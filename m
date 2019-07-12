Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929536638E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfGLB65 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:58:57 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:22932 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfGLB65 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:58:57 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: k5H2GEA6wgcaAK3vDNenUWC2AMBx/kLtrecFIBip9Qrn8r8uWQU2qedqyW22KLAOKo804TqSeu
 +QvDDmWLKBIhYB3rIEFr7MlllKr03zwf1v1pzM8KLIvQwWmHj7kB5tGoTJDPpEz0yxEEcCUrSz
 7KGdR1mbRF6HqRG0i3ULu07MbBR9GOmDMJCQZQhVT0uVHJ6Xngp/xorqu98vpMUjy0wGtsNlGW
 /+05x3YoVRRh1dRBW8uk5cm3YS3YaF6+5cGklxAJ9bG44BxX1yWDZTHWpHOcylx5JHASgC6f72
 yIs=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="41020061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:58:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:55 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUYUrf1/NlQq7bVBerBoOASnVaGcCPh1x/kcoUVrEo54Bq3dZ32g5+Yj7ZHEvML980LJlUM5GRkiaQxJ05HG/1D5wgG/FzYQ7AyhR09OPsuue71t8ot3RJe9l8xRrlFEZN7GYpx/mZ19cMHud39yTkOIuXNv8WYxRNUnwvA6Gr0xRn1I6a5T+U0t7RLcyzR3DO9Ladzwukqt4SVoynWI6A0p4vOWEhvZAwP2EjIHFo9qAOrloa+7vonAEFmaH/lpoqa6MOQcngPunfKM7z9ppbmg2nBYq4Fff87cwRE7opXqz9+Ot91jh8RXBHLljqosHyFG5t4joTIiQhnmFuT9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcsquCUA3DtVlP+6L5fY8G2dnM/g8GgQzU6A+Y1FvVw=;
 b=kY0/W3OWcg6yTdTz/f8KVZBTBRvYnHRMhuV/zFEKnFG/h6ul/kZ8PToBHhPMcaT1ssJOYj6YvSX3Ofw4TzaVCfVLY9xKn6ob9RYlPCvhc4wfV8GKvjrTntywveGF6oJyr69ENeMJig2bDGs2zV6WRg/4buvhDBLRxdpYc3oTM1pUTfkmAgi23jFyzEtrNrkGwbU+S7/ydja3fCAAqXvQzIkSgR2+TezrM+dey7fagekZ4vaTmYh9ZgVon2In1to/0LZIb2IZY2ETLVP1xroltOTurdcIGdUETFKkxcwhS0e1JfTpsJ+ir5kE1dEjRGlmoqgJa/3iByWRmA4pzt5c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcsquCUA3DtVlP+6L5fY8G2dnM/g8GgQzU6A+Y1FvVw=;
 b=nRgJflpbe5pauq5b5k34oqC5U+2tU6yoBM7yCu4iq5cAnWaWr0EDO2SUPZpfFdXq2vCvdT+qDzD4PutrcL/NcemDXpBC7BYP0cef+Fxz2HE9DWn81F88de7xZn0XqqVOVVulJXfIISmNtKfbxIOcFx+25GSMXPw2Kgv0NCN7TDc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:54 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:54 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 05/16] wilc1000: add wilc_wlan_cfg.c
Thread-Topic: [PATCH v2 05/16] wilc1000: add wilc_wlan_cfg.c
Thread-Index: AQHVOFVbjOwWdHElO0GO3dM32GKxng==
Date:   Fri, 12 Jul 2019 01:58:54 +0000
Message-ID: <1562896697-8002-6-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 94dc806c-bc76-4431-f899-08d7066c7e1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB14257113AF56A3CBE30864D5E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(3846002)(8936002)(305945005)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mtqr0bZm8W8PIPpvEqiVJC0/oe8GV1Li4YeYQ6ZMzJwd/61P+xtTq5MC7rxQiVLL2DoxRuxCiKpnYPFZgusq199/sLMUkUbZtS6apznG/hJ+C8pWAPeqKnGqpjFEFl51HzuuZEIFKqjKp3kxtcfQXV8v/T2/yc3BBxTCTf1zv6ZqLFim6jbNj77YTWpCzyft4k92w2+T0/o/TvSS8lDi9GcXquHXzJrIwYa7ndraWHpFlaTlfgZHlvH3KiWzVuE0fVeW5nghlFpVmxqR9qfRqnqtdtNY5L9yasyJ3lVPuxr9tt2Hxlc3q04ulwx0pncVPKT3gjmjkUB3LYz42VEM9Ch0eSjoPcBLYtRHhNGWsO+JET9oE4yBr2H055QArQwWbDTTRdOtgAnbM+hIiyvAg14JHibz+43dNRq/dF/XqTU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dc806c-bc76-4431-f899-08d7066c7e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:54.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_wlan_cfg.c' to
'/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/wilc_wlan_cfg.c    | 495 +++++++++++++++++=
++++
 1 file changed, 495 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c b/driv=
ers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c
new file mode 100644
index 0000000..9dc5de4
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wlan_cfg.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include "wilc_wlan_if.h"
+#include "wilc_wlan.h"
+#include "wilc_wlan_cfg.h"
+#include "wilc_wfi_netdevice.h"
+
+enum cfg_cmd_type {
+	CFG_BYTE_CMD	=3D 0,
+	CFG_HWORD_CMD	=3D 1,
+	CFG_WORD_CMD	=3D 2,
+	CFG_STR_CMD	=3D 3,
+	CFG_BIN_CMD	=3D 4
+};
+
+static const struct wilc_cfg_byte g_cfg_byte[] =3D {
+	{WID_STATUS, 0},
+	{WID_RSSI, 0},
+	{WID_LINKSPEED, 0},
+	{WID_NIL, 0}
+};
+
+static const struct wilc_cfg_hword g_cfg_hword[] =3D {
+	{WID_NIL, 0}
+};
+
+static const struct wilc_cfg_word g_cfg_word[] =3D {
+	{WID_FAILED_COUNT, 0},
+	{WID_RECEIVED_FRAGMENT_COUNT, 0},
+	{WID_SUCCESS_FRAME_COUNT, 0},
+	{WID_GET_INACTIVE_TIME, 0},
+	{WID_NIL, 0}
+
+};
+
+static const struct wilc_cfg_str g_cfg_str[] =3D {
+	{WID_FIRMWARE_VERSION, NULL},
+	{WID_MAC_ADDR, NULL},
+	{WID_ASSOC_RES_INFO, NULL},
+	{WID_NIL, NULL}
+};
+
+/********************************************
+ *
+ *      Configuration Functions
+ *
+ ********************************************/
+
+static int wilc_wlan_cfg_set_byte(u8 *frame, u32 offset, u16 id, u8 val8)
+{
+	u8 *buf;
+
+	if ((offset + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+	buf[2] =3D 1;
+	buf[3] =3D 0;
+	buf[4] =3D val8;
+	return 5;
+}
+
+static int wilc_wlan_cfg_set_hword(u8 *frame, u32 offset, u16 id, u16 val1=
6)
+{
+	u8 *buf;
+
+	if ((offset + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+	buf[2] =3D 2;
+	buf[3] =3D 0;
+	buf[4] =3D (u8)val16;
+	buf[5] =3D (u8)(val16 >> 8);
+
+	return 6;
+}
+
+static int wilc_wlan_cfg_set_word(u8 *frame, u32 offset, u16 id, u32 val32=
)
+{
+	u8 *buf;
+
+	if ((offset + 7) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+	buf[2] =3D 4;
+	buf[3] =3D 0;
+	buf[4] =3D (u8)val32;
+	buf[5] =3D (u8)(val32 >> 8);
+	buf[6] =3D (u8)(val32 >> 16);
+	buf[7] =3D (u8)(val32 >> 24);
+
+	return 8;
+}
+
+static int wilc_wlan_cfg_set_str(u8 *frame, u32 offset, u16 id, u8 *str,
+				 u32 size)
+{
+	u8 *buf;
+
+	if ((offset + size + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+	buf[2] =3D (u8)size;
+	buf[3] =3D (u8)(size >> 8);
+
+	if (str && size !=3D 0)
+		memcpy(&buf[4], str, size);
+
+	return (size + 4);
+}
+
+static int wilc_wlan_cfg_set_bin(u8 *frame, u32 offset, u16 id, u8 *b, u32=
 size)
+{
+	u8 *buf;
+	u32 i;
+	u8 checksum =3D 0;
+
+	if ((offset + size + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+	buf[2] =3D (u8)size;
+	buf[3] =3D (u8)(size >> 8);
+
+	if ((b) && size !=3D 0) {
+		memcpy(&buf[4], b, size);
+		for (i =3D 0; i < size; i++)
+			checksum +=3D buf[i + 4];
+	}
+
+	buf[size + 4] =3D checksum;
+
+	return (size + 5);
+}
+
+/********************************************
+ *
+ *      Configuration Response Functions
+ *
+ ********************************************/
+
+#define GET_WID_TYPE(wid)		(((wid) >> 12) & 0x7)
+static void wilc_wlan_parse_response_frame(struct wilc *wl, u8 *info, int =
size)
+{
+	u16 wid;
+	u32 len =3D 0, i =3D 0;
+
+	while (size > 0) {
+		i =3D 0;
+		wid =3D get_unaligned_le16(info);
+
+		switch (GET_WID_TYPE(wid)) {
+		case WID_CHAR:
+			do {
+				if (wl->cfg.b[i].id =3D=3D WID_NIL)
+					break;
+
+				if (wl->cfg.b[i].id =3D=3D wid) {
+					wl->cfg.b[i].val =3D info[4];
+					break;
+				}
+				i++;
+			} while (1);
+			len =3D 3;
+			break;
+
+		case WID_SHORT:
+			do {
+				struct wilc_cfg_hword *hw =3D &wl->cfg.hw[i];
+
+				if (hw->id =3D=3D WID_NIL)
+					break;
+
+				if (hw->id =3D=3D wid) {
+					hw->val =3D get_unaligned_le16(&info[4]);
+					break;
+				}
+				i++;
+			} while (1);
+			len =3D 4;
+			break;
+
+		case WID_INT:
+			do {
+				struct wilc_cfg_word *w =3D &wl->cfg.w[i];
+
+				if (w->id =3D=3D WID_NIL)
+					break;
+
+				if (w->id =3D=3D wid) {
+					w->val =3D get_unaligned_le32(&info[4]);
+					break;
+				}
+				i++;
+			} while (1);
+			len =3D 6;
+			break;
+
+		case WID_STR:
+			do {
+				if (wl->cfg.s[i].id =3D=3D WID_NIL)
+					break;
+
+				if (wl->cfg.s[i].id =3D=3D wid) {
+					memcpy(wl->cfg.s[i].str, &info[2],
+					       (info[2] + 2));
+					break;
+				}
+				i++;
+			} while (1);
+			len =3D 2 + info[2];
+			break;
+
+		default:
+			break;
+		}
+		size -=3D (2 + len);
+		info +=3D (2 + len);
+	}
+}
+
+static void wilc_wlan_parse_info_frame(struct wilc *wl, u8 *info)
+{
+	u32 wid, len;
+
+	wid =3D get_unaligned_le16(info);
+
+	len =3D info[2];
+
+	if (len =3D=3D 1 && wid =3D=3D WID_STATUS) {
+		int i =3D 0;
+
+		do {
+			if (wl->cfg.b[i].id =3D=3D WID_NIL)
+				break;
+
+			if (wl->cfg.b[i].id =3D=3D wid) {
+				wl->cfg.b[i].val =3D info[3];
+				break;
+			}
+			i++;
+		} while (1);
+	}
+}
+
+/********************************************
+ *
+ *      Configuration Exported Functions
+ *
+ ********************************************/
+
+int wilc_wlan_cfg_set_wid(u8 *frame, u32 offset, u16 id, u8 *buf, int size=
)
+{
+	u8 type =3D (id >> 12) & 0xf;
+	int ret =3D 0;
+
+	switch (type) {
+	case CFG_BYTE_CMD:
+		if (size >=3D 1)
+			ret =3D wilc_wlan_cfg_set_byte(frame, offset, id, *buf);
+		break;
+
+	case CFG_HWORD_CMD:
+		if (size >=3D 2)
+			ret =3D wilc_wlan_cfg_set_hword(frame, offset, id,
+						      *((u16 *)buf));
+		break;
+
+	case CFG_WORD_CMD:
+		if (size >=3D 4)
+			ret =3D wilc_wlan_cfg_set_word(frame, offset, id,
+						     *((u32 *)buf));
+		break;
+
+	case CFG_STR_CMD:
+		ret =3D wilc_wlan_cfg_set_str(frame, offset, id, buf, size);
+		break;
+
+	case CFG_BIN_CMD:
+		ret =3D wilc_wlan_cfg_set_bin(frame, offset, id, buf, size);
+		break;
+	}
+
+	return ret;
+}
+
+int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id)
+{
+	u8 *buf;
+
+	if ((offset + 2) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	buf =3D &frame[offset];
+
+	buf[0] =3D (u8)id;
+	buf[1] =3D (u8)(id >> 8);
+
+	return 2;
+}
+
+int wilc_wlan_cfg_get_wid_value(struct wilc *wl, u16 wid, u8 *buffer,
+				u32 buffer_size)
+{
+	u32 type =3D (wid >> 12) & 0xf;
+	int i, ret =3D 0;
+
+	i =3D 0;
+	if (type =3D=3D CFG_BYTE_CMD) {
+		do {
+			if (wl->cfg.b[i].id =3D=3D WID_NIL)
+				break;
+
+			if (wl->cfg.b[i].id =3D=3D wid) {
+				memcpy(buffer, &wl->cfg.b[i].val, 1);
+				ret =3D 1;
+				break;
+			}
+			i++;
+		} while (1);
+	} else if (type =3D=3D CFG_HWORD_CMD) {
+		do {
+			if (wl->cfg.hw[i].id =3D=3D WID_NIL)
+				break;
+
+			if (wl->cfg.hw[i].id =3D=3D wid) {
+				memcpy(buffer, &wl->cfg.hw[i].val, 2);
+				ret =3D 2;
+				break;
+			}
+			i++;
+		} while (1);
+	} else if (type =3D=3D CFG_WORD_CMD) {
+		do {
+			if (wl->cfg.w[i].id =3D=3D WID_NIL)
+				break;
+
+			if (wl->cfg.w[i].id =3D=3D wid) {
+				memcpy(buffer, &wl->cfg.w[i].val, 4);
+				ret =3D 4;
+				break;
+			}
+			i++;
+		} while (1);
+	} else if (type =3D=3D CFG_STR_CMD) {
+		do {
+			u32 id =3D wl->cfg.s[i].id;
+
+			if (id =3D=3D WID_NIL)
+				break;
+
+			if (id =3D=3D wid) {
+				u16 size =3D get_unaligned_le16(wl->cfg.s[i].str);
+
+				if (buffer_size >=3D size) {
+					memcpy(buffer, &wl->cfg.s[i].str[2],
+					       size);
+					ret =3D size;
+				}
+				break;
+			}
+			i++;
+		} while (1);
+	}
+	return ret;
+}
+
+void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 *frame, int size,
+			       struct wilc_cfg_rsp *rsp)
+{
+	u8 msg_type;
+	u8 msg_id;
+
+	msg_type =3D frame[0];
+	msg_id =3D frame[1];      /* seq no */
+	frame +=3D 4;
+	size -=3D 4;
+	rsp->type =3D 0;
+
+	/*
+	 * The valid types of response messages are
+	 * 'R' (Response),
+	 * 'I' (Information), and
+	 * 'N' (Network Information)
+	 */
+
+	switch (msg_type) {
+	case 'R':
+		wilc_wlan_parse_response_frame(wilc, frame, size);
+		rsp->type =3D WILC_CFG_RSP;
+		rsp->seq_no =3D msg_id;
+		break;
+
+	case 'I':
+		wilc_wlan_parse_info_frame(wilc, frame);
+		rsp->type =3D WILC_CFG_RSP_STATUS;
+		rsp->seq_no =3D msg_id;
+		/*call host interface info parse as well*/
+		wilc_gnrl_async_info_received(wilc, frame - 4, size + 4);
+		break;
+
+	case 'N':
+		wilc_network_info_received(wilc, frame - 4, size + 4);
+		break;
+
+	case 'S':
+		wilc_scan_complete_received(wilc, frame - 4, size + 4);
+		break;
+
+	default:
+		rsp->seq_no =3D msg_id;
+		break;
+	}
+}
+
+int wilc_wlan_cfg_init(struct wilc *wl)
+{
+	struct wilc_cfg_str_vals *str_vals;
+	int i =3D 0;
+
+	wl->cfg.b =3D kmemdup(g_cfg_byte, sizeof(g_cfg_byte), GFP_KERNEL);
+	if (!wl->cfg.b)
+		return -ENOMEM;
+
+	wl->cfg.hw =3D kmemdup(g_cfg_hword, sizeof(g_cfg_hword), GFP_KERNEL);
+	if (!wl->cfg.hw)
+		goto out_b;
+
+	wl->cfg.w =3D kmemdup(g_cfg_word, sizeof(g_cfg_word), GFP_KERNEL);
+	if (!wl->cfg.w)
+		goto out_hw;
+
+	wl->cfg.s =3D kmemdup(g_cfg_str, sizeof(g_cfg_str), GFP_KERNEL);
+	if (!wl->cfg.s)
+		goto out_w;
+
+	str_vals =3D kzalloc(sizeof(*str_vals), GFP_KERNEL);
+	if (!str_vals)
+		goto out_s;
+
+	wl->cfg.str_vals =3D str_vals;
+	/* store the string cfg parameters */
+	wl->cfg.s[i].id =3D WID_FIRMWARE_VERSION;
+	wl->cfg.s[i].str =3D str_vals->firmware_version;
+	i++;
+	wl->cfg.s[i].id =3D WID_MAC_ADDR;
+	wl->cfg.s[i].str =3D str_vals->mac_address;
+	i++;
+	wl->cfg.s[i].id =3D WID_ASSOC_RES_INFO;
+	wl->cfg.s[i].str =3D str_vals->assoc_rsp;
+	i++;
+	wl->cfg.s[i].id =3D WID_NIL;
+	wl->cfg.s[i].str =3D NULL;
+	return 0;
+
+out_s:
+	kfree(wl->cfg.s);
+out_w:
+	kfree(wl->cfg.w);
+out_hw:
+	kfree(wl->cfg.hw);
+out_b:
+	kfree(wl->cfg.b);
+	return -ENOMEM;
+}
+
+void wilc_wlan_cfg_deinit(struct wilc *wl)
+{
+	kfree(wl->cfg.b);
+	kfree(wl->cfg.hw);
+	kfree(wl->cfg.w);
+	kfree(wl->cfg.s);
+	kfree(wl->cfg.str_vals);
+}
--=20
2.7.4

