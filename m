Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BE202A05
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2020 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFUKMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 06:12:10 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:6108
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729768AbgFUKMJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 06:12:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7RCdj5OLcuncv8f9hH8z3YW6zkUwfaQn/SMGnpd00G1OMpdx8zjDeY/GVFOERvMGSgxN7OBEpjppKUVZfls9+kVKnt9LBqE1E7tJxXmXEoxUdJvIQA2Iz+NfGuDP0d7zg3Y5OwHY4yH7UsJrgm5UaXAGf992Rif9z1Q0qU/bj97NctA+QTHCQvcjuBdT+WwKjfxyqM/keI/UjdEihyeVxL9sB1z5x0zSe3Ml6v+WLcZbSIW5jijPo2yh8GpBaio1MF0fQhnv3dpH31PIfFF51Beuy+IJfUcsTl/2w4i6TbzOcSS8t2vzRUM463v9Rx2M2W9zH2Xwhu7D4mXh6RMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PLpP5KpTffec3S1bEMzc4Iks6NWAW/Ou/lrPh42LBw=;
 b=Jf53gM6wIzgAXKBBddq9/hnpEdLAOAFTja1NgUsLTIQ6X/lV2C4WnuGAGxewgglG/rfhu3njg122Xf9XEbxVvfivDlRVye3jqixnW2w760yQVkN+LYN4FFSF4tdXkIf55cIazGV5pey85DH4EhTYsHRYE8ou9RtozJ/Jx+5wyctby3Ns336GnKZqMWJhd0ACQggTSpLmSbri4RGNQ2r1eb9D2dELBXN6fEIXWLfMUgYvlLz9rcIgWAwlROC1p5ZAFYM0FamlYMGkMztSWUBDMsO+/V8/g/Cq1wNIZtH8br5nzNa5OkSYqQ10vrc7TG9X5eIPWL6VIq8fhH8Ag/87Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PLpP5KpTffec3S1bEMzc4Iks6NWAW/Ou/lrPh42LBw=;
 b=z9648g9oZtwEB88ycHW8sTk9VCgtF15sOfM7NEKu049Vfytkumzgd2oPOyrdp7Uh+gNKL/16B3vvV2YJh4pJmurT8brJrCKDAzPP6ZM16zltCNkZaaikse2j1VeJ4hmGA01vk4piTHiNw+iLDnxCxfgOPgJDco6bdoJ6kjKaYT8=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0417.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 10:12:06 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3109.026; Sun, 21 Jun 2020
 10:12:06 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/P6jeY6MUgAAEuiCAAAOSgIAAAEDQgAAFdwCAAABFsIAAAnCAgAAKxICABFnFgA==
Date:   Sun, 21 Jun 2020 10:12:05 +0000
Message-ID: <AM0P192MB0468ED699FC0BE6431812B03E7960@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
 <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
 <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
 <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
 <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
In-Reply-To: <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: candelatech.com; dkim=none (message not signed)
 header.d=none;candelatech.com; dmarc=none action=none header.from=celeno.com;
x-originating-ip: [87.70.42.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5197b59-af0a-4e28-a8be-08d815cb8cf8
x-ms-traffictypediagnostic: AM0P192MB0417:
x-microsoft-antispam-prvs: <AM0P192MB041715F30C2F7166B3510FF2E7960@AM0P192MB0417.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04410E544A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j8Me9PYtVNv3zozF29nhzVXzAF7x3iw9c/TXk0i9xnWUDj4V26i1ljx3ciHc1fZESTxMYw2COESc9R8ZQIElp/zGS+G90rvKHvtcl9xOfV6nXk10UeJa8J8OGdvSHotagBWk78iSzKnrNWklbjVShZa+BqSxyrN5BmWRr6THQESW5YMNQ4hBACH/PA7+PFqGms8H1UCIExMpEJsTD/MTYz3ZL9O8zIXvId/pspwKxztl5Ax+6t6FvRVOUhxRlNKmLfC5j+Ygb4kQ6qc05yGgoyEwYok036WZShdhCPK/TkZElpOhQb9FQgcCY7QzwbpX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39840400004)(376002)(366004)(396003)(346002)(8936002)(83380400001)(55016002)(33656002)(9686003)(4326008)(86362001)(71200400001)(6506007)(8676002)(26005)(316002)(110136005)(64756008)(52536014)(7696005)(2906002)(478600001)(66446008)(5660300002)(66476007)(66946007)(186003)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BMpVgZLGUlpf6Hmmedgw1sR+bmcJt2OWKepTkQ5DTwTCh9Ev/XWU91qdM46djmp0bT+GWTVpgGtVHX299kFo9sMADlXMSbQirfwf/b5rFrvVGQ3kSVI/vF+4HNuDWeF03LI6fx5pFPdNn0k181hsrcs7SjnqiQ6KsEtIkZVi123L8GTY1U2/oDb5nwgMcySklLfXMdn0FFj9FdjYNy6oxeo09+O0kYSfpMxbtHCMHoaj51vyNCMg6eRArt9kfruuZ5vt7F77yx5K4uTwQifFxf0Ibe2AMtyWssSmpvm/NYpdfsD+RxXt1Glk9S2QlDqLXdlRNx+2LkfB28kJT50v9+ZyTy489X9kCpaZ3I/9ElGKVVmY/WDNlNaYvZWcow7LGhxsoPdPOvSjX7KX7UUqalonsZ3yvA2hHOyvMPywI4wx83eqQhV4fTM2DFyCoUmu08LaBTyW+Mzg5W4c7rLUaDedK/Rwgtuvq0dVxqDFy5A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5197b59-af0a-4e28-a8be-08d815cb8cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2020 10:12:05.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjMJYrGCzMwgs/TsI937oQ2F8bO8CtlJa7A00T+Nx8rqVeyvtv5x7zujrxZjrKGditwAkxSbpfMe8vHlYMdDDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0417
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSm9oYW5uZXMgYW5kIEJlbiwNCg0KVG8gY29uY2x1ZGUgdGhpcyB0aHJlYWQsIGhvc3RhcGQg
ZG9lc27igJl0IHNlbmQgYW55IGRlYXV0aC9kaXNhc3NvYw0KdXBvbiBBUCBzdG9wICh3aGVuIGhv
c3RhcGQgaXMga2lsbGVkIF9vcl8gd2hlbiAiaWZjb25maWcgZG93biIgdGhlDQpBUCBpbnRlcmZh
Y2UpLg0KVGhpcyBpcyBjYXVzaW5nIGEgc2l0dWF0aW9uIHdoZXJlIHN0YXRpb25zIGtlZXAgc2Vu
ZGluZyB1bmljYXN0IGZyYW1lcw0KdG8gYSBkb3duIEFQIGludGVyZmFjZSBhcyBpdCBkb2VzbuKA
mXQga25vdyBpdCdzIGdvbmUgZG93bi4NCkkgdHJpZWQgeW91ciBzdWdnZXN0aW9uIGFuZCBzZW50
IDEgZGVhdXRoL2Rpc2Fzc29jIGFzIGJyb2FkY2FzdA0KKGluc3RlYWQgb2YgdW5pY2FzdCB0byBl
YWNoIFNUQSksIGJ1dCBzb21lIHN0YXRpb25zIChlLmcuIFNhbXN1bmcgUzgpDQpJZ25vcmUgdGhp
cyBicm9hZGNhc3QgKHdoaWxlIGl0IHdpbGwgbm90IGlnbm9yZSB1bmljYXN0IGRlYXV0aC9kaXNh
c3NvYykuDQpBbHRob3VnaCBub3QgaW5kaWNhdGVkIGluIHRoZSBzdGFuZGFyZCwgSSB0aGluayBp
dCdzIGJldHRlciB0byBsZXQgU1RBDQpLbm93IEFQIGdvbmUgZG93biBieSBzZW5kaW5nIHRoaXMg
dW5pY2FzdCBkZWF1dGggdG8gZWFjaCBTVEENCihhcyB0aGlzIHBhdGNoIGRvZXMpLg0KDQpQbGVh
c2UgbGV0IG1lIGtub3cgeW91ciBkZWNpc2lvbi4NClNoYXkuDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KVGhlIGluZm9ybWF0aW9uIHRyYW5zbWl0dGVkIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQg
bWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkg
cmV0cmFuc21pc3Npb24sIGRpc3NlbWluYXRpb24sIGNvcHlpbmcgb3Igb3RoZXIgdXNlIG9mLCBv
ciB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24g
aXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IsIHBsZWFzZSBjb250
YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGUgbWF0ZXJpYWwgZnJvbSBhbnkgY29tcHV0ZXIu
IE5vdGhpbmcgY29udGFpbmVkIGhlcmVpbiBzaGFsbCBiZSBkZWVtZWQgYXMgYSByZXByZXNlbnRh
dGlvbiwgd2FycmFudHkgb3IgYSBjb21taXRtZW50IGJ5IENlbGVuby4gTm8gd2FycmFudGllcyBh
cmUgZXhwcmVzc2VkIG9yIGltcGxpZWQsIGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCBh
bnkgaW1wbGllZCB3YXJyYW50aWVzIG9mIG5vbi1pbmZyaW5nZW1lbnQsIG1lcmNoYW50YWJpbGl0
eSBhbmQgZml0bmVzcyBmb3IgYSBwYXJ0aWN1bGFyIHB1cnBvc2UuDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KDQo=
