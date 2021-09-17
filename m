Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7831C40F240
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhIQGZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 02:25:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:58548 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQGZR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 02:25:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202229118"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="202229118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="434023998"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2021 23:23:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 23:23:38 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 23:23:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 23:23:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 23:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDwZGDRgH6L9Basm6Wo2j6MFxftp1RKZuZzZEaAk7NQ99FtDEe+Nyu/xlL5lkiCz/n1T8wbyH8eTz1sGVexREavMfZ6YFc1py0jr0eTHfN5zRHwQOQx/WoSl6hSkekfKfQ8GHelgsVOBygoUnUiNikK63UWqzJUUqiXnVq/MDWBPv739/TPKr8RzqbMcEFPknHmjTvqZyNcrhWM7rjIPGwxT4ZK7zl9aGfuE1vxVbqaoUFz3UzQrDzfSiEEDpy2OUv5HZUcRZTFl6qoSZllWyqxzt7B4SFi4KbV5mRq/ArC1FrcClKnG9+L5DpGaYEMy5Oa9dzPvCtyv1GCETj6I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8VpC51EnO04VVyo6F6VP2PP6fGbdtMHmeoxNTYFqEP8=;
 b=UXsCDtmVvO5BdaplvFMCz6rWdo45wYFHHVaTUt7R8OPqvSLbQabpDROs57hf9ZFep/55HnoyPzI46fJo5qvNFM47DmpWjziU2iU1qraNV1si3IEKC2Ixfn883KlFUj2zl+O6UfaJT4S5dMs/fBKG8sFieFOxK2XDuKRnFlHSvfYtj2aKfATtN7iovxWhd5FGFYy1DfqGNtDwmXijakEtxc65zoNN6gSU8aq47KdnfDTKSFOpZvwH46pEgo3ItPt8juTJJE1Vo5E4p1NA3ZXRHpzKx3stfukz1TaB0+ZBcC3mlSNI+OHst3so2WvnCH3/lAursY7duayDGlKe/PutHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VpC51EnO04VVyo6F6VP2PP6fGbdtMHmeoxNTYFqEP8=;
 b=jYwXLz9crtVHMx9T3aL7Q1NxxkBAWfw714P8EhkKWpb+Doe0ZhXWMpLBsPWAHLVuI4oXSrt2fPGkeXLx6SwP2bjGpN81zyBKgUDxrZVJ1e6J317lxJxVE5yhfG+yggRPF7ab6rGaDHTpmZ4ZFU+0vEHLcUyAjYP3mYhX5KIwtP8=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2774.namprd11.prod.outlook.com (2603:10b6:a02:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 06:23:34 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52%6]) with mapi id 15.20.4523.015; Fri, 17 Sep 2021
 06:23:34 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Goldstein, Naftali" <naftali.goldstein@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Sharon, Sara" <sara.sharon@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Dan1.Halperin@intel.com" <Dan1.Halperin@intel.com>
Subject: Re: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
Thread-Topic: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
Thread-Index: AQHXnkDQZ5ZBaUWHUEeHaTyx44CrVKun3JKA
Date:   Fri, 17 Sep 2021 06:23:34 +0000
Message-ID: <2fc3e84bcc5490212ed86566957e19340520ac37.camel@intel.com>
References: <20210831081802.GA9846@kili>
In-Reply-To: <20210831081802.GA9846@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be2b3b0-9efa-492b-0144-08d979a3ad78
x-ms-traffictypediagnostic: BYAPR11MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2774AD09D56564F8806182AD90DD9@BYAPR11MB2774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPlrUzRzJ0WClRyBQu8uZ4L1pw/Dso8hYQLSnqPAbl0TkZ/LHjg4mBSiTCbZLpuipVG7R2RJudTaWKmdb+OXTm07hariTGx5XlPjsC04XC3Hja1xGZ+THAldX3HxJyd+mWYJ3kzKkVQssrVGWb6O3RsAQX/lilnuJoNd2l20ZBVFm3RbzMB4Z2gh1nqlkWNzFjdV4BuEqQAKqqWfBABmGwcm0xOUnklitrZ+PuJKpzoD+mNpfeMcrbQ2PDj6YWPYPfXPiDM6S2Y0KO3s0D5DroZrUiMG6YBKsJxGdLIjV0tdC5K5aOWLbKH/l4ITivnBAcNAZnHWnLHANmu7GsaPim23yvIKKPvGMjrtQN4MQilbxpF11VPekGzOxbZvpQYLgZ3c0mLvXMvCMa3LEYRtK0RVdEUAhKF0fYfuyfNgxZYy2LYfWgIY+TkeaFoS9+zpdhW5xF8fqBBlFw4CEIsjrRh7SrknMssKaFIpVfhW/FWvKQbcFKf7r+y8mk23OKarUJR3ly7RBv/I46ShUQKWvLnOiRZUfVjNRc9g1OeqjlPyfJs5A7oNOPHekLaE7bMgYX59BtYecQA9Cd1XKvDkGSfjwmJkS1ikzRTPf+LV4NAipMTyL8pKQeYP/RXjbXLQBfYxRUQjjxBLYm957/ogPVO18Y1JdnhT/eMunS6FM76Bg/TWxRFk5QN3gFCUs0SLxnAOdawAQM1YXyz0RrzrVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(107886003)(38100700002)(110136005)(122000001)(54906003)(38070700005)(6506007)(66476007)(66556008)(5660300002)(26005)(8676002)(186003)(8936002)(66446008)(36756003)(83380400001)(91956017)(64756008)(66946007)(71200400001)(6636002)(76116006)(2616005)(316002)(4326008)(6486002)(478600001)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGdrd0p6bDhKWUtQZEFnb1grSnJDZzRoU2VzTWNQQjlTaUpKd1RxV1FkcDJy?=
 =?utf-8?B?TGdjN2M3NWRCYXdDck02ZTk1QXAwSGYwamV3T3FvcnpSektaTjRSSE1semhQ?=
 =?utf-8?B?ekFOd1RVSjU4QldKTk53MElmSHJIL05MWlRLWTRXcWM0Z3YyT3RVb3A5TmhL?=
 =?utf-8?B?aUxGRTVOVWdvR2p5TnVIVkNKbEhXK1BaaW4zQ0tJUWtPTDE3cDRLd1VncFlL?=
 =?utf-8?B?K0tLcGhHRTFVQjdjWndEaWw1UjBaNTFwQnM2ODNOemhiOENVTi9aWFZuN3U5?=
 =?utf-8?B?ZGtsUmtuV2RDd3FiT3N2K2xGL1NJbWRLNFZPUWZyeFZZTjFRR01DZDBQMnRs?=
 =?utf-8?B?OGM5QjJzQmU1UVF6NDR2a2l4VEdWeVpZUXJ1NDFuc3JqS1ljUG5yUlZWR1Jp?=
 =?utf-8?B?WWVEM2RHVEdkak1uZDZlNzBMekVTQ0Q3elQ1ZjMwZUJYUUxCYm5BM0JpOXgx?=
 =?utf-8?B?YTBzVC84a3pBUnNLQ0ppUWRNb2tFODN1NHR5T1oxZjFBZnB1ci9pS3VJV2R6?=
 =?utf-8?B?Y1VmbEtQZWZLY3hIVC85aXI4NmxrZjA4d2JZdHNlNlI1Nk5uZS9Qc1RUTWNX?=
 =?utf-8?B?bGhUSHpIRGxyNm1UUTliRWhiblVNakliTlEwM1pXb1pwdkNyUDhkQXZURGlU?=
 =?utf-8?B?VC9ROU5wQkN4aFd3aXl2Y1ViTjk1U2NYMm1lRFNmR1FOcEFBYTN5TUxzbHN1?=
 =?utf-8?B?amZDbXBsZDRXNzBwTm42Y2l6aE8rWS8wK3MvSmhmTjMwb25STTB2NU5XYk5m?=
 =?utf-8?B?V0VGMzhuOTljMTh6djVZTXdKdjg3bGY2SURzQlNsRU5RdmZXTmY5c3ZEb1FU?=
 =?utf-8?B?Q2ZoOTBLb3cvemFaRXhOVnBaazZEdGJ1Yk1CeXRmUnZ0eUl4YjR5VlU4cjl1?=
 =?utf-8?B?M3NkY0NuaURGS0hzdUdQbU0rQlUwUEJkc3o2WVAzWGU3MFdQYWlZWlFGeHBa?=
 =?utf-8?B?dVBIQzdRNnI5aTBqb3FaUS90K0UveEZmcXpYMHlRcGtFY25IY0gwRk9TQ0RQ?=
 =?utf-8?B?UmUrcStYN2Fab005aENmNXpZTzFHUWdiVVhoN0pOS2hwcFh1ZHc0eGtYdElL?=
 =?utf-8?B?Z2pzSGRjV3hSUUNuUTlRZmY2TFdRajZUY2hHTWZyQmduaFQ5ZWNNYlVBUE53?=
 =?utf-8?B?R3F3L1JEUWt4ZHpSeEo5c2puYkJRYlN3aTJLWjdlYTFXb21na1poaERMYVhO?=
 =?utf-8?B?bHp1SnBGRndDd1orOWd2L2NHbXhVQjdYYkRiQ3UySE1xMlpqUTVGOGRsRGF5?=
 =?utf-8?B?SFM4TUc1c09lRHBEdm54d1cwd2FkR2NMeDc3d0N4TXZpQWc3ZVhxVVdNNEsr?=
 =?utf-8?B?OVVVMXhnZE9wNjBsZkd4STVtTlJXUTB4S1hrQXdKTittSU94ZWtDN0pPL1F0?=
 =?utf-8?B?Um4reHZ5V21CMVFpN1ZVTll3WFNBL1RVY1VnL2pHS2E3a1lIRVpxbXlTWWxa?=
 =?utf-8?B?VEN4U2RoRzliUjBMMTZkMFF6R2krZWRLOEsrVy9kZytpT3Z0MEpnWTRIbW1N?=
 =?utf-8?B?dFJqT1A4eHdabEs5eFJ3L3lxdGRJMnV2WWo1dm9YbzhSYUtuQnhaN0NRWUFh?=
 =?utf-8?B?UHpZTHE1ZWYzUWgvMEtxTi9aUVYybmEzT3R1bUNxNkpRSmo4U25FaFBDQjhv?=
 =?utf-8?B?d1FmZ09aV2xwSGYrYUtxd05zQm9OWEV0cklWYkNUNWk0ellQWVJpcWttNVR3?=
 =?utf-8?B?NFB3cTE2L3dEbDV1cG1Da2JQTFloK0twblJOUlpOdmlsZnNEc0htTE5McVc5?=
 =?utf-8?Q?yC2j+Y8PPn2Z8EFoJ0cbFUpy25RgIrG8E/toKaA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C953C0E4BE15EB478B212CB9E5378BE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be2b3b0-9efa-492b-0144-08d979a3ad78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 06:23:34.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWbAdPEgRCAZHo6LMS2kXnmS9gUBhzA26DknWHAPasqq32/9u6UCBs6Al7NWpfJOJckKrfFT+NRSfJgJRMPeUc1U9ThjdUHaGS+paGHte6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2774
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDExOjE4ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGVzZSBzaG91bGQgYmUgPj0gQVJSQVlfU0laRSgpIGluc3RlYWQgb2YgPiBBUlJBWV9TSVpF
KCkgdG8gcHJldmVudCBhbg0KPiBvdXQgb2YgYm91bmRzIHdyaXRlIG9uIHRoZSBuZXh0IGxpbmUu
DQo+IA0KPiBGaXhlczogNzllNTYxZjBmMDVhICgiaXdsd2lmaTogbXZtOiBkMzogaW1wbGVtZW50
IFJTQyBjb21tYW5kIHZlcnNpb24gNSIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIg
PGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyB8IDQgKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMNCj4gaW5kZXggMGU5N2Q1ZTZjNjQ0Li42ZTNhNjNh
NWE3NWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL2QzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
ZDMuYw0KPiBAQCAtMzYwLDExICszNjAsMTEgQEAgc3RhdGljIHZvaWQgaXdsX212bV93b3dsYW5f
Z2V0X3JzY192NV9kYXRhKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiDCoAlpZiAoc3RhKSB7
DQo+IMKgCQlyc2MgPSBkYXRhLT5yc2MtPnVjYXN0X3JzYzsNCj4gwqAJfSBlbHNlIHsNCj4gLQkJ
aWYgKFdBUk5fT04oZGF0YS0+Z3RrcyA+IEFSUkFZX1NJWkUoZGF0YS0+Z3RrX2lkcykpKQ0KPiAr
CQlpZiAoV0FSTl9PTihkYXRhLT5ndGtzID49IEFSUkFZX1NJWkUoZGF0YS0+Z3RrX2lkcykpKQ0K
PiDCoAkJCXJldHVybjsNCj4gwqAJCWRhdGEtPmd0a19pZHNbZGF0YS0+Z3Rrc10gPSBrZXktPmtl
eWlkeDsNCj4gwqAJCXJzYyA9IGRhdGEtPnJzYy0+bWNhc3RfcnNjW2RhdGEtPmd0a3MgJSAyXTsN
Cj4gLQkJaWYgKFdBUk5fT04oa2V5LT5rZXlpZHggPg0KPiArCQlpZiAoV0FSTl9PTihrZXktPmtl
eWlkeCA+PQ0KPiDCoAkJCQlBUlJBWV9TSVpFKGRhdGEtPnJzYy0+bWNhc3Rfa2V5X2lkX21hcCkp
KQ0KPiDCoAkJCXJldHVybjsNCj4gwqAJCWRhdGEtPnJzYy0+bWNhc3Rfa2V5X2lkX21hcFtrZXkt
PmtleWlkeF0gPSBkYXRhLT5ndGtzICUgMjsNCg0KVGhhbmtzIQ0KDQpBY2tlZC1ieTogTHVjYSBD
b2VsaG8gPGx1Y2FAY29lbGhvLmZpPg0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
