Return-Path: <linux-wireless+bounces-33375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G6jNHlSumkAUQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:21:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B052B6D70
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C063F309179E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D236A01B;
	Wed, 18 Mar 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="i3EnkJPL";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="hAVGWTgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117436AB57;
	Wed, 18 Mar 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818144; cv=fail; b=Y/WDTrQGMyW3NwyakVOrSNUW9NbGDTQ84f11klixiGwY7aShLqmcABuPFM8M1AyVEOII8phD4JbXQC5GSYMjJeOLou1l2oLDsJTzF0N9ONfopYzD3+LemDrwtL/zKKkqWWS/+GOc6pMgxJhue8xuDHNGKIU/kx2DfxlyxZ0PGdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818144; c=relaxed/simple;
	bh=PBhIjvwfE6aUO77RWvaKkwg4s0Rx+iHbyqe0c8RLNWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hrWiUd12H0eHFHUv1xwrqDn7h8J6GaivUcATrsKa4f2zpSBmP4FsTwhzf79/oE6+7ci65s6HqWGwt+faOn8fEiV5+uyy4Vxl6xV1hoSnmzb8tYGolClTvFT5C1zAouCkshnW89UKXRpAMizNyfor/8X+9FfOMTiNtz9e23/ia9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=i3EnkJPL; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=hAVGWTgN; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I602ZW1158337;
	Wed, 18 Mar 2026 08:15:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	ryVYKV8Xv70R4cwV8avNaf+XvIi/3k6lArECAyWbkdE=; b=i3EnkJPL26Gl6EFx
	z24GBq3DgpkBUYNdVzv8Nu/De5F/z5xobMA7e261L+WW8IrfLPrkvl+F/s7a9fCp
	KwYXU5ZqgMQXGIdGmWEU/XobAI3ghEL5ST2YirI1qHelrtOfxkolFn+QsLIMYNF0
	jfTk+o8SFaMF3GbtZ7DRO0IFfA8qXe1OOr19LtqOGfqvxnyS6IiX+C6/bTaWzjzE
	hk+2w6C6Y9ZuarEL4AOZagsskIU108Gk1s6ZLOcUwBneYrYZeYmtln9Yu9O/V++G
	y8hWx17Bb4eG6wdahlDbiHJsH1UgsoCMsKFeb6RIlqa+Gp8MrWl6qgzAcoj9oX3H
	3tHm7Q==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020081.outbound.protection.outlook.com [52.101.84.81])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cxnkj1rqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:15:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQwlmu8nNo05r6izPIsEHRc/zoX2R8qVGtgmkWw3KXXZ5TkzB/DRVtz8PXXgGz7lHNd1n5VfvbVw0V0J3tlHcAQX0bWvEYsbmqx5+ro33LitUKtExvpprLamdRYHP8ly1cy5FAzY9AZJ9Txdb2s9JcyCWi9+29r04bc2GfCMQX8YeG6wzhnvGd+Kvl+YrYG74eOZmm6KZuHVeaUYx36oA/dlduK/hCyOIGXRpJLJ9cO9AIk///0hJSVdLBYILb2dESfLahGIJOVEgQSA3OokR0N8WTNP4keJ/LKUTQKaF9R0T9Scv5e+MM4mh6pAV1EAXKiVsoDX4s0r8P5TO7l0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryVYKV8Xv70R4cwV8avNaf+XvIi/3k6lArECAyWbkdE=;
 b=sXdT9lfOZY9s/k9SUeq+tyuIFQl/CvJ45d61p/1xT6eJhxmLWd088D5Pt+tPvMJse//7oSeO10h6k7rtaGls8xkGeQf4AHiAnVjiVrZcTyDjvEgSPB8fFyEuPixvAwYdzbPPVTpkoLYw7gPwxqbVuJj1MC4tSA/XcJHYfmPx7EO+Q1moR70WTZGfx1ozv8jZWNGSr0y0wu4cmIa0XEjkAXzCydo2dDx0YZ8RgpyvnuVtq+pMMx3SgTIJ7oePJ7NQPlBksyTxT9EyOGuY6B5ljHhgoD9t89rPBxUoNxYPvl+xDYR10LnzdYWuP3qa/lCsYXPmHpl+7vmtCzKNwXhAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryVYKV8Xv70R4cwV8avNaf+XvIi/3k6lArECAyWbkdE=;
 b=hAVGWTgNekX+MAP2WXYvy4MFTSdWOqVc6hvJ3ZAyF+8J1Ee+5Ky0zMQCx2t6UCc+MSMoS1yiqz1YeM53kAxxPWjel6Bgy99kqTo4lzRHA4bhTOC8iy1W4kNTwl2bRES6zd71W0nDEE9sFNNg81nGAeZAfJqPXg9pMfmR4jzz1uI=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by VI0P192MB2833.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 07:15:23 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:15:23 +0000
Date: Wed, 18 Mar 2026 08:15:20 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix HE/EHT capability handling on big
 endian
Message-ID: <abpRCHDDgrorZBa-@FUE-ALEWI-WINX>
References: <20260317-fix-he-eht-capabilities-on-big-endian-v1-1-e7b937b32768@westermo.com>
 <bd262372-9930-4abe-8917-fd037623ed01@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd262372-9930-4abe-8917-fd037623ed01@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF0002396E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::32f) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|VI0P192MB2833:EE_
X-MS-Office365-Filtering-Correlation-Id: f4acde30-4cb2-4ee7-ac69-08de84be1f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	IbXBhYlz04id3smOTFeUmLwCnHTQXFnkYgAKsOGmQnfIWK3KFFprk5yjLfaf1P+8QuGvdnfhXnNpjuVkSc/KWAFPx7Y+vX0yTfjiNsPcfB5gG82bhG3k0k49MQlAu0evax+4ZLCjHIgayHoVWCdBdMn1JVvfXSjhE2qF3ee+6ghuEygeMOGLV2aEuwpCTLKn4pTJqvU/A6uRhLreLqTeie/zX0qSuNIYNkl7Mj7HTlPn+mUjYXYiwycPtLmMjPe5O8rbKVRs9frA/wl1xY/IkJAcqAqe8TQnpgAunGsrJH/kdaWd3kkZpi7PDSr+0zoNk+k9TBZu1Jcv0N0AZ5RJjXgyxTsaT872lsCyEON8WqlzUgMv1Wac8IBNGROjWAqOUpgMEJ7zehwihsqNxVnEzzU4or7ybh8a/w8rkAlPtyD12gfpJbQcuYJMxSX1taMU4pzmKQZ2dAPyItWOxkFczOmuhedqf56JleupfQTMUV1ltqIEOX5t3Xi4/pMQL3cscOWRc8GPNheARqwdcyfAB8f8yMENP97xakmUkd5w6n99kEGs5R0B6Chy/7Xa0SMqJotFzhYujuLYs3Viue2ybzaajf06sAApHomIQ1s7e3hK5JGbZECIsIYl4Tn8KVX+X+i/TelPknbIGtkKDGFfirVf2FSMIS0QeyvSw1y3nCVD6FFtScIegjMDFlEPmwUkiccK7Ae0iE1TPGypR1/wXdTB+VF/QsAc4rL5wxI5SiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18092099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzJVWEFGdWNxR3U3RkhvVHhuTjQ3WU5US1dETml1dEU4SUxMajZQSENpcVJ0?=
 =?utf-8?B?N0dTcmRUN0lKb1kxdmxQT3ZzclJVYTlDTGxRS05JdCtQODVZTjZQLzRRWnNk?=
 =?utf-8?B?OFhpRVJqQnY1V0k2emtKd0NKVFFUYVhWNnBuRDg1MithUWV5RVNlNXZlcjBi?=
 =?utf-8?B?QWsxYXl0cllvUWR5dUNIeDNEL1JLTkkxN2tvc2NXTEVhUHR1bWxzb2c5SFJL?=
 =?utf-8?B?YmJzeEVRb1BPNXlML2VaelU1Z3c0azNUNldUZUtYVnl0SkdyTWNLRUFZODF4?=
 =?utf-8?B?Y0VlSDlwc3RHNFBEeDBFMzdFbmVaQmcyeEJvNTV2cDZ1QlNZb2FLNjZGa2dP?=
 =?utf-8?B?bGhEU200RUM2YW56dGZXMWIvak82cWpydzZIV2hwT3pDT3NYWGhOOXRxUUhp?=
 =?utf-8?B?Vm1xdy9iRWNCaE41SjB3K3JHa1gza1I0WXRBM3VzNFhLN1VzN1IzNDViNElW?=
 =?utf-8?B?T3pRRDVKRHAxM1RDWmFIVkJ2SCtabHZqdGFURTBxbUtjSGliN0VESklYSmRt?=
 =?utf-8?B?UW0ycGhwbWFVbDJtY0lIZzJFcTkyVUkydW56eW9XVUUveWl5WFpaUE1TWnhX?=
 =?utf-8?B?Yk9MaHZZOWd0SHgzdFVZMlJvSnJqMWpwUktMQkFiL3UyRG1uZzVkdWFRdklk?=
 =?utf-8?B?NDhINW1UMDd4ZVRMM20wZDcycjRPYWtOSzhFUHRJYnNDOU9yWU45OVp4bjhx?=
 =?utf-8?B?b2MwWlRGL2VlVnFsZXJXV2huUlQrOVhmY0JYZXdPUGdsZ1l1bDlHN1BVZ0Fw?=
 =?utf-8?B?WE83eEZDdVlOQWpjOWg0Vm15cVJKM0RRWWEzdk9YN2YwckVYUCtlWEprWG84?=
 =?utf-8?B?dGIxbDFEU1VJOVlZaVFicng2eHROT0tvWkJxYWt1b2ZscEpDM3lQSUVLcWU5?=
 =?utf-8?B?cEZIb3lJMU1RM1Z3VXVld0FScmVLaEZaMERMQm5KbnVucUhjeW5Gdkp4RDlB?=
 =?utf-8?B?T0RiSllFT1h6NXhsbjV6bTFybHprOExjN0N5bzBWeGI1RS95Y0xsNnIxc3Jx?=
 =?utf-8?B?eFhWU1cybCs5VXg2ZUIxUmVqR0laSzVwcWRBOUVMekJzUElJZUoyblpjV2ps?=
 =?utf-8?B?S2VRNm1lcmREUHoyVWpvWGhaWEQxZW9Bdlh3bC9yam15V2hIUjk1VWZFQlk0?=
 =?utf-8?B?V3pnaFRIYzV0MjV6MzhjREZralJ4aGNERlBPeXBHdXRuK0tqTTc1Uzl4M3ZH?=
 =?utf-8?B?Q21tRGlIR1lZM3BHdmxFUzlzblVaOEhqbXlmVE82cE96S3ZZSlVTYUJDVVQz?=
 =?utf-8?B?dGFKbVIyOGVaR2dQQjVhM1BiL0k1Z3FvTUNUaGozdEVRMGx1UVNlTUp0OURM?=
 =?utf-8?B?U282TkxaUVpGSzBzejVCS0hMWjBKVWcrMkFGVzYzc2NYM0RURFBKNlFaQ2M0?=
 =?utf-8?B?WlF5bkNjVVdqa0Uwdk02T3loT05yQUI5Qk1pM0tzelBBdUNiSnZKdkdzUHZR?=
 =?utf-8?B?NkdIdVA3L3phczhZL2FkSzVwN1J6Sms0RzlFbEJNRFVTalBGeCt3ejB5WXRG?=
 =?utf-8?B?dE5NU1l6VEpHbzRRL2VrWEdhd2F6VEVmd1UvQlVqSmM2cFFuTkp3OU5aVlN3?=
 =?utf-8?B?MEluTGdNOFcxaXNONTFvUkZqN3FDVHNqTDlKbEQ2RlBtOHJUOFBMTkcrdkhs?=
 =?utf-8?B?MVpmU2FmSFpnVE53dzZubmxQWDhWOG1uOU4rbDIxQXVsZlZ3ak9VUzVLR0pY?=
 =?utf-8?B?YTI1NktFcjRTWjkwc2VEd20vUUF1MnMyQjhsZ3RjT3FILzQ5MktXaVViQ0Rv?=
 =?utf-8?B?VnpINnZJa1k0ZTZQYTlFSVdaL0pCRVdpc241MzRNZzd3dEUzRTNoSXUvOEEv?=
 =?utf-8?B?ejZ0UmM2Wm9xUU9zL2lVRnNMMVc5ZW9hMkpuY3RuZjJUZzM3NUVkM25oUmVY?=
 =?utf-8?B?aXAwQzdISlJOdWJ4R1QxNmJuc1Q2aVlyS0UxNlRIc1hTNUh4MldpVlZZdGhM?=
 =?utf-8?B?SGpRdTFxR1Q1Rzg4bGx3OVhtQUNlbzdTdHZCU2xxeitkSzdUVVFzc3JVZktp?=
 =?utf-8?B?ZVJoYldLT0F1cmc2eUV3dEQ1Rk1qRUpMNm5FUFBiVk53OEI3b05meU9DNUtG?=
 =?utf-8?B?NU03UTF6djhTMVdkLzBkZGxyaUFZQ3lhUGxjMW5uZ0FSSHJpR3BoRk12LzQz?=
 =?utf-8?B?dnVRQytxT2VXaUtxMWhYN1B4SHBORnFSMmJXaS9sK1hsK0lzVkM0dXlUOEFF?=
 =?utf-8?B?ZGpUZGJzUGFISW9Ic3NUNWkyRG1GRWs1MmpjM2FwSGpvcVgrMDVwVWl0RHUv?=
 =?utf-8?B?MEZ6YXlPVG1qQWNIR2RXSVFBK3d2Yjd0bVZtNEw4TXpMNkJ1TGVNcWlaM0h4?=
 =?utf-8?B?MHpqT0t6OFQySUhzNjMwQmxWQnMyaHQvN25hYmsvOXJROEh3bUxIZz09?=
X-Exchange-RoutingPolicyChecked:
	B0FYLeOXUY4Ba0sDiGT+hpqbq/ZfhoQcR1Ogrr4Z+/T17jRfm8tvaxqLbbBtiqtAsnRWdQeEN1pqJH+b+rboqv1yswqggmbLrHuNB1di+cDQLbZ+vKioVgUByo/ZUF1rCFKbZrLj7qTSlLaEeDYA9FMGNeGGU8F/lxofqcfH5pRCtPOqsIei0b8dVj5WKTamfBV9qF+A0AAoCLtTZS6DgIyxxDpKh8wdPoJtkJzEf4bUEFSocbXOLB86ran6AIHezT5AdYNxO5Cii2Ieq0Q6F1lF9VKmFEJvOFGvbo49xfpr6I1ApuCsLzvsGd+RbuvM34VMwg3Lv0/kZ3VXLsPMBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2wP3UcrCfMJNG/tmhvf/3GJsfIZNX7DeoFrY+1wZru8yzVGvCAGRvFNMoAus3AeiLirt3q/Ejbp1TjCa5Be0i0cMmFDta1q6g+c/s2UjskDLaXOCMohk9XyOtol49dfVEDivAIJMMa3JgCZeCbOjqHKu8tNWgAyCIzoIWrHrBz7vHpvr6Lb56oavp6rX6BDBsJHxLUuBWuBUingpSAkTa55J0fkJ+t0z2phllQw9D/p8z0LnOAHBK3FtaTfGG9dsP9+DuLouSTirpQeUm4PFdokILeDUC0azzKnL+wJ4/bOKL8Lxmg0ARzJN/f9K9gd38x/ZkHw64wfGATSqGvjtIwDabYHXjtdbb2VyP+2jIg0PTytF016AIWoT/GAQfz6HA1rFb7uGGfeHCNnda47sU1ONlzP2Qph4Wu/JuJYgnoS8MTs36yJYL6ZH/6+Yj1zbMHyw/C42p9lulsaL6Cy1DFQF2411NaZ06vTmJs+SYyWk17UweSJpeBR2XDvQAb9ddwkpDZwXUj/xOkg/Rn1eZn+Y81zMetG8GrqlgkvFDwOhhDJjNerbM2AgcRzxq6OzAXm3XM8d7VOtlFiu32jvDdrKdpuKuiiyKXaH3q0nap9Bnlpn0rIpV2K7IPUbz6PP
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4acde30-4cb2-4ee7-ac69-08de84be1f23
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:15:23.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8/+z1aCAY9omrcym92jlxV15vncnPtblrTY81wPCVA+3Z+CHvsg0JnyYiT9Ge/iLDgPH0/TKfzqFIn9JReczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB2833
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: VI0P192MB2833.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PO8COPqC c=1 sm=1 tr=0 ts=69ba5110 cx=c_pps
 a=ftZSLPtEb78rP1Exs/vLAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=0E8yrLkJ4B81AYfMwHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: oKRBoriiqZ4CcMGq7eDwU-6SUN6958-e
X-Proofpoint-ORIG-GUID: oKRBoriiqZ4CcMGq7eDwU-6SUN6958-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2MCBTYWx0ZWRfX4IcPNNVSKJcB
 /8v6DVGzFbfipts+fSzULISN/NPO2B0RnG7LpSsv/yFef3l8Iu2gbWLMn/e+r/5UVkqfglIZEpz
 WcYFbQYDzKQ+nzS+bI/TGIyKlLMp6vhovAwHOGNvoK5IhBGrRxQSezRID0aExjwKA7Y0ZzUPkmx
 S38OzxOpAuEGFdZD8x7TRMVTR0StI/v3ZiCtNRW4ftmAtSWCcStE0bgkCi9s3ttDsxgA8bFbyVu
 r7MyyZuhU3/hQveCPTwSJyCdV+RCM3aeEboyBWz459Gm15xUYFDk4OSHN65O6quxw78I01Z6L+0
 K0VCp08NNGenupI99xJW7DZGRdkZYdTZG5Qj38LPBM9YdxdJfVnqgziC4qdVdQMwJ76IZf8wWjs
 4tiaS5QyIZ9058aGNLenMZPJlS8K3Nq8uOWRVnrvHakRJZLPLFiWSkgDkNwYusH8iC+3ZJJhvLz
 KucxzKZpTvfOOobEUKQ==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33375-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:dkim,westermo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 55B052B6D70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:17:43PM -0700, Jeff Johnson wrote:
> On 3/17/2026 3:59 AM, Alexander Wilhelm wrote:
> > Currently the driver uses u32 data types for the HE/EHT capabilities in
> > CPU‑native order. However, the ieee80211.h header defines these fields as
> > u8 arrays. This causes the ieee80211 registration failure on big‑endian
> > platforms, as shown in the following log:
> > 
> >     ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
> >     ath12k_pci 0001:01:00.0: MSI vectors: 1
> >     ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
> >     ath12k_pci 0001:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
> >     ath12k_pci 0001:01:00.0: memory type 10 not supported
> >     ath12k_pci 0001:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x1005 soc_id 0x401a2200
> >     ath12k_pci 0001:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> >     ath12k_pci 0001:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
> >     ath12k_pci 0001:01:00.0: Invalid module id 2
> >     ath12k_pci 0001:01:00.0: failed to parse tlv -22
> >     ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
> >     ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
> >     ath12k_pci 0001:01:00.0: failed to create pdev core: -22
> >     ath12k_pci 0001:01:00.0: qmi failed set mode request, mode: 4, err = -110
> >     ath12k_pci 0001:01:00.0: qmi failed to send wlan mode off
> > 
> > Use the __le32 data type for the HE/EHT capabilities instead and avoid
> > swapping, so that both platform endiannesses are supported.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> 
> With this series applied I see with make W=1 C=1:
> drivers/net/wireless/ath/ath12k/debugfs.c:413:65: warning: incorrect type in argument 1 (different base types)
> drivers/net/wireless/ath/ath12k/debugfs.c:413:65:    expected unsigned int [usertype] v
> drivers/net/wireless/ath/ath12k/debugfs.c:413:65:    got restricted __le32
> 
> From existing code:
> f5c90ff80b4c0 (Sowmiya Sree Elavalagan 2025-01-30 11:41:04 +0530  413)  extra_mcs_supported = u32_get_bits(cap_band->he_cap_info[1],

Sorry, I had `ATH12K_DEBUGFS` disabled when I ran the sparse check. I’ll
fix this in the next version.


Best regards
Alexander Wilhelm

