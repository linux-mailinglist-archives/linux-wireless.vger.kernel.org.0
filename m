Return-Path: <linux-wireless+bounces-37006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEisOWXbFmq2twcAu9opvQ
	(envelope-from <linux-wireless+bounces-37006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:54:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BF5E3B13
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7103048143
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81032400E1A;
	Wed, 27 May 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HIA5JwgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A6218845;
	Wed, 27 May 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882533; cv=none; b=Y1QtDUvUS+15L8N3LTwdbR++THHIHLl0NNWPB30Ajg8+oQ5p4SxD0nbCgEthuW+2Pw5CBvFMN+UajTHk1xh2xGSkWwwZgFsvwdIvrpeFZgNMDl11S6Z7poaryv7DnffmFGiVwgb/VmyTFW9ighQnnJCXJgL3J4T9O/8QX1OMCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882533; c=relaxed/simple;
	bh=7QI8llH0Fpk48C9IV0zLz+V0GpWMqubo42UVL/fZK7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZupVA/RBf6lGeuMurSdmw346fY7Ndv3bcyzwEzfQsEvjWSnhuy0TsvGI2DxGfO1+7IMMdW8I9FdRohkw+83lxrdjAZS0wZUABH13eg+23GuIiQw3pBOD1GvTJ45lnKoWIqsTPquoSw7u1qQ50Wg5220ikF2ay4A5qGl00FhIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HIA5JwgJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64RBml9zB2411447, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779882527; bh=qwuRPNG02lptRoTNiRDh4eyAPpSwfeQc4F2R/gdHt6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HIA5JwgJbwdCqBcqd/7BOkzogeA3o9c1l9QaBv151pLA+TgMMXVt6hu57oRCq0S9W
	 KLb4ginO/Kru1JOUeNwL3MRFJNaOPhSNsy2HP3MUSmHBF55935jNt41fOMAdtFvF5q
	 qH+vTmIXqTPkyjSGqv0iDlqx69GGsmaw+O37fFm/QbXt9Qyve2jXQjwtTEXZM8806N
	 EddEXjDr+ylOjOac9AmsbZflxCUvSi0g88SkOib0mwAov3fNAZny/YBOyMw8sV3ADW
	 liPnLtwBwyKgnzRIQ6jFRySZzZ4ckA6jeNQHfFIhB1XTLr28axC4Xdo4fRL68GcXbc
	 qU//1rB0N1VQA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64RBml9zB2411447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 19:48:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 19:48:47 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 19:48:46 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Wed, 27 May 2026 19:48:46 +0800
From: Johnson Tsai <wenjie.tsai@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Mh_chen
	<mh_chen@realtek.com>, "charlesl@valvesoftware.com"
	<charlesl@valvesoftware.com>, "sabae@valvesoftware.com"
	<sabae@valvesoftware.com>
Subject: RE: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to
 driver_info for per-device quirk control
Thread-Topic: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to
 driver_info for per-device quirk control
Thread-Index: AQHc7CPGiW93h30XpUiSLNaYVUgdtbYem9eAgABea4CAAsqMkA==
Date: Wed, 27 May 2026 11:48:46 +0000
Message-ID: <3ce9d9f4d2e3433ba4ddfd04b989ebb5@realtek.com>
References: <20260525085148.35180-1-pkshih@realtek.com>
 <20260525085148.35180-2-pkshih@realtek.com>
 <2026052558-handclasp-garden-b472@gregkh>
 <1f68b31265984b4e9e4be7872fe516d5@realtek.com>
In-Reply-To: <1f68b31265984b4e9e4be7872fe516d5@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37006-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenjie.tsai@realtek.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 640BF5E3B13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tuesday, May 26, 2026 9:10, Ping-Ke Shih wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, May 25, 2026 at 04:51:47PM +0800, Ping-Ke Shih wrote:
> > > --- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> > > +++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> > > @@ -73,6 +73,7 @@ static const struct rtw89_driver_info
> rtw89_8851be_info =3D {
> > >       .chip =3D &rtw8851b_chip_info,
> > >       .variant =3D NULL,
> > >       .quirks =3D NULL,
> > > +     .dev_id_quirks =3D 0,
> >
> > Why are you manually adding a "=3D 0" for these when that's the default=
?
> > No need to do so, only do it when it is set to something, right?
>=20
> I'd ask authors spending a little time to fill these default values becau=
se
> Realtek WiFi chips have many specific attributes for many chips, and
> somehow it gets messed. For example,
>  - miss to fill value for a certain chip
>    (people might only force on one chip he wants to fix)
>  - for some cases, it should set 0 explicitly as the value
>    (such as a threshold value of hardware register)
>  - messed up the order of attributes
>    People add a field along the existing field across all chips.
>    If a field is omitted, somehow people might add the field at wrong pla=
ce.
>  - simply coding rule
>    People might forget why, so I'd have a simple rule for them.
>=20
> I encountered these cases when I processed earlier Realtek WiFi drivers
> (rtlwifi, rtl8xxxu, rtw88), so I'd explicitly fill values to avoid them.
>=20

Just a gentle follow-up on Ping-Ke's explanation regarding the explicit "=
=3D 0" initialization.=20

If there are no further concerns on this, I will keep the current approach =
for this part and send out the v3 patch.


Thanks,

Johnson

