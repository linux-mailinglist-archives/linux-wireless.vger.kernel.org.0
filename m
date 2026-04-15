Return-Path: <linux-wireless+bounces-34795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sElqFIiM32l5VAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:03:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83894404A10
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2B93017C3E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C414332EDE;
	Wed, 15 Apr 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bB6ixD/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34688331230
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258179; cv=none; b=mH7uiACzdrkzbwQG+rLhZykHuOrixbGnMBBzY7mDLFKc+ZxBze86LiQsqBGyyGajX03UtikL/3zfDrlh1zrmmyy3eHaS3pSOFAdjpctB6xsFo5Rm/cID3FG6yB8aEHC1EdXFvMLsj15roqCCORlMX52Fv3gdK/368rgEkkzXEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258179; c=relaxed/simple;
	bh=v/bmwtzPXj6eViWJH1sCKkFKfbVPdymQqzPbjbDOiT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CprToWKS6DL/CG1Di8DL8JiWqr8yj6tfewdD0tCF2RnzehFxwNncBvaNpyn7OA70vY0zT/04Bm54R1Cca5QJwwkQ3dXUg5YPR/L5/gmkht3j5am3g8csoXOaL9a16RWCc/qMm9NhI+TjUx7NFSNNz3vJJuFG7Ysxya/e1GDNm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bB6ixD/D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v/bmwtzPXj6eViWJH1sCKkFKfbVPdymQqzPbjbDOiT4=;
	t=1776258178; x=1777467778; b=bB6ixD/D/s6tDG07h6TENWEVHyUgfrdkf+wzi8OrvPvq5dS
	HtKKOW+35rq5qNGGsxRoBVvYVrDM8RzZXGFW4vR2g4sHq7YB3T1NdvnrO3u9pj+7/4bBvPF53yVGG
	/BG1TLkL6dayuIsRvkw96KXxCW2HWwGriRvrjE7MouWTBMWymluw1DAWTaXJ/2INd0MXORUGE2pOX
	nJsYbfnSmVlrdlIDppCbNjyW21+rVS0j7ptj1UfJvWdBEZZcf/5vxIt2PFs8VHEYR4Rw310AAGafS
	N+sXAqqMd7yEmgUocp2UcVuV0gkzoiQND8jkL4bZrVxQWG14aqXg8NBG3waiOnIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCztP-00000006PXw-0tK4;
	Wed, 15 Apr 2026 15:02:55 +0200
Message-ID: <e594b5046080b8238c5c311c84bc2be75c5bb6fc.camel@sipsolutions.net>
Subject: Re: [PATCH 09/20] wifi: mac80211: clean up STA NSS handling
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Date: Wed, 15 Apr 2026 15:02:54 +0200
In-Reply-To: <20260415144514.bef3d07beeb6.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
	 <20260415144514.bef3d07beeb6.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34795-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,intel.com:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83894404A10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 14:42 +0200, Johannes Berg wrote:
>=20
> type=3Dcleanup
> ticket=3Dnone
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-on: https://gerritwcs.ir.intel.com/c/iwlwifi-stack-dev/+/273695
> Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> tested: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>

Meh, sorry about that. I'm not going to resend for it right away though.

johannes

