Return-Path: <linux-wireless+bounces-35540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFNqFtJT8WkugAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:41:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4548DCCA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 494023017519
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9532135B8;
	Wed, 29 Apr 2026 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FC44CfdH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB11BC08F;
	Wed, 29 Apr 2026 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423308; cv=none; b=rFGoZAF/bVbVW0Tm1LrflOpCuvCs5VrUqN8Wk7yY4S+y0ly3KGRApsg8KfXM125rOMcOJ0YWQ2YqA24JGhsvr0OAktJ6H4AFeASR40e8kcdHelOljwYlGsOqC4GChIoKaV9/ds+LWf9VZNuo7kQmOPMbr001sTPtJvps/LYaRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423308; c=relaxed/simple;
	bh=SRVu0gvzT/ehuCyMCHuLngBCW6c+UO5WR3it6v24epA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DsZKDqYe2SrykJGu9jqxDl5z/iAoM6zeS9kPbt4kDrijpAtH7iWTaUJ/Yf5Wzy9g93ZvE5G/WnlwVSp1PVJ9Vy4ZQeTXd8SH6JLbKbwWVMT8k/Yhq55ANehvUzCzcptRQymkBlez84kyVHc6V9ZtdOrg7NgntUY7cCRiPsflBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FC44CfdH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T0dsv87849936, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777423195; bh=M40E/Xv0XWgIE9iHSFt6HVwr8JYRwYTzfsgJDkisjQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FC44CfdHXDeaHc+XB4lJf0su/ilf1md9v9++5QMFKO5Vj/V+0skE9usVY1Mqhufa5
	 +s6Er2dw3P7GMzYWh1VQJzg+ZaFuQbKiKMiql+mELkuWTZXrBGWRfTEUrJt7BEhigG
	 HV7huvqUE2n0DTJsL4OSWUmgPyjwYxeuBhK/1nqCzRcH8/ySk5qgULccISSJkb+e8J
	 QuGlUWObMctHsgxQhg+KgKtLB81cMBeWrqiJ2wrCbpeB6vsehFXrbnqG42bwFrEXnC
	 S+Kq6+5LrXH1XXwFOUhTqb3LZbXqs9RdrOFApRw64P9fVTo76Ti04EhfWvVXnVcwhx
	 JTaBD/R9SzuoA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T0dsv87849936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 08:39:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 08:39:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 08:39:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Wed, 29 Apr 2026 08:39:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: David Laight <david.laight.linux@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
        "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede
	<hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Salah Triki <salah.triki@gmail.com>,
        "Achim
 Gratz" <Achim.Gratz@stromeko.de>,
        Ben Collins <bcollins@watter.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: RE: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Topic: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Index: AQHc1o6xWsc4T9bdAkGO0jI3Cj/ORbXziO4AgAA7mwCAAW5CsA==
Date: Wed, 29 Apr 2026 00:39:55 +0000
Message-ID: <5747f43ed3b44cbd839716e07e1186fd@realtek.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
	<20260427214127.406067-8-ynorov@nvidia.com>
	<afBdXj_9r25Ssnz6@ashevche-desk.local> <20260428114342.0d674fd8@pumpkin>
In-Reply-To: <20260428114342.0d674fd8@pumpkin>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3DC4548DCCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35540-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,analog.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

David Laight <david.laight.linux@gmail.com> wrote:
>=20
> On Tue, 28 Apr 2026 10:10:22 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Mon, Apr 27, 2026 at 05:41:24PM -0400, Yury Norov wrote:
> > > Switch from sign_extend32(FIELD_GET()) to the dedicated
> > > FIELD_GET_SIGNED() and don't calculate the fields length explicitly.
> >
> > ...
> >
> > >     for (i =3D 0; i < ADDC_T_AVG; i++) {
> > >             tmp =3D rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWOR=
D);
> > > -           dc_re +=3D sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > > -           dc_im +=3D sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > > +           dc_re +=3D FIELD_GET_SIGNED(0xfff000, tmp);
> > > +           dc_im +=3D FIELD_GET_SIGNED(0xfff, tmp);
> >
> > In the same driver the GENMASK() is being used, why not  doing it here =
while at it?
>=20
> To me those bit masks look more readable than the GENMASK() calls would b=
e.

Either way is fine to me. As we rewrite these into rtw89, using GENMASK()
can be easier to check if vendor driver defines the masks correctly, no
overlap.=20

Ping-Ke


