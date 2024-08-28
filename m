Return-Path: <linux-wireless+bounces-12139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16C9622A9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32472821FB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8815C144;
	Wed, 28 Aug 2024 08:49:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27F15854A;
	Wed, 28 Aug 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834989; cv=fail; b=byYSvJMdSCBGa14S/SQqMr0sFsq6ezCdwjK+1KcUPTF78hVYh18w9r/W8ngTUxjxW+9zijbxwV+LVqL/8t63y1wksvqhbNWaHHDdKCOQwJecrKT+g5lAoyDI6nzeBOg3LMiv3nFNMK0iXmnbiYlFc8Op/yFk8VdEo8FUwGNUrgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834989; c=relaxed/simple;
	bh=9pJ6VlElaG5ZVL7O86cmslHm2kd7nGoIWQvJz3a73uk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DRmvAwIBDyG+0yFXbN9r8WzayszHvSLWi0e+LQy8kXiV4j53YIaqUYm20dZHnBJW2aupEQKGjYJRWiEj7LiBSh1m8jqjAxhyNMFj+t0ttdDe40dxQw7iUR7AcUgfwxG2fIQUpFCu8PApMnjn1ZaGcL16Ngl8By/yuO/OmCPvn2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMx7aCl4tFM61E/mcmxZ99J/0tMRHksM1J5z9fS46uRwaPP0oMZc+4nH3VmFhq9x5E9hcC2A/VUTM7U4azi+Q0DBOafJa6bv2VIbUCnm00pr+L0j1/ixreJwwrUvwVK94o+6SmZRTjGZLYf9h0eeMXgyEkWlnPydikpdRYqK3NXWwmC+7RkGZXMst4sIeqdtl6eZiIhrQeLrjX4avXj3oiU6qeefSCQ4x8E0UuEu/rEo2qyr6wODqB3oR4pi5xbaHd6Ai9lT22VOMUJL5GVLWu0FZAXje2pdBHRb7O4Z0gFObproa0No8BjCA/kbUs8onK0d1AahaY/kyBSlMA3q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yymUGuEcJ+VTUGa/xlzxOuc1+IWgO4nIuxTCPa3mQbw=;
 b=VQlaaSdlOVlxuF/+IQx5rj+zjOXrfq6ina5ExdXmvcmMe04DU/CFmEZU2uRPjZVPGpmXWRFgqWwIZpuFh6UrRnqDwq8Ju2u7DEtZYRogbHOPsOnO3OyE/GqEZngp9Bq2S4cnjo2f8pPTkwa0lZfuS/Pcnk0zanNd3Q2ezIGp2SYIaJYMZ78Lu7MhsntEbNjDLzTZ+ZN2336a6Pc3JJeQCXqJDMr4Mfu9fWw4XdzTt//L+S8nk4zcCbpOghDUhh5xwM+VDIf+juN84tLbKnnz507XD7qBu2rE5tc+mvpEcc3/Asnt2/RZhgCG/d0Kb0jc4lcD3rNnv7mORxky2W8BdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:43 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:43 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v13 0/5] Add AP6276P wireless support
Date: Wed, 28 Aug 2024 16:49:21 +0800
Message-Id: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLkzmYC/32OSw6CMBRFt0Le2Jq2EqSO3Idh0M+rvARa0xrQk
 O7dwgIc3pP72yBjIsxwazZIuFCmGKoQl1MDdtThiYxcBSC5bHkve7ZSwglzZrOmMFFAZqw1Wrl
 OoTdQc6+Enj5H6WOoeqT8jul7bCxC7vhfXbUwzhTvWm2v2nrh7ivuv842zjCUUn4OzDhNtgAAA
 A==
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=4232;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=9pJ6VlElaG5ZVL7O86cmslHm2kd7nGoIWQvJz3a73uk=;
 b=GFi7N5FJSR6BAVA7EPZU+6tz+wE6v31XAWjaEWCCI4NrHMwXi7aXNNydUh+ZuJ5RVotW3T9o/
 cUW/aTsq86cDlVTaRVKzOh4fgn98SkrSlnqOPVgsVAL4O5x/gIZyAlw
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2b339d-6538-4dfe-a941-08dcc73e5c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXBaVXZoYUlEcjJhVmVlRXVzSHpZd1pzckRhbHpESjZLYUNrTE9OZ1R6aEgw?=
 =?utf-8?B?K1VadGo0ZEdyaFlhUHNOU2o1bnBpVTJjT0owTjE5MGl0ME03RzRpK0RaSXZn?=
 =?utf-8?B?am9IS0EvVXNuVzMxV0lodTNlVGVQVVI3NlZIZ1VsUXljN2JidTNqMm5JelY5?=
 =?utf-8?B?Y092NmhrYzRSU3h3aEtoTnQ2N3hOT1FyNVpITGFwaGNMcHRzUHgwMFhlb2hv?=
 =?utf-8?B?NGtWUisweXBBNk03MjJaUCs4Q3YyalovN0lZdFQxRHVDN0VWdC9KRXFaUzhE?=
 =?utf-8?B?SXpWZnVpVDNkUFNCa0NJekdBVUxtc0pyY1dqTFpBRDJjeUh3TUx3MXVxaWRx?=
 =?utf-8?B?bkt3MThlbWRkbk5DbzhsSmROSjZmNUV2ZG92QUw3TjB5OVEvb2x2eWh5YVJx?=
 =?utf-8?B?S3I1TGRDOWRuTndaWFZiYWFteEtXa1dsOFF1ZWFweGZreGQ5OGNRNGo5NmJ0?=
 =?utf-8?B?cmVmeEU1K3ZmbjVQMEx3aVUzcThaWkJBN2lHaURvVytuNXFsREc3QlYvNmsr?=
 =?utf-8?B?UnNGZktLTm1sNVRpT1laOUlrYVdxZk5uMlVheXVVZXFISFcrdjdaeU93dFl4?=
 =?utf-8?B?RHdDdUJpRTc2azl3YXRKS2taalJLSGRlNGFlSFk1T1gxVFpwY3h3T0RURjR3?=
 =?utf-8?B?WGJrcVNPOXd4eThrNm85YkZpbm9lbDFuc28rTFc5Z3prcW5heVZkT3VrZmN5?=
 =?utf-8?B?cUVmaDcwM2pBWW9kbWlzbzRFNzZRWk1pNVNpdVQrb2JqeWN6cmd4WUdEQnBq?=
 =?utf-8?B?YjhybXlLaVM0Z0RETGlXa3B3TDVidU42RXdLMTlodUk3N3BjZEc1alF5WitQ?=
 =?utf-8?B?a1ZiTFVTTm82eit1bTk4ZUM2d0k4ZFAyQm16b01mYmlXRlNiak5IRTFRQlBD?=
 =?utf-8?B?ckxxekw4bDFXRlJmK2dZQiszbVN2MHVPS2pGUW1hdjFLRmFscUNPcEFoZ0JQ?=
 =?utf-8?B?UThjREdrRVkrcVRTc09QMk03ZkV2cFM5T0xUSG50UTkzeE1tOGI2NmNCQklC?=
 =?utf-8?B?WXVHWEFnRzNBSUVKdDJKMTRpejZydUp3UEdycHRhckprbWJ2bUttL3VBTG82?=
 =?utf-8?B?SG5VSUFlK2ZjQ1FXdGRtdjF0QVJoTkdqaGlxUExQd0w2RzZMMTA2SGhnNmUv?=
 =?utf-8?B?U0pYL29sL0NjZU9ENUVKd0psQ1RnbHJ2SldJVlpjeEVNeVlGOTU5UmlLZzJG?=
 =?utf-8?B?VGZzQlArMVFrVXF4L3NMczFBRjMwbGdaQkFlaEkrdDYzczRvTzdPYkpHTkpi?=
 =?utf-8?B?bU1NQTZFWUkzdUs1Q2I1TjhiK0xDRUg4NHM0S3AxcFAyNmIrRHcrRDZ1YXdp?=
 =?utf-8?B?TjlZU0RjdGE2dGVPbmZPOXNteFo1N3c1djFuQTlzdUN1RTFZVjhCa1lNUUZY?=
 =?utf-8?B?aW5LQVY3MXZRVE1RZC9sV0VpdVdqaHJYTnkzNFpDUTk1VkFTbDRpdmwrcTZN?=
 =?utf-8?B?ODBPdnRCeXFKZE1IMVNBYSthN0xJZXlpSlN4alBwN3NVQ0Nkbktmc3F3NVBi?=
 =?utf-8?B?dkpDbDBqVWw3ZjRsdi9weW5yMUhkbjcwS01mTHNPS3M3ZzBqSHdYaUtoaE1k?=
 =?utf-8?B?Rm5lUEdxdjArY2lQR1Z2VTFWYmwwUGNrWTA2UXkvK1dab0Q5V24wSDBPRjBQ?=
 =?utf-8?B?b3FlWmVTWjltTmFneDlSOTRwdExicGh6OHhRdjY1Vkxna3ErYXJDWjJ4enV5?=
 =?utf-8?B?UUdxVWZ5Nlc5RWl2bXpRY3NKbFJrOWdrZDZEb3lIUVBBWmg4NTRyRU05cVRF?=
 =?utf-8?B?cTdaTmhQYUJBTmh4NDNlUDloRisrSUV2WnVYcW45eUtrQUFEcjFZZFVQNWRs?=
 =?utf-8?B?dmNaTWI2ZFhia3hiUFRrTGsyQ0tLcTNpaTJTYWw4RmI2eGxVR1dvdjNsQ013?=
 =?utf-8?B?MGpZZDYwazhYVVk2eGozWGFHbEIrNWJiT0txc2UyS2VBRUtBYkp5OHErOG1l?=
 =?utf-8?Q?CNSobdk8sPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjNqSkVFMm9HRld4ZXRGeDN5ZVN0ZHBXL2lkdTdKaURnWDh3cEtmbWt2V0hl?=
 =?utf-8?B?T3FyV3FhWW1CanBzdURmVk05cVpFRlFOZHYzYmFHUDNsUFdWcEVuU3h1WHNR?=
 =?utf-8?B?aW56RHRab284eEtsU3lYKzZLcU5uK0g0NXBoMEpJSTh4eDdDRmRxcGp0UDF0?=
 =?utf-8?B?cmhGZ2ltV2Nub0JaSnFmeFViZnd6cmQ4UldoNlJncWZqNWZmWFBkVTNqWkNO?=
 =?utf-8?B?Ymord2R2b3NIM3MzL1V5K2FXNkhEdDc2T1QwYVJpSXJRbFVHVGFGVVc2UmNi?=
 =?utf-8?B?VlVHbzRXQzRqcjBlSXI3eXZydGcxWWIwQ0IvaUlYeFR6eUpOT2VSZnVuNk4y?=
 =?utf-8?B?SFNKNFV5cG5BdWs2a0VGTkhLNSt0Z3F1ZWUva2FvS3lYVUFaMGJkYVhKWU5M?=
 =?utf-8?B?ZERhNHM3TDdkWEdQL3I4WldNUFNQUU5OQkZlNnplUURzSVA5ZmRMTjdOMVVU?=
 =?utf-8?B?VjdkcDhqdWsrellwbFRpOXlGa1FMWmZaSXpscm91dGp0Q0lHSWN2SkNReDFs?=
 =?utf-8?B?aUlPK3REdGNCV3NDeEw0Z1lmNXZaZ0dLaFptSzhUVE4yOGxZKy85eWhZM2xk?=
 =?utf-8?B?ejV3K0QvTUg4T2N5ZzB0MEEyVHlWanNtVE5WenFRRldmblV5Rkd2OGk4UHZr?=
 =?utf-8?B?bVpuRFpSRmdUb3I3VldtVlE2VmwzUERpUUJvWGljbjhPVGd2YjVOU2ZIdkxy?=
 =?utf-8?B?ZnRURndDUzR2L01SeHd4RS9TU051YkNZY2pRaVdJWU5Wb3IyUkJiTmhLYzlu?=
 =?utf-8?B?ZjFXM1AwTElNZ2tQNkpTWmNweXQvWjZHSENFNldYRFZsbUZqcm40OWhyNGtJ?=
 =?utf-8?B?aW56c3JDUUZwbkFKY2RNU0Q5MnRFRUNndkpWSlAwVWh3ZDB0TEdYRnpwR1kx?=
 =?utf-8?B?dnRteWMyUFBjSlQ2emljbkFYQ3BrNHBMWERLSkZIR0NZMUUwa2tlUldhb2Jy?=
 =?utf-8?B?dlhDWWs0RlZzVEtWQ0xKZWRsRFBscnUzbk96eVJCYkNpek84M3luaG9Wb2Vv?=
 =?utf-8?B?MFJTeHBVMkxDdjhBeEJVK2c4R214MmZpOEpMNjY1OWJJTzdwYk92dVpnV0JL?=
 =?utf-8?B?NlN5NjZ1Y0xrQ2pub3NtejNtblQvbXFhVXVsRFpRTXJ0THhDckUzSVpDQ1Fu?=
 =?utf-8?B?RkgxbEFFMVNncTFpT3d2MGFEbGZUajg5THBLaFFIS29wdVBSYnNMR3R0bncr?=
 =?utf-8?B?bkJNeGxyaG0ycXNBRnQwM0JBNURWeTJQbUdUUjBrcGNpdUlEQVBaN2ovU0Jj?=
 =?utf-8?B?U0M3YVhkeXFCU0RJOHdIRllOS3k4cDAra3loVndwcjNTQjFVMU9hRnpQc1NL?=
 =?utf-8?B?cml1RHJ0bEdoUzBjMzRRempjVnkramNxcFNqQ0g5M1JrZ1ZNVU5TMmJSRGNH?=
 =?utf-8?B?Q1N1ajlDUTFTZzlQU2NSYXZUenpoNjQ4d3UyWE5rVnNCMUptWWd4eldkRVlD?=
 =?utf-8?B?MlFrNGsrTnRFVGwzNXN3cFBDU3RYZENTV3NtNVJpVUVuOEw1ZnY4bVV6NU9q?=
 =?utf-8?B?RWovTHJMYS9ocFZCdmtLY1BQeUJQbm45ZCtFNWdDY2d1aWwrMUpVNjdwMWNk?=
 =?utf-8?B?RjNRaFpneS9pT2lOOU01alFQNzFYcWxjZjRFbjJyY0lkVU5RSXdlQk5QMHB6?=
 =?utf-8?B?Vk5MandxcTIyQ1VtWmVBdnEwc3ptdklITGhKNmI0L0F6MS8xdjBHQW4wZXRo?=
 =?utf-8?B?TWMvejZPait2Zk5xTUNIcE9WNFZlTDRhVE1QUGM2eERYNDZ4T1ZZVmUzYUxK?=
 =?utf-8?B?VXBpeEtTV25yYWxFcW9pTVJ3TmxBckxSTGhPWnZRc0NNdHlCcUxXT1ozeXg3?=
 =?utf-8?B?U3RyN1BoN2ZCR3pydDhDKytHSTFGUEZubFdFYjcreEllM0NSUTI3OVpMYzJo?=
 =?utf-8?B?VUJHdWc3VzJTZUs4UWNZTGl6R0NwWDZ0OFpMLzBnYVpvQVJ0SFRqMmtUZTRZ?=
 =?utf-8?B?aTBMRnlyN2owSGNtV0lpVFFlMlM0anNka1NlL2FTUXNZTjVuSlJLWUlFU2k3?=
 =?utf-8?B?M3R1dDRPVmh5S3lteFBpYXAyNDJwLzVyV1MzOGlNcG0rTlBTcEV6QnFTVlgv?=
 =?utf-8?B?TkZiamY5eGhOQngzWlZZTEMrSVRHaUhzN01LeWtCWlVhMVk0WlE3Q2wzRjlD?=
 =?utf-8?Q?Hnm6S7iv4UCRfAX2lnzcQVz0a?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2b339d-6538-4dfe-a941-08dcc73e5c53
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:43.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn9Hm0uKX8i28+LfwFFL3yYVy0fLLK59l1rSjaKzDvzRihD/5HP0nS6EwjaFSLGHuhXDcQJqrs2Cg7VozmAk+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Changes in v13:
 - CC devicetree list that forget last version

 - Link to v12: https://lore.kernel.org/all/20240828034915.969383-1-jacobe.zang@wesion.com/

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v12:
 - Add "brcm,bcm4329-fmac" as fallback compatible for PCI ID based devices.

 - Link to v11: https://lore.kernel.org/all/20240816020635.1273911-1-jacobe.zang@wesion.com/

Changes in v11:
 - Retain interrupt check in of.c
 - Split DTS and submit separately 

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

---
Jacobe Zang (5):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      dt-bindings: net: wireless: brcm4329-fmac: change properties enum structure
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   | 27 +++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 29 ++++++++----
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++--
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 55 ++++++++++++++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 20 +++++---
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 ++
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 9 files changed, 113 insertions(+), 39 deletions(-)
---
base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
change-id: 20240828-wireless-mainline-bccba9d69efb

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


