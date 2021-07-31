Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A193A3DC439
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jul 2021 09:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhGaHCI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Jul 2021 03:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaHCH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Jul 2021 03:02:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1BBC06175F
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jul 2021 00:02:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b13so3328886wrs.3
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jul 2021 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=JHoZaXWwk7gKrcZ029LzWeTH2lhGhqMg6fgg3UzrOc8=;
        b=L1SMJOkqFQr4DyybYqHKBlULrf1HBrKlaMkrr8BfYPyRmiqelUUCF64FN6BrCk9iib
         BYfaW7cUY+k2dvvteW+qZaxAYJXFPSd3Ry9wPE5cl2wBeTbE5tbuXBtjvuICPuc4gy5G
         Br9850rx6zZrZ+SDqaXp/z/GJ4wIzbtRC8vhNEy8ZmDMhVzi4HFiD7tbfFdAVFGAv6LM
         d4stCabJSl6H8miS6bOkk1vzAP7ZVPycyBsG8nMXCtE6x9qKB8Ws0MpfH7Mei7GnJFbA
         zcN9LTu4vVuWZZ/sFnPfOWXP2eGbv3qaql7GjfKbvkCi2VwF617LmRR7L2RxAEbRd3LH
         DIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JHoZaXWwk7gKrcZ029LzWeTH2lhGhqMg6fgg3UzrOc8=;
        b=aVzGXX0amAVGKa45ONsxTArkqXDsJrkx9UaCguWSGg5+IH0xvWpC9JIKTcfwzZ9Lev
         UGhbOiNIUajduzwk7dUe5xy9VqEfICAIy/RGi4CzJveXI0SOfyu+ByG1TJxL+7PsduD1
         0gsojx8qP5qFTpPjyCwX+1gN8i+LRkaUdnc5y+9ASVrgHW8tisB3w7LDX/B/q2SfUF1j
         E/0/QpqN5EsczjkoRiA7ft954A//LPHhiBYMzZNfS58gJuN2uydPXaM5JAd8dVzwok5e
         ioipAvcbDXCu4wN6IMVwVR4gbm4PHCTVpbL5NKC+xWm9S1h1I6ujYpKnNwZrVe3UZyKz
         gEyw==
X-Gm-Message-State: AOAM530Fe+VdeTN4YPMdGTRbZtGM3CaiHR+YCZ/5EQAfQ+juqLCuPcM+
        M/lWnaVg/Z0dIan5aW62REouB9vbqtl3fr975HBlRMJzXN05kEpk
X-Google-Smtp-Source: ABdhPJyGD3ia8eQJrL0/k8qKEMimXSE4lAJ9i47x6V2VPIRBP4UCS6agVSOEpxbpxnfRLEsO8qmFjjRFYJR39OnEkWw=
X-Received: by 2002:adf:fbce:: with SMTP id d14mr6929673wrs.236.1627714918946;
 Sat, 31 Jul 2021 00:01:58 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 31 Jul 2021 01:01:43 -0600
Message-ID: <CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com>
Subject: 5.14-rc3 lockdep warning, iwlwifi 9560
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[    8.353133] iwlwifi 0000:00:14.3: loaded firmware version
46.6b541b68.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
...
[    8.737865] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x318
...
[   17.384143] ======================================================
[   17.384144] WARNING: possible circular locking dependency detected
[   17.384146] 5.14.0-0.rc3.29.fc35.x86_64+debug #1 Not tainted
[   17.384147] ------------------------------------------------------
[   17.384148] kworker/u16:8/554 is trying to acquire lock:
[   17.384149] ffff91e2af7d80e8 (&sta->rate_ctrl_lock){+.-.}-{2:2},
at: rate_control_get_rate+0xc0/0x140 [mac80211]
[   17.384197]
               but task is already holding lock:
[   17.384198] ffff91e2af7d8130 (&sta->lock){+.-.}-{2:2}, at:
ieee80211_stop_tx_ba_cb+0x2e/0x1e0 [mac80211]
[   17.384229]

dmesg:
https://drive.google.com/file/d/1A5aZNMf_qXFU6arthGyu_FEIYV08V7wv/view?usp=sharing

lspci -vvnn
00:14.3 Network controller [0280]: Intel Corporation Cannon Point-LP
CNVi [Wireless-AC] [8086:9df0] (rev 11)
    Subsystem: Intel Corporation Device [8086:0030]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    IOMMU group: 6
    Region 0: Memory at ea238000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE- FLReset+
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
        DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
             10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS-
             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+
OBFF Disabled,
             AtomicOpsCtl: ReqEn-
    Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
        Vector table: BAR=0 offset=00002000
        PBA: BAR=0 offset=00003000
    Capabilities: [100 v0] Null
    Capabilities: [14c v1] Latency Tolerance Reporting
        Max snoop latency: 0ns
        Max no snoop latency: 0ns
    Capabilities: [164 v1] Vendor Specific Information: ID=0010 Rev=0
Len=014 <?>
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi




-- 
Chris Murphy
