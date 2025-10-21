Return-Path: <linux-wireless+bounces-28139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4CBF6931
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C7918982A1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86D32E6AA;
	Tue, 21 Oct 2025 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jdOOscEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011025.outbound.protection.outlook.com [52.103.33.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E2333457
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051401; cv=fail; b=ijRDbVQm80chwkq06aDxZ/86ChH2/OfY/31sOP4Ncs6lRyQ2BF5mOSXel6DoRxFi4C5RGbk3ih8ks9jogk8o19DPrWqxoXxmLYTsx5g+baRSiu14cuHysDO5dFqHgcITOIzfom3Su0dV7Q7C/D5MBF13MPGAA7DWVthjE/iZvs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051401; c=relaxed/simple;
	bh=2t7usjkMIO56S7zC+wGWUQVRXREWVQPS8YcZXdZqhE8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YwQPEMeJ4XL4gFUyrXTFidgfoqSSTd1zcjmQR19LSpsncJ2/hWZxpL/YXvLoGUxo6HlTAHrInmZcYSC1fxZ/pkY68/IO1QM/KNnOww4wkX1B6U6xgELrT/Cc8/S/en8zPE9RI0GUjvFmi8o+3TFnH8UKmFGQNbu+OyGsaVf2Pxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jdOOscEq; arc=fail smtp.client-ip=52.103.33.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBqf4OC6VNJ2NwcnOUReZFcYvCtUlVlIuEzkHbULCHNX2BF+rNOy98Y0Tqp0IiooHWvTWSB08soywqqwJP88pOyUS0Tz0kQjyDrb1qjQpoEMBY6AaXKse49ANpUtCpcpj81iD841m4dp3EbeMIBpFSundTmlsO4fBcL362h2OLAwsaxudgpbHBgkzcDVUReybdfptc4RHNnIYZnib6BA9Fb25obWi5wqohYqCRQUjpfdkzGmwIjdzyNUiky+k6lWbSRocHKjnmXe5SCOCswe7jsi/ajmxXeX/AFIfZeDxr6BxBWcR7y1lYDkzfj8G+ZXOJXEAQV72CtPxhNR8YLfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t7usjkMIO56S7zC+wGWUQVRXREWVQPS8YcZXdZqhE8=;
 b=jmICRlqmLszSCEAjV/JWugW0gkEBAVLSItQc5aVHTYYaBl5FVowtwOwq19gTN+NLovofciv16yODUHlsb/vBWlUCJvYXY/ckfLxBw4Da2cIkVrVSmqHtbtcLhwrboUzsaCPTZ+izyb2hfvZa8+4kya63pilYbVOrnwcntr3kTGAn/wq6itKxgonazQhKvIyL3UMQHbnJP5S4bJNFWX2aGU4l8cN1STsIIR7Qy+DZRShbdJE8DQbvuj+GX42p5W8wrFE6UXPjhfdvd9DRptonZe/Cwn/wpZRm4RPHvtWeJLv0HB+AcbK+YSdlwYaGTGoYvquL+ozlVKGWqCQ1LsF+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t7usjkMIO56S7zC+wGWUQVRXREWVQPS8YcZXdZqhE8=;
 b=jdOOscEqZPWzWkvUsH8VkOUb8qpPjWqYWzp9co6UvGCHDsmFH1m8EexqAFTzSHysShXK8uawRdrT4puk2675jnFlN/9DmlmjyZdqiyus6M8BXWhocAZ5pe1vr7YTQGFMNp9INCNbOF6Y7K79TY+mW/N9XEeH4EnB7WeJVMg1fsCwwM5pwqmMWYeQWCvvZuPRxfSTl7rFSZsDN1p8v3VRXFF34ctezolztbR4JjuaKsHDuCO7Mcx6W7eF4PBG9/MuLnrbpcKtxoTsJKQSLVtNpe4gH7bVFE2IVV2jNXlQf7Qyg6AiD2Da123rTfnQ4ers9l6uYIAPJcCHNxhoaViNHA==
Received: from AS8P194MB1919.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:52e::13)
 by PA4P194MB1071.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 12:45:53 +0000
Received: from AS8P194MB1919.EURP194.PROD.OUTLOOK.COM
 ([fe80::4fe7:bffd:1115:25b9]) by AS8P194MB1919.EURP194.PROD.OUTLOOK.COM
 ([fe80::4fe7:bffd:1115:25b9%4]) with mapi id 15.20.9228.014; Tue, 21 Oct 2025
 12:45:53 +0000
From: Stephen C Goodman <Stephen.C.Goodman2@outlook.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
	"arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>
Subject: Broadcom brcm80211 Displays WPA3 as WEP in OpenWRT
Thread-Topic: Broadcom brcm80211 Displays WPA3 as WEP in OpenWRT
Thread-Index: AQHcQoijvopPopH3iUiSdrbdYdZfjA==
Date: Tue, 21 Oct 2025 12:45:53 +0000
Message-ID:
 <AS8P194MB19190A3E9648FD04DCFD5A789DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
References:
 <AS8P194MB1919C4BF0BF0BF222F65BA449DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
In-Reply-To:
 <AS8P194MB1919C4BF0BF0BF222F65BA449DF2A@AS8P194MB1919.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P194MB1919:EE_|PA4P194MB1071:EE_
x-ms-office365-filtering-correlation-id: 5c5d8fc8-3042-4e06-1959-08de109fc5cf
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15030799006|8062599012|15080799012|8060799015|461199028|31061999003|40105399003|440099028|3412199025|102099032|3430499032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Jg2DCRWkbKJtaVE1CEWCdHVA3cTnlhzfwZat4oJhH6IlD3TGkrefRfVyLE?=
 =?iso-8859-1?Q?l5wd2oxefpFetnos7u86laO2cIpwpu01o7Irki1/zwMWszTL9UJ0SROuEL?=
 =?iso-8859-1?Q?0t6gGQVRHDxrQuN659nyPa0mN7Zcuee5AC8N9ZKIlgj29CnxMaxwfTHgnZ?=
 =?iso-8859-1?Q?K2rthvcXtyXc1ovzQ/ZF4Rwmz/Av/u9saEvMzR+dqqEVMTXYNOWJpBKZsK?=
 =?iso-8859-1?Q?V1JSa17ITTBKPSdb1ksLjn7iqs3j2VMU3UPXLTXijInv2n0+YTZqvU+0bp?=
 =?iso-8859-1?Q?7piVPvw0QO1fGIq8UeSZpr2T7yaM+nPXococqTRzd3g/ktfqDrlZ9Cbjwd?=
 =?iso-8859-1?Q?btWmhDYPPxCukrAlwkHywq/6obRj5skxiBVHyst+/aYkpCPjuAMRbUIeJW?=
 =?iso-8859-1?Q?lsbXZj7EQbdWWdTzts+FLCMrb9iJldyaZVfh3i3WP/nxdbLn6id/enimnH?=
 =?iso-8859-1?Q?prZHx/OIZFoMAusv+zGMc5DZT0lu7SiKAhRbpJVJrw70qniuTsNF5lhPEt?=
 =?iso-8859-1?Q?5UqVzCIcWvVctnxPUyQ07UMJNQx6DsWfRRdEPpni1okt2j7mNjMsj5Asgc?=
 =?iso-8859-1?Q?6IHByUtOSuwHcqs3UTjqqQIqoUCztXNpyrmmEJSn/kdtXZjHGBrj2+Xr+o?=
 =?iso-8859-1?Q?Ui6E0akekiAWHY/NgJz5VAEbHWqinJbaktNPEa2mkvfCDNyT+g539GXayZ?=
 =?iso-8859-1?Q?pbHJDI9TxecoTasJTMTsGPuO3MLcjNYXG56ifBIDVhoeuMvxeJbIHJhWAh?=
 =?iso-8859-1?Q?23nHCxSZaF0eG48ZxB7KDCcsg8AAB3xijd+BTBscjl7DlrxrSP4wRFU9jA?=
 =?iso-8859-1?Q?oM5P6rkNJ66V8xCOuK3Wmfaqsf/ux59exZUiYUNrZU/P09WAymCtg74tg3?=
 =?iso-8859-1?Q?UIMCLCkRi3rFDUVGlZJbbBYFBVF+jUheNnHNBznIoeYyMZYGl84oRYOSu0?=
 =?iso-8859-1?Q?hSzYw6BsU3wMyaCkfB34a6NkJMGobV3JXUT/G2ITtGI0Tlpk9EL1Y/QNP0?=
 =?iso-8859-1?Q?7mQqMzUSFCVWk8f2ilUoXuln47xD0puyBx0ynV/9SELX1FiHBmpV2zmPmr?=
 =?iso-8859-1?Q?mq07aWiEPPrbepdvXkWwzISJPGjnSsfZG7VvwybN4z4cawt4hU9MNnOfAj?=
 =?iso-8859-1?Q?woOjvUjivFPKpMghaOnzjxOMSEqUPTrkYbei6P8FPPnneujr1FarwtVnMR?=
 =?iso-8859-1?Q?JveE7cRp8qAUzVgTnZhcRjW6c92vVZrgPKnPbPG+A16h0xszGJU+TGWm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+imClX3NbnMVyk45Yk9ccS/HX3pVXWFyn5N/RhaIWlkQ/zPzFaB7GDXtEc?=
 =?iso-8859-1?Q?xS0J3zF3OKPD6l0n1widWts1+p32Bf0cmAbsK2/UP4dDb2m0yWuqULBCq0?=
 =?iso-8859-1?Q?1DxaS2BgnuSzbKX5H+uKU5yMoIywECT06KSirgTsHmiinv7dbSemn3rVz8?=
 =?iso-8859-1?Q?a+62I0xWg9c56AKhFFAoM1kqRSpcff2w9ehlQR5APYz2v/Iw/VCUNoX4ca?=
 =?iso-8859-1?Q?T7Yq1fAHNGT5GSvG3US1Ia+X2rW2St5z3qdlSySZX4Oe3O3UCMm4vqu2fJ?=
 =?iso-8859-1?Q?fWh95YZYhw71QJY6mT/XIsp+W6XbNudZyi0ounNA6KD6aUJjVlX7DCPR/j?=
 =?iso-8859-1?Q?Is20+XNyOUGc6cCFWjB7F1vc5XAN7mLP2+2kU8cMhULL9f3CyN6vM18qm/?=
 =?iso-8859-1?Q?st4QINtn2YIVhk/R3jy3tpd2B2XZQPZf75jJ1lIp1uLwyWqvHySnuLi/JN?=
 =?iso-8859-1?Q?88lIyBI8HTr2LYmFwxBlbFV4u7HKqvhv31Lcguvlk9tuS34a7HxAvzGZqJ?=
 =?iso-8859-1?Q?VapdGy+pTSUnnI4pEx5fB0Tt4V+YxoP8/59UKLIarkA7iMwpPpQXbHm1kj?=
 =?iso-8859-1?Q?l1lNv+MLofcz0bqVcuH/QODQCXZFxU4df1qlMXhwV8FtB1vsUJ8BONwzru?=
 =?iso-8859-1?Q?aeKnOK10w3AvRWPQHmPC44PiC2f+L3vn3kqoBa/arlgKwMJ8qlK7AReED7?=
 =?iso-8859-1?Q?Pzsp54AvLVw04Xh1YHp8F+tZ/ip+vh1lJHPVG7nvJCY227mf3LEW4qebFX?=
 =?iso-8859-1?Q?C8DhGVJYmS7IqfB06LlZTd6qX39sjZo29/GjkWdvMjv6/SowNAEshn4AuK?=
 =?iso-8859-1?Q?vb33buFNaNh0BIN+MTAOJXzmaq071abpjlTEJ7fNAOIWKhplPU562WTlkS?=
 =?iso-8859-1?Q?A15MjCX5XkoX4/TxnITDZnYvr23bBTZSImGxi619+/ebAw/6f0bXuJta59?=
 =?iso-8859-1?Q?f4n85OpQyk4CsW3UAkhlJ5+D88JAYJvBvMEUV27bGBvK/cgwpvS6UJSCZF?=
 =?iso-8859-1?Q?IWVEtXgB8cyIoqqqoZ+biSjFcMpVNeXQLLXM+kxkA+matnpY6Z3WRajZwp?=
 =?iso-8859-1?Q?ZjlTZZD/xpXnpJXilE8BYi9Qn4tReSL9uHgwyZMc/MopWK3B8BGtrc+Pp8?=
 =?iso-8859-1?Q?/kMfobsppMNJJhjeg45i7NWyhV6IvE35JyPZuOH0FTOkHCIfR30/AoEngD?=
 =?iso-8859-1?Q?sMOMhhr3Wv+r5G025FF8ifuks5CxcE2kDhdhBnU54qbSsF/9iwpgtIa3XN?=
 =?iso-8859-1?Q?Y/dSHB0LmI6MKhMR9wk6Lymwg7kOQZawK4sFxnXSdZ4HFSFgP0IMJfksTE?=
 =?iso-8859-1?Q?Q7GD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P194MB1919.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d8fc8-3042-4e06-1959-08de109fc5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 12:45:53.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P194MB1071

I would like to report a bug concerning the Broadcom bcm4366c0 driver, whic=
h affects most brcmfmac PCIe chips.=0A=
Issue Details:=0A=
Chipset: Broadcom bcm4366c0=0A=
Environment: OpenWRT=0A=
Kernel Version: 6.12.54=0A=
mac80211 Version: 6.16 (backports)=0A=
Description: While WPA3 is shown as SAE in OpenWRT LuCI, attempts to connec=
t to the network or using a Wi-Fi analyzer reveal that it is actually opera=
ting as WEP. This discrepancy creates confusion and undermines security exp=
ectations.=0A=
Steps to Reproduce:=0A=
Use the Broadcom bcm4366c0 in an OpenWRT environment.=0A=
Configure a wireless network with WPA3 security via LuCI.=0A=
Attempt to connect to the network or perform a scan with a Wi-Fi analyzer.=
=0A=
Observe that it identifies WPA3 as WEP.=0A=
Please let me know if you require any additional information or logs to hel=
p diagnose this issue. Thank you for addressing this matter promptly.=0A=
Best regards,=0A=
Stephen=

