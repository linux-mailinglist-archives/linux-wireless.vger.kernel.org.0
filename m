Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A594B089D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiBJIlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:41:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiBJIlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:41:31 -0500
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139A3108D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 00:41:29 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 16159720615;
        Thu, 10 Feb 2022 09:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1644482472;
        bh=PDzjl8+nYwyMkUieVrj6QqDUpJYANip8EQxH+2oEcuU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HEvvGW4qiLXp0C1OE2hhGDXJDiOxbpV6eDt2NdhBoQck9Go2wIM3tTd23xLQSH7+5
         5SBg+0ipfquf1rv5Ce0K7VFZPLk8WZxBBuGWLSy3CGAkkLVAtRe67NjDumvRAQUb+/
         ZXr9qrs4JPUqC2NDXRxo9fuB39x7KuB6KNslCtlPHZx7T/iKfJohDxLAtHEg9T52R2
         H3ImLWZGsZVLWR+RZNoPnnRhHu7XFF5VO+DjuESUk2mZUeuW4y328FNHjSXgjmkGTC
         gTtL3Osf2IIMj25v60AYwf7bAYGsOW4agaB55y508mhg4UXQXGx+zxha4mP6DwFJPj
         p5L8zW3FN2bkQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Feb 2022 09:40:58 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.015; Thu, 10 Feb 2022 09:40:58 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     "Ajay.Kathat@microchip.com" <Ajay.Kathat@microchip.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "Andreas Geisreiter" <ageisreiter@dh-electronics.com>,
        "Marek MV. Vasut" <marex@denx.de>
Subject: RE: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUwAvQHEAACUMdlA=
Date:   Thu, 10 Feb 2022 08:40:57 +0000
Message-ID: <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
 <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
In-Reply-To: <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.51.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSBbbWFpbHRvOkFqYXkuS2F0aGF0QG1pY3Jv
Y2hpcC5jb21dDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDksIDIwMjIgMzozNyBQTQ0KPiBP
biAwOC8wMi8yMiAyMTo1NiwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4NCj4+IEhl
bGxvLA0KPj4NCj4+IEkgdGVzdGVkIHRoZSB3aXJlbGVzcyBjaGlwIHdpbGMxMDAwIHdpdGggdGhl
IDUuMTYuNSBLZXJuZWwgYW5kIHRoZSBmaXJtd2FyZSB2MTUuNC4xDQo+PiAoaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZmlybXdhcmUvbGludXgtZmlybXdh
cmUuZ2l0L3RyZWUvYXRtZWwvd2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJpbikNCj4+IG9uIGFu
IGkuTVg2IFFVQUQgd2l0aCBpcGVyZjM6DQo+Pg0KPj4gIyBpcGVyZjMgLWMgSVBfQUREUiAtUCAx
NiAtdCAwDQo+Pg0KPj4gQWZ0ZXIgYSB3aGlsZSB0aGUgdGVzdCBnZXRzIHN0dWNrIGFuZCBJIGdv
dCB0aGUgZm9sbG93aW5nIGtlcm5lbCBtZXNzYWdlczoNCj4+IG1tYzA6IFRpbWVvdXQgd2FpdGlu
ZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0Lg0KPj4gbW1jMDogc2RoY2k6ID09PT09PT09PT09PSBT
REhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQo+PiBtbWMwOiBzZGhjaTogU3lzIGFkZHI6
ICAweDEzOGYwMjAwIHwgVmVyc2lvbjogIDB4MDAwMDAwMDINCj4+IG1tYzA6IHNkaGNpOiBCbGsg
c2l6ZTogIDB4MDAwMDAxNTggfCBCbGsgY250OiAgMHgwMDAwMDAwMQ0KPj4gbW1jMDogc2RoY2k6
IEFyZ3VtZW50OiAgMHgxNDAwMDE1OCB8IFRybiBtb2RlOiAweDAwMDAwMDEzDQo+PiBtbWMwOiBz
ZGhjaTogUHJlc2VudDogICAweDAxZDg4YTBhIHwgSG9zdCBjdGw6IDB4MDAwMDAwMTMNCj4+IG1t
YzA6IHNkaGNpOiBQb3dlcjogICAgIDB4MDAwMDAwMDIgfCBCbGsgZ2FwOiAgMHgwMDAwMDA4MA0K
Pj4gbW1jMDogc2RoY2k6IFdha2UtdXA6ICAgMHgwMDAwMDAwOCB8IENsb2NrOiAgICAweDAwMDAw
MDlmDQo+PiBtbWMwOiBzZGhjaTogVGltZW91dDogICAweDAwMDAwMDhmIHwgSW50IHN0YXQ6IDB4
MDAwMDAwMDANCj4+IG1tYzA6IHNkaGNpOiBJbnQgZW5hYjogIDB4MTA3ZjEwMGIgfCBTaWcgZW5h
YjogMHgxMDdmMTAwYg0KPj4gbW1jMDogc2RoY2k6IEFDbWQgc3RhdDogMHgwMDAwMDAwMCB8IFNs
b3QgaW50OiAweDAwMDAwMDAzDQo+PiBtbWMwOiBzZGhjaTogQ2FwczogICAgICAweDA3ZWIwMDAw
IHwgQ2Fwc18xOiAgIDB4MDAwMGEwMDANCj4+IG1tYzA6IHNkaGNpOiBDbWQ6ICAgICAgIDB4MDAw
MDM1M2EgfCBNYXggY3VycjogMHgwMGZmZmZmZg0KPj4gbW1jMDogc2RoY2k6IFJlc3BbMF06ICAg
MHgwMDAwMTAwMCB8IFJlc3BbMV06ICAweDAwMDAwMDAwDQo+PiBtbWMwOiBzZGhjaTogUmVzcFsy
XTogICAweDAwMDAwMDAwIHwgUmVzcFszXTogIDB4MDAwMDAwMDANCj4+IG1tYzA6IHNkaGNpOiBI
b3N0IGN0bDI6IDB4MDAwMDAwMDANCj4+IG1tYzA6IHNkaGNpOiBBRE1BIEVycjogIDB4MDAwMDAw
MDcgfCBBRE1BIFB0cjogMHg0YzA0MTIwMA0KPj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiA9PT09
PT09PT0gRVNESEMgSU1YIERFQlVHIFNUQVRVUyBEVU1QID09PT09PT09PQ0KPj4gbW1jMDogc2Ro
Y2ktZXNkaGMtaW14OiBjbWQgZGVidWcgc3RhdHVzOiAgMHgyMTAwDQo+PiBtbWMwOiBzZGhjaS1l
c2RoYy1pbXg6IGRhdGEgZGVidWcgc3RhdHVzOiAgMHgyMjAwDQo+PiBtbWMwOiBzZGhjaS1lc2Ro
Yy1pbXg6IHRyYW5zIGRlYnVnIHN0YXR1czogIDB4MjMwMA0KPj4gbW1jMDogc2RoY2ktZXNkaGMt
aW14OiBkbWEgZGVidWcgc3RhdHVzOiAgMHgyNDAyDQo+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6
IGFkbWEgZGVidWcgc3RhdHVzOiAgMHgyNWI0DQo+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGZp
Zm8gZGVidWcgc3RhdHVzOiAgMHgyNjEwDQo+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGFzeW5j
IGZpZm8gZGVidWcgc3RhdHVzOiAgMHgyNzUxDQo+PiBtbWMwOiBzZGhjaTogPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+IHdpbGMxMDAwX3NkaW8gbW1jMDow
MDAxOjE6IHdpbGNfc2Rpb19jbWQ1My4uZmFpbGVkLCBlcnIoLTExMCkNCj4+IHdpbGMxMDAwX3Nk
aW8gbW1jMDowMDAxOjE6IEZhaWxlZCBjbWQ1MyBbMF0sIGJ5dGVzIHJlYWQuLi4NCj4+DQo+PiBJ
IHRyaWVkIHRvIHJlZHVjZSB0aGUgY2xvY2sgc3BlZWQgdG8gMjBNSHogaW4gdGhlIGRldmljZXRy
ZWUgd2l0aA0KPj4gbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+PiBidXQgdGhlIHByb2Js
ZW0gdGhlbiBhbHNvIG9jY3Vycy4NCj4+DQo+PiBJcyB0aGlzIGEgcG9zc2libGUgYnVnPw0KPj4N
Cj4+DQo+IA0KDQpIaSBBamF5LA0KVGhhbmtzIGZvciB0aGUgYW5zd2VyLg0KDQo+IFRoZSBidXMg
ZXJyb3Igc2VlbXMgdG8gYmUgc3BlY2lmaWMgdG8gdGhlIGhvc3QgZHVyaW5nIHRoZSBTRElPIHRy
YW5zZmVyLg0KPiBIb3cgbG9uZyBkb2VzIGl0IHRha2UgdG8gcmVwcm9kdWNlIGl0PyBEb2VzIHRo
ZSBpc3N1ZSBhbHNvIGhhcHBlbg0KPiB3aXRob3V0ICItUCAxNiIgaVBlcmYzIG9wdGlvbj8NCg0K
SXQgdGFrZXMgYWJvdXQgMTBzIChzb21ldGhpbmcgYSBiaXQgbG9uZ2VyKSB0aWxsIEkgZ290IHRo
aXMga2VybmVsIGVycm9yDQptZXNzYWdlcyBhbmQgaXQgZG9lc24ndCBtYXR0ZXIgaWYgSSB1c2Ug
aXQgd2l0aCAiLVAgMTYiIG9yIHdpdGhvdXQuDQoNCj4gSXQgbWlnaHQgYmUgd29ydGggdHJ5aW5n
IHdpdGggcG93ZXItc2F2ZSBtb2RlIGRpc2FibGVkLiBUaGUgUFMgbW9kZSBjYW4NCj4gYmUgZGlz
YWJsZWQgZWl0aGVyIGJ5IHNldHRpbmcgV0lEX1BPV0VSX01BTkFHRU1FTlQgV0lEIHRvDQo+IDAo
V0lMQ19GV19OT19QT1dFUlNBVkUpIGluICJ3aWxjX3NldF9wb3dlcl9tZ210KCkiIG9yIGNvbXBp
bGUgdGhlIGtlcm5lbA0KPiB3aXRoIENGRzgwMjExX0RFRkFVTFRfUFMgZGlzYWJsZWQuDQoNCkkg
YnVpbHQgYSB0aGUga2VybmVsIHdpdGggQ0ZHODAyMTFfREVGQVVMVF9QUyBkaXNhYmxlZCwgYnV0
IHRoZSBrZXJuZWwNCmVycm9yIG1lc3NhZ2VzIHN0aWxsIGFwcGVhci4NCg0KDQpSZWdhcmRzDQpD
aHJpc3RvcGgNCg==
