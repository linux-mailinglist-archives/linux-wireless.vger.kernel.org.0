Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77218F0BF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 09:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCWIWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 04:22:51 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:47819 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbgCWIWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 04:22:50 -0400
IronPort-SDR: V4m7L6624FKc7biv/h/pi2yIL3+koQNR+ukUGB0CnLYJFdUd/VY7nmnBUzcX0Ans323tGVt0/l
 RtlvTrMKFfnMXvXVaYFw1NwxB7HwXCQhrKoCYqDHZPXpXxzF2a7u/UEeZCEe1OONoint8IuBLF
 Ahu4k2E+D3I1WXgRicUfalk/DRZ1rKt93T3Nn16SrSCA5evxuKIoTGvGm1zf/96kUL4y8+2vTa
 v+vB1u4fYH6lM47CoOsKV1esOZAHqph/IQhC4FC26ypj1cQfzkYm0LsJzMQtGRQ4bNvN0A/Vhf
 SkA=
X-IronPort-AV: E=Sophos;i="5.72,295,1580799600"; 
   d="scan'208";a="69800197"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2020 01:22:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Mar 2020 01:22:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 23 Mar 2020 01:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtt9hPtF6qQDWv72tRULYrh5iWwe2LCk/HUCATH7n1OGIWFlk5LGz/v02i+URSNkHcmNjWtITPy3JiabPcOkGJuvgpsjD3JTO3/eJ3TdH1JD0pk7qsFmUPcjr/KjqLk85/0XNEen6iLS3doksP+eqpN0utg355oIRKMfl/RfR+HFiNV0jBXxJw8sHd4FQvwlK7CXI34zCI3HoAr+MPdztiNJMhDee0gkGcHKsqHYcz40WOg9JM6t7Zr3SoLDqEj6rFOpe2ZiyMPH60fiGms969uWK1kKAe0P9/oD5DOJct3wZTJeKbFwjlcXOcD5+CfjWcGsT72KYBsrfpb/HXG5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80TrivdtU+4xRqcgY5DjdEstDPgS6FAmTgDeWKhwK2M=;
 b=UJ6iJdMPFjvzfZ6hHD7WpsXbhU7W9wUNi1n4Sk0VWDJR9jeszienFLjnwruGD7VYQQzOCYUI/fJMmnFFDfZLPzsu3Z/Jxp+FIhX4j8xQ+SsuiIlKV+qgl8Q/8YWRlhU8SDWWGArHhKtPnlxRASny2MQOGe7bniMCKtM1TpO8DuOelxvEZIfIbGyAOgNRbEy9XJ+Rrmm5umrPxUQ6x6/bV+B4M25xq0kaYvZ98cn3S82qiFifofpaAOzmu1wGFv/t1lTGSTbucPuP1I5UDAhjkkcndve+8choX1vkZDtIqQdPVSJCktNMSSazSsNVsQP+qqXxoH6YJRb6t0fHwjEPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80TrivdtU+4xRqcgY5DjdEstDPgS6FAmTgDeWKhwK2M=;
 b=eBRWz/eLOE0KrGH+LBQzjD2beVMdTJ9dhhLN7BqZLUSPI3BGub3ypsI27ymlGtKzBRgYML1ZBUyRO+8DrQqLW53enfoqK5ZMaF6mbR66U1h7eh9eqdZIV24RTbMyWYW80i9ORlur+JFj/OGlbXZ1/6pkEQjLqWeSby/1lXMfuBk=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2790.namprd11.prod.outlook.com (2603:10b6:a02:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 08:22:46 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 08:22:46 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <lkml@SDF.ORG>
CC:     <Adham.Abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Topic: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Index: AQHWAEIKTm0S89iTgU6wn5ujLF8hH6hVoCEAgAAcxQCAABsLgA==
Date:   Mon, 23 Mar 2020 08:22:46 +0000
Message-ID: <48611e28-5a55-ab05-3865-71992a5be327@microchip.com>
References: <20200322120408.GA19411@SDF.ORG>
 <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
 <20200323064558.GC19411@SDF.ORG>
In-Reply-To: <20200323064558.GC19411@SDF.ORG>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.16.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f7ebb1-c9f1-48d8-1ab5-08d7cf035e17
x-ms-traffictypediagnostic: BYAPR11MB2790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27909FD8E4DD8BB2D0B4926CE3F00@BYAPR11MB2790.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(8936002)(54906003)(316002)(26005)(81156014)(186003)(53546011)(6506007)(8676002)(86362001)(6486002)(81166006)(2906002)(36756003)(66476007)(478600001)(6512007)(66446008)(4326008)(66556008)(31686004)(71200400001)(5660300002)(64756008)(66946007)(76116006)(91956017)(2616005)(6916009)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2790;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHH9T9psS4B+LbYCJZJVaB+pkQ1mQ5eBwcl8hKJYQQj6L4A65NKonNQr9jDu24D7NoiSZjjF5+m+nBzIZCAC1KMfJTyrkCF9muIIviyAreX+PHsjzuoSPzm3Rfy0PcA69IoagqgOrZhMgz/9g5vDq6RGuYmkmzqY4Df9aB5SCsrXrM8HZ3/IQ8J1AKl2pTPa3Y7dAWEDg1bxoklKTz2gUOAIxI4RIq54ZB0n0EPgHe/jG5AfWOkdvi+iPDvB4DcWiZb8aP173MAEMjqs2L3bu9Mk0mZznE3b0XoJab0D9dk+YGAAyfBps1Z+2zOGKuFTmwt/FtVC2cik6zfEPE/c9AChKb6IHj0T0ZP9dK5A81a4Veyck2O2auiv2d3I+rewlm4LVt1+rHdmgnZ7YcZvCWJLFoYa9aFulhIrbkbaEHGYTuT+uyO1e6WSqY5q/e3e
x-ms-exchange-antispam-messagedata: EPtv7YcgFdrJVuSkfYymeA64fG9YoAuAIMS1X/L1Y0k1cP94lIc1Qy3KJiVIC5YcCn5zoy7Ez61ZV9g4OLfQjZTwJs5v2sQlVn358zQ7C6mQcj2alIY6LEMbPvE8B+FTYPaX0pJ0892a7H19RTy/7Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B405D332184A429BE65C1604D37182@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f7ebb1-c9f1-48d8-1ab5-08d7cf035e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 08:22:46.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tw+2rwIY5ZicaH1U4qMmcQqp7KTMa8632fTJ9ZuYX1bv6Zo4yI3raedk5BygqIAUwXPYTZIsVrmb5RW5+YTUSnFPVfkbORDPNby56B6Tas4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2790
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiAyMy8wMy8yMCAxMjoxNSBwbSwgR2VvcmdlIFNwZWx2aW4gd3JvdGU6DQo+IA0KPiBPbiBN
b24sIE1hciAyMywgMjAyMCBhdCAwNTowMzowMkFNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPj4gT24gMjIvMDMvMjAgNTozNCBwbSwgR2VvcmdlIFNwZWx2aW4gd3Jv
dGU6DQo+Pj4gVGhlIGNvZGUgaW4gbGliLyBpcyB0aGUgZGVzaXJlZCBwb2x5bm9taWFsLCBhbmQg
ZXZlbiBpbmNsdWRlcw0KPj4+IHRoZSAxLWJpdCBsZWZ0IHNoaWZ0IGluIHRoZSB0YWJsZSByYXRo
ZXIgdGhhbiBuZWVkaW5nIHRvIGNvZGUNCj4+PiBpdCBleHBsaWNpdGx5Lg0KPj4NCj4+IFRoZXNl
IGNoYW5nZXMgd2lsbCBicmVhayBmdW5jdGlvbmFsaXR5LiBUaGUgY3JjNyB1c2VkIGluICd3aWxj
JyBpcyBiYXNlZA0KPj4gb24gdGhlIHByZXZpb3VzIHJldmlzaW9uKGNvbW1pdCMgYWQyNDE1Mjhj
NDkxKS4gVGhlIG5ldyBjaGFuZ2VzIGNhbiBub3QNCj4+IGJlIGFkb3B0ZWQgZnJvbSAnd2lsYycg
ZGV2aWNlIHNpZGUgYmVjYXVzZSB0aGUgY3JjIGNhbGN1bGF0aW9uIGlzIGRvbmUNCj4+IG9uIGhh
cmR3YXJlIElQIGFuZCBpdCBleHBlY3RzIHRoZSB2YWx1ZSBiYXNlZCB0aGUgb2xkZXIgaW1wbGVt
ZW50YXRpb24uDQo+IA0KPiBJJ20gY29uZnVzZWQuICBCb3RoIGNyYzcgZnVuY3Rpb25zIGNvbXB1
dGUgdGhlIGV4YWN0IHNhbWUgdmFsdWUuDQo+IEkgcHV0IHRoZW0gaW4gYSB0ZXN0IGhhcm5lc3Mg
YW5kIGNoZWNrZWQgdGhhdCB0aGV5IHByb2R1Y2UgaWRlbnRpY2FsDQo+IG91dHB1dCBiZWZvcmUg
c3VibWl0dGluZy4NCj4gDQo+IFRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhhdCB0aGUgaW1wbGVt
ZW50YXRpb24gSSBkZWxldGVkIGRvZXMNCj4gDQo+ICAgICAgICAgY3JjID0gMHg3ZjsNCj4gICAg
ICAgICB3aGlsZSAobGVuLS0pDQo+ICAgICAgICAgICAgICAgICBjcmMgPSBjcmNfY3luZHJvbWVf
dGFibGVbKGNyYyA8PCAxKSBeICpieXRlKytdOw0KPiAgICAgICAgIHJldHVybiBjcmMgPDwgMTsN
Cj4gDQo+IHdoaWxlIHRoZSBsaWIvY3JjNy5jIGNvZGUgbWFpbnRhaW5zIGl0cyAiY3JjIiBzdGF0
ZSB2YWx1ZSBhbHJlYWR5DQo+IHNoaWZ0ZWQgbGVmdCAxIGJpdCwgc28gaXQgY2FuIHVzZSB0aGUg
c2ltcGxlciBsb29wOg0KPiANCj4gICAgICAgICBjcmMgPSAweGZlOyAgICAgLyogMHg3ZiA8PCAx
ICovDQo+ICAgICAgICAgd2hpbGUgKGxlbi0tKQ0KPiAgICAgICAgICAgICAgICAgY3JjID0gY3Jj
X2N5bmRyb21lX3RhYmxlMltjcmMgXiAqYnl0ZSsrXTsNCj4gICAgICAgICByZXR1cm4gY3JjOw0K
PiANCj4gSXQncyBub3QgYSBkaWZmZXJlbnQgQ1JDLTcsIGl0J3MgdGhlICpleGFjdCBzYW1lKiBD
UkMtNy4gIFlvdSBjYW4NCj4gc2VlIHRoYXQgdGhlIHN5bmRyb21lIHRhYmxlcyBhcmUgaWRlbnRp
Y2FsLCBqdXN0IHNoaWZ0ZWQgb25lIGJpdCBvdmVyLg0KPiANCg0KWW91IGFyZSByaWdodCBib3Ro
IGltcGxlbWVudGF0aW9uIGNvbXB1dGUgc2FtZSByZXN1bHRzLg0KTXkgYmFkLCBJIGRpZG4ndCB1
c2UgY29ycmVjdCBkYXRhIGxlbmd0aCB2YWx1ZSB3aGlsZSB2ZXJpZnlpbmcgdGhpcw0KcGF0Y2gg
d2l0aCBsYXRlc3QgZHJpdmVyLiBFYXJsaWVyLCBJIGFsc28gdHJpZWQgdG8gcmVwbGFjZSBjcmM3
IGJ5IHVzaW5nDQpleGlzdGluZyBsaWJyYXJ5IGJ1dCBpdCBnYXZlIGRpZmZlcmVudCByZXN1bHRz
IHdpdGggJ2NyYzdfYmUoKScgYmVjYXVzZQ0KSSBkaWRuJ3QgbW9kaWZ5ICcweDdmJyB0byAnMHhm
ZScuDQpDb3VsZCB5b3UgcGxlYXNlIG1vZGlmeSBhbmQgc3VibWl0IHRoZSBwYXRjaCB1c2luZyB0
aGUgbGF0ZXN0IHN0YWdpbmcNCmNvZGUgc28gaXQgY291bGQgYmUgYXBwbGllZCB0byBzdGFnaW5n
Lg0KDQpUaGFua3MgYWdhaW4gZm9yIHN1Ym1pdHRpbmcgdGhlIHBhdGNoLg0KDQpSZWdhcmRzLA0K
QWpheQ==
