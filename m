Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB68A7C6F91
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378929AbjJLNpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378945AbjJLNpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 09:45:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070FC94
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697118316; x=1728654316;
  h=from:to:subject:date:message-id:references:content-id:
   content-transfer-encoding:mime-version;
  bh=kRRk1Pa9sCojOQPs7D/XR4vrAWvvYABNhDjz6mtC5yg=;
  b=KYmaItLmwsQI1bDuGzXHGTZuiGszleNte7jVN78jXCwEGoL4bJnOTYLA
   RAvbmcCSsNW8kVgoap835FuI2KzN66HNTBhduDlmB+fIzzoZu4B0BMvd7
   ct/KYRipK82iFmHbykb6fIKckF3WOeQu106DvRW2Hl2k2ywO3p9Hpu8P5
   AaWu8UuKoLTyN2gao4rOaYMgPRefvZldZ5NG522voENp7E47hrpLXprvO
   1Czt6OuIPohZ9IHaw5kUmRvg8V8jp0hLNV5yj0LPlWXDqhpdJxShZ1Fxz
   jggHSDuVwRV9XtVwv4VaGaRdgg1Uy1TABkooaTKKAuXvEP0oAVhAquYTP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375280589"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="375280589"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704189124"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704189124"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 06:45:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 06:45:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 06:45:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 06:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY3mJbnX+baFHm5XFx1qDK8l40D7DSp9T4pqGKGEv3h0Bt+D50BTeQws7tpP04x/Oujco1L/epUKWnthQnlHYaIZZ0GYLtaHEY+cQjOlzexKPu8vDl8zuA3JGJysbvgOsgoRTXVyyV14v2PmJqzEUP/7Pg+/5WYuhrgQelwghjpEUXRXQYKceQ1jyegnE8J9J7vYTXXEpKiLOL3Kpuf6Ye6i3ESUNlWkKWbP6v0aZMDiaUL6+Zx5lHGxzAKenA5s+ffV0BLnZXKwtbZedHC0x0nyNBdznFD3mLBYysguSbHbUWBTs7UvSJ7f69/IOEBuamVh/8Y7pxx1vSNP3EF4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRRk1Pa9sCojOQPs7D/XR4vrAWvvYABNhDjz6mtC5yg=;
 b=duI6t5D0RMJBauhvYbRYYEKPTzaK5bbKoMGRBfTBflpCPGnlpYz9UwQ2VWZY+hPoSBT45sZPLIdeHrYOq2im541yPygw5ygBm8zJipsJORgnyoRYRxcIxyhcZCfDLkUYrSb1pRmC8iyzmOg93aBAvpzsFl6NuidEUS7pxkYdP4n+bZpmPlPewjGu/2t7qZJ0DhmuZl/syMkMbkAWV9Pi4byFCnoDzWqdo7UIyNx1h6Gj12ynK7g0vGArnUQSS7F/oxkxaPZWe53nOBBleVK/BezD6FR7xiOh6g2yJG83aGKHH/mYqFU9OsWL0rwa/2XX/Fp64fqBgqiMrzjaQMpW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:45:11 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:45:10 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Fwd: pull request: iwlwifi firmware updates 2023-10-12
Thread-Topic: pull request: iwlwifi firmware updates 2023-10-12
Thread-Index: AQHZ/RGycaigdDLGl0m0Fzsf3hoqwQ==
Date:   Thu, 12 Oct 2023 13:45:10 +0000
Message-ID: <c83259fa6c0c70bf6e751dad7990407654d954e3.camel@intel.com>
References: <d922d3246f1e62d8380a7566bfe23479d8c0e748.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM6PR11MB4577:EE_
x-ms-office365-filtering-correlation-id: 9516f972-7666-4950-bee7-08dbcb297453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u73lIfkSiGcw/J+Yql45LK2VuK4jq4F9eG0QEm/ZcN+cuYsIfgMjJvl0P1VolikPcNKwAQ3eLknce6VQkH/mGfR3om9d2YlceHOyOxi7UPxnV7lU6cY7zRrN2ISKfOSzwocSbEkUD+arbi1sCxFuL4zhOyOxvYiEetQrM/ciFMAgHXpnSFAIIDf1ggUdQ50r+DyvSSIFQimnMvddNbca5YWyKk5MiWwPBjiB6sPsBZh1PeZaoMLkSaVqnrBSu8HfX9X5Wq979+b7HwR7U/WSEQexRVAZaKGtnwxlmA2V4uZpj8urtsneioboLEMWdfNRhBFcDRkS0LpS0gCwcum3vgIxh8QCmGMDCToo5cPtGp3JAgOsMguvjaKEJ7r4lZhqef8DOjvSifsI+F2O3hwBZ6OkDW/YBUxexW3P3TPXz02nGMnGHbLaniUJk8mLIN7dqcZrDTmTbct+PaiEWVMSp1in0Jh0dKUVEJYgBRlJZhtzBmju987QJEsxvrqi2EsKi/iH4AG4Kdb5U89RwWc7g3ukhbfG3O622bwFjQnlKTt/QkJ7HDIy9hcFyjxQH18wKwgJY3sRmwxGWzGmAWX800ZV9YmG70pUybbMdHS5aA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82960400001)(38100700002)(966005)(6486002)(478600001)(6506007)(2906002)(83380400001)(86362001)(2616005)(6512007)(36756003)(26005)(4001150100001)(15650500001)(122000001)(71200400001)(38070700005)(64756008)(8676002)(8936002)(66556008)(66446008)(76116006)(66476007)(91956017)(66946007)(316002)(41300700001)(6916009)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0YxRU01N1lsQ1EyRGdWajJEMVBieFR0dC8wd0dKYVVNbTZNaVpNWlhPN3Jm?=
 =?utf-8?B?QTdKaGttaHp3S2xNckt0VEVRWDlxbTcxako0QzZPS2U2aDNDdTUvdHV1V1d4?=
 =?utf-8?B?b3poZlRXNlYwWlZ3OFVNL1loSmkyckRzUDdLbjVxVDZ5Uk1URkFYWGVrQm1W?=
 =?utf-8?B?WWtjZFU5YUZhY2huWHFuS0tTY1YvbWhrWDZ6NE9QUDZzOEkxMG8xTnE1WHFL?=
 =?utf-8?B?ZXl2MnZjZ2JQSmpoQXF4bWpyM21VV3AyMDZlRklqVU1qSmVqMnc3Z05jRUdr?=
 =?utf-8?B?OUJSRXVuWnVBRThLMmlKN1pFeVJoREp5SmZDdjZsN3ZjT1dyMElWZGprRjV5?=
 =?utf-8?B?UnU4bGJPMDhtWHRoUWxURTJCeGVndGJleUJwRXlnenFSSFNDb3NuZHViQXlp?=
 =?utf-8?B?c3FnQVJmVjdZMzdSYU9oTVhHOEtqT2lxem16MnpobnRYY09OR0EvelhSaUlx?=
 =?utf-8?B?MDkwZis3OUc4ZFZYM1FBcitZQ3UrNFUvN24zT09hRnVmbFJWMVNnNlNpdnJS?=
 =?utf-8?B?Um1qeEtzeWwya25OQXRjMkpjWUIzY2o0VHpoUldsdVR2bzRUYkszdDVMNmVw?=
 =?utf-8?B?ZG9LbE1uTnQxQTZndDZWRmRrNmtMM1hjV2phZUtKamdUdk5UOWpPSWVSQVdO?=
 =?utf-8?B?V0ovZUdVenlySmh4WDZtcGtwV2Nsd2ZwNjQweVFsYk8xU1E0dXR3U080UnhD?=
 =?utf-8?B?Rjl5ejIwSTNNZGVvTmhidFB6NTdIWE5vVUp2eVNlc0tqOGNaNTdBdW9SWFA3?=
 =?utf-8?B?Q1RaVWxidVVGWWJQbStZZ29kSDVoNU1tSjU3b29nbGpZTDFiaVlFZzVhOXVD?=
 =?utf-8?B?Z3J6THBTbUgrYlZOZmdqR2IralByU0lod0NXVTM3azJ5S3hRbmpqMEQ1dmtT?=
 =?utf-8?B?TkRUb3NUNENlZ2tISENza0piSTFRR2dBNEhUQXhyeHd0YWpKNUhWRFZHTnlu?=
 =?utf-8?B?SjNEdjVIUXNFRXVFU2tZV29XN3lwellXMEo4Qmx0UmV3UTFheUhGMFZZV1R4?=
 =?utf-8?B?NndWZUUxeU9mU1dhUDdWVVppQVR0V2x0Yk5mR3pZUS91dDdQZVJ5c1hxNlpM?=
 =?utf-8?B?eThkdUtSNmZmbjJyL1B4RGxFU0p3SmEzU0JQcVhhR1daVytPZ1ZaOWhWT3lI?=
 =?utf-8?B?b0srdGxVVktaYUtDRlRteFpRZnRlZHZ3S2Y3Wkt1SEFPem9MMWtxTzNaWEd3?=
 =?utf-8?B?dEtpTzlSb0dvOCtzSUVnb2Y0ODJCSE05aVlyYndtSDNySDNPM3dHME52UEh1?=
 =?utf-8?B?WlJtUWQxMVpiMnJMZjFqTnVqK0pFeFNqdVJURTE5QmxtMWxqYmZLTmpqZDFu?=
 =?utf-8?B?OHZTV2k2NGVqUFQ4RjcwZTA2TFJjaTU4MXhOV3JqZEplck4rYURkWE1Cd0I4?=
 =?utf-8?B?MVltTG9XZzI4M01Yb2JzZ05KeER6N3ZtbzVoQUwvR0hZS3pIOVA2OE9ydzdQ?=
 =?utf-8?B?NjY3cmVrRXNNK09McWFuNVNWMEUyL1hMMFREZytzSXhuUlpuaUJjcXBDR0c0?=
 =?utf-8?B?ZnhIa2JlWmVwVHg2RWM1MFdYMXFKVHZ2Um0wUGpBdzUraFlZNTEzN3dXOC9z?=
 =?utf-8?B?MnlrVVhSTUZJUzV4WnRMbFdNZEJ5MVhvSDRYQnAyRTNOMFpCOGdXeW9wTjYz?=
 =?utf-8?B?OVhrK2NiVUNWdGYvamYzSzFtSDFPNDNzY0cxa2dOcFVNU1dyTUpLVit0V2RF?=
 =?utf-8?B?WUxyV1dkVHhnc1lKdExYTkhtK3NkRjJqeUtXc0FxbTFTNW9JYVIwd1BPdm5U?=
 =?utf-8?B?NW03NHFwd29iNmNOeFpvNVdETUVZUUpzTjF4cUlmNzJQUlBLbndjc3Z3WGV4?=
 =?utf-8?B?aW1OcUtFMVlPUWQzMTkvaUI4SjQ5dzM3bVgxRXNycW9kVlVWRExYbXJVdzJS?=
 =?utf-8?B?ai83M1JWR1hVY2MrUndnYitsVU92WUxmeFo5YXQyajdwclpQZElibE1acDJP?=
 =?utf-8?B?SmxOYlNLTHZXMlhyNjdVemtabFFFVk9XWWY4M3dvTzJtTStyeEJjOGJHWGpL?=
 =?utf-8?B?MkNTTW9GUHJSUnFlemVtUkZpQlR6bG0vQWRyQXpMNkg5VWI2MkdGTWtCL3Zp?=
 =?utf-8?B?TDZQSnVUTWdJM3pyWlFWUG00N0ZzbEhYLzRFampJWllsdWQwQ2phVlRXWkI1?=
 =?utf-8?B?UFd5OEdpTi9HTWpQWXV0dUNlcDFIb1IvS0hHSlRnS1lueHNTY1UybzZPeXkv?=
 =?utf-8?Q?+Q60qFkd3Jlc2su5p8VMAZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A990F704FC7D3744A409565FDB56ACB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9516f972-7666-4950-bee7-08dbcb297453
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 13:45:10.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhGwIYC8k7igdI5/ECtyM4cWw38mO48BISuEUVqSxKyM6siBtyZH31aSw77RdE5OD39fpUTDtUxSnm+XqnoRhv5GhWJ3RqWVYKNbAwlx5w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkaW5nIG1haWxpbmcgbGlzdC4NCg0KLS0tLS0tLS0gRm9yd2FyZGVkIE1lc3NhZ2UgLS0tLS0t
LS0NCkZyb206ICJHcmVlbm1hbiwgR3JlZ29yeSIgPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29t
Pg0KVG86IGxpbnV4LWZpcm13YXJlQGtlcm5lbC5vcmcNCkNjOiBreWxlQGluZnJhZGVhZC5vcmcs
IGp3Ym95ZXJAa2VybmVsLm9yZywgYmVuQGRlY2FkZW50Lm9yZy51aywgZ29sYW4uYmVuLmFtaUBp
bnRlbC5jb20sIHZpY2Ftby55YW5nQGNhbm9uaWNhbC5jb20sIGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yDQpTdWJqZWN0OiBwdWxsIHJlcXVlc3Q6IGl3bHdpZmkgZmlybXdhcmUgdXBkYXRl
cyAyMDIzLTEwLTEyDQpEYXRlOiBUaHUsIDEyIE9jdCAyMDIzIDE2OjQwOjQyICswMzAwDQoNCkhp
LA0KDQpPbmUgZmlybWFyZSBmaWxlIHdhcyBtaXNzaW5nIGZyb20gdGhlIHB1bGwgcmVxdWVzdCBm
b3IgY29yZTgwLTM5Lg0KU2VuZCB0aGUgbWlzc2luZyBmaWxlLg0KDQpQbGVhc2UgcHVsbCBvciBs
ZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KLS0NClRoYW5rcywNCkdyZWdv
cnkNCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3NzI3ZjdlM2IzMzU4NzEz
YzdjOTFjNjRhODM1ZTgwYzMzMWE2YjhiOg0KDQrCoCBNZXJnZSBicmFuY2ggJ3BhdGNoLTE2OTY1
NjEzMjUnIGludG8gJ21haW4nICgyMDIzLTEwLTA2IDAzOjA0OjU3ICswMDAwKQ0KDQphcmUgYXZh
aWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KwqAgaHR0cDovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJlLmdpdMKg
dGFncy9pd2x3aWZpLWZ3LTIwMjMtMTAtMTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIDkyZTI0ZTA0ODEzNmQ2ZWJmMjliZDlmM2FmYWJhMGYyNGY4OTk3Y2Q6DQoNCsKgIGl3bHdp
Zmk6IGFkZCBhIG1pc3NpbmcgRlcgZnJvbSBjb3JlODAtMzkgcmVsZWFzZSAoMjAyMy0xMC0xMiAx
NjoyMjo1NSArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBmaXJtd2FyZSBmb3IgU28gd2l0aCBI
UiByYWRpbw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdyZWVubWFuICgxKToNCsKgwqDCoMKgwqAgaXds
d2lmaTogYWRkIGEgbWlzc2luZyBGVyBmcm9tIGNvcmU4MC0zOSByZWxlYXNlDQoNCsKgV0hFTkNF
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArKysN
CsKgaXdsd2lmaS1zby1hMC1oci1iMC04My51Y29kZSB8IEJpbiAwIC0+IDE1NTI0ODAgYnl0ZXMN
CsKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCsKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGl3bHdpZmktc28tYTAtaHItYjAtODMudWNvZGUNCg0K
