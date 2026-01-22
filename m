Return-Path: <linux-wireless+bounces-31086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAAlBftKcmnpfAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 17:06:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAED6983A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78C743006523
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3A4A340F;
	Thu, 22 Jan 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E9VDHUQj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F14ADD93
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097952; cv=none; b=gfTATTjfKy9enW2K675SdaJaWzq4PJsEKPMF8PJ2MiE6dqxIh878C0Zrm//U69xRC4gikZaYzDirPfBgRNFpnFts93INX1DJs/w70m60Qc/dzViEU5cKIqDGV8qLZsuGaI3qPyLksUrDihlT0F5AXylcMj2wnQjIwEgbGBQ2YHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097952; c=relaxed/simple;
	bh=LHfsYBfEAd8yYfXjEf9bj1zRRn+nQXx2ps8x8eYEdAI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1tPb7hqs8ddu/4r8cyvtCsNOYns/VcFQhvR6JoX6zFvbicXfxPcid4FV/ao4UVilXHTaaul8bvCf+PeZQBLuFnOxYo+eS5vBtZUj2rychBr+8sjVHFkLkf2fMTydlt5b+uo9d1B8KCtEbQYy4wumYfkSoAZRsMqukO1pgj+c2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E9VDHUQj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TB9y+SKqOgtu219pAzfRMS/i4csBNPv5d/gYp8Joj5c=;
	t=1769097949; x=1770307549; b=E9VDHUQjYDZfqEm2FmZwTx02sQy5IbjyrQPEIDHWEQp8GyF
	huv9wfzojpRFX/WHRMi5NuhM8OqsHxq9ihhmQRBPGYs7/54mTa6/NEA5FLliTTyKAAmbQL3Y0boql
	jKzu1mg2TCz3ZU70AA3rAPK5UFfXEzO0rXr3SEdNQYT/DnWWKEvWmGSaHdqAiDJMwBGVf2hJ65uXe
	8ulFLTSE/cJmyHCSDIzskeB2dYJIIFQsDNmK0/sYEiWeF3ItdvevS6YsLz1WDiSVr1Hjgd8yTxijO
	5b+I0ngzAh0Fp2vYDDzzQuJFhiSOVlceoNiJRgFoUMiaLuQIIubH009bvA1W66DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vixBl-00000000vbd-3RSR;
	Thu, 22 Jan 2026 17:05:41 +0100
Message-ID: <829488acfdbf7ecfe6418bfb2c5669dae18392ed.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: do not set 320MHz EHT capabilities on
 non 6GHz band
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 22 Jan 2026 17:05:41 +0100
In-Reply-To: <20260122145620.861355-1-nico.escande@gmail.com> (sfid-20260122_163621_176267_8452BF0E)
References: <20260122145620.861355-1-nico.escande@gmail.com>
	 (sfid-20260122_163621_176267_8452BF0E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31086-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EAED6983A
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 15:56 +0100, Nicolas Escande wrote:
> The spec (at least 802.11-be draft7) at section 9.4.2.323.3 says we shoul=
d
> not set the 320MHz related fields when not operating on a 6GHz band. It's
> quite explicit for most of them. For example:
>=20
> Bit 0 "Support For 320 MHz In 6 GHz" says "Reserved if the EHT
>       Capabilities element is indicating capabilities for the 2.4 GHz or
>       5 GHz bands."
>=20
> Bit 22-24 "Number Of Sounding Dimensions (=3D 320 MHz)" says "Reserved if
>           the SU Beamformer subfield is 0 or the Support For 320 MHz In
>           6 GHz subfield in EHT Capabilities Information field does not
>           indicate support for a bandwidth of 320 MHz."
>=20
> Bit 54 "Support Of EHT-MCS 15 In MRU" says about bit 3 "If 320 MHz is not
>         supported, then B3 is set to 0."
>=20
> For bit 13-15 "Beamformee SS (=3D 320 MHz)" it's not explicit, but it mak=
es
> little sense to special case the handling of this one.

Sure, but ...

> Fixes: 6239da18d2f9 ("wifi: mac80211: adjust EHT capa when lowering bandw=
idth")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  net/mac80211/util.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 0c46009a3d63..996983f6815b 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -4426,7 +4426,8 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
>  			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ;
>  	}
> =20
> -	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320) {
> +	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 ||
> +	    sband->band !=3D NL80211_BAND_6GHZ) {
>  		fixed.phy_cap_info[0] &=3D
>  			~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>  		fixed.phy_cap_info[1] &=3D

How does this make any sense? The driver should just not advertise the
bit on its 2.4 and 5 GHz sbands?

johannes

