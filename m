Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97F645E2A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLGPz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLGPzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 10:55:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB714D0C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670428518; x=1701964518;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=SQGVH63e6IIU66f2RLXW7X365l3LjnMgeCXYdzfrCbA=;
  b=C/G22OTZlUUbGRHCwTK8eh19qfcofNRqCYq2fgWwLzYfCbN/SoMgHZq6
   Y/dAwWa1yJH7jbbSFruGvkpaOwP/mbXEX9XpIRxKNdCjugbdypmNFHhEZ
   f2/u0G81K17lx9kv7p0xod3z/HCr0k3XvPbf6ukc93+lBx+vkkRmX2Fiy
   i89LBSAooYt/zTo0E7cgZbpXKcvJihS22TUGWiXStUhuju6h4xI2uaInc
   FIaAZ5fyKjIYohrFtomlt7w4NDK4C15Kub4Mj12c+IyYKLlZM+va932vU
   9d8Twn88kN0TkaaMwbffXvzlAbBjPnHyGDRHb8c3/busms5bfD8x7ftdZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="300342496"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="300342496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710109003"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710109003"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 07:55:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 07:55:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 07:55:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 07:55:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3EtJ75WdlV+UTfibQ1I/Rh2GKPfwPp6xYgmPu86bpIIJYlxL/oY9rtYoLWOHT1ZHU49ETKeXS7nkoUEmr3aaAZ8RkkCnTVohOQ6UQoCaZ4JRnFw3FBIFOPwDwKLLTrxW7IkIBkBv3UnPEbkOmWc/adlbRBvFKtZvnabRPQyCsggl0Rhkq/DFn93wDGF29t6Bzaeb01P74IV2joRSKYiUhFsTtiF9ZWQLZLdsPvB9tbyi7iO2kx3sNSyB6v9Np/peP42hNM3PDNwjTcO46f+G68/t1eABVIaYUZDOAe8ltzFez/85bBoH69K2eRhUOCm8TcksNIgkLfDoBOL0AWSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQGVH63e6IIU66f2RLXW7X365l3LjnMgeCXYdzfrCbA=;
 b=TDQk4d6d1wwuzcKgAUSlDJ1zkKxvArr1gKybrqRREv9MCNfEFhDSalWXc+nDHX+W6pNQCrjsKsSxy3Sv5surx+3I2RxkO3I3CaBjpylzKlJL6VibW6RVU+a2UK3f1owuFZIjKWFYDXA+uLSVoguob+QQZOCL1aVw78g/CV/8edEqM96xYHfQlO0mr6wnkLk6jb2LWq+7Gq8JP86dyheNLd+hREC03KunWznZakrbeoiwc7qVEFYH0zqU59Gioeth3MJyZQ69yi6Xhg+X2Mpex6eM1lFLXHIFjY2sjqtOmFXZgD/VW1/KkUmX7tDNQyjtRG51AS1K+/kdIfFtU0SMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:55:11 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:55:11 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-for-kalle-2022-12-07
Thread-Topic: pull-request: iwlwifi-next-for-kalle-2022-12-07
Thread-Index: AQHZClRJH7ttMEHJ4ECwaLfF8pmO1A==
Date:   Wed, 7 Dec 2022 15:55:10 +0000
Message-ID: <b34ff82b2d084d939e636494b24ab1e25ad9b2d3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM6PR11MB4737:EE_
x-ms-office365-filtering-correlation-id: 88e4bb2f-de49-40f3-524f-08dad86b6be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwPPFVxyDblG9I/KiDCjHj/0OK24uq1dZBoMaB/kkfZO6YCk6iXzJUoO5aqzKRlWy+QiobY/UHRVcUl+DcVxtQA9V38Jw+MmlydlPictVb4ZJ22kS3KhOJtB7uX7dgXvi0M3Evfq8jQ+GpLyY4WNq2zU5eLqztK/1kjj/NRLb8ObQ9j2+FhTXuma2pu9VL9K5HVGwGfBpo7eZCCrDwru9ZOI0cxYep/7/GwC5ZRmdUzvsaHipVMxDE49yZHR0i9+F7pPQxFqLtbPRFvoU+pM0G6uSPjPAD0fTuZzvHZuvKmvHEGFfQ+SnIi5kBY/JqBcOMnBtnw8QfvbdbpWDQIWxE7bBAh7r9MJaQxGlrwBkG/Wura6p2vF/FwUJNgLbF7jgIaaLdQ0Sumh3s+oKgBK+ClMhqaDVoB7PxtpkxNwKblP0LyamMUc8FC5dPYpjP4JL7F7q8vrB8i2sLko+CJe28dqV9CoKHSkWIc2X/4LaUkC3UC+vxuMf571Cjwx5hCwNxpdH5QsC5V/puGg1tyZ6gyxiSGlijyBVt0ZPfTX167Tz5hevTbrGllMUAW1QLeAp8AgGRcYi+3O0Z+g9Q83BnikscNz4o7rGQs22ntLk4sTbmQUA0O7hyOZV7opHxxqTmBph7vbiHYKIIGWX7Vt2UFXnzYC3hJyqU7xhh+dnxrhYP7Wys5uGs5iTIGJiKI3QzhUg9Knz0cAHC7yUlQEo4tGlLBMNr7PhWQ5PdAqcD8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(66946007)(66446008)(64756008)(76116006)(8936002)(66476007)(66556008)(91956017)(4326008)(41300700001)(5660300002)(8676002)(478600001)(6486002)(36756003)(6916009)(316002)(71200400001)(966005)(2906002)(86362001)(2616005)(38070700005)(6512007)(6506007)(26005)(186003)(82960400001)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5NKytSOENFTFBQTTlieE5FVENTQkxzYWFzUk0raUR0dG95eU1KVnEvaldG?=
 =?utf-8?B?QlU3MTA1OVhCUUpOQk9tUitUOWlGaURhUklLaVdiNFgyTnJSRFBYaU51Q3NR?=
 =?utf-8?B?RXZ2Rit1YVloSzZhNFpvcWF4OWhGenJXZ0FYYmFEOFRMUWFuRDIwSmxlQTZq?=
 =?utf-8?B?UXNKci9Za2R4Tnc1MUNXdDlIRllYZWhielJFdzRSOThDaU9kRjJaWU1FRWNG?=
 =?utf-8?B?U3hPQWNxaXU4Mjc5aEE5TkZKY2xqQ1NaRGp5VTRORUFPSzVzZDB5bzVpUmZP?=
 =?utf-8?B?UWVJcHlIeGMxTGVtTHpxMlVOZEhXTUR0NEVjMHVmT1hzcWZoOWR0Vm5yV0tZ?=
 =?utf-8?B?MlZ6TFo4eldiS0pieWVCNjNDMTlWMmw1dUdwVHNlRXRTZUQyNzJtcnM2WXB6?=
 =?utf-8?B?aTZXYlNHeGtwNEFpbk1kd1dzNVlkeERMY3ArbnhuWm5JZEo2RXlBdGlhZmk4?=
 =?utf-8?B?cEM3bnNOVGw1U3FYeUY4aHplTU8xTUVOTC9DS2FtSXh3dkpEUStMdGZ4MnF2?=
 =?utf-8?B?TGJGcFQzUWk1Vi9Wd3RNeHNsbFRkVjJlTFRTMThhZHU5eG03ODlHUDdXaVJn?=
 =?utf-8?B?WDZvSkJ1aUxZeEZLNWVzRllBcGRMTUtmUVh0dWFRNUZVamFBSlBVWXhaLzNt?=
 =?utf-8?B?bVo4MFhqRklqQ2F3ZStvWG11TXJ6TUtId05jOHJmZm1XaXpPQTR3SXpGL29F?=
 =?utf-8?B?RmFjMVgzaXRBejVheStUaTZkcTR1VjR1MytVSEJVWDI4VHJIUlJKbFNZTkJa?=
 =?utf-8?B?Mm1Ha2V4cjlSNFFxRDdGemZ1THZmR1luQmI3Z2k3UEZjcDNSTk5KQzJhOFd0?=
 =?utf-8?B?Z1dPaGVkL09MamVwUVR6SGtySFJNdW9qNVpVL24xUVQ1L3Y0VWtFVk5nUFNS?=
 =?utf-8?B?dzBrOWVrVGhUWnRENEhPK1o2K2l5aG1Qa24zSHRlK1kvOENUQlpWQTFXdG1V?=
 =?utf-8?B?ekZ1R3BFa0ViYnZzNG1vVTRKYXJWUGVyNlcrdDJXUlV3QXh6QkJmbUgzRm1u?=
 =?utf-8?B?WkhkeTh2RDZBcDdwZU15MmV2cEtvU01GM1FJY3dKclg5ZkRFNDdWSmVOeHBR?=
 =?utf-8?B?ZWJ1NmpaaTRsbVBKMU9IVTRZZmZCakZYYmFHODR3d3BSS040Q2VTdzVYMDBi?=
 =?utf-8?B?dlVDS05CcEluVE9YZklIUG52S09aeGJPWGc2U0RMaVlJMEM4YU5nMkZCeHhU?=
 =?utf-8?B?RE5OSlloc3EwTnN2d2ZEc09qNSt4SUgrc3I3NkFyQkVaRUVJekFTSlorRkU1?=
 =?utf-8?B?QUVObEtiNDJuNUdLMy9POSs2eTgxTWlxcHJ2MFpxQnAvWkhpbFVUd2d1OTZr?=
 =?utf-8?B?NXE5V28xREM4akVkWXNwaFU1aW8yQ3FvSEprRU1xbG5jbEYyeDFYUEtzRnFN?=
 =?utf-8?B?N0habHhkYzRTSkIzUFUzT3Q0VXpRZjEzd2RacVROWU1XY2dTY1ZQdk9vbUQr?=
 =?utf-8?B?NVcwSVQzQ1hhbXpUdkgwSkwwV1Y5Z3k5YkRIbWowU3dVZDV3RExYdDVTUGRx?=
 =?utf-8?B?WnhQZjM5WUJRSWVGeVRUcXc0MDAxOFptZHVIU2E2cU5uaXVNWDlsSDhVaTJz?=
 =?utf-8?B?S2QxZVlHMDdZdnRtNml4Qjk3Q1ZuNjJaYTNiOGVGYVZlNTZJd3NGZ3ZQeDNL?=
 =?utf-8?B?d2dmMHpLTlM1UjhQY1IvV1RLR1R1a1lJQjlKOUdhd0ROdlVaTi82VEkrb0NE?=
 =?utf-8?B?NU1SblF4QzE2MEZFZmhYSnV2Q3Niem1GSEZRMGN6b3VMWUFzUC9lR08wU2dt?=
 =?utf-8?B?c0ExWG1JeldOaW96aU5zV1RtWmxEbjJMZk9lWncybGRiUkM5LzRwTXg0azYx?=
 =?utf-8?B?V0JXMmJCSDJmclNKTCs1ckV4ejMwSjNBYnlmWFdjcFByeHNNalBzTjBldXJ1?=
 =?utf-8?B?YUNhOXBnbkszaGZCc0p6WnR6S2FrSGRQeHNMb29TMlBQUGZTMDN6WmtUZ3l6?=
 =?utf-8?B?S3dHemV5K005RkF1NGNpKyt5d0RhSnU1akJDa2pmZlMvMS96alp2NHdyZkpE?=
 =?utf-8?B?ZWcxR1FZNEdSY1FLdXgzNzFxT0pZemkwbFlqQ3VqOHNmbW53eVVWMGFuYW5K?=
 =?utf-8?B?TXZZU2RzcC9lUGFpWXNPRXBiSDB1ZFhQY2FzSm9FUmFWZmtXc1Z4VENuaXRJ?=
 =?utf-8?B?TEhpbVdEQU1HblNzMzc0VUNKN21ReDRJdkN5UXI1S2F4cElhaVhGZE0wdUp6?=
 =?utf-8?Q?hfAPN+iTpY81M7QU/Ya9yuQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550222EFDB96EE4B83C1928AA40CB67F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e4bb2f-de49-40f3-524f-08dad86b6be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:55:10.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3r3bI9hYhW8GRouo1mr8aMkjmfACXXlTQDth3oBpgsKBG85tOLqMucuTxqa/VNC3lUDSWABN3s9VSJntGJhimTaE0PTg6B0rqg2MX8SyIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkhlcmUncyB0aGUgM3JkIHB1bGwgcmVxdWVzdCBmb3IgdjYuMiB3aXRoIHRo
ZSBsYXN0IHBhdGNoc2V0IEkgc2VudC4NClRoaXMgaXMgYWxsIG5vcm1hbCBkZXZlbG9wbWVudCwg
bmV3IGZlYXR1cmVzLCBzbWFsbCBmaXhlcyBhbmQgIGNsZWFudXBzLiANCk1vcmUgZGV0YWlscyBh
Ym91dCB0aGUgY29udGVudHMgaW4gdGhlIHRhZyBkZXNjcmlwdGlvbi4NCg0KUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgaXNzdWVzLg0KDQpUaGFua3MsDQpHcmVnb3J5DQoNClRo
ZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNjVlNmFmNmNlYmVmYmY3ZDhkOGFjNTJi
NzFjZDI1MWMyMDcxYWQwMDoNCg0KICBuZXQ6IGV0aGVybmV0OiBtdGtfd2VkOiBmaXggc2xlZXAg
d2hpbGUgYXRvbWljIGluIG10a193ZWRfd29fcXVldWVfcmVmaWxsICgyMDIyLTEyLTAyIDIxOjIz
OjAyIC0wODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0K
ICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkv
aXdsd2lmaS1uZXh0LmdpdCB0YWdzL2l3bHdpZmktbmV4dC1mb3Ita2FsbGUtMjAyMi0xMi0wNw0K
DQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYTYzNjVjMmRhOWZhZjdjN2JjYjgxZmJj
NGI0MjJlOWYzMTljOWYwYzoNCg0KICB3aWZpOiBpd2x3aWZpOiBmdzogdXNlIGNvcnJlY3QgSU1M
L1JPTSBzdGF0dXMgcmVnaXN0ZXIgKDIwMjItMTItMDcgMTc6MzY6NTAgKzAyMDApDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkFuIGFkZGl0aW9uYWwgc2V0IG9mIHBhdGNoZXMgaW50ZW5kZWQgZm9yIHY2LjIuDQoNCkl0
IGNvbnRhaW5zOg0KKiBBZGp1c3RtZW50cyBmb3IgdGhlIG5ldyBIVw0KKiBBZGp1c3RtZW50cyBm
b3IgRlcgQVBJIHVwZGF0ZQ0KKiBBIGZldyBzbWFsbCBmaXhlcyBhbmQgY2xlYW51cHMNCiogSW1w
cm92ZW1lbnRzIGZvciBkZWJ1ZyBkdW1wcyBtZWNoYW5pc20NCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSmFrb2IgS29z
Y2hlbCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IHJlcGxhY2UgdXNhZ2Ugb2YgZm91
bmQgd2l0aCBkZWRpY2F0ZWQgbGlzdCBpdGVyYXRvciB2YXJpYWJsZQ0KDQpKb2hhbm5lcyBCZXJn
ICgzKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG52bS1wYXJzZTogZW5hYmxlIFdpRmk3IGZvciBG
bSByYWRpbyBmb3Igbm93DQogICAgICB3aWZpOiBpd2x3aWZpOiBtb2RpZnkgbmV3IHF1ZXVlIGFs
bG9jYXRpb24gY29tbWFuZA0KICAgICAgd2lmaTogaXdsd2lmaTogZnc6IHVzZSBjb3JyZWN0IElN
TC9ST00gc3RhdHVzIHJlZ2lzdGVyDQoNCk1pcmkgS29yZW5ibGl0ICgxKToNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG12bTogRG9uJ3QgdXNlIGRlcHJlY2F0ZWQgcmVnaXN0ZXINCg0KTW9yZGVjaGF5
IEdvb2RzdGVpbiAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGRvbid0IGFjY2VzcyBw
YWNrZXQgYmVmb3JlIGNoZWNraW5nIGxlbg0KDQpNdWtlc2ggU2lzb2RpeWEgKDMpOg0KICAgICAg
d2lmaTogaXdsd2lmaTogZHVtcDogVXBkYXRlIGNoZWNrIGZvciB2YWxpZCBGVyBhZGRyZXNzDQog
ICAgICB3aWZpOiBpd2x3aWZpOiBwY2llOiBBZGQgcmVhZGluZyBhbmQgc3RvcmluZyBvZiBjcmYg
YW5kIGNkYiBpZC4NCiAgICAgIHdpZmk6IGl3bHdpZmk6IGR1bXA6IFVwZGF0ZSBjaGVjayBmb3Ig
VU1BQyB2YWxpZCBGVyBhZGRyZXNzDQoNCk5hZnRhbGkgR29sZHN0ZWluICgxKToNCiAgICAgIHdp
Zmk6IGl3bHdpZmk6IG12bTogZDM6IGFkZCBUS0lQIHRvIHRoZSBHVEsgaXRlcmF0b3INCg0KVG9t
IFJpeCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtZWk6IGNsZWFuIHVwIGNvbW1lbnRzDQoN
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kYXRhcGF0aC5oICAg
fCAxNiArKysrKysrKysrLS0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9mdy9kdW1wLmMgICAgICAgICAgIHwgIDcgKysrKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJzZS5jICAgICB8ICAyICsrDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuaCAgICAgICAgIHwgIDQgKysrKw0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL2l3bC1tZWkuaCAgICAgICB8ICA2
ICsrKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYyAg
ICAgICAgICB8ICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tZWkv
c2FwLmggICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbWVpL3RyYWNlLWRhdGEuaCAgICB8ICAyICstDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tZWkvdHJhY2UuaCAgICAgICAgIHwgIDIgKy0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jICAgICAgICAgICAgfCAgOSArKysr
KysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdG0taW5pdGlh
dG9yLmMgfCAxMiArKysrKy0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9mdy5jICAgICAgICAgICAgfCAgNiArKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9vcHMuYyAgICAgICAgICAgfCAgOSArKysrKystLS0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1xLmMgICAgICAgICAgfCAzOCAr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL3N0YS5jICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysr
KystLS0tLS0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGlt
ZS1ldmVudC5jICAgIHwgIDcgKysrLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvcGNpZS9kcnYuYyAgICAgICAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLQ0KIDE3IGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25zKCspLCA3NSBkZWxldGlv
bnMoLSkNCg==
