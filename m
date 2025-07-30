Return-Path: <linux-wireless+bounces-26052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6DB157EF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 05:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DB518936CD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 03:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522D77111;
	Wed, 30 Jul 2025 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="liSVPyQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24C4A32;
	Wed, 30 Jul 2025 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846955; cv=none; b=OPyPgC4Bi+nlwAEbAQOtXhVZrcMgmvKi3kVvBMh187dr2u+C7iYyScCKzfeDm43RGHkhxeOToVF9ttVk4b4aM7Cf9VEuQWGv1fR02/NuuR9JO9+AVs+08e4HPDfheUkAY9WhOQqDELXdzuv2rVAJvWuLLZelAIrx9qnTJJMhdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846955; c=relaxed/simple;
	bh=y7A+Cbj306d1WCA4eZFH5mlwMJjPjUpIqFI600wJ9VQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=CeK77C3lIQeFm3HhwJQyS7h6Z+A4o6l/aHYF5kFjrDsbiBD9hnaTQWwJeEL8YXfIz3RHJ+2/liqj7n4z78e9UUkTj2RvsAcInK8hyoQPhsXtjhIH4HfbSToAS954BqmCiNtCllKA1rFzKI6Tdlpv15Rdr9EjqwDAb69buxM3nGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=liSVPyQs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56U3gFRs93000309, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753846936; bh=emXP3TU+KkAxNPKlWl+x3MVQSf2hHwYEGXZb4YFAAPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=liSVPyQs5lt8bpbBjhC5BDWkHz5m04YaWMKr++QMi1OVK0fhPzdWQrR68peBPbNjv
	 1rvdixGt0K7u+TWDlvslLUpXmYfNWOAhSpzfwbZwYNkRt8bM7YNY6YmAP6tCf44Jhl
	 q5PIcuf9ez9xrXuV1d3g64gENG0WTNwUuxu4h20BKBh72cIJSrfFixISRaLLDwNhXT
	 lE0vh2/164qIBBj3OOUYavY9ybazEyekMfm9XW2JKWz9GDGtiJYc7lL/G3xOxpaM4Y
	 eFhOZOjKftXMhis3IhrY9y3elwo1lATqO4GFB/ENcmkqgKh5VBx9loZ2fwcPp5Pjco
	 vVbFNNHfSOyRw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56U3gFRs93000309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 11:42:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 11:42:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Jul 2025 11:42:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 30 Jul 2025 11:42:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sean Anderson <sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Topic: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Index: AQHcANxb3F/NWj2ltUS/9AXHQ44SQ7RJzkeggAA2TWA=
Date: Wed, 30 Jul 2025 03:42:15 +0000
Message-ID: <e8e68a94bb9940509233153f9764c397@realtek.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Sean Anderson <sean.anderson@linux.dev> wrote:
> > There are more unsupported functions than just LOWRT_RTY. Improve on
> > commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
> > warning message") by printing a message just once when we first
> > encounter an unsupported class.
>=20
> Once I encounter an unsupported class/func, I'll check firmware team if t=
he
> C2H events can be ignored. If so, I add a dummy function to avoid the mes=
sage.
> If not, I should add code to handle the event.
>=20
> Do you want to see the message even though it only appears once?
>=20
> > Do the same for each unsupported func of
> > the supported classes. This prevents messages like
> >
> > rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support

Is this a real example? We have handled class 2 (RTW89_PHY_C2H_CLASS_DM), n=
o?

Please point out the class / func you encountered. Then I can look up vendo=
r
driver or contact internal firmware team to know if we should implement or
just add a dummy function.

If we defer it, I don't know when we can do it.=20

> >
> > from filling up dmesg.
> >
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> >
> > Changes in v2:
> > - Also suppress unsupported func messages
> >
> >  drivers/net/wireless/realtek/rtw89/phy.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wir=
eless/realtek/rtw89/phy.c
> > index f4eee642e5ce..9484d80eea9b 100644
> > --- a/drivers/net/wireless/realtek/rtw89/phy.c
> > +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> > @@ -3535,17 +3535,25 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtw=
dev, struct sk_buff *skb,
> >  {
> >         void (*handler)(struct rtw89_dev *rtwdev,
> >                         struct sk_buff *c2h, u32 len) =3D NULL;
> > +       static DECLARE_BITMAP(printed_ra, U8_MAX);
> > +       static DECLARE_BITMAP(printed_rfk_log, U8_MAX);
> > +       static DECLARE_BITMAP(printed_rfk_report, U8_MAX);
> > +       static DECLARE_BITMAP(printed_class, U8_MAX);
> > +       unsigned long *printed;
> >
> >         switch (class) {
> >         case RTW89_PHY_C2H_CLASS_RA:
> > +               printed =3D printed_ra;
> >                 if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
> >                         handler =3D rtw89_phy_c2h_ra_handler[func];
> >                 break;
> >         case RTW89_PHY_C2H_RFK_LOG:
> > +               printed =3D printed_rfk_log;
> >                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
> >                         handler =3D rtw89_phy_c2h_rfk_log_handler[func]=
;
> >                 break;
> >         case RTW89_PHY_C2H_RFK_REPORT:
> > +               printed =3D printed_rfk_report;
> >                 if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler)=
)
> >                         handler =3D rtw89_phy_c2h_rfk_report_handler[fu=
nc];
> >                 break;
> > @@ -3554,12 +3562,16 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtw=
dev, struct sk_buff *skb,
> >                         return;
> >                 fallthrough;
> >         default:
> > -               rtw89_info(rtwdev, "PHY c2h class %d not support\n", cl=
ass);
> > +               if (!test_and_set_bit(class, printed_class))
> > +                       rtw89_info(rtwdev, "PHY c2h class %d not suppor=
ted\n",
> > +                                  class);
> >                 return;
> >         }
> >         if (!handler) {
> > -               rtw89_info(rtwdev, "PHY c2h class %d func %d not suppor=
t\n", class,
> > -                          func);
> > +               if (!test_and_set_bit(func, printed))
> > +                       rtw89_info(rtwdev,
> > +                                  "PHY c2h class %d func %d not suppor=
ted\n",
> > +                                  class, func);
> >                 return;
> >         }
> >         handler(rtwdev, skb, len);
> > --
> > 2.35.1.1320.gc452695387.dirty


