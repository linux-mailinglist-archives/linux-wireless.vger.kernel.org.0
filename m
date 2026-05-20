Return-Path: <linux-wireless+bounces-36732-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM2ABE8nDmr26QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36732-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:27:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DEC59AE16
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEA3430242B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD619374731;
	Wed, 20 May 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="R4pGg+88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1232D42B
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312367; cv=none; b=XUHboZZPXsfmerO0S44jJCT0zmMWXbNZ/3oErWOI6Jtr2GJf7xMzzZPxOQ1i0QmhfMrn0ga4nRt5WuCMvHYcMH7FUxYVRCIenFg4EQOCIPdCNd6sDIRWeZ+L2c1AGyekwwxC1RpoJhThPz+7KAy1yYZoJjtn7IbvxethkEI29ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312367; c=relaxed/simple;
	bh=QiRS2eDU8bKpoVDo418q80Z3Ox4FTtx/mwwg/sLLRZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibcrEvBndPoka/yFMx3QQUAvth9+L0Se4aZ4XucuudieRAiVjaH516V7YvKKaQno4qMIbQ7jpH5O7HgU0Lg5i1bORbt0p46dIkX9rpooSGJdzzLyXMa3/zHq7ha4DFfLwLt/uTEAILqNw2bl5hMB4gybhalJbzqcRyJaaAoxDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=R4pGg+88; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id PoQOwXdFJEZ9tPoQPw3OVl; Wed, 20 May 2026 23:25:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779312357; bh=QiRS2eDU8bKpoVDo418q80Z3Ox4FTtx/mwwg/sLLRZM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=R4pGg+88IEVpNe0Ei/nJ1ocrJT2SThG/bi7VyLr+kZtgLM2uxGsA4IbjWOM7M69TO
	 VHVZUdYiAjKxd/DF4BZLDVLYQ82XqQiv692nTbOtbp/ntZTlEqtZJrPXNOCYW1ZEkZ
	 tqm51YarEr4kMwY+Kw5A88XnPzzvIV/igAB7kkR3YcGUvRAeHRFo7eKLvF/X23P3eK
	 G/980ANyUISBpXXNxgD3SWJ/nUB1ES+au1NoLdbwx6WnRAcRQdWeMiYfxRKyp1tSTF
	 4gS3QXky6KMBIRvOhPQDSDtIzYXIsyKXBlDM1m64Kwd1PewlOfPVTjTNV7YWQIFeYS
	 /5bP891lzmw2Q==
Date: Wed, 20 May 2026 23:25:56 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Michael =?UTF-8?B?QsO8c2No?=  <m@bues.ch>,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 kvalo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260520232556.0ab23b53@fedora>
In-Reply-To: <a052e02c8039b06348119a1ec0b18bf1986a999e.camel@sipsolutions.net>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
	<20260519175812.7ce97ba1@barney>
	<20260519230241.49489a8f@DELL-MOBILE03.ad.smart.it>
	<a052e02c8039b06348119a1ec0b18bf1986a999e.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFmIfqicFKKsNmggrArSj0nxzixVz7gwZFkbTw/jDGoxJPHNQdtpk1VFSUUIDwQhMoh51QUWqNlhy5578dQElfaIDCbNdSB7NsNKIAuJvx5Vn73Gu6/D
 jkYgMa96OSYP5Zvf7W4dRFS+uWE1fY6H0OpfIr0zRuwJMrpTWXRtJhVY7v0JEYsNHLLBmw6Z+OGjhT1uAye8XYHGP56ZxlI66aI6xpt7McMllhxu7Jt9QFo8
 JgBXgbmii/B/P25Rf1S3WB03/x8mvfY2yfrR1nO3n8pcJPWq1xVwonzV2X9J0F5vUNvizdLUdtI9GGyPiXmmcMi7ynLNfpWd3uA7knv7+3j7g4T7z9Qlarwz
 Fmk3z2Vk
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36732-lists,linux-wireless=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mythread.it:dkim,sipsolutions.net:email]
X-Rspamd-Queue-Id: 75DEC59AE16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno Wed, 20 May 2026 13:06:05 +0200
Johannes Berg <johannes@sipsolutions.net> ha scritto:

> On Tue, 2026-05-19 at 23:02 +0200, Alessio Ferri wrote:
> > 
> > The patchset is tested on my own DLink DSL 3580L router and
> > generated by claude from our shared notes, i then reviewed it for
> > sanity and verified it by navigating from the router with modified
> > b43 driver with my phone.  
> 
> I would ask you to disclose this in the commits per
> 
> https://docs.kernel.org/process/coding-assistants.html
> 
> johannes

Will send a V2 with the required assisted-by in the form:
Assisted-by: Claude:claude-4.7-opus

