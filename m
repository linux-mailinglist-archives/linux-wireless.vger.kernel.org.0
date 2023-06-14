Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED4730328
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbjFNPNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343623AbjFNPNe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 11:13:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4417A2128
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686755612; x=1718291612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EPJ6XPMIJlvIxHRHqPe2yu8oCBPceCD1hhL1Y8w5Xjk=;
  b=XFxuGviwUWkoWnp99E7922Y3ox7VM+gyb4ZVBqrEX5cuOT9b/KfBMpAx
   ZZK+nOCgBARENcL36Gc2jp+GByCwbDjYELJKoFS5FV6u4/BIUxFq8nkYl
   8DaUwQd28PFWeVUgGbY0U8mBixEaTCzaPAdIhE8t5lmn5lNy4G5zr9L/z
   vV4JvErTVpHHk4dSw/KnJ4u42ZKUpKc2EYZD4TuSIj5MJxC9cW87nBWpV
   E29BKlTjyAhj5ovQrZ+4FNmhCId9+mFxnqWfI7YKUHb/8z6KVufERQZTW
   3GlHqIzgciZB/Je2ESAX8agBDvKpLYIzePvxoqizPVitnYjtx4ycTeUya
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="348301469"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348301469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 08:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782123555"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="782123555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2023 08:13:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 08:13:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 08:13:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 08:13:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 08:13:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAwH5Gmj3uXXTBxWmXTLHoxAzNjgRbSba8gBthHqNNEDaW64+hKAUCa25MfE+bI+p3/gWaih8QopvdhdzEevaIZZoy7deoI7ybXMuR7cvZ3FAy2TTzvmvzPBfm/CF06mgt1ewA7JtbnwnjGtT0fjKoJG2l3AzNkcfDXAZobSXoDelOZeTr9zC81Hn7jM58giqAZdm1LvIOWL5HDh1RL0UtOc8NTAvfbm5CLuAC+TAHvEk3dr0qBf/NraMUKZ7NClypwzswchbqrCyAK9vTPuHnqHoZj0A0mcFAC0lJNFfzlD5UQ+8T6QEC4fbIuYmHzVkKk6u9VbeTgxtcMkvRZmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPJ6XPMIJlvIxHRHqPe2yu8oCBPceCD1hhL1Y8w5Xjk=;
 b=TxyxJYGQg/4Go0dB/qdlZ4SVpWmDE6Vz/SSWm3QrxkEVwXoaQGmggTjR4U/bVymgl6ttheJ6cbNOEOgp05U5jCWCleU11Oz+cF44m6X7J7v975looqrp15HzwyqtgFBru8hFRzDcJIa/7nY3RoOmhiUdukbxAQNlDUdRysSIUBcpzEeX4vXvZrK7SWmzqUmdGiZM0xpt3cnQ+I+DEi7N+gauNE0uDCxCPTgUW9RlSkrutQ+HBnAOhhEkyz6qM60rzDdzJJeRgOx+55RpNRYH/BThaCvGX+NeCD57LxQS+gDuyVp32Pjmf63eYm3X/AvMkODhqgVfPthS5QTYOYpH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:13:23 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 15:13:23 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: [PATCH 02/15] wifi: iwlwifi: mvm: debugfs: add entry for setting
 maximum TXOP time
Thread-Topic: [PATCH 02/15] wifi: iwlwifi: mvm: debugfs: add entry for setting
 maximum TXOP time
Thread-Index: AQHZnUXKblk2UFqlqkOrrSE7YLs+Ma+KFHwAgABWe4A=
Date:   Wed, 14 Jun 2023 15:13:23 +0000
Message-ID: <57efbc2793def49fd569a0bef6b6e7c30577f83c.camel@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
         <20230612184434.4ab332037a25.I57c33574a61edd68bd0ec1aa7009f31111fd7efe@changeid>
         <31903d55380fae200aad3626308e5b48f05dc14b.camel@sipsolutions.net>
In-Reply-To: <31903d55380fae200aad3626308e5b48f05dc14b.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DS0PR11MB6325:EE_
x-ms-office365-filtering-correlation-id: b9254b1b-4e7b-424b-48bc-08db6ce9e543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cWDKpEeJGomHcQ0CAPbyllJCFkG3adrFv1xufcL+KBw0J3P79xee1/l9w6XjGR9FTnBgCPa/MDu+gLLiBt6z7LZOlefmJqDFy288xgM4OAmYHqiKyEOZpXbk5Mt482ZHINGP2asuqVJdFt9K5bkgfIYlsbEwJumDU6m/XfsDxQX4aW4SYL7D/N5rz3Fw9USlq75gNN6OzaA2ioj10FITYhc+QDrcrRPwnyyD31rL5wes7Mzwsx19Omwd8be08USlhVnEidrRDamdLB2SiX/ikBC79wdbxrXWcTgWyu7NQR+3ClF1Wk0x+nx/gLgd9GX6Xp8/k+9IVgfW057UlBnuKON75gxCl5eONv1G3gE/qos5Onj+27FclZrk3GUaMyk+NGLkb+p71w5HdW7r33b4n1AqJ2R//xR7m+OibSbZzk2/kjQowYGTCW5xqEAczou7mPqB1uE5czGp7u/Y08oYk2vUw+QA233o2XIuRzMSb/kVHPrpuq1cdPhtqA7s22EbeEGkzYoIKXUFOQWobX9I9g56xrIf/3FrRdlEoHlqmBmXkpcH00KlI70OkcmWGWLivdxyT/negRCltFMpBwFzBeeUiwWc49vEKbzXSNeTzYo3+Shp/0h4/iFKdowrcKg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36756003)(2616005)(38070700005)(83380400001)(2906002)(86362001)(38100700002)(82960400001)(122000001)(8936002)(8676002)(41300700001)(107886003)(316002)(6486002)(5660300002)(478600001)(54906003)(76116006)(66946007)(91956017)(64756008)(66446008)(66476007)(66556008)(71200400001)(4326008)(6916009)(26005)(6506007)(6512007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckV0d3pMWENUQ2h2NlRpK2dEaVF3a0hSVElXNXAwZk1Fb290VXR3SXdud2k0?=
 =?utf-8?B?SkplT2srTkZNYXlVTERKNDY0UUF2dEhGTmg0ZjdBQWZIMTkrMldKNEpnZkt5?=
 =?utf-8?B?Vmhka20zSzFIMU94eTFNK2d3MGdEcmNhM3luUnhCZThhVlpnUUQ3c3N3OW5Y?=
 =?utf-8?B?RGl1N2tLS2RMWmh2U3Aza2g2dCs4cWlSaFdvdWZEMDI1elo3elBWWHpCTTAz?=
 =?utf-8?B?akFRTlNKenl3OUNuZzBBV3ZlQ2phOXpFajRBd1p6VHVwd1NuY202YWorNGVM?=
 =?utf-8?B?VkVhdVZnOUxub29kNWxnVHJSeFNHUFltOWI3V0xpcWU5SnpuNllETHVtbWJJ?=
 =?utf-8?B?SmVCWjVnWWNUaWVpNjdHcDlReUNFeXhEUkZrTDZsWlpveU94aXQzZyt2bWtr?=
 =?utf-8?B?TlBCYW9ZMm9zbFhYNldBMGZiR0s4VDgwVHFUa2NUN0JuM0NvTkEwSk1hcThq?=
 =?utf-8?B?elQ4UlFPNDE2cHN2Z2syM0hUa2d1dlo4NlZYM2M2THFxRVY3endvaW9WQkZV?=
 =?utf-8?B?M2lFWVBValIxcmx5V0ZEUmNqdTlwa0RveVh5QkNJSjlTZ09LM0RlQlBFdUJE?=
 =?utf-8?B?eWE4djhFZFVUSURpK0J0V2NSNllpYkVYTkNJSlY1QU5adnJwVXdRaVRDVEZG?=
 =?utf-8?B?MFNycHJldnlPcVFHU1o1cldUdDJuaUFIZ2RDK1A0NWdMSkhTVEZoL1FWWlVV?=
 =?utf-8?B?MkFTQWNoZzdObE1RY2g1OS92cGF6Z2kyZ2xOWXA2K2FlTWJldnVZOWVVQ0Nw?=
 =?utf-8?B?V1JaZ0pJVDM4azdzY3g0enJZVzRCSzUwcnJqR2NBNzhlWkJwMUZ3RDFLdXVB?=
 =?utf-8?B?OTRDOW91K21tNzlDemoxS3NVMlhraUQxSDZJUG9BY3BrQnVJaVppZ2IzV0ow?=
 =?utf-8?B?MWk2d0ZqL0ppOGljRnlPM3pKMmUzTmZDUzBqYXhTMklIL0lWS2l2R3Z0d09N?=
 =?utf-8?B?enQ1elVXdmpYRjlCV0U5Z2NyeW0vQXAxSTRwQWExWW1wc2FxaG9FRi9pWml4?=
 =?utf-8?B?eFc1RjhGb2VKamIxZ3lSMGpobmZBY054TGx4TlNRTng5RlVVSG1ndVh0VnVS?=
 =?utf-8?B?dmxWbmRmSXN5ZnVENHdLa0VDUnVreWNWVzFHTmZTNVhTTm80cUREYnJNSlFz?=
 =?utf-8?B?SWtnQ09HQ0ZKS3VnT2NFYzQwTEJWdnVlRTZKK0FwQUdWWDdGT2V1MjlnNTkv?=
 =?utf-8?B?N2NnbHpmK016THVCQUZTRlp0ZGJpTXBFUjJqdWZmUlNBQ01VTEx5bEo3T3dP?=
 =?utf-8?B?RE10TWdIYzRsNm9ESlZOVEN5WWhBd3JydEFHenZjbCtHRlNZdWdHdkJoRFN0?=
 =?utf-8?B?dGdidEwzWTk5UTdXK3hvcElSQ3QyYWlyc2hsaEV4N1YvMkRXU3VYYlVaYkpn?=
 =?utf-8?B?Ykd1cWdoOURCcy84VzUvS3JDUnRVZXVkbXN2cW1xaC9SOG9Ra0tHeFpPeVg4?=
 =?utf-8?B?cXNBWmJDdTIrbnZ6ZUNCQitxN2ZUd1BsTE5vSDN1Z01MSSt5MTI4Um44WlZz?=
 =?utf-8?B?UTJkalRRUTFzdkJYMzBVdnpMaXMvWmRhWnlRaU9Bd0RhbE93WS9EWUh6NFlB?=
 =?utf-8?B?aURxZVc0MlE4ZUZUQ3hVaHR5eHVaVzZLUmxsVVRYMDZEWkJkMHBZdG1ualZh?=
 =?utf-8?B?SEFmS0NxQmFzQlB2Z2d0ajRIZ2tNaERDaGtHaVFaU1ovVnVncS9TeEZzUjdZ?=
 =?utf-8?B?eDF4WVBlUnZtdTdQOS96NjZxSFRiaGIvNUIzYks2SW1YRnRreVNWRkplaEwx?=
 =?utf-8?B?N3Z3dmNPa1Jhc1JuSmE4ZmY3WDVJTXlpeGNRa0hpMldHL2ZjaEowWmpCTmtq?=
 =?utf-8?B?U0dzYUNDbjZhRlp2K0l3UnBjR1pQRkJ4dmg5MytwUkFWQzMzT0Y5cEd4WjFx?=
 =?utf-8?B?a1dZM2xVQ3RwN3Z6N01TSysxdnIzRTFvdlEyOTFoL0cvd0RkeCtSckFyNVY5?=
 =?utf-8?B?UjY0dXNCN2M5NDA3STVvU2trRmFUK1hBMkhkaE01TmV0U2J3ZHpkcmluU2RB?=
 =?utf-8?B?K3NscVlUT1NUUHZhemwrK2VNeUJlM25SMTdKQmxVSTNPTjlsNUZVZWpxRFRK?=
 =?utf-8?B?LzJ1Q3lUM0xvTkpuL0J0Ym5zTlgvTHg0QTJZdzlEQ0dpRmtrYVBGeUhyK3c5?=
 =?utf-8?B?cjRYSXhuZDRMNXY4UTVKaHJ1bTdVVGV1QUJnN3d3bmFxNTBaSXVNTjRMc05V?=
 =?utf-8?Q?zh/VwtSgKP8rPvrb8kYpsC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3716A46DD0342A4586B90663639CD6D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9254b1b-4e7b-424b-48bc-08db6ce9e543
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 15:13:23.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+igYnnkk4kAvkiKSJUFsJL+4rT6aeAPAy01llvXizL7pCu+UPc9PJT4IGu/VAPCNcW6Y1mDbq2zoa2LW9l1S5zoklVnGpTu1LVfO7Y/MMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
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

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEyOjAzICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjMtMDYtMTIgYXQgMTg6NTEgKzAzMDAsIGdyZWdvcnkuZ3JlZW5tYW5AaW50
ZWwuY29twqB3cm90ZToNCj4gPiBGcm9tOiBBdnJhaGFtIFN0ZXJuIDxhdnJhaGFtLnN0ZXJuQGlu
dGVsLmNvbT4NCj4gPiANCj4gPiBBZGQgYW4gZW50cnkgZm9yIHNldHRpbmcgdGhlIG1heGltdW0g
VFhPUCB0aW1lIGluIG1pY3Jvc2Vjb25kcy4NCj4gPiBUaGUgY29uZmlndXJlZCB2YWx1ZSBjYW4g
YmUgcmVhZCBmcm9tIHRoZSBzYW1lIGVudHJ5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2
cmFoYW0gU3Rlcm4gPGF2cmFoYW0uc3Rlcm5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEdyZWdvcnkgR3JlZW5tYW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+IMKgLi4uL3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2RlYnVnZnMtdmlmLmPCoCB8IDM4
ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL212bS5owqAgfMKgIDMgKysNCj4gPiDCoC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vcnMtZncuY8KgwqDCoCB8wqAgMyArKw0KPiA+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA0NCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2RlYnVnZnMtdmlmLmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9kZWJ1Z2ZzLXZpZi5jDQo+ID4gaW5kZXggMzYxM2IxZmRj
NWQ5Li43NjJiY2U3MGUyNjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vZGVidWdmcy12aWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2RlYnVnZnMtdmlmLmMNCj4gPiBAQCAtNjc5LDYgKzY3
OSw0MiBAQCBzdGF0aWMgc3NpemVfdCBpd2xfZGJnZnNfcXVvdGFfbWluX3JlYWQoc3RydWN0IGZp
bGUgKmZpbGUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzaW1wbGVfcmVhZF9mcm9tX2J1
ZmZlcih1c2VyX2J1ZiwgY291bnQsIHBwb3MsIGJ1ZiwgbGVuKTsNCj4gPiDCoH0NCj4gPiDCoA0K
PiA+ICtzdGF0aWMgc3NpemVfdCBpd2xfZGJnZnNfbWF4X3R4X29wX3dyaXRlKHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYsIGNoYXIgKmJ1ZiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNp
emVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3Ry
dWN0IGl3bF9tdm1fdmlmICptdm12aWYgPSBpd2xfbXZtX3ZpZl9mcm9tX21hYzgwMjExKHZpZik7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGl3bF9tdm0gKm12bSA9IG12bXZpZi0+bXZtOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoHUxNiB2YWx1ZTsNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBrc3RydG91MTYoYnVmLCAwLCAmdmFs
dWUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoG11dGV4
X2xvY2soJm12bS0+bXV0ZXgpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoG12bXZpZi0+bWF4X3R4X29w
ID0gdmFsdWU7DQo+ID4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsN
Cj4gDQo+IFRoaXMgaXMgYSBzdHJhbmdlIGRlYnVnZnMgZmlsZSwgaXQgb25seSB0YWtlcyBlZmZl
Y3QgdGhlIG5leHQgdGltZQ0KPiBpd2xfbXZtX3JzX2Z3X3JhdGVfaW5pdCgpIGlzIGNhbGxlZCwg
d2hpY2ggY2FuIGJlIGtpbmQgb2YgcmFuZG9tPyBTZWVtcw0KPiBsaWtlIGl0IHNob3VsZCBmb3Jj
ZSBhIHJlaW5pdD8NCj4gDQo+IGpvaGFubmVzDQoNCllvdSdyZSByaWdodC4gV2UgbmVlZCB0byBh
ZGQgc29tZSBmaXhlcyB0byB0aGlzIGNvbW1pdC4NCkxldCdzIGRyb3AgaXQgbWVhbndoaWxlLCBJ
J2xsIHNlbmQgYSBuZXcgdmVyc2lvbiBsYXRlci4NCkkndmUgdmVyaWZpZWQgdGhhdCB0aGVyZSdy
ZSBubyBhbnkgY29uZmxpY3RzIHdpdGhvdXQgdGhpcyBwYXRjaC4NCg==
