Return-Path: <linux-wireless+bounces-38023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V22qFIbfOmp5JggAu9opvQ
	(envelope-from <linux-wireless+bounces-38023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 21:33:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E56B9B96
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 21:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nhoward.dev header.s=purelymail1 header.b=EBJwVYxt;
	dkim=pass header.d=purelymail.com header.s=purelymail1 header.b=nAE4IqtA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38023-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38023-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nhoward.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108A93075DE6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 19:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619BA3932DA;
	Tue, 23 Jun 2026 19:32:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8926056C
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 19:32:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243130; cv=none; b=TGooEK/2aZyDkUjhivTWmyT/AI79IR13fvsLo97yzaEHAfxchbdHIKytIQZWVUzzI4umniPxwLkI8bLQ0RACtXDaN99ydmVJB7DoaQ1xrQitkVy+RSLmt5YQHusA6RqBZGU0raezwpQJy3PsatOg5GMOk8kATWNsee9vB+t9BXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243130; c=relaxed/simple;
	bh=Nr2aL63sOv9f485z/UhCxW0OunsYshCUH3IQCPyx7X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY7rJVe76WVpsYAA55jQqaY3NXnmtkI7NilyeBz7VSMn4Xq65OJbu7Hx6gZwH3dBDa+GLR8jB9Iym4ZA0v+HhDXS0GkjYXbPGS3jonNZY36I0STGr6AKIGem2wdfI8mnYhmLOdsxbJPNq35fs4eAPxZrCFm6MEbt5iOjmM/GTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhoward.dev; spf=pass smtp.mailfrom=nhoward.dev; dkim=pass (2048-bit key) header.d=nhoward.dev header.i=@nhoward.dev header.b=EBJwVYxt; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nAE4IqtA; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=EBJwVYxtKk62YxLgGLtFNLjkFNauEJm1unuBauKQEKR4iFgJY4H8Pt8uU5rhC3Oe21JNO2VwfLUDeBAfkLF0Lt6IVyi+dPRzgLGFdkAHvv1UEpXad4CEpbCnsYDAGKSBD87HVOOYKlaiQSY4ANqHFuXay73/MOsw78DGZgRfU+fpOThJdGCnMl5XsRQcwSxonP5oa8IVkXf+wFRahhUpYo8DSIO10wxiBXlAgiPmC30AN0X0Yr2n+4BIDQzduOpAUsu18mN4UdfIXAVG2xlWk1/LrWz7Fx9zITomx8SAHWmN5Sftx5jkL6a8Wyro1ktyjBZMCOqYOnpjwg4ixRL28Q==; s=purelymail1; d=nhoward.dev; v=1; bh=Nr2aL63sOv9f485z/UhCxW0OunsYshCUH3IQCPyx7X4=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=nAE4IqtAGyo8QxOv4tzc2TMiu3efeyMIg4BsbN6+auKho8AbbN5w23CzUgmsS7RYR7jmRn6MXGBxzXdJruMTJhp/a7otMkTQ0o4zZ/lthGmw1Qaw274JOpq3WMC2QctuvzNP3zkdq8CGwztaSMb+BwDjpijhTfmX20E2X1WSjNoHWaVlSJqjOEUHrkDkjeLoGvTMnfbvK+19fnqIjuCOLK8yndI9P1JZysvAdbHDWc7HF4GFDIpTigTGSSvGOFgCN/2Vlwv2qnxsmdeMnh3V8QmJzgiOqonjnnruQQWYNKINP+Bisxdo2OOwVxGi6+GgpN4OEeNJdO5xrauFTkjZTA==; s=purelymail1; d=purelymail.com; v=1; bh=Nr2aL63sOv9f485z/UhCxW0OunsYshCUH3IQCPyx7X4=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 823466:39853:null:purelymail
X-Pm-Original-To: linux-wireless@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 420816377;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 23 Jun 2026 19:31:53 +0000 (UTC)
Date: Tue, 23 Jun 2026 15:31:52 -0400
From: Nathan Howard <kernel@nhoward.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yingjie Cao <yingjcao@sigvoid.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from our
 own BSSID
Message-ID: <ajrfKAmdZnPPkGKE@gpu1>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
 <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
 <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nhoward.dev,reject];
	R_DKIM_ALLOW(-0.20)[nhoward.dev:s=purelymail1,purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:yingjcao@sigvoid.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kernel@nhoward.dev,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38023-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@nhoward.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nhoward.dev:+,purelymail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purelymail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D7E56B9B96

On Tue, Jun 23, 2026 at 11:12:20AM +0200, Johannes Berg wrote:
> On Tue, 2026-06-23 at 11:10 +0200, Johannes Berg wrote:
> > On Tue, 2026-06-23 at 17:04 +0800, Yingjie Cao wrote:
> > > ieee80211_rx_bss_info() acts on a channel switch announcement (CSA)
> > > carried in a received beacon or probe response before it verifies that
> > > the frame's BSSID matches our own IBSS; it only checks that the SSID
> > > matches. ieee80211_rx_mgmt_spectrum_mgmt() acts on a spectrum management
> > > (channel switch) action frame without checking the BSSID at all.
> > > 
> > > Because of this, any station in radio range that knows the IBSS SSID
> > > (which is broadcast in cleartext) can inject a beacon or action frame
> > > carrying a CSA element that points at an unsupported channel. The switch
> > > then fails in ieee80211_ibss_process_chanswitch(), which queues
> > > csa_connection_drop_work and tears the whole IBSS down. The members
> > > rejoin and the attacker repeats, resulting in a persistent,
> > > unauthenticated denial of service. Encrypted IBSS networks are equally
> > > affected because beacons are not protected. Since both of these CSA
> > > entry points are IBSS-specific, the impact is confined to IBSS (ad-hoc)
> > > mode; managed-mode CSA is handled separately in mlme.c and is unaffected.
> > 
> > Once you rewrite this to be more honest, you'll see that the whole Cc
> > stable thing and all is fairly much pointless?
> > 
> > Or have you not realised yet that stations can also trivially fake their
> > MAC address?
> 
> Also, since you don't have a track record in wifi, I'll point once again
> to https://docs.kernel.org/process/coding-assistants.html
>

So, what's the litmus test?  I've been watching this list for some time
now.  I've seen (what appears) to be an ushering of distrust brought
on by llm's.  This also seems to have come into prominence within the last 6 or
so months.  I understand the cautious approach, but what if one's been
working diligently (and quietly), and has spent many hours studying and
preparing a driver series (for oneself and submission to the kernel)?
I've always done well by doing my homework the hard way.  But now,
submissions are met with skepticism... that the work must have been
assisted-by if the person doesn't have a track record.  How should one defend
his work (I'd rather not share credit with a machine when my work is my own)?
To be clear, my question is sourcing from what I've seen to be trending
more recently whereby several submissions have been ?softly? tagged as assisted-by.
Maybe they were, but my point still stands.  Kindly provide guidance.

