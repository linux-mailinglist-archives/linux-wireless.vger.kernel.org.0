Return-Path: <linux-wireless+bounces-7366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914328C07A4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD2A1C210C4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 23:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F712DD8A;
	Wed,  8 May 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GP0hGO7q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EiFoXAR+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41868626D
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210899; cv=fail; b=lu6EfvqjVujwWYjIJcypI/98OifkIetNCh4Z6xwYjKvWgmG6AeyB2FRRWruCibpvaEddcqPeOoxBFxGgcMHf0WuOB3Av8KaUqNcKAFXf+U+KSkn3UxiTJrYfjRSwGXqhhd2BBwCao97/cLcrhgbiI7/NCMfixr2hlQphH5PcJOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210899; c=relaxed/simple;
	bh=POR/xj2KC4Zu9vswVUAseHZM0VNtAWINIWIGGR1WqjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkGhD/xEhzeNkQFL8sTtWRq8YqtiKZzUBaJgj9Cm72dYjJZxFclbBYNpmIHZRtMi34rqrmWhAUJp+zOqZb6HNaITzVG50/u1j8UMfN2Gbgrjzm7klYqfqfafaJAltfiVm9Jvgb5/7+/zclhFYxv2vLn1rLO/C1Ij7aYADG4ccho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GP0hGO7q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EiFoXAR+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448Mu3Xx002426;
	Wed, 8 May 2024 23:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8PKLcwoixRLnaIgi+SpR6M+g57VchW5Nx9+Zdy4tEnA=;
 b=GP0hGO7qr24pvcwD8KYMJbLPAtWDXnCN4JPbqYGM7qaGJU+VxmSufjK1GRydgQ05t8Qm
 VYOispJhGxgV/MAS2UAfmZpjqo1DvY5NGbVdEjfdIhynEi2qNM2cRBq7qvvAqhWJ+caM
 KQgTTRmzbj2QClzaXnFKY3fP7wa7X/chK6V6rQVfHkb1jMjPN+TQNohcQL9ltWdrrkDH
 mzpcIG3bFzca1ii437rFYuMKkDKbeAQCFHOhBSv6o8IhmXJbzWX3WQ9tDFXjOAdAk4Th
 yqBVyuCF+X8kbrs11N5qq/ENwBlQ/zw9vs9mEZXbV3MZW/qrOxlDBjmRIhVYDKFKCu4f yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0je4r19r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 23:27:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448LW8vD031112;
	Wed, 8 May 2024 23:27:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfjf43k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 23:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxSDJi58BQKcsx2LlqG1uMi95wjTuzA499krsNLJYmFd3xxuJ3l6eQnXnmXEGEx6bE9zO5H/ePWiKHrNMGJflPvXMHjO65NtBJI39+pYjf4gMqB+QQMEU5xCCR4S9mikTsRcOx6mLPg37TID4dPpqhi8oGtk3kI5dQhdfC6rgRmIU0BxcrveEZeuB4dvBGqz2NU2qC6BUlOINltHOHIma8CNtXEDBaoOw0n65Pjtiy0sg1WJRuVUbi3cPpNKw4pbjwZY1coeb14U9vpxtQllVhwSkTxbTnASPMBWFMjvCZZ4XDXgvZU/EkTk3kURVSdXPYlUy/PzCzi7M1HlBQUe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PKLcwoixRLnaIgi+SpR6M+g57VchW5Nx9+Zdy4tEnA=;
 b=nc+XXWomA5Ptgu1wki8VjdzyG2b42xo65diN3WW7R4Tl5GwKkkaW9aJosvdkG4Oip1YRor+aBGGZXhfHsde1uw4K9r7r3qReORypJPT/Amv7SdfwyTNWmjXYSaKEhyUbCHvaI6y+8mc5DLM/pIFrrmZY4mZtBnykuQbgefmzC2bAxgI0L7Ri5uk+abd38rgu3wyC6yP4VpTzd/rNY3TcXCPODyD4w+QshCQ2VWOW0NbLo4Z5k+d1oFKjfT8YopE0I9BJEUqxTE8OubX6ehx25kQ49Pv7Q0pCzkd99ZS6/OK6fU1yZm83ThHNpHt+y1l93VBKlTrSeLKt63Dtm0DDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PKLcwoixRLnaIgi+SpR6M+g57VchW5Nx9+Zdy4tEnA=;
 b=EiFoXAR+/p8j+qqzNSlME3fpr+gh7eAtoOnFvh6LixXnYRVBy5U3O3hVl6k+E54kipfW5BwInBXLJirCO7nWmOHFYnWxrvROsRFnC6KAxwSBxjqU7YGCaExNl6h4qYkbRMDn1smSFmtbk7sApgKDyHrnBff6j9qR8ZuDClI8s4E=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 23:27:41 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960%4]) with mapi id 15.20.7544.046; Wed, 8 May 2024
 23:27:40 +0000
Message-ID: <667bb700-1cef-4969-85e7-cf2e9e5be7c2@oracle.com>
Date: Wed, 8 May 2024 16:27:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: Buffer overrun error found in brcm80211 driver
 code
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
        "John W. Linville"
 <linville@tuxdriver.com>
References: <8292faa6-a2f6-4b43-8d60-9eeba85aa6b1@oracle.com>
 <c8d8ac40-d4d5-417b-a67a-8b1fb016d2ca@broadcom.com>
Content-Language: en-US
From: samasth.norway.ananda@oracle.com
In-Reply-To: <c8d8ac40-d4d5-417b-a67a-8b1fb016d2ca@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: f86f08b8-77a3-4040-9899-08dc6fb67398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?amV5dk93Szc1QWxBM1Bnd3Mya3RDd3d3R0dDSmdsQ1NXUWM5U0FhdEdMOVlX?=
 =?utf-8?B?TkdzQWNJbFNmREIzZ2hkNUs0THNQbzdva0ZWTEZKMTJlUWJEeDhkZml6STh2?=
 =?utf-8?B?SVZqa1lLenBjS1lsdmMxa3FVSDAvVjlvS1psMFNRWndVQ3pnSzR6d0xSQW9U?=
 =?utf-8?B?ODdBeWhsMkFYZ0ZEYUszS2h4WHNHNTFhQ0FQSktvcDhzTDNSSE5zOTBqTXh0?=
 =?utf-8?B?L0k1QzZDTFI1TjNUT3RBNXVyNGJZYXFPQmRQZlFtZ1M1RFUxODNxY3hZSjFh?=
 =?utf-8?B?bWdFR0E5ZjBCL2d2MFI4SWtmZUJNdlJSUjdKa013c2ZJRUNjUXhnMVBabFIy?=
 =?utf-8?B?OVJMenVWRm9iOVBKaitUbVlJRVlNNGVOSFk2WVZHd2JwU0ptMmxISWU0R1Nk?=
 =?utf-8?B?dkFaeUEwVnNQYVlGNGhQTGwwUEJ0d1JIWmorY3dGMWZkTzJzNlphdWNFT2Nl?=
 =?utf-8?B?ZnQrSlV6dlNVaGN2aFlEQWVwcUlnVmNTQXpia3pnbUZEUkhkVVkwQ0lkNWZW?=
 =?utf-8?B?VUZObzZMYVQ3TVJSNUNzd25RcmNPMEljNTY5RVdQVWVwZHhScU5RclNNZjUx?=
 =?utf-8?B?RjhmU2paMy9LaUlJZFkzTEU4RTB5c21GY0FFdW1ERHg2dTVrTGRiZmkxWC9h?=
 =?utf-8?B?NE1WQjh3bWVRVHBidmczSFpjVDJWSGJacVZSaGc2Y1NQM1JLYzVEMkJNd3dZ?=
 =?utf-8?B?ckxMM1VpU2ZWZy91dG4xQTAyeEYyZmpiMUpVbnkwWkxpSkJvY3o5bk5sSG9T?=
 =?utf-8?B?bEVSZEZpK2hEaThVRFl3dWo0NzJlRnltUU01dTZRMEhDNnZjVWZnQzRGYXJO?=
 =?utf-8?B?Rmg2TFdHYjl6U3diOU8vZ1pTNlhNM2tIOG5uMDF1Z05wOFhQY1hMNGFTQ0VX?=
 =?utf-8?B?RjJ3c0gxek1ZSnVIbGpRdGEvUHRKOVkzNWcrWUMrVTFyUWJab29ZWisyNkNZ?=
 =?utf-8?B?QW5FSU1Sa3B1djFVNWN1N0kvVkNlMWtUZGE3TnpFVDhpak40cklCaktIdjFm?=
 =?utf-8?B?UzZPZG5TOXcxMEltVkFiNXduSmZVb1ZiR2cyQkhOMGdBTlZYaDB4ZVY2WjVF?=
 =?utf-8?B?cys4WERPZHNxd29KZlRGbW5BM0dGQmZLTjc1QWRyMHExdWZlV2YzVXlXZ1RY?=
 =?utf-8?B?TVNGeTRXalc4dGpOaFFZclNLdTFrNHVLeG5hV0dUWXo2bU0xZmR1VVVyMm1K?=
 =?utf-8?B?R3BGNWhHbWZ3d1FPc1hRUmJwdlFhaTR2MUgvY2g0aDRzS0Nkb1BCdlNCQnRO?=
 =?utf-8?B?blF3OUd1WERKaEVYK2srZ0hsbWR3L1p2MThRVldiNG5QZFVFSmN6bkVWSTMz?=
 =?utf-8?B?c1d5eGdzdk5BMjVTSDNlRk0xOFB4dlUvOXQwandhTERSeUZOY041Nmh2WllX?=
 =?utf-8?B?Vlc3dHZSZ09qalZaUHJ2V04rVlZza0NNa0VYUmU2UjlBYnZJSThwVm5xNVVv?=
 =?utf-8?B?eTNaUnBhdWxISmRudTlFcXZWeHRvRDZ5Qlp6bDZiaWt5K3FRdXBUbDBlbEUv?=
 =?utf-8?B?MmJQWWpGNk9hQmVzMTB1SW5Gc1BsYUg1NjVBVEdOZFY2eTV0MlZBa0k0VDMw?=
 =?utf-8?B?UkZFcGxNQmk3WkFRNW1OVS9BSkRKNy8yZm5heVBhSXZUWlJkWThRWkg3Q0Ro?=
 =?utf-8?B?MDBJOVhvS3VSSksvbnBLVEl4ekZhWWxIT2JxRWt0ZTlqYmloWU1abXU1blo4?=
 =?utf-8?B?YVBCbUx5STQwQm14MEZ6M1lWMjhoMkhWZEFMR0ZwZGxTdlNoU0ZKSVdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHMxV3BVbGdWdE5QTjdIZEhKclFBN0FpbGVyTzEveW1wRjh6MDIxQ1AzZzJ4?=
 =?utf-8?B?UE5FVHNDUW9GQXVHVWU4d0grc3NPbTVma29ibFFhOFlUaDYwZjhCZ0EvcWhI?=
 =?utf-8?B?a25ZRDZrWWNhZ2pjWlZKSFk2VVFPWnN4RWcwNmJBN0JUa0hPVURYNXZBOEFo?=
 =?utf-8?B?QWhDUGNRZlNxZ250akpyN2lFdUEyblJQYVB1U3BkNW4wYXlTS01ZcXp0OE81?=
 =?utf-8?B?eVl4dVluUUVWaklXdGhBWWRKVjhjSExLMFRwMlVIMHV3TjUrak1OSnVjU0ln?=
 =?utf-8?B?RkhHVWc0TmpMV3RTQmRqeSs3VzlCR01RRlZ2dEdMek5kbTJwWGFlcElIOFBl?=
 =?utf-8?B?RVVGaU1FMFBWUDlBRndxdDF5ZXRKZ1NobFdtQkEzT2xWVmRUUkdSUk9UZWJM?=
 =?utf-8?B?b2NEU3pJekNVNlBmcGhHWFZlNlFNWEhLSGcxUWhwb2lUY1UrdXJBQWlaRVBl?=
 =?utf-8?B?aTJBQS9acWxLeGhkNjllcWsyRVdGK3V4VFFqbVpQRjZiQk82UVFpbmtIc2xy?=
 =?utf-8?B?S3RqZDZlN3oxRHpJTm02eDNhWlN2SHZsVG9abytEbDlDaHdDYlFuSUQxelhn?=
 =?utf-8?B?bnRXZWo2ejAyOWJ0SVhTeUxWWnpEcmJhU0lFalZXT1hzMzM1cVdaZ3l3N3Rk?=
 =?utf-8?B?bnMxbVVIdWIwRlFwTm9QUzdDQlhVTU0wMVA4bUdzeldmeEg2aVUxdkE5QjZD?=
 =?utf-8?B?UDIrUEV1TGkyamw3SzBoV2g3LzJjdWFuUzUwM201bE9kSUlQS3RaN0tuVkxK?=
 =?utf-8?B?VHV5WDVvRVRsWkp0bENhMlUyOTAvdU96WnFtaVBpYUZvY3RuRHhoWEE1T1Mw?=
 =?utf-8?B?ampRYlZkSnhRaWo2eG1lWlpKWXE1ZTIzSzdCTXlaTG1NODVnRzBCalVjV2dn?=
 =?utf-8?B?ckxYYTdHUTBjaGNEaTZCNE5JNU1VM0F3MzRiK3JPRUs3YWNmWnUxTi9TeEpE?=
 =?utf-8?B?Ky9UbnJxR09WVG9uZVJDSUV5RTRGWkRYMVQ2RXYxZFBJSk9rWW5CVG1GL3px?=
 =?utf-8?B?OWRRVGhSNTRJQkFYR3AyNHJreXJYeEplNzlaUzQrQ3daWFl0M0lKM2syNC9t?=
 =?utf-8?B?bjhsN3o1bnRWRDZ0RzQxWGpzZjBwWnpNeVRBTjMvY2haazFsSzJpVUxPY3Qz?=
 =?utf-8?B?UUllTWtmall1Z3FvTVV0dk9uZnJCeWdmNUlrYzM5TE9WNHcyT2FKRzJyR2E0?=
 =?utf-8?B?UGtKUUlpaUM2REg5Q0VSREFmOUtEZ0Z3Y2FwOHNDc1MzellpLzBLNStvYVJH?=
 =?utf-8?B?bUlzM0E3UDE1MTBPay9YbFR6U2dneEh5TE1PK0ZidGUwb1lPM1luT0w4bSs1?=
 =?utf-8?B?L1NjazlsaTFqRWRFc1hvMHN2R3ZHdk1IdysySktPYUJ1SUV4R2JSWFZ3anpH?=
 =?utf-8?B?WENxa1hjd3hXay8vMGVHQy8rd25QeElVWGFXdGVoS0c5YVZMWTlWZHNwNTNS?=
 =?utf-8?B?V04vSWR4MmNncWpTQ05MRERpbU9QL3NBdUV0WmxYWG1lWno0VE1pUWRMVFVw?=
 =?utf-8?B?djkvVlY4U2xDSXJzZ05reVVZOVdqRU5FSHRHWTNmRkFVNjBhNXByditJVVlW?=
 =?utf-8?B?aEFVVTRVU1FpUjNrQzdCUHpDNFZmZkxib0d3VFExWmc1Z0FjeVljZ3pZNjNz?=
 =?utf-8?B?WXl5T2FmaUNJTkNIM3B0TGt6dGVXSWYvbnBFaFdRa2RlSDlOUlIzZWxlY0Fk?=
 =?utf-8?B?bzNmVTB1UTluWEp1MDI4QnpqQTBoeWlNWkQ5STRERWNUdzRuL1dIN1JLM1c1?=
 =?utf-8?B?ZHdYcTdvWXVNcXdzdWFkaWFNclNGQWRuQjl6SE0rS3JOZVVEK0haUzdKT0pN?=
 =?utf-8?B?ek9oWlM5OGRNcVNyT0UrK2dnYzhzdjQvSkZyMmw5aWh6WndxQmc1WEp4d2E5?=
 =?utf-8?B?c0V1TmdueUNSRWppb2F0UnZwdVJoR3BRMGtIUTl6ZFNVNzZFWjhhbzdaaUEr?=
 =?utf-8?B?TWhNeEVld3p1am5mWVR4UjZyYmxyOWJ2NmI4WGtLWjdKQk43b2hOY3lpTlBp?=
 =?utf-8?B?aTl2M0l0aGF5MHMyYTNHM0hZSk1wNnZDMFB5eko3UlBaL3VNRjhxTW9yZzk2?=
 =?utf-8?B?L2QzY01aNEh5YldWM1lqMWRsT2pLQmRrMzJWZjltb3VPLzJPRkx5SENPVDE3?=
 =?utf-8?B?bStZM09CRG5pZWR5M1hYVlVVci9BWkNkSzNTZStYQWpZU3hnRE45aFY4OHVS?=
 =?utf-8?Q?VbBXfCSSU0gBIi9qP9tNfvo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+OV5b+8ZkaDS5HxVmRpntNqauKtSOGl828f1/ujLzwwvG/ny0mVjSHrXZasIR8J6zhrof/8eKP0bH7UWOtZP+3ss01RpasPVYnIUqQEWm0y5MpCHnui7HtwQ2e1+uCclT9IhCD5690VK6Hz4dfP0z/gxp9XIXKo/bWoijKa+Qfuh+JzvyGwZ41XmgehgAS/e7pXXpqjy92iLzKNPC+dqyZAVLuqI9e00ViijpbEAPuUkPqeQai3E7KyC9Zs35NbujtXtxJTVRuxun5KACX5AS/Bo4UGqTXa8WoCjITDBxRYLLF7QMjBuNbqzB3ZKZZdrgr4LiSQXF1NfYQVoReeoGKKiMuS3SOuEzHpwl0C4ALu4KlQBFhzjKEbnkTcB7DpcdgRtUBhQ1HPMZfgPxFvwCAM63CvfmtAGXropFzELTfg75KsSfDfGcSEaCKMLsKyceNYJsdP8y4CaYTTRlRZFtyznsZzjKGVeZ9+rcganC+IvshgYGubSFLvAO3jzK4EJbvUT+f3lr+PVFcSYgpu/zOHxoo6QaddI5XAf2BAIfvLdWyB29yaskO0JqcCPA2r24JGR/c56Qfgl/1LoKsm409sb+pNPGz7sY4C5vhina6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86f08b8-77a3-4040-9899-08dc6fb67398
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 23:27:40.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZL1Zz9t8ITxd4ZaD6jJNnk+/hkdrFJAQDRsgCq6Qh0C8l9QD+TP3O4GDSIEsxy4oB0eL7uuD/gVm17Zi+HnHJdIDvhhH4GXH1jnSBkQfd+Q0mFO1XHFVNp4wlxIy0Bu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080175
X-Proofpoint-ORIG-GUID: T6siaI2hqBb148VODvEi7YPGHUAOCcC0
X-Proofpoint-GUID: T6siaI2hqBb148VODvEi7YPGHUAOCcC0



On 5/7/24 12:09 PM, Arend van Spriel wrote:
> - moved John to Cc: as he passed the wireless maintainer role to Kalle 
> long ago.
> 
> On 5/6/2024 9:03 PM, samasth.norway.ananda@oracle.com wrote:
>> Hi,
>>
>>
>> I came across an issue reported by an internal static analysis tool 
>> when tested on the code for brcm80211 driver.
>>
>> The commit which introduced is -
>> 5b435de0d786869c95d1962121af0d7df2542009
>> ("net: wireless: add brcm80211 drivers")
>>
>>
>> In the file -
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
>>
>> within the function wlc_lcnphy_tx_iqlo_cal()
>>
>> we assign value to band_idx as below
>> band_idx = (CHSPEC_IS5G(pi->radio_chanspec) ? 1 : 0);
>>  From this band_idx could be either 1 or 0.
>>
>> But when we look at the array iqcal_gainparams_numgains_lcnphy[] at
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
>>
>> We can notice that it is initialized with only one value in it.
>>
>> static const u16 iqcal_gainparams_numgains_lcnphy[1] = {
>>      ARRAY_SIZE(tbl_iqcal_gainparams_lcnphy_2G),
>> };
>>
>>
>> So, when we try to access iqcal_gainparams_numgains_lcnphy[band_idx]
>> within the for loop in the same function we could be reading a wrong 
>> value of  iqcal_gainparams_numgains_lcnphy[1]
>>
>> Do you have any suggestion on how we can resolve this?
>> Is it possible to keep band_idx to just 0?
> 
> Hi Samasth,
> 
> Did some digging through the code and the only device for which the LCN 
> phy code is used is the BCM4313 which is a 2G-only device. Hence the 
> band_idx in the code you pointed out will never be 1. My suggestion 
> would be to get rid on band_idx and always use 0 instead and add:
> 
> if (WARN_ON(CHSPEC_IS5G(pi->radio_chanspec)))
>      return;
> 
> before the kmalloc_array() call at the beginning of the function.

Thanks for looking into it Arend.
I will work on a patch and make the changes as you suggested. Will send 
it out for review soon.

Samasth.
> 
> Regards,
> Arend

