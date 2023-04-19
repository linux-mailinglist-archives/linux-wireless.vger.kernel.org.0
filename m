Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0536E7C86
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjDSOZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDSOZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 10:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321BC1BE2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 07:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3981E636B2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 14:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68BFC433D2;
        Wed, 19 Apr 2023 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914258;
        bh=tJZZqrGqSqQb66lSfUCypSSZbSXjYgIzHCvjRylaWUg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bYfdTw413uby8FkU9x+mjUBSKt8iOBQP2drrJI7QEhrZlPVWUSjOJnCCTvmnA5YOt
         K0c1Jf86GPrtEzNIhk4oifMm4LKiIDzcUBcGqt0UKEFWSp4YoMDC6gu+r4TNXBIWDZ
         pX6W53O6LiWTTUonO9/0eDdLD6s0HYCoLiDpqCoQqf58lZ7RwUXXwbxMC8vIjNbNXM
         pQmKZj2IN5CsQN9QJ4QV0L92ntl9/sMOmgEZrkszupPdmql0ebOUanR0ng/Gdtbqvw
         EfAIziV01vO9hgCRPYsAR6hRA5WhXMUJ2HCX0Pw/BThtUuT6GzdFeAXW5eqqE9mutH
         PEebccMSfPp3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Fix SKB corruption in REO destination ring
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230403191533.28114-1-quic_nmaran@quicinc.com>
References: <20230403191533.28114-1-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168191425579.18451.5661406318387164374.kvalo@kernel.org>
Date:   Wed, 19 Apr 2023 14:24:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> While running traffics for a long time, randomly an RX descriptor
> filled with value "0" from REO destination ring is received.
> This descriptor which is invalid causes the wrong SKB (SKB stored in
> the IDR lookup with buffer id "0") to be fetched which in turn
> causes SKB memory corruption issue and the same leads to crash
> after some time.
> 
> Changed the start id for idr allocation to "1" and the buffer id "0"
> is reserved for error validation. Introduced Sanity check to validate
> the descriptor, before processing the SKB.
> 
> Crash Signature :
> 
> Unable to handle kernel paging request at virtual address 3f004900
> PC points to "b15_dma_inv_range+0x30/0x50"
> LR points to "dma_cache_maint_page+0x8c/0x128".
> The Backtrace obtained is as follows:
> [<8031716c>] (b15_dma_inv_range) from [<80313a4c>] (dma_cache_maint_page+0x8c/0x128)
> [<80313a4c>] (dma_cache_maint_page) from [<80313b90>] (__dma_page_dev_to_cpu+0x28/0xcc)
> [<80313b90>] (__dma_page_dev_to_cpu) from [<7fb5dd68>] (ath11k_dp_process_rx+0x1e8/0x4a4 [ath11k])
> [<7fb5dd68>] (ath11k_dp_process_rx [ath11k]) from [<7fb53c20>] (ath11k_dp_service_srng+0xb0/0x2ac [ath11k])
> [<7fb53c20>] (ath11k_dp_service_srng [ath11k]) from [<7f67bba4>] (ath11k_pci_ext_grp_napi_poll+0x1c/0x78 [ath11k_pci])
> [<7f67bba4>] (ath11k_pci_ext_grp_napi_poll [ath11k_pci]) from [<807d5cf4>] (__napi_poll+0x28/0xb8)
> [<807d5cf4>] (__napi_poll) from [<807d5f28>] (net_rx_action+0xf0/0x280)
> [<807d5f28>] (net_rx_action) from [<80302148>] (__do_softirq+0xd0/0x280)
> [<80302148>] (__do_softirq) from [<80320408>] (irq_exit+0x74/0xd4)
> [<80320408>] (irq_exit) from [<803638a4>] (__handle_domain_irq+0x90/0xb4)
> [<803638a4>] (__handle_domain_irq) from [<805bedec>] (gic_handle_irq+0x58/0x90)
> [<805bedec>] (gic_handle_irq) from [<80301a78>] (__irq_svc+0x58/0x8c)
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f9fff67d2d7c wifi: ath11k: Fix SKB corruption in REO destination ring

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230403191533.28114-1-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

