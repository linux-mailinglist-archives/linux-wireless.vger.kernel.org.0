Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF54360996
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDOMhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:37:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:54732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhDOMhd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:37:33 -0400
IronPort-SDR: c3yLz9tE/R06RaLUC0/IXkl+WrdZStKWYavRtjZFbI4fyKyFr14t1Qh2GXNgarXhMmkZkcywLv
 5TtWfjXYETbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194870021"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194870021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 05:37:07 -0700
IronPort-SDR: kGZjqCPIb7iqw/d6RNV9+370Uv0SK3qeL9bkczTzabiPo6bwSUKpdSbT1XOkU7BGm7Fo8Iy0qo
 YCziOBohxyqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="425163201"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2021 05:37:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 05:37:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 05:37:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 05:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CopSf4Z1yfYy17K/Itw476KkSL+Ay+2NuDIMhI/L34Dt4cwXohJ3PTy+lzajjvXTZ9RgYVkMrXywlInSocaR6oHE4lyNchOTyanQmIADnM8dXHLeTOQrAKFt1c9Iq7qQUhHlPMy2XGCat4BKWqa9Z/QdqD+ekcP4z79V22by7Q2PdGl/4ngKCv1zf49v2bIFaHyeG9focwyUOgkl19DzfEdBTpcv/jjkV5lTH65ufmUF1PA9SjzJhC7mTwBnv9ykH9PyXupV/1fw+4NRi7+QSiaegH71NQpzuF6kVaSABIhe+OrJcffNULc0jqM/JOeAct9WElKiUoR2WNyATuuWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFLBujJ+o76t495oWRFqMqS+pqJjqHGoANg5QkGEsa4=;
 b=AWcIvQvikq1xRuW/XB0KGCP1L60ySFFRX+qN7A/cDwYVkgfgSIwL9oHjffNahrUTjzsrVtoNMDF+AC3z/gw9YKvM2Jj1R1nq7CSd3UZpse2ckFKQJ8oZBeCY6NynB4zciAHwuRmGZte738s4wNEY/KvVJnoD6keM/ZUbADhi10Df/L/EKvBUvF0QEKlvOQ9JFU18OK8+y0QmWVQ6MSp+ns4YKxfmW4TBrTvWq4Zf6W1ZAnmOuNGoe+l18EvsqRqQmRxiJ2ruClFVXKAWpCODOiF2zYQnLIH0YAmjy/J2bqUy3gK07B7QJosAgwWYwolFrqXoB59/9nzOs0MO684y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFLBujJ+o76t495oWRFqMqS+pqJjqHGoANg5QkGEsa4=;
 b=RMixczGvuTzIwb+xb6/+6/eawbRnDsPCK9HZp3Q6cxH0LFehI3wxiwWmngUV4HtQwTGj5GAHNbih4s4zQwO5Ndto94w8H1iLjqb6OBjNzLM0mOTJj3YIwbw2L7/xPtDvnE8mYNPNSqpofncG0gNNMpYGBu5uHYFEw7kgctsrxac=
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 12:37:05 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 12:37:05 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Topic: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Index: AQHXMe+RUGJ6U8HHjEyOqMg0KcytCqq1f/jpgAAEO4A=
Date:   Thu, 15 Apr 2021 12:37:05 +0000
Message-ID: <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098)
 <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
In-Reply-To: <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 133cac5b-a539-4bae-e738-08d9000b2d8f
x-ms-traffictypediagnostic: MN2PR11MB4743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4743BDDF3BBC6EB5652EC90A904D9@MN2PR11MB4743.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BaAno9i+FcXXNI5LXwU6By6f1y6usumATJvbQKwzqDdRcCIYO2loT/hGgC+zZI8u9kCZhZQTJAvbWIT5xedtj1AzVLm08rvTn0Xh/aWsY2wcwp/ugdBRlanYQGoCNdrzSwqmpXrz88DX0nL6kIptL3y0TJHxAAE0dE1X5A4xSC11pU5h5BErnfmhoWDVcdxxx1i0ieuON7haeA5rLT1pq3r/8iYmBIwPizKYc3SOZSBAgGltUcUBW68WXYbglfIQFM2A8lEQDaDvLRIx30YY/o2Y2Bkb0tDp2ybbEt4/Gcmn97FvltKZdQdSPAMIBGNgSXaN/qOux7FO6wt+w87b8L8sWF09ftDIFGCIDJB+JlVIGGtGWHmkjUToamJC0PWClog1RTLyhrYDYtSVf8Of1hKklIvX5xaZxd9zMeC0uPXCn3cIfNU4kzJwaI3PpUbh7o2GpR9ZexTsv6ipphtLsAlKJwp+KDGJTMeLJQUKqiAjz2pRuGylZ12ex8fN0zOsA2MjwI4p3OF0MCRqToxvW/eg6E6IZtQTQCOhRZWkbb9k1+flZqn33NkBpeH7ccRFRI39QDR40QphCSPL+JGoDa3XTUB2mPVt3GdaXogHMCQ6OYML6IeCAq3YHCDgy4xxZ5IuGS/2KutCty03JoT99PEe7uJt4c4emISP+jDQUfa629jIcWxfPmS0k36cSvib
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(83380400001)(76116006)(91956017)(6512007)(966005)(38100700002)(66946007)(4326008)(66476007)(478600001)(86362001)(6506007)(122000001)(6636002)(316002)(110136005)(54906003)(2906002)(8936002)(8676002)(5660300002)(71200400001)(66446008)(186003)(2616005)(64756008)(26005)(66556008)(6486002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dS9ja3p5QTUyMEhMV1I1VkI3UTVveFI2eXdlRzNhUGRtbUNLcFpKYWQ3UGJK?=
 =?utf-8?B?ZlhYMFZiQjdVYWhaVFY2ckYwM0FJb0tIZDBKUE5YT3Q3RUFQUHlzTDh0WWJn?=
 =?utf-8?B?ZExWYVRKanp0Mm5uQnFDc21haWJqc0JxejNxNEtvTnEwSWl5cFV6eW1CdGl0?=
 =?utf-8?B?RVlsYkNHMktxektibGtlcnE1aWQxSG5sV3FQc3JIcHNJVFpzdkZEK09SMXRt?=
 =?utf-8?B?YkxkU0laRSt3WjczTTZsQ2tTQWdtY3RLRkg4UXFpUWdKdW15b1d3SnZ1eng1?=
 =?utf-8?B?ZWNUaFlZdVZPQktJRUVFT0lieWE2S1pwcWI2TzI5ZFR6dlRPa0lZcUhIQ3M4?=
 =?utf-8?B?RUVLRnVMbFk1bDlHT0syNWpGLytDOFpCZUcwVzVzMTN6VTVSVWVrNXZVU3pT?=
 =?utf-8?B?eVdiY1FHN1J6OEpiNmZoUWZTc3JSYmpqQTBBZG52RitXSWJ1VDVYU002SEZ6?=
 =?utf-8?B?UzVFM3h3K2xtZWRua3FxZkhFRVlQd3J2MEtXTmpIS0t0SVpRR3dqWWVUeVZE?=
 =?utf-8?B?ank5YkV0ejNkTnQzZzYwVk5qdFVPamhiOWNXMkthZ2NORVJQdTNXQTRSYnZM?=
 =?utf-8?B?NzAvd0JDS0YwNkhTWDJoVnVzL3FSRjd5MFprL2RWSFU0NER2RENpREtROWtt?=
 =?utf-8?B?WXB0NS8vNHZtanVMNlUrYS9Tdkx2M1l0OTBnYk0zekszdVA3TmVKMnFWSjVQ?=
 =?utf-8?B?Y2Mzdnk3Y1Z4a0d3Y3VzcGNBc2xEYk5JaGJCZjNZcU1Jd1JlQklQYkRmbW9z?=
 =?utf-8?B?bUpzNzVUL0VadTBIQjJUVXdUTlNCZW1TYzRaRlBjM3lWb085Q2x2cTZaT2t5?=
 =?utf-8?B?NG9WRExsN2gwNW1aTElnYzhIclBZZFVxSUpRRWZ6R2hNMEFJWW5SN3hkMFRC?=
 =?utf-8?B?MldxdlduNlZkVUxxaUIxcWt0QkFuc2laZlZDZVNmNjk1amJPVm5MVFAzVHBC?=
 =?utf-8?B?WW5FMHpEYW1rcmU4R1M4VXA3Qm56djhVZkwzd2RTUXZBYXdWNW9kVWVFOUZG?=
 =?utf-8?B?bUVyNFBKblpINTllQ3ZOTURqS1JhYWU3Y2w3bFJaa3g2Zjk0MkhOckVPMkM5?=
 =?utf-8?B?L0E5YUFWNHF3RTdVb3hESS9vZmpMMXE4WWY5T005NDlNWVlxU2xHaDdQTWhV?=
 =?utf-8?B?Q29LNHo1WmxWajIvNHBNckEraVZFNE5IcmxCci9jb0tEdEFpSC9YaG83bU9t?=
 =?utf-8?B?ekRKN0p0dnpLODRYQUNjajhWLzRCOTE2NWV3TmdDTm9JTURRb0Q1aDhNajFR?=
 =?utf-8?B?ZnlaZmRacXQ3RWhBNEFvWGhFNGw2VHZSb20zWUZzYmhUR21VVXhnWTZGbk11?=
 =?utf-8?B?RGxScjdQSGUwVkpNVS8vVFdobDdQaGovZGxldFFJNVRiWnh0cVhEM3l6Ympr?=
 =?utf-8?B?WUVyTlpIMU5naTdidHVDS1o3ZWFKTlNCb2dhQyszTnkrSjBJWm1scys4dHZX?=
 =?utf-8?B?bmhyMGltaHRpT0FjWnd0cktPaGZXMnZxcWNBSmlvWkd2S09SWjEzOC9aeEpG?=
 =?utf-8?B?aVJBZUdDRy9JMlN5TzlHUXIvL2p0MXRGUng3KzBVSXNveWNrWGRYMkYxREI1?=
 =?utf-8?B?QjZWNHN4d1IxeXAxOCt2c21KK3VmNGJtenhSYXJTU1VYYTV1NnVsZjl5V3pM?=
 =?utf-8?B?WFB4NU5TKzV5bjRiWDRuejNoYWpsM1hIeWRxenJKanl2RDVxK0hnWkoxZnZL?=
 =?utf-8?B?NGIrbE55cmhGQUNPVUZ6cFR6RHoydDlpbnpPK1BjMkxPWTFZa0hSdUhLR2xL?=
 =?utf-8?B?b1RPTXpEaVJqK0FaSEt4aTNxbUs2R0NHOTA0RGlXYU9mOWhtS2xXenBya25V?=
 =?utf-8?B?dWtRcVNRVkxqSE1JTzNBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E1E816862DF845BE2A441FCE7C7938@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133cac5b-a539-4bae-e738-08d9000b2d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 12:37:05.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOlfWAVHX7k6Ku4PubbWgFz6akYlKvlEqIy2/fBngG3xAUGN0mVTJufFh3tvQVM/Jmdp5zZqAwEqpksYYRUX/gIyntOXuWYIQH1NKf2qGyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE0OjIxICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjEtMDQtMTUgYXQgMTQ6MDQgKzAyMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6
DQo+ID4gVGhpcyBmaXhlcyB0aGUgc2FtZSBsb2NraW5nIHByb2JsZW0gZml4ZWQgYnkgY29tbWl0
IDI4MDBhYWRjMThhNiAoIml3bHdpZmk6DQo+ID4gRml4IHNvZnRpcnEvaGFyZGlycSBkaXNhYmxp
bmcgaW4gaXdsX3BjaWVfZW5xdWV1ZV9oY21kKCkiKSBidXQgdGhlbiBmb3INCj4gPiB0aGUgZ2Vu
MiB2YXJpYW50IG9mIGVucXVldWVfaGNtZCgpLg0KPiA+IA0KPiA+IEl0J3MgcG9zc2libGUgZm9y
IGl3bF9wY2llX2VucXVldWVfaGNtZCgpIHRvIGJlIGNhbGxlZCB3aXRoIGhhcmQgSVJRcw0KPiA+
IGRpc2FibGVkIChlLmcuIGZyb20gTEVEIGNvcmUpLiBXZSBjYW4ndCBlbmFibGUgQkhzIGluIHN1
Y2ggYSBzaXR1YXRpb24uDQo+ID4gDQo+ID4gVHVybiB0aGUgdW5jb25kaXRpb25hbCBCSC1lbmFi
bGUvQkgtZGlzYWJsZSBjb2RlIGludG8NCj4gPiBoYXJkaXJxLWRpc2FibGUvY29uZGl0aW9uYWwt
ZW5hYmxlLg0KPiA+IA0KPiA+IFRoaXMgZml4ZXMgdGhlIHdhcm5pbmcgYmVsb3cuDQo+IA0KPiBJ
IGJlbGlldmUgSmlyaSBwb3N0ZWQgdGhlIHNhbWUgcGF0Y2g6DQo+IA0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC13aXJlbGVzcy9ueWN2YXIuWUZILjcuNzYuMjEwNDA3MDkxODA5MC4x
MjQwNUBjYm9iay5maGZyLnBtLw0KPiANCj4gTm90IHN1cmUgd2hlcmUgaXQgaXMgbm93IHRob3Vn
aCwgSSBndWVzcyBMdWNhIGNhbiBjb21tZW50Lg0KDQpKaXJpJ3MgcGF0Y2ggaXMgaW4gNS4xMi1y
YzcuDQoNCg0KPiBJIGFsc28gaGFkIGFub3RoZXIgZml4IGluIHRoaXMgYXJlYSB0b28uDQoNCllv
dXIgcGF0Y2ggd2FzIG5vdCBzZW50IG91dCB5ZXQuICBJcyB0aGlzIHNlcmlvdXMgZW5vdWdoIHRv
IGp1c3RpZnkNCnRyeWluZyB0byBnZXQgaXQgaW50byA1LjEyIHNvIGxhdGUgaW4gdGhlIHNlcmll
cz8gTWF5YmUgaXQgbWFrZXMgbW9yZQ0Kc2Vuc2UgdG8gd2FpdCBmb3Igc3RhYmxlLi4uDQoNCi0t
DQpMdWNhLg0K
