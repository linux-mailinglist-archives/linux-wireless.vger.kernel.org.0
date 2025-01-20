Return-Path: <linux-wireless+bounces-17759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D6A170E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2531F188511C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FD1EBA05;
	Mon, 20 Jan 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cPIhEIL2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB71E0B66;
	Mon, 20 Jan 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392196; cv=fail; b=kZLuAlW903K6OxDa4DFBZLZoMkrMolztMb0rjx5K61fUg60ruirLpzG6+5oObyZFHeyLVJ76iqkqgpRyIGF9qptKbCT+mw5xRlz2f52EpB/vtuN7Uib9E/Udl58Ika0jc7uVmp71+ku/8684lAxF+QzleqZz8sUb9iYkbFhfTz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392196; c=relaxed/simple;
	bh=poQMIwuPKYkLdxPmlbNWSjuajtdJ+yJ8mQIS2niXuks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPxm9kyzXkWlGsSmgQamcKazUvH2HlA7zAGVEOPAQjA425U31jluq7sQPc2fOS+EyRuxDiYYCuHek4SVRz0ng/QxKpczpKcGzScn168jK1+9Ui5Ph04rlBPcDCYIJ3dJxumB2WjLnjNdv32Rtl1e+17MSrYzRnCl1E5lbQ8mIFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cPIhEIL2; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiEPrWuUY1LSnbMKVbNDq+bMLoT0ZoOMErMKelp/zp8dnRR2aVul31GkvL05tAa9lh198eZf21NeHmSrSE2MtmS+1qmLMdc6u7WwmnAVMkHiRsBW6kp5eW9gSHIO1IIcsToULXCdbGh26x22bOiIS2sI6ZAUnmgLk97ny1Bc8ABGfZY2Ky2BSwi0KxvdlTlNPk5KXe/G2a+KV9+eo0INIX+JvsQWENwiluAxhGVnrDroNTbHtPVfnuNTzBA+zk3ooGht6ESXgVwDDua+CTumnla/cw+4e4cYtwMrz9opy0vhKG4m3txC43yU4XkUK9zta2wGJfP8c+CJn3AkcVtZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poQMIwuPKYkLdxPmlbNWSjuajtdJ+yJ8mQIS2niXuks=;
 b=C1F3nKnkNS1qSAI4clxAEaXiAAxt97B0DkR+hH7raAA9o/aKqQy9psS+RCMGCyQQnr4eIUAWDGjZQvOTuQOE0dqVrt0uE5gmmv6AlSqrVg/5vX8qQ6TE0PNGvlADSAqI0bRQmK4NXHQM9BMOS43zaAkoAuAYint7XrKzl6Rspdc7I44V5qaum41LquhaLBIETaBL/DMX+ZdBKWxYzq00mLe0g6LvTqY2nBwlagNTCEQcf0o6q4dGrCCyzOz3nQi98fReHztJP98u0ifrlGqA/mFTvqKyVB7F3oBgMNDbRPjEIPuZOLnIzK0i89hDVztoOzuUhDjYkg1u60wZgaX31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poQMIwuPKYkLdxPmlbNWSjuajtdJ+yJ8mQIS2niXuks=;
 b=cPIhEIL2LpDp7F0KwtYj+jbEjsyTjQSMoGY2WrkXnuSMl8mVwFwpyO/I/Tg5X+bssblAGuVljgwZzaMeW0Jngdvm+Z3Vf1aHH4K3xQJ0QFoXc5YNRm1kBZe1rTjm1lbhOMn0++BJcHDKUBs6Y3fejTieuYRBEVERlL4QhyXgX2NutVb6Df9elBAC1sqgVyeX2dSvUQQ1CtyddWXh2ID0GQw16vrmZ4RfhKpmHz+jNrl9iYdZZm5yzOSx0OCUJlvjYVv+9eu+zUovA8AzTFPRAg6D8wvMAZ/PGuJsr1cASNzmkm/j5Zh76s3AXHhxwOba0Jcu6nMbHLtXxACpmiOVnw==
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:3e::12)
 by PN2PR01MB9923.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:56:29 +0000
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668]) by MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:56:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, "j@jannau.net"
	<j@jannau.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Wi-Fi broken on Apple MacBook Pro with BCM4364 Chip
 starting from kernel 6.13
Thread-Topic: [REGRESSION] Wi-Fi broken on Apple MacBook Pro with BCM4364 Chip
 starting from kernel 6.13
Thread-Index: AQHbazJeZ9zerL33eUO4jTMBEw+ZkbMf4gyA
Date: Mon, 20 Jan 2025 16:56:29 +0000
Message-ID: <06B76E82-BA57-4195-87E5-B0935BDD4EF6@live.com>
References: <B606F666-4A6F-44D9-B956-0B3E88E286E9@live.com>
In-Reply-To: <B606F666-4A6F-44D9-B956-0B3E88E286E9@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA1PR01MB2555:EE_|PN2PR01MB9923:EE_
x-ms-office365-filtering-correlation-id: 3ef37f3a-706f-4b8d-d95a-08dd39736287
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j2+rXb3faMtF+Xaa30Omw8BT/4SfPdOWC0aYX3Apmac0OTaCU/RW33hHqEXSAtSeRM8VhKfdfcuY0QBjylgaC5S3/oINGPuJ0C5f431W1ghGAkztiisBHcKExcTWjqT7egyv7opko8LHlfMHMOVqoPpDjSGAtbGagg090ee5xu2Y3o62+M8mD2uU110vHszNmAHfT8WStbTnXzK1ZfZXag7rbwJuw99YUjpY/4PLFhFqgOEMDc9y/6yeHIFiKGsFSfr6Bm+P+GlEd2nFm5Ohw5HHITUuWsLsE4vFZdHaJ5evqdSudPn2s7/1DB0PmZpZsWHmf/9N6RVsrfv9PuNXSfBdW8g0OKd6EqpeeT5qjkjDSAm/4tLXCPh+7Bgb+X5St3nvrD0WREDnYHFGaPceieXSHgVWDVJE79CMMI4Y5Or4XUoykRpLGASEeJ25Xq7jhMOuVA3xFJioCLHu3O0z2XpbVo/NxbwcLtgnmpmHvnn+T5Pw/QSc9E1/P+2VgxDqZwU+7u5BYw15siCCM4b5AfGzf1SogbvlFlPncudXhnGoCx/q3DIlaqYy3q9BflSoxXKzEk/3YS6dUghFZOI7hF82xjxrwO6SBazNHxYX8J51AmcpAuczAk/H6PoYcnia02TdfZaIDIluiVPuoDUBHWMkVWr5bkwstjPsFGoKjzGhl2xG7gDMo/btkUbuTxKs+gUTe3rAxiV8NDQscIXXiA4jyNGjnFD6xHadkU+wWdkWvGzUgivhrfVHmQIsYh8s856lB1uVcTNmblaSRHsfFAM7fI4cMQLjrxq0Zv/iNs6x+kb1Pm2EpQbr
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|15080799006|7092599003|8060799006|1602099012|10035399004|102099032|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z285NjduMmFITDIwVjdVMUw5OERVL2VXQTYzVHlwU1ZsYUZhV1lEUEowQW4y?=
 =?utf-8?B?dmloNjhrTXRYbzJwT0NHUXkrbGIxckE0UFBZQWtSdlV3TDc2RmV6NStwa3Ns?=
 =?utf-8?B?NkRpR2g0UHN5U2pPTHhBckZSbFI1UUZyOXBBYzIzdk4wUzJJZGxjSGhveU82?=
 =?utf-8?B?eVhQNzlGSlVBL0NaRlVQS3d5NExkN1gwcUtGVXBTdkFJZmNUdUMvTFRJRmEz?=
 =?utf-8?B?aTNLN25FcFhEbmQ5RVFjTkYwcVBDd2U5ckY2blErWEI1UTRWbzl0TVJqY0dP?=
 =?utf-8?B?WGQxMWJKakxOSld0Ukg3TEkwN0wrNnlZMjMrajhZSzB6ODhZNjAyV21wQmVL?=
 =?utf-8?B?eTlxSGVJTEFUZ0VoOHRLMTFoR1J6TnlKbHVqV3R4T1dEdXluYzdTbGplZVFU?=
 =?utf-8?B?akVwUFFSQmJWOFd1VEZqMWREVVpPRHIvSmsraGh2ejk5WFk3Q2xxWDM1Z2lE?=
 =?utf-8?B?V2E1ZGY4dmZUNzlScWRHWG9EMEltQ3hYUHZnZW95aWJEOTdBOUlTUDQrell5?=
 =?utf-8?B?RU1ITTg4dTFKWTZUUHEvU3pHSVYzOCtMUVNPdnQxQmR6ZlR2SitNeFJyWTRk?=
 =?utf-8?B?SVRsS2xYa0s5MnY4bTFPbm5Mc0dpVURjZGR3cUNKNlZvakRXT3RlUDArSVoz?=
 =?utf-8?B?R2dGTkIyQXViSllMY01GY2hnSzJmdkpHelByVFBZaU02MG1XVjVWdW5HRTRX?=
 =?utf-8?B?cVhFbk9wa0J3UjFGY0lMeXVpekZYcFFjZlpDYktnZkRnL2pPSVFwZGhQL1Nk?=
 =?utf-8?B?YkowZjJmbmVPQVovcWxaN1l4ZTYwL3BOdStBM0FOVG1mN3EzNnRmVTd4ZGdt?=
 =?utf-8?B?d3VJUnlRcklOMEtpOFd5TzdaMldPZGc1OXdyMnE0aFRxL0lQeG5UNEVhYVRQ?=
 =?utf-8?B?UFg5QTdtTWNYbFJPNVlrbnZqZm13VnhGNE9Hd3FJMGFENitBYlZvaW5BdkFB?=
 =?utf-8?B?NFAvcDQzTWp3bndCbGpDd3hXd0UrekJzeG9XQ1JDQldiSDQvTUVSbUd1NlE2?=
 =?utf-8?B?am1lSi9GRk5sa2kxcDkzOWVwQTlKZGZCcnFYR216ZFArMHNmQmJFOHNmTm1L?=
 =?utf-8?B?UlBPN21wQ2NLQlRQQTYzZzlPemNpdFpLV2RQRjR1YklhNmlwZmdmV0tudzhM?=
 =?utf-8?B?eE5DaUlvMGs5NXhlLzk0dkswdTVBRGNCYzhYWGxjMUtzTTdINmovb2pBTnND?=
 =?utf-8?B?U3FMZFVmOVRFMUFKa29hUmtSSVNKTWlCWlNRVERkV1JmNGZOdVRYMHhwaDFV?=
 =?utf-8?B?SE1EaVdXTktOa1d6VzBUMEpsTFNMZ3kyYTNYWHZ3V0RaM240Wk5FdmlSY2tl?=
 =?utf-8?B?TFFvcDA3bHJibEptanFDeGt0U1dzbGgvUUxWRnNVTWY4T0xucFAzMndMRGJO?=
 =?utf-8?B?RFNEN1UyS0tEWVhscTJxUjQzTmVEeFRCSHI3U1BvTzRqcWpJN052SWpsWFAy?=
 =?utf-8?B?YlI0eTRPQ1ZoVTdsN01CV2JibzJvTVhvenVwTVhFK1ZtMEMzZ2dLRjRCMEh6?=
 =?utf-8?B?a0Y2bmh4RDlPNlcwNGJMSzJpdlowSmxuanF1c21UbTUrR294YTJ4UVBSUHB2?=
 =?utf-8?Q?JYcgi+0d7IEIWscjlUzx4iB8xQWCX/7McN6ME1gkXno5AX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3duUnN6Z0hqMUU1cmppSUMwelcwMHpJeGNRcElRZzA1cDlQWHhObDNsc1dS?=
 =?utf-8?B?TG1BMERSTUVSYXlFMUxKdTlvbDJKcHBWOVhFRFR4UHROQUVQZzFFWS91U1U2?=
 =?utf-8?B?Z3VsaSs1c2swWGhtRXpGSUFNcSt1MGt0TlZkdUtOMjZyY0I2NkdMZzh5MW8x?=
 =?utf-8?B?Y203cnphVm1CZEpNWGpyVjJMbVZrSDFzME42N2MxS3dGZ0tCZ04yK2ZjQXZS?=
 =?utf-8?B?Y29uOXJpQXRrKzdGbVh4MzM1QXFvZWl2eElVU01rUzc3WDQ4R3ZnYk95bTRa?=
 =?utf-8?B?eC80emZYZE56MjlrbzVkeThXRnF1ei9Jck1iMHhncnZmeDM5MFFlblhxeWR1?=
 =?utf-8?B?bFpidTFMQzlJNFlubG5Udi9PT3hUQmFXQ0xyRnRqUDdzeUVwbjlvVVEvSVEw?=
 =?utf-8?B?L0JET3JaVkpWRXBYbUY5cjFzTTlLbzBTRGtoK0dwSjllOWw2VExFYXpCSWdl?=
 =?utf-8?B?L2JKcnY1N1JCUUdOOGQ1cVZWSHlRM0k3ck9QR0xYZVk0dHUvVnIyMmdlZlZn?=
 =?utf-8?B?M0xqYzF6eWlidldBUGIzMkl5UVF0cFpqeldxMzREOWd3QWU3bVRXNDZRcGta?=
 =?utf-8?B?WTN5NlhDdHVNMkdOR1BtUjZHWG5ka01pRHBBenhtVzR5dEV3eGppejMrTjc5?=
 =?utf-8?B?aUV2T2ZzdkozbC9qbDVvNzhDeFNiTFFrbU9oNDNEWnVQRlEwNG5lOVpac05q?=
 =?utf-8?B?eUlLS095QTdIUmxIOTR1YitXMzlrU05NM3pVS04vblhwSmVweUhLbVFiOThj?=
 =?utf-8?B?b1E2djFteGtTc2JuRGdNcGhzbGQxVkNta3dQTkJMUlBlSGtzanJLRkhuVDZG?=
 =?utf-8?B?em5JZlkrU3drOTNCeCthdU9aUWdYejY0Wml5L3hzdUtlRjhxQks3OTJUUGlP?=
 =?utf-8?B?VXQ1ZTdNeW9aSEo5QjZacitMTWNNT0NFeHQ5UUpiU0dEakpQQzU1SVZQWVpW?=
 =?utf-8?B?Ris0TEVEWnYwMk92LzhvOFBaTE1UWE9UdFZWNkowenZBb2FualFmaWxBeWh1?=
 =?utf-8?B?YSthUVcrMGNGTVY4ZmpQeUMwQldJeVBqa2owOUJSZEJWNHlUV2ZJRElRYk9l?=
 =?utf-8?B?NW9zbGphSmhlOWprY2ZFNG14cjg3VXVCK2U3TFB3RGtzcVRCd2JkRVYrTEx1?=
 =?utf-8?B?dFptL1VwNnZPMU5ld3lZWWU3dThMRS9ZZFovVDNObndYZDJIdWhMV1hLdDc1?=
 =?utf-8?B?Tmp3R2k4V21ZMFBtR00ydEdOZmFYT243TkYxQjUzdzFTU3E5ZVM3QTN4SDlC?=
 =?utf-8?B?SHJIaFBITkdCbS84NjB6cTRGTHBOaFViVDBRSFZLS1d6RFpUdG1WMmhVT1hu?=
 =?utf-8?B?dHlkYUJXOUFuRmtsanNUZlo4WjVBS1ZLcGZmcE1iUTFKam5zc0U5bVdFR2tw?=
 =?utf-8?B?V2lXbEJzR29oMFZzWkx1bjBhREM3WFhyUW1uZmFWNFN3b2lJQStsWFlvbXdT?=
 =?utf-8?B?SWRyS2o1NWV0akFFMmdkckpsWDBRMkZKeDJYRnRMbS9yVmY4K1Z1ZXNidzVt?=
 =?utf-8?B?c1BYejZhdHpIUUlxZmVqWHdPM1ljQ0ZYUVB5cVZpcklkV1pobWd1UzUwa1lQ?=
 =?utf-8?B?Z2xzbUlYdngrWnFYUiswV0t3Vy9aZHY3UWlkR0haeUEybXc5NmNWSkk1V01B?=
 =?utf-8?B?VkZZS2xwU2VXRkM3UzN2UER1Lzl5bDVPWlRiUzNlQUp3WUNKbWlMQWtZdDNX?=
 =?utf-8?B?NzNGd2tON3NiZ1JCbG5JUFZyLzM1WnFyK0xWcC9sb0swaXpzczkrYWVmbkJ0?=
 =?utf-8?Q?nrXxOBu0q+lh7bYpRRr8HqObL/rkNapGPsQFsul?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7714D366CC0A9A46A4C856FB90C644B0@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef37f3a-706f-4b8d-d95a-08dd39736287
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:56:29.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9923

U28gaXQgdHVybmVkIG91dCB0aGUgY2hhbmdlcyBpbiB0aGUgZm9sbG93aW5nIGNvbW1pdCBicm9r
ZSB3aWZpIG9ubHkgb24gVDIgTWFjcyB3aXRoIEJDTTQzNjQgYW5kIEJDTTQzNTUgY2hpcHMuDQoN
Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjP2g9djYuMTMmaWQ9ZWExMWE4OWMzYWM2NGFkYTlkOGI3ZjdkZTI3OWNiNjM4NWVk
MTk0Zg0KDQpJ4oCZdmUgc2VudCBhIHBhdGNoIHdpdGggdGhlIGZpeCBoZXJlOg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy80N0U0M0YwNy1FMTFELTQ3OEMtODZENC0y
MzYyNzE1NEFDN0NAbGl2ZS5jb20vVC8jdQ0KDQoNCg0KPiBPbiAyMCBKYW4gMjAyNSwgYXQgNToy
NuKAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+
IFN0YXJ0aW5nIGZyb20ga2VybmVsIDYuMTMsIHRoZSB3aWZpIGFkYXB0ZXIgaXMgbm8gbG9uZ2Vy
IHJlY29nbmlzZWQgb24ga2VybmVsIDYuMTMuIEp1ZGdpbmcgZnJvbSB0aGUgbG9ncywgaXQgc2Vl
bXMgdGhhdCB0aGUgZmlybXdhcmUgaXMgbm8gbG9uZ2VyIGJlaW5nIHJlY29nbmlzZWQuDQo+IA0K
PiBTb21lIGxvZ3MgdGhhdCBtaWdodCBiZSB1c2VmdWw6DQo+IA0KPiBLZXJuZWwgY29uZmlnOg0K
PiANCj4gaHR0cHM6Ly9naXN0LmdpdGh1YnVzZXJjb250ZW50LmNvbS9BZGl0eWFHYXJnOC80YWRl
MTlkYTIwNTI2NmEyYTgwNDJmYmZjMDc4Zjc1ZS9yYXcvYmI0YWEwMTBkYWE4Y2ZmMDNlNGEyMjAy
YThmMjM0ODBjZjE2OGI3Ny9jb25maWctNi4xMy4wLTEtdDItbm9ibGUNCj4gDQo+IGpvdXJuYWxj
dGwgLWsgOg0KPiANCj4gaHR0cHM6Ly9naXN0LmdpdGh1YnVzZXJjb250ZW50LmNvbS9BZGl0eWFH
YXJnOC80YWRlMTlkYTIwNTI2NmEyYTgwNDJmYmZjMDc4Zjc1ZS9yYXcvYmI0YWEwMTBkYWE4Y2Zm
MDNlNGEyMjAyYThmMjM0ODBjZjE2OGI3Ny9qb3VybmFsY3RsDQo+IA0KPiBscyAvbGliL2Zpcm13
YXJlL2JyY206DQo+IA0KPiBodHRwczovL2dpc3QuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0FkaXR5
YUdhcmc4LzRhZGUxOWRhMjA1MjY2YTJhODA0MmZiZmMwNzhmNzVlL3Jhdy9iYjRhYTAxMGRhYThj
ZmYwM2U0YTIyMDJhOGYyMzQ4MGNmMTY4Yjc3L2Zpcm13YXJlDQo+IA0KPiANCj4gSSBhc3N1bWUg
dGhlIEFzYWhpIExpbnV4IGZvbGtzIGFsc28gaGF2ZSB0aGUgaXNzdWUuDQo+IA0KPiBMZXQgbWUg
a25vdyBpZiBzb21lIG90aGVyIGluZm9ybWF0aW9uIGlzIG5lZWRlZA0KPiANCj4gVGhhbmtzDQo+
IEFkaXR5YQ0KDQoNCg==

