Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DC6FA2B9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEHI7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHI7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:59:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD50423C
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683536352; x=1715072352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rQyg9HStrv70nE8RVbV73Maog9xlPGiwMnryxPXnKmw=;
  b=e3BoIZG29guHM3lpkhFZAtbPlN7i8ahWyTXd0X4Q1bVFEA4DEVec0S1x
   piuouhmx79gz2DaL9USjfMtoFlt05LoKpHeQiq44hOOwjH16GLuQ1JGlm
   eqz5YYkZ1SFjRizp8xWjj+Tw7SaRnNMnVEPGKBLO8gPqmMaf1FeDga3A+
   Y8yzUCgwzBJgZ4LBKab9qRvRWQzShqfHIylJuf9Nd6TyLmzpQq5TGaImn
   PiLI8ixND3Af4GgAcHdxfk8H7qDuKUhaSyo/83S+CoInPdQGswnwnpDkf
   fDjSWsFIjS7MhM2FYHBnkMSIRnv+wo8rMCg+MQ6jd+v+PvM4OnqkcS9HK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="334034601"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="334034601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="675976103"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="675976103"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2023 01:59:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 01:59:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 01:59:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 01:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkuXNSRqUHFPQeRzGj6ZqX4eL/MxlJpd6dDqGf+WDTp3lM+yPWZnRXjxiBaeynR26rdeVS+RbAmK+f3AK+P9gCW2266cZ+fJ+i6oMBso/D6R0PGaTCgFJL3e5Rd5Jr1DEd4QSn7dpgn2duCrstm/g4cJetgwq8Q7chaxbS9t2l/s/ABFDcb1SB59/h8uF2CLWcFrfKbAxaRjePcErg6EuEfs69SRdZibbrlvrHBAlI7hSKliXqsm2k0xBn+c+bdNYxNwQ8Y+04wZasJZzQxojfguq44y8gJpEYY/mu/28HKkqAUXFitTvo0TkZn9xsUC94ooCisOs6J96jLqRusT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQyg9HStrv70nE8RVbV73Maog9xlPGiwMnryxPXnKmw=;
 b=WY7hgfyBQ+mPir9BHU0mHL4YwFcYHjj8z3EZTx0EziMAt73u2uhEH0hySlZVFqTnA3p6FSavZVJWTYI7otvDRc9aRcoW+3zxV3d+F0Zx3HP0cNLLMhcJ0asomQI/hzo1AqlsoG17MAFgXa5KAyyVpph91RowmwIGzhaZOy86ug0I6DF+elmqRR+vDnqbS6Tt5nDvnFm2pW6e6Rbnq6+ESOEbZjPYD8SDaSsmAccL1grsO8ZKqP5GU1NGLiezh8y5ny6zhHVELmP5v6Fnrp6Cs/it4WFP0p9jlmxBkoyBzfZzTP5MpeigusLEHox+CeYq3BBlJEbvQowOgQaVV1yqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:59:08 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::590:168a:7eda:e545]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::590:168a:7eda:e545%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:59:08 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.4 2023-05-08
Thread-Topic: [PATCH 00/14] wifi: iwlwifi: updates intended for v6.4
 2023-05-08
Thread-Index: AQHZgYaSzMobn31SAUu7sFLQJC8mja9QE6IA
Date:   Mon, 8 May 2023 08:59:08 +0000
Message-ID: <2b976fc77d35f32139685541923f0af279e3ebce.camel@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB5412:EE_
x-ms-office365-filtering-correlation-id: 8a802ddd-e720-490b-2662-08db4fa27b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SaEy8UQhVdhPkIUNeWYgIIVq41P0xERGJD653VQUrkVub4HuoJzBxuLNw07Y0vnJnkRg0/EeTMAt4baqrN0nmpjjourDAK1/KG35GKsAbyIe6xaohCYP6vud0+jryNNQa1OriUI9in+Zqm7JSlO+TaU1ejkxm5Z7P2NKEvFmDZvUAB9w0v27J4oqYSRs7tsQ2VRF7/kMww2oIqmpMXEH/MpuTYp0Ir8M2a3J6qPeFph5F26CUK+u6MAz+y46juCoklstOKhIHPxEGY3YydK8M6OG5HiWLudw+tSCwMehdc82jZ2Liv8YS2fPJq/IRdh0ODqjRkiBVuX6fUudgZdktNaL0BCzbeAbFXoZttlCpSY3jO/IK5G9QosIN2/RuPPoLaYUii9OWckzyRh+SLnFYratROzWuzKsAOEQJsgR6wzXD6dC9ggqpZXpngRjNuDplTejTxh07klP4me80x0x7ci5kJ2FzMmQ164FvanSv6PweJudQKbV5cUQ6a1BiMcHRgQJ4nhtLVq9mAviWYEDyicwNfVrtDTqq8mRJwJMAiqs2boOpcTNrd8bADa4LLuFJtbc42TfAhvL1KQ0kA3xM2AN2f+khU6nS0qYx0qa45O8/ag6/Xfd5+qZ91O3bsL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6512007)(26005)(6506007)(6486002)(83380400001)(36756003)(2616005)(38100700002)(122000001)(86362001)(38070700005)(82960400001)(186003)(41300700001)(15650500001)(478600001)(2906002)(5660300002)(66476007)(66556008)(6916009)(4326008)(64756008)(66446008)(316002)(8936002)(8676002)(91956017)(76116006)(66946007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckM5ZEJVWGZFSTJwaTdFQTRCb0M0WkdtdkhtbExMVkcrdmY5MDRwclR3M1NE?=
 =?utf-8?B?WmNSMngrcWl5M0c3VEV1UGw1djdJeGlVMTNockN2OHR1dGQwTWkvdUdBYWxy?=
 =?utf-8?B?UG9wVnV3aktYRUdISUJ0VGEwcmNlVG0yUmg3VmJCdHpid1ZQZS9jYVBCRFYv?=
 =?utf-8?B?Z1dKRU4xSDNXeWtDOHFjb3pURy9MRU8xTmx1ckg0MVgrOVZpNGVmbUFyYnI2?=
 =?utf-8?B?STMxeEt0Qm9DUGx2YXZLNzlUTHVrS0cwSHh5YjQ1dTVWQUVqS2c0NmhycEdY?=
 =?utf-8?B?QU9RZVBRMnZsYlNtTWpRY3F0OTh2d0xCb2c2RkZyTHdrbGlCdFUrUlQwK2Z6?=
 =?utf-8?B?QzJKUUpTUmxoVHk3R0pjc3FMU1oyMFQ3UVNiL1dyblR1anN5aForQzA3WUFJ?=
 =?utf-8?B?TTZVRExtOTlLR3lrUVh1UkhwODZ4NkRGZjRxalBMdUNLY2UyazdHRHFIODI0?=
 =?utf-8?B?Y1RlVkNTQjVtMXBBVVQ4ekZPbkladVFxK0V3R29GL0MrcEVJajdzSEpaNW9u?=
 =?utf-8?B?VlNoMzFRVS80VCs3aHBLbENrcTBrQXdJWngwZFFvNldDY2dzcytFNy9LQWZJ?=
 =?utf-8?B?NFlETk9QVFZHaTQ2SU5nMnVPMGZHMk10WHhvVmZockV2Umo2eG45MDZ2TFRY?=
 =?utf-8?B?SUsvQ1Z3OGxpbnFvdGNqdUwya3FISFhYSkpLT0g5UmhJdVZiY01PdzFlMVp5?=
 =?utf-8?B?OXdsckNMbUszYytENmI1Z3VJRmRXSU9pUHZNQndoeTd0U0dDeE9Jd0hQYnBm?=
 =?utf-8?B?cU8vaEhmVHM3NjFzU0hxY1I0MXcyZENHNXJPVExwVFlUaDNkdjBEbk9lUklm?=
 =?utf-8?B?NHJvUzVjUmo0eE1MMURDUTVNakZacldnQ0ZMNjVGcWowSXVpQWp4TVQ1MlZi?=
 =?utf-8?B?aUJUUGRxWEZ5VWtTWExiMllDVURkdi9iaVlnSFRjU1hobVRGaGJ2citDNkla?=
 =?utf-8?B?QytTUXR3dzFxTGVRa2FiUnljNHJRczBBaXVYTzRkTGpnSGxDUXgyOGlTMXhX?=
 =?utf-8?B?SS9hMjNxdE5VcVlVTGNuaDZXRWUyTGxPbUNCODcrNEs3SUxiOWdFSG5Bc3BU?=
 =?utf-8?B?RUZEbXFjNjJoRVBPcEJhbWNLSUxpYW45MmliMTg5T292ZnIyM3dVVlF2cTZ1?=
 =?utf-8?B?UTdZbHFYV1RCRHJHOGJOZEZVSFJHYW5EZlB3WDVDU0tTN0lZL1VKYVBlOUh6?=
 =?utf-8?B?cUozVE96V3JmUXk4MmJEUlRZU3l0TU1CaExSWTBLRkpkTW0ybXpWWWhiT2VS?=
 =?utf-8?B?b29UNUlqODJtajB1VUQzRGtyaW9zYkphSEVxamk5OVNLVkMyVXZ3WldlbXll?=
 =?utf-8?B?Mzh2cnlMendrWUowN0JKWGY3S0FJd3hJT3ZvcmtGV1pQY3A4SnZ0ZXFJWFZR?=
 =?utf-8?B?eGxPdEtJSE1laWxLRFJSRkxydFkxVkNuZC93dzlWWGVKeGIyeEt6b0dHQXJP?=
 =?utf-8?B?bVcwN2NxaFl3d2Fici9XWUVZMFZzY0wzanJKR2FKcEtLeGNSMFZvRVRsV004?=
 =?utf-8?B?bmtmQXdMVGhQQVpyLzZhUHVsQW5oOXE2LysyVXpoRytROUR1dEREWW9XVmlH?=
 =?utf-8?B?aFdNVHBSV0tRMnhOSmpMdUFLYVBncDdJOTBhMkN2ZmREai8rbVFSaytZZmt0?=
 =?utf-8?B?TUVuWTArTWxIeEk4L3dralcvMXpPTTltNmplWDBvNDVYK3ZkaFUrM1BzZFpP?=
 =?utf-8?B?YzB5ZW4xYWR4NGh6dnN0TlcrdVdnVjFnbEd1QkdDYmZhVlo3NER2eCt3NDlw?=
 =?utf-8?B?VjRTOHRVbk9VcVNjYTJmY3pZOVVRN2FFZys1dWlhT3FucXlKY05hbDF4UmRF?=
 =?utf-8?B?MmhzZXVOQ2Nldm9lbGVPMytlZVd5ZVA2alJpaUVhRzl1S3AzZlB0V3NaVFYy?=
 =?utf-8?B?MmFuS3RpcytoWms5aVlNYWRuYk55SUlkVEpybGdQa3FaV2FMY0xzdkFzTTdz?=
 =?utf-8?B?WHQzSUczRUlWN29jY1A4UGhOS1lsYWFOQ1VlMlQvM21vV2dsdW9QOTkzSG9w?=
 =?utf-8?B?dURVNVRSUDJLRHdJN1QyUkJOWG9yb2trNGxXT2FHSk12aGFPMUdQdnBINzNj?=
 =?utf-8?B?SWVNUU5oeEZ6UTVLbVJFckVjSEpiYnVQT0ROREhXTFN6YkhpTHZoVngySWo4?=
 =?utf-8?B?VFV1clViSUs5UnNyVlJRYUpHZmdqaURJcWZZSkZJcksvSnRBUmdCcUcvYWE3?=
 =?utf-8?Q?7KNVl4+YAfXEVjTiFVxqG/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <745C3C410A5AE2468FD45FFDC47B204F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a802ddd-e720-490b-2662-08db4fa27b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:59:08.0279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJ7xhXS+H7ny95SJNP3wBV8X1ktT3acuVDTHnkmNJPnwHFmkb02lhnK2iXI7hNJVsTYtAJivrd/viMcfmxz2hFfKPWe3hP5eYnWK0/IIZJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTA4IGF0IDExOjI0ICswMzAwLCBncmVnb3J5LmdyZWVubWFuQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBp
bnRlbC5jb20+DQo+IA0KPiBIaSwNCj4gDQo+IEhlcmUncyB0aGUgZmlyc3Qgc2V0IG9mIHBhdGNo
ZXMgZm9yIHY2LjUNCj4gSXQgY29udGFpbnMgdGhlIGNvbnRpbnVhdGlvbiBvZiBNTE8gd29yayAo
bW9zdGx5IHNtYWxsIGZpeGVzDQo+IGFuZCBhZGp1c3RtZW50cykgYXMgd2VsbCBhcyBhIGZldyBv
dGhlciBzbWFsbCBjaGFuZ2VzLg0KPiANCj4gVGhhbmtzLA0KPiBHcmVnb3J5DQo+IA0KPiBBdnJh
aGFtIFN0ZXJuICgxKToNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBzdXBwb3J0IFBBU04gZm9y
IE1MTw0KPiANCj4gRW1tYW51ZWwgR3J1bWJhY2ggKDIpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBt
dm06IHVwZGF0ZSB0aGUgRlcgYXBpcyBmb3IgTElOSyBhbmQgTUFDIGNvbW1hbmRzDQo+IMKgIHdp
Zmk6IGl3bHdpZmk6IHBhc3MgdGhlIGVzcl90cmFuc2l0aW9uX3RpbWVvdXQgdG8gdGhlIGZpcm13
YXJlDQo+IA0KPiBHb2xhbiBCZW4gQW1pICgxKToNCj4gwqAgd2lmaTogaXdsd2lmaTogY2ZnOiBm
cmVlemUgMjI1MDAgZGV2aWNlcyBGVyBBUEkNCj4gDQo+IEdyZWdvcnkgR3JlZW5tYW4gKDEpOg0K
PiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IGFkanVzdCBjc2Egbm90aWZpY2F0aW9ucyBhbmQgY29t
bWFuZHMgdG8gTUxPDQo+IA0KPiBIYWltIERyZXlmdXNzICgxKToNCj4gwqAgd2lmaTogaXdsd2lm
aTogZG9uJ3Qgc2lsZW50bHkgaWdub3JlIG1pc3Npbmcgc3VzcGVuZCBvciByZXN1bWUgb3BzDQo+
IA0KPiBKb2hhbm5lcyBCZXJnICg2KToNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBtYWtlIGlu
dGVybmFsIGNhbGxiYWNrIHN0cnVjdHMgY29uc3QNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiBh
bHdheXMgZnJlZSBkdXBfZGF0YQ0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IGRpc3NvbHZlIGl3
bF9tdm1fbWFjX2FkZF9pbnRlcmZhY2VfY29tbW9uKCkNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZt
OiBkb24ndCBkb3VibGUtaW5pdCBzcGlubG9jaw0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IGZp
eCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBkZWFkbG9jaw0KPiDCoCB3aWZpOiBpd2x3aWZp
OiBtdm06IGZpeCBudW1iZXIgb2YgY29uY3VycmVudCBsaW5rIGNoZWNrcw0KPiANCj4gTWlyaSBL
b3JlbmJsaXQgKDEpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IE1ha2UgaXdsX212bV9kaXZl
cnNpdHlfaXRlcigpIE1MTyBhd2FyZQ0KPiANCj4gWWVkaWR5YSBCZW5zaGltb2wgKDEpOg0KPiDC
oCB3aWZpOiBpd2x3aWZpOiBtdm06IHVzZSBsaW5rIElEIGluIG1pc3NlZCBiZWFjb24gbm90aWZp
Y2F0aW9uDQo+IA0KPiDCoC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAu
Y8KgwqDCoCB8wqAgMjAgKy0tDQo+IMKgLi4uL3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBp
L21hYy1jZmcuaMKgwqAgfMKgIDU3ICsrKysrKy0tDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2Z3L2FwaS9tYWMuaMKgwqAgfMKgIDIyICsrKy0NCj4gwqAuLi4vbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmjCoMKgwqAgfMKgwqAgNCArLQ0KPiDCoGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmPCoMKgIHzCoMKgIDMgKw0KPiDC
oGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2xpbmsuYyB8wqAgMTggKyst
DQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jIHzCoCA5
NCArKysrKysrKystLS0tDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9t
YWM4MDIxMS5jIHwgMTIzICsrKysrKysrLS0tLS0tLS0tLQ0KPiDCoC4uLi9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vbWxkLWtleS5jwqAgfMKgIDI3ICsrLS0NCj4gwqAuLi4vbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1tYWMuY8KgIHzCoCAxMyArLQ0KPiDCoC4uLi93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjODAyMTEuYyB8wqAgMTUgKystDQo+IMKg
Li4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtc3RhLmPCoCB8wqAgMjIgKyst
LQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5owqAgfMKg
IDMxICsrKystDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcnht
cS5jIHzCoMKgIDIgKy0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9zdGEuY8KgIHzCoCA0NiArKysrKy0tDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vc3RhLmjCoCB8wqDCoCA5ICstDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS91dGlscy5jwqDCoMKgIHzCoCAyMCArLS0NCj4gwqAxNyBmaWxlcyBjaGFu
Z2VkLCAzNDIgaW5zZXJ0aW9ucygrKSwgMTg0IGRlbGV0aW9ucygtKQ0KPiANCg0KSSBoYWQgYSB0
eXBvIGluIHRoZSBzdWJqZWN0LCB1cGRhdGVzIGZvciB2Ni41IG9mIGNvdXJzZS4NCg==
