Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFABE32DA67
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCDTa7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 14:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCDTae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 14:30:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB5C061574
        for <linux-wireless@vger.kernel.org>; Thu,  4 Mar 2021 11:29:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id x29so11311967pgk.6
        for <linux-wireless@vger.kernel.org>; Thu, 04 Mar 2021 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=APIpr7XVs/HBr/adFXHx3C07/FjpOG07fNJORZo5/h0=;
        b=VQ5SAtdqBI6iHaRbe2a5LReDMcAZHQdF7idyV3K4HnSvDIJjrAM5jrUREydmeSItRV
         HXwBRj4HYwVqPki17zGYy9hUAQ/pKC57BqFhePOKYySDuUJERgYy1RjNWgE6tHu5Crln
         WYEyIiF+B7PHI9pqwwEm/riL2DkK9iUrXBojZTku1uk03z1TB0boWDUpt/4MCg0nqxSf
         XN5uwN0PpuP8QWRk4GU2BE9IAsarTdONqhexk+9CjaGWavDs9HgOHli5hOi1HExSmfB5
         MlTmN7zFq4OfdU+C7RpoEWd6M5HWbJAb0sNtQupP59aDuP2BCyWfCzR4I2KFKlRwIiQD
         nIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=APIpr7XVs/HBr/adFXHx3C07/FjpOG07fNJORZo5/h0=;
        b=UlAcmdIlIr3mklGN+9wMBic3xXDTkayHDobVOdQ8LshmZFpWnhXrA0fJjrqMEGWcgD
         J3Sc6lbljwXOFQqQaTJM5pbuymv670VVcJvPrDlLAJ1aFRwI/INFpROUdVCVpTWQWqcW
         chmrJuQQAUtxly5oB8Kn8sWyfrNLwyneKJFbF5s+/v0BexiDZ5EUOsRzKZBBQjhB/OTS
         sldTOiwrRWR0qyd/K7ZswRMECyiSHz6oFOGauF4sjHaUlPJodBm6ZTJAdlEKK8hhz5rD
         8WbVuyi1rZaYNxAsM8X4i1dPdMzWy721NPnK+y4QFKgDK9FukErL05AkwWFP2v67EooQ
         Qfww==
X-Gm-Message-State: AOAM5321pzrQa6I6/88N1bv0waGZ/wvsLeTQiHk2UMTkJ/cQ+6NsCrm1
        Yovc6Edsa+bM/ukHnVKpyjZNG76yjk0=
X-Google-Smtp-Source: ABdhPJwhXbILuXQ3Nf6ITiBtT4Q6r8H++QozXD3e69p5XVr2CB4Rj8466iKO2yArysP1i9gMCuunWQ==
X-Received: by 2002:a63:db10:: with SMTP id e16mr4999986pgg.234.1614886193526;
        Thu, 04 Mar 2021 11:29:53 -0800 (PST)
Received: from localhost.localdomain ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id r184sm182229pfc.107.2021.03.04.11.29.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:29:53 -0800 (PST)
Message-ID: <1262e6e9c7d2ab499c15a3d297ed87206e49711b.camel@gmail.com>
Subject: SAE offload on brcmfmac (BCM4345)
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 04 Mar 2021 11:29:52 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am trying to get SAE offload support on a BCM4345 (raspberry pi B+).
From what I can tell it appears the Cypress firmware is not enabling
the right bits. It looks like the brcmfmac driver has all the code to
enable the extended feature. Here is what I have done so far:

Cloned raspi linux kernel v5.4

Downloaded latest Cypress firmware:
https://community.cypress.com/t5/Resource-Library/Cypress-Linux-WiFi-Driver-Release-FMAC-2020-09-25/ta-p/251089

Applied the patches from above. Note not *all* the patches applied
(could be due to already upstreamed), but most did. I did have to fix
an include issue so brcmfmac/cfg80211.c could reference
LINUX_CODE_VERSION/LINUX_VERSION.

Built new kernel/installed etc.

After that everything built, and I do see SAE offload source code which
sets the ext feature if BRCMF_FEAT_SAE is enabled.

I see my new kernel here:

Linux raspberrypi 5.4.83-v7+ #2 SMP Thu Mar 4 10:54:16 PST 2021 armv7l
GNU/Linux

and dmesg shows the new firmware loading:

[    7.315275] brcmfmac: F1 signature read @0x18000000=0x15264345
[    7.337608] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    7.338104] usbcore: registered new interface driver brcmfmac
[    7.606184] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    7.616186] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Mar 23 2020 02:19:54 version 7.45.206 (r725000 CY) FWID 01-
88ee44ea

Yet iw does not have SAE_OFFLOAD set as an extended feature:

Supported extended features:
	* [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in
station mode
	* [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in
station mode
	* [ DFS_OFFLOAD ]: DFS offload

Thanks,
James

