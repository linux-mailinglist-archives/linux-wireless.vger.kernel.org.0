Return-Path: <linux-wireless+bounces-25454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC91B054CD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726E07B6483
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AA2741D4;
	Tue, 15 Jul 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QU2S/zmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561A226CF3
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567867; cv=none; b=Bh+hEhOJgJszrzFcueVOMtq1xtqqDjoOukS1QskuQh8swkKrefXcB9JcSn5eeQ23yl1S4iLMVr02SFd3MOo965TbXnAphiWZ8eNIfQ4yI28Ef1lpPl/7/n1HysIniA34jLGkNXo/q1KRZVKHZI/jdZd2vm224cSoaOe2cBJ/LCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567867; c=relaxed/simple;
	bh=goPlUPod258oAtfVyqL8bc8ABijrKZhDzYOX7GDta9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CrdAxD1ABj2flp2eHznpoq8c+tPD+/YXe5UzIP0WdvRcE5KWBF8cKI9tGoq4Ifh7TRCwhSGzAtiJTHeLQfP++KR+9QIzRN/Knqm1EK6we4GhvcD2pR06ojbJhxC6hAeC6HyGGIDkRpoN8r9Oe4GXKQ05/kV2bcpA5Ieu49L5c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QU2S/zmj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DRTJbQ2pz8nbp6jDElJbcTmi81BwA5y47EYAupgTk/o=;
	t=1752567866; x=1753777466; b=QU2S/zmjUdMptKpw/Y40ijJnCQWs5Nz8xbonPhqMRkCzq4c
	ib/ssdtmP4uGDSzRqF5x9KraV6qJEXAbjHbrAk6cJxQbXojA2HYtbUTPoat74s9NPwOQFw7knTozD
	0aFCSafloaGJpcvwv4zBAt4x3B4COUt/B9bJqO8AMRZdYzKKe/2WwtMFARCPaLBW5N8hNyeKpoXDg
	T7oWnfD0krPbWRLRNT+Dg7GUO//ZZoJ2tw4TemAqSpHZ+EvYKLN46bkML6+XMrlOFF3hY29z1vcEk
	3/SG2qdeXl8NDAMsgclQXO8hUbdjjs+39s9Uda3BJD3HxuSgxVLcUC+5Wi0sFGDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubaxa-00000005mUX-09RW;
	Tue, 15 Jul 2025 10:24:22 +0200
Message-ID: <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: cfg80211: remove scan request n_channels
 counted_by
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-wireless@vger.kernel.org, Haoyu Li <lihaoyu499@gmail.com>, 
	syzbot+e834e757bd9b3d3e1251@syzkaller.appspotmail.com
Date: Tue, 15 Jul 2025 10:24:16 +0200
In-Reply-To: <202507142200.D315742C@keescook>
References: 
	<20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
	 <202507142200.D315742C@keescook>
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

On Mon, 2025-07-14 at 22:04 -0700, Kees Cook wrote:
> On Mon, Jul 14, 2025 at 02:21:30PM +0200, Johannes Berg wrote:
> > If we really wanted to fix it, we'd need to separately track the
> > number of channels allocated and the number of channels currently
> > used, but given that no bugs were found despite the numerous syzbot
> > reports, that'd just be a waste of time.
>=20
> This mismatch between "quantity allocated" and "quantity used from the
> allocation" is repeated in more places that just wifi, and I'd agree
> that it has caused some confusion. The intent of __counted_by is to
> track the _allocation_, so my mistake was trying to apply it in places
> where the allocation size is not retained, and to shoe-horn it into the
> "used" tracking member.

I'd expect in most cases it's really the same - you allocate, fill, and
never touch it again before throwing it away at the end. I'd argue
though that in those cases the whole thing is quite pointless, although
it still allows finding out-of-bounds reads.

> Any opposition to adding such a field here, maybe "avail_channels"?

I guess fundamentally not, however, as described here, I don't think it
has actually all _that_ useful. We haven't found a single _real_ bug
with it in the two years this has been around, and quite frequently had
false positives. Now, tracking the allocation size would hopefully not
get into the false positives again but ...

Also, I still have 11 other such annotations that are probably at least
somewhat wrong in the same ways, and I guess it'll fall on me to review
them, since before forming an opinion on how it should be used I just
merged the changes, naively trusting you (and others.) The scheduled
scan for example is likely in a similar situation, though in that case
maybe we don't reuse the allocations as much.

So for now: no, I'm not going to apply any new counted_by() annotations.
It's cost me far too much time for having absolutely nothing to show for
the investment. Ask me again again next year maybe.

If you feel motivated you could help review and perhaps annotate the
still existing ones I guess, I'm thinking we should have comments there
like this perhaps:

--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -54,8 +54,9 @@ struct ieee80211_elems_parse {
         * scratch buffer that can be used for various element parsing rela=
ted
         * tasks, e.g., element de-fragmentation etc.
         */
-       size_t scratch_len;
        u8 *scratch_pos;
+       /* __counted_by: scratch_len tracks the allocation and doesn't chan=
ge */
+       size_t scratch_len;
        u8 scratch[] __counted_by(scratch_len);
 };
=20

which also helps for otherwise understanding how scratch_len is used.

But I'm also not completely sure I've convinced myself that all the
above discussion about allocated vs. used is really the _entire_
explanation for it being such a spectacular failure here.

johannes

