Return-Path: <linux-wireless+bounces-37486-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RDGMCmFsJmokWQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37486-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:16:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F736653715
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=Ms3NH5gs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37486-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37486-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 815B7300CC92
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A562E7388;
	Mon,  8 Jun 2026 07:16:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283026AF4
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 07:16:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903005; cv=none; b=sXx3dEz+X4ycmGZwm8r8b8iptjbhr+dDrojo8dEYkQfRxDWn8DiNzbIQLelnZAbhw9zqozoiawz03q+AzZf1yhgfLcLoGf/EiByY+fThcAu1WT+kc74X3WmRhC6yUCJdjSZ0Ljj4BgukS0tkkFYAzbP5VR0QslOst0HjmAzWIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903005; c=relaxed/simple;
	bh=eZr9c63Eqe/h1mY0Rf7aRp7l7jcHbcrxr7ojL9lKdHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqrxRKW8ZTMsy04SYJIDyGSwlbUndd8uKZciiSgBF41BhYwTUE9Y9/TMNf0oImbqsGfWzMKTRo3/MAfKws1XGMg+42jeH011Qv+0UHgZ5hYAyUj/4Oxf3DCqP9JeEAntCtyQiwQbuOHPbiCrBf+DWSUfWKKpUBzzJ8GRKFUw3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ms3NH5gs; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UIZJExVAW/SiQTfvjS5WGXHRXQJ/5VxQHzaox57JJlw=;
	t=1780903003; x=1782112603; b=Ms3NH5gsMqmhJgAhi0fbCCr91ps+cOGW/p8BqH7CXh7ZsI2
	LBl9+6XrChUeSuPOULswDz3VE5PSflHWCQpYiNs+CQFuDOB+tJxPv20dNpftzHk42gIj29Eop96l4
	K7tpQKsMn00Ji0V1sTSHvfzVVjfb4UOc/tFAkYtif6YyRQtt1EnclNKMnGKm1zwe5vfBITkPsoS1L
	p/JR/o22zx1Iwvmuzah+eIW7hOeh4e2+T9sBqaUVl1Un5m2r8XPFAWmGFd53u87bN+a6HYLYHK7d3
	OFe09WxPzPUwaCaSfSLivpW7Lwl8/VKaQlJ98S/9tMRcTQLbzv0gfd3HKCwD4siw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWUDw-00000005Yx2-0xCr;
	Mon, 08 Jun 2026 09:16:40 +0200
Message-ID: <7d251045171a4146604b8788479efc0e99224ff8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/5] wifi: cfg80211: Add fragmented
 per-link station stats in MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Mon, 08 Jun 2026 09:16:39 +0200
In-Reply-To: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praneesh.p@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37486-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F736653715

On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
> This series introduces fragmentation support for Multi-Link Operation
> (MLO) station statistics in nl80211.
>=20
> The current nl80211_dump_station() implementation works well for legacy
> (single-link) stations, but it does not scale for MLO peers. With
> multiple links per station, dumping all per-link information in a single
> netlink message can exceed size limits, resulting in -EMSGSIZE errors
> and incomplete dumps.
>=20
> With 802.11be (Wi=E2=80=91Fi 7), a single station may have multiple links=
, each
> with its own statistics. To address this, this series introduces a
> stateful dump mechanism that splits station information into multiple
> messages when required.
>=20
> The dump is performed in two phases:
>   - Phase 0: Aggregated (station-level) statistics
>   - Phase 1: Per-link statistics sent in separate messages

[snip]

Overall, this approach seems (mostly?) right. I have a couple of
comments reading the code itself, but also:

> Aggregated Stats (Phase 0)
>=20
> NL80211_CMD_NEW_STATION
>  =E2=94=9C=E2=94=80 NL80211_ATTR_IFINDEX
>  =E2=94=9C=E2=94=80 NL80211_ATTR_MAC
>  =E2=94=9C=E2=94=80 NL80211_ATTR_GENERATION
>  =E2=94=94=E2=94=80 NL80211_ATTR_STA_INFO
>       =E2=94=9C=E2=94=80 <aggregated station attributes>
>       =E2=94=94=E2=94=80 ...
>=20
> Note: No NL80211_ATTR_MLO_LINKS is included in this phase.
> Per=E2=80=91link stats are sent in Phase 1.
>=20
> Per-Link Stats (Phase 1)
>=20
> NL80211_CMD_NEW_STATION
>   =E2=94=9C=E2=94=80 NL80211_ATTR_IFINDEX
>   =E2=94=9C=E2=94=80 NL80211_ATTR_MAC                 (MLO MAC)
>   =E2=94=9C=E2=94=80 NL80211_ATTR_GENERATION
>   =E2=94=94=E2=94=80 NL80211_ATTR_STA_INFO
>        =E2=94=94=E2=94=80 NL80211_ATTR_MLO_LINKS
>             =E2=94=9C=E2=94=80 [link0]
>             =E2=94=82    =E2=94=9C=E2=94=80 NL80211_ATTR_MLO_LINK_ID =3D =
0
>             =E2=94=82    =E2=94=9C=E2=94=80 NL80211_ATTR_MAC =3D <link0 M=
AC>
>             =E2=94=82    =E2=94=9C=E2=94=80 NL80211_STA_INFO_RX_BYTES
>             =E2=94=82    =E2=94=9C=E2=94=80 NL80211_STA_INFO_TX_BYTES
>             =E2=94=82    =E2=94=94=E2=94=80 ... more link0 stats ...

This description is missing another nesting level as
NL80211_ATTR_STA_INFO no?

johannes

