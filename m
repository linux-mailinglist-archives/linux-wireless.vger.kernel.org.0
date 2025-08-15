Return-Path: <linux-wireless+bounces-26395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49049B2757C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DBE3B0E60
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60B292B3E;
	Fri, 15 Aug 2025 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lAJO6dbU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753011922C4;
	Fri, 15 Aug 2025 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223630; cv=fail; b=U6w58aYCtz02dO12BXN8NFkgJNHP41pUpWh/aDmQI4qvL/SwioGe6QF1k7aHULg0aa8/inqhK1bmmhJAM97MDbjRU5lpteKYkC4QBEF3jxtXaTPqLfrgUPoaV/j1UJkPtKLwnmSfyG4hlzfTyuhu0lYiO8o1TNyhgjqG+qctpzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223630; c=relaxed/simple;
	bh=jahiOrHhO7jxvIcDqxIfnbQDCuGReXUcqfVzqMInWFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hB0boOafBL8BL/1rnArs0x7raDh0+aCbB+AwNK/575o9DdzTFk6EDeMIWDRcerfkt1FOpgjkMKNLp31lJauupQPADTKiAGkjzvNgobS2gzEAVJbjyZjRkzzw1rue50CAQ5JPtWSaxDewmVpr3ve3f9BOU+7fpFPkAgmzsMrYhzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lAJO6dbU; arc=fail smtp.client-ip=52.101.126.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXdyVtnE/UZBnzwxllSedxXDqMdBXZKGD2hxIpM3UWhSEpxcHgEsDoREeiVsgPErC8B+2mdFPJqdAcTVzViEw4YCnMEb5o+VqFVCZhKEBbdHs6yiRCVKPAk/aCdYUMa/7erAf/uyswTVUbRjWKT2Zf1LhnjdwiSI47xecMASVcalmEiUt6OfMl+h9JkW2I8IO/i3J2OzNdhlmVqG/ntgFMbc2q/ZZ2r8EiPHyY06ab6RVtBV5ISckNMdyuA1l1/sVXw08vI/8b6HsV1rTUj/eFQWwAqfNMyr4Kn4sxvcsf5wOaIfSNPQoAKteDfwuc3fjRy5BGmGQQ786VhALfwnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNzeqDgLij/Q850BSXekeHPpYaDart8T9VA4OmQU/50=;
 b=x+MomOLGMzeCUEa5yd78TwnaS7z/B88IavCnGoXB01MvZLFVCcgWFyOp/asaPcZw0GmHv48c5fNYxhqRY/aQR4fNntote87ZaKEawISHhcetg9X/kwXLpQsjeU7chLImUNjAI8JHPDx6hPwaBwoYW1OoQyixZ2MtHRCk6/PkmPw82FFxtg3oGcj288VGDqqOBrnKVBi9AWXdro2nJF0u8B/KEKlr7l6CmIaegzyBjuOJ0BHVIuxAwi66GwtvO6qxfi0r6QgioWWsi4NsvQKSqGnTgXh3uVpXofImDSKlt6AjcAKRCkaGIfSNIBv42zgEGTWtkXZn7qs/AKwDSuJyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNzeqDgLij/Q850BSXekeHPpYaDart8T9VA4OmQU/50=;
 b=lAJO6dbU7Or4WppoTU9JzMZltMwEa0yGTUH9fZz3PTNSanqQdQQA++eOMpDDAWYyMWXF476YilH1C7atVUbrC5zb595MogIhlnbYPvIxh1XCcp7eq4k44dLAWZcS4QstHaf6nBDKPjzXwgQDytbKOft66Tc8I1VHIO99p+guA31JKX+IiR73qPSUk/ZDLeAxb2KQ3LlDqo+uQouZlRkxxHn0pn2gZ+l4a3qaahIQmTVjHihtZ/Xj7hHSZiOETknWFJuHSRozgOQLDo4BkCxRjzVWdB5y/U9SgHI7Gu7SAc5mtLFtqelMh/EoA08N1wXaumKoY/wB6bn21jPg2zsBmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5974.apcprd06.prod.outlook.com (2603:1096:400:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:07:03 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:07:03 +0000
Message-ID: <f1370d58-9689-4c82-bca0-1ef6d709bc18@vivo.com>
Date: Fri, 15 Aug 2025 10:06:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thomas Gleixner <tglx@linutronix.de>, Jeff Chen <jeff.chen_1@nxp.con>,
 Bert Karwatzki <spasswolf@web.de>, Jinjie Ruan <ruanjinjie@huawei.com>,
 "John W. Linville" <linville@tuxdriver.com>, Cathy Luo <cluo@marvell.com>,
 Xinmin Hu <huxm@marvell.com>, Avinash Patil <patila@marvell.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
 <aJ33vFdOfMRDbpls@stanley.mountain>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aJ33vFdOfMRDbpls@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: b128e810-6977-4806-a047-08dddba06d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1FOOHYxNGhhT1FTWnhrL0NiZk5FZFo3MG5hUUtRYisrQUtSZXVwd3Vwc0NW?=
 =?utf-8?B?TkVPeW1JT05xKzFvalRiNnArM3YwZ2JHM2lUbGhHQll6UFBQaW5XWjVXYlpI?=
 =?utf-8?B?VjFUUjM1TXpzOVRzQVpCMTBKeFZETkpTeXNuK21SMDFEWVQvdHl0WTRmQkJI?=
 =?utf-8?B?WXhQUk5jclNuSXhMNzMrOVdnb0hDdURjYzU2SW5waVk5YThPdDRYQ3NabUZw?=
 =?utf-8?B?MWNwUHIvcnVCRHUvVlVodXpUNE1qcWF6eGpmdUI0cVc3VDlXSmEzZjgvbDNV?=
 =?utf-8?B?Y3EzR1B3UFg3MHdwSm12SXFXWnRIT2dmQzgyUG9qVHhMc3Vma202R2J0R0Zp?=
 =?utf-8?B?clZVVkEzT3Z2aDhRZjAwM0p6clRvVkl5eG9ZUWF2bHBmeDZzSG1KMCtpb0NF?=
 =?utf-8?B?WVZjazdwTUV0Y3V0cFpSNzNUMzBBL3pxOW9oWkdScmNoZ3BtdWVPNGsybVBD?=
 =?utf-8?B?UzR3ZzFHbXpIeUtiL2kxS3R3WlN4eWUxdXZVbEJPWk8ycTAyMkFYS2RBeTVu?=
 =?utf-8?B?dVVlNUx5OGhSQzZod253b3RHVzBmWGxMNERpLzc5bGhiSlZVUzQ2aWFBaW1m?=
 =?utf-8?B?TGZ4aVR2MXZoVkk5NTVoTkNMVEgvT3RnUWNSSmhCd3ZCMjllc0J1cG1tcEtZ?=
 =?utf-8?B?bGo5dVR5K2RoRWJnejMvUnI4MGlMeTNTendjbzRjU0tTWVFoblArSVRLTjRn?=
 =?utf-8?B?MzhhQm52cndYbDdVY0hRbjRoM3FsQnhDcUt6c2JldDB1Y29Va09TWFdYN0Z2?=
 =?utf-8?B?N0hqSTR5MHFlemU5aVFoK1pzNDYxZ0NUOUV1eUZNUERrbTdJMm1LZjVJM21T?=
 =?utf-8?B?L2k4cmZ3QTlKVVoxaElUVUNOVEZuSlNQYkpvMjU1QzQ1OVNWNGtBZHNOTjhY?=
 =?utf-8?B?blRNdkhUT2JSU21aVGViYkVZdE1VYTVXZmorYjlnNSthWHZDdG1wZ3daTTEy?=
 =?utf-8?B?elE5UXdvNUZiWWN3VmEyUDBMOVYzaXVPY1VRVFpaWFpjNm1yemttSklUcGND?=
 =?utf-8?B?NjJ5UnduVEF0Z0N6WUh3TTNFN0cvQVFVWUc0N0lGYTl6Q3hmSnN2OEllYnIz?=
 =?utf-8?B?YW9pc3hIVkdvZjhid3gvSmFTaHM3c1loTDgwekxFeHJBLzl4cStqY3NhM3pX?=
 =?utf-8?B?dTQwOUo0KzJFYUZ0Vk5aUkh0Wit2K0NwQ29RSWpVU2hIWVpOWW02WkFadGxE?=
 =?utf-8?B?bGRQcW5iVHczd2pNZnc5cTBNdFViT21FczJMb2J0NjBQWU9DVmtGTnR4dEVJ?=
 =?utf-8?B?cVd6VXd2MHo4bGpGQWtWNGo2NmI2M0QvaUZPN0dKUU9Mby9tSVh1QjRHZmlP?=
 =?utf-8?B?Nis2R1hNMXlMYkxuajR3dURlb3pHTlRaUkFzVG9IMnhUUExtVW00Z1UzNW1t?=
 =?utf-8?B?aXJvTDhEMmtQZXdXMjhzVDBXUjJld00vRXNWajFkREpyOVdTQzRaNGl1TmlR?=
 =?utf-8?B?ekZIUEdPYzRMQjNZcDh5RTJ1UFJHNlVzMEU0eTdZdEdtQ2lPN1JXQnFJZmlt?=
 =?utf-8?B?NWs2VmhGWjlRa28zK0Z0TjJlWFVCYXdXVVNSVFZ5cU5aVlRVTlFnKzFrQTBn?=
 =?utf-8?B?WHRiMmRvWXJrWkg5cjVGUnBEOWd5YVZBQldxWi9CQ3ZlVGpicWhVd3RMZ0J5?=
 =?utf-8?B?WGxsQ3hyclJUQmFVemVZQzBxdFVGOHN5Z0s3OXNSeXk2WStXNTBYTFYyZm9M?=
 =?utf-8?B?NVM1R3VqOWo4SkhGUitUR3RXck9RcVZ2V3VkV3c3TTNKZnBsN0NRcE1zSlo5?=
 =?utf-8?B?ejFYQU51dE0rZmltcnJnYmw3aVBTOVBXeGlac0I1LzZuZU4vNGJwbWE0bHNX?=
 =?utf-8?B?Um5LM2FsZzhFY2VJd3NvVkRMZkxKQzJoV1FKS2pCa1ZoYnhkMGhWWmpLQlpE?=
 =?utf-8?B?SytUeEpQL2orOGZhenI4N2VlVStwakhpaENsUVY3V0ZpbVkzZDhrWlppVkg3?=
 =?utf-8?Q?LOu0/kH5Qis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEV4UGtzc0VOY0QvRzlPTWxaaHdIQXlMcjh1Y3dEb2Vadm1wbnBRcVhnT2ZK?=
 =?utf-8?B?QS9tdlVlc0lrbVMyUGJMcmRvK3BYa2Y1MlZ1V3dpdENBMnVUM2JRVkNYQXBp?=
 =?utf-8?B?eXdSdmtEVE9kckMwUFZVdWQwWDZvZEdPT0IxamZ1VFM0cGFpSmoxRDExQnR4?=
 =?utf-8?B?bzUwZGZSakJpMnFLajVvOVFSMFFMMXVGdEVDVWpEdFUvMDFPWUZXSEJLenRT?=
 =?utf-8?B?Nnk4VzlrNTZwbEx2UjVDaU5qOCt1N1pFSC91V1pobER0eUNCUDNWOGNxbTRq?=
 =?utf-8?B?WlZzenNFSy9ibndxZTIzaWNDTzcvaVdwUStkQ0E0clE1YytKM0xJKzNIMHo3?=
 =?utf-8?B?Qzc5aEtzWEVRUUtDL1dydklpelpmemU5YjJYVVQwS05zajZyOXowOW1KdVpv?=
 =?utf-8?B?dWtwNjRwUTREMVRFVTVYTjFtOWRaR2FqcjdYUVZSUS9hQVJtamVDVmlNMndT?=
 =?utf-8?B?ODB5TVNVaVNhQ0N1NHg0azJoQk92YVFpWityMEl3SGpSSDYxSmRPM2NRcGlI?=
 =?utf-8?B?NDZBeE8yTFRFZUhtemhnMUl4WVJZRVpnYmpObE9uNDRrWGdTUW0wNk5xSkFI?=
 =?utf-8?B?eFZJeFpoMW9TYXVXZjZuQmRhQlYzbWV5alFkdWNnanE4SHZEWEsydkVkb0M3?=
 =?utf-8?B?c1d2NEc5TUpqb0x2cmtYWTJ0VTRaUlg1dXFmVnJPcHAxQlllQ2xqZnFPSjg1?=
 =?utf-8?B?RVVIVHdKa0tneFIwMktkTnQvM09Nd2ErTGxoU29WWUl2NGRGTWVGbWtpcTFV?=
 =?utf-8?B?UE5uUEdBdHZoMEVzdityTGRhVG1hdUNoenJyM3pQT3BLWlBqREFpYWFUNE1O?=
 =?utf-8?B?WlFBT1NYcWxrdGt6T3MrRW51SHV0Mm9YSEFhbFAwdHFTZ3l4OWZvaisxT2RT?=
 =?utf-8?B?L25qN1NKM1pVY1oyVWd2b0w3Q1lPTjZQdGsyRWJ3dmEvVTZRR0NaN3lDUnFr?=
 =?utf-8?B?cURGTUdjb0szL3lHOERwbnFpdWpjMXZ5ZGpZekkxcHBkcndxQkw2dkNsMSsy?=
 =?utf-8?B?ZnVNa0RPY2h6UDdITHFIUkQwTEttNGNQdW85NVpJV0ZqcUxNdnQzNHljUDQ1?=
 =?utf-8?B?VkpsK1FNUjkvL1FDTURvS1JmTXlvSm9MMkJncDJHcnBuRTVtcU9IQWMzbEdI?=
 =?utf-8?B?WXdvSlpVaE1Zd3Y4TlgyeXFGOGpVdkg3UHV4dkFaOTBNVE9Qa0ZjWWpaMDBj?=
 =?utf-8?B?bXFrN1FGaGJQK3ZYZkpteUZtV3NGbmJSRWQ1QTVTUTlOWXdWajFSNURBMlpE?=
 =?utf-8?B?UElJUldFUDB1RXZ0QVlzNTgybnRjYUNrOHAyeFQwdWtYQmZvaTdwcDNrV2dP?=
 =?utf-8?B?MjhNZVYyZ2dwdjl4b2RqZEVoYVErVXhjaTJVNk5ZTkhSTjl5cXhOdkdTZ3V1?=
 =?utf-8?B?RlFoQnJCMHFoN0g3dTF6d2dxTUlhSk5ITk84aEFTVkE3bUVYQ0NjalNUOCtk?=
 =?utf-8?B?S25iZS9QTXBCWTRQMndzdkZRNytacjFCd2xEaFd4QTN0SGRFZUs5aWhxbFdZ?=
 =?utf-8?B?ZE8vRTJKdlNLVldCMUNSOWJrSXVZWkxIbzhWQkNEaWx5RllFMGQyNlVtaGl5?=
 =?utf-8?B?dUJvN1EvSXRqeWZmQjlTanl4RmpKQmo4Z2pWNTJCd0FlZU42RUFZSGJrbHRY?=
 =?utf-8?B?VFFja0ZKRzl1T1J4WUZOY2ZjcGFaOFQxekdYTytJTENQT1ozelBzM1NSUEEy?=
 =?utf-8?B?V3pLcE4zR3E2R3kzL0l4VVE1aWVTNzhuNlN2WW5yM3ExSHEzWnlROGk5YW9I?=
 =?utf-8?B?L2ZSa1FMYk55MkpWZmJsUEFWdGFIWXo5OXMyTUJUbTZzem5DQUdqRFBoSWI1?=
 =?utf-8?B?bEx1Z0lVY1c0cjc5Q0xQTndyMGx2ZEo4WExsVDZiTlVuVHo5Rit6MHEyV0Ri?=
 =?utf-8?B?Wldkd1psYjVicWRYZEtBcy82SXNpTWFKMkQ0SCtTWVpLRmRjRzV0Q1dGSkNk?=
 =?utf-8?B?aFI0NWFIclE3cGRjWC9ydXJIbFpBM1RjeG80d0tZZ2VBWEdXRVRmeGtNSmJO?=
 =?utf-8?B?bVVwQ2pwVHA2eEpBWjZmR3cwYldoY0ZiY1IrbE5MZHBZbG1lZ2d3L3pZM09p?=
 =?utf-8?B?b29tN1BUSWRXVVlPbmRGdlZBUzF3MURBSHhVM3AyWEx0R1hLbmxxZVp4WG5L?=
 =?utf-8?Q?1NK8l397hlJPKqnB8WSBUiIbA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b128e810-6977-4806-a047-08dddba06d70
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:07:03.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYvwqUVkQZhnesF0cmrmXE0Bf9p7/OpFpTbMZvfLVuHLwlFHagwTnH8m5HqA9rQ5BqUu8Gsu8NtC+zu6xdywig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5974


在 2025/8/14 22:50, Dan Carpenter 写道:
> On Thu, Aug 14, 2025 at 09:15:31PM +0800, Qianfeng Rong wrote:
>> Use kcalloc to allocate 'adapter->chan_stats' memory (max 900 bytes)
>> instead of vmalloc for efficiency and zero-initialize it for security
>> per Dan Carpenter's suggestion.
>>
> This patch is okay, but lets re-write the commit message:
>
> Subject: wifi: mwifiex: Initialize the chan_stats array to zero
>
> The adapter->chan_stats[] array is initialized in
> mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
> memory.  The array is filled in mwifiex_update_chan_statistics()
> and then the user can query the data in mwifiex_cfg80211_dump_survey().
>
> There are two potential issues here.  What if the user calls
> mwifiex_cfg80211_dump_survey() before the data has been filled in.
> Also the mwifiex_update_chan_statistics() function doesn't necessarily
> initialize the whole array.  Since the array was not initialized at
> the start that could result in an information leak.
>
> Also this array is pretty small.  It's a maximum of 900 bytes so it's
> more appropriate to use kcalloc() instead vmalloc().
Ok，Thank you for your correction, I will release the next version soon.
>
> regards,
> dan carpenter

Best regards,
Qianfeng

>

