Return-Path: <linux-wireless+bounces-32463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HugOugbqGmYoAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:47:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E799A1FF418
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71E33300B464
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7C384258;
	Wed,  4 Mar 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MJOeCKOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44036CE17
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624856; cv=none; b=ehfBPVfbuq2XKWFr2At0cDZoib+dTa5Be27LcyJhsnEJCH/0oagJiDAqFORg/u+aaaHIa1IKno1WA9WMsKDdPs3iOuJLoNFlGwL00RAswQGD02Q9SEecJMw6lPB/8cyexW4L825bznx86HS1BTlYbwLszczRxj/mV7mEo1ZGRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624856; c=relaxed/simple;
	bh=luzMiyeaj5fYVJUtm5FuYU1fR/h1hLjHRh/ZsjMZ4Ic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK6aMDOoLZghzWjjGnBosZVwyj/gDiJFEJwwaCOYK35ZryLBhUFDhO1qMBYQkSrC0Ix7v+plVZKdnJrBFX2j91WvA/ldCz9OivcYQ6Av9wFkv35JeenpS2QNFtEXWajH7a0qfkLeWZO/9G9VJi8e/faT2D9wS4UmflcUUbzTYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MJOeCKOn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=O8M+/UhYYVB0aUd420q1eHTvhemS3phv8cP3ESSTnDM=;
	t=1772624855; x=1773834455; b=MJOeCKOnPoVcMDNajT2KlonpJZEFib0TEp6CsRc2GMCZnG1
	WbiKmNb5QOTnGhaeORt/Ip9wI8EFbHtCu8oGMUfYvD/Sizd5FW4fBiRN2Y9/Z2ooZB0I+KwFpvpr+
	KyeTFBMNgLjKU6X0kSJOYJkIKd4h3JXBZYzTaup5gA9RCTl2HCVawiekkmhLsXh5G4fXUwqsEPVF1
	gfJi6fQj4OQLflpAyXZkbyucMRe5ORIP572gc/l9ypWf6MzSG1DtZRxl4VO05srzvQHGTV0yxHZ5U
	RwBw2F6b1C2by7ACaN42a4uFjD+Nef+C/mYvtyiw3xLOcMkI7dKD+3aAGVuXzqWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkhK-000000083PH-251s;
	Wed, 04 Mar 2026 12:47:26 +0100
Message-ID: <0ce019564f0a12f9ebb68e505485c5df94d7300f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 05/16] wifi: cfg80211: add start/stop
 proximity detection commands
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Wed, 04 Mar 2026 12:47:25 +0100
In-Reply-To: <20260304071538.3833062-6-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
	 <20260304071538.3833062-6-peddolla.reddy@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: E799A1FF418
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32463-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>=20
> =20
> +TRACE_EVENT(rdev_start_pd,
> +	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
> +	TP_ARGS(wiphy, wdev),
> +	TP_STRUCT__entry(
> +		WIPHY_ENTRY
> +		WDEV_ENTRY
> +	),
> +	TP_fast_assign(
> +		WIPHY_ASSIGN;
> +		WDEV_ASSIGN;
> +	),
> +	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT,
> +		  WIPHY_PR_ARG, WDEV_PR_ARG)
> +);

Why spell this out completely?

> +DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_pd,
> +	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
> +	TP_ARGS(wiphy, wdev)
> +);

Clearly you knew there was a class?

johannes

