Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB35B77F9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbfISKwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 06:52:50 -0400
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:8577
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389414AbfISKwr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 06:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzefjr7D4kkZfkA7VgdqWXW8keLKhKxfqiojcNOReeW0LsAt6VvOm3TWVMd8MGWwCAiQITk/3x0NxMF8aAlOlQCtXrxJ8CuPbrZmMC8sDZmuGDwof22NabwDAfbs7hOe1lHXvoUGa7udHx/gSM6UVs7BxvcpT9kxloWuA2vaL2aFzw/SZ8WlZn4HommzGI3vei1jyDzYNC2tFLMeCbNwNnKpzydtaBC5XxBEjOCvcfi0xEwpTkvAyRBeJhNSdoRix6fnvvRjGQTltaHssoqE4gb2iO5E/IMMzwDGjv6yCITd5OVprjWUwWgBjn5NOyZMtBkk+u9NGFBnTIhjnKobdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OCRFr3dZAaHAsVkOav+lzSBk2+FYFN4Pe6uShfL1sU=;
 b=Up6UEI06T3J2qZPixBmgXmY3zr7sXcK0gC9gKEaqUkZosWcsNC6EEzwH0YVipfb5F4H3Or9KFLheO7C76V85Pe3oRnG39d5X4BRWQN7XKEu8HWdEZkTa/qqUDQ97UbSWimqP7s6Z6/aInKHdsHuy/WsuqSaVBzagT2hKybqGc52FOjzudSQhyQ6iF8+mrw44EHGqaCO9zdXQqQTme7xV4WrMJdVcev3Oyd+CCtDoe9zFNDMzSrnieNCIsA1n1UMHVWNpgrCik5eTwAUKlI3o5LKB6dDqYNq0TZLtc5GV4BOaS1bxb8tcbZ+TUaXF/qiQJ35DU32GzrKKG37UM/C9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OCRFr3dZAaHAsVkOav+lzSBk2+FYFN4Pe6uShfL1sU=;
 b=djJDmeMHeHD2eYkIDfPyLAZ32tie+Foqr0xepoht/MnpykEX9aLgAIR+Q93ytEall1M1Afgbe7yXxBvEFPOUHO05Lj9bfbIRebrvgqb7WcidZWwwW6Go9uGnX+VJGJK3jki1wZwum/cw+eOF+EOzmdNCGm17kgjEsWLpyJXrl4s=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (20.179.149.217) by
 MN2PR11MB3775.namprd11.prod.outlook.com (20.178.253.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 10:52:37 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::45dc:e073:4446:4bf8%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 10:52:37 +0000
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
Subject: [PATCH 05/20] staging: wfx: load firmware
Thread-Topic: [PATCH 05/20] staging: wfx: load firmware
Thread-Index: AQHVbthZcgowo0eqhESpvw29QXecDg==
Date:   Thu, 19 Sep 2019 10:52:36 +0000
Message-ID: <20190919105153.15285-6-Jerome.Pouiller@silabs.com>
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
x-ms-office365-filtering-correlation-id: 36624aae-9522-476d-a0f5-08d73cef7c1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3775;
x-ms-traffictypediagnostic: MN2PR11MB3775:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37759479F5D58E7B97D7BB6993890@MN2PR11MB3775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(136003)(396003)(199004)(189003)(86362001)(256004)(14444005)(8936002)(4326008)(66066001)(36756003)(14454004)(305945005)(64756008)(5660300002)(66476007)(66556008)(66446008)(316002)(476003)(446003)(11346002)(966005)(110136005)(2616005)(66946007)(478600001)(91956017)(25786009)(76116006)(7736002)(71190400001)(81166006)(1076003)(30864003)(2501003)(6506007)(186003)(6436002)(486006)(81156014)(3846002)(6116002)(8676002)(102836004)(107886003)(54906003)(6306002)(76176011)(2906002)(26005)(66574012)(99286004)(6486002)(71200400001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3775;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6yl77AXLzbqTweEbMgD/YJHk81SoC3U+jtU4yphxWLAsVag4biPvHduBH5WUz4xN6nM/mjYaKG5NrBAcPi3Tmgmu1hROW4l0w2pJNaB06oVJpSkJsUg6LRjcmS5gOWjRqgrCztS4DL/TjzHxrrJpDgO9FPEXSN9Ygv9Czg0/NfJVQPUzkEsP7Lr8YsXrNhRpBnIVbBbqJ6NV8jn5TkGzy0Hjg0jgbBPGnbeBo9q52G4g6mKcK+Cdjb4ztr6pfc43Tx2gqI0TFzhbwCPvzvj8aICiGRhXNQdIBLbCAmbXtdFAiz8QonYq3Tq94M31lbfYgrFNbmmYTRBjPlJ/avup7G2dVHIwff0ukvoCYBiFs58iqBC1AXjXvFdZxup9QFMVP8nEMXxnX0udw7O6HK4OMvG4KSXkR0ENZAW+LdbUF50=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB6728E38E3C0949843C6B0399AF029E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36624aae-9522-476d-a0f5-08d73cef7c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:52:36.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnDuiXQDbyeku+44s68RWLJU6gUwMttP0JS0OV/oXiQUqBQsJp0/hB/214WjTotLRwUf9h8P531Nb3xq45TdKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3775
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpB
IGZpcm13YXJlIGlzIG5lY2Vzc2FyeSB0byBydW4gdGhlIGNoaXAuIHdmeF9pbml0X2RldmljZSgp
IGlzIGluIGNoYXJnZQ0Kb2YgbG9hZGluZyBmaXJtd2FyZSBvbiBjaGlwIGFuZCBkb2luZyBsb3cg
bGV2ZWwgaW5pdGlhbGl6YXRpb24uDQoNCkZpcm13YXJlcyBmb3IgV0YyMDAgYXJlIGF2YWlsYWJs
ZSBoZXJlOg0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9TaWxpY29uTGFicy93ZngtZmlybXdhcmUv
DQoNCk5vdGUgdGhhdCBmaXJtd2FyZSBhcmUgZW5jcnlwdGVkLiBEcml2ZXIgY2hlY2tzIHRoYXQg
a2V5IHVzZWQgdG8gZW5jcnlwdA0KZmlybXdhcmUgbWF0Y2ggd2l0aCBrZXkgYnVybmVkIGludG8g
Y2hpcC4NCg0KQ3VycmVudGx5LCAiQzAiIGtleSBpcyB1c2VkIGZvciBwcm9kdWN0aW9uIGNoaXBz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNp
bGFicy5jb20+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L01ha2VmaWxlICAgfCAgIDEgKw0K
IGRyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NkaW8uYyB8ICAgOCArDQogZHJpdmVycy9zdGFnaW5n
L3dmeC9idXNfc3BpLmMgIHwgICA3ICsNCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYyAgICAg
fCAzOTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9zdGFnaW5n
L3dmeC9md2lvLmggICAgIHwgIDE1ICsrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMgICAg
IHwgIDIwICsrDQogZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmggICAgIHwgIDEwICsNCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oICAgICAgfCAgIDIgKw0KIDggZmlsZXMgY2hhbmdlZCwgNDYw
IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9m
d2lvLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL3dmeC9md2lvLmgNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvTWFrZWZpbGUgYi9kcml2ZXJzL3N0YWdp
bmcvd2Z4L01ha2VmaWxlDQppbmRleCAzMzBiNzI4OGViYjUuLmU1NjhkN2E2ZmIwNiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvc3RhZ2lu
Zy93ZngvTWFrZWZpbGUNCkBAIC01LDYgKzUsNyBAQCBDRkxBR1NfZGVidWcubyA9IC1JJChzcmMp
DQogDQogd2Z4LXkgOj0gXA0KIAlod2lvLm8gXA0KKwlmd2lvLm8gXA0KIAltYWluLm8gXA0KIAlk
ZWJ1Zy5vDQogd2Z4LSQoQ09ORklHX1NQSSkgKz0gYnVzX3NwaS5vDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zdGFnaW5nL3dmeC9idXNfc2Rpby5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc2Rp
by5jDQppbmRleCAzNWJjY2E3ZWM1ZGMuLjI1YzU4N2ZlMjE0MSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvc3RhZ2luZy93ZngvYnVzX3NkaW8uYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNf
c2Rpby5jDQpAQCAtMTcsNiArMTcsNyBAQA0KICNpbmNsdWRlICJtYWluLmgiDQogDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGF0YSB3Znhfc2Rpb19wZGF0YSA9IHsNCisJLmZp
bGVfZncgPSAid2ZtX3dmMjAwIiwNCiB9Ow0KIA0KIHN0cnVjdCB3Znhfc2Rpb19wcml2IHsNCkBA
IC0yMDQsOCArMjA1LDE0IEBAIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNkaW9f
ZnVuYyAqZnVuYywNCiAJCWdvdG8gZXJyMjsNCiAJfQ0KIA0KKwlyZXQgPSB3ZnhfcHJvYmUoYnVz
LT5jb3JlKTsNCisJaWYgKHJldCkNCisJCWdvdG8gZXJyMzsNCisNCiAJcmV0dXJuIDA7DQogDQor
ZXJyMzoNCisJd2Z4X2ZyZWVfY29tbW9uKGJ1cy0+Y29yZSk7DQogZXJyMjoNCiAJd2Z4X3NkaW9f
aXJxX3Vuc3Vic2NyaWJlKGJ1cyk7DQogZXJyMToNCkBAIC0yMjAsNiArMjI3LDcgQEAgc3RhdGlj
IHZvaWQgd2Z4X3NkaW9fcmVtb3ZlKHN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMpDQogew0KIAlzdHJ1
Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gc2Rpb19nZXRfZHJ2ZGF0YShmdW5jKTsNCiANCisJd2Z4
X3JlbGVhc2UoYnVzLT5jb3JlKTsNCiAJd2Z4X2ZyZWVfY29tbW9uKGJ1cy0+Y29yZSk7DQogCXdm
eF9zZGlvX2lycV91bnN1YnNjcmliZShidXMpOw0KIAlzZGlvX2NsYWltX2hvc3QoZnVuYyk7DQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMgYi9kcml2ZXJzL3N0YWdp
bmcvd2Z4L2J1c19zcGkuYw0KaW5kZXggYjMxMWZmNzJjZjgwLi5jNDc0OTQ5YTMyZGQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYw0KKysrIGIvZHJpdmVycy9zdGFn
aW5nL3dmeC9idXNfc3BpLmMNCkBAIC0zMCw2ICszMCw4IEBAIE1PRFVMRV9QQVJNX0RFU0MoZ3Bp
b19yZXNldCwgImdwaW8gbnVtYmVyIGZvciByZXNldC4gLTEgZm9yIG5vbmUuIik7DQogI2RlZmlu
ZSBTRVRfUkVBRCAweDgwMDAgICAgICAgICAvKiB1c2FnZTogb3Igb3BlcmF0aW9uICovDQogDQog
c3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGF0YSB3Znhfc3BpX3BkYXRhID0gew0K
KwkuZmlsZV9mdyA9ICJ3Zm1fd2YyMDAiLA0KKwkudXNlX3Jpc2luZ19jbGsgPSB0cnVlLA0KIH07
DQogDQogc3RydWN0IHdmeF9zcGlfcHJpdiB7DQpAQCAtMjc2LDYgKzI3OCwxMCBAQCBzdGF0aWMg
aW50IHdmeF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpDQogCWlmICghYnVzLT5j
b3JlKQ0KIAkJcmV0dXJuIC1FSU87DQogDQorCXJldCA9IHdmeF9wcm9iZShidXMtPmNvcmUpOw0K
KwlpZiAocmV0KQ0KKwkJd2Z4X2ZyZWVfY29tbW9uKGJ1cy0+Y29yZSk7DQorDQogCXJldHVybiBy
ZXQ7DQogfQ0KIA0KQEAgLTI4NCw2ICsyOTAsNyBAQCBzdGF0aWMgaW50IHdmeF9zcGlfZGlzY29u
bmVjdChzdHJ1Y3Qgc3BpX2RldmljZSAqZnVuYykNCiB7DQogCXN0cnVjdCB3Znhfc3BpX3ByaXYg
KmJ1cyA9IHNwaV9nZXRfZHJ2ZGF0YShmdW5jKTsNCiANCisJd2Z4X3JlbGVhc2UoYnVzLT5jb3Jl
KTsNCiAJd2Z4X2ZyZWVfY29tbW9uKGJ1cy0+Y29yZSk7DQogCS8vIEEgZmV3IElSUSB3aWxsIGJl
IHNlbnQgZHVyaW5nIGRldmljZSByZWxlYXNlLiBIb3BlZnVsbHksIG5vIElSUQ0KIAkvLyBzaG91
bGQgaGFwcGVuIGFmdGVyIHdkZXYvd3ZpZiBhcmUgcmVsZWFzZWQuDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zdGFnaW5nL3dmeC9md2lvLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYw0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uODk2M2QwMzUxZWU2DQotLS0g
L2Rldi9udWxsDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYw0KQEAgLTAsMCArMSwz
OTcgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLyoNCisg
KiBGaXJtd2FyZSBsb2FkaW5nLg0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMTksIFNp
bGljb24gTGFib3JhdG9yaWVzLCBJbmMuDQorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmlj
c3Nvbg0KKyAqLw0KKyNpbmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+DQorI2luY2x1ZGUgPGxpbnV4
L2Zpcm13YXJlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCisjaW5jbHVkZSA8bGludXgv
bW0uaD4NCisNCisjaW5jbHVkZSAiZndpby5oIg0KKyNpbmNsdWRlICJ3ZnguaCINCisjaW5jbHVk
ZSAiaHdpby5oIg0KKw0KKyNpZiAoS0VSTkVMX1ZFUlNJT04oNCwgOSwgMCkgPiBMSU5VWF9WRVJT
SU9OX0NPREUpDQorI2RlZmluZSBGSUVMRF9HRVQoX21hc2ssIF9yZWcpICh0eXBlb2YoX21hc2sp
KSgoKF9yZWcpICYgKF9tYXNrKSkgPj4gKF9fYnVpbHRpbl9mZnNsbChfbWFzaykgLSAxKSkNCisj
ZWxzZQ0KKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KKyNlbmRpZg0KKw0KKy8vIEFkZHJl
c3NlcyBiZWxvdyBhcmUgaW4gU1JBTSBhcmVhDQorI2RlZmluZSBXRlhfRE5MRF9GSUZPICAgICAg
ICAgICAgIDB4MDkwMDQwMDANCisjZGVmaW5lICAgICBETkxEX0JMT0NLX1NJWkUgICAgICAgICAg
IDB4MDQwMA0KKyNkZWZpbmUgICAgIEROTERfRklGT19TSVpFICAgICAgICAgICAgMHg4MDAwIC8v
ICgzMiAqIEROTERfQkxPQ0tfU0laRSkNCisvLyBEb3dubG9hZCBDb250cm9sIEFyZWEgKERDQSkN
CisjZGVmaW5lIFdGWF9EQ0FfSU1BR0VfU0laRSAgICAgICAgMHgwOTAwQzAwMA0KKyNkZWZpbmUg
V0ZYX0RDQV9QVVQgICAgICAgICAgICAgICAweDA5MDBDMDA0DQorI2RlZmluZSBXRlhfRENBX0dF
VCAgICAgICAgICAgICAgIDB4MDkwMEMwMDgNCisjZGVmaW5lIFdGWF9EQ0FfSE9TVF9TVEFUVVMg
ICAgICAgMHgwOTAwQzAwQw0KKyNkZWZpbmUgICAgIEhPU1RfUkVBRFkgICAgICAgICAgICAgICAg
MHg4NzY1NDMyMQ0KKyNkZWZpbmUgICAgIEhPU1RfSU5GT19SRUFEICAgICAgICAgICAgMHhBNzUz
QkQ5OQ0KKyNkZWZpbmUgICAgIEhPU1RfVVBMT0FEX1BFTkRJTkcgICAgICAgMHhBQkNERENCQQ0K
KyNkZWZpbmUgICAgIEhPU1RfVVBMT0FEX0NPTVBMRVRFICAgICAgMHhENEM2NEE5OQ0KKyNkZWZp
bmUgICAgIEhPU1RfT0tfVE9fSlVNUCAgICAgICAgICAgMHgxNzRGQzg4Mg0KKyNkZWZpbmUgV0ZY
X0RDQV9OQ1BfU1RBVFVTICAgICAgICAweDA5MDBDMDEwDQorI2RlZmluZSAgICAgTkNQX05PVF9S
RUFEWSAgICAgICAgICAgICAweDEyMzQ1Njc4DQorI2RlZmluZSAgICAgTkNQX1JFQURZICAgICAg
ICAgICAgICAgICAweDg3NjU0MzIxDQorI2RlZmluZSAgICAgTkNQX0lORk9fUkVBRFkgICAgICAg
ICAgICAweEJENTNFRjk5DQorI2RlZmluZSAgICAgTkNQX0RPV05MT0FEX1BFTkRJTkcgICAgICAw
eEFCQ0REQ0JBDQorI2RlZmluZSAgICAgTkNQX0RPV05MT0FEX0NPTVBMRVRFICAgICAweENBRkVG
RUNBDQorI2RlZmluZSAgICAgTkNQX0FVVEhfT0sgICAgICAgICAgICAgICAweEQ0QzY0QTk5DQor
I2RlZmluZSAgICAgTkNQX0FVVEhfRkFJTCAgICAgICAgICAgICAweDE3NEZDODgyDQorI2RlZmlu
ZSAgICAgTkNQX1BVQl9LRVlfUkRZICAgICAgICAgICAweDdBQjQxRDE5DQorI2RlZmluZSBXRlhf
RENBX0ZXX1NJR05BVFVSRSAgICAgIDB4MDkwMEMwMTQNCisjZGVmaW5lICAgICBGV19TSUdOQVRV
UkVfU0laRSAgICAgICAgIDB4NDANCisjZGVmaW5lIFdGWF9EQ0FfRldfSEFTSCAgICAgICAgICAg
MHgwOTAwQzA1NA0KKyNkZWZpbmUgICAgIEZXX0hBU0hfU0laRSAgICAgICAgICAgICAgMHgwOA0K
KyNkZWZpbmUgV0ZYX0RDQV9GV19WRVJTSU9OICAgICAgICAweDA5MDBDMDVDDQorI2RlZmluZSAg
ICAgRldfVkVSU0lPTl9TSVpFICAgICAgICAgICAweDA0DQorI2RlZmluZSBXRlhfRENBX1JFU0VS
VkVEICAgICAgICAgIDB4MDkwMEMwNjANCisjZGVmaW5lICAgICBEQ0FfUkVTRVJWRURfU0laRSAg
ICAgICAgIDB4MjANCisjZGVmaW5lIFdGWF9TVEFUVVNfSU5GTyAgICAgICAgICAgMHgwOTAwQzA4
MA0KKyNkZWZpbmUgV0ZYX0JPT1RMT0FERVJfTEFCRUwgICAgICAweDA5MDBDMDg0DQorI2RlZmlu
ZSAgICAgQk9PVExPQURFUl9MQUJFTF9TSVpFICAgICAweDNDDQorI2RlZmluZSBXRlhfUFRFX0lO
Rk8gICAgICAgICAgICAgIDB4MDkwMEMwQzANCisjZGVmaW5lICAgICBQVEVfSU5GT19LRVlTRVRf
SURYICAgICAgIDB4MEQNCisjZGVmaW5lICAgICBQVEVfSU5GT19TSVpFICAgICAgICAgICAgIDB4
MTANCisjZGVmaW5lIFdGWF9FUlJfSU5GTyAgICAgICAgICAgICAgMHgwOTAwQzBEMA0KKyNkZWZp
bmUgICAgIEVSUl9JTlZBTElEX1NFQ19UWVBFICAgICAgMHgwNQ0KKyNkZWZpbmUgICAgIEVSUl9T
SUdfVkVSSUZfRkFJTEVEICAgICAgMHgwRg0KKyNkZWZpbmUgICAgIEVSUl9BRVNfQ1RSTF9LRVkg
ICAgICAgICAgMHgxMA0KKyNkZWZpbmUgICAgIEVSUl9FQ0NfUFVCX0tFWSAgICAgICAgICAgMHgx
MQ0KKyNkZWZpbmUgICAgIEVSUl9NQUNfS0VZICAgICAgICAgICAgICAgMHgxOA0KKw0KKyNkZWZp
bmUgRENBX1RJTUVPVVQgIDUwIC8vIG1pbGxpc2Vjb25kcw0KKyNkZWZpbmUgV0FLRVVQX1RJTUVP
VVQgMjAwIC8vIG1pbGxpc2Vjb25kcw0KKw0KK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZndp
b19lcnJvcl9zdHJpbmdzW10gPSB7DQorCVtFUlJfSU5WQUxJRF9TRUNfVFlQRV0gPSAiSW52YWxp
ZCBzZWN0aW9uIHR5cGUgb3Igd3JvbmcgZW5jcnlwdGlvbiIsDQorCVtFUlJfU0lHX1ZFUklGX0ZB
SUxFRF0gPSAiU2lnbmF0dXJlIHZlcmlmaWNhdGlvbiBmYWlsZWQiLA0KKwlbRVJSX0FFU19DVFJM
X0tFWV0gPSAiQUVTIGNvbnRyb2wga2V5IG5vdCBpbml0aWFsaXplZCIsDQorCVtFUlJfRUNDX1BV
Ql9LRVldID0gIkVDQyBwdWJsaWMga2V5IG5vdCBpbml0aWFsaXplZCIsDQorCVtFUlJfTUFDX0tF
WV0gPSAiTUFDIGtleSBub3QgaW5pdGlhbGl6ZWQiLA0KK307DQorDQorLyoNCisgKiByZXF1ZXN0
X2Zpcm13YXJlKCkgYWxsb2NhdGUgZGF0YSB1c2luZyB2bWFsbG9jKCkuIEl0IGlzIG5vdCBjb21w
YXRpYmxlIHdpdGgNCisgKiB1bmRlcmx5aW5nIGhhcmR3YXJlIHRoYXQgdXNlIERNQS4gRnVuY3Rp
b24gYmVsb3cgZGV0ZWN0IHRoaXMgY2FzZSBhbmQNCisgKiBhbGxvY2F0ZSBhIGJvdW5jZSBidWZm
ZXIgaWYgbmVjZXNzYXJ5Lg0KKyAqDQorICogTm90aWNlIHRoYXQsIGluIGRvdWJ0LCB5b3UgY2Fu
IGVuYWJsZSBDT05GSUdfREVCVUdfU0cgdG8gYXNrIGtlcm5lbCB0bw0KKyAqIGRldGVjdCB0aGlz
IHByb2JsZW0gYXQgcnVudGltZSAgKGVsc2UsIGtlcm5lbCBzaWxlbnRseSBmYWlsKS4NCisgKg0K
KyAqIE5PVEU6IGl0IG1heSBhbHNvIGJlIHBvc3NpYmxlIHRvIHVzZSAncGFnZXMnIGZyb20gc3Ry
dWN0IGZpcm13YXJlIGFuZCBhdm9pZA0KKyAqIGJvdW5jZSBidWZmZXINCisgKi8NCitpbnQgc3Jh
bV93cml0ZV9kbWFfc2FmZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMyIGFkZHIsIGNvbnN0IHU4
ICpidWYsIHNpemVfdCBsZW4pDQorew0KKwlpbnQgcmV0Ow0KKwljb25zdCB1OCAqdG1wOw0KKw0K
KwlpZiAoIXZpcnRfYWRkcl92YWxpZChidWYpKSB7DQorCQl0bXAgPSBrbWVtZHVwKGJ1ZiwgbGVu
LCBHRlBfS0VSTkVMKTsNCisJCWlmICghdG1wKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KKwl9IGVs
c2Ugew0KKwkJdG1wID0gYnVmOw0KKwl9DQorCXJldCA9IHNyYW1fYnVmX3dyaXRlKHdkZXYsIGFk
ZHIsIHRtcCwgbGVuKTsNCisJaWYgKCF2aXJ0X2FkZHJfdmFsaWQoYnVmKSkNCisJCWtmcmVlKHRt
cCk7DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK2ludCBnZXRfZmlybXdhcmUoc3RydWN0IHdmeF9k
ZXYgKndkZXYsIHUzMiBrZXlzZXRfY2hpcCwNCisJCSBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKipm
dywgaW50ICpmaWxlX29mZnNldCkNCit7DQorCWludCBrZXlzZXRfZmlsZTsNCisJY2hhciBmaWxl
bmFtZVsyNTZdOw0KKwljb25zdCBjaGFyICpkYXRhOw0KKwlpbnQgcmV0Ow0KKw0KKwlzbnByaW50
ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzXyUwMlguc2VjIiwgd2Rldi0+cGRhdGEu
ZmlsZV9mdywga2V5c2V0X2NoaXApOw0KKyNpZiAoS0VSTkVMX1ZFUlNJT04oNCwgMTgsIDApID4g
TElOVVhfVkVSU0lPTl9DT0RFKQ0KKwlyZXQgPSByZXF1ZXN0X2Zpcm13YXJlKGZ3LCBmaWxlbmFt
ZSwgd2Rldi0+ZGV2KTsNCisjZWxzZQ0KKwlyZXQgPSBmaXJtd2FyZV9yZXF1ZXN0X25vd2Fybihm
dywgZmlsZW5hbWUsIHdkZXYtPmRldik7DQorI2VuZGlmDQorCWlmIChyZXQpIHsNCisJCWRldl9p
bmZvKHdkZXYtPmRldiwgImNhbid0IGxvYWQgJXMsIGZhbGxpbmcgYmFjayB0byAlcy5zZWNcbiIs
IGZpbGVuYW1lLCB3ZGV2LT5wZGF0YS5maWxlX2Z3KTsNCisJCXNucHJpbnRmKGZpbGVuYW1lLCBz
aXplb2YoZmlsZW5hbWUpLCAiJXMuc2VjIiwgd2Rldi0+cGRhdGEuZmlsZV9mdyk7DQorCQlyZXQg
PSByZXF1ZXN0X2Zpcm13YXJlKGZ3LCBmaWxlbmFtZSwgd2Rldi0+ZGV2KTsNCisJCWlmIChyZXQp
IHsNCisJCQlkZXZfZXJyKHdkZXYtPmRldiwgImNhbid0IGxvYWQgJXNcbiIsIGZpbGVuYW1lKTsN
CisJCQkqZncgPSBOVUxMOw0KKwkJCXJldHVybiByZXQ7DQorCQl9DQorCX0NCisNCisJZGF0YSA9
ICgqZncpLT5kYXRhOw0KKwlpZiAobWVtY21wKGRhdGEsICJLRVlTRVQiLCA2KSAhPSAwKSB7DQor
CQkvLyBMZWdhY3kgZmlybXdhcmUgZm9ybWF0DQorCQkqZmlsZV9vZmZzZXQgPSAwOw0KKwkJa2V5
c2V0X2ZpbGUgPSAweDkwOw0KKwl9IGVsc2Ugew0KKwkJKmZpbGVfb2Zmc2V0ID0gODsNCisJCWtl
eXNldF9maWxlID0gKGhleF90b19iaW4oZGF0YVs2XSkgKiAxNikgfCBoZXhfdG9fYmluKGRhdGFb
N10pOw0KKwkJaWYgKGtleXNldF9maWxlIDwgMCkgew0KKwkJCWRldl9lcnIod2Rldi0+ZGV2LCAi
JXMgY29ycnVwdGVkXG4iLCBmaWxlbmFtZSk7DQorCQkJcmVsZWFzZV9maXJtd2FyZSgqZncpOw0K
KwkJCSpmdyA9IE5VTEw7DQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCQl9DQorCX0NCisJaWYgKGtl
eXNldF9maWxlICE9IGtleXNldF9jaGlwKSB7DQorCQlkZXZfZXJyKHdkZXYtPmRldiwgImZpcm13
YXJlIGtleXNldCBpcyBpbmNvbXBhdGlibGUgd2l0aCBjaGlwIChmaWxlOiAweCUwMlgsIGNoaXA6
IDB4JTAyWClcbiIsDQorCQkJa2V5c2V0X2ZpbGUsIGtleXNldF9jaGlwKTsNCisJCXJlbGVhc2Vf
ZmlybXdhcmUoKmZ3KTsNCisJCSpmdyA9IE5VTEw7DQorCQlyZXR1cm4gLUVOT0RFVjsNCisJfQ0K
Kwl3ZGV2LT5rZXlzZXQgPSBrZXlzZXRfZmlsZTsNCisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRp
YyBpbnQgd2FpdF9uY3Bfc3RhdHVzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCB1MzIgc3RhdHVzKQ0K
K3sNCisJa3RpbWVfdCBub3csIHN0YXJ0Ow0KKwl1MzIgcmVnOw0KKwlpbnQgcmV0Ow0KKw0KKwlz
dGFydCA9IGt0aW1lX2dldCgpOw0KKwlmb3IgKDs7KSB7DQorCQlyZXQgPSBzcmFtX3JlZ19yZWFk
KHdkZXYsIFdGWF9EQ0FfTkNQX1NUQVRVUywgJnJlZyk7DQorCQlpZiAocmV0IDwgMCkNCisJCQly
ZXR1cm4gLUVJTzsNCisJCW5vdyA9IGt0aW1lX2dldCgpOw0KKwkJaWYgKHJlZyA9PSBzdGF0dXMp
DQorCQkJYnJlYWs7DQorCQlpZiAoa3RpbWVfYWZ0ZXIobm93LCBrdGltZV9hZGRfbXMoc3RhcnQs
IERDQV9USU1FT1VUKSkpDQorCQkJcmV0dXJuIC1FVElNRURPVVQ7DQorCX0NCisJaWYgKGt0aW1l
X2NvbXBhcmUobm93LCBzdGFydCkpDQorCQlkZXZfZGJnKHdkZXYtPmRldiwgImNoaXAgYW5zd2Vy
IGFmdGVyICVsbGR1c1xuIiwga3RpbWVfdXNfZGVsdGEobm93LCBzdGFydCkpOw0KKwllbHNlDQor
CQlkZXZfZGJnKHdkZXYtPmRldiwgImNoaXAgYW5zd2VyIGltbWVkaWF0ZWx5XG4iKTsNCisJcmV0
dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgdXBsb2FkX2Zpcm13YXJlKHN0cnVjdCB3ZnhfZGV2
ICp3ZGV2LCBjb25zdCB1OCAqZGF0YSwgc2l6ZV90IGxlbikNCit7DQorCWludCByZXQ7DQorCXUz
MiBvZmZzLCBieXRlc19kb25lOw0KKwlrdGltZV90IG5vdywgc3RhcnQ7DQorDQorCWlmIChsZW4g
JSBETkxEX0JMT0NLX1NJWkUpIHsNCisJCWRldl9lcnIod2Rldi0+ZGV2LCAiZmlybXdhcmUgc2l6
ZSBpcyBub3QgYWxpZ25lZC4gQnVmZmVyIG92ZXJydW4gd2lsbCBvY2N1clxuIik7DQorCQlyZXR1
cm4gLUVJTzsNCisJfQ0KKwlvZmZzID0gMDsNCisJd2hpbGUgKG9mZnMgPCBsZW4pIHsNCisJCXN0
YXJ0ID0ga3RpbWVfZ2V0KCk7DQorCQlmb3IgKDs7KSB7DQorCQkJcmV0ID0gc3JhbV9yZWdfcmVh
ZCh3ZGV2LCBXRlhfRENBX0dFVCwgJmJ5dGVzX2RvbmUpOw0KKwkJCWlmIChyZXQgPCAwKQ0KKwkJ
CQlyZXR1cm4gcmV0Ow0KKwkJCW5vdyA9IGt0aW1lX2dldCgpOw0KKwkJCWlmIChvZmZzICsgRE5M
RF9CTE9DS19TSVpFIC0gYnl0ZXNfZG9uZSA8IEROTERfRklGT19TSVpFKQ0KKwkJCQlicmVhazsN
CisJCQlpZiAoa3RpbWVfYWZ0ZXIobm93LCBrdGltZV9hZGRfbXMoc3RhcnQsIERDQV9USU1FT1VU
KSkpDQorCQkJCXJldHVybiAtRVRJTUVET1VUOw0KKwkJfQ0KKwkJaWYgKGt0aW1lX2NvbXBhcmUo
bm93LCBzdGFydCkpDQorCQkJZGV2X2RiZyh3ZGV2LT5kZXYsICJhbnN3ZXIgYWZ0ZXIgJWxsZHVz
XG4iLCBrdGltZV91c19kZWx0YShub3csIHN0YXJ0KSk7DQorDQorCQlyZXQgPSBzcmFtX3dyaXRl
X2RtYV9zYWZlKHdkZXYsIFdGWF9ETkxEX0ZJRk8gKyAob2ZmcyAlIEROTERfRklGT19TSVpFKSwN
CisJCQkJCSAgZGF0YSArIG9mZnMsIEROTERfQkxPQ0tfU0laRSk7DQorCQlpZiAocmV0IDwgMCkN
CisJCQlyZXR1cm4gcmV0Ow0KKw0KKwkJLy8gV0Z4IHNlZW1zIHRvIG5vdCBzdXBwb3J0IHdyaXRp
bmcgMCBpbiB0aGlzIHJlZ2lzdGVyIGR1cmluZw0KKwkJLy8gZmlyc3QgbG9vcA0KKwkJb2ZmcyAr
PSBETkxEX0JMT0NLX1NJWkU7DQorCQlyZXQgPSBzcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENB
X1BVVCwgb2Zmcyk7DQorCQlpZiAocmV0IDwgMCkNCisJCQlyZXR1cm4gcmV0Ow0KKwl9DQorCXJl
dHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCBwcmludF9ib290X3N0YXR1cyhzdHJ1Y3Qgd2Z4
X2RldiAqd2RldikNCit7DQorCXUzMiB2YWwzMjsNCisNCisJc3JhbV9yZWdfcmVhZCh3ZGV2LCBX
RlhfU1RBVFVTX0lORk8sICZ2YWwzMik7DQorCWlmICh2YWwzMiA9PSAweDEyMzQ1Njc4KSB7DQor
CQlkZXZfaW5mbyh3ZGV2LT5kZXYsICJubyBlcnJvciByZXBvcnRlZCBieSBzZWN1cmUgYm9vdFxu
Iik7DQorCX0gZWxzZSB7DQorCQlzcmFtX3JlZ19yZWFkKHdkZXYsIFdGWF9FUlJfSU5GTywgJnZh
bDMyKTsNCisJCWlmICh2YWwzMiA8IEFSUkFZX1NJWkUoZndpb19lcnJvcl9zdHJpbmdzKSAmJiBm
d2lvX2Vycm9yX3N0cmluZ3NbdmFsMzJdKQ0KKwkJCWRldl9pbmZvKHdkZXYtPmRldiwgInNlY3Vy
ZSBib290IGVycm9yOiAlc1xuIiwgZndpb19lcnJvcl9zdHJpbmdzW3ZhbDMyXSk7DQorCQllbHNl
DQorCQkJZGV2X2luZm8od2Rldi0+ZGV2LCAic2VjdXJlIGJvb3QgZXJyb3I6IFVua25vd24gKDB4
JTAyeClcbiIsIHZhbDMyKTsNCisJfQ0KK30NCisNCitpbnQgbG9hZF9maXJtd2FyZV9zZWN1cmUo
c3RydWN0IHdmeF9kZXYgKndkZXYpDQorew0KKwljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3ID0g
TlVMTDsNCisJaW50IGhlYWRlcl9zaXplOw0KKwlpbnQgZndfb2Zmc2V0Ow0KKwlrdGltZV90IHN0
YXJ0Ow0KKwl1OCAqYnVmOw0KKwlpbnQgcmV0Ow0KKw0KKwlCVUlMRF9CVUdfT04oUFRFX0lORk9f
U0laRSA+IEJPT1RMT0FERVJfTEFCRUxfU0laRSk7DQorCWJ1ZiA9IGttYWxsb2MoQk9PVExPQURF
Ul9MQUJFTF9TSVpFICsgMSwgR0ZQX0tFUk5FTCk7DQorCWlmICghYnVmKQ0KKwkJcmV0dXJuIC1F
Tk9NRU07DQorDQorCXNyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9TVF9TVEFUVVMsIEhP
U1RfUkVBRFkpOw0KKwlyZXQgPSB3YWl0X25jcF9zdGF0dXMod2RldiwgTkNQX0lORk9fUkVBRFkp
Ow0KKwlpZiAocmV0KQ0KKwkJZ290byBlcnJvcjsNCisNCisJc3JhbV9idWZfcmVhZCh3ZGV2LCBX
RlhfQk9PVExPQURFUl9MQUJFTCwgYnVmLCBCT09UTE9BREVSX0xBQkVMX1NJWkUpOw0KKwlidWZb
Qk9PVExPQURFUl9MQUJFTF9TSVpFXSA9IDA7DQorCWRldl9kYmcod2Rldi0+ZGV2LCAiYm9vdGxv
YWRlcjogXCIlc1wiXG4iLCBidWYpOw0KKw0KKwlzcmFtX2J1Zl9yZWFkKHdkZXYsIFdGWF9QVEVf
SU5GTywgYnVmLCBQVEVfSU5GT19TSVpFKTsNCisJcmV0ID0gZ2V0X2Zpcm13YXJlKHdkZXYsIGJ1
ZltQVEVfSU5GT19LRVlTRVRfSURYXSwgJmZ3LCAmZndfb2Zmc2V0KTsNCisJaWYgKHJldCkNCisJ
CWdvdG8gZXJyb3I7DQorCWhlYWRlcl9zaXplID0gZndfb2Zmc2V0ICsgRldfU0lHTkFUVVJFX1NJ
WkUgKyBGV19IQVNIX1NJWkU7DQorDQorCXNyYW1fcmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9T
VF9TVEFUVVMsIEhPU1RfSU5GT19SRUFEKTsNCisJcmV0ID0gd2FpdF9uY3Bfc3RhdHVzKHdkZXYs
IE5DUF9SRUFEWSk7DQorCWlmIChyZXQpDQorCQlnb3RvIGVycm9yOw0KKw0KKwlzcmFtX3JlZ193
cml0ZSh3ZGV2LCBXRlhfRE5MRF9GSUZPLCAweEZGRkZGRkZGKTsgLy8gRmlmbyBpbml0DQorCXNy
YW1fd3JpdGVfZG1hX3NhZmUod2RldiwgV0ZYX0RDQV9GV19WRVJTSU9OLCAiXHgwMVx4MDBceDAw
XHgwMCIsIEZXX1ZFUlNJT05fU0laRSk7DQorCXNyYW1fd3JpdGVfZG1hX3NhZmUod2RldiwgV0ZY
X0RDQV9GV19TSUdOQVRVUkUsIGZ3LT5kYXRhICsgZndfb2Zmc2V0LCBGV19TSUdOQVRVUkVfU0la
RSk7DQorCXNyYW1fd3JpdGVfZG1hX3NhZmUod2RldiwgV0ZYX0RDQV9GV19IQVNILCBmdy0+ZGF0
YSArIGZ3X29mZnNldCArIEZXX1NJR05BVFVSRV9TSVpFLCBGV19IQVNIX1NJWkUpOw0KKwlzcmFt
X3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0lNQUdFX1NJWkUsIGZ3LT5zaXplIC0gaGVhZGVyX3Np
emUpOw0KKwlzcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENBX0hPU1RfU1RBVFVTLCBIT1NUX1VQ
TE9BRF9QRU5ESU5HKTsNCisJcmV0ID0gd2FpdF9uY3Bfc3RhdHVzKHdkZXYsIE5DUF9ET1dOTE9B
RF9QRU5ESU5HKTsNCisJaWYgKHJldCkNCisJCWdvdG8gZXJyb3I7DQorDQorCXN0YXJ0ID0ga3Rp
bWVfZ2V0KCk7DQorCXJldCA9IHVwbG9hZF9maXJtd2FyZSh3ZGV2LCBmdy0+ZGF0YSArIGhlYWRl
cl9zaXplLCBmdy0+c2l6ZSAtIGhlYWRlcl9zaXplKTsNCisJaWYgKHJldCkNCisJCWdvdG8gZXJy
b3I7DQorCWRldl9kYmcod2Rldi0+ZGV2LCAiZmlybXdhcmUgbG9hZCBhZnRlciAlbGxkdXNcbiIs
IGt0aW1lX3VzX2RlbHRhKGt0aW1lX2dldCgpLCBzdGFydCkpOw0KKw0KKwlzcmFtX3JlZ193cml0
ZSh3ZGV2LCBXRlhfRENBX0hPU1RfU1RBVFVTLCBIT1NUX1VQTE9BRF9DT01QTEVURSk7DQorCXJl
dCA9IHdhaXRfbmNwX3N0YXR1cyh3ZGV2LCBOQ1BfQVVUSF9PSyk7DQorCS8vIExlZ2FjeSBST00g
c3VwcG9ydA0KKwlpZiAocmV0IDwgMCkNCisJCXJldCA9IHdhaXRfbmNwX3N0YXR1cyh3ZGV2LCBO
Q1BfUFVCX0tFWV9SRFkpOw0KKwlpZiAocmV0IDwgMCkNCisJCWdvdG8gZXJyb3I7DQorCXNyYW1f
cmVnX3dyaXRlKHdkZXYsIFdGWF9EQ0FfSE9TVF9TVEFUVVMsIEhPU1RfT0tfVE9fSlVNUCk7DQor
DQorZXJyb3I6DQorCWtmcmVlKGJ1Zik7DQorCWlmIChmdykNCisJCXJlbGVhc2VfZmlybXdhcmUo
ZncpOw0KKwlpZiAocmV0KQ0KKwkJcHJpbnRfYm9vdF9zdGF0dXMod2Rldik7DQorCXJldHVybiBy
ZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgaW5pdF9ncHIoc3RydWN0IHdmeF9kZXYgKndkZXYpDQor
ew0KKwlpbnQgcmV0LCBpOw0KKwlzdGF0aWMgY29uc3Qgc3RydWN0IHsNCisJCWludCBpbmRleDsN
CisJCXUzMiB2YWx1ZTsNCisJfSBncHJfaW5pdFtdID0gew0KKwkJeyAweDA3LCAweDIwODc3NSB9
LA0KKwkJeyAweDA4LCAweDJFQzAyMCB9LA0KKwkJeyAweDA5LCAweDNDM0MzQyB9LA0KKwkJeyAw
eDBCLCAweDMyMkM0NCB9LA0KKwkJeyAweDBDLCAweEEwNjQ5NyB9LA0KKwl9Ow0KKw0KKwlmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShncHJfaW5pdCk7IGkrKykgew0KKwkJcmV0ID0gaWdwcl9y
ZWdfd3JpdGUod2RldiwgZ3ByX2luaXRbaV0uaW5kZXgsIGdwcl9pbml0W2ldLnZhbHVlKTsNCisJ
CWlmIChyZXQgPCAwKQ0KKwkJCXJldHVybiByZXQ7DQorCQlkZXZfZGJnKHdkZXYtPmRldiwgIiAg
aW5kZXggJTAyeDogJTA4eFxuIiwgZ3ByX2luaXRbaV0uaW5kZXgsIGdwcl9pbml0W2ldLnZhbHVl
KTsNCisJfQ0KKwlyZXR1cm4gMDsNCit9DQorDQoraW50IHdmeF9pbml0X2RldmljZShzdHJ1Y3Qg
d2Z4X2RldiAqd2RldikNCit7DQorCWludCByZXQ7DQorCWludCBod19yZXZpc2lvbiwgaHdfdHlw
ZTsNCisJaW50IHdha2V1cF90aW1lb3V0ID0gNTA7IC8vIG1zDQorCWt0aW1lX3Qgbm93LCBzdGFy
dDsNCisJdTMyIHJlZzsNCisNCisJcmVnID0gQ0ZHX0RJUkVDVF9BQ0NFU1NfTU9ERSB8IENGR19D
UFVfUkVTRVQgfCBDRkdfV09SRF9NT0RFMjsNCisJaWYgKHdkZXYtPnBkYXRhLnVzZV9yaXNpbmdf
Y2xrKQ0KKwkJcmVnIHw9IENGR19DTEtfUklTRV9FREdFOw0KKwlyZXQgPSBjb25maWdfcmVnX3dy
aXRlKHdkZXYsIHJlZyk7DQorCWlmIChyZXQgPCAwKSB7DQorCQlkZXZfZXJyKHdkZXYtPmRldiwg
ImJ1cyByZXR1cm5lZCBhbiBlcnJvciBkdXJpbmcgZmlyc3Qgd3JpdGUgYWNjZXNzLiBIb3N0IGNv
bmZpZ3VyYXRpb24gZXJyb3I/XG4iKTsNCisJCXJldHVybiAtRUlPOw0KKwl9DQorDQorCXJldCA9
IGNvbmZpZ19yZWdfcmVhZCh3ZGV2LCAmcmVnKTsNCisJaWYgKHJldCA8IDApIHsNCisJCWRldl9l
cnIod2Rldi0+ZGV2LCAiYnVzIHJldHVybmVkIGFuIGVycm9yIGR1cmluZyBmaXJzdCByZWFkIGFj
Y2Vzcy4gQnVzIGNvbmZpZ3VyYXRpb24gZXJyb3I/XG4iKTsNCisJCXJldHVybiAtRUlPOw0KKwl9
DQorCWlmIChyZWcgPT0gMCB8fCByZWcgPT0gfjApIHsNCisJCWRldl9lcnIod2Rldi0+ZGV2LCAi
Y2hpcCBtdXRlLiBCdXMgY29uZmlndXJhdGlvbiBlcnJvciBvciBjaGlwIHdhc24ndCByZXNldD9c
biIpOw0KKwkJcmV0dXJuIC1FSU87DQorCX0NCisJZGV2X2RiZyh3ZGV2LT5kZXYsICJpbml0aWFs
IGNvbmZpZyByZWdpc3RlciB2YWx1ZTogJTA4eFxuIiwgcmVnKTsNCisNCisJaHdfcmV2aXNpb24g
PSBGSUVMRF9HRVQoQ0ZHX0RFVklDRV9JRF9NQUpPUiwgcmVnKTsNCisJaWYgKGh3X3JldmlzaW9u
ID09IDAgfHwgaHdfcmV2aXNpb24gPiAyKSB7DQorCQlkZXZfZXJyKHdkZXYtPmRldiwgImJhZCBo
YXJkd2FyZSByZXZpc2lvbiBudW1iZXI6ICVkXG4iLCBod19yZXZpc2lvbik7DQorCQlyZXR1cm4g
LUVOT0RFVjsNCisJfQ0KKwlod190eXBlID0gRklFTERfR0VUKENGR19ERVZJQ0VfSURfVFlQRSwg
cmVnKTsNCisJaWYgKGh3X3R5cGUgPT0gMSkgew0KKwkJZGV2X25vdGljZSh3ZGV2LT5kZXYsICJk
ZXZlbG9wbWVudCBoYXJkd2FyZSBkZXRlY3RlZFxuIik7DQorCQl3YWtldXBfdGltZW91dCA9IDIw
MDA7DQorCX0NCisNCisJcmV0ID0gaW5pdF9ncHIod2Rldik7DQorCWlmIChyZXQgPCAwKQ0KKwkJ
cmV0dXJuIHJldDsNCisNCisJcmV0ID0gY29udHJvbF9yZWdfd3JpdGUod2RldiwgQ1RSTF9XTEFO
X1dBS0VVUCk7DQorCWlmIChyZXQgPCAwKQ0KKwkJcmV0dXJuIC1FSU87DQorCXN0YXJ0ID0ga3Rp
bWVfZ2V0KCk7DQorCWZvciAoOzspIHsNCisJCXJldCA9IGNvbnRyb2xfcmVnX3JlYWQod2Rldiwg
JnJlZyk7DQorCQlub3cgPSBrdGltZV9nZXQoKTsNCisJCWlmIChyZWcgJiBDVFJMX1dMQU5fUkVB
RFkpDQorCQkJYnJlYWs7DQorCQlpZiAoa3RpbWVfYWZ0ZXIobm93LCBrdGltZV9hZGRfbXMoc3Rh
cnQsIHdha2V1cF90aW1lb3V0KSkpIHsNCisJCQlkZXZfZXJyKHdkZXYtPmRldiwgImNoaXAgZGlk
bid0IHdha2UgdXAuIENoaXAgd2Fzbid0IHJlc2V0P1xuIik7DQorCQkJcmV0dXJuIC1FVElNRURP
VVQ7DQorCQl9DQorCX0NCisJZGV2X2RiZyh3ZGV2LT5kZXYsICJjaGlwIHdha2UgdXAgYWZ0ZXIg
JWxsZHVzXG4iLCBrdGltZV91c19kZWx0YShub3csIHN0YXJ0KSk7DQorDQorCXJldCA9IGNvbmZp
Z19yZWdfd3JpdGVfYml0cyh3ZGV2LCBDRkdfQ1BVX1JFU0VULCAwKTsNCisJaWYgKHJldCA8IDAp
DQorCQlyZXR1cm4gcmV0Ow0KKwlyZXQgPSBsb2FkX2Zpcm13YXJlX3NlY3VyZSh3ZGV2KTsNCisJ
aWYgKHJldCA8IDApDQorCQlyZXR1cm4gcmV0Ow0KKwlyZXQgPSBjb25maWdfcmVnX3dyaXRlX2Jp
dHMod2RldiwgQ0ZHX0RJUkVDVF9BQ0NFU1NfTU9ERSB8IENGR19JUlFfRU5BQkxFX0RBVEEgfCBD
RkdfSVJRX0VOQUJMRV9XUkRZLCBDRkdfSVJRX0VOQUJMRV9EQVRBKTsNCisJcmV0dXJuIHJldDsN
Cit9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9md2lvLmggYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L2Z3aW8uaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAw
MC4uNjAyOGY5MjUwM2ZlDQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4
L2Z3aW8uaA0KQEAgLTAsMCArMSwxNSBAQA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkgKi8NCisvKg0KKyAqIEZpcm13YXJlIGxvYWRpbmcuDQorICoNCisgKiBDb3B5
cmlnaHQgKGMpIDIwMTctMjAxOSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4NCisgKiBDb3B5
cmlnaHQgKGMpIDIwMTAsIFNULUVyaWNzc29uDQorICovDQorI2lmbmRlZiBXRlhfRldJT19IDQor
I2RlZmluZSBXRlhfRldJT19IDQorDQorc3RydWN0IHdmeF9kZXY7DQorDQoraW50IHdmeF9pbml0
X2RldmljZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7DQorDQorI2VuZGlmIC8qIFdGWF9GV0lPX0gg
Ki8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L21haW4uYyBiL2RyaXZlcnMvc3Rh
Z2luZy93ZngvbWFpbi5jDQppbmRleCA3NDQ0NDVlZjU5N2MuLmE4ZWYyOTE3NDIzMiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5jDQorKysgYi9kcml2ZXJzL3N0YWdpbmcv
d2Z4L21haW4uYw0KQEAgLTIwLDYgKzIwLDggQEANCiANCiAjaW5jbHVkZSAibWFpbi5oIg0KICNp
bmNsdWRlICJ3ZnguaCINCisjaW5jbHVkZSAiZndpby5oIg0KKyNpbmNsdWRlICJod2lvLmgiDQog
I2luY2x1ZGUgImJ1cy5oIg0KICNpbmNsdWRlICJ3ZnhfdmVyc2lvbi5oIg0KIA0KQEAgLTc2LDYg
Kzc4LDI0IEBAIHZvaWQgd2Z4X2ZyZWVfY29tbW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQ0KIHsN
CiB9DQogDQoraW50IHdmeF9wcm9iZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldikNCit7DQorCWludCBl
cnI7DQorDQorCWVyciA9IHdmeF9pbml0X2RldmljZSh3ZGV2KTsNCisJaWYgKGVycikNCisJCWdv
dG8gZXJyMTsNCisNCisJcmV0dXJuIDA7DQorDQorZXJyMToNCisJcmV0dXJuIGVycjsNCit9DQor
DQordm9pZCB3ZnhfcmVsZWFzZShzdHJ1Y3Qgd2Z4X2RldiAqd2RldikNCit7DQorfQ0KKw0KIHN0
YXRpYyBpbnQgX19pbml0IHdmeF9jb3JlX2luaXQodm9pZCkNCiB7DQogCWludCByZXQgPSAwOw0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5oIGIvZHJpdmVycy9zdGFnaW5n
L3dmeC9tYWluLmgNCmluZGV4IDgyMjIyZWRmOTk4Yi4uOGIyNTI2ZDgxOTg0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmgNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93Zngv
bWFpbi5oDQpAQCAtMTgsNiArMTgsMTMgQEANCiBzdHJ1Y3Qgd2Z4X2RldjsNCiANCiBzdHJ1Y3Qg
d2Z4X3BsYXRmb3JtX2RhdGEgew0KKwkvKiBLZXlzZXQgYW5kICIuc2VjIiBleHRlbnRpb24gd2ls
bCBhcHBlbmRlZCB0byB0aGlzIHN0cmluZyAqLw0KKwljb25zdCBjaGFyICpmaWxlX2Z3Ow0KKwkv
Kg0KKwkgKiBpZiB0cnVlIEhJRiBEX291dCBpcyBzYW1wbGVkIG9uIHRoZSByaXNpbmcgZWRnZSBv
ZiB0aGUgY2xvY2sNCisJICogKGludGVuZGVkIHRvIGJlIHVzZWQgaW4gNTBNaHogU0RJTykNCisJ
ICovDQorCWJvb2wgdXNlX3Jpc2luZ19jbGs7DQogfTsNCiANCiBzdHJ1Y3Qgd2Z4X2RldiAqd2Z4
X2luaXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwNCkBAIC0yNiw2ICszMyw5IEBAIHN0cnVj
dCB3ZnhfZGV2ICp3ZnhfaW5pdF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LA0KIAkJCQl2b2lk
ICpod2J1c19wcml2KTsNCiB2b2lkIHdmeF9mcmVlX2NvbW1vbihzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
dik7DQogDQoraW50IHdmeF9wcm9iZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7DQordm9pZCB3Znhf
cmVsZWFzZShzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7DQorDQogc3RydWN0IGdwaW9fZGVzYyAqd2Z4
X2dldF9ncGlvKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IG92ZXJyaWRlLA0KIAkJCSAgICAgICBj
b25zdCBjaGFyICpsYWJlbCk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC93
ZnguaCBiL2RyaXZlcnMvc3RhZ2luZy93Zngvd2Z4LmgNCmluZGV4IDk3MTZhY2M5ODFkZi4uNTZh
ZWQzMzI5MWFlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC93ZnguaA0KKysrIGIv
ZHJpdmVycy9zdGFnaW5nL3dmeC93ZnguaA0KQEAgLTE5LDYgKzE5LDggQEAgc3RydWN0IHdmeF9k
ZXYgew0KIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2Ow0KIAljb25zdCBzdHJ1Y3QgaHdidXNfb3BzCSpo
d2J1c19vcHM7DQogCXZvaWQJCQkqaHdidXNfcHJpdjsNCisNCisJdTgJCQlrZXlzZXQ7DQogfTsN
CiANCiAjZW5kaWYgLyogV0ZYX0ggKi8NCi0tIA0KMi4yMC4xDQo=
