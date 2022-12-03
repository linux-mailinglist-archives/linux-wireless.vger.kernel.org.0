Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2455B641824
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 18:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLCRgj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 12:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLCRgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 12:36:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692321EC44
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 09:36:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f21so11295838lfm.9
        for <linux-wireless@vger.kernel.org>; Sat, 03 Dec 2022 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/ctzesBDdhC+Y3n4ElDRulMMltmusXqIbDihrEfQDM=;
        b=OHEnnX0jGp1638H8u/uZ4bJNDPcFOPpcFpgi9tHunQXqIcHfPKsunadfrRXgNy1bQx
         tcPJcmRNAfbIoNlPJDsWRQoM2yal6JT1Ueuxl0p6Yb0rXkZqvEtg9Mx0pD5wH5dv10ia
         uST3PM08GV8MchAP5QsTvQ9xWnyDP2FD6SbeIIWNjJOy647+st3/5+4YyoEXWqAqoGYF
         z2OTM4x4GAqulvap35qdWrkRWjD6RhuC3oFQDJ0h40irrmnp1QhtuuTpUTEe1ISprqc3
         gP50ZBi8Qg4uigx8MKz/eJD7FXShSV+ziGYp6dS8rfgrLpFbEKw0i+I3/RW6GbH8UNJR
         C2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/ctzesBDdhC+Y3n4ElDRulMMltmusXqIbDihrEfQDM=;
        b=StVkXQ3f3XrKy//NaMpfpDKv07FNI6Jn+iKiN+bVnLNvlfa3bZmEOjHHczxBUsD/6f
         C+vF8fzjs2kcHZ2P52RVo8st9gSL5iYdGUHa9oDcMMVpbDVbVw8WHi1pvO+APoXp9gRf
         2HST2sH1CS4ngl3LHcJ0FomdtsNpKimD1aQ4i5vAyyjk7ISjKCKN1Mcdy7kxEqK7u+AA
         Z9ITYnYs+4ztVr0w/LLTajTrLUiX/Kz00Vf/Xj0O2qWY2bmIcYeYJXoYuG6RkJYYY0q3
         ZFvSTUzmiN9FYmkS0WgXsliiMXwMl6I9tM/Ml/6/J+4Lz3841tLrfbUsSZUgh5N0q1o2
         n1RQ==
X-Gm-Message-State: ANoB5pnwRCvyzidBlZQQ5ZxvaQcsQr1ql8eJ7LEds4mFI/pAkDeg4dr8
        kjv1i6X2nsOVJnC/aGo/Xc1R8Bgebf1aEvbOBx0=
X-Google-Smtp-Source: AA0mqf7V2EiYLQhuJdG5Kw6yb99BKQmFThgOfAm3yATQDN2bBOnJUNdUqnMZ2BN6nAuJzHt8e0BfpA3oc04rSzUjHZk=
X-Received: by 2002:a05:6512:4cd:b0:4a2:c2cf:a297 with SMTP id
 w13-20020a05651204cd00b004a2c2cfa297mr23780329lfq.286.1670088993299; Sat, 03
 Dec 2022 09:36:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:5653:b0:33:7b6f:7092 with HTTP; Sat, 3 Dec 2022
 09:36:32 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <incceisabit@gmail.com>
Date:   Sat, 3 Dec 2022 17:36:32 +0000
Message-ID: <CAJu2LG8XQ07qu_bRvm1CgyEsMAXh6N-zgORqsoXzF_mfD57VdA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ahoj,

Toto je moja druh=C3=A1 spr=C3=A1va pre v=C3=A1s t=C3=BDkaj=C3=BAca sa fina=
n=C4=8Dn=C3=BDch prostriedkov
v=C3=A1=C5=A1ho zosnul=C3=A9ho pr=C3=ADbuzn=C3=A9ho. Podrobnosti v=C3=A1m p=
o=C5=A1lem po prijat=C3=AD va=C5=A1ej
odpovede.
