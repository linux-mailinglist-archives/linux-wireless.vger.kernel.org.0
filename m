Return-Path: <linux-wireless+bounces-28933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A586C5936E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7644A6734
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4936CDFC;
	Thu, 13 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="K6sq98P9";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="UpQbPWRF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF636CDFF;
	Thu, 13 Nov 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053366; cv=fail; b=sZWNT2Q9KnOmkPhmbig9U06U3u8W/+78P2IaqkQTXOw0+ueGS3nZvyFOtO+2ezpCrdowwKPUfwrO+rZtoAoqwH3Xk6HRUUlbdWvPJJkckjALR4EcpiYIqkiSEBW7ttsAP9DiMggxxCUDAfbxxSiARfPNUj4CNrZEDCdmc5jgzsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053366; c=relaxed/simple;
	bh=d0VHDUlWk9090Ux2zhh2+HO9dtnsKwAqQIkQLO/LbTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D1Rt07KvwefY4oUt6vwko47o3emPiukFKoyJHdJEzLMQNhgxM2yPG+Q+rzTwG8MUQXZw9FLqCFjPEmzu9z38/U3VKDmLAWa9uammgxZTEqhdTXojhj5YqdodULTFYNwT3dP1rb1yZFfL1Qeh1s+x8caRMZmtepqWKV7+Dgd2IL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=K6sq98P9; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=UpQbPWRF; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADGRTmB3076402;
	Thu, 13 Nov 2025 10:57:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=tfUdH4MBPPkc85CIyPONKXKTpiCPvkT9gsCVaOQd9ko=; b=K6sq98P91qBQ
	rWcQwb/flgzqBhv1LtfFgl+2eU3+lfEZIIWHipHhBulCBCxHBqYAxY+3U2NZS0CZ
	Fen8hC/LhigcSAuiCLFb+ebhaSdxnpq27acmKjcWfX4wxHdTz/B+d3Ua2vmLdG0t
	BCbZOzHItez2SKO36axyc1wOeWIYSQOGJ+/bJJ2Xz0++QmLcAAXHfpwHbruQkRcu
	QEGe9Luj8tsyZhlM59HDYVvZbsevhktYpw6YenTLVl1ob9nsMaWRYqFJ6o/1ypr0
	hg0kJzGsgLoURzAYkWznQ9/c7MnzKWe2R1o3ktB9aghWHYyg+Kn9XyldkRs5MCND
	oyLTaV79Yg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022083.outbound.protection.outlook.com [52.101.43.83])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4acuvrbcbp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:57:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOhAOnWB/1d75Hgi9Pd29jNceoLSDAHLwO4nSv9MRwKDVJsPNyOpKktboQFTfD0U+VMehxhRMjremD5uGPgdYYagw38et5jmRZ571JxOFMcuIytDRptoKTKTCbLNtMWGp2CNWEwVzRA7lIM+HdyCrrajHVTs5SWWfwR075RxDx1UFWo9Z8KKIZy1kvhfH9yuIxf2NW6mTXD1mpRwdpdzF7EtXn7iZHWQV+nfj3LE2gEN097a8B3vGn2ksfgNh3VD08Q/0hRcDDMobmu4qqzLtZEqCUOBEN+r72hSInNj6sQLN083xkV2Fi3OaGlVm+xtpIB6UL2jLE82teahrDAV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfUdH4MBPPkc85CIyPONKXKTpiCPvkT9gsCVaOQd9ko=;
 b=cOX8AD9W5g+mWPOqrmCVVhDNBnzFoM86oR6ftd/RHXh38Hzvl2DTNVOAPro7XtLV+hKRsCjbCJXlXBB55LyB/M5V4PaN+aRYCOy0wVDICMBliOSsbHkVKaPK2tXOzgemZjsETY4RjjbP705lqkyfPGzZsPH48JNcwvEhc5IB/pr36D1tv+9j9tlJNcWeefxMlyfYJZpdoVy5infd/W7I/82hd/Yhjkh7jgzFLBF0QMwawoCk4ZFVTo0z6BZhNYF0u4nePNZ6phsemfD7uARspfZUg8Pamt0zpIn5eVoVmYuvvB528XxAArSRQPhLlKva+GSQ3FiY4djOB8cXgQaCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfUdH4MBPPkc85CIyPONKXKTpiCPvkT9gsCVaOQd9ko=;
 b=UpQbPWRFRopG5ZXLy4wJ2QoAMVKp4YL8dOi9Y6DfkoR9xsWXQ8xjQ822bxXWFpchEHN7zWIJdzm3FPVxyuQ3r20gikWiWTW8/kuT2P1FX6RduB2At1jfha4w78ICiBGpf3Pi06S8dS7vFTTkVkusMfx97tebQlkQyUqtufIvAgE=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 16:57:48 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:57:48 +0000
From: =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] wifi: wfx: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:57:40 +0100
Message-ID: <2530603.TnzJ9iJZxx@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20251113160825.383883-1-marco.crivellari@suse.com>
References: <20251113160825.383883-1-marco.crivellari@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PAYP264CA0032.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::19) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ2PR11MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5056ca0d-c779-41bb-590c-08de22d5c62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWQrOVNUeVRaYzBvQmhlS3pNVTF2aTNYSWdqTXJWQ1poY05UWFA2dmdEdHZs?=
 =?utf-8?B?YVJvRzE2UTk2aW5RR2FpMjZ6VDJQMm9qL2R5MEVGdGh4QVdQVGdLd1FRa3Zi?=
 =?utf-8?B?MmZxRU94eG5GVnNFOUlKVmxRNjRTeS81MG9SK05PS3Q3alUwSWVSLzhIR05l?=
 =?utf-8?B?UWhrUHFlWEZya0tJZTBtQ0RLSlo4MElyZHM5TjNtbjVudFJRemxoS3YxQVVS?=
 =?utf-8?B?UlJwS2tObjdHNXcvUmh3aTFraTUxdG53Mk5KYUJHMitPbWtXaGd0dUlBTWdU?=
 =?utf-8?B?a2ZZc1M4bVFuSHRtTFpyMHpsMUZ3VnVGMHc2cUVtcXhhRmJUMVhVSzJQN3Va?=
 =?utf-8?B?V05Kd0dNdDREUHZtMTBQSGdXQWV6aTJpSzhnVmlINkwxYnVlaVZkTm92MXNM?=
 =?utf-8?B?dzhDeXk3M1VMQmdzYUd0LzJzdkZUNjVkbktaNVlOazlSOXV6V1A2VXBza0h0?=
 =?utf-8?B?WENsd3J1WDRHeC9RTUhmZHJSRVFneTFSMUVOWnZpQ1RRbkVvTi9jaUVIMVd3?=
 =?utf-8?B?VGZSUE9mZ2NUb2dxdCtJb0RubURLRlBtRU9KM2Q2d0tUUlV3T2wrMGZDWDA1?=
 =?utf-8?B?YTZsRFpnUFF4L3ZxS200S3I1bTVESnNuR0xWTkZOb2F0cWZuWDBNcXlLb202?=
 =?utf-8?B?THdzdGo1NVlEVVZPS0RvdzlxOElLUkdvVjJCWm5qRTdaV1NITnNhZVAwTHRW?=
 =?utf-8?B?MXNrNldsZXBVTHcvS2k1K0ZPdmM3UEUvbWxKcG9FSE0rbi9wa3JNeUU1NTZM?=
 =?utf-8?B?c0oxc0Vad2ZrQ2tEYVZ6Z2x1Vk1CcEFvR3VzRlIvejZHVmxCT2V0REpnblJ6?=
 =?utf-8?B?UFA5RHo3NWl3Q3ZNeHlpOWxDNkt6OWFFNi8vNG91UjYxREdXb280QWxwWmtP?=
 =?utf-8?B?aTdGdHIrWnZOTTdpVE0yaFRQaEZHVzVyeTRJYW1rOEhyQk1qU2RPelFGbEJZ?=
 =?utf-8?B?YklETGYwT3k1Z1BjVVhLSGlEdWd1eTBsRWc2d3A0SHduSkZmSE8vWkJjQ3NB?=
 =?utf-8?B?NGRvTklJeUtmTGkySTNCd2VyVitlRUZzWi9VRkdreld3ZHp3LzVlaWg1U3VB?=
 =?utf-8?B?b2VKUXZCUzl6bHNKa1BzRkVkQkhWdDlvbGw1SnlRMkxWY0hxVENkcFI4a21S?=
 =?utf-8?B?dW0rY3R4NzJOQm1YYjNFUzZVYnFyVnRCVW9tNWM2Ny9yVFZQcXA3SGZTbm5U?=
 =?utf-8?B?VEwyRk5iaGlIbGNHZitxMUNPUWE4ZlRFQ0hUV2N2TVF0MkZGOHhRcG5sNS8r?=
 =?utf-8?B?VXUvejI1cGxYamtQU0l6R3d1ekMwUWtlUzEzeHhoUmpnakdFVStIY201NmU4?=
 =?utf-8?B?Nmh6aEJDejBIN3V4OWN0TG8wNlRTUlkweE1kNFR6cStTU1ZVbVlWYzdDSDdG?=
 =?utf-8?B?WVVnUUd6cmMzNGo3QnVQbVh4WCtPMzJISEJuOG9nY3lyeG5LS29TMnhpSGNV?=
 =?utf-8?B?aGR0aFhWMkFQV1IrVGUrMUxTN3JnbkxwVHNmTDQyT3RpNXdNM1Rkd25SS0U1?=
 =?utf-8?B?ME0rV1VXd0lzNkhLb3N2M0pYYWk0OHVyNjA1UldEY0FocVBDQSthWDFVcnZJ?=
 =?utf-8?B?K3l5MmJka1duU0xiMnhxaWNyQVFFcWhZVXVISXZhVWxLWGNYOHhwU0lENlVJ?=
 =?utf-8?B?ZVEzT0xuYk4zdHFFeVZ0dkZ1bmFPVi93ZjU4NWtKdlJ3SFNybjdROXFQb2o1?=
 =?utf-8?B?eWJmRXNqUVp0VUNmQzUyd1ZMRXhYcmFEMzhHK1FhY255eGk5aGl3M0dUZVlv?=
 =?utf-8?B?ZWZlUElWTzh2MWdNTERHREpHTzUzbFcxYkt1NWt5c3FJQzBYZ0IwSnFSUkFD?=
 =?utf-8?B?eDhvR3M0RGtSNkFDalhpU0lnSDJkT25iSG5sTkJnenpVV2UrbUpmSnJjQ2Nu?=
 =?utf-8?B?Wk8vSHlobTNxTDFaUHRJK0N3ZVBqMDF4cVZoR29FVG5nWW90c0hUZ0oxZE5C?=
 =?utf-8?B?OGpnQjdBb3BmWUF6Vnd4N1lBbjhUMXJ6c1FkKzE3LzhaYU4ySXdzR0JBWWth?=
 =?utf-8?B?ZXY3MUhvbFhlblZuQlBNbnl0clpTeUFuWDlRT2VaZmE4UXpDQTZ0V2RRd3FB?=
 =?utf-8?Q?phHDhu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSs2RVJ3OWlpaU9hWG1kMHBjdTJkQkZxRldJckY1UU52ZzBQN0htM2d0c0JE?=
 =?utf-8?B?UzdVWEIraDFIZmZIV0JUZGpiclZscUdaNGJtTDlZVU90TzdKcE9kMlJHZS84?=
 =?utf-8?B?Qzk3a1AwV0dVWHNFU3lOTzJrU1BWUzZDd25ubXV1eFhvemJlZzdRREc3NCto?=
 =?utf-8?B?Tk1wQWhQSHJEOXIwNUZhbGdsV20xbmx5R2cxSXZYa1E0QllRYk1FRTNNaHVa?=
 =?utf-8?B?amVEVG44L0UzRW1BV052V3RRM2JEQzh2YnNNanQ2M1dBZTdnMWY5cHV3T3RU?=
 =?utf-8?B?VkcrUEhMYUxkcEpFOHpVL0xiWHJET0o3QlNnNjQrLytRb1JSWWZPQXp5Wk0x?=
 =?utf-8?B?emhCTEpWdDg4dG9EME5JMHBXemQ4dzBzL0V5SjhiM0RNTkU0T2FuWDNjNVdS?=
 =?utf-8?B?S0FPMUE4UTF5VW12ZHlZQkJRNDZNdnhUS3VEWkVVQUY2UEthSzZsamhpcXRS?=
 =?utf-8?B?SEV5MHFhNm40NUlQWHhnQ0dMYy9jZk5NK292VHFFL293NWNNbE5zVUZzaTZv?=
 =?utf-8?B?VDMrWjM2dmNsZHRFUVJlUEMvSVhGRXgxelFDMTRyQWpDNVRiMHhzOFg5b0sw?=
 =?utf-8?B?aHIwbDJwd3dUQWZuTHZBQTlOSjhob1MrRklFdHBOM0lpVGY3VjlOWVhxaGpt?=
 =?utf-8?B?MVc1aEI1UnV3UUVzNTRENkJka3hFQys1NTdkcnljNzRSb0lNcyt4Tnh1SE9K?=
 =?utf-8?B?b3JpcDJURDB6Y0pNUkYvNUQ5c3dKSHIrdHIzRjBHNW5MZFZoaG1HTGFvRFAr?=
 =?utf-8?B?MzRoQk9FdlkxWEdUUDJRcWZvbW5qWWYyVmllQjdVNlhQek5CenRzMUJ2WGZn?=
 =?utf-8?B?RDJxWTQ2Mkw4UHovZXFXTjlUMUxRdGU4Rjl6NlAwTFdtcHFsOWkvQzFTYzRE?=
 =?utf-8?B?SUx3c3VVdzRaLzhKSUtiMGVKWUVlZGpSTm5zYUkraTR4b3NHN3ZFODU2cy9x?=
 =?utf-8?B?cUVMd2RtWThHd3RZWGJ4cG1BTi9LQTZYcUdOdXM4Z3BnY2tqcE50OTBaYkts?=
 =?utf-8?B?K3B5Q1BpZDFUZTF5UGdKRFJYOWpjMHV1Q243L3lwMTgzelZnUXlRbGN3eml0?=
 =?utf-8?B?N09BVzJnTDFrMEsvcUJ2cUpCcDJrT1lrWlBXQ25rTzRVQWI5SDhSTk5ZZXB3?=
 =?utf-8?B?SndQbVMwNjQzVHBHQTJaK1ViY29iM2N1QUZjeWJPaVl5TDUxck41UWhpNXpE?=
 =?utf-8?B?RkEyMUtpMXp6UkNqaGpwVE5Ma0xRRHJiUE1rdnpuSy9GNkduSkdMMTZXNmw5?=
 =?utf-8?B?TVlHa2JlUlRnTmN6NXkyV1U5U2lRR1crYmpzN0ttSTA0VE4zRmxiNlRqM1Ru?=
 =?utf-8?B?TUhRMFl0aEFsN0ZTeTdBdUpuQ1NGNWVPbXZDeTRsMG8vQnBTUnVsVGtoZnNj?=
 =?utf-8?B?TzVDdU01aW5jZ0IwRFhCS2gwTXVGalBJaFZOaVFZUVFzYWxBcnJZQ0lPWDZY?=
 =?utf-8?B?bUdQVVArakFvdFpXQmhVckRSL0NEdjcxa1lhR05yR1I1NTZCNHJyRjFSVDZZ?=
 =?utf-8?B?eFhCRG0wUjcxODZJV2ZIeWl6Y0c2dVBVYk5aNGYwS0sxMmF0anBOTFhpbXRQ?=
 =?utf-8?B?dlhWeGducDRYa2xOUlZtbmhieVJOQkdabHNhUFV4YU1OMHhOK3RUcXZveU9m?=
 =?utf-8?B?UGV3TmYzNW12Q2RKUkc4b1dRaGxVRWM2V2xFRDRFYVRMVnVZQkNHMk8wWC8x?=
 =?utf-8?B?RFk5WUpySkpFQlZGdXRUdEVzYjN2WUUvN3FwdFMzN0xRZjdRbWczRjlGb3lU?=
 =?utf-8?B?Q0d2MFRmUVFRVHVrWTlDNkJsQkNPZkx0RTZkU0tqekd2QzdVbWJvMHg3TmZa?=
 =?utf-8?B?eWdlNTdaMTZXbG5TS1hWcWtnRXZKL3dPMXd6dVh1ZFN6ME5VY29mUGhicDdO?=
 =?utf-8?B?OW1DOVpjS3hmYWxaMmk2K21wL01MMWZLUXJNczV0bjFHN3J3S2FsNXVySTVv?=
 =?utf-8?B?ZzhxblFCTm1ua0x2YzNjdDVVUjFvYytTTHVpVjFubVU1Y0ZCQlYzT2pqOEJO?=
 =?utf-8?B?UVh2cytXemxtTGpLVi9TU1ZzcTMxWFI4RUVkOXJPdVlJd3JTQTNOd2J0UWh3?=
 =?utf-8?B?Q0dWcStLNS9ESG8xVFd5V3kyMzk2ZWtPak5zeC9yTnd4aXdmNUJsY25OLzEw?=
 =?utf-8?Q?sO0M1u1NRstmrU5LZr64voWsG?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5056ca0d-c779-41bb-590c-08de22d5c62f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:57:48.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaO03dvfv1B4zT7UU0tfBKnYQeLSvHJmr2ZUClxpWu/rDVg0ujrbiyYlL+bWFt6mmm36hrxfBG+W2LHeQlEz3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEzMSBTYWx0ZWRfX+vBKgNDJXWj0
 5+IIcKcNsBSoZYUMRh5B1yJYamg7qvoM+umy3OXpD/hvys3WvGZ9fMfwoKh8MRyIz6ofwxYX/vy
 0VLIB08P/yNkpEATbYOL5MTJszv46KHy3GmSbyLryJcXQm5cTOwcXvNhMVKg7c5Uuwbgk7CnqhQ
 ZkZjmzzmOMNhdG3XaXTWS2kLwYlsVqc4fsQ9qZ2ejEx+rbt6Emts75ZuFk2exURnWVeRU5bSeIq
 i20CafAmSPXtISbBmsYEGaFUO1cVHqrTCmwM4fd4UI9e7sQYFAAJ2j1zVrb2ZKVVqp1SA/ku/aY
 GE1Vci+YUMJdyIuAIQcOmtOQ+zIbC7Pp9XCUbx3QK8bqLu5WSILK6TDQ9hCtjtxevkjovRppMmU
 EAZ7ErHUcuFwfAS2BRsIPSI3IUcmKg==
X-Proofpoint-GUID: wbtAN-9LD-vIoD6ZTl2x2T0QKJXPVwxx
X-Proofpoint-ORIG-GUID: wbtAN-9LD-vIoD6ZTl2x2T0QKJXPVwxx
X-Authority-Analysis: v=2.4 cv=PavyRyhd c=1 sm=1 tr=0 ts=69160e0f cx=c_pps
 a=z4sgpIVFmn7gf/JJ24wZvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=M51BFTxLslgA:10
 a=i1IsUcr2s-wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=2AEO0YjSAAAA:8 a=oWLVvGOPDP0YegE4zGIA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130131

On Thursday 13 November 2025 17:08:25 Central European Standard Time Marco =
Crivellari wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20
>=20
> Currently if a user enqueues a work item using schedule_delayed_work() th=
e
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> For more details see the Link tag below.
>=20
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>=20
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they=E2=80=99re need=
ed and
> reducing noise when CPUs are isolated.
>=20
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>=20
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>=20
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>=20
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.
>=20
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>=20
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/20250221112=
003.1dSuoGyc@linutronix.de/__;!!N30Cs7Jr!XKe1YoeqdRNkCRNrXBDpd3dyHXefzYb-3C=
pd2WmhtEb9vvp1pYw6DF7umzTJlLkLvSdeRGYOrAZAgyS9L-15V9i67-I_-g$
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index a61128debbad..dda36e41eed1 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -364,7 +364,7 @@ int wfx_probe(struct wfx_dev *wdev)
>         wdev->pdata.gpio_wakeup =3D NULL;
>         wdev->poll_irq =3D true;
>=20
> -       wdev->bh_wq =3D alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
> +       wdev->bh_wq =3D alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PERC=
PU, 0);
>         if (!wdev->bh_wq)
>                 return -ENOMEM;
>=20
> --
> 2.51.1
>=20
>=20

Reviewed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

BTW, this workqueue has changed multiple times. I though it was already
unbound (and I believe it should).

I also think the HIGHPRI is not required (the device perform better
with HIGHPRI, but this is only because we steal the CPU of the other
tasks).

(Anyway, these changes are out of the scope of your PR).


--=20
J=C3=A9r=C3=B4me Pouiller



