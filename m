Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08466B42
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfGLK7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:59:07 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10341 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfGLK7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:59:06 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ZwE7WDJhBxvAflIS9SEuk4Dv8qEw9dSzVVj9L/9N6mcD8eNcXqao/CG7MHCubxPiiqNsIjujID
 JzBYfg5Wy4XRp2ihJsncsaW4VNYckYhjbG3dKp2f1PYwiQDZDv44omCwpFGpSC8Z3hZNEuG/0E
 UOOZlYXp0p8cTY6rRXxtCOcNX4v8DWHmgg+Sn+92osnRuVp5Fn2hj3NndOolKSUvcMzhAywUZK
 JpxaV6x93se4Ap+mxDuCOB7kG7WFbHlMRzA3juZvMxsj6KjxRCu+ALxpE2tnWP/JDzOyYuCLnk
 c30=
X-IronPort-AV: E=Sophos;i="5.63,482,1557212400"; 
   d="scan'208";a="41069167"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2019 03:59:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 12 Jul 2019 03:58:55 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Jul 2019 03:58:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpTZRcChYdkGe9+EGF5TYs4CZbBjWbenkObkFB8Zh0Y=;
 b=rdqlyQbVNTEsngz/IbSMqxeH28XtYJMJCaXbMzWmMAgQGnskAvMKlTKqdcwdlHHgjzg61SR7FFU4z8XgfCS7Csyw5ev9kvZSYK3qGv8yJkL23jwTLYhBZQ1UcU/7kKsF1fNPkf2Or0wWA8oRNXUepBbPQUQviZ0vdXXgD+5Wyhk=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1380.namprd11.prod.outlook.com (10.173.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 12 Jul 2019 10:58:53 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 10:58:53 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <Adham.Abozaeid@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 05/16] wilc1000: add wilc_wlan_cfg.c
Thread-Topic: [PATCH v2 05/16] wilc1000: add wilc_wlan_cfg.c
Thread-Index: AQHVOFVbjOwWdHElO0GO3dM32GKxnqbGlxQAgAA5lIA=
Date:   Fri, 12 Jul 2019 10:58:52 +0000
Message-ID: <c1b7691a-7504-938c-acb0-1d4f47c1bc75@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
 <1562896697-8002-6-git-send-email-ajay.kathat@microchip.com>
 <86bc79ccd379497d56bade79ec8f717603110ef7.camel@sipsolutions.net>
In-Reply-To: <86bc79ccd379497d56bade79ec8f717603110ef7.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::28) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [223.237.224.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa3d1af6-85fd-4a17-cb79-08d706b7ed62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1380;
x-ms-traffictypediagnostic: BN6PR11MB1380:
x-microsoft-antispam-prvs: <BN6PR11MB1380970A4491A20EF07301D7E3F20@BN6PR11MB1380.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(189003)(36756003)(305945005)(86362001)(316002)(8936002)(256004)(53546011)(386003)(102836004)(31696002)(7736002)(5660300002)(2616005)(476003)(11346002)(81166006)(14444005)(52116002)(81156014)(486006)(6506007)(446003)(8676002)(110136005)(66946007)(66066001)(14454004)(54906003)(66476007)(66446008)(66556008)(64756008)(71190400001)(68736007)(6116002)(3846002)(71200400001)(6246003)(25786009)(31686004)(478600001)(4326008)(2501003)(2906002)(99286004)(186003)(26005)(76176011)(229853002)(53936002)(6436002)(6486002)(107886003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1380;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 36Bm96eTgONYHiarRfOeyamHOvJX/6l90CXgzglyg1huRmut0a4/AA6K2OE5EAdlIk168XvtPqvvk5T855ErWC3np+tE5Dez2Kn2VnHMXEZzsVAfP0yROf2QLZiGhc2OhnuxMj6p3GVewqHCtG7aQ56UGAib+rZzbyn7IZJsywP3eU8JsMrBYbgqkhLPq8H2jw2FKV9KQ2yD47vcypQ2JGCxBEYS0inw4Tuby0sUqZvSO2+LwYg+8gPELRDTJznl/nBqpCknupppgsz8WEMjbLl+zQT4YbO8v2Ru833kb3Nmi7Eb0bN+Aj3Xr2CA2R1slWeGmCHWpKLbe1Dnv3aTsTl2iGb44n+3ldBGJN22ILKCBgifBQw1SVTMwOxDC8yh/6J1KI/Xu9U3SX2USYMc4g950qCwyR8v+ZZEn/prmMQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E550B8395FA9149B906C1C3F9E93AD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d1af6-85fd-4a17-cb79-08d706b7ed62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 10:58:53.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1380
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNClRoYW5rcyBhIGxvdCBmb3IgYWdhaW4gcmV2aWV3aW5nIG91ciBkcml2
ZXIuDQoNCk9uIDcvMTIvMjAxOSAxOjAxIFBNLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiBPbiBG
cmksIDIwMTktMDctMTIgYXQgMDE6NTggKzAwMDAsIEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+Pg0KPj4gKwlidWZbMF0gPSAodTgpaWQ7DQo+PiArCWJ1ZlsxXSA9ICh1OCkoaWQg
Pj4gOCk7DQo+PiArCWJ1ZlsyXSA9IDI7DQo+PiArCWJ1ZlszXSA9IDA7DQo+PiArCWJ1Zls0XSA9
ICh1OCl2YWwxNjsNCj4+ICsJYnVmWzVdID0gKHU4KSh2YWwxNiA+PiA4KTsNCj4gDQo+IFRoZXJl
IGFyZSBoZWxwZXJzIGZvciB0aGF0LCBwdXRfbGUxNl91bmFsaWduZWQoKSBvciBzbz8NCj4gDQoN
ClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IGFuZCBJIHdpbGwgbW9kaWZ5IHRoZSBzYW1lLg0KDQo+
PiArCQkJCWlmICh3LT5pZCA9PSB3aWQpIHsNCj4+ICsJCQkJCXctPnZhbCA9IGdldF91bmFsaWdu
ZWRfbGUzMigmaW5mb1s0XSk7DQo+IA0KPiBZb3UgdXNlIHRoZSBvcHBvc2l0ZSBvbmUgaGVyZSA6
LSkNCj4gDQoNCkFzIEkgc2VlLCB0aGUgZGF0YSByZWNlaXZlZCBmcm9tIHRoZSBmaXJtd2FyZSBp
biAqbGUqIGZvcm1hdCwgd2hpY2ggaXMNCnBhcnNlZCBpbiB3aWxjX3dsYW5fcGFyc2VfcmVzcG9u
c2VfZnJhbWUoKS4gU28gdG8gZXh0cmFjdCB2YWx1ZSBpbg0KY29ycmVjdCBieXRlb3JkZXIgd2Ug
c2hvdWxkIHVzZSBnZXRfdW5hbGlnbmVkX2xlMzIoKS4gcmlnaHQ/DQoNCj4+ICsJLyoNCj4+ICsJ
ICogVGhlIHZhbGlkIHR5cGVzIG9mIHJlc3BvbnNlIG1lc3NhZ2VzIGFyZQ0KPj4gKwkgKiAnUicg
KFJlc3BvbnNlKSwNCj4+ICsJICogJ0knIChJbmZvcm1hdGlvbiksIGFuZA0KPj4gKwkgKiAnTicg
KE5ldHdvcmsgSW5mb3JtYXRpb24pDQo+PiArCSAqLw0KPj4gKw0KPj4gKwlzd2l0Y2ggKG1zZ190
eXBlKSB7DQo+IFsuLi5dDQo+IA0KPj4gKwljYXNlICdTJzoNCj4gDQo+IEhtbS4gOi0pDQo+IA0K
DQpZZXMsIHRoZSBjb21tZW50cyBoYXMgbm90IGNhcHR1cmUgYWJvdXQgJ1MnIG1lc3NhZ2UgdHlw
ZS4gJ1MnIHR5cGUgaXMNCnVzZWQgdG8gbm90aWZ5IHNjYW4gY29tcGxldGVkIGZyb20gZmlybXdh
cmUgdG8gaG9zdC4NCg0KPj4gKwl3bC0+Y2ZnLnN0cl92YWxzID0gc3RyX3ZhbHM7DQo+PiArCS8q
IHN0b3JlIHRoZSBzdHJpbmcgY2ZnIHBhcmFtZXRlcnMgKi8NCj4+ICsJd2wtPmNmZy5zW2ldLmlk
ID0gV0lEX0ZJUk1XQVJFX1ZFUlNJT047DQo+PiArCXdsLT5jZmcuc1tpXS5zdHIgPSBzdHJfdmFs
cy0+ZmlybXdhcmVfdmVyc2lvbjsNCj4+ICsJaSsrOw0KPj4gKwl3bC0+Y2ZnLnNbaV0uaWQgPSBX
SURfTUFDX0FERFI7DQo+PiArCXdsLT5jZmcuc1tpXS5zdHIgPSBzdHJfdmFscy0+bWFjX2FkZHJl
c3M7DQo+PiArCWkrKzsNCj4+ICsJd2wtPmNmZy5zW2ldLmlkID0gV0lEX0FTU09DX1JFU19JTkZP
Ow0KPj4gKwl3bC0+Y2ZnLnNbaV0uc3RyID0gc3RyX3ZhbHMtPmFzc29jX3JzcDsNCj4+ICsJaSsr
Ow0KPj4gKwl3bC0+Y2ZnLnNbaV0uaWQgPSBXSURfTklMOw0KPj4gKwl3bC0+Y2ZnLnNbaV0uc3Ry
ID0gTlVMTDsNCj4gDQo+IEkgcmVhbGx5IGRvbid0IHVuZGVyc3RhbmQgdGhpcyBzdHlsZS4gV2h5
IG5vdCBnaXZlIGl0IGEgcHJvcGVyIHN0cnVjdA0KPiBhbmQganVzdCBzYXkNCj4gPiAJd2wtPmNm
Zy5hc3NvY19yc3AgPSBzdHJfdmFscy0+YXNzb2NfcnNwOw0KDQpBY3R1YWxseSwgV0lE4oCZcyBh
cmUgdXNlZCB0byBzZW5kIHRoZSBjb25maWd1cmF0aW9uIGRhdGEgZnJvbSBob3N0IHRvDQpmaXJt
d2FyZS4gSXRzIGdlbmVyaWMgYXBwcm9hY2ggdG8gbWFuYWdlIHRoZSBkaWZmZXJlbnQgc2l6ZSBv
ZiB3aWQuDQpUaGUgZGlmZmVyZW50IFdJROKAmXMgYXJlIGNhdGVnb3JpemVkIGJhc2VkIG9uIHRo
ZWlyIGRhdGEgc2l6ZS4NCkluc3RlYWQgb2YgbWFuYWdpbmcgZGlmZmVyZW50IHZhcmlhYmxlcyBm
b3IgZWFjaCBXSUQncyBpdHMga2VwdCB1bmRlcg0KdGhlIHNpbmdsZSBhcnJheS4gVGhlc2UgZW50
cmllcyBhcmUgbWFuYWdlZCBsaWtlICdpZCcgYW5kICd2YWx1ZScuDQoNCnN0cnVjdCB3aWxjX2Nm
ZyB7DQpzdHJ1Y3Qgd2lsY19jZmdfYnl0ZSAqYjsNCnN0cnVjdCB3aWxjX2NmZ19od29yZCAqaHc7
DQpzdHJ1Y3Qgd2lsY19jZmdfd29yZCAqdzsNCnN0cnVjdCB3aWxjX2NmZ19zdHIgKnM7DQpzdHJ1
Y3Qgd2lsY19jZmdfc3RyX3ZhbHMgKnN0cl92YWxzOw0KfTsNCg0KVGhlIDEtYnl0ZSBkYXRhIGFy
ZSBtYW5hZ2VkIGluIOKAmGLigJkgYXJyYXksICAyLWJ5dGUgaW4g4oCYaHfigJkgYXJyYXkgYW5k
IHNvDQpvbi4gU28gd2hlbmV2ZXIgdGhlIFdJRCBpcyBzZXQvZ2V0IGJ5IGhvc3QsIHRoZSBjb3Jy
ZXNwb25kaW5nIHZhbHVlIGFsc28NCmdldCB1cGRhdGVkIGluIHRoaXMgYXJyYXkgd2hpY2ggY2Fu
IGJlIGFjY2VzcyBsYXRlci4gVGhlIHJlc3BvbnNlIGZyb20NCmZpcm13YXJlIGFsc28gY29udGFp
bnMgdGhlIFdJRCBpZCB3aGljaCBpcyB1c2VkIHRvIHVkcGF0ZSB0aGUNCmNvcnJlc3BvbmRpbmcg
dmFsdWUuIFRoaXMgY2F0ZWdvcml6YXRpb24gaGVscHMgaW4gc2VhcmNoIGFuZCB1cGRhdGUgdGhl
DQpleGFjdCBXSUQgdmFsdWUgKndpbGNfY2ZnKiBzdHJ1Y3QuDQoNCg0KUmVnYXJkDQpBamF5DQoN
Cj4gPiBldGM/DQo+IA0KPiBqb2hhbm5lcw0KPiANCg==
