Return-Path: <linux-wireless+bounces-36893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJsNJt3yFGrnRgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 03:09:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC325CF641
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 03:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 048F93006822
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F092765E2;
	Tue, 26 May 2026 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h0tvQ2Wh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310E19539F;
	Tue, 26 May 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757786; cv=none; b=rmSNCs6KE/H64Ob6sJxq1wWnaJoj6kKUsFgi7bSCndppnDPndftBIEqRiprp7YXNH0qUXGSurnDrUkA7/JxRTqWef3KD4J4MHR3oyOViQVfdmxuQdgiZAgCcwqXfu46bin/yu45OGFe3ef0WJ1Qde8pJ5DySXCcbaOaVHvLtuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757786; c=relaxed/simple;
	bh=Eoz2j2tzMvOZ3kNT/6gorXkyhQQgyskhB4NUpc3Nehw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkYvwNIBSa8tBuXOJDm/SINKPlQm4k2q9ciPHRF16KuRXM3BYZRoV0rohXaNMz9APmKcpCrSewbSwI+yjAmT7eZprsSiad8JRv9ZkD2KbhoFdFHKrUoM5CZ43+bhOuPKo9X57K8zm9IzijfL8hQM83K+OZZ+SL2y/a70PGHukzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h0tvQ2Wh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64Q19cvH61372176, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779757778; bh=YO3XXg7AsjDzOYSyYoYI6uCyGT+jbBRDXhnMpxOK2CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=h0tvQ2WhIzg01qHn0jxIBPHmaamulcAV0Gbt5vmmxPD8YnhJ7o/Cma2dGFTmJoJiv
	 ZB2KR9DIyMtYWoZbYrBflw2fUcLXhrj6apm6lD8VowNjoKiBIz82PLpk9uG+p7TF1i
	 xcb0Q9OBtnmKCITAgRUDDIndcUVtqthHDXP2lvVwAP4UpXqaAq0ZUXS7wJE0eueGt4
	 Dqd6L6JpB7iOdiVymZZGo+iNPV8YSmYUjCRC5+qk07ShkKadINuV1B8eNzVbrIiFrH
	 3pW6/3fU+1L3Xdo6MiAunT0uylmEwwNUl49ZsZt9gjx/g9imLywT7n9FezchHnnTWf
	 2pNIoRjYEyw7g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64Q19cvH61372176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 09:09:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 May 2026 09:09:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 May 2026 09:09:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 26 May 2026 09:09:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Johnson Tsai
	<wenjie.tsai@realtek.com>, Mh_chen <mh_chen@realtek.com>,
	"charlesl@valvesoftware.com" <charlesl@valvesoftware.com>,
	"sabae@valvesoftware.com" <sabae@valvesoftware.com>
Subject: RE: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to
 driver_info for per-device quirk control
Thread-Topic: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to
 driver_info for per-device quirk control
Thread-Index: AQHc7CSklVzBshn0bUasSCNz7LL+v7Yem9aAgADaurA=
Date: Tue, 26 May 2026 01:09:39 +0000
Message-ID: <1f68b31265984b4e9e4be7872fe516d5@realtek.com>
References: <20260525085148.35180-1-pkshih@realtek.com>
 <20260525085148.35180-2-pkshih@realtek.com>
 <2026052558-handclasp-garden-b472@gregkh>
In-Reply-To: <2026052558-handclasp-garden-b472@gregkh>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36893-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AC325CF641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, May 25, 2026 at 04:51:47PM +0800, Ping-Ke Shih wrote:
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
> > @@ -73,6 +73,7 @@ static const struct rtw89_driver_info rtw89_8851be_in=
fo =3D {
> >       .chip =3D &rtw8851b_chip_info,
> >       .variant =3D NULL,
> >       .quirks =3D NULL,
> > +     .dev_id_quirks =3D 0,
>=20
> Why are you manually adding a "=3D 0" for these when that's the default?
> No need to do so, only do it when it is set to something, right?

I'd ask authors spending a little time to fill these default values
because Realtek WiFi chips have many specific attributes for many
chips, and somehow it gets messed. For example,
 - miss to fill value for a certain chip=20
   (people might only force on one chip he wants to fix)
 - for some cases, it should set 0 explicitly as the value=20
   (such as a threshold value of hardware register)
 - messed up the order of attributes
   People add a field along the existing field across all chips.
   If a field is omitted, somehow people might add the field at wrong place=
.
 - simply coding rule
   People might forget why, so I'd have a simple rule for them.

I encountered these cases when I processed earlier Realtek WiFi drivers
(rtlwifi, rtl8xxxu, rtw88), so I'd explicitly fill values to avoid them.

Thanks
Ping-Ke


