Return-Path: <linux-wireless+bounces-17732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E3A166B3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 07:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF9B3A834C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 06:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404B537E9;
	Mon, 20 Jan 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyiLv6t3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0517B502
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354862; cv=fail; b=rkI9lbIFaUitExYOHt1SdPAUtVp3VdDg1Siu+17D5+rnnngKymiyDwm5wrMYAu78WEppVyidykoutO02qghvwaIEeD3U10kr50N5FAmlUsz18pb7DN/cR7UJ9fEa7fhHsr8y4qvMGjnbdR3IpSqkmT9/5+M6CwckquTNmofvTNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354862; c=relaxed/simple;
	bh=FKMZokGwy8n9XgM8ljHAKB1wjxSpsgpirb0ezXzw4PY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WLQ3tpdp51KMAa3Vi8w81HPZ4u1a38lWA0+XYaCQvWL8Q7VDvIdxyfIE7Oxt0AHO+71Q8B+lMCbhRrLPA14PGkB3MIuzw/034goHphDiefhJzAv0m30XXEb9RqFN+wcerOoDqbmsM9ghNrXPhC+0kdTdT/nGx/hI+fxzywFg7Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyiLv6t3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737354859; x=1768890859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FKMZokGwy8n9XgM8ljHAKB1wjxSpsgpirb0ezXzw4PY=;
  b=HyiLv6t3UdkZTK3iJEr9RpOq5cHJjQKNOWya2+Ln0vn7yO8/mD/bEGWv
   omtumdfCmJsvIbmFXMAUSfS1S68Ok25Fw83f8oAMUdb/ybHVgkLUNqv5W
   9zQdfDdtBU+PJEVDoJWeu25sYupouTYIOiScHPo8D38jZz3jpT1WND+uW
   2zS9nnieRKb9AbhtYYN5p6BF3lSaQAmPVyDtCJ2aKCjlop1mzE7rp40r6
   YdcSjDMk2EHRi1q50/uXPSsKWtWsyFMei9BwGq095eH786DqcCnW8zDwo
   BpcbrYzcu92mBUWACBdV/nHNiovngBEyGTXNUKqGMfsQC35CYs6jTJ34+
   w==;
X-CSE-ConnectionGUID: i1LxfIVtQ92werToH3whCw==
X-CSE-MsgGUID: zjk7VChxQz2lUfdr9wZ2QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37867679"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37867679"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:34:18 -0800
X-CSE-ConnectionGUID: veSJTvNpSamqrTsyR7v85A==
X-CSE-MsgGUID: uL3KIA4SQgiWOBPoHRcyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110435606"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 22:33:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 22:33:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 22:33:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 22:33:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIcBXxY30sPqov3Jicjr4NzgZgValxeQSCNfb7Dc3Q4TcgB/EY7KfiKDFZRq9vyuGvtIQSEajTJwZNSyjpOEI3i4OkhM9vScXk/d50NOoFrINw3Zj8Ri/A+g3Rmhw+RGqmRuNnk62HZ6t1EUJiGBfECX8pY/nDv8b/sEmIc5YN3kVOXUu0LSN3cETZaP11NWYDVkuSqGJ+0CI7o3ewgBBCKjTVp2vbsebbV1m9c7tdhvuemHVUNYe/KZXFkz4GSXDOKrcH/9+5TKCyQ/rXfZ5v5ZlPfeYTfnMLZybMckR0bXBaQHGSYCMuX+VOlto5LYc4gZOflW/WjRCb8dObN+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/ruon5wkZeiHHZohruBuiQciWuKhjgecjMQUHQFFxk=;
 b=m4+huN3qIYxMNp1y2TlC6Jo9sjFF9t+Os5OAJjMT6gfMzh7UtBfV4F513poU69o+OHuf4fRiEUb1X1mOWenxdLVBtH5+lGyRjt1tvB2oLbn/hsnErTOtFIQMMXf+iCB92z8T8f9+/zijm1OI0PyNgsEekgnJWuQoZLu4CW2CZE7DmoyrkxD5NQ1s5smr/58LxEzEp5ml5nvEab1ENoyBi8MJBqUVfMB2ojc7s91zSsEdNO/OcJEWGRTt+vQb6MicXSrkhkquYhRkBQ48yrhBtH9hIR8jDfZEd4kBSPtwrgQaCcS1faDdfk20r6YY3YGG0x8qowsTJI4nNg/eakljXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Mon, 20 Jan
 2025 06:33:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:33:38 +0000
Date: Mon, 20 Jan 2025 14:33:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Benjamin Berg <benjamin.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Berg
	<johannes.berg@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  708d06b33b: hwsim.owe_assoc_reject.fail
Message-ID: <202501201310.71e65f29-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: f96a3263-3047-417b-7c2f-08dd391c5ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hm5B65bmeob/OtqfFmFRj9UycVKw+9ZOP5O3W6IUm/pSMbJUZemrEO35f4As?=
 =?us-ascii?Q?Mzv4quYxY5NpiLlC40+FxlgG0Xe3x64Dd39a2CKKXEOogCPSidMGGtNM0qHh?=
 =?us-ascii?Q?xBYKD/XgEPje3oQHVhWS0HYIX2p8mFmkja5HwfV4wfoYieZMr4x5JdRQa4rn?=
 =?us-ascii?Q?Mda9nZemMrzVMyO1JAWjH9OQ76pnNKP7LO+WjKUvJpyaP2yGj+iqxJ+DUS4I?=
 =?us-ascii?Q?SJtpuEMS9G0jlJgai8+0JLnn6c9PeaT3gX6gsnhXnMKcHK0/IbYAN0Moj8oR?=
 =?us-ascii?Q?asiXVecESmnaOXl8yq6rCbpN/0LvPlQV4/Lz1R5XCM3TS95UrSo4zzzm0h77?=
 =?us-ascii?Q?bxfsDtqtPkJRo14lR95zFljos4n0+Vf8laxb/GEk3PC/32ytmfly+51tPZac?=
 =?us-ascii?Q?uSoybcR4HMocYIEVyVkfJMwUYzVM2L8xFOrmicXyxKVb/1q7CEyeKCSux/yH?=
 =?us-ascii?Q?v/KBSD2qrWBiraoFWusbq4Ge5hziHt+2b45wCD2aj6DX90OHX3jlBv2EsL5+?=
 =?us-ascii?Q?phjf4T+pvF8dLJLfl5IB1c2+e7KhadOuKwvJa7OWXTq5WoftjsSssS6xORMi?=
 =?us-ascii?Q?kDLAS/TKINCCiHooMwEGLWJ3Me2bnTWSCchbf0BQn8WD9uyLeP06IzgqfZX7?=
 =?us-ascii?Q?i5Q3n7QGNgwQOLnOM59iq1Il0hNVQnwrj7U6rDPPnDk83DvKErk0hBOD4fqH?=
 =?us-ascii?Q?7U1dZlR0M7UFdKrVBYOCi8CUk/WqXX3ichhjMUsGol0Gjzlco2vg13PDmsdK?=
 =?us-ascii?Q?PFdsyssb1BhV35oybY2mmk5Qb5BQg5Ywo8S5sq+VjNCGqxliMFBKmj3SHXEU?=
 =?us-ascii?Q?ojJ674Yuw3qJTRP9kIQnr7hH/cqhFAwpSOnSeBgf4iEzIyiLFbBng+ki5wG0?=
 =?us-ascii?Q?K9bHUXjKbLv9c53fWat+jnpA2gaZ9Kb+SlDV2AF7NRomeLrAhaHtnednH+Z9?=
 =?us-ascii?Q?orRUaUC4sSXaFPj9B7U13fulCnBjblvHWdqsmGOCxVgmBIpcdq17h4QiTPK+?=
 =?us-ascii?Q?hRUkFflnNOYCNUhYqwX5fTJ8uZ8GjRd6FwWW20efzowLoHQ8qm9oVFctcnm/?=
 =?us-ascii?Q?5yeB7qu0TCna3TeIQszFMT11d1pQRDDByQ1QsPVmraEHmGbvJSdigdQrjK+Y?=
 =?us-ascii?Q?vLJuKUZa6doNm3rZLwUnTmPEptMEYcE+kHbSoyL4tVDPbpShZUaIaZ/v35Jf?=
 =?us-ascii?Q?qgkMb/y66zChptKBVD+k+VTTbMFCen8JKoVVCIY7rxo4pcJR1ItuQGIn0ou4?=
 =?us-ascii?Q?bYN3iVU1CfMAnGp9/ZVUlpMBvhjSQV76pC4P6xK7e/WyaVTxA9Sf+3kga42x?=
 =?us-ascii?Q?MYSKDx5Q46vsA1RU7GDLOiW6xknrEBUzKPQyaxTppJBNhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EXBCZenZHqrvlAnd7G47xnkk0O8ZOUg58G3dlMEbjdfsbbk14obm94evrSV?=
 =?us-ascii?Q?woab3dWmyNgNWEing/cxyDE/gB/YcrxoDGySJ8AJMcbSy6HuLXScDvZ5DSlc?=
 =?us-ascii?Q?EDa8mMzOvHOLxBwK0hnEOqQJr7r2E7uH57uRgOVvaqGfHYfNQ0KzqNsxsBEn?=
 =?us-ascii?Q?UDUtxKG5/9LuJxL4NSp4y4B8ie4L/p6tC+SpYTbk9qswNeRStYiCl8+F38gS?=
 =?us-ascii?Q?I8C1Yzjv6D/qdExeMa+8ExiHVecfjB5bkyjkB3nsTh+PSGAxzBl7aafwfjN5?=
 =?us-ascii?Q?Y3QI4q3rWoqYgZB983OoG79o5I34fi0wcssXUWJvWkEZDvIvD5ZE92fZsfoA?=
 =?us-ascii?Q?6DPVHkhijJOfPglW/nemuydHeWckP1fLZyMuk0F66B2VCjMnUpj7gswpvrtO?=
 =?us-ascii?Q?0Jb5oPemcekXvrbibKYEW4V6CUOyUq36NnbaksOLpRa6Gfzo+Kx0gWzyiVV+?=
 =?us-ascii?Q?bt5xZpVAs6AqM2Z4VnrnF5cbqxJPft1i+a88uN/Ni4qZanY+moXZtj56VwSF?=
 =?us-ascii?Q?udNCBbxS4WSgxFb+DKlGuS9fZpTO1gW4Nov6It7L1Ki8Vj5IfoIYA5CSl/hk?=
 =?us-ascii?Q?DbJNq2beYt0z9TD6QR8AptDyvB7Y6Md8JO88ioVBE4xcGtoWh6fLcSkzSPiX?=
 =?us-ascii?Q?HeF28RRYZ6LHvSxA2RM5uOFVpR/7OiQquTxHzO/2DA09OD7uVvEDoEq9v1LQ?=
 =?us-ascii?Q?DcfKkeKDgRTGWEHDNnc6jJovDT7XSFwukVpaY8DuvYX6G8QbUjwcWxtrTFqM?=
 =?us-ascii?Q?nKMZIDgheboXjQZqC5yU5SB7UdA3DiZZJG6zYuKLh0e2CWKXN2AuT4ieXOIL?=
 =?us-ascii?Q?90c/ChdrpgphJnOxzunYDpTfYKSStYwqEhsRDIWcGzzZ1sNgJVzNRdrCberr?=
 =?us-ascii?Q?nQlBmCO2OjJGHILzBCRNIxofJeIAky4e1GPSBfefBDtyjB+hTLe0rYF6t79f?=
 =?us-ascii?Q?BbR3AyJ8uxf9Oax4FU7bnhA1zYmWiI8Mm3pvWAJsiAR0ci59zC1tZUp5opeU?=
 =?us-ascii?Q?rqTFhwNzPiR+GNZMsTQzcRQfxvfLDt4BPwjA22UusJ9IipfK5KqjVkopv4WK?=
 =?us-ascii?Q?AsgXHoZzaZE/tJ27coAQjDTSL1scSmVSat4gIOrSECqq1iPfKlsZeAl/35uB?=
 =?us-ascii?Q?wAZB51ui/oLmw/f/5ClaLJK/h00isXsR6IAUrdn6ZXAGFei3F8O3jJCHUX2g?=
 =?us-ascii?Q?ajBhhN4Xy4PKfWFF2BS7HV6WqZe1qb5eDxTC9EPs/uTTEG3DR2dYV8E4WH1I?=
 =?us-ascii?Q?n7fQsVdPXSym1U6R1HQggubWDTiiB6m+gbW8iXzRO80Yt3ZidDVT4k2zdkke?=
 =?us-ascii?Q?BAsktl+9qrglz7OuTTbkcwVVnLwSEll43uW/GmUR9xdmVUgYDcIhbrO69uTX?=
 =?us-ascii?Q?V6ZL6NPS9AwHjXH/syyCXisvRGsrG8xUIJqVE/RXTGA7qFCWLUvIlx+S3ow+?=
 =?us-ascii?Q?jd7UjO+CW11r+RaI3i5UenbBPZPRNszlHinidf2LjCRFxSYiRg/gWU9+0IcF?=
 =?us-ascii?Q?6xwlTwTrmM84kiOugG1d76FonCG0gAqOHAfBkDpL6SMSuDocvwlxk6RvW4Lx?=
 =?us-ascii?Q?BDAIH0d8Y+uglXvEneaDIpKXZuq7u8eADudocnTcy2QV8NPoTUNt0rZV/2b4?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f96a3263-3047-417b-7c2f-08dd391c5ff5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:33:38.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Elsj18o441Lj+1/70rlW8DMSDtNt7a4kVs1TUwrqp1iMQdzQ3HEcBPfBBcqj6tzFkMCXSrtUaiTSaypHgqgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.owe_assoc_reject.fail" on:

commit: 708d06b33b97329bd499ff92908c96670a94a510 ("wifi: mac80211: also verify requirements in EXT_SUPP_RATES")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master b323d8e7bc03d27dec646bfdccb7d1a92411f189]

in testcase: hwsim
version: hwsim-x86_64-4ea2c336d-1_20241103
with following parameters:

	test: owe_assoc_reject



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501201310.71e65f29-lkp@intel.com

group: group-00, test: owe_assoc_reject
2025-01-16 13:22:44 export USER=root
2025-01-16 13:22:44 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-01-16 13:23:10 ./start.sh
2025-01-16 13:23:12 ./run-tests.py owe_assoc_reject
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START owe_assoc_reject 1/1
Test: Opportunistic Wireless Encryption association rejection handling
Starting AP wlan3
Connect STA wlan0 to AP
Association result not reported
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_owe.py", line 766, in test_owe_assoc_reject
    raise Exception("Association result not reported")
Exception: Association result not reported
FAIL owe_assoc_reject 13.175237 2025-01-16 13:23:26.666384
passed 0 test case(s)
skipped 0 test case(s)
failed tests: owe_assoc_reject
2025-01-16 13:23:26 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250120/202501201310.71e65f29-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


