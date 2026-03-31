Return-Path: <linux-wireless+bounces-34242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ6pKeclzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:52:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB220370DC6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DE22300C398
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD63A8FE1;
	Tue, 31 Mar 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="kVQWDQ6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011033.outbound.protection.outlook.com [52.103.34.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C342371D04
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986722; cv=fail; b=u4/3jt+1+vk0oZ7hliKa50OUemBoPWjcUZv7M12l4a2R6BxB8MlQmKsoyFvCEpsag8EOgeSl8LFkkijCFFQz4Tj1vurbMuNxg9M2EwEClx1t0T6T3b6YswQvp6f25RdLJGsmKsUHsLacbIYv8vJO3LW1n4x+BX8pwjo8ytQXHWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986722; c=relaxed/simple;
	bh=AgumjggX3ipfUlZZmz2sCFEJCx/zr7XMPrWiBxJkf1A=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=rXTeCHkzCDyNNDfxfv189G6Bdb91k1oflej64khxDI7AU5M3c2JqNyk1VM+oYB8NM/a3aizLF+4udV5V0aHRsaecZyOQP0hRMroU3SBQB9cHZQgzKtI1r8rFAoFfw6cO1wZM7+/PG/O37a2RnccWEN3ufHb4GsJSh+9vygbR0iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=kVQWDQ6Z; arc=fail smtp.client-ip=52.103.34.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpdLevvUWSPz2tTl1TNmxLllSsrfgA8hirdqGQtcICl5yToA7oLS9MPxNhAXc8qL6L/ATBXMzuOt47dcJMpg/9Nm8PTztGTX2unpTc4GgNgxSsMmeqokRILA4qx0QkTBz8tVoycaYERA0A4cHj2is0rx2PgWfPTauo2PFuKufPsSB96nSk4sHv4kMKSYKY3FtSPaJKm4ZOLj9FgI37K0RR9wkT6cIcmf2/56OroXvxKA4CxkWIC6P9VqRjhjrm+1/qtfx0BaVIe1yBkJxzpagYLMwWFI8RKiHHH3O912yg9fZFbIFrwpYLHmBkPKgOSESapGBH6pZvbEZui+ML0jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZuDuya4m+HK7gUTHSoqTT+tbTD764Tdms5s0nWWtIc=;
 b=cblPHwEtjwqNIBYVf2q5PJ4j35QhYAhLBiqeI6GN2+BtX0/4H3D/LC7DuJ2QKTkx32OxNe1WDYs7HXSKSinSpAIpz3LwRdWvPnRdAxUb9953CkvJ14ruzZnlm39v7UhOK8Bs6MPz5Dme04ojCfRgCZj+6A2bpJhLV//LbJBnYTnyRhC7AU0FYhaScXtMF1SVWi11P8lSmax5uIJ/b8cA+CXfbX6xbaRfYUjMSe2zVQypx4NHNJ1G52Q8hcl4KInlOOUDKNN8lGz6m4YbKONBr8smYncxZAS7Dndxah3xuVho1VAlDyWfIJCxg1AIHB/ia2GJFxDrKuJAAUkLSnql0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZuDuya4m+HK7gUTHSoqTT+tbTD764Tdms5s0nWWtIc=;
 b=kVQWDQ6Z+wXYInqM/7XKDU/wAQJ3e6CeHQ1fjPodP8/vBTyYnYRPdsflVRr9GJxmUxBAT4AMuYyoAClUEkHqzMPDWV8554UNSkbsaBiP5n6DrpRAvDQzCXezq8JawHNvwGlUG2BD9GfldoAxzvBMb/Gknxg9OgT4D9NeFZMgm3zw/czRyzLtPryhJGmZrMsNRY04Wkev1ii9ZuZiX7XX7SmTDIkwozljexodjSn424jY7wWERCalYv0hgGXk3CQxNdJqvylc+mrEfTTT4U33VEbTZCagMRRNV5oMs6R5aVn7NFHhyckXfrlHJVuNCsgfY0Lxl/2QWmo3R/VzhkUVmQ==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV3P280MB0433.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:51:59 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:51:58 +0000
Message-ID:
 <GVYP280MB1518C26FF3DB23EA1592F0899453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH] carl9170: main: verify firmware alive before init in op_start()
Date: Tue, 31 Mar 2026 12:01:00 +0200
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <00c161d34ad5d88f57539fe961a2aa53@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV3P280MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a2cc51-3c33-429d-67f3-08de8f5ef7e8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|5072599009|51005399006|6090799003|41001999006|5062599005|21061999006|8060799015|15080799012|461199028|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTJ2Q1FNSlBSVGVmVmZ4WGR6WFlVN2djL3FSTnhpL3lDdXRxRURiM3VOcVp0?=
 =?utf-8?B?OVlPOTFLR25jbENRVDVzR29Wd05XRnVrdjZHRkxraXR6WmUyQVVMNHlMQkpv?=
 =?utf-8?B?MHdHc3NmajhWNkdKQnB5NllqYmVaVzJvaytCVDltSlpqSDh0NHQ0OTE5blBQ?=
 =?utf-8?B?UGVJcGxOa0FGYVg0TUYra01oWVVaNkthQVBwSHhwOXdVcGVHRnpJYWNSRXhB?=
 =?utf-8?B?SC90QUt3K00rQlczdlowSDdCSjVtSitRcmVCK0JheVl2TG1naWtIL1lLTHU1?=
 =?utf-8?B?THBsZFlIbjk0RWNtV3lwTHROd0hRYXhZRXVVWlhTWTBGbjVoK2gyNHFMRWl3?=
 =?utf-8?B?RnNKQXpZQk41bW1ndDBuUVlGL0JWYTZTRWRmUmZRZDV2S2FzLzdRUlNaSjUv?=
 =?utf-8?B?Q1ZxTmxFemZJY2R4akFSdGoya0NCUTRTSXlQRWNjYzRHQ0JBVUJLUUc5NTdB?=
 =?utf-8?B?SzF1eXNsN0tQbjZaZEJuSUZudGR3RnQxQndzVXA2alBReG5IVG9TRG80ZU54?=
 =?utf-8?B?cXQ3NU4xSnNLZGhtQm1aaTk0T25BOStNZDFhcUFydVYySCtJSjhGVzdScXZD?=
 =?utf-8?B?SW5SRTMwaFN2RTgwQ2ZoNklUdC9LWU9IZnFwWVVqU3FPTjI5dDNpQzcwMzkz?=
 =?utf-8?B?bmwwWWdzOEVnTkFJNTZoKy9nUlI1dE5IanB6eU5Xbm5XdjFmRWJpL0JHdkJj?=
 =?utf-8?B?eDhFT2dKdW51UE9Oak04L2R6c2o4VHBCaERCTzYrenQyK3RGVitHUXR1elFh?=
 =?utf-8?B?VDgvOU9nWU45S1FkYnNOcVI4dGgyOXB5MGk2aGs0S0s5YmFqbWhaYzlCSFhh?=
 =?utf-8?B?aStjWitPQ09CUDNJSDk3a090SGNqdTlLUFJZL1N4bmhIcUZiNjZjaXh0NlUr?=
 =?utf-8?B?OFJjamF5dSswZmVxNzlkQzhMS29neTdTdk5QenNPWTBHU3I3MlFEZ2F1RUFx?=
 =?utf-8?B?M2p3ODBYc1ZLVUxRanZWc2dFdWdNRGd1dHkvRFl2eUlTNU9zMnB0MWRoQnZZ?=
 =?utf-8?B?akpycFJxdkhIMUUyRUlUVTl0MkFoQlNOelFVeGRMRXFWL3RLYXFabit5RTVH?=
 =?utf-8?B?RzFWZm8wNDFVYmlhNW9xWU80Q2VZRWlUb0NIeUUvL1l3T0FtYmh0VkdhT0ti?=
 =?utf-8?B?VUJVaU1NZ1F1U245bEpybEFBMzJNRkxtMUNCYzBVcW90dzBGMWJqWEhiOUhC?=
 =?utf-8?B?WlIxa25VT1lvM0dQQklKZk5Kb1ZUbUNyN2ppUVdyTXg1VDZWTWFvb2daVjJ5?=
 =?utf-8?B?MTVZcEVOWC9vTDdwRDZ1MHY2ejJscDFKeVA1clFGZmNQVVlxZHdtejR6MGpv?=
 =?utf-8?B?a29HL0xudHNDWHpuT0sybFphQW9tOUMxUDhtVDQvOXRPUEpjQnhOemlWNVdt?=
 =?utf-8?B?Z1lRYVV5Njc0STVWOE92S0JKaGRGUGV4Ny9SUDNYZXBITnFTY2k2Z2FDenQ5?=
 =?utf-8?Q?NhbQCt99?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhEWkRqd3pjTzZkaTB1cFlZbkhRZGdGM1orM2Y3U25YQU1hTitxd3JiT0RF?=
 =?utf-8?B?K1Q5TUd5Y3dMblcyek5yOStacHEyajY3c2Zka1Q5UllLbER6N2F5Z2x4NWRD?=
 =?utf-8?B?WUQ3Zmo1dGwrM0xML3VMeTdWMHNhWXlYeTF2NmpsMEhuemRxUEo4SVYvS00v?=
 =?utf-8?B?MEdzT1VIOEVxZ3VRQm5PVEI4VTBTdTE4RU1VSTRJLzdmK2VsVFVrd0JZUlky?=
 =?utf-8?B?cmtRWGhnT05VRjJOYkd0b3Y2UGh5NXU5a2N1VEhuOXBkcjRJOWZ0MmZJTmUr?=
 =?utf-8?B?a2YxTGNwLzFjWjJScW95cTREZmZUK1dsdTRVSm9iV2duS1lOcmlxQ1dObW01?=
 =?utf-8?B?TGEwSjk3OWlEUDYyQVlHdW1IOXZ3V1pUQ0xJdE9NVC9GL3pwT2VucjRrUm9L?=
 =?utf-8?B?NXR3VUgvTEsvd3ZBaXZBdHV2TzVXamFxSVVBTnkrWk42UzlOUGVsbFJYZ0Jy?=
 =?utf-8?B?U1dWRnYyVnpiOVhRUHZ2OXJwYUpucmRSa3NyT1dYUkoxQm5vVEY0Y1AvR1hP?=
 =?utf-8?B?Tml1NUxYb1M3dm02Wk52eUhHcWRRSlBIS2ppekFLUzFkZ1J4YzREUU9hanJ3?=
 =?utf-8?B?dk1HcjdYUWVaTmE4Skc4bjlmRVlkbTRNalY3Y1lPTStiL1R0b1dMekpVK1hL?=
 =?utf-8?B?eEpYS0RFM1QydTh2RU1jcm9idjhyNVZkbXp0cGRFb1E2YVN5K2c3NkthUldY?=
 =?utf-8?B?Wk0zcVN5TzdoQld5dWZVd3FlUTFvc3JvUWlnRzdMa1NmUE96T3ExdmNBeC9Q?=
 =?utf-8?B?ZlJ2UDlzNVRITWFQVDhWaStGUndtVmVva2Q1ZlBIeDU3Z0Q1eVhoSVhiazJm?=
 =?utf-8?B?RXpON1hwMFFVa1hSYXZLRFpGYXJ3SlFPR3ZtVEJnNnNncGsyNkdLK3ZMOU5C?=
 =?utf-8?B?clpLOUNCbys5V3BqUkU5KzZoUzBtdUc0QnhQMjcvNHF0U1ZEVWlLdkJqL2hD?=
 =?utf-8?B?T3d2dlViVFJ5cXUyTmMwNVNSdzErQlV3SldmckpzcTVnQVI0L1YvVWU3RWVh?=
 =?utf-8?B?NHZpVkNBUDM5SldyM2NCWkJjR1RsdzRoa20xam9XS0x1VGQ0V3g1M1hyL3hW?=
 =?utf-8?B?WnR0Z3BzOTcrWUdzVTZ4cmVLWnhHN0d5UlBpbHhWcGl1aWsyZkJiSHpzK0hz?=
 =?utf-8?B?YVVXUTc4TzFUQ1BDeVhuV2MzK2JjSnFOdzNqdnpQaC9qTXVrbVkrSURZcjE0?=
 =?utf-8?B?ZnVzb1hNT1VKT1grUTY2bkhyeVUzcHM4SjR5ZUVmOTNMK3diNHJ0am5OUUVk?=
 =?utf-8?B?ZzJkdElCVCsvRGpMTjhEZDM1Qm05L0JQcEl6NjM0K0dBWTZ1YzBUUkdsbGZp?=
 =?utf-8?B?RWlBYWpGa2lFdW5lbTZNSDNMdW5UMWVwd3J1dC9jYXdXOFkwWkRTelVEejR2?=
 =?utf-8?B?eE52TEFuTlhwTWhkYXJiV2ZDMGZlWjBxdDY0Z1dTL0hDU2hFMkd4aEtIRXJ2?=
 =?utf-8?B?TGFkeFhLZ1AyRWJ3cTVUWlpzSDZtT0oxRmtxRDg5dVMwY25oRVJIc3FVY0wz?=
 =?utf-8?B?ZUYyalNnSXo0bzhVK2htM0JXNFNRZ3BCVWlhcXNrWk93M1hVSUZiU3lOdE1v?=
 =?utf-8?B?cW1jU28rdjNobUVwSGJrbzNMN1dHUGxPZWRheTFadGVCc2xvdG51cnd0Yk1v?=
 =?utf-8?B?ZnpjNXZDY09nVGlsUXoySGRIb3lTbVZ3N2ZkUmtjcWpxYUN3eTNhenhTRWs0?=
 =?utf-8?B?MXpNR1VCUGhIZkl3K28xS05Sallsc0dXb1NPOWQwcGYxVXRNdDNySFdUVmxi?=
 =?utf-8?B?N0xqTWVadTRYQ3p2UDVkR1d0dmJ1a0l0MWhUZ2RQL01pQTZ0TWN3VkJ4RVM5?=
 =?utf-8?B?RkgvaWM2SHdpaEU3aFMwL2xHdWw4cktKNkkzQ0lCQTV4aW1ERVhVdGxwbHJy?=
 =?utf-8?Q?boiiGXvbOj+tQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2cc51-3c33-429d-67f3-08de8f5ef7e8
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:51:58.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0433
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34242-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,hotmail.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB220370DC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After carl9170_usb_open() uploads the firmware and asserts the USB
endpoints are ready, the driver proceeds with carl9170_init_mac() and
subsequent register writes without verifying that the firmware is
actually executing and responding to commands.

If the firmware is in a deadlocked state, the register writes in
carl9170_init_mac(), carl9170_set_qos(), and carl9170_upload_key()
will time out one by one, each waiting up to 1 second, delaying the
inevitable error by many seconds before mac80211 sees a failure.

Add a carl9170_echo_test() immediately after carl9170_usb_open() to
verify the firmware is alive before committing to the full init
sequence.  If the echo test fails, propagate the error immediately.

The echo test runs while the device state is still CARL9170_IDLE,
which satisfies the IS_ACCEPTING_CMD() guard in carl9170_exec_cmd().
Only a genuine firmware deadlock (echo timing out) causes the early
return.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -374,6 +374,16 @@ static int carl9170_op_start(struct ieee80211_hw *hw)
 	err = carl9170_usb_open(ar);
 	if (err)
 		goto out;
+
+	/*
+	 * Verify the firmware is alive before the full init sequence.
+	 * A deadlocked firmware causes each register write to time out
+	 * (1s each), stalling mac80211.  Fail fast.
+	 * State is CARL9170_IDLE here, satisfying IS_ACCEPTING_CMD().
+	 */
+	err = carl9170_echo_test(ar, 0xdeadbeef);
+	if (err)
+		goto out;

 	err = carl9170_init_mac(ar);
 	if (err)

--
Regards,
Masi Osmani

