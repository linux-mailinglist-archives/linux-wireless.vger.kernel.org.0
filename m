Return-Path: <linux-wireless+bounces-21501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D64A87BE3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A001664DA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6781714C0;
	Mon, 14 Apr 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oHbMAH8C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eWX9XOoz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44825E808
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622968; cv=fail; b=iVkj4hDMtkqBfZQDXbBuJ1b9xeH6/YfDyKxo8aCQ97h8biwJxJ0rZd8S7kewFFAGs6FMW6bLcrCRKv8gOzWuEteYF9SYM8MrdrPaNdXDB40UtOO335j2V9CSxIwt0DRR5JgqtDgk5Wz0nk9y4TCxagTHU8C10A+BtYEG8dwGh6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622968; c=relaxed/simple;
	bh=aSIq9dTJ/qfhbjtiPPvNqC6hYHJpIb31+EpnL8uvmeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baPvpKRwwTPNIGrtT0CUPMRmpPtVEU7EtJHNkRxM6QvokZsFxYaOGf2jWFn9GoAJToqnA5XJ/h3bxbCtCqRuL+a70U/QsgIbzumGW0GqtQMlXb0O7+4QUn/iSenK5iw5p7nrBiWiEnk3myRItZ8VRz94QDlCq89Dz5SyNuteejM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oHbMAH8C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eWX9XOoz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E7fomi031483;
	Mon, 14 Apr 2025 09:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/KpBwqBOOWKxc1jaumg0EE82+6UW8QKEEXF61pz661k=; b=
	oHbMAH8CtD0IixwBkcs38eu5L5ZNkJppnFotH5TaKUs6M2BwTxpDBzCJz1vSlXky
	p6eVQz0QaCNJWE9m0r7Jcb6BNdiM9d2C2X8HUQT1EZ3ClhxT5KR3XsU9ONOPiukE
	od1ranDdQ9Y7EnwpTe+QsOo9wtqST3Pld4F0dXZIFHr2ovtJR+iXnT6vI5Ah/wGW
	wUJWKeg8xL8z27B35bCyF8wIAXUBCfLuk3HvPdbHNhLoCSRZVUVeyvRLnrhDyOCh
	xNPUOzTOOA3I1IConMZkJmGSdrjlu9rGLmlt/jofmO+WcpIwO75MLdxK+Gj1gtPJ
	ISmptvwmvQjnACLzYWSO0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460vc8gb2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 09:29:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53E7UNnv009180;
	Mon, 14 Apr 2025 09:29:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3g9bfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 09:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7RA6/2KRxOWN0BtCAjzvyLZ04ItbtEMCeP93GyXjyCtHjGfOSi/QGNnnN3em5D/sQdCC+UD2MBfKA2AT3sqSRRRMix6FRiqOLUQxu9FWMigBZhnPlTd+0hk3tpSqr0VA327jfgps0KEL41ch+AwzRpSmVu09bYOZCHxea/iH/5eixjXvkt2zaWnUMwKkmYkfIaiKHhSa6zdejPY6z9o9xlEoS87MCM2NOYl6W/1VLuBC8maPySyUjqMfCULIupq01RaFI+2JQjErWQB3FB0/wNhP88bXxg1FkOuMcrN0bk12aMXfknAtOzV1Tw8H7T6VO6oXjwAWqs18yFtHUGmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KpBwqBOOWKxc1jaumg0EE82+6UW8QKEEXF61pz661k=;
 b=EQsiWe8VTuDGtnEQAn5bssTEy1tb9zgTas7N/rEg/k8rqGZVOsd6r4DGDmHevQPLvZjtppEuXzJH9WXla3cnN8+6Xg9n9peLOgfxbtIF4Syn2KqwUk9nMxoRIZTcVyyX5Lxeq2wk3uFZffV1W18WmC7lpYlZtMfJtZ8JQ2laxz3tFAqhaCQiF4i3EhQRVBRNtlNGU7Q/HKpPaQKS4JKszkvf1hRR4kPtB9YVMC+Nr849iFe99tVjnYJYGVfyAhoFhEF18n8LGMfC+CWvXHFzpl7Db02kQQ25lb+mbZtOzqIVJS+cYGwGWkyg/Wwqxz2VN7nQg65vDg5U6aDar0hQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KpBwqBOOWKxc1jaumg0EE82+6UW8QKEEXF61pz661k=;
 b=eWX9XOozN7LMWoAC/ZDXZ32URSMVXzS/c0j7tDiwqu+h1Oj5wvQlV5T7OrC1SnF50U1AuC7ZmTnnW4jDk7U+fVw8bvX7ZKHbzSx03nPiUlKu48r61N9ezTqXFBm18q5YyZmA5DpXxQkaCOXlvZLDEMzAR/orTdWZLN6/uCRjTtI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:29:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8632.036; Mon, 14 Apr 2025
 09:29:12 +0000
Date: Mon, 14 Apr 2025 10:29:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing
 link interface to prevent duplicate deletion
Message-ID: <4930255f-87d7-49c5-b53f-6fa565cd3a56@lucifer.local>
References: <20250226113118.7626-1-quic_lingbok@quicinc.com>
 <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
 <21ef1321-b079-4749-a675-dcc814f9373d@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21ef1321-b079-4749-a675-dcc814f9373d@quicinc.com>
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: b07eafb7-6e32-40b1-315a-08dd7b36d0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVhqUy9xVWZ6K3pMTk1ub0dkdHB3NVNtU3dkWmE5ZzhSMG8rWHdTTjQyT0cz?=
 =?utf-8?B?RW9xMU51ZjhHd1QrczNrQkJtbGMwZGtrUHBCeDY3N0lMWExpZFlDcThNSTJU?=
 =?utf-8?B?cWhrYTRDMlgvSm5LVUJJUzV5b2xyWFJZbkhxbEpkR0FBcllveGRJdlk1YnB1?=
 =?utf-8?B?MTZzRlZsanBFQ2JDTzhZV3FYT2lyNGkweWs3Z094QXl3UTNzMFM3ZTE5bkQ3?=
 =?utf-8?B?eWZzWFZjWGpxUERjeU1Ib0tpSkk0NzYxdTJORjVxZ1lma0ZJaXVxRWJnZ3Zt?=
 =?utf-8?B?OWNsb0NpRFlOeno4azBMeW5mUFFVVFdKRUxYNW9ScDZzZkRhWkNSWEduTU1z?=
 =?utf-8?B?ZlkzT0RLODJldTFMVGFCaXNsMUFhSGJJdEFidVdCa0R5Nitaa2NuWWR6VFBw?=
 =?utf-8?B?ZTMxbHJybERaOEtjQko4c3NiMVkwd3V3VmlTZWtvRW9VZ2tJeEk1akF1WWtG?=
 =?utf-8?B?WVJpbkw1QmVkVGgySHdDWWd6SEdNQ1JZWVRnaE1WVmNHM0hodDBZOGtJaUts?=
 =?utf-8?B?MENmRU5acHdReDhFSVNreG9rK0xORXJTSEZUelRRVmUrN3ZWcEtqcTNuTVlO?=
 =?utf-8?B?bThxN2JTb2thWHpjYytmM0dvQkxuZlJPSFFmVG5KWkJyLzM1NUxTbnpaaExm?=
 =?utf-8?B?cUJSYVFBT2c1bENWNi9nN1JLRGpUNDRNZ1BqZW54R3lheVlCcW1GbDZsRitv?=
 =?utf-8?B?MnlicHdCaUU0SEZQWFo5QnkrVGVDWVlLTnFWZjBRNGVXRDdLWkVHNzVVVTB3?=
 =?utf-8?B?bUttQnhBSnA1UTUxQjdNNkxaWkpnSUZSOEU1cXBPVW1MdVJMd1pnVFhKMXB6?=
 =?utf-8?B?L2Zvcm5uMVRtZUdDUDFudUxLUFlja0htZkZjN2tkVi83WDdEQkxVdUthblhQ?=
 =?utf-8?B?SkdNZUFDanFDWGM0REhqUTFIWTEveGh2ZWdSRk16KzVNaE96bTlTcE43Q1Rw?=
 =?utf-8?B?UTQrWW5ESGI1b0xMc2tQQzVHUDBhRS9zUDhSdzVIRElqYlhVdDFiUkYvSUZo?=
 =?utf-8?B?NEszaHNZeHFCMCtmcWpXOU1EdW1SaVVGR2p0eHU1a2tyRFI5aDdUQnpUT0li?=
 =?utf-8?B?K0NGcThsalZyU2N1TVd2YWU0b2d2REhOU1dQWHlyZ1ZXNFNlSFNjWm1lWi9q?=
 =?utf-8?B?ZDFsWkJjVEV2bFJuanFXaUJmb1lYSno2SkhieW42M0NqRGJTaGhYd2JCR3Iv?=
 =?utf-8?B?ZUZDS2Y0WEJDVlZ2bVYzYVFUWGtFR2ZjaEtTc2N1T2xzMWVhaUdUTnVHdkth?=
 =?utf-8?B?bGsyT0FQdzhJZUVKbmtQc28xNUQxMWR6YWhHQnRLeFV2SDdoWFhmTFdBeDdP?=
 =?utf-8?B?QlJUdVhRUnN6T2NTWExKalZxRjlZZ05PL1FSM0t0TVdYWG83SkNXWkhTakpC?=
 =?utf-8?B?dGFBalRHb28zMVB6dk5tY2ZlbmRJb3RlR3QyNlVvcndPMG1Md3BtSzQ4Sy9Y?=
 =?utf-8?B?b0lXN2hvaHNCOWZxYlFpR2FZemhWdEZWTlNPSDJYeDZVbDVJTVJMSWQ2Y1R1?=
 =?utf-8?B?UXBaNXd5SXFoOTF1SFVLaUpFeU12VUhyVlV3L1orcEU0SlMzRG11VUVVZ2ZY?=
 =?utf-8?B?dVBpVnpWVWovMEhaKys2Ym5Oa1JtR213SHFGdEFUejhidmdrckNIbXJWMkdq?=
 =?utf-8?B?ZEZQWmMyaUVFY1ZYRnB2bDVMV2NHN1JTS2IraTZVaHVHc0dDZHhWbDBjblRL?=
 =?utf-8?B?RmdmUi9kSEc0WllTVldHdGxiS095eVdhNFovYmw2SkRQcC9TYTI3TlZrUllx?=
 =?utf-8?B?Qkt2YkhNS2lnUTZtQ2c5VEhxc2ZESUNCMXdFRjZWRG9IMUU4KzBjdXdyYXhp?=
 =?utf-8?B?Y0t4WERNdWo5T21Tb05zcThmYnQvS0FsaU9XaFhTSTVwU1AzU0lkaDRHSmZV?=
 =?utf-8?Q?nsP275YFZfTBm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnc1UlBkTzFKa1gxTGJZeSttTFFwSWoxS1pUb2RtYXJWVmoxNENzMHdwakFD?=
 =?utf-8?B?UFhQSDhUOHJoZXRiTklLOVIvNTI1MXFxbW1sZkI1UkdNcHVWb3k2VWdIa0hJ?=
 =?utf-8?B?RTlnZ29WL0xLY3paRjRJRmFoOUVHYXBVdm9NOG9GdU12VDZjc2tQNDJNWEFa?=
 =?utf-8?B?MWhFazhUd0JsQnArdnFFbTZySkd3RnZKZEFBKzVYa1cyemhxVWhOUEtSZ2tE?=
 =?utf-8?B?Y2FFR3NoVDJHYjhBRGhLK3dlTXFiK1MyVEdUQ3cyZERQSmhxZDNwakFobjho?=
 =?utf-8?B?SFA2NEUwOFJlV01lS3JwbXcrNzh4Rm1nRE1lZDVnRE5Oc083Z3lsVkFCODZk?=
 =?utf-8?B?eUxEcERHWmxTeXFPWU1wWVlIelVPNHUzY0VYSlNFM1c1UGNrZmVYNkRKd293?=
 =?utf-8?B?SldYcFduMUtUcERyUFBkajcrOXVTRzlJOWVZaHQrYXRRdisxTnNvN0lMaVNG?=
 =?utf-8?B?aU4wNHNwamROcUIxSmR1U1NaS1QzUXdIZ1luOVljblVHcS9oanRiaW1JUm1V?=
 =?utf-8?B?YkNkMy8zazRjVERFRmZJN0JOUkQ0ZlBYNU5SL2ljQmwvMG9oMTRSRC9IMGt6?=
 =?utf-8?B?YmgvTHQ0aCtWVmF6TXd2YnQ5cTV6OWU3emxIdXEzUGZ2Nmo5L2xsRlFxeUU2?=
 =?utf-8?B?T3diY3pLRU5GN2VjMmg1a2NjK2JER2NNRjZjT3cwUXFlU3JJTk80YmVEclZ6?=
 =?utf-8?B?RFpUNkhBVXlaUnpJbDdDUmJFbEViRlIvTU8vRVBKK2taOHgxTVhweTN2WE81?=
 =?utf-8?B?Kzl0dGlLKzYvSkwzQU80bTVmRkFOTEZ6cndSRG95WktJeEo4cCtwNkxpekE1?=
 =?utf-8?B?YmRPNm13RmRabUlNZzVVTDNEWlhtSlFsaGwxSmVlTEtUd2lZVVdGNGVWTU1J?=
 =?utf-8?B?UE1QSGdQcUdHM3NRUFBmQmJVcHhlV3QwaVRqbUhWZ0hWRE1aYWhKZkQrQ0JQ?=
 =?utf-8?B?UGU0cUVPMXVmaWhpUzlkVEs2SWNHTEp0QlZUVXA4REVaanR2VmNhTWQ2YjJO?=
 =?utf-8?B?RkFwU2Z1M1VzVUQrQ2YyZEo0SDNnSEp6cHVtVHBvdzhWNlZzZGsySC9QOURn?=
 =?utf-8?B?bjJDRzV1dzM5eXZHdVZORGhJT3RSbDRlMzNaN3lodzQ5WXE1QU84b0lNTWNI?=
 =?utf-8?B?TUs1Nm5sSGlYVngrVzg4WGpnS2hHWTQ4K0pwbG9ZY2t5azdJdnpDN0I3TitV?=
 =?utf-8?B?bHFqdnRLRWszVGpYeFFKa1RNYmhGYWFqRW1sd0JLZFRRMGxKdVlvUnI0aDk0?=
 =?utf-8?B?ZG1iN1B5bjM2VVgyZ2M2eXpGRDdrYjBXRVRXdTJsWGxlTDVpVUdSdHZrZnhO?=
 =?utf-8?B?OGJCQ1pNdzA0cmxaTXRNQWxvODRWN1dqekl4bVNYSDg3N0poYVhxSnBxcGRP?=
 =?utf-8?B?eEtVcmkrdHh2bURoZmp6NHllejBxUk9UU05Nb09ZUzV6VnBkS05GVFE3S3Zp?=
 =?utf-8?B?UzFGNXFmcWt5WlRMam9iSzBmM2Q5a2IyeERLeGF1MFdlQ2RuTGFyUEZDbUNu?=
 =?utf-8?B?TFJyNVZiNThKK1JjbUd5SlVHZFR0TjNuNkg1MGQvd084QjU4Y0FGRThsYWVC?=
 =?utf-8?B?VDV6NEl0YXZ1QWdDM2JYbXRUenRjQ3p2d1c0NWxXK2NKNUpDK0JzKzZaRWda?=
 =?utf-8?B?TWVTRVVySlEyemJKc1NuRkg1ZWRlUXV0RHpZdjN4M0FUSU9HNERKU2VQRXR0?=
 =?utf-8?B?QmJGdW1qRVMxTmtLbVhaWENmbTMvODlzNlZqSmFkaTk0clVjamR4UGZBSldU?=
 =?utf-8?B?eGRGa3ZETlZWVGE4dHVHc1VweEloN09lejZqS3RZUkVkSEJFTDZvTmRmYlky?=
 =?utf-8?B?RWdiRnhZSWF5SS9mcVlPdGVJNjlRQ2VQTXpRNGY4aWI3eHE5ckdUMjNUR2xn?=
 =?utf-8?B?Q3NRZncyV2MydjVYN1AxbWx5QWdBTnFFU3dyNlhPNmNvQ0NVaG5kUW9GK3Vl?=
 =?utf-8?B?RGNVeDJRRDNsTVFPelhNeHRWN2hMY1ZieWhwNTJXUHZveGdvYlJvL3BEc0tk?=
 =?utf-8?B?UGM4STdHMGZCMGpKcGpXZTZ4blh2VU1rTk1WUW9ZZGRrbm0yOVBJbnVMbTlM?=
 =?utf-8?B?OVBQMlcremxTclZCdFp4bGRHaXozNmlVWUxFWm9takdiSVcxUDFWQnM3Z1d2?=
 =?utf-8?B?aVh3QmtsU21hcU5GVEZRZEg4WWJVMDY0VnZiNUdNUERYM0dVVVVqaTI2OHpQ?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MobMNpTqb7o7K86LYa8JZzfTdh6VXFG1fTr1X2VyIIycl4ZSznfOqp8kJHlUkB2sCyo1wYeFq0zNHxqcN7C6PG7xqaB9JxjgAGDYnxdkFeA2Yv/29HFL0TjcY3beyewlt/7Z4kCfOcXdlgvyc7q+CohV2l6vAoHCdkR1CM2q4DGyv3thL5CppItT8buIVDi7pKUtXshO1nuBCMUDrQUnF8zYGM1+LAa2mCF8j+G81CV0NUgXFhIvhhHJ2ge2rWXJBa4H8aDIH6WG0O4LM7pIM3ej2R1CQ79pWh04HOLPFd8JkKOKrxnUK/Nzc4Wxqsu3jMod7r7/ZdFJ/vj8MDHuX7ZgOI0aqohLemE9fVPthdicE5NC3M9AdXQTcQ41XkiicHHKwzUPz3WUIBU3ELOXg0A88YQMyZMCdkCxTxhqvwJWzxGU2i9Qxe2ubZoxpqUj+ehANlgOsauYs03QkbHfA/oQ/U1ZlR8Oq6XmXaLQ9rU/OtXcaNpU4qPYaWYdHJ1jBiAvyMj5rZv1wL3xXYPKf22kVjf6HOkyIVfVbxf8OfcX9dqtHlDweIW7+hnjiAfoUGyLuOzpsXZWnB1k67IUopQFb7YlSqSSFReYtG8ZmmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07eafb7-6e32-40b1-315a-08dd7b36d0de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:29:12.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh/EXMpJxQ67DHApc5SGX3Y6QYIVlDn46XTG3helnYngqJjRujOkZnzig4yoO99O/4gXOieht1kkqZWUSLnhxXPasYTgSPEobsJHZY7Wgyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140068
X-Proofpoint-ORIG-GUID: k-4zH1f9p9YHDOA2nK3ykbLwQPyJDChd
X-Proofpoint-GUID: k-4zH1f9p9YHDOA2nK3ykbLwQPyJDChd

On Mon, Apr 14, 2025 at 11:27:47AM +0800, Lingbo Kong wrote:
>
>
> On 2025/4/11 18:05, Lorenzo Stoakes wrote:
> > +cc Oleskandr who kindly pointed me at the v1 of this patch (see [0]).
> >
> > [0]:https://lore.kernel.org/all/20250124093352.481-1-quic_lingbok@quicinc.com/
> >
> > On Wed, Feb 26, 2025 at 07:31:18PM +0800, Lingbo Kong wrote:
> > > Currently, when ath12k performs the remove link interface operation, if
> > > there is an ongoing scan operation on the arvif, ath12k may execute the
> > > remove link interface operation multiple times on the same arvif. This
> > > occurs because, during the remove link operation, if a scan operation is
> > > present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> > > from the firmware. Upon receiving this event, ath12k will continue to
> > > execute the ath12k_scan_vdev_clean_work() function, performing the remove
> > > link interface operation on the same arvif again.
> > >
> > > To address this issue, before executing the remove link interface
> > > operation, ath12k needs to check if there is an ongoing scan operation on
> > > the current arvif. If such an operation exists, it should be aborted.
> > >
> > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> > >
> > > Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> >
> > Hey, thanks for this!
> >
> > Not sure on status of this, has the patch been taken for 6.15? As I don't
> > see it in Linus's tree (not looking _that_ hard though). I don't think it's
> > even in -next?
> >
> > I keep hitting issues with my X870E CARBON wifi onboard motherboard wifi -
> > most recently I saw a null pointer deref in ath12k_mac_remove_link_interface().
> >
> > This occurred when I tried changing the network interface, in fact I had
> > first clicked on 'available networks' in network manager so quite likely a
> > concurrent scan.
> >
> > I rather stupidly didn't copy/paste the text of it, but you can see the
> > report in screenshot form at [1]. Apologies for shade being case on ath12k
> > driver but you know, frustrations :))
> >
> > It's difficult for me to test your patch as I am having pretty awful
> > firmware issue with this motherboard - if I powercycle in any way that gets
> > interrupted, or especially if a kernel issue arises, then the ath12k module
> > will not load on next boot, or at all going forward.
> >
> > Updating the kernel to, I think, a recent 6.13 (and now 6.14-1 where I
> > observed this issue), got the wifi working again, seemingly randomly.
> >
> > Usually I have to try to reset the CMOS state, but doing so causes other
> > issues so I generally try to avoid (I have a network workaround involving
> > an ethernet wifi adapater, it's pretty... yeah).
> >
> > So I assume some non-volatile state gets corrupted somehow, I'm not sure if
> > you had any insights into how I might more sanely reset that?
> >
> > Anyway regardless thanks for your efforts, if the wifi adapter appears
> > again then I will test this and can give T-b tags if so.
> >
> > Cheers, Lorenzo
> >
> > [1]:https://fosstodon.org/@ljs/114318530969496869
> >
>
> hi, lorenzo,
> sry for delay response.😊
> as for as i know, this patch hasn't been accepted so far.
> for your description, you find the ath12k_mac_remove_link_interface() have a
> null pointer deref, i think maybe there is a concurrent scan operation.
>
> i have a suggestion, you can apply this patch and observe if there is still
> a crash.

Unfortunately as I said it's really hard for me to test this since the
motherboard wifi is permanently unavailable due to some cmos state which is
really painful/difficult for me to restore.

This is another bug/issue specific I guess to my motherboard.

I can give it a try if/when that ever comes back, but I really can't afford
unfortunately on this machine the time/risk to try to reset mobo state as things
become unstable when I try.

>
> can you offer a detailed crash dump?

Again, unfortunately, all I can offer is that screenshot I took, I stupidly
didn't copy/paste it.

And it seems kernel I was using had symbols stripped so hard to figure out
exactly where in function it occurred.

>
> /lingbo
>
>
> > > ---
> > > 1.rebase to ath-next
> > >
> > >   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> > > index 3e3afdc56fc9..551133483f44 100644
> > > --- a/drivers/net/wireless/ath/ath12k/mac.c
> > > +++ b/drivers/net/wireless/ath/ath12k/mac.c
> > > @@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
> > >   	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
> > >   	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
> > >   		ath12k_mac_monitor_stop(ar);
> > > +
> > > +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
> > > +		ath12k_scan_abort(ar);
> > > +		ar->scan.arvif = NULL;
> > > +	}
> > >   }
> > >
> > >   static int
> > >
> > > base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
> > > --
> > > 2.34.1
> > >
> > >

