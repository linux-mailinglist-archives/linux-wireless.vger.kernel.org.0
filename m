Return-Path: <linux-wireless+bounces-10883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F15946C00
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 05:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2231A1C20D3E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 03:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0C5695;
	Sun,  4 Aug 2024 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Dbde18dU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2076.outbound.protection.outlook.com [40.92.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2082F2E;
	Sun,  4 Aug 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722741062; cv=fail; b=lwmuBCHJM5mdidFQD+TbbM3BmWtFqLAuMDAno8m7SZpg7tnfPv0gKV+FBEW9HxHDvCBTQiSyOqD1s/V/+jdwgFc4asK/0A13PJTYBU/VjQIhnUtVm11n9MmW6TS0UyHHKPWLfJ7aOXeUNj+J46Y4qLUYP5BNEfgt9msny35axZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722741062; c=relaxed/simple;
	bh=mYgo6saABo34VkU3XXf1msqRbbjrfzXPqMSZqYz5zio=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KrepBJLCjLTRwnqsaz86CzQAkY7ws0NxmEpAy7LN8Mv5IrrYDyqcWzQPsXJ34p5Z6xpH/ePjaSQjpxFFa2qFD5Ss4jfpFkyCfy6WnRgowO+tHai94mmoe4nojTR3xGWWsxSFpNUuHKrzEraYzJAdEtZ8gYJG+Tnq0PMz7AD6LiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Dbde18dU; arc=fail smtp.client-ip=40.92.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLr6i77isItNIv+VuCf/shP1Sn6tTzsN0EJ/U69LNwJ95vSIxRXLMqFBCO6u1Z2A2zFAc5lRFYkus0gTMXwShn8/ZnKgCWwHvtyDNSXXMkH6GPr6VA8pxh5lLbWYz7/JVpedwmqJUqcp2k/0kUD6SJ5J6j6t0ECNOS+UYdFydjFw3qMA+RiFj+ernrgEDvivbSZDqqNJ+YH3rYjX7MGTb7UOQp3zwrXQansf86ZasGP5mFqYpq70ohabYTKLRY7ArsGlyOOEP6QgkkLgEtAtqz9BxBPjeu4sfm3zGmhiPTTvr+26SNoSnsc0VGLxqq1/W9dmEN+uwOtqehE1uEhEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl33C7wsnaRql3kEzN/jLfblxUCw1JaTx8ig6MBTUBI=;
 b=uwMGyzrKhxOCNMnaynmRxJEswSi6GvGkr4GjKntzsbZj06K+R6+r3Atghok16aib3I8vpaoyCio+L3DskniQi7yxYsz5YY0DhtrarxtTSqGs+shLvfbY6IrUTZmESskaZVK0wAOAPvWRHUN3YtvRNUFlb9IftEwrmODE5E8awpCxDuO7DzonCrecnqJXkfUlmi3zwi2bUDTAMq7tQMUiDHRLtu4xCE5qSedM2J9xm8/vtJ8EVa0cSsF64e9/eNpd6E61/Syyytgg1nWsdbhbmqywuVFfnlkiY38mgCntR2saWD9sg6yW3jinGHUcYu0cP/IyocbQaCcn8FmtCJcRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl33C7wsnaRql3kEzN/jLfblxUCw1JaTx8ig6MBTUBI=;
 b=Dbde18dUEh80t+n4PJmuW3w8Ka5nvWstAlF0x7CVu0cnupFqf0hBsMgnGJkgtENYzYUXXfGTAseBXUuXxX5z7JMqmyl4nM4KXHAreC2Zx/579jhrXiydGlEWJnsSWZ+fIm14zyNY9lnLoFpep7c0Iy2NmKM1n5armzil5hI9JW/yuo88QU8U8BkUe3+Ra0f3noBCxGMsqFttZLzt3/82BV8YWfg3HMBcd6oPLoAGgQ/a4yO2hnyYkBv+VP/YDTQS9u8BuHOBMLmnGArh5O9emnvnsG3M/sDgcepvWxTa/vqAsS43101m5YaE0M7MsjG/T+Sp2r6vTH8M7aRusOJR6A==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB1297.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:197::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Sun, 4 Aug 2024 03:10:50 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 03:10:50 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "devnull+j.jannau.net@kernel.org" <devnull+j.jannau.net@kernel.org>
CC: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, "j@jannau.net"
	<j@jannau.net>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"marcan@marcan.st" <marcan@marcan.st>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Topic: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Index: AQHa5hvoE5KcjEPn8km73NJrD5B72g==
Date: Sun, 4 Aug 2024 03:10:50 +0000
Message-ID:
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [mbGjsCejnMQ3Ff3ryllu0e0OaoI4wPwTRcdF6wrJ71+kjRaBPepN0RFdFRuGSXvs]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB1297:EE_
x-ms-office365-filtering-correlation-id: 9bf0893b-9917-4418-671b-08dcb4330b51
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K2PHowtbVet09kHtS3LQEhSbFHlpMC38uol+q/7Dlf19CFIMdCTJbKACl9Vff8KwfdkbXgWbTjX/qBeCqM/rY6L7AcLSG6cHONtWqFE5zsK4Vbp5glpd2ZqtPCmv1c97XQBBRiEN8ikOEYm+lmvLr9lpdez1rrE+LrW8et7ECqmmF5kaxyDDuTOOarVIsmXlDJ9BYxK6ViSwRJpr73OXuJyllbv8CwEaWvwXxh03si0wl6XOudhSbFIrX9lCkvFqJqH8j8LnmhSglLWxFtUIl3QXy3NFdYi5Jg9cgpNLdKU6khyPPw1/0ZcrYqhwKTVVTJ5oPBmneS1aDdKZrHe5pg+QhWrMq7Zzrv4wzCUDK9S0NCt8m6dQJoqa5nhLSfKkECKqQd516P0fOzaZdnK0zhMXcibbZslzYtCEKa7cXS6soVFmCryn3jSiwwVZykIh3cEhxw16sI382sgWE44GxSKSPykk1OyW+VsI+9lMMh878g/6GBAItI/CZUzI3t5UwpKOTQKPuo/ac4ZnssBIlQlHLwcBVpXeAejypK3zeHoEbKWs/+QaT4FQnfe7/kwG858YjJNeRmZts4FiOz+9zeJ5Z6sbpiziqbyEjzWtd5z4/LZVNJx/0301iBoBtscK/juOiywfYhv4T7TMkNuDk6AwRaAKV24xekI+qkX10tqhpr/j+OoRcBsciWjA0idBetpzv9+YUx4xCjug0fh6fjCSjnsG+KJb663hXMN0eQh3uUUHpXt+KoY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028|102099032|4295299021;
x-microsoft-antispam-message-info:
 x4MKfWgG0RC1zgL0OUe3Nj9Szew+UA0mdoqa3F7y/YlNCv/T3rqKvdsVo8Vu3oePi0cFwwdyDeI8L0wwJA0v4Ke7tmta8LLw2z/LW3XZ1GX0IJRmYyGjbJ3Nkt9GIJkTieDvucAEn2wQv4kOzTDkhrDGQ5B5RS9PlVgpNkncz9FZ/Yg2r0BpuWVZ/I4mQe1af4UfpHE6ktX1bExNEXobjsvjzw89gaVqHtHLKD+3ZA8AZNLB0AibxxVaSL0WdkHi673Nn49YO945eK7AWec/mkv64aD1Oohr17EsP5Q91eIGVvIILD51KvgeO8qLhwVBJYL6a4oMdQNJQfn5XP6UkzmxY5CKNcNR/oUvzUYijR/bXwao0jd9vrIz9ZlnzMQ8ne+pu9jD6lblW1JufnBM/A3gPMQNFhmYxE9B6U157AF0sH2YS2zSC5UnXmI2Yybcdlgj8AhBgFrxNrMxABjHY9OxF0BiXVoe4ChORv29bMkQOAwkVtsBxqzRgRnFx2QwSSkmgo7q4RCpMM+xehcg41VmfDIvEVfDBVf3rcoEDW6F45f1n0IeAKQY+oQoaT1z5vnKLlOtGkd039dmz8ikNmPfyYy6yqjtLyylGDtzwkSbj0FWEs+p6bgwbMzPRN0HecUMeGwi2t/Ah1M2UaZ5uQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CdimpKtsySzIUg7rTw7MGOoPbDtlxocbU7K48x4R2+xrJiR+IFehyp7jCEF0?=
 =?us-ascii?Q?Py0RY5jIaIIxOI6fIDNEfLHpDxhny62BcoriD7gsHpUsZ/IASyn/sKcr1WxF?=
 =?us-ascii?Q?9481q88qjfCcD9xNaQyO9lagIFD3v6pFJoV8g4XX3cT6ad/S1Zt+rzWd9LxI?=
 =?us-ascii?Q?vxVkNm3iYN4I45DKhBe89jju3pupCJXRr6HI3o9Jr3AzZX3A4pfqWy6KtMVP?=
 =?us-ascii?Q?DCnmV5jS+soiJYA7zRjTpJnHCv/A1aTocqU3cejxx0fhyXn0w2TKsu/J2HNI?=
 =?us-ascii?Q?i4pdPwgtYYCz6azQFw7ShOMSwr5NYMnfk5g+Q7hR+6I+nmIorWSsfCjj5Wl0?=
 =?us-ascii?Q?GgyQCKx/q8M3jrOOuHWOJ6rXsfdqVo5vu795pwaVf3PHmFWh/SwVku7WvPsb?=
 =?us-ascii?Q?WFUh+215BYkG2eo+R57VuUGjRcbESlqMXfmsQwtAvkf3pUBs/hNDcwLi29hR?=
 =?us-ascii?Q?3h3Bht+2+NsoYFEfloNifAPWR46kHl73dK4ULMyx2iAOgG+h+0Z7+o3JL8ue?=
 =?us-ascii?Q?REdOVyrF/A1/AboaHB03t7y9tIDIalgTigNsNKWypYQlhdTa+c3y4K+v1pLl?=
 =?us-ascii?Q?eOK9Zwc0aEE8A9/tR5CRZaUiaO6zFGRYSNvstlAWdGFwNJqlniPzI7FxUh7j?=
 =?us-ascii?Q?IvjjDEKb0mFRccQmtnQ6Rui4/y6oimyqDrvYvrP8GB/5/4ZxPnXbqeBwayE8?=
 =?us-ascii?Q?AxEAZM8bnkGGY1wtjtxZlubobaM4WTJqfOXA7YqwiJ/uidAv4U2zzOEZVRfY?=
 =?us-ascii?Q?ZfuoybhweLhZssm4HpsRKIuHtFi0ZWGOkSmJYdgiJ/tDj7vxiX2XqCMts0dt?=
 =?us-ascii?Q?UAPWd6+OVcyONoYU4svWaNrzw3mUl5gGA2hiYoia8Q3N9vt8z8BnG7xed53V?=
 =?us-ascii?Q?59U1J53hURn3Ot2ZNYNxFTTKb9QIw7zYXusogUJh+Oz9dBmkS4iGrZ2+6DiM?=
 =?us-ascii?Q?mIaLp+1PbN9wedNmAeosqtY6awWACYokKzOr8viksOKqQtebCEkap6tVMGCw?=
 =?us-ascii?Q?Jy0s8VUKhkOPeau00+srbTo+y+lkSoHFsry82+y+C5GK0r4StIM2W3b7+/js?=
 =?us-ascii?Q?kvjOsFiroKxuIqRtdTKZrVamodwxZfMpBRm5QhEujnRndWeWJ32rKtNtHTiZ?=
 =?us-ascii?Q?E/7i3QPidmrM7Hg3m7tQje7nEATEr9ei0dUgeLSEPPx5AdczEslOvSwgJ1P0?=
 =?us-ascii?Q?2e1vMq9qzUPxao/o1EPs0UaFWHU+dH9YXvSRlmPo9VRnI/6rt7c5GZZ0HbX5?=
 =?us-ascii?Q?iJZPTtRSzcJdNVdvedHY+vllrW1CX+oOsNrZR2EhxptQJna/nR5ZFec3iboV?=
 =?us-ascii?Q?Y2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <47CC545F4DEA2C48A4044D305DA0F1AA@sct-15-20-7719-20-msonline-outlook-24072.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-24072.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf0893b-9917-4418-671b-08dcb4330b51
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 03:10:50.5825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1297

Hi

wpa_supplicant 2.11 broke Wi-Fi on T2 Macs as well, but this patch doesn't =
seem to be fixing Wi-Fi. Instead, it's breaking it even on older 2.10 wpa_s=
upplicant. Tested by a user on bcm4364b2 wifi chip with a WPA2-PSK [AES] ne=
twork. dmesg output:

However dmesg outputs more info=20

[    5.852978] usbcore: registered new interface driver brcmfmac
[    5.853114] brcmfmac 0000:01:00.0: enabling device (0000 -> 0002)
[    5.992212] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4364b2-=
pcie for chip BCM4364/3
[    5.993923] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfma=
c4364b2-pcie.apple,maui-HRPN-u-7.5-X0.bin failed with error -2
[    5.993968] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfma=
c4364b2-pcie.apple,maui-HRPN-u-7.5.bin failed with error -2
[    5.994004] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfma=
c4364b2-pcie.apple,maui-HRPN-u.bin failed with error -2
[    5.994041] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfma=
c4364b2-pcie.apple,maui-HRPN.bin failed with error -2
[    5.994076] brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfma=
c4364b2-pcie.apple,maui-X0.bin failed with error -2
[    6.162830] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
[    6.796637] brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, load=
ing
[    6.798396] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/3 wl0: Ju=
l 10 2023 12:30:19 version 9.30.503.0.32.5.92 FWID 01-88a8883
[    6.885876] brcmfmac 0000:01:00.0 wlp1s0: renamed from wlan0
[    8.195243] ieee80211 phy0: brcmf_p2p_set_firmware: failed to update dev=
ice address ret -52
[    8.196584] ieee80211 phy0: brcmf_p2p_create_p2pdev: set p2p_disc error
[    8.196588] ieee80211 phy0: brcmf_cfg80211_add_iface: add iface p2p-dev-=
wlp1s0 type 10 failed: err=3D-52=

