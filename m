Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18271DB3E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 06:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfD2EuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 00:50:22 -0400
Received: from mail-eopbgr720104.outbound.protection.outlook.com ([40.107.72.104]:35648
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfD2EuW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 00:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTFjBMpqxYooIJxThTv9381u22xkhChXO/DmQSmSojM=;
 b=co8mfNXlRr4ZFaib0Js5FkK28h/i+iwPjvLlW1t7wfwRosMbXI+phV3GtwJo3Tgh2mAcGoXGBhtdaIKdPPl8WtO83W1tge430V8R8GL1u2zKv1K9uI7QzDR+INoklgolBiIpjhr9EZw9Q3c/FhHZnH1Eq+71DO1f6uSK44kK0T8=
Received: from MN2PR06MB5806.namprd06.prod.outlook.com (20.179.145.207) by
 MN2PR06MB5487.namprd06.prod.outlook.com (20.178.241.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 04:50:19 +0000
Received: from MN2PR06MB5806.namprd06.prod.outlook.com
 ([fe80::1068:df85:f952:bbf3]) by MN2PR06MB5806.namprd06.prod.outlook.com
 ([fe80::1068:df85:f952:bbf3%2]) with mapi id 15.20.1835.015; Mon, 29 Apr 2019
 04:50:19 +0000
From:   Wright Feng <Wright.Feng@cypress.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>
Subject: Re: [PATCH] brcmfmac: allocate msgbuf pktid from 1 to pktids array
 size
Thread-Topic: [PATCH] brcmfmac: allocate msgbuf pktid from 1 to pktids array
 size
Thread-Index: AQHU+z2RzToH3FeQwUSmmepORWhyJaZMu9WAgAXbtwA=
Date:   Mon, 29 Apr 2019 04:50:19 +0000
Message-ID: <0f72eace-be93-a6bd-c752-814efe93727c@cypress.com>
References: <1556179487-147593-1-git-send-email-wright.feng@cypress.com>
 <66165629-aa4d-afbe-5b09-3a592ff44a82@broadcom.com>
In-Reply-To: <66165629-aa4d-afbe-5b09-3a592ff44a82@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYXPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:403:a::29) To MN2PR06MB5806.namprd06.prod.outlook.com
 (2603:10b6:208:127::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [61.222.14.99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfe42a76-2cd1-4b7a-35f2-08d6cc5e2df5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR06MB5487;
x-ms-traffictypediagnostic: MN2PR06MB5487:
x-microsoft-antispam-prvs: <MN2PR06MB54873C769CEDDABE76CF3709FB390@MN2PR06MB5487.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(51914003)(189003)(199004)(5660300002)(72206003)(6506007)(6436002)(53936002)(66476007)(73956011)(3846002)(476003)(71200400001)(97736004)(186003)(486006)(66556008)(7736002)(102836004)(53546011)(66066001)(31686004)(66446008)(66946007)(26005)(71190400001)(6486002)(386003)(110136005)(6512007)(76176011)(54906003)(64756008)(6116002)(99286004)(11346002)(6636002)(446003)(6246003)(14454004)(52116002)(2616005)(25786009)(316002)(4326008)(478600001)(31696002)(2501003)(36756003)(256004)(2201001)(8936002)(86362001)(305945005)(81166006)(14444005)(8676002)(81156014)(2906002)(68736007)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR06MB5487;H:MN2PR06MB5806.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NlH7T+LYvc2KBSO2zS+SV9FVp7EUVsBN0pYz1RNVwYshoC/6Mt29z68ivLl9osrx4Jy/XfDzKjB3sIpNbMgR+vAVxfwOZrWOZj0oN7/t515fsGXOBd2as/3DPQhFesHyY6E9LQdea1XcTTHrwqzpCEZlXybm/9zVo7BON/DfHfBSI1TakhujKAzVPmY+RIXf/JGseWepysXXnLpKBXdamqoVZY5YibqxA9BMzjJRYSDN1n7YW6Y1hFhqT7bmhBXLZG1zaQWlhtxEtv0TX3Bi0LL750FztJQduQR0COYV1NjEvEWEZMKo+QOr943oCuNimUYJpy8k9zZiNu4OZcKaQ6OYAy/YQqDfqLpKvJ0J5nV2lg2UyO1+R9qTtyE37IHoQx07v2atYgxyXBkcvUDQdGBi44eTW0h2dDg5ncTKFUw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BE878BEF8041D49991E0D9EC57CAF48@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe42a76-2cd1-4b7a-35f2-08d6cc5e2df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 04:50:19.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB5487
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDIwMTkvNC8yNSDkuIvljYggMDc6MjIsIEFyZW5kIFZhbiBTcHJpZWwgd3JvdGU6DQo+
IE9uIDQvMjUvMjAxOSAxMDowNCBBTSwgV3JpZ2h0IEZlbmcgd3JvdGU6DQo+PiBTb21lIFBDSUUg
ZmlybXdhcmVzIGRyb3AgdHhzdGF0dXMgaWYgcGt0aWQgaXMgMCBhbmQgbWFrZSBwYWNrZXQgaGVs
ZCBpbg0KPj4gaG9zdCBzaWRlIGFuZCBub3QgYmUgcmVsZWFzZWQuIElmIHRoYXQgcGFja2V0IHR5
cGUgaXMgODAyLjF4LCB0aGUNCj4+IHBlbmRfODAyMXhfY250IHZhbHVlIHdpbGwgYmUgYWx3YXlz
IGdyZWF0ZXIgdGhhbiAwIGFuZCBzaG93ICJUaW1lZCBvdXQNCj4+IHdhaXRpbmcgZm9yIG5vIHBl
bmRpbmcgODAyLjF4IHBhY2tldHMiIGVycm9yIG1lc3NhZ2Ugd2hlbiBzZW5kaW5nIGtleSB0bw0K
Pj4gZG9uZ2xlLg0KPj4NCj4+IFRvIGJlIGNvbXBhdGlibGUgd2l0aCBhbGwgZmlybXdhcmVzLCBo
b3N0IHNob3VsZCBhbGxvY2F0ZSBtc2didWYgcGt0aWQNCj4+IGZyb20gMSBpbnN0ZWFkIG9mIGZy
b20gMC4NCj4gDQo+IGxvb2tpbmcgYXQgaXQgd2UgYXJlIHdhc3RpbmcgZW50cnkgMCB3aXRoIHRo
aXMgcGF0Y2guIENvdWxkIHdlIGF2b2lkIHRoYXQ/DQo+IA0KPiBSZWdhcmRzLA0KPiBBcmVuZA0K
PiANCkhpIEFyZW5kLA0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KVG8gYXZvaWQgd2Fz
dGluZyBpbmRleCB6ZXJvIGVudHJ5LCBJIGp1c3QgaW5jcmVhc2UgcmVxdWVzdCBJRCBpbiBUWGZs
b3cNCmFuZCBkZWNyZWFzZSByZXF1ZXN0IElEIHdoZW4gaGFuZGxpbmcgdHhzdGF0dXMuIEkndmUg
cG9zdGVkIHBhdGNoIHYyLg0KDQpSZWdhcmRzLA0KV3JpZ2h0DQo+PiBTaWduZWQtb2ZmLWJ5OiBX
cmlnaHQgRmVuZyA8d3JpZ2h0LmZlbmdAY3lwcmVzcy5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9tc2didWYuYyB8IDIg
Ky0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAy
MTEvYnJjbWZtYWMvbXNnYnVmLmMgDQo+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29t
L2JyY204MDIxMS9icmNtZm1hYy9tc2didWYuYw0KPj4gaW5kZXggZDM3ODBlYS4uYjJmYWIzYyAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9i
cmNtZm1hYy9tc2didWYuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20v
YnJjbTgwMjExL2JyY21mbWFjL21zZ2J1Zi5jDQo+PiBAQCAtMzQ4LDcgKzM0OCw3IEBAIGJyY21m
X21zZ2J1Zl9hbGxvY19wa3RpZChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiDCoMKgwqDCoMKgIGRv
IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAoKmlkeCkrKzsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoKmlkeCA9PSBwa3RpZHMtPmFycmF5X3NpemUpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqaWR4ID0gMDsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICppZHggPSAxOw0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhcnJheVsqaWR4XS5hbGxvY2F0ZWQuY291bnRlciA9PSAw
KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGF0b21pY19jbXB4Y2hnKCZhcnJh
eVsqaWR4XS5hbGxvY2F0ZWQsIDAsIDEpID09IDApDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4NCg==
