Return-Path: <linux-wireless+bounces-30710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B9D14E0F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 20:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810AC302B119
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1E2F39A3;
	Mon, 12 Jan 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ga+mkosm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225D31329D
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245136; cv=none; b=mYcpT1oY93JofV+NGslaZc1Ul0opCI8imaSp0Ca5YVxkl9V8/AgKzobn8aHGcF7HzyUOHK612noiLsLVENnz1IhVcntbe3JqJzNKU8NnLXy+vGuhs++0AiD6EUiFjWeOFxhXETwMgW95RiXs7kMjfXHGcwsgUyn3rwrTpek4jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245136; c=relaxed/simple;
	bh=YNf2hCsFmX+alVKz7JTjcxMRvrQ/iofccAuNG2I7umA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dlbHxjHRAa/dbpmCIAOMg2afQAOAuB9W+XkQN2WAjYt2YlWVLkMsB/KeOpIzMzHWANPlizoInApIPJr8F9QzMsK2e0g9P0q+9mQ6E+n7QvwByQAS1lgHfdfs8E0TtMUgi10Caqge5LWkab6MmY7qrIM0UA2pNrNXjq48XofrzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ga+mkosm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2w6Tj3c80QNPoEFJ+jUkPjNVkHVGv9bw6L8g0i9X4PU=;
	t=1768245134; x=1769454734; b=ga+mkosm8IRkEMUnOd3UHyLR7YaelNIoGjM18x/asWDMsB5
	HRD6aeVqMCNrD1+m5obNiKn7VAX+0pWa233C1AtyNc+hd+9FJl1XAMF1R5fdPbTw0H4NPqa7FSHp+
	15O+wjUay/tBnfOoKJoat2OPX4kIuUUcjkM7BteGHGAMZmYKNHFwu+a5zBSH1UE37hFk7cd2cfa5q
	8Vle6qdfh+Q0hpGxJDDAV8Zwv9Ov0rQ/TfJKNWuODWi/GIvng/ad3Fv4F/N3FJLw/61VB1WRQw8oy
	KCnb+PsRDbJVbrNDxWTdPdykfiTE2XHC4/klibH7oJ7vi2cKFetjubdq9y6FetHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfNKj-0000000A1GH-1Vdc;
	Mon, 12 Jan 2026 20:12:09 +0100
Message-ID: <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP
 Coordination (MAPC)
From: Johannes Berg <johannes@sipsolutions.net>
To: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>, 
	ath12k@lists.infradead.org, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 12 Jan 2026 20:12:08 +0100
In-Reply-To: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com> (sfid-20260112_195259_393455_5899DC2E)
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
	 (sfid-20260112_195259_393455_5899DC2E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

I wish you guys (generally Qualcomm, not you personally) could finish
one thing before opening yet another ;-)

Couple of quick comments:

> +---------------------------------------------------------------+
> >                WLAN Driver (e.g., ath12k)                     |
> >                                                               |
> >   +----------------------+    +---------------------------+   |
> >   |   MAPC Peer Mgmt     |    | MAPC Policy Config Mgmt   |   |
> >   +----------------------+    +---------------------------+   |
> >                                                               |
> >                 +---------------------------+                 |
> >                 | MAPC Event Gen/Notify     |                 |
> >                 +---------------------------+                 |
> +---------------------------------------------------------------+

I think you need to do a lot more to explain why this is in firmware?

> +--------------------------------------------------------------------+
> >                        UHR AP-1                                    |
> >  +---------+       +---------+       +---------+       +---------+ | +-=
--------+
> >  |         |       |         |       |         |       |         | | | =
        |
> >  | hostapd |       | cfg80211|       | mac80211|       |  wlan   | | | =
 UHR    |
> >  |         |       |         |       |         |       | driver  | | | =
 AP-2   |
> >  +----+----+       +----+----+       +----+----+       +----+----+ | +-=
---+----+
> >       |                 |                 |                 |      |   =
   |
> >  +----+---------------+ |                 |                 |      |   =
   |
> >  | init hostapd & HW  | |                 |                 |      |   =
   |
> >  | MAPC support update| |                 |                 |      |   =
   |
> >  +----+---------------+ |  MAPC Discovery |                 |      |   =
   |
> >       |                 |    Request      |                 |      |   =
   |
> >       |                 |(MAPC capability)|                 |      |   =
   |
> >       +-----------------+-----------------+-----------------+------|---=
--->
> >       |                 |  MAPC Discovery |                 |      |   =
   |
> >       |                 |    Response     |                 |      |   =
   |
> >       |                 |(MAPC capability)|                 |      |   =
   |
> >       <-----------------+-----------------+-----------------+------|---=
---+

Those are action frames just going between the hostapd instances (or
similar), why does the firmware need to create an event to hostapd
itself?

> +--------------------------------------------------------------------+   =
        =20
> >                           UHR AP-1                                 |   =
        =20
> >  +---------+       +---------+       +---------+       +---------+ | +-=
--------+
> >  |         |       |         |       |         |       |         | | | =
        |
> >  | hostapd |       | cfg80211|       | mac80211|       |  wlan   | | | =
 UHR    |
> >  |         |       |         |       |         |       | driver  | | | =
 AP-2   |
> >  +----+----+       +----+----+       +----+----+       +----+----+ | +-=
---+----+
> >       |                 |                 |                 |      |   =
   |    =20
> >       |                 |                 |  +--------------+-----+|   =
   |    =20
> >       |                 |                 |  | Notify hostapd to  ||   =
   |    =20
> >       |                 |                 |  |    Trigger MAPC    ||   =
   |    =20
> >       |                 |                 |  |    Negotiation     ||   =
   |    =20
> >       |                 |                 |  +--------------+-----+|   =
   |    =20
> >       |  NL80211_CMD_MAPC_NEGOTIATION_TRIGGER(scheme-id,action)    |   =
   |    =20
> >       <-----------------+-----------------+-----------------+      |   =
   |  =C2=A0

Here, why? What does this do in FW?


> >  =20
> >  +----+---------------+ |                 |                 |      |   =
   |    =20
> >  |parse scheme-id &   | |                 |                 |      |   =
   |    =20
> >  |action. Init MAPC   | |MAPC Negotiation |                 |      |   =
   |    =20
> >  |    Negotiation     | |     Request     |                 |      |   =
   |    =20
> >  +----+---------------+(scheme params & APID1               |      |   =
   |    =20
> >       |              Optype:ESTABLISHMENT/UPDATE)           |      |   =
   |    =20
> >       +-----------------+-----------------+-----------------+------+---=
--->    =20

Hostapd parses something the ... FW gave it? That seems odd. We should
give it in a decent data structure format, if this is at all sensible, I
have no idea.

>           New notifications from cfg80211 to user space:
>           - NL80211_CMD_MAPC_NEGOTIATION_TRIGGER
>             Direction: kernel to user space.
>             Source: cfg80211 on behalf of the WLAN driver/firmware.
>             Purpose: Provide a hint to hostapd that MAPC Negotiation
>             Request should be triggered on this interface. For each=20
>             MAPC scheme, the driver/firmware may request establishment,
>             update, or teardown of an agreement. hostapd is expected
>             to apply policy and iterate over the locally known MAPC
>             peers for this interface.
>=20
>             Attributes:
>             - NL80211_ATTR_MAPC_SCHEMES (nested)
>               Contains one or more per-scheme MAPC negotiation hints. Eac=
h
>               nested entry includes:
>               - NL80211_ATTR_MAPC_SCHEME_TYPE
>                 Identifies the MAPC scheme (e.g., Co-BF, Co-SR, Co-TDMA,
> 				Co-RTWT, Co-CR).
>               - NL80211_ATTR_MAPC_ACTION
>                 Requested negotiation action for this scheme:
>                 - NL80211_MAPC_ACTION_ESTABLISH: establish new agreement(=
s).
>                 - NL80211_MAPC_ACTION_UPDATE: update existing agreement(s=
).
>                 - NL80211_MAPC_ACTION_TEARDOWN: teardown existing agreeme=
nt(s).

Why do you always want to let firmware be in control of everything?
Seems at least for some of this you'd really want the upper layers to
control it for purposes of coordination? How does the FW even know which
other AP it can coordinate with, isn't that something a network
controller would determine?

>       (C) mac80211
>           Two design options are considered for representing MAPC peers i=
n
>           mac80211:
>=20
>           Option-A(Preferred): Reuse existing station management infra
>           - Allocate standard station objects (struct sta_info / struct
>             ieee80211_sta) to represent MAPC peers, and call the WLAN dri=
ver.
>           - Use a subset of the existing mac80211 station states (NOTEXIS=
T,
>             NONE, AUTH) to represent a MAPC stations.

I'd say AUTH doesn't work, for purposes of key management etc. you
really want this to be in AUTHORIZED state.

>           Option-B: Define lightweight MAPC peer/station management
>           infra

But that doesn't seem better either really.

johannes

