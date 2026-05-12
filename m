Return-Path: <linux-wireless+bounces-36320-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjTHeL8AmpOzQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36320-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:11:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1451E4FD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21B67308EE16
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112984BCAC3;
	Tue, 12 May 2026 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iR16MUsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717524C6F02;
	Tue, 12 May 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580483; cv=fail; b=R1nehqhbMVn6VnBMSTpjXv/Tovdr5/8UUPGu1u7IN2+la5bB6MKqKL+i3/ablajNilRWVhEd0FvDRPGZDCWM84xkrQyx3fBrgMTo2EzaMRuRStO9e+fxOGArl8bL6IHh2c6sq2pO1Jh5pqE+XQlqdJsFfExtEqEv1p+86uizsUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580483; c=relaxed/simple;
	bh=256yhfRkuhmEXADBVK3uveOOHqwHrPWG1THuA3qvXoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msnW5JTAgEXOHqAjz1UuDsU1WOgLut55rB+cROxjsNpgKAEF+EZTmGxGXGb/FG6wmnYmRGONZNbZPGjT7QkaatOhVWMxwL79zM5WdboTduSgt7qBRNevLgRFfsGzKL0lme8CBXQLh/VEt23UNsbXVz96FcevSomdzmBoBmzg68E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iR16MUsl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778580482; x=1810116482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=256yhfRkuhmEXADBVK3uveOOHqwHrPWG1THuA3qvXoM=;
  b=iR16MUslVLz9pzmum6CKMHrfuFj4Uhlu1/ITJWZUb8QDuoJL+TewNM2f
   oBR+iu6qeLGU9W0LjPKZ/OK9wgCqCEj8/FmUK6ingapeSX3DiB5ja1d+3
   KusycoaygqY8DDn0ZhtVLEvyy0DmVsiOW7FMUpVgwlC5r2K7Pzo2DMG+r
   UwREg/DdQztudjXkNeRG8SP9rCICkCRN1bZCuIlB6IbbMbi4BzQiz5vhe
   cgsUB91Sw2K+A0FCXAm8/UeiBTU9mbkBAnVXrP6gcFN3Oq+u+z4ev4sQC
   SpBkDxZLhUIszCb1rtcyhFAFQghOIM6Yh4aS3SPcZLYrVcSU8CkKqmJTe
   A==;
X-CSE-ConnectionGUID: dDy9hnTxQDSAm3wZke68Fw==
X-CSE-MsgGUID: CVolcWnOTJS8ZipW6J0JGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79595884"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79595884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:08:01 -0700
X-CSE-ConnectionGUID: cO0z4LwtS0+Qx8tg370mLQ==
X-CSE-MsgGUID: JyP8Uus/RXK2s2UBxVnmYw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:08:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 03:08:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 03:08:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 03:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTuMPvGOf+A1Cl0zkPG+9n5iViuQ0hcyXeOhD53L7zkjaHIx7cqqLdcSJDdoYyc9O16aYtqc/5XrD9G9onmMYjKJWL7LmqEeIW2Lul7xisBlc7g6Ecf2Fq9HuQetsoAgZNjeFBFU4Ag94j02yjLFg95u1tnLSmZarsZZj37kuviJp1rD6+gF08IogDi7oIZBdoZ3L6YPmdovkgshm70xtEAz194HaKcJ4kBs/z3UIDMgxjf23fWWrLeffrk1Unz4ZwOX6roaaYcY7VJHY1iHSRQak92UxeqIPtOdYJwuKUMw039iyIujtti3Jr2JZ3uID0QWYXw3yvCguZAAma+n8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=256yhfRkuhmEXADBVK3uveOOHqwHrPWG1THuA3qvXoM=;
 b=n67N+HY5ql8Cx5xvGTBJo6ujoyUqlZnDNSTaHoa1mcQ/V9O27GYI+nWp4ld71RAUqBMvlYzJA6LEIBxVxRzLhq4uC69x8fQr3k2ZdxrgifOxuyMDsjHFr6tZRvllPdAlhyaekqlSAonqURNfrmMoYbbX1L0YFtL4IIjb/oR+/qJf56aO5QJCrzL6uGMYPf4vbWBrXPToM3Jz4JhSxno8eRpJgUUGkltfltZavpgfvcCxT/ZqkeGZAAG9zBX5ZapmLGDrkci+kueUIpmg+Z22ToHBiMNrR6sm+SD49t+qXQItZY48nyiPTgoBRZyhESJyGWVOeB9roxfjmn0v1WZU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:07:55 +0000
Received: from BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12]) by BL1PR11MB5954.namprd11.prod.outlook.com
 ([fe80::656b:8dc4:72b5:7e12%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:07:55 +0000
From: "Bhatt, Avinash" <avinash.bhatt@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Guetta, Kobi" <kobi.guetta@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
Thread-Topic: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
Thread-Index: AQHc26vi/B+Vuw6kLESUO2/QFJubJrX/KUIAgAsNsJA=
Date: Tue, 12 May 2026 10:07:55 +0000
Message-ID: <BL1PR11MB5954BCE96853D1F299E4DEACE0392@BL1PR11MB5954.namprd11.prod.outlook.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260505-crouching-albatross-of-beauty-a5ac6b@quoll>
In-Reply-To: <20260505-crouching-albatross-of-beauty-a5ac6b@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5954:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: 9071a98c-493d-4dd2-4c7e-08deb00e5636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|11063799003|3023799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 6fxBlACWja9aNdinWTJbI2qVwKJDxA16b0GjqkLqrfw831LF3lwGzXnxm8I0dDq1v5kzmwlr/GUdBWgL4Om0b3BYJNsXcqVOA9SYkV6P4aj8dntzOtYL0nAUcDQksxoBKEylFGIjkbBaOfHbfg/KRejHF4++rBaHpTLaOeiRXgA7fMhX8Vd+4d+W3/yUwb5vQ2IpGErpv/4oZAi6UUushsddYlOmt8urBDmtKzhAb01tivCZqTHJaacyOXpovEfV9esDkOSXpmbmKT7jnoAxi0aAw89VZ6fDFirHsdYKzELSYqDRMKnQPZgd7I3SeYBTtXd8wyfEpVasGi6cFfXcealaorQK9KhwvKSVflOQWrAXyG2itsX5/ys1PRPkT0KO2fUWJoJTJsD8HYPr6HT89T2O3qN9B1aV96AQOVvKRZDIzhz/AYGE2Icd5Rnb56UtbzB8hFKM2aptclC4gv70rzsANXz0Zd+N/3S/GjubnqImbMnw2UKD0Pt6WiM0rgLLEFLtupvy9wDLBZkba2EJTm/qKgUMUXQ7Y6Jtx1mFR3uyoMVJmyBYpVHa/56qMldVb5uJgSBbfrj9/v2akHZi7Q/651QPcyLEF12+tVKJtalPHvknQnX0wSuAAP/pzYrNFb69VNkUbZqoGzG0QYrsZgVNBU16FoX0KkE5Mkp60m8CoyGY3JrlZqwVcNJV9lNj8xl2q7ePGmvwWmIsuo6BazJJYT0VUqhJ/pOYp9g0jo/5/hxNPAQtqFdf/4FW0klk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799003)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWw5bktHdkFKcWcvU1lrS0ZMMXp6dFdZTjVyZmN2YzNldEQ4NHNIWXY2Qm4x?=
 =?utf-8?B?VE5PSW9XU01kM2Rlc1VOTWRuQmlRMDQzQ3dYdE5XNkptKzhBOVJDSjhhV2NC?=
 =?utf-8?B?SDA3QVdaKzY5cGFOWDNlN0FraUp1RUtUamV1RzVTc0FnMGVJVjI2R3JSdTk2?=
 =?utf-8?B?dUFOMGNpaGg3OTBzNXhvaHRkUHhsWSs4UW5Uc1JyenlsS09NUjN6RHU3a1Va?=
 =?utf-8?B?ZGtBTVIyUWg4N3dLV3dIb2NVRXdaZlhqTUxzT2paSjFsRC9tV1VxellXbDJa?=
 =?utf-8?B?K1NVSXk3V1BFdWFOTTVFbWtpYVREdXlXN1AzOUQzKzU1UmhVZjJySG9nT3BP?=
 =?utf-8?B?Vkc1K0RBUEpON0tNN1cyS1BFTGJha21Pb0xxNTI2SkVUR1ZXSWxGcFVLZlVB?=
 =?utf-8?B?Vm53TEpDTWg5YldPRFhDeVpuaENnbTBvYzcxSjd4OG5rQjBCaDBna1IyZHc1?=
 =?utf-8?B?dVg1QUxIRVgxb0g4dHBMS3dVeWkxanN6OWwwdVl3Y3hPdTVhdVZjaVB3SW9y?=
 =?utf-8?B?S1dFdy9uZ2tJb2NmR0FtZ1lUSHVnN3hJTEh1U0pNYWNiV05wV3NlTlIvRVVq?=
 =?utf-8?B?dGFUZi9xY0puUTJac2tYeEhqTjV6aEs5RDdlU1I3czBNdHMrT1JuT1IvTGZm?=
 =?utf-8?B?Z3N4ZHhLSTNyUzZxa2ZjcmxLSzMvbGlRY2kxaUkwcU4xNDJUenhQYkRuTCtW?=
 =?utf-8?B?b2tPeWpDZ2xIa3FGN1QrOHlUeFU3RUdxQmlubVhBYUJuRk8rQ0RPUGxMVGNt?=
 =?utf-8?B?UE9IclE1WTc0SUtWaEMrMjZZTEt3czhDMlZ4bDVndkRkdVBSREQyYzZHMWxk?=
 =?utf-8?B?UTNKWks1aTBqZzR6eGRtWWhOWVNDdGt1SnpzNWpucWIzZ09ienFMUkR0YXRG?=
 =?utf-8?B?Y3ZnT0ZaT3pCemd6RDFJWVZ1TmJkQWdQQkswZDYwbGJvOWdmK2l0NU1oaFk1?=
 =?utf-8?B?QzE2MWVBWC93SGNtZlMrT3M2QXU5NUxkL1hGMW9FSWR2SWdhc1U3UllrK0ky?=
 =?utf-8?B?VWQrc1hVaktYQmx1bXJPT3ZwblNtL3c4Qlp5U3RmeFJOcWxIeVhURXhScmxh?=
 =?utf-8?B?S0dlbDB6V0VZemhKY2RpWUFDR2o3MXZ0YTdEZFdDcVRJUGtIaU9nazBXUXg3?=
 =?utf-8?B?SXZyU1R0U1lwKytROWFGSGF2ZVFFczMwV0d6NVQzc0lnUTZFYTNOZFdmbUs3?=
 =?utf-8?B?Wk5JNm12dENsMGhLVzdSendtQXBzU0l1ekt6MnRKNWNSQ2tDamdwNG1lcW9D?=
 =?utf-8?B?cjY3c2pxQ2lVdnd2S29ONXZHTVl4L0FqN1NGQ2Q1QXo2M2FSeDhHdDlqRCs4?=
 =?utf-8?B?Y3VFOXROL3RQT2tFeXpQWk5lTE1BNk5MeFZpdjQwKzZ3NWNpdE93VFI1b0dI?=
 =?utf-8?B?SmZhTk1FL0RwalBTQk13MzNDZVhyY2dQRmd5dFhiL2paVE1VTWJjMGEzakNS?=
 =?utf-8?B?aGR3UEV5bUFPazNpT3JEREU5UytPRm91cGxpQ2RTaHM1d1RXK1dvT3R5aUtU?=
 =?utf-8?B?bjgyVXRTck00MlBIL0dVRVNmdi9Yb1RPbEEwTUY3UytOQy9QZzdIeHQxSFMy?=
 =?utf-8?B?cTA0N0xTUFlPNGpjWm9xV0c1dDJIU1c5cjNDSjJ3T24xOVZxYklpL1I0U2JL?=
 =?utf-8?B?NnVZdnFKdjdGdEVxSFZEekV5cjBYVEg0dXFmdHE0K2YwdDlkVmtIczN4NHFP?=
 =?utf-8?B?dnVET0RYVXNZT2ltMXR3QnVDRk90M0htaFBid25uRXpCTFNuOWhscUxGZUNk?=
 =?utf-8?B?T2d2VXRMbHNEU1UyT0gwbDk1UzROV0N6Vy9DaVdEWXYzYjFYajhybm9ZTmoz?=
 =?utf-8?B?VHAxWUNVN2xja1NpNEdsOE52YUpXVGU0QStyNjlTWkkxeDJjSjNpeThPVGlt?=
 =?utf-8?B?ZTE4Nlc0TnFNSGs2M01RamhDR2c2KzFKRmZpanBrNzBWMHRYZ1p2SU5ZNXN6?=
 =?utf-8?B?a0NHdWFHUGZxamJ1amVqbCtpTTFpL3JwcktlaWFEUmRmRTBMck1rQmFrR284?=
 =?utf-8?B?aTY1NTBGQjM3KzlqMGRRUjBWWktwNmtndUpqR1cyL1VVamdaWm1kd2Q4amd6?=
 =?utf-8?B?WXIvZUNzdVJDbEdDNy9WQ0FrQ0twUlBTNlcwTFloZmQxK2tVL0R5ZEplTmNQ?=
 =?utf-8?B?bXlSZkk4UDdFY0tyd3lrVTJwc0VKNFQySWswK09BNUlTbkFNSGhZN1NVeUxz?=
 =?utf-8?B?aGRiREYzSHhxUEtoT2hYbTFxQW1hVGJ3L05EWENRNldsaFR6VWN5UTdrcTBk?=
 =?utf-8?B?SWxoV29LQTNvY3NFR0pMYmo0cm9FRXRNYWRKSXlxM2dRcU42U29MclhYR3ph?=
 =?utf-8?B?OTNsbTRUbFM1NGVXTW02MERReGZGR1BRcUV4MHlOcmRQTU9ZYjZhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jwxkqdOd6lekaE60NIks/l8CiVUBB87jctryaGrL6rNDjbg4gVTPI+KNK259hZIdmUehpglshxAi8Orm6B3k//P9eROahAPNsmLt1Iz477YzZ2lXdACRuTjiGA2nSe+ZO/P7Xh5GYUBy7/x+4HdZ9b3IG9Vx6LGIMivM7ZeU/zg35NtxBj6dcdTICcCAkJOR8soHsa0sBI4MNThHFtAinCqMhn6Okz+huEWtGDfH4hYRy8ipiW1wffbjro7rBkfAaUU1yGt5U8XMZhy6mbGbb9va3KW1wcCA1R+R50AcgR4xmdPwPOv8pZRI3edK9ZQ4lZiqbCWTI2h8TsBDjtTI8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5954.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9071a98c-493d-4dd2-4c7e-08deb00e5636
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 10:07:55.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bExmpkEODhjqoS/rzhk714/tPE2SyCFKE72zB4n3GJzXJhFLIE+8kSIRAS893i6ybyRBWy4I1ZCezjW+zbubDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CBB1451E4FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36320-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BL1PR11MB5954.namprd11.prod.outlook.com:mid,sipsolutions.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIFBsZWFzZSBmaW5kIG91
ciByZXNwb25zZSBpbmxpbmUgYmVsb3cuDQoNCk9uIE1vbiwgTWF5IDA0LCAyMDI2IGF0IDEyOjUz
OjI0UE0gKzAzMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFBsZWFzZSBwcm92aWRl
IGxpbmsgdG8gYW55IHVwc3RyZWFtIERUUyB1c2VyIG9mIHRoaXMgYmluZGluZywgZWl0aGVyDQo+
IGNvbXBsZXRlIG9yIHdvcmsgaW4gcHJvZ3Jlc3MuDQoNCldlIGhhdmUgT0VNIHBhcnRuZXJzIHdh
aXRpbmcgZm9yIHRoaXMgYmluZGluZyBsYXlvdXQgdG8gYmUgZmluYWxpemVkDQpiZWZvcmUgdGhl
eSBwcm9jZWVkIHdpdGggdGhlaXIgRFRTIHdvcmsuIE91ciBpbnRlbnQgaXMgdG8gaGF2ZSB0aGUN
CnNjaGVtYSByZXZpZXdlZCBhbmQgYWNjZXB0ZWQgYnkgdGhlIERUIG1haW50YWluZXJzIGZpcnN0
IOKAlCBzaGFyaW5nIGENCmJpbmRpbmcgdGhhdCBtYXkgc3RpbGwgdW5kZXJnbyBzdHJ1Y3R1cmFs
IGNoYW5nZXMgd2l0aCBPRU1zIHdvdWxkIGNyZWF0ZQ0KdW5uZWNlc3NhcnkgY2h1cm4gb24gdGhl
aXIgc2lkZS4NCg0KT0VNIHBhcnRuZXJzIGFyZSB0YXJnZXRpbmcgcGxhdGZvcm1zIHRoYXQgZGVw
ZW5kIG9uIHRoaXMgYmluZGluZy4gVGhleQ0KYXJlIHdhaXRpbmcgZm9yIHRoZSBzY2hlbWEgdG8g
YmUgZmluYWxpemVkIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGggdGhlaXINCkRUUyB3b3JrLCBhbmQg
d2hldGhlciB0aGV5IHVwc3RyZWFtIHRoYXQgRFRTIGlzIHVsdGltYXRlbHkgdGhlaXINCmRlY2lz
aW9uLg0KDQpJZiBhIERUUyB1c2VyIGlzIHN0cmljdGx5IHJlcXVpcmVkIGZvciB0aGUgYmluZGlu
ZyB0byBiZSBtZXJnZWQsIHdlDQp1bmRlcnN0YW5kIGFuZCBhY2NlcHQgdGhhdCByZXF1aXJlbWVu
dCDigJQgaG93ZXZlciwgc2luY2UgT0VNIHVwc3RyZWFtaW5nDQppcyBvdXRzaWRlIG91ciBjb250
cm9sLCB3ZSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgYW4gZWFybHkgaW5kaWNhdGlvbg0Kb2Yg
d2hldGhlciB0aGUgc2NoZW1hIGRpcmVjdGlvbiBpcyBhY2NlcHRhYmxlIGJlZm9yZSB3ZSBkaXN0
cmlidXRlIGl0DQpmdXJ0aGVyLiBBbnkgZmVlZGJhY2sgb3IgcHJvdmlzaW9uYWwgYWNjZXB0YW5j
ZSBhdCB0aGlzIHN0YWdlIHdvdWxkIGJlDQp2ZXJ5IGhlbHBmdWwuDQoNCldlIGFyZSBhY3RpdmVs
eSBhZGRyZXNzaW5nIGFsbCB0aGUgcmV2aWV3IGNvbW1lbnRzIGZyb20gdjIgYW5kIHBsYW4gdG8N
CnNlbmQgdjMgc2hvcnRseS4NCg0KQmVzdCBSZWdhcmRzLA0KQXZpbmFzaA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPiANClNlbnQ6IDA1IE1heSAyMDI2IDE0OjUwDQpUbzogQmhhdHQsIEF2aW5hc2ggPGF2aW5h
c2guYmhhdHRAaW50ZWwuY29tPg0KQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJu
ZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0OyBL
b3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNv
bT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEd1ZXR0YSwgS29iaSA8a29iaS5ndWV0
dGFAaW50ZWwuY29tPjsgR3J1bWJhY2gsIEVtbWFudWVsIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRl
bC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvM10gd2lmaTogaXdsd2lmaTogYWRkIERl
dmljZSBUcmVlIGhhcmR3YXJlIGludGVncmF0aW9uIGluZm9ybWF0aW9uDQoNCk9uIE1vbiwgTWF5
IDA0LCAyMDI2IGF0IDEyOjUzOjI0UE0gKzAzMDAsIEF2aW5hc2ggQmhhdHQgd3JvdGU6DQo+IEFk
ZCBEZXZpY2UgVHJlZSBzdXBwb3J0IGZvciBJbnRlbCBXaS1GaSBoYXJkd2FyZSBpbnRlZ3JhdGlv
biANCj4gaW5mb3JtYXRpb24gb24gcGxhdGZvcm1zIHRoYXQgZG8gbm90IHByb3ZpZGUgVUVGSSB2
YXJpYWJsZXMgb3IgQUNQSSBtZXRob2RzLg0KPiANCj4gUGF0Y2ggMS8zIGFkZHMgdGhlIERUIGJp
bmRpbmcgc2NoZW1hIGZvciB0aGUgSW50ZWwgaXdsd2lmaSBjb21wYXRpYmxlIA0KPiBub2RlLiBQ
YXRjaGVzIDIvMyBhbmQgMy8zIGFkZCB0aGUgZHJpdmVyIGluZnJhc3RydWN0dXJlIGFuZCBpbnRl
Z3JhdGUgDQo+IERUIGFzIHRoZSBsb3dlc3QtcHJpb3JpdHkgZmFsbGJhY2sgYWZ0ZXIgVUVGSSBh
bmQgQUNQSS4NCg0KUGxlYXNlIHByb3ZpZGUgbGluayB0byBhbnkgdXBzdHJlYW0gRFRTIHVzZXIg
b2YgdGhpcyBiaW5kaW5nLCBlaXRoZXIgY29tcGxldGUgb3Igd29yayBpbiBwcm9ncmVzcy4NCg0K
QmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==

