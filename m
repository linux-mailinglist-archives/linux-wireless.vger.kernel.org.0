Return-Path: <linux-wireless+bounces-31298-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIYqIW8Re2nqAwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31298-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:51:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1BAD00A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C0C63006177
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B537755D;
	Thu, 29 Jan 2026 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GReHbAAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5C37A488
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673068; cv=none; b=pYshmxob9DHICCMgQy0c+4iezAmgYgWXnErEtFmT/2eyZ2iLpRiSmUqt/a/NDyUW9YvRx73pMKiQIALlR1NYqvYawl8NFLyq5rmMtfUK/MITPFGgDykhf6V1Qs+hJuHoGd/Dd8GXxDFb7o8FaRQdvxGEM93ctj6rc4tEvvlI45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673068; c=relaxed/simple;
	bh=lriHYEjqSEh7WDwB9+DlPzwtc1YL6y3+j644hpQq9l0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEKOtI7oSxvEx+s1MezrxMI7EcYFt4VEfOOT2pe4Je5tJy7BB7NxstID+eXaIt7fs4k+3YK6NXKGdilNY0R1ITuCR0umZ4d+7Ga4dEsoU8VcC1rjtDAbTDGEooKiHqF/+64GrygJlJjGE3rCqwGH9btLSCQLm33r6ij2rWwkjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GReHbAAE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CuR2rrVfX2N8yleKd21fSTR1cwbrHOk/8ds+GAs8Qyc=;
	t=1769673067; x=1770882667; b=GReHbAAExhnL+Lo1Ua1CBax7G92Ep+sWkQlnuhhKIjy34/P
	QvdoT5Z+MiCFD0YZYhoOvfOzyMj6TC7bmkMVA84YOKfFtK4eKmaE7eDkoxGIyZInsOqqZCMgoS2xH
	87hGEwD85y2p9010CgVoQF5ehyHcVBEONIaqyIYs0gAvLDlhTKhkdlDadJ4IIb8ZcfuJI9B13W0wY
	L5GEqrvde1+opifHCZ7P1y3owcW/hD85fGG1pzeOQYeRBzvoS4KVxzxlA40+n4BjK8dFCN/FTiqyX
	oFHTyZgImrASsq8qKxkQ84t8Zh4IacKlGjllg41nXoYqfh6t0BzRmRr6FddgghSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlMnv-00000006hnp-42MA;
	Thu, 29 Jan 2026 08:51:04 +0100
Message-ID: <49b1e6a881424b6ea29b5779d712314c263c816d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 3/3] wifi: mac80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 08:51:03 +0100
In-Reply-To: <415aaac2-eb63-446f-9fe5-315666ed3c64@oss.qualcomm.com> (sfid-20260129_084149_702774_96155DD0)
References: 
	<20260128133033.aa4a43982df0.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <20260128133033.fba9174f1fd1.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
	 <415aaac2-eb63-446f-9fe5-315666ed3c64@oss.qualcomm.com>
	 (sfid-20260129_084149_702774_96155DD0)
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
	TAGGED_FROM(0.00)[bounces-31298-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23D1BAD00A
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 13:11 +0530, Karthikeyan Kathirvel wrote:

[lots of quotes - if there was another comment I missed it]


> > +	skb_put_u8(skb, WLAN_EID_EXTENSION);
> > +	skb_put_u8(skb, len - 2);
> > +	skb_put_u8(skb, WLAN_EID_EXT_UHR_CAPA);
> > +	skb_put_data(skb, &uhr_cap->mac, sizeof(uhr_cap->mac));
> DBE not required for non-AP ?

"A non-AP STA does not include the DBE Capability Parameters field in
the UHR MAC Capabilities Information field."

johannes
>=20

