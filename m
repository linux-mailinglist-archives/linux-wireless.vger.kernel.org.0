Return-Path: <linux-wireless+bounces-23111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B16ABAA04
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 14:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E6F3A2A3E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEA1FC0F0;
	Sat, 17 May 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="b2SsUhlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E11E4BE;
	Sat, 17 May 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747484476; cv=none; b=tukVNjlWahTSFJpzptRnWt3+j8zsbErVdyPo53hQlA8QoTcRpc9L9f2ZUDdA4dsaXxCtqBUgatdMN30s22+1exomp8Yd51kONGHq97N/D+DfUoFbDUjJY3kk+sCS6i8lQ8VTJ60tJ4v7A44V95HCdCk/pAqA0y9Xdrt0oeTP7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747484476; c=relaxed/simple;
	bh=l/GKdNs2n3c+2P7UHIu1YttCo+lljn7T91JrelRRofQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihLU9/E7p1hGJs1t/1aHuXnG7WUV8kUFFi36hHcmKle4Vdqz3rFYJCcFn53yxFbq3Taxh/SNxMkdhwojPuz03PB6GlYcwpkQRpSCJAtuoDOqllohg51YhbwJRU7ZBWFOX0ddPUG1C/HNt+6YVMa0jFVT7zArItkLQnx7DUAKbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=b2SsUhlm; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9A791552F55C;
	Sat, 17 May 2025 12:21:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9A791552F55C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1747484463;
	bh=sd+U3YFqzk1RpnzvJolI6XDMfp42yhZlNKOwpVmal5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2SsUhlmTX4gkIlerxaK4I8cvRmhMh0dt/rr90e1mfgH8nCE/TVkBnEcMfwHaVDa0
	 Tyn5l9+ZNG9UKU0QbjIk0PaWKnGsAJv8yjBdOhNiULFt9jI0KJqqp8yOcLIOHeXFiP
	 PUxbWdYXUxwL5PXe0bYcIyAlpYDJp7IgehlVo5tw=
Date: Sat, 17 May 2025 15:21:03 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Alexei Safin <a.safin@rosa.ru>, lvc-project@linuxtesting.org, netdev@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] wifi: iwlegacy: Check rate_idx range after addition
Message-ID: <hrpy3omokg5zvrqnchx4jvp26bvfgdrashkmrjonsyz5b64aaz@6d5kn7z7x73q>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
 <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
 <20250517074040.GA96365@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517074040.GA96365@wp.pl>

On Sat, 17. May 09:40, Stanislaw Gruszka wrote:
> Move rate_idx range check after we add IL_FIRST_OFDM_RATE for it
> for 5GHz band.
> 
> Additionally use ">= RATE_COUNT" check instead of "> RATE_COUNT_LEGACY"
> to avoid possible reviewers and static code analyzers confusion about
> size of il_rate array.
> 
> Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Reported-by: Alexei Safin <a.safin@rosa.ru>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---

Thank you for the patch, Stanislaw!

Please see some comments below.

>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index dc8c408902e6..2294ea43b4c7 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -1567,16 +1567,19 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
>  	/**
>  	 * If the current TX rate stored in mac80211 has the MCS bit set, it's
>  	 * not really a TX rate.  Thus, we use the lowest supported rate for
> -	 * this band.  Also use the lowest supported rate if the stored rate
> -	 * idx is invalid.
> +	 * this band.
>  	 */
>  	rate_idx = info->control.rates[0].idx;
> -	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
> -	    || rate_idx > RATE_COUNT_LEGACY)
> +	if (info->control.rates[0].flags & IEEE80211_TX_RC_MCS)
>  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
> -	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> -	if (info->band == NL80211_BAND_5GHZ)
> +	else if (info->band == NL80211_BAND_5GHZ)

5GHZ shouldn't be in 'else if' clause, I think. Is it mutually exclusive
with IEEE80211_TX_RC_MCS ?

> +		/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
>  		rate_idx += IL_FIRST_OFDM_RATE;
> +
> +	/* Use the lowest supported rate if the stored rate idx is invalid. */
> +	if (rate_idx < 0 || rate_idx >= RATE_COUNT)

There is a check inside il4965_rs_get_rate():

	/* Check for invalid rates */
	if (rate_idx < 0 || rate_idx >= RATE_COUNT_LEGACY ||
	    (sband->band == NL80211_BAND_5GHZ &&
	     rate_idx < IL_FIRST_OFDM_RATE))
		rate_idx = rate_lowest_index(sband, sta);

so RATE_COUNT_LEGACY (60M) is considered invalid there but is accepted
here in il4965_tx_cmd_build_rate(). It looks strange, at least for the
fresh reader as me..

> +		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
> +
>  	/* Get PLCP rate for tx_cmd->rate_n_flags */
>  	rate_plcp = il_rates[rate_idx].plcp;
>  	/* Zero out flags for this packet */
> -- 
> 2.25.4

