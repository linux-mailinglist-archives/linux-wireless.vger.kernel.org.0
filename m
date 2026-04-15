Return-Path: <linux-wireless+bounces-34817-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJckN/Df32kzZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34817-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 20:58:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DB4073C6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCA63030C92
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3C21CC4F;
	Wed, 15 Apr 2026 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="sjPDwQFS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A3326D45
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279532; cv=none; b=p/JbEuv9J4R7zyKzD0njSe51DRkTNUIFJqVE41VOCpRNKHImovhwvrRmZQ55RNtxfKjQ324tCZpIALkzDiLT3NAn14oqgGfP8gAX+GUGoQ7KtZC9aKGZUD4BtWmu6PZrQOkzLazqhPBPG2UHmfGhyme4iO2Ojgz9Apm0wgV7hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279532; c=relaxed/simple;
	bh=pR36tD0BNqu54mBaPmqnkTUiHL0jlEzXMrsBHSJtrRk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HX0AfYaarp/nr7nfz+C2+QjZtiywRti7dAPMlHFJGZIPABHdAN3YhDfr3qPnFgzBjrFx5RcaBgZ820dIjMb4iXQKSS5vO/1Qf7xo1NWOQq6GJbLKVjOdrSe+ku9rMV68Srmi/UuChjsABG/a3P6G80+vo/SgHog2LSx7gJT7Acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=sjPDwQFS; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1776279525;
 bh=pR36tD0BNqu54mBaPmqnkTUiHL0jlEzXMrsBHSJtrRk=;
 b=sjPDwQFSfB4URSBrn+JOebBsxSMbm5OyvGE2uRC0+QmnlpSYRXhT3bqLxSrvujaGcXa2gx8nb
 gZtGJVL1RnITvL/kJOUyihO/VGpL2PtbMfiGGHEKqdDG2mgs0PMV4sj4SZJLx68S27Y/Nca+yWH
 F64fxYwH8iFXMc7kkXklvF00haIvm2VkYoK2T60758/MH4aN7H1vixQgFmbHV0nSkL4bN3fFH8k
 YDMMW54HiLsPJq9E6xFZfugwZq6ZkGG6dxFNYq7DAm3S8IdBoM5fEikHGpP5f5DydjYZZl4HIDx
 eRhteaOKHOiGnrnynzbSen/NsT98DidUJ9Uo2U/44fqA==
X-Forward-Email-ID: 69dfdfe372b056130e351deb
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
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
Date: Wed, 15 Apr 2026 14:58:42 -0400
Message-Id: <DHTYJFGLKPQ0.RYJIDH2VLV3W@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, "Joshua Peisach"
 <jpeisach@ubuntu.com>
Cc: "Jonas Gorski" <jonas.gorski@gmail.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
 <b43-dev@lists.infradead.org>, "b43-dev"
 <b43-dev-bounces@lists.infradead.org>
Subject: Re: Firmware for reverse engineering b43?
X-Mailer: aerc 0.21.0
References: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com>
 <c62a448843f189d78187de18d3fcb955f2779d13.camel@sipsolutions.net>
 <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com>
 <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
 <DHTPAVC76140.1JLO3HNQARQ9Q@ubuntu.com>
 <CAOiHx=n8awRRvArvG8sWqEokojXL6ppFRJ8_SOuGAddDb1D32A@mail.gmail.com>
 <20260415175748.61aa7993@barney> <DHTW44HOVZLS.GFYBZTKJTMP4@ubuntu.com>
 <20260415194150.291dbe2d@barney>
In-Reply-To: <20260415194150.291dbe2d@barney>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ubuntu.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ubuntu.com:s=fe-953a8a3ca9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34817-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ubuntu.com:dkim,ubuntu.com:mid]
X-Rspamd-Queue-Id: 518DB4073C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 1:41 PM EDT, Michael B=C3=BCsch wrote:
>
> Well, it probably still works well on the (few) devices it worked well on=
,
> because it basically hasn't changed.
> There are many devices which were never supported at all or were never su=
pported
> properly. It's not that just your device is missing to complete
> the perfect picture :-)
>

Of course - but I don't currently feel like bending over backwards for
this one chip. Keep the working stuff working.

> There might be better uses of your time than working on this legacy stuff=
.
> For example working on the microcode reverse engineering and tools and
> get them updated for the current generation of devices is probably
> much more useful. And I think much more fun, too.
> Or something else altogether.

I can gladly say that using Ghidra on the firmware, v4, v5, and v6 is
amazing. Export symbols help a lot, and it gives you a good idea of what
is going on; with the exception of the decompiler giving goto statements
that jump all over the place and make things confusing :/

But again, it's legacy.

As for newer gens - I thought they are already provided by Broadcom
devs in the kernel? I may be wrong, I can look later.

Thanks :)
-Josh

