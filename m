Return-Path: <linux-wireless+bounces-31420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /dtPIBRVfmlQXQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 20:16:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A3C3A16
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 20:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBAA300DDE5
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D90350D7F;
	Sat, 31 Jan 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eonfeXFJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BB306483;
	Sat, 31 Jan 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886993; cv=fail; b=jW7QpKqGLPd1gnvbMwndG66kOhEK96U4ydZhgeaxL0N8VCuli7acdYPfGb1hvAnT0bMwr5Kr8AwNUIccMRtuki6d04fjMZE6JabcDhQsxr4ldU15hVd+DHnt9d5K5CAaRppJNPm4XCPBgD0kX8iD8Z1njZ8vWwFw9CP2EedP7Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886993; c=relaxed/simple;
	bh=TWneyzoIn3JV+QjjBugKThbdQaEa2rsIcwsNAdBIoeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ljINoAKD8fux/OhBimvCsfXjgzLuA9ALlK9CxQDeu8B7OIxiLj+RGkmnnxT9uGv5vdyLCLa0AOLVlct5Ho+DTHNXyXB+bWqkoTQBDXHsrJB1IrhnMLWYXIuc/EBIx820T5WrLHyzEarLdoEbOTKGKzZkjWrwKd2poMvCpGocoQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eonfeXFJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769886991; x=1801422991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TWneyzoIn3JV+QjjBugKThbdQaEa2rsIcwsNAdBIoeI=;
  b=eonfeXFJBt7dgdUvvRKzWi3l6n3EG3CddYiKc88U61yWmnd1HspSilNI
   NusV/4KELQnWjjx44YbhS9ghr53Nsc0jhfDwBQAeuecSheR3x0RrnYbOZ
   JJXTU4RgtLtjytBdg+JczytwWTeSMFpLBOYWFkEtPdMu5pup8z2WMBZ5u
   ++kLQ/Lt4gJt5k24l+XIoeId5lnb21Mi517PruTJGgqCpH0kfska4p9C0
   J/onXsgkH/O86/6nL4fLsfrZyU7X7n0ox9717Fytzbz1oic58toCFOpPP
   9Rc1QUxBxag2M9U5IQ33teq2e1/YBw5+r4KUoTKE0IgAPXnK0lemgyGtL
   Q==;
X-CSE-ConnectionGUID: s8s9X9cjSGmE6LaLnlti9g==
X-CSE-MsgGUID: +oOWrnHbRMud3/8XcijKsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="70308986"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="70308986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 11:16:31 -0800
X-CSE-ConnectionGUID: hWby0Z+9SlWBCgVt0VYHhQ==
X-CSE-MsgGUID: GR7277y7Qia359vfWOf+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="209481604"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 11:16:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 31 Jan 2026 11:16:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 31 Jan 2026 11:16:29 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 31 Jan 2026 11:16:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn8bIpFTRtY4yd1RPExYlFTicehsI+H6ea1eCFK/rdzZLpkrQ/4VzkHBi5xnCOth3vDu/cBbEs3698dOEmOABH+yrLiXCKnfMm2pY1bsTX3nwlx88InHgpbae+D0h1r/ZeNf0JDnOgmexazDOUCCbn0xqJCg2KDKpzvcf4nB9QBXbBeZRSbbWUboaB4NvbKQ1eMdywb7b68Fv2MF1qPdywCoMDgFeFPJvp4iigI0zdVsHneaDW1HLiX/WoOMPXVUkvG7opKrlBY4TK0RdTCbZhgD4TzYSKPr8D40wuwrTMhAJNBM+TxGv+OwVtsblksfA783sWfQjW9g+6Ub6am2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWneyzoIn3JV+QjjBugKThbdQaEa2rsIcwsNAdBIoeI=;
 b=nwXO3X7tgP9rcFzI8qhKclggb+liZk1XmcznVJmVhlz2W88fSvqR81Vlxk26pESUXTXha++2MPrWz6/jyah6O9BYyOZ4CdnEk/1B29N6iS899CjwGKyRX5FUkDSIEz3Z0XLP2Gw4lngVBGuaiLZbCxRXKQYI42yoOqoptsDbCpCMLiupJIVzIIxBmRKbSkAJrj0a7N+S72vDWxoxZc11J/25TAP2S0BLb/wDODdG2HxOixExYIv92NSMrVF6NTN4wOUGFQidll2it+78/lo5qkV1+h8+LGNZjEGDOG9Yni5vciA51I8t6z9+xTbibSaToqIuKTF6LS/ue6bgKRDnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by LV2PR11MB6024.namprd11.prod.outlook.com
 (2603:10b6:408:17a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 19:16:27 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 19:16:27 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Index: AQHcjlMSDsDNaO3QzkSRZaUB0ZOqB7VkClEAgAAYLQCAAFS+8IAAi5yAgAB00nCAAHrBgIAFdY2AgAE3/7A=
Date: Sat, 31 Jan 2026 19:16:27 +0000
Message-ID: <DM3PPF63A6024A9BB5AB65CD8C9109A37C5A39CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXit5795WQLL290t@debian.local> <aX1CQb1P7QA1JefK@debian.local>
In-Reply-To: <aX1CQb1P7QA1JefK@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: b0675e78-e643-44d1-3e30-08de60fd3baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c21HTUxvODdRdkovbmlNSDhlVjBudko2RWs5TEhkS1pKNU9DOEViYXIzQmlR?=
 =?utf-8?B?Z3pHeGpNM2txbG51WEgwejd1ZzZUR2VURzRsL1lWLzN3UExlcEU2UXJRNCtY?=
 =?utf-8?B?dkFiOU05ODhYR3kwTHdzNUlTWEFJbVNlaHovenB5VWN0SXJyalEyRWZsZmR5?=
 =?utf-8?B?Y25HYlFRSjRFcnE3V3ZEbXAySk9hcVoxc0xmbEpTeWVMdDJoc1crUEcyWTVm?=
 =?utf-8?B?V20xWmpNdzNwWEVIM1pEYUo1TndtdEtRQXI1eXgzYlJtR2xETW4vdkxjbjlH?=
 =?utf-8?B?TTFjLzJlallCRzBDejhZcXdiU3BNU2hvamhISTROUzNRcDY4d1NLT1NpWU5r?=
 =?utf-8?B?c2s1Y0JsT0poZmt4TnBlMnlqRUJPMWtEaW5GTFVMaVRaYXRrNm1uTVQ0eU1H?=
 =?utf-8?B?SnJaTi85eDg5bGNoaGxJTXAzc0dLaGdzaWhrRmNHdTJUMFVpbVErYjRiWHla?=
 =?utf-8?B?LzlCcE1xbkM2dHhmUlNWSTB5L0xPajlJRXhNR2VyY3oza1p6U3d0YW9HLzFW?=
 =?utf-8?B?Y1JUUVNyRDRHVkNJQnJwSHYyOGRha2FISlRRSXVIdng2UEh3TEtxQlJ6OE1F?=
 =?utf-8?B?bi9sak9NNTRydzMzY0RGK1BBOXJMOHBqQy8zYlZVYWFqOU1wS09LVElnL0dT?=
 =?utf-8?B?K3dhTHlXVG9NcTIzdG5MMXFBZ284NG95SWVLZzFrVXZtMFdFdzNHMmlKYW0x?=
 =?utf-8?B?R3o5anJwWmhrQ2IzRVF1ZU1vdTVOdDUzSHpJcDJ1QkJnR0JQNDFaY0pwbmg3?=
 =?utf-8?B?UXd6SlIxTlcvNFpNMmFRRmphRHR0LzRNNFlUbUl5UkJlRjZScWJSUzFtRDdV?=
 =?utf-8?B?QlhrYmZDTEJlVzU2aStBTVF2Z2l0VFA5MU0vNXlxcVFiOHpRdVRPTjFaMjZD?=
 =?utf-8?B?YjVNYWlCOVhBTG9MM0VRekNYMDhMcm9MWjgwcjMwOGxEYWs1QlNEOFBKaE4z?=
 =?utf-8?B?QUNCNFJodjIyMUJqWFdWdnUwZWt6MVJwM2RQSjI1cC82QkJ6eEhPTEd0M05t?=
 =?utf-8?B?WGpCdzVJS3hGUVA5ZEVOR1IrT2RiSjJOaW53ZUNodVNVcGJwNHpCck9mZHVU?=
 =?utf-8?B?QkM5UDhwbGRkNnhqeW1Jb3FqMmhmTTl2TG9jb0hOUE5aWmpNbVJQRW9QUFB0?=
 =?utf-8?B?RHBabHNsUlFMdW4yZ3V5Mjd1M3Rhc0Q2a3BjdnVxNnBNalloaGpSd1BpWDRr?=
 =?utf-8?B?bVlxbytrVXAvUEs4NTVXdWFsd1AyajF6ZWRaYlRYK1dHRlJCeFlPUjFoMFQr?=
 =?utf-8?B?ZWhobTVaYjlIR0RObGlXZWppMHRIdE4vM0F0aFFnTHdtRm5HV1hlM1RjRHlx?=
 =?utf-8?B?UGQ5Zm9jTXMvYWVOTFhIeDhzVVFSb0U4MTJLd3BCVGo4QUQ0MW5jV3A2cHFN?=
 =?utf-8?B?ZzFkaCtFVjh6amo1U2Q0ekJ3VExkMmpWZ00yV1ZzYTM5N0hKRjB5cHhwaFlL?=
 =?utf-8?B?Y1d3K0tpY3JPOCtxWVJaekJHTWNHdTI0VHhZTit1eEFqZ1E2czZSVXJCalN6?=
 =?utf-8?B?VEE1ZWJqaWF1VUl3UVVoM05JRDJtZ2tRYkpTanJkM3Nqek9wck1Cb0E2eGI3?=
 =?utf-8?B?Y1dRUUlWMWpLZDE5QU9lWTVqTkhscHk4OUhRdSszTytNekxBOEdVcTlFSUYr?=
 =?utf-8?B?cWhNMlFQWWNnZ1MzK2JISUlnNitoNWVFMmpsa3ZzUTJYendwbDlGOWpndTlD?=
 =?utf-8?B?RSt0a2ZMbldtWTVLMWo2a3B2U2Q5UUNWSmtTVU1VQ25PaXc4L0RuUzlrK0g1?=
 =?utf-8?B?eVBIYUt2STR6dW95OVEyL015bld6RWZXUlc1UW9TWlRYcVlBY2JvMTZWRDdY?=
 =?utf-8?B?TGEvOUMxeDh5RkJQL1Y1NmJxSmFKWHcvTHlDajJ4VUxFeWM1aEhOV2dqakpF?=
 =?utf-8?B?Unl2bmRJSmpYelcvN2VEVmdGcVhyakQ2TE02aXN3TnFUdHYwQzlIM3VJQWRx?=
 =?utf-8?B?ZUpGbjFwRFRmSjIwWjRtNTBJQmZVRVRXUGxNdFF4UHRscW5YWWxBNnY5ZkUv?=
 =?utf-8?B?c2F0dFJjaU1ZWEhXQlJocis3WTExSmJrOStRcWNkUnN2dkh4bFZCdnRPNWMr?=
 =?utf-8?B?M2VTdTBRQ0pkSzk2ZG9PODhqWkxiclNHRjBlakhlcS9BR2wzZW1UQjRYbU1S?=
 =?utf-8?B?bXM4UzNmclZjcFRIZTl6R2t6YkRrS0E2ZmU5N3BmdHc4WmhVRDh2RllheVF2?=
 =?utf-8?Q?anJi1jcK74Ye3dxXYh0bmEw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ArS1dyd001ZHpKaDNuNjhUUjBINjN0YS9vYjB5dks0NE9kSEdWYTJ1V1VH?=
 =?utf-8?B?OFRFWnJSL29FUk1ETmpaSm9ESGhpWS9wVzc2RGNJY0ZLUXdUcnJSbmFzR2pZ?=
 =?utf-8?B?VTlrTy8vdStmWkhDcVBCSUtLWm0ydlk5Rk1Vci90RG1LTG5iVjBkQTF4Wk00?=
 =?utf-8?B?UFE0cjJhNnpKSTFRNjJVQUZPY2hYK2ZScUlIN0EyNEtCTXpnY2RLYUp6NHJK?=
 =?utf-8?B?NHhYNmRrRms4MUsxYXlheStoRDFtVFdSdnRmYnhjZC96cmRLTzg4WXZsaEla?=
 =?utf-8?B?WG5XQzJtREhTdEsvUzVUTm92ZFJkUzdZQVpkNGJZZms2MXcvSHNqQjNkYnNM?=
 =?utf-8?B?OEc0KzJybURCejl6Q0VBMUlWWnE0eTdLSEdKN0wzYU5vL1JEMnFQVEVpTjRE?=
 =?utf-8?B?SDlyQVlQMEoxc2t1aVBRVUJEQlg1ZVpUdktCMk5jdDA4amo3eUhzQXV0VDZN?=
 =?utf-8?B?K1dIcXduakRiNFJ4RWV6ME5NWGZNR3ZtK2pBdDdUL2ZCUUpyNFRQdWgyYzBR?=
 =?utf-8?B?eXgybC9ZbXZPOUtJblVVd0NJNHc3aUJyaDRYcUR4MmVkVHA4QlJhY3ZBWGto?=
 =?utf-8?B?NzY2emRTL0dnS0doLzRqMndrTVFrKzZSTURUVWllVFg4eTl1Z3VHYmdlV2R2?=
 =?utf-8?B?MDJrcWNFL1krQlk4TkpmQWNFam9FQzJGNGU4dlJDdzJuN3lwdUdCNlh0VFFS?=
 =?utf-8?B?b2N5NXc1Qlg3bWxNMjFwUG1xUGxHVENKNVhKOG5yOVN0WWh0bXRlYnhzTmdo?=
 =?utf-8?B?eDVkRFFtWjhYZ0JkN0l1OUVNUE1tcVpJUDFQKzdvdGVkc3dYcE40VW41cDN1?=
 =?utf-8?B?NE5rdGFqYjhCdVI3SnZFdmU2WUw4L2NEQ0V3d3B5MUtFbDNna1d5aHg3dk9y?=
 =?utf-8?B?V3NhQ3BOUlhaRG1uQ2lxaWRGQXRkdm9DQjNRdkVHWnRBTk1rU1pzTi9va25a?=
 =?utf-8?B?dEZwQTdSNVIxaUpqUmlaUlNrdXJyVEs2UXBFOG5KMnpGYjB5N2ZDblZ4ZDVY?=
 =?utf-8?B?UFgxNlRES3IwaC9qcUh5cDVIUm0rKzBEYU45T1V6NE83aDErVlNQQ1hTR2Fl?=
 =?utf-8?B?UGcvcUxYR1VVOFBMU2NFeUJ4SnJYMEdEalU1TFFJUGhVd2NsNTZrNWwyVG11?=
 =?utf-8?B?UGM1b0c0bDVqdnFSVTg5Rk5wTnV2TVpjZ2dxRUduL0xob2g2eDZkdDRPUTQx?=
 =?utf-8?B?bjgwOGpiL29vRGJBcXd3UmNwN1hyQmNialZvLzJLNDVXWW92c0xCSXEwTG1k?=
 =?utf-8?B?YlIyc0l6T0dHL3BXdDkzeXQ1WUtkejYzN2N6TEVtOTBtcUdUQmoxVkt3NlBs?=
 =?utf-8?B?eHVmQm12T1FvYjI5STl4VVRRUE1PM1VmSkVYK0p5ZDBOdGhHWnhwU0hVSjhs?=
 =?utf-8?B?VmFWbUtrbHhtczNPNXVCVnFmT0ZYQzdEZW9QY2dtVnNQSnZLVEg0M2NWTGRN?=
 =?utf-8?B?MklQcVp2eUhNM0lUMEZjZTVKekZ5T0VYYnhOakRReTRaamZ6QzgrVXdYejc4?=
 =?utf-8?B?RXNodnlqY2F3WjRkd2RuQ0tjbHRpUzB0bnZLV3p5ZHJJTWllTHNHNU9SbXMr?=
 =?utf-8?B?UEErZVIxRU1neDd3RXFDNlY2akZLWHRSU1gyOFh1MDQ3UUFBSGZKemVaZ3Fs?=
 =?utf-8?B?WVRBd08yOXNlQzlmTmgxRytZK211cnF5WDF6Vi9FK3J0NWlEK1BNdEpUMzFj?=
 =?utf-8?B?aTZuOFhFUkszejZkSzNUVHE3ajc5d0U0MnZXN2xIRnJEb2RTMjZGNFpwK3dr?=
 =?utf-8?B?WDM3S0k5dG43eXBCTS9JRXZoVHhVZ0JaMUN2UC9aK1c4emk2d2lHcENOU3Vq?=
 =?utf-8?B?T1BpL1BzK2FRSU1RMFNSMDd4K2FPVnFxUzdJNEtmY2V0cmIzd3VqZS9STXM0?=
 =?utf-8?B?bDQ1Z045ODFrUXRpWENsMDBsbEdjN0hNVnVEK3VreVZ0MFVWa2gxZ0ltOVNo?=
 =?utf-8?B?Q1NuUVFYUXBoOHdlV25MUFV6VEdrdDdpOGt2L2N6Uk0vYWRxZGNUVWV4c3FI?=
 =?utf-8?B?YnpxR0s4cDB3L3RudkM4VjBGUldLYm9hcktmSWxucHNXUFZFMjRPTnNBbnB5?=
 =?utf-8?B?VmVoZmZxZitmUmRsaDcxVHI4eXptK2JUNHd0dnlBb1FYbnlNUHJhYi9sU29Q?=
 =?utf-8?B?TzhPNjVGNVcxWk1sMFRoVEJLQ2dnQllGd01DOE5NMituRlRHZjBSRk44bHdq?=
 =?utf-8?B?cTFleXR6ZHQ1Tkhhb0UwUkRqNnl6dkNmbFFObmdtNDBGN1pOcGNTY0QzY1Bp?=
 =?utf-8?B?NW0zZkY0Y01pem53T1M3OVZzMVdrbjQraHhRZlNJS3RnNTNFdlJxYTdCV0lB?=
 =?utf-8?B?OEhFeVFCWDVKVXBLbnFzeTFybTFCUmhXRmU1QThxQzFBRXo2RWs5V2U2MXdU?=
 =?utf-8?Q?Qxmk0pY5HOIZ5AlU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0675e78-e643-44d1-3e30-08de60fd3baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2026 19:16:27.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvFEFAtoPgLIMpedLwZlWJiaA2NkK99Juq1zIZbanbkR9zhc6R3p9ThrQBpP+BgRi5LXL1yK2h1UP8GUbEOmFcCGC4msSz6GXQk+eXrIjOfgDx3x9jRYhxtfjgUlMSOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31420-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CC3A3C3A16
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5
IDMxLCAyMDI2IDE6NDQgQU0NCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFt
LnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzoga3ZhbG9Aa2VybmVsLm9yZzsgQmVy
ZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPjsNCj4gYmVuamFtaW5Ac2lwc29s
dXRpb25zLm5ldDsgZ3VzdGF2b2Fyc0BrZXJuZWwub3JnOyBsaW51eC1pbnRlbC13aWZpQGludGVs
LmNvbTsNCj4gbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgIndpZmk6IGl3bHdpZmk6IHRy
YW5zOiByZW1vdmUgU1RBVFVTX1NVU1BFTkRFRCINCj4gDQo+IEhpLA0KPiANCj4gSSd2ZSBiZWVu
IHJ1bm5pbmcgYSBrZXJuZWwgd2l0aCBib3RoIG9mIHRoZSBzdXNwZW5kIGZpeGVzIChwYXVzZSBU
Q00gb24gZmFzdA0KPiByZXN1bWUsIGNsZWFudXAgSVdMX01WTV9TVEFUVVNfSU5fSFdfUkVTVEFS
VCBpbiByZXN1bWUpIGhlcmUgZm9yIHRoZQ0KPiBsYXN0IGZldyBkYXlzLiBJIGp1c3QgZXhwZXJp
ZW5jZWQgdGhpcyBmYXVsdCAtIG5vdCBmcm9tIHN1c3BlbmQvcmVzdW1lIHRoaXMgdGltZQ0KPiB0
aG91Z2gsIHRoZSBsYXB0b3Agd2Fzbid0IGRvaW5nIGFueXRoaW5nIHBhcnRpY3VsYXIgYXQgdGhl
IHRpbWUsIHNvIG5vIGlkZWEgaG93IHRvDQo+IHJlcHJvZHVjZSBpdC4NCj4gTWF5YmUgaXQncyBy
ZWxhdGVkIHRob3VnaCAoPykgYXMgaXQgaGFzIHRoZSBzYW1lICJFcnJvciBzZW5kaW5nDQo+IFNZ
U1RFTV9TVEFUSVNUSUNTX0NNRDogdGltZSBvdXQgYWZ0ZXIgMjAwMG1zLiINCj4gSXQgcmVjb3Zl
cmVkIG9rLCB3aWZpIHdhcyBmdW5jdGlvbmFsIGFmdGVyd2FyZHMuDQo+IA0KPiBbMzc0MTAuOTc1
NTY1XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogRXJyb3Igc2VuZGluZyBTWVNURU1fU1RBVElTVElD
U19DTUQ6DQo+IHRpbWUgb3V0IGFmdGVyIDIwMDBtcy4NCj4gWzM3NDEwLjk3NTc0MV0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IEN1cnJlbnQgQ01EIHF1ZXVlIHJlYWRfcHRyIDM5MDg4DQo+IHdyaXRl
X3B0ciAzOTA4OSBbMzc0MTAuOTc3NDc0XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogU3RhcnQgSVdM
IEVycm9yIExvZyBEdW1wOg0KPiBbMzc0MTAuOTc3NDgwXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
VHJhbnNwb3J0IHN0YXR1czogMHgwMDAwMDA0QSwgdmFsaWQ6IDYNCj4gWzM3NDEwLjk3NzQ4Nl0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IExvYWRlZCBmaXJtd2FyZSB2ZXJzaW9uOiA4OS43ZjcxYzdm
NC4wDQo+IHR5LWEwLWdmLWEwLTg5LnVjb2RlIFszNzQxMC45Nzc0OTFdIGl3bHdpZmkgMDAwMDow
MTowMC4wOiAweDAwMDAwMDg0IHwNCj4gTk1JX0lOVEVSUlVQVF9VTktOT1dOIFszNzQxMC45Nzc0
OTddIGl3bHdpZmkgMDAwMDowMTowMC4wOg0KPiAweDAwMDA4MjEwIHwgdHJtX2h3X3N0YXR1czAg
WzM3NDEwLjk3NzUwMl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDAwMDAwMDAgfCB0cm1f
aHdfc3RhdHVzMSBbMzc0MTAuOTc3NTA2XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDoNCj4gMHgwMDRE
QUQwNCB8IGJyYW5jaGxpbmsyIFszNzQxMC45Nzc1MTFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwNEQwOTJBIHwNCj4gaW50ZXJydXB0bGluazEgWzM3NDEwLjk3NzUxNV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4MDA0RDA5MkEgfCBpbnRlcnJ1cHRsaW5rMg0KPiBbMzc0MTAuOTc3NTIwXSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAxNkFEMiB8IGRhdGExIFszNzQxMC45Nzc1MjRdDQo+
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAxMDAwMDAwIHwgZGF0YTIgWzM3NDEwLjk3NzUyOV0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDAwMDAwMDAgfCBkYXRhMyBbMzc0MTAuOTc3NTMz
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg3MEMwMTgyNyB8IGJlYWNvbg0KPiB0aW1lIFszNzQx
MC45Nzc1MzhdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweEFENDdCN0Y1IHwgdHNmIGxvdw0KPiBb
Mzc0MTAuOTc3NTQyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDY2QiB8IHRzZiBoaSBb
Mzc0MTAuOTc3NTQ3XQ0KPiBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHRpbWUg
Z3AxIFszNzQxMC45Nzc1NTFdIGl3bHdpZmkNCj4gMDAwMDowMTowMC4wOiAweEIzRkQzQTIyIHwg
dGltZSBncDIgWzM3NDEwLjk3NzU1NV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDAwMDAw
MDEgfCB1Q29kZSByZXZpc2lvbiB0eXBlIFszNzQxMC45Nzc1NjBdIGl3bHdpZmkgMDAwMDowMTow
MC4wOg0KPiAweDAwMDAwMDU5IHwgdUNvZGUgdmVyc2lvbiBtYWpvciBbMzc0MTAuOTc3NTY1XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDoNCj4gMHg3RjcxQzdGNCB8IHVDb2RlIHZlcnNpb24gbWlub3Ig
WzM3NDEwLjk3NzU2OV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDAwMDA0MjAgfCBodyB2
ZXJzaW9uIFszNzQxMC45Nzc1NzRdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwQzgwMDAyIHwN
Cj4gYm9hcmQgdmVyc2lvbiBbMzc0MTAuOTc3NTc4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg4
MEYzRkQyNiB8IGhjbWQNCj4gWzM3NDEwLjk3NzU4M10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MjQwMjAwMDAgfCBpc3IwIFszNzQxMC45Nzc1ODddIGl3bHdpZmkNCj4gMDAwMDowMTowMC4wOiAw
eDAwMDAwMDAwIHwgaXNyMSBbMzc0MTAuOTc3NTkxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDoNCj4g
MHg0MEY4NDAwMiB8IGlzcjIgWzM3NDEwLjk3NzU5Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDRDMzA4MUMgfCBpc3IzDQo+IFszNzQxMC45Nzc2MDBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDAwMDAwIHwgaXNyNCBbMzc0MTAuOTc3NjA0XSBpd2x3aWZpDQo+IDAwMDA6MDE6MDAuMDog
MHgwMzI2MDAxQyB8IGxhc3QgY21kIElkIFszNzQxMC45Nzc2MDldIGl3bHdpZmkgMDAwMDowMTow
MC4wOg0KPiAweDAwMDE2QUQyIHwgd2FpdF9ldmVudCBbMzc0MTAuOTc3NjEzXSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHgwMDAwMDA4MCB8DQo+IGwycF9jb250cm9sIFszNzQxMC45Nzc2MThdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDEwMDE0IHwgbDJwX2R1cmF0aW9uDQo+IFszNzQxMC45
Nzc2MjJdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDNGIHwgbDJwX21odmFsaWQNCj4g
WzM3NDEwLjk3NzYyN10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDE4MDAgfCBsMnBfYWRk
cl9tYXRjaA0KPiBbMzc0MTAuOTc3NjMxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAw
OCB8IGxtcG1fcG1nX3NlbA0KPiBbMzc0MTAuOTc3NjM1XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHgwMDAwMDAwMCB8IHRpbWVzdGFtcCBbMzc0MTAuOTc3NjQwXQ0KPiBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHgwNjY0Nzg3OCB8IGZsb3dfaGFuZGxlciBbMzc0MTAuOTc3Njc4XSBpd2x3aWZpDQo+
IDAwMDA6MDE6MDAuMDogU3RhcnQgSVdMIEVycm9yIExvZyBEdW1wOg0KPiBbMzc0MTAuOTc3Njgy
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogVHJhbnNwb3J0IHN0YXR1czogMHgwMDAwMDA0QSwgdmFs
aWQ6IDcNCj4gWzM3NDEwLjk3NzY4N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MjAwMDAwNjYg
fCBOTUlfSU5URVJSVVBUX0hPU1QNCj4gWzM3NDEwLjk3NzY5Ml0gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IDB4MDAwMDAwMDAgfCB1bWFjIGJyYW5jaGxpbmsxDQo+IFszNzQxMC45Nzc2OTddIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweDgwNDgzOEJFIHwgdW1hYyBicmFuY2hsaW5rMg0KPiBbMzc0MTAu
OTc3NzAxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg4MDRBNUQzNiB8IHVtYWMgaW50ZXJydXB0
bGluazENCj4gWzM3NDEwLjk3NzcwNl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4ODA0QTVEMzYg
fCB1bWFjIGludGVycnVwdGxpbmsyDQo+IFszNzQxMC45Nzc3MTBdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDAxMDAwMDAwIHwgdW1hYyBkYXRhMSBbMzc0MTAuOTc3NzE1XQ0KPiBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHg4MDRBNUQzNiB8IHVtYWMgZGF0YTIgWzM3NDEwLjk3NzcxOV0gaXdsd2lm
aQ0KPiAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB1bWFjIGRhdGEzIFszNzQxMC45Nzc3MjNd
IGl3bHdpZmkgMDAwMDowMTowMC4wOg0KPiAweDAwMDAwMDU5IHwgdW1hYyBtYWpvciBbMzc0MTAu
OTc3NzI4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg3RjcxQzdGNCB8DQo+IHVtYWMgbWlub3Ig
WzM3NDEwLjk3NzczMl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4QjNGRDNBMjAgfCBmcmFtZSBw
b2ludGVyDQo+IFszNzQxMC45Nzc3MzZdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweEMwODg2MjU4
IHwgc3RhY2sgcG9pbnRlcg0KPiBbMzc0MTAuOTc3NzQxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHgwMEIwMDIwRiB8IGxhc3QgaG9zdCBjbWQNCj4gWzM3NDEwLjk3Nzc0NV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4MDAwMDA0MDAgfCBpc3Igc3RhdHVzIHJlZw0KPiBbMzc0MTAuOTc3NzU5XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogSU1ML1JPTSBkdW1wOg0KPiBbMzc0MTAuOTc3NzY0XSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMEIwMyB8IElNTC9ST00gZXJyb3Ivc3RhdGUNCj4gWzM3
NDEwLjk3Nzc3OF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDhFQkIgfCBJTUwvUk9NIGRh
dGExDQo+IFszNzQxMC45Nzc3OTJdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDkwIHwg
SU1ML1JPTQ0KPiBXRlBNX0FVVEhfS0VZXzAgWzM3NDEwLjk3NzgwMl0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IEZzZXEgUmVnaXN0ZXJzOg0KPiBbMzc0MTAuOTc3ODY4XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHg2MDAwMDAwMCB8IEZTRVFfRVJST1JfQ09ERQ0KPiBbMzc0MTAuOTc3ODc1XSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHg4MDQ0MDAwNyB8IEZTRVFfVE9QX0lOSVRfVkVSU0lPTg0KPiBb
Mzc0MTAuOTc3ODgyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDA4MDAwOSB8DQo+IEZTRVFf
Q05WSU9fSU5JVF9WRVJTSU9OIFszNzQxMC45Nzc4ODldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDBBNjUyDQo+IHwgRlNFUV9PVFBfVkVSU0lPTiBbMzc0MTAuOTc3ODk2XSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHgwMDAwMDAwMiB8DQo+IEZTRVFfVE9QX0NPTlRFTlRfVkVSU0lPTiBbMzc0
MTAuOTc3OTAyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDoNCj4gMHg0NTUyNDE0RSB8IEZTRVFfQUxJ
VkVfVE9LRU4gWzM3NDEwLjk3NzkwOV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDA0MDA0
MTAgfCBGU0VRX0NOVklfSUQgWzM3NDEwLjk3NzkxNV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDA0MDA0MTANCj4gfCBGU0VRX0NOVlJfSUQgWzM3NDEwLjk3NzkyMl0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4MDA0MDA0MTAgfA0KPiBDTlZJX0FVWF9NSVNDX0NISVAgWzM3NDEwLjk3NzkzMF0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDA0MDA0MTAgfA0KPiBDTlZSX0FVWF9NSVNDX0NISVAg
WzM3NDEwLjk3NzkzOV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDkwNjEgfA0KPiBDTlZS
X1NDVV9TRF9SRUdTX1NEX1JFR19ESUdfRENEQ19WVFJJTQ0KPiBbMzc0MTAuOTc3OTQ4XSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDA2MSB8DQo+IENOVlJfU0NVX1NEX1JFR1NfU0RfUkVH
X0FDVElWRV9WRElHX01JUlJPUg0KPiBbMzc0MTAuOTc3OTU0XSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDA4MDAwOSB8DQo+IEZTRVFfUFJFVl9DTlZJT19JTklUX1ZFUlNJT04gWzM3NDEwLjk3
Nzk2MV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IDB4MDA0NDAwMDcgfCBGU0VRX1dJRklfRlNF
UV9WRVJTSU9OIFszNzQxMC45Nzc5NjhdIGl3bHdpZmkgMDAwMDowMTowMC4wOg0KPiAweDAwNDQw
MDA3IHwgRlNFUV9CVF9GU0VRX1ZFUlNJT04gWzM3NDEwLjk3Nzk3NF0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6DQo+IDB4MDAwMDAwRTYgfCBGU0VRX0NMQVNTX1RQX1ZFUlNJT04gWzM3NDEwLjk3Nzk4
OF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6DQo+IFVNQUMgQ1VSUkVOVCBQQzogMHg4MDRhNTdmYyBb
Mzc0MTAuOTc3OTk1XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogTE1BQzENCj4gQ1VSUkVOVCBQQzog
MHhkMCBbMzc0MTAuOTc4OTk0XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogV1JUOiBDb2xsZWN0aW5n
IGRhdGE6DQo+IGluaSB0cmlnZ2VyIDQgZmlyZWQgKGRlbGF5PTBtcykuDQo+IFszNzQxMS40NTI2
MzBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBEZXZpY2UgZXJyb3IgLSBTVyByZXNldCBbMzc0MTEu
NDUyNzgzXQ0KPiBpZWVlODAyMTEgcGh5MDogSGFyZHdhcmUgcmVzdGFydCB3YXMgcmVxdWVzdGVk
IFszNzQxMS42OTkyMzBdIGl3bHdpZmkNCj4gMDAwMDowMTowMC4wOiBXRlBNX1VNQUNfUERfTk9U
SUZJQ0FUSU9OOiAweDIwIFszNzQxMS42OTkzOTNdIGl3bHdpZmkNCj4gMDAwMDowMTowMC4wOiBX
RlBNX0xNQUMyX1BEX05PVElGSUNBVElPTjogMHgxZiBbMzc0MTEuNjk5NDc5XSBpd2x3aWZpDQo+
IDAwMDA6MDE6MDAuMDogV0ZQTV9BVVRIX0tFWV8wOiAweDkwIFszNzQxMS42OTk1NTNdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOg0KPiBDTlZJX1NDVV9TRVFfREFUQV9EVzk6IDB4MCBbMzc0MTEuODM3
ODEzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogcmVzdGFydA0KPiBjb21wbGV0ZWQNCg0KTm90IHN1
cmUgaXQgaXMgcmVsYXRlZC4NCg0KQ2FuIHlvdSBvcGVuIGEgQnVnemlsbGE/IFdpdGggdGhlIGZ3
IGR1bXAgYW5kIHRyYWNlLWNtZD8NCg==

