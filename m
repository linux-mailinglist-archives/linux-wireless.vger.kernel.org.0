Return-Path: <linux-wireless+bounces-34768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOXKHEd632nFTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:45:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DC403FAA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F80930305E3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2E34A3DB;
	Wed, 15 Apr 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="QDN83BKE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514293793C1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253474; cv=none; b=dlYI4f80QDzuXionqSG5zWwKLPE3RpYUZNYj/900/Esqo6BrcSrC7wbTUQeV82WTWFt41RwX14xQdQyagDdplv3tAERGxcq/9Y/POvPJ7zDvodd/3US+Cc0I49XZxavB8IaOMuvqSOkgOXws1rnGcJVn+93MTRKTER7ZcpkiuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253474; c=relaxed/simple;
	bh=RUAMkRMvJIYGpqvgrfry3NMMlM+78pl3rBiEk2MPNJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=C2qWrh/AkUOVQChj/O81NkUmSu+zBw0DIw5nKEEMzTYrIZSMphT5Wt0ddvU9MD9DzxC1QfK+DuUrbdAplcPdAtjxLD7ZL6DW/1pZk3LqIFEjRJTkR/UyubmlDc8lgkZzenUA5jWrI51XIW9R3DEwdNWqzqlkVECEKDR+9veeByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=QDN83BKE; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1776253464;
 bh=RUAMkRMvJIYGpqvgrfry3NMMlM+78pl3rBiEk2MPNJU=;
 b=QDN83BKE1cWlNEOo2GZbV/L2j51jkFNCYXb1gFegdVS/VmJdi/+wpLwdBYv+/WcsMspS//S6V
 l425IoylIS48OxxNQLl6O5Qt478H2Pg6o5r5pT6ZXeKTcCh0PjL9wOBohEy4sY22TDMK2I5qcSK
 ODmt8UTjiHGTU3or1V7/pMFjC+sGfIibrXZQ9pfu+MzJymgFqU0yrQ1ve3NcZrYzUtHOlyws8Zk
 NXtmF2vc6KXOpE4AmKcxC+K8mgPSEAbUvjrCop6Zq7cbVw4qDekgeWvq+Xu0aP+wmYnpENvPNO5
 mE5LbwG4cXmVbnYOa6StLQqfnSpE+7ZH9ZXVyYy0WTCw==
X-Forward-Email-ID: 69df7a17289add7dee9f6483
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
Date: Wed, 15 Apr 2026 07:44:21 -0400
Message-Id: <DHTPAVC76140.1JLO3HNQARQ9Q@ubuntu.com>
Subject: Re: Firmware for reverse engineering b43?
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Jonas Gorski" <jonas.gorski@gmail.com>, "Joshua Peisach"
 <jpeisach@ubuntu.com>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
 <b43-dev@lists.infradead.org>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com>
 <c62a448843f189d78187de18d3fcb955f2779d13.camel@sipsolutions.net>
 <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com>
 <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
In-Reply-To: <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ubuntu.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ubuntu.com:s=fe-953a8a3ca9];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34768-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ubuntu.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D57DC403FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 14, 2026 at 8:24 AM EDT, Jonas Gorski wrote:
> On Tue, Apr 14, 2026 at 1:31=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu.c=
om> wrote:
>>
>> On Tue Apr 14, 2026 at 5:14 AM EDT, Johannes Berg wrote:
>> > I think there's no easy answer - what are you even trying to achieve?
>> > Does b43 not work sufficiently well? Do you even know if some specific
>> > calibration have a tendency to go out of whack? Is there later firmwar=
e
>> > that has some advantage (given how little actually happens in firmware
>> > in these devices, I'd be surprised by that) but isn't compatible with
>> > the driver now, and you want to change that?
>> >
>> > I'd be tempted to say that if there's no problem there don't try to fi=
x
>> > anything, the hardware is ancient anyway, likely has few users, and
>> > those users would probably be fine with just leaving it?
>> >
>> > johannes
>>
>> The BCM4321 (nphy) doesn't connect to my 5G network, so I figured that
>> by filling in TODOs and FIXME's, I could eventually get something
>> working.
>>
>> Other than that, I was thinking of making improvements for the sake of
>> improving the driver.
>
> The initial version of the brcm80211 softmac driver [1] should also
> help in making sense of some of the code (flag names etc). While it
> officially only supports BCM43224 and newer on BCMA, it still had
> remnants of support for older N-PHY revisions, so may help in finding
> differences or explaining what code does.
>
> I once considered trying to clean up b43 based on brcmsmac, but never
> got around to it.

It does appear to be similar - even the current brcm80211. So much so
that I sometimes need to think about whether b43 is actually a
duplicated driver.

Since b43 is in an orphan state, I thought it would be a great place to
start for kernel development. 5G doesn't work on that iMac, some of the
PHYs, like the AC PHYs appear to be incomplete - it felt reasonable.

Because I'm one of those "there's always room for improvement people",
I was going to try to improve the driver, filling out TODOs, fixing
hardcoded register numbers, etc. But if it's best left alone.. then I
guess we can do that.

That is, assuming b43 is actually supposed to be a separate driver,
because if brcmsmac basically has the same code, then maybe we should
focus to centralizing everything? But then there's b43legacy.. hm...

-Josh

>
> Best regards,
> Jonas
>
> [1] https://github.com/torvalds/linux/tree/a9533e7ea3c410fed2f4cd8b3e1e21=
3e48529b75/drivers/staging/brcm80211


