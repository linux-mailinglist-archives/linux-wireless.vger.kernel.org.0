Return-Path: <linux-wireless+bounces-23522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDEAC9DD3
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jun 2025 07:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76EA1897D20
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jun 2025 05:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB82A8C1;
	Sun,  1 Jun 2025 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZJJK1qm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7917BB6
	for <linux-wireless@vger.kernel.org>; Sun,  1 Jun 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748756790; cv=fail; b=QPZAsA3PpNTOpNdOknU2p8wsEh0Il/TUIKBGWv30JlO6ZOh0aUK9i6uM0tR3vI2rQpkjzW+wn2RbYgOtFirvLRNfj5I0BEUbJadwf2DQXni6RwYRSYFA6i44wgcs2Ce/hys8wYXUjsx5aPHZsviJtcNMooojW0TeGT8ulzn+fAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748756790; c=relaxed/simple;
	bh=aeRZKgYNsBfC3St7STS6DPBwSdL/1V3G9tsIlN5pLr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pq9q3kiIPFb2RBaRnOxRyE2NTzEyj1M5kuCiA7HyS4QsTU7EqVjFJjnx9fxtZXsYwAV9ERaLqSAgCKCIS3EsGOAylDubBxmSjTZ98DNXA7RSM5RRoriWr4HRy/UnSCcbsAWkm/wH1v4WagjwSqHFifqpu9ciCLlNt7nxLaUbDlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZJJK1qm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748756789; x=1780292789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aeRZKgYNsBfC3St7STS6DPBwSdL/1V3G9tsIlN5pLr4=;
  b=NZJJK1qmYfDMpLKUUsVDSmki3MeD+h7qtYxsj2QtXeT/Rhc8ZHZTtBsQ
   ltQbHZPmWKnO29a/lRC9QXR2U6ZbsMOQeVbRtmrLmX9XfvFn5PkoSfr0h
   4M84gmPh64dQ3pNZhHn7FjxvNgKa5h/zcmr05slTmXHnyPSWxgCAB+Ohm
   alGogvYvdciOiyiuGPD+3wZNJB7IqyOdJqT3i1AD4+72Dal43lcCtdg9h
   LYSi1/4qVeRRS3nshh5sixJPuWBj/f6zmktxb2o1BmIhBJTr6/OECr2sk
   fm+SPkkTowYDLKlHyxvIAO6WHNy9DeVak2x08TAupE7IzBZmagCVxC5Di
   Q==;
X-CSE-ConnectionGUID: EjNIg0GbQgelaGfx3MmWEQ==
X-CSE-MsgGUID: WzIUh8n/Rs2KC3PUnrfhTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="62149695"
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="62149695"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 22:46:28 -0700
X-CSE-ConnectionGUID: Yd2C5nm0RzOK776g0aVMJA==
X-CSE-MsgGUID: x3ttcOI+R1mvq3klFpCqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="144145617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 22:46:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 31 May 2025 22:46:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 31 May 2025 22:46:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.43)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 31 May 2025 22:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etQMi9nXAwAFNRkpSywuHYa5WvIHC3booLPq0QWxIaecSddVd1lJKQ16vU/V6KauhOWVPNYX/jU+bwX66wMMfeMHHlplkBelQrThJDBcTjNlAMGwEzB7dyo1DzP7fCuTncrgiYLIMgFHo4ntXaVViGlV0p1N0gEpfsmEZZC7JZgdtnk0EOVvTlPOHCs6iA6d/k81L3p1TRk8uyAQ8EtOBLfADmoklWI+MzAvT/XcGe1cQ0o3QhEkDrT33DezMgFdFSJDoAgL35zi6PTzL/uw8NCtWPzRVLK6NyJ3zS0q+stPYzksvQnBlGXaMWLpIVM/337mlN3AiBJIE3D/79D8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeRZKgYNsBfC3St7STS6DPBwSdL/1V3G9tsIlN5pLr4=;
 b=OwT8PnUIVdSSVy1jeJy+GqLma7vjoO1Mn24wM3qvHhNbR7v66b8Id0XOR3Q0PQZe0XkcwPLvQ8ibHc0CogCfx8vAOXe/T9dc1ICuiI54Kk89WQJ3OEIbKePpWDbeZuIo/x3s9oxK7M+IJgZ3y4OjzUUH/1mz4NY/OKlVTq/t56+enqxgPG+dF4lIa3uLTbGzRPpJYp+zPVm1Q8957+n6gkR1Iu0I7pd3lqgjhJPEMbFUmV/V1aLHYmruHaZUy+xXfKPTamVaH+0op9JeLD0EPoLxXA/a84Z3iKydkFOhKPL215XXonUtIu9gjIqC/uplqoBSUcvkeePXROi6y0iWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF44E8B88DF.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::825) by MW4PR11MB5821.namprd11.prod.outlook.com
 (2603:10b6:303:184::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 1 Jun
 2025 05:46:24 +0000
Received: from SJ5PPF44E8B88DF.namprd11.prod.outlook.com
 ([fe80::a1de:85d8:ffa8:530c]) by SJ5PPF44E8B88DF.namprd11.prod.outlook.com
 ([fe80::a1de:85d8:ffa8:530c%3]) with mapi id 15.20.8769.029; Sun, 1 Jun 2025
 05:46:24 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAA+5CgIAAEYCAgTXmVgCAABwWAIAAhkMAgAAyHoCAARv7gIAAEiMAgAByH4CAZbIzgIAAjByA
Date: Sun, 1 Jun 2025 05:46:24 +0000
Message-ID: <0bfeda4daa039465e128a2eb375f09b585f47182.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
	 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
	 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
	 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
	 <Z-SdYIm_lDvmCcO-@debian.local>
	 <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
	 <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
	 <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com>
	 <d3f5b6aea39528ab7647e69f66fa90b26623a543.camel@intel.com>
	 <CAP-bSRb_PeuFMqOjJu=akYsYANQ2ek8N1oR=8RiPXBeefM5_NA@mail.gmail.com>
In-Reply-To: <CAP-bSRb_PeuFMqOjJu=akYsYANQ2ek8N1oR=8RiPXBeefM5_NA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-1.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF44E8B88DF:EE_|MW4PR11MB5821:EE_
x-ms-office365-filtering-correlation-id: 7f726e98-d747-4f07-a981-08dda0cfa500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MldMVVZ4d0JHQ3BiTnRZSzdibHN0d2hKVENWZk5TVUVRMk1GRjJlMmlwci8z?=
 =?utf-8?B?em81TzZiMnNtd0xyVFpLNTFvOWhVSGo1RGFwKzM0MGtQTVN4UDN1TjVrTThK?=
 =?utf-8?B?bXRJdlFPVm1pQ0sxWEprMDlmVlpmQS9mR1NqTTA4ZGs5aE5PZEd3QXdsTk9J?=
 =?utf-8?B?cllLVmd2ZFhqdTVvR3U2blhpMGFtYWd4MS9CQnJldHdra3NIWDdlWTA1R09a?=
 =?utf-8?B?YlNNcmRYb1hQNnJCTU5uZ1JaLzRld2R4RFRlbE05T09SQjFNTExORTczSzNH?=
 =?utf-8?B?S2tUWElIUjBTbmtZZzhBSkJzZDNncmZKd0p5NFJMOGRtbmxHME5KZDBEMXZz?=
 =?utf-8?B?K3ZKdVlpVmJOTGdpVVAva2VwNUJWNlBuSFVHZ1RIcDcxL0RZVjcwKzJUb2hl?=
 =?utf-8?B?a0FzampNbjNINGpjZ2ZCZC85UmhURElBV3hjdjhsWk55YVBwYmhYUkNoZlRM?=
 =?utf-8?B?MHlLUXF3NFRNbGo0YVc5Lysvc2h6akhpWHh0cU5uNndLNU5vU3R6VG5wYjky?=
 =?utf-8?B?M0wxa0pZRnJLVVZ0bkRiNm1OanJlWXlWNEpobGJ4enRlMGJnOXhGd2RNU1hJ?=
 =?utf-8?B?NHA3UzdYb1paMW12NUJVV2xwUHovanJqWVEvQnlWeHg4dzA0a3ZucEJjaUVK?=
 =?utf-8?B?V2JscnoyS1NleFNORUVleit1ZXRzSXpZYWVUbjI1aVZybm5kZ1NKWXJHRXk5?=
 =?utf-8?B?bWo5bUhEbHdSRzZnaXcxdHYwOXpsakhQb0pvNGFtaUM5OFFlbW1oZGFpV0tm?=
 =?utf-8?B?Wk9qbUthNUM1L09BYjMwUE1lbWtLNW1KM0NPbDVmaEI4SnVFTXVWMWc0VGhK?=
 =?utf-8?B?WDduMldHa1YyaCtSWnc2MzlDd25LYzFaamVDYmI4KzlnUC9OTDB3b2RhOHc1?=
 =?utf-8?B?aWFaRGkrTDlDd2ZZVkhlNFBGS0pndjdINEFsQ3RmMGliNlZzYkVZM0RFMEMy?=
 =?utf-8?B?d3pHcUpxTGNrL0Y2UlhocThsWFNxWmNJQVJSY1dkTHp0RFUrL2sydmNlbXNN?=
 =?utf-8?B?ZXFyb1BHeDhKaEwzYVd5b1hyZGxTdDAyS2dsNG91KzRScVBiKys1SkV3c3Nh?=
 =?utf-8?B?SWQ0SVhSZmxGWm5ydlBQS2ltUjFMTTdsMS80b1ptQTlVSUtrWVI2OTFFN0Jo?=
 =?utf-8?B?dSs1bFRJK2phSDlid0ZMcmV0blMzT05scWFkQTNXUGpxckcvYkZjTklVUkxu?=
 =?utf-8?B?d2VsbDRObU9xQWJFSE9oYVpZUGNybjNob2kzdlZnS3AveXhENWliYmhGU256?=
 =?utf-8?B?OXRvV05ERTZMMmUyUnVEcFl4Uk95dVJHazZ0bnI5VDQrMlpWWGZrc0I5cktx?=
 =?utf-8?B?MS9QMkFHcW9DalNkcURicGR4b1MxT3E2TU5UU0ttUDVKMzNMbmV3L2tORGlR?=
 =?utf-8?B?ZmtKMWU3WTZVY2pnVzB3VXR5a1hPeVV4N1E0VjB2Z1VvVXM1c2ZRWjN3b2JX?=
 =?utf-8?B?VTJOSFQxQzVWdjBmakZDWWVlWEtLMHk4d2VQeE5vM3dKQkVub3JyU0ZWNTBn?=
 =?utf-8?B?R1kvbXNSSnNVZ2pOSDU4TUoyNjlBYmpONzFNd1lLYk1uaEo0ckszazBKbWtY?=
 =?utf-8?B?c3YyVlNmZWZzSkNQcGxXOFhxc1dJamRnaWE0VmZlT1hVSXNaSU1ESlJIUUZP?=
 =?utf-8?B?RHdFbHNkVWZ3dmVDRVR3YnZyeU5KZ0MzeVVoZkZKTnlmOVhrbUxicUNqL3pO?=
 =?utf-8?B?SHhIVGkrMW1JNFN6akJwN3lrczRWYXZWZEhuYU52Z0RMZk9ub29JZWQzbXcy?=
 =?utf-8?B?Y0NXQW5zaEx6eWZKS1NPZjdOTU1XaFNwRW5ORVBYUTZnQ3ZSa1MzdHNjWUhO?=
 =?utf-8?B?UThKeGtOYmdxdFJHWDlHVzR3enptYkwzZlgrejhyRW13SnJXNGwvNGFuQitH?=
 =?utf-8?B?RU1wRWphcHR5bXRoMWIxa0xRUk1hdjhKSXlpUGMwNGd2dm5leFVPTUhsUTNQ?=
 =?utf-8?B?SEJvZ2ZhV1djbFUrU3ljdjgzUTVibDVFbk4wWDRlaElGdUtNR3JmaTlhLzFX?=
 =?utf-8?Q?CrRpecXvgUKvO02JcPtwaDpd2xFdz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF44E8B88DF.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VElpYlovVHlJQmxMbGxaU1hLMWZUZ2ZkK21Nb0pDSFNOOGFoMURYdDVUQVE4?=
 =?utf-8?B?cXBNVFM2UUZjcVZhYkM2TEZBcTRWcnhtbW5lcm1qeGNXdXRwazFVYnI1Y3Bz?=
 =?utf-8?B?eEtzejFmNmRzdDduZEVMcWxZNmR0Vkplakg0cWEyT2dRZlV4YTN3T3A1UUNt?=
 =?utf-8?B?dW90anFERExGTmh1alpkZGxsSzFVS2tINU9IWUNGNnprTHBXLzhRYXJiZkU0?=
 =?utf-8?B?VEIvaTJFL0pQVmJ3ZnVmQTZlOER0K25JemtUWk12OEZIMFkvVjhsZzdEekhF?=
 =?utf-8?B?R3VKTzB6akhvRUZwMkNHbUhTcytiN0Y4dmhoTVExTDkzbkhCL1lPZFBFc0tJ?=
 =?utf-8?B?c21LTzJaKzhtRjFDeTZZSC9LU3FuSWNrYWNnczJKdjd0OC9hZGF3U0Y2cFB3?=
 =?utf-8?B?dk5aK1NObEJPVWFXY3hmMEMrMVpDSVVmSThaMko4RmR3VUY3QWJWd0M3Mm1R?=
 =?utf-8?B?VVJ1TWppbFYvbWZ0cmNCMU5VU000WXFiY0JQUHNySHpkZURwY1orZmhTeXRH?=
 =?utf-8?B?TEcvVDRZajA1by9yVkVCQmU1Unc4dkdoSmZMSFBnUmhhQU13QVVEQ1RTVGFH?=
 =?utf-8?B?enhLb1NneXg5cEtJMEpWY2p4TkhOYXkraG1nMGVzeGl4UXVVNHdPcS9xSmsw?=
 =?utf-8?B?RWVmZFBPdXZlNGVna2NGVHFRTXByQXY4cUJlZTJ6dUwxamt6N1F2RW1JSnpO?=
 =?utf-8?B?aStFbnAvZ1UvUGdEYTdCeXZaZWlkayt2WlZ4VkRwMGJORE1oRFFvZXZ5NWJw?=
 =?utf-8?B?cGZxTlllakZSZEd0ZVJIWER5R08rM1NnN0FLeEt1eG9hYS9DR0ZnSnVOSGZQ?=
 =?utf-8?B?dVkxM1dKT3R5aDkxVG5HRDVkSk9BT25TQlhNKzgwZkdIOVZaZ29wb1JZK0tj?=
 =?utf-8?B?UThyeFNqU1FBUjFpMDZTc2dwS0RIY1Z3Tm1CUDRFMXgrUFRmY3lxOGxpYVNE?=
 =?utf-8?B?RVRoclpyV2N3QnJDNHE4NTJNVEczYno1YVFVYmFpZVVobjVja2laTlJ3ZUFH?=
 =?utf-8?B?VUk4VTRSQmhVQ0xQRmYyMFVNUVNEeGpoZ3RiM3ZCZWhrbXZjaGpiS3FxWllZ?=
 =?utf-8?B?VWV4VkhkdWx1ZEl0bWYxS2xOQ0ViUlVsZ1BYUjdUMCtJdkhBUi9Ua3hlY2d4?=
 =?utf-8?B?NTZPNjcxQUcvQy9Dc2E4b05IZWxNVDlFd1JJa3Q3alRoR2pTbFNwRWQ4RmZD?=
 =?utf-8?B?YkRqMTJjdExId082WGlhcFNmRFlPSk5UVzhRakl1NEVzQm9yOHdJcXhPOFIv?=
 =?utf-8?B?WjlvZGN1NUQvMWp3OXhqZnZDb0FqYUE5dlh1SDZiZG81RVhFVjZLR1d1ejFO?=
 =?utf-8?B?aXRkNjFJNkJ1Tk8zdDNOa0tyc2RkTGFicVd3VTVmSkwwT0tpVnVPL042dUM3?=
 =?utf-8?B?SDlFVjZpT3hsdEpVZlFaY2hEOTYzRFIxMzdYcldDOW1TYkdiU0cvazdHaE4y?=
 =?utf-8?B?bElRVm1SM1kvcXRTc0RoczJOSkJsOXd0QnVrRUU3bUtHcmlmOFVMNU11YXdO?=
 =?utf-8?B?RkRhc0RZWldqR3B2TEFDVEJNVnlzYVgrN21LK2xQSExSTitxSW56Y2wvSWhz?=
 =?utf-8?B?VS85RnFtQW9EM21yQlNzcUFScVM5NzhUakhLNTIyek9vZVZkTWF4T0NoelpS?=
 =?utf-8?B?RGluUkNUcGFGTWFyOUtlaUN6cjhhcjd6RzQyWnJJN0JibGJaelBCeVI3TGNP?=
 =?utf-8?B?WWM3dHlZblg5VVZsV3o4ZG5FK3FxQ3NnV3JBSE1zMERIUGpadG04MDFFNFJX?=
 =?utf-8?B?blo5MHVIWkk5cWNCNlRPS1FlY0FueW0yL1BRQjhhUTY4cVpTdGlydml6U3Zz?=
 =?utf-8?B?TEY5RW1Ca0VoL1B2R3B4Y2ZneHIxbk1QbDZraVovb3l1QStMaU5HOVVGRnZi?=
 =?utf-8?B?d0JHbzdLckc1OXVhdmgyRmNQRmxDNEFrL0VHd1lXeWRtWEFjWnNHWWY5cHU1?=
 =?utf-8?B?QU00VDNaSXBqc003d2dKNi94WkFjd2RNcU4vc1VkdFRLYlJpVmpOUWEzWFls?=
 =?utf-8?B?YUVYNVRaY0YyUGlDS3FHTjBzeUlwYXg5cVMwYk9XQkVnMHhTVzFRTlBEcFpq?=
 =?utf-8?B?ZEptT0ZwekdmZHpBbDVJVUZtaVV1bUZQNHVKM2dKU0VucEdLazh6Y0VRVTlU?=
 =?utf-8?B?RWRrVGFKajh6MU1MOWpFZGVhaUZsT2sxb3IrNnlpSUtoU2xBUkhuSk5oQkJB?=
 =?utf-8?Q?QDJeXXgvyehJxzZBAR0A5vY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4518D2790933C049A8531BBE03C3A095@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF44E8B88DF.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f726e98-d747-4f07-a981-08dda0cfa500
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 05:46:24.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIvF9VGpBNRcKGlkQkIR+ieYjh5HPewTmbIP0mzSHNTc0hoxrZWZ45VrN+cEEQavpysBbuJbZ349qaVv9CCdZ6l/bXmVFJCbDUXvOMtiYSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI1LTA1LTMxIGF0IDIyOjI0ICswMTAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBPbiBGcmksIDI4IE1hciAyMDI1IGF0IDA0OjI0LCBHcnVtYmFjaCwgRW1tYW51ZWwNCj4g
PGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSW4gYW55IGNh
c2UsIHRoZSBwYXRjaCB3aWxsIGJlIHJldmlld2VkIGludGVybmFsbHkgYW5kIGZvbGxvdyBpdHMN
Cj4gPiB3YXkNCj4gPiB1cHN0cmVhbSBmb2xsb3dpbmcgdGhlIHJlZ3VsYXIgcHJvY2Vzcy4NCj4g
DQo+IEhpLCBkaWQgdGhpcyBwYXRjaCBldmVyIGdldCBtZXJnZWQ/IEkgd2FzIGp1c3QgdGVzdGlu
ZyBhbm90aGVyIGlzc3VlDQo+IGFuZA0KPiBub3RpY2VkIHRoYXQgaXdsd2lmaSBzdGlsbCBkdW1w
cyB0aGlzIGVycm9yIG9uIHJlc3VtZSBpbiB0aGUgbGF0ZXN0DQo+IDYuMTUNCj4gbWFpbmxpbmUg
Z2l0IG9uIHRoaXMgcGFydGljdWxhciBsYXB0b3AuDQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTE1
MjIwYTI1NzMxOWZmZTNiZjk1Nzk2MzI2ZGZlMGFhY2RiZWIxYzQNCg0KSXQgaXMgaW5jbHVkZWQg
aW4gNi4xNS4NCg==

