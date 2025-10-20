Return-Path: <linux-wireless+bounces-28113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EEBF2B21
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 19:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26844189A496
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 17:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE323FC54;
	Mon, 20 Oct 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HEIgDkpP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD612FB618;
	Mon, 20 Oct 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981073; cv=none; b=qg5X9keuQ2P9Xlhnzu2GyM2N3OMvMBpEZK73gzdy62Y/CVOWnO8+1sfUBVYaq3VCyMFkL93wDL1ufD5Cj+r7SRMuxPzMkboVuqifDy8Usam3rslO8/0pA/DwWwZRiFEydsrB4uNkININN69dJUt5RGGKfhVWSgT6iAUOc6uezM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981073; c=relaxed/simple;
	bh=GMRINbJVU7BdoYvauFkAAngbH+xAKnMVrhGHnsTc5Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og0TvV5vFoazw/gqo9c5G682XZ87/PXgRG1dKAqE/nPS4rQYKczhPHL7Dm383r3Mbm6VmcgPax9JyCYuuRqTC/2Bh1OgWQi2hXqqwf0qmmhe+BuSggV73UkdXb7EjNI9zZ+vtTB1z9utUoBI6XvvHIY9QqDrHk1pp3CUEzSYf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HEIgDkpP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=1EQjJzSZx3vQRH4NLG4P9mwqn4qdkH6P67OwZLAR1wI=; b=HEIgDkpPwGTGM1uN
	Dj5Jru8kQatMzdwu+NUF6qOhm5Dq6u82X/j2jcef1gFphJgHQxXZpCuURpceNL6FB8kvWBmDZJIdV
	mjLnoaBruevIhVMe5QryaKGDjPM5ENLEXRKWbQPZUlr0fZ5LzSC+OFFR70ATA2bbKU1zyNifyI9Ng
	Rncr4roD2FYVSdY2A6QU7qFGgK24o59mIj87sopAGh3Ga/lg8PctTZID+r+qYXO+Xep8RS3XDhizg
	6ZZnikaitG0goK/2mIA5VdP0ZfOkD2VBqdoXVvALktbFtAYuG+IX5b5gWcZbUhwX1SShGpw7Do9z0
	8VKmdLF5oTOJNe3OhA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1vAsvA-00HXXJ-2m;
	Mon, 20 Oct 2025 16:39:44 +0000
Date: Mon, 20 Oct 2025 16:39:44 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Remove unused wdev_to_ieee80211_vif
Message-ID: <aPZl0LFtls2LA6uf@gallifrey>
References: <20250619005229.291961-1-linux@treblig.org>
 <aOvZ8FHp7-tliei2@gallifrey>
 <30b9e7eebfc99330857f7a81c72b9eb23ea6406d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <30b9e7eebfc99330857f7a81c72b9eb23ea6406d.camel@sipsolutions.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 16:32:48 up 176 days, 46 min,  1 user,  load average: 0.04, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Johannes Berg (johannes@sipsolutions.net) wrote:
> On Sun, 2025-10-12 at 16:40 +0000, Dr. David Alan Gilbert wrote:
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > wdev_to_ieee80211_vif() was added in 2013 by
> > > commit ad7e718c9b4f ("nl80211: vendor command support")
> > > but has remained unused.
> > > 
> > > Remove it.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Hi,
> >   Gentle ping on this one please.

Hi Johannes,
  Thanks for the reply,

> This was/is used elsewhere out-of-tree, so I had dropped this change, at
> least for now.

OK, I've made a note.

> I guess that's really not a good excuse though.

So what is it about these out of tree things that needs these calls;
why don't the in tree ones need it?

Dave

> 
> I guess drivers could instead ieee80211_iterate_active_interfaces_mtx()
> and find the right wdev from that list, like
> 
> 
> struct wdev_find_vif_iter {
> 	struct wireless_dev *wdev;
> 	struct ieee80211_vif *vif;
> };
> 
> static void wdev_find_vif_iter_fn(void *data, u8 *mac, struct ieee80211_vif *vif)
> {
> 	struct wdev_find_vif_iter *iter = data;
> 
> 	if (ieee80211_vif_to_wdev(vif) == iter->wdev)
> 		iter->vif = vif;
> }
> 
> struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
> {
> 	struct wdev_find_vif_iter iter = {
> 		.wdev = wdev,
> 	};
> 
> 	ieee80211_iterate_active_interfaces_mtx(wiphy_to_ieee80211_hw(wdev->wiphy),
> 						IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
> 						wdev_find_vif_iter_fn, &iter);
> 
> 	return iter.vif;
> }
> 
> 
> but I guess I'm not sure it's really better for drivers to have that vs.
> upstream carrying the unused function.
> 
> johannes
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

