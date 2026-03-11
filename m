Return-Path: <linux-wireless+bounces-32986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM2bC09YsWmGtwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:55:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA182633AF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCE883016294
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B203D2FE0;
	Wed, 11 Mar 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="srBYu2td"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AF3DE420
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230150; cv=none; b=QjBaer92R6n8XqhwIyGAefjJy2cqSNKxxCbqfgn4ZbSg8yKAPUfmS0UeBXwJozsVBAukeJ3GCO7r2iu0h7Bo3e46kkm6Ajn4wD/cZZO2M6r3Cw0E3sLzUKfhS65ESzyYPy1ybg/Kr63zlFY6xkEbQ97OO9IssJuH4rlRVbsiKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230150; c=relaxed/simple;
	bh=aKKgePj2Hdk5awUGelvL7/TV3NL6v0+frxqTVFzSfaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EMjQ3ip0NNZnDgE7TS+7YwmvZR1PX0/ZLWcsjEmOvAlJ0DpBWwJexj1Zr++oOjke7dPvFC0nsVpUiMm2QSRcdDzZjANey3VvsZB8n/v0X1iN2CnWNqldkBMCuJw+F+ZRFWkfMdi8Tp2yt23OH+U9t0xs5mizw3gEk6y5U91b8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=srBYu2td; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aKKgePj2Hdk5awUGelvL7/TV3NL6v0+frxqTVFzSfaw=;
	t=1773230149; x=1774439749; b=srBYu2tdkZgn57D/lCclPvmhSX6h7A5axchGiGpnpTkvI35
	B6IOBhQ+R77NxgHUC3f/AqezLux+OOSZ4canRLOBf5HNndZV0ndSuKFjauzxZHe6xPmrqwwXNAMiF
	wIe/nbEBvx/trU1whqWPFYcU9bogcHp/D8S3ryzM9my74r8FHzR0l3o5eMK1Zjy7CK5Vki0vf3BZl
	PBbXj7qtAuCGLZzQotxQRTy3i8wnWpuvqL5QCdJs6JvludqiwQEDIgdnNyZwDt52FcJEGDZV88teL
	IvtDeqTvX+72spvzHJ9ux8TsBA413tm2TzzPlagg4EgUr7dUyNI3ruxid0xhA7VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0IAF-0000000EqVX-0CLH;
	Wed, 11 Mar 2026 12:55:47 +0100
Message-ID: <6832f8f0b516157452bd9c23b7c7af087d63d425.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 11 Mar 2026 12:55:46 +0100
In-Reply-To: <6eitsqhsmmhwgd3cobhpdhhzn5m5siw4ser53g3ilvd7kdhy2u@rkilpa5ek26y> (sfid-20260311_124857_985665_F5855D3D)
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
	 <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
	 <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c>
	 <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
	 <6eitsqhsmmhwgd3cobhpdhhzn5m5siw4ser53g3ilvd7kdhy2u@rkilpa5ek26y>
	 (sfid-20260311_124857_985665_F5855D3D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 9AA182633AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32986-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-11 at 22:48 +1100, Lachlan Hodges wrote:
> Initially reading this I was a bit concerned because it means any
> path calling cfg80211_chandef_create() wouldn't work for S1G

Yes, I agree, but I tend to think it fundamentally doesn't work for S1G
anyway the way it's defined with 20 or 40 MHz width. Now you had
somewhat made it work by just ignoring the chantype, but that seems
confusing too, at least in the long run.

> But it's
> actually only a couple of places now that call it and - being forward
> looking - for example with channel switching we would probably have
> an S1G specific path similar to processing a S1G connection anyway.

Right, for mac80211: I don't know if you will have IBSS on S1G, if not
that's right out, TDLS might be an issue, mesh support is probably not
there, HT/HE operation elements (util.c) are irrelevant, which basically
leaves the one I patched, and CSA that you mentioned.

For cfg80211 it's a similar story, but maybe we need to look - but
anything that can hit 60 GHz today would already be invalid too...


> No
> important paths (will confirm this) call this function anyway they
> seem to build the chandef locally.

There are a lot of places calling it in drivers so I don't think we can
remove the function, but all existing drivers without S1G anyway. In
mac80211 there might be paths, but then with the warning I guess syzbot
can find them ;)

johannes

