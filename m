Return-Path: <linux-wireless+bounces-35201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD9+L2Fp6GlZKAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:23:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6DD442607
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEF953027314
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FD2E1C7C;
	Wed, 22 Apr 2026 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x5dZ+h4C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD92D7DD7;
	Wed, 22 Apr 2026 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839005; cv=none; b=nzajB8fU+FAEAGPGz7TBwSUKu3p5TpZTSf+/AIKWklk3jqYKA5M7BLHLmRx/jx/xZ/f2JUUG97l+l06JORkkj/xpVvuGiGaWJAfzyzacSFgS3AErYAJM3yW+fsH7NLUBl3DVjvhu/AGXJnzHzvkWexEzv05ncL3IGdauJv3I/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839005; c=relaxed/simple;
	bh=tZrsGnogjpuzH60NrnfUUr8k6szbpD2LTNullhMJUC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6WBa0vz3BsR6WPFKdYHPVafajiTvQT6hH9wjwg1dd4tBWS4P+S7xVz2Kbh47HGO0Aa9+sbqjvwhxSDCawDFaA1TMH1YXaSyK9tiTkchK8yUncwi2ykQmPCwC9UeuaQOb5prshK5GzeVziSzb50jXbroqhJgjrXdsBx092k1/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x5dZ+h4C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p6y/NiW8TSM4diWr1vLU4U7/Xr0/bik8HlZc6tK1KcY=;
	t=1776839003; x=1778048603; b=x5dZ+h4CSd0Yxtrid7SEWFYPnjmOXXzEopFyMxmW2FFdAOp
	XJiKAYk+x5t+OVnwIpEK+ZCGWIBomPZpL4C9Nm0vJWGJsa0i8JeF3yhwx6huAPS8oFHvbVVvzyAA4
	RySY9pjpQYPOYHErlsQYKhE3BnjZOF2q60ZsNtpzrcmiqplrCIbKdglX5qKJPpl/N439PNrdpqXI9
	aEzk2BqMIjp0pzxcgiGiJVMHmstLU/wjtg0W6hxLFt2I9kzAT64/9vO9Ws9T/b8YFOuNdBCepKZyc
	Re+rEo1LuUMPAdJyRsZUmsAl9Ha/WvfZw3O5o9w51ZoUnfIrfpt+/yDOBnfpGh0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFQzX-000000066JF-3Mtd;
	Wed, 22 Apr 2026 08:23:19 +0200
Message-ID: <e4b3f365a32b633babcd4cefde3fc32460e07e0d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>, linux-kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 08:23:19 +0200
In-Reply-To: <20260421224552.4044147-1-michael.bommarito@gmail.com> (sfid-20260422_004558_248010_38F9E184)
References: <20260421224552.4044147-1-michael.bommarito@gmail.com>
	 (sfid-20260422_004558_248010_38F9E184)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35201-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F6DD442607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 18:45 -0400, Michael Bommarito wrote:
>=20
> Both ops were introduced without a .flags gate, so the generic
> netlink layer dispatches them to an unprivileged caller instead
> of rejecting with -EPERM at the permission check.  Every other
> connection-state op in the adjacent block (CONNECT, ASSOCIATE,
> AUTHENTICATE, SET_KEY, ...) carries GENL_UNS_ADMIN_PERM; SET_PMK
> / DEL_PMK were introduced without the flag in 2017 and left
> unchanged by later refactors.  Johannes checked the original
> Intel submission history and confirmed there is no admin check
> in any prior revision either, so this seems likely to be a
> simple oversight rather than an intentional carve-out.

FWIW, this submission did originally come from Avi, but we no longer
have a driver using it (it was never upstream anyway), so that now the
only affected driver is brcmfmac, AFAICT (other non-upstream drivers I
wouldn't know, of course.)

Arend, it does seem like the right thing to do here, but I wanted to
confirm with you and thus asked Michael to CC you, what do you think?

johannes

