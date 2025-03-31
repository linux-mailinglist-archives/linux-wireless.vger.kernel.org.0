Return-Path: <linux-wireless+bounces-20997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DDA7640C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED91B1662B9
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023801DE892;
	Mon, 31 Mar 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBgoRKUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A1DEFDC;
	Mon, 31 Mar 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416499; cv=fail; b=PgarQOi9yNcvnQyVojxVfo4Q5fbSZef0X14tCh289mbGBc6N+JAM7RgWSqV1OcXobKAbTDjMkqszqVDaQPHU6dKC2glKNE6bKNR88BklgeozRWHSatER+LGAKn9O6DmkEE74fLQ1YEvpe7qibs4mFUQ5qthnBqIzzKmzZD9UT3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416499; c=relaxed/simple;
	bh=77gJzOh5O4iDiA3391f2kFURIHsDUeEnt0Cv36dA57Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+dcN8xI98G1ATweiK72ZcofJWO+MJGiaoMr0Q2OdOU7IwJ+VoXCM6RfWkEcPpHfcjRDLM3J5WKgeaz+1cdQ/4lc9MArVYaxNwI33OH610TilHW+eboZ8+jK4n9wF3i86/WMveJW114DjZ7om8ZwRm2tmdOS3gt6/bPNOZ1+vWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBgoRKUl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743416497; x=1774952497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=77gJzOh5O4iDiA3391f2kFURIHsDUeEnt0Cv36dA57Y=;
  b=VBgoRKUlVg0HOIkiEQUhJfTKI/gsfXUUSw3o+lfPBwiqi23hqw7in+Iu
   WUsGkXOClsQDBrGPnsW3a27sOTtJjYYHbfpLK6jhSnPbGtaPKqMJY3h/8
   xDrIOqBH9KBct7RxjOMp7VsCnriudYFyrYMYxop/KpSbWE0SnwIupvP1Z
   2otvI697BB28LO+iEEITCgexElatbGoMo90ppzuapQ7HsKadYH9v6yrXG
   Wmg8wSnmYSLvFakGFjDQyugT1jYvceLYYWWAbOFzmeYE9mo2V64f6CkLU
   iMooiZDU+319hKxyKOwnD+25p8jJqEHOFuQS62U2Rtqy0+vpyKQe/BGsV
   w==;
X-CSE-ConnectionGUID: wetG2e87TQuHMBZYsOZD0w==
X-CSE-MsgGUID: URdqLZpeSYyCTtmTM8RvxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="48570475"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="48570475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:21:36 -0700
X-CSE-ConnectionGUID: bZtPfSQxSaKhFc0jfmWXRw==
X-CSE-MsgGUID: W5msIaoeQKCi4nl8Rw3e2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="125811843"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:21:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 31 Mar 2025 03:21:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 31 Mar 2025 03:21:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 03:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klng00nmCpouPw0ITWI+jAUzS91CTd0SdwfQZWgxGWGDcollS+CIaJIK/bl3Rvpas8pQZOIma3SWh+OFT83ShWCKQSAXusAxPKyjWVOSjIjFUm53K0ztCJOhb4oY05x9lIocc67W9C92Jfl0f1hxrgweV3jUsmGJZdujahlGcdq5klB3J3vMSXdjhijGBhb7BynsitPhSpdC+Vo5TEB5pEEmlSzIQw6oEKf5v3WhsbvPfiytyFRjfKhQldDBWGn3hWdIN5l8dF4mh0KY+8t/k+74SrfcPxfX+0i9em4mNKy2WvFeF8A1xCaTSUDZzl9qI3ohr1Vjo6yt6JNLj8jUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77gJzOh5O4iDiA3391f2kFURIHsDUeEnt0Cv36dA57Y=;
 b=SR+MzBMKOy/pheCfm6gRvfq366KxnHtF1Bfgd7YZSg0O876dEJAvYe/uBeou5uIsdUuQgyxd14OKVo+Uu+LPlq6F63z7STc7Gpz0mivtPv7HSmFMzow123CipZXb04ChuFhw+Oc6HL5O1cEY1ybxQuj0Ne9baBtMoz8iJRC91nOZFRCAygVXtj+0OyBv6jixuF1vEsoDuNk/fK03oXg1V9EaJZuEyOhdhCqC6vJrVi3GF9mRfsa9EgMdkF/vvriKYnevpx0tlynKILbUG8wQGn4Iz3OypFPLkoAzz7YZ6OO+H91DwP4WGftyxwLgBL++pld4HW7ArvbARNGZFRmybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MN0PR11MB6158.namprd11.prod.outlook.com (2603:10b6:208:3ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:21:06 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 10:21:06 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Wang Liang <wangliang74@huawei.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "ganjie182@gmail.com" <ganjie182@gmail.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, "Stern, Avraham"
	<avraham.stern@intel.com>
CC: "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"zhangchangzhong@huawei.com" <zhangchangzhong@huawei.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: iwlwifi:: fix spelling errors
Thread-Topic: [PATCH wireless] wifi: iwlwifi:: fix spelling errors
Thread-Index: AQHbnGdzWR+djD0H3ECkGRuM43E5QbONFESQ
Date: Mon, 31 Mar 2025 10:21:06 +0000
Message-ID: <MW5PR11MB5810B1FFE4B4B7A7C08AFC35A3AD2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250324030021.2296493-1-wangliang74@huawei.com>
In-Reply-To: <20250324030021.2296493-1-wangliang74@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MN0PR11MB6158:EE_
x-ms-office365-filtering-correlation-id: 532d4d75-5480-4b42-b16a-08dd703dbf44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?NUk0WUxDQ0YrWU9rSXZlLzI0Z0JKM2Y4dUttdTlyWFI4WTUwYW05ZGkwRmJy?=
 =?utf-8?B?RGpXTFpBS0VPSUhKQlNoL09xZ3FYYUxRMVZVbUF6VVBFd0N4dkh3NTA3UDFa?=
 =?utf-8?B?SVhHcVJ3ZG5IUDFvdTlraUdGNWdFaUJORiszb0xhV1dheUN4QUNhQ1p1dStv?=
 =?utf-8?B?NzZEem1mLyt4bG1NUlFWL1FHMFFaOTBHTjlmaTFYc2NMck83bkdrc0xYcTJW?=
 =?utf-8?B?K1QrVG5iWlJ4bEtaZ0R6cytLTkJQSE1POTFQKzg2RkFXcURhZG9FOW9PQjVV?=
 =?utf-8?B?Y1RmQTJxS3Bmc0QvWWpOTFFqZFZiNysxUGRSMlVydUdhQURlR3RySFBER3lD?=
 =?utf-8?B?YUxqL05RcG1iblBuYzRLVEdDVm1rR285c1A2UEdYRHlSZmJYU3dUWjJBdUlG?=
 =?utf-8?B?OWVYYVZ3bDlMMDcvNGJHUHFtL2NhUUQ1ZmNkQytZYkZRdVloaU9Dbzl2S01X?=
 =?utf-8?B?WW52bjN4UlJvUlRzQ3ZVeWNXT1BWMklWaHVJVlZ6VmlmdW04Y3lQcmxWUzM5?=
 =?utf-8?B?Qmh4NXNmdFQ1d2cySnpMWDdURjc4aG9BZnppK0lDUlFXK2FOM2hhaC8vZDNx?=
 =?utf-8?B?OWhwOTJYOC9PanZsSWNQTlY3THQ2cTlIeTE0cDBudUVOQ0F4T2tVM3o3bDdy?=
 =?utf-8?B?TG9YRUxjczE1cmVWaXdIM3VwYk5CNjlscXFIUXpPcENEeGhsbTFHS2s4WWpR?=
 =?utf-8?B?TGJBYS9VZHVzcStpdlJCTm9Gek1ud2JQMkRNOGFuWGJKRlZZYU1ab0x6ZkxX?=
 =?utf-8?B?ZG9YaFBNRk85ak5MOHlNV0haRVVJWmljdkluM0VaR2RheUQ3VzNER3MvSXhv?=
 =?utf-8?B?RmV1Y1hTRy92Wk9VTlU4L0V3Z3BKa1VHd3pHbHFwK3FTcVF4aFQyaXh0czRK?=
 =?utf-8?B?RHJlVFVtc3JhQmxNMWgxQ0RXOGhmRE9VdnczM3BPcit3anBGNHVaL2VoQjdw?=
 =?utf-8?B?YjZBQVNoWG5xS0x1VWF2WkFMbWlSQ3o0R1hlenprM1lDTGlWVzFLaWxjZ2R2?=
 =?utf-8?B?ZXZFQlh2RWdaTEVkbEE4WUwwdnZPWllWaDF6NnhHTXozeXRMZWFiM0VVT1NW?=
 =?utf-8?B?VDVxSlcrOXpsM2xNTTkxL1lnVVN2dVRLVGNtQUJDU1ZxNFdLa3VUZXN3OWRN?=
 =?utf-8?B?SE0rUGc2dXE5MndxK2x5YURFOVlGVTNjeXBaNzZiNWFRRlpBblF2QUo2ZmNQ?=
 =?utf-8?B?ODFKSlBXUzlOdDNWOGNHRjBlbDlDemZncWwrUEJpMGlnbVFMR0dzWlVIVk9p?=
 =?utf-8?B?eHFDMjRXaDhwT1I2LzdHWWFQN3o1R3Q2VUdwVnRmVTlabFB0bWoyUytYd29v?=
 =?utf-8?B?eVB6SUhFdE1KSHlQbHRwcnh1K3ZPN1RKUGFlNXowcUVhYnU3dG03a1puZ3FP?=
 =?utf-8?B?djlMOW9odnhrWW0zVmM1dEJJOFpYb0NCYWU1U01TQlBoNTNZeCs1dGFsNGxz?=
 =?utf-8?B?L1NqOU9OWUcvSXpibnpKdUNablYvT0ZRT0haTnN2alRFOXM4SHpIY2NEc0x3?=
 =?utf-8?B?b0NITEpiYnBCbVRTd3hiNm5ZUVRDVFRUdVZ6WngzcS80cmx4ckplN1BjOXhV?=
 =?utf-8?B?bExRakwvRFBGYzkrdTlHVCtyQXR0MTlZaExheWc5WWNnWHduL0xNQVo4R2Zi?=
 =?utf-8?B?K3JLRitoUldIUXNWenJNY3J4eHlwc1lic2xETUFubVpMc1NWczNZRFhRTzFQ?=
 =?utf-8?B?SDFvZGJrMHhWdy9XMTFHQW1yNVNWWWdIemdTdDZFUEd5cGtoTmo4T01VNksv?=
 =?utf-8?B?S3ppRXJvc1lEaTlUWU1WdldPWWRVY3dMQzF1TXRVZVVFcFNyb09ITms4amg2?=
 =?utf-8?B?dTEyWktzYU9RdmNoTEdDaTF5anM3aTd4R25ybUNsZVZjM3ZieEF1TlFLbU1U?=
 =?utf-8?B?aGg2aDU2emQrOHMxdnNSa040YUNQUWxPWUVRWU15RmhQZ0RzaWhvUndobVda?=
 =?utf-8?B?MHpvRktPOEo1T2lzYVJ5V1Y0WkFoNzRzY0dHdms4RTU1S281VkgrOXhyOFUr?=
 =?utf-8?Q?CkEdcDAn+VcdYTI+oh2miD//xrLZ9k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdlMFBPQ1J3WWpQdnVwM1RCWjdnNEJ3bGpra0txQnFDRiszWFZ3UW1la2hO?=
 =?utf-8?B?azBsT0lpOENCNFEyQnVCNmNGK0syNWQzU1Joc3BGMHlrZUIxcnZYYXdsL0NN?=
 =?utf-8?B?QnV5YlplMUNIelBTQkxlNEgvMGd3ZVpiZGVKK09YUm1XUXVsOWVZVWR6d2Vk?=
 =?utf-8?B?aGl2bjJjaURycnd6Q2t1M052eVZpZDJ1c05tdEpjcVBXeWtKU3Ntay8zbHNo?=
 =?utf-8?B?MFI3MWZmSG1sK0piM3RKZGUwV1pDY0VhT043ZG9icmtKVHJQUzZMTFY3dXJ1?=
 =?utf-8?B?czRtVXFLT3hIRGIvOFY4WVl0WHF6Zk05TkZsOW9KZ3FFaVc1N1RLQU9kTWd3?=
 =?utf-8?B?Z25CUEhzc2xlRzVMWkphMEJXUXVNaFlTdnBYUXVPMm13cHZCa25XaytkeElY?=
 =?utf-8?B?cEdQeS9MV2ZQNEpvTlNHVTBKK0pUUlA4bUo1cFB6TFJFU1FqcUhsVmttNTZr?=
 =?utf-8?B?K2hwT2MrSW80UmYxTkJ2bXZBTExEcWJnS05lR3d5UDcvWmQ5azVWYkhIWGVj?=
 =?utf-8?B?MGtwaWMrSHBNdG11Z1l2S1Z5dDRZWmhKUUJTUTRRU1dydktYVUQ1Q2NHdEFq?=
 =?utf-8?B?ZUNLY05aN01Pbng5UXBlbGFET3N4U01uUkE5Wm9ERFZRSFp0OFp5QnczL09W?=
 =?utf-8?B?L3V4YTdycVBoemhQZGk3cFkzYVJQakgrRG5mdkhyUTlRUVQzUjVudk1OOHI5?=
 =?utf-8?B?dE9XbDlLQlJPdGliMWh2aXpRK28ycG9hSXJPajBqckI1a0g2WGg5NW55bnpB?=
 =?utf-8?B?OWJEZVRBMjFZTUVNaVNTeUw3SmhsanNjaG9BNDdTYzRtWXFReEVkSFlRZXlF?=
 =?utf-8?B?dlNGUmd6VFJIaDI1LzA1Lzc2d0pmV3FXUzZoN1Y5N3VIY0c1VFhCc3Z4aVUz?=
 =?utf-8?B?a0YxN1RqazZza0d0UHkvbDhSVXgwZlFmRWJ5MStRNmtsOWE1SWpmVk1teEtw?=
 =?utf-8?B?OEhYK3NoTGMxK3diUG5INVlDSjRpSy96OVRZL2FvZ2RBTHJlVFhscGlmaFd6?=
 =?utf-8?B?K2h2M3dlcHlvei9Sb0tKb1o2UXZRRlRrTHczL2d6VGVZcUg3bzZSSmIxVldu?=
 =?utf-8?B?eGJqQ1VwWjdqMmt2YjV2L2JJeXVCQ21IMVhPcy9DOVhoVy96bUZVcER6Wi8w?=
 =?utf-8?B?OEF6T2FzVEVMZzVqMTBJNGZiL0FnN2E1M2c2ekdyRUcrRlVCMEVaanRiNnl3?=
 =?utf-8?B?azduUDg5TEJZQmtuM3lVSHJYN0ZLQk93V3dSek1wU285eHI0Ry9uR2RoWmFt?=
 =?utf-8?B?N0NHZ0VvcXFpQkpHVnU0UnNqd1ZvcEs3d2hXc2U1YThBQ0ZNSmhSZDdhU0xn?=
 =?utf-8?B?VTJkQ3hYL3Uza3JDRnFQc25lRjlaL0Y5Y245bVI2Vm96anYxci9wc09jeG5Q?=
 =?utf-8?B?dUQ2VmhyNUd4L0JSMURmajM0QndPRExZYmQyVkhEdElqUGY5cTRiME1XSXIx?=
 =?utf-8?B?N0ZveThvT29XZDBqdUZTR3BuMk1DeFZ6OFRrSkZ0TzVUeVdlOUdoTGNLOEJ1?=
 =?utf-8?B?bFRkQlkzSnkwRFlBOXFOZmovTGxNK1pFdkhrVWJHT2hwc3dnU0JiTmphVGZr?=
 =?utf-8?B?NTNxb1ZaTmhDQ2tTUGQ0RzYyNDl0d3lKYzZMM1YvTHVBNUl5NUNlWDJwWGhZ?=
 =?utf-8?B?TXJMd1k4L0RSbWswc24yVGFwNTZ4UWMrL29CK2wyc3JjaXI0ekxPc0x0QTB0?=
 =?utf-8?B?aDRscnBnQmc1ekdrSDBHVnBPNVV5RUJYNXl3bUtCVXM1dFJRWjZsQmZ6MEdM?=
 =?utf-8?B?UEFmMHpKd1BXRzV4THVPeVUrYmhPbFF5MGw1STBlcUdNSGFZc1MxYUxhcEJu?=
 =?utf-8?B?N2VhRHpRdFpQRWR5dFZqUjdDcHJyc3l3V09ERTVPYTNwNGhBRzlEZW9qazVF?=
 =?utf-8?B?cUlQWE9MckRSTkthT21TaGluUithaUJ6WEFGQ2c5L3pPb0l1b2EyeDF3eSsr?=
 =?utf-8?B?S3BXcTVjdmZDbTFKeHB0V0JnTXQvLzhMSlYwdTYvUUZnbS9rNktWd1hVdEE4?=
 =?utf-8?B?aDRPc25vK1Rhc2IrTFoyTEloaGRWUDd3eHI4TFhwSGpaSTByVkxQS25rNHpi?=
 =?utf-8?B?VjM5cndrMnIwc3BPNkR4ekxjb3V5dldZRlRrbC9VSG5JSXc5WjFMVHVPM0Vq?=
 =?utf-8?B?RXVnSWlOK2kvczNMdHVhbE1PMVl1Y0QwYWxBclZIbitkTFpOOWF2UHhnR2ty?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532d4d75-5480-4b42-b16a-08dd703dbf44
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 10:21:06.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXyoG2SlbNrxfpzidF2HLWqURB0YgnU2VmQoDGl7rVTnWMUuDzoktdsYPug+lXwUHggkx0hYPNefXXW6P2wHk2sqk8aVV2SUXMqSKH+ulH4YoGmbdOeAjX1vGs9TreK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6158
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2FuZyBMaWFuZyA8d2Fu
Z2xpYW5nNzRAaHVhd2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCAyNCBNYXJjaCAyMDI1IDU6MDAN
Cj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRA
aW50ZWwuY29tPjsgQmVyZywNCj4gSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPjsg
Z2FuamllMTgyQGdtYWlsLmNvbTsgR3J1bWJhY2gsDQo+IEVtbWFudWVsIDxlbW1hbnVlbC5ncnVt
YmFjaEBpbnRlbC5jb20+OyBTdGVybiwgQXZyYWhhbQ0KPiA8YXZyYWhhbS5zdGVybkBpbnRlbC5j
b20+DQo+IENjOiB5dWVoYWliaW5nQGh1YXdlaS5jb207IHpoYW5nY2hhbmd6aG9uZ0BodWF3ZWku
Y29tOw0KPiB3YW5nbGlhbmc3NEBodWF3ZWkuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRD
SCB3aXJlbGVzc10gd2lmaTogaXdsd2lmaTo6IGZpeCBzcGVsbGluZyBlcnJvcnMNCk5vIG5lZWQg
Zm9yIDIgOjogaGVyZQ0KDQo+IA0KPiBGaXggc29tZSBzcGVsbGluZyBlcnJvcnMgaW4gY29tbWVu
dHM6DQo+ICAtIGNvbmZpZ3VyYWl0b24gLT4gY29uZmlndXJhdGlvbg0KPiAgLSBub3RpZmljYWl0
b24gLT4gbm90aWZpY2F0aW9uDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+IA0KPiAN
Cg0K

