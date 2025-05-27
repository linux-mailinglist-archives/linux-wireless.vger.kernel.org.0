Return-Path: <linux-wireless+bounces-23445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73587AC5A8B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FA94A7C22
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6651F8728;
	Tue, 27 May 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jk53t04T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C53193077;
	Tue, 27 May 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373447; cv=none; b=lPRK4FTe2y+/U/nxNSiGzf4MgwqI0t/ncNMQ30jpbBr4VvneFZ/EgcgGiBE0+NTSkk1rYK3lsGkDHF1lhjImTp04AplDhZwcaBNH4zaiUbVpR9oC5RStu1tRe3WH0TLaVr756bNJ157zqDEctmuYumvV5arTi15NzIFxFtijbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373447; c=relaxed/simple;
	bh=whL84rT5cgB0gTkk/wdEmU1XcUHt3i2RXeLFKm8nK6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/gOayRTjzw0I2qtJgaJDtY4dratqiiYNLBiyQCqgHYKdPmyw6mmdJocxHmqULtohUpIWY80dZUom6NdEs+FoTK3hTAfbobhfLBQWFIJziGiQAVVXOQP0umP/DI9e7iaAI/2gnolJdMuuRr8jJ2ubjV+8aMirNG1rjt61q55BoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jk53t04T; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.23])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6B781407616F;
	Tue, 27 May 2025 19:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6B781407616F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748373433;
	bh=4K/5g0rz8lGjbxpjjfKHeGpy/D2jGPVIXZxPSOkdpBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jk53t04T4Bj2Jrn/ZlSQH45/VJNFdX3l1EdgKE7krvlnZouNwYt+FspIVKSK5vEkk
	 PlQMJtoffqbvVZSkwfD+Rq8gZ0LWpbLVp8ubhO91Wx5L2TVcq6nyhlsqCjFxm5Wo2u
	 lBfdofVwMGcWTsihG4laHjAFjZB9l91ezi+ko2bo=
Date: Tue, 27 May 2025 22:17:13 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Alexei Safin <a.safin@rosa.ru>, lvc-project@linuxtesting.org, netdev@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] wifi: iwlegacy: Check rate_idx range after addition
Message-ID: <5woqb2ipm4scei365wlo4rupczolhwtbwnw2djhkvi6qcrz2q2@eykv3a3v62lu>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
 <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
 <20250517074040.GA96365@wp.pl>
 <hrpy3omokg5zvrqnchx4jvp26bvfgdrashkmrjonsyz5b64aaz@6d5kn7z7x73q>
 <20250525144524.GA172583@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250525144524.GA172583@wp.pl>

On Sun, 25. May 16:45, Stanislaw Gruszka wrote:
> Limit rate_idx to IL_LAST_OFDM_RATE for 5GHz band for thinkable case
> the index is incorrect.
> 
> Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Reported-by: Alexei Safin <a.safin@rosa.ru>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
> v1 -> v2: 
>  - just add check one possible case the index could be incorrect,
>    instead of doing broader changes.
> 
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index dc8c408902e6..4d2148147b94 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -1575,8 +1575,11 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
>  	    || rate_idx > RATE_COUNT_LEGACY)
>  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
>  	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> -	if (info->band == NL80211_BAND_5GHZ)
> +	if (info->band == NL80211_BAND_5GHZ) {
>  		rate_idx += IL_FIRST_OFDM_RATE;
> +		if (rate_idx > IL_LAST_OFDM_RATE)
> +			rate_idx = IL_LAST_OFDM_RATE;
> +	}
>  	/* Get PLCP rate for tx_cmd->rate_n_flags */
>  	rate_plcp = il_rates[rate_idx].plcp;
>  	/* Zero out flags for this packet */
> -- 
> 2.25.4
> 

Thanks, Stanislaw!

To my mind, it looks reasonable. FWIW,

Reviewed-by: Fedor Pchelkin <pchelkin@ispras.ru>

