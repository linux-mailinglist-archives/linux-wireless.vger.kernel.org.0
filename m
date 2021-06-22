Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9B3B0724
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFVOPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 10:15:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:23393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhFVOPA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 10:15:00 -0400
IronPort-SDR: SYgLTIZhKztpKAMUj67kYrsfwSexPGfjuBKAkFsLX+XLtT4XBsu8tCMaRn3MDzbL0ssAwNgiZs
 y2QjzFYsRyZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228615221"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="228615221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:12:08 -0700
IronPort-SDR: 33hQILjgdvb+dGhMa+a8n3qsxo4Jq48+Z7GyjPN1TQqC9m9v0bCpq9CmmpuhEEc2qPWUApZe6s
 TE9jEgYOK9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="480822744"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2021 07:12:07 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 07:12:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 07:12:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 07:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI7vuPKkLX4urCqeyKXV0qcOlIBtrjRYrMY+WiJTbcVJ5I+0X2tSm4nI6sgHnziv2dbLUjHK+KghwracDgeip6hzSFooN3w/Z3SHaXbxQi7QX4GFUEBTo5w8xFqt5Fi/gu+4lCuoI8b8phmZSBhSu0aFrdCNGFwC/mggUHcQLt4SGozTKVgYLmaKtB7aUr+WjnfOW0GDBSg2tjbI20FifeIRJmi6NXD8LUQejWz7r4HzS0e60JLNrwaCU/S+BR/wZ6+Nf7CxjV/coGxVNd6jBWVPy/bZ7/hcduCCNyOOv3IJP1586c4By2qNQYqHSYc0R3oC+WKg3rMcR5a1Ke+bFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWbolih3GT3jHOA5kVyvfM7k10kIeCGwVMB+fBx20w8=;
 b=DTSpKsD43hd+ujx2fvnoI0DwCMaijJtZc90M9dbGSPCQFuMxtfQoNDQaKxZiPpMtjRF0aiZ/I21cSvtPwGyOfaZwHDm/3s3izEP8UcsKfwRY5z4WW8gQKJf8lSy38e0v1fojfLOJ4oDyYC66B/5Jzy/GRaxVNE0uIWSY19N0CGD+qUyuq88220MbleQSxjU6cg7/9epkbxCjfwnLPjUyKcN9Kv6KRnv3XvLz8kaWln07GNVAtT8JkUrUV+nmwvPgw95GVy1DigwOxV1/+q/Hle3MrEFb6080/eGrXAr55GMw1bFjS4OCyaYeSz1G5/mVzZC6vlhOQgY3TypjHLY8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWbolih3GT3jHOA5kVyvfM7k10kIeCGwVMB+fBx20w8=;
 b=Fw4iT1lLkwstTdeL2YHFuL96gqNb6DsNK/nj/FIM2d2fYIJ4uGnajTfvNJIcSpG9CkkvmPqbRTD3On1vRZ3FPrs17oUgoyqsAWjiVeBmDZaDpiMD6PnYaB9o6hadwXc77EUZC3sm2LlFLNJuETH2ZksGQ4IUtqZM3li1HwwseRw=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BY5PR11MB3880.namprd11.prod.outlook.com (2603:10b6:a03:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Tue, 22 Jun
 2021 14:12:05 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f%6]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 14:12:05 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: Re: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHXZnPDjMmJD4VExEWItilD4eCUmqsf9IyAgAAfsoA=
Date:   Tue, 22 Jun 2021 14:12:04 +0000
Message-ID: <4a3ee9e9665108d678b32de4b8729f0e19f22cef.camel@intel.com>
References: <20210621080159.12883-1-emmanuel.grumbach@intel.com>
         <E1lvfMS-001avq-Bi@farmhouse.coelho.fi>
In-Reply-To: <E1lvfMS-001avq-Bi@farmhouse.coelho.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15076ebb-46fd-4875-f123-08d93587b69e
x-ms-traffictypediagnostic: BY5PR11MB3880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB388085D5C92F1B65A134786A90099@BY5PR11MB3880.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mf8wyF4pJ+gJoqa7spSp0YeuaLYSSRsLp4U/ufcMbLsj4eaF2O+BjuReWU0IcjrKviUQozjWRUgLy8DmDnb3R3g1zHoHnowT8n4+euIUt/rFeN3GFg3olk44eCyTH7thIg5gPomnVU/M4Cos3BWq1C9dVEGc18MyqI+LIbml3G7gF5Ndw2HfbOqhn7QqnH+SOyOzw4sVWO94lJWT9lDkWhqfB7RDjg16WIhAurwV/O8Ug8x1+0zyRytqLYLsn6Foor+JJjutetnen86uHJHbRYhHug1EYf9JUyNNIK+sGSFP8AO1aDhvNZNzS9YwBRVIoHFslyAEC8EZrXLCwCzAOg16DdkfeRzZ5ufKmd0YwlQNKVki8zEQS6XRbwoSRCwxFfC60c9nuPfH28MhgVqCEuwhve2DU4sZQNDBRhpB3ZG5Qq9TZESaVW5M0Y127WPb/ZQJhjc20d0YfttZynI/5QNDqJ5NYxzp4w4loy6fFhpjHs06WAQtvdhfAgj3g0gwG6gIcaVhoXW5b2P2zYg8z0mTlzT60wQRmg+oYGRxDht1VaSYmzNDs+8L9+f6roc6c3PFWbsdBoOALCizRXAcdzP+Qx9M8aUO2mPj9jwIlss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(6506007)(37006003)(6486002)(107886003)(2906002)(4326008)(6862004)(71200400001)(2616005)(316002)(8936002)(86362001)(8676002)(54906003)(66446008)(186003)(6512007)(38100700002)(122000001)(83380400001)(36756003)(478600001)(5660300002)(66556008)(64756008)(26005)(66476007)(4744005)(76116006)(66946007)(91956017)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2o1WFhqUlEwTHBrdTEraG54ckNncGt1WlFJTVp6WGMxVWoza25Bd0w4NWsv?=
 =?utf-8?B?WHBpU3VOdUZndnJkSE9MQWY2eW8vZDV5aVZ1SDlpdWdESFFtREx6TnoxblFO?=
 =?utf-8?B?eEhXczRUT1lPd0xuQ3BscVg4UlB3RUpVVFBBa1l2UFZVYzV6WmFCaENwTHBP?=
 =?utf-8?B?Zkd4eVdxSzV2SHVBbUQwaU8rZHYwTjJYaVFLNnF0bTJtdG5EeVJOc2hTN2JW?=
 =?utf-8?B?YklxMUQyT01uTFBUK2RqdklzbHplRGRqM2Zjc0VxcStRTk04QWlqODErSHov?=
 =?utf-8?B?bnJlQzRJK1ZEOTR0R015TTVpOUhpYkt2QW9HQnpuRHdVODVGVWNlUUVvNXR4?=
 =?utf-8?B?Uk81M2lJVjBxeFhIZXQrRXRjdDgyTlNOZWZaYWRhU2NaUVlqUTdweE04bzhm?=
 =?utf-8?B?T0x1RHlhMUw5Y3l0Q1JUWndMMzluOHQwR3JNTW5jM2lPSnlQbFZlVC9UT1Fm?=
 =?utf-8?B?YnJXUUUxT0xEMkV3ZFd6SFltM01BOTUrVkQzVTkxd21RZkNhUEl4NlFCc05U?=
 =?utf-8?B?RExtVTl5MStlVzFZQlliOXpiNWtnTFg3OWQvQkpwZ0RyZTVSZVJBeTFDNjNY?=
 =?utf-8?B?SWEySG9LWG5UUEloRnVyajJKRGpVekVUMlJZeU01bjlmTmx4LzZ4eE9wSUlU?=
 =?utf-8?B?L1VvcURRRktKOTdDT3Rud0lIQ041bWJCTkx4VXlzeWhUbmUxNFdiNU80WTVP?=
 =?utf-8?B?aXNGVXh0LzdDSXMwLzMwZ0ZRVjJGSCt4YmhKYnNaUzljcmZzc0s5QjNlMVh2?=
 =?utf-8?B?RGZrK1pzUVdrcXNua2hIMlA1ek84Q3M1dWVIWE42Z2NuejVxUEV0TzVrOHM0?=
 =?utf-8?B?dTQxMFhwYlpwSDBiRnMxcXV5U2prMUFpSmNKamhVVElQeGdZaXUveHlxemRy?=
 =?utf-8?B?cmlzUUUxWllWQXUzTjVRbVJBRnRrRVVCaWNmVkNscW9rM3Y5Vlkvd1NwMlc5?=
 =?utf-8?B?TThkSStLRXNIWWdvbkpJV3o5eEtNNHRYM1BJV1JGZmtoZkg0ZERWUW0ybGYv?=
 =?utf-8?B?bVNESEkzL3RnczM1YUtHdE1rN1BSc2M1OElOUWZBV3VWbHBDQ1JoaWNPVzA1?=
 =?utf-8?B?U3JXRVlsNWJjVWdJR21FNkNJKzUvU0plZHFuYWltV1lpTG1RQnV2R1hHMEN4?=
 =?utf-8?B?Zy9ld2I2MEZGbllDdE1aRUprRERkZG05dFgrdU5FT3ZtQ21odUM1M0JObGlp?=
 =?utf-8?B?OGR1OWZ6VHV1MVNpZ2M0K2VhblgwcXA1a29CRHBjUlNSemdLeUlRRmEyVHFW?=
 =?utf-8?B?bDlTTUUzeE1IdVpibkdJekZPa3RCc2NJTkNPc0cwN1NJclpHUzVqZG5XRDhr?=
 =?utf-8?B?SitVSXJncUhEalhScTE2bWtmZlNzbXAzSS9GSmMyMUQ3TUg4ejZ6aW9SZ1Bs?=
 =?utf-8?B?MlJiWE82SjN5VWpDWW5Ic00rTDkxaE0vN0V1UnJOQ3NvaDJMQVlaaXpYNTZn?=
 =?utf-8?B?cW8yQ05vWWZCU3I0cHFudTZnbG53SUpWWDFKUjNVWkJDR0lzY09KK2ZzUU9M?=
 =?utf-8?B?bTZrM0Q5NDVaZlhDeEh5RWg1bGQ1QUs5Z3JscTVoZElPdWRrTWNIbXVQdUp6?=
 =?utf-8?B?OHBYR0VEcllLY1MzMDdkOHpkSzd1N3NOZllXTVVacnpNeHpXL1dXa3czaDY4?=
 =?utf-8?B?bDBCbFRxMXgrMU9FazYrOWhSMzRMVDZ1TVUwQStINlZYU1gyYVI5SDRtMnA3?=
 =?utf-8?B?bldwL2M1UytXdy83V3U1WDhlckdhVDBuVFdabGFEZWk4RlB1anZaKy9tb0J1?=
 =?utf-8?Q?aR9cTttcJn9lEVoZf9559WwPTrCBRnFUHsAluQ7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E0B25E012F0AF4D8544CE28F3D8786D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15076ebb-46fd-4875-f123-08d93587b69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:12:04.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xR9uitKFpq5aIj6/nXnFkTx/kCQdmM6XqLOe61EY9Ftk+BhOUb3mNien9ldd+x34L48r9Z2O3Tde2M1fu4PAWRYwfKYzBTvc579Tt03m0uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3880
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDE1OjE4ICswMzAwLCBMdWNhIENvZWxobyB3cm90ZToNCj4g
RW1tYW51ZWwgR3J1bWJhY2ggPGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JvdGU6DQo+
IA0KPiA+IGl3bG1laSBpcyBhIGRyaXZlciB0aGF0IGhhbmRsZXMgdGhlIGNvbW11bmljYXRpb24g
d2l0aCB0aGUNCj4gPiBXaXJlbGVzcyBkcml2ZXIgb2YgdGhlIENTTUUgZmlybXdhcmUuDQo+ID4g
TW9yZSBkZXRhaWxzIGluIHRoZSBkb2N1bWVudGF0aW9uIGluY2x1ZGVkIGluIHRoaXMgcGF0Y2gu
DQo+ID4gDQo+ID4gQ28tRGV2ZWxvcGVkLWJ5OiBBeWFsYSBCZWtlciA8YXlhbGEuYmVrZXJAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5n
cnVtYmFjaEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVjYSBDb2VsaG8gPGx1Y2lh
bm8uY29lbGhvQGludGVsLmNvbT4NCj4gDQo+IDQgcGF0Y2hlcyBhcHBsaWVkIHRvIGl3bHdpZmkt
bmV4dC5naXQsIHRoYW5rcy4NCj4gDQo+IGY5MGM1YjY3MTU1YiBpd2x3aWZpOiBtZWk6IGFkZCB0
aGUgZHJpdmVyIHRvIGFsbG93IGNvb3BlcmF0aW9uIHdpdGggQ1NNRQ0KPiAxZDI5ZWQwMzI2MGEg
aXdsd2lmaTogaW50ZWdyYXRlIHdpdGggaXdsbWVpDQo+IGViNjlkYmI5NTVlYSBubDgwMjExOiB2
ZW5kb3ItY21kOiBhZGQgSW50ZWwgdmVuZG9yIGNvbW1hbmRzIGZvciBpd2xtZWkgdXNhZ2UNCj4g
MjViNzRmMTg5N2M4IGl3bHdpZmk6IG12bTogYWRkIHZlbmRvciBjb21tYW5kcyBuZWVkZWQgZm9y
IGl3bG1laQ0KDQpGb3IgdGhlIHJlY29yZCwgSSBkcm9wcGVkIHRoaXMgZnJvbSB0aGlzIHJlbGVh
c2Ugb24gS2FsbGUncyByZXF1ZXN0Lg0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
