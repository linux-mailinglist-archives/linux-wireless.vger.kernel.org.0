Return-Path: <linux-wireless+bounces-36674-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7OEaIc3uDGqzqAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36674-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 01:14:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE952585F45
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 01:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1AB3021739
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F5369D66;
	Tue, 19 May 2026 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="sv0JPw1R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AF233943
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232458; cv=none; b=bFMfeEZOrqduajy2h8Vx8spyaSjapGhlhOVt9EjyJOu9L53+t2g+AFvlT9EUQSdzIEu9iaGQ6xpFx5QVH1hBfnuc2/di6l1g6G02v3p/+ai1hY3xPnFEsYFWZct27zIuu+coxKGW6xgfZD3IulSL9nHYT44v2SDAN7w4IAN3sXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232458; c=relaxed/simple;
	bh=OpnXccnP1ozNGUSdnlbBvP1rS6zNyiymHfxwBsbuhWU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mM4YfEP0BlNDEkxPQdQXHtxQeQ1I8q3tdhgilOLrdrmW9qJlxi6tb0t8EzUKAmrWV7By9BR/a0IufAm9J3VSJLqZTNqiPOa0PCh4cUGbZj1sfhFW+24jyunhEyiFG5h6aU8ErKX6JmcYUx/Fa/DFelADfEO0NAe3A0L67+N895E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=sv0JPw1R; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779232453;
 bh=OpnXccnP1ozNGUSdnlbBvP1rS6zNyiymHfxwBsbuhWU=;
 b=sv0JPw1RqtGIuHxNwlQOZ1kx0OSSXclHlTdrg6h96IrxlivjRsaceNTo7aJELIwLJG5uuRyPC
 nreP13BXvX+QVKY0afLK9eK1thWdNHIgvwKsLZZs0PfxKzv5VFPq6CMdBc6kJtBwU4GPuhukFfk
 kOeACgCWqekOVBjEou808n3O9axxdv+EfptEZ4VMqBBY3jFwiXYJsy+vc/zPICuhN/mZ1ybXqJl
 JLpXpxXT5/RbOoUZw9J60T4Az2fC4pxEiRoT1kYss357HvaH9UwbQKUs9a+Cqn5EpheY+mHIV9I
 nHVvp3dQzNWdOiZanxepKWqWxFGWSYXYARi3IZx7DaBw==
X-Forward-Email-ID: 6a0ceeb7dba98f5f2747cad7
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
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
Date: Tue, 19 May 2026 19:13:58 -0400
Message-Id: <DIN19EEVA93R.2R8BXOUKWJ0GA@ubuntu.com>
Cc: "Alessio Ferri" <alessio.ferri@mythread.it>,
 <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
 <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>, "b43-dev"
 <b43-dev-bounces@lists.infradead.org>
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, "Joshua Peisach"
 <jpeisach@ubuntu.com>
X-Mailer: aerc 0.21.0
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
 <20260519175812.7ce97ba1@barney> <DIMWK04RLFCG.17KT0R0YCUMRW@ubuntu.com>
 <20260519215244.2a0d2b29@barney>
In-Reply-To: <20260519215244.2a0d2b29@barney>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:email,ubuntu.com:dkim];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ubuntu.com,none];
	TAGGED_FROM(0.00)[bounces-36674-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	R_DKIM_ALLOW(0.00)[ubuntu.com:s=fe-953a8a3ca9];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ubuntu.com:email,ubuntu.com:mid,ubuntu.com:dkim,mythread.it:email]
X-Rspamd-Queue-Id: CE952585F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 3:52 PM EDT, Michael B=C3=BCsch wrote:
> On Tue, 19 May 2026 15:32:44 -0400
> "Joshua Peisach" <jpeisach@ubuntu.com> wrote:
>
>> On Tue May 19, 2026 at 11:58 AM EDT, Michael B=C3=BCsch wrote:
>> > On Mon, 18 May 2026 03:49:33 +0200
>> > Alessio Ferri <alessio.ferri@mythread.it> wrote:
>> >
>> > In general this looks Ok.
>> > From the style I assume that this is AI generated, right?
>> > If so, can you tell us a bit more about the inputs used for the AI?
>> > What information is this implementation based on? =20
>>=20
>> So... awkward question.
>
> Why?
>
>> Wasn't there just a conversation[1] about the
>> future development of this module, that was left off at "don't touch it
>> unless you're going to thouroughly test this",
>
> Sure. That's why I ask about the development methods used.
>
>> and now we are going to have a *LLM* work on this?
>
> I don't care whether code was generated with an LLM or not.
> What matters is the development methods used.

Fair enough. And it was tested anyway :) sorry for any perceived
arrogance.

I would tag Reviewed-by but I don't have a script to check the tables
(there probably is somewhere... it's a personal problem - a "skill
issue" as I sometimes like to call it).

-Josh

