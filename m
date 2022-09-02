Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DA5AB236
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiIBNxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiIBNws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 09:52:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06DF63E7
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AB38B82A71
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 12:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972F0C433C1;
        Fri,  2 Sep 2022 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662122904;
        bh=X7k9u03NrCRVi1tPAxl93m0OI4CnrSnokeidvxHnYzI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KsJay/KZ77dM8LXcQJjVxL3Y4YHQQdGGUF+k3YBLnF4MZMoCloBCBRvznOcGQaNg+
         Ob3UIyj+/GDKem869n+lS0wiZnKoD+pCoGbqLhwvldtSZV8mGc8CPtUXtqkYNwoDwH
         iJcyt4a9XjxPFhgH1HzWl/9xEPIHqAIuXkhM7NZc9k1hTIOs2VQzEFyVoNr41yOpa0
         9XQSbT02cTOTt3wtjCLAhImcM+RCTENCKJPDfra1UALdbMfydFCYuxgpq2VU5eHEmE
         +CNpE321HzAdIPAV7dVlsug6BS4rqE1PgHx9+zxZ8diZx9tM15DEujanvu+uHaOc6/
         xI/2P6tNNTDRA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
        <20220720135113.15755-2-quic_mpubbise@quicinc.com>
Date:   Fri, 02 Sep 2022 15:48:19 +0300
In-Reply-To: <20220720135113.15755-2-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 20 Jul 2022 19:21:11 +0530")
Message-ID: <87czceaqng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Enable threaded NAPI on WCN6750. Unlike traditional NAPI poll which
> runs in softirq context and on the core which scheduled the NAPI,
> threaded NAPI makes use of kernel threads which are under direct
> control of the scheduler and helps in balancing the NAPI processing
> load across multiple CPUs thereby improving throughput.
>
> In the case of WCN6750, enabling threaded NAPI has improved
> 160 MHz RX throughput by nearly 400 Mbps. This should give similar
> gains for other ath11k devices as well, therefore enable threaded
> NAPI on all other devices.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c  | 1 +
>  drivers/net/wireless/ath/ath11k/pcic.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index d7d33d5cdfc5..e44e2f29a88f 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -314,6 +314,7 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
>  		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
>  
>  		if (!irq_grp->napi_enabled) {
> +			dev_set_threaded(&irq_grp->napi_ndev, true);
>  			napi_enable(&irq_grp->napi);
>  			irq_grp->napi_enabled = true;
>  		}
> diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
> index cf12b98c480d..c703db19de51 100644
> --- a/drivers/net/wireless/ath/ath11k/pcic.c
> +++ b/drivers/net/wireless/ath/ath11k/pcic.c
> @@ -440,6 +440,7 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
>  		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
>  
>  		if (!irq_grp->napi_enabled) {
> +			dev_set_threaded(&irq_grp->napi_ndev, true);
>  			napi_enable(&irq_grp->napi);
>  			irq_grp->napi_enabled = true;
>  		}

The commit log claims that this enabled _only_ on WCN6750 but aren't we
enabling it on all ath11k hardware, or am I missing something? I admit I
didn't check this very carefully.

(reads the commit log one more time)

Ah, in the last sentence you mention that it's enabled on all hardware.
That's quite easy to miss and the commit log is quite misleading, please
emphasise already in the title and the first sentence that this is for
all hardware.

Also more testing would be nice. Enabling something like this with
testing only on one hardware family (WCN7850) can be risky. I always get
warm fuzzy feelings if a patch is tested with all three hardware
families we currently support:

* IPQ8074 etc
* QCA6390 etc
* WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
