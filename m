Return-Path: <linux-wireless+bounces-31579-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFpxOT9RhGkp2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31579-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:13:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A5EFC56
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24C423005312
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC665361DC9;
	Thu,  5 Feb 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ojLoxq2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77345361676;
	Thu,  5 Feb 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279224; cv=none; b=oRPfPQ0sx9SFXNvPtgAHMzsyAz4aoal4L5RahRE+Z3T+YDcBInfuMhK6xaPCg43Gsh4oHPQ8VlIXIIFUObNAnED56nGu+QkBjDjyFCQFjHRPhSiYiUDCIH1R7TVdgI8D+Izqi7K6wRxbn2mfAPdPRYyWscL6Dm2gV50uSSuMZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279224; c=relaxed/simple;
	bh=ZVZZnrGyRFU9pXby7/w7kj32iynDsjpVEBz6ZNgmbgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZC2qVpDjb28PAmHdQ6GId9eIw3KXJDdySa4kBzZNBmOe2f/DfJYzcQdVVIxGBvlSaOb1I7UzbMYnfw6WOfeG6G2tGl1tZQTrL/sFBaBScw3FRmMhap7sZQjE1bjq7pNAaZtpnYeC9TX5AJmFCEqA3Wlhoc/OZt2MKjtRhRzJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ojLoxq2A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZVZZnrGyRFU9pXby7/w7kj32iynDsjpVEBz6ZNgmbgY=;
	t=1770279224; x=1771488824; b=ojLoxq2Az1cXxtg28E7SVfHITDB1RyKBCxnZsFDl12l8hP3
	8m0DcvfjNCy0jfXDvHG1YbaC0Qca2jfzSKXidHNmMrMbLv1gV+l4suZlFSfDc91PUoqp3SRNZNaJH
	BeSQmd3ZfZSPzgDbgJQLUnGTGGWo2nayEfkbYURHpjgzTgnWzoCZia1OAQWTqjxBqBbJXTqzBf5NG
	Hacse+SJzZ0Dtpbz7ZMIamHeqHj8egvwotyoSLNISnJcS8oRCYjXAxVqhhjJjMVy3VpSG9xTfgOd8
	OY+xNECIE1YDSeSnhWWqvKYYO5MhflwzmO8Gak03e9AuHq89RmMM5qeyG43O32zQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnuUT-0000000FNQY-066d;
	Thu, 05 Feb 2026 09:13:30 +0100
Message-ID: <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
From: Johannes Berg <johannes@sipsolutions.net>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Stanislav Yakovlev	 <stas.yakovlev@gmail.com>,
 Alice Michael <alice.michael@intel.com>,  Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Date: Thu, 05 Feb 2026 09:13:25 +0100
In-Reply-To: <20260205075445.43347-1-enelsonmoore@gmail.com> (sfid-20260205_085458_002902_CD48D5DB)
References: <20260205075445.43347-1-enelsonmoore@gmail.com>
	 (sfid-20260205_085458_002902_CD48D5DB)
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31579-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 173A5EFC56
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 23:54 -0800, Ethan Nelson-Moore wrote:
> The ID 8086:104f is matched by both i40e and ipw2200. The same device
> ID should not be in more than one driver, because in that case, which
> driver is used is unpredictable. Fix this by taking advantage of the
> fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
> devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Right, good solution. How did you figure out that ipw2200 uses OTHER?
I'd thought about this but was afraid it'd also just use ETHERNET.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

(FWIW, I've found the database internally, but not who maintains it nor
any historic information in it ... still digging I guess, if only to
avoid this happening again in the future)

johannes

