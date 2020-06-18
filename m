Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73301FF64F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgFRPLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 11:11:50 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:5506
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbgFRPLs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 11:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2Yj7ptWeRUb2JoBKAQUWdeBWNGYI0QOivOkgbYlnMDDvyeTTqy4tdAQ5CzGQo6ZwxKIz3Cv0Bkzhy9e88qyeGGqWQ3v6Of4gwR8hxVzW1ogXTPH6DfIvYcykbpAqcVOIzp/mw+t0It+Wjvy6c+xoT9DCHG5lg6C6N6rT9RDCrRivLduzCkgtrApLVQ9ifj4YwX4/Y73bwiIIhk1UNFSZPTuaFXjXjylP/PIFurrQzRWYKoiLo0q3vwrSd1SkoU78hExZg5b76s81vvJRyert9AI5Qs3RyoiGSEFhpRH/43Oxt+jwLTs5SE9DFZbmPsZiQDd4tv/DcWnWZZlO+zISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMSETmmu7Hm1kqXk1hCFz4JTB/+8jSOIuB586uKZOs=;
 b=RfSlBVtZSdGL+HEU0y6l+PWvARaCRu+uKPFWkN71k5ynazNu2TIfa95T99a+GhhcECf2w7CbCpCaLadIMt/+y4XgD+FJlyDlThe/kjVsvIzv7KCzWK3b51ufZY0mOAJqEDHPJzFoG7PwO9s6aB7RXhTlZFIHPqXbDme/Y/ksTaTK6yoiZOq8KWTUngG6GTwd1BSv1iuehb54OKBESXdpKeKsT8lrY2rT3dPV5UYSmLzhvRreO5wkbop6TjFYUYLxBhFBMRaEt2K03bK2R4zOIojgCslmV62/BN+DY5+grQBXCPPMYkW97p4C0ME5xRvmrE7wblLMTW5PEAUOwyzwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMSETmmu7Hm1kqXk1hCFz4JTB/+8jSOIuB586uKZOs=;
 b=0qZwrcDE170g8NeFwz4Z3smuOzX3ejQDwk+yTiDwthcNXoTKpOGfEU1wCyQaeLwX+yzFT0CLXSrOZtO2tnldKIqT4aE1hvTK2fE/j/RwSltbozF2d76vrudGk+iUNYuhdrAWyHIGWucNrE6cs2X0afmgcw96biU+1xtgbA3MluA=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0434.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 18 Jun
 2020 15:11:46 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 15:11:45 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/P6jeY6MUgAAEuiCAAAOSgIAAAEDQgAAFdwCAAABFsIAAAnCAgAADzeA=
Date:   Thu, 18 Jun 2020 15:11:45 +0000
Message-ID: <AM0P192MB0468C8F72B289021C7FAB9DAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         (sfid-20200618_113627_790574_4007E613)
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
         <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
         <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
         <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
In-Reply-To: <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.70.42.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45fb3d5b-5070-465b-f6bb-08d81399ea8e
x-ms-traffictypediagnostic: AM0P192MB0434:
x-microsoft-antispam-prvs: <AM0P192MB04345D30F4868B6BBF9CF20AE79B0@AM0P192MB0434.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot6nmleozRU+1rXN3TGczwBfDM237Qe3EZ1m93u4YjcvXyMRjLNF0/jtqxjCM8v00NiSdNbwPXGZJwapXLsDtfG1tAuR1CQQ5WlK8UXO/WgMRgA7sY17M2nX891HKQlUCe+xB99W78vsqN+9Io6wJ1vJNofC5cYg0laKD1nOL35AwFt9Sx+tWPDfxK+GmhZfw+AiyAYb0aalXMElyyrXfOPiT9fR8XP+WIU7Z+AFGGAWqMCP+2+kwaRoezhE21lrs9qD/M9I3xLynI0jRIlp/8kZHYiuIUkt1MWLpb6yH48bRh8LhnB4Z7vgzjTySOwB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(396003)(346002)(136003)(376002)(83380400001)(6506007)(8676002)(86362001)(33656002)(7696005)(55016002)(2906002)(478600001)(316002)(9686003)(71200400001)(64756008)(26005)(52536014)(66946007)(6916009)(66446008)(66556008)(76116006)(66476007)(186003)(5660300002)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8HvglEG89AINu3qsSSXX1fEgI0FMQ1OaHuHiAlGM0xLgHZk0qrgfU12rnjKUtu7r86j6RcKOfLqVPuKJXpTbzp0FbIgER5Exje1WjVIbkc4P31HfBDZUl8Ls8IwCqhU0Aqc6R21Icz56DfWb9NqYDOXEuyN70QNuIOzUuVW2J+6K6AyuzJ8OJn8immS0anVOKNlaNSkSVNJmJQPUVa94IGs5BQ1meeUG8sisrBb4AoRTDg3G4H59OourGDLYL9ZUMfx/wieak2BCJSI9OeiizfCbDDWvYw5IQFzHE0NZyOGkvqSubBdnWvqSHRJB315Qb+atyBBrczN87xR40rA69O/l8mcueOFKalmiCL+Fn+FkvnX8uOW2gvfl7tI0ZUfgbtktLw8YRq2/hSrjL7AWEeAir7F+AQQQ2pTzu8okn+pjkDUH8Zji/o0/sHJmjXavMP3YNITJXLSVGCayZHk+5KOpjxw2/rtQ5zGVeGIql58=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fb3d5b-5070-465b-f6bb-08d81399ea8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:11:45.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSKFMT353TWkdSDI2XwN6b3fNuVo2geOVOe4kJm7jGHC+igwyx0PCJeCnkqP861iZHPU9Mk/rW3A0njJRPg6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0434
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4gSXMgaXQgaWxsZWdhbCB0byBkbyAiaWZjb25maWcgPGlmPiBkb3duIiBvciBraWxsIGhvc3Rh
cGQNCj4+IHdoaWxlIFNUQSdzIGFyZSBzdGlsbCBhc3NvY2lhdGVkPw0KPj4gVGhlcmUgYXJlIHNv
bWUgdmVuZG9ycy91c2VycyB0aGF0IGFyZSBkb2luZyB0aGF0Lg0KDQo+IEl0J3Mgbm90IHJlYWxs
eSAqaWxsZWdhbCogcGVyIHNlLCBidXQgaXQgd291bGQgYmUgd2VpcmQgaWYgYm90aCBkaWQgaXQN
Cj4gLi4uIEJ1dCBJIGRvIHRlbmQgdG8gdGhpbmsgdGhhdCBpZiB5b3UncmUgdXNpbmcgaG9zdGFw
ZCBvciBzdWNoIHRvDQo+IGNvbnRyb2wgaXQsIHlvdSBzaG91bGRuJ3QgZG8gYW5vdGhlciBvdXQt
b2YtYmFuZCBjb250cm9sLg0KDQpNYXliZSBJIHdhcyBtaXN1bmRlcnN0b29kLCB1c2luZyBfYW55
XyBvbmUgb2YgdGhlIGFib3ZlIG1ldGhvZHMNCnRvIGRvd24gdGhlIGludGVyZmFjZSwgaGF2ZSB0
aGUgc2FtZSByZXN1bHQgLQ0KaG9zdGFwZCBkb2VzbuKAmXQgc2VuZCBhbnkgZGVhdXRoIGFuZCBT
VEEncyBzdGF5IHVuYXdhcmUgb2YgQVAgZG93bi4NCg0KU2hheS4NCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpUaGUgaW5mb3JtYXRpb24gdHJhbnNtaXR0ZWQgaXMgaW50ZW5kZWQg
b25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkIGFu
ZCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgbWF0ZXJpYWwuIEFu
eSByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiwgY29weWluZyBvciBvdGhlciB1c2Ugb2Ys
IG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24gdGhpcyBpbmZvcm1hdGlv
biBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZWQgdGhpcyBpbiBlcnJvciwgcGxlYXNlIGNv
bnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIHRoZSBtYXRlcmlhbCBmcm9tIGFueSBjb21wdXRl
ci4gTm90aGluZyBjb250YWluZWQgaGVyZWluIHNoYWxsIGJlIGRlZW1lZCBhcyBhIHJlcHJlc2Vu
dGF0aW9uLCB3YXJyYW50eSBvciBhIGNvbW1pdG1lbnQgYnkgQ2VsZW5vLiBObyB3YXJyYW50aWVz
IGFyZSBleHByZXNzZWQgb3IgaW1wbGllZCwgaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8s
IGFueSBpbXBsaWVkIHdhcnJhbnRpZXMgb2Ygbm9uLWluZnJpbmdlbWVudCwgbWVyY2hhbnRhYmls
aXR5IGFuZCBmaXRuZXNzIGZvciBhIHBhcnRpY3VsYXIgcHVycG9zZS4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQoNCg==
