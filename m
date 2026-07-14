Return-Path: <linux-wireless+bounces-39115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UAJuHPKGVmr48AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:58:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F175801A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QVxZKBdw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39115-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39115-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B5C6301C96C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EB377AB4;
	Tue, 14 Jul 2026 18:58:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D5331A61;
	Tue, 14 Jul 2026 18:58:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055533; cv=fail; b=cS7FdoI8j3KiBjwuKquLpLAv2JCafyoPMBp8MktPuVaqL2d/Vlraihj4P4Gw985l6YYC5O2KcIhHrLpLtMMjkt/+34w24A0dKubp273USqP3sCZJg4+vvY4iyfu46Sr0Mok9fhYbsrg5wzGJqLwx3LbSc0AW31lA55xafVY8Fj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055533; c=relaxed/simple;
	bh=2jBZQz3w9TuQd7mR2S34JmGM4C+jIlj0YzD5Kx+dwf4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OmeYsGi8puYQEkkcdCq06tpAjjdFVpxgZhI8wrqI6bilZzqb737SZNEf2VVZAhi1VQALaSJmreD3YWI06r0GVaBiWRTzmjRYypYEIPoRlJhXt4gLZNuIkFSTaxEZSAzLGKLkXlCmfxW/5ELG9pvobN/06EUhPL7/3uUvmazbTiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVxZKBdw; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055532; x=1815591532;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2jBZQz3w9TuQd7mR2S34JmGM4C+jIlj0YzD5Kx+dwf4=;
  b=QVxZKBdwXDVXZa7CgturaqRJP9zSTRbO+EL4gRr6QwmTy7YvIbOySmC7
   7WtsPUdcwSUJ6JW44aJRC9awgmlgbKTAYRakwYu4ZSvnzWQ4Im0neHvzT
   BiZxf0Mv9lFtUH/uWw04uyRSJdOSX8GX9om02Nh1Z+pVhh9XoJ8fclRsu
   5ob08TL9gExSXowRmpmGX/9oFRnTJV8cILjJu7ZUo+TQyEkHOA9BqR4Lg
   HtL0+TJQ4cmjwNSdtxdtQjrmxkAswZ/U/R3PmXePFm2c36wZU/Twgc9Gz
   A1/inTx4pPWgkdBDXe37RQvo8VGSX+b9DbS56KT7NtgDivH3EWk6em3jg
   A==;
X-CSE-ConnectionGUID: cUQD3mlgQOaqut3vKxlCvQ==
X-CSE-MsgGUID: yAiOo+qURSm3V64nQnXNQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107482051"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="107482051"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:51 -0700
X-CSE-ConnectionGUID: KkLlP/9+STm455TnlMjKRg==
X-CSE-MsgGUID: aFM2pygYQCieb6xjpWNQ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252554997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:58:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 11:58:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee8AUC+6/Iaj4QbYrutgLh04S/NH/ynycNI0WZRWTdh36asT0TXPuHVej8f3jVnVW8hwViKbPy5A7XJb8SFX5ix1ZIQvbkH5CYsFS0s1lTJXT2sqMzJOHYgnQRVObm2f1JQhfhE6z5KBnwLywWLMaI61BkmCQm6mwzDLGRz5sx9Fxbiyje2c8RZ87Q+v+hasOHhhuc70SLD/qA3oQgIyhE+SS7Y2klJLqhP9sPbSkIvDOyw8qDFdjyLs19PhZBV7yKu7CPY9exZnSAw4FPKftfvCps8tZecZBynVUQZFjeRfY7ueKlHfeCD1GbbOWzCF9OCfG31HLWCsq6A6E4j+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jBZQz3w9TuQd7mR2S34JmGM4C+jIlj0YzD5Kx+dwf4=;
 b=VszFCS3zpglnf6uh3IBT+nla5kqudRZw1LUIcXzIaiKcOf91MyHXerYaK/3mLRQUU9WYR7QGrRt2g7/3dWRJoQ/hM6JDcylYPsScZ2JXGg8N/SGVj3N9HVdWBfC97UDMjxW1v72artC5HF835h54gBzNVJUXOMZ5VIM1tVvMel376ydGmvoCKCS1EHSpgM90AvuSdOhZDpLN/tXgav0KWh895LkZvUe59DO2ExjuEL+WgPTS7bUovO0pBdVLYzWuAS+Y4nTiGWfVGEL62hO7aRU4Cpwh+Z1JNFQYivYbt2dhIvjUiHMJYfVHwmJxoCNi1DC6ra2y5gOIATplvv5CRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 CH8PR11MB9483.namprd11.prod.outlook.com (2603:10b6:610:2b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Tue, 14 Jul
 2026 18:58:41 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 18:58:41 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Jiajia Liu <liujiajia@kylinos.cn>, "Berg, Benjamin"
	<benjamin.berg@intel.com>, "Berg, Johannes" <johannes.berg@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: use unique thermal zone type
Thread-Topic: [PATCH] wifi: iwlwifi: use unique thermal zone type
Thread-Index: AQHcscFUApSgJUuKOEOTAZOFiMBOabZuIdYQ
Date: Tue, 14 Jul 2026 18:58:40 +0000
Message-ID: <DS0PR11MB7880D6838D23BBE2A821FF1BA3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260312014043.13361-1-liujiajia@kylinos.cn>
In-Reply-To: <20260312014043.13361-1-liujiajia@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|CH8PR11MB9483:EE_
x-ms-office365-filtering-correlation-id: 5f8fa2da-0399-4e80-e4a6-08dee1d9ebac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|38070700021|18002099003|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: Ap2NPfaNILZ3aqMIzM50D3Y801mWlPGW3TU/rKSIAM/raGwuSpHGSMl/rh2ng1TOv6fl5wWGfJ6RGKRQmLxKhTYlBYjfb5PbLuIBTM+8g5USsaWpkQByic5Swl/myC3sYqSQJqtCbZlDP5Zkb1yU+QGVSM0ZGxR+56baqQEtfs2CahfIZeIr39OEJny5k83UMVNiIAVXmRRvg/PH7XgrD7TIMf0k5vxg43dzzyeZyXFjrqe9aYptmgbxUVQ1ePvClxiY20CKpDdwsPpjLV/qg68zyoyQKwMmeka482+opSdJPjDYQeFW/YjxNlNAeuOXVJdHxDINbltAcP27YP1Wl1xDO8hAZuyFLjABebnONA24N5bhfBYqXXSbywQC0uMhiDUGi/tajTupNveH4riuEIgYTLiEKkDnoa29C27OebO9Y3ORgKsbdr6J9Jhx5CUbBBqhoWI758X2x0NyItIo2H8VqsvP0rLpy3LCIHWTP/mG59354dRD1uOHzgH3krAVq5SH71MBLWaPJm5P1aZnD27BZGv9FJSwHp6PapOB9yHbycEnBC1hevQA2U8m2vXG20R0f0ribant58lYW31yU67m4Yh9jqtOPuvRaoRoemUQtI97RDBWbJRLUiFLV/Dl4i/O8Ef331i3iAfYqJi0FYJVtg1Bscg+orU+AfqXm5kSIy7MWJCUbeNs7YfK3zga6AwaGzWP9/DmdGAhp3fbP3dH/tLC0ChruuFQemrdA/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(38070700021)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXVYRXZDaFc4cmw1VTNJOVNXU3Npd1dlSUJXbVoySDNWNDdHRVFNdUdISXFW?=
 =?utf-8?B?eWZPYzAySkdnTnNBbWIyM3IrUVEwdG1reGd5Y1lzeGZCV3hQL2U3V0ttKzJy?=
 =?utf-8?B?MWl1ci9lQUNHY29rMk43NzhuNTl5OGpTNlVsWnNNSnl0eEZicDdsYVE3Uytq?=
 =?utf-8?B?SWVaalpTNXdNN0FiU0hsNG40b3FvVTJ6N1hMejlCTEF2T3Y3a1lIbmEra1N5?=
 =?utf-8?B?SXpPRFk0dnVUSGZMcWJRbXZFR0xBWFd1dm12SnY4dW1wM3A0R3FFR2JKcHQz?=
 =?utf-8?B?QnNrWDhLbkcxRGRYL1hjTThSMWNHKytEbG80MjhEaVNqUjg1cmZ0TS9xMm5n?=
 =?utf-8?B?aGw0M0lDc0dVeHJvMUIvVTRjSDB0Q2E2YVJBNmpocThSTHNoeVRjTmZJM1ly?=
 =?utf-8?B?QUszdE5DZy8yZnFrQWVQUjFWeFJxTjVvZG42TW5PQk5hUU01MnJqOHluOVN2?=
 =?utf-8?B?ZlpmZDBjWTd2TVBxMitmNjlnZldHQlM1aTlJWDhXejIyQzJDVVU2VUtmOUhp?=
 =?utf-8?B?di9kalA5d2JkK3ZackRRSVBVTi94OEJCejBGYjd4ZXR6aGo5N2ZXVm5BS0pa?=
 =?utf-8?B?Y0E4ZEhZZy9FN25rdTMzNXlQTysyY1Ywb2hIWmVNNVlEMUY3VENGZTZ0Sk5E?=
 =?utf-8?B?cDFMUzNiWFJhc0UzTkVENm01RFB5WkozaEM5WGd6elh4TE5GMTRZU1REVHBy?=
 =?utf-8?B?Z3hBa0xOSU9nSlh1NzB3cVRvSWkyT3g1OVRQVTY0eVk2MUtiRlk4SjJKbEd4?=
 =?utf-8?B?OFgzZ3JacjRWS3J6QTJMMzEzaWNUbGdaUXdyTGdnRG5xRllJSHJsdjdOYVAv?=
 =?utf-8?B?WjVKUVdoMzAzVnJTUlVsSkZVVjRrVXFRcFp2MXJobDBIeDdZVDlEd2VlZ3VF?=
 =?utf-8?B?cDlWTXNJalY4UkVUOGtRUTVSM0o0cGswdXhaWjgzNkRVd0hwYStHT1YvNkor?=
 =?utf-8?B?U0JZRTljeDltVlQ4V282aHBZZGY5Q294aEh3TVNmSjFqY01tc056T0kvYk12?=
 =?utf-8?B?MUVzcTVIdDlhNlAxcWprUEJUeUlZTWF2cklXQlZCejJTemZTbFFsVUlQaUR2?=
 =?utf-8?B?cXM4aGVGZEVGNGZNMjByeDRJck8xTkxvREN1bzJXd3ZmSEFQdkdrNCtUTTZP?=
 =?utf-8?B?elIvTjh3d3pLaythM2M0ZnowdDkxek1OTngxSWdiRXZtam9sZGhpZ2xZdldk?=
 =?utf-8?B?T1h5SmIxK2l0RnFmWDA2NXFmRGpLTGlEVkR5dG1TUUpGTTlzZS9JQU5BRk85?=
 =?utf-8?B?V3BISU1waVBtN0paREpjY1NSSGQyR3ZmdU04VEl6OERHUWZlQmJTMHlKdUNk?=
 =?utf-8?B?UCs2cStRSjdjUk0vSXpGOCtMcHpsVi9PbzRQeUxYeHg0ckx6TFpTdHlIdU9V?=
 =?utf-8?B?WHZmSGNHaDdUQitWK0xTbUVMUDZ6WTEwbzd0bDVSUHFGbzNIemk2UGdsaElN?=
 =?utf-8?B?R1Ixdk80TGljd3oxbnh6bWt0Um9CcElJUlJJZmE1TUU3Nk04eUI4aUFLQnRu?=
 =?utf-8?B?bkUvMDBvdVVuZXFsWFZWK2xhRnU2OUZHWGQwTk5CRkxKODIyd0J4am5WeWhz?=
 =?utf-8?B?Q1F0Y080VDRlOWgxUkJWRjhkKzFXVW14MGFHTjA2SXN6OHZmMWlrcjJDcGEx?=
 =?utf-8?B?YjFNVWZzYUJ5czhCRkVtUUxuT1ZsR3l6a0JqMXlXdVVtNlFhMi9pOFhXRlFO?=
 =?utf-8?B?a0Vjd1ZUeW5LYlVra2JCcnNNdEhNNVhzQm9uby9IRXpXMVc2ZmJBbEd3eVpP?=
 =?utf-8?B?eXJzdjFUUWs4Y09vQzQyM0U5UUNPL2NXaGtDK2FlNnlFVjUxVzE5VVJna2Fu?=
 =?utf-8?B?bUdlcitFOXdKck9YUW93cnVnQkxiYnNwL1dVWWVSTXVaWEpET2dDaXNsMXFS?=
 =?utf-8?B?b0ZUWGZHa0NVQWJFajcwQklOcjE1VDR1cVM1TEp4VWVscHZBS1ZWY1RDUVhw?=
 =?utf-8?B?Qk9BcWF3enJYWlNMZ21QbDMwNk9MbzhOWStKeHZrclFRMERPWHJ5dzJaS1RL?=
 =?utf-8?B?NFVmbVVHTzFmNHBVSXBVcjJ0by8zSU5sbHViUHVhaUJ6dElsZFF3MjNSN1JV?=
 =?utf-8?B?ZU5xY3k4SHlpdnRPckhxb3Z0eWNodFRiZGFRQmtFWkdoVlgvcklIUXZGTDZ0?=
 =?utf-8?B?aUlVK2VJZWRKaEFvSXVsQTVCcWxsbjhrcUZxbzlOcGRlbzlaeTNSUk1tbVFu?=
 =?utf-8?B?RWxGQ0syMGJDd2ptMkI1TmY5UzVhVGtocGNUc3pnMEc5SVY5S1hGRW0waEVl?=
 =?utf-8?B?S0U4QmZmaEhjQytvYUVnak5STXRqQVQrb0JPTzViZkpDbmJoaFRYSlpwZklo?=
 =?utf-8?B?VUYwMC82UjIyQ2g3N3VvZHdQWkRDNDh1MjhmK25YOS95T252SW55azNYanFv?=
 =?utf-8?Q?FvZt7bhZ+bXag+/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CvzxwhQkSNuf7gc7+Z/VxlHSuhrRxPrBF/3NOHZbvnMXQaLChBQqmSn9VMSueao0ja+X9OHvmfH/t7XBPpnIbkctxm9J7ZRrsJaba6QGEEyGsgdTgDY7skfU6sp6wcbUqVUjNm/hgtPdIDDNm8pmyhRvfEmgxE31xoHElla+KwR5906yZ/CTPLuzhxM5shR72PE0ebw61VhUr8TzxNXn9fqnklPbn1k/7ckr0epWMYrg8C0WMXs8c6FfxWDTitaBW83OKK889uXzjiEfui4PHGdxgAIJogX553zT/L0jrk1qdoz75nVYs7jTZ1ijpXo4hPR4bFhWBwG28udqGKXSjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8fa2da-0399-4e80-e4a6-08dee1d9ebac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 18:58:41.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HcKQ1YwgMKAdoL0LA7OHH0sANmAdDBjwDHsQw0u92SRq6AXrDpB4ZfBOP89K3IzUu+02vLi6OwdPjp2OmkcG6Br6+uzwKXq55h81J9mJyhPxfXdw3TrWjIeF8fnDZ8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9483
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:liujiajia@kylinos.cn,m:benjamin.berg@intel.com,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-39115-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,kylinos.cn:email,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D31F175801A

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlhamlhIExpdSA8bGl1
amlhamlhQGt5bGlub3MuY24+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyNiAzOjQx
IEFNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5i
bGl0QGludGVsLmNvbT47IEJlcmcsDQo+IEJlbmphbWluIDxiZW5qYW1pbi5iZXJnQGludGVsLmNv
bT47IEJlcmcsIEpvaGFubmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEppYWppYSBMaXUgPGxpdWppYWppYUBreWxpbm9zLmNuPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIHdpZmk6IGl3bHdpZmk6IHVzZSB1bmlxdWUgdGhlcm1hbCB6b25lIHR5cGUNCj4gDQo+IFVu
bG9hZGluZyBpd2xtbGQgb3IgaXdsbXZtIGNhbiB0cmlnZ2VyIGh1bmcgdGFzayB3aGVuIHR3byBk
ZXZpY2VzIHVzaW5nDQo+IGl3bG12bSBhbmQgaXdsbWxkIHJlc3BlY3RpdmVseSBvbiBvbmUgc2V0
dXAuIFRoZWlyIHRoZXJtYWwgem9uZXMgaGF2ZSB0aGUNCj4gc2FtZSB0eXBlIGFuZCBzaGFyZSB0
aGUgc2FtZSBod21vbiBkZXZpY2UgY3JlYXRlZCBieSB0aGUgZmlyc3Qgem9uZS4gVGhlDQo+IHNl
Y29uZCB6b25lIGluZGlyZWN0bHkgaG9sZHMgdGhlIGZpcnN0IHpvbmUgdGhyb3VnaCBod21vbiBh
bmQgcHJldmVudHMgdGhlIGZpcnN0DQo+IHpvbmUgZnJvbSB1bnJlZ2lzdGVyaW5nLg0KPiBUZXN0
ZWQgd2l0aCBBWDIxMSAoODA4Njo3YWYwKSBhbmQgQkUyMDAgKDgwODY6MjcyYikuDQo+IA0KPiBJ
TkZPOiB0YXNrIG1vZHByb2JlOjUyOTUgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRz
Lg0KPiAgICAgICBOb3QgdGFpbnRlZCA3LjAuMC1yYzItdXAxICMyDQo+IENhbGwgVHJhY2U6DQo+
ICBfX3NjaGVkdWxlKzB4NGRmLzB4ZmQwDQo+ICBzY2hlZHVsZSsweDI3LzB4ZDANCj4gIHNjaGVk
dWxlX3RpbWVvdXQrMHhiZC8weDEwMA0KPiAgX193YWl0X2Zvcl9jb21tb24rMHg5Ny8weDFiMA0K
PiAgPyBfX3BmeF9zY2hlZHVsZV90aW1lb3V0KzB4MTAvMHgxMA0KPiAgdGhlcm1hbF96b25lX2Rl
dmljZV91bnJlZ2lzdGVyKzB4MTczLzB4MWMwDQo+ICBpd2xfbWxkX3RoZXJtYWxfZXhpdCsweGJi
LzB4ZDAgW2l3bG1sZF0NCj4gIGl3bF9vcF9tb2RlX21sZF9zdG9wKzB4MzcvMHgxMjAgW2l3bG1s
ZF0NCj4gIGl3bF9vcG1vZGVfZGVyZWdpc3RlcisweGMwLzB4MTYwIFtpd2x3aWZpXQ0KPiAgX19k
b19zeXNfZGVsZXRlX21vZHVsZSsweDFiNS8weDMyMA0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlh
amlhIExpdSA8bGl1amlhamlhQGt5bGlub3MuY24+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdXRpbHMuYyAgIHwgMTAgKysrKysrKysrKw0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdXRpbHMuaCAgIHwgIDQgKysrKw0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdGhlcm1hbC5jIHwgIDQg
KystLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYyAgICAg
IHwgIDYgKysrKy0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9pd2wtdXRpbHMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvaXdsLXV0aWxzLmMNCj4gaW5kZXggZDUwMzU0NGZkYTQwLi5mZTVmYTVlNTk2NjQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXV0aWxzLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdXRpbHMuYw0K
PiBAQCAtMTkzLDMgKzE5MywxMyBAQCBzOCBpd2xfYXZlcmFnZV9uZWdfZGJtKGNvbnN0IHU4ICpu
ZWdfZGJtX3ZhbHVlcywNCj4gdTggbGVuKQ0KPiAgCXJldHVybiBjbGFtcChhdmVyYWdlX21hZ25p
dHVkZSAtIGksIC0xMjgsIDApOyAgfQ0KPiBJV0xfRVhQT1JUX1NZTUJPTChpd2xfYXZlcmFnZV9u
ZWdfZGJtKTsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19USEVSTUFMDQo+ICt1OCBpd2xfdGhlcm1h
bF96b25lX2dldF9pZCh2b2lkKQ0KPiArew0KPiArCXN0YXRpYyBhdG9taWNfdCBjb3VudGVyID0g
QVRPTUlDX0lOSVQoMCk7DQo+ICsNCj4gKwlyZXR1cm4gYXRvbWljX2luY19yZXR1cm4oJmNvdW50
ZXIpICYgMHhGRjsgfQ0KPiArSVdMX0VYUE9SVF9TWU1CT0woaXdsX3RoZXJtYWxfem9uZV9nZXRf
aWQpOw0KPiArI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2l3bC11dGlscy5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9pd2wtdXRpbHMuaA0KPiBpbmRleCA1MTcyMDM1ZTRkMjYuLjg0YTQ1NDNmZDI5MCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdXRpbHMu
aA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC11dGlscy5o
DQo+IEBAIC01NSw0ICs1NSw4IEBAIHUzMiBpd2xfZmluZF9pZV9vZmZzZXQodTggKmJlYWNvbiwg
dTggZWlkLCB1MzIgZnJhbWVfc2l6ZSkNCj4gDQo+ICBzOCBpd2xfYXZlcmFnZV9uZWdfZGJtKGNv
bnN0IHU4ICpuZWdfZGJtX3ZhbHVlcywgdTggbGVuKTsNCj4gDQo+ICsjaWZkZWYgQ09ORklHX1RI
RVJNQUwNCj4gK3U4IGl3bF90aGVybWFsX3pvbmVfZ2V0X2lkKHZvaWQpOw0KPiArI2VuZGlmDQo+
ICsNCj4gICNlbmRpZiAvKiBfX2l3bF91dGlsc19oX18gKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3RoZXJtYWwuYw0KPiBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3RoZXJtYWwuYw0KPiBpbmRleCBmOGE4YzM1
MDY2YmUuLjUwMDAyOGE0ZGJkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvdGhlcm1hbC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbWxkL3RoZXJtYWwuYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gICNpZmRl
ZiBDT05GSUdfVEhFUk1BTA0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvcnQuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC90aGVybWFsLmg+DQo+ICsjaW5jbHVkZSAiaXdsLXV0aWxzLmgiDQo+ICAjZW5kaWYN
Cj4gDQo+ICAjaW5jbHVkZSAiZncvYXBpL3BoeS5oIg0KPiBAQCAtMjQzLDcgKzI0NCw2IEBAIHN0
YXRpYyB2b2lkIGl3bF9tbGRfdGhlcm1hbF96b25lX3JlZ2lzdGVyKHN0cnVjdA0KPiBpd2xfbWxk
ICptbGQpICB7DQo+ICAJaW50IHJldDsNCj4gIAljaGFyIG5hbWVbMTZdOw0KPiAtCXN0YXRpYyBh
dG9taWNfdCBjb3VudGVyID0gQVRPTUlDX0lOSVQoMCk7DQo+ICAJc3RydWN0IHRoZXJtYWxfdHJp
cCB0cmlwc1tJV0xfTUFYX0RUU19UUklQU10gPSB7DQo+ICAJCVswIC4uLiBJV0xfTUFYX0RUU19U
UklQUyAtIDFdID0gew0KPiAgCQkJLnRlbXBlcmF0dXJlID0gVEhFUk1BTF9URU1QX0lOVkFMSUQs
IEBAIC0yNTQsNw0KPiArMjU0LDcgQEAgc3RhdGljIHZvaWQgaXdsX21sZF90aGVybWFsX3pvbmVf
cmVnaXN0ZXIoc3RydWN0IGl3bF9tbGQgKm1sZCkNCj4gDQo+ICAJQlVJTERfQlVHX09OKEFSUkFZ
X1NJWkUobmFtZSkgPj0gVEhFUk1BTF9OQU1FX0xFTkdUSCk7DQo+IA0KPiAtCXNwcmludGYobmFt
ZSwgIml3bHdpZmlfJXUiLCBhdG9taWNfaW5jX3JldHVybigmY291bnRlcikgJiAweEZGKTsNCkFu
eSByZWFzb24gbm90IHRvIGhhdmUgaXdsbWxkIChhbmQgaXdsbXZtIGluIG12bSkgaW5zdGVhZCBv
ZiBhIHNoYXJlZCBjb3VudGVyPw0KDQo+ICsJc3ByaW50ZihuYW1lLCAiaXdsd2lmaV8ldSIsIGl3
bF90aGVybWFsX3pvbmVfZ2V0X2lkKCkpOw0KPiAgCW1sZC0+dHpvbmUgPQ0KPiAgCQl0aGVybWFs
X3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMobmFtZSwgdHJpcHMsDQo+ICAJCQkJCQkJ
SVdMX01BWF9EVFNfVFJJUFMsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS90dC5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vdHQuYw0KPiBpbmRleCA1M2JhYjIxZWJhZTIuLmVhOGU2MTYxNzRkYiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90dC5jDQo+IEBAIC03
LDYgKzcsOSBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvcnQuaD4NCj4gDQo+ICAjaW5jbHVkZSAi
bXZtLmgiDQo+ICsjaWZkZWYgQ09ORklHX1RIRVJNQUwNCj4gKyNpbmNsdWRlICJpd2wtdXRpbHMu
aCINCj4gKyNlbmRpZg0KPiANCj4gICNkZWZpbmUgSVdMX01WTV9OVU1fQ1REUF9TVEVQUwkJMjAN
Cj4gICNkZWZpbmUgSVdMX01WTV9NSU5fQ1REUF9CVURHRVRfTVcJMTUwDQo+IEBAIC02NTIsNyAr
NjU1LDYgQEAgc3RhdGljIHZvaWQgaXdsX212bV90aGVybWFsX3pvbmVfcmVnaXN0ZXIoc3RydWN0
DQo+IGl3bF9tdm0gKm12bSkgIHsNCj4gIAlpbnQgaSwgcmV0Ow0KPiAgCWNoYXIgbmFtZVsxNl07
DQo+IC0Jc3RhdGljIGF0b21pY190IGNvdW50ZXIgPSBBVE9NSUNfSU5JVCgwKTsNCj4gDQo+ICAJ
aWYgKCFpd2xfbXZtX2lzX3R0X2luX2Z3KG12bSkpIHsNCj4gIAkJbXZtLT50el9kZXZpY2UudHpv
bmUgPSBOVUxMOw0KPiBAQCAtNjYyLDcgKzY2NCw3IEBAIHN0YXRpYyB2b2lkIGl3bF9tdm1fdGhl
cm1hbF96b25lX3JlZ2lzdGVyKHN0cnVjdA0KPiBpd2xfbXZtICptdm0pDQo+IA0KPiAgCUJVSUxE
X0JVR19PTihBUlJBWV9TSVpFKG5hbWUpID49IFRIRVJNQUxfTkFNRV9MRU5HVEgpOw0KPiANCj4g
LQlzcHJpbnRmKG5hbWUsICJpd2x3aWZpXyV1IiwgYXRvbWljX2luY19yZXR1cm4oJmNvdW50ZXIp
ICYgMHhGRik7DQo+ICsJc3ByaW50ZihuYW1lLCAiaXdsd2lmaV8ldSIsIGl3bF90aGVybWFsX3pv
bmVfZ2V0X2lkKCkpOw0KPiAgCS8qDQo+ICAJICogMCBpcyBhIHZhbGlkIHRlbXBlcmF0dXJlLA0K
PiAgCSAqIHNvIGluaXRpYWxpemUgdGhlIGFycmF5IHdpdGggUzE2X01JTiB3aGljaCBpbnZhbGlk
IHRlbXBlcmF0dXJlDQo+IC0tDQo+IDIuNTMuMA0KDQo=

