Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9E6A1DB4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBXOqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 09:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjBXOql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 09:46:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461921689A
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 06:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2911B81C98
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 14:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC29C4339B;
        Fri, 24 Feb 2023 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677249997;
        bh=peavsqg3yenBn7QYS5SDS1x3WO3lozC0ZMCB4rY0fq0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qzDxEPZESXm4rZnZ7XMi7/exNMnHAFbUNiurGfGjGAzPmtL5aVBweXUICr0/Gdi29
         ewrxnCt4zOLBwPJy1LpKRJUaaxUYAu7fHGIX9YA80FItxsoGz/wjSJdu/shF9TYDw5
         llJoI8JElrKGB1LqZ2XgXRGvMNKz2vlHAVm8L+bBxHZm8RAnxRpL72X3Snm0KSursJ
         DPsMYQwmriIQq8igBts6UKYHIPPEKNgdFwNpcfgD58faQ7m50yFjWvANJqRdekMMUE
         LiBf0ZgcvvGCFJNt9+j20M01oZlRSBI4y79jvwKhgXG+noUwVP7c5lDS67AxAh5OwT
         C8f01EOr1PjaQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not active
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
        <20230203060128.19625-4-quic_mpubbise@quicinc.com>
Date:   Fri, 24 Feb 2023 16:46:31 +0200
In-Reply-To: <20230203060128.19625-4-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 3 Feb 2023 11:31:28 +0530")
Message-ID: <87h6vbruig.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable for a battery operated device. Same is the case with non-WoW
> suspend, chip will never be put into low power mode when the system is
> suspended resulting in higher battery drain.
>
> As per the recommendation, sending a PDEV suspend WMI command followed
> by a QMI MODE OFF command will cease all WLAN activity and put the device
> in low power mode. When WLAN interfaces are brought up, sending a QMI
> MISSION MODE command would be sufficient to bring the chip out of low
> power. This is a better approach than doing hif_power_down()/hif_power_up()
> for every WiFi ON/OFF sequence since the turnaround time for entry/exit of
> low power mode is much less. Overhead is just the time taken for sending
> QMI MODE OFF & QMI MISSION MODE commands instead of going through the
> entire chip boot & QMI init sequence.
>
> Currently the changes are applicable only for WCN6750. This can be
> extended to other targets with a future patch.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

This is still crashing for me every time with WCN6855 on a NUC x86
device when I rmmod ath11k. Interestingly enough QCA6390 on a Dell XPS
13 9310 does not crash.

I investigated the crash more, the crash happens in
ath11k_dp_process_rxdma_err() on this line:

	srng = &ab->hal.srng_list[err_ring->ring_id];

Here are the debug messages before the crash (first and last are my
own messages):

[  226.766111] rmmod ath11k_pci
[  227.003678] ath11k_pci 0000:06:00.0: txpower from firmware NaN, reported -2147483648 dBm
[  227.082283] ath11k_pci 0000:06:00.0: qmi wifi fw del server
[  227.195760] ath11k_pci 0000:06:00.0: cookie:0x0
[  227.195843] ath11k_pci 0000:06:00.0: WLAON_WARM_SW_ENTRY 0x15b894d
[  227.216022] ath11k_pci 0000:06:00.0: WLAON_WARM_SW_ENTRY 0x0
[  227.216086] ath11k_pci 0000:06:00.0: soc reset cause:0
[  227.236170] ath11k_pci 0000:06:00.0: MHISTATUS 0xff04
[  227.270816] ath11k_pci 0000:06:00.0: ext irq:167
[  227.271231] ath11k_dp_process_rxdma_err() 4187 ab ffff888145520000 err_ring 00000000000001d0

So we get irq 167 which is:

 167:          0          0          0          0          0          0          0          0  IR-PCI-MSI-0000:06:00.0   14-edge      DP_EXT_IRQ

But in ath11k_pcic_ext_interrupt_handler() ATH11K_FLAG_EXT_IRQ_ENABLED
is still enabled so the irq is processed:

	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
		return IRQ_HANDLED;

It looks like that, after applying this patch 3, whenever
ath11k_pci_remove() is called we are not calling
ath11k_hif_irq_disable() anymore. I checked that without patch 3
ath11k_hif_irq_disable() is always called. So this patch is definitely
breaking something fundamental, but I ran out of time to invetigate
further. I hope this still helps.

Do note I have concerns about this patchset, it just changes quite a lot
of the driver logic and I'm worried what else this breaks. Also we
should definitely test with another AHB device like IPQ8074, this
patchset needs extensive testing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
