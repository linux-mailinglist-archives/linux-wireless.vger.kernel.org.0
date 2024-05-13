Return-Path: <linux-wireless+bounces-7577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768EA8C3C0D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 09:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0492B210F1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFF146A88;
	Mon, 13 May 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E37fv4T6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2C146A9D
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585208; cv=fail; b=KUwb7gxGfHKzRDGRsy+pmVoyrbCQ+mPShqJ2ipCkCrRlHlF0W5q4hDuvc1OyMGes07AFGMCrioxODjUWITIVCGgnx4W06VN8NK5So9BST8yQSkHjZVnmLVZaWxpzCYNWGK4Va8Rfw8WLEg2hFKSNf86NXYcudgHbJRFeVjW8/ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585208; c=relaxed/simple;
	bh=wJn0nyA5scvLaJy1/z6rjJUYvV2O5v6NIY4XaA8o/rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZenf0WRji/kfz63oCKp9Mu56BsoXBXdv54XxeJ9Qp7l0utBoQ5EjHGv0orAHDUHjoqBg4YcB8uiLqn2Jb5n+jhRIbW2RJHPx9+BJuVozXhg0NVvQtCYKtWRIOY5W7CmiD8xHOwgv44er44guNRdNSY/NK2BbM4/j2hD8Zox51g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E37fv4T6; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715585207; x=1747121207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJn0nyA5scvLaJy1/z6rjJUYvV2O5v6NIY4XaA8o/rc=;
  b=E37fv4T6BEaCoBinQ7mcXyKy17ilM22c2y2InzNEF6Ea7+WE0n56OaJ1
   OahLUj5cZWBbmRJTo0ey+s4dSaqLzl+Jt+if8htiFP2eFt7SFaVHH4tjb
   ePcRfSHGLIH7+et02Bavpn6IalQs211qfp/xi+C6SQROQ68xf+haEItoL
   jO/ctpPbdZFrpbvNILa7xgMKD48UwREFZDIcWxlEp41XGL+J8uJZbkASZ
   QYM9IV82X0+sW7OdjgFlB/A1f23yCJ6YnW5ko15m3gJVPjrmPcKmU4CDJ
   rLAsHztm4l4YHTmWvepmrImiq7CT3VFccSTjwim/aH0DAUIgG+TH8GqX3
   A==;
X-CSE-ConnectionGUID: //QBJD8ARkmc8klWgjkdhQ==
X-CSE-MsgGUID: BqP8cRIOQwWdl6NnIZs/cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29019838"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="29019838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 00:26:43 -0700
X-CSE-ConnectionGUID: k0p+LICZTmSxhwQZTQSieg==
X-CSE-MsgGUID: lnorq7mJQQ2PfNH22noP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="34943342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 00:26:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 00:26:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 00:26:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 00:26:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 00:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkxKcZ3I9TsoL/ESrESEHrf5pKhJv4oHlefdiOKIwfXUTko6F5ck0TubOx6zWWOY7ZSb8hVhiLZXI8zGPFwui2lCtWwAI1ysWMqbZI89+ujgPLJKdjHK5ATGJdMXfXY4AOIlIRH8F4Oixe5a9TvIn49zxoQP0XsHGueFS3OLHm1U1FtAlsPe4/NJfv5XYOOqEc3AvYAoDTYCmSGXYv/89HFNA6C5KYFgdQJ1Jie3crp7wAcv837gJJcu+b4woczTlgqlvDo7WHbOhQ6JTIwpYya2ZqFM/8l1tjn8Aq+NgHLJxU2HdzyUoMdvB4SvmoIQel0yCnxx70QzLjh7qR4hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJn0nyA5scvLaJy1/z6rjJUYvV2O5v6NIY4XaA8o/rc=;
 b=B1vQZxQ0wMSjwBS0xZuXNqLvNa8Kdi00pJz9A0s9vZgcRHPXxFlkyHsxgedDVthkYMLZ6bK264xlCRG+WOo2aBf+l9swuyllwLu3M3phxa0nxRo87EYTKWa9OIpv6UPHCrWICMvjyVsw4fgG2OqMCJiTc2APNuX37bxea5hW75ITP4nhyoyfujq6pH+jS5UkYuU84lmf4tnfbzQ7O6T8gJxh5+K1L4HLs3O7n9oyRj0/xPrcCiyUbo0FqAjfHnDLi54iSizkhpa01C1ZlL9e1taQ4QfJdrPpL5QLqQMU5sJG13pafzD+RbYtoPXf7SwG6ZYMw2gpKZqgWDoyZv6Vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:26:39 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:26:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marek Vasut <marex@denx.de>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Abhishek Naik <abhishek.naik@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, Gregory Greenman <gregory.greenman@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] iwlwifi: mvm: Ignore NVM write status 0x1000
Thread-Topic: [PATCH] iwlwifi: mvm: Ignore NVM write status 0x1000
Thread-Index: AQHapJ1CJZuGcUpewEGTkQGS6bBK4bGUv3+Q
Date: Mon, 13 May 2024 07:26:39 +0000
Message-ID: <MW5PR11MB5810BC2C41C580237BAD3958A3E22@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240512184932.25831-1-marex@denx.de>
In-Reply-To: <20240512184932.25831-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: 1af525d1-a78a-4082-2a09-08dc731e077f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eVFyeDdpNjQ2SlF6VXVpNkNoN1lHbUZoS1FXVUFLSDVOV1h1UHhqYnF0ZDFG?=
 =?utf-8?B?alR6T0hCb1J4Ky91OFJ0M0VHUktrV0dzWTVSWVZ4OEVGN1dWRXkwYUczak5m?=
 =?utf-8?B?YWE5dDFZRmpRak5JVy9YNVFweGUyL2o3MEFxYllMcDE2ZmFhRnkzWFhVUExs?=
 =?utf-8?B?SFhQUXBFcHlVeFFqS2hvaHNiL3RiNlBWN3FNaTRxN2E4RE1ZUDBjUVp6WWJj?=
 =?utf-8?B?S1MwOWtkNXpRMWtPSXhGWmN0cGhUME1XQjNiaTJiNjFCT29VdkNVbHN4blRV?=
 =?utf-8?B?TjJNZU52SS9MWXRsb1dSTWY4cWpKMHZvV0hzQnVIOUVncGExb0h5M1VtRldK?=
 =?utf-8?B?WEZkR3EzWWl5Wm9zdFVPeURkcHAxWVRDYVVhL2pOOGpDNXh1dFRrS2p4NHgy?=
 =?utf-8?B?eEpDZW9CQ0lKU1hQNGRVdnlRZmNkaU5rNEQzaGNYdEx2L1Q5SzBZTEJnS0FF?=
 =?utf-8?B?NlpzVXFaOXl1NVFXOWo2YUVPenVXVDdlTVhiaVdoNUhuV3RudHE2WDBzbW9K?=
 =?utf-8?B?NmZMZFNpOVMxU2kyYVZMMm5pUElFRmppRFdqZGl2MkpITnNpWUNHb01nUjRU?=
 =?utf-8?B?MkRFdTJvaU1zcjg5UHlMNGV4U0wzdFFmYnpYTG5IV01BdmZzbVBsaXVSY3pn?=
 =?utf-8?B?b2EzeUpjYWkxbTdZQjRkeVNZNjdhUEREeTBGY0Vsak51Zmw5Vnlpdm4yRzdz?=
 =?utf-8?B?a3VmeEJTQ3hVYWYzcSt3RVZRcUVYREJEbmhxNUVTY3FYOWJQbUpGTkxDNHRW?=
 =?utf-8?B?bXhaOTd5LzNDRk54VHBZRjZhZnA5cjFjZmxnZVRyTDk5QTdPNzFTaG9IWHM4?=
 =?utf-8?B?QlRVdTlFNWk3NUxSVWorZDZ2VnlYakNkSzNzc2FDR0hnM3Z3dlZ2cjRleEJB?=
 =?utf-8?B?NTltblhLQzh6WDJRVEhCRDZCZUJWN1lsMFRyYitKQk43bWhnRmRHb2YrR2lC?=
 =?utf-8?B?YmpVSWZSZy9TOUJWa1ZCazg1alpzYWFmNnIxcncrU3ozSU9TV1JhRVE1cTRs?=
 =?utf-8?B?RTIxemtIOHpVdHdVVEVQTi9lRDdpWENEVVRjY0hHazd4aHE4ZWNvL2RJVjNo?=
 =?utf-8?B?NWh2SUVGa1l6V3IrSVN1cVRVUUh0UGxMUUhjS2crNHRHVC9LcFlCMVJIWXBI?=
 =?utf-8?B?bEdsMXJYaHgzWXRLS2pscUc4Vy93TnNIcDZ2NEFZbmZ2aXoyQUI4bzM4RXNZ?=
 =?utf-8?B?VFNwcGFmTmRQdGpGTnQvSEF1cjVEU3RLdUo4cDFseG1DTWMraEJqMHhVWVIv?=
 =?utf-8?B?cGdyQ3FuMzI4azdqaGJ2RjFVaW5OemVoNWdweWRNZjUxRWtScmtLc0ZiT3N6?=
 =?utf-8?B?S2M5ZWdncXc4bGtEa0dxZk9KUDRJL2RRdG5NckdwYmZ2aWhnMzMxMXZSdlZX?=
 =?utf-8?B?M29mU2k3UkJnWFc0V2NPZFdmZ25EMFhFelptcTJPSStLdXlSR2hYN3FhTk1O?=
 =?utf-8?B?alRid1JSQkFkcFYzeVJRbVhZWnp2dUllVU43OHBHaXlQck1jRlY1NGNESTRw?=
 =?utf-8?B?VjVGcVpjZHgvMlA4aXk5WE9qdUZYamNLVGRzeGllNEtWMGEyQVJHaTYwYU01?=
 =?utf-8?B?d0FQUExaOTdBT0EzcHM2b3QrRExiRHMvcERHYkJJS2I0c3N3cXdTVlFEd0Ju?=
 =?utf-8?B?RGhvOENFcHpUYVl6ODlTcVdkUUZzSmNqSnV3T3BGa255TlZ3d3c2SzhzRDlW?=
 =?utf-8?B?QkJUK2J4NW9YQ0ZPSUsvUXJGR3R1V29kRENSR2NiMXh4MW40UTFvaHQ4Mi83?=
 =?utf-8?B?MlV0UW51NDdWVERaT0N3OTN6UzNWZFpJdE45MktDeStJQkxzNCt3UlZRWkMy?=
 =?utf-8?B?emRuSHR5YkVIVEFaS3IvQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjViYjNBVVNRcWU5NFFsdTdkZXJZRWgwcjdBeUF1R2hscWtUcEJrWFBiUHdi?=
 =?utf-8?B?VCt0V2ZUcHdOcXZuTVpudkJHMWg3cUsvaGFvY0UzVmhLZXc5Tkd5Z1lMYkww?=
 =?utf-8?B?R0JqcXMyU21XRjVXa3l6bkplZmVqdzA1b2M1bFgyenY0SUljK3FidnRSOHpV?=
 =?utf-8?B?SDRWQ3EyeHo2eXRGRTFQQW5SMDFlRDl4RjdVeng4dnhMdWNqWGtBeVZMYVVE?=
 =?utf-8?B?K3o5ZjR4RmJCU0FwKzR5TEhhZEsxdWRIUFhyTDlpS0FpY3dGNXpraW9CVDRF?=
 =?utf-8?B?aVptclg0QXNaNlVBazlzakJMVXBnUHcxeVQxc3FWQUdJQXgzTlZ3Rko3MnBF?=
 =?utf-8?B?ZjdvK1B5ZUw3bWFkcUlNYXdMaDJIYi8vN2FMNXdQK2FXUG9RWHhsengxMUhh?=
 =?utf-8?B?ZUdlNWhNZkdTblZ6bzBYRXAyaUd6Yi8xUTJRTWtjaTA0ZC9TVzNmd2xsZlRO?=
 =?utf-8?B?RERTZDRVbjlJWFRwaDUwd0ZjZVZCUUhjVTk1V2ZUczY3Tzd3ZituTzVyb1dF?=
 =?utf-8?B?VWQwb1E1T3ArVG11ZE5Cc2MreEE3TVZtcGNvUTVFd0I1b0p4T3kwVGtMNkpV?=
 =?utf-8?B?WHpUUFovaHIrZ3FVUGJtNFQwdk5GeXUxeU5NOXJmN1duaTJYa3hkWFpFU1Ar?=
 =?utf-8?B?LzJneW50bnFrV0c3cHhmeGlIZ1o4Ylg0QWlycENsbjlKV3J0VDJZU0ZjanRP?=
 =?utf-8?B?Rkw2QXRVUjlSU3o4QlQrbGhxVUpkUlpxSk1tQ1orYjlVaEZHNlhudGhtU0dm?=
 =?utf-8?B?Tmd2azNOV05OblZENEVuYXQxUmI0K21qU05WZndaZDIydzJ2ektYeUVRNE1q?=
 =?utf-8?B?S2ZtMG9xc2dhWm9Sa2NockhYdC9JclNQdEtZUFREQmJ1WE1wZDlTYVhTMmNy?=
 =?utf-8?B?SnhOTld2RjBWY0hKVmE0SHdmcXJYNWxrbG92SFM3aUFwNE00c250SU1ZREZt?=
 =?utf-8?B?d3JPQlJPSC9FeFkvMWFnZUxLZzhmR3pjOE5yR2ZGNmFtalZyeWtHRXFCMTNP?=
 =?utf-8?B?TXgvVFY5Q2dORHVCTGY0VVlMYlN5M0xsUkZMU1g1V3FEZGxjNVFMQk0xcnJO?=
 =?utf-8?B?SEJPRWkzSUx1ZUdHSURESHlSSU5FeklRMS9UeVNocmx0akMvVE5mZ2o2M1pC?=
 =?utf-8?B?RSt5a0RkYm5YVk1EYWgrcm40MFUvTzRNNFcvRzk0V2FLY1JLZE9HRWpLQkVa?=
 =?utf-8?B?UWZJQWM3ZHhJVTR2VVJKRnNRNmkyL2dNU3NYL2ZoU2xad2JUYWdTeDRManE4?=
 =?utf-8?B?SWRSU0lFeXhPRUhucXhoOFlXNmkyY3RsNE9ETHhLMnN4OFByVk5KK0tGeFR4?=
 =?utf-8?B?TmMyK2ExTjU4clZxQ05tMWEwWC94d1dqS3kzWVFuZGkra2ZOVFRuYld3Ynpm?=
 =?utf-8?B?ZGFuTG9XZG9NN1JhbkxDRVF1TEplODZUeEhLM2ZrZ094aXJFRGFRaDhkUnEv?=
 =?utf-8?B?djF2N2duYmJOc3lhWm9nVklRL29hTmdnNjZVSWpXRWxISlV0RXZzRTFCQjZP?=
 =?utf-8?B?bEZZaWxmZWRXS1drT0d2NTluQW9KdnZZc0pLQitGRERBOVdnUU1YY00yMHFx?=
 =?utf-8?B?SnNNck5YaE9jNVZVd0VJQlRGS2VxeHEzVEZib0poR0xLQWRqUWQ2R1NyUkcy?=
 =?utf-8?B?VXZGWWFOSlZXUEkwYVNYTk42cnNERTNJbStsc01SeFZQY0I1T2p3Mm5lSWs2?=
 =?utf-8?B?VTloUGl5cEtUYTFyaUlzSGhBa1phRXdsdFVleng4aDIySm03ZEpRVGY2aC9D?=
 =?utf-8?B?d3FBVHpFRjI0SGprSlIveEhsd20rWGZpeFVvaHMyVHMwYkpSR1lRNk9IOUhZ?=
 =?utf-8?B?SFVOZG5kSlZMZFp5YnNlaTZxbm1zN0REM0E5U0dNWlZKUG01OWZSSDk1TTl0?=
 =?utf-8?B?dU5YYVlKM0cvRGxEQTVXYXR1VVN5OXpXT2pHa0RScnFhZC96QmZIVlJZaUtj?=
 =?utf-8?B?WUxRNzRSbHRJbC9meEJNckpaQ2phbWJjSjA3bmczc1YxNjZRcEw3TmdYTVhw?=
 =?utf-8?B?UVBwWElNTDYzdDRvWktVZ0lMVTlVTlZBK1d3K1hLLzdDZVVpL3ptWHpOOEZq?=
 =?utf-8?B?cUVPRXFVTTMyMllwSWdjYkdkVThBZ0RjZVBXbHJQSlBaYldaRXNyeXY3Wkln?=
 =?utf-8?B?cElTNTZtS05pUklxSFpaU2x3NFl5WGhQRjI1cHQxcU9ZblFValE0MlRiWmhv?=
 =?utf-8?Q?dR1UmOPEIOlY1zLF6Ljiul4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af525d1-a78a-4082-2a09-08dc731e077f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:26:39.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdZTpqV0QcyFevPQcHo8UaGzcnZZzDeUumgWGmEFowpPXhwlIIMIebdmOQ/1S3UiKVT3vJwgR4ZG6pthQASNM1ypulo5YG0wCXq3CVWvXjjdBvG2NAFBeyeTfkpbf9Em
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPg0KPiBTZW50OiBTdW5kYXksIDEyIE1heSAyMDI0IDIxOjQ5DQo+IFRvOiBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPjsgQWJoaXNoZWsgTmFpayA8YWJoaXNoZWsubmFpa0BpbnRlbC5jb20+Ow0KPiBHcnVtYmFj
aCwgRW1tYW51ZWwgPGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT47IEdyZWdvcnkgR3JlZW5t
YW4NCj4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPjsgQmVyZywgSm9oYW5uZXMgPGpvaGFu
bmVzLmJlcmdAaW50ZWwuY29tPjsNCj4gS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IEtv
cmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGl3bHdpZmk6IG12bTogSWdub3JlIE5WTSB3cml0ZSBz
dGF0dXMgMHgxMDAwDQo+IA0KPiBXaGVuIGxvYWRpbmcgY3VzdG9tIE5WTSBmaWxlIG9uIFdpcmVs
ZXNzLUFDIDkyNjAgMTYwTUh6LCBSRVY9MHgzMjQNCj4gODA4NjoyNTI2IChyZXYgMjkpIFN1YnN5
c3RlbTogODA4NjowMDFjIGZpcm13YXJlIHZlcnNpb24gNDYuNmI1NDFiNjguMCA5MjYwLQ0KPiB0
aC1iMC1qZi1iMC00Ni51Y29kZSAsIHRoZSBOVk1fV1JJVEVfT1BDT0RFIHJldHVybiBzdGF0dXMg
aXMgMHgxMDAwIGZvciBhbGwNCj4gc2VjdGlvbnMuIFdoYXQgZG9lcyB0aGlzIG1lYW4gaXMgdW5r
bm93biwgaG93ZXZlciBjbGVhcmluZyB0aGUgdG9wIDQgYml0cw0KPiBwZXJtaXRzIHRoZSBOVk0g
dG8gYmUgd3JpdHRlbiBhbmQgdGhlIGNhcmQgb3BlcmF0ZXMgYXMgaXQgc2hvdWxkLg0KPiANCj4g
SGV4ZHVtcCBvZiB0aGUgaU5WTSBmaWxlIGlzIGJlbG93LCB0aGUgaU5WTSBmaWxlIG92ZXJyaWRl
cyBhbnRlbm5hIHNldHRpbmdzIHRvDQo+IG9ubHkgdXNlIEFVWCBhbnRlbm5hIGFuZCBkaXNhYmxl
cyBNSU1PIC4NCg0KVGhlIGN1c3RvbSBOVk0gaXMgbWVhbnQgZm9yIGludGVybmFsIHVzZSBvbmx5
Lg0KDQpUbyBvdmVycmlkZSBhbnRlbm5hIHNldHRpbmdzIHBsZWFzZSB1c2UgdGhlIG5sODAyMTEg
Y29tbWFuZDogTkw4MDIxMV9DTURfU0VUX1dJUEhZDQpZb3UgY2FuIHVzZSB0aGUgJ2l3IHNldCBh
bnRlbm5hJyBjb21tYW5kLg0KDQo+IDAwMDAwMDAwICA1NCA0YyA1MCAyYSAyYSA0ZCA1NiA0ZSAg
MmMgMTEgMDAgMDAgMDggMTAgMjEgMjANCj4gMDAwMDAwMTAgIGMwIDAwIDAwIDAyIDAzIDAzIDAy
IDExICAyZiAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiAwMDAwMDAyMCAgMDAgMDAgMDAgMDANCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiAtLS0NCj4g
Mi40My4wDQoNCg==

