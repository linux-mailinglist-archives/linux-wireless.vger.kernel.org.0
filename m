Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240D344E3C2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKLJ0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 04:26:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:8241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhKLJ0n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 04:26:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="293929606"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="293929606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 01:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="492931281"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2021 01:23:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 01:23:52 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 01:23:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 12 Nov 2021 01:23:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 12 Nov 2021 01:23:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f59lfI2PBNRiFuBkQZPY6QeXdSWk6nSjxrOlHaxGUAuoDQDjeWwapc2dw3qvWJj7SOz0S3IhcLXy9dJTwkToV5WSakOVr7SIBiI2R+pIdFf32gGJ6O/tQ06G2uBxW8I96cDBDgbmy8vKmC6m3Jzj+coKQyBIrIarrWTKIcbGakIZu4k8pEgwhdEmMfj1w4hibVsk1iaMC029d/ur00HVGVJSOMdSstZJUkVMFfSAMJ2zV2g43E0nxpBmTjbAw5lpRjcyGD9mBC5+TOgdetyWO6r8GH8ay4rg8yG6UN/on3YUBgTnDqwMbIzY2vpprxFw7ib9hcdixz/iDzgi8mDlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T6nVAplD5laMOD4CwV9D2qWDLGRuDQPV0/GxNR5q9s=;
 b=cjwAmBy6oRBFkCA+ezUFJgSCU/EYyaQVaabuJeERgrk/6iOAocdXco7W9z9vuhwHGQAb3NzVKY0KG0JIzq3ZjQjX0I5p1S2ss15/BiB1oOL7t2OKueQZs4vDojXglv5KoZ1ybN1zLI1XY2q9al8Zk0pnwgO85xsdseXkz6hHk/17CW0U1ahe3QGrZU5CRyA5NGuJcOg9kfwCVkysTgg+z2WIOtv9TjXXtgYwTJoBn45rE6i0d9LKTfFCiZvTAOUl9IdcPaLwPfeAxUC0m7DDt0sxT0Tgv4kzjSjc/0hKw02W1z7q3wzAx4tKVaaQWLX4xcfHw0nQKD/ZldC8IGi0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T6nVAplD5laMOD4CwV9D2qWDLGRuDQPV0/GxNR5q9s=;
 b=EM8aD3oDRiEAJgM3CZLzD0cCvy5m0k0IB3Si09ryP6+Lu9bfyvy8Nk0IbdD8SUqvchfvLU4v5c/cJc0wfUnZxvSXF1XlNdnRw7oEiuaMEOvB4UlcrloZITPDnotW9bwtzl+9ZZaVsIWZZtckRIB8O3XmYBQ7Qnw30n40Zta950E=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 09:23:51 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e559:d4e6:163c:b1ae]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e559:d4e6:163c:b1ae%6]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 09:23:50 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "kuba@kernel.org" <kuba@kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: Fix memory leaks in error handling path
Thread-Topic: [PATCH] iwlwifi: Fix memory leaks in error handling path
Thread-Index: AQHX1s0DSGCYmrDNHUCDkuL+8Bv09qv/oGWA
Date:   Fri, 12 Nov 2021 09:23:50 +0000
Message-ID: <6e614fd2baedaad4670c21af8f6dea545218266a.camel@intel.com>
References: <1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13daff83-7c6d-49a0-c7eb-08d9a5be238b
x-ms-traffictypediagnostic: BYAPR11MB2854:
x-microsoft-antispam-prvs: <BYAPR11MB28543E0237B94B925BA6533890959@BYAPR11MB2854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0kow2O9kxAJS8IMdk9nctWDkwMljHw1T9zSTuE58WIZLk21UoVLNvyG7acrcDYLZ3jNicdqZqImQwxIb5WhUdCYrLGAbh+DLZ77fAGfHEIAfAXDwKLjQLQ53w3yjJ6BjldCT/o8m4Kq+EnyfnmcrBmFagT/SSwsmRONLzA56WKMizTVpN2tlCIzmOvIkJYqRFCPUEnU7F1hqGwrgMGJ/my4otrTXPrl0fCU1pqMoeJHErTa96ytEwhoF08u/F4AxAVyLK8wnkhsw7PLIsLhub2K5COCCKQolWMpg5kpDptj6cXYcl9xb/+UnCvoSm01iLKDO/GahTZqOrXxijoaBgwMOe/d44zwoIjOXOH41dfDpx4E13y73zntxZngCTJneCgwr5QXE7yo1/mbsDfmLXwCLQHR7Wth1pB+hF8owAdmvF2ntoZHcJ6+KqBHIkasLJOJfs3AfRfrvWdLs1pvwMIpmVsA+ruKqo4VnA4qVEmCoD1JUpfIFJeNKVbzIpe2vIzTjOo7p/9b46NeNd2q9NuVd763d/Y8wFe3ahjXv37iU4znhforY9KsawGJgWTOx2s7UR5m3gl00/GHbCHakASE1XOi8ETJVJAzsd/U+tYhmvEUvUihu7wvZRxprzk/mDGVhDP4bcnknxbRAmiITuznpTfBIH3rivmGQ6kdAXc6Al1852iAlX4f9rny3COyOMMIITqi3hQNsDdDdEnZbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(4001150100001)(71200400001)(6506007)(36756003)(83380400001)(38100700002)(5660300002)(6512007)(8936002)(2906002)(86362001)(2616005)(66446008)(38070700005)(508600001)(82960400001)(316002)(66476007)(64756008)(66556008)(122000001)(6486002)(26005)(186003)(76116006)(8676002)(54906003)(110136005)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXAzR1JGck5JSWdEU2pRZC9uUWlwQ1ZmbzNoRHV4SHNzK1V5dExHRWNtWUlu?=
 =?utf-8?B?S1FMTGE3RkUySmlud05XQnJseVZHU2Q0L2xZUVpvelJ0VHB4ZksrVGFCSzEr?=
 =?utf-8?B?WHRTL1R4L0FJMFU3Wi9QOC9hbUhKT2w0Q2RxMTdZb1RIOUM4L0kza0dpTy9B?=
 =?utf-8?B?Q05xb05JaExubHMzOE91L3RKRDVvYVRLZDlPUVdJYmx6cmMzT0NzV28zUEkv?=
 =?utf-8?B?N3ZkMkFyY2gvZ0hzMlB5QWlBY2F1RzBiN280ZzI2Q1dOeFBmdHJRNlpqSzd3?=
 =?utf-8?B?bi9kbS9WSFZQUC9POUtUeXc2NmhqeTVXRCtoS3FyYmxab0M0ck1TNjZML3Y1?=
 =?utf-8?B?WEx4WS9HUDJQMzNEU0Z1VzJlOHBHZzZEWm9jZUhITlFzc0lZS3FpNkVGVjdY?=
 =?utf-8?B?WWZ0THVJTERybnVBakFpbzdFdUhxTmRQTE9BWkduTWppNGlpWXBEb0J0Tnk3?=
 =?utf-8?B?MG5LZXBHTTdmZ28yZm1rbWhoOGJXbmZ4V1NrbDk4eTlJYm1XWjY3bnZnOHJm?=
 =?utf-8?B?LzZQZThyN0V3QklhSjZKc0c3c2JNN3lTRU9LRzZhem12Qld5VDAzZXNaUlFp?=
 =?utf-8?B?RVlPSXFNd3Y2NzhNdmp6cjRHZXNXV2lBaWFrelBNUTV2N3BFNkEreFZSKzdj?=
 =?utf-8?B?NDNtWVBBMWxRR1MzNXBETTIzbitHT0hFZ0hQaUZTZHlySitIelFBeTFnWEFD?=
 =?utf-8?B?NmxCdWNKVEFSQ1Q0OWVYdUJzZnB5alBuRy9RV0pRNVJOVXFNTElVeEd3RU8w?=
 =?utf-8?B?c3NGelFKSmxVcW9jb0x5bGZ2ZExJWE8vOWlpZ0xPY0hUSHBQRG5CNXFEZnlv?=
 =?utf-8?B?Mk40YnNRV3hSWklrZFZLSFprY2gzU3I4TE9UNm1BRDF0Tmk0TUFBVENsNFhj?=
 =?utf-8?B?dEt5SUVac0FOUWF6ZTRUUnpuMTkvWTREQXFXK3MwYkNkaVh0TExHdXB5TnZK?=
 =?utf-8?B?RHNZWHdJZ1JCQ1hCaTRtVnNvMHN2dVZYOXRlSzc4U2tjaVJHVkFtaGpydVZG?=
 =?utf-8?B?VWMrNGRzR2MyZFkxVlp2MVJ5aTRneDRObGhxRlZZVFFnWTFFTHV4T1V1ZVNo?=
 =?utf-8?B?Y0tCeXlwQlB0UDNmNkhwcyt2UWxHNVBDeXdpWk41U2k0WTJDZXRaZGVWVEt4?=
 =?utf-8?B?QWpFV3R5ZVAxVmlMdmtyRUJ3NFdRMzhteFZGanMydlAxbHNCOWR6OElNOUsz?=
 =?utf-8?B?eGVQZVdadWFrblBJYVV0MlJZYmV3OWFLcFBaZGNzN2g1ZWFGcmFJd1I3Q2Z1?=
 =?utf-8?B?NXFRSVdYdkh5dGVVRlZTVTQyemxTYkxuQ1IyUE1INk1ldlFDc0JKL0tXN1BN?=
 =?utf-8?B?SkF2cG1TdjZRc0dkVHZUa25wWjY5ek1GdXdqdGQyRWJOR29YaW1Jc1ZNcnJz?=
 =?utf-8?B?SCtGQjJobEF2NHRyaFpFVDBVSTV6WlcxOVpnMEJrMFYwUGJHeGhBcW5yNEl4?=
 =?utf-8?B?eUZsMGpvSTVzTFZaRUhRTXNFQWJ1V0U5dm9NTmlnREJBQTZHOVd3Ym0vR2ts?=
 =?utf-8?B?SFJjNFg3L1YrZ04zUDgvWDdnNnc5cVZTS0JteWhrcUVPV2JSeWJQaVpZU2dw?=
 =?utf-8?B?OUsvRHA1QUM3TWx5M1dIQVR6UytobEtjVEdTRUtQRm0yWXZWSlZWQWprc2pp?=
 =?utf-8?B?RFNxMmFHZGd0R09ISnc0b1R6RTB6Tk5jSUF6d3NLWHMwcHZWZjhMRU5FekxD?=
 =?utf-8?B?cjFFOFZuTEN4UlRIRkJGS0ZFVnpaTCtqTGxtbmtva25vT1orbUt0QVgvMGZQ?=
 =?utf-8?B?MHV0a214Q3AydFpMSUIyWXp0c0s5eEl0eWNNN0tWa2RaSkRTdGZFOWNRRmMw?=
 =?utf-8?B?a25RKzRESUVsUU5WQURNVzhGc0hZN0dZWUxXVm1wNUEwaEVSUlBKWWdxRkxn?=
 =?utf-8?B?YXJZaFZRQ0RBSkZaQ1VBTm9TeUlhblRJeFRBaWNGZUxoZDFiYVFSMFlKY3VN?=
 =?utf-8?B?WGkyb1dCTTR5ZnJZdm1JL0ViZGdQbzBkNERPYXV1YmUxUUh1eUU1NmNxNHFN?=
 =?utf-8?B?WHFiYlZDSzZ6QkRNK0JtYXY4dkthUmx2ZkllcXl3NmMxeGhPcHBqNDZNWm5R?=
 =?utf-8?B?eWlKZGJ1d3lySnF6cHlGMWFEa2FrUThwTVdMNDlLakJtQ2p6anV2bkR1SVls?=
 =?utf-8?B?d3E1c1RQRWkvcGZwWlJES2orejVsYitzaHQ5UENhTEJ3dnpsN2ovZWpWOU5G?=
 =?utf-8?B?cXhreVV6ejhwTXJVc3oybXN2S215akVRaFNKVmpMck1nZTFaeUM0d21iZy83?=
 =?utf-8?Q?6W0HSS7IgFSXeRxBqOiUqon6Z0Sj9ffBrhEBcwIiO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <368EEAE6C150ED42997ED7989CD705CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13daff83-7c6d-49a0-c7eb-08d9a5be238b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 09:23:50.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /q72r6ew04sVJSc6kT3czMBG5Smn9IaEVgAP+Ivh34m3ejQq8mY0xOzJVL3E0pfuJ6bCIHCYbyg8M+RCF9Z6wxyu37ozD8uT2j/5DM8dAtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2854
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDA4OjIzICswMTAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IFNob3VsZCBhbiBlcnJvciBvY2N1ciAoaW52YWxpZCBUTFYgbGVuIG9yIG1lbW9yeSBh
bGxvY2F0aW9uIGZhaWx1cmUpLCB0aGUNCj4gbWVtb3J5IGFscmVhZHkgYWxsb2NhdGVkIGluICdy
ZWR1Y2VfcG93ZXJfZGF0YScgc2hvdWxkIGJlIGZyZWVkIGJlZm9yZQ0KPiByZXR1cm5pbmcsIG90
aGVyd2lzZSBpdCBpcyBsZWFraW5nLg0KPiANCj4gRml4ZXM6IDlkYWQzMjVmOWQ1NyAoIml3bHdp
Zmk6IHN1cHBvcnQgbG9hZGluZyB0aGUgcmVkdWNlZCBwb3dlciB0YWJsZSBmcm9tIFVFRkkiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3
YW5hZG9vLmZyPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvdWVmaS5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L3VlZmkuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5jDQo+
IGluZGV4IGM4NzViZjM1NTMzYy4uMDA5ZGQ0YmU1OTdiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3VlZmkuYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3VlZmkuYw0KPiBAQCAtODYsNiArODYsNyBAQCBz
dGF0aWMgdm9pZCAqaXdsX3VlZmlfcmVkdWNlX3Bvd2VyX3NlY3Rpb24oc3RydWN0IGl3bF90cmFu
cyAqdHJhbnMsDQo+ICAJCWlmIChsZW4gPCB0bHZfbGVuKSB7DQo+ICAJCQlJV0xfRVJSKHRyYW5z
LCAiaW52YWxpZCBUTFYgbGVuOiAlemQvJXVcbiIsDQo+ICAJCQkJbGVuLCB0bHZfbGVuKTsNCj4g
KwkJCWtmcmVlKHJlZHVjZV9wb3dlcl9kYXRhKTsNCj4gIAkJCXJlZHVjZV9wb3dlcl9kYXRhID0g
RVJSX1BUUigtRUlOVkFMKTsNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQl9DQo+IEBAIC0xMDUsNiAr
MTA2LDcgQEAgc3RhdGljIHZvaWQgKml3bF91ZWZpX3JlZHVjZV9wb3dlcl9zZWN0aW9uKHN0cnVj
dCBpd2xfdHJhbnMgKnRyYW5zLA0KPiAgCQkJCUlXTF9ERUJVR19GVyh0cmFucywNCj4gIAkJCQkJ
ICAgICAiQ291bGRuJ3QgYWxsb2NhdGUgKG1vcmUpIHJlZHVjZV9wb3dlcl9kYXRhXG4iKTsNCj4g
IA0KPiArCQkJCWtmcmVlKHJlZHVjZV9wb3dlcl9kYXRhKTsNCj4gIAkJCQlyZWR1Y2VfcG93ZXJf
ZGF0YSA9IEVSUl9QVFIoLUVOT01FTSk7DQo+ICAJCQkJZ290byBvdXQ7DQo+ICAJCQl9DQo+IEBA
IC0xMzQsNiArMTM2LDEwIEBAIHN0YXRpYyB2b2lkICppd2xfdWVmaV9yZWR1Y2VfcG93ZXJfc2Vj
dGlvbihzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucywNCj4gIGRvbmU6DQo+ICAJaWYgKCFzaXplKSB7
DQo+ICAJCUlXTF9ERUJVR19GVyh0cmFucywgIkVtcHR5IFJFRFVDRV9QT1dFUiwgc2tpcHBpbmcu
XG4iKTsNCj4gKwkJLyogQmV0dGVyIHNhZmUgdGhhbiBzb3JyeSwgYnV0ICdyZWR1Y2VfcG93ZXJf
ZGF0YScgc2hvdWxkDQo+ICsJCSAqIGFsd2F5cyBiZSBOVUxMIGlmICFzaXplLg0KPiArCQkgKi8N
Cj4gKwkJa2ZyZWUocmVkdWNlX3Bvd2VyX2RhdGEpOw0KPiAgCQlyZWR1Y2VfcG93ZXJfZGF0YSA9
IEVSUl9QVFIoLUVOT0VOVCk7DQo+ICAJCWdvdG8gb3V0Ow0KPiAgCX0NCg0KTG9va3MgZ29vZCwg
dGhhbmtzIQ0KDQpLYWxsZSwgYXNzaWduaW5nIHRvIHlvdSBmb3Igd2lyZWxlc3MtZHJpdmVycy4N
Cg0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
