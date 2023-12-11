Return-Path: <linux-wireless+bounces-610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0214780BE97
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA9C280A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A215A2;
	Mon, 11 Dec 2023 00:53:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C0EB
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 16:53:44 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB0rG3L12277666, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB0rG3L12277666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 08:53:16 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 08:53:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 11 Dec 2023 08:53:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 11 Dec 2023 08:53:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chris Morgan <macromorgan@hotmail.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>
CC: Chris Morgan <macroalpha82@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
Thread-Topic: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
Thread-Index: AQHaKehQK1uqTNLbjkO8z9YWXMxWYLCfCgQAgABHzgCAA/KewA==
Date: Mon, 11 Dec 2023 00:53:16 +0000
Message-ID: <3b82cf39c388484aa43cd9c9b762bc42@realtek.com>
References: <20231208150739.129753-1-macroalpha82@gmail.com>
 <c06e862c-e5b7-4459-aaed-4f69c3881b84@lwfinger.net>
 <SN6PR06MB534274E463B81EE0331294C0A58AA@SN6PR06MB5342.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB534274E463B81EE0331294C0A58AA@SN6PR06MB5342.namprd06.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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



> -----Original Message-----
> From: Chris Morgan <macromorgan@hotmail.com>
> Sent: Saturday, December 9, 2023 4:34 AM
> To: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Chris Morgan <macroalpha82@gmail.com>; linux-wireless@vger.kernel.org=
; kvalo@kernel.org; Ping-Ke Shih
> <pkshih@realtek.com>
> Subject: Re: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
>=20
>=20
> On Fri, Dec 08, 2023 at 10:17:00AM -0600, Larry Finger wrote:
> > On 12/8/23 09:07, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > When the MAC address read from the efuse data is invalid, warn the
> > > user and use a random MAC address instead.
> > >
> > > On a device I am currently using (Anbernic RG-ARC) with a rtw8821cs
> > > the efuse appears to be incompletely/improperly programmed. The MAC
> > > address reads as ff:ff:ff:ff:ff:ff. When networkmanager attempts to
> > > initiate a connection (and I haven't hard-coded a MAC address or
> > > set it to random) it fails to establish a connection.
> > >
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > >   drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/=
wireless/realtek/rtw88/main.c
> > > index 4a33d2e47f33..6d22628129d0 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > > @@ -2008,6 +2008,11 @@ static int rtw_chip_efuse_info_setup(struct rt=
w_dev *rtwdev)
> > >     efuse->ext_pa_5g =3D efuse->pa_type_5g & BIT(0) ? 1 : 0;
> > >     efuse->ext_lna_2g =3D efuse->lna_type_5g & BIT(3) ? 1 : 0;
> > > +   if (!is_valid_ether_addr(efuse->addr)) {
> > > +           eth_random_addr(efuse->addr);
> > > +           dev_warn(rtwdev->dev, "efuse MAC invalid, using random\n"=
);
> > > +   }
> > > +
> > >   out_disable:
> > >     rtw_chip_efuse_disable(rtwdev);
> >
> > Reviewed by Larry Finger <Larry.Finger@lwfinger.net>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch looks good to me. At least, it can have a valid MAC address.=20


> >
> > Thanks for this patch.
> >
> > There are a number of SDIO devices known to me with improperly coded EF=
USE
> > values. It seems that RTW8723DS chips perform poorly even when given a =
valid
> > MAC address. Is this also true for RTW8821CS chips?
>=20
> The RTW8821CS I have in this specific case doesn't perform all that
> well, but it also has sub-optimal antennas. I'm not noticing any major
> performance difference between the devices with a valid MAC address
> and the device I have without one. They're both pulling about 8MB/s
> over scp on a 5GHz 802.11ac(ax wifi gateway) network.
>=20

It seems like we still need to have a set of _default_ efuse values.



