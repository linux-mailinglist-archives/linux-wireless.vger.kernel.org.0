Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623C72DA7A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjFMHLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjFMHLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 03:11:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50507C9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686640299; x=1718176299;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dYVA1IewGotkqgAo81oTkWzmNDPa4sgGWD9yjP6zOWk=;
  b=E64BnuFO34v1BZFkwrKD+miZA8taJzad2m1pdrgKAHU/Tr5mw+srDe+M
   t+H6KQEJ5sgLDPcnmKd6zna63bjWi5z54OagyhuoUE2T627USx59+xw7V
   Z5cvrTqcD8i8RzkSthCmuqnKLVKSkWp8WmDCZLdcyJ9gGVXq9YYmFr7Eq
   sTX48v8x/UqANYbSZkNFDrdVRIhsn2QdsSlHwLzzNXWzY18eNv5iDsc8N
   U8gbLv4Vg2vBb5fAWMipDRfWgsIiWYWlDcobbSWuoLKex1m+cG2lJGyuF
   MjtmVacQONenAKBY2jLUqlit6pPUbZvpOpaG9HiDkoz8quFNCLNbIxoqM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="424133860"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="424133860"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 00:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688915191"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688915191"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2023 00:11:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 00:11:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 00:11:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 00:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T631GWVn41cdCuQw2YxWjZV0hatLXhdHBORxtQVlOrmWu5UI5G2WVkLmKCbOqLt4Cu+buHtR4nXFRudJevo8Nkh5yfaNVz8+PgGIAnH/13KQxbXmDI8GgWCx1DeKWZT9NHhCH3C/2a58oi8H5rvIDUI3NPy02bgsvIkSQG45sRDNM+8s7CBTHozLVEtdd4wzeZPh2CTxZXO3iTSQ+QrOjb7wYhZq7xrFOB/fQneElF6rRdKmBKwNXh0bnFZEwZHCT0vtX0oEZCANrw2V6guiD3FgM+rkaFGj3HNTEpf0aJ51kSxMrJTROoXhVgspgkJ4KDEJdQWicX1JF40T7USlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYVA1IewGotkqgAo81oTkWzmNDPa4sgGWD9yjP6zOWk=;
 b=GNf+Fhjt1hBu988XmmGe0UQotqOZNvZEBNJsN3tsHAVNnSe02ieqCaf7ngYyYvS4+Os7Vtxgi92T5YqKjySxiIjKVdTlXxdaV+s3YseAMCexvQoRUVUZ2ppPKVUyeXwm59EofD3OVm4ceV/0SxwIm0U5qQJQxv6vS2v/Br7lVlNlbyHpXOS6PyX8jC3PqScJSel49/6t9bdSP+OOaJV2zSHkvXkdV7A2t5QqEC1eSltij2oGQcIhmAkGwxag2JG8Av1vk2gzE7vZBvYfhVVKnZABLpIVJR/nbjHp8f+DpcB7LvbogfYXCPhe3QiLp2hYUckNBtlIfkljK5EVwClHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:11:36 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 07:11:36 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "help.7ocym@8shield.net" <help.7ocym@8shield.net>
Subject: Re: iwlwifi hibernate fails (enter fails, leave wifi unusable on
 resume)
Thread-Topic: iwlwifi hibernate fails (enter fails, leave wifi unusable on
 resume)
Thread-Index: AQHZmtE4OX7bV+BQhEu8luQRdoxdMa+IVu8A
Date:   Tue, 13 Jun 2023 07:11:35 +0000
Message-ID: <a79b716fa8160d1e454c18f81a6f0f3663b12582.camel@intel.com>
References: <168631463735.7.5716753263775974607.139494583@8shield.net>
In-Reply-To: <168631463735.7.5716753263775974607.139494583@8shield.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|MN2PR11MB4536:EE_
x-ms-office365-filtering-correlation-id: 66f47529-7010-4f9d-aeff-08db6bdd6ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QScaAqyJMVktyNCqJ15NmXKMuB7GPTyuIdmYPaVZjyJKLwvCI9FhOw+edUAniIJoqzM6cxAAP8oamWPKVVoJxcEq6qM7cuYvsL8N6SDUD54YzP8523Si/xx1s0PxRuD6Q/Ir2qCScH1+eoqTPf62NZ71Eg08PHlhJ/VRqS3y/SQStfmGm/sN7a0uFjmmgJvgd+mekj3wAIwq0prW8hmmwewtt4fo7TROeXucIYjN41u5AZweMRp2aHX/P3R2hqqiaSM+lYgukuXttlvwd2q0+wQ70mdZoxIIACEYYxb9HA4K1K63UrCp9wIlDt1PPKyhE5SH2QbVc48Leozjse9mCJ8CxUe6xfMPpTnBLLKla8n+hcIvvUAL0PtCXrXxVaR3Sg86sSYuRJETKKZ9HsavzFiUjALszn6HmLVwhKF8y+vHDTUnlGioxKrzy60/+Rnip/JBwEF4UCSGQ0Dv4OSd1T5l6889btJKvJtQw8yl5dm9a5TMhQ69F1lQVr38xIg+9UBZXeA8TFeDzA41tpsGoJdv0aGrKiHa4uBDcrH0+TjlLVjBsHcm4smFqZ1oYoMoJpkNz8hW6Kck5PAnb3ILyojsw85cvtN3CRbNrSbCmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(91956017)(64756008)(66476007)(316002)(66446008)(41300700001)(76116006)(186003)(2906002)(110136005)(66556008)(66946007)(8676002)(8936002)(5660300002)(71200400001)(478600001)(966005)(6486002)(6512007)(6506007)(122000001)(26005)(83380400001)(36756003)(86362001)(38070700005)(82960400001)(2616005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWdDbkJxSVkydWtvQk5OMERtUlpab1NsL2R0OVlLMDZwQkFpWlF1NXhyQU1q?=
 =?utf-8?B?UGpPMi9ld2ZBTVJrRXE2SVpTRWJVWm90am1ET3FPdkczUDNUT2orOWhpVTRt?=
 =?utf-8?B?c2RHTzdveUJHYk1jNk9adUo1TElLUmFhbjc0dU0vVXAvY1RGNXBZSGpSQ3Qv?=
 =?utf-8?B?bXo5aVJ0MUQ0ZCsvT2J6aVpTYVRMWFlwellpdGdSSkF4a3pBWVdUcHE1OXM5?=
 =?utf-8?B?M0ljYnNkVXVqNWZmTTF5UG80YTRuT2ZRa0VWbFlpRC9RUGJhU3hib3Nhdk9W?=
 =?utf-8?B?RCtOYnZjVXVuWWxXcUNVSXp4bjRLa0ZCZ2V1aStCQ3VJcCtaVU5sSjlCa0cr?=
 =?utf-8?B?MjVzdmx5QkJqa3F6aEVJQjNKRHBrd2p5U0pEMjBJU05laGI0T0hDWlhVckln?=
 =?utf-8?B?VzRsUGExWG5EK3piaXhKazhEL3d5YVlSSlpGQWFUYjZOMVdsaTU5NnZUbTE5?=
 =?utf-8?B?b0R5cXZFQm8vS09ONUFlUXhJeFpiR0hEOVhDNFFLOGVDL2wvTWgxSUxuTXNV?=
 =?utf-8?B?ZytsODlNZUhuZ3EyVWFkMUIySis2NFdFeWZWQXQvMks5eTBPZUxEZnR3ZlAv?=
 =?utf-8?B?d09mMWllelh1Z3h1b1kzUTF2SmQrbUtDTVVUcXJmdDF6bVF6NkkrSDk0N1R0?=
 =?utf-8?B?ZnBUNkw1aEN0M2h5VnVZR2dKVzBVMWdRVmx1R3JuSTFPYzFNdUszRm1zVk1G?=
 =?utf-8?B?UFFkVFlwbjEvOURtbzB5M2c3SkIwSVo4NVFCT0g5KzAxRGswUm1EcXZQc1ls?=
 =?utf-8?B?WDBsWnhlOVZEQUVpNEdBeXExcnliamNJU3IybFYvVmJoT09sNDBLQjdFb1F1?=
 =?utf-8?B?bW5UTVltN25LbUk4clBUMXlWNTZKWlo3VUdzRHFhUDNPQkMrZi9OVDhKbWEy?=
 =?utf-8?B?YWVodWJrS2NSdGp3bHE4c1o1cnBPNFM3S3lTWk1zbUdWYlh4blpLUzFoSk53?=
 =?utf-8?B?d0VIcjYyOElieStRa3orR0RObFlLcmJReDAzalhCeExkQXRTZ1V4TEl5N0VQ?=
 =?utf-8?B?SFR6U2tLdWUyVFp0ZmQ1WGNJcXRMQTQ4U0Z4S3lPRCt5U1FvdmhkWnVMTmpO?=
 =?utf-8?B?dExtYzQ4emJFeWp2OWVsN2dnT3Jxb3QrbmVUcmNySGhhSzV2TTE0NFNuVm1V?=
 =?utf-8?B?ekpKb1hiTVFsZ2FkbGk0NUhnbVBuQkUrQUkrTHlsUHV5QW5hbC9veGsxVDhR?=
 =?utf-8?B?QnRraTRaV3BlNm90R3pDVFFadUxySHBybnozczloSFp2eHcvZjZxaHhrZ3JF?=
 =?utf-8?B?RmpCNWFncWEwWXZVSjRBZC8ydUhIYU5KZE9VeTJWSU02VVFIcVY3dVNSY2NB?=
 =?utf-8?B?ZmljSHFTR0o3VjdmSXZtWWR4WXlSVjlHc2xudDY1QW43Z2JpVFJPU2Vmc1BH?=
 =?utf-8?B?clViYlV6eVZTbkI3OFdxaGdocHRwM2VEOG9VSzc2d1FCZTV5Qk5BdktabnNi?=
 =?utf-8?B?OTU2aURsbXFDazIranNBNFEvSHVvTXkyTmVienlmdlExQ2JoK1FOODhMUFZ4?=
 =?utf-8?B?ak81NGdyYUQxd0d5RUowUUVBeVE1RUtQVWVBWE13YUdLZjZDcjh0LzJQa20v?=
 =?utf-8?B?MkpYN01RSStMTDVhZ0ZnUUlpaWlxM0lhV2VMNVB5QzBFNUxiRXlDQmx0WnJs?=
 =?utf-8?B?aGJJbVNQNExlT1k5V1JQNzBITVNLeXk3MlFkT2QzTUpIYVhKeG95T3JhQ25X?=
 =?utf-8?B?YlVYRURGb1lEOUN0dStoTE00U1ZNQmFCZVFZRy83Z2lRTG0yM09UZlR2Mk91?=
 =?utf-8?B?TlZxVmdnNURvKzRQQzZCUFFjbHJaWW5iYzM3UHdEVFVrYUdFTVl0TVUydFZS?=
 =?utf-8?B?T1c2OG9hTWFMV01kS1EwRDdjREdJTXUrWEJ3VjNpS3BQSkRVV3o0YnQrOUF5?=
 =?utf-8?B?bXMrbEtBanZCS3F3emMwNUZSOUNzWkw2bUxuZFpsVEJNWjkvblR5cXRyeGxT?=
 =?utf-8?B?eWRWTkd5Wm9XTnVaMnJkNjFtMmJLcG5iU2VMOUdUUEk1cTJHNjlFUUcxWnhl?=
 =?utf-8?B?bnFKNVlUWXZsOTVVY0g2b1FtKy9HSGY0TzhmOWdmRllMRENBc2xIUkVOYWRv?=
 =?utf-8?B?bXdVZHphVEpaZU1YWkREWk56VDlwWGd0ZHdYTHhzYksvOFIxYk5DOGpmV2dI?=
 =?utf-8?B?aTVHUkl4ZnNXUWNGMUN3c1JpbWJoM2ZPNm9NbVptMjFRbVF5UEpDTHBNa1Nv?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFEBB898DC8B7040BEF790C24249DEA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f47529-7010-4f9d-aeff-08db6bdd6ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:11:35.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXC0Zxn4i5rSve+ieiquAQskq6ty4kfColZnovFNyo+7aS7Dvgnzne1GTiMDYsSVw8FsnJ36tkIpPQ0B+aFvk8zp1L4vSVKahnFqkFVEdxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIEZyaSwgMjAyMy0wNi0wOSBhdCAxMjo0MyArMDAwMCwgaGVscC43b2N5bUA4c2hp
ZWxkLm5ldCB3cm90ZToNCj4gSGksDQo+IGl0J3MgbG9uZyB0aW1lIHRoYXQgSSBkaWRuJ3QgcGxh
eWVkIHdpdGggaGliZXJuYXRlLCBzbyBkb24ndCBrbm93IGlmIGl0J3MgYSBuZXcgb3Igb2xkIGlz
c3VlLg0KPiANCj4gbXkgaGFyZHdhcmUgOiBodHRwczovL3dpa2kuZ2VudG9vLm9yZy93aWtpL0xl
bm92b19Zb2dhXzkwMA0KPiBJIHVzZSB0aGUgcHJlLWJ1aWx0IGdlbnRvbyBsaW51eCBrZXJuZWws
DQo+IDYuMy42LWdlbnRvby1kaXN0ICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgTW9uIEp1bsKgIDUg
MTU6MTA6NTMgLTAwIDIwMjMgeDg2XzY0IEludGVsKFIpIENvcmUoVE0pIGk3LTY1MDBVIENQVSBA
IDIuNTBHSHogR2VudWluZUludGVsIEdOVS9MaW51eA0KPiANCj4gSSB3YW50ZWQgdG8gcmUtYWN0
aXZhdGUgaGliZXJuYXRlLCBldmVuIGlmIEkgbWFpbmx5IHVzZSBzdXNwZW5kIHRvIHJhbSB0aGF0
IGlzIHdvcmtpbmcgKGJ1dCB3aGVuIGJhdHRlcnkgcnVucyBvdXQgdGhlIHN5c3RlbSByZWJvb3Qs
IGFuZCBJIHdvdWxkIGxpa2UgdG8gaGF2ZSBpdCB0cnlpbmcgdG8gaGliZXJuYXRlIGluc3RlYWQp
IA0KPiANCj4gc28gdG8gdHJ5IGhpYmVybmF0ZSBJIGBlY2hvIGRpc2sgPiAvc3lzL3Bvd2VyL3N0
YXRlYA0KPiB0aGUgc3lzdGVtIGJlZ2luIGhpYmVybmF0aW9uLCB0aGVuIGdvIGJhY2sgdG8gbm9y
bWFsLCBhcHBhcnQgdGhlIHdpZmkgdGhhdCBkb24ndCB3b3JrICh0aGUgYWRhcHRlciBpcyBubyBt
b3JlIGxpc3RlZCkNCj4gDQo+IGhlcmUgaXMgYXR0YWNoZWQgYSBkbWVzZyB0aGF0IGNvbnRhaW5z
IGVycm9ycw0KPiBwbGVhc2UsIGxldCBtZSBrbm93IGlmIGl0J3MgYSBrbm93biBpc3N1ZSwgYW5k
IEkgd2lsbCBnbGFkbHkgaGVscCBpbnZlc3RpZ2F0aW5nLg0KPiANCj4gdGhhbmtzIGFuZCByZWdh
cmRzDQo+IEpMTQ0KPiANCj4gU2VudCB3aXRoIFByb3RvbiBNYWlsIHNlY3VyZSBlbWFpbC4NCg0K
RnJvbSB0aGUgbG9nIEkgc2VlIHRoYXQgdGhlIGRyaXZlciBsb3N0IGFjY2VzcyB0byB0aGUgZGV2
aWNlIG9uIHRoZSBQQ0llIGxldmVsLg0KQ2FuIHlvdSBwbGVhc2UgdHJ5IG91ciBiYWNrcG9ydCBk
cml2ZXIgZnJvbSBbMV0sIGl0J3Mgb3VyIGludGVybmFsIHRyZWUgd2l0aA0KYmFja3BvcnRzLiBX
ZSd2ZSBzZWVuIGEgZmV3IHN1Y2ggcHJvYmxlbXMgYW5kIHdlIGhhdmUgdGhlcmUgYSBmZXcgYXR0
ZW1wdHMNCnRvIG92ZXJjb21lIHRoaXMuIFRoZSBpbnN0cnVjdGlvbnMgb24gaG93IHRvIGJ1aWxk
IGl0IGNhbiBiZSBmb3VudCBhdCBbMl0sDQpwbGVhc2UgdXNlIG1hc3RlciBicmFuY2guDQoNClsx
XSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZp
L2JhY2twb3J0LWl3bHdpZmkuZ2l0DQpbMl0gaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5v
cmcvZW4vdXNlcnMvZHJpdmVycy9pd2x3aWZpL2NvcmVfcmVsZWFzZQ0KDQpUaGFua3MsDQpHcmVn
b3J5DQo=
