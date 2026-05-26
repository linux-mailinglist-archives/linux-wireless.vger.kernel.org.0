Return-Path: <linux-wireless+bounces-36930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL6fDqkTFmojhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:42:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BB5DCD3D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C3A300F53D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FB3C3439;
	Tue, 26 May 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIM9Pz+A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E43C13F0;
	Tue, 26 May 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831704; cv=fail; b=RMFlZ+xcbqhYpI+sxkE6MsKTGWgTmqk0jyg+BWJAu49fQE3TTKcH6cYn81mGjwza5weR3tEf689roSenRiFDL4pU7+ld0rhLQwVeNxLDapQ4ZnxVmAKYgad84ZEfDElQuGHdF7QN1Gq6qyqaKOS9qRm/tf+xJO27jnMd03Ocm1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831704; c=relaxed/simple;
	bh=rsKg1H7SXjkKgif+Mtlyv+VPcrT17H27QeDw3J8Gjxw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gpA4eZoBUzHPNKwtMOy2qQzrEbo6/XB1knyskUhPtEdCWOceH5IRT/lS1EvcQ9AIGYl0QPpLLrBRo1Fbq5epey5/GtY7WpJwRkotOzelgVZQvC5OUhAwcFOrhg6KFwZE5hrQ8VW/P3d+v3Tsv2L4KEMD5eVAztzQLmtJhFyKuzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIM9Pz+A; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779831703; x=1811367703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rsKg1H7SXjkKgif+Mtlyv+VPcrT17H27QeDw3J8Gjxw=;
  b=nIM9Pz+AQAHoCEW5nXzjz4vjfVoKlCATzCWjCIK2kBJ1sWQQMMbHLyt8
   ioPyjADGYt0JMl5/Jl3H95KO5fEXL9ViEf+tL+opK5LdHTwQrx9gdZaR6
   VTyPopGivVrvEoQvS3947T/HEdXJIC0mpeUxs6FZp0FXll3ROsvzMARwx
   58AMzgj0llMYdHM3GaysxGprEQSO2r7TwoGQ0gK/ldU2g06fsKAlJbM8r
   phecD3HVQLjBEiqrjkNO2k/ptHt3/W8yiL1oobGrx+7wMShcPoWlObjfA
   9iNvakit/QZ01savT+IQutt4N4l7IIGjul4VW0Ayv8PYcFwLoWhEV4+M5
   w==;
X-CSE-ConnectionGUID: 30Pbq0QXRpee9tLEnpQW0g==
X-CSE-MsgGUID: 0SWCgxQaS4COuc4wu5IrgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80843674"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80843674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:41:42 -0700
X-CSE-ConnectionGUID: 2koEc8u7T8WClE5ji7bM3w==
X-CSE-MsgGUID: XCfjGJUSRBuVayAkmobV9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246072171"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:41:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:41:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:41:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWmUVO39bPLiHAS12qH//VK07o9BXFbqqT1+6oqSozl5bRiyR9eHbmwL/Hg8EHZrKNHYHXNc/qBOtvBBjaLxjtim6uQ/qh1EqOUMUnwevIzaBhe62EsIWLC8DnC6B2mNKq78V7Tw9NZMV2fpZwp6DLz+oM53EvOmVL6tnw0QLCSBcJ9goYcugUfUXHyC+HBOz2/OXaQI/wxonKJ3fMjwtj5lgNbbuWGFT/r4T78Ttt3+BZ6xxPU4gaKnhWJKlnvPV+038uyuJdMfEe/zrCZfJVT5levYN76bDojGygUjsQDqF/1TBCsdIDcUIcgZarHj3dSuxnL1YENN78qDevg/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0e5EmI33Gjw6c39EKVezKYpX8KvcZDdQgUGHQnbNVA=;
 b=RvCUJ51NAl8uc/T11BJm+gp8M4pw3BQOxyKlbC8zQK586o02HcrnRDdZimbUifGWHafHSwwldsmAHfc+ADFJqzwxMDexVEUaETPxUs6LoiDMF6OqreqwTt/QI7OKlOEUAWfzmTJTUrF1uzb4GveeX2NQ/2urlbMFOGE4TWES9c/MotPqdLGJsHdBFYDTy6zM8S0UP+qg60dfyZMRtUGqVpvksBhgwzfhi9d3W6dt0S+/qs9yTGMbXG1S+2ep7iBwI8GWynSvHg21JMzalAaKGbC/hAwu59uJu9it/vLt2HaP/kBrcDysPcfYbO8IizqNwouhq1l5VwJb5QI2CaSHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:41:38 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:41:38 +0000
Message-ID: <5b082d25-9a57-4612-a93e-a4591acd0ea6@intel.com>
Date: Tue, 26 May 2026 14:41:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 01/24] timekeeping: Provide ktime_get_snapshot_id()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
	<mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, <thomas.weissschuh@linutronix.de>, "Arthur
 Kiyanovski" <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>, Oliver Upton
	<oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20260526165826.392227559@kernel.org>
 <20260526171222.769770418@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526171222.769770418@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 497e108b-6704-4dd1-a80e-08debb6f910d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xXJP2/Awmpj2XxIo4xZoGrJEgbTmwU/pAIfyALKW6cs+LB49KqU81hWedILNfX0rFG8czfIt5Kx4wQe/nKFCmfZj9ie2F98k1+Dc2HQremFuSrS5+3GVg/GTLX/e9gL+/fLxiPrcGPpeANoQGPXzJj4WHaLd3i6NBVLpOA3FnqxD9j2i7fo7hCF6Ukdfz2Vr2TzrR/HjlpWUHlFBGp2PD7WErER9Lv7igIeVKTGGGL6SjaQ9vhpMwxHuTsImJJE0U29UF9XHG6WIi7RTLFVRSTaq5FAbi0FVbXex1TiHS4sc4S0ZeHN1AIxoy9vbYkhmtajvEnerZDN4sCAujWtGwShKYDjh+0axS53SWv8k+X5BgRhYPTNl1ilucrxd4H6S42lpDg+LVbtz7gOOypXIacy5SPusORO4vvWQ3DuDUmDWz4kJ1FV2TBMNMeGzFraQPeehwKyjeQLlrSpX2s2krOQnqavtH1pFy1ZB7bEtfCVrR01C0tkmQrY9d/a/sAPPxR0Av0ZA10bzRthVqEoXVNzFwo/3xV5w5A9LyOJXHgYwTJoVPna9Fa58ptsk+V32M+QuThUao36cxVHCg3wqGjyJcy7N/pIbkPOeNdrDrmkXCYnBhcp9124K5iM43nkESOdgjJNpRfgTwQfGT34HirO3BZTZcQJULzP/fp8QB4V2oQD6WqtQ8p2CDYUSauy7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJMUWl0ZEdITzc2MHJIL1ZmZmxhaVo5ZnFxblZUR1NJYmx3Z3VjTjlBR01Z?=
 =?utf-8?B?ZkxYbWtkTVhQWElSVW5iTGF4VWdEbmFwempFdUttVGJsaHhEZ1lCL1pqSTJT?=
 =?utf-8?B?ME52U3dVb2YxbkFaVE5xTU5nUXI0enRNamQydVV4RUkwVlF1enc1ZjhDUjF0?=
 =?utf-8?B?V1VsbzZ5UHBVaUp0Yk5lREFtb0hTc0Q2RlVBZkhycXRUd2IvRm1ieGZtcDhR?=
 =?utf-8?B?ZWxTUlRPN0h0ZUE5UWNGU0NoeUZWeTdNeEVFcm1GTkgwSUxCbjJpeGJUSUpL?=
 =?utf-8?B?MXVIanRjZlFSNTZkTWZVMzA4a1AwaU1rcmpGVlJCemJBNzFBVlZvWkw3YzRB?=
 =?utf-8?B?b1ZEanpka09rUVZCNW5hRGQ3eDFabUV2V1hjRlR4MXNxdzFjK0NGcHFJVUdK?=
 =?utf-8?B?eUVYa2dFSDczaUJGM3VrWjlnSDZUMVJ3dmFzNkRBU3l4SW9UNnprMloyMGti?=
 =?utf-8?B?UzB4a0k5anNMWHMwTWVCUDlQUWk4SEttbVp4ZG5aalRaQ1VDRlVFY25STzEy?=
 =?utf-8?B?NnR4Y2xQeVV3VEpCbXBjWno1a29vZFlMbUFQSjlPWjgzUnVlQ04zcFVHRS8w?=
 =?utf-8?B?S09DcTVRUTdid1J2aldrL2ozbitjeGpwOWFRajhabkpkN21JWHVmVFBScDlp?=
 =?utf-8?B?WUdKSmZTYTFoRlc4RFZZNHFTVUMyaGgxODQxWVpwdVdSQ0NqQUw2aWkwR0dt?=
 =?utf-8?B?b3AwWWhHTEJ0WTNvdmU1MHFGTUt4dHVKSTZUMVRFdjU2dlQxRlNGOHdsODJB?=
 =?utf-8?B?WHc2WFZuRnhQZTZ5c09IRUgrSGZNZ3RldGIvZjl0cUVESVNkMWxQaDN1dThj?=
 =?utf-8?B?QlRCMEFTMHVGTGsrdzloNTVQSFppMDI1UFFUOUxJdlJZNlF3V09BWVpyd3VG?=
 =?utf-8?B?eVdBYndsUU9ITlFrRnZndEw3MXlodnV0L2lhMU9QUVZVOXJPK2FKM1ZVUjN5?=
 =?utf-8?B?ODIrMWgvc1AzKzNpdmhsbWg3eFkreW5ZdlNENHdLSGFGS1RObndkbVRLUE5N?=
 =?utf-8?B?YUdjekJDdkZGT0tGQm9DajdFcThKNkxtMzRUai9DSlg4Q3ZJRTdPWVlvYzVM?=
 =?utf-8?B?RGc1bitNd2ZlN0NTQS9RNW9OWmtzd2c2eUx6L3Z5YmpsUnhVYzdtNUJYdkVj?=
 =?utf-8?B?clMrRzFNTWRYN1NKcjNBQStzUHhZN2NOOEJ1WUF2emx6N0ZKOFQ2VmtaTXlw?=
 =?utf-8?B?ZituNCszbjBxbWNkSFA1ekZvM1htZkNZREgxYm4xNEZ1TE1LKzNZOEtiVHJy?=
 =?utf-8?B?SE1nREVxT1JjMGlYYzI0cDc5SlNIdVAwSnB6MU53MHJsZ28wNFZZM1Q1Z1Vn?=
 =?utf-8?B?YWZyN213ZUpFQ3JsdGsxRkdncG9sRDZxMHdHaTBFajVHME9wTitLbHFZS3or?=
 =?utf-8?B?ZEVnaFNKZkhGRTJqcW9FQURxUW56UW9IZ0Q1c1ZycHJjZVZzT05sYW1yd1BX?=
 =?utf-8?B?S1Bxbjgya0NhRVUzR1k4ZnJYRmhhcnBwL0NDZVlodXRkZFlFaUdyUDJHQ0pM?=
 =?utf-8?B?ai9uR2NCMzZJRTZsV3NrMHFveklyaFRzVldXbXdXbjdaRGFBZVIwYUZTSXYr?=
 =?utf-8?B?dVVHYk9wc29Vc01QUWdlM0llZnJKU1pmOFRxRXpmc3poclJKTENFOWlwQ1NP?=
 =?utf-8?B?ek9LNkpWRVhIaytabGlnekV1OHI3bWxNczRRamhCYlJzc1E5a0FMVzFZV1Bu?=
 =?utf-8?B?Z2lsOXJmTU1LbUREL2E2d0wzL2FmaVZpUXlNcVdFakR5WktZQk4rbC9tNmt0?=
 =?utf-8?B?SGxQenpEdUVZQVBtWTBQL2hWWWJoRGNjSW14ZHVTSVo4cVBIbnFteG9iL0ZC?=
 =?utf-8?B?UWNTZ1NXeXdDVG5qNEYxOHEyOEVZb2RaQWJuTjh1R3N2MS9BUThJQjBRMWdR?=
 =?utf-8?B?RUlCNjNBaUQ4L1hMMnU1RmZLRHMybGlsMDFGdDF2T1hMME1JZVdwVStKMTlr?=
 =?utf-8?B?amVnd3JMY0p5VGtFMkw0Wi90dUtkYmZ5YVlWUW9EbFJUVEdoNzEvdHJxT1Fr?=
 =?utf-8?B?d1dOZzNZaGtuaGc0OWVjN0lRbEtjWk5rSENmSEw0R0o0d0xaMHVFZXlOMnpn?=
 =?utf-8?B?RmpqcTg3dUJMUXJhK0pvUC81MTRvVmtlenFOQklMVlZNZHBJa21pQ2dsSjVW?=
 =?utf-8?B?TlhzRTV2V3lFZGEvMnNqYW5sNDN2NkNsWis0UVprMk1RSjRneC9lYXBYNVVU?=
 =?utf-8?B?enF6cU52ZXVldTdlc1FGWlZyTW93QkgzYmJiZnhEbnV1clg4KzhXQjMwRExk?=
 =?utf-8?B?MUhMUTI4bTRkUjM3OTlQaEg5aWwwV3lSc2d2S0x5ZWN6d1ozTDdnMGtkMkor?=
 =?utf-8?B?YW9OOG5Ga2hORExPeGppV3cxNzJ0SVdoVFhodCtYN2wwdkFlR2lmUT09?=
X-Exchange-RoutingPolicyChecked: ZJm7UDC+8jyKNiGRfn9a8/x4vF0l43XbtoY3MJW6U1pxxsZNIFm1Xr8h9UagTdfX2zjdFNaTJPfANSX0xjGGk7Kz0pA7CDheLvIM5uOV/PUt/A0NSXacvGyKd/8/fxjQo4Qv1hB845LpCCHSkPiARnZaKgtvbkAmwWKklhsyMn/3pHtiPnj4DMyrKw+m/MqAZ8ylKrLTKqgR8iT7G4DnOK+zQoBChy0MyjRuTG3yDWoT7VAGZnoM4jFAH6NKdpi/V8U+E7TZFJWrKtJWqEX4YFk7jVmE4MX0uRZYtfpzjLQUKJYURnrtKo2ZL38LCveJ2sLd0vc713gqmLsGhgT8+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 497e108b-6704-4dd1-a80e-08debb6f910d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:41:38.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mj3Q7Xc9AKOSRMLgsdyFoqdO1vBPFqYeCrgbNdYbqa6/j/+lh0TCSN9AQ5a8miPlv70/BJq/fyR6K6uMCbJHzyT0LVKoYi3JTqne2AefV0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36930-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 931BB5DCD3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 10:13 AM, Thomas Gleixner wrote:

>  /**
> - * ktime_get_snapshot - snapshots the realtime/monotonic raw clocks with counter
> - * @systime_snapshot:	pointer to struct receiving the system time snapshot
> + * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
> + *			    CLOCK_MONOTONIC_RAW and the underlying
> + *			    clocksource counter value.
> + * @systime_snapshot:	Pointer to struct receiving the system time snapshot
> + * @clock_id:		The clock ID to snapshot
>   */
> -void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
> +bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clockid_t clock_id)
>  {

Since this function now returns a bool would it make sense to add a
"Return:" comment to the kdoc to help explain what the return value means?

I saw that you have a WARN_ON with the ktime_get_snapshot wrapper. I
guess it returns false if timekeeping_suspended.

> -	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
> +	u64 nsec_raw, nsec_sys, now;
> +	struct timekeeper *tk;
> +	struct tk_data *tkd;
>  	unsigned int seq;
> -	ktime_t base_raw;
>  	ktime_t base_real;
>  	ktime_t base_boot;
> -	u64 nsec_raw;
> -	u64 nsec_real;
> -	u64 now;
>  
> -	WARN_ON_ONCE(timekeeping_suspended);
> +	/* Invalidate the snapshot for all failure cases */
> +	systime_snapshot->valid = false;
> +
> +	if (WARN_ON_ONCE(timekeeping_suspended))
> +		return false;
> +

This warns here, and the wrapper ktime_get_snapshot also warns. Does
that make sense? I guess eventually the ktime_get_snapshot will be removed?

