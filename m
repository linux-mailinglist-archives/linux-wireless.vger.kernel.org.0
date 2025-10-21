Return-Path: <linux-wireless+bounces-28150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF71BF713E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76337402BEB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D772F2916;
	Tue, 21 Oct 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FeVe7Url"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1D2D6E67;
	Tue, 21 Oct 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056830; cv=none; b=OtRFOtjccD9qbXkf/sDVBLlD6h1TaeurqrvZrBLo16/cjwK9ovoMYLUAxihQzpYAks99oEwqzO2UQEASegNa1OXVN8Az1ibEhi3ArySAOU4pL5kQ03covTdLBGlz2mufRUQpfrl4TiVqAzzxgc5+0iRZFcio0fYANxdQ1+1VUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056830; c=relaxed/simple;
	bh=JSobYfr+WjpQpXvdVJCSc0DfJWxmil7RxAESVY00LRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhzmYU1Cn9PttycfOAcuFoN01RAoEzaH1YhQ2PloWbCqduX7DCBvIUelC2ftS/YBM18F5VvxEqWzP9ODoOG0nVdZIUZNApN4GK3xgPCFfyDGYm78Yv3X1dt9guyv1WRM53It57NVV+yHPxurIVgvOGhEbnn9ZPHj753WvGX+nds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FeVe7Url; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LIAVNbOhdkFrK1z7fNFUt6d9/zFjhPdfVuObhwjxb98=;
	t=1761056829; x=1762266429; b=FeVe7UrlBUuPquqXfuzlaLYzXmOMYzGSLVMyCpzYUCPdpZu
	NEjDeMVb2YNOPaX9kmG2zncgAP4BQ0quN2HbFPssa0hm5AY59psiLCLQzJJfpmFSr9hhW9EavMW34
	iuKGM1Ufs/YhxhX3KfH04lKgmrkiKQg50J38bFpNbQJfQGvJTJUchcswy+17wDazFUcs+fL/IhCBc
	ZElwG1HqBiev96Nne55/V4KK/kC8tffAe0+C0qZbOWpA0m1NfT4/wOnshhAsoUEFdJ1pjoAxBqdlx
	C6lsO4e63lQMIz4pVS692zHYNMGFOPuPC4eekNeQKBermp56kXc9QKONSPouQyrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBDKL-0000000C0fg-0OQr;
	Tue, 21 Oct 2025 16:27:05 +0200
Message-ID: <0400fa9ddfcb235aa6f80290f95fceb2d1a3ab12.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: advertise
 puncturing feature support
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Oct 2025 16:27:04 +0200
In-Reply-To: <8eaadd1e-793c-4931-bee9-599fd333ab04@oss.qualcomm.com>
References: 
	<20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
	 <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
	 <8eaadd1e-793c-4931-bee9-599fd333ab04@oss.qualcomm.com>
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

On Tue, 2025-10-21 at 11:26 +0530, Aditya Kumar Singh wrote:
> On 10/20/2025 7:55 PM, Johannes Berg wrote:
> > On Fri, 2025-10-17 at 09:32 +0530, Aditya Kumar Singh wrote:
> > > If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_=
BITMAP
> > > attribute, the kernel with mac80211_hwsim driver currently rejects th=
e
> > > command with the error: "driver doesn't support puncturing", because =
the
> > > driver does not advertise support for this feature.
> > >=20
> > > At present, the following hwsim test cases utilize puncturing, but th=
e
> > > bitmap is not sent to the kernel. Instead, the puncturing information=
 is
> > > conveyed only through the beacon data:
> > >   * eht_5ghz_80mhz_puncturing_override_1
> > >   * eht_5ghz_80mhz_puncturing_override_2
> > >   * eht_5ghz_80mhz_puncturing_override_3
> > >=20
> > > A future change in hostapd will begin configuring the puncturing bitm=
ap
> > > explicitly, which will cause these test cases to fail unless the driv=
er
> > > advertises support.
> > >=20
> > > To address this, update mac80211_hwsim driver to advertise puncturing
> > > feature support.
> >=20
> > This might be a good time to introduce better checks vs. what we have
> > now in hwsim_chans_compat(), which just uses the control channel rather
> > than any actual bandwidth/puncturing/etc.
>=20
> Comparing those will be equivalent to comparing chandefs instead of=20
> control channel right? And we already have a helper=20
> cfg80211_chandef_compatible() to do that. So we just need to pass=20
> chandefs and call that helper? Or hwsim should be more stricter and just=
=20
> use cfg80211_chandef_identical() (this helper is not exported yet!) ?

I guess it shouldn't be either of those, since if you transmit at a
higher bandwidth, even if cfg80211_chandef_compatible() returns true, it
still shouldn't work? But that's also a rate scaling thing with the
bandwidth actually used.

>   >
> > It'd also make the tests actually test more. What do you think?
>=20
> That's true. You want those changes also along with this patch or you'd=
=20
> take this one as it is and take those separately?

Well given what we have now it doesn't really matter I guess, just
thought about it here because of the context.

johannes

