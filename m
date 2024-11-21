Return-Path: <linux-wireless+bounces-15574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0E9D53BC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24ECB20C44
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83D1C232B;
	Thu, 21 Nov 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm+QJRDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1143AA1;
	Thu, 21 Nov 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220010; cv=fail; b=Lk6b/j7WX6GJ2g3zdyr5QdV40WDNCKLrJbrCO/7Q17VnQky5PsnL02opddKAhrom1rFeJNkceaELdmDinmKpduJgthVa3XAHBhXdIr+kiguROMKmUWsFnT1L4wN4zAP5gULo2qPez7gHw7VBztPjEvgLVK71qV3rz9WHBopvtFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220010; c=relaxed/simple;
	bh=f1KFKH1c1JCtSgM4KeSrlzN+BVJapLUzbtP6EGXO0Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8XKz8Ar+VkIGXyDxMztQtn1ztrbJbN7zidEJKtAHT9PBVViqeAzNrc3smPdkd3A2oChDwKzzDkB0c7uKoWOma2mpJEEjo45STZn6cuoXWvbMSDJDazuBAd40UriSil9gDANh/p6VLNOgo4AYaSeCMncQpE/CJFHqYZqRVyow3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm+QJRDa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732220009; x=1763756009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f1KFKH1c1JCtSgM4KeSrlzN+BVJapLUzbtP6EGXO0Xo=;
  b=Bm+QJRDa59cnpxy3UelkkZPsxm0HGMCe4Tjaqpx31kG5SGrdXsLECfnk
   Zfi8l8ZwiZyzo/bkIGMJ+uPnTnv8XuA+Nr7BHgwTyEiK9M8eKiCXtwy1x
   rS7ubgYx/c1g0lGuKawVNxx+FNuwuEv1fObCeqdAk1UlK15t8/UO8xAm9
   b95NUpL9Y4d5bySMBJpstZkyWneGuwu/gVZqyVGzItsR1hhrZRW9+K7Rf
   LQONCgH8FmIt3cI4EPoccgwMi1CnkHWyLr7Olgr5OwyqmOw4lF+Xuo2VD
   BBEl/w3N2scmFsiAHOAP60ZCTMfVWgjuY2NQ8akpZNPZG+6nvU9s2Otd2
   Q==;
X-CSE-ConnectionGUID: 30D58/p2SQOTQVaSQ12qMA==
X-CSE-MsgGUID: vsgrWfA7Tb+ceN4fL1dldw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32212936"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32212936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:13:29 -0800
X-CSE-ConnectionGUID: kITyOntES8CZ2AH6VbND6w==
X-CSE-MsgGUID: 6JYZ07+9RA+6ZKrfzjAuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89999764"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:13:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:13:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:13:27 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:13:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfEdfdlWYba6x3hZ9NIHmhDGPJakkv7valeNYkxu+oS4DsO0ySmtINu8QFsAifHJ134k6hngTI/3naE2FYl3MZqNigTG0qtm67wktED8FSmPkJM5nxaUVVKiYpZQmvEYnEs8nEIdmDQSoDYFH7vutEEKu+fQo9+U+/rciHwnDjalIyIAz1nQm7vWG1EvHmdf6Y47AkhVUlfMDNxIBQ/I6arEHiOmu4qharCPmQ1r+jghlF7diO7P0Wkh31tNhzWeD4104S8QNPwzuqkEeMC79/2iNNTjiTu5owxyO4UV1e7iR7roH5wVs8ytzLsz85p4WaAFJC7liJGXZN3JBfNuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1KFKH1c1JCtSgM4KeSrlzN+BVJapLUzbtP6EGXO0Xo=;
 b=MbxVOxE84/uWKSbVDeJxXejx4lG7KTemvEvYwItjXWUqkc8JQeEweQaEdVYUWH79soV0Cl+rbmXpLgaaIbutGBZo3bpjXYH7UG+VZ9rp5CNRDuAYgXBYrYFcgD+gKExR39Pb5yHdwT65B1BLz7J29Q+iBGbijG5PxOwsoYN9mF6J/Oi1N/Ci5n14UdzOYycTOY/BctaH7KKaM5oN7EmN3ymTHrIwJaOiDVMyX8LwLtFQt4dH+x82ZuW6NxSTo9qeeRJp/qVhx6oPE7IV8Ka5uB+FT8EgL+4Ih4LY4xi2ZAD3hPR1B45Rwetyr6uXPWYiioRXiLeQBYSlhkg0lWmCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Thu, 21 Nov
 2024 20:13:24 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 20:13:24 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: =?utf-8?B?SnVhbiBKb3PDqSBBcmJvbGVkYQ==?= <soyjuanarbol@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [PATCH v2 2/3] iwlwifi: mvm: Enclose multi-statement macro in a
 do while
Thread-Topic: [PATCH v2 2/3] iwlwifi: mvm: Enclose multi-statement macro in a
 do while
Thread-Index: AQHa8oEuDn6nG2UwbE614A6JXImLerLCuslA
Date: Thu, 21 Nov 2024 20:13:24 +0000
Message-ID: <MW5PR11MB581014711CD5F3E2812062E9A3222@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <cover.1724103043.git.soyjuanarbol@gmail.com>
 <61d25f02322b875dd9eb37ea992dc62be7c75840.1724103043.git.soyjuanarbol@gmail.com>
In-Reply-To: <61d25f02322b875dd9eb37ea992dc62be7c75840.1724103043.git.soyjuanarbol@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB7596:EE_
x-ms-office365-filtering-correlation-id: e6672540-59cc-487d-40c5-08dd0a68f3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T3FrZTkwamNmakdqUHQ0U01Qa21aT0E5angvMGlYK2hSTU9kWXNJQURGVm1U?=
 =?utf-8?B?OFdqT1RFakRkTC9lTGxVd1R6LzBEbUR3ems2d204TWc4T1BzU2NmS3FkTTh6?=
 =?utf-8?B?Tm5JcExuRzZnK0d5N1JQMGRtdjhDdzZCUEorcmt5WmdHM0Q2K3ZhTzFaN0Ew?=
 =?utf-8?B?KzZxN1lkQXJhUzEyMW0yNXpzWW40U0x6UkIzZGl3WkMyNU15K1k2QlNSTU1s?=
 =?utf-8?B?V2tHaDUyRktQY25xTDdNa1U5L1Nzb1hvaE1HMHU3Mi9oRHF6Q2RiVUhVQVFu?=
 =?utf-8?B?SGNmREJIbVIySWY3ajF6S3o1TkZ2UFdNb3VxMWZuc2JhOTJ2cEpHcW5qWlVB?=
 =?utf-8?B?dTE1eHV6MkUvQnpZWW0xVXZacVVjL21ZRmpmcXhKMEdhUVM0VzMvdEN3a2tL?=
 =?utf-8?B?S0FyQW40bDlqandwTVNBN0ZmTXhMV2RNNkpIMTlSRzdtdDlSMjJzWXlkS0Ra?=
 =?utf-8?B?NnIvOEx3cjlMU2hMNzQ5ek9SNUdraXI2N3ZqQmM3SzdyeHQ4K05Td0M1VS96?=
 =?utf-8?B?em9vOXc0YzBMbTVybVlhalhWZGtmMXQwdEVmZmorN0l5dE5nNTQ1azlibmhD?=
 =?utf-8?B?WmV1L2pXVUorOEFGWXlQNy9Ea3g4bmc5a2t3eTYrVGlEd01pRHl6V2lxMEt5?=
 =?utf-8?B?U3lYNlpBVXdYUnRNWERHRDdLRXFYS2tRUW16MlhzMjdSY20wWXR3bXV1czBL?=
 =?utf-8?B?SEszcS9FZXVWT1pDazBUZFlLOGdJeWlGcWZWN0NRU3pJTlFZYnVwMVl5aDJl?=
 =?utf-8?B?TWZ4MWdCZkdLMCtZUGR0VitHTTRYZnVzdjJBUVRZZVZSazc4WlIySlFYYWhz?=
 =?utf-8?B?ZTkrNnhaUmdMcWl6dHdGV2paTzZBMnVkQm5ySUs4TnM2SE41U2hKSnpoeGgy?=
 =?utf-8?B?Slh6bDFQdi8rTFJSQmwyUjhVKzAzZU9FMUFEWWluQ3V0UVZDQXhkRU94OWxP?=
 =?utf-8?B?V1ZLYVptdTZXWVBpdnBydmgzMDFRdXFtWloyTmx5ai9SV3JEZFA5aTVSa25Q?=
 =?utf-8?B?VVZ5U3IrRkVxaG9kcUhJdC9ibitXZzVORWZuaExnSnRUMHFBM0w2MDVYZlJF?=
 =?utf-8?B?NHFZcFpoM1RuWklJMDdyemMyak44alRYWTF1aHdJdUx6N1ZHVlpPOVRuVU84?=
 =?utf-8?B?a0diV3EvNjVXdUV4cCt0aUhYek5UQjlBRTZ1R1lTQ216eExLMW5UMlBGay82?=
 =?utf-8?B?dGUvNFVZcHVBOUdoenlydkFzR0taN3FiNmpVb2J1NkEveERrMytmcEczVFZ3?=
 =?utf-8?B?Q0hibWpxdjFEUm9MVFVrZzg2VXhvL0k4L0hWMlp6cnUwVFVJR3JGN2hQTk5y?=
 =?utf-8?B?NDdWZENhZnN5L1k0Zm9jdUY3TWdtemJpcldKQUZja0pORVplbWd3ZlZEZytj?=
 =?utf-8?B?Z2ZTczR2NENxNGczdmNDKzgxR242RHczVUsyWm54QlRzVEczY3hNY3d2a0xz?=
 =?utf-8?B?ZTZSaTJuZ0kzK2o3S1UvQnF3T0VDMTFUckNxbU5aNjNqbkZ1QWdaRURUbVZN?=
 =?utf-8?B?dlJJMS9CRS8xZTU2emFKVEpCeGhOenpQYWk4cW9iVFhRSkJwWEJkTVlUVTdi?=
 =?utf-8?B?RERQcEovN2xIV2RQRDRXTGRPelM2L1pId1Vnb2tTOFhNY0RwYUg3MldCS3Fy?=
 =?utf-8?B?c0hGa1hpdGRkS2Z6aVJCK3dObUlua242ZGMyUmNrWkhsNm1HcWsvOGJwL0VX?=
 =?utf-8?B?R1VlTVRjM0NUVlB0WUcyS28wb2hibUlldEJocFZaa1FBTDRVMnJmSitTd05v?=
 =?utf-8?B?Vkk4ZUEwc1dyTUhNbTllek5xbWhwYU5xNy9RTEpQdytCMkkxVGU3M1RyWis5?=
 =?utf-8?Q?Zt3RBBR/Yp9nUYjQcWbQ7f6P821rnMFr46Wtg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1pQ05yYXRVNWJnK2tpSng1L3RVOWEyQnpDQ2syQmswWEZjQ3M0SzJSRkFt?=
 =?utf-8?B?UEwzc3FlSWhNcG82UmxLZkJtdTFHMTF1RVB0TDQ0YlIzYXptZlRTZGRYVWt3?=
 =?utf-8?B?cmVZcFY0SGhQYy9RbUdUN1IvcHQxRWYzcTUwdk9XSVA5cENzeFp2dzFpeWxm?=
 =?utf-8?B?cUo3NVdEUEF5cm9jZUlKOHNCVnhCWGRkSkg2UkpqTEVrb0s1a2FSNkMrTWRN?=
 =?utf-8?B?L3RIRHZ3eThla256YmkxV1c0RUwxa3dLS29rRlJHMEx6NUVxZXVyMXc1VGFn?=
 =?utf-8?B?VEdCaXFNcnEzR0k2Qk4rY0dxZjZQRG9GMVBNZ0YwcmM2OEVmeER3K2RDTCs1?=
 =?utf-8?B?ZWlUeFpRb05nR0hVSWVKNFhaMnZnMHNtK1dpRW9tQ2FoMnNGQW1WTi91d1hh?=
 =?utf-8?B?VTgydGxkaWdOSHBPT3RlVmxtVEN1bXBCbjJTVlJySHJYbGRmTVlGOUdPME5p?=
 =?utf-8?B?N216cDZ1bWhJYmxQMk9qYURKS3A5UUppcmNqem41S21xSnBnWTBKL0NZMkNZ?=
 =?utf-8?B?RUpxYW44bC95cWdBK2YxZXZ5eHJiUVdWTzgwVmtTS0tWMGwyWTJaMWtlL3hI?=
 =?utf-8?B?aEE0RTcxTHlweVBma3RHeWo5TzZSUzJnMENwV0Jza1NLRm1QQ1NtTGRGeGgy?=
 =?utf-8?B?SGRKNDNEbU9Td2lBVVc3dnBlZnpQdHIvWEJSRG9FdXlnK3ZUalo0SERFQk1B?=
 =?utf-8?B?ZGhQUnlhVmFKL2dRbHg1UThJQnk5UkwzREtMRTFsZm1WaExSMTdNYUJMZVZt?=
 =?utf-8?B?UzRzN2pRVS8vOHVLMm9LUWVpWUVZaklyOWdLUXlacTlZRGs0L0hRdmFMbjN1?=
 =?utf-8?B?TWJaaGpnTmxvNUg0RGJISUl3cEY0L0JDOW5uQ0lwMVVtQmVrcUVtU2hBSzZs?=
 =?utf-8?B?dTNTRnRIZWROS01hUkRXNDBmSmdjbUwwU3hycXVhQzk1QWpZSVhEdGczWTRa?=
 =?utf-8?B?L2M3TDhCL3c0VEV0ZFpxaHZYYktMeFlNeEZXR05ZcVNKZGM5Nm1SNUpUNUJT?=
 =?utf-8?B?NVl5YS9qRS8zK0plZStmZVd6NXczdCszdzZZYytDQkE4ZjlySTFWWGwrTkEz?=
 =?utf-8?B?Y3VOY09vcWpQdmVWZ0lBOVdGNlBzT2tZVWFUTi9CV3IxS2FrY1BxKzltK0FN?=
 =?utf-8?B?VFFKN29PS1VJZDJZWXp4eldRWVZQNGc0YmpySmhIcjVSNzA3dEdyT0V3YWxs?=
 =?utf-8?B?d1I4ZFQrYytVelc4cG5tcHplNzNIanRLY1JLaXpORXdRVngwZmoza3BWdytF?=
 =?utf-8?B?cklqWEpNZW55a0tYRWxPdTBQb1pPTDlEVHVMM1AzREZMRUNqUXo5WHZnOU81?=
 =?utf-8?B?OTJWRUp5TWZkdExQYUEzODk2Q05WdHVPbGVIZXFkbjJMUHhwRU5qSDY0a1Np?=
 =?utf-8?B?RUQ5UXFDVjU1UXFKK3IrZWtLcXY4WTkxcFZCM2IxcEsvRTdBV2ZtMUZzYWJy?=
 =?utf-8?B?NDNqRmlROStrNTFLaS8rMVU2cXBIellYZ05od0xqdUV1TmdaTHJVQVZhbmlH?=
 =?utf-8?B?alE2S25oL2tuY2gxSklhd1Y2V2pKZFloZTBpeEVFWUxweU5zaktaS29DZ1N4?=
 =?utf-8?B?QVVicm1sbjhhc1l5ODhoM3UrY0FnNmMzYXAxVmJtR2poN1JmUnlHOUpKSnlS?=
 =?utf-8?B?MEZmUzQ2a0hXRzBEazZ4OEVIVTlTNnJTS20xMHRMTlh2cE9UWmZYRjlJUmlT?=
 =?utf-8?B?NFB4amRDRzdFQ05jY3ROSmtOK2dHZ25GTG9HMVVXN2tHb3MzL3RHdDhkeEVX?=
 =?utf-8?B?cDhVQmtVdzhnTFkyNTBBemlWT1hIaWhYR2U4R0pmU3VPMFByaDRmamJkZXFw?=
 =?utf-8?B?cWo4Z0JuRTNKMFJNN2VwVld1Y2I4L1NlYmdoUDAxc2psZ1pqN0Nab1NtWlZk?=
 =?utf-8?B?Y3BjR1FxRm42dmdtVXJMdEJ3MjcvSVczeU1vMmMrMnllZFQyeWhCTmJaSU5N?=
 =?utf-8?B?Y05LNjJYWGI5SWo2bG4weVRMaGpqSGo1bEtTT2JZbEFXTEt6cExmZzh0V1V6?=
 =?utf-8?B?WTFZSnJTNFIzeDRTNUpVaVdoblZ1VnNDdkxLcGk2Y2VYTTluZElSRnVXL2Q3?=
 =?utf-8?B?ZjByLzA2ZFU5WGpzWmVyTHFQOUhNNFFRWkZLd05TUk1ocVdldlJ6MGxRR3Vo?=
 =?utf-8?B?T1orWFNJWXhWMG51eDBtWEREZms4ajlKc0hGeDJkdzI5Ky82RXZpOTZGNkkz?=
 =?utf-8?B?YWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6672540-59cc-487d-40c5-08dd0a68f3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 20:13:24.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRVDa44YU2nQgrZXDrutphPG5nXlWZe0VULoN+FXAYZuefmJ6x37QSsx9SBG3z6tWZy8AO5jwnCJndcqCQg5l7X/wCiZLGQYqF0LuWzhusB7jZEFnCAflT13ciql4Px+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVhbiBKb3PDqSBBcmJv
bGVkYSA8c295anVhbmFyYm9sQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMjAgQXVndXN0
IDIwMjQgMDo0NQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1p
cmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47DQo+IGt2YWxvQGtlcm5lbC5vcmc7IEp1
YW4gSm9zw6kgQXJib2xlZGEgPHNveWp1YW5hcmJvbEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAyLzNdIGl3bHdpZmk6IG12bTogRW5jbG9zZSBtdWx0aS1zdGF0ZW1lbnQgbWFjcm8g
aW4gYSBkbw0KPiB3aGlsZQ0KPiANCj4gVGhpcyBwYXRjaCBlbmNsb3NlcyB0aGUgYENIRUNLX0JX
YCBtYWNybyBpbnNpZGUgYSBkbyB3aGlsZSBhcyBwcmVmZXJyZWQgYnkgdGhlDQo+IGd1aWRlbGlu
ZXMuDQo+IA0KPiBUaGlzIGNoYW5nZSBpcyBwdXJlbHkgc3R5bGlzdGljIGFuZCBkbyBub3QgYWZm
ZWN0IHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SnVhbiBKb3PDqSBBcmJvbGVkYSA8c295anVhbmFyYm9sQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1xLmMgfCAxMSArKysrKysr
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9yeG1xLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1x
LmMNCj4gaW5kZXggMWEyMTBkMGMyMmIzLi42MzY2Nzc5Y2NhZjIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3J4bXEuYw0KPiArKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1xLmMNCj4gQEAgLTEwNDMsMTAg
KzEwNDMsMTMgQEAgaXdsX212bV9kZWNvZGVfaGVfcGh5X3J1X2FsbG9jKHN0cnVjdA0KPiBpd2xf
bXZtX3J4X3BoeV9kYXRhICpwaHlfZGF0YSwNCj4gDQo+IAljcHVfdG9fbGUxNihJRUVFODAyMTFf
UkFESU9UQVBfSEVfREFUQTJfUFJJU0VDXzgwX1NFQyk7DQo+IA0KPiAgI2RlZmluZSBDSEVDS19C
VyhidykgXA0KPiAtDQo+IAlCVUlMRF9CVUdfT04oSUVFRTgwMjExX1JBRElPVEFQX0hFX01VX0ZM
QUdTMl9CV19GUk9NX1NJDQo+IEdfQV9CV18gIyMgYncgIyMgTUhaICE9IFwNCj4gLQkJICAgICBS
QVRFX01DU19DSEFOX1dJRFRIXyMjYncgPj4NCj4gUkFURV9NQ1NfQ0hBTl9XSURUSF9QT1MpOyBc
DQo+IC0JQlVJTERfQlVHX09OKElFRUU4MDIxMV9SQURJT1RBUF9IRV9EQVRBNl9UQl9QUERVX0JX
XyAjIw0KPiBidyAjIyBNSFogIT0gXA0KPiAtCQkgICAgIFJBVEVfTUNTX0NIQU5fV0lEVEhfIyNi
dyA+Pg0KPiBSQVRFX01DU19DSEFOX1dJRFRIX1BPUykNCj4gKwlkbyB7IFwNCj4gKw0KPiAJQlVJ
TERfQlVHX09OKElFRUU4MDIxMV9SQURJT1RBUF9IRV9NVV9GTEFHUzJfQldfRlJPTV9TSQ0KPiBH
X0FfQldfICMjIGJ3ICMjIE1IWiAhPSBcDQo+ICsJCQkgICAgIFJBVEVfTUNTX0NIQU5fV0lEVEhf
IyNidyA+Pg0KPiBSQVRFX01DU19DSEFOX1dJRFRIX1BPUyk7IFwNCj4gKw0KPiAJQlVJTERfQlVH
X09OKElFRUU4MDIxMV9SQURJT1RBUF9IRV9EQVRBNl9UQl9QUERVX0JXXyAjIw0KPiBidyAjIyBN
SFogIT0gXA0KPiArCQkJICAgICBSQVRFX01DU19DSEFOX1dJRFRIXyMjYncgPj4NCj4gUkFURV9N
Q1NfQ0hBTl9XSURUSF9QT1MpOyBcDQo+ICsJfSB3aGlsZSAoMCkNCj4gKw0KPiAgCUNIRUNLX0JX
KDIwKTsNCj4gIAlDSEVDS19CVyg0MCk7DQo+ICAJQ0hFQ0tfQlcoODApOw0KPiAtLQ0KPiAyLjQ2
LjANCg0KVGhlIGN1cnJlbnQgdXNhZ2Ugb2YgQ0hFQ0tfQlcgaXMgYWxyZWFkeSBzYWZlIGFzIGl0
4oCZcyBvbmx5IHVzZWQgaW4gc3RhbmRhbG9uZSBjb250ZXh0cyB3aGVyZSBtdWx0aS1zdGF0ZW1l
bnQgZXhwYW5zaW9uIHBvc2VzIG5vIHJpc2suDQpOQUNLLg0KDQpUaGFua3MsDQpNaXJpDQo=

