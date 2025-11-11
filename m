Return-Path: <linux-wireless+bounces-28834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A886C4CA87
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06BE44F953E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB352F0C6F;
	Tue, 11 Nov 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YpNL6rTN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8038225761;
	Tue, 11 Nov 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853039; cv=none; b=jm5W5NBOo1oWuFCbitGP+K8LwZELwHD3VRUoO/Mf60Gv4GCj4/zbgYA0wTYlntweXgnUafH30h7djIKP5fnXIklj08BCNqh6bEa9KGXNZffu+48Hh2zNWcdg2AfyN2O30wGqYF7TzUONyUHh/fjsP8S9D9XhCGITPOU24hQNh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853039; c=relaxed/simple;
	bh=HuwgNnsIx8bsAdhpCRc5zsES9Gw1RU5uXTprjAnG7jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIPN8+aBmgk51XT7ZR4O2Zzd7T0s2GYOJfOs4jzuwUyrMJC0o/PcAxbf2u4e0QBgZGCLJhdoKFmjdYXmofmrOi+PYVDVBESA12xbjF+ntD8feA1+Kad0Vld1+1kCKtySHzySDSahVZNoWyWCbpMC2C31Uxrionohn+RMrJGnwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YpNL6rTN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UxAL9kVzMDghVPB8gRVQfjQgOsl5ypAhI+eC+thIb2A=;
	t=1762853037; x=1764062637; b=YpNL6rTNNteO14RY9iSnSy0BcsgEdn4pqM05Sdi4akYS6Qm
	VPlfwX7CZpJHZM+Byy23pvbpKhJaltowwOjGOfnljqUCwxdZptk6V1H7h0riCIgcHHb2ljYY6PXIt
	1ylUSIsAMq/DBU9q+Wq6CclOZaC6eGB7CGCdneG7asI7NxPVyCzWO12CwuBn3RWlGfmKsfcqRj9Kn
	WRCMarg2TK3dAnhRU9QzYOp+CWIYnu33/Ak/uGNYygLydNo92P3FHKE18FB62vm+7Uq8eqaTEUi1i
	4DG1Ovh/bdwFTNHHxrI0cdE7CEQmLq2ZzGdX+LWKibr4pLRGJJ2VIcGIvoFGmkdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIkbR-0000000FGaf-44MX;
	Tue, 11 Nov 2025 10:23:54 +0100
Message-ID: <6eeea6645b52d484a45b57086ea50bf5d8c34f86.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mwl8k: inject DSSS Parameter Set element into
 beacons if missing
From: Johannes Berg <johannes@sipsolutions.net>
To: Pawel Dembicki <paweldembicki@gmail.com>, linux-wireless@vger.kernel.org
Cc: Antony Kolitsos <zeusomighty@hotmail.com>, Roopni Devanathan
	 <quic_rdevanat@quicinc.com>, Thomas Fourier <fourier.thomas@gmail.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 10:23:53 +0100
In-Reply-To: <20251111091708.2809266-2-paweldembicki@gmail.com>
References: <20251111091708.2809266-2-paweldembicki@gmail.com>
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


> +static void mwl8k_beacon_copy_inject_ds_params(struct ieee80211_hw *hw,
> +					       u8 *buf_dst, const u8 *buf_src,
> +					       int src_len)
> +{
> +	const struct ieee80211_mgmt *mgmt =3D (const void *)buf_src;
> +	static const u8 before_ds_params[] =3D {
> +			WLAN_EID_SSID,
> +			WLAN_EID_SUPP_RATES,
> +			};

Heh, I meant you should have only one tab to indent the constants, not
indent the clsoing brace, but I guess I can fix that.

Should this go to wireless? Maybe then a Fixes tag would be nice?

johannes

