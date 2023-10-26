Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE907D8887
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJZSq0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJZSqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 14:46:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8210A
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 11:46:22 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-66d093265dfso8359316d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698345981; x=1698950781; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGQlzUwLsxguat3zUutPfAYHF8ElHbCKvg5hvYb9r7o=;
        b=HjISPgYaVdz4kAEVrtfv0jSpXNB/JkgDQwDXfkSnjE0yC4RQprqwi+ia8wNuOvseLW
         Tuv5EBUfW4Ytjz7aYegMtkVyX8BJ+DYSueFqQfEkirQoSJ3aw2GfSVPBESeguBgmBU/o
         7C+YXKb72412nGWYsAWrgIuGj843DrrzmK+QEWWsZe2ehB3v9rEOUUxHptBS++ZiXN04
         YfJUQGBPmk0Antp0myQxQUc92kS9rbg6fA24ycfDbkh8FyArM+f9q+qz9JVQ7rlcK2pZ
         VaFf/Uq6Uqnh2OtFJbICINgDT4u8IC2wq9mnS4pH947QBirBupNek5x6+TbaMc/sGKZ/
         pOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345981; x=1698950781;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGQlzUwLsxguat3zUutPfAYHF8ElHbCKvg5hvYb9r7o=;
        b=G9QRtD/PCLe+Wyp55EEAuXu6fLXlBMGFhNvWAj0zZ486Xa0Y+EA1MsC/w45Xho+/P+
         Nx3g2RxQFIMtfXHvIln6s7Du9x10HEQH4tbda0klOi4zXgzNA1YCz/DoNJo3N4qy5XeS
         WSQHITSM+cQzNJ+jL8nJccLck356ZTI83Ms4Y+HHZ6YBqRWJ5aLbT0WU/W19HIb/jjwO
         4pRXfTmzcsKNtx2E7gP8TcYEoYpdR/xvQtdZOPTxg/nJhSDhncLxVR+6RBss2o9IAhis
         69WK+zG2JzK9SvuTWEfRzG773mw3qf7RjQNl08XiB5sKLwTLWa3wqoygLBO40yEAuS5w
         5xxA==
X-Gm-Message-State: AOJu0Yy3HkEldPGnqFHlcM7jic9sxFpojWYehO4i0qJU8zRlUEJTMoGD
        vNhOCt6Qz2le+cElBve9F05A7DkaiilRtP8J2LU=
X-Google-Smtp-Source: AGHT+IGW6AT6tXzqQCKvSlC37sePeMfdM1jNPFi7jmr4vhMeZR4ttWzHP59+yx9fmtcB7/vlgpZhUtAxizE7k7lc2eE=
X-Received: by 2002:a05:6214:768:b0:66d:3e3e:5bae with SMTP id
 f8-20020a056214076800b0066d3e3e5baemr652939qvz.30.1698345981547; Thu, 26 Oct
 2023 11:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:c245:0:b0:51c:206f:72d5 with HTTP; Thu, 26 Oct 2023
 11:46:21 -0700 (PDT)
Reply-To: krystalhowley1@gmail.com
From:   krystal howley <blandineblandine619@gmail.com>
Date:   Thu, 26 Oct 2023 18:46:21 +0000
Message-ID: <CAOUsorgLOzDOTvE430OBh3Wbm4pOVYs1XtqVduNjp0=3ZRcZLA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Buen d=C3=ADa,

Espero que este correo te encuentre bien; Por favor, le escribo para
informarle si recibi=C3=B3 mi mensaje anterior que le envi=C3=A9 hace algun=
as
semanas.
Krystal Hawley de Estados Unidos de Am=C3=A9rica

Espero tu respuesta.

El m=C3=A1s c=C3=A1lido saludo,
Krystal Hawley.
