Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F2285783
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 06:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJGEWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 00:22:33 -0400
Received: from mail-dm6nam10on2121.outbound.protection.outlook.com ([40.107.93.121]:49409
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgJGEWc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 00:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1H4gU+4jrptOp5Wb0UfGiGSnsS6w/wXHtNzdx2lmbXTljx/ySKT0+h9DJ8F7MkEQDih8uZwxweItkJpOpjWgNEYZa8cf1l2LwA5t2ZskEcarpjjZJSb54eXipD1II6/6cU4ayynWO95Ve/XCCa70JvTjcYiJicEoKLHiteFKgL2cWSl6mKWUXboKrVZYVkLnCAIMe2wlJveNKmnpjXtIrrub60g9ctdqJTBIRR72zoFnqmuGtfb6cGM8Oq/+me3/jvPAYwkuj+UsHF2GQUKbVxUJ5GSPu7rlxVyO7dnAkBOd79GmxUWoIRar8yGNBTAUfSWsjWM0TlUv3q9Ti72JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QaR4uxOJqNIzNHgB7sgMhkyELTgQftNLrOT0XDkO4=;
 b=V1ZN0nvtEOAOWjrurniqCcAWHzqYeHYOAzfjSpEi9ZNyjJFjNLZXOD4HEwGhj3HsUqaCtSjMhe6OWMhkckl37K6fqWZgvQLFisQp+mJvjR1o2L5BhMCkNRt7/zqUxi83ybDohV3UZHN4kKEFyZbHSxMb8jHZXIXJbWZ7NTNj2nHflKN2qU3K/GlTWqdK37189nBxOh9wJj/4guJDT8odHLZEYFsCJSTl4vfqJ0+KcsDZlH7MEvavWW6jDop6wxNmYHkqtbFNDLAj6D3itEzbKp7DBNrKDoIIaJ5F7dhskrTQkL+eg2cfg2tTd+KKouOj5CFqnjx52c4Jkx1jZuKEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QaR4uxOJqNIzNHgB7sgMhkyELTgQftNLrOT0XDkO4=;
 b=f/0c2bv82hlfQ2FW94aIQRYIM1lA97i7p3jo2mSDSJpbQEaOcZ9JqY6774jfILEMwm4p2IpbxHEjiU4tNoaCrvdRgBDEGk+TDw4uA/O42SzkHtdUSxJtEo8W5kvDKINKpehPSAsy5onWeScUYWCxb/vh5jJWF4e8Y/paj+lVukg=
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2500.namprd06.prod.outlook.com (2603:10b6:404:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 04:22:12 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 04:22:12 +0000
From:   Wright Feng <Wright.Feng@cypress.com>
To:     Wright Feng <Wright.Feng@cypress.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Kurt Lee <kurt.lee@cypress.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>
Subject: Re: [PATCH] brcmfmac: Support DPP feature
Thread-Topic: [PATCH] brcmfmac: Support DPP feature
Thread-Index: AQHWmuZov+JDHSnfp06n7XPsjkLBSKmKFkkrgAF2kwA=
Date:   Wed, 7 Oct 2020 04:22:11 +0000
Message-ID: <162d761f102adf7921de628234eb44d0a18543c7.camel@cypress.com>
References: <20201005070857.83974-1-wright.feng@cypress.com>
         <87tuv7c2r9.fsf@codeaurora.org>
In-Reply-To: <87tuv7c2r9.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
x-originating-ip: [210.241.230.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fde42f09-026d-42db-ec7e-08d86a789034
x-ms-traffictypediagnostic: BN6PR06MB2500:
x-ld-processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR06MB250039C855FDC11CF7C31FDDFB0A0@BN6PR06MB2500.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMv73dbaxg8NEslor0tdm6ehzJqE2UobLlvC6OH6D4ZWpxbjJPEOIwu7Iv8DEPPWTB/mkVo6BoYdGebf4ZESjgtmMNDvLFwwwWPjRKwUGN2lAcGfcC0lAI2AJYs+6zKYgowCn0mJ3SFJJcCG9xjMCmwt8F7CzsJikI7qOsTbrKjYZVDqWl9BMTc+JavdFmonFlaVkWz0PXfyVwGqvN41fBbOWOdh/L3ZkLDzrUpg+SmFCU0KrtzkUH9NRiqteq3uYIQ2UbIzSHBBhQYQJkIJAFbZoPA1zYJutD6KZx8nJY8uJZoSNBxnZy0R2Q9lerEUn+CQkVKjrSQ5Px6ULkTsS6BBSYRa5F1fNYlD77cexBhajFhUCqKKmQXpXC6HvjQ3en1UlNCH8Cbn/Pshvcbn6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(6506007)(76116006)(5660300002)(4326008)(71200400001)(2906002)(186003)(6512007)(26005)(64756008)(66556008)(36756003)(66946007)(66476007)(66446008)(91956017)(86362001)(2616005)(8936002)(6486002)(54906003)(83080400001)(316002)(110136005)(8676002)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xsQCe5qD8etpmm2Jn9sN4fqAnrFsl7sMVv5s7yv/xGPay2JyL57XPTLZ+5SJ0OqsoEjieZoUkuucHL2WZjgbB4yQlHUqBZ9Y39xMJo9qf1ZKEEUwHkxE7O6b5iOY0uAhnPXcmFbEo9gbEo/amqRk/hEByoMhixAAyWkcc0YV3A2lk/L/P7bmiiJbCsOhaDkgnK/YIWik/DFHDZ40baUPVZ1w6j0Vz5We6pe7MJFejsDdk2tGWA361HXCFX+UCpVN1IXcDgzOQUcbBDvDIUeRNin4MltSgP/VLqkynlahWtcQ0DWiN9LZ3m6yOfI5c+PX5ok3j/LU4s8WpTIwhmubt8zHTcnK4zg9GUq88pXs0/rF+35jfYK2kKoRbJLspOAaVHghraXcevqTuaJH+DsYUoEPtBuCiz1uJuoM2r/eqMTXPw9wklgUJz+E8No7AJVTlv3HWxxPbI5Gng7m6GvuGFNOuAsEdr2ubAPgMU4i1jW5UrImkqFiYYL8XSohuNdca85gVlxC1/xo4Jqhm89PKBvt9Ye1mcOa1bRV3DKfSvKB3ZBn+Le0syn/jF26GIgEG/dwHJP7/oOeVqMRDzRBd1tTUPUeZ8QONwIjx1MoS5FQBaxjdX1RqrCCbkt7U54V5DBQCaw2sTZGQqhSICU67g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FCE33889E268440B47A85EACF00919E@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde42f09-026d-42db-ec7e-08d86a789034
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 04:22:11.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUHJJ3cVClFQkEY0mhk2KBdNnOxZVxhkDb+7P08AjiaWXziaDaRv2Gl1XidSVHfxWTqq/qGo4u1rypXsXmLbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2500
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTA2IGF0IDA5OjAwICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBX
cmlnaHQgRmVuZyA8d3JpZ2h0LmZlbmdAY3lwcmVzcy5jb20+IHdyaXRlczoNCj4gDQo+ID4gRnJv
bTogS3VydCBMZWUgPGt1cnQubGVlQGN5cHJlc3MuY29tPg0KPiA+IA0KPiA+IExldCBkcml2ZXIg
cGFyc2UgRFBQIGZyYW1lcyBmcm9tIHVwcGVyIGxheWVyIGFuZCBkbyBjb3JyZXNwb25kaW5nDQo+
ID4gY29uZmlndXJhdGlvbiB0byBmaXJtd2FyZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBL
dXJ0IExlZSA8a3VydC5sZWVAY3lwcmVzcy5jb20+DQo+IA0KPiBXcmlnaHQncyBzLW8tYiBtaXNz
aW5nLg0KSSdsbCBhZGQgaW4gcGF0Y2ggdjIuDQo+IA0KPiAgDQo+IGh0dHBzOi8vd2lyZWxlc3Mu
d2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJtaXR0aW5ncGF0
Y2hlcyNzaWduZWQtb2ZmLWJ5X21pc3NpbmcNCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmMNCj4gPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEu
Yw0KPiA+IEBAIC02Myw2ICs2Myw5IEBADQo+ID4gwqAjZGVmaW5lIFJTTl9DQVBfTUZQQ19NQVNL
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJVCg3KQ0KPiA+IMKgI2RlZmluZSBSU05fUE1L
SURfQ09VTlRfTEVOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMg0KPiA+IMKgDQo+ID4gKyNkZWZp
bmUgRFBQX0FLTV9TVUlURV9UWVBFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAyDQo+ID4gKyNk
ZWZpbmUgV0xBTl9BS01fU1VJVEVfRFBQwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBTVUlURShX
TEFOX09VSV9XRkEsDQo+ID4gRFBQX0FLTV9TVUlURV9UWVBFKQ0KPiANCj4gU2hvdWxkbid0IHRo
ZXNlIGJlIGluIGluY2x1ZGUvbGludXgvaWVlZTgwMjExLmg/DQo+IA0KPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9pbmNsdWRlL2JyY211X3dpZmkuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9pbmNsdWRl
L2JyY211X3dpZmkuaA0KPiA+IEBAIC0yMzMsNiArMjMzLDExIEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBhY19iaXRtYXBfdHN0KHU4IGJpdG1hcCwNCj4gPiBpbnQgcHJlYykNCj4gPiDCoA0KPiA+IMKg
I2RlZmluZSBXUEEzX0FVVEhfU0FFX1BTS8KgwqDCoMKgwqDCoDB4NDAwMDDCoC8qIFNBRSB3aXRo
IDQtd2F5IGhhbmRzaGFrZQ0KPiA+ICovDQo+ID4gwqANCj4gPiArI2RlZmluZSBXRkFfQVVUSF9E
UFDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgyMDAwMDAgLyogV0ZBIERQUCBBVVRIICovDQo+IA0K
PiBJIGFzc3VtZSB0aGlzIGlzIEJyb2FkY29tIHNwZWNpZmljIGFuZCB0aGlzIGlzIHRoZSBjb3Jy
ZWN0IGZpbGUgZm9yDQo+IHRoaXMNCj4gZGVmaW5lLiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20g
d3JvbmcuDQpZZXMsIHlvdSBhcmUgcmlnaHQsIGl0IGlzIEJyb2FkY29tIHNwZWNpZmljLg0KPiAN
Cj4gPiArI2RlZmluZSBXRkFfT1VJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIlx4NTBceDZGXHg5QSLCoMKgLyogV0ZBIE9VSQ0KPiA+ICovDQo+IA0KPiBZ
b3Ugc2hvdWxkIHVzZSB0aGlzOg0KPiANCj4gaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaDojZGVm
aW5lIFdMQU5fT1VJX1dGQcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gMHg1
MDZmOWENCj4gDQo+ID4gKyNkZWZpbmUgRFBQX1ZFUsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MUHCoMKgwqDCoC8qIFdGQSBEUFAgdjEuMCAqLw0KPiAN
Cj4gU2hvdWxkbid0IHRoaXMgYmUgYWxzbyBpbiBpbmNsdWRlL2xpbnV4L2llZWU4MDIxMS5oPw0K
V2Ugd2lsbCBjcmVhdGUgYSBubDgwMjExIGNvbW1pdCBmb3IgbW92aW5nIHRob3NlIGRlZmluaXRp
b25zIHRvDQppZWVlODAyMTEgaGVhZGVyIGFuZCByZXVzZSB0aGUgZXhpc3RpbmcgT1VJIGRlZmlu
aXRpb24gaW4gcGF0Y2ggdjIuDQo+IA0KDQo=
