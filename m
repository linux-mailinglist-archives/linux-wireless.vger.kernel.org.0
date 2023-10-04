Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2067B790C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJDHvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjJDHvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 03:51:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15250A7
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696405867; x=1727941867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kTN7fUgAsNvoMidGBjqjI4qDANzjklbJ/fubt7x/Kuo=;
  b=N0TUhWYIiQ2YAWaQs/edLcFQJLzkG14xVLO7bWOkSXHvS/tg6bUN2c7+
   yyWKkxjxLPlfYgQm/Eq/UDvh2Yqc0dpMbw5qMCgoqf1KA9A+yMJQh7l9D
   FQwr5uSsOzBt+0j4eX4DgWWtaV95Cojg5Z2qcZBx1tTaX96zm7AUAEBwL
   KmpHWUfxLjrPAMpGcKd1sHhek5f3/q6pPX3pyyj4PtjgsSU4OG1/O1/95
   T+y2xvfkuJD+4NnOIhnX8QwH1jOkwN/hFovStOvsdUaarHC+7tirfTSo+
   CApbHT1q1/yfkYH6rmPQI616auzrUPNm9vKJnQhDMl+jwUf3EDN/w4rFs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386958762"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="386958762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841715820"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="841715820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 00:51:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 00:51:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 00:51:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 00:51:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 00:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC1i59W1nUkuk7Gb9boWWba20gBPJKaneuZtamhsiZq75Ybl87Coi3EAV6DmsxB+skdIRUPDohL8FHbG7N4x1wySoCb9lqiaCh/tDAVUBaBjqxzIRWJmhdRUbtdj/RZOhkCrRY1dot+SgejCmCjXb1ePV2XsTYZbDBdsXcSKl6iu15h6YJGybdP6lrmsJpwQ/zKn0exit0O43LXHfYr1mErwxDMjBbvqjUKEyc5/LMBvb2qlC/LRI7wBK+0vqSPWQfH8+e2OVy1BcQvYfLP4nbiHWlUuYK8AIH1sy57Khs0BzrB2ujb7kqKrLI0/0/INy/OZowdxxNINzcxhfZRR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTN7fUgAsNvoMidGBjqjI4qDANzjklbJ/fubt7x/Kuo=;
 b=VxbFutiG3em/Pxm+VP6wDLiM9bCvB4Jrobi9SXZK5uAzpjWs2dmDbFfgG7/QOQ9M3PFf1ttL30sd3hqofQH75D8IJsoh4U3NE9ZyAv4iKsuCC2oFoHwND6XO/o851IL5B1b2ExBdKQZ1KYz9hNq2cLznNcRfkKOYTT9y5RpGkAC456YymDJpm93q+Q0aqmcgdmZ9l43GBJYqWKPRK0SXkLiHxVBZo2wDi/toy77XWvXNCRVh6gxD7Kiq9CuMN8HSDYe/zhcocj3eU9kkvHAHNa+OklpIKRTzcrDaUEXntL6/OChcJvKdTid6HENhhZDAiuKPTMxkQxPqflOwZbUzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 07:51:03 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 07:51:03 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>,
        "anarcat@debian.org" <anarcat@debian.org>
Subject: Re: Microcode SW error since Linux 6.5
Thread-Topic: Microcode SW error since Linux 6.5
Thread-Index: AQHZ7LCU6xPqhW7gDU22eTXtJkWaybAlqn2AgAUwOYCAADfTgIAA01UAgAAGxwCADBobgIABTuWA
Date:   Wed, 4 Oct 2023 07:51:02 +0000
Message-ID: <42e000913e3af714c77fb7a55dd898733e271be0.camel@intel.com>
References: <87ttrncuc8.fsf@angela.anarc.at>
         <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
         <87jzsf9dme.fsf@angela.anarc.at>
         <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
         <8734z29jx7.fsf@angela.anarc.at>
         <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
         <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
In-Reply-To: <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DS0PR11MB7532:EE_
x-ms-office365-filtering-correlation-id: 4be0237a-bc26-426b-c2e3-08dbc4aea837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLxYFfyQT9QAJ5U0hIhwGG1FmVKSltBmKn7EZzH2GGyPXSqNGBSSIyzbEIhyHWPT87VZgTR9pyoFUs2GsXq63AD0feRqDVn9ct30vIjA2U53ouqAE+bWPvjokYRbShcQL4IV90jleCqRLiWDPMYX/IIXmm3BO/Imefkh+G67eeS9XrwhJXUY9yrr8BXDRGw4HSTvjRIio/013sPg83vUecuk7CAdxEkvIRC0BdeWYOirReTidJDQRyE5rXplulC5C2GCauz40Jp1BkrENEeZaaqFzNxhN/VRtEBnZLvvBQFzDzQlY78vsyIt+/ECq4kReX3+6ZlIxQmKVSPAJNRuTC6rkio7sL1P1tmn/de6sFm6DB6kMKXiLDWLCpLwPwPh2TcIxIwp26TCWWRrAWA5TDSJl5xZ+pqieEtsPJJHvT8kYBOM8TMs8SaZPy5xgItbLUULPilR4MaSlAJVBn3wb/U7EE9Nyul0ZjbAclOE/RVdnElS2hLEJztbMuPPTZBNQj2TKY8m4DYbESXrBsmEC4Tv8NnbAQAFk/DSVwomdomqPQdhZUZ/eF4/wPmRupEHvY7rANCyfR2kebKjAgUvXPyf48J57lqBk61Cd1HjnV52Alr+cTDmoMS0EXMrn5caHri0v1qqyiyj5o5/K9t8ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66446008)(64756008)(54906003)(66556008)(66476007)(66946007)(316002)(41300700001)(76116006)(53546011)(2616005)(6512007)(26005)(36756003)(71200400001)(6506007)(478600001)(6486002)(966005)(38070700005)(38100700002)(122000001)(82960400001)(86362001)(83380400001)(110136005)(91956017)(2906002)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkNSWEo3S3h4ZVhyNFNGK3g2S0VaWjZXUkZuaXRwZnY3R1lPdGdCRkxSNk5D?=
 =?utf-8?B?RXM3MEtwN3M0b2xHU1p2TFlndEZKTkNicGtESXptYVVkMVl3dkoyR2RwUzdL?=
 =?utf-8?B?SXJXSzY0bVRIcnRvS0w5QTFNVzJSOWFlRFVMT05SR0RVR1B6aGlYVGkva0Fo?=
 =?utf-8?B?NmtVdTZ0M3doQUF1ZFpKNVRtRnRwOW1BaVhERDNhVzZESHVsQjE1S1l1T1ZK?=
 =?utf-8?B?c3BtYUxHSFRwaWxaUC8xV1lBbDQwbCtqQmI1NUZ3aHBzVUxhVGF2U1NuNWhQ?=
 =?utf-8?B?c1M0Z2xhc2p3eG05MStRSTQwVWxTSW92ZERNQzd5TVVZOEVWcWFRNTJxdGNy?=
 =?utf-8?B?VkVMRG5JMWl4QndjcEVEcFg1aHRZaWlTcm9kY3JraHF3c2hKVTlUaTZ5YTdC?=
 =?utf-8?B?RkNTTGNCMHQvbE0rUEQvNmlaSGV4bFpuRytGU2xxVlo0Kzg3ME5QK09LMEMv?=
 =?utf-8?B?U3JQTkZiZ3dHcHEvbnhzY3RjeEt4ckxwTFpUaDBQeWM0LzhQbGo0VWg0WkZ1?=
 =?utf-8?B?R0FwY3VjTngvdThDalN5M1VnWFdpZ0FpNVJqNWYzVFJCTGZORkJLMjJub2xp?=
 =?utf-8?B?cXdlZmVEWkFVM0NOUXFpaTVSZHZvN0RaUEY0VWtFMWE2OTV4dElEWDlGbzJC?=
 =?utf-8?B?VlI3VEk3bDJCWDNvOW15Tlc4c2lQUE41a1ByYTY2N0RKZkVyRy9NQXljNVdq?=
 =?utf-8?B?QzJTTEExUzdZdkdhYi8zSjhsQ2p1aGtjYjlEQVdYOEY2cG8wMjJVVEpra2sx?=
 =?utf-8?B?dVZrSTZtbGRQMWs2eVA0VnNpZFlxUDliN2VheFFNbXJNMUVKSTVnUlFoME5n?=
 =?utf-8?B?YnlaOEVHeFkrQ2Z2LzdCbjJHcjNhMkp5MWtLWGpkVXc5emUxUDRjaGV0MUVr?=
 =?utf-8?B?MWlsMzhqREFRWFZJS2VueVRxdTlYNXVPMVREVDRLWlJZVGlOeE1hYVc2dHpO?=
 =?utf-8?B?MGRFSjhPN3RWc3pLcnNTZFdoR2l6NjBCQjRXbUNWUDBOWHNnUTQxcHNzdGx6?=
 =?utf-8?B?NHFFeDhXdU8wcmRIYWZWVzNHQ1grbTZlcVhYOGt2bHZSS291VGRHMTVQcUdS?=
 =?utf-8?B?dmg5c2hXeEY5WFMzeVF2WGVqL3RpOThpd2V1ODJGOWJSU3RWdXVEQTJRM2pE?=
 =?utf-8?B?S1phM1BtN1pmd2JkcUI0TDNQVFo1aXR4TzNHTW8yWW9WcXZHU1I2T2pIT1Nn?=
 =?utf-8?B?enFOaEJmVmxkUGR1dnBWT2N5ekp1Zlp3MjRvMzdhaVZ0NFRrUTArVW9CeWFS?=
 =?utf-8?B?K0l0djVIZ0NrL2ViOWtrYlNZWE1LVDdsSGRUSXp6MUR0cVRZUUg4ZnFUbXkr?=
 =?utf-8?B?Sk1RQU5FWU1DM0c0aE9Wbk92djNUdmErZVdmUUE1eFdqaG5xdlFyR0QxdUxq?=
 =?utf-8?B?bEhob3BPeEdudENjSFM3dkJvdktJSjIxZ2t2dm16Q1BqRCt4NkFUT2d3TUdF?=
 =?utf-8?B?MUhZWXBzenpNVTBQZFI1TXJUZCszTm9rTkZBRjlkMXp1VGkwVDBQWVJWQmRE?=
 =?utf-8?B?RzN2a3A3V0FweEwwQ01HOURESEpuSnB1TVJtTEJ3ZmJ6UFBTRHhKalI4b0Na?=
 =?utf-8?B?YnMwTEd5ZEdpdTg1SDJydEluNEFuSW9TWVVZT1JDNmk2QW9HR2JKcTJjSFF2?=
 =?utf-8?B?VTdNeUFuaXE0anVnWEZwSHFWM3kxUFMvVWN5K0s3SnNIdXo3UDQ2VlBHNk1x?=
 =?utf-8?B?M0RFL3dqaW8yVGZlR2tTSDRraVlXaEp0bHBTczNoOUlmUkdGc0I5cnhIMWN4?=
 =?utf-8?B?RnFJVDExdWVVVmwycjVic3dYamdna2RZUExYQmdLMkF0SmdTcytVdU1JNWd4?=
 =?utf-8?B?RzdFWFR1N1pnTkFoSEh4NUtVb2FqVmx1c0VWMWNMbVBoS2p5bWlSemFJSnpp?=
 =?utf-8?B?TEx4U3hGZTJuaGtSMTlBb2RJNU1JSnVJZ1h1c3p3eFdKa0FLMXBuNzRpejU2?=
 =?utf-8?B?YVROcE1tTnhlT2ZRQjBzK2Z5N2MxL2JxaUV5aUkvNHFwNFBCN0N5WitWbnc3?=
 =?utf-8?B?QTJPY1NiakdpU3V2K1ZvQUo3RkRRY0dhMFcvaE1vQ0FYc2FmUC9QVWEzVlRn?=
 =?utf-8?B?RVNqRk9tMk5yVitiSnB3YWRuWkE5ZlBpRGVRRjVpZkZGdEV6dnczQldHenZE?=
 =?utf-8?B?UC92K3luaVRsS0t2R0NwamdJTWJKNzZvRlFSVUFKTStoK0MybFFZdUN2RFFS?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9643921AD0808644A9B618D516A45A20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be0237a-bc26-426b-c2e3-08dbc4aea837
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 07:51:02.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+W9D1aFkxZinKSPRRrDcz+iw1eerhT5GJjZQOip7L42KEjbS6T/cTo3VAe5KWAdJs6ZZu+lg6AlwQHab9sTgJ/ZEdGzpjojDN4h65K9b+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgMjAyMy0xMC0wMyBhdCAxMzo1MiArMDIwMCwgTGludXggcmVncmVzc2lv
biB0cmFja2luZyAoVGhvcnN0ZW4gTGVlbWh1aXMpIHdyb3RlOg0KPiBbQ0NpbmcgdGhlIHJlZ3Jl
c3Npb25zIGxpc3RdDQo+IA0KPiBPbiAyNS4wOS4yMyAyMTowMywgSm9oYW5uZXMgQmVyZyB3cm90
ZToNCj4gPiBPbiBNb24sIDIwMjMtMDktMjUgYXQgMTQ6MzkgLTA0MDAsIEFudG9pbmUgQmVhdXBy
w6kgd3JvdGU6DQo+ID4gPiA+IERpZCB0aGF0IHBhdGNoIGhlbHA/DQo+ID4gPiANCj4gPiA+IEkg
aGF2ZW4ndCB0cmllZCwgdG8gYmUgaG9uZXN0LiBJdCdzIGJlZW4geWVhcnMgc2luY2UgSSBjb21w
aWxlZCBhDQo+ID4gPiBrZXJuZWwsIHNvIEkgaGF2ZW4ndCBhY3R1YWxseSBzZXJpb3VzbHkgY29u
c2lkZXJlZCBpdC4gQnV0IEkgY2FuDQo+ID4gPiBkZWZpbml0ZWx5IHB1dCB0aGF0IG9uIG15IGxp
c3QgaWYgaXQgd291bGQgYmUgdXNlZnVsIGZvciB5b3UhDQo+ID4gSGVoIG9rLiBXZWxsIHdlIGNh
biBhbHNvIHRyeSBpdCBJIGd1ZXNzLiBPciByZWFzb24gb3VyIHdheSB0aHJvdWdoIGl0LA0KPiA+
IGJ1dCBJJ20gcHJldHR5IHN1cmUgc29tZXRoaW5nIGxpa2UgdGhhdCBzaG91bGQgYmUgZG9uZSBo
ZXJlLg0KPiA+IA0KPiA+ID4gPiBZZXMsIHlvdSBjYW4gLi4uIGJ1dCBJIG1lYW4sIHdlIHN0aWxs
IGRvIHdhbnQgdG8gY29uc2lkZXIgdGhpcyBhIGJ1ZywgSQ0KPiA+ID4gPiB0aGluaywgc2luY2Ug
d2UgZXhwbGljaXRseSBidWlsdCB0aGUgdGhpbmcgdG8gbG9hZCB0aGUgb2xkZXIgZmlybXdhcmUu
DQo+ID4gPiA+IEl0IGp1c3QgZ2V0cyBfZmFyXyBsZXNzIHRlc3RpbmcuDQo+ID4gPiANCj4gPiA+
IEdvdCBpdCwgaGFwcHkgdG8gcGxheSBndWluZWEgcGlnIGEgbGl0dGxlIGZ1cnRoZXIgaWYgdGhh
dCdzIHVzZWZ1bC4NCj4gPiBXZWxsIHlvdSBtaWdodCB3YW50IHRvIGdvIGZvciB0aGUgZXh0cmEg
c3RhYmlsaXR5IGluc3RlYWQgOi0pIEknbSBraW5kDQo+ID4gb2YgdGhpbmtpbmcgYWxvbmcgdGhl
IGxpbmVzIG9mICJpZiB5b3UgY2FuIGRvd25sb2FkIHRoZSBuZXh0IHdpZmkNCj4gPiBmaXJtd2Fy
ZSB3aXRoIHRoZSBjdXJyZW50IG9uZSwgdGhhdCdzIHByb2JhYmx5IGdvb2QgZW5vdWdoIi4gOikN
Cj4gDQo+IFdlbGwsIHRoYXQncyBub3QgaG93IExpbnVzIHdhbnRzIHRoaW5ncyB0byBiZSwgYXMg
ZHVlIHRvIHRoaXMgIm5vDQo+IHJlZ3Jlc3Npb24iIHJ1bGUgdGhpbmdzIHNob3VsZCBjb250aW51
ZSB0byB3b3JrIGlmIHBlb3BsZSB1cGRhdGUgdGhlDQo+IGtlcm5lbCB3aXRob3V0IHVwZGF0aW5n
IGxpbnV4LWZpcm13YXJlIChhcyBhbHNvIGV4cGxhaW5lZCBpbg0KPiBEb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvZmlybXdhcmUvZmlybXdhcmUtdXNhZ2UtZ3VpZGVsaW5lcy5yc3QpLg0KPiANCj4g
VGhhdCdzIHdoYXQgSSB0aG91Z2ggd2hlbiBJIHNhdyB0aGF0IG1lc3NhZ2UgaW5pdGlhbGx5LCBi
dXQgSSB0aG91Z2h0Og0KPiB3ZWxsLCBub3Qgd29ydGggYSBjb21tZW50LCB0aGUgcmVwb3J0ZXIg
YXBwYXJlbnRseSBkb2Vzbid0IG1pbmQgdGhhdA0KPiBtdWNoLiBCdXQgc2luY2UgdGhlbiBJIHNh
dyBtb3JlIGFuZCBtb3JlIHJlcG9ydHMgdGhhdCBsb29rZWQgcmVsYXRlZCB0bw0KPiBteSB1bnRy
YWluZWQgZXllcyAoYW5kIHRodXMgbWlnaHQgbm90IGJlIHJlbGF0ZWQgYXQgYWxsISkuDQo+IA0K
PiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzg5NA0KPiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzg5NCNjNsKgKHNh
bWUgdGlja2V0KQ0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTIxNzk2Mw0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZjY0NDg3MTktMTRlMi00OTYy
LWFjM2QtMWJlM2MxOTE1NmVkQGRvbGNlLWVuZXJneS5jb20vDQo+IA0KPiBHcmVnb3J5LCBKb2hh
bm5lcywgaXMgdGhlcmUgc29tZXRoaW5nIHdyb25nIGhlcmUgd2l0aCA2LjUueT8gSWYgeWVzOiBp
cw0KPiBhbnl0aGluZyBhbHJlYWR5IGJlZW4gZG9uZSB0byBpbXByb3ZlIHRoZSBzdGF0ZSBvZiB0
aGluZ3M/DQo+IA0KPiBDaWFvLCBUaG9yc3RlbiAod2VhcmluZyBoaXMgJ3RoZSBMaW51eCBrZXJu
ZWwncyByZWdyZXNzaW9uIHRyYWNrZXInIGhhdCkNCj4gLS0NCj4gRXZlcnl0aGluZyB5b3Ugd2Fu
bmEga25vdyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2luZzoNCj4gaHR0cHM6
Ly9saW51eC1yZWd0cmFja2luZy5sZWVtaHVpcy5pbmZvL2Fib3V0LyN0bGRyDQo+IElmIEkgZGlk
IHNvbWV0aGluZyBzdHVwaWQsIHBsZWFzZSB0ZWxsIG1lLCBhcyBleHBsYWluZWQgb24gdGhhdCBw
YWdlLg0KDQpUaGUgcGF0Y2ggaW4gWzFdIHNob3VsZCBzb2x2ZSB0aGUgaXNzdWUuIFRoZSBwcm9i
bGVtIHdhcyB0aGF0IHdyb25nIHZlcnNpb24NCm9mIEZpcm13YXJlIEFQSSB3YXMgdXNlZCBmb3Ig
c29tZSBvbGRlciB2ZXJzaW9ucy4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIzMDkyNjE2NTU0Ni4wODZlNjM1ZmJiZTYu
SWE2NjBmMzVjYTBiMTA3OWYyYzJlYTkyZmQ4ZDE0ZDgxMDFhODlkMDNAY2hhbmdlaWQvDQoNCg==
