Return-Path: <linux-wireless+bounces-37438-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RwOeI/34ImrVfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37438-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:27:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03C649C2D
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:27:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Zj7tEp6N;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37438-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37438-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CED30A9325
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E2406812;
	Fri,  5 Jun 2026 16:14:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA6404BFF;
	Fri,  5 Jun 2026 16:14:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676095; cv=fail; b=qBN55AdCnIMXicFvvbL55nsOhiBFOXMhsOe713zkMzPd32g2g4EkKZOiGnMn7K3yeQpQedi+8nzgs4Ezi59KEl17kTul8Q2lchcyL+k4vu7For0G8mOskU0owR9ltcLvVVSKn5lCodHnMXBeY5qJ5dtT1be41kHxohAPuOGN8aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676095; c=relaxed/simple;
	bh=mPCmgUwyXV4d3FIOyoIweJZsZ/jrkbmAMmhIy47oGBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTURd6BoVl9haQbSZH1Khb/cheM8owvU+ZePNRaQ2F6+12+Av1i7giemc40MrqabXIzlDogQWTYNBEXruFzw20BHArUFzD34wk+q9KVKrBRVFCOlgkjMXjSjlb4izvtX3DDFBVpOx9Fww5H8LZWW8j8bdeVjXvfNeey+KtPrKvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zj7tEp6N; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUZ279gun5mJJ8Ta2BmFaSo+zwlNYovt4Iz71NhP9QIma3FlfP2HxOcV+Q5jzTV+q2EulP1Z2BRfKaTmiAoJYgreQFK/1jjocjCilgqZUPgl8jyxoq7MoyBzDXdTzKJA0NlvFr21Ugs93H4Zfdk+C5fr5+rwdM2EtCOR5pzqV2THcrY6DOM7K77AJgWj+J+3nG/3ceGOssYHZSJCgaGxFTHTRQrXJq1WLoLq8CfPq/CusKT/o5Mwqb8rT/VX+5c0qnkivqJlNsLmd9Ru+7O0MLZyJdZikgvHPO9lBGm8zh9HBBnuDE1jJLm5NJqUUzSnzmwQd5rB6Je/d21nZiEAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQRqEtSR19AnIgAkaEJ38dTf230X2TpDAnqLolQDjIw=;
 b=XRHr05HqT7H9uP7s0aB7aCSAsXpYpi3Xku43GQuwQjictVoZHGs3Oy/uh4d6a4mLexlrbnxceFWA7ZJ73Yl2dBHsuo474rnKCDscynB8WvVzluwf8v1vPnYnvEqhKgoZUsQiB9VZ3eTKiay8SezoiKP0nHMELfD6dt6GfXIYSY/tD0cLVuaEXNyC1fa5RdkLlxYqOTWyeaMOW+kUdmnWxqoFgSu1pL9WUGZtrO3hpfgihQBxGGI2RaramiR7EA5M5eF+NhEyckRhSdYl2+gMI8sT/7jenv/ji5nmgS6ckXMwDo2gzwXFLQFYWYnXjGRXhJ19c4PJUfOVYyia896DLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQRqEtSR19AnIgAkaEJ38dTf230X2TpDAnqLolQDjIw=;
 b=Zj7tEp6Nrf4h/xzVAYPd9h7P4WfE13EUlH3AkAEdCzsLyPoBFbMHjadtj3nThy1wX8yHlCUSO7EaB+YlNLJUA9XvFydag943TFoDeA8waaSjbcx7laGSdAsa9tPNyvXpEhRPniRwkLhS4oaC09cn/4SSS89siifwirxGspImjPcuDQ8W8ZOOjT01m0cl7K+8/W2f+kLpXwDXRGD6YXPc4rO4jTcchA2g5ufdEJlCBOMqmdpwyWRqcfWfuv3E3SpQrYMH294VhvcijDwLM0eK8n7UAVqmhCeNZbUEfio/gcCnol91N2oxulVzXDyGQnsEfq5rQGzu9T1mSghe+ap0gg==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:22 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:22 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	ulf.hansson@linaro.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v12 13/22] wifi: nxpwifi: add data path support for STA and AP modes
Date: Sat,  6 Jun 2026 00:13:26 +0800
Message-Id: <20260605161335.2415583-14-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 696a658d-5dc9-4803-d26e-08dec31d8158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	WqndHUwXkO9y9LuCceADs8UtmcHRN1TG/yVeTW4M7ZqDvGDFAQ7xG3nZno8A5EGpEp5yPqaFonYHiL7neXfTDanSgqE7LNreqF3J8nV9JgdTzkygAPdbH4BQtxqrx/NjFMGBKPlPk38p4m0+lUU2V369G2VdgcRYUWuljFx+MhutehP0SCWmuGoasbU61BFjmlN8BtUxN8muG6QvHZcj28+krlT6fXURDfdBRmgLScKieNL8xxVQHuIKSDirxsEG0B0Z3o7Ir4x4vjNp6F7HVwjdzct8iOImGo4Ryo92VRCHgSDEZ6zjUF32xoreXMm2QQV8NcK4Et5uVWdkdjivjrheGN4cyPzVyDUHIM0C+8HNk3MuCjbSKtRHowHDd82G0yc0baIL1ayCTjQXL4ivNNpg0tqP5sAwh+eLEZCk/zIAH5NVsRBj84om+kkemw/mIj2ku8mdsnm8YuygBH+3KOLXIAGZhGqjMY1dNZh3hZ2Vkn1KRz+QBgD7LOdOscyDShaMkulX1GY+gyU6ojZRi1H5b9DA0CpSE72o9vHOo1t21BOMBH8tad0XqRyGSMWdYbBWJDl7tQERf+bsN4gx/9VWFw/cZUQhQWOsh5Qwq3i/mTM8rwS1HY6jfBimQX5lFNWPDk6nFGqCCKxk7DlKedP91K2H7zwwYE433VSCh5S6r7dm4ceW2qgHEd2Z82KYs8lm8doorQL0NDww7JMqU04+poTVEeiqGbDtHpV2JaSBYzllK2c/Lj7Njbpe6SjR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFJGa2FoaExMd1I1Qjh5dFRxa3dTTjl3TFV6c3cwQ1R1UHc4ZU5Vc3B4UUZU?=
 =?utf-8?B?S1VKaC9KcElOaG1OTjRoR0RsWDh1T04xejBXL00vcndLZ3VESG5jVVZLVCtu?=
 =?utf-8?B?NlBJdnYwWkRqMmtwV0MzVURrYUxqOGIwU08reFVHQStJNDJsUkxzSEIxY3F5?=
 =?utf-8?B?c3pSVHFNTnZTYS9CQ2dIdWtGWExYVHpNN2RYS1VjRWlGY1ZNZGFGTWhhbkdw?=
 =?utf-8?B?bmZHRjdkaXBrYlU4ckVaUmlXZHIyWVZBSER4VjdoazIxbnh3RTEvSHdLRzY4?=
 =?utf-8?B?S1VXYWRCTkZELy9oVlB3RmdhUXJUL0pWMUgrUzl5S21ucW9uZmRHdjZsd2Fj?=
 =?utf-8?B?VW9OZEZYK0xnaWc2TkdseDN0RnNQTnA1MWg2bkhYYW1hZzNSTWtkSnJRMGxD?=
 =?utf-8?B?MC9Edml4aTFPeS84aVBibWc2aHhKeVFrckZDaEFtUkY4d3BLNjdGZEZXM29w?=
 =?utf-8?B?QjdvSmdqQVV3L1FGM1FvVGVhaVlJT3liNVI3M2dZU2lFT3lxd0NzbmlnSFkv?=
 =?utf-8?B?MTRZY1ZYOTNyL09yL0lrZzdmaWw0cVFHQ1ppaUxFQlNVTXFheDZvQ0NqakFC?=
 =?utf-8?B?bWRhbWttRnh2cXFyOFIwY2sxbWFCZXF5dFZIamNkWUdtL3VydHlDbC9Cc0tE?=
 =?utf-8?B?S0x0aUhrTVNkaW1hQ01GKytrTVl1WlRtRWlIZWV1YlpLNDdkZktFU08vSWJR?=
 =?utf-8?B?Ykx1aENreUdvQlAwa1hrWmtlTkI3T09Xa2cvcVdQM1puVkR0SVhpR0RsUDQ2?=
 =?utf-8?B?WXhTL1NEVWVLZmVzUjdkd040RVcyRUVGNVgrQUxEYUJvOC9XNVpQREpZSlFu?=
 =?utf-8?B?dC9Idnk2Mkpra3Q5dDFISnNHcE1EaU54Z1l1MjBGQ3l3OXNYbC9qelZvZ3Qw?=
 =?utf-8?B?T01SL25OZmxIdStlVk5meklIa3JMd0I1REtKWUMwdHZsZU1LZjNCbU9QTXo2?=
 =?utf-8?B?ZndHcWErOVFJbndJaXYrS3NKcjNYSWtYMWdab1o4RlJEbnI0VTA4K1JHODF2?=
 =?utf-8?B?eXdtbVdyUVQ5a1g0L1oxTGFoN1UyamFKK0ZaRytPYm9BVkc4Tyt2ZUlIdHZN?=
 =?utf-8?B?VXlZTE85ZElaTG5ZUndKeTduSk9qUHMrYzM0a3g0RjgrRmJYT1BNT0VraHRY?=
 =?utf-8?B?ME95ckRJL0dWU25YSCsvbW5ObTU3TVorVGdNYWhWTTNzNGNrOElyenVOVVBD?=
 =?utf-8?B?WG9OWUd3My8zc01YTCtXRnVDUWprZHdubzNPNEZLbFo5SUFTb3pvODZrZ2Z0?=
 =?utf-8?B?TUhTYk1Mb1dURHJKNTYzZGlNM2J6VTZlaGhGNUY2RFdnK3NTN1BXR2ZGV0N2?=
 =?utf-8?B?QklsOU84U2dlc2lyNkYyRG9CZ05BUHdvUUpwcVQ2cGd0aFcvakJSc2F5SGdo?=
 =?utf-8?B?ekl2NkwraTNXNG9USlBxTC8vV2Rrb2hQV0dPNVlhQ0pyT2c4N2t3UDZsQVFJ?=
 =?utf-8?B?Z0JSZUd0K0M3NGZCSjhWWmZ5Tm1uc0VhOUtVSmpHd1F0QlFOK3AwYUFub3JO?=
 =?utf-8?B?a2UyZW8reklSQUFSMmxRd2F5bkxVODdkNEozTjdIYlBGcDQwMndhdWpmVy8z?=
 =?utf-8?B?U09oY1NkZENvQ0szMUlQOCtPMXVTU0NqUTAzSGNtL2I0RmJSdnBZb2JCRmtT?=
 =?utf-8?B?YXgzL3FmcUhBUGpDTk1SUmZ0emtFdHJwQnNXLy9mV0VRb1hjSDl6VERZelhS?=
 =?utf-8?B?YVNNUEhXc0hyWkdDMHEyeHhGNWFXL2NIaXZQUkxycks2V3NPcHEwcVVZT2Ju?=
 =?utf-8?B?R3RtQ1o1T2svbmJ6d0s3U1FuRzVpMFQ0dWxIS2p1L01kSVRCRHQyK1NXTEJY?=
 =?utf-8?B?VmNwR3U4SFBWR05lV292MmhhWkQ5RGRpcUZBNTArMHN2MmQ0WTQ1djdXN08w?=
 =?utf-8?B?cE1vQlZ6S1pzSTE1VlpKeTIxWXdMM2cyVElYb1RkZlJBZVA2SXVIUVgwL3dB?=
 =?utf-8?B?UWRaN3JpaDlpWGFVOFkwZEhncTFMdEZicEppNnp6NzcvOVJ1cG56clIrYWJU?=
 =?utf-8?B?di9jWkhaRnVNQWVaUlcxWExLR0lrSHlsTVFNMnZqNVZ1VzFucVRzcFdZNEUr?=
 =?utf-8?B?a1FLaUp1Vml6NzVlczMwS2U4bGxPWEsxNG5qb2x6VGVrcitQd1d1anNxc3Nm?=
 =?utf-8?B?QURlYTY4Q0EvbW4vM3M0TWx0Sm5JVFZkMXhMSk1rUUJkVGl5aDVqakViQ1FC?=
 =?utf-8?B?d0VlUFBJVXZYcW9oU1FFM053WEQzK1NqMXBoZHFxZWhGa0pac3d5Znc1UGR0?=
 =?utf-8?B?cVRtM0xOM0NjQXJPSjJhMVpEZS94SnM5Q0YwdWNFLzlacTFKT0tLZXV3VUti?=
 =?utf-8?B?b2tyMlB6MVdhU1VBME9BZGZLQkl0S0RwQmJDNGpNdDRmT2ZCK0IzQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696a658d-5dc9-4803-d26e-08dec31d8158
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:22.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf/F4uyPPj/+lf+n/inZuDiZ2iidceNdQtoDUjOkGpCIn3Yu8Ho/+aOmoxl0LJyjCUnJf4JtIxHMjJsbDUcDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37438-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA03C649C2D

Add the data path implementation for both station and AP roles, including
transmit and receive handling across multiple modules.

Add sta_rx.c for station receive processing, including frame conversion,
RxPD handling, alignment adjustments, WMM priority evaluation, and 11n
reorder support.

Add sta_tx.c for station transmit processing, including TxPD preparation,
NULL data frame handling, and integration with firmware status reporting.

Add uap_txrx.c for AP-mode transmit and receive logic, including bridged
packet forwarding, STA-specific queuing, and AP-side packet dispatch.

Add txrx.c for common TX/RX routines shared by all roles.

Provide support for Ethernet frame reconstruction from 802.11 headers,
TX/RX descriptor handling, WMM prioritization, bridging in AP mode, and
completion callbacks for transmit status reporting.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c   | 242 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c   | 190 ++++++++
 drivers/net/wireless/nxp/nxpwifi/txrx.c     | 352 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c | 478 ++++++++++++++++++++
 4 files changed, 1262 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_rx.c b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
new file mode 100644
index 000000000000..d951d21eb41c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <uapi/linux/ipv6.h>
+#include <net/ndisc.h>
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/*
+ * Drop gratuitous IPv4 ARP and IPv6 neighbour advertisements when
+ * source and destination addresses are identical.
+ */
+static bool
+nxpwifi_discard_gratuitous_arp(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	const struct nxpwifi_arp_eth_header *arp;
+	struct ethhdr *eth;
+	struct ipv6hdr *ipv6;
+	struct icmp6hdr *icmpv6;
+
+	eth = (struct ethhdr *)skb->data;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_ARP:
+		arp = (void *)(skb->data + sizeof(struct ethhdr));
+		if (arp->hdr.ar_op == htons(ARPOP_REPLY) ||
+		    arp->hdr.ar_op == htons(ARPOP_REQUEST)) {
+			if (!memcmp(arp->ar_sip, arp->ar_tip, 4))
+				return true;
+		}
+		break;
+	case ETH_P_IPV6:
+		ipv6 = (void *)(skb->data + sizeof(struct ethhdr));
+		icmpv6 = (void *)(skb->data + sizeof(struct ethhdr) +
+				  sizeof(struct ipv6hdr));
+		if (icmpv6->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!memcmp(&ipv6->saddr, &ipv6->daddr,
+				    sizeof(struct in6_addr)))
+				return true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/*
+ * Process a received data packet.
+ * Convert 802.2/LLC/SNAP to Ethernet II when appropriate, trim the
+ * rxpd and extra headers, optionally drop gratuitous ARP/NA, cache
+ * RX rate for unicast, then deliver to the stack.
+ */
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	int ret;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct rxpd *local_rx_pd;
+	int hdr_chop;
+	struct ethhdr *eth;
+	u16 rx_pkt_off;
+	u8 adj_rx_rate = 0;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+
+	rx_pkt_off = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
+
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX)))) {
+		/*
+		 * Replace the 803 header and rfc1042 header (llc/snap) with an
+		 *    EthernetII header, keep the src/dst and snap_type
+		 *    (ethertype).
+		 *  The firmware only passes up SNAP frames converting
+		 *    all RX Data from 802.11 to 802.2/LLC/SNAP frames.
+		 *  To create the Ethernet II, just move the src, dst address
+		 *    right before the snap_type.
+		 */
+		eth = (struct ethhdr *)
+			((u8 *)&rx_pkt_hdr->eth803_hdr
+			 + sizeof(rx_pkt_hdr->eth803_hdr) +
+			 sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+
+		memcpy(eth->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(eth->h_source));
+		memcpy(eth->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(eth->h_dest));
+
+		/*
+		 * Chop off the rxpd + the excess memory from the 802.2/llc/snap
+		 * header that was removed.
+		 */
+		hdr_chop = (u8 *)eth - (u8 *)local_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)local_rx_pd;
+	}
+
+	/*
+	 * Chop off the leading header bytes so the it points to the start of
+	 * either the reconstructed EthII frame or the 802.2/llc/snap frame
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (priv->hs2_enabled &&
+	    nxpwifi_discard_gratuitous_arp(priv, skb)) {
+		nxpwifi_dbg(priv->adapter, INFO, "Bypassed Gratuitous ARP\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	/* Only stash RX bitrate for unicast packets. */
+	if (likely(!is_multicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest))) {
+		priv->rxpd_rate = local_rx_pd->rx_rate;
+		priv->rxpd_htinfo = local_rx_pd->rate_info;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		adj_rx_rate = nxpwifi_adjust_data_rate(priv,
+						       local_rx_pd->rx_rate,
+						       local_rx_pd->rate_info);
+		nxpwifi_hist_data_add(priv, adj_rx_rate, local_rx_pd->snr,
+				      local_rx_pd->nf);
+	}
+
+	ret = nxpwifi_recv_packet(priv, skb);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "recv packet failed\n");
+
+	return ret;
+}
+
+/*
+ * Process a received buffer on the STA path.
+ * Validate RxPD and lengths, handle monitor/mgmt frames, fast-path
+ * non-unicast frames, and feed unicast data into 11n reorder/BA logic.
+ */
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct rxpd *local_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ta[ETH_ALEN];
+	u16 rx_pkt_type, rx_pkt_offset, rx_pkt_length, seq_num;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(local_rx_pd->rx_pkt_type);
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_length = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	seq_num = le16_to_cpu(local_rx_pd->seq_num);
+
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
+
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
+			    skb->len, rx_pkt_offset, rx_pkt_length);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (priv->adapter->enable_net_mon && rx_pkt_type == PKT_TYPE_802DOT11) {
+		ret = nxpwifi_recv_packet_to_monif(priv, skb);
+		if (ret)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	/*
+	 * If the packet is not an unicast packet then send the packet
+	 * directly to os. Don't pass thru rx reordering
+	 */
+	if (!IS_11N_ENABLED(priv) ||
+	    !ether_addr_equal_unaligned(priv->curr_addr,
+					rx_pkt_hdr->eth803_hdr.h_dest)) {
+		nxpwifi_process_rx_packet(priv, skb);
+		return ret;
+	}
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		memcpy(ta, rx_pkt_hdr->eth803_hdr.h_source, ETH_ALEN);
+	} else {
+		if (rx_pkt_type != PKT_TYPE_BAR &&
+		    local_rx_pd->priority < MAX_NUM_TID)
+			priv->rx_seq[local_rx_pd->priority] = seq_num;
+		memcpy(ta, priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	}
+
+	/* Reorder and send to OS */
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, seq_num, local_rx_pd->priority,
+					 ta, (u8)rx_pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_tx.c b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
new file mode 100644
index 000000000000..5ad578223f1c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station TX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+
+/*
+ * Fill TxPD for TX packets by inserting it before payload and setting required fields.
+ */
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	unsigned int pad;
+	u16 pkt_type, pkt_length, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+	u32 tx_control;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+	skb_push(skb, sizeof(*local_tx_pd) + pad);
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
+
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+				nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		local_tx_pd->tx_token_id = tx_info->ack_frame_id;
+		local_tx_pd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (local_tx_pd->priority <
+	    ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl)) {
+		/*
+		 * Set the priority specific tx_control field, setting of 0 will
+		 *   cause the default value to be used later in this function
+		 */
+		tx_control =
+			priv->wmm.user_pri_pkt_tx_ctrl[local_tx_pd->priority];
+		local_tx_pd->tx_control = cpu_to_le32(tx_control);
+	}
+
+	if (adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(struct txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		local_tx_pd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!local_tx_pd->tx_control)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
+
+/* Send a NULL-data frame with TxPD at highest priority. */
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_tx_param tx_param;
+/* sizeof(struct txpd) + Interface specific header */
+#define NULL_PACKET_HDR 64
+	u32 data_len = NULL_PACKET_HDR;
+	struct sk_buff *skb;
+	int ret;
+	struct nxpwifi_txinfo *tx_info = NULL;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return -EPERM;
+
+	if (!priv->media_connected)
+		return -EPERM;
+
+	if (adapter->data_sent)
+		return -EBUSY;
+
+	skb = dev_alloc_skb(data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = data_len -
+			(sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_reserve(skb, sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_push(skb, sizeof(struct txpd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+	local_tx_pd->flags = flags;
+	local_tx_pd->priority = WMM_HIGHEST_PRIORITY;
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	skb_push(skb, adapter->intf_hdr_len);
+	tx_param.next_pkt_len = 0;
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	case 0:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, DATA,
+			    "data: %s: host_to_card succeeded\n",
+			    __func__);
+		adapter->tx_lock_flag = true;
+		break;
+	case -EINPROGRESS:
+		adapter->tx_lock_flag = true;
+		break;
+	default:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	}
+
+	return ret;
+}
+
+/* Check whether a last‑packet indication needs to be sent. */
+u8 nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 ret = false;
+
+	if (!adapter->sleep_period.period)
+		return ret;
+	if (nxpwifi_wmm_lists_empty(adapter))
+		ret = true;
+
+	if (ret && !adapter->cmd_sent && !adapter->curr_cmd &&
+	    !is_command_pending(adapter)) {
+		adapter->delay_null_pkt = false;
+		ret = true;
+	} else {
+		ret = false;
+		adapter->delay_null_pkt = true;
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/txrx.c b/drivers/net/wireless/nxp/nxpwifi/txrx.c
new file mode 100644
index 000000000000..6e8b49138e57
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/txrx.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: generic TX/RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+
+/*
+ * Parse the RxPD, select the target interface, and dispatch the packet for
+ * handling.
+ */
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb)
+{
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct rxpd *local_rx_pd;
+	struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+	int ret;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	/* Get the BSS number from rxpd, get corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, local_rx_pd->bss_num &
+				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop RX packet\n");
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	nxpwifi_dbg_dump(adapter, DAT_D, "rx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+	memset(rx_info, 0, sizeof(*rx_info));
+	rx_info->bss_num = priv->bss_num;
+	rx_info->bss_type = priv->bss_type;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_rx_packet(priv, skb);
+	else
+		ret = nxpwifi_process_sta_rx_packet(priv, skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_handle_rx_packet);
+
+/*
+ * Add TxPD, validate, send the packet to firmware, then run completion
+ * callback.
+ */
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param)
+{
+	int hroom, ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd = NULL;
+	struct nxpwifi_sta_node *dest_node;
+	struct ethhdr *hdr = (void *)skb->data;
+
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hroom = adapter->intf_hdr_len;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+		rcu_read_lock();
+		dest_node = nxpwifi_get_sta_entry(priv, hdr->h_dest);
+		if (dest_node) {
+			dest_node->stats.tx_bytes += skb->len;
+			dest_node->stats.tx_packets++;
+		}
+		rcu_read_unlock();
+		nxpwifi_process_uap_txpd(priv, skb);
+	} else {
+		nxpwifi_process_sta_txpd(priv, skb);
+	}
+
+	if ((adapter->data_sent || adapter->tx_lock_flag)) {
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_inc(&adapter->tx_queued);
+		return 0;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+	nxpwifi_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+out:
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, DATA, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case -EINVAL:
+		nxpwifi_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n",
+			    ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+
+	return ret;
+}
+
+static int nxpwifi_host_to_card(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb,
+				struct nxpwifi_tx_param *tx_param)
+{
+	struct txpd *local_tx_pd = NULL;
+	u8 *head_ptr = skb->data;
+	int ret = 0;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop TX packet\n");
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+		return ret;
+	}
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(head_ptr + adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, ERROR, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode &&
+		    adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		skb_queue_head(&adapter->tx_data_q, skb);
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+			atomic_add(tx_info->aggr_num, &adapter->tx_queued);
+		else
+			atomic_inc(&adapter->tx_queued);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+	return ret;
+}
+
+static int
+nxpwifi_dequeue_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_tx_param tx_param;
+
+	skb = skb_dequeue(&adapter->tx_data_q);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		atomic_sub(tx_info->aggr_num, &adapter->tx_queued);
+	else
+		atomic_dec(&adapter->tx_queued);
+
+	if (!skb_queue_empty(&adapter->tx_data_q))
+		skb_next = skb_peek(&adapter->tx_data_q);
+	else
+		skb_next = NULL;
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len : 0);
+	if (!tx_param.next_pkt_len) {
+		if (!nxpwifi_wmm_lists_empty(adapter))
+			tx_param.next_pkt_len = 1;
+	}
+	return nxpwifi_host_to_card(adapter, skb, &tx_param);
+}
+
+void
+nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (adapter->data_sent || adapter->tx_lock_flag)
+			break;
+		if (nxpwifi_dequeue_tx_queue(adapter))
+			break;
+	} while (!skb_queue_empty(&adapter->tx_data_q));
+}
+
+/*
+ * Packet send completion callback handler.
+ *
+ * It either frees the buffer directly or forwards it to another
+ * completion callback which checks conditions, updates statistics,
+ * wakes up stalled traffic queue if required, and then frees the buffer.
+ */
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+	struct netdev_queue *txq;
+	int index;
+
+	if (!skb)
+		return 0;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv)
+		goto done;
+
+	nxpwifi_set_trans_start(priv->netdev);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT)
+		atomic_dec_return(&adapter->pending_bridged_pkts);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		goto done;
+
+	if (!status) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += tx_info->pkt_len;
+		if (priv->tx_timeout_cnt)
+			priv->tx_timeout_cnt = 0;
+	} else {
+		priv->stats.tx_errors++;
+	}
+
+	if (aggr)
+		/* For skb_aggr, do not wake up tx queue */
+		goto done;
+
+	atomic_dec(&adapter->tx_pending);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	if (atomic_dec_return(&priv->wmm_tx_pending[index]) < LOW_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (netif_tx_queue_stopped(txq)) {
+			netif_tx_wake_queue(txq);
+			nxpwifi_dbg(adapter, DATA, "wake queue: %d\n", index);
+		}
+	}
+done:
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_write_data_complete);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body)
+{
+	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
+	struct sk_buff *ack_skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!tx_status->tx_token_id)
+		return;
+
+	spin_lock_bh(&priv->ack_status_lock);
+	ack_skb = xa_erase(&priv->ack_status_frames, tx_status->tx_token_id);
+	spin_unlock_bh(&priv->ack_status_lock);
+
+	if (ack_skb) {
+		tx_info = NXPWIFI_SKB_TXCB(ack_skb);
+
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS) {
+			/* consumes ack_skb */
+			skb_complete_wifi_ack(ack_skb, !tx_status->status);
+		} else {
+			/* Remove broadcast address which was added by driver */
+			memmove(ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16),
+				ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN, ack_skb->len -
+				(sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN));
+			ack_skb->len = ack_skb->len - ETH_ALEN;
+			/*
+			 * Remove driver's proprietary header including 2 bytes
+			 * of packet length and pass actual management frame buffer
+			 * to cfg80211.
+			 */
+			cfg80211_mgmt_tx_status(&priv->wdev, tx_info->cookie,
+						ack_skb->data +
+						NXPWIFI_MGMT_FRAME_HEADER_SIZE +
+						sizeof(u16), ack_skb->len -
+						(NXPWIFI_MGMT_FRAME_HEADER_SIZE
+						 + sizeof(u16)),
+						!tx_status->status, GFP_ATOMIC);
+			dev_kfree_skb_any(ack_skb);
+		}
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
new file mode 100644
index 000000000000..f3d24bf861ca
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP TX and RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/*
+ * Drop bridged pkts from RA list until pending <= low threshold; return true if
+ * any.
+ */
+static bool
+nxpwifi_uap_del_tx_pkts_in_ralist(struct nxpwifi_private *priv,
+				  struct list_head *ra_list_head,
+				  int tid)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct sk_buff *skb, *tmp;
+	bool pkt_deleted = false;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	list_for_each_entry(ra_list, ra_list_head, list) {
+		if (skb_queue_empty(&ra_list->skb_head))
+			continue;
+
+		skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT) {
+				__skb_unlink(skb, &ra_list->skb_head);
+				nxpwifi_write_data_complete(adapter, skb, 0,
+							    -1);
+				if (ra_list->tx_paused)
+					priv->wmm.pkts_paused[tid]--;
+				else
+					atomic_dec(&priv->wmm.tx_pkts_queued);
+				pkt_deleted = true;
+			}
+			if ((atomic_read(&adapter->pending_bridged_pkts) <=
+					     NXPWIFI_BRIDGED_PKTS_THR_LOW))
+				break;
+		}
+	}
+
+	return pkt_deleted;
+}
+
+/* Delete bridged pkts from one RA list; rotate index to keep fairness. */
+static void nxpwifi_uap_cleanup_tx_queues(struct nxpwifi_private *priv)
+{
+	struct list_head *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
+		if (priv->del_list_idx == MAX_NUM_TID)
+			priv->del_list_idx = 0;
+		ra_list = &priv->wmm.tid_tbl_ptr[priv->del_list_idx].ra_list;
+		if (nxpwifi_uap_del_tx_pkts_in_ralist(priv, ra_list, i)) {
+			priv->del_list_idx++;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+static void
+nxpwifi_uap_queue_bridged_pkt(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	int hdr_chop;
+	struct ethhdr *p_ethhdr;
+	struct nxpwifi_sta_node *src_node;
+	int index;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					     NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Tx: Bridge packet limit reached. Drop packet!\n");
+		kfree_skb(skb);
+		nxpwifi_uap_cleanup_tx_queues(priv);
+		return;
+	}
+
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		     sizeof(bridge_tunnel_header))) ||
+	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		     sizeof(rfc1042_header)) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX))) {
+		/*
+		 * Replace the 803 header and rfc1042 header (llc/snap) with
+		 * an Ethernet II header, keep the src/dst and snap_type
+		 * (ethertype).
+		 *
+		 * The firmware only passes up SNAP frames converting all RX
+		 * data from 802.11 to 802.2/LLC/SNAP frames.
+		 *
+		 * To create the Ethernet II, just move the src, dst address
+		 * right before the snap_type.
+		 */
+		p_ethhdr = (struct ethhdr *)
+			((u8 *)(&rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+		memcpy(p_ethhdr->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(p_ethhdr->h_source));
+		memcpy(p_ethhdr->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(p_ethhdr->h_dest));
+		/*
+		 * Chop off the rxpd + the excess memory from
+		 * 802.2/llc/snap header that was removed.
+		 */
+		hdr_chop = (u8 *)p_ethhdr - (u8 *)uap_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)uap_rx_pd;
+	}
+
+	/*
+	 * Chop off the leading header bytes so that it points
+	 * to the start of either the reconstructed EthII frame
+	 * or the 802.2/llc/snap frame.
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Tx: cannot allocate new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return;
+		}
+
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: new skb headroom %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
+		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+	}
+	rcu_read_unlock();
+
+	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+		/*
+		 * Update bridge packet statistics as the
+		 * packet is not going to kernel/upper layer.
+		 */
+		priv->stats.rx_bytes += skb->len;
+		priv->stats.rx_packets++;
+
+		/*
+		 * Sending bridge packet to TX queue, so save the packet
+		 * length in TXCB to update statistics in TX complete.
+		 */
+		tx_info->pkt_len = skb->len;
+	}
+
+	__net_timestamp(skb);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	atomic_inc(&priv->wmm_tx_pending[index]);
+	nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	atomic_inc(&adapter->tx_pending);
+	atomic_inc(&adapter->pending_bridged_pkts);
+
+	nxpwifi_queue_work(adapter, &adapter->main_work);
+}
+
+/* AP fwd: mcast/bcast -> up + bridge; unicast -> bridge if RA assoc, else up. */
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ra[ETH_ALEN];
+	struct sk_buff *skb_uap;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	/* don't do packet forwarding in disconnected state */
+	if (!priv->media_connected) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "drop packet in disconnected state.\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	memcpy(ra, rx_pkt_hdr->eth803_hdr.h_dest, ETH_ALEN);
+
+	if (is_multicast_ether_addr(ra)) {
+		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (likely(skb_uap)) {
+			nxpwifi_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+				    priv->stats.rx_dropped++;
+				    dev_kfree_skb_any(skb);
+			return -ENOMEM;
+		}
+	} else {
+		node = nxpwifi_get_sta_entry_rcu(priv, ra);
+		if (node) {
+			/* Requeue Intra-BSS packet */
+			nxpwifi_uap_queue_bridged_pkt(priv, skb);
+			return 0;
+		}
+	}
+
+	/* Forward unicat/Inter-BSS packets to kernel. */
+	return nxpwifi_process_rx_packet(priv, skb);
+}
+
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *src_node, *dst_node;
+	struct ethhdr *p_ethhdr;
+	struct sk_buff *skb_uap;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!skb)
+		return -ENOMEM;
+
+	p_ethhdr = (void *)skb->data;
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+	}
+	dst_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest);
+	rcu_read_unlock();
+
+	if (is_multicast_ether_addr(p_ethhdr->h_dest) || dst_node) {
+		if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)
+			skb_uap =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		else
+			skb_uap = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(skb_uap)) {
+			tx_info = NXPWIFI_SKB_TXCB(skb_uap);
+			memset(tx_info, 0, sizeof(*tx_info));
+			tx_info->bss_num = priv->bss_num;
+			tx_info->bss_type = priv->bss_type;
+			tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+			__net_timestamp(skb_uap);
+			nxpwifi_wmm_add_buf_txqueue(priv, skb_uap);
+			atomic_inc(&adapter->tx_pending);
+			atomic_inc(&adapter->pending_bridged_pkts);
+			if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Tx: Bridge packet limit reached. Drop packet!\n");
+				nxpwifi_uap_cleanup_tx_queues(priv);
+			}
+
+		} else {
+			nxpwifi_dbg(adapter, ERROR, "failed to allocate skb_uap");
+		}
+
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		/* Don't forward Intra-BSS unicast packet to upper layer*/
+
+		if (dst_node)
+			return 0;
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Forward multicast/broadcast packet to upper layer*/
+	netif_rx(skb);
+	return 0;
+}
+
+/* Process AP RX: check RxPD/len, handle mgmt or 11n reorder/AMSDU, then forward. */
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u16 rx_pkt_type;
+	u8 ta[ETH_ALEN], pkt_type;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
+
+	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
+			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
+		priv->stats.rx_dropped++;
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->stats.tx_failed++;
+		rcu_read_unlock();
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->rx_seq[uap_rx_pd->priority] =
+						le16_to_cpu(uap_rx_pd->seq_num);
+		rcu_read_unlock();
+	}
+
+	if (!priv->ap_11n_enabled ||
+	    (!nxpwifi_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
+	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
+		ret = nxpwifi_handle_uap_rx_forward(priv, skb);
+		return ret;
+	}
+
+	/* Reorder and send to kernel */
+	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, le16_to_cpu(uap_rx_pd->seq_num),
+					 uap_rx_pd->priority, ta, pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
+
+/*
+ * Build TxPD for AP TX: push aligned TxPD; set bss, len/off, prio, delay, txctl,
+ * flags.
+ */
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_txpd *txpd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	int pad;
+	u16 pkt_type, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+
+	skb_push(skb, sizeof(*txpd) + pad);
+
+	txpd = (struct uap_txpd *)skb->data;
+	memset(txpd, 0, sizeof(*txpd));
+	txpd->bss_num = priv->bss_num;
+	txpd->bss_type = priv->bss_type;
+	txpd->tx_pkt_length = cpu_to_le16((u16)(skb->len - (sizeof(*txpd) +
+						pad)));
+	txpd->priority = (u8)skb->priority;
+
+	txpd->pkt_delay_2ms = nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		txpd->tx_token_id = tx_info->ack_frame_id;
+		txpd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (txpd->priority < ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
+		/*
+		 * Set the priority specific tx_control field, setting of 0 will
+		 * cause the default value to be used later in this function.
+		 */
+		txpd->tx_control =
+		    cpu_to_le32(priv->wmm.user_pri_pkt_tx_ctrl[txpd->priority]);
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(*txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		txpd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	txpd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!txpd->tx_control)
+		/* TxCtrl set by user or default */
+		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
-- 
2.34.1


