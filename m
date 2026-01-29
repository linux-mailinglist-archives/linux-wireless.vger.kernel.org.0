Return-Path: <linux-wireless+bounces-31321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBf7GVNTe2nRDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:32:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79945B0137
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBDE63013D63
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A6344D8C;
	Thu, 29 Jan 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kzuVplmQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBD205E02
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689936; cv=none; b=m8eYHifpdaipfpH1VXWsQIVtoXvusliO+eAsbeDgCeBkPo8HNpn5BtnpTTCxV2VNsjPMt2nayLxIIpOSomWa4QuWbXDABd/OSAwcxND3QMy0d8HZnqrIaug/CK5IgRwZv+JZbjgnl/RqPY7tx68hvXVPO9WRYIeLfbmR6tMgO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689936; c=relaxed/simple;
	bh=almMixDPpN712yI/INes79bBcOkM/848WGyMgctC9Ac=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1Vi0/janBzsG5f3n01zXeVBzZPGwNMa2AejiBixCdGABw7qEkjJItWww4UYqy+l9/NGN/ISb7Z392x40sM1DNq0fPgPP34T0lmj2Ry8ECJg85VAINgww9IJaeW/fvr9GfHlnRRzy6fTzsSK0bN6+jF/LDFyVo0PF5oy0YUI+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kzuVplmQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k3RwuI56+kPBNOhMewict+1NbarCwuksZhpBLSrk8O0=;
	t=1769689935; x=1770899535; b=kzuVplmQwaiMc+uYSaZQvCLpu8/OeHB6qGiV7dxGixZPYM9
	+9DqLv3KQSi0NoLX4kNaIMXz6mst3wW/+wlslARE+AeJsmcC7ilNQbJowopPbnArW/y1QhUE5HU7L
	PXaD+CdjeX4BHkxoSYcwEg57SpDi7ApzjW+BrVgI9StRyS7AI9uUmHsqz0DOTxKLnv5CgVUZkFtgV
	wl5CXXY7R8li4FOpKxJp2Y6Qu03vUi7izxHjiimOtyjuUkPtl0vurELzQNbNXsHNT7cTmb3dTa/oh
	w/TtKyYaIEKi5u/Y3/8ZO0VQXEI3tOVoVzHqtIprag+NpfKoNq2vjyvJGwvmbqbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlRC0-00000006qkY-2C3f;
	Thu, 29 Jan 2026 13:32:12 +0100
Message-ID: <557b1daefd126666d9c8c988767c5f624195491a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 1/3] wifi: ieee80211: add some initial
 UHR definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 13:32:11 +0100
In-Reply-To: <be12c67cc6d39203db0463aa703efde18d29e51e.camel@sipsolutions.net> (sfid-20260129_132805_662889_B9EBAD77)
References: 
	<20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
		 <0037ce8a-64ca-4986-a937-e35ef92289ab@freebox.fr>
		 (sfid-20260129_124301_168453_B87927F7) <be12c67cc6d39203db0463aa703efde18d29e51e.camel@sipsolutions.net>
	 (sfid-20260129_132805_662889_B9EBAD77)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31321-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 79945B0137
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 13:27 +0100, Johannes Berg wrote:
> On Thu, 2026-01-29 at 12:42 +0100, Pablo MARTIN-GOMEZ wrote:
> >=20
> > > +static inline const struct ieee80211_uhr_capa_phy *
> > > +ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
> > > +{
> > > +	u8 offs =3D 0;
> > > +
> > > +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> > Shouldn't we check for 'ap' here too?
> >=20
>=20
> We don't use this in a non-AP context right now, but I guess it makes
> sense to prepare.

Actually, that wasn't even right, I did add some station handling code
on the AP side ...

johannes

