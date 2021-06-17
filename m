Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFF3AB86C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFQQID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:03 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:40639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232149AbhFQQHZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeScvxE6x1RupBjdKXUTHyJMBWNTMfBUgNgSyaA0etHc/pSZ+zQNRztgrZ1j1hFjvtEewb6cL2lR7GY8Vi8axew8XoVkVuM9Vp+vbm6DvM62a1oCJnZn+VbgtFul3fbpHp2o7X0VcAbyJMCkioJEkI8l0wNZ5reQTfUOBk1OB/dfarCEAhbMbOi0qhMM50vCd+Ncp4yMKEbq3bDsJuGEJCqBNTnuCnyfTL1oJT5ZLriVRYlPD2MeiqvcBkpcJc9jfACdgf1Bu5fddFAl0w0ESIwqCRhwRRePEE7gwt/t7iJj3Ivk8kLYxAjZ68tEC/GsGBIbLCqzMsq+sK17P0jzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN28uCS62slwZdlXsiwM8KaLfOO0AzkbFCotKTzsae0=;
 b=Pvf2i++pWY0fjSi6r3dSKETgUvWYdWCazkKZYH1h8RDmJW9ta4+7Du/eqoOtXrXwI55kjkPs3PIEnMk8V8pfR9bo+dejGvPxPedQChRxif0gUhsw0bj9/T+J8rxBZ3CPoPLM0sWDGeIi15nFGDcs+YCOXPH7D7tfTT7hIwlzHjStAuQRUYrFSMunK8dGrVHXMx8if5VTs0pB+DvgfBSQws2+tAxQCBbyR2UMgIukvizLWzrgEHeE7Y9ukm7Ofeg09h1ARc1Uk12x93CaDta5y1Un9UlWPs8Lt/1yNXcROmKVjJ/gVckPixF0I3BJu3dn8yMGf6VWa3UqFTTtsTiHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN28uCS62slwZdlXsiwM8KaLfOO0AzkbFCotKTzsae0=;
 b=0TVaKUhicWCq/IgV+tviBfTXLh3AGfVeLU84uO1C8PPJsG/v9P6uYkf+LQ2sbe9E54RL3j7ZH2MQeRjgrBA2+aJJCAEWJ/TbHEg/xJ6kXvFcU4hp99j54RHIMgN+MRuqNHlCVX6jjZh8pTTbBjsuTCzmg1frJDb8IuZ9hblt6bQ=
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
Subject: [RFC v1 067/256] cl8k: add e2p.c
Date:   Thu, 17 Jun 2021 15:59:14 +0000
Message-Id: <20210617160223.160998-68-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50bd4c9-9a89-4094-ec42-08d931a97dbe
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268502842F89B613FE98AE6F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8owOSDbegI1hEtldSvfMRu9C9InFbPOyW+HFFBgDvi8IHPcJILkheR56obnCjlr0PiBAF37OPbZ57r4Rf3GqKHRBrcYeaAV1FiQDCFmN48ZFjA0aSAqm2dpXZXaoA9cGvn97J9aZ3Z0/lcbst4nEXN1OmCVElH+g5p0rC55h761229nitwV8rdBkTe4gl+4bXEhQFV/awTv06sslpoYWwg8hAJokHZDYBdt22O6BdyeWv56U22ctQxk2q22kXqxAoIkAUhsOEUmTK0W4eSBOLJJtpH1DwrYcGe2AJHrbl6LcFMW0DomNtGqTrdlvimqQs6cuvFlFdWRZqQRxpTZUYb75zCqgo8w4D7uhskUIoH0izl8QjI1qDmP9p16zsjlabuDWkL9LBklqJeMp7vnlWHeNSPnuJdKZpW+auytcUIhCpRB7yS7HPFaWPbV9u/z7z4QxstcSV5NiRXUWChTb6ToNnXi46D3Gr2q5gpK6oplP85LpooPNjne9onF0KUgZvEXdpIHrzsn8qM8q1v2yoBHgWhIcsgIcB8ScGELf9zCkilel5jxVQAiYX0EaKhjeNhTcKUBwyP9ErmyDz/1R2HdExwoy+yhwMRz21pcXNSO4rF6RtQTU1ZTGWth3/THC/yT47379pT77MW7ndTcWBkluO2eAl1KB5k45RF6/Km913yT4ES4CN8AcH8uJgsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(30864003)(107886003)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RmQUlSdXdkeDIxeVZ1VDNXbnA1YldhZUR3YzM2dUdyd3krbWRrbEp0L240?=
 =?utf-8?B?VGpDSE8zTjByQ3hZQTEvOU83NXhZNlBhcmRCZDUrMnhFVlpBN2Q3bDBiY0lM?=
 =?utf-8?B?S3pXQTFPY0JyVjZwdmV1OEwwUXROenRzNHJyT1NvZFVMTmVzS00yOVpxZFFZ?=
 =?utf-8?B?dTUyRElQcHRXY2NubTZGd0NFdkFqZUMxZmF0RjhaVndXSVF1MGJLOXJjNUwv?=
 =?utf-8?B?dWJqcVliMGR3L2t1SWtXemZDRHRqTFBKR1JoMkpKS1VrbzZxa3I2SnUvMmtZ?=
 =?utf-8?B?dzhxZUJxYjRUMVZQWlo5eW5WNDU0dDIrVXJJQk4rWGdEM3Z5U0J2NHBTalgy?=
 =?utf-8?B?aEY2VU8rdlpmSXBwQUVDTWdYWGxYbS91d1JiYkNaV0dDSmRNamFESlIxQStz?=
 =?utf-8?B?d08wSG5vRWcwNElwdXVNZGdld0p2T0Z3Vm0yd0VpdEdJTWZPajZPRFVUUjhj?=
 =?utf-8?B?WDhHU3FBekR5dUd1UjE4eGwzZ29MQjVHaHNBSU51a3VEdWZ3WU5jV3FFTjNU?=
 =?utf-8?B?RW03VTUyTGxCVkNPT0djSUF2OWZmTU9mNU1uK2xsVnMydVAzaENEYlVSbjV0?=
 =?utf-8?B?MEdPakZKM1Noa25OeXNoTFBLZFI5WTdBN2pVV2VRT2c5ZXllN243aFRWT0FR?=
 =?utf-8?B?SWRrR0dYaUIydW9IUDI2RGlPUlRHcXBXTC9GYVM3SzdPcDRBbGI4MWxZcXJ2?=
 =?utf-8?B?ZFRRRFBxbjZVckxrbW5BWmxVRUFjZURGbXFRaTR2QkZEZXJXYU9tQXh6SDZm?=
 =?utf-8?B?amlEVDB6TTFZdnh6bXNrTUVNb0REaHQxZ1d0a245REhQMFJpVGhtMFlaS29U?=
 =?utf-8?B?Z1k2UFFjUGlLWiswbTdIbm5jTXRBWmdlNGNNem1lNisrTW4zNmpjeG8vYUUr?=
 =?utf-8?B?SWxPWjBEM1ZKeWZSUjhIQU9LMlZwTkJ0azVMOFpSRlpXSDNrNmh1bDZKQ3A1?=
 =?utf-8?B?QmxyTlFRUzZ4dkMzRTY1YXg3MURGZ05OZjI4SFE3OGtuWkUzb1hPcnplRVR4?=
 =?utf-8?B?UFpUWEpiVmJ0OTVGRWQzYVFQclBjbWQxM3YxNUR1MGJkdmJyb0FKVGI5VDBO?=
 =?utf-8?B?eG8zSGVEUlVuWTJrYWtOUldlczMrQ0QvU3FSaTFyaGxXNE1wdWlmRDVlOWRp?=
 =?utf-8?B?V0F3TWpCZisxbWcvNXNJWVU2QVdOTUw5eituTElTbDRQV0tVajNtZEFJWnVO?=
 =?utf-8?B?cktnajlqZExRSzA2dTY3KzdzNTliRUMrdUgweThIMVFWemxva1liNm1IdVZa?=
 =?utf-8?B?ZUJyTUMyRWRWSjM3T0NJbmtWeVlYUnNkSlVTdmZNeWVWVXUzb2QzRXFFRFhN?=
 =?utf-8?B?SHM1T2NKWVVJYW9oVHVnaG1wQUNQTG5peGVUMzREbzRYQXdCeFcxVjgyRGNM?=
 =?utf-8?B?RStoRXI4R1BWWGt1ZUF0d0lmeHNyNFFna0xzRGtvMDdnR3RZS2Yrc0UvL1RX?=
 =?utf-8?B?cEdOckp1QXdsbmhmR2s1UFQ2RElpVkVvS3R3SDFnMGpvbHJTeVVlYWo4NGJp?=
 =?utf-8?B?U1FTbFBtRWJEWHRHcm5Xb2J0eEpManJwUDIyeTlJbTAxNkRvTUhMQkg2WnAy?=
 =?utf-8?B?cGc5UU5pNFMrYTRXNFovWUpIV0gyNHkydmNtYkI5YXA5ZmVRMVhqa2ROeDVa?=
 =?utf-8?B?OGlvR1NZKzhZUmlZY2kraWlwcnlNRkE3QkVPSnFxT09IWU9wMjZlUTJqVnNh?=
 =?utf-8?B?RXB3aFlHUmJhV01RQlJZVzQreFZFeHBnM3JHdHc5eXJGTy95TTNWV2lsOWE5?=
 =?utf-8?Q?o5KBnSGICL5QRb7k7kM4dV5Dtr3630GDnD+FoZy?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50bd4c9-9a89-4094-ec42-08d931a97dbe
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:48.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcmLJ+KHEQa+WnziRhXXaTITvp+JXt/8JF3boGOrCCzItJh3c4IikzUbRgZlZhnmD8Y2ifWhfs0pAGW4sR5rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/e2p.c | 664 +++++++++++++++++++++++++
 1 file changed, 664 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.c

diff --git a/drivers/net/wireless/celeno/cl8k/e2p.c b/drivers/net/wireless/=
celeno/cl8k/e2p.c
new file mode 100644
index 000000000000..0e51d88b042a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/e2p.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include "utils/utils.h"
+#include "utils/file.h"
+#include "chip.h"
+#include "e2p.h"
+#include "reg/reg_access.h"
+#include "config.h"
+
+#define EEPROM_VERSION 2
+
+/* EEPROM Parameters - Suitable for ATMEL AT24C16BN */
+#define E2P_SIZE       0x800               /* 2KB =3D 16Kbit */
+#define E2P_PAGE_SIZE  0x10                /* 16 Bytes */
+#define E2P_PAGE_MASK  (E2P_PAGE_SIZE - 1) /* 0xF */
+#define E2P_PAGE_SHIFT 0x4
+
+#define PAGE_NUM(addr) ((addr) >> E2P_PAGE_SHIFT)
+#define PAGE_OFF(addr) ((addr) & E2P_PAGE_MASK)
+
+enum bit_num {
+       BIT0,
+       BIT1,
+       BIT2,
+       BIT3,
+       BIT4,
+       BIT5,
+       BIT6,
+       BIT7,
+       BIT8,
+       BIT9,
+       BIT10,
+       BIT11,
+       BIT12,
+       BIT13,
+       BIT14,
+       BIT15,
+       BIT16,
+       BIT17,
+       BIT18,
+       BIT19,
+       BIT20,
+       BIT21,
+       BIT22,
+       BIT23,
+       BIT24,
+       BIT25,
+       BIT26,
+       BIT27,
+       BIT28,
+       BIT29,
+       BIT30,
+       BIT31
+};
+
+/*
+ * MACSYS_I2C:: PRERLO (0x0) - Clock Prescale register lo-byte
+ * Width: 8, Access: RW, Reset: 0xff.
+ */
+#define I2C_PRERLO (I2C_REG_BASE_ADDR + 0x0)
+
+/*
+ * MACSYS_I2C:: PRERHI (0x4) - Clock Prescale register lo-byte
+ * Width: 8, Access: RW, Reset: 0xff.
+ */
+#define I2C_PRERHI (I2C_REG_BASE_ADDR + 0x4)
+
+/*
+ * MACSYS_I2C:: CTR (0x8) - Control Register
+ * Width: 8, Access: RW, Reset: 0x00.
+ */
+#define I2C_CTR (I2C_REG_BASE_ADDR + 0x8)
+
+#define EN (BIT7) /* =E2=80=981=E2=80=99 the core is enabled. */
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Transmit Register - Data
+ * Width: 8, Access: W, Reset: 0x00.
+ */
+#define I2C_TXD (I2C_REG_BASE_ADDR + 0xC)
+
+/* 7:0 TXD */
+#define TXD (BIT0) /* Next byte to transmit via I2C */
+
+#define TXD_MASK (0xFF << TXD)
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Transmit Register - Address
+ * Width: 8, Access: W, Reset: 0x00.
+ */
+#define I2C_TXADDR (I2C_REG_BASE_ADDR + 0xC)
+
+/*
+ * 7:1 TXADDR
+ * 0 RDWR
+ */
+#define TXADDR (BIT1) /* I2C Slave Address */
+#define RDWR   (BIT0) /* =E2=80=981=E2=80=99 =3D reading from slave. =E2=
=80=980=E2=80=99 =3D writing to slave. */
+
+#define TXADDR_MASK (0x7F << TXADDR)
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Receive Register
+ * Width: 8, Access: R, Reset: 0x00.
+ */
+#define I2C_RXD (I2C_REG_BASE_ADDR + 0xC)
+
+/* 7:0 RXD */
+#define RXD (BIT0) /* Last byte received via I2C. */
+#define RXD_MASK (0xFF << RXD)
+
+/*
+ * MACSYS_I2C:: CR_SR (0x10) - Command Register
+ * Width: 8, Access: WC, Reset: 0x00.
+ */
+#define I2C_CR (I2C_REG_BASE_ADDR + 0x10)
+
+/*
+ * 7 STA
+ * 6 STO
+ * 5 RD
+ * 4 WR
+ * 3 ACK
+ * 2:1 RES
+ * 0 IACK
+ */
+#define STA  (BIT7) /* Generate (repeated) start condition. */
+#define STO  (BIT6) /* Generate stop condition. */
+#define RD   (BIT5) /* Read from slave. */
+#define WR   (BIT4) /* Write to slave. */
+#define ACK  (BIT3) /* When a receiver, sent ACK (ACK =3D =E2=80=980=E2=80=
=99) or NACK (NACK =3D =E2=80=981=E2=80=99). */
+#define IACK (BIT0) /* Interrupt acknowledge, When set, clears a pending i=
nterrupt. */
+
+/*
+ * MACSYS_I2C:: CR_SR (0x10) - Status Register
+ * Width: 8, Access: R, Reset: 0x00.
+ */
+#define I2C_SR (I2C_REG_BASE_ADDR + 0x10)
+
+/*
+ * 7 RX_ACK - Received acknowledge from slave - =E2=80=981=E2=80=99 =3D No=
 acknowledge received.
+ * 6 BUSY - I2C bus busy - =E2=80=981=E2=80=99 after START signal detected=
. =E2=80=980=E2=80=99 after STOP signal detected.
+ * 5 AL - Arbitration lost - This bit is set when the core lost arbitratio=
n.
+ * 4:2 RES
+ * 1 TIP - Transfer in progress. =E2=80=981=E2=80=99 when transferring dat=
a. =E2=80=980=E2=80=99 when transfer complete.
+ * 0 IF - Set when interrupt is pending, cause a processor interrupt if th=
e IEN bit is set.
+ */
+#define RX_ACK (BIT7)
+#define BUSY   (BIT6)
+#define AL     (BIT5)
+#define TIP    (BIT1)
+#define IF     (BIT0)
+
+#define I2C_EEPROM_ADDR(page) (0xA0 | (((page) >> 3) & 0xE)) /* [1-0-1-0-P=
2-P1-P0-0] */
+
+/* E2P_MAX_POLLS should not exceed 12 iterations (attemts) */
+#define E2P_MAX_POLLS 10
+#define E2P_INITIAL_DELAY 32
+
+static int i2c_poll_xfer_acked(struct cl_chip *chip)
+{
+       u32 val =3D cl_reg_read_chip(chip, I2C_SR);
+       int cnt =3D E2P_MAX_POLLS;
+       unsigned long delay =3D E2P_INITIAL_DELAY;
+
+       while ((val & BIT(TIP)) && cnt--) {
+               udelay(delay);
+               val =3D cl_reg_read_chip(chip, I2C_SR);
+               delay <<=3D 1;
+       }
+       ++cnt;
+
+       while ((val & BIT(RX_ACK)) && cnt--) {
+               udelay(delay);
+               val =3D cl_reg_read_chip(chip, I2C_SR);
+               delay <<=3D 1;
+       }
+
+       if (cnt >=3D 0)
+               return 0;
+
+       cl_dbg_chip_err(chip, "ACK FAILED\n");
+       cl_dbg_chip_trace(chip, "I2C_POLL_XFER_ACKED: val=3D%Xh, cnt=3D%d.\=
n", val, cnt);
+
+       return -1;
+}
+
+static int i2c_poll_xfer_no_acked(struct cl_chip *chip)
+{
+       u32 val =3D cl_reg_read_chip(chip, I2C_SR);
+       int cnt =3D E2P_MAX_POLLS;
+       unsigned long delay =3D E2P_INITIAL_DELAY;
+
+       while ((val & BIT(TIP)) && cnt--) {
+               udelay(delay);
+               val =3D cl_reg_read_chip(chip, I2C_SR);
+               delay <<=3D 1;
+       }
+
+       ++cnt;
+
+       while (!(val & BIT(RX_ACK)) && cnt--) {
+               udelay(delay);
+               val =3D cl_reg_read_chip(chip, I2C_SR);
+               delay <<=3D 1;
+       }
+
+       if (cnt >=3D 0)
+               return 0;
+
+       cl_dbg_chip_err(chip, "NO ACK FAILED\n");
+       cl_dbg_chip_trace(chip, "I2C_POLL_XFER_NO_ACKED: val=3D%Xh, cnt=3D%=
d.\n", val, cnt);
+
+       return -1;
+}
+
+static void i2c_write_start(struct cl_chip *chip, u16 page)
+{
+       u32 addr =3D I2C_EEPROM_ADDR(page) & TXADDR_MASK;
+
+       cl_reg_write_chip(chip, I2C_TXADDR, addr);
+       cl_reg_write_chip(chip, I2C_CR, BIT(STA) | BIT(WR));
+}
+
+static void i2c_write(struct cl_chip *chip, u8 data)
+{
+       cl_reg_write_chip(chip, I2C_TXD, data & TXD_MASK);
+       cl_reg_write_chip(chip, I2C_CR, BIT(WR));
+}
+
+static void i2c_write_stop(struct cl_chip *chip, u8 data)
+{
+       cl_reg_write_chip(chip, I2C_TXD, data & TXD_MASK);
+       cl_reg_write_chip(chip, I2C_CR, BIT(STO) | BIT(WR));
+}
+
+static void i2c_read_start(struct cl_chip *chip, u16 page)
+{
+       u32 addr =3D (I2C_EEPROM_ADDR(page) & TXADDR_MASK) | BIT(RDWR);
+
+       cl_reg_write_chip(chip, I2C_TXADDR, addr);
+       cl_reg_write_chip(chip, I2C_CR, BIT(STA) | BIT(WR));
+}
+
+static int i2c_read_stop(struct cl_chip *chip, u8 *data)
+{
+       cl_reg_write_chip(chip, I2C_CR, BIT(STO) | BIT(RD) | BIT(ACK));
+       if (i2c_poll_xfer_no_acked(chip) =3D=3D -1)
+               return -1;
+       *data =3D cl_reg_read_chip(chip, I2C_RXD) & RXD_MASK;
+       return 0;
+}
+
+static void e2p_reg_set_bit(struct cl_chip *chip, u32 reg, u32 bit)
+{
+       u32 regval =3D cl_reg_read_chip(chip, reg);
+
+       regval |=3D bit;
+       cl_reg_write_chip(chip, reg, regval);
+}
+
+static void e2p_reg_clear_bit(struct cl_chip *chip, u32 reg, u32 bit)
+{
+       u32 regval =3D cl_reg_read_chip(chip, reg);
+
+       regval &=3D ~bit;
+       cl_reg_write_chip(chip, reg, regval);
+}
+
+static void e2p_enable(struct cl_chip *chip)
+{
+       /* Disable I2C Core */
+       e2p_reg_clear_bit(chip, I2C_CTR, BIT(EN));
+
+       /*
+        * Set Pre-Scaler LO
+        * pclk =3D 240MHz, desired SCL =3D 400KHz.
+        * Prescale =3D [240e6 / (5*400e3) ] =E2=80=93 1 =3D 120 -1 =3D 119=
 =3D 77h
+        */
+       cl_reg_write_chip(chip, I2C_PRERLO, 0x77);
+
+       /* Set Pre-Scaler HI */
+       cl_reg_write_chip(chip, I2C_PRERHI, 0x0);
+
+       /* Enable I2C Core */
+       e2p_reg_set_bit(chip, I2C_CTR, BIT(EN));
+}
+
+static int e2p_read_byte(struct cl_chip *chip, u16 addr, u8 *pbyte)
+{
+       if (addr > E2P_SIZE) {
+               cl_dbg_chip_err(chip, "Wrong addr or len\n");
+               return -1;
+       }
+
+       /* Clock in the address to read from. */
+       i2c_write_start(chip, PAGE_NUM(addr));
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       /* Addr 8 lsbits are 4 bits page lsbits or`ed with 4 bits page offs=
et */
+       i2c_write(chip, addr);
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       /* Read single byte */
+       i2c_read_start(chip, PAGE_NUM(addr));
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       return i2c_read_stop(chip, pbyte);
+}
+
+static int e2p_write_page(struct cl_chip *chip, u16 addr, u8 *val, u16 num=
_of_bytes)
+{
+       /* This is a write page (up to 16 bytes) operation indicating the o=
ffset to write to. */
+       int i;
+
+       if (num_of_bytes > E2P_PAGE_SIZE)
+               return -1;
+
+       /* Clock in the address to write to. */
+       i2c_write_start(chip, PAGE_NUM(addr));
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       /* Addr 8 lsbits are 4 bits page lsbits or`ed with 4 bits page offs=
et */
+       i2c_write(chip, addr);
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       /* Clock in the data to write. */
+       for (i =3D 0; i < (num_of_bytes - 1); i++, val++) {
+               i2c_write(chip, *val);
+               if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+                       return -1;
+       }
+
+       /* Clock in the last data byte to write */
+       i2c_write_stop(chip, *val);
+       if (i2c_poll_xfer_acked(chip) =3D=3D -1)
+               return -1;
+
+       /* Make sure to wait before moving to another page */
+       mdelay(4);
+
+       return 0;
+}
+
+static int e2p_write_block(struct cl_chip *chip, u16 addr, u16 num_of_byte=
s, u8 *val)
+{
+       u16 bytes_on_curr_page =3D 0, bytes_left_to_write =3D num_of_bytes;
+
+       do {
+               bytes_on_curr_page =3D E2P_PAGE_SIZE - PAGE_OFF(addr);
+               bytes_on_curr_page =3D min(bytes_left_to_write, bytes_on_cu=
rr_page);
+               bytes_left_to_write -=3D bytes_on_curr_page;
+
+               if (e2p_write_page(chip, addr, val, bytes_on_curr_page) =3D=
=3D -1) {
+                       cl_dbg_chip_err(chip, "Error writing page %u offset=
 %u\n",
+                                       PAGE_NUM(addr), PAGE_OFF(addr));
+                       /* Written less bytes than num_of_bytes */
+                       return 0;
+               }
+
+               addr +=3D bytes_on_curr_page;
+               val +=3D bytes_on_curr_page;
+       } while (bytes_left_to_write);
+
+       return num_of_bytes - bytes_left_to_write;
+}
+
+static int e2p_load_dev(struct cl_chip *chip)
+{
+       u8 *cache =3D (u8 *)chip->eeprom_cache;
+       u16 i;
+
+       for (i =3D 0; i < EEPROM_NUM_BYTES; i++)
+               if (e2p_read_byte(chip, i, &cache[i]) =3D=3D -1)
+                       return -1;
+
+       return 0;
+}
+
+static int e2p_dev_read_block(struct cl_chip *chip, u16 addr, u16 num_of_b=
ytes, u8 *val)
+{
+       void *read_block =3D NULL;
+
+       if (!val)
+               return -EFAULT;
+
+       if (addr + num_of_bytes > EEPROM_NUM_BYTES)
+               return -ENXIO;
+
+       read_block =3D (u8 *)chip->eeprom_cache + addr;
+       memcpy(val, read_block, num_of_bytes);
+
+       return num_of_bytes;
+}
+
+static int e2p_dev_write_block(struct cl_chip *chip, u16 addr, u16 num_of_=
bytes, u8 *val)
+{
+       int bytes_written =3D -EIO;
+       void *write_block =3D NULL;
+
+       if (!val)
+               return -EFAULT;
+
+       if (addr + num_of_bytes > EEPROM_NUM_BYTES)
+               return -ENXIO;
+
+       bytes_written =3D e2p_write_block(chip, addr, num_of_bytes, val);
+       write_block =3D (u8 *)chip->eeprom_cache + addr;
+       memcpy(write_block, val, num_of_bytes);
+
+       return bytes_written;
+}
+
+static int e2p_load_bin(struct cl_chip *chip)
+{
+       char filename[CL_FILENAME_MAX];
+       size_t size =3D 0;
+
+       if (cl_chip_is_6g(chip))
+               snprintf(filename, sizeof(filename),
+                        "eeprom/eeprom%u_cl80x6.bin", chip->idx);
+       else
+               snprintf(filename, sizeof(filename),
+                        "eeprom/eeprom%u_cl80x0.bin", chip->idx);
+
+       size =3D cl_file_open_and_read(chip, filename,
+                                    (char **)&chip->eeprom_cache);
+
+       if (size !=3D EEPROM_NUM_BYTES) {
+               cl_dbg_chip_err(chip,
+                               "Invalid EEPROM size - %s (actual %zu) (exp=
ected %d)\n",
+                               filename, size, EEPROM_NUM_BYTES);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int e2p_bin_write_block(struct cl_chip *chip, u16 addr, u16 num_of_=
bytes, u8 *val)
+{
+       return -EOPNOTSUPP;
+}
+
+static int e2p_bin_read_block(struct cl_chip *chip, u16 addr, u16 num_of_b=
ytes, u8 *val)
+{
+       u8 *base;
+       u16 *offset_addr;
+
+       if (!val)
+               return -EFAULT;
+
+       if (addr + num_of_bytes > EEPROM_NUM_BYTES)
+               return -ENXIO;
+
+       base =3D (u8 *)chip->eeprom_cache;
+       offset_addr =3D (u16 *)(base + addr);
+       memmove(val, offset_addr, num_of_bytes);
+
+       return num_of_bytes;
+}
+
+static int cl_e2p_init_bin(struct cl_chip *chip)
+{
+       if (e2p_load_bin(chip))
+               return -1;
+
+       chip->eeprom_read_block =3D e2p_bin_read_block;
+       chip->eeprom_write_block =3D e2p_bin_write_block;
+
+       return 0;
+}
+
+static int cl_e2p_init_dev(struct cl_chip *chip)
+{
+       chip->eeprom_cache =3D kzalloc(EEPROM_NUM_BYTES, GFP_KERNEL);
+
+       if (!chip->eeprom_cache)
+               return -1;
+
+       e2p_enable(chip);
+
+       if (e2p_load_dev(chip))
+               return -1;
+
+       chip->eeprom_read_block =3D e2p_dev_read_block;
+       chip->eeprom_write_block =3D e2p_dev_write_block;
+
+       return 0;
+}
+
+int cl_e2p_init(struct cl_chip *chip)
+{
+       u8 mode =3D chip->conf->ce_eeprom_mode;
+
+       if (mode =3D=3D E2P_MODE_BIN)
+               return cl_e2p_init_bin(chip);
+       else if (mode =3D=3D E2P_MODE_EEPROM)
+               return cl_e2p_init_dev(chip);
+
+       return -1;
+}
+
+void cl_e2p_close(struct cl_chip *chip)
+{
+       kfree(chip->eeprom_cache);
+}
+
+int cl_e2p_write(struct cl_chip *chip, u8 *data, u16 size, u16 addr)
+{
+       if (size !=3D chip->eeprom_write_block(chip, addr, size, data)) {
+               cl_dbg_chip_err(chip, "Error writing eeprom addr 0x%x\n", a=
ddr);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_e2p_read(struct cl_chip *chip, u8 *data, u16 size, u16 addr)
+{
+       if (size !=3D chip->eeprom_read_block(chip, addr, size, data)) {
+               cl_dbg_chip_err(chip, "Error reading eeprom addr 0x%x\n", a=
ddr);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_e2p_write_version(struct cl_chip *chip)
+{
+       u8 version =3D EEPROM_VERSION;
+
+       if (chip->eeprom_cache->general.version !=3D version)
+               return cl_e2p_write(chip, &version,
+                                   SIZE_GEN_VERSION, ADDR_GEN_VERSION);
+
+       return 0;
+}
+
+int cl_e2p_get_addr(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u16 addr =3D *(u16 *)data;
+       u16 len =3D *((u16 *)data + 1);
+       int reply_len;
+       struct cl_e2p_get_reply *reply =3D NULL;
+       struct cl_chip *chip =3D cl_hw->chip;
+       int ret =3D 0;
+       u32 end =3D EEPROM_NUM_BYTES;
+       u8 mode =3D chip->conf->ce_eeprom_mode;
+
+       reply_len =3D sizeof(struct cl_e2p_get_reply) + len;
+       reply =3D kzalloc(reply_len, GFP_KERNEL);
+
+       if (!reply)
+               return -ENOMEM;
+
+       reply->e2p_mode =3D mode;
+
+       cl_dbg_trace(cl_hw, "addr %u len %u\n", addr, len);
+
+       if (end < (addr + len)) {
+               cl_dbg_err(cl_hw,
+                          "size check failed: last addr =3D 0x%x, eeprom m=
emory end"
+                          " =3D 0x%x, eeprom_mode =3D %u\n", (addr + len),
+                          end, mode);
+               ret =3D -EINVAL;
+               goto e2p_fail;
+       }
+
+       if (len !=3D chip->eeprom_read_block(chip, addr, len, reply->e2p_da=
ta)) {
+               cl_dbg_err(cl_hw, "Error reading eeprom addr 0x%x: len %u\n=
",
+                          addr, len);
+               ret =3D -EXDEV;
+               goto e2p_fail;
+       }
+
+       ret =3D cl_vendor_reply(cl_hw, (void *)reply, reply_len);
+
+e2p_fail:
+       kfree(reply);
+
+       return ret;
+}
+
+int cl_e2p_set_addr(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u16 addr =3D *(u16 *)data;
+       u16 len =3D *((u16 *)data + 1);
+       u8 *e2p_data =3D (u8 *)((u16 *)data + 2);
+       u32 end =3D EEPROM_NUM_BYTES;
+
+       cl_dbg_trace(cl_hw, "addr %u len %u\n", addr, len);
+
+       if (end < (addr + len)) {
+               cl_dbg_err(cl_hw, "Invalid E2P addr 0x%x, valid are: 0 - %u=
\n",
+                          addr, end);
+               return -EINVAL;
+       }
+
+       return cl_e2p_write(cl_hw->chip, e2p_data, len, addr);
+}
+
+int cl_e2p_set_wiring_id(struct wiphy *wiphy, struct wireless_dev *wdev,
+                        const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 wiring_id =3D *(u8 *)data;
+
+       return cl_fem_set_wiring_id(chip, wiring_id);
+}
+
+int cl_e2p_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+               void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       char *ret_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!ret_buf)
+               return -ENOMEM;
+
+       snprintf(ret_buf, PAGE_SIZE,
+                "usage:\n"
+                "get addr <address> - Read value from specified addr\n"
+                "get mac - Read MAC address\n"
+                "get serial_number - Read serial number\n"
+                "get pwr_table_id - Read power table IDs\n"
+                "get freq_offset - Read frequency offset\n"
+                "get wiring_id - Read wiring ID\n"
+                "get fem_lut- Read FEM look up table\n"
+                "get platform_id - Read platform ID\n"
+                "get calib <ant> <ch> - Read calibrated offset for a given=
 antenna and channel\n"
+                "get hexdump - Read entire eeprom\n"
+                "get table - Read entire eeprom and print in format of tab=
le\n"
+                "set addr <address> <value> - Write value to specified add=
ress\n"
+                "set mac <macaddr> - Write MAC addr\n"
+                "set serial_number <32 characters> - Write serial number\n=
"
+                "set pwr_table_id <id tcv0> <id tcv1> - Write power table =
IDs\n"
+                "set wiring_id <0 - 255> - Write wiring-ID\n"
+                "set fem_lut <type_num> <lut_lna_bypass> <lut_tx> <lut_rx>=
 <lut_off> -"
+                " Write FEM look up table\n"
+                "set platform_id <val> - Write platform-id to eeprom\n"
+                "set freq_offset <0 - 959> - Write frequency offset to eep=
rom\n"
+                "set calib <antenna> <channel> <power> <offset> <temperatu=
re (optional)> -"
+                " Write calibrated power and power offset for a given ante=
nna and channel\n");
+
+       err =3D cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+       kfree(ret_buf);
+
+       return err;
+}
+
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

