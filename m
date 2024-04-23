Return-Path: <linux-wireless+bounces-6715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CE8AE3E4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574ED1F228B4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603E60279;
	Tue, 23 Apr 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bkiAHMCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7397E116
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871706; cv=none; b=J76h1p8i6jJ/5uQndLyLHdj10+F286D1kh2mfILbJsEnTlf6KMY1q2OkC9NTKiVYOr24mMk+bklYWgGoPir1R1TAv1avu7ADF7de32VMExF4MCtSSM0fCoIBaJ1++C7TtEJZnH8tvnfZhYH560pN6JSj0PN0UA94lEPOH60lmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871706; c=relaxed/simple;
	bh=4QDD0koqWeMNJsvK+AWr9qksMalrIX1hjsHyTDdQR+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePAl/Rck1OIPaHS7QLd4DwaqzDJHvwx5p0lVrJcqZkLgRzlQLj30t8uBLNG5nlQmBe9ze/UC0Cdye7Q7BI1A/Mjqh2SYld6pe4FJe4I6p/0yz79UTkDWB1Q2UHlc4HLJ20kL7FpcfratHeWktMq+VYqIVW4hNxYuxrEdVUYTuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bkiAHMCV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OftHQlL3/SZHidctDx5bqDbcjKcl0GkA0Xb9cAKf5Sc=;
	t=1713871705; x=1715081305; b=bkiAHMCVZNzXZJDXeV0yYeXx4Ers83au9YV92DDbTHkiIy0
	FiMSkytZHRyCRwWH6zNNP5KSzWbzyNKyzxcuFpu6qHfBMIm8VW5SbF0NoY+wgKol1wh9bxw6tmu1c
	mir6/msF08Jeu6F0dyvomoTjG2l2BoZhm73pzvo1AaRJbN5Ytx69XZz7RGg0Ez6JqD6GHqMBCfXOX
	OiaeAgmmvAlHQSN9NIC/CQ8U5VE2IKs9NvXPpuz9z7ajr+w2xkAPlikhP4WzrvDZRhV/SqGYSi5lw
	1iT3p6m2ZovM+zqlAffn9jeevoge/PNMPPwuomUGfOiyB4e9CUmb9NTgDwsVUqzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzEJx-000000025tM-3X8U;
	Tue, 23 Apr 2024 13:28:22 +0200
Message-ID: <e9c1c8fb20c39ed158f11a6152dc594de6073726.camel@sipsolutions.net>
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
Date: Tue, 23 Apr 2024 13:28:20 +0200
In-Reply-To: <757f417d63a750e84ab883b500becc2773e9ff17.camel@sipsolutions.net>
References: <20231208063820.25983-1-allen.ye@mediatek.com>
	 <65d21336e8f7e180352403a3e894aeaf27a22cab.camel@sipsolutions.net>
	 <c23373d71eff81ea043783edff0345502bb2e299.camel@mediatek.com>
	 <757f417d63a750e84ab883b500becc2773e9ff17.camel@sipsolutions.net>
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

On Tue, 2024-04-23 at 13:21 +0200, Johannes Berg wrote:
>=20
> Anyway, I think I agree, but can you please add some validation of this
> to cfg80211 as a first patch

I guess I should say what kind of validation? I think it'd make sense to
ensure that the elements even exist/are long enough (currently there's
no validation in nl80211_parse_mbssid_elems at all!!), perhaps call
validate_ie_attr() there as well.

Feels like something should also ensure that not only is

	config->index < wiphy->mbssid_max_interfaces

but also actually < 2^max_bssid_indicator?

johannes

