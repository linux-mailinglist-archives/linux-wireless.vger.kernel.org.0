Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276C514A0BB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgA0J2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 04:28:35 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38253 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgA0J2f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 04:28:35 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: tWqGSKwFF8eM0EiQ0tnOgTJZ6qY1XtSGWCoGXRQBUzber2Fksg50++pCcAWhDyc6C9cykeKMJi
 3KmycayIrI0VhNRKzZZXhDR0Y4qLquWw+w395SlCNp/zChT92k9wywdP687DMK8nbeM0gyYY5I
 3Zu69Bp0b/IFnk8Mps8SS1J4geWuuIWzAkPYy5VSDuHTSQ4urOPU0h5WxTkpYxJG+2pG5cO2YI
 5+cbMKn2u6X1p0/gwKxAnpvXIURd3joCNjFJ4NmHhlQDEhTpiVxHxlX2e4c5RnceGCSCxQVs1f
 cFs=
X-IronPort-AV: E=Sophos;i="5.70,369,1574146800"; 
   d="scan'208";a="66108897"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2020 02:28:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Jan 2020 02:28:34 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 27 Jan 2020 02:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkxVsvizrl37leoChkF27NMc9JpBEc6+5LOxBgwpX1YDZg/W1IgQ6oqNgaew0qo6b6xKAkI3D5B/8JHPPzJ0gyUvN/Wd15xFmmu3uyCq03mJ0Qs0bi6F98BohG2qOavk5OxABS/NFTnjvHI9nt9VqimESz7Er4bgf5AcEntU7CWwiMBqQLKmGLNWurjPS5Ye6OmHgPcuyCucgaE/4zyLA6XNglZ7Mh7j6gFevuUmETPsi6GPrJR4bWNzPabG56dNfQ/Iv8EkZxwBxlRoWWfRvqMCzNbyB50IXIhKWA8RVniYxi6jJVcc2IDiympLBnLNE4ICntVt4nwXNrfiqTmmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms3i0zOqinvB9kQqoQrW6F/r0zdfNWAOxebZ//zfoi8=;
 b=YvVkcvLA+X/xDkxI2MUhRECUq2gF5cK67igN0WSf6aSEhrtupeQOW9uoVezSnsitTR3/zXTj0sfalB2nyMKwp+lpad66hGHFeO4Vub3ZGOX+0ZAciHAD6H4y1XIQMBS2x6YL1tMPWxAKRd4J0asTkYas5mw7mtYjfeRSsEhtgZTHL4qe+iNtLChfIXWJAQJGoohwr+REEdaw71ISBqIhBvzhiM2CARIYOlV8/mApOlokHS7Iv4S7gXnpMId+pUVS3Q+7cgwloufuvpPbn2k13ab3LE6NF6+Bg7ui2ScLq0+jmGz0uqTTDAc55UQSPytmzYPBVeHAVvOL29uZ9BWMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms3i0zOqinvB9kQqoQrW6F/r0zdfNWAOxebZ//zfoi8=;
 b=ROKB2D7u7eVUoHz1+F2/fdeF10ZoCcwyCaOqtqZHRGSQQbU4B9rCIwyHgtYZz1EObvj1cMjG/szNgUOuwo+iffVy+PeHX3hZV1vkT2mU4h4RLTpBqJSujzArFtn9mKlalYU5D5AxxDDR2x/ZmNjvmJ8sUG/XFkZjix8CotyhW64=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1938.namprd11.prod.outlook.com (10.175.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Mon, 27 Jan 2020 09:28:30 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:28:30 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>
Subject: Re: [PATCH 1/2] staging: wilc1000: return zero on success and
 non-zero on function failure
Thread-Topic: [PATCH 1/2] staging: wilc1000: return zero on success and
 non-zero on function failure
Thread-Index: AQHV0eu8bTZ/RdN5BkGJQfFUn4Ja4qf+JUiAgAB7XYA=
Date:   Mon, 27 Jan 2020 09:28:30 +0000
Message-ID: <5e0a781c-aa46-c41b-374f-566ed5630be8@microchip.com>
References: <20200123182129.4053-1-ajay.kathat@microchip.com>
 <20200127073701.GP1847@kadam>
In-Reply-To: <20200127073701.GP1847@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe8752d-1909-4328-0171-08d7a30b45d1
x-ms-traffictypediagnostic: BN6PR11MB1938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB19389075529703E2C865FCBCE30B0@BN6PR11MB1938.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(107886003)(91956017)(4326008)(31696002)(6916009)(81156014)(64756008)(66556008)(8936002)(66446008)(66946007)(81166006)(66476007)(2616005)(76116006)(6512007)(36756003)(186003)(6506007)(53546011)(2906002)(8676002)(5660300002)(86362001)(6486002)(26005)(54906003)(316002)(31686004)(71200400001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1938;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrJ5a549Yr7ggRc8heqAttyTSvOEvB8ujh3ePT5J+Ghi5fV5V7+F8VodTd/70MMdKq+8U6fOOZ/bo191qikyeUdalu3KjUf1Fx/WjPPUiLta+uQz/eVKkyvNOg37SSFK5MvhzmVzIQbHx+FgxIvHHctlOdKzSUEDxAk8naTJogd+Xm6jCztpkJ70/nkf0CHScaJ+l6qj70uugAsjR7sBmqHuqhIir06liCNIApnuB/FhHN+joLoUIxFcZkT7kNT6TUiI2qxHhYKSGuO3RDVkV9az9sEEshA5lAsNc+N4J2J/XJxBXmoXLv+iGOw7pNYt2YKCUArBxL5lFlQ8cL8pk/hQ0jO8nWpfQtw11GfOqMXbCs5rB7ssSb1koM2+j8kxYKZfeOHt8H6kus2canoMXDRq50KQN5G8mWwBvkeEENV5wfUwhC/oNw7ev7wDinyD
x-ms-exchange-antispam-messagedata: PO68DNxMLD7UGXA2RHZceOJfjuNTIWO2wBuP3Diyh4Y+qYUqXVyX1wC8HbJkZXp6x1Xz4enlkf9GH++kvTwbbf7JPgzYMMxMiHNJEI8NQcs2Fy0VGc1wFHIj43k/weIFR4mZDl0exGSKRiywu1hpRA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6658EF7714D5AB42A43AA3CDCC79AB8F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe8752d-1909-4328-0171-08d7a30b45d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 09:28:30.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cNxH0VKJ0y+F5e6mf7v6R6QBptWrq9mekZIfQocmv0FSA+oMFsSJNzG6jTx/01fKKe+Z3Mjj4WFR+/2ZZi9inAPxARVr8xiQN1HJRMYQiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1938
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuLA0KDQpPbiAyNy8wMS8yMCAxOjA3IHBtLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiAN
Cj4gTG9va3MgZ29vZC4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQG9yYWNsZS5jb20+DQo+IA0KPiBPbiBUaHUsIEphbiAyMywgMjAyMCBhdCAxMjo1MDo0
N1BNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gQEAgLTM4NCwx
OSArMzc4LDE4IEBAIHN0YXRpYyBpbnQgd2lsY19zZGlvX3dyaXRlX3JlZyhzdHJ1Y3Qgd2lsYyAq
d2lsYywgdTMyIGFkZHIsIHUzMiBkYXRhKQ0KPj4gICAgICAgICAgICAgICBjbWQuYWRkcmVzcyA9
IGFkZHI7DQo+PiAgICAgICAgICAgICAgIGNtZC5kYXRhID0gZGF0YTsNCj4+ICAgICAgICAgICAg
ICAgcmV0ID0gd2lsY19zZGlvX2NtZDUyKHdpbGMsICZjbWQpOw0KPj4gLSAgICAgICAgICAgICBp
ZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgIGlmIChyZXQpDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X2VycigmZnVuYy0+ZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIkZhaWxlZCBjbWQgNTIsIHJlYWQgcmVnICglMDh4KSAuLi5cbiIsIGFkZHIpOw0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4+IC0gICAgICAgICAgICAgfQ0KPiANCj4g
UGxlYXNlIGRvbid0IHJlc2VuZCwgYnV0IHRyeSB0byBhdm9pZCB0aGlzIHNvcnQgb2YgYW50aS1w
YXR0ZXJuIGluIHRoZQ0KPiBmdXR1cmUuICBZb3UncmUgdHJlYXRpbmcgdGhlIGxhc3QgZmFpbHVy
ZSBjb25kaXRpb24gaW4gdGhlIGZ1bmN0aW9uIGFzDQo+IHNwZWNpYWwuICBJbiB0aGlzIGNhc2Ug
aXQncyBwYXJ0aWN1bGFybHkgZGlmZmljdWx0IHRvIHJlYWQgYmVjYXVzZSB3ZQ0KPiBhcmUgZmFy
IGZyb20gdGhlIGJvdHRvbSBvZiB0aGUgZnVuY3Rpb24sIGJ1dCBldmVuIGlmIHdlIHdlcmUgcmln
aHQgYXQNCj4gdGhlIGJvdHRvbSwgSSB3b3VsZCB0cnkgdG8gYXZvaWQgaXQuDQo+IA0KPiBJIGFt
IGV4dHJlbWUgZW5vdWdoIHRoYXQgSSB3b3VsZCBhdm9pZCBldmVuIHRoaW5ncyBsaWtlOg0KPiAN
Cj4gICAgICAgICByZXQgPSBmcm9iKCk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAg
ICAgICAgIHByaW50ZigicmV0IGZhaWxlZFxuIik7DQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4g
DQo+IEluc3RlYWQgSSB3b3VsZCB3cml0ZToNCj4gDQo+ICAgICAgICAgcmV0ID0gZnJvYigpOw0K
PiAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgIHByaW50ZigicmV0IGZhaWxl
ZFxuIik7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgIH0NCj4gICAg
ICAgICByZXR1cm4gMDsNCj4gDQo+IEl0J3MganVzdCBuaWNlIHRvIGhhdmUgdGhlIGVycm9yIHBh
dGggYXQgaW5kZW50IGxldmVsIDIgYW5kIHRoZQ0KPiBzdWNjZXNzIHBhdGggYXQgaW5kZW50IGxl
dmVsIDEuICBBbmQgdGhlIG90aGVyIHRoaW5nIHRoYXQgSSBsaWtlIGlzIHRoZQ0KPiBCSUcgQk9M
RCAicmV0dXJuIDA7IiBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbi4gIFNvbWUgZnVuY3Rpb25z
IHJldHVybg0KPiBwb3NpdGl2ZSBudW1iZXJzIG9uIHN1Y2Nlc3Mgc28gaWYgSSBzZWUgInJldHVy
biByZXN1bHQ7IiB0aGVuIEkgaGF2ZSB0bw0KPiBsb29rIGJhY2sgYSBmZXcgbGluZXMgdG8gc2Vl
IGlmICJyZXN1bHQiIGNhbiBiZSBwb3NpdGl2ZS4NCj4gDQo+IFRoZSBvdGhlciBhbnRpLXBhdHRl
cm4gd2hpY2ggcGVvcGxlIG9mdGVuIGRvIGlzIHN1Y2Nlc3MgaGFuZGxpbmcNCj4gKGluc3RlYWQg
b2YgZXJyb3IgaGFuZGxpbmcpIGZvciB0aGUgbGFzdCBlcnJvciBjb25kaXRpb24gaW4gYSBmdW5j
dGlvbi4NCj4gDQo+ICAgICAgICAgcmV0ID0gb25lKCk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgcmV0ID0gdHdvKCk7DQo+ICAg
ICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAg
cmV0ID0gdGhyZWUoKTsNCj4gICAgICAgICBpZiAoIXJldCkNCj4gICAgICAgICAgICAgICAgIHJl
dCA9IGZvdXIoKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiANCg0KVGhhbmtzIGZvciB5b3Vy
IHVzZWZ1bCBhZHZpY2UgdG8gYXZvaWQgYW50aS1wYXR0ZXJuLiBJIHNoYWxsIGtlZXAgdGhlc2UN
CnBvaW50cyBpbiBtaW5kIHdoaWxlIHdvcmtpbmcgb24gZnV0dXJlIHBhdGNoZXMuDQoNClJlZ2Fy
ZHMsDQpBamF5
