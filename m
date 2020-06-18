Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC61FF473
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgFROOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 10:14:39 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:21806
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbgFROOh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 10:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyS/V5R0ra96CW+TMiPHPw4NyaMsbTJKz413bFCQT0LKHmefc03BnV3fS76eHJGLi5XzXVct+ilRVThgAuU3dh9vX5UJPlU9CDdlwUsGuyZ6P7AQ7HK4Qu2jQ/31zmcpGUFCAE2g1mYvjSz+SmkL6xalCECy+BKmR4S27x01w4/msjnElR4N1C4SqFVYxcaIuzAGam9DFeEmhqG036x4yPZWOuUq8lYHyDDWRBJrUfGoEjTbYjqqfQvNljtJsDMDMHtPpNyynlpcXt6/BaQEDXHeXTJR9rUytlp5Gr1hSUmAKfTx8LzJp/YbbCl6RW04KgsSDvrgaQlauGU12lkNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/7E+Ajj+Gki+U1kPQCt3MLxrCov4JJ11XZsrvFvT+g=;
 b=DgEUusU/R/AoeW+kOXyzOyV/2DAXMDiol9LFS8HPapWb4X28kQoXDEM3BIEM/WrVikiwr1B5PysMEZDchJslsAEAMKwWHoDNQ7McrGDcY2vcTXV/T7l6s/gKSlWnHSmhjp7MxDRAd7n7O7QR7ZBBRu/Rk+vnRKm4jBqfRoW9OIkFqqCfMBIqaS5ZFcXbtRmb+bpwg51juMotoe73XOXSHeyEjvp7q54FMlTsaPomNp3N5Iru9Z7JHuVuZf7smSVbin5wURbB6jqp+S3F/SMKJuaTJOgNDCzDjE3ECXg24qM6PC3a7rqwl1QIFtYEAHcjt5SZtVsiGaN874PPoDDmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/7E+Ajj+Gki+U1kPQCt3MLxrCov4JJ11XZsrvFvT+g=;
 b=gDeUfDexSLu4ha39mbMJMCQrmzriXkrAJjqVxmaT0eIARRZAgzLIIEc2uwrPFu0k+bm/oSmZyMKGFafOEGlT3dhFHyUiPe8952gswAv2t0fDTKmnvdrAmIuBFhhcP1KccXyF27x3UVXsTML6ODRcSn7llHodxpowp5lCjWx0OIg=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0273.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:49::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 14:14:33 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 14:14:33 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/P6jeY6MUgAAEuiA=
Date:   Thu, 18 Jun 2020 14:14:33 +0000
Message-ID: <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         (sfid-20200618_113627_790574_4007E613)
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
In-Reply-To: <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.70.42.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a31f5795-3466-4014-1e45-08d81391ec9e
x-ms-traffictypediagnostic: AM0P192MB0273:
x-microsoft-antispam-prvs: <AM0P192MB027314A7DD6829F96802780EE79B0@AM0P192MB0273.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQiYrErO9pq2qe2o3X9RnQJgR+stIGyUqRDZ51zBLOJEQwUaFgL7CFABEbtAILubfHd6Lc97NrUCtuI6wPtRq9FYcOzXFMHybSz/YImnjstHcAdz5wu9/0rID8psVzpA8lSE4TFch6e9cN96haBSKI9dFt7pHxgzAtgehBhH4rAqbJn3dHyrcEYxODY1uX/r6PqqyLGkhfe/MxIox1iCDEq6EQiwGUfRn4EjARngh55WlQtAfYWcGMnsFjpkcm6T+6sPqe+0aMbtRqmgGxHNWsmtEgsfhSzJiAwiJCBdqLWInmeCu2O5QiUj7AuOgu5+LGATLTwmPElNOW7xWKsIxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(136003)(366004)(346002)(376002)(396003)(64756008)(71200400001)(66446008)(76116006)(66476007)(55016002)(66946007)(6916009)(9686003)(66556008)(86362001)(316002)(4326008)(7696005)(83380400001)(26005)(186003)(478600001)(2906002)(33656002)(52536014)(8676002)(6506007)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cgMyg3piE3Z0R9q7db+gckRGipILHSmjvj5AcJhe5a4vJSkkA3UJZ2td25l/BnHIuanlgDzNzNrlbxM7W80Fw3tHYo1nPC3VLFExVcloMKIxdyC+Na+xndSUnhVnohpWEtqjuYUOMHTvVxg2LtTMePlgQ2W7A4XM/kPtIs9ldTyEZ393R0FyLTyBM78aMyuu7PIgp6AhLkyILcMT/rqr1UaoUhblvdEkAdkNa4RmzxpFpDZrLY7C+Y6IGevJIEBbZnxWdqZYle9Dhrl5cY51OlmQXR/w7Y2zbWhVFsalwteXWi0RDTduqGuYYOhW4978X94pygaYiGeA+ozP1XqSWRAIsSM4df0h4Jkt19+ZPYz3kFFN77t250mIiFh06wIirPDmmtgRL2SAkNsoWNjxS3JSW+R91MrYEbtC74EYR8cXLEVvrf2GBFF0WPxslz9cVfXPy5JwrLqR7oN8mG2Rj4IaqYZYA2twDrc9wF9ITl4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f5795-3466-4014-1e45-08d81391ec9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 14:14:33.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG4XtoIL/YkEjWPSJ4RAovCHuGOPcxehGooYCPUP6g2CQTZsRZryfiaYWY5lV857TnvIY7myLGQlEG4Ftyr8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0273
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBIb3N0YXBkIG5vcm1hbGx5IGhhbmRsZXMgdGhhdC4gQXJlIHdlIHJlYWxseSBzbyB3b3JyaWVk
IGFib3V0IGl0DQo+IGNyYXNoaW5nPw0KPiBqb2hhbm5lcw0KDQpBY3R1YWxseSwgaXQncyBub3Qg
Y3Jhc2hpbmcgYnV0IFdJRkkgU1RBIGtlZXBzIHNlbmRpbmcgdW5pY2FzdCBmcmFtZXMNCnRvIEFQ
IHN1Y2ggYXMgUlRTLCBCQVIsIE5VTEwgZnVuY3Rpb24gKG5vIGRhdGEpLg0KVGhpcyBpcyB3aGF0
IEkgd2FudCB0byBhdm9pZC4NCkl0cyBqdXN0IHNlZW1zIG11Y2ggbW9yZSBjbGV2ZXIgdG8gbGV0
IFNUQSBrbm93IHdlIGFyZSBkb3duLg0KZG9u4oCZdCB5b3UgYWdyZWU/DQpPbmNlIGl0IHJlY2Vp
dmUgdGhpcyBkZWF1dGgsIFNUQSBzdG9wIHNlbmRpbmcgYW55IGZyYW1lcyB0byBBUC4NClNoYXku
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVGhlIGluZm9ybWF0aW9uIHRyYW5z
bWl0dGVkIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRvIHdoaWNo
IGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciBwcml2
aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV0cmFuc21pc3Npb24sIGRpc3NlbWluYXRpb24sIGNvcHlp
bmcgb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1
cG9uIHRoaXMgaW5mb3JtYXRpb24gaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmVkIHRoaXMg
aW4gZXJyb3IsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGUgbWF0ZXJp
YWwgZnJvbSBhbnkgY29tcHV0ZXIuIE5vdGhpbmcgY29udGFpbmVkIGhlcmVpbiBzaGFsbCBiZSBk
ZWVtZWQgYXMgYSByZXByZXNlbnRhdGlvbiwgd2FycmFudHkgb3IgYSBjb21taXRtZW50IGJ5IENl
bGVuby4gTm8gd2FycmFudGllcyBhcmUgZXhwcmVzc2VkIG9yIGltcGxpZWQsIGluY2x1ZGluZywg
YnV0IG5vdCBsaW1pdGVkIHRvLCBhbnkgaW1wbGllZCB3YXJyYW50aWVzIG9mIG5vbi1pbmZyaW5n
ZW1lbnQsIG1lcmNoYW50YWJpbGl0eSBhbmQgZml0bmVzcyBmb3IgYSBwYXJ0aWN1bGFyIHB1cnBv
c2UuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQo=
