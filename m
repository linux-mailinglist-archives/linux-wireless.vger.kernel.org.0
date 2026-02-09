Return-Path: <linux-wireless+bounces-31655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOfhHU+UiWlj/AQAu9opvQ
	(envelope-from <linux-wireless+bounces-31655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:01:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7A10CB1D
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC2B3001FCE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFA2D8762;
	Mon,  9 Feb 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IahHHq1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49E1FBEA6;
	Mon,  9 Feb 2026 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624077; cv=fail; b=LoHfHMT57dt9F+SUU+tBf5gWXG1r3wdkw6YHSOONW/43lYLFUjPG4zSTmxR9vbMELF2BcDm9CbV9heq8XYyz/1NcAV4lwSw5EhSiR2Wz7EFM8sJ8JaIa0r4hP519+t3lqDkE0NJe6xdcwi2Z48CumivutAzwdpXVnLKqANs3p+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624077; c=relaxed/simple;
	bh=9w+8RnKjFfrX7YD140Nhh0VaJlXhrXlrADlJyoYRQKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2b5Eg5QZMED/5E75P0cCPZ5Cbv2NuDoUUq13bORxVr6gDOv/UNTJ7fKQZQSydhsMzupTEZqyDRlaoWG6iTSOFyBMsiEZrrSmwlp2V0f91YTG3xsmTwaB5vFkkx8xXO3Fx+OIiU294FFKNBObdTNS6U7rFC/WHzbPhOaIJbQDug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IahHHq1x; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770624076; x=1802160076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9w+8RnKjFfrX7YD140Nhh0VaJlXhrXlrADlJyoYRQKs=;
  b=IahHHq1xRGRRe7V+NEhx/h89J6/yx4j001hteAwrt7nUEhOPosiQyFex
   siuyhi6JHZbRKLNShgULXeOkXfXZaGf60z1aCceCeV+JvkjmJv/cau96v
   /if/2uDtBrUkautmRLB+NTaJkX6osVZL2MVSN8I64g2S8kf9c7Z5G/gdP
   xjIz77N1Lm3W57n8Tsw0Af53InXR6dZ/UwAsxTmqeuujai2kw5UqWe5iH
   aXDXs86yjsqTnathwMcGY3FhNpzpnc9x+A3e3Qdl2672QxHimOvWxtaZz
   ZP70WPqM8vHuXH/bDvoWMU6iOaP+73Rv4atmGxI3e4TbEbFhE08FwKMnq
   Q==;
X-CSE-ConnectionGUID: vCYwEixATUO5HY3KLfIEuQ==
X-CSE-MsgGUID: 3Y69SYhRQiabRAXpJ/q4wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82464036"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="82464036"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:01:16 -0800
X-CSE-ConnectionGUID: k35Wgv9DTC60Rd2sM3Z0+w==
X-CSE-MsgGUID: +GTT8F2gS56div0X6G20oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211247942"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:01:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:01:14 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 00:01:14 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:01:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHuqY8KwiI7ozJ046qcdmXysk+deK4ol9s8kDKAmYVG/ou17tVyUyg8GZ9jJGpFe/67Gae8q5W7HkPzdhiIDTeqDf6fndGBd/46V401YeGBN39rfN6SbrGA2J9ujgG0hGiWVD35vGqw4h5TDckNEZZDErRQHeO5VlPxdHhp3andB2ZhWQL1XhFf0UmV/h5EkXUW5afnzRHnra97mibBDOgyT8w7ZqVLL+X7iRWst0H7zGqahgyrJpprNU0r+y4jOJMHU4jk85+ckeWqKUtKYU78ZZDQ7XviUL09HtCfuy5WQMrAZIa1s4zlB8bkcb5dwNwk8ePFK4Qs5jTL41bkG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w+8RnKjFfrX7YD140Nhh0VaJlXhrXlrADlJyoYRQKs=;
 b=ljKC+FLiYVQAntII50CemyixYQctv6vg2jQnx0rskbE43TUnj7+tHdArwFfHaeHR2oGxq9tVy8ZcStDGSnLgjhm63xJ1+lqgNeai2OMlSBk4DXFTnVeIJKqye3x0/OBc38ScYSTMYarNjVtxScKnn38kWuAjWI4SaFADytBrglDadSYznyA8QrZLCHh/jfuHFua/8a/C0y+1VsgCkrLhYIR6B2nwJ91dkA9VvlS40sKM/u7IdwyUarzNozf7f+inW/q+okjLb/22Okdx2TYcBGNSK9ZXGROh0uLV5NWnaZcpSIGRC/04Yi3B0GcvmvVeDUxSJE67YbnNIOXIqfiYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CY8PR11MB6820.namprd11.prod.outlook.com
 (2603:10b6:930:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 08:01:09 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:01:09 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v2 1/3] wifi: iwlwifi: replace use of system_unbound_wq
 with system_dfl_wq
Thread-Topic: [PATCH v2 1/3] wifi: iwlwifi: replace use of system_unbound_wq
 with system_dfl_wq
Thread-Index: AQHcWgW9/gdYfoslS0KSkBGR4WiLpLV6gDSw
Date: Mon, 9 Feb 2026 08:01:09 +0000
Message-ID: <DM3PPF63A6024A997DE452C005FBF60E124A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251120100850.66192-1-marco.crivellari@suse.com>
 <20251120100850.66192-2-marco.crivellari@suse.com>
In-Reply-To: <20251120100850.66192-2-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CY8PR11MB6820:EE_
x-ms-office365-filtering-correlation-id: c170af78-20d4-4b31-984c-08de67b162c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dTdNSmN2U0tFdWJCWm9TTk5PYzBkNUc2THRjZTZzcW05VE1nanA3cjNWbkJI?=
 =?utf-8?B?bDZPYUpaWnFnK09Hd01vb29ZRHVyVDVoa29zWnVaek53SUhBNno4M3IxSGVt?=
 =?utf-8?B?V3U3WG91Q1dtWmxheVVlM0QwVWRCQXdvaHJYUzFUOG9EQTNERGRiSStHWDlI?=
 =?utf-8?B?dUFzNnJ2eTF6K1JXejNRajR2WFdQUnE2SWsyYWFQY2x2Z21NaHNVdDkwYm9h?=
 =?utf-8?B?SDBueVVuVnRDZmk4SkwxeWU1SXQ2dVQrSzZmRDFrUG4vMnpYR011cmRuQzJk?=
 =?utf-8?B?SUxBWjZ4Qk9GcWZEQStpUUdPQ0k3TVRNWUdkQ0RWM1RkY05oaVhVRFd3ZkNN?=
 =?utf-8?B?TDFBYmVyRTRHRkwvY1BpY2phQlEyTDhuR3JrK3JLOEtYVE1aT3YrdXhsbVM4?=
 =?utf-8?B?Wm50UVpzR3dpQ29DQnpDTUtRUjIycjI3Ulg4RGtvVGdTRTM2emhnUkUxMHpH?=
 =?utf-8?B?emN5SWZvT09HaDArc2JSRURlZG1lU3BqR09xUmdqbkkrb3pPbzhEUDNLdGw5?=
 =?utf-8?B?NEdwTEI0L0VUS2pSYnlyQnVsY3JIT3ArdjZwdDN0QWNBTjV6Q01LVU5YdCtp?=
 =?utf-8?B?b01RMmwvQzF2akhWM3cyVDkwSktyMFVDK0ZVaEtuZWhUaGdxVnN2TWtiYW1U?=
 =?utf-8?B?U0s2WFJhWU9mMEkxdnF2RS9zTmQwR1oyQ2FEaGtjZVBKak82SnFRR3VZQitV?=
 =?utf-8?B?elJ3SWxZOU5KeEdUcWJ3eHpFTjlFem1scU1KWUtaUXNCcDVLMllSR3lIdkJE?=
 =?utf-8?B?ME1YUWNxeWQ1NktJbHVISGx0dGhEOXk3dVc2TGlqckx3SnUyVHJ1Z2Q1c2Yx?=
 =?utf-8?B?eDJ4cmxoeTd2cXRvQVFoSzJJOS8rSXAxYjhMamNscGFCajBEeDZmM0xFRFli?=
 =?utf-8?B?YnRDamF3Vm95UWJSZGZuRjZvNk1VOUdUa1lxUjRHK011TUt3dWwramkxKy8x?=
 =?utf-8?B?WEhCMndJaVpLdU1aSWFhellTSnpVV1h6RmlhYUpjRUl5ZGJDZnVMQmxGdG9I?=
 =?utf-8?B?RWhIVWRLUm52OTJWbUtDVUcrUnR3Z2lFRzdvVmdBU2JkVTdYMVBidkFKd21C?=
 =?utf-8?B?MTB1eTR0NURLL2h4bUxPMWxFc2xLT2hHY3g4TW82Q0lQbEVlR2x1UnJZbFJR?=
 =?utf-8?B?Mmk2SWZLMmlacDVJTlJuNW50RGdBb2lKSlNGYzZzUDRhb2l4NktKaTFwRGg2?=
 =?utf-8?B?dmN3R3NISFY1OTZtS0VldnE4VitLODM5Q0NIdjREWVJ4TWdWNE5STi9LMXRu?=
 =?utf-8?B?WWpoMU5mWS9kTU9NaU9jdUJvMDVyS3BEQW1YamNlRzlKR1Jjc2JJTkRDbFdm?=
 =?utf-8?B?eHYra0xiZGJHVWZjc3RzZjhxY1FYU0tRbFY3VUZIMVR6eFFwUFN3YzIxN3dN?=
 =?utf-8?B?VVAwYlpOdHFKUDFrV3BlbUt3RXUrQmVzd1BaZkU3MUhWVlhVdlRzQzByb0tY?=
 =?utf-8?B?ZDIreU9FTVFubnRud1lFVkY5dldPRVM1WlRkamt3c2hmbXVFUGM5R1lTVVA2?=
 =?utf-8?B?djZGYVMxQWhkVkFhWWI0b1J6dnM0WnJSVEtZSmVaVkZTZ0JWZVhSTzYwMEVQ?=
 =?utf-8?B?LzU1N3FBdVV4ZWNJWTRWM2xyb2dWMTVWd1NqYUhDNUM2UWFCRlR6RHhxcXlj?=
 =?utf-8?B?T0RqSWllT1VPak0vRnZHV0Izb1BUbDUzZy9zS1ZDaVNESC8vN09SeDNlQzNH?=
 =?utf-8?B?eDQ4V0QrWnhFWTVPN0ZFOXZmbmNubmR0UUJrZEZpNTJESlFBL3hSNzR0bHd1?=
 =?utf-8?B?QTVTRnBMY2x0bzl3RHFhWVN5TmJyR2o5djRCcy9VbUVIUHhwODVQdWM4SnhB?=
 =?utf-8?B?Zi85STBSMVhhUUVwWWtCK09HM0JNdnozSlFsYlpPdlNSS0lvOEJCNHJkdWF6?=
 =?utf-8?B?cmlqMjhpRWtaOHErWlBMZm12Y0kvTXRTbFcyY2NYV0w1cmdqZUJTT1Z3dGZV?=
 =?utf-8?B?WlhjTUY0a2FhUzcra2RjR1dmV0FKckN1M2F2MEprU3lQOENzQWxOeWNLV1dD?=
 =?utf-8?B?aDg2R1hObis4WTI3b0U2cjYvSzVCZEdVeWdnUFk0NXdENjFnYklpOUptUVdO?=
 =?utf-8?B?ZW8wcHMvdTMremI1SFR4NllpdHN3MEZsM2xhQWFTRmU1MFpzV2N4WXgxWE5G?=
 =?utf-8?B?MytwM2JjallnSkt4TWNCMmRzR3JKSXRZZTFwOExlUDhLdmJ2RWZVOVoyRTlX?=
 =?utf-8?Q?MgoFbxZ4CIatXN0QLxc3zvA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDMvVEdNTU0vZU1xeFBKb3B5SEQwcS9VUkgramhtQzAzb2xsQnZ4M21iTTFG?=
 =?utf-8?B?dWVHM1E2MVp4Y2hscWNldkNNNmdWSkpSZ29yNG84c0g4dTFXRUNiL0pCa0pT?=
 =?utf-8?B?SEo2MDdVaEk1V3graGJkb2h6Ti94ZUR0TTQ0K0JZWWVHU3o3SGZiV3R1Y2t5?=
 =?utf-8?B?OWNjTXNXaTFxMlNlZSs5OG9QQWwwdFY4dk9hTFNMZDlhZkNDUFA1N3VoQlRN?=
 =?utf-8?B?bWRlMzE5SGsvMHBoK2pqbFQ0NTEweGZBMWJQUXV2SGVEbklBVE8zcEFrSmww?=
 =?utf-8?B?a0M4RUpKM3k4TlZHQm00SVI4NnBPZExGNGdOV3dJZnRGTG84R0lQNytmc0lB?=
 =?utf-8?B?Y2FuTHpPZEhSc0hacUxEQ1h1SWw4N0ZkRkxrc08yaFZudEZiYjk0WGJkSXpt?=
 =?utf-8?B?bXg3akV6VzRDNjZ2bDl1M1dVSWZEQ01NaXc2YVdFakZGejlJSzNieklJTXRE?=
 =?utf-8?B?R0NKTXpVVWFEV2llU2hCNWlBSzhVdlNhcEdxQXQ1TngxMmtxUG1WYW9pczNZ?=
 =?utf-8?B?dEN0b3RjSWVzVndZdG5yN3IwZmlmbm1ybmlaUzZ6K2hmUllDL1hwZXlVVzFB?=
 =?utf-8?B?bTRsaTlIVDNIbzJndS93Vys3cFFMRjgrbVUvZVA1TTZWYjJpRTlyZHNFVnBv?=
 =?utf-8?B?TFRKNXJucno0Q1huR0FBRzNlNEVVeS8zeWdXSmp2aHU3d1h3T1RoNTlMMzBI?=
 =?utf-8?B?MHhUb0pWNndwYTZGTU4zdDhveGVpWlp0WVBEYmNLOWlqTVpTcXI2TnJteHE3?=
 =?utf-8?B?cEV3MkpQTmExZDFPQkFuV3BqSy8wQ2RpOVhuZ21aM21CaFN0QVF0c1hTYnRh?=
 =?utf-8?B?cUcyajFhOGZYeEtMUE5xT2tmS3Q0L0pEYUg2RjlQQ3VWT05yLzN0dE56NVhD?=
 =?utf-8?B?WG5qbU56SjY3a043NnNXSGJTTjhPSUJiRW1XZlVkcE80MitOV2hKc2xvWHZN?=
 =?utf-8?B?V0RIQXJwMnp6a0h2MEE3YkhzdzJiL2cvL3hoQ0JKdDN2eThWczhWTHkzUm00?=
 =?utf-8?B?alFBNHZzU3FwRGJlVTRaQkhldTFGSTF2L2FHVVAxbW02c2crQkpSbU1KSURj?=
 =?utf-8?B?VjhNQzZid2Q4YnVzbDM5RUZsaXNQNmV4SStiK1llemN6WFVIcDVwRWdZWlBq?=
 =?utf-8?B?cEtZeC9JVWRTczFxNUVZMDlpOUJIRDhjTitRT2JRczdKQ0VMUXVLUllwZHBZ?=
 =?utf-8?B?UmJTcDQrS29sOWY5ZzJxSVBtRGwzRm1xME1YRGFMQ29nZ2xKMitOT21jWitZ?=
 =?utf-8?B?dytGTTJ1TWpTdTcvaE1PVXh6Y28rRk5kOW1wU2M1Q2NyU0hwSjBTMWk5K0xJ?=
 =?utf-8?B?QzlpRGdKVkw3cU9BcW5rYU5KNXhlYytTVkxrOC9iZWZkU1dRRWEvSUtRTXho?=
 =?utf-8?B?M2dXUWVWME51Q2k4L1NubXZqZk1wRE1wMmRwYmIwdHIwUWNNTERmOFpsaytl?=
 =?utf-8?B?c2VIZzZYZ1RuSFlEaGh1MUZMNWVyTUU4eUo1eXphZllqSG9BYzUzaVdob0ZV?=
 =?utf-8?B?UnhLQWtRZmV1M0Y3Y1RDZUpqWVhnbEhPQklJU3dTU2dYOEc3TkRrYW1Ldjdz?=
 =?utf-8?B?dUZwdWw0QzNLUk5PWkgxQk85emlnZm5WOExmekRLV2ZXQm0wdHRUV3MzbXhY?=
 =?utf-8?B?ZmYzL2U5b0RaSEg1ckhrTEJYZjhiV0M5Nm1XL2tXYVNxTFUvelNmNnYvMThX?=
 =?utf-8?B?ekNERlFWNHZlb3VtcTJUbWM0L1JGWUdBdkowUVJjdERGZXNDWFNrdEtPbmpB?=
 =?utf-8?B?TFJEdzJZQ3pjMEtqWlBMOW5NY0o1TmxRK3pOQlgvdWNvdFY2eFRHNFE2YkVN?=
 =?utf-8?B?MWV0dWwzMmhIUlVqT0F5UFg3Snk2SUU3VVl5MXdxTkZCcTdPekxVOG1HaEF6?=
 =?utf-8?B?dmpwa1F4RG9rdjF2UFN3UDdDRGVrNVVQTlExQ3FXWjhjbjNFOGNLK1hZeW5T?=
 =?utf-8?B?azU2TGlUSFRqRkRTVTdiQ1hhVklnajZ0Zlp6TFRXQ08xYkU0QTRDMnh6anJ5?=
 =?utf-8?B?Z0lWajBaY09sU1FxaTBQSC9Yc3RDVzZwbDhqZ2JIWkl5VVJuZjQveDNqa29m?=
 =?utf-8?B?Sms0YVd5Rm96dElNZktqb01QUkk4SGJpQUZYcHI1UEZjcWVmNmxNT2lmeHBT?=
 =?utf-8?B?bUxMYVJsSXMwRG4yRWZ3dlVTTjl6R2JSTVZhWlhoNlN5ZmZsRmpEaHJhcnFI?=
 =?utf-8?B?T21kVVBodFpJSk9kbFMxY04xbVZKa3MrVDFLbEMvL3QrOE1PN3pUR3M2cE4y?=
 =?utf-8?B?R3B5VUxnd3lhZjRzazBqWjRjcGUzdVJocEJiaUZJUHBRd2xmRi9SZ1BsSDZC?=
 =?utf-8?B?b1hJMkI0TCs5MU1BeFdQQVBUY0J3L0RQTFJKNXNuTUszaHRwRUpLNnJZUHpQ?=
 =?utf-8?Q?iZeg3CFX0uGuMh1c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c170af78-20d4-4b31-984c-08de67b162c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 08:01:09.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suqgt+dHfX73CE71/yoAeKDWjitoMGohbRqLeKbkQcbX8jc6dPcDmUROyxOBbYezWDOLcPvOznRiuW/3cKQwOwDPc36Re2Is+ec1mDA6dQYAt1yQ57VPoJjKoabfK8IL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31655-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linutronix.de:email,intel.com:email,intel.com:dkim,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sipsolutions.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ECA7A10CB1D
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDIwLCAyMDI1IDEyOjA5IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz47IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+OyBGcmVkZXJpYw0K
PiBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvcg0KPiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgTWFyY28gQ3JpdmVsbGFyaSA8bWFyY28u
Y3JpdmVsbGFyaUBzdXNlLmNvbT47IE1pY2hhbA0KPiBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPjsg
S29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsDQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRl
bC5jb20+OyBKb2hhbm5lcyBCZXJnDQo+IDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjIgMS8zXSB3aWZpOiBpd2x3aWZpOiByZXBsYWNlIHVzZSBvZiBzeXN0
ZW1fdW5ib3VuZF93cSB3aXRoDQo+IHN5c3RlbV9kZmxfd3ENCj4gDQo+IFRoaXMgcGF0Y2ggY29u
dGludWVzIHRoZSBlZmZvcnQgdG8gcmVmYWN0b3Igd29ya3F1ZXVlIEFQSXMsIHdoaWNoIGhhcyBi
ZWd1biB3aXRoDQo+IHRoZSBjaGFuZ2VzIGludHJvZHVjaW5nIG5ldyB3b3JrcXVldWVzIGFuZCBh
IG5ldyBhbGxvY193b3JrcXVldWUgZmxhZzoNCj4gDQo+ICAgIGNvbW1pdCAxMjhlYTlmNmNjZmIg
KCJ3b3JrcXVldWU6IEFkZCBzeXN0ZW1fcGVyY3B1X3dxIGFuZA0KPiBzeXN0ZW1fZGZsX3dxIikN
Cj4gICAgY29tbWl0IDkzMGMyZWE1NjZhZiAoIndvcmtxdWV1ZTogQWRkIG5ldyBXUV9QRVJDUFUg
ZmxhZyIpDQo+IA0KPiBUaGUgcG9pbnQgb2YgdGhlIHJlZmFjdG9yaW5nIGlzIHRvIGV2ZW50dWFs
bHkgYWx0ZXIgdGhlIGRlZmF1bHQgYmVoYXZpb3Igb2YNCj4gd29ya3F1ZXVlcyB0byBiZWNvbWUg
dW5ib3VuZCBieSBkZWZhdWx0IHNvIHRoYXQgdGhlaXIgd29ya2xvYWQgcGxhY2VtZW50IGlzDQo+
IG9wdGltaXplZCBieSB0aGUgc2NoZWR1bGVyLg0KPiANCj4gQmVmb3JlIHRoYXQgdG8gaGFwcGVu
IGFmdGVyIGEgY2FyZWZ1bCByZXZpZXcgYW5kIGNvbnZlcnNpb24gb2YgZWFjaCBpbmRpdmlkdWFs
DQo+IGNhc2UsIHdvcmtxdWV1ZSB1c2VycyBtdXN0IGJlIGNvbnZlcnRlZCB0byB0aGUgYmV0dGVy
IG5hbWVkIG5ldyB3b3JrcXVldWVzDQo+IHdpdGggbm8gaW50ZW5kZWQgYmVoYXZpb3VyIGNoYW5n
ZXM6DQo+IA0KPiAgICBzeXN0ZW1fd3EgLT4gc3lzdGVtX3BlcmNwdV93cQ0KPiAgICBzeXN0ZW1f
dW5ib3VuZF93cSAtPiBzeXN0ZW1fZGZsX3dxDQo+IA0KPiBUaGlzIHdheSB0aGUgb2xkIG9ic29s
ZXRlIHdvcmtxdWV1ZXMgKHN5c3RlbV93cSwgc3lzdGVtX3VuYm91bmRfd3EpIGNhbiBiZQ0KPiBy
ZW1vdmVkIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRlanVuIEhlbyA8dGpA
a2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3Jp
dmVsbGFyaUBzdXNlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL2l3bC10cmFucy5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvaXdsLXRyYW5zLmgNCj4gaW5kZXggYTBjYzVkNzc0NWU4Li43ZTg0MDc0ZTFh
M2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXds
LXRyYW5zLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wt
dHJhbnMuaA0KPiBAQCAtMTA5Miw3ICsxMDkyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGl3bF90
cmFuc19zY2hlZHVsZV9yZXNldChzdHJ1Y3QNCj4gaXdsX3RyYW5zICp0cmFucywNCj4gIAkgKi8N
Cj4gIAl0cmFucy0+cmVzdGFydC5kdXJpbmdfcmVzZXQgPSB0ZXN0X2JpdChTVEFUVVNfSU5fU1df
UkVTRVQsDQo+ICAJCQkJCSAgICAgICAmdHJhbnMtPnN0YXR1cyk7DQo+IC0JcXVldWVfZGVsYXll
ZF93b3JrKHN5c3RlbV91bmJvdW5kX3dxLCAmdHJhbnMtPnJlc3RhcnQud2ssIDApOw0KPiArCXF1
ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fZGZsX3dxLCAmdHJhbnMtPnJlc3RhcnQud2ssIDApOw0K
PiAgfQ0KPiANCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBpd2xfdHJhbnNfZndfZXJyb3Ioc3RydWN0
IGl3bF90cmFucyAqdHJhbnMsDQo+IC0tDQo+IDIuNTEuMQ0KQWNrZWQtYnk6IE1pcmkgS29yZW5i
bGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQoNCg==

