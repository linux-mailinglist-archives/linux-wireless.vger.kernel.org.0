Return-Path: <linux-wireless+bounces-24665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB87AEDC89
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3041B188CEE7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0906241CB7;
	Mon, 30 Jun 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VyYblwQe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02A23ABB4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285872; cv=none; b=SSsb573SHOyQTIf3Hd/s8ls6V1gfCvir/EqzWSgVbPft0gK3d6Fe9ErEFgdFsLYqIItYNEy6xCo1c7W4VNG6V5i/r/hPuk1rsJtbV/UlzVjKSFjIv4API3ckKxUVElc7T7vSj8TVVSmVH1Wyi4FeivmuAUpuAJ6SbxbrxJEDCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285872; c=relaxed/simple;
	bh=oSuvCxd0deSF+8IMvbA2/ulMGhyIPWsHf1nn1Po0USY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3gm4IQ79XlfnTfpjuU/dyclarwINAtukxvzdSBY8l1UbcWy7BINFctEgfkpc33D+wQVnOP1GZ1Zhlcs8lzpu37XblqxND/dklxe0apuIB4rpI4PAXS+xTP6GzO2ndZ/wJKti7VArwjnXISNnuVdl4hsTfSc7Xtiscwkh50nIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VyYblwQe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oSuvCxd0deSF+8IMvbA2/ulMGhyIPWsHf1nn1Po0USY=;
	t=1751285871; x=1752495471; b=VyYblwQebjFpx93YjCTbLrDD/AkcCewLGJbegjC7VwE3ayr
	G4QzIpjXr1UL8RughflMhFACqRRzs+1u7e7/MgWuBIDUzk3agdm5kHgvNsz94E7wqZMPhbUG78gYA
	T58KTtI6ZK3+5BCaXaNwsdHL11YDwl+wn1cgBSMt4VBw4cQZ4USBdYi5GZWHE1z/z8ZdlP1OEGiui
	INf1M0k9krYC5p6nXsxHSUkIDV6WjxGcdVfA3mlrLsWoB8TPawEgB21BXE08L0p5v/mbb7YcGxpAr
	XkcqtmPtB4ITqXItTHbclVoqAyeo+Xw5x4yZP6Z+/N5d8X0PFfYwteLJEPR9Y8DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWDSD-00000001D9I-2h6E;
	Mon, 30 Jun 2025 14:17:46 +0200
Message-ID: <50b5a8cd4f47d68c1ec5fd46b9c706f74bad0635.camel@sipsolutions.net>
Subject: Re: Linux Wireless Request for Collaboration (AP-centric features)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 30 Jun 2025 14:17:44 +0200
In-Reply-To: <a2b447ca-fe62-49d4-b24a-f9709575b693@oss.qualcomm.com>
References: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
	 <dd5d7dabccee33e81f77163b5ba640841cfe5ac8.camel@sipsolutions.net>
	 <a2b447ca-fe62-49d4-b24a-f9709575b693@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-27 at 07:21 -0700, Jeff Johnson wrote:
> On 6/27/2025 12:39 AM, Johannes Berg wrote:
> > Hi,
> >=20
> > So I held off for a while since I didn't want anyone to think I have it
> > covered ;-)
> >=20
> > > Specific areas of interest at this time include:
> > > Robust AV Streaming (IEEE Std 802.11-2020 section 11.25)
> > > Seamless Roaming (IEEE P802.11bn/D0.2, March 2025 section 37.9)
> >=20
> > But of course generally with my maintainer hat on I'm interested, and t=
o
> > some extend perhaps the seamless roaming overlaps a bit with client?
> >=20
> > Now that I learned more about it though, it seems the seamless roaming
> > isn't even all _that_ seamless, and doesn't require major surgery?
>=20
> I think you have a typo: s/doesn't/does/

:)
(I didn't)

> Seamless roaming is meant to be seamless to the end user but definitely n=
ot
> seamless to the underlying client or the AP code. And although the scope =
isn't
> as bad as MLO (we hope), it is still a complex handshake, and there are s=
ome
> things that will be in our proposal will definitely need discussion.

OK, I look forward to seeing that then, maybe I'm just completely wrong.
Especially the AP part seemed fairly simple from the kernel space POV to
me since it just has to keep the STA alive for long enough to drain out
all the pending frames, while already having redirected the L2 to the
new AP. The APs will maintain two STAs but that's split over two APs
too, so shouldn't be that bad? Although I suppose if you get someone
trying to do seamless roaming from one link of an AP MLD to another link
of an AP MLD ... but I don't think it works that way?

It also has to copy state like the PN/SN etc. but that's also not
architecturally challenging, I'd think?


The client part also didn't seem nearly as bad as I had anticipated;
yes, we have to swap from the old to the new AP more seamlessly, but we
don't have to support two AP STAs at the same time, just drain traffic
while queuing new TX traffic and then swap over quickly without dropping
the STA. Perhaps at a mac80211 level we still create a new STA but then
have an atomic 'swap()' callback to the driver? Haven't thought about it
too hard yet.

> The reason my team is focused on the AP part is that, as reported earlier=
, for
> Wi-Fi 8 we want to transition to upstream for all of our AP products. Our
> primary Wi-Fi 8 client will continue to use the downstream qcacld driver,=
 so
> client design is currently a lower priority for my team. Perhaps Intel ca=
n
> drive that :)

We definitely will be working on the client side.

johannes

