Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0B1FF535
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgFROpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 10:45:40 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:6021
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731123AbgFROpg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 10:45:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN03eAEzSdBJVtjVpYKafuOjVQrMprF0khD0zhb1UUK9Tn9wbS3tilxrZPvDYv+P61HFk4E+wu4lMcnTIvsRp0Goo8HkdR8ko1hyZPoA8CJBPe0p6zpdqPSpnUuW2stlh2Gg2MYMcvlY1xeX89415HrDto+upc8KkP2osPswY9jirtbU6pXb7YhYfdUeB2mnn/52nU1SRDJI84atl3TW1BVYMJfYVWi9HQcHEZRq7cd+mivqBvpf2Ywa2ol7ElSXd/r8Q6uzC50UfFNlBYmu9ZE3jZC1PMYnrxkN9VQhJjzuj0nVMmCcCbd+KiIBFyWW4HxGdM7N9AzI50qdjkp2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctplI59t0wgfB5Kgv40ZAzckyNUr6Q6La6cWsaBgH2I=;
 b=ZNnAGq1dtO9VJKs76u9mYxRqoIXaPokZMwj09Mt0wDSy0iLbMd8xdAL/FE7ctHk9+Wsy6Lu4nL57KOS0qVnnMl7vMEgruNmExD0hsHJNexEpVihI7SaMdUmsGMRA87MuhAIwG8Gs6Bg0V4S0JGTkseLK+x/iqqbzI96Qx7Axgcs3MIwnsE0Hj3nXDPM1AdqCxYrn9gYjb1dibcscZ3tzOcF7ZtaqMkKxoAvMYDqtxQoE07dTL70PyuJ5fSpfKvU6KbMTKe+wz+hhQV7fWu9igeyv2mjoXhgjzQgkcIxNaukq79tctJIv0yH7BEU5B/8SGwStodsFppEF0LwEkrqhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctplI59t0wgfB5Kgv40ZAzckyNUr6Q6La6cWsaBgH2I=;
 b=XGtMF/Vws+lD2p2S7ECXOf4RhslyINkG/pusYD9FS+25dIfraNMDJ/tcvZjf8KUlFKdOZstH5evN+PraBA+6O2EH5FcCOxydukGnmD6/iIzDMVgIYOnfU2ezXOoD7+9qwSXX4Cp1QUwizGBHzbvFmKjw/bdWj9dXuADY3TkvCQM=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0356.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 14:45:32 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 14:45:32 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Topic: [PATCH] mac80211: Send deauth to STA's upon AP stop
Thread-Index: AQHWRVPx7SBnzBH8kkanFbiH9ch/P6jeY6MUgAAEuiCAAAOSgIAAAEDQgAAFdwCAAABFsA==
Date:   Thu, 18 Jun 2020 14:45:32 +0000
Message-ID: <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         (sfid-20200618_113627_790574_4007E613)
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
         <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
         <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
In-Reply-To: <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
x-originating-ip: [87.70.42.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ee708e-67fd-4e9a-c5d4-08d8139640dd
x-ms-traffictypediagnostic: AM0P192MB0356:
x-microsoft-antispam-prvs: <AM0P192MB03569941DDBC95C3C186B13FE79B0@AM0P192MB0356.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bZq+NQd9AoXTWkYV0Lob6lFT9nbmNDVk6c+lqYNAWpFfUh9ZtVRDtnSS+z3gCfVmo5okCb4QYk9N6z22Bf3zq85ziCM++/OsTt2hw73SDHcWIil0Wo7SvAkgjqG5ogyyRmTdXjcHI6hwZMdrReRoq2aiqd3f9Ze3W8x38oK+N6KUr24ba/4Nw2Pa9LjrMTqt/4j1JBcYvvPof6ltwcbcLwTbAsaUL33qSzcrzI6eABz3fir4JBs5CfdXrE/ORnbLZ6sia0MZL0AfUQcFKLwOLI0NWtzNbLuY+FwdTudeDFS7nb/V/PzFoWHvXmzdiSu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39840400004)(136003)(396003)(346002)(86362001)(55016002)(9686003)(7696005)(4326008)(5660300002)(71200400001)(478600001)(33656002)(6916009)(64756008)(8936002)(76116006)(316002)(186003)(66946007)(66446008)(66476007)(26005)(66556008)(2906002)(6506007)(52536014)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 45jaDTo2MVQ+iqVWzUDyW5DvHvJXM4VdsxdrRNtXupSGm/BX1l7bi5hrASLjMjoqr5hui3c8P+C7UfYZyAMhcwQz7Kygq32mCp92OiL+gYtVSwcg0DygCaASkBZbOu1LbEiuSmZGtrmAbJKmBBIAouke4qWkKfkVDyDVu6asELFrTY/1Ic/xACw8fZVkHYZsXuNUx+8KPZhsRnm4i+k1lb1Bi5JNZ9VCwJf4oj3KJMBLOuh1WcMz8BrJ1vC9I1b526BCH8TdiKmQsnEDxwqwIReJaluYF3nt3Nb7vxBiNdiiL4jyNJMis9WbG+B8DrczlFAo+8ghOP1f29y7wqkEJEo4yTXmHFCngfkBlY6ewlkivAxwaB1+GxbaWMK0RbFvUX3AsoOM77CpTgxhplYWcLcP40ulQx/8JYqkWE4LHD9csVpqAHBkIvJlpUCq8XaESDqOU2P10GS92OddGaLQVq1rIkdYupk2rJ4YiCDxffg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ee708e-67fd-4e9a-c5d4-08d8139640dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 14:45:32.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V7G5T15AL63C/aRS7ruH6nmBkbvoeF/a5RQDxTcVmWvHu7dlSQB9tZkxOw5NVqkQp76vL4I41/QDFJk1h4mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0356
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBTby4uLiB3aHkgd291bGQgeW91IGV2ZXIgZG8gdGhhdD8gOikNCj4gam9oYW5uZXMNCg0KOikN
CklzIGl0IGlsbGVnYWwgdG8gZG8gImlmY29uZmlnIDxpZj4gZG93biIgb3Iga2lsbCBob3N0YXBk
DQp3aGlsZSBTVEEncyBhcmUgc3RpbGwgYXNzb2NpYXRlZD8NClRoZXJlIGFyZSBzb21lIHZlbmRv
cnMvdXNlcnMgdGhhdCBhcmUgZG9pbmcgdGhhdC4NCg0KUmVnYXJkaW5nIEJlbidzIHByb3Bvc2Fs
IG9mIHVzaW5nIDExay92LCBJIGNvdWxkbuKAmXQgZmluZCBzdWNoDQoiZ29pbmcgZG93biIgc2lu
Z2xlIGZyYW1lIGluIHRoZSBzdGFuZGFyZCAoYWx0aG91Z2ggc291bmRzIHRyaXZpYWwpDQoNClNo
YXkuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVGhlIGluZm9ybWF0aW9uIHRy
YW5zbWl0dGVkIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRvIHdo
aWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciBw
cml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV0cmFuc21pc3Npb24sIGRpc3NlbWluYXRpb24sIGNv
cHlpbmcgb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5j
ZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24gaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmVkIHRo
aXMgaW4gZXJyb3IsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGUgbWF0
ZXJpYWwgZnJvbSBhbnkgY29tcHV0ZXIuIE5vdGhpbmcgY29udGFpbmVkIGhlcmVpbiBzaGFsbCBi
ZSBkZWVtZWQgYXMgYSByZXByZXNlbnRhdGlvbiwgd2FycmFudHkgb3IgYSBjb21taXRtZW50IGJ5
IENlbGVuby4gTm8gd2FycmFudGllcyBhcmUgZXhwcmVzc2VkIG9yIGltcGxpZWQsIGluY2x1ZGlu
ZywgYnV0IG5vdCBsaW1pdGVkIHRvLCBhbnkgaW1wbGllZCB3YXJyYW50aWVzIG9mIG5vbi1pbmZy
aW5nZW1lbnQsIG1lcmNoYW50YWJpbGl0eSBhbmQgZml0bmVzcyBmb3IgYSBwYXJ0aWN1bGFyIHB1
cnBvc2UuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQo=
