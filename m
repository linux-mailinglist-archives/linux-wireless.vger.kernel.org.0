Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A403AB8CC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFQQKj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:39 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:56046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233696AbhFQQJl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4fpxhFvG9h4i2Xco8T6D9kzqwnNI47bEK1yrEPmg5k/OZm79vMC1gO2IohE/Pv2Uqj+UNkSzRxkWHQogyH54IX5WC3s8UZfrjrkC52i4lnWZTJnC2ZFAOUMszJ/3kM5g6EOnvDuPDDpjYzqvUpBkaUfRKbbxooiL5D3d2tu+5lwCDgwA9rE66MtOSI1pIO8dZmkKTw2sdZPu7Zl+xbr5xXWPGHfiKYW6RFdFHMfrH0p5OotLxzPOMHDUuUM+4jSOsyKuUjrbfmD+0b2QIqCemfrpPe23N7GVnKBh2expxvlmK+nhFkRDua/Tru1auFKWnuOy70SXkdsWonWpfTgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6NzzCVTJJJaQqe1ocfERNfd8Rb79tAz72jx2gWbdSs=;
 b=N+vSJTIflSTOF6xCdnQ5wbio0CkFAsOSBvzQWcYxuZtiUgqFrIZBB3r9EQXiSaQDEhAXxyr16JLg6VvR2hJzfyIZgKq76FFt41S88kAV1h4ckdib0Xcra6oarHJqVGVUR5nFZxFO+XeQeyrHGY3/Od3HJvbQ6sAg+K05lCkiEjRmhT46c5lGYNft/WXxD2BTE5HL0Nk9+6BfFQzvhck03ECt4Rs/u2i+HBUEFZEZiOdbBAb2vDCcM5VHOFDAM4yHqlIBcmE8c1xI88YVjvySjGTgYzB9qmvA6p/9ymL1xtniuuMHfabajUc+HnApngjmqarRUmvuaFNipmA16M5euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6NzzCVTJJJaQqe1ocfERNfd8Rb79tAz72jx2gWbdSs=;
 b=TvvITgoniSlOpTQx7heDgnsbvM5s7bCy/02EcukvYUXpysMqiQXElJudA9lo8p2PSM2ri2nnoQAXP2vNq85UPYpy6GpHTt06GW1UdyBeXNU/kdmkzKX/ruFooWYUfQqm0md4PGO2rLpSLfxKMj7dFQjyau60OOjpSlr2Znfvl6U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:53 +0000
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
Subject: [RFC v1 148/256] cl8k: add reg/reg_access.h
Date:   Thu, 17 Jun 2021 16:00:35 +0000
Message-Id: <20210617160223.160998-149-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa166848-80fd-40d4-716c-08d931a9b2e8
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059F73F354E66780DFC8F32F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6glUc1iQPpmbQIObQsEpABgjdRkAHDx+S2rUn+ApvCt0yCyvd9yk878RvY2ti+SdkPvSi78o2i0Wt8h1loo/a8rpCBwsExYrCP3buIh3Xm3S75gOXaHdeDkGPaW+FtjKx4xA99JhjOwXY7eGOqBSzKr3yJG9mc7uSr4a5YiwQWDLufRbSo9ARZkFhMGyNoAOlx055d/A12iLljiREeycM9jIdMfX2amBOdoqiiXwn2hSGvcmGWJYK9mBPmWUYjJeD9S2gpIlbt3YwEi1dxiExTDRr2gqfHjyXBAMUgRbm3LLBH9vb+nmK6Zs7DGP06HukjoqUPpxWb5IsfZSJKeQHR80P6nz1zve+4AHnP+Os3HJqpbhl1l2+idKfjvrk+ScE6X4G17PsUsDhVLLqbL+lamkLr1UC78fVWdJJfMFPQ+PUTkzlnENx4B4BQAAconvk2lsqLypybro608N/HazO0jgLjn243VaMRZVSNKXBoGJJFRKewtfjzDfHarNdOFgjhIGcPxngOzlOLCcJkxjCDinbrk01YKdf141oGHzV8FH6uWh6LatJjEBQ+6DF0ySnyuwdUap131P31ilPkv+vwgJ8gxmThvoQnDSnfdz6PM7I+pimn8hDEv0vabmb7xhaPZpq3+sK39WnOP57bPRMVXCwQ1131H2GfJ9JSSwser2vTniiEltoWDIvS0gyhrCs7hH/wf/Hgop8bCp6aMVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(376002)(396003)(366004)(26005)(956004)(478600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(316002)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQTCz2HXJwMA0SjqBNHFVPJNi3UsYbSRW+3X2rTF4frFZyBZ3/I0UG9cxzTk?=
 =?us-ascii?Q?Ebt6UXfKmEIIGYSI5NI44Kvz8F7/z8hu9qBcDQeXcPrZBPDqfKWgVVeVRb91?=
 =?us-ascii?Q?NL7hRu6NZZoQPiob+l1TDzDyP2jSMXwrLXAnZzASitLDfrtlKpcBnIvofZ+x?=
 =?us-ascii?Q?84EdQnGMYn+SIGuQYZLgDaZiVNnHhH9Yw8X4vwWVDGu9tUGzayBh/PX31K3b?=
 =?us-ascii?Q?6qSQX9kkPV9wLeDXiq1kMJ+fxxuNdmck9BuWAuPzxBMB7SUjUbuNMHDbbfD/?=
 =?us-ascii?Q?cgyscaxVqcNvXJS3dudr4mpP4k4bD6CvNvqfCYSecQdtPLx6WeajR85BKCNm?=
 =?us-ascii?Q?CVFxHuYnFCGhc4H1Hw7660u1IQPw2Lb6B8KoqnySj3WbV+WITU4d5UGJ+Fxk?=
 =?us-ascii?Q?2mNnbQgp9dguuKx9wdff+5heI/lfIl7VbeDwlkKyffA+4wRmNrVoi98b6G7E?=
 =?us-ascii?Q?Xv14qtwU82YDCTYshpNMGl+SA2QWaqZH/Tah68xYX4rkboIfSWih3VDNpzNW?=
 =?us-ascii?Q?NfPMtKvV6sHcFTstXdwECNPgx6QLDDBci2q3Htr7HG59li7OUyzbeTJaRGbY?=
 =?us-ascii?Q?q9wRTRuJok7kbROG0LA0siVLtyvIzD0gYtI8bAh9mMx+0HCG2P5eIw/YOnTT?=
 =?us-ascii?Q?/Yi7FqUDHfQzS7NeK6PZ1i7eEgl1F9NKjlJHCY77IdpjS7+Oe7pLGbF6f/AK?=
 =?us-ascii?Q?m9IzDIs93LOre8cIEdFq4C6FtsD0qGFoDLIoDCtPg7sie2s0m+6VttnXltXJ?=
 =?us-ascii?Q?uqu21T70dVBEvqVRZ4n2qle+R4xh78g8BFTSAizNujA/zPT/YDoIj5Gwy+E7?=
 =?us-ascii?Q?sVAR+HYoXv8+LXYml88AQZRDItieMpN711tFQZzNraTK5skYjmnyEPrqKqDk?=
 =?us-ascii?Q?iu/rCvcxSRRUvhLU/oPmBA9NfbKUdMGpAqOfCISc+miy7VBN1p4hWNAxvObi?=
 =?us-ascii?Q?z+04w6bcXRzegPhrhavMgYt5OCNnUNxxcBRSSjAMUMNprmHUEi7KQgwLJHR3?=
 =?us-ascii?Q?rA8fH5dvRR/2PwSDvLiHq2ziV4BuhWYpWdbj+wEMLQPdHlGEnDFJLSOz6oqI?=
 =?us-ascii?Q?ERhH87rtGg0Y2QcK14vFgg2p+Ss0hNUxrCZ4ILH7S90ExnRUFvaT1gH7TwAZ?=
 =?us-ascii?Q?2/UuQ3ZwaiV7hfM769j5YiIACUNMxzHuhFbiA105QP5zzIfUnH3etbuLOyQY?=
 =?us-ascii?Q?OtJx+coSKV5BUQ83HnXLFqoFRNCOvvKjWrPTRoXZTz7kYg9zbkdmn6QwVSW9?=
 =?us-ascii?Q?LO5cSy9I+itts2UGrywMl0RXzyKk+mZJ4KuAbE8AlQwjNieBru4j9aABPzfI?=
 =?us-ascii?Q?zNmtfA4HABtZeaaLSnDUNxzJ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa166848-80fd-40d4-716c-08d931a9b2e8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:17.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHPlwhRQ8dRTKRLgz41tzt9+jIc28U/lIuwSR5AwCi0hGY28NTgpKbdKYSkW9RwcMMKIrpffIEXThgaGVW2noA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_access.h | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_access.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_access.h b/drivers/ne=
t/wireless/celeno/cl8k/reg/reg_access.h
new file mode 100644
index 000000000000..337f6f809d35
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_access.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_ACCESS_H
+#define CL_REG_ACCESS_H
+
+#include "hw.h"
+#include "chip.h"
+#include "ceva.h"
+#include "fw/msg_tx.h"
+
+#define CL_REG_DBG(...) \
+       do { \
+               if (cl_hw->reg_dbg) \
+                       cl_dbg_verbose(__VA_ARGS__); \
+       } while (0)
+
+#define CL_REG_DBG_CHIP(...) \
+       do { \
+               if (chip->reg_dbg) \
+                       cl_dbg_chip_verbose(__VA_ARGS__); \
+       } while (0)
+
+#define XTENSA_PIF_BASE_ADDR     0x60000000
+
+/*
+ * SHARED_RAM Address.
+ * Actually the PCI BAR4 window will be configured such as SHARED RAM
+ * is accessed with offset 0 (within the AHB Bridge main window)
+ */
+#define SHARED_RAM_START_ADDR    0x00000000
+
+#define REG_MAC_HW_SMAC_OFFSET   0x80000
+#define REG_PHY_SMAC_OFFSET      0x100000
+
+#define REG_MACDSP_API_BASE_ADDR 0x00400000
+#define REG_MAC_HW_BASE_ADDR     0x00600000
+#define REG_RIU_BASE_ADDR        0x00486000
+#define REG_RICU_BASE_ADDR       0x004B4000
+
+#define APB_REGS_BASE_ADDR       0x007C0000
+#define I2C_REG_BASE_ADDR        (APB_REGS_BASE_ADDR + 0x3000)
+#define IPC_REG_BASE_ADDR        (APB_REGS_BASE_ADDR + 0x4000)
+
+/* MACSYS_GCU_XT_CONTROL fields */
+#define SMAC_DEBUG_ENABLE      BIT(21)
+#define SMAC_BREAKPOINT        BIT(20)
+#define SMAC_OCD_HALT_ON_RESET BIT(19)
+#define SMAC_RUN_STALL         BIT(18)
+#define SMAC_DRESET            BIT(17)
+#define SMAC_BRESET            BIT(16)
+#define UMAC_DEBUG_ENABLE      BIT(13)
+#define UMAC_BREAKPOINT        BIT(11)
+#define UMAC_OCD_HALT_ON_RESET BIT(11)
+#define UMAC_RUN_STALL         BIT(10)
+#define UMAC_DRESET            BIT(9)
+#define UMAC_BRESET            BIT(8)
+#define LMAC_DEBUG_ENABLE      BIT(5)
+#define LMAC_BREAKPOINT        BIT(4)
+#define LMAC_OCD_HALT_ON_RESET BIT(3)
+#define LMAC_RUN_STALL         BIT(2)
+#define LMAC_DRESET            BIT(1)
+#define LMAC_BRESET            BIT(0)
+
+#define XMAC_BRESET \
+       (LMAC_BRESET | SMAC_BRESET | UMAC_BRESET)
+#define XMAC_DRESET \
+       (LMAC_DRESET | SMAC_DRESET | UMAC_DRESET)
+#define XMAC_RUN_STALL \
+       (LMAC_RUN_STALL | SMAC_RUN_STALL | UMAC_RUN_STALL)
+#define XMAC_OCD_HALT_ON_RESET \
+       (LMAC_OCD_HALT_ON_RESET | SMAC_OCD_HALT_ON_RESET | UMAC_OCD_HALT_ON=
_RESET)
+#define XMAC_DEBUG_ENABLE \
+       (LMAC_DEBUG_ENABLE | SMAC_DEBUG_ENABLE | UMAC_DEBUG_ENABLE)
+
+/* Macro to read a platform register */
+#define REG_PL_RD(addr) le32_to_cpu(*(volatile __le32 *)(addr))
+
+/* Macro to write a platform register */
+#define REG_PL_WR(addr, value) ((*(volatile __le32 *)(addr)) =3D cpu_to_le=
32(value))
+
+#define CL_BAR_REG_READ(chip, reg) \
+       le32_to_cpu((__force __le32)readl((chip)->pci_bar0_virt_addr + (reg=
)))
+
+#define CL_BAR_REG_WRITE(chip, reg, val) \
+       writel((__force u32)cpu_to_le32(val), (chip)->pci_bar0_virt_addr + =
(reg))
+
+static inline u32 get_actual_reg(struct cl_hw *cl_hw, u32 reg)
+{
+       if ((reg & 0x00ff0000) =3D=3D REG_MAC_HW_BASE_ADDR)
+               return cl_hw->mac_hw_regs_offset + reg;
+
+       if ((reg & 0x00f00000) =3D=3D REG_MACDSP_API_BASE_ADDR)
+               return cl_hw->phy_regs_offset + reg;
+
+       return reg;
+}
+
+static inline u32 cl_reg_read(struct cl_hw *cl_hw, u32 reg)
+{
+       u32 actual_reg =3D get_actual_reg(cl_hw, reg);
+       u32 val =3D 0;
+
+       if (actual_reg =3D=3D (u32)(-1))
+               return 0xff;
+
+       val =3D REG_PL_RD(cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+       CL_REG_DBG(cl_hw, "reg=3D0x%x, val=3D0x%x\n", actual_reg, val);
+       return val;
+}
+
+static inline void cl_reg_write_direct(struct cl_hw *cl_hw, u32 reg, u32 v=
al)
+{
+       u32 actual_reg =3D get_actual_reg(cl_hw, reg);
+
+       if (actual_reg =3D=3D (u32)(-1))
+               return;
+
+       CL_REG_DBG(cl_hw, "reg=3D0x%x, val=3D0x%x\n", actual_reg, val);
+       REG_PL_WR(cl_hw->chip->pci_bar0_virt_addr + actual_reg, val);
+}
+
+#define BASE_ADDR(reg) ((ptrdiff_t)(reg) & 0x00fff000)
+
+static inline bool should_send_msg(struct cl_hw *cl_hw, u32 reg)
+{
+       /*
+        * Check in what cases we should send a message to the firmware,
+        * and in what cases we should write directly.
+        */
+       if (!cl_hw->fw_active)
+               return false;
+
+       return ((BASE_ADDR(reg) =3D=3D REG_RIU_BASE_ADDR) ||
+               (BASE_ADDR(reg) =3D=3D REG_MAC_HW_BASE_ADDR));
+}
+
+static inline int cl_reg_write(struct cl_hw *cl_hw, u32 reg, u32 val)
+{
+       u32 actual_reg =3D get_actual_reg(cl_hw, reg);
+       int ret =3D 0;
+
+       if (actual_reg =3D=3D (u32)(-1))
+               return -1;
+
+       if (should_send_msg(cl_hw, reg)) {
+               CL_REG_DBG(cl_hw, "calling cl_msg_tx_reg_write: reg=3D0x%x,=
 val=3D0x%x\n",
+                          actual_reg, val);
+               cl_msg_tx_reg_write(cl_hw, (XTENSA_PIF_BASE_ADDR + actual_r=
eg), val, U32_MAX);
+       } else {
+               CL_REG_DBG(cl_hw, "reg=3D0x%x, val=3D0x%x\n", actual_reg, v=
al);
+               REG_PL_WR((cl_hw->chip->pci_bar0_virt_addr + actual_reg), v=
al);
+       }
+
+       return ret;
+}
+
+static inline int cl_reg_write_mask(struct cl_hw *cl_hw, u32 reg, u32 val,=
 u32 mask)
+{
+       u32 actual_reg =3D get_actual_reg(cl_hw, reg);
+       int ret =3D 0;
+
+       if (actual_reg =3D=3D (u32)(-1))
+               return -1;
+
+       if (should_send_msg(cl_hw, reg)) {
+               CL_REG_DBG(cl_hw, "calling cl_msg_tx_reg_write: reg=3D0x%x,=
 val=3D0x%x, mask=3D0x%x\n",
+                          actual_reg, val, mask);
+               cl_msg_tx_reg_write(cl_hw, (XTENSA_PIF_BASE_ADDR + actual_r=
eg), val, mask);
+       } else {
+               u32 reg_rd =3D REG_PL_RD(cl_hw->chip->pci_bar0_virt_addr + =
actual_reg);
+               u32 val_write =3D ((reg_rd & ~mask) | (val & mask));
+
+               CL_REG_DBG(cl_hw, "reg=3D0x%x, mask=3D0x%x, val=3D0x%x\n", =
actual_reg, mask, val_write);
+               REG_PL_WR(cl_hw->chip->pci_bar0_virt_addr + actual_reg, val=
_write);
+       }
+
+       return ret;
+}
+
+static inline void cl_reg_write_chip(struct cl_chip *chip, u32 reg, u32 va=
l)
+{
+       CL_REG_DBG_CHIP(chip, "reg=3D0x%x, val=3D0x%x\n", reg, val);
+       REG_PL_WR(chip->pci_bar0_virt_addr + reg, val);
+}
+
+static inline u32 cl_reg_read_chip(struct cl_chip *chip, u32 reg)
+{
+       u32 val =3D 0;
+
+       val =3D REG_PL_RD(chip->pci_bar0_virt_addr + reg);
+
+       CL_REG_DBG_CHIP(chip, "reg=3D0x%x, val=3D0x%x\n", reg, val);
+       return val;
+}
+
+#endif /* CL_REG_ACCESS_H */
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

