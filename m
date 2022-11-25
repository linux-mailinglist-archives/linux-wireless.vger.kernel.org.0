Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCE637FCA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKXTtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXTtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:49:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964008E087
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:49:05 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn5so3020952ljb.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pY/KFzMUcQbo1JbHAXXsU40/SwdsfgesWpL2pxzvHzc=;
        b=AHm8n434vhV2QbZi4VjThL4G/JvwcmnHqllsx4OZRaY4kS+PrxnF96bzftgmfvgC/+
         RCqXeZ64Aup8XJfVj4NcptKUgXJgit4U+5TLJIwexyIGrfPbTVUrHdSk03XPlMGJCc1Q
         wFBE4eOXfSfp+GLzcaOqRDZdgwR/fPiPlfWoEyqZtb2a5JPWDJGwn2ec6iOs5wfd9YLQ
         cD9Eq2nMXBa9tOAoAuPsGFqLByFsye0BJEjd8NinUw/YabOeUntH6A0MpDNV14GVtGXs
         GN3QeGosRmcIhJRC/09Z/H4jVR2Z7BurlDAn32e6bSxBa1kB34vhdCgcbR0aybqvVicK
         zXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pY/KFzMUcQbo1JbHAXXsU40/SwdsfgesWpL2pxzvHzc=;
        b=U4R3w5C4OLAuzzcjCBs/K9qEADTCg6cehKl21pogCzwQiviYK5WSFUtDX6IgVqojAm
         gmhsvigcBL+M6JLvu/RFha/fIrLOAt4YOmNOHIgx3Srohly5pxmk+oHW+1yJ43tQ1anY
         PgLpA0ysDVcWz8WeFdNL/xPC+mSqwvyrphIqblKGjOOERKUXvDdE+hMMTam9sNTZrY7b
         Xe/ClGa9xIjcsN6nCVqbOpXu+IH/4ha5ZgG6jn8cfd0HgijY3vHyPP3SzoUWnEb1Lfzx
         nZ9TWtoZ8GyYA9RE3B4+LYl2lco9ao0Od5h83MumoyZQjS7l2aJPIL43L85kQGpB+NHU
         Xdjg==
X-Gm-Message-State: ANoB5pkExFKx0pgXv+EHB8lApa0ZRnIav0bnp4X9zovjkUPBjPrJPeCU
        o/Tm9bkrVLjyT3K24B40Sg0Ay3+f6joJsHXk5OZRitv/hHCzQw==
X-Google-Smtp-Source: AA0mqf5lPRkxnBR4/d+PKfafJwRa2kFohRPcirBWO/lVHOBlA89Ke6yGcQw0i3dFXniwBgvscrEphGbcaFHEU9DFGHg=
X-Received: by 2002:a2e:a9a0:0:b0:278:f1a5:a365 with SMTP id
 x32-20020a2ea9a0000000b00278f1a5a365mr10430689ljq.29.1669319343980; Thu, 24
 Nov 2022 11:49:03 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:47:53 +0200
Message-ID: <CADUzMVbQ_g6WnrNAp2sCdnkhtgv+5KdjHx3d7=bZfGU3TBqh9A@mail.gmail.com>
Subject: PRO/Wireless 2100 3B Intel problem
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

This miniPCI card just refused to work:
[   67.118806] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   67.119301] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   67.161946] lib80211: common routines for IEEE802.11 drivers
[   67.161954] lib80211_crypt: registered algorithm 'NULL'
[   67.243955] libipw: 802.11 data/management/control stack, git-1.1.13
[   67.243966] libipw: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
[   67.410310] ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, git-1.2.2
[   67.410318] ipw2100: Copyright(c) 2003-2006 Intel Corporation
[   67.411296] ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
[   67.627970] ipw2100: eth%d: Failed to start the card.
[   69.555719] ipw2100: eth%d: Failed to start the card.
[   69.556126] ipw2100: probe of 0000:05:06.0 failed with error -5

Here it is:
05:06.0 Network controller [0280]: Intel Corporation PRO/Wireless LAN
2100 3B Mini PCI Adapter [8086:1043] (rev 04)
    Subsystem: Intel Corporation MIM2000/Centrino [8086:2527]
    Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 20
    NUMA node: 0
    Region 0: Memory at fdbff000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
    Kernel modules: ipw2100
00: 86 80 43 10 02 00 90 02 04 00 80 02 00 20 00 00
10: 00 f0 bf fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 27 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 22
40: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00
e0: 00 20 00 14 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
