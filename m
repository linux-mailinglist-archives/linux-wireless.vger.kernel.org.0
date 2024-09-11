Return-Path: <linux-wireless+bounces-12790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DB9752E6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A608E281BA9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D61185952;
	Wed, 11 Sep 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Esju1OAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BE1537C9
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059170; cv=none; b=M3o/HiA13N2Abjot5oBofF+say+l71LbJRcTSO57srmNy/zOU1KLW09MpFXKlUeGXa8tIJ2T01TPhaWYJsstpGrwomcy2253oxys92avqZ0VEEitCUvJiuKWABe6FrADIpGEu2oyaveFSnOcKxTrNSdkWhG4xBETF7wACoGeSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059170; c=relaxed/simple;
	bh=8xANxriHF0ScMPe+fSyMAo00i2FmBw6gCpTbf6La/WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUp0EH1YzyFK+pqLtZXz7l6FseC+kunj006NAG8s43Db8tOjGqVr3dZoBlTZ8zWBuxFXaKcWkSB9Nlz2OlKEx1PKvwWc1M76sc0BUk70OI23tQt+53xssPC1TbT3oV2P8lfDrNNrRWJgNkB9W71CIjMtLdjfFXS7DpemH5UQYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Esju1OAK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mS/vwiTzIujUR8SIRVSDklN6Gm4yZg39cYyCPxdi+O4=;
	t=1726059169; x=1727268769; b=Esju1OAKyXpR7wpleMNmTGb8phZcTDZ6STK/ElVTfeApRUe
	WsZ+1eZzMiNj9zNYZCsxtIvXRIUYEtRAxVJi6QiO/YGEV5Y+nnGNDX4xgcptkB5lUFpHqoZJNTSAl
	wAhxYCoQsPyHgi6WIgjmh9vJfgvhbEySujx5Eab+LU6oeImbdAM7r1TrOzVTcbU25YDdx8MnyrX6q
	wnMIT9so2tnNN7nUQZgcg0ulzSC0Bs8imhZeco6kFwbbarTDF+r93Vf0iYzq5rC6FwwsVGrPiB3Hn
	vaqJvzDzA2CDyWoihfnH3tJG94HbO8vrYLmzkQZqXgLcrQruvFdJmgzVgCO014bQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soMpx-00000008sB9-2nqN;
	Wed, 11 Sep 2024 14:52:45 +0200
Message-ID: <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 11 Sep 2024 14:52:43 +0200
In-Reply-To: <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
	 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
	 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-11 at 18:21 +0530, Karthikeyan Periyasamy wrote:
>=20
> On 9/11/2024 3:12 PM, Johannes Berg wrote:
> > On Wed, 2024-09-04 at 16:59 +0530, Karthikeyan Periyasamy wrote:
> > > Currently, wiphy_verify_combinations() fails for the multi-radio per =
wiphy
> > > due to the condition check on global interface combination that DFS o=
nly
> > > works on one channel.
> >=20
> > As it should, really.
> >=20
> > > In a multi-radio scenario, global interface
> > > combination encompasses the capabilities of all radio combinations, s=
o it
> > > supports more than one channel with DFS.
> >=20
> > No, that's not correct, it doesn't.
>=20
> But the attribute comment section clearly says the Global iface=20
> combination encompass all radio combination as below
>=20
> * @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing *=
=20
> the
> *      supported interface combinations for all radios combined. In each
> *      nested item, it contains attributes defined in
> *      &enum nl80211_if_combination_attrs.
>=20
> Is my understanding incorrect ?

I guess it depends on how you interpret "combined". It must be something
that can actually be done *regardless* of radio assignment, to be
compatible with older userspace.

So if you think "combined" =3D=3D "superset of all radios" then your
understanding is incorrect. You need to think "combined" =3D=3D "what the
device can do without caring about radio assignment".

johannes

