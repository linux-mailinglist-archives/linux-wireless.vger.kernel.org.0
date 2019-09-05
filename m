Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5566DAA18A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfIELfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 07:35:00 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60981 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbfIELe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 07:34:59 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: PtPIRUosD9LyyRb75RUDAqPif8RNDAC6fNYr0P84QzhhFS1w/i2950s2C5u/tdw0Gme8AkG++q
 K6N2OHqQ4VSyYK+REbKpD/t9hd8uPs3zDyc+94HUuXN1sjyCyfkVXc1ogfJmYWqHPEcns//cO5
 GMZPShSYr6DbwE7DW2KVJu1giIfxcK9XgQxkt7W0MuPiPk7e5T3kMbFt8pBlvz+3uEX2LuWByM
 TT3u0EoIJEH87Lryjzj7mp0fsmavTqt1DesiwKRa22PHuy29oYG0KmA0GUm1nFuZljJG9hrU/W
 8fk=
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="47936976"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2019 04:34:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 04:34:58 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Sep 2019 04:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX4nwhnWSqOgsWso4ocCYETqcb7bIAvC4ap0WbDwM+hDx22vgaFkzhx7g5SLQa4/XbkxjgR+VcXU1y4Qo/hUGGYR1GYNLW8F3fykCfEUB3KWClZY6NTwWtdPVJiJU7eeuTw+yc7DyuRC3RpfPt6h7FFZ8W2gvEU6+fFnnPYH19TqzqS4ubhPOWaTDiVVSxYykf5r2cfJCMf0jI9+jrsPpEpYKpJym5AbjdqNaWunTYw9KfSaQZYDNHomkhsS9GfmD4OgXx34J5BhmlPXLf70NAEGOPFPWKnwHgsGZZVm+Qd8QMCiGHXcJAmSXbNRAbVv2Hy+xw0/8MT3CMX9s5u2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29FwnydSVZa44ay7U18Q8Q3QOvBIPCZSaJ2UQrkSOvQ=;
 b=mE+Hw3Zi6ZANcbfAS1D+pjiUrdUdHhBLCRxHGmbjd/CnQekkkL2NDuuzJ0MT79Q4EGhuKP3rCWSDjynr0YzF4tzS9DEx0Y4UvlW5ZcLCP1XiFS/tJXBgkgPeqVvE3ioSvKlicmHKlwxgK9gbaEsWb3OZRy+1oe4kMZ6HsMnIl2znDfS0xZmuRvg4yhheZp6Q0LFXJV0cXW9cOQdEzx2t+hlUJigeXG4XiELt2q/ghaNF6bV5Kbyb0BvWd4Pp7xVXK55GiaDGdWLFFDTf8Sn1rg6v5RSpQOiVhLCQdsTdr3PE0ys34khdo1dX0pNK56DagvsjJVn2qN+wxOAj0b5IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29FwnydSVZa44ay7U18Q8Q3QOvBIPCZSaJ2UQrkSOvQ=;
 b=qDpJAt9Y49vLpLu4I4hHGD0IC80I/oFfr8o0tYOuc6yUb3swLCuTojZb/7Fg+WTB+c6MIE1isFaA1fO2/t2h+M/HZphgiIDNhpOEQamLzMspJa0eRUdQecP5O6OgndZNJMQo4mdAx3P81VHSXwzqAR5Jk/u8caCXyeqGx9xxeyo=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1489.namprd11.prod.outlook.com (10.172.22.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 11:34:56 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83%4]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:34:56 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <greg@kroah.com>
CC:     <Eugen.Hristev@microchip.com>, <Adham.Abozaeid@microchip.com>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Topic: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Index: AQHVYyVmBkghZ7w+IkiStodl6jvpxKccmquAgAAYcQCAAEJxAA==
Date:   Thu, 5 Sep 2019 11:34:56 +0000
Message-ID: <5878d3a6-65b7-0f02-2810-57f5c060b931@microchip.com>
References: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
 <da5ea898-d8da-a6e2-97a0-4662b7d70b31@microchip.com>
 <20190905073700.GA30339@kroah.com>
In-Reply-To: <20190905073700.GA30339@kroah.com>
Reply-To: <Ajay.Kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 999e74f4-3326-4f8d-401b-08d731f513c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1489;
x-ms-traffictypediagnostic: BN6PR11MB1489:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB14898052B1CBCB84189969C5E3BB0@BN6PR11MB1489.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(136003)(376002)(346002)(396003)(189003)(199004)(52116002)(6246003)(53936002)(66066001)(31696002)(86362001)(256004)(6116002)(3846002)(2616005)(229853002)(66446008)(11346002)(64756008)(476003)(446003)(66476007)(305945005)(7736002)(6512007)(6436002)(31686004)(486006)(6306002)(36756003)(66946007)(66556008)(71190400001)(6486002)(81166006)(76176011)(3450700001)(478600001)(14454004)(81156014)(8676002)(5660300002)(6916009)(54906003)(966005)(71200400001)(316002)(2906002)(43066004)(102836004)(53546011)(6506007)(386003)(4326008)(186003)(8936002)(99286004)(25786009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1489;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p1CuM5RoWcW0AbAn/paFHiBLK4gZblthm6N43cF4qAD0fQ0JTFTsh6mFvKJGAGhJ8iOOVA0gIPEfcTZkdiknNKUb2dGG3lFwL3/1mU7ajE/GD9kvnrp6W5DAo9fK4YV15LB9y6eF0p9Yt3DsxgTAwoQkrgY37mni1TFpop4UmO7fnEbieOzhEBw9TVZ13OStoz507ud3BfbbHAyu1XSQ2soehh9LLA0L8ypx3KeWm4SK2/qoFdUtF2wfo7hbBcE4JqBgtSoypeKlxJcE2Cetj7yF9PeSqDZo3W+Hi+qoBg5dV+AJ9/yEiDSLKYfUG3m3ycZg9agaBWklc739P2H5osRUFzR5bbO1p3Xz7Z0jp44NOgpvY2Tzi2imiUihoXmtaenq4tn1AXe3VhgrOYWGxgHAKrJQyvNwzWJ0cjENRr8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25DBC010746EEB4F8B6A46E4EBFD80F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 999e74f4-3326-4f8d-401b-08d731f513c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:34:56.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NIB7JrzKfcIfl6b3wTVI7sOEHKf1lmBtIml5WPSbnn/8KAewUZY1GJZwGkd0QSwexcbehS7IfCpbehdLqF7LbS6YqePP0pfM/hZqR496EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1489
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR3JlZywNCg0KT24gMDUtU2VwLTE5IDE6MDcgUE0sIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFRo
dSwgU2VwIDA1LCAyMDE5IGF0IDA2OjA5OjQzQU0gKzAwMDAsIEFqYXkuS2F0aGF0QG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBIaSBFdWdlbiwNCj4+DQo+PiBPbiAwNC1TZXAtMTkgNzowMyBQTSwg
RXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxl
dWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBBZGQgYmluZGluZ3MgZm9yIG9w
dGlvbmFsIHJ0YyBjbG9jayBwaW4uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlz
dGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhhbmtzIGZvciBzZW5k
aW5nIHRoZSBwYXRjaCBzZXJpZXMuIFRoZSBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzIGxvb2tzDQo+
PiBnb29kIHRvIG1lLg0KPj4NCj4+IEFja2VkLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBt
aWNyb2NoaXAuY29tPg0KPiANCj4gVGhpcyBpcyBnb29kLCBidXQsIHlvdSBhcmUgYWRkaW5nIG5l
dyBmZWF0dXJlcyB0byB0aGUgZHJpdmVyLCB3aGVuIGl0IGlzDQo+IHN0aWxsIGluIHRoZSBzdGFn
aW5nIGRpcmVjdG9yeS4gIFdoYXQncyB0aGUgcGxhbiBvbiBnZXR0aW5nIGl0IG91dCBvZg0KPiBo
ZXJlPyAgV2hhdCBpcyBsZWZ0IHRvIGRvPw0KPiANCg0KVGhlIHBsYW4gaXMgdG8gZ2V0IHRoaXMg
ZHJpdmVyIHJldmlld2VkIGFuZCBpZGVudGlmeSBpZiB0aGVyZSBhcmUgYW55DQptb3JlIFRPRE8g
aXRlbXMuIFdhaXRpbmcgZm9yIHRoZSByZXZpZXcgdG8gY29tcGxldGUuDQoNCkR1cmluZyB0aGUg
bGFzdCByZXZpZXcgWzFdLCB3ZSBoYXZlIHJlY2VpdmVkIGNvbW1lbnQgdG8gc2ltcGxpZnkgdGhl
DQpwYWNraW5nIG9mIFdJRCBjb21tYW5kcyBieSBhdm9pZGluZyB0aGUgdHJhbnNsYXRpb24gbGF5
ZXIuIFdlIGhhZCBkb25lDQpzb21lIGltcHJvdmVtZW50cyBpbiB0aGlzIGJ1dCBzdGlsbCwgdGhl
cmUgYXJlIGZldyBpdGVtcyB1bmRlciBkaXNjdXNzaW9uLg0KQnV0IEkgYW0gbm90IHN1cmUgaWYg
dGhpcyBpcyBhIGJsb2NrZXIgZm9yIG1haW5saW5lIG9yIGNhbiBiZSBhZGRyZXNzZWQNCmxhdGVy
Lg0KQXQgdGhpcyB0aW1lLCBJIGRvbid0IGtub3cgaWYgdGhlcmUgYXJlIGFueSBtb3JlIFRPRE8g
Zm9yIHRoaXMgZHJpdmVyLg0KQ3VycmVudGx5IGFsc28gd29ya2luZyBvbiB0ZXN0aW5nIGFuZCBm
aXhpbmcgYnVncy4NCg0KWzFdLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxl
c3MvMTU2Mjg5NjY5Ny04MDAyLTEtZ2l0LXNlbmQtZW1haWwtYWpheS5rYXRoYXRAbWljcm9jaGlw
LmNvbS8NCg0KUmVnYXJkcywNCkFqYXkNCg==
