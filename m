Return-Path: <linux-wireless+bounces-20896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF4A73F57
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00293AFFC3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB01A262A;
	Thu, 27 Mar 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqAUM5S5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87E1581E1
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107501; cv=fail; b=ceJWuxDXlq8ysS4KZMGxtpjErEtdF/rmu3hlf+xBNlofUAIHuoSeCBaRWMdneXr5q9N2yWboZ0dmMPiuh5eu1c5TRzKrud3B5hCCvBRtaFJZI4zX78568WXDvYPsUPIiEf5+oLuKcnisW+QUm5y2awkvrh2yhGO4hLgSaxV6Xis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107501; c=relaxed/simple;
	bh=HNh2c6AL8BKqFktDr+7JmNRAa6EqJw5JJXoBeXAci3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVdFhlh7nbhamib4FLPlf592JS1LovmiBU9xhpuhBvlDt60HS746xBPWzUH7kG0PJ/ttrSnpg9LJz2QspBniNYGbIb1bW4gje7M0Tnf6OVjXbeJPHfSXnv5DBaAFpkh3UEyPOrVrwM0ES5eX9Jvb0EluAoY/6yKA/vlzl9cP+Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqAUM5S5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743107499; x=1774643499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=HNh2c6AL8BKqFktDr+7JmNRAa6EqJw5JJXoBeXAci3k=;
  b=VqAUM5S5hBFJbe2AqShPeIqLFJq4Xy2Dq0Cx1GK1l0hPmkYxzT7aj7aL
   WZ/wp0eurDw5/tteY9kX3fs9E6T1Q+lXaqeLguVuDOUzh8R4hEZffy1eN
   QQgsZgCBDdRdOOfGq82pWPMMHU/M0TQj8qqo1Ax4D7J3RKVv5lL1kZlwL
   aVAidwGj9g4YWZluZ9HIlm3oCyFf0m7xflumeR9ciIyAeNgvtr9gSZ1B1
   HLD7omTldKxCKRb9k8wcHrlANLeWwAvw6ZLPnELKEIEU+dkRs3Ru8yH+N
   MvOW4/ogDSBGI+eDP5EtkoVi5+325K24FQOWo39MWnv2PdViNE8Kw0Evv
   w==;
X-CSE-ConnectionGUID: /2vW3Sr6QESgiz2iE5x8cQ==
X-CSE-MsgGUID: LHuKEaPQQ/COKGOdS91F8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48243014"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208,223";a="48243014"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 13:31:39 -0700
X-CSE-ConnectionGUID: QJg6lNdyT7ua0l7jctZkbA==
X-CSE-MsgGUID: t8pMB0aWRw+H0s3ZXn9mYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208,223";a="156184390"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 13:31:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 13:31:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 13:31:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 13:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My2xBrQbGfGItaHzPubB3VCrruesB/39qEVslV6BFA05qhLpnQg2D50I4aC3bIeyXJkrowBHuaAg9h0Fqd5tdFHb++U0emYKN0OFtwB190GFGvZYLexTmKp2Q79IHiH3apDpk214YPHBmbO6pek+CPSlV73Wj/a8mF3mqAxnfBUeX2Js53OcYEngolsTkYvFaKMw7mwGK8ABUndSg94n1WnV7/NJx3dZm6XXVBMMDynKllJd6XV3VroQyYyncuQol02e5RXKGtmZ8V2W3pWhbSQBxAQWBNhPufmfyFUjYORVAmAdWy0IKQ9hcImnOd50l84exj8fw7uLDMaQIeDLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq2+oTdO3Gnm9AZzgOGe6LSwobF6UMm+Wjfj5tH6gRQ=;
 b=wubYhNEjFz0u+hm5wtnSNK1vfOnB0S3odUXTyjITyYgQCNyIqyzprZ9FeKuxaZ161vex26fHYRof+VMLLcYsfeAeD+ChucxZrghR1FoPkA/SXUUh0l3kVFjr24xoYmVGDtV+bIR7Is+gTdKTyjjeR8HI0FhFDMsxfJtJnzMsb2XxdSHMDaUj9+jpB8eJpI0wNHpURRCqgSZKN46sABdyrAbgJPPCVCuPV+mTamFC7UqcpiUMYR2+TaxTuudD3wBPxyBP8LO5YHv68M4poGlzaaw0+fxxubLE5b3iyRODjXuMlrTTZRuT7Fclor4W4YvzNIfftWBztQW7RTiby/dpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 20:31:34 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 20:31:34 +0000
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
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAA+5CgIAAEYCAgTXmVgCAABwWAIAAhkMAgAAyHoCAARv7gA==
Date: Thu, 27 Mar 2025 20:31:34 +0000
Message-ID: <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
		 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
		 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
		 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
		 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
		 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
		 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
		 <Z-SdYIm_lDvmCcO-@debian.local>
	 <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
In-Reply-To: <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|SA2PR11MB5049:EE_
x-ms-office365-filtering-correlation-id: eba7703c-6a65-4c6c-ed59-08dd6d6e5d98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?em1Jb0QzWnBqUk9ScE9RK2RQYXRFSkpOVHZhMWpJZlQ5Y2VvWDI3dHhiZ0kv?=
 =?utf-8?B?c3F4RUhOaWVkRGd2amUwVDlyUnFsRHNyai9HRFI5U3U0RkxDRk1WVjNoN2pI?=
 =?utf-8?B?RDRrcGFBQ0tZblNQUWVWUU9uZ0FQSU1PVm5xUXhNQ3VKM3BHbkd4K0JNSURu?=
 =?utf-8?B?aGF3LzF4TGpGWG44cnd2YWJhby9idXE4Mnk2MTkwakxGM2dUTWxBVWhQWWIv?=
 =?utf-8?B?cXpiWEE1OVFIQ3lQS2hCYW0zcjVNM1kzQUNMSzRVb3NFOFZtOFNOUEtWVERj?=
 =?utf-8?B?WmJIZ0JiWVU3VEwzVzgzTDV5ZDNqMjJXWlZSRXZScmpLSW9vdFlOU0RYMmhT?=
 =?utf-8?B?TlU3dDJMK1hqc3lubCttamdBUHhXT2Mycy9QbXF3ajVjMGNqRDc1SFUwS09P?=
 =?utf-8?B?Q1NOS3F4MTNOYTB6M3p1ekZRd3IxYjFPQXJLOFNxSFR4aU9nUVZsWkFwYTUy?=
 =?utf-8?B?SXQvZWxRR1BoWVBxVkExMFgxZ28wQlp2R3NPdWJpZi8zNE11UUpjajlsdVVC?=
 =?utf-8?B?NWozSHhwVFBtTENuYmIxUmJPT0IvYlFxWThJRTIvUGY5RlZZbllKcFFkd3J3?=
 =?utf-8?B?LzQxNDdoVW5scjJZTG9GSDIxRTRDckpFR0VYUlEycU9HNWg0V3UrNEk1bjRL?=
 =?utf-8?B?TldwU09la1BGRjNBbkFoZEdWVkhKaHpqQ2VYTU5oejFlRlRkS0tZOE9VM053?=
 =?utf-8?B?Zy9RNjJtNktSd255aVUwZTFMUlNnNnB4UnZ3b010Y3hnOHg0Qy9SRGxOaU9F?=
 =?utf-8?B?Q2Z5VVVXblQrZHhYSGxuNytmazh4SzZ1MnZQbFRodFZ4bjdkQTFYeGhLaHgy?=
 =?utf-8?B?M3V5aWVSQndoM004emV2NncyazFPZkVYWEhYOTVGeFlIc1RuNVUraE5GWU0x?=
 =?utf-8?B?NlVhVFkzTjB3TE1idU5uZmQ2V3pxN1ZQTjlGUW5KMGJCeTZ4ZzFSM1JhMnVM?=
 =?utf-8?B?anVZczBKbnQ0MmhNNXNIazFqZGwwNFBEWGtpSlF5a1R1U0ZxNzhYaGNaeHNN?=
 =?utf-8?B?UXJYWmJMeCtUdVo1enZGcWlYUHlIRU52VXlNSWd0NnhXT0VBSTV4VXN2THYw?=
 =?utf-8?B?YWJENnhYd1haK0NQZXpmamFoQlVQdzlINDB1Tms2cDBSUlp1SkRSWG9jVkda?=
 =?utf-8?B?emw5RHlyZWJBbW42aU9aOTVHUnJlNWtLNXJ3U2RuY1EwSnIwYmhnOVRiaVdr?=
 =?utf-8?B?K0pQMUdBYlE1b3dwQ1ZtM3A1RTRldkhPWlhNTTNsS2l0RFFjRUFNUUsrQUJq?=
 =?utf-8?B?cEJQVEg3dFp0WWNQMUlOaXg0WGlkcTVQb0lYKzcrSjNXN3Y3b1h2NjVpKzJV?=
 =?utf-8?B?dWExOFlydUQvNitiZ2FqTjRXTTNLS1lBUFFKdDcxdiswNERYSG55V29aL1lP?=
 =?utf-8?B?cmxwU3g4eFhUOEJlR3FqK2Uzb2lzV2NsZ25BZDFVYnVwZTNpNUxDOXVaOWxX?=
 =?utf-8?B?d3ZERnIrWE1TSzVKNm5OTHozdWFBM050cEVBRUF4YnpDdFlmNEdnQjEzNld2?=
 =?utf-8?B?Yld1T3kvMGlxOHhpT2xSWE12TXpWbktMVGRYSTdzQktjb3V0ZzduMGlhZlpz?=
 =?utf-8?B?T1M4V003bDVya0l6RVIvM1JLU0Fza0ZBREhacXRnMm1UYkNLdWlUVGorTlkw?=
 =?utf-8?B?Uy9yUzZnZW9EeFZtcUZObHZNNWlDQWtMRWtSMThKMHMyZUtHK25TdkVUWXpD?=
 =?utf-8?B?MVgrTHNVdWNSL21WdHYySDl3bHVCNDg1M1EyQ05jLzN5MVNGZXdyOTVsSVlH?=
 =?utf-8?B?MzJ4cEh5c0RhS3dMZ1lXb2VJMG5sQTVlREhuTUhRck5wMlVZb2ozdmNCVjFW?=
 =?utf-8?B?eUQxWU8vb25WY0dvOXBMNFdUL3dIeUNRa3lLNzI3L3pBc09YY3dlNUk4UkJ3?=
 =?utf-8?B?MkFWV1FsaFhMT2lVY2ExWkhUMzhqUXA3Z05MMGRNOE1wRis4K0MyNlZ2UlJS?=
 =?utf-8?B?VkxyblVNdmFYM010M2hqTEFrS1dOblNiSjhWWVUyWlVnUUN1SEJra0pqMHFa?=
 =?utf-8?Q?RVC6B0a8+/VvvHpBjpcovw+NpoDXgA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHBrTlRSbzhyMm5zdnlvYzFCZmQ5eS9hUFpIMTZTbkRSQmNhZzdkWGdWZFlj?=
 =?utf-8?B?Slpya21PYy84SE1QaEt6YzBvWUQ2L2I4NGs3REJwSC9PeGIzMysyMkIzZDFi?=
 =?utf-8?B?dmtlNG82ZHlRV243VHdPOUcvUmRUTENISTIzaUNHMWphYWozWENYbFRuWG9Z?=
 =?utf-8?B?ZmtxbEZ1NVNveDFHMC80eHJFTlFmOTJsVFhHREpFbENkMFRnYXgzMTJnbzE2?=
 =?utf-8?B?VWV6cTE2eVNCaVdKKzRsZlQwSW1DdWRsbC9IYUpJS3JVeTRtN2MxeHh0enhD?=
 =?utf-8?B?NjI1cmt3Ni9WcENPc2E0dm0xVHpXL2E3UlRVRUdQN0oyUGt5Q2ptLzgxN3hl?=
 =?utf-8?B?NEY5NUN1NUptQ3hla2l6aXhFbzZxdHhQcUZoZzcwSXRycEhjQ2cwUWx2a2sy?=
 =?utf-8?B?NE1WYzNFWDJmejllWVFSNFoxdWs4WjFIV2ZEek96WmVrODdWLzRYb0hHNnJJ?=
 =?utf-8?B?d2pTR3ZGT2ZSYkFON1NCdnlrWHdkTGVhUHl0ZjlrSElEVW9oTzNISkNQL2pl?=
 =?utf-8?B?enNtV1E0WlVxbXU5Q2FvN2VGQ1RmRmh0RFhYTG85NEJ1YzRhQXNxVDM2S2x6?=
 =?utf-8?B?dTNJVkVyL2RxNWlKMG5ZTUNFM2labGtSVVMvN3d2U21XUkJablNGYTk2THI0?=
 =?utf-8?B?VmltVDliQ1dqY1lxR3duNXJ3ZGE3TFpqKytibFVSTkJuR0FyM2ZTWm56SG5K?=
 =?utf-8?B?dUFZbHd1Z2hRRVo0aGNPY3h5UTREUjRoNDd1ekdXbTRNYVdQVHRUNXgwdDhF?=
 =?utf-8?B?QjZSM1RXTU1aRG9vcWdBbHRISUY5NndqZzNzS3pnS3RmaEE2NERNWDFhdGc0?=
 =?utf-8?B?cDlmeHJXenBxQ3lIZUl1Y1Z1Y2tFZDJlSmh0UnpteHZoWDR2RDJsdW1aaHM2?=
 =?utf-8?B?YlhSbHRZR3ZRRU1XTnB0aCtOYXZjVmh6ZE9ubSt0dDNXeE80akZrVUtzazht?=
 =?utf-8?B?aDVpa1JMR05iQUJuUlh6d29qd3cvc1F3MEVveWpPNjhmSzlWaFBSK09HSDZj?=
 =?utf-8?B?STM1SGR5Z29yMU5zRExLT3I4M3o5QVlxVmtjNlJ1UHVXSGk2RjlpbEdwVnNQ?=
 =?utf-8?B?VjhEM2R6OFFzWTRLYVQzd2FGYVR5VnhMSk5lcllDV0FMNlowNE4xekxJRWN3?=
 =?utf-8?B?Y3lVVEtLTG1TTlI4dUFqeVlYQ2NCM1hoU0xUNlN1dnVGSlBabTRqSlpMMVZY?=
 =?utf-8?B?ZHU2Nk41dkc2dTFnVnZXQmdkV1VhZWxWNytUc3RaVmk0aU5PVzFuTXBVblRx?=
 =?utf-8?B?MWNwZEFBM3ZOSldEVGswSEdJNmdETDV4YjAybTkwY0EyK0VidDZtY1A0ZXRp?=
 =?utf-8?B?WklscGFPRDNhWlltUkdwa1loallQZDkzM0NHYnp0S2x2MGFSZ01yUkUxRGRN?=
 =?utf-8?B?S1ByNmY3NVhWUUpONGtxZDgrVm5Ya2hRMnkwOXVrWHBjc3l2emhlNzFaWTdV?=
 =?utf-8?B?UDYwOG03R2Era0lRejVqS2VnSG1xV3hRVDZhQnJPVjdOQmM4UzY4NmJOTnY0?=
 =?utf-8?B?d0xaaVgra2hEdzQ5RTlYWlJuczB0MjBWV042VGhMeEhRa1NjODFZY0V3Y0FD?=
 =?utf-8?B?UFdvTWhXNjYybHVncHpJanJaVEJIZ2NBbitUa012cUtQUTAxSEFQUDVlZlNa?=
 =?utf-8?B?ZTh5Q1RsdnBvTVBRZUUzc2MrTWw0UUJCZk9EZGx0Yjl3MzR0WTdQMHA5SHA1?=
 =?utf-8?B?MmxkTkVXU2RyamR2bzQ1SkJiV3RRNkMzaTFCL0hkSjRKSEFFeDd2THZBSDFm?=
 =?utf-8?B?blJ1RWMvVTExakJCK2dRd3pQbTJUZUgzZmFtMDZLT0hjNUdreTVsa2M5QjNH?=
 =?utf-8?B?cGhCVXlOL0FjMjRQbHR1V0g2c004NFZYaU5qcXpZVE1OaHdaMXJVVmgrSTYx?=
 =?utf-8?B?eFd3VjlQUzU3eGNmZG1waGxiL3RiY2JPbWIycVhnRUhVRFkvQTl2U2cyblRW?=
 =?utf-8?B?cGM0K2hSdUsxVVp4N3hFeXhrdVpIb3hqNDRyTkFJWkFHV0Erejdrd1JnUE9Z?=
 =?utf-8?B?MkJIMi9Ub0R5cE5SeDVqUS9GSWkzNnpoU2d3NlVvSmlZVjNtZld2VlN0M0I4?=
 =?utf-8?B?Tzh2NTVpOUZ0Ty9TQWdhVldCdlhoYm1YT0Fwd3NONDVDeVNveXEyTjBCN094?=
 =?utf-8?B?WFV6Zm92azhOT2FObnJJNGhIY3BNVDZnbmxRai9kN2YySXhnUGMzTjJCRUYy?=
 =?utf-8?Q?QG3Hb6D478p4E7YgJfwOJuE=3D?=
Content-Type: multipart/mixed;
	boundary="_002_43c0e4554151e015c068b79b5da7231f8674a474camelintelcom_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba7703c-6a65-4c6c-ed59-08dd6d6e5d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 20:31:34.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /c0jBU7iFo/QQWRDOYesfreSn/jAX0/eCTck7uKZAghuVTDUpX6P/d87WPWtKqn7JmgBiFbp/fE0IoAMMMdL9ALTfCcv12kfw6KC4QtFi6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
X-OriginatorOrg: intel.com

--_002_43c0e4554151e015c068b79b5da7231f8674a474camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <841458F3A823DB4195795B48289BF4F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTAzLTI3IGF0IDA1OjM1ICswMjAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6DQo+IE9uIFRodSwgMjAyNS0wMy0yNyBhdCAwMDozNSArMDAwMCwgQ2hyaXMgQmFpbmJyaWRn
ZSB3cm90ZToNCj4gPiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAwNDozNjoxMlBNICswMDAwLCBH
cnVtYmFjaCwgRW1tYW51ZWwgd3JvdGU6DQo+ID4gPiBXZSBoYXZlIGFsbCB0aGUgZml4ZXMgbm93
IGluIDYuMTMuNy4NCj4gPiA+IElmIHlvdSBzdGlsbCBoYXZlIGlzc3VlcyB0aGVyZSwgcGxlYXNl
IHJlcG9ydCBiYWNrIGFuZCBJJ2xsIHRyeQ0KPiA+ID4gdG8NCj4gPiA+IGZpbmQNCj4gPiA+IHNv
bWUgdGltZSB0byBjcmFmdCBzb21ldGhpbmcuDQo+ID4gDQo+ID4gWWVzLCBJIHN0aWxsIHNlZSB0
aGlzIGluIDYuMTQuMCBvbiBldmVyeSBzdXNwZW5kL3Jlc3VtZSB3aXRoIGxhcHRvcA0KPiA+IExl
bm92byBMZWdpb24gNyAxNkFDSGc2Lg0KPiA+IA0KPiANCj4gQ2FuIHlvdSBnaXZlIHRoZSBhdHRh
Y2hlZCBwYXRjaCBhIHRyeT8NCj4gQ29tcGlsZSB0ZXN0ZWQgb25seS4NCj4gDQo+IFRoYW5rcw0K
DQpBbmQgaGVyZSBpcyBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCkxldCBtZSBrbm93IGhv
dyBpdCBnb2VzLg0KDQpUaGFua3MhDQo=

--_002_43c0e4554151e015c068b79b5da7231f8674a474camelintelcom_
Content-Type: text/x-patch;
	name="0001-BUGFIX-wifi-iwlwifi-don-t-warn-if-the-NIC-is-gone-in.patch"
Content-Description: 0001-BUGFIX-wifi-iwlwifi-don-t-warn-if-the-NIC-is-gone-in.patch
Content-Disposition: attachment;
	filename="0001-BUGFIX-wifi-iwlwifi-don-t-warn-if-the-NIC-is-gone-in.patch";
	size=6263; creation-date="Thu, 27 Mar 2025 20:31:33 GMT";
	modification-date="Thu, 27 Mar 2025 20:31:33 GMT"
Content-ID: <3F075E0D87F80240A6DB450056B85530@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwZDk3Njk2ZTk0N2VlZWVjYzRkMGFmZjlhZmQzMTU0ZTg5YzJjZTBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbW1hbnVlbCBHcnVtYmFjaCA8ZW1tYW51ZWwuZ3J1bWJhY2hA
aW50ZWwuY29tPgpEYXRlOiBUaHUsIDI3IE1hciAyMDI1IDA1OjM1OjE1ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gW0JVR0ZJWF0gd2lmaTogaXdsd2lmaTogZG9uJ3Qgd2FybiBpZiB0aGUgTklDIGlz
IGdvbmUgaW4KIHJlc3VtZQoKU29tZSBCSU9TZXMgZGVjaWRlIHRvIHBvd2VyIGdhdGUgdGhlIFdM
QU4gZGV2aWNlIGR1cmluZyBTMy4gU2luY2UKaXdsd2lmaSBkb2Vzbid0IGV4cGVjdCB0aGlzLCBp
dCBnZXRzIHZlcnkgbm9pc3kgcmVwb3J0aW5nIHRoYXQgdGhlCmRldmljZSBpcyBubyBsb25nZXIg
YXZhaWxhYmxlLiBXaWZpIGlzIHN0aWxsIGF2YWlsYWJsZSBiZWNhdXNlIGl3bHdpZmkKcmVjb3Zl
cnMsIGJ1dCBpdCBzcGV3cyBzY2FyeSBwcmludHMgaW4gdGhlIGxvZy4KCkZpeCB0aGF0IGJ5IGZh
aWxpbmcgZ3JhY2VmdWxseS4KCnR5cGU9YnVnZml4CnRpY2tldD1ub25lCmZpeGVzPUk2MTNkMTdj
NzEyZGU3YTBkNjExY2RlNGUxNGYzN2ViYmUwYzNjOTY0CgpGaXhlczogZThiYjE5YzFkNTkwICgi
d2lmaTogaXdsd2lmaTogc3VwcG9ydCBmYXN0IHJlc3VtZSIpCkNsb3NlczogaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTk1OTcKQ2hhbmdlLUlkOiBJNTY5Y2Ex
NWVhYWE3NzRkNjMzMDM4YTc0OWNjNmVjNzQ0ODQxOTcxNApTaWduZWQtb2ZmLWJ5OiBFbW1hbnVl
bCBHcnVtYmFjaCA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmMgICAgIHwgIDIgKy0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyAgICAgIHwgMTMgKysrKysrKysr
Ky0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2ludGVybmFsLmgg
fCAgOCArKysrLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3Ry
YW5zLmMgICAgfCAxMSArKysrKysrKy0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9wY2llL3R4LmMgICAgICAgfCAgMiArLQogNSBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9pd2wtdHJhbnMuYwppbmRleCBlOGFhNzJkYTM5ZDMuLmRhZTA2NDI0NmZkMCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuYwor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5jCkBAIC01
OTUsNyArNTk1LDcgQEAgSVdMX0VYUE9SVF9TWU1CT0woaXdsX3RyYW5zX3JlYWRfY29uZmlnMzIp
OwogCiBib29sIF9pd2xfdHJhbnNfZ3JhYl9uaWNfYWNjZXNzKHN0cnVjdCBpd2xfdHJhbnMgKnRy
YW5zKQogewotCXJldHVybiBpd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3ModHJhbnMpOwor
CXJldHVybiBpd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3ModHJhbnMsIGZhbHNlKTsKIH0K
IElXTF9FWFBPUlRfU1lNQk9MKF9pd2xfdHJhbnNfZ3JhYl9uaWNfYWNjZXNzKTsKIApkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jCmluZGV4IDA3OTZhMzhi
MmQ5Mi4uNDVkZmQ0ZThmNzM4IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL3BjaWUvZHJ2LmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9wY2llL2Rydi5jCkBAIC0xOTk4LDEwICsxOTk4LDE3IEBAIHN0YXRpYyBpbnQgX2l3bF9w
Y2lfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldmljZSwgYm9vbCByZXN0b3JlKQogCSAqIG5lZWQg
dG8gcmVzZXQgaXQgY29tcGxldGVseS4KIAkgKiBOb3RlOiBNQUMgKGJpdHMgMDo3KSB3aWxsIGJl
IGNsZWFyZWQgdXBvbiBzdXNwZW5kIGV2ZW4gd2l0aCB3b3dsYW4sCiAJICogc28gYXNzdW1lIHRo
YXQgYW55IGJpdHMgdGhlcmUgbWVhbiB0aGF0IHRoZSBkZXZpY2UgaXMgdXNhYmxlLgorCSAqIEZv
ciBvbGRlciBkZXZpY2VzLCBqdXN0IHRyeSBzaWxlbnRseSB0byBncmFiIHRoZSBOSUMuCiAJICov
Ci0JaWYgKHRyYW5zLT50cmFuc19jZmctPmRldmljZV9mYW1pbHkgPj0gSVdMX0RFVklDRV9GQU1J
TFlfQlogJiYKLQkgICAgIWl3bF9yZWFkMzIodHJhbnMsIENTUl9GVU5DX1NDUkFUQ0gpKQotCQlk
ZXZpY2Vfd2FzX3Bvd2VyZWRfb2ZmID0gdHJ1ZTsKKwlpZiAodHJhbnMtPnRyYW5zX2NmZy0+ZGV2
aWNlX2ZhbWlseSA+PSBJV0xfREVWSUNFX0ZBTUlMWV9CWikgeworCQlpZiAoIWl3bF9yZWFkMzIo
dHJhbnMsIENTUl9GVU5DX1NDUkFUQ0gpKQorCQkJZGV2aWNlX3dhc19wb3dlcmVkX29mZiA9IHRy
dWU7CisJfSBlbHNlIHsKKwkJaWYgKCFfaXdsX3RyYW5zX3BjaWVfZ3JhYl9uaWNfYWNjZXNzKHRy
YW5zLCB0cnVlKSkKKwkJCWRldmljZV93YXNfcG93ZXJlZF9vZmYgPSB0cnVlOworCQllbHNlCisJ
CQlpd2xfdHJhbnNfcGNpZV9yZWxlYXNlX25pY19hY2Nlc3ModHJhbnMpOworCX0KIAogCWlmIChy
ZXN0b3JlIHx8IGRldmljZV93YXNfcG93ZXJlZF9vZmYpIHsKIAkJdHJhbnMtPnN0YXRlID0gSVdM
X1RSQU5TX05PX0ZXOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9wY2llL2ludGVybmFsLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L3BjaWUvaW50ZXJuYWwuaAppbmRleCA4MDkzMDZlOGMzMmYuLjQ2ODA1YTllMDNjOCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2ludGVybmFsLmgK
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2ludGVybmFsLmgK
QEAgLTU2MCwxMCArNTYwLDEwIEBAIHZvaWQgaXdsX3RyYW5zX3BjaWVfZnJlZShzdHJ1Y3QgaXds
X3RyYW5zICp0cmFucyk7CiB2b2lkIGl3bF90cmFuc19wY2llX2ZyZWVfcG52bV9kcmFtX3JlZ2lv
bnMoc3RydWN0IGl3bF9kcmFtX3JlZ2lvbnMgKmRyYW1fcmVnaW9ucywKIAkJCQkJICAgc3RydWN0
IGRldmljZSAqZGV2KTsKIAotYm9vbCBfX2l3bF90cmFuc19wY2llX2dyYWJfbmljX2FjY2Vzcyhz
dHJ1Y3QgaXdsX3RyYW5zICp0cmFucyk7Ci0jZGVmaW5lIF9pd2xfdHJhbnNfcGNpZV9ncmFiX25p
Y19hY2Nlc3ModHJhbnMpCQkJXAorYm9vbCBfX2l3bF90cmFuc19wY2llX2dyYWJfbmljX2FjY2Vz
cyhzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucywgYm9vbCBzaWxlbnQpOworI2RlZmluZSBfaXdsX3Ry
YW5zX3BjaWVfZ3JhYl9uaWNfYWNjZXNzKHRyYW5zLCBzaWxlbnQpCQlcCiAJX19jb25kX2xvY2so
bmljX2FjY2Vzc19ub2JoLAkJCQlcCi0JCSAgICBsaWtlbHkoX19pd2xfdHJhbnNfcGNpZV9ncmFi
X25pY19hY2Nlc3ModHJhbnMpKSkKKwkJICAgIGxpa2VseShfX2l3bF90cmFuc19wY2llX2dyYWJf
bmljX2FjY2Vzcyh0cmFucywgc2lsZW50KSkpCiAKIHZvaWQgaXdsX3RyYW5zX3BjaWVfY2hlY2tf
cHJvZHVjdF9yZXNldF9zdGF0dXMoc3RydWN0IHBjaV9kZXYgKnBkZXYpOwogdm9pZCBpd2xfdHJh
bnNfcGNpZV9jaGVja19wcm9kdWN0X3Jlc2V0X21vZGUoc3RydWN0IHBjaV9kZXYgKnBkZXYpOwpA
QCAtMTEzMCw3ICsxMTMwLDcgQEAgaW50IGl3bF90cmFuc19wY2lfcmVxdWVzdF9maXJtd2FyZShz
dHJ1Y3QgaXdsX3RyYW5zICp0cmFucywKIAkJCQkgICB2b2lkICgqY29udCkoY29uc3Qgc3RydWN0
IGZpcm13YXJlICpmdywKIAkJCQkJCXZvaWQgKmNvbnRleHQpKTsKICNlbmRpZgotYm9vbCBpd2xf
dHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3Moc3RydWN0IGl3bF90cmFucyAqdHJhbnMpOworYm9v
bCBpd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3Moc3RydWN0IGl3bF90cmFucyAqdHJhbnMs
IGJvb2wgc2lsZW50KTsKIHZvaWQgaXdsX3RyYW5zX3BjaWVfcmVsZWFzZV9uaWNfYWNjZXNzKHN0
cnVjdCBpd2xfdHJhbnMgKnRyYW5zKTsKIAogLyogdHJhbnNwb3J0IGdlbiAxIGV4cG9ydGVkIGZ1
bmN0aW9ucyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL3RyYW5zLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUv
dHJhbnMuYwppbmRleCBhODk0YjI4ZDZmNzMuLjc2NjU1YTJlZmYzZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3RyYW5zLmMKKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3RyYW5zLmMKQEAgLTI0MzEsNyArMjQz
MSw3IEBAIEVYUE9SVF9TWU1CT0woaXdsX3RyYW5zX3BjaWVfcmVzZXQpOwogICogVGhpcyB2ZXJz
aW9uIGRvZXNuJ3QgZGlzYWJsZSBCSHMgYnV0IHJhdGhlciBhc3N1bWVzIHRoZXkncmUKICAqIGFs
cmVhZHkgZGlzYWJsZWQuCiAgKi8KLWJvb2wgX19pd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nl
c3Moc3RydWN0IGl3bF90cmFucyAqdHJhbnMpCitib29sIF9faXdsX3RyYW5zX3BjaWVfZ3JhYl9u
aWNfYWNjZXNzKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCBib29sIHNpbGVudCkKIHsKIAlpbnQg
cmV0OwogCXN0cnVjdCBpd2xfdHJhbnNfcGNpZSAqdHJhbnNfcGNpZSA9IElXTF9UUkFOU19HRVRf
UENJRV9UUkFOUyh0cmFucyk7CkBAIC0yNDg2LDYgKzI0ODYsMTEgQEAgYm9vbCBfX2l3bF90cmFu
c19wY2llX2dyYWJfbmljX2FjY2VzcyhzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucykKIAkJCQkgICAg
ICBJV0xfQ0ZHX01BQ19UWVBFX01BKSAmJgogCQkJCSAgICAgdHJhbnMtPnRyYW5zX2NmZy0+aW50
ZWdyYXRlZDsKIAorCQlpZiAoc2lsZW50KSB7CisJCQlzcGluX3VubG9jaygmdHJhbnNfcGNpZS0+
cmVnX2xvY2spOworCQkJcmV0dXJuIGZhbHNlOworCQl9CisKIAkJV0FSTl9PTkNFKDEsCiAJCQkg
ICJUaW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGFjY2VzcyAoQ1NSX0dQX0NOVFJMIDB4JTA4
eClcbiIsCiAJCQkgIGNudHJsKTsKQEAgLTI1MTUsMTIgKzI1MjAsMTIgQEAgb3V0OgogCXJldHVy
biB0cnVlOwogfQogCi1ib29sIGl3bF90cmFuc19wY2llX2dyYWJfbmljX2FjY2VzcyhzdHJ1Y3Qg
aXdsX3RyYW5zICp0cmFucykKK2Jvb2wgaXdsX3RyYW5zX3BjaWVfZ3JhYl9uaWNfYWNjZXNzKHN0
cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCBib29sIHNpbGVudCkKIHsKIAlib29sIHJldDsKIAogCWxv
Y2FsX2JoX2Rpc2FibGUoKTsKLQlyZXQgPSBfX2l3bF90cmFuc19wY2llX2dyYWJfbmljX2FjY2Vz
cyh0cmFucyk7CisJcmV0ID0gX19pd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3ModHJhbnMs
IHNpbGVudCk7CiAJaWYgKHJldCkgewogCQkvKiBrZWVwIEJIcyBkaXNhYmxlZCB1bnRpbCBpd2xf
dHJhbnNfcGNpZV9yZWxlYXNlX25pY19hY2Nlc3MgKi8KIAkJcmV0dXJuIHJldDsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS90eC5jIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL3R4LmMKaW5kZXggNWMxZTYzYmYzMWQ1
Li41MmRhMzhhYzY1M2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvcGNpZS90eC5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
cGNpZS90eC5jCkBAIC0xMDIzLDcgKzEwMjMsNyBAQCBzdGF0aWMgaW50IGl3bF9wY2llX3NldF9j
bWRfaW5fZmxpZ2h0KHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLAogCSAqIHJldHVybmVkLiBUaGlz
IG5lZWRzIHRvIGJlIGRvbmUgb25seSBvbiBOSUNzIHRoYXQgaGF2ZQogCSAqIGFwbWdfd2FrZV91
cF93YSBzZXQgKHNlZSBhYm92ZS4pCiAJICovCi0JaWYgKCFfaXdsX3RyYW5zX3BjaWVfZ3JhYl9u
aWNfYWNjZXNzKHRyYW5zKSkKKwlpZiAoIV9pd2xfdHJhbnNfcGNpZV9ncmFiX25pY19hY2Nlc3Mo
dHJhbnMsIGZhbHNlKSkKIAkJcmV0dXJuIC1FSU87CiAKIAkvKgotLSAKMi40OS4wCgo=

--_002_43c0e4554151e015c068b79b5da7231f8674a474camelintelcom_--

