Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E740F247
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhIQG0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 02:26:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:58610 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhIQG0I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 02:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202229249"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="202229249"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="530567137"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2021 23:24:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 23:24:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 23:24:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 23:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN9y/2z3KL3xuilxaKl0hlBfSc/C8oXiZ2sUeb8lCdjuu84HEVF/ww7aWTber+inr5rOVJ+zgFoVXjh69GjsqeOhNwkftxblGbt/amYerYimHVkMBZQGl/+bouX+TIyKvrJffWlpJKr9BC71UbKu7+Q/HgyOLymjSh9HFvIo8ftWUypNTCP9jeLz93z2ejCcHFuDwoWASiex1JTcdoMiurc6Z0T3Wr+LMxXhoMXLkG4BvvYFyNYEd/ftmy5Hyc132rOR8wyGIRTdVZtc24woHLiR7ECOoiA2vfCS+6lGS0Wp1dfcno+NEmfHCDlyUWCxt4FOTJhX8hL2Z1LQwEw2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pTEkYTARj+r6nD8lsM1aVJhqh1vmwEUJdOA9T7GEth4=;
 b=b3xuUvb212BcoTUrAT2cL0aQtYDtIUN/hKjXj99UFVwINVt8wdGr+14BJJv1bd19Ioam00xkEomz7Og3dzHBRCbw/D3WjmgPC2vQtqNGACSFhoXhkWBeOGopHGBi+VvO6j+0zY7lDBnR9jdqooYA5weDaXnLhn7eFd/1Y/K/wrRYWWdxbVVtlF92IETUzCMFO+TW/hKghq72HQc+x5xPuR6bBkPvcICYsubOtI1Ll/6uHetIkJBSkzKa/Vp4dlKNZbDrmwjZf2pyW48bQ+4KyUPu3pMV0L0YZuEfDU5No1Kycp8lNxSGL+QrO2uFRwbv/K9Zi4dvNIGBpeEFWs8hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTEkYTARj+r6nD8lsM1aVJhqh1vmwEUJdOA9T7GEth4=;
 b=x9o9SWCBpm1KUFt68hTMJls5jGms2/Zs9TUcqE03cH0NQKHKUdrK6cbQuosz5k8sl3aPRX6Y+cb7PKn8/3FongNsuhEgekclPwT/0lsMBF6pjSUNrBnNw3UVKKtrssZg5wcXkZYYAzfUB790o4s4vxa0KgkS4AeljPkhUqzQbSU=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2774.namprd11.prod.outlook.com (2603:10b6:a02:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 06:24:44 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52%6]) with mapi id 15.20.4523.015; Fri, 17 Sep 2021
 06:24:44 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "Goldstein, Naftali" <naftali.goldstein@intel.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "Errera, Nathan" <nathan.errera@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sharon, Sara" <sara.sharon@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Dan1.Halperin@intel.com" <Dan1.Halperin@intel.com>
Subject: Re: [PATCH 2/2] iwlwifi: mvm: d3: missing unlock in
 iwl_mvm_wowlan_program_keys()
Thread-Topic: [PATCH 2/2] iwlwifi: mvm: d3: missing unlock in
 iwl_mvm_wowlan_program_keys()
Thread-Index: AQHXnkD4mhxigMkVVEeGmIO3bT00X6un3OQA
Date:   Fri, 17 Sep 2021 06:24:44 +0000
Message-ID: <1cf19ff3324b4994d841d455036cc34d8b1f2998.camel@intel.com>
References: <20210831081849.GB9846@kili>
In-Reply-To: <20210831081849.GB9846@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfea20b9-a95a-4921-6be1-08d979a3d704
x-ms-traffictypediagnostic: BYAPR11MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27741A1CE9B5D7F5EDA0CC4F90DD9@BYAPR11MB2774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wopuMQdScnHrlJBtgf8fnPGh39x3+QPbu8KwzymF/K2vqDjuMi8F4nf1sEHBkf8axiCMHkdW2BErxu4fOeexh+cX5Wx2mKX8E+Ho92wxYKnS4ouYaY+7n72p/1/jL/y/CCjkDFNRYqSzX8JY0qG3sKOt5N9QB0TxWFLhDj0ATCG6EVUVT1EVgXKvd8cRhbXH5sIQT4980djHpq3CI4BSsTLkbHsMxO/cDxI2NmBsRm4Ny5yMLrvbd/fly6lfNJgWAR/J34k9qLQChpw/kPuX4GkLhfCKRuaOSMccUhYe/y/YTDGCSHdCSUXSmTy/fy6R4Mt6nwpv5dI4krexGMAVHiNKp3YDgmBFIl1VxpP4NDGQfG1japOoiKSK0bH5piEwdqi0G8sMrD0o1rQ3I043m5b8azNYv1dDZeCICcJvvqjI7olNrc1wirbuk38Wt6NBbq1OJsu2KPe0yVLF2JDb/c2RPuiP2iGw8Bc8znHXCtQqr/mKHwm9Oa+S1CJEi6UIUZ4E5JqEstNMPnktKGFTfVYqKOkTtgxGFdbq599BZjHFc0SeOP4CSq4QhXBdMdJrDiSu6cMVJS67EqZLbw5Xh3q4uuDQK+KaAvucz4D1UTAA0xCPLYWzirUGLK9rIpgrNLwZ1sdwP4oetzBWk+ttIN/VJP5KkpcfDmMx39K+7g/8RbhB/tQh4qWa/PHC9zFAwn6f/4Lu+L41sf7dwHnHYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(107886003)(38100700002)(110136005)(122000001)(54906003)(38070700005)(6506007)(66476007)(66556008)(5660300002)(26005)(8676002)(186003)(8936002)(66446008)(36756003)(83380400001)(91956017)(64756008)(66946007)(71200400001)(6636002)(76116006)(4744005)(2616005)(316002)(4326008)(6486002)(478600001)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHVpckFDeGRPL0ZKZ1dvUWZEaEE0Y0VIRWxaOGg0dVZFOTNKdm1mM1NiK0Ix?=
 =?utf-8?B?SHplYzFBRzJvRHVUMTlwQmE4azZmQlBCT1ZPQk5QbTVmUVd3elJWdlNzeDZ0?=
 =?utf-8?B?bGZtV2pSS2RkZzkyekJVMlNSMUNaais5ZUIzcy9hTWlQWHh6WFdpTENLNWI0?=
 =?utf-8?B?UlNWT0lXY0VRUjA2UldZU1MyRm9RR3oxcDJVVWVWSzFmMFhDWFAwNTZGNks0?=
 =?utf-8?B?YWpFRHorN2Jyandxa0FLZzRtMEZNdzVMN21idG5PWjAvQnZkZjBaUHB0aHJG?=
 =?utf-8?B?TVRVaWZUdjRwaVJEcXN4bG1FMWhtT2J2aEVFQXIyM1RFenp6U3hGbkZNc2Ji?=
 =?utf-8?B?V05DNEg0SVFlVmlpZlB5bWtiYzZHL3FkN05vdURxdk03WGhLUVBFTVgzRFhC?=
 =?utf-8?B?dW91cVF3K0VYM3NzS1U0MmxkQUxFSjZWT253cjI5MW40SjlUaGs1N082TXVQ?=
 =?utf-8?B?TGUraExMWVpNUmE0d05HNmdrK2dKTFNNd2FnckI0SWJMeXk4TXFza1pFR3VH?=
 =?utf-8?B?Snc4M0h4RFFIV3JVSUg3NVNZUlJLSVNYQ3RHa1dBVWczRmFHL080N1VmdGNl?=
 =?utf-8?B?dkZhSERaK2Q0bURUbUdzYktJbDZwem5rVUlsOFltUytzanlaRjgyb3ZoVzFV?=
 =?utf-8?B?WDU1ZmZ5V2FnamJ3VlRoQWtoWHdsUEI0N3FrU1ZxamRQSzlQWVo1K2NXY3VO?=
 =?utf-8?B?WW9pRUhXUlo3ZEVneEh1Q0dHcjNnQ0dzSHY2cTJ4QnlxMStiOVEvcmJjSEJW?=
 =?utf-8?B?Rm1kUld5QmRFeExsbTlaWTZ0aTZzUTNVQlV4cGxmUFdIUlF6VUNFQ3F0bFNZ?=
 =?utf-8?B?WjRUeHFJUGFBSHNMQUxHM0t4L1JXMy9waWZreEVGdXJrVlJqNzBaajRBdEVx?=
 =?utf-8?B?VmFMZ0pJTTFlZFAyL093cFVjaERMQnc4NE5VODJPOFB0a3VkeWxkMUhDVndL?=
 =?utf-8?B?WUdVRXhKRUxFdmNRTWhaQ01PSVFUTGFRQ2R0cmRRMFhUTXE4Yk5qckFZdmpH?=
 =?utf-8?B?MU1QVEtQdC9HNi9VcXlUZE9JZHc3Z0RHTE5kVlNMcktUUUFpQWFKbGh6SFM3?=
 =?utf-8?B?eFFMenZVVG9BZXFmQ2pCRS9uYTJLQzhFNURHU3dWZUJjSnY1TXFVYkpHSUNm?=
 =?utf-8?B?VklQQmJ3a0U0dmVIRDBYUW9CR0g2OXpLRmlUMkJCRXZ4NW1Yc1UvYlU4ekN1?=
 =?utf-8?B?TW4wRWRqYVk3MFJSMGt2MFQzbHBQSFRnaDZ3TFJDVkltbFdzUUY3L0lkQmVi?=
 =?utf-8?B?QW9zcFd4UVRCL1pnUWZySzhZNmhJQ2x6MG00Z0kxczJqdUdiQ1BvK0FSMVhx?=
 =?utf-8?B?VXpQZ1BSUUVTY3FvMTZDL0tQdzhzT0F2UVJKeUZzZkFaVG8yS1RDR21heWZ0?=
 =?utf-8?B?SGZlVEtldTJQMDRVZWxGOTlXaWUwQjMxalVTOXh0WEFqVGIzdWJpcUFmL3hM?=
 =?utf-8?B?YXFjQU10c2crZzFnVnE2Tm9reVRiUnVrcVdPTVZncWpkS3lKbDE2MUlXaEM3?=
 =?utf-8?B?STgzMjQ0QUNGSUZXcklmcGtvd2YrY2FkRE5Ba005TmRWbFBpaTFPRlRCVEdG?=
 =?utf-8?B?d2VDUEprU2tOK2Fjem5FNisyL1djWU5pNGFNaVBqYThaUjBnS2luV1F6MUFn?=
 =?utf-8?B?VUdmOTRFSkVDUnFKTVd6Y2xmUWFQenZJQ1E0NXRBNm1PeHFXTnY0QWdQbEVV?=
 =?utf-8?B?THlFcEE3c2JyU256RDhxeVFwc2tSek44R1ZYekxMNU5oaVZ0NVVuejZFalF3?=
 =?utf-8?Q?TaaQML8n8J1SvHaCJfRztDppE5fywU0aO2IntW6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B0FA01EFE3F548A1FC3CDCA5CB8861@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea20b9-a95a-4921-6be1-08d979a3d704
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 06:24:44.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6o+jRe+NyGsE5DYuEhQ4OwpJuVgPHE4Ji9I4lJ26wrwi5vJFlQhQFAzd2j7EM3MZVKKDispBkIjDVRhn5ULMRTUgXtf8FIh4WGMFoWVYtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2774
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDExOjE4ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGlzIGNvZGUgd2FzIHJlZmFjdG9yZWQgYW5kIHRoZSBtdXRleF91bmxvY2soJm12bS0+bXV0
ZXgpOyB3YXMNCj4gYWNjaWRlbnRhbGx5IGRlbGV0ZWQuDQo+IA0KPiBGaXhlczogYWYzYWFiOWNl
Mjk4ICgiaXdsd2lmaTogbXZtOiBkMzogbWFrZSBrZXkgcmVwcm9ncmFtbWluZyBpdGVyYXRpb24g
b3B0aW9uYWwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVy
QG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2QzLmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9k
My5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYw0KPiBpbmRl
eCA2ZTNhNjNhNWE3NWMuLjlmNzA2ZmZmYjU5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jDQo+IEBAIC0xNjAsNiArMTYwLDcgQEAgc3RhdGlj
IHZvaWQgaXdsX212bV93b3dsYW5fcHJvZ3JhbV9rZXlzKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LA0KPiDCoAkJbXZtLT5wdGtfaWN2bGVuID0ga2V5LT5pY3ZfbGVuOw0KPiDCoAkJbXZtLT5ndGtf
aXZsZW4gPSBrZXktPml2X2xlbjsNCj4gwqAJCW12bS0+Z3RrX2ljdmxlbiA9IGtleS0+aWN2X2xl
bjsNCj4gKwkJbXV0ZXhfdW5sb2NrKCZtdm0tPm11dGV4KTsNCj4gwqANCj4gDQo+IMKgCQkvKiBk
b24ndCB1cGxvYWQga2V5IGFnYWluICovDQo+IMKgCQlyZXR1cm47DQoNClRoYW5rIHlvdSwgRGFu
IQ0KDQpBY2tlZC1ieTogTHVjYSBDb2VsaG8gPGx1Y2FAY29lbGhvLmZpPg0KDQotLQ0KQ2hlZXJz
LA0KTHVjYS4NCg==
