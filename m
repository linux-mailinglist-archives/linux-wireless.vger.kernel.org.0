Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB948D3D6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiAMIvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:51:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:63393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbiAMIvh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642063897; x=1673599897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hJ2kXREjuEJY+3ksCCfp2U70U++e2MHna0d4ZDlTeQ8=;
  b=Pray9R8T2ZNiNMCTp5WAzEFQj0HLThzF9OHbLzR0EeXgUtTsLbV9+Nx9
   aI8s7JarQw9k0ZBIfDmvbMN+25BAQuQa0B9JMVeTu79SJNV+4qabhKo0A
   tN0Siec7oXf8RfOnnP6deYZ5blx2jMBiJ1ufMSFUJcXE92tkLZcpynF1h
   38vPwuHIe1FCfUVRBKHk0+RUP0/ooeWEK4d5SKnDtrdJRud9Yy2VnpfQn
   A1IX7Vu6hKmvYLupCTMPAbxX4nEwDuHPNUnAQKtK12ZyzbbJmnnvtPM7U
   eq0KSUv9colWFcXt4EIXAZuWmHDwt0G8rIebcsWMfnRSsVVD3WJZ64e4g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268316402"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="268316402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 00:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529580385"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 00:51:20 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 00:51:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 00:51:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 13 Jan 2022 00:51:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 13 Jan 2022 00:51:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS35UaB4Ut3y6L9UTLd934IKDRuoa+CUiNouaxIOsHpjG+Q7kQJ4vxId7E0FxB2P5pCNIF4gp4VFDXLLd5TlXgQXFSZBgGTXH3bq4UryGeG0XiOCDGL4qn2tpCeXCBzY0W81+BMhrvzuK0bwSmmgWdWm+TaZR6tuuEI4836x9yfQ9rUOEowm9Z/xsXXVEHJCvtCZsAonf1nuCLIvm8h9U8/U+tvioQOwCl4UDUWozJSjfsoWWPGjNf2k/On1e2tyWr5gWuTTt32glOi3wtL3ywhLMFcQMr6+451GpDEwe8Jzn3sgmZFOZ/H1PkqXQhDtl1nbYgr4rDTftlvmfeTjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ2kXREjuEJY+3ksCCfp2U70U++e2MHna0d4ZDlTeQ8=;
 b=F3XN0vSQkc/wffGvfOq9jPbquBjgxkqEdfghvLskBjBNiBkEoTW4XJRUh1lR2VnffV8l+ZI67wKGRaJJRqPCV1N/ZdxqTUjjSTPM+s59peKqYlHvXDTYQR2WwJJt0eIykp551tlx5aSlsBGHfq26dRhXweTi3B+ToV9Sm+i67SGdHZmbAceHrASTLGXpDpNCJEWdgvEfrtmdewAlbrJu6le36VaQAN/LHxgaHnyvKw85MaiCCLq6QY7lEvkG8rfwGiSMHjpJFY5vXeyKt/YfHbspH1aZBcv5MNfiTjcgLOQ+KSYX8tf4ZmN/S1yzgiECFjlHjUl03G72jHEh0h7LPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB3287.namprd11.prod.outlook.com (2603:10b6:a03:1c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 08:51:14 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 08:51:14 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgACrzgCAAOssgA==
Date:   Thu, 13 Jan 2022 08:51:14 +0000
Message-ID: <1b4e94531f48a6d58bf3502dbb7125075b96944d.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <CAJvTdKmKPA_W_tXVjFOQEb5nX+sE+PmBeyVcf35=8WbLXuZapA@mail.gmail.com>
In-Reply-To: <CAJvTdKmKPA_W_tXVjFOQEb5nX+sE+PmBeyVcf35=8WbLXuZapA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65c23c2c-95fc-4e0b-d760-08d9d671db3c
x-ms-traffictypediagnostic: BYAPR11MB3287:EE_
x-microsoft-antispam-prvs: <BYAPR11MB32879B506C17B6AACF2FA53890539@BYAPR11MB3287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzSbTNZVsi4QycJb24u0q+r6smcFyFktFQBP7MlXHMb+7jUjyT7zSFkqYrUc0g8eBh787v6ZGcyW6FXEw7wBhh+OrDLOE+R8pPJEFh2qx0mI9k6gnQoeVrtKHVyQsDY8WuAcAKtbCcmWytCirjZPFXzDHDXEfoI4NUVYTKzab/WeOqjX4chqWkbk3OpYboHOciKwdOX8Okvjj6YdH3xJ0nDjRxBKNYwcIFNzxeCsrk8iPxlxy3uuLc7WsXn01J36bdboiff8x8dRnVF0jgl5ldfYl9LKe2JKQA99iSEnT4fp7+3fXbkTnes2DhTjf2scvhr3i8RHmPXIGoUpLZRY7/Rz3lZ6Spiu3XCaalASLCHaOZx06siu+IbFF7C6QA8KeR8UJxsFKor/7zaGORF3IGGEAUa128JYkVF9JSPDMmy42XXZ2t9CG/ErMUBk2k+SPA+cs/feOYJn6etWX8bC9XJoazwC1lH4ID6kVCE1aI125YxPjovlI+7CxR9xnMTX58qUQAs/euMLrTM7Z8UeEZNLHqO0y5At4+ToSQ6gqQ0zlkNgxEtmeVYqMPYXA8fX+Azk83H5U5WVAnKRH5hwHCGPf9auHXH58cfhWul4qGHXwrLgElWTqcvWDRsmZGRNSl2wDQSXlfoZ+QOI+y4LzT3VXWxjus32NBC+f7QGGKGd9I/1A6j4mcUAQnYsLIAkcoW7bR4IZspO0M6L7az+Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(38100700002)(122000001)(91956017)(8936002)(26005)(186003)(66946007)(5660300002)(66556008)(4744005)(4326008)(8676002)(71200400001)(110136005)(66476007)(316002)(6512007)(83380400001)(2906002)(2616005)(66446008)(6506007)(38070700005)(36756003)(86362001)(82960400001)(53546011)(508600001)(64756008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0lEcWVpVWNUTmpIVHNtVEJSTnp2MVNNSGU3cEhCY2wybVh4OFpVY05qYlZY?=
 =?utf-8?B?YUdQTTlyczVSTnYvdWRYaGl1WE8xYW8zVkxJQ2RCUnQrQ0VWVnUxMmwzSG1P?=
 =?utf-8?B?NzBzYWViMFZQSTlSbFM4UDFMZUVqQ1hyc3lIUmRoL09YRzVjQmh3dEI0UGFT?=
 =?utf-8?B?SzMxZjRJdVhGT0VYNURWbmIvcnFCZDBiUHlvN2lIa2tRVno2cEV6ZEJ0MTN6?=
 =?utf-8?B?U2RCcTE1cmRncmRoNW5PREMybHZvQ3dBb0pQVWRQT2owYTFoM0VWa3gxdnNE?=
 =?utf-8?B?Y0J4eTJiZ3dRa1BiRkxXb1FlTXlyWHhZYUNrbk9aeDFDVVhlMm81WjV5Vm4y?=
 =?utf-8?B?eHdvTFN1Q2plTVRGYUNLcGVKTGg5RUdrOFRvd0tydG5mL01WRy9lKzBqSkdX?=
 =?utf-8?B?ZmZDZnJUYmY5MWxEbXhQeTFpY01KZVA5TUhvWGE3SnhjMktSaDJRb1lySlRz?=
 =?utf-8?B?UW4zb052M082SURESE4rOUxmc1Q0UmhNVE8vU25NSjU4TGJEUlVzaVhBb09S?=
 =?utf-8?B?U2gxSUdnd1BONEVBUC9UL2xiczRiU3BMRUIyRTRYblBzY3lQTHVhY2padzRl?=
 =?utf-8?B?K2RXU2JDcVFlTGpycWtpaWRQQ0U4b3A3RFpjQys1SytVSkJTLzUwT2VwK1hx?=
 =?utf-8?B?dFgwTzhUbkVsc0FHSUs2UFZNcENnQjN4SUhJZlRCamFLZVRHb3FPVXArci9O?=
 =?utf-8?B?Rm5pbkZnWDR6ZFZXcmpUaXVnRFJuU1Zzc0F1MFZjaXdIZyt1V1FzSDBOUUd2?=
 =?utf-8?B?cXphdEdqNVplNFlXM1dxVGFJdjdBdkl6Z2ZLQTRET1haR1VESGMxT2IxODFm?=
 =?utf-8?B?aWdRL3NXOFA4TThRY1JvRkh2eE1pQUZMcTF4VC9pOWFGN3VINFF6WW85UWJG?=
 =?utf-8?B?U0FuUzB5aW96SnJIU2U2SmRaUGp0MmUxN3FSSmV0dXJhbkw1MzgvbUJtbWdh?=
 =?utf-8?B?WWlZZkVnR01nUS9RQTIyRlhRK1dUZmpYMStiVEhHYi9MczN1cVRCcDdVc2RI?=
 =?utf-8?B?dEdTWTd3N1plZzJmUjVHK2p5bmYwNUNLdmdwdlRSc2IrZEw0ZjRNSTM5TkJw?=
 =?utf-8?B?dWhZd0NyeHlUd2dvRnM4bkN2N0JZV0NqZnRXbTlDM1d3cHF6Umh5Q2k2bHhk?=
 =?utf-8?B?cFd0dWVqc2dvRVFvZWFFTUltU0h5dUVFKzFKcGl6WGpERVNvNlMwZWhyRFV5?=
 =?utf-8?B?eFpFb2VFQXhWZmoxcmUrZXdVTm43WUNIeGJNTTRuVjJoUTBYU0FKRjdKajJz?=
 =?utf-8?B?RlZyNFFrVDdwa3U0Y0RpdDhiWTVBYXBicElXSDNUU01rQnUvdmhxbE5Qc2hi?=
 =?utf-8?B?NlhEK0UxM0lZcXpLejQwVTBmd2JEb3habFpJTW1yOExVTitMWE82QW9paVpX?=
 =?utf-8?B?eUcvaEdVM2wrY0NhZDBwdHMvdkhJUXAyWDRqZ2pxYUJmK0FlMmNGRXdVdFFD?=
 =?utf-8?B?TGIrbDh0ZnZsdVViZnVlaWY4bUhrYmxscThLSFBqRkhvZnc3KzVrNFRnYk9J?=
 =?utf-8?B?aFAza294a0dqakJMRVZTN1NmYVNuaWhyeERERzcrMW0va3RlcjBxazgwOHYw?=
 =?utf-8?B?a3l4TmV5RVhyeW1ldm03S0Y0MDVzaUxkY1lyZHhRanJhNll2YXFTaXhQVXhJ?=
 =?utf-8?B?SWw0TkRiWG05VXNjWkhDV3JkK2lSazZtUUs2dWtZL3hROUljVkJvTllsNFZx?=
 =?utf-8?B?T3NmRVQxZzZTdWt0V0NyenprUVpyVnMrL3J5L0hOSlI1Nm5tR0FSWlVtQ2oy?=
 =?utf-8?B?cmUvdDA5aDBMRjNwTTRpRllBNzFkRmpjWGNtQ2UxSHFrR0xtbDR5UDNZTUF6?=
 =?utf-8?B?SmlHaEwvTTR2RGtqMFVnV1pKak9RWm1yeGhpR2tMMFFsOXEvcStvd3ViZERm?=
 =?utf-8?B?YjYraHRCdTRZUndVMXlOcmxPbGUyQ2JMMVpTRnVucDFpVFJsRHZLQzk2VDBh?=
 =?utf-8?B?ODlBZlBDSy9JazVYR0ZXSHRHUVBReS9FMDU3cDNXWS8wdi9YdXJwclJZMUlW?=
 =?utf-8?B?aEg3Z3BpbXRmcm5PZ1pmN0duM2orcjZDemdjOE15L0syZ1lOOGdVRjQyeXF2?=
 =?utf-8?B?Y1pLNDFGYk9IN1kzejh1eEVNYlc0UFRPMWNhVjBEUDJsTjgzc21WUDZYc1Bt?=
 =?utf-8?B?TmxBL1ROU1ZTbjdrbTdsY3hLWFNTZEtZU0Z0Y3E4WlF5VmR1UE42S3RkaFNx?=
 =?utf-8?B?SkhoTnJUWHlsN1BWc21JQUt0M0pIWmxUUjJjeFljbjFweFhhM1NNejhKcHpx?=
 =?utf-8?Q?hcWuaV9miembQnIwgmJ+7penWtvJHs5iWqy7cF9UB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8419EB42AA65104CBADF9283D4F36B48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c23c2c-95fc-4e0b-d760-08d9d671db3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 08:51:14.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7knk6StFr+BwEgRsEWJ85vO9Gd0RusIg/Mki5dqr1Lhp7HhtHUKfQqeio9zDyutk31QEiMXVpnDK82TWrzxcarHNKzeLLOCULcxGYsosTMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3287
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDEzOjQ5IC0wNTAwLCBMZW4gQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgSmFuIDEyLCAyMDIyIGF0IDM6MzQgQU0gSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lw
c29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IA0KPiA+IFNvbWV0aGluZyBsaWtlIHRoaXMgbWlnaHQg
aGVscD8NCj4gDQo+IFllcyENCj4gSSBoYXZlIGNvbmZpcm1lZCB0aGF0IHRoaXMgcGF0Y2ggYWxs
b3dzIHdpZmkgdG8gd29yaywgd2hlbiBhcHBsaWVkIHRvDQo+IExpbnV4LTUuMTYuDQo+IA0KPiBM
ZXQgbWUga25vdyB3aGVuIHlvdSdkIGxpa2UgbWUgdG8gdGVzdCBhIHByb2R1Y3Rpb24gcGF0Y2gu
DQoNClRoYW5rcyBhIGxvdCBmb3IgdGVzdGluZyENCg0KSSBqdXN0IHNlbnQgYW4gb2ZmaWNpYWwg
dmVyc2lvbiBvZiB0aGUgZml4ICh5b3UgYXJlIENDZWQpLiAgSXQgd291bGQgYmUNCmdyZWF0IGlm
IHlvdSBjb3VsZCB0ZXN0IHRoYXQgb25lIGFzIHdlbGwhDQoNCldlJ2xsIGdldCBpdCBpbnRvIHRo
ZSB2NS4xNy1yYyBzZXJpZXMgYW5kIEkgQ0NlZCBzdGFibGUsIHNvIGl0IHNob3VsZA0KbGFuZCBp
biB2NS4xNSBhbmQgdjUuMTYgc29vbiB0b28uDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIGFuZCB0
ZXN0aW5nIQ0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
