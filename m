Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5E204FD4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgFWLAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:38 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41143 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbgFWLAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910018; x=1624446018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJH1m/MDyyRtAUNe9J13EWdbkoEXDMVvI2d5v7dcXno=;
  b=h2X8MKO5C/qYSdMH/SvierfL7748aUAMSpg1gpW4FyaqCjJC2G1wbqbX
   MlajpWZgt5m/WhgqYmfmyaCxFivnlm23VJSmwOY6ECRJmx/5DJFECD34L
   McB6fgkCLm9yjgk7dCW9nk4AXh4FFADun4W/vh/Sj7c3DhdrlF6K/zX6f
   aDf01J5eOGlYpq/++Wfyf+XxScL+H7N//HJRglTxGWxK4AyIGFAB3GdU8
   2YJtzNmGHkK6VmOvpPD6UqRZoGxBSgcWs2PlZW+zc9RgxY2sRpbuvNJW6
   /n0Lip20DqyAsCYgaI+KM2sSK6Dl6C1pVnwQ4gbNOmRghdEzGuQK2/pjB
   w==;
IronPort-SDR: vGKUebQf1ChCF0xbAT819Z++oG9XpgveqI/JlGUJUcODmyAx4rgu1YxotQ3c3FeghJ7ntqAF4T
 FDJEEDO7xmZlwjCIHVtLjGwXN7I1FEYCSR/x9iIuLXfxVS6wP44vz44jCDYoEut/vab9loSd7S
 iES816NMmPqBNzt/6XYrBlWnpst4j+gJ7y2Of5qb0UQqZj68onHX8SCqUmN85oQkdBcK9FMVNh
 z9ZYxnKEU+5uWkt8DeKX/XoxkrQ2Zr6Q0IZxp6IUKkmEHN6cr3xTlAYvT27mmXsFD4tONL4wrq
 xMI=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="80543434"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 03:59:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 23 Jun 2020 04:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLrKd6fp7Ze0c22+/IAiIycm4BE2WvhmijlUMu4BH/qHl64/Me2UpXbQQBYb9JuwNnOY9sLBswXShbSMaad9QDJHB7nT/5vNbTlHoTyyPw7lXZi0qBZTdXk5KO/bEeYGXhKunJkSFWs+mNj0jQ8irycfmAf6xaLBVm5eg20JZC1PRmIHHj8UJfnvEz6g6gOS3GSY4H568VEaGubkK6GSeUk797i+gfFbn0e2FX1GRDmg/N7N5aN50iEJPqjMsBIwSUcLtQY4n3GB9Z/z+g33ChezCQM5dUoLqFLPfT1nQiE4pPVXu9MnwfzRCPClBPijKlnebqET+79zAEcxJI/L5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM7DSo3pfXzV/3Pstpzs1QmL/t5wphbjKbPwoFgRNKY=;
 b=At3rWVQG+p9XavLFGDPCTw872bo3tqF6WUFjD0dP/q7W6kzaTETeahroeh2YDSYMNGvlv+jdaK+1G//4fsjZ2ycyUL6poQLPqvHm8r9RmHqArw9aEYZbEJaVzU0cnOsZYnc7Iwtb4xZN8FR81KEjo8AyLj4EFTERW5xcT8FK+fwUB1AEVhffZR0OeJ9U5Q6t+N5MgKgAcx8Umz/nZq5i1QhiPQr56LerUp+6iKzSgIrS16FsL8oEKShW2CLJri2QIPacYR78SrznsOMndRNflKIPmTc86r6s2q5AM/kSbxe3WDC/1R9WubpNOc1a0eYLrxDVF4W6XZD1OhzdsVt0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM7DSo3pfXzV/3Pstpzs1QmL/t5wphbjKbPwoFgRNKY=;
 b=gHuR3SObzG1HaPg19OixUiOdtww3Dv6t6TfOumokNKRuMIt7ujXKjdZ8icx8LthGzQ8nmUY6xe570FFVEY9kr093NciiEIK+Dv8u/3S+5Tp4t8CfMusHmlGs+sN8+z2RHV+cfwGIhaop2wSo6W2MFCLS42XG3EG4VTv88NEqeU0=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:08 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 05/17] wilc1000: add wlan_cfg.c
Thread-Topic: [PATCH v7 05/17] wilc1000: add wlan_cfg.c
Thread-Index: AQHWSU10s0pOCPEkn0yjaht5LNvbEQ==
Date:   Tue, 23 Jun 2020 11:00:07 +0000
Message-ID: <20200623110000.31559-6-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.200.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb7ff1eb-4a7a-4a88-d319-08d8176497f8
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3551BA0872CBB6D98649F3CAE3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6B2NGCltlumPMjXoKXLe/VVR4i+1Ebi5eqSKnjvUWHhTpfoDmS0u0zb8I0xOu1tzvzxm/dL97Q4AcGF0k8mSgRBq62bWJIXEgDJ5OWt58MYpmWbMPADx4vHA4aMVG1IG/cDrL2nIdZlW4Idrd0qm2ZilAxG3W3+T56Z8m7pmPOiOMhVhJXkyWCvaCIVpCvA4TCnL13zz2z72gyfFJN/3kx+29XVL1LnCRxlUEDHHQy6k1cgvO2om50olgE8UZqx4gJrq2edEJU66lVtpC+TTPG2RbWZL7kLsfrXAf4S0MIKIFqKgnnST5LGD9LI3st+piWAFgP4yQoMQdcGPu8iCEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o/umFFA6gO/blXyfDnTCr/XNFuXvitzr+nnuEHY5O3vFQCI1C4MXJOKos6d1hDesotEJ3P+OOmXhBAS/0SacMwIIN9NTF8ef0AGuJySguS0xC4/n6ziAlg16lY5MIexB/kQs8XE7rgCA5qLtiM+o2ckm2IRaft12/vSnh/Jp+JF4Aa0rt+Xsjdusa1OtKjozMQ7jhRHz+knIzO/WwBwvsgkkRG1/FJHUJM27+wddFxPMrvdrbHcGUDJ+mzgtoWM8rRyhQPsaewBFEKX0dhmzKKuI3JMvzbnPF7HMo+s9n0TkZ1kQ2dlonJC5dJmaBcSopOwlVxP7o9ETTqt0Sgp+RLlJ7nxkavukoYhwbrYF42PCn6LE/ZZ6NMBPxlJZ0jTOIv6XbhDCj8JmhiwKlhYBvvwZIybMK/EzEENJIUkzUzUJi22k5a1TM1Tis3s2snfyz5uLutcd92+JwgcbListrDT+KDmMDM47w1wvoRreoTBZBZivwgMzcVa+au3m4lL/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ff1eb-4a7a-4a88-d319-08d8176497f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:07.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iK7gzu+hbpGVVDVdMin9+BrbSMlFaNE5//OKWjNRlNaqo0azkeMaRJRtMs9oKyIH2KDU9U5e2uQkZG0+5Lqdhzk/FDozin7rLQND39Q5BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
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
