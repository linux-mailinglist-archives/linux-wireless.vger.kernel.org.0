Return-Path: <linux-wireless+bounces-35419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI65FErZ72maGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:46:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F015747ADCC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11DF83119503
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D23A1A3C;
	Mon, 27 Apr 2026 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGLIeKER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D93385511;
	Mon, 27 Apr 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326135; cv=fail; b=IWn4Tf/iT8dr29S04BpCXv2Z6nLObUTRBh9Wc8jxNswTi8BiH8h5t4ziu/fhRzKJk1P0dWDgkvmI+QVdbGrwnYC1Nro/39gULxdxdX87Ne+MLjK4p4R84IKzdQu5cZ1BjkvLf+hPpR31xCk7ltfgIYe6dqMzUTqyLOn7kXvKc0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326135; c=relaxed/simple;
	bh=NmX7diBXWLVyEWL4ak+Olp1X4AFpXzF6+xq3S7BBRIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhwwfEIrckxEK7y9cumWHZeVDEOWpzeZE4T79kZVUa4gwlvnH9wZVfXsB/LG52wCGC6dtjOibn0cZdFVVcu3oJIgv9PsV5k3XzyCGFrR7jvbhya7o57Bi/4wTl/u1B9EzYElUApjJlxLlz4S/1tw1ABUfnaN7ao2PGfmcl3KRPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGLIeKER; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kdh4D9hy6pogmztdaxuzVSZ01RC0QIpEUOVIkA/A4E/IA6q8jlc8QTVzW4njB4FerzrhlOcmB5l7/6CGTYJ5PJNA8dC0W+ysFTAaCVLZbAo4IWLfBIzNI5gU9UowNrk++fIq+yhIDT86o9CwgkB8LdnHMsDT1hLjFBy22bhTJbWDo8IlY59M+7VBCPuo4H1a/Wa+mENkOh8qHuqe+hpTZmPdekRo/wU82cQloSGFcuaZbvZm07GwVoHeFk1bCyBoKz2AZcv+EfAgjgmCt0HNrOb/4blz2MWWXCcama5m8QCuRcdjRNdGgNCBmIRT6x27szx5Si37sOb2BJ1gsRwd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M75Yg7BQjU+KtB+Ke4YhIvkFQKWbOiRe5R+iAPCCmiU=;
 b=RLIrmweSp1O6zp/x7IMp1uhAeU8DlBGEYqnczDrgeIJqOp/IIBBDyoRnZ/6JwxlIxh16M7LSlv3ag5Jq8OQvYsqmFPwYvSWRg0yjLH2Q85Mr5dYO00p3rhfJUVvfj+1Xh6G54DkEd9E3ejCRlOnLesJhr9o3lSOE05gtcVz7SOdAOn2uNqDp5QCFwa8T7jz7G+TU9BUKZBl7tnr9ZcnPCnQ97sRUEMjS1955dL9CF0UHiEDlMRTU69wV3bZln7KLAKgI6Z35AvcXiVKExiNAs4/qgrT+wBWDpD93fMMQCOrhbd1c9LkcFMySkg00+udRVEHwKM3nsVeGqHdpPVc8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M75Yg7BQjU+KtB+Ke4YhIvkFQKWbOiRe5R+iAPCCmiU=;
 b=bGLIeKERYeKwCCOn4V7OZPHlZxYGTcsZ4CW8neHYRbeHEc1Z3W65M5fZt/z/p7DQpTtGaMI/ADI1Z405s7p6Cwa9eJltApYAJw5z/ybH3zJN3mRrAICoct/SENhfnzpvnBMBQPfFCUDyCfYBq2nWQtzlh/rksEduyWVNzxy/aEDphaVipxqu7K+TIF88vJF+EBGaWVR633JiPcyMNOjAofz2rCWsFC0FznnhlxlNPdKKhivrz31uC1q8IxHiy2rdUJ30eJ67Yc1/LUtY5jAQMokTNt3DZjUDDystiOe7d09rG4g1obhqZevFFtNj9I5JPTiQxcM3+pO1/AGiWsnyLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:41:57 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:57 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Ben Collins <bcollins@watter.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 6/9] iio: mcp9600: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:23 -0400
Message-ID: <20260427214127.406067-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0478.namprd03.prod.outlook.com
 (2603:10b6:408:139::33) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6bda23-9d7f-4e7b-678c-08dea4a5ce70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W8EMGw55og5q9DEhlw3lPSKV1w6BMMuwIW0jyz569KsLdClAr9+CzP1+QdCwzB/V712TBQqMZ5INWLUv9UkAYVbjqqHcf9COiISQdNFuvS9ABCZX4DGDq1lZyt9DdICazFzK9KYKnq6gndko9taZtY5oAWZcX6QtIbzx2RUyNb8w1fMMEFCVyMO/eeGVWFgZe5wGXNbYzuWQuc1ciceeJBYO4/4wpELQ9/xI0Um76afhG812XzfLjzx6hpnEOb0x0I2XtBK5Nkau6Sky2ymgHUK18mZ9+maiiUrnIk2fXbKnERXeGxI5bJXXBl8gjeo4g7pw/Yi68vCMHwzDvbBxZ5FasA96MwpMRJxichWfWiyrltyLeK4/MuxgJCE0cxNGCtwuMMVvLDanqq6B0yNd9fQLoc2mmEOflhA+wuEm3Ctj74viEP0iCwwggHNuCOHPT0iI/a3Y0tPSbw5V3EgaszoGvEyMVkBZnAID971nxwswwRCsMFOhiuSu7K4ueXZuEjDc5zWI5j9fOb0/4YUfeTXb37hCd5Z8WaPShIOyc0NJAL9z2roBATXuyiSGhe+uPvEaNku/p6fGOziVaP34Alo9R7hz7UWze0lnaUHL5ZNkdrDBfKul8vItojmC73rbeduRFhPJpFto1c6wCw4PuS8awtjDhI3O2OUOr03nSeBu/vKBlzIOSmFn5CmzXNeh9Jx4xd51hhaF2Bf3+W30z9gyV2CK1rYFQBc8mn5oQupf2qnyKGuEqDjZwRrAouZSQ2nMPJWbvj/XJzYEDiWtNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdtK1hlcTdHVWlhRjNiNVlWMFZwUm5nRWtiMEVtZngxTlVydUJqSkdzbnd3?=
 =?utf-8?B?eEdwSmQ3bENSMm16L3I5UCtiYVkyelV2eXJvTjMyTWRVWnFSMWNxMUY5bnZp?=
 =?utf-8?B?NnFKMFBIUlF5Q0wvZWpqMGh2dlhuWkczbUhHbUhWRkVMU1UxOWdGeDBBQ0JH?=
 =?utf-8?B?VHNRZXI1dyszVFlBV2tIR3l6c09JV3F1VGFMcXdMRXg0MS8xeGFmdVBicHcv?=
 =?utf-8?B?bDNFWkpYejFqQ3piTEJFNGtRVFZNdVU1RTQwT21VUXQ1c1JaZ01vYmY1MDN4?=
 =?utf-8?B?NStPYy9heCtxOGxESiswU2xsR29MbnlQaXdEaGNqRnhINmpuaVc4MkVkczE4?=
 =?utf-8?B?RXFmMUJBZlJ1OGRSUFI0SHFkb3pockFvSWpYRFpWSnZlY3lHTm5ucHlWTmNV?=
 =?utf-8?B?S1EvbFlNSzB0Zjk5c2RrQzg5ZGkxb2VzRk1iSjR2V0VlZnBBSHhmYlI5Rkxo?=
 =?utf-8?B?V1FZVXhjOTllYXBURURrczlkUU95a3R3K1JPSGlyS0Eva2hWM21xTVFoOHp5?=
 =?utf-8?B?emI5T3RCYThxR3ppemhjUkFvVk1tY3NKd1VWUnNqV2lzalp2TG50YjF1dUhQ?=
 =?utf-8?B?Q0VPUC9GcER0TlFmVnF3NHVTSU9tQlJ2NkhWeHU4a1pHdndrazYwV2dJY2Fk?=
 =?utf-8?B?RldyNW1hNWl3bXNpZzNSY0tTSmdUT0JhZ0haVlhtQWVyTlhISW1wWlZueXFC?=
 =?utf-8?B?NzFTYmM4MjZ5bm9hcEozYXVJQmNZL2FEWjZvZ0RZbEtxbWRyUENGZzhIb1R2?=
 =?utf-8?B?SG9MUVpncGZCNklMdENVQktjeTh5b0pZRkI5cm1tK2lGb0VKQjRwNW1XaCtk?=
 =?utf-8?B?T2VENTRPSXU3clo2bE9abTNGNXpscEIxakg1cTYranpaRUptNnlXa3FFd1l4?=
 =?utf-8?B?aFIzSk5HcjRzZ2l4SUZwczJMazFqbGxWa2o0aHNISWJNbU1IeElEOTBOaTN6?=
 =?utf-8?B?RjFnRE41cUZzSzBGbTZhcXhQZ2pzaUZMMXFoWHBvNE9jMUdtL3M2K3hVaHYr?=
 =?utf-8?B?SUsxR1JDSWdkR1VuRTMxZXZiSnZya1p6aEgwQSsrb1V5b0JLdlFWUGVIRExQ?=
 =?utf-8?B?WE5GYnVTRDM0djVsZ01TSWdvMk5DclNRUWhvd0xRS0xFQkNXUW52S1kweCtB?=
 =?utf-8?B?elQxbVMrckZkZTljb2NCRjVtREQ5MUtNcFFrbFZSc3o0SDdxS3djZVhFZ1Ey?=
 =?utf-8?B?NTc5QWpJYzNhWjZhZzl6elArOE5rVjJ5Z2orSnV3WmpPN3huZlRaUkJoejBl?=
 =?utf-8?B?RC9JTXRINkdReTNYYmtidEVvbVBid2xDMmVnTjBBZmFxeDVjam1pc1Nvay9q?=
 =?utf-8?B?LzBLZWV0Si90clZmMjhsbnlVOUxnakd1bi9VcllKSVl3MkRSbjFKc2FrTEJB?=
 =?utf-8?B?VTdpMEFNaHRZNm42NTcxWVJ6WXIrWWt6QjByYytadjdLQktFTlExQ0pQWk14?=
 =?utf-8?B?OWgvQjJkaTh0OU15akQ3QThZWlJPVFh1UFd0cTBUeUhnL0pFTzcyc1kxKzRF?=
 =?utf-8?B?OGUyQ1I1WG5Hd1pRSXJhb2dtamVoZkdxZThjMlN6azhObmwvaEpmRU1BcnR6?=
 =?utf-8?B?cnpWUmFvUG0wK0QxS2hXeUhqY1hoRVg2MkU1MEtxR1FMajBXc0NtY3VkWXQ3?=
 =?utf-8?B?eEhKaFVkSHVUblNRZk1id1VXZGVYUHpNVkVRQmFBK24rMSticXJJWUkvWk8y?=
 =?utf-8?B?UXBMTlhrMTZjZmZka0NMNWpRT2JJNnEvS1J5WTk0WHBhTk1mbkpRVVJlYkFl?=
 =?utf-8?B?UmFzRE4xamFKakhpbGdDVDhscUwwM2wvczhJTjd5U0hrWlhtWERaYkQwWjQv?=
 =?utf-8?B?d2JiWEcyQ040bWNKaUFDU1VGWVNXRHUzVWc5akQ3TTdLQVRvdXZRbHJuN0V4?=
 =?utf-8?B?SGgwWXlKd3ZOR3NsNUVmTm5mbEorQU4rYUxMNXFSMWdwSTJsN0VYYUFHbTRB?=
 =?utf-8?B?ZHFKU2QrQzJFNDFINlhIYkVSMW8xSHdwNG92Slcxc3JLTlFuMFpmVnV3SjZB?=
 =?utf-8?B?U1FuWnQzUE5TdjRRQlkxT3lxNGN5ZmdGN3RzdUtNMDdBdW1tbXpLOURPd0Ey?=
 =?utf-8?B?bjNqTVRCdVZjVUZDR0lHd2RGd1NvSGlFU3l1U0ZDcHRiNVJndGRHRkdockV6?=
 =?utf-8?B?S2tSMUpkUmg1SmtRQ2E2cHhoelhwOXdpUW5zcTM3K1E1Zk1EM1BCMkFjb0xs?=
 =?utf-8?B?MlFQb3Q0ZGIxVFNjTTBRQU5DOVQxM2trWXkycE93VmUweDYwdTRKeklsaWJK?=
 =?utf-8?B?ZE9Hd1ppTXVHMHVoOXVRTU9XOEdKOWduRGZHaVJkVjMyRWR2SDZudWh4d0xL?=
 =?utf-8?B?WDNtL2ZSSzFzWituZmovamVhVFBDYTVvRUh6bmFiSmNIeTFoeVlSZUMxcFVH?=
 =?utf-8?Q?8FKCONuWoC0dwbNaaOEKBLTqNKo8zPrY6tvhb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6bda23-9d7f-4e7b-678c-08dea4a5ce70
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:57.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfEfGlMgkM2XbBBxWVa8unDrrHdPtyX0g1JtfHLY0tAO+vY8C3/+ROCtLoI0RYzjLB1lw1Eq4Io8y6TO2kX71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: F015747ADCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35419-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/iio/temperature/mcp9600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index aa42c2b1a369..69baf654c9c0 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -297,7 +297,7 @@ static int mcp9600_read_thresh(struct iio_dev *indio_dev,
 		 * Temperature is stored in two’s complement format in
 		 * bits(15:2), LSB is 0.25 degree celsius.
 		 */
-		*val = sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
+		*val = FIELD_GET_SIGNED(MCP9600_ALERT_LIMIT_MASK, ret);
 		*val2 = 4;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_EV_INFO_HYSTERESIS:
-- 
2.51.0


