Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5898F211CA4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgGBHYl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 03:24:41 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50842 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgGBHYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 03:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593674678; x=1625210678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=562KCIfDJxrQmNkKSjXHMsQcKmJhUw082FXFJ1VaHa8=;
  b=ISjaOmKKWUQ4TijjGeKoHti3kZA2929YP3Pa/JXKvUJMK6ajxrYV9c/N
   O2uxZ/chhA4L0BFMhC4494piyMbhXBEJEW2+lMYoAlEcw78Nd9MspQWph
   Q1i4RMPnd5gVFe3rmA8ViJyoSVk5kSw7nqKRoFEJX7HMI4eq/wmskjXg1
   FGMj80OfU7LLoUtF3L8HtRNIXH95OIYkcTwW1swKuW+ZLjAnwnQUchYEQ
   syJLTidTptNOxXQ9y/gNpVkXjSYTECdRA8Mlz3qtBDQLUANvG55uSw7MK
   3vfhHa8mFWKFH1XX1tw6o4FGGj5eaEGEGVWWkjucAN2bCCKnhA867626Q
   w==;
IronPort-SDR: vk6UJaJHsyYTUvIHwnUbdQqkzZps/ziKsbAXgUm9/V/+eV7nSKMdAEvoiBLSiAhLGgUFtN1Ktj
 JtUhxntPaca1xSmBfQzvOJ+lYzlbzjX9jKqzNOmmMjLt+j4JPihOs0GtJWmlXM/o5zab6+wf8R
 bRMRF9V6mvIHq96+Wheqxyx9WBloOeZoHwqmxoCv9Cm1euLLYSniYqd8aAtKJpT5KTvIzlnAht
 Z+QAos25U2oVifaa4tCpRbfkqLQmmvWW8++wzC3Zv+qcx2sJOUFgN1NjiaGHws+mA1jlyrJqZH
 dKI=
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="85960831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 00:24:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 00:24:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 2 Jul 2020 00:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIM6OomBvzJNc2jVX3amLcf4dSv02sb/MeNkpERC7VkE1Z5WgofnaJCZ5fAQyDeN04COg29ca4AlKeprLcdxjArXIwU6BEX56EdAl7Wu2C4AFQRYdtc3fDUq1+c57eSpi+fkGuY4uCi52LqEFNUDoixTLidUbx2PpwP6nX4/c23SbkzblH79cDBIsaj0diqxB3TdMww1Ns4lH/B9Gt+IT3kb8Z6m9RZ/TWsARJnyYjmjxQiRAXwabpkJGsyuoGqpnntamUHV18DuN857Q14/CESiWE4ew7QzxwLsJZjc7wa9yjkKwMfVNIZBg5d6diEVujyKK1QnpHW0cL9GntUTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=562KCIfDJxrQmNkKSjXHMsQcKmJhUw082FXFJ1VaHa8=;
 b=PU61S8gbLzoQDcT4zLA2JGWHoQpShzuJX4Yfgkb5a7LBAunV9MZqK70Yi/tzwTMFlXDFYiPhOvW7+dsIuAwvVlQxmHVJfjN/dfqzV0WCWMhaxbJzxGtFQT4PbHy2WWtjVVg+3RXDm9KyEZH6K5a5JhQ+IUgmqQRtHgQCl/3kmnoTJVhQfq/DIaCy+yENbZ3WUdzNFNH1oDV5gmJLF2zToPYHB2yjSSyut3N4jWVOfEWcqQKnbeVQlfL7DqV13zjsSdjXB0JAdjRrRb1GRGWAEDmjQ/SPhNS2mFl/xa9wxEKaIEjO9PDjeePXrxWhw+6vTnjTB1DPgFwUPEkBXORdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=562KCIfDJxrQmNkKSjXHMsQcKmJhUw082FXFJ1VaHa8=;
 b=k2DfMmU/4lcHyCp0n36+adY2tRjFhfZzUYw48AQRoLgcZZryYQl/e71kAlpw2UxXneN39OfpZCt19OK6ejs943ZYg226mgrp84gV5Qgd2zoYmmqv108UaEiVeMIPYloH5Nouxo5KVzdw5i6Uhi6c8m1Si72jvl68uOMzyvMeg5Y=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3823.namprd11.prod.outlook.com (2603:10b6:208:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 07:24:34 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 07:24:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>
CC:     <devel@driverdev.osuosl.org>, <Venkateswara.Kaja@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <linux-wireless@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <johannes@sipsolutions.net>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
Thread-Topic: [PATCH] wilc1000: move wilc driver out of staging
Thread-Index: AQHWSu1f9HixhD7k+UOCPxtNASiGMqjz52OQgAAD3ICAAAKOAA==
Date:   Thu, 2 Jul 2020 07:24:34 +0000
Message-ID: <cb2299ce-c315-1748-b475-8798165d4111@microchip.com>
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
 <875zb6e6zr.fsf@tynnyri.adurom.net> <20200702071523.GB961982@kroah.com>
In-Reply-To: <20200702071523.GB961982@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.198.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc5c9003-3725-4e1a-753c-08d81e58f836
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3823E5C1F941053A038C0E14E36D0@MN2PR11MB3823.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHhfjJ88wKH0Q9aCcTrSEV3MCDo9ERYBkZsDpTgl/DbNoFO5aAnNk89m5uMh9Q7F09aB2+mzE3PkqTZzTECAJIhj/GP/9g54TjpKVOrU4kq1Q5xcQ5OWhAapowEJgKwcYMRKDiW+FSPt5/Nes4nX+qPTp1jIBNFKrS1Ia1V5MYiWkpiRpbpWJhTKnaJORZGi9CNd6VBBuo5TXL/HnYRYNF0cSEusK072KqUGsRkdgvFABg/VReNDmxoNyyweTuQeJ2zEVMpOFgZ0wIXvr/al8u33m+Hhj2bkVgrKSk7QozvWC9gd2jmVxGvsim2zo2CJ37V5hYlZn30NdvmRRhQV848j2UeHv7sJRgQXKjT2n1GkN0VWfEfqu7lbXYwXJAGR0kCVZr59a80p7AHDv/OYzF0ObjoGxyb3M5rXEQd7rN83Q9Rl4RnT9B4zF1LcvgPpnaXjyITM3zmZrDHOrO685g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(66556008)(64756008)(6506007)(478600001)(4326008)(53546011)(55236004)(86362001)(31686004)(8936002)(6512007)(110136005)(316002)(5660300002)(2906002)(8676002)(91956017)(36756003)(54906003)(66946007)(66476007)(76116006)(31696002)(71200400001)(66446008)(2616005)(6486002)(186003)(26005)(966005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EUrYNTgkQCsNIY7MAhdBWEAr/etQvardPFVkGkrrTfWwJAOoClm46FM9oZpTAWnEhkBJrF5cXAeJwOdzcJtjGqyfxdx7zUrndc0ePwBxB4N/zxAluGXIOOc1jxfxnKOy2ThcRupx3QgpZ5UKU7tCTFSAEGrb861YbElmCIRJ8kduZkfnaP+IspxcPuekQZh7c7X69aNu10gG4ql6fcz7FnGdL2vOjAg5oLAve9+xLQKg47lHtnLr9OcM3n7RX+SRaLCPA6ywemQHQq69X9AnbAalM9D/Ouqxl0HY0xsuZPlL6jzVNFwdZSEEhW/KzkX1CEHHuQ6IJI8/I8DNy3RAijCTZ+gMPVafs/CGoqbSHZA0fNVpS3ppl1y+628nlSNXWLAInEpP8yUrWDdzQ7+u/Zp0LM2CYBMAbmCe5fZVwWEvSqQ61m6z6L5eENBZ4vKkc7/uIrqjNurRlkN40kaK+5MtUEEgKbeZeMFRon5epX8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1456E1AB23CD834E8CF4D26FE6363A12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5c9003-3725-4e1a-753c-08d81e58f836
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 07:24:34.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFu5WkjQHuglQ1A4xNHUTFuQjngu1ymIYdAtSXdmtHS/e39OiEHVZCZugz9Q/gMtY0rul1LHO45T8cCdpsZc59/JN7aFYAcqq3eWMFX6UFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDAyLzA3LzIwIDEyOjQ1IHBtLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgSnVsIDAyLCAyMDIwIGF0IDEwOjAw
OjQwQU0gKzAzMDAsIEthbGxlIFZhbG8gd3JvdGU6DQo+PiA8QWpheS5LYXRoYXRAbWljcm9jaGlw
LmNvbT4gd3JpdGVzOg0KPj4NCj4+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNy
b2NoaXAuY29tPg0KPj4+DQo+Pj4gV0lMQzEwMDAgaXMgYW4gSUVFRSA4MDIuMTEgYi9nL24gSW9U
IGxpbmsgY29udHJvbGxlciBtb2R1bGUuIFRoZQ0KPj4+IFdJTEMxMDAwIGNvbm5lY3RzIHRvIE1p
Y3JvY2hpcCBBVlIvU01BUlQgTUNVcywgU01BUlQgTVBVcywgYW5kIG90aGVyDQo+Pj4gcHJvY2Vz
c29ycyB3aXRoIG1pbmltYWwgcmVzb3VyY2UgcmVxdWlyZW1lbnRzIHdpdGggYSBzaW1wbGUNCj4+
PiBTUEkvU0RJTy10by1XaS1GaSBpbnRlcmZhY2UuDQo+Pj4NCj4+PiBXSUxDMTAwMCBkcml2ZXIg
aGFzIGJlZW4gcGFydCBvZiBzdGFnaW5nIGZvciBmZXcgeWVhcnMuIFdpdGgNCj4+PiBjb250cmli
dXRpb25zIGZyb20gdGhlIGNvbW11bml0eSwgaXQgaGFzIGltcHJvdmVkIHNpZ25pZmljYW50bHku
IEZ1bGwNCj4+PiBkcml2ZXIgcmV2aWV3IGhhcyBoZWxwZWQgaW4gYWNoaWV2aW5nIHRoZSBjdXJy
ZW50IHN0YXRlLg0KPj4+IFRoZSBkZXRhaWxzIGZvciB0aG9zZSByZXZpZXdzIGFyZSBjYXB0dXJl
ZCBpbiAxICYgMi4NCj4+Pg0KPj4+IFsxXS4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
d2lyZWxlc3MvMTUzNzk1NzUyNS0xMTQ2Ny0xLWdpdC1zZW5kLWVtYWlsLWFqYXkua2F0aGF0QG1p
Y3JvY2hpcC5jb20vDQo+Pj4gWzJdLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJl
bGVzcy8xNTYyODk2Njk3LTgwMDItMS1naXQtc2VuZC1lbWFpbC1hamF5LmthdGhhdEBtaWNyb2No
aXAuY29tLw0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRA
bWljcm9jaGlwLmNvbT4NCj4+PiAtLS0NCj4+Pg0KPj4+IEFzIHN1Z2dlc3RlZCwga2VlcGluZyBh
bGwgdGhlIGNoYW5nZXMgaW4gc2luZ2xlIGNvbW1pdCB3aXRoIGZpbGUgcmVuYW1lDQo+Pj4gc28g
aXQncyBlYXN5IHRvIG1vdmUgb3V0IG9mIHN0YWdpbmcgWzNdLg0KPj4+DQo+Pj4gUGxlYXNlIGNo
b29zZSB3aGljaGV2ZXIgb3B0aW9uIHlvdSBwcmVmZXIgYmV0d2VlbiB0aGUgZ2l0IG12IG9yIHBh
dGNoIHNlcmllcw0KPj4+IHNlbnQgbGFzdCBUdWVzZGF5LiBUaGUgcmVzdWx0aW5nIGRyaXZlciBp
cyB0aGUgc2FtZSBhcyBubyBwYXRjaCBoYXMgYmVlbg0KPj4+IHF1ZXVlZCBpbiBiZXR3ZWVuLg0K
Pj4+DQo+Pj4gWzNdLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIw
MDYyMzExMDAwMC4zMTU1OS0xLWFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20vDQo+Pg0KPj4gQXMg
ZGlzY3Vzc2VkIHdpdGggR3JlZyBJIGNyZWF0ZWQgYW4gaW1tdXRhYmxlIGJyYW5jaCBmb3IgdGhp
cyBhbmQgbWVyZ2VkDQo+PiB0aGUgYnJhbmNoIHRvIHdpcmVsZXNzLWRyaXZlcnMtbmV4dDoNCj4+
DQo+PiA1NjI1Zjk2NWQ3NjQgd2lsYzEwMDA6IG1vdmUgd2lsYyBkcml2ZXIgb3V0IG9mIHN0YWdp
bmcNCj4+DQo+PiBHcmVnLCBoZXJlJ3MgdGhlIGxvY2F0aW9uIG9mIHRoZSBpbW11dGFibGUgYnJh
bmNoOg0KPj4NCj4+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9rdmFsby93aXJlbGVzcy1kcml2ZXJzLW5leHQuZ2l0IHdpbGMxMDAwLW1vdmUtb3V0LW9mLXN0
YWdpbmcNCj4gDQo+IExvb2tzIGdvb2QsIEkndmUgcHVsbGVkIGl0IGludG8gbXkgc3RhZ2luZyB0
cmVlIGFzIHdlbGwsIGJ1dCB0aGVyZSdzDQo+IHN0aWxsIGEgVE9ETyBmaWxlIGxlZnQgaW4gZHJp
dmVycy9zdGFnaW5nL3dpbGMxMDAwLCByaWdodD8NCj4gDQo+IEknbGwganVzdCBhZGQgYSBwYXRj
aCB0byBteSB0cmVlIHRvIHJlbW92ZSB0aGF0IGxhc3QgZmlsZS4NCj4gDQoNClllcywgVE9ETyBm
aWxlIG5lZWRzIHRvIGJlIHJlbW92ZWQgYWZ0ZXIgdGhlIGRyaXZlciBtb3ZlbWVudC4NClRoYW5r
cyBHcmVnIGZvciBhbGwgeW91ciBzdXBwb3J0IHRvIG1vdmUgZHJpdmVyIG91dCBvZiBzdGFnaW5n
Lg0KDQpSZWdhcmRzLA0KQWpheQ==
