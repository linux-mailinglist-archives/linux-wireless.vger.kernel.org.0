Return-Path: <linux-wireless+bounces-27442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928DB7D5A0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B151467735
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D3337E93;
	Wed, 17 Sep 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VvTSAKbO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA3337E98
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111789; cv=none; b=LJW1k9PvhcBJnLmhPDzOdgItAPEA2pzzmuPM2vvemqloLKwbrX326OuG19DDZVf8bePNvVL7Z8aG2ZLtGgTY/qpJwTUJxXrl7mJmJl6VOEVTRyIGsuFwKgryiXgAYrbKMWsfSLfslRdeDIkWj5pMOk70waPYlbUsx3UX4mss5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111789; c=relaxed/simple;
	bh=62yh3T9RNbBp4FgCB/WvAuvarvzwDp2pE/lLHBYj/GM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IC3jeb04ZmDo1b3Yq48BIllphgzW93HL5o6lS9kFZeXscFsrKTCbslAiZDLrMQjT8CwUGZRhYZhk/ruHexWHiXNG9HRf2Is0HK5XGla6B/Tx56bVPOY5taRDicQz6HA4MvDzxbUX6Hc+ZidYNeeLzWNvvF10y7S+8weg0Xm+Epc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VvTSAKbO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MNK45GBZskjMv9XEtqRFpO83H0cVR+kE/Of7Hqy+0Y8=;
	t=1758111787; x=1759321387; b=VvTSAKbObwsgHeqtG1Py7BTrJ2c+9JfZIfGKjGgE+qQzBJ/
	NKbN+eoMMVc11aw6piBI68ntARxCFWa/NdEn7JzYTaIeVFIFI/Dy73p6KVvqG1SwzieNzwtHkKAuz
	xGoy1fvnLwHoOdRjQxuQpNklnOsGuGATFLMVCVi9mpKbFrDA91WeEhHgFVysJp1fSdL/fndTqHJS/
	bdlSugViwEh92ffUl6wvV8coZnAACvkSc39oRXL/6/Pj5O/L+J4d+WWU/5r+Frt4eGQxmu4AWM9/n
	uIOHB5nhxNj9ZOVETobnwvfMzcKPvPl6xEphP6iRXO8S0vPO9rYEKkvr/YQwQxOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uyrBh-0000000Auyy-1Zbq;
	Wed, 17 Sep 2025 14:23:05 +0200
Message-ID: <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, wlan-kernel-dev-list@infineon.com, 
 Carter Chen <Carter.Chen@infineon.com>, Owen Huang
 <Owen.Huang@infineon.com>, Ian Lin <Ian.Lin@infineon.com>,  JasonHuang
 <Jason.Huang2@infineon.com>, Shelley Yang <Shelley.Yang@infineon.com>,
 avishad verma	 <avishad.verma@infineon.com>
Date: Wed, 17 Sep 2025 14:23:04 +0200
In-Reply-To: <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
	 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
	 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
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

On Wed, 2025-09-17 at 17:48 +0530, Gokul Sivakumar wrote:
> On 09/17, Johannes Berg wrote:
> > On Wed, 2025-09-17 at 03:47 +0530, Gokul Sivakumar wrote:
> > >=20
> > > We have split the driver into smaller commits to make the review easi=
er,
> >=20
> > Now I guess you should also split it into a smaller driver that doesn't
> > try to be the kitchen sink from the get-go ...
> =20
> We acknowledge that the number of patches are more and the review bandwid=
th
> is limited. We had modified our internal WLAN driver source code as per t=
he
> linux kernel guidelines and submitted it for upstream community review in
> the v1 patchset, based on references from earlier instances of how new
> vendor WLAN drivers (Ex: ath drivers) gets submitted for community review=
.
>=20
> Could you kindly clarify whether you are suggesting to shrink the INFFMAC
> driver source by having limited functionality, as part of the v2 patchset=
 ?
> I guess, that could help ease the review process and the other files can =
be
> submitted as incremental commits later for further review.

Yes, I'm definitely suggesting that. I don't see why you need to have a
driver that has everything in it from the start.

It'd be much easier to start with a reduced driver that doesn't have
everything, in particular not things that aren't already common and thus
need more careful review, perhaps even from experts outside of wifi,
such as the sensing part, XDP, offloads, and probably more.

(On the offload part in particular I'll also note that we're not going
to be adding module parameters, alternatives have been discussed
elsewhere on this list and/or the netdev list.)

>=20
> > >     This driver also introduces a new wdev interface (non netdev) typ=
e
> > >     =E2=80=9CWLAN_SENSE=E2=80=9D in the Linux nl80211/cfg80211 layer =
to allow 802.11
> > >     frame transmissions with a specific MAC address, which would be u=
sed
> > >     by the device during solicited WLAN sensing measurement.
> >=20
> > And this _really_ isn't how things work.
>=20
> Ok, this probably needs modification, we will come back on this topic for
> further discussion in the future. For now, we will prioritize other drive=
r
> functionalities. Thanks.

I really don't know what it needs, but it certainly needs to not be
hidden in a huge "new driver" patchset.

(And on that note, I'll say that I'm almost certain that we'll simply
reject the hidden vendor specific stuff inside of the general APIs.)

johannes

