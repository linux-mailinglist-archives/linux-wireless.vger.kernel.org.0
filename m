Return-Path: <linux-wireless+bounces-16244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32D9ECD66
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B47169FC8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED5233689;
	Wed, 11 Dec 2024 13:36:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD82368F1
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924199; cv=fail; b=exVht3Om8EB0GVx0rvofcmN5c8DOzjcFcIb7s7dUIXIPBynR1RlbZu8RTGikaeSiawpoFXhGoY9m6Po6ewacexqccgE/RBT47EUAy6XrcR3rHOuKdpMqLLWFlghjbojm83n6DEoJ0QPdP48CVWo7NnhZXevjfMAnAAfUPkAF7AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924199; c=relaxed/simple;
	bh=bPSVGupmZtFx1GHvcAF1SRvlLUGEe5wZwxtqNQhuo/s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q9jckFKykAegcoQAmGzT54B8SfVWinj20JAT1p3E6J7RvepAK+9L+Lf1MxVRBzTqZPQDxTyC+xP47oQp0q5KUtoScG51KWltycyh81yg/eY/3rrJ3N0BInh9hWB7Th6z5bg6NcrZ8Xw4W7OJRNgCZXV3k0myggUO2Yi+9x7OS7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBl3Qq006283;
	Wed, 11 Dec 2024 05:36:33 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u46sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 05:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2Hlcli5w7Y5v1+Rc1bhMaUfppiG+FIe3xkwMVwV7pmqLVII41D7RUfgT6LR7mkxGa47Ti9NX3fDJ/LNKAcIK4oVY02oY7oNyGkIVIw1j9bo5LJRKif9uNroV8KtAzYof/rjmlKv7Noxsxc80zuwPiBivyzBsSSIOZLPkaMzUffQXPtRkJ97S9Wq31VZENrwD5HpVSGoQ13yMpBIQH+PIv5XEGmYwpq/lNQEw20Cp1LYDmYRLcETgcL05oMP8qfhdDALP4au/oTMAS+hE1jI2S5/i4fd8HvUOiZxpkKeQaDI8/h2QqzEC0CAFobbykIwjPG3hFBiXHfJhGu9yscwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0krIsjMVumSy8hnJj/X2xJEJVKCWo7xNVh/qw6w/nw=;
 b=J+9yJ82CtZ106w4+L6qc+wDVPkt0qZslw66/RdNnBLPfSvhJtJcg+GXA7IPvhYkK6zRi9PKZZORdHptNeOYG7eJbx2wjUt/44ou9PTxOexEiCRDS/jB8d5/tFz/vXRkjGrfMHkEJHZZI+sE4jV/KNiw1JKXRGaTVxGCZnIu+BataMQcpIpvzbCpoa7K7FURSYXKwslUUwzbAEzfcK57LTL4FZdRzqzohyd8j9sATx3g4mQj4tsV+8rsv2Ziqskvtl8P1ujMew9eSE5IutymLgowy7Eax9itvRXehmGaccMvsxXLDjRU870xbhteD3+zo7rNQDE7wvdDc8dG6+fnoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 13:36:30 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 13:36:30 +0000
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Marcel Hamer <marcel.hamer@windriver.com>
Subject: [PATCH] brcmfmac: add missing header include for brcmf_dbg
Date: Wed, 11 Dec 2024 14:36:18 +0100
Message-Id: <20241211133618.2014083-1-marcel.hamer@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: c148498d-510d-4b4f-4436-08dd19e8d1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjI4Sm4yOFBsbUc4SUlnMCtCN1BaQU9sOFhMVmhxcjNJZFhaRDVxQ3R0Vml4?=
 =?utf-8?B?dW1QL0VTYmxTT2s3SGZWdW9pWjVpc1JDNTU0RmhlREhZdERsVDZJT0huTVFm?=
 =?utf-8?B?T3M3TGN2cWtuaGlwY2NwWWRHZ2p0bWo0L01uaSsyVXFDSFZESHZ0Mlp4TzZh?=
 =?utf-8?B?WmRzYlBzTjZPMTZrZVZKOXBhMTNlR3V6UHAvdllvNUVUVU5iYXh2YjgyTDNU?=
 =?utf-8?B?TG04QTRsNUlLM3BoQnZEbDRQTXkwdnhtR1NLdHp6UDZtOTVaWXI5emxndk5n?=
 =?utf-8?B?NWFRSlloaUVJU3pwK0toalE2bFQxcForUlVsZGhXb3lmZDQyYlQ2MTdxL3J1?=
 =?utf-8?B?Q1VOeDRvVkhJWThvVWtYbGo1TWJUNWxZUE1vNkFsckxwazJudmZSYWJqVmk2?=
 =?utf-8?B?R0s3aFNReDdpUy9RSTdoVlB2U3VXdXZMWXNkbVpiZXBVVWM1eHZ3SjJIN0tZ?=
 =?utf-8?B?MEh2MERadmdwMVBiMGFVMFArbG1FVFdZaXJQaFZUMzJHcm5tMGRQZUw3d25V?=
 =?utf-8?B?Q3NSaG5vcmlGeFlsdklOMFRqaHRTOGpSekVBbjBpYkxraGJJQXNuNlNrZjVO?=
 =?utf-8?B?OGVyL3gvUDU1Q3BLWkRpaFIwUjBrMGJGdE8vNjBpOFZxaG9LNDZ6dyt5ZG5N?=
 =?utf-8?B?UjdwaUFZYjFNbXRPa2pqUzJXNG1NUzBoY0tBSUptWkVKUzd1M2FNSDlaQm5v?=
 =?utf-8?B?TzA5c0pqMVR0M2FuNjRSK05XaXVzL21JaW9QbTMxVllJTnFaTFZuYjJZZUNY?=
 =?utf-8?B?ZnV2S2FXSis0M29INVdPbTR5NVBIQmJXOTYxWWp5eG9IZHpZbEt4MWtDalM4?=
 =?utf-8?B?MmFYMTVlaWVDTkhBTUNIUXppNnVYem1FbFVvaWpWanFIWk1CUmN0NWlOcFNG?=
 =?utf-8?B?VWJZN0VTejdVNFE2YStrZENucld4bjJtbnBWek1Lc0dpcDZ1N3ljK2FFcS83?=
 =?utf-8?B?eW9PUklCVW5HRUR6R3RTdGJEZWJZQ3R5SGNqNjFPNHZmUEJwejNuZm1nZ0pT?=
 =?utf-8?B?cXJMSm80QjhzM2VUS0ZMQmhDREw4MVdUVEhTR25YSkl5MW93VHIxV3J4T1RU?=
 =?utf-8?B?cXdodTlCci8zVmdOMGNMSlVCTnd1NVNNN2pPNGlLTTdacDlLa3ZWeDhLQTd6?=
 =?utf-8?B?eERmdG9aUy9aSWJmalE3aXdIQTVZWGpaMitxb3BBUWNpTzd1MnZZV25GQURm?=
 =?utf-8?B?cGpMU3JtSjdIc2hLMEhnQ0FnclZTNzdrMzFKNllXRGNOblUwelB0d0c5OUxU?=
 =?utf-8?B?NXpITU1HQkpFa2dEUUtHbnVtc0NMa0crTmNjQW1KZTNNcWhCV2piQTJGZ2Za?=
 =?utf-8?B?KzlBM1U0c1FvV3lwSWVJc2VPWjFyamY0eXJGR2NacnVNb0IwWFp6ZjQ5ZEpL?=
 =?utf-8?B?R0htMS9pVUFnTlJjbkFKQW9GdWhkUExTREFyWTU1QjhBWTJIMUlPRFIwTmFh?=
 =?utf-8?B?cUp0b1ZMR1NrNUpzeXJvMklWK0FxV08wSjJySG95VnFocHl5Um1Ud0xPTTJK?=
 =?utf-8?B?V2RTTzBxdDhyTndiekt6cVFQdkg2YWlpUmEybFdiR0dab1VQeDN4QjBxRVda?=
 =?utf-8?B?Z0tGbm9zOTBVOUd5dVBySStsZXhCTjJXSnp4WEJmV2c3dHNqbk1iakRHK2h2?=
 =?utf-8?B?UmN2STRidWlSVTBxa0piVkIxN1lFSE12L2hLNWc4anZxNFNobWhkcWl3RUZI?=
 =?utf-8?B?OUpWa05KRGhBKzBuNGIyMGM1aEF4YTBiRDVBVnVXeFBvM0FWSkh3YW1tbzZO?=
 =?utf-8?B?dkxoaUg4NVdDUnQzVXdzQXpBTEhpa3AyUnI2YTFNTUtzN2J4MFZaamQvY255?=
 =?utf-8?B?bnQxcXBjY3pKaHVsZ284UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXB1ZXJlZXlCY1hqbEhTNDNoQ0JwQkNId0d6ait2NHpWbmE1SWpyOEZxZFR1?=
 =?utf-8?B?VkFqVmpaWXpGNXJCMnRMdmN1Tm9mL1NLeEJPS1Q1WGd1TGtKMmpYSmd5OXla?=
 =?utf-8?B?VnFvbXR6S3FIUzdmUUFTTmhSTDZJbWtiRHlLM2d5bE1YZDlpWm1nNU81eEJ5?=
 =?utf-8?B?b09ISWh5L1dNVXRBazAyR2lXenNjbDhrQ0lIZzE2b1lHUGZvcEV5MXZMMGpV?=
 =?utf-8?B?ZythZ2lZTFpyemJra2hJdENGUVhmaFdTVGMrQWVoZHhmT0RQYUN3RFY5TDYw?=
 =?utf-8?B?RGV1Y1AwOUg2MlVERVRUMXc4RVZ0b3JDSVZTNjE5Z3d3SzA0Qzh5K0FJTHNB?=
 =?utf-8?B?Mk1EYmFhd2pTQ3JEZ3pkV1cyQUQ3ZmxLeXNNUUg5TTRmb0ZQWng1U3JsMENY?=
 =?utf-8?B?QTdzTzl5UzdJNVFBd3lIYmlQd2dKRHJYWEcrdGpnWTljYlNmbVZQMEhoZXpW?=
 =?utf-8?B?dVFDK2ErRmJlVXYrUVMyWExXMCs4NkFxbHVLdE0vZE9HM3J5di96bk1oa01G?=
 =?utf-8?B?RlVGV2gybUVZWFZkSTVHakt4aGczYjdlOHJ2RU1xWVUzekdVWlZRNnBkekhC?=
 =?utf-8?B?MlE2K3VDWi9zK0oxSUhxNWd5UDRadEh6MGZIMHNFMWNiMjg1Mm1BMDByTTBj?=
 =?utf-8?B?RjliSEpOSFpPYSt6VWFnbUZ4T1R6RGZJdWxramhJK3BoZ0JIQ3JQRlgwZm5E?=
 =?utf-8?B?OXdOSHhjdU8rTmdESmx1UTc2NTg3aUFqbk5oYXlBamNRUzJManU3citTdmJG?=
 =?utf-8?B?bGJvMnBhbmsxQWE1cFFKZ3I5VmRJTVNCSU5FQzdTa0lhc3V3QlJuYzVNV0w2?=
 =?utf-8?B?MHk4Q3ZOUlowbGxhL01BM2tKQkhFamMxUXVXblpvRnBhNHh2dTJhWGZlOU5H?=
 =?utf-8?B?SjdHSVNSRlN3R0tZclZFb0Q2OCtRNWRkR3lVeXJ4RUlPWk5MMGhCMkNoRkZH?=
 =?utf-8?B?MkRZcm1JZFVpTnRkeW1DNGhPOHh2Qkx2ZnB2VnVlK2pzRzBhVjVXRmdrWVdz?=
 =?utf-8?B?dStaZEtRQnJ6VnNOZDl3TWFTcUU4RDdtTCtQdW9LQVZMNm1Sb3NYVks2d2pM?=
 =?utf-8?B?bVdBUVlSOEFESU1nTFJacXJjczB1cllWaFFCVHVXazFvb2JXU1kxbDV0NFRq?=
 =?utf-8?B?UzBJZXpsNkV4VVpzV1A5K28zQW1yRVV3OUhneC9URWNmcld3TkpwOGUxMDha?=
 =?utf-8?B?Z3p1ek8xVmFJTG5qUDZHWk5QejBtSVEwT21jRU9RanBWR013amFUWUtyZnJF?=
 =?utf-8?B?bjFJaXByZWc1ZS9aOVpoU2M1eG9jZFBncFY1WVo2VmVkbTVjclRGYlQvUW5m?=
 =?utf-8?B?QjJLVFBkMTZtWnB3RmFXL3FaTTQzL0g5ZWkwL1dtdGw1NnhYNm5hK1htSjd6?=
 =?utf-8?B?bnJwOHhEcWxKSzc1emVPdDIwRjNUcFh5WllFWlROTHpzNGNJUStkQzNDQStH?=
 =?utf-8?B?ejlnczVURmRINGU2ZFptK0xON2pjNUk2NW1mcnVjRWFWdy9qdE9QQVZJbURS?=
 =?utf-8?B?MVpQSXVJM1g3NmQ3d3ZHRnJ3dVZ6Y2d6R0w1aHVSc24yaitla0Rtc2xjZmpF?=
 =?utf-8?B?QmhLMDFtUlRwVWJLZ1RmU0xQSW5LVE9wVmhqT2dHTTZHanQ5aE95NXA5ZWdE?=
 =?utf-8?B?TXdOSXlSNFBHYWVKcEtZK2JIbEZ4YXhqWCtTcXBaOVk4STRPQnJ0VUtpdThv?=
 =?utf-8?B?d29xemd5cmlaKzRGOTBYNnlKN2h0b2lSVjZRLzdWQk5TcnRWcXh2aXlpelJD?=
 =?utf-8?B?MkhmY0FYK1g2Ukt5c2t5QjBSd0xKS21ndVpRR3NVWlZTWlIxZkhGY0xzOFZ4?=
 =?utf-8?B?dDNjREFxcFhoYU5OZGlBMWZNaGpzME91eFlIQzlRVmhRVmtWam5zbGFLcitw?=
 =?utf-8?B?OVR0RHEzM2kxQmZlMFJIOWFYTkdBYWJ3YXgvdnFxb2FqdERVU0VHejM2NkFN?=
 =?utf-8?B?ODMyYnVaa1dzcW5yNU1Nb3dUQjc3VjZWM2tKZGUwWUFWMC9KcnFuWXBXQVA5?=
 =?utf-8?B?c0grWHhGb2F1clRPS0MxU1dCYVk1cTFaU0VhRTVrK1dQb3hyYzNSSU0rVkxt?=
 =?utf-8?B?TEJPeUx0TW9NeGxtZXVITzlDZlY4MjhvNmxVdHpOOWo5Y1h4Si9IdnRSbm1Y?=
 =?utf-8?B?bUM1Q0QwVU85NUo0ek0zM1gzTWJIRndwcFRMSHJVQVlENzhhSkFWNWNTU0dv?=
 =?utf-8?B?anh1UU9UVDhxWUFSdkpMdDByd0VTelk3TEYwYVFrWjkydmFrN2VrYkh1NXBm?=
 =?utf-8?B?dzlIOERZYXN2NHBmRG50bnJ4L3BBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c148498d-510d-4b4f-4436-08dd19e8d1c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:36:30.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+lXv/esdF9kqV69o8KCDb2TodVFxk0betPU8JGAZjr/M1AYz1euRZNCJBHuklrQ1KGFxQIO/nUu+ieOpeSA5RccTUzCGN3yjEns5CmhOjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=67599561 cx=c_pps a=WGTt6C9BqyZsVnlRayY6PA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=xJcuyeIl4yQisyzVulMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 8EewXVJjU_2IQKqyNN7a1c7RiYl1ZSCu
X-Proofpoint-GUID: 8EewXVJjU_2IQKqyNN7a1c7RiYl1ZSCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=728 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110099

Including the fwil.h header file can lead to a build error:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h: \
	In function ‘brcmf_fil_cmd_int_set’:
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:90:9: error: implicit \
	declaration of function ‘brcmf_dbg’ [-Werror=implicit-function-declaration]
   90 |         brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, data);
      |         ^~~~~~~~~

The error is often avoided because the debug.h header file is included
before the fwil.h header file.

This makes sure the header include order is irrelevant by explicitly adding the
debug.h header.

Fixes: 31343230abb1 ("wifi: brcmfmac: export firmware interface functions")
Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index 31e080e4da66..ab3d6cfcb02b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -6,6 +6,8 @@
 #ifndef _fwil_h_
 #define _fwil_h_
 
+#include "debug.h"
+
 /*******************************************************************************
  * Dongle command codes that are interpreted by firmware
  ******************************************************************************/
-- 
2.34.1


