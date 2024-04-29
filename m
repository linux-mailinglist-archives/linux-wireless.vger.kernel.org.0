Return-Path: <linux-wireless+bounces-6985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D368B575F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD66282F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF959535C1;
	Mon, 29 Apr 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="OfOWaGls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2E53E33
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392190; cv=none; b=Dk0GlO6DbClvPca5d5lwX7GnBwhGnVK6BmRdQ2iYsHyYAl60XiydqwRwYrXqHB0RYpt5bzOP//jvyjLq8Y3vQGo62Ney3FU36ux90JvPS28mZn5kCiEVI+zb6VNaox+WpDWd7zecM4YwVEPK6LBe+QmipKxNugdN5pVs0jJVP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392190; c=relaxed/simple;
	bh=vftSGFpv9sp0DvAreoTdzRHdoVnENU1KMMZljiMxJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2FunC/vs6mQx8ypzTkEpkYmIHkiKZJhcYD/3AVbjmfCTedZA4ChYOus52L10MFKd/mQCnSUxx79inf/5qcf7ALkkn1oqYvOFuszMvTpLb8BfKLp4m6udvoALJUAZJ9dx8BNomvCnoSm/1vdyEniiJrhHa3GtnY7Agw9EZThZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=OfOWaGls; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714391699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+eupiIIC3zcFVNwOSflZiCwKLV+wdtCtjNUcI/UrXQ=;
	b=OfOWaGlsrxHQUtnjPxjUGxcgZl4smIQfKE9ivJdnbTn0x6uFS2VWkErWoe7ZZKuKT5BcO9
	HBumQi5kw/CsApcKqEqF3PogADmqGMtJQx4sNaVpjSu/B+lJvagcoyJGzF/X6hO4ZiaJrt
	PSwN4Tg0aCxCiGwypJfI2S6ISXOkktk=
From: Sven Eckelmann <sven@narfation.org>
To: ath12k@lists.infradead.org,
 Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Sarika Sharma <quic_sarishar@quicinc.com>,
 Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: Re: [PATCH v3 1/2] wifi: ath12k: Don't drop tx_status in failure case
Date: Mon, 29 Apr 2024 13:54:54 +0200
Message-ID: <2323473.ElGaqSPkdT@ripper>
In-Reply-To: <20240429114841.413901-2-quic_kathirve@quicinc.com>
References:
 <20240429114841.413901-1-quic_kathirve@quicinc.com>
 <20240429114841.413901-2-quic_kathirve@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4887899.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4887899.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Apr 2024 13:54:54 +0200
Message-ID: <2323473.ElGaqSPkdT@ripper>
In-Reply-To: <20240429114841.413901-2-quic_kathirve@quicinc.com>
MIME-Version: 1.0

On Monday, 29 April 2024 13:48:39 CEST Karthikeyan Kathirvel wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> When a station idles for a long time, hostapd will try to send
> a QoS Null frame to the station as "poll". NL80211_CMD_PROBE_CLIENT
> is used for this purpose.
> And the skb will be added to ack_status_frame - waiting for a
> completion via ieee80211_report_ack_skb().
> 
> But when the peer was already removed before the tx_complete arrives,
> the peer will be missing. And when using dev_kfree_skb_any (instead
> of going through mac80211), the entry will stay inside
> ack_status_frames thus not clean up related information in its
> internal data structures. This IDR will therefore run full after
> 8K request were generated for such clients.
> At this point, the access point will then just stall and not allow
> any new clients because idr_alloc() for ack_status_frame will fail.
> 
> ieee80211_free_txskb() on the other hand will (when required) call
> ieee80211_report_ack_skb() and make sure that (when required) remove
> the entry from the ack_status_frame and clean up related
> information in its internal data structures.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Thanks for porting and testing both patches on ath12k.

Kind regards,
	Sven

--nextPart4887899.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmYvio4ACgkQXYcKB8Em
e0bp6A//YzB2dprLEdV27QypAs5E3l/3pnIf+iSCoH0DuZApGLCt3IyS6Q6cLtMJ
6TuHe4995GhjVVmvD2p9g+MAfcD5olfJVFKB5QUb8wdgQtKwiSoDeKUkxVCM+1EM
TeHYdTcDBCJqnGwR06+BECdk+pWfh7zli3L/8UyLbCX3dlFGvaZAo1Hmu0N+nTbN
ALyc6PtyZPWOMYJTbZEBZ145BNHOW2adz15dDCdiSmcRcZLugmm6fDZwAwPadZkr
vthJ0yVR/yF+uMPrCH9mKa5fWVjV2GI6he1ioY+6GprJ5KOZzG5K3UGKdBrjydcZ
eGx+t8LZqc9wPU4TyaOG3S7IF4INLI0WaJFTEMAoyQEHQHzvP4OuR+YvAOtNqbvL
PJOA6HW68tFIZHidq+rVReOZirLhC7cdNV/iK/iyWremwJJX0mFT9OsIa5aIXzEH
Cn2O6sCHfKEgMZrsy0yRtLXcrmsakupqYyYnsjyHGZy35bPIbXDdFaE0TLNwLx1T
Y/1PNvOMlv1laH65Xzrw+W1IABsfiUIB7+ipCEchGljwR2rO9nXamaFoA2XjT5iz
OAoT5qe5UPxvHpssfFn3swT8ALsjVx7MuCbiWgvx86/CEbNnbL/f/+k4wkGLJPIr
TILIfybyNUutmbI6og9C7szeE0yzsX6y6/Y00JzEedI1Ui6m8CA=
=ZGBz
-----END PGP SIGNATURE-----

--nextPart4887899.GXAFRqVoOG--




