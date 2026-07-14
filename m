Return-Path: <linux-wireless+bounces-39113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id raAoIjd8Vmp/7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:13:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADF757C3B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:13:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hwV1iPw9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39113-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39113-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14F83033839
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959D3CA4B9;
	Tue, 14 Jul 2026 18:08:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2027707;
	Tue, 14 Jul 2026 18:08:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052533; cv=fail; b=VTchtc2Ql2hbbw8YfBvp0OUiDLb8WLH/3Oi15Qj9RV/t+5NPmCDFFQkXb7M5V8yqQhJaJ/reWLZ/poZU9s210682qZe/a/n2Jhlpw+cpfturr5edEGsB70b/XYYo2YQWAYvIYZ65UzGXRnWYcGfPqCWSb9EI7MPPMB84CO4eotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052533; c=relaxed/simple;
	bh=4MaY9VkhiMXGfKrIpGJ2tmDJddwjo0INYJ3KnwN26Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnJqzTNw9uWUdOqR5kw7NHFk/p55X5ryCDGE4u3o1VNxhDl17QCBh7XqDPYWQGZxJFJ2kUoZLXt6ZlWn0soXdP5Rj2J9ZrCTvQ8ko4lvwElE9kl5vCKNueKL4c12hsFIUB7L7WFtx0XLKyvLDYZsc9yvxZYyniXrqQX2GOGOn7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwV1iPw9; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784052532; x=1815588532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4MaY9VkhiMXGfKrIpGJ2tmDJddwjo0INYJ3KnwN26Wk=;
  b=hwV1iPw9NwpzIEPyJeULBzFsPZtMYtjtoCuUIGnMNlGT1OVIxMQSj2l+
   VYlVbLX/qlHznoSBIou8CVZuu0kUY6N8VQZOVSHFhfc+k06BZlKwT7E7d
   wtWKGho58e0rcsgZCW0pvQY1AJVOfxD9Sfa81zpqPncJMCbi4b9cn3uTl
   ceJpnIrK162BwYF9u9VcpTlgZARVTdreHIyT+482D+Fm20tIE/gqpKL9X
   QYMmybLg2q4YJIRk52xnYI9wD62valJOz2cCXe7N6pNwBBCFdgQVf/cxR
   47o5t2ZfDAiOR3Kw3Pp2qEKpsniUjKZJ7zCGXvrfp58iUXRWHM7/0R3Hy
   Q==;
X-CSE-ConnectionGUID: 9Hy/vG6zQKWyrqhHJ+jMDg==
X-CSE-MsgGUID: toTfCwqqSfmy3jInoxeN+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96193539"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="96193539"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:08:51 -0700
X-CSE-ConnectionGUID: 39u1irLFQJO8GmjAYi/13Q==
X-CSE-MsgGUID: emOiX/KGTJu5zVUhOgg4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249568403"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:08:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:08:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 11:08:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tibLXaFsfkJRofHcbp8luLe1M5nC2/WkE6Ae0UjOM8NCCgVcosi9006nHSeERldITjYPF1n7yG+Lh8IBh019ZYOnPxLGIBIEhnuz0R5MNPtPKc7gmu66foq7oRAXz40IFM1yAzZIzKT42iNTlptkQvggushkoFIKeB10++GTuy5wo3IC/ejsvv8oli7Y04t5NaceLPUNQ1yWoz+iTEArYmrDAgDzI5+lYfapQlP20NVzWw3QFgX+GTPIUeSeq/ouDPlhJ8zAI5vj94bujnXnM8xX0JvDSIgM1lXvIeyQOzcbD9F4XvfCyaZ84HbXLpO7aknDT54gzZs18nd4tkKn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MaY9VkhiMXGfKrIpGJ2tmDJddwjo0INYJ3KnwN26Wk=;
 b=PEKky4TT6Ck+tnliokjjZUYoBY30X2daL5bFHKptT0YPX6FTVBe5pqpW6VPSd3x9wJfZioZk1KzQPpp4veZ7HiSw+Os284wZ5CHRewvO60iW6k3OmAkuF3lQ6xalQS7/LPER3ohbwwVbhSflDZJuRvMFJ5olzvxEJR9FQFPM0502pAXimqBMkcpRWOAx3z6cNRpT20f0K2cTNushw/efqFpIN45Ab/QjkL8yHb0bqV7+4Dcy2pugL/GBOyxLnrXz4x3jEM4AnjSeoZoXnBbtOmhxpF1GpozGHoGx/IThAUfPz6Du3NBX2CyWCxV9IVUcNVqfIlSOoW4pwvfAPNWvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Tue, 14 Jul 2026 18:08:46 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 18:08:46 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: "open list:INTEL WIRELESS WIFI LINK iwlwifi"
	<linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: validate UEFI reduced-power SKU TLV length
Thread-Topic: [PATCH] wifi: iwlwifi: validate UEFI reduced-power SKU TLV
 length
Thread-Index: AQHdCGFthorIh7SdcEWeZlnH2KKz3LZtZr6w
Date: Tue, 14 Jul 2026 18:08:45 +0000
Message-ID: <DS0PR11MB78802CCE2DFBF3DAD8DF3ECDA3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <2026063008051412.5-ccfa108-0020-wifi-iwlwifi-validate-UEFI--pengpeng@iscas.ac.cn>
In-Reply-To: <2026063008051412.5-ccfa108-0020-wifi-iwlwifi-validate-UEFI--pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: d3a4fc72-2d8d-4028-9058-08dee1d2f279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: QrHtmYzgKXlfbRWSV8fjBHn9eyS7LX5CfpoOnz5Tnfq9TWAccTuqsuoSDxbkXi4kDyP3zhD60SNvSoZlxXLRC6dKMWRVqTJ3H1PXpAgm+HmYLF6PIL61W3wo+pe6ymh0qXPpyVYnaOMXILc4Fa5j90Ql9BpR911NJlVhNbblQOuDEMXPdflg18wmdYInq69F1cqsx+vjPkxNlVd5l+q+x2bXIOp4i7URNp/AlDmAXjCMeYHAMG7EJolYbbnn5WPTEB22B0vP5w7XZlXmQNgkyReC5f9a6otw0AjWk6OajaCVrNZgjfU5ysp86jHvtbmV1/1ukzt0mqP09mEcvV61YEIABbJ25r2qkxMnS0/8S65b0EmK6v1jGRBFndp/yCrBC79e1QBfd3as6u1x6PD4rE7etOVfLPcGKKrtWFUmpRCjOMZizyhWMzrIaSk0MOgvo0+wAkjqgNqgWlK7FCwLs35uuIJg8OuloBC/yfDcstDTXutJM5saJpcBEh0eXsetXxaYHR3SJBxDMNTMCF1vwphr+58lvSJhb3JDL7nRRdtO3D4wH0KMWYUiNotOcz8qsVb1mowxCQPVuEF2oQLX6Rq3fezVaCgnOHrLxyd5SXEJ7zr+I5cR7wBKCbb40PZkHPNtXZKuIX2uZTa8MyPkmsbyWGlEELET68BMv0He/s0iN6U+qtnA8Bu+FLm8xr37rMcpK9DnEQdRL5oAPjt+6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJsYkRqbUFnakd0WGlpRkZ3eUt1clh5RlVoa2Y0dGR2eTNGQ2dwN3VHZEhE?=
 =?utf-8?B?V2RNZ0k3djdWNmpOWDJNbjBRWUtqbGsvUHBPZ2M5eVBOZVNsSmZtOGRqSzRk?=
 =?utf-8?B?YW1JUzNyak55cTREN2F1LzRDVjd3RVFqOVdqTzN1Rm5RSkdOQmVFL1g3bStw?=
 =?utf-8?B?aFFnL3VVMUEzNnhZdWI1OVE2VUlMcmEvUlNxcGhhb1JjdUU5Q1hvK0xGdlM0?=
 =?utf-8?B?aVdHQ0RYTFNsa2hQbWNoMHJJdEd2VVdKbDFnRWkvSndzeUVRL1hCeTZ6SUZw?=
 =?utf-8?B?NWt1dVRmQ1gyRFlTZ3JGKzdIYmN1d0F5cUNjWCtsblRiQWN6YkZuRGh3WW52?=
 =?utf-8?B?QnBOQzNoQ3VqTlpkUmlIamJHZXd4WHFGSXBxcThKMk9hVWlLdllZSjVHZmsv?=
 =?utf-8?B?ZVEzUW43Q2hwUDY3R3ZJOXhVMzcvakx6dDJEZXhaaHQvN1B3UTRpYnA2aTlw?=
 =?utf-8?B?Rk9GK1JoUkhOK1U5eWFreXdCa2JyMVgzQ21rNnRYK0M0cXhLMXNqRXJQVWpV?=
 =?utf-8?B?U21BdTQyOXBRU2pYU2JjbEM5VE9qZG1zMDQ1RkhDT1d3VmFveng1eUNLc09n?=
 =?utf-8?B?TGZHa0VieVhOTVVSRXViQWU0Y3hzR2FHRGM4d3hiV3FpQ05FbTUvNzgyTnR2?=
 =?utf-8?B?TnVNUldJSzBpVUx0NU1uNmo2ZWNudHRGekZ6RnVIaGpleC9XS0ZYK2dqUEhG?=
 =?utf-8?B?UisyUDNVQWZ4a29nRzlLbHRwdWlhQUJZalJwdW90TDNOb3dqTWFWeWpQYkVB?=
 =?utf-8?B?bC96MEJqcURjRVN5b0kxTjVBSmNHV3pIYWF4eC9DTDRKVHEyWHFJbGhGY1Ni?=
 =?utf-8?B?UWUvRityb2VTd1V3b0F6RitkQllBWmtnOEZrdzhCN1VEZEFxWUowNkxObmxx?=
 =?utf-8?B?L3lTZlhtaExwNUdmRG9iM1V0QkV3aVV5dlAreFgydlQzV1Qwd0hDSDNkbWhB?=
 =?utf-8?B?dFIrMTZqR2hkSkx5WFoxcVFiMGZkWmZpa3pFajdJdEVMcUdPbGIwTkE1L0U1?=
 =?utf-8?B?QVM0YmpOeUxVRldrYnFZRW5FVTBJYk5qeXBrTTdKc2NzcWFBU0RiRHd3K000?=
 =?utf-8?B?SUhsWTkvbkg0U0sreVlaRm4rTnVjS2ZsZExjZXlBWi80dE9JR1Z1LzNxRmtl?=
 =?utf-8?B?NmN0Wjh0U3ZoNmNqb1ZKek9iMm1STTRNa3Y3KzFpZlFrZ2ZGNExQWTh2UC9B?=
 =?utf-8?B?Vy90QmxRemxPbmozQkppUEVULzdheEpRTGhnMzg2MTRYeDlPOXFxamYvcFQv?=
 =?utf-8?B?TUpiYkEvQ2J3RmxNcmo5Ri9uM0p5ZnlrVXBOMFJqK0RwRkRONlhZalZqdXZq?=
 =?utf-8?B?dmhYalBoL2RNcnM3M1V5N0I2RG5aOFFFaFp2TUdNU3lvZ3hsZDZickx1ZDZt?=
 =?utf-8?B?R0JtbVROWUo3cW9ZY21xU0ExcWNZWERVVWpSdkF0a0FEWDh3OTN5RFNPMnR4?=
 =?utf-8?B?eVlxenVneElveTdmQlFqaDc3WEs2WjRka0U5M3laQkNhWGVXV2Rya0p1dC8x?=
 =?utf-8?B?QmRkdGQrWDdXeUNmek9NemI3NENibnpzeHpiQmdTMWQwZmNvaEFkNmRwZlFw?=
 =?utf-8?B?QlpyeTdBczhOTmwwaUpVa25kRTRBa2dCY1Rnb1pwNXEwY1I2MHgrdHBNS3Qz?=
 =?utf-8?B?bUg5UzZRVFBMeGplcmhRK1pDeDhsMDliaDdxRG9HV3NwdzdZdEZLVUsvbDRW?=
 =?utf-8?B?QjdzelNBRElDVVV4RkwrKzVpYkVEM0tvOTBPOGI4ZUQyQW9CL3R6UUMwcmlY?=
 =?utf-8?B?cTNXTllSUW0xOUlaYWJ5Ni9DRjZnZllocFpLYVpMSVoyODhGNzhCZ3pSMEpW?=
 =?utf-8?B?MzU3NEhxWDhtbDR4b3dQNUFuNEI5dkxiSjNaK3VpeEJKcWlmTzVNY01DWVRn?=
 =?utf-8?B?QzQyNXR2b0VRWU04Z0tPbHdXNEVvZ2FkbEQzT2RHalluU1Q1dEZjM2pFUEM5?=
 =?utf-8?B?OXZUWHdweHF1bDhoTnVtU1ppeWdMVjdIU0pRRHNPQ3cxekdBbVQ4Y0J0SUcv?=
 =?utf-8?B?UXBhUlFNMExOZDVDQ1dpOU5oWHlWYTNldVhyYWtDdFlpTlBPU01uRTg2WEM1?=
 =?utf-8?B?SVpMazBjWk1yK1FzaEpFalk0d2xzR2FqRENIZWh2MmpXVmJlNXZCNVNkLzZN?=
 =?utf-8?B?SXd5N2lmbUJhdHEwQ2ppN3BIeGFJK1BjRk1LcmltS1NPblJOT2dtZjdXQ1g1?=
 =?utf-8?B?cDlFUkhvZnlMVWJIRDhWdG9ZL2dZR1B3T1Bvb1dGNGk2a2t5cnE0UHdrWC81?=
 =?utf-8?B?VnVWWS9TME1NYmdRN0d5YjJFcnFDZCtWUGdkOXBwN3pzd05tWkE1djNWT015?=
 =?utf-8?B?L0FHWW81SXVYb3pEZDN6RllQVU1jWUF3K1ljbDk0RnlTSkk4SFdGUnNWNXIz?=
 =?utf-8?Q?EkVRUzzzCnMYnv+E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fnbSs/5ufqTBk/aieROGETcbgCD/1s5xeCXDRqQNkf/JHVij16euucOdehP5fvektlPUUAXG04ZuVGro/S0aNC5NyFspX4AEKmD+DAfrWvmjRkmZo04Ll72vpznSz4M4k2L2CJax1UoW+zjq7fC/91F8k8i47P9mh/exTCTQwgFxpgsr1PZH2ISTT0UzRKf1uw2FmuP6E39+3IJY3CxHrvtTAz6LQqwxkIU3UQqIMn/OdzlAdJXCLTNYtJx54vPzxQrcY5gLPIGxeBNoyf6yo/dHJEAkmIo7WUYSP8gtuSywKemFD7MyrmuI+CBcvD2DMnNAk4SXQtxWwVMTGXT1lw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a4fc72-2d8d-4028-9058-08dee1d2f279
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 18:08:45.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEwfin8uG6UVWzcepL9jujfMZJrhcngRwmeLQx0sXTD6zmltcacNG6Nsy95PWcvOkR0uLQHUPdnRtM9JygF2uEiVqmqCQOKLpYqESFvt3QruxNw9sx81vSVEm5F7hyPd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39113-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,iscas.ac.cn:email,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4ADF757C3B

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZ3BlbmcgSG91IDxw
ZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzMCwgMjAyNiAxMDoy
MyBBTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVu
YmxpdEBpbnRlbC5jb20+DQo+IENjOiBvcGVuIGxpc3Q6SU5URUwgV0lSRUxFU1MgV0lGSSBMSU5L
IGl3bHdpZmkgPGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Qg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBQZW5ncGVuZw0KPiBIb3UgPHBlbmdwZW5n
QGlzY2FzLmFjLmNuPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IGl3bHdpZmk6IHZhbGlkYXRl
IFVFRkkgcmVkdWNlZC1wb3dlciBTS1UgVExWIGxlbmd0aA0KPiANCj4gaXdsX3VlZmlfcmVkdWNl
X3Bvd2VyX3BhcnNlKCkgcmVhZHMgdGhyZWUgU0tVIHdvcmRzIGZyb20NCj4gSVdMX1VDT0RFX1RM
Vl9QTlZNX1NLVSBUTFZzIGFmdGVyIG9ubHkgY2hlY2tpbmcgdGhlIGdlbmVyaWMgVExWIGxlbmd0
aC4NCj4gDQo+IEFkZCB0aGUgc2FtZSB0eXBlLXNwZWNpZmljIG1pbmltdW0gcGF5bG9hZCBsZW5n
dGggY2hlY2sgYmVmb3JlIHJlYWRpbmcgdGhlDQo+IFNLVSB3b3Jkcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy91ZWZpLmMgfCA2ICsrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy91ZWZpLmMNCj4gaW5kZXggMmVmMGE3YS4uNzQ3ZGY2
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy91
ZWZpLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy91ZWZp
LmMNCj4gQEAgLTI0OCw2ICsyNDgsMTIgQEAgaW50IGl3bF91ZWZpX3JlZHVjZV9wb3dlcl9wYXJz
ZShzdHJ1Y3QgaXdsX3RyYW5zDQo+ICp0cmFucywNCj4gIAkJCUlXTF9ERUJVR19GVyh0cmFucywN
Cj4gIAkJCQkgICAgICJHb3QgSVdMX1VDT0RFX1RMVl9QTlZNX1NLVSBsZW4NCj4gJWRcbiIsDQo+
ICAJCQkJICAgICB0bHZfbGVuKTsNCj4gKwkJCWlmICh0bHZfbGVuIDwgMyAqIHNpemVvZihfX2xl
MzIpKSB7DQoNClBsZWFzZSB1c2Ugc2l6ZW9mKCp0bHZfc2t1X2lkKQ0KDQo+ICsJCQkJSVdMX0VS
Uih0cmFucywgImludmFsaWQgUE5WTSBTS1UgVExWIGxlbjoNCj4gJXVcbiIsDQo+ICsJCQkJCXRs
dl9sZW4pOw0KPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiArCQkJfQ0KPiArDQo+ICAJCQlJV0xf
REVCVUdfRlcodHJhbnMsICJza3VfaWQgMHglMHggMHglMHggMHglMHhcbiIsDQo+ICAJCQkJICAg
ICBsZTMyX3RvX2NwdSh0bHZfc2t1X2lkLT5kYXRhWzBdKSwNCj4gIAkJCQkgICAgIGxlMzJfdG9f
Y3B1KHRsdl9za3VfaWQtPmRhdGFbMV0pLA0KDQo=

