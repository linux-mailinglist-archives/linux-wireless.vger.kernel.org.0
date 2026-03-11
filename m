Return-Path: <linux-wireless+bounces-32958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AYoJNATsWkZqgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 08:03:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA525D27A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 08:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12CC9303F558
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666037646E;
	Wed, 11 Mar 2026 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mTxQthbh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E226B2DA;
	Wed, 11 Mar 2026 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212570; cv=none; b=EGvnf8cnZeCNDfIQcICtE6aQkxzOCd09R3QB3RjhxmBV5Gl9qdXTfwUoPPQR2ev7T5eU1GwgrE/cjDzeRiOBuo/oAE3FfrhNnkpYAYaPyBv/nJXnc9a3rxpbhNRShC+x1x4WexBXZOKWtYcjmJdO5Yof1hz1k+/uReO6E5GqCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212570; c=relaxed/simple;
	bh=6tv8senFdqX6Y5EDwJb0iCnsBGWxPh4CaJZL8KKD/n0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwzYJ5VygHHaZ9n22DancA1EvUAsOMDXf0ElUeI5lMBBC+lJWXFHBBFdb65GwbldvmgxALrDuNC/b2GEgwxprHgmQ+0JLq+l1WajIvtz8iQUq03FMxGi/g5CkWerFfn2mtZ3PBMjTkenIEEsNX8pvSom/1RE1IYsqjSt/KulCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mTxQthbh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6PS55y4gvmf4spClIBFgKMrT+PNhwcn/PfU6OM6TZfE=;
	t=1773212569; x=1774422169; b=mTxQthbhv/8YdqghvkjFV8DDPD389czorGLignXM1D9wY1A
	82SUtanmLHXzxkS+59US7MgA+22ODsPxEUyPjD2f6lBDJGDcGL7Y2dirrCv2O9YaOY93h7+lhtaq+
	uzT5gY0lykDOhnmM/0qN3HhgT3Eg7vGCIU16b1zaWzJ8qelhw2HW4EU1OWIHk0Sd2jxPN74Xb8b+y
	xNOHlnE7g3LFvY2I35grdpV8X4RxwfdMGBtR+m0VCqF20071I75He5RkIzFSSIvnUpLRBGd0ZsCDf
	jsXiICZ8jkR2dMSDljVTQw/2oJUY25cZPqBk3du3tcmArcq7t1AHClBlU5Q9H+yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0Dag-0000000Eh1y-0Wem;
	Wed, 11 Mar 2026 08:02:46 +0100
Message-ID: <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
Subject: Re: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Date: Wed, 11 Mar 2026 08:02:45 +0100
In-Reply-To: <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
	 <9b0144261da2ce7f5ef0a533928732cc43459e40.camel@sipsolutions.net>
	 <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
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
X-Rspamd-Queue-Id: 07AA525D27A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32958-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-11 at 11:30 +0800, Jeff Chen wrote:
> On Fri, Mar 06, 2026 at 10:19:43 AM +0100, Johannes Berg wrote:
> > On Thu, 2026-03-05 at 22:39 +0800, Jeff Chen wrote:
> > > This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
> > > IW611/IW612 chip family. These chips are tri-radio single-chip soluti=
ons
> > > with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
> > > Communication with the external host is via SDIO interface. The drive=
r is
> > > tested on i.MX8M Mini EVK in both STA and AP mode.
> >=20
> > How exactly was it tested, it doesn't even build ;-)
>=20
> Hi Johannes,
>=20
> I=E2=80=99d like to double check whether it was caused by the missing IW6=
1x SDIO IDs in sdio_ids.h:
> #define SDIO_VENDOR_ID_NXP           0x0471
> #define SDIO_DEVICE_ID_NXP_IW61X     0x0205

Probably? I didn't really check too much what the failures were, it's on
patchwork and you can check yourself. I just briefly checked that it
wasn't a false report.

> These definitions were not yet in wireless-next around 2026-03-06 when v1=
0 was tested, and
> only appeared in linux-next after 2026-03-10.
> Could the build issue you saw be due to these two IDs not being defined a=
t that time?

Obviously that would be an issue, and they still don't appear in
wireless-next, which tree do they actually appear in? There's usually
very little to no cross-tree merging going on before it all hits Linus's
tree, but it has to build before that happens, so I don't know how you
expected this to work?

johannes

