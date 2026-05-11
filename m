Return-Path: <linux-wireless+bounces-36209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIu4FjuLAWp4dQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:54:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8B509A1A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC20F3051489
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2913A785A;
	Mon, 11 May 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rG/RDuUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB13A6B64
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485647; cv=none; b=fuJjfVZdgEn7qMumRfGc4Gl7PkgrTSG/nkQTCaLOFxgner4jpBAT2E9KuA/DcOxq6ONvH9Kr08DDPMYnHZS1LqzPp8gzBuSPdY0i/4we0PJ2y/ktPJ5iejjSp7lPNGNqs5s+yA0mdbusvNxpbUDzFqLOoZaak+Sk9mD67+PEc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485647; c=relaxed/simple;
	bh=g2CBvieFpaoUTXha6giSpwYAQFospAfoCnEcvVi8aHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2z7J1tmFrKHmfJIeqtTs3yIpzUFEW2FrnKODcGRYxRme65JRNXDK7yqZ3mmVlPfOzjJWgQ1qRp7DaK5j/dbMGFbziHv7J5h6zoS11KY6mE03tZdxLdmV1FoAmmFhuSs0FMQJY8zXRDRMJQM7I8sowhWzPBNwHkRY1/OXz13xUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rG/RDuUX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hd03KedD/dPRrIUJtGuMPGyR9MAf8xaAXzggQQ0rj+w=;
	t=1778485637; x=1779695237; b=rG/RDuUX0QeRVg9+yNeBndgfJh9ShTDdJrNS1U2OfnAJHlF
	Ovg/8CP7fzES6JpEnOorok+2eVwXext8hT8zVW7kPydjDXdh7kby9F9OMPuu4WFCAMEDENQXkSdWW
	uL164Fu8ELjHSyNde44svJugp3T89SPuU93nMLXI4ubM1HM7BgwYe+VTPDu7EcbGaueH6n3XaRuxk
	x+5XZzw9lNvDAfhail/o4FrgN8G/rvgYhd8kuNM9et0YxrwH6ZcOp3UX98u3bk4+RKLmhw0DJq76s
	zcolDAaekp+zOVbQsa6skgJvOJgyQgCmqv7avUMhAuwIFtZK5q9BHS0Ak711omUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMLM0-0000000EVVV-44t0;
	Mon, 11 May 2026 09:47:05 +0200
Message-ID: <ecb7aef2f18cc7c04817be155017a54a45fa579e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] Fix overread in PREQ frame processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 11 May 2026 09:47:04 +0200
In-Reply-To: <20260509234143.101237-1-masashi.honma@gmail.com>
References: 
	<db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
	 <20260509234143.101237-1-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: C4A8B509A1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36209-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Action: no action

Hi,

Please send new versions with a version tag ('v2' in the subject etc.),
and not in the old thread, that just messes up the threads. Ideally tag
which tree these should go to, though I think given the many other
things I'll put this into wireless-next anyway, unless you strongly feel
it needs to be in wireless?

Also, please use appropriate "wifi: mac80211: " prefix in the subject.

> +#define PREQ_IE_PREQ_ID(x)	u32_field_get(x, 3, 0)

This isn't really right since u32_field_get() exists only within
mesh_hwmp.c ... it's probably better to modernise all this while at it:

#define IEEE80211_MESH_HWMP_FLAGS_AE	0x40

struct ieee80211_mesh_hwmp_target {
	u8 flags;
	u8 addr[ETH_ALEN];
	__le32 sn;
} __packed;

struct ieee80211_mesh_hwmp_element {
	u8 flags;
	u8 hopcount;
	u8 ttl;
	__le32 preq_id;
	u8 orig_addr[ETH_ALEN];
	__le32 orig_sn;

	/* optional AE, lifetime, metric, target */
	u8 variable[];
} __packed;

and then some inlines like

static inline const struct ieee80211_mesh_hwmp_target *
ieee80211_mesh_hwmp_get_target(const struct ieee80211_mesh_hwmp_element *el=
em)
{
	int offs =3D 8; // seems wrong

	if (elem->flags & IEEE80211_MESH_HWMP_FLAGS_AE)
		offs +=3D ETH_ALEN;
=09
	return (const void *)&elem->variable[offs];
}

static inline u32
ieee80211_mesh_hwmp_get_lifetime(const struct ieee80211_mesh_hwmp_element *=
elem)
{
	int offs =3D FIXME; // not sure

	if (elem->flags & IEEE80211_MESH_HWMP_FLAGS_AE)
		offs +=3D ETH_ALEN;
=09
	return (const void *)&elem->variable[offs];
}

and restructure the code accordingly?

Anyway, I dunno. Maybe we should just go with your original patch for
now. Maybe I'm also asking more of you than others because you have an
LLM to help ;-)

johannes

