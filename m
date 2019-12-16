Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9355D121099
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 18:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLPREc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 12:04:32 -0500
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:49121
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfLPREC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 12:04:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+YbPKRKBF0YOQck+PlWh06x76HBPDS38f0jESJGol0j4mNFfWAfwfbTJZp1ByKHLnVG9zBTddGQU5J++OhydAjHwX2xt0MOcBhzFxCnQDxDbl35SSbfoD4q4wFMxqD+vpxtgmaXqvKEpyin0hPz65JHK7BM7+7/t5E2LLVT9z4ZRygcVG87NY/0ERFXa7DeBsMDQuYceD/cIgTKelwhamO+plMQ8VUP4JHgNkWLwGXkmv5IjVq1fG29wcK2e2lmBj4SbwT8mZCZY7rotaJHSBzMLjJDoQyADJ52etoPOIS0CEmn8QNdsy9uUcKtSUqACZYA+9Ujvv75r3/J+4vJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf29GQ1fMD5E/kSXlughPxFDT7SFM535rxjnJN7/yv0=;
 b=nK7HYAsL2gE6g+VjEgxCyPMrTUm4tgfelhsyhlFYI0tokepc0m3ONOoHBkLwOW37e1+9ZZWtzHSju+MNgHj9TqT+nqceJrjNBZ0xa9yujPhn7japIt2ytfCYYvnqRX+Sx0l3P+b5YeRP44MI7UY4813EgNwUOrwc0G7VXfzCfflgvcUGBhqwWJQC1IW9N2LM9prISL3QHe7yskGonGpIngCPoacb2mF50y6WY8lnTIDJ6Ly9ZOhy01jlEOXarTEKvJEuVqA+9XJfR2blz6dWFeKPqt1VtNwf5+4lQHLFJ+iflBE7DASPsI1HsW8/Q16uNhVUlK6uMGAnn7LeHKZSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf29GQ1fMD5E/kSXlughPxFDT7SFM535rxjnJN7/yv0=;
 b=h5tZF487YV9vdN2f1dh3A0f2Fk17RjmfUoFWMFW4tequjph1YABk3Rrf/9/tloBjMPnlh6wSQixmr6nKXMnOixiGtr5XqRg2eVwFInampdiS32C8YonSYmkBbranuaFBf09fG/8NhRrt5jxECMzzNTRVNx/hKpzBK0HsbPhH1so=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4351.namprd11.prod.outlook.com (52.135.39.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 17:03:52 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 17:03:52 +0000
From:   =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
Subject: [PATCH 22/55] staging: wfx: ensure that received hif messages are
 never modified
Thread-Topic: [PATCH 22/55] staging: wfx: ensure that received hif messages
 are never modified
Thread-Index: AQHVtDLGqmJKgRqRl0Sda3hQ6x5RxA==
Date:   Mon, 16 Dec 2019 17:03:45 +0000
Message-ID: <20191216170302.29543-23-Jerome.Pouiller@silabs.com>
References: <20191216170302.29543-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20191216170302.29543-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 584eb13b-d2b6-48b3-6066-08d78249ed8b
x-ms-traffictypediagnostic: MN2PR11MB4351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43510A2235D4DFA996CB5EA893510@MN2PR11MB4351.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(66556008)(66446008)(64756008)(66476007)(76116006)(85202003)(91956017)(66946007)(54906003)(107886003)(4326008)(478600001)(110136005)(71200400001)(6512007)(81156014)(8676002)(81166006)(186003)(36756003)(30864003)(2906002)(85182001)(6666004)(66574012)(15650500001)(1076003)(316002)(6506007)(5660300002)(86362001)(26005)(2616005)(6486002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4351;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtOgu6/MoFTvHYBOJHtcMl2Tca4AObSDPImEGY1UD5KYkx8no4smO8k4OOSXgxMF9iIxJTBHj0e5AznZw3LMhP8ZdbX/G7NAITyA6ttxYZE8B4q1GULmlEoLOMWRrpa64Rup6BZ2hNP8n2MaWLKYIAK/IuSmgRUDdVvLz4HtNX8lszI3ttCBccO3aZ4c8B5OfVskhPtPFSl+IyyOyeV8Lm8FIKS16tn/Nzs7Q1hxC7D0msTvQCN6upaw8NVV3t825top/oe/CVxlxK0DpAXoFMxFpwyqC96MyxjB0I0TiDSKVbewfEoPmeojp2UAL1eGMIbm/cY8MFIToSgxYi/gy+JAB12GlfjDoAMYPlqmE4QLTgO9/v9y+E4pOPwr/Raq6MU2SxrsQITTC5Fd5ry4lbvORIlcF7C6m9VcT34eKetzUoVbLo2vH9QSUaL+xhFI
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B94E65E11F1F345A49ECB848BA026C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584eb13b-d2b6-48b3-6066-08d78249ed8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:03:45.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+hkpMwNxrMiMOS6ThdvYlLp7NjW+N1LtqDCzFYCK8oLKCOGE8PBN7wEMaAz5dl4yPm9mAyERPBWGXGNswUojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4351
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpU
aGVyZSBhcmUgbm8gcmVhbCByZWFzb24gdG8gbW9kaWZ5IHRoZSBkYXRhIHJlY2VpdmVkIGZyb20g
ZGV2aWNlLiBTbywNCmxldCdzIG1hcmsgdGhlIGFyZ3VtZW50cyBjb25zdGFudC4NCg0KU2lnbmVk
LW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0K
LS0tDQogZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmMgICAgIHwgIDggKystDQogZHJpdmVy
cy9zdGFnaW5nL3dmeC9kYXRhX3J4LmggICAgIHwgIDQgKy0NCiBkcml2ZXJzL3N0YWdpbmcvd2Z4
L2RhdGFfdHguYyAgICAgfCAgMiArLQ0KIGRyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV90eC5oICAg
ICB8ICAyICstDQogZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfcnguYyAgICAgIHwgOTQgKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvc3RhZ2luZy93Zngvc2Nhbi5jICAg
ICAgICB8ICAzICstDQogZHJpdmVycy9zdGFnaW5nL3dmeC9zY2FuLmggICAgICAgIHwgIDMgKy0N
CiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3NlY3VyZV9saW5rLmggfCAgOCArKy0NCiBkcml2ZXJzL3N0
YWdpbmcvd2Z4L3N0YS5jICAgICAgICAgfCAgMiArLQ0KIGRyaXZlcnMvc3RhZ2luZy93Zngvc3Rh
LmggICAgICAgICB8ICAyICstDQogMTAgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwg
NTYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFf
cnguYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV9yeC5jDQppbmRleCBlN2ZjY2U4ZDBjYzQu
LmQ0NjBjMGZmY2ExZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV9yeC5j
DQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfcnguYw0KQEAgLTQ4LDcgKzQ4LDkgQEAg
c3RhdGljIGludCB3ZnhfaGFuZGxlX3BzcG9sbChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0
IHNrX2J1ZmYgKnNrYikNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgd2Z4X2Ryb3Bf
ZW5jcnlwdF9kYXRhKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX2luZF9yeCAqYXJn
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KK3N0YXRpYyBpbnQgd2Z4X2Ryb3BfZW5jcnlwdF9kYXRh
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KKwkJCQkgY29uc3Qgc3RydWN0IGhpZl9pbmRfcnggKmFy
ZywNCisJCQkJIHN0cnVjdCBza19idWZmICpza2IpDQogew0KIAlzdHJ1Y3QgaWVlZTgwMjExX2hk
ciAqZnJhbWUgPSAoc3RydWN0IGllZWU4MDIxMV9oZHIgKikgc2tiLT5kYXRhOw0KIAlzaXplX3Qg
aGRybGVuID0gaWVlZTgwMjExX2hkcmxlbihmcmFtZS0+ZnJhbWVfY29udHJvbCk7DQpAQCAtOTgs
OCArMTAwLDggQEAgc3RhdGljIGludCB3ZnhfZHJvcF9lbmNyeXB0X2RhdGEoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHN0cnVjdCBoaWZfaW5kX3J4ICphcmcsIHMNCiANCiB9DQogDQotdm9pZCB3Znhf
cnhfY2Ioc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBoaWZfaW5kX3J4ICphcmcsDQotCSAg
ICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KK3ZvaWQgd2Z4X3J4X2NiKHN0cnVjdCB3Znhfdmlm
ICp3dmlmLA0KKwkgICAgICAgY29uc3Qgc3RydWN0IGhpZl9pbmRfcnggKmFyZywgc3RydWN0IHNr
X2J1ZmYgKnNrYikNCiB7DQogCWludCBsaW5rX2lkID0gYXJnLT5yeF9mbGFncy5wZWVyX3N0YV9p
ZDsNCiAJc3RydWN0IGllZWU4MDIxMV9yeF9zdGF0dXMgKmhkciA9IElFRUU4MDIxMV9TS0JfUlhD
Qihza2IpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV9yeC5oIGIvZHJp
dmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmgNCmluZGV4IGE1MGNlMzUyYmM1ZS4uNjFjMjhiZmQy
YTM3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3J4LmgNCisrKyBiL2Ry
aXZlcnMvc3RhZ2luZy93ZngvZGF0YV9yeC5oDQpAQCAtMTMsNyArMTMsNyBAQA0KIHN0cnVjdCB3
ZnhfdmlmOw0KIHN0cnVjdCBza19idWZmOw0KIA0KLXZvaWQgd2Z4X3J4X2NiKHN0cnVjdCB3Znhf
dmlmICp3dmlmLCBzdHJ1Y3QgaGlmX2luZF9yeCAqYXJnLA0KLQkgICAgICAgc3RydWN0IHNrX2J1
ZmYgKnNrYik7DQordm9pZCB3ZnhfcnhfY2Ioc3RydWN0IHdmeF92aWYgKnd2aWYsDQorCSAgICAg
ICBjb25zdCBzdHJ1Y3QgaGlmX2luZF9yeCAqYXJnLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsNCiAN
CiAjZW5kaWYgLyogV0ZYX0RBVEFfUlhfSCAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2lu
Zy93ZngvZGF0YV90eC5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmMNCmluZGV4IGM5
ZGVhNjI3NjYxZi4uYTQ1MjQzYTdmMTVmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dm
eC9kYXRhX3R4LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV90eC5jDQpAQCAtNzIw
LDcgKzcyMCw3IEBAIHZvaWQgd2Z4X3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3Qg
aWVlZTgwMjExX3R4X2NvbnRyb2wgKmNvbnRyb2wsDQogCWllZWU4MDIxMV90eF9zdGF0dXNfaXJx
c2FmZSh3ZGV2LT5odywgc2tiKTsNCiB9DQogDQotdm9pZCB3ZnhfdHhfY29uZmlybV9jYihzdHJ1
Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0IGhpZl9jbmZfdHggKmFyZykNCit2b2lkIHdmeF90eF9j
b25maXJtX2NiKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBjb25zdCBzdHJ1Y3QgaGlmX2NuZl90eCAq
YXJnKQ0KIHsNCiAJaW50IGk7DQogCWludCB0eF9jb3VudDsNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvd2Z4L2RhdGFfdHguaCBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZGF0YV90eC5oDQpp
bmRleCAwZmMzODhkYjYyZTAuLjA3OGQwY2ZjNTIxYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvZGF0YV90eC5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfdHguaA0K
QEAgLTY1LDcgKzY1LDcgQEAgdm9pZCB3ZnhfdHhfcG9saWN5X3VwbG9hZF93b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yayk7DQogDQogdm9pZCB3ZnhfdHgoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsIHN0cnVjdCBpZWVlODAyMTFfdHhfY29udHJvbCAqY29udHJvbCwNCiAJICAgIHN0cnVjdCBz
a19idWZmICpza2IpOw0KLXZvaWQgd2Z4X3R4X2NvbmZpcm1fY2Ioc3RydWN0IHdmeF92aWYgKnd2
aWYsIHN0cnVjdCBoaWZfY25mX3R4ICphcmcpOw0KK3ZvaWQgd2Z4X3R4X2NvbmZpcm1fY2Ioc3Ry
dWN0IHdmeF92aWYgKnd2aWYsIGNvbnN0IHN0cnVjdCBoaWZfY25mX3R4ICphcmcpOw0KIHZvaWQg
d2Z4X3NrYl9kdG9yKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsN
CiANCiBpbnQgd2Z4X3VubWFwX2xpbmsoc3RydWN0IHdmeF92aWYgKnd2aWYsIGludCBsaW5rX2lk
KTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5jIGIvZHJpdmVycy9z
dGFnaW5nL3dmeC9oaWZfcnguYw0KaW5kZXggMTQ5NGFkNWE1MDdiLi44YTNjY2RjNjBiN2QgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5jDQorKysgYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L2hpZl9yeC5jDQpAQCAtMTgsOCArMTgsOCBAQA0KICNpbmNsdWRlICJzZWN1cmVf
bGluay5oIg0KICNpbmNsdWRlICJoaWZfYXBpX2NtZC5oIg0KIA0KLXN0YXRpYyBpbnQgaGlmX2dl
bmVyaWNfY29uZmlybShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc3RydWN0IGhpZl9tc2cgKmhpZiwN
Ci0JCQkgICAgICAgdm9pZCAqYnVmKQ0KK3N0YXRpYyBpbnQgaGlmX2dlbmVyaWNfY29uZmlybShz
dHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCisJCQkgICAgICAgY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhp
ZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCiAJLy8gQWxsIGNvbmZpcm0gbWVzc2FnZXMgc3RhcnQg
d2l0aCBzdGF0dXMNCiAJaW50IHN0YXR1cyA9IGxlMzJfdG9fY3B1KCooKF9fbGUzMiAqKSBidWYp
KTsNCkBAIC01OSw5ICs1OSwxMCBAQCBzdGF0aWMgaW50IGhpZl9nZW5lcmljX2NvbmZpcm0oc3Ry
dWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZfbXNnICpoaWYsDQogCXJldHVybiBzdGF0dXM7
DQogfQ0KIA0KLXN0YXRpYyBpbnQgaGlmX3R4X2NvbmZpcm0oc3RydWN0IHdmeF9kZXYgKndkZXYs
IHN0cnVjdCBoaWZfbXNnICpoaWYsIHZvaWQgKmJ1ZikNCitzdGF0aWMgaW50IGhpZl90eF9jb25m
aXJtKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KKwkJCSAgY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhp
ZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCi0Jc3RydWN0IGhpZl9jbmZfdHggKmJvZHkgPSBidWY7
DQorCWNvbnN0IHN0cnVjdCBoaWZfY25mX3R4ICpib2R5ID0gYnVmOw0KIAlzdHJ1Y3Qgd2Z4X3Zp
ZiAqd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYtPmludGVyZmFjZSk7DQogDQogCVdBUk5f
T04oIXd2aWYpOw0KQEAgLTcyLDExICs3MywxMiBAQCBzdGF0aWMgaW50IGhpZl90eF9jb25maXJt
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCB2b2lkICpidWYpDQog
CXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IGhpZl9tdWx0aV90eF9jb25maXJtKHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KLQkJCQl2b2lkICpidWYpDQor
c3RhdGljIGludCBoaWZfbXVsdGlfdHhfY29uZmlybShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCisJ
CQkJY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCi0Jc3Ry
dWN0IGhpZl9jbmZfbXVsdGlfdHJhbnNtaXQgKmJvZHkgPSBidWY7DQotCXN0cnVjdCBoaWZfY25m
X3R4ICpidWZfbG9jID0gKHN0cnVjdCBoaWZfY25mX3R4ICopICZib2R5LT50eF9jb25mX3BheWxv
YWQ7DQorCWNvbnN0IHN0cnVjdCBoaWZfY25mX211bHRpX3RyYW5zbWl0ICpib2R5ID0gYnVmOw0K
Kwljb25zdCBzdHJ1Y3QgaGlmX2NuZl90eCAqYnVmX2xvYyA9DQorCQkoY29uc3Qgc3RydWN0IGhp
Zl9jbmZfdHggKikmYm9keS0+dHhfY29uZl9wYXlsb2FkOw0KIAlzdHJ1Y3Qgd2Z4X3ZpZiAqd3Zp
ZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYtPmludGVyZmFjZSk7DQogCWludCBjb3VudCA9IGJv
ZHktPm51bV90eF9jb25mczsNCiAJaW50IGk7DQpAQCAtOTMsMTAgKzk1LDEwIEBAIHN0YXRpYyBp
bnQgaGlmX211bHRpX3R4X2NvbmZpcm0oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZf
bXNnICpoaWYsDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IGhpZl9zdGFydHVwX2lu
ZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZfbXNnICpoaWYsDQotCQkJ
CSAgdm9pZCAqYnVmKQ0KK3N0YXRpYyBpbnQgaGlmX3N0YXJ0dXBfaW5kaWNhdGlvbihzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwNCisJCQkJICBjb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2
b2lkICpidWYpDQogew0KLQlzdHJ1Y3QgaGlmX2luZF9zdGFydHVwICpib2R5ID0gYnVmOw0KKwlj
b25zdCBzdHJ1Y3QgaGlmX2luZF9zdGFydHVwICpib2R5ID0gYnVmOw0KIA0KIAlpZiAoYm9keS0+
c3RhdHVzIHx8IGJvZHktPmZpcm13YXJlX3R5cGUgPiA0KSB7DQogCQlkZXZfZXJyKHdkZXYtPmRl
diwgInJlY2VpdmVkIGludmFsaWQgc3RhcnR1cCBpbmRpY2F0aW9uIik7DQpAQCAtMTEyLDggKzEx
NCw4IEBAIHN0YXRpYyBpbnQgaGlmX3N0YXJ0dXBfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAq
d2Rldiwgc3RydWN0IGhpZl9tc2cgKmhpZiwNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBp
bnQgaGlmX3dha2V1cF9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlm
X21zZyAqaGlmLA0KLQkJCQkgdm9pZCAqYnVmKQ0KK3N0YXRpYyBpbnQgaGlmX3dha2V1cF9pbmRp
Y2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KKwkJCQkgY29uc3Qgc3RydWN0IGhpZl9tc2cg
KmhpZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCiAJaWYgKCF3ZGV2LT5wZGF0YS5ncGlvX3dha2V1
cA0KIAkgICAgfHwgIWdwaW9kX2dldF92YWx1ZSh3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCkpIHsN
CkBAIC0xMjMsMjUgKzEyNSwyNyBAQCBzdGF0aWMgaW50IGhpZl93YWtldXBfaW5kaWNhdGlvbihz
dHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc3RydWN0IGhpZl9tc2cgKmhpZiwNCiAJcmV0dXJuIDA7DQog
fQ0KIA0KLXN0YXRpYyBpbnQgaGlmX2tleXNfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwgc3RydWN0IGhpZl9tc2cgKmhpZiwNCi0JCQkgICAgICAgdm9pZCAqYnVmKQ0KK3N0YXRpYyBp
bnQgaGlmX2tleXNfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCisJCQkgICAgICAg
Y29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCi0Jc3RydWN0
IGhpZl9pbmRfc2xfZXhjaGFuZ2VfcHViX2tleXMgKmJvZHkgPSBidWY7DQorCWNvbnN0IHN0cnVj
dCBoaWZfaW5kX3NsX2V4Y2hhbmdlX3B1Yl9rZXlzICpib2R5ID0gYnVmOw0KKwl1OCBwdWJrZXlb
QVBJX05DUF9QVUJfS0VZX1NJWkVdOw0KIA0KLQkvLyBDb21wYXRpYmlsaXR5IHdpdGggbGVnYWN5
IHNlY3VyZSBsaW5rDQotCWlmIChib2R5LT5zdGF0dXMgPT0gU0xfUFVCX0tFWV9FWENIQU5HRV9T
VEFUVVNfU1VDQ0VTUykNCi0JCWJvZHktPnN0YXR1cyA9IDA7DQotCWlmIChib2R5LT5zdGF0dXMp
DQorCS8vIFNMX1BVQl9LRVlfRVhDSEFOR0VfU1RBVFVTX1NVQ0NFU1MgaXMgdXNlZCBieSBsZWdh
Y3kgc2VjdXJlIGxpbmsNCisJaWYgKGJvZHktPnN0YXR1cyAmJiBib2R5LT5zdGF0dXMgIT0gU0xf
UFVCX0tFWV9FWENIQU5HRV9TVEFUVVNfU1VDQ0VTUykNCiAJCWRldl93YXJuKHdkZXYtPmRldiwg
InNlY3VyZSBsaW5rIG5lZ29jaWF0aW9uIGVycm9yXG4iKTsNCi0Jd2Z4X3NsX2NoZWNrX3B1Ymtl
eSh3ZGV2LCBib2R5LT5uY3BfcHViX2tleSwgYm9keS0+bmNwX3B1Yl9rZXlfbWFjKTsNCisJbWVt
Y3B5KHB1YmtleSwgYm9keS0+bmNwX3B1Yl9rZXksIHNpemVvZihwdWJrZXkpKTsNCisJbWVtcmV2
ZXJzZShwdWJrZXksIHNpemVvZihwdWJrZXkpKTsNCisJd2Z4X3NsX2NoZWNrX3B1YmtleSh3ZGV2
LCBwdWJrZXksIGJvZHktPm5jcF9wdWJfa2V5X21hYyk7DQogCXJldHVybiAwOw0KIH0NCiANCi1z
dGF0aWMgaW50IGhpZl9yZWNlaXZlX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0
cnVjdCBoaWZfbXNnICpoaWYsDQotCQkJCSAgdm9pZCAqYnVmLCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
KQ0KK3N0YXRpYyBpbnQgaGlmX3JlY2VpdmVfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwNCisJCQkJICBjb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KKwkJCQkgIGNvbnN0IHZvaWQg
KmJ1Ziwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiB7DQogCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0g
d2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNlKTsNCi0Jc3RydWN0IGhpZl9pbmRfcngg
KmJvZHkgPSBidWY7DQorCWNvbnN0IHN0cnVjdCBoaWZfaW5kX3J4ICpib2R5ID0gYnVmOw0KIA0K
IAlpZiAoIXd2aWYpIHsNCiAJCWRldl93YXJuKHdkZXYtPmRldiwgImlnbm9yZSByeCBkYXRhIGZv
ciBub24tZXhpc3RlbnQgdmlmICVkXG4iLA0KQEAgLTE1NCwxMSArMTU4LDExIEBAIHN0YXRpYyBp
bnQgaGlmX3JlY2VpdmVfaW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc3RydWN0IGhp
Zl9tc2cgKmhpZiwNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgaGlmX2V2ZW50X2lu
ZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZfbXNnICpoaWYsDQotCQkJ
CXZvaWQgKmJ1ZikNCitzdGF0aWMgaW50IGhpZl9ldmVudF9pbmRpY2F0aW9uKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2LA0KKwkJCQljb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLCBjb25zdCB2b2lkICpi
dWYpDQogew0KIAlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYt
PmludGVyZmFjZSk7DQotCXN0cnVjdCBoaWZfaW5kX2V2ZW50ICpib2R5ID0gYnVmOw0KKwljb25z
dCBzdHJ1Y3QgaGlmX2luZF9ldmVudCAqYm9keSA9IGJ1ZjsNCiAJc3RydWN0IHdmeF9oaWZfZXZl
bnQgKmV2ZW50Ow0KIAlpbnQgZmlyc3Q7DQogDQpAQCAtMTgzLDcgKzE4Nyw4IEBAIHN0YXRpYyBp
bnQgaGlmX2V2ZW50X2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZf
bXNnICpoaWYsDQogfQ0KIA0KIHN0YXRpYyBpbnQgaGlmX3BtX21vZGVfY29tcGxldGVfaW5kaWNh
dGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCi0JCQkJCSAgIHN0cnVjdCBoaWZfbXNnICpoaWYs
IHZvaWQgKmJ1ZikNCisJCQkJCSAgIGNvbnN0IHN0cnVjdCBoaWZfbXNnICpoaWYsDQorCQkJCQkg
ICBjb25zdCB2b2lkICpidWYpDQogew0KIAlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IHdkZXZfdG9f
d3ZpZih3ZGV2LCBoaWYtPmludGVyZmFjZSk7DQogDQpAQCAtMTk0LDEwICsxOTksMTEgQEAgc3Rh
dGljIGludCBoaWZfcG1fbW9kZV9jb21wbGV0ZV9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2LA0KIH0NCiANCiBzdGF0aWMgaW50IGhpZl9zY2FuX2NvbXBsZXRlX2luZGljYXRpb24oc3Ry
dWN0IHdmeF9kZXYgKndkZXYsDQotCQkJCQlzdHJ1Y3QgaGlmX21zZyAqaGlmLCB2b2lkICpidWYp
DQorCQkJCQljb25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KKwkJCQkJY29uc3Qgdm9pZCAqYnVm
KQ0KIHsNCiAJc3RydWN0IHdmeF92aWYgKnd2aWYgPSB3ZGV2X3RvX3d2aWYod2RldiwgaGlmLT5p
bnRlcmZhY2UpOw0KLQlzdHJ1Y3QgaGlmX2luZF9zY2FuX2NtcGwgKmJvZHkgPSBidWY7DQorCWNv
bnN0IHN0cnVjdCBoaWZfaW5kX3NjYW5fY21wbCAqYm9keSA9IGJ1ZjsNCiANCiAJV0FSTl9PTigh
d3ZpZik7DQogCXdmeF9zY2FuX2NvbXBsZXRlX2NiKHd2aWYsIGJvZHkpOw0KQEAgLTIwNiw3ICsy
MTIsOCBAQCBzdGF0aWMgaW50IGhpZl9zY2FuX2NvbXBsZXRlX2luZGljYXRpb24oc3RydWN0IHdm
eF9kZXYgKndkZXYsDQogfQ0KIA0KIHN0YXRpYyBpbnQgaGlmX2pvaW5fY29tcGxldGVfaW5kaWNh
dGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCi0JCQkJCXN0cnVjdCBoaWZfbXNnICpoaWYsIHZv
aWQgKmJ1ZikNCisJCQkJCWNvbnN0IHN0cnVjdCBoaWZfbXNnICpoaWYsDQorCQkJCQljb25zdCB2
b2lkICpidWYpDQogew0KIAlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2
LCBoaWYtPmludGVyZmFjZSk7DQogDQpAQCAtMjE3LDEwICsyMjQsMTEgQEAgc3RhdGljIGludCBo
aWZfam9pbl9jb21wbGV0ZV9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KIH0NCiAN
CiBzdGF0aWMgaW50IGhpZl9zdXNwZW5kX3Jlc3VtZV9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LA0KLQkJCQkJIHN0cnVjdCBoaWZfbXNnICpoaWYsIHZvaWQgKmJ1ZikNCisJCQkJCSBj
b25zdCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KKwkJCQkJIGNvbnN0IHZvaWQgKmJ1ZikNCiB7DQog
CXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gd2Rldl90b193dmlmKHdkZXYsIGhpZi0+aW50ZXJmYWNl
KTsNCi0Jc3RydWN0IGhpZl9pbmRfc3VzcGVuZF9yZXN1bWVfdHggKmJvZHkgPSBidWY7DQorCWNv
bnN0IHN0cnVjdCBoaWZfaW5kX3N1c3BlbmRfcmVzdW1lX3R4ICpib2R5ID0gYnVmOw0KIA0KIAlX
QVJOX09OKCF3dmlmKTsNCiAJd2Z4X3N1c3BlbmRfcmVzdW1lKHd2aWYsIGJvZHkpOw0KQEAgLTIy
OCwxMCArMjM2LDEwIEBAIHN0YXRpYyBpbnQgaGlmX3N1c3BlbmRfcmVzdW1lX2luZGljYXRpb24o
c3RydWN0IHdmeF9kZXYgKndkZXYsDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IGhp
Zl9lcnJvcl9pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAq
aGlmLA0KLQkJCQl2b2lkICpidWYpDQorc3RhdGljIGludCBoaWZfZXJyb3JfaW5kaWNhdGlvbihz
dHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCisJCQkJY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29u
c3Qgdm9pZCAqYnVmKQ0KIHsNCi0Jc3RydWN0IGhpZl9pbmRfZXJyb3IgKmJvZHkgPSBidWY7DQor
CWNvbnN0IHN0cnVjdCBoaWZfaW5kX2Vycm9yICpib2R5ID0gYnVmOw0KIAl1OCAqcFJvbGxiYWNr
ID0gKHU4ICopIGJvZHktPmRhdGE7DQogCXUzMiAqcFN0YXR1cyA9ICh1MzIgKikgYm9keS0+ZGF0
YTsNCiANCkBAIC0yNjgsMTAgKzI3NiwxMCBAQCBzdGF0aWMgaW50IGhpZl9lcnJvcl9pbmRpY2F0
aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KIAlyZXR1cm4g
MDsNCiB9DQogDQotc3RhdGljIGludCBoaWZfZ2VuZXJpY19pbmRpY2F0aW9uKHN0cnVjdCB3Znhf
ZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KLQkJCQkgIHZvaWQgKmJ1ZikNCitzdGF0
aWMgaW50IGhpZl9nZW5lcmljX2luZGljYXRpb24oc3RydWN0IHdmeF9kZXYgKndkZXYsDQorCQkJ
CSAgY29uc3Qgc3RydWN0IGhpZl9tc2cgKmhpZiwgY29uc3Qgdm9pZCAqYnVmKQ0KIHsNCi0Jc3Ry
dWN0IGhpZl9pbmRfZ2VuZXJpYyAqYm9keSA9IGJ1ZjsNCisJY29uc3Qgc3RydWN0IGhpZl9pbmRf
Z2VuZXJpYyAqYm9keSA9IGJ1ZjsNCiANCiAJc3dpdGNoIChib2R5LT5pbmRpY2F0aW9uX3R5cGUp
IHsNCiAJY2FzZSBISUZfR0VORVJJQ19JTkRJQ0FUSU9OX1RZUEVfUkFXOg0KQEAgLTI5OSw5ICsz
MDcsMTAgQEAgc3RhdGljIGludCBoaWZfZ2VuZXJpY19pbmRpY2F0aW9uKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqaGlmLA0KIH0NCiANCiBzdGF0aWMgaW50IGhpZl9leGNl
cHRpb25faW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwNCi0JCQkJICAgIHN0cnVjdCBo
aWZfbXNnICpoaWYsIHZvaWQgKmJ1ZikNCisJCQkJICAgIGNvbnN0IHN0cnVjdCBoaWZfbXNnICpo
aWYsIGNvbnN0IHZvaWQgKmJ1ZikNCiB7DQogCXNpemVfdCBsZW4gPSBoaWYtPmxlbiAtIDQ7IC8v
IGRyb3AgaGVhZGVyDQorDQogCWRldl9lcnIod2Rldi0+ZGV2LCAiZmlybXdhcmUgZXhjZXB0aW9u
XG4iKTsNCiAJcHJpbnRfaGV4X2R1bXBfYnl0ZXMoIkR1bXA6ICIsIERVTVBfUFJFRklYX05PTkUs
IGJ1ZiwgbGVuKTsNCiAJd2Rldi0+Y2hpcF9mcm96ZW4gPSAxOw0KQEAgLTMxMSw3ICszMjAsOCBA
QCBzdGF0aWMgaW50IGhpZl9leGNlcHRpb25faW5kaWNhdGlvbihzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCiAJaW50IG1zZ19pZDsNCi0JaW50ICgqaGFu
ZGxlcikoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZfbXNnICpoaWYsIHZvaWQgKmJ1
Zik7DQorCWludCAoKmhhbmRsZXIpKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KKwkJICAgICAgIGNv
bnN0IHN0cnVjdCBoaWZfbXNnICpoaWYsIGNvbnN0IHZvaWQgKmJ1Zik7DQogfSBoaWZfaGFuZGxl
cnNbXSA9IHsNCiAJLyogQ29uZmlybWF0aW9ucyAqLw0KIAl7IEhJRl9DTkZfSURfVFgsICAgICAg
ICAgICAgICAgICAgIGhpZl90eF9jb25maXJtIH0sDQpAQCAtMzM1LDcgKzM0NSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgew0KIHZvaWQgd2Z4X2hhbmRsZV9yeChzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiB7DQogCWludCBpOw0KLQlzdHJ1Y3QgaGlmX21zZyAq
aGlmID0gKHN0cnVjdCBoaWZfbXNnICopIHNrYi0+ZGF0YTsNCisJY29uc3Qgc3RydWN0IGhpZl9t
c2cgKmhpZiA9IChjb25zdCBzdHJ1Y3QgaGlmX21zZyAqKXNrYi0+ZGF0YTsNCiAJaW50IGhpZl9p
ZCA9IGhpZi0+aWQ7DQogDQogCWlmIChoaWZfaWQgPT0gSElGX0lORF9JRF9SWCkgew0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngvc2Nhbi5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9z
Y2FuLmMNCmluZGV4IGE2YzkzNDAwYTdiYS4uNDVlNzhjNTcyMmZmIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zdGFnaW5nL3dmeC9zY2FuLmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93Zngvc2Nhbi5j
DQpAQCAtMjY3LDcgKzI2Nyw4IEBAIHZvaWQgd2Z4X3NjYW5fZmFpbGVkX2NiKHN0cnVjdCB3Znhf
dmlmICp3dmlmKQ0KIAl9DQogfQ0KIA0KLXZvaWQgd2Z4X3NjYW5fY29tcGxldGVfY2Ioc3RydWN0
IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBoaWZfaW5kX3NjYW5fY21wbCAqYXJnKQ0KK3ZvaWQgd2Z4
X3NjYW5fY29tcGxldGVfY2Ioc3RydWN0IHdmeF92aWYgKnd2aWYsDQorCQkJICBjb25zdCBzdHJ1
Y3QgaGlmX2luZF9zY2FuX2NtcGwgKmFyZykNCiB7DQogCWlmIChjYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoJnd2aWYtPnNjYW4udGltZW91dCkgPiAwKSB7DQogCQl3dmlmLT5zY2FuLnN0YXR1cyA9
IDE7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zY2FuLmggYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L3NjYW4uaA0KaW5kZXggYjRkZGQwNzcxYTliLi5jN2MwYWIxNzhjODcgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3NjYW4uaA0KKysrIGIvZHJpdmVycy9zdGFnaW5n
L3dmeC9zY2FuLmgNCkBAIC0zNiw3ICszNiw4IEBAIGludCB3ZnhfaHdfc2NhbihzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJCXN0cnVjdCBpZWVl
ODAyMTFfc2Nhbl9yZXF1ZXN0ICpyZXEpOw0KIHZvaWQgd2Z4X3NjYW5fd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspOw0KIHZvaWQgd2Z4X3NjYW5fdGltZW91dChzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspOw0KLXZvaWQgd2Z4X3NjYW5fY29tcGxldGVfY2Ioc3RydWN0IHdmeF92aWYgKnd2
aWYsIHN0cnVjdCBoaWZfaW5kX3NjYW5fY21wbCAqYXJnKTsNCit2b2lkIHdmeF9zY2FuX2NvbXBs
ZXRlX2NiKHN0cnVjdCB3ZnhfdmlmICp3dmlmLA0KKwkJCSAgY29uc3Qgc3RydWN0IGhpZl9pbmRf
c2Nhbl9jbXBsICphcmcpOw0KIHZvaWQgd2Z4X3NjYW5fZmFpbGVkX2NiKHN0cnVjdCB3Znhfdmlm
ICp3dmlmKTsNCiANCiAjZW5kaWYgLyogV0ZYX1NDQU5fSCAqLw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc3RhZ2luZy93Zngvc2VjdXJlX2xpbmsuaCBiL2RyaXZlcnMvc3RhZ2luZy93Zngvc2VjdXJl
X2xpbmsuaA0KaW5kZXggNjY2YjI2ZTUzMDhkLi5jM2QwNTViMmY4YjEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3N0YWdpbmcvd2Z4L3NlY3VyZV9saW5rLmgNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93
Zngvc2VjdXJlX2xpbmsuaA0KQEAgLTI1LDE0ICsyNSwxNiBAQCBzdGF0aWMgaW5saW5lIGludCB3
Znhfc2xfZGVjb2RlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX3NsX21zZyAqbSkN
CiAJcmV0dXJuIC1FSU87DQogfQ0KIA0KLXN0YXRpYyBpbmxpbmUgaW50IHdmeF9zbF9lbmNvZGUo
c3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBoaWZfbXNnICppbnB1dCwNCitzdGF0aWMgaW5s
aW5lIGludCB3Znhfc2xfZW5jb2RlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LA0KKwkJCQljb25zdCBz
dHJ1Y3QgaGlmX21zZyAqaW5wdXQsDQogCQkJCXN0cnVjdCBoaWZfc2xfbXNnICpvdXRwdXQpDQog
ew0KIAlyZXR1cm4gLUVJTzsNCiB9DQogDQotc3RhdGljIGlubGluZSBpbnQgd2Z4X3NsX2NoZWNr
X3B1YmtleShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTggKm5jcF9wdWJrZXksDQotCQkJCSAgICAg
IHU4ICpuY3BfcHVibWFjKQ0KK3N0YXRpYyBpbmxpbmUgaW50IHdmeF9zbF9jaGVja19wdWJrZXko
c3RydWN0IHdmeF9kZXYgKndkZXYsDQorCQkJCSAgICAgIGNvbnN0IHU4ICpuY3BfcHVia2V5LA0K
KwkJCQkgICAgICBjb25zdCB1OCAqbmNwX3B1Ym1hYykNCiB7DQogCXJldHVybiAtRUlPOw0KIH0N
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jIGIvZHJpdmVycy9zdGFnaW5n
L3dmeC9zdGEuYw0KaW5kZXggN2Y0ZWFhOGU2ZDg0Li5iNGJiNWI2NTNlNjQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0
YS5jDQpAQCAtMTM0NSw3ICsxMzQ1LDcgQEAgaW50IHdmeF9hbXBkdV9hY3Rpb24oc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcsDQogfQ0KIA0KIHZvaWQgd2Z4X3N1c3BlbmRfcmVzdW1lKHN0cnVjdCB3
ZnhfdmlmICp3dmlmLA0KLQkJCXN0cnVjdCBoaWZfaW5kX3N1c3BlbmRfcmVzdW1lX3R4ICphcmcp
DQorCQkJY29uc3Qgc3RydWN0IGhpZl9pbmRfc3VzcGVuZF9yZXN1bWVfdHggKmFyZykNCiB7DQog
CWlmIChhcmctPnN1c3BlbmRfcmVzdW1lX2ZsYWdzLmJjX21jX29ubHkpIHsNCiAJCWJvb2wgY2Fu
Y2VsX3RtbyA9IGZhbHNlOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmgg
Yi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5oDQppbmRleCA0Y2NmMWIxNzYzMmIuLjcyMWI3Y2Vl
OWMxMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmgNCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy93Zngvc3RhLmgNCkBAIC05Miw3ICs5Miw3IEBAIHZvaWQgd2Z4X3VuYXNzaWdu
X3ZpZl9jaGFuY3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KIA0KIC8vIFdTTSBDYWxsYmFj
a3MNCiB2b2lkIHdmeF9zdXNwZW5kX3Jlc3VtZShzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwNCi0JCQlz
dHJ1Y3QgaGlmX2luZF9zdXNwZW5kX3Jlc3VtZV90eCAqYXJnKTsNCisJCQljb25zdCBzdHJ1Y3Qg
aGlmX2luZF9zdXNwZW5kX3Jlc3VtZV90eCAqYXJnKTsNCiANCiAvLyBPdGhlciBIZWxwZXJzDQog
dm9pZCB3ZnhfY3FtX2Jzc2xvc3Nfc20oc3RydWN0IHdmeF92aWYgKnd2aWYsIGludCBpbml0LCBp
bnQgZ29vZCwgaW50IGJhZCk7DQotLSANCjIuMjAuMQ0K
