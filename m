Return-Path: <linux-wireless+bounces-26050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DDB15696
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 02:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE343A23B5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC577E0E4;
	Wed, 30 Jul 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="G43m3NDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16443AA8;
	Wed, 30 Jul 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835788; cv=none; b=p2FEBcH2yEw1XwnnewhnuL5/s4cwfLxDzAmNFZIGsbfN3Ods95edg4NvOkElKqZp+j+0B7KZXSQkxE4Pfz5b/QBagVzyKKtHoS8eXIxlcoZKc/6fW/lk9Jfx1EB3EK7TIwQ7LcWE65/7mHWqQBMx3guYvuLmc9v+3372wXVTT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835788; c=relaxed/simple;
	bh=Xgkqjthp0xD8K7KDTt/KKfzQFiK9OF2TanBEnNzVjoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pu4dlbLGHWj0kvRrpfnvtnbnnR2gpuG/RlzUCXnK087IP0ch+h6opQ1LYnVtFxpAQlCmstXXiSS7gkq1o5tEgfVNPMi++aKOKymWSUY0SdDetM7BAq20Mw6t9PRYN5PL+DJAb4/riXuHYlO3prO+YuPydYmgu+y20ObWBiqInaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=G43m3NDM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56U0a4eI52729127, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753835764; bh=ihPtxIQdIF+lWYnPR+GKRWPzygHLYkLUE15oRvSc/Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=G43m3NDMGgoJ5g7cYlCSl6N2nUtGs79NIE06SgRYIpKP0TOQVFRsOY1ODkfrfes3j
	 evD3UArKaf49Arqs7S0z1+o0mNfMP23zKTszW3o8nZ7tJA5qPCoBdQMal65yl/GT60
	 2LylDuTSWvK6xlV0MgspgUeC2p5RwtxXTYb1kgUw14ih2vA74qecPMYJK0hMJthUiq
	 NT3qCJclZAE41QbioVMr1zUgQnYKuoOGMIqZZ0cPdz2SJOKlFFywFy4JYYIoQGdBQ9
	 /yCgsnmOed3gfxUlfYYdwCZ+KpXF6AwWTHeT88bGNW4hUekdMVgjuJReqzkP/oWjfn
	 cLokD2zwT1Xhg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56U0a4eI52729127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 08:36:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 08:36:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Jul 2025 08:36:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 30 Jul 2025 08:36:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sean Anderson <sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Topic: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Index: AQHcANxb3F/NWj2ltUS/9AXHQ44SQ7RJzkeg
Date: Wed, 30 Jul 2025 00:36:04 +0000
Message-ID: <c034d5cc40784bfa859f918806c567de@realtek.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
In-Reply-To: <20250729204437.164320-1-sean.anderson@linux.dev>
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

Sean Anderson <sean.anderson@linux.dev> wrote:
> There are more unsupported functions than just LOWRT_RTY. Improve on
> commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
> warning message") by printing a message just once when we first
> encounter an unsupported class.=20

Once I encounter an unsupported class/func, I'll check firmware team if the
C2H events can be ignored. If so, I add a dummy function to avoid the messa=
ge.
If not, I should add code to handle the event.=20

Do you want to see the message even though it only appears once?

> Do the same for each unsupported func of
> the supported classes. This prevents messages like
>=20
> rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
>=20
> from filling up dmesg.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> Changes in v2:
> - Also suppress unsupported func messages
>=20
>  drivers/net/wireless/realtek/rtw89/phy.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wirel=
ess/realtek/rtw89/phy.c
> index f4eee642e5ce..9484d80eea9b 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -3535,17 +3535,25 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwde=
v, struct sk_buff *skb,
>  {
>         void (*handler)(struct rtw89_dev *rtwdev,
>                         struct sk_buff *c2h, u32 len) =3D NULL;
> +       static DECLARE_BITMAP(printed_ra, U8_MAX);
> +       static DECLARE_BITMAP(printed_rfk_log, U8_MAX);
> +       static DECLARE_BITMAP(printed_rfk_report, U8_MAX);
> +       static DECLARE_BITMAP(printed_class, U8_MAX);
> +       unsigned long *printed;
>=20
>         switch (class) {
>         case RTW89_PHY_C2H_CLASS_RA:
> +               printed =3D printed_ra;
>                 if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
>                         handler =3D rtw89_phy_c2h_ra_handler[func];
>                 break;
>         case RTW89_PHY_C2H_RFK_LOG:
> +               printed =3D printed_rfk_log;
>                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
>                         handler =3D rtw89_phy_c2h_rfk_log_handler[func];
>                 break;
>         case RTW89_PHY_C2H_RFK_REPORT:
> +               printed =3D printed_rfk_report;
>                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
>                         handler =3D rtw89_phy_c2h_rfk_report_handler[func=
];
>                 break;
> @@ -3554,12 +3562,16 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwde=
v, struct sk_buff *skb,
>                         return;
>                 fallthrough;
>         default:
> -               rtw89_info(rtwdev, "PHY c2h class %d not support\n", clas=
s);
> +               if (!test_and_set_bit(class, printed_class))
> +                       rtw89_info(rtwdev, "PHY c2h class %d not supporte=
d\n",
> +                                  class);
>                 return;
>         }
>         if (!handler) {
> -               rtw89_info(rtwdev, "PHY c2h class %d func %d not support\=
n", class,
> -                          func);
> +               if (!test_and_set_bit(func, printed))
> +                       rtw89_info(rtwdev,
> +                                  "PHY c2h class %d func %d not supporte=
d\n",
> +                                  class, func);
>                 return;
>         }
>         handler(rtwdev, skb, len);
> --
> 2.35.1.1320.gc452695387.dirty


