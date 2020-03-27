Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47D1956C3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0MH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 08:07:58 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:22904 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgC0MH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 08:07:58 -0400
IronPort-SDR: d5TM3En95bxZeDD/XCW+4LMUcCvIfFjJ/jh+jHZzKsv6Y5Jkn1tcTbbCEiTPt3O8u82Rl3w2uC
 Fx2HZsbKMa9FAmhwQ6kBRkAopqvI2qLu9xs8z1Z+hfRYOcvKpFweV4BValcQBlyYo0MReUtgrp
 FD6DgIUnom2uAWbgKq01TDBcawmyoFIkZ5dS48/q7UuEUugzrDp6n4J7iLhyrXWwho3jBGt/gt
 xN2H5Rahsah/KcE/XF1JIFPwOHwHzFBglaMRF96o+2dDVV6jH2x+gUqoIZUcCa2i+G90clbfUm
 Idc=
X-IronPort-AV: E=Sophos;i="5.72,312,1580799600"; 
   d="scan'208";a="73746130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2020 05:07:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 05:07:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Mar 2020 05:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M14/puVmX65ES3RSKGQ8arFqyUAmsEIbq5L74RqDTIFh04Ig+pbky3z+DTgdIy1NxSj3PoRvuZ1DOdUWnqOG/F5o3WXVZVRXZ/XXesqDSF7FOgEXMZxsP7aZrBI7En+957bpUKqqVfF79w7ermp+oCBDfEBbdSKv1+3VomorgGFN0sqTdO2+U5kci+OHhV1/aoEwioeZxqP1ojVTB/hyMZNBc66zXYvYkf5rarIi7wtQGWJMbw7cm0PjuPwaILR4LrBxQSjliICEW4ym+lfgubjzaJAqhNUQiIujRpZsNwWRB9WlXvkxUi5OXuSDHZuZES3BYxUMgmymdI7CMjDU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftr3BOp1RQ5aAzQd3c1l6l6UQv/25lYrJWUSJcp5fvc=;
 b=eaphNjjWqn0eOd1YBBOQxdo54/0MIS5HdOsbcaPzkBKKoMUhRFoH3hcAbvrisnuw4yWQJBlemYIBv39ueF03hsyUL3tklsM9D6tDVwOF4p4yGpUv0+0Z0SwHZigO60OVPxZZ1YgR02j7zYakDcVf5+pde+M1LaoMDWqQYlYPPUF47VPSEgmrNDeYqgpQQJKO8vhA/DZYzUR4lE3J0/wflA4otsfV6ZKnNB6G6eidbKbF7021z8LpuPgqdBC+jLYGyTMI5WDXJW4Tm1J/qHDSwaN3bqCoeyEToYEhc3Rm3MV179LhzXm2qRAN7MBktYsQGIfNmjX5+dV4bXUWIIYpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftr3BOp1RQ5aAzQd3c1l6l6UQv/25lYrJWUSJcp5fvc=;
 b=IvJNgdxPdXuNMEr7mmn/zu78bkqt9IYRQZfQH9q7PjDdghksdbceGa0t7w2l4vmaSq/ckTbntyw3JyjAIUJazaQZfraa2mJMQNWq0tbWc9XfzZSMOkJ55CS9Bcst2ddqkfkGmpai6vq82+rr4rMkDGqxWmAzDYQOd4Ig3KSrs1U=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3109.namprd11.prod.outlook.com (2603:10b6:a03:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 12:07:54 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 12:07:54 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v6 00/17] wilc1000: move out of staging
Thread-Topic: [PATCH v6 00/17] wilc1000: move out of staging
Thread-Index: AQHWBAGTqEr82liQgUqCj/rX8Gwo4KhcSlDCgAAOWwA=
Date:   Fri, 27 Mar 2020 12:07:54 +0000
Message-ID: <438b865a-842a-f7d6-f57e-f7b1614ff17d@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
 <87ftduoxou.fsf@tynnyri.adurom.net>
In-Reply-To: <87ftduoxou.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11adb2af-c222-4500-0fc2-08d7d2477b22
x-ms-traffictypediagnostic: BYAPR11MB3109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB31096704B5C43727BAF68765E3CC0@BYAPR11MB3109.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(81156014)(8936002)(36756003)(31686004)(71200400001)(478600001)(6486002)(6512007)(6506007)(53546011)(6916009)(966005)(91956017)(54906003)(26005)(31696002)(86362001)(8676002)(81166006)(186003)(2906002)(2616005)(66446008)(107886003)(5660300002)(76116006)(64756008)(4326008)(66556008)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3109;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjb7s1Z0pMzPpI33qsEcNS/9VXyszGgBfrLpDzLSfY0qWXiXXoOJBJxnsvIJP0jVzBLuqa/9/faidCU1U9D02e3WnFlUTQxLrcC4MbGNiqW/siwgsolFzUxyzC7QSNh2wkCH8h1+MmK5jfUhPKG1F4EJ5ifc6dOv5szIczQSJvNnhrKHkXuBAqImdycRtJ71rWw4LiCSUCZpd8ul+3gqbMPAevTSdMjMk4C8pmvrwoFqlgEb0qObU+aAL3q2JxUbqhqIPq94U6EJe6L0IHL6qCzyBWZrceATvkiAzyUweAPLxCOvuA6VPq58rWkDIVvTsVsttEDiumMjCF2ql+k9vyCXz6MG5mcJ8ftP/Xp1+4l8jfn87rtyvjgh9QRJ0o1vOvX+P9TMyoH2C/IOoPVACkqto5gwViutlzxaZo4fYBJuZRRdIrKeejc4FNp2v6fHs6QXKrQJLAinC6Q2GjMKygGgx31c1pYBr8WXQ5L+Vbd5Ob1+XvU+SwARamOeQh92puGCj+pI+NpQ1OaHfkDg5Q==
x-ms-exchange-antispam-messagedata: wET2jUVMtlneu16kgNDtzMlaKB+9X5EhpxvmsrZ9BWP8hpyQonnXIUBqD8b2aNR0dK4Nwk+AZzVEKHB3HHNbWnNy3O3h8RcqqSlJXC52KHNsC7jGSbeJq8VXUyPCdFKuRsOC2qHAR8QiL3O5a3QE2g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <63DEC88A8E17344D9A0E2C97E8993154@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11adb2af-c222-4500-0fc2-08d7d2477b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 12:07:54.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b35kcZVG7kVwNkd5k+yHwi/J8uBeJbsyT52AnVv68ehE4AVxyK/jsvJOZ2/WYrDXoVKUzTr4OnvBed5+eDmmXtIloubkOQT38Rruve7tBHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3109
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDI3LzAzLzIwIDQ6NDYgcG0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IA0K
PiA8QWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbT4gd3JpdGVzOg0KPiANCj4+IEZyb206IEFqYXkg
U2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXJp
ZXMgaXMgdG8gcmV2aWV3IGFuZCBtb3ZlIHdpbGMxMDAwIGRyaXZlciBvdXQgb2Ygc3RhZ2luZy4N
Cj4+IE1vc3Qgb2YgdGhlIHJldmlldyBjb21tZW50cyByZWNlaXZlZCBpbiBbMV0gJiBbMl0gYXJl
IGFkZHJlc3NlZCBpbiB0aGUNCj4+IGxhdGVzdCBjb2RlLiBQbGVhc2UgcmV2aWV3IGFuZCBwcm92
aWRlIHlvdXIgaW5wdXRzLg0KPj4NCj4+IFsxXS4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtd2lyZWxlc3MvMTUzNzk1NzUyNS0xMTQ2Ny0xLWdpdC1zZW5kLWVtYWlsLWFqYXkua2F0aGF0
QG1pY3JvY2hpcC5jb20vDQo+PiBbMl0uIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdp
cmVsZXNzLzE1NjI4OTY2OTctODAwMi0xLWdpdC1zZW5kLWVtYWlsLWFqYXkua2F0aGF0QG1pY3Jv
Y2hpcC5jb20vDQo+Pg0KPj4gQ2hhbmdlcyBzaW5jZSB2NToNCj4+ICAtIGhhbmRsZSBEVCBiaW5k
aW5nIHJldmlldyBjb21tZW50cyBzdWdnZXN0ZWQgaW4gYmVsb3cgbGluazoNCj4+ICAgKiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9kcml2ZXJkZXYtZGV2ZWwvMjAyMDAzMjAxNzU5MjAuR0EzMTY0
MUBib2d1cw0KPj4gIC0gbWVyZ2VkIGxhdGVzdCBkcml2ZXIgZnJvbSBzdGFnaW5nIHdoaWNoIGNv
bnRhaW5zIGZldyBjbGVhbnVwIHBhdGNoZXMNCj4+ICAgIGFuZCBjaGFuZ2VzIHRvIHVzZSBjcmM3
IGZyb20gZXhpc3RpbmcgbGlicmFyeSBpbnN0ZWFkIG9mIGhhdmluZw0KPj4gICAgcHJpdmF0ZSBp
bXBsZW1lbnRhdGlvbi4NCj4gDQo+IFRoaXMgaXMgYWxyZWFkeSB0aGUgdGhpcmQgdmVyc2lvbiB0
aGlzIG1vbnRoLCBwbGVhc2UgYXZvaWQgc3BhbW1pbmcgdGhlDQo+IGxpc3QgdW5uZWNlc3Nhcmls
eS4gV2hhdCB5b3UgY2FuIGRvIHRvIHNwZWVkIHVwIHRoZSBhY2NlcHRhbmNlIGlzIHRvIGdldA0K
PiBSZXZpZXdlZC1ieSB0YWdzIGZyb20gcGVvcGxlLCB0aGUgbW9yZSBJIHNlZSB0aG9zZSB0aGUg
bW9yZSBjb25maWRlbnQgSQ0KPiBnZXQgYWJvdXQgdGhlIGRyaXZlci4gSSB3aWxsIGFsc28gcmV2
aWV3IHRoaXMgYWdhaW4gb25jZSBJIGZpbmQgc29tZQ0KPiBmcmVlIHRpbWUsIGJ1dCBkb24ndCBr
bm93IHdoZW4gdGhhdCB3aWxsIGhhcHBlbi4NCj4gDQoNCkFwb2xvZ3kgZm9yIHNlbmRpbmcgdGhl
IHBhdGNoIHNlcmllcyBtdWx0aXBsZSB0aW1lcy4gVGhpcyBzZXJpZXMgYWxzbw0KY29udGFpbnMg
dGhlIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBwYXRjaC4gV2UgaGF2ZSByZWNlaXZlZCBjb3Vw
bGUgb2YNCnJldmlldyBjb21tZW50cyBmb3IgdGhlIGZpbGUuIEluIHRoZSBsYXRlc3Qgc2VyaWVz
IGFsbCB0aG9zZSBjb21tZW50cw0KYXJlIHRha2VuIGNhcmUgYW5kIGhvcGUgaXQgY292ZXIgYWxs
IHBvaW50cy4gSSB3YW50ZWQgdG8gYXRsZWFzdCBjbG9zZQ0KdGhpcyBhbmQgZ2V0IFJldmlld2Vk
LWJ5IHRhZyBmb3IgdGhlIGZpbGUuDQpBbnkgc3VnZ2VzdGlvbiBvbiBob3cgdG8gZ2V0IG9ubHkg
c2luZ2xlIGZpbGUgcmV2aWV3ZWQgb3V0IG9mIHRoaXMNCnNlcmllcyBpbiBjYXNlIGZ1cnRoZXIg
Y29tbWVudHMgYXJlIHJlY2VpdmVkLg0KDQo+IEJ1dCBpdCB3b3VsZCBiZSBnb29kIHRvIGRvY3Vt
ZW50IGluIHRoZSBjb3ZlciBsZXR0ZXIgd2hhdCBjb21taXQgaWQgYXJlDQo+IHlvdSB1c2luZyBh
cyB0aGUgYmFzZWxpbmUuIFRoYXQgd2F5IGl0J3MgZWFzeSB0byByZXZpZXcgcmVzdCBvZiB0aGUN
Cj4gY2hhbmdlcyBHcmVnIGhhcyBhcHBsaWVkIHNlcGFyYXRlbHkgYW5kIHlvdSBkb24ndCBuZWVk
IHRvIHJlc2VuZCB0aGUNCj4gd2hvbGUgZHJpdmVyIGV2ZXJ5dGltZS4NCj4gDQoNClN1cmUsIHdp
bGwgY2FwdHVyZSB0aGUgY29tbWl0IGlkIGRldGFpbHMgaW4gdGhlIHNlcmllcyBjb3ZlciBsZXR0
ZXIuDQoNClJlZ2FyZHMNCkFqYXk=
