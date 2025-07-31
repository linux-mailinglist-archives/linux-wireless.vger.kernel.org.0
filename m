Return-Path: <linux-wireless+bounces-26068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B663B176D7
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0CB586467
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971224169A;
	Thu, 31 Jul 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TFbiJ/k0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC815533F
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991829; cv=none; b=qKjXDyWPHEwxdjMc56sHkeP81/mqHuYDtNsqwGivJ93GC8ZGiTJbobuRHRmgzuVv6h0mc81xgfWezNFUllw7dP9DTs7wrSSH61v4UuQijRfCa1Xsu/f2K7C7rArXmyViFMu9XawTSgydty1y4/lPMNC7gu7w82KKNmiNRhEtbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991829; c=relaxed/simple;
	bh=O+mw1B1hci1vkap5M7FQ4gXHO/MiQQym6Jzo1FpG4l8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InLkcBhBShw5+5igL1euULnS2yeP9YKLdF2vgX1O6cEl3cBl+CRXq7jUArlUhBxVtIhPHSIFOG7AEoKntvedLhz4UyxzBT+sZGa5MTwf7bwk28PCtFHA5jqKKVZmvNz1g0KNS8++gtZ4K6SELEo6tDD7xPc8ZY+J2vlXZCn4Opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TFbiJ/k0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z15m4U5hhDJyDFB2SRFfiKcQpus9MtvloPr9ocvvlgQ=;
	t=1753991827; x=1755201427; b=TFbiJ/k0kWt/9rRFhq0eSDTy2z/zVpJz5gCT0hEQ3DbM8VO
	ZSwXivjMjZh55AYkDXPTLOU8a1fZH88VfBzkJrohSa/hTwK/oP2L2EkLRz1RTYIjyOwhY2WL+8dXB
	Jc+LwdvgPSi3lBB/U1eSz5W4whlbCTs9LwkuT/Ij5rnFM33MurP9gx6xqxO24+fIvPfglNE/eRk2O
	o+/wcwZ21zdtjvXc+S7YxFB+BWsesm5H+RYiMO5d3cjG9lTMxYyLDPtyh1p0Pm3+pL8j057DSX9R6
	6f9sM8ddJggLVRoF1C2BYRNq7RAHAWagg+s+6hbuxra5/LuzjhH0aXTkAcxAz0ow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uhZOc-00000001jdq-092w;
	Thu, 31 Jul 2025 21:56:58 +0200
Message-ID: <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Thu, 31 Jul 2025 21:56:56 +0200
In-Reply-To: <20250725132221.258217-4-lachlan.hodges@morsemicro.com> (sfid-20250725_152252_821403_0A559DB0)
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
	 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
	 (sfid-20250725_152252_821403_0A559DB0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-07-25 at 23:22 +1000, Lachlan Hodges wrote:
>=20
> +static inline u8 *tim_push(u8 **p, u8 v)
> +{
> +	*(*p)++ =3D v;
> +	return *p;
> +}

The robot complains about this, there should (normally) not be inline in
C files.

Also, looks like you don't need the return value?

Anyway, it's the middle of the merge windows, so I guess it'll be a
while before I apply things.

johannes

