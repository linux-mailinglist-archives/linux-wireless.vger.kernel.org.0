Return-Path: <linux-wireless+bounces-29927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF54CD008A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0D83026B1B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087733A719;
	Fri, 19 Dec 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AOljheAV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FE2E973F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150494; cv=none; b=I8Xbw+oDGhZWlYsnkMAYkvUYkNrxvDQtKKJDh2k1yVeqvWZkFF2xPruNrmJpE4IZfML/VdMbOWH4sSNtbgvUldTIHR1c9fRHjZDnvIO+f8eQGOnmKgMDjy2A4oPVV8ug7knveK5SvcakZjC8/HRStqLhcQSaObvPRnTFnngJJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150494; c=relaxed/simple;
	bh=TOpVihBNkGAExhWaFCYlWIbr/Tr0haT9OwM0+9mZEr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UlFunpzaMy8Id/RuSh3unPEW5+8QbAX6yqE/Y816JqgfkuXENRgOj5EGyPdDVEiJDauT2MKHKSwQothA8z+++lmAjXUtvXtJACtO0ntz/36C8fzvIM8UX+0n5hcKL7bjYXdHxNxqBHhU7XpPNIhWFzna/u7IAimQbZufmTXlRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AOljheAV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BJDLRPU01689004, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766150487; bh=m6FcKbzmp1mIb6RbhDe8NxopqFgyvpG3E8lP+Ww2tQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AOljheAVUGJJC/AbrDIrKYiJdopD9njqRXRN7Z2LhL2Hg0KcdBQzri1YoVtzFwXWi
	 8DCma74y4ZeIP449t4TZOeQoiBxdyAPqo+T6u8VL4RBJIu0JIc+ynoqRyoypxCKW6D
	 yA0LZ42ua/A8dobUeN+/SZmwinj/3g09b23+2dzamSnmPcRJaRuBi3EJW3vhfXmqgo
	 CwCiWLhtQpp609mmOvIpXTX2fe1GRDz8ka8KOr/qGXgsqHRpkma033dEYa3HNos9yr
	 wriyxGMS2iXhXabAJfMHgJDBbh5UWWlgujHPfW66bYwYgB7tXlXNgzrt8N7BADFzCs
	 DYJk3cqZdbeVA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BJDLRPU01689004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 21:21:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 19 Dec 2025 21:21:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 19 Dec 2025 21:21:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next v2 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
Thread-Topic: [PATCH rtw-next v2 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
Thread-Index: AQHcb+iZQ2DZGki3TUiI+XZVt7MS8rUoRPiAgACu74o=
Date: Fri, 19 Dec 2025 13:21:27 +0000
Message-ID: <7482605222b747afbf9658170cc29b6b@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
 <20251218063117.26278-11-pkshih@realtek.com>,<fd0e0d09-e220-4465-a80a-b26974602fa9@gmail.com>
In-Reply-To: <fd0e0d09-e220-4465-a80a-b26974602fa9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>=20
> On 18/12/2025 08:31, Ping-Ke Shih wrote:
> > XTAL SI is an indirect serial interface to access registers in another
> > hardware domain. When BT driver initializes UART interface, firmware mi=
ght
> > rarely control XTAL SI at the same time causing access racing.
> >
> > Current is to adjust initialization flow to avoid the racing. To make
> > the racing visible if it still presents, add a message to address this.
> >
> > USB adapters might be unplugged suddenly, causing flooding messages. Ch=
eck
> > RTW89_FLAG_UNPLUGGED flag to avoid them.
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > v2: handle USB being unplugged case to avoid warnings.
> > ---
> >  drivers/net/wireless/realtek/rtw89/mac.c    | 31 +++++++++++++++++++--
> >  drivers/net/wireless/realtek/rtw89/mac_be.c | 13 ++++++++-
> >  2 files changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wir=
eless/realtek/rtw89/mac.c
> > index e5f2fa3b2b37..8987077bf756 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac.c
> > +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> > @@ -1483,6 +1483,15 @@ static void rtw89_mac_power_switch_boot_mode(str=
uct rtw89_dev *rtwdev)
> >       rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
> >  }
> >
> > +static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwd=
ev)
> > +{
> > +     /*
> > +      * Avoid accessing IO for unplugged power-off to prevent warnings=
,
> > +      * especially XTAL SI.
> > +      */
> > +     return 0;
> > +}
> > +
> >  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
> >  {
> >       const struct rtw89_mac_gen_def *mac =3D rtwdev->chip->mac_def;
> > @@ -1497,8 +1506,13 @@ static int rtw89_mac_power_switch(struct rtw89_d=
ev *rtwdev, bool on)
> >               cfg_seq =3D chip->pwr_on_seq;
> >               cfg_func =3D chip->ops->pwr_on_func;
> >       } else {
> > -             cfg_seq =3D chip->pwr_off_seq;
> > -             cfg_func =3D chip->ops->pwr_off_func;
> > +             if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags)) {
> > +                     cfg_seq =3D NULL;
>=20
> I just realised, this NULL will be dereferenced in rtw89_mac_pwr_seq().=20

Did you mean this statement?
   ret =3D cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq)=
;

In this case cfg_func is rtw89_mac_pwr_off_func_for_unplugged (not NULL),
so not possible to run rtw89_mac_pwr_seq(), no?

  =20
>=20
> > +                     cfg_func =3D rtw89_mac_pwr_off_func_for_unplugged=
;
> > +             } else {
> > +                     cfg_seq =3D chip->pwr_off_seq;
> > +                     cfg_func =3D chip->ops->pwr_off_func;
> > +             }
> >       }
> >
> >       if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))

