Return-Path: <linux-wireless+bounces-12149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8059622E4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416931C217B8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4215C14F;
	Wed, 28 Aug 2024 09:02:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020085.outbound.protection.outlook.com [52.101.128.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC515748F;
	Wed, 28 Aug 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835756; cv=fail; b=pvEZCw2xXvUWZhIno1hrgjMprkKeQQjsNkYpYEByh3i4R41HWyhF1ZMwlmUxksEhbzhfMd/O570rKe6gmPkcHtzvKp4P7Fx5wDwFjjlnfpxnuM0z751echVM+sDBnM3GNrV9qUbt63wpQGYjm7PfOIkE21PEC183dx8/jflfoWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835756; c=relaxed/simple;
	bh=tAcR9W+O44EqT6a+j/AylBUOh6TIO42/aWlamHrD1Yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtG+f9U0Ht+TTfQ78WtTEIdO1yle60fz5v3bVdjgQ3PMSCxHtBWdT2Bmd8wGVL56Xt6Pq/uTWfK4CVGJ4B0CCfO7KTg/I4NOOaqg67jRNSeAkO8JTgppNwITB/92xFRoyAjZUc5+ZiGiklHtEELNQf/pv03iLUFyhYHxXtp7uQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlwYqjlMua4WuC0xT7MlGzxq4tKHg1H8UinJGSsAAPRFrIcHga7yhYt0WpRylAinLWziFH1pwlxKv58Nzk6I50XQSyAGLvPjnG9KKJwTNzMNP0UK3a+uwRD4G3RnUw9caJXXeKrpgkQo28RYMNQMfzaFc0ogSlbV+j4Mds4BNFWbWp5X7pEP3aWJ8Aps05RCdIM7VRDznYfEq1JiX8iDg1ayrynF3aRxPhL8v2cBJcfCJpRQAmkQKkiRDjtltjeZf86z2XhqckKF51WSBoPRWgH/NNdrWHGFZjJ3aaAXs+4FeZLqIDwWhe5fd2my7sYvfxNxTHxkIFSFZ/Rc98Ex7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JL3zcUOOH3rVYPlfFSJ62xDfyJDSiLYbsgQHvkUlFI=;
 b=PH3ZETAOOC9zN2s7Wei4Q2Fur411abzV4SzMQ8oahfVR2anOhyaynCDladUSr6WUItHVERsofMtEPrH5W+ziT2Ap0YeR3qz4ig1PS4c5SwbThwXnc9EREHOil1h+i9ozY9E/VF5IvAGaSoGZGrZzsPI5pgjpNX4+qymmmabGcmZhyGzHoNV78pib2SQFD1KYnRQO8erN0q74WMdqDDYLNHFKP4lwCO1InDYnt+yoBY5Sd9IwxY/tcRxRdayICK1FtItAz4BVlH5Vv+gwCqcY1cWpKj/LcY7ninpFfiGlZnsZH23m7SAsfdGEAjJ0KPN5I5ECloxNyJI2bmvX1iSiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8039.apcprd03.prod.outlook.com (2603:1096:101:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 09:02:28 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 09:02:28 +0000
Message-ID: <672cfb0b-679d-4a14-b92e-c8c591bd7eb8@wesion.com>
Date: Wed, 28 Aug 2024 17:02:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/5] dt-bindings: net: wireless: brcm4329-fmac: change
 properties enum structure
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
 <20240828-wireless-mainline-v12-3-9064ac7acf1d@wesion.com>
 <22fdbe11-830a-4084-aa5e-1b7294f3a7fd@broadcom.com>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <22fdbe11-830a-4084-aa5e-1b7294f3a7fd@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: c23783b1-4ac8-4f17-4e56-08dcc7402461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDQ2ZEloRlc3T3N4Y1l4cU84aGRyU3pLN0RDaklzTDlwdjdDM0tGWkRRWXhu?=
 =?utf-8?B?VGtWVGJDMEtOWDgxM2g1R2k3ZXdlT0tYbEIvUzVmajQzSisvdXVaYVdMOE1K?=
 =?utf-8?B?WTEyU0JrRndBeSsvdWxjZjdDNzZJaHc3OTVCZjNzSjQvNU1pVThDMENMbW9U?=
 =?utf-8?B?UXZXRVVtRFhIdjR6U0FLRUhyaXVkZS9GTDduYjVZTnppaG5WOEN5Q1pOdUFD?=
 =?utf-8?B?YXhqUyswSkFtNWg3STREZ3BYendWVDg4WGFUd1VjN3lCWm5wRmRmdzJxQk1l?=
 =?utf-8?B?eGlYeTViRGtwcHZybkg2QVJuQWIxOEJQTUw3OVk3Q1VVcy9mMVAyNGNqb0k1?=
 =?utf-8?B?K2Y5TTUwUG41Vk5kUkpBVFZYdUVWTjlqNHJnU01OdkFiYUk0R2JTM2ZvUTRs?=
 =?utf-8?B?QitvZHUzRlhPaWVCVnBoeHAwMXJmUTlBeHlVWUNKSDByN3B3TVYvMHZWazUz?=
 =?utf-8?B?ZEdvUndXVkM0NGZlVDFOdXBrNlRtM3djQ1lzUmxkM2NNN01YRkExQS9MRWRx?=
 =?utf-8?B?YktvNlFVRm11enBGUFJmUWI1Z1QyaElTYnJTN3hyWDdpc0dZL2w0Z3FUdVhh?=
 =?utf-8?B?V2RyM2ovSzlDNWo4eEZROExXZm5lNXlqbE1GcDJtRVljaWJVNmFTY2tPM3dU?=
 =?utf-8?B?cngrU0JobHp5cldya3lCMmtzVGlxMzB6NmFEenNuVSt4OFZ3Um0rMzkzUGJj?=
 =?utf-8?B?MTFQc3RVZVBoOGdYRE9yN3VjY3ozbjU2NEVaTjErbUlRNWtjdHBPU1FOWHBV?=
 =?utf-8?B?LzZDZ3JGL0g2bXdqczJGMm5rY0d0S0FBcndpVEJaMkhmYi9kMVFBS05Rd2xp?=
 =?utf-8?B?SEdNaTNGVVhHQi9Rbnh5NFRIQVNrTXpXcmFJeVYyNEhkZlNxdE5XTEJiZDVi?=
 =?utf-8?B?RlR5ckwxQ1dpSXVsL1ZGOVVKMFdxTVRSNElrblRTZWw5TEE5V2gwVCt0MXVP?=
 =?utf-8?B?bEZLUXNpcWFTaGJlNnBxcXYyMGhEUjVzeVI5OHJIRlhXKzUzMjA3VmtKeUZ4?=
 =?utf-8?B?WjlXNFV1a0kxbzJaanNEa0N3WXpqZ00vQ0IxTkZiZEtTU2ZPVXQ3Q3ZsLzYv?=
 =?utf-8?B?V1JLNEVmMlpxZE10Kzc1MFdqNzZmNDB5OWFwclg4czRQc0ZDaHhIWGJJRXhE?=
 =?utf-8?B?WS93RXRTeTNZR1JrbGYrMDhwT0VmRHdISFZmUmczd0xOWDZydm5POGpoenh0?=
 =?utf-8?B?VW1OU3M2OFJUek4zOEttYlU2c0RqTURqdk1yTkVpSlpWcmdyRTI2V0YyaENo?=
 =?utf-8?B?MEVobGZ3aGxxd2lpamUyQW5NRngya0ljZURoQUpJb2QvL3prb0kvM0lMYnVG?=
 =?utf-8?B?c1NScGx3SzMyVTQ1NXgyd3F2VkV0TktiNEdlcW43VXNRbUUvcmM3ZlE2OWV1?=
 =?utf-8?B?U2wzQWVReEVTclRpR0tNQThvdkVlZUtabUVka2JyZm1oVi80QyswOWcvTG5Y?=
 =?utf-8?B?SlJIeWdZSkNISjh3WmwxdEZXbnVnSFpmajBjTDdzSHBlM2xEUGVsVW1pMWtj?=
 =?utf-8?B?eHlFcEdqLzVDTnBVRjM4bEVyMVZSbmxpb0p4dXVWeEpJQ2dlRVZFTEZrazh2?=
 =?utf-8?B?Z0ZXeVNqYlFBamZFNERsUkM4UlprUlNEUStvSkc5bzNnZnVJMFh1bFFLUjJn?=
 =?utf-8?B?dmFDdVp3V2FNb3BOTStOZjQ2TXBsTWpCV042OS9VZDNzMHhsTG50Nml2WlJY?=
 =?utf-8?B?Nys0TklraUtYNyt5KzRHdGF2SmgxV3g1Y0JmdEd6R04rVjByamRyY1BVSXM4?=
 =?utf-8?B?d2Rlc3lwWjZ1eTZiVFZOMVNPUkNzZjhTTk1FYXZpN0lyUlVZT1Fpa2lUTGNJ?=
 =?utf-8?B?Vy9ySHBGZWNxbzJwTFQxNE4xVGh0TTJPZVV6U3d6VVcvelZlMVlNa3llVW9Z?=
 =?utf-8?Q?YDefYxCmjn+zR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlnczRVZVhxUTIweEkxR3pEekxZMVlFYnVOWTUwNTJMUmNBWXJFUXIzd3Jt?=
 =?utf-8?B?RDk3L21wVXhXRExSYVA2cEZPcFFHdnR6OFpZRTYyS1lCaFp5N0hEa0VYa2xo?=
 =?utf-8?B?OVZiTzNXVjFUL09peVBudjBBQkU3ZXRGclRJQnFqMVUzVVRlMXFHT2hSTTdY?=
 =?utf-8?B?MDhHeXFYVURjenJTOUJGVG1TMEhQeFFRdDhsZnZKZkxoTjl6ZHFUV2djUVVt?=
 =?utf-8?B?UW93MERhdVluc1phb1ducWpUN3MwQndzVy9DTXZhVzlqT2x6QXdMa1RRNzhq?=
 =?utf-8?B?eEJSUnBYNWxCLytlanBjUE02SEtKbVZtWTQ2dlBUUVlXbUE3MEVHV2JNNjNZ?=
 =?utf-8?B?VVRyMmtoRmNVZHlaN1dBZ2hEWmE3ZnlaaU5VUGZVRWtNdXo2M1AwOWZ1akxH?=
 =?utf-8?B?bWZQQjUxYjJKZUtPNHNkYTF5dURYMFB2NTcvOFhyaW1manRKREVubzI4cHp1?=
 =?utf-8?B?SnRiOGg5UjI1Skl2Q25NeVB1T3padlA1cFg0S2kwNStRWWlITEJtOHZFdStv?=
 =?utf-8?B?YTlQd25SVDlRSW5lcVQ5d3NxTytLZlU1WDRmQ01mQ3ArV1hNTGJ6cWhJUTBF?=
 =?utf-8?B?MG9oL2huVVVPemhac0ZPT1ZISURaQ0FRNjhEa1BLWEkrYmU0anhta2pNajd2?=
 =?utf-8?B?WUZscmszdXhGelZoOHB4QmpaWksrZzNVTWN1dkxiNEF1eXk5bUV0VTUzTlI3?=
 =?utf-8?B?Q0xESWxSQlpYSmxzMk9xTmREcjNERWFsejNHODZlSkhGUGlCNE5LVnZ0ejl3?=
 =?utf-8?B?cDkxRWJLckVMcnJnYmZ4U0V4ZW1nZ3MwdCthM0VUSU1FWnBSQTZGajhNa0Vm?=
 =?utf-8?B?TlcrWmpEdEZ1TlVVWktqYjdGbDJuUlJ3SXFIWDlOZkFNMjNWeXUwYmxkbDNM?=
 =?utf-8?B?Wlg1VkdQWS96cUJGdUtFTkp3Y05DY1lTcm1nOUY0K2diZnVhdU54MU00V1NB?=
 =?utf-8?B?S0JpanJaZWl6Rkd0NWZFV0pMZmZHSFZweVBjMysxcmo0b2F1d3ArM1FJWkhF?=
 =?utf-8?B?Ym9ZZkRxdTRFL0trKzJ5cnhIa1ZNNzRiVU4ycStpQk0yR0YyQWZBMFRlMnY0?=
 =?utf-8?B?V3JXU08rMGZvdHA3SzN4ZFFjaHFzNUVaT2NhNnZaN0VBMkVZNDRrc0ZQNnh6?=
 =?utf-8?B?N25GQ0M3QngzdExQQUhBVXp6alQvd0hjMGVRT1pjQ2Y5dzluRUx6amVOQ0FQ?=
 =?utf-8?B?NWd0UFBIL3B5SVdjSXVxcmtsK2FBYlk3eEtmTk9kN09KRUg0bENYOG9BQkxG?=
 =?utf-8?B?TnZOSGRidnZha3YrNkc2M3BUOTdzS1pweU4zSWlJM3NFSGlCR3VNMEE1d3Bp?=
 =?utf-8?B?ZG8rSlg1TnB2MjZqd2pPU3NHT3FaekdtS2lUQnF5Zmp4LzEzd25wOE91N3hT?=
 =?utf-8?B?VFE2L1NZL1dscnBpZzhmVDJBaXJnVmswV0Iwc0pYSktPbkZnTVBPcHhLSE1W?=
 =?utf-8?B?ZDhBV0ZDL3hHRDNkOU1wYWFGR0l2N0d0RzVobFpycHZwOGFQWCsvVUZHMDNv?=
 =?utf-8?B?Y2llVXJ2Y3Z3TlFCRW50YnlSSHZBVXpOSExBUGJ3R01sT3QzVGxUNE1UMzBw?=
 =?utf-8?B?dXlyT3FqT3A0MlFVSGN0MXRiRXN4aVNpTDExSzgyd3B6czZQT3Y2Z2tmcWxN?=
 =?utf-8?B?Y1ZxaUs1Y2JKamxoVzV6UVdMMng2bFVKN3ptMGFZQ1VJbTNFYnFnWlZTL0w4?=
 =?utf-8?B?cG5kQWRRUVd0TDBibzM0WldRbEhlRUdwb0hFNjN1d0hubUdRTk94VXBkeFNK?=
 =?utf-8?B?RWx5WXpKeDVrYkVDOURWa2VyUmpNZElWNXhVTldYd3k5cXRqZjNUUURmWWZC?=
 =?utf-8?B?WG16cERmWk5KaEFmcjRvL3dFQmlpYnNtSEM0dFRyUDVXV3pmTDN4N1diaE0r?=
 =?utf-8?B?NGZFYXpKS1BPZ3JmT0xMRDJQQTJjMmFtMnVHRzZLMENaT2t2MzJFY1Y2Q29r?=
 =?utf-8?B?aGpIRnNSRGw0V1BpYmxSc3hxTS83b21PZ2xxT2VxNDcrWWVha1NwZ3R0K0hW?=
 =?utf-8?B?ZnRaSnVnZS92ZkJZcDREdW9PcU8xZWhudFVRZFk0d2dCejNYZG9KeE11STkr?=
 =?utf-8?B?NjlEeXp5VXdCUDU5MFArdEVEZXNxMTBGT3ZNaGlIdU1ORFZmZHJBaDh0cElS?=
 =?utf-8?B?cVAySEVEeFhQQzdSRVhmaitFT0hFMFBCUjZZalFkU0tEWG9IZmpBOExlekRl?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23783b1-4ac8-4f17-4e56-08dcc7402461
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 09:02:28.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn4P1HNH1CpK2idQpsg+CXFINQWAhkePPBBu8lIFW64kCMR2NE1fgnmR+rOX3T5rVHM3oepjL3Y0kQ5yVI1qwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8039



On 2024/8/28 16:50, Arend van Spriel wrote:
> On 8/28/2024 9:40 AM, Jacobe Zang wrote:
>> Add "brcm,bcm4329-fmac" as fallback compatible for wireless devices that
>> used PCI ID based compatible. So that can pass the compatible check in
>> driver.
> 
> Hi Jacobe,
> 
> Using the driver implementation as an argument for adding the fallback 

Yes, so I changed the argument in v13 which seemed doesn't matter now ;-)

> compatible to the bindings does sound wrong. The most importants rule 
> about the bindings is that it is independent of kernel and/or driver 
> implementation.
> 
> Now this actually overlaps my patch series from couple of weeks ago 
> which also covered some other existing DTS files for Apple platforms. So 
> my proposal here is to drop this patch for now. I will give it another 

Okay ;-)

> shot in v2 of my series after yours is (finally) applied. We can always 
> hope ;-) That does also mean the compatible check in the driver should 
> not be moved in brcmf_of_probe(). Also the Khadas Edge2 DTS file should 

I see. Thanks for your information.

> not use the fallback compatible yet. I can include it in my series later.
> 
> Regards,
> Arend
> 
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   .../bindings/net/wireless/brcm,bcm4329-fmac.yaml     | 20 ++++++++++ 
>> +---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)

-- 
Best Regards
Jacobe

