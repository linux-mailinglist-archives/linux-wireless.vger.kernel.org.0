Return-Path: <linux-wireless+bounces-31663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICM4Jb7WiWnZCAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:44:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1AB10EE48
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 141233013031
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7E36EAA4;
	Mon,  9 Feb 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EZw7paLi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD436D4FB
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636459; cv=none; b=Z+1yWaOIZN/jr1PQS1m98EuzoQeF2vhKuAqtTVt0zIipF+hfKuhOru8cbXe4/1OihSnbD9CQ51ufMzrz005GBcY5IZKpF//aqS+viW9hmAe0NlFsLmnZ8k4bFWVnKLAly5mQRMjj3ITI57vBZ5u5o9SwdU9xgh5EepUsKTT4Goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636459; c=relaxed/simple;
	bh=sDTHqOsNsotiTeQa5J1JTDkYT0cJHBRYzoajd7XgPYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXECqe44QZQgBO112M2IZwJkl7lfNWKA/vaI2DFE/CtcnbFTQe6cc04oQr5MFOtRbnt3bcd77OJsPbJDtJxHVvBdM82Fvdw4KdUDyjMP597cDnBYomhn404HACTAr+HsoqfnEgqY7Jl1jnYuFuVBASnVCDfYAdVAxVc9VZCfGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EZw7paLi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sDTHqOsNsotiTeQa5J1JTDkYT0cJHBRYzoajd7XgPYo=;
	t=1770636459; x=1771846059; b=EZw7paLi6if3lilHQW5leaoVP3hkbSjTI5KJTwJ/WzmVirl
	Qq9Aays8wguNAc+tU1R+WkMEtd8B2LRRdTxHfyMBxJ5EyqQKQoMOEWpl4Ay/a+LHPnBvK4IKAmulL
	jdkYfxymP2vcNr9Jx9BNsomhvjsvmld/srgN/XFWXI8gBm4pSWitPp0PIe05HLohiKiWabypjz8y4
	JB0hN/PmzUfR+1CCMa608o/RG2VSK7wIwLrtR4rNeVSXCMa5gRM3c5Krl7LKdroVLM7mXiq3lcdti
	HLbEFLy90c8xUdKpyelbgL29SYLcmChOk9UXVrnXcQ/sdJ0jPGNsZMop/zyr6XkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpPQP-00000002qd7-2ZHY;
	Mon, 09 Feb 2026 12:27:30 +0100
Message-ID: <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Mon, 09 Feb 2026 12:27:28 +0100
In-Reply-To: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
References: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31663-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E1AB10EE48
X-Rspamd-Action: no action

Hi,

So that looks like a huge improvement to me, nice! :-)

On Sun, 2026-02-08 at 13:48 +0530, Sai Pratyusha Magam wrote:
> The hybrid way of having both HW/driver based crypto for certain frames
> and SW crypto for others require that the fast-xmit path be skipped
> when the above mentioned key flag is set, since data frames still rely
> on software based crypto

I can understand this sentence in the sense of "A =3D> B", and it
describes why B follows from A, but ... why do you even need A? I.e. why
do you want to do this for management frames only, it seems the encrypt
function and having hwsim worry about it should work just as well for
data frames?

If I restrict hwsim [1] to only pairwise and CCMP/GCMP (clearly it
doesn't handle TKIP due to Michael MIC, WEP is irrelevant, BIGTK isn't
handled in hwsim), then it mostly works without all of that extra logic
for me for the tests. Maybe need to think about IGTK here though, some
tests are still failing.

[1] https://p.sipsolutions.net/d101bc31582cadcf.txt


But if we do that (even if I don't like it, I'd rather fix the remaining
issues), then you need to document reason for it.

johannes

