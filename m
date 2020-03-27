Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1934E1951B0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgC0HDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 03:03:32 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2297 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgC0HDb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 03:03:31 -0400
IronPort-SDR: 1GJ9RdjcwGnNNhI26JK9YO2ivsAsESqh6JV9719QNMoiNxqtkqAvTph9GFpbe7UCvWQhmnDUH2
 AYlzysyCFSmq381n62mBLqAislXmpiJCl/SerTnvFRyBXpSJzEjuZ0kGrWo1Avy/l/+85G5EVo
 eVCCoeCwb+6lbB4fqZHTFOGZ9+1UTcv3s8Qx1lvD3S6jfpPW2TNSdYBfnuRFPGWppA+xQ8xL05
 Uga+Vm0sIgJrkaPgbKI3cFpyqN3Sly3F7SXKB2PBk7cuDYR7OGPuQDgNYz2jELutf0NrEEKqAx
 yuU=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="71454858"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2020 00:03:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 00:03:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 27 Mar 2020 00:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FixJRdhdMRCbjIolXfM7ALzaiOhQ4x9ZOl/JvuDPIVTOkOKGQ/EaTVIIXBkuWkunMISZ5iUEsZhO+bPoeeEOatbhekaquLWRcm6Xch6WXD76SionYLRhnZ5MYX4lPLIq0rT71nLFbWaW03LXdWDPZ+ALHRmU3xBO1nPPz+xeorYOViKuIE2oy2yb35aBFkcBQ/i8YuGdO1rRzqYVb7RYWrAG2X3GPF/a6uLCUrJ3FB3XaWnX1JpOgx0mgsOMcr21dpEQ1fp5PwenfeYtkmBLUQQADbPii8q9PITn6wsKzuMJa9hDZ6MT/bFEa7ySWeUMwdprFVAxd8xDbPI0lqzZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgwA10WHUobDrH32E5GL2bBnZmpnZCJ8U2mNReVzbUE=;
 b=ERUorC5me+RE/CBhyywqeBu1wSFIwsJQVMitZj3Yn49Na1QWyVKnskYUGOatxA9x/690WgrrWP6PfG0nJ070KFP2bb3D2/RErurRpMpaD6KiH7kkv6N32iBHBP/uixV8oGWJr6kFBSUUc3PbJeEFYbomZ6d8qZr3gl3AvoI7vWyMYjTuDL/OOboftId9Gq4LObMGdA7hPZeEtZqOJ1kXF7Q51qIDnjKjtDHkrbSN8xr1isZhwa9/J2Bg04A5JaPxX0eDSiVXPzNPIbjfWXeDeV5ICLTHcIQvd1BFRohUcrW810IzLHHnZJQ00A6r4Qb6w69zmE45XlZUAm4siNWD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgwA10WHUobDrH32E5GL2bBnZmpnZCJ8U2mNReVzbUE=;
 b=bypnBq/rHhP6GYm//eMdIRZZNaIZaChj7dPTE24ZNG1ElfsJOflDLWLoA9vA8DbKJZ31U3y3J8jDeH7khp2pxxm8qXRPuHUQFS2B3Q0GWKcu7uWxhjPbHhjf9eko6L7wf2rINo3Punmhfg4e3NYVj3e706VlaqVK3WS89m9bGss=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3061.namprd11.prod.outlook.com (2603:10b6:a03:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 07:03:28 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 07:03:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <lkml@SDF.ORG>, <gregkh@linuxfoundation.org>
CC:     <Adham.Abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Topic: [PATCH v2] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Index: AQHWA6TJE1xkA8WrykOUJ6UZi95bXqhcBFUA
Date:   Fri, 27 Mar 2020 07:03:28 +0000
Message-ID: <820cc7dd-b19e-fdb4-feec-c8595e6029ce@microchip.com>
References: <20200326192836.GB15115@SDF.ORG>
In-Reply-To: <20200326192836.GB15115@SDF.ORG>
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
x-ms-office365-filtering-correlation-id: 980b615a-f790-4970-e413-08d7d21cf3b6
x-ms-traffictypediagnostic: BYAPR11MB3061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3061972DA7C44A5CD3843454E3CC0@BYAPR11MB3061.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(31696002)(36756003)(8936002)(81156014)(81166006)(8676002)(2906002)(53546011)(86362001)(6506007)(2616005)(4326008)(5660300002)(71200400001)(316002)(31686004)(478600001)(91956017)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(26005)(6512007)(6486002)(54906003)(110136005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3061;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEEb6dieAPFNTjWCvRZYikuO2rL6nrZOVnQAAntXYw9UX/WpmKBMrthr10EtN/xJifJuxl60ucQTsuyVQTYMs1jorEktCjTr9qlDpIvkweTiSE6kx4SCqb6rOjHSET4+ywSshXYSUIQ+WoRGnmK+P7Dw8MnC1Ppc+FOIdvP9KzgOULvgkQH2PBjVFxbn+a7NTxwpqV63MGJ5C7AMBY8JYQ1dWjXOgtniaBtzd6tFXQK5MiJHwlF51fsjJFXQ3tMCd5HRcK5dHCnoyaMlgutKnK0RQMyCcdVvIQeG9zvll//jmYEqWaczVBePilBUFeqp6UxDdwxsVYulceEaIPBDl2nTU34J3Y/xxuCcyWMMg8rDB9o3OxUGHnEnmB7tfBD46uIWUbaBUVIN7KPJfXf+rY2an1Gyv95ffiw0zQEBntuwCWIZyFP/mF1ylcKy5O5x
x-ms-exchange-antispam-messagedata: Rspq9Eys7ok0IYDpkfpez+ZNt910GZqc8+r13tYnpuXO6ait7uaY0DFCFpBbQ5wl/PbSYjsKHj+vhyrKgUgvHW/AKP4TPz12Jroc64Z3RKVCXktFk+iRyWT1JMwbJtqIpRUV1rmw1fNolSnJ8anQag==
Content-Type: text/plain; charset="utf-8"
Content-ID: <19AA986F5450C8448D240A9C65E8AFAF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 980b615a-f790-4970-e413-08d7d21cf3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 07:03:28.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGmzLzT/giGXXAoEdY0n68UfeI72j0iXmbkc0xIdcqZtrL9AJZ/aQdedAYCRNlpfHVZXvjIfMjglkIe2YzMBj0vOLVC2oWjIlB+DINm62AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3061
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR2VvcmdlLA0KDQpPbiAyNy8wMy8yMCAxMjo1OCBhbSwgR2VvcmdlIFNwZWx2aW4gd3JvdGU6
DQo+IA0KPiBUaGUgY29kZSBpbiBsaWIvIGlzIHRoZSBkZXNpcmVkIHBvbHlub21pYWwsIGFuZCBl
dmVuIGluY2x1ZGVzDQo+IHRoZSAxLWJpdCBsZWZ0IHNoaWZ0IGluIHRoZSB0YWJsZSByYXRoZXIg
dGhhbiBuZWVkaW5nIHRvIGNvZGUNCj4gaXQgZXhwbGljaXRseS4NCj4gDQo+IFdoaWxlIEknbSBp
biBLY29uZmlnLCBhZGQgYSBkZXNjcmlwdGlvbiBvZiB3aGF0IGEgV0lMQzEwMDAgaXMuDQo+IEtj
b25maWcgcXVlc3Rpb25zIHRoYXQgcmVxdWlyZSBtZSB0byBsb29rIHVwIGEgZGF0YSBzaGVldCB0
bw0KPiBmaW5kIG91dCB0aGF0IEkgcHJvYmFibHkgZG9uJ3QgaGF2ZSBvbmUgYXJlIGEgcGV0IHBl
ZXZlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR2VvcmdlIFNwZWx2aW4gPGxrbWxAc2RmLm9yZz4N
Cj4gUmV2aWV3ZWQtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+
IENjOiBBZGhhbSBBYm96YWVpZCA8YWRoYW0uYWJvemFlaWRAbWljcm9jaGlwLmNvbT4NCj4gQ2M6
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gdjI6IFJlYmFzZSBvbiBz
dGFnaW5nLW5leHQgdHJlZQ0KPiB2MjogUmVzZW5kIHRvIEdyZWcuICBJIHNlbnQgaXQgdG8gQWph
eSwgbWFpbnRhaW5lciBvZiB0aGUgZHJpdmVyLCBmb3INCj4gICAgIGhpbSB0byBmb3J3YXJkLiAg
U2hvdWxkIEkgaGF2ZSBieXBhc3NlZCBoaW0/DQoNCkN1cnJlbnRseSwgd2lsYzEwMDAgZHJpdmVy
IGlzIHByZXNlbnQgaW4gc3RhZ2luZyBzbyB3aGlsZSBzdWJtaXR0aW5nDQpwYXRjaGVzIHBsZWFz
ZSBtYXJrICdkZXZlbEBkcml2ZXJkZXYub3N1b3NsLm9yZycgbWFpbC1pZCBhbHNvLg0KQnR3LCBJ
IGhhdmUgYWxyZWFkeSByZXN1Ym1pdHRlZCB5b3VyIHBhdGNoIGJ5IGFkZGluZyBtYWlsaW5nIGdy
b3VwLiBUaGUNCnBhdGNoIGlzIGFwcGxpZWQgdG8gJ3N0YWdpbmctbmV4dCcgYnJhbmNoLCBzbyBw
bGVhc2UgcHVsbCB0aGUgbGF0ZXN0DQpzdGFnaW5nIHRvIGNoZWNrIHRoZSBjaGFuZ2VzLg0KRm9y
IGZ1dHVyZSBwYXRjaGVzLCBwbGVhc2UgYWxzbyBhZGQgJ2RldmVsQGRyaXZlcmRldi5vc3Vvc2wu
b3JnJyBtYWlsaW5nLWlkLg0KDQpSZWdhcmRzLA0KQWpheQ==
