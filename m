Return-Path: <linux-wireless+bounces-20257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1ADA5E471
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4875D3B0969
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129B24BBEF;
	Wed, 12 Mar 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+kgoMW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844B1E5706;
	Wed, 12 Mar 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807935; cv=fail; b=QUbKkwGwpbLXxzvRiViNyJ6JzVY53yVL0mbjfTOWZPsO5r36qekbQV1iPwyzH/eagp6bSxHLZA3Qdo15anLMTseED5KHDy9OOurbgTX4Ql+T6ugnB5BFY0UlN3J7ygoW/5SVYTQASUuaJfklaEzdvKHVUvoB06mJDxbxIVbKQBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807935; c=relaxed/simple;
	bh=tIrYdEQGJi55WTeYkahl4X3A6kmdxArTvaMRYDjJzec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jtH372DlyfGjT5tUL9zO3uCfJlt/AXdHNS+pDp2q6LOXl9TXWB29fInEX5cIn/CsKwghnEbfo+TitT37K64tMcB50MJXKLbTwsFYXaiIS/D+hsh+tXtyFqIZLYhvVE2yuhkbe+e335GbGQdPlNk76WmrfjahBlkOXbF/nb0Jsag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+kgoMW2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741807933; x=1773343933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tIrYdEQGJi55WTeYkahl4X3A6kmdxArTvaMRYDjJzec=;
  b=M+kgoMW2+PH0AVNAfeV/YEPcz3pPygfU6XeT3aORR8PMaMRWALd5G9B5
   jL6mTlFo/eU795L1vNBU8PBevMlXXbsyHgS7/HzMcspZFbIDn8akMw1tH
   2+enZJ/DOabMSiCpfe6vFQbdlN/UoFBF6t66niM+k+p7V1JRZi8iZUxkO
   ncPpIJXPQM7dTveX/rzO9DGGha9eLlcWx9g7+XwdwXyGPVNqcoKfGAN9e
   rVPQha4cZw5i9MU6wESX6LMHh9iX2nxk4T8WG0s8cowEbPyLge9mzOKBf
   m5UnIbu4CzFM/kZzOa75B7XFMZDECxCR6mVlUf2MrWFYGlTd74SqkP91a
   g==;
X-CSE-ConnectionGUID: xLKaRoFrQvW+2ictE1ATSg==
X-CSE-MsgGUID: uE010HySSqKhz88imw2Y1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30491550"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30491550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:32:12 -0700
X-CSE-ConnectionGUID: 8Snmio/vRh2bALWVjzxqow==
X-CSE-MsgGUID: ZeYoaVv4RfufAxVEaVLJeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151687079"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:32:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 12:32:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 12:32:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 12:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWx7qajUzF/Qhn0Y+7c0u2iLFhUomULgi3n6ZA9UdS3Pnn0zffV4PFvp6V3el2bKLFosZvPqnDWquBoTCk16a/zClpgZu+dVzl/k5fRh9vEFV5fU6d6VAiJFdsQsPB2LDB8IJM7wJ7TdJ96CpvNr4Dhpk7uurqc/syE1vg+uql6h7yEGr9pQ6JXzcaaD5Ld5pCgSp62sdy9DEM5YpzT1Z/Qf8KpAXc7GtdsDt057Bjek11MIq5QRlxaKwgHbOlDbPkoznC868Fb8/yoTvFyHLPlgw86o7tyRKB4KU+RslRzDSKpVAjyWeWzqOa6VH4VezGWp8/Gxr0q/U5W/21FD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIrYdEQGJi55WTeYkahl4X3A6kmdxArTvaMRYDjJzec=;
 b=GmNvzIcymwVBJ2ZM2Qy9Q+0e+rGaFTXo0pvUhm8dtjxmrBSKMQV9+UzX6AdSYcfpHzpO38XQ/qsCmbbSR4Br7IoWKm1BKMC65u0Uq6Jx9p5IY1ucVsuP9Bw6PikDsKlU8jvJm3KIed34QuZ8bTHd7ZWpiR2tTyaI3WEtKRU+bmooGhLjFgXtkdHpHcJIJpmHUBuBWbLY5R0uXGhwNFAU5jJNZm+S8iK0TCkw0q5NLOvxbHQJN6jGSu2VB8L080ARjwzZzj4Ikb7ntdIkbkAVf9vJnUFVn4zH/IopL7qgCYsAVN+SSIpyOsi11ONNTQlgzs0tJW35i9Ynna0+K9FkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CY8PR11MB7314.namprd11.prod.outlook.com (2603:10b6:930:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 19:32:09 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:32:09 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Stern, Avraham"
	<avraham.stern@intel.com>, "Gabay, Daniel" <daniel.gabay@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Berg, Johannes" <johannes.berg@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>
Subject: RE: [PATCH] wifi: iwlwifi: Fix uninitialized variable with __free()
Thread-Topic: [PATCH] wifi: iwlwifi: Fix uninitialized variable with __free()
Thread-Index: AQHbk2VmSPGCRK6/mkOkdVpQzZI997Nv4vgQ
Date: Wed, 12 Mar 2025 19:32:09 +0000
Message-ID: <MW5PR11MB5810329D2D44A188239D3093A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
 <1b32cd5b-aa46-4a23-bd21-908196c4bab3@web.de>
In-Reply-To: <1b32cd5b-aa46-4a23-bd21-908196c4bab3@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|CY8PR11MB7314:EE_
x-ms-office365-filtering-correlation-id: 98d5ab2b-e4f2-44b3-319c-08dd619c94b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTRYVXpWNS9mZy9HeWxyUXVXVEcxZk9oeW5DS2hLWnYwaFRMa0xjRnlxOTFa?=
 =?utf-8?B?OTJxTUFNSmdQUTJBdFI0MzNUeVIwMWFvZFUvcjhKM0s5ZjF2Smg5YkE1Vnky?=
 =?utf-8?B?WDRpbVZ6TmtSVWNwbVdtOEZBNEs0d2E0cEZjQXRnZDF5NUdrSXc1V1ArWlRp?=
 =?utf-8?B?NDNsL0V0VkdCUHA3c2JzSFdUVUFSTlY3RGhWeCt2VW9qQTdabHkxdndXanB3?=
 =?utf-8?B?VGVIa0JZM05PK3IxSXA4cjU5QVB4THJuQ0c3cWF5UWprSS85SnFob0M1eEVm?=
 =?utf-8?B?US8zNWFJOWRPN29PNExhRWVYcndhaFlJd1ZFTUhybXZ6djhLUEowQ3FJbU5Z?=
 =?utf-8?B?VkphNTVTcjd0cVR1T3pGSEIvV1VnZGZuY1FrMnlJSkZUczNCbklRNnBuNnpW?=
 =?utf-8?B?RlQ4UmxOWXcvT29Ea2dPcTdxM2F5S002c2NQRmFjUVZjc2YxYjN2RUYvMHY5?=
 =?utf-8?B?SEh2WDFXb2ozNlJ0REdhTnM2YmtPaUZmWG8vaFpYMnVMeVBzeUhDQkIvcmpV?=
 =?utf-8?B?L0Y1Ylkyc0xxc1dPT1dUbEROMU9EL05pc3k3R0JSSmU0VTdsTUFub3h5L1JN?=
 =?utf-8?B?RTVpdlVJTHhkcDVvaXhtK2NPWVRzT3JMMGphM1FDQlM3L3kvVjVDekxqUmJx?=
 =?utf-8?B?VFdHcmZYQ3czOHlBK1lELzVoQUtYRlJQR0I1YmNUSlNFbFY0a241dEp2M21Q?=
 =?utf-8?B?QngvcVFpS01jR1hTc25oRlBqL0lxQnJ3M0VxTGpNSUdHRzdDMVdaUjZ4WHdD?=
 =?utf-8?B?aGk1UUhZR2QyaW5kUXdCMldQL2RUdW5uTVl6TnZ2V2RQUE96RnphV245WFVJ?=
 =?utf-8?B?aGxGRS9vbUhxWHdmbnJPQVUxaUNYcnpXQmhXTzlhQ0NpRVpBaU9iNzNHd1JK?=
 =?utf-8?B?UGVVNjZaaDlUNVQ1a0d6MzJBemVqbkMzM2VVazhhdlBKTkNIRXNrbGR2WGFj?=
 =?utf-8?B?YjlJS29SMFkzVlBkTU1oUmJjdldWNU1MelBhbXhjUDZkdmxXNlhvSkMzVTBU?=
 =?utf-8?B?TFF5WXRZTXdnbC83b0FjbDE1ek0rT2VwaVJEZWpLaDlVbGdEWDJvZW1jWVBk?=
 =?utf-8?B?eWFBMWw1ejBYQW5YT1FoSnJVakM0T20zdG1TVXhjNmNrTXh2MFNSWHZtQnU3?=
 =?utf-8?B?U3ZqSGZVMG9PTjBSYTRnSG9oZ3BkNzNranJDWjFoVkU4dVVWNi9TSStuUTRT?=
 =?utf-8?B?cEdML3Q2dFBDVTFkY3BiWkM0VFNrT2VNL0hRNjZZenFERXRDTEN0cVIzeGpm?=
 =?utf-8?B?UUR3NVVRL1lLa1FNallEb256QmZMYU5EWS9vNkhwYlJIdmwrTVpGUytEYXF1?=
 =?utf-8?B?M3p6ZUlXSTlLdUtsdzJhdHMwZmFnczNuSVdZTU1lNGNHcnpNYjZCcFQ4WlBl?=
 =?utf-8?B?MmVjNnlmNGZQbGQrck5SWS9qRWVXNWtmejVRclBBREdIdTBXYWhBRkJ3WlVm?=
 =?utf-8?B?c3hXUVFiaWpEVG9DZUM3VDYrYnlmaXFTTUd1UDNwanNXaXF1blNiSGNGSjMv?=
 =?utf-8?B?VU5FcmhEWGhhTnVpQzJ5dnRSSVk3SEFTVzRIb1Zya0s2djVveXVkM1VIUGwz?=
 =?utf-8?B?WU43VncxaDBjVHpyOVhYQWpDLzZKK0l6NGZDRmx0YWlXQlJVREg3Z1YxYVd0?=
 =?utf-8?B?eTQyQ3hQYXM5WVhFSUxhWnl3R1BJUUxaOVFCRlZ4STJwSWlwTXZHOUdEdkZO?=
 =?utf-8?B?YlJaaUJrRGNneGw3THBhbGFtZlU1YlRRVE9hOXB2Nm1GVzdYaDFVVTFuU0Fl?=
 =?utf-8?B?M3RFMVlCa2E1UjRubHlQcEk4enl5ODQyR0VaMXZzZXFTendlOHh2QmpGSWcx?=
 =?utf-8?B?czNZSzR4VE9kc3d6NUNSZUl4ZmovYzhtTHo2MS8zM000NEVMOGxuWXBtTkEv?=
 =?utf-8?B?L3JEbFFnRmNhaVBjN25sZm1tbkEvZ3dOTy84ZjJKMDI4WGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkkrMmZtVWpuSncyRlVRSk9IZUpRcTFpRCs4ZE9mVFFOcG9iK2ZBdjFNUjg0?=
 =?utf-8?B?Y0lqMDRFWjFzaTNHVElxeUdYczNJZ0VJcXVmbGNIRXhaajZjVXkrbU8wNEhi?=
 =?utf-8?B?dVp2TjZKK3d0QWVYbnNOaTVhOWJTV0NzZkV0bW5Xdmo1cTUvTFJXMTBOUUZW?=
 =?utf-8?B?UzFSODQ5RER0WEhVa2tmWWM5NXB2eVVZSWlRWG9DZWthNVA4eHQyTVBuV0xu?=
 =?utf-8?B?dzVHRzlKUXBNRXMrR0JwbEE4Vnl6bWV6ZHRZN1EzV1FoeCt6RjdlaFV4eHYw?=
 =?utf-8?B?MUdWRnhNRXoxOVJhejdvd0s2amlKdmRIWnBHVEpGQU9QSzlYMjBqY0lOWEVJ?=
 =?utf-8?B?L1k3Mjh1RTZGcnMyc0lmZnJIeUNwTUdWVWRtNlkxSEhQencvTXpRUXhyNEJt?=
 =?utf-8?B?LzA5R0EyNkFpTmpzOU1TMm1KMlRYK2I5ZS80eFp0Zk1OTDlJVERYdGdVejI1?=
 =?utf-8?B?WHZRTTFXbm5XaEpHa3JGemtYbHJsVFlPbTJJZktUVFVsYWlLaWdtRDFwRzdT?=
 =?utf-8?B?dWJHZTJSOEhCc0dPekIwbEIzakZZU1gvcGJnTFRZRTJnYmNOK1o2TUZaUnlm?=
 =?utf-8?B?VC9jTXJEalhTRlk1ODk0TlNTVVdWbU5iNTBCV0ozdW9xSVh1VGxUQ1NGQVMz?=
 =?utf-8?B?Y0ZRb3lkSFZLRk1iYnFjeFhzTEYycDQ2VWlwQnF1djQveUFwd0EzVDBsdmVn?=
 =?utf-8?B?OXFzRzNNY0pQeUhOZC95U2VNT2JWck1wY2dvb2tNWkprL25iNmliYWpTL3lv?=
 =?utf-8?B?MFFITlNXVlVjc2pqVlYzdld2LzgzWmlSUWVHWFNPdEhyOVhDbzV6Yy9PQlNP?=
 =?utf-8?B?WEl5alNUL3lzWU1BcXhXZEVMRzlHRmRrWFlFQnJ5bEdXcEZFb2pPTFRTVFRy?=
 =?utf-8?B?VmZrNEtHaWhBV2Zaay9JYmhYbXlqa1h0aWRuMG51OWpDOTBTOFdjb25iV3FO?=
 =?utf-8?B?NklJV08wMzhDRjBWNUM2SXBmMEJnZUE2ekhid0p3V2s0Q1hIOFZhVTQwVFJ3?=
 =?utf-8?B?bWJsclg3cUJzOHhqaXhqYmY5ZnRuR3MxYU8rTituZnhiYUwrcklEUk41dnBB?=
 =?utf-8?B?MDdBQk50UFdoMG5LNUhFMTNleXZ2TzVkMHZFelIxRFBGOGhYaCtpekU2N1hm?=
 =?utf-8?B?MVBraXRUL2t2dEN4NFBmT1ltNFFsaGNiQWU0NHA5dXFuRzVyWk8zNmR0MjZF?=
 =?utf-8?B?WkRISFZGbW0zYVBmSklLRzFlVTRMc0VoWmFCZGU5TzhtNW9LanhzV29HWTFa?=
 =?utf-8?B?Ym5VTmZYOHhqTE9IemthT29xaEZhRzQ2aFZjMmZHYmRxbUM5ck1rWnRaS3di?=
 =?utf-8?B?aW42L1o1eTlPWmVVNnY0Z0NjVnIzdVRtVFRuV0wzaFFqUE9xTkc3ZytVRFJB?=
 =?utf-8?B?MWlVZS9PY3ZSeThvczN0S1g5OU4xa3NHWnkzVkpma0VZb0xqVzg4cjdaKzhk?=
 =?utf-8?B?RElCd1lrTkJncXREam93cnI1a0trdTdCN2V2M3A1TkhwMWNGVGd1MkxQbUJu?=
 =?utf-8?B?TzM5TzY4dDQ3TWg4MjVPa0dYbkdpWnFSS0RmeUJDU3VUSkRBd0hiZk1CYTA2?=
 =?utf-8?B?SXRTRlZSQUFseDdMN1hJTXgvRG1JRnRacVRFUnF3VnhjTk5hSXhNUVI5anhs?=
 =?utf-8?B?NU1QbWF4K1FxZzFWOERZelFJczhPbVd4OW9yNFNMVVFtejFaK1U3NU9XaUVs?=
 =?utf-8?B?ZU8wbnRIQTlDRFZ6NDYxMWQ5bjJJdXFXTUd2NzVXbWNocWxVUUk4b2hDS0NP?=
 =?utf-8?B?a2pkUGEzMC9NeERpOGM1dkI2dGUvWEExeVNZSG9aeGtCU1BKczRWdGZFSmpz?=
 =?utf-8?B?ckVNVkVlbHpsMFRvbU9ZTlB2NE9rejNrbjNkZGhDbTNTcDV6VHZldHpQZTRp?=
 =?utf-8?B?czZVcnlFekY4ckZNcng2Snk3QndsNWlNMVVDZkR5eE1YT1ZVaHVrUnlqRkpQ?=
 =?utf-8?B?SjVCVUxtWThKT05waU1KRnlzNERkVFpWTFd0YjNLQ01nb0NzUXBMK2VWS01C?=
 =?utf-8?B?bWNNdHoxUVZNNE95aC9nbnJQMkNhd05NTGNFWk9KQ2VkVGE4UFltYUo2UnVh?=
 =?utf-8?B?ZmJLNGxEaWgzellHK3E2cVRHaTRwY0p3U0Vqa21Bb0lwOGMzK2p0Z0lLZ3pl?=
 =?utf-8?B?WkV0RnV5UUdnM0U0VFZER2JUUEFkaXJrbzJoWTdOTHhaSkZvdmtyaUN4Y0FD?=
 =?utf-8?Q?CI2zPAkPIBYscuxwQrAZ93E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d5ab2b-e4f2-44b3-319c-08dd619c94b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 19:32:09.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fC2NHWMY261iw0P5xTx0Apntoy7j3htSM+XrOJJQHn/hEQ9h0PEyEeox8XQIWHyQ5WVUdRKLYK3QsIAhyOyVpOpM5c2HMgh9qcwpGKSFifAtKFh5CQiE4Y00Pzplqd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7314
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEVsZnJpbmcg
PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCAxMiBNYXJjaCAyMDI1
IDE3OjQyDQo+IFRvOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+OyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2Vy
Lmtlcm5lbC5vcmc7IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBBbmph
bmV5dWx1LCBQYWdhZGFsYSBZZXN1IDxwYWdhZGFsYS55ZXN1LmFuamFuZXl1bHVAaW50ZWwuY29t
PjsgU3Rlcm4sDQo+IEF2cmFoYW0gPGF2cmFoYW0uc3Rlcm5AaW50ZWwuY29tPjsgR2FiYXksIERh
bmllbCA8ZGFuaWVsLmdhYmF5QGludGVsLmNvbT47DQo+IEdydW1iYWNoLCBFbW1hbnVlbCA8ZW1t
YW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPjsgSmVmZiBKb2huc29uDQo+IDxqZWZmLmpvaG5zb25A
b3NzLnF1YWxjb21tLmNvbT47IEJlcmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNv
bT47DQo+IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRA
aW50ZWwuY29tPjsgQmVuIFNoaW1vbCwNCj4gWWVkaWR5YSA8eWVkaWR5YS5iZW4uc2hpbW9sQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogRml4IHVuaW5p
dGlhbGl6ZWQgdmFyaWFibGUgd2l0aCBfX2ZyZWUoKQ0KPiANCj4g4oCmDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvZGVidWdmcy5jDQo+ID4gQEAgLTU1
Niw4ICs1NTYsOCBAQCBpd2xfZGJnZnNfdmlmX3R3dF9zZXR1cF93cml0ZShzdHJ1Y3QgaXdsX21s
ZCAqbWxkLA0KPiBjaGFyICpidWYsIHNpemVfdCBjb3VudCwNCj4gPiAgCX07DQo+ID4gIAlzdHJ1
Y3QgaWVlZTgwMjExX3ZpZiAqdmlmID0gZGF0YTsNCj4gPiAgCXN0cnVjdCBpd2xfbWxkX3ZpZiAq
bWxkX3ZpZiA9IGl3bF9tbGRfdmlmX2Zyb21fbWFjODAyMTEodmlmKTsNCj4gPiArCXN0cnVjdCBp
d2xfZGhjX2NtZCAqY21kIF9fZnJlZShrZnJlZSkgPSBOVUxMOw0KPiA+ICAJc3RydWN0IGl3bF9k
aGNfdHd0X29wZXJhdGlvbiAqZGhjX3R3dF9jbWQ7DQo+ID4gLQlzdHJ1Y3QgaXdsX2RoY19jbWQg
KmNtZCBfX2ZyZWUoa2ZyZWUpOw0KPiDigKYNCj4gDQo+IENhbiBpdCBiZSByZWNvbW1lbmRlZCB0
byByZWR1Y2UgdGhlIHNjb3BlIGZvciB0aGUgYWZmZWN0ZWQgbG9jYWwgdmFyaWFibGUNCj4gaW5z
dGVhZD8NCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQtcmM2L3NvdXJj
ZS9pbmNsdWRlL2xpbnV4L2NsZWFudXAuaCNMMTI5LQ0KPiBMMTMzDQoNCkFzIHNhaWQgaW4gcmVw
bHkgdG8gSmVmZidzIHJldmlldyAtDQpUaGlzIGlzIHJlY29tbWVuZGVkIGlmIHlvdSBoYXZlIG11
bHRpcGxlIF9fa2ZyZWUgdmFyaWFibGVzIChhbmQgdGhlIG9yZGVyIG9mIGZyZWVpbmcgbWF0dGVy
cykNCk9yIGlmIHRoZXJlIGlzIGEgZ3VhcmQoKSBsYXRlciBpbiB0aGUgZnVuY3Rpb24uDQpUaGlz
IGZ1bmN0aW9uIGlzIG5vdCB0aGUgY2FzZSBhbmQgd2lsbCBwcm9iYWJseSBuZXZlciBiZSBzaW5j
ZSB0aGUgZW50aXJlIGZ1bmN0aW9uIGlzIHJ1bm5pbmcgdW5kZXIgdGhlIHJlbGV2YW50IGxvY2su
DQoNCk1pcmkNCg==

