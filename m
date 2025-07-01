Return-Path: <linux-wireless+bounces-24741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B355CAF0227
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38F04A4A4D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A32797BE;
	Tue,  1 Jul 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ya+/6VSV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011024.outbound.protection.outlook.com [52.103.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7425C6EC
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391871; cv=fail; b=BtuqgP9iIw2KMtWYHUKeXcxs/bgkCGMaQQjsgEWIdXTcxqs2vJ4yGWHKLO0LrqOyohTWR2RlNRL26RBrDjlBuDky7DC+DixIlLyjixDWRriuv+2TTj79j67GhSMThZFBjplHpUMFHufIl4N5EqTmcQmwpc9p1P8ylxjmDtE+d9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391871; c=relaxed/simple;
	bh=puz6MkL1DQIkMzPRqU4/+DzV1g9uQrWFo7mGhkty8Ww=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJujOmlDBUauKbniQyGAEsDnNbcBHjDJ///J/ws5i8zeWfjZ2CORxg3ZRwmRzWxmDgzMgOP9KwS5Mic2Im5aQiE5kYQbkuo7sMdtoLHLOTMNhex51VDrgp93kqOVwWGXhq3b0Pohvn0cXV1/OVrLg6snv2LDWObRMrskQkG6DHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ya+/6VSV; arc=fail smtp.client-ip=52.103.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaSHAXlebOUzAftarfWdiv7t6V24ufn7NE8VDC1nUWIMAFZV+3MsD00Jl+hEh7GouEwBvwP+nps471ncbhx15L2GupEAXkZIGD6GgP4TexmYCFijkxIfdtr1FknI5zLkY2GASsXnwUK5KxDbDU5qoGtm+/utDpISPxsbzcDFb8ZdBcrQAD1mrq3DY7XsV9awoNru9ervdo0VITw+NCYo3T9/4raOBma42aArc4ejevBdkmGzvlOv3L5kz6/Ol63276qBl9pFurn7aIsQqfReMYa+uuFo1PCt8rhkMsbP+vmri3am4galbEJv80ekPqMM8nmffpzgH/sCPG0BgIM0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puz6MkL1DQIkMzPRqU4/+DzV1g9uQrWFo7mGhkty8Ww=;
 b=mASyFUL12tMgs3jsZVaNTSClf2xV4QkJ9jfeXxxLAJOWZP8Pe/w+S677mKqhvfVjs8lbHVjjb9OSuJY7ttlTyizt9Fyr5yrw6jtLh2ll/0iyzph+Mdp7kNFaV+8Dmb1oU1oG01poXkD1vLNf8mMgDDrR1A6vFsAsiBbEZwpQBiZFoOXyZTuqiwO3WsvNwWS6p2ozUdadrc9YCEgogWo42Nq3zZdpV+B9JKJZVMmUXnudv5MNfHKF3kVkO87jrHAQ3Qq2R6fAsq63HL1Qn434eqXsx3xxzkb/+PnavZwCXWm0TxbfmEQ7TlJr39BnYEXv+RZpcoGy+zBBc604j/DLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puz6MkL1DQIkMzPRqU4/+DzV1g9uQrWFo7mGhkty8Ww=;
 b=Ya+/6VSVwEr2OhYYfqDGNAyzp5hQetEYav6LYL0UW3X+BdGw8Bv2PdPwHxtYH1QdWiCnio/iHd6HXYpS1jeU94NLSpJCZN1KJgcNKW3BWxMqgB0u/NRZ042aDfjFfdBWaqMdPt9lqj1/QPqhVvUpPz5RDPuD40E75GRMPnPb+9uJDWlLLep7FlAdLzg4IEUU749gsKlW/BBS4ivMdfmR7mKyrdtPRyk5E9DJ7yDRkQIH8auVEtS6AqQRSFeg5yUMTzp0M7iO0E3qdWDFQtuYW9i84B8ixfzcJv2l03Aq18LvnPWRXISiYxSKy4uOaAVu2+17JkOfNOwZiuCPALn/Qw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYYPR01MB12579.jpnprd01.prod.outlook.com
 (2603:1096:405:19c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 17:44:26 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f%6]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 17:44:25 +0000
Message-ID:
 <TY4PR01MB1443286365BCAAE548AD4702A9841A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Wed, 2 Jul 2025 01:44:20 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next 0/6] wifi: rtw89: Add support for RTL8852BU
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OF0EPArrkH0C3A5qY9LUjNT0"
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To TY4PR01MB14432.jpnprd01.prod.outlook.com (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <f8546ff8-b14e-440a-99b0-7a963149f956@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYYPR01MB12579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c303b88-d49a-4832-4741-08ddb8c6ebb6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|7092599006|12121999007|15080799009|8060799009|19110799006|6092099012|5072599009|20055399003|40105399003|4302099013|440099028|3412199025|26104999006|26115399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IusBitEGD0p3ATJMl1MvofJkLZ1socSo7XOfzqNobRi+mVzCkT4OWvTzne+J?=
 =?us-ascii?Q?8LBbSC6lSoy3UXAfR9+M6mki3PuLvyismnKNQ0G+9gvpCnjB68IV3sQI4dG6?=
 =?us-ascii?Q?iX7OHKMPJ8ao2dp52KMAyOVkSqZlSODy95rCr4LuHVjPjPax2/jwKSXre+tW?=
 =?us-ascii?Q?CQ0Lnxz1/PumV4B5J1reOUDqQ5rVOhTnN4drSCb2xv0U4YeYUtXb33V6CPmK?=
 =?us-ascii?Q?TTtk+klnkScDRCRIXkdj/h08LnYWRe8Q9xngHs3+xOKfygW6pkQQnLLJL+cY?=
 =?us-ascii?Q?MgJPnhGa9nw4pxYxuKjcSkTWmK6/lGbcUFO/E7DdpGtdJdCceok4BPmgng1Y?=
 =?us-ascii?Q?Eo4Nhd2CvnYYn9fb7ol6yEgYAHqxVKB4O0Vyv0m+mAtCGDzRzWSZx8bY27n7?=
 =?us-ascii?Q?O1o9BQHSr+AaiTVxMk28QUJ5Nanr09BMbpiMs12mVAX3H3cuCVPaOAMWjiIL?=
 =?us-ascii?Q?dUii4kCk/DOybv7nH8uJaLHXCZx6v2Xvf/lscWPdHunMRvXrdHbqTaGzPmxe?=
 =?us-ascii?Q?HM0bLVINpJv7E1znMR/ztAxLGwOhnulEJNC8M4HlD4NevhCuDMhirtG6jvOD?=
 =?us-ascii?Q?UH7uYrFlRXazVAihvd9e4JGaDaZG1iYFv3pSp5mPGtcsi/Qv37f1ycnt92sC?=
 =?us-ascii?Q?RDEot0j+aQR2MFB+5tukPc+OUPE/NcMqr9o6Sjz6T0zw3Ms1NLVycy/VoZoT?=
 =?us-ascii?Q?GZerYnhhh3vgqCtH/GyILkc/U1VWeffLiHrSYoNenglJjIsB3/hw8qtZQIHy?=
 =?us-ascii?Q?QWLJMTmE1wu4eQ19vWbjU9UGM7lh88HpZsDZXaR0qMjXwNoPslLf9KYRpNO5?=
 =?us-ascii?Q?IOHlmeDVEZCAJNjOTc0aS3Z1rfrKg2rKbsCBV9GYKNnlmd2d4kIpxvnNy/kU?=
 =?us-ascii?Q?9H3t6lBM2qArgD5Bhi1yrLrxmStvf5pjmTZe/n2pS05Atl2ypzke5UNwLRrB?=
 =?us-ascii?Q?Sdp+IV10QF4uyd+S6zezQ9thISeZvshhPcGHKis9wTzs6+FI0aHWKzJXFh4J?=
 =?us-ascii?Q?IaLazxOOzSgNvDZre7ZZesuwbkgqMUuzKbP+1u9wy7PN7LTADzu157fHQW0d?=
 =?us-ascii?Q?ZKg5fgF4JX8tO8SQodi8IyHqosi2DNf2cMIlOBw39UX/ETxQf2CxrutBx3UD?=
 =?us-ascii?Q?ydbwL6P6yc2jCzvkhozEVur3NfvoK+FY80ow8Og6OMfIQzxj3pFIq4zzO2mZ?=
 =?us-ascii?Q?P5rVy4Hvo/pWR2/A3xu76C8pErREAHvqD0CIYQQ5WFkhrt5vqLKU0gSv/Z09?=
 =?us-ascii?Q?8b0YOJ+gxPFqzeKqD9I4qZHYMLrd6O4b1333JMj+JFYaXaUhdZ6LGGE0KZS2?=
 =?us-ascii?Q?4qPSiePzirEZT2vImlx5Zm2orACjSYID0n1R8HNdCYBXDgtKHdGBExh5HWfG?=
 =?us-ascii?Q?GuWyZn6idUAPEWfKcA2OusM9hlOQ6TWMFz4CPanXrjfPZ5kwt/G76xfR3mWn?=
 =?us-ascii?Q?PhzHE5bjVneK+as/93qP9OP5g/fDhdb3T/HhhUdqCippkIDNhKDL0w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEdo4qSpi3hDemuXxQXWZ3a9zHR3prwFAbUe7Zfe6Rqz6pAuaWCAlwmdXasu?=
 =?us-ascii?Q?zuH1IRUVF3rr2yxO3PzOb9aYH73A6dDe5yrzpF3UA0oXPaBwIcMzgL7tZZVw?=
 =?us-ascii?Q?+K1KbsHyVIXxoaOtbx6waXWLHFdjo9THHlgVcQqlV1rqvAwutCC0J67SZ5eH?=
 =?us-ascii?Q?a/D3ZzUHRyQr9Zjz+vuoLAhlnXegxF9yDFZE1382faqSN+oJAnRIWZw+4hvY?=
 =?us-ascii?Q?WDJ0pLE0G+OeU4QEiw+cAm7AtsnBEP3vRbvc8LQkg7Q1rpO1UAplPoFQyvjd?=
 =?us-ascii?Q?Mg6RFMRoYp87I9NYocfiByTrwcEfOFsCa1BJkx/b4tAkLSynCZzjOGkANA9U?=
 =?us-ascii?Q?UHRFzrood4vc5urqgz86FFet+QJZwtazPhahIDCTC9GlB8hZEhOKdmaZXl/w?=
 =?us-ascii?Q?85XqN7k6cTQ0E5ioaqKbDk/1h/6hYSc6Em0KaiqBwD0ySUuoK/Ecd4doE6k5?=
 =?us-ascii?Q?23Nv5+bjU78hRHlZot3SJSj471CmrgjEiKljd9iMQ++pe0z8JbEzit9XOEbN?=
 =?us-ascii?Q?Oe0lceuJq2h5fQOLedO6FVq8YlrJqpQwhLeKOFVyaumG2meXoPAop9tigqeV?=
 =?us-ascii?Q?73zBoT2y8Y8gL/NzrEE33v8geyT+Rj+3nn8bgdnwptm4OdDn8PVtvb8/qZHb?=
 =?us-ascii?Q?U7h3hZ0eCE4tpWgjmTn2rAyJgAXsnJZ0t5I+sS528mYX8wms2WOfMoOW4Atr?=
 =?us-ascii?Q?YwvHi9C9VpwWbuVxCdjM77igjg7nVD4joY5noSDLEeZRl/hKVIWvhfXaVDvq?=
 =?us-ascii?Q?7OMN1AFVgteMZH7vIjPCgtWVj49zt+GKf/BD5fjOmPUYo7u+Wcl2jgnTHuB2?=
 =?us-ascii?Q?n2YwdrmmHkHQXw+gXJMfFvu3/9O3rjwUQP4YfcEzoPRcbCpAVCoNx4KYVGRb?=
 =?us-ascii?Q?ZMpki/wAeJ2Mgs4IrTHGRtCdbHr1Kunwiw2oQMbKaliz51Fv+ooO3A38oAjc?=
 =?us-ascii?Q?wROqDSX0UkdpO5VoglxYzRWsF8MwN9eB8pLxeOHJVndlfHB053JHYrQmGUIM?=
 =?us-ascii?Q?N3tgFC4AyBFup06zOhJel0bPqhdRyOrsMp0eES6aR+f7La2V1TyiCepjThs8?=
 =?us-ascii?Q?Oh6VnGcB+zJoegyDHesViRDVPGOdHVrPt2KA1jEybjEqMk2F66z/jFYM1szO?=
 =?us-ascii?Q?XFrqtyXiVfDK/dhAe1n8qJ7VKOBoq2NYJ6W4WYXP+FnTuiH0iaARxmTPelOc?=
 =?us-ascii?Q?I0k5TNauN3ATaJv4Humq4CvO3B+slpWCDxXD1lTilsre1QJ4XVLIpAzp1C/i?=
 =?us-ascii?Q?Ba8KHYb/ksWV0HjVysJZ5oFIzF+blWDMnoV9I/Nr7RH+mm52IxpNNlSxjwPr?=
 =?us-ascii?Q?f4c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c303b88-d49a-4832-4741-08ddb8c6ebb6
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:44:25.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12579

--------------OF0EPArrkH0C3A5qY9LUjNT0
Content-Type: multipart/mixed; boundary="------------pKsm0295L7nQEk4MO2D7uqNI";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: wiagn233@outlook.com, Ping-Ke Shih <pkshih@realtek.com>
Message-ID: <f8546ff8-b14e-440a-99b0-7a963149f956@outlook.com>
Subject: Re: [PATCH rtw-next 0/6] wifi: rtw89: Add support for RTL8852BU
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>

--------------pKsm0295L7nQEk4MO2D7uqNI
Content-Type: multipart/mixed; boundary="------------1dhsPQWyV13IFxsU2MVx4ORT"

--------------1dhsPQWyV13IFxsU2MVx4ORT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkdyZWF0IHRvIHNlZSA4ODUyQlUgc3VwcG9ydCEgQnR3IHdpbGwgeW91IGFsc28g
YWRkIHN1cHBvcnQgZm9yIDg4NTJCUz8NCg0KQmVzdCByZWdhcmRzLA0KU2hlbmd5dQ0KDQrl
nKggMjAyNS83LzIgMDowMCwgQml0dGVyYmx1ZSBTbWl0aCDlhpnpgZM6DQo+IEFkZCBzdXBw
b3J0IGZvciBSVEw4ODUyQlUuIFRoZSBjaGFuZ2VzIG5lZWRlZCBmb3IgdGhpcyBjaGlwIGFy
ZSB2ZXJ5DQo+IHNpbWlsYXIgdG8gdGhlIGNoYW5nZXMgbmVlZGVkIGZvciBSVEw4ODUxQlUu
DQo+IA0KPiBUaGVzZSBwYXRjaGVzIGRlcGVuZCBvbiB0aGUgaW5pdGlhbCBVU0Igc3VwcG9y
dCwgb2YgY291cnNlOg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtd2lyZWxlc3MvbGlzdC8/c2VyaWVzPTk3NzQ4MA0KPiANCj4gQml0dGVyYmx1ZSBT
bWl0aCAoNik6DQo+ICAgIHdpZmk6IHJ0dzg5OiA4ODUyYng6IEFjY2VwdCBVU0IgZGV2aWNl
cyBhbmQgbG9hZCB0aGVpciBNQUMgYWRkcmVzcw0KPiAgICB3aWZpOiBydHc4OTogODg1MmI6
IEZpeCBydHc4ODUyYl9wd3Jfe29uLG9mZn1fZnVuYygpIGZvciBVU0INCj4gICAgd2lmaTog
cnR3ODk6IDg4NTJiOiBBZGQgcnR3ODg1MmJfZGxlX21lbV91c2IzDQo+ICAgIHdpZmk6IHJ0
dzg5OiA4ODUyYjogQWRkIHJ0dzg4NTJiX2hmY19wYXJhbV9pbmlfdXNiDQo+ICAgIHdpZmk6
IHJ0dzg5OiBBZGQgcnR3ODg1MmJ1LmMNCj4gICAgd2lmaTogcnR3ODk6IEVuYWJsZSB0aGUg
bmV3IHJ0dzg5Xzg4NTJidSBtb2R1bGUNCj4gDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9LY29uZmlnICAgIHwgMTIgKysrDQo+ICAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9NYWtlZmlsZSAgIHwgIDMgKw0KPiAgIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmIuYyB8IDg1ICsrKysrKysrKysrKysr
KysrLS0NCj4gICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYl9jb21tb24u
YyAgfCAxNiArKy0tDQo+ICAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4
NTJidS5jICAgIHwgNTUgKysrKysrKysrKysrDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxNTYg
aW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmJ1LmMNCj4gDQoN
Cg==
--------------1dhsPQWyV13IFxsU2MVx4ORT
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------1dhsPQWyV13IFxsU2MVx4ORT--

--------------pKsm0295L7nQEk4MO2D7uqNI--

--------------OF0EPArrkH0C3A5qY9LUjNT0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmhkHnUFAwAAAAAACgkQX75KBAfJsRnb
mw//cSclzghzTjLPd4cAqwWNCEnPujkV5P+nwZl/qXcAN/ma25XefQWZ4OPrAeHNkpUnymwcYe7j
oxcpHxyG7yfS1SdMg1Uv82fZf6oOyfr+TY7go4ierUgN62wrfAxzYu5CqdDfFLuUj5lgMYYEGegB
+N3vNfdvQwpjKd6PH7BJPFQ1zv+s/xXmaf3XXNrklpOgE7FeIyKB2C4+VjxL1m/2Rd5hwYgRQLvV
xBe48d8gNabrfkMl2zki80qqvB4ujpFm6dttCVs5O9i6Ge5jWeznd0IS/57cfZSDeI7Rq8QYlsdI
rW/CE5SD+8ClAApu/Li9G8nNHo11E+LlNy6g9xQDbNPj9paXG1GsfEj56U8vGhQ/UWb9GPhQulF/
P29b5Vcuj/CR808pDWu+WGI8N3UGU8ONnqf0y4IDIP03zCGNn29hF6+MhVNTCrsu+552hErZMvmM
nsc28eNUK0X+ySGugOP54igCf8iGUhy9Ej+ff7eVWz28XnBHmQcnvdK7nvp1SrFuy6gMepsDSQbz
PdvMAILnI23+MerLzAhWMcttKFzjafyEHwKkM7crkCfEscx9IU7ELrype5FQ6Q5S+UM3XEoI+kXJ
xafTEzAymZl/ksf8w2ejVy+z1YnHWq6m/NsW+Ch2d4H6D5xF9OGmEg5rd7MxfizZakkceMHiU9sB
Fks=
=PRel
-----END PGP SIGNATURE-----

--------------OF0EPArrkH0C3A5qY9LUjNT0--

