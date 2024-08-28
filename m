Return-Path: <linux-wireless+bounces-12144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0F9622BD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE11C23901
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28A15CD54;
	Wed, 28 Aug 2024 08:49:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026E167DB9;
	Wed, 28 Aug 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834998; cv=fail; b=agzlHjW+fsWiJj7NJiTnnYUSXl8uuChk7gf5yDIireLwZ16ueFrMafnxne2jAOTSGe0ajEczDNu8jLt0tf46WBxsNDNmv0dW+yV5sv2r+QsSPAD78i6Cp7khAbWphwvcfU+Ti3i/LwUvyEfacLhXUqbNsJ6zMA/iTby9DpDvdwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834998; c=relaxed/simple;
	bh=1EIqUH68e2yHYUoqfpobt6Hzt4qoimWdTYOf3QUUDbM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fVriuEG/GfCGuNxx7ooMClEuZnM/H2rlJEwtrzyzVWilvTsAvx5vU50avxOqZIaX+lrXYqozn7cnmgFQzLI4ukN0HwPCQFKPuwlD2GG6K+eWULIG9iX4ztrvi0+2Hfq+MQanjizDUCbgbSIXEFoR22rFy5VxQ9Kz4AXJdpz5/h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX1bdWdoLMe9XQFyc0E9baI/3/gMT/sBkgG1ya2aEI5gTO4Gm46g37jrE4Zdxq3YvedDvpYNrCu7klLz3Ubt1BT2aN2fW/WDZAv2QEiEPwgbYDL0NpEz2RGY3OZLwn2q1ycmYmo9RfukYGDW9NJTNDTb8Gj6fvuVIGfZmCGVyBzEBzysOmnuyWYzl+JiID+Xsp8+vFjq5EMpJ8KPtRQAmnb7NOak0EHVmgNHjJFpMqqLocZjFpHwRxBwf1x1GW8yaqv9Iz3rd51/ihPgOPcZXc1BtUO5z7D1ztMxxii6U2t5+JjwZEkQKI/CeeB+T3Ssbh0xLHxOdA1pcWrgY0BV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlpp3oox8tLYxz6TyL3i7Joq2cepMbm6CkxqGzFixa8=;
 b=SvZy8f9qj6MxWbGg8Zypciy/fWCOiCnq51HPJV1EDwV3a2Fa8aCKYX7vjpgL9qkemZ5Kkm77RUTDonWXYcarMPK3BwWp+ZG5S+ZVk0qu+vTxzRwUTMlWHjrEUxPritfw6xrBRGv5EUo+fM0Nx88TuOvn3ywEuB/u6ScJxBPZh3qK+NCmXtEUcDSbMmHtrKIvl/ChgGbHylSwVVJzKTqUt58JM/xAYJecSblcYQrU7KWAejUdBG57qh7i44hcDPUPr1xUyprHfrJsBatc4TCxjWF2+guPu9sjyEmf8+3BwYCIXjQWpH4Uw0BI5Xq2qOH8Ver/erm2KCgZ02vLiqiBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:51 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:51 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:49:25 +0800
Subject: [PATCH v13 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>
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
 Jacobe Zang <jacobe.zang@wesion.com>, Ondrej Jirman <megi@xff.cz>, 
 Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=10253;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=1EIqUH68e2yHYUoqfpobt6Hzt4qoimWdTYOf3QUUDbM=;
 b=W/Z+9tvRnS0PPTpTbelbn3hmqC8oRSjXXjzNc4WuT0ewG+uXYPsx8RkNLFveIw6rSDdIjGxvp
 +c1hreNpqLEA/tbixg5aM01AInT1yPxLhDCZFUNclW6A8Qy+DsGWwwz
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
X-MS-Office365-Filtering-Correlation-Id: bd7bd374-3b8d-4cd4-4eed-08dcc73e6126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZjTXdlMmwxTkNZa2pMenp2RUU4ZU9CMlZSNjJVM0tkN2FCL3lOdi9EMS9R?=
 =?utf-8?B?U0YySkszbDIrdW1FVUdaczJwTzJNRG9QZnNlWnVXR1I1K2Nvdy9OWnRLbjJF?=
 =?utf-8?B?cTFNdFRXUEhXSkIyTURQd05BWEJSWTl1WGNWWDY5VE1YK2toMTFJbjNSdXlT?=
 =?utf-8?B?WWI3MmxJWEtlYXNsdit1c0tFbmpiSmxQV0xpVlZ6OVk4d0dtdTlPTUhMS3Np?=
 =?utf-8?B?Q1N0U3RCUUd6N0RZRS9QWlpVbkkrNDd2ZFo2ZklRbGxVOXV0Y0VVWHplckJE?=
 =?utf-8?B?Y1h2ZlpkNnJhZHFhZnl1SDlQTnkydHZmbm1uZFJWdjJvdmljazF6Q0tjRUpX?=
 =?utf-8?B?aUszeUZOdGZmMHQrdzNOcmZhRCtSakMwU1UvQU00ckJ0aUVhb3VQQ1ROSk1i?=
 =?utf-8?B?cERNTGJTVGozNDg2STlIdjB4THU0Wk1kQmptTkQvMkxPbFhtUzZZV3ZwNDVm?=
 =?utf-8?B?UkJxeUVtMmtiTENvQzNEa3JNZWRxTDQ5L2FHdC9XMUxwSmJzRzlWNTN3bXU5?=
 =?utf-8?B?MFIrNGVQUTVoUW1Gdi9nM2dmKzAzOW52N2hlNW45cy9nVm9GWVBDOGVqZHNN?=
 =?utf-8?B?OEFUZ01FV243eGNObldzQjlUTU1hMmxlQW1DWFlsaFdBazgvc3BlM1ZGd0My?=
 =?utf-8?B?YUszV0pHZVk2Q0R4NHBJSHBvMDNoNzhUNjJPS201S2V3TjJ5b3M1T3Z3N3pk?=
 =?utf-8?B?YTk2N0NLRVNBU3drdjBmWlN3eS9NUWlJWnRxa3laV2VkNUZubmdKcTNNaW5L?=
 =?utf-8?B?NytZRVB3OVJWSjBJWUxYVGRqdEsyNDlxSDJ4VHJ6V1UveUpGVk1NUWZNbThB?=
 =?utf-8?B?MUtHYXlKVVBxa0hwZVZBR0srVUVRTkxNeWFBWjAwLzkyOXpyV1NNTk8vS080?=
 =?utf-8?B?M0Jud0M1S01jQStCRGo4VWVNbEE3di9GRGlURjRud0ZUVWdvekFTOTB2Q1F4?=
 =?utf-8?B?ZmV0VWVEWXA1ZmlzRDlWRUUrbUJBMDRKSkxrQkhwYmx4MmM2MHNuQ3Y2czQ3?=
 =?utf-8?B?enFNMUx4Sll0dVJJYTFEeXpMRFF5UG44V2RXeGllZkJxcDhrcHRqNTVTNnF3?=
 =?utf-8?B?L2Z3N2prZUxLMmdxSW5aVzBtME9FNzhwOFN6OXFDN2JBTU5IVU9uMGhlN2JE?=
 =?utf-8?B?d2toRlNyYzRtZ2JkMGZZTWpqMFQ2OFR5QWhrZWpOa0JEY0VEdldZcXlIVWxu?=
 =?utf-8?B?RFlKK2dTTXpMcUNoNWJuR1pCd1k5ZFpUMlNRSmY0a25QcXE4WmFiWFB6SVp1?=
 =?utf-8?B?SFg3RmhUWkRnYWtiQjNFYllydzJ6UGxuOFRHUlpwWEFvbmRPQ1EwOHNNVXdD?=
 =?utf-8?B?Y1BVRW9sMDNLQmk1QjB2WlNxbTA0TUUvMExDanVidHN4cmwvSW1meWNTeURT?=
 =?utf-8?B?UVpmWm1zTzlORkhFT2JhMEpQbS90aEFla1BuMUptSUZaVEJXVTJlclFYd0pZ?=
 =?utf-8?B?WlVaTWt1L0YyRDFZUjcyaXB4K0xnUXd5WmpKcGxaZ1RiSXFuMHJ0VHRkNGUz?=
 =?utf-8?B?TVVqLzZxWjNEeGt6QklzTTRZUjZyazZGRzMwdnE1dEdVRnFlTk1rMGhHZThM?=
 =?utf-8?B?SjNpdzc0dzJ6MXY0VnA2UnoyTXI1T2RtS1FSV1pYblBxZFMwVU56RXBBYkxJ?=
 =?utf-8?B?a005cm42cGlBRXZXSjBVZzBJQU4rajFtOC9mOWlqc3J5V1BiQ2hMUWQzTnAz?=
 =?utf-8?B?NWhLRWxZSEY0KzBpUVRwNWRMbkM5Vk41SDVqMVA2VzE5UlBBZW9henlBekFl?=
 =?utf-8?B?NFR1eVFFVzk4czJrSG50UVdGeUk0ZDF3RmVHeWh6clVwSWVkYTNQcFhPOXQ4?=
 =?utf-8?B?VVJpN0JuUWlXcStCWi9sOVlRRmdsUzFvVUprQmd6Q3ZDNE95OFRzVVdJR2lu?=
 =?utf-8?B?cU1CVkZpYnQzSTMvZ0VhUFZ1MWdCMFFFbm0zMXN1VHRWUlFUK0dKalhZQkJl?=
 =?utf-8?Q?rHBuyeOnrsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rys2NktuTUdtNllqQ1JuNUJLaVFCMmUxWkh3Q21VZDVuWmgvU21JTDREMFZa?=
 =?utf-8?B?VGhJZC9qNmZ6dXkwZk0zd01LOGRzVkdJaUhwTHViZTlEdllISlFxek80ZUwz?=
 =?utf-8?B?aEIySXU4Ny9aOWtlTlNtQ1hhWHBzTDhwNU5LNFgvb3JRQitobENFaGxsQTBl?=
 =?utf-8?B?S2dtMndubXhiNGUydlNoTWlvbVJlK25Ob0xMVHJEaDBHdkNTQ0Zka1UxZUFQ?=
 =?utf-8?B?VE9lNC90QlVDN3Q2eEtJbjd2V1BCdjlRZGNMejcrRXVnSldPdVRyb243UjhU?=
 =?utf-8?B?amdyemF3WVNwazBxUDA4M1d5WmJnK2tFT3lDSVdnWHovUlJOZzVIUmloVkRo?=
 =?utf-8?B?WFpqYzlYWlFTallMMi8wcGprWS85QmpETzNCS2toSGN5MWZBelRYTENjRW9s?=
 =?utf-8?B?NWhIQnErRHkwNTFyWjBHRHF3V29qTmpNNWhiMzlwR0hSSStNZGJhZTVCWnJJ?=
 =?utf-8?B?OGdqa2UxVmgyNWtNOHBjSnB4dFJ2SVJlOU5vNTM3SlF5c21UbHJ3cXloVXdJ?=
 =?utf-8?B?Tmc2RXdISUtKL2huRlNKL0F4eXlQODNDWGRZQ05xa3ExM0RDbGYxSlkyamNE?=
 =?utf-8?B?TFhqYndNb3cyTnZib1lVN25kNHhDczBrb0dzSXE0RnRUb2RGWGlqSmU4ZGp1?=
 =?utf-8?B?Wk1jT2JST1Ivd3FKcGJhYlBTVko5emhvd0JqKzhNVTN1YndHQ3lkRFAwdTdJ?=
 =?utf-8?B?M0Fzc0p4M3RVMDR0WVhXSGlZTTJxN3pnMXJybmgvbkV5ZzVNdDlWenBpb1ZU?=
 =?utf-8?B?c0Z1N2xSOHJGdFpwUmVXY3JRMkxpN3dKMnNLYmZkUjhCVUhrR1FaYUdFUFpx?=
 =?utf-8?B?OU1NYVRtUzJ3S3ZyV2NlQUt5U2J0VGwzTDFDSlJRbzVRY2NIUDJUc0dRUko5?=
 =?utf-8?B?UFVQWGRXZ1BvSXc4SkhweVVlZEwzQUs0RGVnUndZaTRGUk52SHIrOTNFMEM3?=
 =?utf-8?B?UmhKWXRnM2hSQk5BMTFGVERJV05wUFlLZHhxWDRmbnBoZjFPZ3h6TDMzTG9V?=
 =?utf-8?B?V0dwelV3VFhvZnUxMlQyNjU0SmhuMFFhdFo4NjlpdG0ra1dxZ2pLNVhGVjg2?=
 =?utf-8?B?M3ZRa3FnKzhjM3JRd0tXd1N5MC9VRDhIWUZzcUxTZ2hKUjg1QWZNYjNhNFlI?=
 =?utf-8?B?R0Q2V0kzQjdLQlVWeVVSNzNSUjl6ZC9mTWdYVkJrYk1TZ2tTN3I0NlRnMTdo?=
 =?utf-8?B?V3M3cG5ONlVSZlVzY1pRcE8yMG81bDA4WnhaRWlkd2EySTFSaERhdWdSankw?=
 =?utf-8?B?dkpFdGtqdlpaM2wxeGxuMXc5V2FsMkFmams5YmdvMXU3TVA0WmdwUUhaaGdE?=
 =?utf-8?B?bjNPM0MyeC8yY0hvTmphTVg2OE1uaWdwbmcxT1BPaUlRaDBnc3FZYUhJYWNl?=
 =?utf-8?B?Ry9xZFkvcnZpNEtwTUNxcmhiOWd3c0lsclpFZTRYUzlEZFgxVmJ6Uy9PcDJQ?=
 =?utf-8?B?d1N1MDRROHV2M1JpSDRKZEI3cHBtM1VIckV3NlJvaFZ3WGgzclEwUXNyNTZ3?=
 =?utf-8?B?QWwvNkFXTGgvbHRJVUszRmpObFo4YWxud1Qzdm5icFZaMS9rUzR0Y3RLTm9B?=
 =?utf-8?B?WUdHdmJIdUluMW9xRS9TQXNRcmZPNDVUQm1pRjJvcmVBSlRKem4xWGF4QUF4?=
 =?utf-8?B?K0FCQ0R0KzJ2MmdyYkVPeEg2aVM5MkVXWWY2NGtFbTRhcTh5cnlqaExqMzQv?=
 =?utf-8?B?VFNEdmY1MVdtVU5oaW9Jb29Zdml6eTF6bmJUWFpESU9TYXdnbHYvNGl5U21D?=
 =?utf-8?B?LzNvUThUOWl0YXJINVl5eHdBMTJ0dGdxWllXQVkzQ3c2bWJpV3VjQWVaeHBu?=
 =?utf-8?B?c1Z0R3JWZ3RmSFNkU2V1RkFvZGhKZHdaYVp5QW1Zd3Naa0pZVnNoY2NzbHpP?=
 =?utf-8?B?c1hVOFBYay9Ra2IwT3ZCQzVTVWNjZTJmMzhHcVhacDQwZ2hqRUt1Nmd0S1I3?=
 =?utf-8?B?V2ljcVM0M0NuYXJKdlpUV3pYQU5MaWdodHpLak5RR2NDMGo5a3kvSE5aRjBn?=
 =?utf-8?B?NzkxRGlQMkJUYWFGM0hhVWhqTmI5VzBFVlVhOW9MNGptU2ZQeFZ1TitrUkky?=
 =?utf-8?B?a0x2V1F1Z21nVnErLytVcE5aaE5ZYlZIcWt2YWV5RnIwTzFqWFhmTStKdkxT?=
 =?utf-8?Q?ycKOJekuBHiCfuSrD1LJ2wKzL?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7bd374-3b8d-4cd4-4eed-08dcc73e6126
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:51.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGEyi8ZeZa3pwEB5W3cGFbMlyo3qOkMGGRls+ozxwTBhZrkKcVIVrHncwIVIUapeXGYQaKyyCT5xs7hch24nPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 +--
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 ++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 29 +++++++++++++++-------
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++++---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 20 +++++++++------
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 +++
 7 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d35262335eaf7..17f6b33beabd8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f657561056..c1285adabf72b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,18 +66,22 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	struct of_phandle_args oirq;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -106,7 +111,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -114,33 +119,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
+	clk_set_rate(clk, 32768);
+
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (of_irq_parse_one(np, 0, &oirq))
-		return;
+		return 0;
 
 	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e90..190e8990618c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac22..59c77645e2183 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4452,7 +4454,9 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
 	if (!bus)
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8afbf529c7450..2821c27f317ee 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);

-- 
2.34.1


