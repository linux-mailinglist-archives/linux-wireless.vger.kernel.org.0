Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1B65A022
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiLaBAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Dec 2022 20:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiLaBAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Dec 2022 20:00:19 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF541C913
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 17:00:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v23so13418788ljj.9
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91osJ7/ZYKHOYqA/7nAx16Uv0IEXhd+tnUgTAcY49F0=;
        b=HYWjQw2icIBxd2I5T+r7/GWND9m3HWSCd/2AuVWT57CVNRH8SYrCaEo9KKLbKu236H
         6kaSR0UyTUp66npePavMrc6PjM3OPx6PNMjzh6Y3q/8FpDsiCizQIBWVbCd0kZZLtMwY
         np7jPODVFiugaCC3FgU7By9ht9EE/CWoZcPAvoi1KF2aZ2hF0lfuua+FDxeFUS0m30O5
         4rem5v+DYvNiU039TPkJTHtoPvb+LfF3dd6m/lIwpNVrif+1gZUu2KVI/d2ZCubKocoQ
         k9l7dJL+11t8dDQbpZ8QnQR0GE2WtcITIqZ+O//f+Of1FWB2qw9GYXvR97QSwWkKQAjI
         8jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91osJ7/ZYKHOYqA/7nAx16Uv0IEXhd+tnUgTAcY49F0=;
        b=Y7iO/cAsnhi4fy6cWSOiguN15q10ra3nwjjnnzTn/i8d3c1TA2EoQkMtf9dG+eW462
         ZqTOtsGXaG/M/WF/EcUL3RorTWNDmdJXBEf2cEcFmRXQQ1/PTw4mxJ6Or6UcYv1GrUVD
         iN5JeKckE1hrJleaMzBowYVTYooPXUHDaWd2smUNkKuEmH7MYEv+QbSK7yLLPnORn53n
         lbPIiGEY/qJRGYtelNJVupglRZ72p4Geu3hmroLwnR9JZl0Hj8RkMaHmuvRUxs01iZSY
         4W9tGBmKx1/O0Af7r+aJKWEjEioxnH/ZmhS8hRnGzVCb3TdgGZXr2VvzvhisIUGTKYFm
         vMYA==
X-Gm-Message-State: AFqh2kqv+bIDnyZSWCY5YJus2BrFOGru7FNaG1E3TSPQSr0RruzmV76N
        wev1FdGsg1fEww0TnoPzY0N2ELDUfQaNVSBc1vU=
X-Google-Smtp-Source: AMrXdXvhH1yUFQB5+RfUdnGTmjksUKzjn90EEMIb+2tjgt6kogBDR9bEOW/5dDS78OLDy3Ob105OAzghqI6LzKFaSFg=
X-Received: by 2002:a2e:7a0d:0:b0:27f:d911:acf9 with SMTP id
 v13-20020a2e7a0d000000b0027fd911acf9mr301650ljc.23.1672448416777; Fri, 30 Dec
 2022 17:00:16 -0800 (PST)
MIME-Version: 1.0
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 31 Dec 2022 01:00:04 +0000
Message-ID: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
Subject: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, regressions@lists.linux.dev,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Folks,

I'm seeing a regression in the brcmfmac driver which appeared in the
6.1 dev cycle, I didn't pick it up until around rc8 but with deadlines
and travel I've not had a chance to bisect it but wanted to report it
to make people aware. I've seen in on a number of devices with
brcmfmac wifi over SDIO including at least the Raspberry Pi (zero2w,
rpi4, rpi400, rpi3B+) and other devices like  the Rock960, Pinebook
Pro etc.

A quick look at brcmfmac shows arounf 26 changes for 6.1 and it seems
like it's an issue around firmware loading where it looks for a device
specific firmware but doesn't fall back to loading the more generic
one, or tries to load one ending in .txt, but then doesn't load the
NVRAM.

Anyway I wanted to report it as atm I haven't had  time to actually
debug/bisect it more.

a dmesg snippet for the RPi3B+ is:
[   24.541576] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[   24.551460] usbcore: registered new interface driver brcmfmac
[   24.559669] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus-Raspberry Pi 3
Model B Plus Rev 1.3.bin failed with error -2
[   24.693853] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.txt failed with error -2
[   25.717596] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000):
clkctl 0x50

Regards,
Peter
