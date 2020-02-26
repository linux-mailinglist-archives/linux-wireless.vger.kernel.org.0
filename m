Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0017C16FC37
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2020 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBZK2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Feb 2020 05:28:54 -0500
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:35195
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbgBZK2y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Feb 2020 05:28:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXVV0gYDvMoWNqwDwNAI49x34CZ2AqAbBNgwf2OzJaffriVHf8aRYPgL+UDAbKR2f5CMjc2WWq1ZINwgJ/rXNrwAeXHZpXpC+2DJIMpC5107SLVvL0Ru9M11FNlYcDehFx/GWrZawqClIpzLf1X7MoTPeAKWj2PJBB6QtzXuTSZtrMBqgrs7o5W4NEE4PacMc3ieVIFqwWQpebRaic9kYE/gdQaIS6epzG2qfFLu0ycAVKuzLxyAJ8ngIxnohr6CQtrXz4boYtuKMTdrNRsY0k1oUHqqXo0FMcHkpei2N1heVmJsFn2IxknGAXzpFHIypmZeKcb5RNysKAm+RJsXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0hJHDHRFnD1Wq8PET39/frn8ymDptXVKzCZc/G2IkM=;
 b=J8J5h9qGbzrkPPeQNlk1ssu80tLCFkCTYm84X0kdd59usD1blhiexXDE6mMhN8gTQrcRreqymw6JveZzuj++HgyCYcd4vOL3lm6dDzULW8pQbzl3/TVeX+2JYqNlIwT6m/6CC74/el+vTgTjU0xIRLW08vsx8mAlk00+wRr+bNy+SHvBkBXgocdwYR/bSQ19PG7BT5kQkaS5As3Dpl+feJzsC+mPpQqQIzl7dtJ2oM0H8iy/mTaclqgx2yNaziTvUWPHcllEP0Gj51J6D+J8839zgBl1a7/4EYoITWMzD7S1Ca8Algtuw2btUXGsMESenhK+zzfOggMVjdEDeIUH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0hJHDHRFnD1Wq8PET39/frn8ymDptXVKzCZc/G2IkM=;
 b=TJzJxsXfZxQj0EMt7bjdWbyBT+nn36zyPp8FLJQrBS0Ca5O0A6lJqfwNPIovJKL6z2LzDvMXuuWF0BM94q7MuHC+Z4aqGlnxe1o8x3+C0uRJ1Hw9fi4NpdW4C6+9Os4w58fcS/HRDiRsEMq6Svk2DvksCra2QYrJefiIYgjnPHs=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB6325.eurprd01.prod.exchangelabs.com (20.180.3.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 10:28:51 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8182:86f9:16d5:e18c%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 10:28:51 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wds link and Radius authentication issue
Thread-Topic: wds link and Radius authentication issue
Thread-Index: AdXsjibtdxWH8Dl8Q0qO4Lm83lijWg==
Date:   Wed, 26 Feb 2020 10:28:51 +0000
Message-ID: <DB8PR01MB55294DD5307E8C6AAB2A2B0990EA0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af9a7838-f42f-4a65-5347-08d7baa6ac3d
x-ms-traffictypediagnostic: DB8PR01MB6325:
x-microsoft-antispam-prvs: <DB8PR01MB6325495CB8CF8F2653CFADBA90EA0@DB8PR01MB6325.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39830400003)(346002)(42606007)(136003)(376002)(199004)(189003)(7696005)(33656002)(9686003)(6506007)(81156014)(52536014)(26005)(86362001)(8936002)(8676002)(81166006)(76116006)(66946007)(5660300002)(316002)(55016002)(2906002)(66476007)(66446008)(6916009)(71200400001)(66556008)(508600001)(64756008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB6325;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: il4zRuJQ+ImAnYjrZyOw/U9w9QuNVrpDuCtJQaZ9htM7DLSMNWcwMtQAYzBaMh2lsJ3emE8ugWrxrTs7MlCXn6DC3Ri1rxn+9AJtgDu//gvWWmIkHnobNc6uhd7fHsKDqjsm+nrU2fTuUNRh2DcV9tMiliytgxb/ZmyZq0upC6beQ1GYCUKbhLdhFPeaI0aaYSFD/1r/plGY1nKQ+LKRy7XPI23NOr5BsEKKqBAor8VXKAnur8ZVctwoHNV8vVB+s4ITpHfYcawOo8UqA4o/Cssrhw25/F7AtzDi0UgZZbBoowMtzHAWZnBjDgluk3bDM+uVo3IV7EOrOptq4YO+VU8rtadJaRPBgkUVO1jTNpya5nXJ2eVi7o+93XLrkqglIbSaTRl8WE7DMn9gcShqnDyOSA/QTTTEHvCI1QJ5MTCQmjW/Rh/Jd+sgCx5Q/OiU
x-ms-exchange-antispam-messagedata: PqiA83sp6M88Kqo8lKphJseABguYAwMQpSZpTTAPGRAwlNzOUFWgj1fatGqR9okw6qRnl7d8xgKAfuUWa0RrwcyHSRkQ5mIfdMeI5KfAXwcxIxkFHL0qj8vge4rmwCUyau5rosGhTbvv6nT8SByl4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a7838-f42f-4a65-5347-08d7baa6ac3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 10:28:51.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZL3oHJbEMQqO208EXEGRHBVdm47dKxy7yk5v3WwQwYmGc/TD8UkNWIf8yR2WQsrhiYXz3fhHPJiJE7+K+Is5CAHe9OxF3V3MSx4TssR+hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6325
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

	Dear mailing list,=20

	I'm facing an issue when my equipement are configured with WDS and radius =
authentication.

	My both product (the AP and the sta) are using the same hostapd/wpa_suppli=
cant and wifi driver version.
	The wifi driver version is openwrt backport-5.4-rc8-1 package.

	My AP is configured to accept the WDS sta. In the AP side the ifname wlan0=
.sta1 are created and added in the bridge.
	My sta is configured to use the WDS addresses.

	If the security policy is configured to WPA-PSK and in the client side the=
 client if is added to the bridge, the communication work (I can ping my AP=
 from my sta).
	If the security policy is configured to WPA-EAP (I tested PEAP-MSCHAPV2 an=
d EAP-TLS) and the client if is in a bridge, the communication doesn't work=
.

	I did a Wireshark capture on other WIFI interface, the packet seem sent by=
 the AP and by the sta (I can see a broadcast frame sent, and the packet ty=
pe is data. I think it is the arp request). But these frames are not receiv=
ed (I make a wireshar capture on the sta and AP if, no arp frame are receiv=
ed).

	I don't know where I need to search to fix this issue. Could you give me s=
ome pointer/help to fix it.

	Thanks for your help.








