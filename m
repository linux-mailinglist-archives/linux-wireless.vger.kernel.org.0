Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED575AEB9B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbiIFOUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbiIFOTK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:19:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EC82877
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662472212; x=1694008212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VuM+mY28Df/77Q25J5Mf19Q6Dtg0RKkoaiF1EZEJfvw=;
  b=JEdOlKho53rE7s0jWbZIOOv3HyeKBXXDHIkxslppU7RaIAia45mVUOgy
   69ultbgZA/YhhezJgjoieVUfxPV6e8xUmUbl4cUR/TYamHizPHst/y17Q
   +K4OJwXjywiNqEWYI9iJG4TvKz3oYZjDmLrJFHpzyu/ge4ydwn6OPwm3r
   qjnlFj83LVJRqiNBLzBTjlGY54IGRSUywDHw/JVC3prcdOPXd9nMmQ56Z
   9D91GB4fiX3OtXQcOzLBHslKnWHgFTCXJP0s69023CWzl0W4Fw6Frim8G
   PkubB1peSQs0ZB8by0a8HrxDDcwJxdhREpG3TjsGVvhO2+/R0zRHtcMtp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="382891374"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382891374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="703214665"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2022 06:48:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 06:48:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 06:48:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 06:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDMdIpg6ThsCT/t5SUnY+OdyB184cT51cyr3GS2+KKqVTctx1aTdVkh4PWBSte+CWJEXs/InsAEk0+yt2T56s5LRVrng31fD8IgGODufzYTyqqeYoTE30IJ+mZ79JQfu0zF4O0FLnMHVjKbeJiIQLKSaHin1iZtHdn86LTNUWZmhDn2jXIG2BI2rffjOQs15N8mM9QgvoptnnTNV4YbSG4Sh8xcIweqi546dWfNpXeEK06yNo6PLC0NV0G7ZpZKpRiRMEHhn0UT3TyNKwaDdS+d1G9CIiFgS0KPyzkeBOoBAVzKd6veThdnYYGHM/F9jTnlSIXpzv2yTXgXGARI7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuM+mY28Df/77Q25J5Mf19Q6Dtg0RKkoaiF1EZEJfvw=;
 b=RXLeLYYJ7Q+tdHNjS0On4KPZj61ixigobZvc5eR3uqMJK2Q71QAOW/XKdZUwmRBRwLVrebdeJkzao7SYcwKs+JkaX045IXlDnzXOWInIPs2etAqrlQQJtDsqdL8FIqAUMTKSHcEOZJqVwIvN5MXKI+Gw7tAK8gIaPXSrrHmevLF4pKYhKaGSlhuaP4qiF+UgBjyGGioPSVxLo1Wa4myQ19gJLl602teU51U51OV26fjHbUBlvtYdP1ip+X55Tv8zI9YIS6BBFWkSbQiOkUjAcTQ5sxpbhMeqmh8/6hwz9P42OtVVkT+qEHbOlaeZZYj4PEOIjyd75ec7YuN94L3rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM6PR11MB3930.namprd11.prod.outlook.com (2603:10b6:5:197::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 13:48:37 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517%9]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 13:48:37 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/15] iwlwifi: updates intended for v6.0
Thread-Topic: [PATCH 00/15] iwlwifi: updates intended for v6.0
Thread-Index: AQHYwfaYtr+hQqQYskOVrYr56X589a3SasqA
Date:   Tue, 6 Sep 2022 13:48:37 +0000
Message-ID: <18b973a48d2df0393e896a36054089ce37a3352e.camel@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e8d9bc-3c42-48d8-87ee-08da900e7fcf
x-ms-traffictypediagnostic: DM6PR11MB3930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7EM+Q24M8rvzqass2bcTM4P8dfEZYn9HDKoJcoI2Ekfv/wS+dr0Nbps2D4fiSiJkSedUWTJDuN2ou1EUYoC3AlCsw1EtmetE0ZM2r0Dj+khV7KCOBnX723ym1jZr64kYczABvKeL/U2+d9hwMki9lCQxRUEPuZx+/uzU2UeBCzILZL+LFbk77tys3fbSHgLFfCEDHZAtusq9PzUF0VpiCUdaZ8P8goe3jaCZjsDDBmZHxgZ+/IFSah++iyB0tRF24b8/dRDEZSOxgjWNZ3d6Gjz5Sq6RUS07M8ofbIsLczlhqBQlXw3tmq5fEdDxQQrVS16EBTu339vBsSXLjnDgPZ5F+s/4BJTDsi9gx5lcf71gXWUG4tOS2NslAqCM68MdwFXjWaFs/VvEsGmWT7UlTbPFfsW4sZgxWgAI1qUhWeHPIAGuSYw0tomMKNP9On2vkxwvvTLpt8ROmAzF5yKBsvXjJBwsDKOrHhCauUSlQsVnxCQ3qfUbcBnr9PVJU3Z3TdS/voW5wINzi5JDzNN42P2aI5fMf33vJeg4cb+LU3O/0md3mAh7phA3T3pT1XuEZ2AJqb2k9LBjCc+4bBvbaiMYuVYhqbvSQm3eMZUCSQ2AnakGaByCm7WNc/5TA486hZbp9khvhuoKTCMYQMKG96NPo+fCsZBKPzwBSWrOV61wa4zw+Sgz9OPFad8xl51A/QElhf/atD1fs/mO3ddG789s+aE8pQYLR3CNC02Nkjdvoyi2OZ59LL1h8QOyu2fnwotRzDDmjzMfr10ip/vBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(39860400002)(136003)(66446008)(91956017)(2906002)(66476007)(64756008)(76116006)(4326008)(8676002)(5660300002)(15650500001)(8936002)(66946007)(110136005)(66556008)(316002)(71200400001)(6486002)(36756003)(478600001)(82960400001)(38070700005)(6506007)(83380400001)(26005)(6512007)(2616005)(86362001)(38100700002)(186003)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWxodUdQckdLYk43ODdOcGFxVUwwalFHWjMrY0JoT3l5T2xVNHdvUVRyRlVa?=
 =?utf-8?B?UU5zNjl3UHFNVDBUbGt3NmVpRE8yYlZ5V0tZYkJtczV6bmpVSkZydkhBY2F2?=
 =?utf-8?B?ZnBzd0ovV2pBZ21SNkNpeWxiSVdjeE1yT3VxQjRRazJTeVYyQi9yNUhHVjE2?=
 =?utf-8?B?SGdFY2xUOEg0QXFCYjA2WVFoNkJYMUZrSGpiZENFQjc4Z2tubEpuS01aNTAv?=
 =?utf-8?B?SnRqb3NlN3ZlMzFlN2tBK1FyTnczWlQvdHNrUVptZU5NaWRsMHN1M2pLalQv?=
 =?utf-8?B?R1d1WHUzN3BvL3VaVStCZ25qdmg0UjFJMmIvMEcwcDhtT1BabHRuNHhtUmJU?=
 =?utf-8?B?MFYwQlhrNm5ocG5qSXUvVmtza1l2Z3luSE90YVpKS29tbWRZYlZjZURXWmxI?=
 =?utf-8?B?VVk5VGdTK21iWXR2eEsvRG9SZGJXUStBZ05qQ1I1MHlDYkN3ZHhOdU9zRkx6?=
 =?utf-8?B?bU5Ia3BrTjBjRTg3Ym1LMFhwbXV1eE5kYkdDcHFROGkya2xKbytWclZSdWxz?=
 =?utf-8?B?cjNyOVQxNE0zRUZMejNiWnZmZjFMRUxyaUhtSXVZOGliei9yQ1FhYUJTOXJa?=
 =?utf-8?B?andJalFCOWhuNmhLRzROZDdzM0s0d1hob2JBUHdBbENmUk9mUDdKb1RDMnZK?=
 =?utf-8?B?Z1NSN2FSTzZMV2RTSEUvYUxKU0xKK1BPd0xhN1J6SEtoQnVsOHhiS25vb1hY?=
 =?utf-8?B?QWpNLzdLV01lR3ZKOU1WZUt1MkRIc0VvUzEwaFdDTHZHTkd0UXJLaDN6ZVB1?=
 =?utf-8?B?d2dJQkhSZXZNQTByeG01ZzVGa09Zd2dOZVlONTRRTk4zNXZUZGtVYVF2K0JX?=
 =?utf-8?B?L0NJanJhVFFwcDJ1NUpZZVRGRjl5eUFONXJzU1BINys2N0lKbUxPQ2YvT2Rq?=
 =?utf-8?B?SlFGN0lMdU1DUzlObzJZMmZReEx0V2dsMS9Pb0xBeTNlOTloa3FKaGF4MTVH?=
 =?utf-8?B?dnJ4WDhKWkNpdnBaZVFUa1V2ZjY4ajZNa3h4aG1DQ2dBWUhTYzEvOFdla0x5?=
 =?utf-8?B?R2VBVVpjWFJwdVdmcnI4eVdTQTZyM2FSN1dzSTB0QmV6Tnd6U2h1R01kVW5o?=
 =?utf-8?B?M3ZINXEraGcwUjM4cUxlZlhwZGlXTmdjUWNSRTFXRGd6SDNseTVTTkh6TUJS?=
 =?utf-8?B?V3p4MEw5WE42M1ZTdEVaekNSbnkwbCtKZjdkUDloZjRYTloxK1pmMEdJaVRx?=
 =?utf-8?B?RlhzdzRZdUR3V3ZSMHg3TTZJT3dLMWRBam5jOURkYStBeHN1VW55U2xEdHlo?=
 =?utf-8?B?cFE1S1BUenEyQnVJZmVPZGJhNVdkejU3N210U2drZkJZUWdPU2ZPeTFHVmhO?=
 =?utf-8?B?cVQvVFl1dCtjM2loRVdiVm9wckRRYjFDY2RzVlh5UUxnUHdxMjlKOWY1SGxl?=
 =?utf-8?B?RVRIbEtma2IyaHk0a3hWU1hPbjBxMk40RzVWN010K3lkeW5YZlpvRVU5WktN?=
 =?utf-8?B?aGI2bklYbDdUbmpzdnpQTHp0WTR0Y0dSVzNuZkR6bGVidk16clJlNlhKcEpS?=
 =?utf-8?B?a2dWU3VYazBvblRjZmQ1R1BJQUs3YjM4bWJCbWRINFhpeDVLRVNMR3VHZ3RB?=
 =?utf-8?B?bkFnMUc1aUoyQVViQkVwL3VKM3o1a2s0dVR0emtlMzZLa3owNFBYbW5XdzNl?=
 =?utf-8?B?OEZKK2g0T3ZnU3ZEY1JyakRHTWMrSFNwM2g2YTZtOEpWRVcrWWRsejJ5Q1Ns?=
 =?utf-8?B?eDBXa3NxNDcvRTZvNFZDQ2hXMnJzNmJ0Ylg2MEw5RGQ0a1Mrb3NrODBwOU5O?=
 =?utf-8?B?TTc5WnNDcGErc3pXWTlZZUYyUGpXZXEreHZRSUFpcTcwRytiS3pCSDBGcmpu?=
 =?utf-8?B?U0hhcmFWOHdwcmJPRW9xdG8xcU0xSEZ6YmYwbEVERkdjaUY5dnJUWCttOERW?=
 =?utf-8?B?S2w2YmpHTHQ5NVBVb3haT2JGclFnbFNoVml0MlZmeWc2OEszdE9tL2pCeHVk?=
 =?utf-8?B?TURZQkl0TUFCZnhhT1Z6T29iY2srZ01YRE0yZjd4SVNWZ0Q4cjA1NGRVcFp6?=
 =?utf-8?B?ZUJ2bXJxcEk5YzgwNU5mTTM0TzlCSExON2ZoeGRZWU81T2l4M1ZOVEZtTE5l?=
 =?utf-8?B?c3dnY1NDbngxQmlrUmZPVHZjN1BZTTZVSit6b0hPT3pMUnRySDVxcHlJeVpr?=
 =?utf-8?B?bk1HbEliMGRoQU5ZYmE3eVpKSjdieVg0aXVEcG5jMWhXUWo4MDZzNHBVbXhH?=
 =?utf-8?Q?4Eng8Q3V02bb4aH/3H6kx8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271FB3B84B778943A94D062CA396DF9F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e8d9bc-3c42-48d8-87ee-08da900e7fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 13:48:37.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6TqiV5fgK20R/un7TNDYcAOy+MyG1dRLuBWRUmaVc0pNPeN2cgPMHDtBSveAv67dJltM0wpCwnhpUN2iuVu8XiIP8vA8qB0ujo5+FMhqYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTA2IGF0IDE2OjQyICswMzAwLCBncmVnb3J5LmdyZWVubWFuQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBp
bnRlbC5jb20+DQo+IA0KPiBIaSwNCj4gDQo+IEFmdGVyIHNvbWUgaGlhdHVzLCB3ZSdyZSBzdGFy
dGluZyB0byBzZW5kIGl3bHdpZmkgcGF0Y2hlcyBhZ2Fpbi4NCj4gSGVyZSdzIHRoZSBmaXJzdCBz
ZXQgb2YgcGF0Y2hlcyBpbnRlbmRlZCBmb3IgdjYuMC4gSXQgY29udGFpbnMNCj4gdGhlIHVzdWFs
IGRldmVsb3BtZW50LCBuZXcgZmVhdHVyZXMgYW5kIGNsZWFudXBzLg0KPiANCj4gVGhlIGNoYW5n
ZXMgYXJlOg0KPiAqIFJlZmFjdG9yaW5nIG9mIHNvbWUgd293bGFuIHJlbGF0ZWQgY29kZQ0KPiAq
IEZpeGVzIGFuZCBjbGVhbnVwcw0KPiAqIEFkZGluZyBzdXBwb3J0IGZvciBCWiBkZXZpY2UgZmFt
aWx5DQo+IA0KPiBBcyB1c3VhbCwgdGhlc2UgY29tbWl0cyBhcmUgcHVzaGVkIHRvIGEgcGVuZGlu
ZyBicmFuY2gsIGZvciBrYnVpbGQgYm90Lg0KPiBJJ2xsIHNlbmQgYSBwdWxsLXJlcXVlc3QgbGF0
ZXIuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEdyZWdvcnkNCj4gDQo+IEhhaW0gRHJleWZ1c3Mg
KDUpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IGRvbid0IGNoZWNrIEQwSTMgdmVyc2lvbg0K
PiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IEFkZCBzdXBwb3J0IGZvciB3b3dsYW4gaW5mbyBub3Rp
ZmljYXRpb24NCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBBZGQgc3VwcG9ydCBmb3Igd293bGFu
IHdha2UgcGFja2V0IG5vdGlmaWNhdGlvbg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IEFkZCBz
dXBwb3J0IGZvciBkMyBlbmQgbm90aWZpY2F0aW9uDQo+IMKgIHdpZmk6IGl3bHdpZmk6IG12bTog
ZW5hYmxlIHJlc3VtZSBiYXNlZCBvbiBub3RpZmljYXRpb25zDQo+IA0KPiBIYWltLCBEcmV5ZnVz
cyAoMSk6DQo+IMKgIHdpZmk6IGl3bHdpZmk6IG12bTogdHJpZ2dlciByZXN1bWUgZmxvdyBiZWZv
cmUgd2FpdCBmb3Igbm90aWZpY2F0aW9ucw0KPiANCj4gSWxhbiBQZWVyICgxKToNCj4gwqAgd2lm
aTogaXdsd2lmaTogbXZtOiBBZGQgaGFuZGxpbmcgZm9yIHNjYW4gb2ZmbG9hZCBtYXRjaCBpbmZv
DQo+IMKgwqDCoCBub3RpZmljYXRpb24NCj4gDQo+IEpvaGFubmVzIEJlcmcgKDUpOg0KPiDCoCB3
aWZpOiBpd2x3aWZpOiBtdm06IGZpeCB0eXBvIGluIHN0cnVjdCBpd2xfcnhfbm9fZGF0YSBBUEkN
Cj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiByeG1xOiByZWZhY3RvciBtYWM4MDIxMSByeF9zdGF0
dXMgc2V0dGluZw0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IHJ4bXE6IGZ1cnRoZXIgdW5pZnkg
c29tZSBWSFQvSEUgY29kZQ0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IHJlZmFjdG9yIGl3bF9t
dm1fc2V0X3N0YV9yYXRlKCkgYSBiaXQNCj4gwqAgd2lmaTogaXdsd2lmaTogY2ZnOiByZW1vdmUg
SVdMX0RFVklDRV9CWl9DT01NT04gbWFjcm8NCj4gDQo+IE5hZnRhbGkgR29sZHN0ZWluICgxKToN
Cj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBkMzogcGFyc2Uga2V5cyBmcm9tIHdvd2xhbiBpbmZv
IG5vdGlmaWNhdGlvbg0KPiANCj4gWWFhcmEgQmFydWNoICgxKToNCj4gwqAgd2lmaTogaXdsd2lm
aTogcGNpZTogYWRkIHN1cHBvcnQgZm9yIEJaIGRldmljZXMNCj4gDQo+IFllZGlkeWEgQmVuc2hp
bW9sICgxKToNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBpdGVyYXRlIG92ZXIgaW50ZXJmYWNl
cyBhZnRlciBhbiBhc3NlcnQgaW4gZDMNCj4gDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL2NmZy8yMjAwMC5jwqDCoMKgIHzCoCA0MiArLQ0KPiDCoC4uLi93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2Z3L2FwaS9jb21tYW5kcy5owqAgfMKgwqAgNSArLQ0KPiDCoC4uLi9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvZDMuaMKgwqDCoCB8wqAgNjEgKy0NCj4gwqAuLi4v
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvb2ZmbG9hZC5owqDCoCB8wqAgMTcgKy0NCj4g
wqAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3J4LmjCoMKgwqAgfMKgwqAg
NCArLQ0KPiDCoC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvc2Nhbi5owqAg
fMKgIDIwICstDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1jb25maWcu
aMKgwqAgfMKgwqAgMyArDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vZDMuY8KgwqAgfCA2NjggKysrKysrKysrKysrKy0tLS0tDQo+IMKgLi4uL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jIHzCoCAyNSArLQ0KPiDCoGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5owqAgfMKgwqAgMSAtDQo+IMKgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmPCoCB8wqAgMTggKy0NCj4gwqBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1xLmMgfCAzNzYgKysrKyst
LS0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyB8
wqAgMTkgKy0NCj4gwqAxMyBmaWxlcyBjaGFuZ2VkLCA4NDYgaW5zZXJ0aW9ucygrKSwgNDEzIGRl
bGV0aW9ucygtKQ0KPiANCg0KQSBzbWFsbCBjb3JyZWN0aW9uIC0gdGhlc2UgcGF0Y2hlcyBhcmUg
aW50ZW5kZWQgZm9yIHY2LjEuDQoNClRoYW5rcywNCkdyZWdvcnkNCg0K
