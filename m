Return-Path: <linux-wireless+bounces-29001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B17C60CA8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 00:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B4C3A86D2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACA21CC68;
	Sat, 15 Nov 2025 23:17:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011079.outbound.protection.outlook.com [52.103.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837318EAB
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763248624; cv=fail; b=NlUOG5XcVaU20t0xnaNVjsONt9y4yJnVGFcYksLtnWgaumUmivw/iqbRuj7jYXyS5x3GKdSn3t/6PDQHhEmanRYK+dXiWqGsaHTd37+O8l2ZcNzrLwRYAovplzFnXKl+KuN5zLfFzGbiKzvsYr0kRK+mOREpacODyO0ASm0GmEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763248624; c=relaxed/simple;
	bh=T8f8EKrg2GTO+oTsQuC9+4YmBbxNJLBL3XBvqETeQzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkv+Y3qN3nJTYvAdZO6ddPm/3+S6op+zAHdr2ud967Lvn4vhFma4CE3Hf+kurIbme8hvGemqd96FMS9YG1CvCCGBNr/RgJ0ykGQjFt8MtToORY5WZI9p4/jIusz2U1rIIIj/xDywoalKZDfJZGydp7kVhu36AmvgY8zQEGmcANQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=52.103.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruVjSUHH1vJNpmobhblhmB3sYgeD+GkjeXVX4OxFcfL07j+IJUsBdsTxutiuPnOa6rApuAj+r8vzMgyVACo2CWzOFLk1pMmh7fJJcHzmfrBIW1tVO2a6lxxrEyO3jtD8qdXOh6wzhG9oHRP7Xs2TG+m/skY2CJ4CzUMSYfp9jMHK5k4AWyWbvDGC3BqeRxKFcerSETKK9XUGRKS1GuiKDrQVwbQFntzX9fL6GxWnouYM4D6RVu+3sbcDR18T8ThjuCcJLD2fmIu2zkU1irSc0BX4rBNAJD6gCE3BuIBJ1UQWW6yLLGDroydjy31P2X0iIlm96o2ao5QsRlhUrKHR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R3xw/XAi01agYyqIc3sNrCkFZlN3jidnSxIyY58jAc=;
 b=X5m8IUQ8wm4k/9FrG7asRjtSc7x8paSac9yFqFR+gifD3psnOVG+D/CXokRkw+3fIe2uUDSlw673n+a7nDjfS/zbvrLWYcsNBcHmAxVtxuBjnTTZuia+euQZdvihN3RB2bA136vYnMQULStXpnzq705oaY8fX7QXX1KX1S+wVQJi6whrEPy/+zaKSrZwEUQyE/4FmL+h2RaTtaH2CoUzWOLOs+3VjAURmsM9NJ9zCs+eVJ33CbK5nojAMyX1X63uwXpzBADlgk8Sf2m6ZXumf8cup1VZuUa+2MrFxItrDGqI6gNCZ3smiGhiG8e9c0p76HNLASXnbTA5gcd/zQS0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM (2603:10a6:150:284::10)
 by AS1P250MB0655.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sat, 15 Nov
 2025 23:16:59 +0000
Received: from GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747]) by GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 ([fe80::5957:21ce:d025:7747%4]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 23:16:59 +0000
Message-ID:
 <GV1P250MB14330DE9B959725A5EE6DC7FE8CBA@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Subject: Re: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly
 flush pending packets
From: Florian Maurer <f.maurer@outlook.de>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>, Jeff Johnson
	 <jjohnson@kernel.org>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Sun, 16 Nov 2025 00:16:58 +0100
In-Reply-To: <822673fe-174f-472e-8874-783198e22300@dd-wrt.com>
References:
 <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
	 <236b48e6-43c3-4d2e-a864-3ba627101c90@dd-wrt.com>
	 <GV1P250MB14333099108FC4461F201AE3E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
	 <822673fe-174f-472e-8874-783198e22300@dd-wrt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
X-ClientProxiedBy: AM9P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::19) To GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:150:284::10)
X-Microsoft-Original-Message-ID:
 <ab8b59df073ff94c83cfdb9b2e029b42fa28050b.camel@outlook.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P250MB1433:EE_|AS1P250MB0655:EE_
X-MS-Office365-Filtering-Correlation-Id: efedddba-5a76-4508-5dc3-08de249d13bc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|12121999013|19110799012|15080799012|23021999003|51005399006|8060799015|440099028|3412199025|4302099013|10035399007|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlc4STBSQkc5eUJzTDd0MmRwc3R4bWprdFlZbzZMeUd2b2lFMDkwTUVxSGZa?=
 =?utf-8?B?aXJHS2xRTWVCTGFzREdSc0pUZkMvQVI0VUpnemxuWlFvNnowbHJwdXUzNEZs?=
 =?utf-8?B?Z0o0K0w4UmtoYzJIWXQvUEdQWU1LbkQ3ZjBRTkhvY0MvNGMrbVdVR0JWUVNO?=
 =?utf-8?B?bzVma1U5K0doVnArSHUwdzJ3UForUzZCOU1yZURucjlDSHdaL3VoUGhvMExu?=
 =?utf-8?B?M0FHVXk3dUFINFNNT2RHd1RuZi8zL3U0TlJlNHZoVzBrYTZnWDFYUTBNNi9H?=
 =?utf-8?B?N0VsYUpiSjB5TDJIbGJIeG1XRG00OWdteVErb1VGN2tmRWp2Z3VqRUNaRGN5?=
 =?utf-8?B?V3ZGUnVuM3pGMDBuSHpoYnMxQjNlUHNyenRmbXZuRVVxdFhrSlpFVlJjTEsz?=
 =?utf-8?B?YWk4OGYvTTFyS1h5Wm5zZHpZSmFvOUZsVGQySUFUQ0REWDcrUU5CeStuK2My?=
 =?utf-8?B?SXVIdkQ4NnBDR0w2MUNNVENlTU5jNEdjZjZJeHZyRUJlMDh4dXQvNEtWZCta?=
 =?utf-8?B?eTJZL3VpWm5ib21XeXpBQ2xpVmlvTEJ5dmFTaDR6S2VVMnBhajZ2MWJkSjlV?=
 =?utf-8?B?Q2tYYW9QeVQwUDlXSzQ2bXFnOTZnQ04zVE1rQUdCeURIWWpBOFdZTjc5TXV6?=
 =?utf-8?B?a1cxYk5zVjNtNlhhVE81TTVVSDVoUkhyOFRBcjNxMnVYYmVuMFVvK0VtSjB0?=
 =?utf-8?B?Q0tkV2RkMGQ3TE93Z0JRSEZUTkJUbVFxT2ZmWFp1bU96VktMQTdkL3RZSVlG?=
 =?utf-8?B?K3VDb0Nxc0FiUVpBLzF6VDIrMHduZkVwMFp1MnhsUzJ5SkREMk4zc21BUlg5?=
 =?utf-8?B?UEpVU0NCUnoyMHdqWUFGTlNIVThqT0pRRFpqQVo4K2EvZW5GQTdMblJJTUwz?=
 =?utf-8?B?akY2cXhoYXQzc2lsdTdtQ0xkcVFGNWZWNnhwRUh5MGYzQWgraHVRcW84aWI4?=
 =?utf-8?B?Y25nUmZuU0ZoeW9HRE96eWtacG1xYjJteGIwZXhJSWpMdVlzSjVyblhRRHhN?=
 =?utf-8?B?ZE5lYjdrNmU0Q2dLeEc4YUJweG5XM1dUaUtxNUorWWVNd045UzIrRjU4WUky?=
 =?utf-8?B?ZzlRRWFOOGxXY0lIMmRtZHVNWCtKbFBMY3JHV1R1NStvRGNrb3dndlRVMWZN?=
 =?utf-8?B?Uk4vZUV5MUpKck4ycEYzcGYxVG5MK01RNXRqUG1zWG9ONWlMVERHNnJGaWNl?=
 =?utf-8?B?SlVtbDVsTmhEdzBLcWNCOGttSVZmZ0pTcUszMklQbzluUjd2Q1ozNno2aktl?=
 =?utf-8?B?NWxGMDlXODFlKzFzdEhrQ200L04zV2JuNlhJQ3k4SUtYKzVTNzNrZzBoWEti?=
 =?utf-8?B?cFBTVEZDWE5DbFhPellWdXNXTmhUbU03dTNadWtCaS9GbjM3TEZRdzU0ZW1w?=
 =?utf-8?B?bEhQWHFXRFRUbFMvV3JjQVpPU0xOUkhpRVk5UnZZejdMbHVWaUNPL1pLMzkv?=
 =?utf-8?B?djJaaEl0aU9PV1Y3NFRHNkVsSE0rNU1YK3dtc05Mc3Y5VnpjUkxjZzVXYlNh?=
 =?utf-8?B?azFVUnpzVmVoZ29vbEF3YmJTOHVUM2ZpUDhqT1FJTitxOENXZEg3Z0Fqa0NM?=
 =?utf-8?B?U1ZrQThIN0MxSjJCTW5vejRCaW81QVY2d0RvNVhPeG5XNkpTeE5WSW4xd0s2?=
 =?utf-8?B?NzVJQSt2SXRhVHJwem5sM21LRGszeFZYbS9VMkplQnd4ejV6TGJOeENsa0dp?=
 =?utf-8?B?UGsxRTVVeVZNaXZBNTUzVmlSLzVoNzlLdlpXTENYMk9LQ1o4R2NkcEJ3NDNq?=
 =?utf-8?Q?hVjmB57KV5iFaS7bSXOfjyPMtkuU890AGcS1E60?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVQ0VHBvNTh6UitqUEpsNStpZzhJQkVtTkpTOGNQbzd0S1hVK2REOWZLUURJ?=
 =?utf-8?B?bTRKQmErZG5rMkd5aEhqQ2RaaDhPZVVkV0ZZL1FoeG8zZWdXWWdWUXoxQ1Rp?=
 =?utf-8?B?YUZWcVlDcnRoRXlsRkxmdDJSdXhvdldjejhteFo0Q2xaQnlJVzJ0SWFBQXg2?=
 =?utf-8?B?L3lSdFhRNGZwMjltSlRmZlAvVHZ1NHprR3l1NExGZDdDZHkxeWlwZzVBTFpj?=
 =?utf-8?B?aGFvc3RGNEdXRTFPTzg3aWxmNjd5dFduSEN0OGswK0d4R0xsYWVHZXg0ajhi?=
 =?utf-8?B?QnBqbDNLWHluWi9iUENQWndvK1JENUIyeFRsSFFWcHdYc1E4SVFLOFdTemY1?=
 =?utf-8?B?eFh0aWFZTk4wdzc2SmlER29lcmJYS1VTbGE2RFFlYkxHcG9tUmh4SjdGUk4v?=
 =?utf-8?B?U1U5bXVRYUk4bEJHOGxxa3JSODlYVTREWWVBZTZpSy8rT2RlZkxxS1dtdyt3?=
 =?utf-8?B?Sm5rZ1FKYzhneHhLY04vdGxwdUlHZmxkZzhmZGtoMnJKMFJ6WFV3MC9lNk9p?=
 =?utf-8?B?bU4xY1VubTFDcjhhSlNoVWZTTitjeVIvaWZhb200SUREOFZUQ1l5ZXUzejNE?=
 =?utf-8?B?RTRvaStKbjl6VVdnK1FEaVlzd21uSkJFUlEzRlM0UWxZNVVxeDNQMmUxb0h2?=
 =?utf-8?B?ZmZVbUFwY01LZFNITFh6SW9lRHBrQTZtSnQwcXA3b0k1bTZSOWlrUURpWVVF?=
 =?utf-8?B?T2xXeHA2M1JGaTBVMmdZTUdCNWZCcHVUc3VQWmZmZ0ZrTlNXb1U0Q0NUclV0?=
 =?utf-8?B?UXd6OVNkZUtBdTN4UDZDbUJrOFRaRGJLekN5U3dQcWdFbkswclNlTUxtVi9D?=
 =?utf-8?B?cE1MRWZ1LzREVjNMNnNiZDBCdEtZZExnU0NRaEwrOHVvL1ZpSU9acEMwR0hY?=
 =?utf-8?B?T0NiUVJERGVSK0Jab29CblVhbHEwZHMzWDFtNk9IUnRiM2VJc05BMmVhV2FW?=
 =?utf-8?B?SCsxdkFaaUlkb1pYcHZvMjVZNmEzOXNIM2lrZXZ6a1ZhaW1YRXZJNVFGdGpJ?=
 =?utf-8?B?ZUF0UHl0S2JJbjBKSS9yMmo1bTdYYVNxSTVxVDJWKyt4dnRGbkw4bm1iL3FM?=
 =?utf-8?B?dHU5aXNVbGpwalViVVdSQUJNei91cHdtSnZucTFaMWkxU0w1VlJIS1dScU53?=
 =?utf-8?B?Z0NReW9xZUFtTTAyVUVoT0lDanU0MitHMVRiZzkyR3lXeDNpSmpkMUNFcW9w?=
 =?utf-8?B?ZmZMcjYwbjVjNGo2WDNoRlZNUUI5bEpORTg2WWRHZVRWNWh0R1VZMGJqb0ly?=
 =?utf-8?B?UmpSNDIyWDNKRGtWWGo1bHJGOElncjBHaVkzdzVkaGtMTXVuNlJDbmJGdGM1?=
 =?utf-8?B?cUlxYitxbnh6azB1QVpkWkM1bVZBakVZeGttQjhTSnlidnZTMHErUW81L1lx?=
 =?utf-8?B?Q2xSWTVENHFvRUpUd0QrUEF5aHpmVU5HeE5oS3I0UGVBSU9tamRmWGNWKzlz?=
 =?utf-8?B?WXNSQnNnN1ZoVUhhRGdRN0RzaWNhYXRTZVlSZXIvazBYamRXNDVoNEc0R3cx?=
 =?utf-8?B?Z3JVb1BXeTFJL3dDdWoyajUyeExvWkxWZUljeTBLdE9aekJncWRzQ0p5cjBW?=
 =?utf-8?B?VlBWd0lWeWNBcDhkY3pzOVAwQzZ0MUw4Y0VUb3hSTkRNbHg2S1hZSkNzaFNl?=
 =?utf-8?B?bjNHdHRLWnZ0Q05Bc0gyY0UzMU1iT2pSYzdQcUUzaUxIZDJ5emdhU0JyK0dT?=
 =?utf-8?B?Y2RBeGhkQlZXN0d2NEtSMGJTcGMrTEVYR1JLZXhVTFQ2M2hLRUJDcDhIM3k1?=
 =?utf-8?Q?uF48uEiLuVD75CMeDs=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: efedddba-5a76-4508-5dc3-08de249d13bc
X-MS-Exchange-CrossTenant-AuthSource: GV1P250MB1433.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 23:16:59.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P250MB0655

On Wed, 2025-10-08 at 08:09 +0200, Sebastian Gottschall wrote:
> Am 07.10.2025 um 15:59 schrieb Florian Maurer:
> > On Tue, 2025-10-07 at 14:38 +0200, Sebastian Gottschall wrote:
> > > Am 07.10.2025 um 10:11 schrieb Florian Maurer:
> > >=20
> > > > When a STA is marked as no longer authorized, if the driver doesn't
> > > > implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> > > > flush hardware queues to avoid sending unencrypted frames.
> > > >=20
> > > > This has became a problem for ath11k because ieee80211_flush_queues=
()
> > > > will stop all traffic and call ath11k_flush, which waits until the
> > > > whole HW queue is empty. In a busy environment this will trigger a
> > > > timeout warning and stalls other STAs.
> > > >=20
> > > > Fix this by implementing flush_sta method using WMI command to flus=
h
> > > > frames of a specific STA.
> > > > Flushed frames will be marked as discard in tx complete indication.
> > > >=20
> > > > warning print "ath11k c000000.wifi: failed to flush transmit queue =
0"
> > > > was observed on various openwrt devices, and is fixed through this =
patch.
> > > >=20
> > > > Signed-off-by: Florian Maurer <f.maurer@outlook.de>
> > > > Tested-by: Florian Maurer  <f.maurer@outlook.de>
> > > > Co-authored-by: Benjamin Berg <benjamin@sipsolutions.net>
> > > > Tested-by: Flole <flole@flole.de>
> > > > ---
> > > > We tested this patch and it solved the problem of flushing the tran=
smit
> > > > queues taking too long when the AP is busy.
> > > > We did not confirm if this flush is implemented to guarantee that n=
o
> > > > unencrypted frames are sent out on station removal.
> > > > Could someone with more knowledge about the firmware behavior check
> > > > wether this approach is feasible or if a different approach should =
be
> > > > taken.
> > > > It is not clear to me if the approach taken in "wifi: ath10k: Flush
> > > > only requested txq in ath10k_flush()" might be better.
> > > > https://lore.kernel.org/linux-wireless/01d859e8e574a1f5d0b916333fe0=
b5cda859af9b.1732293922.git.repk@triplefau.lt/
> > > >=20
> > > > Regards
> > > > Florian
> > > >=20
> > > >    drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
> > > >    1 file changed, 19 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wi=
reless/ath/ath11k/mac.c
> > > > index 106e2530b64e..a94649edd4ed 100644
> > > > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > > > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > > > @@ -8330,6 +8330,24 @@ static void ath11k_mac_op_flush(struct ieee8=
0211_hw *hw, struct ieee80211_vif *v
> > > >    	ath11k_mac_flush_tx_complete(ar);
> > > >    }
> > > >   =20
> > > > +static void ath11k_mac_op_flush_sta(struct ieee80211_hw *hw,
> > > > +							struct ieee80211_vif *vif,
> > > > +			    			struct ieee80211_sta *sta)
> > > > +{
> > > > +	struct ath11k_vif *arvif =3D (void *)vif->drv_priv;
> > > > +	struct ath11k *ar =3D hw->priv;
> > > > +	struct peer_flush_params params =3D {
> > > > +		.peer_tid_bitmap =3D 0xFF,
> > > > +		.vdev_id =3D arvif->vdev_id,
> > > > +	};
> > > > +	int ret =3D 0;
> > > > +
> > > > +	ret =3D ath11k_wmi_send_peer_flush_tids_cmd(ar, sta->addr, &param=
s);
> > > > +	if (ret)
> > > > +		ath11k_warn(ar->ab, "failed to flush sta (sta %pM)\n",
> > > > +			    sta->addr);
> > > > +}
> > > > +
> > > >    static bool
> > > >    ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
> > > >    				  enum nl80211_band band,
> > > > @@ -9920,6 +9938,7 @@ static const struct ieee80211_ops ath11k_ops =
=3D {
> > > >    	.set_bitrate_mask		=3D ath11k_mac_op_set_bitrate_mask,
> > > >    	.get_survey			=3D ath11k_mac_op_get_survey,
> > > >    	.flush				=3D ath11k_mac_op_flush,
> > > > +	.flush_sta			=3D ath11k_mac_op_flush_sta,
> > > >    	.sta_statistics			=3D ath11k_mac_op_sta_statistics,
> > > >    	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
> > > >   =20
> > > why is peer_tid_bitmap 0xff instead of 0xffffffff?
> > When setting it to 0xffffffff it fails with:
> > Assertion !CHK_TID_FLG(ptid, WAL_TID_IN_SCHEDQ) failedparam0 :zero,
> > param1 :zero, param2 :zero.
> > leading to a device reboot. See:
> > https://github.com/openwrt/openwrt/pull/20293#issuecomment-3367037471
> > It works with 0xffff though, but I don't quite know what the firmware
> > does/expects here. Maybe someone with more information can help.
> due the sources. BIT 17 has a special purpose named WMI_MGMT_TID
> all bits can be masked but bit 17 as it seems
>=20
Setting more than 0xFF leads to firmware crashes in AP/MESH mode.
Setting bit 17 in AP mode crashes as well.

There is reason to believe that bits 25-28 should be flushed
in STA mode, which is done in the v3 of this patch:
https://patchwork.kernel.org/project/linux-wireless/patch/GV1P250MB1433E723=
AF90A69AEBB696DAE8CBA@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM/

