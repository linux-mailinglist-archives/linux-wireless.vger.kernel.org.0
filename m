Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D71B7B07
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfISNxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 09:53:08 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:34912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403801AbfISNw5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 09:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmKhxgqyqQULWa1bth4Uf0PXkWTiKv4Y8IH14ijAE8smvqIv6aqd1EwpfVpBFinC7boEkTPad4vq6+rLDZ+lwBjzydU42C3i7Nwaw+A03kW7hDE409XwTR9pOipvNMbOKkeVokaHvrO38r1wS2CfJiUngk2c96AdCuP9YI1/I47UDHLU+JWKmF1afc1SldTQZT4swLXLYydqhVVrrXWUe7lFCL7qUmn2h6dCl6IsnUHtjG6qc8/EUwzRggjcYcIly9KcxmxQsV1yNPiUFD8FetSKDXBXXB0Fv5gGMX/KbaWrwbjLTp7jI5+9aeVwCg3d3ijvgxF11YDXgFQ3CGea9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HvDQN5zIDjPsZ+tsXHVt7Krv8jtj63VsUt+BuD92VM=;
 b=GFjCk6cPHVNUro186dJFfoJkz6G2z6VF6bEKv8K08MkcmrJKzXdWLaDKoDtrJoxIjPuakHKc150vjtHvwoLS16S2cgtqUyUUjPi62/PWoSWD1KvSzdVBq3cOwqAfrd0ORo1NK89zwyl3rhioQmzjt+cEH95GH0Mw2RkyUYDpUo/0hoENEz+W/b8qPUps71cKoHsdYz57MSD48wKwv7cfC3DE3nfjFwl+zjslLYcXN7GJ4mU1vRSKpjggbZVKUd71wh+jHMoUGRZdpKr5gzsrq+h4tAx7F5mcB1JB5gK+bwuqGAifvXT/vXfYtuOo4+87BZyY5CpYbzAjWCLl26NZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HvDQN5zIDjPsZ+tsXHVt7Krv8jtj63VsUt+BuD92VM=;
 b=VYL4LJ8DFunfwymujq1bd3jsyUfZ0hdR+DYr8LlZieleoz3lQaLU/grMeWmQb1glF2EUYWNuui+L1IgiajqeqsMQVUMj7TyN6vfo0bA4u/iJBqbDzKlNtZYRxWWwOBDs151zb6kKZl5+VDf7G25ZzFPqqZ32bCP75/0Uuk/ThkI=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (20.179.149.217) by
 MN2PR11MB4400.namprd11.prod.outlook.com (52.135.37.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Thu, 19 Sep 2019 13:52:42 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 13:52:42 +0000
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
Subject: [PATCH v2 19/20] staging: wfx: implement 802.11 key handling
Thread-Topic: [PATCH v2 19/20] staging: wfx: implement 802.11 key handling
Thread-Index: AQHVbvGBBkaPJaFD9kyUnoCuFiXQpA==
Date:   Thu, 19 Sep 2019 13:52:41 +0000
Message-ID: <20190919135220.30663-20-Jerome.Pouiller@silabs.com>
References: <20190919135220.30663-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20190919135220.30663-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f99177d1-01a0-4d28-8c15-08d73d08a491
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB4400;
x-ms-traffictypediagnostic: MN2PR11MB4400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB44005A83A58DEC313DA2656593890@MN2PR11MB4400.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(376002)(39850400004)(136003)(366004)(396003)(346002)(189003)(199004)(3846002)(76176011)(8676002)(76116006)(476003)(25786009)(2616005)(6116002)(54906003)(71190400001)(6436002)(102836004)(6486002)(36756003)(186003)(71200400001)(26005)(305945005)(6512007)(99286004)(6506007)(91956017)(7736002)(446003)(8936002)(256004)(81156014)(14444005)(2906002)(66066001)(30864003)(107886003)(4326008)(86362001)(14454004)(478600001)(64756008)(81166006)(2501003)(486006)(66574012)(316002)(66946007)(66446008)(66556008)(5660300002)(11346002)(66476007)(1076003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4400;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /cB1+rRPmBB6BIbxpyqSjH1C2PL09pDxcuPTEe/jA9WrT+1d6YXwnW6mcs2iD2tH+rtVynuClOs4f/JyqgvS3ZycZH9hs/VvDQk8UThdPpPLWkHZaY8MUtWkcor7e0z+SEhH82ivGrzoBLx5kqZKOjQyUqVNhH/tB9mpFAXnodbKzGSWqQCDvL+RsGvoRwjd1/wdM5eWzU3qVFdApGGgdkKZIBochB4GuK+QKfCFTXeUvRwsOmdaQKWunAhQHF1rejcFWD3h1b6LP9k1HmS849VHDog9O58+kYTJijD0lISqiXd3wXeu/fkW+gOht4FT9t4Y2FsagAuksTNvcGDZRlwMyLX0i7rx21wY34C4gCcFq6E2wMfJMQ2u5Yp6+yCWNaG0OQGmhw46OF2mPBlky+AD9N0SStwznp0siL3Ssig=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCB6F52ACEFCD14FA841252E634B05FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99177d1-01a0-4d28-8c15-08d73d08a491
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:52:41.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3POGgxhFiyTwtEXkotgk6RSpyAELS25yivm9wkwus5iiueyClFsy47gqmR8qPdsUoTZ3CP8F21h7vxHOWz27UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4400
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpT
aWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5j
b20+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlIHwgICAxICsNCiBkcml2ZXJz
L3N0YWdpbmcvd2Z4L2tleS5jICAgIHwgMjU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9rZXkuaCAgICB8ICAyMiArKysNCiBkcml2ZXJz
L3N0YWdpbmcvd2Z4L21haW4uYyAgIHwgICAyICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5j
ICAgIHwgICA0ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oICAgIHwgIDE5ICsrKw0KIDYg
ZmlsZXMgY2hhbmdlZCwgMzA2IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9zdGFnaW5nL3dmeC9rZXkuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2tleS5oDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxl
IGIvZHJpdmVycy9zdGFnaW5nL3dmeC9NYWtlZmlsZQ0KaW5kZXggMmI4YTVmYTg2ZmFjLi4wZDlj
MWVkMDkyZjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlDQorKysg
Yi9kcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlDQpAQCAtMTQsNiArMTQsNyBAQCB3ZngteSA6
PSBcDQogCWRhdGFfcngubyBcDQogCXNjYW4ubyBcDQogCXN0YS5vIFwNCisJa2V5Lm8gXA0KIAlt
YWluLm8gXA0KIAlzdGEubyBcDQogCWRlYnVnLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdp
bmcvd2Z4L2tleS5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9rZXkuYw0KbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uNGU3ZDJiNTEwYTljDQotLS0gL2Rldi9udWxsDQor
KysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2tleS5jDQpAQCAtMCwwICsxLDI1OCBAQA0KKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvKg0KKyAqIEtleSBtYW5hZ2Vt
ZW50IHJlbGF0ZWQgZnVuY3Rpb25zLg0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMTks
IFNpbGljb24gTGFib3JhdG9yaWVzLCBJbmMuDQorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1F
cmljc3Nvbg0KKyAqLw0KKyNpbmNsdWRlIDxuZXQvbWFjODAyMTEuaD4NCisNCisjaW5jbHVkZSAi
a2V5LmgiDQorI2luY2x1ZGUgIndmeC5oIg0KKyNpbmNsdWRlICJoaWZfdHhfbWliLmgiDQorDQor
c3RhdGljIGludCB3ZnhfYWxsb2Nfa2V5KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQ0KK3sNCisJaW50
IGlkeDsNCisNCisJaWR4ID0gZmZzKH53ZGV2LT5rZXlfbWFwKSAtIDE7DQorCWlmIChpZHggPCAw
IHx8IGlkeCA+PSBNQVhfS0VZX0VOVFJJRVMpDQorCQlyZXR1cm4gLTE7DQorDQorCXdkZXYtPmtl
eV9tYXAgfD0gQklUKGlkeCk7DQorCXdkZXYtPmtleXNbaWR4XS5lbnRyeV9pbmRleCA9IGlkeDsN
CisJcmV0dXJuIGlkeDsNCit9DQorDQorc3RhdGljIHZvaWQgd2Z4X2ZyZWVfa2V5KHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2LCBpbnQgaWR4KQ0KK3sNCisJQlVHX09OKCEod2Rldi0+a2V5X21hcCAmIEJJ
VChpZHgpKSk7DQorCW1lbXNldCgmd2Rldi0+a2V5c1tpZHhdLCAwLCBzaXplb2Yod2Rldi0+a2V5
c1tpZHhdKSk7DQorCXdkZXYtPmtleV9tYXAgJj0gfkJJVChpZHgpOw0KK30NCisNCitzdGF0aWMg
dWludDhfdCBmaWxsX3dlcF9wYWlyKHN0cnVjdCBoaWZfd2VwX3BhaXJ3aXNlX2tleSAqbXNnLA0K
KwkJCSAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5LCB1OCAqcGVlcl9hZGRyKQ0K
K3sNCisJV0FSTl9PTihrZXktPmtleWxlbiA+IHNpemVvZihtc2ctPmtleV9kYXRhKSk7DQorCW1z
Zy0+a2V5X2xlbmd0aCA9IGtleS0+a2V5bGVuOw0KKwltZW1jcHkobXNnLT5rZXlfZGF0YSwga2V5
LT5rZXksIGtleS0+a2V5bGVuKTsNCisJZXRoZXJfYWRkcl9jb3B5KG1zZy0+cGVlcl9hZGRyZXNz
LCBwZWVyX2FkZHIpOw0KKwlyZXR1cm4gSElGX0tFWV9UWVBFX1dFUF9QQUlSV0lTRTsNCit9DQor
DQorc3RhdGljIHVpbnQ4X3QgZmlsbF93ZXBfZ3JvdXAoc3RydWN0IGhpZl93ZXBfZ3JvdXBfa2V5
ICptc2csDQorCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5KQ0KK3sNCisJ
V0FSTl9PTihrZXktPmtleWxlbiA+IHNpemVvZihtc2ctPmtleV9kYXRhKSk7DQorCW1zZy0+a2V5
X2lkID0ga2V5LT5rZXlpZHg7DQorCW1zZy0+a2V5X2xlbmd0aCA9IGtleS0+a2V5bGVuOw0KKwlt
ZW1jcHkobXNnLT5rZXlfZGF0YSwga2V5LT5rZXksIGtleS0+a2V5bGVuKTsNCisJcmV0dXJuIEhJ
Rl9LRVlfVFlQRV9XRVBfREVGQVVMVDsNCit9DQorDQorc3RhdGljIHVpbnQ4X3QgZmlsbF90a2lw
X3BhaXIoc3RydWN0IGhpZl90a2lwX3BhaXJ3aXNlX2tleSAqbXNnLA0KKwkJCSAgICAgIHN0cnVj
dCBpZWVlODAyMTFfa2V5X2NvbmYgKmtleSwgdTggKnBlZXJfYWRkcikNCit7DQorCXVpbnQ4X3Qg
KmtleWJ1ZiA9IGtleS0+a2V5Ow0KKw0KKwlXQVJOX09OKGtleS0+a2V5bGVuICE9IHNpemVvZiht
c2ctPnRraXBfa2V5X2RhdGEpDQorCQkJICAgICAgICsgc2l6ZW9mKG1zZy0+dHhfbWljX2tleSkN
CisJCQkgICAgICAgKyBzaXplb2YobXNnLT5yeF9taWNfa2V5KSk7DQorCW1lbWNweShtc2ctPnRr
aXBfa2V5X2RhdGEsIGtleWJ1Ziwgc2l6ZW9mKG1zZy0+dGtpcF9rZXlfZGF0YSkpOw0KKwlrZXli
dWYgKz0gc2l6ZW9mKG1zZy0+dGtpcF9rZXlfZGF0YSk7DQorCW1lbWNweShtc2ctPnR4X21pY19r
ZXksIGtleWJ1Ziwgc2l6ZW9mKG1zZy0+dHhfbWljX2tleSkpOw0KKwlrZXlidWYgKz0gc2l6ZW9m
KG1zZy0+dHhfbWljX2tleSk7DQorCW1lbWNweShtc2ctPnJ4X21pY19rZXksIGtleWJ1Ziwgc2l6
ZW9mKG1zZy0+cnhfbWljX2tleSkpOw0KKwlldGhlcl9hZGRyX2NvcHkobXNnLT5wZWVyX2FkZHJl
c3MsIHBlZXJfYWRkcik7DQorCXJldHVybiBISUZfS0VZX1RZUEVfVEtJUF9QQUlSV0lTRTsNCit9
DQorDQorc3RhdGljIHVpbnQ4X3QgZmlsbF90a2lwX2dyb3VwKHN0cnVjdCBoaWZfdGtpcF9ncm91
cF9rZXkgKm1zZywNCisJCQkgICAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5LA0K
KwkJCSAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9zZXEgKnNlcSwNCisJCQkgICAgICAgZW51
bSBubDgwMjExX2lmdHlwZSBpZnR5cGUpDQorew0KKwl1aW50OF90ICprZXlidWYgPSBrZXktPmtl
eTsNCisNCisJV0FSTl9PTihrZXktPmtleWxlbiAhPSBzaXplb2YobXNnLT50a2lwX2tleV9kYXRh
KQ0KKwkJCSAgICAgICArIDIgKiBzaXplb2YobXNnLT5yeF9taWNfa2V5KSk7DQorCW1zZy0+a2V5
X2lkID0ga2V5LT5rZXlpZHg7DQorCW1lbWNweShtc2ctPnJ4X3NlcXVlbmNlX2NvdW50ZXIsICZz
ZXEtPnRraXAuaXYxNiwgc2l6ZW9mKHNlcS0+dGtpcC5pdjE2KSk7DQorCW1lbWNweShtc2ctPnJ4
X3NlcXVlbmNlX2NvdW50ZXIgKyBzaXplb2YodWludDE2X3QpLCAmc2VxLT50a2lwLml2MzIsIHNp
emVvZihzZXEtPnRraXAuaXYzMikpOw0KKwltZW1jcHkobXNnLT50a2lwX2tleV9kYXRhLCBrZXli
dWYsIHNpemVvZihtc2ctPnRraXBfa2V5X2RhdGEpKTsNCisJa2V5YnVmICs9IHNpemVvZihtc2ct
PnRraXBfa2V5X2RhdGEpOw0KKwlpZiAoaWZ0eXBlID09IE5MODAyMTFfSUZUWVBFX0FQKQ0KKwkJ
Ly8gVXNlIFR4IE1JQyBLZXkNCisJCW1lbWNweShtc2ctPnJ4X21pY19rZXksIGtleWJ1ZiArIDAs
IHNpemVvZihtc2ctPnJ4X21pY19rZXkpKTsNCisJZWxzZQ0KKwkJLy8gVXNlIFJ4IE1JQyBLZXkN
CisJCW1lbWNweShtc2ctPnJ4X21pY19rZXksIGtleWJ1ZiArIDgsIHNpemVvZihtc2ctPnJ4X21p
Y19rZXkpKTsNCisJcmV0dXJuIEhJRl9LRVlfVFlQRV9US0lQX0dST1VQOw0KK30NCisNCitzdGF0
aWMgdWludDhfdCBmaWxsX2NjbXBfcGFpcihzdHJ1Y3QgaGlmX2Flc19wYWlyd2lzZV9rZXkgKm1z
ZywNCisJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIHU4ICpwZWVyX2Fk
ZHIpDQorew0KKwlXQVJOX09OKGtleS0+a2V5bGVuICE9IHNpemVvZihtc2ctPmFlc19rZXlfZGF0
YSkpOw0KKwlldGhlcl9hZGRyX2NvcHkobXNnLT5wZWVyX2FkZHJlc3MsIHBlZXJfYWRkcik7DQor
CW1lbWNweShtc2ctPmFlc19rZXlfZGF0YSwga2V5LT5rZXksIGtleS0+a2V5bGVuKTsNCisJcmV0
dXJuIEhJRl9LRVlfVFlQRV9BRVNfUEFJUldJU0U7DQorfQ0KKw0KK3N0YXRpYyB1aW50OF90IGZp
bGxfY2NtcF9ncm91cChzdHJ1Y3QgaGlmX2Flc19ncm91cF9rZXkgKm1zZywNCisJCQkgICAgICAg
c3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5LA0KKwkJCSAgICAgICBzdHJ1Y3QgaWVlZTgw
MjExX2tleV9zZXEgKnNlcSkNCit7DQorCVdBUk5fT04oa2V5LT5rZXlsZW4gIT0gc2l6ZW9mKG1z
Zy0+YWVzX2tleV9kYXRhKSk7DQorCW1lbWNweShtc2ctPmFlc19rZXlfZGF0YSwga2V5LT5rZXks
IGtleS0+a2V5bGVuKTsNCisJbWVtY3B5KG1zZy0+cnhfc2VxdWVuY2VfY291bnRlciwgc2VxLT5j
Y21wLnBuLCBzaXplb2Yoc2VxLT5jY21wLnBuKSk7DQorCW1lbXJldmVyc2UobXNnLT5yeF9zZXF1
ZW5jZV9jb3VudGVyLCBzaXplb2Yoc2VxLT5jY21wLnBuKSk7DQorCW1zZy0+a2V5X2lkID0ga2V5
LT5rZXlpZHg7DQorCXJldHVybiBISUZfS0VZX1RZUEVfQUVTX0dST1VQOw0KK30NCisNCitzdGF0
aWMgdWludDhfdCBmaWxsX3NtczRfcGFpcihzdHJ1Y3QgaGlmX3dhcGlfcGFpcndpc2Vfa2V5ICpt
c2csDQorCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5LCB1OCAqcGVlcl9h
ZGRyKQ0KK3sNCisJdWludDhfdCAqa2V5YnVmID0ga2V5LT5rZXk7DQorDQorCVdBUk5fT04oa2V5
LT5rZXlsZW4gIT0gc2l6ZW9mKG1zZy0+d2FwaV9rZXlfZGF0YSkNCisJCQkgICAgICAgKyBzaXpl
b2YobXNnLT5taWNfa2V5X2RhdGEpKTsNCisJZXRoZXJfYWRkcl9jb3B5KG1zZy0+cGVlcl9hZGRy
ZXNzLCBwZWVyX2FkZHIpOw0KKwltZW1jcHkobXNnLT53YXBpX2tleV9kYXRhLCBrZXlidWYsIHNp
emVvZihtc2ctPndhcGlfa2V5X2RhdGEpKTsNCisJa2V5YnVmICs9IHNpemVvZihtc2ctPndhcGlf
a2V5X2RhdGEpOw0KKwltZW1jcHkobXNnLT5taWNfa2V5X2RhdGEsIGtleWJ1Ziwgc2l6ZW9mKG1z
Zy0+bWljX2tleV9kYXRhKSk7DQorCW1zZy0+a2V5X2lkID0ga2V5LT5rZXlpZHg7DQorCXJldHVy
biBISUZfS0VZX1RZUEVfV0FQSV9QQUlSV0lTRTsNCit9DQorDQorc3RhdGljIHVpbnQ4X3QgZmls
bF9zbXM0X2dyb3VwKHN0cnVjdCBoaWZfd2FwaV9ncm91cF9rZXkgKm1zZywNCisJCQkgICAgICAg
c3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAqa2V5KQ0KK3sNCisJdWludDhfdCAqa2V5YnVmID0g
a2V5LT5rZXk7DQorDQorCVdBUk5fT04oa2V5LT5rZXlsZW4gIT0gc2l6ZW9mKG1zZy0+d2FwaV9r
ZXlfZGF0YSkNCisJCQkgICAgICAgKyBzaXplb2YobXNnLT5taWNfa2V5X2RhdGEpKTsNCisJbWVt
Y3B5KG1zZy0+d2FwaV9rZXlfZGF0YSwga2V5YnVmLCBzaXplb2YobXNnLT53YXBpX2tleV9kYXRh
KSk7DQorCWtleWJ1ZiArPSBzaXplb2YobXNnLT53YXBpX2tleV9kYXRhKTsNCisJbWVtY3B5KG1z
Zy0+bWljX2tleV9kYXRhLCBrZXlidWYsIHNpemVvZihtc2ctPm1pY19rZXlfZGF0YSkpOw0KKwlt
c2ctPmtleV9pZCA9IGtleS0+a2V5aWR4Ow0KKwlyZXR1cm4gSElGX0tFWV9UWVBFX1dBUElfR1JP
VVA7DQorfQ0KKw0KK3N0YXRpYyB1aW50OF90IGZpbGxfYWVzX2NtYWNfZ3JvdXAoc3RydWN0IGhp
Zl9pZ3RrX2dyb3VwX2tleSAqbXNnLA0KKwkJCQkgICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25m
ICprZXksDQorCQkJCSAgIHN0cnVjdCBpZWVlODAyMTFfa2V5X3NlcSAqc2VxKQ0KK3sNCisJV0FS
Tl9PTihrZXktPmtleWxlbiAhPSBzaXplb2YobXNnLT5pZ3RrX2tleV9kYXRhKSk7DQorCW1lbWNw
eShtc2ctPmlndGtfa2V5X2RhdGEsIGtleS0+a2V5LCBrZXktPmtleWxlbik7DQorCW1lbWNweSht
c2ctPmlwbiwgc2VxLT5hZXNfY21hYy5wbiwgc2l6ZW9mKHNlcS0+YWVzX2NtYWMucG4pKTsNCisJ
bWVtcmV2ZXJzZShtc2ctPmlwbiwgc2l6ZW9mKHNlcS0+YWVzX2NtYWMucG4pKTsNCisJbXNnLT5r
ZXlfaWQgPSBrZXktPmtleWlkeDsNCisJcmV0dXJuIEhJRl9LRVlfVFlQRV9JR1RLX0dST1VQOw0K
K30NCisNCitzdGF0aWMgaW50IHdmeF9hZGRfa2V5KHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1
Y3QgaWVlZTgwMjExX3N0YSAqc3RhLA0KKwkJICAgICAgIHN0cnVjdCBpZWVlODAyMTFfa2V5X2Nv
bmYgKmtleSkNCit7DQorCWludCByZXQ7DQorCXN0cnVjdCBoaWZfcmVxX2FkZF9rZXkgKms7DQor
CXN0cnVjdCBpZWVlODAyMTFfa2V5X3NlcSBzZXE7DQorCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0g
d3ZpZi0+d2RldjsNCisJaW50IGlkeCA9IHdmeF9hbGxvY19rZXkod3ZpZi0+d2Rldik7DQorCWJv
b2wgcGFpcndpc2UgPSBrZXktPmZsYWdzICYgSUVFRTgwMjExX0tFWV9GTEFHX1BBSVJXSVNFOw0K
Kw0KKwlXQVJOX09OKGtleS0+ZmxhZ3MgJiBJRUVFODAyMTFfS0VZX0ZMQUdfUEFJUldJU0UgJiYg
IXN0YSk7DQorCWllZWU4MDIxMV9nZXRfa2V5X3J4X3NlcShrZXksIDAsICZzZXEpOw0KKwlpZiAo
aWR4IDwgMCkNCisJCXJldHVybiAtRUlOVkFMOw0KKwlrID0gJndkZXYtPmtleXNbaWR4XTsNCisJ
ay0+aW50X2lkID0gd3ZpZi0+aWQ7DQorCWlmIChrZXktPmNpcGhlciA9PSBXTEFOX0NJUEhFUl9T
VUlURV9XRVA0MCB8fCBrZXktPmNpcGhlciA9PSAgV0xBTl9DSVBIRVJfU1VJVEVfV0VQMTA0KSB7
DQorCQlpZiAocGFpcndpc2UpDQorCQkJay0+dHlwZSA9IGZpbGxfd2VwX3BhaXIoJmstPmtleS53
ZXBfcGFpcndpc2Vfa2V5LCBrZXksIHN0YS0+YWRkcik7DQorCQllbHNlDQorCQkJay0+dHlwZSA9
IGZpbGxfd2VwX2dyb3VwKCZrLT5rZXkud2VwX2dyb3VwX2tleSwga2V5KTsNCisJfSBlbHNlIGlm
IChrZXktPmNpcGhlciA9PSBXTEFOX0NJUEhFUl9TVUlURV9US0lQKSB7DQorCQlpZiAocGFpcndp
c2UpDQorCQkJay0+dHlwZSA9IGZpbGxfdGtpcF9wYWlyKCZrLT5rZXkudGtpcF9wYWlyd2lzZV9r
ZXksIGtleSwgc3RhLT5hZGRyKTsNCisJCWVsc2UNCisJCQlrLT50eXBlID0gZmlsbF90a2lwX2dy
b3VwKCZrLT5rZXkudGtpcF9ncm91cF9rZXksIGtleSwgJnNlcSwgd3ZpZi0+dmlmLT50eXBlKTsN
CisJfSBlbHNlIGlmIChrZXktPmNpcGhlciA9PSBXTEFOX0NJUEhFUl9TVUlURV9DQ01QKSB7DQor
CQlpZiAocGFpcndpc2UpDQorCQkJay0+dHlwZSA9IGZpbGxfY2NtcF9wYWlyKCZrLT5rZXkuYWVz
X3BhaXJ3aXNlX2tleSwga2V5LCBzdGEtPmFkZHIpOw0KKwkJZWxzZQ0KKwkJCWstPnR5cGUgPSBm
aWxsX2NjbXBfZ3JvdXAoJmstPmtleS5hZXNfZ3JvdXBfa2V5LCBrZXksICZzZXEpOw0KKwl9IGVs
c2UgaWYgKGtleS0+Y2lwaGVyID09ICBXTEFOX0NJUEhFUl9TVUlURV9TTVM0KSB7DQorCQlpZiAo
cGFpcndpc2UpDQorCQkJay0+dHlwZSA9IGZpbGxfc21zNF9wYWlyKCZrLT5rZXkud2FwaV9wYWly
d2lzZV9rZXksIGtleSwgc3RhLT5hZGRyKTsNCisJCWVsc2UNCisJCQlrLT50eXBlID0gZmlsbF9z
bXM0X2dyb3VwKCZrLT5rZXkud2FwaV9ncm91cF9rZXksIGtleSk7DQorCX0gZWxzZSBpZiAoa2V5
LT5jaXBoZXIgPT0gIFdMQU5fQ0lQSEVSX1NVSVRFX0FFU19DTUFDKSB7DQorCQlrLT50eXBlID0g
ZmlsbF9hZXNfY21hY19ncm91cCgmay0+a2V5LmlndGtfZ3JvdXBfa2V5LCBrZXksICZzZXEpOw0K
Kwl9IGVsc2Ugew0KKwkJZGV2X3dhcm4od2Rldi0+ZGV2LCAidW5zdXBwb3J0ZWQga2V5IHR5cGUg
JWRcbiIsIGtleS0+Y2lwaGVyKTsNCisJCXdmeF9mcmVlX2tleSh3ZGV2LCBpZHgpOw0KKwkJcmV0
dXJuIC1FT1BOT1RTVVBQOw0KKwl9DQorCXJldCA9IGhpZl9hZGRfa2V5KHdkZXYsIGspOw0KKwlp
ZiAocmV0KSB7DQorCQl3ZnhfZnJlZV9rZXkod2RldiwgaWR4KTsNCisJCXJldHVybiAtRU9QTk9U
U1VQUDsNCisJfQ0KKwlrZXktPmZsYWdzIHw9IElFRUU4MDIxMV9LRVlfRkxBR19QVVRfSVZfU1BB
Q0UgfA0KKwkJICAgICAgSUVFRTgwMjExX0tFWV9GTEFHX1JFU0VSVkVfVEFJTFJPT007DQorCWtl
eS0+aHdfa2V5X2lkeCA9IGlkeDsNCisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgd2Z4
X3JlbW92ZV9rZXkoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfa2V5X2Nv
bmYgKmtleSkNCit7DQorCVdBUk4oa2V5LT5od19rZXlfaWR4ID49IE1BWF9LRVlfRU5UUklFUywg
ImNvcnJ1cHRlZCBod19rZXlfaWR4Iik7DQorCXdmeF9mcmVlX2tleSh3dmlmLT53ZGV2LCBrZXkt
Pmh3X2tleV9pZHgpOw0KKwlyZXR1cm4gaGlmX3JlbW92ZV9rZXkod3ZpZi0+d2Rldiwga2V5LT5o
d19rZXlfaWR4KTsNCit9DQorDQoraW50IHdmeF9zZXRfa2V5KHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LCBlbnVtIHNldF9rZXlfY21kIGNtZCwNCisJCXN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYs
IHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsDQorCQlzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25m
ICprZXkpDQorew0KKwlpbnQgcmV0ID0gLUVPUE5PVFNVUFA7DQorCXN0cnVjdCB3ZnhfdmlmICp3
dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopIHZpZi0+ZHJ2X3ByaXY7DQorDQorCW11dGV4X2xvY2so
Jnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgpOw0KKwlpZiAoY21kID09IFNFVF9LRVkpDQorCQlyZXQg
PSB3ZnhfYWRkX2tleSh3dmlmLCBzdGEsIGtleSk7DQorCWlmIChjbWQgPT0gRElTQUJMRV9LRVkp
DQorCQlyZXQgPSB3ZnhfcmVtb3ZlX2tleSh3dmlmLCBrZXkpOw0KKwltdXRleF91bmxvY2soJnd2
aWYtPndkZXYtPmNvbmZfbXV0ZXgpOw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCitpbnQgd2Z4X3Vw
bG9hZF9rZXlzKHN0cnVjdCB3ZnhfdmlmICp3dmlmKQ0KK3sNCisJaW50IGk7DQorCXN0cnVjdCBo
aWZfcmVxX2FkZF9rZXkgKmtleTsNCisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSB3dmlmLT53ZGV2
Ow0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh3ZGV2LT5rZXlzKTsgaSsrKSB7DQor
CQlpZiAod2Rldi0+a2V5X21hcCAmIEJJVChpKSkgew0KKwkJCWtleSA9ICZ3ZGV2LT5rZXlzW2ld
Ow0KKwkJCWlmIChrZXktPmludF9pZCA9PSB3dmlmLT5pZCkNCisJCQkJaGlmX2FkZF9rZXkod2Rl
diwga2V5KTsNCisJCX0NCisJfQ0KKwlyZXR1cm4gMDsNCit9DQorDQordm9pZCB3Znhfd2VwX2tl
eV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCit7DQorCXN0cnVjdCB3ZnhfdmlmICp3
dmlmID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB3ZnhfdmlmLCB3ZXBfa2V5X3dvcmspOw0K
Kw0KKwl3ZnhfdHhfZmx1c2god3ZpZi0+d2Rldik7DQorCWhpZl93ZXBfZGVmYXVsdF9rZXlfaWQo
d3ZpZiwgd3ZpZi0+d2VwX2RlZmF1bHRfa2V5X2lkKTsNCisJd2Z4X3BlbmRpbmdfcmVxdWV1ZSh3
dmlmLT53ZGV2LCB3dmlmLT53ZXBfcGVuZGluZ19za2IpOw0KKwl3dmlmLT53ZXBfcGVuZGluZ19z
a2IgPSBOVUxMOw0KKwl3ZnhfdHhfdW5sb2NrKHd2aWYtPndkZXYpOw0KK30NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2tleS5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9rZXkuaA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uOTQzNmNjZGY0ZDNiDQot
LS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2tleS5oDQpAQCAtMCwwICsx
LDIyIEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KKy8q
DQorICogSW1wbGVtZW50YXRpb24gb2YgbWFjODAyMTEgQVBJLg0KKyAqDQorICogQ29weXJpZ2h0
IChjKSAyMDE3LTIwMTksIFNpbGljb24gTGFib3JhdG9yaWVzLCBJbmMuDQorICogQ29weXJpZ2h0
IChjKSAyMDEwLCBTVC1Fcmljc3Nvbg0KKyAqLw0KKyNpZm5kZWYgV0ZYX0tFWV9IDQorI2RlZmlu
ZSBXRlhfS0VZX0gNCisNCisjaW5jbHVkZSA8bmV0L21hYzgwMjExLmg+DQorDQorc3RydWN0IHdm
eF9kZXY7DQorc3RydWN0IHdmeF92aWY7DQorDQoraW50IHdmeF9zZXRfa2V5KHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3LCBlbnVtIHNldF9rZXlfY21kIGNtZCwNCisJCXN0cnVjdCBpZWVlODAyMTFf
dmlmICp2aWYsIHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsDQorCQlzdHJ1Y3QgaWVlZTgwMjEx
X2tleV9jb25mICprZXkpOw0KK2ludCB3ZnhfdXBsb2FkX2tleXMoc3RydWN0IHdmeF92aWYgKnd2
aWYpOw0KK3ZvaWQgd2Z4X3dlcF9rZXlfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOw0K
Kw0KKyNlbmRpZiAvKiBXRlhfU1RBX0ggKi8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcv
d2Z4L21haW4uYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jDQppbmRleCAwNjIyMGJhYzVi
NzUuLmU3YmJhMjRhYWUwYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5j
DQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L21haW4uYw0KQEAgLTI3LDYgKzI3LDcgQEANCiAj
aW5jbHVkZSAiYnVzLmgiDQogI2luY2x1ZGUgImJoLmgiDQogI2luY2x1ZGUgInN0YS5oIg0KKyNp
bmNsdWRlICJrZXkuaCINCiAjaW5jbHVkZSAiZGVidWcuaCINCiAjaW5jbHVkZSAiZGF0YV90eC5o
Ig0KICNpbmNsdWRlICJzZWN1cmVfbGluay5oIg0KQEAgLTU2LDYgKzU3LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7DQogCS5yZW1vdmVfaW50ZXJmYWNl
CT0gd2Z4X3JlbW92ZV9pbnRlcmZhY2UsDQogCS50eAkJCT0gd2Z4X3R4LA0KIAkuaHdfc2NhbgkJ
PSB3ZnhfaHdfc2NhbiwNCisJLnNldF9rZXkJCT0gd2Z4X3NldF9rZXksDQogfTsNCiANCiBib29s
IHdmeF9hcGlfb2xkZXJfdGhhbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IG1ham9yLCBpbnQg
bWlub3IpDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYyBiL2RyaXZlcnMv
c3RhZ2luZy93Zngvc3RhLmMNCmluZGV4IDVhODE0MDEwMGU5Ny4uMmU3MDliOGEzYmY0IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5n
L3dmeC9zdGEuYw0KQEAgLTksNiArOSw3IEBADQogDQogI2luY2x1ZGUgInN0YS5oIg0KICNpbmNs
dWRlICJ3ZnguaCINCisjaW5jbHVkZSAia2V5LmgiDQogI2luY2x1ZGUgInNjYW4uaCINCiAjaW5j
bHVkZSAiaGlmX3R4X21pYi5oIg0KIA0KQEAgLTE2Miw2ICsxNjMsOSBAQCBpbnQgd2Z4X2FkZF9p
bnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2
aWYpDQogCUlOSVRfV09SSygmd3ZpZi0+bWNhc3Rfc3RvcF93b3JrLCB3ZnhfbWNhc3Rfc3RvcF93
b3JrKTsNCiAJdGltZXJfc2V0dXAoJnd2aWYtPm1jYXN0X3RpbWVvdXQsIHdmeF9tY2FzdF90aW1l
b3V0LCAwKTsNCiANCisJd3ZpZi0+d2VwX2RlZmF1bHRfa2V5X2lkID0gLTE7DQorCUlOSVRfV09S
Sygmd3ZpZi0+d2VwX2tleV93b3JrLCB3Znhfd2VwX2tleV93b3JrKTsNCisNCiAJc2VtYV9pbml0
KCZ3dmlmLT5zY2FuLmxvY2ssIDEpOw0KIAlJTklUX1dPUksoJnd2aWYtPnNjYW4ud29yaywgd2Z4
X3NjYW5fd29yayk7DQogCUlOSVRfREVMQVlFRF9XT1JLKCZ3dmlmLT5zY2FuLnRpbWVvdXQsIHdm
eF9zY2FuX3RpbWVvdXQpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngvd2Z4Lmgg
Yi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oDQppbmRleCA1MGMwZDljMGU1MjguLmE4NmRkZmFl
ZDgyNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93Zngvd2Z4LmgNCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy93Zngvd2Z4LmgNCkBAIC00OCw2ICs0OCw5IEBAIHN0cnVjdCB3ZnhfZGV2IHsN
CiAJaW50CQkJdHhfYnVyc3RfaWR4Ow0KIAlhdG9taWNfdAkJdHhfbG9jazsNCiANCisJdTMyCQkJ
a2V5X21hcDsNCisJc3RydWN0IGhpZl9yZXFfYWRkX2tleQlrZXlzW01BWF9LRVlfRU5UUklFU107
DQorDQogCXN0cnVjdCBoaWZfcnhfc3RhdHMJcnhfc3RhdHM7DQogCXN0cnVjdCBtdXRleAkJcnhf
c3RhdHNfbG9jazsNCiANCkBAIC03Myw2ICs3Niw5IEBAIHN0cnVjdCB3ZnhfdmlmIHsNCiAJc3Ry
dWN0IHdvcmtfc3RydWN0CW1jYXN0X3N0YXJ0X3dvcms7DQogCXN0cnVjdCB3b3JrX3N0cnVjdAlt
Y2FzdF9zdG9wX3dvcms7DQogDQorCXM4CQkJd2VwX2RlZmF1bHRfa2V5X2lkOw0KKwlzdHJ1Y3Qg
c2tfYnVmZgkJKndlcF9wZW5kaW5nX3NrYjsNCisJc3RydWN0IHdvcmtfc3RydWN0CXdlcF9rZXlf
d29yazsNCiANCiAJc3RydWN0IHR4X3BvbGljeV9jYWNoZQl0eF9wb2xpY3lfY2FjaGU7DQogCXN0
cnVjdCB3b3JrX3N0cnVjdAl0eF9wb2xpY3lfdXBsb2FkX3dvcms7DQpAQCAtMTIwLDYgKzEyNiwx
OSBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB3ZnhfdmlmICp3dmlmX2l0ZXJhdGUoc3RydWN0IHdm
eF9kZXYgKndkZXYsIHN0cnVjdCB3ZnhfdmlmDQogCXJldHVybiBOVUxMOw0KIH0NCiANCitzdGF0
aWMgaW5saW5lIHZvaWQgbWVtcmV2ZXJzZSh1aW50OF90ICpzcmMsIHVpbnQ4X3QgbGVuZ3RoKQ0K
K3sNCisJdWludDhfdCAqbG8gPSBzcmM7DQorCXVpbnQ4X3QgKmhpID0gc3JjICsgbGVuZ3RoIC0g
MTsNCisJdWludDhfdCBzd2FwOw0KKw0KKwl3aGlsZSAobG8gPCBoaSkgew0KKwkJc3dhcCA9ICps
bzsNCisJCSpsbysrID0gKmhpOw0KKwkJKmhpLS0gPSBzd2FwOw0KKwl9DQorfQ0KKw0KIHN0YXRp
YyBpbmxpbmUgaW50IG1lbXpjbXAodm9pZCAqc3JjLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCiB7DQog
CXVpbnQ4X3QgKmJ1ZiA9IHNyYzsNCi0tIA0KMi4yMC4xDQo=
