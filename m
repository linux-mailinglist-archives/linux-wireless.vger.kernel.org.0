Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB741C2D1E
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 16:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgECOwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 10:52:23 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38752 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgECOwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 10:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588517541; x=1620053541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q15gEN/Lb1j6CfXGd6Jws1AMU4jxMuOi8ziNU4gZ6z0=;
  b=0v5MMpTfTzP7xhlL9BjuNJFacxGe+W9TFEwwRzIHi39+UyNcpHjWoBMp
   +ZCh0VhagdNKJJP2Qiu4nY1YNDSsPu0exvYJSws+LlvjUW8sX9jWZcc7s
   Tfpr5/5U0nKP1yoe6oB1KevUJZgVurD351d5u0NRGAE8xwjXE/BDYtpiz
   zhQR3JgZR/BRhfWvgU3EcN5mWpeqy2YHUhKdDj2+t+AEgSHLkBH5eAvYf
   B48+q37LDdm/E5qjo382LCXvq3fO85HgwaWPDdyJGWTLdWwpu1Xok3gbR
   2mC6nudeo7mIJ13t5ku6EL0/zBodaa2O8MzQwk+e+6cBQK7IMSyyjyJrq
   g==;
IronPort-SDR: 5moeM1tAjtGoaeuOmw1tozXWuRLausFpDTL2CthhHd81bqg1BiHQv2KV68cgQYqJuMTczJoyCO
 szyY2MRwpSWzAfG0875y3+QDT0UYcti50YLOiIQRIPn44JgBRAmXGicWGWlmjZijc5Nzai/t73
 4OVVYzW1XIfcKPwJ9UbvJ1dauWhOdWKOW5A+i45hzXG5bJm2dVXJd/PcqnBGdtZ7/L0hF0uwSx
 veuOLC30edxt7TZudIJmOduqsIPHhfwOBUr+Ge2Ys62WFvCIpJPwkbp9f9WUD1aD9WX8NGGNfb
 PCA=
X-IronPort-AV: E=Sophos;i="5.73,347,1583218800"; 
   d="scan'208";a="72251061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2020 07:52:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 May 2020 07:52:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 3 May 2020 07:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmL01zVYzaCknjB+1hvYevGOxk0+BiuuBGy9JlJYkZysCmIaSkCwuwG4jmuWXR5FgPF3jxLJuexiJvWW7MeJf8XYOnqeLgmWzjnxJUcQmz3Z7aCKjiCJFKxI7TFdThtrlXpOGfJ8VWSTYbeTY46HNMskxtyTTAeTAFszGRAdJwGClDUzcygxKaKXE1aIXGsPkZBEXVTHwFaTcvjOP8vetHm88sIKu3dKUglJzJFa74CpUuEkdSYZQkRey2jcYimmIl1baafbKQd9r/TnfB+7qESCMu5X3vlnbtqM8Qa3IpcydmaCAbnwYfxD3nzd07wXW3nmVG5e5Yx44e6KYDV8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q15gEN/Lb1j6CfXGd6Jws1AMU4jxMuOi8ziNU4gZ6z0=;
 b=KQ4kZyTZSXPrOvw4cML2y3QTGO6fD5BSJdFWAguqqFiDVjFsbf39IWKPq3mDE/6yRKGt8KK6li3C00Q3R2zZVgVQORJyHJnynUh2l27N+ynpLwXknashmBkVyFnZDPFb1jL3VqetFzOyJjVJzWctSkxxWcYl9PVZBmjyIvXxhvIpN0+Qt83fP9XGVjKozX3Hb+pf0jHkv485QrWZFIqk9VD2ig27VptYtjY7dqx+wJ5MgpI+9DoxnRpR2pi2I3lGUPh6MGM0rvS/A9b6AhjoEgZVY9+16r3hD5LML7FoGJAy2T2KoPJ1L1Uapai4wPfnJ7xtgLlkLO1w4P8MuXh7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q15gEN/Lb1j6CfXGd6Jws1AMU4jxMuOi8ziNU4gZ6z0=;
 b=bdZOKPAChWKUUc1HN3lP0YumtODFi+K+28oQ41VyCtwpb+CjH3PBZOOO8SAY8RAmviTeaJZjKHOTed+seQBwEJ1pteaU+HZN/5Hvyc6neoXu5yR2D25eqBU+81ZFm7nK1ue0cQrO0zz088NB9waBHse0jujCM3GJx8DErVPXiRo=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2646.namprd11.prod.outlook.com (2603:10b6:a02:c6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Sun, 3 May
 2020 14:52:19 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::7c0f:1690:7a0d:151e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::7c0f:1690:7a0d:151e%6]) with mapi id 15.20.2958.027; Sun, 3 May 2020
 14:52:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <oscar.carter@gmx.com>, <adham.abozaeid@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <rachel.kim@atmel.com>,
        <johnny.kim@atmel.com>, <chris.park@atmel.com>,
        <dean.lee@atmel.com>, <linux-wireless@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: wilc1000: Increase the size of wid_list array
Thread-Topic: [PATCH v2] staging: wilc1000: Increase the size of wid_list
 array
Thread-Index: AQHWIR/JG/h3/9iPxkC7eX3Zc1g8RaiWcqGA
Date:   Sun, 3 May 2020 14:52:19 +0000
Message-ID: <d75b7f64-0ba0-65e9-ea4c-cc87b3a51a10@microchip.com>
References: <20200503075145.4563-1-oscar.carter@gmx.com>
In-Reply-To: <20200503075145.4563-1-oscar.carter@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [49.207.48.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e49eb02d-0411-4945-babe-08d7ef719452
x-ms-traffictypediagnostic: BYAPR11MB2646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26466F7C3B3976F26C6CFBAFE3A90@BYAPR11MB2646.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-forefront-prvs: 0392679D18
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMFslSpu7XdGAlBw0VSaBL31NRFOBBwXrIDR6tQsqMOGdeUl1myjRswODechOCO0DENnEKLVmlbXbWjZ+LQFeZisWl/xJ8tVWOel6oq6OakSaeI2gW0WOsi9yF/0+48gVixJ2ZdHuXx+sMNNRjl6RY8/j4v97pxBcR4K3nYT/cbfRnc0JKkuBbSJ3YnI3LNWi+JCVyH1hwAwH8+vyOseieYFWfqDqzvUd42otQW+ARcFJdvhlYyBIjeV54GnvmkQ4R9PcEvEpWHDSplnv96SMEkOcmZsBvmDMxt2eL6i7mkPXMbdm8m8ANKmh4ceN/gFiU6yLThl3H0/YtC2uhu9qVPrIKQHRulvmgWj0W4rn7OJD5T650K5V3T/5rjCOOqRR2QRde9ngi+tRhOcyt91WahAK1jev47DDM9orCjY6cfGKK7siMaJIBG/rG53jKS+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(396003)(39850400004)(346002)(186003)(66556008)(66446008)(66476007)(64756008)(26005)(31686004)(31696002)(55236004)(2906002)(2616005)(6506007)(36756003)(53546011)(8936002)(8676002)(6512007)(5660300002)(91956017)(86362001)(76116006)(66946007)(6636002)(6486002)(54906003)(71200400001)(4326008)(316002)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Oejkvl5lL/JKgFwJExc+SrcXVE3Qdt19jor6KHgHHNH2Hbxzo9Cce4+bGpkDzeZUj85+t19NPc54X/r/y9UM1ShDz7U+CKYrcDx+DZQIMHyC/DVkrh6KlusGNLZv07mub9jhsZvnUohZMeS3jlmDdCHf6YIUCV29k/fxH345n41aFaxY68uUzbnctuPw8i1DJSfUB/DFKeJhKGqBWBQSczRvYMMjWvNfZ5lX1LdS/csbnDTC7JY7d9UuDdbgFky1httZUoRBjNvc9ZUU64/5CtnZAK35jA9Yp2n1Kz/bs29vf3zpxwoHWirgAjkc2POLBNNAX5d0w3sxw7DadwDLrhyfeU+OLep4AmD0ysap5Yfa9lkMKubaRQOoMHv6vIsOlAzIW5+oQ00NFLodZ+BQEJoF2gMhLs9BB6/uP3Sn/vMRmmJUkl2XdKIf+rh7/cEMQW9uvhbx5JmAzKKpvJQLHk+Se3Z1xnYs7xT7nBkIngZoCaTI7H7/hSoI4rOkq7tBrRE330ka6E5n8Z/XtUOYr4YUv+PlXygXj1LD8BhaEQwlUTPADGOMcI5lEmPUrBPqcFW8gJRiImZaLySjGvBux+6oMEHJABez1fU2flzTc8jTZNfLlGqY2hlFYjEW6ELfi+R1dZFWGvOGOsWoIQo3o3gOL3d4FO/+8z0cu6li5CuHpdAwebXGiZNxrPCrCfr6uG0ExfzrfX9qhGurYjhf0be+Rv28LylyMKAeEcmNMBsRRlGXba5UYUe8joQBJARo5i2NPf92gJdx4FQnaTrfE6AM50vC1zaRNbyUgDv1bwg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F15515B00E2704E973CABAAB5044792@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e49eb02d-0411-4945-babe-08d7ef719452
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2020 14:52:19.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiAeuFCg32yoiwBMNfHE9CywLX3TYN9DeW8vKMQEtuh+jH5VE4bua5IYN8CbX8s/k0a0LiWfNm2J/gXi64FZaSybn8tTSSXdQx1YLq7rYB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2646
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDAzLzA1LzIwIDE6MjEgcG0sIE9zY2FyIENhcnRlciB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbmNyZWFzZSBieSBvbmUgdGhlIHNpemUg
b2Ygd2lkX2xpc3QgYXJyYXkgYXMgaW5kZXggdmFyaWFibGUgY2FuIHJlYWNoIGENCj4gdmFsdWUg
b2YgNS4gSWYgdGhpcyBoYXBwZW5zLCBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyBpcyBwZXJmb3Jt
ZWQuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDE0NTE5ODEgKCJPdXQtb2YtYm91bmRz
IGFjY2VzcyIpDQo+IEZpeGVzOiBmNWEzY2I5MGI4MDJkICgic3RhZ2luZzogd2lsYzEwMDA6IGFk
ZCBwYXNzaXZlIHNjYW4gc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IE9zY2FyIENhcnRlciA8
b3NjYXIuY2FydGVyQGdteC5jb20+DQoNCg0KVGhhbmtzIGZvciBtYWtpbmcgdGhlIGNoYW5nZXMu
DQoNCkFja2VkLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KDQoN
Cj4gLS0tDQo+IENoYW5nZWxvZyB2MSAtPiB2Mg0KPiAtIEZpeCB0aGUgY29tbWl0IGZvciB0aGUg
IkZpeGVzIiB0YWcgYXMgQWpheSBzdWdnZXN0ZWQuDQo+IA0KPiAgZHJpdmVycy9zdGFnaW5nL3dp
bGMxMDAwL2hpZi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAw
L2hpZi5jIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hpZi5jDQo+IGluZGV4IDZjN2RlMmY4
ZDNmMi4uMTI4OTQzYzNiZTRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvaGlmLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hpZi5jDQo+IEBAIC0x
NTEsNyArMTUxLDcgQEAgaW50IHdpbGNfc2NhbihzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgdTggc2Nh
bl9zb3VyY2UsIHU4IHNjYW5fdHlwZSwNCj4gICAgICAgICAgICAgICB2b2lkICp1c2VyX2FyZywg
c3RydWN0IGNmZzgwMjExX3NjYW5fcmVxdWVzdCAqcmVxdWVzdCkNCj4gIHsNCj4gICAgICAgICBp
bnQgcmVzdWx0ID0gMDsNCj4gLSAgICAgICBzdHJ1Y3Qgd2lkIHdpZF9saXN0WzVdOw0KPiArICAg
ICAgIHN0cnVjdCB3aWQgd2lkX2xpc3RbNl07DQo+ICAgICAgICAgdTMyIGluZGV4ID0gMDsNCj4g
ICAgICAgICB1MzIgaSwgc2Nhbl90aW1lb3V0Ow0KPiAgICAgICAgIHU4ICpidWZmZXI7DQo+IC0t
DQo+IDIuMjAuMQ0KPiA=
