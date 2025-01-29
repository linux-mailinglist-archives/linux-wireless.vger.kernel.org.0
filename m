Return-Path: <linux-wireless+bounces-18099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8ADA21687
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 03:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0466E18840A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 02:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141C2D627;
	Wed, 29 Jan 2025 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ODE0y842"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BE2AE7C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738118634; cv=none; b=RQWlKwwQOBrPXcC5ky/xJC8VLVuUW+jNqJXG7yqotmOnUn6IaTbAPHyXLp5he08F8Yh/sE+mt8fQg/us/5/yEMNI3nU00JI+xbz80JeflePP07Wl5Cy9YcM9kuG5k3hM7KEilsNnKZbRoilr354HipB+/w3NJif6frljEiTyul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738118634; c=relaxed/simple;
	bh=iOly2gXTW3iN8g1p2jVvPXuitYO0A0ju0+rb5680Acg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lzK3fj/+uol8rPHGhWLzNcjp09KEj5cjbOAS0FD1l/GyKLodXUJYQs4NjnfURXvyl6GxIlScvE0aP6djtEpQsegG0fDee+UBWKdZKA7IF20mMuk77ycjVcG367V5aOEckRqqWrSar7blYyCfE3NlGjHVHxqUm5Wd7gwIMyJDFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ODE0y842; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50T2hipaF1283082, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738118624; bh=iOly2gXTW3iN8g1p2jVvPXuitYO0A0ju0+rb5680Acg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ODE0y8429Cfw80q0O4AZ7uP1T7E6UMpmlXtsMIev+Iy3zNxig31Z7PZuBnnJYNNOM
	 ABbHvTt403zlqvWaj25/WJKVllxcGNX9JJkw3vtfkytOcD7EWzrVGM9v3YY4fMWX3X
	 SA+EFrcBd8SsEUsq1HL5rW10AHHtGVMpQ+s14HrH9u4IqRsZFxBijMaaM1fcc0zxSG
	 kK+gIO9Bfh9F1m3cv5LMvNBk0IuhjxdO2U8WR8b2/zpQK815iyBWo+ZxD/1dvKBACl
	 O5TN29X0WntT/ahG22hMB1GzDaZwJmxmXFVdoymgYx1V+fTiSM0DXq/bnaLZ2KLLUB
	 L94jS+LWTeMVg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50T2hipaF1283082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 10:43:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 Jan 2025 10:43:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 Jan 2025 10:43:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Wed, 29 Jan 2025 10:43:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Thread-Topic: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
Thread-Index: AQHbcEWMDvUgah16k02kcTsE1TgourMqKWuBgACTdYCAAPJSlIAAOz8AgAEf/jU=
Date: Wed, 29 Jan 2025 02:43:44 +0000
Message-ID: <1f04331c713141c68e6892751611d01e@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
 <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
 <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>,<d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
In-Reply-To: <d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
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

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> On 28/01/2025 07:52, Ping-Ke Shih wrote:
> > Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> >> On 27/01/2025 08:36, Ping-Ke Shih wrote:
> >>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> >>>> The existing code is suitable for chips with up to 2 spatial streams=
.
> >>>> Inform the firmware about the rates it's allowed to use when
> >>>> transmitting 3 spatial streams.
> >>>>
> >>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> >>>> ---
> >>>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
> >>>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
> >>>>  2 files changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/w=
ireless/realtek/rtw88/fw.c
> >>>> index 02389b7c6876..0ca1b139110d 100644
> >>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> >>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> >>>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev,=
 struct rtw_sta_info *si,
> >>>>  {
> >>>>         u8 h2c_pkt[H2C_PKT_SIZE] =3D {0};
> >>>>         bool disable_pt =3D true;
> >>>> +       u32 mask_hi;
> >>>>
> >>>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
> >>>>
> >>>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev=
, struct rtw_sta_info *si,
> >>>>         si->init_ra_lv =3D 0;
> >>>>
> >>>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
> >>>> +
> >>>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
> >>>
> >>> Using `efuse->hw_cap.nss >=3D 3` would be consistent with latter patc=
h.
> >>>
> >>
> >> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
> >> I assume this is to keep the current draw under the 500 mA limit
> >> of USB 2.
> >>
> >> What about rtwdev->hal.rf_path_num >=3D 3 ? I don't remember why
> >> I didn't do that.
> >
> > I think `rtwdev->hal.rf_path_num >=3D 3` is suitable to initialize/conf=
igure
> > hardware registers, because no matter USB 2 or 3 mode should be the sam=
e.
> >
> > For this case (RA info), this is related to protocol, so I feel
> > `efuse->hw_cap.nss >=3D 3` is suitable, but I have not seen a patch to =
declare
> > supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI,
> > it gets abnormal rate to RTL8814AU in your test?
> >
>=20
> You didn't miss it, that will be in part 3. You can see the code here:
>=20
> https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca35c=
3d3217/rtw8814a.c#L82
>=20

I feel we should clearly define the meaning. What I thought for 8814AU are:
 - hal->rf_type: hardware capability. Should be RF_3T3R no matter USB 2 or =
3.
 - hal->antenna_tx: the antenna for current TX. Can be 2 antenna.
 - hal->antenna_rx: the antenna for current RX. Can be 2 antenna.
 - efuse->hw_cap.nss: read from efuse. So this will be 3SS for USB 2/3.
If you have better defnitiion, please share your ideas.=20

Also, I would want to point the mcs_map implemented in rtw_init_vht_cap().

	if (efuse->hw_cap.nss > 1) {
		highest =3D cpu_to_le16(780);
		mcs_map |=3D IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
	}

This can only support up to 2SS, and I'm not sure if 'efuse->hw_cap.nss' is
still sutiable for 8814AU.

>=20
> With RA_INFO_HI the first C2H_RA_RPT comes at the normal time,
> before the first CTRL-EVENT-SIGNAL-CHANGE:

So, how about sending RA_INFO_HI unconditionally for 8814AU
(just check chip ID as condition)?


