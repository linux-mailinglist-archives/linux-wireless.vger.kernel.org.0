Return-Path: <linux-wireless+bounces-37356-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dsPiAZE8IGokzAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37356-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 16:39:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC9638AE6
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 16:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bePxWgs2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37356-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37356-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CBC6300753B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3BF27466A;
	Wed,  3 Jun 2026 14:32:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721D282F39
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 14:32:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497121; cv=fail; b=TxxDQvnhICywbKhBS9UL8+5WsalcKpf8ZDE/vY/LPXcAeDLypF83wilxui+NnOqR8Ik7Geq0/D3Vcn8EAxbnltZwjZAQ4aoSBGaJ5g4RucIFgvJfwdy0kX9qpVbQxZMECrvoQxDTEYqPNlNoX2bbK6vVhMutkHd9k6q3BD2ARz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497121; c=relaxed/simple;
	bh=buPNThqSHPzC5YKdQbboWvEuMhlLGNqlhTAPtAZao5o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CK5D1dMLP71oitB7+fQU7SaXkV8+zxbSUJXYk7oUGzBswTfxROfXUDfQjlOpPRYcBuTqG56HtbCnd2UAVtwFYPquVmTgP/OUjWrybahlmYsaG3WkEE4295eSuIFlWGwIFiqaPhaA3lUOSOnD7nHlxjTax2G/QyQdlSdeGPWMD9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bePxWgs2; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780497120; x=1812033120;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=buPNThqSHPzC5YKdQbboWvEuMhlLGNqlhTAPtAZao5o=;
  b=bePxWgs2jxsfZzSKmp2uFu4PA/NLLefmp/pS22v4P6FeAyFHSVavCp12
   wtEnUHvkkBYihT61D2QQu/ux1gje2kK58vR7YpWi+HsDYFBUSOfG1TrZl
   +C8bXsoWe44NRVYUU+o9oXHNEA/3hhv7fp9serNwSxCBzv780MXu2mdRk
   gLvkYwMZNTvR0NpUxe4kyYUrARIeEyr7s5EdZ4JbFbn40giSqa6cEP0+2
   0g20ZqGH4Egg9+hDcnkbu6O9+zsP9jO+7ddDYJYWWlC51lMHAB7SonLDk
   upvJGzXZMpnUs2GikCVlPlk2aW/87zkc41tUR9iRFizIyBu5R/CL6GfwV
   Q==;
X-CSE-ConnectionGUID: jR768IAcTfmbRbyacqaS9Q==
X-CSE-MsgGUID: JfzHpiI0TxuTuPeAOVE94A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91881837"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91881837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:32:00 -0700
X-CSE-ConnectionGUID: NiCln7GaSoKTzRCYMBKfWA==
X-CSE-MsgGUID: 3DaC+QsmTZumicg4MnQ6Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244106460"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:31:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:31:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:31:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:31:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu243Ej/JTJS2yvenvhj9SmoSBIKwzC9TLkRy5lGGx0tB9pUUbzZBZnYObA/GQGpJoIJBKF9WQGJMKSThLKE9HIZFVWh14lHYJ6SrjpbfOKEKN35BFdAXLYTcBApNU2jeSV/YhpvMyUUzLt5qrf8sNJcP9xLr1u33T2vDxgYHb/aEZrGS/cpUl4iYqba2Bu68wdhj6n2araIYj7yoCPYGMxZM7/Frl7TWEkpa1pJ5SfuNaAnfiThIibmYKMEi8wwLxPndSW2g6FWnQboUskgEPmKEAFpdcTqzYkMEqrel0kzkeyte0IWEaWOPorVDuOx6MPWQMvpU7IoXfmZhRhpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buPNThqSHPzC5YKdQbboWvEuMhlLGNqlhTAPtAZao5o=;
 b=ZPyLFEp6HckrXJIYk5lePpdAY5ZvpVn+iPUww+G9S78+rQu9dHzYrvDN4IJa3Dya6ITNL7lz09hU9zPhtkyeLfJiHgT+7p2v4mmDfu28bXzSNMAui6GfI6fviSm/t7NqsaoZT55N97iK+fbVgYb/Zw1wAkMGwtQBzqy0MxNcivMdg4fi1WGGYtfqisZb+1l4cuhdTDFOikrQC2WP9sdDnT71MK53GQwbIWq/ZBIJhdUT9VRhkWi9p5wxXJM4/+r8fF+9Mhlt5kTxgUhXmLJxIgfuGAZBQgVAX17HmI2QxSzmDVWSdlsfiI3o4GoXVQ7+2BjeL8DlwLpHyM4uFnVdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:31:51 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:31:50 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2026-06-03
Thread-Topic: pull-request: iwlwifi-next-2026-06-03
Thread-Index: AdzzZY0L3X1s3Sc/RyK40SXaNiVykQ==
Date: Wed, 3 Jun 2026 14:31:50 +0000
Message-ID: <DS0PR11MB78800BE36F7F51BF24238474A3132@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|SJ0PR11MB8270:EE_
x-ms-office365-filtering-correlation-id: 9695277d-d04c-4698-d037-08dec17cd992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|18002099003|38070700021|11063799006|3023799007|56012099006;
x-microsoft-antispam-message-info: nmcTKxwprLg1VM3NHDLXGINlex5p+qB/HjfglHfLjFxKLtIQHbhOOyJoGH/Oom8V2bN8EKDcJ75rL3NBWO1776bMvhQCUsGJHnk4JLwL5XFLylZ4dkiJxSZ00GH2Ind/ZpgwcU86FrzsazfYEeu2ise16XUWidt4CM0rv7kJU3tTX6ysIQmMWE3CqvkMkaAd6HJGYDvMbz673ZTZbmnPEJtzhoU50mrXQUIsgwUJUGOx372fzLYwbgDDSuIzJEq842McLDC5EJwcx6yR0pZ7AeCfAyiWgK4BIdAfQxe8055T7C+0KefPrJya84aRsKbJSmlHwi3mYPmrocea7Wn0E9T+VL6fV6ANFcTnfBTJIPst/i1sHCwJpx0sRHglHvwQVO+Ke+Mba1fLYC5B4Y/Nwrpsa71kaZ8+mK3W0V6HK78L5XclO6vF4BzT7r97ji254BLrxn1IVBJ6dmUybj3RLEQYsSlOLSpH9IFo17ofIN014oYSRTQB/70ExW2n0VeQ/Q2OT7e2pg2cWxuUS5bV8QSOvpBjdwFtaQdIbCGc0VuNXkGPQ5GdKZ9m27AcI4kSdN6Zq8R4R95a/LRnGHvTQvzHnMg7VJmzWpHA64xfapassQryqnZ+VcvJhVJxNmLw9XDewN7/4L1/FcrLS+DD6yGHPGsY0MwGCW+sv6uS9rN0OJ2KoNLqfLxzwnnDqlcn4s6vnnI/D4ddsT61ntXh2JL7X6lFNv5LQdho6LdSB5bgZD21cRoSPbFygkge2+vu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(18002099003)(38070700021)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVM0SE83SVhReDhVU296KzAwU0lPOTcwSVFKcFZRbjl5NUlvZlMzTFZVZkln?=
 =?utf-8?B?RG1YRjNUeDhwQjA0ZThGN0VINmVFUklDSWVSUGlOeXo1bG1LK2ZaeWF6cGp1?=
 =?utf-8?B?SzNQdENrVFRpYjRQUXVwUkZONGhlZlVOSHFKQndIUEdyemxzWVhaeDdiM0Jl?=
 =?utf-8?B?NFJhTXJuK3BTeXowUGNzMVZNb1Y5OFJHOTdNaUFsVU5HSEgzZWUvdThqeXFq?=
 =?utf-8?B?WkU3cXJrR3EzazMydi9OYytFQjlRZWVJejJsUGxDNVFmUVFKL0ZpaXBZd3ll?=
 =?utf-8?B?dGZ6dUt1Q0xsREVOT2ZoMFkyNWdMQjFucTYxS3BiRUpFRy80d2lSTjRyUDM3?=
 =?utf-8?B?amlyN0FJT0VNOEVyc3hMNHp4aEdPeDN1SFgyYXg0eksxbUVaNmx6RExzNlJB?=
 =?utf-8?B?ZkREVHVCY09NR1F1NFV2SnlnZDl1OXdYdXEzaHU0YlhPcFVGVEk1cU9qTGsv?=
 =?utf-8?B?NmxiblFKdy9yVThuUG1LMHA2ZVMvU0preTBoMkRuSmQrRjBJSGY0VXhDQ3BR?=
 =?utf-8?B?Qy9YcFJlTFZFUlM2cHZWVUJWbDgrR2YrSElFa1hVd01EaFJ2MmJzK1VYNUJy?=
 =?utf-8?B?OUJtMHd1bHcwcjBLTzUwOXBYRFV3dU9CMzZObktGNElLamJsUUI5MXVsR1li?=
 =?utf-8?B?cHlvTTRLMnVYeGRVN1ZMVG1HUkgrK0h1WnVsOXlQSk54L09wNXZtUlo3SWhl?=
 =?utf-8?B?Z09NV1NsSXpNclplUzAxOVZmOC9lSFpwaWo3YkFEMVhvMldWRDlHRWhJVkxm?=
 =?utf-8?B?SXJ3aTJYU0YyRW13UnlZVU9VTU14ZXo4K0Izam1DNERZUFkvRUdwc2l0MmZk?=
 =?utf-8?B?V1g3cDlRL2tOMVdFRlRJeCtRaitmNUZDR0ZlYlZSeklrdFpoc3FBSmdVMlly?=
 =?utf-8?B?RlMwQkdTZFpFYkZRamkrKytLN1RjRnI4Uld5ZSt3QUNscHVWRDlJdk1VQkFF?=
 =?utf-8?B?a1VPTkRucTFPNGNJR0h0dEdkTFp2aCtNZk1DcHg4S25DQVR5Qk5tTHhZTVBa?=
 =?utf-8?B?VC85SGVyekg3MFg3K2RETndpQitITkhiRVJORTRSbW5STkVmUlJKQjlNZTVl?=
 =?utf-8?B?L1kvd0hyaWFKSkNGdEgyN28vODA1WXlXVW1ualdPUUhjeG5GTTM0MkdqdXRk?=
 =?utf-8?B?RGhoa3VKUS9Fbnd6MkR3MHV5ZjNUSUZGWFAwcGQ5Vi9pakR6OWNTVXBWcDFn?=
 =?utf-8?B?Um1XUU1HVUdXZUJWcTd2cGNlOXQ3SXd0d051S1VhUmJlRE9MaUNEY2RsOE10?=
 =?utf-8?B?RWROY2dqdWlzc29JRTRjQ096b2V5dis1dFd5MEh1NGdWb2toMzJKdEpGMlpj?=
 =?utf-8?B?KzhCR2RKVHJUNExjcFprTkRRdjFhSElST0kwSkpwTXdZSlhHakdEdW9uZ2VO?=
 =?utf-8?B?QlhkMDZWRU82ZjdET3V4ejhUeVFSdERSK0txWUdVKzF3SUduQjYwajZBL0Vx?=
 =?utf-8?B?UXlEcC9ITkQwWUkrOExjSEh4blNjclFOdmNDU0x2Vy95WkpSVU9FTTdmTUdY?=
 =?utf-8?B?Sk92b3M0WHFXZTlwR0xJWEREWFdvRkV1ZU9Yckl0OWtoSWVGalErY050T09x?=
 =?utf-8?B?Z1B5cVlSUmFKeFhZMWZUS1k3S0tncXM1Tlhvbm5yQXQzbFRJSWJpenpSV3pQ?=
 =?utf-8?B?R0ZicVJBdDZaQUJoejhYMFNMbTA2SnVaMHhjWEI5WjVmOEVaa0VxdXp3RjJD?=
 =?utf-8?B?NGZuUzhrQ0RWL05IY3owUE5zVHJXdGhYb1hHWmFNTkJRNDl2Qjk2blZURHFY?=
 =?utf-8?B?WXJqTGFJWVhqa3NhaE55K0VBRkpnRzJsbkw1V0VOaE9OVUpoMktuaUYrcUhs?=
 =?utf-8?B?SUZpNkhTT3YrM1dBNERwcnQ1d1pkMWJ2Y3Mvc2hVa1NrV1Rab2dZclhEU2Fz?=
 =?utf-8?B?VHc0aVM2R2lrTkI0bTFxNXkvczJYSXc3TWZQQ0MvV1VudVJBNDFYNVV2eWM1?=
 =?utf-8?B?a1pxUGsvUWJicnlueTF5WE1lYnAzcCtOdytrYVF0Q3pqemRvcFZFeU4zak1Q?=
 =?utf-8?B?NmF5SHhYVnJsSyt0aU8xS3hYamNiQjlrZGhhRlZwdlNKU3ZmNXRUM3kxWkR3?=
 =?utf-8?B?Q0dybzFzMytGRFovV1NTT0FTWG1sWUdlT1lkQ1hLVVJKL2Y0bkhMQlVNYUsr?=
 =?utf-8?B?eU9JYy9TNmtCNDBKckdSRkxpZVp5bUpyTDNLRFVKNnY3Tk5Bd3lRRnFNYmM5?=
 =?utf-8?B?OEdJV1Fha1NpbVFVNHVXUWt5YjFBY3o2dzloNW9TcEZ0bXJJR2NVaVR2K1lh?=
 =?utf-8?B?ZHlHK0xLS0pOOGFyQlhGWkFPQWtScTAvbDU4V3l3L2M2bW8zWDh5TEFSeDF1?=
 =?utf-8?B?dnRzQnhZL1I4ZjB1WkNCcTVacXZLanFQRnFkT2N0a2dQcUREM0VzUkd6T3dU?=
 =?utf-8?Q?7efsFi5F5MBv2334=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HzmWUl2rLvnb4CCWws/5mJz3u+aUa7LTvnj2b9yNecRNLg4VePZE0svdmKkg0OMNULzMV89zhPeqF7eI586gVa9VcmmQ2LeeVWDqiyeKC9Bac/213E8e1KGHcjrld+smkvN8O5W+2HAZN2Va7aXFrZWoF2pUqobwqZV9+assyJZbc/xmUIjXHTJ/72UWDE1ShbzpamqO1tn52sp+HonAPRBF7IZ9pi5CfmHbFT3vTdneFtB6Jl8NuR8MYfUNJKrV+b/GD6Cu2saltUFWQdsjZ8CX2N7qaFk23bB+q8o6c0bRTbLHLBh1oB0vV0DJtyZBuGpAEy/GSZFtNv5Gy0XAqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9695277d-d04c-4698-d037-08dec17cd992
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 14:31:50.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiriyvIM15i/PjXOA6CIVSvxZCPMLU2a9loAYwf//t2wshQbNQzI+LK2T231IXW5kF4QkzIDFTFPsxrF8ufaZ3n4V+X5kj16vkm5GU1gQVb3mamirGON4kDzXEklfp9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-37356-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89EC9638AE6

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2YWRlZDZjMTA0OTBkNWIyNDMyNWU0
NmYyMmIzMjc4NzZiNjY5ZjcyOg0KDQogIE1lcmdlIHRhZyAncnR3LW5leHQtMjAyNi0wNi0wMycg
b2YgaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9ydHcgKDIwMjYtMDYtMDMgMTQ6MTI6MTEgKzAy
MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvaXdsd2lm
aS1uZXh0LmdpdC8gdGFncy9pd2x3aWZpLW5leHQtMjAyNi0wNi0wMw0KDQpmb3IgeW91IHRvIGZl
dGNoIGNoYW5nZXMgdXAgdG8gYTYxMzZjYTJkZDk3NzNkNmJjZDQ1ZTgyOTA0MDM1MzZjOWM3MTA1
NDoNCg0KICB3aWZpOiBpd2x3aWZpOiBidW1wIG1heGltdW0gY29yZSB2ZXJzaW9uIGZvciBCWi9T
Qy9EUiB0byAxMDYgKDIwMjYtMDYtMDMgMTc6MDI6NTUgKzAzMDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCndpZmk6
IGl3bHdpZmktbmV4dCA6IHVwZGF0ZXMgLSAyMDI2LTA2LTAzDQoNClRoaXMgcHVsbCByZXF1ZXN0
IGNvbnRhaW5zIGl3bHdpZmkgZmVhdHVyZXMgYW5kIGNsZWFudXBzLiBOb3RhYmx5Og0KDQotIEJ1
bXAgbWF4IGNvcmUgdmVyc2lvbiBmb3IgQlovU0MvRFIgdG8gMTA2Lg0KLSBBZGQgS1VuaXQgdGVz
dHMgZm9yIGxpbmsgZ3JhZGluZywgUlNTSSBhZGp1c3RtZW50LCBhbmQgYmVhY29uDQogIGhhbmRs
aW5nOw0KLSBEcm9wIGNvcmUxMDEgc3VwcG9ydCBhbmQgcmVtb3ZlIFRMQyBjb25maWcgdjQvdjUg
Y29tcGF0aWJpbGl0eSBjb2RlLg0KLSBGaXhlczoNCiAgICAgICAgRml4IFBDSWUgd3JpdGUgcG9p
bnRlciBkZXRlY3Rpb24NCiAgICAgICAgRml4IFNURVBfVVJNIHJlZ2lzdGVyIGFkZHJlc3MNCiAg
ICAgICAgUmVtb3ZlIHVubmVlZGVkIFdvV0xBTiB3YXJuaW5nDQogICAgICAgIHJlZHVjZSBOSUMg
d2FrZXVwcyBkdXJpbmcgZHVtcC4NCiAgICAgICAgUmV2ZXJ0IE1PRFVMRV9GSVJNV0FSRSByZWxv
Y2F0aW9uIGNoYW5nZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBdmluYXNoIEJoYXR0ICgzKToNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogYWRkIEtVbml0IHRlc3RzIGZvciBkdXBsaWNhdGVkIGJlYWNvbiBSU1NJ
IGFkanVzdG1lbnQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogYWRkIEtVbml0IHRlc3RzIGZv
ciBQU0QvRUlSUCBSU1NJIGFkanVzdG1lbnQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogYWRk
IEtVbml0IHRlc3RzIGZvciBsaW5rIGdyYWRpbmcNCg0KRW1tYW51ZWwgR3J1bWJhY2ggKDIpOg0K
ICAgICAgd2lmaTogaXdsd2lmaTogYWRkIHN1cHBvcnQgZm9yIEFYMjMxDQogICAgICB3aWZpOiBp
d2x3aWZpOiBidW1wIG1heGltdW0gY29yZSB2ZXJzaW9uIGZvciBCWi9TQy9EUiB0byAxMDYNCg0K
SWxhbiBQZWVyICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogUmVxdWlyZSBIVCBzdXBw
b3J0IGZvciBOQU4NCg0KSXNyYWVsIEtveml0eiAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBt
bGQ6IHN1cHBvcnQgRlcgVExWIGZvciBOQU4gbWF4IGNoYW5uZWwgc3dpdGNoIHRpbWUNCg0KSm9o
YW5uZXMgQmVyZyAoNik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBmdzogY3V0IGRvd24gTklDIHdh
a2V1cHMgZHVyaW5nIGR1bXANCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogcmVuYW1lIGl3bF9t
dm1fbWFjODAyMTFfaWR4X3RvX2h3cmF0ZSgpDQogICAgICB3aWZpOiBpd2x3aWZpOiBtb3ZlIGl3
bF9md19yYXRlX2lkeF90b19wbGNwKCkgdG8gbXZtDQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6
IGRvbid0IFdBUk4gb24gV29XTEFOIHN1c3BlbmQgdy9vIG5ldGRldGVjdA0KICAgICAgd2lmaTog
aXdsd2lmaTogbXZtOiBmaXggUDJQLURldmljZSBiaW5kaW5nIGhhbmRsaW5nDQogICAgICB3aWZp
OiBpd2x3aWZpOiBwY2llOiBmaXggd3JpdGUgcG9pbnRlciBtb3ZlIGRldGVjdGlvbg0KDQpNaXJp
IEtvcmVuYmxpdCAoNyk6DQogICAgICB3aWZpOiBpd2x3aWZpOiByZW1vdmUgc3RhbGUgY29tbWVu
dA0KICAgICAgd2lmaTogaXdsd2lmaTogcmVtb3ZlIG12bSBwcmVmaXggZnJvbSBtYXJrZXIgY29t
bWFuZA0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBmaXggc21hdGNoIHdhcm5pbmcNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1sZDogYWx3YXlzIGFsbG93IG1pbW8gaW4gTkFODQogICAgICB3aWZp
OiBpd2x3aWZpOiBmaXggYSB0eXBvDQogICAgICB3aWZpOiBpd2x3aWZpOiB0cmFuczogZXhwb3J0
IHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBoY21kIHNpemUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12
bTogcmVtb3ZlIF9fbXVzdF9jaGVjayBhbm5vdGF0aW9uIGZyb20gY29tbWFuZCBzZW5kaW5nDQoN
Ck1vcml5YSBJdHpjaGFraSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBmaXggU1RFUF9VUk0g
cmVnaXN0ZXIgYWRkcmVzcyBmb3IgU0MgZGV2aWNlcw0KDQpQYWdhZGFsYSBZZXN1IEFuamFuZXl1
bHUgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBzZXQgZmFzdC1iYWxhbmNlIHNjYW4g
Zm9yIGFjdGl2ZSBFTUxTUg0KDQpTaGFoYXIgVHphcmZhdGkgKDQpOg0KICAgICAgd2lmaTogaXds
d2lmaTogY2ZnOiBSZXZlcnQgIndpZmk6IGl3bHdpZmk6IGNmZzogbW92ZSB0aGUgTU9EVUxFX0ZJ
Uk1XQVJFIHRvIHRoZSBwZXItcmYgZmlsZSINCiAgICAgIHdpZmk6IGl3bHdpZmk6IHJlbW92ZSBv
cnBoYW5lZCBEQzJEQyBjb25maWcgZW51bQ0KICAgICAgd2lmaTogaXdsd2lmaTogc3RvcCBzdXBw
b3J0aW5nIGNvcmUxMDENCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogZHJvcCBUTEMgY29uZmln
IGNtZCB2NC92NSBjb21wYXQgY29kZQ0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9jZmcvYnouYyAgICAgICAgfCAgMTYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2NmZy9kci5jICAgICAgICB8ICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvY2ZnL3JmLWZtLmMgICAgIHwgIDEyIC0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi1nZi5jICAgICB8ICAgMyArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL3NjLmMgICAgICAgIHwgICA0ICstDQogLi4uL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9jb21tYW5kcy5oICAgfCAgIDQgKy0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9jb25maWcuaCB8ICAxMSAr
LQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvZGF0YXBhdGguaCAgIHwg
ICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvZGVidWcu
aCAgfCAgMTYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9y
cy5oICAgICB8ICAzNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
ZGJnLmMgICAgICAgIHwgIDk2ICsrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9mdy9maWxlLmggICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvZncvaW1nLmggICAgICAgIHwgICAxICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L3JzLmMgICAgICAgICB8ICAyNyAtLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvaXdsLWNvbmZpZy5oICAgIHwgICA2ICstDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtZHJ2LmMgICAgICAgfCAgIDYgKw0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXBycGguaCAgICAgIHwgICAzICstDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuYyAgICAgfCAgIDUgKw0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmggICAgIHwgIDE1
ICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kMy5jICAgICAgICB8
ICAgNyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2xpbmsuYyAg
ICAgIHwgIDE1ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbGlu
ay5oICAgICAgfCAgIDYgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L21hYzgwMjExLmMgIHwgICA5ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tbGQvbmFuLmMgICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL21sZC9zY2FuLmMgICAgICB8ICAgOCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbWxkL3N0YS5jICAgICAgIHwgICA2ICsNCiAuLi4vaW50ZWwvaXdsd2lmaS9t
bGQvdGVzdHMvbGluay1zZWxlY3Rpb24uYyAgICAgICB8IDI4MCArKysrKysrKysrLS0NCiAuLi4v
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3Rlc3RzL2xpbmsuYyAgICB8IDQ3NCArKysr
KysrKysrKysrKysrKysrKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3Rl
c3RzL3V0aWxzLmMgICB8ICA2MCArKysNCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bWxkL3Rlc3RzL3V0aWxzLmggICB8ICAgOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbWxkL3RsYy5jICAgICAgIHwgIDc0IC0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL21sZC90eC5jICAgICAgICB8ICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2JpbmRpbmcuYyAgIHwgICA1ICstDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYyAgfCAgIDYgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jICB8ICAxMiArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgIHwgIDI2
ICstDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90aW1lLWV2ZW50LmMgICAg
fCAgIDMgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90eC5jICAg
ICAgICB8ICAxMCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3V0
aWxzLmMgICAgIHwgIDMyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9w
Y2llL2Rydi5jICAgICAgfCAgIDMgKy0NCiAuLi4vd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L2dlbjFfMi9pbnRlcm5hbC5oICB8ICAgMSArDQogLi4uL2ludGVsL2l3bHdpZmkvcGNpZS9nZW4x
XzIvdHJhbnMtZ2VuMi5jICAgICAgICAgfCAgMTIgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvcGNpZS9nZW4xXzIvdHJhbnMuYyB8ICAgNyArLQ0KIDQzIGZpbGVzIGNoYW5nZWQs
IDEwMzEgaW5zZXJ0aW9ucygrKSwgMzA2IGRlbGV0aW9ucygtKQ0K

