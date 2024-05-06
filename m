Return-Path: <linux-wireless+bounces-7234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9908BD51D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4DB22A43
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233481586F2;
	Mon,  6 May 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFvoUoEG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vV2H10RK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD64AECA
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022242; cv=fail; b=CMmO8tBx3nq7uMKR6aW2AKK4QKpD/Z+A4WQJt6LL+/56GHjnod7xxONtycdBmT/H2/QXSEZSMuCZnM1H/sJjYhvmE/NQ+FaJsXPuhKsbsKBAjKCavDlNSfpkETdyIO6qMJKKKR9cO4QFQHFOkKqU451azcTW/9T7/vZd9TOgkyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022242; c=relaxed/simple;
	bh=VPW3M7odKc4LurG6sQDSWiwJkrhXx7HpuHyrPKTIfd0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=hn1L4jE9eOSwUR8fLVFvxDe7Umc0QyDCw4ISLeeKw/FSeio/dWhRHOUKM8FffWdbX8OxT9jyctPUlvr6bOjhZXrZXRYjNrSMesWdZ/D0gmceZkWVpD5NU59jGFrFQWF7W7tgsoYyNdH4YOkVciCUoonp306n39qMDu97gc9KX/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFvoUoEG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vV2H10RK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IHfQv018806;
	Mon, 6 May 2024 19:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=KLjO8rMlpnhvOQ9wThfB4Ql77IObpk8/w/hxtQVRNc8=;
 b=CFvoUoEG7zx7aryZMGsu2LY0GpqM9ST6xIMgFNcQe0N2frU1IGL2YP8lXMWsY7OUyYJk
 97MY4beioW1haGUixlfnWXJJYfoceuh2ROPo0aiF2fIU2qCE83ldMsllURNsC+g4s6N1
 dOnhGcAEguTxbfcaDCMUb7QyjurLySDV3uq0KWOZHh6QqYtt4zEi5WJtjtdReYAz1YOI
 UbbRL1ljycnLqgB8mVmmTxKFHOP9Y/1NJHT/y5H6kOv5ie+Y4nGcCDCLHRaj2wpdh0m9
 3WWDc+2lnyCAoPDIPU179aPtGVYDS5Tcby0zfpoPSi+jk+QejDm57DQbKo8SiGOsIFHV TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5kcfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:03:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446HYJ0S039374;
	Mon, 6 May 2024 19:03:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf60x1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHwRTTQ7LUHCMONn+fe80ovyEHVsjd+UwS4XpXhUHyrbqXcZD9tCBN9NVVT46NIOI6wyNJ60yuzYzHUDR4YczpDqlLjjRPbp+gpk7uuTtjIiGuZ3yt/b0yKJE0SkkOm39r3D9vAh7zYMEjq+3iW2g7vVzYgMeo8BskiYvRtsUVj737MUcjYvlBzlyFSg1LjprAUSelyV29oEuYfM7hdnl/cppoEKq0qt2BPJfWXWsQAIdw34VyFlLy4eDeQHPIFcW7kFOn6F3wq2PotOvUOD5S5oxAjHJfPMjBD/hsUDPsS+F9euuKqxyyzI0jYFtKOxwjBDu17fxrAtWxHht1p1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLjO8rMlpnhvOQ9wThfB4Ql77IObpk8/w/hxtQVRNc8=;
 b=K90CgBASiusueQ/Nzc19D4CvDm7QGtMUaxLFfXri6CLecpW427cUkYEMZgy5amgMJg9AKHwWYY+sIqQhYcnAawjrNL5Ho8O5YMxrrFh5+XOdsmhPEyXLPGhuL12raXY/qpEIaTGsKxCgZzQgIvzHe/uXJZr5V91xLhGdJ5/uXZ3RN1tCX7yJWX+sZTpVglYsYMB7jMGlFtmOVDjJUpDYfSOeNrh+722A8pDsiXyA8ucxD6Ts0mpaa9SXz1MSmxyZAkKG/hWs7L3/x2RRBbRL2clwbQmaq1rJ8ygPgKx++EHWKKgYNBT64Feugq3Mixm6PezphrUCp5+3UFk6/B9QlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLjO8rMlpnhvOQ9wThfB4Ql77IObpk8/w/hxtQVRNc8=;
 b=vV2H10RKMNQgktUOP246Lw0u061XymZSBhm/bimTgjQqbItHMnVcd5iQOE/E/ST/KFWGYdfCfIXO53ciZQGlQK5SUS90+9RGOQqyfWJE/kbTnujma7cc3wYfXZYoqtZhf6TciFqu69+Uh1XI1+B5BfXuyZzCY2LodS+jcFkJDyE=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by MW5PR10MB5851.namprd10.prod.outlook.com (2603:10b6:303:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:03:21 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:03:21 +0000
Message-ID: <8292faa6-a2f6-4b43-8d60-9eeba85aa6b1@oracle.com>
Date: Mon, 6 May 2024 12:03:15 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: arend.vanspriel@broadcom.com, linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org
From: samasth.norway.ananda@oracle.com
Subject: Buffer overrun error found in brcm80211 driver code
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|MW5PR10MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 079d2151-2fb2-489f-ab2e-08dc6dff325d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SmNSS0FsSTdHZmU2cDQ5RFUydVFwUUh3WlpjK1k1VUNEdHhJTXVKSndOTS9X?=
 =?utf-8?B?b2pkaUxpRkdzL2gyeEhEamtDR1Y5NldqMzd4MUVjZzBUV2pYc2owYy9qdFNE?=
 =?utf-8?B?NVYvVUtMZk1Ua2RNb3JuaERJZzJFMlRJaVd6ckZrejVIV2Y3aldhYmNCSkVI?=
 =?utf-8?B?aUtzNnpRdjJPVVRXb3ZxWVR3TEJka09QZVlpSGc3U1lRbGloWExhcFBGOHJM?=
 =?utf-8?B?azFMTGpwQU1IRVBJdUVtUTBYQVVrVmgybFpJOW13T1laWUlFSko0cDJsZlha?=
 =?utf-8?B?TEMzSjI4Ykl1bTNweTBUcSs0UG9OU1Z2RVhmNGpkd0g3bHdNczBwU3BaWjVV?=
 =?utf-8?B?cVY4aUVsdGRaUWg4UHppalUxblBNYkY2VFlIY0RDNWhYTUw0cWtndVZTSW5R?=
 =?utf-8?B?OWVqb0RMSUZ2cER6Uk1HdWFWTE9KQmx4Ykk4VDF4VDVMYk5YTDBWQmU2UUl1?=
 =?utf-8?B?cEZ0TUFVY3IyRGt4VEQzK29YdGVqT01FeGdxcjJjS09lM2w5QUJmZk8vaTh6?=
 =?utf-8?B?L1RkTHBPTEVkQjBNZ2w1SmV6UDBJTnJLc3pTOVZKSkx1MUhmckNPY1JXaGFP?=
 =?utf-8?B?cCtSTjloV0VvN1F5aFVjekpxaWh5WXdJRTBMUnA5UTZTOWdsNms2NzZndXVX?=
 =?utf-8?B?cDlSOGJQdDBTdzFDYk1KL2xzSmR0cllHeEptV0RFOExmc1Z3ZFpPblJ1dXlS?=
 =?utf-8?B?L3FTOUUvYjAyT2xYMHEwZVNPTkNYVmgyNUlIL3A0TC85ZDdIQnpGU2ZrL2tQ?=
 =?utf-8?B?cFJXeFkwNlU2T1kyZzI5Qi8raS95Tlp6akZ3VTlxOUF3cHZtR3dvbk5vQVhD?=
 =?utf-8?B?a29LRmNRZkU5WmJkVi9JTmlnOEpWQTBydkgyT3RobGZPakJJTWRmNUdSb2NN?=
 =?utf-8?B?SkhjWS9QMncrMW9tWjFOYTBLQjJJSzZwWklWZ25GS2tWMVE5bE9WMlJQaHVi?=
 =?utf-8?B?SHU3MGgvMUFDYmlMYjVxVyt3TmtSSWs4T2JiR2hTbjRuTlJjRTl4YkxwYVJJ?=
 =?utf-8?B?ZGxLUVJYVXduZGlEUEMvM2tDK2N6SFpQQ1FreVo5Q2o5NURGU29KRllKWmE3?=
 =?utf-8?B?enpUdU9LOVp6RG9MK3hsUkh1ZERBdkxZVkYyQmFmQlJOTmJHUXB6TVpiOFNM?=
 =?utf-8?B?U0tYdTN5T2EyQ0oyQ2tGaXlYckIvWnBDM2xRaDlqWnkwTmZBd3g0NlorZXMy?=
 =?utf-8?B?dFR4NmdpZ1VQL2ZJY3dMUkl0NndXZ3NRMGhxNFVCT3NGUG5qc0dKbEJLWS92?=
 =?utf-8?B?ZUFVdGNqQUZqRVQ3VUtnWmRvbXF2V1A4MkE2Z3ZIZHl5UWNuZjZtT2duTW9L?=
 =?utf-8?B?MUpZOXlTak52ZExnR1dtRXljSDJsUVpORTVVdmtTKzY5bU8xM2lNckVyckpK?=
 =?utf-8?B?QjlJeGFRTUhQd3BPdDdCMTY5TzlxYzlMeHhwTlVQVm9sN3JnVFo1UDgxOEta?=
 =?utf-8?B?bmFGQ0NRWnZaTEc4VG1DTXpjRWE4bEdoZ1lYeFpQaXowd2RuRE94RmFGYlll?=
 =?utf-8?B?MjRsaHQ0aDIwSVBxNm1CYjNURElVUEhoRVgwTEQzTE1sSlg1dk54eFE1TGFj?=
 =?utf-8?B?SVFVTDdJeThaTWk4YVFnWjljdmdvVUhzM3o5V05zMUhJSEkzVFAvbGdVR0Nv?=
 =?utf-8?B?S09wdjBZbkVwN0hMakNyNmlFT0FLcFdqVks2NXBJUDFVWm1pRHRpRkNJVUlo?=
 =?utf-8?B?UHVoRWVncWpZeTlod3pvY1Z5K0xrR2EreTd6MkpGTnc5eFU3blRrL1lnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aERHeGdPbmNwSHR3b3A2TXZibFJFdVdmOWlzTUZ6ZGJpa1RzalV5c0todjhK?=
 =?utf-8?B?VVpTYktEalJENXlzRUNSZHpVb3MyWjdMekU3d01MNFgvNGhReEJ4cTZDWTdy?=
 =?utf-8?B?K0VUZTV6dURIY0xybXp5NVp0eDVqQ29PV3VWUjNVVjI5bGRodEZjR29mQk03?=
 =?utf-8?B?VTVLbWFiZUNzTk4rKzhHVEpKTDFLWk1oYXBuaytRR21pdUxVTnEvR3krT05Z?=
 =?utf-8?B?eVEyNjJQaTdhVzlPelFyZVdqUGNQSnJmVisrOW5BWVZVVzNYTmliWlJNRmM3?=
 =?utf-8?B?UzI1cjFMTkVMd01JRE9kUGNlaWxabVBWS25ic1NCTEpPWERSb3dmMTRuUzVm?=
 =?utf-8?B?WTdpWHZLb1VpTHNQNFBZZHhBck5wY2VOWmtEUDM2azFCZXNQbjJVOUZHNG1n?=
 =?utf-8?B?bW1kU1dXOU5kR1ZaeEpXbXVTU3dYbllaVy84cVhqYSt4WXU3alhrdjUyQ2JV?=
 =?utf-8?B?c2Z6VkczZ0poRThkdjl6ZjkycWRucFV6c015UVJYelA0QzZMZHZ6QXFhZDVZ?=
 =?utf-8?B?Nk8raFlhZmtiTzN4aEJOZkJKbjk2aXU0NDZ4QTJtTk94M2NkMWtSNFp6Y2N0?=
 =?utf-8?B?MHhtSmtqOXgvVnFQcUN0TWF6MEVPOFBlSDF5UlpOaWNmc1FlOXV4a2czUTNG?=
 =?utf-8?B?WG1iOXdiRm9DNm5GNFhadHJBV0gxQi9EdnhTWTUrUTYzaXJnNWVCUGF1Y3dQ?=
 =?utf-8?B?ZkJyY0ozdnNSd3Bjdk0vcnZxZVVOQVlWWXBaNG9qaEZPOGZCVkZ3cHJtZGFh?=
 =?utf-8?B?S0FlVkd4MzlvL0paVGFMV2NCMmM5ZGRpek9xaDN6bU9WOGd3OUY0ODJHNUh3?=
 =?utf-8?B?NnpqVGpJUWc4dmlnVVBZNktkcjB6czBVQmx0NEtnRVNGWmVGLytickJXWC90?=
 =?utf-8?B?Tm5XeWErcVJ6elN3aTJEMy9YU0hXSzF1ZG8vbHpaSUpuTG91RndUMDI0QmRD?=
 =?utf-8?B?M0s2ZFJPWGFWN0RjMWpYS3N0SDlQNy80dWxlc3M3cWxOSzB4eXMrVGhIUWR0?=
 =?utf-8?B?RHM2azd2aTlZOWVTTTlvcklNTHRzUERJTnZJT0oxaWxQRHZDZVZvK2dsbk0w?=
 =?utf-8?B?V0R2UlRibEorNVdkZVVTWkVXNFFrSWw5N0xkaGh4MlJrMmR3aEsycC9yUy8x?=
 =?utf-8?B?R1V1eW5wc3lXTXhvSkloUmFYa09qSUNCV1BEY2V4Z0NSejV5NnIwanBkcFhC?=
 =?utf-8?B?R2NjZm1hTHliTlFLYmhTdWc3ZnRrc2dWditEVEg5QVMrcHpvVnBNa1RQMkQy?=
 =?utf-8?B?TkdTWGNjbUZkNUpVZFlERDhXa2VmUE5La0txRVlETnYyRzdtSTZ6TFlZUVlB?=
 =?utf-8?B?SHhYMTlLbUE5OWVGekhJMEd0VFkzbzZ3WkJSaDBzNnAzTDBqcElQWkY4YWFQ?=
 =?utf-8?B?bVZLajFJblQzTWg0d2JjS3ZKTC9SYWRYMmdMdlhpeG1nK1cxTUkyRlRNRnYz?=
 =?utf-8?B?angzODRFUUN0UUp3VjZHaWcrOEE3OG1jQ0djZkZpakxoTS93cU9McCtJdzZV?=
 =?utf-8?B?N3NuVFdnV3FHakZxcENibWFZVkRwQWhaaE9vZEhEdUNPMWR1a2tLUnFqMG9x?=
 =?utf-8?B?MVBsRzN2RnBTY08zQVVUMTNOSjlMOGNxNzE5aXNWL3pVZkYvL1h2WlhWRjZs?=
 =?utf-8?B?a1lBTEZjUVNOVWhDUjVaLzJQRTRnSmhrcUJMdzd1UHBMMjNRbGVDYld0NVlV?=
 =?utf-8?B?b1E4K04wcGNUdjlOYVY2dE9WbkhwalJhTEJxS0xrckkvYzdmcGtzMnBYTTNC?=
 =?utf-8?B?TGJyaUszWXdhYnhadzNmMTRZb3ZYS1crSjJmNUdWbWJsQWVpcEFoeEJhbmRi?=
 =?utf-8?B?enY0SXVHTW1vazZmdnQzaTVhRGNVMzBDazRGcFNzVUNhRjBpVUpreXZKNUJw?=
 =?utf-8?B?aDlCR1BON3J0cXFJa3AxSzU0a3N6elFDczl0ajU0Y09ITTRlQ1J4SW1PdnNu?=
 =?utf-8?B?L292NUJ5VWtiaFJPbWVEYlZ3MnY3TEpDZWE0M3RkRHVKMUxtQStablpyYWow?=
 =?utf-8?B?dThJWjlZbmNHRlhCa0FDMnFNc0ZHTmZuSTN5SzQxOW83N2ZNVWFWaGV4MXNp?=
 =?utf-8?B?QWlFQjMxcGJIQVRSLzlkNTVTSG5ZZFFjUTVwd3REZUhrTThuTHVHZXY0RG9H?=
 =?utf-8?B?eU0zZk9HSnQwMkRITDN3eFdJN0t6Z1IrSnlKUDZuMVpONmFhY0krTEZDZGR5?=
 =?utf-8?Q?w8FijKMTRtPBDrx7gKafFZ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aQ6e2Qg8B1QckRoHiTHmhGmnceAOugoySCs9DbxM49XyV+8ShwZXA9oqJpPPkEAJ5JDsaS+YkGqiuHSGLXiYNjMsa2bYEEd7hHgxwnwtgfOX1FqNQVwHODo2Arov/opuFGD16yGa/fE9m8RmRK9YQnh3sYJ85Rdhdo4fSpfRZKF8hJwzeepcAJt9gH6O++ZLJ+87TQJmOkcebclN8j901RB6lGUl4XZSTycJfr6QoXls0j2yn4O3WjdnsmSgUMysYm3QxDlaLIB0MJQxe1wa8gjJyNJhMLrRvaB2+DNG4+TzSqexiBftkL1wmB5088VvGIc+s6NXyKw2w7TM5mACW0nIGQG6N6+LKKeWGiqqriYH8R+5M0hxoRUYWYzbX2xIRriswRDaGyyfLpvRHLzeAF8zZjsZfkconAiPQKJ6hqdTmnmuaOWfYnAZUyaT/e5fwh0pqXT1J7REHCBw7WR1af9odmF6mRTywomFDJL86mzS0uelGLnk/wUmqVcksABqJprPDjfGZBNClmCQlfSdECljiInsU/UGlJdnY2pTcJ8JMpoy4ABpI1a46+6Z18eWJAvrVpwU+iO/PBdR/TAqEDm80+D9472CEjUOwIDaPyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079d2151-2fb2-489f-ab2e-08dc6dff325d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:03:21.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YsVfSgViazvkRtB6G9wxOBi3atR1KKr3wU2gGdMypsxfEO0FcTTb3E8kwW+ugHOpY9B7C0Pv/dK3rX/4cyvPMG3JNhIFP+DtdeYzsvvbhr1eM7cNLBMBworZtr+OL0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060137
X-Proofpoint-GUID: jSPG6YUxAjT1SFSJ2bNWksm5_P6S9aQq
X-Proofpoint-ORIG-GUID: jSPG6YUxAjT1SFSJ2bNWksm5_P6S9aQq

Hi,


I came across an issue reported by an internal static analysis tool when 
tested on the code for brcm80211 driver.

The commit which introduced is -
5b435de0d786869c95d1962121af0d7df2542009
("net: wireless: add brcm80211 drivers")


In the file -
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c

within the function wlc_lcnphy_tx_iqlo_cal()

we assign value to band_idx as below
band_idx = (CHSPEC_IS5G(pi->radio_chanspec) ? 1 : 0);
 From this band_idx could be either 1 or 0.

But when we look at the array iqcal_gainparams_numgains_lcnphy[] at
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c

We can notice that it is initialized with only one value in it.

static const u16 iqcal_gainparams_numgains_lcnphy[1] = {
     ARRAY_SIZE(tbl_iqcal_gainparams_lcnphy_2G),
};


So, when we try to access iqcal_gainparams_numgains_lcnphy[band_idx]
within the for loop in the same function we could be reading a wrong 
value of  iqcal_gainparams_numgains_lcnphy[1]

Do you have any suggestion on how we can resolve this?
Is it possible to keep band_idx to just 0?


Thanks,
Samasth.

