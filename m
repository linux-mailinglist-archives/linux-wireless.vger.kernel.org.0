Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9797D6939D4
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Feb 2023 21:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBLUb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Feb 2023 15:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBLUb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Feb 2023 15:31:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1DD525
        for <linux-wireless@vger.kernel.org>; Sun, 12 Feb 2023 12:31:27 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id u75so6896417pgc.10
        for <linux-wireless@vger.kernel.org>; Sun, 12 Feb 2023 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676233887;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3iIghNYce+dgV8YXeRndeSBcZ6lqwpwyBMDGmIlOl8=;
        b=L30t+hBToSdYgm2A68w0LW5D4sx1HVFtR6LBj6Qwnx3ZB4UhjPOBgIYczQkL/HDJzD
         S67S6QCGZV6zJS1RTaweqfczYMLYcMpelCOjzKwiHBDMwX6+XyH99qw4wEuXPqw3nj6Y
         9DSY5S/OK5zVw11iHF/eptW/i6yeOhklf3+qvPdq0KiijzlHtkQWrQlekAafB5HFBYao
         Gbn/yrJory15l+Sq226Bb26j0E9rkd4SDDSYToE1xGItPfkHeo+Xs7Hs/KhP7HeFXzfQ
         RUvDrDuC9ALKLrkn8wfvCtL9r45wvCJ94JXmsyXEdZbFZ286s/3EcX3vrMEQbtmsypFl
         eF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676233887;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3iIghNYce+dgV8YXeRndeSBcZ6lqwpwyBMDGmIlOl8=;
        b=Bclw56Ws/Zqp94u560JH5wfxjPGv7a1mOYyNdakdcFlo+JO8dZh34tGIYVf3V2Y6VV
         b7lAUM6clmdAp53cnXWkIUoOK5wQnw3R8w4KPCe8kxHveN6imCXvJvv7kAQEOu9noM2Y
         GzVkbh9Oj374XhsY1U8UxYIJgj/AC+fo3HHrvJdA8wVrB1snj3NkN4Qc7LzhY3MKUjHG
         Ser9PEqQYABVkIW3sTU9CO5hElgXMq73Sc4GiJCKO2P4WFDGZTEFxKFza7UOHq5p7tLe
         ZBElovHU6JVTHB6zMzr/kf61d0966jcv/CSDbllExcmp0F4slJaRZaIrcAfKTfAIUIXe
         j+sA==
X-Gm-Message-State: AO0yUKX5tKftRxb8spHzCEV6PjDOe7nT5Z3c6VgTbCrQIcW3gyNgv16V
        d6TYJ4NIDZ6hhZDvgbr4VvLrJhdBAm5R/PbUD6c=
X-Google-Smtp-Source: AK7set9bVPllWLp8UnM4S+5tUu6Pg1ZgkFVu1EJ2W6J69fsWajXvurEeYZtdx7SG8ompXCAmRDmp8EViOK3A64dEv9Y=
X-Received: by 2002:aa7:962f:0:b0:5a8:b95a:ea18 with SMTP id
 r15-20020aa7962f000000b005a8b95aea18mr196974pfg.25.1676233886967; Sun, 12 Feb
 2023 12:31:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:f584:b0:412:65f8:9966 with HTTP; Sun, 12 Feb 2023
 12:31:26 -0800 (PST)
Reply-To: cfc.ubagroup013@gmail.com
From:   Kristalina Georgieva <unitedbankunitedbank84@gmail.com>
Date:   Sun, 12 Feb 2023 12:31:26 -0800
Message-ID: <CAA9iZpB25W7L6pgDKjUs77z7nGb4uiEC8eomgzJ-mr+TBCf-Hg@mail.gmail.com>
Subject: =?UTF-8?Q?BOAS_NOT=C3=8DCIAS?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:52e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [unitedbankunitedbank84[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cfc.ubagroup013[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [unitedbankunitedbank84[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prezado Benefici=C3=A1rio,
Enviei esta carta h=C3=A1 um m=C3=AAs, mas n=C3=A3o tive not=C3=ADcias suas=
, n=C3=A3o
Tenho certeza que voc=C3=AA recebeu, e =C3=A9 por isso que enviei para voc=
=C3=AA novamente,
Em primeiro lugar, sou a Sra. Kristalina Georgieva, Diretora Administrativa=
 e
Presidente do Fundo Monet=C3=A1rio Internacional.

Na verdade, revisamos todos os obst=C3=A1culos e quest=C3=B5es que envolvem
sua transa=C3=A7=C3=A3o incompleta e sua incapacidade de atender =C3=A0s co=
bran=C3=A7as
taxas de transfer=C3=AAncia cobradas, contra voc=C3=AA, pelas op=C3=A7=C3=
=B5es de
transfer=C3=AAncias anteriores, visite nosso site para confirma=C3=A7=C3=A3=
o 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Somos o Conselho de Administra=C3=A7=C3=A3o, o Banco Mundial e o Fundo Mone=
t=C3=A1rio
Internacional (FMI) de Washington, DC, juntamente com o Departamento de
Tesouro dos Estados Unidos e algumas outras ag=C3=AAncias de investiga=C3=
=A7=C3=A3o
relevante aqui nos Estados Unidos da Am=C3=A9rica. ordenou
nossa Unidade de Remessa de Pagamentos no Exterior, United Bank of
Africa Lome Togo, para lhe emitir um cart=C3=A3o VISA, onde $
1,5 milh=C3=A3o do seu fundo, para um maior saque do seu fundo.

Durante o curso de nossa investiga=C3=A7=C3=A3o, descobrimos com
consterna=C3=A7=C3=A3o que seu pagamento tenha sido atrasado por funcion=C3=
=A1rios corruptos
do Banco que est=C3=A3o tentando desviar seus fundos para suas contas
privado.

E hoje informamos que seu fundo foi creditado em um cart=C3=A3o
VISA pelo UBA Bank e tamb=C3=A9m est=C3=A1 pronto para ser entregue. Agora
entre em contato com o diretor do UBA Bank, seu nome =C3=A9 Sr. Tony
Elumelu, E-mail: (cfc.ubagroup013@gmail.com)
para lhe dizer como receber o seu cart=C3=A3o VISA Multibanco.

Sinceramente,

Sra. Kristalina Georgieva
