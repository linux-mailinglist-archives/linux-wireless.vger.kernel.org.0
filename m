Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44E03AB873
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhFQQIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:10 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:41442
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231527AbhFQQHb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKXiMp0tCHaaIOLLXW07qAWQNCv9QxEBYw5p8dYQwOcXiZoYu5HEJ2E84KsBUZGGI7BBd+l2gMBaeFF5BOgI+Cd46oWrGlH8h+pG0UvTwYyw7U4/wTv2oLHpbXEQrNyIsLiKSLBBkiSaBIUIDBwSVnkYGehBH58EJ9kVs/QZMBVSXH3k4VTZ7uAb06st+K+iSuRx8swOnVqykoK3+2A55AEXb/dBnsxJX4KISFvP1UOlBsJ+/4FCqSvToLXjttFe5yomqvFnvscMfmmlT0pDPU5TrQsRY0u9m5PeVh1AQum4NctrOdlkzQKkaTqvWk+1EwFVW8xL2Hz2r2QSKqIh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Aw+o0HWiC6MlOTjmt0rPwx1D54dpU09Sktbca93+DA=;
 b=CA0eZOGOBA9LAbFP3cknFu+XS2qAhQ3yeWSZdFZuqGomD/6RJ4N/04kugOpqdjfVOnwonPzZNmjTQzoeOj0Bm6DJxc70XtMQJLV+EnRD4Y40fsdyltD7ubogdDHT7iOKKpHlkxSBwmzmBiPrq20897cDz798ptELCq47fTvJUnBuZWxTzWuvMlqviSUfGI5t04W+kEGyF8c0//jOmaWAZW5rztL2XHzJ6JgMe43Lw9ZdPXN/R0Ba9wgGPOx3wiZYkQr8TeLKw+uS12/ZTJJgqS2uijBjtdm8cY7vbHMr2Lo8zQZWY32zUNeYzzsbAIDwQKKFhP6QTBb1tqs7TGlqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Aw+o0HWiC6MlOTjmt0rPwx1D54dpU09Sktbca93+DA=;
 b=wntzdq2QLNPqlflwzQTAf/Gg2FUXRdAWYkzZdlSfVtY1nlMEGY2HNtVDAFdGxbZBz9GQUKvxpbTMuTQVn6iAonO3eHbH7njsUhhsPBB5qbhey/+rLF1Pwry+TM5pL1lrbgStdp7XOEl4b5YGh9u/K65c/5j/XsHp6c3nqdhCp9U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:08 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:08 +0000
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
Subject: [RFC v1 109/256] cl8k: add main.c
Date:   Thu, 17 Jun 2021 15:59:56 +0000
Message-Id: <20210617160223.160998-110-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cacc9468-8023-4cd7-5798-08d931a99967
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0402C471AED70DB805C5F615F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB4TltUDCS7oiOdmqBOeN1eD4fEavSeK1J36GB3CMUDDDY2sW9ln4ScbeMZzMMTnpwi5qFa8lFMeKXnPJB9PruDjShRFU6imTPKvybdmSAdZCl8fmaEjAgOpCi3Xd2r4iibAzW2eliCsAlu4dGAf1oMkTY9w3GaCnA4F/8HEuGsI/EQiYkK9mex6Ouur6MlddtdHK6qKzVEeEIDm1Z9t/tGywYxD2HUXhA0YMJ9cnqdXq7F0K4Mm0akhgF9hkWs9pSjmpJaDQDBOPZJ1b4nYonaMMMqBBU3ZpG6vD+0L+AUk3xNZaQ/Coh/ZKhqsMPVXmrYOOCgcxJIgbTexdSkI0+OVBWRMV0CbEtM/AEQ0E/wvvhNlTVV0bFUFkPZ7Gr1DSV2xlyTqPFARUiK5dUJV+XBIGacrixgGrD0tOt0jTgej+rBQEN0NE3wRDXYb66qphsPtU/8mLS1OBqyKqZh0zUBVHHgSq68WkawYVUfIWSAmbqFDbZtL8bGi3tRpnzjcLj8X14I0ARW8HupHJGoKoO9vPhrI7LxpLCDuuscSe6Tdij1LZgZ1CU2FF1qoJa58iCcbgxc5QlsB+rWh98awdWGSeu5+pmYft3IbLGuUxFEBBt1xBuOs6a1hQsaERwAIInMxs+94AYpDdYRwpbbT9eq4qaEyvxYC7UDWvHKejthMO0PF563oUbNgJcllQhVUTGQQGrGy7IXjRmBpCHQsKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(30864003)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xf91LVnPlDXVoEH1EA7sygL7ROjMofx0iog0AUWPYRwOhjh60uGnCyVRABO4?=
 =?us-ascii?Q?gqoo8BZXCmCvgiOm8b06VNDcQgNsamPupOrn3wLrsn1CdHe0Is/eAWBZIOsk?=
 =?us-ascii?Q?WTKFm36qVMXtpBQmIp9Lzyq/0PNwroQwm+3soPlOuqrKqeIC8+OqleZS1y+Z?=
 =?us-ascii?Q?S44yl9NzZ62RD2IkT+HeuyuvekVW1qmXX91vBs2KJlmbkcUKtuLeLtNjtua1?=
 =?us-ascii?Q?hm37XiXA5gxduOgshPQF13YiVg5g+xIBGCclE3186IP2kDCusAes4zkGmNCf?=
 =?us-ascii?Q?cZW8oUPfqlwKt6jMO3Cd2YhmzVYHocqplU37+QPFLoyoVwFdN85pA2PvtVQ7?=
 =?us-ascii?Q?ZXTT1jt3hAYALdvL31/jfDbebg0Q5Rl+4GgKieP0c4TvSXBcC7Ebf7nhDaaC?=
 =?us-ascii?Q?GxW77fSOSfjh2IUZzB7WpablvHd3fwbvt+sqzWspLe5YsKrXs/M+n/1yoo86?=
 =?us-ascii?Q?OkXiWpO+B12oW9i8LFBVHWxuCl/WYqZITKGK8Po3NycemTqZvaDldWs4b/hD?=
 =?us-ascii?Q?S5Oo2pKC4WxxExv1Q1MErd9iBt3BCTzKgHImAd5X1KNqhNFKg+txGFIBVc9W?=
 =?us-ascii?Q?pq4cQ5UjR8iYY4wsLWbexjNQkjP1ZjduMKv412RikGTzws8XZteTCwnP0sdB?=
 =?us-ascii?Q?rcoe/LWV1OTYWzLc2x0/omuuPYIyucBPnx/3rELeYUuolzsbL25WRAYhjQTs?=
 =?us-ascii?Q?SpZ5zp+kNLzvkKmF9IQ6IKnlr37TBAET7tr/aL/MuDawYNX1s2X9YnUxhDXR?=
 =?us-ascii?Q?69JDOfeq7ejj0tS1jdG4ZZ9Hc9YpG4bycjguYkIiRQGo7GNYqa2jc6/TsaR0?=
 =?us-ascii?Q?ZCvLwRoCy6dd1OU34Oa5DZlEUQ0Dx9z0kvcuhiKJ3xNVy8Xg7CK/Zzj0Qevm?=
 =?us-ascii?Q?odQzc73VSHaxuhtTxE3Ir2NSZree+n+MNzwPAWp/CZj21hXhfpZcTs6RpL2T?=
 =?us-ascii?Q?n9B+5W7q08eSZfEN4MGXm0AtSW1NzzAqdIMunNJ9FzmsEwZ2xHUo6Uzd1FOq?=
 =?us-ascii?Q?lDn5lorSAuP4UGQpjtyYmzkPlKqKDv6OHxa1X8skmrnshWhmT03XIDVIPPe2?=
 =?us-ascii?Q?p6/rpJBRQRqW+0EFhXYg2UhYBBZPc3/81lpQl2cyqNkSmUvTbTm1oKLDuAuz?=
 =?us-ascii?Q?caqaVViXaDXCoHPw3wutQrTURZQeNXRuAnadgpUnpcX6riSN1it3ZkUuXAXg?=
 =?us-ascii?Q?g14z2svIObijyAsOXqk0MfEgZVNBDTw+OMn34G6UmyEYxTDKzZsmLcx0DWXJ?=
 =?us-ascii?Q?pYWLVBjnUAH7BSYLlXys4M41xuEQXGmrKVnGxYUlAeIfoxHp6vYsJ8lLNQvG?=
 =?us-ascii?Q?ore2rhI9wkpfcJrSpaquWAKY?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc9468-8023-4cd7-5798-08d931a99967
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:34.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogQbqX7dj1y4BIUn2aZXqe04gkkSgPfm0vA9tw1IwBP2AUTkFWC1UOJBqDo6lDhyqIkoAzp5YTlZkBhGTa6WIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/main.c | 584 ++++++++++++++++++++++++
 1 file changed, 584 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.c

diff --git a/drivers/net/wireless/celeno/cl8k/main.c b/drivers/net/wireless=
/celeno/cl8k/main.c
new file mode 100644
index 000000000000..0b37ae8a03e1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/main.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "main.h"
+#include "ops.h"
+#include "dfs/radar.h"
+#include "fw/msg_tx.h"
+#include "tx/tx.h"
+#include "reg/reg_access.h"
+#include "stats.h"
+#include "debugfs.h"
+#include "vendor_cmd.h"
+#include "chan_info.h"
+#include "tx/agg_cfm.h"
+#include "tx/single_cfm.h"
+#include "tx/bcmc_cfm.h"
+#include "tx/tx_queue.h"
+#include "rssi.h"
+#include "maintenance.h"
+#include "vns.h"
+#include "traffic.h"
+#include "ext/vlan_dscp.h"
+#include "sounding.h"
+#include "recovery.h"
+#include "rate_ctrl.h"
+#include "ext/dyn_mcast_rate.h"
+#include "ext/dyn_bcast_rate.h"
+#include "tx/tx_amsdu.h"
+#include "prot_mode.h"
+#include "utils/utils.h"
+#include "band.h"
+#include "phy/phy.h"
+#include "rf_boot.h"
+#include "dsp.h"
+#include "calib.h"
+#include "reg/reg_macsys_gcu.h"
+#include "dfs/dfs.h"
+#include "tx/sw_txhdr.h"
+#include "tx/tx_inject.h"
+#include "fem.h"
+#include "fw/fw_file.h"
+#include "cap.h"
+#include "tcv_config.h"
+#include "mac_addr.h"
+#include "hw_assert.h"
+#include "power_table.h"
+#include "noise.h"
+#include "twt.h"
+#include "fw/fw_dbg.h"
+#include "wrs/wrs_api.h"
+#ifdef CONFIG_CL_PCIE
+#include "fw/msg_rx.h"
+#include "bus/pci/irq.h"
+#include "reg/reg_ipc.h"
+#include "bus/pci/ipc.h"
+#endif
+
+MODULE_DESCRIPTION("Celeno 11ax driver for Linux");
+MODULE_VERSION("8.1.x");
+MODULE_AUTHOR("Copyright(c) 2021 Celeno Communications Ltd");
+MODULE_LICENSE("MIT");
+
+#define MAX_MU_CNT_LMAC 8
+#define MAX_MU_CNT_SMAC 8
+
+static struct ieee80211_ops cl_ops =3D {
+       .tx                           =3D cl_ops_tx,
+       .start                        =3D cl_ops_start,
+       .stop                         =3D cl_ops_stop,
+       .add_interface                =3D cl_ops_add_interface,
+       .remove_interface             =3D cl_ops_remove_interface,
+       .config                       =3D cl_ops_config,
+       .bss_info_changed             =3D cl_ops_bss_info_changed,
+       .start_ap                     =3D cl_ops_start_ap,
+       .stop_ap                      =3D cl_ops_stop_ap,
+       .prepare_multicast            =3D cl_ops_prepare_multicast,
+       .configure_filter             =3D cl_ops_configure_filter,
+       .set_key                      =3D cl_ops_set_key,
+       .sw_scan_start                =3D cl_ops_sw_scan_start,
+       .sta_state                    =3D cl_ops_sta_state,
+       .sta_notify                   =3D cl_ops_sta_notify,
+       .conf_tx                      =3D cl_ops_conf_tx,
+       .sta_rc_update                =3D cl_ops_sta_rc_update,
+       .ampdu_action                 =3D cl_ops_ampdu_action,
+       .post_channel_switch          =3D cl_ops_post_channel_switch,
+       .flush                        =3D cl_ops_flush,
+       .tx_frames_pending            =3D cl_ops_tx_frames_pending,
+       .reconfig_complete            =3D cl_ops_reconfig_complete,
+       .get_txpower                  =3D cl_ops_get_txpower,
+       .set_rts_threshold            =3D cl_ops_set_rts_threshold,
+       .event_callback               =3D cl_ops_event_callback,
+       .set_tim                      =3D cl_ops_set_tim,
+};
+
+static void cl_drv_workqueue_create(struct cl_hw *cl_hw)
+{
+       if (!cl_hw->drv_workqueue)
+               cl_hw->drv_workqueue =3D create_singlethread_workqueue("drv=
_workqueue");
+}
+
+static void cl_drv_workqueue_destroy(struct cl_hw *cl_hw)
+{
+       if (cl_hw->drv_workqueue) {
+               destroy_workqueue(cl_hw->drv_workqueue);
+               cl_hw->drv_workqueue =3D NULL;
+       }
+}
+
+static int cl_main_alloc(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       ret =3D cl_phy_data_alloc(cl_hw);
+       if (ret)
+               return ret;
+
+       ret =3D cl_calib_tables_alloc(cl_hw);
+       if (ret)
+               return ret;
+
+       ret =3D cl_power_table_alloc(cl_hw);
+       if (ret)
+               return ret;
+
+       return ret;
+}
+
+static void cl_main_free(struct cl_hw *cl_hw)
+{
+       cl_phy_data_free(cl_hw);
+       cl_calib_tables_free(cl_hw);
+       cl_power_table_free(cl_hw);
+}
+
+static void cl_free_hw(struct cl_hw *cl_hw)
+{
+       struct ieee80211_hw *hw =3D cl_hw->hw;
+
+       cl_tcv_config_free(cl_hw);
+
+       if (hw->wiphy->registered)
+               ieee80211_unregister_hw(hw);
+
+       cl_chip_unset_hw(cl_hw->chip, cl_hw);
+       ieee80211_free_hw(hw);
+}
+
+static void cl_free_chip(struct cl_chip *chip)
+{
+       cl_free_hw(chip->cl_hw_tcv0);
+       cl_free_hw(chip->cl_hw_tcv1);
+}
+
+static int cl_prepare_hw(struct cl_chip *chip, u8 tcv_idx,
+                        const struct cl_driver_ops *drv_ops)
+{
+       struct cl_hw *cl_hw =3D NULL;
+       struct ieee80211_hw *hw;
+       int ret =3D 0;
+
+       hw =3D ieee80211_alloc_hw(sizeof(struct cl_hw), &cl_ops);
+       if (!hw) {
+               cl_dbg_chip_err(chip, ": ieee80211_alloc_hw failed\n");
+               return -ENOMEM;
+       }
+
+       cl_hw_init(chip, hw->priv, tcv_idx);
+
+       cl_hw =3D hw->priv;
+       cl_hw->hw =3D hw;
+       cl_hw->tcv_idx =3D tcv_idx;
+       cl_hw->chip =3D chip;
+
+       /*
+        * chip0, tcv0 --> 0
+        * chip0, tcv1 --> 1
+        * chip1, tcv0 --> 2
+        * chip1, tcv1 --> 3
+        */
+       cl_hw->idx =3D chip->idx * CHIP_MAX + tcv_idx;
+
+       cl_hw->drv_ops =3D drv_ops;
+
+       if (cl_hw_is_tcv0(cl_hw))
+               cl_hw->max_mu_cnt =3D MAX_MU_CNT_LMAC;
+       else
+               cl_hw->max_mu_cnt =3D MAX_MU_CNT_SMAC;
+
+       SET_IEEE80211_DEV(hw, chip->dev);
+
+       ret =3D cl_tcv_config_alloc(cl_hw);
+       if (ret)
+               goto out_free_hw;
+
+       ret =3D cl_hw_set_antennas(cl_hw);
+       if (ret)
+               goto out_free_hw;
+
+       ret =3D cl_tcv_config_read(cl_hw);
+       if (ret)
+               goto out_free_hw;
+
+       cl_chip_set_hw(chip, cl_hw);
+
+       ret =3D cl_mac_addr_set(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_mac_addr_set failed\n");
+               goto out_free_hw;
+       }
+
+       if (cl_band_is_6g(cl_hw))
+               cl_hw->nl_band =3D NL80211_BAND_6GHZ;
+       else if (cl_band_is_5g(cl_hw))
+               cl_hw->nl_band =3D NL80211_BAND_5GHZ;
+       else
+               cl_hw->nl_band =3D NL80211_BAND_2GHZ;
+
+       cl_cap_dyn_params(cl_hw);
+       cl_vendor_cmds_init(hw->wiphy);
+
+       /*
+        * ieee80211_register_hw() will take care of calling wiphy_register=
() and
+        * also ieee80211_if_add() (because IFTYPE_STATION is supported)
+        * which will internally call register_netdev()
+        */
+       ret =3D ieee80211_register_hw(hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "ieee80211_register_hw failed\n");
+               goto out_free_hw;
+       }
+
+       if (hw->wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
+               ret =3D regulatory_set_wiphy_regd(hw->wiphy, cl_hw->channel=
_info.rd);
+               if (ret)
+                       cl_dbg_err(cl_hw, "regulatory failed\n");
+       }
+
+       cl_dbg_verbose(cl_hw, "cl_hw created\n");
+
+       return 0;
+
+out_free_hw:
+       cl_free_hw(cl_hw);
+
+       return ret;
+}
+
+void cl_main_off(struct cl_hw *cl_hw)
+{
+#ifdef CONFIG_CL_PCIE
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
+       cl_ipc_stop(cl_hw);
+#endif
+
+       if (!test_bit(CL_DEV_INIT, &cl_hw->drv_flags)) {
+               cl_tx_off(cl_hw);
+               cl_rx_off(cl_hw);
+#ifdef CONFIG_CL_PCIE
+               cl_msg_rx_flush_all(cl_hw);
+#endif
+       }
+
+       cl_fw_file_cleanup(cl_hw);
+}
+
+static void _cl_main_deinit(struct cl_hw *cl_hw)
+{
+       /* First bring down all interfaces */
+       cl_vif_bring_all_interfaces_down(cl_hw);
+
+       cl_hw->is_stop_context =3D true;
+
+       cl_drv_workqueue_destroy(cl_hw);
+
+       cl_noise_close(cl_hw);
+       cl_maintenance_close(cl_hw);
+       cl_vns_close(cl_hw);
+       cl_rssi_assoc_exit(cl_hw);
+       cl_radar_close(cl_hw);
+       cl_sounding_close(cl_hw);
+       cl_chan_info_deinit(cl_hw);
+       cl_wrs_api_close(cl_hw);
+       cl_dfs_close(cl_hw);
+       cl_twt_close(cl_hw);
+       cl_tx_inject_close(cl_hw);
+       cl_dbgfs_unregister(cl_hw);
+       cl_main_off(cl_hw);
+       /* These 2 must be called after cl_tx_off() (which is called from c=
l_main_off) */
+       cl_tx_amsdu_txhdr_deinit(cl_hw);
+       cl_sw_txhdr_deinit(cl_hw);
+       cl_stats_deinit(cl_hw);
+       cl_main_free(cl_hw);
+       cl_fw_file_release(cl_hw);
+       cl_vendor_timer_close(cl_hw);
+#ifdef CONFIG_CL_PCIE
+       cl_ipc_deinit(cl_hw);
+#endif
+       cl_hw_deinit(cl_hw, cl_hw->tcv_idx);
+}
+
+void cl_main_deinit(struct cl_chip *chip)
+{
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+
+       if (cl_chip_is_tcv1_enabled(chip) && cl_hw_tcv1)
+               _cl_main_deinit(cl_hw_tcv1);
+
+       if (cl_chip_is_tcv0_enabled(chip) && cl_hw_tcv0)
+               _cl_main_deinit(cl_hw_tcv0);
+
+       if (cl_hw_tcv1) {
+               cl_phy_off(cl_hw_tcv1);
+               cl_free_hw(cl_hw_tcv1);
+       }
+
+       if (cl_hw_tcv0) {
+               cl_phy_off(cl_hw_tcv0);
+               cl_free_hw(cl_hw_tcv0);
+       }
+}
+
+struct cl_controller_reg all_controller_reg =3D {
+       .breset =3D XMAC_BRESET,
+       .debug_enable =3D XMAC_DEBUG_ENABLE,
+       .dreset =3D XMAC_DRESET,
+       .ocd_halt_on_reset =3D XMAC_OCD_HALT_ON_RESET,
+       .run_stall =3D XMAC_RUN_STALL
+};
+
+void cl_main_reset(struct cl_chip *chip, struct cl_controller_reg *control=
ler_reg)
+{
+       /* Release TRST & BReset to enable JTAG connection to FPGA A */
+       u32 regval;
+
+       /* 1. return to reset value */
+       regval =3D macsys_gcu_xt_control_get(chip);
+       regval |=3D controller_reg->ocd_halt_on_reset;
+       regval &=3D ~(controller_reg->dreset | controller_reg->run_stall | =
controller_reg->breset);
+       macsys_gcu_xt_control_set(chip, regval);
+
+       regval =3D macsys_gcu_xt_control_get(chip);
+       regval |=3D controller_reg->dreset;
+       macsys_gcu_xt_control_set(chip, regval);
+
+       /* 2. stall xtensa & release ocd */
+       regval =3D macsys_gcu_xt_control_get(chip);
+       regval |=3D controller_reg->run_stall;
+       regval &=3D ~controller_reg->ocd_halt_on_reset;
+       macsys_gcu_xt_control_set(chip, regval);
+
+       /* 3. breset release & debug enable */
+       regval =3D macsys_gcu_xt_control_get(chip);
+       regval |=3D (controller_reg->debug_enable | controller_reg->breset)=
;
+       macsys_gcu_xt_control_set(chip, regval);
+
+       msleep(100);
+}
+
+int cl_main_on(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       int ret;
+       u32 regval;
+
+       cl_hw->fw_active =3D false;
+
+       cl_txq_init(cl_hw);
+
+       cl_hw_assert_info_init(cl_hw);
+
+       if (cl_recovery_in_progress(cl_hw))
+               cl_main_reset(chip, &cl_hw->controller_reg);
+
+       ret =3D cl_fw_file_load(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_fw_file_load failed %d\n", ret);
+               return ret;
+       }
+
+       /* Clear CL_DEV_FW_ERROR after firmware loaded */
+       clear_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags);
+
+#ifdef CONFIG_CL_PCIE
+       if (cl_recovery_in_progress(cl_hw))
+               cl_ipc_recovery(cl_hw);
+#endif
+
+       regval =3D macsys_gcu_xt_control_get(chip);
+
+       /* Set fw to run */
+       if (cl_hw->fw_active)
+               regval &=3D ~cl_hw->controller_reg.run_stall;
+
+#ifdef CONFIG_CL_PCIE
+       /* Ack all possibly pending IRQs */
+       ipc_xmac_2_host_ack_set(chip, cl_hw->ipc_e2a_irq.all);
+#endif
+
+       macsys_gcu_xt_control_set(chip, regval);
+
+#ifdef CONFIG_CL_PCIE
+       cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.all);
+#endif
+
+       /*
+        * cl_irq_status_sync will set CL_DEV_FW_SYNC when fw raises IPC_IR=
Q_E2A_SYNC
+        * (indicate its ready to accept interrupts)
+        */
+       ret =3D wait_event_interruptible_timeout(cl_hw->fw_sync_wq,
+                                              test_and_clear_bit(CL_DEV_FW=
_SYNC,
+                                                                 &cl_hw->d=
rv_flags),
+                                              msecs_to_jiffies(5000));
+
+       if (ret =3D=3D 0) {
+               pr_err("[%s]: FW synchronization timeout.\n", __func__);
+               cl_hw_assert_check(cl_hw);
+               ret =3D -ETIMEDOUT;
+               goto out_free_cached_fw;
+       } else if (ret =3D=3D -ERESTARTSYS) {
+               goto out_free_cached_fw;
+       }
+
+       return 0;
+
+out_free_cached_fw:
+       cl_fw_file_release(cl_hw);
+       return ret;
+}
+
+static int __cl_main_init(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       set_bit(CL_DEV_INIT, &cl_hw->drv_flags);
+
+       /* By default, set FEM mode to operational mode. */
+       cl_hw->fem_system_mode =3D FEM_MODE_OPERETIONAL;
+
+       cl_vif_init(cl_hw);
+
+       cl_drv_workqueue_create(cl_hw);
+
+       init_waitqueue_head(&cl_hw->wait_queue);
+       init_waitqueue_head(&cl_hw->fw_sync_wq);
+       init_waitqueue_head(&cl_hw->radio_wait_queue);
+
+       mutex_init(&cl_hw->dbginfo.mutex);
+       mutex_init(&cl_hw->msg_tx_mutex);
+       mutex_init(&cl_hw->set_channel_mutex);
+
+       spin_lock_init(&cl_hw->tx_lock_agg);
+       spin_lock_init(&cl_hw->tx_lock_cfm_agg);
+       spin_lock_init(&cl_hw->tx_lock_single);
+       spin_lock_init(&cl_hw->tx_lock_bcmc);
+
+#ifdef CONFIG_CL_PCIE
+       ret =3D cl_ipc_init(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_ipc_init failed %d\n", ret);
+               return ret;
+       }
+#endif
+       ret =3D cl_main_on(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_main_on failed %d\n", ret);
+#ifdef CONFIG_CL_PCIE
+               cl_ipc_deinit(cl_hw);
+#endif
+               return ret;
+       }
+
+       ret =3D cl_main_alloc(cl_hw);
+       if (ret)
+               goto out_free;
+
+       /* Reset firmware */
+       ret =3D cl_msg_tx_reset(cl_hw);
+       if (ret)
+               goto out_free;
+
+       cl_calib_power_read(cl_hw);
+       cl_dbgfs_register(cl_hw, "cl");
+       cl_sta_init(cl_hw);
+       cl_sw_txhdr_init(cl_hw);
+       cl_tx_amsdu_txhdr_init(cl_hw);
+       cl_tx_init(cl_hw);
+       cl_rx_init(cl_hw);
+       cl_prot_mode_init(cl_hw);
+       cl_radar_init(cl_hw);
+       cl_sounding_init(cl_hw);
+       cl_vlan_dscp_init(cl_hw);
+       cl_traffic_init(cl_hw);
+       cl_rsrc_mgmt_init(cl_hw);
+       cl_vns_init(cl_hw);
+       cl_maintenance_init(cl_hw);
+       cl_rssi_assoc_init(cl_hw);
+       cl_agg_cfm_init(cl_hw);
+       cl_single_cfm_init(cl_hw);
+       cl_bcmc_cfm_init(cl_hw);
+       cl_dyn_mcast_rate_init(cl_hw);
+       cl_dyn_bcast_rate_init(cl_hw);
+       cl_wrs_api_init(cl_hw);
+       cl_dfs_init(cl_hw);
+       cl_tx_inject_init(cl_hw);
+       cl_noise_init(cl_hw);
+       cl_twt_init(cl_hw);
+       cl_fw_dbg_trigger_based_init(cl_hw);
+       cl_stats_init(cl_hw);
+       cl_vendor_timer_init(cl_hw);
+
+       return 0;
+
+out_free:
+       cl_main_free(cl_hw);
+
+       return ret;
+}
+
+static int _cl_main_init(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       if (cl_chip_is_tcv_enabled(chip, cl_hw->tcv_idx)) {
+               ret =3D __cl_main_init(cl_hw);
+               if (ret) {
+                       cl_dbg_chip_err(chip, "TCV%u failed (%d)\n", cl_hw-=
>tcv_idx, ret);
+                       return ret;
+               }
+       } else {
+               ieee80211_unregister_hw(cl_hw->hw);
+       }
+
+       return ret;
+}
+
+int cl_main_init(struct cl_chip *chip, const struct cl_driver_ops *drv_ops=
)
+{
+       int ret =3D 0;
+
+       /* All cores needs to be reset first (once per chip) */
+       cl_main_reset(chip, &all_controller_reg);
+
+       ret =3D cl_prepare_hw(chip, TCV0, drv_ops);
+       if (ret) {
+               cl_dbg_chip_err(chip, "cl_prepare_hw for TCV0 failed %d\n",=
 ret);
+               return ret;
+       }
+
+       ret =3D cl_prepare_hw(chip, TCV1, drv_ops);
+       if (ret) {
+               cl_dbg_chip_err(chip, "cl_prepare_hw for TCV1 failed %d\n",=
 ret);
+               cl_free_hw(chip->cl_hw_tcv0);
+               return ret;
+       }
+
+       ret =3D cl_rf_boot(chip);
+       if (ret) {
+               cl_dbg_chip_err(chip, "cl_rf_boot failed %d\n", ret);
+               return ret;
+       }
+
+       ret =3D cl_dsp_load_regular(chip);
+       if (ret) {
+               cl_dbg_chip_err(chip, "cl_dsp_load_regular failed %d\n", re=
t);
+               return ret;
+       }
+
+       ret =3D _cl_main_init(chip, chip->cl_hw_tcv0);
+       if (ret) {
+               cl_free_chip(chip);
+               return ret;
+       }
+
+       ret =3D _cl_main_init(chip, chip->cl_hw_tcv1);
+       if (ret) {
+               _cl_main_deinit(chip->cl_hw_tcv0);
+               cl_free_chip(chip);
+               return ret;
+       }
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

