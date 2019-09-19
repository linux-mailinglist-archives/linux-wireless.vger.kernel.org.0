Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2EB7C83
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbfISOZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 10:25:55 -0400
Received: from mail-eopbgr780053.outbound.protection.outlook.com ([40.107.78.53]:38626
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389350AbfISOZy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 10:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAVbm3gIGG4wbEcx6dZz2+Vc68TUq4lbXGvPPQz+SyFAlIIftCiUdssMlCJvFp6mwHqDd+wgaFoevKmPcxaCB5SEM9lYVqVXas4/nKI11G5/VxuLcQhKbIKKKSoU8Mc+p0IATZ4zNIiykM8aM9GTMO1Smk3WJWBn/YVKgHZlRfaejc9AwPq7AX1NsZRZw9PnGsJBu/iIuvhSWFchAnt7qWQq1IcsNc2DUYlBjPtTCaaHZRAz/OROr86JXiegklZQ/w97NIQS5H1iZtr5MwCDqufQNkhV8874DAMG5duNqdk5rw+nMHz0Q7ZvPiqtJyi7OzRXGhzmFvgBqZ1/dndDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuS2otXZYhv5vPjSXbr2OYHe4M5DwuNOKQpSQcbgvK4=;
 b=D7VK+9jgGp1fxarjJW6likPtkxFs4rCs/pbBBRXMSPiCGhSroaBiLUrdachO5J89laezCEHqK6YJ1taTb4mEi6rvf6SnEH3ECOWN1KH2fXCoxzKgNDX6ckzJ9vNw1EYD2fe/CNTTc3KD5YNWWT+xeuyqLPlCs0oBgmJBFzdKJR8j/Umw0TNm0OYF1x7ZX1yBFOL6GOJ5Jbp2b9PLS2gx+WGuq04scQKKu0Y4nCCc2EOm95BMaxNpB9Tpp8uBq6QJXYQEiaW7Vh1U+RFsFAK8XXB4knQPUfaWYzcO+4LF31DjAcp2fRoaQQXUGp9jzBnNEHMTCw+QS5LCBbAnTuOd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuS2otXZYhv5vPjSXbr2OYHe4M5DwuNOKQpSQcbgvK4=;
 b=jXKpbgfPQ3wo+GDQZE+SA99f6TgwLiNXdxRYXNYpTVM1ZkPAlDYzysqvOHQox12L10UlJDbhvPkHpM96mVtvE+5KEIKjDmNl1Q6K15ELNuNfhhuR3xM7uZ7rAtEb3GSovhqRlRpzztYS4ZMv7R6203ZIQts9QowMMBP7wlrlJTM=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (20.179.149.217) by
 MN2PR11MB4144.namprd11.prod.outlook.com (20.179.150.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 14:25:47 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 14:25:47 +0000
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
Subject: [PATCH v3 17/20] staging: wfx: allow to receive 802.11 frames
Thread-Topic: [PATCH v3 17/20] staging: wfx: allow to receive 802.11 frames
Thread-Index: AQHVbvYgTxUc8dXR8Eu4cgfcOTIxtw==
Date:   Thu, 19 Sep 2019 14:25:46 +0000
Message-ID: <20190919142527.31797-18-Jerome.Pouiller@silabs.com>
References: <20190919142527.31797-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20190919142527.31797-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f6718c8-ebba-49a7-8f1b-08d73d0d439e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4144;
x-ms-traffictypediagnostic: MN2PR11MB4144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB414426FA34B51184F16EEAF493890@MN2PR11MB4144.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(39850400004)(346002)(199004)(189003)(43544003)(86362001)(66066001)(66574012)(2616005)(14454004)(478600001)(54906003)(8676002)(71190400001)(36756003)(71200400001)(7736002)(316002)(305945005)(110136005)(6436002)(256004)(81156014)(14444005)(6486002)(6512007)(186003)(11346002)(91956017)(486006)(446003)(26005)(2501003)(99286004)(66446008)(66946007)(76176011)(476003)(66556008)(64756008)(66476007)(4326008)(102836004)(6506007)(107886003)(5660300002)(76116006)(25786009)(81166006)(1076003)(8936002)(2906002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4144;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cu50ud30kpl/w76jDrjNbV92AplSnRuqwLmSDUEi624/9F7gzQbkurDNdtsH6Q5D8/QeoXWdwobMYT0jIpgwspg7pq7MK5NckN9wOQc62kTY1pfzSGiGdKnjn8zSt2PBAHcchsObs8qUQwat5RSCl4rYsRi3crz5NUr9Rj3RyWO6RhZlQ8i1yannBpbqUPbR6dMzjr73Dj0OM3wnuHrZpkO+hCH6Icb/OK06S6Cn2Z1fukQCeDWOLjsqa787/YbcBqZZh9DDbdAG+E4F73ZyuEfVmoyvHpuL0gBWTbOlQsrEZtFGU0UeauoOpkpoxlbIzDhwMPu0Ue5Jd98sXCliUo3mvMaPpNlr+8hTEQAmP7guYqChNsVkFGK3H44/vlb3cXXluVTuxsAk687kb6PKXiRKa62rOqkFqpp0SRPDFXE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DB318E5FD439E4AB046260B03F57D05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6718c8-ebba-49a7-8f1b-08d73d0d439e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 14:25:46.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrGBHXR0gAAj2Kj4kVNJi4dEGVFxBEZUa2XBtWnAlekKXpr3lyqUiQBF2dr1IuQpJqrnGyG4ltewfkVRKf6JxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4144
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpB
Z2FpbiwgdGhpcyB0YXNrIGlzIG1vcmUgY29tcGxleCB0aGFuIGl0IHNob3VsZCBzaW5jZSBkcml2
ZXIgdHJ5IHRvDQpoYW5kbGUgaXRzZWxmIHBvd2VyIHNhdmluZyBvZiBzdGF0aW9ucy4NCg0KU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
Pg0KLS0tDQogZHJpdmVycy9zdGFnaW5nL3dmeC9NYWtlZmlsZSAgfCAgIDEgKw0KIGRyaXZlcnMv
c3RhZ2luZy93ZngvZGF0YV9yeC5jIHwgMTgyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfcnguaCB8ICAxOCArKysrDQogZHJpdmVy
cy9zdGFnaW5nL3dmeC9oaWZfcnguYyAgfCAgMjMgKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDIy
NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93Zngv
ZGF0YV9yeC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV9y
eC5oDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9NYWtlZmlsZQ0KaW5kZXggZDVhYzlmYWZkMWYxLi5kOWUyMTUxNWQwOGUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlDQorKysgYi9kcml2ZXJz
L3N0YWdpbmcvd2Z4L01ha2VmaWxlDQpAQCAtMTEsNiArMTEsNyBAQCB3ZngteSA6PSBcDQogCWhp
Zl9yeC5vIFwNCiAJcXVldWUubyBcDQogCWRhdGFfdHgubyBcDQorCWRhdGFfcngubyBcDQogCXN0
YS5vIFwNCiAJbWFpbi5vIFwNCiAJc3RhLm8gXA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2lu
Zy93ZngvZGF0YV9yeC5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmMNCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLjNiMzExN2IyZWRhYw0KLS0tIC9kZXYv
bnVsbA0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmMNCkBAIC0wLDAgKzEsMTgy
IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8qDQorICog
RGF0YXBhdGggaW1wbGVtZW50YXRpb24uDQorICoNCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAx
OSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4NCisgKiBDb3B5cmlnaHQgKGMpIDIwMTAsIFNU
LUVyaWNzc29uDQorICovDQorI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+DQorI2luY2x1
ZGUgPG5ldC9tYWM4MDIxMS5oPg0KKw0KKyNpbmNsdWRlICJkYXRhX3J4LmgiDQorI2luY2x1ZGUg
IndmeC5oIg0KKyNpbmNsdWRlICJiaC5oIg0KKyNpbmNsdWRlICJzdGEuaCINCisNCitzdGF0aWMg
aW50IHdmeF9oYW5kbGVfcHNwb2xsKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YTsNCisJc3RydWN0IGllZWU4
MDIxMV9wc3BvbGwgKnBzcG9sbCA9IChzdHJ1Y3QgaWVlZTgwMjExX3BzcG9sbCAqKXNrYi0+ZGF0
YTsNCisJaW50IGxpbmtfaWQgPSAwOw0KKwl1MzIgcHNwb2xsX21hc2sgPSAwOw0KKwlpbnQgaTsN
CisNCisJaWYgKCFldGhlcl9hZGRyX2VxdWFsKHd2aWYtPnZpZi0+YWRkciwgcHNwb2xsLT5ic3Np
ZCkpDQorCQlyZXR1cm4gMTsNCisNCisJcmN1X3JlYWRfbG9jaygpOw0KKwlzdGEgPSBpZWVlODAy
MTFfZmluZF9zdGEod3ZpZi0+dmlmLCBwc3BvbGwtPnRhKTsNCisJaWYgKHN0YSkNCisJCWxpbmtf
aWQgPSAoKHN0cnVjdCB3Znhfc3RhX3ByaXYgKikgJnN0YS0+ZHJ2X3ByaXYpLT5saW5rX2lkOw0K
KwlyY3VfcmVhZF91bmxvY2soKTsNCisJaWYgKGxpbmtfaWQpDQorCQlwc3BvbGxfbWFzayA9IEJJ
VChsaW5rX2lkKTsNCisJZWxzZQ0KKwkJcmV0dXJuIDE7DQorDQorCXd2aWYtPnBzcG9sbF9tYXNr
IHw9IHBzcG9sbF9tYXNrOw0KKwkvKiBEbyBub3QgcmVwb3J0IHBzcG9scyBpZiBkYXRhIGZvciBn
aXZlbiBsaW5rIGlkIGlzIHF1ZXVlZCBhbHJlYWR5LiAqLw0KKwlmb3IgKGkgPSAwOyBpIDwgSUVF
RTgwMjExX05VTV9BQ1M7ICsraSkgew0KKwkJaWYgKHdmeF90eF9xdWV1ZV9nZXRfbnVtX3F1ZXVl
ZCgmd3ZpZi0+d2Rldi0+dHhfcXVldWVbaV0sDQorCQkJCQkJcHNwb2xsX21hc2spKSB7DQorCQkJ
d2Z4X2JoX3JlcXVlc3RfdHgod3ZpZi0+d2Rldik7DQorCQkJcmV0dXJuIDE7DQorCQl9DQorCX0N
CisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgd2Z4X2Ryb3BfZW5jcnlwdF9kYXRhKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX2luZF9yeCAqYXJnLCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9oZHIgKmZyYW1lID0gKHN0cnVjdCBpZWVl
ODAyMTFfaGRyICopIHNrYi0+ZGF0YTsNCisJc2l6ZV90IGhkcmxlbiA9IGllZWU4MDIxMV9oZHJs
ZW4oZnJhbWUtPmZyYW1lX2NvbnRyb2wpOw0KKwlzaXplX3QgaXZfbGVuLCBpY3ZfbGVuOw0KKw0K
KwkvKiBPb3BzLi4uIFRoZXJlIGlzIG5vIGZhc3Qgd2F5IHRvIGFzayBtYWM4MDIxMSBhYm91dA0K
KwkgKiBJVi9JQ1YgbGVuZ3Rocy4gRXZlbiBkZWZpbmVhcyBhcmUgbm90IGV4cG9zZWQuDQorCSAq
Lw0KKwlzd2l0Y2ggKGFyZy0+cnhfZmxhZ3MuZW5jcnlwKSB7DQorCWNhc2UgSElGX1JJX0ZMQUdT
X1dFUF9FTkNSWVBURUQ6DQorCQlpdl9sZW4gPSA0IC8qIFdFUF9JVl9MRU4gKi87DQorCQlpY3Zf
bGVuID0gNCAvKiBXRVBfSUNWX0xFTiAqLzsNCisJCWJyZWFrOw0KKwljYXNlIEhJRl9SSV9GTEFH
U19US0lQX0VOQ1JZUFRFRDoNCisJCWl2X2xlbiA9IDggLyogVEtJUF9JVl9MRU4gKi87DQorCQlp
Y3ZfbGVuID0gNCAvKiBUS0lQX0lDVl9MRU4gKi8NCisJCQkrIDggLypNSUNIQUVMX01JQ19MRU4q
LzsNCisJCWJyZWFrOw0KKwljYXNlIEhJRl9SSV9GTEFHU19BRVNfRU5DUllQVEVEOg0KKwkJaXZf
bGVuID0gOCAvKiBDQ01QX0hEUl9MRU4gKi87DQorCQlpY3ZfbGVuID0gOCAvKiBDQ01QX01JQ19M
RU4gKi87DQorCQlicmVhazsNCisJY2FzZSBISUZfUklfRkxBR1NfV0FQSV9FTkNSWVBURUQ6DQor
CQlpdl9sZW4gPSAxOCAvKiBXQVBJX0hEUl9MRU4gKi87DQorCQlpY3ZfbGVuID0gMTYgLyogV0FQ
SV9NSUNfTEVOICovOw0KKwkJYnJlYWs7DQorCWRlZmF1bHQ6DQorCQlkZXZfZXJyKHdkZXYtPmRl
diwgInVua25vd24gZW5jcnlwdGlvbiB0eXBlICVkXG4iLA0KKwkJCSBhcmctPnJ4X2ZsYWdzLmVu
Y3J5cCk7DQorCQlyZXR1cm4gLUVJTzsNCisJfQ0KKw0KKwkvKiBGaXJtd2FyZSBzdHJpcHMgSUNW
IGluIGNhc2Ugb2YgTUlDIGZhaWx1cmUuICovDQorCWlmIChhcmctPnN0YXR1cyA9PSBISUZfU1RB
VFVTX01JQ0ZBSUxVUkUpDQorCQlpY3ZfbGVuID0gMDsNCisNCisJaWYgKHNrYi0+bGVuIDwgaGRy
bGVuICsgaXZfbGVuICsgaWN2X2xlbikgew0KKwkJZGV2X3dhcm4od2Rldi0+ZGV2LCAibWFsZm9y
bWVkIFNEVSByZWNlaXZlZFxuIik7DQorCQlyZXR1cm4gLUVJTzsNCisJfQ0KKw0KKwkvKiBSZW1v
dmUgSVYsIElDViBhbmQgTUlDICovDQorCXNrYl90cmltKHNrYiwgc2tiLT5sZW4gLSBpY3ZfbGVu
KTsNCisJbWVtbW92ZShza2ItPmRhdGEgKyBpdl9sZW4sIHNrYi0+ZGF0YSwgaGRybGVuKTsNCisJ
c2tiX3B1bGwoc2tiLCBpdl9sZW4pOw0KKwlyZXR1cm4gMDsNCisNCit9DQorDQordm9pZCB3Znhf
cnhfY2Ioc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBoaWZfaW5kX3J4ICphcmcsIHN0cnVj
dCBza19idWZmICpza2IpDQorew0KKwlpbnQgbGlua19pZCA9IGFyZy0+cnhfZmxhZ3MucGVlcl9z
dGFfaWQ7DQorCXN0cnVjdCBpZWVlODAyMTFfcnhfc3RhdHVzICpoZHIgPSBJRUVFODAyMTFfU0tC
X1JYQ0Ioc2tiKTsNCisJc3RydWN0IGllZWU4MDIxMV9oZHIgKmZyYW1lID0gKHN0cnVjdCBpZWVl
ODAyMTFfaGRyICopIHNrYi0+ZGF0YTsNCisJc3RydWN0IGllZWU4MDIxMV9tZ210ICptZ210ID0g
KHN0cnVjdCBpZWVlODAyMTFfbWdtdCAqKSBza2ItPmRhdGE7DQorCXN0cnVjdCB3ZnhfbGlua19l
bnRyeSAqZW50cnkgPSBOVUxMOw0KKwlib29sIGVhcmx5X2RhdGEgPSBmYWxzZTsNCisNCisJbWVt
c2V0KGhkciwgMCwgc2l6ZW9mKCpoZHIpKTsNCisNCisJLy8gRklYTUU6IFdoeSBkbyB3ZSBkcm9w
IHRoZXNlIGZyYW1lcz8NCisJaWYgKCFhcmctPnJjcGlfcnNzaSAmJg0KKwkgICAgKGllZWU4MDIx
MV9pc19wcm9iZV9yZXNwKGZyYW1lLT5mcmFtZV9jb250cm9sKSB8fA0KKwkgICAgIGllZWU4MDIx
MV9pc19iZWFjb24oZnJhbWUtPmZyYW1lX2NvbnRyb2wpKSkNCisJCWdvdG8gZHJvcDsNCisNCisJ
aWYgKGxpbmtfaWQgJiYgbGlua19pZCA8PSBXRlhfTUFYX1NUQV9JTl9BUF9NT0RFKSB7DQorCQll
bnRyeSA9ICZ3dmlmLT5saW5rX2lkX2RiW2xpbmtfaWQgLSAxXTsNCisJCWVudHJ5LT50aW1lc3Rh
bXAgPSBqaWZmaWVzOw0KKwkJaWYgKGVudHJ5LT5zdGF0dXMgPT0gV0ZYX0xJTktfU09GVCAmJiBp
ZWVlODAyMTFfaXNfZGF0YShmcmFtZS0+ZnJhbWVfY29udHJvbCkpDQorCQkJZWFybHlfZGF0YSA9
IHRydWU7DQorCX0NCisNCisJaWYgKGFyZy0+c3RhdHVzID09IEhJRl9TVEFUVVNfTUlDRkFJTFVS
RSkNCisJCWhkci0+ZmxhZyB8PSBSWF9GTEFHX01NSUNfRVJST1I7DQorCWVsc2UgaWYgKGFyZy0+
c3RhdHVzKQ0KKwkJZ290byBkcm9wOw0KKw0KKwlpZiAoc2tiLT5sZW4gPCBzaXplb2Yoc3RydWN0
IGllZWU4MDIxMV9wc3BvbGwpKSB7DQorCQlkZXZfd2Fybih3dmlmLT53ZGV2LT5kZXYsICJtYWxm
b3JtZWQgU0RVIHJlY2VpdmVkXG4iKTsNCisJCWdvdG8gZHJvcDsNCisJfQ0KKw0KKwlpZiAoaWVl
ZTgwMjExX2lzX3BzcG9sbChmcmFtZS0+ZnJhbWVfY29udHJvbCkpDQorCQlpZiAod2Z4X2hhbmRs
ZV9wc3BvbGwod3ZpZiwgc2tiKSkNCisJCQlnb3RvIGRyb3A7DQorDQorCWhkci0+YmFuZCA9IE5M
ODAyMTFfQkFORF8yR0haOw0KKwloZHItPmZyZXEgPSBpZWVlODAyMTFfY2hhbm5lbF90b19mcmVx
dWVuY3koYXJnLT5jaGFubmVsX251bWJlciwgaGRyLT5iYW5kKTsNCisNCisJaWYgKGFyZy0+cnhl
ZF9yYXRlID49IDE0KSB7DQorCQloZHItPmVuY29kaW5nID0gUlhfRU5DX0hUOw0KKwkJaGRyLT5y
YXRlX2lkeCA9IGFyZy0+cnhlZF9yYXRlIC0gMTQ7DQorCX0gZWxzZSBpZiAoYXJnLT5yeGVkX3Jh
dGUgPj0gNCkgew0KKwkJaGRyLT5yYXRlX2lkeCA9IGFyZy0+cnhlZF9yYXRlIC0gMjsNCisJfSBl
bHNlIHsNCisJCWhkci0+cmF0ZV9pZHggPSBhcmctPnJ4ZWRfcmF0ZTsNCisJfQ0KKw0KKwloZHIt
PnNpZ25hbCA9IGFyZy0+cmNwaV9yc3NpIC8gMiAtIDExMDsNCisJaGRyLT5hbnRlbm5hID0gMDsN
CisNCisJaWYgKGFyZy0+cnhfZmxhZ3MuZW5jcnlwKSB7DQorCQlpZiAod2Z4X2Ryb3BfZW5jcnlw
dF9kYXRhKHd2aWYtPndkZXYsIGFyZywgc2tiKSkNCisJCQlnb3RvIGRyb3A7DQorCQloZHItPmZs
YWcgfD0gUlhfRkxBR19ERUNSWVBURUQgfCBSWF9GTEFHX0lWX1NUUklQUEVEOw0KKwkJaWYgKGFy
Zy0+cnhfZmxhZ3MuZW5jcnlwID09IEhJRl9SSV9GTEFHU19US0lQX0VOQ1JZUFRFRCkNCisJCQlo
ZHItPmZsYWcgfD0gUlhfRkxBR19NTUlDX1NUUklQUEVEOw0KKwl9DQorDQorCS8qIEZpbHRlciBi
bG9jayBBQ0sgbmVnb3RpYXRpb246IGZ1bGx5IGNvbnRyb2xsZWQgYnkgZmlybXdhcmUgKi8NCisJ
aWYgKGllZWU4MDIxMV9pc19hY3Rpb24oZnJhbWUtPmZyYW1lX2NvbnRyb2wpDQorCSAgICAmJiBh
cmctPnJ4X2ZsYWdzLm1hdGNoX3VjX2FkZHINCisJICAgICYmIG1nbXQtPnUuYWN0aW9uLmNhdGVn
b3J5ID09IFdMQU5fQ0FURUdPUllfQkFDSykNCisJCWdvdG8gZHJvcDsNCisNCisJaWYgKGVhcmx5
X2RhdGEpIHsNCisJCXNwaW5fbG9ja19iaCgmd3ZpZi0+cHNfc3RhdGVfbG9jayk7DQorCQkvKiBE
b3VibGUtY2hlY2sgc3RhdHVzIHdpdGggbG9jayBoZWxkICovDQorCQlpZiAoZW50cnktPnN0YXR1
cyA9PSBXRlhfTElOS19TT0ZUKQ0KKwkJCXNrYl9xdWV1ZV90YWlsKCZlbnRyeS0+cnhfcXVldWUs
IHNrYik7DQorCQllbHNlDQorCQkJaWVlZTgwMjExX3J4X2lycXNhZmUod3ZpZi0+d2Rldi0+aHcs
IHNrYik7DQorCQlzcGluX3VubG9ja19iaCgmd3ZpZi0+cHNfc3RhdGVfbG9jayk7DQorCX0gZWxz
ZSB7DQorCQlpZWVlODAyMTFfcnhfaXJxc2FmZSh3dmlmLT53ZGV2LT5odywgc2tiKTsNCisJfQ0K
Kw0KKwlyZXR1cm47DQorDQorZHJvcDoNCisJZGV2X2tmcmVlX3NrYihza2IpOw0KK30NCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfcnguaCBiL2RyaXZlcnMvc3RhZ2luZy93
ZngvZGF0YV9yeC5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5i
NDRkMTUyNjhmODMNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0
YV9yeC5oDQpAQCAtMCwwICsxLDE4IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seSAqLw0KKy8qDQorICogRGF0YXBhdGggaW1wbGVtZW50YXRpb24uDQorICoNCisg
KiBDb3B5cmlnaHQgKGMpIDIwMTctMjAxOSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4NCisg
KiBDb3B5cmlnaHQgKGMpIDIwMTAsIFNULUVyaWNzc29uDQorICovDQorI2lmbmRlZiBXRlhfREFU
QV9SWF9IDQorI2RlZmluZSBXRlhfREFUQV9SWF9IDQorDQorI2luY2x1ZGUgImhpZl9hcGlfY21k
LmgiDQorDQorc3RydWN0IHdmeF92aWY7DQorc3RydWN0IHNrX2J1ZmY7DQorDQordm9pZCB3Znhf
cnhfY2Ioc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBoaWZfaW5kX3J4ICphcmcsIHN0cnVj
dCBza19idWZmICpza2IpOw0KKw0KKyNlbmRpZiAvKiBXRlhfREFUQV9SWF9IICovDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfcnguYyBiL2RyaXZlcnMvc3RhZ2luZy93Zngv
aGlmX3J4LmMNCmluZGV4IDk3YzRjMmYwODJmYi4uYzA3OTg0YjA1MzVkIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfcnguYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9o
aWZfcnguYw0KQEAgLTExLDYgKzExLDcgQEANCiANCiAjaW5jbHVkZSAiaGlmX3J4LmgiDQogI2lu
Y2x1ZGUgIndmeC5oIg0KKyNpbmNsdWRlICJkYXRhX3J4LmgiDQogI2luY2x1ZGUgInNlY3VyZV9s
aW5rLmgiDQogI2luY2x1ZGUgImhpZl9hcGlfY21kLmgiDQogDQpAQCAtMTI3LDYgKzEyOCwyMSBA
QCBzdGF0aWMgaW50IGhpZl9rZXlzX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0
cnVjdCBoaWZfbXNnICpoaWYsIHZvaWQgKg0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIGlu
dCBoaWZfcmVjZWl2ZV9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlm
X21zZyAqaGlmLCB2b2lkICpidWYsIHN0cnVjdCBza19idWZmICpza2IpDQorew0KKwlzdHJ1Y3Qg
d2Z4X3ZpZiAqd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYtPmludGVyZmFjZSk7DQorCXN0
cnVjdCBoaWZfaW5kX3J4ICpib2R5ID0gYnVmOw0KKw0KKwlpZiAoIXd2aWYpIHsNCisJCWRldl93
YXJuKHdkZXYtPmRldiwgImlnbm9yZSByeCBkYXRhIGZvciBub24gZXhpc3RhbnQgdmlmICVkXG4i
LCBoaWYtPmludGVyZmFjZSk7DQorCQlyZXR1cm4gMDsNCisJfQ0KKwlza2JfcHVsbChza2IsIHNp
emVvZihzdHJ1Y3QgaGlmX21zZykgKyBzaXplb2Yoc3RydWN0IGhpZl9pbmRfcngpKTsNCisJd2Z4
X3J4X2NiKHd2aWYsIGJvZHksIHNrYik7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMg
aW50IGhpZl9qb2luX2NvbXBsZXRlX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0
cnVjdCBoaWZfbXNnICpoaWYsIHZvaWQgKmJ1ZikNCiB7DQogCXN0cnVjdCB3ZnhfdmlmICp3dmlm
ID0gd2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNlKTsNCkBAIC0yMTgsNiArMjM0LDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7DQogCXsgSElGX0lORF9JRF9HRU5FUklDLCAgICAgICAg
ICAgICAgaGlmX2dlbmVyaWNfaW5kaWNhdGlvbiB9LA0KIAl7IEhJRl9JTkRfSURfRVJST1IsICAg
ICAgICAgICAgICAgIGhpZl9lcnJvcl9pbmRpY2F0aW9uIH0sDQogCXsgSElGX0lORF9JRF9FWENF
UFRJT04sICAgICAgICAgICAgaGlmX2V4Y2VwdGlvbl9pbmRpY2F0aW9uIH0sDQorCS8vIEZJWE1F
OiBhbGxvY2F0ZSBza2JfcCBmcm9tIGhpZl9yZWNlaXZlX2luZGljYXRpb24gYW5kIG1ha2UgaXQg
Z2VuZXJpYw0KKwkvL3sgSElGX0lORF9JRF9SWCwgICAgICAgICAgICAgICAgIGhpZl9yZWNlaXZl
X2luZGljYXRpb24gfSwNCiB9Ow0KIA0KIHZvaWQgd2Z4X2hhbmRsZV9yeChzdHJ1Y3Qgd2Z4X2Rl
diAqd2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCkBAIC0yMjYsNiArMjQ0LDExIEBAIHZvaWQg
d2Z4X2hhbmRsZV9yeChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikN
CiAJc3RydWN0IGhpZl9tc2cgKmhpZiA9IChzdHJ1Y3QgaGlmX21zZyAqKSBza2ItPmRhdGE7DQog
CWludCBoaWZfaWQgPSBoaWYtPmlkOw0KIA0KKwlpZiAoaGlmX2lkID09IEhJRl9JTkRfSURfUlgp
IHsNCisJCS8vIGhpZl9yZWNlaXZlX2luZGljYXRpb24gdGFrZSBjYXJlIG9mIHNrYiBsaWZldGlt
ZQ0KKwkJaGlmX3JlY2VpdmVfaW5kaWNhdGlvbih3ZGV2LCBoaWYsIGhpZi0+Ym9keSwgc2tiKTsN
CisJCXJldHVybjsNCisJfQ0KIAkvLyBOb3RlOiBtdXRleF9pc19sb2NrIGNhdXNlIGFuIGltcGxp
Y2l0IG1lbW9yeSBiYXJyaWVyIHRoYXQgcHJvdGVjdA0KIAkvLyBidWZfc2VuZA0KIAlpZiAobXV0
ZXhfaXNfbG9ja2VkKCZ3ZGV2LT5oaWZfY21kLmxvY2spDQotLSANCjIuMjAuMQ0K
