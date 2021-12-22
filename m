Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6147CDB0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbhLVHyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 02:54:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38352 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVHyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 02:54:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7889618D6
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 07:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD2C36AE5;
        Wed, 22 Dec 2021 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640159676;
        bh=XLBYJuppkas4D825vESwdBqX6EeXfIw3TfBh0xrJ0JM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WQeB8gNgjbOXw//8G6PB7mYTLf2ob4VeSJyIhwmqq/lw7LBwYWrhPa/xT7tWO6/7A
         gFqa8pfswn6xRKti/ay17g/MkMnEo+Fc/HcUzNyLfwWQVdA6WHAqMq4q+R7Pd+MYAW
         lhV7UrkXjydRgIQtho/AcxDsUovtapUjcWU0fS4/eBBAvJZ2EVDnGKtPZUH7isZPlo
         NsAZITtrg9TfGi9ky2VSfeu7qmnk0jxxAfWHJUVve7VdAlXSMefzqAUPianVuVn6Zo
         EMTc6XVw+zRlvJ/26x3obPS/lx/kEfSerhZ+Z2uyyfc2FJmeygITjEntpW+ALUWCZc
         nDjKOYdq394wg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        enrico@fracta.dev
Subject: Re: [PATCH v2] ath10k: abstract htt_rx_desc structure
References: <20211216151823.68878-1-franciman12@gmail.com>
Date:   Wed, 22 Dec 2021 09:54:30 +0200
In-Reply-To: <20211216151823.68878-1-franciman12@gmail.com> (Francesco
        Magliocca's message of "Thu, 16 Dec 2021 16:18:23 +0100")
Message-ID: <87bl192hxl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Francesco Magliocca <franciman12@gmail.com> writes:

> QCA6174 card often hangs with the current htt_rx_desc
> memory layout in some circumstances, because its firmware
> fails to handle length differences.
> Therefore we must abstract the htt_rx_desc structure
> and operations on it, to allow different wireless cards
> to use different, unrelated rx descriptor structures.
>
> Define a base htt_rx_desc structure and htt_rx_desc_qca_old
> for use with the QCA family of ath10k supported cards
> and htt_rx_desc_new for use with the WCN3990 card.
>
> Define htt_rx_desc_ops which contains the abstract operations
> to access the generic htt_rx_desc, give implementations
> for each card and update htt_rx.c to use the defined
> abstract interface to rx descriptors.
>
> Fixes: e3def6f7ddf8 ("ath10k: Update rx descriptor for WCN3990 target")
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>
> Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
> Link: https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

This looks, but I did some changes in the pending branch. Please check
my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c9a516b946c4b3ce25d422890ca78d0ca730b065

Below are my comments.

drivers/net/wireless/ath/ath10k/htt.c:141: line length of 98 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt.c:149: line length of 98 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:374: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1098: line length of 98 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1234: line length of 98 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1261: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1417: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1553: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1600: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1654: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1710: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1753: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1788: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1814: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1930: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:1962: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:2172: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:2211: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:3139: line length of 100 exceeds 90 columns
drivers/net/wireless/ath/ath10k/htt_rx.c:3148: line length of 92 exceeds 90 columns

ath10k-check warned about long lines, so I fixed those.

> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -75,6 +75,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>  			.board_size = QCA988X_BOARD_DATA_SZ,
>  			.board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
>  		},
> +		.rx_desc_ops = &qca988x_rx_desc_ops,
>  		.hw_ops = &qca988x_ops,

Any particular reason why you didn't use the existing hw_ops?

> +static void ath10k_rx_desc_wcn3990_get_offsets(struct htt_rx_ring_rx_desc_offsets *off)
> +{
> +#define desc_offset(x) (offsetof(struct htt_rx_desc_new, x) / 4)
> +	off->mac80211_hdr_offset = __cpu_to_le16(desc_offset(rx_hdr_status));
> +	off->msdu_payload_offset = __cpu_to_le16(desc_offset(msdu_payload));
> +	off->ppdu_start_offset = __cpu_to_le16(desc_offset(ppdu_start));
> +	off->ppdu_end_offset = __cpu_to_le16(desc_offset(ppdu_end));
> +	off->mpdu_start_offset = __cpu_to_le16(desc_offset(mpdu_start));
> +	off->mpdu_end_offset = __cpu_to_le16(desc_offset(mpdu_end));
> +	off->msdu_start_offset = __cpu_to_le16(desc_offset(msdu_start));
> +	off->msdu_end_offset = __cpu_to_le16(desc_offset(msdu_end));
> +	off->rx_attention_offset = __cpu_to_le16(desc_offset(attention));
> +	off->frag_info_offset = __cpu_to_le16(desc_offset(frag_info));
> +#undef desc_metadata_offset
> +#undef metadata_offset

I couldn't find these two defined anywhere so removed the undefs.

> +/* rx descriptor for wcn3990 and possibly extensible for newer cards
> + * Buffers like this are placed on the rx ring.
> + */
> +struct htt_rx_desc_new {
> +	struct htt_rx_desc base;
>  	struct {
>  		struct rx_attention attention;
>  		struct rx_frag_info frag_info;
> @@ -2210,6 +2221,240 @@ struct htt_rx_desc {
>  	u8 msdu_payload[];
>  };

Using old and new is not a good idea when versioning something because
when a third one is added the naming will be hard. So I renamed old to
v1 and new to v2 everywhere in the patch.

> +extern const struct ath10k_htt_rx_desc_ops qca988x_rx_desc_ops;
> +extern const struct ath10k_htt_rx_desc_ops qca99x0_rx_desc_ops;
> +extern const struct ath10k_htt_rx_desc_ops wcn3990_rx_desc_ops;

These should be use "ath10k_" prefix, but forgot to change that. Will do
it later.

> +static inline struct rx_msdu_end_common	*
> +ath10k_htt_rx_desc_get_msdu_end(struct ath10k_hw_params	*hw, struct htt_rx_desc	*rxd)

Are there extra space before '*'? Need to check that.

> +static inline struct rx_ppdu_end_common	*
> +ath10k_htt_rx_desc_get_ppdu_end(struct ath10k_hw_params	*hw, struct htt_rx_desc	*rxd)

Extra spaces?

>  static struct ieee80211_channel *
>  ath10k_htt_rx_h_peer_channel(struct ath10k *ar, struct htt_rx_desc *rxd)
>  {
> +	struct ath10k_hw_params *hw = &ar->hw_params;
> +	struct rx_attention *rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);
> +	struct rx_msdu_end_common *rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
> +	struct rx_mpdu_start *rxd_mpdu_start = ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
>  	struct ath10k_peer *peer;
>  	struct ath10k_vif *arvif;
>  	struct cfg80211_chan_def def;
> @@ -1069,15 +1107,15 @@ ath10k_htt_rx_h_peer_channel(struct ath10k *ar, struct htt_rx_desc *rxd)
>  	if (!rxd)
>  		return NULL;

Here I moved the variable initialisation after the rxd null check to
avoid null pointer issues and also reduce long lines.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
