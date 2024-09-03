Return-Path: <linux-wireless+bounces-12378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542EB9699B3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F091E1F213A7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299DD17C9B3;
	Tue,  3 Sep 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dYbnM530"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506B1A0BF7
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357879; cv=none; b=qThh5CmLKfBy5ejfvNbQY+r3DZs5gMHDuldz1X6GfR1O+IZFla7fzxV/So45vkII6q1w9Kz/F1V/O1e0zNsio0K1OOMfqhMrgtGdAqtbCyj/YwesAA9WndYmjnCt0vSXlWm2O1A3aDWWJHiSfcvc1oT0bos4wy17ugy/QxPRto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357879; c=relaxed/simple;
	bh=vCTABZ4zw42O+Hb3V14RKywAqZiE1UJZ6fs5bcvpnrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtBkETpCNMDGnnu8Io3Whox0YTS3ZxicbMJqL2/AAHm2A3wGjmIGBU7oMDNX2Eq4dOA82YpEufSiM4bJyxpSSF0AHEqkvL+18FnAPXVmRiRitsOi07yKzIqRKsaoSngVNqqFpluxOQx3uN4y5pD6ic9QgOGBfftRgv58ioX9Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dYbnM530; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kHIc4XlgdnV2E+f1jIwX2EPdPvN0pMAS4hckU2RCjsA=;
	t=1725357877; x=1726567477; b=dYbnM530ql5z2V5BuavI2p0DKNrXM1bXB0EcqowGre/SK3B
	ZqLQ4ayUyLlHc5wHDyQhxKZhze7BV7mKR8a5Me/jPuGLY8KD1zC1lQCi2I/pYfaKJgNjooC0OZn97
	mzyhX/mO0m0PYLum0ELDlYd7vAP7HTVyFtivwSmM1O/unsp3wAy4S3krNi42VsLQ2UMbz1oNMtfbv
	vT+0u+WmEi1sEImXNbwxm3PGPJpKIZw1baYjgL2O5/cEWDPS53W/awpAnExj4heP1qr36LT4qCxtM
	z0ritQw1Z5+1MsPwxZrAv0dGNgjIkbCs2hulDnEgIKsimbJ0sarKjHMKJhVKoDiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slQOo-00000002CSu-0a8m;
	Tue, 03 Sep 2024 12:04:34 +0200
Message-ID: <807fe0b60e727ea927cb12a75f874698a1798723.camel@sipsolutions.net>
Subject: Re: [PATCH v5 8/8] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 03 Sep 2024 12:04:33 +0200
In-Reply-To: <20240902064847.2506090-9-quic_adisi@quicinc.com>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
	 <20240902064847.2506090-9-quic_adisi@quicinc.com>
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

On Mon, 2024-09-02 at 12:18 +0530, Aditya Kumar Singh wrote:
>=20
> @@ -3482,7 +3487,18 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_loc=
al *local)
>  		     link_id++) {
>  			link_data =3D sdata_dereference(sdata->link[link_id],
>  						      sdata);
> -			if (!link_data)
> +			link_conf =3D
> +				rcu_dereference(sdata->vif.link_conf[link_id]);
> +			if (!link_data || !link_conf)
> +				continue;

Can you not use link_data->conf?

> +			chanctx_conf =3D
> +				rcu_dereference_protected(link_conf->chanctx_conf,
> +					  lockdep_is_held(&local->hw.wiphy->mtx));

sdata_dereference or wiphy_dereference or whatever, please don't open-
code it.

> +			if (!chanctx_conf)
> +				continue;

This changes the previous behaviour, is that OK?

> +			if (ctx && &ctx->conf !=3D chanctx_conf)
>  				continue;

You don't even need the check if you have this though.

> @@ -3491,11 +3507,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_loc=
al *local)
>  			if (!sdata->wdev.links[link_id].cac_started)
>  				continue;
> =20
> -			link_conf =3D
> -				rcu_dereference(sdata->vif.link_conf[link_id]);
> -			if (!link_conf)
> -				continue;

Actually link_data->conf comment already applies to an earlier patch
then, and it might be better to just remove the link_conf entirely, and
call the link_data just "link" like in more places. That's in patch 6
already.

> +static void
> +ieee80211_radar_mark_chan_ctx_iterator(struct ieee80211_hw *hw,
> +				       struct ieee80211_chanctx_conf *chanctx_conf,
> +				       void *data)
> +{
> +	struct ieee80211_chanctx *ctx =3D
> +		container_of(chanctx_conf, struct ieee80211_chanctx,
> +			     conf);
> +	struct ieee80211_chanctx_conf *itr_data =3D
> +		(struct ieee80211_chanctx_conf *)data;

The cast isn't needed. But you don't even really need the "itr_data"
variable since you never dereference it.

johannes

