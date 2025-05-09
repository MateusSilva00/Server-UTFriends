-- AlterTable
ALTER TABLE "conta" ALTER COLUMN "email_verificado" SET DEFAULT true;

-- AlterTable
ALTER TABLE "perfil" ALTER COLUMN "biografia" SET DEFAULT 'Bem vindo ao meu perfil!',
ALTER COLUMN "seguidores" SET DATA TYPE JSONB,
ALTER COLUMN "seguindo" SET DATA TYPE JSONB;

-- CreateTable
CREATE TABLE "cargos" (
    "cargo_id" INTEGER NOT NULL,
    "perfil_id" INTEGER,
    "comunidade_id" INTEGER,
    "nm_cargo" VARCHAR(40),
    "att_01" BOOLEAN,
    "att_02" BOOLEAN,
    "att_03" BOOLEAN,
    "att_04" BOOLEAN,
    "att_05" BOOLEAN,

    CONSTRAINT "cargos_pkey" PRIMARY KEY ("cargo_id")
);

-- CreateTable
CREATE TABLE "comunidade" (
    "comunidade_id" INTEGER NOT NULL,
    "nm_comunidade" VARCHAR(100) NOT NULL,
    "biografia" VARCHAR(256),
    "seguidores" JSONB DEFAULT '{"seguidores": []}',
    "data_criacao" DATE,

    CONSTRAINT "comunidade_pkey" PRIMARY KEY ("comunidade_id")
);

-- CreateTable
CREATE TABLE "pensamentos" (
    "pensamento_id" INTEGER NOT NULL,
    "user_id" INTEGER,
    "ds_pensamento" VARCHAR(256) NOT NULL,
    "reposts" INTEGER DEFAULT 0,
    "curtidas" JSONB DEFAULT '{"curtidas": []}',
    "comentarios" JSONB DEFAULT '{"comentarios": []}',
    "tipo_pensamento" INTEGER DEFAULT 1,
    "data_pensamento" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pensamentos_pkey" PRIMARY KEY ("pensamento_id")
);

-- CreateTable
CREATE TABLE "perfil_comunidade" (
    "comunidade_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "pk_perfil_comunidade" PRIMARY KEY ("comunidade_id","user_id")
);

-- CreateTable
CREATE TABLE "publicacao" (
    "publicacao_id" INTEGER NOT NULL,
    "comunidade_id" INTEGER,
    "ds_publicacao" TEXT NOT NULL,
    "reposts" INTEGER DEFAULT 0,
    "curtidas" JSONB DEFAULT '{"curtidas": []}',
    "comentarios" JSONB DEFAULT '{"comentarios": []}',

    CONSTRAINT "publicacao_pkey" PRIMARY KEY ("publicacao_id")
);

-- CreateIndex
CREATE INDEX "pensamentos_user_idx" ON "pensamentos"("user_id");

-- CreateIndex
CREATE INDEX "publicacao_user_idx" ON "publicacao"("comunidade_id");

-- CreateIndex
CREATE INDEX "email_idx" ON "conta"("email");

-- CreateIndex
CREATE INDEX "nm_curso_idx" ON "curso"("nm_curso");

-- CreateIndex
CREATE INDEX "nickname_idx" ON "perfil"("nickname");

-- AddForeignKey
ALTER TABLE "cargos" ADD CONSTRAINT "fk_perfil_comunidade" FOREIGN KEY ("perfil_id", "comunidade_id") REFERENCES "perfil_comunidade"("comunidade_id", "user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pensamentos" ADD CONSTRAINT "user_id" FOREIGN KEY ("user_id") REFERENCES "perfil"("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "perfil_comunidade" ADD CONSTRAINT "fk_comunidade_id" FOREIGN KEY ("comunidade_id") REFERENCES "comunidade"("comunidade_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "perfil_comunidade" ADD CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "perfil"("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "publicacao" ADD CONSTRAINT "fk_comunidade_id" FOREIGN KEY ("comunidade_id") REFERENCES "comunidade"("comunidade_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
