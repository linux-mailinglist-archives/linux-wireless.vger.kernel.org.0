Return-Path: <linux-wireless+bounces-23578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB31ACCCCC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EE43A18DC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92450288C0E;
	Tue,  3 Jun 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMTAPpHj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123301D63DD;
	Tue,  3 Jun 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974936; cv=fail; b=VM9e8wXYeJKSsLNt+k997k8QtXicEngOp455raH1P+pJwC4ZYPtSuR4c556Ske9YyehcsYz2Aba3MTnb2dD/Mt9RzjJitc23XswriIQ2u8D8riBJU2bJ3nqO6WvJd0Be/nNBqpzPOLIu8duIKnv0cNJvwbpxo2AaLxflBiv5Zqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974936; c=relaxed/simple;
	bh=55kO/9ziryIJoaotALzHdFz9sTlW/obfNKchqnYM1DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBa+KD3dJPy3xzeVVaz4IZTEInS2QszxP+Ps/Iu2I2F9ac/q5QN/LDuEtGCU7M8sqRHYZFAcsTPXPAl+O3lKNxUfXbF3oJCagCYe8NdDb9s11x9Ny2FLbrrupflL6gCgLBFD/coS4lciCsdKgOZg5qu+HcK9o7+R5+4rGC0Vi0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMTAPpHj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748974935; x=1780510935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=55kO/9ziryIJoaotALzHdFz9sTlW/obfNKchqnYM1DM=;
  b=jMTAPpHjFTC3+oEt+kljaStlYtmOCBir1TRnZGmZof94LgMb9A2V9cKz
   ZltckS58YKE4H5lAweEJwP7oQd1J4l7aewCz5E+CU/d6Iks8s6ODg/9P1
   ikHO9uHb6mYLHZZJSiH9bKHanBiIH6FkE2BodRCBO+jxAFcOAlMTj+sjl
   ifW+jQsIKqShL3Ld5GEmgBVV/GbO13c0s+LwEt2PdnN4bFaFTwjT4zCeS
   VixLVmvwsL0P3KWysxqfQIKC26jWZe9EcsK8NikPUccRUUYCrKHlB5qi9
   MZ9ghzBHtOK8kNv1eX3QiqvpZ95cW4A7U0mVJFIXJ/jEndZ18GCJEWQ1V
   A==;
X-CSE-ConnectionGUID: Vmyg9dy+TYa8y+2FNlyjWQ==
X-CSE-MsgGUID: 6VBNeKHITZiGdkweF/oT2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62422324"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62422324"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:22:12 -0700
X-CSE-ConnectionGUID: Y6NsP5ztRbafhBxKLIiyrA==
X-CSE-MsgGUID: viiy1XWnRdalu8a01NEPkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="150091271"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:22:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 11:22:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 11:22:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 11:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzxuTXF/9hj9LCu8ML2rudcNpUa77G8LQI4KmfwpNdfaNZiuprVhhn3sPrkbMdHv2V8JbY73WmXyldG7Kp2UEUN9PpkasXR8i2MOWyUDOOzH93scAYjr/WzMP6M9awGha9uDVJUBh3duy6MsAe16VPgGu7t+vufXShzLRmlbmPMJR/Njq5LQAhYfey0UXbR3dMAgcxCYh7h3eWXmvSNaL0U4BjlnzOBGklJVqGmJNm8C8Y4WLV8ABAbVoihUW2e3zqgbJ4GKEabdZw2famPRe5Z3fDW56ZEtn0CUdQVWvVj3pq+Yg2ozdQeW/pYZw2tedEMLHlVSv8UO82KbzTHG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55kO/9ziryIJoaotALzHdFz9sTlW/obfNKchqnYM1DM=;
 b=x23Fo+4SfM/jsK63PYA4Ql1cBjL+h43Q4gSnT0zOMvanKQ1bCiAP55EtSXuBpecBnuRNClXI4CNDTA46sb6vW7HA+IS6v+VLCamj6xfdOhh/5272jcq6i23FEEWqkJf3vANyHvZK3+fda17upB90hpZW8DW9fx70IZgeKQ7x33JZgQEkHvHcAr0sJ86K6Xf9VBDnV1AG64zriowKZaAnGLkBFK0F1utF+yTdxfD5lQJQfa7TS7QDicHaj8iVypaBcZhSxSLexvIstAbLiWkGdFjfQCMcj8mOuCbXY5aeTxAJyKqb/+9lTeTwp5LBrN0SRpPjnTyMkZ8F8Y6BKz+oZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM6PR11MB4515.namprd11.prod.outlook.com
 (2603:10b6:5:2a9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 18:22:09 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%4]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 18:22:09 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Damian Tometzki <damian@riscv-rocks.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Thread-Topic: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Thread-Index: AQHb1K79w0jCIcYeiUWI5OXOWSPRVrPxtirAgAAHwwCAAABYEA==
Date: Tue, 3 Jun 2025 18:22:09 +0000
Message-ID: <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
 <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com>
In-Reply-To: <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: 4a1c315b-4fa3-4a65-5089-08dda2cb8d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFd5MmpFL1hDZitFRU1KeWZyVTYwY2lUK2xnTExZN2poUlBVUlkrK3U4K2Nh?=
 =?utf-8?B?TytYWVF2VktmS0RmeXNwNlZNb1hQakZKK2puYmRzaCtEWkR2Uzl6ZWxTUmU4?=
 =?utf-8?B?T3hqK21idGlsQ3h6Y091TXZqTmNOYjNsYWMvc0owOHRONlNMSGpWbWFKblJo?=
 =?utf-8?B?M0U1bW9lb0M5VkRiMTlsNHVpMXN3RkJxZGxnSXpETVNpOHl5QTJyelVQQUVG?=
 =?utf-8?B?L0p1UTdTbUhqWW80THhUbXlmYmo5R2xqUDhXY3BkZW51MVlrUDA5c29Lajhy?=
 =?utf-8?B?a2pMdlYrRXJoMkFCcUtZcHVJZVdjVTJaekZGRDgxR2ozZ0RGWGtkemE2RlBj?=
 =?utf-8?B?dnFBVkd0RlhEREgvVC80am1xUms1YU1kMEdzYzdhNEVOTlZNVGozYWo2c0Yx?=
 =?utf-8?B?aTEzNytnV3h6YzdUVTN1UjVaeDArQzlqTDJpeDVidHpHL1dhQTh1cHVpMk53?=
 =?utf-8?B?NzZ1OHdUUGc1djBrUFRjR05VUUE2RGNVa1dQRHVrcHI5WjlUUm5CbERRUVZp?=
 =?utf-8?B?UnJFT1c5aE9oaDk2Y3BhUUtKc0tqWFpVWThPSDBTWXZyeVVGb081aUkwTlV1?=
 =?utf-8?B?VnZ1NnhZMk8yWCs4TjhEUmZLWVR3SjcxMEN5SExPSXYrRm0rK1V0SjF1aGRK?=
 =?utf-8?B?NTBEbWlHRkJocEFpU3BZVXo1bDU4eXJwbDlOWGxKdVhEZXAvREJEV3pJY1dx?=
 =?utf-8?B?SXYyVElHTFJya1F4VkFtaWdUQ0hzWXZrWVRudjU1MTRSUnhCcDNLSjlJb2NK?=
 =?utf-8?B?U3VURnpyV2pxNzJLY05ORVVZQUZGQ0Q5ejBuUnByVkQvUmhxZEtlRHVyVmN6?=
 =?utf-8?B?dFdSMmtpSWROeUhkeXcxYWI0NTB2NDJIZnBYOUt1UllIbjZQSHg4WlU5bkpD?=
 =?utf-8?B?dTY5d2JyZHh4eWpwUlFlMTJiUlNtRXV6a254azJEbzM3NjJMUUpROHlaS3FB?=
 =?utf-8?B?M2ljSEZyRndyMWxtUTlQMXdLZnhZeFNwMUc3U3VZaVlLTDZFUlBpR045anFr?=
 =?utf-8?B?a2VhZ0NCRm1xcDZtMzhTcGtyMDVudUQwSmxnU3dMOWxibXZGdjcrVmNTOUtZ?=
 =?utf-8?B?bkEzd25XVmY1NitDZW5IVHg5NU5rUHdVSm1KRG5JdXc0REVsQjJmcXV2MlV2?=
 =?utf-8?B?WFJUTzh0N0ZQU3V4S0krUFJJNW9VRUtPUUNpQSs2L2ZXTExud3M0ZWVRUnUw?=
 =?utf-8?B?WEEyT0VKbm9QcDZtVENEZmRRVDFCRitiT3RTZ29sN1lYRy81dVMyQmNsb0NN?=
 =?utf-8?B?MWFxQnBCV0FFaGNGWUoyR241aENlTE5tZXdiM2xBbFNPRE53MjVtWHk3U3A4?=
 =?utf-8?B?UVRvSTlOaE1Za2xUc1hSclVtc3dmL1lYb2VDbnhNV1ZCSlFNTlNteWJERE5y?=
 =?utf-8?B?NG9NUGphY2FzOXZBeWJIS0hNM1cvYVcwWFAraTQydUUzWVZwcjRvNmRIUElk?=
 =?utf-8?B?bW11RzEwZkd4cVZXOFhpREpjQ2YyNmhHVmE2Qnl5RUIycWU0RDFjTitUbnhj?=
 =?utf-8?B?QmpSV3JoSEt1cThXMXhXMFVMYXFPY0VpMUQ2U2p0UzVpc20vTGNPRGZCRE5v?=
 =?utf-8?B?ZFFPM0IrWjFKYTVmVC9jNDAvcWZlZFRPVEs3cDVWZ1lGTTJrdWxpenFQVFJp?=
 =?utf-8?B?bGM0R3lUUndmVkhIZFNrOVNrZDJveEQ2RXRYYXBkNE80QldNK0d6YVBQVkJB?=
 =?utf-8?B?Q3FrMVJrOG1qTXkvNlZaMlh0Nnc1b0ZwdTdHd1ZCVEFKOEVhMk16TnZGaXZE?=
 =?utf-8?B?SVlQaEFGU2QvdVNMTC9pUnpNZ3IrNEVYTEk4ays5SkdON0JKRnQ3aXRMOTBl?=
 =?utf-8?B?TjlLQ0ZtdlowVVFKSmxWRUw4MHNvb3FXamVML0dEWllQV1c1ek4xZEdEWG90?=
 =?utf-8?B?UER0MHBOcTltYUVjSWxqQS9iMHVhNWY0dzlielNLSXZXSGxYVU1Zdm1JR1dQ?=
 =?utf-8?B?MXppQ2QzdkRaZ0pxWER3RkszK1g5enBGeU1pQ1pMcEFRN3ZkWWJ0TWtrSjQ0?=
 =?utf-8?B?bGZtanNJY2xRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZvVTJWYUFDQ2xYUmd3N2FuYW94M1VuK2tSZjF0c2Z1VWRNUko2RVBXM1pN?=
 =?utf-8?B?VGlRYWZQMWFSVy85OE90SUJUN242bGcxMHhQK05aVjZtcUtTeVBLUktQZFJB?=
 =?utf-8?B?RDdqTTkvMFp5eFdzWEhPN1FzclVIN09CVjRYTWRJaGNYZ2Mwc3dSazU1N1Bh?=
 =?utf-8?B?azVlbTRSQXNQSHNYY0JXTU5XTzYxOXRnRk9TcEc4WkpML0Nnek13dS9rY0Ev?=
 =?utf-8?B?UURvalQvSUh5a1RnNEw3S2NYS2Z6ZDg4UWZhdHdQMGhIYngzdlZlTWFYYVEr?=
 =?utf-8?B?My9MM2RzT1Z1N2QrWGZIa2puUDVpMm0ybnBGSGFSWmxYUmlkUWtLTjN0VHZM?=
 =?utf-8?B?NzhXcGQ4Z2VNUjdNblRGYmpaVUgxYWVPUUNtWWtPYk1jRkZHT2VPQmVHY3lj?=
 =?utf-8?B?TkMrbDBlSjJWa0hLYU5xMWtHMFp3RjJwU3Y5cjBxZmpsT3dRZ0svU3JSbTY2?=
 =?utf-8?B?c0F4cFpJdnAxOEVRWERuMG9laENWQXpNTTJnem1uUU5lOG0xN1FYOFF2SCt3?=
 =?utf-8?B?QU9lRUx3Z3BoSFhyZW1BRWhlNEIzVkVWbXZmblM3cm1YQW9raU5hV2tzQmp1?=
 =?utf-8?B?UDNTNlJ2SzdZKy9jVG95Vkh3YzJFWklTQUhhN3hOSElYcWRvL0I1d1VzbGt3?=
 =?utf-8?B?U3lndDFyTGg0QnFBR245MkxSV1NzY1M2S25rYTdRQy85eTl1ZmxqMTlzN3Ir?=
 =?utf-8?B?Y0JydFFXam0yYlZqcmNDcW45dldSdHRsVUdaTFE1L1EwUkxzdjUzbklEcWsz?=
 =?utf-8?B?eU14d3lFU3J0TTIzRXNWbUN3TW9WdUk1RVZ4ZkUzNkR4QnJRQTBEZTMwMjZn?=
 =?utf-8?B?Sk1CQXJ0V3QrTFRvWDZ0R1NlRXhYWGtqZkdOdTRpMnVJMUNwc2dkaS9nbDR5?=
 =?utf-8?B?N2V4aTFnVmRGcURManBLamtURGZOMDlEWVYrMWlHeW1IVU1YU3RoVnBsY2dB?=
 =?utf-8?B?VkRJK3IvNDFQa1V2RWNCbDZVNU1oQkJQSm1Ld3pFaXBnSUJGNzk1S3FleTlZ?=
 =?utf-8?B?dVU3bjY1MTZpV3VEc25TUUxPdWg2bmZvL2RyUUdwUmFMTWF4aUwwY04xV01T?=
 =?utf-8?B?ZGt6UWQ5VGg2d3hrV3JnZWhMYitwakFmT0JPa3p1UHhVWlBkZGpGY01IK1FQ?=
 =?utf-8?B?R0l1WERibktvVXRRelhmT1Zjc3B6cUFuMXlWd2xBSlU4ZGxUeU5GNjV5d1NW?=
 =?utf-8?B?UVE3emk5RER1OGRPVXY1UzRVZWhGLzVBTUY5UytSUXlqeHVkNjMxb0FMK1l4?=
 =?utf-8?B?MFNGQXFwR3VpYlBlSWFCaUwySCt1ZXdkdEdUS2thS0VCMnI1YytYYjJBdlIv?=
 =?utf-8?B?eTFrRXY3Mm9QaEZQemdoVVRrcGllVUFKbUZmUWgwVVB4cGJ3cjNGRnViT1FK?=
 =?utf-8?B?ODZBTVk0eXNRTEJrZnQ3b2RGVFdXK2NUajJ4VlZWVkNLeWR6NitHZ3QwaUNJ?=
 =?utf-8?B?bWx6Mms1UEVVdjZPU2ZRc001WTl5MEozenhNelJ4NURWTDZzeEczcStUTnlZ?=
 =?utf-8?B?S2ZYUmdUYUlzTjhaanMrK1NUV3JYV3RWS3hXNXZ2WGtWckgySjY3SWQ1ZWgz?=
 =?utf-8?B?MDhZTCt1RmZYaDdTTU1nZU1pMzJwdlk2RC9odTNhMVZPZ0xldkZFaktKUk9t?=
 =?utf-8?B?Y1NZdUNSSDNnZEZ1ZTY0RGhIWDVIenNpZDRNQitnSlFCenF5K1BLRUgwZStk?=
 =?utf-8?B?QXpvNkdDZ1RtbXdod3RKUWdqb2tGRHJyOTJsRDZNZGR6bTZWZzJzNGo4N1ls?=
 =?utf-8?B?b0UxeXJFNEpTYWl2cU9KMENuVVBCUlpONHEvUkRjTENaUmc3ZE85RVZWOTlR?=
 =?utf-8?B?ZW9zVmNEWUk0SmNrWUpWWHpMVHFFK1VPandUayswN2NGdWpXbWg5NW96OWJN?=
 =?utf-8?B?UFNFU1dwenJrOFprb0RJRG9NM0FDV3RYOVJ2YmZlUUt2d0xRbks1NUd3d3l6?=
 =?utf-8?B?N2g1Z3VCclNQMkljdnN1R3NmT1VsMHQ4ZlFzUUdMcDZKeWJ6UXd2ajlYVlFH?=
 =?utf-8?B?S2tMbURGTGtyc0dWTTNMMDFtaU9SVzZ6R0pOcTE3S1R2RGxMT0JENlh4VS9n?=
 =?utf-8?B?THZSb1ZGM3JUbCtINGtJdXl2MGRTNlh5dHBoalRQOXBrTUJLSWxIN29NUU95?=
 =?utf-8?B?N29zVDlGWjdGS00xaWhiVzZqM1pNUWpJZHZReitENzJuSm9QNFdjbW1wNkFl?=
 =?utf-8?B?bUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1c315b-4fa3-4a65-5089-08dda2cb8d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 18:22:09.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnwXU9O0WFgHZ8wbIRvn6FpMfMnOHSJHZjTXS4CETKpJ5ft4scgoXBtVkqUU+tNioOXU2bXdOqLKp0VntRofE6yCb6Ritd4LBh1rba/Vrft6SJZMQ1bBE4WdwuD9mlWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-OriginatorOrg: intel.com

PiBJZiB5b3UgbmVlZCBhIGtlcm5lbCB0cmFjZSwgSSBjYW4gcHJvdmlkZSBhIHRyYWNlLWNtZCBs
b2cuIFBsZWFzZSBjb25maXJtIHdoaWNoDQo+IGV2ZW50cyBhcmUgcmVsZXZhbnQgPw0KPiBNeSBp
ZGVlID8NCj4gc3VkbyB0cmFjZS1jbWQgcmVjb3JkIC1lIG1hYzgwMjExIC1lIGNmZzgwMjExDQoN
CnRyYWNlLWNtZCByZWNvcmQgIC1UIC1lIGNmZzgwMjExIC1lIG1hYzgwMjExIC1lIGl3bHdpZmlf
dWNvZGUgIC1lIGl3bHdpZmkgLWUgY29uc29sZSAtZSBpd2x3aWZpX21zZyAtZSBtYWM4MDIxMV9t
c2cgDQoNCg==

