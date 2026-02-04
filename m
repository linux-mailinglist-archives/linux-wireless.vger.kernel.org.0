Return-Path: <linux-wireless+bounces-31539-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBlLDw9Gg2nqkgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31539-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:13:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED6E63EB
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165C830A704D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8D40B6C3;
	Wed,  4 Feb 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WcFKnOmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8B2D8375;
	Wed,  4 Feb 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210437; cv=none; b=RD1yw3ecpulZOvBeBE0lsCMf2QChWf3Z82M75opDidTkXl2yMqQOjRSUjbiP3I5/WAtQiNN78QaVUxC4qgjm03IX9Zl1AaYpAI0u35uAW1ai2eMNPCudI/rfoH2EEWjq3/JlmH0xJikWCPArAML1IiUddG8kplMcTPD5Gegk+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210437; c=relaxed/simple;
	bh=i4VRp0jJbGw3ZaDauwZaabPPV3NPWcfhkl4uFkI8peY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fk8WvhL2mLy+eKOgkBYSAV8Ys0i5eozqcLaRDH7UnCns+xz3RyYZbV+Pj1Nn8CRcT5OoN9yfrtJCaMDy/aK7mHkoCxbajiDuB7x50oS+5iFDJSUhaSUPhS31HiAXQ7a1rOCJkN0FEKMqudQ88jDqubKjYnNF7vs6P7sE2VLjhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WcFKnOmZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LQj6rnh7ICGonKPGyulSWFi+XNXMy0j7q2lUi31+XN4=;
	t=1770210436; x=1771420036; b=WcFKnOmZnYz1SkaJLGA08osxgDlQKImm/hTcH7jPZEOl9Go
	aCaKzlDtawj6XZttkFiYSd8rpFQCJQw22N5q7t4vfMSQNlc5EwI2Ho/NivmnDfgWGc4EA8rKJjjhg
	fBddZdXPrKotuf8DLTP+0SXEVD8WJgY8P9T8ruEBQSYAmdVzRemX5deEuzs+LEuCo7IEztDCLgXbL
	WcRxp1tTQXwNiOFH3fiuCRwoAzKQUrjYjv0rV7PK1UNx5zN6y+Mh2DKrPMyZyYO0q60gEXcnSUb7d
	pUbi3qGtZoGxHqXmDfzzwS2cnxOpmmF0Rr2Rb2P0dYwlHr1f2/L07Hjy71/gJ16Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vncbC-0000000EO8O-1ziS;
	Wed, 04 Feb 2026 14:07:14 +0100
Message-ID: <540a592bb2604b130e0b21f99e634ac100cee61c.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
From: Johannes Berg <johannes@sipsolutions.net>
To: dhyaan19022009-hue <dhyan19022009@gmail.com>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dhyaan19022009-hue <dhyaan19022009@gmail.com>
Date: Wed, 04 Feb 2026 14:07:13 +0100
In-Reply-To: <20260204125345.6072-1-dhyaan19022009@gmail.com> (sfid-20260204_135403_809238_73C22A22)
References: <20260204125345.6072-1-dhyaan19022009@gmail.com>
	 (sfid-20260204_135403_809238_73C22A22)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31539-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 96ED6E63EB
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 18:23 +0530, dhyaan19022009-hue wrote:
> When bringing up the wireless interface via virtual monitor mode,
> iwlagn_bss_info_changed() can be called with a vif that has no
> associated rxon context. This occurs during the
> ieee80211_add_virtual_monitor() -> ieee80211_do_open() sequence.
>=20
> The function iwl_rxon_ctx_from_vif() returns NULL for virtual monitor
> interfaces, causing a NULL pointer dereference when the code attempts
> to access ctx fields at offset +0x10.
>=20
> Crash signature:
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
>   Call Trace:
>    drv_link_info_changed+0x2b5/0x2c0 [mac80211]
>    ieee80211_link_info_change_notify+0x13d/0x160 [mac80211]
>    ieee80211_recalc_txpower+0x5c/0x60 [mac80211]
>    ieee80211_assign_link_chanctx+0x182/0x410 [mac80211]
>    ieee80211_add_virtual_monitor+0x17c/0x2b0 [mac80211]
>    ieee80211_do_open+0x6d8/0x740 [mac80211]
>=20
> Add an early NULL check for ctx before accessing its members.
>=20
> Hardware: Dell Latitude E6430
> WiFi: Intel Centrino Advanced-N 6205 [8086:0085]
> Kernel: 6.18.7-061807-generic
>=20
> Reported-by: Johannes Berg <johannes@sipsolutions.net>

Yeah, no. Please find someone who's willing to teach you first.

johannes

