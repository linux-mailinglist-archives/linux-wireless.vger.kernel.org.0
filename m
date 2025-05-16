Return-Path: <linux-wireless+bounces-23071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B991BAB98AE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47707500297
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F09222592;
	Fri, 16 May 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="VLnFtO3H";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="xL3vy+3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D115530C
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387385; cv=fail; b=i1L0AaAZ3ClMvPF1XFEDQtR6v3p2yIINKa+eCmv+mGomi1RVncpIzBkBYabKjkZMpo55HRMbX/mMFQogicYe9LDJi+2R8XHYS+QSrLJFhrglyVGSkOxqjFPM2OMS2Qhd79kf2VDLvEM9q34C+9hRnmXzDAefAmcKHlD9Mcoeebo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387385; c=relaxed/simple;
	bh=fRyv5c034RE62RoYjJv9ChT/bkgq+wVrCv6MnGJ84To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8N1l0y3m2lZyGobfP015TfkvKkcU15o5cHhVDTS/KDS1rs1vQR4Wwp+RQC3It8jbmadvWDIso6afZU49Y/OGAr4MRuOY7TC3ygnWx26q7VJA0MtyQ5mU67E074nAQapp3wzvqhP4G+e30lyt/pN/Hv7FprMRB1snAXdtvAtExw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=VLnFtO3H; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=xL3vy+3K; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5soOY006294;
	Fri, 16 May 2025 11:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	MNjkuwYwpdhvjqkr2yntZrtnD7ay/BTEWQdShTGSXV0=; b=VLnFtO3HuQmaaYmx
	M8Ty+ZFe/NSNyV1YocR1y00WphQg/8TXtYD3kub+SYo6xgVCjVylVtC3cn0RbAKY
	aJsU2eWfvWDG5R73WSkSWd0lKMvv3U7UfvPX56JgxwvnO9vn3ANyWWIINh77CgkC
	LqTI2ysm5pwE6sgLRIIL7aiWejH7jI7o3sO+Jy6SsRsNUDVb6TST9ZJMgnn4CUnp
	x0VQKORu2AHKGDLThGT3/WDnfg1Fs17hepBY3KvG4PXqVw6pcK2RTSfnv5wUrUfN
	AaieYCDqgSj/MZ9aBOyRl3rkZiRa2/WnlNbbJ4Ovi4BcFTpU8loT8l0nYHE4EzdD
	Ev327Q==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46htt46sh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 11:22:53 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcDQGMh87n1oe5chSOqHrIa3a8zpW/Q2slMEB1EITocooERgECQKEzj5Il+BGe+ujPAMziHpxaOSdq2lXAukCpwBqHPnML7BEam1hx3iaG+6QY0W5+GL3fAoQvSpZMX0me+1lceptWx3f/5xqhYx8qjADIhID8GlZSkNeGyfMhCrR453MhaAcjpPUhyPEGRxjwSnw9JA49jY3sX7YGuOXNbrFMGeML/ax13HAxjwM3KWjwY2WJXHE4/mCw3keWd2DJ1p7sw2K5aFCEZJAi9LFF3T3wh+zUqXVynIbHPmJfO1CjiYQ+Cf8XLvqSNFQ1b2LQdDTalwh2fCfumSs+RBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNjkuwYwpdhvjqkr2yntZrtnD7ay/BTEWQdShTGSXV0=;
 b=GzuBEUYHBIbiZ9yuKGiID/yhXwzZteyMo1QTpLgJBCo/hWS1uv/FU1/+MZMnfjk2DjQa1ZJkQAoqliXF/jCes4I8hyhiEFvLzzfSCEfSQRSc5FBAe7lT4Nq9z8nvSw02T/L3Gjni8d9PIAvbD46ll2nVQ8mPNUsqOYvLSLQngLspWmCx9UfKgJj1A55Z/JdwQUov5ITceTuDe4JJTUDoPcZRBkXS8aISAN9NVtPayh1Br2JM7NFC/S3dk5dMEPG6NSeNk/waGet0HZmDnNPjMqdAbgXIxnk1HDkTS31AXOrIDH9qRFboinQW5PxbRah6ACeReWEtrGfwOEYsD8NHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNjkuwYwpdhvjqkr2yntZrtnD7ay/BTEWQdShTGSXV0=;
 b=xL3vy+3KpXCrvchG+hp4UuD+TGD67y0O4GOJMm/tnFDF1YynftVGvHO42VAkdKcfGaFiTPJHvnxNfp5gN9Y3yei3Q9Z3gPPHV280JhMoBk0Yfyz0kJlYCBKRps+z3JA2hJxo1P7G/C0s1db/HuqoorMc0xpRZclhbfihqCACPzg=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by DU0P192MB1745.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 09:22:48 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:22:48 +0000
Date: Fri, 16 May 2025 11:22:45 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org,
        wireless-regdb@lists.infradead.org
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
Message-ID: <aCcD5QLRpbMexvq9@FUE-ALEWI-WINX>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
 <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV2PEPF00007567.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e5) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|DU0P192MB1745:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e9b977-e667-445a-a9b7-08dd945b398a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0s3ZThiYnNwUHlaTS9xY045eWF6ZGszakxiSGpvTHdNclhzOFM0SXkyMmlU?=
 =?utf-8?B?NmV6MnhOQ0l3YkV6Ujl1R0l5NkExMVpSV0dwTU1EUGhPR2o2VFVzRlZleHow?=
 =?utf-8?B?MTdFNG5ydjh1ek5vSHhQeUVJN1U1SXR0N2paWjUwQUE3c0lrclVEbXZ4bTRM?=
 =?utf-8?B?eEo4L3ZpR3F3d2FpdWJGMW8wYjVPcWgxZU9hTzFzeUZla2xSMTkzOGh2cHpQ?=
 =?utf-8?B?NTZmYTJoczJEdWM1TWJ4RmZmT1Fva1JoZ0ZTM3hkM1hQVW5uWldiWjYvUGJi?=
 =?utf-8?B?TVplY2RGMnBNRjVHVFdZSStVeldXTkFSSmt6czZRUkRLVXNma25nUUdEdXF5?=
 =?utf-8?B?ek1rVWR1UEZTcEtBaFNPa05PZUE1L2ZHa2NkdkZIM0lTS0EyWHNKRHBvOFdS?=
 =?utf-8?B?WTFkc2Q5ckwwTGtYbGMxd2FvOWN0SkNhK1lEWTkxQmZiTm9qK0lDdjFLWTRq?=
 =?utf-8?B?TnROZVRLbFhsQWZseXFVUkFwQ3BQNjhlQ042NVpMTmdxNW5RclpkUGNMVjhH?=
 =?utf-8?B?d0trV3FMTitDM0tYa1ZwTjlmR05zSWZXOFJkSXFweS8vRVNHLzlqcjliR2g5?=
 =?utf-8?B?cFNONjBJN3E4UGJ3T2NoeDJFMTh0UEpLdzNIWFVvOEFMZDFYMlJwYVFxcXBK?=
 =?utf-8?B?bWl5UTAzdE1LR05YM0tMYWxuOEl6MXBWMFJnWWdieXJEd0Jvb2pvSi9DUVcy?=
 =?utf-8?B?Wmx6eC9QaVI1R2I1NkJhaG83ZHluVVplUS9BRXo0VkRNU0orNWREcE9oRDBN?=
 =?utf-8?B?ZXk0U2FMMUdnekJBZTArM0pveXJ4RjU4Y05uQWNzSWROUDNmZ3FrelZaT3F6?=
 =?utf-8?B?OGdYQUxnejU0MzFMRUdoNFNXcEdaVUl3NEpCUEl1SU1DaWFKOU1NQzN5K1l4?=
 =?utf-8?B?WXoxZGVqQnhRNllHY3JtRmlKZS9xZ0FjZlo0anY1OU93b1A0RWlNQTlZdndy?=
 =?utf-8?B?UngyTDNyOVVPMkVHS3h1M0VqOFh1ZE53ZDhKeHFQdkVYdEl3enBPQ2VpK1BJ?=
 =?utf-8?B?KzRsVzJqVTJUYnBraXNhalJXWjA5R2k2SWxKNC9uamhCcnUzd3h5WDNoMGZT?=
 =?utf-8?B?NWdqRTJFL2VmSC9GamhnYXQvWDFtOGNnY2J0S3l2TUYzUS8zZXEzeWk4Qkgy?=
 =?utf-8?B?TmZrQm9WUjRkZTNaK25JdWc1YU8rdHlLTGhsOEU1cnhvRXJxNHl6ejNRZnpy?=
 =?utf-8?B?OEhDaDliQUs1S01la0xIaEI3cnRRM0JXRW1HNXgrVWtrY3UwdC80eEo3M2Vs?=
 =?utf-8?B?Umw3K1ZnSDNrTFVycXhjdlgrWSt3NG56UkxoSmhrV0tmN2VtSjkrM3BTSzli?=
 =?utf-8?B?R2o4TTRqdU41elBDdHpTZUp6WmZSWVRhbmVkQi9Pa2Z5RGZlSVFsTHdrNTN5?=
 =?utf-8?B?bVpGeG44dVpHTlF1c0NmNzBIbFpjMWhkUjdEZ0pDUXFkQlZoVGw4Yzl3Wndt?=
 =?utf-8?B?dnBwcHBLaHcyNzJVV2toUm5ISXBuSWhKYkdvSHZsdEhyL2dhQXQxbWoxdzlE?=
 =?utf-8?B?TGtyNHNxR3U1SG0wUFNUZHFyQTM2QU85NURVWGdvNDlPSnB4Zkh5Qll0eUxU?=
 =?utf-8?B?NUQ2R1dhYnVuUFBBSGU3V1lWYlFHR2E4eU4xTmxJemZmL1ZTOGN2OEVUV254?=
 =?utf-8?B?ZmlZVFZTT00wQ2tGL1lnczVyV1JFNFVHVENNVi9MMWh0dVRoOUpkekJkKzl2?=
 =?utf-8?B?dloza0pZR2hJQlllOG9QNVBqcWltVTFUa3c0Z0lFNUdiQnc3dXh3TXVOVmJj?=
 =?utf-8?B?aXRrTDJNVTc5UE1yM1BOaVNNZVMxYkZKTzFydm9vcVJRb1ZRaGI5WlRxbWNW?=
 =?utf-8?Q?ql3YAi/qweEXur/W+wcSzEzcWi8STwp31s9Ck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01uTkNhU21QSjBQS2YzbnhUbEU3K0NhMHRaV0Y3SjFYd1g5bjdCNEFJVVRn?=
 =?utf-8?B?NXF3QmNrRm5Ib0lUamQxeVlZWEkwbzRpblVOemhqYjIzSXhSb3ltaG1rRTVa?=
 =?utf-8?B?QitFN2Y5TFhSR1ZjZnhiSWhPcXdjWTFXSG9iRGdTZTl1anRDcVFYOGFlWXJi?=
 =?utf-8?B?bFlUSzNEdFZJd1U4WERGL04zUndkTktLKzc1UEZGWVVUZGRNV1FzNG5UQ2Nt?=
 =?utf-8?B?dkRyanJXNkpBQzFBb0tCRnZPRXI0Y0xEampvUnA2SmFScnlzVjQvd0llUTNn?=
 =?utf-8?B?QmJGYm1zRW1PK1dwdmZzWW01cU8raXBCZER1MXV0RE83a2s0bjlHYTZsM2th?=
 =?utf-8?B?WGtCZmZieGdZbUxtVVN0cjNjSDRJNGRFa01OV2dVa1pKbVEwNTZzbVZpME5r?=
 =?utf-8?B?Z0hFMUMvaytQcnhzc0hYSVhYY0Y2cDBWT3NkYjRZbzNlNS9kamtWL0RsWkxB?=
 =?utf-8?B?Zi9iSkNubDV2eTNnaWlvSFBHQXp6UE1zMTdkK3BGSnFlWUE0cXBDWDBSMWpy?=
 =?utf-8?B?RGVqUi9venVqbENwV3R4eDlqK2xSVmlJSVA4Q1ZMMUxwSk5nN21jd3V3a1lF?=
 =?utf-8?B?R0NCYnFQMndOVEdNdnJjOE0rQllaWkQzckhvNEM3Uys0bzJYZ240aDAxTk9T?=
 =?utf-8?B?WG1oNlRrVEVHNTluc3kwNzNSZGNxU0dkUy9ieWNhLzJKclViSFRPNzROY0hz?=
 =?utf-8?B?MTRRMDJZMVB6V3Y2OTBYSXZYNEk1cHBKR0Q5eE5FWmZweTkwWFlaZVNRZ2xN?=
 =?utf-8?B?WDNQQlhBbUZwSzA1dU9IcmY2T1BsSkZWc3JiWmp2UFN1d21hM3gxUFF3dzNU?=
 =?utf-8?B?T2R2b1RHTVBNMU5EZS85dFUreXoxRk8vN0JlcDRVMTNoRi84L0ZXU1JkM25t?=
 =?utf-8?B?c1RIWG5NR09UdG5zZXA2T3dsTmJJRzMrd0cvcmVXamgzUWRtd0Z1OTlvNFFS?=
 =?utf-8?B?WlZ0YUpETm1PZUQ5Nit1SUVXMzJBWmY3NlQ3MmhtYmhTMHNxV3ZFY0I4aFVK?=
 =?utf-8?B?NENsd3JLMktRT0lDWnZUT2Z5SnU4eEdqTm5VWlNxVkZNejFyb3IxeGhWa0J1?=
 =?utf-8?B?WlFOZWlSTXM2RU1DYkhyZGhlZ0pqdTREcXk5UlBCR3ZjdkEyV1JlYmdoSndy?=
 =?utf-8?B?RFgrdDVjVWtPSmdXSnRZcE1UUTQ2L05NYWEwbU95VXpJWXdoL29kL0JhWi9i?=
 =?utf-8?B?SWdsME9HUWpQR1pFdU13cVBzM3NTZFdkUmZXcVZYYVhQZXZMbk1OZ3FSckFP?=
 =?utf-8?B?dFJkaGhZZnJWWnBBcVFwWHNlREJQbjluM0lvdlNaQ3krSFJ0bGpQOUk2MHdx?=
 =?utf-8?B?MXVUS3doT0F5NitJWEZ1aEdDSFlUdmRnVmw0Y2Q0djRKM3Y4Ni9rNzZHWUlo?=
 =?utf-8?B?ais2Um1vVVhrM1FFTHRXZEpKYWdkZUhiaWVQWVA0bHgzazY5S2Y3aERUV3Nk?=
 =?utf-8?B?RjNJUEJoVUlzS2loU01VbG5NQWRDYjMxM1NvSy9pRkRzTGZ5N2RXNzh4bDFr?=
 =?utf-8?B?QWlLSXZmRlVWYkE5ekpwNTFWVDlKSmk2Q3ZFdlB3b2RzVWtTaXZxaTlCblVr?=
 =?utf-8?B?RDR6MG9heWFOZmJyQTMyUXAyMmpEV0pud0RVNmlrTk1GU0RYQzhPai9iaGdR?=
 =?utf-8?B?UmhUWkV6bzIzT0YrUmJkR2dPZWpoMGU2T0x4L29UaXVnZy94SkxGd21aS3RW?=
 =?utf-8?B?OWNlQ2UrSUFkQU1DNUtLdll3RXBNQmhWL3Y4VEJGTFdGVWRCWjNZVUEzVS9h?=
 =?utf-8?B?WmxGejUxZmtQYWN3SDlsWkRFUFBXTXlXVktPSW1BTEZGekxubndQdG5wVmNG?=
 =?utf-8?B?R1JVQmhUT0o1cGluT0pxcytjanZML0JJcnN6bnFIMjN3bktCUUY2VHBQOG9i?=
 =?utf-8?B?RTRPNEt0L3BwOXVNU1VveHdHVEF3RzFnUUtMYnFNL1N6bUFxNXZQSDRxTkRP?=
 =?utf-8?B?SVlEaHZ4VmNBWDdNdldnNktDVmY4N1E2OEZUVWhzQ3EvMWN1QUFiQmdCTWlH?=
 =?utf-8?B?U1dqNUUxMUtuamcvMWNhaEhOT3pDQWpPWjF2TVl3UjFhZTdzZXA4b011RWlm?=
 =?utf-8?B?Q1lFcDZFWDJnN0FPZE54cTFNOUMzbG45dVBVZ1JqbEFWTFNHY0tkYjh0MjJJ?=
 =?utf-8?Q?dhzH/d8lQODaLP3X7mUds/C+9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bPRiNqT4myPRv8WFViITYtY6qkSAxJtJ4ShCDzGYQF+9Rm+5E0LcE1rKq46WqFKrzt98ybt+G0cRcrr2bWW32/WJQTraieAOA3KonmqdOrl3TV5OipFdiHNg0h8oF8flOJSxyDW1ExDyTAgeRV0MT/zHuFisLNWTcB8HKc7ivUuhcuveu9tpmT0LiEbrWnw24nKpJQEvmCjDxfjVIitPR4WwSKX7BmuJA9FtTPcmWQlvAlekBuhjsX73uwQhNuo7MehCS1AGlfCu/p4buCvrqELYuiKG0XQhumDsz1Zal/CwqveKEZyzCs5zGRuXfpQVYbe6Hb/gh3SR/gG3++CjJ2EQVTtshgiYmeIr5fo2U/7fh6qrC6lw1Wklc2L54uK7UkjguVYnOXamK5eNK7HIs+KdLR+SarU4hGqSN/XD6ES+x6KXrKgKvIPY9/Qtt/GKRHMm+HVFGe6ca3kgBdTomcgj438SSF/R+tOcSo/V54qscrXZSD2sziIHt1hbBgXQbkVR8I458emb+ujvz4qzYvrEk3MFLmXFJuCa+BvjfUCRGGDQXstDu1QaXMkCNxT3MO8ZFN6ml2dD7YyJny7KNrOeq7iXSTQr0+baY+FP8NCkIxGbtBr0KdxFYmmEwQ6C
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e9b977-e667-445a-a9b7-08dd945b398a
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:22:48.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdcU7xqBCb90XsaV4ny7SmQJCA1fEfsyomAxXObRBvLRYnGmKUlraNnHpkkv9+09+peWqIQq1z2H1LJqgdXW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1745
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU0P192MB1745.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: QM86WAfwWloMZjSoTkCgoSoOgIu2Bbc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA4NyBTYWx0ZWRfX8RRSNvhShK0G t9ONRbL3RCGpgm5arKkKHmgEcclfLaZ8pkHh2t4UHuJzUFHe2i+KqfL8xM3JmcWLO6lv6Lr0BPz wJt4i8XPBbnaFr4lGoqpNJqcA+UP/yXGf/uNEj64kbz5ozcm/WgvpxkV+qjTpCvJBU04gf1Fqc5
 BiyeeKiPLuX3iSI2Mqb22kCwnQUFO1ZcsnsN3c1CWQyouI6lXeacgq6b2hIU0TC0Dny6nV3g23c baQuWAPv0gSFW7KWbMuiiVccQu6jJt0fzLnIK+yT6UbAkEoHP2FpYRXUOgSuWhYEByv9Bq8zqiL 9h0nHFWm1c+BKXX2WQGIFv1piFQfZ+Rm9rvcSzul6DGynETLsich5twNgIQKlbRAr0O6u5i43zm
 7SKlRKo0PoK4DheSXkjnfrVcH8NOhle5FsbbVUBjns+1UxOunV+k6mlV/migeCkCCHrGd07X
X-Proofpoint-ORIG-GUID: QM86WAfwWloMZjSoTkCgoSoOgIu2Bbc1
X-Authority-Analysis: v=2.4 cv=SJtCVPvH c=1 sm=1 tr=0 ts=682703ed cx=c_pps a=G0dRk995gfaoSGr6a0qYcw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=02BgHTXZAAAA:8 a=1JH1qzqAEujoWz3kIqkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zM26VYTW1YGJCMSE5WE3:22

Am Fri, May 16, 2025 at 10:38:04AM +0200 schrieb Johannes Berg:
> On Fri, 2025-05-16 at 16:15 +0800, Chen-Yu Tsai wrote:
> > > The frequencies 5470 - 5725 have a power of 500 mW. It results in 26 dBm. But I
> > > believe 27 dBm are allowed.
> 
> Seems like. But units are hard...
> 
> The link in the db went stale, but the current versions
> 
> https://urldefense.com/v3/__https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/MobilfunkDectWlanCBFunk/WLAN_5GHz_pdf.pdf?__blob=publicationFile&v=1__;!!I9LPvj3b!Hih48oBC7IPvu59VI1FRTqSb45uwWEnAELFqlK_ubfJdtkTnODDPuyA5gG6olCgbiPxC6m0zQdcuNJ3nzRJ1RJ_PT6ux0w$ 
> 
> states (page 5):
> 
> --------------------
> Frequenzband 5470–5725 MHz
> ...
> Maximale mittlere EIRP für
> bandinterne Aussendungen
> 
> 1 W
> Ausnahmen:
> für Anlagen in Straßenfahrzeugen gilt eine maximale
> mittlere EIRP von 200 mW.
> 
> ...
> 
> Maximale mittlere EIRP-Dichte für
> bandinterne Aussendungen
> 
> 50 mW/MHz in jedem 1 MHz-Band
> 
> ...
> 
> Sendeleistungsregelung (TPC)
> 
> TPC muss durchschnittlich einen Abschwächungsfaktor von
> mindestens 3 dB gegenüber der höchstzulässigen
> Sendeleistung der Systeme erbringen; oder ohne TPC muss die
> höchstzulässige mittlere EIRP und die Obergrenze für die
> entsprechende mittlere EIRP-Dichte um 3 dB verringert
> werden.
> --------------------
> 
> 
> So to be _really_ precise you'd end up with 1W reduced by 3dB which of
> course _is_ precisely 27dBm since 1W is 10^30 or precisely 30 dBm.
> 
> (Except in "street vehicles", apparently. Rail has its own things, so I
> guess that really does mean cars/trams/etc.)
> 
> But given the unit conversions are hard, we should probably just do this
> in the db in dBm?
> 
> johannes

I referred to the following EU Rules:

* ETSI EN 300 328 V2.2.2 (2.4 GHz)
* ETSI EN 301 893 V2.1.1 (5 GHz)
* ETSI EN 300 440 V2.2.1 (5.8 GHz)

The problem with them is that almost always the unit _mW_ is used. And the
reduction without TPC then is given in _dBm_. However, for 5.8 GHz (SRD devices)
the transmission power is stated as 25 mW. Does the EU Rules means 14 dBm or
only 13 dBm are allowed?


Best regards
Alexander Wilhelm

