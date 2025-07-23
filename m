Return-Path: <linux-wireless+bounces-25940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A861B0F21B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6039E1897BAE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F41277CB8;
	Wed, 23 Jul 2025 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EGGI6vNj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751A1DE3C8
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273417; cv=none; b=o6dG0jnaBzQ4x2BNGbamlYw+Ko0a4YeUTX+hGeeTcvKib60hLSEH/7bz6/ezoOG1Fc0/wBkpRE5Kupzd9NPEaRkMDDrhF94GnrK2ZlV/VmN72zUgh7PmHWcjoXWC+hKRcmmhCVlyfP/C8p7VgAdeCgxNJxnbIrJQTalO0l/coXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273417; c=relaxed/simple;
	bh=OSn7CCDqmNEIXCqgX64kUx/vS9VlMBwGkkbM9VJIZ58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxDSYJH76NvBVa42dyOPT7AHMDzbFn1Pp9P0YKDTvoaVWZyM9FP4hxZeD5S2noAt+dkPaRTmrDQ0OsWAO0ZM/PArvLFDfPcRE6sXsz3goZqISc+0ToCTsfoSH/vHdckcgdqvp08ReMTnl8Zhb3eEuOL6BvGUrH5EjYCCEW2Cbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EGGI6vNj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56NCNPhU42921669, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753273406; bh=dY4iV6V3Gq3i6BM73GAekg2kBXWqy2bZNSyMDwdkNC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EGGI6vNjfrCtC9PjOPBOqc6lkUX3Ict8hK/gvJTKDPrthvxAXxEruMmZd3TW8cUF6
	 BOh7Ir6yt4g9pp5a7Smw4SGAEmwDKajA5FRYI3b4UQMggRhT0+AC+4qmIx3lGiptNg
	 t/6vvtSaBgbZDgWmTYwAkis3B4CF8BoIvajJFrp72c+M5uBrmo8vVQXHTZqPnoDCnr
	 EwXBYXpgCb/DsOKQ2MDQsTeTWZpdIlqo71r1kyy5mT1dX2SUfzwpvTRQM3n2/myrV+
	 8xRfzVbLwexyNyS56bgApXXA3kdrnVWdc8TZJtSJNxwIPzeS+a5DJzdMJlvAM09WTw
	 Nf536yOkUhXzA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56NCNPhU42921669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 20:23:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 20:23:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Jul 2025 20:23:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 23 Jul 2025 20:23:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Piotr Oniszczuk
	<piotr.oniszczuk@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: Re: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oP//fpUAgACIU6D//4PSAAAQ6kAg//+iJYCAAJdrXA==
Date: Wed, 23 Jul 2025 12:23:23 +0000
Message-ID: <5933c3ef71914cdf83687042488800d2@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>,<7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
In-Reply-To: <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>=20
> On 23/07/2025 12:07, Ping-Ke Shih wrote:
> > Piotr Oniszczuk <piotr.oniszczuk@gmail.com> wrote:
> >>> Wiadomo=B6=E6 napisana przez Ping-Ke Shih <pkshih@realtek.com> w dniu=
 23 lip 2025, o godz. 10:19:
> >>>
> >>> working state:
> >>>=A0=A0 rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=3D0x493d=
30ea
> >>> non-working state:
> >>>=A0=A0 rtw88: rtw_chip_parameter_setup:1859 hal->chip_version=3D0x3030=
30ea
> >>>
> >>> I'd try to read more times to see if it can become correct...
> >>> Also, I force to use correct value at the last iteration to see if it
> >>> can work even incorrect value of register 0xF0.
> >>>
> >>> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/=
wireless/realtek/rtw88/main.c
> >>> index fa0ed39cb199..137418d1108d 100644
> >>> --- a/drivers/net/wireless/realtek/rtw88/main.c
> >>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> >>> @@ -1858,9 +1861,14 @@ static int rtw_chip_parameter_setup(struct rtw=
_dev *rtwdev)
> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> >>>=A0=A0=A0=A0=A0=A0=A0 }
> >>>
> >>> -=A0=A0=A0=A0=A0=A0 hal->chip_version =3D rtw_read32(rtwdev, REG_SYS_=
CFG1);
> >>> +=A0=A0=A0=A0=A0=A0 for (int i =3D 0; i < 20; i++) {
> >>> +=A0=A0=A0=A0=A0=A0 hal->chip_version =3D i =3D=3D 19 ? 0x493d30ea : =
rtw_read32(rtwdev, REG_SYS_CFG1);
> >>>=A0=A0=A0=A0=A0=A0=A0 hal->cut_version =3D BIT_GET_CHIP_VER(hal->chip_=
version);
> >>>=A0=A0=A0=A0=A0=A0=A0 hal->mp_chip =3D (hal->chip_version & BIT_RTL_ID=
) ? 0 : 1;
> >>> +=A0=A0=A0=A0=A0=A0 printk("rtw88: %s:%d hal->chip_version=3D0x%x\n",
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __func__, __LINE__, hal->=
chip_version);
> >>> +=A0=A0=A0=A0=A0=A0 mdelay(100);
> >>> +=A0=A0=A0=A0=A0=A0 }
> >>>=A0=A0=A0=A0=A0=A0=A0 if (hal->chip_version & BIT_RF_TYPE_ID) {
> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hal->rf_type =3D RF_2T2R=
;
> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hal->rf_path_num =3D 2;
> >>>
> >>>
> >>
> >> well - with above patch all starts to work well :-)
> >> 10 boots, 10 working wifi with correct scans.
> >
> > Good.
> >
> >>
> >> demsg from working sys: https://termbin.com/bhs4
> >
> > Unfortunately, the log said:
> > first read:
> >=A0=A0 rtw88: rtw_chip_parameter_setup:1860 hal->chip_version=3D0x303030=
ea
> > 2nd~19th read:
> >=A0=A0 rtw88: rtw_chip_parameter_setup:1860 hal->chip_version=3D0x303030=
30
> >
> > Not sure if I can use this pattern to make a workaround. I think the be=
tter
> > way would be to use firmware report to fix this. I'll try to make a pat=
ch
> > and get back to you soon.
> >
> >
>=20
> Maybe there is a mistake in rtw_sdio_read32() ? It's pretty complicated.
> The equivalent function in the vendor driver is reg_r32_sdio_8822c().
> I think for reading REG_SYS_CFG1 in rtw_chip_parameter_setup() it needs
> to do the indirect read in the snippet below:
>=20
> u32
> reg_r32_sdio_8822c(struct halmac_adapter *adapter, u32 offset)
> {
> =A0=A0=A0=A0=A0=A0=A0 enum halmac_ret_status status =3D HALMAC_RET_SUCCES=
S;
> =A0=A0=A0=A0=A0=A0=A0 union {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __le32 dword;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 byte[4];
> =A0=A0=A0=A0=A0=A0=A0 } value32 =3D { 0x00000000 };
>=20
> =A0=A0=A0=A0=A0=A0=A0 if (((offset & 0xFFFF0000) =3D=3D 0) &&
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adapter->halmac_state.mac_pwr =3D=3D HA=
LMAC_MAC_POWER_OFF) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return r_indir_sdio_88xx(ad=
apter, offset, HALMAC_IO_DWORD);

Thanks for the hints. I think it's worth to try:

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wirele=
ss/realtek/rtw88/main.c
index fa0ed39cb199..5ea13c775796 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1861,6 +1861,8 @@ static int rtw_chip_parameter_setup(struct rtw_dev *r=
twdev)
        hal->chip_version =3D rtw_read32(rtwdev, REG_SYS_CFG1);
        hal->cut_version =3D BIT_GET_CHIP_VER(hal->chip_version);
        hal->mp_chip =3D (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
+       printk("rtw88: %s:%d hal->chip_version=3D0x%x\n",
+               __func__, __LINE__, hal->chip_version);
        if (hal->chip_version & BIT_RF_TYPE_ID) {
                hal->rf_type =3D RF_2T2R;
                hal->rf_path_num =3D 2;
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wirele=
ss/realtek/rtw88/sdio.c
index cc2d4fef3587..5c9e7c8cdd7e 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwd=
ev, u32 addr,
=20
 static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
 {
+       if (!rtw_sdio_is_bus_addr(addr) &&
+           !test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+               return false;
+
        return !rtw_sdio_is_sdio30_supported(rtwdev) ||
                rtw_sdio_is_bus_addr(addr);
 }


