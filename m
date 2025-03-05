Return-Path: <linux-wireless+bounces-19803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C9A50275
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FE2160E10
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815724CEF0;
	Wed,  5 Mar 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l2jimK4e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2063.outbound.protection.outlook.com [40.92.107.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF924C668;
	Wed,  5 Mar 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185710; cv=fail; b=qQU02gqzkXFVV8+94Tlp+pyepHjRsDeZXemPwHoUmgIH1N/BIbjQSj59nDutaM+qlcRX7v8+8Sth0l37srkRoTNr2kIBrS063xXOZJr+jQUr0jAuHOLTpJ5kdwOkjTJTum8UJQAVG61ePeynq5RWF9NKgYdjESkoCQ2sTphRo28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185710; c=relaxed/simple;
	bh=ToiTULezg5kE6+h0FouvoSfBnoDIjC1hwCbvas8wPlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SceI7t8wPK5xtFuppN3uDm2MtuyTeKqKikjMSscTpqprRcRcMnqDLr6ec4MRnjupAjPA1EzXUYV+ZAOB8RYsTkm4HVaJC+T2BL3j13R07jhZ3+sfRmsUBqgA1ANTDkzxuQVfqLJidWUfuiGljUEDisS0XDPOaxRNySO9BAyAOZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l2jimK4e; arc=fail smtp.client-ip=40.92.107.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvDcyurluB3hw310+A86NS+2Znx6LsoiHiq90MepAXNbh4knvuE4uEgkX/573P1GfMqgk2+I0IDKXE9j0evkIV/UQVwW29p7L2yJt6GYxfzIkwsF5dBz7O330SD4l+Zlap1aPlzl2je8XcsA1IBT/EmC6Fhzn60sZNuiAYExuaMM+x/WKMbwJdcQ/eyQpLfGgcuqGAMX6VssOJ5/lVEtzRAjwFB8Unm8mItH7td606+I64iN0j0ZpurftDrq0wRwFGjA/WgexfB9FNO1pLXgjGkg02rgUPTIU+50JMYAPeB0/815iF/XvLw1+WnLPIFFoY7rRWjNV025Hl4UoH1Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geTB6TSNPSFi83y59qFFUV1xEhmnYTdDW0V4nYcahjA=;
 b=FohveXYNVAxokMXm017C3X0Xe3VdTCdros8uLGBmxQOMAX1Ih8LrUQydsZwdEDkyss68GvOumSEeEcahfDEaRNU7OQojRE/ikfjP/Op2nldsVz2ztiOnDx5eeMHvAAMI+MUBjDI7vJy+RluEc8Aa3kuFHqo4/cwbNwkNpj4IA49Y7oz92shxAPqvxXtIEApbZQ+uJ/4NAn9+BZcVrEz8KJWwImMMSYYcYx5kIDwDn6dLKflzS36KorwBFBG4AsMLizQVvBW5msGg/Z1GSUhdyi0KVgKz81imlbzhtZyZTCZpuKw5zlooX/RlEhBcuAVkxzJM4JC+iBtrP7xAMNOYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geTB6TSNPSFi83y59qFFUV1xEhmnYTdDW0V4nYcahjA=;
 b=l2jimK4eFG0YyS5U2j+SrH+nxozoPr1t8A9PYmhLox7ukRM6CuQqd6FuQ1I8PLrE+DbIjr7iw9k39PiCiWfqesXliW/G1vwQkYGTNOEO6bCONb1fVWZ07mlHqtGxQ+3pLrO0OuUyWxaaAYE4y5chlg8Cq19zgj9V0elrpCPwIaKIjs8jlOaye5ERvluh8zTEC6YV9cI8DPkl7rvCdGMOKo/ZnLNIw9PrMokE0DW7JfQnV9rNDTna8Z8+ypV3NfYmGFpeECI7x3lEwDo/oVnZDsHZgEaXSwa14P18B/p+kGvdgdo88ivvs8yBVqLop3yx7RPbtrsrdpnPWI1Iauangg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SEZPR01MB6077.apcprd01.prod.exchangelabs.com
 (2603:1096:101:21e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 14:41:44 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:41:44 +0000
Message-ID:
 <TYZPR01MB5556A389846BF8E8A49831CDC9CB2@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Wed, 5 Mar 2025 22:41:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: ath11k: pcic: make memory access more readable
To: Steev Klimaszewski <steev@kali.org>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
 johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <20250304063328.33762-1-steev@kali.org>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <20250304063328.33762-1-steev@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <60652338-4b91-47b0-8f95-fa3f1c042024@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SEZPR01MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd42e7e-8709-41aa-cc92-08dd5bf3d9ba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|13031999003|461199028|15080799006|8060799006|6090799003|19110799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlEcTZrMWV1UTJ1aU5saGFTak9VQXVGUUlrR0xYbzduRWU2V3dRUEZqSEZo?=
 =?utf-8?B?WVMrc0VlengwZG5oYUtSTGZpSVdZbEUrRnIwS3N1MTNVS2h6WUZMbzlRWERX?=
 =?utf-8?B?Uk1QOHYzTHk5aWV5QjlIRXNtOENxL1prVWJKbE4rNDV3ZzlJZXVXRTlqN2g2?=
 =?utf-8?B?REE4ZEhKRkh3MEFCWFVkV1dkd25qZVFJOEJrRE1PbVZUeWdyK3RWb0N1ZVQv?=
 =?utf-8?B?cW5PcGhDTll5WVBxSER1cnFXWVdRQy9Hbmgwd0d5cnNOOWRTTVRhUk56TGlO?=
 =?utf-8?B?WDBXSHJBSmJ4RWdrbUw0anJ1VkN0Z3JUaks5Q1Z5V3puRnVMOE1YZHhNb3Ny?=
 =?utf-8?B?UFkrdVFmbDAyYlMvRzc1Sm5DRVY1UUM5RjYwNlM3RVo4dmI2NmtDU3VqRjZV?=
 =?utf-8?B?cldkaVp1UHNXWm04c0tlOFlEeXdHSjJSbXVseUt4V2tCdElrWnBOSDdDSEIx?=
 =?utf-8?B?QjR3QmpyOTRVSXpESlI3MVR5cHkzMVUvRWhER3BNeWFtSDhLSnExQ0FXbHVQ?=
 =?utf-8?B?UnZSakJlcVU5NTJVczBmV2UyN29lUzJCb1crbUtKc0tqdk9pRmdpSmFaVXBo?=
 =?utf-8?B?TVZ0cmZoOWhxdEE3dVQvNjZnL1l1UTN4RWFJVnZkUytTOEpoTlVlQTZLaHlz?=
 =?utf-8?B?ZzU5R1pkOFdQTHp6Q3B0QjJ6UlZoSHo2REhEcVdWVWRSdVFPSjBneHpRaS9y?=
 =?utf-8?B?akFOdDVlRTYyb0xtS29LTk5VVmZTWnV1Z0pVa0l5N29QZG9hbG9pQTZxWkhk?=
 =?utf-8?B?Ynh2dzhRYVM4Zjd5SHU0Q3ZaS05JZzIrZHYvdmI1U3BFQ2JrbDZETDY4dkNK?=
 =?utf-8?B?cUlNMXY5SmQ1cTNnVDg3OUdYeFpzb1IwRkFSdENYYkJQbE1Pb0k2WWhENWph?=
 =?utf-8?B?MkFIK0QvRUF2YmNUakJFU0c2WW1HVnh1NU5WbnFWbWtrUHZZcW1kUE5mb2Nv?=
 =?utf-8?B?OWVlL1BJTjE1QURCQlBYY0VBUmhCYjZFWG84bkFjZ3RTdkRFOXhwUWprNFNH?=
 =?utf-8?B?KytPdGJLemU3NlhMdi9OYkpxWDFRSzgxU2kvbVlWWDhmckJYZTNCdGRRKzhO?=
 =?utf-8?B?UklSenRPY3NVTXRydUJYaW13ZXdOSGsrNkJDcUVYVnloMzhTSVlEbkF2UHdv?=
 =?utf-8?B?blZnbXRmUktIMkc3YmYxeTlzNCtjcjB3aHNwOExYeHArbVdBeDdXNldTV1RK?=
 =?utf-8?B?cDJxYnd0VHBDb2VKK2YveVU2K2luTzlNaENwNzRXY1h3cTJEbHJlWEt2Q09k?=
 =?utf-8?B?SFg2Z204TC9aS2drRzFObHhUN0ZXUHpISW5SRldURTkyZzFsb0s2OExnOGln?=
 =?utf-8?B?TmtYRGxuMzl1SmYzRGxlMnFaTFcvdTE0U0lYR253WU9UOGVFTS80UlU1MXZ2?=
 =?utf-8?B?enRPL0RmWS9pS1Yvc2wwVGdORXZ6SVVNelB0QVBndGZUZG1SQTgySlh1ZjVp?=
 =?utf-8?B?ZlNvWWxGNHVHd3NvemZhb0l6bUd2VWVaTzIyRm9DOVlhVW1ocHNaeWx6Wkh3?=
 =?utf-8?Q?t0Ltag=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGgzUkMxc2dXZlMvODFxc0RwVkpPUkJaekR4anZINCtlR0hoeFJ4b1JsMTFY?=
 =?utf-8?B?dUViVEhXUnJPZ2Q0TUdDd2loMnVZb3BzeFNMbnRlRUZsc2ZiajUzaTVod2Fa?=
 =?utf-8?B?WFJBNEZFVWFLQmIweDV2WU10ZDdHQ1cxdG9vbjZjODkvYXk2K3Z4UmRHWWdG?=
 =?utf-8?B?bStBZm02QkxmKzJDOGpZZ3hjcm1tbmFHSmxXM1FLOStjcjNvaWhZR2NkTWE2?=
 =?utf-8?B?RzZ1OER0RHhLR0oxSlh3MTZ0a00wTmhNSjFXc20rQ2NyRENjUFREL3Y1TEFV?=
 =?utf-8?B?NTZNV3BpbXBMMnZKY3I4ZHpOK1JQdUNZM0JWUHBIZ2lBMWZZeGNUcHlZT1NY?=
 =?utf-8?B?OU4wNTBRQXdTcmxOUGd3QmZUdVpDend2dHMxR083MTNzbUdIYVVwdkYzS0Jz?=
 =?utf-8?B?OHdjeVVHaWFEVGNTb2J4VkdUck1rZU1sMVRwaW1GTTlpOE4xYjhtWjFYd1B6?=
 =?utf-8?B?c0pPZWJKT2p4UElNRkcybVZpd2VqN0YzRUZQdDAwN2NPZDV4L0wzWURJTlNO?=
 =?utf-8?B?OHlpdERFL2FqOWVnTFNVWXNEclRuelRlRTVjMWVzb0ZCTnVJUUhYc1llQ2Ux?=
 =?utf-8?B?V0JJVVFoOVEzUkZJUFliOGpLbHRIcnJiVW5vWmVKM0lqS2h1MTI0VEZxMG83?=
 =?utf-8?B?ZEJoVndlbXQxNVJIdFJkY3Zjb2xpME1jODlUa1c0VGFMSHFxbzh6WmVPYkNF?=
 =?utf-8?B?TDI0Smx3Smd2NG5wTGRFbUZYOHhWVlNqVUd4eHJhbEtoSmYrV3BXOXBXY2dY?=
 =?utf-8?B?THBKYkoxTDRhTjZqa1JpdklUaUt5TGZEZnRJbG9zcVA1RFdveTZlbXpZNUpH?=
 =?utf-8?B?MjNiQ3VhaWhOcVFUWk5JVHpKZWs4UERpOTkxRHBKZ0JEVGMzNVRmLzc5UjJQ?=
 =?utf-8?B?MDFTdk82b0dUTGN6bUtzcnVNVjVqUmJ0SzFpeXJKN2VPT3FRcFk0Ly9KQWYx?=
 =?utf-8?B?WDN4MmVBV0JNQW1GNUN2Y1RlMmtmclNETktxak9FK01pZG1RWEJ2alFHVUpm?=
 =?utf-8?B?L3BNbXBocUVLUWNwUWdRNUFZUWVscFNhYWVZeWhrN2dvVjVseHh0bU45SStu?=
 =?utf-8?B?NUJZYzRybGt3Uk1LQkJRbXU4VTJUTmQ0d2FXQ0pYU0k5NGc2RitOdEhaWWw3?=
 =?utf-8?B?U2F0UVFQSkFDN2poLzRvNzJrOTd6bjZhNndsQjBjbVNFRGh4ZEp0aGs1RURM?=
 =?utf-8?B?c3pOZ3c4SS81STBwOW96eWcvSFUvUkFYK1hJUlZtRVJraTdPWktteGxSa2lP?=
 =?utf-8?B?YVlycExQaEprcHZhZDVmaTNEZmQ4WGluakI5cTRQZjJlSFB6STJsMlc4bXpp?=
 =?utf-8?B?RnNPWGR0WXltb0JaVFpIRlgyMmlvZHB5eUpFWDdWUzZZdzFLb0VMR09MTmFH?=
 =?utf-8?B?eDd1cGZmUVVJYnRWWjhsV21VOU1WdStoQklUM0lRT0UwZXZXdkEyY1JkZzV0?=
 =?utf-8?B?SjlRYWdDWTRpMjAxVllkdXo2UGRnRmpwN1l0Y2ZURE1iOEhzb0tOSnhCdUV4?=
 =?utf-8?B?S2k1QmxqdndzaFJKcWxmaGpVbytzNmJBUXo0aUtoejk3RzBqUlUySHJlRFpx?=
 =?utf-8?B?MGhHVGlHbVFEZTZOWFJvTithMHhiMEdvNjVpRGcwNmViWFNKWUpIUGZFUXJU?=
 =?utf-8?Q?ayUFLAV9KUlRO7R1e0rLDS9jKHvx/WgiwJlImdbzaWD0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd42e7e-8709-41aa-cc92-08dd5bf3d9ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:41:44.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6077

在 2025/3/4 14:33, Steev Klimaszewski 写道:
> Hi Ziyang,
> 
> With this patch applied, on the Thinkpad X13s which has an ath11k, I am seeing
> the following:
> 
>   ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0210
>   ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>   ath11k_pci 0006:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>   ath11k_pci 0006:01:00.0: ignore reset dev flags 0xc800
>   ath11k_pci 0006:01:00.0: failed to receive control response completion, polling..
>   ath11k_pci 0006:01:00.0: ctl_resp never came in (-110)
>   ath11k_pci 0006:01:00.0: failed to connect to HTC: -110
>   ath11k_pci 0006:01:00.0: failed to start core: -110
>   failed to send QMI message
>   ath11k_pci 0006:01:00.0: failed to send wlan mode request (mode 4): -5
>   ath11k_pci 0006:01:00.0: qmi failed to send wlan mode off: -5
> 
> I'm pretty sure this isn't supposed to happen?
> 
> --steev

Oh, give me some time to check what happen.

