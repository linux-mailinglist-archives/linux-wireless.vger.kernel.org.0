Return-Path: <linux-wireless+bounces-19583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7AA49A38
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBAB3AB2A7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BC26B2B5;
	Fri, 28 Feb 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FtWHZPOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA9261579
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748065; cv=none; b=j/pRG5MDZI2iN7nNHdhwy2PFeOQtO/J91+5qsBuxHJ4SVPqRb0LXhHypYRggFnn32wnzPpFo/+GJ9pyfxclEEtwNikmUx/ukO6CiprbsTDERQGFvznIC4/ZOkhvOBqDORGTiulGgGGjuEQsk+f70cRMqBlshILGrb/wbTVQJWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748065; c=relaxed/simple;
	bh=Uq1h+69+qYmUC9sParZp2ddH0EktnCvKVE9q6U8BVxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPfO6K/YcDHRV0SENXCRB88Xx3RmgN/WiCSXenXoEkPihK5QchC/a3ALjX3sWI5IresKvvGtFrFOB7vcq9op6zEbr/n6SmDLOyMFb4LzqK5Fnw0B5poVp2EeCOqutRLcJSvZwSvEMrn31AD1OiXBEwkEXSJWTlLsfpaqHmnMUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FtWHZPOp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gZ+p23IhPGjhdfkt5MnaRPC+cPVhMnkKfjG6wjjrmJQ=;
	t=1740748063; x=1741957663; b=FtWHZPOpYE0A7Y9pE9Zd4H/TJiIA4+xE9yye1/AUqTkI/zX
	lzFehzj6IExRiv8iAYo+YbreAWy1iA7LcnQcUh1PIf6IH2mTZVlz6ObaMmMJ5+7/29+vq4vjZRr6x
	ZD/M//yqbf9Kes0T/EeWVtDLo3D2wBgCG0I4ZY+Hk8lrX9LJlY+6gTSrAlikHZ7rSg+YXCq6FNjx1
	nm+ldVPhflS8J18vu4KTPOidPt+P2FNhUyvFrOaaIIK0K61s7fMd9kad+abgrOpBvx8l6P6GZlwev
	7pUC6u0d8vG3l09gXJ07yucrj6Ff/KCjOvfEKyedPYjsesTJcy2DpCA2Pv1SbN2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to05c-0000000DkV3-2KdB;
	Fri, 28 Feb 2025 14:07:40 +0100
Message-ID: <497038580b4a41221616070dfe0f42a69ce47b75.camel@sipsolutions.net>
Subject: Re: [PATCH v4 3/5] wifi: mac80211: Set RTS threshold on per-radio
 basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:07:39 +0100
In-Reply-To: <20250129155246.155587-4-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-01-29 at 21:22 +0530, Roopni Devanathan wrote:
>=20
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> @@ -126,7 +126,7 @@ struct iwl_mvm_time_event_data {
>   /* Power management */
> =20
>  /**
> - * enum iwl_power_scheme
> + * enum iwl_power_scheme - enum iwl power sceme set by debugfs

How does that belong here?!

> +++ b/net/mac80211/cfg.c
> @@ -3038,7 +3038,13 @@ static int ieee80211_set_wiphy_params(struct wiphy=
 *wiphy, u8 radio_id, u32 chan
>  	}
> =20
>  	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
> -		err =3D drv_set_rts_threshold(local, wiphy->rts_threshold);
> +		u32 rts_threshold;
> +
> +		if (radio_id >=3D wiphy->n_radio)
> +			rts_threshold =3D wiphy->rts_threshold;
> +		else
> +			rts_threshold =3D wiphy->radio_cfg[radio_id].rts_threshold;
> +		err =3D drv_set_rts_threshold(local, radio_id, rts_threshold);

Should we really just leave it all up to the driver, or perhaps call it
multiple times for each radio? Dunno.

> @@ -715,8 +716,14 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *t=
x)
>  		    tx->sdata->vif.type =3D=3D NL80211_IFTYPE_OCB);
> =20
>  	/* set up RTS protection if desired */
> -	if (len > tx->local->hw.wiphy->rts_threshold) {
> -		txrc.rts =3D true;
> +	if (tx->local->hw.wiphy->n_radio) {
> +		for (i =3D 0; i < tx->local->hw.wiphy->n_radio; i++) {
> +			if (len > tx->local->hw.wiphy->radio_cfg[i].rts_threshold)
> +				txrc.rts =3D true;
> +		}
> +	} else {
> +		if (len > tx->local->hw.wiphy->rts_threshold)
> +			txrc.rts =3D true;
>  	}

Are you sure you need this? Seems odd to me.

> +static ssize_t rts_threshold_read(struct file *file, char __user *user_b=
uf,
> +				  size_t count, loff_t *ppos)

I'm not convinced it's worth keeping this at all since you can retrieve
it via nl80211?

johannes

