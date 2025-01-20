Return-Path: <linux-wireless+bounces-17751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC1A16B5F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 12:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6323A5EA9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F01B4F02;
	Mon, 20 Jan 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Zmp9hjhV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9E167DAC;
	Mon, 20 Jan 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371918; cv=none; b=a+TyMJ9GK6g5czWr8QHnQnVH4db9wciZ5zW68b1wTxCtrJQCLTjxqS6sydm76IoGsTwPCf8j6p+HUic3ByAQr8EtIc2x60IXFIH3WaWbgcA8GRD7sq7MNfe7jd6ofqLfp9JNBpt0BY71jAGz61ZNCTqg5LciiUrW+4xVF90QDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371918; c=relaxed/simple;
	bh=t8lbNI8l8J6K8X/eX/eTvMGEXbRIqa3MAyfuLyY4LBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui2hapd/5S8Hnnt3QVYY7jAuaHbRiLOC39Yp+w37mKFNZWGcRvlBBjK8ngVo+rAf6JkuP2Hd0HiDfjZfAMY0GICMZlTBLplbvQQll3aoHlcviHMjyXXdck2Ws9A9QX8egPr5VbSH7dykTVAMMgiI9OHZS4efBfqGULcqED1Mno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Zmp9hjhV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1C44E1FC0F;
	Mon, 20 Jan 2025 12:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1737371536;
	bh=AmRqvCfczjNBxPeTdKZqx5x0NqI8hK/m2GHaetg4oPo=;
	h=Received:From:To:Subject;
	b=Zmp9hjhVx745w2orzuWU+CXWghsmvavFtV9yMBVaLMJP0s8MXk5xjiFD5oSB5Bql8
	 H3YncaOtJUpM5An/isWtUFzNM2a988j2NkodVrt6iLiRkOpHoFx/MDoxHYjw65n0B1
	 faBgIO8Ifss8w421NfgUK3mkC7A7T8vHEGsXwb/V+CPd9JhJ73vsI8Ntx8lm1cwjqi
	 qo0DThHxlLkqRTpMSoXyIvD0AtRpsM5cyqAzkyv8MV9lg4VCO/e1r2WwMLGVNxd9TP
	 kPu4RL/2agzgzxBp5I+XtzgJ8SCOeuvg+6b/ufFfSnpc6aPYbJdnGRTPxNkzLKWWp8
	 hNBGA2dLE+6Yg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id C0D177F96E; Mon, 20 Jan 2025 12:12:15 +0100 (CET)
Date: Mon, 20 Jan 2025 12:12:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware setting for
 HT40.
Message-ID: <Z44vj59nWIiswq7s@gaggiata.pivistrello.it>
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
 <20250120074011.720358-2-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120074011.720358-2-jeff.chen_1@nxp.com>

Hello Jeff,
thanks for the patch.

On Mon, Jan 20, 2025 at 03:40:11PM +0800, Jeff Chen wrote:
> Add the missing bandwidth configuration for HT40.

Can you expand this a little bit?

- Is this a regression?
- What is the impact of this missing configuration? It's not working at all?
  It's working in some unexpected way (please explain)?
- Should this backported to stable (probably given the answer before it should
  be obvious the answer to this question)?

Anything else worth mentioning?

> 
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/11n.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
> index 66f0f5377ac1..4ae0b4aaa09a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n.c
> @@ -308,7 +308,7 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
>  	int ret_len = 0;
>  	struct ieee80211_supported_band *sband;
>  	struct ieee_types_header *hdr;
> -	u8 radio_type;
> +	u8 radio_type, secch_offset;
>  
>  	if (!buffer || !*buffer)
>  		return ret_len;
> @@ -401,13 +401,15 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
>  		chan_list->chan_scan_param[0].radio_type =
>  			mwifiex_band_to_radio_type((u8) bss_desc->bss_band);
>  
> -		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> -		    bss_desc->bcn_ht_oper->ht_param &
> -		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
> -			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
> -					  radio_type,
> -					  (bss_desc->bcn_ht_oper->ht_param &
> -					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
> +		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
> +			if (bss_desc->bcn_ht_oper->ht_param & IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
> +				chan_list->chan_scan_param[0].radio_type |= (CHAN_BW_40MHZ << 2);

setting `radio_type |= (CHAN_BW_40MHZ << 2)` seems the only real change on this
patch, correct? Anything else is cosmetic, correct?

would doing just this change be equivalent, right?

	SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
			  radio_type | (CHAN_BW_40MHZ << 2),
			  (bss_desc->bcn_ht_oper->ht_param &
			  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));


Francesco


