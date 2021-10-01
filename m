Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720BF41EB96
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353165AbhJALTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352728AbhJALT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 07:19:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAEEC06177B
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 04:17:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j27so6981879wms.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/daOxNeMRBqAQ9qFc9dbkkcOID+IWuEhIuLuYmnrND8=;
        b=bAOeC9AJaZ6n3huKl2ky8zQJUv2CJqws9i8ZJIwYTltlKeJqyhxKVlP+EWSYfLlAW0
         78I60qmqdCvLi4j7YCNXk0f2Jt2Vhp0eR2uGcvzBbiGcYhT0ueKIoQa/GUruM3mR29g4
         HMMte/mPGqMPdC/tjoHEBrV465ypl8+DvJKll48fzbhDtG9io3ngigBeJVtgZgEm5Lcu
         zXtChJHa1OEvWWDuXq6yP3xNN6E0G3aVvYBpdO3Wo146Vfao8FujkIE6Ib+3X+sLWhR4
         DONQ1CC+sCIbu9z/z+EGpjsGIJWXrssEuEcvBEspaOGJKKUXqhogW6ECevgEPyT5x4kZ
         vF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/daOxNeMRBqAQ9qFc9dbkkcOID+IWuEhIuLuYmnrND8=;
        b=5oXMvYPz6JqhefB8vhP6/yOti+JmSgKsfJ7ROM6z2lK4x8bpMbNUVHxfOau55fvJrV
         9Te/eBY3CCBKjLy/yNaJe96Th7EXNGIoiwnF/i/xtMqZ6AOjoLftbHpSu9mtz143IpOO
         PJ2QjWrQyi3PSuwSKRM5Od2tYdf3PUR5hOXGeg5Qv41PZKcj9KEnoeAQt1fYPgrdrK36
         QEdXvmnWcHFsBQ1kvfLJTECRElmXUW/yRzZhSYJ5k4vlt74cuZDx5c0kyS3QYWedkGd0
         +JU52ZHnU6RILJjGTo7HIE9o3ILvwa+bMJpKuJ1vQGXc2jW+KYr7slfW7GJDOc5YVHXV
         V2QA==
X-Gm-Message-State: AOAM530xSm7mgbIFkEF/FuBgcl9m1JiLTGhxBYcUXGPojLKEX3jQJVSw
        H2LouznMxIxMbJyHzntvWWM=
X-Google-Smtp-Source: ABdhPJwrmN6K45pUi+Y7WuZleS9c1EVmueCrA6kIQje16YW9M5oY/cTvF5XrwHtjnZHJD78UCNPBGA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr3979971wme.94.1633087061988;
        Fri, 01 Oct 2021 04:17:41 -0700 (PDT)
Received: from [192.168.1.6] ([171.49.254.68])
        by smtp.gmail.com with ESMTPSA id v13sm2507895wrp.64.2021.10.01.04.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 04:17:41 -0700 (PDT)
Message-ID: <6436bf9c-02fc-06b0-eb27-15a33b64abe0@gmail.com>
Date:   Fri, 1 Oct 2021 16:47:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Qualcomm Atheros Ath10k and Ath11k CE Buffer DMA alignment issues
 on Raspberry PI CM4 - Aarch64 architecture
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Maurice Smulders <Maurice.Smulders@windtalker.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org
References: <35F57D80-C7F7-47B2-BEC8-533006C72E2A@windtalker.com>
 <87lf3d5jxo.fsf@tynnyri.adurom.net>
From:   Govind Singh <govind.sk85@gmail.com>
In-Reply-To: <87lf3d5jxo.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 01-10-2021 12:08, Kalle Valo wrote:
> Maurice Smulders <Maurice.Smulders@windtalker.com> writes:
>
>> I am trying to use the QCA6174A and the QCA6390 on a custom board using a PCIe switch - but that doesn't matter - It still fails w/o the switch:
>>
>> lspci
>> 00:00.0 PCI bridge: Broadcom Inc. and subsidiaries BCM2711 PCIe Bridge (rev 20)
>> 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 02:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 02:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 02:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane Packet Switch
>> 05:00.0 Unassigned class [ff00]: Qualcomm QCA6390 Wireless Network Adapter [AX500-DBS (2x2)]
>> 06:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
>>
>> Both device drivers do not work. I changed the CE code to use the GFP_DMA32 flag as an attempt to allocate the memory correctly, but DMESG shows
>>
>> [pi@node6745 ~]$ dmesg | grep ath
>> [    5.801896] ath10k_pci 0000:06:00.0: ath10k_ce_alloc_src_ring: Not unaligned <--- User message exit from this function
>> [    5.804284] ath10k_pci 0000:06:00.0: failed to alloc CE src ring 0: -12
>> [    5.813138] ath10k_pci 0000:06:00.0: failed to allocate copy engine pipe 0: -12
>> [    5.815414] ath10k_pci 0000:06:00.0: failed to allocate copy engine pipes: -12
>> [    5.818002] ath10k_pci 0000:06:00.0: failed to setup resource: -12
>> [    5.826953] ath10k_pci: probe of 0000:06:00.0 failed with error -12
>> [    5.855993] ath11k_pci 0000:05:00.0: WARNING: ath11k PCI support is experimental!
>> [    5.896148] ath11k_pci 0000:05:00.0: BAR 0: assigned [mem 0x600000000-0x600ffffff 64bit]
>> [    5.900236] ath11k_pci 0000:05:00.0: enabling device (0000 -> 0002)
>> [    5.914050] ath11k_pci: probe of 0000:05:00.0 failed with error -12
>>
>> Error -12 (ENOMEM) gets returned and the driver doesn't work...
>>
>> 05:00.0 Unassigned class [ff00]: Qualcomm QCA6390 Wireless Network Adapter [AX500-DBS (2x2)]
>> Subsystem: Qualcomm Device 0108
>> Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Region 0: Memory at 600000000 (64-bit, non-prefetchable) [size=16M]
>> Capabilities: <access denied>
>> Kernel modules: ath11k_pci
>>
>> 06:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
>> Subsystem: ASUSTeK Computer Inc. Device 86e0
>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> Interrupt: pin A routed to IRQ 48
>> Region 0: Memory at 601000000 (64-bit, non-prefetchable) [disabled] [size=2M]
>> Capabilities: <access denied>
>> Kernel modules: ath10k_pci
>>
>> I am at a loss what to do here. The ath11k driver has the SINGLE MSI fix built in.
>>
>> Any ideas' what I can try to fix this problem on the raspberry Pi CM4?
> Sorry, no ideas. But adding ath10k and ath11k lists, maybe people there
> can propose something.
In RPI CM4 board, pcie-32bit-dma configuration is required for 
QCA6174/QCA9880 module, which can be enabled using dt overlay. Also, you 
will have to enable legacy PCI IRQ mode(using modparam@ath10k_pci 
irq_mode=1) as MSI does not work.

DT overlay change:
56b8b2c96118293ad6dec20203dada8116f7c664:overlays: Add pcie-32bit-dma 
overlay


BR,

Govind


