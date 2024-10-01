Return-Path: <linux-wireless+bounces-13359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707598B687
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E8E1F251FD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DFA1BCA15;
	Tue,  1 Oct 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a2o0noES"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C229A1
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770088; cv=none; b=ofkI8AJb8DODW25QuSDQu5vTg3pwMK/YnWdGuk3ZNN66AzSocM9KAIcrHNkwe+4G8jGFdsEB8obQ96ulAZ8hGmEU+eayEoqhkxckAYhM5l5KkQp3D8TRSTARMSm3+GX+EogpszYVtb7qDm7gvxfiYHBcv9JS0edDGbTRYUIdDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770088; c=relaxed/simple;
	bh=5MQFlj6/JeFg3Y6xjVpKMktCyTQL6tIxs1NH+jFsENA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIOBl9emE5ig335Yg8DflN4mjvwy3vi5qxmkR6VJtsyt0AxVa06zkw5yKOqUGy6Xl+a1PGxLTsO1j4oyN0HwZuqmuG2HwjMmUo9vexm+XV3wenSiCQ6zTJOV5DygfwFLZpvKGHp3umHoNnKDP3qyttq1Fy7lNNaePDLM8IwwJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a2o0noES; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6fDoOHkgwj8lqEsUdx0mUeTNs6SRSDLbN2FOUo40l5E=;
	t=1727770086; x=1728979686; b=a2o0noESoJT+yf+ck7FqJvr3lmTRtcnwTwJ01QnTc9nXUmj
	6XNfGtSgSPvyW7L6HMPfSQVApK8+EbSxNFqhHaBVQku/JV9SwTTb9iYy+DktAMdh9ae2NofrBIXf/
	ieVXGlRK6Xl6+PiGhjoyrF4YEziikk4XVFaq9c3JayZ9qhuh/1O4XknKbcu3YaxW66FyyD1DBCJU+
	bYT7A7bOYqwggERRMO/n9Ke3gJm4aTGTsP+omqYNCK3gZ/kvv4t3wSnpoZRVwqj/IGW8J7wYjrqn5
	z2/DjAZHhPDogamt8W3Z2XmkcQd+SAeoQM0cePCuki1rTvxpJsRbuth/921E7jTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svXvO-0000000EfUM-48VG;
	Tue, 01 Oct 2024 10:08:03 +0200
Message-ID: <16ad03533ab6aca65c3fe9db94ae53ad11fdb9d1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 10:08:02 +0200
In-Reply-To: <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
	 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
	 <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
	 <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
	 <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
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

On Tue, 2024-10-01 at 13:07 +0530, Aditya Kumar Singh wrote:
>=20
> First iterate and do only _ieee80211_link_use_channel() this part. Then=
=20
> let the flow as usual and after stations are added, do the=20
> link_info_changed() part.

That would seem to make sense, it also matches assoc flow better.
Although not sure that matters too much, since this is necessarily very
different as it's while associated anyway.

> > But also this seems to break out driver for other reasons, because it

type - I meant "our driver"

> > initializes rate control somewhere here and needs a station for that.
> > Didn't look deeply into that yet though.
>=20
> Okay so doing as I said above could work -
>=20
> if (add) {
> 	...
> }
>=20
> for_each_set_bit(link_id, &rem, ..) {
> 	...
> }
>=20
> for_each_set_bit(link_id, &add ...) {
> 	_ieee80211_link_use_channel()
> }
>=20
> list_for_each_entry(sta, &local->sta_list, list) {
> 	...
> }
>=20
> ...
>=20
> for_each_set_bit(link_id, &add ....) {
> 	now call
> 	ieee80211_mgd_set_link_qos_params()
> 	ieee80211_link_info_change_notify()
> }
>=20
> ...
>=20
>=20
> At least I tried both of these ways in hwsim. I dont see any failures.=
=20
> Hence I thought why not move whole for loop to top instead.

Right, I don't know - I guess I should try with our driver?

johannes

