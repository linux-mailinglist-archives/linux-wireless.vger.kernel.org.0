Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7920AC7B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgFZGrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 02:47:03 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:3342 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgFZGrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 02:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593154022; x=1624690022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ARKgUcNN7zHpsKX5KhiGVDAOHcN/29M8aA9xFW2/KS0=;
  b=YASS6lGO03J4Qy5BUmZ+CVCt6BVzwM63XbvY+FcU2UhDGqwc29oBQZmm
   bJ3UIsx+WqkRSQnBI9G+WJtNa/PKE9rowgCto4uC/QJSS2RpNptnOvzbW
   jrRSEI6prl1Y/cCRAh60tyxK+eNWfJI/qX9UbI6xK/CjXMsEaA17FTALy
   nugFp54+p/MrdT/jZph0SeDZXZF/V813y1kg7xWPmylLG6867mJEKiltr
   1gEBYLUabOmfZKqrktmEtYzRB8OWzhyCSpIMil3Nc1mtZwqwGfWEnkKu5
   6TwC4/oXfvwgHt9FV1rIYXrmWJsJ0GwGgMTulIw1XB1Tlcei3gRdaOWNU
   g==;
IronPort-SDR: 2WRTdirJ7opiC0j5REpDyuv0Q8ieRi4AXHiTe/K5ABBK+I//JyEoSnmCualeOzKvHbBrmz8tIk
 boycBNrKfC9Qwy9Y++LY4PHOKVxP5oy1Oq51VI06aJUd/c3PX0wRe362drpkUSr3lKzJffG/cT
 5GRDHii/9xBkTaTfKrQCwD2L29qeXTESQYK/kU2HXt2xBxFeAwDhLb++ZQdNDvjvTKLI25OG16
 MlZ90YQaImzajLq1PUMoz7dDDu9B8l3/R7QNHJZgrxiUl/comhYmkhhM4AJqBWoHSarcFIcCvX
 9ag=
X-IronPort-AV: E=Sophos;i="5.75,282,1589266800"; 
   d="scan'208";a="81667186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2020 23:47:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Jun 2020 23:47:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 25 Jun 2020 23:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBCHySua3yiqh5yU2UeeskjcYotymfBcX/xyDdJrV57HgiWTUedAON43f080m5NuSzbZpOShzUopTKUTco5bWZVgmcc+xhD6T9uf15mW6r5nghcdVo9XB58kOSn3Ob2Pzg9dn2nqVl/vNFdYt+i1MPNvnJe+v4diXRkb9/W+2e4Er+051Gj8UXabtdBol7XruPHWu2JW7831XmYwFPUODoMLtaYKg7sAJZRMHaf7Z/ArO//dubHLFC3IiM+G4zEt8u9iZcavAYtBNJim34nlCwatzOmbfvPDDmQZVsnM89Uyg28mf6qO0V2VDsGV8CDY9pWrxFjHDQnW9bQibZZxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARKgUcNN7zHpsKX5KhiGVDAOHcN/29M8aA9xFW2/KS0=;
 b=TgLQebGEnYbzpgY5KP7LKMyCSN1+5vQEmI1MmFpwwANjrATVeGX8Y4CKkN2a9+b0AtbQY01SvRRStX9BD3Uhz137dcBtuRXyNRgi+y6b54HXzKr8a/3yxIFJrspYQVtPKxsQrqMFeutoqKeH3WmzXe3wSNEqz+S5Kcg1A9QYIkEuaffr46Ea3uRPdY5ID0MXyMkKxjnnd8zSKGPcjbz3498uZ+NwqsAIjQKChKB3m8ZM0BlvzKnoGIB2HLQz9QUyutLWDu9jdHirWoGQhQXUAqGNScOTPUv0AcDkc5F+yt/OrpY+LhWnN+QQoKHtxOU4518aAWgWMKIMQwYEvuJElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARKgUcNN7zHpsKX5KhiGVDAOHcN/29M8aA9xFW2/KS0=;
 b=AIguSj8OoRR/Yvcw3i4MuYGSjVT1Sglx01+2PNV399PIu26YwjLz+vondEr0rkiGBB+9WuLuwZXcCUNW9e/4L/jAC3dDk/Y+d6IjRtfz4do4gimiyda4aJ0ieWFKomquWLvUNizZ0WGnjmZjFM7QdoIoLux9RiJHlCHUzqFAuYQ=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (10.255.181.224) by
 MN2PR11MB4032.namprd11.prod.outlook.com (20.179.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Fri, 26 Jun 2020 06:46:58 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Fri, 26 Jun 2020
 06:46:57 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
Thread-Topic: [PATCH] wilc1000: move wilc driver out of staging
Thread-Index: AQHWSu1f9HixhD7k+UOCPxtNASiGMqjqZfn4gAAPVgA=
Date:   Fri, 26 Jun 2020 06:46:57 +0000
Message-ID: <efd8f137-3709-8a03-67a3-723b2f2980fd@microchip.com>
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
 <87a70qe5na.fsf@tynnyri.adurom.net>
In-Reply-To: <87a70qe5na.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.206.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e47a70b-1a72-4e4f-9686-08d8199cb8d3
x-ms-traffictypediagnostic: MN2PR11MB4032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB403280E97E2A611F0A3E786BE3930@MN2PR11MB4032.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWogBWGLNfLplBcgmNXLdavuCOw3RuM7Ai6FH5aFSZi7O7vhJQU9j7Xjo7ZDYZ62QqflCeRPumJ5uKQi3ZZsh8rzRX+BAUxltz2lpNOtMbI9Ly3UvprCfomL52lGd8k93LPkwbc0f4waA6aC6DuAJWheOCuWe0ehoQcpSG9OJXn/0Z2/n2H3XASy6pvKn0NMz9X95IuHEfWDYduyjgiEfe2xJHuec+HC51iyEZHumHX+u7vIIjJuwCLUrAUYL+VK4JR2ZQtZA0F6OZD1d2FobucXzzYsY94HjvCM7hcZrycoHelw8eOFxdBQKtANlio0nYq5QzJ/lq3Z2K5k6hcalp/u0L/HzUjhQOM8nLbn7Vp3no61S8rzO0/IFnbM5uu26ef1aLKiiDJC58XfK9HrRrX5p55iRxVm389breLCw3Yib5Q2pBgdiWkoecolMPdYh4Es8U9QFRXKkhGzuUBDfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(31696002)(86362001)(26005)(8936002)(71200400001)(36756003)(53546011)(5660300002)(55236004)(186003)(83380400001)(6506007)(66946007)(6512007)(107886003)(6486002)(54906003)(6916009)(76116006)(966005)(91956017)(66476007)(66556008)(4326008)(31686004)(478600001)(8676002)(64756008)(316002)(66446008)(2616005)(2906002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PIa0FijxklolkXPgDHBh8AjaoKUsuScI9W4dXivkcx9/aj+z+e6H/wDYRG562n8Kn2mSf2neGW22I12n3FcFEnezosXK/dbVlOCaQgUyWYKsqMKiUUqoA9TWFf8EntKfK6vhnZ4DM2sVMDf4qjqOtkUQpoL/TDyoRQc1T7JnF+D1F5dGTM6M6IGNV7LeBHjobaR3N/01gC5gIlnUzEdfZkDcb8vX16vJB7eIwL95zvVTZJB+EPiIp5eQYGrA/wKWkVYDrb2CgPkx5eZxbbQzwhhw9xNhzfs2uVzzpR7I/Rl2zeN73wLuIqOAGr9kVP/7sCba/O+7t21PU1U3P5hokkMZeX6OS2hvY5j2HmNeGiIrHN+MIhPmJYRRx6w297ZIdUBpiqnsmVkrNufpObl4nXopkC3KYd1eJKR/x0QusskwQRrUpbJ0maHaq6HvGsW0iG+fsDu++hUKCVzQKEBkaDdUgkZUDj9N2XSVsgcCO7s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D81E4519837545908062196A203FF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47a70b-1a72-4e4f-9686-08d8199cb8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:46:57.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz85X+B5q3Wz2zAQDEZqOBh1kVYlbNjnwXt/258U/h3vuAbA8WXn+PsvwwvgkqD1EVUDpsGG927+iBALDntnfc4OzmYvta+HFP3f9I89xuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4032
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDI2LzA2LzIwIDExOjIxIGFtLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
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
Z25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBbLi4uXQ0KPiANCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL0tjb25maWcNCj4+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL0tjb25maWcNCj4+IEBAIC00Nyw2ICs0Nyw3IEBAIHNv
dXJjZSAiZHJpdmVycy9uZXQvd2lyZWxlc3Mvc3QvS2NvbmZpZyINCj4+ICBzb3VyY2UgImRyaXZl
cnMvbmV0L3dpcmVsZXNzL3RpL0tjb25maWciDQo+PiAgc291cmNlICJkcml2ZXJzL25ldC93aXJl
bGVzcy96eWRhcy9LY29uZmlnIg0KPj4gIHNvdXJjZSAiZHJpdmVycy9uZXQvd2lyZWxlc3MvcXVh
bnRlbm5hL0tjb25maWciDQo+PiArc291cmNlICJkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2No
aXAvS2NvbmZpZyINCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGluIGFscGhhYmV0aWNhbCBvcmRlci4N
Cj4gDQo+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9NYWtlZmlsZQ0KPj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvTWFrZWZpbGUNCj4+IEBAIC0xOSw2ICsxOSw3IEBAIG9iai0kKENP
TkZJR19XTEFOX1ZFTkRPUl9TVCkgKz0gc3QvDQo+PiAgb2JqLSQoQ09ORklHX1dMQU5fVkVORE9S
X1RJKSArPSB0aS8NCj4+ICBvYmotJChDT05GSUdfV0xBTl9WRU5ET1JfWllEQVMpICs9IHp5ZGFz
Lw0KPj4gIG9iai0kKENPTkZJR19XTEFOX1ZFTkRPUl9RVUFOVEVOTkEpICs9IHF1YW50ZW5uYS8N
Cj4+ICtvYmotJChDT05GSUdfV0xBTl9WRU5ET1JfTUlDUk9DSElQKSArPSBtaWNyb2NoaXAvDQo+
IA0KPiBBbmQgdGhpcyBhcyB3ZWxsLg0KPiANCj4gSSBmaXhlZCB0aGVzZSBpbiB0aGUgdG9waWMg
YnJhbmNoLCBwbGVhc2UgZG91YmxlIGNoZWNrOg0KDQoNClRoYW5rcyBLYWxsZS4NCkkganVzdCBj
aGVja2VkIHRoZSBwYXRjaCBhbmQgaXQgbG9va3MgZ29vZC4NCg0KUmVnYXJkcywNCkFqYXkNCg0K
DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9r
dmFsby93aXJlbGVzcy1kcml2ZXJzLW5leHQuZ2l0L2NvbW1pdC8/aD13aWxjMTAwMC1tb3ZlLW91
dC1vZi1zdGFnaW5nJmlkPTU2MjVmOTY1ZDc2NDRiNGRjNmE3MWQ3NDAyMWNmZTA5M2FkMzRlZWEN
Cj4gDQo+IEkgaGF2ZSBub3QgcHVsbGVkIHRoYXQgYnJhbmNoIHlldCBpbnRvIG1hc3RlciBzbyB3
ZSBjYW4gbWFrZSBjaGFuZ2VzDQo+IHN0aWxsLj4NCj4gLS0NCj4gaHR0cHM6Ly93aXJlbGVzcy53
aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRpbmdwYXRj
aGVzDQo+IA==
