Return-Path: <linux-wireless+bounces-6714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5C8AE3B7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A93AB20F8A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B04612EB;
	Tue, 23 Apr 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="W4FF6b0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD760279
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871271; cv=none; b=kSL33H6qKpO0ggImpvQ7UBn3Yn2w1DsfBUb2NRjl/DPd8WFxNbws5cMcP2miD799jYSLNxhF0QzISqiRPNbPVjO0/QeAc74G9BLNmDwtwSiAuOqUXXUJxDRmTyhGxqL8VFBZ/R+93Zr/pV6vWt25JhxvtaMH4whCP8zjnzY5fmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871271; c=relaxed/simple;
	bh=TSj5LeYjkpK9XNI4Yvas4e5knCrKA+ZPbN7x3+5ThhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ngbtb9e6BSSt9UEW1NfBMlN7kyFXdn/CnxJzS9f9pV5tbOf/7VRFFSYhpCneOVk3AeadKApzOVXNBvAeLCaJ4majOHdFmUNIX0XyGeNN39++ox3CsfXXhKUcGP/SwKG6g33kMfgcCQuWNiVi146cnvL7NOcrLM6E8MpfvFB8rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=W4FF6b0R; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TSj5LeYjkpK9XNI4Yvas4e5knCrKA+ZPbN7x3+5ThhY=;
	t=1713871268; x=1715080868; b=W4FF6b0R3ND8zXBgPmRhFHFyP7hBTMuc2zxzaDOk3VznLod
	0b8CPyVyKwKep976Thn4K6BHMgRfUJVebh60SHbJWUQ57vXv9VjdXBBKVpfySRlY4orCe8K6PMm5Z
	KfNO0mezfOc5VDtMte+79vbD7/lOUEKSZbCYJUBK2eVS4F/kKECksOsvn09sYKMZEg1c2zYU47qU7
	afvVjQiMyln3ng2gGz/KYNNuCSa4T2aMPRjxLanrMVLQtTBOveajLU2wzBtPHYddF4jg4Vog/+G4k
	VQDNOKquYm5bu5faoAqeWI/yr9xHoyf+PvujqjLThQTEYe6EEjGOTqRv+ipMDUHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzECt-000000025Sw-2Tpu;
	Tue, 23 Apr 2024 13:21:03 +0200
Message-ID: <757f417d63a750e84ab883b500becc2773e9ff17.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS
 numbers
From: Johannes Berg <johannes@sipsolutions.net>
To: Allen Ye =?UTF-8?Q?=28=E8=91=89=E8=8A=B7=E5=8B=B3=29?=
 <Allen.Ye@mediatek.com>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Cc: "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>, 
	"nbd@nbd.name"
	 <nbd@nbd.name>, Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
	 <Evelyn.Tsai@mediatek.com>, Money Wang
	=?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
	 <Money.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	 <linux-mediatek@lists.infradead.org>
Date: Tue, 23 Apr 2024 13:21:02 +0200
In-Reply-To: <c23373d71eff81ea043783edff0345502bb2e299.camel@mediatek.com>
References: <20231208063820.25983-1-allen.ye@mediatek.com>
	 <65d21336e8f7e180352403a3e894aeaf27a22cab.camel@sipsolutions.net>
	 <c23373d71eff81ea043783edff0345502bb2e299.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-12-27 at 09:38 +0000, Allen Ye (=E8=91=89=E8=8A=B7=E5=8B=B3) w=
rote:
> >=20
> > We should have Lorenzo here, he wrote the original code.

Actually John/Aloka at least also did ... so whatever.


All this only _really_ matters I think when you have EMA, right?


> The number of BSS is not equal to MBSSID element count plus 1 because
> there might be multiple nontransmitted BSSID profile subelements in one
> MBSSID element.

Yes.

Actually it's even more confusing:

> Also, one nontransmitted BSSID profile subelement might
> be fragmented across two MBSSID elements if the length of the
> subelement exceeds 255 octets.

True; however, in this case, a single entry in the
NL80211_ATTR_MBSSID_ELEMS array (and thus in mbssid_ies) must contain
both MBSSID elements together, so it's only counted once still. More
importantly, otherwise we would split them across two frames with EMA,
which is wrong.

So really mbssid_ies / NL80211_ATTR_MBSSID_ELEMS is *not* the list of
MBSSID elements as they should appear in the frame, individually, but an
array of *sets* of MBSSID elements.

For example:

mbssid_ies[0] =3D mbssid_elem(profile1, profile2), mbssid_elem(profile3)
mbssid_ies[1] =3D mbssid_elem(profile4_part1), mbssid_elem(profile4_part2)

when you have EMA with periodicity 2, and 4 non-transmitted BSSes where
the first two are small and fit into one element, number 3 is bigger and
needs its own, and number 4 needs to be split ...


> > But this seems fishy to me, if you look into the element itself,
> > you're going to have to do some validation on it?

I stand by this though.

> > And what about fragmentation?

But not this :)

> Whether the subelement is aggregated or fragmented, the MaxBSSID
> Indicator field would be the same for the multiple BSSID set.

Right.

> Therefore, we directly retrieve this field from the element.

Yeah, makes sense.

> For example, there are five BSSes in one multiple BSSID set, one
> transmitted and four non-transmitted BSSes. We might use just two
> MBSSID elements to store all the non-transmitted BSS information. Here
> the MaxBSSID Indicator is 3 in both MBSSID elements. However, the
> element cnt is 2 and if we use the original method to calculate the
> BSSID Indicator we will get 2 which is wrong.

Right.

Anyway, I think I agree, but can you please add some validation of this
to cfg80211 as a first patch, and also document all this better in the
commit message? Optional, but some additional nl80211 documention would
be very nice.

Thanks,
johannes

