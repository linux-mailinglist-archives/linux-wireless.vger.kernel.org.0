Return-Path: <linux-wireless+bounces-28082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFABEE414
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D70B3497B0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F52877D7;
	Sun, 19 Oct 2025 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmYIn6XU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48822A1D5
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874861; cv=fail; b=WfppBpQzd0VWfjri46qaPMGUF6z1SxVatJPPp9fiKp2vzjqKg0hAINX9Uqh8KLIAm5dquKOvpE95O2G4g4FIVWRKui5ksQQMIxzA4hF9404I293Hy5t6w8ILeqkH5UxMqgiPyv8eDNMfbxBtQ9iOWJJ82bgZaYL9EbiD05c4ZzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874861; c=relaxed/simple;
	bh=GPkFOTvHjsNljl6YWxViaSxma8N2RxKnA7zKP42DQqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pw3DL0R8twjGrOhVro7T6AuKAk8dPRhpwSEAI10NfvjO82K13IK1p4vCnTWgKK7pdtudcWQKzv0bSJC1wHxB0XSH8TVuMJ3LPzj15KMp9GKRuStRS0sdcTFWU1pu/bCMDMAnZMWlLzDyaVvTgYlbcJProiLsWV0+WMHgUFtWfB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmYIn6XU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760874860; x=1792410860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPkFOTvHjsNljl6YWxViaSxma8N2RxKnA7zKP42DQqs=;
  b=YmYIn6XUWYKn8LspsORAjZCd4/i4cA15BqbJK19F77IDRBQ/YULCHnmq
   x2VYYBi3cI9+n8CSKaYTT/hrdlLBDmD16pIDpztbUqQmh1zMlNfFG3WDt
   7lGca8qoaWJPs+ucC9a8q74LrRyCSr8l6UjXLMOxQm0oHP+LtVD+IhMqY
   2ETL01vftolGLXjA84RIwkWT6mrQXG/7ONWIFs4+qyVliG1TWxUAp/D3G
   p4HTNA5f6VQ7obs9j7Zr65SvSkoPNdk3yCThC3q2H/KUgGHupLhSVGrx5
   y4CQ7yAG5Zpdgq1In6UqEHjTKo1ONOWRq5ouTEJyhXO9szBLNRcQiyVqu
   A==;
X-CSE-ConnectionGUID: 2zX/JuGxQgG/9xGQyLEYbA==
X-CSE-MsgGUID: xekszXHZR5u82ZwpZdgJ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74143663"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74143663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 04:54:19 -0700
X-CSE-ConnectionGUID: 1dNgAQijRGiPKRhwWtX+8g==
X-CSE-MsgGUID: vt9roSZ5ShevRe/3AppVRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="220265621"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 04:54:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 04:54:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 04:54:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 04:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkTexKc/Bbv206KXvjnW9jiCqcjPXZ1WgvIU0Ptn/RgP2vux5asAHCXR6JNTf7IDXha6/VItrAof9+PjkOi8DR1pIhLS6+33kaJgWuOeQm8/BEQx2qbyFq+7wEEukf/uAeKOmCsWjzc0vALmsIDz7Aa7xvLw9axxUIKMs6OOSfssCVLx9YnVmb+25erubA0Zt0QJwPQWY0gop133fYljH8LyOYLhYNWclrV4TEYykPlyfk2I9W+2ZngsWJnnjGoI/B8qHLJFlAYwi5zxiM/0eONHuNZRikJCZCQ4004t08TITWnqUd6UncqUGXchh/cyTJww+VqEq8ZF7Tn1LA5Lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPkFOTvHjsNljl6YWxViaSxma8N2RxKnA7zKP42DQqs=;
 b=T6E7NkrGyrgA9RXlfxNv0oE58owLMjdnkqlToyCNhfTEO96y6kxZsEcdrUiTRby0JqSAkBx3cuQtBlskBwGAS3vXYsFvf9U0IFlBrjm2dg65/iW6MyDlLOKKaSHGfGALLfS5aq78GCSquPBriC78hcVRktk99yNKD6a3QWbtLok2ssBaRAEc4rGS7LwkX87c8EyUBV2cdnHGAA0+LdXvlYBYVTEwsc5TbPeLTy1c/bTOm2YGwmRXCqteLJfTA3sw4LJxvtYFxVP2HhdyStm5IOCF4EummOF1v+85zb9G1A4agWOh15vPAfi0prVoFFbor7X5nqRZbIZZx24JQq304w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ0PR11MB6767.namprd11.prod.outlook.com
 (2603:10b6:a03:47e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 11:54:15 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%7]) with mapi id 15.20.9228.015; Sun, 19 Oct 2025
 11:54:15 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: RE: [PATCH] wifi: iwlwifi: Add missing firmware info for bz-b0-*
 models
Thread-Topic: [PATCH] wifi: iwlwifi: Add missing firmware info for bz-b0-*
 models
Thread-Index: AQHcPd3iF8Ac3mkpLEaEFC8KQMAlWLTJYYNQ
Date: Sun, 19 Oct 2025 11:54:14 +0000
Message-ID: <DM3PPF63A6024A9B48F90D1FB104CBEFC22A3F4A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251015141307.25305-1-tiwai@suse.de>
In-Reply-To: <20251015141307.25305-1-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ0PR11MB6767:EE_
x-ms-office365-filtering-correlation-id: acb4cf35-abe5-40bc-5d41-08de0f0639f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVZwaHdTQXBNTjJzbHI3ZGFGQmRhNk4va0VMY1NJcjE2NE9YNThtbFJsSkMv?=
 =?utf-8?B?TDhLSTU3Z0lXRTNZSCt5UmRwNk5CMEpmckR4Rzdvc2RlRUxyUkk3czNVZllJ?=
 =?utf-8?B?TkNJTnBaeEFaekdvQnpvaWNidVBaWUVxK3RLQjdMOEJVMTB3Q0VJTlhxQjh3?=
 =?utf-8?B?SDRIQVFxSnI3WUxtZHBSdTFsTUN3Y0tYSjhJNnQ3d1BMb0VrcW04bFZ4Ympm?=
 =?utf-8?B?WThhVWIraFNvZDhFVlg1N2pBUGl3Q0JGaWdDQnkrS0plWHhTTkdzRkZxZmVB?=
 =?utf-8?B?ZGRFdkE3SzU4Y0RNT1BnZUM5UGVWeHE1SUVaTnJYYWpobFRtUFl0aFBldWU1?=
 =?utf-8?B?WVY4S2JxSU1sdnhrZGRwWTYvT24rY3drdm8wSWZXR3JVeTFURHdxdUd3NjBp?=
 =?utf-8?B?blQ2VlNIT1BleEpwbTIwRC9KajRCTWNWZlJTaWxrOHFGejkzZ0tpVHZDTGlp?=
 =?utf-8?B?ZGJzQ2dNZUJ1Y0RsRk1ibk0xUFlsRHRQM0FnbCtvdnZnbmpFV3V1NU5nMVVy?=
 =?utf-8?B?eUxDMi9GWkg0WU5EVUZzb01PUmY1WnVROEJodk1ham9IdlJyVXBoVXNNbDZJ?=
 =?utf-8?B?b29TYjNNQjlSVTh3N3duUmxuWWpoZUhEQWJHVDlLS3hUWk54L3BQZTRDa1E2?=
 =?utf-8?B?b1lDTmY4TDhEelJDanIwNkxldEszSTVSUnptTlAwT3RVd0U4aStPemRZVHZR?=
 =?utf-8?B?ZHR1bnEyTTM5Uis0bEp3MUdOMVErWHRHZnNremZMUzJ4Rjk5dThhNzluWWtJ?=
 =?utf-8?B?MDdTOW5LUmVBTUsvSGZvcmpiWGFhK2JZTjR5QmpEZUlPM3IxOHpuRDJpT0VQ?=
 =?utf-8?B?TzVBbnZaSVdzZmt1TmZvRUlaS2k5alhHQ24xYUlKeExHMTQxMzM0dkR0V2l0?=
 =?utf-8?B?VTN3cXpiMkZlT3ZQOU94NnN2TS83cVNrOFJFR0ZaZEhiUEM3MnB0M2J5U1Mw?=
 =?utf-8?B?Tjd2VnNWdmZpeFZRVFBlbjE1VkhxNXVKMG41NktSTGJrWDFwUTBVeVpKT0c5?=
 =?utf-8?B?VGErdjY5Z1k3S1ROTFMrdWNxb0lLNGxJdW9RbnI4ak1ITU9ocGdPYVQwb1Q0?=
 =?utf-8?B?ektRamhIUUF1Nml0VmNNbHJwVW54YjFSSXRHZmZrMUVkNW1ISHZPRUYxaXFO?=
 =?utf-8?B?SjJnaXZtV21HL2loK0E4UlBvSTk2am9ITHlaMnp4bHBmSlpEcGRSRHAwU3Zo?=
 =?utf-8?B?U0xzV1NibXYybmlQdkxjSkJ4ZjJtQnZYaFBSZ2xaeUdaV3JFN2kwL1V0ald4?=
 =?utf-8?B?aUY4WWZPSEg0c0VoNDNROFFRWGZieE9tWGxaTDMzclc2b3BneUMzU3lkdmth?=
 =?utf-8?B?bUl3RktRVjgzamZtdWZ6Ly9NQXBTZFdWMmZ2V1pRdWlsRXNlZCt1NWpiS3kr?=
 =?utf-8?B?UmNHb0w3bWJXQndsRnBXV0I4ZnNHZnptT2NBWVUyWXBPbVhUcFJLcjFtWWQz?=
 =?utf-8?B?RWpvVFBzYlBhZkhhSlN1UDlaZ05NbS9CVXpobytMOGN3SU0ydVYySEk3eVJz?=
 =?utf-8?B?aHV4ajVWaVNNTmVOeVc5dk5HYnd5VGwyZlZncTlGMjBKY05GZW80eHhvQXE2?=
 =?utf-8?B?a2llaXRqZlpiVjljdGNhbWZTNTVmTGVBNjYzOXdmWW1EeGlNV2l4TmZUZkNt?=
 =?utf-8?B?ZFUrNUZkMGpXelhrdGt1WmlzOHIzWFJUdVU0WW5RajcrTWptWXJwZkFRTGV0?=
 =?utf-8?B?eUxobDBJZmNJenJETmlGU3o0Sm9teWR6em5UMFluZEpjVk80T3Vmc1FVRnZu?=
 =?utf-8?B?dGF0cjJMQ0RpaXNyTXhVUmVyaUpiaERTd1V0MFo3TVNyb2RFM21JNE5QNGgx?=
 =?utf-8?B?a1VXa1JQSkJiNDhicld6Z2U3V3Nzc3dMZVZnUHN5d3U2N0lIbFcvUlM3MVho?=
 =?utf-8?B?dzhRdGN3TlRvTUpudnN6dktiRGRzVWduRDcreDRCWkJiYTBIbG1QeExVOTZO?=
 =?utf-8?B?ZXZrcjZKYUVMUzlBUmJSNWtsWnllYXd3L2s0RTRldE44KzFTQXowOVd2TmVH?=
 =?utf-8?B?bjl1bUE1S3FzclM3anBEYlBsSmxRd1NxSjVyRC9yZ05xRnJmZ05wWWtvYjF4?=
 =?utf-8?Q?GCQWw2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NklNcmZjNlQ3Qy8yVXZ3bGhaWFNWVk54R3BLSFVxandUNTFsSUp1b2FsQ2ZZ?=
 =?utf-8?B?VG5adSsrd3RSYU5WM1h2alF5dHJnVmVvY1U2NVZwSkxEcXRXVUpiQUM3YlVB?=
 =?utf-8?B?RE1zK3cyaUhHcTJhc0laTVJWV1ZVemhkVjAzY3pMd1FaZW5JQTR2L1djRVdM?=
 =?utf-8?B?V0EzdmlOcW9VTUEzczkxcmx3cVNxRGJvOSttN0JjY29kd3JOK255aTcxZmFa?=
 =?utf-8?B?ZWx1U2V6R3A4WlNFTXVwZHhMZkcvZGQydkg5cmtBdGNYWVY3ZS9zbjFsc2Zu?=
 =?utf-8?B?ck8xaExTLytyQ0ZhTzUwVUhic2xFZHBSYXk3bVU2MEhVR0kyT2JJNzN0YVdP?=
 =?utf-8?B?elAzTExJYVBhVjc4UnYzT2s5emtOTldaUVJ3aHlQM09GN1Bxa1dUalhXMFhU?=
 =?utf-8?B?MFFKK3lReXl5anFpM0ZsajdPTUJDcURiTUhZeXdBem5MZjFNeFNickxLZ05F?=
 =?utf-8?B?OGJmMzg4VEpraDlheUhSQy81YlNPMitpZnU1YndCTGRFMXpFWXp3eWFISHZZ?=
 =?utf-8?B?dm5zdVpNMnVRcTFLcGk4UE5vLzFjSGpnTjJiQ1d0czZ6SC80emk0a1dMMXc1?=
 =?utf-8?B?cERxUXE0KzlRTk1MZWQ1WjFTQzNRd2pGMVlEZjRER1NIak1senJyUnJVNDk3?=
 =?utf-8?B?Rk11cndtSDM0a3FTQ3dsMkVPWExjVUNxdVBmZXRGN1ovYytDWnltOW93YVlv?=
 =?utf-8?B?NzRCb1JKanF3M0crbFB1WHNtTk5JK1lYdnNQN1g0Y3JHOHc1RXp0b1I4MUlV?=
 =?utf-8?B?QVl4bWlwNEZNemRMT0VyY2dnbkkzTnFWcDh3Y2ZxRnNQSWdTNlMzSXU1NXQ4?=
 =?utf-8?B?WW1KSXIwVkM4Y0FpUzVCY1RjeDVoditDQ0hlcUtleWtvTXhYT0UxRVFtWUVU?=
 =?utf-8?B?ZkZmdG5NcWx0amRLNmQrWklRK0twb0IvanF0TzRJTTRWNTFZRS9TREJHYTRE?=
 =?utf-8?B?NXU0MzZQT1B4N3dnYlRtWG5zak1vc2U3SFRiOW54eU1TWkQxdGY5V2hFSVo5?=
 =?utf-8?B?eG9hUVVvN29xZ0xmMFNhd1VMN1FlWTNicFpiQktDRUZMc1lkK3c2bkNSM3dH?=
 =?utf-8?B?TUMzb1VRYkJ2dW14b1dwU21IWWZ4ZUl5bjNJaWUvVU9kMGhVR1dvZ2dWYTZK?=
 =?utf-8?B?dmhEcndsVG5aN2xFRnA1aXhkWGtpZDNFUWtQTzYvZkF0QlduN3I5aGEvdmdT?=
 =?utf-8?B?elFZM0NYcGlTZ0wvN05KTGVjOVVOdG1YMjM5eE1NNHg3WDJwMHRUdWhoM2lw?=
 =?utf-8?B?RTRhTEE2WHhENlg1eWJNQWFtNXowYUJhVlNFSWttN25tbXdEdnI3dnBDRk1L?=
 =?utf-8?B?azZycDFMSVBCdHY2ZVJpQnNZN0UySWFEQmpTNDN3YVdzbVlodmVURmNVY3lF?=
 =?utf-8?B?N2NqRWRBbFJ2aFJhMkY3RnNzaDZES001YXV4TUYxZGZCU2k0RC9TTWNlL3V1?=
 =?utf-8?B?U25jaENzWktLY3BnZVJ3My9Cc056WjVBVmNsRkdQQzVhR05HR2F4cTB1TUFM?=
 =?utf-8?B?b2huTkhHSUhEb25UUmJ6SmFyQ1I4TG9yZWwxczZiaEpwRUFvN3pCbkhzb2g0?=
 =?utf-8?B?ckVOTHZkYUtYUU5xNGQ5QS9wSjBlYzBSVjlVdy9nWDFFcHFmbTR3MVZiL0ZM?=
 =?utf-8?B?MTlyU0crbWRNU2RFK2JkUXZEMUo1YUY4NEt4eGh1S2FVNmh3bGFYRzgzMEc1?=
 =?utf-8?B?OFRTRFhjVjdiL010N0V1WkFZRVJGZ2g5bHEraWR5V1dIWTBuMEl0a1hyMG1l?=
 =?utf-8?B?aHg1c1pTZGh0Tmhoa0pmOWNZSW9wY3Uxb2xhWThJelRaUWdvUXpOMktWbUFE?=
 =?utf-8?B?cXhwbkNwd2lhd29NRy9kdG90T21ZZytnVWtscUhkWEpXcW5OcjF6L25MS1pV?=
 =?utf-8?B?MzJwdXFweVdPWGt6SWFha0VzN2ViMVZNSHVZL0w2WWcyYlFWbzdEUmJsUm1h?=
 =?utf-8?B?Z0JWSVAwTWN0T1NmM3dDNUdzWjR6UFBrZGE3cm9rcklRSFFKTFJIbVhkdzUz?=
 =?utf-8?B?ZlNHbmxTTWFCY3lTaEUvREIxTldvbnhyR1ZVcFNqRisrZU03K3hRREZqMWNX?=
 =?utf-8?B?U0hRMm5pbGF5T0s5akx3aGxoQ0JvOTQ1YTQrajU5aWZ3OW5hbVpZSWI4WEhu?=
 =?utf-8?B?ckFKeENNRVNYN09tTi80N2p3RDd3U0R6aGlKWm1HM080Mll3eHA1RDgwdExk?=
 =?utf-8?B?VHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: acb4cf35-abe5-40bc-5d41-08de0f0639f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2025 11:54:14.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0LnY6X8YdMBr2weZCQFnnt+udaHIDwy6yrkw3xzRFncHg6CXe6LQWktbzyZYdRK9nsts72WoBmt3CIllqiCJmwDVV7NXsd4Qg1huoSXPpEj4N0qMR+tL286/Yend8Oj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
X-OriginatorOrg: intel.com

DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEJlcmcsIEpvaGFubmVzIDxq
b2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSB3aWZpOiBpd2x3aWZp
OiBBZGQgbWlzc2luZyBmaXJtd2FyZSBpbmZvIGZvciBiei1iMC0qIG1vZGVscw0KDQpQbGVhc2Ug
c3BlY2lmeSB0aGUgZGVzdGluYXRpb24gdHJlZSBmb3IgdGhpcyBwYXRjaCwgd2UgaGF2ZSBpd2x3
aWZpLW5leHQgYW5kIGl3bHdpZmktZml4ZXMuDQpTbyB5b3VycyBzaG91bGQgcHJvYmFibHkgYmUg
W1BBVENIIGl3bHdpZmktbmV4dF0gLi4uLg0KPiANCj4gVGhlIG1vZHVsZSBmaXJtd2FyZSBpbmZv
IGlzIG1pc3NpbmcgZm9yIGl3bHdpZmktYnotYjAtKiBtb2RlbHMsIHdoaWNoIHJlc3VsdHMgaW4N
Cj4gdGhlIG5vbi13b3JraW5nIFdpRmkgb24gc29tZSBpbnN0YWxsZXJzIG9yIGltYWdlcy4NCj4g
DQo+IEFkZCB0aGUgZW50cmllcyBmb3IgaXdsd2lmaS1iei1iMC1mbS1jMCwgaXdsd2lmaS1iei1i
MC1nZi1hMCBhbmQgaXdsd2lmaS1iei1iMC1oci0NCj4gYjAuDQo+IA0KPiBMaW5rOiBodHRwczov
L2J1Z3ppbGxhLnN1c2UuY29tL3Nob3dfYnVnLmNnaT9pZD0xMjUyMDg0DQo+IFNpZ25lZC1vZmYt
Ynk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9iei5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9iei5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9jZmcvYnouYw0KPiBpbmRleCAzZTYyMDZlNzM5ZjYuLjQ0YTAwYWNjZTgxZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvYnou
Yw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9iei5jDQo+
IEBAIC0yMiw2ICsyMiw5IEBADQo+ICAjZGVmaW5lIElXTF9CWl9BX0ZNX0JfRldfUFJFCQkiaXds
d2lmaS1iei1hMC1mbS1iMCINCj4gICNkZWZpbmUgSVdMX0JaX0FfRk1fQ19GV19QUkUJCSJpd2x3
aWZpLWJ6LWEwLWZtLWMwIg0KPiAgI2RlZmluZSBJV0xfQlpfQV9GTTRfQl9GV19QUkUJCSJpd2x3
aWZpLWJ6LWEwLWZtNC1iMCINCj4gKyNkZWZpbmUgSVdMX0JaX0JfRk1fQ19GV19QUkUJCSJpd2x3
aWZpLWJ6LWIwLWZtLWMwIg0KPiArI2RlZmluZSBJV0xfQlpfQl9HRl9BX0ZXX1BSRQkJIml3bHdp
ZmktYnotYjAtZ2YtYTAiDQo+ICsjZGVmaW5lIElXTF9CWl9CX0hSX0JfRldfUFJFCQkiaXdsd2lm
aS1iei1iMC1oci1iMCINCj4gICNkZWZpbmUgSVdMX0dMX0JfRk1fQl9GV19QUkUJCSJpd2x3aWZp
LWdsLWIwLWZtLWIwIg0KPiAgI2RlZmluZSBJV0xfR0xfQ19GTV9DX0ZXX1BSRQkJIml3bHdpZmkt
Z2wtYzAtZm0tYzAiDQo+IA0KPiBAQCAtMTA0LDUgKzEwNyw4IEBAIGNvbnN0IHN0cnVjdCBpd2xf
bWFjX2NmZyBpd2xfZ2xfbWFjX2NmZyA9IHsNCj4gSVdMX0NPUkVfRlcoSVdMX0JaX0FfRk1fQl9G
V19QUkUsIElXTF9CWl9VQ09ERV9DT1JFX01BWCk7DQo+IElXTF9DT1JFX0ZXKElXTF9CWl9BX0ZN
X0NfRldfUFJFLCBJV0xfQlpfVUNPREVfQ09SRV9NQVgpOw0KPiBJV0xfQ09SRV9GVyhJV0xfQlpf
QV9GTTRfQl9GV19QUkUsIElXTF9CWl9VQ09ERV9DT1JFX01BWCk7DQo+ICtJV0xfQ09SRV9GVyhJ
V0xfQlpfQl9GTV9DX0ZXX1BSRSwgSVdMX0JaX1VDT0RFX0NPUkVfTUFYKTsNCj4gK0lXTF9DT1JF
X0ZXKElXTF9CWl9CX0dGX0FfRldfUFJFLCBJV0xfQlpfVUNPREVfQ09SRV9NQVgpOw0KPiArSVdM
X0NPUkVfRlcoSVdMX0JaX0JfSFJfQl9GV19QUkUsIElXTF9CWl9VQ09ERV9DT1JFX01BWCk7DQo+
ICBJV0xfQ09SRV9GVyhJV0xfR0xfQl9GTV9CX0ZXX1BSRSwgSVdMX0JaX1VDT0RFX0NPUkVfTUFY
KTsNCj4gSVdMX0NPUkVfRlcoSVdMX0dMX0NfRk1fQ19GV19QUkUsIElXTF9CWl9VQ09ERV9DT1JF
X01BWCk7DQoNClRob3NlIEZXIGZpbGVzIHNob3VsZCByZWFsbHkgYmUgYWRkZWQgdG8gdGhlIHJl
bGV2YW50IHJmLSouaCBmaWxlcw0KKHllcywgSSBrbm93IHRoZXJlIGFyZSBhbHJlYWR5IG90aGVy
cyBoZXJlIGJ1dCB0aG9zZSBzaG91bGQgbW92ZSBhcyB3ZWxsKQ0KDQpTbyBmb3IgZXhhbXBsZSwg
aXdsd2lmaS1iei1iMC1mbS1jMCBzaG91bGQgZ28gdG8gcmYtZm0uaCBldGMuDQoNCj4gLS0NCj4g
Mi41MC4xDQoNCg==

