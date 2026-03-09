Return-Path: <linux-wireless+bounces-32763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMTxEHqVrmnRGQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 10:40:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CA23651D
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F3B30364DC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927737AA7B;
	Mon,  9 Mar 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WJROnaU6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F13368B9;
	Mon,  9 Mar 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049072; cv=none; b=RvOgokeaMa3xLeG5sMTdqNJNm+Iy6oFu8FHhpEMrjD0p2z1k006SwCWLRu5z7TprGjsOMDHPV1oic2aLfg/Alp+A+HmrNLJJcCuPtB3W1/8CHkRzTBC/7PA+XblHUyJnurU3WH/Mzuqd5k3dLq7EQ4e7WSIuzpTL/KprAOY1xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049072; c=relaxed/simple;
	bh=mq+nXbWiFXTt5yPaEg+o/4srlFTaKeyflobN3SvOKkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrtgtpdw1W+3KZx+KyMuV10v+LsFsaRbfIiGBsKkdMXE2gyYCPxH6rLMtttSD5a0/PqRHYgwZaIDzVShqlG7FRyEJaPHu/nAVdnBMqUN9l8Bj3MAv1Hr7T13CVcGRy5YGFq09wsembjuFgRhcWh13oMbxVYs6spfAhp7bBLFLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WJROnaU6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mq+nXbWiFXTt5yPaEg+o/4srlFTaKeyflobN3SvOKkI=;
	t=1773049071; x=1774258671; b=WJROnaU60leA3OozBpaJaScuoW1dnE104ufyLeTIWM2nCVP
	k/MOtlH5Ceoq1lfazA6ORCTtHogjoPpPS0awmsRvkoOGaqUWDhndTMuhI/3mSQfkYlp7ReIQTZbaN
	z1EA3Y/NBxov4FPvHZtro89ZHWk2OBcETECmok8OgR7y/fWVk4fyFog20uIwYGbuP7HJpYNWqiEoN
	Tj6aUv3gndQz8o6d09+K6owExhKvjXn5oTLrZKi/r0iH8J/EyIAwrauOpN1BsGz3ee6voHzOXVUEK
	w2yr5yvLECW5pNqOqpUbpEAR1PEdO0kljYPQy11VqvcCWT4ATtZWWmDIbz0GII9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vzX3b-0000000CpyL-31UD;
	Mon, 09 Mar 2026 10:37:47 +0100
Message-ID: <888ab7ed9c72d19765e87f00b17dd95963cbca18.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge	
 <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 ayman.grais@morsemicro.com, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Mar 2026 10:37:46 +0100
In-Reply-To: <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz> (sfid-20260309_102319_807825_CD4D4D5D)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
	 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
	 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
	 <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
	 <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz>
	 (sfid-20260309_102319_807825_CD4D4D5D)
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
X-Rspamd-Queue-Id: 8E1CA23651D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32763-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 20:23 +1100, Lachlan Hodges wrote:
> That's the goal of course. As for future work, right now both the
> kernel support + this driver is about as barebones as you get so we
> intend to continue expanding that. It felt best to push the driver
> now as the bare minimum such that people can start using the upstream
> S1G work. We have a lot more to do.

Right, that was definitely sensible (and something we've requested from
others).

> We expect to see some larger features - including monitor mode, and
> mesh in the near to mid-term future within the driver itself, but the
> core development will still remain in mac80211 & cfg80211 as we
> extend the S1G implementation.

Sounds like there would be quite some co-development with cfg/mac and
the driver, which is probably simpler if I apply driver patches too,
otherwise you have to synchronise pull requests to when I apply patches
to my tree? OTOH, to pass the bot checks you already have to do that
anyway, unless sending cfg/mac/driver patches in one series, which also
isn't great since it ends to bury the cfg/mac patches.

> As for workflows, we are still figuring that out for ourselves.

I'm actually not worried really worried about this driver at all, tbh,
since you're clearly around. :) But there's always a chance that you
also get patches from other folks.

I'd prefer if you could create an account on patchwork.kernel.org, and
then I can automatically delegate patches to this driver to you. Whether
or not you then re-assign them to me in patchwork or collect them and
send a pull request is somewhat secondary, but the latter obviously
makes things a bit simpler for me. If you _are_ going to do that longer
term than just the initial driver, probably should document a T: entry
in the maintainers file too.

johannes

