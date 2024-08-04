Return-Path: <linux-wireless+bounces-10886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B5946CB3
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24FB1C20D3E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48857EEA6;
	Sun,  4 Aug 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qxhQZehK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2108.outbound.protection.outlook.com [40.92.102.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73BD51A;
	Sun,  4 Aug 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752826; cv=fail; b=ku1fGoqAo30AMhiGWE8eNw6VJPgE6WVMv7AdI1MsN32HHy/pp2WZDY9Mq3hkTKUlLSytIJuk9xR4mRQojSBLSU6tNthVSDjQMYZSw7B667b+vBNN+dkgg/iRL3DlXiB1wrUYU3sMsj0IQ0DowoDpJ02hTnlYL3i3Arj7lSDrQH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752826; c=relaxed/simple;
	bh=omM8dcH5DfqJ72azPRFi1U/Dv0A1ieGkIEXJw6GoPdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIC7LNDNbrSEt7+qEGWjBsMPm5kSkL8qwnhoIecyehwy1llbLE400T4ptCcXDqukkYGXmLgv6iXzKPkFWs2tnO9iWb6HwnaSp9IK1sByvJUgLgiKP0+zVZE9CGRHoHm0bg+QVmD+h34ZlNMbsSJqEO4/wbgCOul8AEcOB8nxHvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qxhQZehK; arc=fail smtp.client-ip=40.92.102.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egLyRLGAO+QGc1RepAixlMr3xGwJ8yPi5sUOcrYOhCKufBR4migZsTPawI8jyYO7eKJ2wiN1C6MitybjA6qanVnoBUVDFxjFx6tr8+GckyNDhUeUdpvtWv5DqqJYs2rmUo7+S2PAt5y+OxJ1u9iGLs4L81srTcmiiTiMXvdr+zC5sSkJkZx0yfvIiiBtM80IBcdb3OAORvIg5/IXDw3YvGofTBJKoFmDIhoVBQ1Yf1HG4SCJQy9vIL0LWHgxGmwDAR5g54rqD2nqvGFomhpOuNfp501VFaLOmy7J4D+IqTtK8K5n1rCqBjgJ/SPjCR+OJ1JYeMCARm5OOkXyo/xYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omM8dcH5DfqJ72azPRFi1U/Dv0A1ieGkIEXJw6GoPdw=;
 b=ueaGfaZb7xXT6Zgwj7vqGmhllPenhyq/oxz1VD4sGohDwmUHhFN5R+CXDSAGVoWJw72jXyCn6kOTMXPpHkN+h48uX3kx/Z2xe408PFZ1QQ+4SGkXgofaUr8GYtcxxMl5xcmidnKjOTnk5CgeC2s6VBx4joxy4ypyNRukXehHPvdF75rdWg4A28oXSb5/ejYPCs41XTRZjtFOaEyXAyek1zhMfb5Kze9CwZDGXp4xfFhisMOOXrNaEvj/E4By1WmzlUg2jFK7OIaX1Dnopa9uVSKfsOJ0X1CFwvv9bI1+5B4vUSBRQJy3IsoyJL1QLCSHvNLW0O7rVf8PmUh2bcYDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omM8dcH5DfqJ72azPRFi1U/Dv0A1ieGkIEXJw6GoPdw=;
 b=qxhQZehKyOuupLngr8rB+rbwUDSAQqwsra+E8D4hhR9dTlqoJDyAMvtZZlVFmBWXYJ5vCAjtoOXJhrk9hqhPRejWtxntzsMcXdbtVClxLN9aPsUfcB7qTl1J/bJDz7M0MqT2vYowdHAU/3o0QZ9HaV+w433A5m5VhGmeZ4ztlZAg2/xfdhtiZ9eCjMykbZZoHfaCsMzgjfapfq/yV43xAhGo49Cz6KqEeEC0WUhFGgA8YYW8u7d/GLsXLCnxY2H8vsuucrDEfI5JnpCsxWQAU7iWScWJXRYujRwBIYpyGkNBNpmZjHNethtUbUHDu+M+BPbAgdgPVytFZ0emtmEMsA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0092.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Sun, 4 Aug 2024 06:26:54 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:26:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Janne Grunau <j@jannau.net>, "devnull+j.jannau.net@kernel.org"
	<devnull+j.jannau.net@kernel.org>
CC: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Hector Martin <marcan@marcan.st>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Topic: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Index: AQHa5hvoE5KcjEPn8km73NJrD5B72rIWoF0AgAAB5OU=
Date: Sun, 4 Aug 2024 06:26:54 +0000
Message-ID:
 <MA0P287MB021725DE596EF4E5294FA5DDB8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
In-Reply-To: <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [BObjNcPjFNGV3vDq9DYmLhaJS2ldXTHbkInZvheq5vhB1cGPOxxME6diqAEQ3u+V]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0092:EE_
x-ms-office365-filtering-correlation-id: c159bec8-1bc3-4130-e3fc-08dcb44e6f08
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15030799003|19110799003|3412199025|4302099013|440099028|102099032|1602099012;
x-microsoft-antispam-message-info:
 zxzEktgmK6OGUQOi4YMKkuqPbfnTw4r4SERGvePrtS+sDHBkRR6CreyHJJFKxGCs8i+N+rLTw9S8F7wbi/Q94pqS4Ju7L9XKCUeNK2YmF7POWmQ+8t4NzMwd5jI6ojj2w7193W/z587xoJeG2HvptscHmdtPhGBeaArTendEHq8h65+TDiaoIvZSKt7eajErCa2Y/hPALxsKAwN9JaCiHUvIM/O4jlGXkXogUSHn574aU4TagFzL5G4tYqAD1fOXb5BtSU62xcyy5LsH0RUP0UV/O96mYgHdrvZHgjLjf9707yh6JJqBNPbm1UHDSweFAu/bJdW8UPbw4Q3zxio3nteEftgGglIldCouI8qDw9SV/mhM/unDiHg83LiWgVNA/b6ZaWX7+kcPUjbViRafy0RCwy+daw0wYbC7bOnrkmxxx21AhgV4+J+ILFmQqZADk5vhgSTeLUlljuGosNMKgDQywkWlyZ0+zl0QoJF5dPzXM8qe8YLyfffVEe44ITmOLbmSmF8+q8hAwi5S5mm9MyUaA3eqxfdJc94i4XD8bPFoEXn/aljiXHIXaAIf8YoWqLswv/lr1s63tNhiU1OVbUPt83UXjVYGGvcS3pZZdiW2UIFlftxfiqNCHAxCbnZupXmXjeOkq+rwioqDkmHY2nOALqItKzRM2+FIPbWfDYCcPrS1conQgj7uEfuttG1He64dZxBFCDZs7OvAUhO8oHeofWW7wbaUY4t7SHO1FE7nYG5fADoa3DrLIx4pI7GRDEKbqZo0BFejV5n1l+DBQSSq4GZ967IuxDq4dN4nCWo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lsAukAk2KJUA2ouC3ndB1TT9VHYXMfOlXy+hxcBFJBjU/LdYMq9JjrKTkWu1?=
 =?us-ascii?Q?BGcSrAAyqqaaHYzehswui2eQhUAq3JRbWWk4xUrzdDN4aZSpVVp1BiP/0EdE?=
 =?us-ascii?Q?IGLsavKgU07CXBKy/2HxvvWevJjpVKlosCvY8NYcEfIXXvCk3GztoMUJ0Vmk?=
 =?us-ascii?Q?dFHpCgGDMpcdvIhGNcQiFmgrgMUM6ZAbhWlVGEK5QzTCwa2HvgTqyAgCPKQP?=
 =?us-ascii?Q?8meMoyV8u9llhWlNz8lDmxy0OR8dsUT/VKCUY08WSnWH7q/9RstzzxeVPMie?=
 =?us-ascii?Q?zgkV0NDvLIUEa2QXLk0dfXnE0ij/k2ySQitPj5N3lNFs53FqR/VlvuWthY0F?=
 =?us-ascii?Q?Ohg85bGSepqDZL96+GQqS+FjVRq0plJpA3V3yfgcLwUs0I3TsjAifSLKpik+?=
 =?us-ascii?Q?11iIajoxZMpKAqbyN9NDSR2hOermRszqK3gVaaK2hSTxjzkli17hPzKwKIah?=
 =?us-ascii?Q?kenJy4DsHTLYjIA5AVbAOwXsYPv3BmphetRCcaolkuclvE+ZvA1US7rQYYST?=
 =?us-ascii?Q?awelFLb5xKt2HBF4eeGgEICPq6asQ+NDJWcjEoGOwRv2IkO8AJBLUcYRcZuF?=
 =?us-ascii?Q?gXno6tDaXtnJFjtZ7KiHI2FHPC581cVfXFVaFN6hn0URvf3I4lAggc4EIUeF?=
 =?us-ascii?Q?EsdDXOlBBxrod529ypoPeJaFEDBGbvOZ2ys1ieZwJUJlJfg0pepnPBupyOgY?=
 =?us-ascii?Q?kBD/LOqTubQF5rwKpolHqGf0n4Pb2GtE2ZX7+tU3C1qL0TVXC+rT6VatUx+4?=
 =?us-ascii?Q?TfjJDYa+3Q0pi9OPKSosE1GPsgk1QVu6Ay2i5nlc5hvgeCFvSIfaXmET8W8N?=
 =?us-ascii?Q?/clidjRI3h9iQuTeUAayMFPn7gvvDIouQX2FU0cUSoX3sbUCYVEZ7seemKp0?=
 =?us-ascii?Q?OMFsQuNoUGbiz34o/crWpP0JGkehLdDx7WNcSUcjZnaD7oWl5aAjINTVpvBn?=
 =?us-ascii?Q?iTboKknoJaVd/ZWn0gbdmcqILxETBdbv7I3i7s6eTmDwAOl/FVMYnDrEJOBw?=
 =?us-ascii?Q?8itz8hzDXlIL4OaF0dgVJhTfqyBC9AsHxBISZ4IwB/ovr90FG36R2P1Jk8cP?=
 =?us-ascii?Q?2/zZG7Jk3hGLqWwghgpWdn0n3NSqIeIXF5eJX1W268XhV8YcRV/+bI9+shG2?=
 =?us-ascii?Q?IhJlUI0L67WbQSW93U1BU1UaxgtaEv/a5NsxsCXw5+05T8JvrRnIRuthxmit?=
 =?us-ascii?Q?UGfuRz28y9X6kRqRl3elSa/rzbCF0+Yl+4St54I5f9wUppim6LH6Le/yPdit?=
 =?us-ascii?Q?/lCv6eXV4avEBI9JLnXUwcoUBdGIDJL34uukazEP9+wR30t4vbSIZKDL/o3V?=
 =?us-ascii?Q?xHg=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c159bec8-1bc3-4130-e3fc-08dcb44e6f08
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 06:26:54.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0092

Hi

WPA3 is broken on T2 Macs (atleast on 4364) for a long time. I was under th=
e impression brcmfmac doesn't support it.

Anyways, I've asked a fedora user to compile a kernel with CONFIG_BRCMDBG.

If you want logs without it, look over here:
https://pastebin.com/fnhH30JA

________________________________________
From: Janne Grunau <j@jannau.net>
Sent: 04 August 2024 11:49
To: Aditya Garg; devnull+j.jannau.net@kernel.org
Cc: arend.vanspriel@broadcom.com; asahi@lists.linux.dev; brcm80211-dev-list=
.pdl@broadcom.com; brcm80211@lists.linux.dev; kvalo@kernel.org; linus.walle=
ij@linaro.org; LKML; linux-wireless@vger.kernel.org; Hector Martin; stable@=
vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa dele=
tion

Hej,

On Sun, Aug 4, 2024, at 05:10, Aditya Garg wrote:
> Hi
>
> wpa_supplicant 2.11 broke Wi-Fi on T2 Macs as well, but this patch
> doesn't seem to be fixing Wi-Fi. Instead, it's breaking it even on
> older 2.10 wpa_supplicant. Tested by a user on bcm4364b2 wifi chip with
> a WPA2-PSK [AES] network. dmesg output:

On bcm4377, bcm4378 and bcm4388 (chipsets used in M1/M2 macs)
WPA3-SAE and WPA2-PSK still works with Fedora's wpa_supplicant 2.10.
Fedora's package carried SAE offload patches in 2.10.
wpa_supplicant 2.11 still doesn't work with this patch but it prevents a
kernel oops after a disconnect (due to an authentication timeout in the
current broken state) in wpa_supplicant.

I'll continue to debug the wpa_supplicant 2.11

best regards,
Janne

