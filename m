Return-Path: <linux-wireless+bounces-24935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2AAFC9FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4591BC346E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C851283C82;
	Tue,  8 Jul 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS7Xce2w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C997221FC9
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976072; cv=fail; b=e+QwjUdu2dUpG8o5IWGe/YjLmgThvJDp/2634xJArfA0g+aL6x6TyNNhio8ij+lXiEKlF+N2iq7n83ve10okgRuNnh6nDgNq5KxYq2zADb3+3NttYpOrpTMoRY5eyrGVhl+lgLLX3O4a6smbAmQwFkEBs7X870m+ko5uknsoXoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976072; c=relaxed/simple;
	bh=xajQp9ybzdffZu7t4x+ji1++AyPtsNJJsaTiIiFICRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gczJIKDa5FdyL8qidUenAHOarug76CqRGKZ5m46pJH/8CRiobhi37xlH4u1eQNPdDJAyT4rcmaS8HbVMFl9Pxu1jRpU6CEZ+e+InFFxHSDV/dE/ToHAPBlbcoSaMWHWJ4z5uRvOM4PTNu8gxi52rUVy5g4NytoNGEKmb3TuCEcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS7Xce2w; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751976070; x=1783512070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xajQp9ybzdffZu7t4x+ji1++AyPtsNJJsaTiIiFICRM=;
  b=LS7Xce2wluBkCg6Q4u4qansA+/ZKRsKQ/IqsPS8Fo1XBIfT5J0+NRtkA
   RgqQQTRDgY7P9JO1psVyC8UgsAUWpivXggjD233OmPabAfiv5tE6+lYOy
   xmGVIklauqRX6oJxYEK+hmEuXbAbD0PxlQ3Racc9GhOHq2cZyUuyZj03v
   K1QUksphoB/Y2j7s9lt7gBpCTPiyRUzRaVdwZpnBLgRSYzjn/9sh1gUWS
   uy/iPnR2ClQxAK/5GsGlZg4SCmxBNpRWnUXIUFwg0A+zTA+JJMHjsscCg
   G5zapWu7015fnVOActmOivTV08ukqlIjKCoc/m7quVocLkmfqihQN8Yd6
   A==;
X-CSE-ConnectionGUID: VpBtDb+oSpyJgNygFn5mHQ==
X-CSE-MsgGUID: lzkP6HbQS7ejrvvXISrxQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53418851"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="53418851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:01:08 -0700
X-CSE-ConnectionGUID: pBX6pyM+Ql+HgiRITtATxA==
X-CSE-MsgGUID: I1PdvXmXToilRig8MuEEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155218799"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:01:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:01:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:01:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnGyWDCXnH2mr9ZrpBYZOQXGGLU/I3BwJYhH6WTaX6IrGNp4jA4Lr2UB2Uf9cXtHrI7bXT0mbrlH476Sk2cQv/SE1pLUR+etFuCOJjuBd8hWjWZ3WjlFxTfKkvpjCzquZX0z9gfF+SV2HgmaB06NQeOlryiXYAR2qy1LBhb46Y92CjBgAQx4KbtP602+2h0YQrINCLSCeiDuksK/bfZpg19qFdZAxQzI2hMT5vaqVnYLG3P0FdxHykM5ECjctWhlOT/n0xaZu9+roCRgsHJn9xe1PhFQCC5qdzrJSmaG2asI+ORcbfiwgzyGDBkEf9v9e4NnGL0t5YwZ4I96ZaUFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xajQp9ybzdffZu7t4x+ji1++AyPtsNJJsaTiIiFICRM=;
 b=Xj3FqvnkeNMqTpRHTrkF+GeTlFCD2iHXbze2Hwy85MGgqiqi1jpd+P1fKeuUqdc+J8gYnAiIjihfXGM78ZJISjjUzfbYJ8Kkl6Eu8/n/ZYCJJXTYPDlaYD4aHmxI+LLvjwJsouyCcbgVy0YZr4qBQDxO6KuTJ0wcVdBt18TtHEbP7sE7MqrZUSSNn1jLv4fUZab99q735lydFnakd3bN3aqe1UdBBzWFJMhlVPyppjTR10YXg0b74cHIljMAsaa11+xFDuu6SV9u+5NrmobXvDYi8mwNXpduQNfdAhDz9paV17BvXYePZl/ZClI++aCSmJU2+s9cucSpp9imbSJ+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 12:00:21 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:00:21 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
Thread-Topic: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
Thread-Index: AQHb48SdjpmBjSQ3gUKiLcOKc//j87QVaSNRgBLEOIA=
Date: Tue, 8 Jul 2025 12:00:21 +0000
Message-ID: <SJ1PR11MB625216838B22D946DC359C74F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-2-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002839_326397_7F85850C)
 <e39611e7990541138e7d82809fee924433274912.camel@sipsolutions.net>
In-Reply-To: <e39611e7990541138e7d82809fee924433274912.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|MN2PR11MB4599:EE_
x-ms-office365-filtering-correlation-id: ff504772-375a-42cc-dbf5-08ddbe1703c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGFONGduWmdhRks4ZVhRaTYyWjVqdDJUejBjRDQvaFhRMkxrZ0hWTjBWbFdH?=
 =?utf-8?B?S1ZoWUFIK1dXd3grbTVPencwNFpsTGhQR3dmUUprV255bFk5ZFg5WnVMai83?=
 =?utf-8?B?NGFqNHpRbXBvcXRkRUZnSzVmUDl1TnlZV2lsTUM4eThPOWUyRE1vLzlKVnlL?=
 =?utf-8?B?VGhraGsyTklQR1liMFZGZzZUSnV1ZHFkQVJzRVdGVTNnOUwrZ3psS1ZYd3JD?=
 =?utf-8?B?Wkl0MXVsWnNrcXZDWHowZmszOVpUSlpuTzVLeFVqZ2s1ODBhZGU1U1RnQS85?=
 =?utf-8?B?L3J6SC9JREE5YVpnR0JteWJHSDh3TUVvRUZFOENZYUNWMWIxVjF3ZUovSmQ3?=
 =?utf-8?B?SmxlRjFYQlFtNFRvNXBDdlBTVDJxak9Fbm5EWHFoSnNFOTA5ajIzK2hwYmtC?=
 =?utf-8?B?Yko3RVExY0hUbkJkcTlpaFloL1VQUjFWK0l4Q1ZIaGkyb3M0aE01WEJYdkdm?=
 =?utf-8?B?WWcyOXBCVGo5RVo3QXNzaTZlSVRKRUoyeU5tTGtmYmhORGNQeFJtTENYeGpE?=
 =?utf-8?B?OEZ0LzZ4akxFSnVoa3p5eklheGxnSkpweGNhaW0yVGdveUsxZFo0QmtyZEZ3?=
 =?utf-8?B?bU1BeVJzK2ZBd2hOU2pISnFWeXVuSGcySC9ZWTZtengxNExCR3ZiSUdNd0hh?=
 =?utf-8?B?UWJGcGRxa0hIdENXcnZtRWRPd1ZBMkRBVjNITE1lajB1dXJJQXR5ZFoyUU51?=
 =?utf-8?B?ZDBDVWw1S1pMMm9BMCszQVI1YUJrQmQwNGZNajJuVDEyY0VlN0twellCdVYv?=
 =?utf-8?B?Y2x4NTJEQ0xoL0VpOTBaMGhRY3hvN056Q3ZJWXNBQ21XcFZibmp4dTNuMFhN?=
 =?utf-8?B?TmJaV2t4bnZaQXFJbm5kYWtucVJ1bzR2aEZWWVVUK1paOG8wWXc5T29qbWgx?=
 =?utf-8?B?NHVPVmZQNXRmZ2kwVC9yVmNOcHRLbVMySTJuSjc3K29neGhKRStveXhNUCtY?=
 =?utf-8?B?YXo4ckFxQjg5cDdVZjd3c3BjR3V2ZEhPdXl6bThzLzBPVlFiVGlXK2xmZkNk?=
 =?utf-8?B?Tm9IOVl5V2QvSURVd2d1UHVyNXhERCt2TTg0ZjRHbzk4WkU1WWkycjM0RzFT?=
 =?utf-8?B?b0pJMjBPaEZqZ2tyUUxsYlpRZUtmcTdsOXF2Q1I5L0ZEZ2NmbmIrV2ZVOG1k?=
 =?utf-8?B?Nnp3S3QvN2VzRUVjS0wxRldyTDgrd0JHSTE2Sk5VZER2SGdXcUIyK1ZwSTh2?=
 =?utf-8?B?VWZmQ1M2YjQ3dkdBUWZIekREbjRLS1pQMnNMTHhnQ2RoMlBjdUUzRzRXN2U4?=
 =?utf-8?B?blJtTHl4ck5FcDNkdzlaY3ZNUWpuSjZORWs3V29YL0pnUXlmeVUwaEdJNHJt?=
 =?utf-8?B?aGVBWkREemZ1MmRseTM4bnp6aWdMSHV5dTFaTklaVTdzdHU2NVVad1FnNGVU?=
 =?utf-8?B?TU5IcXc2cVlIQ1YzTUh4bmpYWkU4L1lTMWx5YzhTRlRibk9PR013cTV2ZjhT?=
 =?utf-8?B?TXA5ckdNdGRwMHBnSHBhczRYU2xVbnVsVWQ2UkJOdnY3R1E1Q1lJM0RKT0RR?=
 =?utf-8?B?MnBuclVsSFByWlN0V01XYlJRdHI4Z21hQ2RDWTQ0aG1jTll4U2xKYjNHd0Rh?=
 =?utf-8?B?NTlublc1ajAwczkvRkoyU3N1V29wOTBxNlNHN3dvZkxIT2o4Y0JSc1YwbFZ5?=
 =?utf-8?B?MFYrVlM1cWZxQ0NMQXB5b3lSdW04UGJSaFNsMVFzbHhqZ2taWnoxam5JdVhm?=
 =?utf-8?B?SDNmeGlyMFZIL2dvY1pyWXBCNXE0S1pLTEp6akxqTkNaV3JTMW1TN1NxZXJp?=
 =?utf-8?B?cjQ2ZGdiSm5FVksyWE0zbmZrbmJianVpeFpRcGlkSi9CUllFV0hGVldMcTV4?=
 =?utf-8?B?Z3Y0U2hBMjJNd0ViSjh0ekQ2M3VJZGdFclQ5V1hEMnpZckpwRm9iVjVQZ0R0?=
 =?utf-8?B?M3BoTXYvT21CVEFkUzAvV3Y2YW9OOG1mY0NBUFV5akpxZkJGSHY4QWRVRFpz?=
 =?utf-8?B?VUdTa1Mzd0dOOTYyOC9lc0VRa3YwRWtzdWlVTWxrdTFCM3I2cFZhcU55S0Ux?=
 =?utf-8?B?SlBKd2FMOEhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpIclowWjNzZUs5N1gvdms0TFczdHhtMXlOTkVqekh4ZnZGQ3hIQ0k1L2RJ?=
 =?utf-8?B?T09oMkc1cTdqOFM5RndrcHdMUWt1ZExUN05Jc2Z5aFBwUFcrOURPemh0Qkx3?=
 =?utf-8?B?NURDSytnbjRyQmZLNkQ4bWd5WE0weS9ZTEFqRGtYMkdPR3dtTmk1YStScTB5?=
 =?utf-8?B?SlZwLzBreHJ1Z3VqMkVwOURVS2VHYVg3ZWY1dXVOQTZCR0RFVDhpK3hxR3Bv?=
 =?utf-8?B?VzgyYzA1S2Z6bnJuQ0NUTXlvOEw1WUFQM0syd1M5aFhHd3NXVktGbEpQMS9P?=
 =?utf-8?B?aUp5Szl0WFdBakZkVzh3UHlEQVNGaHFsNDZRQ2ozRVE0bVpFZ3JGSjI5L3N6?=
 =?utf-8?B?Sm1qZk1GdW9uWFYrVDk4eERXV2d2U0NCUWdxWklwbjgybUluZVRkcm03UUZK?=
 =?utf-8?B?ZUxCbGMxeWpob1NpWmdVenRGZUN6MmtHV2Q1dEJSYWx3cS9QTlNyMzVyQWxn?=
 =?utf-8?B?Mm5LbmZ0T1FSTm01Ykc1OU9raTNZZ2F1VENSaEFGY3R2MFhtRnBSY0RKb1hW?=
 =?utf-8?B?TVEwZ280UlFpU01oeVRqbGZBMDBtb0RKYytzZjhENVRweE53c2RVMDhOZmhX?=
 =?utf-8?B?Zlk0QkFvUDNMTGpxZC84c29Sd3ZqUlhGNjMxNWt0RXowaGpJQVkyN0tuelVl?=
 =?utf-8?B?ZlpVbzBpYmtFNTUxbVp1MkdxQW9NV21JQjNXNjdVMzlDeFBIaHJRVm0zakdC?=
 =?utf-8?B?bUlQK3VIYVFlWHg1R1UxV1NPRHQvUm51SFdoR2pBRjZHMng0TnFpcEZ5Ni9m?=
 =?utf-8?B?VEs0Z1c0N0pZUVJueldDVEs2Y2laNXRHQmVubE9Oa25xbzZPRmtQVnVzTk42?=
 =?utf-8?B?WUxQSUhtS0VQSmk3SHdNZmxwbnI4VmZPcWpDOHhjR01rVGRJZzJibGwvbUNj?=
 =?utf-8?B?U1R5UjNPMVZRVVRDT3dRelcrTlVBeDNQQUsyU2J2TG5vbHJrTDZ4dVBuSG1M?=
 =?utf-8?B?Umg1VlE3T0l5NFk1YVloSTVyU1l6azVPUjlyY1BTRlQ4SGYrV3NPbTMydkkr?=
 =?utf-8?B?b3RpR3FXTGZtUGVpSmpjRFlTMnoxc2Z1c1YrNXU1YTVuVXVzdjhsVGdMZjRB?=
 =?utf-8?B?Tmw3SjgvMGVvNnBXOFYxUk5PNElLRTR1L0dxdW1VQlpXZW1zU1BQYlhaZDRX?=
 =?utf-8?B?QmNYUkVvUTgzQURHZTB4TE1YQms4YmpGUlN5alpGUktFRmRvVjVMSXdFSUZU?=
 =?utf-8?B?b241ZlFyU2t3YXo5SUJqT1U0YjE2RHJOcE9JUjN4Mlh0NlY3a2Q0NFhCdjBa?=
 =?utf-8?B?NEdSQ2hqNEp5SEhMSjJRMEJCS0NvS2NhSjVJVlBMekl2TlhPYmNSQTJFMVVJ?=
 =?utf-8?B?a3ZjdytlSjZGSmpRMW9XdEFaMXhxd29RZmJnU2lMS281bmlDcHB1MzMrT3Jw?=
 =?utf-8?B?ZmpQbktFZlpmc0duNFZaR29hZUQzTDhEVXVjTjhPN1RCSFNKTkR2NTFlNnEx?=
 =?utf-8?B?cjlybk8yRGFiWFNTbVJmbnlzNnUxWDlzWHQraml3SmRMdnJxeWtDV05SdGtD?=
 =?utf-8?B?MkF4ZHNoVGQ0OWdnVjQrVzRhY2lWdTI4OE52OUJZa0JqcnJHUHNOWDRNOGhk?=
 =?utf-8?B?emlFOE9rbWNyME95UlFNTEEwckJsRytZSWQ2bXQwOUgxVWhCUk11bUlkNGNl?=
 =?utf-8?B?NFNFa3NOcWcrc0JVaVBvRFZxZlRFdE03ZVhFZ2duM1g3bDFQeWw1VjNvbnFw?=
 =?utf-8?B?d3AxdnJuNnhRMTBhdTQxOW1HWk1DeU85bWExTFNYL2hyTnBCS3hqV0ppdnlU?=
 =?utf-8?B?bzMzNmVDN2NIOUt4bnRxOHFiRXJlUWRwRzZ3V1BSNEY1WG4zajc1VGd3YlBS?=
 =?utf-8?B?ci8rNjhxR3VLMTNJNDJNc3V0QndKMWNJVGtoamc3bVgrVlN5K3orcVE1ZHdH?=
 =?utf-8?B?VVFrbGg4S1UrTkVMTnRxTkpOYXlpcWRNR2h4RUlrVmQ3aVhvTkRmUTlycS8z?=
 =?utf-8?B?LzBBVXRYVGpkWFk0UzhMYXZEeC9hU1lobGZPN3k5dFdUNlF3Vm80a2RLZk5N?=
 =?utf-8?B?dTVxOEljNC83Y1ZUNjQ2Sy8zMGNmVnYvRHl4dnR6OUJFRExEa2g0Q1c0cVFo?=
 =?utf-8?B?MTFnaHJWZS9BUUhnUFZmVkNEZmIyQTUwbWwyRTMrQ040TTdReVBkQ1kwcHJm?=
 =?utf-8?B?VFNreEsrOGNPeHRDUXJhbWwvU0RhU2FvMEIxZnJsUkJVVDE4VHRpZU5GVDB4?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff504772-375a-42cc-dbf5-08ddbe1703c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 12:00:21.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6/UesNV9Zlr1qybmoP8atRDzFGbEIT6FlTKsjurxws8tuVG8+Eqq341p4Objsh2EXbBiY449U8zZ1nqjZmKDtJvS9I4sWfQui40Lv5yxGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com

PiA+ICsgKiBAcnNzaV9jbG9zZTogUlNTSSBjbG9zZSB0aHJlc2hvbGQgdXNlZCBmb3IgTkFOIG1h
c3RlciBzZWxlY3Rpb24uIElmIG5vdA0KPiA+ICsgKglzcGVjaWZpZWQgKHNldCB0byAwKSwgZGVm
YXVsdCBkZXZpY2UgdmFsdWUgaXMgdXNlZC4gVGhlIHZhbHVlIHNob3VsZA0KPiA+ICsgKgliZSBn
cmVhdGVyIHRoYW4gLTYwIGRCbSAodW5zaWduZWQpLg0KPiA+ICsgKiBAcnNzaV9taWRkbGU6IFJT
U0kgbWlkZGxlIHRocmVzaG9sZCB1c2VkIGZvciBOQU4gbWFzdGVyIHNlbGVjdGlvbi4gSWYNCj4g
bm90DQo+ID4gKyAqCXNwZWNpZmllZCAoc2V0IHRvIDApLCBkZWZhdWx0IGRldmljZSB2YWx1ZSBp
cyB1c2VkLiBUaGUgdmFsdWUgc2hvdWxkIGJlDQo+ID4gKyAqCWdyZWF0ZXIgdGhhbiAtNzUgZEJt
IGFuZCBsZXNzIHRoYW4gcnNzaV9jbG9zZS4NCj4gDQo+IEkgdGhpbmsgdGhlc2UgYXJlIG5vdCBk
ZXNjcmliZWQgd2VsbCwgYW5kIEkgYWxzbyBkb24ndCB1bmRlcnN0YW5kIHdoeSB3ZQ0KPiBzaG91
bGRuJ3QgdXNlIG5lZ2F0aXZlIHZhbHVlcyBpbiB0aGUgQVBJcz8gSSBrbm93IHRoZSBpd2x3aWZp
IGZpcm13YXJlIGRvZXNuJ3QNCj4gbGlrZSB0byBkbyBpdCwgYnV0IHRoYXQncyBub3QgYSBnb29k
IHJlYXNvbiBub3QgdG8gZG8gaXQgaW4gb3RoZXIgcGxhY2VzPw0KDQpTdXJlLiBXaWxsIG1ha2Ug
aXQgc2lnbmVkLg0KDQo+IA0KPiA+ICsJc3RydWN0IGNmZzgwMjExX25hbl9iYW5kX2NvbmZpZyBs
b3dfYmFuZF9jZmc7DQo+ID4gKwlzdHJ1Y3QgY2ZnODAyMTFfbmFuX2JhbmRfY29uZmlnIGhpZ2hf
YmFuZF9jZmc7DQo+ID4gKwlib29sIGVuYWJsZV9oYl9zY2FuOw0KPiANCj4gV2hlbiB3ZSBoYXZl
ICJuYW5fc3VwcG9ydGVkX2JhbmRzIiwgaXQgc2VlbXMgdG8gbWUgdGhlc2Ugc2hvdWxkIHJlYWxs
eSBiZQ0KPiBieSBhcmJpdHJhcnkgYmFuZCwgYW5kIGJpdG1hcCBvZiBiYW5kcyB0byBlbmFibGUg
c2NhbiBvbiwgb3Igc29tZXRoaW5nIGxpa2UNCj4gdGhhdCAuLi4gYWxzbyB0aGlzIHJlYWxseSBh
cHBsaWVzIHRvIHRoZSBubDgwMjExIEFQSS4NCg0KTkFOIHN5bmNocm9uaXphdGlvbiBpcyBvbmx5
IGRlZmluZWQgZm9yIDIuNCBhbmQgNSBHSFogYmFuZHMuDQpOb3csICJiYW5kcyIgKHN1cHBvcnRl
ZCBiYW5kcykgZmllbGQgZXhpc3RlZCBiZWZvcmUsIGFuZCBJIGRpZG4ndCB3YW50IHRvIGNoYW5n
ZSBpdC4NCkhhdmluZyBhbiBhcnJheSBvZiBiYW5kX2NvbmZpZ3MgaW1obyBsb29rcyBvdmVya2ls
bC4NClJlZ2FyZGluZyBlbmFibGVfaGJfc2NhbiAoaWYgdGhpcyBjb21tZW50IHJlZmVycyB0byB0
aGlzIGZpZWxkKSwNCml0IGNhbid0IGJlIGZvciAiYXJiaXRyYXJ5IiBiYW5kLCBhcyBkaXNhYmxp
bmcgc2Nhbm5pbmcgb24gMi40R0h6IGlzIG5vdCBhbGxvd2VkLg0KDQo+IA0KPiA+ICsJdTggKmV4
dHJhX25hbl9hdHRyczsNCj4gPiArCXU4ICp2ZW5kb3JfZWxlbXM7DQo+IA0KPiBjb25zdCB1OCAq
LCBwcmVzdW1hYmx5DQo+IA0KPiA+ICsJc2l6ZV90IHZlbmRvcl9lbGVtc19sZW47DQo+IA0KPiBB
bHNvIG5vdCBzdXJlIEkgc2VlIGEgbmVlZCBmb3Igc2l6ZV90IGhlcmUsIGl0J3MgY2VydGFpbmx5
IGdvaW5nIHRvIGJlIGxpbWl0ZWQgdG8gYQ0KPiBuZXRsaW5rIGF0dHJpYnV0ZSAodTE2PykgYW55
d2F5Pw0KDQpXaWxsIGNoYW5nZSB0byB1MTYNCj4gDQo+ID4gKyAqIEBOTDgwMjExX05BTl9CQU5E
X0NPTkZfQ0hBTjogRGlzY292ZXJ5IGNoYW5uZWwuDQo+IA0KPiA+IElnbm9yZWQgb24gMi40R0h6
IGJhbmQuDQo+IA0KPiBTaG91bGRuJ3QgYmUgaWdub3JlZC4gRWl0aGVyIHJlcXVpcmUgYSBjb3Jy
ZWN0IHZhbHVlLCBvciByZWplY3QgdGhlIHByZXNlbmNlIG9mDQo+IHRoZSBhdHRyaWJ1dGUuDQoN
Ck9rLg0KDQo+IA0KPiA+ICsgKglFaXRoZXIgNDQgb3IgMTQ5IGZvciA1IEdIeiBiYW5kLg0KPiAN
Cj4gV2Ugc2hvdWxkIHVzZSBmcmVxdWVuY2llcy4NCg0KT2suIEknbGwgY2hhbmdlIHRvIGZyZXEu
DQoNCj4gDQo+IEEgbG90IG9mIHRoZXNlIGFyZSBtaXNzaW5nIGRvY3MgYWJvdXQgdGhlaXIgYXR0
cmlidXRlIHR5cGUgdG9vLg0KPiANCg0KU3VyZS4gRml4ZWQNCg0KPiA+ICsgKiBATkw4MDIxMV9O
QU5fQkFORF9DT05GX1JTU0lfQ0xPU0U6IFJTU0kgY2xvc2UgZm9yIE5BTiBjbHVzdGVyDQo+IHN0
YXRlIGNoYW5nZXMuDQo+ID4gKyAqCVRoaXMgaXMgdW5zaWduZWQgOC1iaXQgdmFsdWUgaW4gZEJt
IChhYnNvbHV0ZSB2YWx1ZSkuDQo+IA0KPiBOYWgsIHNlZSBhYm92ZS4NCg0KV2lsbCBtYWtlIGl0
IHNpZ25lZA0KDQo+IA0KPiA+ICsJLyogQ2hlY2sgaWYgdGhlIGNoYW5uZWwgaXMgYWxsb3dlZCAq
Lw0KPiA+ICsJaWYgKCFjZmc4MDIxMV9yZWdfY2FuX2JlYWNvbih3aXBoeSwgJmRlZiwgTkw4MDIx
MV9JRlRZUEVfTkFOKSkNCj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IHRydWU7DQo+IA0KPiByZXR1cm4gY2ZnODAyMTFfcmVnX2Nhbl9iZWFjb24oKT8NCj4gDQoNCk9m
IGNvdXJzZSA6KQ0KDQo+ID4gKwlpZiAoIWNvbmYtPmxvd19iYW5kX2NmZy5jaGFuKSB7DQo+ID4g
KwkJLyogSWYgbm8gMkdIeiBjaGFubmVsIGlzIHNwZWNpZmllZCwgdXNlIHRoZSBkZWZhdWx0ICov
DQo+ID4gKwkJY29uZi0+bG93X2JhbmRfY2ZnLmNoYW4gPQ0KPiA+ICsJCQlpZWVlODAyMTFfZ2V0
X2NoYW5uZWwod2lwaHksIDI0MzcpOw0KPiA+ICsJCWlmICghY29uZi0+bG93X2JhbmRfY2ZnLmNo
YW4gfHwNCj4gPiArCQkJIW5sODAyMTFfdmFsaWRfbmFuX2ZyZXEod2lwaHksIDI0MzcpKQ0KPiA+
ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGNvZGUgc3R5bGUNCj4gDQoNCkZpeGVkDQoNCj4g
PiArc3RhdGljIGludCBubDgwMjExX3N0YXJ0X25hbihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgZ2VubF9pbmZvDQo+ID4gKyppbmZvKSB7DQo+ID4gKwlzdHJ1Y3QgY2ZnODAyMTFfcmVnaXN0
ZXJlZF9kZXZpY2UgKnJkZXYgPSBpbmZvLT51c2VyX3B0clswXTsNCj4gPiArCXN0cnVjdCB3aXJl
bGVzc19kZXYgKndkZXYgPSBpbmZvLT51c2VyX3B0clsxXTsNCj4gPiArCXN0cnVjdCBjZmc4MDIx
MV9uYW5fY29uZiBjb25mID0ge307DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsJdTMyIGNoYW5nZWQg
PSAwOw0KPiANCj4gd2hhdCdzIHRoYXQgJ2NoYW5nZWQnIGV2ZW4gZG9pbmc/DQoNCk5vdGhpbmcg
aGVyZS4gSXQgaXMgbmVlZGVkIG9ubHkgaW4gY2hhbmdlX2NvbmZpZygpLCBidXQgSSBzdGlsbCBu
ZWVkIHRvIHBhc3MgYSB2YWxpZCBwb2ludGVyLg0KSSdsbCBtYWtlIGl0IHN1cHBvcnQgTlVMTC4u
DQo+IA0KPiBqb2hhbm5lcw0K

