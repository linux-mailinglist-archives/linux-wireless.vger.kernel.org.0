Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA211026E6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 15:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfKSOfa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 09:35:30 -0500
Received: from mail-eopbgr720122.outbound.protection.outlook.com ([40.107.72.122]:27577
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728342AbfKSOf2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 09:35:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKUZuNk0WHRshtKPVXp6HV6qqiqu4dRUo27HfDs+QNwuKPfhvYcK80ndweieUFvi54J8PzhfOfK06qyzl6xmZZFJyV4+fdUnlNoKPcxGh7UG9w3ul0qJXigxzSfSmIu1IMsHrdF5OCFXb09B3fyWx+EtpmcUcOWTFJK5GfgoitjPRP7VCcCJQLQRMz6IHj3zSnoru/xjjo5pYwOVehbI/vktGg5nPBkWV5ChUw1iH5nhw+7GtOz7IkDYBOeN5jtIov0T5NkDZYUPQR1C9VwHauUt44yEx6UJrMcyjl4sy/zFIosE1/UeJOyoNuxJqWZfJOo9ALuGKooEJbYpVFf9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqKUAFDzH6+mEZKNoBVFg6xTklA9vHYcfk6tgf29ohE=;
 b=eytaz7/PScswvpDAtEOLNooqgBmqjp3hH1XySejVcDu1IvgiFthKRMalvEc3Ebkf2gRwRlNNOb4Sc607g3g2ZbmYkeork/FvQ98yzbv60TG5MqoXf3ShyTGYNZ5lLoNy3LF6KZkeOXX/Sm2czd3sPRiUdkXzY1cpYNGItPuGVBEBgwAj4movflYK885z7hj6EaRfbGmKexpJjwyiBCFPDwy/X6+t347M5gX4WO9bWiO7c1EBq6fSipn/l2iJe0eZlW0n7eQfqXBzBWss3tZCPUfc7i4eQwXpP2O+DQk72+uuRi5uiuUpVGV9QfoV4zOJVoNvx3tFrAg1uQEs6SDgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqKUAFDzH6+mEZKNoBVFg6xTklA9vHYcfk6tgf29ohE=;
 b=cc3t4tPa9vsj9QrfEYJwGjADCprnhVB2tCftCkR0K2KcS7L7YcLXLcsjsJA48vduWz2Gts3P1VLFupfw/QWQnYcdnEq8FPhtGnRdL4sqSrmRvlYpX3I1Qgsvo6pbw8Gk3AlL7QbkqjssiC8mpQJtvXqwWItW8JSz2z6nLCF2RMQ=
Received: from MWHPR0601MB3674.namprd06.prod.outlook.com (10.167.236.28) by
 MWHPR0601MB3691.namprd06.prod.outlook.com (10.167.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 19 Nov 2019 14:35:23 +0000
Received: from MWHPR0601MB3674.namprd06.prod.outlook.com
 ([fe80::796c:c777:d199:f2ae]) by MWHPR0601MB3674.namprd06.prod.outlook.com
 ([fe80::796c:c777:d199:f2ae%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 14:35:22 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>
Subject: Re: BCM4335 SDIO firmware crash/problem
Thread-Topic: BCM4335 SDIO firmware crash/problem
Thread-Index: AQHVkjzZLYO2NXjKxUS8wg38pn2QRKeC9xmAgA6HM4CAAMrfgIAAX20A
Date:   Tue, 19 Nov 2019 14:35:22 +0000
Message-ID: <f8351761-b5b4-734d-7fc8-aae37023d222@cypress.com>
References: <CAFBinCAbmvUJym2KD5Y4DcF_iGUwB6SrQSGd7qU6qmuctJ06Cg@mail.gmail.com>
 <CAFBinCD8TXZD6q662kFm_ZNe+kUi74q=SaEz_PHUev=AnWZSBw@mail.gmail.com>
 <CAFBinCCY=9Acen_YSkCxrwgx0txCGym_qVax9GfaVL7WC6MKWg@mail.gmail.com>
 <8c5c682c-da4b-0fb4-2173-8c3082614a56@broadcom.com>
In-Reply-To: <8c5c682c-da4b-0fb4-2173-8c3082614a56@broadcom.com>
Reply-To: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.222.14.99]
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-clientproxiedby: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To MWHPR0601MB3674.namprd06.prod.outlook.com
 (2603:10b6:301:7c::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eb6b0d0-7a30-4ccd-6b77-08d76cfdb565
x-ms-traffictypediagnostic: MWHPR0601MB3691:|MWHPR0601MB3691:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0601MB369166FA020439277BFDB3FDBB4C0@MWHPR0601MB3691.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(3450700001)(8676002)(102836004)(86362001)(76176011)(31696002)(110136005)(14444005)(54906003)(58126008)(52116002)(316002)(31686004)(305945005)(71200400001)(71190400001)(43066004)(256004)(14454004)(7736002)(2501003)(99286004)(2616005)(107886003)(5660300002)(6246003)(66066001)(11346002)(446003)(6436002)(6116002)(486006)(6486002)(65806001)(3846002)(229853002)(65956001)(6512007)(66946007)(6306002)(66446008)(66556008)(64756008)(66476007)(4326008)(478600001)(966005)(186003)(25786009)(36756003)(6506007)(2906002)(476003)(8936002)(26005)(53546011)(81166006)(81156014)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3691;H:MWHPR0601MB3674.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwQYtV8nvO41VlI9kPVhuYhZYhocl6sQv30OH1jF3Ow3Gu39XgrHcw5uUBPYVl/hs/c+AcPlR+98AyhiiEImbahnUWpTSuV9i2HnRiSXFzTZIIKSn9WNGkLqCHbnJS+uNaL4+KhCNRZFiP6x7Q+m1vmZy62kDLJoiXlCr4TMLrwG1sKl4asbuoUi7HTLmqS+sm8oGDuKtVe8vMsE9zbBZMwPjM1vV2On2wLIkHPu749OkCJ+nlr3Gn40YT9cRd9CxBLSyffnvy5r+jnIR0fp6Xbls5jMhJe2P9yKlpST2DsR85e3055YwOB9SqMR6ZkeLtvjDZfo6PesMGGfCtjuJ/P4VoRnjdex0ttS3Bmy9bHZ2b0j9rC2cLt3MVFILKFnz5rXSUL/tlu1UiT72Ci8dUwOTVSKOQqA8IzC2fLO23dwjbn67ZuNl0ca0XyrYUXSmIhTtZeg2t5D/4JaWaQJxBUr0Mm+lLBR7iPp1ZbYGUQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF09B64B62DC5840A25B33B447B379B8@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6b0d0-7a30-4ccd-6b77-08d76cfdb565
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:35:22.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+rNpGolcyL/akBFRBjiogpUiZHk9b/BMgB5zfzT/mC2CQ5YpllgzkmiOrLEhMJ++Nicqq4+SeJl42QZOCjxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3691
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDExLzE5LzIwMTkgNDo1MywgQXJlbmQgVmFuIFNwcmllbCB3cm90ZToNCj4gT24gMTEv
MTgvMjAxOSA5OjQ3IFBNLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdyb3RlOg0KPj4gSGkgQXJlbmQg
YW5kIGxpbnV4LXdpcmVsZXNzIHN1cHBvcnRlcnMsDQo+Pg0KPj4gT24gU2F0LCBOb3YgOSwgMjAx
OSBhdCAzOjU1IFBNIE1hcnRpbiBCbHVtZW5zdGluZ2wNCj4+IDxtYXJ0aW4uYmx1bWVuc3Rpbmds
QGdvb2dsZW1haWwuY29tPiB3cm90ZToNCj4+Pg0KPj4+IE9uIFN1biwgTm92IDMsIDIwMTkgYXQg
MTI6NDkgUE0gTWFydGluIEJsdW1lbnN0aW5nbA0KPj4+IDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdv
b2dsZW1haWwuY29tPiB3cm90ZToNCj4+PiBbLi4uXQ0KPj4+PiBUaGUgQW5kcm9pZCBpbnN0YWxs
YXRpb24gdGhhdCBteSBkZXZpY2UgY2FtZSB3aXRoIHNoaXBzIGEgbmV3ZXINCj4+Pj4gZmlybXdh
cmUgdmVyc2lvbjogIkJDTTQzMzUvMSB3bDA6IE1heSAxOCAyMDE0IDE2OjU2OjU0IHZlcnNpb24N
Cj4+Pj4gNi4zNC4xNzEuNTguMiIuIFRoaXMgaXMgYWxzbyBhdmFpbGFibGUgaW4gQ29yZUVMRUMn
cyByZXBvc2l0b3J5OiBbMl0uDQo+Pj4+IEkgd2VudCBhaGVhZCBhbmQgdXNlZCB0aGlzIG5ld2Vy
IG9uIG15IEFyY2ggTGludXggQVJNIGluc3RhbGxhdGlvbiBhbmQNCj4+Pj4gaXQgc2VlbXMgdG8g
aGF2ZSBmaXhlZCBteSBwcm9ibGVtDQo+Pj4gSSBhbSBub3cgYXQgMTIgZGF5cyBvZiB1cHRpbWUg
YW5kIHdpZmkgaXMgc3RpbGwgd29ya2luZyB3aXRoIHRoYXQgDQo+Pj4gZmlybXdhcmUNCj4+IGdl
bnRsZSBwaW5nIG9uIHRoaXMNCj4+IEkgY2FuIHNlbmQgYSBwYXRjaCBhZ2FpbnN0IGxpbnV4LWZp
cm13YXJlIGlmIHlvdSB3YW50IGJ1dCBJJ20gbm90IHN1cmUNCj4+IGFib3V0IHRoZSBsaWNlbnNl
IG9yIGFueSBpbnRlcm5hbHMgb2YgdGhhdCBmaXJtd2FyZQ0KPiANCj4gSGkgTWFydGluLA0KPiAN
Cj4gU29ycnkgSSBkaWQgbm90IGNoaW1lIGluIGVhcmxpZXIuIEkgaGF2ZSBub3QgbG9va2VkIGF0
IHRoZSBDb3JlRUxFQyANCj4gcmVwb3NpdG9yeSBmb3IgbGljZW5zZSBmaWxlcy4gV2l0aG91dCBz
dWNoIGluZm8gSSBhbSBpbmNsaW5lZCB0byBzYXkgeW91IA0KPiBhcmUgbm90IGxpY2Vuc2VkIHRv
IHJlZGlzdHJpYnV0ZSB0aGUgZmlybXdhcmUuIFRoZSBCQ000MzM1IGlzIA0KPiBlbmQtb2YtbGlm
ZSBmb3IgdXMgYWx0aG91Z2ggbWF5YmUgQ3lwcmVzcyBpcyBzdGlsbCBzZWxsaW5nIHRoZSBkZXZp
Y2UgDQo+IGFuZCBtYXkgd2FudCB0byBwcm92aWRlIGEgZmlybXdhcmUgdXBkYXRlLg0KDQpIaSBN
YXJ0aW4vQXJlbmQsDQoNCjQzMzUgaXMgbm90IGluIG91ciBzdXBwb3J0ZWQgY2hpcCBsaXN0LCBl
aXRoZXIuDQoNCkkgZGlkIGEgcXVpY2sgc2VhcmNoIGFuZCBmb3VuZCBiZWxvdyBDb3JlRUxFQyBy
ZXBvLCBidXQgZG9uJ3Qgc2VlIGEgDQpsaWNlbnNlIHdpdGggaXQ6DQpodHRwczovL2dpdGh1Yi5j
b20vQ29yZUVMRUMvYnJjbWZtYWNfc2Rpby1maXJtd2FyZS1hbWwNCg0KUmVnYXJkcywNCkNoaS1o
c2llbiBMaW4NCg0KPiANCj4gUmVnYXJkcywNCj4gQXJlbmQNCj4gLg0KPiANCg==
