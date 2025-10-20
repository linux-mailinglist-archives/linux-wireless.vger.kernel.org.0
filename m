Return-Path: <linux-wireless+bounces-28109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D814BF1E2B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406E718A3F63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9514A3E;
	Mon, 20 Oct 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuRZbn48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0E1DF270
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971116; cv=fail; b=NOD3WOpRlgUSAN/X1lr8CYXoeAvr9SYAGuldFkAv6EpcLkw1ZpjtqV+u+e3ndgb4oPiybMXytb7K+uRXSn5PwjWVNX5SVBJT9nauBjT4nH9qfBpnF9+BwA3yFJf5emh8Pzt/LpmZ1FpLD3jyc+eZJ8A/RYwRxEYbo0sdNEyS/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971116; c=relaxed/simple;
	bh=s/NJJ3OXuS9l/Vfb9z1/xitlMKX2J06sFvLJ7DATKVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAZxTNySvbBaSDaSkyxPi22lZApIF3sXpE73eKgNcDat6jf3MadPGkPBtVr7L6hal2KCZVwIpSnkpolZWFGmTiG/4YvlezxN11jPPlJVaUP9q0faMHr4M0JwIFR3vqY/oG4rVpYn24FeLu6G1N93CKES6LsgGG2/ZfiWidQ03ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuRZbn48; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760971115; x=1792507115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s/NJJ3OXuS9l/Vfb9z1/xitlMKX2J06sFvLJ7DATKVM=;
  b=UuRZbn48RvIVNj/RwKJVmUTBdN3o8AtFpmBa+p8IgH3OcOE3jhtqgPSn
   H9h382qlod1H02eOExGcsqamOpq6hXorA0LQiOQOgkepWi2FPfCPH70Y1
   quhNYmPXKlOdyMHp8L/vcRkyL6qhQGZaSRewPYmAo6BOGh8WK7VE1b8Qu
   And0kJaDa/A9EP6t3laZKbAzFvmuYPjw9NblRwBKud5bkXBGs8sikqqRz
   /OIXaeS4T2GcBiW+TQM5A5cFPNrAu4+plhmjJdgFlSjDXDzKbEaJkjRRd
   dfPXNPcXeC9CKN4pXwICSEdFylWb0mPyhGlBD6B05PwczGRIz+7R51JBv
   w==;
X-CSE-ConnectionGUID: 7oOV0bWCR0ycVqGyyuLS9w==
X-CSE-MsgGUID: MqkH+puNRe2RoZX4xLnIfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80524443"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="80524443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:38:35 -0700
X-CSE-ConnectionGUID: odMWAKJjT8C9Vb/YRD0GsQ==
X-CSE-MsgGUID: zqCwICe0SXOO3u0/Btmz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="182896756"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:38:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 07:38:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 07:38:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 07:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftKdZaXFVo8TMYYlRuXRllPy5sK/JcubZRSPqdP+8NU1yZmbu5uyHTvt0wL4pjlGF3V8z9WFnNUGIc7C7pFUa575bXZMdeH2Vy2Lsb8YwQGF5o0j7t8T94+nj7t90HtQLFdpAlcvMGu970X1OZr12Za6jELRRdk8Cu7gHXJmcpMFLv1b3lsoVWKje/xdjZXTo6FiVbPriEQjaZudg7iSuCG8HoNPOhG53FeUOcIRVzTFPuhKL/6STGq+Iiz4x0WvZVwd1Y4GE3VlfbSWTVhLjDTzJ0tZKZafomdIWo0SYYrOT3+3zXZOl9q5irszwJCIFZFA3mgKSl/ABSWXgsBmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/NJJ3OXuS9l/Vfb9z1/xitlMKX2J06sFvLJ7DATKVM=;
 b=ka+kHtXWmVUOLyaSI+n4CzYT57R/pVP53KO8hlw00Dc061RTaKA8D/QRK4OXDZp4ez3GAW+Z4nAAy1/H89CVCj6o1nUJUdHu+yFhOz2+Pc61Ku7sWtKY+dFF3GT0ZvJVJOYK3fKDSQxxr21s/fldWt5PlDdegUk9nRtBFyOd6RVpIntfiGTil5pn0RX7GdmQQblZSY8dsXi0NlagjCHs0KckRjuJR1Bh36NPL/qqJKPEPRS/98tK1642uUl2pfhO6kn0Zch+WzgqninVnhbDrjyinMSx1V4f7ndsgV7CF7xPH/Zf1t9sOTYbqc0sdmYmAuQXDfn+DwokHol+N5VDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) by
 SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 14:38:30 +0000
Received: from DM4PR11MB6432.namprd11.prod.outlook.com
 ([fe80::8b2:9c72:8f9a:8280]) by DM4PR11MB6432.namprd11.prod.outlook.com
 ([fe80::8b2:9c72:8f9a:8280%6]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 14:38:30 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"jeff.johnson@oss.qualcomm.com" <jeff.johnson@oss.qualcomm.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: nl80211: call kfree without a NULL check
Thread-Topic: [PATCH] wifi: nl80211: call kfree without a NULL check
Thread-Index: AQHcQZdEKgv7PZWqY0KVnryJCyOwhLTLGgwAgAABKYA=
Date: Mon, 20 Oct 2025 14:38:30 +0000
Message-ID: <683ef3677fae404c40aa49e022048151df6e7265.camel@intel.com>
References: <20251020075745.44168-1-emmanuel.grumbach@intel.com>
	 <39434456-04a5-422c-a42e-9c4ef40dbe8e@oss.qualcomm.com>
In-Reply-To: <39434456-04a5-422c-a42e-9c4ef40dbe8e@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6432:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 00d863f4-80c1-40f3-520b-08de0fe656dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QmR6b2F6RE9EajVtcHVOb0ZWZkxITFh6Q29xSng3cWJFaENMRkNXWFhpbmJz?=
 =?utf-8?B?akROMm0rRkpLT1c3cGdFWnlvZk9TNXMzcHhBbzBieWlhRlRtb2VsYUFKZ3k1?=
 =?utf-8?B?MUlBR01wR1pZSHJLTkIvUnBBSmhnWnVZSk5LQXNFUk5uVlFkYTRtdmU4Z3Fm?=
 =?utf-8?B?c3F5czQxc2VJaTQrc1lnektsOUdHMUNGWkkxUDFIZk12NVBXZ21JR2I4QnZ4?=
 =?utf-8?B?MTZvS2FmMmUzekQvRW5qWTJlRnBTZitDR0tZZlNIazJrSE5tVElIUnJmZm1s?=
 =?utf-8?B?M2VBT0JIa3JzTXZadDVkV3RlRWdnV3NDSWFYQ3QvUWpkVXM3VjhrNm5XNWdn?=
 =?utf-8?B?TnJ6anRkTWJrd1NQZjhtc3hMT2F3SnNzWFUrT2diQ0pKUkNpQ25rd1ZMRWNG?=
 =?utf-8?B?NXVMZ1IzRHJ5ZU1oaThwU09YZjhFUTAvOWRpckZpSVU3VnJKRmJCZysxY1Fy?=
 =?utf-8?B?M3ZBVlI5aG1hMDRLNUc3bVJOQVN4ajlYNTZ2Y2grSXdIWmZWOW9PZjRIeFh1?=
 =?utf-8?B?dmJjY1ViMlowM1JiZ2hFeUY5NWRnUnJYM0kvOXA0ZHBraDRlc2QzQUNqUklS?=
 =?utf-8?B?ajc0N3hiN3BLbUdHM3h4eW9iSUhpMTIyWmhEYXVTRXdsdnBsTjg2Vkhvbnh4?=
 =?utf-8?B?T2NGVU5jdkVqUTNDRERTVVQvS3VoVjMwOU9TS2lqUFlFVFRhMHZUV2tiTjdE?=
 =?utf-8?B?MkFJWS9jV0JaVXgwcmFJR3RsWFFHeU9GblJhTjR2YzUwM3BIUW4rdnR0YXNU?=
 =?utf-8?B?Q0l1b0pEQVZDRUFHYlNTeFM4TDVNQVpHbjhhTFNSei83dUl3RFlJeGRmT0s0?=
 =?utf-8?B?WEJQWmhyd2hMNDdkQlg0QzBIeDdKbW5XZ2o0R2xDdzJURDJyUDRUcXp2Ylhw?=
 =?utf-8?B?VGJqeFhMT2FCZGVTSWdyV1Njdm5DbjRTQkNtTm1RcDl6RllVelUxU0M5N0R6?=
 =?utf-8?B?SFVlUUFRRkhlYTFaTlUvVjdtNXE5Tk95dnNzMVpBbGxQbis4QkhGQVUzV21x?=
 =?utf-8?B?YlN3NHhiMHpMK29ybjVXdkc1YXV0RmQrZ0FYbUJ0OEJ4WllEbXpiMm1yd0hC?=
 =?utf-8?B?RWFHVVl4WWVxRDhaOGVBOURZSVpKeStHcWhOV01zTlhhck9qaW1URDJ6aXRV?=
 =?utf-8?B?emxralhHYlFlY3pBeG94ZXFYOTJRTDJjR2NCSjE3b0xvUURueUcvakZPR2tH?=
 =?utf-8?B?R2lzcXh6NGFwemphMi9Obi9GeUNteGw4TUlBdnUvdjBvVGw2elRVOUhvYnRE?=
 =?utf-8?B?MEtxc2xXWG4rTFhDQ2VraDM4THAxVlFXWFlNOHBIK1c0eS9lWUEzbmROMjNI?=
 =?utf-8?B?NTFlVWtIVFZ0elVkdVFlN1RsK29XRTRMNThmWURRZjhWTlRXMDJibEx6eHZH?=
 =?utf-8?B?Kzh5L3pYYmV3UVAvRFpMQkF2eTRLRHM2Zi9VUGtYWitYS2VBTlNNbWZid3dn?=
 =?utf-8?B?WXdxNDlqNFMzRlRUYmdYTTk1NFFQN0xScCsvc3hCR3hwdDdwWlpOMjBsRUp3?=
 =?utf-8?B?V1BjVUszaStxTCtLYS94SUJwdWJkYm5FYUpKUUlSbU9QTzZCeEppT05PR2Na?=
 =?utf-8?B?N0dqY1oxaEhTK2UwN2QwUVNDdzdYVmE3N1NDcjRGcSsyZmJQUG1BbTdMbjVL?=
 =?utf-8?B?WFdaOTZYSUtRL0tMeGlBNnpPNW9OT3FKUDV5VWtxYUltZzIyaXJIVktLLzRw?=
 =?utf-8?B?MThycTlaNDJVMVRzcWovTlJNSEdnb1I4OGFOdVJTaHllcEFaUFhlQ0VpQ0Z0?=
 =?utf-8?B?b2xQZHU3Sll5b0lyUG96SjJQZkk2SkdGeDU2c1Z4QVQvN01yK2xwNlJkUDlC?=
 =?utf-8?B?R0Z3NHVJUEc4ZFk0a1N2dnFST1ZJNUNtcFMwVmJtSmhiN2k1NWR5TGUzV2Iy?=
 =?utf-8?B?Z0FzYkpKc21QWlh4L2VXR0wvMXVMdGxGUjlVQjJFNGJFUE8vVlBDWnY1YXdi?=
 =?utf-8?B?ZENEVmdqb0dLSDdNWmhKSnVkMEpwQjhXY2RlSXlMMXFPVmQrd2Z0NW9YNkU4?=
 =?utf-8?B?YTJZRkVDRElmaDc2MXpBS0hSekoxRllHQ3NjUjVzYzI5THpDem5pZXFGeEpu?=
 =?utf-8?Q?paHIsH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6432.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a014eThvcTFxay9sbnVtNGlBbmFUNWtySmJPZjZSMmlubzRNUnlqSDQ4dER4?=
 =?utf-8?B?UWRTM1h2UkM0K052Q1dYM1JqQi9IRTk0NTQxZmtrNjRtNlcwVFJueTNZYnY4?=
 =?utf-8?B?QUZJUUNLdFMrbm1EWlpQbGlRN20wY0FiSHE2ZDl5MTZKT3JzVWQ5cVBrMGdQ?=
 =?utf-8?B?MDRjb1pzUVJvNEsrOG0yRmsvVU1EeW1zNjQ3bHpGTW9hYk5iRUgyaHl3NWNu?=
 =?utf-8?B?RjhYSjVvdmowL2Q0RTVtdnNoRWlJQ2tzOWRkTDEwY2lVUHVMMFN1S2toUENB?=
 =?utf-8?B?OHk1YVJrekxWR1R1UFUwUE1HSXhDLy85TnlleVhCaXNldWYrd25zNVFIYTJX?=
 =?utf-8?B?S0dvOEhHeTlGK0RjeUprc1dydFpHZ3A3cDV0YWJESDUyOUJncGYrZk5BSTJ5?=
 =?utf-8?B?bFNDTnl3ejFGWEZKWDdIdjdscVE5MzRiQjFQZWhaSWRhVTBNYkxXd0NOMHNh?=
 =?utf-8?B?eXV1Y3JaYUlYd2kyUisreHUrVTJHc1l2TlhESzdWSFIrRkVJZHE3emJmem1W?=
 =?utf-8?B?Rkl6S1dBdGRXSWREK0pXeGtscUtRYnQwR0ZGamJzT29VbjZhRm1yWVd5Q0xD?=
 =?utf-8?B?WjlxTk4zd09LVVR3Mmg5TVM1elZjbGpnZXFVbjJPZFhlcTBSa2plVTNpaFIy?=
 =?utf-8?B?SG8yZ3JSNlZTVHoxRjBNOEg1akVJZVdYZUd3ZGFnSFEyYkwweEZ3UHliK05N?=
 =?utf-8?B?c3NPcFdWRWlZc045ZlpRUUFyOTNaQ29ndUJDZ3Rab2hOU3dSM0NCQTc1VDlx?=
 =?utf-8?B?aERIRC82RnpsYWM5MEFSY2lPUGRmTHVBcGsrYWxnUVhtR2Z1bE5KOWVIR2ZY?=
 =?utf-8?B?ZzM2MkRaVnZhUEg3czFLN2h0SlBLTFN1TjZqUFdCMGVIaThFSmRCR2ZBMzlr?=
 =?utf-8?B?aVkxSkpCTHM5bml3YVVtRFlwb1FINEpodGMwMThpZEpLT1hyODEzNDB2dDJS?=
 =?utf-8?B?ZTVYQUJnb2Njczd3aHBiYmlzRFdjdXlNdk1ZVXBUUFEvNFFLWlE2UUxYMWlz?=
 =?utf-8?B?RGlVc09uaUZTN2xuZVVZeVExaU5IT2NndDRFNW9DVzJlZlFlZFhsRVBOSmd3?=
 =?utf-8?B?SFlzQVMxZVZLdVRLY2w1WW5NMzBHb1Y0VDFsbENLZ0Q4NzVtdzdkV0F2ZEJn?=
 =?utf-8?B?b1YyV0N5UEVGOUVYb0V6RHZJUjZ5SE9vNlRjZHV6WFlYN3N1VDI2anlnd05K?=
 =?utf-8?B?ZlMxMFM0STVtUTJZb1JIYUhJbTJ0L0ZqY0hmVklia2Q0UTI0c2ZsQUhrL29r?=
 =?utf-8?B?ZXBKWnR2VnlZTkJkSmJQR0NRR1NKSkdjL0poS2JGdHVlRVRCaTJickJJNmRI?=
 =?utf-8?B?VHJoejZyY3Q2SzZ2dXFGMkNUMWtLVE5Sb1laSzB0VHcwTnlOb3BFU2RjY3pO?=
 =?utf-8?B?bTExM0lUWmRyNFlVa2w5b1VJMUtHcnlGZkdQTURpQTlnbnYrbnBKakFBMVJW?=
 =?utf-8?B?UmV0THdndFRWLzk4S01aVHE2eThuM1FMSGlvd1Jpb2lvVm9Edmd1QWVCN1Ex?=
 =?utf-8?B?UFJsdjFXOVM1amhVd3R5RE1ZQ21PYlJnMkxSbFFISnAxRnJMQXZkRTJmdHZN?=
 =?utf-8?B?VVZ4VldLQ01XRVhUQi9CM2IzS3Nib0gvR2p1UXhXcHRlZmhEcTZLd1JiRmV1?=
 =?utf-8?B?Ly94ZXlSWnROZS9SczRwb09XNHBHcWpjVlRwYmZ4SXVQcGZ1L2dvN29SYU9L?=
 =?utf-8?B?QkIvck1LTHR4R3NaRnRCclQvM3lGc2dRenMvZGs3eE5CenI3N0J0eXJMNWdl?=
 =?utf-8?B?S1QwSzhJVkJpdVdNaVVHL1Iwc2ExYTVQSnY5MXBaVEpTMFJ3cGJJMk9OZENX?=
 =?utf-8?B?ZVJxZytFR2t1TlZFVGJKV0tZZDN3ZzRjSS91NXFBcERCdjJNbnlna3NnTCtF?=
 =?utf-8?B?YjVqWWJibHU1VUZMb3RNeGhlNmswT1JMRkY0a29STUM3SldhVzhHamsrV0R0?=
 =?utf-8?B?dG1OdVIxWFNIUlFoelo3R3p4eVR2R2o2U3k4cG9RenFqVGRIVnhWNkFKamFI?=
 =?utf-8?B?Q3lyTXlFUk1jL2luVTZiUDZsZ09SZ3QvOXRYTUxJRURMUy92NTM2MGwzUWk1?=
 =?utf-8?B?SGQ5NHJMQlkvUVJQS0FidXlwWkFuSVZmVDErTUdNYTVGZHlQYTYvcUUwWWVp?=
 =?utf-8?B?dC81OTM0NXd3UjlwSmMxOHE0ZmMzZVFlVDNsK2s4a2ZRVVBrVjR4RWhOZlpX?=
 =?utf-8?Q?VKO20p4rwNgVIyl0KPH36L8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C47680DD13CAC44788956E9A2AB0578B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d863f4-80c1-40f3-520b-08de0fe656dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 14:38:30.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQbFLQwF3pymsNTbVBzkJpkBfLABkXdA4bEXwWigRuYMOTX8ocLGGVFIhaYGWSAL1xKEEmv2x0pFO7P54T1ivDonKcSpOgWMtucjU5FkZLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDA3OjM0IC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6DQo+
IE9uIDEwLzIwLzIwMjUgMTI6NTcgQU0sIEVtbWFudWVsIEdydW1iYWNoIHdyb3RlOg0KPiA+IENv
dmVyaXR5IGlzIHVuaGFwcHkgYmVjYXVzZSB3ZSBtYXkgbGVhayBvbGRfcmFkaW9fcnRzX3RocmVz
aG9sZC4NCj4gDQo+IElzIHRoaXMgYmVpbmcgZmxhZ2dlZCBpbiBhIHB1YmxpYyBDb3Zlcml0eSBp
bnN0YW5jZT8NCj4gDQo+IEkgZG9uJ3Qgc2VlIHRoaXMgYXQgZWl0aGVyIG9mOg0KPiBodHRwczov
L3NjYW4uY292ZXJpdHkuY29tL3Byb2plY3RzL2xpbnV4DQo+IGh0dHBzOi8vc2Nhbi5jb3Zlcml0
eS5jb20vcHJvamVjdHMvbGludXgtbmV4dC13ZWVrbHktc2Nhbg0KPiANCg0KIE5vdCB0aGF0IEkg
YW0gYXdhcmUgb2YuIFRoaXMgd2FzIGZsYWdnZWQgYnkgb3VyIGludGVybmFsIGluc3RhbmNlLg0K
DQo+ID4gRml4ZXM6IDI2NDYzNzk0MWNmNCAoIndpZmk6IGNmZzgwMjExOiBBZGQgU3VwcG9ydCB0
byBTZXQgUlRTDQo+ID4gVGhyZXNob2xkIGZvciBlYWNoIFJhZGlvIikNCj4gDQo+IElmIHRoZXJl
IGlzIGEgcHVibGljIGluc3RhbmNlLCB3b3VsZCBiZSBuaWNlIHRvIGFkZCBhIENsb3NlczogdGFn
DQo+IHRoYXQgcG9pbnRzDQo+IHRvIGl0DQo+IA0KPiA+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBC
ZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBKZWZmIEpv
aG5zb24gPGplZmYuam9obnNvbkBvc3MucXVhbGNvbW0uY29tPg0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBFbW1hbnVlbCBHcnVtYmFjaCA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgbmV0L3dpcmVsZXNzL25sODAyMTEuYyB8IDMgKy0tDQo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL25ldC93aXJlbGVzcy9ubDgwMjExLmMgYi9uZXQvd2lyZWxlc3Mvbmw4MDIxMS5jDQo+
ID4gaW5kZXggMzQ2ZGZkMmJkOTg3Li4wM2QwN2I1NDM1OWEgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0
L3dpcmVsZXNzL25sODAyMTEuYw0KPiA+ICsrKyBiL25ldC93aXJlbGVzcy9ubDgwMjExLmMNCj4g
PiBAQCAtNDEzNiw4ICs0MTM2LDcgQEAgc3RhdGljIGludCBubDgwMjExX3NldF93aXBoeShzdHJ1
Y3Qgc2tfYnVmZg0KPiA+ICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+ID4gwqAJCQly
ZGV2LT53aXBoeS50eHFfcXVhbnR1bSA9IG9sZF90eHFfcXVhbnR1bTsNCj4gPiDCoAkJfQ0KPiA+
IMKgDQo+ID4gLQkJaWYgKG9sZF9ydHNfdGhyZXNob2xkKQ0KPiA+IC0JCQlrZnJlZShvbGRfcmFk
aW9fcnRzX3RocmVzaG9sZCk7DQo+ID4gKwkJa2ZyZWUob2xkX3JhZGlvX3J0c190aHJlc2hvbGQp
Ow0KPiA+IMKgCQlyZXR1cm4gcmVzdWx0Ow0KPiA+IMKgCX0NCj4gPiDCoA0K

