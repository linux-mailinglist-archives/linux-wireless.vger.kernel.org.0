Return-Path: <linux-wireless+bounces-32614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nr1A4mZqmkxUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:08:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519721D9FE
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B76D300442C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7F8479;
	Fri,  6 Mar 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mSShidGs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C738158DA3;
	Fri,  6 Mar 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788067; cv=none; b=Xod/W2d61M+kTtg5DE9kS4akwbApzUGvF6y9sPd58dGSPqT2cL1ZbY6tVgS8PvXoEVY85+hZClVzxyIs8rvX0bBeETxXy25CYOEC22qc6xd7rt6CIt4UpUJG20kLy3mXypg6mFzXO7gtRDL7W45Prqj/EX9RZW5cIKNPSd0ExFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788067; c=relaxed/simple;
	bh=Ibyu+M5jBYSutPZCDQaTqSZguya8pb+78+QfT8HUgLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MqjdYUM7eEsUcJSXG8TTJwjND0Tez3YXM8H/JCtYbdZFvmEBNHFRrrh6XErMtNj2hFSjRd8xYeliaYCbyiSAWrELEDRgGVrwAENZ01+qoO+1iD+dJH9UVtueXahRoNxKQfRNCx4MIb033vrvr+GR9tS3Qf/fxhl19MTwi+zEGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mSShidGs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62694MwD43092504, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772787862; bh=Mny1+BKvl9hHCC52gtmeAmDWz08iQHJnQohacOFyU1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mSShidGsMfn2tBvX2uCi2FLqwdn4+0D1wvfY/Q/37tX6Yur2b1Br/yO6Ln3TqhNBg
	 xhFitETXRTfc7Cq03GpxBJUo+CBtW59UlcI3+LiY4f0QAQ6386mry6/l3p7KA++kF9
	 fQz5c4W36TdDUzyQeYKdPMSsbnExKfu7E6QgnQqHSpjqUpeHe57Ahwfd7ZugvzsibL
	 EkdVqDIZpnJYHwooCGXdGH9OQIjuC//HH3hvvfls6DvSlspdbKkahcfqzlycVVWUyZ
	 +1huSrhcjmnxVEBnCxLEoRZyRug7+L2Nw+Deeh61S8Kn4wpn2sneaDWxCBsWh1AQG/
	 e2TkSyrM1hzhw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62694MwD43092504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 17:04:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 6 Mar 2026 17:04:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 6 Mar 2026 17:04:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 6 Mar 2026 17:04:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johan Hovold <johan@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Brian
 Norris" <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Ryder
 Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Sean
 Wang" <sean.wang@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>, "Stanislaw
 Gruszka" <stf_xl@wp.pl>,
        Hin-Tak Leung <hintak.leung@gmail.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea
	<claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Topic: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Index: AQHcrJBJgpW9edckl0WtWY+w5y49ArWgtZSA///saICAAJSWcA==
Date: Fri, 6 Mar 2026 09:04:22 +0000
Message-ID: <81935da1c67a493c8313d906244dd577@realtek.com>
References: <20260305110713.17725-1-johan@kernel.org>
 <0c75afbbe7bb419cab648f94191fe47f@realtek.com>
 <aaqL0RdwEjWWjECk@hovoldconsulting.com>
In-Reply-To: <aaqL0RdwEjWWjECk@hovoldconsulting.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1519721D9FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-32614-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Johan Hovold <johan@kernel.org> wrote:
> On Fri, Mar 06, 2026 at 01:40:31AM +0000, Ping-Ke Shih wrote:
> > // +Cc Greg
> >
> > Hi Johan,
> >
> > Johan Hovold <johan@kernel.org> wrote:
> >
> > [...]
> >
> > >  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  4 ----
> > >  drivers/net/wireless/realtek/rtl8xxxu/core.c       | 11 +++--------
> > >  drivers/net/wireless/realtek/rtlwifi/usb.c         |  4 ----
> >
> > Acked to changes of these Realtek WiFi drivers. But I'd like to know wh=
y
> > rtw88/rtw89 aren't included in this patchset?
>=20
> I used a more specific grep pattern to catch driver releasing references
> in disconnect() and therefore missed a few that dropped the reference in
> helper functions (or used non-standard names for their disconnect
> function such as ath10k, I see now).
>=20
> > Greg sent a patch [1] to
> > correct error path of USB probe for rtw88. In the discussion, he also
> > mentioned the simplest way is to drop usb_get_dev()/usb_put_dev() like
> > this patchset does. Will you share patches for rtw88/rtw89? I so, I'd
> > drop Greg's patch and apply yours.
> >
> > [1] https://lore.kernel.org/linux-wireless/2026022333-periscope-unusual=
-f0a0@gregkh/
>=20
> Sure, I can include rtw88 (and ath10k and ath6kl) in a v2.

Can you please also include rtw89? (I saw you have sent v2 though)

>=20
> Do you really prefer replacing Greg's fix or shall I send an incremental
> patch on top?

No. I'd drop Gerg's fix from my tree.

Ping-Ke


