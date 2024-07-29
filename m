Return-Path: <linux-wireless+bounces-10639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303693FC7F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC94B21387
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CB1474CE;
	Mon, 29 Jul 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXbiP8UZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97F80633
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274565; cv=fail; b=IIhy9Pqx5iHdFVpX/RH8CCWx3gnCkOKuYNFtKhH8KVixZzxfPt+JQ9JRKV4RrSUIw8/VsN1P1FrG3DvacNak8MBPyEY07kzB9pZ0LLvLTOzbXTgoCJ+fqV6PsWEJEpwplACha5nzvk37iHbU6kU4FOmOvEF/BDZnusmwPSeWwq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274565; c=relaxed/simple;
	bh=hY7jBeKno6kefoKyBs0HAhpvDIcSxd6Gb7zqJiKe84w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlwEEX/V0t/K2+2QWKcjmO2lJHjQBziWvvyHvkWQvQwz/7ArTVHnC6xOnHYAmT8CUXd8mjXrUDjZ3W4iSFYL/h1kDCRhg9nXuLW4KVg7rwfHf3PWmNhJSirLPGm8QGfIMoP4nf3BAmg1s99FgykSrF2etDb21+IybeQjCH2rGb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXbiP8UZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722274563; x=1753810563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hY7jBeKno6kefoKyBs0HAhpvDIcSxd6Gb7zqJiKe84w=;
  b=ZXbiP8UZSJHOY78mrrVhWH3zR6y8icT3L/n+zIr+QYRngYFeu7VahJ1c
   u4Gxx6vlBpa9LgZYtAB1jb2m3+za58OywUUNxxdbfBJHKSbJeNfAhIInK
   Bphx3aYdE8EUH3lxeN+6fIvenONX8xcAJ0zxReuGkhrBCU7XmTWI8+1iu
   KOrITtr11ibeCnQ8CR77QH4W5A9f5HWhR8Yi6zQw7dVnBnmpAUCouTtKw
   q6Y+GIW2k/lgq65mbWr8yLmMqeDG4oxjorQCnWITGlVgeTG9vQmodwI8d
   vMy8GMvhopxV1DMVZH8ZOMYMZi4OsLrplR6cFI8iI7xhkBC9RCZgiscS4
   A==;
X-CSE-ConnectionGUID: thwnVQNrRSqxNJ6hCaEjSA==
X-CSE-MsgGUID: SOZDVO/sTdqALXN924wnOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23801320"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23801320"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:36:02 -0700
X-CSE-ConnectionGUID: w7+Qdc5DRi69WBalwlxmfQ==
X-CSE-MsgGUID: HwgxWX/TS4SkYAtyNANKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54636310"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 10:36:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 10:36:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 10:36:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 10:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYKj8sQDLgbmhRtN1HkPbFTXQJ0BIVwALrMKTIHD2OhC2c4nHkHWqDL6yoao9+DNYF196Rdayxww+Gi5/XNFmaSv0ZHHUBzHkS/fStUAeg3gORPJv4C2EWvyRNkYf82QG20Fn7UYa/hW9wKCqYsOWgenqXJtVqGeGcVMGRBNAaGHJPL5QWGh42dhWuyJPVBtwkC/9v76JK94xwqtB6queiwnugCpuy7VbFdJtvs0pf814O/IFrQwoiSukba5zyXV6emBFSzbhPcB6k/+4QakC6u9slBVeJestbn/DIkKlFMmCkO7YLNNF2lDflLCliJtMFlNsfrpp/n9z+gv8n/0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY7jBeKno6kefoKyBs0HAhpvDIcSxd6Gb7zqJiKe84w=;
 b=vvZcMOpltBj5KbAoWFQbF4C7FI3pvNKY8G0wzMzX4a+iNCO4MA+mAOSyghv5bFqS2vVGFEZMhRzLGrLWCOlcRg8RKY6mkMIfXY5c+7XAC3E0anHcJZiOVg6O7Wp4tPyY+WSQpTECMvwodWtp9pz12B2Gup6kMXhyjYU1XY0g7jGgYN7W8CZl7u8EDbKnoU4QeeT6OBdXhpcyWHQwgbIdXz1kwPmHE4CZAebmxm3HoFPqTsF/DNKa7Twj4j6yl5jO0rJ9W/e327axS0QG/Bqh1hDzgdnHoMSZQsvkvLl0+u92T50qE889gf9bMELScbcX1tDkXtTYnN3aSntikTKFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:35:55 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:35:55 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "greearb@candelatech.com" <greearb@candelatech.com>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 08/17] wifi: iwlwifi: mvm: set ul_mu_data_disable when
 needed
Thread-Topic: [PATCH 08/17] wifi: iwlwifi: mvm: set ul_mu_data_disable when
 needed
Thread-Index: AQHa4d1L2kcpRchpAUuiG9XbH/eckrIN98sA
Date: Mon, 29 Jul 2024 17:35:55 +0000
Message-ID: <cd7d7553040cf8eb704721712e94767fac47ee6f.camel@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
	 <20240729201718.fef270d2995b.I328237837df30e1cb98764987eaaf8e8993e058c@changeid>
	 <eb5c63dc-8934-50fe-3b08-24db25c80bb3@candelatech.com>
In-Reply-To: <eb5c63dc-8934-50fe-3b08-24db25c80bb3@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|DM4PR11MB6550:EE_
x-ms-office365-filtering-correlation-id: 1a625cc2-1a55-4692-5fbf-08dcaff4e676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlZTeUhETHQ4TVdzU1JzRmc4S2VTQ2JtWk9SdkN1amo0Mk1FSTRnY3VWVlZE?=
 =?utf-8?B?eWdpUFlnQUR6YjgvNlA5TFlMbFpseDRWVmlnZEZML0ZpbFF5SzFIYjRQVjRy?=
 =?utf-8?B?NDlTWXFiK2s5UXpiaEVlOXc5NWlYcTBUMjVKVG9ucXRsYjZPNlRHci9sWHlt?=
 =?utf-8?B?bmNENzc2aTg5TGNwZys1d08ydlJ3TkQ1TUVZbDJveHNtNVd0QkJHM3NaTHJt?=
 =?utf-8?B?SlNKSk00SFhnczRaY21JQUcyb01qV1l5OW1NYjJ6N3NZV0czcnh4MWtlK3lj?=
 =?utf-8?B?YStYNGhlTW9NZHZndjNCcHpLQy9nU3c5L08yUFYxeTdsS3JOVVhBY0l4T0Nj?=
 =?utf-8?B?Z1pCVGxhWjg1Und4WE44aDJBRkZVcDMzblpXNzVZRkhCSDk0T0NxamIzNi9N?=
 =?utf-8?B?RmgwZnJXUjVsZUN0dE1HeWlpRk5GOUpoVWowNWJnYlBORHY5by9kOWJFdUlQ?=
 =?utf-8?B?T0lvU09raytuWFlOcE80WlpVRkdmbU9KakM3dFNXT2pvQXNZczI5c2h1Wk1o?=
 =?utf-8?B?d1ZZNm91NU9OcXhkemhhenprdkNXaWlxUTJNNzBUVmhRMnhQQzBBMGtnd2k1?=
 =?utf-8?B?dTBlcXdFMEdEbzZCcXRSL3VQdEhXVHJRLy94MU5TZ1RUR3d1MEI5WFg3dWhZ?=
 =?utf-8?B?WEZJbzhITkVXdFhQQzJDN3AxaDRxWHdrdkNnczRTSDYyL3NsdE9VT1ZlS1d5?=
 =?utf-8?B?UU1ReTMzUk5NdzJ5aDZjNGI4dUc3UFAxNXREYy9PYVhDSmxBYXovMXcrcml6?=
 =?utf-8?B?OG44QVAzdjNPWCtJUUJrTEJXZkdHQjQ5dGw5S3dtQVRRbEZ6aC9mVWVKem1B?=
 =?utf-8?B?SDdMZWFCcU05SmErb0VLWFBKMjRoOWhSdmFkM05zVUdOR0VhN3plQzFjRTNO?=
 =?utf-8?B?cm0zODBFNE1EZFA0S3QrSDRvVG55VDVqbUxxK1IxUTRJVDBROFdwZ1ZjVWJ2?=
 =?utf-8?B?dXpCVG5LK2hYTXpOWnpZc3lvUDNZVVp0T0FQaytEc0lPTXZRbHRWVXVtUVFk?=
 =?utf-8?B?TjJ0QjhvRjFqNzgxUitxbGxYaEMyZmxpdlBGWnlzZm9vVUd1K2h2SzVDOW40?=
 =?utf-8?B?eFNpSjBnUUhFWm81Z1ZQbmZDT29BQ21FMnpMeXlldHN0WGlMSGI0OTVuanhM?=
 =?utf-8?B?Wmc4ZCtENG8yVW5CZmlVZFcwU3gwVWxUZU1kYy9GOXBVTjZzTUt4emF4ZFFP?=
 =?utf-8?B?cUF1aVJzMVBhSWNFZlJzSzNoUEZWODhHQ3BwWHR1bXRmWjRURUVITytIODRR?=
 =?utf-8?B?RTlLOXNEQ3JUZUozYVdjTVNjK1p0NmJXRXc5bFB6RDFRaDRQaE96SnFGbGY1?=
 =?utf-8?B?eWMvVjgzVWVqUVlLOG5Kc2hLNTNPNFhWcyt6bTlwcTBzVjlubEV1ejl3YlI3?=
 =?utf-8?B?STJna0RvSmo2NzVVdXZkeSthWkVyUUNxSEthRUZjK1FscDBIUEoxTmY5T1VS?=
 =?utf-8?B?Q25YbGpWQUxYaWhEYksvZll4dERtNm9BdVFkeUVwVGJCSHV5ZG95RHE5U3F5?=
 =?utf-8?B?YWNXamNIb0Uyb2g1MlNTS3BhYWRiZ1JDOGdBdWt1WFhsT1dBeDdVN004bXNh?=
 =?utf-8?B?V3daTTNWVUpJQzljT0R2bTNqSHJKbnZLbXRtUENHbndndVJ3dWFzMzFLT0hL?=
 =?utf-8?B?SVBtN3JlNDgrM3FPRmk2UjJxenVzN0EzWWNRNUVwN0FtbmxITzBkU09FQ3o1?=
 =?utf-8?B?Z25xYlA4dDU3dlN4NXFSVlB4aHgydHllZ0JtZGNLRXFOVUl1aHA4UWVWenV5?=
 =?utf-8?B?RFkvT3ZtQXlzUkcvU1VXd0xzMGEwODdoSDNWZC9KQmZhL3pHZFVBUXlIU1h0?=
 =?utf-8?B?NzVVY2oxWDlKbDFYbHZrWjdxOHFyeVZvMWFjREVVV3F1MExSNUI1UkVkY1ZE?=
 =?utf-8?B?ZXNyK2FpekFxMXRxY3lWUDBtUjh4UjQvYnBFQ0tZREZjVUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXpWeEc0S2J3cDE2eEVza1ErUFVmdVB2Mkcwa2tCazg1RmxLdDQvLzRnRklL?=
 =?utf-8?B?SW9STUpObTArNGh0UnFzUmc5RS9QSlhLdytEMXVnaGtSdU9sQmJrQksxMHlH?=
 =?utf-8?B?RWVhOG54Z3F6aUV1b3BNTlJMRFdTR080YmlISWJJVjZFUmY5SmFwdWxsUGlj?=
 =?utf-8?B?V1FwMFdOUVgvcld4a1ZOR2ZvY0drYTRFOFhtbzNMaUM5OWlsNWh0VkVMeUtZ?=
 =?utf-8?B?ZHVkTUxtYis0THhFWFhiN2ZNS3JjRVR2SDFQVjdwRTdHSSsrT2ViMkpaUy9o?=
 =?utf-8?B?UGhmdGpWYWYxdzlVTTg4VEdlUXZtdXEyZ2VwRTNBcXgrckF2TTFlWWx0Y0F5?=
 =?utf-8?B?VlQzbkNPM1VmZFFxR0RKS0Z0UFRuYW54c2twUjZZNFM3Sk5hdzZFZ25TSTJ2?=
 =?utf-8?B?YWNBTGdITFltTVVmUURUcTgvb0pGNW10d2lpM2NBOCtESklsdzhZQUQvZmE4?=
 =?utf-8?B?dWQrOE5uVElXMWJHVTZqMGV4K0FQdmd4alhKS2d6dFcvNWFMekJUc2d5R3ZL?=
 =?utf-8?B?WXA2eHlySU5ZWDhhdWY4OSs0MEZ1dVZtckR1YlZ5dkhweHE1QSs4NFhQNXRl?=
 =?utf-8?B?MlF3TnhoZ2N1Mk1HTWFoa2JTRXE5cDNiWGtacXNqWVd3SC9HL2hKMnVnK1ZR?=
 =?utf-8?B?dUdFYTBJYlZBZ09lYkNJRFExbkdlUnlITjFuNGhJWTV2V3l3ZHp2L1V1MmYy?=
 =?utf-8?B?dGFGZ3prOThKelg3N1lBUXMvVnZrTGUrTXhyQUZOU1RuNzRHai9ub042QytV?=
 =?utf-8?B?cFFQRnphbGNWWVprQThVUHpqMW1hRld5OUIrMkFaUGtCUkl1WmZFMnNlaHF2?=
 =?utf-8?B?QWdhcnVqQkZlSnZDQUZlTzlFYkRjd0xoTHEwYTRkTzVJd0dMV292Smp0R3FL?=
 =?utf-8?B?NjUwOVZnek1menBvVHcrTzU5Sys3VkNjRGNHSnkwVmNtWFJBbm5uOTlrWmRD?=
 =?utf-8?B?TUJBS252bXUxcSt0TlpZaGdPZGF4TjhDOEIyeGExTVFabVlJeXBndnBXMWwv?=
 =?utf-8?B?c2hxN0dnVmpXUzk5ZXNaZndqM0NYUHFMVWdoeEM2NUJqUmprZXp6Tlkxa1pB?=
 =?utf-8?B?OWpJc1MwSXRiWThDMVlIUU5ZdEQ3czZCbndaL3haV0RncUxiYkcvb3BnNy9U?=
 =?utf-8?B?dlFYSzBEcVFSc1dWeDVwOFFGSzMra0xNenpkWVIrdmtjSTA1dVdraXBtbkhB?=
 =?utf-8?B?dTU3WnNjNHVEVU1CT0dFcmRuZTY3WlNMWHdUZSs1UitMb2JNQWlGYnpIUFU4?=
 =?utf-8?B?WjFtTHN3UktWcTRHT0V4cHE3STI0SWd4WC9mWVJ2MlRuamcrTUxFdHFxMFdY?=
 =?utf-8?B?WU4ycGE4QThWcTJRcWFsaXVjeVlGY3gxekxnczRaeDBvQThYMnNGSDFLUG9I?=
 =?utf-8?B?cFR2V2o5OVllY2s0Z001Mk92TTdkdFJrOGI4YWZnUnBXWFozUG0zVnR5RXEw?=
 =?utf-8?B?K0hxTStFaU9tbGY4WW5NS0dPQnJmRENqdnEwYkNnU1Y1TzZ4cDdvc3JsenMv?=
 =?utf-8?B?ME5pcHI2WlVVQ05ZRkN4b283V0RLeS9lNHI0bmplMTA4SkdLRXlqTkRsTlNH?=
 =?utf-8?B?QXlheXU5WmdTZ0dUeFMzTkFCSjB1NDl0WXBTR2hrNFlNTUxwWVY1VXg5SmpY?=
 =?utf-8?B?Zit0RUpYdm9IOWg0dFZFRFZSdUFvVWpVZGIvMTZyay8zNzYxeWhLdGxlSnBX?=
 =?utf-8?B?OXY1bi9ibjJaTGpMd2tscmtJTGJ4Q1lZSlRIbjVFQ215OW1CTGgyZUhGWWZ5?=
 =?utf-8?B?S0lkU0x3c1JNY2xhU3VUdTdKTFEyMlRMKzBrZ200M2dxMER0dGlpU216Zlcv?=
 =?utf-8?B?Wkl5ZXhIRzJUSys2RzhPNzY1ZmJPTHREZzhNM0VvVE1ldnAzQ09QRk9Dbk9k?=
 =?utf-8?B?QjV1U0RUM24rMTBaamVPM2dtSGc2emxtVW8vK0FuM013c2c0bVZzdTd5QWFL?=
 =?utf-8?B?d0pUZ2srcitobVBPOTRncmJjdENNQ1VFRE9nWWZPRFlZRFVLbnM2VkI3bVFu?=
 =?utf-8?B?Vm9ZenN0Tzd0d2kxampTSktvL3U3NHdod0xhU1BucGs0eGdtR1VOWDdtbkdp?=
 =?utf-8?B?aWpFMnNrZXo3WkdaR0NiVGJIZHFYemN3RVBDaEhaV0JlQUdlOE9sN3lvcTVl?=
 =?utf-8?B?d3RxRUZWUFhqem9mYUl3K0NuWS9mUzhGTi8wc280TUR5ZHhLTVorVWhoeGN5?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E35E3F5B04FC2D45BDDD08997B506A85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a625cc2-1a55-4692-5fbf-08dcaff4e676
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 17:35:55.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Efnqya+nFqpFSMbKN9DP0H5iJYLNe+zYG2/xG7kbRsesLtFpGCBhiBIPnH1ZDcuJGugP9RjExUuMNNo3oCo0v1qVOxSn2auMtcEDO210X8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com

SGkgQmVuLA0KDQpPbiBNb24sIDIwMjQtMDctMjkgYXQgMTA6MzEgLTA3MDAsIEJlbiBHcmVlYXIg
d3JvdGU6DQo+IE9uIDcvMjkvMjQgMTA6MjAsIE1pcmkgS29yZW5ibGl0IHdyb3RlOg0KPiA+IEZy
b206IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+ID4g
DQo+ID4gVGhlIGZpcm13YXJlIG5lZWRzIHRvIGtub3cgd2hhdCB3ZSBoYWQgaW4gdGhlIEhFIENB
UCwgcHJvcGFnYXRlIHRoYXQNCj4gPiBzZXR0aW5nIHRvIHRoZSBmaXJtd2FyZSB0aHJvdWdoIHRo
ZSBMSU5LIGNvbW1hbmQuDQo+IA0KPiBIZWxsbyBFbW1hbnVlbCwNCj4gDQo+IERvZXMgdGhpcyBo
YXBwZW4gdG8gZml4IGEgZmlybXdhcmUgY3Jhc2g/wqAgSSBoaXQgYSBGVyBjcmFzaCB3aGVuIGRv
aW5nDQo+IGJlMjAwIHVwbG9hZCB0ZXN0IHRvIGFuIG10azc5OTYgdGVzdGJlZCBBUCwgYW5kIHBv
c3NpYmx5IGl0IHdvdWxkDQo+IHRyaWdnZXIgdGhpcy4uLg0KPiANCg0KV2hpbGUgSSBhbHdheXMg
cmVjb21tZW5kIHRvIHVzZSBvdXIgbGF0ZXN0IGNvZGUsIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGNv
dWxkIGZpeCBhIGZpcm13YXJlIGNyYXNoLA0KZXNwZWNpYWxseSBzaW5jZSB0aGUgZmlybXdhcmUg
ZG9lc24ndCBzdXBwb3J0IHRoaXMgeWV0LiBUaGUgQVBJIGlzIGRlY2xhcmVkLCBidXQgdGhlIGlt
cGxlbWVudGF0aW9uDQppcyBub3QgaW4gcGxhY2UgeWV0Lg0K

