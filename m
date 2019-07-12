Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9D6638C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfGLB6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:58:51 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23268 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfGLB6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:58:51 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: aoiKRQk6rvjpVXqhLNG0Fn2OO1pByfnk5qnuOzrcXXMhQu09vQFrAjv9admHtko+Ikr0N/22UC
 PauJ47ZzLeJ6SIRZa2ZWpF0quReHwZGFjcPnIv2FP3f0gxdLizcJzP0rZg5TXmGrqN0k4gQaM3
 fxvGlqCmgL9XiXUlj4lqvrwcHB7bXdtbk7iDome4hnMcIjdLyW+16h5JvLIZC4IIdmo+xBqv15
 jaK0NJ44u6vg/ZyzZtK0wWoS0INh5NP7b8Cd2+zt+f5QuPSk5fO2Wytx5WFigPQNToYgY5JVHI
 XlA=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="40962323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:58:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:49 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwtiCe3tfKwenk35PCZ9Timpo1yreBHs+L8yssAoFkpm5gziI4xJfqPweUeZgq9iEgChYb1LljFFQqtpItJI400z21kD1CpRCqv/aqr/G4uvMIUL58Y8vZ9Bv0548mKVhxH8CZIRVsfVGUZr/V+encci13v/Tm4M+MbGp0ehtJaDHZZQ55Uqh9zEIUXY4JzgaJ60yV5EFaN41m+Jg50SuHROJLwph1guhcCfA24FUcrFQjYxKm59/QJrrW5iXCvRg/XfbH3vx542B9pjRpTZ984M2vH+bQ9QdFBqWIoln9n2BHeVdy4nu7LKdAXI2KuIcEk9vCBP9fsKAiQhNlBPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdw1sohRjzm0YCfslCebSgdVdDEDqIhKKynx9WmFdFI=;
 b=eQBcFPCxu8dwZAYb+1AEQBKkVT2T7kDfOgN1PwMwGkWICj/le7yiRLmC57eToR7An/piP6rbPnkymZc5e5pENWcTmZlIOxoK2uVEJ3/J3DN3LWahPfueywrQhFDedPw2IZdRjsaXpb0RITUcjdBdNUE1EpcN5mqZIH2TnbKYQrWOJiDoeoNe1sba1Ygy3mza43XHA25nMJZbIKeBgVwUJkHAzqaXNtikwsOkarEEro25OnMzl+othU81d4dExTe4Ydi/Go4Pk3dygpjuak770MU0Fhle77e0rv5vGnp8WaPyp7cdFf2iVuc368g8tj5wEjZg+6ww9wm2ni2C9G3C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdw1sohRjzm0YCfslCebSgdVdDEDqIhKKynx9WmFdFI=;
 b=H0Uv8IYh6TdoqLvmq1KNBec8A8cOyhWVc1HJO14E2eEzU51T/JKGlcPKd51w68MSDkGfKT+lRYCm3LTXA6k9PMHu4DRCFR0uTP7qGD3pUCxK1BfbEpZmpOWNyhohJA5q4LMG6erwcism6D5iPSuUVL24fND5b+xFf84h/nYtIhc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4179.namprd11.prod.outlook.com (10.255.128.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:47 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:47 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 03/16] wilc1000: add wilc_wlan_if.h
Thread-Topic: [PATCH v2 03/16] wilc1000: add wilc_wlan_if.h
Thread-Index: AQHVOFVXgZ6C3TyTf0iEispYhFpoGg==
Date:   Fri, 12 Jul 2019 01:58:46 +0000
Message-ID: <1562896697-8002-4-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c63cd677-c4d5-432c-a900-08d7066c79c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB4179;
x-ms-traffictypediagnostic: BN6PR11MB4179:
x-microsoft-antispam-prvs: <BN6PR11MB4179119A9870AA851619E40EE3F20@BN6PR11MB4179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(486006)(71190400001)(71200400001)(54906003)(102836004)(86362001)(316002)(36756003)(305945005)(6506007)(6916009)(99286004)(2616005)(478600001)(30864003)(2351001)(476003)(446003)(11346002)(78486014)(7736002)(68736007)(386003)(3846002)(66446008)(66476007)(8676002)(52116002)(8936002)(4326008)(66556008)(26005)(53946003)(5660300002)(2906002)(50226002)(14454004)(66946007)(6116002)(6486002)(6436002)(81166006)(186003)(6512007)(81156014)(66066001)(53936002)(256004)(25786009)(14444005)(107886003)(76176011)(5640700003)(2501003)(64756008)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4179;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2IIT0hM8dSaJjmPnlqXa7XYOCL6TUVamufnw50NWtvGcWrZxVweskmJfiMtFy6fOZMg6FjAw1riY15yRyWEKPC66s4P6Gq50eGar6yyb2WcpQvn99mbnUAGu9rcBm3XU3grqBY7zssa1Qec1A+UES+fhs5K2ea1GnSRCXuQI/R75/rNzneBQQwnXowD0DLoiSK2MeEhc4kXMYJ7Y5kasghYdSLf0UDhySpOKVgFPTK3+/QO7O+M9gz7vyqB+9ED1iDoa1t2nxUNP3hzhB3Rrn7kEB2LPlJZHMLvQ0D+4daPR+76ZAUv8SnYWNYhHrhT64ABR1TzNIXd8yaOWtauloPmTrX5a+XGHDOy7yQ8Y7gFmQMpBYnoDjXkmtsSZcn8h5LcCiSgkxvCPCqKyLq/kRSj9k0B4Fys3q7DrUK76P38=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c63cd677-c4d5-432c-a900-08d7066c79c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:46.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4179
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000//wilc_wlan_if.h' to
'/drivers/net/wireless/microchip/wilc1000/wilc_wlan_if.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wilc_wlan_if.h | 803 +++++++++++++++++=
++++
 1 file changed, 803 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_if.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wlan_if.h b/drive=
rs/net/wireless/microchip/wilc1000/wilc_wlan_if.h
new file mode 100644
index 0000000..b89d0e0
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wlan_if.h
@@ -0,0 +1,803 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_WLAN_IF_H
+#define WILC_WLAN_IF_H
+
+#include <linux/netdevice.h>
+
+/********************************************
+ *
+ *      Wlan Configuration ID
+ *
+ ********************************************/
+
+enum bss_types {
+	WILC_FW_BSS_TYPE_INFRA =3D 0,
+	WILC_FW_BSS_TYPE_INDEPENDENT,
+	WILC_FW_BSS_TYPE_AP,
+};
+
+enum {
+	WILC_FW_OPER_MODE_B_ONLY =3D 0,	 /* 1, 2 M, otherwise 5, 11 M */
+	WILC_FW_OPER_MODE_G_ONLY,	 /* 6,12,24 otherwise 9,18,36,48,54 */
+	WILC_FW_OPER_MODE_G_MIXED_11B_1, /* 1,2,5.5,11 otherwise all on */
+	WILC_FW_OPER_MODE_G_MIXED_11B_2, /* 1,2,5,11,6,12,24 otherwise all on */
+};
+
+enum {
+	WILC_FW_PREAMBLE_SHORT =3D 0,	/* Short Preamble */
+	WILC_FW_PREAMBLE_LONG =3D 1,	/* Long Preamble */
+	WILC_FW_PREAMBLE_AUTO =3D 2,	/* Auto Preamble Selection */
+};
+
+enum {
+	WILC_FW_PASSIVE_SCAN =3D 0,
+	WILC_FW_ACTIVE_SCAN =3D 1,
+};
+
+enum {
+	WILC_FW_NO_POWERSAVE =3D 0,
+	WILC_FW_MIN_FAST_PS =3D 1,
+	WILC_FW_MAX_FAST_PS =3D 2,
+	WILC_FW_MIN_PSPOLL_PS =3D 3,
+	WILC_FW_MAX_PSPOLL_PS =3D 4
+};
+
+enum chip_ps_states {
+	WILC_CHIP_WAKEDUP =3D 0,
+	WILC_CHIP_SLEEPING_AUTO =3D 1,
+	WILC_CHIP_SLEEPING_MANUAL =3D 2
+};
+
+enum bus_acquire {
+	WILC_BUS_ACQUIRE_ONLY =3D 0,
+	WILC_BUS_ACQUIRE_AND_WAKEUP =3D 1,
+};
+
+enum bus_release {
+	WILC_BUS_RELEASE_ONLY =3D 0,
+	WILC_BUS_RELEASE_ALLOW_SLEEP =3D 1,
+};
+
+enum {
+	WILC_FW_NO_ENCRYPT =3D 0,
+	WILC_FW_ENCRYPT_ENABLED =3D BIT(0),
+	WILC_FW_WEP =3D BIT(1),
+	WILC_FW_WEP_EXTENDED =3D BIT(2),
+	WILC_FW_WPA =3D BIT(3),
+	WILC_FW_WPA2 =3D BIT(4),
+	WILC_FW_AES =3D BIT(5),
+	WILC_FW_TKIP =3D BIT(6)
+};
+
+enum {
+	WILC_FW_SEC_NO =3D WILC_FW_NO_ENCRYPT,
+	WILC_FW_SEC_WEP =3D WILC_FW_WEP | WILC_FW_ENCRYPT_ENABLED,
+	WILC_FW_SEC_WEP_EXTENDED =3D WILC_FW_WEP_EXTENDED | WILC_FW_SEC_WEP,
+	WILC_FW_SEC_WPA =3D WILC_FW_WPA | WILC_FW_ENCRYPT_ENABLED,
+	WILC_FW_SEC_WPA_AES =3D WILC_FW_AES | WILC_FW_SEC_WPA,
+	WILC_FW_SEC_WPA_TKIP =3D WILC_FW_TKIP | WILC_FW_SEC_WPA,
+	WILC_FW_SEC_WPA2 =3D WILC_FW_WPA2 | WILC_FW_ENCRYPT_ENABLED,
+	WILC_FW_SEC_WPA2_AES =3D WILC_FW_AES | WILC_FW_SEC_WPA2,
+	WILC_FW_SEC_WPA2_TKIP =3D WILC_FW_TKIP | WILC_FW_SEC_WPA2
+};
+
+enum authtype {
+	WILC_FW_AUTH_OPEN_SYSTEM =3D 1,
+	WILC_FW_AUTH_SHARED_KEY =3D 2,
+	WILC_FW_AUTH_ANY =3D 3,
+	WILC_FW_AUTH_IEEE8021 =3D 5
+};
+
+enum site_survey {
+	WILC_FW_SITE_SURVEY_1CH =3D 0,
+	WILC_FW_SITE_SURVEY_ALL_CH =3D 1,
+	WILC_FW_SITE_SURVEY_OFF =3D 2
+};
+
+enum {
+	WILC_FW_ACK_POLICY_NORMAL =3D 0,
+	WILC_FW_ACK_NO_POLICY,
+};
+
+enum {
+	WILC_FW_REKEY_POLICY_DISABLE =3D 1,
+	WILC_FW_REKEY_POLICY_TIME_BASE,
+	WILC_FW_REKEY_POLICY_PKT_BASE,
+	WILC_FW_REKEY_POLICY_TIME_PKT_BASE
+};
+
+enum {
+	WILC_FW_FILTER_NO =3D 0x00,
+	WILC_FW_FILTER_AP_ONLY =3D 0x01,
+	WILC_FW_FILTER_STA_ONLY =3D 0x02
+};
+
+enum {
+	WILC_FW_11N_PROT_AUTO =3D 0,	/* Auto */
+	WILC_FW_11N_NO_PROT,		/* Do not use any protection */
+	WILC_FW_11N_PROT_ERP,		/* Protect all ERP frame exchanges */
+	WILC_FW_11N_PROT_HT,		/* Protect all HT frame exchanges  */
+	WILC_FW_11N_PROT_GF		/* Protect all GF frame exchanges  */
+};
+
+enum {
+	WILC_FW_ERP_PROT_SELF_CTS,
+	WILC_FW_ERP_PROT_RTS_CTS,
+};
+
+enum {
+	WILC_FW_11N_OP_MODE_HT_MIXED =3D 1,
+	WILC_FW_11N_OP_MODE_HT_ONLY_20MHZ,
+	WILC_FW_11N_OP_MODE_HT_ONLY_20_40MHZ,
+};
+
+enum {
+	WILC_FW_OBBS_NONHT_NO_DETECT =3D 0,
+	WILC_FW_OBBS_NONHT_DETECT_ONLY =3D 1,
+	WILC_FW_OBBS_NONHT_DETECT_PROTECT =3D 2,
+	WILC_FW_OBBS_NONHT_DETECT_PROTECT_REPORT =3D 3,
+};
+
+enum {
+	WILC_FW_HT_PROT_RTS_CTS_NONHT =3D 0,  /* RTS-CTS at non-HT rate */
+	WILC_FW_HT_PROT_FIRST_FRAME_NONHT,  /* First frame at non-HT rate */
+	WILC_FW_HT_PROT_LSIG_TXOP,	    /* LSIG TXOP Protection */
+	WILC_FW_HT_PROT_FIRST_FRAME_MIXED,  /* First frame at Mixed format */
+};
+
+enum {
+	WILC_FW_SMPS_MODE_STATIC =3D 1,
+	WILC_FW_SMPS_MODE_DYNAMIC =3D 2,
+	WILC_FW_SMPS_MODE_MIMO =3D 3,	/* power save disable */
+};
+
+enum {
+	WILC_FW_TX_RATE_AUTO =3D 0,
+	WILC_FW_TX_RATE_MBPS_1 =3D 1,
+	WILC_FW_TX_RATE_MBPS_2 =3D 2,
+	WILC_FW_TX_RATE_MBPS_5_5 =3D 5,
+	WILC_FW_TX_RATE_MBPS_11 =3D 11,
+	WILC_FW_TX_RATE_MBPS_6 =3D 6,
+	WILC_FW_TX_RATE_MBPS_9 =3D 9,
+	WILC_FW_TX_RATE_MBPS_12 =3D 12,
+	WILC_FW_TX_RATE_MBPS_18 =3D 18,
+	WILC_FW_TX_RATE_MBPS_24 =3D 24,
+	WILC_FW_TX_RATE_MBPS_36 =3D 36,
+	WILC_FW_TX_RATE_MBPS_48 =3D 48,
+	WILC_FW_TX_RATE_MBPS_54 =3D 54
+};
+
+enum {
+	WILC_FW_DEFAULT_SCAN =3D 0,
+	WILC_FW_USER_SCAN =3D BIT(0),
+	WILC_FW_OBSS_PERIODIC_SCAN =3D BIT(1),
+	WILC_FW_OBSS_ONETIME_SCAN =3D BIT(2)
+};
+
+enum {
+	WILC_FW_ACTION_FRM_IDX =3D 0,
+	WILC_FW_PROBE_REQ_IDX =3D 1
+};
+
+enum wid_type {
+	WID_CHAR		=3D 0,
+	WID_SHORT		=3D 1,
+	WID_INT			=3D 2,
+	WID_STR			=3D 3,
+	WID_BIN_DATA		=3D 4,
+	WID_BIN			=3D 5,
+};
+
+struct wid {
+	u16 id;
+	enum wid_type type;
+	s32 size;
+	s8 *val;
+};
+
+enum {
+	WID_NIL				=3D 0xffff,
+
+	/*
+	 *  BSS Type
+	 *  -----------------------------------------------------------
+	 *  Configuration : Infrastructure   Independent   Access Point
+	 *  Values to set :         0               1            2
+	 *  -----------------------------------------------------------
+	 */
+	WID_BSS_TYPE			=3D 0x0000,
+
+	/*
+	 *  Transmit Rate
+	 *  -----------------------------------------------------------
+	 *  Configuration : 1  2  5.5  11  6  9  12  18  24  36  48  54
+	 *  Values to set : 1  2    5  11  6  9  12  18  24  36  48  54
+	 *  -----------------------------------------------------------
+	 */
+	WID_CURRENT_TX_RATE		=3D 0x0001,
+
+	/*
+	 *  Channel
+	 *  -----------------------------------------------------------
+	 *  Configuration(g) : 1  2  3  4  5  6  7  8  9 10 11 12 13 14
+	 *  Values to set    : 1  2  3  4  5  6  7  8  9 10 11 12 13 14
+	 *  -----------------------------------------------------------
+	 */
+	WID_CURRENT_CHANNEL		=3D 0x0002,
+
+	/*
+	 *  Preamble
+	 *  -----------------------------------------------------------
+	 *  Configuration :    short    long      Auto
+	 *  Values to set :       0       1         2
+	 *  -----------------------------------------------------------
+	 */
+	WID_PREAMBLE			=3D 0x0003,
+
+	/*
+	 * 11g operating mode (ignored if 11g not present)
+	 *  -----------------------------------------------------------
+	 *  Configuration :   HighPerf  Compat(RSet #1) Compat(RSet #2)
+	 *  Values to set :          1               2               3
+	 *  -----------------------------------------------------------
+	 */
+	WID_11G_OPERATING_MODE		=3D 0x0004,
+
+	/*
+	 *  Mac status (response only)
+	 *  -----------------------------------------------------------
+	 *  Configuration :   disconnect  connect
+	 *  Values to get :          0       1
+	 *  -----------------------------------------------------------
+	 */
+	WID_STATUS			=3D 0x0005,
+
+	/*
+	 *  Scan type
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Passive Scanning   Active Scanning
+	 *  Values to set :                  0                 1
+	 *  -----------------------------------------------------------
+	 */
+	WID_SCAN_TYPE			=3D 0x0007,
+
+	/*
+	 *  Key Id (WEP default key Id)
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Any value between 0 to 3
+	 *  Values to set :   Same value. Default is 0
+	 *  -----------------------------------------------------------
+	 */
+	WID_KEY_ID			=3D 0x0009,
+
+	/*
+	 *  QoS Enable
+	 *  -----------------------------------------------------------
+	 *  Configuration :   QoS Disable   WMM Enable
+	 *  Values to set :   0             1
+	 *  -----------------------------------------------------------
+	 */
+	WID_QOS_ENABLE			=3D 0x000A,
+
+	/*
+	 *  Power Management
+	 *  -----------------------------------------------------------
+	 *  Configuration : NO_POWERSAVE MIN_POWERSAVE MAX_POWERSAVE
+	 *  Values to set : 0            1             2
+	 *  -----------------------------------------------------------
+	 */
+	WID_POWER_MANAGEMENT		=3D 0x000B,
+
+	/*
+	 *  WEP/802 11I Configuration
+	 *  -----------------------------------------------------------
+	 *  Configuration:Disable WP40 WP104 WPA-AES WPA-TKIP RSN-AES RSN-TKIP
+	 *  Values (0x)  :   00     03   07     29       49       31      51
+	 *  Configuration:WPA-AES+TKIP RSN-AES+TKIP
+	 *  Values (0x)  :      69        71
+	 *  -----------------------------------------------------------
+	 */
+	WID_11I_MODE			=3D 0x000C,
+
+	/*
+	 *  WEP Configuration: Used in BSS STA mode only when WEP is enabled
+	 *  -----------------------------------------------------------
+	 *  Configuration : Open System Shared Key Any Type | 802.1x Auth
+	 *  Values (0x)   :    01             02         03 |    BIT2
+	 *  -----------------------------------------------------------
+	 */
+	WID_AUTH_TYPE			=3D 0x000D,
+
+	/*
+	 *  Site Survey Type
+	 *  -----------------------------------------------------------
+	 *  Configuration       :  Values to set
+	 *  Survey 1 Channel    :  0
+	 *  survey all Channels :  1
+	 *  Disable Site Survey :  2
+	 *  -----------------------------------------------------------
+	 */
+	WID_SITE_SURVEY			=3D 0x000E,
+
+	/*
+	 *  Listen Interval
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Any value between 1 to 255
+	 *  Values to set :   Same value. Default is 3
+	 *  -----------------------------------------------------------
+	 */
+	WID_LISTEN_INTERVAL		=3D 0x000F,
+
+	/*
+	 *  DTIM Period
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Any value between 1 to 255
+	 *  Values to set :   Same value. Default is 3
+	 *  -----------------------------------------------------------
+	 */
+	WID_DTIM_PERIOD			=3D 0x0010,
+
+	/*
+	 *  ACK Policy
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Normal Ack            No Ack
+	 *  Values to set :       0                   1
+	 *  -----------------------------------------------------------
+	 */
+	WID_ACK_POLICY			=3D 0x0011,
+
+	/*
+	 *  Reset MAC (Set only)
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Don't Reset	Reset	No Request
+	 *  Values to set :       0               1	    2
+	 *  -----------------------------------------------------------
+	 */
+	WID_RESET			=3D 0x0012,
+
+	/*
+	 *  Broadcast SSID Option: Setting this will adhere to "" SSID element
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Enable             Disable
+	 *  Values to set :   1                  0
+	 *  -----------------------------------------------------------
+	 */
+	WID_BCAST_SSID			=3D 0x0015,
+
+	/*
+	 *  Disconnect (Station)
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Association ID
+	 *  Values to set :   Association ID
+	 *  -----------------------------------------------------------
+	 */
+	WID_DISCONNECT			=3D 0x0016,
+
+	/*
+	 *  11a Tx Power Level
+	 *  -----------------------------------------------------------
+	 *  Configuration : Sets TX Power (Higher the value greater the power)
+	 *  Values to set : Any value between 0 and 63 (inclusive Default 48)
+	 *  -----------------------------------------------------------
+	 */
+	WID_TX_POWER_LEVEL_11A		=3D 0x0018,
+
+	/*
+	 *  Group Key Update Policy Selection
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disabled timeBased packetBased timePacketBased
+	 *  Values to set :   1            2          3              4
+	 *  -----------------------------------------------------------
+	 */
+	WID_REKEY_POLICY		=3D 0x0019,
+
+	/*
+	 *  Allow Short Slot
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disallow Short Slot      Allow Short Slot
+	 *          (Enable Only Long Slot) (Enable Short Slot if applicable)
+	 *  Values to set :    0         1
+	 *  -----------------------------------------------------------
+	 */
+	WID_SHORT_SLOT_ALLOWED		=3D 0x001A,
+
+	WID_PHY_ACTIVE_REG		=3D 0x001B,
+
+	/*
+	 *  11b Tx Power Level
+	 *  -----------------------------------------------------------
+	 *  Configuration : Sets TX Power (Higher the value greater the power)
+	 *  Values to set : Any value between 0 and 63 (inclusive Default 48)
+	 *  -----------------------------------------------------------
+	 */
+	WID_TX_POWER_LEVEL_11B		=3D 0x001D,
+
+	/*
+	 *  Scan Request
+	 *  -----------------------------------------------------------
+	 *  Configuration : Request default scan
+	 *  Values to set : 0
+	 *  -----------------------------------------------------------
+	 */
+	WID_START_SCAN_REQ		=3D 0x001E,
+
+	/*
+	 *  Rssi (get only)
+	 *  -----------------------------------------------------------
+	 *  Configuration :
+	 *  Values to get : Rssi value
+	 *  -----------------------------------------------------------
+	 */
+	WID_RSSI			=3D 0x001F,
+
+	/*
+	 * Join Request
+	 *  -----------------------------------------------------------
+	 *  Configuration : Request to join
+	 *  Values to set : index of scan result
+	 *  -----------------------------------------------------------
+	 */
+	WID_JOIN_REQ			=3D 0x0020,
+
+	WID_LINKSPEED			=3D 0x0026,
+
+	/*
+	 *  Enable User Control of TX Power
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disable                  Enable
+	 *  Values to set :    0                       1
+	 *  -----------------------------------------------------------
+	 */
+	WID_USER_CONTROL_ON_TX_POWER	=3D 0x0027,
+
+	WID_MEMORY_ACCESS_8BIT		=3D 0x0029,
+
+	/*
+	 *  Enable Auto RX Sensitivity feature
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disable                  Enable
+	 *  Values to set :    0                       1
+	 *  -----------------------------------------------------------
+	 */
+	WID_AUTO_RX_SENSITIVITY		=3D 0x0032,
+
+	/*
+	 *  Receive Buffer Based Ack
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disable                  Enable
+	 *  Values to set :    0                       1
+	 *  -----------------------------------------------------------
+	 */
+	WID_DATAFLOW_CONTROL		=3D 0x0033,
+
+	/*
+	 *  Scan Filter
+	 *  -----------------------------------------------------------
+	 *  Configuration : Class       No filter   AP only   Station Only
+	 *  Values to set :                0           1           2
+	 *  Configuration : Priority    High Rssi   Low Rssi     Detect
+	 *  Values to set :                0          0x4         0x0
+	 *  Configuration : Channel     filter off  filter on
+	 *  Values to set :                0          0x10
+	 *  -----------------------------------------------------------
+	 */
+	WID_SCAN_FILTER			=3D 0x0036,
+
+	/*
+	 *  Link Loss Threshold (measure in the beacon period)
+	 *  -----------------------------------------------------------
+	 *  Configuration : Any value between 10 and 254(Set to 255 disable)
+	 *  Values to set : Same value. Default is 10
+	 *  -----------------------------------------------------------
+	 */
+	WID_LINK_LOSS_THRESHOLD		=3D 0x0037,
+
+	WID_ABORT_RUNNING_SCAN		=3D 0x003E,
+
+	/* NMAC Character WID list */
+	WID_WPS_START			=3D 0x0043,
+
+	/*
+	 *  Protection mode for MAC
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Auto  No protection  ERP    HT    GF
+	 *  Values to set :  0     1              2      3     4
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_PROT_MECH		=3D 0x0080,
+
+	/*
+	 *  ERP Protection type for MAC
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Self-CTS   RTS-CTS
+	 *  Values to set :  0          1
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_ERP_PROT_TYPE		=3D 0x0081,
+
+	/*
+	 *  HT Option Enable
+	 *  -----------------------------------------------------------
+	 *  Configuration :   HT Enable          HT Disable
+	 *  Values to set :   1                  0
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_ENABLE			=3D 0x0082,
+
+	/*
+	 *  11n Operating mode (Note that 11g operating mode will also be
+	 *  used in addition to this, if this is set to HT Mixed mode)
+	 *  -----------------------------------------------------------
+	 *   Configuration :  HT Mixed  HT Only-20MHz   HT Only-20/40MHz
+	 *  Values to set :     1         2               3
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_OPERATING_MODE		=3D 0x0083,
+
+	/*
+	 *  11n OBSS non-HT STA Detection flag
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Do not detect
+	 *  Values to set :  0
+	 *  Configuration :  Detect, do not protect or report
+	 *  Values to set :  1
+	 *  Configuration :  Detect, protect and do not report
+	 *  Values to set :  2
+	 *  Configuration :  Detect, protect and report to other BSS
+	 *  Values to set :  3
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_OBSS_NONHT_DETECTION	=3D 0x0084,
+
+	/*
+	 *  11n HT Protection Type
+	 *  -----------------------------------------------------------
+	 *  Configuration :  RTS-CTS   First Frame Exchange at non-HT-rate
+	 *  Values to set :  0         1
+	 *  Configuration :  LSIG TXOP First Frame Exchange in Mixed Fmt
+	 *  Values to set :  2         3
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_HT_PROT_TYPE		=3D 0x0085,
+
+	/*
+	 *  11n RIFS Protection Enable Flag
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Disable    Enable
+	 *  Values to set :  0          1
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_RIFS_PROT_ENABLE	=3D 0x0086,
+
+	/*
+	 *  SMPS Mode
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Static   Dynamic   MIMO (Power Save Disabled)
+	 *  Values to set :  1        2         3
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_SMPS_MODE		=3D 0x0087,
+
+	/*
+	 *  Current transmit MCS
+	 *  -----------------------------------------------------------
+	 *  Configuration :  MCS Index for data rate
+	 *  Values to set :  0 to 7
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_CURRENT_TX_MCS		=3D 0x0088,
+
+	WID_11N_PRINT_STATS		=3D 0x0089,
+
+	/*
+	 *  11n Short GI Enable Flag
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Disable    Enable
+	 *  Values to set :  0          1
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_SHORT_GI_ENABLE		=3D 0x008D,
+
+	/*
+	 *  11n RIFS Enable Flag
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Disable    Enable
+	 *  Values to set :  0          1
+	 *  -----------------------------------------------------------
+	 */
+	WID_RIFS_MODE			=3D 0x0094,
+
+	/*
+	 *  TX Abort Feature
+	 *  -----------------------------------------------------------
+	 *  Configuration :  Disable Self CTS    Enable Self CTS
+	 *  Values to set :             0                      1
+	 *  Configuration :  Disable TX Abort    Enable TX Abort
+	 *  Values to set :             2                      3
+	 *  Configuration :  Enable HW TX Abort Enable SW TX Abort
+	 *  Values to set :             4                      5
+	 *  -----------------------------------------------------------
+	 */
+	WID_TX_ABORT_CONFIG		=3D 0x00A1,
+
+	WID_REG_TSSI_11B_VALUE		=3D 0x00A6,
+	WID_REG_TSSI_11G_VALUE		=3D 0x00A7,
+	WID_REG_TSSI_11N_VALUE		=3D 0x00A8,
+	WID_TX_CALIBRATION		=3D 0x00A9,
+	WID_DSCR_TSSI_11B_VALUE		=3D 0x00AA,
+	WID_DSCR_TSSI_11G_VALUE		=3D 0x00AB,
+	WID_DSCR_TSSI_11N_VALUE		=3D 0x00AC,
+
+	/*
+	 *  Immediate Block-Ack Support
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disable                  Enable
+	 *  Values to set :    0                       1
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_IMMEDIATE_BA_ENABLED	=3D 0x00AF,
+
+	/*
+	 *  TXOP Disable Flag
+	 *  -----------------------------------------------------------
+	 *  Configuration : Disable                  Enable
+	 *  Values to set :    1                        0
+	 *  -----------------------------------------------------------
+	 */
+	WID_11N_TXOP_PROT_DISABLE	=3D 0x00B0,
+
+	WID_TX_POWER_LEVEL_11N		=3D 0x00B1,
+
+	/* Custom Character WID list */
+	/* SCAN Complete notification WID*/
+	WID_SCAN_COMPLETE		=3D 0x00C9,
+
+	WID_DEL_BEACON			=3D 0x00CA,
+
+	WID_LOG_TERMINAL_SWITCH		=3D 0x00CD,
+	WID_TX_POWER			=3D 0x00CE,
+	/*  EMAC Short WID list */
+	/*  RTS Threshold */
+	/*
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Any value between 256 to 2347
+	 *  Values to set :   Same value. Default is 2347
+	 *  -----------------------------------------------------------
+	 */
+	WID_RTS_THRESHOLD		=3D 0x1000,
+
+	/*
+	 *  Fragmentation Threshold
+	 *  -----------------------------------------------------------
+	 *  Configuration :   Any value between 256 to 2346
+	 *  Values to set :   Same value. Default is 2346
+	 *  -----------------------------------------------------------
+	 */
+	WID_FRAG_THRESHOLD		=3D 0x1001,
+
+	WID_SHORT_RETRY_LIMIT		=3D 0x1002,
+	WID_LONG_RETRY_LIMIT		=3D 0x1003,
+	WID_BEACON_INTERVAL		=3D 0x1006,
+	WID_MEMORY_ACCESS_16BIT		=3D 0x1008,
+	WID_PASSIVE_SCAN_TIME           =3D 0x100D,
+	WID_JOIN_START_TIMEOUT		=3D 0x100F,
+	WID_ASOC_TIMEOUT		=3D 0x1011,
+	WID_11I_PROTOCOL_TIMEOUT	=3D 0x1012,
+	WID_EAPOL_RESPONSE_TIMEOUT	=3D 0x1013,
+
+	/* NMAC Short WID list */
+	WID_11N_SIG_QUAL_VAL		=3D 0x1085,
+	WID_CCA_THRESHOLD		=3D 0x1087,
+
+	/* Custom Short WID list */
+
+	/* EMAC Integer WID list */
+	WID_FAILED_COUNT		=3D 0x2000,
+	WID_RETRY_COUNT			=3D 0x2001,
+	WID_MULTIPLE_RETRY_COUNT	=3D 0x2002,
+	WID_FRAME_DUPLICATE_COUNT	=3D 0x2003,
+	WID_ACK_FAILURE_COUNT		=3D 0x2004,
+	WID_RECEIVED_FRAGMENT_COUNT	=3D 0x2005,
+	WID_MCAST_RECEIVED_FRAME_COUNT	=3D 0x2006,
+	WID_FCS_ERROR_COUNT		=3D 0x2007,
+	WID_SUCCESS_FRAME_COUNT		=3D 0x2008,
+	WID_HUT_TX_COUNT		=3D 0x200A,
+	WID_TX_FRAGMENT_COUNT		=3D 0x200B,
+	WID_TX_MULTICAST_FRAME_COUNT	=3D 0x200C,
+	WID_RTS_SUCCESS_COUNT		=3D 0x200D,
+	WID_RTS_FAILURE_COUNT		=3D 0x200E,
+	WID_WEP_UNDECRYPTABLE_COUNT	=3D 0x200F,
+	WID_REKEY_PERIOD		=3D 0x2010,
+	WID_REKEY_PACKET_COUNT		=3D 0x2011,
+	WID_1X_SERV_ADDR		=3D 0x2012,
+	WID_STACK_IP_ADDR		=3D 0x2013,
+	WID_STACK_NETMASK_ADDR		=3D 0x2014,
+	WID_HW_RX_COUNT			=3D 0x2015,
+	WID_MEMORY_ADDRESS		=3D 0x201E,
+	WID_MEMORY_ACCESS_32BIT		=3D 0x201F,
+
+	/* NMAC Integer WID list */
+	/* Custom Integer WID list */
+	WID_GET_INACTIVE_TIME		=3D 0x2084,
+	WID_SET_OPERATION_MODE		=3D 0X2086,
+	/* EMAC String WID list */
+	WID_SSID			=3D 0x3000,
+	WID_FIRMWARE_VERSION		=3D 0x3001,
+	WID_OPERATIONAL_RATE_SET	=3D 0x3002,
+	WID_BSSID			=3D 0x3003,
+	WID_WEP_KEY_VALUE		=3D 0x3004,
+	WID_11I_PSK			=3D 0x3008,
+	WID_11E_P_ACTION_REQ		=3D 0x3009,
+	WID_1X_KEY			=3D 0x300A,
+	WID_HARDWARE_VERSION		=3D 0x300B,
+	WID_MAC_ADDR			=3D 0x300C,
+	WID_HUT_DEST_ADDR		=3D 0x300D,
+	WID_PHY_VERSION			=3D 0x300F,
+	WID_SUPP_USERNAME		=3D 0x3010,
+	WID_SUPP_PASSWORD		=3D 0x3011,
+	WID_SITE_SURVEY_RESULTS		=3D 0x3012,
+	WID_RX_POWER_LEVEL		=3D 0x3013,
+	WID_SET_STA_MAC_INACTIVE_TIME	=3D 0x3017,
+	WID_ADD_WEP_KEY			=3D 0x3019,
+	WID_REMOVE_WEP_KEY		=3D 0x301A,
+	WID_ADD_PTK			=3D 0x301B,
+	WID_ADD_RX_GTK			=3D 0x301C,
+	WID_ADD_TX_GTK			=3D 0x301D,
+	WID_REMOVE_KEY			=3D 0x301E,
+	WID_ASSOC_REQ_INFO		=3D 0x301F,
+	WID_ASSOC_RES_INFO		=3D 0x3020,
+	WID_MANUFACTURER		=3D 0x3026, /*Added for CAPI tool */
+	WID_MODEL_NAME			=3D 0x3027, /*Added for CAPI tool */
+	WID_MODEL_NUM			=3D 0x3028, /*Added for CAPI tool */
+	WID_DEVICE_NAME			=3D 0x3029, /*Added for CAPI tool */
+	WID_SET_DRV_HANDLER		=3D 0x3079,
+
+	/* NMAC String WID list */
+	WID_11N_P_ACTION_REQ		=3D 0x3080,
+	WID_HUT_TEST_ID			=3D 0x3081,
+	WID_PMKID_INFO			=3D 0x3082,
+	WID_FIRMWARE_INFO		=3D 0x3083,
+	WID_REGISTER_FRAME		=3D 0x3084,
+	WID_DEL_ALL_STA			=3D 0x3085,
+	WID_REMAIN_ON_CHAN		=3D 0x3996,
+	WID_SSID_PROBE_REQ		=3D 0x3997,
+	WID_JOIN_REQ_EXTENDED		=3D 0x3998,
+
+	WID_IP_ADDRESS			=3D 0x3999,
+
+	/* Custom String WID list */
+
+	/* EMAC Binary WID list */
+	WID_UAPSD_CONFIG		=3D 0x4001,
+	WID_UAPSD_STATUS		=3D 0x4002,
+	WID_WMM_AP_AC_PARAMS		=3D 0x4003,
+	WID_WMM_STA_AC_PARAMS		=3D 0x4004,
+	WID_NETWORK_INFO		=3D 0x4005,
+	WID_STA_JOIN_INFO		=3D 0x4006,
+	WID_CONNECTED_STA_LIST		=3D 0x4007,
+
+	/* NMAC Binary WID list */
+	WID_11N_AUTORATE_TABLE		=3D 0x4080,
+
+	WID_SCAN_CHANNEL_LIST		=3D 0x4084,
+
+	WID_INFO_ELEMENT_PROBE		=3D 0x4085,
+	WID_INFO_ELEMENT_ASSOCIATE	=3D 0x4086,
+	WID_ADD_STA			=3D 0X4087,
+	WID_REMOVE_STA			=3D 0X4088,
+	WID_EDIT_STA			=3D 0X4089,
+	WID_ADD_BEACON			=3D 0x408a,
+
+	WID_SETUP_MULTICAST_FILTER	=3D 0x408b,
+
+	/* Miscellaneous WIDs */
+	WID_ALL				=3D 0x7FFE,
+	WID_MAX				=3D 0xFFFF
+};
+
+#endif
--=20
2.7.4

