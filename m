Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E75AEFD1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiIFQC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIFQCK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 12:02:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DC82D0D
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 08:22:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cu2so24216128ejb.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Sep 2022 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=lE67JprNCX7SN3lPprUe6JMb6lN2qR3wx5EWOsmBhTxm9aub8LdgqUGxPSenL0W31P
         Fe9oJK/lPXlccC1QN7Wjy2GgzHjJbe2wvFW8QMvbVOhcKoWftZyFTmmmsU0Utr5W3JNc
         475H2pVPQvqCgnrlyfVqYphqYiNbalvucoAm/o+7Z8Trngt2TN78wQkDJMGNuktelNom
         9TKeW8dxB4zlkaqv/6Dsw3oZeFxUhcaZii15pGo7rN4p8n+o/sQG+VWRnOJ7AJJhkVSQ
         IILXoQpWcaH/ZGY1zEOORGXgOFrSChth1vqhHRqpVghN/M3pHIQ+4vZ7XwShovcUrEYT
         b+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=vEilCl+k66yz1/ThY9KOyB0cITLyW95XT6cDBnw047UfCtS6/+VtFIkcVzFFtqnI2z
         ivZPGBAirCxdVKLztsBr9+WZJxmtkKb0dyDTzms+IkMN0qk5ISjfTUcgQbsrXam1OkL6
         kvq8J+T2Yq6hPDjLclWZmkwifrhXlFPMxEES0jA2m0gRWfDq0xulxftR7vgRRbCOC5oy
         L4wU9EUhWKqxEuaiv+W9zI/V1fayYPE2F/sp3mdwyVOj8tYWRhi2kAU/l5JOteegm4IG
         sR81y1BAME+j0imHnvFOOAgnDOnsK0SRY9VoENnJByOmF/rbParQ1b3M7rsuRq6gkvDH
         BJpQ==
X-Gm-Message-State: ACgBeo2LciG/Jf3mxz4ut6ODLOtDsg6CEyeFMPzoK54YTPbY2fG+4fYR
        4IxwvWoHjWNcdBbaLvjmlQbsGUY/eE0IGVuNSH0=
X-Google-Smtp-Source: AA6agR5cbTRDey2qc0f7fs1dZ3sw3Xk1BHPqMzgzsKxWP+04LKYTywUrwMCBRz3cE6Fff0isoW43fByQeGd/w/secP8=
X-Received: by 2002:a17:906:4fd2:b0:742:133b:3522 with SMTP id
 i18-20020a1709064fd200b00742133b3522mr26720399ejw.21.1662477746354; Tue, 06
 Sep 2022 08:22:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: 553450897dy@gmail.com
Received: by 2002:a17:906:7b81:b0:73a:a972:8f77 with HTTP; Tue, 6 Sep 2022
 08:22:25 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Tue, 6 Sep 2022 15:22:25 +0000
X-Google-Sender-Auth: zuu-j7pUPvFECT-xOq8xyfehoQA
Message-ID: <CAMSAxkXFWxMT822MLDDwGno5G=8rkubfdvrAet2vnDf4trga4g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
