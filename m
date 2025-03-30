Return-Path: <linux-wireless+bounces-20958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D9A75883
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 06:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CB23AB399
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7321C2AE69;
	Sun, 30 Mar 2025 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNEfNnNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E733EA
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743307973; cv=fail; b=DJGrdzX9AvhDjBVoIo/lzl6R4ElKrI5cwMbYZ/zjk7AyziomfjhYbsW7AQd/0w6oKYeEg9s2EzK/vmy9miNh7RoaUJqBLufx4osZNxs8oQ2tWtDAfIp4gZA1kRU0VXE0FZyCzwtvpIOO/vj+uDL5HcWYfSP3oZtJ/yWKgHk2HUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743307973; c=relaxed/simple;
	bh=xL2vD1NO4NxWVkiC6Y+iqcBii+wZzBdjDn74KcJ/rYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gh2lEhGFG4pGfcE86IgQOZUQxjyzJlv1LxU6bEI/65tkUwqaTFdOJhyuCulyNZH6014QB27G+FTVWLn7r0y6WKNO1+R7LrBF3KkaIn12rRQy3a0uZqHsTE5aDEAlL+PFmyesUTlWOu1uDQDdy9wAVU4CJCfeCU5NGOxs6DlxH9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNEfNnNu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743307970; x=1774843970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xL2vD1NO4NxWVkiC6Y+iqcBii+wZzBdjDn74KcJ/rYU=;
  b=gNEfNnNu3xpQyaJeljM12t6Yr2vFbvXO4QopuX/2HwbYffJU/0R3ehz4
   2uQzdsPNbwMyFU2/pzscB3flMJrcsa+UMu7sRYK97Ll1o8fxTj03zU//L
   b/4aJmJqQWz6sFXrWROSIJWKrbT7bpp8WjL/GOnimg2LNIvBUmlfWdN6W
   QkphnB2SS1EgbSGncz6voMC/hM2Nxp7lhJF9NmbPDFtpAtTVWbPG3mXzZ
   5NbTDRiPgozl/iYG8EhmFa2p8b+4F9lDuE4WRglve5qO2MJRD9e5W7wpC
   9/CYhR7oDhVarIUmUBdJAoB0ca6nl0z+s2RzPYUY90y+BJgyISODX0wAG
   A==;
X-CSE-ConnectionGUID: y2IGh95dRcK5ggDkP2bTFA==
X-CSE-MsgGUID: 5w9UVgzGTFeoqTyGmhutPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="56004350"
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="56004350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:12:50 -0700
X-CSE-ConnectionGUID: dEoosLgPTPuSYDYY6vuNSg==
X-CSE-MsgGUID: s7vnNAkBSParDogCnWPaWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="125612541"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:12:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 29 Mar 2025 21:12:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 29 Mar 2025 21:12:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 29 Mar 2025 21:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg1rbUqLz4qKBjHgit3mlJMJnlFqRHedXIlZ3K+1vlx5HNT7v+run7k/q4NXxX/DPX/I5Dy7hbXeT+RL7BaQBzrbgYgzz+1p6v2Sosjcb/SRavRsGQmvTcwpUeS/lcjAzw0clYUBn0P6ORPP2AjrbsPQnBcw1Ux8S2+pwmg2tUvEIeqGux4J6wGv0z477Dk8mTx78ftGIX4aap9uhSl1mTBVWGRQN1toMLyH4wfam/LfcOIwIWmEPn1azLiQ/rBemfGyrPwugr9cwOBHYbE1HsZaFWJN9zdLwcBfm0B1jFupH6USTiseyWDj8X7CE69HwR/TB22aN8K9ObeBzcqzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL2vD1NO4NxWVkiC6Y+iqcBii+wZzBdjDn74KcJ/rYU=;
 b=OdQV4hHaNG2p87xq6D6g+/QGSYORBtJk0cjSMJCq+IlmEzfM1AjCnCAFB2aZ9/nA5YXNOj6g4DILgNBnIVBeLoGUZzb1aTbuQqasPTGVvklRVFjydZ8DdpaD6Q6K/rT0Fpurzz8NB/CTBuIr4zx/ChbxQkpwpAuPlvP2/BLhErVU4qMS1dAzfekRR+k3yhYaPJ381N54Qyznjx3M7tIpbo9/vFLmNgTuy5M4WHzrRxSiYp7nDosAB828VBMSdjPLtEZT/sSwD7rPS8UjaWU5gzoQCw2Zp6X1UQQX70ynpV79/U05cfjslN5QmZ8Y7GGwnqKfnCru4uHLxR50NjzSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 04:12:44 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 04:12:44 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with error
 -22
Thread-Topic: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with
 error -22
Thread-Index: AQHbn3mA8QotXLrVl0qHByV5uQ6cqrOLFJVw
Date: Sun, 30 Mar 2025 04:12:44 +0000
Message-ID: <MW5PR11MB5810B066CB7824714FF25D0CA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <Z-XvFvGigpY7JYFn@debian.local>
In-Reply-To: <Z-XvFvGigpY7JYFn@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MN2PR11MB4584:EE_
x-ms-office365-filtering-correlation-id: abf08a1c-2353-442b-73f7-08dd6f411f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THZFNmtrVFRXN3JoSTB5dDJBa0JhWklob3UvdXVmN29GV1h1RXZLK0UrNTlO?=
 =?utf-8?B?K2dLdVArdjlZSFVtdFpnRE9uNjV4VmlTbGtydVB4d1EwTzZFZ3FnaXRHbHJV?=
 =?utf-8?B?MFoycCtLS0tUTS9FM3Y0SUtkMFVSMnlnbkpUVmRxRFNxWGFHNCticllKWDNJ?=
 =?utf-8?B?ckR2bEZ6YWkvK2pwK3FiNmsvQnJuVFlJanFwY0oydHowK1M0TytrNUd3b25Y?=
 =?utf-8?B?VkNpa3BBenQ4bTFkT1krZ3ZMaXVSS2NDRnN3c1FtRU1semZIRHVJamxnUGd3?=
 =?utf-8?B?c2laOXdjaWZpZGxnVGRpT2ZxOG5pZG5QSVgyTjJkZDNob2oxeHFTSlhmNjZG?=
 =?utf-8?B?SlJsTW1PemRKbHJNQys4NmcyTVIyelpUWkVlbTB1WU9DK0sxNzRkVUhkcnpK?=
 =?utf-8?B?anNFQmV3dENHUXNKd2syaHJsaDVkODkybmljOG4vSktUZVVzUnp2bWxpeFVH?=
 =?utf-8?B?S3dCUk1tVUFyL3N1Yjl5QnlQVi9jYlFnWXdRc1ZOS1FwL3daUGZBQTIrYk5O?=
 =?utf-8?B?VXV4ZHpQZ2NKdkJDY2FqUm5MOUxobCttSmc1Q1dpU0srb1BXOUlxNnNPbTMr?=
 =?utf-8?B?ald5L3pzTmhLSW0zTm5yQkZLYUVWcG5TUHU0OUxWM3l6MmJjSHZqSjl1TUVk?=
 =?utf-8?B?dGg4U0dySkNpUHYxVGFVb0FOQWRkeFVzcVIwUDVCZWpNdDRVVWNvVDg0dGw0?=
 =?utf-8?B?KzVET295LytSVzRYRzV5WmV3bkp4L2VPZ1IzUlNTQlBjeUdYM2lOam5nV2Vh?=
 =?utf-8?B?ZTc0Qjh1dFdiWmdENzBpVFhFajJMOUJXVzVMcjd2Q0MrTzZFYWdKUnNGYmxw?=
 =?utf-8?B?TTRtZHFDbGNZaGdSUm5QVkxtMTNyUmdLWVZSU2xweXhoY0JwR1RMQ3d1dVNG?=
 =?utf-8?B?ODJlRGRPa05aeWNGRGNxdGVXOUVQc2lwbEsvWVBjYXpiYzdaZ1U0ZnJzSGtN?=
 =?utf-8?B?dytINGhNdS93ajlTYlF6Z1RGNVNFWGJlcWlnbTZnYzhmZXMrN3Vyb29sS2dt?=
 =?utf-8?B?elN3RVpmd3dZTEhjaGlMRkJWVi9JK2ZNQm1xSG1UeFdYVFFHazNVbzJZSzNp?=
 =?utf-8?B?bVFYN2NOOFl4ZVBJVy81VGIrOEwxMjNUc3hyb0RsaHJza0xnQlI3YjR1SlM0?=
 =?utf-8?B?ZjBVcWcvZnhLbWRYUnZNMnZBNW9lOVIxT1pGaWFzaGM5V2lSZGNzajI2dEN6?=
 =?utf-8?B?VS9YbDhUL1NJUnFLbnFxanpLbUhBa1BNUHUwS0pMOUF6SG5HVnJRTXJKVlpq?=
 =?utf-8?B?NzIwTklCUEJlU0hmKzBCdjVqQ2ZRYlBFVjZTdUlHekh4QUczTlU5a3l5Z0NQ?=
 =?utf-8?B?RDZ1SjR4RXRxOHNmSmZHM2hPYno3UGZxcVAvQms2RzRBenpNVXV4YnZZNU1X?=
 =?utf-8?B?MVRCZlFHR1YyYnl5TEovWHZ0UVUxZTFRcE1WN3F4MkR2eEFtK2cza2NhUUN6?=
 =?utf-8?B?MmU0eTZFTE9FSWp6ZEs4Rlp3b3FtRjFmVGdyaXBFWFJzdlAzOEpkc0p3RVN6?=
 =?utf-8?B?aS9sQmxxb1lZQ2d4WHhUUkFzUmhtVHQ5Sjc4UjhjZ2hrK0Y5TjZjaEg3V3VV?=
 =?utf-8?B?WndGU2Y1aFVlMTBSQmlTb2NSUUk0eXYwcUFTRW4zMlJrRFdTRUl0MytjYnd4?=
 =?utf-8?B?MDlPNk52VFZXTU8rL1Jzcms4WmF2cVN5N1ZldkhnbDNFZW1wUTdKTjNoU0RQ?=
 =?utf-8?B?djZBN1lzbGtweGR0cklmcUdOanY1WGRJQjk3blZHcFJBTXZtRjIxZFFjdHIr?=
 =?utf-8?B?MURtbGRZbnZHcnVjWno0MGszVkxwNDJaMXh1b0IyM256cmluSTFHZHZxR09N?=
 =?utf-8?B?WnJXdTRWZnJSaG1tSy9Oa1BEOEh5dGNHejB3NGc5NTB1RWlCSFFSMVRZSXNL?=
 =?utf-8?B?eUtzMHlyS21OREJ5SzFyUEI1U2s5Y0xFYUVQdSticTBTenRHU0JRRENvVzZy?=
 =?utf-8?Q?k1DBwC/mT3I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1EN1hMVFU1NWxJSEhzbmkxYWpoczVMMWFvby9XZVRyeFdkK2ZFTzdqL1Ft?=
 =?utf-8?B?N2tselhGM2FwVTlpWEtNTjhvV2xLakxFdzBZYUV2VWk0VXI3enFJdTNqbDRU?=
 =?utf-8?B?VXVpbTRySG5NNDVmTGs1cTNWVGNlaFZ0RFdHOTJINy9DdXc0Z2o5cko4Vmlx?=
 =?utf-8?B?Mkh5Yzd4Q0pjOFJsM004REVOTkFsQ210aFljMW95KzRSdkVYbEVoUTVtUUhN?=
 =?utf-8?B?aklNdTFEK0lUaUYwZkZJdWg2TlhNT3BXcXRYTUdZWmNlQVNBTnlqL3RnTEJr?=
 =?utf-8?B?YlIzc2Uzc0FSUS94VEV1ZGgwWGRUaFdxTkYvUDhtYW9zWDRJYXVoZE82WVl3?=
 =?utf-8?B?dFBNWXljL1dPZ1c0emJFNzBMMG1rN2lsM09QMWxZZ053Z3BRWWZJeGVIdEFz?=
 =?utf-8?B?RkxTYUsweTRxcW5pSk5tTEg4Y1d3YXNpMVRqSWc2Skx2cURLY25XK0FIZDVx?=
 =?utf-8?B?NzlaWG0zR3pGMldGNkVWQUFjaktpOWFrUytKRFIzMVBTL2NqUllwODRMajVq?=
 =?utf-8?B?VnQ4TEZ2K3BlOUNDM3dJNkpOZjl1Mm1ieSs2c1JkNEdWRTgydkhySTh3aFJj?=
 =?utf-8?B?K2toOEpQc0Zxc29QaTZud0QvSUs3TUlxbGJXb1BkRUpCT0c0b0tHYTgvUzQy?=
 =?utf-8?B?Njl5K2VoQmJTK0RQMkp0UmdtZnFzWHdicSs4dDBGZEZQNHYxcjhuZkxkU0lY?=
 =?utf-8?B?Yjg5UjdVdEdoNm1XcVZDZEdEclZsZjROSzBmRnlUemhiZEpKMWpjVy9PMEww?=
 =?utf-8?B?L0l5bWc2UTY1bFBDNmsrQ2xvaldrV2FxQ1pBZ2k4TGUwWkRnMW5idGRlbHhx?=
 =?utf-8?B?a1JtemU0OFJaazVKb3RlWmJMVG5POWpySnpwRHgyQmpiRk5ZOS9xaWxqL2R1?=
 =?utf-8?B?SkJ4Mzc1VGtHd1ZIYkVyT0c4YzdjN3JINDYraE9hN3hYSENZbDBSNE54dnlv?=
 =?utf-8?B?NWVkd0hmYnpDOWdJN1J0aExHamJXOFFtNHZUbWMxb1UrZ1I3YlcyNnhvNEdt?=
 =?utf-8?B?K2x1VUFlcXNHaEIvcXFZRDh4L2RVUnloNjRaanBrc1dIRWNjTVhNZ28zbDEx?=
 =?utf-8?B?c3ZZNjNBWlRNL05HcUh0Q2lKOU1LcmFBdEFES2F0bGZTTk1hS25WZk5uUFJr?=
 =?utf-8?B?SGphY0JRMnZDK0plK1JXMUZQMm16a1g0S3IxM3g3QzBLUEVmTG9FRHN2RUVa?=
 =?utf-8?B?UkxJdnIvNWV4RCtiQlgxNGZBUGFZcWhBdVBDVnM3OGNNOHlwMlpOZk4wUWVh?=
 =?utf-8?B?ODhldHAzK01ZL2xBcUFyK3JQYWpBbGVjOEhHRWpFcWs2TjVsdHJMQ0lCNTB3?=
 =?utf-8?B?UTRxVzZZY0xGcWE3UVA2QUw0bTZaMmJOcEZNaFhBemxLMENudHVFMURsTTEw?=
 =?utf-8?B?YkY5eGt0cmRuWnZFQTJ0Z0VUMTB5bnBEZmlOQlZWb09YZ2liMW9ZdXJrWEVj?=
 =?utf-8?B?dkkxVVh2d3JFWlUzNVREMDRmY1B3K1F5UTB2dGRQTnZSQzlPTUhUSitZalBZ?=
 =?utf-8?B?cXZmODlhZ0M2SlgvVXVXblNDYm9UOHFLRlVPVGl5UHBtTkVSM0ZUWVBkVDhp?=
 =?utf-8?B?SWdhSEoxR2pNMXE5bnVRci9vNnNUZTZZcG41QTMvdjU0QStaaTR5anVMcUVy?=
 =?utf-8?B?emx4bGllWUwrOWNLRjFwOXRKRGJESi9kQlVjdFZleERwYjdSOGR3Q2oyeWRN?=
 =?utf-8?B?aGg2b2FFancxOU83bUFNR2lvS2RaZ0wrbG5peVQyWWRycXZ0OEVNTTQvU1BV?=
 =?utf-8?B?b3RCWWRTL3VFSHhhb3dNWXFKRVJ3Nm5PcnNpazhsdFg5MU5ZZ1Z1dDNOSHF4?=
 =?utf-8?B?YklzNDJ1VEd4d3N5MjZYaEp4ZE91K1BkQVpWV1hjenc2U1I0TmlLL0lpTlNh?=
 =?utf-8?B?VUpBL3psRGl3anQrVTg0S3FnU2ErMXN6b1RtaTdiVDFsNmNNYUlrSGFaU2ta?=
 =?utf-8?B?SHlUTVZrRkJQOTdVdUs3dkNZWTlPRUdyNHRhTFdDK2xWbHpIRjQ2ZnJ0TVpU?=
 =?utf-8?B?cXZGMFlzRURJTUNpS0FkZ2ZaTUR0T2pnbWhhVzliU3NPUWU2NWtheXNOWGxl?=
 =?utf-8?B?aVM4T0xGc2xPTnJXVEE1amU3NVlidmJEYklUaWdjRFpFNU50NExhbzFTejJm?=
 =?utf-8?B?MFEwUFJUalZQTlJEVk9WejVDVzlQYlY3cXA0RFVMUkdaU3k0WFVxbm0rU0R1?=
 =?utf-8?Q?/YsTKF9OLJYgbi2aewhAToc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abf08a1c-2353-442b-73f7-08dd6f411f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 04:12:44.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqFCwEkzzlumVN0O49JXFcVFm+Z0OLK1FIV7agIG2mHwBMNydjjp2P7enhfIZVA3wbiKt2jF0DchJrmhHCW6dTQ0O4K4EtSVFsJEwXAVnkDJno5S6nfVUW9ba4R+jhlk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMjggTWFyY2gg
MjAyNSAzOjM3DQo+IFRvOiBHcnVtYmFjaCwgRW1tYW51ZWwgPGVtbWFudWVsLmdydW1iYWNoQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsga3ZhbG9Aa2Vy
bmVsLm9yZzsgS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsDQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVu
YmxpdEBpbnRlbC5jb20+OyBCZXJnLCBKb2hhbm5lcw0KPiA8am9oYW5uZXMuYmVyZ0BpbnRlbC5j
b20+OyBiZW5qYW1pbkBzaXBzb2x1dGlvbnMubmV0Ow0KPiByZWdyZXNzaW9uc0BsaXN0cy5saW51
eC5kZXYNCj4gU3ViamVjdDogW1JFR1JFU1NJT05dIGl3bHdpZmk6IHByb2JlIHdpdGggZHJpdmVy
IGl3bHdpZmkgZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+IA0KPiBIaSwNCj4gDQo+IExhcHRvcDog
TGVub3ZvIExlZ2lvbiA3IDE2QUNIZzYuDQo+IFdpZmk6IEtpbGxlcihSKSBXaS1GaSA2IEFYMTY1
MHggMTYwTUh6IFdpcmVsZXNzIE5ldHdvcmsgQWRhcHRlciAoMjAwTkdXKQ0KPiAwNDowMC4wIE5l
dHdvcmsgY29udHJvbGxlciBbMDI4MF06IEludGVsIENvcnBvcmF0aW9uIFdpLUZpIDYgQVgyMDAg
WzgwODY6MjcyM10NCj4gKHJldiAxYSkNCj4gDQo+IFdpZmkgc3RvcHBlZCB3b3JraW5nIGluIHJl
Y2VudCBrZXJuZWwgYnVpbGRzOg0KPiANCj4gWyAgIDIwLjkwNzgyNF0gSW50ZWwoUikgV2lyZWxl
c3MgV2lGaSBkcml2ZXIgZm9yIExpbnV4DQo+IFsgICAyMC45MDc5NTVdIGl3bHdpZmkgMDAwMDow
NDowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikNCj4gWyAgIDIwLjkxMjAyNF0g
ZWUxMDA0IDItMDA1MDogNTEyIGJ5dGUgRUUxMDA0LWNvbXBsaWFudCBTUEQgRUVQUk9NLCByZWFk
LQ0KPiBvbmx5DQo+IFsgICAyMC45MTM2NjZdIE5FVDogUmVnaXN0ZXJlZCBQRl9CTFVFVE9PVEgg
cHJvdG9jb2wgZmFtaWx5DQo+IFsgICAyMC45MTM2NzBdIEJsdWV0b290aDogSENJIGRldmljZSBh
bmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkDQo+IFsgICAyMC45MTM4MDZdIEJsdWV0
b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbICAgMjAuOTEzODEwXSBCbHVl
dG9vdGg6IEwyQ0FQIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbICAgMjAuOTEzODI4XSBC
bHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gWyAgIDIwLjkxNzQ1NV0g
aXdsd2lmaSAwMDAwOjA0OjAwLjA6IERldGVjdGVkIGNyZi1pZCAweDM2MTcsIGNudi1pZCAweDEw
MDUzMA0KPiB3ZnBtIGlkIDB4ODAwMDAwMDANCj4gWyAgIDIwLjkxNzY3NF0gaXdsd2lmaSAwMDAw
OjA0OjAwLjA6IFBDSSBkZXYgMjcyMy8xNjU0LCByZXY9MHgzNDAsDQo+IHJmaWQ9MHgxMGExMDAN
Cj4gWyAgIDIwLjkxNzY3OV0gaXdsd2lmaTogTm8gY29uZmlnIGZvdW5kIGZvciBQQ0kgZGV2IDI3
MjMvMTY1NCwgcmV2PTB4MzQwLA0KPiByZmlkPTB4MTBhMTAwDQo+IFsgICAyMC45MjAxMjZdIGl3
bHdpZmkgMDAwMDowNDowMC4wOiBwcm9iZSB3aXRoIGRyaXZlciBpd2x3aWZpIGZhaWxlZCB3aXRo
IGVycm9yIC0yMg0KPiANCj4gQmlzZWN0IGxlZCB0bzoNCj4gDQo+IGNvbW1pdCA3NWEzMzEzZjUy
YjdlMDhlN2U3Mzc0NmY2OWE2OGMyYjdjMjhiYjJiIChIRUFEKQ0KPiBBdXRob3I6IEVtbWFudWVs
IEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+IERhdGU6ICAgV2VkIEZl
YiA1IDE0OjU1OjQyIDIwMjUgKzAyMDANCj4gDQo+ICAgICB3aWZpOiBpd2x3aWZpOiBtYWtlIG5v
XzE2MCBtb3JlIGdlbmVyaWMNCj4gDQo+ICAgICBXZSdsbCBoYXZlIGRldmljZXMgdGhhdCBhcmUg
RUhUIGNhcGFibGUgYnV0IGRvbid0IHN1cHBvcnQgMzIwIE1IeiBhbmQNCj4gICAgIHRob3NlIGRl
dmljZXMgbG9vayBsaWtlIHRoZSAzMjAgTUh6IGNhcGFibGUgZGV2aWNlcywgYnV0IGhhdmUgZGlz
dGluY3QNCj4gICAgIHN1YnN5c3RlbSBJRC4NCj4gICAgIFdlIGFscmVhZHkgaGFkIHRoZSBzYW1l
IHR5cGUgb2YgZGlmZmVyZW50aWF0aW9uIGZvciBIRSBkZXZpY2VzIHRoYXQNCj4gICAgIHN1cHBv
cnQgMTYwIE1IeiBvciBub3QuDQo+ICAgICBFbmhhbmNlIHRoYXQgbWVjaGFuaXNtIGFuZCBub3cg
dGhlIF9JV0xfREVWX0lORk8gbWFjcm8gZ2V0cyBhbg0KPiAgICAgaW5kaWNhdGlvbiB3aGV0aGVy
IHRoZSBiYW5kd2lkdGggc2hvdWxkIGJlIGxpbWl0ZWQgZm9yIHRoYXQgc3BlY2lmaWMNCj4gICAg
IGRldmljZS4NCj4gICAgIFRoZSBzdWJzeXN0ZW0gSUQgZ2l2ZXMgYSBiaW5hcnkgYW5zd2VyIGFi
b3V0IHRoZSBiYW5kd2lkdGggbGltaXRhdGlvbg0KPiAgICAgYW5kIGl3bF9wY2lfZmluZF9kZXZf
aW5mbygpIGNvbXBhcmVzIHRoaXMgdG8gdGhlIGxpc3Qgb2YgX0lXTF9ERVZfSU5GTw0KPiAgICAg
ZW50cmllcy4NCj4gDQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBFbW1hbnVlbCBHcnVtYmFjaCA8ZW1t
YW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPg0KPiAgICAgUmV2aWV3ZWQtYnk6IEpvaGFubmVzIEJl
cmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KPiAgICAgU2lnbmVkLW9mZi1ieTogTWlyaSBL
b3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCj4gICAgIExpbms6
DQo+IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI1MDIwNTE0NTM0Ny4xYmE0MDZjNTM4YTUu
STZlMjQxMjNmNjBhNzY0YWVkZg0KPiBlYWFhYzg3NjhjMjZlMTM2YzMyMGNmQGNoYW5nZWlkDQo+
ICAgICBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNv
bT4NCj4gDQo+ICNyZWd6Ym90IGludHJvZHVjZWQ6IDc1YTMzMTNmNTJiN2UwOGU3ZTczNzQ2ZjY5
YTY4YzJiN2MyOGJiMmINCg0KSGkgQ2hyaXMsIHRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCldlIGhh
dmUgYSBmaXggZm9yIHRoYXQgd2hpY2ggd2lsbCBiZSBzZW50IHNvb24uDQoNClRoYW5rcywNCk1p
cmkNCg==

