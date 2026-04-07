Return-Path: <linux-wireless+bounces-34442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHZ+L8aj1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:27:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C53AA43A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212C33043FA6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21985378805;
	Tue,  7 Apr 2026 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IVery5rZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6B3845B2;
	Tue,  7 Apr 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543134; cv=none; b=RJTYLYle9l5xByWartgFXjz7Q+ds9hix/GeRBaA2g+tyF9gPLUyeE7Lg5zrpRkI2SUKBDHRAiSp3T9ZIsxFGQWsX4Sj7+nlMfwBuM6l8+/BfmknwC7Std+nXvKdZU3TprI8m/HYjXtlGRcpADDjicmH1bq1Z4/ZD5EyC7/kYLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543134; c=relaxed/simple;
	bh=7myyrQLyPFYxdKfnkSXwkzBuz3EJBZB6Q5+S3A0CE+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYNSXea5XSg0kvXar4b5L/J9hIkNcj7tbPNBed4CoLI7buGmk/nVbQ+4WghTQqw5j7miD89z/E2Mmc+XcOICWanEW9jVTsJSIIS9ZeUR/7tfz+e3tpdk83SFxOqNelUUjycLNOYv+QI6HQgimhe57ekHVh5e2fasFhJyPhh4AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IVery5rZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f34iJLD9ZZePI8PF+bqyMD2gigAtlHfku0r+4VhOe40=;
	t=1775543132; x=1776752732; b=IVery5rZ3BU4vpMv+3oWBYQy7Bd3rV0amTl2oK7WCzPD8U/
	KI3bIRp3N+ueIaBYrBE2L9wrvtQfup306oLiyW2aKGVcyy3O08OcMw4p40obMO4RNLHNjGR/vtAGJ
	cdE5p2vco/cIOF5dnhCMPvDbS2fax/QiNxMJBygb2EaHGPsqzOOI7G4Ccqnl7j+22XgnP9xbHEIoj
	GnS/Im8IP7l8Av7FU0mpXj1dKK3473qdtrusgykKgPQ5/CFpwpYU1sUPxcxcDfo4iY9bkUpQKoBNO
	W0LP7rvqurqiCDSAr9PhjEWSiYeJADiVTCP3il2nccFBlVDfPYHLVwDlB+fTL/LQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w9zUc-0000000C2JF-2VsW;
	Tue, 07 Apr 2026 08:00:54 +0200
Message-ID: <7f69d6e6c2057858eda5c65ec77be44d72c6ac78.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu
	 <herbert@gondor.apana.org.au>
Date: Tue, 07 Apr 2026 08:00:53 +0200
In-Reply-To: <20260405052734.130368-1-ebiggers@kernel.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34442-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 239C53AA43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, 2026-04-04 at 22:27 -0700, Eric Biggers wrote:
> Michael MIC is an inherently weak algorithm that is specific to WPA
> TKIP, which itself was an interim security solution to replace the
> broken WEP standard.

Heh, yeah, we keep thinking about whether or not we can remove either of
them completely, but ... backward compatibility is messy.

> Seeing as Michael MIC is specific to WPA TKIP and should never be used
> elsewhere, this series migrates those few drivers to the mac80211
> implementation of Michael MIC, then removes the crypto implementation of
> Michael MIC.  This consolidates duplicate code and prevents other kernel
> subsystems from accidentally using this insecure algorithm.

Makes sense, mostly.

The one thing that feels odd to me in this is moving it to *mac80211*
specifically, and then using that in the ancient drivers. Not only is
that a big module those don't (otherwise) need, but also it makes it
look like you need the softmac stack for those drivers, but they're
really hardmac so that's a bit confusing.

I wouldn't want to have a separate module just for this, but I think
since it's going to be exported anyway, we could move the whole
michael.c file to net/wireless/ and make it part of cfg80211. All
wireless drivers ought to depend on that anyway.

johannes

