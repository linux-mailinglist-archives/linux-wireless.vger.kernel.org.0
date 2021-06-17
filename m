Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A23AB869
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhFQQH5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:57 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:9431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231186AbhFQQHX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9WWGz3d+W8WFF4F7ox4XoVkAF91x2AhSzbXfiwyWtqHjX4C3h/gAZF9wTPdC5OWfVgoLrVmYxAFnoZ62wgU589doAoJ69fdTM8n9r54R9MqhZHdtSbtODjX22f17MBKpTfXOzNthz6pHeP3/xic6ZYwSorV4r7z2LmOupZgi8P92/liy4a/FG4rEmiBDQP8NZKEp8GGmcD9tbLu04PUE76hQzk7KropjOLhKIDF7qffq2vM3LWdfPqSmVS9AVgjyT1vpHkcY4pUSRLl0O1FpP+fi4RdyPeu4VtxIgi3IVE1nZK81jyvy/eAdE5hwvczVrF/V7zYHhq7TZKXMctexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUZ7YNDxKkI5Fuw+DtAIVYn2pxe+z2R8vJZTxIAUf+w=;
 b=dsDiyhCQ9IdYnYQRCze7rZQUCy+++JmBfyWPIOGQJoNdTq18DAl/WPd61/D8DxhW3A8/OWNScDC4YWI7z3MHd8D6P67FTA1YorRtuxd7SF77ufXtCJCuRsh+KvxJ18za6pb2KFt1U1gapDaQQdMfqEF6583J7qmYi98FgaJA4dC8NqkosaLtc5L2UkYf5veyUNLTAx1l+TbvCUCLeHJHdQHasOn76HXOQhZLoI8DkqeYROvWYKhdXEPqcDv4uZBon02un9Tj35KoYaWI0azyzvY3quiwHPVdKZlmN+jylfs1JHVj8ahTWx99fe+vSqhjYKsQlVbDpWiM0MW3FYH4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUZ7YNDxKkI5Fuw+DtAIVYn2pxe+z2R8vJZTxIAUf+w=;
 b=sWvNEmYS10qHGGhBH9hInt9Hs3K2aE0tTSBt3VkAWQ0fqFET1fEFBo9Y4UYaag0sQYYgTPt2nBG/A4w/6RfA9xPi5VBNmp0mFhUMytxfgWeO7VsJCoaqFxO7+CVUIZRLG62+8SFHGYoRvQznriP+fbCqvHZyL0vedOnwqNGzEgo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:21 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:21 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 068/256] cl8k: add e2p.h
Date:   Thu, 17 Jun 2021 15:59:15 +0000
Message-Id: <20210617160223.160998-69-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3441ff2-7d93-4848-fd37-08d931a97e81
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268496128B6A33444ECF3A0F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5ZYE/b+g1pl56Xlv/NsdIc2QC7aNq3aBbovKasX2uKvR5dDAh0VSPZNPxHhlbOPfZ1rS3tU57LuvgiX2JUKE9wRSL4G3Zyj7X5uRIMonGq/75czQb1w2IeshVX2z9cj5AmS7KtN688xu85rRl7ukJgJWbJQeEy4aL2qmn5v625KaFotw86EmGj4b0kx621/riHekKH7UjlCw78dOcJdGAocZTtT7izFrY+0IJky41QuUA7Wx4KwUZapH2Ua3AbjEkrfX90jiC+1TsFEqJamPJW0Tx3mwu84a7PU9iaeuvqLEBnGfVxgKt8kXtzAREEAHjzKmlVBYa628sTUU43snJtWEk9tR3pfzKWtaZ9e0ar69hz1iOccWsqF0APxzpYv3+XNb4tahNUk6wIWuSVZtOZJbfWs5ZiegTuZaG3Z1hFuIbVPxoHYh7/1yNZ9ClIv5TI5rv62jLIrFTyt11ZFGZU3YtqUe+Jt1j9wz/buoVlRXMYqPtwI8AWc0F2qTbTGTHVniCX4J4sZkoQSI4NbTE8U/eWgIvBPY6UIOVKfUY9W/+PniiGyjqQVVqDo+odbcbkshDC8UqVRAjculaD8PU2GyH8QMq31L97bB/HKvjwNES/ezhIoTeh0nodhIaeItDkCl80HOUs165zPq+QpwJDWdynf/NpEW6XYPjgM0FXLvtV+9vTlNf1FToBg0B7j8RgG3gD7eq9Do+m1tD8mEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzwIXorVf+JK9vtE1rpupZEjmFCAu7k2JYHxqMTp0JW6TjvefITHLVMfe9HO?=
 =?us-ascii?Q?s1JUysESIltmoImB0OqTEm1hf1NvomiwQXwyR9YPYWifi8RkEgajO5qo/+iT?=
 =?us-ascii?Q?1ERhmNSvz+J+lf08c4fm0Mv5sdKZiA1kBhBcuYgqCxXYLGtmax5BsFZrZsv5?=
 =?us-ascii?Q?6ex7kC82qcZDex6HwvqR/fTmHzVlSjT0ed6g4MLTc/v31JhNtxlT4pwYA1zK?=
 =?us-ascii?Q?fk0Zhwjg6rllGwTyrv0ineTA/jwLNcYUtgcNroejjXS0k723fErUlD1EMpLO?=
 =?us-ascii?Q?4gXlX4P5aY0FHD33dRD974t3CNZ3BgIlgN0wJwLRYex1JUgzCdcWNnBUGsKp?=
 =?us-ascii?Q?aUrNom4KbwJDXqPC24l6KGweAlvd4KfFjUChGAE/tL5hjUb0wRsrJZTRArYA?=
 =?us-ascii?Q?K+aAecs657e51dK1MW1585sALsf+jVq/TrdD2kNVfdjDBIl1/LPGU97+p71g?=
 =?us-ascii?Q?8ET5ZU/RjBFkMDpOW2lWspzQZzdVNE5iaiypyfM5AQDdYFFhs1lvYguZmS/X?=
 =?us-ascii?Q?YTQkJlMfHgQtFIf+rmDnYfIsxRpm7yG8w1nEKwqZg5uXFV05YSFZadw2mehd?=
 =?us-ascii?Q?lPtUsqmNLUHmf2vrWy1Kk2UDMtERZac/GCpG8Af+XJQNE71AFw2p08Uh/Iz9?=
 =?us-ascii?Q?gKSXJ6HhUj/alyClF+LOmvRYtO4iNaUdTzrdp33vzTYIH2z6SeRL1C5SjjWI?=
 =?us-ascii?Q?lp7hsVt6Lrj8mgICjh+nti0aFk/FAHryAWLW6fVrrhD2gW+A8EN+gCddTYvp?=
 =?us-ascii?Q?gooExMeY34latNjOJL6Knn6DJkqPS5poEH4MPbb2GHvMq0Kf1s45Y5RFgo6h?=
 =?us-ascii?Q?JBdjMPQmM+RfGOvzHoLYRLKa2MY3TSlhlHw5+v7gqXuwbb92uelQi7RTjR3Y?=
 =?us-ascii?Q?9RmlgbHY0C2mAcqxgvlQENZRYrsghRM2aStUMK/P/oYO/nRUuzIdGhsMl4R9?=
 =?us-ascii?Q?cZYD/pnPDcY3Sg/zX/q+YM9+RAZprCJTxOan/z81hDlBCAlRjjOfaKzUDERb?=
 =?us-ascii?Q?Vrn/9y0vWOFQtWSt2PrPtLsZRdQPus2TZE0cCIGiA4UOQwD88JcgCu61iKlo?=
 =?us-ascii?Q?UC0AoTnk4WSK2UdPumsVaD0TggJAJf6eJmE8mIvjEicRbfRyvNOTyPJ/yNzS?=
 =?us-ascii?Q?Si9byeS1P5sYeg1UT1CArZ69c5D+Sm0Ckfpou2RMTldTYFFf+t4h4aQUg2yU?=
 =?us-ascii?Q?SLSRg5F+hPCNlI7mcsrDE1EiSLanr0rdP5AyjBsOqc1lmiuvOcuVGToD78qR?=
 =?us-ascii?Q?CUqvXRGmIUh3c3cKeIqvzXPg92XSJrvol5DAaLHRWh7auWnvn6BnJHEiTW1u?=
 =?us-ascii?Q?ID+GDPKG9jazObXaDhrIiiYx?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3441ff2-7d93-4848-fd37-08d931a97e81
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:49.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ33KfODvwLHodw9Zll8BJRYDqm1D0kduz4+PZWL3+19D2E64OeFsQGGSX7bVFew6SI9JUSrBFJDZzl2yG7CcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/e2p.h | 166 +++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.h

diff --git a/drivers/net/wireless/celeno/cl8k/e2p.h b/drivers/net/wireless/=
celeno/cl8k/e2p.h
new file mode 100644
index 000000000000..74ec66dfe277
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/e2p.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_E2P_H
+#define CL_E2P_H
+
+#include <linux/types.h>
+#include <net/cfg80211.h>
+
+
+#include "def.h"
+#include "fem_common.h"
+
+/**
+ * EEPROM abstraction layer
+ */
+
+#define SERIAL_NUMBER_SIZE 32
+
+enum eeprom_flavor {
+       EEPROM_FLAVOR_CL80X0,
+       EEPROM_FLAVOR_CL80X6,
+};
+
+struct eeprom_hw {
+       u8 reserved[96];
+} __packed;
+
+struct eeprom_general {
+       u8 version;
+       u8 flavor;
+       u8 mac_address[6];
+       u8 temp_diff; /* Default value TEMP_DIFF_INVALID =3D 0x7F */
+       u8 serial_number[SERIAL_NUMBER_SIZE];
+       u8 pwr_table_id[2];
+       u8 reserved[53];
+} __attribute__((__packed__));
+
+struct eeprom_fem {
+       u8 wiring_id;
+       u16 fem_lut[FEM_TYPE_MAX];
+       u32 platform_id;
+       u8 reserved[19];
+} __packed;
+
+struct eeprom_phy_calib {
+       s8 pow;
+       s8 offset;
+       s8 tmp;
+} __packed;
+
+#define BIT_MAP_SIZE   20
+#define NUM_OF_PIVOTS  20
+#define NUM_PIVOT_PHYS (MAX_ANTENNAS * NUM_OF_PIVOTS)
+
+struct eeprom_calib {
+       u16 freq_offset;
+       u8 chan_bmp[BIT_MAP_SIZE];
+       struct eeprom_phy_calib phy_calib[NUM_PIVOT_PHYS];
+} __packed;
+
+struct eeprom {
+       struct eeprom_hw hw;
+       struct eeprom_general general;
+       struct eeprom_fem fem;
+       struct eeprom_calib calib;
+} __packed;
+
+enum {
+       ADDR_HW =3D offsetof(struct eeprom, hw),
+       ADDR_HW_RESERVED =3D ADDR_HW + offsetof(struct eeprom_hw, reserved)=
,
+
+       ADDR_GEN =3D offsetof(struct eeprom, general),
+       ADDR_GEN_VERSION =3D ADDR_GEN + offsetof(struct eeprom_general, ver=
sion),
+       ADDR_GEN_FLAVOR =3D ADDR_GEN + offsetof(struct eeprom_general, flav=
or),
+       ADDR_GEN_MAC_ADDR =3D ADDR_GEN + offsetof(struct eeprom_general, ma=
c_address),
+       ADDR_GEN_TEMP_DIFF =3D ADDR_GEN + offsetof(struct eeprom_general, t=
emp_diff),
+       ADDR_GEN_SERIAL_NUMBER =3D ADDR_GEN + offsetof(struct eeprom_genera=
l, serial_number),
+       ADDR_GEN_PWR_TABLE_ID =3D ADDR_GEN + offsetof(struct eeprom_general=
, pwr_table_id),
+       ADDR_GEN_RESERVED =3D ADDR_GEN + offsetof(struct eeprom_general, re=
served),
+
+       ADDR_FEM =3D offsetof(struct eeprom, fem),
+       ADDR_FEM_WIRING_ID =3D ADDR_FEM + offsetof(struct eeprom_fem, wirin=
g_id),
+       ADDR_FEM_LUT =3D ADDR_FEM + offsetof(struct eeprom_fem, fem_lut),
+       ADDR_FEM_PLATFORM_ID =3D ADDR_FEM + offsetof(struct eeprom_fem, pla=
tform_id),
+       ADDR_FEM_RESERVED =3D ADDR_FEM + offsetof(struct eeprom_fem, reserv=
ed),
+
+       ADDR_CALIB =3D offsetof(struct eeprom, calib),
+       ADDR_CALIB_FREQ_OFFSET =3D ADDR_CALIB + offsetof(struct eeprom_cali=
b, freq_offset),
+       ADDR_CALIB_CHAN_BMP =3D ADDR_CALIB + offsetof(struct eeprom_calib, =
chan_bmp),
+       ADDR_CALIB_PHY =3D ADDR_CALIB + offsetof(struct eeprom_calib, phy_c=
alib),
+
+       SIZE_HW =3D sizeof(struct eeprom_hw),
+       SIZE_HW_RESERVED =3D ADDR_GEN - ADDR_HW_RESERVED,
+
+       SIZE_GEN =3D sizeof(struct eeprom_general),
+       SIZE_GEN_VERSION =3D ADDR_GEN_FLAVOR - ADDR_GEN_VERSION,
+       SIZE_GEN_FLAVOR =3D ADDR_GEN_MAC_ADDR - ADDR_GEN_FLAVOR,
+       SIZE_GEN_MAC_ADDR =3D ADDR_GEN_TEMP_DIFF - ADDR_GEN_MAC_ADDR,
+       SIZE_GEN_TEMP_DIFF =3D ADDR_GEN_SERIAL_NUMBER - ADDR_GEN_TEMP_DIFF,
+       SIZE_GEN_SERIAL_NUMBER =3D ADDR_GEN_PWR_TABLE_ID - ADDR_GEN_SERIAL_=
NUMBER,
+       SIZE_GEN_PWR_TABLE_ID =3D ADDR_GEN_RESERVED - ADDR_GEN_PWR_TABLE_ID=
,
+       SIZE_GEN_RESERVED =3D ADDR_FEM - ADDR_GEN_RESERVED,
+
+       SIZE_FEM =3D sizeof(struct eeprom_fem),
+       SIZE_FEM_WIRING_ID =3D ADDR_FEM_LUT - ADDR_FEM_WIRING_ID,
+       SIZE_FEM_LUT =3D ADDR_FEM_PLATFORM_ID - ADDR_FEM_LUT,
+       SIZE_FEM_PLATFORM_ID =3D ADDR_FEM_RESERVED - ADDR_FEM_PLATFORM_ID,
+
+       SIZE_CALIB =3D sizeof(struct eeprom_calib),
+       SIZE_CALIB_FREQ_OFFSET =3D ADDR_CALIB_CHAN_BMP - ADDR_CALIB_FREQ_OF=
FSET,
+       SIZE_CALIB_CHAN_BMP =3D ADDR_CALIB_PHY - ADDR_CALIB_CHAN_BMP,
+       SIZE_CALIB_PHY =3D sizeof(struct eeprom_phy_calib) * NUM_PIVOT_PHYS=
,
+
+       EEPROM_NUM_BYTES =3D sizeof(struct eeprom),
+       EEPROM_LAST_BYTE =3D EEPROM_NUM_BYTES - 1,
+};
+
+struct cl_e2p_get_reply {
+       u8 e2p_mode;
+       u8 e2p_data[];
+};
+
+struct cl_chip;
+
+int cl_e2p_init(struct cl_chip *chip);
+void cl_e2p_close(struct cl_chip *chip);
+int cl_e2p_write(struct cl_chip *chip, u8 *data, u16 size, u16 addr);
+int cl_e2p_read(struct cl_chip *chip, u8 *data, u16 size, u16 addr);
+int cl_e2p_write_version(struct cl_chip *chip);
+int cl_e2p_get_addr(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   void *data, int data_len);
+int cl_e2p_set_addr(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len);
+int cl_e2p_set_wiring_id(struct wiphy *wiphy, struct wireless_dev *wdev,
+                        const void *data, int data_len);
+int cl_e2p_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+               void *data, int data_len);
+
+enum cl_e2p_cmd {
+       CL_E2P_GET_ADDR,
+       CL_E2P_GET_MAC,
+       CL_E2P_GET_SERIAL_NUMBER,
+       CL_E2P_GET_PWR_TABLE_ID,
+       CL_E2P_GET_FREQ_OFFSET,
+       CL_E2P_GET_WIRING_ID,
+       CL_E2P_GET_FEM_LUT,
+       CL_E2P_GET_PLATFORM_ID,
+       CL_E2P_GET_CALIB,
+       CL_E2P_GET_HEXDUMP,
+       CL_E2P_GET_TABLE,
+
+       CL_E2P_SET_ADDR,
+       CL_E2P_SET_MAC,
+       CL_E2P_SET_SERIAL_NUMBER,
+       CL_E2P_SET_PWR_TABLE_ID,
+       CL_E2P_SET_FREQ_OFFSET,
+       CL_E2P_SET_WIRING_ID,
+       CL_E2P_SET_FEM_LUT,
+       CL_E2P_SET_PLATFORM_ID,
+       CL_E2P_SET_CALIB,
+
+       CL_E2P_MAX
+};
+
+#endif /* CL_E2P_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

