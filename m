Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95D72FEA8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbjFNM2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbjFNM2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 08:28:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D41F1FDE
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686745718; x=1718281718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KAtuvsLHERpYCRVAAlcpaai96bPAJDBuDXLSZdb33cg=;
  b=l2O2Qp7vBcfkm9TZrtodr0dDv4WyLCDr3p443R5ictmoCkkyQ3SMl4Vw
   Jsa/JVXhc7J4tUi9VzBAn1EtqSfYCG6bC9OaObrN/btWtP/PaGVgla/qx
   VvH/id51xFTMpSnSTrlmmj21pHwlz0BkzfOI74uTctBwlEisbchdRrIWX
   3dO664ebGtliGkIk/v3LhXdpX638KKSdo8z3G5boooC7Awy4USiQhLNO7
   xLRjaykS0RYfi6qTnPzPrGYl1UKNPJ8RTDBZbbS2rpGfb5UCAgOJjoMoU
   km9UQz8Gc8JNUHlQvDWIR79rN5LmqnsK/5P9T/Hr23Vvd52ynUatBWWrZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361077624"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361077624"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="1042191935"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="1042191935"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2023 05:28:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 05:28:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 05:28:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 05:28:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 05:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaJliPVqx0uQ4aVZFRatiyuVJnA3XsbSqbt5eCESYYJpC/eE349g+pEmoHPNaJSzNDNrUpme5+oPD9HxCWz+NfK25L5/ZLj8htZ+RMckxhSzMvtBb9YaGdnqL5LGDIaCL9Xwn+lvpliqKwByXLm+D38wYBdhIP9+rGSmbjEHSm2BnTg/u53KHaBG0AM7TgahCED7OvdVUqBJsIsAHtTlbmyKCNGL5SxT9Hd/Vh3udtoMXJj+QaIIqDW5HXchee5DzS0jC0tggBKhjv3+0ui0iGNYIIAd9XIS4bdDD3GjzuMK34q48ix3Yyd0djVt6vZ1u/QV8loCS8hOxdbfTFychQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAtuvsLHERpYCRVAAlcpaai96bPAJDBuDXLSZdb33cg=;
 b=LonlnK8SdOkB9JAVP/zeTkgOd0igx6PVvivheils1jh21hk76QDdkpyveEoBRslU4/4hlNssiw+tPOF37+vTbuXAJJvx7q/Gdk6KYMuPLHFHK4sOwuDsFpqE02ryUDKr9Dle3L8QmduB/AAjm2lALjCMgB52PFK+6GXdSGK3gWBNeb/LW4L/L4izSQ7aChZORAULIgkvEZQGiXq47vcRhPTYJ9QByYzmj+jTQfVM3u5WXC0fUseiS4cbtzLPqxOGTj12zpNPVb5faRODzRJSG06Wquj4boeUo1SsIlgsus/EuFgoRwDtJ+ojxDOrfrmeaeKf4PzI2+PPPGV57fJPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 12:28:34 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 12:28:34 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>
Subject: Re: [PATCH 08/15] wifi: iwlwifi: mvm: Add NULL check before
 dereferencing the pointer
Thread-Topic: [PATCH 08/15] wifi: iwlwifi: mvm: Add NULL check before
 dereferencing the pointer
Thread-Index: AQHZnUXT89iQ1yUpVkCk0o55zpU726+KFYAAgAAnagA=
Date:   Wed, 14 Jun 2023 12:28:33 +0000
Message-ID: <75ea42d01f6397f5b46842e6eccd3fced9b6e31a.camel@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
         <20230612184434.cf7a5ce82fb0.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
         <416fc1eba88e13c245fac4499ee0af2efbd5485a.camel@sipsolutions.net>
In-Reply-To: <416fc1eba88e13c245fac4499ee0af2efbd5485a.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM6PR11MB4532:EE_
x-ms-office365-filtering-correlation-id: 6c081268-1c33-480c-a9f5-08db6cd2ded9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7GGhQ7W2H9LfL9B2URfB+WbVvUhXGnAGvTnprSv+HXj5A+h0MecLYbW0WACn/B/OoNsFmtAtCPf+NSv+CftKoRTSNWIMDTIwiqA4GZNsrQc+/dnON1CFvcG6ZFeXj2rbsakyw9XFR+ea7xsztKZIzd2votGoGv6U8xt4Xqv3ycLdT81yuLMrDWh+vm7m1D+YQzlUm48gBkzi2WsZAzxcq+DcOIjKnB7nvxqSFCRA1bgeQLWqC0eKZDLlCP+xwfuZoXQYgkq221EaAnwdmSnAZwoSkaZlpVJ5TE3yftCxZwCmKWIUSBkEZObVtbSuxL23Odlm4TBYnW3cd7z1KkTJDuls55kpqumZZhSt0JQNoRWzFEnOp5tPb0b0sJ71C6acV/zT6rPItpwRRiXcAarXcjBCG3bAXeIpWzuFBwXlTSy8afyxHmLedCtxQTcbIAu7WSkHiIkplqCbnuoemwwqJRYMHQ9n5qBYO+YMf7ZavbA9u6X84EU3APsDX024GZnbd/XlOJ4Bweszm+V8mHW0kMrff8lnMZN1mLgBqwKzp1rjXNSQ4KXHuVHDSNddjNocAmpaO7cotEiJ7t+i8R1ZTjLKS0iD+yLFySn7Wk3UrVBaivU8yvB2OQRDRHqOxLRR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(8936002)(8676002)(2906002)(38100700002)(82960400001)(5660300002)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(316002)(122000001)(4326008)(6916009)(91956017)(83380400001)(54906003)(41300700001)(2616005)(36756003)(478600001)(186003)(6512007)(6506007)(26005)(107886003)(71200400001)(6486002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHI3YUN6cXBHUm1ONnNia1VWY2hvK2JYY2pybm1xSWw5ZDdPNGgyT1dzeUhI?=
 =?utf-8?B?anNiYVlPR0VxQnV5RGNqZXEzUVQ5QktUdENmRHF0T0lhOCtNSFdCa05hVHBW?=
 =?utf-8?B?eTUwcGpEYVgySFNVRVhpaVN4aWhybHBySWpkR2gzZFEvQ1RsL2dRMWFzbHZ5?=
 =?utf-8?B?VjdjZWd2azc5c0NlRVd6S0QzdllDa1cvYTNrS0t4Y2VJc29QZzNiYmlzV1Vy?=
 =?utf-8?B?N1RBbXBtY0lESlZlSllEK2xFcXhxKzlPa2RkYWwrMWR0RmlrZGRSaGFGWHo2?=
 =?utf-8?B?L2ZlTUFXMU9kV1RKTTVYZXVRQllyVllhUU54ZFRVWnRsMnJPSWtZVURYcVJj?=
 =?utf-8?B?eXY5aDRvd1FjeFhaTmJHSC9CUXZRK3M2Tk9JV25RM01ycmJBR2VmMjJyN3hh?=
 =?utf-8?B?SlBXMXo2bmk0anN1ZWZpVnhhajZ5UVFoaDJRVDRBTi9JVk5ZVlN0TERFYXZw?=
 =?utf-8?B?RS9qQTNkbXU5YVVCeW53R3VQUVBlNTR6Y1JsWDRvL1RNcmY3OUpGUkw0ZGg5?=
 =?utf-8?B?TXlsallta3FibDVvS1dYemhEd3dUVnYzenJ1STZNMzJ5MWw0L05GbFREZk4x?=
 =?utf-8?B?MWRudmNOb24yeU5JVXYvSks1bkJvOGQ3MzlFYm1lZU5UOE5PMFVwN0l4K250?=
 =?utf-8?B?QzdUdnBNZUhySUJXYnBGaDNYdjdIRkgzUGNWaHJIektxSzR6YmN0bnNKTjN3?=
 =?utf-8?B?RDlSeGM4QnNHMjVYajNWV1YyZzYvRU5CN0JsTVJkZmVub2RxS29Kb2pIMFFw?=
 =?utf-8?B?V1o0RGk1VmN3R0hhZjg5RHNXcFFMMkZCQW5RMlJlSDRzYUVkTy9nSGVRUzY4?=
 =?utf-8?B?dURGZVRRVDNnQmNYSXpKbFF4TGVOT2htNWNRMkpoVUJiU1FOYzFTakUvYzJP?=
 =?utf-8?B?UU42eWtURDVIakdEdG9XSXBCeTBqTE5EWW1OWTQzd1g4Mk50Mm9aWFpWS1JT?=
 =?utf-8?B?NkdLbE1mbCtCSkdncGJVdEdQY1oyNjJCOWN5Q3BEKzRocDF5SytJMWNKei9v?=
 =?utf-8?B?M1NxajYvcDQ2M3hsODBoS1JvS2JrYnR2U3NBbzViWW1wZDFRZ21zWUYwS0Fy?=
 =?utf-8?B?aGo5RXI5QWMrZGtHcE9Wc2ZLb0xlYjl2M1phaWg4WjRDS3RHT0pTbjJYMTlV?=
 =?utf-8?B?ODJlN0ZFMlFBdnhwVnFqd3hiaDY0QU5FbjJCZlNDQU5kVnJvWlhvVEhwa2lW?=
 =?utf-8?B?VEVLeGdqSDBWbjhtcDB5L2xXcEJLVXk3b3dnSUJvZnZ3VWdtSjV4ZlQ1aWpj?=
 =?utf-8?B?eU1veFhwZWJGYXB2WHVpR09OZ2VXa1hEQVV2bE9OUlYzeUZWL2pxVWhMM09D?=
 =?utf-8?B?cE5McHVMQkVTRncrUjlvYStvdHplZ3phTHBVM2Y0M0dER29vOEF4dTBjdjNN?=
 =?utf-8?B?OEloODA5U0p6QWY1UXVaL0pwTHNCV3Z3U3NrYmtuaUFDYndZeWNQVHpGNDBy?=
 =?utf-8?B?RUhlZGk0QlFQWHVuUkkwb20wRk1QT1RhSHZVWEhQM1EvL2tPN1pWRmprSDNP?=
 =?utf-8?B?MWVmK25kVCtLK3REN2pra0tscEtIUERVWXp0VnF4L005YThqdU45cU1nR09u?=
 =?utf-8?B?ZlZLSDZ5cmJwOW9QckpZWWFUaktOV1ZDRXBmTkUxZXV0bmRBRURFTThKc2Vz?=
 =?utf-8?B?RjB1cmRqRTlMemhqVVB3UWU4T3hGZ3EvQVdlMUpDUU9EblEya2hYZ0NFUGRT?=
 =?utf-8?B?WVBXTnNwbXF2VUxVdDUzU0NSYmswSU05eTNNT1ozejVVci9oK3hCNDhzKy9z?=
 =?utf-8?B?UW1zbk42aXlvR01QNm5HOS9TWHkxaDdDR3VPbjFOQm5XL05Tbm5HUnBjejZu?=
 =?utf-8?B?R1ZOM2RsV084UE1OdlVOc0lmNWhTL1JvZ0pybjlkRURXUGFtaG5FWm5yM1Fy?=
 =?utf-8?B?eVFCWjVPUnE1UCtkK1dVMGZKcTJZaUdScWF5RWhYS25KNFQvb2FlMFJMUUUr?=
 =?utf-8?B?MWpSaVJGL1F3WUtPbnVOVHh4OWVRNnNPS2lyUWxCd04wTDBNVEpRdTJxK2RN?=
 =?utf-8?B?ZjRnMTVwaWIrRk9aWGMrVjd6QWFaY0NiUWVSY0EzdmxMYzZIZnNDYVliVGRD?=
 =?utf-8?B?UGppRFprUkJEMVQreFUyYlBzRGdRQ0VnUnZ5bEVRK2dQVjNYK3ZUWWVSckRG?=
 =?utf-8?B?UDFSTWJEQTNzVWg0b2JFOUV3ZzdzaGZQQUZIa0dZQ0FUWnU2cERRVkNHeTY1?=
 =?utf-8?Q?QEqkryfpw6yIWR3ujV4BgJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6218F8739AE7B9439ED278B7B5BF5B3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c081268-1c33-480c-a9f5-08db6cd2ded9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 12:28:34.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MQadfRB4wyhxRc7coNjhN3C/hivzfHwAtazsHCjT6R9Pbg4cynVVJIlMTIfwigW/chAR+C8385OrL+uuZvxASXKce/+c1TM2P6anTMgIZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEyOjA3ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjMtMDYtMTIgYXQgMTg6NTEgKzAzMDAsIGdyZWdvcnkuZ3JlZW5tYW5AaW50
ZWwuY29twqB3cm90ZToNCj4gPiBGcm9tOiBNdWtlc2ggU2lzb2RpeWEgPG11a2VzaC5zaXNvZGl5
YUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gVGhlIHAycCwgYnNzIGFuZCBhcCB2aWYgcG9pbnRlcnMg
YXJlIGFzc2lnbmVkIGJhc2VkIG9uIHRoZSBtb2RlLg0KPiA+IEFsbCBwb2ludGVycyB3aWxsIG5v
dCBoYXZlIHZhbGlkIHZhbHVlIGF0IHNhbWUgdGltZSBhbmQgY2FuIGJlDQo+ID4gTlVMTCwgYmFz
ZWQgb24gY29uZmlndXJlZCBtb2RlLiBUaGlzIGNhbiBsZWFkIHRvIE5VTEwgcG9pbnRlcg0KPiA+
IGFjY2Vzcy4NCj4gDQo+IFRoaXMgaXMgbm90IHRydWUuDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqAvKiBlbmFibGUgUE0gb24gYnNzIGlmIGJzcyBzdGFuZCBhbG9uZSAqLw0KPiA+IC3CoMKgwqDC
oMKgwqDCoGlmICh2aWZzLT5ic3NfYWN0aXZlICYmICF2aWZzLT5wMnBfYWN0aXZlICYmICF2aWZz
LT5hcF9hY3RpdmUpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoYnNzX212bXZpZiAmJiB2aWZz
LT5ic3NfYWN0aXZlICYmICF2aWZzLT5wMnBfYWN0aXZlICYmDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgICF2aWZzLT5hcF9hY3RpdmUpIHsNCj4gPiANCj4gDQo+IFRoZSBwb2ludGVycyBjYW4g
b25seSBiZSBOVUxMIGlmZiAqX2FjdGl2ZSBpcyBmYWxzZSwgaG93ZXZlciwgaXQgbWF5IGJlDQo+
IGZhbHNlIGV2ZW4gaWYgdGhlIHBvaW50ZXIgaXMgbm9uLU5VTEwsIHNvIGl0J3Mgbm90IGV4YWN0
bHkgdGhlIHNhbWUuDQo+IA0KPiBQcm9iYWJseSBhIHN0YXRpYyBjaGVja2VyIHRoaW5nIHRoYXQg
ZGlkbid0IHVuZGVyc3RhbmQgaXQ/DQo+IA0KPiBqb2hhbm5lcw0KDQpSaWdodCwgc28gdGhlIGNv
bW1pdCBtZXNzYWdlIGNvdWxkIGJlIHJlcGhyYXNlZCBsaWtlIHRoaXM6DQoiV2hpbGUgdmlmIHBv
aW50ZXJzIGFyZSBwcm90ZWN0ZWQgYnkgdGhlIGNvcnJlc3BvbmRpbmcgIiphY3RpdmUiIGZpZWxk
cywNCnN0YXRpYyBjaGVja2VycyBjYW4gZ2V0IGNvbmZ1c2VkIHNvbWV0aW1lcy4gQWRkIGFuIGV4
cGxpY2l0IGNoZWNrLiINCg0KRG8geW91IHdhbnQgbWUgdG8gcmVzZW5kIGl0IHdpdGggdGhlIGZp
eGVkIGNvbW1pdCBtZXNzYWdlPw0K
