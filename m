Return-Path: <linux-wireless+bounces-36670-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ5qCJC7DGo+lgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36670-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:35:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E799584383
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E41903028EF6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7E3A451D;
	Tue, 19 May 2026 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="akCew3s+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DC37701A
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219192; cv=none; b=Z28H4FRK0hOLLevnxXxe40h3D8KuZaqadVWS5QUS2kalPRS7kPsRb7jz7g0Rh7GKXgtD3u6e+ROeJJ9ZI6XwX98+PBeWAIqr1+z5IvAPGda27sEwenmYPuce8rnQ8xJooJZPogsPwzqvCfKcGpp8cZRUMdnX0euvbTsqqgDPnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219192; c=relaxed/simple;
	bh=TtM2W9AwNWKVP95jJPXeNWdZKkI7gPqVnCltipJQpbM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jo9I1NxOY7eQWuWW06In0JCINRLffh4A2W7Rz9HqhyFf8yd1Hap3XLAeNUcPqdqrnEbRE5s5QQqBKE505yuem4wG2wXBqRw5GD6p49cNfKP4CsAkVRX58D9AIGcm+rLK1Y30ViC7fh4PqRJLtRXzJlvO/ZggTrXA+PhzNnkHuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=akCew3s+; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779219172;
 bh=TtM2W9AwNWKVP95jJPXeNWdZKkI7gPqVnCltipJQpbM=;
 b=akCew3s+F8yoX1yE4/ow0RTWBa5v832uFq/ZXBosEK/9n+N9savRObVOlZEe9AxjMHVJR/f75
 iAqIJviFOmHMB7hTYwb8LvHPh4c9GC/8Wse2UIpUhb2BtRi8op9NMZ0CKhcsnPtHZPlYMLHvp5i
 dsjgTqzwT77ZwofQCr0H98zMfi8uN+y8vQxnd/Lzg4jch2vj+RyIqHSvk/0dxEpf40Wq2Ey39ZI
 Sx+14JauyZbN5FGIWxyiXa9B4nbaKGprbL56T0Is5QyycAdHdC2qEUgt/YFOzSmA+F93+p0n1sM
 bSSpRBrxjtmirUZcuxpiInPbuRkiluTybL3CMqUpw80A==
X-Forward-Email-ID: 6a0cbadd1469872a31cd8465
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
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
Date: Tue, 19 May 2026 15:32:44 -0400
Message-Id: <DIMWK04RLFCG.17KT0R0YCUMRW@ubuntu.com>
Cc: <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
 <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>, "b43-dev"
 <b43-dev-bounces@lists.infradead.org>
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>, "Alessio Ferri"
 <alessio.ferri@mythread.it>
X-Mailer: aerc 0.21.0
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
 <20260519175812.7ce97ba1@barney>
In-Reply-To: <20260519175812.7ce97ba1@barney>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:dkim];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ubuntu.com,none];
	TAGGED_FROM(0.00)[bounces-36670-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	R_DKIM_ALLOW(0.00)[ubuntu.com:s=fe-953a8a3ca9];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ubuntu.com:mid,ubuntu.com:dkim]
X-Rspamd-Queue-Id: 7E799584383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 11:58 AM EDT, Michael B=C3=BCsch wrote:
> On Mon, 18 May 2026 03:49:33 +0200
> Alessio Ferri <alessio.ferri@mythread.it> wrote:
>
> In general this looks Ok.
> From the style I assume that this is AI generated, right?
> If so, can you tell us a bit more about the inputs used for the AI?
> What information is this implementation based on?

So... awkward question. Wasn't there just a conversation[1] about the
future development of this module, that was left off at "don't touch it
unless you're going to thouroughly test this", and now we are going to
have a *LLM* work on this?

That aside, I don't see any obvious issues in the patchset.

[1]: https://lore.kernel.org/b43-dev/DHTYJFGLKPQ0.RYJIDH2VLV3W@ubuntu.com/T=
/#t

