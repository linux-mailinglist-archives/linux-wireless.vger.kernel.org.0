Return-Path: <linux-wireless+bounces-32207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JYrFEZUoGlLiQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 15:10:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D141A73F0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24780311CD03
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17ED3B8BC9;
	Thu, 26 Feb 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p1z1dB+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B773B8D5C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113991; cv=none; b=Ifl7Z6+EWx1ARPNHmv80yloGnHJS7YDxTAIzoSd6dfqSIBldRwPQry0ieAoIu9RKfPd86PydSl6rmCTRUmRzlXuMxno0Bf8LLTMvbLN7q7pp8223W2VwBtWZ9p1VX03quluWsNuAtz0Kml6zbyQZoBf9Uc8212pLEFiu3g/LiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113991; c=relaxed/simple;
	bh=5XxH/S+XOG3q6I7YMwpQsgR5Rsaz5VsXKxB4eb/9yTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjrkEDGXkrVUQvIu7UG7PpEpjWH5uvD/5LQUSaw6BXk6K8P/tF4jMTiuRlkpx7wJ1+jO+a6nmDVmSvJsyOHudcna11Nv0zCejQK0qsZ5dbYCAbP43NA6pjoSmrurYQ7RunftaYY/S3MrSjSg5eTozQgdu1xcUX/PCn9plx3BiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p1z1dB+8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5XxH/S+XOG3q6I7YMwpQsgR5Rsaz5VsXKxB4eb/9yTY=;
	t=1772113989; x=1773323589; b=p1z1dB+8PQWLHRwF1DHyk2cd99M8PqUbar0bPTossDUMsH9
	3ADmoJ8+Rdcq8vHbtViHMznZCWWdNJ5rF0xA9AIzzZlrGI61H08owdZkCE9IVAGDvS30W2ac2G1Q+
	DXdhf9gbRreVbc7JvP5HLlOnOCswSt03HK4e/0Oue1l69M6U7x1SwDA2DzobKvHeGkNpRHjLJQmVO
	pYrqQRdfQLg3ifJ6+/KWYrm2mujnZF0+4IZUYDm1pjHRwE5JdVnZQy7c+PezEKy9NRD+eQNCnqnC0
	hVN4mjwOHmNdebEYdu8bB3yGW4xRDKOEjpAGt9d3fmIrHglbTcqRo64EkFMjirhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvbne-00000002PDJ-2mrd;
	Thu, 26 Feb 2026 14:53:06 +0100
Message-ID: <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise
 support for IEEE 802.1X authentication protocol
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 26 Feb 2026 14:53:06 +0100
In-Reply-To: <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
	 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
	 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
	 <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32207-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_MULTI_FAIL(0.00)[sipsolutions.net:server fail,sto.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08D141A73F0
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 19:20 +0530, Kavita Kavita wrote:
>=20
> On 2/26/2026 2:06 PM, Johannes Berg wrote:
> > On Thu, 2026-02-26 at 12:24 +0530, Kavita Kavita wrote:
> > > Advertise support for the IEEE 802.1X authentication protocol in
> > > mac80211_hwsim to enable testing scenarios.
> >=20
> > Do we even need this in drivers vs. mac80211 just setting it?
> >=20
> > All the code for it is in mac80211, so it shouldn't matter?
> >=20
> > I'd actually argue NL80211_EXT_FEATURE_EPPKE is the same, mac80211
> > should set it instead of the driver (I didn't merge [1] yet anyway) and
> > only NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION should be in the driver=
?
>=20
>=20
> For (Re)Association frame encryption, additional changes are required in =
the
> driver and firmware. Because of this dependency, we initially thought it =
was
> best to let the driver set the EPPKE and IEEE 802.1X Authentication featu=
re
> flags as well.
> However, since no lower-layer changes are actually needed for EPPKE and
> IEEE 802.1X Authentication, these can safely be advertised directly in ma=
c80211.
> The driver should only set the (Re)Association frame encryption feature f=
lag,
> and mac80211 can then conditionally enable the EPPKE and IEEE 802.1X Auth=
entication
> feature flags based on that indication.=20
>=20
> I will send the updated patch set with these changes. Thank you.

Right, works for me. Can you please also resend the hwsim patch for
EPPKE/assoc frame encryption then, that I linked to earlier? Feel free
to just put it into this patchset (instead of this one) of course.

I'm planning to apply the AAD/nonce fix soon, and then this can go in.

johannes

