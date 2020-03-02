Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403A7175FD4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCBQel (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:34:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42797 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCBQel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:41 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /HNY4F7sWy8IWHIyiby5HGHDbN7M9qTPTcm95Q6Ie2fX2sxdXdUu6Vb0Gera8tKmVOFmqSDSVO
 Kjxwz0IGugr01XHa6lm2rFX3AgMdd8yr75mmE59aAbrptTA2k2foMFi525b95yKqgGg6hTcUpt
 SJ2X6tMTyVMbAMCr70OXK/93BmsNoHsd54q28ubgbjrq+AHs6F7wCiQXE2Eh4zA33x28RTbcZy
 GyDFRP8QsYOdQ/rm1SLQwoGc0VMmI2Su+s1gTQ/BcZtuGM6Zt/pkm7tpg1TXa7ErCxCr7Zu7Q9
 49w=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68544148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9h8eF6RVp5cEL8PkQHzhmvR3S8mjQjSrayv3QlXmd27U5Cn89Ls2xk+h3Lzv0rK6P024XTk65Fw5r77N4K1t+TFYwqFG/XtmWPnSjqt50+MksONoyRLOg9TCDQrR5aQswHZnZfh7uUNdfVV472zWiDfKy98B1JjblFk+b/8l0TOYa9HlHyj9sPGb1LIIczttAsKSttQMKx/ixkCRF7Pmztlt7Eqsg0AufIUA8pmZYHU23DWEKpIOQUuV2WlKojFVBTi7aJ1XaCHFkSpX9HOURgr1WZ3PD3e80liQgEsGoqRDbx6ajhEQni0yH3qPP00RAnfkotOVz4kikB1YvN1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM7DSo3pfXzV/3Pstpzs1QmL/t5wphbjKbPwoFgRNKY=;
 b=iXIbw/UnfVMtGAQCkw/924TCgargzjEmm6/8LI7G1lHEGZRTj2LHXEIWhbtBHhE1tRB2vKCPzeFtba/JB45GUL+xTkLaIbaZsHBVyKVGRQS1Uz4sZ7BnwAQ7qwFD7pgpOSH36GbsCaigXehGYkWuTrdL9jwQ/dQ8URWDPxx9VaDN/+9PKzBXauKo94vKUdBqkpN7bjMDvRNVcCJsq+qCL+x9bwFUvIdPXEYwQe/uIA6xwq31bokJhQN07Qr/dnmMxjG09UUigzpXNT+GcnSbcz1pTJ4zjnH17HWNr/SpigZMY0bDIQDzZmEEJvH3ES9WkeO5y1v2a0iJQCTbGnU0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM7DSo3pfXzV/3Pstpzs1QmL/t5wphbjKbPwoFgRNKY=;
 b=VCcpTZG+dZk9i7UqkThmlFJZTu/9GlzX9A0Mn/DYkUYEcMeSMmnJdJo+0Mha3yX3nssthY513CyyTma9gwuzE7tzo0IsbRM6smCYeI1ozJdfwpph6itqxrmbKzItq5rxFRgC3RhGKA+ufUxsboWxz+RUcjdPtcTzs4tZlHw6rY0=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:33 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:33 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 05/18] wilc1000: add wlan_cfg.c
Thread-Topic: [PATCH v4 05/18] wilc1000: add wlan_cfg.c
Thread-Index: AQHV8LB0JdFputDKhUmt6KH9T/t9ow==
Date:   Mon, 2 Mar 2020 16:34:33 +0000
Message-ID: <20200302163414.4342-6-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d886dcfd-1eaf-4827-3db0-08d7bec796bb
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098C3859B5DEB437AF07C3BE3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNSUQ+c/vBtBjgR3oD+VSKGR6BLMmkpkCwjcIJbt7LmX/+Z1SnWH/nk5Hf0apEfEetASY5SoQi1YlI40zEaD5vsIlIEsslHJfJ7Qj6V7kmXyNQXja9GU72XFOkDKphreNTzLTrA8d+5p9smC3P90UaFxudjCmUBKVaSFVM2tTk/sdpXZOh+JmrJGLNXDm37PXF/rOQyc4/1rOC0rjz7XO13c+dmyOsdQ1CWBU0IBLuRYERb63CVc6T83dGJXzwNZGisNtibaz3LJ7pBCmoMXP+BEsuZatzn4C36ftCViIdru+8ryqMFoVuRkw9Kl3V9M9VsNNjKZsFmohHJTSrwGhDXBrnWC9t8g2ySZVR+nneSMVEozO72LYiEaSpfLfTOUnckg6Ek346AtfFXW0uI85RpayqzQOQ2+pE+IaYL8cTfjS+0eWYtde/WIpKSwF5/T
x-ms-exchange-antispam-messagedata: +jaRIoNZmS85vnLL/FRR0tMl6Q/IWELiePZyGZ+SS2L0qA8VKzqoVopN3f1vLD831LPl5uO5sweesmIbtno9RE0hKaLOvTVV8qUGp2EpgKoLAAorvk87wYk3gZijE/H/ZbyL0SOUrKbX8TeyiwTqjg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d886dcfd-1eaf-4827-3db0-08d7bec796bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:33.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zZAJvO6i8tnXJf9mpxCC5SoRLW8ajRK6A7YLIsn1lhah4FvJDa9OGG2Ty939d79GiOS4+pQ1KDP1i29USLizUGLH6Lbk3oOHhTPkBIfE/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/wlan_cfg.c' to
'drivers/net/wireless/microchip/wilc1000/wlan_cfg.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/wlan_cfg.c    | 413 ++++++++++++++++++
 1 file changed, 413 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
new file mode 100644
index 000000000000..fe2a7ed8e5cd
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include "wlan_if.h"
+#include "wlan.h"
+#include "wlan_cfg.h"
+#include "netdev.h"
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
+#define WILC_RESP_MSG_TYPE_CONFIG_REPLY		'R'
+#define WILC_RESP_MSG_TYPE_STATUS_INFO		'I'
+#define WILC_RESP_MSG_TYPE_NETWORK_INFO		'N'
+#define WILC_RESP_MSG_TYPE_SCAN_COMPLETE	'S'
+
+/********************************************
+ *
+ *      Configuration Functions
+ *
+ ********************************************/
+
+static int wilc_wlan_cfg_set_byte(u8 *frame, u32 offset, u16 id, u8 val8)
+{
+	if ((offset + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(1, &frame[offset + 2]);
+	frame[offset + 4] =3D val8;
+	return 5;
+}
+
+static int wilc_wlan_cfg_set_hword(u8 *frame, u32 offset, u16 id, u16 val1=
6)
+{
+	if ((offset + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(2, &frame[offset + 2]);
+	put_unaligned_le16(val16, &frame[offset + 4]);
+
+	return 6;
+}
+
+static int wilc_wlan_cfg_set_word(u8 *frame, u32 offset, u16 id, u32 val32=
)
+{
+	if ((offset + 7) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(4, &frame[offset + 2]);
+	put_unaligned_le32(val32, &frame[offset + 4]);
+
+	return 8;
+}
+
+static int wilc_wlan_cfg_set_str(u8 *frame, u32 offset, u16 id, u8 *str,
+				 u32 size)
+{
+	if ((offset + size + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(size, &frame[offset + 2]);
+	if (str && size !=3D 0)
+		memcpy(&frame[offset + 4], str, size);
+
+	return (size + 4);
+}
+
+static int wilc_wlan_cfg_set_bin(u8 *frame, u32 offset, u16 id, u8 *b, u32=
 size)
+{
+	u32 i;
+	u8 checksum =3D 0;
+
+	if ((offset + size + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(size, &frame[offset + 2]);
+
+	if ((b) && size !=3D 0) {
+		memcpy(&frame[offset + 4], b, size);
+		for (i =3D 0; i < size; i++)
+			checksum +=3D frame[offset + i + 4];
+	}
+
+	frame[offset + size + 4] =3D checksum;
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
+static void wilc_wlan_parse_response_frame(struct wilc *wl, u8 *info, int =
size)
+{
+	u16 wid;
+	u32 len =3D 0, i =3D 0;
+	struct wilc_cfg *cfg =3D &wl->cfg;
+
+	while (size > 0) {
+		i =3D 0;
+		wid =3D get_unaligned_le16(info);
+
+		switch (FIELD_GET(WILC_WID_TYPE, wid)) {
+		case WID_CHAR:
+			while (cfg->b[i].id !=3D WID_NIL && cfg->b[i].id !=3D wid)
+				i++;
+
+			if (cfg->b[i].id =3D=3D wid)
+				cfg->b[i].val =3D info[4];
+
+			len =3D 3;
+			break;
+
+		case WID_SHORT:
+			while (cfg->hw[i].id !=3D WID_NIL && cfg->hw[i].id !=3D wid)
+				i++;
+
+			if (cfg->hw[i].id =3D=3D wid)
+				cfg->hw[i].val =3D get_unaligned_le16(&info[4]);
+
+			len =3D 4;
+			break;
+
+		case WID_INT:
+			while (cfg->w[i].id !=3D WID_NIL && cfg->w[i].id !=3D wid)
+				i++;
+
+			if (cfg->w[i].id =3D=3D wid)
+				cfg->w[i].val =3D get_unaligned_le32(&info[4]);
+
+			len =3D 6;
+			break;
+
+		case WID_STR:
+			while (cfg->s[i].id !=3D WID_NIL && cfg->s[i].id !=3D wid)
+				i++;
+
+			if (cfg->s[i].id =3D=3D wid)
+				memcpy(cfg->s[i].str, &info[2], info[2] + 2);
+
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
+		while (wl->cfg.b[i].id !=3D WID_NIL &&
+		       wl->cfg.b[i].id !=3D wid)
+			i++;
+
+		if (wl->cfg.b[i].id =3D=3D wid)
+			wl->cfg.b[i].val =3D info[3];
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
+	u8 type =3D FIELD_GET(WILC_WID_TYPE, id);
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
+	if ((offset + 2) >=3D WILC_MAX_CFG_FRAME_SIZE)
+		return 0;
+
+	put_unaligned_le16(id, &frame[offset]);
+
+	return 2;
+}
+
+int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
+			  u32 buffer_size)
+{
+	u8 type =3D FIELD_GET(WILC_WID_TYPE, wid);
+	int i, ret =3D 0;
+	struct wilc_cfg *cfg =3D &wl->cfg;
+
+	i =3D 0;
+	if (type =3D=3D CFG_BYTE_CMD) {
+		while (cfg->b[i].id !=3D WID_NIL && cfg->b[i].id !=3D wid)
+			i++;
+
+		if (cfg->b[i].id =3D=3D wid) {
+			memcpy(buffer, &cfg->b[i].val, 1);
+			ret =3D 1;
+		}
+	} else if (type =3D=3D CFG_HWORD_CMD) {
+		while (cfg->hw[i].id !=3D WID_NIL && cfg->hw[i].id !=3D wid)
+			i++;
+
+		if (cfg->hw[i].id =3D=3D wid) {
+			memcpy(buffer, &cfg->hw[i].val, 2);
+			ret =3D 2;
+		}
+	} else if (type =3D=3D CFG_WORD_CMD) {
+		while (cfg->w[i].id !=3D WID_NIL && cfg->w[i].id !=3D wid)
+			i++;
+
+		if (cfg->w[i].id =3D=3D wid) {
+			memcpy(buffer, &cfg->w[i].val, 4);
+			ret =3D 4;
+		}
+	} else if (type =3D=3D CFG_STR_CMD) {
+		while (cfg->s[i].id !=3D WID_NIL && cfg->s[i].id !=3D wid)
+			i++;
+
+		if (cfg->s[i].id =3D=3D wid) {
+			u16 size =3D get_unaligned_le16(cfg->s[i].str);
+
+			if (buffer_size >=3D size) {
+				memcpy(buffer, &cfg->s[i].str[2], size);
+				ret =3D size;
+			}
+		}
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
+	switch (msg_type) {
+	case WILC_RESP_MSG_TYPE_CONFIG_REPLY:
+		wilc_wlan_parse_response_frame(wilc, frame, size);
+		rsp->type =3D WILC_CFG_RSP;
+		rsp->seq_no =3D msg_id;
+		break;
+
+	case WILC_RESP_MSG_TYPE_STATUS_INFO:
+		wilc_wlan_parse_info_frame(wilc, frame);
+		rsp->type =3D WILC_CFG_RSP_STATUS;
+		rsp->seq_no =3D msg_id;
+		/* call host interface info parse as well */
+		wilc_gnrl_async_info_received(wilc, frame - 4, size + 4);
+		break;
+
+	case WILC_RESP_MSG_TYPE_NETWORK_INFO:
+		wilc_network_info_received(wilc, frame - 4, size + 4);
+		break;
+
+	case WILC_RESP_MSG_TYPE_SCAN_COMPLETE:
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
2.24.0
