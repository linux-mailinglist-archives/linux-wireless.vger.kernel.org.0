Return-Path: <linux-wireless+bounces-19606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3EEA4A15E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D966C3A4FFD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66CB1A2554;
	Fri, 28 Feb 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="xTDR+ZRM";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="B11PPXz4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC201F4C97;
	Fri, 28 Feb 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767066; cv=fail; b=jIs+sLqWB68Fg1BYjK3Wwhjw0vpW1m5NAYuVgrDmO5Thi3XyWkow0/ivg4/ntSrJASvbaoESPxeRw04FyLPoQZrPBERfknzEAVUJOpUQY/ei1gdMU56Uk5TT+YooQUzC277u9c6W0wbiZTwbAuvs1P3sLCDF6XHqNJdBaB/jT7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767066; c=relaxed/simple;
	bh=TUSbefa1RtSOI1HW0RDRjuD6llP9MiM+MgG1VFe6g1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euS4dsDqA+uhHqKo0or4iboLubMNnf0tAYPRlz/4P11Cr5EO/ztf/TL8NfvtqFXrpFXW2fU3L8NN7nnkbc2KYSbbQd0v19WVSX09f4G9Tn60O7KNBwr0dg6VP/eRO1o/DcDVOuTnKLVnVp1uMcr5Imh+3Vy+m9hBO5y5z6mnwU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=xTDR+ZRM; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=B11PPXz4; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8EhYK012718;
	Fri, 28 Feb 2025 11:15:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=TUSbefa1RtSOI1HW0RDRjuD6llP9MiM+MgG1VFe6g1w=; b=xTDR+ZRMXPY5
	eIj96M326NBLiRrABVkUFXznVUy66uMSHjy6nzfhPMOg0oP/h6J8T9L3vn6LuK7i
	74PVLPrIvNtBWwKpW8SOIFtpK3igLiQIJp3tzgAlKMRUknwzzNJTVLcVLaXd1kUq
	iP4SSCpED+QoNnDyKkT75GH56cR3HK8zC3cUVfdMkN4d35Y/O+14/kSahwG5t1S8
	MszRqhtjitlVqHG/18fzjtRLXDA2mN3l4gwwNdcrGQogFZ97FeoLX6dtlq611jLL
	+h2EIjdedRQef40t1e4sBLDvnZT0HhD0B2bIVKS8dWvPzHSebLZpCpNVifx7A/2t
	icNOroIWfQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbrujd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:15:01 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6K+GJpwvzJRWhSJIfr9yPx/Lqk0JKNZju1iDe92IoAcy9V8BAARMBzP6uKXqnFH0hlaffmYwtxA4IpKOHHftfZD0+QVYncVZvqWeA5NKqDXMkiSt+tps8TeCBlD50jdmK/YJYeljRp/UwRYxhNmLFXO4O3HCHGXH+ah6aO3RvA3XYqmhgW/CHUOmQdYxV+nm1f0NM0awkaZxGHicsp6fvnnXXbxAJjsoJPVEiJDhyRV/7JgMHWe7lnWykxZOq8Ny5c059MEsRGc1N2jbsyAgr2lY9aeFj7g63TU+MS+kDFrLTLJPxQSwrhND6nghtAQWYldVId3FqOcgdct7+V6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUSbefa1RtSOI1HW0RDRjuD6llP9MiM+MgG1VFe6g1w=;
 b=gT5MEZrrqBzjVFxasWdiCQBF8NnjU8ZiUf1/wKRziQHIwAl5pBlrKo9uJ8XD9YP5WQu6H12wtGPRlS1F/6aAyRGc1/MSh4SZbvmAi6Qe+/RDXN0y8mFsTNrj2YzeBohNe8YQSFsqrU1SQHZWJfY13t9JMpg5nSjl64F7M/vMedqNkXeexZgLdML7s/fhwz/Yj759LyTukB5M641Puh7Xvok+2qvowB2ZMQIZxqVqBCZ2YoxJSTkFRvHidq6KmK3ti+SfALfCBOJ0kNwXpqRIfJXgeExTIUzuy+q9+TzhaeeQzh3k97WanAGubL4Fc9WeRl7LlJCioGBi8+XitlZFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUSbefa1RtSOI1HW0RDRjuD6llP9MiM+MgG1VFe6g1w=;
 b=B11PPXz4kc76v3qryBY8PflAFvk9mSptOSUGu0dNEuQLS4jlyUWXE67XjjqdaTOX8PFqVsWIvoey6Iu3aM/HQQaubchUvVucDPNeeEw6DIsTjRGX+j9V8tv00gUb7cJCOfFfKf2yXyT/DTgnbr9Ht00IaV5+yxxCiu4gxnmCXbI=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:58 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:58 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 5/5] wifi: wfx: allow to enable WoWLAN using NL80211
Date: Fri, 28 Feb 2025 18:14:41 +0100
Message-Id: <20250228171441.109321-6-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: cf882eb3-1e93-4e9f-637e-08dd581b6dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXpsZWg5d2RFQUxvQTlKKzRxdVFubVFBUlpkaVk4QTNhcTBxQk5OTExQY0pR?=
 =?utf-8?B?Wndac05kYzZ3cVU3ajMwdFVJWUpkTExwQkdTMUNGcytsR2dtZXYxaTNnbUpP?=
 =?utf-8?B?ejBEb2xNRDVYODJMUEtldFJ1blFKRk9HbWlobERsVmpidkYxVVhPNHJpVjhr?=
 =?utf-8?B?VDNoSkxUQUJlemluTW5RUlkyQU5BT3ZhNEZXcFdFaEZXd3VLUmtIU3N1cXJU?=
 =?utf-8?B?Mk1SZnFoSmwzWTMvZ0FNZlFOb2dhelZyTkRlVVlLV0tQS2RCaU1idjVCdmIy?=
 =?utf-8?B?ejNRR3M0NUkvSGpBNmdGTkpZQ0VVa3BENmJ2azN1bDExazlLYkJrQ3c5WHJh?=
 =?utf-8?B?RHVrL3BhTjE2Y2FTNEZmajdUSmdOQ0hHWU5rQW0wcS92MmNWTHdJd2luNWxw?=
 =?utf-8?B?Sm9xeWZTTkpkM1ZtTG9RTkQ5b0lpU3REYnVxc3YzQWc1Zmd3ZWlTcFh2eXVH?=
 =?utf-8?B?Z0NxRUxFRVRzNEJCQzErYlg4d2tvNzNKUWk2cGIydHRWTS9sWmNjdHIzZzRr?=
 =?utf-8?B?aGJxUnNpejdlckhsc1RxU1ZVVjVnNVk1aDU4aTY4OVE3NENvSHorMEtQTStS?=
 =?utf-8?B?bXFMbWRiYU4zWXJ1K2U1ZWluY0llWjFySXIxT0trSXIrWUJ4N3dpYis1bVUz?=
 =?utf-8?B?R1hIc3ZtckM3d01sR3lrWCtMRE5kdU9oUEVuZTVlSG53R2JzdE9qNThpaTBF?=
 =?utf-8?B?d0U3SnJFTG5GRGlIaWIySEk0dDlhOFdIdlFNU0Yyd2pwdHdYRG1TWHMyQ1Fu?=
 =?utf-8?B?SVBDaHQ5Ykt5SC9YKzgwaDRHVXNpdnh4RHc2ZTA1UlB2aDFKZkZWaS8ranAx?=
 =?utf-8?B?eGRCUFRpN0ZFbGZJb3BGMERBSG1lK0JzZ2E5WHhRWnRNbWU3OWY2emZqUU5S?=
 =?utf-8?B?clJLa3RmUWhwQWQybkpIUDBsRm03YVFTdlVwRnNDd0pYUkdibFNhSm11dXd2?=
 =?utf-8?B?Q0pmc1VlMGh6ZWd2NGlMcFFsY2ttTVNCcW92TW03U3N5NkM0ZW1YVmdJN0U1?=
 =?utf-8?B?UTlOQnJNb3cvbElBaTR1MVRXb1A5MDdTbjE4Y0UwMXV5OWZ4cmkwRHdGdkxk?=
 =?utf-8?B?UUUwWUg3dmdwUU16b1lwSjFINmh0ZkdacHdUaFVRSGhCS05aZUYvU0hrdWZB?=
 =?utf-8?B?RnM1Zm1TaTZwbjRvL1JVcHBheWQxcURad0lBTTNvR3Vjdm41QkUxd1lyWWli?=
 =?utf-8?B?M0Z5cjE3cXArWnhXNzdoMXRyNHY4WUdjVnhNRnkzbEE2RnRSaEdmTURVS2VL?=
 =?utf-8?B?YTFQeHVVMTBtUlgyeUJTYWREUnRHMjhTVW9yeVEyVUNZZUF2d2tGUVJJaEt5?=
 =?utf-8?B?OGdpT2YvR3dDNGtHUWtrZ0dkTHcxMS8yamRRUmNWQ0tsZ2NtYWZKekk4c1BB?=
 =?utf-8?B?OTdoRUtZMEd6RElUZVlXbVBsOUN3VkJrSGhNcll4SlYxM2F2WGJCa2VPTjRn?=
 =?utf-8?B?Ty9FOHFjUng3THMvclBqQW9zYThhSnE2SEJIbEN2aWh0ZG5FaEdFVVhWVlhU?=
 =?utf-8?B?UUU4ZitWRk44S09MVnBPVW5WWnlhMmNXeERiZU9adFdLN1U2UWZnU05yRnlp?=
 =?utf-8?B?ZkwxRHptYzRudGYyOXRPOHdoN29nZi9uemIyZ2phR0lCVG96c3oyMFdQVXFo?=
 =?utf-8?B?Vm5jOG1jbGd0b0kzbUZPWlRYb0pKNTVtTGJEZFo2K3h3blNOZDE3MzN3elNl?=
 =?utf-8?B?TUNSM2dVUTFUWGRYMjRIeFRuejRWQXJCSVlFRUNoY1RuWkN6TDF6WEFONmdl?=
 =?utf-8?B?LzZlSk43ckczcWRwSlNiV2lBUVVGLy9LRDJoRlMxRGJheEFnYzJNcngwbG4w?=
 =?utf-8?B?MG52Z21iZUZDU0VXeUZGQUt4VUs5WElQTm4xWXd4WFZIUGdXMDdnd2dveFZ1?=
 =?utf-8?B?UVpnMHQzellrZ21FbnhkMWE5anc3czR1aVZTbkJDSzd6MzNiTXBsVXkzK25a?=
 =?utf-8?Q?G1GKGv7/uixnMbCKOJNAHFIlT4Jdd4eQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djkzTS80VEZTQ0VIZzUvTVhyQ3IrcHBtcVdWYlBabjZDQUUycEN4RFBZOTBO?=
 =?utf-8?B?WXd3cWpzSk9QdlBIQld2YzlqZTZUUmRjNFRycDVHTVlGUjVkSnZGMktkcWF5?=
 =?utf-8?B?SUJkUTc0dXdaVEptdHZ5aDlVTmo2dHVTQ1NZQ3laYWhXUUo5eUFRemVXTTEx?=
 =?utf-8?B?ZGJFZUlaNUVFV0gyVG8rZzBNdEk5b0x3cXV3WjJjdnRFclhYUDRTZnpET05M?=
 =?utf-8?B?anNvaEs1VmJXN2taWVpESmFxbkl4RVcvL3d1RTU1dlZYRmNZZU5sWEtqdGt6?=
 =?utf-8?B?c2pFTzBZbEZBYVV6bkRUcm1iZmNlbjVJTUVJQkJ3dm10dGVhRFlGYjF4cUxk?=
 =?utf-8?B?clBmc2dlcEFnN08wb0xEbmF5R2dvZkE5SXlIUnV3SDg0OVAxTWszeDhMQjRV?=
 =?utf-8?B?Q1NlVGZjMzlZRXkxRkZUajlyR0RpWjZqMmQ0NGU0cVJ1N3VTaklXb3BTbjBB?=
 =?utf-8?B?M0pXOWhORjZ0Z1gyVHZTS2pTNk1KNm5GdzUzQmJ4d2V3RDVFZ3dQak5vYkFh?=
 =?utf-8?B?c09ib3E4bVU3Mk82Vm5GY0ZoVWdLUENZVVdFcWNMbDJrMG9LWDNuZkZ1UEwz?=
 =?utf-8?B?SHptaTcycW5SUStPLzMwVVExNHdraGhjbSsrNEFtQll0NHZxeXFQSk5XQ2Uy?=
 =?utf-8?B?Q2o0MFgrOW4rY0NpT0g5YTVEcWZnSXRKcVRTa2JRN2ptcHJTdFByVjNyQ3Qw?=
 =?utf-8?B?UGdDTmxRRVhOMXdZdjlZVDFjMDAzRFd3SFdPK1Q5NVpJT0JscXVhSXYxaDUw?=
 =?utf-8?B?S1l1dGxmaUU1M0tlNjRLOXUzeFJQSmpjVHNkQnpZN09UTE5BUW9GM3lxVTJI?=
 =?utf-8?B?QTN2UTdpWWppY2JMblkzT2JEYlFvOGxzQXFtN3JTMTEvZDZ0NzBpZUZSbkR0?=
 =?utf-8?B?NEp2c2VmMFZwcUxtdm5KcnJ4Qm9UQVRUMG81SDZSYUZIeHBERU1IM1MvdVlL?=
 =?utf-8?B?WEwwZ1N0TDhRWllsU1hzbmtPWDl2WWtIVjBiTnA4aU1OT3JZWmdsU253WTNw?=
 =?utf-8?B?U2Q5VlR6cHJKcDJ2T1ozRnZhU3V3N3F5aVlGRW5KV1QvWnA0ZFRrSFdqQ29z?=
 =?utf-8?B?eDBJdHdWN1lsLy9HekxOOWFOVWxjU3lhZUNtRldIcGhuKzAvUHVlaDFrTGlV?=
 =?utf-8?B?Z0NYRXh3Yys3WjlTYmFqSkRzYzNMb1BuMVBjc1hLaEFJUXNuQmdwZkZLNXZm?=
 =?utf-8?B?UHBPQm1XM0hyK1d2ZnY1S3cxcHFxUVNZbm82L1ZuYXRmTGRvR2JYR3VRVVdq?=
 =?utf-8?B?cXlkdVJ6dEVldlFCM0owczhVMHRKTXR0R3lTczZHQ0tVSXVENGNCWnVPNERY?=
 =?utf-8?B?cmpyVU05V09GdUJyallzMTlyTUtJRk1PRHVSUk1UYU5USmN4WHI1N3Jrc2sz?=
 =?utf-8?B?WEJVY0Y1TmhoUjl3MjlMeHJBM1JuNS91SDlIUnA5NVZPZUU0WHZNUkQvRW1D?=
 =?utf-8?B?S2xBczhNUmpmc25CT0hUVjRUbVdKWkpweHpnb0l3Yk11cVoyZG4yZUphdmIw?=
 =?utf-8?B?NW1BTTFJV1R5OEh2MUYvN0lFaVNsc3JnUnprQnhvbCtadElZQXpoUFgzUGhi?=
 =?utf-8?B?eEg2QTlhRS9Fa1V4S1FURDBDaVdydWtMY2VGeXorWjFsSExsOGdGNTR1Z1Y4?=
 =?utf-8?B?U1RSWlhzRUZYSUErSGdOcUhDeEtNNldpWHUvWUlJWVM3VnJIZDIxUmsrQnJh?=
 =?utf-8?B?OFU4R3EyaGpkWk1MWUFGdlJkbFVSb3RFWUpXSGxvZjhtQ3pVMUVxUE1mZTNv?=
 =?utf-8?B?bmFhVDhGVm01UXY1OWJiSytHV3MzR3JYM0I5L2VaZDNjNlEvME02bDhiZkpN?=
 =?utf-8?B?eTNBWGNLd1R4WXcwamNvTmRqYldCV1RsTTVlT2dOTzExcjhHMUdZOXcreWhU?=
 =?utf-8?B?dzBrR1J2bEpyWThVZ01OTm5qcnhtVU8wc2Q0cDM4WlRjSnFKWWpjSHN5anV6?=
 =?utf-8?B?UWZaSmxKR1NBREJhaXZiRXAzMVhxMmlLVzlyZ0Iza2dyT0RaUVdVa0dLOURr?=
 =?utf-8?B?VzZvRjlpUGFCbjlMcmNTNTFRQVdBbUFlNU84ZHpwZlpWL1V0MXZZRnA5Qms2?=
 =?utf-8?B?SXQ4RENacDlraFo2SlgwTFkrcXBMRlpTNUNkZEl2VDVwR3hvTFVBaSswdk4v?=
 =?utf-8?Q?4qO3Kjh5Bd0FEQ3kK1f/SvIHp?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf882eb3-1e93-4e9f-637e-08dd581b6dbb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:58.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjxZLQ369uBVoIbJtctIVQa2d9Xj77cp+tQB0UI52d3EVNtEOxdoT1cIWPND/sHcxJk8uQL88zAlrWDkORHCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-Proofpoint-GUID: VgiV9FLJyyG_KBItkHQ-he41_EVTwrP-
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef15 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=OlggIWMgOj6OOkBI_M4A:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: VgiV9FLJyyG_KBItkHQ-he41_EVTwrP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

SXQgaXMgcG9zc2libGUgdG8gdXNlIG5sODAyMTEgdG8gcmVxdWVzdCB0byB0aGUgZHJpdmVyIHRv
IGRvIGFsbG93IHRoZQpyZXF1aXJlZCBidXMgY29uZmlndXJhdGlvbiB0byB3YWtlLXVwIHRoZSBo
b3N0LgoKVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXF1aXJlZCBBUEkgZm9yIG5sODAyMTEu
CgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFi
cy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaCAgICAgIHwg
IDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgIDggKysr
KysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jICB8ICA4ICsr
KysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyAgICAgfCAgMSAr
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICAgICAgfCAxMCArKysrKysr
KysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICAgfCAgMSArCiA2
IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9idXMuaAppbmRleCBjY2FkZmRkNjg3M2MuLjc5ZWRhZWYyMDg4MSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaAorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oCkBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCB3ZnhfaHdi
dXNfb3BzIHsKIAl2b2lkICgqbG9jaykodm9pZCAqYnVzX3ByaXYpOwogCXZvaWQgKCp1bmxvY2sp
KHZvaWQgKmJ1c19wcml2KTsKIAlzaXplX3QgKCphbGlnbl9zaXplKSh2b2lkICpidXNfcHJpdiwg
c2l6ZV90IHNpemUpOworCXZvaWQgKCpzZXRfd2FrZXVwKSh2b2lkICpwcml2LCBib29sIGVuYWJs
ZWQpOwogfTsKIAogZXh0ZXJuIHN0cnVjdCBzZGlvX2RyaXZlciB3Znhfc2Rpb19kcml2ZXI7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggYmQ4ZTFmZmI2
MWJiLi41NTQwZjJjNjYwNzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1
c19zZGlvLmMKQEAgLTE3Myw2ICsxNzMsMTMgQEAgc3RhdGljIHNpemVfdCB3Znhfc2Rpb19hbGln
bl9zaXplKHZvaWQgKnByaXYsIHNpemVfdCBzaXplKQogCXJldHVybiBzZGlvX2FsaWduX3NpemUo
YnVzLT5mdW5jLCBzaXplKTsKIH0KIAorc3RhdGljIHZvaWQgd2Z4X3NkaW9fc2V0X3dha2V1cCh2
b2lkICpwcml2LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9
IHByaXY7CisKKwlkZXZpY2Vfc2V0X3dha2V1cF9lbmFibGUoJmJ1cy0+ZnVuYy0+ZGV2LCBlbmFi
bGVkKTsKK30KKwogc3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfaHdidXNfb3BzIHdmeF9zZGlvX2h3
YnVzX29wcyA9IHsKIAkuY29weV9mcm9tX2lvICAgID0gd2Z4X3NkaW9fY29weV9mcm9tX2lvLAog
CS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc2Rpb19jb3B5X3RvX2lvLApAQCAtMTgxLDYgKzE4OCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgd2Z4X2h3YnVzX29wcyB3Znhfc2Rpb19od2J1c19vcHMg
PSB7CiAJLmxvY2sgICAgICAgICAgICA9IHdmeF9zZGlvX2xvY2ssCiAJLnVubG9jayAgICAgICAg
ICA9IHdmeF9zZGlvX3VubG9jaywKIAkuYWxpZ25fc2l6ZSAgICAgID0gd2Z4X3NkaW9fYWxpZ25f
c2l6ZSwKKwkuc2V0X3dha2V1cCAgICAgID0gd2Z4X3NkaW9fc2V0X3dha2V1cCwKIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHdmeF9zZGlvX29mX21hdGNoW10gPSB7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDFkNmJmMzUyNWY0
ZS4uMjU3YmMzY2QxMTk3IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2J1c19zcGkuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYwpAQCAtMTgwLDYgKzE4MCwxMyBAQCBzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6
ZSh2b2lkICpwcml2LCBzaXplX3Qgc2l6ZSkKIAlyZXR1cm4gQUxJR04oc2l6ZSwgNCk7CiB9CiAK
K3N0YXRpYyB2b2lkIHdmeF9zcGlfc2V0X3dha2V1cCh2b2lkICpwcml2LCBib29sIGVuYWJsZWQp
Cit7CisJc3RydWN0IHdmeF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKKworCWRldmljZV9zZXRfd2Fr
ZXVwX2VuYWJsZSgmYnVzLT5mdW5jLT5kZXYsIGVuYWJsZWQpOworfQorCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJLmNvcHlfZnJvbV9p
byAgICA9IHdmeF9zcGlfY29weV9mcm9tX2lvLAogCS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc3Bp
X2NvcHlfdG9faW8sCkBAIC0xODgsNiArMTk1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB3Znhf
aHdidXNfb3BzIHdmeF9zcGlfaHdidXNfb3BzID0gewogCS5sb2NrICAgICAgICAgICAgPSB3Znhf
c3BpX2xvY2ssCiAJLnVubG9jayAgICAgICAgICA9IHdmeF9zcGlfdW5sb2NrLAogCS5hbGlnbl9z
aXplICAgICAgPSB3Znhfc3BpX2FsaWduX3NpemUsCisJLnNldF93YWtldXAgICAgICA9IHdmeF9z
cGlfc2V0X3dha2V1cCwKIH07CiAKIHN0YXRpYyBpbnQgd2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKaW5kZXggODNm
ZDI3OGU2MTVlLi4xN2JhMmM1OWU1M2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jCkBAIC0xNjAsNiArMTYwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
b3BzIHdmeF9vcHMgPSB7CiAjaWZkZWYgQ09ORklHX1BNCiAJLnN1c3BlbmQgICAgICAgICAgICAg
ICAgID0gd2Z4X3N1c3BlbmQsCiAJLnJlc3VtZSAgICAgICAgICAgICAgICAgID0gd2Z4X3Jlc3Vt
ZSwKKwkuc2V0X3dha2V1cCAgICAgICAgICAgICAgPSB3Znhfc2V0X3dha2V1cCwKICNlbmRpZgog
fTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggOWUwNmY4YjhiOTBk
Li5lOTViOWRlZDE3ZDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAt
MTAsNiArMTAsNyBAQAogCiAjaW5jbHVkZSAic3RhLmgiCiAjaW5jbHVkZSAid2Z4LmgiCisjaW5j
bHVkZSAiYnVzLmgiCiAjaW5jbHVkZSAiZndpby5oIgogI2luY2x1ZGUgImJoLmgiCiAjaW5jbHVk
ZSAia2V5LmgiCkBAIC04MTYsNiArODE3LDE1IEBAIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3KQogewogCXJldHVybiAwOwogfQorCit2b2lkIHdmeF9zZXRfd2FrZXVwKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9kZXYg
KndkZXYgPSBody0+cHJpdjsKKworCWlmIChlbmFibGVkKQorCQlkZXZfaW5mbyh3ZGV2LT5kZXYs
ICJzdXBwb3J0IGZvciBXb1dMQU4gaXMgZXhwZXJpbWVudGFsXG4iKTsKKwl3ZGV2LT5od2J1c19v
cHMtPnNldF93YWtldXAod2Rldi0+aHdidXNfcHJpdiwgZW5hYmxlZCk7Cit9CiAjZW5kaWYKIAog
aW50IHdmeF9zdGFydChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9z
aWxhYnMvd2Z4L3N0YS5oCmluZGV4IDcwY2NjOGNiN2VjNy4uODcwMmVlZDUyNjdmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKQEAgLTU4LDYgKzU4LDcgQEAgdm9pZCB3Znhf
dW5hc3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYKIAkJCSAgICAgIHN0cnVjdCBpZWVlODAyMTFfY2hhbmN0eF9jb25mICpj
b25mKTsKIGludCB3Znhfc3VzcGVuZChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGNm
ZzgwMjExX3dvd2xhbiAqd293bGFuKTsKIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3KTsKK3ZvaWQgd2Z4X3NldF93YWtldXAoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIGJv
b2wgZW5hYmxlZCk7CiAKIC8qIEhhcmR3YXJlIEFQSSBDYWxsYmFja3MgKi8KIHZvaWQgd2Z4X2Nv
b2xpbmdfdGltZW91dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7Ci0tIAoyLjM5LjUK
Cg==

