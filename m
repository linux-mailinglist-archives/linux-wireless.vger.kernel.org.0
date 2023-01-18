Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC3671481
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 07:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjARGqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 01:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjARGoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 01:44:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D15D13F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 22:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 879D5CE1906
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 06:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B5C433D2;
        Wed, 18 Jan 2023 06:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023095;
        bh=7jmwhEllwM5W/V6xnSwPgvXkrbqwQ8kpfh3maIEmMOs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GV4oEAZo4SaVY7MsDHPKAHwrfCm+6LFA8jcIRPuJ2Fq2IBmB9e7sGXMrO76V6iY8l
         2X6TK25u5YSJJc6Bj0YZL7AzeSdAZv/idi8WMHTecy4sYqPR3BHrB2HrOd6s4+Zesm
         XK9exsRwEB1kv9/OAc/dqdMXwHR5gVmCLryiCjvdHff0iv175TsSamBHQsQoB/vAAN
         roPqFJBTfTKGiKeMJIGwO29+zzdlaRYW7dm+jKF90Oo7TzEgv0R11cw3Zm0fSaeW8P
         tdk2T2eyJjabn5PHGm7LGm1Wc0Kzq9LFEAe3+VTOetlxCh8bgsE24tQU82x/ssAOwo
         PZHyrQWMkwzxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix ce memory mapping for ahb devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230113063209.7256-1-quic_rajkbhag@quicinc.com>
References: <20230113063209.7256-1-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167402309000.24104.9044414885510659579.kvalo@kernel.org>
Date:   Wed, 18 Jan 2023 06:24:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> Currently ath11k_ahb module is not loaded successfully and the wifi
> interface is not created. Kernel trace is seen while loading the
> ath11k_ahb module. The issue is seen in all ath11k AHB devices except
> in IPQ5018.
> 
> This happens because in ath11k_ahb_probe(), ab->mem_ce is initialized
> with the value of ab->mem. However, at this instant ab->mem is not
> yet set.
> 
> Later, during write to a particular memory via ath11k_ahb_write32()
> this ab->mem_ce is used with particular offset. Since ab->mem_ce is
> not set properly this possibly leads to memory conflict to handle
> kernel paging request and the below trace is seen.
> 
> [   93.035047] Unable to handle kernel paging request at virtual address ffff800100a00000
> [   93.035083] Mem abort info:
> [   93.041869]   ESR = 0x0000000096000045
> [   93.044561]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   93.048377]   SET = 0, FnV = 0
> [   93.053840]   EA = 0, S1PTW = 0
> [   93.056704]   FSC = 0x05: level 1 translation fault
> [   93.059745] Data abort info:
> [   93.064603]   ISV = 0, ISS = 0x00000045
> [   93.067729]   CM = 0, WnR = 1
> [   93.071287] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000042219000
> [   93.074409] [ffff800100a00000] pgd=100000007ffff003, p4d=100000007ffff003, pud=0000000000000000
> [   93.081195] Internal error: Oops: 0000000096000045 [#1] PREEMPT SMP
> [   93.089598] Modules linked in: ath11k_ahb ath11k_pci ath11k qmi_helpers
> [   93.095851] CPU: 2 PID: 66 Comm: kworker/u8:3 Not tainted 6.1.0-rc8-wt-ath-658126-g58e4b9df840c-dirty #2
> [   93.102454] Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK14 (DT)
> [   93.112171] Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work [ath11k]
> [   93.118856] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   93.126838] pc : ath11k_ahb_write32+0xc/0x18 [ath11k_ahb]
> [   93.133520] lr : ath11k_hal_srng_setup+0x860/0x8f0 [ath11k]
> [   93.139075] sp : ffff80000aaebb70
> [   93.144452] x29: ffff80000aaebb70 x28: 0000000000000020 x27: ffff80000aaebc50
> [   93.147934] x26: ffff000004923750 x25: ffff000004921200 x24: ffff000004928000
> [   93.155051] x23: 0000000000000020 x22: ffff000004930000 x21: ffff000004923200
> [   93.162170] x20: ffff000004920000 x19: 00000000eea00000 x18: ffff0000049200f0
> [   93.169288] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000000025e
> [   93.176405] x14: ffff000003c414f0 x13: 0000000000000000 x12: 0000000000000008
> [   93.183524] x11: ffff000003c41488 x10: 0000000000000040 x9 : 0000000000000000
> [   93.190641] x8 : ffff80000a9dd100 x7 : 0000000000000000 x6 : 000000000000003f
> [   93.197759] x5 : ffff800100a00400 x4 : ffff8000031f4018 x3 : 0000000000000004
> [   93.204877] x2 : 0000000047b62000 x1 : ffff800100a00000 x0 : ffff800012000000
> [   93.211996] Call trace:
> [   93.219104]  ath11k_ahb_write32+0xc/0x18 [ath11k_ahb]
> [   93.221366]  ath11k_ce_init_ring+0x184/0x278 [ath11k]
> [   93.226576]  ath11k_ce_init_pipes+0x4c/0x1a0 [ath11k]
> [   93.231610]  ath11k_core_qmi_firmware_ready+0x3c/0x568 [ath11k]
> [   93.236646]  ath11k_qmi_driver_event_work+0x168/0x4f8 [ath11k]
> [   93.242376]  process_one_work+0x144/0x350
> [   93.248275]  worker_thread+0x120/0x430
> [   93.252352]  kthread+0xf4/0x110
> [   93.255997]  ret_from_fork+0x10/0x20
> [   93.259043] Code: d503201f f94e1c00 8b214001 d50332bf (b9000022)
> [   93.262863] ---[ end trace 0000000000000000 ]---
> 
> However, for the device IPQ5018 ath11k_hw_params .ce_remap is
> defined. This parameter is used to recalculate ab->mem_ce and hence,
> this issue is not seen in IPQ5018.
> 
> Hence, fix this by initializing ab->mem_ce after ab->mem is set.
> ab->mem is set inside the ath11k_ahb_setup_resources() therefore
> initialize ab->mem_ce after ath11k_ahb_setup_resources().
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: b42b3678c91f ("wifi: ath11k: remap ce register space for IPQ5018")
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

53a998c4d728 wifi: ath11k: fix ce memory mapping for ahb devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230113063209.7256-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

