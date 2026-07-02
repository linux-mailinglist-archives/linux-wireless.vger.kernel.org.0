Return-Path: <linux-wireless+bounces-38490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WUqJ24jRmpgKgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:38:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F26F4DE2
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:38:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hkYJjHhe;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38490-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38490-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42E6C305BE08
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4533905F8;
	Thu,  2 Jul 2026 08:27:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730D33F8CA;
	Thu,  2 Jul 2026 08:27:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980846; cv=none; b=KYYCnAvx97xxjsqJotOSNS7eTSD3WW9og7wvt+ttGXQ/B8mw1KTHFbjbNpn6qmxMO5aZbAhiyzyDQoUJKdDS7joCYkzVCZ3kjpMhDZjlH9MBIOjnjJzj+CVtTYxwbPDJo9TxZAc5mS5aPGvdCANnYcrxVovasyz2H0cDLEfN9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980846; c=relaxed/simple;
	bh=+ngHn6uf+3LIKwi/2+6vVQprALRvSEsMi9V4LTgnpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLEzGp/L9OweTjRBkB1OKwGDSyBFSQfEv+K0Elcu/U7xrDGwVzAZmtnRjZoNYEs7uxh11i8gBOh6M8UziOkrMdn0wuoWdOnDACRa5a8KQZuJ+njGrLIK0kADS4OlaIuLHcuKmoA/kZnnjxMxPO10VnpXh5sHN79vQ8qyIqQ8NYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkYJjHhe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851061F000E9;
	Thu,  2 Jul 2026 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980845;
	bh=vDQz+NYkTBHSULK0tw+Mm8elpzXTkLrFpJWp8OOPxRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hkYJjHheBiigSCIoxAnmBnm2Bv2li9Wt0V/580iIt97g+Qrcrl/x51jeXGSSBer4N
	 G8ZKzu71v+Ztthqr3JIPrs2YJj9D7qbkxUzhIYzarWZPgQiaBamvYPihvcQtIxaDpa
	 rnh9tbuT81gfZDB+QWm7HZ6b2Fuj1Iqs6AZ2ft+3KAfMwrBosipBQB9reYyIz+THZV
	 YRpOs2QdLr7ugW9crkovYbsPxYd+v1B0mMjw/cdJOcm71xTzmDe2rETZdLIqtOprgQ
	 538oSgv1t2IdpzYrb02oFqE2FPspC5qTTb4RIneR8kbqhk8V8dooW047Fjf+FmWdPW
	 ZbW0tPAXYrQRQ==
Date: Thu, 2 Jul 2026 10:27:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Andrew LaMarche <andrewjlamarche@gmail.com>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] dt-bindings: wireless: ath12k: allow calibration variant
 for WCN7850
Message-ID: <20260702-beneficial-hopeful-binturong-a0bee9@quoll>
References: <20260701-ath12k-calibration-variant-v1-1-d3eddaabf026@toradex.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701-ath12k-calibration-variant-v1-1-d3eddaabf026@toradex.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ernestvanhoecke@gmail.com,m:johannes@sipsolutions.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jjohnson@kernel.org,m:jeff.johnson@oss.qualcomm.com,m:andrewjlamarche@gmail.com,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ernest.vanhoecke@toradex.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38490-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,kernel.org,oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org,toradex.com];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,quoll:mid,toradex.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 089F26F4DE2

On Wed, Jul 01, 2026 at 05:42:24PM +0200, Ernest Van Hoecke wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> qcom,calibration-variant selects board-specific calibration data for
> systems where the bus and device IDs are not unique.
> 
> This is not specific to WSI-capable QCN9274 devices. The WSI binding
> already allows the property, so allow it in the WCN7850 PCI binding too.

Why? You need to provide reasons WHY do we want this.

> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Where is any user of this?

Best regards,
Krzysztof


