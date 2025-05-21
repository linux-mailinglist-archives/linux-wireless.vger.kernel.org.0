Return-Path: <linux-wireless+bounces-23209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CAABEF36
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C73A188C14E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69F238D57;
	Wed, 21 May 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MWCUWwIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14C238D53
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818609; cv=none; b=Aqy8l6yiMLzJCiuVTbjKQQQ2qOnyOIeMUJaAvLZ7I+SIsrtl2nhU15UdPd2jvlEVY70XFe8LPp7DbPRM9n0Qnv15kC3G4fPLXsroExQ7uME32owJzx1rcr8MyNeQItuGPhV+y/RIuKGuZU13/09/f5QzamqCtoszJfyjvVpfLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818609; c=relaxed/simple;
	bh=l8jrg81f/KLYBN9tt+tgfDeyNB5QBe5szZC7UmZ6+1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAivgOBvbKjVBCfOvgWbbYusNhbEh5DvaWWV+1aszzknMQqPtjDUmkz0ExrOrATRZdR/ZMfbDPJ6D0K0KPsdoqTK1QX3CKekPcAdz1DQEBUO/39/tfwbYqItzHwb7YEhXd6+gemrrzt02dprNgOd0EK0GRKYv0wH2DJrDBAFqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MWCUWwIX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZfJvcBGEZ4kG0tgJ1vTK1vjCTKPU/qeFuQ9UyLCoTzM=;
	t=1747818607; x=1749028207; b=MWCUWwIXEZN5gqyn4xK/cSMsIQg2s59k57kxiVBz21zEVLO
	SnYSKTwJhIXLCvuNNjgJpYFapqygVIrhWl/GP8XR6zEdrACncqUwWUZyMSIg4oY7YUdKxRG7AVbFq
	pAFtJkLerewXniPje96aTcHXLePVA7GA5OV1QaC7vB0EHiOoFZ2/LJyAG4YaOSKqObgp8m87BsLdd
	PXlgz/8aBjZA+M5Cy1XLDtnk+CKHDXbLfTiLGmjiO555ZP/+hbDuy2EOZ6hViHdlzPyyUD7O+vy9e
	YQpA2dzv7SArxFp8oDgqrPSyODgn8b5yXmTPZFcY2HbWL6rDSEw5tdLaRiBuo30Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHfSe-0000000E82D-1Sz9;
	Wed, 21 May 2025 11:10:04 +0200
Message-ID: <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:10:03 +0200
In-Reply-To: <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
	 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
	 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
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

> > > >=20
> > > The following snippet of code tests the value of radio_id in
> > > nl80211_set_wiphy() in net/wireless/nl80211.c:
> > > +		/* Radio idx is not expected for non-multi radio wiphy */
> > > +		if (rdev->wiphy.n_radio <=3D 0)
> > > +			return -EINVAL;
> > >=20
> > > This snippet returns an error if the radio_id is negative, so radio_i=
d
> > > passed to set_rts_threshold() will always be positive. So can we reta=
in
> > > u8 data type for radio_id?
> >=20
> > I quote from the commit message:
> >=20
> > > A value of NL80211_WIPHY_RADIO_ID_INVALID(-1) indicates radio index i=
s not
> > > mentioned and the configuration applies to all radio(s) of the wiphy.
> >=20
> > So now something is at least _very_ confusing.
> >=20
> I can rewrite the code to something like this:
>  - Change the data type of radio_id to int.
>  - NL80211_WIPHY_RADIO_ID_INVALID value assigned a -1.
>  - Set RTS threshold for all radios when radio_id is -1.
>=20
> Is this okay?

I honestly thought the last two items were already the case?

johannes

