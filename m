Return-Path: <linux-wireless+bounces-21940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D5A99B53
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 00:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF891175947
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 22:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0E1D63F0;
	Wed, 23 Apr 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x9lmJCcD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E42701AF;
	Wed, 23 Apr 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446531; cv=none; b=E2A8TMT9eaAfBIbkca7kQLr9ae3QtTrXOjGhOp0VOXKNPFoJUnWkVfEdhPhA71cwqdh6RrDIkqcU0IruuTZgiA7ZM0b/HOxXqVxPWDcZgOV1iOHBg7YwdSgoiIdxaQZB5ZDA3XFuDBRdSpSAw0LfKKMS0sOco/r8wXKspFxF39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446531; c=relaxed/simple;
	bh=4DE49/DCg6Osb/XUYJ9DnwvTKDvpyl+gXUa/AHHMsdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fY5O6hn1CU1T+xLYUcSMFRjGvSU09cIN1Yx7B3G4Pet4StgbloG4dcjVI+6H8wdKU6mKLzmsAgDsJcowJJKdVwpuZ2DxoJO8Oh+5eFViHelE/1yB9orzK2pfA4dqFn4AMIijnD5hepIA2QN+kVvR2pbQg5LzIVx7CGFm0ZfswcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x9lmJCcD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nmeggAjgOIdw5h9gwCoQYZdsE1xYtq2spynuYzN88BU=;
	t=1745446530; x=1746656130; b=x9lmJCcDdN/VrsURwfpGu7r7v01nnf+zdp9RxpqOBcWEHc1
	Vs9i/z2qH55Vrdn87lN3NvAuI5JKD6fp1aorYLzABkMx1ltn1MzDT3czNwjrjjIT53gvkE/QbrcCw
	6ARmsS5CE4Po75oKcSJSGgJDyMw0eTTNHFTK8EqAQCoBaoH2mz3qP5nKAKbnbMv6xSwtZMZZcyh1U
	agahN8GC5xwbuTxPp7dM+ihJoWoIkuUzPNde0GbOfrq7n1CWVfFvzh9opq0m4GiGynCfVV6CXAfu9
	fXTACLXLTnYUbf0D/IJqz1uLSCX7amHQvucFJPsRQmcEAwh2NHaCslD1ClkeO2ng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7iND-0000000FV91-1k6F;
	Thu, 24 Apr 2025 00:15:22 +0200
Message-ID: <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Thu, 24 Apr 2025 00:15:17 +0200
In-Reply-To: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
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

On Wed, 2025-04-23 at 23:21 +0530, Gokul Sivakumar wrote:
>=20
> +static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_dev=
ice *dev,
> +				     struct bss_parameters *params)
> +{
> +	struct brcmf_if *ifp =3D netdev_priv(dev);
> +	int ret =3D 0;
> +
> +	/* In AP mode, the "ap_isolate" value represents
> +	 *  0 =3D allow low-level bridging of frames between associated station=
s
> +	 *  1 =3D restrict low-level bridging of frames to isolate associated s=
tations
> +	 * -1 =3D do not change existing setting
> +	 */
> +	if (params->ap_isolate >=3D 0) {
> +		ret =3D brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate)=
;
> +		if (ret < 0)
> +			brcmf_err("ap_isolate iovar failed: ret=3D%d\n", ret);
> +	}
> +
> +	return ret;
> +}

Seems like a terrible idea to accept any other changes silently without
doing anything at all.

Also, please pay attention to the linux-wireless list. Like, at all. We
started using tree tags months ago, we started using a different subject
prefix _years_ ago.

johannes

