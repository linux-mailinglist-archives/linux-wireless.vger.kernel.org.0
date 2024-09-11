Return-Path: <linux-wireless+bounces-12787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4724974ED7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7601F28C2E6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E514D2A6;
	Wed, 11 Sep 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hFbUxnhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551845C18
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047594; cv=none; b=LDNRK6NvApFhgPSELKJbU2ITbqLjiv4uEeS+jJxpAI1fER4K4RNW+kygTlKzRnN2POpyHxO2KuOA7FPdDgRIKwC0jrw204Fz8HZfmruj0f6ZLuTFz7g4lQecXK7XHZHfTwzRXMtvGtik40KtDrB2YKZm3kkGyi1eSTPbGfvLHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047594; c=relaxed/simple;
	bh=vmyAUrCKnervdNwZrYxfMaS+TenGlOYCfSjBkgFq8kg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huhHfhn9R1UzdiPX/HyDOxomHM6HnJLCqn9dgLXC7pNlLrtustQlBllBVWeOhi58kun4oM053IlzMzXY+zqVGS8YCHdBDOn8yCzV9CRFu5BzhNUdJQcFcUQjNHUhww57wEFx/LxHw84dQFitK8lFPilPRmASpFuSRBA5Dlwarhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hFbUxnhx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hgMHorFs88GmyQyCaFSPSomfHtumJ8ru5Jf8j4bxXy4=;
	t=1726047592; x=1727257192; b=hFbUxnhxgBk5YLqGpulEQhGPYFF31Z2tWn7ez2orRZHyzsK
	RmgpzPBdkUONj1kF7eXcwOaKEFGl3lEQR50X3MAFXaR51eLTEW+uGobnxKu3VkuhdPOkp04m2VLp/
	jCqfEmP88CbhzBMkwiZ1H8PsgYnG8Vuk+t5caysuwsbYTRdLdL3y7+2/jmLCoShlWDteK8zrmlY4P
	j0OzsrKmZMUKndOUrBRGB5cyHZ/Gm3kwPPpViadjskpgzBqA9smWIS3YMBnqgcF0Ws67CtX0tQXAN
	s4xnfNaInAd02ZFIwkIcnotpPUioLay2KgD9ArhZNx7CrXMCK5a4kLc1835zVgGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soJpF-00000008bly-0RM3;
	Wed, 11 Sep 2024 11:39:49 +0200
Message-ID: <0f29f8befa24fb802fcee0d77662707a5b3a089e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: restructure vif and link conf for
 mlo mbssid support
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Wed, 11 Sep 2024 11:39:48 +0200
In-Reply-To: <20240910204538.4077640-3-quic_msinada@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
	 <20240910204538.4077640-3-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-09-10 at 13:45 -0700, Muna Sinada wrote:
>=20
> +++ b/include/net/mac80211.h
> @@ -682,6 +682,8 @@ struct ieee80211_parsed_tpe {
>   *	responder functionality.
>   * @ftmr_params: configurable lci/civic parameter when enabling FTM resp=
onder.
>   * @nontransmitted: this BSS is a nontransmitted BSS profile
> + * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is en=
abled.
> + * @mbssid_tx_vif_linkid: Link id of Tx link for non-Tx link.

It seems it might be simpler to link to the ieee80211_bss_conf? You can
derive all from that (vif and link ID), but it's probably simpler than
having to do lookups (RCU or protected etc.) based on the link ID? And
we can guarantee that the pointer lifetime is valid, so I guess don't
need to RCU protect it?

But otherwise, also again, need to document non-MLO values. Probably
want 0 not -1 as you did, otherwise driver always needs to check to get
to bss_conf.

> +++ b/net/mac80211/cfg.c
> @@ -142,8 +142,10 @@ static int ieee80211_set_ap_mbssid_options(struct ie=
ee80211_sub_if_data *sdata,
>  					   struct ieee80211_bss_conf *link_conf)
>  {
>  	struct ieee80211_sub_if_data *tx_sdata;
> +	struct ieee80211_link_data *tx_link;
> =20
> -	sdata->vif.mbssid_tx_vif =3D NULL;
> +	link_conf->mbssid_tx_vif =3D NULL;
> +	link_conf->mbssid_tx_vif_linkid =3D -1;
>  	link_conf->bssid_index =3D 0;
>  	link_conf->nontransmitted =3D false;
>  	link_conf->ema_ap =3D false;
> @@ -157,9 +159,25 @@ static int ieee80211_set_ap_mbssid_options(struct ie=
ee80211_sub_if_data *sdata,
>  		return -EINVAL;
> =20
>  	if (tx_sdata =3D=3D sdata) {
> -		sdata->vif.mbssid_tx_vif =3D &sdata->vif;
> +		link_conf->mbssid_tx_vif =3D &sdata->vif;
> +		link_conf->mbssid_tx_vif_linkid =3D link_conf->link_id;
>  	} else {
> -		sdata->vif.mbssid_tx_vif =3D &tx_sdata->vif;
> +		rcu_read_lock();

No, absolutely not. Please review this with someone who understands RCU,
I'll stop here now.

johannes


