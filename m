Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9513517170
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiEBO2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiEBO2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 10:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F2BF6B
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 07:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4140F60B6B
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 14:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918AC385A4;
        Mon,  2 May 2022 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651501509;
        bh=rYy4mpAx6EyxzNfDAK8Zp5xCShNoIUSIErNAxKOZE1o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nm2I33v4dmGau/a2WmCkzYyxbFqRIfac0f719qLFowSTDqcyF64cGKUuSfqTTcXB8
         beIm6Bsu9XCy3C8++HhKWK1+LotmtWbqLBqDVMSnEkJfd+WBOYicpgCzQ16y2//8ps
         SCi+MIp/+V/c8N6W6C7MuIqf3ipxKr366T78bcKrHoOwf9wv0IxqsVHiUiV9MtwDtl
         lBVJCoP5p71ZL5dax+wtIRqYDlPpIfhxKLKLPE2iKRyvXTf0xm5hNK5wF4sVEn04u6
         a3gubEOs+iFljmb9pbhy0OtBkoziszXxzk84h7u9e9e6GUf27E34hni5DW+o5seplq
         gyzTrVWPthD2w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] ath11k: Fix RX de-fragmentation issue on WCN6750
References: <20220328061947.28813-1-quic_mpubbise@quicinc.com>
Date:   Mon, 02 May 2022 17:25:04 +0300
In-Reply-To: <20220328061947.28813-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 28 Mar 2022 11:49:47 +0530")
Message-ID: <87bkwgau67.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> The offset of REO register where the RX fragment destination ring
> is configured is different in WCN6750 as compared to WCN6855.
> Due to this differnce in offsets, on WCN6750, fragment destination
> ring will be configured incorrectly, leading to RX fragments not
> getting delivered to the driver. Fix this by defining HW specific
> offset for the REO MISC CTL register.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> @@ -2229,6 +2229,9 @@ const struct ath11k_hw_regs wcn6855_regs = {
>  
>  	/* Shadow register area */
>  	.hal_shadow_base_addr = 0x000008fc,
> +
> +	/* REO MISC CTRL */
> +	.hal_reo1_misc_ctl = 0x00000630,
>  };

I don't really see the benefit from the comment, it doesn't bring any
extra information.

>  const struct ath11k_hw_regs wcn6750_regs = {
> @@ -2311,6 +2314,9 @@ const struct ath11k_hw_regs wcn6750_regs = {
>  
>  	/* Shadow register area */
>  	.hal_shadow_base_addr = 0x00000504,
> +
> +	/* REO MISC CTRL */
> +	.hal_reo1_misc_ctl = 0x000005d8,

Ditto.

What about other ath11k_hw_regs tables:

<global>[1906]                 const struct ath11k_hw_regs ipq8074_regs = {
<global>[1988]                 const struct ath11k_hw_regs qca6390_regs = {
<global>[2070]                 const struct ath11k_hw_regs qcn9074_regs = {

You don't mention anything about those in the commit log. If they don't
use this register (didn't check) we should at least initialise the
fields to zero, deadbeef or something to make it clear they are unused.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
