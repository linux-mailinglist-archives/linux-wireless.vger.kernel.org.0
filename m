Return-Path: <linux-wireless+bounces-26438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A0B2B241
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 22:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B0E164779
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6721171D;
	Mon, 18 Aug 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3DlNcBD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A62397BF
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548352; cv=fail; b=QMrrrdiLUqNTkgIM3n4TVMJuM4vOhT6lBqU0kwOBzK3B/QQluFP0ppzi6Se1Hs5QS747LxiHb/Qn4MIf6FC9QaFDvWAARHTmL57WPYRzXpMtKN9JQjftELpTAvsaribbS068EIRliGFzVm6KyQ2afE0u+PVKbbyQxzT3dmBBIM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548352; c=relaxed/simple;
	bh=dOpnNeEDPEeIpiVyeju8EKN4ziYPi2MtdM/vQFik0Es=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AkFRg5bveZ9J0+jae2Qlf+qhkei1fanmZL9nJb1Tj21bJTMzWugW6O97LeyuUMW5ipo9YE2r7WEehbaLDhyCEawUKL6NNVlNZq0Ht9vr3PpL5G+/Y0jOS0Zeynu4mAdejuvUumJ1h+lZ0JxR4zMmZmhE5UKSPoUQ3PmpHqzNn9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3DlNcBD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755548351; x=1787084351;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dOpnNeEDPEeIpiVyeju8EKN4ziYPi2MtdM/vQFik0Es=;
  b=j3DlNcBDsdPlFnrjn2xaBeu0oPjLff/9Z04JIjc1y9JUivvVrFsU6f/W
   W+mhvYVeD7pZkSClADVTKwMkL+S8zFlSC4FS6RZvU0dLDX9+wjGa38jv8
   MiuZXab9auZIm0n2ddset2Zaz7WhD7uIFNtLy5S+CD4BKNqt8tJgtsPep
   Nk6wd3luGC5dG6x1llh7GuEq+8pMPEC6S2J09TxRkT1Fa8qg7gPAvWvbc
   R3Cf9FkQAnzjac1NIqb/fUYyaZGXRcl5oM8stDXPjy3pUa+v0pzWMhPcP
   U1mzkcetDF6GLH/0QvP1l9qTVtSNIso1IKMITDLW2BB5Pf/z/pljKrvGw
   g==;
X-CSE-ConnectionGUID: XF4NaH8lR+u8ZqiyMyDk9Q==
X-CSE-MsgGUID: uhYNSjhkQjqt+KAASDlRSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57640226"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57640226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 13:19:10 -0700
X-CSE-ConnectionGUID: MZft7XGlQWqDGhshVpoRdw==
X-CSE-MsgGUID: VvD9HewOTTieSsQs3xrpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167618558"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 13:19:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 13:19:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 13:19:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 13:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI27P1C3mJU4VtwkRRCyBwSr4HI2Z6npcQcMtZQxpmutwSkBRlKgoeBYkkRvnSA+KM0bvY+f4K+IBkFOmiz2Ti4s6ddECjoAiOZS+eCu2uwkVZu0BIAaCtAwj9236R+f8VvHWcHs720mDwpMksJyoVkdOHOqRVSYfaId8QWPtSvn/h65d7QlxmBnFfE8xW7E+JMbdF9xJxwFWzARjmKPIkZwlQEEIm/1RgH+qxeY5iTfAhXoqjoTB2rIj7l4iZC6ZKfcd3Af+CB+vzPxEd2T2a9F3xBJ2bv+e2mWyPqSxWIYz21znSg4cWjq1vyyViAly9VXbU3yupjqZ8Mgj75PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOpnNeEDPEeIpiVyeju8EKN4ziYPi2MtdM/vQFik0Es=;
 b=SeQqcWraqOAOhQmFZlTqcRJZtb3QXwH85HjpwY+VbL/SFGunKF3ZbUeOEqVs9svrdfRqZiM6lIAfX9ujYW0Mzvyxv2R6uO9Zs1toDLAoaOy3HvlepBp1A3KBFZ/tnp3RQnqFV/BbCXID7G9VbcEwHYivYeNVm5DG8pU3zAMhlx6qcqjVyhkyA8hzd47ADpWK9/R/hCHLBMLPR5tlJaOZ8/GSOtKyzzyQ9NI7NH7owV85xTYJ22X87psd3YHugBgSHVlNbVhk6SC48hHoIIr+gdHf2MV/TJrOFsNctrxeqWLvQTpk+oesr18Upzd7FkD3GEKkkTUZTHXiio2d3OPRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by BN9PR11MB5243.namprd11.prod.outlook.com
 (2603:10b6:408:134::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:19:06 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 20:19:06 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: Josh Boyer <jwboyer@kernel.org>, Linux Wireless
	<linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben"
	<ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2025-08-18
Thread-Topic: pull request: iwlwifi firmware updates 2025-08-18
Thread-Index: AdwQfRuSbOkGqQTnSF6EOYspWWuMPg==
Date: Mon, 18 Aug 2025 20:19:06 +0000
Message-ID: <DM3PPF63A6024A98DDD1D55C6EECDDE41B2A331A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: 2bf61e71-a64f-4680-6293-08ddde947b8e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TWgwNmdkSk4wUlVpL2R3eForTUhQZUoweHhjOVJ0cDZ0S1FFdXVRVXJvdEhi?=
 =?utf-8?B?c0FHU2JGcG1HQ2lPb0RMKzV6elJUcGlteHRuMWg0dXRXWGJlREV0eXdST29w?=
 =?utf-8?B?Z0t0MXBzNEZHenZYRHRrVi9RUnlkZndUb1N5Y2RpYWlkaHNueWRjQVlGMFlP?=
 =?utf-8?B?b2pzYS9FK2FoRmkwM1FOYnBHYTBGa1RYeDl1eUovRG1aRHd1ZjNUQ2NjRS9S?=
 =?utf-8?B?Y1I3QWY5QVdBTlpwS1h0VjVTdWRIaXgzUUJLMnhtN1dPbUJZN2FDUllJakZO?=
 =?utf-8?B?bWZhL08yRjE2b0d4UnRHNXpTUlhnK25URnhRTU9TK1IyV2V1WklJVXlodmwx?=
 =?utf-8?B?WC81N1d0LzYxNnBsZVk2bG1oaXZVRnBGVEhHY3lZU1c5d1VYbEI5QVl1bHdO?=
 =?utf-8?B?Q2haSWdHdXJvZlZzRUFJVG80ZWNkRTdaTnhDdFdGdGhCMHE5bGd3bUlQd0JL?=
 =?utf-8?B?cmFyVUN4aHFwSE9EVnBoUEp0RUNLZTRJOTdEOUVaR2V0MnVmYmxvZEdtekpD?=
 =?utf-8?B?VWp1aDMxMWpJWkcvekpoazU1V01hMDI5YnpCNHZyNFNvV0t3WjVvWWxjYW1J?=
 =?utf-8?B?SzQyQWQ0dUFBZTdKMWt6MEs4L3dZWURRMmNUQzNvd0J5ZWF3eHhnNWhtMHJ0?=
 =?utf-8?B?YlBKYzdpQms2VGp4WVBjSWRRa3E2b2RjT0thb1d5RnFrREp5VXU3Rk1vMS83?=
 =?utf-8?B?UU1JZ0xIa2JOWGpQU0VJQVdqZUdEWmROR05lUk15cDUzWEdxNUh5VmNZNk5T?=
 =?utf-8?B?andvbmhIbWFhOUY1TGZiNGQ2ZUhtYVZXbkhvWXQ5MHExS05tNm1XMFQ5Umxw?=
 =?utf-8?B?VC9GVGFyV3VZcmJXSVEvVHJpczgycFg0OVNkY0dBVStRQWVsMWtiYWR1NjVT?=
 =?utf-8?B?MlQ0QjZEZDBUTlNnT1RLVWxKZ1Y1anVaWTZaT00zWkk1d0R4djlya3RpSEgv?=
 =?utf-8?B?RDYzVjVwVFhITDZCN3Q4UHVrMjlGYmdIYlVudEtLQlcyYkJTMFNNQVh1Z1By?=
 =?utf-8?B?Z09uTjhHYnlKUGt3dVduV0JCeVo3K0kzYVU2bW5DbEVsNmRYY2VVOWdsNGd6?=
 =?utf-8?B?dVN3dlYzeFBOMk9mdThmdlozOWloYXpGUkxwTHJMME9UcHlVSThhY1hHSjJy?=
 =?utf-8?B?eVo5a1EzSkpGLzZIS0NkaHNsbm05SjJTNjdtV011WmtKTDVqYm9GSFVjYnBQ?=
 =?utf-8?B?V1RzYVpWaVRCUFMyL1krS3ZVTVF0NEdJcis0V2dldE9LZmR6OEs5SkZCSzdp?=
 =?utf-8?B?YmFJT2FicHRtQ3JvWGdpMElHMk9uSlIxOVcyUUFHM2M4TVpzZVlYSTVVUlpn?=
 =?utf-8?B?RjA3QzU1dStYZTRGQWJQeVo0aWtqeTc0K29zV0ZCWHRUSnZxdmU3WE8zNnV6?=
 =?utf-8?B?bUJtR1RNNjdmMit4QUFObGhPVWdja2dyZXNIaVZaRmw5R3d4RmFTV3lBRGp1?=
 =?utf-8?B?TEk3aFk2VmRIVFVJMjFKU0lrRFp0cUR0QVV2VGVOTFBhUTQ1YlJMZWxmaUxs?=
 =?utf-8?B?all1ajRvakRSMVliamFqbmJwNVEvbWlDY1Jndlgxb0xVODB1cmg3UHV2L0pv?=
 =?utf-8?B?bHhKcmluVVVTQ2Q4U0VQSk9OQktCTmd6TWZNKzFNUHF2SUk1VHVTUEEyUUQw?=
 =?utf-8?B?aUNZbTNoYmRFRkVxSkJGZGttb0UwUUtyeTl5a2xGVEZFZERXUjRLQVhuek5N?=
 =?utf-8?B?MkZuQXZiaEZMd0tIc1ZQQ1haTVZpa2xzZ0c0RnUwSE53WU1uNmdMd2lOSzk1?=
 =?utf-8?B?RzM3aVRlaFUrVWNUcHVsR0hxUSs5ckVpS2VjMHJsOXl0QzVWd1FwdDYzUW52?=
 =?utf-8?B?YkM3NDRjK3JZdVlLVEE4WGlhM3BISXo0aTlPWisvTWxKY1NmY2tEdGMxcDZW?=
 =?utf-8?B?YmlNQVdNR0w4TG9ubThxRm5PS05RbU9aQnNsQldnQ1c4RWZpd3VYdzVlQlJM?=
 =?utf-8?B?MmxzSi9SYnNBUWVqcS8wZkI4Vm5yQ25ZZ2c2bE90bndTL2dGV3RkelJvck5z?=
 =?utf-8?Q?kxhT7VWnSMZnCo8rJ/P9jMiITVeynE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VElMVVRrUGJObDJlM29CVm9URmd6RjR1SmRWWWt1dlVqSG8zQUFkcmlxMy95?=
 =?utf-8?B?VlhGbzhtR3B3RWcxL3lpdy9ORlIyVzhJWXE2OWNLZVdvQzJiUDlocFBpVEMy?=
 =?utf-8?B?cmM3bDdTaXc5NE5jMHVxVEFDeUpYeDFLTGgxdjBxK0FIbG1OcnhiY0hFbzls?=
 =?utf-8?B?eksvV3pXRlR0QlFGNkMrdVVOM0pUbG9Vc2tRNnRDVU1CY1YyU0xzRVJFelFp?=
 =?utf-8?B?QTVGT1hJNXBTZG01b1p5WnJranJ0aC8zYU9acmgyRUFMQkR3cG1Bcno5bVJF?=
 =?utf-8?B?M2o0eTV3ZlpkK1JxY2F6eUYzakcxeHEzOEZ3M291WGdtcTFDWHJ6SG1CVTJr?=
 =?utf-8?B?Um9UT2oxeW9EVDZSWS84MnN3bnpnL2tieG5vM2srdjZjSmtHcTljei9HQmdF?=
 =?utf-8?B?ZUlvcFBoYUhRU3VQTE9iVHVHUFpSRWlZeHYwUHpob1dFUHAraG5RZ3RzUU5p?=
 =?utf-8?B?NUQwYXIwYmVWRTd4bkc0N0wvcnphMTZyOXlWRDRRQ1plRERCQkIzNjJjWnZW?=
 =?utf-8?B?dDUrQmxyYkl1bHpVS0lKTm80dS9qL2g2UThsQVluYlN5b2hkYlh3d0Jxa2lh?=
 =?utf-8?B?SGdnUHdhZ2NHKzFSTGlyRVBtVXkrQ25Wc0xwNktDMlBqZVc2alNGV0x5TW1Y?=
 =?utf-8?B?ZWVtZHlsWmJSU3oxYk9xYVo3alBMcEFhc0UzYTV6MUVYRGJxTmZ5R2ZnSEhz?=
 =?utf-8?B?VGU3ZFRjYjF5U0xLa3BEOHd3MDlKVFNkWmxILzhUNnZtLzdHbEhPaFJMWHRJ?=
 =?utf-8?B?NVN1NGg2L2ZpVElPdWdzYllFdjRIUXBicm81M2RVZVdTcVp0MUdpaDFIYkkx?=
 =?utf-8?B?aHRHdi83eW1nRVYweXJTVXExUkJqc2M0YlMrSzhTa2xXbHk0V3grVkdRRVpX?=
 =?utf-8?B?blVsY3lXV2FyQzkxSEJ3dW5pTFNNVHpiZ3F5d3d4Y0NZb3cyUzg3OWNyVUY5?=
 =?utf-8?B?dXY5Q1NzM2xFVHhuZlR2TlBOY0FGL1ZhSU1uaTBkVTdTeWNFa2hBTlBQZjFo?=
 =?utf-8?B?ekVMVHFFSG44SXVMWHlMRy9tdHppVlJsYmRWWkpScHVha3pFM3R0d04zUFYv?=
 =?utf-8?B?VWtneTIrQkp5dFNDY3J1NE5xaGhWcGR6MU9OQUNTUUxCb0hVQ3BFM1FabnFn?=
 =?utf-8?B?NGg3TDVWTlhmTTF3K2ZqdnBHMThVOElaR1NIcXpiOE11T0l6RVdDY2k3aUFz?=
 =?utf-8?B?ck52YjVmNEhnbm02S2hCclYzbXpnQmNjbFEvRUV0TmRGcklRS0tOdmZjRmpo?=
 =?utf-8?B?Mk0zdzY3UnFOZHYwSytmTzNrUktUY2FYK0g2YU8zcHJ6V3hEQTNWbFRKU0ND?=
 =?utf-8?B?NmMyZ2g2cE8zVE1CTWczYjh4RFpoeU1TakRkUjAraE1hdytZMy83SzBJSC9r?=
 =?utf-8?B?eFNZVjdaU0U1cVloLzRIV3g5UUp6dlBvZ21tVEhnT290R3ptRHk1dG1MRG82?=
 =?utf-8?B?SXRUS1RBenBCdUpwZmY1MGJGaXBoWk5JaDZPMmxqVEhzUExrMGtCN00xeTBJ?=
 =?utf-8?B?dHZVWjc4aWpXZXpKZ3diQmdtVUdROGo5M1hraGlwMGQ2bTJEamhGcjFXRE1s?=
 =?utf-8?B?bDJqdEQvQXlPY1ZPbWV3ZDJPOGJCMlRwUDFtRXNsVXVPUk55K1c1aFlFT2Fw?=
 =?utf-8?B?M0k3elhEcXVTb29CbWxRNUJ3SWRFbzEwZUVmaUFIT0ROUTF3aWhFeEJKSHl2?=
 =?utf-8?B?bDEvQllrK25pTGZKZTZGaTVJbjlmeXlYUUt0VTV2aGdvaGNncGVOdmdnUzVu?=
 =?utf-8?B?Wi83YTZvdXhPWlU4RFdRYjVGdHdIVkpLZDNVRGg3WlZid1BmdmV6Yit6eFhG?=
 =?utf-8?B?a0hzRnlaQ1BHZlRYVkw0L2daMGNTRUFucnQyNktWcEVid1dDM3NieVVURjBF?=
 =?utf-8?B?aURUMXQvbTI3UjJmL3F6citBdXkwRHIyTDFKNXFIVGJXaFk5dGN4U3dEVFpu?=
 =?utf-8?B?TVQwSHRlMTd5b3c5N2tBU1N3a0lBbTFQcEE2MW9oakNtVlBZVDZra0hvSFAz?=
 =?utf-8?B?UVRndGNsVWcxdUtUOFUyVVpHRytBZXpaVWxvd2tJTE9ubzBCUC9XWldVLzdp?=
 =?utf-8?B?SWE1d0Q0R3M1TUNiMUUvSEdsYUNaaG9OZ2JCcmw0WEJKMkNoSWRqeXFSN1Ix?=
 =?utf-8?B?Y0swdmIvU3hDWVU4SEUwRE5lQlE0MDFBcVREOHpZWkRLeHNYRmJTUXZuMUVG?=
 =?utf-8?B?N0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf61e71-a64f-4680-6293-08ddde947b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 20:19:06.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYAmYseNC029EKBkXBSgPxijndBnpqhGcYiiT3QkWbERVA94HHGrr1Wun497rJ2rFEinZufHG8gE0jjVPMmAGy9YdVE7ILYtL3Is6VVZ9KOnawWem0Gsw3BkAkIeU1C/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBv
ciBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KTWlyaQ0K
LS0tDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMDdlZDg5M2RmNTdjOGIx
ZmIzMGU0OTdkNjE3NTQ4MjU0YmJmMTEyMzoNCg0KICBNZXJnZSBicmFuY2ggJ2FtZC1zdGFnaW5n
JyBpbnRvICdtYWluJyAoMjAyNS0wOC0xNSAyMDo1OToxMSArMDAwMCkNCg0KYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3
bHdpZmktZnctMjAyNS0wOC0xOA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYjVi
NzhkZGEwNmY5YTYyOTU1YWJmYWFjNTQ1MTViNjAzOWE2ODFkMzoNCg0KICBpd2x3aWZpOiBhZGQg
QnovZ2wgRlcgZm9yIGNvcmU5Ny04NCByZWxlYXNlICgyMDI1LTA4LTE4IDIzOjExOjE0ICswMzAw
KQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpjb3JlOTcNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTWlyaSBLb3JlbmJsaXQgKDMpOg0KICAg
ICAgaXdsd2lmaTogdXBkYXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmU5Ny04NCByZWxl
YXNlDQogICAgICBpd2x3aWZpOiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlOTct
ODQgcmVsZWFzZQ0KICAgICAgaXdsd2lmaTogYWRkIEJ6L2dsIEZXIGZvciBjb3JlOTctODQgcmVs
ZWFzZQ0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDAgKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGl3bHdpZmktUXUtYjAtaHItYjAtNzcudWNv
ZGUgIHwgQmluIDE0MDYxODQgLT4gMTQwNjU3MiBieXRlcw0KIGl3bHdpZmktUXUtYjAtamYtYjAt
NzcudWNvZGUgIHwgQmluIDEzMjI4OTYgLT4gMTMyMzI5MiBieXRlcw0KIGl3bHdpZmktUXUtYzAt
aHItYjAtNzcudWNvZGUgIHwgQmluIDE0MDYyMDAgLT4gMTQwNjU4OCBieXRlcw0KIGl3bHdpZmkt
UXUtYzAtamYtYjAtNzcudWNvZGUgIHwgQmluIDEzMjI5MTIgLT4gMTMyMzMwOCBieXRlcw0KIGl3
bHdpZmktUXVaLWEwLWhyLWIwLTc3LnVjb2RlIHwgQmluIDE0MDYzMjAgLT4gMTQwNjcxNiBieXRl
cw0KIGl3bHdpZmktUXVaLWEwLWpmLWIwLTc3LnVjb2RlIHwgQmluIDEzMjI5ODggLT4gMTMyMzM3
NiBieXRlcw0KIGl3bHdpZmktYnotYjAtZm0tYzAtMTAwLnVjb2RlIHwgQmluIDAgLT4gMjIyNTk0
OCBieXRlcw0KIGl3bHdpZmktYnotYjAtZ2YtYTAtMTAwLnVjb2RlIHwgQmluIDAgLT4gMTgzNzAy
NCBieXRlcw0KIGl3bHdpZmktYnotYjAtaHItYjAtMTAwLnVjb2RlIHwgQmluIDAgLT4gMTU4NDY4
NCBieXRlcw0KIGl3bHdpZmktY2MtYTAtNzcudWNvZGUgICAgICAgIHwgQmluIDEzNjc3MDAgLT4g
MTM2ODA5NiBieXRlcw0KIGl3bHdpZmktZ2wtYzAtZm0tYzAtMTAwLnVjb2RlIHwgQmluIDAgLT4g
MjIxMDc0OCBieXRlcw0KIGl3bHdpZmktbWEtYjAtZ2YtYTAtODkudWNvZGUgIHwgQmluIDE3NTE3
MDAgLT4gMTc1MjA3MiBieXRlcw0KIGl3bHdpZmktbWEtYjAtZ2YtYTAucG52bSAgICAgIHwgQmlu
IDU1MTI4IC0+IDU1MTI4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAtODkudWNvZGUgfCBC
aW4gMTU5OTk0OCAtPiAxNjAwMDI0IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAucG52bSAg
ICAgfCBCaW4gMjc4MzYgLT4gMjc4MzYgYnl0ZXMNCiBpd2x3aWZpLW1hLWIwLWhyLWIwLTg5LnVj
b2RlICB8IEJpbiAxNTM5NjU2IC0+IDE1Mzk3ODggYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEw
LTg5LnVjb2RlICB8IEJpbiAxNzM2MDI4IC0+IDE3MzYxMDggYnl0ZXMNCiBpd2x3aWZpLXNvLWEw
LWdmLWEwLnBudm0gICAgICB8IEJpbiA1NTIwOCAtPiA1NTIwOCBieXRlcw0KIGl3bHdpZmktc28t
YTAtZ2Y0LWEwLTg5LnVjb2RlIHwgQmluIDE1OTA1NDAgLT4gMTU5MDY4OCBieXRlcw0KIGl3bHdp
Zmktc28tYTAtZ2Y0LWEwLnBudm0gICAgIHwgQmluIDI3ODc2IC0+IDI3ODc2IGJ5dGVzDQogaXds
d2lmaS1zby1hMC1oci1iMC04OS51Y29kZSAgfCBCaW4gMTUyNjgyNCAtPiAxNTIyODYwIGJ5dGVz
DQogaXdsd2lmaS10eS1hMC1nZi1hMC04OS51Y29kZSAgfCBCaW4gMTY3Nzg5NiAtPiAxNjc3OTc2
IGJ5dGVzDQogaXdsd2lmaS10eS1hMC1nZi1hMC5wbnZtICAgICAgfCBCaW4gNTUwNTIgLT4gNTUw
NTIgYnl0ZXMNCiAyNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1iei1iMC1mbS1jMC0xMDAudWNvZGUN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1iei1iMC1nZi1hMC0xMDAudWNvZGUNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1iei1iMC1oci1iMC0xMDAudWNvZGUNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaXdsd2lmaS1nbC1jMC1mbS1jMC0xMDAudWNvZGUNCg==

