Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90894532928
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiEXLi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEXLiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A28CCDC
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVJz9aE1jVdaVVnVmUxBZ/0WbYVuGS0Z2Grw61kiPhgZT2dvONMfGYusPJdKpHsbx3hMKNMO1ydDgb+CofeEQ2UKuvkOpvdmIY0MHAkmfUM4GfXI3UVZDUsIkhd0i7O3IKaawoeSaZxyq0QouSGNaakH/OBbfSoPDBtYw0vepKOik9hmmwft+YM5hkCHnwY70ck9Iwe8GcHbcmV6pJFDQ9UZT5JEwStbXc/QetIsqLTQ+jZ0ST9AxCq2qTGtn/qN2ktnOnh/Bjc0ufPXCmB5KMgry2KDAxrjBxt7V9yNqYaOtkC+QObVOdb96qylnPU6Gilmk2TsLvRiOiNQeYLlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSg25pXC+Zj926KTkdUB9cGJkUb3sgwBOqZ8Ehe/WuY=;
 b=HhM4K0MuPU9uHhA3BJ+rasd9/H72Fl1K5wDz8Ws98qIvKy+Rkav9j9rgLJM2l0F1Z9UlRaDoNMuRc1JgI9JGKv+/HWSMZKVlZ2MJZFPvTAK8UqBQvVGeRVP6FRHoraeDnQlO+7gmnxBwuvaKN3IYCYlEdtzB4JZmLGEgAe7ij6CkCt7nhicAxKzWTl1EUN8i1tra60/EqSw4QY+FwSHvGvZBD81dYzGJCOhg3R9xtDvneUgjtYAbtCit5o/20DnfVjJG0jdvw8iuDNaWRGkaZ2qVTdn3qqxvtPA1JLp846WU4+w5q1g64BTi4NiqhfCavyMoKOdLPosrxWIhwMvEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSg25pXC+Zj926KTkdUB9cGJkUb3sgwBOqZ8Ehe/WuY=;
 b=1UgpYEENKUiJw8UYQxwE8V/lJNyz+vdhH/AzxX77K007fjdmMFaCL4yLhHG8rcWHMpA7mmfTD7wn/x5ChF2c5SQQMysOcQ1q98Ka7S2PHdtoaT8vTnATejLBBrIMd8sy6hxMuNMDAsSY3ljU1Wsk2VlnnrMDDvJ5/9d383HK0f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:38:04 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:04 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 29/96] cl8k: add enhanced_tim.c
Date:   Tue, 24 May 2022 14:33:55 +0300
Message-Id: <20220524113502.1094459-30-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5e7a7e3-e1f7-4b87-adee-08da3d79ddbf
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB03057AAC86E9050541AD2073F6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebl34/+lRHhjsQFKfsIiTlCh3syyPJGtoqMY7ehdxfL1ic9yUREAJVZQ5Z8Io5kc0LPGNP0BgmeE5OppxK2ZaP6du/1FA2g//F8ajIUnqt6RVVcUM8ZUa8L2zUyH/TXTlxMLuO+g1Q3y1o7j6BEjZ2/O2rXvjNHsapbso3n/s0pWbAie90upBg7ky9avmfhzBO5oHxFV/INOwFh6zP5dbFjCwL0+YPqiIfLVwh73PMOOgkJUW96SU6Z/6IZLdANm0raoSkmIXG9cU43WrlfALidjZu01RXGysBvM+53IPbix0Mgb1cIlSlRUNsFEdSbw1xuuMAChMiMu4YBhGTfwpSw4SVmnBXAifdwOSFBAQF2FAB9qFKa6b5FQ8m02M9kj3WqvLKXOm/RZNGs2hmgOFgKSH4dTzw8HaW221OqfSQoZNwXcKAXdWjpmMViW0eoxvhWDgyZDIehAK9cQzUeMa5PV8MIkxik/FnLzjOvR8YX8DOdrK3Navs/SqO3T6B8OYO7QEEqsnDJHjUO+hO9jy2EHOqEk8FDZgtXSV/FgZMBt0bbYPVzIIsF4ZJaQNPxaGKSSjXt44/s5q6BxaJaH1Jbz/mUsarfMyEUSMosIi5WLTsPF7Hue5ue891sLgP0Ua5+Hs0LTjnoaPU7iEKM+0CraWrSUWVAMNS4DIbv6ZFEr/fDuVAb8px2KnC9bmyGiIP4nPf8/jQMQBXxcifpL1RL3GfHh/+nSNuKQdzJj/1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vNKHSGGNoLLT/PYzbVWwplTr8nPxzVJIE6ekJXNXvZxrwSgktp41OVg9Y3N+?=
 =?us-ascii?Q?t1nVPOaYagh2G80ANaeUYhI6pdg4ZeiG672h4hTG69UO6gq4XnsETt/xbF8B?=
 =?us-ascii?Q?qtgweTNAVZ7kSXgX729UWM2Ys6NzDxqVIzhH7nYoRVGfpDKHjWRnJYq9tpm8?=
 =?us-ascii?Q?X/6BPvSuE95Rx6M8QnK2sHu9IkWXZ5/kSK5+N/Uv4yszVP5qQNJKw7xt39Hp?=
 =?us-ascii?Q?myrA7CAQsfsVMRnJua2JCZZQV9SViIu9X5fTk18o4PMiZP6AEosZGrQYFK6y?=
 =?us-ascii?Q?M16xSSTgsPglT0+WgF+5eTjLEbO1VtpraXhXUJ0juS9GhJvX1MQdh45mEvfG?=
 =?us-ascii?Q?buyY5uToL1QFT1F7lHrz7jK4LdwEklhKtWZqp7C/lO76XiLSC1KA8b5zT2EP?=
 =?us-ascii?Q?vCe+46HOHdehEFU9FgjOQN1AZRvcm88vSLJW6fm3WYfKJXj14547qCsoHYT2?=
 =?us-ascii?Q?xWXp8aMuS+L4GOEtioNCrPyAGt5v9oBC6bnLYgGk6GtHrrZQrx+2w8DzuXdE?=
 =?us-ascii?Q?Byk9J/YNPduN/9cUHmRTXikQdV/V4aCo4v8HHb+1SnMvrHJ2kmfrfA7zbl3t?=
 =?us-ascii?Q?F2UyDxedKzeds8YiH5J+Qu/ClQAbilfaN/eu+i2jJGqNGrB5NejTuoGoUUOH?=
 =?us-ascii?Q?dCePrNVG/3hGtoNrHJ6tHnVxipG5BpwVZ6U91kG3tFQWzjgjR0e/6glPYJeq?=
 =?us-ascii?Q?HNaJHWCwWqlKxm9j9Bz5P+wGhB0tpFgFfBj2f4xM3QSBj99YSgH5/sYeQiph?=
 =?us-ascii?Q?P35MUKFREwwblu4aIfa+Gnth0xLkszvni85D6KFcWkUD1ufQvq9zh5ojk+4F?=
 =?us-ascii?Q?8rsWStcRPdE2hCcu7eSWwbs+a7lpcs2xdOhMeBRi/KSUE7R6Z5ItefkzX0Aj?=
 =?us-ascii?Q?0CUg2U4AgByvWGCfDnsmrlXXfQMuMMWx7h79Gc58DYEf1PZUCv8UKD+Z6K9D?=
 =?us-ascii?Q?aNusIP1m+ssv14f1TpI3n48Kv60fo8ZLw6zdP814VqH3cH0wthJC99EPYU29?=
 =?us-ascii?Q?gG98zuLmR9VSSWbRnaxoATqMbqHsOUJv/iqGxokz+35hlO40ftFBtWRJjDM7?=
 =?us-ascii?Q?EKoLne/D22MOQBX7HZphkIgd2nl8GyFZLOwHaH20W9DKget+iGKcBUJV9gN7?=
 =?us-ascii?Q?p/v7yelStoX/eTTD93acQQc6b+MQzIGe747Tbw+x2FCFr9l34SS2zOhypWZD?=
 =?us-ascii?Q?QHQnLEtaOoBF+ydgM35rIBMbgwHmSKj9fxUDcf6ouuWbhbekQTW7wcRkrKhI?=
 =?us-ascii?Q?TSc5U4HgsAsPELdMztcT3WFzDWFFXQFViLJoy6RNcI14tJI4thfucdosdqqs?=
 =?us-ascii?Q?LlXw6xgEFAF5ozeOKwuBewS0sTxcHyAs6wU7xbuvHwn2XiduqkqSrtfOf9ZI?=
 =?us-ascii?Q?DTRFvQn5gkxLhFSqzYri4izZQn0d/Q1tU1XVZm8YRKeTMW7kZxG8sDkaCNsx?=
 =?us-ascii?Q?/ht4Ri5kclet7qkyTZ+KAwXdw+B3yuIFQAPfGBdJAd71t1MGjcnplHrVmR7p?=
 =?us-ascii?Q?qrWtDmBNzqFnWlMP9PrLk93XzR5Fv15D1RnEDVe4GzUJTvhsddqd2D3arIFQ?=
 =?us-ascii?Q?jAFVOuTgVlh4OTyfd7pJrLhOhN1yLQtCOz3io8+ploMYuEZiU5u0ZD5l6oms?=
 =?us-ascii?Q?OUGS63TPaRU1zkx/40HlNuI/jImJbxSQ5lNLrnjKJTxQUvHCkjo6ZCzzRdFQ?=
 =?us-ascii?Q?vDR3lUNi3oqaSEXSUQcxpucURE2nEis56rRySqhG2SdQ7KdvBXX78YMYM84p?=
 =?us-ascii?Q?SGHWw+lTphOLmRr1L2MbUPIIzKmAGjA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7a7e3-e1f7-4b87-adee-08da3d79ddbf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:04.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owlFOmJVNj+fsg1rGOPESv31Nw58w8rr05318KjV+aJRoqfO7Ne9f8EtemdLcwDpONXFsl2eWIrgiB/urjWTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/enhanced_tim.c   | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.c

diff --git a/drivers/net/wireless/celeno/cl8k/enhanced_tim.c b/drivers/net/wireless/celeno/cl8k/enhanced_tim.c
new file mode 100644
index 000000000000..893bddb2b25b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/enhanced_tim.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "def.h"
+#include "hw.h"
+#include "sta.h"
+#include "enhanced_tim.h"
+
+/*
+ * The kernel's test_and_set_bit() gets unsigned long * as an argument, but we actually
+ * pass a pointer to u32, what cause to alignment fault in 64bit platforms.
+ * This function gets a pointer to u32 to prevent this alignment fault.
+ * Notice that the kernel's function sets the bit as an atomic operation,
+ * and our function doesn't. Vut it's not an issue since we set the bit from one context only.
+ */
+static int cl_test_and_set_bit(unsigned long nr, u32 *addr)
+{
+	u32 *new_addr, mask, old;
+
+	new_addr = ((u32 *)addr) + (nr >> 5);
+	mask = 1 << (nr & 31);
+	old = *new_addr & mask;
+	*new_addr |= mask;
+
+	return (old != 0);
+}
+
+static int cfm_test_and_clear_bit(unsigned long nr, u32 *addr)
+{
+	u32 *new_addr, mask, old;
+
+	new_addr = ((u32 *)addr) + (nr >> 5);
+	mask = 1 << (nr & 31);
+	old = *new_addr & mask;
+	*new_addr &= ~mask;
+
+	return (old != 0);
+}
+
+void cl_enhanced_tim_reset(struct cl_hw *cl_hw)
+{
+	/*
+	 * There is no need to reset cl_hw->ipc_env->shared->enhanced_tim.
+	 * It is done as part of ipc_shared_env_init()
+	 */
+	memset(&cl_hw->ipc_env->enhanced_tim, 0, sizeof(struct cl_ipc_enhanced_tim));
+}
+
+/*
+ * NOTE: the UMAC DRAM starts with the enhanced TIM elements stractures.
+ * This is hard coded in the FW, this memory allocation should be changed in
+ * the driver module .ELF file.
+ */
+
+void cl_enhanced_tim_clear_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx,
+				  u8 ac, struct cl_sta *cl_sta, u8 tid)
+{
+	/* Pointer to HOST enhanced TIM */
+	u32 *source = cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+	u32 ipc_queue_idx_common = IPC_TX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(ipc_queue_idx);
+	/*
+	 * Does the UMAC enhanced TIM need update?
+	 * If the TIM element is set then clear it and update the UMAC TIM element
+	 */
+	if (cfm_test_and_clear_bit(ipc_queue_idx_common, source)) {
+		/* Pointer to UMAC enhanced TIM */
+		u32 __iomem *target =
+			(u32 __iomem *)cl_hw->ipc_env->shared->enhanced_tim.tx_rx_agg[ac];
+		/* Offset to UMAC encahned TIM array position */
+		u32 agg_offset = ipc_queue_idx_common / (BITS_PER_BYTE * sizeof(u32));
+
+		/* Update tim element */
+		if (cl_sta) {
+			struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+			if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+				ieee80211_sta_set_buffered(cl_sta->sta, tid, false);
+		}
+
+		iowrite32(source[agg_offset], (void __iomem *)&target[agg_offset]);
+	}
+}
+
+void cl_enhanced_tim_clear_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				     bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid)
+{
+	/* Pointer to HOST enhanced TIM */
+	u32 *source = cl_hw->ipc_env->enhanced_tim.tx_single[ac];
+	/* Staton index: 0 - 128 (do not use cl_sta->sta_idx which is 0 -127) */
+	u32 sta_idx = ipc_queue_idx % FW_MAX_NUM_STA;
+
+	/*
+	 * Does the UMAC enhanced TIM need update?
+	 * If the TIM element is set then clear it and update the UMAC TIM element
+	 */
+	if (cfm_test_and_clear_bit(sta_idx, source)) {
+		/* Pointer to UMAC enhanced TIM for singles or aggregation */
+		u32 __iomem *target =
+			(u32 __iomem *)cl_hw->ipc_env->shared->enhanced_tim.tx_single[ac];
+		/* Offset to UMAC encahned TIM array position */
+		u32 sta_offset = sta_idx / (BITS_PER_BYTE * sizeof(u32));
+
+		/* Update tim element */
+		if (!no_ps_buffer && cl_sta) {
+			struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+			if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+				ieee80211_sta_set_buffered(cl_sta->sta, tid, false);
+		}
+
+		iowrite32(source[sta_offset], (void __iomem *)&target[sta_offset]);
+	}
+}
+
+void cl_enhanced_tim_set_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid)
+{
+	/* Pointer to HOST enhanced TIM */
+	u32 *source = cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+	u32 ipc_queue_idx_common = IPC_TX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(ipc_queue_idx);
+	/*
+	 * Does the UMAC enhanced TIM need update?
+	 * If the TIM element is cleared then set it and update the UMAC TIM element
+	 */
+	if (!cl_test_and_set_bit(ipc_queue_idx_common, source)) {
+		/* Pointer to UMAC enhanced TIM */
+		u32 __iomem *target =
+			(u32 __iomem *)cl_hw->ipc_env->shared->enhanced_tim.tx_rx_agg[ac];
+		/* Offset to UMAC encahned TIM array position */
+		u32 agg_offset = ipc_queue_idx_common / (BITS_PER_BYTE * sizeof(u32));
+
+		/* Update tim element */
+		if (!no_ps_buffer && cl_sta) {
+			struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+			if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+				ieee80211_sta_set_buffered(cl_sta->sta, tid, true);
+		}
+
+		iowrite32(source[agg_offset], (void __iomem *)&target[agg_offset]);
+	}
+}
+
+void cl_enhanced_tim_set_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				   bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid)
+{
+	/* Pointer to HOST enhanced TIM */
+	u32 *source = cl_hw->ipc_env->enhanced_tim.tx_single[ac];
+	/* Staton index: 0 - 128 (do not use cl_sta->sta_idx which is 0 -127) */
+	u32 sta_idx = ipc_queue_idx % FW_MAX_NUM_STA;
+
+	/*
+	 * Does the UMAC enhanced TIM need update?
+	 * If the TIM element is cleared then set it and update the UMAC TIM element
+	 */
+	if (!cl_test_and_set_bit(sta_idx, source)) {
+		/* Pointer to UMAC enhanced TIM */
+		u32 __iomem *target =
+			(u32 __iomem *)cl_hw->ipc_env->shared->enhanced_tim.tx_single[ac];
+		/* Offset to UMAC encahned TIM array position */
+		u32 sta_offset = sta_idx / (BITS_PER_BYTE * sizeof(u32));
+
+		/* Update tim element */
+		if (!no_ps_buffer && cl_sta) {
+			struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+			if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+				ieee80211_sta_set_buffered(cl_sta->sta, tid, true);
+		}
+
+		iowrite32(source[sta_offset], (void __iomem *)&target[sta_offset]);
+	}
+}
-- 
2.36.1

