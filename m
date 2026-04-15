Return-Path: <linux-wireless+bounces-34815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPmoDjvP32m4ZAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:47:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD58406E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AECA3012581
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E12BDC13;
	Wed, 15 Apr 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="YtF897uv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EE41C71
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275252; cv=none; b=oInR8umLxpMEdnhOIFhuMyJzcJsgU7F1lcS6D8dMoZkEXHDjcKMdb6DHVIJ265fCbvSiJ5tFjDva3e3L36etR56TuwoWkScHwnlmC8bhot1zQoU9of2upffv0qxk0X7vuNC2cnYu8AJg77hJftv4ZeBQVsecRbz/uDEd5tj0/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275252; c=relaxed/simple;
	bh=NtB/eWOJij+AJOpCmAPG4LZPrrs0H8n9UE2w9g0Bys8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IB6It0tI9zFfYAh/eyo4ceB/Y9dNMQ5mrE/BUKtX74dJYtJ/C8cgpVyYjWkSkyfsNoIvkzSP7sWy95nSjy53TGLdv+XpM30Exh3dhDS4DzUIiOeeHyngoupSZ8625peXv5gUv6GF1oFK7u7F36DE9tODcei63E7iO9hiHAaASPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=YtF897uv; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1776275249;
 bh=NtB/eWOJij+AJOpCmAPG4LZPrrs0H8n9UE2w9g0Bys8=;
 b=YtF897uvfpHmJo76GRPqlxNxOjklRIZdPi3Xs03/bZEDCH9vygGlsME0iNmi327mJYvP8PCP+
 EFmnE7Y88PdJwrBluSx/ddpvFe+X5Cpd089y4/m1FEXmYVsvSwWjEv/2u53VGIbW8PwZBarsDm+
 5CDSiJbWYnvKygEryVgDJy9DoFXhgclCBEVgYFb5VabUDf/79W2CKut2/dIYpXoR/d8ZBkpw4xj
 ZFY0C+u5mpJpsQL46kbwAq7S+D5n8QW7p2ORF6Ns2dIslVUB6kg0/K34YvWeij6Mu82LKvmk4Zx
 YYXqhWN+yefjxzBkJxysbdUx9DcuDqc98imkvM05322A==
X-Forward-Email-ID: 69dfc52a8929b895becdf89a
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Wed, 15 Apr 2026 13:04:40 -0400
Message-Id: <DHTW44HOVZLS.GFYBZTKJTMP4@ubuntu.com>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
 <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>, "b43-dev"
 <b43-dev-bounces@lists.infradead.org>
Subject: Re: Firmware for reverse engineering b43?
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, "Jonas Gorski"
 <jonas.gorski@gmail.com>
X-Mailer: aerc 0.21.0
References: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com>
 <c62a448843f189d78187de18d3fcb955f2779d13.camel@sipsolutions.net>
 <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com>
 <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
 <DHTPAVC76140.1JLO3HNQARQ9Q@ubuntu.com>
 <CAOiHx=n8awRRvArvG8sWqEokojXL6ppFRJ8_SOuGAddDb1D32A@mail.gmail.com>
 <20260415175748.61aa7993@barney>
In-Reply-To: <20260415175748.61aa7993@barney>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ubuntu.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ubuntu.com:s=fe-953a8a3ca9];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34815-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[bues.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BD58406E4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 11:57 AM EDT, Michael B=C3=BCsch wrote:
> On Wed, 15 Apr 2026 13:54:31 +0200
> Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
>> On Wed, Apr 15, 2026 at 1:44=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu.=
com> wrote:
>> > It does appear to be similar - even the current brcm80211. So much so
>> > that I sometimes need to think about whether b43 is actually a
>> > duplicated driver.
>> >
>> > Since b43 is in an orphan state, I thought it would be a great place t=
o
>> > start for kernel development. 5G doesn't work on that iMac, some of th=
e
>> > PHYs, like the AC PHYs appear to be incomplete - it felt reasonable.
>> >
>> > Because I'm one of those "there's always room for improvement people",
>> > I was going to try to improve the driver, filling out TODOs, fixing
>> > hardcoded register numbers, etc. But if it's best left alone.. then I
>> > guess we can do that.
>> >
>> > That is, assuming b43 is actually supposed to be a separate driver,
>> > because if brcmsmac basically has the same code, then maybe we should
>> > focus to centralizing everything? But then there's b43legacy.. hm... =
=20
>>=20
>> It is/was intentionally a separate driver: Broadcom didn't want to
>> maintain support for obsolete chips (anything SSB, anything older than
>> BCM43224), so the decision was to have b43 support all the "legacy"
>> chips, while brcm80211 supports everything never. Since they were both
>> based on the same driver, they are (more or less) the same
>> architecture.
>>=20
>> But now that Broadcom has essentially abandoned the softmac part of
>> brcm80211 since several years, I don't think there would be many
>> objections on unifying it with b43.
>
> The hardest part in the b43 development always was not to break already
> working stuff. There are many different types and revisions of the hardwa=
re
> out there. Probably in the order of many dozens of variants.
>
> Please keep in mind that changing code means mostly testing.
> Which is hard, if you don't have the hardware variants and basically no
> users exist anymore. Just implementing random TODOs and missing pieces
> will break things. (e.g. not doing some HW calibration or workaround migh=
t
> be better than only partially doing it or doing it wrong).
>

Well, if the regression risk is that high, then I guess I'll let it be.

> I would personally not touch this thing anymore, except for security fixe=
s and such.
>

Sure. I might just make sure everything is using register definitions
instead of hardcoded values, but then leave it there.

> But if you want to work on the code, long term, I would welcome that.
> We could even arrange that I ship you some hardware.
> But keep in mind, it's all almost 20 years old legacy stuff.

The only b43 devices I have are the aforementioned iMac, and also the
Wii. And unless the hardware is unique in some other way, I don't think
its worth sending it to me. Besides, if the code is so risky to touch,
then the only technical change I make should just be to fix my 5G
situation.

I didn't intend to become a b43 maintainer, and given where I currently
am lifewise, I don't think it's worth trying to fulfill that role long
term. Hopefully I'll find areas of work in brcm80211 to work in. It
just so happened that "make sure the kernel works on everything you can
get your hands on" stumbled across b43, which I thought would be a good
starting point.

So I guess this driver just sits here.. not quite pointless to be
removed from the main tree, but not quite worth the effort to bring it
up to speed.

