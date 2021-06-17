Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D13AB868
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFQQH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:56 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:43502
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230343AbhFQQHV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj1FxXuvWALUPEaVeJqNDG0lwLnyuYNmiN7Ikq/WM1Ac9wCANb6+k24Ej3nlHwYls00uJVCfj364obslAYKWHUEs+3oErIi0LM5LfYWcH+eS+RC2kXJP1+E9YWcftwPEzqyCBCbu/F04ASpsQBW2pxnz0B3J2TADTeqqXyjKJxQhdwxt0TvdtQf4WfmH66E8HN/cjd+2OlqDn36OgiEBDoiRF7Sdf2qVVz/HidWWtXoihqjdK2MroEvCHoh5AmRYMF5U619bBBOQN2II4GJM24qkHIem9oLjaVnOWYvG5fljGdVVGIsZeJJwfAQW4P/CDaVk2p0VZYeIaVFx5Bb5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cjOdv6YHHTrKvwUsD3mkmqmLXnaW2KBGs6NgRsjjgU=;
 b=GsePQ2c8jpT9LRwfk2vhwSRhpA/WIqMZ6ECEYYfaAAn0H02vI6TD4HuV/ZQ15t3rUwozNBSAC2KDcly1VoTsMtow0ph/flr6G1C3j69yu/B7rD1jcpwwqLgS+5MiyatE3gcNJYbIqjLvfiIN6rrpIdCH/7m6Htn08jEEbcceItrBpZ06yKscHicsyQZzy4Uw21dPma1K/Yv4MnBmvQkL9Feq3+b2RXislPvJopgn45jKpirtzR+oibBT+NJ4rY3P/2WBBitloe/SHojQC9rXRAM8F4vZ56AaOkFErL4SB83QpMdeOt4j6W6yv2nQ3actuOa1MJ/uaXLGbcPPQsl7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cjOdv6YHHTrKvwUsD3mkmqmLXnaW2KBGs6NgRsjjgU=;
 b=nkRxHzBDLtwbanPJsf28aiKoxY5XmUle1nyDYoMsGV15WYR/FUpS3so+BdArvAqMf4U1Xpyaog/mT/1PfRwfQuOaGA9AeY3j6sYcv13kMGKqNkdItgDdV26338hIp3wGwGu78TY6Qk2Da+t3qrrQ51LzVNzQ9mhlesbotrk+Zwo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:20 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:20 +0000
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
Subject: [RFC v1 065/256] cl8k: add dsp.c
Date:   Thu, 17 Jun 2021 15:59:12 +0000
Message-Id: <20210617160223.160998-66-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f010e6b-10e5-4f3a-665c-08d931a97c45
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12685C865C534BEA1635065AF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqucWJ69504ceQ5GtI2SBTklHgqgHkVdcoZxi6HMRDsbIOjYxBV8DmLWs01gRXdS5OZlmlyflmBULHi3kh2eJG9JxxHxRQYoMJzQ1WLNEq3Vmfck1aAE50eMKMfplAY8ZRHioUs1I6R8EmvVPCUmj4PPLknkkMWbZbUntnIK14ZHwjMN2+ON6x8sWiAG2TsKac+dzyJC4FqCneCap3/BPu8rCD9RUBXVQXaaSGRtMukfiNUnH5PeCgCjcAR+jBrCQ9HxQOoNgrNLCSUFMm4ituCZUK57P+Ds/ZYBKGTGYR686U4pdCNv5R6HldMtujdCFmlpA1McPA+t9UzMDyKCVbGGvkMPfhoNw/Y4DJiJg31c0kJWXj0MLgYGWJSZnYLZ/gDNJK4oz6OTJHT8n7569VPByyD2jlRDyllIIqcUc3czePt2NouxPo7nIyNT5QQgc36nZvy+sHYJfLuqq7yVoqSTDnZqpC94b522deWFJF6LyZch9Dqh+yXuajWssiFdn/qst+VGHwY9KK37vQwZm7axwaCCgopf3xin6PCPqXStlZ/tBMm9zPiYHAAscJuCAwRqW7vciSrEKEaty7pA5RvQrC/izr70KKlkBN6vIqUGTnaV/S2G2D1/l4AiDZPk2penyzMVrX/xVQsGl5TIGTHXeNReCBKGJ7KXmEf81DSkAG9Vz4YmsnZfl+FuuMkaLZN0mBIKPf46dgzQmpUMNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(30864003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbT2p9ZAe/wdRN6EGJTK5KigPyIbK3djF2YPCrSBk/bO3OEUkfEDMzj98lDg?=
 =?us-ascii?Q?pKUdd0TTHgYZeBtS5WYJEvk/Xlh9zHh6yVTEkn8BprJrkDoeltxV+OH3Fijv?=
 =?us-ascii?Q?d1qvmzQv3XdNXuH/lBwEYflN8F6WhPsi3rHX3bCExl4phFCryjdAnASLi9FH?=
 =?us-ascii?Q?CY8F1UlWk9h199B5fTSy83SqivMomVWvarzX0uwgHqWF1zrBt+zovm2uvPMx?=
 =?us-ascii?Q?T9jb9QDdV0y7+e2gNMc18wuo1RRlY15r+pnNRuCQ6jXUxLQKEa1fTetv/S79?=
 =?us-ascii?Q?DgiPGOAMcDOcHwmRyDf+r7ygZpD6DrEbUL7LPVScIPXPV7elvAWtvHagyyCT?=
 =?us-ascii?Q?qzknxIT/A5UZqXGtwJgJ3wFvxXGIe8U6Q1y/yesELRTIFTHniowM5dGbkDyq?=
 =?us-ascii?Q?YCnReTdvyt/pxKivkK1v/SdefMVuU7dunihjSZd7QLcy9pVCptru6/E/d6dS?=
 =?us-ascii?Q?0ve5A5W54nyOUbNnUdCb4d4ijolPDDur5E/rU1O5ozJ+YGimTEU2Z4sA4Ud4?=
 =?us-ascii?Q?7uV6X0X9QojJ4f6xVL6+r8fx1biTo0efZdQP3psl1qcHMLqdVfTCZ8TztREM?=
 =?us-ascii?Q?QiWwuXIg0mwT1okLK+GwgbDho9XJglz06Zm1x0V1lSOzu9ezfXTGoSULtcRj?=
 =?us-ascii?Q?QMleyySb4zzysvb9K25jfAnV7Mz87/wVqShvRieRrLrmwF/uf/ViQV3M38Dm?=
 =?us-ascii?Q?lBL1AZ5rxymj8xxxl3GDTHvPJiUMkRCg1PRbHfx5YHQwI44vpaFl1J+N64DO?=
 =?us-ascii?Q?wEPwn6SjibLyumCTBN+5Sg2SzURxGI/nJul/r7p0N68Wfxfi6olbNEz2TEwx?=
 =?us-ascii?Q?+USBtmkjgkORPyG7PLhfh9ydVR8ze519Papw/KTkJuJFAAFNyddCksw/ig4d?=
 =?us-ascii?Q?AB7zLzJtEDAwbxscG5yzga+tceOSdrUu0eRdJ1/F2vncmlvMWuVsGnTy/F2Y?=
 =?us-ascii?Q?2iqL3tJM3ya4q4XfBw5jzduvOd33aJlyHC0xm6rX9LigfVigN8YjvdzxaBbA?=
 =?us-ascii?Q?GBBYjUxKetfrjoiNcHwSAA++l+TVLXFINeSOOlAy+x5a1ufM9EKc9b/HfeWA?=
 =?us-ascii?Q?eY3Eht3swaYz8xlUQ/PtLyJ+1ebTzGdYfOydti5/x+81gRJdKiJgNJ7xgV3j?=
 =?us-ascii?Q?cJxwk7dRFSYiym5LI2CLDPzdLLUyYBgW6EZKZFmpk5CsQvEXk+50G8103Cgk?=
 =?us-ascii?Q?ecAc/Tbxkg9Hz2hoXyfhAsN8w00T1QMfBQTWzpLXifn50A9jKbKzPHTraks7?=
 =?us-ascii?Q?aoP5/seleL5doPuKESAHkRSmC5Yqq1s7ChuJAbudxjYKzlfW4hd3b1t7+qrJ?=
 =?us-ascii?Q?cIu5OKOUuBaq4kt0P4sDy3VN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f010e6b-10e5-4f3a-665c-08d931a97c45
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:45.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUXhGISd/kF68uUMeAiFNLXP0SBXX34N/Uwa5MjUetSnHl/9Z4uJeUzj2gYTX/vHe+Jqg7LFDPTUYVDmJqV9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dsp.c | 611 +++++++++++++++++++++++++
 1 file changed, 611 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.c

diff --git a/drivers/net/wireless/celeno/cl8k/dsp.c b/drivers/net/wireless/=
celeno/cl8k/dsp.c
new file mode 100644
index 000000000000..cf9646cd1ed4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dsp.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "reg/reg_modem_gcu.h"
+#include "reg/reg_macdsp_api.h"
+#include "reg/reg_cmu.h"
+#include "reg/reg_access.h"
+#include "reg/ceva.h"
+#include "dsp.h"
+#include "hw.h"
+#include <linux/firmware.h>
+
+#define BUSY_WAIT_LIMIT 10000
+
+static int dsp_busy_wait(struct cl_hw *cl_hw, u32 control_reg)
+{
+       int i;
+
+       for (i =3D 0; i < BUSY_WAIT_LIMIT; i++) {
+               /* Poll Bit29 to verify DMA transfer has ended. */
+               if ((cl_reg_read(cl_hw, control_reg) & 0x20000000) =3D=3D 0=
)
+                       return 0;
+
+               cpu_relax();
+       }
+
+       return -EIO;
+}
+
+static void cl_dsp_boot(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               /* Disable ceva_free_clk */
+               cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 0);
+               /* Assert Ceva reset */
+               cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+       } else {
+               /* Disable ceva_free_clk */
+               cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 0);
+               /* Assert Ceva reset */
+               cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+       }
+
+       /* Set Ceva boot=3D1 */
+       modem_gcu_ceva_ctrl_boot_setf(cl_hw, 1);
+       /* Set Ceva vector */
+       modem_gcu_ceva_vec_set(cl_hw, 0);
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               /* Enable ceva_clk */
+               cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+               /* Disabel ceva_clk */
+               cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 0);
+               /* De-Assert Ceva reset - Reset Release */
+               cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 1);
+               /* Enable ceva_clk */
+               cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+       } else {
+               /* Enable ceva_clk */
+               cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+               /* Disabel ceva_clk */
+               cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 0);
+               /* De-Assert Ceva reset - Reset Release */
+               cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 1);
+               /* Enable ceva_clk */
+               cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+       }
+
+       /* Release Ceva external_wait */
+       modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0);
+       /* Set Ceva boot=3D0 */
+       modem_gcu_ceva_ctrl_boot_setf(cl_hw, 0);
+}
+
+static void config_dma_for_code_copy(struct cl_hw *cl_hw, u32 page)
+{
+       /* Configure Program DMA to copy FW code from Shared PMEM to intern=
al PMEM. */
+
+       /* External address to read from. */
+       cl_reg_write(cl_hw, CEVA_CPM_PDEA_REG, CEVA_SHARED_PMEM_BASE_ADDR_I=
NTERNAL);
+       /* Internal address to write to. */
+       cl_reg_write(cl_hw, CEVA_CPM_PDIA_REG, CEVA_SHARED_PMEM_SIZE * page=
);
+       /* Page size */
+       cl_reg_write(cl_hw, CEVA_CPM_PDTC_REG, CEVA_SHARED_PMEM_SIZE);
+}
+
+static void config_dma_for_external_data_copy(struct cl_hw *cl_hw)
+{
+       /* Configure Program DMA to copy FW code from Shared XMEM to intern=
al XMEM. */
+
+       /* External address to read from. */
+       cl_reg_write(cl_hw, CEVA_CPM_DDEA_REG, CEVA_SHARED_XMEM_BASE_ADDR_I=
NTERNAL);
+       /* Internal address to write to. */
+       cl_reg_write(cl_hw, CEVA_CPM_DDIA_REG, 0);
+       /* Page size + DMA direction is write */
+       cl_reg_write(cl_hw, CEVA_CPM_DDTC_REG,
+                    CEVA_SHARED_XMEM_SIZE | CEVA_CPM_DDTC_WRITE_COMMAND);
+}
+
+static int cl_dsp_hex_load(struct cl_hw *cl_hw, const u8 *buf,
+                          off_t offset, size_t size, size_t buf_size)
+{
+       u8 single_buf[4] =3D {0};
+       u32 bin_data =3D 0;
+       u8 next_byte;
+       u8 byte_num =3D 0;
+       int ret =3D 0;
+       ssize_t oft =3D 0;
+       size_t real_size =3D min(size * 3, buf_size);
+       /*
+        * CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST is global and we don't
+        * want to add TCV reg offset.
+        */
+       bool chip_reg =3D (offset =3D=3D CEVA_SHARED_PMEM_BASE_ADDR_FROM_HO=
ST);
+
+       if (buf_size % 3) {
+               cl_dbg_err(cl_hw, "DSP size %zu must be divided by 3 !!!\n"=
,
+                          buf_size);
+               return -EINVAL;
+       }
+
+       while (oft < real_size) {
+               memcpy(single_buf, buf + oft, 3);
+               /* Each line contains 2 hex digits + a line feed, i.e. 3 by=
tes */
+               ret =3D kstrtou8(single_buf, 16, &next_byte);
+               if (ret < 0) {
+                       cl_dbg_err(cl_hw,
+                                  "ret =3D %d, oft =3D %zu,"
+                                  "single_buf =3D 0x%x 0x%x 0x%x 0x%x\n",
+                                  ret, oft, single_buf[0], single_buf[1],
+                                  single_buf[2], single_buf[3]);
+                       return ret;
+               }
+
+               /* Little-endian order. */
+               bin_data +=3D next_byte << (8 * byte_num);
+               byte_num =3D (byte_num + 1) % 4;
+
+               /* Read 4 lines from the file, and then write. */
+               if (byte_num =3D=3D 0) {
+                       if (chip_reg)
+                               cl_reg_write_chip(cl_hw->chip, offset, bin_=
data);
+                       else
+                               cl_reg_write_direct(cl_hw, offset, bin_data=
);
+                       offset +=3D 4;
+                       bin_data =3D 0;
+               }
+
+               memset(&single_buf, 0, sizeof(single_buf));
+               oft +=3D 3;
+       }
+
+       return 0;
+}
+
+static int load_dsp_code(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u32 real_size;
+       u32 page;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       u8 *buf =3D NULL;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s",
+                cl_hw->conf->ce_dsp_code);
+
+       cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_code);
+
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+                          path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+       buf =3D (u8 *)fw->data;
+
+       for (page =3D 0; page < CEVA_MAX_PAGES; page++) {
+               /* Copy DSP code (one page each time) */
+               ret =3D  cl_dsp_hex_load(cl_hw, buf,
+                                      CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST=
,
+                                      CEVA_SHARED_PMEM_SIZE, size);
+               if (ret !=3D 0) {
+                       cl_dbg_err(cl_hw, "Failed to load pmem page 0x%x!\n=
", page);
+                       break;
+               }
+
+               config_dma_for_code_copy(cl_hw, page);
+               ret =3D dsp_busy_wait(cl_hw, CEVA_CPM_PDTC_REG);
+
+               if (ret) {
+                       cl_dbg_err(cl_hw, "dsp_busy_wait failed!\n");
+                       goto out;
+               }
+
+               real_size =3D min_t(u32, CEVA_SHARED_PMEM_SIZE * 3, size);
+               buf +=3D real_size;
+               size -=3D real_size;
+       }
+
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static int load_dsp_data(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s",
+                cl_hw->conf->ce_dsp_data);
+
+       cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_data);
+
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+                          path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+
+       ret =3D cl_dsp_hex_load(cl_hw, fw->data, REG_MACDSP_API_BASE_ADDR,
+                             CEVA_DSP_DATA_SIZE, size);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load HEX file\n");
+               goto out;
+       }
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static int load_dsp_external_data(struct cl_hw *cl_hw)
+{
+       /*
+        * Shared XMEM is not accessible by host.
+        * Copy the XMEM section to DRAM first and then use CEVA internal D=
MA to copy to
+        * SHARED XMEM.
+        */
+       struct cl_chip *chip =3D cl_hw->chip;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s",
+                cl_hw->conf->ce_dsp_external_data);
+
+       cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_external_dat=
a);
+
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+                          path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+
+       ret =3D cl_dsp_hex_load(cl_hw, fw->data, REG_MACDSP_API_BASE_ADDR,
+                             CEVA_DSP_EXT_DATA_SIZE, size);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load HEX file\n");
+               goto out;
+       }
+
+       config_dma_for_external_data_copy(cl_hw);
+       ret =3D dsp_busy_wait(cl_hw, CEVA_CPM_DDTC_REG);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "dsp_busy_wait failed!\n");
+               goto out;
+       }
+
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static bool cl_dsp_is_universal_file(struct cl_chip *chip)
+{
+       return (cl_chip_is_tcv0_enabled(chip) &&
+               cl_chip_is_tcv1_enabled(chip) &&
+               !strcmp(chip->cl_hw_tcv0->conf->ce_dsp_code,
+                       chip->cl_hw_tcv1->conf->ce_dsp_code));
+}
+
+static int load_dsp_code_dual(struct cl_chip *chip, const char *filename)
+{
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       u32 real_size;
+       u32 page;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       u8 *buf =3D NULL;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+       cl_dbg_chip_verbose(chip, "from %s\n", filename);
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+
+       if (ret) {
+               cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n"=
,
+                               path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+       buf =3D (u8 *)fw->data;
+
+       for (page =3D 0; page < CEVA_MAX_PAGES; page++) {
+               /* Copy DSP code (one page each time) */
+               ret =3D cl_dsp_hex_load(chip->cl_hw_tcv0, buf,
+                                     CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST,
+                                     CEVA_SHARED_PMEM_SIZE, size);
+               if (ret) {
+                       cl_dbg_chip_err(chip, "Failed to load pmem page 0x%=
x!\n", page);
+                       break;
+               }
+
+               config_dma_for_code_copy(cl_hw_tcv0, page);
+               ret =3D dsp_busy_wait(cl_hw_tcv0, CEVA_CPM_PDTC_REG);
+
+               if (ret) {
+                       cl_dbg_err(cl_hw_tcv0, "dsp_busy_wait failed\n");
+                       goto out;
+               }
+
+               config_dma_for_code_copy(cl_hw_tcv1, page);
+               ret =3D dsp_busy_wait(cl_hw_tcv1, CEVA_CPM_PDTC_REG);
+
+               if (ret) {
+                       cl_dbg_err(cl_hw_tcv1, "dsp_busy_wait failed\n");
+                       goto out;
+               }
+
+               real_size =3D min_t(u32, CEVA_SHARED_PMEM_SIZE * 3, size);
+               buf +=3D real_size;
+               size -=3D real_size;
+       }
+
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static int load_dsp_external_data_dual(struct cl_chip *chip, const char *f=
ilename)
+{
+       /*
+        * Shared XMEM is not accessible by host.
+        * Copy the XMEM section to DRAM first and then use CEVA internal D=
MA to copy to
+        * SHARED XMEM.
+        */
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+       cl_dbg_chip_verbose(chip, "from %s\n", filename);
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+
+       if (ret) {
+               cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n"=
,
+                               path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+
+       /* TCV0 */
+       ret =3D cl_dsp_hex_load(cl_hw_tcv0, fw->data, REG_MACDSP_API_BASE_A=
DDR,
+                             CEVA_DSP_EXT_DATA_SIZE, size);
+
+       if (ret) {
+               cl_dbg_err(cl_hw_tcv0, "Failed to load HEX file\n");
+               goto out;
+       }
+
+       config_dma_for_external_data_copy(cl_hw_tcv0);
+       ret =3D dsp_busy_wait(cl_hw_tcv0, CEVA_CPM_DDTC_REG);
+
+       if (ret) {
+               cl_dbg_err(cl_hw_tcv0, "dsp_busy_wait failed!\n");
+               goto out;
+       }
+
+       /* TCV1 */
+       ret =3D cl_dsp_hex_load(cl_hw_tcv1, fw->data, REG_MACDSP_API_BASE_A=
DDR,
+                             CEVA_DSP_EXT_DATA_SIZE, size);
+
+       if (ret) {
+               cl_dbg_err(cl_hw_tcv1, "Failed to load HEX file\n");
+               goto out;
+       }
+
+       config_dma_for_external_data_copy(cl_hw_tcv1);
+       ret =3D dsp_busy_wait(cl_hw_tcv1, CEVA_CPM_DDTC_REG);
+
+       if (ret) {
+               cl_dbg_err(cl_hw_tcv1, "dsp_busy_wait failed!\n");
+               goto out;
+       }
+
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static int load_dsp_data_dual(struct cl_chip *chip, const char *filename)
+{
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       const struct firmware *fw;
+       size_t size =3D 0;
+       char path_name[CL_PATH_MAX] =3D {0};
+       int ret;
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+       cl_dbg_chip_verbose(chip, "from %s\n", filename);
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+
+       if (ret) {
+               cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n"=
,
+                               path_name, ret);
+               goto out;
+       }
+
+       size =3D fw->size;
+
+       ret =3D cl_dsp_hex_load(cl_hw_tcv0, fw->data,
+                             REG_MACDSP_API_BASE_ADDR,
+                             CEVA_DSP_DATA_SIZE, size);
+
+       if (ret !=3D 0) {
+               cl_dbg_err(cl_hw_tcv0, "Failed to load HEX file\n");
+               goto out;
+       }
+
+       ret =3D cl_dsp_hex_load(cl_hw_tcv1, fw->data,
+                             REG_MACDSP_API_BASE_ADDR,
+                             CEVA_DSP_DATA_SIZE, size);
+
+       if (ret !=3D 0) {
+               cl_dbg_err(cl_hw_tcv1, "Failed to load HEX file\n");
+               goto out;
+       }
+
+out:
+       release_firmware(fw);
+
+       return ret;
+}
+
+static void print_ceva_core_info(struct cl_hw *cl_hw)
+{
+       cl_dbg_trace(cl_hw, "CEVA_CORE_VERSION_ADDR=3D0x%X.\n",
+                    cl_reg_read(cl_hw, CEVA_CORE_VERSION_ADDR));
+       cl_dbg_trace(cl_hw, "CEVA_CORE_ID_ADDR=3D0x%X.\n",
+                    cl_reg_read(cl_hw, CEVA_CORE_ID_ADDR));
+}
+
+static int cl_dsp_load_dual(struct cl_chip *chip)
+{
+       int ret =3D 0;
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       struct cl_tcv_conf *tcv0_conf =3D cl_hw_tcv0->conf;
+
+       modem_gcu_ceva_ctrl_external_wait_setf(cl_hw_tcv0, 0x1);
+       modem_gcu_ceva_ctrl_external_wait_setf(cl_hw_tcv1, 0x1);
+
+       print_ceva_core_info(cl_hw_tcv0);
+       print_ceva_core_info(cl_hw_tcv1);
+
+       ret =3D load_dsp_code_dual(chip, tcv0_conf->ce_dsp_code);
+       if (ret !=3D 0) {
+               cl_dbg_chip_err(chip,
+                               "Failed to load DSP code. Error code %d.\n"=
,
+                               ret);
+               return ret;
+       }
+
+       ret =3D load_dsp_external_data_dual(chip, tcv0_conf->ce_dsp_externa=
l_data);
+       if (ret !=3D 0) {
+               cl_dbg_chip_err(chip,
+                               "Failed to load DSP external data. Error co=
de %d.\n",
+                               ret);
+               return ret;
+       }
+
+       ret =3D load_dsp_data_dual(chip, tcv0_conf->ce_dsp_data);
+       if (ret !=3D 0) {
+               cl_dbg_chip_err(chip,
+                               "Failed to load DSP data. Error code %d.\n"=
,
+                               ret);
+               return ret;
+       }
+
+       macdsp_api_config_space_set(cl_hw_tcv0, 0);
+       /* Release DSP wait. */
+       cl_dsp_boot(cl_hw_tcv0);
+
+       macdsp_api_config_space_set(cl_hw_tcv1, 0);
+       /* Release DSP wait. */
+       cl_dsp_boot(cl_hw_tcv1);
+
+       return ret;
+}
+
+static int _cl_dsp_load(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0x1);
+       print_ceva_core_info(cl_hw);
+
+       ret =3D load_dsp_code(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load DSP code %d\n", ret);
+               return ret;
+       }
+
+       ret =3D load_dsp_external_data(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load DSP external data %d\n", =
ret);
+               return ret;
+       }
+
+       ret =3D load_dsp_data(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load DSP data %d\n", ret);
+               return ret;
+       }
+
+       macdsp_api_config_space_set(cl_hw, 0);
+       /* Release DSP wait */
+       cl_dsp_boot(cl_hw);
+
+       return ret;
+}
+
+int cl_dsp_load_regular(struct cl_chip *chip)
+{
+       int ret =3D 0;
+
+       if (cl_dsp_is_universal_file(chip))
+               return cl_dsp_load_dual(chip);
+
+       if (cl_chip_is_tcv0_enabled(chip)) {
+               ret =3D _cl_dsp_load(chip->cl_hw_tcv0);
+               if (ret)
+                       return ret;
+       }
+
+       if (cl_chip_is_tcv1_enabled(chip)) {
+               ret =3D _cl_dsp_load(chip->cl_hw_tcv1);
+               if (ret)
+                       return ret;
+       }
+
+       return ret;
+}
+
+int cl_dsp_load_recovery(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0x1);
+
+       ret =3D load_dsp_external_data(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load DSP external data %d\n", =
ret);
+               return ret;
+       }
+
+       ret =3D load_dsp_data(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Failed to load DSP data %d\n", ret);
+               return ret;
+       }
+
+       macdsp_api_config_space_set(cl_hw, 0);
+       /* Release DSP wait. */
+       cl_dsp_boot(cl_hw);
+
+       return ret;
+}
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

