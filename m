Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA83227530C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Sep 2020 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIWIQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Sep 2020 04:16:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:36884 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWIQ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Sep 2020 04:16:58 -0400
IronPort-SDR: M1/UogoCEuiNzbTw03Jd3e02jljp3SYbPuiigpJYsHXUIEUiQiuAE+YzkhliaEK6OMrBEWJmGi
 i+CjBaJ/LCLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222405665"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="222405665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 01:16:57 -0700
IronPort-SDR: kV4Z3LNJWoS7RMBWiWjA0Lz+xSziLX9RslAAp762uSYOhNctP7T8X1Nb/I8LjO07nQu5UQooS8
 xjrQ/Ls0lyWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="510907980"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2020 01:16:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 01:16:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Sep 2020 01:16:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 23 Sep 2020 01:16:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlcOkQ27U3KnvlbUMih32AYuRHvBCjbYDQw1eu9TGK5D8LqGIPASzPuJxGEawi8xQ0E1yf3XTmEbcaXrVQpVgbfASfNoC97n03SjaLZE6VxuVKaA3j3Nd51B6pqoIsCyyhiAdTuPK9uLcKYL0xOg5cjkReD8K7WVBZWvdddotjkjwtNeZAN+A0hXlXe7GuelGODuCPnz4DUiAH2N9lcF0DAbrvw11Sajrz7kLP6U/PaiPztDdl2B4x08AsWQLgJMvxqnqTXIRByG+VbneUqKsZZ4Ym5e6c1Y5ZzNTdrCQ2vINncTcgaQ4Za28CdLwKnXprdHj4W/wZD4kjVgwCSUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVOqKja2HKXpFnmHCk3XFoLpQQBCk0vMRCMlTMQlMe0=;
 b=DlZ/FMnZXg07GBDCX1AsO+1+d7mNH7FeevLmchdsv9kgwXvlSpuLo1bC3WhTlQNnqLt8VhiiQtImevdy6fgn3qr96AYs//EE5kQ37E9ZwIt2s4rZZO/j2tOGBk8LCav2ant3bGJaU1kB+bTrgM67xNtVLDeaehQG8lqwSBvHrCmRLSMzwWyebpuMoBNBEio8B4zTWIOdGqv87N0RRp3/7wEok9xN7P/r3uphOqDkAyO8axtGW1ZW4q47nJDD19pZ5SuNMHv+5ZyvDSWI6j2oQs1Eiegc14WLaxYo2S/5hGyA3vdIb6UZZkaTEd2NKIcYspgLMvhQp7LP9OYSZMh/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVOqKja2HKXpFnmHCk3XFoLpQQBCk0vMRCMlTMQlMe0=;
 b=wDZVBL51DU2jCpU3EhiIW1r1jC0OiiaKyLYpNb8pKu8l7MSe6vd/lUgRGInTqCGx0buwMRYD2otPXgTCFemnsUP9x+eP5oFBpBO/p5a1wToNz1EBQjQEJjW8kJaB4MJTz0wOHMaYzdFc84iOZLEYmFQlEXRSUt3zZa5QOhHkJlA=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2855.namprd11.prod.outlook.com (2603:10b6:a02:ca::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 08:16:45 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::80d9:6be4:2116:c79c]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::80d9:6be4:2116:c79c%5]) with mapi id 15.20.3391.026; Wed, 23 Sep 2020
 08:16:45 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sugandhgowda@gmail.com" <sugandhgowda@gmail.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Cedric.Izoard@ceva-dsp.com" <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Subject: Re: Configuring WiFi6 in hostapd
Thread-Topic: Configuring WiFi6 in hostapd
Thread-Index: AQHWiF6UWtb12ODeT0iq8bBO8Zo6qalj0kUAgAf+kACACiIqAA==
Date:   Wed, 23 Sep 2020 08:16:44 +0000
Message-ID: <27c3af2e3128614ffe6321a95935378f35fee1b3.camel@intel.com>
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
In-Reply-To: <CABPxzYKPHXtJHP4FhdrtJ763ZeHwf4bjyPOr5c7g_88r_pSdLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.233.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52785ec6-dbb5-488f-52d9-08d85f990294
x-ms-traffictypediagnostic: BYAPR11MB2855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2855F1FD77C1FE67F1F1427390380@BYAPR11MB2855.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qM0uxX5clKpD2DrvAi1KkyIIifT1VW4kqGpJNnRhVu9F/vpzYpKRjfVJL1gyE2FRXIcx+k5UE/sHj3Om4xG+EI4QQ+ely7oefA90HPyjcN3Nw8txxRvCiAdbuKikNf6G7dy9VajNJeOHav/YTgwvNsLRTFzxBP5+muW3uVv99cVMUKW+kugZ7yWr6SJKUZJY6kBe76dUKwMW7UJOtM2xbmP0SwSTekEPnH1wrcKG/mYhxG4lfarxs1omVwjfd2Ljah1ZrZ1X0AlHB/nu8TWjo4o/Ysket6oaF29u7HggRiCdH1V1VR7Ls/XKT0cNW9gO+0F+DSzqhinkAwJRTBnUTOD2uYRBMELtOTZG0rY2kKxRTxJGWoNiDXR6VT6VszU7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(36756003)(2616005)(6506007)(8676002)(8936002)(2906002)(5660300002)(53546011)(91956017)(66946007)(66446008)(64756008)(66556008)(6486002)(66476007)(76116006)(110136005)(71200400001)(316002)(6512007)(83380400001)(54906003)(186003)(86362001)(478600001)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GQQ5IGRy03cgbIkvlkXNNyLdjo9LoyJiuyqPf9rkzcd1KEynsR3TGvJ9UCu//axrXtRKxoiMrTX2YCE73BX4iE6TjKyoJDuVkYwg/KTmEu0Dh33IcB+AsfUzCGM7hvbkbGtLcsjTZEX7xtQ8oR/zCJfsNCyOp6jVaSTsMSE06ZuB6LuxRIroQVAdlb5TEIjk26qxqvfgoEg1SXSzhuqLkf7Nd34Yrdl/sS6a+vWFlBNuuxo31YLsTtk8gA54yP+XP/eftW5axccM6whU1Bv/3ooPEozYvKPH6pFuG895Wt0PRtn6vpQRcB9u2U5Yf88YVxeF5Nu1yfyKQGHjd3iEdWmmQGtGwy8VzhJXXoOKCyhqtkYkir6U5KqvSi/3a70+YT9ucNT1eDjsgJsD+4hscgF8TRHBR8jj1qzaVkK1gRAA+M+ixqocKX3QBBWlnkxMvqv0GG6ck/446IpKx3RK/dbtWFigQbmx4aHnoYF+JHpsx7Nr0bhM49C2ZuCZyZs0VzCUNXcKhJAOc8CX1+guSIVoAXW9WF+PafwvliAYncDwwEbUjDdGlvEMdpCXcDuBci95IZdszCrUwj9gbApNUI+iWGVwqlhF9uS2B9wNcUCsKXG0UMyLt20Ex8L/lzqRaznpHkshdJnoiA4ozAvQNw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0DD3D0937B3E46B1B4B0B9D4794B62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52785ec6-dbb5-488f-52d9-08d85f990294
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 08:16:44.9213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nvM0bdyrTMPu28oOSP4iInRLmMe+vgoh9rKiNpFzx+lin01FcTpwTUOYEKuEw+by1JTtsD3op/CXYRU6ICuNgM+qO58u1xSYgJGeb41oog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2855
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTE3IGF0IDAzOjAxICswNTMwLCBLcmlzaG5hIENoYWl0YW55YSB3cm90
ZToNCj4gT24gU2F0LCBTZXAgMTIsIDIwMjAgYXQgMTI6NTYgQU0gS3Jpc2huYSBDaGFpdGFueWEN
Cj4gPGNoYWl0YW55YS5tZ2l0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMTEs
IDIwMjAgYXQgMTA6NDEgUE0gSm9oYW5uZXMgQmVyZw0KPiA+IDxqb2hhbm5lc0BzaXBzb2x1dGlv
bnMubmV0PiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAyMC0wOS0xMSBhdCAyMDozNyArMDUzMCwg
S3Jpc2huYSBDaGFpdGFueWEgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gPiBbICAyMjguMzE1Mjkw
XSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDAwMjA3OCB8IEFEVkFOQ0VEX1NZU0FTU0VSVA0K
PiA+ID4gPiA+IFsgIDIyOC4zMTUyOTRdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwQTBBMjAw
IHwgdHJtX2h3X3N0YXR1czANCj4gPiA+ID4gPiBbICAyMjguMzE1Mjk3XSBpd2x3aWZpIDAwMDA6
MDM6MDAuMDogMHgwMDAwMDAwMCB8IHRybV9od19zdGF0dXMxDQo+ID4gPiA+ID4gWyAgMjI4LjMx
NTMwMF0gaXdsd2lmaSAwMDAwOjAzOjAwLjA6IDB4MDA0RjhFM0MgfCBicmFuY2hsaW5rMg0KPiA+
ID4gPiA+IFsgIDIyOC4zMTUzMDNdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDAwNEU0RkY0IHwg
aW50ZXJydXB0bGluazENCj4gPiA+ID4gPiBbICAyMjguMzE1MzA3XSBpd2x3aWZpIDAwMDA6MDM6
MDAuMDogMHgwMDRFNEZGNCB8IGludGVycnVwdGxpbmsyDQo+ID4gPiA+ID4gWyAgMjI4LjMxNTMx
MF0gaXdsd2lmaSAwMDAwOjAzOjAwLjA6IDB4MDcwMDAxMDEgfCBkYXRhMQ0KPiA+ID4gPiA+IFsg
IDIyOC4zMTUzMTNdIGl3bHdpZmkgMDAwMDowMzowMC4wOiAweDQ4MzA4NDAzIHwgZGF0YTINCj4g
PiA+ID4gPiBbICAyMjguMzE1MzE2XSBpd2x3aWZpIDAwMDA6MDM6MDAuMDogMHgwMDAwMDAwNSB8
IGRhdGEzDQo+ID4gPiANCj4gPiA+IFRoaXMgbWVhbnMgdGhhdCB3ZSBnb3QgYW4gaW52YWxpZCBU
WCByYXRlLCBub3RhYmx5IGFuIEhFIHJhdGUgd2FzDQo+ID4gPiByZXF1ZXN0ZWQvY29uZmlndXJl
ZCBvbiBhIE1BQyBjb25maWd1cmF0aW9uIHRoYXQgZGlkbid0IGhhdmUgSEUuDQo+ID4gPiANCj4g
PiA+IEkgdGhpbmsgSSBzYXcgc29tZSBwYXRjaGVzIGluIHRoaXMgYXJlYSAoY29uZmlndXJpbmcg
dGhlIE1BQyB0byBiZSBIRSkNCj4gPiA+IGZseSBieSBpbnRlcm5hbGx5IHJlY2VudGx5LCBidXQg
bm90IHN1cmUuLi4gTHVjYSBwcm9iYWJseSBrbm93cy4NCj4gPiBBaCBva2F5LiBUaGlzIHdhcyBy
ZXBvcnRlZCBvbiA1LjQga2VybmVsLCBkbyB5b3UgdGhpbmsgaXMgaXQgd29ydGgNCj4gPiB0cnlp
bmcgb24gbGF0ZXN0IGl3bHdpZmktbmV4dCB0cmVlPyBPciBhcyB5b3UgYXJlIHJlZmVycmluZyB0
byB0aGUgaW50ZXJuYWwgdHJlZQ0KPiA+IHRoZSBpc3N1ZSBpcyBwcmVzZW50IGluIHRoZSBsYXRl
c3QgYXMgd2VsbD8NCj4gSGkgTHVjYSwNCj4gDQo+IENhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29r
PyBBbnkgaGVscCBpcyBhcHByZWNpYXRlZC4NCg0KSGksDQoNClRoZXJlIGhhdmUgYmVlbiBzb21l
IG5ldyBwYXRjaGVzIGluIHRoaXMgYXJlYSwgYnV0IGFmdGVyIGEgcXVpY2sgbG9vayBJDQpkaWRu
J3QgZmluZCBhbnl0aGluZyBzcGVjaWZpYyB0aGF0IGp1bXBzIG91dC4gIEknbGwgdGFrZSBhIGNs
b3NlciBsb29rDQphbmQgbGV0IHlvdSBrbm93IGlmIEkgZmluZCBhbnl0aGluZy4NCg0KLS0NCkNo
ZWVycywNCkx1Y2EuDQoNCg==
