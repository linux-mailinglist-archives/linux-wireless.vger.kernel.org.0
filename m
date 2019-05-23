Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7F2842D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfEWQpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 12:45:08 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:30091 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfEWQpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 12:45:08 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,503,1549954800"; 
   d="scan'208";a="32707969"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 May 2019 09:45:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 23 May 2019 09:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiKT9VMgtMh8zUTG7RqF/W+sJPHeoYkUb6M1Cz8wmLk=;
 b=X9Ab3KLxMGaS0Qla/W8v5hdzoCW6S+CjkKyIyKPZzndbTNDLTKKX39FAmbLQH+QhLz8+9sfwaSy1WIOOpxsK75gVhm0Yv/6ky2ydl070RtAwGjM2KDmKxFoWd8dMjGi9Iy3h2pUQ0BhAkjMZGEF7A/u8RY6WAz4zKjc5rmIrwlc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4129.namprd11.prod.outlook.com (10.255.128.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 23 May 2019 16:45:05 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::4cd5:b733:dc60:292f]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::4cd5:b733:dc60:292f%7]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 16:45:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
Thread-Topic: [PATCH 00/16] wilc1000: move out of staging
Thread-Index: AQHUwEbCCX3IcHjEkkah7YSVPvJ9TKYWSGkAgAABd3mAYw1+AIAADAJigAApwIA=
Date:   Thu, 23 May 2019 16:45:04 +0000
Message-ID: <fb17fb6b-08d2-6871-d214-2fbcc1da73fb@microchip.com>
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
 <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
 <871s30pevc.fsf@codeaurora.org>
 <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
 <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0110.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::26)
 To BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.17.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b95ca84d-670d-4afb-e7b1-08d6df9e01ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR11MB4129;
x-ms-traffictypediagnostic: BN6PR11MB4129:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB4129D7AA1D7B7FD60FC727B9E3010@BN6PR11MB4129.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(14444005)(256004)(53546011)(6486002)(446003)(25786009)(6306002)(2906002)(6512007)(2616005)(54906003)(71200400001)(71190400001)(486006)(36756003)(8936002)(186003)(53936002)(31686004)(26005)(476003)(11346002)(68736007)(4326008)(6506007)(31696002)(386003)(86362001)(64756008)(229853002)(102836004)(72206003)(81156014)(7736002)(81166006)(966005)(8676002)(14454004)(5660300002)(478600001)(66556008)(3846002)(6436002)(6116002)(52116002)(66446008)(76176011)(66476007)(107886003)(6916009)(66946007)(6246003)(316002)(78486014)(99286004)(305945005)(73956011)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4129;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qraaBAN6PxMtZvWjIqtw69WT3v8q+Ca6kt/6b0Gu8itSp7xsn6ModNCxFe6ohOdiw4A4SFmk8S1GfgI0+GEq7i/TvpICWJqPHXosWqzwjFOhvzMuDWOB3QopKOQQ1iNfDCdQVjj11c3UxK9QMr1lVgE6JtD23WNVoqfQHXnGLtpCHRizIVI4iTSjRK+XNmPUHf4mbE4Ub5iV956E0bOiHqCKo8WR1Iciy/vLcKpGBLUYjB2dCNXYZ9l44RMTwTEWBw/2nLNXj7D904SwOK2YGMC93eaESNUpcjMXxNB55ep/vq/qwZN1mpIZ48N3FdyyixVn5uZLMVLYvg83K7yjKyVNbZOxTrlpadrlOZF5ebyw8SRFXtQM0NoI33woAytfsLVESMj7TZNbIawdq3G4ckb/rgdbrtLbxcLdJdOfQKo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE9B8C666364AC4793025FA02B29A817@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b95ca84d-670d-4afb-e7b1-08d6df9e01ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 16:45:05.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4129
X-OriginatorOrg: microchip.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDUvMjMvMjAxOSA3OjQzIFBNLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiA8
QWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbT4gd3JpdGVzOg0KPiANCj4+IEhpIEthbGxlLA0KPj4N
Cj4+IE9uIDMvMjEvMjAxOSA2OjI0IFBNLCBLYWxsZSBWYWxvIHdyb3RlOg0KPj4+DQo+Pj4gPEFq
YXkuS2F0aGF0QG1pY3JvY2hpcC5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBIaSBLYWxsZS9Kb2hh
bm5lcywNCj4+Pj4NCj4+Pj4gT24gMi85LzIwMTkgMTI6NDIgUE0sIEFqYXkgS2F0aGF0IC0gSTE1
NDgxIHdyb3RlOg0KPj4+Pj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlw
LmNvbT4NCj4+Pj4+DQo+Pj4+PiBUaGlzIHBhdGNoIHNlcmllcyBpcyB0byByZXZpZXcgYW5kIG1v
dmUgd2lsYzEwMDAgZHJpdmVyIG91dCBvZiBzdGFnaW5nLg0KPj4+Pj4gSW1wbGVtZW50ZWQgdGhl
IGluaXRpYWwgcmVjZWl2ZWQgcmV2aWV3IGNvbW1lbnRzWzFdIGFuZCBzdWJtaXR0aW5nIHRoZQ0K
Pj4+Pj4gZHJpdmVyIGFnYWluLiBEdXJpbmcgdGhpcyBjbGVhbnVwIGRlbGV0ZWQgYXJvdW5kIDMu
M2sgbGluZXMgb2YgY29kZS4NCj4+Pj4+DQo+Pj4+PiBCZWxvdyBhcmUgdGhlIG1ham9yIGl0ZW1z
IGZpeGVkIGluIHJlY2VudCBjbGVhbnVwOg0KPj4+Pj4gIC0gcmVtb3ZlIHVzZSBvZiBzaGFkb3cg
YnVmZmVyIHRvIGtlZXAgc2NhbiByZXN1bHQuDQo+Pj4+PiAgLSByZW1vdmUgaW50ZXJuYWwgbWVz
c2FnaW5nIGZsb3cgdG8gaGFuZGxlIGNmZzgwMjExX29wcy4NCj4+Pj4+ICAtIG1ha2UgdXNlIG9m
IGNmZzgwMjExIHByb3ZpZGVkIEFQSS4NCj4+Pj4+ICAtIHVzZSBzdHJ1Y3R1cmUgZm9yIHBhY2tp
bmcgZmlybXdhcmUgY29tbWFuZHMuDQo+Pj4+PiAgLSBtYWtlIHVzZSBvZiBrZXJuZWwgcHJvdmlk
ZWQgQVBJIGFuZCBtYWNyb3MuDQo+Pj4+PiAgLSByZW1vdmUgdW5uZWNlc3NhcnkgbG9ncyBtZXNz
YWdlcy4NCj4+Pj4+DQo+Pj4+PiBQZW5kaW5nIGFjdGlvbiBpdGVtOg0KPj4+Pj4gIC0gZHluYW1p
Y2FsbHkgYWRkL3JlbW92ZSBwMnAgaW50ZXJmYWNlLg0KPj4+Pj4NCj4+Pj4+ICBUaGlzIGl0ZW0g
d2lsbCB0YWtlIHNvbWUgdGltZSwgd2UgYXJlIHBsYW5uaW5nIHRvIHRha2UgaXQgdXAgYWZ0ZXIN
Cj4+Pj4+ICBtYWlubGluZS4NCj4+Pj4+DQo+Pj4+PiAgV2UgaG9wZSBpdCBjYW4gYmUgbW92ZSBv
dXQgc3RhZ2luZyBpbiB2NS4xLg0KPj4+Pj4gIFBsZWFzZSByZXZpZXcgYW5kIGNvbmZpcm0gaWYg
aXQgaXMgZ29vZCB0byBtb3ZlIG91dC4NCj4+Pj4NCj4+Pj4gRG8geW91IGhhdmUgYW55IHVwZGF0
ZSBmb3IgdGhpcyBzZXJpZXMuIFBsZWFzZSBwcm92aWRlIHlvdXIgaW5wdXRzIGZvcg0KPj4+PiBu
ZXh0IHN0ZXAuDQo+Pj4NCj4+PiBydHc4OCBpcyB0YWtpbmcgcHJpb3JpdHkgaW4gdGhlIG5ldyBk
cml2ZXJzICJxdWV1ZSIgc28gSSBkb3VidCBJIGNhbg0KPj4+IHRha2UgYSBsb29rIGF0IHRoaXMg
aW4gdGhlIG5leHQgZmV3IHdlZWtzLg0KPj4+DQo+Pg0KPj4gSXMgdGhlcmUgYW55IHVwZGF0ZSBm
b3Igd2lsYzEwMDAgZHJpdmVyIHJldmlldy4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXINCj4+IGlu
cHV0cy4NCj4gDQo+IFNvIGlzIHRoZSBkcml2ZXIgaW4gZ29vZCBzaGFwZSBub3c/IEkgcmVhbGx5
IGRvIG5vdCB3YW50IHRvIHVzZSBhIGxvdCBvZg0KPiB0aW1lIHJldmlld2luZyBpdCBqdXN0IHRv
IGZpbmQgb3V0IHRoYXQgdGhlcmUncyBhIGxvdCBvZiB3b3JrIHRvIGRvLiBGb3INCj4gZXhhbXBs
ZSwgaGFzIHNvbWVvbmUgZWxzZSByZXZpZXdlZCBpdD8NCj4gDQoNClRoZSBmaXJzdCBzZXJpZXMg
Zm9yIGNvbXBsZXRlIGRyaXZlciByZXZpZXcgd2FzIHN1Ym1pdHRlZCBlYXJsaWVyIFsxXS4NCkl0
IHdhcyByZXZpZXdlZCBieSBKb2hhbm5lcyBhbmQgaGUgbG9va2VkIGludG8gZHJpdmVyIGludGVn
cmF0aW9uIHdpdGgNCnRoZSBjZmc4MDIxMSBzdGFjayBwYXJ0LiBXZSB3b3JrZWQgb24gdGhlIHJl
dmlldyBjb21tZW50cyBhbmQgc3VibWl0dGVkDQp0aGUgY2hhbmdlcyB0byBzdGFnaW5nLg0KDQpX
ZSBuZWVkIGZ1cnRoZXIgcmV2aWV3IHRvIGlkZW50aWZ5IGlmIHRoZXJlIGlzIGFueSBibG9ja2Vy
IHRvIG1vdmUgdG8NCm1haW5saW5lLg0KDQpbMV0uIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL2xpbnV4LXdpcmVsZXNzL21zZzE3Nzg3OC5odG1sDQoNClJlZ2FyZHMsDQpBamF5DQo=
