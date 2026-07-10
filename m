Return-Path: <linux-wireless+bounces-38851-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PW9dOP4BUWp+9wIAu9opvQ
	(envelope-from <linux-wireless+bounces-38851-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 16:30:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E673BBFF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 16:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=kz6NjpeR;
	dmarc=pass (policy=none) header.from=dolcini.it;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38851-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38851-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A0F3053DD3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A430348C61;
	Fri, 10 Jul 2026 14:23:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AF2E762C;
	Fri, 10 Jul 2026 14:23:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693398; cv=none; b=q/OgGrAeswvhuusrY7lI6VaSD9Axl6vNo6df7yocQY8C3O8vITimIJd4HVmnkS0rI+vov7oMIfjMAHOZHvQ9vRqK7J85Nu5Gs9Z/hB5ucCv4uXZNVOPFbCY2GgHNaAPzWtmUPlLeudFJOXIKnEzr+mSkP3b5gPtMnBsrPcFTb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693398; c=relaxed/simple;
	bh=r7/9LOboyLHHkT/0tArXdh/IvtIzxUswzEgA8gjenPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EU1Ar6C3LnvNceMqxppSdeoMjOtwSG31mD0ZRcFsX8oWkq20Of60J1h73unBZZREGrF1Md+ipGQX6uO6ZP5ivlqvaLj70rSCOMVGYnTZMSMfInZv3REoPbJdZ9btVzLVd2jxMTHAuqQFMJEZa1kBBqSr3HVGwQCoHzgh/5L/aXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kz6NjpeR; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 38E9422DFC;
	Fri, 10 Jul 2026 16:23:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783693391;
	bh=JlXhDK3SpK/AwHtqfGwbsNmOHHv27/h4myvZJQX2l3Q=; h=From:To:Subject;
	b=kz6NjpeRbTYmnfuDSIt8IL2piA7VkTT8eogW4xffawLKWHPrTsiiLLiqC5YZUrc94
	 wV1D27ma7RHGY+kFRiABCthGssea+3chpcUtqZ5FoCAhMvzi4n1D6TkHI+ZmqIBGFw
	 SMaKOTJnUCu1sHC6FfLid7nR6f1oB9h+G91mpfeoHrjyCf20I/3pQ6Z7D4aE+Y4eOl
	 Ym0Vl/m8OUA+b/9HBUzmPq+BdAZWPgil0AiNkLzr+GsU0WQC0Zv3sgotYlltXAY3y/
	 fL99RSPJt2brJnx/+yLgdqDDC3Um4dY5ZsGESQkmmS5FclCXOTeplB2fTUQWclwMkA
	 2xmOrLlV4gAxg==
Date: Fri, 10 Jul 2026 16:23:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Johannes Berg <johannes@sipsolutions.net>,
	skyexpoc <skyexpoc@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: bound uAP association event IEs to the
 event buffer
Message-ID: <20260710142307.GA77999@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b98582b-1120-46ff-8fa6-fd30a6b13016@Canary>
 <1462bcdb0944bfd3ae7ac9618cc59ab6cf75dfc6.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:skyexpoc@gmail.com,m:francesco@dolcini.it,m:briannorris@chromium.org,m:miriam.rachel.korenblit@intel.com,m:kvalo@kernel.org,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-38851-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,francesco-nb:mid,vger.kernel.org:from_smtp,dolcini.it:from_mime,dolcini.it:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6E673BBFF

On Fri, Jul 10, 2026 at 09:41:26AM +0200, Johannes Berg wrote:
> On Fri, 2026-07-10 at 09:21 +0200, Francesco Dolcini wrote:
> > I think we received a few patches that are validating the data received
> > from the firmware (including this one).
> > 
> > I did not review any of them yet, what is your opinion on those?
> > 
> > Should we consider the firmware trust-worth or should we validate
> > everything we receive from it? Is there some agreement on this topic in
> > general?
> 
> I don't really know fully "in general", but I/we generally treat these
> as issues. I'm not going to worry too much about them, but I think we
> should fix them.

Ack


On Fri, Jul 10, 2026 at 07:44:27PM +0900, skyexpoc wrote:
> > Should we consider the firmware trust-worthy or should we validate
> > everything we receive from it? Is there some agreement on this topic
> > in general?
> 
> For mwifiex there's a concrete reason not to trust it: besides the
> SDIO/PCIe parts, mwifiex also drives USB dongles (8797/8801/8997), so the
> "firmware" can sit on a hot-pluggable, potentially attacker-supplied
> device. A malformed event from such a device is the same threat model as
> any other malicious USB peripheral, not just a hypothetical firmware bug.

...

> So I'd say it's consistent with how the driver already treats
> firmware-reported lengths and agreed, worth fixing.

... and ack.


Johannes, Brian: I will try to review those patches, unless someone
gets to them earlier and they are merged.

Francesco


