Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64904190486
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 05:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgCXEfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 00:35:31 -0400
Received: from mx3.watchguard.com ([63.251.166.21]:8814 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCXEfb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 00:35:31 -0400
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 23 Mar
 2020 21:35:29 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Mon, 23 Mar 2020 21:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVPF67MjFfMV/96D1QrDYlhsMc0IEEt5BbyE/dAhP4dwUkmOXgGqmWjht5+YGX5LJd/0xvglbuhymlRQN9JL0AFZ+Lyqi4uYDwfso17vFOd+2+BxGMBObdu+HjjDRubhpyxpYC1XqGBSLYP6Otvtgf+hV3KkWCZZXj2QG6Xq1//edIv0AC/AXE/qo26VPfZ/4t8q9BfwBqP2dJsFYb1LFhHtQ6yaCesha28ThP95dkvoe28lTj+W4iXH5NdMxZTRMi8fPh4jwzxXfhXRHQqcfqWvSXdi6Sf+6KNyo52fiiSELDGdUQu4i+BReSGLVFHV0RSv0Ax6uyvh+7F/nLa8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yptZn9w/Bxe+pQutJlzX0Etn/f6D6Qt83PS2dNve9wQ=;
 b=Xkos//x7Tdm0kLVo9orJ2+XCMBWWRIO9QxZeIWz4Ij/e1c5LnmXWB+amaaS0MnjqMNtL3nb/sJN0F6Sb9CnTRr8Br1v0Th8xUvLSLO+Yo07+rGex+DA3FbZIDcxpvWA+UQ119WyMMlXHi7VbvzCNo9VTHVq2iPBN8piR4DIoR7nGHqVPMfh8H4AwWqNDFukiQAUDsfXcfx6W7hrdBO67OYfeuoj31kqMll5LDf2GqSc0vCDfcwwa7baSf8d6II1Grl8Ljd8tqfuie4Hk7WdbYQ5GTiPXFDwOK3tbe1MQjPccJ/F2cVbrb5vB/mOVI9ZRb5P5IBxShx2zyipObDRtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yptZn9w/Bxe+pQutJlzX0Etn/f6D6Qt83PS2dNve9wQ=;
 b=dhBXPr3v7MrshLEHST1APO/6C5fBPjC2EmH4NNRWCGVLZynWjb9/GMmhxjj6TYYUs9akrLRqt354n1SgThOJ5rIg4dRuKFEmsoZ2iQ6ZidA2PsmEy/TweufCm8crU16NBOI1Efz2ADSbh5LItp3ym7/nW6LN1QIzzpkTbxUy08Y=
Received: from BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24)
 by BN7PR10MB2450.namprd10.prod.outlook.com (2603:10b6:406:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 04:35:26 +0000
Received: from BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128]) by BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 04:35:26 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Ben Greear <greearb@candelatech.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Joe Qiao <Joe.Qiao@watchguard.com>
Subject: RE: Firmware Crashed
Thread-Topic: Firmware Crashed
Thread-Index: AdX/0YxOsQET/+KrQn2mecR6d2iN5gAP8c6AAEdzTgAACoSDgAAC7fCAAAB/mAAAADKIYAAIeeSAAAAROwAAAcXLAAAA1oAA
Date:   Tue, 24 Mar 2020 04:35:26 +0000
Message-ID: <BN7PR10MB27371C9DB5BF632794781F849AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
 <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
 <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <2e7adba4-7a4b-f306-b216-99b64d2f42ea@candelatech.com>
 <BN7PR10MB2737E8FB25C5D7738DAE917C9AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
 <7bea9719-76a0-2be2-ab6f-f3425b57dee9@candelatech.com>
 <BN7PR10MB27376CD0C5F6C63D26C4EBA09AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
 <12c8ab18-869d-cf67-0c4a-e1524dd7ac98@candelatech.com>
In-Reply-To: <12c8ab18-869d-cf67-0c4a-e1524dd7ac98@candelatech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [63.251.166.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ca98445-c3d3-4577-ffa3-08d7cfacc678
x-ms-traffictypediagnostic: BN7PR10MB2450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR10MB245082FA422BB9D47D5D05559AF10@BN7PR10MB2450.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(376002)(136003)(346002)(7116003)(15188155005)(26005)(4326008)(186003)(6506007)(966005)(16799955002)(8676002)(81156014)(8936002)(55236004)(53546011)(107886003)(86362001)(81166006)(7696005)(52536014)(64756008)(5660300002)(76116006)(3480700007)(66476007)(316002)(55016002)(66556008)(33656002)(54906003)(110136005)(66946007)(71200400001)(66446008)(2906002)(9686003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR10MB2450;H:BN7PR10MB2737.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iON/dwV49dKy8ziMzbpHa2T9xKD7/dkRw7S68smRS/jJKlQoaNs8Jl/q4yRlTuV/X9FLBphvF9IAIJeVoeYGSEBEknuwbTZWupffkHXqbw4oMmcKBRvb2XCkGSBJgStTriTVyTpuw+UlsMvjCR4fz6zypmVvUs627fJLhUfTbkwlQ2icgnxz9YcL1ZMkDy5Mcl7u/wzBAvzLIEknWdjumlcKlWdSKFYyt2aAhUMVdQ0K6xA0uf+EjhpgeE92WytOPtYSJW+LolS4qowuAMD+Hro4xX67kqTbPxb3bYZ2s8ZbY1L7X23SUFykSbjT4rX4fzECY4cTJNoxkSLFqYaCLfIdSFAzxvYGWPG5D0E1AUPBfmKUSIkAR7jzDF/isR9QYTy68s7vrsKazaV24BuKpgDSiaf1CgVgQ8v+dMkhW4vZP7oj12y1/oiyTEYq/aeQCJOBcnS8bQbFaEgXbPEK3dD1aymYFK6RUeGv0BZSlGs1mw/gxRrzuehyweb3cfx/trstAUxK32CEo8TjZVjXGw==
x-ms-exchange-antispam-messagedata: 4bcj/u9KWlpOpdxBod+G4Ue2lMt13Uuc07TnUbI6zErTfThvN4qtk80EmWuMVcdE6pMSCyTSIjMxiXzpNukACdsRbLFElgbpR2Vr7Nmj+ZhYTTuYw9LpWBwfPouyw7fIXDCArypaB/VdwxYRWdFHFQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca98445-c3d3-4577-ffa3-08d7cfacc678
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 04:35:26.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFs2XDJTWvqC5K77SA5gZ3ofZi1IyYEdEYw4HrakIBe/n3CyXunkSE8B6QkcZD5/9D/xI2XRPntDimJOixGk02RFbcJ3szc74FW0SExDdOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2450
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+Pj4+Pj4+IE5vLCBpdCB3aWxsIGJlIHZlcnkgZGlmZmljdWx0IGZvciB1cyB0byB1cGdyYWRl
IHRoZSBrZXJuZWwuDQo+ID4+Pj4+Pj4gVGhpcyBtb2R1bGUoUUNBOTk4NiBQQ0llKSBpcyBmcm9t
IHRoZSBhIHRoaXJkIHBhcnR5IGNvbXBhbnkuDQo+ID4+Pj4+Pj4gVGhleSBhcmUgdXNpbmcgdGhl
IFFDQSBkcml2ZXIgYW5kIGl0IHdvcmtzIHdlbGwuIFdlIGFyZSB0cnlpbmcNCj4gPj4+Pj4+PiB0
byBpbnRlZ3JhdGUgdGhpcyBtb2R1bGUgdG8gb3VyIG93biBkZXZpY2UoUFBDLTY0ICsgS2VybmVs
IDQuMTQuODMpLg0KPiA+Pj4+Pj4+IFdlIGRvbid0IHdhbnQgdG8gdXBncmFkZSB0aGUga2VybmVs
LCBzaW5jZSBpdCB3aWxsIGJlIGEgaHVnZQ0KPiA+Pj4+Pj4+IGNoYWxsZW5nZSB3b3JrIGZvcg0K
PiA+Pj4+IHVzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBUaGFua3MNCj4gPj4+
Pj4+PiBNaW5nIENoZW4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+Pj4+Pj4+PiBGcm9tOiBUb20gUHN5Ym9yZyA8cG96ZWdhLnRvbWlzbGF2QGdt
YWlsLmNvbT4NCj4gPj4+Pj4+Pj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDIxLCAyMDIwIDExOjE2
IFBNDQo+ID4+Pj4+Pj4+IFRvOiBNaW5nIENoZW4gPE1pbmcuQ2hlbkB3YXRjaGd1YXJkLmNvbT4N
Cj4gPj4+Pj4+Pj4gQ2M6IGxpbnV4LXdpcmVsZXNzIDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc+DQo+ID4+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBGaXJtd2FyZSBDcmFzaGVkDQo+ID4+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+IGNhbiB5b3UgdHJ5IHRvIGJvb3QgaXQgaW4gYW5vdGhlciBkZXZpY2Ug
YW5kIHVzaW5nIHNvbWUgZGlzdHJvDQo+ID4+Pj4+Pj4+IHRoYXQgaGFzIDQuMTkgb3IgbGF0ZXIg
a2VybmVsIHdpdGhvdXQgYmFja3BvcnRzPw0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
TXkgc3VnZ2VzdGlvbiBpcyB0byB0cnkgaXQgaW4geDg2XzY0IFBDLiBUaGVuIHlvdSBjYW4ganVz
dCB1c2UNCj4gPj4+Pj4+IGxpdmUgbGludXggZGlzdHJvIHdpdGggZGlmZmVyZW50IGtlcm5lbCB2
ZXJzaW9ucy4gSWYgaXQgZG9lcyBub3QNCj4gPj4+Pj4+IHdvcmsgd2l0aCBhbnkgb2YgdGhlc2Ug
eW91IG1heSBoYXZlIHJhbiBpbnRvIGEgaHcgYnVnIHNhbXBsZS4gSWYNCj4gPj4+Pj4+IGl0IGRv
ZXMgd29yayB0aGVuIHlvdSBkb24ndCBuZWVkIHRvIHVwZGF0ZSB5b3VyIFBQQzY0IGtlcm5lbCBi
dXQNCj4gPj4+Pj4+IGZpbmQgYW4gYXJjaGl0ZWN0dXJlL2RldmljZSBzcGVpZmljIGJ1ZyB0aGF0
IHByZXZlbnRzIGl0IGZyb20gbG9hZGluZy4NCj4gPj4+Pj4NCj4gPj4+Pj4gW01pbmcgQ2hlbl0N
Cj4gPj4+Pj4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gSSBkb24ndCBoYXZlIGEgUEMgd2l0
aCBQQ0llIHNvY2tldCBvbg0KPiA+Pj4+PiBteSBoYW5kLCBidXQNCj4gPj4+PiBpdCdzIGluZGVl
ZCB3b3J0aCB0byBoYXZlIGEgdHJ5LiBJIHdpbGwgdHJ5IHRvIGZpbmQgYSBvbmUuDQo+ID4+Pj4N
Cj4gPj4+PiBJbiBjYXNlIHlvdSB3YW50IHRvIHRyeSB0aGUgYXRoMTBrLWN0IGZpcm13YXJlIGZv
ciB5b3VyIGNoaXAsIHlvdQ0KPiA+Pj4+IGNhbiBzZW5kIG1lIHRoZSBmaXJtd2FyZSBjcmFzaCBv
dXRwdXQgYW5kIG1heWJlIEkgY2FuIHVuZGVyc3RhbmQNCj4gPj4+PiB3aHkgaXQgaXMNCj4gPj4g
Y3Jhc2hpbmcuDQo+ID4+Pj4NCj4gPj4+PiBodHRwOi8vd3d3LmNhbmRlbGF0ZWNoLmNvbS9hdGgx
MGsucGhwDQo+ID4+Pj4NCj4gPj4+PiBUaGFua3MsDQo+ID4+Pj4gQmVuDQo+ID4+Pj4NCj4gPj4+
PiAtLQ0KPiA+Pj4+IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPiBDYW5kZWxh
IFRlY2hub2xvZ2llcyBJbmMNCj4gPj4+PiBodHRwOi8vd3d3LmNhbmRlbGF0ZWNoLmNvbQ0KPiA+
Pj4gW01pbmcgQ2hlbl0NCj4gPj4+IFRoYW5rcyBmb3IgcmVtaW5kaW5nLiBJIGp1c3QgcmVhbGl6
ZWQgdGhhdCB0aGUgZnVuY3Rpb25hbGl0eSBvZg0KPiA+Pj4gYm9hcmQtMi5iaW4gaW4NCj4gPj4g
YXRoMTBrIGRyaXZlciB3YXMgY29tbWVudGVkIG91dCBieSBzb21lb25lIG9mIG15IGNvbXBhbnks
IGFuZCBub3cgSQ0KPiA+PiByZXN0b3JlZCB0aGlzIGZ1bmN0aW9uYWxpdHkgaW4gYXRoMTBrIGRy
aXZlci4gQnV0LCBmaXJtd2FyZSBpcyBzdGlsbA0KPiA+PiBjcmFzaGVkLCBhbmQgaXQgc2VlbXMg
bGlrZSBpdCBpcyBjYXVzZWQgYnkgZmFpbGluZyB0byBmZXRjaCBib2FyZA0KPiA+PiBkYXRhLiBU
aGF0IGlzIHNhaWQsIHRoZSBkcml2ZXIgZmFpbGVkIHRvIGZpbmQgYSBtYXRjaGVkDQo+ID4+IChi
dXM9cGNpLGJtaS1jaGlwLWlkPTAsYm1pLWJvYXJkLWlkPTExKSBib2FyZCBkYXRhIGZyb20gYm9h
cmQtMi5iaW4uDQo+ID4+Pg0KPiA+Pj4gRG9lcyB0aGF0IG1lYW4gdGhlIHZlbmRvciBvZiB0aGlz
IHdpcmVsZXNzIG1vZHVsZSBoYXMgbm90IGNvbW1pdHRlZA0KPiA+Pj4gdGhlaXINCj4gPj4gYm9h
cmQgZGF0YSB0byB1cHN0cmVhbSBhbmQgYnVpbGQgdG8gYm9hcmQtMi5iaW4gZmlsZT8NCj4gPj4+
DQo+ID4+PiBUaGUgYmVsb3cgaXMgdGhlIHBpZWNlIG9mIEJNSSBsb2csDQo+ID4+PiBbIDkyMTcu
MzQzMjMzXSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm9vdCB1cGxvYWQgb3RwIHRvIDB4MTIz
NA0KPiA+Pj4gbGVuDQo+ID4+PiA4OTk5IGZvciBib2FyZCBpZCBbIDkyMTcuMzQzMjM5XSBhdGgx
MGtfcGNpIDAwMDA6MDE6MDAuMDogYm1pIGZhc3QNCj4gPj4+IGRvd25sb2FkIGFkZHJlc3MgMHgx
MjM0IGJ1ZmZlciAweDgwMDAwMDAwMDAxOGEwODQgbGVuZ3RoIDg5OTkgWw0KPiA+Pj4gOTIxNy4z
NDMyNDJdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBibWkgbHogc3RyZWFtIHN0YXJ0IGFkZHJl
c3MNCj4gPj4+IDB4MTIzNCBbIDkyMTcuMzQzODI4XSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDog
Ym1pIGx6IGRhdGEgYnVmZmVyDQo+ID4+PiAweDgwMDAwMDAwMDAxOGEwODQgbGVuZ3RoIDg5OTYg
WyA5MjE3LjM3MjU2MV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6DQo+ID4+PiBibWkgbHogZGF0
YSBidWZmZXIgMHhjMDAwMDAwMDc1ODRmYTUwIGxlbmd0aCA0IFsgOTIxNy4zNzI3ODJdDQo+ID4+
PiBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm1pIGx6IHN0cmVhbSBzdGFydCBhZGRyZXNzIDB4
MCBbDQo+ID4+PiA5MjE3LjM3MjgzMV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJtaSBleGVj
dXRlIGFkZHJlc3MgMHgxMjM0DQo+ID4+PiBwYXJhbQ0KPiA+Pj4gMHgxMCBbIDkyMTguNzgzMzgz
XSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm1pIGNtZCB0b29rIDM1Mw0KPiA+Pj4gamlmZmll
cyBoeiAyNTAgcmV0IDAgWyA5MjE4Ljc4MzM5Nl0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJt
aQ0KPiA+Pj4gZXhlY3V0ZSByZXN1bHQNCj4gPj4gMHgyYzAwIFsgOTIxOC43ODM0MDFdIGF0aDEw
a19wY2kgMDAwMDowMTowMC4wOiBib290IGdldCBvdHAgYm9hcmQgaWQNCj4gPj4gcmVzdWx0DQo+
ID4+IDB4MDAwMDJjMDAgYm9hcmRfaWQgMTEgY2hpcF9pZCAwIGV4dF9iaWRfc3VwcG9ydCAwIFsg
OTIxOC43ODM0MDVdDQo+ID4+IGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBTTUJJT1MgYmRmIHZh
cmlhbnQgbmFtZSBub3Qgc2V0Lg0KPiA+Pj4gWyA5MjE4Ljc4MzQwOV0gYXRoMTBrX3BjaSAwMDAw
OjAxOjAwLjA6IERUIGJkZiB2YXJpYW50IG5hbWUgbm90IHNldC4NCj4gPj4+IFsgOTIxOC43ODM0
MTVdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBib290IHVzaW5nIGJvYXJkIG5hbWUNCj4gPj4g
J2J1cz1wY2ksYm1pLWNoaXAtaWQ9MCxibWktYm9hcmQtaWQ9MTEnDQo+ID4+PiBbIDkyMTguNzgz
NDIwXSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm9vdCB1c2luZyBib2FyZCBuYW1lDQo+ID4+
ICdidXM9cGNpLGJtaS1jaGlwLWlkPTAsYm1pLWJvYXJkLWlkPTExJw0KPiA+Pj4gWyA5MjE4Ljc4
MzkxNl0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJvb3QgZncgcmVxdWVzdA0KPiA+Pj4gJ2F0
aDEway9RQ0E5OTg0L2h3MS4wL2JvYXJkLTIuYmluJzogMA0KPiA+Pg0KPiA+PiBUaGlzIGlzIGFi
b3V0IGEgd2F2ZS0yIDk5ODQgTklDLiAgWW91IHN1cmUgeW91cnMgaXMgOTg4NiBjaGlwc2V0Pw0K
PiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IEJlbg0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiBCZW4gR3Jl
ZWFyIDxncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbT4NCj4gPj4gQ2FuZGVsYSBUZWNobm9sb2dpZXMg
SW5jICBodHRwOi8vd3d3LmNhbmRlbGF0ZWNoLmNvbQ0KPiA+IFtNaW5nIENoZW5dIFllYWgsIEkg
YW0gc3VyZSBpdCBpcyBhIFFDQTk5ODYgKG5vdCA5ODg2KSwgYW5kIEkgY2FuIHNlZSBpdHMNCj4g
ZGV2aWNlIElEIGlzIDE2OGM6MDA0Ni4gQW5kIHRoZSBhdGgxMGsgd2lyZWxlc3MgZHJpdmVyIHdp
bGwgdHJ5IHRvIGxvYWQgdGhlDQo+IGZpcm13YXJlIGZyb20gdGhlIHBhdGggb2YgYXRoMTBrL1FD
QTk5ODQvaHcxLjAgYnkgZGVmYXVsdC4gU28gSSB0aG91Z2h0IHdlDQo+IHNob3VsZCB1c2UgdGhl
IGJvYXJkIGJpbmFyeSBmaWxlIHNhbWUgYXMgUUNBOTk4NA0KPiAoaHR0cHM6Ly9naXRodWIuY29t
L2t2YWxvL2F0aDEway0NCj4gZmlybXdhcmUvYmxvYi9tYXN0ZXIvUUNBOTk4NC9odzEuMC9ib2Fy
ZC0yLmJpbikuDQo+ID4gSXMgdGhlcmUgYSBib2FyZCBiaW5hcnkgZmlsZSBmb3IgUUNBOTk4NiBz
cGVjaWZpY2FsbHk/DQo+IA0KPiBPaywgSSBtaXMtcmVhZCB5b3VyIGVhcmxpZXIgZW1haWwuDQo+
IA0KPiBZb3UgZG8gbmVlZCBhIGJvYXJkIGZpbGUgdGhhdCBtYXRjaGVzIHlvdXIgY2FyZC4gIFRo
ZSBOSUMgdmVuZG9yIHNob3VsZCBiZQ0KPiBhYmxlIHRvIHByb3ZpZGUgdGhpcywgYnV0IHlvdSBt
YXkgaGF2ZSB0byBwYWNrYWdlIGl0IGluIGJvYXJkMi5iaW4gZm9ybWF0LiAgSQ0KPiB0aGluayB0
aGUgYXRoMTBrLWZpcm13YXJlIGdpdCBwcm9qZWN0IGhhcyBzb21lIHNjcmlwdHMgaW4gaXQgdG8g
ZG8gdGhlDQo+IHBhY2thZ2luZy4uLm9yIGdvb2dsZSBjYW4gcHJvYmFibHkgZmluZCBhIGxpbmsu
DQo+IA0KPiBUaGFua3MsDQo+IEJlbg0KPiANCj4gLS0NCj4gQmVuIEdyZWVhciA8Z3JlZWFyYkBj
YW5kZWxhdGVjaC5jb20+DQo+IENhbmRlbGEgVGVjaG5vbG9naWVzIEluYyAgaHR0cDovL3d3dy5j
YW5kZWxhdGVjaC5jb20NCltNaW5nIENoZW5dIA0KVGhhbmtzLiBJIGdvdCB0aGUgd2lraSBwYWdl
IG9mIGF0aDEwayBmb3IgYm9hcmQgZmlsZXMgKGh0dHBzOi8vd2lyZWxlc3Mud2lraS5rZXJuZWwu
b3JnL2VuL3VzZXJzL2RyaXZlcnMvYXRoMTBrL2JvYXJkZmlsZXMpLiBUaGUgaW5mb3JtYXRpb24g
bWFrZSBzZW5zZSB0byBtZS4gSnVzdCBhIGNvdXBsZSBvZiBxdWVzdGlvbnMsIA0KV2hhdCBjb250
ZW50IHNob3VsZCB0aGUgYm9hcmQgZmlsZSBiZSBpbmNsdWRlZD8gDQpIb3cgdG8gYnVpbGQgdGhl
IGFjdHVhbCBib2FyZCBmaWxlIChib2FyZC5iaW4pPyANClRoZW4gd2UgY2FuIGFzayB0aGUgTklD
IHZlbmRvciB0byBwcm92aWRlIHRoZSByZWxhdGl2ZSBpbmZvcm1hdGlvbi4gDQoNCg0K
