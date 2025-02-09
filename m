Return-Path: <linux-wireless+bounces-18660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40677A2DB89
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C297A163A6F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4A8F66;
	Sun,  9 Feb 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nccD+Eet"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010014.outbound.protection.outlook.com [52.103.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E284C2FB
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088176; cv=fail; b=mIH5xRF9BD79WWtkOsCDGI/sSWKB1ITPNOczU7B5CgGS/4F4ZaBGUXKgHDaJMf1gVwQVGrnIfxrSm+6uEcDY95SG1jW9f8HnZSw28eyI+wbpqFL4/BfNmNXCdUgwvcv629rk6AWdSu6sFMoHuMmQyn5Ag3pUS7DfwfdhSyaDVaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088176; c=relaxed/simple;
	bh=4T4KAfTLqbAa/3amKB6VNxWmjS0cL50ncaxx3ckR5z0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gX26zBOfaeGq/RcTwJahNWTt3spI3Ra4q9Jr46poY9C3QynKLrmr6Jh9zwEmL8MEc6t8Fu7pgKD47YGenDFnmbsEefMBb3mPhgU9+UAmFU+luSGvbOTna4YYLx7yKdX9W9/mcZic3OVzbI1sYY5Y9BC/AD+l6Dvu2CIlwEbQtDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nccD+Eet; arc=fail smtp.client-ip=52.103.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4lPHGNGvPLnutpuiSNrRgu02DeLCLlvrgmSwU7BdOWbsK9RDw8gTDJ6Tnitj9NPWnafEgT3FVlgJzJJThE982BOhbncUalmU2ku1wnVNJS03bY1GOi1pSFIfye2CSQXSouq1NamywitioHQCJpRnIRUUhxfsSY5DjEou2BmUPVwbwksuAtfDKQwnitYZVUDtsxn5Uf30HyJkebIapCXmMXl9wCbxROgxONqQK2vYdVte0nnmQGhL9lYmDwyKijIlgCUlcAwq5l/TBjW1zOgD74pzcxIS+UY9dXDSQr/FQ0daXDbG9hXeKbznziOfNIIlFXiVK0o08Wlpd/NtCOZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T4KAfTLqbAa/3amKB6VNxWmjS0cL50ncaxx3ckR5z0=;
 b=xZP8nsKQi57EW+VqQDhnF+pxThLmNGzmLqOqJdLB5hEa7laG571Qy7pS6t8hlj3IrAvn7tWEOgDl4T6fQsGMugPiihnQDB8WbjL1R2D5Hhf8R0C2KgqLB5uep8Ppgxo+mkZ5UUvsyMMzzkBD051JYGP35TKzpD42IsC8koklpcmZmxD0WgwJO7RUK27B8Q4ZsqTI+S4fMzR1oC/yCxz8zxakFaGKrjetqCg+b1q/iHCpAcfNj6GEh/f/2/xmZY70rNmeM3Z/kx0dZr9wCdnHDw8fq2cZ6fBmU3jthOAX7lqj4mnqNDTnMJLRieGGiwEd8q6AsbTxqDw99oA1C0VD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T4KAfTLqbAa/3amKB6VNxWmjS0cL50ncaxx3ckR5z0=;
 b=nccD+EetosrTbolBFu0Pi1G9QLVsAiRyHfFeioVBIO1R8qRfrhIJjhJsCJ0+tZD0JnVMcKBsq5StCtpHpIXr2Q6dM/va8fuyeX3GoPnkJgd0nQarLxxqFe7zpzF8Us6ftVAPIGazsCqzh6UGZVSHJZktJmRJrz0+sHPNioaRbyS9WbhrLftSKkyb4zIDmnI6jbRoP32FIfc0YGVvLMmAyeZ0phpj3xQpbw1vAb6icKAsZWbU6rwiQXm8YRe0qZ9Zr67NCL+aUQm3TA+1A5X+2G/MI37XjyWFHOkWQTnBNN8UKh4c/8S5Ic2zaKmo+QpVX+lS8rg/ZglO8HbhvX5m9g==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYYPR01MB12470.jpnprd01.prod.outlook.com (2603:1096:405:197::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 08:02:51 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 08:02:51 +0000
Message-ID:
 <TYCPR01MB84371970CCFFCB213AEB962098F32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sun, 9 Feb 2025 16:02:41 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 4/4] wifi: mt76: mt7915: cleanup mt7915_get_power_bound
To: Razvan Grigore <razvan.grigore@vampirebyte.ro>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
References: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
 <20250209011856.6726-5-razvan.grigore@vampirebyte.ro>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20250209011856.6726-5-razvan.grigore@vampirebyte.ro>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FrgAHl0IrsxffDY2F93I3HdD"
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <a7c01940-bfcc-4d97-bae3-5ca416f9ac27@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYYPR01MB12470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2302e016-4b03-4287-64be-08dd48e0254e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|8022599003|19110799003|6092099012|12121999004|15080799006|5072599009|7092599003|3412199025|13095399003|440099028|41001999003|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBKRjR5MzNNNUhqRm1TREFOK2JidlRYRDVNb1YyNHQrMXdEU0RQajlLS2FL?=
 =?utf-8?B?YVl2UnRMRzdSNVhiY0VmNnFGMUtCeDk2YkVMcTFXZ2ZIRWZHdElXVG5RY3VL?=
 =?utf-8?B?RzhUTm95Qjhza0ltaTgvOGhBbXpLVDVaMy9MT3Jsd3pVUDNmcld0RUxNUG16?=
 =?utf-8?B?SC94SjNKTC9zRHFVVmpHOFFPL291K1RoQTc1ZnJ3RWV2Z1lWbVhObGVKakZ1?=
 =?utf-8?B?bVhTL2hCcWM2UjBuc242MFBDS0NWU0R6UVpLelJ1UFRncXNTdmk5Z3J0QUhm?=
 =?utf-8?B?bWdpM09vdkFFK2FEU2VaODN6Z3lMc2hWWmppV3RKVy95QXptQkZnM2RJeHRX?=
 =?utf-8?B?eWN4c3dJb1lJZ0I4NjZ5dnlpYnFlWE11ak5WaWxGL3VlaDdtaURDQ3lyQ3lk?=
 =?utf-8?B?Sk9kNUw5MUc5RGZTUlo1bzJjYVUvMjJRRjBSNEFTc3psSEpXSjcyYkpybDk1?=
 =?utf-8?B?Qlk3elcyV3o2cTFWR3hsQStqS09RU1ZRR3FpTUZuMzZxOG1HNVJGUHB0a2ZG?=
 =?utf-8?B?elo4c1ZtRThYc0RiSEU4NjduWW9FeCt1RmVPUTEzVjlKWGRaQ05IbmVIQXVp?=
 =?utf-8?B?VW0zRGwzN0VpVzFJMjlIRkNnTG1xdEtER0VnZ2s2NnBoWnI4ZXBRaFpIdjAr?=
 =?utf-8?B?YjVQWW5kMjNhSlRKczFBWmtVSGdERlFaTHpDTEF2ell0K1NDTmtIVTlRR1dP?=
 =?utf-8?B?cjRhdjB2N3loM0ltbHI4SUc5SGZTYWIzVFo5b0RrU011L2Z4K3c1eEFBaksw?=
 =?utf-8?B?WUpucVF6a2hkY1hVUlR6dGFqZVdvVm9DcVh3V1dvY2JIWTlqT0dJR2xMVlhG?=
 =?utf-8?B?K1dhaTNKaTZRS0x3dTkvSSt6THlJZEhwd25jcHR4Z2dtdFZjSVh1aFlXekcr?=
 =?utf-8?B?VkxGOTZ1ckd6UWk4ZWdUZGpWSHRDV25rM0w1ODVVYWtObkVLUW9QekE1eWU2?=
 =?utf-8?B?L1dWQTEzY1IrRyt5cVZ1THFVZ3AzWjVLSmk2YzAvY0NyRnM2VlBNdEhTSzhP?=
 =?utf-8?B?d0doeGQ1L3ZXWStHRm5EY2xnQm8xMUlVRlFzcy9TUDI0MjlEYk41N3VUSmVZ?=
 =?utf-8?B?SDhiUXVRWStDK0d4TXgwVTdpZnlHVDNDWkNLQlQxVm1FZmJ5L3dkQTVhdmpi?=
 =?utf-8?B?bXUzRWNyMEx6OGVDNGhPYVBjMGFBSnhPREMyVjFVL25Bd2VoeGhoNkl0Q0ov?=
 =?utf-8?B?TzVjbmpKWGp0Z2xwU0c2WjFZK2huWDlDVnNoVEhDY2lwZ2dVY2c2aFpyL3BX?=
 =?utf-8?B?TWwxKzdIWFAzVVRMaFE5U2E1QUV1ZmRpcE5lZ0JRTmdmOEVRbmdMMXRaakRq?=
 =?utf-8?B?ZG1lbVRBWHVEclA0MVBldC9zNm1wYVZJMkhOWHVlNDZzYVE3RkV4QTdNOE0v?=
 =?utf-8?B?QjVSY1pMQStoamFoMnlJMWhHQXJPWldmZGE5REpGWURKeEVnQkZLMlJ6Ymhn?=
 =?utf-8?B?c0lCM09tZ3NrWDEwc1E1eHRrTk5OQ0NYVTl4VjMyL1F5N2YyTzVReTU4cDRQ?=
 =?utf-8?B?QWtrV2JYQVRHRmcwSVBodHgvVjNiK0xMTFJpd1Z0Rm1lMXl2SDdtTmhxNU9q?=
 =?utf-8?B?WUdTbGhZK25tdnFaSUJYUFFOMFNLdytXQ0lGNjltL0QzYXErVk9MUEdoVGgw?=
 =?utf-8?B?Q3VvQmQ1Vll5QTc1OFJlYlNnSzh6dkNYTTlLMWpsNjB1L3Rtc1A1VXVzbE8r?=
 =?utf-8?B?WWp1TVluN0JSWWVmTXBFa0dyRndJelRldmFhdWlEQmMyS1dIYkZ0RUpNUUpU?=
 =?utf-8?Q?zRT+DgCE1lodF050UA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXVjNDFmTW9zV0gxRkVsNWZsUVZCUFBRazhWM3hsbU0ybmxsMWRsUFgzSnRQ?=
 =?utf-8?B?TkplWXhyZTRSQmk1ekJKNTFuZ2RiWklXUDFFKytOZHFiRjhWSURoTHJwN2o3?=
 =?utf-8?B?OEpwdnQvbDZaQzcveXJzdURDMEwrb21kK2dyTm1WalBIVFhieklzeTNDaXFZ?=
 =?utf-8?B?Q0lkY21zcG1ZTG9wcXVXbXAwYXk4UjNNNG9odzNXY0NGc0loVzJvejJqTmY3?=
 =?utf-8?B?STQvYVJtdUwzdXFwb09INUlSa3lIekJnbmh1dWRLZGoreVlDMFp4SjVQSDlV?=
 =?utf-8?B?V2hKK0RBWTA5UXB6QlVUQ2hpQlFJVmVwd294YWFEbEFaUzhHNVduZ25qRitL?=
 =?utf-8?B?eVVuNjlMaXg0SVJ1Y0FVaU9QVVBDc1lpU2tITjNja2ErL3JOSlo2YktpZjBJ?=
 =?utf-8?B?Z0dSZVFWQzM5dlZXT1pWR1FMZktXZUZLa2NBZVRWYTgyMGtpb2k1RUpXNnRy?=
 =?utf-8?B?UHhKaURNOGJPaXp1anplcmFwZ2VrY1Bibk9xSFRMSWlXZzF0U0JQWFdmdjdL?=
 =?utf-8?B?azZKM0xUdCtBTWhVL3E5Zk8zZ1lXR0VtL1RsZlhxMzdNbFpKNlpWaVJVNG41?=
 =?utf-8?B?eFo3TlV3UnNFSEdkUHhQSFBPR3FEWkZVYzZscnpZMzViSGtnaU15QlZJa3hi?=
 =?utf-8?B?endwdU12K2ljV1Z0OXVGeWtMK3B3M0l4YkNXTlRpT3NCU0RzYmtlVk9kb3RM?=
 =?utf-8?B?by91TkFKS203c3JrSDBaMmRxSVpxN3AzdFhyMzAzNnlydVlkaG9hWXpRS29y?=
 =?utf-8?B?SUNFZkNnc05rUTh3dDBnQUduVko1SHV4RGxUMXJZb0NTd0ZmcHIwc3NiUjVl?=
 =?utf-8?B?NXpIUjlMTHJSN3hoWjFOV0I4NXFzNndua1crU3VOQ1krY3MvWFE0MkZWQ0FN?=
 =?utf-8?B?Z0ZvdkhiRG5kNzVpY3grcXFXTWs0K0FpMkw2a2xoMTNucTF1aUVSTmliZ01Z?=
 =?utf-8?B?ZHVrYkg1bGRnZU13MDkzWGJEcUpGNXVsOWVYelJlMjk5eUlFVElLc3NYQmN3?=
 =?utf-8?B?VWt0RjZ5M2oxNm9kSGt6dUhzK2IrT0V2V2lmanN6NEVreGp1cDhieFJoOTkv?=
 =?utf-8?B?Y0ZQNWJuVmpsUGV0Z1RCS1l6OUNYQ1JGRysrSHhBSUl0eCtVTzVNSWJ4V01s?=
 =?utf-8?B?SFE1UmZEbDRTbkVabHp4VkNpdUpnSG90TUFxQ1l0TmtiY0hTRnIrLzRKQnhx?=
 =?utf-8?B?ajh5cGt6SC9xUDdyL3lWZzgxaVlBOU5KUmhUZ0VTcXBGcEMrZENaZTdkKzJp?=
 =?utf-8?B?d3hBNDhRMlJ3R2tRemFQUDZFdm1nNWN0L1ljQ1ZjbUxicFlydjdFTGNNMXVV?=
 =?utf-8?B?YTFpOVQvUmdxWFoyZGg0RThVZ3hsSHZ0UlJCb0pXclJYT1hIUnJwTXc4N0t4?=
 =?utf-8?B?UmpXNlFLeFNCazRINzhwTGQzLzBWSzRHWVVIWkkvc3lkL20vL21XZGNSUGMr?=
 =?utf-8?B?MzBvUU1zTjVxVzZBK1RHTnJiczZWRXpZaE5jR2FFd20yNk5yQzEzT0t5aHNh?=
 =?utf-8?B?aXZwbE83SU5GeTFLNTdtbDFMeUg3ckNkS2pWb2pFQmE2TTJGd2VZZlJGRll2?=
 =?utf-8?B?R3BJUWdhbHJia3FPbVQwSVByR0cxYVZHY1FJOHBFbGN6ZVRhb0VLT29xTHY4?=
 =?utf-8?B?OWNqa2Y4WDRyTGZwTlJoclF0a0Z1dS9QQXA5SVpFTGtJZmZKRllPZjFsN2xT?=
 =?utf-8?B?TXZHZll2Q0Y4Z3hFSk5tWm92RVFKcmp4eXRwdno1WHNqQ3Z3ZmdEQ1pQZUk3?=
 =?utf-8?Q?Ij76ifwTvzYrJopm4c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2302e016-4b03-4287-64be-08dd48e0254e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 08:02:51.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12470

--------------FrgAHl0IrsxffDY2F93I3HdD
Content-Type: multipart/mixed; boundary="------------fZPUJXFGH5qKhQORoIGtFkzU";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Razvan Grigore <razvan.grigore@vampirebyte.ro>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc: wiagn233@outlook.com, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
Message-ID: <a7c01940-bfcc-4d97-bae3-5ca416f9ac27@outlook.com>
Subject: Re: [PATCH 4/4] wifi: mt76: mt7915: cleanup mt7915_get_power_bound
References: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
 <20250209011856.6726-5-razvan.grigore@vampirebyte.ro>
In-Reply-To: <20250209011856.6726-5-razvan.grigore@vampirebyte.ro>

--------------fZPUJXFGH5qKhQORoIGtFkzU
Content-Type: multipart/mixed; boundary="------------7o6HEAanxT4xN3h0ib5p0CsB"

--------------7o6HEAanxT4xN3h0ib5p0CsB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lIGZvciBNVDc5OTY/DQoNCkJl
c3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjUvMi85IDk6MTgsIFJhenZhbiBHcmln
b3JlIOWGmemBkzoNCj4gUmVmYWN0b3IgZm9yIG1ha2luZyB1c2Ugb2YgbXQ3Nl9nZXRfcG93
ZXJfYm91bmQgaW5zdGVhZCBvZiB0aGUgc3BlY2lmaWMgbXQ3OTE1X2dldF9wb3dlcl9ib3Vu
ZCwgc2luY2Ugd2UgbmVlZCB0aGlzIGZvciBvdGhlciBjaGlwc2V0cyBhcyB3ZWxsIHdoZW4g
Y2FsY3VsYXRpbmcgdHhwb3dlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmF6dmFuIEdyaWdv
cmUgPHJhenZhbi5ncmlnb3JlQHZhbXBpcmVieXRlLnJvPg0KPiAtLS0NCj4gICBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMgfCAgOCArKysr
LS0tLQ0KPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5jICAgICB8ICA0ICsrLS0NCj4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuaCAgICAgfCAxMiAtLS0tLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZGVidWdm
cy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZGVidWdm
cy5jDQo+IGluZGV4IDU3ODAxMzg4NGU0My4uZGI4NTYwZjdlNjU3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZGVi
dWdmcy5jDQo+IEBAIC0xMDg0LDEzICsxMDg0LDEzIEBAIG10NzkxNV9yYXRlX3R4cG93ZXJf
c2V0KHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWYsDQo+
ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gICANCj4gICAJaWYgKHB3cjE2MCkNCj4gLQkJcHdy
MTYwID0gbXQ3OTE1X2dldF9wb3dlcl9ib3VuZChwaHksIHB3cjE2MCk7DQo+ICsJCXB3cjE2
MCA9IG10NzZfZ2V0X3Bvd2VyX2JvdW5kKG1waHksIHB3cjE2MCk7DQo+ICAgCWlmIChwd3I4
MCkNCj4gLQkJcHdyODAgPSBtdDc5MTVfZ2V0X3Bvd2VyX2JvdW5kKHBoeSwgcHdyODApOw0K
PiArCQlwd3I4MCA9IG10NzZfZ2V0X3Bvd2VyX2JvdW5kKG1waHksIHB3cjgwKTsNCj4gICAJ
aWYgKHB3cjQwKQ0KPiAtCQlwd3I0MCA9IG10NzkxNV9nZXRfcG93ZXJfYm91bmQocGh5LCBw
d3I0MCk7DQo+ICsJCXB3cjQwID0gbXQ3Nl9nZXRfcG93ZXJfYm91bmQobXBoeSwgcHdyNDAp
Ow0KPiAgIAlpZiAocHdyMjApDQo+IC0JCXB3cjIwID0gbXQ3OTE1X2dldF9wb3dlcl9ib3Vu
ZChwaHksIHB3cjIwKTsNCj4gKwkJcHdyMjAgPSBtdDc2X2dldF9wb3dlcl9ib3VuZChtcGh5
LCBwd3IyMCk7DQo+ICAgDQo+ICAgCWlmIChwd3IxNjAgPCAwIHx8IHB3cjgwIDwgMCB8fCBw
d3I0MCA8IDAgfHwgcHdyMjAgPCAwKQ0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3Uu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQo+
IGluZGV4IDlkNzkwZjIzNGU4Mi4uMzY0M2M3MmJiNjhkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KPiBAQCAt
MzMyMyw3ICszMzIzLDcgQEAgaW50IG10NzkxNV9tY3Vfc2V0X3R4cG93ZXJfZnJhbWUoc3Ry
dWN0IG10NzkxNV9waHkgKnBoeSwNCj4gICAJaWYgKHJldCkNCj4gICAJCXJldHVybiByZXQ7
DQo+ICAgDQo+IC0JdHhwb3dlciA9IG10NzkxNV9nZXRfcG93ZXJfYm91bmQocGh5LCB0eHBv
d2VyKTsNCj4gKwl0eHBvd2VyID0gbXQ3Nl9nZXRfcG93ZXJfYm91bmQobXBoeSwgdHhwb3dl
cik7DQo+ICAgCWlmICh0eHBvd2VyID4gbXBoeS0+dHhwb3dlcl9jdXIgfHwgdHhwb3dlciA8
IDApDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gICANCj4gQEAgLTMzNzMsNyArMzM3Myw3
IEBAIGludCBtdDc5MTVfbWN1X3NldF90eHBvd2VyX3NrdShzdHJ1Y3QgbXQ3OTE1X3BoeSAq
cGh5KQ0KPiAgIAlpbnQgaSwgaWR4Ow0KPiAgIAlpbnQgdHhfcG93ZXI7DQo+ICAgDQo+IC0J
dHhfcG93ZXIgPSBtdDc5MTVfZ2V0X3Bvd2VyX2JvdW5kKHBoeSwgaHctPmNvbmYucG93ZXJf
bGV2ZWwpOw0KPiArCXR4X3Bvd2VyID0gbXQ3Nl9nZXRfcG93ZXJfYm91bmQobXBoeSwgaHct
PmNvbmYucG93ZXJfbGV2ZWwpOw0KPiAgIAl0eF9wb3dlciA9IG10NzZfZ2V0X3JhdGVfcG93
ZXJfbGltaXRzKG1waHksIG1waHktPmNoYW5kZWYuY2hhbiwNCj4gICAJCQkJCSAgICAgICZs
aW1pdHNfYXJyYXksIHR4X3Bvd2VyKTsNCj4gICAJbXBoeS0+dHhwb3dlcl9jdXIgPSB0eF9w
b3dlcjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvbWN1LmgNCj4gaW5kZXggNDk0NzZhNDE4MmZkLi4wOTJlZDUwNGE4ZjIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5oDQo+IEBAIC01MTUsMTYgKzUxNSw0IEBAIGVudW0gew0KPiAgIAkJCQkJIHNpemVv
ZihzdHJ1Y3QgYnNzX2luZm9fYm1jX3JhdGUpICtcDQo+ICAgCQkJCQkgc2l6ZW9mKHN0cnVj
dCBic3NfaW5mb19leHRfYnNzKSkNCj4gICANCj4gLXN0YXRpYyBpbmxpbmUgczgNCj4gLW10
NzkxNV9nZXRfcG93ZXJfYm91bmQoc3RydWN0IG10NzkxNV9waHkgKnBoeSwgczggdHhwb3dl
cikNCj4gLXsNCj4gLQlzdHJ1Y3QgbXQ3Nl9waHkgKm1waHkgPSBwaHktPm10NzY7DQo+IC0J
aW50IG5fY2hhaW5zID0gaHdlaWdodDE2KG1waHktPmNoYWlubWFzayk7DQo+IC0NCj4gLQl0
eHBvd2VyID0gbXQ3Nl9nZXRfc2FyX3Bvd2VyKG1waHksIG1waHktPmNoYW5kZWYuY2hhbiwg
dHhwb3dlciAqIDIpOw0KPiAtCXR4cG93ZXIgLT0gbXQ3Nl90eF9wb3dlcl9uc3NfZGVsdGEo
bl9jaGFpbnMpOw0KPiAtDQo+IC0JcmV0dXJuIHR4cG93ZXI7DQo+IC19DQo+IC0NCj4gICAj
ZW5kaWYNCg0K
--------------7o6HEAanxT4xN3h0ib5p0CsB
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------7o6HEAanxT4xN3h0ib5p0CsB--

--------------fZPUJXFGH5qKhQORoIGtFkzU--

--------------FrgAHl0IrsxffDY2F93I3HdD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmeoYSIFAwAAAAAACgkQX75KBAfJsRk5
9BAAkOMHdU/RhfCq/H8Lnh7pIc+qyjx1hfNJQmUipIoxCzqoZPk7W//nkmjBOfEC9LvT5WMdIExW
IQ6GxjGBRMFzrgK1xnojagTftH0fyDEPY7pb3DGX2SDBwn5hweshP4n1i1ujYr0IIxnhzJ0+SbS6
R5xIyFXXahwgt5Ohx7NCDhArXrsqVsSqIEa+UsEFEDCLEEe20YtZN/cLH25fXIvu46tWwZ8OYXq9
FgRdhzE377SgqPFPPgdUgustrVPchKdeglgEJnJTEDLcdpSsTZZsE00++AnpIVGvuibWel6KIEXN
X/4+whIVaTX8bLIN0UfYzrfU/4MGeO47THTYJJtWHQbCcYcKdCVZUYi2fRMu5IMKJapzKd89apBU
ekRBMemqwEjXDhfBG7aiQkomg3gs2K5TP1musMLmUG3DcKDS1BGtJTY56U+VSnEg68zJT+7Fa2ct
CRIomivBGmUWIoFWG3lJhbdIc0SMqAVhgEsM/dFqldwHjF41OQZ+EY5VPkG+Pe9zrXjGavulMKvT
utWdjxymACQFF6SkDJCS31JpZatYVJ1/YXmeE4H35z+435W8bFDkBmIn88x7XHIh12684gEB5BPx
2NausfNMh2poqo8I5nqbW1k2S/ud594Lh5U+wbog3CrwtEpTmnfgaMKRyX+kuv9IQcAt2XZKpq9M
+JY=
=ddgD
-----END PGP SIGNATURE-----

--------------FrgAHl0IrsxffDY2F93I3HdD--

