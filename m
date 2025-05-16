Return-Path: <linux-wireless+bounces-23072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78CAB98CF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1CA1BA8A6C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDB22FF4E;
	Fri, 16 May 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o45EMBzt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556917B425
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387790; cv=none; b=a2ZMVqkunwYeao7T3f9YUpZ3wW7AIhqejky8I62Gfjxztq6ligOqJ4ornH95bijARrsrPmsVfQyeEegYnkuP+y2r/Strz7EGYgTxdwOXqzL1N5dtyZ2kaV9U7n0qs+XtytgHNlJ3kFG6707Gd9RjiUgM/4cXA/i8EuydW87j5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387790; c=relaxed/simple;
	bh=q5CO50yhbzeFsHy1hImtV3jvDNccMC3aRZWtBIM8rHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOW6gWHFjlXZaa4yQsJopc/kr5u+WlfBqDiaODxXs/pt+4cgZ7PkvnTdP9jFHYxUSxzq9TMgC6X82MphVIjTievTJS7E1AMYUpEuAKrm+hO89YOs+sR2hHGaEMUCSfdBCmYK6BE1B+a7lVz4Aqg01a54UkHMHG8l2P8JKVqOn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o45EMBzt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q5CO50yhbzeFsHy1hImtV3jvDNccMC3aRZWtBIM8rHQ=;
	t=1747387788; x=1748597388; b=o45EMBztG8UZYQ6aXBR486N0tl1pWIqKDM6X+yowF76si+9
	JaXwwA8jRkLdDfzUrNw5A7qWYy6xIo87UMn4CG0WKdRYcj7vfcvll28aca4zKT13lSJgqnrRdIfFg
	wfNuLzzvTPCHT3H0zgzSKTNXFNHd9+qr6qIKvKuUwAIwJEs5xzWsk7+46ziHDSr16XJKBowUpdGKn
	cNsGGM1NKnxDIRlJuGSnE7o92ef80sur0qhBSIUEgOZSlourpJ+jKav80w07AkUbloK0r0Dip2HZZ
	ofhgUuaeGU4lF6ZZjG0YDfk+xPrbn7aBbVx4iBrVB/Z2PNOotoILbBWupVPEYhow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFrNx-0000000EEi4-0NHF;
	Fri, 16 May 2025 11:29:45 +0200
Message-ID: <30e8968b8acb0406d614d320bdf7f6c1c34c068b.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Date: Fri, 16 May 2025 11:29:44 +0200
In-Reply-To: <aCcD5QLRpbMexvq9@FUE-ALEWI-WINX>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
	 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
	 <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
	 <aCcD5QLRpbMexvq9@FUE-ALEWI-WINX>
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

On Fri, 2025-05-16 at 11:22 +0200, Alexander Wilhelm wrote:
>=20
> I referred to the following EU Rules:
>=20
> * ETSI EN 300 328 V2.2.2 (2.4 GHz)
> * ETSI EN 301 893 V2.1.1 (5 GHz)
> * ETSI EN 300 440 V2.2.1 (5.8 GHz)

Is that really all that relevant? I don't think ETSI has normative
power, that's left to the per-country regulators, IIRC. Who in Germany,
as demonstrated, did a mix of units for the range you were talking about
before.

> The problem with them is that almost always the unit _mW_ is used. And th=
e
> reduction without TPC then is given in _dBm_. However, for 5.8 GHz (SRD d=
evices)
> the transmission power is stated as 25 mW. Does the EU Rules means 14 dBm=
 or
> only 13 dBm are allowed?

It means just that, 25 mW is allowed? I'm not sure you should read more
into it than written.

You could argue that 14 dBm is "close enough" at 25.11886 mW (0.47% too
much), but perhaps that's not something the computer should do, but
rather whoever updated the database. It might even differ slightly per
country, I guess, technically - though here the German document [1]
states the same.

[1] https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Te=
lekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/F=
unkanlagenGeringerReichweite/2018_05_SRD_pdf.pdf?__blob=3DpublicationFile&v=
=3D2


So perhaps the database could state 14 dBm with an appropriate
justification, but the conversion from 25 mW to eventually rounded down
13 dBm also seems right.

johannes

