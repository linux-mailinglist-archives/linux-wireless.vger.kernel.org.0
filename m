Return-Path: <linux-wireless+bounces-31928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAXNDStSlGlFCgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:34:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06214B6AE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838073006B76
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0032A3C1;
	Tue, 17 Feb 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o5hmxreX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1F32E15B
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327980; cv=none; b=XhuU/YL/y6w/5632bAuUYb1h6+ePFJddx7n13YjSiGFSk3l98FjAwwQztWa31mBnGL9ZFwb01mqTf/cxebuYvrcfUAGq79GZI/gbBzBWlkqel2+QhoVl1XrxEMBfZbudrw1BRoS3lZui1NFTFemvmIa2D6Bfx9k3iYCSiz7nTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327980; c=relaxed/simple;
	bh=UUHrozg0eDafxKNf4gdWBaihk/aCwaAWll8SEGw8ki4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tm4K58S6t0eqgaSrK2vyrdlu9LiLbpPRVb/uIwYfX/Pm0MAW+kH7pTM8028PtJHLJ2gVkWhfaUQKdnpN7WLcfsmu/MRBRwEWmjKq25PivwqTT0FD0AoQq3thJKGP8Oh/KW5iv1CAb+pN6tnwqJkTJNKzgIL3l/MVdEwLfUF1OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o5hmxreX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UUHrozg0eDafxKNf4gdWBaihk/aCwaAWll8SEGw8ki4=;
	t=1771327979; x=1772537579; b=o5hmxreXBPkRW37+gYsU6e/lwFR9F+rbOpnJ8ZlTP1WX5kd
	DEPzVKVPnG4/2VaVMwO+lX0sju78vKaw8sVdCeI8ur1EeSO2a8V0SqRrpD1yvBX8fPuciHgFCeTWu
	33X4gt01Hq5/WtqF8OK8uYZ+jvaKomjWWuRsOEcREySjToixeO6Km7X+VSAt9wmU+TwKLnHMWGCNs
	f1Lhc0OmmB+KEftmyU/nDVBT3pkwRCFyz/PUNs4yQIIykwsyWdEaaY+d1I/h6y/IOBhmvUXvCJFQJ
	nc66LsDkJ05pnSJl18x/ZhsAbas55kABUvVh8rU8aSR2UuFDybXzSb1Ji2SLiKjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsJK4-0000000BMcV-3TjK;
	Tue, 17 Feb 2026 12:32:56 +0100
Message-ID: <bfb907e97b80eba00725af8873e8e1c3dc577f73.camel@sipsolutions.net>
Subject: Re: [PATCH iwlwifi-next 00/15] wifi: cfg80211/nl80211: Add NAN Data
 Path support
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 17 Feb 2026 12:32:56 +0100
In-Reply-To: <4b8a609add613f5409d7bb2ee524bb4c9288e61f.camel@sipsolutions.net>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
	 <4b8a609add613f5409d7bb2ee524bb4c9288e61f.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31928-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+]
X-Rspamd-Queue-Id: 9A06214B6AE
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 12:31 +0100, Johannes Berg wrote:
>=20
> Wrong tree tag, since it's all cfg80211, and also it didn't apply on
> iwlwifi-next at all.

Oh and also, this was already v3, but you lost the version tag, and
there's no description of the changes between the versions.

johannes

