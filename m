Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285953C6F3
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiFCIe2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFCIe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:34:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9234117E2D
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52DCAB8214F
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 08:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F362EC385A9;
        Fri,  3 Jun 2022 08:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654245263;
        bh=vuM1FijWVf3JLmS6pjEO4fnhUWhgktmQ1f4rrxAKU0c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gTPVpvwVuSLqejphnDn8xIzI9BOLHmAvQeEoznfT5ivYgKpy3T/Kp2t3w/naghmND
         It+W2MZg1quWqdD98EdN4SWeCTAmFDAd0Lr+ixyW6SMtQOiiB0euR8O97gJzAX0jZS
         2HxfoDnyfOPEp5KUszZnd3AFsvQb7wr5FyuNbJeBlIgN5Y2LWwqKngB7lO6RCAizDG
         1k4/BlO9CAh9lKHMUibmO7QNBF5/PICdqxuaG11TLeGFB6eRazp/d1UZIe8cl4UvyV
         gMPymdNtChI7iisNKCD6QxvJ7FcVkUKFGl9CgXBm0gQY+OMTAEnFr7lbr5PrvZ+NBR
         l3361krjb05rQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: Add support for dynamic vlan
References: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
Date:   Fri, 03 Jun 2022 11:34:17 +0300
In-Reply-To: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
        (Seevalamuthu Mariappan's message of "Mon, 10 Jan 2022 09:11:30
        +0530")
Message-ID: <874k12no1i.fsf@kernel.org>
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

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:

> Advertise AP-VLAN interface type for vlan support in driver.
> Metadata information in dp_tx is added to notify firmware
> that multicast/broadcast packets are encrypted in software.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c  |  6 +++
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 74 ++++++++++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath11k/dp_tx.h | 14 +++++++
>  drivers/net/wireless/ath/ath11k/hw.h    |  1 +
>  drivers/net/wireless/ath/ath11k/mac.c   |  5 +++
>  5 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 293563b..0b2407e 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -86,6 +86,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = false,
> +		.supports_ap_vlan = true,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
> @@ -150,6 +151,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = false,
> +		.supports_ap_vlan = true,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
> @@ -213,6 +215,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = true,
> +		.supports_ap_vlan = false,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>  		.supports_regdb = true,
>  		.fix_l1ss = true,
> @@ -276,6 +279,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 8,
>  		.num_peers = 128,
>  		.supports_suspend = false,
> +		.supports_ap_vlan = true,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
> @@ -339,6 +343,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = true,
> +		.supports_ap_vlan = false,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
> @@ -401,6 +406,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = true,
> +		.supports_ap_vlan = false,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
>  		.supports_regdb = true,
>  		.fix_l1ss = false,

As this is an old patch, please make sure all entries in hw_params have
supports_ap_vlan.

> +static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_len)
> +{
> +	if (unlikely(skb_cow_head(skb, align_len)))
> +		return -ENOMEM;

The preferred style in ath11k is:

ret = skb_cow_head(skb, align_len);
if (unlikely(ret))
	return ret;

But is the unlikely() really necessary here?

I doubt this applies anymore so please rebase and submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
