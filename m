Return-Path: <linux-wireless+bounces-10375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0029373E1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F1D1F25BF8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD252C182;
	Fri, 19 Jul 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="ckU+4WPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020098.outbound.protection.outlook.com [52.101.171.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA61C32
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369042; cv=fail; b=liFsMcRMzXJPm/W4fv685p9NGeSwX6hHljdbXNNGKNnEClUk+CBBv+9b0RrgS6OuTuKtPhApEYDC4lqKzXtGJY1dGykk1J6YO3oWlFP2EYzRAbGX+2xNbBFRhEjq2vMBEoSC7pT6HkXlDBs1RB5YZXUEtZblIfVidKRSFG7CkU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369042; c=relaxed/simple;
	bh=rBG+AeT9M82z4CdF3WxCW6tb2ogHJ3u4zVV/zz8U5ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zh3ILrzN4GsrurJwj1klxWyG1pHcauENVKfQ9bvZZC3c3HNKJRhyBE2UvstLeKH0JtlT+ooJdKVR3KWVUB4/5vLrUEP8cKLzukWA7ZEn8geToPWoxqGlrbYYf4YH+A/PxZBzwcv7R9RzrGKxQh4xupwPmiFZn1zDXXZMzn+bm+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com; spf=pass smtp.mailfrom=softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=ckU+4WPN; arc=fail smtp.client-ip=52.101.171.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSYgdQfZbdtWbaoOBO1ud025hoRrdLw2zHpiQkfdEiw+zX6HXpevvFSEocfaB+Fihqf/zDDx8BPc2Hnt3dzRPbTMXA9MhvPDc8nwd/5z+cIyjgZPwtTwwMU8ezECFReqhKLUZ/VZhDPuHTHQUXLl8Mw+OrG2TM9E+m6+aP2+PFnmKPjclLF522ascbeQ5DvYiNJ4HxxsK8BqxKh50DO5gFFQsoSJhwPcy6nWlD98LnzRplvRJpOaLvpeDzr4MUOeMNrsva+k1+4XOzlpMTQ0CcGupHpWYFSkJnnNibISaNw4Ocn3WkhrERzwsqCA4J6IEAnM19jnG+XcR+jvVPYCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBG+AeT9M82z4CdF3WxCW6tb2ogHJ3u4zVV/zz8U5ko=;
 b=MzndLcG4jBjkEl5EIkZwhGW+OgOJYk+gmeDxasw9GGtt1CJbGuEP8ruaZtVJ00w81gxcPreO/tXMVHQabcqY4VDskSAbbC9eJZx1VdjqhH60ZtUqzrALEfc5ugJW03LRFjMqcmQILAw77XZxFGKwqGX4a4dTnHfYhbPnyCJVmX0/FEzNJwrd7ruoL78IbecYMbrN5GtoMPw/kC50hbEOmJ0rUXJ+CYhmA6d0T0LOO62OxanUfZgViKl50FgZiV6oXbhAHL6DPmrvgyhl/n7FdF5c1EACBJAAjSqgt5rCTsogYuDBkGZHruYJhrXwdwKwfUGfa2ekqyjbHjaW2z++kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBG+AeT9M82z4CdF3WxCW6tb2ogHJ3u4zVV/zz8U5ko=;
 b=ckU+4WPN16PVkbdGHQLP2D+C3bYsIPQgJeebQbf5dwvHrlXGcMNkBQyurR/u9ZPVMDm6LoX/3ksCNM8glCYtB/5262ar/sQR3NAo4yxBi6mdlHx8VCftem4P75HGH5hnwugrZIJoSP6IayGBRQA+JxQ8azHz9KcEq3hcclyJt0Tb4OhMSHC/isC4lE0OYZWWoeGB7/onwK150N3aOsEtRs1jSQjj+YY4W8WyxcJ5BuTaG2i7AMXe66SjMQIKF4ckONenGhCo0X8US2zbFgUZHULu9XH5yVeVmXyN1k+BTefK1fUMnwjOsZXW5QT2eYwgV6xF/cPsIjynNH/4YJrSLA==
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3a::5) by
 FR6P281MB4876.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:155::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 19 Jul 2024 06:03:54 +0000
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2]) by BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 06:03:54 +0000
From: "Jesuiter, Henry" <henry.jesuiter@softing.com>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: AW: Performance of Reassociation 
Thread-Topic: Performance of Reassociation 
Thread-Index: AQHa2EeueyCxNvdWakyDpuL0/ysvurH8K4CQgAAv1i+AANfq8IAAXlye
Date: Fri, 19 Jul 2024 06:03:54 +0000
Message-ID:
 <BE1P281MB221074E53D2D150EBC4EC1C39EAD2@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
 <ef8f3c47b3264aedad776ff248fa635d@realtek.com>
 <BE1P281MB22102E859A8EFF4475843FB89EAC2@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
 <d28a43de3a2c43a4882696b6fc87747f@realtek.com>
In-Reply-To: <d28a43de3a2c43a4882696b6fc87747f@realtek.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2210:EE_|FR6P281MB4876:EE_
x-ms-office365-filtering-correlation-id: 1e6dc0b7-3460-4d3d-c9f0-08dca7b89214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6pChm2h8jr4RXdQmkg7sdin6qWFglGfP+tU8haEaviohDW3ZN9Tlz+IWjk?=
 =?iso-8859-1?Q?tOZVNZLVn08fjv6igxcUxXVx1kdV1zyQ7YxxlHujmAqrziU0+KgSi0nXmr?=
 =?iso-8859-1?Q?4ufv7B7coERU0EMWFDS/xeeorg0j0BIImPgAlhc9N0DMSAGnybnKo88jBT?=
 =?iso-8859-1?Q?GUlY6QV9QGRc7DZoGBVaX3jClqRx15U0QEBaFHI3W2fDKxyv/YHGVTJfXx?=
 =?iso-8859-1?Q?9e894Apudbrw/4EHmGpR5avA6vutspbwvRO9OnPBxhNU3mmKei3RjmMGNM?=
 =?iso-8859-1?Q?KnbkS5J03/XQsBGQz1lY13d64RhHzNtWBSFCEsB+yoro9vEWtZ5+zNhWk4?=
 =?iso-8859-1?Q?tJxgqxCuA2E7RW6mZQ3Fhh6ZqTSiKT+5bfPYRcx8d0wjHYKUx0DR6139Ds?=
 =?iso-8859-1?Q?uzjzsVzXWuhKTeu6zbXOqaPMNsX40R/KmtB0ZSTGHFYLoLV4TFjzJjJDGX?=
 =?iso-8859-1?Q?xcoxqpHelnkpHhWVAguOMWBDXz6is7+69kz5TeyOv5XqzfjtA0gBapvaHT?=
 =?iso-8859-1?Q?LAubHP3bK4Ntgf+Z7JB88ZnSwxtb57qiANlPULuoBwyUKC9E8hTvAhbg79?=
 =?iso-8859-1?Q?f8AOwBwODakZtRUTiYwmB8+NJ/HCu6TDLmj9QgDtrUts42p3irZapfj9Uq?=
 =?iso-8859-1?Q?BhztzhahsqKPb9mprp5K3EUz956Fztw2UtVEVTuapH7eK6T73sppVrYdNa?=
 =?iso-8859-1?Q?XH6lO1DvaVAUU3eLLJSaK79WmBcffF8IAlpSlcpRjjykZYb134EJy5AZ5+?=
 =?iso-8859-1?Q?xoE9iTqvQeMepMWvezxYvYGAgGLvopOWharKoX9pyKgPSp488A39kztFf9?=
 =?iso-8859-1?Q?+HdkgiltRFAJHSeJ8+B6uRBISY1YTlsSoRPC46gv2eipcz2kO4sRjbq3Fk?=
 =?iso-8859-1?Q?bd2EH4RWsaXiXKJo4oa8ck5V8taCkLLpymWSxmp5ypKEJnEvLjZKHuvqnM?=
 =?iso-8859-1?Q?VouSWkSV0Xh26R49MBWvBjy+g5xYqWPoHpfyWdH68GqTSWsE80jjNkKtLr?=
 =?iso-8859-1?Q?XjPTqQDKz6ob8zb9jU5cXZAV4qJ+zAbVb7FbJ06tDHjKWONkpRLuQHCuHh?=
 =?iso-8859-1?Q?mEz02dGVBQF28A9kfV3fjuKGwwIPbuTUC/h9XdtfEjVzssQ+YMm/amWkVU?=
 =?iso-8859-1?Q?2uxDwoUuoeucjNSVKk2eo2Z1W+7SI1Gi8DIcr9q/HHuJn9Qjj3fZYpFAMg?=
 =?iso-8859-1?Q?gKKEa3pqUNbGd7bVJWoCmWeFOZnK2DfL+ZqnC3SmExTo8zQY7JWoo3JZyN?=
 =?iso-8859-1?Q?bQoqOMffF0hxZqZZGin4vzyR3k0nSBxaZ4TSDdhkNMbOqqXcIR9b4pEU0z?=
 =?iso-8859-1?Q?pd8oYAiPJ7tLXmSKL7U7TyfucWbMJW4pLbe+00CVXbUuu+zF6p2ZxLewb3?=
 =?iso-8859-1?Q?a1cvj6Z77AiJyQfZb6OF4SRTzl0SKjdlLx9tK27al2XeDI994Xky5+mLhQ?=
 =?iso-8859-1?Q?cVMJjD9cLCauDfNe313vzwjGlLQmAtVbZPS1Jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VuKxLFscH6H8JX7qO/MG+/9vzLdAeWHIXC5iTYH/ep6szKgkIai/d5CMrU?=
 =?iso-8859-1?Q?svaEBSv1dbNF6sZKQx2Nj+Ai7L0D9TrQhtFk3T9QEJRDoMyoXSRlpwObLM?=
 =?iso-8859-1?Q?VkG83CwkHsKn/wbIsHkTSvQjQFSu1GQgQ2zRqmc9PemzLd7Y55LREmSKWO?=
 =?iso-8859-1?Q?H0EqT2KuAMY34Dg1Dtqj4m5CnOKbxEPWpxvNkMNMes7+kziiV9+oHd3Oor?=
 =?iso-8859-1?Q?ShEclk4m5PCW3YfdSqo80crNviTlWSx2SmC2dLTX3Tad8BoBuBuEtRF83T?=
 =?iso-8859-1?Q?Ts1upxDGpb6Y7ghIy0bc2Ufm2DXqZoCwhKEYWA9Kwr9C1JcRVSGPlwhlDB?=
 =?iso-8859-1?Q?5Lw+MooNVzwAvCjUFQXdS2wVydNx01GtHsEEncTavWBYV7lc1Qd6sjacVc?=
 =?iso-8859-1?Q?2D2JauYnNYrh3wR42INS2ueJDgfNifF5AYQedUTvVJdczppNs22tRJwQnR?=
 =?iso-8859-1?Q?C2flht3ieiPR9DAIEHvTexkUQwm0rYk3nYsxKL28ZG4oK2Q4O7NCmVUO5b?=
 =?iso-8859-1?Q?MnIjVfbSGGLQRU1w28JeeYLk6DKKrMTGT+gU4ETCl+C40j7BRc+m/9MPmd?=
 =?iso-8859-1?Q?t51i1h4UbfSA7AgRGJ7qPsGMiPN2B6haBF0LudKF5tzzHKszCvA9bjx31Y?=
 =?iso-8859-1?Q?25/TRI6Tzr2/B6AMZ2pyPiC356kPBQ/3frCkEkZOuNu6MRvXdGYyy2Anxy?=
 =?iso-8859-1?Q?NONsonctpFk41Ocafn5CDXNkPLIPsdxjcJpnivmXToDAyCGz4jKAFGN42v?=
 =?iso-8859-1?Q?W+rH2DxsbBURPAKtBami92L19jORjTi40T8P9zqCB6Nc5c3ucbkTetdUVy?=
 =?iso-8859-1?Q?hPmUcsFFx80i1G5Fs4GbTmduA2AWQYWxGtkypKLEbmwXJMObTeAVqIf6Dd?=
 =?iso-8859-1?Q?xVhHHMgHsd/fjlsisCWj1Ed3YviZ35QJRzwpuH3jWX3HHUIDpwGLKHZZrf?=
 =?iso-8859-1?Q?T5VAoFiCaJJ6idB6uUGfgoQda+cKTUGbQIvTqRJIJMHIMMSRHaR06hDt1T?=
 =?iso-8859-1?Q?oL3B8nCklNakc+wvAwibMWI/eBhYo9rZKW1cgbyjfc8er3v9tIGhKh0H5X?=
 =?iso-8859-1?Q?XucWtFBB9KWXTz90hK3mIww+oQEKoTu83le8rQxzuYAtjkv1lL0UyXB19i?=
 =?iso-8859-1?Q?q3hTnTijtVbD+spLyEKl3CFmm2ilks3xjdBwdKlGd6lBeLpKuI+29OsOw+?=
 =?iso-8859-1?Q?Q9ASmoTVid7YGts3b37jV+zBjLZbxRHat652pibsd0gLAI9gMeVXzm6c74?=
 =?iso-8859-1?Q?OB+f0qnA05LMsN+XbtyLNHFI6aapfJl0+/Qagm5xVs/FACB2t3tvdnUAoy?=
 =?iso-8859-1?Q?rv1/7JDJv9vAS1j06MtmTJdjMNWWagjr8SDqtftw2v0lJwSm1vv1vVv++k?=
 =?iso-8859-1?Q?Qkgqbk1dIoxK4lQO4ClP1ATLS8ZL7RPfKXKzoT7LgDJqvP2Q+ZnP1/lvix?=
 =?iso-8859-1?Q?suV1LKlmWcz1Ty66iMaAgDdjUNHarg3mHRv+1d4rxwdTKkUKjEC5LwEL0d?=
 =?iso-8859-1?Q?H2q3Wqjaw9YBWB5EQojeNLPeiw3fKurPqNgOWASqzUuWBtQMV9tAVO70Bj?=
 =?iso-8859-1?Q?YVAeB+9zvKNwodjy9zpO+/Itq3J11/rodd3c7+i5HTOEKECJU9GSUDGowJ?=
 =?iso-8859-1?Q?CH2YTfJJBvhn1QJGoK7SbYlhPOxgVpyAUDiMghFYxIB2d6Vjwi2/BtP/F0?=
 =?iso-8859-1?Q?BgiiRPVG2sP9D94U4FprCnlmoMtaKtUV5UQEjoj3?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6dc0b7-3460-4d3d-c9f0-08dca7b89214
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 06:03:54.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0dnQjra0FmloGYKGhOXThWPzSdZ9PvDx+Hsk1EbDuNmhp2yjK975BUe200puSCG38NkooVe6/lrWCDEndlufV4hHxaeJLiv9jLG5HqE8bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4876

Ping-Ke Shih <pkshih@realtek.com>=A0wrote:=0A=
=0A=
> Maybe you can start a delyed_work with 1 second delay when entering to=0A=
> rtw_enter_ips() but not actually enter. For normal use case, after 1=0A=
> second, call rtw_enter_ips() to power down. For roaming case, it must=0A=
> ask to power on by rtw_leave_ips() immediately, so cancel the delayed_wor=
k=0A=
> and no actually power off/on in this case.=0A=
=0A=
This is a very interesting idea. We will try this for sure! Thank you very =
much. =0A=
=0A=
>=0A=
> One more question. Is there a way to use 802.11r (fast roaming) with the =
mainline driver?=0A=
=0A=
As I know, 802.11r is mainly implemented in wpa_supplicant. I don't remembe=
r=0A=
drivers need to implement special handles for that.=0A=
=0A=
Ah, ok. Thanks for that advice. =0A=
=0A=
Kind regards=0A=
Henry Jesuiter=0A=

