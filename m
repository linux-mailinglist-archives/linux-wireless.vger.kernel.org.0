Return-Path: <linux-wireless+bounces-25079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BBAFE102
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA29188E598
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30A26CE3F;
	Wed,  9 Jul 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HJdjRIku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012053.outbound.protection.outlook.com [52.103.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DC26CE21
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045104; cv=fail; b=i4dCGXFKfk+Ey76quiMWikQlMKGmJk+7yAsXRteeD+thSrY6Ql04+6M7t2Z1hlYF2UoxPKKqHo3s3B23JCRJiToIYWnUr2tPNQByjZFQ+7We4r7q7Ri/jmIpwVooK4LZLQRdt4gZdlCX5Rj0b2WnBZiqPhcLk/mM3y24LK7SKSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045104; c=relaxed/simple;
	bh=qYoo0GWg41fzDTGSwE7LP0LO1ElYUaO7P5EMT0Wr2R4=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOXDEsVj7XRndmZGv6VYfFWLJq1tXHX5vAjul5eIVImkhTiiOtgXg1aQ3MMA/VQS1irC+D59c6qqZHRHh0Hoxhklz8LXWQnMrfK2BcVmTxRNLXobi6l5fDyYfRZgSewHWJCL/J8uC7Ey7lI3CfOzrusWGF18kKtGPaw+0KqpJlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HJdjRIku; arc=fail smtp.client-ip=52.103.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njmHNNDLrjty6GLP9RCIn2PRJO0Y+0qHH+atYaYSfEZKEk5gQ+hreMr5dFc1IId/333VGhb7/cErkj+DwEwR/Ie/kvbIe9BnGzFufxZqKJlNVrF7YwQc3kMgPBn7yPbMG4prpgjRhEtL3uBxjB1mw8tJf2Ui9xK+p4MKYRaBA6+rNtMqrgZ7ZusZT7kTo+kqbooE1ICTWLoKON1qk6zcTIyt0izMO724KpRAQtbFmWMjZ1Xy8u7QboO4uWmyDEzysKQWxkk/w4TvNcckQ6ddGMdr41Zk+A7piYTl+srSA38+zxZZhcd3idu5+WCtnVeOktzzmjCG/7Nv9ErGWV++jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v00LxDBf7kUw+BU06zlIjLm0NYVv8bUeKMMD5vOBR9M=;
 b=eW9FfIfHYU8v7A/Z3045MXwuwUW1v2RJlQEbYlsdx/a/VrGYbAS1SZz3gcwy+8MTaDkKwg4kDf9qYT/fgMWH5bp3v964cYajCUL3q6P2CxB8PO3xx6s+/d293IQ0zS+7zbRYCFE93LVi387lSvGpVYHGhvUSS5IaFNq0stGUq62K/oSATR7M7cjVXqIrkmbEWu4lVOjo6FuyETHd8E5ldOcySwhOyj++237qhlHbhdM7EtMAPQtIZK6jnB/I7CEqe0yJveXxe3TGnd6emrXH+FO3AVl+kR5iwC4xAySifK/nEaOyccFZMdYmygCfK1UgKEHiZHpPXcI92a8zPARd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v00LxDBf7kUw+BU06zlIjLm0NYVv8bUeKMMD5vOBR9M=;
 b=HJdjRIkuezEnWwZi/+CeD0wseWWbszVnEI8VZgxJx0Sch3oBrBmdsAWet7BXYIQSqz/T6PKLq1qQWkcoMYEkyuvZld9i/jmiKFLrGRtdOCrAqDewQ6K36nz0j3jCaxGECfsV3XQKAltAYpySkncEmaS4D+avzQW1YvqT/dLJA1Xt5W7JiZZ0BliuSPmbP6L5n2VXYLTRPRmUFTXcxgYz/D7Z8l1YBeymuUDqBR78X1OnKJiRty4gTpJNfRGnvaaIjttlURgHSQNKv7N5upayCNEm8W2ueJ19A+WfuwjqyKOLclUJO40E5JQ4WMxkDNO3K+YJi0N3u7KDmtV/TXqTEg==
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7) by KL1PR01MB6014.apcprd01.prod.exchangelabs.com
 (2603:1096:820:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 07:11:39 +0000
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6]) by KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:11:38 +0000
Message-ID:
 <KL1PR01MB53220FA9AF7791C21F2FB4C4B249A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
Date: Wed, 9 Jul 2025 12:41:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional
 Wi-Fi dropouts
From: Ansh Gupta <anshgupta1941@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
 <1293cd1841414523ac2d159e69db482f@realtek.com>
 <3af6b319-9ebc-4d9e-8d94-326329b47268@outlook.com>
Content-Language: en-US
In-Reply-To: <3af6b319-9ebc-4d9e-8d94-326329b47268@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7)
X-Microsoft-Original-Message-ID:
 <0683231f-4209-4500-8dd1-d5e0ceca65e7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5322:EE_|KL1PR01MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5a24ab-bf89-4f02-f781-08ddbeb7d817
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASJcrELKpeRZU+NaeB607qdsL4KJnJxDwQrQakPoFnhyTSQSicQB95yQUEkCf5KK60nXDKGfJa1JeIoUhaY2oX/StjHk5+mFCVUrp9co9ZjMtEGU9T+GPnmyRA1BnPEzsVb/6i+oqp/duFNHeQKRn4jSCII7eqqgTUjissTHyvGMbUQDSqc1eGrsSkoUIioZ9Lpp+3byoGOjt0MJfOKcYypb0EVjXwEXCscnS5JuwbI/slvg6JRMWjW2EL/MHZsgghbwOxUbUb7xTZbpi9SLRi/QFWHLWmFBERaJLMxEIWCnT4b5tFDjeeFD8bLaUpPJ7v5A8+TR5dJWdHCfqH63FfPMFxjY3AeoLkCRZ6WSszCnt0UD8RUx3EGX5iOdmy7TOR2QP10383XSk8S5bEZ/ZX+XWUGtuqqXt1olTW0snGY+awaz1JvfNQPhlXWfTPtRLz/iKl+3+Z25/FElp9uX4BFtlouXY1HVtrR1M144bdlJ0c/AXrzuMZme6fmVtDtRgoUpUEzWAlTfIj/mKYrxahkIZdyEFxDrQ1owK9AOel2Pq8DFCwxf8BgDwqORE7UmicBrOzDziBc8xEKOjJSBg7Po5bi3p8XJoyLYag2Qz+S5rjyTf4sZz/h2eE0BH8imlgEdFYMfR7BHEmBNBXvFXscwcoBu7RUCsIzyVKROiAQLXWGo0e8RgWbMZ44aJAgTMFeZqq8tE5G1Lw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|15080799012|3412199025|40105399003|440099028|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnFjSzBrTWhyNWdCa2JvOUJ5dE9YbXRMV0JjS1Q5bDRJTnd5UlFZR1MxdHov?=
 =?utf-8?B?NVh2dFE2ZlRtWmZJUWk0cHVvdEVhR0cvV1BudXpjbmJtZE1SemZEM1JIc2x3?=
 =?utf-8?B?NVpoNUZjaVA3ZHlUMlBqOWp0ZzdxckdnaS9zSWNUaUJHK3lnZ0ZETkZRbVBp?=
 =?utf-8?B?YnVPTE9tVjlVcnhQdlppQi9ScXZzeWUyTGdwY1E5c2JOTTR5b0p2Qk4rOGhR?=
 =?utf-8?B?L3FMaHhhYWZNV1FqaEVWMjhpMDNZdm5DRng5SEsvYUlxTkRLeWxzYnJmQXZE?=
 =?utf-8?B?M3FyazZmaGVnZ2FzdTYrN0VLejBITVc0cktpYTBlZ0ppWmVBTnQxN0lkczRq?=
 =?utf-8?B?T0x4eGMvQkhjbjU4S3FtemVHa1orRDQ5QXlheDJWOWJVdXNhN2ZBTVJLem9V?=
 =?utf-8?B?R1BNMlhZVmFmM0s4TldidDI5MUhCcGVZckhCcGNVS2NZNnhEeHFISGZWZ0Ro?=
 =?utf-8?B?aGF4UG5rZ3hHcHgyS3VQdzVBRG15OHd2Q0FOTVRadXhKd21lTzJPclFWSERv?=
 =?utf-8?B?Y2xpWHc4L2ZSNXo0dllKLy9PR3BHMmwxak5Md1FKUkRCUXdpS1RkaHZUVFk2?=
 =?utf-8?B?VWtTVjhtU1N6WStHM0NoN0hZcnQrQjZHQUtrVEN3TUlYSG9iai9UZjJINWRu?=
 =?utf-8?B?bmh4alErYzllTjh4c2xRV2dKelF6Q2F2a01vNWljd2NvcVRtajlMd2Q4YXlV?=
 =?utf-8?B?ei8zTDg3bDYvVDlyd1dyUENkaHl6UXZFZmxPR3Z3bkJ3VWYxSVM0Q2N0cURD?=
 =?utf-8?B?ZzdFUm1iZWJjSEFlbmR5SUsvUU52STNZb0U2NFBxNkk2RWZlRmRLQkU3QnZy?=
 =?utf-8?B?djQrOVlkWTNSaVpCRmNOMHJKaWdzemNtOFNuWmp4OHBMWThUUWNKbEJ3dFFv?=
 =?utf-8?B?TkFiV0orWHRHSzNrdHlEUTFQQ0pzeTM2dTJrN3M0TkJNakNYMkNpUWJQcnFU?=
 =?utf-8?B?VmMxelVET3c5bm96MWRBSEV0UnA4YWRDREViZ3BtUWlZWDI5ZGw2VjJhdldh?=
 =?utf-8?B?NTBveU14aG5uVVRYUUk2eXAvR0J2ZlFQVkY0WXcrdnJDL0dybU45SHNXSTNm?=
 =?utf-8?B?RFAwK1NXbXF6eFowc3RnbVNCNDdlMFd4V2MyUjZFVnVUdjFubHloVzNTYTBM?=
 =?utf-8?B?dEdKQ1lQODBYMngrRWJuQ1kwZ1VIbkVXUXloUHFIVGhWVXdGemJqTGp6NmI5?=
 =?utf-8?B?WWxQaDZwc3VHQ1BHbGVmaUVKeStpL1BTYkJjUXdDSWpqdDhZWHNyNWNJaHM1?=
 =?utf-8?B?SUgvUG5teTlMc0FSU1AwaFdhV2R2SXhidHVGQkNlaDlGKzV1V3gvWEJYT1py?=
 =?utf-8?B?ck9YTUFCQ3M4dTM1Zk81YUV0aDh0TUxPVVh0TEZFTXV0MHA0aXBkdjZwVU8v?=
 =?utf-8?B?clg3c09FOWRRQyt1QUpuVDRvcnc1ZURpUU1RWG5DR0xyL2lOYm1BdG5Mbnp5?=
 =?utf-8?B?Q0JYUVlEaCtROWtKSE5DRWJDZXVMZ21CWFZoc2FKZzk2T2N5dXd0SjcwdUdi?=
 =?utf-8?Q?0GVSSCk5e0OljcL1E7yrgXyM5k1?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXZvZjk5UVFYSVhsT3ByUU04QXZKUi82MG9aR2o1clE1bFlxSDFrOUM4MFdX?=
 =?utf-8?B?YXJib3J3Tmg0RjNZTjFtMEVuYTB1NDNnK3JOcVpvZ1U4TkpJRUZJbStKS1d0?=
 =?utf-8?B?TUVVNjROUmpXYWYyWDVjUEQrV3lJL0MvZTZBYkJKM092emhsWlNmazBGVFZw?=
 =?utf-8?B?NDNkaHhrMmtMYkN3SVU2dXoyV0R6VzNpUG5oRTRHc0Fva3gxek9PSHhyN1ls?=
 =?utf-8?B?QTAyVmhXVWlURkdpcWVTVy8xblI3VlBaRkRjNVdWV0pEeXZiRkhIS0oxTWxK?=
 =?utf-8?B?dkF0KzAyU2x3dVZiN0pQVDdmdkxFNVBYK09LTDRiV3MxT1pWMVcwQTYvVE4z?=
 =?utf-8?B?VnIrMVdlYk1MR3l4eHdzSE9MSndEc3cxRWdndWMrVm9HUmwwSTB0MktpeHVW?=
 =?utf-8?B?akNHS3FqbHNnM1Uwa1h0RGlaVlhIeUpqS0FjSHJobEVBaStaZkZZZDZlTGtN?=
 =?utf-8?B?SHJxYmRMSndnQkhGaU9GNTNSSGR4dmQxV3ZYNEc4cWdGcklXeE45NUgzUTZS?=
 =?utf-8?B?Z2ZsaS90bmRYUnFweVFZcWxWeXpZMzVXTFNkaWtmYmIxVnJRZ1ZZM1l0anpL?=
 =?utf-8?B?bWNLUTh4cGYzYzlIUzdaOHc5cjNBTFp4dS9CSlJvclFwcjBGQ2h5OTMxUjhu?=
 =?utf-8?B?eHZxaW04ejNYYkNDNGpmNW5zSzlKbHlyckFhTTcvM1VncmlmaFIrdnNVNUlY?=
 =?utf-8?B?cGxIM2xDeFlFS3dXbklSMnBDR0UycGcxS2tYQmg4L2VrWjlNTTg3V0o5WkFN?=
 =?utf-8?B?dS9uWXViViszQ1RUS1BrOW1Namo2bS9BWG15VVFjcjJQZDlvMnRrOWkzYWVK?=
 =?utf-8?B?TTQ5V2JrcGxabE0vY3RwN25aajVVTHdTcmYzRWdZWUNVZzRmdkNVOGtKSDk1?=
 =?utf-8?B?eHlwdGRFbE93MGYxRzZPcU43clNTT2p4NWRJamgybXYrNTZnV2NqMWxnVnlE?=
 =?utf-8?B?T3g5aGFJMFZrdnBKSVVTVHRCVERNVEN1ZnU2aThHMytnNWVWbGN6b3JIblRk?=
 =?utf-8?B?L0V1WXhORDFDQ0UrTmtUczZrWVo2ZTFlSithU3VTUjZsTGNYZGh1U09SL1kw?=
 =?utf-8?B?Rms3bmFVV1J1NmkzQ0NyaElzLzdQeTZmVnQvYVZURzNSVDNtV3NCRjN5K0xR?=
 =?utf-8?B?R01KYXp2dEtWSkQ0OWRGTDhWSmxKOTRuR01YTVI4U2pLbDVxQnNsb253eFBP?=
 =?utf-8?B?UkRqNkFCL3o2eGpkSmhQNGZKbjFYdW4zOS83M0RNVlRzQ00zVTlRRmdlQ1A5?=
 =?utf-8?B?ZXc1clRscE5CVkpjM2NVZ1pWZGI4cUJaUWlYSzhZV01FUmN2MVgxazdOOFdx?=
 =?utf-8?B?S0xwU2pQd1ZXc0N3azFZeGhjK2lRcHkzK3RCMUNvRHd3WjBzSDgzOFBrMFRT?=
 =?utf-8?B?czVvOVNnRE9YcUl4b0djQmsycHJrZDhjYXArd3NjTWtTWVBQa3B5NWcxYUoz?=
 =?utf-8?B?SjEwdGVIa1VNRE9jWTloYmRSREFsNkhONE1DSExiNzB6TjlET1VLVjFmdG1E?=
 =?utf-8?B?MUV3QXVXcHZzZ05mMm10MUcwdDlmSWlpbzVMZDd2MUFRMGxud09XNTQydUx6?=
 =?utf-8?B?b3R3NjRvQnlwRS9rN3d0UzVEaEJBMTJSYWk3THlldytveTJDQjZqVWt5cTFT?=
 =?utf-8?B?MU5EVDNxRnB4WVlZekVqZndGR2lETGNodmMvVHpaaytUcllBMklLL2hoYzZh?=
 =?utf-8?B?VzhDd0RGMm5pVVRvR2s3dFp4MktGMitVR0Z2aVNXQ0xYWlZwZ2E1WksxcEdn?=
 =?utf-8?Q?z2mm/aOnqEaU+iH7viUgHAZPeLH1lpZXbt4uEHe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5a24ab-bf89-4f02-f781-08ddbeb7d817
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5322.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:11:37.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB6014

Hello,

Were you able to reproduce the problem? Please let me know if you 
require more details.


