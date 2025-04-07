Return-Path: <linux-wireless+bounces-21212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBEA7ECCF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EFB189CB99
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AD25D54E;
	Mon,  7 Apr 2025 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKuHHoBt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9925D545;
	Mon,  7 Apr 2025 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052570; cv=none; b=iEKDxol4rVbK/6imeVkZxQ/Xr/PgUE8/NE73/nMlL9tfh5YGX+apBuqZA3InhW5c70xNo/Ezkbf6BEmKPi79lDKpdXVMGzJqM7ie3TrtJO/IxB4J7p1cFMjWz+UXSw85Q4c1y6U3mVlXLfMeAe3NvdQsdII8X2z5lLHkP6uST2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052570; c=relaxed/simple;
	bh=b/MXUmcAbF/lysUWjr8HjXUt9a43+bWo9N2Fk7BZ/x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO/C8n0yXeEUsbfSBiwB1dQKczUw8NzAR9V2kiG0D7tkKt/HDRdJLkkticjWnTHvIWqt/SP5HIXhgCA+OVi50l3lAmhAuOQYq9RT9JMltNizoeo8twZxVemu4DokSnHYo2/WDjteKLP3AMcEfo9KNmk+RmBBmDmhvs0TEiza/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKuHHoBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A283C4CEDD;
	Mon,  7 Apr 2025 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052570;
	bh=b/MXUmcAbF/lysUWjr8HjXUt9a43+bWo9N2Fk7BZ/x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKuHHoBtemrJGN7x4S5oEc6HTjYwNK5EeCEgTP0fjHDv58jNQ+nOOWhYqlZSa1FKS
	 wi/bninK4zyZoajNsDxcm3aAk6wHSfwg4QBtFZTq+aSllD9IcQYaFXXcHcJwaw77rn
	 qnML7crgeQFJdX8LriJdxs6BFg6ADV8cfMMQNfMfqOzFRmBf4RZwdbRb1o8w6rCVrI
	 WDfB5igRXqCZZ8PSGehRlOKh+wC22wsKqU5/eDTb3TGY5wkLjLq0uOZWsoPMh/9Kb5
	 Tw/ZNA73fIV+h8UQeJkoaR9uT5T8+ptYaIc5WN9m6UhI96wCPUCp0CNkDK3aLeGYzI
	 N5cVEkN+tWZFw==
Date: Mon, 7 Apr 2025 12:02:47 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mac80211: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071200.565181DC1@keescook>
References: <Z-SQdHZljwAgIlp9@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-SQdHZljwAgIlp9@kspp>

On Wed, Mar 26, 2025 at 05:40:36PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> net/mac80211/spectmgmt.c:151:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> net/mac80211/spectmgmt.c:155:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/mac80211/spectmgmt.c | 55 ++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
> index c6015cd00372..7422888d3640 100644
> --- a/net/mac80211/spectmgmt.c
> +++ b/net/mac80211/spectmgmt.c
> @@ -147,14 +147,14 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
>  	struct ieee80211_local *local = sdata->local;
>  	u32 control_freq, center_freq1, center_freq2;
>  	enum nl80211_chan_width chan_width;
> -	struct {
> -		struct ieee80211_he_operation _oper;
> -		struct ieee80211_he_6ghz_oper _6ghz_oper;
> -	} __packed he;
> -	struct {
> -		struct ieee80211_eht_operation _oper;
> -		struct ieee80211_eht_operation_info _oper_info;
> -	} __packed eht;
> +	DEFINE_RAW_FLEX(struct ieee80211_he_operation, he, optional,
> +			sizeof(struct ieee80211_he_6ghz_oper));
> +	struct ieee80211_he_6ghz_oper *_6ghz_oper =
> +				(struct ieee80211_he_6ghz_oper *)he->optional;
> +	DEFINE_RAW_FLEX(struct ieee80211_eht_operation, eht, optional,
> +			sizeof(struct ieee80211_eht_operation_info));
> +	struct ieee80211_eht_operation_info *_oper_info =
> +			(struct ieee80211_eht_operation_info *)eht->optional;

These are both packed, so any alignment issues with the trailing
structures would be pre-existing.

>  	const struct ieee80211_eht_operation *eht_oper;
>  
>  	if (conn->mode < IEEE80211_CONN_MODE_HE) {
> @@ -167,38 +167,38 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
>  	center_freq2 = chandef->center_freq2;
>  	chan_width = chandef->width;
>  
> -	he._oper.he_oper_params =
> +	he->he_oper_params =
>  		le32_encode_bits(1, IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
> -	he._6ghz_oper.primary =
> +	_6ghz_oper->primary =
>  		ieee80211_frequency_to_channel(control_freq);
> -	he._6ghz_oper.ccfs0 = ieee80211_frequency_to_channel(center_freq1);
> -	he._6ghz_oper.ccfs1 = center_freq2 ?
> +	_6ghz_oper->ccfs0 = ieee80211_frequency_to_channel(center_freq1);
> +	_6ghz_oper->ccfs1 = center_freq2 ?
>  		ieee80211_frequency_to_channel(center_freq2) : 0;
>  
>  	switch (chan_width) {
>  	case NL80211_CHAN_WIDTH_320:
> -		he._6ghz_oper.ccfs1 = he._6ghz_oper.ccfs0;
> -		he._6ghz_oper.ccfs0 += control_freq < center_freq1 ? -16 : 16;
> -		he._6ghz_oper.control = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
> +		_6ghz_oper->ccfs1 = _6ghz_oper->ccfs0;
> +		_6ghz_oper->ccfs0 += control_freq < center_freq1 ? -16 : 16;
> +		_6ghz_oper->control = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
>  		break;
>  	case NL80211_CHAN_WIDTH_160:
> -		he._6ghz_oper.ccfs1 = he._6ghz_oper.ccfs0;
> -		he._6ghz_oper.ccfs0 += control_freq < center_freq1 ? -8 : 8;
> +		_6ghz_oper->ccfs1 = _6ghz_oper->ccfs0;
> +		_6ghz_oper->ccfs0 += control_freq < center_freq1 ? -8 : 8;
>  		fallthrough;
>  	case NL80211_CHAN_WIDTH_80P80:
> -		he._6ghz_oper.control =
> +		_6ghz_oper->control =
>  			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
>  		break;
>  	case NL80211_CHAN_WIDTH_80:
> -		he._6ghz_oper.control =
> +		_6ghz_oper->control =
>  			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ;
>  		break;
>  	case NL80211_CHAN_WIDTH_40:
> -		he._6ghz_oper.control =
> +		_6ghz_oper->control =
>  			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ;
>  		break;
>  	default:
> -		he._6ghz_oper.control =
> +		_6ghz_oper->control =
>  			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ;
>  		break;
>  	}
> @@ -206,15 +206,14 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
>  	if (conn->mode < IEEE80211_CONN_MODE_EHT) {
>  		eht_oper = NULL;
>  	} else {
> -		eht._oper.params = IEEE80211_EHT_OPER_INFO_PRESENT;
> -		eht._oper_info.control = he._6ghz_oper.control;
> -		eht._oper_info.ccfs0 = he._6ghz_oper.ccfs0;
> -		eht._oper_info.ccfs1 = he._6ghz_oper.ccfs1;
> -		eht_oper = &eht._oper;
> +		eht->params = IEEE80211_EHT_OPER_INFO_PRESENT;
> +		_oper_info->control = _6ghz_oper->control;
> +		_oper_info->ccfs0 = _6ghz_oper->ccfs0;
> +		_oper_info->ccfs1 = _6ghz_oper->ccfs1;
> +		eht_oper = eht;
>  	}
>  
> -	if (!ieee80211_chandef_he_6ghz_oper(local, &he._oper,
> -					    eht_oper, chandef))
> +	if (!ieee80211_chandef_he_6ghz_oper(local, he, eht_oper, chandef))
>  		chandef->chan = NULL;
>  }

The leading "_" on the identifiers is a little weird, but it retains the
original convention. Conversions looks correct.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

