Return-Path: <linux-wireless+bounces-81-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B87F91E6
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0059B1F20CD6
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B652469E;
	Sun, 26 Nov 2023 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0jkaYzc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612AB8
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 00:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700989101; x=1732525101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJJkoVrLYbjm52xGldwSzFCjMWMi8zeT8lY2UeYGQo4=;
  b=T0jkaYzcsHNQwkRGgLvu3+VQ7Y18qwGacrPw0gBqnmp/PandLCvc4r3d
   37HKLkE+Mhe3UzYWmZZaBL/yPB3wZ4y+1v23qKW4/j/NY3T3k1Q4WLoRG
   zuTfKwAetWFwFv6kKEJhgt/e1+Q96HzszrsObuB2gYYJX5VhjSj60g4Fi
   0nA3s3eo6nx82kzmM7Ds5+MmNwOmmZbly5rLKFd34CuFHMvx2OOFoQDMZ
   bBNbQA7qijhhQplVHGVfpKkp/rsQw1s0La4t52wvEmiQZdCvtri/RIh0s
   mud+aA2c+KUgkYbLdBH+D6T83PgSebPjbYsSWsu2w7zWvmklXBwK+abqH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="5801550"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="5801550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 00:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="1099473364"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="1099473364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 00:58:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 00:58:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 00:58:19 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 00:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIXjmlghW6rgxDg9tiWH86x0oBvUnesjsrOdl+BYuOreTF3KKz0Wkmid54AP1DrCGLtxbZz1d6ScrRpEz0JGIv96fnFY5Kg6u5Z87zv8E1W0UV8V10XtSiKSXhwU3nTGsJ5tvGBr1DL34Jt2bb0z8D+dEILg34Ge4B7Cj3TNgSdsP3iYMQ2qUTBjo2SA7TLzb3mQVAnjjI67n1I79bSydIFomUfDJAFYvSAYtshBtaf6SYvGK8Kh2mLfNn/7tjez1mzaUv7qUo5DNo6TjQlSnov0aVjkzZW76o6GzANXHrE6VyuykOB2RDl1lzRbMRFM+HJz+XlmR8UFT7JpbSqv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJJkoVrLYbjm52xGldwSzFCjMWMi8zeT8lY2UeYGQo4=;
 b=kKGMvidtzzIdwCPweS4ht/if0+WEBKHLpQhk0iVVRlsuJ7o0w4JiwAXCIIwKduRyKfwLCfZmbplgQTMcc1/SgToc1W5kMcpj03UAL++CRuSaiv2d1MxUTY05QQOJUw1ws0znSxoshXgebbrN1s1FYO9KpCS5nDPvyvg9elX14KwIA3ntTvuLDzqAdAU7PGfT/slBtVhIxZ9eRBLuhL28x0JHwi/t5DYyHmcLSg2xm5HnO26ihn/pA+GKbioJ8SY4VOLOHdfCelPO1WO6ZEOOjZT58gDvdYQbqilqwwuUZMt+Vd/6mLxT3mza7G02u2BNVO5Nahd53ErLEaTSqjX4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3897.namprd11.prod.outlook.com (2603:10b6:5:4::26) by
 PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Sun, 26 Nov
 2023 08:58:17 +0000
Received: from DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::eb4f:8941:c267:c2ca]) by DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::eb4f:8941:c267:c2ca%7]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 08:58:17 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Greenman, Gregory"
	<gregory.greenman@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS STA
 channel change
Thread-Topic: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS STA
 channel change
Thread-Index: AQHaFhTT7gV152az5UmUhnfVvdT70bCJ6FMAgAJ33IA=
Date: Sun, 26 Nov 2023 08:58:16 +0000
Message-ID: <DM6PR11MB3897EAD2252F23EBAED8EC4EF5BEA@DM6PR11MB3897.namprd11.prod.outlook.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
 <782a4f7ac91dcb0e1c564e285051c63e2a95d71f.camel@sipsolutions.net>
In-Reply-To: <782a4f7ac91dcb0e1c564e285051c63e2a95d71f.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3897:EE_|PH7PR11MB6521:EE_
x-ms-office365-filtering-correlation-id: b2566505-5566-41e4-345c-08dbee5dd445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gpe8IfCGoFTnnohnzJDwe9TeaGBEG30KORBcJfxXFRwyTabbJjchXfvNENSAZWjt4t9ZTsz9zSxVyP6G3/lB4j5ztNDX1jC5NeRzGXmCV1PwroVAkmxGcR8q3WZ5zsOTmjK7Rm5uGZ64zOb7W7NGbzfO2Zez3EEKidlwiVkHlHrO1dH08HosC41d69vX2Cy5SusE4djHb3yaCZMuTQMheCovKkYZlqVh+nv2obz9Ldar+asNh2zxFvIcG7G1M6VvPPuBzJDxp9CxqrlEBDTbm2o9B8z6u0Wc4f4/+TdDNpDyn4Wsb2FXkYammoo6GtKdc7Wi8wZvr7ZfcnsHmpZRzkGgd2nJQIRHivPJkJs5v/mZK+muzYyfhSoQcnkvqwbSDgtijcgcpWYUl+8xaUC19JeJGaBC+bRf/RXyphu5lsHUa6sNbyoF8GNTEtizHraZOmRE1quh9X+Bd90vLsbafx0ZgmS3i01tvVWn4dYwAsRrcbG5rQKtp1fI+qVFznhluExXcxpA5qINooMCwzhNlDAuTYoMnyxEHohtL4hsEoWma6OeWTH1lE5p/mE5aPIo/ZFtTJ2kXze/bKnkdUh6wylRWIn3Jy+pvrtOtrDbZIZlAQ3D27Pe7MbzS5N1pFHu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3897.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(38070700009)(38100700002)(66946007)(66556008)(6636002)(76116006)(110136005)(66446008)(64756008)(82960400001)(33656002)(122000001)(86362001)(71200400001)(26005)(83380400001)(7696005)(9686003)(4326008)(41300700001)(478600001)(316002)(8676002)(2906002)(66476007)(6506007)(52536014)(5660300002)(15650500001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHVJQUlneGFqZnNyZUhDUkRZZzN4WnJUYm9mVFpRbnQ2VWJsZ3JTa0w2ZnRK?=
 =?utf-8?B?VkwydE1MNlRxUDl1cldmOGxraVkwcHJvQUl0ZUl6eFRQZk1FaGZOQ0pqdHJF?=
 =?utf-8?B?SXZicXpIY0Z3aTJ2S1p2KzlrUHdCaVg3RTZ2M2h6eVg0Wi9wTU5KdFhYSW1o?=
 =?utf-8?B?WkZ2RFBDYlV4Nmh6L2s4VVJjTjE4UmJpa1JPdERnaVJzemlIT0RkZ0pmR2JB?=
 =?utf-8?B?RldjZWZlMkRsU0U4VktqMnFVb3FUUkdQVnpYcTFuVFg1M0dJbzlBc3FOa2Ny?=
 =?utf-8?B?aEl3K21yQytpZWpoTU1Pek9sUVAzbGgwcmNSSldqdG1YRk1YVWdHQ282Si92?=
 =?utf-8?B?VVh0cWk2cWJybFlsZEhvZUd3dEdsM2FoWVJ2cFZpSE5jRVJZYXhOQWcvTWFY?=
 =?utf-8?B?N3VxNGZtTTNyUnFUT0RPL2ptYWxCRWlhdnJNZmFrejdqZlZoZGpYOGdieXVS?=
 =?utf-8?B?MVF1cU95WmlIanVDSWUydnk2L1JnYWpKaG5SRFRKZVRXYi9jZ0pjRHl5WEVu?=
 =?utf-8?B?M0xUSUtlNHcxRWFwK3Ryc2FRL1JraCtMN3k4U29xU1hTZy80czdEQzlWZTdP?=
 =?utf-8?B?VXROd0FodHNCTi9DZjdUdnJXUzR0ZUR4SmsvVG1iUG03NSsvZVRNUkFONlpS?=
 =?utf-8?B?WlVybGU1UEZnNGdsM094UUlHRXhpWmx6MzJaVGFNU0tzL3lxVk04WXVVRjY2?=
 =?utf-8?B?ekdMYWlzVWZ0ckdaaWNKWS9WM2JPNkhiL1o2ZXIycWJhRFoyZ3lOOVJiOWNi?=
 =?utf-8?B?anNMV2gwRjFEVFZGS0UzSWlNT0pNNEd0NE4zYXc0L1dLU1V5TkhUREJPK0Jy?=
 =?utf-8?B?T2lBNDJjKzdFUkd2c1p0bEpCOEF3L0hRQ0dmVVk5aHhWRTZPNWQwYVlJWklw?=
 =?utf-8?B?N1RQSUZJL2tFUWFvWk9ZS1lDZk1XMnIxNy92ZnpaemxhRUR6bzRDSFRjeWI1?=
 =?utf-8?B?bEtEbitDb2pBTkFGaDlwRmZFU3RhYys4WTZBRFhDcEdYdmI4Uk5USk5xTGFF?=
 =?utf-8?B?U20yczhYWWN0WStBNGN3aDYwOTlVdzg5dGcvS1I5T0JrWHpUUkVGWElCWFBs?=
 =?utf-8?B?azZWYStRNVRRamlNWlZLNHhDU1dSYzU3b0dHTHVFRVFUaHdaaFh6cWR0UEFv?=
 =?utf-8?B?UFNVY0FVTWN2d0FyZVhYRTI2YnN1eWdka0JTeUZXR0FrcS8wQ2ZqMU96ZWxH?=
 =?utf-8?B?TWtwVVpnQ3JsZjlBZEgvZ3RXMEpaRWxaa2hFT0NnVmZ2SGVOWFNkcmNBRFNO?=
 =?utf-8?B?eXNySE41YU0xT0hwa3YvcDQ4Mld1cURsRSs3YS9XVjJycmhlbG5TL096VDhK?=
 =?utf-8?B?TkNrdDhRcVVkN3VTWTR5a3hacU41QjA4T1dUMlN0TXZQODFGT2dib1Uydkgy?=
 =?utf-8?B?bzEwTzlpQUJGQUhCd0kyUkt2eWJrUk9Fbm5XejdVTnl4UlUrdlpJR0JlWENj?=
 =?utf-8?B?bTAvSThjd3dUNk9IVWFkbzhOZm9ObG0zLzlVM0JnU255bHJteEpFSUlyQ3dq?=
 =?utf-8?B?ZlBXTktoTkNGOGNQMVd6R1RwRVZFWitGYXVxMVpmV3BiS0RVdDVJZ3Jvc2U1?=
 =?utf-8?B?djVXSkw1TFEvR0VxNkdZamRicVlUUkpOZmpNKzVldkNJTENLdE0zSkVMUUtj?=
 =?utf-8?B?KzE1YjU3V3RtUTkwek1JTmNDZURSU200Yk9sY0dVLzRDY0Z0cGlsNytmMDBD?=
 =?utf-8?B?ekFvd2pMR1MyMFgxSjNZRTRqZUVWRVlvTm5IWmJCQUxZWFphVktJVjRkV3o1?=
 =?utf-8?B?L3dOUlZRc3Z4bE9KWStMekIvV2JlTGE4RGN1c1JYTU9JOHMvRkJSN284M3Z5?=
 =?utf-8?B?S1V4WDdjd2hZYjJwYXlETExuRGpqY0JVMXZvSDRBSG1DTnI4ekp0WVZFekFn?=
 =?utf-8?B?UjRuVmtwajVyYTdpNm1MQUZsMjJsQlV4K3dRcnBwQXo0WmdWSkFNZUNIalEy?=
 =?utf-8?B?Sllad3NyMTFuSlJMUWh2YUY4RWh1dlFpa3l1V1FHTFBxU3JJdm1WTlJFdFhp?=
 =?utf-8?B?V3ZUVW1QQTV2S0tJVkxvNTNYUXVGOE5OS1U0em0wZnBYeVRNcE4vVGpDK1hI?=
 =?utf-8?B?TTZvQjZNRWZvZ0I3SXVDT1NORVRpUDFVa0psK0RKa0FTZEVMODhBdHl4ZjZy?=
 =?utf-8?B?M2FrdHZ0TEJlZUJnekZrWDM2ZEF5SU9KMG9UWTU4RXVtelA4MXV3aXp2aXNV?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2566505-5566-41e4-345c-08dbee5dd445
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2023 08:58:16.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75IzBQF1Yb6Ft26uJcsAEnAfFQLzHtSRz2c7SVkm4LwsTdFy6dEXb286/hVE7FR9/iRBlepUdaqZG3+PxE4Iib7w2iyzgcev2Fi9ERwt4QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

PiBjZmc4MDIxMV92YWxpZF9kaXNhYmxlX3N1YmNoYW5uZWxfYml0bWFwKHUxNiAqYml0bWFwLA0K
PiA+ICAgKiBjYXNlIGRpc2Nvbm5lY3QgaW5zdGVhZC4NCj4gPiAgICogQWxzbyBub3RlIHRoYXQg
dGhlIHdkZXYgbXV0ZXggbXVzdCBiZSBoZWxkLg0KPiA+ICAgKi8NCj4gPiArDQo+ID4gIHZvaWQg
Y2ZnODAyMTFfbGlua3NfcmVtb3ZlZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MTYgbGlua19t
YXNrKTsNCj4gDQo+IFdoYXQgaGFwcGVuZWQgdGhlcmU/DQoNCk5vIGlkZWEsIGl0IHdhc24ndCBp
biB0aGUgb3JpZ2luYWwgcGF0Y2guLiBXaWxsIHJlY2hlY2sgd2l0aCBHcmVnb3J5IGFuZCBmaXgg
aXQuDQoNCj4gDQo+ID4gK3ZvaWQgY2ZnODAyMTFfc2NoZWR1bGVfY2hhbm5lbHNfY2hlY2soc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldikgew0KPiA+ICsJc3RydWN0IHdpcmVsZXNzX2RldiAqd2Rl
diA9IG5ldGRldi0+aWVlZTgwMjExX3B0cjsNCj4gPiArCXN0cnVjdCB3aXBoeSAqd2lwaHkgPSB3
ZGV2LT53aXBoeTsNCj4gPiArDQo+ID4gKwkvKiBTY2hlZHVsZSBjaGFubmVscyBjaGVjayBpZiBO
T19JUiBvciBERlMgcmVsYXhhdGlvbnMgYXJlDQo+IHN1cHBvcnRlZCAqLw0KPiA+ICsJaWYgKHdk
ZXYtPmlmdHlwZSA9PSBOTDgwMjExX0lGVFlQRV9TVEFUSU9OICYmDQo+ID4gKwkgICAgKHdpcGh5
X2V4dF9mZWF0dXJlX2lzc2V0KHdpcGh5LA0KPiA+ICsNCj4gTkw4MDIxMV9FWFRfRkVBVFVSRV9E
RlNfQ09OQ1VSUkVOVCkgfHwNCj4gPiArCSAgICAoSVNfRU5BQkxFRChDT05GSUdfQ0ZHODAyMTFf
UkVHX1JFTEFYX05PX0lSKSAmJg0KPiA+ICsJICAgICB3aXBoeS0+cmVndWxhdG9yeV9mbGFncyAm
DQo+IFJFR1VMQVRPUllfRU5BQkxFX1JFTEFYX05PX0lSKSkpDQo+ID4gKwkJcmVnX2NoZWNrX2No
YW5uZWxzKCk7DQo+ID4gK30NCj4gDQo+IFRoYXQgLi4uIGRvZXNuJ3QgZXZlbiB1c2UgdGhlIG5l
dGRldiBwb2ludGVyLCBhcGFydCBmcm9tIGdvaW5nIHRvIHRoZSB3aXBoeT8NCj4gV2h5IG5vdCBo
YXZlIGEgd2lwaHkgYXJndW1lbnQgaW5zdGVhZD8NCg0KV2UgZG8gbmVlZCB3ZGV2IGhlcmUsIEkg
d2lsbCBjaGFuZ2UgaXQgdG8gYmUgd2lyZWxlc3MgZGV2aWNlIGluc3RlYWQNCg0KPiANCj4gam9o
YW5uZXMNCg0K

