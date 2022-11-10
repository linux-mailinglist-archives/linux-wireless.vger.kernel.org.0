Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26AE624317
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKJNVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJNVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 08:21:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE26BDF3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668086474; x=1699622474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lNo5R52Z16E7eQ8G7Eg8WI/dD/JoNpnfJtvkB1v9H28=;
  b=LvoCWmgaP0ehwo0HU6BRay3odz1Aj9FVTJ774dm9ra4qhkEZFS9AaSk+
   UGAttXgf7STGO2jnlvFwwIz5aQ9aJzDSiuAJ44lZRglo8mj2Kxn2K7T8x
   IzlzlzFlEwMWAe/bmdxRrBx9C4RjfHyKxKceCCxj0hwi9TOaTqaFPOy2F
   2nBAemQQ5SLhRuPBA6jCVUJaIGZPAoNs0SWiujip4xkzDJqKRoTKX85Xx
   KOuZWMvlNvvYETqW087h3S1glBdFeowzQdp55uUgDSBCfHJ++/e2k8r2b
   0p3P3EcLgANKVGgck09r+9QyJgmLQEggcD2ZaAPxdWFvOYvqybojL3NOd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="375550788"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="375550788"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631652683"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="631652683"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2022 05:20:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 05:20:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 05:20:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 05:20:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 05:20:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzi/ys6rjVBYdVMYsQnjb3pXyx/agJmyrKztigzxJbIawF+6HXcKdhANeUcdUzdN+740MDKZulzIfxO3/VeWFUF/xVYyFvrAmR89iR4fFlLked+6hMI6ix2GoojGfaI0BUebyUVnU0Z3lT6j4kAcaRXAzVELAPFvp2WLVZ9sokaxXmGBGgCAjHra6dXIfRvvIWIZ4pKz7zKUayNQU8WXyvc/of0KhyF84FI1jRyhPTKtMPUof9qfc1fOmxRPjR3f8KzfLLUU1jpvKbOQmK1Hioe+ku/xX15ICj2eEbIjhbk1pOGxYczfEbtlSVCSW10MkcLdCCf0t6/r/al7l008Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNo5R52Z16E7eQ8G7Eg8WI/dD/JoNpnfJtvkB1v9H28=;
 b=eGv8r44pLhfFpYuGSk7NdnXSyCxp3y4OR12Pk64rlMpUNLQ4bjwE7nvqubX2khf2v0dMDnqe9VnHr7IQwncFAZ+5XYe4E0u4xmbXXCJS1sUY5sxzEx+XGOMhP18uDSWesEwvR5tJ79o2F65mn9p3dPckns7iJbawpg8LJPIjvXxzafjhMOnwGLYdcif2P5kKMoIbuBI+ChUlnNeVxRiOZZr5h/uEveGln6uAuwpca72pWSttb8Z14pJjXQf5fc+HQGIyAam9OBnWIqzqHfkgLewNvlne97fMEw7gAYWDn/fRNTuruXYZHkb85AwSPqdWkNJxgKQXjKyP1yY2cv5yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 13:20:48 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b%9]) with mapi id 15.20.5791.022; Thu, 10 Nov 2022
 13:20:47 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: iwlwifi-next-for-kalle-2022-11-06
Thread-Topic: pull-request: iwlwifi-next-for-kalle-2022-11-06
Thread-Index: AQHY8c8kWoJiM6QWfUCs6xB0aK3krK423K8kgAFOLYA=
Date:   Thu, 10 Nov 2022 13:20:47 +0000
Message-ID: <752e052b161628891957d33a98da3c49926b3ec8.camel@intel.com>
References: <141140c10cd372c03abccb0483548108de705565.camel@intel.com>
         <87sfisavp1.fsf@kernel.org>
In-Reply-To: <87sfisavp1.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA0PR11MB4559:EE_
x-ms-office365-filtering-correlation-id: 9b709574-ae85-4c35-fe88-08dac31e617d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/l3dEda8ZKwO1asqbRPkDst40jSPkaAzaKfXCpE21E+p9eejPWTjdtmmV1Ja1XfalJef3vgBRIslLeVsVtjl7FEZ86lHFSu07ueDKdx+KU5AGZHBaObJqB7ZtV3F0TrBK5cfLFlQYwwwKT5a/Gfiq0zp38a9t7ExyrgAV5GLgYGvZTia+hs6n9uLp8ujaHc6qSgjPeLHmxPodRMuJLE8LllMS20zR4KolSDMEKqckQpgS+9py9m+ACTya7SBM/J/+1aCfRRuJLUX6Ge72HrCxs2TYwuLfDnL+EnWWkbLXoDn2dBt2fo+bygSLVqhoZG7OV1hJBgKKooCXjI7A21vM1425ib7Uy+D5oa74xYeXAi7d5LNEtAiGDHDCMHl91nRczmrsq0JGaTi2WQfE84GBUlhs0pBqeUwhbWRZ5g9SIkTS5kMaS3c4zc4sn1qKa5LqqQB6kU4utS5ylKV6WDL1b51Dp8H0IvQd3kq7zv2/HCscvT+wblXPEc/yuoS5GCY1qKMMf5SY6DhYnhWFZcoz+mXg2W+OubbJvSRDW2qlbhOYXTGStQTTQl1YF+GN1zkgufEL9TdJc9pHHD88ozLsGFpsEzV2BM7PH7A9BltaYPCbDs+o5ltnvdwxNa2NgWJfkByngB8E++qq5Tj8K+DwLHp2s+bfc3I4/P7f5yZdVw6SeHYOX2yTPAv4MF/Z/X/+7xgpFW3OSK5LjwMpvOPCUhcXuxLBX0kx2KQMRiV4jg1PvP4eGsJVjeWBVbuBSXa8B8S+HmZThitEadAdIZdsrFF7ZpaGyG0emLUeuEYtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(2906002)(83380400001)(478600001)(2616005)(5660300002)(38100700002)(122000001)(82960400001)(186003)(8936002)(86362001)(66446008)(38070700005)(6506007)(6486002)(4326008)(6512007)(71200400001)(8676002)(66476007)(76116006)(66946007)(64756008)(66556008)(966005)(91956017)(26005)(316002)(6916009)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjVZeTB1cG1jek5BeG03eE5SY2dHbGtQY2NCTWJ1L3J1bEtQLzNwSVZpelRQ?=
 =?utf-8?B?ejhJUzlGWnVnTktKbXQrdXVaWXVxc2N4RzkyZHlCUXBnUXJFWWVTTFdjL1Yv?=
 =?utf-8?B?ZVFIM1ozNnE0WitRbVMvR3B0OFRqWHJXVFJsWDhDYjUrb1NFMFBoYmdhTlo3?=
 =?utf-8?B?bGpUaXpRWk5GM2VlL3Bta3Avd2pkVTZadTFoNnUxS28zc0JydGpncllkYWdI?=
 =?utf-8?B?SW5ZelhLYjU5WHo4NW9jSkNKZXViM1JnMXpjTXp1QkwwUCtEMUU4TVVNeDJ3?=
 =?utf-8?B?aGN1Y0JpNzQ1SmRKcXlMOTBHdkhJNDF3eGxxU0ZPQ2dwOWVYWFBJWVB0UVFV?=
 =?utf-8?B?cFNjNG1CcjZpSHpKR1Q3a1hBUWxWalpWeHZOckNJc0E1Q0pOdFdCbHhtSkdy?=
 =?utf-8?B?anJMcEl1eEltQXovU2tsOHZ4TVgvaDVVMWlKMGh1K0lycTk1WXBBR3E1bE8x?=
 =?utf-8?B?Q1ZMS2Q3UVpoK2tGbERuU1FjYzdwS3lyZ216VlpwREhWVWRUZ09mRHlQMkVo?=
 =?utf-8?B?K1k2YmhIRFZ2eDZPQ0QrRUpxdEFqNDlMNFN6dGJnQ0ZwbmtYVVB1QU94R0Fs?=
 =?utf-8?B?MzdTVVBidmlsMEkzQWJiSmh1bnpiVFYxK0FQUUQ3Y05ueEVEZUtSMTlnTGY2?=
 =?utf-8?B?VVVUYS9MS0xXWlp6ZHdSNjBFVEs5VlBHVGRVU0NyNEp0UGJRUkhNU3ZockJm?=
 =?utf-8?B?VCs5cVJ6UkZ6cGErL095N2V1RnU5Vi9DVHZ4a2duZzdpRys1Z0x0NGx3azF3?=
 =?utf-8?B?UDc0MUt3VnJ2MHI1aThTTlJiQ1ozVVRDUHlHSTlrbmtQWFVMbWsybDczSHJI?=
 =?utf-8?B?NUhlSHVxeUlIaHpjaXdnc2N6enorV0N4aDkydXFzcmtLeGpLVlE1bXJrblhk?=
 =?utf-8?B?eVZUMEp2OVdvOFNMTUUzNW9KWDRTVUN1MlFDRTZISjlTYTNpbTNWRG1TcEtq?=
 =?utf-8?B?MW55clJyUHZ5L3NIckNjQ0tnYVJ3MmY2NFVsOFVjWGlXYkY5Z3BtREh6aGwy?=
 =?utf-8?B?cmJJVjdNc0M3aFZkemhnTElkNEM3RFp4NlBSTG9OMjl3YWRnY1JXSTEzVDhp?=
 =?utf-8?B?TlBrRjlqTWg4RDB5Tld1bjdYam93ZXVzRGdLNGVpWE1FcDdxclZlTjloSitV?=
 =?utf-8?B?OWE0UWVrSEtON3JYTnpUWksxbEx5NHI0WGtMeTNrS1BlTUxVUlRibmRYMEtC?=
 =?utf-8?B?cHdubUUvMGZtOU1LeTd4NytpMnpQN09xc0V4SVI3YjJQNng0MHhNUFExNkxF?=
 =?utf-8?B?eGFnS3B6NWpwbGNxU2RQNVNTYUZKWG5BNHRKV1I5M01BRXYrUzJWakxvL3Qw?=
 =?utf-8?B?Y1UzOExNRjJNTUllZjRXQk0yUmpDcWVHYmZDbjBET1d4anB4dHdsM212RlBV?=
 =?utf-8?B?WW5GeWtvcWE2V0lPanBqV3BCV0R4Z0xOb3graGhVK1dZNDFtTm4wTTRCOEts?=
 =?utf-8?B?THhuV09lUW9adXV5blFVWjgwTUVCbmhLWkJxUmVUZlYwSzNZNWxITkhnYWYx?=
 =?utf-8?B?OEVFZEtVM3VLRTEyZWxKUmF4NHp3RU5jWnRWV2FzTVhJZ1pJMDlRQWdWQUFr?=
 =?utf-8?B?Z2ZNUE93OTYvNFVCNXlodUl6TG9UNjNKVW5VZzFBMkNGQTd2VGxTRWtTTnBr?=
 =?utf-8?B?OVE0dDRXS0tNYUp1Z2ttbTBpdmNDK1RZcWpDS1dvL1RjRDM5V2tmRXZMSGEr?=
 =?utf-8?B?RWVZV0k4c1JmdkMwQnRLcVdRVlgvNENUN1F4NTJoMkdDcHdIY2NWb3NtMnJU?=
 =?utf-8?B?WUo5bUpKUDZxbDVEVzNOaGc3dlVKTGd2VmZRODF4SmZBN3lNcnZvdlBROUll?=
 =?utf-8?B?KzN6bGtwSkZVRlNoVG5VL3hxOEsrYjd3QklYdlJHSVJZYXpWYTFOYXV4d09I?=
 =?utf-8?B?b0xVb3ROamlEYk8veVNKV3JjWEVtYmdNOUdLVnNXdHZRKzUzck1Eak1XRU43?=
 =?utf-8?B?S2taRjZsby92VmhtWVBBdHd1blI4SWdBY2RyeU5HbDRJajQ2Y3JLY3lzeHBu?=
 =?utf-8?B?eGNUeHdKaFlPTkorNnhaNEYzSXZtWGVjam9jSUpTWWpNQnlmODFkUzNrVzBC?=
 =?utf-8?B?blh0R0tYb3k1akpKR0R1b2xXcmNHUVl6Q0sycUk0OTlxa2lPbzEwMWY4NmZa?=
 =?utf-8?B?cUhFNnNGZzkxN3lCTlVJRzg2WUwxS0dlc2Y1Y1hBWHBUd1loZzdUQ3BQUm9K?=
 =?utf-8?Q?upngLwfkyxdhPaD0ApuDDMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A243960D44FC74C91B52E44428B2B78@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b709574-ae85-4c35-fe88-08dac31e617d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 13:20:47.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pybw23X3LU6nrm0dPQ65EK0a8WY1dIVvlGQI8xRYaRHayQXcWIKwpSzglVti0gshYtDf2hAsq9pF9Z43feu3MJ3PiTdnh5a/w0A0+UGbIjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTA5IGF0IDE5OjIzICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAi
R3JlZW5tYW4sIEdyZWdvcnkiIDxncmVnb3J5LmdyZWVubWFuQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBIZXJlJ3MgbXkgZmlyc3QgcHVsbCByZXF1ZXN0IGZvciB2Ni4yIHdpdGggdGhlIGxh
c3QgdHdvIHBhdGNoc2V0cyBJIHNlbnQuDQo+ID4gDQo+ID4gSXQgY29udGFpbnMgYnVnZml4ZXMg
KG1vc3RseSBtZWkpIGFuZCBjbGVhbnVwcy4gDQo+ID4gVGhlIHNlY29uZCBwYXRjaHNldCBkZXBl
bmRzIG9uIHRoZSBmaXJzdCBvbmUuDQo+ID4gDQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRo
ZXJlIGFyZSBhbnkgaXNzdWVzLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBHcmVnb3J5DQo+ID4g
DQo+ID4gDQo+ID4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZDk1NGE3ZTRh
YTA3Mzk2MzA4ODRmYzU3MmQyZDBlNGRjZDE2ZTI1Og0KPiA+IA0KPiA+IMKgIHdpZmk6IHJ0bDh4
eHh1OiBVc2UgZGV2XyogaW5zdGVhZCBvZiBwcl9pbmZvICgyMDIyLTExLTA0IDEzOjAxOjM1ICsw
MjAwKQ0KPiA+IA0KPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
PiA+IA0KPiA+IMKgIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0wqB0YWdzL2l3bHdpZmktbmV4dC1mb3Ita2FsbGUt
MjAyMi0xMS0wNg0KPiA+IA0KPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA2OGVm
YWRlOGVmNWMwNjU2Y2Y0MGQ1MTFkZmEzNjc2NzYyOTQxMTM4Og0KPiA+IA0KPiA+IMKgIHdpZmk6
IGl3bHdpZmk6IG1laTogd2FpdCBmb3IgdGhlIG1hYyB0byBzdG9wIG9uIHN1c3BlbmQgKDIwMjIt
MTEtMDYgMTI6MDI6NDAgKzAyMDApDQo+ID4gDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IGl3bHdpZmkgcGF0
Y2hlcyBmb3IgdjYuMg0KPiA+IA0KPiA+IFBhdGNoIHNldHMgMCBhbmQgMQ0KPiA+IA0KPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gDQo+IENvdWxkIHlvdSB3cml0ZSBhIHNob3J0IHN1bW1hcnkgYWJvdXQgd2hhdCB0
aGUgcHVsbCByZXF1ZXN0IGNvbnRhaW5zIHRvDQo+IHRoZSBzaWduZWQgdGFnPyBUaGF0J3Mgd2hh
dCBpcyBzdG9yZWQgdG8gZ2l0Lg0KPiANCj4gQWxzbyBJIHNlZSB5b3VyIFNpZ25lZC1vZmYtYnkg
dHdpY2UgaW4gY29tbWl0cy4NCj4gDQoNClllcywgc3VyZS4gSSdsbCBzZW5kIGEgcHVsbCByZXF1
ZXN0IHdpdGggdGhlIGZpeGVzLg0KDQo=
