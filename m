Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A696E1FAA7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfEOT2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 15:28:34 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:61143
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbfEOT2d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 15:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bowerswilkins.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t5RQyY4opltNV2SxvLc12fTsmNzAbNTwSpXWmaJ8/g=;
 b=XedgBruGVvjAFp/RDjkRfEqFTxm7cG0Oo6O8LreBNB6aROwJZ+H9zIdG9g92PaCO7CH+Z0+yQ9nkYlvLZmg9kTqcshDRqK5BV6LYw8es3XEBCSysaLfko2gu/luy/f7MS9iQv7/qGMhLXMzBXLHHCuh81cFgFNAsLCbJGn1BRQc=
Received: from AM0PR04MB6065.eurprd04.prod.outlook.com (20.179.32.150) by
 AM0PR04MB6323.eurprd04.prod.outlook.com (20.179.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 19:28:29 +0000
Received: from AM0PR04MB6065.eurprd04.prod.outlook.com
 ([fe80::485d:efe5:102e:2989]) by AM0PR04MB6065.eurprd04.prod.outlook.com
 ([fe80::485d:efe5:102e:2989%3]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 19:28:29 +0000
From:   Peter Oh <peter.oh@bowerswilkins.com>
To:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>
CC:     Peter Oh <peter.oh@bowerswilkins.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH v3] wireless-regdb: Update regulatory rules for South Korea
Thread-Topic: [PATCH v3] wireless-regdb: Update regulatory rules for South
 Korea
Thread-Index: AQHVC1RfL7zm5Gang0mmJUT3y2ZM4A==
Date:   Wed, 15 May 2019 19:28:29 +0000
Message-ID: <1557948501-12579-1-git-send-email-peter.oh@bowerswilkins.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To AM0PR04MB6065.eurprd04.prod.outlook.com
 (2603:10a6:208:139::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.oh@bowerswilkins.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [12.244.182.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f506bfb4-44a8-4cc4-57c2-08d6d96b820f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR04MB6323;
x-ms-traffictypediagnostic: AM0PR04MB6323:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <AM0PR04MB6323EC6169F2D485A5C1094299090@AM0PR04MB6323.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39850400004)(376002)(346002)(199004)(189003)(50226002)(81166006)(8936002)(8676002)(81156014)(7736002)(486006)(6486002)(476003)(2616005)(478600001)(44832011)(53936002)(305945005)(386003)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(966005)(6916009)(6306002)(6512007)(26005)(7110500001)(186003)(2351001)(68736007)(6436002)(25786009)(5660300002)(15650500001)(5640700003)(2420400007)(316002)(86362001)(71200400001)(71190400001)(54906003)(36756003)(2501003)(102836004)(14454004)(14444005)(256004)(4326008)(99286004)(3846002)(6116002)(52116002)(2906002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6323;H:AM0PR04MB6065.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bowerswilkins.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6O6/mA5e533P9oymyDFJkGMlVoC5mjhllKLLTaKDiHs4ct/4nYX+sd/IvRvgdz5U0FyIiow7Yw5yI8o5vVfDnyBY8EBun6EIQXkvlVUXe2vEwPpVjRdm9b8lWJgrgVoONz/6zIkk1cfScuuShGEjPG9OFYbAD3WXRH/oMlI78mOBIvFRHXL9zBdJm7Ej1wQI1s4v/6Art2fHt546DTDoqQQmBSuju4hJsLZODno2gn3xWQrec8lfBN/rF7qKBVrSCuxylX+Ei4bJGNpFIwWJ5YVt5Xh+u5YjwAyMphNutkr7QOXNrQGShQ9x1Fw6rYLmTi3Q9HNATQBiVZRf7lKmRiMNMMWog1Gik8v4FkHKzeTENE5bOuHwF4PQeHY2kD50/QzXNxaDDlvQqws7jsic/5K7SthCuPd6bYlmQh/ZSLs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bowerswilkins.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f506bfb4-44a8-4cc4-57c2-08d6d96b820f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 19:28:29.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a75a45bb-4772-448f-a2c6-9d2413d86410
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6323
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogUGV0ZXIgT2ggPHBldGVyLm9oQGJvd2Vyc3dpbGtpbnMuY29tPg0KDQpVcGRhdGUgcG93
ZXIgbGltaXQgYXMgZG9jdW1lbnRlZCBpbjoNCmh0dHA6Ly93d3cubGF3LmdvLmtyLyVFRCU5NiU4
OSVFQyVBMCU5NSVFQSVCNyU5QyVFQyVCOSU5OS8NCiVFQyU4QiVBMCVFQSVCMyVBMCVFRCU5NSU5
OCVFQyVBNyU4MCVFQyU5NSU4NCVFQiU4QiU4OCVFRA0KJTk1JTk4JUVBJUIzJUEwJUVBJUIwJTlD
JUVDJTg0JUE0JUVEJTk1JUEwJUVDJTg4JTk4JUVDJTlFDQolODglRUIlOEElOTQlRUIlQUMlQjQl
RUMlODQlQTAlRUElQjUlQUQlRUMlOUElQTklRUIlQUMlQjQNCiVFQyU4NCVBMCVFQSVCOCVCMCVF
QSVCOCVCMC8oMjAxOC04OSwyMDE4MTIyNykNCndoaWNoIHJldmlzZWQgb24gRGVjZW1iZXIgMjcs
IDIwMTguDQoNClNpZ25lZC1vZmYtYnk6IFBldGVyIE9oIDxwZXRlci5vaEBib3dlcnN3aWxraW5z
LmNvbT4NCi0tLQ0KIGRiLnR4dCB8IDExICsrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RiLnR4dCBiL2Ri
LnR4dA0KaW5kZXggNGZiMTk0OC4uNmU1MDE5ZiAxMDA2NDQNCi0tLSBhL2RiLnR4dA0KKysrIGIv
ZGIudHh0DQpAQCAtNjk1LDExICs2OTUsMTIgQEAgY291bnRyeSBLUDogREZTLUpQDQogCSg1NzM1
IC0gNTgxNSBAIDIwKSwgKDMwKQ0KIA0KIGNvdW50cnkgS1I6IERGUy1KUA0KLQkoMjQwMiAtIDI0
ODIgQCA0MCksICgxMykNCi0JKDUxNzAgLSA1MjUwIEAgODApLCAoMjApLCBBVVRPLUJXDQotCSg1
MjUwIC0gNTMzMCBAIDgwKSwgKDIwKSwgREZTLCBBVVRPLUJXDQotCSg1NDkwIC0gNTcxMCBAIDE2
MCksICgzMCksIERGUw0KLQkoNTczNSAtIDU4MzUgQCA4MCksICgzMCkNCisJIyByZWY6IGh0dHBz
Oi8vd3d3LnJyYS5nby5rcg0KKwkoMjQwMCAtIDI0ODMuNSBAIDQwKSwgKDIzKQ0KKwkoNTE1MCAt
IDUyNTAgQCA4MCksICgyMyksIEFVVE8tQlcNCisJKDUyNTAgLSA1MzUwIEAgODApLCAoMjApLCBE
RlMsIEFVVE8tQlcNCisJKDU0NzAgLSA1NzI1IEAgMTYwKSwgKDIwKSwgREZTDQorCSg1NzI1IC0g
NTgzNSBAIDgwKSwgKDIzKQ0KIAkjIDYwIEdIeiBiYW5kIGNoYW5uZWxzIDEtNCwNCiAJIyByZWY6
IGh0dHA6Ly93d3cubGF3LmdvLmtyLyVFRCU5NiU4OSVFQyVBMCU5NSVFQSVCNyU5QyVFQyVCOSU5
OS8lRUIlQUMlQjQlRUMlODQlQTAlRUMlODQlQTQlRUIlQjklODQlRUElQjclOUMlRUMlQjklOTkN
CiAJKDU3MDAwIC0gNjYwMDAgQCAyMTYwKSwgKDQzKQ0KLS0gDQoyLjcuNA0KDQo=
