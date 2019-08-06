Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A8839B4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfHFTch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 15:32:37 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45273 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 15:32:37 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LmPF4wXQCPRNS0XPAbQtjwHNuOnRaa6pnBRx4FbtUZHIMOfVlhfajMt91RjLkFCNETcN5oLSX8
 Z7jXvfoQP3Dn7EblQWaDOZL+KqW3FwpMw/E34p4YaI0IXM8XBajhXtMUX51THQtHJS6eSpRNiL
 GUdScW9ZyoEDzPCHNMVGs3IUGbtlfplnoB7K3lWaxEilOSMmwlr0nofUPheji+6PxMwvzqWzTa
 B9UB/6VY92Gqp1loefbd01z7S1EiMbvMtMvocnLt1Sbrv0fImzjGsY9lUDViL1vc2HYIQ+3l5c
 6ZI=
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="43397239"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2019 12:32:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 12:32:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 12:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMgVapPYwht8VGcQXO8/i6l6ltHQbEjyQ323S2gsXx/wZrU+j9X5YTSqnSAEJl3b13tcKg+yn2txPgs1lPRyAMJQ0R/Wa1lV25tkz89cF2NUWmzEMPM/35Y/s0MksgUaJKjw2z+XojHkpv3H66IVRX7eSYYHFEMSy+i19CuDlOwb8ieL1fVIfKznOgd4rTaDvX3BUL8s8ZPb4SdOJ26KivHcZOBab0teaCrUuqcAK8spFN9OD4nrpe4+oBuNp9BJBMlS9X5N7YAxTrDssbO8+U/JIw7EkLfrubiu6AYGoWmgYGRkeqSKFtPXtUCKtMr1j8ihJt328TwrrfzPwMQ7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzTO0CwbreFbKe49+mV6LHnB1W3Eab20PYAVUCFQ+ss=;
 b=XybTLbbFD7elCdLK1F82g2mrno3XiTphWfZA3bMsPXvZZKZPGzdK8N0Uap06bCAsrNHEDoUdCa/OFQ1P8wzA8fHFeY24DGIYal3ZcQ3cHi0fZKjyhF9OUbsMn9pCA6Ezq2m24B62QN8uyhQMuG6+ar8AFVSTQMVKhjNM2vmyvgGrMzHCZvtsr+7RIXkbrEpIjd9y2TwZTIwjdz3x/JNYJ7fw6T44KtoBVK54u3MP1mMzoy/kwMHCnd/dYhicnYv2oOgp+urGwHdXwIvT0BqBUw9apU/xobnM3XKalUgaPgV1PNWNdu7vRYmdIYfY8mrrTbiKtGMvP+gThTJLyWeZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzTO0CwbreFbKe49+mV6LHnB1W3Eab20PYAVUCFQ+ss=;
 b=V8bWc+gRaEFPJHLg7m9CD6AohLo4ECHV/ZbeyuZ1Rb26bFJTSjGoCZBqEDeyckd/Wunh/mwP+I+GLCm6IDSExWy60IwdVwpbn+zDl6ItwLsVTgao1gSGmxEvxGkHLUE74coaSjahhELi6r2b81RFJi62TSeOwkpQRH3FeVD6yMs=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1357.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 19:32:09 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336%2]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 19:32:09 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: Re: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Topic: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Index: AQHVQzBVmkV0XiIfSkqdQ0TzXZfFVabuI64AgABuv4A=
Date:   Tue, 6 Aug 2019 19:32:08 +0000
Message-ID: <f0a3701c-39c3-1b95-3148-621b26d3f870@microchip.com>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
 <20190725213125.2810-4-adham.abozaeid@microchip.com>
 <20190806124656.GH1974@kadam>
In-Reply-To: <20190806124656.GH1974@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80790541-d3ae-4456-39ef-08d71aa4c56d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1357;
x-ms-traffictypediagnostic: MWHPR11MB1357:
x-microsoft-antispam-prvs: <MWHPR11MB1357D31362EE7B5D1B4B0E728DD50@MWHPR11MB1357.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(102836004)(305945005)(65826007)(5660300002)(54906003)(58126008)(66476007)(66446008)(64756008)(66556008)(99286004)(31686004)(65806001)(66066001)(65956001)(4326008)(66946007)(52116002)(25786009)(478600001)(6506007)(386003)(6512007)(229853002)(68736007)(6916009)(107886003)(86362001)(53546011)(6246003)(76176011)(316002)(6436002)(4744005)(31696002)(53936002)(6486002)(64126003)(8676002)(8936002)(7736002)(81156014)(81166006)(71200400001)(2906002)(26005)(3846002)(6116002)(256004)(14444005)(486006)(186003)(14454004)(11346002)(2616005)(476003)(446003)(71190400001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1357;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0lcblvlTQTTGVhd83yxLWkq6ZM4kK1ihUHIKmiM/6jc5JfAT8uFm2QPWPGp6fcb3oIptRCRTGdihgizbZi+eJtfNNCuXsurag7e1gLrtMbfjx+FCmIOKbQX+dBnXg9L7Cn5P5BpAOVVp6ZEBuHXrC625UZgA+i85e11YgvmTLf7nQ/uMUwM8Ju7r8lzDQjUCPWIrQ1oTtSaJU4JoOzF95cH72xvUgZ7hX3LHP5xFcUHsUqrcxA4cYy9geC8XIxJzUhFQTcBztYTdiPVn41MmJmRDGDAMKBVWAgIDgqXiOko/yL0njOQz/taTQKNzfNsQ2sHnFO3aiM23xDF4y69e4nDIyTWTDET2CB70pZelAshXrWy1pWfwk3PxzbZUZogTXNfySX7wgzl3w+7S0W7AqgV6Cc6elsDVIh3EjHQFd4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD2B8C269CF526418476B195FCD4B5B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80790541-d3ae-4456-39ef-08d71aa4c56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 19:32:08.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1357
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuDQoNCk9uIDgvNi8xOSA1OjQ2IEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4NCj4NCj4gT24gVGh1LCBKdWwgMjUsIDIwMTkgYXQgMDk6MzE6MzRQTSAr
MDAwMCwgQWRoYW0uQWJvemFlaWRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IEFkaGFt
IEFib3phZWlkIDxhZGhhbS5hYm96YWVpZEBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IHJlbW92ZSBv
YnRhaW5pbmdfaXAgZnJvbSBzdHJ1Y3Qgd2lsY192aWYNCj4+DQo+IEhvdyBpcyB0aGlzICJ1bnVz
ZWQiPyAgSXQgbG9va3MgbGlrZSBpdCBpcyB1c2VkIHRvIG1lLg0KVGhlIG1haW4gdXNhZ2Ugb2Yg
b2J0YWluaW5nX2lwIHdhcyB0byB0cmFjayB0aGUgaW5ldGFkZF9ub3RpZmllciBzdGF0dXMuDQpB
ZnRlciByZW1vdmluZyB0aGUgbm90aWZpZXIgYW5kIGlwIGFkZHJlc3MgdGltZW91dCB0aW1lciBp
biB0aGUgZmlyc3QgYW5kIHNlY29uZCBwYXRjaCwNCnRoZSByZW1haW5pbmcgdXNhZ2UgYmVjYW1l
IG1lYW5pbmdsZXNzLCBhbmQgY291bGQgYmUgcmVtb3ZlZC4NCj4gcmVnYXJkcywNCj4gZGFuIGNh
cnBlbnRlcg0KPg0KPg0KDQo=
