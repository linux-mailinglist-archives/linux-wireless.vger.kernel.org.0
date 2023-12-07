Return-Path: <linux-wireless+bounces-531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70478084D5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA78B2169E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836E3309C;
	Thu,  7 Dec 2023 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="cGgCszqc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D1C9
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701941938; x=1702546738; i=zerobeat@gmx.de;
	bh=UhcMnQsy5nJFQQC+OSXK7fwnJ8FloHzWUwtBedaf7b4=;
	h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:
	 In-Reply-To;
	b=cGgCszqcpTQBWOyu48ztZrFlFD0LHtrx+sEgTc41sNlv2F8BBvYbwr9pjrHbnBNa
	 Mg09y0d0JDB1BvE8x8xDqSnTohFLp53l75Oz9R23yjB05J4i8gQrpu87HSyLeERq+
	 i6Brv1/0etAOOHX0P6Kr3L3/eueB73F7eiKg52fFfC4P0fQS6C9DgqlJrW9egGRJT
	 kzw8B7ZjiSAV1D2xAxp69dDhlSZ3j2HqpeKIdCg0HGXCxmm/+xquFR0lWWURWZdGi
	 IqHFcPtPbjcLglVAEVVOl2x4JVmumLKkUs+lKX453dib+4zoW8yorqNhLZNLEB9+r
	 GR4Tc8Piux6t4UkPmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.252.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1rcZZG2IA0-00jLTk; Thu, 07
 Dec 2023 10:38:58 +0100
Message-ID: <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
Date: Thu, 7 Dec 2023 10:38:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
In-Reply-To: <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:754EDbtLouSePzN+4aDlzLCbqw0NR763/Nrm/5LAu2Rm32w1ger
 v52sAKfcV/1g28rLH/9vjrC3wPTloNNTO7wvz8p4kIlqqGlkuu4cJyFTNKKbZL6ukJYm7tm
 awdyuIMKI+Ep5c89tOR4ZMc2SjGX5eKdR43Zue449ElaQo6q5NNijpNrEmYc3MdATfxu7N6
 OIjD8dXqOaVBR1v/Mnm8Q==
UI-OutboundReport: notjunk:1;M01:P0:Lg6PIcTLp+g=;GwCtzRXQq8PVrgHJbjvNdtbVCKz
 ItNfyCLSZ48pGRUKrsdzM+lTfOXJIUHHh02YPiXAgV1YDMm6dAY34+6UIiAtfK4To8usgyyr1
 iAKKpvQi6TrvyozYIEZwns3KFQlsrnDFu9baM7t6zhN+GpDl1C0m9qNuTwAM3FdX0joPRhhz3
 rdQ2Q9RkdQ5SDMFBpzDCVPIK6H5OZHuARimENdOO7GwHmky2ZfU2Yjfgf86QjZvPBNHVl6GK+
 dGP93XvA1oVEH43nfTmNDoAjMlTR7IBNwkcdhA7WZaLYMixj98nb40qe+Ag5/pH6B7fMpD9Ka
 OQ/2KQC92pSmR3XMtYfcH2e02O/2xHNfukpAd4sh85hA5S4/5clIG9YVJQuPuT1yMHBdYQeJj
 5J4pZ2TXQ90o9TPTzHulZSevv56nEkBS0WbLGK7bEc1oGBeOriInUB+tA8AGocoGqjqU7mO5P
 6iH/FqNxLIOZiegtKeT7rzemXJhG0Qg1DIsdBfpmMIKQ0gG7Z1QLfF2eHNQUMtLhFtJtJXgMu
 X6X1ZgNDIIEF1f1QUT4zwdz3d/R8DfYcjh22kEPMS2BZkqhDeO2vfUI5J/cTq0mrH+ifciNtt
 GCd1Lsd4M+MTXsgCMW0yadoGnYAki4NFtt7CL6Ct/QBbgimIIse2Bd0US2q8ZPnwUmuguf9ro
 QhOTlYWCNIzDqQGMx1Tnev8JvafBGdr0vhi82K+cLzL0uyJSvXWYYlJsghGDnZvg4/XVXoc5P
 /tVOHaJKTCgl3Pfty3QE2n3IgJZBRSUofx+QEXvQU1jJPilOyYfEAJI3iMbPmQNk+WvVAP305
 ScK96TzaHj242DJgrbUqwR4XvvC2w/TJSXi16BsiVeLa0lm7KBegtk1vOAGDWfovjJdtsCW0V
 4rdMlKvGeWDliHMBpWTiUjb2socfIV2HKN7kfDeNxFXZjxkECQPSAsCgmO3uaiL6+9amagLmj
 9Bjwm5+7bvx23KpA3guaHfmwYZk=

Is this correct to commit inline patches?
Looks for me similar to this one
https://lore.kernel.org/linux-wireless/20231127162022.518834-2-kvalo@kerne=
l.org/T/#u



subject: [RFC PATCH] wifi: rtl8xxxu: Add new device ID

This patch will add a new device ID (2357:0126)
Patch will close: https://bugzilla.kernel.org/show_bug.cgi?id=3D218231


TP-Link TL-WN8200ND(UN) v3.0
ID 2357:0126 TP-Link 802.11n NIC
https://www.tp-link.com/de/home-networking/adapter/tl-wn8200nd/
Sold in Germany.

tested:
[  855.204083] usb 1-9.3: New USB device found, idVendor=3D2357, idProduct=
=3D0126, bcdDevice=3D 2.00
[  855.204091] usb 1-9.3: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D3
[  855.204094] usb 1-9.3: Product: 802.11n NIC
[  855.204096] usb 1-9.3: Manufacturer: Realtek
[  855.204097] usb 1-9.3: SerialNumber: 5091E3C3A09F
[  855.242127] usb 1-9.3: This Realtek USB WiFi dongle (0x2357:0x0126) is =
untested!
[  855.242134] usb 1-9.3: Please report results to Jes.Sorensen@gmail.com
[  859.592016] usb 1-9.3: Dumping efuse for RTL8192EU (0x200 bytes):
[  859.592024] 00000000: 29 81 00 7c 01 40 03 00 70 34 04 50 14 00 00 00  =
)..|.@..p4.P....
[  859.592027] 00000010: 20 20 20 21 21 21 28 28 28 28 28 f0 00 ef ff ff  =
   !!!(((((.....
[  859.592028] 00000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592030] 00000030: ff ff ff ff ff ff ff ff ff ff 2d 2d 2d 2d 2d 2d  =
..........------
[  859.592031] 00000040: 2d 2d 2d 2d 2d f0 ef ef ff ff ff ff ff ff ff ff  =
=2D----...........
[  859.592032] 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592034] 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592035] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592036] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592038] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592039] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592040] 000000b0: ff ff ff ff ff ff ff ff a1 1f 1a 00 00 00 ff ff  =
................
[  859.592041] 000000c0: ff 01 00 10 00 00 00 ff 00 00 31 ff ff ff ff ff  =
..........1.....
[  859.592043] 000000d0: 57 23 26 01 e6 47 02 50 91 e3 c3 a0 9f 09 03 52  =
W#&..G.P.......R
[  859.592044] 000000e0: 65 61 6c 74 65 6b 0d 03 38 30 32 2e 31 31 6e 20  =
ealtek..802.11n
[  859.592046] 000000f0: 4e 49 43 00 ff ff ff ff ff ff ff ff ff ff ff ff  =
NIC.............
[  859.592047] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592048] 00000110: ff ff ff ff ff ff ff 0d 03 00 05 00 30 00 00 00  =
............0...
[  859.592050] 00000120: 00 93 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592051] 00000130: f6 a8 98 2d 03 92 98 00 fc 8c 00 11 9b 44 02 0a  =
...-.........D..
[  859.592052] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592053] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592055] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592056] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592057] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592059] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592060] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592061] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592062] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592064] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592065] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592066] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  =
................
[  859.592068] usb 1-9.3: RTL8192EU rev B (SMIC) romver 0, 2T2R, TX queues=
 3, WiFi=3D1, BT=3D0, GPS=3D0, HI PA=3D0
[  859.592072] usb 1-9.3: RTL8192EU MAC: 50:91:e3:c3:a0:9f
[  859.592074] usb 1-9.3: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic=
.bin
[  859.600070] usb 1-9.3: Firmware revision 35.7 (signature 0x92e1)
[  868.683025] rtl8xxxu 1-9.3:1.0 wlp22s0f0u9u3: renamed from wlan0


$ iw dev
phy#1
	Interface wlp22s0f0u9u3
		ifindex 4
		wdev 0x100000001
		addr 50:91:e3:c3:a0:9f
		type managed
		txpower 20.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
$



diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drive=
rs/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..47b5e6d20e54 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7957,6 +7957,8 @@ static const struct usb_device_id dev_table[] =3D {
  /* found in rtl8192eu vendor driver */
  {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0107, 0xff, 0xff, 0xff),
         .driver_info =3D (unsigned long)&rtl8192eu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+       .driver_info =3D (unsigned long)&rtl8192eu_fops},
  {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab33, 0xff, 0xff, 0xff),
         .driver_info =3D (unsigned long)&rtl8192eu_fops},
  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff=
, 0xff),

Signed-off-by: Michael Dieckmann <zerobeat@gmx.de>
=2D--
  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 ++





Am 07.12.23 um 09:52 schrieb Ping-Ke Shih:
>
>> -----Original Message-----
>> From: ZeroBeat <ZeroBeat@gmx.de>
>> Sent: Thursday, December 7, 2023 4:46 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org; Jes.Sorensen@gmail.com
>> Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
>>
>> Better now?
>>
>
> Your patch isn't much like others. Please check patches [1] made by othe=
rs.
>
> [1] https://lore.kernel.org/linux-wireless/
>
>

