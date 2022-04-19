Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B250713C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbiDSPCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 11:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiDSPCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 11:02:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43F23B029
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650380359; x=1681916359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FhmavZ83xpAONwzHgua+kVCN+C6ke3gYBADWnALyuoQ=;
  b=M9v3Cg+x9r2iUCGnEbVO3qkTpJMoldYUx9bOHhnSmkjyZhADgD6S3of0
   osc7QullZYdW+bxgTKVtQrLwcDh6AAo1XejVjAlMyl3CnmWbtF2ju5hFV
   IID6ZU/du6pc9lRZqP4OZTbQt7jVEyUjn5hBeWtSMYtac8bzcpmtKxpyh
   CzwInicMHiWs9L3pynPoa2mK68PIHptop72Q7szu++sgkoa72SYj7sTje
   BD8+pBJUTCnfUxqd5WM90NJFSwlKrvRsvioquwLN7bbHEZuKzjQJ6VNFe
   iugzvduha6VsNnkPhUsPNGznwEO/cZjJB66twQuNwP1WF0dLPeCP5imIp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244368342"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="244368342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="666354483"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 07:59:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 07:59:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 07:59:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 07:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir+8QS1dVckzTaRBfypES45JQ580gwOvOvtTqBi3HaK1j/siKeB8ZT9keSO4AfgmZKtca3y2wYyvGjFc+/zbixGqRg0xUVtX2ElgqSUFisCzzW5h5cTAOZLBcYaEvBWpCE/qMGytdHxuqtRaHgHLSu2abCGWCHai+AZSojAL6karSggODcrTfVlUTyNiW1s3WUzZ793us3SFpdFCCgSOBtS0l6mPoljtYRBWGK7rAWiUTkxlMw2k99IwscaQvLzFiMlcpReOv7g8Y3aq5JeF631VNWwNzDYb8nnc9fRy2dY8mGw/trBkitGC7WdX6eQg80Ai9zahxnUwB0YJ1xWgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhmavZ83xpAONwzHgua+kVCN+C6ke3gYBADWnALyuoQ=;
 b=Leb1V8jySbi0iWAlsUebAxyeyU/OnX/FVfna8bX2uSmgSmw8jbWqQqqwfhPtf3nNZ9dM4Su2hUYu8JlGFwaEMtkf6E45YTtkWdatn3CczFWdnCP1JKRT2dDS8ODhIuEP2iZXQJGle5vFAIjO4sdU2aVqjTdJaSG8GKJBvU/9c0GoRlNrRSlq6SHPKNrV016cp9dJP9U43xuNhuEl5D1AXN1C++CRG7OWRUQAFhgumBTZi1BnEsJcVRW1o6WGg5rFekrkE4MZzHpgAC7GOeJ+/LpKFgygt+T7I7pad4WxJYA6bS3dZv+k7nK6fBFMD77yBNB6jjxwq2DYzJpZ2em7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by DM6PR11MB3001.namprd11.prod.outlook.com (2603:10b6:5:6e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:59:16 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::d47f:5a63:f3ab:a5c9]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::d47f:5a63:f3ab:a5c9%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 14:59:16 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgABSk4CAAD1KgA==
Date:   Tue, 19 Apr 2022 14:59:16 +0000
Message-ID: <f2cb9bd4fc540454ed687822e3a8dc0a5f62b352.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <871qxt2ucm.fsf@toke.dk>
In-Reply-To: <871qxt2ucm.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.0-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 995ba561-2895-4c10-d332-08da22152c8a
x-ms-traffictypediagnostic: DM6PR11MB3001:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3001ACE28241E15BCF86051B90F29@DM6PR11MB3001.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHcbTFl40448F1bINAp1CMiDElgZhVLGd+9GebkhHET8IBETn2m9BhvFHx0PdynJbWXBVN4AcTpDKbLMk93kyk/Rc0cITk05pKAyjXKLgWvxFxPCqSpVTqy4sBYRgEAyskdtyoFdrLNkhtXv1D5F0DmRw0YbskMMwXVC0QE7Iyt3gFZpkJgYJVAu50NzTxmCy2orJLK8OS2goGF2svB6n1qUtP3JttGABXxJaFAwDSbgsmmwlrLzNPWHlAgNlBEL5PulrPpPfIHY25bbYt5fQGPiFzK/+x1B/m5Ph35a1jyLaYNqJVpZsHNK/hduWpO5PMH888/JYZyx9hfz1w8Hs6+OIqN7mlJjQXRuG0Frg8Tt7QGNYj6AIeqBOpfynrT+L4ARb9hj0GHoJAkJ3RaMv6ddlpJ0y9goLns1g+KVbHyNSkbZ+pLwQOZ4VNuVDpAbH+/8g7vJrVZIsv9lmg7E4yc+VCbw/69zoiELM+ffJTe3PXZP8hyAtghbOt2zMf60aQZi8tp43NjZ8qRHyv6QeBF3evtPyoLSfdK7IPvP6PD3HwfFetDGpjOZEdbEUog02ornt5ynMH4fnBFc1W/rlgpCu6IvUNAZvq0UWwOoeVrFuifDiWdAFYx61+8uvhCSxkP17DO+aA2hkl/6Xoluhn9HOX8X/W6toYqpRg3ze6z85b3+4zbxNRp3wLku7sN31MRBMG3iqUr2LHKWWUI9SzCVOXn/vy/fdFXfpp5gSHxfiOhkljgJ8rJcjURRW5H3tPwIN218Fk3uLX8ll1EhlUUKO1wapMd6ZD4OXNRjrtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(6486002)(966005)(71200400001)(107886003)(122000001)(91956017)(2616005)(110136005)(4326008)(15650500001)(316002)(186003)(66574015)(6506007)(6512007)(6636002)(2906002)(54906003)(36756003)(66446008)(76116006)(83380400001)(508600001)(8676002)(86362001)(5660300002)(66476007)(82960400001)(66556008)(66946007)(26005)(38070700005)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWUxclY0Unk3dEFiaFIyc2JWSENpTDM0eHYzWWJjZ2hRNUxqU1krMlRHN0RB?=
 =?utf-8?B?U09PZE5Vbml0cnJXYXZIM1Z4Tm9YdThxZEtmY1UxVDVHeEVVMWZ2cmpyMWtM?=
 =?utf-8?B?SVZ0UytyZWF3V255cDZDS21QZElYNnd3bklhOUEvYk5mMFZOZmlkNkpzY0ZS?=
 =?utf-8?B?UjNtK1lWaXZrY3pzRXg1NXJXcDJrK1E0RTJHbm1YRXVxS0toRjNCQWZwb3hz?=
 =?utf-8?B?b3VBN1JxZFFvbldTQ2V3ck82NEwxRk1UR01WVlNOOXptYzRIUjg0bEFyekVC?=
 =?utf-8?B?VDc5S0RZbUlGRUZFMVlVTllUN010UnpNZ01ESVNHNkM3YnNLYUNJZnVFS28z?=
 =?utf-8?B?VEtpZXhodHdhZWZBeHJUVTE0U0FEVW9PTXVJY0xUdkVqYUExcTE5UDhFRDBw?=
 =?utf-8?B?OElRWlhPYkpyT0NBblhuOUtaZHNMYStMME9reldFKzc4a3dyRnFBNFVpOTVG?=
 =?utf-8?B?UFVZb2FnTVdXRWtIUHNDdnlobDg5dzNucWJOS3Y4ZGRSTFViU2JzQWdsWXc0?=
 =?utf-8?B?eDQ2a0o5OVlVTjBNMElDZlMvVk1aQVgrbzNTYnA0bys1MjlhSWJLWmVXOVBP?=
 =?utf-8?B?TXpXeG1RWlFnVjRyR1A1SjFsdDRSanhmclpzOTdleGhLSTZxZGlNV1AyUy81?=
 =?utf-8?B?dGxKem5BUGZmVmFkblRkZHpkK0Y5eGxjUzN5TlNGc2FMbXNHU3JtaitHNVlB?=
 =?utf-8?B?d2JsY0tNc09ONnhqTk9CYTdDTktsRnFZRXk3M25RSHF0U3hxcDRzNkVyejJX?=
 =?utf-8?B?a1NuQWVUeDFnME9tUXFaVGhJeGZ1MjFuRDNBZk1MejBVLzI2TkZ6eWF4NXRr?=
 =?utf-8?B?eWU4QXBlbnJiZFVsMkNCUUJIQUVRd0FtbFZaN0ZabHp3RmRtdnBUUUxTRUVz?=
 =?utf-8?B?T1hSZVFNUytzRW53SzNNNjJJdC94cHhZL1dldmROSDFWQ3dIMEdtMndrQ3dL?=
 =?utf-8?B?dmlMMkN1N1RqVWM4NFFUVHQ4Wjk2RklJQkhCQzZGQ0pvU3FWeVo4b0xoMU52?=
 =?utf-8?B?R083Z0RqeTV3aFo3M1p1ajJYd25KS2JYMjM1bUlTYUxxVU5nTUl5R1ZxZmFX?=
 =?utf-8?B?aWxxR2N4NC91QkppbFdmenVhUW9pY2lxZUNsa0pyTTEwck44RFBnamU3TWF1?=
 =?utf-8?B?L1hIMEI1emxmbjNFdEl6MEZ4eDMxb1pJZ3pWM0dBbnBhWVN1TG9GbldTS3B2?=
 =?utf-8?B?RmZ4WERpK3BmcVhsV3NESzl6MGJTVlVkWDhGcWFwYW9RUFlFcGVubXJENFlz?=
 =?utf-8?B?Tk5XSWw1L05DTTVRWjM1NENkSUs5S005SkF1Um1FQU92a3owWVROUHFjYjJM?=
 =?utf-8?B?aDE3OEZLZDZHN2d6M1JtLzA5SEY5ZVgyL1NGZHcrT1l2UUw5WVBaMWl1R1N2?=
 =?utf-8?B?VVBvV0NlU3ZoNlNGdHdDN2hJNi9ycnRBTWZLOXRkdFQ0QUdhbzFsV3VYZDdy?=
 =?utf-8?B?UjdzYldhZjlocjhlT3NqbHNGVzFvMGltTjJKVkhSTUhiRzNjNnpQZzQrUld1?=
 =?utf-8?B?aHdVTEErREJCa2hUZHVDNVV4Z1VGVVgxTFpxNSsycVhyWlAvOEk3TlFTR2xq?=
 =?utf-8?B?M3lrS3BmSXNXSlBhdUJ5U0dSZUVpQWdpMXNsSWE1eUFsZXJxdmxwbTVzVTds?=
 =?utf-8?B?d1VCMWE4MlQxWVA3dU9pSTg5VlVJQkV3MkNWdFZkY3c0ZlFLczNmamF1SUdl?=
 =?utf-8?B?VUtTNUVwdzhBcVIyZWJXRTVXdWNpN2RISmdiZzZOUzZPUVMrQ2xrWlNpMnZE?=
 =?utf-8?B?eXI0K0VwLyt6SzhSTDU5aWJvOEpBOGZWcjRNVHBzeUphMUJKeEwrbHZETlYw?=
 =?utf-8?B?eDZ2NjlnaFhhUjFDSU1ZSzZCeXN4a2IrUTRMRGJxRm5DazR4cmFwdWVqUjdv?=
 =?utf-8?B?bU1UOXNNb21CTlRpODA3QkpKSnVzdkkzS3BUd00zTzcvU3JUOW5iUEhONlFU?=
 =?utf-8?B?RDlZc1JHKytQNFVzU0k5cDJxcnVEeGxzUUdJajVNbGhJWkxOQy9VdWp0clBl?=
 =?utf-8?B?VlpzVUJxL0dMNzlDbWFlc0hUQ0RDM1hoRk81OWtKNXkwcU4ybmZ4RmlSNmlo?=
 =?utf-8?B?WkpOSjBYSDVXN2d1dlNDdW5QSXZycTVsWXBzb01FeEpCaEFjMld1U0hRSmlz?=
 =?utf-8?B?TDFYSjU0dEdzZTg4dllrTFZ5amN2dk5TNHB0N1ZDai9RcEEzQWtsQ3FxRDlE?=
 =?utf-8?B?aXRaMGlsODJrRVdHeS9neDF1aXJUaHQyOVczd054cE1xbEl2bzZoc1kxWllY?=
 =?utf-8?B?TXNoc2xGVHpmckNybURhRjZvTFFyNUhpVUd0MXpwQ0VVdk5zWjZxajgyNlo2?=
 =?utf-8?B?K1VBdDNndk1BL09iempXTTFPQTM1SFd3WnI0Mk9kY3I5bjZzbU84MVhXakp5?=
 =?utf-8?Q?ws8JhSIZDUTjYnHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693CEEAE2058824D877DADB29955DFEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995ba561-2895-4c10-d332-08da22152c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 14:59:16.2362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kw0Vbg6EssM7Cs55aa4Lvgrk1CkqCUGb7G9//l9a5+84VCg33rDQPy6DrVuUOzdBXqT0t29i9L7/dRlAW5ds6+gDCy3TSUb1mN/TRoM4h4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3001
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDEzOjE5ICswMjAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+ICJDb2VsaG8sIEx1Y2lhbm8iIDxsdWNpYW5vLmNvZWxob0BpbnRlbC5jb20+
IHdyaXRlczoNCj4gDQo+ID4gT24gTW9uLCAyMDIyLTA0LTE4IGF0IDEzOjM2ICswMjAwLCBUb2tl
IEjDuGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6DQo+ID4gPiBIaSBMdWNhDQo+ID4gDQo+ID4gSGkg
VG9rZSwNCj4gPiANCj4gPiA+IEkndmUgc3RhcnRlZCBzZWVpbmcgaXNzdWVzIHdpdGggbXkgaXds
d2lmaSBpbnRlcmZhY2UgZ29pbmcgYXdheSBhZnRlcg0KPiA+ID4gc3VzcGVuZC4gSSBnZXQgZXJy
b3JzIGxpa2UgdGhlc2UgaW4gZG1lc2c6DQo+ID4gPiANCj4gPiA+IFsxMDQzOTMuMTQyMjY0XSB3
bGFuMDogZGVhdXRoZW50aWNhdGluZyBmcm9tIDRjOjYwOmRlOmVhOmI4OjU4IGJ5IGxvY2FsIGNo
b2ljZSAoUmVhc29uOiAzPURFQVVUSF9MRUFWSU5HKQ0KPiA+ID4gWzEwNDM5My4zNDc3NzVdIGl3
bG1laSAwMDAwOjAwOjE2LjAtMTMyODA5MDQtNzc5Mi00ZmNiLWExYWEtNWU3MGNiYjFlODY1OiBD
b3VsZG4ndCBnZXQgQUNLIGZyb20gQ1NNRSBvbiBIT1NUX0dPRVNfRE9XTiBtZXNzYWdlDQo+ID4g
PiBbMTA0MzkzLjM0Nzg3Nl0gaXdsbWVpIDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2It
YTFhYS01ZTcwY2JiMWU4NjU6IGZhaWxlZCB0byBzZW5kIHRoZSBTQVBfTUVfTVNHX0NIRUNLX1NI
QVJFRF9BUkVBIG1lc3NhZ2UgLTE5DQo+ID4gPiANCj4gPiA+IEFuZCB3aGVuIHRoZSBob3N0IGNv
bWVzIGJhY2sgdXAsIHRoZXJlIGlzIG5vIGNvbm5lY3Rpdml0eS4gUmVzdGFydGluZw0KPiA+ID4g
aXdkIGZpeGVzIHRoZSBwcm9ibGVtLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIG9uIGEgNS4xNy4z
IGtlcm5lbCAoQXJjaCBMaW51eCBkaXN0cmlidXRpb24ga2VybmVsKSwgYW5kIGxzcGNpDQo+ID4g
PiBzYXlzIHRoZSBXaUZpIGRldmljZSBpcyBhbiAiSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBB
WDIwMSIuDQo+ID4gPiANCj4gPiA+IEFueSBpZGVhcz8gOikNCj4gPiANCj4gPiBUaGlzIHNlZW1z
IHRvIGJlIHJlbGF0ZWQgdG8gaXdsbWVpLCBzbyBJIGFkZGVkIEVtbWFudWVsIHRvIHRoZSB0aHJl
YWQuDQo+ID4gDQo+ID4gQWRkaXRpb25hbGx5LCBJJ20gbm90IHdvcmtpbmcgd2l0aCBJbnRlbCdz
IFdpRmkgYW55IG1vcmUsIHNvIEkgYWxzbw0KPiA+IENDZWQgR3JlZ29yeSwgd2hvIGlzIHRoZSBu
ZXcgaXdsd2lmaSBtYWludGFpbmVyLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZm9yd2FyZCEgSG93
IGFib3V0IHVwZGF0aW5nIE1BSU5UQUlORVJTIHRvIHJlZmxlY3QgdGhpcz8gOikNCg0KSXQncyBh
bHJlYWR5IG9uIGl0cyB3YXk6DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIyMDQxMjE5MDE0MS40NTQzLTEtZ3JlZ29yeS5ncmVl
bm1hbkBpbnRlbC5jb20vDQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
