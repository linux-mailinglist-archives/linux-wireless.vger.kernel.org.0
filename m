Return-Path: <linux-wireless+bounces-33351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N8QOCVQuWnj/wEAu9opvQ
	(envelope-from <linux-wireless+bounces-33351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 13:59:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4545D2AA4EF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 13:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3353096A55
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7623C65E0;
	Tue, 17 Mar 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="e1B39WHY";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="f8+8E0Zc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9233A3E75;
	Tue, 17 Mar 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752120; cv=fail; b=cv/ibQssBPE0fM7M3nHNSVvlGLoojkLoXwmMjr0JFRQ8crrVjwWbjNnZATlK0cHjgRm5YO3IhPrhImUWF7rpMfdW9oX2bZ9lpDkoVagKJL/DfprvFGjp4CjEh/v+PZxk5BTglfCnp9YMvr9NiWjxM7HrzBOGElUjx5qZcrZNsjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752120; c=relaxed/simple;
	bh=VRTAtJEVQeCvBV7SFcJ/Ah+mBcxvxUkTIxlTHVKHPCM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=jjE2PHkGpd5iOrmLLvNxL97B3AXQV/vHARi+EBaEZ7dLPei59/6H17mQAr1mZfCLdSyTncvIiZN9cAmnzwJdJaTXdJX6OBRnCFO0jCvpMRxj4NJoC3S465yCMsxD7/y0rTOoygyZHFaBunY708vcxosg+u4EKrhJGO5DNJue2N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=e1B39WHY; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=f8+8E0Zc; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HCNSfJ3583185;
	Tue, 17 Mar 2026 13:55:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=4dD+etMu7/ptF3iZpItfWS
	UeToV3J4b2XlvRBfOAiwA=; b=e1B39WHYRAYn3XOa0whAGOTy9PUiuD+V647Js1
	5ausjlZ8im21vQWNIS8tcP98KMnsu6Ieq4sRWOHlUd5Zlx5h1mZzWIw0SNFHBE7h
	ANyYvTPreVBc5LyZQRSdBMKPKMPSewx5XLTckhN7dHV+uhypYYBTa2S60GOS90aC
	5H+nZ45DVWfTUfxa3aMF949p+jIrM5NiWz2Y1FLGa5Ogid2DO6KlIzsrFq8jmZgY
	sQkb0RVkZWQiGHehFbAW3urIr1h82quGpDQMssPyP9QA24CAxbLFCP27PQ2Mk9e5
	NrizS68Cit8mkwBozHxosBDF6niYsQQvGx8I/WI8WINp/gBw==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11022086.outbound.protection.outlook.com [52.101.66.86])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cy6wn80tv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:55:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrTIv13lA9C9Vl0g3pOeds+56Ivm9Ez1gmuPTI7VdC8p8oBOLJBqRNoIBRQOW04sRFkQn/P2YlHnSEk+Vh/XQGrvxmp340VBctYEIH15+27wlSWt0Y4HFgTKALuqghJ2PTaQBUi9sbZ+sDkt+WF3VUXs38fvq3lWSv6imW7WTzFIqJXSzN/L9mWPgu9lw8zb8FgY5Ch+L04SrMz1Ym6iFNAJPOmWUjJX4TQkai/m4utXxbUUaHnvbe5NJ/2KqfgL0ZHKmd3yb+VJSMEWpPMbUKGpckDJn/3gJHfIW/l/rBcblo0sWYph9QISHgTWOErUhFd2U4pxIdqpKpbklcmF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dD+etMu7/ptF3iZpItfWSUeToV3J4b2XlvRBfOAiwA=;
 b=R3EZpaTtVdozs/EOfn5NyPEUkYYcKkxHzkl/1kFai/1XEAGUAzYTWMzaEgoXGc//4TAfM7/j9Z0MT5OA6TRQB/wRu7M5lXXZAr/HaY6nknZuEhBrvJLy0bzTBUXPhoHV7EP0UayfksyBOPZ+fg8CjMc7PhBIBehPZ5zfPoFqsJcl5XyBU6MPRFu+T9gMu/UAIyj+H2R2tBh807JoJYAeuD8DCfBH9NwZQJLgA1aLIa40pXNd38WTTN/+AJOitJZrJXSFFC1ZQVawIjpRPVkJ2OC4Atk2AuQ90VpUk5s2A0qwtI6KB/ucTcHOzY+rSPm8FKujYo/p+HNGyGvfl55afQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dD+etMu7/ptF3iZpItfWSUeToV3J4b2XlvRBfOAiwA=;
 b=f8+8E0ZcetmHSBwV9KK8d3p2P2oYO7ZSY8mZheb/w+2P3gF2bOBoddT/rO7KONKkFfSuhZqpRxDcd/OHZnfs7s2V2gr7sU0i3l6as30qHFidfvNB4S715Lr6LJ+4f2cttBR19/ff7FHgJnvL6ogWADjmkO3JJwOutQ7dA2l+XTw=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PA1P192MB3088.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 12:55:07 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 12:55:07 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Tue, 17 Mar 2026 13:54:52 +0100
Subject: [PATCH] wifi: ath12k: fix channel list copy on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-channel-list-copy-v1-1-5e1e5ae1c5d5@westermo.com>
X-B4-Tracking: v=1; b=H4sIABtPuWkC/x2MywqAIBBFf0Vm3UDZC/qVaGE21kCYaEQh/nvW8
 nDPPRECeaYAg4jg6eLAh81QFQL0puxKyEtmkKXsyrrq0fCN32Jpx53DifpwD2oyrVaLbMzcQf4
 6T1n8u+OU0gtm2EZxZwAAAA==
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV3PEPF0001DC07.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::269) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PA1P192MB3088:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd26d23-feea-40d7-3ba1-08de84246a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EysfcrpGGDxj1+FB8xmqUP53hKpoN1mT3FtJedIOk1ys9N8gXKT7gnin0MKHzVosvuIEDr2kYtOL/fEVBJXq6hXSVHl0em/DpYWOcFxZEP/vdp2yfbsQj0eMr9nV8SC09HcP9TujjmDc8a0xXIZ3i5+c97meJNwYmvyriFBa667JSMmyDBR+KuISAr/G1ZmjH8Bp6EzPrJnCByD2/NcfGcCmjsPYtUYQI0/BEY51kjxV1V3jnTzQgHcolDWxOTnPhauU2qnbjkeyXyJDMJHk2wtu19oq1DKycj5BJo5PX8DnySFRs4EKjGE39Ri6ZEzNKibMnpz7zWncuKHdnhrImcWRqLBTBI2CxZYbDk1lZfJMs8cK9DgHBDDlp6X7XlGgH5HP+w0MzBxpBkKO286DNItyshIWDKywPdBwpVlduNFj7Qce1KyjSvu4SQ70dhllBnkKxGKSsz7B8o1iDIFJP6E93z0d93Yvbd6Vm7Bp2Ba3gSUeDqnYgJuuVP8TXOfT/zdwtsCXVwiL6N85JIuJk2pWkJ4c/7P8mEbC1HibOxKvJdM9pqGEbe4VKgXNsJxHLXl9mDpQwk4oKUF58phsbCCr78q+vy6zmO9IFJF9Pv7uEeI6+NluomRO9fQmh/eNNUyO2j+0UZ6vtmIGZcwtu5IW4aZ0T3vUuxFpmCcwDGWbozXICcgszC9oMPDdIAAZ+LPhv77G0wpubYemkvtFQgoCr6XwtzAn1b+yk3V97dE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW9XUkluQTJDWGI5RVA0bVJHUko2NCtGMGl0aFY0TXVLU1orV3FEbzA5R3Vm?=
 =?utf-8?B?VTdaM2VrRmg3ZmFXMmlsV2tHVkNxMGcwZUl1aEFKcXBQdlltT2VKbENnVWpl?=
 =?utf-8?B?bmtKRGhmSzdlWS9nYkUwT2JmQkRYR1IzU0cyeTRicjZhQVJvbFBDYkIzMmlB?=
 =?utf-8?B?TVdhMFBnWjlCNjl4NUNQSWNraXA2ek1wd1hRcC9VQXd0RFhHbkhOa1dIcnJa?=
 =?utf-8?B?c3VxUUlvVTJENzN6RmtRMDBndmlGZWZiOUlmWVVNRmFEMm5CemhtS01VUHNI?=
 =?utf-8?B?eEMySDl3MUpPTEtNUXVxVFVNMDQwcEhNM2VlbWhFN1hBTkh5eUwyckZ6Rmhz?=
 =?utf-8?B?ajRlYWtva1J3WmRic2p3b3htUnJTK0ZVa2g3MWVnYzVoTERSWStxZG5Qa3FJ?=
 =?utf-8?B?WjFSUDlRa3pEVnBWcnhsSVk5blNaeUJ1M1orYzhXT2Rvb3Y3Q1Baa0FyY2Ru?=
 =?utf-8?B?Q3A4ZlhuRjA0dEtWQml5TzlLRFltZW9xNEdld29Gck5IN3hhVE1VQmdqQ0cw?=
 =?utf-8?B?dmFrTFZXbzhyeGpKV3RhZ0hxZUdSQzlVSDhseHBnSFBjN1piTjMwMWRoSE5k?=
 =?utf-8?B?OUFLUXY3N3l1UEwrZ081bjB1QmoxZm1VeXYzVzJ5Ui9TZ3JRZTRkb3NTeWZK?=
 =?utf-8?B?UmpidkExQTdlMUZhcFZwWHp5WmpZeVo2RXlCdWVvNXEvcFdCeWNFeXhjVXpN?=
 =?utf-8?B?Q1FjbVNCUC83MzRDTklaYkZENDMrZVQ3VG0rTWVlUFBoZmpwSjViak54bFNp?=
 =?utf-8?B?VUdTeFlnUXArMGFtOVlxb1FJY3pic0Q1ZlpqUzlWU3hoRFlDOWdUd3VmbGM2?=
 =?utf-8?B?aFJtbk9NL0N4eXh2c0lET1ZIT1R6MExEZVVqeEJNbDR4am5GQ1VYZ2lJRWpS?=
 =?utf-8?B?SUtYMHpDTkxoR1I0YWQvTHQwcy9CRkhMMjI5NGpvMEFYUmIzV1VOK0dzR3hE?=
 =?utf-8?B?enZxeW9vc01OMEY3eU54YTV6cnYwMUpBOWZ0ZEpZYWlMdzZFajlLWWFIZ0w5?=
 =?utf-8?B?bFl3UUFmVm8zNExXOWtVckZLMGFCSUJxQWxVY0FrYlQxTGlVeEJtMmtTWmYx?=
 =?utf-8?B?KzNoSDZTVGNIVloycDQvT2hSUHBNVEZYeDdTdVNHcUFOdTVGT2hiUjJnUjRw?=
 =?utf-8?B?UGRTVWdldEJvQ0VjUWVqdmlxSENzcWpwRkhnUUZha3RFVGt5eTd3bHZkd2dz?=
 =?utf-8?B?cG96aGg3MDVQbXozUWZrSy8xS2MwQ3g5V3J2aDdTeXora2RmeGJ1YkVhWnJm?=
 =?utf-8?B?Q0ZkYnNENXdRKzk0VkhBMFVOQ3JnYkFrRUovYk1nVk9jdTNScVEwQXl2cWc0?=
 =?utf-8?B?bXZWK0htcjZ3NFphZnVwM0tNU0RlOXNZWUg2aWE0Zk1Ic2JheXdNSG03UURQ?=
 =?utf-8?B?V2xWTndPSTJodkxrbFEwbTNhTTBTbmYxVjB0dWNzM2RGV2M1MHlaUCtrWE1N?=
 =?utf-8?B?UmVpR05tVlBSaFZFYXpEMjI2QzR4SGNjbWlabmNnR01nSmQ5L1p6cTZCMmsw?=
 =?utf-8?B?UWxIV2ZnVVRYL29tNTh1bnM1c0dZT2ZMYkhsRm9kYUNXcVNzOXU0SFdpN1Uv?=
 =?utf-8?B?QWdmSy9hTVRUQ3NmaktNSWhZcUU0czBXZnpyL3F0dExoVUxXSXdQTTYvTlZC?=
 =?utf-8?B?MG1iZEo3NHNYMWpmOW5DdEVEMVowaXBmZ0RTZktHeGdYemNkVE9OK1pkQ2lB?=
 =?utf-8?B?V1FmaHBHUFJuSnRuQkJDNEZXKytReExHblZyR3BzNDJpemc2dDlMTzdIeEU2?=
 =?utf-8?B?S2VSaWwwaGVHejhnbGFWRHAzcmluSjJrNm5XOG1JT2NMaDJBbTVVU1k5eVQw?=
 =?utf-8?B?TTdtemFEdXgrdHBKOXRjNUdUZE1pc2J1TnFKdjYzR2tvbDdwd1M4UTNHVGNo?=
 =?utf-8?B?SUV2TjBpbmhBa2MvYi8rakY2c0NNOE1DY0VEdnBTbDNaWForaEhIVSs0cERZ?=
 =?utf-8?B?b1MyOTFHVkRWNXZEbTNVblMyTVFLbldyQVJIMjZ5QmZONUZPOWVQbWp1bkht?=
 =?utf-8?B?cGhibnF5WmF0L0VBVE9va1BRQk81NTVmZUh6c0VKVDVjT0VCTVlsUUcxaHUv?=
 =?utf-8?B?VkNrMFN0RzdGN01IdmtKRHZXTzI3d0pnd2lJbFU2NCtmdm5XQUhQdEYweCtU?=
 =?utf-8?B?ekR4QUlwS3BCMGFKcW1LZ2NIUFlaUmd0bFMvS1pGVXpSZmt0M1pwSmN4M0dz?=
 =?utf-8?B?czUvQ3M4SkhadW44QnlqeGhDcGlWdGlCVW4vMDJiU1BaRTR2OHlSQUhHcHF0?=
 =?utf-8?B?VnBsU3FPQ3BlYVpVL3BnM2dLQ0FWQ1JiZFFFcjRPdmk5RU91UFJWZzBsLzF4?=
 =?utf-8?B?T3VKRXVJVmgxajA0Z1UvVHVtdjVoVVVDUnhiSVNYU2U4WUhZWmFSZz09?=
X-Exchange-RoutingPolicyChecked:
	HczI5ai0pYdnz452mQB+n341/qC5vyjDFSQ3qvtzCzdxDL4bOquhf/rqwsJykZaX2drCxEnBTkJyONEMpwVolszLObUKCOLEfI3jl9PZu6v8NejWrzzhK3OUKYjO7DS6sIdLYwNRi7XLzZqvI5uPl7wiZ4Q7StPGPPXpnTC8jBNkB4LPeQLl79wDmQjXsl3L8QGgRGlRjrMphiv25ZQkm4nzRuqLnOAi3WF9acsxoVbLGuBZrLk2yZK+z/1nw0iqUVk9wDbvgP/ZHy0tD0uSbYbYaW+V+hRIzFcvmfZlynXloWLTgBLSNd+dYT2E2T4NENAYUez3jrIIJPm1Fy9A7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mzKgrdcN5GVhxFyUHGr+dakxqNz0qsZx0m1aJhz5lVEGO3DRrBfnvxIXHKbBcwZs2wo4Wdw6JYTiBAYEntj396kVX2SC6hjKG+FqMAeGeEi7TuXCLKGJmnsXz25xvsb70NSyW/7qnxXLiov4f5bymER5cfNg9+y+EVhseH19NAFEk3xFmSOphw5MYKA4/snsmp4Nn7JXFW8kp+0QCxVeYbjVmyMXTD1CHY81UgItaPVGSjzg0aIoxOVms72CYxSW2dWt0vkb8rJLenYZGl9Y2EqIpl9g7KACTRYawS3rhoVwn8/JDyHfYHAmtXicrRnXYoGP2moD2Kc/s/6nUUqvLPXI9ym99d2hikbydJ02XDzaZGPkAbEtQgoEK+GY8RV949qHyqkTWnFpVsOPNU7umCb4zH8w6E1YtKKt/2cjX5YjDvkITP+KyEZckA30wV2OODb+rocVUBYYY3u77aKSimxnjaG6JtfPE7HkWz0cCseW7ljAhjBOI4+Zyho9aNEIxFfjcoujJlHfUFPmJgfF7KkOzwmH/daTQqeTKRqopjGFDmZeIjbvIMKPUZsXLOMbd644Jh4gQbILamWbyfeCUmjibSUOnK1S+XCuN/XRylHdm7yQIpGahSeewCDUkcWU
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd26d23-feea-40d7-3ba1-08de84246a43
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:55:07.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pi41khnpGLbxodZjeY4sHCpky27VQmDDOFW5+8PX4pUg1uzJEsvtOMcAKSCphwy3jDoAUJGPTI1UiKD75gTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P192MB3088
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: PA1P192MB3088.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNCBTYWx0ZWRfX8KgtvQfotQOU
 WMAJCY0jqqbVyk6UdvZ5uSqF3EavBZxohNXw2iUUAtaZxRTh+tks3e34lxs/N73htv593693I9r
 tS34pwE/9pDCAVPsoupXqbZUqwk3IIx6i67dmrAWT+PHNipalu3QPelk/IxiJXeo1DYI0PXjCNV
 76DOnRC83FoJ5XTsid5MsaI0ZvUJqcgTtXnQyOCHbb/bCkYml+FPO4p+/hOX+NUOBKqw9864TYM
 ZDIaHbekiNsgpj92XGMtkOpmpQcqJdEsOotykOy5Jt3vORaCkGrMoGHD8TlGVJsaI7WrYCTGgZz
 FI096KjFuna/n5xiPRaQjolhwj+qbEc9sCdntRjxU/jnyJgOQzq7PReC4rKOPe+e5p2+VvBvEOI
 oDugM9jTvAMR4EVMrgEXoknbg7P3sqTZFDEOkVrGoyVrdnELo6hDxSr/Nw9y7BmszF3q9RLipnL
 7OKMFHPDuKZunlNauuA==
X-Proofpoint-GUID: z_dzQAUzXv06PJTd17iIkZ9SLqde9T4j
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69b94f2d cx=c_pps
 a=2+fW704MvOI7SWwK38+Gsw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: z_dzQAUzXv06PJTd17iIkZ9SLqde9T4j
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-33351-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,westermo.com:dkim,westermo.com:email,westermo.com:mid,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4545D2AA4EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ath12k_wmi_scan_req_arg structure defines the channel list in
CPU-native order, while wmi_start_scan_cmd expects the values in
little-endian format. The simple memcpy causes the hardware scan to fail on
big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
values to support both architectures correctly.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..9e1d3c662852 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr, extraie_len_with_pad = 0;
+	__le32 *tmp_ptr;
+	u32 extraie_len_with_pad = 0;
 	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
 	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
 
@@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	tlv = ptr;
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
 	ptr += TLV_HDR_SIZE;
-	tmp_ptr = (u32 *)ptr;
+	tmp_ptr = (__le32 *)ptr;
 
-	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
+	for (i = 0; i < arg->num_chan; i++)
+		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
 
 	ptr += len;
 

---
base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
change-id: 20260317-fix-channel-list-copy-cef5cad24fb6

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


