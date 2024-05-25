Return-Path: <linux-wireless+bounces-8053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844648CED42
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 02:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0211F2216F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 00:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442210E6;
	Sat, 25 May 2024 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rk8fUNLF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957AA47;
	Sat, 25 May 2024 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716598267; cv=fail; b=Zf1ZADBUWgSPRjMysBYgRUOnVsGr36n4gsObnuBMkIB5i2eswFTK8HsAlIpPn2lGpd60957hrOmptiJ/qU7VvWaj5C8xozKcs/b2fHdjTLP+L0TzLhX9/4N4Q9UxJQTrYqr/mOMkZSRbWR8fBlASK6VMNZQGHTYlDT7drJQqjYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716598267; c=relaxed/simple;
	bh=TenAwvtPHPyjkQVnmFwQHdi6PY7bWEO+mjNf6Sn9xk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFOTQT+Mp8GBDkNk8fP33VV+/pyxi9uQLT3n7iv1mN2wBzU8izq7FV2YYyYEy/uyRpaVRIeWfouDdgzGluFMu1oreDhXSqApqo6uHczEY1HyRDYsWJiywLQca0IhVuqI626XgEPT6Lz3EkqG3NgYfA7BfJUgZ/xbqKeWo2kvorI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rk8fUNLF; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChEtq7uEQdxZg6BKQcqvd5ctkDSupS7xc/ZuI0vVvCxsIkwlkV/UihjbUfcph6gVAepr10vi3DfMh7MQkji2h5kMOwVsZG8hZflPg4HelAj2tALah01/oAvkbQ6PVY13NJNlSxPzRJoL05hwIxZLMrbY9YY7Knl1M/AcL7B7Wn4itB4dnBTXaqNbNULKmDlQICgTPC7DUnU55nTECAHeIxeHhQXo6drrtXriDUcTdvwVCBbkJRRz6xcx6DgL4uCMF19SRQCQj8UlFHGRcAGmOrbD14CiOfuj0SUq33CfMhhBWPcj8K3nlXQJzwfgXiE1cHYYWqwOW47JNQ0SD+4V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TenAwvtPHPyjkQVnmFwQHdi6PY7bWEO+mjNf6Sn9xk4=;
 b=nF2K/VI3bm45Ry8yQQmXm+Lqla45oGd5QIhiwN+wsh9wXPmtC80uqI/9ErqIny4LseuEWajvWe0a/g5olGQGKSTbXDygeYsGsPQOX0fmKExzb/djdQoB1MIgL8JyRtJhQ5G9RqoIAp9TqZy/1wXPOIL3Hk2+9TqWFXYHY72x5n+s9tgU73PGITuofdSTDAsMaghwZiFzvlBAFPFhrz75b4R9IUE7lA4eXkz/1PFWn+gakmbi2yL1vPFrwW6sZIuQj7iEDiRN6m9wTC2fW00tQWxnMtS1JTQKkT1oQNYacnPOc4pl9o/W9ODQX3Rcp5XmaousWhmo3/4F0jASlfb4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TenAwvtPHPyjkQVnmFwQHdi6PY7bWEO+mjNf6Sn9xk4=;
 b=rk8fUNLFB1Xk5elEkX8aryBZziAhOa5h4RqgiusgBy2SehoxB0An0yZ7ddoTRRo7auInZHTY2y2XSwMflvtQuljIyIJrV0pOPaFh5Wn4rv8FYhoGd4NY/6SIyQ/kHh9F15B7zQO/S9CaEPX0nQmhpZXebHrz/0edA0n7aZloLUg=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8841.eurprd04.prod.outlook.com (2603:10a6:20b:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 25 May
 2024 00:51:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7611.016; Sat, 25 May 2024
 00:50:59 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index:
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYA==
Date: Sat, 25 May 2024 00:50:59 +0000
Message-ID:
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
In-Reply-To:
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8841:EE_
x-ms-office365-filtering-correlation-id: e64c821d-d94e-46a6-308f-08dc7c54beb9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmkzREZqUWErcVA1T2E4NDNvTTlLamxQNzI1Q2FNVHhNbFB2Z2pWdVNIZjZw?=
 =?utf-8?B?bXl2dU1mZzVYNG52ckNpSmdIZUwvd3czeEtrZGk5bEZGUDRlc0ZWeVpOeGcx?=
 =?utf-8?B?a3k2Q2dwRkwwUFYyNVQzTFlLc3o5VEtyaFNKaE14USsvUEUvaUxMd3lhaFE3?=
 =?utf-8?B?UXYzNW05NWx4Z2g1YzNUWmVBbjVsdUQxek4wQkRFNnFjMTViS2l6QkVQQi9k?=
 =?utf-8?B?Ujh4SDZYOC9hb0gxWG9HWlNJVEdsckRaUDBmYld6WDZ1RFo0UlBEalpCaHRt?=
 =?utf-8?B?UlgvVTBNcXE5TWdiR2YxRTA2MVcvS1NNZDJySnpnbW1DeG9qSUFBM3dXNkJO?=
 =?utf-8?B?Zkh3bnhBd3htQVhHUGJrb2VQQUNqV0tLajM5dVROZnpDUTMwY3Z5ZHdSZW9w?=
 =?utf-8?B?NlJHVVNUV1psUzU3RkhVQ3lFSzVlU01rTmlEcVBzbnNRMW5MNFZsMGV0Mnhr?=
 =?utf-8?B?Nk1kOGE0QkxHTThmTk03OUtSUEU0UmwzL1VCT01tQ09QbUo2UzdPRkd5OVpV?=
 =?utf-8?B?UTdNTnJlbG90SlZCWjYwdTJhNEo2a2lSZ1pFdWROaW5rRGNTa3A5SC9HRExB?=
 =?utf-8?B?RHd5MUVPY1pBeE8wSTZRMk1waERzSE92cFVQb1hBelIwUm5pUUJwdXNYckhE?=
 =?utf-8?B?MzBhck1CNWMxcDJsY0lOQXc0TkZJdWVzUXU1eXZ0eGxWSWFzdjdoSDY0RU5n?=
 =?utf-8?B?dExXL21oaTNZUDVxbFEyRTBFVGs4MGhKQUFnOG9zMXJNVFJXeGVrMm1acUF0?=
 =?utf-8?B?TW9ZSCt2N0pNU2tmMXBoaGRuSnUwNjNFa0oxN2JLdWhGZ3J5Q0VnZ05ZTnlR?=
 =?utf-8?B?RThxbml3VVM4d1JZMDcyR3VKRHdEMS9XeWtLVzBDa1ZNaU4xOXdrMWZYUStE?=
 =?utf-8?B?V2JPdnhwbmFhNTY2eTgxOTl2SUd6WDdYVG1URGoyVG1vaFZVcTZaQlZEVVBt?=
 =?utf-8?B?bUlVS2poNmNPSGU1clNRL2NiTExKOVhIT1NCQzEvNHI2L09WcmhlaGJoWUpt?=
 =?utf-8?B?WVU2T3gvUVY1MWZ5VVVWN3dqaFpBNEdWd2g5ajlxNUJoVGlSSlZMOFlaUlI1?=
 =?utf-8?B?SUc4cTRLVHZjSHFBeDluTFVDR2lGRlNFWEFyUGJhMFF3ZzRvYVhoTGRYU3Vp?=
 =?utf-8?B?MlZtZndzcnE5Qm02NytvaTJMeFJNZHlvTW00MjVkM2dQSGtHbE54T3liUHEw?=
 =?utf-8?B?djVISUNSQVFuUnZnNXozMlRMVEhyMnZyS1VuencxcVlJQkd5UU9qM2xRdERa?=
 =?utf-8?B?SzRIMHdkTWNCQ2J6dDFWSUpzMEoxLy9OLzRRMjcrNnY2azlqSWVkc0twVHN3?=
 =?utf-8?B?cndGbFMwclIzaU1wNnFDTnR6T1ZXcmRyR3FaSkFPWXNBU2Fvdm10TmpTaTd3?=
 =?utf-8?B?SEJOdkI5M2QvV0RZdDQreG1WZXRZanRlWVozTkRtY3lIMUZ1bzdQM0Jka0kw?=
 =?utf-8?B?aHo2L092MTAzS0dZYTl6dk1uMDYyVjhPL1BGTSszSjlvRzUwUXhaVzhNRHha?=
 =?utf-8?B?T2lkb2REdXBaU01SSlJhSSs1ZHBERW1BUjF1RkkrMXNBWEY0WnVKZzBmWWtw?=
 =?utf-8?B?c2FKcVBZalJuTXJOZ0xsRk11VDdqL05OZ3ZTcTlNUzhZM1dYZjdOZUtyWHNZ?=
 =?utf-8?B?OFBiaDFtZEsxcWJDOU5zcFJlbWd5ZStkdkVsNVl3UEorYWU0VEp2aXNZOXA1?=
 =?utf-8?B?M2Z4Sm5WcnA5N2xlSzZxY0NINHV0STF4emk1eHZSZFNKcDgyWkIyZzBDNUJi?=
 =?utf-8?B?b2tLUy9hVkhOOHQ3dmFPclhmcFVXT04wTk5YMGdiZlVqTUEvUkJlZnhaSTMx?=
 =?utf-8?B?aGE2eXJ1QTFMMFh5bFFzZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHBvdTB0c2NMZUNtYzJwdkRRbmZwWlpFOHp2MjhBQmt1VjhwdmpFWDFoRlJj?=
 =?utf-8?B?S0FPbGNlVkU3a0JvOWJnYkFNcUh4aUh1bEt5RGcyU0lGY0hJWjhFdFdSNFc2?=
 =?utf-8?B?WkVXank5bHJpSTlkSFk5OXhhTWlNSzlqOUt4RmlpcUJwekVjcm9BNzEyWUdn?=
 =?utf-8?B?bCtuV1pubS9YOEk0ZXdWRCt0dTBmNlZia3U0aXBmSXpBNFV5Q25TeHJkOTYx?=
 =?utf-8?B?WjhCT3Z5R29saVpEbnhZTDdtUjVsOTZmWlo5enc2cFp6MStMY3dkbFdSck9R?=
 =?utf-8?B?Zm5JWUkzU2xmL1B5aWw2N3JUNlpiclpVVmM5ZHAySXJNRmRGL0c5Mk1jMUxY?=
 =?utf-8?B?SE81UWdhbVFOK2QvckVxRVlFeW1MNE5BcFNDcEFnenp0VDFNY1hjUHFzdXpV?=
 =?utf-8?B?QjlTQWtkamhrUGdTOG5zRG9xRDRlb0Q0N2dEWlQvOUNDYjVRY3hpclJxUTZq?=
 =?utf-8?B?Q1UxYlBOZ0lXb0xlUkZ2VEVYQlFHelJiM3o3bkRRTVpiaDlOWkorczFUU2sr?=
 =?utf-8?B?NnNreEhSRkRPcjB6SzBzMVIzRG5HMTNkb1ZxaWRRR2V0bGx3SEpPVC9FSDg4?=
 =?utf-8?B?U2tuMENmemozT1E3eEVtSDRZT3JoenYwVXVlbUU2WWZlUngydzlXOGlmSDg0?=
 =?utf-8?B?Z1owQThUN1BSNzl4T1pzSzJQSC9mVkRwQjhiNGZXVjltMnF2TUVIZnMrNUpK?=
 =?utf-8?B?MFBaTDAxN3ByOFRqVllIOFBTV011VnRkRXNaR0xEUjY1MmlzREEwQVBKZExz?=
 =?utf-8?B?ajJPWmFBbE9mY3diQzhxeXVEcWhob3I0cE9kZS9yMTNiRmkwTnRnTW4wQzdU?=
 =?utf-8?B?alFBS3d4Y1lkbENrTjFVdzBoZ0Jqek1EKzl4S2djWHZVQ0dTRU9yWXcvbzRE?=
 =?utf-8?B?VUM5VFBubGxrM1lNYmZudktKVUR6RytuUTZvVmR2Q0NKcTMxdG1WRC92eW8v?=
 =?utf-8?B?eUZEb3QzL2lmaUZXT2JFd2N4eHNRL0lOQ1ZaeWRBOUxwQUFsOGZLV3RCT1Zn?=
 =?utf-8?B?SEU2S3lLVEJrSlBRM1I5Y1Y1SllKY0w3dkx4QjRmUUZpdVQyUnYzYlpTa3A2?=
 =?utf-8?B?dWIrRG5JTzlzTHpaaEhhVmw2Vlh3VHdiOFkvcjR3S2xiTGI4cFlnM3hzeGhh?=
 =?utf-8?B?WmJCZ1hrUlNPMzVDcVBrMTIrVmJBdTN3Y0ZNSUFlZDJoVCtwajJ4K1hYYmhu?=
 =?utf-8?B?WDVJbTJ2WXgvd0I4bWxQcSszbmxLYnE5TE1VNVRWdGdJbHl3b0doZENEQmFX?=
 =?utf-8?B?OU5hS2pMWWYyL3FlNmwwWEc2b1lEOTJiN0lzZm1GcUVnbmp2eUdqdCtVOG55?=
 =?utf-8?B?UGVwREx1bWNOL2Nhb1FrTXNSdC9wNWp1VmEvaDg0T0hNQnBFQ3lFWU5MZXJG?=
 =?utf-8?B?YlZMQml2QzdXYXhCa09Ubm5QZ0hFTm1yQnpnN3lRcnRaalJaaFZHMEY4VnAw?=
 =?utf-8?B?Q1BldUFPUzlMWjI0WVJIRGtrYUhBaWd3Yjk2Mlcrdm0zSi9jQ1JZc3Z0Rk5k?=
 =?utf-8?B?WndSQzRJbENEcFRqbFF6R3FlR3NLbmF6NGdzYW9mN0NEWklHajZUYlNwZHNQ?=
 =?utf-8?B?czJuR2xPTEZSdGNZOFpmK1VLUUVRWjl2TWF3SXJUYUhHYmE0ODRGME9vVkxw?=
 =?utf-8?B?SUF3RzU2blIwV3FPQlNBNkhiaVh6WTZoVmZLaEpneXhnQW0zZzFsbGtNUTdM?=
 =?utf-8?B?VXpkY0IyZDB3QkZFUjdHR0liT1piQmlPeHBQR0h5ZUZYQTdZa2sxUDJDWGxh?=
 =?utf-8?B?Q2k5ZkYvQloreWFiQ2dCeUFyVWVib3ByQWg5WUw2OEdhTFpTOHM3WDlYMlhT?=
 =?utf-8?B?UStUYy9POWRSZSt0RVZRUldNMEl6eW9sT2o1a2Y2cVB0R1RsVjFRdHJNL2Jq?=
 =?utf-8?B?djJVQmhBTldCOFZTTUFOWXZKMGx5b3RNY2pJZzJDNU9VU0dDR1hrRmxoMnho?=
 =?utf-8?B?NjFJRndtRjJLRFZHbWtMckc2ajBwT3JiakxrMk1GSk9rbUkzSk9jaU5xeXkz?=
 =?utf-8?B?WTZyTnNSUjFWcnlQUDBlcERLU21qQ2RrS3pUc3JwL2kveXk0VnBPTWVybFp1?=
 =?utf-8?B?ZkY3ejlHUG9wU2VlMjFvdGRXTTZMZzVOUnRGcHBGUEdFbTJ3RHlGMXN3SGpY?=
 =?utf-8?Q?MozMCj+jY4XMLcyRyOjjSOmsI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64c821d-d94e-46a6-308f-08dc7c54beb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2024 00:50:59.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBtDkJKdYv8qk/6TYvIWNXZFbug4qDCOC3KaicAb4Sgs+D5aBFJsbPrdScw9ESQFK+d0/MGkgayf3ksaS2T9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8841

SGkgQnJpYW4sDQoNCj4gRnJvbTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5v
cmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjUsIDIwMjQgNjo1NSBBTQ0KPiBUbzogRGF2aWQg
TGluIDx5dS1oYW8ubGluQG54cC5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGt2YWxvQGtlcm5lbC5vcmc7
IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5oc2llaEBu
eHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXgu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MTAgMS8yXSB3aWZpOiBtd2lm
aWV4OiBhZGQgaG9zdCBtbG1lIGZvciBjbGllbnQNCj4gbW9kZQ0KPiANCj4gQ2F1dGlvbjogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUg
bWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0K
PiBPbiBGcmksIE1heSAyNCwgMjAyNCBhdCAzOjAx4oCvUE0gRGF2aWQgTGluIDx5dS1oYW8ubGlu
QG54cC5jb20+IHdyb3RlOg0KPiA+IEkgdGhpbmsgaXQgbmVlZHMgdGltZSB0byBzdXBwb3J0IHBy
b2JlIGNsaWVudC4gQ2FuIHdlIHB1dCB5b3VyDQo+ID4gc3VnZ2VzdGVkIGNvbW1lbnRzIHRvIHRo
ZSBjb2RlIHVzZWQgdG8gaG9vayBwcm9iZV9jbGllbnQoKSBhbmQgYWRkDQo+ID4NCj4gPiAiVE9E
Tzogc3VwcG9ydCBwcm9iZSBjbGllbnQiIHRvIG13aWZpZXhfY2ZnODAyMTFfcHJvYmVfY2xpZW50
KCkuDQo+IA0KPiBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB5b3UgcGxhbiB0byBhY3R1YWxseSBp
bXBsZW1lbnQgcHJvcGVyIHByb2JlX2NsaWVudA0KPiBzdXBwb3J0PyBEaWQgeW91IGFscmVhZHkg
ZG8gd2hhdCBJIHN1Z2dlc3RlZCwgYW5kIHVuZGVyc3RhbmQgd2h5IGhvc3RhcGQNCj4gbmVlZHMg
cHJvYmVfY2xpZW50IHN1cHBvcnQ/IFRoaXMgc2VlbXMgdG8gYmUgYSBjb21tb24gcGF0dGVybiAt
LSB0aGF0DQo+IHJldmlld2VycyBhcmUgYXNraW5nIGZvciB5b3UgdG8gZG8geW91ciByZXNlYXJj
aCwgYW5kIGl0IHRha2VzIHNldmVyYWwNCj4gcmVxdWVzdHMgYmVmb3JlIHlvdSBhY3R1YWxseSBk
byBpdC4NCj4gDQo+IE5vdyB0aGF0IEkndmUgdHJpZWQgdG8gZG8gdGhhdCByZXNlYXJjaCBmb3Ig
eW91IC4uLiBpdCBsb29rcyBsaWtlIGhvc3RhcGQgdXNlcw0KPiBwcm9iZV9jbGllbnQgdG8gYXVn
bWVudCBUWCBNR01UIGFja3MsIGFzIGEgcHJveHkgZm9yIHN0YXRpb24gcHJlc2VuY2UgLw0KPiBp
bmFjdGl2aXR5LiBJZiBhIHN0YXRpb24gaXMgaW5hY3RpdmUgYW5kIG5vbi1yZXNwb25zaXZlLCB3
ZSBkaXNjb25uZWN0IGl0DQo+IGV2ZW50dWFsbHkuIFNvIHRoYXQgbG9va3MgdG8gbWUgbGlrZSBw
cm9iZV9jbGllbnQgc3VwcG9ydCBzaG91bGQgYWN0dWFsbHkgYmUNCj4gb3B0aW9uYWwsIGlmIHlv
dXIgZHJpdmVyIHJlcG9ydHMgVFggc3RhdHVzPyBBbmQgaW4gdGhhdCBjYXNlLCBJJ2Qgc3RpbGwN
Cj4gcmVjb21tZW5kIHlvdSB0cnkgdG8gZml4IGhvc3RhcGQuDQo+IA0KPiBCdXQgaWYgeW91J3Jl
IHJlYWxseSBwbGFubmluZyB0byBpbXBsZW1lbnQgcHJvcGVyIHByb2JlX2NsaWVudCBzdXBwb3J0
LCB0aGVuDQo+IEkgc3VwcG9zZSB0aGUgVE9ETyBhcHByb2FjaCBpcyBhbHNvIE9LLg0KPiANCj4g
SSdkIGFsc28gcmVxdWVzdCB0aGF0IHlvdSBwbGVhc2UgYWN0dWFsbHkgZG8geW91ciByZXNlYXJj
aCB3aGVuIHJldmlld2Vycw0KPiBhc2sgcXVlc3Rpb25zLiBJJ20gZnJhbmtseSBub3Qgc3VyZSB3
aHkgSSdtIHNwZW5kaW5nIG15IHRpbWUgb24gdGhlIGFib3ZlDQo+IHJlc2VhcmNoLCB3aGVuIHRo
ZSBvbnVzIHNob3VsZCBiZSBvbiB0aGUgc3VibWl0dGVyIHRvIGV4cGxhaW4gd2h5IHRoZXkncmUN
Cj4gZG9pbmcgd2hhdCB0aGV5J3JlIGRvaW5nLg0KPiANCj4gQnJpYW4NCg0KWWVzLiBJIGtub3cg
d2hlbiBhZ2luZyB0aW1lIG9mIHN0YXRpb24gaXMgb3V0LCBob3N0YXBkIHdpbGwgdXNlIHByb2Jl
X2NsaWVudCB0byBjaGVjayBpZiBzdGF0aW9uIGlzIHN0aWxsIHRoZXJlIGJlZm9yZSByZWFsbHkg
ZGlzY29ubmVjdCBpdC4NCg0KV2l0aG91dCB0aGlzIGZlYXR1cmUsIGl0IHdvbid0IHJlYWxseSBh
ZmZlY3QgbWF5b3IgZnVuY3Rpb24gb2YgaG9zdGFwZC4NCg0KVGhhdCBpcyB0aGUgcmVhc29uIHRo
YXQgSSBzdWdnZXN0IHRoYXQgd2UgcHV0IGNvbW1lbnRzIGFuZCBUT0RPIHRvIHRoZSBjb2RlLg0K
DQpEYXZpZA0K

