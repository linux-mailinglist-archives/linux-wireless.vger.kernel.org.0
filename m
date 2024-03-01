Return-Path: <linux-wireless+bounces-4289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C804686DAB8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081C61C20CAB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48246425;
	Fri,  1 Mar 2024 04:36:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF0405DB;
	Fri,  1 Mar 2024 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709267797; cv=none; b=DMzdx+r34ksA462fXuoba67PY4FIkL2ezHbwQVUbai/v60xIgeOtN4/EDoNYfgzPivahrokXAc0OjA+Z1iBPnpUqvoT60uf7dwCNkmD4b/ErwwuESsJ8LNiPwl0g01f+e8+fll/4VNEISI5VFMssq4iP59E7SQn0m5rKXXRdGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709267797; c=relaxed/simple;
	bh=wdCREJ/ERf9GMjaN03MmgOGKwhRWI9srDXXsfp4H4vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KacBlezhe5owo/SdsxAd1l4hgvqHSvOuKYrCz19GrL+eybr9UB8jmTLO7CqXXUly+hKI7LtddXiVQzqeU6em+Z/7M/T4C6hhCbKnNyghgYeEqLghkYvP2/XXcwuf/dq6Rzsweact3gMgtWJx1sepzuxPPSgQMdawV/C/HRIZ5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4214a9Q011893683, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4214a9Q011893683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 12:36:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 12:36:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 12:36:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 12:36:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Topic: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Index: AQHaadh8n611UJm6iUqkDrqnT0K/C7EiKLcwgAAmtxA=
Date: Fri, 1 Mar 2024 04:36:08 +0000
Message-ID: <4fc45b4289d747dd80f76dcacef3c54d@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-6-fiona.klute@gmx.de>
 <3805850d51334319984bc304ca1dc3c4@realtek.com>
In-Reply-To: <3805850d51334319984bc304ca1dc3c4@realtek.com>
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



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Friday, March 1, 2024 10:33 AM
> To: Fiona Klute <fiona.klute@gmx.de>; linux-wireless@vger.kernel.org
> Cc: kvalo@kernel.org; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; =
pavel@ucw.cz; megi@xff.cz
> Subject: RE: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
>=20
>=20
>=20
> > -----Original Message-----
> > From: Fiona Klute <fiona.klute@gmx.de>
> > Sent: Wednesday, February 28, 2024 7:55 AM
> > To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@lin=
aro.org;
> linux-mmc@vger.kernel.org;
> > pavel@ucw.cz; megi@xff.cz
> > Subject: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
> >
> > +
> > +#define TRANS_SEQ_END                  \
> > +       {0xFFFF,                        \
> > +        RTW_PWR_CUT_ALL_MSK,           \
> > +        RTW_PWR_INTF_ALL_MSK,          \
> > +        0,                             \
> > +        RTW_PWR_CMD_END, 0, 0}
>=20
> Move this macro to main.h along with RTW_PWR_CUT_ALL_MSK.

Think of this again, I prefer removing braces
#define TRANS_SEQ_END			\
	 0xFFFF,			\
	 RTW_PWR_CUT_ALL_MSK,		\
	 RTW_PWR_INTF_ALL_MSK,		\
	 0,				\
	 RTW_PWR_CMD_END, 0, 0

Then, consumers look like

static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8703b[] =3D {
	{0x0005,
	 RTW_PWR_CUT_ALL_MSK,
	 RTW_PWR_INTF_ALL_MSK,
	 RTW_PWR_ADDR_MAC,
	 RTW_PWR_CMD_WRITE, BIT(7), 0},
	{TRANS_SEQ_END},  // <=3D=3D=3D This one will be consistent with others.
};

Ping-Ke


