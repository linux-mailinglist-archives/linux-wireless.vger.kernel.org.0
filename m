Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C727B6D6FCB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjDDWAZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjDDWAX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 18:00:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F7359D
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 15:00:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so37602054pjp.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680645622;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrQ0Xa0ospuogFf0FekggZcYN62tCBsmjNRR+g2LJ8s=;
        b=VwojCbgVfAZw8Z093U5teQvKn5//EMe2833Z2MLe+BCw6TBv4pc9hN/rIp4z9mmIRU
         QnWBsUEkQ1zuVCBVZYXRFqOchhL+7pU5HVYOjVPvMxACbQ/zZyK7ORKKZtDcjr07XLbw
         klvvplwwSomt1R6ux6KEiS7zu0CARkCCnMZcNbxEh1lxJsyYVro4Fu1q8nDymJWalNqR
         Z/yfqzgSr8uYdc6QzO6s41Nestlc84g4tSSKjGHiVHaV7QXqQ4ZlA7azviUXb/amRMUb
         XQ+7q5MgTxjUv2a/EG5pt+TzdERPr1HVgMr+f+WnCFrL3UCxgvEnNIdK6oK5UI3h5Jpr
         yuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680645622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrQ0Xa0ospuogFf0FekggZcYN62tCBsmjNRR+g2LJ8s=;
        b=GTDzxVW5wpegGvNeXf+DQ0tkCz1xIIrbWS/LPFjJZX0vsl8a3/wVnAZJDKkilwq+DW
         C5b5xtql40XrhfwIV3JD6SOJ0XpD608XIOI9qIFhdQQ1H9UEI97M7kQQt23Lqd8j9jeo
         Rsplvh4v6jCnnyYYIL7XojGTUejYUAUFc/xEma55RnAwRnVvQM7XJiK6802M8c4Xnp1q
         I3NdgVfITsniXmpYGvJ5ZplOEbAy/Huh3e0p8Gni9nZiRayA6bBgU038ekaf6IKhtAc/
         4Xmb2hSOFy9+Mw/8Lu3Fyb6AN5b3MHDaeRzGBR/vx2bwjFXErpubi0Ikv1+T1TzTY773
         Yjiw==
X-Gm-Message-State: AAQBX9cTj2zWhBkIGVBCMuE8SAQ+ESonJ2UZjfudYqiSLvaMckm3M8DZ
        IRnfMPhzRzeX3urJioDRzA1TAvdgQ0P05KZmxYY=
X-Google-Smtp-Source: AKy350bAyEj032g6PcBvNZf1pUsKTFeox8/fZcJvGL+5iRSZ7Uy4kQr3Bjd8ATDENE3Bs2WnGorJeWzB7PTUuSiUEEk=
X-Received: by 2002:a17:90a:6c65:b0:23f:a26e:daa3 with SMTP id
 x92-20020a17090a6c6500b0023fa26edaa3mr1440587pjj.9.1680645622022; Tue, 04 Apr
 2023 15:00:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:c943:b0:197:90f1:8269 with HTTP; Tue, 4 Apr 2023
 15:00:21 -0700 (PDT)
From:   Bright Gawayn <g3511172@gmail.com>
Date:   Wed, 5 Apr 2023 03:30:21 +0530
Message-ID: <CAErukXnPGfSguvqc4D_u_DDeNZCEzf0dPgrr_+x6T9i7zmv23w@mail.gmail.com>
Subject: Business proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=ADVANCE_FEE_3_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [g3511172[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [g3511172[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 


--
Good Day My Dear, Happy New Year.
 My name is Mr Bright Gawayn,
it's my pleasure to contact you today in
regards to a very lucrative business proposition.

we use a certain raw material in our pharmaceutical firm  for the
manufacture of animal vaccines and many more.

My intention is to give you the contact information of the local
manufacturer of this raw material in India and every details regarding
how to supply the material to my company if you're interested, my
company can pay in advance for this material.

Due to some reasons, which I will explain in my next email, I cannot
procure this material and supply it to my company myself due to the
fact that I am a staff in the company.

Please get back to me as soon as possible for full detail if you are interested.

Thanks, and regards
Bright.
