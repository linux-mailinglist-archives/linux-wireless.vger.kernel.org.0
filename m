Return-Path: <linux-wireless+bounces-160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB57FB46E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 09:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3728248C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E38107A1;
	Tue, 28 Nov 2023 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4o4+b64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946FE9D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 00:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701160771; x=1732696771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2RVabO8iOMR4boi2Xrl7xRIlAdouDzrNgddIHrAluDI=;
  b=I4o4+b64Xqv2cWTE4rPURyzhxkzrLMOx2R1q3zjPIcTSAQieJL3VbZwB
   1w44nslXQL7Bv2rgvKYSlF5E2RZrhws3C/s8huJ8Sx6mvfAMbeqX2LE6z
   mQDa08R1GY+TUbb6TsSj1R3K/W/doSjBL4rwB2clqIOjQ5JpZrwBijBsk
   XdMI/jqbvQN0REStSBa6TEpaikZ0wBmYQAFqz2ZYmwjT9spBSf5INKQk0
   Q+LbliBdNnSbtAQRomg9nQNknuFa0z8DeefQB50cVsUpU8xKzehTNm89Q
   bMEfb4iy1ql/XBFivc7iKE6eoP2FG0j1M4y9jamhP/0l+SGIgrbi5z690
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="391751365"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="391751365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 00:39:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859349292"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="859349292"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 00:39:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 00:39:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 00:39:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 00:39:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 00:39:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHzpoTXTBr/AWeKCYI5Plw5WuC/2LLox4lWyD2e7opdJjFosc9ec2qO65iPVCsPhTCE/LTw2CVnCbJ/OiQrdR7RU2hglU4JH6cfvAeV36MuE97hwTrpZS/A1eR1x0r/nTuIFA4uTOo9M15PeuWNf7SpMqvABjVvfKEjE3WFHF0jEr15rTxF6FKQttg0HpnrqkQgzijyi+0doWrTJf1UWUwNU0I1JZmLgYaeX3+uMYA7tJZK1CLUG/axH67ldGntOc+9mVWEnh0pcy5rIYuwXQ/hFD+flOzFRwOaxL8GWugMAQv+xjc3Z9i4zZ1VvqbcC+3cLK49xiRViobudl+xg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RVabO8iOMR4boi2Xrl7xRIlAdouDzrNgddIHrAluDI=;
 b=mDXDdSMwRBDeU+mixN0ITODC/IQa2InG1t7Fo9qgNVy5bIxHH34KAmGzlln1aJ3M8khCSzWb6bNnj12HSVYfJAeKpPpg3sBEMBgjLeXs4TWY/6d7nacRNR8OVeCykB2mndXYn3q5vcwjTOOZV+JORq48nL6EQG4EtmxWAYstemeD3duYw0RgvGtDUPaVvNIiTLuQihz9EEkKT4Z8krt3WwTLzBR6SXiJQ8Q1fRbxjwAUM7nEI9qOWXtzJW6iqkF+FiZIowH3188/iprCoVE9i8yQbDQSpnLRXOJjQRz82R7RRy6hlsMxId6X9X5rjZyNyzmMCqi8u0QrJDsCy1WISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3901.namprd11.prod.outlook.com (2603:10b6:208:138::12)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 08:39:28 +0000
Received: from MN2PR11MB3901.namprd11.prod.outlook.com
 ([fe80::8811:350b:6fcb:8c09]) by MN2PR11MB3901.namprd11.prod.outlook.com
 ([fe80::8811:350b:6fcb:8c09%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:39:28 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Greenman, Gregory"
	<gregory.greenman@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 6/6] wifi: mac80211_hwsim: Add custom reg for DFS
 concurrent
Thread-Topic: [PATCH 6/6] wifi: mac80211_hwsim: Add custom reg for DFS
 concurrent
Thread-Index: AQHaFhTa6EYTukw9G0+m/7U2F7FPE7CJ6XEAgAWTrwA=
Date: Tue, 28 Nov 2023 08:39:28 +0000
Message-ID: <MN2PR11MB3901864D44E1F80C974E3766F5BCA@MN2PR11MB3901.namprd11.prod.outlook.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.560597906f17.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
 <feeb5fc1ec52fb7bb85f9242d351bf6ff44b315f.camel@sipsolutions.net>
In-Reply-To: <feeb5fc1ec52fb7bb85f9242d351bf6ff44b315f.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3901:EE_|LV3PR11MB8767:EE_
x-ms-office365-filtering-correlation-id: b19d3d74-a3d6-4c16-cf53-08dbefed88ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xpvSdJ3s6G66CMW5mFN8J8bnXU4mZ6ZtYjYaLX5qPqLNPQ02psdmgYbDjlS/uX2fysQUDPHTDh++QDvw2cfreRed23wc31+XPFzefJEvx58NLcaSwimnbro6YB0lASuWCAMI1wBOFCy43TuyIPy4zP3x22601CzFQ0h2VGEkHuawhYdkpalJfjwMejiOEqUcVgODZrGisN720iEtW/GT8mv3+bc/fPIXDlI6jowGfhH2ayaaMuYgQ5/+AtXoIDbnINB/xF7d3PbNz9GKbZk3Hcby7/t+DQMldiqXUeUctJ/nS591GpmFSTc+ZRpvq02tfqk3IgFdzz/luyWMCzvO+EG6zUgol02tziUPElAbZLeHf76Qx5I18sbk0a7IuV43mL5+Sg0yGVydDmSpD0OAIh5AhbRU3cAyagNGErswqC1YbxgT0l16Nuojf3M00nQ9E0TxS1iUo5vlvmLSA0F19RKpsl85KBgHpyyhiRAbnCf3zR2gRRDy0secjCSiWRl5V0qA8JdNKB3Yd4bmeL8JleKu6kyX5C/oisnn5e0l1XgpIVw83/mq96YDTOt/EjQjqbynseKdKb43JefsnMkL8f5OBAS2T6w+S0fapfABhOs9PCBJllfONU3aWlMytOjY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(122000001)(82960400001)(38100700002)(478600001)(33656002)(41300700001)(8676002)(4326008)(8936002)(64756008)(6636002)(316002)(86362001)(66446008)(66476007)(66556008)(110136005)(76116006)(66946007)(26005)(7696005)(6506007)(71200400001)(9686003)(38070700009)(52536014)(4744005)(55016003)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZ2K01Cb3UrSmhEN1g4U2tnV3NjSitlNTd4S1lWclFoQWlqTmVKdGxQclRk?=
 =?utf-8?B?RVcwekhSVXRaY1l1czNoUXJOQ0F6d2NCSVduWDFocVF3cVZFcy9KNjdJeWU1?=
 =?utf-8?B?VUU4N1ZSdUM3d21WNTVGYUFyYityOWEzWm9UQS9kZTBPa21DK21JcnFqaG5m?=
 =?utf-8?B?cTZ2cThVR2pKQXExWlNKVFJxQTlxR1doMGVTeFVPMFFkTHRibHB3aW9UdTZV?=
 =?utf-8?B?aWsxV3hSM3lvVzBwTHFqSlBkTWJqYXBLWkpFbGVubk1hUU80ampQL082UTc2?=
 =?utf-8?B?Z013RFd4dHFLdU1xYjNzOXJRbjZDUFlwRWd1bUxaT2NPN2dEYmxKakV6Q3N3?=
 =?utf-8?B?VmdQU0JuOE9uUTI1a3pZYUx5YXhKamp2TmFzV2hqL3o4N0FJVXgwdE9vOTFH?=
 =?utf-8?B?QkhEMVNxc0pVa2xoQzRJRG9sNnNBakxsdTUxaTcvZkk3cmR3bFYycnlYU0wr?=
 =?utf-8?B?d1Bya2FzYXRIelhLYVd0aHhvblVrbDdHQmlNTmdpUkF6bE1qblhpYlhpQjVu?=
 =?utf-8?B?OUd3eDZNWk1UZTc4UTBjaXR6eU5sZExYWTVjQUd3NVU0bzFDZTkrLzZyL21X?=
 =?utf-8?B?VVBpMDVjT3hYZncwalI3bGdxT29ySTR0QWFQWUZRUmYwVExaRHhEempWenBr?=
 =?utf-8?B?bVk2Z3hnLzhtS1BSS25GUDRpNDFDd29XcG9lbWFkcFJ1M3pabUFudGUzZ3py?=
 =?utf-8?B?YUdhQjlQSWxFYU1OQW5IM0hKbjRNY0grMUorQUFZQ0hDUHFiZjZOUmp3NlFl?=
 =?utf-8?B?b2VBakd1S25QZ0Z1YVdnNU41NkZqcFVvY3g2UnFzcjVEMzJuVzRZbEJxazFX?=
 =?utf-8?B?KzdqMk9IMnB6bDVNMU5RSTVJcHFtWERnVnRaR0pidHFWVnpTTUxCNUJ4SVJE?=
 =?utf-8?B?aGQ4TE1EWG1tZG92aGhVZ2lMcW8yR2RFRXFWUUFYUkg0QUFNTm5SV3JZM0Fk?=
 =?utf-8?B?ZHFEekF0TjBobkM3YzNCK3doU0UzaUxKaTYza1ZXcTN2MXNWd3FmdHN1Y1VI?=
 =?utf-8?B?dTZLTkF5WTB3M2Yvb29xQzZEQVkrNXExM1dPVStUanFlc1J5RHdnUFF5U201?=
 =?utf-8?B?UEZSWHQxV2dXODJTdkpERVlrOGtUZE1BeTlTZVA4bUJheUFGS2pXVzFua3Zy?=
 =?utf-8?B?VVBpemJyQnU0Sll2WWRseXFxSWwvbFNFcWtQYlcxUlpmTVM3elNkQnlqc3pm?=
 =?utf-8?B?b0g2M2Frams4SW9OVjJoR3JBclpsQ0MwQWhVY3JvbGpWWlllekhUbHhoUnVu?=
 =?utf-8?B?K0xSenNobElBcDBZY2EzcVgydEgxeDM2Mk0yMUFWbzJMWlFpNDZDYkk3SStV?=
 =?utf-8?B?MnYvc2hFYmF5ZDhidU9UeUIweWhYbC9WS0xRaE1ya1ZsaDV6cDhZNmtZZWcr?=
 =?utf-8?B?N2xGTGM1cGYrdERZcHA1UHptajMvK1lUSEc5b1R0bm1GOEZaK3NBV1QwQ1VX?=
 =?utf-8?B?VzFnRDlhYVdsTVVGWTJ1TmgvbU85V0FVR3V3eDY0UVp6blVYOGhyRFlla25t?=
 =?utf-8?B?WlRBUDZzRlkydGNJSTFTWXBBZXduT1k5QXlZY0JPTWFMa1BpbTJCdDJpUmJm?=
 =?utf-8?B?OGIvUmZrczZ6VE1Idm45bUdzaDRLUEdRbkhpeDZGZlBvR3JUSDlqbDg2UkJX?=
 =?utf-8?B?UDFONk44VmU2VGY5WDVvQ3hyTXdnYTR1WmliTjNJRDVNZlUybFg3NVZJS0s4?=
 =?utf-8?B?bEV0NVdqM0NpWGQ2MVIrQnNkaW54RUxQcFF1WGlqZHZKMy9jQkp2Um1Oejdx?=
 =?utf-8?B?ejNmSzZzQkNrVDk3SFBBZjl2Rkt1TUlhcUtxZU41L280aTk1ZzFGWWo1WnhF?=
 =?utf-8?B?OVJxdFh5WUI0SFJQSnhjVUNrVHc4OE1oWmxQWTZuckxBNzR3RmZqT1kxTyts?=
 =?utf-8?B?bjAzK01iT3o5N3BGdnIrdjA4Y2pUYmhtQ3kweGJuVGJEYkJrY0t2azAyZXRq?=
 =?utf-8?B?TGpZclRieGlJVXprYVRsL2JTZi91Rjl5WllIcHJlZWFzaWtpUHJLRDlIcDlM?=
 =?utf-8?B?V2RvRDRSdytKVG10Ny9xdVY0WXFTWVJBci81Z3g2SXllVTdjVXg2Y015U25Y?=
 =?utf-8?B?endMWWtpcjdLRFFGbmRYM3lrN3VjcDBwODE3Z2poV0ZOTlZrWFdqdDM1ckZp?=
 =?utf-8?B?Nld6eWhha1dObnhRY0lOSXpGQkdOZTV5YjVnSklsVHRqWk41ZHowM1hIeDM3?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19d3d74-a3d6-4c16-cf53-08dbefed88ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 08:39:28.4261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9aO/ylT0sr8j9ExK5xfQhZ78ajA8N7I6TFWkMVw2Wk70bRAo5gqfHWE9G09AvuU44fM+Kx1GaXq+7xq0f3bHpIpXTObvYf7AqTbTSX+wcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com

PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9yZWdkb21haW4NCj4gaHdzaW1fd29y
bGRfcmVnZG9tX2N1c3RvbV8wNCA9IHsNCj4gPiArCS5uX3JlZ19ydWxlcyA9IDYsDQo+ID4gKwku
YWxwaGEyID0gICI5OSIsDQo+ID4gKwkucmVnX3J1bGVzID0gew0KPiA+ICsJCVJFR19SVUxFKDI0
MTIgLSAxMCwgMjQ2MiArIDEwLCA0MCwgMCwgMjAsIDApLA0KPiA+ICsJCVJFR19SVUxFKDI0ODQg
LSAxMCwgMjQ4NCArIDEwLCA0MCwgMCwgMjAsIDApLA0KPiA+ICsJCVJFR19SVUxFKDUxNTAgLSAx
MCwgNTI0MCArIDEwLCA4MCwgMCwgMzAsIDApLA0KPiANCj4gRGlkbid0IHlvdSBzYXkgdGhhdCBj
b3VsZCBiZSAxNjA/IEJ1dCB0aGF0J2QgbmVlZCBtZXJnaW5nIHdpdGggdGhlIG5leHQNCj4gcmFu
Z2Ugb3IgYXV0by1idy4NCg0KVGhlIGVudGlyZSByYW5nZSBoZXJlIGlzIDgwLCBzbyAxNjAgZG9l
c24ndCBtYWtlIHNlbnNlIGhlcmUuDQpJIHdpbGwgYWRkIGF1dG9fYncgaGVyZSBzaW1pbGFyIHRv
IHdoYXQgd2UgaGF2ZSBpbiB3b3JsZF9yZWdkb20uDQpBbmQgYWxzbyB0aGUgc2Vjb25kIERGUyBy
YW5nZSB3aXRoIDE2MC4NCg0KPiANCj4gPiArCS8qIFRPRE86IEFkZCBwYXJhbSAqLw0KPiA+ICsJ
d2lwaHlfZXh0X2ZlYXR1cmVfc2V0KGh3LT53aXBoeSwNCj4gPiArCQkJICAgICAgTkw4MDIxMV9F
WFRfRkVBVFVSRV9ERlNfQ09OQ1VSUkVOVCk7DQo+IA0KPiBIbSwgeWVzPyA6KQ0KDQpBY3R1YWxs
eSwgYXMgLG1hYzgwMjExX2h3c2ltIHNob3VsZCBiZSBhbnl3YXkgc3RhcnRlZCB3aXRoIGN1c3Rv
bSByZWdkb20sIEkgZG9uJ3QgdGhpbmsgbm93IHRoYXQgYW4gYWRkaXRpb24gbW9kdWxlIHBhcmFt
IGlzIHN0aWxsIG5lZWRlZC4NCkkgd2lsbCBqdXN0IHJlbW92ZSB0aGUgVE9ETyBoZXJlLg0KDQo+
IA0KPiBqb2hhbm5lcw0K

