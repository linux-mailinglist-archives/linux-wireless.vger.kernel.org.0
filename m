Return-Path: <linux-wireless+bounces-30845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB6D25287
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FAC9300EA0C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D43A7E0E;
	Thu, 15 Jan 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeI1bW/M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706B3A784E
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489202; cv=fail; b=Q91TLyBK+goM+77NF4XCYRwwrvmVARAifGMY98gw7d4vb6gvvDQv9CtCReCSZ3TZcSK/tvKu/5zXlWlNEdxWO2IuYEx/9OEFA03LlqdLEz2jLBN8hSpAkFoKJXKCmI+UppWS2khxde7D+M2osfHksjswygekQ1wOOwvSEqie6vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489202; c=relaxed/simple;
	bh=l+pgJ6Nzc2mEZ8pLMx+TdahvoCNcm1bN6rxgEeM7u9I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RfuoGlM0U3fygfcZRqrQUQbB3nY4NMU4jr3709anBDCLn/IK7Z20Sc1nnyyRMI0Q7ypW0eoCrrFZ1PYiKAuzqOmv9umeHxFQWbhYbGNzN5smGAmuOoca/o5VcK8WbBFNuXOqg0sXx/j1NM8hAW/zmmsssutthw2KpnW42AWGhwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeI1bW/M; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768489198; x=1800025198;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=l+pgJ6Nzc2mEZ8pLMx+TdahvoCNcm1bN6rxgEeM7u9I=;
  b=BeI1bW/McZv3iHrLl6mOgvRMPVP/EN+5qykTGLoMNwq8r7n562oRPONZ
   OgnxwJ2Y0PvPuFn2ryEYG3glLPldE8O2Jtx4oqtqObsE04ZTV36GkyMnS
   3grjX6fwfhiuUD8zCrkeUub9wvSQ5IfSvEcQcscUbYmNfD/lk7iWRLpe7
   PoK97m7QbCqazigg1F32OG1OCY7EBxuJcx5JjmfD0UHRLLusjyGfS/cg3
   Dr3r09x9o1zeWjucz7e0uurs7OBWy+67akygrHJUZW7DpP+1yK1iQoEs3
   UjVn23keI7AtWLq7xcCosH6nfFuI8IkW8/bq3mCFhj+rdku3jA5aBpQ9p
   w==;
X-CSE-ConnectionGUID: TWqoLhnDS5mY2Cuk5sM+ow==
X-CSE-MsgGUID: xWwqRLLrTFy5ieRIqH9MhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69774996"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69774996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 06:59:55 -0800
X-CSE-ConnectionGUID: mAj6OphiTUmwkEy5Kxflvg==
X-CSE-MsgGUID: fMAW07j2Q0OWAEVwnfGy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209479522"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 06:59:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 06:59:54 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 06:59:54 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 06:59:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLbTfagm5zD1y/vbElVhwFk0j52cLps5jlkXZss1bDvXS+hTQrVSoljGVjfFsLTF2OE8zjP8sDKUdCg/aZFjCK3IXuWoR7kIvL/3/v5LXnc6rqvMMPsOAZjKCb/YOXgXrOOPZhfwzA4WyOBk/XzNVjAJ5c1hrMDe1ORgRgPB9z5wj6o/myG3M2or9M4+/UKBs4Sdw3wqzb/TXLQZ7XIJdT1zif3sgpGAOd3JWm7lYlpDJFCx+HpZyQaNYEcy1NL5HYkMcjQ/FP190uMn5VAUYyI2W0FRi1h/4RWNh6srW9A3Aw93pT8LQHw9Pm3TN827xOngZx8EYPh+pgk7DAdJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+pgJ6Nzc2mEZ8pLMx+TdahvoCNcm1bN6rxgEeM7u9I=;
 b=ZvudoOq68J/UIhiwqw6KNoFBDxvBBCzFk2w3WCjWNld+LvIkGMDoOK7cYVWho5YixtLQHUQU1iqRQCmp/bUnCZHVSyo3ntJJZuSgnjZsHNMvCj9BbFTuDXvFSJJa04fXVsee2E2+23yDOiCQr1YFuKArkuB0Wxr+nvjKYwcwWfVR+H9lqCKJZnFu2a91vPzSNeTeAQ+02gF1vW9oNL3YMmUcYI2BZdJL435TN4l+pEkjMroIXntspCIwxXAu71NG/outeAN5k0ABAKTLjijND+XGz353K9F/rwnxVFVzz9d6CoiOT2geQZjpwJxecgMRHNtkzdgZK7/YXxm5GtHlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA3PR11MB8047.namprd11.prod.outlook.com
 (2603:10b6:806:2fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 14:59:49 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:59:49 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben"
	<ben@decadent.org.uk>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, "Yang,
 You-Sheng" <vicamo.yang@canonical.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull request: iwlwifi firmware update 2026-01-15
Thread-Topic: pull request: iwlwifi firmware update 2026-01-15
Thread-Index: AdyGL0X75O+elNlRQbelrIdiOkG0sA==
Date: Thu, 15 Jan 2026 14:59:49 +0000
Message-ID: <DM3PPF63A6024A90C1E91457AE8636FBD67A38CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA3PR11MB8047:EE_
x-ms-office365-filtering-correlation-id: a8859824-0ef1-4978-7c08-08de5446baef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RGJSWFIyMEF4SWZ4cERDdDIwNEpjV09saTBJUWtYMHpSZ3BvOFd6TFBpaHZ3?=
 =?utf-8?B?R1ZZZEFITmZEMTlvUGtRdVUxOUEydXUvTFdmcElnMkFoTzFGaDJVbEpzMEdC?=
 =?utf-8?B?cUlwUFBQdmhld0JyZW91by8vYSt4NjlSZVNYcHloT2kwUkZPT0lSTk9pV1Ry?=
 =?utf-8?B?cGlwUSs2OFFkWWFkYmVTQzZHL1V4Yy90azRTT2diZ01pNUwxaE5JTjRvMTNC?=
 =?utf-8?B?dnRtU0dLYUJyV3BGUnBNL21TejNzQ1B3OGZvZ0duY3ZPS1BibmkzZTdDTGJz?=
 =?utf-8?B?YWM1eVcrdmx6R0RoMGYwdnVZam9GV0FERVRZSDRzNGRLSURsVFMwUmlxUTRE?=
 =?utf-8?B?WitEbk1qM09Qc0E3aXArTDRUYzI3aE5GN1pjcGp5MlVoTlRmeGNYWmtGeFFU?=
 =?utf-8?B?anVtcFFjUHlOYmtEZkJYOUxneFBNcHdYeVdXZitGeDU2TjdNdnlSS0VWR3RD?=
 =?utf-8?B?bDg5a0daNzlpQlBIN05aVHVsV3RWZWJNaW9oUVBNVjN4VGlkSmVoWkVaRzV0?=
 =?utf-8?B?U1E1bTNXTW9hMUNad0VURnJkVDNPeEttL3pDalQyQ00rOFRlSlFMOWFRdUVE?=
 =?utf-8?B?VXNJNXQ1OWJyZ05uLy9tcE54TVQ2Tzg3d1orT1BIVW1PUDAxV3hWMTlXbEpZ?=
 =?utf-8?B?MGxaU1FScEpaS0tDUjJnMFNETXlDMUFSVmFJNFVWTWF1T09rWExteXFHWWE3?=
 =?utf-8?B?ZHNubVpiOUJDcGVLYXpKYmpPTCtpNzhpbW1LaHhhZkZIN0g0anRQN3NFaTZj?=
 =?utf-8?B?ck9JYXlkT0lNb01MMjY2K0pETHF5RURtNTVyK1lxc1VDa2ZOd2E1L0JOdS9p?=
 =?utf-8?B?VUhTSmt5NGZTcVdpdE1jRXlGbUFXcGtYTzUrZ3N0eVlHU0ZPTUFIdmV5cHdz?=
 =?utf-8?B?eExiU1d1OUlBT2lXY0JKK2lUVWRjZEhNSmR3UlAwNkhhTFJUOXhseWs3MTdK?=
 =?utf-8?B?TGhjb0lsZ0NwaTR3alJhVEQvMnZzekk0STdRTmVvekhJRHBmWTQwTjNONUxn?=
 =?utf-8?B?UlJOaWVzVUNwUHgweURQemdheWF2SVY3Yll0V0liVEcrbXczVUloeHY4WkZP?=
 =?utf-8?B?SDMxRTVZS1Jacld2ODRlazVML09aLzc2bWFmeHp2NkRnT2QxWm9hUHQxNC9n?=
 =?utf-8?B?cVRTVi9vS205c1piQWhPTlF1WWFiWFdwd0NCYnhraWlZYjBpS2JHNS9sby9K?=
 =?utf-8?B?czg2MUE2d1dOVkpVdXpPcUZRZytXbnJuVEZpMk5uR3laN2JTUFB4cTBQZGpO?=
 =?utf-8?B?N0tWM1A3SW93WG4yNk4xd1o3dDJCMlNPZlpiZnp1NU9xUEo2RWY2KzhuazFl?=
 =?utf-8?B?a0NpbTdMVy9sZUY3WHZQQURZblRhd0FxalF5UjBENFRZWUF1QmFmT3dBZjhQ?=
 =?utf-8?B?OFowRVVxYS96ZWtGZVl5RU1kZXRlbWZxZ0t2ZHRiNVdCUWNrdjVVQXgwOW5O?=
 =?utf-8?B?R1ZzMDk4cnRlTUhLRUpTVzdzdkMyTnJoUWZIUnFQTnhrTHBLQjVIT2ROL2lQ?=
 =?utf-8?B?ZHFnakk0V2x0cFg5UTFKSFVuR1JuQzRzSHh1TlZVc3BnME5BeEh5bjlJTGF2?=
 =?utf-8?B?NTlyK3VJakgwMmEydjBWcGFsd1pUTWFubGluZkttTmJqVGdwcWhQbWZabFdF?=
 =?utf-8?B?Zno1bmIzakZpbXpPaU1FT2Z4YVhPNGdodjVEekRmd2xVOU0xN0tjTlNNb3dM?=
 =?utf-8?B?VHJiUHBXeDRndlU4d3BFRi9OV1IxY21KeGk1blEzR1VXZ2o0aDV3U2VzWHBD?=
 =?utf-8?B?VnJmQjZMTjRDQi9OT1JlMW1LeWZ2ekdKTHBGcklMYjhMSVpOeVNkMjZEazlZ?=
 =?utf-8?B?UEFDaVFXbHY5Y3JIZ2swNW9Ua29LdWMrQ3FvSTlvbmwzOVBiNzJoeGRCVTZE?=
 =?utf-8?B?MUF5OXN5SFZoVXFjUXA0ZnptK1VxMU5XWGUzZFdkTUpENVZVMDkxOXlvVnpi?=
 =?utf-8?B?bXBpLzlmLzVYaVkrQlBJTDVNc0tkQVFrcUo4VHFDRnYvYVVpU3JUS29Rb1Fv?=
 =?utf-8?B?Tm00bjVER1A1eXQvSXNtQWhNeitxbmJwRGVaU2NCZUVVTXVOeUhpZkxITUs2?=
 =?utf-8?B?SE9SWDMrTllvZDk5QjBpOFlXaURESWhkNCthU214WTJJL25mOGRLd0hrc05u?=
 =?utf-8?B?UHc0U0xDWGdRVXAyMnpFRC9rSEhURnNPNDF4OWsvS2Z3UjVMc2srZlpIVE1L?=
 =?utf-8?Q?YdX/MDCmDt7EGozWthS4IL0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TisxazIzVmRBZEpqNWRoS3lkUzk4QXZoWjd3SWJpN0E0RUY1dVFkblB3MGpu?=
 =?utf-8?B?V0VHUFhnaFc4eGFZTTR1aVEvL2VFM3VKU1VwbFdXaDZsQ09ZQlBrQUZmMFdU?=
 =?utf-8?B?Q0hCRml1UWdmVFdBU1dUUEF1ZGNTWW54WFVQWHUzdWVodTFUMmlCY0NwQ1dG?=
 =?utf-8?B?TEVUM0IvS3c2YzVHRUo2eHRVWlRxdkdadXlSZkNDVTJmUzhYUHFPcVR1NEVl?=
 =?utf-8?B?WWJoM1QzVUk0QTBOcUp5OUxOUDRpalMrSUthU2pWdS9iL0FxbmVldXFwZTVN?=
 =?utf-8?B?N0FQNXNCTFI1NHJGWExnWDlXelB6TzZKTWVCTE04ZnBrZi82TWVkclNZYWxh?=
 =?utf-8?B?Tnh0SnZTd1pIZUlkdHZHUEhrZ0l6QVJWWitaYlQvaXNuL01aSjQyQ2JHUmpQ?=
 =?utf-8?B?NW5XZTVYbkhLcndPWHhVeGQ2WFFHWnF2WWtTN01wMXNORnQrMFRjKzhKNnFl?=
 =?utf-8?B?MkE3S3l4MHFGZFFOQWNCd2dOTURIckZxV1lyU2VkZkRqM3Avb09DdXMzcXdI?=
 =?utf-8?B?SmFNeHE0NkNOVngvV3RRMldJbUZVNEdXWWJySWYwSE52TGtMUUl5SmxJUU5B?=
 =?utf-8?B?bjJxYTM3d2pyM3JSV1NmdG1IVHFMZm5uZUVBVlUzS1VjNVVyb212Z2UxNlR1?=
 =?utf-8?B?VCtIWjFuNXloTmVXelJkMVhENk9nZHNOM0FLVE44cml6ZG0yMStSWEZCUkN6?=
 =?utf-8?B?UGZWM3ZiN0s2bnFSS0hpNkhhNDg5VENlalZJbVQzYTljcXl2cmdHT0E4Rk1P?=
 =?utf-8?B?QzlpcWVyTm1jN1Rub2tJYWtmVjdiN0V4SG1lOXUvMTNzNWtQYURvSXJRWWF6?=
 =?utf-8?B?YmxlS25tcHlFeXhJWkIrTEZmUG5CNktYYndjR3NWS2gzSkZUUGhnamd4UmVF?=
 =?utf-8?B?MTNLNEZlT1o0bEZsWkJYb0V6Q0lMN1ptd2RXNzRFT2M0UkhRREV1a2d1VWtM?=
 =?utf-8?B?ZlJhWGNyb2d1UGNpRGJ3Wnd0a0N6TkorU3Z2SGpxV0UraXlsVlgyM3NMZ1cy?=
 =?utf-8?B?VmQ2TXVkRkdZZWxmeFl6SlJXYVFMZGVzYnRyRmxId1hPdlJLYUJGd3JkbGRE?=
 =?utf-8?B?UFB3Mm1tcGdCUkMvdWlWVEdVTXZpTVM5SHBhWGVOUHVPdjJUV0NIbHlvVER0?=
 =?utf-8?B?aGJ0ZnovZ3hrbzRGVDJIYWU0UGVLQzBBcDNJWjlyUW9qclNCcXJuWHJtM25U?=
 =?utf-8?B?MkR5TTlaN3RuNjhsRTVidzVSNi9RT2N4Njl0amZtNlNWeGEzOVVrR0htVnN3?=
 =?utf-8?B?QXFzbEk3R3J2dlRTOVVWMEZKckp1YUpNRitTblNYVjZGZEwrTXJNMlF6WG5X?=
 =?utf-8?B?T09LY2hvUXJITU1hMFo4MEJManN6QXcybXpNckJWV3hTbXpFNkF1aDA2Qy9l?=
 =?utf-8?B?bkJCNDdOQ0NrajZxRU1rVSsxdks4REI5YVNlczFnTElueU96a3RDWVVUYThN?=
 =?utf-8?B?ZTBTb1dmWTJEL2F5QndveUo1dEhMSEwyYmE2QWJPTUIybCtkMDMwL3VGL0RT?=
 =?utf-8?B?bkw0YkFLQ0d3YzJsb01PenhWcE0wb094NU5FdTl1Y0kwUlJKU0hsL0dpeUoy?=
 =?utf-8?B?ZWRVY0RBc3YwRWRDTkxmSFMwV0FXYlZtNmEyUzRYT1BsTUtnZ2YxNFE0aldq?=
 =?utf-8?B?Q3B6cmh1UHhnbE5HQWUxb3Y1RDZ6V0hXZTFGWEM5aGdLZW9ldjRXZUF5T2Vx?=
 =?utf-8?B?TUlERkZ5bFNtVERrVGFUQXcxc0l2T0RKS3BTUlMvNGpLNDQwWGZVRStEZHdP?=
 =?utf-8?B?dUltZS9pNmFkQkVoNDJtMWhZRFlKNTFLQXAxaFVXMmpyNEhjcURtNFVwNWlw?=
 =?utf-8?B?WmtpbUNCL1FKa0hMZVVrbXllYXEwOEZwbW9abnVMZUIzWC9sZXJ5aHgxWkd4?=
 =?utf-8?B?WFdMd0cyM1lKUzlBaHN5WXhkTVhoZXlyd1Zabm1BQTk2cnlGelVUUTRYN2wy?=
 =?utf-8?B?bVdKT01tTE43blMxUVFkK2RteGFzdVZ2ODJQWHBOdlUvYnpEdEZncFZQYzdX?=
 =?utf-8?B?NFV5aWlRN2duaS83c1Qxcm1oeW85T0xBWC9EUDNOcTRhWFJnSldxeXB0NWNY?=
 =?utf-8?B?S1NDQmFTZVZaaW1iM1BOR2tuK2JxQ3dSSTl5QjB1NzlZbGY0V2FvS1FzQ3NW?=
 =?utf-8?B?OGl2S00xVktXbXFaZVBjdlR1Y3puTkNkb0I1am1oaks0OVRQbVdXbjR5NVp4?=
 =?utf-8?B?TGlxRE02TXJsZmtsWmlabU8wZDFxSWJlK3ZDQzI1aGUvdXZiNWl3REhGT3hN?=
 =?utf-8?B?U1luMCtZMnAzT1BydGEvVk1YNi9RaFkrZDRMSkplR2dwS0p4Rm0waW5WV2NX?=
 =?utf-8?B?ZnhBaFRDUExGRnpWV2h0SmxQM3poczZGNDFkUUM5VGpvSVBLVmtZRWxFQTMx?=
 =?utf-8?Q?NeXzApKkoigitiAk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8859824-0ef1-4978-7c08-08de5446baef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 14:59:49.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1Of+9uMJA9d6kjohf2hu82PIFVguJgvWQYJ3E77x4dfuMD+OsQV4o4NyO/o14/LFYyIkbTOuYGpGQ1HV9eDOoZEa9uYz/G4dmYxMNkZhIhGINooiJ8ilqn7N2bsIw7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgdGhlIGZpcm13YXJlIG9mIGNvcmUxMDIgZm9yIGFsbCBvdXIg
c3VwcG9ydGVkIGRldmljZXMNCg0KUGxlYXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUg
YXJlIGFueSBpc3N1ZXMuDQoNClRoYW5rcywNCk1pcmkNCi0tLQ0KDQpUaGUgZm9sbG93aW5nIGNo
YW5nZXMgc2luY2UgY29tbWl0IGU0NzdiZDU5NDJmNDM2MDI5Y2VlMjNhOWM0Y2ZlYzJlYTM2ZTM4
YzA6DQoNCiAgTWVyZ2UgYnJhbmNoICdpbnRlbC9wdGxfZ3NjXzEwNS4wLjIuMTMwMScgaW50byAn
bWFpbicgKDIwMjYtMDEtMTQgMTI6MTE6NDggKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3
LTIwMjYtMDEtMTUNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDlhOTI4NWNlOWI0
NDBjNGQwZDZkOWFlZmYxODE2MTVkODA1MmRmZTc6DQoNCiAgaXdsd2lmaTogYWRkIEJ6L1NjIEZX
IGZvciBjb3JlMTAyLTU2IHJlbGVhc2UgKDIwMjYtMDEtMTUgMTY6NTE6NDIgKzAyMDApDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NClJlbGFzZSBjb3JlIDEwMi01Ng0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNaXJpIEtvcmVuYmxpdCAoMyk6
DQogICAgICBpd2x3aWZpOiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlMTAyLTU2
IHJlbGVhc2UNCiAgICAgIGl3bHdpZmk6IEFkZCBIci9HZiBmaXJtd2FyZSBmb3IgY29yZTEwMi01
NiByZWxlYXNlDQogICAgICBpd2x3aWZpOiBhZGQgQnovU2MgRlcgZm9yIGNvcmUxMDItNTYgcmVs
ZWFzZQ0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MzYgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6
LWIwLWZtLWMwLWMxMDIudWNvZGUgfCBCaW4gMCAtPiAyMjQ0Njg0IGJ5dGVzDQogaW50ZWwvaXds
d2lmaS9pd2x3aWZpLWJ6LWIwLWdmLWEwLTEwMC51Y29kZSAgfCBCaW4gMTgzNjcxMiAtPiAxODM3
MTcyIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLWhyLWIwLTEwMC51Y29kZSAg
fCBCaW4gMTU4NDYyMCAtPiAxNTg0Njg0IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWds
LWMwLWZtLWMwLWMxMDIudWNvZGUgfCBCaW4gMCAtPiAyMjIzMzI4IGJ5dGVzDQogaW50ZWwvaXds
d2lmaS9pd2x3aWZpLW1hLWIwLWdmLWEwLTg5LnVjb2RlICAgfCBCaW4gMTc1MjU4MCAtPiAxNzUy
NjUyIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0gICAgICAg
fCBCaW4gNTUwOTYgLT4gNTUwOTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktbWEtYjAt
Z2Y0LWEwLTg5LnVjb2RlICB8IEJpbiAxNjA0NjIwIC0+IDE2MDQ2OTIgYnl0ZXMNCiBpbnRlbC9p
d2x3aWZpL2l3bHdpZmktbWEtYjAtZ2Y0LWEwLnBudm0gICAgICB8IEJpbiAyNzgyMCAtPiAyNzgy
MCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1tYS1iMC1oci1iMC04OS51Y29kZSAgIHwg
QmluIDE1Mzk3ODggLT4gMTUzOTc4OCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1h
MC1mbS1jMC1jMTAyLnVjb2RlIHwgQmluIDAgLT4gMjMxMTY2MCBieXRlcw0KIGludGVsL2l3bHdp
ZmkvaXdsd2lmaS1zYy1hMC1nZi1hMC0xMDAudWNvZGUgIHwgQmluIDE4MTA1NDggLT4gMTgxMDg0
OCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC13aC1iMC1jMTAyLnVjb2RlIHwg
QmluIDAgLT4gMjIxNDQ2OCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zby1hMC1nZi1h
MC04OS51Y29kZSAgIHwgQmluIDE3MzY2MTYgLT4gMTczNjY4OCBieXRlcw0KIGludGVsL2l3bHdp
ZmkvaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZtICAgICAgIHwgQmluIDU1MTc2IC0+IDU1MTc2IGJ5
dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdmNC1hMC04OS51Y29kZSAgfCBCaW4g
MTU5MTU4OCAtPiAxNTkxNjYwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdm
NC1hMC5wbnZtICAgICAgfCBCaW4gMjc4NjAgLT4gMjc4NjAgYnl0ZXMNCiBpbnRlbC9pd2x3aWZp
L2l3bHdpZmktc28tYTAtaHItYjAtODkudWNvZGUgICB8IEJpbiAxNTI2OTU2IC0+IDE1MjY5NTYg
Ynl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktdHktYTAtZ2YtYTAtODkudWNvZGUgICB8IEJp
biAxNjc4Njg0IC0+IDE2Nzg3NTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktdHktYTAt
Z2YtYTAucG52bSAgICAgICB8IEJpbiA1NTAyMCAtPiA1NTAyMCBieXRlcw0KIDIwIGZpbGVzIGNo
YW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktYnotYjAtZm0tYzAtYzEwMi51Y29kZQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktZ2wtYzAtZm0tYzAtYzEwMi51Y29k
ZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc2MtYTAtZm0tYzAt
YzEwMi51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc2Mt
YTAtd2gtYjAtYzEwMi51Y29kZQ0K

