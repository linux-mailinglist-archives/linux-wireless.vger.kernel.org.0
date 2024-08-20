Return-Path: <linux-wireless+bounces-11699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE695868F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB3B1F277E3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AC18FC9D;
	Tue, 20 Aug 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVWIlS1d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB318FC61
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155635; cv=fail; b=meY7oi+X0bqjVTqAYPJotkMsCk1hrHU49jV0Xd4Hn//PiaA+/yxFpTBT0deddf7nHSG1H9WsAxzQQEwkonqpIhXldrukz2oHaaQiS7YDnQDuRho/9x+KDyZjuOfFlheHkNUvYRlaNEFdA6UpnuumAmtylFbLhNMQiIUzV+p0nFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155635; c=relaxed/simple;
	bh=nYh4sFFyA5zlqduqZu/zn7mRGqOK6lYJOd9OaN+kOZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tlrhwf8TxvDlipdgKVK7E7F6CpiPjc2x5Z/tlSVmvgeyWXtW5AquuBoG4arfV7b/BjYicZP+jLs8oBm9j6Du9pjr0pq80ACoPLs4O5I0Jtd2LR9jJwQtHxE3KsOQBh7btGqEIZUx07SKY5Q24hX8Fxr6YaS8TkkyaVQKbqdy7wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVWIlS1d; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724155633; x=1755691633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nYh4sFFyA5zlqduqZu/zn7mRGqOK6lYJOd9OaN+kOZY=;
  b=AVWIlS1d9IOlqI7sfhVtOgem/qKxoSLYnfF4aatPzU8KTMulZ0GuA+1e
   KZz6d4WeOkqYYjau1F94FWGT9YB3EdUHNdmwZzGMoGY0QD/gKHtES0jtg
   hMl5GUcMlT29w05d4t2Gd4N+8aPkfNTMLjV0R2UT92zLPOaXJt1qY8uU2
   GvjsEEnR7xM7WsOmGiOusm56pY73iOmu7k93n5Kg0Q2Ur0SPRGq+uhW6R
   YsJ7W91s7gdZQ3YuE2M/X9BooYw5vXycCH1QfnrmhTslz/oa9DomdVeT0
   zcQfGVc1hI235Kcq1YcnGYY8y0AW2gNhVkgellWhpRaX2KDa6YAge7Tas
   w==;
X-CSE-ConnectionGUID: 2+6v1G+vTXihwOpeMzhffA==
X-CSE-MsgGUID: N/AKLrveS+mzAh2VxHQaKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33604361"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33604361"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 05:07:12 -0700
X-CSE-ConnectionGUID: CeslUp13Tgu/LL0nKhDwPQ==
X-CSE-MsgGUID: SENRRcaJQI2A898o7fFxVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="61472693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 05:07:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:07:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:07:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 05:07:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 05:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwnZdg6HWOMHaswSCUfae8ku8WUN+OS/bkdmiy3+TerUvbIkrDYFz18AH1HDlxJzT4dS2mamAcqw34D6AlPDeDHEeZIVllmbza5QSYowwVwOKHNBj2WBLsqA5uXnDBJfKgEn8JGmo8bLzdMhyfBbi7lAHD50XBtwCt2HCylsK4HmQvIOV5mZUekssV0HT5XiiaHiHI51rUdAUksQfrSMC7owE4iiJjkdgHKYuv18P0oLCRN/2HPEi3fmd1K2W0831LaYJliUteta7iEfchQnoTC9h29m5PsULCYFijGzXK6KpaxA7xqu84WtH7g3OjhR37lfQKDMBxx1Oc/OBJ3t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYh4sFFyA5zlqduqZu/zn7mRGqOK6lYJOd9OaN+kOZY=;
 b=yXnaDZko6e7d5YncQyhIDw/1bojQAzymFZxl1L+n5rc4daWetvyWxKa9rWV4NPaQoRPYNkkEgJuZAwbFHT/VxoK+zeP32/eMR37Y83IdANs5hQdLWpUpQ//TAZtjz+TR85eDIAiYq2IUnxP1lPB7jPH7eoiBvbhTCkpruNSfg+67xZqO6ky/D72XiRjwzPrsgkBgUaCyOL2tok8a0mIhfK9gr0AxxeHfjr3Ol2RAL6pQGJ7SP1TNQGuwubh1/KWyWua1Xt6lCJ0y1nNhShy94mWzIgnIY66jtpjEYJ4R0TV8jsTeOkeQ4l2Df2ifW0Binv+nfZGLLgghrpe+LGPj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:07:03 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 12:07:03 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, Jonas Gorski
	<jonas.gorski@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
Thread-Topic: [PATCH] wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
Thread-Index: AQHayG2W4rwwjnQys02DEX4D2YfyULHbbdWAgAAKSQCAVOmrUA==
Date: Tue, 20 Aug 2024 12:07:03 +0000
Message-ID: <MW5PR11MB58103A7C382B21A4821B7B6AA38D2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240627103936.4a7cd28f3136.I328a219e45f2e2724cd52e75bb9feee3bf21a463@changeid>
	 <CAOiHx=kKuGWhEQrtRXx5HJqR46D8o34ug8iXrc0nBkCFiZzjPw@mail.gmail.com>
 <465aafdc7bdcc61177f28c83f3c87c2f8560e03c.camel@sipsolutions.net>
In-Reply-To: <465aafdc7bdcc61177f28c83f3c87c2f8560e03c.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: 2ac185ba-0c15-4eef-68b0-08dcc1109a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TERlN01PRkRpc0xvRkt6NzdZQ2d2SEppd2ZMb2doaHM3SmRtTFRLN0hVdlRr?=
 =?utf-8?B?L0d5eHpUMlpTOTd4TGREWEo3bWdmNUpnc01vNFZEU1ZtTGdGSlpqY2hrTEN2?=
 =?utf-8?B?RUMrSjU4WkVMSTBKQlh4a1N5NzR3VDhTZnI3OGx3Z2pKT0pSMk1BUDU2M1FM?=
 =?utf-8?B?TVRTdmUxRWg2NFNyeTl1bmxKeEhmNmRoK1hKZGhaRnlkSG9WMTRYNUZJYTdh?=
 =?utf-8?B?WE41SHZzWWplWW9xTjlTeXlzb3VaVUFFbERsSWV1ZjVkNG96Ym50QWRxMExR?=
 =?utf-8?B?YnF6TGxxZStIemozdmpjbE1YMFRkaUpzUHFLcHF2QW80a2ZSUWlDVVFXQW52?=
 =?utf-8?B?ZGxCY0xOUm55eUFRaS92NklGa3NqNXJIMTFuYjd2Z0xteG5CVDNTUElYT2F3?=
 =?utf-8?B?OVAySXhvdlVESjF2VnN0cDZBeWVNWFZDOTEwTVJlcnlJYVVVaGlnQUJ4Wnkw?=
 =?utf-8?B?NWpYQ2NsSm9iQURJWFhNMllhcWlST1BIVmliM29xbEpIcSttVHdRVnV5VmNi?=
 =?utf-8?B?OEJUNlhwS1hMRTYwcjIyYkhNRjRWbkFVVXN4eTlwdmg2aThsOWFRMC8zTHNw?=
 =?utf-8?B?dXhyUURFOEtpdW1WYzdrdjgzNVV2TEdERy9uZDVkdDVSWU9vYXNwRVBCS1Zp?=
 =?utf-8?B?U1ErdDk5N05TVWEySmNOdjdDS053dURiSGNPempESXUzTExKcXFFSjZyUlpw?=
 =?utf-8?B?R05mRnlXRzlNVzhpR1Q4ZVB0TndiNjdEenBhc01pZzFQcS9HandMaWdibk12?=
 =?utf-8?B?Rkwza2FFeHg5OEVleVBCY3N5RHphK2M5V1hWeVVSS2FVQjBFcnVpN2hwbW8w?=
 =?utf-8?B?Z0txdkx0WGt3ZWRIaGgvTUFyek5ZQytXbUN3OFFlMGRnVFM4c291L2Fic1hx?=
 =?utf-8?B?bElYekRoakhhZXdkcC8yc0JTZ3NxTEpsYkhQQ3VWWTZnSnlkdi9Camt2em9I?=
 =?utf-8?B?VS8yRDFKUkQ1K2NhaVhJRS9MOC9PZXlBeDNGU0NUK2tYcDBONjMwZmZjQUdt?=
 =?utf-8?B?THppTWZCTmdBeXRsYUZPUlFRQ3cvYnNoWDJxdzlhNFRnMDNkQ1k1dm5IaHBO?=
 =?utf-8?B?MkpRdTZQamVscDVZeGoyUXM4MlBnc01rRFdWMFpDTElOOHAwQ1hoeEdKdDhP?=
 =?utf-8?B?c2RCZW16b1RIRnVsMTIxQzZuTnVoSHJhWWNpN2JtTUJZM2FNM2JiY2NaUWNt?=
 =?utf-8?B?N0tFbUZ5clFQeXdmZmVYREFjdzVhRm1CcklQVWVPMCtBUXpaOEZRdUhTdGE3?=
 =?utf-8?B?MW1iWURGYlg1Vy9UWWtxdkREQ0RCNXRiOTk0cWRFUitNeEtvQkpON04vS2h4?=
 =?utf-8?B?Mys2L1BsbzMweWdHM2VSS29pcTZLSTFrNHkzUEFxL1RzTkNsU25jTlM1UlpQ?=
 =?utf-8?B?MXMrK0tKWVpZNm4zVE9sQXZveDZkYzRYaXJrdG1PY3o3ajhvN2JxUFczQ2tX?=
 =?utf-8?B?WHRwMjY1VjlCbUd0c1hUOE4xOFROTU1mUTZoY2RrZkdNSGJ3RlRNa0crQUVY?=
 =?utf-8?B?Q3hJOGhBeDc1bGdvbGtkVEtYSWNXWTIvdEt4ZDUrV2dKY0hHVXJSL0xSZ0hC?=
 =?utf-8?B?QjErTmNjRmdmM09vc1RTeHJJaFV6UWY5OFpDdXFXT1JsRDNBZktFV3I5OTY5?=
 =?utf-8?B?QThCMkVZZTZXV2VwYzc4TndiT1VRcHhXZ2diYjdHZG5UaWY2MFJ3ZGNMZjA3?=
 =?utf-8?B?V0JPSE5nSDlhTWdpdGtvQ3JxYnJIWk5NamtONUxHTHREblp6U1Iva2ZQMS8w?=
 =?utf-8?B?L3RkcVZ2cWk3a2l0emw2Y3RDN0pwSUNGSGNoa1J3VlVxbzFYWUVYbmtFbTZj?=
 =?utf-8?B?b3Boa0R0SnpBR1lIaXQxN2NFMnA4ZEdzQW93d1EzbHkwWElqL1gydjk1V1JB?=
 =?utf-8?B?YWZMVTNLL3JjUHRoQlRmcm92S2pTdEJjSG1aTnRtVlNaUVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3Vydk1TemZBaHRUcDJGTUNiV1ZHQTlwNVIxei9YZERySnZmVWw5aWlsTlZ1?=
 =?utf-8?B?eDI0VFNKZ2JVdFFSR0loUXBMTWg2bzBTL1psNzhyMjBuSWYyLzltTGIrZU0x?=
 =?utf-8?B?V09pUzdCQ1M5Q1lRdFpXWHpxN1NoYVFTYlExbjI1Q3NpSDRVRytuUVJrK3Na?=
 =?utf-8?B?VFE0YVVMWk1ZL1dNQVU5RW4zS0pvWll1UGJ0VGhxUjVraDljUlVsbFRQeFR0?=
 =?utf-8?B?aTRsQVRrOThLUEFKNmtSRlZ0TGY4NHJEUVVPQ1llNjF3MnBNYkJ6RENqZW5E?=
 =?utf-8?B?dlhZd2QrRUs2bURwZTBxWDNyZ2FGQktCWmFRRktGL1ZiaTNGRlNrTmxqQlhl?=
 =?utf-8?B?M2Mzdjd0VnFPQkNmNTB4ajZpd1lCOE5Ob1Z2WXdaNEszSGYwZy9zVWc1TTlX?=
 =?utf-8?B?RitOTnFzS1ZYajR1MUEyRFFQQ3hyWC94UVZldjN0emF3TW4vU1VzcmRxb0Zz?=
 =?utf-8?B?Y0hDSFdGL3gwK3dDNWt2MkUwV0tibkFPNnNoVlVaQytoTTUyQThscjFFVWlR?=
 =?utf-8?B?aWltOVBkMC8zb3g0ditpOHEzK1VJQlRSTHV1MnNuQlBNeVNrQ3locXdhL3Nu?=
 =?utf-8?B?UEJCU2c4ZmgxN3B2WnRabzZWU1hrUURiNXVyVWN2MlJiVk43ZVZTVXJGakts?=
 =?utf-8?B?NHh1RFF5N1R5SzVFM1JUTVl3SDhncS9xQ2YvMXQ2VFJDWWlzSkVFTm9SbEE5?=
 =?utf-8?B?eFU2VEJwQ2JjUDhxM21RTkZVRWVQRU1wMHVCUTRqSHBrQVUrYkw5dlVnWjlu?=
 =?utf-8?B?YnZWN1psRTZOZ2lPc3FaR2pLTzRlZjN2d3BWeVdRKzJsQU1KZVlPTDJYT3Q3?=
 =?utf-8?B?dVUyTnVyc0tpK3ZqcFRZTm9xNXBZRkFWUFNiZWRZZE1BVHo1QUp0TFNtRUFM?=
 =?utf-8?B?LzNCem1oaFVKc24wbWRiYnhQRDl6WUdySGtEOXBZeVhlTk94WGt4TnN1bHdK?=
 =?utf-8?B?YUV4dm9SVzRwWllycnhidm4yeXF1ck9CaWU1b1R1Vm02SGp5d0pVWTV6UTdC?=
 =?utf-8?B?TkQxSWFhYlNiSEwzVVZxQXVKT2h1ODdHK3Z0Q0Y5WWdqUDB3R1pFSEFCQXZT?=
 =?utf-8?B?RkxPaUtqcGdwZllralVscklsQ1BwODlydkw3MnBRa3F0aDl1UTlYZHRPRHpt?=
 =?utf-8?B?dDEveTB6OXBwcVZXZHQ2bmRWMmdqYmFzZzg4QStwbWJIanFieFdLUGZtU2hk?=
 =?utf-8?B?a2JkdXNjVXJNNEttUytubm9teWhCbHZ6cDZWQjNUSGpwQ0FTYktrQ2tUTmpI?=
 =?utf-8?B?SzdJc3RHaDNBTjRZTlVMeEZKMzlyNWZjUU1rWTFsQ00zZFFIWll6V2dzcXJn?=
 =?utf-8?B?Wi9lQnJpVHNGaWRSWHI3QlJJdUxkVkxCNGFPQlpWWE02WmoxWFN4Q3pSMFZZ?=
 =?utf-8?B?SzhFWkF3ckRvMlFhZ2JYUnJtcmJWeU9nWnFyOWVzMUJDK0xrQk1mWFNuZllY?=
 =?utf-8?B?cGkxT045VUhqNVR5OGw0VTlsUjRKZVRFem1LbnFVVzVEU1Jkelg4MzdTNnlU?=
 =?utf-8?B?S08rWHBkcmZ0aDZST0dyUUVmb0liU045akVkQzVvSDE1MnNMNWVUZm15ZC82?=
 =?utf-8?B?WHZ4dldOWFd1Q0huMThQbnQrWHp5anFTankwNjZybW13VnVCbHAwaGZ1MjA1?=
 =?utf-8?B?R2Z4VC9UM29hNE10OVd4cGFEL2w1dURyd2wyOGxzQUN3UkN4L3JxNHUrRGE3?=
 =?utf-8?B?Q1g1L2pady9WQnJVRXJjSmd1UWJCUW9jd3pPYW9xSDg4ZzBaVzRuMnhKWnpJ?=
 =?utf-8?B?WTdzUEFMWnN4aktaLzloWUt6UHpPTjJtdWRYU3JkVFVLMEtNUmtzNUtoVCtJ?=
 =?utf-8?B?N0ZhU2lUaHlvcGFRcW5waGZHOXA4STMzQ0lVQ202ZitjWEFYd2J1T21NSlZU?=
 =?utf-8?B?bDdYR20zUFBJRVZOMnZ4ZXF6Z2NvZTlTQW1rQXozS1M1c3JDRWFtTzRlSk1D?=
 =?utf-8?B?ZURhZnlGTnYwZDYxZjVVdXNCb1B6RW5pQmVjSDQwaURJUGNyalFMK2dXUDQ5?=
 =?utf-8?B?ak8ySVFNNmwralFMVGpDemNKcDZQL2Z5a0NRaUpWR0pBQ2RKeDdQdHJDWnUr?=
 =?utf-8?B?d1JXMHI3d1dDdDJhbW83dTBJVTJ0ZTFmTmp3Lzg3aStpMlZkb08xeE5qSm11?=
 =?utf-8?B?eXhtN0d4aTIyTlZIZTlFRE9wTGtYRllBWHlIUDBORDRkNGVwbDhJaUNVL0FV?=
 =?utf-8?B?VEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac185ba-0c15-4eef-68b0-08dcc1109a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 12:07:03.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxa5lHaUhgroWACnt6OXvncygPlDxpHdDrhrfBH+tSlDVpY4r6gkv4dlBUYPw277oJDmsUIbJD+BRxrFh9BeA541gaN0Xji6TwPqWWIQ5YTOtZRNoY20gQo8I1S7qk61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-OriginatorOrg: intel.com

PiANCj4gT24gVGh1LCAyMDI0LTA2LTI3IGF0IDEyOjQ3ICswMjAwLCBKb25hcyBHb3Jza2kgd3Jv
dGU6DQo+ID4NCj4gPiA+ICsrKyBiL25ldC9tYWM4MDIxMS9tbG1lLmMNCj4gPiA+IEBAIC0zNTIx
LDYgKzM1MjEsMTAgQEAgc3RhdGljIHZvaWQgaWVlZTgwMjExX3NldF9kaXNhc3NvYyhzdHJ1Y3QN
Cj4gaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YSwNCj4gPiA+ICAgICAgICAgdTY0IGNoYW5n
ZWQgPSAwOw0KPiA+ID4gICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ByZXBfdHhfaW5mbyBpbmZv
ID0gew0KPiA+ID4gICAgICAgICAgICAgICAgIC5zdWJ0eXBlID0gc3R5cGUsDQo+ID4gPiArICAg
ICAgICAgICAgICAgLndhc19hc3NvYyA9IHRydWUsDQo+ID4gPiArICAgICAgICAgICAgICAgLmxp
bmtfaWQgPSBzZGF0YS0+dmlmLmFjdGl2ZV9saW5rcyA/DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fZmZzKHNkYXRhLT52aWYuYWN0aXZlX2xpbmtzKSA6DQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsDQo+ID4NCj4gPiBTaG91bGRuJ3QgdGhl
IGVsc2UgYmUgLTE/DQo+IA0KPiBIbS4gV2UgZGlkbid0IGRvY3VtZW50IHdoZXRoZXIgaXQgc2hv
dWxkIGJlIDAgb3IgLTEgZm9yIG5vbi1NTE8uDQo+IA0KPiBPZmYtaGFuZCwgMCBwcm9iYWJseSBt
YWtlcyBtb3JlIHNlbnNlLCB0aGVuIHlvdSBjYW4gdXNlIGl0IHRvIGluZGV4IHRoZSBsaW5rDQo+
IGFycmF5IGV0Yy4gdW5jb25kaXRpb25hbGx5Lg0KPiANCj4gV2Ugc29tZXRpbWVzIHNldCBpdCB0
byAwIG9yIC0xIHRob3VnaCwgZS5nLiAtMSBmb3IgYXV0aCBiZWNhdXNlIHdlIGdldCBpdCBkaXJl
Y3RseQ0KPiBmcm9tIGNmZzgwMjExIC4uLg0KPiANCj4gSG93ZXZlciwgZHJ2X21nZF9wcmVwYXJl
X3R4KCkgaGFzDQo+IA0KPiAJaW5mby0+bGlua19pZCA9IGluZm8tPmxpbmtfaWQgPCAwID8gMCA6
IGluZm8tPmxpbmtfaWQ7DQo+IA0KPiBzbyBpbiB0aGUgZW5kLCBpdCBkb2Vzbid0IG1hdHRlciEN
Cg0KQnV0IGRydl9tZ2RfY29tcGxldGVfdHggZG9lc24ndCBoYXZlIHRoYXQ/IEFuZCB0aGlzIGlz
IGNhbGxlZCBsYXRlciBpbiB0aGUgZnVuY3Rpb24/DQoNCj4gDQo+ID4gSGVyZSBpdCB3b3VsZCBi
ZSBmZnMoMCkgLSAxLCB3aGljaCBpcyAtMSwgbm90IDAuDQo+IA0KPiBJbmRlZWQuIEkgZ3Vlc3Mg
d2l0aCB0aGUgd2F5IGl0J3MgaGFuZGxlZCBpbiBkcnZfbWdkX3ByZXBhcmVfdHgoKSBJIGNhbiBq
dXN0DQo+IHNpbXBsaWZ5IHRoZSBvdGhlciBvbmUgdG9vLg0KPiANCj4gSm9oYW5uZXMNCg0KTWly
aQ0K

