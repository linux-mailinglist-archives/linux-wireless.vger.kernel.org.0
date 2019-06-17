Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3547BCD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFQIFd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 04:05:33 -0400
Received: from mail-eopbgr790137.outbound.protection.outlook.com ([40.107.79.137]:6213
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfFQIFd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 04:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg7StyxRgv7WBVk81UeLYSw1aUjjWS1ireND0bEiaaM=;
 b=u8qxDmMI2oMo5fhPKUU6lCRb4ZJaoQJjtSp1xk2GprIHzu/bdX7BpvDnenLIr+Tlb7mj+D4wp+SRDLkP6Psm3ry3/wPZm+QcqyLdDYjTL3dSE9wqy3daimhjXk+mGWUkOBxgdiVaisHdGRsqxHcEGBABsrE0JgbLX9/DJMRZ+6g=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB5849.namprd06.prod.outlook.com (20.179.162.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 08:04:49 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::8cc7:f8b2:c735:8992]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::8cc7:f8b2:c735:8992%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 08:04:49 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
Thread-Topic: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
Thread-Index: AQHVI5wQ1zsNjjpn8Ea8hZQgX/OX3aac9kYAgAKJGwA=
Date:   Mon, 17 Jun 2019 08:04:49 +0000
Message-ID: <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
In-Reply-To: <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
Reply-To: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [61.222.14.99]
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-clientproxiedby: TYAPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::28) To DM6PR06MB5804.namprd06.prod.outlook.com
 (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce40350-62f1-4ed0-9aba-08d6f2fa7811
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(49563074)(7193020);SRVR:DM6PR06MB5849;
x-ms-traffictypediagnostic: DM6PR06MB5849:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR06MB5849A9FAB8589EEC8AB63156BBEB0@DM6PR06MB5849.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6512007)(386003)(26005)(6506007)(6636002)(2906002)(5024004)(66946007)(64756008)(66556008)(73956011)(66446008)(4744005)(66616009)(66476007)(66066001)(65956001)(65806001)(53936002)(6436002)(68736007)(6246003)(65826007)(6486002)(86362001)(2201001)(71200400001)(71190400001)(31696002)(966005)(99286004)(6306002)(476003)(58126008)(478600001)(8936002)(2501003)(316002)(11346002)(52116002)(2616005)(446003)(31686004)(76176011)(102836004)(229853002)(3846002)(6116002)(8676002)(486006)(186003)(3450700001)(36756003)(99936001)(43066004)(305945005)(256004)(72206003)(64126003)(7736002)(5660300002)(14454004)(81166006)(81156014)(110136005)(25786009)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB5849;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e/eonagKtnsBTXuO8FuDyztYbjMy+DhuMneHCshUdYtKmQlhX8eQiF99DuM+0utSPvKMpJSJ2zJtA6yHe9lhckRcwS3NS8hn40RYOJSlxscyhsiolCAus9SZNaJKATAuzZOTvePGKSN9GdxfK6K1WGRF7Az2UaENeGiNxpZKEr7QSyLw4zWDu2NidglIV7lm/BwaP26wNVBmcp1Op3Bfcz4lo7SKHCRy9GGMxE97+Eyy1HB+4OHyjU3T0ci0HDwc1Mfss9lrkKy5enXhl2O+4ueUJwLhtwUXF3lEYRC3SpoXR/WTZ52QjBA7kqqnDLJu2D4STOOTSjqgCH29KfQgL6IrFxCxP9cIdy0yT9u1aa/zXbeLTnOzN3ryI1FHqQV0+Ie7j9giWnaTCzY5XKEJ57UbtF/I71ZxvDut5cR2tzw=
Content-Type: multipart/mixed;
        boundary="_002_605ea0a83303b810622318ccc7eb7af4cypresscom_"
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce40350-62f1-4ed0-9aba-08d6f2fa7811
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 08:04:49.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chln@cypress.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5849
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_002_605ea0a83303b810622318ccc7eb7af4cypresscom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B3178B2F0B154418E2CCD94A585DED6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64

KCtTdGFubGV5KQ0KDQpPbiAwNi8xNi8yMDE5IDE6MjEsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6DQo+
IEFtIDE1LjA2LjE5IHVtIDE5OjAxIHNjaHJpZWIgU3RlZmFuIFdhaHJlbjoNCj4+IEhpLA0KPj4N
Cj4+IGkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIGFuIChtYXliZSBvbGRlciBpc3N1ZSkgd2l0aCA0
LXdheSBoYW5kc2hha2UNCj4+IG9mZmxvYWRpbmcgZm9yIDgwMi4xWCBpbiB0aGUgYnJjbWZtYWMg
ZHJpdmVyLiBNeSBzZXR1cCBjb25zaXN0cyBvZg0KPj4gUmFzcGJlcnJ5IFBpIDMgQiAoY3VycmVu
dCBsaW51eC1uZXh0LCBhcm02NC9kZWZjb25maWcpIG9uIFNUQSBzaWRlIGFuZCBhDQo+PiBSYXNw
YmVycnkgUGkgMyBBKyAoTGludXggNC4xOSkgb24gQVAgc2lkZS4NCj4gDQo+IExvb2tzIGxpa2Ug
UmFzcGJlcnJ5IFBpIGlzbid0IHRoZSBvbmx5IGFmZmVjdGVkIHBsYXRmb3JtIFszXSwgWzRdLg0K
PiANCj4gWzNdIC0gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0x
NjY1NjA4DQo+IFs0XSAtIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MjAyNTIxDQoNClN0ZWZhbiwNCg0KQ291bGQgeW91IHBsZWFzZSB0cnkgdGhlIGF0dGFjaGVk
IHBhdGNoIGZvciB5b3VyIHdwYV9zdXBwbGljYW50PyBXZSdsbCANCnVwc3RyZWFtIGlmIGl0IHdv
cmtzIGZvciB5b3UuDQoNClJlZ2FyZHMsDQpDaGktaHNpZW4gTGluDQo=

--_002_605ea0a83303b810622318ccc7eb7af4cypresscom_
Content-Type: text/plain;
	name="0001-wpa_supplicant-Fix-802.1X-4-way-handshake-offload-in.patch"
Content-Description:
 0001-wpa_supplicant-Fix-802.1X-4-way-handshake-offload-in.patch
Content-Disposition: attachment;
	filename="0001-wpa_supplicant-Fix-802.1X-4-way-handshake-offload-in.patch";
	size=1644; creation-date="Mon, 17 Jun 2019 08:04:49 GMT";
	modification-date="Mon, 17 Jun 2019 08:04:49 GMT"
Content-ID: <C52F39F2AD3FD1478EE59E7CD5390312@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA5Nzc0ZGZiZjYyZjQxMDgwMjY3ZWJiMDk0MzAxNWE5ZjZkMWRjMGNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVuZy1Ic2llbiBIc3UgPHN0YW5sZXkuaHN1QGN5cHJlc3Mu
Y29tPgpEYXRlOiBNb24sIDIwIE1heSAyMDE5IDE3OjEwOjM5ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gd3BhX3N1cHBsaWNhbnQ6IEZpeCA4MDIuMVggNC13YXkgaGFuZHNoYWtlIG9mZmxvYWQgaW5k
aWNhdGlvbgoKQ29tbWl0IGQ4OTY4NzRmODY4OSAoIm5sODAyMTE6IEluZGljYXRlIDgwMi4xWCA0
LXdheSBoYW5kc2hha2UKb2ZmbG9hZCBpbiBjb25uZWN0IikgdXNlZCB0aGUgcmVxX2tleV9tZ210
X29mZmxvYWQgZmxhZyB0bwppbmRpY2F0ZSB0byB0aGUgZHJpdmVyIHRoYXQgaXQgc2hvdWxkIG9m
ZmxvYWQgdGhlIDgwMi4xWCBoYW5kc2hha2UuCkhvd2V2ZXIsIHRoZSBmbGFnIHdpbGwgYmUgdXBk
YXRlZCBhY2NvcmRpbmcgdG8gdGggY29uZmlndXJhdGlvbiBvZgpwcm9hY3RpdmUga2V5IGNhY2hp
bmcgYW5kIE9LQyBpZiBrZXkgbWFuYWdlbWVudCBvZmZsb2FkIGlzIGNvbnNpZGVyZWQKKGl0IGlz
IGVuYWJsZWQgYnkgZGVmYXVsdCBub3cpLiBEbyBub3QgdXBkYXRlIHRoZSBmbGFnIGlmIGl0IGhh
cyBiZWVuCnNldCBmb3IgODAyLjFYIDQtd2F5IGhhbmRzaGFrZSBvZmZsb2FkLgoKU2lnbmVkLW9m
Zi1ieTogQ2h1bmctSHNpZW4gSHN1IDxzdGFubGV5LmhzdUBjeXByZXNzLmNvbT4KLS0tCiB3cGFf
c3VwcGxpY2FudC93cGFfc3VwcGxpY2FudC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd3BhX3N1cHBsaWNhbnQv
d3BhX3N1cHBsaWNhbnQuYyBiL3dwYV9zdXBwbGljYW50L3dwYV9zdXBwbGljYW50LmMKaW5kZXgg
OTZhMzY5MWNmM2NmLi42NmVlMjY4ZDg2MWMgMTAwNjQ0Ci0tLSBhL3dwYV9zdXBwbGljYW50L3dw
YV9zdXBwbGljYW50LmMKKysrIGIvd3BhX3N1cHBsaWNhbnQvd3BhX3N1cHBsaWNhbnQuYwpAQCAt
MzIyMSw4ICszMjIxLDEwIEBAIHN0YXRpYyB2b2lkIHdwYXNfc3RhcnRfYXNzb2NfY2Ioc3RydWN0
IHdwYV9yYWRpb193b3JrICp3b3JrLCBpbnQgZGVpbml0KQogCSAgICAgcGFyYW1zLmtleV9tZ210
X3N1aXRlID09IFdQQV9LRVlfTUdNVF9JRUVFODAyMVhfU1VJVEVfQiB8fAogCSAgICAgcGFyYW1z
LmtleV9tZ210X3N1aXRlID09IFdQQV9LRVlfTUdNVF9JRUVFODAyMVhfU1VJVEVfQl8xOTIpKQog
CQlwYXJhbXMucmVxX2tleV9tZ210X29mZmxvYWQgPSAxOworCWVsc2UKKwkJcGFyYW1zLnJlcV9r
ZXlfbWdtdF9vZmZsb2FkID0gMDsKIAotCWlmICh3cGFfcy0+Y29uZi0+a2V5X21nbXRfb2ZmbG9h
ZCkgeworCWlmICh3cGFfcy0+Y29uZi0+a2V5X21nbXRfb2ZmbG9hZCAmJiAhcGFyYW1zLnJlcV9r
ZXlfbWdtdF9vZmZsb2FkKSB7CiAJCWlmIChwYXJhbXMua2V5X21nbXRfc3VpdGUgPT0gV1BBX0tF
WV9NR01UX0lFRUU4MDIxWCB8fAogCQkgICAgcGFyYW1zLmtleV9tZ210X3N1aXRlID09IFdQQV9L
RVlfTUdNVF9JRUVFODAyMVhfU0hBMjU2IHx8CiAJCSAgICBwYXJhbXMua2V5X21nbXRfc3VpdGUg
PT0gV1BBX0tFWV9NR01UX0lFRUU4MDIxWF9TVUlURV9CIHx8Ci0tIAoyLjEuMAoK

--_002_605ea0a83303b810622318ccc7eb7af4cypresscom_--
