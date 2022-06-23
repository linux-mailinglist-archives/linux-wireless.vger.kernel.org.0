Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCE557281
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiFWFMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 01:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWFMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 01:12:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685738DB2;
        Wed, 22 Jun 2022 22:08:26 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3177f4ce3e2so159537397b3.5;
        Wed, 22 Jun 2022 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KFYc2tDDZqXCL0SmmnI4Mn6DVjcGYX42TW6sDOVI8A8=;
        b=Zvt2UAWJgToWveyx3vT8KnAc/j2vA1n8szAEn338MiQZbdq9wWljGQoVOfrk7b5QqV
         FhAvZ4rK1o3ZOKMnaTuz+uvS6S/DRTrNcESIKhcrfFpduKY8VjurkP8yoUKvwSuFSq8W
         eSK3iiRZxh7RZP2BsA6kgRFPCcV8OLRSkc2gqZWnTSpWoF6rOEzlt/TjZNtnqR4msJ5X
         hEPBfI3tQbxkUdyo4+/r19Rd/8NEW6Ov/6QCcmfHp26EJYTcaOMSb7A4elZBQkTiT9+D
         SCXV+SaXkFvdPQznRC4uFrSiDmRsVXf5tx4UQfKw4NaNr4YbqCIfEyoItXIRNh8lEL8c
         6m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KFYc2tDDZqXCL0SmmnI4Mn6DVjcGYX42TW6sDOVI8A8=;
        b=HpVF7p9jNe9khrCOrE064W1tr52tqf7n4AWFe40fCTcjuHkAay3ZdKtpieKPe3bArc
         T0av1fliVYhYIetF2UuPdxQ1iDllc8seuTujlPfTSbrEAJ0A8ktdAtpN9h46QAOMRv6M
         v5yWE8U0ZEQnrRMpX8HFDnpd33yD3DSFf0uxpt8Y3P4gfRKJBB1D286uskJV/2pzbklY
         KB/uAATM1wkYrs0E4a0eUP93ap3y+qbcQkRj2Zy7ckd268CKo1pu+gFp2boz4tUNbYo3
         XC2GTyIQg7+6Du4tm+3Qu2Jo6hqiXSWvMGDPNY2ChyG3cTbBXsq5CRFVO04roUbFCuwC
         bwDA==
X-Gm-Message-State: AJIora9Zefc4OzLI36pLXba3o07FWuif39kkIF0uWa1V7XemUsNNX+Qm
        hyw4aGMeVb/HHnuofiaMaXgBDiUYfwxw7Wx6yG4=
X-Google-Smtp-Source: AGRyM1tnTyMJxxHX8irg1vsAdnAx4HRqRtKlssmlqTB/j89jD8fwpq320OPIhN3Jmh9elyZ0DnujDXG6vj1HgbBA8Ck=
X-Received: by 2002:a81:12d6:0:b0:314:6097:b272 with SMTP id
 205-20020a8112d6000000b003146097b272mr8637708yws.159.1655960905672; Wed, 22
 Jun 2022 22:08:25 -0700 (PDT)
MIME-Version: 1.0
From:   Gregory Erwin <gregerwin256@gmail.com>
Date:   Wed, 22 Jun 2022 22:08:15 -0700
Message-ID: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
Subject: ath9k: hwrng blocks for several minutes when phy is un-associated
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     ath9k-devel <ath9k-devel@qca.qualcomm.com>,
        linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I bisected down to commit [fcd09c90c3c5] "ath9k: use hw_random API instead of
directly dumping into random.c'' while investigating a long delay when entering
suspend on kernels v5.18 onward. There are other reports of hangs or
unresponsiveness at https://bugs.archlinux.org/task/75138 with some more info.

AFAIKT, the issue is triggered by the ath9k hwrng when the interface is up,
but not associated with any AP. In this state, 'dd if=/dev/hwrng' will block
for up to 231 seconds before finally returning an input/output error. Similarly,
I get a kernel log message "hwrng: no data available" every 231 seconds.

The hwrng will unblock when attempting to connect to an SSID that doesn't exist,
but not when performing a scan, so I'm guessing AR_PHY_TST_ADC only produces new
data when the phy is transmitting.

Admittedly, I don't actually know if this blocking behavior is
expected or not, but it certainly seems undesirable.
