Return-Path: <linux-wireless+bounces-31657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHYsHNOUiWlj/AQAu9opvQ
	(envelope-from <linux-wireless+bounces-31657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:03:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35B10CB77
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB3DE301C14B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1033B94B;
	Mon,  9 Feb 2026 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsMtnsN8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195933122A;
	Mon,  9 Feb 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624106; cv=fail; b=AOYKZ3FktFB2Q5OBeewnHv0YktjD6iEUzubWIKKbYSIKUED8OszwaLMTwjVOEn4bsDVp12l2OFqySJ6D5sH5mqfPNC1b1AEF5V0kayb3TN+U9CByHxIc5ASoNUW6L03n2KeHLMrOEKO9o2JmeQGKxMo+BFH6pMglNiWjE99lQ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624106; c=relaxed/simple;
	bh=cLN/9tD1rKRQfvfKhhUHCmMyxaB/Vp+wIzy/vPVAR0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcmpJAMEAAfy93ahYkSKgnCuhNOhA+zqdyneWDgHDLUi4bWYhdlWh5DgSadQtxt99g+Zbz3qY7K9R+jAdnTtBJj+JAuBkTW5v7fVPaElhrJnH1h9xa+teEYOn/5WkWaITKaLnBFnGgpoaZgRz4GT4AJuAmqvIS3AN2j/yZ4U40o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsMtnsN8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770624106; x=1802160106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLN/9tD1rKRQfvfKhhUHCmMyxaB/Vp+wIzy/vPVAR0M=;
  b=SsMtnsN8uet1je1ubOTCSilIXDhWjx7oZbF8Fu5mBxTPra/Vt6CuyrgH
   a0QQJcOXCQKYbFczH7mMSTtYF6myfsvD7+mvPNmcVQ0xAxn7lMGw99JG3
   F6vLJOzOglsWAdDH9ukpyF+ABCQU0wGocP3ius+Vs0KiawRAClhCWhq92
   qieGBa7q9Iusi/BDK3ensa0arh/OHSdRMU/6A7FQDs4OzUnTaLtPMwJDe
   A5h9RmGt/8Dd20Agnx7kjkGDqEO5yemu12LeFIKzjxfPbeuZzmZjqkuAU
   lyekXDKDkkjlD30Qn03itM0BOSp7m/JwXr0hPsz/7KwiFnLDb6zuHg8Nv
   Q==;
X-CSE-ConnectionGUID: 3V4HKCO0TtG/rdzlt+mlMQ==
X-CSE-MsgGUID: +vN0QkB/R4uwfbIVCMT1wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71913660"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71913660"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:01:43 -0800
X-CSE-ConnectionGUID: ppXhknlhT8mIXBfepalC8g==
X-CSE-MsgGUID: +HQgxWEuStOIeeG9LtgcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="216480362"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:01:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:01:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 00:01:42 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKm0WgEOQf16d89gxU2Pk2GiMfqx5PnssctyMYY9Mr6MXG2fxktWfYVlgHc2gy09hkLDtFjULX4CVh7HGTw4PAvzQRWfG32F8HHNmthTrUP9S7Y6VlS4XLMXhocPkljUFBsIcXV8y8d7AUYJQ+YdUrKt4Yrgao82mpfyiCl2oFJClgnDT9EZDV1ouf1rp6zHjnMD5qvH440MCBWwU7x3qN2MwI6VQiJM1uNO4kbPIwe8iLJ+LJUwav40lkZgBjdvyyZO3fxHvkAllgDKY6qQy61LUpsNHx2PpdMgLhUqn9RvbKyX6P6T7GlE7gzG7uwC48kAvQLYLshf8/smUsPHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLN/9tD1rKRQfvfKhhUHCmMyxaB/Vp+wIzy/vPVAR0M=;
 b=wuqNdkhJubDTSxU+1xRmQYGqMDrqXrYjvFxd5n2/G6N4dVLuKOsHROzRNvFJrvYcSCM4fYKhoQVs87rGTGuup6WGZxXDaWFwOe4R3QqSsNrsPSfBKxjrPPGctfF0/JgnQ3xWAR4qChC8xc3ull3Wdxd8CKwfRGs627CNF6YTH821biwizV3NumgtllOHSviBjjkPEcg8QA/bEu+Fq+MXjQsY7ZAvNHcPlBKyec8h25Lrw+AuKcbWzA47OCNG1aFSc/APkPKVAGqhv6lLCB3zQZFNccPJ6Tgk/CHvLlgW2/U80DNoQn8ui5g1rQvT2Lb4kA/lHY9mbWNqqqZrn7T0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CY8PR11MB6820.namprd11.prod.outlook.com
 (2603:10b6:930:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 08:01:37 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:01:37 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v2 2/3] wifi: iwlwifi: fw: replace use of
 system_unbound_wq with system_dfl_wq
Thread-Topic: [PATCH v2 2/3] wifi: iwlwifi: fw: replace use of
 system_unbound_wq with system_dfl_wq
Thread-Index: AQHcWgW8DLMYP47Ta0+bm/2KDWwWNrV6gITw
Date: Mon, 9 Feb 2026 08:01:37 +0000
Message-ID: <DM3PPF63A6024A9A18B15F70784E2C261A1A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251120100850.66192-1-marco.crivellari@suse.com>
 <20251120100850.66192-3-marco.crivellari@suse.com>
In-Reply-To: <20251120100850.66192-3-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CY8PR11MB6820:EE_
x-ms-office365-filtering-correlation-id: a23ed154-56e7-46a7-adf8-08de67b1735c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WVlUWmlUQWdUUHlBVmliUThiU2ZOWjBKN1gzcll3dXNDOFFNMmNETjZpU21K?=
 =?utf-8?B?aEtFbWJWdFNhU0lSTVJoMDdIVTV4cW96eDFxYm41Y1o1Ni8xVmNvdExHVTZC?=
 =?utf-8?B?M2tEaFJ0TjluRGpnS1pSa1ZvK2xFL1FmUEdRcEhLTTF1dGdGVzdqSEVjZTFG?=
 =?utf-8?B?M0E5S29wVk5wTDJ6cDUrT1BXL2ZqU2ZEY2FSNmZJRHNnUzBQQlN1T3g5ZmMy?=
 =?utf-8?B?Z0w2WGsrQndDdDlkVlRlZzZ3OE5uems3QlVPV3h6Qk5TMzZCQzB4ay9GY1lx?=
 =?utf-8?B?SVNLMHNIbWdaakJBNGY0d2xINWUwZzQzRTVzL09VelFhK3pPUkdrY09ONEs3?=
 =?utf-8?B?QzZGZGFtV3J4dTlEVlVLUjNsR3BOQ0hxM1NZZE1zcXNMcVRodllwYWx2NkFT?=
 =?utf-8?B?Zit2bWdtZzJURGVoS0RBNFgzYmwwMlFKUGg0ZS9hODhSdXR5NTdaOTlDMnVT?=
 =?utf-8?B?a3Ivb3FUMVVqN1l0b3lxNG9rZ3ZIVFlsWVR5dWlWcGhMQTZlY21lano1WVps?=
 =?utf-8?B?b0RJY2xIUmY3WktIdTBXb1o2dWpPTnpuM1E0NFk2bzdaUVFvUk5uNXN4SkZr?=
 =?utf-8?B?K2VFMnNXN0dzL3NlQXlETDhEZ1UzZkdMeFpCbmp2TjA5aGZsZVU1OFdPWmgw?=
 =?utf-8?B?MHc5ajhZa2RZbHRVbFhnaTRtT2xKWENXSUZ2ZDUzWm9NanVFQzRvTTByRnZC?=
 =?utf-8?B?MXJ1TnhabmdKZW9Hd2l2NW9IOWhuSzdYN1VwdXJSVWVIbkVaQTRlSkNiR05t?=
 =?utf-8?B?Sm9RU2pPU2JkcW1MWFgwWE5RSmZQeUt4ZG1VMEZwdS9oVnl5Rlp4YXo5dEtY?=
 =?utf-8?B?M1N0bWVoV2syL1RGUUF6eVh4bU9RcFA4dE1VbzZaR1NwbDdacC9mTXd3czZo?=
 =?utf-8?B?UGhCNjZMYTJhTnhmbVNLcnJMYTEyN1krOGZaMThnNnBsRnBaOG9jS3hMbGha?=
 =?utf-8?B?NzB5SVpLbWZ2RG1mR1oydng3aklyUTZVWExRejBDd2I4aGFWSktZSUkxYjN1?=
 =?utf-8?B?WUN3NHRoNWRQRStST1IwUlZWdy9ZVSs2MTJ2QTdRWnJJendkb1dsQjRUdGlp?=
 =?utf-8?B?SmdEejRPV1MwbW5sSkNJTzZ3elQwUHhqMEhPTHAxWkVSK3dqK3N1OVU3MVZv?=
 =?utf-8?B?bGt5S0t2cXF5bnFTSkMvTlZsYk11SGR4OGhRNDlCcUZjM0lhNnZwV2daSG5j?=
 =?utf-8?B?YTkrVFVicGs1WVVySkNXTEV6amxJVTlYK1ozYmpSYWhLMUxnZGFCclZ6b0pO?=
 =?utf-8?B?RmozSjJOZmNHckRnM0RUSTdKY2VSUStSWlU4U0orSEZwaHNhN09ZZ1BsVTBi?=
 =?utf-8?B?SUJNNXpyWWhPUzRTRVkwOGhVODhyQ0dtbnRHSndoU2c5eHFMQ1BGWmpOOEo2?=
 =?utf-8?B?d2IyYmpNckcxNHlZdHdUT2x1RGF6SmkyUFlsMVdLNzZXZjloS2JiZUlLdVFa?=
 =?utf-8?B?OFFGMmpYUHFhcGpKa1VkRzlocGxUY3FtMjVmOTgzemUwWXBSZkM4Z1NhSXZV?=
 =?utf-8?B?dlpWTU5WMWUyZVQwK1BGSDZVdS9TcWlmQ3RpK3pkcUNMV1MyZlkxL0pKMkEz?=
 =?utf-8?B?R1prNmZ4UXlhODFWZlFkN0VTcG9zWEg0NzVQOHZGMzB2Q01ZZTU2aVVoK2Zs?=
 =?utf-8?B?enZzcndvdGdqemhvT0IrTWMrZkxrcDA3bkFDWkxCdm9nVytYM2NhODQ5NFI1?=
 =?utf-8?B?ZW12QWhsd3d1QmxtOTlORXFYd2xpc2EwaTRSQ1BGempjbWdtZVI2R1JZcVNC?=
 =?utf-8?B?UFloZnExc01qMGFwU3BBalZ3MVRLVy9LU0kvZ2J0TlVLQjRoTUMyQzJCdnFj?=
 =?utf-8?B?OUI2Zi8zMnhXT0lkV2tuSG03U3dHWGtsSUQxb3BncmY4M3JUZ25yM0dHK0Zj?=
 =?utf-8?B?QWNFMERiczlrNjl2NC9lcWhxVUgwd1htMklnUHZEcTkwNWpaUytEYmJjZnlv?=
 =?utf-8?B?bHhmWFkrZ3JlN1pFRUdhZW1RQjViZWhPUmJKUkFyS1N4bmllVGl6Si9rUW5P?=
 =?utf-8?B?TjdJd1dEYlR4endVZHFJQmJpQnpjZHZ0U1VPZFFabUwyTnZjcXkyLzNSR0Vy?=
 =?utf-8?B?Z3oyVUFLaEtjVGs2KzVubDRTWC9mUnRHWDFBK3lXREM0WlZFWjZEaHhNY3A2?=
 =?utf-8?B?Y2c0amQyVXZ4SFJMMGJOTTg1eDJWSXI2TUQwQzJXZFhyRWpuN3d5UUh0bE1a?=
 =?utf-8?Q?G53EYJuR4ztjqmGPxbTH1WM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2Q0aUs4N0YrRFNLaTBTVXBSelE1VzNpVmJjTUQ4R0swWEZrSUZYOGIza0d5?=
 =?utf-8?B?eWl4UlhBUzZpK2RmTW5MQWdJMnRLcCt6dyt3UmswWVBpNTMwemp1M0ROMVZZ?=
 =?utf-8?B?WlNGR29oTHk1MHB3Z3hpMnJZVmU5dTQzOU9XaEJrTDBka2wxa2dERWJNYk43?=
 =?utf-8?B?WnJzT1hxT1ZKQytzcGJvK0lOaEZmQVRzcW9FVWRNaE9Jd1RNczdNVTZDL0NR?=
 =?utf-8?B?Y3Roa0Q2b1U4ZEZyekRMMmxRSE5ManV4WjVFbm9kRXBTcVJrcEtnN3FxQTdT?=
 =?utf-8?B?b1dGbC9OYnNKVlY4YS9nZzZrT3YxdkRYUlJKaWtscFdhKzhWNERqOTllcGhz?=
 =?utf-8?B?anVrNHBpZ2ZiU0Yxc3Z0dUtQUUhHTG8zNm12azlhM3VBbGY0eVdJQnVWSUNw?=
 =?utf-8?B?YUFLYVNkL2Y5UG45RHFyRkdWTVpreC9obEl4RVFuQis3VjF4Q2RLd0V2NHhG?=
 =?utf-8?B?WTFGelFWZkZJc3BOSGR0R3c2ckV2bFZUeEZWWXloaXJpL3BTSXQrcVloa1Z6?=
 =?utf-8?B?d05PVkRnODBQYXhxM0NzR1RNSkZnRm9remRkOC9HbVJmWkVOckhBTjdzRWRQ?=
 =?utf-8?B?L0YyOTFxNEFsSmF4eVRsUWZRM0hiNWkyS3M4L015VXJ6bkdoUG5EaTNvWjlB?=
 =?utf-8?B?LzdQYlJwWGVrMHEvQkVTU2dmcUtDTkhYWmw2UTN5WTk5OXhhcGNnMmVrUkNX?=
 =?utf-8?B?cUVGSnhIcmFUampoTWZZcEs3R2w4aEREdEIvYVhOaVF0d09xMEt2Rm5KTXBu?=
 =?utf-8?B?VGxwaGd5NlRxdDJ4MnFmbzBhcVQvSnorNDNiY2JqcEFTMDFHKzNuMTJOTEc2?=
 =?utf-8?B?QzE2Z01iS09GNWVmL3BJMUNFZCthNkIyNUtNUnljQXREU2RTK1BXSzU3aTBa?=
 =?utf-8?B?SzVZZUxieHFoV1VmRnZndVFUTmZkdG9xWHpWQkpyL1NnRjZlZWZqMHVMUU5G?=
 =?utf-8?B?bE1HODF0ZVZ6cmVhYmphbDh5cHpBdFVWSTE1YXJRZHB0SjN4bW0rcHFscTNq?=
 =?utf-8?B?UDY0ODVLdzcydzBLblcyUUY3VmVEUFpaWEVQMmFMNCt2S253TGttR0dEcm5V?=
 =?utf-8?B?UlNDcHM3cStCcnY1VmRKcjgvQkZWYUZXVkQrZEUwQWpaYWNVd3hnN0w0azFy?=
 =?utf-8?B?SXdDRHAxd0UxQjZPNmtMSmtKU0dWN0pSZllxMWZ3UDFyZVBPWlVwTm0yTHJK?=
 =?utf-8?B?OGwzQmx1b0xocEdBaHl5UWJUVThRRjFUM2djdml1R0tsWXcrLzBISTZFc3VT?=
 =?utf-8?B?TnBwd1JJZVdrUUZIK093NElwb3NBWkxmTlBTMXpNcy9LNXlTZUNIeEhHYUcz?=
 =?utf-8?B?d1BRd3lHcjlxVkpPdlBYa21uRXE1SUJwcHlJRElDcUxMYkJqZXdhTG10bEpr?=
 =?utf-8?B?MjRvTjZkaG9kMWp4Z3F4dGlqT25VTUJJTmRFT1E0NTltcjZiQk01cVNrZEEw?=
 =?utf-8?B?VjhxZlQvYyt6eGE4RnhYU21VelE0OUk0Ui9pcDZYelVDbEtoU3hGVXR3YUxK?=
 =?utf-8?B?R3VkSnN2ZCtzdzRESE5EU0dyQjM2K3M0RUN5Wm9aOG12ZDJJQy9yY0s1OTRa?=
 =?utf-8?B?NjJ4d2JHd0UrQzRSdWdUcFVFcE5kQUZkVzErVGZJLzVRQ2gwZnpyYXdwN3Av?=
 =?utf-8?B?ZmQzN214Rk1NL3QwWmZlemR5U2d2WmhYR2lwbmNid29heXduV0tnRzFZWnJn?=
 =?utf-8?B?cTAvNzFLT2JkRW1FZ1NDS0xGVjEyUUVweFZIYUh6Q0xaZHlmK1RuVmdiVHI3?=
 =?utf-8?B?SlJJbGdUc3YwTjJRdktnQWVpd1ZocWlabHNJM21KVVBBajFYWDhnK2hQRkw4?=
 =?utf-8?B?cU4rYVBnc0VRT0hjczBlMzFldDdEMkN0REt2UndvU3dsNHFWcGZJS0RoY3No?=
 =?utf-8?B?RDdSem5OVC9Eb0JWNmZYemRFcnBBWFRjdlFJeHFKTlNBNHBjWUIranZhMUZh?=
 =?utf-8?B?S1VUM3Jla0ZacnJudkg2WkM1dVZiL1VDWFhGVGpxM0ErM3VIakF0ZnpybVR2?=
 =?utf-8?B?TGI3TFZEQitGMEJoeXFYQVJTVkNvdVR3ZHl5ZDVXUlJnVmN0WEhkQ0xlZGZj?=
 =?utf-8?B?ejFOWjFwRkNlQVJvRlEwcXpMYjZsZ3lhSmRyZHl6RXNDMlRIcVZwYkNEcjND?=
 =?utf-8?B?V0hYVEsyV2t3WFpTVjlXajNMZzZFRzBhbWNkNVRYcE9EN1BVdi9UTlZQSjRm?=
 =?utf-8?B?bFVacXpPREJDWUMwaW5VMHVqK1pqbGhBZ0NaU3VoOG9yc3pSeFBCN1B5N2Vn?=
 =?utf-8?B?d21uZUkvQjZzZFhWUWRGRHhDRUJPY215QTNuNE1iYXF4TFl1SVFTYWFEL0Rq?=
 =?utf-8?B?TXAwbmNoVkRIbTlIQUhYdis1UFdNVjI0dDZpNWIvTXU0V054alh5bUNaMFVl?=
 =?utf-8?Q?sIt8+I/Bm/K5GRnA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23ed154-56e7-46a7-adf8-08de67b1735c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 08:01:37.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORjDsXN0UAOa1lklJV24N/1BQuapkf0hV/pG3DLgiQoGgpWaqc4vsQJKHQXsj0trMIXuJPKIb+VlXfK6LlNON+G6LKJ3NupK/2a72y9FfEAxq4oOyZ0hN+ztLJqIHXZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31657-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,suse.com:email,sipsolutions.net:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CD35B10CB77
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDIwLCAyMDI1IDEyOjA5IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz47IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+OyBGcmVkZXJpYw0K
PiBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvcg0KPiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgTWFyY28gQ3JpdmVsbGFyaSA8bWFyY28u
Y3JpdmVsbGFyaUBzdXNlLmNvbT47IE1pY2hhbA0KPiBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPjsg
S29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsDQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRl
bC5jb20+OyBKb2hhbm5lcyBCZXJnDQo+IDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjIgMi8zXSB3aWZpOiBpd2x3aWZpOiBmdzogcmVwbGFjZSB1c2Ugb2Yg
c3lzdGVtX3VuYm91bmRfd3ENCj4gd2l0aCBzeXN0ZW1fZGZsX3dxDQo+IA0KPiBUaGlzIHBhdGNo
IGNvbnRpbnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBBUElzLCB3aGljaCBo
YXMgYmVndW4gd2l0aA0KPiB0aGUgY2hhbmdlcyBpbnRyb2R1Y2luZyBuZXcgd29ya3F1ZXVlcyBh
bmQgYSBuZXcgYWxsb2Nfd29ya3F1ZXVlIGZsYWc6DQo+IA0KPiAgICBjb21taXQgMTI4ZWE5ZjZj
Y2ZiICgid29ya3F1ZXVlOiBBZGQgc3lzdGVtX3BlcmNwdV93cSBhbmQNCj4gc3lzdGVtX2RmbF93
cSIpDQo+ICAgIGNvbW1pdCA5MzBjMmVhNTY2YWYgKCJ3b3JrcXVldWU6IEFkZCBuZXcgV1FfUEVS
Q1BVIGZsYWciKQ0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSByZWZhY3RvcmluZyBpcyB0byBldmVu
dHVhbGx5IGFsdGVyIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG9mDQo+IHdvcmtxdWV1ZXMgdG8gYmVj
b21lIHVuYm91bmQgYnkgZGVmYXVsdCBzbyB0aGF0IHRoZWlyIHdvcmtsb2FkIHBsYWNlbWVudCBp
cw0KPiBvcHRpbWl6ZWQgYnkgdGhlIHNjaGVkdWxlci4NCj4gDQo+IEJlZm9yZSB0aGF0IHRvIGhh
cHBlbiBhZnRlciBhIGNhcmVmdWwgcmV2aWV3IGFuZCBjb252ZXJzaW9uIG9mIGVhY2ggaW5kaXZp
ZHVhbA0KPiBjYXNlLCB3b3JrcXVldWUgdXNlcnMgbXVzdCBiZSBjb252ZXJ0ZWQgdG8gdGhlIGJl
dHRlciBuYW1lZCBuZXcgd29ya3F1ZXVlcw0KPiB3aXRoIG5vIGludGVuZGVkIGJlaGF2aW91ciBj
aGFuZ2VzOg0KPiANCj4gICAgc3lzdGVtX3dxIC0+IHN5c3RlbV9wZXJjcHVfd3ENCj4gICAgc3lz
dGVtX3VuYm91bmRfd3EgLT4gc3lzdGVtX2RmbF93cQ0KPiANCj4gVGhpcyB3YXkgdGhlIG9sZCBv
YnNvbGV0ZSB3b3JrcXVldWVzIChzeXN0ZW1fd3EsIHN5c3RlbV91bmJvdW5kX3dxKSBjYW4gYmUN
Cj4gcmVtb3ZlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8g
PHRqQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNv
LmNyaXZlbGxhcmlAc3VzZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9mdy9kYmcuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2RiZy5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9mdy9kYmcuYw0KPiBpbmRleCAyY2U1NTg1OTY0MWMuLmU1ZjMxYjgyMzM5
YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9k
YmcuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2RiZy5j
DQo+IEBAIC0yOTMzLDcgKzI5MzMsNyBAQCBpbnQgaXdsX2Z3X2RiZ19jb2xsZWN0X2Rlc2Moc3Ry
dWN0IGl3bF9md19ydW50aW1lDQo+ICpmd3J0LA0KPiAgCUlXTF9XQVJOKGZ3cnQsICJDb2xsZWN0
aW5nIGRhdGE6IHRyaWdnZXIgJWQgZmlyZWQuXG4iLA0KPiAgCQkgbGUzMl90b19jcHUoZGVzYy0+
dHJpZ19kZXNjLnR5cGUpKTsNCj4gDQo+IC0JcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV91bmJv
dW5kX3dxLCAmd2tfZGF0YS0+d2ssDQo+ICsJcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV9kZmxf
d3EsICZ3a19kYXRhLT53aywNCj4gIAkJCSAgIHVzZWNzX3RvX2ppZmZpZXMoZGVsYXkpKTsNCj4g
DQo+ICAJcmV0dXJuIDA7DQo+IEBAIC0zMjM3LDcgKzMyMzcsNyBAQCBpbnQgaXdsX2Z3X2RiZ19p
bmlfY29sbGVjdChzdHJ1Y3QgaXdsX2Z3X3J1bnRpbWUNCj4gKmZ3cnQsDQo+ICAJaWYgKHN5bmMp
DQo+ICAJCWl3bF9md19kYmdfY29sbGVjdF9zeW5jKGZ3cnQsIGlkeCk7DQo+ICAJZWxzZQ0KPiAt
CQlxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX3VuYm91bmRfd3EsDQo+ICsJCXF1ZXVlX2RlbGF5
ZWRfd29yayhzeXN0ZW1fZGZsX3dxLA0KPiAgCQkJCSAgICZmd3J0LT5kdW1wLndrc1tpZHhdLndr
LA0KPiAgCQkJCSAgIHVzZWNzX3RvX2ppZmZpZXMoZGVsYXkpKTsNCj4gDQo+IC0tDQo+IDIuNTEu
MQ0KQWNrZWQtYnk6IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRl
bC5jb20+DQoNCg==

