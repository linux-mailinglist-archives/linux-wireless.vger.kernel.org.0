Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBC28EC99
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJOFWA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 01:22:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:63074 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgJOFWA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 01:22:00 -0400
IronPort-SDR: iKyYJfKNSRRqzrldubWiZLxppsHGOF7C6cbaLdQsdHr7P/7yG/BVKftUWgzcTnc6zvgP1pqCvP
 L3n+6Y1WVukw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="227913803"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="227913803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 22:21:59 -0700
IronPort-SDR: f2WuME7EaGK0qKb2DJubYqBV/BYyP21MSqHJ0rsYC6LM6tdEXV/pvBDFQeR9M1qyuIOB2Op5lp
 vWNaak0niz2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="346738727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2020 22:21:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 22:21:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 22:21:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 22:21:58 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 22:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ5ItXngpbKpCzrbOWjmjG4W6HECAoB5ELkLcCcu3T+kyz7/Gcl6/J3MQPkB9fZK6irMSfEmOYSE+zkIWhLvJ4yJV/G+V6073f6h6XhrCTelxTaE6E2hq7c4+kmqkMrMmyfYFlCWUOJK2hxPLYwrIum5kKJHm3wBKEbgUmWQzhDhd8yiSykuJ1Wy/kuoeqMOhaCe7yoY3/SDPExTVxlbu0XbZO4gGOhfmk1iJhYbwgMwh+sX0BPHlX06g2tzXQZw66qMX28DEZSQ5RAVfIkpCAduWaHRn9vuLGpJ+L4ulUVv3hZbxWovI/I9fZkdHULPcRFZsvSXi1gS0cPnOB9wLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0u4L1JP5eUM7lnyQTvuw3uKtiZmjzZJ8y8mDpnkMBg=;
 b=YOULVhouI9Ky3OF5aI7C2aGQAVHm/rNoeVrzaFfVcyKeq2IBatfN3fIXIUYs6GIUIm9eDuapTEEDrkFwyR9nMm/LAzplbXDbKt6zpvukyqsFoICu1C/6pBUbYc/6P84aC3XI/oeoS4QxnqPy99s3QJ57dfaAOEroOFGBw/r2HbViR8SrYQ4dCQQ/cdYbTi10cLVcG3Y98FPZ6r7zdl5xF6M9m/3v3/0487MxJe1c8aamYcaujm72A+q4WJf3tarKxT1YD+gY97/LsZG8Rr52nWgpKO0yBM1Thr8uNRsCR60uOitlkcFugEN8wYJR5hYLXSf3bQPdF7n14lzHhTxx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0u4L1JP5eUM7lnyQTvuw3uKtiZmjzZJ8y8mDpnkMBg=;
 b=wjO2Om/YzPz7tlmz4mbuGZK/Q/rxQsDptJwVxo833ITgd0fRSvfg0lkoaJSYZN5pWQsWIjO+Cfn0XCj/J9QaJTiMCxs46SVkzkJ+5QD2E3NrjPNmH8zcmVAKFcwGbBUwaOSgLxfkWNWDAeZFvhfPNQ8E1wlbUR0hqjHkSDkirXI=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 05:21:48 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::718c:ac63:d72e:f3c9]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::718c:ac63:d72e:f3c9%4]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 05:21:48 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "sugandhgowda@gmail.com" <sugandhgowda@gmail.com>,
        "Damary, Guy" <guy.damary@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Cedric.Izoard@ceva-dsp.com" <Cedric.Izoard@ceva-dsp.com>,
        "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Subject: Re: Configuring WiFi6 in hostapd
Thread-Topic: Configuring WiFi6 in hostapd
Thread-Index: AQHWiF6UWtb12ODeT0iq8bBO8Zo6qalj0kUAgAf+kACACiIqAIAABYeAgAu/QoCAFp2igA==
Date:   Thu, 15 Oct 2020 05:21:48 +0000
Message-ID: <a28a4e6d72c4e0dca24c8206effa723f20bfc0fe.camel@intel.com>
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
         <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
         <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
         <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
         <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
         <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
         <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
         <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
         <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
         <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
         <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
         <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
         <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
         <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
         <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
         <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
         <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
         <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
         <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
         <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
         <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
         <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
         <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
         <CABPxzYLEZ5KU5x3w9rex3SQqj+TwGXFOXnC_QXdEu9NLfcRHMQ@mail.gmail.com>
         <CABPxzYKPHXtJHP4FhdrtJ763ZeHwf4bjyPOr5c7g_88r_pSdLQ@mail.gmail.com>
         <27c3af2e3128614ffe6321a95935378f35fee1b3.camel@intel.com>
         <e2cd5f5c162373e367d0e94bf2250e9a7f8144d2.camel@intel.com>
         <CAD_iCC8qJ_Xaa5yjkdzapGCtJsAt2VbYzTfgpUDCeT7RpyrBjw@mail.gmail.com>
In-Reply-To: <CAD_iCC8qJ_Xaa5yjkdzapGCtJsAt2VbYzTfgpUDCeT7RpyrBjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96982565-2ee1-44e2-3e50-08d870ca3756
x-ms-traffictypediagnostic: SJ0PR11MB4989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49899D5D67F18BB4F76DFB2E90020@SJ0PR11MB4989.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEcmsqFlicWxalQtmOU5steGAfNqe8qLAXfx8rzSMcT6O0kgVvbm2sbN84fWiIwJ9pSYoFU6Mc1b59Muhtms6LdK5eU8RZIs4jKLyzC63hyMDqo79Fj5EGfGsnZu05oO23h9FPtCDF1I9qNm8OkgaNYUprAuy+KT+IC4T0SrU2fvClYCUo4sBWpDGtt7y7cAtshD/Lgi80AZCWEcdC6394jkc+f7KF8YmDujFd0TKc/F0k87ZTa6qHUI1P6R3xXCyxuJ6mRYA8b7Od+irqgcwnlAr5eIkg7eJKTtyKgsNp3CHQ7mKLfIblaC2zIUBhANQMUeGx9RKuNgqvug4aeqDVRf8VfupYmLQRIjZyA2y8lMWIxy5G+8zwD0MzPeORxiSLK0fC51XelfRZoHqt1Gug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(5660300002)(478600001)(110136005)(6506007)(2616005)(6636002)(6486002)(86362001)(54906003)(186003)(53546011)(316002)(26005)(83080400001)(91956017)(4326008)(76116006)(8676002)(966005)(71200400001)(8936002)(6512007)(36756003)(2906002)(19627235002)(66476007)(66556008)(66946007)(83380400001)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cawdNbzaZB22eghrebfNCnncbebXoGjf04IwItgK8knxNUu2QB7zUZFUSF9Agh0X+knqXVLvxLkaCRJCm4A27TREXZKFIzldoNJ9WFmfL4qONzAHg4lHGS4jgqJFZH0pba1UdRbo5cUbD2lLLQHB27VuYg0OydsGELzwFdo9JyhihUflQPBddn8nId6vItdngOsUpmyuFRawFbGBHpG3i9snKNbwBW4ML8437f2c5E/kzs2cZoLOwgeWyAx8E0+ForjsjO2IEXtM6NIEANyoTPFa67+7w2dWebxkbKDonIH8rwhnERq/0afsBTxRzw+Y/JMPgV/DXDk+MbLE2YahpxA0c4PZ0zMCRCq0RyRvqImMULi+tsaBTm+VcCAw90VBhO1QfMocnvr72whOtrc0Gh0E3ACivmbLU7SVFTij5oGGNyy85E6LvNc58bW9gAuzOacgl+BHb1Ool3mogVaxzw4WY5s3pPN62MH5TJTAA6cT5QaTUBWpqqi3Ayl8+4E5bcDZZt/90pgXxk/a5ZOT19Nb2YPNnLNUeEYSSwZNTZQEB/deZL5QAQa54iJCwKLTD11sIGd2gv234W0dqZEnom08yaU+PgfUXXKvGzV1fxBeZgzxYwxX2b+yeG8r3nj35RV+C/jY9ytnVj8uKW1ooA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <98C1B89D43C62649AA65B36708011471@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96982565-2ee1-44e2-3e50-08d870ca3756
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 05:21:48.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbPMrMblvv4UpTisxb04K1xMf3e8/LVGmDGsZsIE4W2tk13ojnlj6W9juTkfg76gsbImR5q3Rr/zBxtbliYrz6gKgbsIc7JchoLYkctULvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTMwIGF0IDIxOjU5ICswMjAwLCBTdWdhbmRoIEh1dGhhbmFoYWxseSBN
b2hhbiB3cm90ZToNCj4gT24gV2VkLCAyMDIwLTA5LTIzIGF0IDExOjE2ICswMzAwLCBMdWNpYW5v
IENvZWxobyB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMTcgYXQgMDM6MDEgKzA1MzAsIEty
aXNobmEgQ2hhaXRhbnlhIHdyb3RlOg0KPiA+ID4gPiBPbiBTYXQsIFNlcCAxMiwgMjAyMCBhdCAx
Mjo1NiBBTSBLcmlzaG5hIENoYWl0YW55YQ0KPiA+ID4gPiA8Y2hhaXRhbnlhLm1naXQgYXQgZ21h
aWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPk9uIEZyaSwgU2VwIDExLCAyMDIwIGF0IDEwOjQxIFBN
IEpvaGFubmVzIEJlcmcNCj4gPiA+ID4gPiA8am9oYW5uZXMgYXQgc2lwc29sdXRpb25zLm5ldD4g
d3JvdGU6DQo+ID4gPiA+ID4gPk9uIEZyaSwgMjAyMC0wOS0xMSBhdCAyMDozNyArMDUzMCwgS3Jp
c2huYSBDaGFpdGFueWEgd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFsgIDIy
OC4zMTUyOTBdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwMDAyMDc4IHwgQURWQU5DRURfU1lT
QVNTRVJUDQo+ID4gPiA+ID4gPiA+ID4gWyAgMjI4LjMxNTI5NF0gaXdsd2lmaSAwMDAwOjAzOjAw
LjA6IDB4MDBBMEEyMDAgfCB0cm1faHdfc3RhdHVzMA0KPiA+ID4gPiA+ID4gPiA+IFsgIDIyOC4z
MTUyOTddIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwMDAwMDAwIHwgdHJtX2h3X3N0YXR1czEN
Cj4gPiA+ID4gPiA+ID4gPiBbICAyMjguMzE1MzAwXSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgw
MDRGOEUzQyB8IGJyYW5jaGxpbmsyDQo+ID4gPiA+ID4gPiA+ID4gWyAgMjI4LjMxNTMwM10gaXds
d2lmaSAwMDAwOjAzOjAwLjA6IDB4MDA0RTRGRjQgfCBpbnRlcnJ1cHRsaW5rMQ0KPiA+ID4gPiA+
ID4gPiA+IFsgIDIyOC4zMTUzMDddIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwNEU0RkY0IHwg
aW50ZXJydXB0bGluazINCj4gPiA+ID4gPiA+ID4gPiBbICAyMjguMzE1MzEwXSBpd2x3aWZpIDAw
MDA6MDM6MDAuMDogMHgwNzAwMDEwMSB8IGRhdGExDQo+ID4gPiA+ID4gPiA+ID4gWyAgMjI4LjMx
NTMxM10gaXdsd2lmaSAwMDAwOjAzOjAwLjA6IDB4NDgzMDg0MDMgfCBkYXRhMg0KPiA+ID4gPiA+
ID4gPiA+IFsgIDIyOC4zMTUzMTZdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwMDAwMDA1IHwg
ZGF0YTMNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIG1lYW5zIHRoYXQgd2UgZ290IGFu
IGludmFsaWQgVFggcmF0ZSwgbm90YWJseSBhbiBIRSByYXRlIHdhcw0KPiA+ID4gPiA+ID4gcmVx
dWVzdGVkL2NvbmZpZ3VyZWQgb24gYSBNQUMgY29uZmlndXJhdGlvbiB0aGF0IGRpZG4ndCBoYXZl
IEhFLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgdGhpbmsgSSBzYXcgc29tZSBwYXRjaGVz
IGluIHRoaXMgYXJlYSAoY29uZmlndXJpbmcgdGhlIE1BQyB0byBiZSBIRSkNCj4gPiA+ID4gPiA+
IGZseSBieSBpbnRlcm5hbGx5IHJlY2VudGx5LCBidXQgbm90IHN1cmUuLi4gTHVjYSBwcm9iYWJs
eSBrbm93cy4NCj4gPiA+ID4gPiBBaCBva2F5LiBUaGlzIHdhcyByZXBvcnRlZCBvbiA1LjQga2Vy
bmVsLCBkbyB5b3UgdGhpbmsgaXMgaXQgd29ydGgNCj4gPiA+ID4gPiB0cnlpbmcgb24gbGF0ZXN0
IGl3bHdpZmktbmV4dCB0cmVlPyBPciBhcyB5b3UgYXJlIHJlZmVycmluZyB0byB0aGUgaW50ZXJu
YWwgdHJlZQ0KPiA+ID4gPiA+IHRoZSBpc3N1ZSBpcyBwcmVzZW50IGluIHRoZSBsYXRlc3QgYXMg
d2VsbD8NCj4gPiA+ID4gSGkgTHVjYSwNCj4gPiA+ID4NCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2Ug
dGFrZSBhIGxvb2s/IEFueSBoZWxwIGlzIGFwcHJlY2lhdGVkLg0KPiA+ID4NCj4gPiA+IEhpLA0K
PiA+ID4NCj4gPiA+IFRoZXJlIGhhdmUgYmVlbiBzb21lIG5ldyBwYXRjaGVzIGluIHRoaXMgYXJl
YSwgYnV0IGFmdGVyIGEgcXVpY2sgbG9vayBJDQo+ID4gPiBkaWRuJ3QgZmluZCBhbnl0aGluZyBz
cGVjaWZpYyB0aGF0IGp1bXBzIG91dC4gIEknbGwgdGFrZSBhIGNsb3NlciBsb29rDQo+ID4gPiBh
bmQgbGV0IHlvdSBrbm93IGlmIEkgZmluZCBhbnl0aGluZy4NCj4gDQo+ID4gSW4gdGhlIG1lYW50
aW1lLCB5b3UgY291bGQgdHJ5IG91ciBwdWJsaWMgYmFja3BvcnQtaXdsd2lmaSB0cmVlLCB3aGVy
ZQ0KPiA+IG1vc3Qgb2YgdGhlIGludGVybmFsIHRyZWUgaXMgcHVibGlzaGVkOg0KPiA+DQo+ID4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9i
YWNrcG9ydC1pd2x3aWZpLmdpdC8NCj4gPg0KPiA+IFRoaXMgaXMgYW4gb3V0LW9mLXRyZWUgZHJp
dmVyLCBiYXNlZCBvbiB0aGUgbGludXgtYmFja3BvcnRzIHByb2plY3QuDQo+ID4gWW91IGNvdWxk
IHRyeSB0aGUgY29yZTU2IGJyYW5jaCwgZm9yIGluc3RhbmNlLCBvciBldmVuIG1hc3RlciBhbmQN
Cj4gPiBjaGVjayBpZiB0aGUgcHJvYmxlbSBpcyBzdGlsbCB0aGVyZS4gIElmIG5vdCwgd2UgY2Fu
IHRyeSB0byBsb29rIGZvcg0KPiA+IHRoZSBwYXRjaCB0aGF0IGZpeGVzIGl0IGFuZCBwdXNoIGl0
IHRvIHN0YWJsZS4NCj4gDQo+ID4gLS0NCj4gPiBDaGVlcnMsDQo+ID4gTHVjYS4NCj4gDQo+IEhl
bGxvIEx1Y2EsDQo+IA0KPiBJIHVzZWQgcHVibGljIGJhY2twb3J0IGl3bHdpZmkgdHJlZSB3aXRo
IGNvcmU1NiBicmFuY2ggYXMgeW91IHN1Z2dlc3RlZC4NCj4gSSBhbSBzdGlsbCBvYnNlcnZpbmcg
dGhlIGNyYXNoIHdoaWNoIEkgcmVwb3J0ZWQgZWFybGllci4NCj4gDQo+IEFsc28gSSB1cGdyYWRl
ZCBteSBsaW51eCBrZXJuZWwgdG8gNS44IGFuZCB0cmllZCAsIGJ1dCBzdGlsbCBvYnNlcnZpbmcN
Cj4gdGhlIHNhbWUgY3Jhc2guDQo+IEkgYW0gYXR0YWNoaW5nIHRoZSBkbWVzZy4NCj4gDQo+IEFs
c28gd2hlbiBJIHJ1biBob3N0YXBkX2NsaSAoc2VlIGJlbG93IGZvciBvdXRwdXQgKW9uIG15IEFQ
LCBJIGNvdWxkDQo+IHNlZSBIRSBmbGFnLg0KPiANCj4gPmFsbF9zdGENCj4gDQo+IDhjOmM2Ojgx
OjY5Ojg2OjY1DQo+IGZsYWdzPVtBVVRIXVtTSE9SVF9QUkVBTUJMRV1bV01NXVtIVF1bSEVdDQo+
IGFpZD0xDQo+IGNhcGFiaWxpdHk9MHg0MzENCj4gbGlzdGVuX2ludGVydmFsPTEwDQo+IHN1cHBv
cnRlZF9yYXRlcz0wMiAwNCAwYiAxNiAwYyAxMiAxOCAyNCAzMCA0OCA2MCA2Yw0KPiB0aW1lb3V0
X25leHQ9TlVMTEZVTkMgUE9MTA0KPiBkb3QxMVJTTkFTdGF0c1NUQUFkZHJlc3M9OGM6YzY6ODE6
Njk6ODY6NjUNCj4gZG90MTFSU05BU3RhdHNWZXJzaW9uPTENCj4gZG90MTFSU05BU3RhdHNTZWxl
Y3RlZFBhaXJ3aXNlQ2lwaGVyPTAwLTBmLWFjLTQNCj4gZG90MTFSU05BU3RhdHNUS0lQTG9jYWxN
SUNGYWlsdXJlcz0wDQo+IGRvdDExUlNOQVN0YXRzVEtJUFJlbW90ZU1JQ0ZhaWx1cmVzPTANCj4g
d3BhPTINCj4gQUtNU3VpdGVTZWxlY3Rvcj0wMC0wZi1hYy0yDQo+IGhvc3RhcGRXUEFQVEtTdGF0
ZT0wDQo+IGhvc3RhcGRXUEFQVEtHcm91cFN0YXRlPTANCj4gc3VwcF9vcF9jbGFzc2VzPTUxNTE1
MzU0NzM3NDc1NzY3Nzc4Nzk3YTdiN2M3ZDdlN2YNCj4gaHRfY2Fwc19pbmZvPTB4MTllNw0KPiBl
eHRfY2FwYWI9MDQwMDQwMDAwMTAwMDA0MDAwMjANCj4gDQoNCkhpIFN1Z2FuZGgsDQoNCkknbSBD
Q2luZyBHdXkgaGVyZS4gIEhlIGNhbiBoZWxwIHlvdSBnZXQgc29tZSBkZWRpY2F0ZWQgc3VwcG9y
dCBvbiB0aGlzDQppc3N1ZS4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
