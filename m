Return-Path: <linux-wireless+bounces-19764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6AA4E475
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C663F19C52F5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF22505CE;
	Tue,  4 Mar 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="o3jRqqCb";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="SiI2JcAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0920A5EA;
	Tue,  4 Mar 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102365; cv=fail; b=mpthu4BcYJT/zJPVubTwe0nowq1Usypjnh+F0HyJXG0U9DE18Tj1GKhXyDmui5skFW2HizCsc/+daBm/irRV6+A/y6TyVLT5MzABgo8se7axDXDF93zk9hZtZsjTgMD32Yj885Zu6wYSVb8LjRnEIlyp26dridA4ePJhVxVVRQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102365; c=relaxed/simple;
	bh=jXTMqQayNWK+OVT8qiUBwW+haAwrrcI8uj0NoGtLn0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWLbHfEi+JAqTBEvaShpjodoZnFEoxFA20Ycchrzrrl4bk4zBuOsJ9LzWjS0bjGf0/2atpGX8Lkzxgqod/LtTX6d0LYIVhreORqQbFrBedaahvsFLCZidPCWq/Rh97jq8r2LOCgTEuKfzJ+SRqe86gZN41l/8Cj4jqfS/GpzMU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=o3jRqqCb; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=SiI2JcAd; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524BF7h9031961;
	Tue, 4 Mar 2025 09:32:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=jXTMqQayNWK+OVT8qiUBwW+haAwrrcI8uj0NoGtLn0o=; b=o3jRqqCbKzR9
	ZOc3dZ7JZaUTICrRoLXP8v8wbDjIZIfFclUbxnZkvRp8TN0aeCiX/fL4By8eLlBh
	+uQHnvwl6xyib0ExOsmhu3/XcX/PHwCLYqiUWVt9GtQGvRbtqJ0rsS50xQYMHbBK
	Oymm/ahbsss02hhoVjBHwnoJHTlWUA7CEZ0TTnYzsW+7Lr9/UFZD/kzYovc0xAZ8
	k96kO4rml5XSsdrP6fbzMrFDB+2GyKoefbt6NLyc62JgZyPj+9BFjqf7HqnE8Kae
	dCuk6iFF+TWvbEr1asuZgGeGv/QK94ji7GhseYHtAZr6wNac5gee7LnBICX5M8xG
	NtTztg6xvQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchhcus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:39 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haYMwz5JfYqnkDddV4bKac2GZmnTzR7DrMRc3xY4L+3hoFoVyX9XZOKt2JksScqu3C6Y/P5wtuPzhd4OK/d14drxCmGa27Oz0cqB7dS2tTn73WXh7LzgJPdW+KA+4YNur/goppNlyxJ9amPtnHnVtEIbr2x3QkXkxcLpEt7fNK8L3KhsWCw6CADTJpYWahpAhORdYDx/dYnzclWC5rIBg8BHEdLrZwXGz35XEFHQ6Rh0Ac83swjRp/eTyVQbqsRADcaOXvmQr/nokJ/sLh8vvqKlFjA8c5qC2MRWtl7AKNqUaa5Vzwn/6AL7E0yacN1DLrK75pqBXOhj+wjN5ArKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXTMqQayNWK+OVT8qiUBwW+haAwrrcI8uj0NoGtLn0o=;
 b=eMtF4aB2AHzfdalvXRyQ4B4+N2XRTtC/MebiBqo5wD6LNnO0c/7a7f2TScArQarQoxHvMBiuMGpOgcSC46RVFzjp9YRSOhteMSYGsRKQ1KJ4jn9hbAW/GEOhyl88N335j/5qtB8u8lWWZTVkbdAqHztPXfh3+uqyzjXul7eXxfqaUoIp7svhy5Fd+TGCT4pFgYGkCW4VEAfuhnaGW6zN4KZ2ekxr9cGlfx+Sp98bVuPHVa16qg1rPlnpckFL2vcxYqaJ0Sv7PO/6G/hkrSu81+BYohT49ZofPsaHKL43zllsOBSYuQkC+TLhAFk1UD9r9bSsik92qfXyUqc3Lm6eZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXTMqQayNWK+OVT8qiUBwW+haAwrrcI8uj0NoGtLn0o=;
 b=SiI2JcAdGeH4AtukaVNYO/cpeLm848k1/P31JYx3O9fHLD4anRIydDeKdKFXcnhjQIMZlA3J9yLnDIHGQpnSBr+ruxSjP/SagF3Xeu6/IUqi9QHYt34sw3ZpSOfyWrRcXa2BX4i/0KdM94KPMb/D2DzQ5NwRWge3wJF0PfYI4pQ=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:32:38 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:38 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 4/5] wifi: wfx: allow SDIO device to wake up the host
Date: Tue,  4 Mar 2025 16:32:23 +0100
Message-Id: <20250304153224.39083-5-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304153224.39083-1-jerome.pouiller@silabs.com>
References: <20250304153224.39083-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::11) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4652ac87-b24d-462b-8cd3-08dd5b31cb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmVuZExOVGV6VHRIbnFwQnFYTUZ5Y1BwVGo2ajdpOCt2QUxSVGVHM2cvc3dI?=
 =?utf-8?B?aW5VUE13blpxZGwvWlA2MGJ0Rk1mdXV5Vmgyc1g0QWRsdG8wQVY2cDZxdzdp?=
 =?utf-8?B?aGZ5QWdud01HeHRKR0NadmVpalhoWU02VTB2OXpzODhXMG9pVzRYcTRqUk5T?=
 =?utf-8?B?OFAzNTVJalhXQXNIRlVnZ3NkS0tvSkIzeFd4Szg1eGt1cXRIdTVoc3EreGpm?=
 =?utf-8?B?QkxIZnNxMDBZZTBsbHdMblROMGV0bU5WQ2I0Z1JJMndOeDRpSVFVNEhzUmFE?=
 =?utf-8?B?VWhFeW03SmgzUTZnaHF4ZjBEdHpsRnBkNm45SStaVTdyZEVoTThqV0xuTFNk?=
 =?utf-8?B?ZlVtMTRnbE15T0FnUnVQNDlFVTBjSXlpeXZnakFpdFN3RWs4QzFPVEloemR6?=
 =?utf-8?B?WEgwY0JyMXVvV1ZxWW8zMVU1ZzdpWTBDOVR0eXM0bXVxZS8wT1pvUVVIY3Jz?=
 =?utf-8?B?VUpzYUd4Qm9RZW1MSXhKVmU2ZXRaSGM0UEdmbWs4dGdnVWVBV2tBeExHakE0?=
 =?utf-8?B?RlBESnZmK1g0RFhIamdFTTA5bE5xbUtheStVZlQwU0R0ajVTOWxGbVg5TjU1?=
 =?utf-8?B?bUd5dkJERE84V3dwSjRObmdxYjlBdGRiYWJHeDBrZTVUdTMzUU9teTVPN0Ey?=
 =?utf-8?B?V0c5L1lKUkswVXZXcXN6dXFmR2NUdjd5YzM1NWY5THVGZ3JQd2NTZzRZN29n?=
 =?utf-8?B?SStWazlrY1JoUVB1N1VyZEZwWVMzN0QyL3pJb0crVDZsbE5xSHpOejF3enFZ?=
 =?utf-8?B?QUY3aXM1Q3NkMmZhMVBUTU5ob1BML2tmTTZJa0czMmEvRTUrNjU3bGlReEpx?=
 =?utf-8?B?bXBLRGtHNzJqSExsVEc0cVNoL09qWWJRS3d1V1piSVhHdm15cUtuaWI1bFUr?=
 =?utf-8?B?VENBWjJmc2xOWG5HREI3dS9heFltQ3BoaVFFdDRoYWtKMU90QytrMk9HNWtI?=
 =?utf-8?B?MVM5Z2RyR09Xa3ZJdEl5T0RaUTJIdjEwSk4vVTh5Y2xDR2Z4TEZSbVk5em9W?=
 =?utf-8?B?dHMyc0VDK0toNkQ4anZzUFdxM1dhZTdEa1dlczRvbDd3U29rN0pyK3FHOVRh?=
 =?utf-8?B?OFgyMjBTODJodk5va2E2Nnp3MTY1dEVEc3dPSDBNUDNlRHRWL0EwN1FHT1pz?=
 =?utf-8?B?TDNOSHJNaSs2QWxuWEJtbXpHSklnR1RicmxDaXg3TS9PSkJjengydVlBSnhT?=
 =?utf-8?B?UFl1SU9DUEUwTVNxWHpQNFFtdmZpd0hLdTFLTHVFN2hMTkNvaGJ4MFB3bCt0?=
 =?utf-8?B?MHgwcmVMV2cxdXhjTlZSbHluckVmdHhJN2QzT3NzZzF0N3hxZVZ1d0R5Tjdh?=
 =?utf-8?B?QSs0d3EzbG1DQUxpR3FXYnZVZWxMcS9ncEluY211bHF5NEg0ODlVMTJmODVR?=
 =?utf-8?B?dDI1T25JVVcxTlhqN2JFRFYzUFVKbEozUTZadWJRenNJeWNVS1pBdkJUVjV2?=
 =?utf-8?B?eTlnUEVKdEsrU1YyR3NXeUo0MlpBdEpyck1lWXQ3S2dYMzNZVUxtUlNiOVpE?=
 =?utf-8?B?Vmt5clh2emJ3c0ZwRHdBRFFWSjJDWEkwaWVBWGkvMWQyN1FHT3JJdUZ1aDVZ?=
 =?utf-8?B?dS9aMTJqZXRmdzhnNWlsNTdRcHpEcVM1R1dTYXRwcytSU1ZsckliSzJkWFlB?=
 =?utf-8?B?VG5McWxKR2RxQ3BIdFN0d0RUeXZwMEhidWIzc0lUREZucnJteVhyV1lDWnp4?=
 =?utf-8?B?bGZHMlpOZGVmNE1CM3BzQ3BVelQxYnhualp2SFYwU3JlT3dVd3p3U1BMMENw?=
 =?utf-8?B?MUlwUEhjMlhrOURlK0hDa1owWlpPZmhhKy9CMFFUUTFTZFdtVXpFWUtlU1RD?=
 =?utf-8?B?ZmwzMGJoWXF5ZUkxOXEzeHMydGU1OFJYNEZwTlErVFQySGRkbkJrK3Y2cmZk?=
 =?utf-8?B?NGV6bEg1Q1dxSksycHJ2TUVLWE5vajlrY2pWRFdyRURwaHA0U2lwWm9uQ2JD?=
 =?utf-8?Q?3yNbDGnOGzaAYKZEZvat1UQs7Lq5eA0i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXVyZVk4aTRFUGxpOTM2YlhxYnBqMTVFc3ovcUZ6WEh0TGVNd1VPZGc2UFM1?=
 =?utf-8?B?V01pNGlicXdnVkhtYzFIVlR5NHA1QmhvRWlZblRkUHpLSlVDNWZSOTRmc1pT?=
 =?utf-8?B?UDc4WDJLT0laQW9MeFpmdWljL2d4VVd5SHoyalY3d3ZjQjhtUDcyT1pGbDdN?=
 =?utf-8?B?Y3ZJM0FpejJHbU1XVEpFbi9PSE1laEtlZVdKOFFOREswMGZFelBpNThWUFlq?=
 =?utf-8?B?aHpzSnoybktHYUpVOFNVUGlXNi9uYWxhTDdXbXVMWlYxMTcrcUF6RGxKQ0g5?=
 =?utf-8?B?WlRwbHBZVUhRR3JJdjFPR29iSGlIcFFaVVBjcmg4bVF5aWxZNDJYd2o0Z0xm?=
 =?utf-8?B?SG5QdE4wU003Vnc1YWVNYXpxNkV2V2x3QnZ6NUkrVUlTdDRSUk5ub1Q4V1VZ?=
 =?utf-8?B?b09kK1ZnSzVRVExaTGRRRHdSVUhUZi9adHd5UnZsc05FbnhwNHJsWGZkRjhI?=
 =?utf-8?B?NGIyY2kwV1hocjludmxVQ3dPVnBla1BkSXFWNkFkMGEyN2I5R3RGaWphMEp3?=
 =?utf-8?B?cVI4TEFDWG9IeUo3VlNNMVlMZU5WNDVlVHBmRlB0T29oTnpXZXl4K2FtRDR1?=
 =?utf-8?B?enJ0T01GTGhVZE5Pc2lETEtsZGhvaGs4c015N1p0Z2s5bGZjZ3l4Vi9VamhH?=
 =?utf-8?B?YU9aQlRNNlNPR1pFK2ZybHdzVnZrbzAxa0kvdlFFUVFwdlArb1JsZ2VQQkJ1?=
 =?utf-8?B?SWU1ZktnRDRwc3JrdE9qVXNWNDY3Y0FzWDJnY1RWbTV5NXF2UnhuZ2V3a096?=
 =?utf-8?B?MVVjc3V3ckY4R3lyczI0NEY3VWovSU8yMWZLcnEyNGV1V2hNUXZHU2NpTlY1?=
 =?utf-8?B?VEtkRjhhMkl1QUdmN09GS3NPZDdvVDBuRlpEaWlVcXhjcUNRUWhyZTFNUkdh?=
 =?utf-8?B?NjVBUXV5ZWZEalZXaVdPTGVsZ3ZMUUJPVms3T1FkV0lzTHlhVmNnMTZnMy93?=
 =?utf-8?B?OXduTStTWkFnbnhwN0ZYa1dId0JmNmlHUnRsSks2SWo5M051QXVsS2l1a2ll?=
 =?utf-8?B?ZGdxRVVFc2orN2UyNlpUeFpoRDg0emJlRFN3dDV3U0RxT24zRkZtcHZaUVJG?=
 =?utf-8?B?bG9IRFZ3N1dPbEJIR1FJcHBQN2Vuc1VHcGg3K2E3TU53UnRpUFJucVRyRVgr?=
 =?utf-8?B?OHdPUVRBUGUxamQwYjBlcG9tWDVkUTN6QUNSb015N2g1MFFiNVNabVd5TXNT?=
 =?utf-8?B?alJmRVNGTU9BQmNkeGUwU2RIWUhHMTV4SXU1TDRyTzZwa2RGK2FzUVZXOWYz?=
 =?utf-8?B?bWdFQzR0d1QwQkVVM3FsYjgyNWo4dTdQamN5dGkydVE2SUdLY0RvUUtpWmxp?=
 =?utf-8?B?aC9LUU5LM0F2STM2U00rRWFPQytrU1JvVDVBaWszanEzR1JxKzRseENNZEw1?=
 =?utf-8?B?c3gxYkRIZTMyVFVrWGZhT2tzbkx6ZE4rM0tVa1RkM0YvQU5LS2ZhQmJJTGFs?=
 =?utf-8?B?cS8vVHJDSGJNRnFyMlI5VEY4UGYwOVFEYjh5QW1HbXJhY0UvcjVXay9UaE9T?=
 =?utf-8?B?NFZ2MFd5S0JaaXhMdVlNcmt4aVV4bFk2Yk5RRXFTUE5VWWRDQnFIYlJRSWhL?=
 =?utf-8?B?d2dzVi9YTUxrTmFlSjBsV1QxQXd1enhKRGdBRmorcVNsRkNtMDNJMTJBeW5a?=
 =?utf-8?B?dHI1VEdwak9KWStNdmJ2U0lWek93THd2eWdlZzliaFVwWXZGUHVTUDFoVkF5?=
 =?utf-8?B?RHhmZlBqZkZ4QVdGYUlPKytCTUs0Y21XWStvY2RPQkpsWGpCLzJRcm1LTWda?=
 =?utf-8?B?amxRYm1sRjhneDFZc1JzTUNQQ0JROFAvVXFPQS96VTB3NGF4K0oxUmdBc0JD?=
 =?utf-8?B?OXJNbmdzYW9PNysrYWJKY3ZzNEpuc0ZXMWVKM1lnQkpYcFVBcjBOaEpaVEpl?=
 =?utf-8?B?REhQWlJQMWVKamJrMmRLb1VRenJ1L2duNEZJRUxaZHVvYjlxRFQ5bWlPdDAv?=
 =?utf-8?B?YzFsU2lEYk9vOUE1L0NKL2hlSUVBSUdZY3h1R0doMnVYdkp0dUVGMVFUbDJU?=
 =?utf-8?B?cGluMHFhbzNqOFRXVDY1UTFZaVdZdnplak5xV2dlV1RSbnlIOFBSTVlhT3pa?=
 =?utf-8?B?eFZkcmxEWnlyN2VxN1BYWlJCWkVwcUhqZWFvdlZqTkYwQ1FybkF2enUyWkVj?=
 =?utf-8?Q?wsqYkX+MIv387trjtwN3WWuCD?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4652ac87-b24d-462b-8cd3-08dd5b31cb5f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:38.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOnZNeNlkkfW86bjY1blahLVnmAr5St0ElFQ0vLp06s9ssLNPGORkzOoISdVH5XjIQmRDPzDyxjvqwul3Lpvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c71d17 cx=c_pps a=Syk5hotmcjzKYaivvMT4gg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=_bZ_Ugej2YiJM_EvIRMA:9 a=QEXdDO2ut3YA:10 a=CJgG61vzA6yyTBTLYZUp:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-GUID: bkINjzr3vwkjoCMCgPK-fTzNjrKbpR9M
X-Proofpoint-ORIG-GUID: bkINjzr3vwkjoCMCgPK-fTzNjrKbpR9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=830 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

SWYgdGhlIGRldmljZSBpcyBjb25uZWN0ZWQgd2l0aCBTRElPIGJ1cywgaXQgY2FuIHdha2UgdXAg
dGhlIGhvc3QgdXNpbmcKZWl0aGVyIHRoZSBTRElPIGNvbnRyb2xsZXIgKHRoYXQgcmVxdWlyZXMg
TU1DX1BNX1dBS0VfU0RJT19JUlEKY2FwYWJpbGl0eSkgb3IgdGhlIG91dC1vZi1ib3VuZCBJUlEu
IFRoaXMgcGF0Y2ggYWxsb3dzIGJvdGguCgpPYnZpb3VzbHksIHRoZSBTRElPIGNvbnRyb2xsZXIg
bXVzdCBiZSBhYmxlIHRvIGtlZXAgdGhlIFNESU8gZGV2aWNlCnBvd2VyZWQgb24uCgpTaWduZWQt
b2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0t
LQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgNDYgKysrKysr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggZjI5MGVlY2RlNzcz
Li4yN2M1ZDdmNTM0YTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
ZGlvLmMKQEAgLTE0LDYgKzE0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4KICNpbmNs
dWRlIDxsaW51eC9pcnEuaD4KICNpbmNsdWRlIDxsaW51eC9hbGlnbi5oPgorI2luY2x1ZGUgPGxp
bnV4L3BtLmg+CiAKICNpbmNsdWRlICJidXMuaCIKICNpbmNsdWRlICJ3ZnguaCIKQEAgLTE5MSw5
ICsxOTIsNDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NkaW9fb2Zf
bWF0Y2hbXSA9IHsKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCB3Znhfc2Rpb19vZl9tYXRj
aCk7CiAKK3N0YXRpYyBpbnQgd2Z4X3NkaW9fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCit7
CisJc3RydWN0IHNkaW9fZnVuYyAqZnVuYyA9IGRldl90b19zZGlvX2Z1bmMoZGV2KTsKKwlzdHJ1
Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gc2Rpb19nZXRfZHJ2ZGF0YShmdW5jKTsKKwlpbnQgcmV0
OworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1cm4gMDsKKworCWZsdXNo
X3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwkvKiBFaXRoZXIgIndha2V1cC1zb3VyY2UiIGF0
dHJpYnV0ZSBvciBvdXQtb2YtYmFuZCBJUlEgaXMgcmVxdWlyZWQgZm9yCisJICogV29XTEFOCisJ
ICovCisJaWYgKGJ1cy0+b2ZfaXJxKSB7CisJCXJldCA9IGVuYWJsZV9pcnFfd2FrZShidXMtPm9m
X2lycSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCX0gZWxzZSB7CisJCXJldCA9IHNk
aW9fc2V0X2hvc3RfcG1fZmxhZ3MoZnVuYywgTU1DX1BNX1dBS0VfU0RJT19JUlEpOworCQlpZiAo
cmV0KQorCQkJcmV0dXJuIHJldDsKKwl9CisJcmV0dXJuIHNkaW9fc2V0X2hvc3RfcG1fZmxhZ3Mo
ZnVuYywgTU1DX1BNX0tFRVBfUE9XRVIpOworfQorCitzdGF0aWMgaW50IHdmeF9zZGlvX3Jlc3Vt
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJc3RydWN0IHNkaW9fZnVuYyAqZnVuYyA9IGRldl90
b19zZGlvX2Z1bmMoZGV2KTsKKwlzdHJ1Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gc2Rpb19nZXRf
ZHJ2ZGF0YShmdW5jKTsKKworCWlmICghZGV2aWNlX21heV93YWtldXAoZGV2KSkKKwkJcmV0dXJu
IDA7CisJaWYgKGJ1cy0+b2ZfaXJxKQorCQlyZXR1cm4gZGlzYWJsZV9pcnFfd2FrZShidXMtPm9m
X2lycSk7CisJZWxzZQorCQlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCB3Znhfc2Rpb19wcm9i
ZShzdHJ1Y3Qgc2Rpb19mdW5jICpmdW5jLCBjb25zdCBzdHJ1Y3Qgc2Rpb19kZXZpY2VfaWQgKmlk
KQogewogCWNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoJmZ1bmMtPmRldik7CisJbW1jX3BtX2ZsYWdfdCBwbV9mbGFnID0gc2Rp
b19nZXRfaG9zdF9wbV9jYXBzKGZ1bmMpOwogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBmdW5j
LT5kZXYub2Zfbm9kZTsKIAlzdHJ1Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzOwogCWludCByZXQ7CkBA
IC0yMzUsNiArMjc1LDkgQEAgc3RhdGljIGludCB3Znhfc2Rpb19wcm9iZShzdHJ1Y3Qgc2Rpb19m
dW5jICpmdW5jLCBjb25zdCBzdHJ1Y3Qgc2Rpb19kZXZpY2VfaWQgKmkKIAlpZiAocmV0KQogCQln
b3RvIHNkaW9fcmVsZWFzZTsKIAorCWlmIChwbV9mbGFnICYgTU1DX1BNX0tFRVBfUE9XRVIpCisJ
CWRldmljZV9zZXRfd2FrZXVwX2NhcGFibGUoJmZ1bmMtPmRldiwgdHJ1ZSk7CisKIAlyZXR1cm4g
MDsKIAogc2Rpb19yZWxlYXNlOgpAQCAtMjYxLDYgKzMwNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc2Rpb19kZXZpY2VfaWQgd2Z4X3NkaW9faWRzW10gPSB7CiB9OwogTU9EVUxFX0RFVklDRV9U
QUJMRShzZGlvLCB3Znhfc2Rpb19pZHMpOwogCitzdGF0aWMgREVGSU5FX1NJTVBMRV9ERVZfUE1f
T1BTKHdmeF9zZGlvX3BtX29wcywgd2Z4X3NkaW9fc3VzcGVuZCwgd2Z4X3NkaW9fcmVzdW1lKTsK
Kwogc3RydWN0IHNkaW9fZHJpdmVyIHdmeF9zZGlvX2RyaXZlciA9IHsKIAkubmFtZSA9ICJ3Zngt
c2RpbyIsCiAJLmlkX3RhYmxlID0gd2Z4X3NkaW9faWRzLApAQCAtMjY4LDUgKzMxMyw2IEBAIHN0
cnVjdCBzZGlvX2RyaXZlciB3Znhfc2Rpb19kcml2ZXIgPSB7CiAJLnJlbW92ZSA9IHdmeF9zZGlv
X3JlbW92ZSwKIAkuZHJ2ID0gewogCQkub2ZfbWF0Y2hfdGFibGUgPSB3Znhfc2Rpb19vZl9tYXRj
aCwKKwkJLnBtID0gJndmeF9zZGlvX3BtX29wcywKIAl9CiB9OwotLSAKMi4zOS41Cgo=

