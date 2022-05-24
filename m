Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15A153295D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiEXLj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiEXLjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E592D01
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7qmBNmVmwiqbfmqOZsHc+q/SG5L0AtqXvQVx22ya6Z18iQHF5V564ExiuHxrL6YF/8sbdJvJcne8bnplraZk2kNDZpT38U/oHEq74OXv+h6cqrJ3+yo8Vr0zcM6H/kqzB1N3E8hA26AKzHlS+/spqd5szNTe60dqrXsL7CeZM6123Md+KwLuAYucggrphpgrwXdOu3n2kJNoAIUAopnLep5HvcHfJKDJ9pZFr/xBbNYs9VwGbR5CS+DRk1TQQHkT/sFHOzHd+UdgTyiXUNab004lMva1ywpdzxOs/YhY93vbtGFgCX6RB717tITynDfrYC457EUAZXSvQt8S/Vtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZPsCcruYG+xAKUQN6WMYvyDcG+9g1RmeHUitee3gb8=;
 b=n9u2ZhGuE0cZrSG7NI2jtUeE4PX0C60vjTkp3fwxal3s6+r2TtSW+1t5ZYYVYXdy/sEAZFcriw5P5rhOoexF2O+mclFOEPj40hTZW1EvlW0HipYhw4pibsakqUi7f3BX6ovLZqsO9P6sRkzOJxNjZc80k4Jv5PiKEZCacA7bSEjhMpHWXv3k17reCuUK+tW366ahplGAzhEV/kGUJ4CZv4GW0FarvkFnjkxjvpFtiuxb/mFT6h+dk4iQTVViOKsP6QR67Be9+0KhC3bDdpFgIAOJff6YZe1Zuda5O/jXue1c+nDdT/9+r+jYh7SBvcNKsOkihhaikHCrVRhgvFL16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZPsCcruYG+xAKUQN6WMYvyDcG+9g1RmeHUitee3gb8=;
 b=YlZkoynsCC2l3uC27RlFZeovrhyVj6HwR/Wzb6OiIKaECBQi0biiZj+MpNh50dwCyVN5cUJdDwvFRSl8fxLtTMK4JgpgaowmbA/msY/pnaUeQKESpAZSNTYpglQnsPAPFpa6s15/vrI1RNQ8ibW0Bl4Sdp13CthD59tQMcU5R6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:43 +0000
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
Subject: [RFC v2 42/96] cl8k: add main.c
Date:   Tue, 24 May 2022 14:34:08 +0300
Message-Id: <20220524113502.1094459-43-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9763b2e-2eac-47fc-4e23-08da3d79e6fa
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384619471D0CB2798846C97F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23pZcr0HmpL1WXaVh3238s5Y1bl2nAN2OZR3FX7BF7POnxjNUjMzZDGhzY7RnceGS3Xgz6YwpaK9kN6z568lOtTkuwJXsocSSS5Itr0/asiUvaHpqPoE7oSercIvak5diA2ujNAtx6ZkCJ+jVHw4nvHUsAp2Jp0ipouVLkIPLe40oMZGLCszO8xsY00w9f21tg6FhJP6gHT5ZaqH/z6uBcSxpFEnTw2slhfsyzeWsLfe5SE3JpMq57bSrs5F0VeqZSwn7wwVOm98FCs3vfuk18xs0rkjnhTEQu/OwQX0Zgi5bmURoG8yY2pxVYXo1/fYg8OQzGcq+pZRzrcjAX3EDQTLGP7Ln5nRg0OFmCrA90dPLoNuLFUpvOc7hsp/1z7MuJB3ahHEfgAG0pAQwxnPY40Oox2J5wMoSA6RiyyboaRWHhW9lKkOnXDofrVohotzFXUZwy8RwaDN6p/uJfElmWDPHr15PiK0G5gCQ13RPXVATJeFUNyhIn7fm+Kj7zRUDbjI6jP/h3XVh15mbWzNucqbUMjUfvPjlDE/ajb6eFPQ4YOKK0KwWwcslhFnC9fc89DncpSMZMLl3Y816Bzk9PlDOC4RpqetgsttlTAX8O26vivHZQheIsJSB7Qa3Iy0pU8g6Hp1sm5rVahd0dzk+6SEU2hIXNciNMKWprojMlodQPB3vLXABuJbQ0MzwC4/YqNE66RKOnVU8yqBwBVAtLqIdj70GnOeKG7yIcrD5n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWxOvb9jUKBknoWDm9KT0FSeNV7rto1Ku3se8+2IjZLoN5IRIcx2QtCwGnIS?=
 =?us-ascii?Q?+5nvvIIZI7e2DLfEkGzgyq7g4S6PRaBGyE0P4SpK2BtnkKuQAt+LOPXpogxj?=
 =?us-ascii?Q?++9ZsrZqICg1tTrfO5giY0JBixheUl55w+kHCdzcMq9YLY9JpvHq8lAznTc0?=
 =?us-ascii?Q?P/H8HDs+q9tHeEy2TRpQDQIp+WA0wri1ulBdIaJ8wUgJ9391aURGsVfibLp5?=
 =?us-ascii?Q?E0nd4dCi7ilVMqIZBMUXrWPG8y8qgbVEyCWwBwencda3+SAHVHZXGHLLEp19?=
 =?us-ascii?Q?cKK/kmGuxlVawriC4UoH4BuTE+fwOmggGqDZGkOT9hPxrr3xAqQdUkbzQWcy?=
 =?us-ascii?Q?rh9LirErmyiAuZF2l5UT3v5bPyGAMT61yHiBRViIY5OiXhSORgsG5yNfPahg?=
 =?us-ascii?Q?ml3/M2nk8eohnboNH9jy8aNDoijSilHkgXAA1CRMxRaQ/jrsQl1xahOBLZtC?=
 =?us-ascii?Q?SeMI72RVJ1vypK8p0v8bqfaqHcd6qZlb8C1fY4DVNVTHmypVkWD/6mqhG9e0?=
 =?us-ascii?Q?xqL95WvSd6XKsY8UODp9hpfWJ5ZPnTbbdIZAnjxHv1sluUy+7baAmzx8DHhU?=
 =?us-ascii?Q?LwptWlC1EMmxFGjiiytFz21algupBvjnmJzxc6mKBnIVeGBq4+cxOl3jZYSK?=
 =?us-ascii?Q?R/XKscbfoGiLMsfAYddfheo/9SFj3mBCr9uuCwd/Nw+aQD3X/zXZdyaXwUyp?=
 =?us-ascii?Q?DFDT2Z6NjzvUsat3rAD8DLm+EhSf0V+O8B4BG+0yEs/aYPkmLNwpEhvlDdGo?=
 =?us-ascii?Q?OBjlTdB76DFzWCMpMJnJ2ZRPnat5aBFEZlMWwFu0Def1ZAGUX0xKMbYai259?=
 =?us-ascii?Q?0PWTDRMVCczegPsjc3ArY1JENHOpb0fHrsDSuZyz5nzx4PxJplH5WCPh56H7?=
 =?us-ascii?Q?WeVgLxHhVcPuig0rn8dKTtl33ZwVnSDp7nyewEh2BVccERV+YUjLsio4LRoV?=
 =?us-ascii?Q?lFn+ZOAkJTDrA86Cv/TFVQesRTkFj0eKu7gn5boqu22x6P8UqpHYoDb0e2Fx?=
 =?us-ascii?Q?71f79Up8g1jXEltGVcY+obYdEMn6XqbX+2a8TzzLpCwqwWiXOH/mjO04K6vN?=
 =?us-ascii?Q?fsOG13Ny16UYxPlr/vWip8ON9nFudXYrdjawz1JkPNUBiQ+iXzZKOxYMUDpR?=
 =?us-ascii?Q?MuiaWJuXMcARsOGFzjLNHBOV9lXbSX/Urzln2H8NW7IixHTHcWFzJNGtPQZt?=
 =?us-ascii?Q?0V5D0TCtAU0XC32QTBd/J151o6NmFYEYrpIhLzsM+A6BNFdO9n7EoANzVlLX?=
 =?us-ascii?Q?faAkyDAb52TWw+DkK4sbMPvLP1ej6hcyUZfVonufd6V108kxM1p/aHUEqQiJ?=
 =?us-ascii?Q?nJI/d9nzEWIdF3lZ4I9DGXldWrdM1dH8Ah4h7Z2QqAl5AQJ5WAipel04y9LL?=
 =?us-ascii?Q?jzR9o2FEMhAGGx2HxbTqu3zIFRpHCOWInMKW+jHLXwsret1DM8iBWFJO5Gyo?=
 =?us-ascii?Q?SbT3ih958vT3RdYEJssZrjlnDsthTf9gDTXv8JMjHl3Nk7MsThZnMTe2ui65?=
 =?us-ascii?Q?tmcXo8BT6d4U6SYYlLQJ9HlmN+CPbX/8C1Ym6K/MMDvyL9KyNQ2yfley7WIw?=
 =?us-ascii?Q?y/ErMprmKbijpFQIUumIYPlvGpUbs+yT+KcntQXsXaHrRp1W1IMtbXhDwoB8?=
 =?us-ascii?Q?u4WNbM1zPWD4upQQSWVpH7y8rZV6iYbtvMEgUGqJD+NGUaW7hyeap7PCfhJQ?=
 =?us-ascii?Q?pZGIb6ZL8g1IQh/kFDEMBZQV/bl2EHz9w0gaJ1vCvq4dARC7EZFyNUyYKHis?=
 =?us-ascii?Q?Xtwa9yTPoSIzgvMBm9XJaFkW6xwH33E=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9763b2e-2eac-47fc-4e23-08da3d79e6fa
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:20.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBagqrBLBL0Db/Z5IfN0CqQABpsknEITZ0iarbH2fpbRBYF1AuANbCSmJooCdAbKN6cUwPBPCYQ1+9dth7SEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/main.c | 603 ++++++++++++++++++++++++
 1 file changed, 603 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.c

diff --git a/drivers/net/wireless/celeno/cl8k/main.c b/drivers/net/wireless/celeno/cl8k/main.c
new file mode 100644
index 000000000000..08abb16987ef
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/main.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "tx.h"
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "stats.h"
+#include "maintenance.h"
+#include "vns.h"
+#include "traffic.h"
+#include "sounding.h"
+#include "recovery.h"
+#include "rates.h"
+#include "utils.h"
+#include "phy.h"
+#include "radio.h"
+#include "dsp.h"
+#include "dfs.h"
+#include "tcv.h"
+#include "mac_addr.h"
+#include "bf.h"
+#include "rfic.h"
+#include "e2p.h"
+#include "chip.h"
+#include "regdom.h"
+#include "platform.h"
+#include "mac80211.h"
+#include "main.h"
+
+MODULE_DESCRIPTION("Celeno 11ax driver for Linux");
+MODULE_VERSION(CONFIG_CL8K_VERSION);
+MODULE_AUTHOR("Copyright(c) 2022 Celeno Communications Ltd");
+MODULE_LICENSE("Dual BSD/GPL");
+
+static struct ieee80211_ops cl_ops = {
+	.tx                     = cl_ops_tx,
+	.start                  = cl_ops_start,
+	.stop                   = cl_ops_stop,
+	.add_interface          = cl_ops_add_interface,
+	.remove_interface       = cl_ops_remove_interface,
+	.config                 = cl_ops_config,
+	.bss_info_changed       = cl_ops_bss_info_changed,
+	.start_ap               = cl_ops_start_ap,
+	.stop_ap                = cl_ops_stop_ap,
+	.prepare_multicast      = cl_ops_prepare_multicast,
+	.configure_filter       = cl_ops_configure_filter,
+	.set_key                = cl_ops_set_key,
+	.sw_scan_start          = cl_ops_sw_scan_start,
+	.sw_scan_complete       = cl_ops_sw_scan_complete,
+	.sta_state              = cl_ops_sta_state,
+	.sta_notify             = cl_ops_sta_notify,
+	.conf_tx                = cl_ops_conf_tx,
+	.sta_rc_update          = cl_ops_sta_rc_update,
+	.ampdu_action           = cl_ops_ampdu_action,
+	.post_channel_switch    = cl_ops_post_channel_switch,
+	.flush                  = cl_ops_flush,
+	.tx_frames_pending      = cl_ops_tx_frames_pending,
+	.reconfig_complete      = cl_ops_reconfig_complete,
+	.get_txpower            = cl_ops_get_txpower,
+	.set_rts_threshold      = cl_ops_set_rts_threshold,
+	.event_callback         = cl_ops_event_callback,
+	.set_tim                = cl_ops_set_tim,
+	.get_antenna            = cl_ops_get_antenna,
+	.get_expected_throughput = cl_ops_get_expected_throughput,
+	.sta_statistics         = cl_ops_sta_statistics,
+	.get_survey             = cl_ops_get_survey,
+	.hw_scan                = cl_ops_hw_scan,
+	.cancel_hw_scan         = cl_ops_cancel_hw_scan
+};
+
+static void cl_drv_workqueue_create(struct cl_hw *cl_hw)
+{
+	if (!cl_hw->drv_workqueue)
+		cl_hw->drv_workqueue = create_singlethread_workqueue("drv_workqueue");
+}
+
+static void cl_drv_workqueue_destroy(struct cl_hw *cl_hw)
+{
+	if (cl_hw->drv_workqueue) {
+		destroy_workqueue(cl_hw->drv_workqueue);
+		cl_hw->drv_workqueue = NULL;
+	}
+}
+
+static int cl_main_alloc(struct cl_hw *cl_hw)
+{
+	int ret = 0;
+
+	ret = cl_phy_data_alloc(cl_hw);
+	if (ret)
+		return ret;
+
+	ret = cl_calib_common_tables_alloc(cl_hw);
+	if (ret)
+		return ret;
+
+	ret = cl_power_table_alloc(cl_hw);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static void cl_main_free(struct cl_hw *cl_hw)
+{
+	cl_phy_data_free(cl_hw);
+	cl_calib_common_tables_free(cl_hw);
+	cl_power_table_free(cl_hw);
+}
+
+static void cl_free_hw(struct cl_hw *cl_hw)
+{
+	if (!cl_hw)
+		return;
+
+	cl_temperature_wait_for_measurement(cl_hw->chip, cl_hw->tcv_idx);
+
+	cl_tcv_config_free(cl_hw);
+
+	if (cl_hw->hw->wiphy->registered)
+		ieee80211_unregister_hw(cl_hw->hw);
+
+	cl_chip_unset_hw(cl_hw->chip, cl_hw);
+	ieee80211_free_hw(cl_hw->hw);
+}
+
+static void cl_free_chip(struct cl_chip *chip)
+{
+	cl_free_hw(chip->cl_hw_tcv0);
+	cl_free_hw(chip->cl_hw_tcv1);
+}
+
+static int cl_prepare_hw(struct cl_chip *chip, u8 tcv_idx,
+			 const struct cl_driver_ops *drv_ops)
+{
+	struct cl_hw *cl_hw = NULL;
+	struct ieee80211_hw *hw;
+	int ret = 0;
+
+	hw = ieee80211_alloc_hw(sizeof(struct cl_hw), &cl_ops);
+	if (!hw) {
+		cl_dbg_chip_err(chip, "ieee80211_alloc_hw failed\n");
+		return -ENOMEM;
+	}
+
+	cl_hw_init(chip, hw->priv, tcv_idx);
+
+	cl_hw = hw->priv;
+	cl_hw->hw = hw;
+	cl_hw->tcv_idx = tcv_idx;
+	cl_hw->sx_idx = chip->conf->ci_tcv1_chains_sx0 ? 0 : tcv_idx;
+	cl_hw->chip = chip;
+
+	/*
+	 * chip0, tcv0 --> 0
+	 * chip0, tcv1 --> 1
+	 * chip1, tcv0 --> 2
+	 * chip1, tcv1 --> 3
+	 */
+	cl_hw->idx = chip->idx * CHIP_MAX + tcv_idx;
+
+	cl_hw->drv_ops = drv_ops;
+
+	SET_IEEE80211_DEV(hw, chip->dev);
+
+	ret = cl_tcv_config_alloc(cl_hw);
+	if (ret)
+		goto out_free_hw;
+
+	ret = cl_tcv_config_read(cl_hw);
+	if (ret)
+		goto out_free_hw;
+
+	cl_chip_set_hw(chip, cl_hw);
+
+	ret = cl_mac_addr_set(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "cl_mac_addr_set failed\n");
+		goto out_free_hw;
+	}
+
+	if (cl_band_is_6g(cl_hw))
+		cl_hw->nl_band = NL80211_BAND_6GHZ;
+	else if (cl_band_is_5g(cl_hw))
+		cl_hw->nl_band = NL80211_BAND_5GHZ;
+	else
+		cl_hw->nl_band = NL80211_BAND_2GHZ;
+
+	if (cl_band_is_24g(cl_hw))
+		cl_hw->hw_mode = HW_MODE_BG;
+	else
+		cl_hw->hw_mode = HW_MODE_A;
+
+	cl_hw->wireless_mode = WIRELESS_MODE_HT_VHT_HE;
+
+	cl_cap_dyn_params(cl_hw);
+
+	cl_dbg_verbose(cl_hw, "cl_hw created\n");
+
+	return 0;
+
+out_free_hw:
+	cl_free_hw(cl_hw);
+
+	return ret;
+}
+
+void cl_main_off(struct cl_hw *cl_hw)
+{
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
+	cl_ipc_stop(cl_hw);
+
+	if (!test_bit(CL_DEV_INIT, &cl_hw->drv_flags)) {
+		cl_tx_off(cl_hw);
+		cl_rx_off(cl_hw);
+		cl_msg_rx_flush_all(cl_hw);
+	}
+
+	cl_fw_file_cleanup(cl_hw);
+}
+
+static void _cl_main_deinit(struct cl_hw *cl_hw)
+{
+	if (!cl_hw)
+		return;
+
+	ieee80211_unregister_hw(cl_hw->hw);
+
+	/* Send reset message to firmware */
+	cl_msg_tx_reset(cl_hw);
+
+	cl_hw->is_stop_context = true;
+
+	cl_drv_workqueue_destroy(cl_hw);
+
+	cl_scanner_deinit(cl_hw);
+
+	cl_noise_close(cl_hw);
+	cl_maintenance_close(cl_hw);
+	cl_vns_close(cl_hw);
+	cl_rssi_assoc_exit(cl_hw);
+	cl_radar_close(cl_hw);
+	cl_sounding_close(cl_hw);
+	cl_chan_info_deinit(cl_hw);
+	cl_wrs_api_close(cl_hw);
+	cl_main_off(cl_hw);
+	/* These 2 must be called after cl_tx_off() (which is called from cl_main_off) */
+	cl_tx_amsdu_txhdr_deinit(cl_hw);
+	cl_sw_txhdr_deinit(cl_hw);
+	cl_fw_dbg_trigger_based_deinit(cl_hw);
+	cl_stats_deinit(cl_hw);
+	cl_main_free(cl_hw);
+	cl_fw_file_release(cl_hw);
+
+	cl_ipc_deinit(cl_hw);
+	cl_hw_deinit(cl_hw, cl_hw->tcv_idx);
+	vfree(cl_hw->tx_queues);
+}
+
+void cl_main_deinit(struct cl_chip *chip)
+{
+	struct cl_chip_conf *conf = chip->conf;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+
+	if (cl_chip_is_tcv1_enabled(chip) && cl_hw_tcv1)
+		_cl_main_deinit(cl_hw_tcv1);
+
+	if (cl_chip_is_tcv0_enabled(chip) && cl_hw_tcv0)
+		_cl_main_deinit(cl_hw_tcv0);
+
+	if (conf->ci_phy_dev != PHY_DEV_DUMMY) {
+		if (!conf->ci_phy_load_bootdrv)
+			cl_phy_off(cl_hw_tcv1);
+
+		cl_phy_off(cl_hw_tcv0);
+	}
+
+	cl_platform_dealloc(chip);
+
+	cl_free_chip(chip);
+}
+
+static struct cl_controller_reg all_controller_reg = {
+	.breset = XMAC_BRESET,
+	.debug_enable = XMAC_DEBUG_ENABLE,
+	.dreset = XMAC_DRESET,
+	.ocd_halt_on_reset = XMAC_OCD_HALT_ON_RESET,
+	.run_stall = XMAC_RUN_STALL
+};
+
+void cl_main_reset(struct cl_chip *chip, struct cl_controller_reg *controller_reg)
+{
+	/* Release TRST & BReset to enable JTAG connection to FPGA A */
+	u32 regval;
+
+	/* 1. return to reset value */
+	regval = macsys_gcu_xt_control_get(chip);
+	regval |= controller_reg->ocd_halt_on_reset;
+	regval &= ~(controller_reg->dreset | controller_reg->run_stall | controller_reg->breset);
+	macsys_gcu_xt_control_set(chip, regval);
+
+	regval = macsys_gcu_xt_control_get(chip);
+	regval |= controller_reg->dreset;
+	macsys_gcu_xt_control_set(chip, regval);
+
+	/* 2. stall xtensa & release ocd */
+	regval = macsys_gcu_xt_control_get(chip);
+	regval |= controller_reg->run_stall;
+	regval &= ~controller_reg->ocd_halt_on_reset;
+	macsys_gcu_xt_control_set(chip, regval);
+
+	/* 3. breset release & debug enable */
+	regval = macsys_gcu_xt_control_get(chip);
+	regval |= (controller_reg->debug_enable | controller_reg->breset);
+	macsys_gcu_xt_control_set(chip, regval);
+
+	msleep(100);
+}
+
+int cl_main_on(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	int ret;
+	u32 regval;
+
+	cl_hw->fw_active = false;
+
+	cl_txq_init(cl_hw);
+
+	cl_hw_assert_info_init(cl_hw);
+
+	if (cl_recovery_in_progress(cl_hw))
+		cl_main_reset(chip, &cl_hw->controller_reg);
+
+	ret = cl_fw_file_load(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "cl_fw_file_load failed %d\n", ret);
+		return ret;
+	}
+
+	/* Clear CL_DEV_FW_ERROR after firmware loaded */
+	clear_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags);
+
+	if (cl_recovery_in_progress(cl_hw))
+		cl_ipc_recovery(cl_hw);
+
+	regval = macsys_gcu_xt_control_get(chip);
+
+	/* Set fw to run */
+	if (cl_hw->fw_active)
+		regval &= ~cl_hw->controller_reg.run_stall;
+
+	/* Set umac to run */
+	if (chip->umac_active)
+		regval &= ~UMAC_RUN_STALL;
+
+	/* Ack all possibly pending IRQs */
+	ipc_xmac_2_host_ack_set(chip, cl_hw->ipc_e2a_irq.all);
+	macsys_gcu_xt_control_set(chip, regval);
+	cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.all);
+	/*
+	 * cl_irq_status_sync will set CL_DEV_FW_SYNC when fw raises IPC_IRQ_E2A_SYNC
+	 * (indicate its ready to accept interrupts)
+	 */
+	ret = wait_event_interruptible_timeout(cl_hw->fw_sync_wq,
+					       test_and_clear_bit(CL_DEV_FW_SYNC,
+								  &cl_hw->drv_flags),
+					       msecs_to_jiffies(5000));
+
+	if (ret == 0) {
+		pr_err("[%s]: FW synchronization timeout.\n", __func__);
+		cl_hw_assert_check(cl_hw);
+		ret = -ETIMEDOUT;
+		goto out_free_cached_fw;
+	} else if (ret == -ERESTARTSYS) {
+		goto out_free_cached_fw;
+	}
+
+	return 0;
+
+out_free_cached_fw:
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
+	cl_fw_file_release(cl_hw);
+	return ret;
+}
+
+static int __cl_main_init(struct cl_hw *cl_hw)
+{
+	int ret;
+
+	if (!cl_hw)
+		return 0;
+
+	if (cl_regd_init(cl_hw, cl_hw->hw->wiphy))
+		cl_dbg_err(cl_hw, "regulatory failed\n");
+
+	/*
+	 * ieee80211_register_hw() will take care of calling wiphy_register() and
+	 * also ieee80211_if_add() (because IFTYPE_STATION is supported)
+	 * which will internally call register_netdev()
+	 */
+	ret = ieee80211_register_hw(cl_hw->hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "ieee80211_register_hw failed\n");
+		cl_main_deinit(cl_hw->chip);
+
+		return ret;
+	}
+
+	return ret;
+}
+
+static int _cl_main_init(struct cl_hw *cl_hw)
+{
+	int ret = 0;
+
+	if (!cl_hw)
+		return 0;
+
+	set_bit(CL_DEV_INIT, &cl_hw->drv_flags);
+
+	/* By default, set FEM mode to opertional mode. */
+	cl_hw->fem_mode = FEM_MODE_OPERETIONAL;
+
+	cl_vif_init(cl_hw);
+
+	cl_drv_workqueue_create(cl_hw);
+
+	init_waitqueue_head(&cl_hw->wait_queue);
+	init_waitqueue_head(&cl_hw->fw_sync_wq);
+	init_waitqueue_head(&cl_hw->radio_wait_queue);
+
+	mutex_init(&cl_hw->dbginfo.mutex);
+	mutex_init(&cl_hw->msg_tx_mutex);
+	mutex_init(&cl_hw->set_channel_mutex);
+
+	spin_lock_init(&cl_hw->tx_lock_agg);
+	spin_lock_init(&cl_hw->tx_lock_cfm_agg);
+	spin_lock_init(&cl_hw->tx_lock_single);
+	spin_lock_init(&cl_hw->tx_lock_bcmc);
+	spin_lock_init(&cl_hw->channel_info_lock);
+
+	ret = cl_ipc_init(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "cl_ipc_init failed %d\n", ret);
+		return ret;
+	}
+
+	cl_chip_set_rfic_version(cl_hw);
+
+	/* Validate calib params should be called after setting the rfic version */
+	cl_tcv_config_validate_calib_params(cl_hw);
+
+	cl_hw->tx_queues = vzalloc(sizeof(*cl_hw->tx_queues));
+	if (!cl_hw->tx_queues) {
+		cl_ipc_deinit(cl_hw);
+		return -ENOMEM;
+	}
+
+	ret = cl_main_on(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "cl_main_on failed %d\n", ret);
+		cl_ipc_deinit(cl_hw);
+		vfree(cl_hw->tx_queues);
+
+		return ret;
+	}
+
+	ret = cl_main_alloc(cl_hw);
+	if (ret)
+		goto out_free;
+
+	/* Reset firmware */
+	ret = cl_msg_tx_reset(cl_hw);
+	if (ret)
+		goto out_free;
+
+	cl_calib_power_read(cl_hw);
+	cl_sta_init(cl_hw);
+	cl_sw_txhdr_init(cl_hw);
+	cl_tx_amsdu_txhdr_init(cl_hw);
+	cl_rx_init(cl_hw);
+	cl_prot_mode_init(cl_hw);
+	cl_radar_init(cl_hw);
+	cl_sounding_init(cl_hw);
+	cl_traffic_init(cl_hw);
+	ret = cl_vns_init(cl_hw);
+	if (ret)
+		goto out_free;
+
+	cl_maintenance_init(cl_hw);
+	cl_rssi_assoc_init(cl_hw);
+	cl_agg_cfm_init(cl_hw);
+	cl_single_cfm_init(cl_hw);
+	cl_bcmc_cfm_init(cl_hw);
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	cl_dyn_mcast_rate_init(cl_hw);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_init(cl_hw);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+	cl_wrs_api_init(cl_hw);
+	cl_dfs_init(cl_hw);
+	cl_noise_init(cl_hw);
+	ret = cl_fw_dbg_trigger_based_init(cl_hw);
+	if (ret)
+		goto out_free;
+
+	cl_stats_init(cl_hw);
+	cl_cca_init(cl_hw);
+	cl_bf_init(cl_hw);
+
+	ret = cl_scanner_init(cl_hw);
+	if (ret)
+		goto out_free;
+
+	/* Start firmware */
+	ret = cl_msg_tx_start(cl_hw);
+	if (ret)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	cl_main_free(cl_hw);
+	vfree(cl_hw->tx_queues);
+
+	return ret;
+}
+
+int cl_main_init(struct cl_chip *chip, const struct cl_driver_ops *drv_ops)
+{
+	int ret = 0;
+	struct cl_chip_conf *conf = chip->conf;
+
+	/* All cores needs to be reset first (once per chip) */
+	cl_main_reset(chip, &all_controller_reg);
+
+	/* Prepare HW for TCV0 */
+	if (cl_chip_is_tcv0_enabled(chip)) {
+		ret = cl_prepare_hw(chip, TCV0, drv_ops);
+
+		if (ret) {
+			cl_dbg_chip_err(chip, "Prepare HW for TCV0 failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Prepare HW for TCV1 */
+	if (cl_chip_is_tcv1_enabled(chip)) {
+		ret = cl_prepare_hw(chip, TCV1, drv_ops);
+
+		if (ret) {
+			cl_dbg_chip_err(chip, "Prepare HW for TCV1 failed %d\n", ret);
+			cl_free_hw(chip->cl_hw_tcv0);
+			return ret;
+		}
+	}
+
+	if (!conf->ci_phy_load_bootdrv &&
+	    conf->ci_phy_dev != PHY_DEV_DUMMY) {
+		ret = cl_radio_boot(chip);
+		if (ret) {
+			cl_dbg_chip_err(chip, "RF boot failed %d\n", ret);
+			return ret;
+		}
+
+		ret = cl_dsp_load_regular(chip);
+		if (ret) {
+			cl_dbg_chip_err(chip, "DSP load failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = _cl_main_init(chip->cl_hw_tcv0);
+	if (ret) {
+		cl_free_chip(chip);
+		return ret;
+	}
+
+	ret = _cl_main_init(chip->cl_hw_tcv1);
+	if (ret) {
+		_cl_main_deinit(chip->cl_hw_tcv0);
+		cl_free_chip(chip);
+		return ret;
+	}
+
+	ret = __cl_main_init(chip->cl_hw_tcv0);
+	if (ret)
+		return ret;
+
+	ret = __cl_main_init(chip->cl_hw_tcv1);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	if (conf->ci_calib_eeprom_en && conf->ce_production_mode && conf->ce_calib_runtime_en)
+		cl_e2p_read_eeprom_start_work(chip);
+#endif
+
+	return ret;
+}
-- 
2.36.1

