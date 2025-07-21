Return-Path: <linux-wireless+bounces-25766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE517B0CBBE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 22:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96493AFA60
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0319CD0B;
	Mon, 21 Jul 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKesk9QJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9A6F06B
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129337; cv=fail; b=WGOJd2JdD0bGpZQazuvGzRjdoeoSOq+7P6kMHW05qbopwOqksqyawoFv4CcEzs5orbn9IUGtECwMxwEO5tRxtJMyKQPT+44mg/PqD0EGjIEGnpNm3Q5O1EkDTgMNUZ2aedMuf0waSgsHLIvrORd6KP3BGEfhVMmmvLiaV6MBgos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129337; c=relaxed/simple;
	bh=HKJUFEt2bgDq4txBUiW6d3uXQuE0BpHtihWfGOHD/kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udS8dUGcmipLluuE2zE4a+fmRLNqgRIRp4kBchzgJrrj/ukLmyUPuT53rvKtOg7yTgJaphOzJPdggEhjMz/BBR6JrK9JRs8XG25uBEIheAPcOcoskoefccqePOIWhOMwlHBP6O4V/GBRi1GLyPuZMRd9bDVD3tJ5U5YjL5Rxm9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKesk9QJ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753129336; x=1784665336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HKJUFEt2bgDq4txBUiW6d3uXQuE0BpHtihWfGOHD/kQ=;
  b=oKesk9QJnvJSuarUMjr3yKzGGWAjPPvIBs25AB+XnvdofhUynV3/HWUw
   6gmZFTHaPIHi9TCQG4jsP14q1gL/gb9NnQ5v+jj8+pfu8sH9P+HxXn5B9
   GQZo3ogYWV7nTikosSg57yLAlzV71lhBeC8xYP+kLhiBKEwYAVDh7QDyW
   Q7XCD9NLpP963AkjsF80bnzuhx0OsEc0uWeKInycE9BopC8nS7qLT4Weu
   9Pkqm34TNhEl/rDITVD7UeCBTol6kVM58bwOmbxT/SOAF7wbBRdCQQvTt
   UAhCSEqqBaveqjcVaOJ8hQcNN7Uh3085ItsE5vhwacdpfGmpI8CcVdhaf
   g==;
X-CSE-ConnectionGUID: dO///GHTRuiJy1miEWZvnw==
X-CSE-MsgGUID: QPmCRjBxSBKCwNkogWhihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="77899525"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="77899525"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:22:15 -0700
X-CSE-ConnectionGUID: bRBlhev2TDi5NoFmzHpbgg==
X-CSE-MsgGUID: 6eqRWjKZSp6I6NZNWe3Nog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="182651404"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:22:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:22:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 13:22:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLAY9XCNzbsPeuCIbzyK2bjcEzRvXtFulFM2NAWRhcnP5J+FT7mGoyjRHLjCcauztvi6n3/H3s9QX2M45wvFNK4JVDTsxB8UyTgClr/G4s32rysXXZmpCqTdpjCrizRQrUFwBK8RqBKlC5Jh28LzD4UrgtBXpMR9OrVcaXqtttux0CSnjvVJPBBpCwWgLy47KNAIfBfeuOHnH+lUtxjOZ56yVUIIiYehq09h/fWQasVBVGXAqlY+q3ln5DMzAb5n99CgMgVRS5N5bbtVX/82656w0n4SVzRqwdWV7C2mC3cV5YQnbRLKZOFHFDZ+19nx1ZvIfklAInHrULWHqRcJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKJUFEt2bgDq4txBUiW6d3uXQuE0BpHtihWfGOHD/kQ=;
 b=zHm8v8CXzyP8Ak/d+jrCK1yau4R9MmQ2HnyXAOThI7RdZjOCxpqHWVYKRUPb/Pz9cF1Yf2gQjA7smaFYlzHAiVRFh1F8ywiTJ6iqkC38d8T5haCoSOZcsS0n0p5iIv+Qq2OELVxu79W+7o8BUSCKwnwqmI4j0fWE+6zmQETMKx5dNInstgIWpyxLFO7HAuTl41VBtYC9PmZZWPdWjNAlgdCLmo4XeXuJwF2Ads995Wa8BRqOJ+Bd5rXZfO2DVY4Xu3TEKCbuTGG/Nl66ETuzCNkm/KvC+CrWE2W5f5QjhSRp79pQ9UQskVDCZE8IROL3+uvO/6cAQXF5oi34BP9A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MN2PR11MB4597.namprd11.prod.outlook.com
 (2603:10b6:208:268::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:21:56 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:21:55 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Antonio Quartulli <antonio@mandelbit.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [PATCH] wifi: iwlwifi: fix cmd length when sending
 WOWLAN_TSC_RSC_PARAM
Thread-Topic: [PATCH] wifi: iwlwifi: fix cmd length when sending
 WOWLAN_TSC_RSC_PARAM
Thread-Index: AQHb9o7/kR+10+6r80e2+Z9tCKPD2rQ9C8uA
Date: Mon, 21 Jul 2025 20:21:55 +0000
Message-ID: <DM3PPF63A6024A9D3E27E675C13CDAF6DD7A35DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20250716201911.700-1-antonio@mandelbit.com>
In-Reply-To: <20250716201911.700-1-antonio@mandelbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MN2PR11MB4597:EE_
x-ms-office365-filtering-correlation-id: a4de89cc-cab6-479d-4212-08ddc8943cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WU9aZ042QTJnRUhjTnBCRXNDNktlaDV6YnNxdSswM091TzlIWHIrWDRXNnRr?=
 =?utf-8?B?ZlhEQ1FDV1F0bTlpVW1obmtJL0RNNGhoZ0NRaGpONlNMZWJuWGhqNFkxQWNq?=
 =?utf-8?B?dmhXaXhXTHJaMDhobnlhMm04WTkvT281dlBkQkREYTN6LzJkUzg5aGdZM1pq?=
 =?utf-8?B?Vm1jRmx6cjE1WkcrZnFDREkxMGxNekYyalpwKzgwOVdZRktkZGRYWHpCb01O?=
 =?utf-8?B?RWdYZmxPVkZnVjVMQ29vL21iajlKWTB6L0dqQmZYQ3RxbU9ja2M1WW91Rzc2?=
 =?utf-8?B?bmZaRmNYczcyS1JLUDZsa2pKVjdGU0NtYjhHTmVoTzR2MURaVTJJK0svSWFM?=
 =?utf-8?B?N2o5Q01yeWRFeUY5ODNKMi9iT2M1QnowL2dhSno1N1BETGFWVmpKRGZNdXl1?=
 =?utf-8?B?U0hmNFk2aU5CZExaeS9CVURUYnFKMFI5cEVlTGxrWDZpbjNuaHdNMm9rbHE2?=
 =?utf-8?B?NzRPRXFaTGJLUGJ6b2gwaFV2Sng3YmRDakpUQ1hMU0N2cFBacHhmZWhOZkoy?=
 =?utf-8?B?OVVucXJqQWFyd285REVneUw3NXYxRGZ3dWx1dHFjTjBrb05ac2NlaHZjNm4x?=
 =?utf-8?B?Z1MwSk5HdU9QVDE0R0F4Uk5ETmpQMWo4L21maEZqb29sYk5RUldBSGFZZDZ1?=
 =?utf-8?B?a0x2SWZnK0s5Mm5OTlU4cW5OM3RCRDF3c0NtYjRHNFJXT2xrWE0yR0dwWVFu?=
 =?utf-8?B?d3Fnb212U0E1TXhBOGhQWjhDMFlTNGFXdnFndjhjckYxVWpiTFRkS3JNQVVu?=
 =?utf-8?B?Y21meXoxZFBQOGV6Zm5HWFVDZVBtdUc4elJsWmt0cWF1ejJEbmdFbURFSXA5?=
 =?utf-8?B?NjBHaFdJa0NubHFRdTV1aEZUSkwzVXc5NkJEakh2akdEdkxzUFJaZEFTMXEy?=
 =?utf-8?B?b3lmT3VyUWpLRUE1OFVxd1paU3FOR0V3OFFYTkF0dHdBYmY3ZjgvbXlmTXpT?=
 =?utf-8?B?ODhxWVErS0ZqdThERjRuelRRNjBmM0NvMWJHWWlVSWlDUkxwUjVKWnFqd2VF?=
 =?utf-8?B?cTB5ejAybXdUYWd5NDlYTGJ5TFZ5aG9GaUIxcjRjczhxdVp6c2o0NjhmQWs0?=
 =?utf-8?B?WURCQWdxeUVTMmpxeENWeHRwZ0xRR1VQaGRmL2N6V1RyWnA5TVNraHNIRjVQ?=
 =?utf-8?B?bWU4dFI5RG94VEt4cUd4Q0pNMnBmUlBLdzBaazU3WXREaEVzQ1llZXlUUG5G?=
 =?utf-8?B?MEloWk9DZkNDelAxVDhJc1p2VkFTZXoxVFU3cmNBNUVNUExQUm9zMkh2M04x?=
 =?utf-8?B?NkJpVS9wUU5LdUluY0N6anZvanZzbDBhWWVxbmJGcTlRSEhtVGhBaUVmRXJL?=
 =?utf-8?B?S25aaGFGR00zK1FHN1QrcEF3MFNuVUZpVUpJTGRPazVWZ2RSR3JmTHhxKzdE?=
 =?utf-8?B?dDA2eGlsdlVkM2E1UktuanViVndiN01LMlh1UDVJVUtFMzZ1cFpKUVJIQVVJ?=
 =?utf-8?B?NC9CZXFRa1hlc2xubGFqVDJLY2wxNG5RM09mcjdVemllUHJDWXBUZWUydUxL?=
 =?utf-8?B?SHlVOXhNTFNDNTcvLzBSR1JBQll4TVdBZjN0QlMzTWJIS3h3ZzFyL2xRbEdI?=
 =?utf-8?B?Q0ZMemR3M1NBWVpiTmVqSUY2bTUzUFJnNmdYdmJyMXd3WGJpRVA1M2tCRWln?=
 =?utf-8?B?NWQ2Yy9ndlNBRmFCVUdreHVYWnEwZnQ0TkxBMlVCWSt6Nkl4WnR0RmhMWEpw?=
 =?utf-8?B?WUgyNFgvOG1WNFVVTHladFVVS0FlZjVnMjRhNVhpUkgvZjdiZnpTS254RXVa?=
 =?utf-8?B?bXdJZVRJUVA2Vmg3NkVzbmk1V0h2dWROdk00RzJtUHprYU1hRVd3eFRMM0hp?=
 =?utf-8?B?cTN4cUplTWlyMG9FT3dGcWFDMDZGTExybHRKS1J2NENvYU1uaWxQTUlDdHVB?=
 =?utf-8?B?M0VGdlRuMitEbDQvRWpoWnhYWFhLblJ1VDUxbkp3T3NaM1IrWnMrRE1KOVo0?=
 =?utf-8?B?S09JaU1Rb3Q0Q2ZTOGcwSHhJLytUTHFuSlJVYWhuT1lqODBJYnkvNDVRVGFW?=
 =?utf-8?B?U2hOMVQxVXdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtieTJNa1RCa1BHWVlSL25vSGh2NUZvLzVLenhLZkU0aC9xWW1XRWtCY3pH?=
 =?utf-8?B?Q1BOMDg3bWwrd2J2KzdOQTdMNGxON2FhaVg0eW9uY3o5TWt0RDM5MlJwcktI?=
 =?utf-8?B?ditPeEZqbDZDZlk5ZTNQb1VQVy9BblFtMTJNT1kyRWVUc2VneW9YQXU0bkdD?=
 =?utf-8?B?bGlxaTJqL1lNZDFsNmlXTGwzdUJOU0E0WmV4djl3SG5ZS0pvc2dhVytiSTg2?=
 =?utf-8?B?WTk4SHZkNlpTSTUyK1VQcnFrK1BWL3pjb0ozcUNiZVZLcy9iZVFWWEdkSnBh?=
 =?utf-8?B?RnRWZ1RXa08xTEtZV1BmRTlmeE15VHR4c201MGJZaytNQythRy9mSlVSRGdo?=
 =?utf-8?B?UllsMXU1TnZtQmJ4MWduWnVDZ2VHN2MvSVBkcW5aTmlCbTR1dFhJcjdxTmUx?=
 =?utf-8?B?dDdYdmRrdXQ4aStIQnpaZDdnUC9VTGlYWGQxMGJGdXpSQy8xMlVRNmovQTRm?=
 =?utf-8?B?OFN3SldkSHdYVlRpeTUrVmdodTZkOXNDOFM2SExMdjZxalI4dThwM0piSTZa?=
 =?utf-8?B?WHkxL1FQdkl2b2kyRzU0V0N1c1A3QjNvdWFHSWZzZTBTaHhHR0VtRWxTcldB?=
 =?utf-8?B?Qi90anFmVjFDVWhveDRqekVaaVh5N2N1REhKYTUrUnVqWTBLblg4TnlYR3Rs?=
 =?utf-8?B?TGJHYXNrTlBJRjZZaFI4R2ZFVUIvQy96anFjelhmZ256alY5OTliTW1XOHV3?=
 =?utf-8?B?VU9jYVU1QlFtSitDdG1hdUo3eUpBa241WGR4SnpGVGJBRmphTEgzcUxXak1v?=
 =?utf-8?B?OU5wQjM2ZytWTG9MeTlkVFY5UnNtNHdhN3VsYVplUm9RUGROZFVuSWhJQlYv?=
 =?utf-8?B?Mnh3Qk5XQUZ5WFdDaDFmaUU2Zng5cFhrWENndFNZcFJhMVZOL0hwSytUc2JX?=
 =?utf-8?B?SU1jbkQ1OWNyTkhFOEo2SGVRdG9PWTlqa1d2c0tTTHVlL2VJd1hMRDZYcW9q?=
 =?utf-8?B?RmRJeUhpUlpiMFZqblNQaHY5S3N1WUxOZ2pKWHhyYkd5RWZqbmVLdkkycTl6?=
 =?utf-8?B?NnBkYWxGVDdXWGNZNGNaejh5SVlNQzlnTDhIOTZqUUZGMTBWSm1kU21obnl3?=
 =?utf-8?B?aU5WWjB2bVljQWlqNTV5Z1owM1Myd0UyRDM1d0FMRm11cWtPc1ZHbnhkdnBQ?=
 =?utf-8?B?YnhVYkJFVFJWUndyeHJVcElXa1haVzNXNGZGYWpKMU9tOHBodk1FaE5JZUVC?=
 =?utf-8?B?NDdiS04vdW80aHowOFFtVXZrbWxnQWhtaUU4Yml3OFdpTHhTcTkxaCtwbFVk?=
 =?utf-8?B?ZGdFL1gvczZBSEY5Unl4NDQ2cmIxWmRiODBXOFNuMXVNRVZERzhDRm9WMFMx?=
 =?utf-8?B?eWI1WkFBY0w2RW5uZzJUbk16c0E1SjcxRit3eHBxTkI2UGtCVVdJWVh1Y0Y0?=
 =?utf-8?B?cnBOdU9lMVhvdnRwN2luV0lxREhXWTBJbjBtOFNhMjFKNGRGNUs3dXhqQ3hs?=
 =?utf-8?B?Vit1NW1uV2oreE9lbjBlc1Y0bFRRM0g0UEVwSEEvd1NHb3U3bnRKKy9zUmQ3?=
 =?utf-8?B?T0JMVDlKVHlFbXQ1VDhacmpSNFkrd0hkaG0zbjJ4T2pUckh3V3RIMkZXcmNQ?=
 =?utf-8?B?Z1VtSzJqMFFvMGwzSDB5VnFpNVJ1U2hGWnozdUt5eG1QRDVkcWpwSEg3TlVm?=
 =?utf-8?B?WWZqOFViNDNvaGdUd2tuejhjVzd2ODFPamltNi9iQWtQd1AvL015OFpmT1NI?=
 =?utf-8?B?N2lPNU9vSDdPQzBHQU5FOVFJOUNIc0ErdENUMzRKMnpFdCt1dUFIODJuZzBT?=
 =?utf-8?B?ZXlzai96d01YZHZJSGlNSFByTVExMFU3dHRTMC90N0pWUnY4WThHNDJmb2tn?=
 =?utf-8?B?OXlKMk1PYUdOdTQrbUFRcDhIL1BLYWg1VEF1NEJOQngwZ3dZdjRxamNnSXlu?=
 =?utf-8?B?Z1h0RWI3dG9zUDRlZlVpTGRLckJ6N2lJc0pqZktWTFVtMGk2aVNQZ1Yrdkc0?=
 =?utf-8?B?S3BmUFRna1BQVTM4a2IyMGEvRlNBc29pY2dTT0JzbHdzL2haTmd5OW1YYmg5?=
 =?utf-8?B?NUlvRy9MZkpoWUszRnJvSktraXI0bXg5RVBuSnFyM3h0RUw1N1UxTjJLOVlM?=
 =?utf-8?B?dUtmYzZBN2dBSTc1enVzWXR5OUg1Sk5qVW03U094TVg5cmtBV2FSajd4SXNT?=
 =?utf-8?B?KzlucFlpc2M4cXQrWTljdXMxWTJoYVhEUy9kUk9uT0VjcDFLcWZmZWJkWXRi?=
 =?utf-8?B?L3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de89cc-cab6-479d-4212-08ddc8943cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 20:21:55.9408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTXZrW6fkLrE55aSxKxz+MGQ4Bd2IVgBPJOnt5+frlNrR1+moDd5URbjYpieIZ5mpWzgHPCL4EVysY/EPd4I/0nJ5ze3LJYIdshhKjotj3G70jcr6YPxljZ+JfT6rzpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudG9uaW8gUXVhcnR1bGxp
IDxhbnRvbmlvQG1hbmRlbGJpdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMTYgSnVseSAyMDI1
IDIzOjE5DQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFudG9u
aW8gUXVhcnR1bGxpIDxhbnRvbmlvQG1hbmRlbGJpdC5jb20+OyBLb3JlbmJsaXQsIE1pcmlhbSBS
YWNoZWwNCj4gPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IEJlcmcsIEpvaGFu
bmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEdydW1iYWNoLCBFbW1hbnVlbA0KPiA8
ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPjsgQ29lbGhvLCBMdWNpYW5vIDxsdWNpYW5vLmNv
ZWxob0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogZml4IGNt
ZCBsZW5ndGggd2hlbiBzZW5kaW5nDQo+IFdPV0xBTl9UU0NfUlNDX1BBUkFNDQo+IA0KPiBJbiBp
d2xfbXZtX3dvd2xhbl9jb25maWdfcnNjX3RzYygpIHdoZW4gY2FsbGluZyBpd2xfbXZtX3NlbmRf
Y21kX3BkdSgpDQo+IHdlIGFyZSBhY2NpZGVudGFsbHkgcGFzc2luZyB0aGUgc2l6ZSBvZiBhIHBv
aW50ZXIgcmF0aGVyIHRoYW4gdGhlIHNpemUgb2YgdGhlIG9iamVjdA0KPiBwb2ludGVkIGJ5IGl0
Lg0KPiANCj4gRml4IHRoZSBleHByZXNzaW9uIGluIG9yZGVyIHRvIHBhc3MgdGhlIGFwcHJvcmlh
dGUgb2JqZWN0IGxlbmd0aC4NCj4gDQo+IEZpeGVzOiA2MzFlZTUxMjAyODUgKCJpd2x3aWZpOiBt
dm06IGQzOiByZWZhY3RvciBUU0MvUlNDIGNvbmZpZ3VyYXRpb24iKQ0KDQpJcyBpdCB0aGUgcmln
aHQgb25lPyBJIHRoaW5rIGl0IHNob3VsZCBiZToNCjQ5MzY4MWQ5Zjk1YiAoIndpZmk6IGl3bHdp
Zmk6IHJlbW92ZSBzdXBwb3J0IG9mIHZlcnNpb24gNCBvZiBpd2xfd293bGFuX3JzY190c2NfcGFy
YW1zX2NtZCIpDQoNCg0K

