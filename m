Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF4211D03
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGBHaj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 03:30:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51445 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGBHag (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593675035; x=1625211035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UbsXvqA1Xhr/Ai4N8FnYZ9+dcxnKGhe5ZQL6IEeZrqQ=;
  b=eJYR1FTo78W1GrasOEdOAifVr51ojxUHgb71cnqwqXp0C0zC1/y3OSha
   RmdcQ5sB3yQR1rcbyxFEm/VGyh2mVqlqHW4Sn1jDdYxf0p+W5REVPtMWU
   A2/Di5C5Boln6KZfocs2BfLudrDHzU4CGWgVG5V4zMng6mo1TYtunohN+
   Md4ngeCo8ptwjbjqlocv8d/79oRp3mwlViWNxU/82xdwj0eap6HrmcjBe
   0CQGFeQ2ESzGiop6kWWw8CUQbDIY4OAowgdNmbczwRStjQAP27+ATtcXf
   33uVFdyeSI8SZMOGYFTN0DVvaah3iY1DcKvwMDwp3L6xdefda6QZeBRC9
   w==;
IronPort-SDR: XBDtDpIkXM6jLwv6w1kD8zWCNlALaJ+ok3ueqpikEVIfCBdLO57A1AntdAjAyGXSf00pglTsPK
 XlA/fO9aWi9rwnujky5HbEIMwN8X0QhJmMBo1a5L+9KEGB0Ws69wbwR0xX7X2J76ZPin6HllB+
 zXsgV/E/ow3TmoTnGut0D8ktW+oLdLdSyJLs+pUdbGQQxq4p9hvH9KyAaPHll67EWYx700MrJh
 pUtopy6sLjX0u0LqNlT7OrVGsn5TnaUy2rQUIrzPWNaaSPMCO8kCgf9S9NncoSBTmJJJpng0fx
 598=
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="85962205"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 00:30:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 00:30:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 2 Jul 2020 00:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6Da5ZwGAucbrrarFPNLgQkpGeLN2CSO0V8FDyxZ6yMbgHsiuP1tJ6Jj/tkO+fyZ0AaWt3h029NVB6jMyztUbNQKqZl+CiWVPnrOi3biswMtiCT9Y0pdlttOuaVH50UNKCNd87AzS8yWfFgPHKgk5UOqNQ3hUAY0eR6SVBd/OW3QwyixGF+/dC6cJXU/dCBQuVrOEEsHEgRvMpxehalVamqwTtqpbWyqL44hFQjIYKvXs/Ro4ku/HIJT001LwRjkbOMqTwyQAAVaf1t79WDBl1DL7zxrhCWdSy/7UdpFEL7gSDi/57aiB9b9JnlnV9I3CPXpDAucjbPGMGRSDHnZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbsXvqA1Xhr/Ai4N8FnYZ9+dcxnKGhe5ZQL6IEeZrqQ=;
 b=AfuTVOzNgi0vSQXgqyin0zScyAp0GE8FeoTlsk+3K9bIrjy84TG19cZI9+EKK69b95Y9kr1k2P2bieZb56nafLCXftDWPuzusvWeiFC+MSQvkCQ94JZktZsPqN5AeBsAd0SREuyCxdQDKOkGBtsVoU3eEIX/ioDgKGmpAKobOPzwqrGfAAJPQAB1pPELEDLGVLrQGPBtmoICjeu3vPGVOIdrMLo4KETPpzK7alIr0gQHVsz5cgms0pjWh458c0mz08zUhFaP4Q/0ansci0jMcIE+4BmJMMm4zafFW2i3XA7y2httGa4D4LlSipSxEwqQoEZUmujQeJ7+RK77XtbNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbsXvqA1Xhr/Ai4N8FnYZ9+dcxnKGhe5ZQL6IEeZrqQ=;
 b=NU3n5Sh0MKkgaMlZS8hVXPZWorswhsrRvLzRGq/5lBO6RSPJuq6/9MFftDjwQJt9TNPt7dE3K3maCVANim3skX9ZCUeDhq+/ca3L+/jbBeULTEvKWmrDkTm4PFJUKcw9wV9FEV972qj4agcNH5x8JbyIat06zxufDg8Lr4ft6XY=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3823.namprd11.prod.outlook.com (2603:10b6:208:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 07:30:31 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 07:30:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
Thread-Topic: [PATCH] wilc1000: move wilc driver out of staging
Thread-Index: AQHWSu1f9HixhD7k+UOCPxtNASiGMqjz52OQgAAIFQA=
Date:   Thu, 2 Jul 2020 07:30:31 +0000
Message-ID: <a09157e8-6464-9d48-5d5d-fc168e1b85dc@microchip.com>
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
 <875zb6e6zr.fsf@tynnyri.adurom.net>
In-Reply-To: <875zb6e6zr.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.198.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32cf921c-a19a-4cb7-5390-08d81e59cd4f
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823FA7517679D4FB95691CBE36D0@MN2PR11MB3823.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZs6D6wuXO8uQNcQUXZLYZpiJ6fJlyHGK7FEJXVk6RvkDBcHopXDs+1DsHFScGApW6LEpzvOKpJ2wV/VxEF3ED2Ke+8budMeuOWTSCgYeFCvm60nrbKj8cqEdUfquRItiRtL97fWYDFvnr09WrAICAvBthdO41Ce3ddJg4fDzxO2Oak1RmrWLDOM3DYDtoncpL52tAMLrtIvU8VKm8Yfs5CgZjA99xQ5d+c5bgo9/jZsHCyo+8BfGa5fFBate2Me20PONjI8xYA/xWdE9TWhJ7fjd5sMlXkwXlsoLGF4RlspE7Rx7e3bEjUl/CIv7KYpayKytI+zyqhA+iZzbYTB0t0eIVvN3/ZIIfEskQBkJSHTAnyOupzfCyZbb5Bj7jaSSXgXbpeKIeJ1AL47142Aqt1unO8SeVLnneVk/beEducHVnZfl8rGd9fHoJ7HICtL3ouvs3MtoPwQzeo3/PdePA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(66556008)(64756008)(6506007)(478600001)(4326008)(53546011)(107886003)(55236004)(86362001)(31686004)(8936002)(6512007)(316002)(5660300002)(2906002)(8676002)(91956017)(36756003)(54906003)(66946007)(66476007)(76116006)(31696002)(71200400001)(66446008)(2616005)(6486002)(186003)(26005)(6916009)(966005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b6CAqJ5gw5jE9N1mOHjH2yKKU2M31jOzHZypi2HuTt6ndfZYNzoTBombto79VMAZL320SnINDYa8oPDWSfGb18hDGo9jH7UN5iu//UQIC9bP7G3QipMgtZUKXvxla0gmbKvPTDJoYbk2WD5s/M0/eWn9N4p5TE1F3O15UywC1MzL7LgHv8VgvT/+2qzxQkYyanrWmsYqQnIOeiAlq3v/U2EupklwqqcFbdGLTKcBO7IiFUHSHIM8WKrmxHrfPhEkzeltnQ4jnEB2X3Vn1I3dFO2xeJQuLLlXlwC2xoRIreJGeZ7aopx9UfAhrHmhn+U6gZWHNjxU65hJVEpe1VqjGBpEzMR4dprfZ7M7W1W208ITEpa8uQF/YAuksXCuOXTSTJwOyIdOv1rlT+8ZYPobcAiPZtLXlzyV92SqhsLCdJXsYK6S2hoMMyj47et3nQr/9DkSKz+NPBrq9h3KVJga6jlDjlvygqYW6wbNcSAyqPE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C3FDED834C0A94CB64F0415FFB27B51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cf921c-a19a-4cb7-5390-08d81e59cd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 07:30:31.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+e1Njocz8hNZAcobUETLiT00QTvrwJ0arW2s5H+pWtvgJFUK5BXZxERa2erjvHL9/yRl0gxE0JdLAWXe7fPdrZCOl1j+WId67zmyBX6LNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDAyLzA3LzIwIDEyOjMwIHBtLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29t
PiB3cml0ZXM6DQo+IA0KPj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlw
LmNvbT4NCj4+DQo+PiBXSUxDMTAwMCBpcyBhbiBJRUVFIDgwMi4xMSBiL2cvbiBJb1QgbGluayBj
b250cm9sbGVyIG1vZHVsZS4gVGhlDQo+PiBXSUxDMTAwMCBjb25uZWN0cyB0byBNaWNyb2NoaXAg
QVZSL1NNQVJUIE1DVXMsIFNNQVJUIE1QVXMsIGFuZCBvdGhlcg0KPj4gcHJvY2Vzc29ycyB3aXRo
IG1pbmltYWwgcmVzb3VyY2UgcmVxdWlyZW1lbnRzIHdpdGggYSBzaW1wbGUNCj4+IFNQSS9TRElP
LXRvLVdpLUZpIGludGVyZmFjZS4NCj4+DQo+PiBXSUxDMTAwMCBkcml2ZXIgaGFzIGJlZW4gcGFy
dCBvZiBzdGFnaW5nIGZvciBmZXcgeWVhcnMuIFdpdGgNCj4+IGNvbnRyaWJ1dGlvbnMgZnJvbSB0
aGUgY29tbXVuaXR5LCBpdCBoYXMgaW1wcm92ZWQgc2lnbmlmaWNhbnRseS4gRnVsbA0KPj4gZHJp
dmVyIHJldmlldyBoYXMgaGVscGVkIGluIGFjaGlldmluZyB0aGUgY3VycmVudCBzdGF0ZS4NCj4+
IFRoZSBkZXRhaWxzIGZvciB0aG9zZSByZXZpZXdzIGFyZSBjYXB0dXJlZCBpbiAxICYgMi4NCj4+
DQo+PiBbMV0uIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzE1Mzc5NTc1
MjUtMTE0NjctMS1naXQtc2VuZC1lbWFpbC1hamF5LmthdGhhdEBtaWNyb2NoaXAuY29tLw0KPj4g
WzJdLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8xNTYyODk2Njk3LTgw
MDItMS1naXQtc2VuZC1lbWFpbC1hamF5LmthdGhhdEBtaWNyb2NoaXAuY29tLw0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+DQo+PiBBcyBzdWdnZXN0ZWQsIGtlZXBpbmcgYWxsIHRoZSBjaGFuZ2VzIGluIHNpbmds
ZSBjb21taXQgd2l0aCBmaWxlIHJlbmFtZQ0KPj4gc28gaXQncyBlYXN5IHRvIG1vdmUgb3V0IG9m
IHN0YWdpbmcgWzNdLg0KPj4NCj4+IFBsZWFzZSBjaG9vc2Ugd2hpY2hldmVyIG9wdGlvbiB5b3Ug
cHJlZmVyIGJldHdlZW4gdGhlIGdpdCBtdiBvciBwYXRjaCBzZXJpZXMNCj4+IHNlbnQgbGFzdCBU
dWVzZGF5LiBUaGUgcmVzdWx0aW5nIGRyaXZlciBpcyB0aGUgc2FtZSBhcyBubyBwYXRjaCBoYXMg
YmVlbg0KPj4gcXVldWVkIGluIGJldHdlZW4uDQo+Pg0KPj4gWzNdLiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIwMDYyMzExMDAwMC4zMTU1OS0xLWFqYXkua2F0aGF0
QG1pY3JvY2hpcC5jb20vDQo+IA0KPiBBcyBkaXNjdXNzZWQgd2l0aCBHcmVnIEkgY3JlYXRlZCBh
biBpbW11dGFibGUgYnJhbmNoIGZvciB0aGlzIGFuZCBtZXJnZWQNCj4gdGhlIGJyYW5jaCB0byB3
aXJlbGVzcy1kcml2ZXJzLW5leHQ6DQoNClRoYW5rcyBLYWxsZS4NCg0KDQpJZiBteSB1bmRlcnN0
YW5kaW5nIGlzIGNvcnJlY3QsIHdlIGhhdmUgdG8gdXNlICd3aXJlbGVzcy1kcml2ZXItbmV4dCcN
Cm1hc3RlciBicmFuY2ggdG8gc3VibWl0IG5ldyBwYXRjaGVzIGZvciB3aWxjMTAwMC4gcmlnaHQ/
DQoNCj4gDQo+IDU2MjVmOTY1ZDc2NCB3aWxjMTAwMDogbW92ZSB3aWxjIGRyaXZlciBvdXQgb2Yg
c3RhZ2luZw0KPiANCj4gR3JlZywgaGVyZSdzIHRoZSBsb2NhdGlvbiBvZiB0aGUgaW1tdXRhYmxl
IGJyYW5jaDoNCj4gDQo+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9rdmFsby93aXJlbGVzcy1kcml2ZXJzLW5leHQuZ2l0IHdpbGMxMDAwLW1vdmUtb3V0LW9m
LXN0YWdpbmcNCj4gDQo+IC0tDQo+IGh0dHBzOi8vd2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2Vu
L2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJtaXR0aW5ncGF0Y2hlcw0KPiA=
