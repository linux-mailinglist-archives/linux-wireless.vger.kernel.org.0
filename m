Return-Path: <linux-wireless+bounces-23207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D38ABEF09
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B28C5188
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D37238C0A;
	Wed, 21 May 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AaTcMWko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE123BCF2
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818150; cv=none; b=e4ryktuEJIvBmekgYjJNwVP7zN4HS/fnrdbDU4FbYZFHClKUkFafFNpJU9ELwab32xILFgT5C27YTs1WmqQsIlL/RWtSAs8QidiWWpS46DHUVZ1wnH7JTwC1CXkh2LTSEb9+PEhfxFF8Td3wwss36/2VsS+ADRTybhk9nQAq5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818150; c=relaxed/simple;
	bh=Xx1y3gxEH3dSzdzQzAhjbf1KYTzG3u/XGiy4kJl4Fvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1IbZ+ij9yi2YSMOuKIoiGZrrE3Qum2fnpFb1uyNeHJTQCfl52dfEjJ5qS7bW5dRMMYD9UYUijIC/EuFobFH2DHZbYuNHK+3qL3vP+Caa7wxn9a953/CDo8DeOSg0e6etCDjYDdK/bayDLD2op0909ZGVIsCTK7E74LT26tgVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AaTcMWko; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DdU5uPq2KXsfJglr16tlzYMOq8ld2v++xxF3KfjiN58=;
	t=1747818148; x=1749027748; b=AaTcMWkoFT1p0PH0m1A9BmlZuGQL7JmJVo+/NRKbAdN4zoJ
	0ardmSUdgJQGIkgLkwJE5Uznix3ONPRbF4CI8Idqsp1icoZHEJ6UNOlBI+5srAEqFkRvxXVvPi4eb
	9+RPxAklZsC8QObfR8ReMeKD19vUCDIZWhcSBA6H5CBwEOjxZMwg3FVX+R9wTlDg696fU1dumQrq0
	Gpq3I+enw0XLQu4iFhoq7/9e1IeLsTgzT6AtC9gXuBfPSaqbVq9E0QHiVWYERDannv8vOfv6DeUxJ
	O0do2x8IofyQp6CkD2Sjwtyn9SgP5qbDV4hUOGYcTmtitCA7HwXQy++IHf+MJYKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHfLA-0000000E7HR-0Zo2;
	Wed, 21 May 2025 11:02:20 +0200
Message-ID: <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:02:19 +0200
In-Reply-To: <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
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

On Wed, 2025-05-21 at 14:30 +0530, Roopni Devanathan wrote:
>=20
> On 5/21/2025 12:49 PM, Johannes Berg wrote:
> > On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
> >=20
> > > +++ b/include/net/mac80211.h
> > > @@ -4569,7 +4569,8 @@ struct ieee80211_ops {
> > >  			    struct ieee80211_key_conf *key,
> > >  			    struct ieee80211_key_seq *seq);
> > >  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
> > > -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
> > > +	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id,
> > > +				 u32 value);
> >=20
> > That should probably have documentation updates. And passing a negative
> > value to a u8 seems awkward? Maybe that should just be 'int'? For a
> > value that's likely passed in a register, u8 will probably require more
> > (machine) code anyway.
> >=20
> The following snippet of code tests the value of radio_id in
> nl80211_set_wiphy() in net/wireless/nl80211.c:
> +		/* Radio idx is not expected for non-multi radio wiphy */
> +		if (rdev->wiphy.n_radio <=3D 0)
> +			return -EINVAL;
>=20
> This snippet returns an error if the radio_id is negative, so radio_id
> passed to set_rts_threshold() will always be positive. So can we retain
> u8 data type for radio_id?

I quote from the commit message:

> A value of NL80211_WIPHY_RADIO_ID_INVALID(-1) indicates radio index is no=
t
> mentioned and the configuration applies to all radio(s) of the wiphy.

So now something is at least _very_ confusing.

johannes

