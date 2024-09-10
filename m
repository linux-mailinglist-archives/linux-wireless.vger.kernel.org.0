Return-Path: <linux-wireless+bounces-12720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED397276E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2530282027
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85416F27D;
	Tue, 10 Sep 2024 03:05:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08116DEA7;
	Tue, 10 Sep 2024 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937545; cv=fail; b=o110FkTquoQ9Ue/4xBqTnBlJr6bmT8wYOVtCeVEhTH1EtBgh9hA1/fy33pmE50Cz39nGkrrAZ0F1C3ckahPlXDgCrNwYLjSbh9Yzqw+umyG3k9b7Sp4QKa8MM/tqBX40zfa6pKRXjBNH62E+UTMIYDQvWj72NkCyiwK82Oj66+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937545; c=relaxed/simple;
	bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PmLZao7C2TzwmLCUvaeMhVB1bEEAc50k4kBD4eKMnBWv5O0VohPK44K/M2/6OsiZGWzldgPZf607SCJhTAhki79AKefPiQEETnaif7bxFnddw3GqCxev7m2K/hYGo+HowO9lXJ2AYJIkI/I9qU4kUNfzA91VqEBhYWKJe/e049U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4FaJMlGeThX/Q3XlDAqb3CYAax5hraaJjc4ZfeWWyxRhuatqovMHhzbbFjfpbYUX8KM8BlCgxYJEBnSYuU5Q40xnQU/3e+r9VD7k/HcfP35PwT6pFeHZ8nPra+SDTaqb4VLne+R3xrl/m+g88by3RHKm5z+3u3Ki5kVOZndYXAi49OuJ6GqSiR52vNbvGlA0mAjF5bcrShKqWkoPPXPhuW1xWXW6kodLLOldTDhX73E/PlgCNuiTlcAWCXzCi5S8RyNASC0HWW1wAOgJrODwf6nrITVop/WWFsXq9pdptlNM0I4r4Nkgl+C4w07TLEUa0f6P6CTxkk/DtO+BW332Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbxQ8CN2hEqCPJsO4yOc2S/gFbfZhs3WhsZPY+vH/Dw=;
 b=ABaU0U19dV5JSFID5rRQ6lvIfdvKvqSnLhf7LtX7TeguvURck17bkqirDFZfK7lgNaur2GnvMfXUCkK26gQY3TFcvuRJ2wWzaEsvdAABHDdOoLYo9Y2HlTMJWDAdoEhMZjBjYRj6fKAhWWTzCG3L3R14Bn49fxMXkckHvpOOezMM1DfAtXO3Qs8JpIho9gOIekygJNfV/RpGwnJaOEkBjwnHVws0d4imG8ZmfiFekd2KJZ8wOmts78Gk6+9jFOR5FfD978yEmcJIJh6NusKWdNaO2smNTcpOLVZeSQUKw/1g7uxZeOTdsfb3/zKyw3pPj4+okl3vm0i2uJ6SDGFLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8442.apcprd03.prod.outlook.com (2603:1096:101:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:05:36 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:05:36 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 10 Sep 2024 11:04:11 +0800
Subject: [PATCH v14 1/4] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
In-Reply-To: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 nick@khadas.com, Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937530; l=1081;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
 b=ggqWWBOE927fFqoGTZyalFb8LwnHtQGkIeSGfEEgIl0EK0H6RhxspIb/uBeqt31Qq/8ATNPZd
 WUa0E0PwrK2DJJz2LpxchWQCTG5ARuvsq1P52XbyRs7lbAiE1kJezKO
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c817d9-f445-40f9-badd-08dcd1457161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjA3UHVGSWc2TlVJa3JLOHJCVlUreVF1T1dKSjZnWWp5M0dOanlDTUJZREk5?=
 =?utf-8?B?YmR0VC9LSDl2V29lbTArUGhYNWZaWkRoUDRIOHMxcStxYXFuZjV6czdWWUFV?=
 =?utf-8?B?dnhvMVFqTWg1SitubkxTa2FnTGZYdmZDOXhhZGd0OTJ4R2w4UlA0MHVhcXdx?=
 =?utf-8?B?Z0RoME1WNGlEWWxabldleVYwOUk0MWV0VVRXYlZIa1JxWHRGNkxTOGZVRzhy?=
 =?utf-8?B?SkU4N1p2UzlmNUw1SnVsSy9oY3M0RXlqYjk2TTlUMitjaGc0eFpmb05ZR1Yw?=
 =?utf-8?B?ZzRIQWoxKzd4dStLRG5DZklRUy9LMWJER29rckNHRWZlYk9iSkdNemxxZHB1?=
 =?utf-8?B?bmxwU3VhNkxtUzd5YW1SV1g2bDRwb01YT1gzcW9UaEZPWmJOTFBXbmVMRlA4?=
 =?utf-8?B?RGkrM2h5c3dFSk1zQ1UwUlgxdGgwTVg1Y2RUUDdSdDQrSmNJZVo4SEpUTGZ4?=
 =?utf-8?B?VHlpbGwxZjlhQXJwWFdsVGxPUzJQODFjK2Z3UGgvUXdoQXN5WDNBZFRKWm9Y?=
 =?utf-8?B?TmZrR090dk12MmM2VHB4T0ZOUy9sMW1wMGpXUmxjblB4VjRrY0RFVXVaZU8z?=
 =?utf-8?B?WFFScXFkanBVbkc1QmtYNTBwN0xCV0Vnd2MzODlhT2pwMFdnd2dZblNmS2Fa?=
 =?utf-8?B?aGN5MDZBaUdtdHp0UXMycE85WTVhZlAyWE9KdzdTNE14ZDdvYnNUQW5EZXpI?=
 =?utf-8?B?TURVdzFvUmRqODhXVjVNTTNaVWlqRGhHclA2MnFBd2ZDK28zS24wOXliMkpZ?=
 =?utf-8?B?Q0U5eVpEeStIMFFuR2NCaG9uRkxRSnEwNFZlOGRhNmcyUURId3AwcnFabTRv?=
 =?utf-8?B?RnFidHdFOUtPUGltT2t5U2xLVUF3aWFLMWZKL0xOd0Q4Kzk2MStwaUs0VEZX?=
 =?utf-8?B?ZENxZXh2cmx4OXh0b2lLaU91NkU5cDdQdGhPaDFGNSs5eWlacGNDeHg0SEtF?=
 =?utf-8?B?bTNHVnpCNGZFU1ZET296aE1EWUdLMlcyRXFaRXUxMHpLNVVCL1ErT0ZQRGlm?=
 =?utf-8?B?U0k4dFJBUTgxeDhqQUxXQ2o1Uy83RDFQTS9Cd09BVVRtL1RmY2FLUXd3Z1RL?=
 =?utf-8?B?ejZVcTh6L0lIUzFLVHpXQjcvZnJLWWtsWm52OEZHOVZrNnJMTG5JSXJqazlG?=
 =?utf-8?B?QTY3L2xYZEhDVHJEWFhJSllIdEZPSGFHZitlNEN0VWVjR2c2blJ0K2xDc1dY?=
 =?utf-8?B?ejdzMlNZZy9ncER3UzFXSTN1ZFZSbXh3Vm1HVUVzRndkMW1uZ3VoZm9TaXVl?=
 =?utf-8?B?QVFERkROajB3ZVVZYVVaajFBc0VlYnZOSm1ZN2dCSFkvM0lqL0kxV3hLcHhV?=
 =?utf-8?B?RXNjdWh3LzhaUks5ejBBNEdFa296K1pabWRYUk5kRFZON0hhWTBYMXJzV2pp?=
 =?utf-8?B?QStKalhQakEwanVlT3VvTjdCeWg0Z1RMTkF5b3pkNFJvNDhCbGpTdWpSTVZs?=
 =?utf-8?B?L0VheHVNdEVIdFpYNGc2T2UwY29nWFlwVlJTeFN1QkgrVGdDWTM3QVFlMjl0?=
 =?utf-8?B?VzhFaGpoUi8rSVVuUnRFSk1wWE51YVA0eG0wSTYxREJLcm90Z1VxODRaQUg3?=
 =?utf-8?B?YzREM0UvZTFiUVF2bktwc1kyT2hxTGRCaURZOVlYMW9qWXR4TlZHd1RFdnpj?=
 =?utf-8?B?azNGSnhqU0NuU3BTVHhpYnZ6Vkw0YnNxcVdPaGFOeWF4bEtTV0dZRW5lU00x?=
 =?utf-8?B?UGowWStxNkRCK2NvejYyWE5VY0Q3TzhhVjZKbElTUGV6YmVTbWxCcVBmcytt?=
 =?utf-8?B?QmpPS2dhSXZlWHpQYm9ta1hGSTlYMFJBdjlsRGIreHltdmZSS0U5c3g1eXYz?=
 =?utf-8?B?cXhLUmJpbmJrQ2plZFhYSm45SGhyandwK1lJcFBUc29vVFdwaG9ESkloR0ox?=
 =?utf-8?B?WlQvdEMrMjNQWWhyMHkybXZYeXgxM0JSaHMrVld4UU9rRnQrT3dVanA1bVBN?=
 =?utf-8?Q?tELvZz5a4H0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlVwWDloTEhoSVorWGJPYXk2QVQvNUxqTHJ6VnJXaXU0S0hHTGJyT3RLNTNu?=
 =?utf-8?B?WlZuemZVbHNTcDFhZjdDSU5BZnFEclVQbUEvK3ArdUhwYlhXODdFNmx4Ty9X?=
 =?utf-8?B?bnhOQkxZNmNsdlRoU2hlUkZ5NDhmS29ZaHlvbkhWQnVpNTZoazRGbmFpVHdp?=
 =?utf-8?B?TGN0SjlFMmMwOGpTa3VVV2tLR0YrZzBvRjZ4ZHQzRG1BbXFmZVNnUWVpMHBw?=
 =?utf-8?B?MWNnSEFTemtzVVd6Q3oyYUw5aWwzUmREUDd3dTJiSlRGTGdiVXZUa05tSFd3?=
 =?utf-8?B?SENzVnZnWk9vcFVkUmJTQ3VOcUZ5MkU0bVZiZmlVNWgvcCtuRk1Lc0RqNkx1?=
 =?utf-8?B?UHk0VCt5bFpvNGVlVXRHaU0vckFsOUFxUmhpallIdGE1QnlEU0J0ZFFvQnA2?=
 =?utf-8?B?dzRFMnBNZU1Ma2RCT21XMUR3ZG5lRVRGVUFYem1RWUVHKzYvYUd1M2drVjhy?=
 =?utf-8?B?ckV1MCs5YWpCcHZuWWNTVmdseCthNlpacFVweStBWkhQUXpYUFhoelNWOVFr?=
 =?utf-8?B?SmhWa0s5MW43NEpVeUNUc1p6UFJ6Z3JUOUU0OVNSN1ppRFFBcFdGd0dKeXlJ?=
 =?utf-8?B?U2JXb0o2U1JGZi9yWmtRMEYzUG5uS0Z4U0ViU3h0WDRLRytGYnhyVyt3dHVR?=
 =?utf-8?B?L2RoRk9lY0ZaQTdXY2dTL2UvZk9pMmtacit6RE5rUHpiVTRVQjR2ZDlyVmpo?=
 =?utf-8?B?eWhiM3I1ODFKQ2d6aVhLdi9IWndzc2xPbHgwL3ludk53NTJoQ1JEeHpCRzMy?=
 =?utf-8?B?TjNFVjV2STRtWGhybXI2a3QzTGYyOFF6TDFSSVZ6UGppelJINlE4V2dBUFZR?=
 =?utf-8?B?bXk0RU9QbjFac2hNNUpDSDZWL3paZlBidmdzK1k2TVJHY2kzUC9MZnZJdnZ3?=
 =?utf-8?B?WmY1dEpPUE15YzQraVNhY1NFRDVXcnNGL1lRdUpnSXY3SmNNeU1HWjlEcG5J?=
 =?utf-8?B?QmVoUURhSHNUSU9iNVh0N1JlbXhPblJzYnpLeitaWk9JaW5iUENiU2w3VDhr?=
 =?utf-8?B?VElKbHpzSkRCbjlmNnVhbTNkY1R1a0tlU3lQUDNRQkg4d3llN3lZdHQyeXA3?=
 =?utf-8?B?VkhzQzAyeGJvb3RiMVlXd01iME9iTmdsOVE1YWgvV1dNOHA0d25iK1VhekdC?=
 =?utf-8?B?RDVvU1hZY0ZYdE9ONThiUDhQbm84VXpnWjBweEw3TG9pb0tSVm5qSVhrVkVD?=
 =?utf-8?B?aWd3M0hTWVdzbmRlc2lZZUtVL1NzWXVDTGVkQ1NkdGF1cE1ZSzB6THduckxK?=
 =?utf-8?B?UjhtOVpjdmZEamVyeGNmdmlJd3N6ODV1eVVEdTdxZzlsTDZtRWlXYm15Mkds?=
 =?utf-8?B?TFJlczRwZ0hTemFleDl1SkNMSmFXeVhua0VoQnVkWGRxSUZSNWM5M3ZrZFJt?=
 =?utf-8?B?RHJ0RGM0aWc3c3cyc0dpMWxUTlVabVJOdjNiYUtwZVFGbHNxQmxVT0V4a21Z?=
 =?utf-8?B?cW5ldWFvaStndlkxQURYSWp2a0lmZVVyUVUyQ1d5KzJEUC9TaUVnTnF4Vzc0?=
 =?utf-8?B?T0Q0Y3BIcWk1bjVZbUxKTmlUUExPbHBRNkFnbGpqejg2NGpoZ0dFcU5lSEhB?=
 =?utf-8?B?WE0vdXlwbWxNZnF2Q2ZyL1hJQTgraXQ3RVVtUnRXTGhPZEZDSHFPL1BGa1ZU?=
 =?utf-8?B?Wk4zOTllMmtxUjFkVFoyZGN3ZUFqNGprblJObzVMd1ZxbmdvWFIyR0c2eGMv?=
 =?utf-8?B?NURzZlZ2aGpMVDJrV0xibFpqK3VVeVBGR09uVk1Gc0VRYmlkUG90dVhySnds?=
 =?utf-8?B?T2h3N0s5MnR6MkJvRzJ1bmhqT2x1N0x3a3R2a1YvdzJUbmJTSWJNMnZiSllF?=
 =?utf-8?B?SGxGSE5sUU1SZGdJMDUrTE8vZFZ6UnRYSUwveDk1dEhBK1pqSzgrcWpVNjVZ?=
 =?utf-8?B?dTl3V21jZmtaOTdpQzY0bGRJc3lBbWtaRHRjaUFxOWcwU3YyZFZFTjZsVmxP?=
 =?utf-8?B?MDdOY1pNbGJ5Qnk2a1hmV0t3ODJEbkZVZmROeTRmYUV2L2YweDFxYkJoWW1C?=
 =?utf-8?B?YlgxS1FGU1dHaHpZMFpoRTNsUjNqU0xZWEFnaVNYUVdJU2IrWXdvOTdjakJt?=
 =?utf-8?B?dWJ0eGRrQWJ6NlNJS1FBTi90ejNyaTEvLzFpdndFUE9hejVoTWRicEpCQnpo?=
 =?utf-8?Q?FTtM+mOQgI5KqXsfN8jA6EArC?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c817d9-f445-40f9-badd-08dcd1457161
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:05:36.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G539ZfEu/fv29gXLkkHG4m70i7mL6tMP/UxG9jLAhoHVpQbMgRf1CHWD8iXQRxPs+vq5712QfXywlwR+Pmt6ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8442

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


