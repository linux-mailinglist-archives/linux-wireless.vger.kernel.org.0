Return-Path: <linux-wireless+bounces-19604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61CA4A0DF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AB91899FEF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546BC1925BF;
	Fri, 28 Feb 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="U+y4qsI3";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="X6gL3Sab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F81F4CB1;
	Fri, 28 Feb 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765152; cv=fail; b=ipS4fDizHaoKRSjMFsx+TlkCB37MKVyQNMHYeRkXZ1fyv1ylFWQT2KOAhB8ecHW0g6QsvS/Tvm5M+20bP2ZRZ9qWgbDjo9gLyqVZtDLxBp8yxLL7yc6y4EIWvTUJAx8EjJ2/1nDCl4zOL5qIptWHSJuiAKOkmUP8JC9umWSGbwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765152; c=relaxed/simple;
	bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rxu+XF8WThfv8JzdiVLnzd6rqW6jyidfzu42CggSkpjBahAzdwCtgh0zV5CAGYEyqWsQf1aamayc6PQgUNOOggiqePxkfKl1uUoR1Wv4Y6+uir923Z0VTQG9nPT+fFwtQCq9i6DkaiqIAE9W2lqPY3ZfjsDTC3zLaMeVWJ68/6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=U+y4qsI3; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=X6gL3Sab; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8EhYH012718;
	Fri, 28 Feb 2025 11:14:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=; b=U+y4qsI3a8t7
	VuY4GNAbYAIHKIK3Gtw0GDVpVD1I/efFxslUPoyWd//0cePfvS9w4PuRghLVPBjU
	rYkeYbTUQP9Su39JFPfZTz2VdALk3fRbW87afHYldkyfjCN/UoDPsRgQcRdlUVi9
	iRU4o90dN/tp4EkZABH7zFezENLAiU47PZ6+7XbUc+lcafl9CbYMq5ofLLzivQVs
	YNchZsne/KPmgE05wt7sscCpykuuxqyuvJ9pHFHg63gcxDknTxUA65BuCo9thj+d
	tlE5Gyj+ovY/2SnoBa4DPjHqCvoIoWv0395UqgAKDSQf+jR7wM+/hJfGosrseRcT
	MCw9vJltZA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbrujd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:14:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrUpDeb0w3+Lh9AQ6vhpmyBAza/T6C69ou9n/FDMq78zKuyLEOy61KbmFV8Z0eg75Ya+6+SMsUK1UeMIpPlyEtwG5q46YPqkrcEhLgogHXD6AufMqBOodsSEa+hQlWxugSnZlapDpGmneMIP4dh/2AAciuYEzUHb9IhLkLazF/LUlZALwL4/qs9aA1dDmp9y8F2N3V/LY5m0N+krCrz4E/mO7TDEOji9PSWFpbWrlCH1gUCvZx+A4aTPEpF5BbO/xbAUcPgyY4lbWqhZ9DCAGpWzEFRHRV2JwT+nx2nxsRgTWWpP6UXoxpS4taOJMGnKoc9gz1WMGq6YB8MyAOI9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=Bs89Sy/wUdHwn/oAXU/UVIzsjw0YwsL6p22sAKws6wa9B0w1DbCko1fvYHr8N1h9mgDNPmlOIVBuLKQvlDvLzaHXMGXkGSIfM1EUBpK3CIj6IOLjeDlz9LVtQEMXNAeEArBd/mGFd6LDeR1u5u2FcJ9p4Acb38ErJuTkLAXSxrE/7Hi2tIgG9XNZ0rElcdczsxy+CNy4wWHh+VkcaPzj7eE1UbCTT4uwQXUUigPcZLkTyjz//7xNk/cEZ+jJCKYOyaNGpG9TV5YpPPe8DI+mHY6mYkeQGOJu192biw+OIChQ/bo91xHBtPRPQTl8AJ4DTn5cyjyEy6jAt+gbnysuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=X6gL3SabWYX65YQPK5FqNhhNFvQMe7WTbE0rAidR9Cb6SksLgPL5Q6RCyVWMsH/t7XyFNFr5k/GXLAvsN0UePWIiEBk0dqXaH0cq0PoVDjMRIJk6PdWgB4Hco5uaFbHsOeDHSxcCcwjmDpq+lVpZeGrerXu7ZAY5cgb9NlWSt6g=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:54 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:54 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 1/5] wifi: wfx: align declarations between bus_spi.c and bus_sdio.c
Date: Fri, 28 Feb 2025 18:14:37 +0100
Message-Id: <20250228171441.109321-2-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 561b724c-33ca-46d2-154c-08dd581b6b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnRkMCtIQ1pCaGwyTkhQb0lNRFFic0g2VWhPVUgyUjl5UjZSQStoWnRBUFlP?=
 =?utf-8?B?V3l6NjJDWGVHVEpDK3BYb01wOTYvTUp4cUFZTm9HdXp5R0xSSU5sajVta1E0?=
 =?utf-8?B?Zk80SllYMWxWRDY1ODRSM3ZhRmx6Z2dhT0huOHlLenAzZGdzVWtwbWtvSWQr?=
 =?utf-8?B?Vk9oSmpieFlzMEwrRnVMdHhxOVVSdEJmZkZQWXVodS9EdGZSWlh3Z25sN05X?=
 =?utf-8?B?TEtac0o2Sko3eVBteDNvcWN1MWpyOW9rdlpra3I1TlU0TWt5THhPTTdNaGFO?=
 =?utf-8?B?L1RyZDJKMDR5cWRpYWF2aHRzVGkzeUJCdmdXSGR0Vy9PTURpRWZUQUpOVFh2?=
 =?utf-8?B?c2l0blhSMXdlTTE2RHp6aHNCVnRDT2lNSk5OUU0rLzJCVWIvTkJNVGdmR3JG?=
 =?utf-8?B?TkRYaE5wTDZuVHlGdlljeWJnOU9sZlpJaUZ6T0ozYTNzc1NIaHROYmRZU2Fm?=
 =?utf-8?B?NU1YY0Njd2ZNd3lWN1BrT0RpUlFsTVlqWFZmNWNKbmVBV2tBSHNiTitsS2N5?=
 =?utf-8?B?VnBhNGZtRzc1d21aZTBkM0kzd3M3elpIZmhwdklha3RPdmttRmUvNWJRZnZl?=
 =?utf-8?B?VzFKLzBaUG8xUGxncDRyZTNmWUVOdy9uUFRXTGV0aTFuM3JxbHJqOFBQZkEx?=
 =?utf-8?B?RmNFNFNUamNORlE4NUpZN29GRHh4NzgzQnlXaHpkaXE3ZzRpd2VkWHpVcGM4?=
 =?utf-8?B?d1llMGY5Zk1reWlCVHUrYWU1RDRmTVl6TWpFdFNBSVJtajI3eVdqL3U4UlVH?=
 =?utf-8?B?djF1bUlzTDBiTmdwaEpWWFNSMm1aMm5ZUXQ3K3BXZktqZW5VRE1TWWNRSEE3?=
 =?utf-8?B?STUvbkJQVnRQS2JmZVB4QThaam80Rk1hVjFGZ1J6RWQzSmtsQ2xtQmdvTWxP?=
 =?utf-8?B?eGYrY2g2UVFxd1RIT3BBUTd0SzQ2UGJuZ1BCT09HZW9rSnNLdERvczZkR21W?=
 =?utf-8?B?SEhwd2NkeXFFeStHU0FFWWhydS9EeUo5YlFubnVyT0RSNmszQmZjUEhDM1Nl?=
 =?utf-8?B?b2tUYy9TQm5qNlVoV1RVMFo1RFR4WTNYZjA3NHUvQ01HOG9TN3pLRDQ5QVRZ?=
 =?utf-8?B?am9BeUVwQUlBRGQyZGsxM09oZDYrNElGNEM5NW5KcWhtUFVmenE2dUx0VGQy?=
 =?utf-8?B?SkptU3J6MnFmY2g4U1B0dnQ5ZVdpQkJsNVlNc3VLajYrWWpaUXBnZnBrMzh6?=
 =?utf-8?B?NGJVMHRnck1HVkYrSUFBRUJMNTFWMjVPVzBLT0w3d2lNaGNUczBNd2wzTGlj?=
 =?utf-8?B?cG1HUXR1aXRsYWtNSFEyakVsMzZOazV6RVhJQ1hqR2xvU1VLVkVIenJqbHBj?=
 =?utf-8?B?TG0wcFZ1UDQzaHZmUDR3R0gvNmdWSUltQmlzRDJXb2g3SWdTQWdnbDdCQmdH?=
 =?utf-8?B?NlBxMWxTZG10NlJwc3RlYWI2TU5IVWJncUtOa2hieXZDSGZlWEVvSVRIeEVH?=
 =?utf-8?B?YjNXc3RQbVlQWFh3Zk9STTN4ODlNMkxSK0paU01WWWVYSGdMdzdHaDdVOU0r?=
 =?utf-8?B?ait2YUl5RXhYMUFRQ2plek5zejIvcnZ1cHV0V3Q2eVdQMnd2anpnOGRYK3Vp?=
 =?utf-8?B?TlJCQVFlU1k5Zk9EL3NwbDQzVk10bjFsZVlsb0Nrb294eUo4WjIvNGo0Qk1w?=
 =?utf-8?B?cXFBQ2wvMENJeHlZWHVucHBOTEx0ZnEvNXltRmFwYk5lSzBGYXhiT21Yanl2?=
 =?utf-8?B?OEh2Zzh3TUl0KzZJQUNhTHhsNlRNMmN3bDhCeitTbUdVMW1IVURFY2FVTy9E?=
 =?utf-8?B?SnJxbllsSW9TOVRFSDdySC9tUnVhNVFEamVwQUVhendQWnczNXQ4QTZqVkx2?=
 =?utf-8?B?dzVaWWhxZTlUazREcmV2Mmp0WlNuek43Z0UxUlJ3RkdzeEwxZ3FOOFJqSURl?=
 =?utf-8?B?Vmw2SFZQSEQ2OGh3a3RTNmZvQ0dycXVjbXUwTTdZY3laL0hhTGlSeGhuMjVk?=
 =?utf-8?Q?u9TCAuM77ws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXJHRkN4RndEclpRS1NpeXBoL0R3T0RJWVU5MkI3eVVQblJiUDBXTE5Nay8v?=
 =?utf-8?B?dEJuTWVZNlViSWI4ZVQ0bE9SZXRsM2s5QjFkcmNya21GMXdTSXpQV0p0Vitp?=
 =?utf-8?B?ZWNaR0syVWEvTGFVQkFLbkMyMHdWdlFRbHB3WWpreXcvanNzOUtzWlRMTzYx?=
 =?utf-8?B?SUkxUEJpTFFKeXhLKzJ2cVdjanUwSXk3Ykg4enF3OVZIU3ZBYTRhVytVUjlm?=
 =?utf-8?B?SkQ2RWpUS2t3clVBQjVnQ085czRTUlNxdjlIcjZ5ajBmQVZFS0JHSExidnBt?=
 =?utf-8?B?cHE3NXY4amVvZ3dVZXk4ZDY5NWVTK0pSaXA1WHFtMkVGajFoczhjMXpnclI0?=
 =?utf-8?B?WnpUZUJDbFVBWUlpK0JJbzQ1cGJoOEp6L0IvWWNRVitmZmlLRE5Oa2QzKzd4?=
 =?utf-8?B?aXZCOEFPMmVtaENqcmlSaUlwV24vR3o4TDNvVEp6eFRJZVRwV1lhS3QxZld5?=
 =?utf-8?B?NHFRdHdPK21qZmZNd1MxaW11T3BFS21aa2FoMGFvNU9ZSks3OFpYeUk3d2Yv?=
 =?utf-8?B?dDlJQzc0aUJ6L1c0bXZ6YjJYYTl6b2tHb0I0WFg2QzVTeDZXSDZPWTZSaCs5?=
 =?utf-8?B?N3ZwK2V1TDdtcnJqbGNDM01nV3pNWThycmRhZUxtY3RhbjFtTGNBRk1Ib2o4?=
 =?utf-8?B?SnlzTTNRTGpWeVdMWEdxNUI5dkg4V21hWERiaTNldmEvNVNvb1Rna29FeHBR?=
 =?utf-8?B?RHp3cm5JR1dBbnJzOW1aTDB1UjlObHVYY01QdGgycFBXUit3WGJzZ0s0WmdE?=
 =?utf-8?B?QjlBY3lKUDQrTGVsdTNnZzFZbEtRNmlWK0NaTHd0UnlOYTdKcnFybXljY2V3?=
 =?utf-8?B?ZHZMY21vQ05iVm5HVVMvcElDa1ViR0ptdmFzNVZuVWNVZUMvTjFLYzRUMW05?=
 =?utf-8?B?TUwxNEtrRENQUStxZGhuMW9MU1pTdGNUdHRTZWtoSHg4ZFpxNTEwVXVDQkJk?=
 =?utf-8?B?eklHOXdYSTdOVFcwT2lsanJsRXhxMmZIK3h0REM4b1o2cVM3bXc3R2YzSEFy?=
 =?utf-8?B?TTEwUVk4bng3d0gvNXJHamxJWHBxNzRoOUpMaThqQkNlVVhZYWg2OFRXR25v?=
 =?utf-8?B?Uk5WMVFaWDB6U3k0WU1TNmFGN0FXUlM5SGJQZFUyclV5Z3JMWWVObHl5VE9J?=
 =?utf-8?B?MTBHSU10a3kvVFNTdkZUSUV5VVdHNm4wbmhPbmF0NEZpTU1KYmM5OVphVng1?=
 =?utf-8?B?Z01xa0pad1hkSmlmRGx1SUViSFFiNk1OV2g4L1RRQ0YrbjZreGFqV3dhNWJ3?=
 =?utf-8?B?K3pKZk8vOXNBRS9iaWFreUpYOS9HQzBUY09LUjZkbGdjUlVINWthdDBFZ0Nx?=
 =?utf-8?B?VnduQzdpbHprK0gzMko0WUtTSmcyOGlabndjT2hZekVVeTlYWHV2Y1VmUzFI?=
 =?utf-8?B?Mno2aE5FVWtkYXg0VHRtUC94UE8xZGFLQU5ObFBLanp6ek5nVlhZc2lNTzVj?=
 =?utf-8?B?ekZGOEJGNG12RFlhbXYzUm5ScXZreGhZNDdWelBsOUNjVHpBR1IrMmd4YkJu?=
 =?utf-8?B?VnZTMFljc2JVVzAzVG5Yc0RqL01vMlozTy9GRnVZeUI5RWQwZ0tVUDF1OWhC?=
 =?utf-8?B?R0I2ZEFodEJHSjl0K3ZlR1VRM1dZMmdVMWpnUDAzM0o0MUZxalQ0NHhWRVFL?=
 =?utf-8?B?QmtQWlJlYjZ1Z3QzTm8ra2lzd3c2N0VxbDRMU2xxeGRJTTNISFhXaHRReERu?=
 =?utf-8?B?RUxnY2RwbkxRcHlIc1JXd3FyRjhTbjRGc0RKbXN1VVdLZDhWQkpwQk8vWXJZ?=
 =?utf-8?B?aVI0NXlkWlYvS2k0TmpHc0tPZXNYYVNHVHRHQ3lxV0k4Z1JBM2JXUlZ1L2xN?=
 =?utf-8?B?TWRKMUxYTDNpenZyd2ZWbmkzWWg1NGtpcDVSSTZkcHN5a3BHMVQzT3hGemxC?=
 =?utf-8?B?UHhJZjVKVEM3TnJiaWsvU05EVml3bmVTL0tTMCs5ZnI3ajgwdjJ4akV6ZGNK?=
 =?utf-8?B?ZkVEaEdQRHNUeUIxU2FTQnVpaTBXNE93a3FjcWxyT3pHUHNnOWo2K1dYZzYw?=
 =?utf-8?B?STFlem8xTG5MSUV6MFE5ZWR3UWUvRUF0TEVFVzdHbk9oQXA3TnRoaG9nZUM2?=
 =?utf-8?B?eDJ5c1lLZEJ4eDRIbGRuaGxPUzcwL1RVYktML2loY3ovLzJLWEdwemN5SnN4?=
 =?utf-8?Q?8yhd5Q9WXBR8mUKQyu3l2XFIS?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b724c-33ca-46d2-154c-08dd581b6b31
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:54.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvScHMO2DyWGnV14p+fOrNC2T4WpUjReOyBJ5dt2whAxdZ88DMbkEPON1BIEd8udvYI7sLi/WF+i8LGssj8/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-Proofpoint-GUID: uZkVTzZFJZsVISfwVTwy6b20qLt5Y57P
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef13 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=94Nz2Nw6my-I-Yvh_ZUA:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: uZkVTzZFJZsVISfwVTwy6b20qLt5Y57P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

SnVzdCBkZWNsYXJlIGZpZWxkcyBpbiB0aGUgc2FtZSBvcmRlciBpbiBidXNfc3BpLmMgYW5kIGJ1
c19zZGlvLmMKClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxs
ZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVz
X3NwaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3BpLmMKaW5kZXgg
MTYwYjkwMTE0YWFkLi40NjI3OGRjZTdmZmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NwaS5jCkBAIC0yNzQsMTEgKzI3NCwxMSBAQCBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCB3Znhfc3BpX29mX21hdGNoKTsKICNlbmRpZgogCiBzdHJ1Y3Qgc3BpX2RyaXZlciB3Znhf
c3BpX2RyaXZlciA9IHsKKwkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAorCS5wcm9iZSA9IHdmeF9z
cGlfcHJvYmUsCisJLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogCS5kcml2ZXIgPSB7CiAJCS5u
YW1lID0gIndmeC1zcGkiLAogCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3Nw
aV9vZl9tYXRjaCksCiAJfSwKLQkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAotCS5wcm9iZSA9IHdm
eF9zcGlfcHJvYmUsCi0JLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogfTsKLS0gCjIuMzkuNQoK

