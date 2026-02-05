Return-Path: <linux-wireless+bounces-31580-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDxkDkFShGkx2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31580-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:18:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EB5EFCC1
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37748300C022
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802B033F37D;
	Thu,  5 Feb 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QAqvwzND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC0298CC4;
	Thu,  5 Feb 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279486; cv=none; b=pJRVAfVe3kwTxlKkAtjIwL+BEIrr4cXS/tCzGnOGBN5vPCuy8kv9MF+/5Zor3oL18gS9hNqSr6VQkktUCRu0CWn4hFkX5MtQMNzIDuXBMRSDcfdEuJfl1SL8xfaULNT/Sh73TE09ZxkYFKpTWjdtnJMZkBaFCmP+1YW81bkQ8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279486; c=relaxed/simple;
	bh=d6czF1Mp6LaftRex5Z5Cx76eLZM9ZX6QUdrLafdNhT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRgof2HBF8PrX1RlncqYHaf6od4VmcjMGACbu2YzpSTe79ab/hX7Wfb1aY7rerdCVgn1zo/BTyn82RTeFPwEsL6VbrjFkRw1M0oEaKCJosqPEO0cJBAobg47OAiCEgRrcyl56LDbxIxTMdEyaGMlB/u7e0vmFcWioB4f4CIW6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QAqvwzND; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d6czF1Mp6LaftRex5Z5Cx76eLZM9ZX6QUdrLafdNhT4=;
	t=1770279486; x=1771489086; b=QAqvwzND6abR7j5+Fw3o4nVyZm5ick36cxv3TUqxjvWmwfr
	1YTlJr/blHkIIM/l3rTZeV7EPuWkq+sonW1Nn6gbED0ESoS7S/65GQ56PENNu83ol/hqOIdQvix12
	puxJ2KtDzCVJVQ87vnSr9dablATtMzKDoxZ6SmNQGVoPlIkOfBAQ6DiR2xXpqFsBDWCymnQ8kcHoQ
	avJ+JrEHp6Y+Vcg4PQtI0hc4k0W/fKcE0gXgeaBCecMVvCbDO+vp0CCXQ7JKsJ6NaljwnLA4s/QM9
	28MfVU6hoxNnR4qA3vAAmIjP+QJAUyI0qc6YowBUztYCY16tZ15qOLSdI+FWpFgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnuYp-0000000FNdu-3zeV;
	Thu, 05 Feb 2026 09:18:00 +0100
Message-ID: <6006da6281d43f4f5a55dd6434d40eedfc7ae4fd.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
From: Johannes Berg <johannes@sipsolutions.net>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Ethan
 Nelson-Moore <enelsonmoore@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-wireless@vger.kernel.org"	
 <linux-wireless@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nguyen, Anthony L"	
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Stanislav
 Yakovlev <stas.yakovlev@gmail.com>, Alice Michael	 <alice.michael@intel.com>
Date: Thu, 05 Feb 2026 09:17:59 +0100
In-Reply-To: <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260205075445.43347-1-enelsonmoore@gmail.com>
	 <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31580-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94EB5EFCC1
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 08:13 +0000, Loktionov, Aleksandr wrote:
> >=20
> Commit message could be more detailed.
> - Why the PCI ID is being reused (if known) Is this actually a reuse afte=
r EOL, or is there a misunderstanding? The commit message hand-waves this c=
ritical detail.

Well, if you and I can't figure this out internally to Intel, I doubt
anyone _else_ can. Sure, ipw2200 is EOL for *long*, but Intel still
shouldn't have reused the IDs even if the old ones got carried forward
from PCI to PCIe.

> - Whether this is documented in hardware datasheets

Good luck finding any documentation on ipw2200 these days. Those devices
shipped 20+ years ago.

> - If there are bug reports of the conflict in the wild

Does it matter? If you have a system with either of those, you'll get
lucky if it works, and get a mess if it doesn't. ipw2200 driver will
probably bind to just about any device with the right IDs since it
doesn't do much in probe().

johannes

