Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C534A229
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 07:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCZGpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 02:45:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:56383 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhCZGpc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 02:45:32 -0400
IronPort-SDR: l/MFhRF2mUsXy6a3GZeXK1Vk3Js7rWYIaZvJfo0kYaKrwNCsFACS+IHFEjYIRYhvRpId4zoXaM
 NfJqztCDXJlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187797337"
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="187797337"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 23:45:32 -0700
IronPort-SDR: X7kpCxbavx2pqmLnCtUEkSBqJC240JqGKrbe2J5BQYUvcOuDmVuowSCvGDeiV0j36kTq2LXISC
 ls9vlnUzSA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="436776937"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2021 23:45:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 23:45:31 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 23:45:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 25 Mar 2021 23:45:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 25 Mar 2021 23:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMfyrcFr2YVokeWBBBogXcLoth7yrYuyGRC3JfvwknhyUr+qwWasTAsHh0fieiopzBxuW0jqX1EMnGssn/Knkcy+2YqE/X+z1c73D+Dw+NA6IU3dNSWZJemNpg98uvX2gaOuM5I5DRPg37WSgp2QVIbFC+5/rvPEueFUnDF5zel47Z+zeW8aMiEO9RxQXh8oJK9N4uKR82zhlCLwMXBNoSYy5IbDFHE17vj0Iw8AH19kaaS3feO/uK4fSur84F02ZUMAuOGfty68dB341Ld4+j54ecPs5d2RBce+8xKVG1jaZN2BGx1AX18W8mdqLAKxaOdHn8iZfXeRxzqITsqNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qWjYz8eEkH4Jl3Jk5OwS7Ce+jO5dbl+t3NXgE5h550=;
 b=i5HXhPqnuH8lYm79tfy2ss1UFl2qud19OhKurwUiAfsCR1oCMSmcGtxkx4n/fMvqixxWqNh8y8fVYPlhlpyUQyBsZr8muUVu51rzfzNeELdeJLXsXtbwl03BE3/855lP7++ZQlHzNvxDHWaN+vuSosSF4o5m7+q5Ttm+tUVpm/dxw7LzuzATzg2pGLX+4vKyCVD+7h4IxId51VzHcIIXag6Q1twm4TxNpDdTUMNoRskLGRnkzyblRogSY9IR4OOgCpHIeLp90girtIu7eqRwWhS0lsXOfBDW+DBtu4HzqihiV7H5Hi2wevjxC002gsk+ahMHBAasHzNLFIxMv1xefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qWjYz8eEkH4Jl3Jk5OwS7Ce+jO5dbl+t3NXgE5h550=;
 b=w2iXdL5ZYru/p3EK6bm2APTaq/QBfMDNGQKnanHb8WQmBL72lPgEPbzLgJ0fOvUn7DK23MhJ76LzTUjmiyoozyMub9owI+KMSe4Vf9evqXmu804/KEPprsIvFwhXTWCVzDsZI0L6i8waFwzVx5Cpunm6+DkWD5nkwAO6Hp0Fa1A=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 06:45:30 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7%7]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 06:45:30 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "greearb@candelatech.com" <greearb@candelatech.com>,
        "paulius.zaleckas@gmail.com" <paulius.zaleckas@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Intel AX210 does not work on 5.11
Thread-Topic: Intel AX210 does not work on 5.11
Thread-Index: AQHXIKg5YGF/4AFkiEKRwAxXt25WAaqTEA2AgAAW5QCAACnkAIAAApGAgAKCfwA=
Date:   Fri, 26 Mar 2021 06:45:30 +0000
Message-ID: <1d3a4c605700079bf3de1b2d8b7b1d5a5645190e.camel@intel.com>
References: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
         <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com>
         <CAPiS6wB4Ls53ykD6iSUpBGN+sHauya1Mhu-7Q+Z_gzh=bAShAw@mail.gmail.com>
         <CAPiS6wD=NZe6+aT6wc_s94KVfFRVK_3b+zM_RUR7q6uWe-Wgpw@mail.gmail.com>
         <CAPiS6wCi2-cUaDkgkOFietb5Ko7oCLMjkoNcOfygNsSfYxAAeg@mail.gmail.com>
In-Reply-To: <CAPiS6wCi2-cUaDkgkOFietb5Ko7oCLMjkoNcOfygNsSfYxAAeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: candelatech.com; dkim=none (message not signed)
 header.d=none;candelatech.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5818518-8142-4774-3b0c-08d8f022bf77
x-ms-traffictypediagnostic: SJ0PR11MB5070:
x-microsoft-antispam-prvs: <SJ0PR11MB50708617BB54D9970E72AC8990619@SJ0PR11MB5070.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tVk2gHDJ3NK8Vtqb85ejnwWhIIm4A7Kd2mkiV88vWSKQDSSQidl9pmlH0qXlJSWqP7+0jcYEWfOEXFSAbxBWER2S1UJKvMwOOrsNLgmVkjkRmqNWIPYMgvsgtV6GP5Es3Jo18rOcu9yeFZs/i7Q85yNsXmhOwOpk3x+mmNPmPIOPQPvprvPegDNfH5dtaEkV1JxQOx6rBFRkwzQpierBUMEZlci0RlRPEvCbD84F+yelfQWqO7NBD+yKGij7pdVYCI7JmeQyH3SH91G0/h6xjMGgIh/9yfxdsNAx2ZWo7pdMT6XX9quP17oljKTSvja+NzT/ecZEcWQtOZ6x0TZtdh9ZFcSFpmqYvjXpQLlo4Rn0/wXhv0ihsm/iobCatVdefVVi2pPPcsSYnglQXASx0MxfcJ2AHDtuuJlR2sVC2e4myPLZik0U+SdsDtM8CGYxmEsqSbPa6uum8BSUUTBDFDRd8HoEBkkAAJhI8iaqLb7LERAcQ08kTYcRLVC77tNnP0I1SKChQ3fHDtNq5FhzvDy3vxiFJe5d2gLqW8OIGpYMAlIAxHQ4lhxxe7n+UarbI2/NP/rJUHdP/RQLFuqBzj0OVsZUyc+rixwdyV82ot6p1+uDP+ScICNTTKkTOm3gpbdaD6MP67ypSEix7jix4lqZanw9jQiA9f8VvLMk2Tktnzmf6FN/3dmZzhWFNOfTt3nZtIAxYEGUTDUftbhVxhL7cikNQtorMyo78bDNMeM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(396003)(136003)(76116006)(38100700001)(86362001)(2616005)(6512007)(71200400001)(316002)(91956017)(966005)(478600001)(8676002)(110136005)(66556008)(2906002)(64756008)(53546011)(6486002)(186003)(83380400001)(8936002)(66446008)(66476007)(5660300002)(6506007)(4326008)(26005)(66946007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?amhvb2p4d1UvMlBvTC9OL0xFMDg2SEpBcGRyUTZxUmxEZkZLbFlHSUl1WUNw?=
 =?utf-8?B?TjdPcERVeDZlL0lxc0EyRk5TakhCVnJWVVBTdTk0bng4MWRhdGk2TzhMZHlq?=
 =?utf-8?B?eU8rRVUvNzFGejJpNVRLY1NrcW1wcjJwblpYNUgraGFOSUZCZk1ybW4vVkE1?=
 =?utf-8?B?YjZ6czNmU2NaQnlxbFh4QVduRXNGSXN2c3JmWlFNVHJKOUdTNWNQdmlhTGkz?=
 =?utf-8?B?NzBVWnVYb2sxd3BTYkxkRVVKMzRoWTBBREhobHpxRk84Z2J1b1d2dkdXSm0w?=
 =?utf-8?B?aU0vRE4zVmh1YjdkcWp0ZkNCbWRqY013eGZGY1RtNG4zbmtUQ0JVUFdDZXVv?=
 =?utf-8?B?cG5jNmJnOFVDZEdzbXI4aWFrWURObmx2TE5RdTBreGI3ZmpJNWErcUlET2hM?=
 =?utf-8?B?QkcxdFIzT29PVkhEWDc0NVlFeTZLYjZkc1plZloxdlBmMG5nSDdrZXlhaFpR?=
 =?utf-8?B?SmJOU21rakNtSE9BdmQvTDBHdlp4V0VocDE5VnhKYlRPaDcyTm9UcjAyK0xi?=
 =?utf-8?B?MU5mUEp2OEtXY0tpRTFNL2NRNFhWOWkxcVpvbzFnMitseFdBTlVJRThNcXo1?=
 =?utf-8?B?b29YRm4yMEFRNXA2MUUzVFBjenhaZVd3blVCZkI1MXVhY3Nla3ppdTdJMXZ6?=
 =?utf-8?B?QjZVRldDNmZBc3dQclN4L0ZJR2hNbXhtU04vTFI3RUg5SzZ0Mjdia3h1dmJo?=
 =?utf-8?B?U0VIcTNudyt0ZXo1S0cyYWxlbWlpKytER2g2WjdYdzNSdmEwQXkybmdBa3pI?=
 =?utf-8?B?Uk0zUy9haHhES0RmZWovbzJXWXlhNjNHdzRNSHZ6bldhQ3VNbVdHa0h2OTZF?=
 =?utf-8?B?QWhWaGNpWTVLQ3F2amFMSm5yZ0Z6aXJVbDJVL2IvbHdndE9tQnI4UXoxSWVE?=
 =?utf-8?B?dU9yZzRiNU41VVFKS3lVVXhjcmIvWXBFeVZFSDNVbGN1QjU5SC9uTSt2UURv?=
 =?utf-8?B?QmZDWjlBZE9hUFQ4QTFKZUlkQnUxVlNIS2dxMkNMSUdzNTFXQVN1dmxadklK?=
 =?utf-8?B?VDZsaGM4V3BjQm1Oblk3RXJJMTcxcU1MOFIza3FOV01tem5pSWV6Ynk3WDJx?=
 =?utf-8?B?SzFDZHZFNmtKUEJjaklORHp0WGxhc095eDMxZytpWjFoZVBJS3BkS3ZMYnJr?=
 =?utf-8?B?Z1NDa3l5UzJHTlBobXZaR0c4R0hRNTBXRzhVTDZsdWN2ajdFNUpxYjl1eHVN?=
 =?utf-8?B?eGxuOEI4dU1IM0tDUk9KaENRMFJ3Wnd6eGR0YmVNc2RaMVYvWGg0dW1nZ1VB?=
 =?utf-8?B?OFZrT2lTOEwvdnRUdTRTbllFNVVGSWhiTEk0S3lVMzJ6b1I1cjZRN0ZsWG82?=
 =?utf-8?B?VlRpamxuRHVVNkZrUklZQnVvYWRSK2ppTStlL3BucmhwdTdBTkpKMkdpSkVX?=
 =?utf-8?B?SGsxZ29vV1lIZ0RZRkl5NjUvWW5vLzdOMExGM2JXTDkrK3BtOFhQL0wza0Rm?=
 =?utf-8?B?SkhyNDdCZjc0RTZvZ3U1NFk5Y0Y5WmNwZXJFN2hVRUZnclFPU2pYWTFxTFE4?=
 =?utf-8?B?OVU3SnVta2dmUEVhY1dJNTA0SE9FQTgrWGNnZ21nOWRBdVBycmg0T1JOM1B0?=
 =?utf-8?B?U1k4Mlg0OGxJY040RDRUbmVPQlA0VDFFQVNIWG5YQjNrcTVJMUVDZ3FxZ04v?=
 =?utf-8?B?NjJya2ZkcXl1WmdWbHRJbzlIcW0vVnIyejJaS3NQcGJvR1RvcFd5TlFjYzBJ?=
 =?utf-8?B?NGdaUXZnY2lLaXBkWFQ3SEVvSGd4VmlEYjh3UHVQeHVrZVNRK1U2S1pYMTdT?=
 =?utf-8?Q?accOkvpVEnJwfLJbdMOQK9rMXc3K+bb4OD3GxUs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <14487BFE6224E242AC0A7FC4FCDFFDA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5818518-8142-4774-3b0c-08d8f022bf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 06:45:30.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlVAPaazASOWq/GJ3KFd8nzyoXU5NiFheHH61D7qbW/1wELR0YvpWBegMMhuqJP/BBS0qKhB4LIoXN66POcGmylrMhU+O04GaBmQO2YQ578=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTI0IGF0IDE4OjI1ICswMjAwLCBQYXVsaXVzIFphbGVja2FzIHdyb3Rl
Og0KPiBPbiBXZWQsIE1hciAyNCwgMjAyMSBhdCA2OjE2IFBNIFBhdWxpdXMgWmFsZWNrYXMNCj4g
PHBhdWxpdXMuemFsZWNrYXNAZ21haWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIE1h
ciAyNCwgMjAyMSBhdCAzOjQ2IFBNIFBhdWxpdXMgWmFsZWNrYXMNCj4gPiA8cGF1bGl1cy56YWxl
Y2thc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBXZWQsIE1hciAyNCwgMjAy
MSBhdCAyOjI0IFBNIEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPiB3cm90ZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IE9uIDMvMjQvMjEgNToyMSBBTSwgUGF1bGl1cyBaYWxlY2thcyB3
cm90ZToNCj4gPiA+ID4gPiBJdCB3YXMgd29ya2luZyBvbiA1LjEwLjE2Og0KPiA+ID4gPiA+IFsg
ICAgNC4yNzQ4NTZdIGl3bHdpZmkgMDAwMDozYzowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAg
LT4gMDAwMikNCj4gPiA+ID4gPiBbICAgIDQuMjc5MDE0XSBpd2x3aWZpIDAwMDA6M2M6MDAuMDog
YXBpIGZsYWdzIGluZGV4IDIgbGFyZ2VyIHRoYW4NCj4gPiA+ID4gPiBzdXBwb3J0ZWQgYnkgZHJp
dmVyDQo+ID4gPiA+ID4gWyAgICA0LjI3OTAzMV0gaXdsd2lmaSAwMDAwOjNjOjAwLjA6IFRMVl9G
V19GU0VRX1ZFUlNJT046IEZTRVENCj4gPiA+ID4gPiBWZXJzaW9uOiA5My44LjYzLjI4DQo+ID4g
PiA+ID4gWyAgICA0LjI3OTQwMV0gaXdsd2lmaSAwMDAwOjNjOjAwLjA6IGxvYWRlZCBmaXJtd2Fy
ZSB2ZXJzaW9uDQo+ID4gPiA+ID4gNTkuNjAxZjNhNjYuMCB0eS1hMC1nZi1hMC01OS51Y29kZSBv
cF9tb2RlIGl3bG12bQ0KPiA+ID4gPiA+IFsgICAgNC40NTYyMjhdIGl3bHdpZmkgMDAwMDozYzow
MC4wOiBEZXRlY3RlZCBJbnRlbChSKSBXaS1GaSA2IEFYMjEwDQo+ID4gPiA+ID4gMTYwTUh6LCBS
RVY9MHg0MjANCj4gPiA+ID4gPiBbICAgIDQuNjA3NTI0XSBpd2x3aWZpIDAwMDA6M2M6MDAuMDog
aW52YWxpZCBUTFYgbGVuOiA4LzEyDQo+ID4gPiA+ID4gWyAgICA0LjY3MzEzNF0gaXdsd2lmaSAw
MDAwOjNjOjAwLjA6IGJhc2UgSFcgYWRkcmVzczogZDg6Zjg6ODM6ZDk6MzU6ODcNCj4gPiA+ID4g
PiBbICAgIDYuMDU1NzMxXSBpd2x3aWZpIDAwMDA6M2M6MDAuMDogaW52YWxpZCBUTFYgbGVuOiA4
LzEyDQo+ID4gPiA+ID4gWyAgICA2LjI4ODQ2MV0gaXdsd2lmaSAwMDAwOjNjOjAwLjA6IGludmFs
aWQgVExWIGxlbjogOC8xMg0KPiA+ID4gPiA+IFsgICA3Mi41NDY2MDJdIGl3bHdpZmkgMDAwMDoz
YzowMC4wIHdsYW4wOiBkaXNhYmxpbmcgSFQvVkhUL0hFIGFzDQo+ID4gPiA+ID4gV01NL1FvUyBp
cyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBBUA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFuZCBmYWls
cyB0byBzdGFydCBvbiA1LjExLjg6DQo+ID4gPiA+ID4gWyAgICAzLjg4Mjc0NF0gaXdsd2lmaSAw
MDAwOjNjOjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQ0KPiA+ID4gPiA+IFsg
ICAgMy45Mzc3MDhdIGl3bHdpZmkgMDAwMDozYzowMC4wOiBhcGkgZmxhZ3MgaW5kZXggMiBsYXJn
ZXIgdGhhbg0KPiA+ID4gPiA+IHN1cHBvcnRlZCBieSBkcml2ZXINCj4gPiA+ID4gPiBbICAgIDMu
OTM3NzIwXSBpd2x3aWZpIDAwMDA6M2M6MDAuMDogVExWX0ZXX0ZTRVFfVkVSU0lPTjogRlNFUQ0K
PiA+ID4gPiA+IFZlcnNpb246IDkzLjguNjMuMjgNCj4gPiA+ID4gPiBbICAgIDMuOTM3ODkxXSBp
d2x3aWZpIDAwMDA6M2M6MDAuMDogbG9hZGVkIGZpcm13YXJlIHZlcnNpb24NCj4gPiA+ID4gPiA1
OS42MDFmM2E2Ni4wIHR5LWEwLWdmLWEwLTU5LnVjb2RlIG9wX21vZGUgaXdsbXZtDQo+ID4gPiA+
ID4gWyAgICA0LjM0MTI2Ml0gaXdsd2lmaSAwMDAwOjNjOjAwLjA6IERldGVjdGVkIEludGVsKFIp
IFdpLUZpIDYgQVgyMTANCj4gPiA+ID4gPiAxNjBNSHosIFJFVj0weDQyMA0KPiA+ID4gPiA+IFsg
ICAgNC40ODY0MDVdIGl3bHdpZmkgMDAwMDozYzowMC4wOiBsb2FkZWQgUE5WTSB2ZXJzaW9uIDB4
MzI0Y2Q2NzANCj4gPiA+ID4gPiBbICAgIDQuNTg4MjEyXSBpd2x3aWZpIDAwMDA6M2M6MDAuMDog
VGltZW91dCB3YWl0aW5nIGZvciBQTlZNIGxvYWQhDQo+ID4gPiA+ID4gWyAgICA0LjU4ODIxM10g
aXdsd2lmaSAwMDAwOjNjOjAwLjA6IEZhaWxlZCB0byBzdGFydCBSVCB1Y29kZTogLTExMA0KPiA+
ID4gPiA+IFsgICAgNC41ODgyMTVdIGl3bHdpZmkgMDAwMDozYzowMC4wOiBpd2xfdHJhbnNfc2Vu
ZF9jbWQgYmFkIHN0YXRlID0gMQ0KPiA+ID4gPiA+IFsgICAgNC43OTYyMDZdIGl3bHdpZmkgMDAw
MDozYzowMC4wOiBmaXJtd2FyZSBkaWRuJ3QgQUNLIHRoZSByZXNldCAtDQo+ID4gPiA+ID4gY29u
dGludWUgYW55d2F5DQo+ID4gPiA+ID4gWyAgICA0LjgwODMyMV0gaXdsd2lmaSAwMDAwOjNjOjAw
LjA6IEZhaWxlZCB0byBydW4gSU5JVCB1Y29kZTogLTExMA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFBsZWFzZSBhZGQgbWUgdG8gQ2MgYXMgSSBhbSBub3Qgb24gdGhlIGxpc3QuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBZb3UgcHJvYmFibHkgbmVlZCB0byBnZXQgbGF0ZXN0IGZpcm13
YXJlIGZyb20gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
aXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQNCj4gPiA+ID4gYW5kIHNwbGF0IHRoZSBpbnRlbCBy
ZWxhdGVkIGZpcm13YXJlIGludG8gL2xpYi9maXJtd2FyZS8NCj4gPiA+IA0KPiA+ID4gRGlkIHRo
YXQsIGJ1dCBzdGlsbCB0aGUgc2FtZSBpc3N1ZS4uLg0KPiA+IA0KPiA+IFJlbW92aW5nIC9saWIv
ZmlybXdhcmUvaXdsd2lmaS10eS1hMC1nZi1hMC5wbnZtIGZpeGVkIHRoaXMgaXNzdWUuDQo+IA0K
PiBGb3VuZCBtb3JlIGluZm8gb24gR2VudG9vIGJ1Z3M6IGh0dHBzOi8vYnVncy5nZW50b28ub3Jn
Lzc3NzMyNCNjNg0KPiBTbyBlaXRoZXIgY29tbWl0IDAwMDczNWU1ZGJiYjczOWNhMzc0MjQxMzg1
OGMxZDljYWM4OTllMTAgc2hvdWxkIGJlDQo+IHBvcnRlZCB0byA1LjExLXN0YWJsZSBvciBQTlZN
IGxvYWRpbmcgZGlzYWJsZWQuDQoNClVuZm9ydHVuYXRlbHkgd2UgY2FuJ3QganVzdCBiYWNrcG9y
dCB0aGUgRlcgdmVyc2lvbiBidW1wLiAgVGhlcmUgYXJlDQphY3R1YWwgQVBJIGNoYW5nZXMgdGhh
dCBuZWVkIHRvIGJlIHN1cHBvcnRlZCwgc28gdGhhdCB3b3VsZCByZXF1aXJlIGFuDQp1bmZlYXNp
YmxlIGFtb3VudCBvZiBjaGFuZ2VzIGZvciBhIHN0YWJsZSB0cmVlLg0KDQpXZSBoYXZlIHR3byBv
cHRpb25zOg0KDQoxLiBUcnkgdG8gdGFrZSBhIGZpeCB0byB0aGUgLTU5LnVjb2RlIGZpcm13YXJl
IChJJ2xsIHRha2UgdGhpcw0KaW50ZXJuYWxseSkNCg0KMi4gUHJldmVudCB0aGUgZHJpdmVyIGZy
b20gbG9hZGluZyB0aGUgUE5WTSBmaWxlIHdoZW4gb2xkZXIgZmlybXdhcmVzDQphcmUgdXNlZCAo
SSdsbCBjaGVjayBpZiB0aGVyZSBpcyBhIHByb3BlciB3YXkgdG8gZG8gdGhpcyB3aXRob3V0DQpy
ZWx5aW5nIG9uIHRoZSBhY3R1YWwgdmVyc2lvbiBudW1iZXIpLg0KDQotLQ0KQ2hlZXJzLA0KTHVj
YS4NCg0KDQo=
