Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5193F1903D7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCXDaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 23:30:14 -0400
Received: from mx3.watchguard.com ([63.251.166.21]:7143 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCXDaO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 23:30:14 -0400
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 23 Mar
 2020 20:30:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3
 via Frontend Transport; Mon, 23 Mar 2020 20:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIdbFnVV0tyZPU+qb2etnHJNfbOcKA3QFWknoZAzYJm8iKDAvkKLR46y1XMfSIHkJiRYdl3bHxCa+QdvTJr4804OrD2kvt3BSpv4pMGosmoPJWNhXjpVWwhXIFg5WuzvEuk9FF+MXVE5+f+YQnuDadjpue2WHnf4e2YOXBSqj4E3oOyZ/KCuVYn5Hi3ssS1O8TSbOhHbJA/a7Uo4sK3Tkg6OVklPzIL10tBf7S/RnqzsIT1mvygna6cvBtgEW4IqeFBKujcdIx4fcWbh6jcNrCEzKNUJwR+rHCePf8VYVTrY1/3fkgvADam+ARtxtDc6h9+fd+PDTgOEgLpoPmClmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8n6ryhXmxAhugH5tkwm+etT3FvSOpEWDY+9htkawQA=;
 b=Ce5KEkeGhPWNfXFQ+luFgE9hOs4MwkC/D97U/s28MwWDWb71qm97boCPs1/qHllnrsAJ8lpWMA08SvGERAxibCnxUJ0Y2+4WzSW0bNH47b4hvGtYucu9KW1hgApxflOTG4pm4cQBpKK0LuTu+urvxGzEFjtSP2cSz7A+xUnPMnfa5mSvtDq/yzVl08imL2TXd7DSsrMXXY2fQFw8kmUz/83EYQwKfYuLbRBSrNJQLklnowQhsoifdb4RBosN5OPpfR8sQiww2qP3oyROl1jEHOcd7Dq99YappqRbsQ4/7foBf0Y6p7L1D26XMjeiVp3VGv/Ip6HDepXMlrYZ6XNwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8n6ryhXmxAhugH5tkwm+etT3FvSOpEWDY+9htkawQA=;
 b=qTKRwUzjfgPtAXhZDqFnwzRcwucTwsjQzrB7HmOndEDH7conAnQDUQvcJ8SlTfIYCO8Oa27D0A5AHD9yq+BICHKUBW+7WZPriDfddptc5DrVrZ2MAnG6O6/D1zG8GNnrr2xSL8iA+kd3/AZnFQAHojI2AaM7OQmFpLkA3rld1+w=
Received: from BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24)
 by BN7PR10MB2755.namprd10.prod.outlook.com (2603:10b6:406:cb::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 03:30:10 +0000
Received: from BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128]) by BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 03:30:10 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Ben Greear <greearb@candelatech.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Joe Qiao <Joe.Qiao@watchguard.com>
Subject: RE: Firmware Crashed
Thread-Topic: Firmware Crashed
Thread-Index: AdX/0YxOsQET/+KrQn2mecR6d2iN5gAP8c6AAEdzTgAACoSDgAAC7fCAAAB/mAAAADKIYAAIeeSAAAAROwA=
Date:   Tue, 24 Mar 2020 03:30:10 +0000
Message-ID: <BN7PR10MB27376CD0C5F6C63D26C4EBA09AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
 <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
 <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <2e7adba4-7a4b-f306-b216-99b64d2f42ea@candelatech.com>
 <BN7PR10MB2737E8FB25C5D7738DAE917C9AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
 <7bea9719-76a0-2be2-ab6f-f3425b57dee9@candelatech.com>
In-Reply-To: <7bea9719-76a0-2be2-ab6f-f3425b57dee9@candelatech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [63.251.166.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2c93b17-9f0e-4dc5-5a26-08d7cfa3a878
x-ms-traffictypediagnostic: BN7PR10MB2755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR10MB2755F53F93E1C0ABA16A21E79AF10@BN7PR10MB2755.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(346002)(136003)(9686003)(53546011)(7116003)(2906002)(186003)(55016002)(6506007)(107886003)(55236004)(4326008)(86362001)(110136005)(26005)(54906003)(316002)(7696005)(33656002)(66476007)(66556008)(64756008)(76116006)(66946007)(5660300002)(66446008)(52536014)(8676002)(16799955002)(81166006)(81156014)(71200400001)(966005)(478600001)(3480700007)(15188155005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR10MB2755;H:BN7PR10MB2737.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCr5wZ/FKdOx7+G4mnOzhNdlY/Qz3yDPgxWLjeb8AnWFfd7EdtiGzqZIFLsZluvyEgZNI33CCos9TZKubAZQXGHuk1xOfb5AuJnYkJQ6hzTSk74Lxc0Jmx2Nws7x41JjxAFPr3e3mKNfihMWtjGdrXUOzYiNMroZYk+xhlEkKn+WlgEhhImLZKi38W7/EdI4BpTcnretPqdS06F+QPglUPR21LxwbuedZffMmnN+q/Mi+Oyk7frR8p6rxU1lvrioczDUumeoKevYO4WHi6lqEsHzQy/UOwL3FMjboJ9N68e0mq6tZYzWylJPFcfyPyi1Nkw0i2Erm1vNrewR1P1g+zdtvadlc8OnsgA7j43mYxxqr3KimeqhoT4qKe9aKTjQFq3L4R/q6NdCbJuBljcILwT2968j3gvfdmBlHJM4lCc/abXuPK8jL0MXiRZ+aAZhMSYYYPAK1tQSUQ6vgsVfIhdt4XFlyzxyoXg+DqHJOefRM+E6wpeKDoIojdSTmOjqaBIvQwIGxoDztKPaJGfJvg==
x-ms-exchange-antispam-messagedata: xwr3M9bsQftuPmn/lpjXgtuPmoIRNOuoT1UWGqMp31Ls/kQ8EjB8D9KydCg32QGKm99oItnCOfjTBH8LlSB9Bqz0ANBrLuLAbFN7cnsYIeeYxMoPMXlp9v5l6uL7oiNbNTXT8bTi5GdTOZlFWEfuIQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c93b17-9f0e-4dc5-5a26-08d7cfa3a878
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 03:30:10.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pY3Daq+XR5O+CGdTtb0j2N71IZJo/7ltlBkybf6xhGkaQlmyd3pmKOKfDNaQU/ROIuzyfXv1sUS7wZDP5uOh05DKm9ONtI/Oc4ts82jMXlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2755
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+Pj4+PiBObywgaXQgd2lsbCBiZSB2ZXJ5IGRpZmZpY3VsdCBmb3IgdXMgdG8gdXBncmFkZSB0
aGUga2VybmVsLg0KPiA+Pj4+PiBUaGlzIG1vZHVsZShRQ0E5OTg2IFBDSWUpIGlzIGZyb20gdGhl
IGEgdGhpcmQgcGFydHkgY29tcGFueS4gVGhleQ0KPiA+Pj4+PiBhcmUgdXNpbmcgdGhlIFFDQSBk
cml2ZXIgYW5kIGl0IHdvcmtzIHdlbGwuIFdlIGFyZSB0cnlpbmcgdG8NCj4gPj4+Pj4gaW50ZWdy
YXRlIHRoaXMgbW9kdWxlIHRvIG91ciBvd24gZGV2aWNlKFBQQy02NCArIEtlcm5lbCA0LjE0Ljgz
KS4NCj4gPj4+Pj4gV2UgZG9uJ3Qgd2FudCB0byB1cGdyYWRlIHRoZSBrZXJuZWwsIHNpbmNlIGl0
IHdpbGwgYmUgYSBodWdlDQo+ID4+Pj4+IGNoYWxsZW5nZSB3b3JrIGZvcg0KPiA+PiB1cy4NCj4g
Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhhbmtzDQo+ID4+Pj4+IE1pbmcgQ2hlbg0KPiA+Pj4+
Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IFRv
bSBQc3lib3JnIDxwb3plZ2EudG9taXNsYXZAZ21haWwuY29tPg0KPiA+Pj4+Pj4gU2VudDogU2F0
dXJkYXksIE1hcmNoIDIxLCAyMDIwIDExOjE2IFBNDQo+ID4+Pj4+PiBUbzogTWluZyBDaGVuIDxN
aW5nLkNoZW5Ad2F0Y2hndWFyZC5jb20+DQo+ID4+Pj4+PiBDYzogbGludXgtd2lyZWxlc3MgPGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZz4NCj4gPj4+Pj4+IFN1YmplY3Q6IFJlOiBGaXJt
d2FyZSBDcmFzaGVkDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gY2FuIHlvdSB0cnkgdG8gYm9vdCBpdCBp
biBhbm90aGVyIGRldmljZSBhbmQgdXNpbmcgc29tZSBkaXN0cm8NCj4gPj4+Pj4+IHRoYXQgaGFz
IDQuMTkgb3IgbGF0ZXIga2VybmVsIHdpdGhvdXQgYmFja3BvcnRzPw0KPiA+Pj4+Pg0KPiA+Pj4+
DQo+ID4+Pj4gTXkgc3VnZ2VzdGlvbiBpcyB0byB0cnkgaXQgaW4geDg2XzY0IFBDLiBUaGVuIHlv
dSBjYW4ganVzdCB1c2UgbGl2ZQ0KPiA+Pj4+IGxpbnV4IGRpc3RybyB3aXRoIGRpZmZlcmVudCBr
ZXJuZWwgdmVyc2lvbnMuIElmIGl0IGRvZXMgbm90IHdvcmsNCj4gPj4+PiB3aXRoIGFueSBvZiB0
aGVzZSB5b3UgbWF5IGhhdmUgcmFuIGludG8gYSBodyBidWcgc2FtcGxlLiBJZiBpdCBkb2VzDQo+
ID4+Pj4gd29yayB0aGVuIHlvdSBkb24ndCBuZWVkIHRvIHVwZGF0ZSB5b3VyIFBQQzY0IGtlcm5l
bCBidXQgZmluZCBhbg0KPiA+Pj4+IGFyY2hpdGVjdHVyZS9kZXZpY2Ugc3BlaWZpYyBidWcgdGhh
dCBwcmV2ZW50cyBpdCBmcm9tIGxvYWRpbmcuDQo+ID4+Pg0KPiA+Pj4gW01pbmcgQ2hlbl0NCj4g
Pj4+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIEkgZG9uJ3QgaGF2ZSBhIFBDIHdpdGggUENJ
ZSBzb2NrZXQgb24gbXkNCj4gPj4+IGhhbmQsIGJ1dA0KPiA+PiBpdCdzIGluZGVlZCB3b3J0aCB0
byBoYXZlIGEgdHJ5LiBJIHdpbGwgdHJ5IHRvIGZpbmQgYSBvbmUuDQo+ID4+DQo+ID4+IEluIGNh
c2UgeW91IHdhbnQgdG8gdHJ5IHRoZSBhdGgxMGstY3QgZmlybXdhcmUgZm9yIHlvdXIgY2hpcCwg
eW91IGNhbg0KPiA+PiBzZW5kIG1lIHRoZSBmaXJtd2FyZSBjcmFzaCBvdXRwdXQgYW5kIG1heWJl
IEkgY2FuIHVuZGVyc3RhbmQgd2h5IGl0IGlzDQo+IGNyYXNoaW5nLg0KPiA+Pg0KPiA+PiBodHRw
Oi8vd3d3LmNhbmRlbGF0ZWNoLmNvbS9hdGgxMGsucGhwDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4g
Pj4gQmVuDQo+ID4+DQo+ID4+IC0tDQo+ID4+IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRl
Y2guY29tPg0KPiA+PiBDYW5kZWxhIFRlY2hub2xvZ2llcyBJbmMgIGh0dHA6Ly93d3cuY2FuZGVs
YXRlY2guY29tDQo+ID4gW01pbmcgQ2hlbl0NCj4gPiBUaGFua3MgZm9yIHJlbWluZGluZy4gSSBq
dXN0IHJlYWxpemVkIHRoYXQgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgYm9hcmQtMi5iaW4gaW4NCj4g
YXRoMTBrIGRyaXZlciB3YXMgY29tbWVudGVkIG91dCBieSBzb21lb25lIG9mIG15IGNvbXBhbnks
IGFuZCBub3cgSQ0KPiByZXN0b3JlZCB0aGlzIGZ1bmN0aW9uYWxpdHkgaW4gYXRoMTBrIGRyaXZl
ci4gQnV0LCBmaXJtd2FyZSBpcyBzdGlsbCBjcmFzaGVkLCBhbmQgaXQNCj4gc2VlbXMgbGlrZSBp
dCBpcyBjYXVzZWQgYnkgZmFpbGluZyB0byBmZXRjaCBib2FyZCBkYXRhLiBUaGF0IGlzIHNhaWQs
IHRoZSBkcml2ZXINCj4gZmFpbGVkIHRvIGZpbmQgYSBtYXRjaGVkIChidXM9cGNpLGJtaS1jaGlw
LWlkPTAsYm1pLWJvYXJkLWlkPTExKSBib2FyZCBkYXRhDQo+IGZyb20gYm9hcmQtMi5iaW4uDQo+
ID4NCj4gPiBEb2VzIHRoYXQgbWVhbiB0aGUgdmVuZG9yIG9mIHRoaXMgd2lyZWxlc3MgbW9kdWxl
IGhhcyBub3QgY29tbWl0dGVkIHRoZWlyDQo+IGJvYXJkIGRhdGEgdG8gdXBzdHJlYW0gYW5kIGJ1
aWxkIHRvIGJvYXJkLTIuYmluIGZpbGU/DQo+ID4NCj4gPiBUaGUgYmVsb3cgaXMgdGhlIHBpZWNl
IG9mIEJNSSBsb2csDQo+ID4gWyA5MjE3LjM0MzIzM10gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6
IGJvb3QgdXBsb2FkIG90cCB0byAweDEyMzQgbGVuDQo+ID4gODk5OSBmb3IgYm9hcmQgaWQgWyA5
MjE3LjM0MzIzOV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJtaSBmYXN0DQo+ID4gZG93bmxv
YWQgYWRkcmVzcyAweDEyMzQgYnVmZmVyIDB4ODAwMDAwMDAwMDE4YTA4NCBsZW5ndGggODk5OSBb
DQo+ID4gOTIxNy4zNDMyNDJdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBibWkgbHogc3RyZWFt
IHN0YXJ0IGFkZHJlc3MNCj4gPiAweDEyMzQgWyA5MjE3LjM0MzgyOF0gYXRoMTBrX3BjaSAwMDAw
OjAxOjAwLjA6IGJtaSBseiBkYXRhIGJ1ZmZlcg0KPiA+IDB4ODAwMDAwMDAwMDE4YTA4NCBsZW5n
dGggODk5NiBbIDkyMTcuMzcyNTYxXSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDoNCj4gPiBibWkg
bHogZGF0YSBidWZmZXIgMHhjMDAwMDAwMDc1ODRmYTUwIGxlbmd0aCA0IFsgOTIxNy4zNzI3ODJd
DQo+ID4gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJtaSBseiBzdHJlYW0gc3RhcnQgYWRkcmVz
cyAweDAgWw0KPiA+IDkyMTcuMzcyODMxXSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm1pIGV4
ZWN1dGUgYWRkcmVzcyAweDEyMzQgcGFyYW0NCj4gPiAweDEwIFsgOTIxOC43ODMzODNdIGF0aDEw
a19wY2kgMDAwMDowMTowMC4wOiBibWkgY21kIHRvb2sgMzUzIGppZmZpZXMNCj4gPiBoeiAyNTAg
cmV0IDAgWyA5MjE4Ljc4MzM5Nl0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJtaSBleGVjdXRl
IHJlc3VsdA0KPiAweDJjMDAgWyA5MjE4Ljc4MzQwMV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6
IGJvb3QgZ2V0IG90cCBib2FyZCBpZCByZXN1bHQNCj4gMHgwMDAwMmMwMCBib2FyZF9pZCAxMSBj
aGlwX2lkIDAgZXh0X2JpZF9zdXBwb3J0IDAgWyA5MjE4Ljc4MzQwNV0NCj4gYXRoMTBrX3BjaSAw
MDAwOjAxOjAwLjA6IFNNQklPUyBiZGYgdmFyaWFudCBuYW1lIG5vdCBzZXQuDQo+ID4gWyA5MjE4
Ljc4MzQwOV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IERUIGJkZiB2YXJpYW50IG5hbWUgbm90
IHNldC4NCj4gPiBbIDkyMTguNzgzNDE1XSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogYm9vdCB1
c2luZyBib2FyZCBuYW1lDQo+ICdidXM9cGNpLGJtaS1jaGlwLWlkPTAsYm1pLWJvYXJkLWlkPTEx
Jw0KPiA+IFsgOTIxOC43ODM0MjBdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBib290IHVzaW5n
IGJvYXJkIG5hbWUNCj4gJ2J1cz1wY2ksYm1pLWNoaXAtaWQ9MCxibWktYm9hcmQtaWQ9MTEnDQo+
ID4gWyA5MjE4Ljc4MzkxNl0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGJvb3QgZncgcmVxdWVz
dA0KPiA+ICdhdGgxMGsvUUNBOTk4NC9odzEuMC9ib2FyZC0yLmJpbic6IDANCj4gDQo+IFRoaXMg
aXMgYWJvdXQgYSB3YXZlLTIgOTk4NCBOSUMuICBZb3Ugc3VyZSB5b3VycyBpcyA5ODg2IGNoaXBz
ZXQ/DQo+IA0KPiBUaGFua3MsDQo+IEJlbg0KPiANCj4gLS0NCj4gQmVuIEdyZWVhciA8Z3JlZWFy
YkBjYW5kZWxhdGVjaC5jb20+DQo+IENhbmRlbGEgVGVjaG5vbG9naWVzIEluYyAgaHR0cDovL3d3
dy5jYW5kZWxhdGVjaC5jb20NCltNaW5nIENoZW5dIFllYWgsIEkgYW0gc3VyZSBpdCBpcyBhIFFD
QTk5ODYgKG5vdCA5ODg2KSwgYW5kIEkgY2FuIHNlZSBpdHMgZGV2aWNlIElEIGlzIDE2OGM6MDA0
Ni4gQW5kIHRoZSBhdGgxMGsgd2lyZWxlc3MgZHJpdmVyIHdpbGwgdHJ5IHRvIGxvYWQgdGhlIGZp
cm13YXJlIGZyb20gdGhlIHBhdGggb2YgYXRoMTBrL1FDQTk5ODQvaHcxLjAgYnkgZGVmYXVsdC4g
U28gSSB0aG91Z2h0IHdlIHNob3VsZCB1c2UgdGhlIGJvYXJkIGJpbmFyeSBmaWxlIHNhbWUgYXMg
UUNBOTk4NCAoaHR0cHM6Ly9naXRodWIuY29tL2t2YWxvL2F0aDEway1maXJtd2FyZS9ibG9iL21h
c3Rlci9RQ0E5OTg0L2h3MS4wL2JvYXJkLTIuYmluKS4gDQpJcyB0aGVyZSBhIGJvYXJkIGJpbmFy
eSBmaWxlIGZvciBRQ0E5OTg2IHNwZWNpZmljYWxseT8NCg0K
