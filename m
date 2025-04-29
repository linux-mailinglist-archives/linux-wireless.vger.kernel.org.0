Return-Path: <linux-wireless+bounces-22204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F368AA14B0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20074C4580
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15DC2528FC;
	Tue, 29 Apr 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AkmyTe4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6921ABDB;
	Tue, 29 Apr 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946971; cv=none; b=RsnAdYadY5XEHjnq+4UK30BPWntuT6xj8WifC0YmKk+RAcSZxxWo2Aqf/baNvKLnLsr+PsfbBgiNdfWKIIY3+KXH3Z5KEG5mshcC/3xDuwtTmL6rBsYEoOD+LoRR4497rD74KPzuLTfPwFCWM1ZQ4gBlGAOcyAzXY2qVd69pD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946971; c=relaxed/simple;
	bh=zIESig/sdrklC2QUfMKBiME2VbHq59qP0ORH722HL7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvWxPqe6av00c4G8tdI5yfczTwqXZ88s/A+Naczih3L7FPfDX3zaBURJbp2kQMjRS6ZsKVVtEqmqVXZNfhyGKwhGQtFG+ltydaSz8axZJnnDi4WTY8kVv0KPoiEkJauxf1Y6AXM6v/UG+8uL/fw+hJ4f9ZMggaErXGomOGD5Ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AkmyTe4S; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id A168940594EB;
	Tue, 29 Apr 2025 17:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A168940594EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1745946959;
	bh=21UY7oxPFE0GjMY5Q/rd+zUU7x2/+gFe8bBEGUI2oK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkmyTe4S+FnsWis9+pOeopoZ4A36Nc4bjGDcH5QIdwaqn8X0k+koCDis48Hy2EGFU
	 OpoYiH2oxRClVixqMR7ynwnNxgPzKlbpzV2k2YN9NaS2GA869flI30t8mTQ9hSl8cN
	 kWH9ydXfeAqd7FcxuuArRr82H8CXFz81Mitu0pYY=
Date: Tue, 29 Apr 2025 20:15:59 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Alexei Safin <a.safin@rosa.ru>
Cc: lvc-project@linuxtesting.org, netdev@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] iwlegacy: 4965: fix possible out-of-bounds access in
 il4965_tx_cmd_build_rate()
Message-ID: <d57qkj2tj4bgfobgzbhcb4bceh327o35mgamy2yyfuvolg4ymo@7p7hbpyg5bxi>
References: <20250424185244.3562-1-a.safin@rosa.ru>
 <20250427063900.GA48509@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250427063900.GA48509@wp.pl>

Hello,

On Sun, 27. Apr 08:39, Stanislaw Gruszka wrote:
> > diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > index 78dee8ccfebf..f60d9b9798c1 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> > @@ -1572,7 +1572,7 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
> >  	 */
> >  	rate_idx = info->control.rates[0].idx;
> >  	if ((info->control.rates[0].flags & IEEE80211_TX_RC_MCS) || rate_idx < 0
> > -	    || rate_idx > RATE_COUNT_LEGACY)
> > +	    || rate_idx >= RATE_COUNT_LEGACY)
> >  		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
> 
> .. so looks the check is fine already and changing it will induce a bug
> for RATE_54M_INDEX.
> 
> Regards
> Stanislaw
> 
> >  	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
> >  	if (info->band == NL80211_BAND_5GHZ)

Here goes the fragment:

		rate_idx += IL_FIRST_OFDM_RATE;
	/* Get PLCP rate for tx_cmd->rate_n_flags */
	rate_plcp = il_rates[rate_idx].plcp;

> > -- 
> > 2.39.5 (Apple Git-154)
> > 

Looks like the proper checks should be added to address the 5GHZ case and
validate that the index won't exceed the array boundaries after being shifted
by IL_FIRST_OFDM_RATE.

--
Thanks,
Fedor

