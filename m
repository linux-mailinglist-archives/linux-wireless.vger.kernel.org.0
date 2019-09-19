Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA7B77FE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbfISKwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 06:52:49 -0400
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:25057
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389412AbfISKwq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 06:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1JTycXEXUsXuxhFX1CzarOrIfF7YIs52p1lFyi56D8MzNIu3XYu6WeOfazXTeOBAgDj/Y+GFnpRfP/SPo6cuk2qlIrt4ORgzfbrEXtV7oaG+/IFaMiLbd4s4vLy4tCpv8WHWztXW0R3X/H2Y6c0VtmZgTYGpkW0S5L9HLCk93Mi9GGeo6dd9RRF94xG5+/OJmnsN2mVWUEIXccaYHcIZO3JPlrTbjClKMsBx8s9DCdt87EYoWootGiQqv2cSbTonn8hsYL1zHtn99SkZav68cvCLj06Yy6c48OzBBRH+WPchD0zPNVb/FjcFidl0a3vDhRi+0zlps584UeHJla0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovEpaCg56NloN+xo1i3MQxEpKDcYk9rAjhnkQJ+A410=;
 b=a8U3x7hZAkIUMa6+otyUQdwHhmS+dlYrg06VQ7/Hw7aDCIJtxN1B+s1OXO64/r5FrXt4g+33wKZN9VXPckI4NAkX3oMOIB4yVIoRyNshILDlyqIn115jOSZZn6T3DHK9eINbMihw60fhcftgRSjSW/66sRt/4qS/MJCzXfPpnboLs0XtxFbknXvO0iNi3hRMr2+7w2cAZoyJtlnRKIuDnGu3jUUuWmpGpTx6hbaUaZWUmEZZt26tBEHYk18oNlBXWAK+VmJngqQxiG7gsv8nUrjQDjV0trAJ6sqNKebTbWPfJgQPW6aGNzDf//P9154ePK3K4JSHKUephqjoxto5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovEpaCg56NloN+xo1i3MQxEpKDcYk9rAjhnkQJ+A410=;
 b=iTbcdE3bVQHOY6L4iQCCO908lyKzonqbpGlDW24+qI8IbvE3PK/7tKPSAeO9R7pkynHuFSLLS+EvJMU9RMQ0/5fO1PFf3+iwhiO3DepI04SzO7yM8M/bz0dc0Lxm0RomtnRIsPwzQmuwh212Kw0khRI845ydygT8j9HxuWB4M9I=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (20.179.149.217) by
 MN2PR11MB3775.namprd11.prod.outlook.com (20.178.253.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 10:52:36 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 10:52:36 +0000
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
Subject: [PATCH 04/20] staging: wfx: add tracepoints for I/O access
Thread-Topic: [PATCH 04/20] staging: wfx: add tracepoints for I/O access
Thread-Index: AQHVbthZ49yLPBF0BECGn0rUHCl/Yg==
Date:   Thu, 19 Sep 2019 10:52:36 +0000
Message-ID: <20190919105153.15285-5-Jerome.Pouiller@silabs.com>
References: <20190919105153.15285-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20190919105153.15285-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6373457f-43eb-4e8e-c9b1-08d73cef7bc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3775;
x-ms-traffictypediagnostic: MN2PR11MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37756F24CB098AF2CCB484D893890@MN2PR11MB3775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(136003)(396003)(199004)(189003)(86362001)(256004)(14444005)(8936002)(4326008)(66066001)(36756003)(14454004)(305945005)(64756008)(5660300002)(66476007)(66556008)(66446008)(316002)(476003)(446003)(11346002)(110136005)(2616005)(66946007)(478600001)(91956017)(25786009)(76116006)(7736002)(71190400001)(81166006)(1076003)(2501003)(6506007)(186003)(6436002)(486006)(81156014)(3846002)(6116002)(8676002)(102836004)(107886003)(54906003)(76176011)(2906002)(26005)(66574012)(99286004)(6486002)(71200400001)(6512007)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3775;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PRMbmHkTBnAATyGVR1Vv01asvYqHWuL5XmKizUSXB4NKqwaMF2XzWZhiSUpmCu4X8Zi6+8iMRornz2P5/FdQoAFer64JCqVJ8EUdDq/H1mDLNY/fHg9WczBPtftBYR2V4J0y8t7VLMiF7DDt7tHs/v7UYjg8T4UywF4As13MJxd2jAIijn2WuPch4kMxQTSYlHBZy0d17/o8IfoUnvKb95A/msZS2SlziA+uBlgIFm+XKseL98cOSCLxdX16QIsfzo95GiEKy3MGFY1QOodksvwuab7xjNAk+yUxmEdr8LJgGksYV5/wfYbJb5Tj/AoioHdm3XOgUEOZNv75oImjT76/sJ0CU+maDvqlYtRBnweknEO4tSwCPmkktSRBB/8l2sN3X88MbMUaST0i3NR6d5+EllUbuBp2ePq0KDvdVd8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76BBCE3922326346905C126ECD7D4B38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6373457f-43eb-4e8e-c9b1-08d73cef7bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:52:36.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7bwcT6GmNk4iArdSCTlkeC/NhTQ+kXQo+iYPElQPDnucmrbiyiH9M6UT/k2uytWOkiSczrBCOx8FCwp+tYV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3775
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpT
b21lIHRyYWNlcG9pbnRzIGFyZSB1c2VmdWwgZm9yIGRlYnVnZ2luZy4NCg0KU2lnbmVkLW9mZi1i
eTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KLS0tDQog
ZHJpdmVycy9zdGFnaW5nL3dmeC9NYWtlZmlsZSB8ICAgNiArLQ0KIGRyaXZlcnMvc3RhZ2luZy93
ZngvZGVidWcuYyAgfCAgMTAgKysrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmMgICB8ICAx
MSArKysNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3RyYWNlcy5oIHwgMTU0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCAxODAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3N0YWdpbmcvd2Z4
L2RlYnVnLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC90cmFjZXMu
aA0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9NYWtlZmlsZSBiL2RyaXZlcnMv
c3RhZ2luZy93ZngvTWFrZWZpbGUNCmluZGV4IGU4NjA4NDUxODZjZi4uMzMwYjcyODhlYmI1IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9z
dGFnaW5nL3dmeC9NYWtlZmlsZQ0KQEAgLTEsOCArMSwxMiBAQA0KICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCiANCisjIE5lY2Vzc2FyeSBmb3IgQ1JFQVRFX1RSQUNFX1BPSU5U
Uw0KK0NGTEFHU19kZWJ1Zy5vID0gLUkkKHNyYykNCisNCiB3ZngteSA6PSBcDQogCWh3aW8ubyBc
DQotCW1haW4ubw0KKwltYWluLm8gXA0KKwlkZWJ1Zy5vDQogd2Z4LSQoQ09ORklHX1NQSSkgKz0g
YnVzX3NwaS5vDQogd2Z4LSQoc3Vic3QgbSx5LCQoQ09ORklHX01NQykpICs9IGJ1c19zZGlvLm8N
CiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RlYnVnLmMgYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L2RlYnVnLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAw
MDAuLmJmNDRjOTQ0NjQwZA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC9kZWJ1Zy5jDQpAQCAtMCwwICsxLDEwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seQ0KKy8qDQorICogRGVidWdmcyBpbnRlcmZhY2UuDQorICoNCisgKiBDb3B5
cmlnaHQgKGMpIDIwMTctMjAxOSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4NCisgKiBDb3B5
cmlnaHQgKGMpIDIwMTAsIFNULUVyaWNzc29uDQorICovDQorDQorI2RlZmluZSBDUkVBVEVfVFJB
Q0VfUE9JTlRTDQorI2luY2x1ZGUgInRyYWNlcy5oIg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvaHdpby5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9od2lvLmMNCmluZGV4IGZhNjI2
YTQ5ZGQ4YS4uMGNmNTJhZWUxMGU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9o
d2lvLmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvaHdpby5jDQpAQCAtMTIsNiArMTIsNyBA
QA0KICNpbmNsdWRlICJod2lvLmgiDQogI2luY2x1ZGUgIndmeC5oIg0KICNpbmNsdWRlICJidXMu
aCINCisjaW5jbHVkZSAidHJhY2VzLmgiDQogDQogLyoNCiAgKiBJbnRlcm5hbCBoZWxwZXJzLg0K
QEAgLTYzLDYgKzY0LDcgQEAgc3RhdGljIGludCByZWFkMzJfbG9ja2VkKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LCBpbnQgcmVnLCB1MzIgKnZhbCkNCiANCiAJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdk
ZXYtPmh3YnVzX3ByaXYpOw0KIAlyZXQgPSByZWFkMzIod2RldiwgcmVnLCB2YWwpOw0KKwlfdHJh
Y2VfaW9fcmVhZDMyKHJlZywgKnZhbCk7DQogCXdkZXYtPmh3YnVzX29wcy0+dW5sb2NrKHdkZXYt
Pmh3YnVzX3ByaXYpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCkBAIC03Myw2ICs3NSw3IEBAIHN0YXRp
YyBpbnQgd3JpdGUzMl9sb2NrZWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCByZWcsIHUzMiB2
YWwpDQogDQogCXdkZXYtPmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1c19wcml2KTsNCiAJcmV0
ID0gd3JpdGUzMih3ZGV2LCByZWcsIHZhbCk7DQorCV90cmFjZV9pb193cml0ZTMyKHJlZywgdmFs
KTsNCiAJd2Rldi0+aHdidXNfb3BzLT51bmxvY2sod2Rldi0+aHdidXNfcHJpdik7DQogCXJldHVy
biByZXQ7DQogfQ0KQEAgLTg2LDExICs4OSwxMyBAQCBzdGF0aWMgaW50IHdyaXRlMzJfYml0c19s
b2NrZWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCByZWcsIHUzMiBtYXNrLCB1MzIgdmFsKQ0K
IAl2YWwgJj0gbWFzazsNCiAJd2Rldi0+aHdidXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYp
Ow0KIAlyZXQgPSByZWFkMzIod2RldiwgcmVnLCAmdmFsX3IpOw0KKwlfdHJhY2VfaW9fcmVhZDMy
KHJlZywgdmFsX3IpOw0KIAlpZiAocmV0IDwgMCkNCiAJCWdvdG8gZXJyOw0KIAl2YWxfdyA9ICh2
YWxfciAmIH5tYXNrKSB8IHZhbDsNCiAJaWYgKHZhbF93ICE9IHZhbF9yKSB7DQogCQlyZXQgPSB3
cml0ZTMyKHdkZXYsIHJlZywgdmFsX3cpOw0KKwkJX3RyYWNlX2lvX3dyaXRlMzIocmVnLCB2YWxf
dyk7DQogCX0NCiBlcnI6DQogCXdkZXYtPmh3YnVzX29wcy0+dW5sb2NrKHdkZXYtPmh3YnVzX3By
aXYpOw0KQEAgLTE2Niw2ICsxNzEsNyBAQCBzdGF0aWMgaW50IGluZGlyZWN0X3JlYWRfbG9ja2Vk
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIgYWRkciwgdm9pZCAqYg0KIA0KIAl3
ZGV2LT5od2J1c19vcHMtPmxvY2sod2Rldi0+aHdidXNfcHJpdik7DQogCXJldCA9IGluZGlyZWN0
X3JlYWQod2RldiwgcmVnLCBhZGRyLCBidWYsIGxlbik7DQorCV90cmFjZV9pb19pbmRfcmVhZChy
ZWcsIGFkZHIsIGJ1ZiwgbGVuKTsNCiAJd2Rldi0+aHdidXNfb3BzLT51bmxvY2sod2Rldi0+aHdi
dXNfcHJpdik7DQogCXJldHVybiByZXQ7DQogfQ0KQEAgLTE3Niw2ICsxODIsNyBAQCBzdGF0aWMg
aW50IGluZGlyZWN0X3dyaXRlX2xvY2tlZChzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHJlZywg
dTMyIGFkZHIsIGNvbnN0DQogDQogCXdkZXYtPmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1c19w
cml2KTsNCiAJcmV0ID0gaW5kaXJlY3Rfd3JpdGUod2RldiwgcmVnLCBhZGRyLCBidWYsIGxlbik7
DQorCV90cmFjZV9pb19pbmRfd3JpdGUocmVnLCBhZGRyLCBidWYsIGxlbik7DQogCXdkZXYtPmh3
YnVzX29wcy0+dW5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCkBA
IC0xOTAsNiArMTk3LDcgQEAgc3RhdGljIGludCBpbmRpcmVjdF9yZWFkMzJfbG9ja2VkKHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCBpbnQgcmVnLCB1MzIgYWRkciwgdTMyICoNCiAJd2Rldi0+aHdidXNf
b3BzLT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOw0KIAlyZXQgPSBpbmRpcmVjdF9yZWFkKHdkZXYs
IHJlZywgYWRkciwgdG1wLCBzaXplb2YodTMyKSk7DQogCSp2YWwgPSBjcHVfdG9fbGUzMigqdG1w
KTsNCisJX3RyYWNlX2lvX2luZF9yZWFkMzIocmVnLCBhZGRyLCAqdmFsKTsNCiAJd2Rldi0+aHdi
dXNfb3BzLT51bmxvY2sod2Rldi0+aHdidXNfcHJpdik7DQogCWtmcmVlKHRtcCk7DQogCXJldHVy
biByZXQ7DQpAQCAtMjA1LDYgKzIxMyw3IEBAIHN0YXRpYyBpbnQgaW5kaXJlY3Rfd3JpdGUzMl9s
b2NrZWQoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCByZWcsIHUzMiBhZGRyLCB1MzINCiAJKnRt
cCA9IGNwdV90b19sZTMyKHZhbCk7DQogCXdkZXYtPmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1
c19wcml2KTsNCiAJcmV0ID0gaW5kaXJlY3Rfd3JpdGUod2RldiwgcmVnLCBhZGRyLCB0bXAsIHNp
emVvZih1MzIpKTsNCisJX3RyYWNlX2lvX2luZF93cml0ZTMyKHJlZywgYWRkciwgdmFsKTsNCiAJ
d2Rldi0+aHdidXNfb3BzLT51bmxvY2sod2Rldi0+aHdidXNfcHJpdik7DQogCWtmcmVlKHRtcCk7
DQogCXJldHVybiByZXQ7DQpAQCAtMjE3LDYgKzIyNiw3IEBAIGludCB3ZnhfZGF0YV9yZWFkKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2LCB2b2lkICpidWYsIHNpemVfdCBsZW4pDQogCVdBUk4oKGxvbmcp
IGJ1ZiAmIDMsICIlczogdW5hbGlnbmVkIGJ1ZmZlciIsIF9fZnVuY19fKTsNCiAJd2Rldi0+aHdi
dXNfb3BzLT5sb2NrKHdkZXYtPmh3YnVzX3ByaXYpOw0KIAlyZXQgPSB3ZGV2LT5od2J1c19vcHMt
PmNvcHlfZnJvbV9pbyh3ZGV2LT5od2J1c19wcml2LCBXRlhfUkVHX0lOX09VVF9RVUVVRSwgYnVm
LCBsZW4pOw0KKwlfdHJhY2VfaW9fcmVhZChXRlhfUkVHX0lOX09VVF9RVUVVRSwgYnVmLCBsZW4p
Ow0KIAl3ZGV2LT5od2J1c19vcHMtPnVubG9jayh3ZGV2LT5od2J1c19wcml2KTsNCiAJaWYgKHJl
dCkNCiAJCWRldl9lcnIod2Rldi0+ZGV2LCAiJXM6IGJ1cyBjb21tdW5pY2F0aW9uIGVycm9yOiAl
ZFxuIiwgX19mdW5jX18sIHJldCk7DQpAQCAtMjMwLDYgKzI0MCw3IEBAIGludCB3ZnhfZGF0YV93
cml0ZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQ0K
IAlXQVJOKChsb25nKSBidWYgJiAzLCAiJXM6IHVuYWxpZ25lZCBidWZmZXIiLCBfX2Z1bmNfXyk7
DQogCXdkZXYtPmh3YnVzX29wcy0+bG9jayh3ZGV2LT5od2J1c19wcml2KTsNCiAJcmV0ID0gd2Rl
di0+aHdidXNfb3BzLT5jb3B5X3RvX2lvKHdkZXYtPmh3YnVzX3ByaXYsIFdGWF9SRUdfSU5fT1VU
X1FVRVVFLCBidWYsIGxlbik7DQorCV90cmFjZV9pb193cml0ZShXRlhfUkVHX0lOX09VVF9RVUVV
RSwgYnVmLCBsZW4pOw0KIAl3ZGV2LT5od2J1c19vcHMtPnVubG9jayh3ZGV2LT5od2J1c19wcml2
KTsNCiAJaWYgKHJldCkNCiAJCWRldl9lcnIod2Rldi0+ZGV2LCAiJXM6IGJ1cyBjb21tdW5pY2F0
aW9uIGVycm9yOiAlZFxuIiwgX19mdW5jX18sIHJldCk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL3dmeC90cmFjZXMuaCBiL2RyaXZlcnMvc3RhZ2luZy93ZngvdHJhY2VzLmgNCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmJhOTdkZjgyMWYxYg0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC90cmFjZXMuaA0KQEAgLTAsMCArMSwx
NTQgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQorLyoN
CisgKiBUcmFjZXBvaW50cyBkZWZpbml0aW9ucy4NCisgKg0KKyAqIENvcHlyaWdodCAoYykgMjAx
OC0yMDE5LCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLg0KKyAqLw0KKw0KKyN1bmRlZiBUUkFD
RV9TWVNURU0NCisjZGVmaW5lIFRSQUNFX1NZU1RFTSB3ZngNCisNCisjaWYgIWRlZmluZWQoX1dG
WF9UUkFDRV9IKSB8fCBkZWZpbmVkKFRSQUNFX0hFQURFUl9NVUxUSV9SRUFEKQ0KKyNkZWZpbmUg
X1dGWF9UUkFDRV9IDQorDQorI2luY2x1ZGUgPGxpbnV4L3RyYWNlcG9pbnQuaD4NCisjaW5jbHVk
ZSA8bGludXgvdmVyc2lvbi5oPg0KKw0KKyNpbmNsdWRlICJidXMuaCINCisNCisjaWYgKEtFUk5F
TF9WRVJTSU9OKDQsIDEsIDApID4gTElOVVhfVkVSU0lPTl9DT0RFKQ0KKyNkZWZpbmUgVFJBQ0Vf
REVGSU5FX0VOVU0oYSkNCisjZW5kaWYNCisNCisvKiBUaGUgaGVsbCBiZWxvdyBuZWVkIHNvbWUg
ZXhwbGFuYXRpb25zLiBGb3IgZWFjaCBzeW1ib2xpYyBudW1iZXIsIHdlIG5lZWQgdG8NCisgKiBk
ZWZpbmUgaXQgd2l0aCBUUkFDRV9ERUZJTkVfRU5VTSgpIGFuZCBpbiBhIGxpc3QgZm9yIF9fcHJp
bnRfc3ltYm9saWMuDQorICoNCisgKiAgIDEuIERlZmluZSBhIG5ldyBtYWNybyB0aGF0IGNhbGwg
VFJBQ0VfREVGSU5FX0VOVU0oKToNCisgKg0KKyAqICAgICAgICAgICNkZWZpbmUgeHh4X25hbWUo
c3ltKSBUUkFDRV9ERUZJTkVfRU5VTShzeW0pOw0KKyAqDQorICogICAyLiBEZWZpbmUgbGlzdCBv
ZiBhbGwgc3ltYm9sczoNCisgKg0KKyAqICAgICAgICAgICNkZWZpbmUgbGlzdF9uYW1lcyAgICAg
XA0KKyAqICAgICAgICAgICAgIC4uLiAgICAgICAgICAgICAgICAgXA0KKyAqICAgICAgICAgICAg
IHh4eF9uYW1lKFhYWCkgICAgICAgXA0KKyAqICAgICAgICAgICAgIC4uLg0KKyAqDQorICogICAz
LiBJbnN0YW5jaWF0ZSB0aGF0IGxpc3RfbmFtZXM6DQorICoNCisgKiAgICAgICAgICBsaXN0X25h
bWVzDQorICoNCisgKiAgIDQuIFJlZGVmaW5lIHh4eF9uYW1lKCkgYXMgYSBlbnRyeSBvZiBhcnJh
eSBmb3IgX19wcmludF9zeW1ib2xpYygpDQorICoNCisgKiAgICAgICAgICAjdW5kZWYgeHh4X25h
bWUNCisgKiAgICAgICAgICAjZGVmaW5lIHh4eF9uYW1lKG1zZykgeyBtc2csICNtc2cgfSwNCisg
Kg0KKyAqICAgNS4gbGlzdF9uYW1lIGNhbiBub3cgbmVhcmx1IGJlIHVzZWQgd2l0aCBfX3ByaW50
X3N5bWJvbGljKCkgYnV0LA0KKyAqICAgICAgX19wcmludF9zeW1ib2xpYygpIGRpc2xpa2UgbGFz
dCBjb21tYSBvZiBsaXN0LiBTbyB3ZSBkZWZpbmUgYSBuZXcgbGlzdA0KKyAqICAgICAgd2l0aCBh
IGR1bW15IGVsZW1lbnQ6DQorICoNCisgKiAgICAgICAgICAjZGVmaW5lIGxpc3RfZm9yX3ByaW50
X3N5bWJvbGljIGxpc3RfbmFtZXMgeyAtMSwgTlVMTCB9DQorICovDQorDQorI2RlZmluZSB3Znhf
cmVnX2xpc3RfZW51bSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCisJd2Z4X3Jl
Z19uYW1lKFdGWF9SRUdfQ09ORklHLCAgICAgICAiQ09ORklHIikgICAgICBcDQorCXdmeF9yZWdf
bmFtZShXRlhfUkVHX0NPTlRST0wsICAgICAgIkNPTlRST0wiKSAgICAgXA0KKwl3ZnhfcmVnX25h
bWUoV0ZYX1JFR19JTl9PVVRfUVVFVUUsICJRVUVVRSIpICAgICAgIFwNCisJd2Z4X3JlZ19uYW1l
KFdGWF9SRUdfQUhCX0RQT1JULCAgICAiQUhCIikgICAgICAgICBcDQorCXdmeF9yZWdfbmFtZShX
RlhfUkVHX0JBU0VfQUREUiwgICAgIkJBU0VfQUREUiIpICAgXA0KKwl3ZnhfcmVnX25hbWUoV0ZY
X1JFR19TUkFNX0RQT1JULCAgICJTUkFNIikgICAgICAgIFwNCisJd2Z4X3JlZ19uYW1lKFdGWF9S
RUdfU0VUX0dFTl9SX1csICAiU0VUX0dFTl9SX1ciKSBcDQorCXdmeF9yZWdfbmFtZShXRlhfUkVH
X0ZSQU1FX09VVCwgICAgIkZSQU1FX09VVCIpDQorDQorI3VuZGVmIHdmeF9yZWdfbmFtZQ0KKyNk
ZWZpbmUgd2Z4X3JlZ19uYW1lKHN5bSwgbmFtZSkgVFJBQ0VfREVGSU5FX0VOVU0oc3ltKTsNCit3
ZnhfcmVnX2xpc3RfZW51bQ0KKyN1bmRlZiB3ZnhfcmVnX25hbWUNCisjZGVmaW5lIHdmeF9yZWdf
bmFtZShzeW0sIG5hbWUpIHsgc3ltLCBuYW1lIH0sDQorI2RlZmluZSB3ZnhfcmVnX2xpc3Qgd2Z4
X3JlZ19saXN0X2VudW0geyAtMSwgTlVMTCB9DQorDQorREVDTEFSRV9FVkVOVF9DTEFTUyhpb19k
YXRhLA0KKwlUUF9QUk9UTyhpbnQgcmVnLCBpbnQgYWRkciwgY29uc3Qgdm9pZCAqaW9fYnVmLCBz
aXplX3QgbGVuKSwNCisJVFBfQVJHUyhyZWcsIGFkZHIsIGlvX2J1ZiwgbGVuKSwNCisJVFBfU1RS
VUNUX19lbnRyeSgNCisJCV9fZmllbGQoaW50LCByZWcpDQorCQlfX2ZpZWxkKGludCwgYWRkcikN
CisJCV9fZmllbGQoaW50LCBtc2dfbGVuKQ0KKwkJX19maWVsZChpbnQsIGJ1Zl9sZW4pDQorCQlf
X2FycmF5KHU4LCBidWYsIDMyKQ0KKwkJX19hcnJheSh1OCwgYWRkcl9zdHIsIDEwKQ0KKwkpLA0K
KwlUUF9mYXN0X2Fzc2lnbigNCisJCV9fZW50cnktPnJlZyA9IHJlZzsNCisJCV9fZW50cnktPmFk
ZHIgPSBhZGRyOw0KKwkJX19lbnRyeS0+bXNnX2xlbiA9IGxlbjsNCisJCV9fZW50cnktPmJ1Zl9s
ZW4gPSBtaW5fdChpbnQsIHNpemVvZihfX2VudHJ5LT5idWYpLCBfX2VudHJ5LT5tc2dfbGVuKTsN
CisJCW1lbWNweShfX2VudHJ5LT5idWYsIGlvX2J1ZiwgX19lbnRyeS0+YnVmX2xlbik7DQorCQlp
ZiAoYWRkciA+PSAwKQ0KKwkJCXNucHJpbnRmKF9fZW50cnktPmFkZHJfc3RyLCAxMCwgIi8lMDh4
IiwgYWRkcik7DQorCQllbHNlDQorCQkJX19lbnRyeS0+YWRkcl9zdHJbMF0gPSAwOw0KKwkpLA0K
KwlUUF9wcmludGsoIiVzJXM6ICVzJXMgKCVkIGJ5dGVzKSIsDQorCQlfX3ByaW50X3N5bWJvbGlj
KF9fZW50cnktPnJlZywgd2Z4X3JlZ19saXN0KSwNCisJCV9fZW50cnktPmFkZHJfc3RyLA0KKwkJ
X19wcmludF9oZXgoX19lbnRyeS0+YnVmLCBfX2VudHJ5LT5idWZfbGVuKSwNCisJCV9fZW50cnkt
Pm1zZ19sZW4gPiBzaXplb2YoX19lbnRyeS0+YnVmKSA/ICIgLi4uIiA6ICIiLA0KKwkJX19lbnRy
eS0+bXNnX2xlbg0KKwkpDQorKTsNCitERUZJTkVfRVZFTlQoaW9fZGF0YSwgaW9fd3JpdGUsDQor
CVRQX1BST1RPKGludCByZWcsIGludCBhZGRyLCBjb25zdCB2b2lkICppb19idWYsIHNpemVfdCBs
ZW4pLA0KKwlUUF9BUkdTKHJlZywgYWRkciwgaW9fYnVmLCBsZW4pKTsNCisjZGVmaW5lIF90cmFj
ZV9pb19pbmRfd3JpdGUocmVnLCBhZGRyLCBpb19idWYsIGxlbikgdHJhY2VfaW9fd3JpdGUocmVn
LCBhZGRyLCBpb19idWYsIGxlbikNCisjZGVmaW5lIF90cmFjZV9pb193cml0ZShyZWcsIGlvX2J1
ZiwgbGVuKSB0cmFjZV9pb193cml0ZShyZWcsIC0xLCBpb19idWYsIGxlbikNCitERUZJTkVfRVZF
TlQoaW9fZGF0YSwgaW9fcmVhZCwNCisJVFBfUFJPVE8oaW50IHJlZywgaW50IGFkZHIsIGNvbnN0
IHZvaWQgKmlvX2J1Ziwgc2l6ZV90IGxlbiksDQorCVRQX0FSR1MocmVnLCBhZGRyLCBpb19idWYs
IGxlbikpOw0KKyNkZWZpbmUgX3RyYWNlX2lvX2luZF9yZWFkKHJlZywgYWRkciwgaW9fYnVmLCBs
ZW4pIHRyYWNlX2lvX3JlYWQocmVnLCBhZGRyLCBpb19idWYsIGxlbikNCisjZGVmaW5lIF90cmFj
ZV9pb19yZWFkKHJlZywgaW9fYnVmLCBsZW4pIHRyYWNlX2lvX3JlYWQocmVnLCAtMSwgaW9fYnVm
LCBsZW4pDQorDQorREVDTEFSRV9FVkVOVF9DTEFTUyhpb19kYXRhMzIsDQorCVRQX1BST1RPKGlu
dCByZWcsIGludCBhZGRyLCB1MzIgdmFsKSwNCisJVFBfQVJHUyhyZWcsIGFkZHIsIHZhbCksDQor
CVRQX1NUUlVDVF9fZW50cnkoDQorCQlfX2ZpZWxkKGludCwgcmVnKQ0KKwkJX19maWVsZChpbnQs
IGFkZHIpDQorCQlfX2ZpZWxkKGludCwgdmFsKQ0KKwkJX19hcnJheSh1OCwgYWRkcl9zdHIsIDEw
KQ0KKwkpLA0KKwlUUF9mYXN0X2Fzc2lnbigNCisJCV9fZW50cnktPnJlZyA9IHJlZzsNCisJCV9f
ZW50cnktPmFkZHIgPSBhZGRyOw0KKwkJX19lbnRyeS0+dmFsID0gdmFsOw0KKwkJaWYgKGFkZHIg
Pj0gMCkNCisJCQlzbnByaW50ZihfX2VudHJ5LT5hZGRyX3N0ciwgMTAsICIvJTA4eCIsIGFkZHIp
Ow0KKwkJZWxzZQ0KKwkJCV9fZW50cnktPmFkZHJfc3RyWzBdID0gMDsNCisJKSwNCisJVFBfcHJp
bnRrKCIlcyVzOiAlMDh4IiwNCisJCV9fcHJpbnRfc3ltYm9saWMoX19lbnRyeS0+cmVnLCB3Znhf
cmVnX2xpc3QpLA0KKwkJX19lbnRyeS0+YWRkcl9zdHIsDQorCQlfX2VudHJ5LT52YWwNCisJKQ0K
Kyk7DQorREVGSU5FX0VWRU5UKGlvX2RhdGEzMiwgaW9fd3JpdGUzMiwNCisJVFBfUFJPVE8oaW50
IHJlZywgaW50IGFkZHIsIHUzMiB2YWwpLA0KKwlUUF9BUkdTKHJlZywgYWRkciwgdmFsKSk7DQor
I2RlZmluZSBfdHJhY2VfaW9faW5kX3dyaXRlMzIocmVnLCBhZGRyLCB2YWwpIHRyYWNlX2lvX3dy
aXRlMzIocmVnLCBhZGRyLCB2YWwpDQorI2RlZmluZSBfdHJhY2VfaW9fd3JpdGUzMihyZWcsIHZh
bCkgdHJhY2VfaW9fd3JpdGUzMihyZWcsIC0xLCB2YWwpDQorREVGSU5FX0VWRU5UKGlvX2RhdGEz
MiwgaW9fcmVhZDMyLA0KKwlUUF9QUk9UTyhpbnQgcmVnLCBpbnQgYWRkciwgdTMyIHZhbCksDQor
CVRQX0FSR1MocmVnLCBhZGRyLCB2YWwpKTsNCisjZGVmaW5lIF90cmFjZV9pb19pbmRfcmVhZDMy
KHJlZywgYWRkciwgdmFsKSB0cmFjZV9pb19yZWFkMzIocmVnLCBhZGRyLCB2YWwpDQorI2RlZmlu
ZSBfdHJhY2VfaW9fcmVhZDMyKHJlZywgdmFsKSB0cmFjZV9pb19yZWFkMzIocmVnLCAtMSwgdmFs
KQ0KKw0KKyNlbmRpZg0KKw0KKy8qIFRoaXMgcGFydCBtdXN0IGJlIG91dHNpZGUgcHJvdGVjdGlv
biAqLw0KKyN1bmRlZiBUUkFDRV9JTkNMVURFX1BBVEgNCisjZGVmaW5lIFRSQUNFX0lOQ0xVREVf
UEFUSCAuDQorI3VuZGVmIFRSQUNFX0lOQ0xVREVfRklMRQ0KKyNkZWZpbmUgVFJBQ0VfSU5DTFVE
RV9GSUxFIHRyYWNlcw0KKw0KKyNpbmNsdWRlIDx0cmFjZS9kZWZpbmVfdHJhY2UuaD4NCi0tIA0K
Mi4yMC4xDQo=
