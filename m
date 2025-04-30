Return-Path: <linux-wireless+bounces-22260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0974AA4B21
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D63A851C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF41253F32;
	Wed, 30 Apr 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A6kEj1E3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DA248F59
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016082; cv=none; b=G9dgDobBfXpFzEFpyV6D2lUdJ8CZkSIfjCJ10JUzdwuTJ5IGsmR3keg0/yAVZfmX8Q0kNdmqJDlsnZ1pcvWDqIa1pHHjHWPZ+trbfPDKMVdqIGOhhq8wK1IkRsKk4Zi9cv9+RGswnBt5r3bTOxf9gZ672pMT6jBS3AC/IsYEPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016082; c=relaxed/simple;
	bh=JchPmd26Yi+a0z9EKcI+gH22ft9fwdAXsV/Z63tDak8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ouNVNQ7VAhaIgbKiUSs57ZIeT0do2QgrKk288ZHKZROxAbXTH3PyJG5RXMZuFsD5FJEksi5NbJEV+PafY/Io9NaF1wgNryVsEl5CX2RIrm+x8QHMUWSaMubxy/J2eJ3X1z9blRVtthjYnhddHn8BYOSZT8mOX4Je7QdyQ0QUPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A6kEj1E3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DvcjdfXvEfZJYVNSbu8MMC5z1QV6bHy+tDSMwStv0N8=;
	t=1746016081; x=1747225681; b=A6kEj1E3gSFf0bG2nbJv8wIEWtLgNqNBZH/hn35oc5sQCe4
	9xAQCNx5+gB4FfqDC8FdtYhAPwUD7EPMhOB/vZ9MpzifWmk0bWiFBFsyI3r6f28Vu0mx2QKm+EfTk
	ssbhdWTYWYEy8nVCi/RyjkInewLhQdWZ5+56TYw6Q79AVyP9SNcCdzSwq75weoM6jecTW5+GYlMFC
	nLEVSkjIY+WE2D2xya2+h+d8prZBhTcjK9lkt1uGnxLSGLfIcDWaGdZi1zLMMpI76JXWZt3H8sEFS
	YFoSKhqxBe82zS0Bk7aZtRq01C1oMIkuX2fctdFV+rCBGEjSMmimJQ3jGfhWCPFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA6Xd-0000000Dlyd-2WpF;
	Wed, 30 Apr 2025 14:27:57 +0200
Message-ID: <b968fa70833b4c8b9da680d91e10ec9754f2a5a9.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>, Maharaja Kennadyrajan
	 <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Wed, 30 Apr 2025 14:27:57 +0200
In-Reply-To: <f447a8290d56eff5c28f22a4fed0458b5dbe8abc.camel@sipsolutions.net>
References: 
	<20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
			 <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
		 <940db15452d6dc9c7f4dd074360bacd2c6f315f8.camel@sipsolutions.net>
		 <SA3PR02MB1008360AEAF6B0DF92E264C49F0832@SA3PR02MB10083.namprd02.prod.outlook.com>
	 <f447a8290d56eff5c28f22a4fed0458b5dbe8abc.camel@sipsolutions.net>
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

On Wed, 2025-04-30 at 14:26 +0200, Johannes Berg wrote:
> On Wed, 2025-04-30 at 12:25 +0000, Maharaja Kennadyrajan wrote:
> > >=20
> > > > +     if (valid_links) {
> > > > +             for_each_set_bit(link_id, &valid_links,
> > > > + IEEE80211_MLD_MAX_NUM_LINKS) {
> > >=20
> > > We just added some for_each_sdata_link() macro or so, so you don't ne=
ed the
> > > distinction between MLO and non-MLO. I really don't like seeing that,=
 if we do
> > > that all the time we have far too many places that would do it.
> > >=20
> >=20
> > We have to loop over the links of sdata here. So shall we use this API =
for_each_link_data() instead of for_each_sdata_link?
> >=20
>=20
> Yeah you can use for_each_sdata_link()? But you didn't.
>=20

Err, no. Naming. That iterates _all_ links of _all_ interfaces for the
entire wiphy.

You should use for_each_link_data().

johannes

