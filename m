Return-Path: <linux-wireless+bounces-22042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7653A9C1BF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3391BC01FD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587412356C6;
	Fri, 25 Apr 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lLWbeXS/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67F235348;
	Fri, 25 Apr 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570440; cv=none; b=sHaanb/xzklUPOfNpbPRTX+xjUjARvcwoil18Bg/0TGUzZmQdAnm7+u6ZwIDiieJpODiV6r5jxWMHI9paX7ED01uKvuHRCfcltQnDIhK8iFARoOk79zF/h0GmTsxklFw+hkvYQQsfe0GHE1xExBx3E04f9jbLruVYLIb9bUus38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570440; c=relaxed/simple;
	bh=x7suQfU8+JQR5c33reO5qChGwL2ucUnxvh4Mk9tBdUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaXXNjeFf76nHD42E8Va7j5Rpk+RHLyR3SpzcexjXP2aI0GVtxYQJmHRMci7FHz8xW2dwQ98zdj1gBjyBYrkUSXFBb9BGAbNBz1wGQwPl4Vnwe2uLyCC1gAKTqsBw7yS/VEyDXyos4WtRTkZSjChIib7MRZR93Anj+32L54K0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lLWbeXS/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/VUSIghyqrguqoDHIl9mme3Sw4KuqhQY8/xEAAaYuPg=;
	t=1745570438; x=1746780038; b=lLWbeXS/vHcZAqHSf2pBLZn/rC7toCfvc+TPgkl9a2lNsLU
	y9Xzi76gjmH3X6eIyIE/E/sc1l9ylRYWLKS6S2DTv6yT23hykEZ9vrCwRxQNRjMBGulsPUFClKdsD
	+3vvwrZTEE0eBbYo1x1otPpU7f9FOneGbCJxlK8e6kjX/3z+lCov2SfOSCvfGYTJxltW9KChR7WHv
	dGrCiKgc4uB/wpZGzeS7AgOs1cCrpLunPOAVQPQmTd233AoAT89LoHV9eMdEHFyIphoycqaNH6vW3
	+0KqBE1VT0WaDhNE1Gix43ArLKUIj3YS12ohdLmPNIg+PQMZ2VzYJAxEzRYoM2hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8Ebr-000000019XY-1DJM;
	Fri, 25 Apr 2025 10:40:35 +0200
Message-ID: <44916ff608ee53238d79e57ee31fcbf86dfb672d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size
 for WPA3 external SAE
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, Ting-Ying Li
	 <tingying.li@cypress.com>, Ting-Ying Li <tingying.li@infineon.com>, James
 Prestwood <prestwoj@gmail.com>
Date: Fri, 25 Apr 2025 10:40:34 +0200
In-Reply-To: <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
	 <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
	 <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
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

On Fri, 2025-04-25 at 09:57 +0200, Arend van Spriel wrote:
> On 4/24/2025 9:42 PM, Arend van Spriel wrote:
> > From: Ting-Ying Li <tingying.li@cypress.com>
> >=20
> > Add pmkid parameter in "brcmf_auth_req_status_le" structure to
> > align the buffer size defined in firmware "wl_auth_req_status"
> > structure.
> >=20
> > Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
>=20
> Hi Johannes,
>=20
> checkpatch issued a warning about From: and SoB: difference, but how to=
=20
> resolve it. Both emails are stale so it does not matter, but I lean=20
> towards using the infineon email address as that is likely the most=20
> recent identity used given the company history. Please advice.

I think you should probably keep whatever they used when they posted it.

> > +	u8 pmkid[WLAN_PMKID_LEN];
>=20
> Sure like the wifibot checks. Do run checkpatch and compile test for=20
> every patch before sending it out, but no kerneldoc. Will need to add=20
> kerneldoc for this struct field.

Thanks :)

johannes

