Return-Path: <linux-wireless+bounces-21254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395EA7F8E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC53AF8BC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B233CA;
	Tue,  8 Apr 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbgGKXbO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285F219E99
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102643; cv=fail; b=rv2znOdocSmbt6wBa7/KyTJTZGaEIX0XBCYbsKR3rqaS/pIApFoo+6gum4QU9wbRGVeHtZtIHYi0SKiFvLNBTPAcstvRotDj7tnikFZ9wxvBOwDXGnG+YXSXYvY5cGnrcqpPmdN1SgxNvTLezCwKykbzEhJ2HcL1IGR0YqIc4W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102643; c=relaxed/simple;
	bh=guo6YYDbVo89JkbK6R70t6dpBWLiwQ0lXvvZW41GPq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p4pTcezQRmv1/1EYhaHbyvGh3B+mCEo38xJjz7c28ixfxzqgV7jGDDYq0WbigFP320l5VQUsMQj4ZERqxCvw5LqCAQ8XcbypnOikOnnU5re0mNfczdiIZpTZrQ10YF9ACser0a4Pfx9Z9uKZvAC8V8j7eUcQfs+s3USu5iTDk6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbgGKXbO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744102642; x=1775638642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=guo6YYDbVo89JkbK6R70t6dpBWLiwQ0lXvvZW41GPq4=;
  b=JbgGKXbOfs3OdXIOVGI5oC9BMK2Y7ArhpYPVejPtfjlgHeR/KwFSAfjs
   uOWU8kPL7FvN6E9WP0X5DD0nSEjjVvj0pEkQwpV4XlvioRp3XUpsWWlFT
   laAFoqFXlPlAOGj63BVUnrKxoW/pbuzTcCIzmtT3hRCEIJ51ZBVZudXEI
   Vz0+LzqM/kgRIhP1CVAqIVrekA9QIJqqVvqYfa5ggxm+mNfOqr6KeWOKN
   woAPxJyL+gZFGo9zXrf/12JyZH+w9n87BMDfw75vouSNmiw9PsOSBZ7Iy
   VS/7n0PXz1nUIODshPBHuCsBZ3dHlQoablZPLeXnrAmqaAyWqTRpn5c0W
   g==;
X-CSE-ConnectionGUID: RApYtwnHSgWW7ewR7pPdqA==
X-CSE-MsgGUID: Ls3S8uP/R7mcmYo6xXmP/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45642445"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="45642445"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:56:56 -0700
X-CSE-ConnectionGUID: TKfxT6UxSGuuEAsMi3IJxQ==
X-CSE-MsgGUID: 5j/oB7wDTqmDJuFS9iDqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="129154490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 01:56:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 01:56:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 01:56:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 01:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6ZhEk7Zty3dtExT4tc8Sbd99XiqZbp8VeIwDBvHP70LygNPJDW8oQf0z1VN12Mlo9NygraFuWcINCJcwH1zj6ucamYIs72xOWpUD1OJ73isNf8aHTPzReO/g2ktUADqlilKZu8Yn5s+q4hFovxpqoEqLZk4mICcDTwJEi5v8JAu/7qWRZcIjIhK0Esq6gX9mwzGW86k3vYGXDOE7ps4UTalc5f75zmmD1ZBLNIeij0VkcBedQ3d6Fg1v0bhiZvPOnq0hXch+Lz8tho4BIapgOO7cnBF18t7XlWZa4Yln+VtL+mcZHYxGgTiRo8FH94aLQP8eF61weXkxBluqLUnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guo6YYDbVo89JkbK6R70t6dpBWLiwQ0lXvvZW41GPq4=;
 b=OoxyT3rkK74cgwXuBzE9Tl6v7PUnHY8I674+hkJkPA2z/mlGEY5nHkkPQBwCrIcIvL4U1CURCsVObUCs5dTsTMabn14dSycKar+b33QDxoMthkG/XjTeGTb+RIjU4UQU1GceQ9qAHUFNCTLVQke8lCce7Tv6It05tlmYHyhhS9ATaJWqoJkllmg66AgrUnUgoTiIrxfrMXFlGNEFP+aJ5IcwywM8cmTp2cKQHAsJCcE3WUyDYBWwDkPTGs6HU1751LhzdE0d/gKsRWLweL4fuN9P+rE667kgeft8XfQcbLewRsvtDDit7pVlWF49bG4sjPYL6pPk7fET20b4dJNSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 08:56:33 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 08:56:33 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Berg, Benjamin" <benjamin.berg@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>, Arnd Bergmann
	<arnd@arndb.de>, "Stern, Avraham" <avraham.stern@intel.com>, "Gabay, Daniel"
	<daniel.gabay@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Triebitz, Shaul"
	<shaul.triebitz@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
Thread-Topic: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
Thread-Index: AQHbpvoMjZjUtwDLbUG8nOtsdV6UnbOXwlnggAAHlYCAAa97QA==
Date: Tue, 8 Apr 2025 08:56:33 +0000
Message-ID: <MW5PR11MB581048AC111336B74F19EE1CA3B52@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de>
 <MW5PR11MB581086E3DEFC1D6710892E68A3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>
 <Z_N6D9t5PV6ptXUN@wunner.de>
In-Reply-To: <Z_N6D9t5PV6ptXUN@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DS7PR11MB7950:EE_
x-ms-office365-filtering-correlation-id: e2c8f3a2-fd39-4665-0f8d-08dd767b431e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkZHZzFyb0gwSUxsWFF0eklWNVlMU1hrQ2xuTEZUQ2F0VmZ1QmJ3ZERGVFJH?=
 =?utf-8?B?N2l5QmRGcW1FYXBldlJFT0VVQ3diRWNJSXp0MVkxS2d3Y3N0dWI4ZG85NE5z?=
 =?utf-8?B?cFA2TGxUbWw1Uy9FUGFBZjUxRFNidW9iZHpVbWEvNlgxUmN1MUZOT1ZDNEJt?=
 =?utf-8?B?RVIyS3dPUGE3WjNKUTh6cGlDc1FpWEIwYTVDd3JFeGpzMEZtOFozYWd2aEUw?=
 =?utf-8?B?TUE3dVZKQVRrMEZLQlBqSFJVWDJpc3pMQVdJcERCd3AvMnp2b29CdEMwN0FV?=
 =?utf-8?B?TGlxdWkxeERWUk5uODgrdXIzR0QvczNySFhoRnZ0VG42Mi9taDJZNXJHOFoy?=
 =?utf-8?B?MWNmOVhMVWVMZThPbW5Fb3Nya2xvRWVzcDVMdk40akpVYlNQVFBxVmdublFN?=
 =?utf-8?B?bnVkT2ttVTU1NTB5ajZndXh4SEYxbjRnNnRoYkFZWWF0K1JDSEJpeDFNbDhD?=
 =?utf-8?B?Z2hYY3pTeTlVVHdiUmVVZkdEYmU5MklKdVRxNDZEK2REelJCbVRhQWtHTEVH?=
 =?utf-8?B?LytES3hJZ290SG5STTRwYnNTMkdabjJwRTlPOHl4Rk5PTGJEaFZTaWpSLzlj?=
 =?utf-8?B?bGJ4Y2tYY1Jpb3RvM0M0QzVyU3RlNTkrUXZQeVI0ZmhaYnYrVXkxK0tQQkt1?=
 =?utf-8?B?aEd2eVZVYnlRMDNaYnhjeVBRcDFRTnNiNCtXQnRDSExERDFYL2RGbElxWGJB?=
 =?utf-8?B?YTFjNTRWZVZGWHlzSVRUSmxmcndIZnZETE5oQkp5ZXJtSE16bkx5U0VWQkxs?=
 =?utf-8?B?Tkhad0sxdHJ4Vy9sU1BDK3IwNWpHbWdBa3NqSlB0YTNLT040U0dyMHMydVFX?=
 =?utf-8?B?Tjlaa00vQzZTZ05zZzN5aTQvMURUanFWYUFRWWM4MXd4SUw0YzhKMVdCd1lQ?=
 =?utf-8?B?WUI1T0FyRyt6QlllSVRjbzl5akhlU01Rd0I0VVgrTUVNLzViZVFsWXp1emJo?=
 =?utf-8?B?aktYbEhSYmwxYTZjN0JtVWg2OHdGYkI3RVpRcUN4NTR2N2NqeUJHOC9hVEdv?=
 =?utf-8?B?S2Vqd25lMVkzci9YOC84ckNOV1pMWjFKM29oVUJTS0hYNDJqNlM0bUJ3T1pP?=
 =?utf-8?B?RkNSSkxnSStoK3dKYXMrRVhJQUM0SldtVnVJMDRZMS9kM2tUV3dMSXJpWmFu?=
 =?utf-8?B?cGh3STc3algvWU1tVnh4QVhKMkpscndEeWRUY3RUT08xY0J0SlBVZ1Axb3Jm?=
 =?utf-8?B?WUEvT2FTeDdDVkd3c0FvbUhISEJFMTJhTWoxRjdteXJZQUF6bENWQ2xzRHll?=
 =?utf-8?B?bjZZdFMrbzVoM2RHdkR2d1MyNFVOWDBKTU44WVdzc3p0UjRDUlZXd1pBY3Jr?=
 =?utf-8?B?M0pMZWdVYzM2cHd0NDNTTFljR3ZMbHNLcjhLSkhCOGhrTUMrRldlTzQ3Smpo?=
 =?utf-8?B?MGVlZTUreFRRRzRDTXhkamJGa2tLUjJURE8rdk9RT0RyeVpPN3FzQ0VLVFdn?=
 =?utf-8?B?NXpRS3k4aURXMmJaRkxHUTBiMlRlNnBzL3o1UG5Bd0V6c1pqclNHdVl3QmVH?=
 =?utf-8?B?SmI4Vll4V3VwYmRHNHVXSzVONWZ1dzVxbmo2K21QajlMcmJSZkQ5di9oTDQ5?=
 =?utf-8?B?SldKT2lxcUFLcDFReGswNjhraEhuQ2h0dUhsKzFjQnZWQld0VnhweU1BK013?=
 =?utf-8?B?bjUyV3gxOFAwaEc5WmpCdGJGYUpzaHhjTnJNdWVXMkZRUWVXZ3dpaGsvdmE5?=
 =?utf-8?B?VFRPSHhOSmRmMWNKcm1CemRKNFNDNWZZZWJFMmpIRm9rNis4QnhTUHRneHhD?=
 =?utf-8?B?N3VaYlZwbjVSQkt4V2hoV1RIL3Vzckk4ZjhNck0vZjE4UTVBUjdOYTZYWDJH?=
 =?utf-8?B?L2pjMXVpTVdFSTM1WlFtSzR0MjUxdEE3ZkpjRWNwUFhvMTI3TFBScW0wSzl2?=
 =?utf-8?B?VmJSVmdteUNaUzFsdGVvd2gzWkRZMFZjcExoaThoR0dhWTcxc2VQTGNUUUVo?=
 =?utf-8?B?dU12TzFnMUFlejFEYXY1eC9GWXd6aktrVmhkZEh5eCtvWWZBL2wwNjBmZGw4?=
 =?utf-8?Q?VqEopaKS5DRFZAWtkjp2C15sX5KHZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjRJS2kxalZLVU9lT2lSb0VOZ2k4N281Y0h1bUhGVmJNUGlwRFVkczVqNlg1?=
 =?utf-8?B?NHpGMmRFR3hSTUZ6K1JMYm9wWGlnQzVyVGxWRi9GalN0TEdTYld2elhSZ3FX?=
 =?utf-8?B?bEJJWHc5NmxCQWtFN0M0RE1qdzFmTmphUHhYc1ZkSWJ4TmNVUkg3SjBidE9U?=
 =?utf-8?B?TE54bEhMRUE0TTVuamVaWTZRejBWc2Y5ZjEwMDgwbFhlSWQ3WE9OdU5YbFFB?=
 =?utf-8?B?VVdBY2JxdG9kbERsTUtKY21KRk8zemg5SEF3RDdTWll3WjVQenlBQitYSFpY?=
 =?utf-8?B?TWgyRjZDU3c2YzQyWlRoVmtudUZPQWp4V1ovWEJVNVhQMGxmNUk2QVQrUHpz?=
 =?utf-8?B?WURtUzhYSWpXR2FpWkx5OWdhdTNGN291MGh0YUZ4OUxBdXZNUldpeHZmTzNk?=
 =?utf-8?B?R0d3QTdJL2I2dUVXSEFZbTRpSFNPMzkyR2hGaW9USVIrcExkRFFzWjVUZzNu?=
 =?utf-8?B?WWxxQmpvU2hFY1N0U0hBcm1xcmZMVm5iOWx2MTJtQzBlMEljTC9uMS9obE5B?=
 =?utf-8?B?Y0JseUJaZlFEcm9ScXU5R3NSVFEwSXRkTk9mMG1kNmpFeW55R0YyUGpTOS9R?=
 =?utf-8?B?VHlaMGYzWGppTGVoK054SndOUlZjWGFsR2pEcEh2ZXpSdkUzaS9zYS9mZWNm?=
 =?utf-8?B?MmJJeGl3VHhTaGcvdXB5WitjamNHeUdRbk5aandVTHVvL2pOSjdrYVl2UlJr?=
 =?utf-8?B?V0hkMWdqVmthM1gyTC93c3p2SGpkcHE5cWJtT2lBWTJueXhBNU4rZ2F4aDhQ?=
 =?utf-8?B?Z1ljZlE1a1V4dXZoRzNDUTBhWm0vYWpkSG9ZYzkvV3lIbCtuRUwxOFR6MzE0?=
 =?utf-8?B?NThlOFBjZGtYcS9vODIrWDNRZVdybzc0MEZPcmdIcnZZODZVWnl3dFQ4alpS?=
 =?utf-8?B?M2FaWWoveG5vaTJkbWoyZFdsMHBjZ2ozMTRnSzBvSG12VXU5SVI4VHhKbXJT?=
 =?utf-8?B?WnZrYUpyUWYxTUZFT2RqY0t3d2FVUnJGWlBrbDZxcEFpcDVmTnRaMkhXVzcy?=
 =?utf-8?B?RnlYV2JScWZlc2dKZzBTaWtwa0h6K1lxN29GYjZVa00xUlhMcXNScHR0TUl1?=
 =?utf-8?B?cFV6Q1hucHR0OGJzb2FtdEtMY1NWeFgyU21IQ1lVczhCa0Y4cWpncG03aHZt?=
 =?utf-8?B?RUpZZmdpRE02L1JKai9EVDBHZTVxV2d2WFY0allNZGUvNWNuYi8zTVpyc3Ix?=
 =?utf-8?B?aEVWZGRWcXoxZk9obFFoNHlzb0lobnhQVHhsb25mdy92L3d1V0xWMlRkVG52?=
 =?utf-8?B?RkhVSjVHdS9WQlJabkFUSWswTW5KSk5NZGN4Y1h6ejgxeHBjaG1tY2RWSDVX?=
 =?utf-8?B?VkJyeHZLNW5VKzdqaFVFcE9oaU9uL3RGektEc05JUFpkbVZQYnFXNmVwOXp2?=
 =?utf-8?B?cm1EcjBRSlRhNGlUcjM0MjhVY3NVY2hRNWVYVkxhcVVadVZqb04rVllIRFZI?=
 =?utf-8?B?NDg0SWlUL29ubkZ6eDBId3dRUFZBNWNldVVGZGNDM3pEWjdEOE9vU0FCK0la?=
 =?utf-8?B?YzVHZ05XYWlMTjNmVnFEMEpzbk9FY0lRUkhGVWxwM0lBZU84amdPaldoOXAy?=
 =?utf-8?B?dTVxdGVUbnhtM0pLVFQxN2NFRFZIbmE1aUV5ZGdvU3gzaFBWTUNzTVJFV1RT?=
 =?utf-8?B?QTB4MkNndG9Bb0VneGR3QTZ3dGJiU29RQ3Q2bEZZSTNiUU5iWlcvVmtZUUln?=
 =?utf-8?B?UlBYRFZBdXg1V3kwNWplRzJxaDNxT21IMlFTM09heVFVTlc2TXVraGpFbHJP?=
 =?utf-8?B?MlMwZU9XYkFiMnNVSmJFYWdpVHA2RTNGdTdKUTRUSDcrZWY0Qy85dkFHZmxQ?=
 =?utf-8?B?M0dvNlN1QTVpVzRuaE1lS24vcHMrTXkwWWlSL2xaZTFxL3RIOFc4bCt6SjBJ?=
 =?utf-8?B?Y1VzdmRDQk9obVlBbUZBT3o5NnlmYThUeG16cnFUdXVYdm1TLzV6Y3Iyb1Rw?=
 =?utf-8?B?OVZydnpxZDJxQUJ3L1BldmpRMDBOTllWeXBYL2prdDgxU2c4aFJneXBBMG1M?=
 =?utf-8?B?ZFRJUnR5RDh3QVZXSFdKRzVVU29yaUo2c3BNOFlrTlN1QjVRR21OREFTcXdQ?=
 =?utf-8?B?cXZXL0hLbU9HQmxVQjhuMkVRYjZIemRPVU5yR1lXUyttS3lqeTNsY25FUkl5?=
 =?utf-8?B?NmRHbGV1T1dYQWdwT3RseUoyRXRKWjlLdUlZTFVQc29jaUtPdVBnaWtlQTN1?=
 =?utf-8?B?eHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c8f3a2-fd39-4665-0f8d-08dd767b431e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 08:56:33.5417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjb5HGdU7R5PDvgLdhGqmxe67qSNxDQHL1zRF71muI2wkhOsCY85m6ZR+ZOtnIIpLZUpEQoO0mRuQbZocnvjGbTsKv5+rvp5TTEvp02etUp+R4l+zHra+JGkgFTYkogn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgV3VubmVyIDxs
dWthc0B3dW5uZXIuZGU+DQo+IFNlbnQ6IE1vbmRheSwgNyBBcHJpbCAyMDI1IDEwOjA5DQo+IFRv
OiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVs
LmNvbT4NCj4gQ2M6IEJlcmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEdy
dW1iYWNoLCBFbW1hbnVlbA0KPiA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPjsgQmVyZywg
QmVuamFtaW4gPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPjsNCj4gQmVuIFNoaW1vbCwgWWVkaWR5
YSA8eWVkaWR5YS5iZW4uc2hpbW9sQGludGVsLmNvbT47IEFybmQgQmVyZ21hbm4NCj4gPGFybmRA
YXJuZGIuZGU+OyBTdGVybiwgQXZyYWhhbSA8YXZyYWhhbS5zdGVybkBpbnRlbC5jb20+OyBHYWJh
eSwgRGFuaWVsDQo+IDxkYW5pZWwuZ2FiYXlAaW50ZWwuY29tPjsgQW5qYW5leXVsdSwgUGFnYWRh
bGEgWWVzdQ0KPiA8cGFnYWRhbGEueWVzdS5hbmphbmV5dWx1QGludGVsLmNvbT47IFRyaWViaXR6
LCBTaGF1bA0KPiA8c2hhdWwudHJpZWJpdHpAaW50ZWwuY29tPjsgbGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHdpZmk6IGl3bHdpZmk6IG1s
ZDogZml4IGJ1aWxkaW5nIHdpdGggQ09ORklHX1BNX1NMRUVQDQo+IGRpc2FibGVkDQo+IA0KPiBP
biBNb24sIEFwciAwNywgMjAyNSBhdCAwNjo0Mjo0N0FNICswMDAwLCBLb3JlbmJsaXQsIE1pcmlh
bSBSYWNoZWwgd3JvdGU6DQo+ID4gPiBGcm9tOiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5k
ZT4NCj4gPiA+IFNlbnQ6IFN1bmRheSwgNiBBcHJpbCAyMDI1IDE2OjQ0DQo+IFsuLi5dDQo+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kMy5oDQo+ID4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kMy5oDQo+ID4g
PiBAQCAtMzQsNiArMzQsNyBAQCBzdHJ1Y3QgaXdsX21sZF93b3dsYW5fZGF0YSB7DQo+ID4gPiAg
CXN0cnVjdCBpd2xfbWxkX3Jla2V5X2RhdGEgcmVrZXlfZGF0YTsgIH07DQo+ID4gPg0KPiA+ID4g
KyNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gPiA+ICBpbnQgaXdsX21sZF9ub193b3dsYW5fcmVz
dW1lKHN0cnVjdCBpd2xfbWxkICptbGQpOyAgaW50DQo+ID4gPiBpd2xfbWxkX25vX3dvd2xhbl9z
dXNwZW5kKHN0cnVjdCBpd2xfbWxkICptbGQpOyAgaW50DQo+ID4gPiBpd2xfbWxkX3dvd2xhbl9z
dXNwZW5kKHN0cnVjdCBpd2xfbWxkICptbGQsIEBAIC00Nyw1ICs0OCw4IEBAIHZvaWQNCj4gPiA+
IGl3bF9tbGRfaXB2Nl9hZGRyX2NoYW5nZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCj4gPiA+
ICAJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiA+ID4gIAkJCSAgICAgIHN0
cnVjdCBpbmV0Nl9kZXYgKmlkZXYpOw0KPiA+ID4gICNlbmRpZg0KPiA+ID4gKyNlbHNlDQo+ID4g
PiArc3RhdGljIGlubGluZSBpbnQgaXdsX21sZF9ub193b3dsYW5fc3VzcGVuZChzdHJ1Y3QgaXds
X21sZCAqbWxkKSB7DQo+ID4gPiArcmV0dXJuIDA7DQo+ID4NCj4gPiBZb3UgYXJlIG5vdCBzdXBw
b3NlZCB0byBnZXQgdG8gdGhpcyBmdW5jdGlvbiBub3QgdW5kZXIgdGhlIGlmZGVmLg0KPiA+IFNv
IGlmIHlvdSBkbywgSSdkIHJldHVybiBhbiBlcnJvciB2YWx1ZSwgbm90IDA/DQo+IA0KPiBOby4g
IFRoaXMgY29kZSBzZWN0aW9uIG9mIGl3bF9tbGRfbWFjODAyMTFfc3RvcCgpLi4uDQo+IA0KPiAJ
LyogaWYgdGhlIHN1c3BlbmQgZmxvdyBmYWlscyB0aGUgZncgaXMgaW4gZXJyb3IuIFN0b3AgaXQg
aGVyZSwgYW5kIGl0DQo+IAkgKiB3aWxsIGJlIHN0YXJ0ZWQgdXBvbiB3YWtldXANCj4gCSAqLw0K
PiAJaWYgKCFzdXNwZW5kIHx8IGl3bF9tbGRfbm9fd293bGFuX3N1c3BlbmQobWxkKSkNCj4gCQlp
d2xfbWxkX3N0b3BfZncobWxkKTsNCj4gDQo+IC4uLndvdWxkIHVuY29uZGl0aW9uYWxseSBjYWxs
IGl3bF9tbGRfc3RvcF9mdygpIGlmIHRoZSBlbXB0eSBpbmxpbmUgc3R1YiBvZg0KPiBpd2xfbWxk
X25vX3dvd2xhbl9zdXNwZW5kKCkgcmV0dXJuZWQgYW4gZXJyb3IgdmFsdWUuDQo+IA0KPiBUaGF0
IGRvZXNuJ3Qgc2VlbSB0byBiZSB0aGUgZGVzaXJlZCBiZWhhdmlvciBoZXJlLCBqdWRnaW5nIGJ5
IHRoZSBjb2RlDQo+IGNvbW1lbnQ6ICBBcHBhcmVudGx5IGl3bF9tbGRfc3RvcF9mdygpIGlzIG9u
bHkgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIGlmIHRoZQ0KPiBmaXJtd2FyZSAiaXMgaW4gZXJyb3Ii
LiAgU28gcmV0dXJuaW5nIDAgaXMgdmVyeSBtdWNoIGludGVudGlvbmFsLg0KPiANCj4gVGhhbmtz
LA0KPiANCj4gTHVrYXMNCkFja2VkLWJ5OiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5r
b3JlbmJsaXRAaW50ZWwuY29tPg0K

