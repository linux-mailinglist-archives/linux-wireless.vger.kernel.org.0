Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC4257B0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfEUSnh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 14:43:37 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:62723 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 14:43:37 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,496,1549954800"; 
   d="scan'208";a="34046847"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 11:43:36 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 21 May 2019 11:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8L7sQcUUreJzvv+KdquaYGZ3YdkFj/9QthmEThiJJY=;
 b=UQamTczc0Psv7OgHGjHPvAV3XBPUw17YR4UXAFlVcTuxupCIsOd4JBBPYptiVTmsEg8h0FUpr+0IuyEHkKgthlsg9WcPEsGFztbprFWbis638IagC4iGSCdNG2Ghg6pazeHlAmaidjams8+jTvZywaeWbQpsRaz99ZYSoX/pznc=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1327.namprd11.prod.outlook.com (10.169.237.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 21 May 2019 18:43:27 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::9ce9:4621:3c3f:a961]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::9ce9:4621:3c3f:a961%4]) with mapi id 15.20.1900.019; Tue, 21 May 2019
 18:43:27 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <colin.king@canonical.com>, <Ajay.Kathat@microchip.com>,
        <gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: remove redundant masking of pkt_offset
Thread-Topic: [PATCH] staging: wilc1000: remove redundant masking of
 pkt_offset
Thread-Index: AQHVD9egnn/gbMbCgE+l/pOShkDQxKZ16nWA
Date:   Tue, 21 May 2019 18:43:27 +0000
Message-ID: <f7460c62-2a44-df0d-afaf-04d1c990d2a1@microchip.com>
References: <20190521131706.30236-1-colin.king@canonical.com>
In-Reply-To: <20190521131706.30236-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 667d34e9-56cf-40e5-3e11-08d6de1c368a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1327;
x-ms-traffictypediagnostic: MWHPR11MB1327:
x-microsoft-antispam-prvs: <MWHPR11MB13272826BF33DD4C3F7F4F848D070@MWHPR11MB1327.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(53546011)(68736007)(4326008)(6506007)(256004)(110136005)(305945005)(386003)(7736002)(58126008)(64126003)(316002)(6116002)(3846002)(53936002)(14454004)(102836004)(52116002)(6512007)(5660300002)(6246003)(65826007)(2501003)(73956011)(25786009)(11346002)(76176011)(486006)(2616005)(66946007)(66446008)(64756008)(66556008)(66476007)(6436002)(476003)(71200400001)(71190400001)(26005)(31696002)(6486002)(86362001)(2201001)(8676002)(36756003)(478600001)(66066001)(65806001)(72206003)(81166006)(446003)(81156014)(8936002)(31686004)(99286004)(2906002)(65956001)(14444005)(229853002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1327;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8eCPFPERT7ZPRGwIFBzvDQMs5IzEce6BPjMHoArICZXRmho5o0xhS8OVZu5ASKNUFE21ydfsZdNZKPGFgUmcaqjBAKJb6WL14wj5i4jwRey8MYH+r9GfaD1sY6P1PXfcI3ZKb2TlCmNrgeoIZQ1VrZuHPvJLFVxt94khm1ba6pgDc9iOIiZil0xR7Ah0xiopg6kXiTjNBIsLp0wq+EPJDEDfz4aiZceyyP6VQOhEjXuwoTFCN5iNMB9q7D0JEoaLA8Z6xZzukPN6E98C4LCquVQ1KME+Js8PIGenQAJYKxR0GH5XdXE5rmugYHbbXKdCS9t+1ax8kdDfsJzzRoRBB+R3ZMRMSJjgKkxS8rwJ/ZPlfLDcFa0anfAfeGgemScUYTslWVgc5H5105kEToZLMdgLOQgKVaQVBNjjsLdi/x8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFFFBADA9DF8FD4CB170D5E21D1F32BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d34e9-56cf-40e5-3e11-08d6de1c368a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 18:43:27.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1327
X-OriginatorOrg: microchip.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiA1LzIxLzE5IDY6MTcgQU0sIENvbGluIEtpbmcgd3JvdGU6DQo+IEV4dGVybmFsIEUtTWFp
bA0KPg0KPg0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29t
Pg0KPg0KPiBUaGUgbWFza2luZyB1cGRhdGUgb2YgcGtnX29mZnNldCBpcyByZWR1bmRhbnQgYXMg
dGhlIHVwZGF0ZWQNCj4gdmFsdWUgaXMgbmV2ZXIgcmVhZCBhbmQgcGtnX29mZnNldCBpcyByZS1h
c3NpZ25lZCBvbiB0aGUgbmV4dA0KPiBpdGVyYXRpb24gb2YgdGhlIGxvb3AuICBDbGVhbiB0aGlz
IHVwIGJ5IHJlbW92aW5nIHRoZSByZWR1bmRhbnQNCj4gYXNzaWdubWVudC4NCj4NCj4gQWRkcmVz
c2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQoNClJldmlld2VkLWJ5OiBBZGhhbSBB
Ym96YWVpZCA8YWRoYW0uYWJvemFlaWRAbWljcm9jaGlwLmNvbT4NCg0KDQpUaGFua3MsDQoNCkFk
aGFtDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFuLmMgfCAz
IC0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFuLmMgYi9kcml2ZXJzL3N0YWdpbmcv
d2lsYzEwMDAvd2lsY193bGFuLmMNCj4gaW5kZXggOTVlYWY4ZmRmNGYyLi5kY2Q3Mjg1NTc5NTgg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dsYW4uYw0KPiAr
KysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFuLmMNCj4gQEAgLTcwOSw5ICs3
MDksNiBAQCBzdGF0aWMgdm9pZCB3aWxjX3dsYW5faGFuZGxlX3J4X2J1ZmYoc3RydWN0IHdpbGMg
KndpbGMsIHU4ICpidWZmZXIsIGludCBzaXplKQ0KPiAgCQkJYnJlYWs7DQo+ICANCj4gIAkJaWYg
KHBrdF9vZmZzZXQgJiBJU19NQU5BR01FTUVOVCkgew0KPiAtCQkJcGt0X29mZnNldCAmPSB+KElT
X01BTkFHTUVNRU5UIHwNCj4gLQkJCQkJSVNfTUFOQUdNRU1FTlRfQ0FMTEJBQ0sgfA0KPiAtCQkJ
CQlJU19NR01UX1NUQVRVU19TVUNDRVMpOw0KPiAgCQkJYnVmZl9wdHIgKz0gSE9TVF9IRFJfT0ZG
U0VUOw0KPiAgCQkJd2lsY193ZmlfbWdtdF9yeCh3aWxjLCBidWZmX3B0ciwgcGt0X2xlbik7DQo+
ICAJCX0gZWxzZSB7DQo=
