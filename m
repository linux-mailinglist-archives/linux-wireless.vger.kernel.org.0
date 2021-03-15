Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8DE33C4C9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhCORtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhCORsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 13:48:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1AC061765
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 10:46:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso15192017pjb.4
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=U40mYr8ah8+CSLM6VDYRvcQoYQqEC1drsw9qoDV3nhE=;
        b=ohIQaAv924eazjAr8zPL69BXR4StPgUgSClyVjNsjyST5wR4APzgN/B8YykOePV0B8
         y7bcCSH/ZPYWCwdrNAN5kB5jQHRxuWcaIdnHnp6geyRF56oNrwYZNK06z7SdCPDtD/kf
         nRo/j9LT77/GeyAGU7GDgtnhbtQF/U2/tGZauAdSKH6Glyg0A/T22VAgpxbExgTp4YuD
         eAd/K50b4k8UVe8MVWVvvEgpIt7xC1qBHsxX1Y+eupcDv04qfGUpdjrzPyDIDBLuJmZg
         ttKExVi7Z5XbWPaUmbEGHMQYkzAF70y/h5uTkm3fx+0OzTaDmzr6r+6gN/FVH7ehJ/Yk
         BnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=U40mYr8ah8+CSLM6VDYRvcQoYQqEC1drsw9qoDV3nhE=;
        b=abtQVJSNsC0UJcCmbFeW8UlMoX+lTYZHOwLv0hY6YqFpgNkFp3Z6xFIl9IuEwCGQqn
         9SR4O14xkJ3OOczzcxeUpjH2ph4Ioqrvuf60DwmMtkv1n192e8P/rhFDpzALjV9PmiIw
         qMdpogOFZgb0biZ6UOStWKSdPSdrvYalG0un6d50C+3kl8D2HVjECGQXPdZeEpuOvNw1
         Kv7kY2ifkACJF14nxwoa/c7hdX9fn+GtglfENUJegJfolUmOxtEgiQOlbKtt8p34ZzUS
         tL4bVgDeubTTffxPgO9uve6WUCxGTs9qfXb6TGrhoOD5iT0p+BsdUIMSyBtQ3lrYO024
         oKiA==
X-Gm-Message-State: AOAM530w5YoY4C5GPGmZgYnJ2Mhkd+r93ihyOeRE022wJD6YHKUO3+9r
        wcpmYI8sbu/S+c1JbV/MO5iaKialZyc=
X-Google-Smtp-Source: ABdhPJwDyElcDwKFl3TG9oKP/hy7rrkw60vy+AxS1nog/aLXlOQ8no32jkmpP/JUbE6TkZnBf0qF3g==
X-Received: by 2002:a17:90a:d3d1:: with SMTP id d17mr223859pjw.21.1615830417853;
        Mon, 15 Mar 2021 10:46:57 -0700 (PDT)
Received: from jprestwo-xps ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id x7sm14522693pfp.23.2021.03.15.10.46.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:46:57 -0700 (PDT)
Message-ID: <0378ea17e0a8bdb72d635430ff14edc428591690.camel@gmail.com>
Subject: Re: SAE offload on brcmfmac (BCM4345)
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 15 Mar 2021 10:46:56 -0700
In-Reply-To: <1262e6e9c7d2ab499c15a3d297ed87206e49711b.camel@gmail.com>
References: <1262e6e9c7d2ab499c15a3d297ed87206e49711b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maybe a simpler question: What brcmfmac cards *do* support SAE offload?
So far I have tried:

BCM4345 (raspberry pi 3 B+)
BCM43602
BCM43242

The last two are quite old (fw dated 2013/2015) so I wouldn't expect
those to work. According to the documentation the BCM4345 should
support SAE offload, but me and several others have tried checking the
extended features and it is not enabled.

Thanks,
James

On Thu, 2021-03-04 at 11:29 -0800, James Prestwood wrote:
> Hi,
> 
> I am trying to get SAE offload support on a BCM4345 (raspberry pi
> B+).
> From what I can tell it appears the Cypress firmware is not enabling
> the right bits. It looks like the brcmfmac driver has all the code to
> enable the extended feature. Here is what I have done so far:
> 
> Cloned raspi linux kernel v5.4
> 
> Downloaded latest Cypress firmware:
> https://community.cypress.com/t5/Resource-Library/Cypress-Linux-WiFi-Driver-Release-FMAC-2020-09-25/ta-p/251089
> 
> Applied the patches from above. Note not *all* the patches applied
> (could be due to already upstreamed), but most did. I did have to fix
> an include issue so brcmfmac/cfg80211.c could reference
> LINUX_CODE_VERSION/LINUX_VERSION.
> 
> Built new kernel/installed etc.
> 
> After that everything built, and I do see SAE offload source code
> which
> sets the ext feature if BRCMF_FEAT_SAE is enabled.
> 
> I see my new kernel here:
> 
> Linux raspberrypi 5.4.83-v7+ #2 SMP Thu Mar 4 10:54:16 PST 2021
> armv7l
> GNU/Linux
> 
> and dmesg shows the new firmware loading:
> 
> [    7.315275] brcmfmac: F1 signature read @0x18000000=0x15264345
> [    7.337608] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    7.338104] usbcore: registered new interface driver brcmfmac
> [    7.606184] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    7.616186] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Mar 23 2020 02:19:54 version 7.45.206 (r725000 CY) FWID 01-
> 88ee44ea
> 
> Yet iw does not have SAE_OFFLOAD set as an extended feature:
> 
> Supported extended features:
> 	* [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in
> station mode
> 	* [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in
> station mode
> 	* [ DFS_OFFLOAD ]: DFS offload
> 
> Thanks,
> James
> 

