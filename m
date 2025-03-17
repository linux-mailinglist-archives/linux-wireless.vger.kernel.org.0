Return-Path: <linux-wireless+bounces-20427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB8A644B2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFC1166CC5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE021ADDB;
	Mon, 17 Mar 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuvR0mCr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2B21ABB0
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198899; cv=fail; b=IxLeWyjH3ZEzOlFZzGVAFvySc12/cIhpfhniH4PIQPIv2sZEJxyQ7s0Af5wlxfzpO9VbvcrAdST94FSAkPJHvPvUMnQCra3x+7XHvyOQOjlgZfHCAHgT5YSYk9J7stcjBwd+CiVvbeXAWdSPm3Z8IYIDyU7CjDib3P8crtTA2rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198899; c=relaxed/simple;
	bh=Jld1A+bfm55ErVgvM1GbP0ICwQ/jUd4vGRd2UdgfROk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zbq4+AO5no+MUw500sMytOTsQB5Luy+Q2qF+MQCrpWBiE0sllfunaHxthwnH7NEi7yoRULsTqsTam6Yjt1KVrOPhKmH5Qzvm6/fILxWcL9VOWrb3rZDhRK47ldJEjEB/e2ef0dmT8c9ERzzYzZuLrtJFVZgH0P3PO8v7bKSJ8QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuvR0mCr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742198897; x=1773734897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jld1A+bfm55ErVgvM1GbP0ICwQ/jUd4vGRd2UdgfROk=;
  b=MuvR0mCrN687Qtf+ZbdBmms+dm9KNJJafybI9kTO7LbAm6fa1HxoUGAm
   RCeeCNoAaT5fTjWIydHv5FGssfwApUdmiOesPppTXNJfupRNKMzCpPgfz
   ymnb+OJMKe/vagHWyCM27j61THCgczIa+TB+6ICfCKv9A6lIc+vsPNF8g
   7pdG+G7sbFQut2p0fVxfaEym0IdU9PbcXbYTpHRwFqSPbDmekB6GTXeA4
   2fwPff0MGOrcUp9vnLorteW11zfURI2DEV7ZTihxskOAVpPDgpGO217I5
   VuhukzcH3U39lTDYsBZmtXCVANuQELhMkp40J+Jy0HIksbN+kHaJONsMx
   g==;
X-CSE-ConnectionGUID: HezMMnpgSCq+jFpV81I37g==
X-CSE-MsgGUID: B8keueCdT9OmwwmygpBljg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="53489492"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="53489492"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:08:14 -0700
X-CSE-ConnectionGUID: J4bLqsrgQCWbX/GChKMhFw==
X-CSE-MsgGUID: +Z4Wd1YAS920pEhDiLGJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121590116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 01:08:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 01:08:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 01:08:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 01:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnKmEMQsrsDuaemQfx82xFx53fnuQl7l45RzaP1lzXm93GtaGmJluEKFA0oWunzvzKXm4ybG9YawpIpv1Qae3c+BjoIaF/vrBRdJZTLWHS/hzue/ZEL7kh+alQzW+6/6PuMJVqToS54cT9HSutQTpp71zFsZCqH9dE4KQmZ8MAovjFWAOKOzExzUSabp6a4UvLJJix+x/B29H9fTxA/80WtDqvOmgdVxaakXEFSg0ow92RxRL4lRSqSZ7YAzfTZbpeSRmfvEm4zRltN11zEM/SveevJPD8WZPz1ZgiRBhjUmq7oGl20CzSRvdNBA2iiiujucQy+/E36uD1ypdSoVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jld1A+bfm55ErVgvM1GbP0ICwQ/jUd4vGRd2UdgfROk=;
 b=v6aXjoRiJpBPhJMTZ8D856e7B/YaDpqDiiekxwuJcz7f2qplg2wSAL6lePO6/yA7Xcd2nrJw3zct35+/hRXCa+1TG4wSmM+g0kIfMnozINkoNtLR5Lm/pzTweywvnboEBt17Gsc2rq9DUXoSc43Ojsao5wTZEAT5NrRCoym6oF2akVNuh/bM3YcTUpaMmkNlFjstbqGpCYREYzHhQUL7Ly92FHVVYeu/++1CXe0H0HpmVBmNv+sXCrOLRjj81REMPWBseC7YFL6+B/90qasQc5SvYEys6B80BphAEg3F8HBVJ+BOABEqsdRNi3L85K574zfZLmeMrJ/39Qh6m6f1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:07:42 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:07:42 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] wifi: iwlwifi: add iwlmld sub-driver
Thread-Topic: [bug report] wifi: iwlwifi: add iwlmld sub-driver
Thread-Index: AQHbkykfArxIscl5uE+ExD2odjCqu7N3AMlg
Date: Mon, 17 Mar 2025 08:07:42 +0000
Message-ID: <MW5PR11MB581082EEB5F17C45727EE433A3DF2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <6dc3c2d6-0457-4d2c-9784-b0e5920611c1@stanley.mountain>
In-Reply-To: <6dc3c2d6-0457-4d2c-9784-b0e5920611c1@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MW4PR11MB6984:EE_
x-ms-office365-filtering-correlation-id: ff9d7bb6-ccd4-435f-e058-08dd652acb1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEhCS1JONExrYW5JWUlqd1JqT2ErYVJOWkdQU091S05haG5BSXhxeFdBTTdm?=
 =?utf-8?B?UDFkSnF2RTIvL2ZqR20zMGVvaWFiV1pkYmFBZHpDMzc3RUtKZjVmb2wwRFNR?=
 =?utf-8?B?Y3c2a1kydXl2N3lzUmNyZVdzYVdZVnhRVVFzZlcvNElaTUEvZ0RMaFYvKzk2?=
 =?utf-8?B?Uk9zRzhNRDVKVWlxMnhmV3YwVTdWQjB3M2VKNnFzaWh4US9ndEtaN2I1YjFZ?=
 =?utf-8?B?NE81dENWdXptQjRhUnVRbnQ4N0JVM3IzM2xueVJrd0hJSWpBUEhaTHk1dVNJ?=
 =?utf-8?B?V1ZBTGdLNVN6MTIzbENidWdUT1R1U3JsZHJScEtaWGkxdmNvVjUrMk9qQTF3?=
 =?utf-8?B?WHpkMHRJSTlORHl2NWZ5RU9xUlcrUUdEbHoyT3dZczZlTmZhUTNnZkpmbHRY?=
 =?utf-8?B?Mmk4MVBsczdqYWtTaFN6alg3QmJZZHg2TnhkNmNMKzdhZHg1TDN1bHN2azBY?=
 =?utf-8?B?WDVFZmtON3REUFFmbWVZYTlXRzJoVCtQWjBhbFlsVlJDaklqT1Fac0NTN2RG?=
 =?utf-8?B?T1pNTWdjcFNueTFPeGFvUmhtRGR1NjcvUWlUYk5nSXBYWDQxK05jb09PNGFu?=
 =?utf-8?B?OVJqdGtPL1lpWFplOFgveXJzSUpaNlJZMlplUXFGWGxpMGNIbVpCMXZBTU91?=
 =?utf-8?B?dVA2bVcxMEx0d01FSTRHZUNaYXRrNGlWbExtMDB3aWtMQWlCVXM4N0pDY0JZ?=
 =?utf-8?B?WkdJT283K1UzWEV6Qk1UV0hOWVcrTlZheHBUWjd6WEoyY29kazAyUXM0NzBI?=
 =?utf-8?B?V1FibDJJTlZTbXJIUkFFdDAzWjYyVWYyREVGajBTYmlwcEttQk9RaFBQVklq?=
 =?utf-8?B?bmRHeFBzSC9SQXpHN2xBdnRmSVRudENTR1dzY1lSNzFLZkZoY1g3NTBHT0xO?=
 =?utf-8?B?TUZqcVFaSS92a2Y5WHVhS2F4VmZMSTB5d2pSZG9jUkcveU8wWU4zZzJuTCtQ?=
 =?utf-8?B?ODdOa1lQUm1JV3RFUTVxQ3NTTlJDeDQyYk1qTXg3WFVGNU1DNDlpMWdTeHV3?=
 =?utf-8?B?MGw2ODV3KzVBUjFWVEE0V0NXcE9IYmNlRE1qNXZlTlJJTmRmakVtaHY1SFZH?=
 =?utf-8?B?TjdKSmxTRTBOc1BzcEZnUC9WdndQZzUvdFkxS25LbForT0RJMExKUFQ0RC9x?=
 =?utf-8?B?THBpcktBWndTUk51Ykl4SmZWbnpIT3Fja0wyYi8yalZYRCtjRDFJNFowK3lI?=
 =?utf-8?B?Z0d4Q3QrLzM3SWhqdmFjU1FCR0tZRi9WVUJlbzdYYVVUaHFod0FkaUQvRHZl?=
 =?utf-8?B?eHZjVkI2S1BhUEVhY1NhWjU5VzdRckcwbFdDczJaeHp2MVpHS1NpQ0o3UTg4?=
 =?utf-8?B?cGVHd1ljNXdIUTlMemNLYXVFbmMvb2ZMM3AwWCtKVWx6WDNnRThLRGN5NWEx?=
 =?utf-8?B?NDFJTDNEVERFeVVaU3hBSS9SbGxHWXhibjl2aTBGbk8wYWcwYVN0VGhMcmFS?=
 =?utf-8?B?eXB5QXpsbGNoemI3L3VVOGxxdDhuS3RMNWRQK0JPeXd4eEp3UU1neTFRWVhY?=
 =?utf-8?B?RWx3TURWQWlaZGVDWUVnS01TYzM2cEh4UnFrUVpiS3JHaUNxZE41YmVmRlZ6?=
 =?utf-8?B?MWoyR3NINkxhekxSSXgxZk9Nc3RWUDNaRWdzR0ttL0hib2RlZUt4RmRXTmNy?=
 =?utf-8?B?V05iYkxsNjd5dmpvRWxvSWJESGJ0TDE2NWNxVlo3cnExbTlzN3RiVHRmV2ZS?=
 =?utf-8?B?ZjVKbHY2dXl4NnVmTEoyY21Lb2ZTaS9CRkpTdEQyRTdoTE4xaU9ObnNDRGNV?=
 =?utf-8?B?ZElENFVjUFd5Z2x3Ny9KdnlQSm9pcE5EeVY1OEZPY0NqSmQyWTVubjJTc2ND?=
 =?utf-8?B?VXg3aUNINnJQZkV0L1RuN282aitUREVibzFKMVBlc0NUd3hnSiszUkhPUUVz?=
 =?utf-8?B?QlUzVmtpSjB0bTJvdENZYkN2RS9JOE5YLzBaWDR4cWpmZUN1RXdIc0ZkNmI2?=
 =?utf-8?Q?bX37ExGwT4y2P+dvI/8QI8cEwIXJEURL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWV0TTlHdzFoNng4M1lCRHUrQmI5SFAxc3ZQb1h3dWFJd1VLK0FrRk5LTjVJ?=
 =?utf-8?B?QlB3dXowcDIrMXg3b2Y2cnhVdks5d0JBL2ZwOUlRd0V4RzA4RkI2S0lhazBV?=
 =?utf-8?B?ZkJBKzdrL0k5bWFJZGVITmphSWZVTzJsMDRBaXUveThrL1dOcGZQV3ZlbXF5?=
 =?utf-8?B?WUQ2RUVPSFdETU9oWlRBTVc3dVJRQkRQWnpJaHhJOG1LZGdTSXFvMDQ4L1BC?=
 =?utf-8?B?Z0lTMHp1a2hBTW5EWUdSS0wybUhyL3JOSzdSTk5PNldia0EwL3Z5RHVDcW8v?=
 =?utf-8?B?K05FaFRkMm5PajlMVlpUTHBsTGlmcmVpbzBnV3hLck5wRXA1TUxFWUF6VHFP?=
 =?utf-8?B?dHNPUVFJZUZLcTZkM1ZCWHM0N1NzeFpncVp0cUI2QWpSdmFmdjFnWWRDQ3gy?=
 =?utf-8?B?QjZtS2pNdU45ejMzTnl6MGZ4NC9TQWZBcUx0TTkzVytHVWY1SlBQeUF3T1lN?=
 =?utf-8?B?MUk5ZWpycUhHTlcrcmliKzdPdis3NFVYcENnRXYrUklvOElqMGFTU0N1bm1J?=
 =?utf-8?B?dXV6eVByaEtRdkNENmYxelMweGYxQW5yWnhNU3djNzE5QkorT25od0xqOGp1?=
 =?utf-8?B?WjRyRXF6RVd4ODgxTGkzNWFmanFsZnNTV1ZLWjJTSlBOMVVickpyaU5SQU9I?=
 =?utf-8?B?eVpDN1JwRDJ3M2Rwc2E2cUNhZ3BCRkQveDNVRkNGQVVKY0dOT2pGRjZLK0dD?=
 =?utf-8?B?WTdRajM2TU55M3kvK24xczhrY3BsWXNFc2NUeTlNSU1qZlFISTFHNlV3dVRa?=
 =?utf-8?B?am1DQlpWd1dCVmEwcUdaMGc2RW1JUndxaGd1UWJuUVVqTm9oS1BkSXY1ZSs2?=
 =?utf-8?B?aW4vN1JnRGJqUEJhMUtxd2V6S1BHdHY0VHhFdkRjV2J2alg1YmZJMlFCZUJY?=
 =?utf-8?B?OGRkNWpCbzd1RjhxY1huNUQxbU5Cem8vOTUwMExBRTFoL3ZJNXR5eUR1MDhy?=
 =?utf-8?B?UXdvZFZaVFJ2a1NLOVdkd243NUZHRFArVmtaQVRpNFNIOUd2WkVpL1d0VXhz?=
 =?utf-8?B?L0VNR2NrU1lmdVpPakRPbFBYL0I2N1FnT3ZrMEg2Q3BZYlRPNjVMWmdxeEU3?=
 =?utf-8?B?SlFlWU96NlpObnNHVXhnS0RCWjNoRHg2bldtT2RwNittTmZvTXloekVsekkz?=
 =?utf-8?B?QVprRGFwYVFabEJMNm1IUVBjVEcwcFZxd0d4YmRFdEg5NmJQVWQ5RDJuRStJ?=
 =?utf-8?B?bFQ3d2sxZFpCSmJKZzBNMnhmTUVwb0ZjUXQ1QllzQ2ljamtuaVFhTlFKdDhT?=
 =?utf-8?B?R2xZRndZSzBxTHV2eVRLQ2tXVnpqTHpsZE9PMmx0RjZQNndtQ3l3OFZLd1Vo?=
 =?utf-8?B?UFFybzNmLzZkK3pkNHpPTFgvOE5TNEFLYXdqZzlua0NiUVVXOWp6cTZSTE9i?=
 =?utf-8?B?eXJ2WHNWay82ZDlGL3o2dEFTTmNKMWlZOGpJNFpCRW0wNjBLVnVIWkhBN1dp?=
 =?utf-8?B?OEh2YTRSRFdETERCZCtmMlRFWTE1aUdoYTdUUUJHVXl1L0RaUnJYWUU2VmM1?=
 =?utf-8?B?bWs5SEdGN09DL3lLVzBTdmtsUkRhQlVOcDY5UzNwKzNvRjNuVjJOQVRkM0FZ?=
 =?utf-8?B?QVMwQ09GY2pqTklOVlU4SFBDY1g2UWEvWHVGMnhjbTVTc2xsNlJJUVQyTG9R?=
 =?utf-8?B?b3lnSkRXd3hpWUl1bVNJV3NjNGp3dzRUdnoyVTJrWnF5SHFiVWY5MnBGV0Ix?=
 =?utf-8?B?VzZrSUlkSzBGMzNpVGpNVnVoZWwyU2s5TkFVRDlQL0N6SWFaU3p6N3YrSjMw?=
 =?utf-8?B?RDIwdkNiWFduODRyR2ZHWTdNTWZrd1J4Uzd4VE9BRGgxVkdqd3BCVmxEdTE4?=
 =?utf-8?B?dFlxdENxdGo5RTZyL045VWJYOUtxKythdXZYUUZHdythdThiRHBGYTFhWlFT?=
 =?utf-8?B?UHFhMGFlR3k5dHFhR0dSZ1lOR0J3WlR6SmYxb1FCZEFTVkYxKy9pRnNJY0Rm?=
 =?utf-8?B?dFpCOVBIYm5jOG9SVTdDbUs0dmI4YU9Lejg4ekVyOGJ3Ykg0bHMvM2I0b1ZH?=
 =?utf-8?B?YTkvRkhTZnhLUmFkNkJLN09aanJha0kzMlNtd0J2Q1lsemJwTmJLdEs2UnUy?=
 =?utf-8?B?Mnl1cGtCVTFCRGltNlE5NUUvVTlvMmxoTnp5U0wrS2Y3WXN3TUF0WWNCNzJr?=
 =?utf-8?B?M3dTUVBtb0dIdXlkTm1tQUlkTW1QczFrRXlmYnhXTWpaYmVOYzNtL3dxVmd6?=
 =?utf-8?B?RXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9d7bb6-ccd4-435f-e058-08dd652acb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 08:07:42.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtMrFR/tD9NulYg1jrWYHMr/rmyaoiKvzFi9i3z8OisQU4GeygweZ0f9WqB3d3R5XC2H1pI119Ru2Au6k1on69WWJ6FqYt8AmJZVZeln/Pidv8Vf4XB82T2MD7DpgC1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDEyIE1hcmNoIDIw
MjUgMTA6MzENCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5r
b3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtidWcgcmVwb3J0XSB3aWZpOiBpd2x3aWZpOiBhZGQgaXdsbWxkIHN1Yi1k
cml2ZXINCj4gDQo+IEhlbGxvIE1pcmkgS29yZW5ibGl0LA0KPiANCj4gQ29tbWl0IGQxZTg3OWVj
NjAwZiAoIndpZmk6IGl3bHdpZmk6IGFkZCBpd2xtbGQgc3ViLWRyaXZlciIpIGZyb20gRmViIDE2
LCAyMDI1DQo+IChsaW51eC1uZXh0KSwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBTbWF0Y2ggc3Rh
dGljIGNoZWNrZXINCj4gd2FybmluZzoNCj4gDQo+IAlkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9kMy5jOjE5NzgNCj4gaXdsX21sZF93b3dsYW5fcmVzdW1lKCkNCj4gCWVy
cm9yOiB1bmluaXRpYWxpemVkIHN5bWJvbCAna2VlcF9jb25uZWN0aW9uJy4NCj4gDQo+IGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2QzLmMNCj4gICAgIDE4ODQgaW50IGl3
bF9tbGRfd293bGFuX3Jlc3VtZShzdHJ1Y3QgaXdsX21sZCAqbWxkKQ0KPiAgICAgMTg4NSB7DQo+
ICAgICAxODg2ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV92aWYgKmJzc192aWY7DQo+ICAgICAx
ODg3ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9ic3NfY29uZiAqbGlua19jb25mOw0KPiAgICAg
MTg4OCAgICAgICAgIHN0cnVjdCBpd2xfbWxkX25ldGRldGVjdF9yZXMgbmV0ZGV0ZWN0X3JlczsN
Cj4gICAgIDE4ODkgICAgICAgICBzdHJ1Y3QgaXdsX21sZF9yZXN1bWVfZGF0YSByZXN1bWVfZGF0
YSA9IHsNCj4gICAgIDE4OTAgICAgICAgICAgICAgICAgIC5ub3RpZnNfZXhwZWN0ZWQgPQ0KPiAg
ICAgMTg5MSAgICAgICAgICAgICAgICAgICAgICAgICBJV0xfRDNfTk9USUZfV09XTEFOX0lORk8g
fA0KPiAgICAgMTg5MiAgICAgICAgICAgICAgICAgICAgICAgICBJV0xfRDNfTk9USUZfRDNfRU5E
X05PVElGLA0KPiAgICAgMTg5MyAgICAgICAgICAgICAgICAgLm5ldGRldGVjdF9yZXMgPSAmbmV0
ZGV0ZWN0X3JlcywNCj4gICAgIDE4OTQgICAgICAgICB9Ow0KPiAgICAgMTg5NSAgICAgICAgIGlu
dCBsaW5rX2lkOw0KPiAgICAgMTg5NiAgICAgICAgIGludCByZXQ7DQo+ICAgICAxODk3ICAgICAg
ICAgYm9vbCBmd19lcnIgPSBmYWxzZTsNCj4gICAgIDE4OTggICAgICAgICBib29sIGtlZXBfY29u
bmVjdGlvbjsNCj4gICAgIDE4OTkNCj4gICAgIDE5MDAgICAgICAgICBsb2NrZGVwX2Fzc2VydF93
aXBoeShtbGQtPndpcGh5KTsNCj4gICAgIDE5MDENCj4gICAgIDE5MDIgICAgICAgICBJV0xfREVC
VUdfV09XTEFOKG1sZCwgIlN0YXJ0aW5nIHRoZSB3b3dsYW4gcmVzdW1lIGZsb3dcbiIpOw0KPiAg
ICAgMTkwMw0KPiAgICAgMTkwNCAgICAgICAgIG1sZC0+dHJhbnMtPnN5c3RlbV9wbV9tb2RlID0g
SVdMX1BMQVRfUE1fTU9ERV9ESVNBQkxFRDsNCj4gICAgIDE5MDUgICAgICAgICBpZiAoIW1sZC0+
Zndfc3RhdHVzLmluX2QzKSB7DQo+ICAgICAxOTA2ICAgICAgICAgICAgICAgICBJV0xfREVCVUdf
V09XTEFOKG1sZCwNCj4gICAgIDE5MDcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IkRldmljZV9wb3dlcmVkX29mZigpIHdhcyBjYWxsZWQgZHVyaW5nIHdvd2xhblxuIik7DQo+ICAg
ICAxOTA4ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgIDE5MDkgICAgICAgICB9DQo+
ICAgICAxOTEwDQo+ICAgICAxOTExICAgICAgICAgbWxkLT5md19zdGF0dXMuaW5fZDMgPSBmYWxz
ZTsNCj4gICAgIDE5MTIgICAgICAgICBtbGQtPnNjYW4ubGFzdF9zdGFydF90aW1lX2ppZmZpZXMg
PSBqaWZmaWVzOw0KPiAgICAgMTkxMw0KPiAgICAgMTkxNCAgICAgICAgIGJzc192aWYgPSBpd2xf
bWxkX2dldF9ic3NfdmlmKG1sZCk7DQo+ICAgICAxOTE1ICAgICAgICAgaWYgKFdBUk5fT04oIWJz
c192aWYpKQ0KPiAgICAgMTkxNiAgICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ICAgICAxOTE3
DQo+ICAgICAxOTE4ICAgICAgICAgLyogV2UgY2FuJ3QgaGF2ZSBzZXZlcmFsIGxpbmtzIHVwb24g
d293bGFuIGVudHJ5LA0KPiAgICAgMTkxOSAgICAgICAgICAqIHRoaXMgaXMgZW5mb3JjZWQgaW4g
dGhlIHN1c3BlbmQgZmxvdy4NCj4gICAgIDE5MjAgICAgICAgICAgKi8NCj4gICAgIDE5MjEgICAg
ICAgICBXQVJOX09OKGh3ZWlnaHQxNihic3NfdmlmLT5hY3RpdmVfbGlua3MpID4gMSk7DQo+ICAg
ICAxOTIyICAgICAgICAgbGlua19pZCA9IGJzc192aWYtPmFjdGl2ZV9saW5rcyA/IF9fZmZzKGJz
c192aWYtPmFjdGl2ZV9saW5rcykgOiAwOw0KPiAgICAgMTkyMyAgICAgICAgIGxpbmtfY29uZiA9
IGxpbmtfY29uZl9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoYnNzX3ZpZiwgbGlua19pZCk7DQo+ICAg
ICAxOTI0DQo+ICAgICAxOTI1ICAgICAgICAgaWYgKFdBUk5fT04oIWxpbmtfY29uZikpDQo+ICAg
ICAxOTI2ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgIDE5MjcNCj4gICAgIDE5Mjgg
ICAgICAgICBpd2xfZndfZGJnX3JlYWRfZDNfZGVidWdfZGF0YSgmbWxkLT5md3J0KTsNCj4gICAg
IDE5MjkNCj4gICAgIDE5MzAgICAgICAgICBpZiAoaXdsX21sZF9md19uZWVkc19yZXN0YXJ0KG1s
ZCwgYnNzX3ZpZikpIHsNCj4gICAgIDE5MzEgICAgICAgICAgICAgICAgIGZ3X2VyciA9IHRydWU7
DQo+ICAgICAxOTMyICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgIDE5MzMgICAgICAg
ICB9DQo+ICAgICAxOTM0DQo+ICAgICAxOTM1ICAgICAgICAgcmVzdW1lX2RhdGEud293bGFuX3N0
YXR1cyA9DQo+IGt6YWxsb2Moc2l6ZW9mKCpyZXN1bWVfZGF0YS53b3dsYW5fc3RhdHVzKSwNCj4g
ICAgIDE5MzYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBf
S0VSTkVMKTsNCj4gICAgIDE5MzcgICAgICAgICBpZiAoIXJlc3VtZV9kYXRhLndvd2xhbl9zdGF0
dXMpDQo+ICAgICAxOTM4ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAxOTM5DQo+
ICAgICAxOTQwICAgICAgICAgaWYgKG1sZC0+bmV0ZGV0ZWN0KQ0KPiAgICAgMTk0MSAgICAgICAg
ICAgICAgICAgcmVzdW1lX2RhdGEubm90aWZzX2V4cGVjdGVkIHw9IElXTF9EM19ORF9NQVRDSF9J
TkZPOw0KPiAgICAgMTk0Mg0KPiAgICAgMTk0MyAgICAgICAgIHJldCA9IGl3bF9tbGRfd2FpdF9k
M19ub3RpZihtbGQsICZyZXN1bWVfZGF0YSwgdHJ1ZSk7DQo+ICAgICAxOTQ0ICAgICAgICAgaWYg
KHJldCkgew0KPiAgICAgMTk0NSAgICAgICAgICAgICAgICAgSVdMX0VSUihtbGQsICJDb3VsZG4n
dCBnZXQgdGhlIGQzIG5vdGlmcyAlZFxuIiwgcmV0KTsNCj4gICAgIDE5NDYgICAgICAgICAgICAg
ICAgIGZ3X2VyciA9IHRydWU7DQo+ICAgICAxOTQ3ICAgICAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4gICAgIDE5NDggICAgICAgICB9DQo+ICAgICAxOTQ5DQo+ICAgICAxOTUwICAgICAgICAgaWYg
KHJlc3VtZV9kYXRhLmQzX2VuZF9mbGFncyAmIElXTF9EMEkzX1JFU0VUX1JFUVVJUkUpIHsNCj4g
ICAgIDE5NTEgICAgICAgICAgICAgICAgIG1sZC0+Zndfc3RhdHVzLmluX2h3X3Jlc3RhcnQgPSB0
cnVlOw0KPiAgICAgMTk1MiAgICAgICAgICAgICAgICAgZ290byBwcm9jZXNzX3dha2V1cF9yZXN1
bHRzOw0KPiAgICAgMTk1MyAgICAgICAgIH0NCj4gICAgIDE5NTQNCj4gICAgIDE5NTUgICAgICAg
ICBpd2xfbWxkX3VwZGF0ZV9jaGFuZ2VkX3JlZ2RvbWFpbihtbGQpOw0KPiAgICAgMTk1NiAgICAg
ICAgIGl3bF9tbGRfdXBkYXRlX21hY19wb3dlcihtbGQsIGJzc192aWYsIGZhbHNlKTsNCj4gICAg
IDE5NTcgICAgICAgICBpd2xfbWxkX2VuYWJsZV9iZWFjb25fZmlsdGVyKG1sZCwgbGlua19jb25m
LCBmYWxzZSk7DQo+ICAgICAxOTU4ICAgICAgICAgaXdsX21sZF91cGRhdGVfZGV2aWNlX3Bvd2Vy
KG1sZCwgZmFsc2UpOw0KPiAgICAgMTk1OQ0KPiAgICAgMTk2MCAgICAgICAgIGlmIChtbGQtPm5l
dGRldGVjdCkNCj4gICAgIDE5NjEgICAgICAgICAgICAgICAgIHJldCA9IGl3bF9tbGRfc2Nhbl9z
dG9wKG1sZCwgSVdMX01MRF9TQ0FOX05FVERFVEVDVCwNCj4gZmFsc2UpOw0KPiAgICAgMTk2Mg0K
PiAgICAgMTk2MyAgcHJvY2Vzc193YWtldXBfcmVzdWx0czoNCj4gICAgIDE5NjQgICAgICAgICBp
ZiAobWxkLT5uZXRkZXRlY3QpIHsNCj4gICAgIDE5NjUgICAgICAgICAgICAgICAgIGl3bF9tbGRf
cHJvY2Vzc19uZXRkZXRlY3RfcmVzKG1sZCwgYnNzX3ZpZiwgJnJlc3VtZV9kYXRhKTsNCj4gICAg
IDE5NjYgICAgICAgICAgICAgICAgIG1sZC0+bmV0ZGV0ZWN0ID0gZmFsc2U7DQo+IA0KPiBtbGQt
Pm5ldGRldGVjdCBpcyBmYWxzZSBidXQga2VlcF9jb25uZWN0aW9uIGlzIHVuaW5pdGlhbGl6ZWQu
DQo+IA0KPiAgICAgMTk2NyAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAxOTY4ICAgICAgICAgICAg
ICAgICBrZWVwX2Nvbm5lY3Rpb24gPQ0KPiAgICAgMTk2OSAgICAgICAgICAgICAgICAgICAgICAg
ICBpd2xfbWxkX3Byb2Nlc3Nfd293bGFuX3N0YXR1cyhtbGQsIGJzc192aWYsDQo+ICAgICAxOTcw
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
c3VtZV9kYXRhLndvd2xhbl9zdGF0dXMpOw0KPiAgICAgMTk3MQ0KPiAgICAgMTk3MiAgICAgICAg
ICAgICAgICAgLyogRU1MU1Igc3RhdGUgd2lsbCBiZSBjbGVhcmVkIGlmIHRoZSBjb25uZWN0aW9u
IGlzIG5vdCBrZXB0ICovDQo+ICAgICAxOTczICAgICAgICAgICAgICAgICBpZiAoa2VlcF9jb25u
ZWN0aW9uKQ0KPiAgICAgMTk3NCAgICAgICAgICAgICAgICAgICAgICAgICBpd2xfbWxkX3VuYmxv
Y2tfZW1sc3IobWxkLCBic3NfdmlmLA0KPiAgICAgMTk3NSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSVdMX01MRF9FTUxTUl9CTE9DS0VEX1dPV0xBTik7DQo+
ICAgICAxOTc2ICAgICAgICAgfQ0KPiAgICAgMTk3Nw0KPiAtLT4gMTk3OCAgICAgICAgIGlmICgh
bWxkLT5uZXRkZXRlY3QgJiYgIWtlZXBfY29ubmVjdGlvbikNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl4gVW5pbml0aWFsaXplZA0KPiAN
Cj4gICAgIDE5NzkgICAgICAgICAgICAgICAgIGllZWU4MDIxMV9yZXN1bWVfZGlzY29ubmVjdChi
c3NfdmlmKTsNCj4gICAgIDE5ODANCj4gICAgIDE5ODEgICAgICAgICBnb3RvIG91dDsNCj4gICAg
IDE5ODINCj4gICAgIDE5ODMgIGVycjoNCj4gICAgIDE5ODQgICAgICAgICBpZiAoZndfZXJyKSB7
DQo+ICAgICAxOTg1ICAgICAgICAgICAgICAgICBtbGQtPnRyYW5zLT5zdGF0ZSA9IElXTF9UUkFO
U19OT19GVzsNCj4gICAgIDE5ODYgICAgICAgICAgICAgICAgIHNldF9iaXQoU1RBVFVTX0ZXX0VS
Uk9SLCAmbWxkLT50cmFucy0+c3RhdHVzKTsNCj4gICAgIDE5ODcgICAgICAgICB9DQo+ICAgICAx
OTg4DQo+ICAgICAxOTg5ICAgICAgICAgbWxkLT5md19zdGF0dXMuaW5faHdfcmVzdGFydCA9IHRy
dWU7DQo+ICAgICAxOTkwICAgICAgICAgcmV0ID0gMTsNCj4gICAgIDE5OTEgIG91dDoNCj4gICAg
IDE5OTIgICAgICAgICBpZiAocmVzdW1lX2RhdGEud293bGFuX3N0YXR1cykgew0KPiAgICAgMTk5
MyAgICAgICAgICAgICAgICAga2ZyZWUocmVzdW1lX2RhdGEud293bGFuX3N0YXR1cy0+d2FrZV9w
YWNrZXQpOw0KPiAgICAgMTk5NCAgICAgICAgICAgICAgICAga2ZyZWUocmVzdW1lX2RhdGEud293
bGFuX3N0YXR1cyk7DQo+ICAgICAxOTk1ICAgICAgICAgfQ0KPiAgICAgMTk5Ng0KPiAgICAgMTk5
NyAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAxOTk4IH0NCj4gDQo+IHJlZ2FyZHMsDQo+IGRh
biBjYXJwZW50ZXINCg0KVGhhbmtzIGZvciB0aGUgcmVwb3J0LCBEYW4hDQpXaWxsIHNlbmQgYSBm
aXggc29vbg0KDQpNaXJpDQo=

