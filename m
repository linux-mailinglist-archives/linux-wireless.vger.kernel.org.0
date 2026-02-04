Return-Path: <linux-wireless+bounces-31537-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNT1K7Q6g2ngjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31537-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:25:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8414E5C06
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1258530013AB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC583D5230;
	Wed,  4 Feb 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pOtx8Z6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6F3C1960;
	Wed,  4 Feb 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207919; cv=none; b=RRBWDFCR9phCXRyWwNL6PMlmcz7pJFtv9idfP/H8Guyn9/eYo//uUBEbmoD6cFs3L7RL75gKO2eOGdsqjgujFVratHqHItaHbJdDqlXp/YQ+HcNn4ZBQjDJqcU5v/QN7+Kg6pg0Dkac2W8UIKkIu+UVXlTKOoWG+xloHJO3J+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207919; c=relaxed/simple;
	bh=Nf+piwtIVZ1eO2ytB2/u2CXfRcWXRRV8MdzbpQDfxFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLGvdR7yUUdLwA34UezGjwjicZ1c5yeswC1hNiFqwniiTN33HDJV9YCFYI3dwcUx5vXxSXJljaLLXXS5MYqCUOUGtEec279uo3fBOwEjEqRz7CtzUi2ZPtBvBG9hJ7ACrYZSQhXq0wMGAfzRiJS5VBRWTJ5XzHYxIbTp37XrxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pOtx8Z6w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L4426qYFaFofD4qwVjRgElXhcobmYp03gOpK5V65zH4=;
	t=1770207919; x=1771417519; b=pOtx8Z6w87rv5jpzRtaPQ5dG2oUY86gIAAPB3hCCLe1HoZ4
	pTLQ4wa3IID32wJK3U7i3RNcvGXWHSUtYVnVWBBWhBNHEWaRoMnZoZg6WeCMpIpyA2lhjl6K+gEEI
	ErWlIcFjxfdkCqlOWVW8NEFiLc7MWZ4nJzis+Q1IhxDQmdde19tZzbW1j53BryLQrEhPSQpwc/0TY
	vgLOJs2Qecs00YB4Y2sbyhbcTWB78zOBOVxIlDQFECH7LPmxqDTn4pdn7sF6PKJZlxfUvvqaceFOu
	BpjStRIZcoXkpHapviOFqY9AaeTY1vPZOXwz4GqoN8wX4GfnZDST1St5eodJsyrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnbwa-0000000EMP0-3MNT;
	Wed, 04 Feb 2026 13:25:16 +0100
Message-ID: <5d06a246c7a38668423da3d0fc43db5ee38d08a2.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
From: Johannes Berg <johannes@sipsolutions.net>
To: dhyaan19022009-hue <dhyan19022009@gmail.com>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 13:25:16 +0100
In-Reply-To: <20260204120141.2896-1-dhyaan19022009@gmail.com>
References: <20260204120141.2896-1-dhyaan19022009@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31537-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8414E5C06
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 17:31 +0530, dhyaan19022009-hue wrote:
> From: Dhyan K Prajapati <dhyan19022009@gmail.com>
>=20
> When bringing up the wireless interface via virtual monitor mode,
> iwlagn_bss_info_changed() can be called with a NULL bss_conf pointer
> during ieee80211_add_virtual_monitor() -> ieee80211_do_open() sequence.
>=20
> This causes a NULL pointer dereference when the function attempts to
> access bss_conf fields at offset +0x10.
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
> Add an early NULL check for bss_conf before accessing its members.

If that really can happen, that'd be a mac80211 bug, not to be fixed in
a random driver. I see the crash above, but you've not even described it
correctly, it seems more likely to me that iwl_rxon_ctx_from_vif()
returned NULL.

johannes

