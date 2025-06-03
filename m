Return-Path: <linux-wireless+bounces-23576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965ECACCC72
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25A7188DD3F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219221E5B94;
	Tue,  3 Jun 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHiHB8kV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198D19AD8B;
	Tue,  3 Jun 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973011; cv=fail; b=ApdC12TBY2/atxAmQF3H7YHKGRRCHPIvz7ecQkpHVDrDX0lY6o99OHFxlJP6nbPTEgBTPmBRco8ddPTVZQfpy38ApUZvju/nK+y7fyUnSxyI1eWhjg8prN6dIv/pBnMHdGwAgbHzV9iIV0H1x+lidicVKl6QjKRETHb6/P4/y7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973011; c=relaxed/simple;
	bh=Yyq/yglbF75i9daRKOS7ukxNVmN/lOdBcjgEJhbW7OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bs1yfqZnCUqTMZUCDRfydcx+GjeXMAw8L4pmlZUj8nDbKW0qPyS4soJpu7TclN1BpAA6WWHiNS3ndEOUzn0p2dN4HI6fhv+/oCpVpj2PV0R2f3+y1nf5VV2lkkBXJAg3Jf5Myk9zqWljN+/DqpRKl7WJqEh5JNf2S9Jti+aHMnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHiHB8kV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748973009; x=1780509009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yyq/yglbF75i9daRKOS7ukxNVmN/lOdBcjgEJhbW7OY=;
  b=jHiHB8kVL1eFhgk6us6ute4xQYTAV2CpI9CdednMeOlJTVJMYqWJ9Qrl
   dMxWQLS9uT1oFjMkE1ZqIEP83CtrMqdDS6+SgMyfMmDbmu/POGB6zJ8li
   w7XtvVSDof1HDrPjM2Gb1pRaasS9R64JPZZgT4+n+ZT3tM5D92IXryK5e
   bqxUOoAMUZMAeVczIDJAmmqA19FE8/FubKlnxR+EpPcbPR4VuvJdCGf9W
   R3JIU2DJT/tIXraowEHz0ZEZKxA/LVqgTeJ5ycTZ+Zz0C03K6ijTiGcfL
   xcabKemJas0f9URl0I6kLqSfZhkMf9O0GCiursSy10iafw0H91rONxUIu
   A==;
X-CSE-ConnectionGUID: kXZ+uYbuSrKYWzzCqw/lxQ==
X-CSE-MsgGUID: fTK74LotSYm3lEhT5GhkDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53654348"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="53654348"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:50:08 -0700
X-CSE-ConnectionGUID: Fk+J+TaHTVuJrbEg+5J+sA==
X-CSE-MsgGUID: h/U6XjeARreCGiW49Q5Qnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="175876475"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:50:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 10:50:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 10:50:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 10:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJZsyrAUvvQVoVFXpdXRgf/Mg8XdxzDg1i2voZdIE1dyn7kF0Y638vI8FImpTuwHp1DCpLh4otL4vXhDBrTXfCofdeUgNGNBeOfj4DXvvhDsRmOhOCVkziEPCDJk7pwAW/XAA+0y6LirZ2iBgOClpFZm1b7CpHJbIzoq32YYffbSqAYcnBu+JGOm490SXZt5M2tk5z8vHrfMfOot9S00BVkVTHeVkCwhl3XYr7pzUaaSzGtFPb73/0tUmZEltBHyMQTqULcjF6nQGBN5CcjPWaE2nu/Qbltw4/0Qxx00F19GKI3vSd9X4EOEG9mSlS576Py6aBLm17mBb0aE6FIfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyq/yglbF75i9daRKOS7ukxNVmN/lOdBcjgEJhbW7OY=;
 b=PR8Ub8kJGdYMhntJYrlM4oTqg8jP6u1KNaQlQ4PfVxI8tPNI8SEX4U1ATV5Bx2QVnAXAc/b0KWLrFoVqH3IDADW7Pmm14Yhz3EZCgJTGuX4hKwEHKfISciwctud6x/xCV7BoPOE7f+JLa44teVGG7PqgX8ayXu70kpJjZBO8U9d2ryOOObqPimeortfmd4s/juIwNcL91y6CxQPV5XUcyp+O2zxH/xDgT41UUgSRRvo4qY83lTUdac2fA2mspENR5b34CrsE7PQAoJnvK6WaP3/sBq6P/LZkI7oTG5Sp2gKHcnyM3mvXTx19jfUU4QKK1t/oCrYjlB4zr/FwIkaEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH3PPF10FBEE80C.namprd11.prod.outlook.com
 (2603:10b6:518:1::d09) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 3 Jun
 2025 17:49:51 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%4]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 17:49:51 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Damian Tometzki <damian@riscv-rocks.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Thread-Topic: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Thread-Index: AQHb1K79w0jCIcYeiUWI5OXOWSPRVrPxtirA
Date: Tue, 3 Jun 2025 17:49:50 +0000
Message-ID: <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
In-Reply-To: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH3PPF10FBEE80C:EE_
x-ms-office365-filtering-correlation-id: 9f428f2d-a135-4bd2-d175-08dda2c70a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aG45eTRWTTZqN0Voby9sU01DVXNBQklyU3p4MkFWRzhxT3Z3MGV6Ukx5RDdi?=
 =?utf-8?B?bDFzUFFJSC9PVXRqRmlCWG53bG8xNUJoSERmOWF5YzZHMnpqcUppNkd2Njdu?=
 =?utf-8?B?M2gvcC9GR25ycHcvaStsQVliYkdyTFI4b1kxS0dFalpnUGl1NU9zYW5xTTFj?=
 =?utf-8?B?eitldXJxdDczMGNPUTBKZWRoKzJET09DY1lzaTNwWkY0Y2QrL2lOZ0tjSUZP?=
 =?utf-8?B?UGtQYnFIN2lMT09JY3U1QWtvUElIM1MzREF6LzExYUsxYUtLZnJlemhuenNC?=
 =?utf-8?B?VC9JZWpHcmx0NHpncUkwc3ozQnJZWmxyZUhBZWY0cDAweGlmazhkN2oxaWx6?=
 =?utf-8?B?aWhtTVR6NmZIbGR4RTViUEpEVUI1em1QeGx1L1c2dXBaSmVCRi83TGIxdytB?=
 =?utf-8?B?WWExSUVUR05GYVQvYVhOVWlGSFJBVkJJY3NYQWpoQXZOS2hkWm90ajM3K2Ru?=
 =?utf-8?B?WENsL0hQUng3WXJ6V3p2SVlncjJsK05SbUNuSWxUODBKNVVRUFg2emlBT2Zi?=
 =?utf-8?B?SkNpTkZFSmUya0xldHVPRWRPU3ZOaktGU3VHS2JYemliNGNOZ01mbUR3b1VE?=
 =?utf-8?B?NkFhZVZLVVRndGM1a2JNNHJvVUU3cTJzMHRKTlVoQW9YWXBsOHRwUW1rY3Bp?=
 =?utf-8?B?YndEa1oyYnFsTGQ3ekhwd3EzbXB2VDlNbUhnNkZSakdzbFhWT1R1SjNRYnRp?=
 =?utf-8?B?M3NKMTVuOWI4citiSHEvVjVpdlRtT1UvZCt5dlhtbTBMZlFKQ3RJbkc2ZTRG?=
 =?utf-8?B?c0plQnYvQ2QxRTMvcm5iYnJNQWVjN0JhS0J3T0FjZnRnc3RnUDBOcTl5ZkxV?=
 =?utf-8?B?dzg3OUZhUHZLeVdFN3QrL3UxYjZPRE1jdEMxb3RUVThxbFd4MEErRUEvV1R3?=
 =?utf-8?B?MEkvajRYNHJJSkdEK2RFUmFRSTlPK0ZLTEZ6elpuWEFoMm5zQVU2dDYzeExS?=
 =?utf-8?B?OWRkdUMwQmZIcVdZWFNaVDBQM2VZQ25zbDZuQXNZUWtLbXdzSFk0VEMyaHVD?=
 =?utf-8?B?anhPek1uTjJWSE41N2ZOWGNuclRYSTIwd3BlR2lJVHlOYmpmSDRlZjBzQ0Ix?=
 =?utf-8?B?b2hZUzBwdjJzeDJpQ0dHNis0OHJ5aThjWkxxbFJqcG9yMzhKZkx6eTJRdkxy?=
 =?utf-8?B?alNIRGJMN0I1cTZVenlZTWNwNFNxRi9Lam5abVJmZy9YcEJWdHdIVHZPV252?=
 =?utf-8?B?R2Q1YkVWdnc1Yml5MTZJTFV6b000RHc0dm4xZ2lHRUljUHZOVTkxZ2lpUE91?=
 =?utf-8?B?RXZXNGp0cGxkbHl3STZReEVYWkR0dWFGbDFya2h6V2lYZDlPTHpwRUVEeWVI?=
 =?utf-8?B?anp6RlN5bC9qTVBQKzlGeHBjOENjUGFKTisxOEl6RlowVjlWT3QvRGNDd3RP?=
 =?utf-8?B?ZWV5RnRXaGRqdkpUTkpPU3N3TnRXeWcvT25JNnlQU2tleVU3czdsNzV0MG5C?=
 =?utf-8?B?Um51dDFJOEE0RTZxNFlZSUlsL3BJTlJEN2tacDRxWUx0SHhUcjRLczZxTVpx?=
 =?utf-8?B?ZUZPK0diZk11ZGl3TjhqdXpZQS9FaXFaakc5NGVBekpJcXRlTEZKelM0M3VX?=
 =?utf-8?B?TkJ0RHZzQkcxRGw3aVoxUWZ6aUlzMi82S2dHV1h1UllTcGcyRVhaZlBxUWJ2?=
 =?utf-8?B?VUtoS3NOOFZXbFdjcjAxbVZxVy9qRG5ROTZILzFiclNIZkhlM0FRc1V5U1Fp?=
 =?utf-8?B?NFVwV2ErdC9YM1VWOUlrTlVXdXBQNlQ0eEZ3N0JsZ21ObkQ3cEtFWlkzUS9k?=
 =?utf-8?B?RlRjWnQybVN6Tkc3czBxMXBpMGZLTFJhdU03aEFvdnI0WFE1WCtiajVJUnhr?=
 =?utf-8?B?Q0ZmdUtyMDVYZzZXcUhCQmR2bmJLK2Rwc21ZVWp1S05FZCtCZy9uVXdhdlU0?=
 =?utf-8?B?LytmNGtFOEdVbjVad055TDVWSHBaVVgzN1lWdFRpNjRUR21pMFRYbCtQK1Q2?=
 =?utf-8?B?RWxUcGVaSjdCbE5DZnhPWU1qeVlBbUx4dlJFQTFzVi9FaXc0T1p2TEtTbGd0?=
 =?utf-8?B?bG52bGRxckpRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNvRHNvSVdlL3NIN1RwTkMrM25KWWlQeVhYQ21kVFdidWwvYktPNk9TbWZ0?=
 =?utf-8?B?dm9LbGJ3US9HNmxVNUlQaXZTUGhxcmZxamRQaVhBWVFQUEJod3V5dXlBRnE1?=
 =?utf-8?B?K2FJbEpLRTFXbUplR1l1T050d1ZlVkVDRllBdWRFVDc0SHlhUDNwOFF6TXdj?=
 =?utf-8?B?QmE0Q1J4djZHeXdadGFNOUQrSXpVR3RWc2JaYVRPbUxoK1hpQytKK3U0d1pZ?=
 =?utf-8?B?bWpHMjFUUDFBd1V3bG5IeW5kU2xhcDhnd25ERW1GM1ppU0VlSmxtZkhYcFNh?=
 =?utf-8?B?VmEyQkZjaUFtVi9BTGFpRDJYcUVuZ1Vic3pKWkR4TzNnUmxWVXRSMkpEM0lH?=
 =?utf-8?B?Vjc0Rkt3UDRmNktpU0pYa3BCd3pHczE4TlRjeFhGVzg2UjQ2MHFPUXRsU3V4?=
 =?utf-8?B?eDAxT2haMng5cDlEdlRIcXFYcVQ4QUh4RzF5WHR5UzFKekdwaThTZXFmQ3Zx?=
 =?utf-8?B?L1dJVE5MbGo1UHVlenRKeldBcHdMSmRlSzF2NmZ4VldPcmFhZXpSOUFCdlNk?=
 =?utf-8?B?Qk1FRUxRQmpkN3doNXE5bkRqZ1NMdVlLZWJiK29PL1Y4a3NId0tOb1VuUTFX?=
 =?utf-8?B?eFNsU1daOHdZVVRrQUxQbXkvOFp4bThrbzRMaWlJczBGbVkwem5RSktaMVNJ?=
 =?utf-8?B?aXA5OFJuVWM1QXdZeHNoYTRDT3J6Wlk1MWRmOFp3eXpDTy9NaU82Ylk1a2Nv?=
 =?utf-8?B?K081dmxsSE40WitSbFJQcUxTdkRZWDMxd0YrMEZjVWFXTnRiTml6UFZ6clB4?=
 =?utf-8?B?cXZ6S1Y4aENuNWdBVWQwWFVHTnZnazVKbVgvT3F2L3pjTWRXbEZwVlFhcjlh?=
 =?utf-8?B?UHdUaWRLdFFhaDFCNmtaWmZRSVBuakkvbUIvTGliNGROTmlUU0hGOHN0WGM0?=
 =?utf-8?B?YkJjUFdoZnVDREY0L1ZRME8zb2lKY2RMdW1PVjFwaTU0bzVZY1lNbmppY0hY?=
 =?utf-8?B?WUZZSk1INFNSMkh4N3Mwd1h0TjQyM1IyYXhBL055cVV3ZmRwWjhFdlZSZzNs?=
 =?utf-8?B?bkdmT1JMOUp2VzFWenhNeXlPbEQxaEEvbG1nZ05Wcm4rWXlIZi8rWDBDaWMv?=
 =?utf-8?B?SzVQbllsaS9QK2xYOUdUVDFlZTk5YXBqODROdDQyVWN1NWlTVGtINk5GbDl4?=
 =?utf-8?B?QXd6YzdybXpuUy80akY3N2lsMW1odThnTEdXRkEzYWxkS2ZCTi9yWU5vTjNP?=
 =?utf-8?B?R1EzdTFTZDcvMk9LUXlKOGJKVXc0aGF0UnVvb1Jjdlo1L21oODhBcWlBc3A0?=
 =?utf-8?B?SXMxL0JOS3o5ZXhmRThUbEVuUWhsRWEra2w2eVIrRVlna25XTXNvVkpzMHln?=
 =?utf-8?B?Q3hjZnUyQS9COVlvZStxVDNBNXZpQmpJZHBic3RBNTkrc1NiOG5jb2RKYmQ1?=
 =?utf-8?B?enhKeU82S2xlU3JyNmlYSThXdWl3YWZTZGhTOWVVdVg3NDNUT1RXU3JxMmM3?=
 =?utf-8?B?WWoxUnkvTm9JTHcrQlAraStybVhsL0lxQkJmeEloMWNhbjhHODcxcktyQ2Jx?=
 =?utf-8?B?b01Xa0JSVlpCZk5ER0toM3R6UWh5d1dxUFk2ZU4wOUZKVU5MbFIvNmJZTllh?=
 =?utf-8?B?TmRoblQ5a0hHKzJhamJBbktMNUF5ei8zZTJuS25BdWt3a2hmYVNqeDJBU202?=
 =?utf-8?B?aTZVMy83WmI4M3k0Sk11RVd3dHpjZHo3Z0pvZ00xYmF4dXR5WlpjYnI2REQ5?=
 =?utf-8?B?eE0yYVFhVTZmR3lPMlNZK3UvSkZ2WFhxMGZ2ZTBSNS9GQUVzdmR5RzdrdmRF?=
 =?utf-8?B?bzN0aFJ3MS9CRmtIMFpKaFJROWo2NXVGZVlxTnBpd08wQlJoY1V1TllaRHEx?=
 =?utf-8?B?MTk1YURiLzZXWHF0U3pUM1lxMk5CQ1BEb0VweU05SnRUZ0JVbGR4WmVSdkhu?=
 =?utf-8?B?U1ZpbmY1NVAvSndDRXFoM0lHRTMvUnVoZmVYY0RtMHRMVGRjbnF4WTQrTkxh?=
 =?utf-8?B?cXV0Ulo5dGJQYndnMDNVWmVsWTVxc09BZGhnWEQ3Uy9JemYyVWs3YldmQjBx?=
 =?utf-8?B?RlBjdXFIa2N6Q0tKYzRwSEhpWG1hcEJkSkVXL2hxWEptcVcyS2NzVzhDK3pi?=
 =?utf-8?B?SytaQ05CV3lZSGIrMVc0Q3NuUXR4cFJ0cGVkTEphVHpwNlNLSnBISkZaeDZh?=
 =?utf-8?B?VG83Wm44cmJJVDJoaUltbVFPRmJ3ZFdISkw1VFV1bGFkelVTeGtQbWJoWGFm?=
 =?utf-8?B?Q1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f428f2d-a135-4bd2-d175-08dda2c70a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 17:49:51.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pbme3VX0jZd71TVs68Blx9+q+9yWppc66/ePFOt7b7m4WXwKxSgUlYUXyat2aCNs4bF8zovav7QtokgM+59k0qZUndaAALEEeUCIP4St64/ffHc29VCfu4iLn4aNXh2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10FBEE80C
X-OriginatorOrg: intel.com

Q291bGQgeW91IHBsZWFzZSBwcm92aWRlIGEgdHJhY2UtY21kPw0KRG9lcyB0aGlzIGhhcHBlbiBh
bHNvIGJlZm9yZSBzdXNwZW5kPw0KDQpNaXJpDQo=

