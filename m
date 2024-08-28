Return-Path: <linux-wireless+bounces-12140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F09622AF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07491F25E13
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1C15F3E6;
	Wed, 28 Aug 2024 08:49:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C815D5AB;
	Wed, 28 Aug 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834991; cv=fail; b=pQEXFuHIeyel7h9TRfmrQV4HhjAt8kExGMHrHaqgfqBybM9wwiA/aZ4y2Kmzd5Hi96/Rh57BUGKU9cIY3yKprLDP2T/JM4BHnQfUCmF6ZDs2R31Gw6slpn49VWiOFowiiIkTXEd1SK10qI3uHRRWkbfsjfWhoyqHl8Hjt9mnS5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834991; c=relaxed/simple;
	bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VT8Fn5OXZUmCjzRu0qkiuEn3vN7dsDA+3vsKhMCCTUZt5Kg7K8Jud7TGtFrQJZqpj1lFKfIDX9iGoKnZ/MhZRfmyrKr6+WMGsjdsSNOseLmBWpSClJnRysQdOSfsugL1ZFXkPVJ6QBOFEal7irDldkefQL0yDi/9MUlRehg+p1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av2r0oSEAePfqOgwu5DX/jbnTb++Eb3BIR9y9utf8nmVc7aZTkN31jt6Relj2FhUFA4VGI+Ge1aaQLdJdUCZh/gwDLhPYmWX8/AT8I9AdGk70RcgvmKvmohmwTWb6whON3bKigjr1gJ0MVNoNU2I7fg+3ICyg3eSRY44neDaoKbhYyRRIlHXz+xtYMaNyFBYfyM/S9iL8s6haG7EkadzYEBjORZVewca/Bsv78SZD4dMGIb+87k2cJddLfvad0lkuJCQ07afZ5PXrwBK/NdwgClSGRh/mbQZgSGSNW6RHXvnavNR/uJFLMEyuJb/a0YEEDtJxUgBdnItYHTAfZed1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbxQ8CN2hEqCPJsO4yOc2S/gFbfZhs3WhsZPY+vH/Dw=;
 b=s1C/sL8eAxYEzxW4jckLnOXZ9wtAUzpMIANQbMH9SXXHjJr29BAcecimQBEy6yKEh+kszsBqFTXyiEzE/M6/Goev8D6nLzA7NuSas7how9Eim69D2XDrYvzy6AfvuTtAtPjm96hjnGFSU/VW58CWEA8YJTvdNNIKyqEEPjCO8iadiToQDq1Q5VfChxiMznqWl+ujI513Dr7TiyTfPAAWLeNTJbtaM+H10pwDVywvGNAJ/nMrkxjbfh0ieAcb/s6O4Bp+xUvT8CAKE55TrARnK4U3cy8z0zrVRTZ+kUr0i+RvrAPVh5KLfj0Yw31WS2AAa3kmc52vHqOB/r7c3WiNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:45 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:45 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:49:22 +0800
Subject: [PATCH v13 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v13-1-9998b19cfe7e@wesion.com>
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=1081;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
 b=lwhWbD7utoPjl3v362nDnCaONDmWG4xP1jHbOGRDtoSswtS7D2UrEBnNfeNWNhryIewVY6Wo6
 pCfIiS+kh7wANVoVYTO4DL6LLsxR7fBsL9PJsR3cPw8qkZtNRIRqM7K
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
X-MS-Office365-Filtering-Correlation-Id: e3274fe6-57e8-43a5-90b5-08dcc73e5d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHNNcXFBd0wwd3JaS1FVZDBGTmh1bEdyVjlqT0J4SDQySDRQY08zRmQ3R2VI?=
 =?utf-8?B?a05CYzkyTTNoVTJXRHV0VHQ4aFk2U0k4QnFReUNJWUFKRDZRdlF6V1RNdFNH?=
 =?utf-8?B?UkZ2YkRyMVZXczQvamxYeXZ3NEw3eGovcXNNblltRXp4eXNSeUpMdFhLclBy?=
 =?utf-8?B?TDc1VStVVVFscWE4ZG5Wb09ueUo3TGhmeHJqRExWekhKME5nZHNDN3VVKzhO?=
 =?utf-8?B?WkxaM0w1WVBJQnlrOHIzL3JxMFcxd0JFLzFOY1pJUDZjRmRBZHQ5eUlhamRB?=
 =?utf-8?B?OTRsVHU3UHZuUHZhQ2pLMGpOTjhWR1E0TjRLck5IV3BnVXNMeEFYblltZXJ1?=
 =?utf-8?B?aDAvZW94dE1vend3ZU9sNHJ5KzlXeTYxcFBBT0ZzY2k2aisrakhRZ0FpNGkw?=
 =?utf-8?B?NXVmQnk3TVVmdy9JOWZ6TXZ2K0JXdlBva0U1SitWenRGVUlmOVhnQUJHcVFi?=
 =?utf-8?B?b1B5ZDRhQkt4OWY3U3RwclgzQlVHY3liVVQyN3dPWVNyZ0pySkxBeVZhSkkr?=
 =?utf-8?B?Qk8zSFhKQ1UvRGxtaGRwQXQ3Z0lOTndybW9pMVJZN1Nub2hPNWZ2Zm5nQ2h4?=
 =?utf-8?B?Rm9uTS8xSlBPdFJvNGZGd2hMUS9GbTJlSHI4WUorR0FUQ1BKTmRtYWRTMU9r?=
 =?utf-8?B?dkhaek9jUlFFZHRlTFp5M1djN3UwYWlObW9ONGxQTTZ0SUJkbHNUbHcrNXkz?=
 =?utf-8?B?MDRBUkZrRzloUFZKYzdlcE5YOU9hK1AwMVVZYkdoZDRaaUZRTmdmaFVYWHFR?=
 =?utf-8?B?NnF6RVY3WkxSeTFiWmoxemlJbi9STXJWaXE4cWdJSllQbG94M2Z4UVRLV0la?=
 =?utf-8?B?c1F4OHRMYW9hd2QyQkxrNDRiSGVrNi9sM25KWXpYNXMvMXlDNzB4SG8ydEQz?=
 =?utf-8?B?MXVoRWg2NDh0Tk1WYzVWTXhsMzhFRHVRTWdOWTRaM2pIb2JGekkweTJQTzBh?=
 =?utf-8?B?K2UrZWMwVVF4NXNZRGlROGVWZll0cVREcVJpRUJMVDRDN3RONFpQbmJyWHN6?=
 =?utf-8?B?eCt0VmRlYUswcUZsUnVJS0doY1pPdVlBbHdidGZWU3prNlJ6ZlJsMGlQZmtN?=
 =?utf-8?B?SEpVL2pXWnlmcW8wb3ArL2N1a0pTVXJYalI4N3pBWHptekFza2RRdndqTjNV?=
 =?utf-8?B?S2RFM2ZzQTlMeTFPSTVrWTBYUmNKc3d3cFljamd6c0FoblZBUjh3SFRScURh?=
 =?utf-8?B?SytjMXRwU2VWamZ6KzEyNHFJY2dldHFlQ2RVQlRSMTlZbFJtL3hJSldadTk2?=
 =?utf-8?B?Q25aRWRMM0NMNkU2eFZhR3hyY3pGVk53c2hpQXZ0d3c0WG1xcjlaeHV4SGFI?=
 =?utf-8?B?cEFXTkFwQ0dxbEVoRitRdTZxRE5KR0JqS0R5VlJFSWppSDQvS0RRcWV5Nm9U?=
 =?utf-8?B?d3p3SnNLb2FKbXB0ZHZiWUEwcVdTWDVzaDlOcS8zcHR0MmwxRkJjcWc3ck5N?=
 =?utf-8?B?bWI3TmwxZ3ZQWUNjN3JyUTB0NWdYODJ1dDFOckpHQUhCNXpTczZHT0JJRWpj?=
 =?utf-8?B?WmFwY0txQTRzd01pcnZlNWZwbUlpb3BCdDZJWXl1MXhVcXMwenBCdG15OS9n?=
 =?utf-8?B?TW9WZldycnNIS1F3MHBjQWZMdGQyYnBJQ0VGeW93L0o5eWdEL1hHbjNkNUh2?=
 =?utf-8?B?Q2hBOGxyU3prMzNlM2diaHR3Y1FYY093VUlTcFBidnlZME0rM0oweTEzVm5n?=
 =?utf-8?B?OGJtd0ZDWFVHTENVRk5waWRQUFBnS0pmVVFPdUxRNEpzV2JjTlBoYWFoMUxW?=
 =?utf-8?B?OTltalcwTHg4c240TU1TZzNpeHJWS2hxT3BCZmFuOU5jdE5kZ1dyVlUvUlcz?=
 =?utf-8?B?UCtaMzAxMmk3elVWaHdkSXk1Tmg2Sm1ibUZ3VFBWNzBwWW01R2tVTUQvY2pK?=
 =?utf-8?B?eERrUHlkME9tSWtXY1NhY3B4MzNVN29CbHJPc2pWQ05CbUNHYmVueDlMSDFG?=
 =?utf-8?Q?2SWWkth3OfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1puWStBOU43Ly9zbUFNRFg0K21EbUxEcmVUYnZzQllobU1wN0NVbmJHTDRy?=
 =?utf-8?B?S2Ivd2M2NXM5UHJBMWxPdzFWWlZwQnVtRkZiVlhMZmExYm9FS2xkbTVVMENF?=
 =?utf-8?B?NU9UNXIyUkpxbG53Zkk5Ky85TnRIMDZCRGE5VjZFU3RET2xxVFZYTXF2dTZz?=
 =?utf-8?B?SkMvMG8vKzdOUHhWeW00cUg4RWQ5azlLWk1LMmlLemRaUUJQSm9TN2Z6VGlv?=
 =?utf-8?B?WXlPWXdRenZLTWczWDZxa0ZRK0RUVUVJMTBZNmszVmVxT1FZbklnSms0QjZp?=
 =?utf-8?B?MHhRdjZKMytYNEd1bE5laVk1UkV1cktPUG11MWxGcDdYQ1UwaFJuNEliSW13?=
 =?utf-8?B?KzJmclFQV05SNVJGRHdSQUEyNWhqYU5FNzg3ZksvOXJMTjVqNnBLeWlMRnZW?=
 =?utf-8?B?Skx0YXd4SERuMHIxMWtaNmU5dVdxWW5vV2pZZndDeVBSOTROLzMyQU9LSHls?=
 =?utf-8?B?c2ZVeUhWTC9xOFJOTHUvZlpKZC8xU3pNQVdvQjNoTWR5Tk8rYjZjQkw3MUFG?=
 =?utf-8?B?dVVrZlFZUXZoRGdpb0RObG81VjgvYks0aGt0WFdMTGJpNmRQTDFzUWJTcXRC?=
 =?utf-8?B?cHcxeXlZRjJoVHdrcHEyZFViM25waDdyTmlFbVJHeCtRZC9EamJvT0R4QzY0?=
 =?utf-8?B?NDRXT0s3Wm4vTzgrMDBpNW8rTnJkMjRiNG5mK1pnL2N3NDE0RVZjOVRBYjJG?=
 =?utf-8?B?ZjVVRFZCNHNqM05OczB0SVYvMW9XSzB0WGJhdjVXTDh6L2FMQXJ3UFAzMHRZ?=
 =?utf-8?B?MTZVTW1Ndm1aaVBiNVlEVzNIdGxjc1duVzJEcVpGTFhLcEtsYUdaS2RFbmlC?=
 =?utf-8?B?dFlXS1JnZDRHSzZKak45SVM4YjlCdDNrMkJjMmMrbWpYQ1ovdkh0VEIwdG03?=
 =?utf-8?B?SXRyQTVJak13elZydmNoak10SlJqN3ZwclEyZGpndXFacURnRThkQzB2VTNV?=
 =?utf-8?B?ZzcvR2hmbEtRRHRJSzJtMnRLYjJJYXR6YkhUb01kTUt2T08yclBHZE5IZldw?=
 =?utf-8?B?Z3NQSFAvK0hGRnIvaUZoQ1U0RzhuSmVJSEZyOUFVMm56ZEJvNTRqdkVqMDli?=
 =?utf-8?B?WUtzRkljdXd6bnJxZzd5MWtMVWVxTVNaUkJuOEw2TUF4dDQrdS9oMmM0OTlk?=
 =?utf-8?B?aHkwYWtXTDd4blRhbGpPcDZoTVJkRUVSNU95QnBOZFg4NTB2bENXYU1US2FE?=
 =?utf-8?B?SXZia213MWlxbDVwWHlrZ2ZUbzFEa3JmYnpFYUlQUWlJM2tTTXpRTVc1RktE?=
 =?utf-8?B?amoxS3RDMllrMnIzUEhkMzd5NEN5ZGpReXVraUdGbUxmZ1F2bExTNnFZOHRL?=
 =?utf-8?B?dE9ZNkF5U0JjckNpMW5telluWHMzcFFOYmwyMnFQeU5iVWk1cmN1Z3JHZXE4?=
 =?utf-8?B?cDVrVmsyV1RMNEZ3SktDZXdtcE9YVWNqM1ZwSnI5SGtKcjBkMWVXMjBaSDly?=
 =?utf-8?B?dEZzY0dzRUNFZEpxa3JmOW1UK2lhREp0eExJcGd5ZzBDVklQblkwaWZaZDVo?=
 =?utf-8?B?bzJ2QVUxb1dLU0VjbTJ5UVdiUGxUQVVhK1N2VkFLc3JrWDg2N1pDRnFSVWFD?=
 =?utf-8?B?Yi9FYTZsekhVOFF0MHJhUnNzSnJXeWVGZm1Va1pUcEh5dE1tdTcxS3hZUWFR?=
 =?utf-8?B?dWhCVlVNTUFNbXhZcGx6QStBZ3c5R3pFVzdGaXR2L3BVRFNra1BiZkZKQmY3?=
 =?utf-8?B?RlJRSU5tZlhqMS9SdTZRSmVmSGxtZmR3MUZ6SWhLZnQ2Y3FFNVZja3dyVTNl?=
 =?utf-8?B?U1dtTk1iUmFJcE9DdG5PbGdUdk40MmZTYS9QNDJuTGRrR1RQL0t3aENvcEpX?=
 =?utf-8?B?TWZUUi9YNE1zTnIrK1pXZ2EyV2VXcFEzYWFiTDIreWpKZzdiN3hRakhXQ1NT?=
 =?utf-8?B?THFpWEtPRHZBZ3JIUGwrZmF1U2pQUi9MNlIrMDZsTzRkUTZPVlVpYmN6QXIr?=
 =?utf-8?B?cHRGMjdPUEtIb2RKV1Z0Y0NoOURMQThNdmtFLzhEOFpjd1M5K01LWWFrUldo?=
 =?utf-8?B?NUJsMmo1Ykh4cGs4NndPSGlNRkZNV05vR1c2b1hFemZ0eGhPTW5aTnovQWtv?=
 =?utf-8?B?LzBZZkJ5NzZuTDlmVFNESHJDckJ1YTZmKzZIRW5kR3hxYktuNi9TWklacWRr?=
 =?utf-8?Q?aPunZzPoIGncFfuKcd+GABv28?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3274fe6-57e8-43a5-90b5-08dcc73e5d87
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:45.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnpe1pQ0FJ8T8Wg3kgVgsvwGJH2EXCT+TMw5JwxSaNg9fi1ZELmCbt8fO5C3urwGniiFQNdBpYxgcDF4G+eNKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases

-- 
2.34.1


