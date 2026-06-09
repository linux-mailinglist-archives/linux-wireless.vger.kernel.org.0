Return-Path: <linux-wireless+bounces-37585-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lt7fJoQIKGqx7gIAu9opvQ
	(envelope-from <linux-wireless+bounces-37585-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 14:35:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C566017C
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 14:35:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=qZ3KDvem;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37585-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37585-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 813203007213
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B83F39E5;
	Tue,  9 Jun 2026 12:35:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1855416CFE;
	Tue,  9 Jun 2026 12:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008510; cv=none; b=Rkp9mq+cUANw1PoEZmK9UNzBHkPv46p4fIMNaQyfi3Zs16L8wbv6IIsG8itquFmSl/cE5jmHugt2xgUZjwTTfY7jA2G5RzIrRzbyvZ+Uki5fbSa4852JkMJSXvs4fLvZ1Jz3iPyLpe3f+YXWWkBC8j0GY6oghgeldW9jfu7olKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008510; c=relaxed/simple;
	bh=BJqqP6Sdwa91ZGN7Y1x68WyVTyaymu15mhyHVolKOng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVPhkvd3WUngF/8kXKRwZRvkeOUv33mfBvhSr07TSQ6D3G76Vs6c7m+gU0QklphbtqdJoBtnf0MiRCxVULsue3VAslgNjPQArgzbIquenC/moGVP+4lTwutBafaBbm6EQjAz8e4Dl8kOkvd9o99meqgiCv6ExGUH6MSwQSqk368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qZ3KDvem; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BJqqP6Sdwa91ZGN7Y1x68WyVTyaymu15mhyHVolKOng=;
	t=1781008507; x=1782218107; b=qZ3KDvemGP+hKLF0NZRGh4ULzwt0Vr8ieHLCzUS7aIu0Hq5
	ry+FZ5lch3DoKITn8I8urGzszhWYXvpwtmQ8btUCX6gZSYwcK2rfD1MM8+ZRrbcBpn33EXfhuwiIO
	q5GIxK3oEE/8vbyUni5ZG0smamNq9N0Uz8Z0WvKv2ymeUiifPK5MJdL962AKZxE5jQoUXghRCBQuX
	aQEm+V/eS+Cy0++nYBxzq2VTOK2qKkeo1Q1SPkTMarFevHq9EvcVweWpcO/r27qGzylR1CwNYfA4I
	7/Oz+Hgzm+ghOQpU0XD8YkKIqKOYTxQhy+61RiCKmQCWzx7zhyqfGIEnbKMMVssg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWvfU-00000006pXw-1zJt;
	Tue, 09 Jun 2026 14:34:56 +0200
Message-ID: <8b157b78483fde06a7ba740cdd9e8c91d78ba574.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: fix destroy-on-close UAF in
 netlink handlers
From: Johannes Berg <johannes@sipsolutions.net>
To: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 14:34:55 +0200
In-Reply-To: <20260609093408.2777763-1-dominik.czarnota@trailofbits.com> (sfid-20260609_113412_336281_D54034A7)
References: <20260609093408.2777763-1-dominik.czarnota@trailofbits.com>
	 (sfid-20260609_113412_336281_D54034A7)
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dominik.czarnota@trailofbits.com,m:jukka.rissanen@linux.intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37585-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 857C566017C

On Tue, 2026-06-09 at 09:32 +0000, Dominik 'Disconnect3d' Czarnota
wrote:
> mac80211_hwsim is a developer testing driver for simulated 802.11
> radios and is not used for normal wireless LAN operation.
>=20
> Its generic-netlink handlers can look up a radio by MAC address and then
> continue using the returned hwsim data after the rhashtable lookup has
> completed. A destroy_on_close netlink socket can concurrently remove that
> radio from the global table and unregister/free the ieee80211_hw, leaving
> the handler with stale hwsim_data, wdev or PMSR request pointers. This
> can lead to a use-after-free.
>=20
> Make address lookup take an active radio reference under hwsim_radio_lock=
.
> Drop that reference at the end of each netlink handler that uses the
> lookup helper. During radio deletion, drop the initial reference and wait
> for active handlers to finish before unregistering and freeing the hw.

The whole refcount here is overblown, could just use RCU, and the patch
doesn't apply either.

johannes

