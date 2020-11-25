Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBE2C3F3D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKYLlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 06:41:17 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:51746 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgKYLlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304472; x=1637840472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A3WG8JeKmtKktM0AXAH4zNnj2CBBDR9gbXQZhS7+CNg=;
  b=R2CjNddSLrzR6WP/3+qgJu+pVQ06Vq6RTbdLtIX6Vj7qQaFrup3CjP1Y
   VZXd3fuzxEzEZfo7VsgSS6MEBkwLYimfP8zfumtZ2NoA1umurhn074WtK
   3Q4IWSnm36zo3jmaKJuaALQRssL6ZgnSpbod2H7YoPELLKSEyNiKbVMKT
   TWBSST2aPeaFufuayjskBsWjV11Es2yGgANMUX728u7OS7rnXKwpavirL
   XY5cVuo16Ruz3gxdeQopWAlWAqAJ74fnN3lEfBsACTMit3nK/oZJRseu5
   f4UKBzmdxPyC/kOsYu7g07ZUozOjQ/ezYBFLS6r8tKn7euZfE/Zwl9usY
   g==;
IronPort-SDR: xHMedmEeQymC+J2fQ51CXn4wX0dCgbwYYR58yRYYliFjGmozK38zurd0G6Q/R5fjIIUEs6wdfj
 u8+BiZd8FgC5PYKVbVTy3JhazrinH6YEMXfqI4L9FYyvYxG5sQv7PmnMvCbyCFenElNF/X9fJX
 J8+j/RqhuM0dPfdPzObDAwTpIpw3JxQQYwIgXAP7xhWY+Gcks5rwq68Kf5sB5FaCsyxogYpRw9
 HWDwUT8LwLs+ZP/FCAU8KxUfDwQuHYTG/xDON/dI8sW79o+A0cEuu83SWRizrKL0/U73VludjB
 u3k=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="100348214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:41:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:41:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 25 Nov 2020 04:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNDhlZkCGg5KRHzvmbn5AmEuT6Ed/S0AFFq107BXmHxGtTiLT5xRGgs8rieOXYC9U6IIbqwmuqeYQq+ejtkxO66qhhSf7r1pjlYN6S1EZDhzcEWnsQNv9y38RGQXfkTNP2SH8SqtOhtHrf3JSfIfXPLFwlJwikCmRSAO3SkOBCw68xyn/vMtS/+VSowJJF8QOEjYjZvoT2Tk1SmOFx72N52KIz6+jB2wQWlgfLZE8SpryqLs5jn9quGBXUyamu4OlEoJq1TxWZWIYN515vlvo69E3CrhyU36S2OBAybEhtwJdkzcQbrSZuqpKEEmZ7xE9t4TvmGQ6Kn4kLyALxF4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZm5g0l1cmqyVi2oTs/++OzID7Ve4Usoydzo6NoBwYY=;
 b=fF1lhYCCvxPUQI57bW7gUD4hMApnx0EQzmkfludTKn1dNAwPly1x67adnHAYsMwC7oyP0Rc3MXAN3dktfE8xblWYEVxwoYFXEOG7vq3k3zvPPnBYVV9PLL4ChG0atlYDDiSdqrBaLB9tYCCG1f1BTCQT/hz33XxgMOiyns62+qmKF/F52gG0CtZclVZk12bLB2Fkp6x1TNDTPLk9zLNaxaDMdc9H2fEHWWO6A+XyAX6R5s6/RQ7XcFiiHNZpymMaKsgMy6jE2OL7ycVvD4cNDSGyBLVLR3G9UMk76LVRvIGWSzd/uNvwFa7oPkOzWP9tos8dvTId94LsDp4irr8Gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZm5g0l1cmqyVi2oTs/++OzID7Ve4Usoydzo6NoBwYY=;
 b=iBGl4Zlv1iUmQqyHM9k/GMmYcgNflLKl5GPek5FRzJSVHdkSsUhSFR8b9t6OxQKlwuT1kbqR85mUo6PUyVp5fMMY9e6a82dX3S7V9KZPzq+ePop/eaSZzA9lOrhkkc+mMhq08mGe0gBe/fjgPYMjJhT7BkxrjZfdUEZbEYrQfI4=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 11:41:08 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:41:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/5] wilc1000: free resource in wilc_wlan_txq_add_net_pkt()
 for failure path
Thread-Topic: [PATCH 2/5] wilc1000: free resource in
 wilc_wlan_txq_add_net_pkt() for failure path
Thread-Index: AQHWwx/dKVqWhS/yykqTuHgnqFj2eA==
Date:   Wed, 25 Nov 2020 11:41:08 +0000
Message-ID: <20201125114059.10006-3-ajay.kathat@microchip.com>
References: <20201125114059.10006-1-ajay.kathat@microchip.com>
In-Reply-To: <20201125114059.10006-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [171.61.34.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65225dc-574d-4be0-092c-08d891370064
x-ms-traffictypediagnostic: CY4PR11MB1605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1605495DD15584C8DF6FA5A6E3FA0@CY4PR11MB1605.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjAENITLYSCxMZ44ILPzzOHotTfuVL3YIIuRJDBjZtoLQefTYHjKMhIGIMUgxGHYQjiYVZZ78ZQ/oJtoOzI7IMAsK49OKCoKsDVeupFrmmU3V94er/wbtWJ6bM230nfHG+z3UXz0D9I0+F9oa63SL9B7cXDe4HEHI6FOy3gTlnGZQiaTmH9IQu9vh+9/6MOOZsd691LJiqjWQ7fjwpL6Pb9HACfNU3jnRueCRJzRxSXKALvzTCEF5G20u8OJlHntHAeQi/QadG5DQYK+VVze5KPIErXbmcCwlgeX1YgCUPBGtGZ7agU+kqA8ffYwojmug+XwE6BgizP9+zfFjYV4/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(66446008)(66556008)(107886003)(2616005)(6486002)(4326008)(4744005)(5660300002)(66476007)(36756003)(54906003)(71200400001)(76116006)(8936002)(64756008)(110136005)(2906002)(6506007)(66946007)(86362001)(186003)(91956017)(478600001)(83380400001)(26005)(316002)(8676002)(1076003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: a1t/SsJzG8ut4GOvDhUjiPljmhjfumZCSqqXa2zXYwTZEuhIaNGG2TeH4DBbxiB7W9CDus3J8FTLJ88wODPHEH3MfvYNRtwsOzuCIv0FkCQemaq/5fEvuZNFo3c8lDKunAZgOmdlGNpwrtoZCOIr5xXTq064OvV0C1qLPSesSwtSoOhHyR5p98HDXkj2fwbCFRKSgWri1xFJfKMvX1fXWsNtw/3qsqcWLPy0iSMqOluy4VrAmz1DNDDcbm+djk7ZjpRF5TX3fqB2/IAg87GwMs3aBbdSM1p/JUn6NfqMTAKK1yeKLX+8v5eLWhE4BMqkhijgM0dBTnzFkhqZNDzEax66Z15TQASa6z0jJ4Lxjp0OJTAHgoKC1qaHF1DO655TCXd7S8NvoSSGHKA/ePWemlvrS3SHXySM18yIG980hKlEsGomm0DP5p8vWkIG0F8eIcb2uQp6Qt6fMREQuA/H0KPGrfeq5zm2lU/VT5ker3zs39axoymOx7wEXpOOsgc+YuNhMXrk89X/AbwqczpBkjFt/X5WuJ8E0XwmH/bPB+SlmEGHIvZ+kcafWcWt93xpXdhwMkMPWQAgf6LTYnCf0pQC0F+PfZtPCNGePkBLioQAREAVuho9bzbaGlALFaTsVxKej9LhkMGL/t9CUln9rxKO03UEOs33CjhgXa+Tyxu1GyOkr3ZO1+pTPi99lTwZWXphF/LQ4GDKYUgn4exGDR0wSbBeU9SlCX0SUBd4GCdCb8PkZwF2Fhh8p4jwwUKzD2le9xrdVs/zhIgyUr31BtWAVHU4YArfzhNlCT7qOOb2i+jY79R54xpRdCYmycq5Qju8NN+iU1vDZXB/uAne0Iu3WRcFhIb7JnkBMUHMv5LcnBIJQJkElLWHynYELFYfI8yi1vvdXAqI1jHlX7fcSg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65225dc-574d-4be0-092c-08d891370064
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:41:08.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qx8GtEVz4NBFWAHP4Qf5IHInG9IhIHiIS5zNCkyeX0ou3GYoYTU3PNakxaajjsdSwlktvYXvIgzsiUHxZ40/9u5FNDgVVGMz6by63GMcWZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1605
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Before returing from wilc_wlan_txq_add_net_pkt() invoke tx_complete_fn()
callback to free up allocated memory for failure cases.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 6a82fb2f283e..f0cc2da7c9c7 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -284,13 +284,17 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev,=
 void *priv, u8 *buffer,
=20
 	wilc =3D vif->wilc;
=20
-	if (wilc->quit)
+	if (wilc->quit) {
+		tx_complete_fn(priv, 0);
 		return 0;
+	}
=20
 	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
=20
-	if (!tqe)
+	if (!tqe) {
+		tx_complete_fn(priv, 0);
 		return 0;
+	}
 	tqe->type =3D WILC_NET_PKT;
 	tqe->buffer =3D buffer;
 	tqe->buffer_size =3D buffer_size;
--=20
2.24.0
