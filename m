Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC1508043
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 06:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347823AbiDTEvD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 00:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiDTEvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 00:51:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110A275D4
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650430097; x=1681966097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uC2GTDsQIhOAA2D96hrIln2Dw+IZQBKiyucpFWS8eNk=;
  b=nSvjZe92Nc4ZoF2gBe6G7UqtxphkBdN05QXusQLVCQeCFxQCUixL3IRe
   mlhrcFhzOfHms4T/j8dacZOJH/ov4hphLsXE+NbDjYoOd3/JTAqazW6e4
   FFE9mBNep09O86zwKedFNcDygLvNDw0wrrx8hyO1jjIpgyB1d088BwPis
   zcaKzXSU7CLLyflLUy1IY+T2vgyf3QorZCwaDKsNS9EiTWLCEx5RAd84N
   5MlQw1/jMOQEvlbRLU8O2d1TPrYBxNL9nf8txoBXtpOBCNSU0ZboF1R/y
   zFZv3Wsky1bioICnbm+rbrThXtA0mOjDl+MOEPIUSkgkh0ZtAv3zNpOLz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245831609"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="245831609"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="593038137"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2022 21:48:07 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 21:48:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 21:48:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 21:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/F/pANjpR5DRaBi36dAOaJP4Ew7HoC2U9IPmMPyn/257vmQXAoJ7a/4RklRxqTtVYLZXtlWfalyj37DCBD9keooyfhg7ao7H4ML/liiYtyOKG9GQRMCJZ5UuFfp1iFl6Zip+dGT/QoktFY903YFDfwe0Dw6XFPYcNNACcWov+8wVCB7huv/ZT4SBko0hNHHV66ONMdGTeLI+QmHSlq2CS1ZscBXF6v0AFcZKkb0LNqUgNNaB6wBMZl2HeVm/FvbuYmUbY27VIMyYhbRu0prEebkog/ib6ZiceuyS6FggFrtR8TDfVGkhgwK8dHGZYNsJh5tytYsSUf5mkKn6XppfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC2GTDsQIhOAA2D96hrIln2Dw+IZQBKiyucpFWS8eNk=;
 b=blesSVNg69XisjX6m7VGt/v8UqMs2x/Mz50LuHEX5xi10rROGZ4sRld1CgA+KgIMCEsf9qQs3NOgB7Bmb0XijcyR7jf0x/aGMJnMSW+yX4r2SO3ywmgOqGl1a4S2PnGVCaC7gBUEkTr3OdbNvAoG9+nho7koKRjRJePtwsAddajrlxnnbCnIXuDUIV6ibWchzKrUxehYYnvFCZXh1Jwek5tETQjSSGoctkRHbTV1AvL4eVhjX74r0ot8vJOr1GYBbxhDroJQX8gIvprcQOj8fin+AnrqHEnxf9AX1GkrbE1Px92GBGiHi2macBirF2+wwhbCINeCDTwwlc+Chig0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:48:05 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 04:48:05 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2ICAAARFAIAATT6AgABoR4CAAA2LgIAAKBQAgACDLgA=
Date:   Wed, 20 Apr 2022 04:48:05 +0000
Message-ID: <a8b437f1fc466096f119298ae1562c2aa224ad95.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
         <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
         <87mtghs3y2.fsf@toke.dk>
         <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
         <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
         <877d7kn62t.fsf@toke.dk>
In-Reply-To: <877d7kn62t.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a446122-0c8a-4fc9-5fd6-08da2288f56c
x-ms-traffictypediagnostic: PH0PR11MB4839:EE_
x-microsoft-antispam-prvs: <PH0PR11MB4839D35AFDC73F846BF56102F2F59@PH0PR11MB4839.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYgnd1NQlsIygbG7o3Ob/+BpUdFMg2Z9SqgT76Db7QoKzIlSOcVAc5twVW5sz9B2UxXdjkmJBYeFoAwsgBXVewLBQm1JDcK33e+mZTNUl+NtgOT6Wc1ytoK5pG6Fd3lHO5EnLBndYEt1uEEPYIoJwrgwAStP6brq5MMy2qhIBclzaaVLtWTvtV+oMmZeM8blUIwORTH+xaW5qLKuG2G6Bu05l13v3dsdvuvb4s+BYLzYAJdZs4mGIQeQ1wC+QBv4tONZmaw9GzmRvsgasiby+lRpmoc9LMil0lhdOMqbWwA9NKw7BB9h5DQgCIT+DZnheSR9Hrd8upPB4TXf5FLw6m7Atw8pZEk1z9nQdOjgmwmjMCewai3U+gTs/vSBOEyOryM+/tR14PL/KH/Y49KAfpawgpMONfFupm5uWQrP4W/FWwYNy55ybEBM4pjZrElDlh7VCKuoKhuBtl96EYVF9VRkuMmfBNt2Fwhmip7P9XRp/S6YYLS/7gwyzOcIO8+SJ9lwXmEWdXiTc0zABah4f3C0AfavrZsu+F65ssJd2nDTFufMpm5/A6ETMIpCH10QVLX1iag8nDmuJWe4clMNWAKbZrlY0VlYE+MaCuTDOyLzCXYSso/AOa9Pv+3mDU/3Z4Kuz5nbS7EIzccRxYMTPtrHwDYyWlKOVDXJ42ndZjpIN1Sg36gX59bmjav3ztBAAd+YEAxFVhYnYaAC6AbNtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(122000001)(26005)(66556008)(186003)(66446008)(6512007)(316002)(86362001)(66574015)(2906002)(15650500001)(36756003)(107886003)(64756008)(508600001)(110136005)(6636002)(8676002)(82960400001)(66946007)(91956017)(76116006)(54906003)(2616005)(4326008)(6506007)(38070700005)(5660300002)(83380400001)(38100700002)(8936002)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1QxN0JrWlFiVzR2R2dUM3F0cXlRUXdjVmJWNjJJZGxWUlBVOFZHcW5zSVBV?=
 =?utf-8?B?ZG85MW1LMWpmR2VrQnhuMEsvZjd5M25HYUdrc1R0MDNzRDRJNGZnTEVSZkU2?=
 =?utf-8?B?eC91bGZ3VnA4SWJhYWp2ZE9iZzd3Mlk2ZkQxQklvOTJmYmlFRFhNNktsZWtS?=
 =?utf-8?B?ZDZEd3I3U3kzUDNBdUMyNis1ZkJ0cXg4dVQzWFRHcExqempiemxpQ3RDaUdo?=
 =?utf-8?B?Z1JUVXIvNWc3bElhWjExWFdiMDJTWG82ZDQwaUtYNktaTVlqeTNLVUpzU21h?=
 =?utf-8?B?aUJ5L0Z0b05XRDVCRVg5dWdjTFBmNi8remdobHcvSjc1blM0NThrQkxjU1FS?=
 =?utf-8?B?SUpHM3h6NlBrajFYaWlLVThoOWxPSVZ6Rk8zWWllYndqWnZsVTRVRHpOWVVD?=
 =?utf-8?B?WUYrODVCcUtCSDBDMGR4bERRbVBwbEd3TWxNL1Bub0xIdmRWcmp5RE9NRFhU?=
 =?utf-8?B?NGprdDVqdDRkRWZ4Y1JzWWxTV0RBQjFtSFRPMjhlakhWTHZUNWpXSncycitk?=
 =?utf-8?B?MzJnaUVaSjBnS28yK0Z6ZmJEU3dSTG9UWlhTRUZVTExJNTduYUJzQ3k3VzBY?=
 =?utf-8?B?RlkwZlJ2azNvNjcySTUyL0QyeTU5RG95U054N0QrU1Bka3hjbkRXb2liaC9H?=
 =?utf-8?B?NUJGUk02RUZIdHBWcDJJcW9jTHRaTnpNTDJRWjZRYzRFOU1IY1VjQmk5ckZs?=
 =?utf-8?B?N2tCblcvdE9vS003SzRpTk8xeC9KbE9ZRHJSZXNOb1QyZUE2dUNQMkpmd3hq?=
 =?utf-8?B?QnhaZXBjSnhCSWNmSEE4c0QyeXFFKzZ5THBlQ3VsS3lqbUVOSmllVUtwTkZC?=
 =?utf-8?B?aVdIUURTQlRGcldJTmlzMW5YRWorUUEzMGlRR3FRbHZWaGN6UGNSNEdFL0dr?=
 =?utf-8?B?aXZLRTU5NE1teTlEYkszYUZmS05DbDRSOW9zVVNIVWpMTWlreUNadUVIS1Ux?=
 =?utf-8?B?K1NWdlVQODF1V2xWdm8xbUVnc2VMTUIzbWxhUENRMGtrWjBrNHRxZ2ZDVFlF?=
 =?utf-8?B?dy94SEhyTzNTcTNPSWhZSGdXYy8xdEVZZnlnQlo4OVBHeHc2b2NCWmtWUjFh?=
 =?utf-8?B?MUs3R0dhbGh4VW9FRlA4V3p0TXBnRXpuKzBaUGgwOVdXcW5lZnBHb3V6MjlB?=
 =?utf-8?B?cjhSYlduMTRTNVcwb0VLZXhScm9jTm5JNEliemZrYUFqek9YVzNqcFM0OXpZ?=
 =?utf-8?B?TEp4VElXMjdhOVMrdjBFcDUzTXJveW5IcU5kQ0lieTNSdEh0OUthNGZ5NkRB?=
 =?utf-8?B?QkNTUDREUEtTUElBRWpsZjE2akNsa1Z5eW85dzZJeU5WM1Eyak5ZTmttb0lD?=
 =?utf-8?B?MStNNGZLZVJyNUppWFFacXEzVkU4WWxmdUxHUi9ZWDVCWUJpMHFWVzFvbEpR?=
 =?utf-8?B?d2tCRDhNWUJvRDFYNzhpZnRHZXlkbVY0Z0R5cmtlTTE5ckdZR1lwOUc1N29G?=
 =?utf-8?B?MExZdXVCMTFETzg4TEdVSkRDcnovQ2VxQTVlV2paZ2FKb3BlZGdkN1R3Vy9D?=
 =?utf-8?B?cmdmS2ZTL0xiUFhYdUlPU0FYYlRseS9ocE12VHBJeWdTV25UNFVUT3NhNVNl?=
 =?utf-8?B?RmlhYWdoSlc0dmdrQnpuQnNxeG8waENqNFFRVDdTSE5YdnB1RXlvNlZCVDNH?=
 =?utf-8?B?SS8zaHNMQ3pPT3BQeU9MWTlqbHhwWnh0bGd2VGlpWndaUjhvd2lVVUgrYnNm?=
 =?utf-8?B?RUhvYnIyS0FPSy8xb3dNN2FiemRNamRWWVYrMXNpYVNNS0g2TDI1T05xR1RX?=
 =?utf-8?B?Q01jUGlUQjZ1ck9CQ2xUMVE5cEZvV1phU0ZSV1J3MjBIUlpRUnpCMXNlRlRz?=
 =?utf-8?B?enZIQ055TFBSTGdtbUxON3lQRlR0M2JMRzJKNTdPYnJSY2VLR1pyVnlHL3Yw?=
 =?utf-8?B?SnNML1FPcHNQMFE5RGpTOTNLSjF2QmpBY1EzZlk0L1hDeXRJTk5qK1ArTUdP?=
 =?utf-8?B?ZXE2NzYrVmZwVGpTSDRNUThNTkNwOU8rY0ZLUHlMYWZKVlA4VW90Z1RqZXZx?=
 =?utf-8?B?QVJ1dk5yTmlWOGFsdlNvamk3RitOOHB5U1Eyck5OcHhFaDdxd2xWTHZ4dXBx?=
 =?utf-8?B?b1lOcEZUS3FTRng3RmxHaDFtSW0vTjFmRGhDZzliWlV1TEtWMXE0dmFqY0Fw?=
 =?utf-8?B?UGtBU1BxalRjbmZZSFRjdFpFcjJUaTlkMDlxbGVBbmZoTlgvQ0ZOYmwyejRM?=
 =?utf-8?B?Q1FZTjZmcWFqWVlqbXZIZ1VrN2NRNldmY1dVNVU1M2czTVFITGxjRHdoYnp1?=
 =?utf-8?B?QlZTNGVLRHpCV21pSEdzNzk0VjQ5akRwSFBDbVBkWkY3aW9HV0tqSlhINGF3?=
 =?utf-8?B?M2hVTWF3WEFJcUQ0VjBzNTZFMFRkZW56UDY3QlJzTHpIOFRDb1pMalE3ZzRX?=
 =?utf-8?Q?501P4zDrW+81pquN0ir9pmQXeWmOXH/9DORY1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC9F23CA41317C48A85C4F50C169C525@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a446122-0c8a-4fc9-5fd6-08da2288f56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 04:48:05.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJauWksECxDINKNFuLuuECS4NqR/VyUVQ9whs9Y+QjpM7gwL7ktuGeDlpeYiUw70nA7WskVG8BsBzjD02Kkaac3EaDh7+mdGU/AD1q8+OK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDIyOjU4ICswMjAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+ICJHcnVtYmFjaCwgRW1tYW51ZWwiIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRl
bC5jb20+IHdyaXRlczoNCj4gDQo+ID4gT24gVHVlLCAyMDIyLTA0LTE5IGF0IDIwOjQ2ICswMzAw
LCBHcnVtYmFjaCwgRW1tYW51ZWwgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjItMDQtMTkgYXQg
MTM6MzMgKzAyMDAsIFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiB3cm90ZToNCj4gPiA+ID4gIkdy
dW1iYWNoLCBFbW1hbnVlbCIgPGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JpdGVzOg0K
PiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUdWUsIDIwMjItMDQtMTkgYXQgMDk6NDEgKzAzMDAsIEdy
dW1iYWNoLCBFbW1hbnVlbCB3cm90ZToNCj4gPiA+ID4gPiA+IEhpIFRva2UsDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyMi0wNC0xOSBhdCAwNjoyNCArMDAwMCwgQ29lbGhv
LCBMdWNpYW5vIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBNb24sIDIwMjItMDQtMTggYXQgMTM6
MzYgKzAyMDAsIFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiBIaSBMdWNhDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBIaSBUb2tlLA0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJJ3ZlIHN0YXJ0ZWQgc2VlaW5nIGlzc3VlcyB3aXRo
IG15IGl3bHdpZmkgaW50ZXJmYWNlIGdvaW5nIGF3YXkgYWZ0ZXINCj4gPiA+ID4gPiA+ID4gPiBz
dXNwZW5kLiBJIGdldCBlcnJvcnMgbGlrZSB0aGVzZSBpbiBkbWVzZzoNCj4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiBbMTA0MzkzLjE0MjI2NF0gd2xhbjA6IGRlYXV0aGVudGljYXRp
bmcgZnJvbSA0Yzo2MDpkZTplYTpiODo1OCBieSBsb2NhbCBjaG9pY2UNCj4gPiA+ID4gPiA+ID4g
PiAoUmVhc29uOg0KPiA+ID4gPiA+ID4gPiA+IDM9REVBVVRIX0xFQVZJTkcpDQo+ID4gPiA+ID4g
PiA+ID4gWzEwNDM5My4zNDc3NzVdIGl3bG1laSAwMDAwOjAwOjE2LjAtMTMyODA5MDQtNzc5Mi00
ZmNiLWExYWEtNWU3MGNiYjFlODY1OiBDb3VsZG4ndA0KPiA+ID4gPiA+ID4gPiA+IGdldA0KPiA+
ID4gPiA+ID4gPiA+IEFDSw0KPiA+ID4gPiA+ID4gPiA+IGZyb20NCj4gPiA+ID4gPiA+ID4gPiBD
U01FIG9uIEhPU1RfR09FU19ET1dOIG1lc3NhZ2UNCj4gPiA+ID4gPiA+ID4gPiBbMTA0MzkzLjM0
Nzg3Nl0gaXdsbWVpIDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2ItYTFhYS01ZTcwY2Ji
MWU4NjU6IGZhaWxlZCB0bw0KPiA+ID4gPiA+ID4gPiA+IHNlbmQNCj4gPiA+ID4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiA+ID4gPiBTQVBfTUVfTVNHX0NIRUNLX1NIQVJFRF9BUkVBIG1lc3NhZ2Ug
LTE5DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQW5kIHdoZW4gdGhlIGhvc3Qg
Y29tZXMgYmFjayB1cCwgdGhlcmUgaXMgbm8gY29ubmVjdGl2aXR5LiBSZXN0YXJ0aW5nDQo+ID4g
PiA+ID4gPiA+ID4gaXdkIGZpeGVzIHRoZSBwcm9ibGVtLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IFRoaXMgaXMgb24gYSA1LjE3LjMga2VybmVsIChBcmNoIExpbnV4IGRpc3Ry
aWJ1dGlvbiBrZXJuZWwpLCBhbmQgbHNwY2kNCj4gPiA+ID4gPiA+ID4gPiBzYXlzIHRoZSBXaUZp
IGRldmljZSBpcyBhbiAiSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMSIuDQo+ID4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQW55IGlkZWFzPyA6KQ0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gVGhpcyBzZWVtcyB0byBiZSByZWxhdGVkIHRvIGl3bG1laSwgc28gSSBh
ZGRlZCBFbW1hbnVlbCB0byB0aGUgdGhyZWFkLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gQ2FuIHdlIGhhdmUgdGhlIGZ1bGwgZG1lc2cgb3V0cHV0Pw0KPiA+ID4g
PiA+ID4gV2hhdCBOSUMgLyBwbGF0Zm9ybSBkbyB5b3UgaGF2ZT8NCj4gPiA+ID4gPiA+IERvIHlv
dSBoYXZlIEFNVCBjb25maWd1cmVkIGluIHRoZSBCSU9TPw0KPiA+ID4gPiA+ID4gRGlkIHlvdSBl
bmFibGUgd2lyZWxlc3Mgb3BlcmF0aW9uIGluIEFNVD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBB
aCAtIHRoaXMgaXMgQVgyMDEsIG9rLCBidXQgSSBzdGlsbCBuZWVkIHRoZSBwbGF0Zm9ybSBhbmQg
dGhlZnVsbCBkbWVzZyA6LSkNCj4gPiA+ID4gDQo+ID4gPiA+IEl0J3MgYSBMZW5vdm8gVGhpbmtQ
YWQgWDEgQ2FyYm9uIEdlbiA5LCBtb2RlbCAyMFhYUzNIQzI2OyBBTVQgaXMgc2V0IHRvDQo+ID4g
PiA+ICJEaXNhYmxlZCIgaW4gdGhlIEJJT1MuIEkgcmVib290ZWQgYW5kIGRpZCBhIHN1c3BlbmQv
d2FrZSBjeWNsZSBhZnRlcg0KPiA+ID4gPiBjb25uZWN0aW5nIHRvIHRoZSBXaUZpIG5ldHdvcmss
IHdoaWNoIHByb2R1Y2VkIHRoZSBkbWVzZyBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzLg0K
PiA+ID4gVGhpcyBpcyBhIFNreWxha2UgcGxhdGZvcm0gYW5kIHdlIGRpZG4ndCBoYXZlIGEgaGFu
ZHNoYWtlIHdpdGggQ1NNRSB3aGljaCBpcyBub3QgZW5hYmxlZC4gV2UNCj4gPiA+IGFyZQ0KPiA+
ID4gbWlzc2luZyBhIGNoZWNrIGJlZm9yZSB3ZSBzaHV0IGRvd24gaXdsbWVpLg0KPiA+IA0KPiA+
IEhtLi4uIG5vLCB0aGF0IHNlZW1zIHRvIGJlIDExdGggZ2VuZXJhdGlvbi4uLiBzbyBUaWdlckxh
a2U/DQo+ID4gQnV0IHN0aWxsLCB0aGUgZml4IGJlbG93IHNlZW1zIHJlbGV2YW50Lg0KPiANCj4g
SG1tLCB0cmllZCB0aGUgcGF0Y2ggYW5kIHRoZSBtZXNzYWdlIGlzIHN0aWxsIHRoZXJlIChhcyBp
cyB0aGUgYnVnKS4uLg0KPiBUaGUgZXJyb3IgY29kZSBpcyBkaWZmZXJlbnQgbm93LCB0aG91Z2g6
DQo+IA0KPiBbwqDCoCA2NS43NzM3MzFdIHdsYW4wOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gNGM6
NjA6ZGU6ZWE6Yjg6NWEgYnkgbG9jYWwgY2hvaWNlIChSZWFzb246DQo+IDM9REVBVVRIX0xFQVZJ
TkcpDQo+IFvCoMKgIDY1Ljk3Mzc2N10gaXdsbWVpIDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03Nzky
LTRmY2ItYTFhYS01ZTcwY2JiMWU4NjU6IENvdWxkbid0IGdldCBBQ0sgZnJvbQ0KPiBDU01FIG9u
IEhPU1RfR09FU19ET1dOIG1lc3NhZ2UNCj4gW8KgwqAgNjUuOTczODQ1XSBpd2xtZWkgMDAwMDow
MDoxNi4wLTEzMjgwOTA0LTc3OTItNGZjYi1hMWFhLTVlNzBjYmIxZTg2NTogZmFpbGVkIHRvIHNl
bmQgdGhlDQo+IFNBUF9NRV9NU0dfQ0hFQ0tfU0hBUkVEX0FSRUEgbWVzc2FnZSAtMTQNCj4gDQoN
ClNvIHlvdSBkbyBnZXQgYSBTQVAgY29ubmVjdGlvbi4gV2VpcmQuDQpDaGVja2luZyB3aXRoIHRo
ZSBDU01FIGd1eXMuDQpDYW4geW91IGdldCBkeW5hbWljIGRlYnVnIHByaW50cyBmb3IgaXdsbWVp
IG1vZHVsZT8NCkJlc3Qgd291bGQgYmUgdHJhY2luZyB3aXRoIC1lIGl3bG1laV9zYXBfY21kDQoN
CkkgbWlnaHQgYWxzbyBuZWVkIGR5bmFtaWMgZGViZ3VnIHByaW50cyBmcm9tIHRoZSBtZWkgYnVz
IGRyaXZlciBidXQgdGhhdCB3aWxsIGJlIGZvciBsYXRlci4NClRoYW5rcyBmb3IgcmVwb3J0aW5n
IGFuZCBwcm92aWRpbmcgdGhlIGRhdGEhDQo=
