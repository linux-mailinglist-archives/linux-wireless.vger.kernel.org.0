Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33B1177A6B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgCCP2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 10:28:52 -0500
Received: from mail-eopbgr150094.outbound.protection.outlook.com ([40.107.15.94]:3782
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729819AbgCCP2w (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 10:28:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFV+c64LhdbQ5OZsOTHs0fVH3oYeYSSpA5lCzEhD7uh6AG78P5BUSiD0RvxQ0dr4WYGJkCPJBXbuRvAzC3DG1GtyK4gd5Bt2NP46idHigNFrcHgxk8fyHuhb5s+2n66X7oo+ZnrjYwBS8uQ6K01iXPIQKWs+XB4Uq0G7gOGCp25hRb/cK8CG/axHefvygbxpH3nu7xpYDtrBgzye3pVci3R0nfDlTONvBGNHq3UwdJog75KWf/+6LsCNS9JqXlIE/G5ypGCtxkznCeX6Eip+Pot1rvgLlPj8eG3Wl6TgZ5hEgxTAJOv9SqZ/Q2hNUxHXV1KgRnUftoE5hZOnyPcJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27Qby9Qh7P68HyrIZnVdfgvfcIrYPKFDI/Rnxj7xE7g=;
 b=EC3D8py2kQyZzoF+v2j0yLCC/vhqZsDtwTQXwtYWkGTToYKbh1uTs9BTiwiRnAFohMju01r9x+5qfPDg77IWXKogUQGBpFpMepE6zszVS5BS0/Gg2Drqhvj7x4R9dD7bLdLrEHcgmklENf+HcoGYatAwgZRTZh9WR1cLNjT10Oi+Molsba4B8NsJqGJsiriYFvw2oPe5zRi6mqkl+r8VBAlJv50PjJXhtyGKBBegzJI0HmkOv57NEF6AiC4wW8AZPNSMrbJGZhdbOnqoMi+DOAguTeH5QO5V2S00F38YbOPwC19mgXPCH1XgrUmsMrKAjUQpYQNEefqikjsGXC3cCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27Qby9Qh7P68HyrIZnVdfgvfcIrYPKFDI/Rnxj7xE7g=;
 b=Y53Hu0vT6CtiqY1GjVf8JLJFtQpCHvNh+F1cRDz/nsa/NvPAHv0JEkvQItUrhm6Z+mH09xHbHmFVgWsGvrTs7kJoxcGDdXuk/WMlWOfid8zvD/WepMs74fDJNfA+cUzno/K1lQerkpwaks9G5OfIyWvSO49eP0qTRJ89dG8PLlA=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB5929.eurprd01.prod.exchangelabs.com (10.255.17.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 15:28:48 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:28:48 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hostap@lists.infradead.org" <hostap@lists.infradead.org>
Subject: wds link and Radius authentication issue
Thread-Topic: wds link and Radius authentication issue
Thread-Index: AdXxb7ZSnH+tbpW2TUaSZehDqCGwcA==
Date:   Tue, 3 Mar 2020 15:28:47 +0000
Message-ID: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02463f2e-6cdc-47ad-3d6d-08d7bf87919b
x-ms-traffictypediagnostic: DB8PR01MB5929:
x-microsoft-antispam-prvs: <DB8PR01MB592934F436BEC710947F54C190E40@DB8PR01MB5929.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(42606007)(346002)(376002)(366004)(136003)(39830400003)(396003)(199004)(189003)(9686003)(76116006)(508600001)(186003)(55016002)(81166006)(8676002)(81156014)(7696005)(66946007)(8936002)(86362001)(26005)(4326008)(6506007)(66476007)(66556008)(110136005)(66446008)(54906003)(64756008)(316002)(33656002)(71200400001)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB5929;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziws/+2janMfNNl0CV43zWIjXIIIuk5wZC7/kmdy/pH/r8BUn5L1RWHris7ptm8rpE7IJcTQZbB+J2hFkytemkHnMEprlFj9qTddAj2o/SWs4F7199rlvbAo/4X4Roa+zFKKzLhR3zTxJ2PZ33pGXLOMB5ldKS/K7/qyZ5hCT2ZD8cp7uRuywKJufymEMmUwQ61w8YqBkNXkXhtCD0FMN7l8n+dUU7VFn/IeKwwmW2L6LPVA5WPCJN/WWS5T0T1DfxQOF1hhb7dNTaF3BTjdK8jeImecWtIR1Y6Q8KtekIqAkxxyWFbVepl/1JbwpyM76pkbQruXvfCZ+W6isqFdcy86zx+4/RHVwIqDGKLun5NFC2sqajdHRo1U6nfvVPFMWE3mhM4atPbLP3lNeJFPOD+uHrXzFq0mI07Jo7O+9QhJagkO+e2bs16o6GlW7nX4
x-ms-exchange-antispam-messagedata: g5FS3T9IJL5bXulk6y9XcPGKMEBZk5MYHRpG7tK7PLQq6EtN5OnL9irEO6RFFxDa5FKgJ9zC/48WW9VT1iuT5fAtwfoIojVc6kMIKK125FqyYPnUtQ+NvOqJhNYSR6EB0R3vV76zjxBsTuMkwfJp2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 02463f2e-6cdc-47ad-3d6d-08d7bf87919b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 15:28:47.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWwSVxf60wgfZyJonOTT8fBe+D20kQgYHneJ76ERthEkXsM6bfOp7TTnCGhUPPU7ReP9PDRcsuETGzE5oXJWARAHWl5qABeMl/MNxeQ6T3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB5929
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIG9yaWdpbiBvZiB0aGUgaXNzdWUgaXMgIGluIFZMQU4gc3RhIGZlYXR1cmUgYW5kICBXRFMg
c3RhIGZlYXR1cmUgbWFuYWdlbWVudC4NClRoZXNlIGJvdGggZmVhdHVyZXMgYXJlIG1hbmFnZWQg
d2l0aCB0aGUgc2FtZSBjb2RlLg0KDQpJbiBjYXNlIG9mIHdlIHVzZSBhIFdEUyBzdGEgYW5kIDgw
Mi4xeCBhdXRoZW50aWNhdGlvbiB0aGF0IGRvbid0IHdvcmsuDQpXaGVuIHRoZSBBUCBzaWRlIHJl
Y2VpdmUgdGhlIG51bGwgZnVuY3Rpb24gZnJhbWUgaW4gNGFkZHIgZm9ybWF0IGZyb20gdGhlIHN0
YSwgaG9zdGFwZCBjcmVhdGUgdGhlIHN0YSBuZXRkZXYgYW5kIGNhbGwgdGhlIE5MIG1lc3NhZ2Ug
Tkw4MDIxMV9DTURfU0VUX1NUQVRJT04uIEluIG1hYzgwMjExIHRoZSBmdW5jdGlvbiBpZWVlODAy
MTFfY2hhbmdlX3N0YXRpb24gYXNzaWduIHRoZSBwb2ludGVyIHZsYW5zZGF0YS0+dS52bGFuLnN0
YS4NCg0KRHVyaW5nIHRoZSA4MDIuMXggYXV0aGVudGljYXRpb24gaG9zdGFwZCBzZW5kIHRoZSBO
TDgwMjExX0NNRF9TRVRfU1RBVElPTiBtZXNzYWdlIGZvciBhZGQgdmxhbiBtYW5hZ2VtZW50LiBJ
IGRpZG4ndCB1bmRlcnN0YW5kIHdoeSBob3N0YXBkIHJlcXVpcmUgdGhpcyBjYWxsLCBiZWNhdXNl
IGluIHRoZSBtc2cgbm8gdmxhbiBpbmZvcm1hdGlvbiBpcyBnaXZlbi4gV2l0aCB0aGlzIHNlY29u
ZCBjYWxsLCBpZWVlODAyMTFfY2hhbmdlX3N0YXRpb24gZnVuY3Rpb24sIHNldCB0aGUgdmxhbnNk
YXRhLT51LnZsYW4uc3RhIHRvIE5VTEwgLiBBZnRlciB0aGF0IG5vIGZyYW1lcyBhcmUgc2VudCB0
aHJvdWdoIHRoZSB3ZHMgc3RhIG5ldGRldiBhbmQgYWxsIGZyYW1lIGFyZSBzZW50IHdpdGggMyBh
ZGRyLg0KSW4gdGhlIHN0YSBzaWRlIGFsbCBmcmFtZXMgcmVjZWl2ZWQgd2l0aCAzIGFkZHIgaXMg
ZHJvcGVkIGlmIHRoZSBzdGEgaXMgY29uZmlndXJlZCB0byB1c2UgNCBhZGRyIGhlYWRlciBmb3Jt
YXQuDQoNClNvIG5vIElQIGNvbW11bmljYXRpb24gaXMgcG9zc2libGUgYmV0d2VlbiB0aGUgQVAg
YW5kIHRoZSBTVEEuDQoNCkkgdHJpZWQgdG8gZml4IHRoaXMgaXNzdWUsIGJ1dCBJJ20gbm90IHN1
cmUgd2hlcmUgSSBzaG91bGQgZml4IHRoZSBpc3N1ZSAoaG9zdGFwZCBvciBtYWM4MDIxMSkuDQpG
aW5hbGx5LCBJIGZvdW5kIGEgd29ya2Fyb3VuZCwgaW4gaG9zdGFwZCBpZiBJIGRpc2FibGVkIHRo
ZSBWTEFOIGZlYXR1cmUgdGhlIGlzc3VlIGlzIGZpeGVkIChiZWNhdXNlIHRoZSBzZWNvbmQgY2Fs
bCBpcyBub3QgcHJlc2VudCkuIEZvciB0aGUgbW9tZW50IEkgZG9uJ3QgdXNlIHRoaXMgZmVhdHVy
ZSBzbyBJIGNhbiBkaXNhYmxlZCBpdC4NCg0KSSBob3BlIGFuIG1hYzgwMjExL2hvc3RhcGQgZXhw
ZXJ0IHdpbGwgZml4IHRoaXMgaXNzdWUgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGlua3MgZm9yIHlv
dXIgaGVscC4NCj4gLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQo+IERlwqA6IEpvaGFubmVz
IEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IEVudm95w6nCoDogbWFyZGkgMyBt
YXJzIDIwMjAgMTA6MzENCj4gw4DCoDogQ2VkcmljIFZPTkNLRU4gPGNlZHJpYy52b25ja2VuQGFj
a3N5cy5mcj47IFN0ZXZlIGRlUm9zaWVyDQo+IDxkZXJvc2llckBnbWFpbC5jb20+DQo+IENjwqA6
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBPYmpldMKgOiBSZTogW21hYzgwMjEx
XTogd2RzIGxpbmsgYW5kIFJhZGl1cyBhdXRoZW50aWNhdGlvbiBpc3N1ZQ0KPiANCj4gSGkgQ2Vk
cmljLA0KPiANCj4gVW1tLCB0aGF0IHdhcyBoYXJkIHRvIHJlYWQuIFlvdSBzaG91bGQgcXVvdGUg
bXkgd3JpdGluZywgbm90IHlvdXIgb3duIDopDQo+IA0KPiANCj4gPiA+IFRoZSB3bGFuMC5zdGEx
IG5ldCBkZXYgd2FzIGNyZWF0ZWQgYnkgaG9zdGFwZCB0byBtYW5hZ2UgdGhlIHdkcyBzdGEuDQo+
ID4gPiBUaGlzIG5ldGRldiB0eXBlIGlzIEFQIFZMQU4uIFRoZSBmdW5jdGlvbiBpZWVlODAyMTFf
bG9va3VwX3JhX3N0YQ0KPiA+ID4gcmV0dXJuIC1FTk9MSU5LIGJlY2F1c2UgdGhlIHBvaW50ZXIg
c2RhdGEtPnUudmxhbi5zdGEgd2FzIG5vdA0KPiA+ID4gZGVmaW5lZC4NCj4gDQo+IFJpZ2h0Lg0K
PiANCj4gPiA+IEluIG1hYzgwMjExLCB3aGVyZSB0aGlzIHJjdSBwb2ludGVyIGlzIGFsbG9jYXRl
ZD8gV2hpY2ggTkwgbWVzc2FnZSB0aGUNCj4gdXNlciBzcGFjZSB1c2UgPw0KPiANCj4gTG9vayBh
dCBpZWVlODAyMTFfY2hhbmdlX3N0YXRpb24oKSwgY2FsbGVkIGZyb20gbmw4MDIxMV9zZXRfc3Rh
dGlvbigpIHdpdGgNCj4gDQo+IAlwYXJhbXMudmxhbiA9IGdldF92bGFuKGluZm8sIHJkZXYpOw0K
PiANCj4gam9oYW5uZXMNCg0K
