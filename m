Return-Path: <linux-wireless+bounces-22715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16FAAE0B9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC814467D7C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F2205E3B;
	Wed,  7 May 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="csqTx04s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A8287508
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624467; cv=none; b=OE5rBvn3/vRvzbM56nvgUBM+0o5CIPZefn2MXTwMzhl5Eg9eFXxQ0qODMerpxL68CyXxyZFHGsPl7LGU/ikCWnoXWQMKp2OgM+psrBKdMGV/vHxyiHLNgRDOkjBdhB8RYK+ZVnInkc+FnDwRSO+x7rOaeMfsvTefZCxGTDdsGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624467; c=relaxed/simple;
	bh=1ztAGyBwbQdxHwJWpjZcO6/NAx4xVe/xiys8r1aG98E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6SYtjepMpMOfcZtNZsBXXcAdeBKvnHnvZj2DO3vh0jdt7XXd+BxFYRc+bhTXZryBzCDyt5+5rPkgS1RDFtMTjBf6LLs+z0Y3ZhHelt+WrBJdkw+0Y8C03TldNUA9lYj17szgXbMZwK+a4sZqJR0OmY10lQ7dOYobChHlHoAgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=csqTx04s; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qG944cGib6NmJS9IZziJhtbgXoo/GfsF/XZuY82SQNk=;
	t=1746624465; x=1747834065; b=csqTx04snEca3qseAbs5GNvSizhaBRnR1KzDcXixFjgv//G
	or87Q+Kmj0AgOYj824GMT49x+HKR9zLz+RF9/1Omvb67NQ124EdS4GXMidsnk0h6Zv49w9fjPPw1h
	TNHks3IkrQ9TRr1NO0TSIjmg/i1x/dxGCs3xqsncF4XWv90a6YJoRuRbEDRLVwjf9/VI+SPIkQzIk
	oCShZPOQu34v50QKlXRcYTGJo7SHdn1St2IlkLuzKHYInHGr1lJXWntMrbWVlQddge/O7XmLCyJWM
	TQCJt17kquM1wJxyy+WOcJmJVJOh5IqwchJ/LAxed0Ft/sZmxbLU93cMYbhvt8yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCeoH-000000082iC-2efO;
	Wed, 07 May 2025 15:27:41 +0200
Message-ID: <a12320b826ef7395bde044d9dcc7ad9f902c6ef9.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 07 May 2025 15:27:41 +0200
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
> Sarika Sharma (11):
>   wifi: mac80211: add support towards MLO handling of station statistics
>   wifi: mac80211: refactoring sta_set_sinfo() to add support towards MLO =
statistics
>   wifi: cfg80211: refactoring nl80211_set_station() for link attributes t=
owards MLO

These three seem fine, modulo the nits. But of course that's just
initial refactoring anyway.

>   wifi: cfg80211: reorg sinfo structure elements for MLO

Here I'm really not very happy with the massive changes in all drivers
that now have to use link[0]. Especially since you later add back the
station_info statistics again for accumulated statistics anyway ...

But to be honest I completely forgot all the history here. Looks like
your initial patches couldn't even build, so I can't compare well with
what it would've looked like before.


I think it might make sense to treat "accumulated" and "non-MLO"
statistics the same.

In the accumulated statistics you add

+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	u32 beacon_loss_count;
+	u32 expected_throughput;

and realistically we could also have _most_ of the others (not all
really make sense though, admittedly), I think it'd be easier to just
*add* per-link statistics instead of refactoring things completely in
all the drivers, at least for an initial version. We can see more
cleanups later.

We can also prohibit filling entries that make no sense for multi-link
statistics when provided on a global level, though honestly I feel like
for most of them we should actually provide some value, even if tx/rx
rate is just the best rate of all the links, or something like that?

However especially initially as the code isn't complete, we can also say
that things like pertid stats aren't allowed on the STA level, only on
the per-link level, if per-link statistics are provided at all; that
would save some code in the accumulation in cfg80211.


So I think overall it'd be nicer to

 1) Add a separate struct link_station_info to what we have now
    (instead of refactoring everything from station_info into that
    new struct).
    Maybe also need to see if everything really makes sense - you showed
    the connected time as global in the commit message, but have it per
    link in the structure?
    This would also not yet require any drivers or mac80211 to change at
    all, since it's just adding a new capability.

    Oh, in terms of allocation - the struct isn't huge now, do we even
    care about simply adding 15 links? It still stays well below a
    page as far as I can tell ... keep it simpler for now?

    That also saves the back and forth you have with patch 08 where you
    basically just add stuff back that was there before. But now you've
    already converted all the drivers, needlessly in a way.

 2) Add the needed nl80211 to show the per-link values, and that then
    immediately requires the accumulation logic. For values that we
    don't have accumulation logic for (yet) we can suppress the ->filled
    value, possibly with a warning/message?

 3) I don't think we need this wiphy flag really, as long as we have all
    the links allocated we can see if anything was filled. If nothing
    was filled at all we can know the link wasn't there?

    But also that's to say that it doesn't really _matter_ if a driver
    has multi-link or not, even if it has multi-link and can only
    provide accumulated statistics then - apart from it having to figure
    out how to provide the rates if it wants to - that should be fine?

Up to this point the this outline should give us maybe a slightly less
efficient internal representation, but an internal representation that
doesn't require changing hundreds of lines of code across every driver.
In fact, it should require _zero_ changes in any driver up to this point
because it's perfectly valid for an MLO connection to provide *only*
accumulated statistics (of course not what we want, eventually.)


Next=C2=A0would be actually making use of this, of course, which is more
work:

 4) If we now have station_info with links[] in it, statically
    allocated, mac80211 can be refactored to fill that, basically what
    you have in patch 9 except without the allocations.

 5) Patches 10 and 11 basically stay as is.


I don't really see _much_ disadvantage with this. Yes, we allocate more
memory, but these are ephemeral allocations, we don't even hang on to
them very long. An array that is literally of structs rather than
pointers to them is easier to deal with. Having pointers would also
work, or having fewer entries and not indexing by link ID, or having the
per-link as a variable array at the end and then it's still an array
just allocating how much it needs ... But I'm not sure that's all even
worth it for an allocation that'd now be ~2.7k and very short-lived? And
allocating more smaller structs probably isn't really all that much
better than one bigger one either?

Anyway if we find an issue with this we can still rework the internals
later, but I'd rather not have so many driver changes unless we know we
need them.

johannes

