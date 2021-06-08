Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60FB39F74D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhFHNHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 09:07:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:40687 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbhFHNHo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 09:07:44 -0400
IronPort-SDR: CKCSBFNqUgfohFfx2BN/jVAre7jd9UxXXrckW5PBP10q1mcz4mbet4mYOkqXrjAx1HXjM2JeZc
 SOisRdwgqSSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204861736"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="204861736"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:05:51 -0700
IronPort-SDR: 1o9BTMnfZbkp3EhFHvHrv2qRJWBv00w84KXYgYzb4DcRu6tGRgGPSRJJUZoVlG340y3D1mfj/e
 zc6BqYymA/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="551596354"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2021 06:05:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 06:05:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 06:05:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 06:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6OlmNmzv3q4MypypibDTVdNl4V+skL7BStqyFb1pXBWsK/0oisoYSv6VCXaJPXlT2LpyrN571SmMBTmxiaH2NcDrpnqqwnjD4Hedvm78nuoIFIObLQfpSjmY9Msu5ReH590yOsM63LeGvJk1Uhz89e0sjkRAHAmbhIZIvZb4iGActRs9jmq485TXusIofDAbDMcMwcc7K8rkEOCTJWK6uyFCs9kCTMjv+gK4MpNElWuagFsqFoGcRIH0uJKGJi3wZYiR6hnIKrSCB5Umu/V7C4FswOJ3TZSl74wQiPdNirP7O8r1+hod2rTHUFZy9x7KhWfZNbvb/4rF2r3V2QeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ9MTFdxeMs5bQ2CUVUDVNa5cquq1BLD7lYdoCKToYg=;
 b=QBxwIWwCpJgAPafYtq6i8mEiFk6DyHzW8VozVh/nKlH3G7av5fpeuuRoGobVxfnInjZeNZoTehtchzymRyuHFLwHmX2WSE2bzOigoKA8tNyL4z2sAKS81xhdGjIZe3bPTwojwDeAt+Wm8YttjqZW0RzzNTHVE8dPBPL/8851+fJTM2h+2Qzn5D2lQkJc+LkwpIDZpTvmHsplu42QiXZF0Wp0yXU2NilYo7fJXDIQFkF+jQ5OiKT/x714S9mEl6Ctg+NrSNvKmx3ekzwi2ZbRxkx6QFicRP0tbAzM7jhniJ9jqufIFFT4DkyaGtYg2ARjNSdDnU4T7DKUw+DXaeEJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ9MTFdxeMs5bQ2CUVUDVNa5cquq1BLD7lYdoCKToYg=;
 b=xNZiKt5uWm0/IEAWXhhTtZzh0gwIyeCO4Za9D0ZIDJRR7l09FQypNAEswfIG7sUntOI3nGnH+G0Fje4NdUu6gQ2n1vDnXIJu/oe0LYOQ3lRkeYZRXVkt6B8QdZUJW5Xdz5SdRdQExUMFwADvbgGpoEZBV8o1XLWi+kfA9/5mmNU=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 13:05:49 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 13:05:49 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Thread-Topic: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Thread-Index: AQHWyVPm8LymXluzUEOtV//c2pB2jKsCVVeAgAjl/4A=
Date:   Tue, 8 Jun 2021 13:05:49 +0000
Message-ID: <abe481f9cab8440c975331ff1a0d96b44c3eaeb8.camel@intel.com>
References: <X8irC3FP0QDE9QFe@mwanda>
         <CA+ASDXMS-qR2tgFzE7_cqtxLj9-TavbmghqGo0jDtHkbUB59Ow@mail.gmail.com>
In-Reply-To: <CA+ASDXMS-qR2tgFzE7_cqtxLj9-TavbmghqGo0jDtHkbUB59Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f5b94f3-1666-4814-0d94-08d92a7e2324
x-ms-traffictypediagnostic: SJ0PR11MB5135:
x-microsoft-antispam-prvs: <SJ0PR11MB51350BB62788C47B1CD096A990379@SJ0PR11MB5135.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBqxx8I+e+DG3tBkTggsAlU/rYX+lnAyUIfG7Ohmv+yNv57BPu9lwzzvAO1YOh1MnfssqZyEhhwL1X/npTyPNX3Vaufj1ZnjwZnTfeirs3/kP5NhPA2CRW+eUzm053wOLdfhBRrBjYC2Vldy4xi/X7LYPYT3R7z4rVVK5WllrLOQhqYnxd+Y0soqiGGsoxyvy620UF/ydACyjxR1K151XvxtOg8AjzYp25TfjYyooZe4k0xH8FIRfFYyjeWtBcMLvbyQHGKyhnilLWbwnqXzzeg0yHCgLHCWjFTF0X2DrUzrjo5RpDwlGpPZwmYMbh/xskRIa4P1vncnrf05jNeErjPgWkkq+9qcz/P0SeY61/tA6yYzjbmRpxm6M6n8R3SjatajkTcAyDdoV08UvX+uN3dummi1evVXKS/A5V9thFZP8j9UmgYOf3Mjd/GM2REa4sBTkUEybjnuFFFx8dIGAG8tx6H9HMOzwKtcuehTTDKrDgwta8l2nthsSNhICBjH1800F9QbiWt/EHVOjwwtazN9g5+Wi72pL4XM4mH+V9ZO/4saxIEObcy5lMM03C3yN427emm91OfO+9hXSW+MLPfpr0Wio2AQ0PhGTa9IDfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(4326008)(4744005)(54906003)(91956017)(2906002)(26005)(8936002)(76116006)(6486002)(8676002)(110136005)(64756008)(86362001)(66556008)(66476007)(36756003)(66946007)(66446008)(5660300002)(6512007)(83380400001)(71200400001)(498600001)(38100700002)(122000001)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9Ydmg3Ylk0TjI1aUYwRDJ3ajhNdEZVTHdnSUJsdEVLVktzcHNLOTlSYVdS?=
 =?utf-8?B?U0x0LzlJM3BBYkg2eEJFVmJHa1hWcDhoWDVYWFp2b1BLOHB0aldiSHRBSWkv?=
 =?utf-8?B?RGxTeWtoNDBmU2lFS3dFSFFlUTVIcVBKNDZqQ3QrcmJOb1hHYmt1VnhmZVln?=
 =?utf-8?B?Mk9uMEZabWg5SFZHZVM1amk1UXpGTTUzc2N2cXh2R2lmdUY2d2RveXpMdk5Q?=
 =?utf-8?B?OU11TmMreWFmb1FBSXVvV2pydnpRRWhtL1hxazRZQVY3YXE4bVJBVVU0UEZ2?=
 =?utf-8?B?VjFibldRWTJRRTF6blRMalhvZTBab21HRzI0bFVQVDVSaklzU3ROd25La2FN?=
 =?utf-8?B?b2lvalUvR1A3NWovTGc5ZlFjUUw2ZlBNS05pM3I4K3l2TTFqNVZIeGZvaVY5?=
 =?utf-8?B?L1AzOG5lVWFXbk5GZ2lmRFMxS2N0b0VySndFQnpUd21nT1MwUjhPQWFPZEdR?=
 =?utf-8?B?WjJRaHZzNm11QkVKQU40TnBIQW9kUWtDYUZlWmNaSVNSYTdvb0JKbTdubUJK?=
 =?utf-8?B?L3BJaU9iamxYb01ZWmlhRW5yY00xaDZnSE5WdlI4WVNaNzMyMTV4SWdMWnpx?=
 =?utf-8?B?VG1Lck1JUm9ic0ZUdmI0MHV4YzhaS2VTNmhKeUwyVHliTHp5QllYZEdSVDBW?=
 =?utf-8?B?V2hFM1VTOHNwUUFyY3pQWlk2UWNjaGlKRzNocDlXck5RUCtFVkxRU2RFaXR6?=
 =?utf-8?B?Sy9YRkFMeXQ0RzJCZ1IvU0I2azBYWDBFS3c4SlgreU1CS0xZUk1yMm9WNGZS?=
 =?utf-8?B?UmVqNzJneU40c2xqSE5tZGF0TjdYSXlDWGY4bFdpaWdPdkQ4ZTJGZXJoSjIy?=
 =?utf-8?B?SnN2NnEyaGlGK0dRcFd5TXdDNTg1cW5KZEkzV3F3Y3ppNWlBV0swcVpudHFF?=
 =?utf-8?B?MEVqZnlEemFlOGUzRHFqa1Vlc0RiZm5lNWZMRnkrNEJpdjFpb2dnZmlkNERa?=
 =?utf-8?B?N1BidGgwejMvSzBZeFBBb0Q4TWlBZ2puVndEZmJZU0ZYR05jN3RIY3hPMVdB?=
 =?utf-8?B?N25SeC92bHEraVlHd0p6bm1RTmFwYzN6eE93MFRUWVNmZWZCTGpsRHBwaDNT?=
 =?utf-8?B?M1BselhHN0EyS1FKanJIdWs5UW8vNkgrWXFlZlZ6SEZNbWVFbXJTL2lIaDQy?=
 =?utf-8?B?ZGRGMDRQTWdkbG5UMythV2NmQUpEWWlwZGZRb2pmd2tOanJjUmxNNTYzSEJh?=
 =?utf-8?B?dnhnc3hrRlViaUQvNWVSSDlqRmFadGQ3cEVpOUpYem9qSDZzbWcrS2tuSzNY?=
 =?utf-8?B?RGJTU1Jxd1ViMUw4MjZ6bUlKNFNkSVRKKzZ5c25TS1lCakxFQUZxbFZQTGFj?=
 =?utf-8?B?QStlUHVwZ2tzUHBlaTZMaE95b3Y4QXk5Y0gyZFNzRGl0MjdlMFFhTkhqbmF5?=
 =?utf-8?B?UFNxT05JWi9CZ1ZCRkY4UVlpZ1ZHY013VS9lNmFOczluNDVSQU9ldE5PK3RR?=
 =?utf-8?B?anhzU0pIZGRhWHBFbDNYZURvMzZ6WFF3U3VaUXF1TzFmU1RDSHA3ZlY1OEpE?=
 =?utf-8?B?OE9JbUdRUng0VHJvdkdaaG1ZeGlycldGcWFlbjlBVTlqOS94Zm14aDc1VnQy?=
 =?utf-8?B?R2JGTXUreUtWUUxjUEVJSXRKVXdpVkhpZzR6ZnBnMUFlUm1BNzhYT1lzQnA5?=
 =?utf-8?B?eSs2ZHZOdlFwbEljVWwyMmpMaVFGZGFWT2NIWXRhblh3NEtDWkQrOEhwdUx0?=
 =?utf-8?B?ZnNMTXN3YjFobkxidWZPcjRuM3prQzUwaWN0WVlDMzBZSjFwdjRmL002SjNo?=
 =?utf-8?Q?gWxcPC02Is87+XoUz3MeQY2oR/OZSpLuqJ3ZY1W?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <777A82850F9084458FEB331658751627@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5b94f3-1666-4814-0d94-08d92a7e2324
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 13:05:49.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0fk4xqV327nqYVFZRYhaFiUXs7vILugRKaPK/pjeWmhW3ZUJEImB3JyGJs0kF2JyQfd0hdEO2oLBkl0d461BnS+PzSYiYO6uJyVQxblpqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTAyIGF0IDE0OjEyIC0wNzAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQo+
IFNpZ25hbCBib29zdDoNCj4gSSd2ZSBzZWVuIGlzc3VlcyBpbiB0aGlzIGNvZGUgaW4gdGhlIHBh
c3QsIGFzIHRoaXMgaXMgYSBjdXN0b20gZm9ybWF0LA0KPiB0aGUgZG9jcyBhcmUgbm9uLXB1Ymxp
YywgaXQgaW50ZXJhY3RzIHdpdGggQUNQSSB0YWJsZXMgdGhhdCBJbnRlbA0KPiBkb2Vzbid0IGFs
d2F5cyBnZXQgdG8gcmV2aWV3LCBhbmQgdGhlIHBhcnNpbmcgaXMgYWxsIHdyaXR0ZW4gaW4gQy4u
Lg0KPiAuLi5JIGFsc28gdGhpbmsgRGFuJ3Mgc3RhdGljIGNoZWNrZXIgd2FybmluZyBiZWxvdyBp
cyBjb3JyZWN0Lg0KPiANCj4gTHVjYSwgaGFzIHRoaXMgYmVlbiBhZGRyZXNzZWQgeWV0Pw0KDQpZ
b3UncmUgcmlnaHQsIHRoZSBpc3N1ZSB0aGF0IERhbiBwb2ludGVkIG91dCBpcyBpbmRlZWQgYW4g
aXNzdWUuICBJJ2xsDQpzZW5kIGEgZml4IGFzIGV4cGxhaW5lZCBpbiBteSBwcmV2aW91cyBlbWFp
bC4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
