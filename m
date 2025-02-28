Return-Path: <linux-wireless+bounces-19601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0CA4A087
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17443AC80E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB91AB6FF;
	Fri, 28 Feb 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="LwV91hFA";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="SMzfCDCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC5276023;
	Fri, 28 Feb 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764051; cv=fail; b=T+PgRRmyC1OtxcSnni89uz5ZlFW3/HB30285BvWYad8QJ92KpEOe0MV2yXBoI64ZpLPTs5B6xNPP/UL2/TyJWoUIjv2fJ2qZBGkEzFvSh+A2jbt9r/ztTC/Jd0u6shTqEeLPTRoPYBhl3CSZieIiERWvSRTIhpc8gFqEvaLJNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764051; c=relaxed/simple;
	bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jF1XsuottxLQ1FCmRZvMnl7vfQqju5Y8pv0j8Xz6TNcHkiX6025pYY8mohvxmJUGrlxCk5UGPzO0WNnLD7dMxSfg8stsswbjPgkFKmaGF6JemH/0mhII49K5JCBwA2PhxIMO370zuEv8gd3cupe1GGTtU01g9lQGgagXUOcdeUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=LwV91hFA; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=SMzfCDCI; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDK2j2012530;
	Fri, 28 Feb 2025 11:15:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=; b=LwV91hFAnyd9
	5V39ac2deVuikZxP+gnFvNi5lrMrgXYGXNQedam9iXx45i77FIPu/z8ZsNzNrsyi
	AqNGMYTPkzl0ynKnBCetgHAha0QQ4k13e8wYjCBqcdZ8yytMTh5HpKSwFoh5MVKo
	/R00CpELWEyN+eK5uKyBgPe/EbOsqrkQS4Vc3dS5zRszo0pUeGWqOrHYA6T75VoC
	zvwt5V9GC6veP0VuEKh410MIRkHow3cS7GR7phzyCYOTswVsR65VLfRqTcFZdj3R
	lZGNRyvokCm7EXgJLFBq5qWiO3L9dUfEiCgoIp2fbGXLcgfyl+bfAbuOVd7EKVjO
	DoiyfTPU0A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbruje-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:15:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9PxtQZWMiv75dZ6pm0uG5hXzBVR/pUUX5g6vYoDg3oWb6N5+9IwpxNKRBCUdBObMNQVqyI+XVEZHHVKK13JYXyr+xvAAWGD+XCxJ9lpQUofhsRz0yrQH7dgeVknanFnT8z2Ce9ngTdl9An8MHv5V5DTbm74yfu6MwllPAxnu+FEMPOygrLSt5+b9rU0ScLTB+lcbUabmTut8PWOK4QaX7mvd60C50dgNjnpHETUcDwbcmsb3oYZ1123GNI4s9SOCFhR+QfUo9tG6egjGTQGJ0IXqyuCmws9VA6Y4+Wf46FXRvnzw38kpfv9jqn9I3QHm6GHSFcaQru1qqM6wewMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
 b=WMHoA1DIjkDdNzvXTb2WvskES8VXFYL7cd+zkzlmDWUGSW6YWuLIE8TnSLlUslb9CLXIWiXBweNW2/MHmfklwasqR+UlP1tdEJK5VHmVMBrVg8KB6NpYFR77E48qU1LM3/CMeSqBLn4sb8DAl3VB2KkyPr2+z3WPKY26pQsaZaVBEs2fpZjs8R+TPWkoU1Q5Wxg0SpPKl8X+18EqnEnkMo93rNXONZ8f1YSPA/fRUd2pWPIPmEUCMZf0psfk9z8ouSi9jRtU6j5TOC2zDBNOkHZ1irgi87F5CnAalpmLZACcGNgrIQNpADcZ3IGiE9lfsYj0vGmMbq8cZ+b4MfOIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
 b=SMzfCDCIGWNcti3Z0LpxmUc/Yq7efwk3WST7qvOs9f2ITQxhWsLWGFbiIBvyp7/lfHVDEurlnGp8o/Q9taBusH5c6lPxNxTgoraekFpust3YrJ1bHkBC6CkyFPGAI1wf4ekCHjUPsCaO9PCeEKSjzgnuVHKFuL7Yx83Y9a30oqQ=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:56 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:56 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 3/5] wifi: wfx: allow SPI device to wake up the host
Date: Fri, 28 Feb 2025 18:14:39 +0100
Message-Id: <20250228171441.109321-4-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228171441.109321-1-jerome.pouiller@silabs.com>
References: <20250228171441.109321-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::12) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ0PR11MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 62684c77-4fe0-48f4-3553-08dd581b6c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clppcnB2ekdPTVloMVBxVElEY1I5R0tucDdvdGpaNDAxb0ltQ2lkdml6WG9M?=
 =?utf-8?B?bVhGMGFNS2RSWnhFamZTeHFPMlg4Q0t2aVlFcXY3VWVpMks0V1hya0xxZ3A3?=
 =?utf-8?B?cXVVTWJXQlRUQVpudnVFRWVwZG9FUS9rVUVGblZsVXJKOWNpTTdLZk9kVU9h?=
 =?utf-8?B?WUZiaUlBSzIxSG16S2NZREZKd28ybTdWRnN3K3p2eWVDd2djUHN6OFBJQlNk?=
 =?utf-8?B?VEZmRGtGUm1aSW1ZVDQwZVRJYzBLQXdwSjgrNU1lbXIrSWNwL29sbjM5OWd6?=
 =?utf-8?B?MnBlNFNXMnZHUG5PelNGT3ZLbEhONnowUnQ4dWtHVERaZURlYmxaS2lLS3RW?=
 =?utf-8?B?NlNyQk0rUVhZOFE2UkdxQWJRVENld3FpVVo2OHQ1cUdSRjhpa2owa0ZLZkQv?=
 =?utf-8?B?dmJiQjdJS2ZXMjFDWm5kaktnTWRkL1dBc1kvcWtVZnpxL1kyUmdpSVhQbEk1?=
 =?utf-8?B?cDNicUpjU2d0STJLM1lxTWJWWVJtLzRRQndaV0NBaEIvVXZPdG1VRjVOaDRh?=
 =?utf-8?B?Z2FYY05Sc1F1L2t0TXZ6K0lLZTJsNmx2NERsK2RmVlgzVmFvTDc1cVFYZ0xq?=
 =?utf-8?B?ZDVqamU3MEhXQWw3cldIY0kyMDBHNHRGTUpxUzljODQrL3ZWd3NPeCtCYlFh?=
 =?utf-8?B?N2Jrb3VJYmVXL3BuMTVkL2praDZmZ3k2VmxxcE0rNWJhOThhTC9PNG45dW5W?=
 =?utf-8?B?YjQxTHltemtyVFpjQWw2Zlo5QmM0WVB4V2l0MGpNQmFTVlBRZXp3eHB6ajBK?=
 =?utf-8?B?ZUIwMWdXcHBISkZLbkVLWGc0Sytlakt3ajgwbkZ2U2srNVhuYnNTbW9KaTBM?=
 =?utf-8?B?Q2VzYnZIM0E1clRXNWdNUXpVMUZ3UGJpUUlrN1ZqQklCQTJCK2FtMzhtaTJV?=
 =?utf-8?B?RWNkRVZRakQ5aDdkbjNLV3poOUk4NWgzSElIT01pVzJCZGZzNGEzYVJ1QUlt?=
 =?utf-8?B?R28vL1M2VTVoTHBpbGExb1dYU0YzbkNHcUZKNVZ5VE16ZlhUNzNtaWVlbDAz?=
 =?utf-8?B?OFJVMXdQWlhIYXBXQ2ZFcnJFdXhnSU83UzZsTEc1bktKeDh4a1pKaXJIU1Q2?=
 =?utf-8?B?a2w2dGNiNkhyRk1FZXhSMGdqREdRVHc5blIramgrVnVXSU9pZ0dLQXdFUmFz?=
 =?utf-8?B?WTRGNlZwZTJSSitEWklaaHBTL0xBc3Y5WU1Jd2NFV2pXLzk5ZTZubm01eUJh?=
 =?utf-8?B?R2VkMXMxaGM4UG1lZHg0b0JCVlFnMW9IWkpjb2lLK2ROMUczZ2JxMHZLbUlQ?=
 =?utf-8?B?YzZGZzJZb2s2L0d2NEE1L0YxcWdtb2RIVTF6RG1ySldYazliZzU4TDYrSnNS?=
 =?utf-8?B?ejdzSXlweFhZalorVE5GakJob0xaa2RyU1lNVzNTdUxxajBhSnVBdURNUVdE?=
 =?utf-8?B?bFJsUjFMUTVZSmh1ZEdEZ2pYM1g5c0FnMlMyb0pwQ3prRVBPN2lIdSs5RnV0?=
 =?utf-8?B?WjNmMnpqZmk3VjZwQjFDS0tYdm92TjlyRTdVd1RYUUFQYVFIUE5WeHl6eDlB?=
 =?utf-8?B?M2dSWnhlTm1tNXRzN0lodVJsRHpZRFFjUGxkM2dzVGkrRlU2RXQ0RGZPVTgx?=
 =?utf-8?B?SmFFWVA1MXFpclJDMDVwTms1RnFVdmhaaDRtK3dpc0Vxd2MydTFXQ01jQ0ZT?=
 =?utf-8?B?SG5HZFl6SUxuVHNibWJ4RU8zYVBlVzJOWEd6UFZ0bSttQXA5MUJwOVlHL29s?=
 =?utf-8?B?czlneWhwSHV1VmVQa2VKY0tzUVE4NmE4UWk5QWd5c25BS0tUbytuU3lpd09z?=
 =?utf-8?B?dVdvUlc0Z2E1cDJKbjhaaW0rMUJab3I5VWtFOHE0aktPRkhoTWwvanFzcmlj?=
 =?utf-8?B?c2kzRVpPYXlFQU43dW9BOVdFMFUyQ1U5WUhQdG1mSko3OGNNOUtLeVlnSEZZ?=
 =?utf-8?B?ZW9qTlpNK0FwbldUbjM5VWVXaG5INXEzUzY5ei96ZkxwNFYzZTYzSXU4RE5I?=
 =?utf-8?Q?wfUJWwNcSBizmIo32Fe/BfN4jBprkIMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThJMjhnSWVaV3JiTlFkNktjWkJIOTZtdWZEbzBobms4Q2xTUmxoOThLQkhI?=
 =?utf-8?B?Vnk0VStNd0g1cU9Ld1VjQWc4NVJTdk4yYk5Yc3FRUGFiWnN2cGhrYXpNSFZM?=
 =?utf-8?B?aHcwYm9tMmpBcVdhcDRaMERUZnhab0lSbXJXM2wxZW5aRytVRmIvZ3lNWG1K?=
 =?utf-8?B?VXpwK0xCeVpmeTFBL0REazJENFdZTjEzNDFycWtkb3ZJcXRrTlRmUWQzUThQ?=
 =?utf-8?B?R3RFNXRyT3BVRW14cUc0d0VVeVJob1dTTzBudE84V3BFTWZmRU1NSUgvTGUz?=
 =?utf-8?B?Y1RKQXBVYzVCVEVKOW1tWExsMFZZNXpZUVE2T0xtb1NaSFdSUlNoY3JyRG45?=
 =?utf-8?B?Y1BPS1duUzkxYUJhZ2h6dWxudnduam5xRllxWndLS2NUaW4vYzJUVGxnOHhD?=
 =?utf-8?B?SlppZFo3cDlLWjJ0MUlyQStOWWVhUkhhMDVON3RhY0dPSDB1bzJuT1hzY0xP?=
 =?utf-8?B?a1p5dXY4N2FGUXJSay9GaWx4eUZxd1FzeWIrZkxsNmg0ZzlwVEwxL204R3Fl?=
 =?utf-8?B?VDFBdDIybklWcEhPWmU1dEdCTnQrcXNYWDhONitpVzlBQUQ5QkR5ejFTUHVn?=
 =?utf-8?B?c1dQZTJwd1NudWc1cDJ3aXR3Uk5hYXVyYXRCbFBLcGl1SEhQanp1bVUwZjNV?=
 =?utf-8?B?OEJrVWNxV2RBQWd4bktQWWdaejljR01UZTZhVTlvUTFReGxTMHNEb1VxaWsw?=
 =?utf-8?B?WDN3ckhPWS8wcVJHRkZuN1ZUemNZLzBpUFE5S3FOTkZ4cW9Dc3ZFWGVReElw?=
 =?utf-8?B?UDc0MXlxQzVncU5YNEtJNloxcG52Qjc4UEdiYmhZYWR1dTJPL2R5QW5qQkNS?=
 =?utf-8?B?eVdUVThrS0NDc04vSDFPbjVOZ3RVMC9pWDZhUXpVdWJtdmIxWnNYekRNUlZF?=
 =?utf-8?B?QmVZR2kxVDNvSVk0WkFPU3VVMFlETHpUK0VqaUVPSWlpVUk2eno5WkxjR0k1?=
 =?utf-8?B?Q3hHSnZkT3RoM3NGeU5LNjJka2Y3NzczcXd3UTFoQW95Vmw2ODB2Szk2QXZp?=
 =?utf-8?B?YUJ6SlhpQ2JoU3p4d3EvRHY1YTczMUp3WHZaM0R2bWlnNzJJS3laeEwvdjNU?=
 =?utf-8?B?a0RXUmdzS3gxdURGS015ZUtVYWE3Y0syRS9Bc2RESE9LL2k3SWRZeWtsaWhT?=
 =?utf-8?B?M254QUxmSlJXeVQvMk5kTkJudnA4ZG4rVVpzS1ZGVUlQRThzb0d5SjNjWDZK?=
 =?utf-8?B?dXluWld0N0s4Z1dwbWVFMHVyWFg0V3VYb09NWldvbm9iNUlEQUl0dUZmVGxS?=
 =?utf-8?B?TnNrWVF3UHM2SWcwcUl1UDJJVlQ1a205Q0p1Q0NwRUpKSFVYbm00THlNSXZM?=
 =?utf-8?B?cGh3NGxvVEJoVVNsb1RiUUl3bWt4NExBVjQ5RUpBMXFtcDRPTGdVUkxjTisx?=
 =?utf-8?B?d1FFRVpSWEsyK1pwd3Zyc3U4TENmbUxxUVIwT2dYZFZKT1lLbFB2bHVrQ3pJ?=
 =?utf-8?B?Vks1d0pPcHQzR0liMWtmMURMdmF3SGJ6dTZKOUdsaTlrNkZ4dUZkNDBieDJr?=
 =?utf-8?B?U2JMOEhwNytSc3dQeWRVMEtvWVZKZXhzZDB6UFlIMVNGcUV2TEJwVllQYUVh?=
 =?utf-8?B?V202anpxT0wwSFg3OW8zbnJCTi90eHhPYm9lUkF1SzVlbmFkYmRrTnJwL0hL?=
 =?utf-8?B?T01Va3RHNTVMYytpeHQ4cVFadHFqSE5aNGxYdkxuUS9IZFVtZ1pUeFN3Uks4?=
 =?utf-8?B?TGJyRjFucWlkdmsvS0ZxSDl4ajBtVlpDZ1d1OUFMbjR4cHovM2Z6QjErVFpp?=
 =?utf-8?B?aCtHaERSdk85ZlVxdjJNa1M1VmMxMk8veHE1ek52ZU02QWQydXlPbnJnVlJX?=
 =?utf-8?B?czh0ZHF2azFQdTR5MXZ2czRMbTRYbWhrQVAyNjJOSlRFZDZwTjhjcWZ3Mk1L?=
 =?utf-8?B?cUxRRVd6YmVaS3hNWmtobC9kcStVYmFLMVpXcTJWMXFRaVRHTnYrSjVMakZi?=
 =?utf-8?B?Q0M0dUpVTXhrVldTaERkN1JLZ1JoSmVvVkdEc2U1QXlsYUV4U3pxZjZFZmxn?=
 =?utf-8?B?NUtibkszd2NBeTBLS1dGZ2dnUFkvL1F1dWhOVGZydXBvWDBEL3FuTFF5VlY1?=
 =?utf-8?B?NHUyUzJjSXY4b0xQOG1NeVVxeUlRSTRPK21zSXBYMmx6Yno1K1BrUUNxZGxX?=
 =?utf-8?Q?ZPfAjHYKXKBEYqLevE4u3sCPW?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62684c77-4fe0-48f4-3553-08dd581b6c6b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:56.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1VrvFU56SoiRVSIa5Xd6sOpyd0hIJy+opa30Q30lK1xIwoW0tnV9hBFGi1fMt02NJfUD8sRhhSy2ZXaY8PIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
X-Proofpoint-GUID: 7Q8aN8R_2U8TmTfEelB1oU4H4kkOAzAd
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef16 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=y8Il-FFEXRI_uRj3CQYA:9 a=QEXdDO2ut3YA:10 a=SRgmj7pJOxBPWxSGtsjD:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: 7Q8aN8R_2U8TmTfEelB1oU4H4kkOAzAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

V2hlbiB0aGUgaG9zdCBpcyBhc2xlZXAsIHRoZSBkZXZpY2UgaGFzIHdha2UgdXAgdGhlIGhvc3Qg
dXNpbmcgdGhlCnVzdWFsIFNQSSBJUlEuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxl
ciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9idXNfc3BpLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDQ2Mjc4ZGNlN2ZmYy4uMWQ2YmYzNTI1
ZjRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGku
YworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYwpAQCAtMTMs
NiArMTMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4
L2lycS5oPgogI2luY2x1ZGUgPGxpbnV4L29mLmg+CisjaW5jbHVkZSA8bGludXgvcG0uaD4KIAog
I2luY2x1ZGUgImJ1cy5oIgogI2luY2x1ZGUgIndmeC5oIgpAQCAtMTg5LDYgKzE5MCwyNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJ
LmFsaWduX3NpemUgICAgICA9IHdmeF9zcGlfYWxpZ25fc2l6ZSwKIH07CiAKK3N0YXRpYyBpbnQg
d2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqZnVuYyA9IHRvX3NwaV9kZXZpY2UoZGV2KTsKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMg
PSBzcGlfZ2V0X2RydmRhdGEoZnVuYyk7CisKKwlpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRldikp
CisJCXJldHVybiAwOworCWZsdXNoX3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwlyZXR1cm4g
ZW5hYmxlX2lycV93YWtlKGZ1bmMtPmlycSk7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3NwaV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBzcGlfZGV2aWNlICpmdW5jID0gdG9f
c3BpX2RldmljZShkZXYpOworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1
cm4gMDsKKwlyZXR1cm4gZGlzYWJsZV9pcnFfd2FrZShmdW5jLT5pcnEpOworfQorCiBzdGF0aWMg
aW50IHdmeF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiB7CiAJc3RydWN0IHdm
eF9wbGF0Zm9ybV9kYXRhICpwZGF0YTsKQEAgLTIzOSw3ICsyNjAsMTIgQEAgc3RhdGljIGludCB3
Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQogCWlmICghYnVzLT5jb3JlKQog
CQlyZXR1cm4gLUVJTzsKIAotCXJldHVybiB3ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlyZXQgPSB3
ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJZGV2aWNl
X3NldF93YWtldXBfY2FwYWJsZSgmZnVuYy0+ZGV2LCB0cnVlKTsKKwlyZXR1cm4gMDsKIH0KIAog
c3RhdGljIHZvaWQgd2Z4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCkBAIC0y
NzMsNiArMjk5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NwaV9v
Zl9tYXRjaFtdID0gewogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgd2Z4X3NwaV9vZl9tYXRjaCk7
CiAjZW5kaWYKIAorREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKHdmeF9zcGlfcG1fb3BzLCB3Znhf
c3BpX3N1c3BlbmQsIHdmeF9zcGlfcmVzdW1lKTsKKwogc3RydWN0IHNwaV9kcml2ZXIgd2Z4X3Nw
aV9kcml2ZXIgPSB7CiAJLmlkX3RhYmxlID0gd2Z4X3NwaV9pZCwKIAkucHJvYmUgPSB3Znhfc3Bp
X3Byb2JlLApAQCAtMjgwLDUgKzMwOCw2IEBAIHN0cnVjdCBzcGlfZHJpdmVyIHdmeF9zcGlfZHJp
dmVyID0gewogCS5kcml2ZXIgPSB7CiAJCS5uYW1lID0gIndmeC1zcGkiLAogCQkub2ZfbWF0Y2hf
dGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3NwaV9vZl9tYXRjaCksCisJCS5wbSA9ICZ3Znhfc3Bp
X3BtX29wcywKIAl9LAogfTsKLS0gCjIuMzkuNQoK

