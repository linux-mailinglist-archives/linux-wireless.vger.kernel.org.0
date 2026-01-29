Return-Path: <linux-wireless+bounces-31320-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEUlLFNSe2nRDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31320-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:28:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA3B00D7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EA7F3003625
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D228850B;
	Thu, 29 Jan 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SfzJSQ2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484A218ADD
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689679; cv=none; b=XWE7QMTuVdJRnt9biOqf4MYa7T4nfhWhAYxcKs1dcMEC6VW875l6RMXXP8UWoDCi1IHp4yWxz9sSPnRw3QNSZzrmL3hjChorckb+329VC7E89sWVQMLBw+qQNeOwI4aW/qiSueFxnxLS9J78eef25S/S5g40IEJXnDmz6MGURac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689679; c=relaxed/simple;
	bh=1TE+wp1YRolgWaOfsqZs+F96oLr7OiVVc4WQeFuX5Nc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXgw651LYboBCJPetuiiH91uoOcDpILAODNjA8UiLnCHzIlsx5omAPdw3mc+e2kL1uWP3r/15MN/nCVc5UEN+nuVNiykts2OvJmy7mwotGgjiDYxfeBAn6dJAv/Ejn3P8y1s6lclwt5DU7HomYQEvFW2GzWaAhbptrhUDWPIi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SfzJSQ2j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pmfb1qsTBu3wwhQiREuM7CWQK0vsP/eFR245z+F4qRA=;
	t=1769689678; x=1770899278; b=SfzJSQ2jz8rcWJaul4w1vWjotMC8E52bMJf4tT/NzQp4YUI
	0GMHfPzvzSpr7aeOoxISFfUeC2A5wAPwa7/8kgS3BWP2Pwk+nj7ZfU1R50NxdJ927A+mllWHzh2af
	K4Q1jMROfzj1/kOiiIU8nsilI71nrWzsv4CZJGUyPZY/e4uwuqY15tLQjh9lp+lHoXCjU85ltBAU+
	hM3A3JJA27P3c5mzOycrEFYbj9ef6CKWdMQzSRvtM7vEtsycc5iwH7NfVlYfPDbwNTGSONMVFzSDL
	PQaj52Gze6mjwLVjgZjlSzjE4Wd4iHoyaztk/1fqPLF90kxlhsjc+QoNFPy7j6Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlR7s-00000006qbK-1VAG;
	Thu, 29 Jan 2026 13:27:56 +0100
Message-ID: <be12c67cc6d39203db0463aa703efde18d29e51e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 1/3] wifi: ieee80211: add some initial
 UHR definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 13:27:55 +0100
In-Reply-To: <0037ce8a-64ca-4986-a937-e35ef92289ab@freebox.fr> (sfid-20260129_124301_168453_B87927F7)
References: 
	<20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <0037ce8a-64ca-4986-a937-e35ef92289ab@freebox.fr>
	 (sfid-20260129_124301_168453_B87927F7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	TAGGED_FROM(0.00)[bounces-31320-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 50CA3B00D7
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 12:42 +0100, Pablo MARTIN-GOMEZ wrote:
>=20
> > +static inline const struct ieee80211_uhr_capa_phy *
> > +ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
> > +{
> > +	u8 offs =3D 0;
> > +
> > +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> Shouldn't we check for 'ap' here too?
>=20

We don't use this in a non-AP context right now, but I guess it makes
sense to prepare.

johannes

