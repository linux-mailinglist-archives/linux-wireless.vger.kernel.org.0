Return-Path: <linux-wireless+bounces-32205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN2dJnsqoGlrfwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 12:11:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52E1A4E0F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628683088244
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83805335063;
	Thu, 26 Feb 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NcR5JZlc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA32EC0AE;
	Thu, 26 Feb 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103918; cv=none; b=uGxtiwScOFAP8PlNTNm5ll5G8jBV9+NzwVhrwLr8fACL8rTyVpB/BCdNZ/gMkKu+FhHTi5SNnVsosxKVLAd3J14F+g99EP41AiqrwswTLY9/FFKylmkTskY7V/T2DhLvQDtxefHb/MOsNHimbEi0ccX2gF0q8Mk53I/Cpjcxg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103918; c=relaxed/simple;
	bh=V95bhn9rprxDi03+zPxnmBdDEHhjecqUFVKtWdLgg0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dK+3DcU2CcADlwYFZhTdebJHbY5h6Kxb6Wnw83o6pmEEo1ZxuEAWXO4hogyBLPGfNeVVhF/jEqaoOPoRKrNk24ceHo9Ev8f20ZrYlaYBBmz2j/fb79oPOITkXnOEgDIIPfjCiDlZCDhSGS+86tvczEMrhQJLt2LmvYufV/zGaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NcR5JZlc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DpVH+Eki7flv+ilLlNjtQCnrLNN1fQcCvY4UT+YV5Kg=;
	t=1772103917; x=1773313517; b=NcR5JZlc7XuQH7M3wGZoJdSpAxsygA8wS2wHHjhxw7GwN8O
	f6fchA0V3sl+SCugz52xjW4G9oURAXmrHGlyveiLJGmfKuNehuzaBhRSKpFlO3V0hUaw2diFPArEu
	KcYSYwjynWAFeFrqBktRRRho1wwHiHjeOTj3Zy8aTJ57wAU9ZUswyAcb3DXJaU5IfYK67p7x7Gy1S
	BKsGV/ben2P6957kMYNBGAtusOVYpfdAXvx7JxPoAN522Ws0NUOqgeRSgL6xUkmNzd+lEE5hpJiyQ
	ww7N8IGtyBPeU4sMqSsa7QJ0heH+TJ/KRQlX/boAg7KgUljbM9tOrXCOZy9oym0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvZBB-00000002Kw2-147P;
	Thu, 26 Feb 2026 12:05:13 +0100
Message-ID: <27f3c451a3b2d01132934fc7d96f2475947be263.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: update outdated comment
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, kexinsun
	 <kexinsun@smail.nju.edu.cn>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
	ratnadiraw@smu.edu.sg
Date: Thu, 26 Feb 2026 12:05:12 +0100
In-Reply-To: <b6tb5zvgfnu2tbttnd6fqlnwkvj2lzgoiwl4wz7urobdeptivs@xiefjb2zch4r> (sfid-20260226_115743_153734_7370BE3D)
References: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
	 <b6tb5zvgfnu2tbttnd6fqlnwkvj2lzgoiwl4wz7urobdeptivs@xiefjb2zch4r>
	 (sfid-20260226_115743_153734_7370BE3D)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32205-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmane.org:url,nju.edu.cn:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: EE52E1A4E0F
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 21:57 +1100, Lachlan Hodges wrote:
> On Tue, Feb 24, 2026 at 10:15:48AM +0800, kexinsun wrote:
> > The function ieee80211_start_scan() was refactored and replaced by
> > __ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
> > races and rework scanning"). Update the comment in
> > ieee80211_tx_h_check_assoc() accordingly.
> >=20
> > Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
> > ---
> >  net/mac80211/tx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index 8cdbd417d7be..85c48b42474c 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -288,7 +288,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data=
 *tx)
> >  		 * sent and we should not get here, but if we do
> >  		 * nonetheless, drop them to avoid sending them
> >  		 * off-channel. See the link below and
> > -		 * ieee80211_start_scan() for more.
> > +		 * __ieee80211_start_scan() for more.
> >  		 *
> >  		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/3008=
9
>=20
> Might be good to remove that link aswell and update the comment? Looks
> to be dead.

Hm, yeah, I can't say what this link was now.

I did find where it came from though:
https://lore.kernel.org/all/1237368810.5100.15.camel@johannes.local/

I suspect that maybe it was meant to point to
https://lore.kernel.org/all/20090316085741.GA29986@jm.kir.nu/

but I don't really know.

johannes

