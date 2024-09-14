Return-Path: <linux-wireless+bounces-12859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8586F978E2A
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 08:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8DA1F23F0F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 06:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79251C6B8;
	Sat, 14 Sep 2024 06:03:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77138B;
	Sat, 14 Sep 2024 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293789; cv=fail; b=kVCErYUExhmhUMZVtZhammZUKVU02Tw2pSob8G4NM2f7loKtySOlSWyOcSMwR72q3G7NkL8CltH20jQw1Jd+PTBR/ZlQcjvMmS1+cOhRkLDjSmAOt+9J+7r3+f/9sWyd/85zYhz9OmaYmRpgW0UEOG47S8vnty1tcxhEZVdIYv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293789; c=relaxed/simple;
	bh=DA5bI81LtShS+9PxLmrkx3ywp/TNnGU59rFKoztBWOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hu2BwVaslBIZSbiHHHuTx/0MC7na4MnxWfrPVNLShEqLXwQd6V6fFVAFxhlXmCyd6ArftyoZDIVAdVY7UNt6hfb53byX8/lHyoPWVB7fHfPx2lSUzYfX78izw7dZf7aytEPINqaUwYK9a0e9HCRSuvX0oIZ682gVoFINzBSnE50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJY3+9SsX2kr0HgB37Go7UmL3LR7LE2//Wnf9PWVfzWBiQbeatbLyTIAeedObglKMblYFMJMIsTyNvcS161ZzioYIXMcb/y3mRvoxIPYIKL5DBwUiDpQWsSbW6S1V4MKgPui9vuEkQKb8l5v+/cH2WNvIHWCU4Sevq1kwvIQOk6NMqnUBMRKGocJdU0pKMGlMNpSa3kXSq14etY9KsMIMBH9LCeUnaj/HpyDfpMYpyjVvWUGqA6eh+WfvEdmXa2/4yhxkuJ4+ERyK3voza6CyCFX6OgEWUYz0ACqzuH21l8bNNpXyrKUPIudhplpsh5HEK+J5joDf2ngdowX2aPl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQbSO35rABceheqdlL8om7sj0wukdAd8zvu/8JQ16Fw=;
 b=ja8fcLBMb1J0YZ1v6PTUAPpqZQ8qlDfybf3OIjK6Bk5A1qM68ETF2IMgqvtgZsG7MTJpqBOlc9n0mzsiQuSp2EGkAONE1rzCfQxfWkY9HxZk05nc2dzUomEuos5LVmbxJp+plVHGYq2UBX/QbiM/PalHntGn4AlTXSrATBayYyYu/+JJ2ktPk6239WXKzpiS/n2eG3KByRqlW8/0FvKMs6P9fvZ/bVmlV8wl8oKTfBXVG4iuXgmC1fkLyikinoPOcuTZ2CsvsU1GsO5Onn+Dn9/s9zdHofbogzo0C066aQYAu+NkQU+rBKU51TFi3GYWjuW4tJSPx52b+rRbVJuK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6453.apcprd03.prod.outlook.com (2603:1096:4:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 14 Sep
 2024 06:03:04 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Sat, 14 Sep 2024
 06:03:03 +0000
Message-ID: <68276e9a-c181-4d8f-bef9-a1746f7927ae@wesion.com>
Date: Sat, 14 Sep 2024 14:02:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/4] wifi: brcmfmac: add flag for random seed during
 firmware download
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com, Ondrej Jirman <megi@xff.cz>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
 <01020191ec87b457-619e709d-46d1-4c57-b3df-d4e6fd13db5d-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <01020191ec87b457-619e709d-46d1-4c57-b3df-d4e6fd13db5d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: cb845650-8fa5-43bd-64ad-08dcd482e4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmNKZXdLWjhUN2hYb2l0WTVBUmZ5NFhydEpLL2hRZ0oxU2hZcDI3UkRmNjdi?=
 =?utf-8?B?SEREYzc3ZFhZS1crV3pwcVozOGplcU5jWGhHRlJISm5pUXNiaFBhSEtRa2VS?=
 =?utf-8?B?U2UrU296SktnWVZHVWl0dHVIZSthZnBncGVxRXVrcngvMFFqanprck8waC82?=
 =?utf-8?B?bUl3TllzbFpHLytFNy9iY2dUMkdVM0s1ZDlWSXBobHo1dVZ4QzlWZ0xTRFpu?=
 =?utf-8?B?eXVFY3FUNWlBZ2tlYm9uSlZSUVh4QmNHRE9JeWlqeUlLTU42WEJIOG5VUzdD?=
 =?utf-8?B?STJwU3VJN3dabU1vTHpTeGNGYk8yMm01bE9NRk9ZM0tJVEo2VFl3OFJEdkI3?=
 =?utf-8?B?VVZ3MURxQmRmejRETTZ2Y0lGN29MQmFlS0ZOc1ZEUGJmQUZSbnlvK0VFM1Ay?=
 =?utf-8?B?b1VDN1J1ZHpZVFk2OWhDTUZrSExkNkpuUm83bktySnpoZVFCb1NubElGckFN?=
 =?utf-8?B?SC91YnIxbDRWNDRPSTVSMUNnQitxK1pGbGViVFBKRTVPdTMyV3lqM2FPeGEy?=
 =?utf-8?B?OXlYeFpkQ3ozR3JqbTJVZHUyR3ZjalpOOFNHSmlOWFNUaXdQb0N0enlSUm53?=
 =?utf-8?B?NHZmeEpVWTdKdVZzUG1kQUpZd1ExR2FucHgxb0tDN0piczV2UGNOeldBc1ZN?=
 =?utf-8?B?QUcxZVNmMGc3V0ZlOWExdDRpNUlMaVVVWHZ1NHUrN25TYTdLa056KzNFVUht?=
 =?utf-8?B?NitPK1Rxa2twSWVLNXV6S2lUMDJRdzkzWFRpNGNCVTVEaHM4NW8rcVg2KytI?=
 =?utf-8?B?bSswSFF3Tnh1dTZtUE4xMjRXZ3FZRXZmZ1VSTkJiaHY1VXlxMDBET0t5MEVH?=
 =?utf-8?B?OEIzendORGpwbGFkclhLSjhhUisyWkwwc3ViODFmZjlXRVJncjFXK2VHUllv?=
 =?utf-8?B?dkRMUFJhUWZHV0ZGTnBBWmI4MS94VFp0SGwrTks4cVRMZW9FMThMcDdNdmhx?=
 =?utf-8?B?blhWR1hEbzhVdTZpd01EYWl2YTJod3hSazd4amdqQVRpT1U1cUMyWG5BSXJv?=
 =?utf-8?B?MmlMQTB2OWVnYi9tU0x1Q0V6NWFGbkg0VEV0aXBDT1FJWmJDQzluQzluNVVJ?=
 =?utf-8?B?VGtpZ1ZNUTIvbWRJelRickluMURLUkdMTjFzaUxGZzJTQWxIMFJGczREbExr?=
 =?utf-8?B?WmFNOUYraW1vbkVlUjRteHl5QWJ1d0E4Rmdjd3JoMEZmR2IyN3poTkNuU2h2?=
 =?utf-8?B?NEZuSkFWWnE3MVFIM0IvaEFCdmttcG5YYkIzTll3akRnTjA2OURkR0FkWldI?=
 =?utf-8?B?UktKc2RHY3k2YzVTNDU2RXRVNlJobm9pVzdDcTNXVE1YMldRamlRbnNDUXZV?=
 =?utf-8?B?V3JwRU5aeW9RYnMzZmdoUG9WMUJJKzhoUzcrNGVkbC9ncHhBd21CVDQzMFhn?=
 =?utf-8?B?UHJSUW9PMnplZVJmTVFubFZFeHJEM0NNUSsrTUF4OGdVSmpReEpjVVFPU25F?=
 =?utf-8?B?SzQ3TjNHMmFFa052VlhqcUFlWVVXYWptWTlrVHlPR2FMVnZNcGhXdS9UdWFM?=
 =?utf-8?B?cE1XamVJK1ZKVm43SHNuLy9KNGt5OE9NaHorZDdobU5WTjZqUUZIWkV6bWdC?=
 =?utf-8?B?cE1aV05XVTFUa2F0UVdKRXZnUGcwdk9TM0pTOFZ6dTF5R1M2QlRXMXdyUVVT?=
 =?utf-8?B?OWFHT2dHaW9oeVJzaTNFWEpnYVdmTnRnUXF5OHdZdnI4alZhS3Z6K0xaUkJx?=
 =?utf-8?B?RkZqaGNMUG0xSFhmQ1E5OTg5eWd2bXNjVGhwMnRjQk5maEEwRDRRY1FPOXZX?=
 =?utf-8?B?YkJUSzV1Nzk3aERKdE56cHBKa2FETURvMTZzU2ZFQ2dwTDlaWU9LRUs2Mk5P?=
 =?utf-8?B?RnJobU9HV3QzcWRBMUFkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRyUThSa1NPaWdVK1VLZXVGSFhLcmdDKzRLODhRVkhMVzZiZEhUU2pxZjdD?=
 =?utf-8?B?amo5bVRvSWdCNU00ZkNidGg4WnYzVlROSVZlMjA4aGRKSm1tNnU2TnhxRGtD?=
 =?utf-8?B?Um5TTFdwSmJPU1h4aTJ0aVV1UUFScC9hbEpWaTNoMzZOL3FJY3F2cGdvMUFG?=
 =?utf-8?B?SGd4K212TVFJS1NLK3krTmdyRThHZW5TSmRNeFNJNmdvSVJESjZjRnJ1NWRH?=
 =?utf-8?B?bnhEaGJaNEpjRjliWDhFWDdTNUdJTzFVZGRnL0pWaUYxOWNkVjRJdzZTZHJy?=
 =?utf-8?B?aUQ1L1JxMytrdUxpbGxSTTBWMEhOQTE4NXU1UklCUnFBb2hrUWgwUnkvVFFv?=
 =?utf-8?B?QTAvVFo4by9wVjRsR0tCb0hjNWdEQ052T29XRHpvMTdabit3WDVETDFnMU1M?=
 =?utf-8?B?dHBreXNMOGhvcWowZmJaL0pIdGVHUk1KU0ZMemY0VWxTQWhid1dEOEZEOUVT?=
 =?utf-8?B?S3I2ZlQ3MWJlVHBLT1VyQUhjVU9Yb2RiYUFKWERzL0taV3BjcU9FUVhvSXpq?=
 =?utf-8?B?ZW1BbDZ0bE95Z2k5ZFlVVU5wWlBUazJIK2FKbENTd0ZZWlVtZGtCZk1WckFT?=
 =?utf-8?B?bnJodTBQaVJPNHNwYUlJYlZvcGJ6dFB0WHh0Y1RMTTg4emxIWCswQlZMMzR4?=
 =?utf-8?B?UjU1NUNRa3FjOTEvOWNtSmZzUCtxSGNvcm0wTkNYVWp6a1ExeG9vM0ZicmlN?=
 =?utf-8?B?anRJckQxYUJEeUdBdS95SVEzK2xYK2htaXdqODZiRGtQTE90ZkpDa0NaMEsz?=
 =?utf-8?B?K2k2czBMNWtlNkFqT1NaR01IMkY4alNuazdTRHNCM0hXbHVtTmNWbitOa2E5?=
 =?utf-8?B?TXZVM2JlWjhPaDVTS2hHVks0TXl2MC9xUXY4THlPQzhBdkNyL2t1bHdKeWtR?=
 =?utf-8?B?eHpicjVqc3JmeUY1Ty9ON2JIbFg0WVgySVdHVnNCV3kzY2grZWdkekxjM0RD?=
 =?utf-8?B?ak1XUWxzM3h1TW5yYTFhTzRSYUZIbFBpRk9USmZlNWlEZ24yNmxnNi9XR1JN?=
 =?utf-8?B?ejJnZmZxY0lQbWY2ZzBMZ3MzOXZFNEQ4WWZlYkVBU0E5NEZ2RFgyOXI4NGFz?=
 =?utf-8?B?YU4vQnJIRzcwUkVEcDNYdjlkMUdKZFFHakZiM09VcEt6MW9ubHJVYXR1MCtI?=
 =?utf-8?B?UjZsanNyVTZhd0d1cG5ONVJEZ2RpYmt6cmowdURzZlRwSCtYRktZNEFESU9q?=
 =?utf-8?B?aUhPUURzdUZBNlZTVDRLV3BPZks2anMzalhKdnRUUjU1LzBNOHgzeWY3UXcv?=
 =?utf-8?B?MGI0V1RTbWdxY1dMZEpKODNyQ3V0N3hVc09HNWxEbnNtSmlicGlDbnhzNzlo?=
 =?utf-8?B?RFdkRkplenRFdkRRa0hsVDFrSkVQQmRuQ3k0Mlg0NVVNeTBSUkRXUWFFNVFJ?=
 =?utf-8?B?VXp2bXJYa09HWi9BOTIvcEJ0OW1FTXRwZ2NBVmgvOEVCMnRpanN0WU54THh3?=
 =?utf-8?B?MENMcUMxWHEraTdBVkVrR2oyVTF6OGJ2U3hJUGQ0a1RLUThUZStvNWUwZWxY?=
 =?utf-8?B?SDg1b3dlbmdVNWxuZVRXc2hqVzl0VVNhZEFQMEhER1VIWG1QTE5IUXE1aDNW?=
 =?utf-8?B?WUhkVkV6NmtqR2tJMmtaK0RhOHhpYWs5VjV6V0VmRmtZaWdBMExIMUgwM2RK?=
 =?utf-8?B?NlJOYVBVeCtRQUFQb05hSWp5UjQyb0FEeUMzVWdqUThLc08rRWJGNElhR09v?=
 =?utf-8?B?K09uVFZuRXc3ZU1IN2drMXQ0NDIxakt5TURxSEw3S2RGSWlnd1NBN20vQU05?=
 =?utf-8?B?QllTNW9VNDNjOUx0L1ZTcXcvUGhUL0F6WDRqZnF0MzhwMXdoKzdlUm00Qi8r?=
 =?utf-8?B?Nmx1ZUtBQVZaa0huMnI0RERpcncvdGhzTTUreVVVLzJTdTVpU1Z1NnJkYndq?=
 =?utf-8?B?TXArUG1hcEtuQSsveGZsSE5vWjIrUWN5NEM1c0VIL0lRUHJpMkUvVzlDOW1P?=
 =?utf-8?B?Q0JRQVRGRWVBblgzUk1ZODIvVE0rbE9CVjc0NHNhSjlZU0FuN3Z6alZKS1VX?=
 =?utf-8?B?c0t2OWFJbFg0djVPNnpzQ3BMSitBQUhnTUhWK00xUmMzdUp4SWJwcnZIakVE?=
 =?utf-8?B?ZkN3YkZTcCtvczJvTWE3ZGdMd1FzeTNvM1lXWnZvSW1uT3lCempJbnh1UzNM?=
 =?utf-8?Q?JJQPMQB3JIX1D7Cok4yFTy8ch?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb845650-8fa5-43bd-64ad-08dcd482e4fe
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 06:03:03.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EsEWcxBWSOsaF7PK9kfoWTrfhAXKRqVtg4CJ0m8izaRPIXkXoXXUsAt/pfo6YhUlrtOZwTNj25ZcakiXDJaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6453



On 2024/9/14 1:56, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 10, 2024 at 11:04:14AM GMT, Jacobe Zang wrote:
>> Providing the random seed to firmware was tied to the fact that the
>> device has a valid OTP, which worked for some Apple chips. However,
>> it turns out the BCM43752 device also needs the random seed in order
>> to get firmware running. Suspect it is simply tied to the firmware
>> branch used for the device. Introducing a mechanism to allow setting
>> it for a device through the device table.
>>
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com> # On RK3588 EVB1
> 

Thanks for all your reviews and tests ;-)

> Greetings,
> 
> -- Sebastian
> 
>>   .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
>>   .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
>>   2 files changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> index 190e8990618c5..c0fdaa4dceda4 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> @@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
>>   BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
>>   BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>>   BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
>> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>>   BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>>   BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>>   BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
>> @@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>>   	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>>   	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>>   	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
>> +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>>   	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
>>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
>>   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
>> @@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
>>   			  u16 value);
>>   	struct brcmf_mp_device *settings;
>>   	struct brcmf_otp_params otp;
>> +	bool fwseed;
>>   #ifdef DEBUG
>>   	u32 console_interval;
>>   	bool console_active;
>> @@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>>   		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
>>   		brcmf_fw_nvram_free(nvram);
>>   
>> -		if (devinfo->otp.valid) {
>> +		if (devinfo->fwseed) {
>>   			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
>>   			struct brcmf_random_seed_footer footer = {
>>   				.length = cpu_to_le32(rand_len),
>>   				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
>>   			};
>>   
>> -			/* Some Apple chips/firmwares expect a buffer of random
>> +			/* Some chips/firmwares expect a buffer of random
>>   			 * data to be present before NVRAM
>>   			 */
>>   			brcmf_dbg(PCIE, "Download random seed\n");
>> @@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
>>   }
>>   #endif
>>   
>> +struct brcmf_pcie_drvdata {
>> +	enum brcmf_fwvendor vendor;
>> +	bool fw_seed;
>> +};
>> +
>> +enum {
>> +	BRCMF_DRVDATA_CYW,
>> +	BRCMF_DRVDATA_BCA,
>> +	BRCMF_DRVDATA_WCC,
>> +	BRCMF_DRVDATA_WCC_SEED,
>> +};
>> +
>> +static const struct brcmf_pcie_drvdata drvdata[] = {
>> +	[BRCMF_DRVDATA_CYW] = {
>> +		.vendor = BRCMF_FWVENDOR_CYW,
>> +		.fw_seed = false,
>> +	},
>> +	[BRCMF_DRVDATA_BCA] = {
>> +		.vendor = BRCMF_FWVENDOR_BCA,
>> +		.fw_seed = false,
>> +	},
>> +	[BRCMF_DRVDATA_WCC] = {
>> +		.vendor = BRCMF_FWVENDOR_WCC,
>> +		.fw_seed = false,
>> +	},
>> +	[BRCMF_DRVDATA_WCC_SEED] = {
>> +		.vendor = BRCMF_FWVENDOR_WCC,
>> +		.fw_seed = true,
>> +	},
>> +};
>> +
>>   /* Forward declaration for pci_match_id() call */
>>   static const struct pci_device_id brcmf_pcie_devid_table[];
>>   
>> @@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	bus->bus_priv.pcie = pcie_bus_dev;
>>   	bus->ops = &brcmf_pcie_bus_ops;
>>   	bus->proto_type = BRCMF_PROTO_MSGBUF;
>> -	bus->fwvid = id->driver_data;
>>   	bus->chip = devinfo->coreid;
>>   	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
>> +	bus->fwvid = drvdata[id->driver_data].vendor;
>> +	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
>>   	dev_set_drvdata(&pdev->dev, bus);
>>   
>>   	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
>> @@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
>>   		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
>>   		PCI_ANY_ID, PCI_ANY_ID, \
>>   		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
>> -		BRCMF_FWVENDOR_ ## fw_vend \
>> +		BRCMF_DRVDATA_ ## fw_vend \
>>   	}
>>   #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
>>   	{ \
>>   		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
>>   		(subvend), (subdev), \
>>   		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
>> -		BRCMF_FWVENDOR_ ## fw_vend \
>> +		BRCMF_DRVDATA_ ## fw_vend \
>>   	}
>>   
>>   static const struct pci_device_id brcmf_pcie_devid_table[] = {
>> @@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
>>   	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
>> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
>> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
>> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
>> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
>> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
>> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
>> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
>>   
>>   	{ /* end: all zeroes */ }
>>   };
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> index 44684bf1b9acc..c1e22c589d85e 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> @@ -52,6 +52,7 @@
>>   #define BRCM_CC_43664_CHIP_ID		43664
>>   #define BRCM_CC_43666_CHIP_ID		43666
>>   #define BRCM_CC_4371_CHIP_ID		0x4371
>> +#define BRCM_CC_43752_CHIP_ID		43752
>>   #define BRCM_CC_4377_CHIP_ID		0x4377
>>   #define BRCM_CC_4378_CHIP_ID		0x4378
>>   #define BRCM_CC_4387_CHIP_ID		0x4387
>> @@ -94,6 +95,7 @@
>>   #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>>   #define BRCM_PCIE_4371_DEVICE_ID	0x440d
>>   #define BRCM_PCIE_43596_DEVICE_ID	0x4415
>> +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
>>   #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>>   #define BRCM_PCIE_4378_DEVICE_ID	0x4425
>>   #define BRCM_PCIE_4387_DEVICE_ID	0x4433
>>
>> -- 
>> 2.34.1
>>
>>

-- 
Best Regards
Jacobe 臧介皓
Amazing Khadas, Always Amazes You


