Return-Path: <linux-wireless+bounces-3517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483A852BC2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 09:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC63D1F24310
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB62208B;
	Tue, 13 Feb 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QnjBuyFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A62261A
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814641; cv=none; b=myRk06sz0tPXL5aM/f4vej3rzV9x2/bwNT246nfHldUa0UtTRgbh5vmnSaR06Eo5LsRzcYQ7F+J7CoLDZGrx5b3dRMJJbXK2set+jcz2jU1RAc8n50nS/Rsl92WwIEp5tH+daCchI5DmGQkxXVETgxm5xnA9K830tekGwE14iEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814641; c=relaxed/simple;
	bh=3Bxove3xW7LPM3vclx9kCej6+g4CP0JS+zwmX4llo4s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kN++TKNkicNXTTbbXIl2W25s23qVd5xeYca3HT/j6H65kuTuPlKwpe5GT7nZQ8GiRre6C1Y0C+lbUBqpCKZNEwTZDs56KkwR/6idIQ8maWram/l+Tyyh+F4gHofyGDgscV+le6/FGni5IdmcHi58h8q0qx9T3OWxmkeXNUSexuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QnjBuyFA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nN81jSM7WlT8EdAF2L75PKPSulfInXw77goOm51vmxE=;
	t=1707814639; x=1709024239; b=QnjBuyFAREPd0Fx8jxK4YMQWHDKNbtvSDRf/v/hMlIU5Hm/
	RD/G/ZPlZHbobAAeKGAukW3Z1L/1Ufqw4bh2Hox/XcCmZ/LuX4BNNFh5e9hF+Ow/V57eVCkAzssiw
	sDZbC7qqI3JkOqEWgzc1BWioMU6O4MpuxGIxB4WLsTqi7B8MKL7fFw1/SVSAAum9eodwWpzO48GJJ
	F7KgOXlU+mHj+0PI1A1ciDOueJdCXigdWFzWxHNIgysnwuLvTyh3yvqr5Ju2uiMArAXLyiABjHGfT
	gyg6T8k2ArjlDqjoGBODxzbpX2m61q3cnzpyPqL+/y/1zx1W/Ymd/zJuFYrvEKhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZobM-00000007YmO-2n2d;
	Tue, 13 Feb 2024 09:57:16 +0100
Message-ID: <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Tue, 13 Feb 2024 09:57:15 +0100
In-Reply-To: <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi PK,

Actually, sorry about this part of the patch. Pretty sure I meant to ask
you, but then wanted to get things together before everything broke ...

> > +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> > @@ -2495,8 +2495,11 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_=
dev *rtwdev,
> >  	}
> > =20
> >  	if (vif->bss_conf.eht_support) {
> > -		h2c->w4 |=3D le32_encode_bits(~vif->bss_conf.eht_puncturing,
> > +		u16 punct =3D vif->bss_conf.chanreq.oper.punctured;
> > +
> > +		h2c->w4 |=3D le32_encode_bits(~punct,
> >  					    CCTLINFO_G7_W4_ACT_SUBCH_CBW);
> > +		rcu_read_unlock();
>=20
> We don't deference chanctx to reference puncture value. Instead use the
> value from vif->bss_conf.chanreq, so I think we don't need RCU locks, rig=
ht?

Well, clearly the rcu_read_unlock() is wrong since it's not paired with
rcu_read_lock(). I don't know how neither I nor the robots noticed
that?!

The other thing here is that I'm not entirely sure how the driver works,
chances are that this was previously a bug, and now is still a bug,
unless the driver doesn't really support channel contexts, or any form
of concurrency.

If you actually have the ability to support two connections (e.g. P2P
and BSS client) then theoretically it's possible that you have two EHT
connections with compatible puncturing, using the same channel context,
but with different bandwidths, e.g.

BSS 160 MHz   |   |   |   |   | C |   |   | P |
P2P                           | C |   |   | P |

(P) indicates punctured subchannel, (C) indicates control channel

In this case, p2p_vif->bss_conf.chanreq.oper.punctured =3D=3D 0x8 whereas
bss_vif->bss_conf.chanreq.oper.punctured =3D=3D 0x80.

However, you'd really be using the actual channel configuration from the
channel context, which matches the BSS vif, so should be puncturing
bitmap 0x80.


So realistically, what you probably need/want to do is move this whole
chunk of code to when the *channel context* changes, i.e. to
rtw89_chanctx_ops_change(). You even get the
IEEE80211_CHANCTX_CHANGE_PUNCTURING flag when the puncturing changes
there. Also need it in rtw89_chanctx_ops_add() of course, and possibly
in rtw89_chanctx_ops_remove().

Though it _looks_ like you only support one channel context there, so
maybe also only one vif, and it doesn't matter? I'd probably still move
it over to the chan.c code though, it really does belong there more as
discussed in the commit message of this change.

But I didn't want to make those more semantic changes because I don't
know what logic your device applies here.


And sorry about the locking bug! Not sure how that happened :(

johannes

