Return-Path: <linux-wireless+bounces-24647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B17AED4BB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 08:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D4518960C1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D921E32D6;
	Mon, 30 Jun 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yv9ieyEY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBE1DE2B4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265413; cv=fail; b=tmXJXe2rfr4VYawF3U5ahF/FdnwZO4prgq6i2JN0LODFo+mYf0KKlRBEpUmtO/CI918w2Ff32H8P8Oy4YEYXaFJL6/jrtQkVDu0IqMhoP/KiadzoJD/H0rJoBhqMmg+u8tBIMggzHYdHZvfmOXzVRnBBUbxMmWYFN2ezOLRUNmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265413; c=relaxed/simple;
	bh=QRIbPusxCHJxSjP7YhgCpoIAz8CGHjSrjLoKs3ircAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7AAAhNUjjetc6vc3A2IUDRvv1kUyFneZTU6rsX7Zfi1o2aC+teRIRAyzEuzDUkrXD3rRoPYtvji/QkAnkURfCcHL+Lu53ktyOCmh+bf3PQLJGH4Ck04u3P5oh/dUU44V2vDxkspKVmhY9EjTH/sMIVrX5U/zTQe20Of8PsXOSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yv9ieyEY; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPCeuAHFXHoGj17OpwtTLCFYuvaRoWj0ZOFgMXlyMcuPQp2xBsvep07uVmxe/AvkSI1iAyTQ76eSf1CtaC/xS7YO8+is+j7Yc9JxYeNexV9xslQwxFcIKxXzrvj0Eong+lgeQUn7iBhqpz1urfJ0QeYDiCtM0fgtfEA71RDx18ajWTSMZwBkbuBXmku01qsal4vexQGp+RIdqWtUT/LHeGaNvr+LeODyAJpES5fkfYBVvBCPN2lI6eIOByaSWeAaf3+4v/Z4crk+UowRtfE5ZSmhgfb1dtWyKWg7/mok1iWLCLKpX1JKmOpmgkFAgZ2CB2/w8+YXm7DBgOfU5m1goQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kKbRxttxE25p20RwnxuKdwDFRVEM9rKJ0onM7YRih4=;
 b=uJiTRElXeC7J2QYZ61LA79nh+2pFPR9V1BJE/tmorpqLWu50X7CelEZRfIB1DzYMzL6kkxkprsuEjeYo+ULdS6SIIRzoirAVtyYkJTkqJvzo+lA4Gthnh+oiwooPJa2o54+CNOJUjTP8xFg8BaAG4+kvrz4CXdnaEgoVKLhHL1lREm1bvuVTM/TMrhlMOb+CjAbS8kZKL4aPgiQS6OZWTXrvXNOB+lI54Bf1th0r0pMpPuXZiP5RF/ZSwsMW3/m+pJjhIgDE8/adSm1cIpiFJHc1O26Ogj5k+FkWwH2GAmPvSbXt9AM12Zn0sUWLldbMm/VKwsVTiGLjA7XLB/MRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kKbRxttxE25p20RwnxuKdwDFRVEM9rKJ0onM7YRih4=;
 b=yv9ieyEYrJQ2/nLDHBiT8rfDxAOerzj2aVTQem4XNJAkgXV0jFfKSUcprXAC5vDnFZPPYKgpsx13OBoTTXLL8TI63qR4rjzJ7eWaxPzwp0Ic19JWEjUWf8D6cOLXO09qczfNwOE9kDS4J+DQF0fXYF9J6n0hYx54kdPLucdfRmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 06:36:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Mon, 30 Jun 2025
 06:36:49 +0000
Message-ID: <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
Date: Mon, 30 Jun 2025 12:06:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Robin Murphy <robin.murphy@arm.com>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Matt Mower
 <mowerm@gmail.com>, Jeff Johnson <jjohnson@kernel.org>, will@kernel.org,
 joro@8bytes.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
 <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: b986e93d-1c82-49bf-cc3c-08ddb7a07db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWNwL1BhUmlnWnhEMWVWdy9IcHZ3U1BFSEp4MzFIOVlkYThpUVdjOU83cnFG?=
 =?utf-8?B?Vjc3M1V4L0VXNU1OczBHR0w0LzAraUtTeDN6dGZkNGFKcldkaU9Mc0lKYyti?=
 =?utf-8?B?N2c0d0R5UlZoZmN1WDVRcUcvQmMvZkthNitOeWpQTmpvU1E5SXRDUk02bksz?=
 =?utf-8?B?MFZFQ2hOUVNhdGVKNE5Kbk1UNjhFY0J1R1RLaE44elFZRmorWVRsRFRaUzh1?=
 =?utf-8?B?aWVybUR1ODZwN3g5elJQc01xcG85UGE2djZGSmEyaWd5ZC83MSt1VXNHUU5C?=
 =?utf-8?B?UUdyc1JaN3Y5RTJYc3ZwemVyaHBxUU04NTBudXoxa0tSZGlENnpyNXJTRFNl?=
 =?utf-8?B?SWcyS080OXFsK1FNOGRMSFNVK0o2ZmYvemFLQTZDVWdhaTVucFVZS2JQZ1J4?=
 =?utf-8?B?TC9JQy9FUlphNVpQaTlCSGd1VDhhRlRYQnYvZE1MaC9lZTVNN01IRXRrRzZO?=
 =?utf-8?B?SWtFUTVEMjd6cFRROEcxeWt4aHduSmo2T3pSc2c5Vy9XTGRIeDFxNk1EQ2li?=
 =?utf-8?B?L1czSkVjWElsZ1B6YmE1WWRBbnJEWVJHcUUrNW1qSTFBYzRCL3E0MVRFS1dL?=
 =?utf-8?B?THRkOE9EMzdja3JydDh1cUl5aU0wLzhPZUJKMWYreThBcTR0SFNrM25FM3E1?=
 =?utf-8?B?SGV1Y2o3bS83UXNSK3dHN09ZUjgvcUdOMHo5VlYra1JRR2JTWER0REJ6aGYz?=
 =?utf-8?B?Nzc0eXpKcFZ3eEFLOVFEVVR4UklJOTV4bGRzM3NBREcwTWdHL3FXRDlJbE1Z?=
 =?utf-8?B?bEhqcGluV1EyVjZDVWVNYkxkZ0w2cml2R2pwV2owR0hTN29aVHh6VGtmUnY3?=
 =?utf-8?B?M1gzd1N2UWNiTFVLZHp6dUJNTDFjYittOGt4c1h4K0VOdFExbjRlM3RYOTlE?=
 =?utf-8?B?MmNyZkRkU01KUmVYWkFCbTRyejFhSGRuQmFRcm9VTmx4YzZDRVExMFVvRm1s?=
 =?utf-8?B?RHhKc3Z0RHZJSW83K0VrZjhja09KU0cwV3RDaEJsZkxCd0ZJclgya1JkZzJx?=
 =?utf-8?B?M1JtWWhTa0s5V2NUR1RydFVFZzFoeTZ2RGNNbjJuRkFoUk1LOHJEaDFsSEZN?=
 =?utf-8?B?ZXdBcVhQaHF2VDRSTVdNeTBSb0dpQ2NjemEvdkcwU0FqWFRyVGVocUhjak02?=
 =?utf-8?B?ZzdNVWVsNUJwYWVYNUtrSy9VUDhjU29BbFp4ejRQeTZBaEtwSFdLY1FvalBx?=
 =?utf-8?B?Zm9ZT0hLL3BRRXppMWdJQnBqeUlFaHlnWmVUNFNZclBBOVdNWWtURkUzdkh5?=
 =?utf-8?B?NWdYOUd0ajJ6cDFzdC9mMzhmd3dSUmVLaDlacmh3VDJCK0dYSGxPTzNnNUdy?=
 =?utf-8?B?Y2NLOWlwbWR0UDM3Z3hPTUx4SWFyVi9IVWNDWTlBcVgrTFJBS1lITGU3dlNM?=
 =?utf-8?B?WkdpQzRRQWtKaTZZOFdDSE02bHE2V1VzcnUwa0E4WUwrSzFEaEFoOHJzR2tF?=
 =?utf-8?B?d0dZZytEb0F4b3J0Qks2aUtVVlV0bVZsN2Z3dmdVWFBoRHdxWEhCUDBDR3ZS?=
 =?utf-8?B?ZlJBNEcweE1Ob2t1cVd3dWxoVWFhUmZlSHhTVGE5MW1DLzNVMW9vMUVSY0Nz?=
 =?utf-8?B?WkhRZ1kybWI2bUNicEdpT2JXTnIyZ0s5WkUvMk1KRkdrNEh2eU9IOEdmd2VG?=
 =?utf-8?B?OXJGQlpRTjMyOTQ3OVV5MzN5eTI5eEkyMm1SMnFTNndpMkFWT0djYWVFaHVC?=
 =?utf-8?B?WHBFK1J0RkJqY1N1bjJhMWdzN1MrT3lGeEpDL3BJb1pzbkkxL25WdElhTG9R?=
 =?utf-8?B?R0lhZExQZ1BFSW96VW5HNlRuRElqQkNic2dtcUk2dVQ0L0I4OEFBazJsSmR1?=
 =?utf-8?B?T3pXd002Tmg1UFBWbVFxcnJOM05ldVpHS3VFODcva0s3Sks2ZHdkWmQyUHk1?=
 =?utf-8?B?OW9tdTJxbEV3a09mTVVJR1ZhUFpoOTVFKytxWnJjSWtvMU1BUE1zQXQvVWdE?=
 =?utf-8?Q?X56nTZWYHuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExCeGlJKzdIdmw0Nllmc3RhcnpLdFkvb1Z3WDlsSktUOElyVW1WVU9UNXJS?=
 =?utf-8?B?NmZmUkExNXJkMXpqblFPdHU1enZSaldvdWJYbHhua0hEdHBOYmJSTGVhdGtY?=
 =?utf-8?B?UGV2c0QxblBKRXpmb1NEQ2pmTEwwdzRjQ1lncjdiZVBmZjVGOCtSRkFkUlYz?=
 =?utf-8?B?dC80dWFQM1NhRDZRUHh5RjhxRTV5YlNJaHJacllINTQ3MWtwN3VXSng3dndo?=
 =?utf-8?B?MUthM3FRQU1ITWduQ2tUTG9nWXM4MVI5enV6REo3TDhrU2cxRStFWEV5aWZB?=
 =?utf-8?B?b1pKM3RtbUt4UUhPTVVLK3hiQlZDM0FBUGxEYUYwREFLaXpWNXE3Z0dSV2VD?=
 =?utf-8?B?U3NKOXM0MTM5QXZRZ29nQ003MENra3JQemZjVFFhRjdOV2EwOHA0TVFLZGU0?=
 =?utf-8?B?L2lkb1ErN29UMmF3QW9jRkdoeENwU2EvRjlrNWtWQTByUzNEZWV4aWYwaE9V?=
 =?utf-8?B?eTAvRGVvZFROT0hxSFUxMVBIOXIvc2hVVTRGdmdRdDE3L2MwenlhVURsdkhS?=
 =?utf-8?B?S3pMSGJlSFdPdUFXVnAwWVU1c0o4czhqcUVEQXdLOFVuUkZXcTdrbHpUZERG?=
 =?utf-8?B?Y0RSZHJBbEJ6Q0NMMDhiQVRzcndDdUxoM3ludHJNTU1uaVBscWVvb3lleHhJ?=
 =?utf-8?B?em1UN2pZWi9aK1F0MWJhNnJ1azU2SWhCVUtwa3QwMGp1czdpOXNhOGl4dEdv?=
 =?utf-8?B?L0tnbXpXZEVuV1l0OHN0Yjhtbzlsb3dhejVGdWM3bG1ZWldtMmJ2cm1mZVJR?=
 =?utf-8?B?WTRlTjluV0txVTVmdUVuU2R2ajhUV2dWN1p6L1JDUjVRck9YSGtjMlRXR1py?=
 =?utf-8?B?azZ1c2FPeEdkZU8vbzYwTGt5Tm5DZTZXdTZ4cnZrTDNRY2w4ZEVUODdZUDlX?=
 =?utf-8?B?MXdMU1hmYkhlOGhBTklPMHVQaHhBL1Q2aE1RandxTkJRc2pCek82MzJCZkJw?=
 =?utf-8?B?S0lPV3JEUVZhRW84T1hQVVJadFBEeEhkaS85VFUyMDFUbjlmYWU5bTg5MktJ?=
 =?utf-8?B?MFJIaFBzSjhPR0F0SzV3WjZyRzlwRkllNENlT3U3bjliTW9xNWNCRVpSVkhU?=
 =?utf-8?B?eGd0N2NpTW1pL3hQWG9McG5EbEh5bVM3aE1YcEdKdXJwM0JHRk5jM1VSOHdJ?=
 =?utf-8?B?dzdCYy9zZDBxMSs3U0w5QjgwbkwyK24yK0IzMHB2d2ZvRkZvOGRXTGdrQjZ3?=
 =?utf-8?B?ajlvVFJDeGhRYk1GcEQzcnZVR2lGY1ZzaFYxMngvWTQyRm5wWmg5SVJoTUZV?=
 =?utf-8?B?LzF2TnVGM0YwSTErWnA2Q3dpeVh0dkh5WDcyeFhrelpwVDJib1ZPTnFPVlFL?=
 =?utf-8?B?aUtBSUJBb0dIWjdmK1pvZnFBNHd4bHBKRVIxY3BzUmZ6eW5MK0FJenZYc2sz?=
 =?utf-8?B?M3VsTGVBd2pOK3RZZWFwaUkxZXJvZkkyWHdaMTVMeUtDdTh4dmlaWS9ETnBR?=
 =?utf-8?B?ZTZ6VUlLVi9KV25DcXVEdVJqNmpNMUdwaS9vcVgvM3dqdkJTZGlJamw5WnB0?=
 =?utf-8?B?Ujdmem82SnBlT2lHOEpFRnlGaUgrQ2pZYVZIM05KazVRRFBaeURPbUpEMW1H?=
 =?utf-8?B?NHIzYVhJM0dJeENXZUZSSlZ2VWQrYk9EODJGZGYySUhNZk1hV1VsM01Dd0kz?=
 =?utf-8?B?NnpvTHM0SzBwRWtvcVNkdk56aFpVcy9Cak1NVnNVUFkvTHZ0TERvYm1CS3VQ?=
 =?utf-8?B?dXJMbUxkNGgzVCtjVExrNGg5ckZMQXIwZmhObWF1MW1NZXlDQXZxdkxhWUx0?=
 =?utf-8?B?cTN2ZXVDZ0ZvYlE4dTFuc2xmMW1aZVBtN21ZbFNjNjF3QmJOYm9mL281TGJZ?=
 =?utf-8?B?d0Fwcmx5eW5KbnV1VXd0MGlNSnY3SGNaVWgyM09QeU1OanMzZVYzb3p0QzFK?=
 =?utf-8?B?bkI2eGJpN1k2U2JGUGZjdXNHdDhVRzNLWit2TWYvVGdqOS83bUVZT2xLTDRw?=
 =?utf-8?B?d05BVWc0VUNBc3FIZ2l1Zy9pVXgwN3A4bFdmNFd6Sit6aGVBR2FqRTNIeFdx?=
 =?utf-8?B?WG81WEVhYmR1NXFuV0dhSlN3QUFCclN5VTdIMDduTnNGTU93T0xWalUvb3Fl?=
 =?utf-8?B?c1hlOW1VWmFiMEIvdVNQVmxEVlpKVEs2T045YUgrSXBMa0g4NS9VejVydk5Y?=
 =?utf-8?Q?aO3Fmrc4etzeSxJNW0K5gulvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b986e93d-1c82-49bf-cc3c-08ddb7a07db3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:36:49.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fonJhe3NBVl65WV7SMfh5ETawIBeD0A3DO8pVSKifLivcKfol8LdOs43sTcf2MTAcI48MnFhrtxEgeQHQZgD2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

Hi,



On 6/27/2025 3:54 PM, Robin Murphy wrote:
> +Vasant
> 
> On 2025-06-27 6:39 am, Baochen Qiang wrote:
>> [+ IOMMU list]
>>
>> On 6/27/2025 12:21 AM, Matt Mower wrote:
>>> Dear maintainer,
>>>
>>> I have been experiencing lost network connection with the ath12k_pci driver
>>> in the linux-6.12.y kernel branch. Often, when the issue occurs, the
>>> network does not recover until I reboot the computer. A full report of the
>>> errors I encounter, the symptoms that arise, and several dmesg attachments
>>> are in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1107521 . I have
>>> attached a dmesg from 6.12.34 for convenience. The short summary is:
>>>
>>> 1. I started noticing log lines like the following soon after boot when I
>>> updated from 6.12.22 to 6.12.27. After these events occur, the network goes
>>> down and often does not come back up.
>>>     ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>>> domain=0x0010 address=0xfea00000 flags=0x0020]
>>> 2. I was able to reproduce this issue very rarely in 6.12.12 and 6.12.22.
>>> The issue always occurs soon after boot in 6.12.27, 6.12.30, 6.12.33, and
>>> 6.12.34.
>>> 3. I have not reproduced the issue in 6.15.2 or 6.15.3.
>>> 4. In some cases, when shutting down the computer, a kernel bug caused my
>>> computer to hang. I haven't determined whether this is related to the issue
>>> above or an independent issue. Search the bug report
>>> for PXL_20250611_140820085.jpg to see a picture of the kernel bug on my
>>> laptop screen.
>>> 5. I have tested two firmware versions:
>>>     a. fw_version 0x1108811c fw_build_timestamp 2025-05-17 00:21 fw_build_id
>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>     b. fw_version 0x100301e1 fw_build_timestamp 2023-12-06 04:05 fw_build_id
>>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Thanks,
>>> Matt
>>>
>>
>> I had a quick test with 6.12.27 kernel on both my Intel desktop and AMD RD but
>> didn't hit
>> the issue. And I am using WLAN.HMT.1.1.c5-00284.1-
>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3.
>>
>> As mentioned in the Debian bug report, since reverting ath12k patches does not
>> fix this
>> issue, maybe it comes from the IOMMU subsystem?
> 
> Faults are usually still indicative of the client driver/subsystem doing
> something not quite right - racily performing dma_unmap before the device has
> actually finished making accesses; mapping the wrong size such that the device
> accesses off the end of the mapping (this can often run into another valid
> mapping so not necessarily fault); mapping the wrong DMA direction such that the
> device then tries to write to a read-only page. However I suppose it's not
> impossible that some fix to amd-iommu in that period might have changed its
> behaviour in a way that exacerbates things - Vasant, does this strike a chord
> with anything you're aware of?


I did look into kernel code and changes between v6.12.9..v6.12.22.. There are
only two changes in AMD iommu driver.

40c731472f41 iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path
   -> This one was needed to fix the suspend/resume issue. This just adjusts
control bit after suspend. Its not touching page table.
6e1e451456e1 iommu/amd: Remove unused amd_iommu_domain_update()
   - Code cleanup patch.


Looking into lspci output only `c2:00.0` is placed in group 15 and domain ID
0x10. I believe there is only one device in this domain.

Interpreting IO_PAGE_FAULT flags = 0x20 means It was a write request for the
page that was not present. So at this point I would still suspect on device
driver side than IOMMU side.



> 
> A couple more things I'd try on the ath12k side: firstly, boot with
> "iommu.strict=1" and see if that makes the faults any more frequent/
> reproducible; if a fault is fairly easily reproducible, then use the DMA API
> and/or IOMMU API tracepoints to compare the fault address to prior DMA mapping
> activity - that can usually reveal the nature of the bug enough to then know
> what to go looking for.
> 
> I wouldn't put much significance in whatever happens *after* the fault -
> presumably the driver is assuming the blocked DMA write has completed, so then
> goes on to read some incomplete descriptor as if it were valid, and thus may
> fall over in all manner of entertaining ways on bogus data.

Thanks Robin. I'd suggest to follow these suggestions.

-Vasant


