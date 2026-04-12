Return-Path: <linux-wireless+bounces-34651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CwtCBdYV22nj9AgAu9opvQ
	(envelope-from <linux-wireless+bounces-34651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 05:47:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8253E2A0D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9A230233C2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C02220F2D;
	Sun, 12 Apr 2026 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQBz8shz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4D1A6828
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775965651; cv=fail; b=DAWZ9ZtSFAtQecQz+RPJwn1Tsm/aQYWW6eby7RE05oZxih+JKyM4MnsZD8Qxf56f9OreRjNq9Z53ExBfrqJNer095RgXMwxmMyJ+rjuqxNwwodsuAsH42RjOlGvzhFkSgDcabSNWq4ad4Q1GbkngJRj4co85C3LPdqSI5agjNos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775965651; c=relaxed/simple;
	bh=2d3qY75bx5IFWQrxPouapFpKkAkudX9nvtqoOpcNl+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYx7N+cb2Tzd+qSb0t18sLBdF6EN66aUtE4JXawGKSN6Yycu1I8hfZ+tS68+92jDk6BpxkuxyK5LACObTNiKQMhtIkkXEV34P69RDyH9yrXqkL5F2qg72SA0gL3v94UaXmhPw71cvhw3OQgDJ9A5mth+2kcqyOIoUeSTyCC+ylg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQBz8shz; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775965649; x=1807501649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2d3qY75bx5IFWQrxPouapFpKkAkudX9nvtqoOpcNl+o=;
  b=RQBz8shzaAWpfJa9qR2GlMAvts3bmggQVdZYrgLN2DASbJk4xzKA0AO7
   goyuuO5L7xjR9mKTOVwmmAluO6uTVFiP9E13o6iFUtfEduK/C8cDj9uUx
   Y4RwgnJWABOrxXO71db65U1aEOWTuPDNRV3H80bFyPRDnZc/B+e4SpxBz
   vSkExVbF/oWJ6il1la/Skvlqn1sNzOVEI1O++3ZfLfVkyWSfjWB1f9Iif
   hfDwakE5Nk379T1aL0qFFBIyW1wYbeGdyZEO7ENjg/PaOCxx4sQIjpGf5
   ipq7qahQPuHNwNoAhmFD0iBwXRL37r2MFtZ5OHZB7aQ3E2y1NX27Sovb+
   g==;
X-CSE-ConnectionGUID: f/EwGXMmTNyxCLfy12NvIg==
X-CSE-MsgGUID: LVfFR2avTMObht7/n5c8GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="77050394"
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="77050394"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 20:47:28 -0700
X-CSE-ConnectionGUID: olbnYICJRza0n7RjwHApFQ==
X-CSE-MsgGUID: lG53z0ClTqa/6Ydg7l96TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="234378267"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 20:47:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 20:47:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 11 Apr 2026 20:47:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 20:47:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz5G314MCfePL4zxq50kQGkvYV5e4U7oChbJ8wlrvQuZFN7abocap0UF4niNlVSgvCoYKqGJHF0Wud7d2ytsb83Rw1A9+6CcLc+30SXRKwaS81NZjlxmTMximSU+82fs+eHVsTxK7WAz24vj0PrwFvm5tHTvzLUh3fLpLcyj1PvDR4Vc7j+hJAaWI9y7/9/jRpklFRNLjmc6mwv8E6eC1TKH+LvMTWtqF1oa1zXLgC97TWFZQmVq3PbOZfrJs9sP7cDEyATA6qEMBHL1cJ9xVrMxnQ2ok1rt83UZtD+ikHvwCp44DyBnxfFC3GoHKfw+5nBGGCLNRNPiO7GX7/wAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d3qY75bx5IFWQrxPouapFpKkAkudX9nvtqoOpcNl+o=;
 b=WlIUEdgKcJbT2EPKSoEicLXuTYr8VSEc53Ja9x7MAhztNOyyHRnZ8yeCuptw1QGmEfo4i6z3lE3lvW2awmXAWm4ORrFWPhpwXGtyCmywTppeXGtVqekjYvTkbO8PiGQLmB8kZT5CHB8jjl2ow3wCw+brZdkka1SmV8WNOh2M6JMVudiJ0HcI+RUWC2g4R2ZcFXcQGC2CkyIdD4zlrUMkCza6XYzQkte7rmz4lDqfXBCbiEnWpFTMBkSwcASqNEubxtZBYzgJM9fSllwSK7ufGK1rSTSICI1RjfeKfL42ah6bbM+MTIJ8W9t0+txV5jU1SDRb8ezrabPbSG1UJPjySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 12 Apr
 2026 03:47:24 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%6]) with mapi id 15.20.9818.014; Sun, 12 Apr 2026
 03:47:24 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Cole Leavitt <cole@unwrap.rs>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "greearb@candelatech.com" <greearb@candelatech.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [PATCH 2/3] wifi: iwlwifi: mld: fix TSO segmentation explosion
 when AMSDU is disabled
Thread-Topic: [PATCH 2/3] wifi: iwlwifi: mld: fix TSO segmentation explosion
 when AMSDU is disabled
Thread-Index: AQHcxL7ynTgA72iHWUGR6uxbUrfZr7Xa1HrQ
Date: Sun, 12 Apr 2026 03:47:24 +0000
Message-ID: <DS0PR11MB788029013A25A284B0907D01A3272@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260405054145.1064152-1-cole@unwrap.rs>
 <20260405054145.1064152-3-cole@unwrap.rs>
In-Reply-To: <20260405054145.1064152-3-cole@unwrap.rs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|IA4PR11MB8990:EE_
x-ms-office365-filtering-correlation-id: b7cdf4b2-d976-4559-5f0e-08de9846354a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 01l5g61pVWBANv79F4F/PS5u3+JMKzm6XCtehTaADm0QvJe/SCCC+auCxQdTSdhdjw+QtFmQDsTraqtoMPxobpEP6rhDK9LUlzww0F64YZLa+3RUO1mrjNzDpWVw1TI2LmFx9VJDwSgskB4UGs4kZYZD6KtIQ5lUO+WCgRtts5PQeszZVOMySm27nGhUaShh7yxByMFyJizyaKX7vt0B8HV+N2H+twBAle2yfUALNuOnTuXCI50soRVPpEazlrThsxl7DV/zACKg2mLzD0L2C5KWNK3GLJLUDGGGzrro8qbkKZHslN+v9v+oBoi71J0TwSbY0kbr5ef/hh4dbsLSp0OJV6Z5vcpmn+SA+FFUE4BhB/xEuboZcDxfF5dnd9kUUUheler1QIQ/dYRs/OWbvEqpxoYtPVhCfU9QaGBVs7ekCzJRwPEPGhkcIeNdGTTLieQcgt6TTNWZRklg8/8lked5cDfWtpYfwtZmUyYFQe6UfAerrZGbvyo3rVNNYKeeYCU6SwCn28fPD1H3hOzL5PjdmnF5AyQo+R0O0EbK1qa1ztH2WBFqE1XJENOzGlkSt8vxV3UTP8xs3NRj4ocIppvbIfvpOInDcSRy3qrVmDQ+iraRtUsvkjUga/2jR79D7SaEVsxYR1COUeCL2qV2qsnra7tQFBjEr7q2xTuDqhi0l9A8akhBCTG0XrK6+EHIi/CuGx5uLEx5N9/rAStBJ60ZhOV4AckdrfHRPwE48CZ41yApJgJW1lADlKI4m9wqzxrYQ9YVDJRZ1d7mhnY8PR0Ks5yyk+t1EQOQ0xZ51WI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzJxY2VmUWZ2UlRPbXBHanlua3RjZXVKanBIendsYjNQa1hRWEJPZE8wYWU5?=
 =?utf-8?B?ZEVwV0ZNdW1xYmROWnJLMFVrenU4RFhpb2VOTlJJemlNb0JYZUw3SWxDaDMr?=
 =?utf-8?B?TmwxcGo5UTVsMUNGZTZwM2hTaHpjWUYrUm8zc0RuWGNCWUJENTJObjNjTzRp?=
 =?utf-8?B?ZnQxZ1d6ZU1peDlQd1R4OTdiU2FZNytydS85UmxZNCtnbkFSZmJCSEJtUmFK?=
 =?utf-8?B?Y09qNXoxZFVSTHBlVUhoYi8wSWtnbzVmQXc2Wk93OGJ0eHgyNXo0T1dTT0FF?=
 =?utf-8?B?VVphaGV5cEx4Nm1CelVxZWdjMjk1RDRYdlhieUNFWUVKTzMrbCt6WVZUWElL?=
 =?utf-8?B?MmtTVkV0U1BiS0gvNFVkMjVjNEp2Y3BFSGx4YXZIcVltUjlib0JXQnF0QmdX?=
 =?utf-8?B?c3RUYXNUeVQwYWthZ09NeEhmMXo3NWRVTG5uRy82ZVlCQUVOQzBWblR4K29D?=
 =?utf-8?B?ZEtWOHVzanNXTmpyMW1zcVc0ODYrWlEwSnpwQ2RtVThyNmllMXdybHNENGM2?=
 =?utf-8?B?Uy8yU3RQQ01XQVFTRUY3VUJSWVl6bFEvRVdWTi9EMjFIREg4cW5XUzQxNXVO?=
 =?utf-8?B?VStMelRMdkwvWEgySzByKzF3L0JleERucnlIeld2UzJIaGdvUW1XNFc2TUN0?=
 =?utf-8?B?bGcvM2MyVWdjdDVXcThnc0NhSWtXanBvWS8ycEMydFJvTFYrYytMQ2IzNi8y?=
 =?utf-8?B?RFNBZjBFTnV0TVg0OFZOejRWS0VlTVU0a2RQSkRFTlF0UVBGYm9PRVh3ZWJs?=
 =?utf-8?B?cFJPZzYvWHFSbys1KzJaTTBrKzFXdVBLdXVrajRHK3BST0dsUVoxS2s2OThR?=
 =?utf-8?B?SGJkZ0pnajNPTFNoRW5YN1FuM1JQREZJeFJyMVFSSUxkWUVzTXN2eWc5YjRa?=
 =?utf-8?B?S3QzZEdNS2FYbWZ0eXVqS0VCd0JQbGU1ZlVGaDd3eGkrOVpWYTBNZW1pN2tM?=
 =?utf-8?B?MEVlTkh6b29leGxxMDl4SWZpWG5iZ2dISng1SHRuRSt6ZWdaQ2QyMVNWWnZt?=
 =?utf-8?B?Smhjb0hMV1BhU2FGTDZqRFBHNUZNL2o2Y0xBbmxwTTREMW9ZU2VDZU1EM3l6?=
 =?utf-8?B?RFhwUllDUUY1UjJaY1B5VVo3MTF6UXV3b2x3d0s5WnhiSFNlQUp5YXkzVXMr?=
 =?utf-8?B?UmVrU08yN1UvNC9EMUo5eDhTcmVzV2t0NjM4UGpQSS9LQWhveGVrYzRyeXhn?=
 =?utf-8?B?dm5ORDk2SFlMLzdQTENJeDh1UjdJMFNQNUtnTE44cWxJTEdoZURtMzZYb25P?=
 =?utf-8?B?QmJvR1RpV0IxMzdnSGtzcnF2VmIzUVMzeDcycEw5VFViaGJnR3VQOUk4dUxQ?=
 =?utf-8?B?SCtWZHdVS2lqYThZczA2enFpZlVTQmtGSU1JWGJXVGdkSXNPOVJvTFFFcTd3?=
 =?utf-8?B?dzV6VXlXUGJ1UnNTL2ZjNGNKSFV1N1RxTnRjYzUzZDhpVDh5VlBiWlgwekhV?=
 =?utf-8?B?WjBJRkJPN0Z2VDJma0F6endSVitGbXBDOTBOZ0NoVjlpTmpRenFzMFR4RmVQ?=
 =?utf-8?B?eVlxRlhUWUFrcVpQOHJnRDdtd3l2WjJGSG1heGpHdXhmbjZMOHErQm1rMGRh?=
 =?utf-8?B?WnoxUlVWY0dkZTJhQy9qZ25SRGFoSjduTENzVVVtcDI3QURCaHFLV0t4anVy?=
 =?utf-8?B?Nk5QUmhuenJuQU13WjJLTHpLM1hBREtxTlA2NURiZE51ZDNhZm43VTZ5OHZ1?=
 =?utf-8?B?WnRUUWhUenlzYUx0czNlS1pBZFd1YkF0ZDVZNVV2MnBHUU9VeUdCL05maDE0?=
 =?utf-8?B?ekRBbENnaENLNitCQ09xbFlUc0JRWS80b0IwalkyV1o3SE9EQXNEeUFKeUdD?=
 =?utf-8?B?Z2NabUV5Mk5ZL0JhZXlORWJHcjhHb3o2d0c3dEVBME90NW1oaVFsRXorVkZr?=
 =?utf-8?B?eXZLZXJzdEl2UUMvV3lXVVNXc1J2SEUwZTVZOStzKzRDRXZDZlB4Y3hpQ1ZF?=
 =?utf-8?B?YXhCNi9tbk9LeE84NGJDa0RHRjJneWFSRWV5ZVUxQ29kcDhpN0dCTUxISFIv?=
 =?utf-8?B?dWYwZUZiWVN5djVBQ1BJZkNscVFsOUx3VDIxUnE5Q2d1ZHF4Y3NEM2ZNTG5E?=
 =?utf-8?B?RDl0cTJDcXBBMGQ1Y0ZidmFJYVZ5d0xnVkIrNUcrZThMbGxuZzNTRFdpc2Vx?=
 =?utf-8?B?OXVLUzFDUG1pd0FiQ0pMZEd5YTBXaFRqQmN0T2swTnM4cHAzSGJjZVRNWUx6?=
 =?utf-8?B?a0NUTmc4QVVQWUdMZkl5SGZyVmtzbWlzUm1OSkExR3IwMHZNM3Bxd1RsL0ZR?=
 =?utf-8?B?VjgrRUhEbFhaRTBzczFoR1NBS2svUytkS25rNzBTZGtQYWdJc3A1eGNmSFhu?=
 =?utf-8?B?NnJNZnNnOXVDZWU2Qk9wYjFSamxEZXdNQXRxQllpRDVuUGQ2ZW81STEvMGhk?=
 =?utf-8?Q?FkiQw8NyM3PXfIgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OTdZBl3qOrDGEeAp3S6L25pyBMqJTiyVeW3DMTe7GxQZDhQe0Xv08WoiZKjE+cDxggMZ0LdVLF9D3XQic7v6AuiW+z2VTP2TLLZuvF30TAvraPine1fV6Sg6UQQe+UvzgL3fWT5c15eHqPmYXXXwgf6XN+24Rwbqvqlm44Q3sEbYWndSKdjIfUQcGmIE8vXsM5jBpTI6dHpiDU7BCD0ZWGbKI92ui8KhOkkj0IVlrblT0hstpmBs7sd9JWWbKAxKu8Mfaq7KcNi3vKKws4hVsth9CsAfQlRPX7vXxcV9voxhysDtCMFBKPPb6xDU1a/Tx9U+hafhrU+8Q2uj3OaxLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cdf4b2-d976-4559-5f0e-08de9846354a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 03:47:24.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXnpHQUZdfA8YCVfXBK2p/Z4hU8/usqhQH7aL6ZAYhQ4MSECMtgDF+edESzSkdy44eDrvMFfjuG0f9JvZBuz3vPYQ8Q5fSwhVXOUn0sKIVGjI7/Z0m7gNN/d15kBoPBK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34651-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6D8253E2A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29sZSBMZWF2aXR0IDxj
b2xlQHVud3JhcC5ycz4NCj4gU2VudDogU3VuZGF5LCBBcHJpbCA1LCAyMDI2IDg6NDIgQU0NCj4g
VG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZ3JlZWFyYkBjYW5kZWxh
dGVjaC5jb207IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3Jl
bmJsaXRAaW50ZWwuY29tPjsgam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldDsNCj4gY29sZUB1bndy
YXAucnMNCj4gU3ViamVjdDogW1BBVENIIDIvM10gd2lmaTogaXdsd2lmaTogbWxkOiBmaXggVFNP
IHNlZ21lbnRhdGlvbiBleHBsb3Npb24gd2hlbg0KPiBBTVNEVSBpcyBkaXNhYmxlZA0KPiANCj4g
V2hlbiB0aGUgVExDIG5vdGlmaWNhdGlvbiBkaXNhYmxlcyBBTVNEVSBmb3IgYSBUSUQsIHRoZSBN
TEQgZHJpdmVyIHNldHMNCj4gbWF4X3RpZF9hbXNkdV9sZW4gdG8gdGhlIHNlbnRpbmVsIHZhbHVl
IDEuIFRoZSBUU08gc2VnbWVudGF0aW9uIHBhdGggaW4NCj4gaXdsX21sZF90eF90c29fc2VnbWVu
dCgpIGNoZWNrcyBmb3IgemVybyBidXQgbm90IGZvciB0aGlzIHNlbnRpbmVsLCBhbGxvd2luZyBp
dCB0bw0KPiByZWFjaCB0aGUgbnVtX3N1YmZyYW1lcyBjYWxjdWxhdGlvbjoNCj4gDQo+ICAgbnVt
X3N1YmZyYW1lcyA9IChtYXhfdGlkX2Ftc2R1X2xlbiArIHBhZCkgLyAoc3ViZl9sZW4gKyBwYWQp
DQo+ICAgICAgICAgICAgICAgICA9ICgxICsgMikgLyAoMTUzNCArIDIpID0gMA0KPiANCj4gVGhp
cyB6ZXJvIHByb3BhZ2F0ZXMgdG8gaXdsX3R4X3Rzb19zZWdtZW50KCkgd2hpY2ggc2V0czoNCj4g
DQo+ICAgZ3NvX3NpemUgPSBudW1fc3ViZnJhbWVzICogbXNzID0gMA0KPiANCj4gQ2FsbGluZyBz
a2JfZ3NvX3NlZ21lbnQoKSB3aXRoIGdzb19zaXplPTAgY3JlYXRlcyBvdmVyIDMyMDAwIHRpbnkg
c2VnbWVudHMNCj4gZnJvbSBhIHNpbmdsZSBHU08gc2tiLiBUaGlzIGZsb29kcyB0aGUgVFggcmlu
ZyB3aXRoIH4xMDI0IG1pY3JvLWZyYW1lcyAodGhlIHJlc3QNCj4gYXJlIHB1cmdlZCksIGNyZWF0
aW5nIGEgbWFzc2l2ZSBidXJzdCBvZiBUWCBjb21wbGV0aW9uIGV2ZW50cyB0aGF0IGNhbiBsZWFk
IHRvDQo+IG1lbW9yeSBjb3JydXB0aW9uIGFuZCBhIHN1YnNlcXVlbnQgdXNlLWFmdGVyLWZyZWUg
aW4gVENQJ3MgcmV0cmFuc21pdCBxdWV1ZQ0KPiAocmVmY291bnQgdW5kZXJmbG93IGluIHRjcF9z
aGlmdGVkX3NrYiwgTlVMTCBkZXJlZiBpbiB0Y3BfcmFja19kZXRlY3RfbG9zcykuDQoNCkFuZCB3
aHkgbm90IGZpeGluZyB0aGlzIGlzc3VlPw0KDQo+IA0KPiBUaGUgTVZNIGRyaXZlciBpcyBpbW11
bmUgYmVjYXVzZSBpdCBjaGVja3MgbXZtc3RhLT5hbXNkdV9lbmFibGVkIGJlZm9yZQ0KPiByZWFj
aGluZyB0aGUgbnVtX3N1YmZyYW1lcyBjYWxjdWxhdGlvbi4gVGhlIE1MRCBkcml2ZXIgaGFzIG5v
IGVxdWl2YWxlbnQNCj4gYml0bWFwIGNoZWNrIGFuZCByZWxpZXMgc29sZWx5IG9uIG1heF90aWRf
YW1zZHVfbGVuLCB3aGljaCBkb2VzIG5vdCBjYXRjaCB0aGUNCj4gc2VudGluZWwgdmFsdWUuDQo+
IA0KPiBGaXggdGhpcyBieSBkZXRlY3RpbmcgdGhlIHNlbnRpbmVsIHZhbHVlIChtYXhfdGlkX2Ft
c2R1X2xlbiA9PSAxKSBhdCB0aGUgZXhpc3RpbmcNCj4gY2hlY2sgYW5kIGZhbGxpbmcgYmFjayB0
byBub24tQU1TRFUgVFNPIHNlZ21lbnRhdGlvbi4gQWxzbyBhZGQgYQ0KPiBXQVJOX09OX09OQ0Ug
Z3VhcmQgYWZ0ZXIgdGhlIG51bV9zdWJmcmFtZXMgZGl2aXNpb24gYXMgZGVmZW5zZS1pbi1kZXB0
aA0KPiB0byBjYXRjaCBhbnkgZnV0dXJlIGNvZGUgcGF0aHMgdGhhdCBwcm9kdWNlIHplcm8gdGhy
b3VnaCBhIGRpZmZlcmVudCBtZWNoYW5pc20uDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IE1pcmlhbSBS
YWNoZWwgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+IEZp
eGVzOiBkMWU4NzllYzYwMGYgKCJ3aWZpOiBpd2x3aWZpOiBhZGQgaXdsbWxkIHN1Yi1kcml2ZXIi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xlIExlYXZpdHQgPGNvbGVAdW53cmFwLnJzPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3R4LmMgfCA1ICsrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdHgu
Yw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3R4LmMNCj4gaW5k
ZXggZTM0MWQxMmU1MjMzLi44YWY1OGFhYmNkNjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3R4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdHguYw0KPiBAQCAtODIzLDcgKzgyMyw3IEBAIHN0YXRp
YyBpbnQgaXdsX21sZF90eF90c29fc2VnbWVudChzdHJ1Y3QgaXdsX21sZCAqbWxkLA0KPiBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICAJbWF4X3RpZF9h
bXNkdV9sZW4gPSBzdGEtPmN1ci0+bWF4X3RpZF9hbXNkdV9sZW5bdGlkXTsNCj4gLQlpZiAoIW1h
eF90aWRfYW1zZHVfbGVuKQ0KPiArCWlmICghbWF4X3RpZF9hbXNkdV9sZW4gfHwgbWF4X3RpZF9h
bXNkdV9sZW4gPT0gMSkNCj4gIAkJcmV0dXJuIGl3bF90eF90c29fc2VnbWVudChza2IsIDEsIG5l
dGRldl9mbGFncywgbXBkdXNfc2ticyk7DQo+IA0KPiAgCS8qIFN1YiBmcmFtZSBoZWFkZXIgKyBT
TkFQICsgSVAgaGVhZGVyICsgVENQIGhlYWRlciArIE1TUyAqLyBAQCAtDQo+IDgzNSw2ICs4MzUs
OSBAQCBzdGF0aWMgaW50IGl3bF9tbGRfdHhfdHNvX3NlZ21lbnQoc3RydWN0IGl3bF9tbGQgKm1s
ZCwgc3RydWN0DQo+IHNrX2J1ZmYgKnNrYiwNCj4gIAkgKi8NCj4gIAludW1fc3ViZnJhbWVzID0g
KG1heF90aWRfYW1zZHVfbGVuICsgcGFkKSAvIChzdWJmX2xlbiArIHBhZCk7DQo+IA0KPiArCWlm
IChXQVJOX09OX09OQ0UoIW51bV9zdWJmcmFtZXMpKQ0KPiArCQlyZXR1cm4gaXdsX3R4X3Rzb19z
ZWdtZW50KHNrYiwgMSwgbmV0ZGV2X2ZsYWdzLCBtcGR1c19za2JzKTsNCj4gKw0KPiAgCWlmIChz
dGEtPm1heF9hbXNkdV9zdWJmcmFtZXMgJiYNCj4gIAkgICAgbnVtX3N1YmZyYW1lcyA+IHN0YS0+
bWF4X2Ftc2R1X3N1YmZyYW1lcykNCj4gIAkJbnVtX3N1YmZyYW1lcyA9IHN0YS0+bWF4X2Ftc2R1
X3N1YmZyYW1lczsNCj4gLS0NCj4gMi41Mi4wDQoNCg==

