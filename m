Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A61FF4D4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgFROga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 10:36:30 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:49598
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbgFROg2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 10:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqooawI+bROMcjmV/qmG1MVI4ptONJqTtlF660Zx2Ni5yy3DBytPJ5qpZ7rTrcKEopiOBTFDUw4o8ngamR1YfwdK9ItZ77qdoOWikdWzZaRWNnUoEMXBwUaJy5FBO9ZsZqIpX0SL3eGzUFmb6TPETq3iPaAnZRj7fJ2qSZYD4ZRd5/Yjfey8gYgmuTUR7GjizVWrCbNcxfrmm8SG/Pi37P3Q1fkdOEDkdM4VedrItM4ZzV+tBrfjn1ormU7Ut/hOFS5EPTZWBnhgUYzU8dCYik7/niI1cfcpb2LhXTWT4lpSu5/RS2RySSH9FfT5VJqu6tgVzpwGqkGxQTlgtne0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzq4v6P6j+gfmM93d6tebLbOmrx1SZsxOxne5jHnpfE=;
 b=JRRXQ1vY+591RfH35EB33g0dRCzAD+QO/AAsCCk2G7BbqiNIvcB8tcaTzASIVTF5NqK2qdwWMpWbFPpiEVdxVo8nmlGQ60DT+53drShkW2CJDLCvs3XlVb4K7+46tKblwTVzSJTRGdIVkTVhdma95J+hE4nYNkwZp7OicbPBryYZOGbvDx1PsZTryvw6MEpBHx4ivDkR4saRGQyOHhjTxw3jJaENCvPOaut4xLhWcUUZau3PBPc9I4dbZsjd9tXWMXlkDnkfQN/r9T9wQlNXisfrtevArm9QKQfordfbZQ44VN167+fyIaeMlcIRbhZAWACW8XgR4+/Iu8z9BDYd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzq4v6P6j+gfmM93d6tebLbOmrx1SZsxOxne5jHnpfE=;
 b=2r9MKWq7mjZOv4lTQpnPNclOfOOQ9uEj8VoAdJJ3KBVrw1D+xWujL8lIEAR721+5PSXpe22Wi7whdLOgETDsv0uVXFfZLRmEO/6Bdh6ga7WWvcfxc6uxPNpeL2AU+FKmMkjxesjwfSOJP4T9EGGeLLr1mVBHPMTXzkpWzJ5urlc=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 14:36:26 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 14:36:26 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/P6jeY6MUgAAEuiCAAAOSgIAAAEDQ
Date:   Thu, 18 Jun 2020 14:36:26 +0000
Message-ID: <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         (sfid-20200618_113627_790574_4007E613)
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
         <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
In-Reply-To: <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.70.42.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41fcdc4d-6ced-44ad-cb8d-08d81394fb4d
x-ms-traffictypediagnostic: AM0P192MB0452:
x-microsoft-antispam-prvs: <AM0P192MB0452AC2F8DCF7B41F7D9F1E7E79B0@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QpwgNSgAee4rS2PJ/IBWZlCPUuHXrYFfu+Tdht3asXJJV2leh2HcFhkm5a/5cLQ//JM9elV1ZEUSlTYBvMkJhwCSMJqqx8gbadwtUnmu+j+pt6Q9cpYyHpJuzBvitLNx58smkdb3Y/j5ZcDMwlm7BCoYcu/fIEfDzl+K7SDAhryiFozrgBH+BedzvgKUMezRd5rWQIh3XnBvcmpuv5948LJbi+1hHcA6HkDXQOOo9pshFPwVYbcx245FrkeJWDNXcquz/lgCC50PbrmMtcoURheyXTUKwx9NiU1irQcIG3tv3RSuWXGnOwb74kRzic/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(366004)(39840400004)(76116006)(86362001)(66946007)(4326008)(71200400001)(83380400001)(316002)(66476007)(33656002)(8936002)(2906002)(5660300002)(6506007)(52536014)(26005)(55016002)(9686003)(186003)(66556008)(64756008)(8676002)(66446008)(478600001)(6916009)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oObZhUeFmWVzFWyIXdKOWbHcrgupoCdiZnpp265P4SsIf2EEibCFBm671LvNReHOW8HBE3YS9OeAjNf4RuEPQUqVFBXpJfAaXIoAtUF+HOM1SD3FmFqr+28lpv49Rm63IslCkWEi6DvhLPeaMqLuZJtoSQNorMHYwfDVZMcy3qUyQsFb7QexfpSzq201iNKBZwBgbMuR2l2OZMdIpcMBHMN4iE3Xcc8LvNxgIv2q7Ql3Rmo6lWMnvIljKN1ZmXJGpk2JQQ+IKV0zr5xBJ3lf8j2faq6Th6iNirRDToLTKRhCAc4WaaP4/boUksCfTEQ9NudZnDPiN5BWzuxZOz97M7I686Rlau3RNqbHvB1CKMhtWYrunbFfxV2m7gCQjkU+6I/bhiCSR+nG+Hu85VYM9UmvJ3x9LPLL/9/L6cuUpaDMZTmAjok5YyHYHLLlPbuslX0IqJKcrcr6PTAM0AjDSHHa0NxIrXKck9+qbaEmsuM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fcdc4d-6ced-44ad-cb8d-08d81394fb4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 14:36:26.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOV9i73yJJuOTmn/Us0W7ldIWvqgjLrY3VHPHPEExxmkJ94T6X12jSNuB6d2onGt0lCoxGcXEHvIRClwFia/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBXZSdyZSBkb2luZyB0aGF0LiBNb3JlIGFjY3VyYXRlbHksIGhvc3RhcGQgaXMgZG9pbmcgdGhh
dC4gU28gd2hhdCdzIG5vdA0KPiB3b3JraW5nIGZvciB5b3U/DQo+IGpvaGFubmVzDQoNCkFpciBj
YXB0dXJlIHNob3dzLCBob3N0YXBkIGRvZXNu4oCZdCBzZW5kIGRlYXV0aCBpbiB0aGUgYmVsb3cg
MiBjYXNlcyBhbmQgSQ0KYWN0dWFsbHkgZG9uJ3Qgc2VlIHN1Y2ggaG9zdGFwZCBjb2RlIHRoYXQg
aGFuZGxlcyB0aGF0Og0KImlmY29uZmlnIDxpZj4gZG93biINCiJraWxsYWxsIGhvc3RhcGQiDQoN
CkFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KVGhlIGluZm9ybWF0aW9uIHRyYW5zbWl0dGVkIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBw
ZXJzb24gb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4g
Y29uZmlkZW50aWFsIGFuZC9vciBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV0cmFuc21pc3Np
b24sIGRpc3NlbWluYXRpb24sIGNvcHlpbmcgb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2Yg
YW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24gaXMgcHJvaGliaXRl
ZC4gSWYgeW91IHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5k
ZXIgYW5kIGRlbGV0ZSB0aGUgbWF0ZXJpYWwgZnJvbSBhbnkgY29tcHV0ZXIuIE5vdGhpbmcgY29u
dGFpbmVkIGhlcmVpbiBzaGFsbCBiZSBkZWVtZWQgYXMgYSByZXByZXNlbnRhdGlvbiwgd2FycmFu
dHkgb3IgYSBjb21taXRtZW50IGJ5IENlbGVuby4gTm8gd2FycmFudGllcyBhcmUgZXhwcmVzc2Vk
IG9yIGltcGxpZWQsIGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCBhbnkgaW1wbGllZCB3
YXJyYW50aWVzIG9mIG5vbi1pbmZyaW5nZW1lbnQsIG1lcmNoYW50YWJpbGl0eSBhbmQgZml0bmVz
cyBmb3IgYSBwYXJ0aWN1bGFyIHB1cnBvc2UuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KDQo=
