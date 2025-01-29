Return-Path: <linux-wireless+bounces-18118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451AA2184B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962727A2C55
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3D198A36;
	Wed, 29 Jan 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QrDK1JCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB919580F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136480; cv=none; b=NSN11uRD6CN5JFZNbTrTAbhub4f2QcgkskrZpxiPGco0hXotCP+FhXW7r6S2dK38V4SszwdYVRnk8BnTysgqqdhH8kjuD1uooscZ6zTknZW0um8shF5CJclWxg+39URoTXFjP778RHud6oTeVmslquEObg5WZFb2sisnmyMpDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136480; c=relaxed/simple;
	bh=rPcZoDTD+PVg/3yLFFxyT9QCmh7BS/93HXZkW06hW68=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsatdY4SwfmIzvd9H4dm5oAdKgfikA+yNdd9lSgw+NN8bz+30gKt25iwUAl2wvCQlrcBv1kFQ4SrKFnZVsRWO804jv/TbKv6pirhTM90gN2yx361TGgaW/b30TLwLlJmDDLZzFdNrrhXw3PUMAT1LX19lg79A4yUk80KIfFhSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QrDK1JCI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7rekKWzDRQQvs8rd9AISCHCjZ9AbrUch+rIMCOUTyaY=;
	t=1738136479; x=1739346079; b=QrDK1JCIKIcAqQ/bGjSTft9Irs5o8lLB+hqVNCUkEAJA0im
	DNCy8HmCGux4z0KQQ1cxnYm21kRiEEMJUbByRGNZvCOj2mXT68crz1q37o4sBsLkmB3YY0M1hWiVm
	oI59laj7pr26Q4DdREPL0lQHrRDEkGVCrKEZNAFLt+SZwCAPAa44SveqSV8M653Dr0P/8Glc9IQ6v
	C0PvWR1O0oB8doBkD+oh9+pEcHpQX+Ik/xCMLrM3NVtFf+r47h1o9+gfb6Hud6IY4HAaf3CfWquId
	ON991SPFh2PMYdEcxrk2L19V4262VAg5aCTxQQsLOPPEqqg11hY8ebeMETnyM99w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td2hG-0000000DqF0-1h7B;
	Wed, 29 Jan 2025 08:41:14 +0100
Message-ID: <e2c711ac4d5cff0cd8cbf4d73fd6d71d9db3ff1f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 05/13] wifi: mac80211: Convert vif->txq to an array
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 29 Jan 2025 08:41:12 +0100
In-Reply-To: <20250127162625.20747-6-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-6-Alexander@wetzel-home.de>
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

On Mon, 2025-01-27 at 17:26 +0100, Alexander Wetzel wrote:
>=20
> +/**
> + * enum ieee80211_vif_txq - per-vif intermediate queues (txqi)
> + *
> + * @IEEE80211_VIF_TXQ_MULTICAST: queue for broadcast/multicast data fram=
es.
> + */
> +enum ieee80211_vif_txq {
> +	IEEE80211_VIF_TXQ_MULTICAST,
> +	IEEE80211_VIF_TXQ_NUM,
> +};

nit: missed docs for _NUM

> +++ b/net/mac80211/util.c
> @@ -364,13 +364,14 @@ static void __ieee80211_wake_txqs(struct ieee80211_=
sub_if_data *sdata, int ac)
>  		}
>  	}
> =20
> -	if (!vif->txq)
> +	if (!vif->txq[IEEE80211_VIF_TXQ_MULTICAST])
>  		goto out;
> =20
> -	txqi =3D to_txq_info(vif->txq);
> +	txqi =3D to_txq_info(vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
> =20
>  	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
> -	    (ps && atomic_read(&ps->num_sta_ps)) || ac !=3D vif->txq->ac)
> +	    (ps && atomic_read(&ps->num_sta_ps)) ||
> +	     ac !=3D vif->txq[IEEE80211_VIF_TXQ_MULTICAST]->ac)
>  		goto out;

Seems it'd be nicer to use an intermediate pointer here.

johannes

