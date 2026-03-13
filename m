Return-Path: <linux-wireless+bounces-33186-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBaAO1C1s2l5aAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33186-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:57:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0127E693
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7E43026A85
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C24305046;
	Fri, 13 Mar 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="U2m+GO+0";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="MLSh6mdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E32594BD;
	Fri, 13 Mar 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385037; cv=fail; b=AyJihVNKOIwiA6O5oFOH0moCJXqRJIP5YfmAuoVzTbB7bPXBfmy+SgDIaNspUX5nbuLkwHwKXq5UvZPcJeUufEbq9ZKqcROmluqJSlTw6LWa1sdM67XTAk0YsAW3hMbdvhXHDey3d2GFC6FAAgBV9T6kRXnm+3hSQooXsZZw+OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385037; c=relaxed/simple;
	bh=XYbLdQyFOGJBi19wg+6JFjyONtHLMTuqljxL2xbbdto=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LjWn6YHYl9vhSbcb3VdXcmamkymdpyITTi+zVgHIJ/OTQ4ih/3YNjJtnexRzWTNKJxjelbNi+7xKLL4Rq8Iw0+H3hWMX53Amqy12PYDe/n5vFATa63xMgJW0uiCmyD+BC+tClH8D2rDMBWElcag1KFCyvbNXw6gmXESc5qM4PN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=U2m+GO+0; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=MLSh6mdM; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5Ldwr2016793;
	Fri, 13 Mar 2026 07:57:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=xBRe9vwLB0SGPiYFydJ5uU
	57Wj/ZEG4JAKpVw9Lf8DI=; b=U2m+GO+0ucGo6iCEisgvy/R9wtSWmyhtbVmb6M
	rd/E/MLRwaqmvFWMyP4ulEnOLB5WR3AI2DAAS56U7RV275kuFvAZF2ow3vOkreAd
	KEc7D66ZtUxyfPEuVuRCWnYif2yeM/NBG7sz6qgyYSwj8SHK5q2C7IEQNqqD+lAa
	51vGXjtHWgJvye1qMkkG/7kp9D+ZA2Oy4cZOceTcLjU6clMiTNavzJ1vjigUjfBI
	4N1+9qMgch5+oi87Mbv3j6fYNv+AUzzoYVPMMMLbqLdnzZYMjrWu4Jah5XmOzqRN
	bwdCo8SpoYWNNiqifMdFW8V0zI4aSwDY+hTjeoYzNJez08PQ==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ctxy4jch3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:57:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCrVwSI1j7Q9Js5TTrpb82AUzBXryfmDFof9aRRTxHi2GDC5mzmw8mpaRD442aVYy3y2awxBmG6VWjAz4xbiNtPo2hfppQQuCSRRhJoA9qtU+lZQw9G502OA2mtU0Vwq06cjiAxNAS5wh8ob8odYMDJJy5HnwfRYb85dl5ghALv+NwBU8Kq4aOnUNpd/FodF4y/+vyiQGIUMo2YXM3UJ9Hq9uiin/eyGe7SeSpXKM3PwlwUaKnhDtLD5MpZcY4hm0PbqdO2H/4/rdLeZJ2jULlDoDKzbXKFxaNcBIDbMQ8i0IDlpz7ZcjMk6+/i3owDP4bUi1cl5b2EPjWvx6/Vm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBRe9vwLB0SGPiYFydJ5uU57Wj/ZEG4JAKpVw9Lf8DI=;
 b=ud8SBsCNHiteOfjAmsg5ILw8FMtoiNliD/SBUTR+TVPinZ7OHRglDIeJZ0iPC9RdjYLTgbIo2JsZFg9xI+WFbhtgRZ79FrSsWUAQnx2lGkHzGGwVfTEtPRcT47EeP9JDM56PCspeYIKzlqXj2JoxHscg8qgvz4yo4CRZoNL5yMw9MRI9+ByEE7J4mxxEVwDuyNeN9//0/bFZemW4i2pykL7WkUnBRmH/ewdU1yzQVZpffJQIThE7lHT1+CQQSaBHIgmgA1MvGXADRfOoaMI7ko9SHTyQe0QEn/kAGw0GMd++v5ny2Tfm5nRj+O9I0KBpEn72/Nwq/35BRP+iMd0oXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBRe9vwLB0SGPiYFydJ5uU57Wj/ZEG4JAKpVw9Lf8DI=;
 b=MLSh6mdMVqo66C31BauEx9CMtYC43QoGbUkZwhxRXPGsdlyq8gg3gYEcCLJGYje7Fj23NVwvKZFMDu/Uh7pN6vFT8C1mj4C7VB//dxCJ6fPyc6QYJetgLdhLTZGDiMZL/llZeEIr6PB694BFm2ZryvTDi/DaV6OHnCtS22uxDiA=
Received: from PAXP192MB1168.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1aa::17)
 by PR3P192MB0619.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:2b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 06:57:02 +0000
Received: from PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 ([fe80::2346:6c82:47c:cee7]) by PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 ([fe80::2346:6c82:47c:cee7%4]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 06:57:02 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] wifi: ath12k: fix endianness handling for SRNG ring pointer accesses
Date: Fri, 13 Mar 2026 07:56:56 +0100
Message-ID: <20260313065657.303604-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F6C7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::650) To PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:1aa::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP192MB1168:EE_|PR3P192MB0619:EE_
X-MS-Office365-Filtering-Correlation-Id: cde83dff-c431-4c32-aff1-08de80cdbab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iAvD2V56x5wTUY1Nrj1a9xzlNenQl/8sitiYU/FxPG4IoGwIwAaUfZxUat1nz490y9KbzBcwTqE8kE/cZ80UhjW56H4ky1VcptE0zbykS7OSOMFCKCl9UYKq3xCLsVz2WtYWLI7Q46eIuittISFE0gAKSkwgfGv+M7JxvQIvjWZvVg+tuiYAdUXODTw0yazEDbN12GhoWiqVSTlojFYSdmZ9ym/ybKmYU6AMj4Qs6ZbN+XPYLtt/YNqPfZ5OgZt8kIbkDXTdvS37VeP0Rv+9ap8EuCJuIeTFvUOTbjeDBzHRKcPEHUIIaRaYRTzhGdDJth23lqLfHzaxH4R/zXBrgbwNt57zdZj2ySjSLL2omsir3yJmVZik1wPDDCIf6A3SRDi8gqckgCYj0Qy7NxufPRogw0spLkO46m6/debHA4MAI9gpvcwAoYyTF9DMHw7zxafNkdrkxN0V9WHPR/iG/ZrWVby95mp7lbtIohJLUlE9x7doUttZKyV0jDUk7RrXKKE5lB2uPCq7Nfjsf+bYQmowJNgXbfYnvJ9n/7b8bbnY1uuYuNDfbviz1OOlAPIHaavuNmVPnrQwMvWXS/frV5cM7vKdUsWzOeFmXGp4yYFKDL3Uclqj6NYplgcqoRY9lfBdCZPe10cEbduAP5px8k9EGBmhCt1Kr1CI41zdFBAmoFZ9HYvo+KYhHwe717TfukUESY/wVrYK4R7Vwej+Qx7+mcwZ9HXtL39rgV/XaPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP192MB1168.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTxyH/HYrE82Uuui02vOVD7uKqFEldVQ4ltM/i8nCLmv93o+ProLLRrP/2Xa?=
 =?us-ascii?Q?Ha177x/QRjLKC5aKraOfCBLmJ6ODrky6JpgHhsUFN/PmxpOqIYgvFChF8Vqq?=
 =?us-ascii?Q?sp/wejSW22br+ndKlAF1occ23OG7TsgLm81M6dvli4ZCgq/ekWJzyh03e7Jn?=
 =?us-ascii?Q?H3nHIQvHsurnEVY9p368Ou5DUVJIt48XWv3LVysrY/lGtRADUwKSAiH7QdeX?=
 =?us-ascii?Q?A0T6om+oW7nuLlEWgDnRmNIzCCo0QbRolgmZKpwU5CHHarWnNFMe83BZFmMX?=
 =?us-ascii?Q?r/lPfO7M8aTPzelp4278Q5zEwnbRiX2+r+w8qr6NGtMm8yOJ+5jzlFnQEa/F?=
 =?us-ascii?Q?4MDvapub0QeNXGdBNoqlj9XxqhKLgRtg4CLeFeNsfWRYgXzf2h49rSwK3Oko?=
 =?us-ascii?Q?bGj0jSQ7CrA/Gnu7T8VoYvBe2a+xoTrwjMVE2aDxT62kNi19dAF30YumxIib?=
 =?us-ascii?Q?0LDgfNUDiUCZ289uTv9I0uKbhHnQB+zSnsQiWKQk1WNck/f7MpiA8Q7cD6ml?=
 =?us-ascii?Q?nUAl1P2PDOla4WUfLoXMXT41888xsshTRunORKHMN5MwuFkUJbl/Rcook9tI?=
 =?us-ascii?Q?AX+DOD4AKVclkxQLPLIZGo6IS3clUovlIxFJvI9vLDuUU/RI1jF+Wbiq0iRJ?=
 =?us-ascii?Q?q9+j9hDCfIgbPP1LvopiqqlevVHMjwShY2ejwcxS7dEfSOPj8SMOvyt1f9LD?=
 =?us-ascii?Q?SC4WL5CMKy40OX3XGPRYTKRnLinPllqNNiXc3zCLBEaGw6bWX9ljfD0+z8JZ?=
 =?us-ascii?Q?u2nlqALu18KzF5rsY8G7Gx0d5xl3lpekBA2BOz5GECc/pa901o9V1XwpCvfF?=
 =?us-ascii?Q?cmHDVUJxGcX9lr2XrUeV1wFElBlYZ5TIEScWh0kcw1pDtLxZ3Ffgw8pjUn9r?=
 =?us-ascii?Q?NnG/Ybkx/TnkS9BNZlVOiDrBh6uMkEhz3OZm9jEAULMHEXBnszOs4iPbePIu?=
 =?us-ascii?Q?MDl9XMAGIx2d+/7i2nUwMklzn9KuHuAdIBNcj4cHqbefUX6hIwsnfswVgzJ8?=
 =?us-ascii?Q?3lxkkDD0zbb4t7Sw/WOfJhRCzJlgv6p97dibyDmbKbyDee8uAe9JoZ77Z2v4?=
 =?us-ascii?Q?ycVQw3EIcVB203twBTruWCces5724VdOOGBIL+7YL96xQeAq4aIrVqtj3gCN?=
 =?us-ascii?Q?ArmDVLiwxJnD5BlFcCjy5QLuFSLzFuOmjBAl0HWJZBTUeCSqKyQ4RFFF8x0k?=
 =?us-ascii?Q?6XBgKsz1dN6TDiVQWDBktUwEZIFKbkl24MPyt7gYsOPMHySJoFkzocDT8+UD?=
 =?us-ascii?Q?cg4boAIsCxYb5BRftT5LFabHp894lumcHO+F2mRaTlHtNXEJEy2GKH1D49aL?=
 =?us-ascii?Q?wthTpKrggM4+QOv9yvuEBZQVtDbhAsa8TfxPDA5zyaeYZKieaB3C6R9M5zNp?=
 =?us-ascii?Q?rpc778gI5xjLtMF0zn6BU6KsVOoeoNn43Vo8K2kNHxVHi0Tky5HAOKmDWdmN?=
 =?us-ascii?Q?jociQphzM3LPoyNlQ66fWjsPcSgpzq5fows42BMdyUZRHG4eFaH9YK+3i1QU?=
 =?us-ascii?Q?b6G+0ciWp2r+0fQY3p8yLFVHd109basW4ae4B6pjlm1OCiJWOeIO+r7Ogp6v?=
 =?us-ascii?Q?AuYD7qu7x+XbZjT5klgm3tgLIg9VBzvQ6lf+UboNIOH5/KwhGpv2zjrb/EhK?=
 =?us-ascii?Q?0eJid8bSWxPf5dApoWGSJPjL6Di2wX2CHkiMRq/p23tBRd9bjsN8lDmMVBFg?=
 =?us-ascii?Q?pGrTIuCUuVqr1m+sxrZtqsYn2shOg2DX6Ohtd4HAMIYYoOAoVVU53Hwuerc2?=
 =?us-ascii?Q?7DCAWDTmWA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	M3OQk25FwzIgfOb9Ub6UC5M6XNb946yFeT9sh4B0uIuSZ8eLGnLUZqW4xH5d9FmZ5HGvI9zXOhsgke4Xuqddhr3ejdO/l7XrHhTC+GH4P+ZdG0nGrsf7SYKT220lU3ArKXS4B8qL8yIwlivwS9wtOnjYzh2pMKsQgSLlw56KIYaaltyGIxu3DjfHwz8+9biZyHzdwl0lGhWRdbivxZlEHSeEI/M+zymApgUk3hi+e6l8ZNt1lY12c/rm4Q/q0A1wuIJztTA1fN1k9Y2MhbvThDaXrDu08zxcDDGMGgQEvjOM9hcQXcB/MyvWKKR9jMs7FiMKgOXccd5k4FOcCTxDmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RxKmQLHu0ZOAzaxOTh1Q3t0SAJD1b9sZ9RJ/gj0NDS7cKx18Nt/M8JlKC+OWNXSrswrKUGbctpv5yEGLAZMRKABGLOwd9yiObm39rIOcACLURZIoRGpGlurB1dbP1A4dmqK/5ptIFPHaq194tMOq+/3nCzmc58fVsOwX2sdalaSJt+iRUqsaYs9JoChQMdF/pWeQ0FGubUVbUJ8lLxCoLUoEr1JPL97k00a3a7OuxI1CTKg6XN4HQd95SvmXlr9x5rbMUEV5r1TSnl9VTJ9paWpz+qWXHt/Dc5BCkjcu2Xam0cfAIP6khPvMlbPvGgyoO0LLrzTn80Eo8jWzeOcNHHTIy6iNsRCSLh3/ncut5HfPJSJWcvKs9HdS9cE1YtbACqbwO9P4UR1hPRzGJ+8xavoBS6p49SybEMGuLOpbXTD4osx2l6PY7pCt5yG1kpBX7yrrvs9vhCxbdRI5Q3Iklk6MvbBgpCL5qSjIt4eLKxh8G/NjFNQ83EnR2X7W2wAO1yZsqJBsb43oIXOlyrBeVFyAXAcxGRrpRN6wKxwQ6Lqlz4vppCoWLJsOgywA4HeCuJDE6aXeEhEbJWvusH2x5Ep0s2YwatRQ7Fn0rX0n6WpEEovUMqyNJug5B1xiAM+K
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde83dff-c431-4c32-aff1-08de80cdbab0
X-MS-Exchange-CrossTenant-AuthSource: PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:57:02.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccmbQo7M+3r8Ldt7DxGq1X1fH2veNUemY+MHs+wxYBp+NFvwKbL/3lfnLhBxYq6ArogDM1vtHI9+CI6pmSPbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0619
X-MS-Exchange-CrossPremises-AuthSource: PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PR3P192MB0619.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=deaNHHXe c=1 sm=1 tr=0 ts=69b3b540 cx=c_pps
 a=MgZwUjY4L3PVdcQOU+00KA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=xIER7TDS9NvsDhoS_LkA:9
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NCBTYWx0ZWRfX1j2xh7s0pxpZ
 AZivTe1ew/UZ0vtNHvokxAjvQXehgcXfri/OhBRxafrV/HyOm6YsodGtEnvDdQKiZxZT/F0fP88
 zTzIoYnW0WMrbbm9QkURV2jtD7vHrRPGu4CvZtwE7tU6A9ggwQtgz+Fj4is8i4o4Vq08X8uxGrm
 5Kiy7sVJTwMYDhGkZ5GzovXpQ4vc6eruIgfScmKPAB22ObGy68wEEjWGhP6TCv9Tb+LylEXUx11
 zR0l4ZehKD1cCRjdlFBYIuEsj+IiuDmTPXACbf3/YsDYhtlvh4bcq6EhBBUPUnCAM967A0/5pAE
 iAuZ3/J/Nf85tWru5NvoQf8Ow+EOvKX39rTx1p5A/JOYcYCBAL3hTNmOQJ+nq8FeO0ItQ4+MTJ2
 8MSYecPlM33zz45TPQS8KMgWYuK1TmDO0ZCF2dRO1ziiXKED8lL8pitbe0SjO2E08j63TmMavls
 CfOR03A45bOgnJy8Rqg==
X-Proofpoint-ORIG-GUID: 5mhbArj2WhY5oD-U3H9Yqqhb2eCYBxce
X-Proofpoint-GUID: 5mhbArj2WhY5oD-U3H9Yqqhb2eCYBxce
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33186-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim,qualcomm.com:email,westermo.com:dkim,westermo.com:email,westermo.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51E0127E693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SRNG head and tail ring pointers are stored in device memory as
little-endian values. On big-endian systems, direct dereferencing of these
pointers leads to incorrect values being read or written, causing ring
management issues and potentially breaking data flow.

This patch ensures all accesses to SRNG ring pointers use the appropriate
endianness conversions. This affects both read and write paths for source
and destination rings, as well as debug output. The changes guarantee
correct operation on both little- and big-endian architectures.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Changes in v5:
- Revert removing volatile from `hp_addr`

Changes in v4:
- Rebase on latest 'ath' master
- Remove volatile from `hp_addr` due to the `checkpatch.pl` warning
- Fix opening braces at the end of line due to the `checkpatch.pl` error
- Fix `u32 *` cast in `wifi7/hal.c` due to the `sparse` error

Changes in v3:
- Rebase on latest 'ath' master
- Use always 'le32_to_cpu()' macro for conversions

Changes in v2:
- Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
---
 drivers/net/wireless/ath/ath12k/hal.c       | 31 ++++++++++++---------
 drivers/net/wireless/ath/ath12k/hal.h       |  8 +++---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 14 ++++++----
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..9b55c516c9eb 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -355,7 +355,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	tp = srng->u.dst_ring.tp;
 
 	if (sync_hw_ptr) {
-		hp = *srng->u.dst_ring.hp_addr;
+		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
 		srng->u.dst_ring.cached_hp = hp;
 	} else {
 		hp = srng->u.dst_ring.cached_hp;
@@ -379,7 +379,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	hp = srng->u.src_ring.hp;
 
 	if (sync_hw_ptr) {
-		tp = *srng->u.src_ring.tp_addr;
+		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
 		srng->u.src_ring.cached_tp = tp;
 	} else {
 		tp = srng->u.src_ring.cached_tp;
@@ -501,9 +501,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
-			*(volatile u32 *)srng->u.src_ring.tp_addr;
+			le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 	} else {
-		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
 
 		if (hp != srng->u.dst_ring.cached_hp) {
 			srng->u.dst_ring.cached_hp = hp;
@@ -529,24 +529,27 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		 */
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 			/* Make sure descriptor is written before updating the
 			 * head pointer.
 			 */
 			dma_wmb();
-			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
+			WRITE_ONCE(*srng->u.src_ring.hp_addr,
+				   cpu_to_le32(srng->u.src_ring.hp));
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
 			dma_mb();
-			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
+				   cpu_to_le32(srng->u.dst_ring.tp));
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 			/* Assume implementation use an MMIO write accessor
 			 * which has the required wmb() so that the descriptor
 			 * is written before the updating the head pointer.
@@ -556,7 +559,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
@@ -711,7 +715,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 	 * HP only when then ring isn't' empty.
 	 */
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
-	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
+	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
 		ath12k_hal_srng_access_end(ab, srng);
 }
 
@@ -810,14 +814,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
 				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.src_ring.hp,
 				   srng->u.src_ring.reap_hp,
-				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
+				   le32_to_cpu(*srng->u.src_ring.tp_addr),
+				   srng->u.src_ring.cached_tp,
 				   srng->u.src_ring.last_tp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
 		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
 			ath12k_err(ab,
 				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.dst_ring.tp,
-				   *srng->u.dst_ring.hp_addr,
+				   le32_to_cpu(*srng->u.dst_ring.hp_addr),
 				   srng->u.dst_ring.cached_hp,
 				   srng->u.dst_ring.last_hp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index bf4f7dbae866..10f0f53dc83a 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -921,7 +921,7 @@ struct hal_srng {
 			u32 tp;
 
 			/* Shadow head pointer location to be updated by HW */
-			volatile u32 *hp_addr;
+			volatile __le32 *hp_addr;
 
 			/* Cached head pointer */
 			u32 cached_hp;
@@ -930,7 +930,7 @@ struct hal_srng {
 			 * will be a register address and need not be
 			 * accessed through SW structure
 			 */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Current SW loop cnt */
 			u32 loop_cnt;
@@ -950,7 +950,7 @@ struct hal_srng {
 			u32 reap_hp;
 
 			/* Shadow tail pointer location to be updated by HW */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Cached tail pointer */
 			u32 cached_tp;
@@ -959,7 +959,7 @@ struct hal_srng {
 			 * will be a register address and need not be accessed
 			 * through SW structure
 			 */
-			u32 *hp_addr;
+			__le32 *hp_addr;
 
 			/* Low threshold - in number of ring entries */
 			u32 low_threshold;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c05bfcffdf5c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -320,7 +320,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.src_ring.hp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base);
+				(__le32 *)((unsigned long)ab->mem + reg_base);
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
 				   "hal reg_base 0x%x shadow 0x%lx\n",
@@ -331,7 +331,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	} else  {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.dst_ring.tp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base +
+				(__le32 *)((unsigned long)ab->mem + reg_base +
 						(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
@@ -384,11 +384,13 @@ void ath12k_wifi7_hal_srng_update_hp_tp_addr(struct ath12k_base *ab,
 	srng = &hal->srng_list[ring_id];
 
 	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
-		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.dst_ring.tp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 	else
-		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.src_ring.hp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 }
 
 u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type)

base-commit: c2bcd89db970ee73cccfb9c619b7287d6da4bf88
-- 
2.43.0


