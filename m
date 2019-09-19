Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61BB7B37
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbfISNwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 09:52:35 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:34912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387924AbfISNwe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 09:52:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8Co5da7ARoXHfm55TTf+w6S3UzCCL47kxApm3h/L4A8rv+izIXCrGAqwg6sycCRXqniVhOR/AQdT6tX0PuoHy8dnhI1KQJg5YX/Ejgk4I39Jc2HF2B8a+9AQ0rKeIGaI0osemFcj3ZryTFL1Cv936GcOoJ8XKilA+dZ5VwksRdHxGW5BYU03KmYqcjHeykHY6csUojbyIf/ktlFECE3yPXxBKvXxkLurm7AuWGxBKpMDaJKlNl6s4o4meSsqVdMJSQro2FH7mVefwOjQU9XD+FuEJ59LmjYVUKhp50FR76KPP5I4Ej2i392bJfviLOoM8ikFRPgl5v7ZJDC9L6UtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqNWfJxy/CWzD6OeIYMk2l7RnErTKIsL4U5WwzVKuYM=;
 b=knN8K1nQCN3+9Dys6TG1lbeXQma/c7xWURRnscwJnGknjiEzM7vaLhL9RcGhNlLvorf7gPYy9wwX1+AXEypug7nyYYzO7BmdpHhxA2jdjbP4limkoUpFeHyUH34rh2DrnWOnmZS48VWjRb8MXJmeJxP7tuccy6lp6uSZ2b7O+bpF1dui5lr+V0zqQg8lHIIM1P8pOPD5KTqMp4n9kf/xXA0P9y1kKh7vMltwoI6meniNEtsVftxBqSIKfzhSiZ6HJjUtCKazh7h7zjsGsrlizlyWtFUaJTB6iMZ5stb+4jcuCzHkZg5ExRCoqnSXsQyXUlJ7VM51c//kWmEp4pU2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqNWfJxy/CWzD6OeIYMk2l7RnErTKIsL4U5WwzVKuYM=;
 b=b/0vnucXhX5jl8qv2uAlkPXkOtjXwBcmIcPFh7GRfFLhJyft4cKukPuhneSWAe4WJtBIUukW/h/fZvMUstkgC26tQHqMWh28kVd9IUFD/ifrY5oWUwH6jdNpRMxz5I3azZF5Mwa6zX3qDvqxq4UM2RbrAF8+tJAbIYBxHVbGuzs=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (20.179.149.217) by
 MN2PR11MB4400.namprd11.prod.outlook.com (52.135.37.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Thu, 19 Sep 2019 13:52:29 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 13:52:29 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Le Goff <David.Legoff@silabs.com>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>
Subject: [PATCH v2 00/20] Add support for Silicon Labs WiFi chip WF200 and
 further
Thread-Topic: [PATCH v2 00/20] Add support for Silicon Labs WiFi chip WF200
 and further
Thread-Index: AQHVbvF5D+UjeNCK102+Pvb9efuQpQ==
Date:   Thu, 19 Sep 2019 13:52:28 +0000
Message-ID: <20190919135220.30663-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 492ef907-d106-4e46-8181-08d73d089c9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB4400;
x-ms-traffictypediagnostic: MN2PR11MB4400:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4400586A26A0A0753C0AADA993890@MN2PR11MB4400.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(39850400004)(136003)(366004)(396003)(346002)(189003)(199004)(53754006)(3846002)(8676002)(76116006)(476003)(25786009)(2616005)(6116002)(54906003)(71190400001)(6436002)(102836004)(6486002)(6306002)(36756003)(186003)(71200400001)(26005)(305945005)(6512007)(966005)(99286004)(6506007)(91956017)(7736002)(8936002)(256004)(81156014)(14444005)(2906002)(66066001)(107886003)(4326008)(86362001)(14454004)(478600001)(64756008)(81166006)(2501003)(486006)(66574012)(316002)(66946007)(66446008)(66556008)(5660300002)(66476007)(1076003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4400;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WAxsL0Xq2MwSs3hTHsaA3ZLssGFS1FpIMtVMm+p6L1U9fndMwdWYxIXqFBjv3/JbsVQrm9foG2yFv3TeveEIk8w1SFMVcx1K0RljMuYdtzOYPmIJg9oH7lh/fCGt+xM4hGRCxVMwRka0PFkqNtqEm3cPzb4CKnPy2cBiJvq29n6yeDdFNpwru1F5gKcrLxCkaKMwM88u5WQYwe9/gU4ZgQhZ6f2spfOX0dGopZ4tGfTgx3OkLKSczBYm2Vtuh3cKhsqIAfMVowr4yUUFGgy+5IUhG96phJY3mAy3z2TDV4UyuG648ZPhKoFHdiUDldllxTUQG+FGH6C2+Cd9tKNAIdJEz8II2A3qG8QAfaFS8M2/EabPoc1trnydWfTiY+JiuV+Gh9F2xwtx2xGTlyvqErlaDMX9Lgf5H2RK9Cr7EY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67223C42AAE63A4F918638EA6A888675@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ef907-d106-4e46-8181-08d73d089c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:52:28.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oedqu9qq2g2bbcmxr1zc0QhMqWoo+l2/6m1SmxhDINNbXjp9nXXUtWeVpCqXDVSp7HJg+/Y0NggFPzWF1JrMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4400
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpI
ZWxsbyBhbGwsDQoNClRoaXMgc2VyaWVzIGFkZCBzdXBwb3J0IGZvciBTaWxpY29uIExhYnMgV2lG
aSBjaGlwIFdGMjAwIGFuZCBmdXJ0aGVyOg0KDQogICBodHRwczovL3d3dy5zaWxhYnMuY29tL2Rv
Y3VtZW50cy9wdWJsaWMvZGF0YS1zaGVldHMvd2YyMDAtZGF0YXNoZWV0LnBkZg0KDQpUaGlzIGRy
aXZlciBpcyBhbiBleHBvcnQgZnJvbToNCg0KICAgaHR0cHM6Ly9naXRodWIuY29tL1NpbGljb25M
YWJzL3dmeC1saW51eC1kcml2ZXIvDQogICANCkkgc3F1YXNoZWQgYWxsIGNvbW1pdHMgZnJvbSBn
aXRodWIgKGl0IGRlZmluaXRlbHkgZG9lcyBub3QgbWFrZSBzZW5zZSB0bw0KaW1wb3J0IGhpc3Rv
cnkpLiBUaGVuIEkgc3BsaXQgaXQgaW4gY29tcHJlaGVuc2libGUgKGF0IGxlYXN0IHRyeSB0byBi
ZSkNCmNvbW1pdHMuIEkgaG9wZSBpdCB3aWxsIGhlbHAgcmVhZGVycyB0byB1bmRlcnN0YW5kIGRy
aXZlciBhcmNoaXRlY3R1cmUuDQpJTUhPLCBmaXJzdHMgY29tbWl0cyBhcmUgY2xlYW4gZW5vdWdo
IHRvIGJlIHJldmlld2VkLiBUaGluZ3MgZ2V0IG1vcmUNCmRpZmZpY3VsdCB3aGVuIEkgaW50cm9k
dWNlIG1hYzgwMTEgQVBJLiBJIHRyaWVkIHRvIGV4dHJhY3QgaW1wb3J0YW50DQpwYXJ0cyBsaWtl
IFJ4L1R4IHByb2Nlc3MgYnV0LCBiaWcgYW5kIGNvbXBsZXggcGF0Y2hlcyBzZWVtIHVuYXZvaWRh
YmxlDQppbiB0aGlzIHBhcnQuDQoNCkFyY2hpdGVjdHVyZSBpdHNlbGYgaXMgZGVzY3JpYmVkIGlu
IGNvbW1pdCBtZXNzYWdlcy4NCg0KVGhlIHNlcmllcyBiZWxvdyBpcyBhbGlnbmVkIG9uIHZlcnNp
b24gMi4zLjEgb24gZ2l0aHViLiBJZiBjb21wYXJlIHRoaXMNCnNlcmllcyB3aXRoIGdpdGh1Yiwg
eW91IHdpbGwgZmluZCB0cmFkaXRpb25hbCBkaWZmZXJlbmNlcyBiZXR3ZWVuDQpleHRlcm5hbCBh
bmQgYSBpbi10cmVlIGRyaXZlcjogRG9jdW1lbnRhdGlvbiwgYnVpbGQgaW5mcmFzdHJ1Y3R1cmUs
DQpjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIga2VybmVsIHJldmlzaW9ucywgZXRjLi4uIEluIGFk
ZCwgSSBkcm9wcGVkIGFsbA0KY29kZSBpbiBDT05GSUdfV0ZYX1NFQ1VSRV9MSU5LLiBJbmRlZWQs
ICJTZWN1cmUgTGluayIgZmVhdHVyZSBkZXBlbmRzDQpvbiBtYmVkdGxzIGFuZCBJIGRvbid0IHRo
aW5rIHRvIHB1bGwgbWJlZHRscyBpbiBrZXJuZWwgaXMgYW4gb3B0aW9uDQooc2VlICJUT0RPIiBm
aWxlIGluIGZpcnN0IGNvbW1pdCkuDQoNCg0KQ2hhbmdlcyBpbiB2MjoNCiAgLSBBZGQgVE9ETyBm
aWxlIChhbmQgZHJvcHBlZCB0b2RvIGxpc3QgZnJvbSBjb3ZlciBsZXR0ZXIpDQogIC0gRHJvcCBj
b2RlIHJlbGF0aXZlIHRvIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciBrZXJuZWxzDQogIA0KSsOp
csO0bWUgUG91aWxsZXIgKDIwKToNCiAgc3RhZ2luZzogd2Z4OiBhZGQgaW5mcmFzdHJ1Y3R1cmUg
Zm9yIG5ldyBkcml2ZXINCiAgc3RhZ2luZzogd2Z4OiBhZGQgc3VwcG9ydCBmb3IgSS9PIGFjY2Vz
cw0KICBzdGFnaW5nOiB3Zng6IGFkZCBJL08gQVBJDQogIHN0YWdpbmc6IHdmeDogYWRkIHRyYWNl
cG9pbnRzIGZvciBJL08gYWNjZXNzDQogIHN0YWdpbmc6IHdmeDogbG9hZCBmaXJtd2FyZQ0KICBz
dGFnaW5nOiB3Zng6IGltcG9ydCBISUYgQVBJIGhlYWRlcnMNCiAgc3RhZ2luZzogd2Z4OiBhZGQg
SVJRIGhhbmRsaW5nDQogIHN0YWdpbmc6IHdmeDogYWRkIHRyYWNlcG9pbnRzIGZvciBISUYNCiAg
c3RhZ2luZzogd2Z4OiBhZGQgc3VwcG9ydCBmb3Igc3RhcnQtdXAgaW5kaWNhdGlvbg0KICBzdGFn
aW5nOiB3Zng6IGluc3RhbnRpYXRlIG1hYzgwMjExIGRhdGENCiAgc3RhZ2luZzogd2Z4OiBhbGxv
dyB0byBzZW5kIGNvbW1hbmRzIHRvIGNoaXANCiAgc3RhZ2luZzogd2Z4OiBhZGQgSElGIGNvbW1h
bmRzIGhlbHBlcnMNCiAgc3RhZ2luZzogd2Z4OiBpbnRyb2R1Y2UgInNlY3VyZSBsaW5rIg0KICBz
dGFnaW5nOiB3Zng6IHNldHVwIGluaXRpYWwgY2hpcCBjb25maWd1cmF0aW9uDQogIHN0YWdpbmc6
IHdmeDogYWRkIGRlYnVnIGZpbGVzIGFuZCB0cmFjZSBkZWJ1ZyBldmVudHMNCiAgc3RhZ2luZzog
d2Z4OiBhbGxvdyB0byBzZW5kIDgwMi4xMSBmcmFtZXMNCiAgc3RhZ2luZzogd2Z4OiBhbGxvdyB0
byByZWNlaXZlIDgwMi4xMSBmcmFtZXMNCiAgc3RhZ2luZzogd2Z4OiBhbGxvdyB0byBzY2FuIG5l
dHdvcmtzDQogIHN0YWdpbmc6IHdmeDogaW1wbGVtZW50IDgwMi4xMSBrZXkgaGFuZGxpbmcNCiAg
c3RhZ2luZzogd2Z4OiBpbXBsZW1lbnQgdGhlIHJlc3Qgb2YgbWFjODAyMTEgQVBJDQoNCiBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA1ICsNCiBkcml2
ZXJzL3N0YWdpbmcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCiBkcml2
ZXJzL3N0YWdpbmcvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiAuLi4v
YmluZGluZ3MvbmV0L3dpcmVsZXNzL3NpbGlhYnMsd2Z4LnR4dCAgICAgfCAgIDk3ICsNCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgICA3ICsNCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDI0ICsNCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L1RPRE8gICAgICAgICAgICAgICAgICAgICAgfCAgIDIwICsNCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L2JoLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMzE2ICsrKysNCiBk
cml2ZXJzL3N0YWdpbmcvd2Z4L2JoLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDMyICsNCiBk
cml2ZXJzL3N0YWdpbmcvd2Z4L2J1cy5oICAgICAgICAgICAgICAgICAgICAgfCAgIDM0ICsNCiBk
cml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zZGlvLmMgICAgICAgICAgICAgICAgfCAgMjY4ICsrKw0K
IGRyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NwaS5jICAgICAgICAgICAgICAgICB8ICAyNjQgKysr
DQogZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmMgICAgICAgICAgICAgICAgIHwgIDIwOCAr
KysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfcnguaCAgICAgICAgICAgICAgICAgfCAgIDE4
ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfdHguYyAgICAgICAgICAgICAgICAgfCAgNzk5
ICsrKysrKysrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmggICAgICAgICAgICAgICAg
IHwgICA5MyArDQogZHJpdmVycy9zdGFnaW5nL3dmeC9kZWJ1Zy5jICAgICAgICAgICAgICAgICAg
IHwgIDMwNSArKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RlYnVnLmggICAgICAgICAgICAgICAg
ICAgfCAgIDE5ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYyAgICAgICAgICAgICAgICAg
ICAgfCAgMzg3ICsrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uaCAgICAgICAgICAgICAg
ICAgICAgfCAgIDE1ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfY21kLmggICAgICAg
ICAgICAgfCAgNjgxICsrKysrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfZ2VuZXJh
bC5oICAgICAgICAgfCAgNDM3ICsrKysrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX21p
Yi5oICAgICAgICAgICAgIHwgIDU1OCArKysrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9y
eC5jICAgICAgICAgICAgICAgICAgfCAgMzM2ICsrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hp
Zl9yeC5oICAgICAgICAgICAgICAgICAgfCAgIDE4ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hp
Zl90eC5jICAgICAgICAgICAgICAgICAgfCAgNDcwICsrKysrDQogZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfdHguaCAgICAgICAgICAgICAgICAgIHwgICA2NyArDQogZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfdHhfbWliLmggICAgICAgICAgICAgIHwgIDI4MSArKysNCiBkcml2ZXJzL3N0YWdpbmcv
d2Z4L2h3aW8uYyAgICAgICAgICAgICAgICAgICAgfCAgMzM4ICsrKysNCiBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2h3aW8uaCAgICAgICAgICAgICAgICAgICAgfCAgIDc1ICsNCiBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2tleS5jICAgICAgICAgICAgICAgICAgICAgfCAgMjU4ICsrKw0KIGRyaXZlcnMvc3Rh
Z2luZy93Zngva2V5LmggICAgICAgICAgICAgICAgICAgICB8ICAgMjIgKw0KIGRyaXZlcnMvc3Rh
Z2luZy93ZngvbWFpbi5jICAgICAgICAgICAgICAgICAgICB8ICA1MDAgKysrKysNCiBkcml2ZXJz
L3N0YWdpbmcvd2Z4L21haW4uaCAgICAgICAgICAgICAgICAgICAgfCAgIDQ4ICsNCiBkcml2ZXJz
L3N0YWdpbmcvd2Z4L3F1ZXVlLmMgICAgICAgICAgICAgICAgICAgfCAgNjA2ICsrKysrKw0KIGRy
aXZlcnMvc3RhZ2luZy93ZngvcXVldWUuaCAgICAgICAgICAgICAgICAgICB8ICAgNTkgKw0KIGRy
aXZlcnMvc3RhZ2luZy93Zngvc2Nhbi5jICAgICAgICAgICAgICAgICAgICB8ICAyODkgKysrDQog
ZHJpdmVycy9zdGFnaW5nL3dmeC9zY2FuLmggICAgICAgICAgICAgICAgICAgIHwgICA0MiArDQog
ZHJpdmVycy9zdGFnaW5nL3dmeC9zZWN1cmVfbGluay5oICAgICAgICAgICAgIHwgICA0NiArDQog
ZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYyAgICAgICAgICAgICAgICAgICAgIHwgMTY0MyArKysr
KysrKysrKysrKysrKw0KIGRyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmggICAgICAgICAgICAgICAg
ICAgICB8ICAxMDEgKw0KIGRyaXZlcnMvc3RhZ2luZy93ZngvdHJhY2VzLmggICAgICAgICAgICAg
ICAgICB8ICA0MzQgKysrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oICAgICAgICAgICAg
ICAgICAgICAgfCAgMjA0ICsrDQogZHJpdmVycy9zdGFnaW5nL3dmeC93ZnhfdmVyc2lvbi5oICAg
ICAgICAgICAgIHwgICAgMyArDQogNDQgZmlsZXMgY2hhbmdlZCwgMTA0MzAgaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4L0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3Mvc2lsaWFicyx3ZngudHh0DQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvS2NvbmZpZw0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvc3RhZ2luZy93ZngvVE9ETw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2JoLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9iaC5o
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvYnVzLmgNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc2Rpby5jDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NwaS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV9yeC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvc3RhZ2luZy93ZngvZGF0YV9yeC5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3Rh
Z2luZy93ZngvZGF0YV90eC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93
ZngvZGF0YV90eC5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvZGVi
dWcuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RlYnVnLmgNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9md2lvLmMNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9md2lvLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX2NtZC5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvc3RhZ2luZy93ZngvaGlmX2FwaV9nZW5lcmFsLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX21pYi5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9z
dGFnaW5nL3dmeC9oaWZfcnguaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcv
d2Z4L2hpZl90eC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvaGlm
X3R4LmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWli
LmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmgNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9rZXkuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3N0YWdpbmcvd2Z4L2tleS5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2lu
Zy93ZngvbWFpbi5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvbWFp
bi5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvcXVldWUuYw0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4L3F1ZXVlLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9zY2FuLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zdGFnaW5nL3dmeC9zY2FuLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9z
dGFnaW5nL3dmeC9zZWN1cmVfbGluay5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3Rh
Z2luZy93Zngvc3RhLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9z
dGEuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4L3RyYWNlcy5oDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93Zngvd2Z4LmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC93ZnhfdmVyc2lvbi5oDQoNCi0tIA0KMi4yMC4x
DQoNCi0tIA0KSsOpcsO0bWUgUG91aWxsZXINClNpbGljb24gTGFicw==
