Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52BF40F24B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 08:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhIQG0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 02:26:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:56041 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhIQG0n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 02:26:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209964709"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="209964709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="699323558"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2021 23:25:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 23:25:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 23:25:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 23:25:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 23:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQtkfupA7/9RMI/Vd767tXP51to9Z2ZTv/kRPAITQH2tIB3ALFiWixelnuAcaW9Dj7CDp9jVjdn9l6TJ9YUFFaj//X5LeQA46U8Az7vv1TUeZwtDHPVJ2OFBbVeB80Z8nuBwPSq63/g0ZdBdYZWTt6ZnlZlVngxtBKjY8B0YZpxAWaD4/QeO2dhMgo0ViDz3v06SRma4wcoaQ6qT/dwuEHpAknvGvSk22FXpAD6xAmYVHBEtQBX95Ui5Kwh3zzNh3vyb+0So+idE/Ih8DlMTFF3obloAOqEZ/LvLNDZer5/G7aDKOx0NtaCEr9uYXUQZ+T2lXmgR4bRFUrYnQiteSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n4MCzK5ZRwNDaPnHbp/2M6+PthPrSNnz6gy2p0pI1cQ=;
 b=UnbK6HzxyBNp1K2eC7TUiYr2kn1RFm/1kl9Bu9VcYNM6ElrLRm1aeJx/ImzE1zWoa/x8UlhLtoBhetyy0Dk5iLzQaQ0wTuSrGDxb2lWHrC2K6/nclopJqVIVfAYj6ev6mSBB51yZl9F2THXouUdc+qUYQn6wfUrGcvVI0p4xN5e9zWgMEJHro8aMriTyy4jcVOiqfSUYn0lw4wEbgmZHpbCgGyxhmqKaP6QT6ZNXuGjMIBV5NHa3OdZ9AnC4s1S7C/4ZWP24nCJgiiiGiiP8CV0NNYKq/DcsEp1Kvvjj24lFMCmdFw/1ahgC5IrCv8tsSBpYA9yPr8kqiTreTsjvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4MCzK5ZRwNDaPnHbp/2M6+PthPrSNnz6gy2p0pI1cQ=;
 b=RYQV2fGFJKy1WsVwpZQ80gfwBqF5XVMoKI6gkeXO8WkzdJHNw+UatkZpSbY2Y8zqyTNhNRuJBOT6M/uDHUzaM+Tb61JLe84J9eIzU14cXjjrHo7crXPAtYWcZPtv0U5TrFLIAggziFfEI6yGX5JR7eBcpjnOpl2fjdo7JQ7q49Y=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2774.namprd11.prod.outlook.com (2603:10b6:a02:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 06:25:18 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::582c:29ff:d42b:ac52%6]) with mapi id 15.20.4523.015; Fri, 17 Sep 2021
 06:25:18 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Goldstein, Naftali" <naftali.goldstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Sharon, Sara" <sara.sharon@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Dan1.Halperin@intel.com" <Dan1.Halperin@intel.com>
Subject: Re: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
Thread-Topic: [PATCH 1/2] iwlwifi: mvm: d3: Fix off by ones in
 iwl_mvm_wowlan_get_rsc_v5_data()
Thread-Index: AQHXnkDQZ5ZBaUWHUEeHaTyx44CrVKum/ajqgADfZoA=
Date:   Fri, 17 Sep 2021 06:25:18 +0000
Message-ID: <5826089e7d9e75319ef0644945832285a7ab314c.camel@intel.com>
References: <20210831081802.GA9846@kili> <87bl4sxxgw.fsf@codeaurora.org>
In-Reply-To: <87bl4sxxgw.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d41e9fd-fe9d-487d-e73c-08d979a3eb65
x-ms-traffictypediagnostic: BYAPR11MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27742904CDF2CF2F8D692D0F90DD9@BYAPR11MB2774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxDuA/E0QoP2ISZBC2PftRO9j1F/rpcqLRH+Ra0Ko9ius+0x+ytR/ngm/I29+ayGa3G/KeMVOhwOMCw/nEHKrAl2HtKcFcrTQaIwUdJMuhl7LEqJyEroCcIK6YG/kqqN42PVE6yxdh0AZutFa6gfP5o7DlorLtkxoxA2sJN+DlxvadjYcclM5cTs7yKHkLD7hUrjC0NhYWc/IITj2iryBVFYGZ09EiWA73MwpUzC0ijnXL/NJOAnOpzyP/hLX0krcdZsmYCp4LWkc/BL4FKHr/Eu5x0oeNqMujFDCE5zVQ7IufikSLnm4G8T2T9n55bw7XZf75gKLnLEPD3qq0aa6FXY1fakBOTfUE9uiKYzs0C02MDnFwpHggkynbUSwQIEZdQP2wv/zFM1RaSL0Acxy7QWgt67F8kachynVDOgYGfhkdFlu6oHrZBjdlLcL7DG9h6EUgbgHTkfH9tXlTC6E8OYfXQVYws8wfnN6Qj3vJb9xzkw6E0RrnC0S9rPKkDOswdlJPCRCPaF09tL+K4xhJWFWPaHdChg8DzUS1ThIV6gVL6deB7CQwmJniij4aE7XdEYgA1OXga1M/kwbXH8zS0NVrnQDWh5FTURahc5VR4zRDo16RoGAn005/Kt1BiSoj0GePJdKU04Pg7FY/eJ5qHR/Ab6LyAaqFvkoBTES8bKQ4lOpAeh0b4hD9aPzupCA8YqIqDSdkJnJpPvjS2A1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(107886003)(38100700002)(110136005)(122000001)(54906003)(38070700005)(6506007)(66476007)(66556008)(5660300002)(26005)(8676002)(186003)(8936002)(66446008)(36756003)(91956017)(64756008)(66946007)(71200400001)(76116006)(4744005)(2616005)(316002)(4326008)(6486002)(478600001)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjlyYmhXcEdhS3RaU2M5eXJEUFJwS0RjdHFJbHVnM0FoOXFaVHY4MGdaczgx?=
 =?utf-8?B?V1VzQmcwbVNrUjMyWU9oMk5iTHVEUVphVG1OSFJqRWdvT2lZRjh5aEtPOWtj?=
 =?utf-8?B?SEZkb1Ryd2l0NG15Rk9JREkwSUdGMHVwYXJmOUtrbmt2SEhWZzR5Y3hhZ0U1?=
 =?utf-8?B?S1JOdXpiT3h1c3pWNjgrQ09mYVlFckhRVXI1ZkVMbjlXbXhqZGZLMC9kVmJ0?=
 =?utf-8?B?bks4UmIwQ1p0bDNRNjJDL0g2UVFLY0RySFRiODlHVG9lV1MzNEI4NE5TcXdK?=
 =?utf-8?B?eCszcVFLUTAzMC90a0oxaU53MjhMZmNMZGNkTE45R1FXditUS3RMekR3clps?=
 =?utf-8?B?MVhiclBoa3hlOCtzT3NQYWo0dnhRMVBqOTVGcFFMRWVXajREMGxNSE5OOUhZ?=
 =?utf-8?B?TXJQb00wVXVxU1gwNDZURXg2dEFJeUNrT1RBYzM0UkVzeDZKenQxMkFPbjhl?=
 =?utf-8?B?UGFrZEZkTjhZV0tGR0Y2LzdBUEx1ZW9FOVdkM1B5dm1QakMxTGJCSElPT1hN?=
 =?utf-8?B?anhzSHY1Y05keGtLWktReUlZMnU1QWdualhmMVNtMjI2d2RDVkRmRVh5ZUFq?=
 =?utf-8?B?ZFFSdzNBWXVEcUV2VDZUR1dpa0lQYjhNd0I5S09wU1gzdkk4MklHaWlMWCt4?=
 =?utf-8?B?WjRDZWhvcmxsaGsyUFRhNkpoN0xvMVNtKzhteXpqbnhnMzJJZXYvZXJOWm5Z?=
 =?utf-8?B?VDN0K3liNCthZnh2QjNEb0FxL21wR2xNTzNlQ2p3UVVVYjJmSFFDMXh0VjVs?=
 =?utf-8?B?NVZWbVZ1UDc3UEFsbjNySU1DNlBMMUJjTXQ3VXJxVUI5ZkUxcUJ3VXFicld5?=
 =?utf-8?B?YWdPaGIvUVdCTXRzd0ppanRUMmprMVQ4c1pqZHJpeU5BQXhGcHFTYThpZmkx?=
 =?utf-8?B?R0NPREtoZlJhaW1ZaFpiVWZlOUFSR05CRk5iR0hWLzNSdzY4cXVFeUR5a2d6?=
 =?utf-8?B?bWsrZlRmNHVCWnQwWTA0Nk94ZXdyc2E3RnlOcGNaMHoydU1SbWp2MVVEY1Jk?=
 =?utf-8?B?aHdGYktOWjJDZzRzSFFwWER6YzZpR24wa0xQMFlOMytmZkg5WVFVVDg1b2Ru?=
 =?utf-8?B?NXlLUmt5U1pwME83bkczd3VKdUN2N2NkV1RVM3U0S2lYWkxrSXJrOUZBWDNv?=
 =?utf-8?B?Y2F4NmNlMzZoTGN0elJlZ2YzS05MeCtmNXkxWEI0RlVwMXV4b1NTeXptSU9L?=
 =?utf-8?B?ajkyTE5aMkl5UzYrby9ZcFBPbjRLQ1UzbDJ4ejFTbmlza0g2UHhZZENpTTBH?=
 =?utf-8?B?V3lGcHh6Z05GQitsUnRUWW01YnQ5Q3RKYXRBaVJCbDJxNytqMThiTGVlUlNh?=
 =?utf-8?B?dHdSbEhmR2NubjFHV2ZhZ3lpVTBtNzZBVEJoeW11aWs5V3grc0NKNE9GVHQ2?=
 =?utf-8?B?eFZvOVhSVlRXMTh3S0FkNStUVmgvZEpjWGE3VXJieE05UloxVUVJb3cwSVBm?=
 =?utf-8?B?R3lvTHBqalNzZGJZejVqZVg4VFcwM2RGNHNKQVBxWnhMRjBqZ296U0ljY29x?=
 =?utf-8?B?Kzc0Q1E2UC9LN2NWcVFQd1JxODVBSmVDQ2RjOVU1MFBBbUxyc0ZFYjRJK0FP?=
 =?utf-8?B?cU1FcnpEZkRNajYvRVhEUlQySmtVWjZiMGpUYWZ3VDJSS29ZeWdkRVVpajYz?=
 =?utf-8?B?cnZRRFFOTTh4YXRjRnFOcG9NSy96b0s4OE9nN2xlWjZGSDl1K2Ixc2NHTFNT?=
 =?utf-8?B?ZHRTYTQvNkowazNVUFpoV0RXN2xmTDBIdUVYejB4RTY0VmJhOXJsdGdNWW42?=
 =?utf-8?Q?tHx04EoVrDqjCB/VrHkC6GbzrRX/efcuhdlIY0l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7326233BEDD2D94B847752100C12C10A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d41e9fd-fe9d-487d-e73c-08d979a3eb65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 06:25:18.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z55vjzDTY0Upn77MjInD9QdoKJDV94fckRxV1aQzcgcxHeTQHcwxzyfHeE1bZcOS7QzQwN1PfwkdQsewoxQv/AIH49ly3WDPTps03uqsdFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2774
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTE2IGF0IDIwOjA1ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBE
YW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+IHdyaXRlczoNCj4gDQo+ID4g
VGhlc2Ugc2hvdWxkIGJlID49IEFSUkFZX1NJWkUoKSBpbnN0ZWFkIG9mID4gQVJSQVlfU0laRSgp
IHRvIHByZXZlbnQgYW4NCj4gPiBvdXQgb2YgYm91bmRzIHdyaXRlIG9uIHRoZSBuZXh0IGxpbmUu
DQo+ID4gDQo+ID4gRml4ZXM6IDc5ZTU2MWYwZjA1YSAoIml3bHdpZmk6IG12bTogZDM6IGltcGxl
bWVudCBSU0MgY29tbWFuZCB2ZXJzaW9uIDUiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gDQo+IEkgdGhpbmsgSSBzaG91bGQg
dGFrZSBib3RoIHBhdGNoZXMgdG8gdjUuMTUuIEx1Y2EsIGRvIHlvdSBhZ3JlZT8gQWNrPw0KPiAN
Cj4gSSBhc3NpZ25lZCB0aGVzZSB0byBtZSBvbiBwYXRjaHdvcmsuDQoNClllcywgcGxlYXNlIHRh
a2UgdGhlbSwgdGhhbmtzIQ0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
