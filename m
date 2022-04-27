Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288F851125C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbiD0HbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiD0HbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 03:31:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006706D97E
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 00:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B463DB824B0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 07:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5681DC385A7;
        Wed, 27 Apr 2022 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044482;
        bh=i1MksPYxwLoIvoNytS28wKo4pIbrPrqNpFbI1Dy3/8I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bObbJSqfQXYLbDzpGoFaImmURuzOR9sYgx0p4t2g0TFVZ5nlL//QPJzNsmSYRz+yH
         PMBmVc/O29qW6mYmIEz55w+N6GNp7X1V5xJuT7sxQhSrmFdB3N8pXYjA+obhsJtZjf
         E17yYZIRx4GAcsrtiSRaUoJO5Zk+vlD3L7yEqz3kLIaR1Q73fEDSVFtuTDy1/KS3c6
         WslIJQR3QTxLTaiIQwK4mVosbEerrF47NMQu8Zp2xoJeY9L3y+7tVNyLyQ2pNVPSJ2
         iCRAT83zIKtzjpfZ0bRxc/Mi0riSnN+onuow4v2zRKhvfB5/bZJSqkbNrTi4TZWtE1
         fFd7esJWfZYjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: disable spectral scan during spectral deinit
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1649396345-349-1-git-send-email-quic_haric@quicinc.com>
References: <1649396345-349-1-git-send-email-quic_haric@quicinc.com>
To:     <quic_haric@quicinc.com>
Cc:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        "Hari Chandrakanthan" <quic_haric@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165104447917.30072.15809077383105828467.kvalo@kernel.org>
Date:   Wed, 27 Apr 2022 07:28:01 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<quic_haric@quicinc.com> wrote:

> When ath11k modules are removed using rmmod with spectral scan enabled,
> crash is observed. Different crash trace is observed for each crash.
> 
> Send spectral scan disable WMI command to firmware before cleaning
> the spectral dbring in the spectral_deinit API to avoid this crash.
> 
> call trace from one of the crash observed:
> [ 1252.880802] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [ 1252.882722] pgd = 0f42e886
> [ 1252.890955] [00000008] *pgd=00000000
> [ 1252.893478] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [ 1253.093035] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.89 #0
> [ 1253.115261] Hardware name: Generic DT based system
> [ 1253.121149] PC is at ath11k_spectral_process_data+0x434/0x574 [ath11k]
> [ 1253.125940] LR is at 0x88e31017
> [ 1253.132448] pc : [<7f9387b8>]    lr : [<88e31017>]    psr: a0000193
> [ 1253.135488] sp : 80d01bc8  ip : 00000001  fp : 970e0000
> [ 1253.141737] r10: 88e31000  r9 : 970ec000  r8 : 00000080
> [ 1253.146946] r7 : 94734040  r6 : a0000113  r5 : 00000057  r4 : 00000000
> [ 1253.152159] r3 : e18cb694  r2 : 00000217  r1 : 1df1f000  r0 : 00000001
> [ 1253.158755] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [ 1253.165266] Control: 10c0383d  Table: 5e71006a  DAC: 00000055
> [ 1253.172472] Process swapper/0 (pid: 0, stack limit = 0x60870141)
> [ 1253.458055] [<7f9387b8>] (ath11k_spectral_process_data [ath11k]) from [<7f917fdc>] (ath11k_dbring_buffer_release_event+0x214/0x2e4 [ath11k])
> [ 1253.466139] [<7f917fdc>] (ath11k_dbring_buffer_release_event [ath11k]) from [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx+0x1840/0x29cc [ath11k])
> [ 1253.478807] [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx [ath11k]) from [<7f8fe868>] (ath11k_htc_rx_completion_handler+0x180/0x4e0 [ath11k])
> [ 1253.490699] [<7f8fe868>] (ath11k_htc_rx_completion_handler [ath11k]) from [<7f91308c>] (ath11k_ce_per_engine_service+0x2c4/0x3b4 [ath11k])
> [ 1253.502386] [<7f91308c>] (ath11k_ce_per_engine_service [ath11k]) from [<7f9a4198>] (ath11k_pci_ce_tasklet+0x28/0x80 [ath11k_pci])
> [ 1253.514811] [<7f9a4198>] (ath11k_pci_ce_tasklet [ath11k_pci]) from [<8032227c>] (tasklet_action_common.constprop.2+0x64/0xe8)
> [ 1253.526476] [<8032227c>] (tasklet_action_common.constprop.2) from [<803021e8>] (__do_softirq+0x130/0x2d0)
> [ 1253.537756] [<803021e8>] (__do_softirq) from [<80322610>] (irq_exit+0xcc/0xe8)
> [ 1253.547304] [<80322610>] (irq_exit) from [<8036a4a4>] (__handle_domain_irq+0x60/0xb4)
> [ 1253.554428] [<8036a4a4>] (__handle_domain_irq) from [<805eb348>] (gic_handle_irq+0x4c/0x90)
> [ 1253.562321] [<805eb348>] (gic_handle_irq) from [<80301a78>] (__irq_svc+0x58/0x8c)
> 
> Tested-on: QCN6122 hw1.0 AHB WLAN.HK.2.6.0.1-00851-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

161c64de239c ath11k: disable spectral scan during spectral deinit

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1649396345-349-1-git-send-email-quic_haric@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

