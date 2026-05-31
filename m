Return-Path: <linux-wireless+bounces-37189-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ylbhOYfgG2rpGwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37189-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 09:17:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D7614CD8
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 09:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BAD63028E8A
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43541DB13A;
	Sun, 31 May 2026 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="fwYglW0x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2473033EA
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780211843; cv=fail; b=CSGjH++DE0c5znFCICSni/XTB+KiZGU1Uh9E2AggupDdHZge2LvvucQe21dpn8whQ0kEyUHWWj8nMghxbt4n1Y156TV/fN7InaWiMfAce5kVaP1Rq9uGqbk5NYBQQpX2TDtudiErAl9nKyZF5oB94Ai2zyuGMuCggkKJFXDkDeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780211843; c=relaxed/simple;
	bh=162fbMIicn8NY1faM0zgNITjd1DVbJ1jdQp+N6Z6oJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFw6f+PDzsWLutwikLFB8X5FDTMBWx/WQhuiyk9Xfb90PWewpsDQ4HYYJuPqCgkiaKzJqoi0orVXJ3b7YgrE8d1cZk2B40xX691folfHc3ejnmTs39o4RXPamNsI+D03iwstuSDnP5T0zyctkRBkewMDcrS9/JTZ6y72Ks/JDaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=fwYglW0x; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V45hUI2465309;
	Sun, 31 May 2026 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=162fbMIicn8NY1faM0zgNITjd1DVbJ1jdQp+N6Z6oJI=; b=fwYglW0x5pZx
	JYMMf/hSrlvCteNYmJYDViKjo57kDWO5VpDzcXFzI8lX8ajWyKxqM6aftuo063Go
	hCApTDbWsoLvbPBeVsi6ZpEIWJVD+JCeKGoLM7+tV/+Dsa7NCUmeHvUayMy26rd9
	6jvzlliSgiNjeXO8/81FfJ6EKLc4n+In8YibmaHVgP1Rp86XWd4T3iGRvbNRPgzC
	fhmyozPrVN4lOeHItWkAieP+leGVwbzPvNc22PLc/PyBKe/ISJwpQ7WqUDPTh4Gr
	sdkONvCWQM7tQwqO7PqGLdx+bEj+87yjtZzy4LKHQLuxgJN0bJS6QFO3VzwvQcxU
	p2v/1wnNUA==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013019.outbound.protection.outlook.com [40.107.44.19])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4egdnjg3xx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 07:17:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxazaVfjWySHAv2O5dmjn0ffIP+7/bFMwpdFoqusZVGSBKcCHKIcIe+ez68OSlbNEHs77dyqik2Hu60+EFoRDlzHvJXW3sbTUf+kp4PAzYFvWCczUx/hN3uIuOMW9vLxmi6X/s2m+uj0CJXMng9T9NUXdkLj42gSNJDqEHSNk6YXsgeg8jOQ6oGhVawzimEHAf+/adizng7HI1f/r5BHMo+qImHBOmLw7LjmwMVi4VZD2MTUYlQPWF+XV5WiXNWuNq+TutYZWpxxs/Xado0cXLpuL6Be6JGOc8/DXZe74dQJDDd1qmN1eRNoU6z28gxEEieYAgrsweeoflkUXGD1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=162fbMIicn8NY1faM0zgNITjd1DVbJ1jdQp+N6Z6oJI=;
 b=FXhrPpx/tcAB1g5PkHC7euIL/pLdZXcRJ6YmRdwlryxiZySzy+u3OWacjpbf6TssnFcGPG7bI9H9fRsWddaFECvWlC0Ybm/yW4Z2438iEE1SxxTdEVX1Vgce8PMsHzZ4wEwFGRuT3uz/KLxxlcYs5XJoSZVNqlRP8G6TkIAOKEn8I32W4xHpCmt8djRnwbmVbgMoXmDhinmx/ySDC52RQQ11qwm655sZ7bBmQnT1m3q3nJGVYob5/WHf+tBFPcwcwNgi5vaGL4L+DSKsfGaIqK+a+9yOAOfgfTOMXSeWtCS42RSlSHF26LZauw1GxJSdJNqLuJvRbNEOWm0/WLVuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TY0PR03MB8247.apcprd03.prod.outlook.com (2603:1096:405:10::8)
 by TYNPR03MB10108.apcprd03.prod.outlook.com (2603:1096:405:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.6; Sun, 31 May 2026
 07:16:57 +0000
Received: from TY0PR03MB8247.apcprd03.prod.outlook.com
 ([fe80::1d8:7622:b6b1:7036]) by TY0PR03MB8247.apcprd03.prod.outlook.com
 ([fe80::1d8:7622:b6b1:7036%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 07:16:57 +0000
From: =?gb2312?B?THVjYXMgWVEyMSBYdSB8INDs0+7G5g==?= <xuyq21@lenovo.com>
To: Johannes Berg <johannes@sipsolutions.net>, Ren Wei <n05ec@lzu.edu.cn>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kilroyd@googlemail.com" <kilroyd@googlemail.com>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "yuantan098@gmail.com"
	<yuantan098@gmail.com>,
        "yifanwucs@gmail.com" <yifanwucs@gmail.com>,
        "tomapufckgml@gmail.com" <tomapufckgml@gmail.com>,
        "zcliangcn@gmail.com"
	<zcliangcn@gmail.com>,
        "bird@lzu.edu.cn" <bird@lzu.edu.cn>
Subject: Re: Re: [PATCH net 1/1] wireless: wext: export each WEP key size only
 once
Thread-Topic: Re: [PATCH net 1/1] wireless: wext: export each WEP key size
 only once
Thread-Index: AQHc8M136Vzhe0YUpEqkT+cGFbnPDg==
Date: Sun, 31 May 2026 07:16:57 +0000
Message-ID:
 <TY0PR03MB82478F512E58630BCD9B0E86A2142@TY0PR03MB8247.apcprd03.prod.outlook.com>
References: <cover.1779632308.git.xuyq21@lenovo.com>
	 <a039d8a18fa47ab9fce851b7f42cdadb62e54ba9.1779632308.git.xuyq21@lenovo.com>
 <1a8bbed215d7f6027d56ab42cf8f6e742d1e7fa1.camel@sipsolutions.net>
In-Reply-To: <1a8bbed215d7f6027d56ab42cf8f6e742d1e7fa1.camel@sipsolutions.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB8247:EE_|TYNPR03MB10108:EE_
x-ms-office365-filtering-correlation-id: 2ff8a0cc-2147-4481-cd63-08debee499e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 rUYTQzCu+gk7Bz24C9NjlNjD/f0qMtT1njD/4Fhnm1akXqRvF8gKlnmuAyETjYE5wUH9dib0yUI08EH6/FcIFz7pDcTJ9lEV6sdu3eJbaANs6kxHiBfnGz9ZabDZ9JOLgT2sYKk3EUmpx5hIkSJjxOX7NPbiJagVAyW3vXmqHFY0zb3tdcWOl0/DEZNstFA+nTshPswYBW64QrdVnlDq6d9CgiCt7EkoWxlziTzAPQdVuEJoGi/6Qyh73dpG/ptL5XDBSQWs2PykLaZ4Fwbh1hg0CZCDvuaA4Ja7hIp4mpbXEWlfQSzkScFyKHMMR+w2FdWJ03Z+s1hq7f9LMYfZosd/0rxMMuUtE9YaLgWUohUKK0V1YxLjOZDmf3/f7Oef4cxmQu5HCH0UAhkLmfZCBadZ5VhPZngP9++nQUL0eXxyQOOQcfLrvD/iyskBVYLE9oUViKY1EwdG+i+pwSZv3IgAWqrLe1YS3mjm/SfULXQKo+Kqoh9YbN0Tcg3oVYaL1aAcPXXomlIGXliRXHuTDNhMyK9/YkvlPqlrQeaZWPRmpz+s5NEE5fXgb0yLcd1i0mI5Yu//n2rag1ldgsMYESIejIWNwO3j/u+Nr6Y5VZv1Mxnau3ppkTOeKUlHkP2bjqtFcXLb2a2g5JUwA9e93whSdKedL6YpaqSqk9dm533eFAB52fqKow6MZ7HTk+63Qcy5joZ853hcom0wMrCjrXs3/R2v56doB+lw+BbNcPMmnf0IAfq3YOHkHK1FD07R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB8247.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SEpFQWpORk5PV3RrVjU5Uk5qR3V3eXh6OFErRE5GaFY4TlhpRWFvdWlVbEFU?=
 =?gb2312?B?REFyc3k3am80dmtMRWlBQnNCemZRb3Fjb3VnUjVyMUdTakF4M1NZN2FHYVdo?=
 =?gb2312?B?K0tuRU93MUtXUWZmZXpuRUY4cjNZYlNFdGRpRzBWR3JFaWZ3KzZ6RDVsd1BU?=
 =?gb2312?B?KzBPRGdZWG5yb2x6MjFvc2VFVHlWSVNuTDFhTzFRR0Uzc1dtdnhoMjY4dyt3?=
 =?gb2312?B?YjRLT2hCQUFlQStSa3J0aUNaRHIwMGI1WC8waEtDcHZWb0RZMklIbmVZR2JB?=
 =?gb2312?B?NFBMNDhvWko2RGQ5Uno0WjlxQy84VHkxRFRoZmR4RHpsMnlqQnV0UGZOQ0hQ?=
 =?gb2312?B?OGJ6bVhFYUFOaHZaeG1oYTdQaGpOM29yM0NDTE0zSFJhQ2pxMm9Gdkt2eXRl?=
 =?gb2312?B?dVd0VVdnQzZsL3lyRFRoV0ZhaXZQT29vcGZyalpFKy9oRG80RDFiSllSUy9t?=
 =?gb2312?B?aXllcXpZdGpqTTh4NG9WZnFGUjFnL3h6TWJZUC8rcUtCUUUrdFhkVGRvbFpN?=
 =?gb2312?B?VXk5cmI1SklPMkxVbXRFVFdiZ2l1L2swU20zbFZZdWoxb1JCR1FjU1psSWRM?=
 =?gb2312?B?b0VtRlBndFdYbTZyVDlLbHhTcFNXc0xQbXcrMGRKakdIUm5vMnJvalAzRjRw?=
 =?gb2312?B?KzFmMnBQdFR4WVo4WDJJY01mMDFlTGFra0hTdmlPcGxNVXA0dU55VEx5aklH?=
 =?gb2312?B?eVQwWUxIRjdYUktuUFU3Zmg0V2Q1Ty9DRTd1UVczVnlPVXlUYTByVWtsay8r?=
 =?gb2312?B?Rk1KVEhBTitlUGdBbUx6Yy83RU9sNGdHVGgzVHdDT2dpUERkcDdTbnNCV2Za?=
 =?gb2312?B?c3B6cVFGbVkzZy9DUVFVcnc1V21qVHZKbmQyVzZoekoxQldGNi9EYUlXYWtW?=
 =?gb2312?B?TTFzNFk4YXlQaU00d2pjT0pMUGRlaXZ5YUJUZGFiazlmQ2dzYWdHVUdCcjdq?=
 =?gb2312?B?M21rUGo3NWlSTEZQNlBtU2lLL3VkYUxQd05nME0zT3EyZ25PcWRjN2tVak9p?=
 =?gb2312?B?OXM2MUltRW1RblFGd0twQ0VxU0Y5d2U5TE1aZ2g0cXQ3RGE4NTVmbVpjb2cv?=
 =?gb2312?B?d293SVg3Uk54NVVXdm04LzN5aVpYUzB2S3lLcEdjM05Ub3ZFeVJVbzI2emc5?=
 =?gb2312?B?V0Zibm05dmdmQjFYdDg4QVE2cDNoY2ozM25UZnFqWTE4VG9uN21zT2h5bDFJ?=
 =?gb2312?B?NjQxZ1k3ODVXY00yV0lsTUsrVFVRazVBbmIydkJCVWw4RHNlZFhqKzdKRjhB?=
 =?gb2312?B?cDVqbkNlS3B4WVEvT1dzK0ZSbXZZNnJOUGEzZTdJQVd2elRoVWJlOEh0MGp1?=
 =?gb2312?B?QkltOGlEanN4ekhRU2NHQUpFcktPR2d4V2YxVFdmdmJ2aU9HWUxwTWZSV21u?=
 =?gb2312?B?NFljRjNqS1dVcGk5MVMrZkIzME11YXRBZmFoaVBuRjFIYmxWZVdWY3IyYWVF?=
 =?gb2312?B?M3JnejJKa2dqRXF2dHNrdFFxZDcxbnBNcGZMR245R0pZSXdjRUJITUptK3JQ?=
 =?gb2312?B?TmdnUkM4L09PeUU1R0F4ZGQ3aTlPM04vSk5NNVF2UkxtVlZWb0syVjlCSVpr?=
 =?gb2312?B?RVZnV0hsZjNHY1YzMnJFYjhrOEJWQVM2STVuRmxIdlhvcUhiUWIrQlZQMHRI?=
 =?gb2312?B?dE9tK3JsUU95TjVSUkY4VGFwL0pacWN4d0ZQRXMvd0lyYU5YcVF2MWtlY21l?=
 =?gb2312?B?cXdoektFalpQNGRmRGxFUUNwUGkxeTFBbnFOazN2VldWM25kM0w1bWhZUFZL?=
 =?gb2312?B?MlQ4bVNRdVlwcC82T3hFUzlJUGJueC9Tc1RsdFhBRTIwWGNsa0c3R3lMeHNJ?=
 =?gb2312?B?QTY0OHVIL0tENVBFV1hCZVcwa2pSWm9ZbVN4MHJJS01SMjJINkQwYTNyVkZJ?=
 =?gb2312?B?QnBDcEU2aVBTK2pHMEtFY21WajE5eE0waWhXVVNBL2hQZGVZZE56SjNjNjJP?=
 =?gb2312?B?aStGa1plY2R4VDhCS1RhNHFSZ1ludkNxaExZbDFYeXhsZm90QjY5NCt0N2Rw?=
 =?gb2312?B?MTlZSXlEaXJyY0FQdUgyNEs0b29ISFdKZ3pkY2c3RTZvc0dWUk9vZG50STBj?=
 =?gb2312?B?Qk9FNXl4c1liS1dib3gzRDFkWERnaTl5R1REYzhwazJnNHVWd3VhK0VPS3Nl?=
 =?gb2312?B?S1Z5WkFNU2VvRlBkc2FURFJoQ28reEFpUnFFYjRqL0hrY2RqejlTdy9JdkJy?=
 =?gb2312?B?ZFZTbERHWHJIL1JpKzNJekt3amR1bWkxendJMm12L0txNjI0OFhGQ1BLdTBW?=
 =?gb2312?B?WTR5ZzVVMVBveVo1Z2E4WUVpejR5NkRXOWNaelBrU0lvWmFyb3JGMVFwblFx?=
 =?gb2312?Q?N0p4vbPRLJmlreJj6C?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SkAqv746NBaakMnksLTWAWGxkSvsaoPsDlkWh83WIxUV4LKTFjWIH9L0zvnkLBuIjXJfLi1STdbM5yktq+78ThlXM78q2eqlpxJWH4AewMSULqqm3VX7QCeB1Gin0SbYQH7cSs/8YoDKnwjwv3Bnf7Ai/8aqCOFspk/FNJ81txVr/j9YvHXVARHzEhnxtTj7jGZbyTcmei10n7H9V5pkgFv9RsY2X61ruhlI8WLTVFubWOUoza2kFrJws7tBbiFQlGkiSe46HfKDkayXilWw7gABHYabEyqOOZCBvJx3Vm3nUkxWWF7ArO3B9dpkVFga3GGMkVy3peQR6mBQvDom8g==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB8247.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff8a0cc-2147-4481-cd63-08debee499e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 07:16:57.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTMOSbpZLT/v9CwFoZn3ECFdJxof0m5eJ45r9IUrvNIOyzxJEgCN14+W6o+WNLc56GA/gkXWcsMOmowKaYqLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB10108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDA3OCBTYWx0ZWRfX5z/Kd69LzzNi
 UymgggF1RBHMjbkSWrq3NFOrFxfZ3U5EICZDPDzQIbWsxSaKpiC6tXefuJPNk2cA3O8WVU7dXtx
 b1MeyWRmeCbI6I3RjaebH2bAN5fSy6DtzZe8I54KVSiBzbTk1+AzlxSmIY3od0OvYPA0Phj2wCT
 7/KT7bWeJPGpFtY8Vp9W0LhHh9V72ZQfTnxrg7ZjakK4Vy832/1JoT+RjBQklE6iKWonG1HISaW
 KUxRyVHAI8nCu5DBhVbvgsnVPK81b+AKpOMhmqyCOrELZaBrLE3y5RSTEwXcMGKCOrQPWNFzBxY
 EqsxXIOe24ygReTB2W5rRy9pQaQJE3oz/nu3vTquMsyxJh/8Ogq6iSfzBXT4Q38QlLta3kTbq42
 cX303Yfhlbw45l8JwPtkFfLeSDqDit6myjPwq4CcKYuCQBQP4Aqe/mO3yPo1dqGHRY4jYOe0wQZ
 oMLNpPaF0M+ZQs/WApg==
X-Proofpoint-GUID: 37tj40lKb5KKcf7eIIlhQ8bQoyi9su8_
X-Proofpoint-ORIG-GUID: 37tj40lKb5KKcf7eIIlhQ8bQoyi9su8_
X-Authority-Analysis: v=2.4 cv=BbboFLt2 c=1 sm=1 tr=0 ts=6a1be06c cx=c_pps
 a=VedXox5PDv7MRHZ09beFKg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=NGcC8JguVDcA:10 a=cHAot3JNSH0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2RTuljz969oO5usasWGy:22 a=hJVLCblJc-VYA0_z04R5:22 a=8k6WQxmsAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=dLpdNhwrMDr8z4aPMPwA:9 a=mFyHDrcPJccA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310078
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[lenovo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lenovo.com:s=DKIM202306];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37189-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[googlemail.com,tuxdriver.com,gmail.com,lzu.edu.cn];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lenovo.com:email,lenovo.com:dkim,lzu.edu.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuyq21@lenovo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lenovo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 602D7614CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ICBPbiBXZWQsIDIwMjYtMDUtMjcgYXQgMTg6MTggKzA4MDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6
CiAgPiBPbiBXZWQsIDIwMjYtMDUtMjcgYXQgMTg6MTggKzA4MDAsIFJlbiBXZWkgd3JvdGU6CiAg
PiA+IEZyb206IFl1cWkgWHUgPHh1eXEyMUBsZW5vdm8uY29tPgogID4gPgogID4gPiBjZmc4MDIx
MV93ZXh0X2dpd3JhbmdlKCkgZmlsbHMgaXdfcmFuZ2UuZW5jb2Rpbmdfc2l6ZVtdIGZyb20gdGhl
CiAgPiA+IGNpcGhlciBzdWl0ZXMgYWR2ZXJ0aXNlZCBieSB0aGUgd2lwaHkuIFRoZSBXRVhUIHJh
bmdlIGRhdGEgZGVzY3JpYmVzCiAgPiA+IHN1cHBvcnRlZCBrZXkgc2l6ZXMsIGJ1dCB0aGUgY3Vy
cmVudCBjb2RlIGFwcGVuZHMgb25lIGVudHJ5IGZvciBldmVyeQogID4gPiBXRVAgY2lwaGVyIG9j
Y3VycmVuY2UuCiAgPiA+CiAgPiA+IEEgd2lwaHkgbWF5IGV4cG9zZSByZXBlYXRlZCBXRVAgY2lw
aGVyIGVudHJpZXMsIHdoaWNoIGNhbiBtYWtlCiAgPiA+IGNmZzgwMjExX3dleHRfZ2l3cmFuZ2Uo
KSBncm93IG51bV9lbmNvZGluZ19zaXplcyBwYXN0IHRoZSBhdmFpbGFibGUKICA+ID4gZW5jb2Rp
bmdfc2l6ZVtdIHNsb3RzLiBUcmFjayB3aGV0aGVyIFdFUDQwIGFuZCBXRVAxMDQgYXJlIHByZXNl
bnQKICA+ID4gd2hpbGUgc2Nhbm5pbmcgdGhlIGNpcGhlciBsaXN0LCB0aGVuIGVtaXQgZWFjaCBj
b3JyZXNwb25kaW5nIGtleSBzaXplCiAgPiA+IG9uY2UuCiAgPiA+CiAgPiA+IFRoaXMga2VlcHMg
dGhlIGV4cG9ydGVkIFdFWFQgZGF0YSBhbGlnbmVkIHdpdGggdGhlIHN1cHBvcnRlZCBrZXkgc2l6
ZXMKICA+ID4gYW5kIG1ha2VzIGR1cGxpY2F0ZSBjaXBoZXIgZW50cmllcyBpcnJlbGV2YW50Lgog
ID4gPgogID4gPiBGaXhlczogMmFiNjU4ZjljZTIxICgiY2ZnODAyMTE6IHNldCBXRSBlbmNvZGlu
ZyBzaXplIGJhc2VkIG9uIGF2YWlsYWJsZSBjaXBoZXJzIikKICA+ID4gQ2M6IHN0YWJsZUBrZXJu
ZWwub3JnCiAgPiA+IFJlcG9ydGVkLWJ5OiBZdWFuIFRhbiA8eXVhbnRhbjA5OEBnbWFpbC5jb20+
CiAgPiA+IFJlcG9ydGVkLWJ5OiBZaWZhbiBXdSA8eWlmYW53dWNzQGdtYWlsLmNvbT4KICA+ID4g
UmVwb3J0ZWQtYnk6IEp1ZWZlaSBQdSA8dG9tYXB1ZmNrZ21sQGdtYWlsLmNvbT4KICA+ID4gUmVw
b3J0ZWQtYnk6IFpoZW5nY2h1YW4gTGlhbmcgPHpjbGlhbmdjbkBnbWFpbC5jb20+CiAgPiA+IFJl
cG9ydGVkLWJ5OiBYaW4gTGl1IDxiaXJkQGx6dS5lZHUuY24+CiAgPiA+IEFzc2lzdGVkLWJ5OiBD
b2RleDpHUFQtNS40CiAgPiA+CiAgPgogID4gUGxlYXNlICoqYWx3YXlzKiogY2hlY2sgaWYgdGhl
IGlzc3VlIGhhcyBiZWVuIGZpeGVkIGFscmVhZHkuLi4KCiAgSSByZS1jaGVja2VkIHRoZSBjdXJy
ZW50IHB1YmxpYyB0cmVlcyBhbmQgc2VhcmNoZWQgdGhlIHB1YmxpYyBtYWlsaW5nCiAgbGlzdCBh
cmNoaXZlcywgYnV0IEkgY291bGQgbm90IGZpbmQgYW55IGZpeCBmb3IgdGhpcyBpc3N1ZS4KCiAg
VGhlIGN1cnJlbnQgcHVibGljIGNvZGUgaW4gYm90aCBuZXRkZXYvbmV0IGFuZCB0b3J2YWxkcy9s
aW51eCBzdGlsbCBoYXMKICB0aGUgc2FtZSBsb2dpYyBpbiBjZmc4MDIxMV93ZXh0X2dpd3Jhbmdl
KCk6CgogICAgICAgIGNhc2UgV0xBTl9DSVBIRVJfU1VJVEVfV0VQNDA6CiAgICAgICAgICAgICAg
ICByYW5nZS0+ZW5jb2Rpbmdfc2l6ZVtyYW5nZS0+bnVtX2VuY29kaW5nX3NpemVzKytdID0KICAg
ICAgICAgICAgICAgICAgICAgICAgV0xBTl9LRVlfTEVOX1dFUDQwOwogICAgICAgICAgICAgICAg
YnJlYWs7CiAgICAgICAgY2FzZSBXTEFOX0NJUEhFUl9TVUlURV9XRVAxMDQ6CiAgICAgICAgICAg
ICAgICByYW5nZS0+ZW5jb2Rpbmdfc2l6ZVtyYW5nZS0+bnVtX2VuY29kaW5nX3NpemVzKytdID0K
ICAgICAgICAgICAgICAgICAgICAgICAgV0xBTl9LRVlfTEVOX1dFUDEwNDsKICAgICAgICAgICAg
ICAgIGJyZWFrOwoKICBTbyBhcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhpcyBpc3N1ZSBpcyBzdGls
bCBwcmVzZW50LgoKICBUaGFua3MsCiAgWXVxaQoK

