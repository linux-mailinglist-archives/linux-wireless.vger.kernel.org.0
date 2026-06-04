Return-Path: <linux-wireless+bounces-37387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DduGDERnIWqOFwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:53:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5063F9A5
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=TDmOcmPi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37387-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37387-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0518530B8C51
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52745426691;
	Thu,  4 Jun 2026 11:48:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084B2594B9;
	Thu,  4 Jun 2026 11:48:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573719; cv=none; b=lO06UBT5mSOiis30rOTIhd3AT/I+CvphsDq955LsOTM2UCOHNcc2QA5rh5d6F7W5RKtak6p5A359omEFwSRL9vbW2eHsL/qoog/4lOP1fYFQHCtJ3kx7OuP1MBrS0Y8+/flSO3DVAlWMDdqHKnUhuwyA25NWZZOhzZJ+o4YxtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573719; c=relaxed/simple;
	bh=91YV57NHkIKryjPwiOnA8wuaZX549ZxjQjZjyeqhpTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6Xv/VkY48Wg7bLcXSxid1LRNsGnSku3Odq49JUFt4DOEUEEAcXmKc/chjqAticbw0IwFsm6nKeeySbRMg4mRlmqBdUKEaXTB5rpTpJ+uW9tmo+qnTGzpm3xTesllPuh47R8FHVZNfA2Gnr2xn8QptXc+kVb5NDhmzJC4SEBEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TDmOcmPi; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FxEVjqEZq5nxSjM7FBRBoVftG3fOIujov85xVsPkWvo=;
	t=1780573718; x=1781783318; b=TDmOcmPipe9DLSfOxHBnd8bwLXv1lnfdkfDa5O534tvuMgT
	UKU0blwl4s43T1Ix4lN5kwu5m2Ji0/thfgmhixvCgNv7cjEicJcBy5VezWdC1GZsmFxd0pRpWQJju
	hBt8jsClVuN25e8lNES7X8454OTVSUj48+t99WH4mcX0Z8Ji8jYPV2Wzt5epffE8zGwFrUOXqAXQx
	Iml6hMwKywj3Ad6+jb+3BxRuVoLObRoAHARJqNUH8UQB0YtLRBCHjx+pZHhG2PxpXT3XwyVVPQdhH
	eC2jWtaVLdBzVCkS8/DT2wk9gz92DKH5ic/ntXQjvJ4fm5knWnYNoB3OPAYoNvig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV6Yt-00000000Sxw-2w4o;
	Thu, 04 Jun 2026 13:48:35 +0200
Message-ID: <66ec16ce60ab78c68d52312d98f316b74715742e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 13/31] wifi: mm81x: add mac.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:48:34 +0200
In-Reply-To: <20260430045615.334669-14-lachlan.hodges@morsemicro.com> (sfid-20260430_065748_226496_B841CF01)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-14-lachlan.hodges@morsemicro.com>
	 (sfid-20260430_065748_226496_B841CF01)
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37387-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAE5063F9A5

On Thu, 2026-04-30 at 14:55 +1000, Lachlan Hodges wrote:
>=20
> +static inline bool mm81x_mac_is_sta_vif_associated(struct ieee80211_vif =
*vif)
> +{
> +	return vif->cfg.assoc;
> +}

> +static inline u16 mm81x_mac_sta_aid(struct ieee80211_vif *vif)
> +{
> +	return vif->cfg.aid;
> +}

Heh. Those function names seem way longer than the implementations, but
YMMV :)

> +
> +static inline __le32 mac2leuint32(const unsigned char *addr)

"le32" rather than "leuint32" might be more understandable, but perhaps
this should also come with a comment about dropping the two octets or
something?

johannes

