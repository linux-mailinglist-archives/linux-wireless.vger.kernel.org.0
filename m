Return-Path: <linux-wireless+bounces-10301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AB933EA8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7328142E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965E17FAD8;
	Wed, 17 Jul 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="nChUgZcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022089.outbound.protection.outlook.com [40.107.149.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273F1109
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226992; cv=fail; b=Mn6Q5LNfhFRw5RfXTQ/FMAl6xFn3R44xGawgfsDW7blS9lL/4Ua+vsyx31EHOLSsa1zkYr8uHgBgdaBVQC9VtxshY4TBjr3qfGPSaRGas0fLK9niN536zRpP0yDEIlkiK/nYQU3q04Lcm8yO6Jgjdc3z9496jaYGZwXeCjYMX+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226992; c=relaxed/simple;
	bh=EnHJIzVDNoga0sHy6KgUHnI9qjR0XdEOjpaGlolM2xY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rn8afYWNTIXvHL8Mn4o2nT2GTrkCF+5VYZvMNIIHFI07c7QwDJxKr/+TgIJB9TJQVGNC2CWEbg9GaTWU/MJgrB99KKERK0bS/4XqkAYE64dCS/F/ZVyN6AvZTQgobDCb0mCPmftRqB3Xqdqzh4bOiqeVbjbomAhzehfkd98HtB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com; spf=pass smtp.mailfrom=softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=nChUgZcE; arc=fail smtp.client-ip=40.107.149.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXxLsFRzdTWjwlhB9ZIapT9D4e1A6snJUxf6C6aj6w3qC1unCv2IOYYjp4yy9A8HpsXALxpahedHR8rxo8vK4ZVLTv8SVN8LGmrHVAqILtUsiDVIi8O3kv8vb9rJ+sXdZqi5RuVHgiKrWGvOm16oCNftHQLIRhJq37tKGFN3rP9lq2eMaNo/5600dVz6P2OxkjfObZtQbktsDdC4mf0SgQscZf1iBBflvaqveWrHNJstIfApWFX/ZK9vBQeJJxOJXShYjW9NvbBTRCEmEDNM6EFdhqnBSbjXV346mrL4OmvK0TZJIADebkz3oyJFppZNbX5Azdi+LW5DZWrx/qQh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgBuYqxcMzrxG1QPwRUgH1xAE96/TGZMPu2KmLQPbQ4=;
 b=A85G6t9xi5LCA10ypfzbPZFTn5la57tSlvOX7YbiJJjwvpjvt0VaiOiWPMQflKPgxU6V2Qnm+j3NuJPTt6nrVjxpZsiG5khVEEopLlifC247nwQTkX9xFu5JXS6dCIk5SQrUMi/KYkI9ijXaqCVwTepDIKor/LYNHUh2vHDcLn9kafMWjC6+89jjnP3kY0l2j5xhHVyiMRlH9md0wcaSgXlOzNecrHOzMpXR0TREAQIkEFsi9EH3Sr4yZDfU1ilocRl/CH5IL/5AMSV4eoGo4ef7lV+CNDRHrnmTNWhpMtyUZVXnBqH67aub/2h5MAiHBNNuxVtQ9M3JJXUoeNBZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgBuYqxcMzrxG1QPwRUgH1xAE96/TGZMPu2KmLQPbQ4=;
 b=nChUgZcEFt29Smszq1qHuKTE1Q+IwNbZKab0sTc5kwpE6y9Q0wwMHLOa252aYnGWUwpASQKrGx82G4qungXtgPLbQZ47C/uG0ndKLMxgeXQBIV7fV1GDXVrC0K/c/m5sj++SeSPRbNvTt6EBpwriqDUt7LCssc36JTCWsN1W38QqGLGiZCJ/+ySOm7d+PneO2Cna5Oy0CQiVha5Zvg+aAzNDtX6koWdYUIk2cj/8Uo7M2s9Lhyg7FzTs0wxygEs6ffG0iAjDvj5oTwEBvy0mVwfyZjHs/nYGwW3eQaNwFYK0+XrhpZi5wT11HzKt4T12Y+c9bVp06P7VdFccgmevwA==
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3a::5) by
 BEZP281MB3106.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:65::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Wed, 17 Jul 2024 14:36:22 +0000
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2]) by BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 14:36:22 +0000
From: "Jesuiter, Henry" <henry.jesuiter@softing.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: Performance of Reassociation 
Thread-Topic: Performance of Reassociation 
Thread-Index: AQHa2EeueyCxNvdWakyDpuL0/ysvug==
Date: Wed, 17 Jul 2024 14:36:22 +0000
Message-ID:
 <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2210:EE_|BEZP281MB3106:EE_
x-ms-office365-filtering-correlation-id: 06cb1088-1e9d-477a-1bce-08dca66dd471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?fonUWarqW4qNa3gWbNVMUROgp77gCqNzYCkftMExmUqmI3/KBnJVvSKD?=
 =?Windows-1252?Q?OarZV2jTF2eBrqnLTLZh24z5+JGjuxAvktga7xG3m6dBCBd+5i6yiBVI?=
 =?Windows-1252?Q?HNiGxOYZPW2IMmrAcdgyq1eWF7utYqwVYLF1K9fy6IYluKxQq/5vevkn?=
 =?Windows-1252?Q?eGsZpIQiY8RY/x2X+VE6uSSuynXlKz2tK9n/4oljJqzQDOKlwdM1u3Xw?=
 =?Windows-1252?Q?73aa+EviAYUQhrPTpGaYN3LH4yh8NdnkP24XY+Q7ECyKivxE9Ewx/EcR?=
 =?Windows-1252?Q?y+mVaOIzlNIF4hAjxcTWOsTqfRLz+dSL26Uj4zQ1CDhAwhPcDbHDTxqe?=
 =?Windows-1252?Q?DgRIH23r3zV6Tka/7HDON8k50eO2LFMZGsHRjG3vEfR6SAH/CpuZlZpY?=
 =?Windows-1252?Q?ydGCPmKTQgPe/bKojMRMjFSWWEmvd1PJhsLMv2kxPq1i0hHV2HeRcxpk?=
 =?Windows-1252?Q?02RdfBhqbf7rOXoJ77QDHd++ytOuNIqeYDwzSsIZxmfi/UokMSrFG5RW?=
 =?Windows-1252?Q?ItwBUt3fDPgPFVG8iypk8Aez1wTF2OHZS0Kleua0PEgNiJ5kzNZjRMVx?=
 =?Windows-1252?Q?KDYmOQCgIe2Qx9uz4+Eqgfm0wNSoYRO+s2OmJZx5UODbJGGWflJPaj1f?=
 =?Windows-1252?Q?urCi89DLEnBV9D9+xH1wSxTz25oKc3FbPPifrmpPi2hJRBJe46BtK0nN?=
 =?Windows-1252?Q?DhVFPLyxV0KXhPLYv53AKqhPR4XsJxgm2Bzg3FbHJ7qYpqO4UYp+m7Vc?=
 =?Windows-1252?Q?uRkpFbqF1dxK9TWMW7iQneqqvdpg6BcVnrj5MNFJsxzTC3HJQ4FwLFY9?=
 =?Windows-1252?Q?QUWc9oBgkzWQIMZgDgpzhEMOla3w7BP2E7KX/yY0tiGc8K378Z/eF2Io?=
 =?Windows-1252?Q?x1Gl4XZpjWcEaOLs+ee5sK3jvNjkAPoUhYgRVKz6cKNRtAGVqsuanRQ1?=
 =?Windows-1252?Q?tGMgxmeIYaLmJckpuQRPKLDmpd2/8/3HHFfp2ScOZtSi4J+QSpI8y74B?=
 =?Windows-1252?Q?k5OHWcre5cpC9rJGhazuMsGunTnxk9loC5mdL3uuGjMwws0leNFdAtGO?=
 =?Windows-1252?Q?AvMSadIbZaynfuVlW1Oy1h5TjK/5YJjd2yhHGH+HA4Tzrtr/CVOR2lBy?=
 =?Windows-1252?Q?4ldlQsjs8fu0eT/bp4BBPdmD8SEBDbYgTwS6mAJ/FHRUxSzTNu9qkZkW?=
 =?Windows-1252?Q?Ehvw8EyeVycMxEPCnPh55Xf99I3rM6eAaRLDBIesv53P5cnCC2zeBIEC?=
 =?Windows-1252?Q?dg7ovB9bp4I3z5Q02c6pQQOR0Cn/IUSbEILB141ZvkJ4EiF0hqMG41D4?=
 =?Windows-1252?Q?Wlc1dg7wQielv1BYqc6fP01ynUkSVXauKGzKRFxcuQbLwdgryqAiYmAV?=
 =?Windows-1252?Q?jW5ZefNsGboNAeNcdQuiiRYhifBqXcumyk4rrEV998Mml7qHAMXB6nNP?=
 =?Windows-1252?Q?73BWPHUXMf8e6mSSRq+Lqw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?yYafvjkcH90szJD9qDMLXBwOw/4TQ/cZZbTsUG5rJ+S3i2iuWU5sTjeC?=
 =?Windows-1252?Q?akRVoqv/ws2LiZ6It8tf5+o5NZNzdLIsKWX1hKtmPsHuu2XY3n0y1D25?=
 =?Windows-1252?Q?IXAaIgGoSli5/Y7gl/p2g5dPcYOy5EJLWYpQ/AsC610Al8CbS3KW0Mnq?=
 =?Windows-1252?Q?GEmcG3OWZ1sivneEgtPGWxWFkyUXBmLwZgsQh5pDpm/gmDXqBb2OIgVx?=
 =?Windows-1252?Q?DWTsbPwZpuhOQwzzqRzpo9uasVv6YXKzemehJ3P5uQqrovyv+3+sLv1T?=
 =?Windows-1252?Q?L/qgzl3IZHmDsSVsTrsyrQTGWqJxAfNmKPYZ9VphYVO8oXmJsQWxdTGh?=
 =?Windows-1252?Q?svTE/AGvGegudafMhqRw6Wq4nXOSHop7VP5nUahqznNgBZdVmp74dp65?=
 =?Windows-1252?Q?qz6CYj6lnxmGLJV9KNZ9vmOhhUvRWc+NY/zWGtWkCkcklNVDaA0e9jRw?=
 =?Windows-1252?Q?x1GtU1Rj4G1LWvFU0E/itA64gc9kQkwshcAnQgGkR8VVdQzto5hLf3vV?=
 =?Windows-1252?Q?OebB8IjDw2bqCQS9BslIKvpMHHi4RTBbC9R7T6fxBdc+eeX6CcYf9JaV?=
 =?Windows-1252?Q?MyagokK8uCWAUkycjfk0DpbL2PS6G2m5tkFKYaqDyHUdJIVLftd7SBjf?=
 =?Windows-1252?Q?Kjo8oruBXCgxqHKymdoLone0I7lc87/eTv/eiq9CxzQ34GlXz26COyKY?=
 =?Windows-1252?Q?+wDItZpRQy0xKKn744Q+2264eKoTmo6DZtfNMyCWTG0kv0rhI2tpX42t?=
 =?Windows-1252?Q?lMSfHJuGKaONWLWz3Ozc5ZLkP3R9+CE/57lxi1WDiJAmiU88TgD2vRyy?=
 =?Windows-1252?Q?8lBUYaiU1VApnDIWhVLbKPdxeR4axq3cfU1onlXfohtqCwIqgiwG2EeT?=
 =?Windows-1252?Q?VrMdux3B36ov8oj7eMb8fOcUsfxUO7O93w04QTf9RqrnfQ2Yvl6ndAmU?=
 =?Windows-1252?Q?omm81gtvfWvZWqntCFiX3j+NArxo1T9ZAbVcFkLj6b8wHq5f1TdXgZZ2?=
 =?Windows-1252?Q?xSbcs6gq8w4xNjfRhnc2Z4A+Z7BgOnBaFwEWDssIOQqntEoAyl6EL+nP?=
 =?Windows-1252?Q?XZ/2nO2WgVsfSfqKQLhFXo8Zb5YJ5iTdtcQY/A5938rdRp5igsnwTaNq?=
 =?Windows-1252?Q?wvNzXN0xN3U3koWr3ABIy/Net+5FSnz5RwxaacXE32he+SP5K+lWIDRt?=
 =?Windows-1252?Q?7QfRjD0aDUoKmH4XKOQoxW/VTp3YewWVsDoPeF5onEM4XxgbXxnkG1nW?=
 =?Windows-1252?Q?nJ7AoJ6Hlc8cvKXtDO919jTplgcrTvebXerwzgfaQhL/ARNLrVyE1S0Z?=
 =?Windows-1252?Q?onuZVy/0r70LDcmTEAgTXksApTGlEgibZoi0bfS2cYyXYK+L23nYBRgm?=
 =?Windows-1252?Q?s5TotSJU6Pa0fu5hW/YuJu2sBmNvrMdA5Qkff+FcqCbhqov8oF+hK6+T?=
 =?Windows-1252?Q?A3NEYRdeyTCW7Af26iVD5Q4o5/CyKQAONceBj8sxvMm0k8nJcRiLvRbs?=
 =?Windows-1252?Q?qgo+FKCV4QE9egBcry1/YLQeLfRnDj3Tg807DO0mOeYL+buGtByduDTi?=
 =?Windows-1252?Q?RAj/rQzfa6kCGvr7TTrObay+svEDdue/LGySNF+KAJXHHyBDAxz94zKC?=
 =?Windows-1252?Q?NQ5lRtZq6YaTm3rrg/utvz+jKytzy8NDir8a54xDLZ9YGfAa53RWqAkb?=
 =?Windows-1252?Q?HibV58jiMPyI026L0niJhnyDgh9FnR5LVTEB/x4X+4R4r4mgms6lQw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cb1088-1e9d-477a-1bce-08dca66dd471
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 14:36:22.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lBIjAH82azR9IuDjhUjytHFt3inWifV5wJyxscA6w/qhjLyO4wH5Hm0p1YPjNm1BtW0BoTfpz+RY84u7yydqgPuiuUsawTPXEQMvGgiYUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3106

Hello,=A0=0A=
=0A=
we are using the rtw88 driver (with kernel 5.4) together with a RTL8822ce c=
hip (Firmware 9.9.15, WOW 9.9.4, H2C Version 15) on a PCI-Express card. We =
stumbled about long roaming durations and investigated a little into this i=
ssue, by using different hardware:=0A=
    * Freescale i.MX6/ARMv7=0A=
    * Intel Core i5-7300) =0A=
=0A=
and different distributions:=0A=
   * Yocto Hardknott/3.3.6, Kernel 5.4=0A=
   * Buildroot, Kernel 6.6=0A=
   * Ubuntu 20.04, Kernel 5.15=0A=
   * Ubuntu 24.04, Kernel 6.8 =0A=
=0A=
and found roaming times from 450ms (Ubuntu 24.04, Intel) up to 900ms (Yocto=
 3.3.6, FreeScale). =0A=
=0A=
Since we are used to much shorter roaming times (about 200ms even on the Fr=
eescale), we did some research and found that the driver is taking most tim=
e on two occasions: =0A=
1. Reinitializing the MAC (that was shutdown completely on the previous dis=
connect)=0A=
2. Recalibration of the PHY (maybe due to the MAC shutdown too)=0A=
=0A=
The following is a (shortened) trace of a roaming between two APs on our de=
vice. Please note: this log is taken with debug mask 0xffffffff in /sys/mod=
ule/rtw88_core/parameters/debug_mask - so there might be some timing impact=
 just due to the output, but we see similar results by setting debug mask t=
o 0x0. We also added some output for function tracing. =0A=
=0A=
1. disconnect and shutdown the  MAC after leaving the old AP=0A=
    [  561.500691] wlan0: disconnect from AP <old_ap> for new auth to <new_=
ap>=0A=
    [  561.532634] rtw_8822ce 0000:01:00.0: send H2C content 00000001 00000=
000=0A=
    [  561.532656] rtw_8822ce 0000:01:00.0: sta <old_ssid> with macid 0 lef=
t=0A=
    [  561.557185] rtw_8822ce 0000:01:00.0: this vif is not mu bfee=0A=
1.1 MAC shutdown happens here=0A=
    [  561.557589] rtw_8822ce 0000:01:00.0: rtw_mac_power_switch() =0A=
=0A=
2. Start authentication to the new AP=0A=
    [  561.557691] wlan0: authenticate with <new_ssid>=0A=
2.1 Reinitialize the hardware =0A=
    [  561.577099] rtw_8822ce 0000:01:00.0:  rtw_power_on()=0A=
    [  561.577109] rtw_8822ce 0000:01:00.0:  rtw_hci_setup()=0A=
    [  561.577128] rtw_8822ce 0000:01:00.0:  rtw_mac_power_on()=0A=
    [  561.577262] rtw_8822ce 0000:01:00.0:  rtw_mac_power_switch()=0A=
    [  561.580561] rtw_8822ce 0000:01:00.0:  rtw_wait_firmware_completion()=
=0A=
    [  561.584826] rtw_8822ce 0000:01:00.0:  rtw_download_firmware()=0A=
=3D> about 40ms here=0A=
    [  561.614635] rtw_8822ce 0000:01:00.0: rtw_hci_setup()=0A=
    [  561.614657] rtw_8822ce 0000:01:00.0: rtw_mac_init()=0A=
=3D> about 250ms here=0A=
    [  561.876080] rtw_8822ce 0000:01:00.0: rtw_hci_start()=0A=
    ...=0A=
2.2 PHY calibration=0A=
    [  561.877140] rtw_8822ce 0000:01:00.0: [RFK] WiFi / BT RFK handshake s=
tart!!=0A=
    ...=0A=
    [  561.896456] rtw_8822ce 0000:01:00.0: [RFK] WiFi / BT RFK handshake f=
inish!!=0A=
    [  561.936393] rtw_8822ce 0000:01:00.0: [DPK] s0 dpk start=0A=
    [  562.056272] rtw_8822ce 0000:01:00.0: [DPK] s0 dpk finish=0A=
    [  562.056280] rtw_8822ce 0000:01:00.0: [DPK] s1 dpk start=0A=
    [  562.176275] rtw_8822ce 0000:01:00.0: [DPK] s1 dpk finish=0A=
=3D> about additional 300ms until here (that's the phy calibration stuff)=
=0A=
    ...=0A=
    [  562.297750] wlan0: send auth to 1c:28:af:40:fc:70 (try 1/3)=0A=
=0A=
So, we are wondering if this long duration times for reassociation are hard=
ware-related (maybe even someone uses the same chip and does not experience=
 these delays)? =0A=
=0A=
On the software side, is there some optimization potential known in the sof=
tware/driver that is just not realized yet? We would be happy to realize/im=
plement those potentials. To be more specific: We are looking for a way tha=
t the driver does not need to reinitialize/restart the hardware while roami=
ng in order to reduce that part of the roaming delay specifically (and mayb=
e skip/shorten the phy_calibration part). Any ideas are welcome. We are als=
o happy to provide any additional logs that might be needed (please specify=
) and to answer any additional question you might have. =0A=
=0A=
Viele Gr=FC=DFe / Best regards=0A=
Henry Jesuiter=0A=
=0A=
Teamleiter Firmware / Team Leader Firmware=0A=
E-Mail: henry.jesuiter@softing.com=0A=
=0A=
Softing Automotive Electronics GmbH=0A=
Richard-Reitzner-Allee 6 =96 85540 Haar - Germany=0A=
Fax +49 89 456 56 -499 =96 www.automotive.softing.com=0A=
Sitz: Haar bei M=FCnchen, Amtsgericht M=FCnchen, HRB 184930=0A=
Gesch=E4ftsf=FChrer: Ren=E9 Schneider, Oliver Fieth, Dr. Wolfgang Trier=0A=

