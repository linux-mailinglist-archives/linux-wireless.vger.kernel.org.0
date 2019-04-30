Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD77F1D6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3ILu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 04:11:50 -0400
Received: from mail-eopbgr100068.outbound.protection.outlook.com ([40.107.10.68]:48655
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfD3ILt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 04:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=camlinlimited.onmicrosoft.com; s=selector1-camlintechnologies-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//9Snsc/+wR2WREBq3r6euZ6nst5TGxnWS4Zf46dc+E=;
 b=fV3565GoJon/4L2KErFGx0OPJo9GLRxk52wA2dBcchB1+ZvIyk3jSe+xxyYrZ9VI0zOkC7PpBnXyprvAP+nxZXGC1SviKSahg4ngr6gTFVt9Nz4GTVT+JKUcX7P2t7bnxThwTiG2jL8jzEkx0VAfm91JH81VUXjthIeWRhu30Z0=
Received: from CWLP123MB2050.GBRP123.PROD.OUTLOOK.COM (20.176.59.213) by
 CWLP123MB2532.GBRP123.PROD.OUTLOOK.COM (20.176.62.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 08:11:45 +0000
Received: from CWLP123MB2050.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c8ad:367e:c7d:83f5]) by CWLP123MB2050.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c8ad:367e:c7d:83f5%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 08:11:45 +0000
From:   Piotr Figiel <p.figiel@camlintechnologies.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
Thread-Topic: [PATCH] brcmfmac: change the order of things in brcmf_detach()
Thread-Index: AQHU/qTjTShkSc9F4EKf1QMZbN2XZ6ZUW2YA
Date:   Tue, 30 Apr 2019 08:11:45 +0000
Message-ID: <20190430081142.GA27822@phoenix>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
In-Reply-To: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.143.242.242]
x-clientproxiedby: DB6P18901CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::29) To CWLP123MB2050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=p.figiel@camlintechnologies.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac87d75-2996-40e0-cd04-08d6cd437c59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CWLP123MB2532;
x-ms-traffictypediagnostic: CWLP123MB2532:
x-microsoft-antispam-prvs: <CWLP123MB2532004122C06858CDBA9018E73A0@CWLP123MB2532.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(8936002)(229853002)(6246003)(102836004)(316002)(6486002)(81156014)(66066001)(54906003)(81166006)(76176011)(2906002)(33716001)(97736004)(6506007)(4326008)(8676002)(386003)(7736002)(3846002)(52116002)(6512007)(99286004)(6116002)(9686003)(305945005)(33656002)(68736007)(5660300002)(486006)(25786009)(53936002)(6436002)(14454004)(476003)(256004)(186003)(446003)(66556008)(66574012)(1076003)(66446008)(71190400001)(64756008)(14444005)(66946007)(6916009)(66476007)(11346002)(26005)(73956011)(71200400001)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CWLP123MB2532;H:CWLP123MB2050.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: camlintechnologies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sbvMXmBS235ZZ4/J1zk8vsXgHGuYKg1i6vlNIaTushQAlc4qyEeAeQFH2fS4Whi3YRPAQhGM6pPgbw+seEYxDdz/Rlyehlv62YVztNYAayYOKHD8MLlkyFak25de02NNoRcagmAR9m0aRUEdGHJuSRfLhxXYC6w5s8LWP8CQJ6D1m4DABkYAAu0mHjvt11Dz60yUHHr46XTPsbE9tNSpZLX1XrUZoMGxJuiKabT2KX+b358B/fIhRXB4mWZ3YANIxkcZ7PjIQapJD3pn0QZzUB3BF+ZD+lMn09QDGWT5otTVmTjJMmlk1+H5JqtWHF0sU2tJSNAYWrawl4zcbzRRrr+uQ1hHBbbeE1nC4/VIuPcFxqsq/qcrBaW1Rc4H3KY2uNuB3Hlv+uqYbIK5AyHknR1xVUlriaPBFUkahlcV0uE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6C981AAF147B942B2320D84219CB1BE@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: camlintechnologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac87d75-2996-40e0-cd04-08d6cd437c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 08:11:45.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2532
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQXJlbmQsDQoNCk9uIE1vbiwgQXByIDI5LCAyMDE5IGF0IDEyOjA5OjIxUE0gKzAyMDAsIEFy
ZW5kIHZhbiBTcHJpZWwgd3JvdGU6DQo+IFdoZW4gYnJjbWZfZGV0YWNoKCkgZnJvbSB0aGUgYnVz
IGxheWVyIHVwb24gcm1tb2Qgd2UgY2FuIG5vIGxvbmdlcg0KPiBjb21tdW5pY2F0ZS4gSGVuY2Ug
d2Ugd2lsbCBzZXQgdGhlIGJ1cyBzdGF0ZSB0byBET1dOIGFuZCBjbGVhbnVwDQo+IHRoZSBldmVu
dCBhbmQgcHJvdG9jb2wgbGF5ZXIuIFRoZSBuZXR3b3JrIGludGVyZmFjZXMgbmVlZCB0byBiZQ0K
PiBkZWxldGVkIGJlZm9yZSBicmNtZl9jZmc4MDIxMV9kZXRhY2goKSBiZWNhdXNlIHRoZSBsYXR0
ZXIgZG9lcyB0aGUNCj4gd2lwaHlfdW5yZWdpc3RlcigpIHdoaWNoIGlzc3VlcyBhIHdhcm5pbmcg
aWYgdGhlcmUgYXJlIHN0aWxsIG5ldHdvcmsNCj4gZGV2aWNlcyBsaW5rZWQgdG8gdGhlIHdpcGh5
IGluc3RhbmNlLg0KDQpUaGlzIHNlZW1zIHRvIGFscmVhZHkgaGFwcGVuIC0gYnJjbWZfY2ZnODAy
MTFfZGV0YWNoKCkgaXMgY2FsbGVkIGFmdGVyIHRoZQ0KaW50ZXJmYWNlcyBhcmUgcmVtb3ZlZC4N
Cg0KPiBUaGlzIGNoYW5nZSBzb2x2ZXMgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgaXNzdWUg
d2hpY2ggaGFwcGVuZWQNCj4gdXBvbiBpc3N1ZWluZyBybW1vZCB3aGlsZSB0aGVyZSBhcmUgcGFj
a2V0cyBxdWV1ZWQgaW4gYnVzIHByb3RvY29sDQo+IGxheWVyLg0KPiANCj4gUmVwb3J0ZWQtYnk6
IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4NCj4gUmV2aWV3ZWQtYnk6IEhhbnRl
IE1ldWxlbWFuIDxoYW50ZS5tZXVsZW1hbkBicm9hZGNvbS5jb20+DQo+IFJldmlld2VkLWJ5OiBQ
aWV0ZXItUGF1bCBHaWVzYmVydHMgPHBpZXRlci1wYXVsLmdpZXNiZXJ0c0Bicm9hZGNvbS5jb20+
DQo+IFJldmlld2VkLWJ5OiBGcmFua3kgTGluIDxmcmFua3kubGluQGJyb2FkY29tLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQXJlbmQgdmFuIFNwcmllbCA8YXJlbmQudmFuc3ByaWVsQGJyb2FkY29t
LmNvbT4NCj4gLS0tDQo+IEhpIFBpb3RyLA0KPiANCj4gV2hpbGUgd29ya2luZyBvbiBhbiBpc3N1
ZSB3aXRoIG1zZ2J1ZiBwcm90b2NvbCAodXNlZCBmb3IgUENJZSBkZXZpY2VzKQ0KPiB5b3VyIGNo
YW5nZSA1Y2RiMGVmNjE0NGYgKCJicmNtZm1hYzogZml4IE5VTEwgcG9pbnRlciBkZXJlZmVuY2Ug
ZHVyaW5nDQo+IFVTQiBkaXNjb25uZWN0IikgY29uZmxpY3RlZC4gSSBzdXNwZWN0IG15IHJlb3Jk
ZXJpbmcgc3R1ZmYgaW4NCj4gYnJjbWZfZGV0YWNoKCkgYWxzbyBmaXhlcyB5b3VyIGlzc3VlIHNv
IGNvdWxkIHlvdSByZXRlc3QgdGhpcyBwYXRjaCwNCj4gd2hpY2ggYmFzaWNhbGx5IHJldmVydHMg
eW91ciBjaGFuZ2UgYW5kIGFwcGxpZXMgbXkgcmVvcmRlcmluZywgYW5kIHNlZQ0KPiB3aGV0aGVy
IG15IHN1c3BpY2lvbiBjYW4gYmUgY29uZmlybWVkLg0KDQpEb2VzIHRoZSBpc3N1ZSByZXBvcnRl
ZCBieSBSYWZhxYIgeW91IGFyZSB0cnlpbmcgdG8gc29sdmUgd2l0aCB0aGlzIHBhdGNoIG9jY3Vy
DQpvbiBjdXJyZW50IGxpbnV4LW5leHQ/DQoNCkJlc3QgcmVnYXJkcywNCi0tIA0KUGlvdHIgRmln
aWVsDQo=
