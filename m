Return-Path: <linux-wireless+bounces-17033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE1A0065B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5042C18830B4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247661CD210;
	Fri,  3 Jan 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="1n7oKvDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DA1B0F33
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894781; cv=none; b=ur4HyXpV1rtbEGT5IO3KpMoObhM6NOvZmopQUkFiDWqDgXuco2BpetOKLRgzf249hEKPzQi2LoHGRZMlHBQERVOm/l5+d4/zk2YIAZUpi/ITGtVHcY51wzBJaSGW+hs5YRI928JXdbk+Gxxo8knNzmmvLBMK8cHYfZLi7V5nLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894781; c=relaxed/simple;
	bh=qUPRZskHJ+euSey/AbshsXeYOEOd9FooAV00nZdOEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7o3q/1mUbxEiUUgHEh65PyvFN8/Hah1u1AawfABnoT3pX12qhfojz8ZqIV6UgHtYHmbcynyQGhWmfZ1BTZchC73OilCSTTJ76Qr1jSE4VvRAA1fchyAduBdW57LEN2xVrcpSHJHK3q65ms2jpau5jQX2Ix3b/dtclcg2zZn7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=1n7oKvDN; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 34948 invoked from network); 3 Jan 2025 09:59:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1735894774; bh=/6yQLG0zTD1VR1PmHShGmYEioog5lHSHwLvLNKfLPLA=;
          h=From:To:Cc:Subject;
          b=1n7oKvDNnVxaMVmRIJKrHTPk0ORrMuwzU53cQyFe+KLn+lpQz6Ncs0cJVxA3v12BD
           RhdCd4bSsXPEJ6GLZMPkhsxi4CTk1NNnYh8y+dTkDS0bbw5KEi2xkRQu/csKNioGz1
           7Kar3YsB2cpBklg7SURuGAohNpjquKPkpUxjgtGFJhgUILMeoaxGf4cLHzOgUoRmMi
           vQLJcKm13Eu2PuKw0t+/kUnlf51gOwFtZOsAKMrjckMnJxovJ92XpqzFa9lnqYXFJv
           4tZqWzR3YCS6gWgSTm0yipdpVHsSG/g/0iFzi2uII5sHjsdqgjb73GVctuEwqOn/vP
           b/wlRKwtfjxUg==
Received: from 89-64-0-140.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.140])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux@treblig.org>; 3 Jan 2025 09:59:34 +0100
Date: Fri, 3 Jan 2025 09:59:34 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux@treblig.org
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: iwlegacy: Remove unused
 il_get_single_channel_number
Message-ID: <20250103085934.GC94204@wp.pl>
References: <20241226011355.135417-1-linux@treblig.org>
 <20241226011355.135417-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226011355.135417-3-linux@treblig.org>
X-WP-MailID: 615016b2ae563662b85b48cd4b21a0e1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8bP0]                               

On Thu, Dec 26, 2024 at 01:13:55AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> THe last use of il_get_single_channel_number() was removed in 2011 by
> commit dd6d2a8aef69 ("iwlegacy: remove reset rf infrastructure")
> when it was still called iwl_legacy_get_single_channel_number.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 31 --------------------
>  drivers/net/wireless/intel/iwlegacy/common.h |  1 -
>  2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 958dd4f9bc69..af4f42534ea0 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -3915,37 +3915,6 @@ il_set_rxon_ht(struct il_priv *il, struct il_ht_config *ht_conf)
>  }
>  EXPORT_SYMBOL(il_set_rxon_ht);
>  
> -/* Return valid, unused, channel for a passive scan to reset the RF */
> -u8
> -il_get_single_channel_number(struct il_priv *il, enum nl80211_band band)
> -{
> -	const struct il_channel_info *ch_info;
> -	int i;
> -	u8 channel = 0;
> -	u8 min, max;
> -
> -	if (band == NL80211_BAND_5GHZ) {
> -		min = 14;
> -		max = il->channel_count;
> -	} else {
> -		min = 0;
> -		max = 14;
> -	}
> -
> -	for (i = min; i < max; i++) {
> -		channel = il->channel_info[i].channel;
> -		if (channel == le16_to_cpu(il->staging.channel))
> -			continue;
> -
> -		ch_info = il_get_channel_info(il, band, channel);
> -		if (il_is_channel_valid(ch_info))
> -			break;
> -	}
> -
> -	return channel;
> -}
> -EXPORT_SYMBOL(il_get_single_channel_number);
> -
>  /*
>   * il_set_rxon_channel - Set the band and channel values in staging RXON
>   * @ch: requested channel as a pointer to struct ieee80211_channel
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 725c2a88ddb7..92285412ab10 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -1705,7 +1705,6 @@ int il_full_rxon_required(struct il_priv *il);
>  int il_set_rxon_channel(struct il_priv *il, struct ieee80211_channel *ch);
>  void il_set_flags_for_band(struct il_priv *il, enum nl80211_band band,
>  			   struct ieee80211_vif *vif);
> -u8 il_get_single_channel_number(struct il_priv *il, enum nl80211_band band);
>  void il_set_rxon_ht(struct il_priv *il, struct il_ht_config *ht_conf);
>  bool il_is_ht40_tx_allowed(struct il_priv *il,
>  			   struct ieee80211_sta_ht_cap *ht_cap);
> -- 
> 2.47.1
> 

