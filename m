Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0A532967
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiEXLkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiEXLkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:23 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9292939A0
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfR53efHGsH4KeFi8lGz17ROGckgs1fwueV6Y7whIXvbGCjqKRV/SnkT1Hj2+ioPv27ihSkG6IHz3n92jgrTTyrJYoOsiOtP2PD2OPA8k8GQIKcGatqmQp33Y79J40xrQSybmvrcCgjur+Peg1RO2EzGgIn7wrERfRey/L1Z2clh5fekS4L3o/5D7vikju0VXHfcRZoysxMTGys6m8ssXwNPc0+ybtPVvjgBqaK0mjuTzocHgJidU5/46mfWC8PByitTmW1uS5d/XwPzv4+oKvD1QuJO65gy2gbW18lplajyfaSxO7yA9t+QQ1whpdSH3pKpB9GBCaZIaH1txNj3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlPJQilWTY5hoW6q8ZBlpd0qoBHS2YakFmK5RuugP6g=;
 b=OStvHi//1TcDjP51TK9W0vBepI+TMLbiJ4gXS/rnf1ylmMQnwo4NtEDkLtDfFr37zkNtBnOjelDcGMslpAJk+zxPr4Bc4qjOA9psffWxiVa54y9rjdm1VENJdfOtqAtVMkdSocTSXFxjuIGNzAGOSFsH/uPI39NL1DKutJHWKCkFIz3BuzgsdO1zBTUYr9/v3cvQkra0GWXkFCs395Shh69Z+SSXOKfT5fbwbfURj5UqxzftpwknNJYaQ+J5ZIl35Z8BDid86nUaJHGH+Vuv8EDGaTqqS9rXyanntPTpTCnW6jD8WiLiFozp/eay9IMLANUhln2qMt8p5a1fd3JZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPJQilWTY5hoW6q8ZBlpd0qoBHS2YakFmK5RuugP6g=;
 b=W4NOIAcmzwJap4NnWp0mSK8UWM6ns+7vSoO6xMkr0klbblh6UCMifeZkfMPmiAYXsMI2Cu+isZBR+8FFkAZPENXER7OQ3WshOdYMK5b180wcJtuAQBrMI73HqwQjQfvDOUl3gi0n1pYU++04IX2R8Amk5L8VH3iBWT+cVBtwWcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:51 +0000
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
Subject: [RFC v2 56/96] cl8k: add radio.c
Date:   Tue, 24 May 2022 14:34:22 +0300
Message-Id: <20220524113502.1094459-57-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e4f6aea-e6a4-436d-83f2-08da3d79ef4e
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB157174936E8177B156F02F4EF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vhy0Gjq1kX+UBc4+YDOhNZayMybSo/4Af+3Oxmn1r2Q/6tI4xSNPl0K7McpdPiHjsKakqOqBP4zLBUQyfHYeDXuLYYQOh4lU8cZfCkEp0LYhAt4iMxT4LkX/6CbKwphqi/L7ljjkg4hA/UvSv+l8x90PEvb6lXcwmTNGUz7U1TcXHdFELLcLEyAcV0Sw9tW5riYyNC4nbzWZp54mFoEnE2SU7B86RSQOKpdh6z9GMY+0Arr9MaVzXoe9r+z4DO3ZwB+b7hXZaIMX5wtqzqb4YEnAvfzwC2TPRHd3qvOSN6TEpWuMWSCrbeLHCAFPaNqZGPgTRFlaoLx/fJd/CPYzxKq9fKDuFH5d3bGv7GRpcExMVay69kq3zI7V7aWM309uejBW+1wweUurGTWSg+c9rMW2wPOg+s2I0ggp+C3rKK9adneFQ9mpTCTywKHbI5my9FoE38tOVNcEQJBWrd3XIIjCqVZYyFKWtUNurWGsrmbpnoJb6XI3gTGL7wUM09ql0GZiv+BEV29TPcc7Cak0hO1K6xyMcOahlyjyB9DKect+il/ak7IOYvkIzqINbTamcXPWuObWTkFQMNPH74UBCFvCAACWEcXn28qchsGAUQ0VLQlu6i9JgEEky+WoDpnkm0Y7/vGD+nvJI4QugLfIVof4SypfzGo5lkBEEXjhIwvlcPDT4UJ70H8+EZ5G9P3ca3G/1yDeI45HH7yF2hlIGl110Hi3158Q+3Pi+yEppRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(30864003)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCfhcjoRwaMpY/KN4T6fsdianThEekw+7tlIraV3gQ0bZYqR/BT7XFgDVuWE?=
 =?us-ascii?Q?KNgAvciVRa746tVAES6Lx0Y6sVieZ1CJLRL558jrchDi65JyUBf+TGHmaq9i?=
 =?us-ascii?Q?zOfv7fNIIP4jYW3w3tcI3iNDruGTfzOcoXunqet1fhx9ItEIltsdJyWVHhp6?=
 =?us-ascii?Q?+c1rPfKGcy2M36owG6GZLhb4Lp3u5r0UdmWjQtg5fJWm99GXikd2thUyS8w0?=
 =?us-ascii?Q?+fdu6rgfJMiwlpbfLKwOsCeWQVHwr8ZPkGNoY3jTHp+Q7pVeM9s3RRO+1YTf?=
 =?us-ascii?Q?akIFiySwnR+bGYLkAKOYH1eP8Q4aoXsq6ZWxJF8jTNKkjCP6qYx3ecgA6/Cj?=
 =?us-ascii?Q?I8ycENZLBcjRzsrg9pDTUJvEeZka2C/z7WLxxYzeZGeLwszKdAadf9TZxC+H?=
 =?us-ascii?Q?jnKEurpnpN8pQc7/5KyeDS4zc5bpq5VKGktIlUYFMavP7Lyuoy6QInEm5Srx?=
 =?us-ascii?Q?loxFrbSabJGdRlw6QU85AtLhrzXps30jcvM4U78kSdKCXttdUqFkoINGeeT+?=
 =?us-ascii?Q?U3EyImxN1vgDGJZj60YTOv0aSNVFZAyZdJNEmIKqM450lpffT4sk0zDY5JYd?=
 =?us-ascii?Q?3uMzovXezVMK5GmKGLygmcvKnvdfj/kiNGq7kvyPVQ4rFGxv86A+Ea6JodwB?=
 =?us-ascii?Q?0I06jJIhiNfwpHpjJoAO/UYnXbb0pMOD9kfKoKgol1tXeC1A5kZYsjUhzzuV?=
 =?us-ascii?Q?45NdvVBNw2Z15hnWostEtKXf6okTsprgEkFML+4yjG1cTBtmx3GXCG4Tz7+H?=
 =?us-ascii?Q?9WLb/Fkk6zv7GV9W8F2ok39KCUDe+MPYLqG1leIwWLNTuTc4lN8Du3WDnAkQ?=
 =?us-ascii?Q?pmLBDiAS5JdXqS4sW2qmxYYleINNfqm1iGWClrhuZhd7rHtWlSCj+qIsHBE4?=
 =?us-ascii?Q?9dSv5ilvo20xItwaHt7erLzvPYV0hZtBJBtI+LXq2hJ/Ya/DmtgxDXsPXGZV?=
 =?us-ascii?Q?x4vlANnmtv0eoSZioOK7WEz0QlHJ/7wieY+EdGSFVMfKEkwMrNjHdwT/kjex?=
 =?us-ascii?Q?AwSJLJcYNxKUpupEgv45sY88S6xDiOjJwd7p3gyRm9a9AhD0oQ+SqLwMSKxz?=
 =?us-ascii?Q?eW/T2x3Q/xxDUTKXATHoJW3/DHxN+xtAYVofLL5o52ucx6XhjGJqhUFcaQyh?=
 =?us-ascii?Q?HmYVVQpBB8acNfU142IKxm9FDhpijyvp3FddYJJtygF7k72+28tvnVoCcywX?=
 =?us-ascii?Q?edZG4uJkgpqrapnxgA+j7GmK1tyO8ssCUfBgTRReVLr4uTdXYfVIp+kDQ9i+?=
 =?us-ascii?Q?m9DnY7u0ivzzM7+slT56mFiTlgOt5u0R8paUV0p9833Ot2ST8RXG//kSt1TU?=
 =?us-ascii?Q?BynKfOihXuQCBSa+jjOBOmS76VvlSfmZgBV+aU3rvhvQKviSXcSrB2gZrxJb?=
 =?us-ascii?Q?PjVhOEg24Gm+thGsDrqTMqfSddopNhB6SPgu9/HDbs8Pc2fSrRSLEqIdHkEp?=
 =?us-ascii?Q?d3rps+EHmYMQ8+RgjLY672uAwa7Bluvisp8c2F0ws6AywloFlWN1sRqw8sca?=
 =?us-ascii?Q?fKoQlf6uj4KrUFFpjGBtZ+bkX66NvgJIYTZVTwOSn5AOZSH+xIk9GauyoIiP?=
 =?us-ascii?Q?jeL3JNtJqb8q60Kti3/gCBgfKEGshEAiwcWpFt4TqlPaJZvrVvjzfCiCr85G?=
 =?us-ascii?Q?Y2/W8OP0+5ML6EbuRLCayKxaRw6+uIGk8VnbXnYrh2yWG951C3QwE0y2Rcak?=
 =?us-ascii?Q?91FfC3+GDIeOLAmAsmHP8E2wQdFBdk+n7jALuifrMaqMHE6BTrevRcBrrfK2?=
 =?us-ascii?Q?iFSO+n1kgqsZWXo2SdpN/IVPSQ9hI2k=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f6aea-e6a4-436d-83f2-08da3d79ef4e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:34.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/Mh2YNESwrK799AnQhBPrGXXqStH4hDZa/IjFnvJmMxOhOqpaILon+Qqvogo0GO1wMggJwaQv/pCKeTvB/T2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 drivers/net/wireless/celeno/cl8k/radio.c | 1113 ++++++++++++++++++++++
 1 file changed, 1113 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.c

diff --git a/drivers/net/wireless/celeno/cl8k/radio.c b/drivers/net/wireless/celeno/cl8k/radio.c
new file mode 100644
index 000000000000..416c2bdff07e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/radio.c
@@ -0,0 +1,1113 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+
+#include "vif.h"
+#include "sta.h"
+#include "chip.h"
+#include "debug.h"
+#include "hw.h"
+#include "phy.h"
+#include "utils.h"
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "mac_addr.h"
+#include "stats.h"
+#include "radio.h"
+
+static int cl_radio_off_kthread(void *arg)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)arg;
+	struct cl_vif *cl_vif;
+
+	cl_dbg_verbose(cl_hw, "Waiting for stations to disconnect\n");
+
+	if (wait_event_timeout(cl_hw->radio_wait_queue,
+			       cl_sta_num_bh(cl_hw) == 0,
+			       msecs_to_jiffies(5000)) == 0) {
+		cl_dbg_verbose(cl_hw,
+			       "Failed to disconnect stations. %u stations still remaining\n",
+			       cl_sta_num_bh(cl_hw));
+	}
+
+	cl_dbg_trace(cl_hw, "Stopping queues ...\n");
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+		cl_vif->tx_en = false;
+		cl_dbg_verbose(cl_hw, "Radio OFF vif_index = %u\n",
+			       cl_vif->vif_index);
+	}
+	read_unlock_bh(&cl_hw->vif_db.lock);
+
+	cl_msg_tx_set_idle(cl_hw, MAC_IDLE_SYNC, true);
+
+	cl_dbg_trace(cl_hw, "Radio shut down successfully\n");
+
+	cl_hw->radio_status = RADIO_STATUS_OFF;
+	atomic_set(&cl_hw->radio_lock, 0);
+
+	return 0;
+}
+
+static int cl_radio_off(struct cl_hw *cl_hw)
+{
+	struct task_struct *k;
+
+	if (cl_hw->radio_status != RADIO_STATUS_ON ||
+	    atomic_xchg(&cl_hw->radio_lock, 1))
+		return 1;
+
+	cl_hw->radio_status = RADIO_STATUS_GOING_DOWN;
+
+	/* Relegate the job to a kthread to free the system call. */
+	k = kthread_run(cl_radio_off_kthread, cl_hw, "cl_radio_off_kthread");
+	if (IS_ERR(k))
+		cl_dbg_verbose(cl_hw,
+			       "Error: failed to run cl_radio_off_kthread\n");
+	return 0;
+}
+
+void cl_radio_on_start(struct cl_hw *cl_hw)
+{
+	struct cl_vif *cl_vif;
+
+	if (cl_calib_common_check_errors(cl_hw) != 0 || !cl_hw->conf->ce_num_antennas)
+		return;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+		if (cl_vif->vif->type == NL80211_IFTYPE_AP) {
+			if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_REPEATER &&
+			    !test_bit(CL_DEV_REPEATER, &cl_hw->drv_flags))
+				continue;
+			if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_MESH_AP &&
+			    !test_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags))
+				continue;
+		}
+
+		if (!cl_hw->conf->ce_listener_en)
+			cl_vif->tx_en = true;
+
+		cl_dbg_verbose(cl_hw, "Radio ON vif=%u\n", cl_vif->vif_index);
+	}
+	read_unlock_bh(&cl_hw->vif_db.lock);
+
+	cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE, true);
+
+	cl_dbg_verbose(cl_hw, "Radio has been started\n");
+
+	cl_hw->radio_status = RADIO_STATUS_ON;
+	atomic_set(&cl_hw->radio_lock, 0);
+}
+
+int cl_radio_on(struct cl_hw *cl_hw)
+{
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+	bool both_enabled = cl_chip_is_both_enabled(cl_hw->chip);
+
+	if (cl_hw->radio_status != RADIO_STATUS_OFF ||
+	    atomic_xchg(&cl_hw->radio_lock, 1))
+		return 1;
+
+	if (!both_enabled ||
+	    (both_enabled && cl_hw_other && !cl_hw_other->conf->ce_radio_on) ||
+	    (cl_hw_is_tcv1(cl_hw) && cl_hw->chip->conf->ci_tcv1_chains_sx0)) {
+		if (cl_calib_iq_calibration_needed(cl_hw)) {
+			cl_calib_common_start_work(cl_hw);
+
+			return 0;
+		}
+	} else if (cl_hw_other) {
+		if (cl_hw_other->iq_cal_ready) {
+			cl_hw_other->iq_cal_ready = false;
+			cl_calib_common_start_work(cl_hw);
+
+			return 0;
+		} else if (cl_calib_iq_calibration_needed(cl_hw)) {
+			cl_hw->iq_cal_ready = true;
+			cl_dbg_verbose(cl_hw, "IQ Calibration needed. Wait for both TCVs "
+					      "to get to radio-on before turning both on.\n");
+			return 1;
+		}
+	}
+
+	cl_radio_on_start(cl_hw);
+
+	return 0;
+}
+
+void cl_radio_off_chip(struct cl_chip *chip)
+{
+	if (cl_chip_is_tcv0_enabled(chip))
+		cl_radio_off(chip->cl_hw_tcv0);
+
+	if (cl_chip_is_tcv1_enabled(chip))
+		cl_radio_off(chip->cl_hw_tcv1);
+}
+
+void cl_radio_on_chip(struct cl_chip *chip)
+{
+	if (cl_chip_is_tcv0_enabled(chip))
+		cl_radio_on(chip->cl_hw_tcv0);
+
+	if (cl_chip_is_tcv1_enabled(chip))
+		cl_radio_on(chip->cl_hw_tcv1);
+}
+
+bool cl_radio_is_off(struct cl_hw *cl_hw)
+{
+	return cl_hw->radio_status == RADIO_STATUS_OFF;
+}
+
+bool cl_radio_is_on(struct cl_hw *cl_hw)
+{
+	return cl_hw->radio_status == RADIO_STATUS_ON;
+}
+
+bool cl_radio_is_going_down(struct cl_hw *cl_hw)
+{
+	return cl_hw->radio_status == RADIO_STATUS_GOING_DOWN;
+}
+
+void cl_radio_off_wake_up(struct cl_hw *cl_hw)
+{
+	wake_up(&cl_hw->radio_wait_queue);
+}
+
+static void cl_clk_init(struct cl_chip *chip)
+{
+	cmu_clk_en_set(chip, CMU_MAC_ALL_CLK_EN);
+
+	if (cl_chip_is_both_enabled(chip)) {
+		cmu_phy_0_clk_en_set(chip, CMU_PHY_0_APB_CLK_EN_BIT | CMU_PHY_0_MAIN_CLK_EN_BIT);
+		cmu_phy_1_clk_en_set(chip, CMU_PHY_1_APB_CLK_EN_BIT | CMU_PHY_1_MAIN_CLK_EN_BIT);
+
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+		modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv0, 1);
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 1);
+
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+		modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv1, 1);
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 1);
+
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+	} else if (cl_chip_is_tcv0_enabled(chip)) {
+		/* Even if only PHY0 is enabled we need to set CMU_PHY_1_MAIN_CLK_EN_BIT */
+		cmu_phy_0_clk_en_set(chip, CMU_PHY_0_APB_CLK_EN_BIT | CMU_PHY_0_MAIN_CLK_EN_BIT);
+		cmu_phy_1_clk_en_set(chip, CMU_PHY_1_MAIN_CLK_EN_BIT);
+
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+		modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv0, 1);
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 1);
+
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+	} else {
+		/* Even if only PHY1 is enabled we need to set CMU_PHY_0_MAIN_CLK_EN_BIT */
+		cmu_phy_0_clk_en_set(chip, CMU_PHY_0_MAIN_CLK_EN_BIT);
+		cmu_phy_1_clk_en_set(chip, CMU_PHY_1_APB_CLK_EN_BIT | CMU_PHY_1_MAIN_CLK_EN_BIT);
+
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+		modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv1, 1);
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 1);
+
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+	}
+}
+
+static int cl_pll1_init(struct cl_chip *chip)
+{
+	int retry = 0;
+
+	/* Verify pll is locked */
+	while (!cmu_pll_1_stat_pll_lock_getf(chip) && (++retry < 10)) {
+		cl_dbg_chip_verbose(chip, "retry=%d\n", retry);
+		usleep_range(100, 200);
+	}
+
+	/* Pll is not locked - fatal error */
+	if (retry == 10) {
+		cl_dbg_chip_err(chip, "retry limit reached - pll1 is not locked !!!\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cl_cmu_init(struct cl_chip *chip)
+{
+	int ret = 0;
+
+	if (IS_REAL_PHY(chip)) {
+		ret = cl_pll1_init(chip);
+		if (ret)
+			return ret;
+	}
+
+	/* Set gl_mux_sel bit to work with pll1 instead of crystal */
+	cmu_control_gl_mux_sel_setf(chip, 1);
+
+	if (cl_chip_is_both_enabled(chip)) {
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+		cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+		cmu_phy_0_rst_set(chip, 0x0);
+		cmu_phy_1_rst_set(chip, 0x0);
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+		cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+	} else if (cl_chip_is_tcv0_enabled(chip)) {
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+		cmu_phy_0_rst_set(chip, 0x0);
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+	} else {
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+		cmu_phy_1_rst_set(chip, 0x0);
+		cmu_rst_n_ricurst_setf(chip, 1);
+		cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+	}
+
+	return ret;
+}
+
+static void cl_riu_clk_bw_init(struct cl_hw *cl_hw)
+{
+	u32 regval;
+
+	if (!cl_hw)
+		return;
+
+	switch (cl_hw->conf->ci_cap_bandwidth) {
+	case CHNL_BW_20:
+		regval = 0x00000100;
+		break;
+	case CHNL_BW_40:
+		regval = 0x00000555;
+		break;
+	case CHNL_BW_160:
+		regval = 0x00000dff;
+		break;
+	case CHNL_BW_80:
+	default:
+		regval = 0x000009aa;
+		break;
+	}
+
+	/* Set RIU modules clock BW */
+	modem_gcu_riu_clk_bw_set(cl_hw, regval);
+}
+
+static int cl_load_riu_rsf_memory(struct cl_chip *chip, const char *filename)
+{
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	char *buf = NULL;
+	loff_t size, i = 0;
+	int ret = 0;
+
+	size = cl_file_open_and_read(chip, filename, &buf);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (size > RIU_RSF_FILE_SIZE) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	/* Enable re-sampling filter init. */
+	riu_rsf_control_rsf_init_en_setf(cl_hw_tcv0, 0x1);
+	if (cl_hw_tcv1)
+		riu_rsf_control_rsf_init_en_setf(cl_hw_tcv1, 0x1);
+
+	while (i < size) {
+		riu_rsf_init_set(cl_hw_tcv0, *(u32 *)&buf[i]);
+		if (cl_hw_tcv1)
+			riu_rsf_init_set(cl_hw_tcv1, *(u32 *)&buf[i]);
+		i += 4;
+	}
+
+out:
+	kfree(buf);
+	return ret;
+}
+
+static int cl_load_riu_rsf_memory_recovery(struct cl_hw *cl_hw, const char *filename)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	char *buf = NULL;
+	loff_t size, i = 0;
+	int ret = 0;
+
+	size = cl_file_open_and_read(chip, filename, &buf);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (size > RIU_RSF_FILE_SIZE) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	/* Enable re-sampling filter init. */
+	riu_rsf_control_rsf_init_en_setf(cl_hw, 0x1);
+
+	while (i < size) {
+		riu_rsf_init_set(cl_hw, *(u32 *)&buf[i]);
+		i += 4;
+	}
+
+out:
+	kfree(buf);
+	return ret;
+}
+
+static int cl_load_agc_data(struct cl_hw *cl_hw, const char *filename)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	char *buf = NULL;
+	loff_t size, i = 0;
+
+	size = cl_file_open_and_read(chip, filename, &buf);
+
+	if (!buf)
+		return -ENOMEM;
+
+	/* Enable AGC FSM ram init state */
+	riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(cl_hw, 0x1);
+	/* Start writing the firmware from WPTR=0 */
+	riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_setf(cl_hw, 0x0);
+	/* Allow WPTR register to be writable */
+	riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_set_setf(cl_hw, 0x1);
+	/* Enable auto increment WPTR by 1 upon any write */
+	riu_agcfsm_ram_init_1_agc_fsm_ram_init_ainc_1_setf(cl_hw, 0x1);
+
+	while (i < size) {
+		riu_agcfsm_ram_init_2_set(cl_hw, *(u32 *)&buf[i]);
+		i += 4;
+	}
+
+	/* Disable AGC FSM ram init state */
+	riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(cl_hw, 0x0);
+
+	kfree(buf);
+
+	return 0;
+}
+
+static int cl_load_agc_fw(struct cl_hw *cl_hw, const char *filename)
+{
+	int ret = 0;
+
+	if (!cl_hw)
+		goto out;
+
+	/* Switch AGC to programming mode */
+
+	/* Disable RIU Modules clocks (RC,LB,ModemB,FE,ADC,Regs,AGC,Radar) */
+	modem_gcu_riu_clk_set(cl_hw, 0);
+
+	/* Switch AGC MEM clock to 480MHz */
+	modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(cl_hw, 3);
+
+	/* Enable RIU Modules clocks (RC,LB,ModemB,FE,ADC,Regs,AGC,Radar) */
+	modem_gcu_riu_clk_set(cl_hw, 0xFFFFFFFF);
+
+	/* Assert AGC FSM reset */
+	riu_rwnxagccntl_agcfsmreset_setf(cl_hw, 1);
+
+	/* Load AGC RAM data */
+	ret = cl_load_agc_data(cl_hw, filename);
+	if (ret)
+		goto out;
+
+	/* Switch AGC back to operational mode */
+
+	/* Disable RIU Modules clocks (RC, LB, ModemB, FE, ADC, Regs, AGC, Radar) */
+	modem_gcu_riu_clk_set(cl_hw, 0);
+	/* Switch AGC MEM clock back to 80M */
+	modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(cl_hw, 1);
+	/* Enable RIU Modules clocks (RC, LB, ModemB, FE, ADC, Regs, AGC, Radar) */
+	modem_gcu_riu_clk_set(cl_hw, 0xFFFFFFFF);
+
+	/* Release AGC FSM reset */
+	riu_rwnxagccntl_agcfsmreset_setf(cl_hw, 0);
+
+out:
+	return ret;
+}
+
+int cl_radio_boot(struct cl_chip *chip)
+{
+	int ret = 0;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	bool tcv0_enabled = cl_chip_is_tcv0_enabled(chip);
+	bool tcv1_enabled = cl_chip_is_tcv1_enabled(chip);
+
+	/* Call only once per chip after ASIC reset - configure both phys */
+	ret = cl_cmu_init(chip);
+	if (ret != 0)
+		goto out;
+
+	cl_clk_init(chip);
+	cmu_phase_sel_set(chip, (CMU_GP_CLK_PHASE_SEL_BIT |
+				 CMU_DAC_CDB_CLK_PHASE_SEL_BIT |
+				 CMU_DAC_CLK_PHASE_SEL_BIT) &
+				 ~(CMU_ADC_CDB_CLK_PHASE_SEL_BIT |
+				 CMU_ADC_CLK_PHASE_SEL_BIT));
+
+	if (tcv0_enabled) {
+		mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw_tcv0, 1); /* Disable MPIF clock */
+		mac_hw_state_cntrl_next_state_setf(cl_hw_tcv0, 2);        /* Move to doze */
+	}
+
+	if (tcv1_enabled) {
+		mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw_tcv1, 1); /* Disable MPIF clock */
+		mac_hw_state_cntrl_next_state_setf(cl_hw_tcv1, 2);        /* Move to doze */
+	}
+
+	/* Enable all PHY modules */
+	cl_phy_enable(cl_hw_tcv0);
+	cl_phy_enable(cl_hw_tcv1);
+
+	if (tcv0_enabled) {
+		mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw_tcv0, 1); /* Exit from doze */
+		mac_hw_state_cntrl_next_state_setf(cl_hw_tcv0, 0);  /* Move to idle */
+	}
+
+	if (tcv1_enabled) {
+		mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw_tcv1, 1); /* Exit from doze */
+		mac_hw_state_cntrl_next_state_setf(cl_hw_tcv1, 0);  /* Move to idle */
+	}
+
+	cl_riu_clk_bw_init(cl_hw_tcv0);
+	cl_riu_clk_bw_init(cl_hw_tcv1);
+
+	/* Load RIU re-sampling filter memory with coefficients */
+	ret = cl_load_riu_rsf_memory(chip, "riu_rsf.bin");
+	if (ret != 0) {
+		pr_err("cl_load_riu_rsf_memory failed with error code %d.\n", ret);
+		goto out;
+	}
+
+	/* Load AGC FW */
+	ret = cl_load_agc_fw(cl_hw_tcv0, "agcram.bin");
+	if (ret) {
+		pr_err("cl_load_agc_fw failed for tcv0 with error code %d.\n", ret);
+		goto out;
+	}
+
+	ret = cl_load_agc_fw(cl_hw_tcv1, "agcram.bin");
+	if (ret) {
+		pr_err("cl_load_agc_fw failed for tcv1 with error code %d.\n", ret);
+		goto out;
+	}
+
+	/* AFE Registers configuration */
+	ret = cl_afe_cfg(chip);
+
+out:
+	return ret;
+}
+
+static void cl_restore_ela_state(struct cl_hw *cl_hw)
+{
+	struct cl_recovery_db *recovery_db = &cl_hw->recovery_db;
+
+	/* Restore eLA state after MAC-HW reset */
+	if (recovery_db->ela_en) {
+		mac_hw_debug_port_sel_a_set(cl_hw, recovery_db->ela_sel_a);
+		mac_hw_debug_port_sel_b_set(cl_hw, recovery_db->ela_sel_b);
+		mac_hw_debug_port_sel_c_set(cl_hw, recovery_db->ela_sel_c);
+	}
+
+	mac_hw_debug_port_en_set(cl_hw, recovery_db->ela_en);
+}
+
+int cl_radio_boot_recovery(struct cl_hw *cl_hw)
+{
+	int ret = 0;
+
+	mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw, 1); /* Disable MPIF clock */
+	mac_hw_state_cntrl_next_state_setf(cl_hw, 2);        /* Move to doze */
+
+	/* Enable all PHY modules */
+	cl_phy_enable(cl_hw);
+
+	/* Restart LCU recording */
+	if (cl_hw_is_tcv0(cl_hw))
+		lcu_phy_lcu_ch_0_stop_set(cl_hw, 0);
+	else
+		lcu_phy_lcu_ch_1_stop_set(cl_hw, 0);
+
+	cl_restore_ela_state(cl_hw);
+
+	mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw, 1); /* Exit from doze */
+	mac_hw_state_cntrl_next_state_setf(cl_hw, 0);  /* Move to idle */
+
+	cl_riu_clk_bw_init(cl_hw);
+
+	/* Load RIU re-sampling filter memory with coefficients */
+	ret = cl_load_riu_rsf_memory_recovery(cl_hw, "riu_rsf.bin");
+	if (ret != 0) {
+		pr_err("cl_load_riu_rsf_memory failed with error code %d.\n", ret);
+		goto out;
+	}
+
+	/* Load AGC FW */
+	ret = cl_load_agc_fw(cl_hw, "agcram.bin");
+	if (ret) {
+		pr_err("cl_load_agc_fw failed for with error code %d.\n", ret);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+#define NOISE_MAX_ANT_PER_REG 4
+
+void cl_noise_init(struct cl_hw *cl_hw)
+{
+	struct cl_noise_db *noise_db = &cl_hw->noise_db;
+
+	INIT_LIST_HEAD(&noise_db->reg_list);
+}
+
+void cl_noise_close(struct cl_hw *cl_hw)
+{
+	struct cl_noise_db *noise_db = &cl_hw->noise_db;
+	struct cl_noise_reg *elem = NULL;
+	struct cl_noise_reg *tmp = NULL;
+
+	list_for_each_entry_safe(elem, tmp, &noise_db->reg_list, list) {
+		list_del(&elem->list);
+		kfree(elem);
+	}
+}
+
+void cl_noise_maintenance(struct cl_hw *cl_hw)
+{
+	struct cl_noise_db *noise_db = &cl_hw->noise_db;
+	struct cl_noise_reg *reg = NULL;
+	u8 ch_bw = cl_hw->bw;
+
+	if (noise_db->sample_cnt == 0)
+		return;
+
+	reg = kzalloc(sizeof(*reg), GFP_ATOMIC);
+
+	if (!reg)
+		return;
+
+	/*collect statistics */
+	reg->np_prim20_per_ant = riu_agcinbdpow_20_pnoisestat_get(cl_hw);
+	reg->np_sub20_per_chn = riu_agcinbdpownoiseper_20_stat_0_get(cl_hw);
+	reg->np_sec20_dens_per_ant = riu_agcinbdpowsecnoisestat_get(cl_hw);
+	reg->nasp_prim20_per_ant = riu_inbdpowformac_0_get(cl_hw);
+	reg->nasp_sub20_per_chn = riu_inbdpowformac_3_get(cl_hw);
+	reg->nasp_sec20_dens_per_ant = riu_inbdpowformac_2_get(cl_hw);
+
+	if (ch_bw == CHNL_BW_160) {
+		reg->np_sub20_per_chn2 = riu_agcinbdpownoiseper_20_stat_1_get(cl_hw);
+		reg->nasp_sub20_per_chn2 = riu_inbdpowformac_4_get(cl_hw);
+	}
+
+	if (cl_hw->num_antennas > NOISE_MAX_ANT_PER_REG) {
+		reg->np_prim20_per_ant2 = riu_agcinbdpow_20_pnoisestat_2_get(cl_hw);
+		reg->nasp_prim20_per_ant2 = riu_inbdpowformac_1_get(cl_hw);
+	}
+
+	list_add(&reg->list, &noise_db->reg_list);
+
+	noise_db->sample_cnt--;
+
+	if (noise_db->sample_cnt == 0)
+		pr_debug("record done\n");
+}
+
+/** DOC: RSSI tracking
+ *
+ * RSSI values of association packets (request in AP mode and respone in STA mode)
+ * are not added to rssi pool sample, because at this stage station is not added
+ * to driver database.
+ * RSSI of association is important for WRS in order to select its initial rate.
+ * The goal of this code is to save MAC address and RSSI values of all association
+ * packets, and after station fully connects, search for the correct RSSI and add
+ * it to the rssi pool sample.
+ */
+struct assoc_queue_elem {
+	struct list_head list;
+	u8 addr[ETH_ALEN];
+	s8 rssi[MAX_ANTENNAS];
+	unsigned long timestamp;
+};
+
+#define CL_RSSI_LIFETIME_MS 5000
+
+static void cl_rssi_add_to_wrs(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS])
+{
+	struct cl_wrs_rssi *wrs_rssi = &cl_sta->wrs_rssi;
+	int i = 0;
+
+	for (i = 0; i < cl_hw->num_antennas; i++)
+		wrs_rssi->sum[i] += rssi[i];
+
+	wrs_rssi->cnt++;
+}
+
+void cl_rssi_assoc_init(struct cl_hw *cl_hw)
+{
+	INIT_LIST_HEAD(&cl_hw->assoc_queue.list);
+	spin_lock_init(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_assoc_exit(struct cl_hw *cl_hw)
+{
+	/* Delete all remaining elements in list */
+	spin_lock_bh(&cl_hw->assoc_queue.lock);
+
+	if (!list_empty(&cl_hw->assoc_queue.list)) {
+		struct assoc_queue_elem *elem = NULL;
+		struct assoc_queue_elem *tmp = NULL;
+
+		list_for_each_entry_safe(elem, tmp, &cl_hw->assoc_queue.list, list) {
+			list_del(&elem->list);
+			kfree(elem);
+		}
+	}
+
+	spin_unlock_bh(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_assoc_handle(struct cl_hw *cl_hw, u8 *mac_addr, struct hw_rxhdr *rxhdr)
+{
+	/* Allocate new element and add to list */
+	struct assoc_queue_elem *elem = kmalloc(sizeof(*elem), GFP_ATOMIC);
+
+	if (elem) {
+		INIT_LIST_HEAD(&elem->list);
+		cl_mac_addr_copy(elem->addr, mac_addr);
+
+		elem->rssi[0] = (s8)rxhdr->rssi1;
+		elem->rssi[1] = (s8)rxhdr->rssi2;
+		elem->rssi[2] = (s8)rxhdr->rssi3;
+		elem->rssi[3] = (s8)rxhdr->rssi4;
+		elem->rssi[4] = (s8)rxhdr->rssi5;
+		elem->rssi[5] = (s8)rxhdr->rssi6;
+
+		elem->timestamp = jiffies;
+
+		spin_lock(&cl_hw->assoc_queue.lock);
+		list_add(&elem->list, &cl_hw->assoc_queue.list);
+		spin_unlock(&cl_hw->assoc_queue.lock);
+	}
+}
+
+void cl_rssi_assoc_find(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 num_sta)
+{
+	/* Search for rssi of association according to mac address */
+	spin_lock_bh(&cl_hw->assoc_queue.lock);
+
+	if (!list_empty(&cl_hw->assoc_queue.list)) {
+		unsigned long lifetime = 0;
+		struct assoc_queue_elem *elem = NULL;
+		struct assoc_queue_elem *tmp = NULL;
+
+		list_for_each_entry_safe(elem, tmp, &cl_hw->assoc_queue.list, list) {
+			lifetime = jiffies_to_msecs(jiffies - elem->timestamp);
+
+			/* Check lifetime of rssi before using it */
+			if (lifetime > CL_RSSI_LIFETIME_MS) {
+				/* Delete element from list */
+				list_del(&elem->list);
+				kfree(elem);
+				continue;
+			}
+
+			if (ether_addr_equal(elem->addr, cl_sta->addr)) {
+				struct hw_rxhdr rxhdr;
+				s8 equivalent_rssi = cl_rssi_calc_equivalent(cl_hw, elem->rssi);
+
+				rxhdr.rssi1 = elem->rssi[0];
+				rxhdr.rssi2 = elem->rssi[1];
+				rxhdr.rssi3 = elem->rssi[2];
+				rxhdr.rssi4 = elem->rssi[3];
+				rxhdr.rssi5 = elem->rssi[4];
+				rxhdr.rssi6 = elem->rssi[5];
+
+				cl_rssi_rx_handler(cl_hw, cl_sta, &rxhdr, equivalent_rssi);
+
+				/* Delete element from list */
+				list_del(&elem->list);
+				kfree(elem);
+			}
+		}
+	}
+
+	spin_unlock_bh(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_sort_descending(s8 rssi[MAX_ANTENNAS], u8 num_ant)
+{
+	int i, j;
+
+	for (i = 0; i < num_ant - 1; i++)
+		for (j = 0; j < num_ant - i - 1; j++)
+			if (rssi[j] < rssi[j + 1])
+				swap(rssi[j], rssi[j + 1]);
+}
+
+static s8 cl_rssi_equivalent_2_phys(s8 rssi_max, s8 rssi_min)
+{
+	s8 rssi_diff = rssi_min - rssi_max;
+
+	if (rssi_diff > (-2))
+		return (rssi_max + 3);
+	else if (rssi_diff > (-5))
+		return (rssi_max + 2);
+	else if (rssi_diff > (-9))
+		return (rssi_max + 1);
+	else
+		return rssi_max;
+}
+
+s8 cl_rssi_calc_equivalent(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS])
+{
+	s8 rssi_tmp[MAX_ANTENNAS] = {0};
+	u8 rx_ant = cl_hw->num_antennas;
+	int i, j;
+
+	/* Copy to rssi_tmp */
+	memcpy(rssi_tmp, rssi, rx_ant);
+
+	/* Sort the rssi's in desceding order */
+	cl_rssi_sort_descending(rssi_tmp, rx_ant);
+
+	/*
+	 * 1) Calc equivalent rssi between the two lowest values.
+	 * 2) Sort again
+	 * 3) Repeat steps 1 and 2 according to number of antennas.
+	 */
+	for (i = 0; i < rx_ant - 1; i++) {
+		rssi_tmp[rx_ant - i - 2] = cl_rssi_equivalent_2_phys(rssi_tmp[rx_ant - i - 2],
+								     rssi_tmp[rx_ant - i - 1]);
+
+		for (j = rx_ant - i - 2; j > 0; j--) {
+			if (rssi_tmp[j] > rssi_tmp[j - 1])
+				swap(rssi_tmp[j], rssi_tmp[j - 1]);
+			else
+				break;
+		}
+	}
+
+	return rssi_tmp[0];
+}
+
+s8 cl_rssi_get_strongest(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS])
+{
+	int i;
+	s8 strongest_rssi = S8_MIN;
+
+	for (i = 0; i < cl_hw->num_antennas; i++) {
+		if (rssi[i] > strongest_rssi)
+			strongest_rssi = rssi[i];
+	}
+
+	return strongest_rssi;
+}
+
+static void cl_update_sta_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       s8 rssi[MAX_ANTENNAS], s8 equivalent_rssi)
+{
+	/* Last RSSI */
+	memcpy(cl_sta->last_rssi, rssi, cl_hw->num_antennas);
+
+	if (cl_sta->manual_alpha_rssi)
+		return;
+
+	/* Alpha RSSI - use alpha filter (87.5% current + 12.5% new) */
+	if (cl_sta->alpha_rssi)
+		cl_sta->alpha_rssi =
+			((cl_sta->alpha_rssi << 3) - cl_sta->alpha_rssi + equivalent_rssi) >> 3;
+	else
+		cl_sta->alpha_rssi = equivalent_rssi;
+}
+
+static bool cl_rssi_is_valid_ru_type_factor(u8 ru_type)
+{
+	return (ru_type >= CL_MU_OFDMA_RU_TYPE_26 && ru_type <= CL_MU_OFDMA_RU_TYPE_106);
+}
+
+static void cl_rssi_agg_ind_rssi_values_fill(struct cl_hw *cl_hw,
+					     struct cl_agg_tx_report *agg_report,
+					     s8 *rssi_buf)
+{
+	/* Fill the rssi buffer with the correct rssi values */
+	switch (cl_hw->first_riu_chain) {
+	case 0:
+		rssi_buf[0] = agg_report->rssi1;
+		rssi_buf[1] = agg_report->rssi2;
+		rssi_buf[2] = agg_report->rssi3;
+		rssi_buf[3] = agg_report->rssi4;
+		rssi_buf[4] = agg_report->rssi5;
+		rssi_buf[5] = agg_report->rssi6;
+		break;
+	case 1:
+		rssi_buf[0] = agg_report->rssi2;
+		rssi_buf[1] = agg_report->rssi3;
+		rssi_buf[2] = agg_report->rssi4;
+		rssi_buf[3] = agg_report->rssi5;
+		rssi_buf[4] = agg_report->rssi6;
+		break;
+	case 2:
+		rssi_buf[0] = agg_report->rssi3;
+		rssi_buf[1] = agg_report->rssi4;
+		rssi_buf[2] = agg_report->rssi5;
+		rssi_buf[3] = agg_report->rssi6;
+		break;
+	case 3:
+		rssi_buf[0] = agg_report->rssi4;
+		rssi_buf[1] = agg_report->rssi5;
+		rssi_buf[2] = agg_report->rssi6;
+		break;
+	case 4:
+		rssi_buf[0] = agg_report->rssi5;
+		rssi_buf[1] = agg_report->rssi6;
+		break;
+	case 5:
+		rssi_buf[0] = agg_report->rssi6;
+		break;
+	default:
+		break;
+	}
+}
+
+void cl_rssi_block_ack_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct cl_agg_tx_report *agg_report)
+{
+	/* Handle RSSI of block-ack's */
+	union cl_rate_ctrl_info rate_ctrl_info = {
+		.word = le32_to_cpu(agg_report->rate_cntrl_info)};
+	u8 bw = rate_ctrl_info.field.bw;
+
+	s8 rssi[MAX_ANTENNAS];
+	s8 equivalent_rssi;
+	int i;
+
+	cl_rssi_agg_ind_rssi_values_fill(cl_hw, agg_report, rssi);
+
+	if (cl_hw->rssi_simulate)
+		for (i = 0; i < cl_hw->num_antennas; i++)
+			rssi[i] = cl_hw->rssi_simulate;
+
+	if (!cl_hw->rssi_simulate) {
+		union cl_rate_ctrl_info_he rate_ctrl_info_he = {
+			.word = le32_to_cpu(agg_report->rate_cntrl_info_he)};
+		u8 ru_type = rate_ctrl_info_he.field.ru_type;
+		u8 format_mode = rate_ctrl_info.field.format_mod;
+		s8 bw_factor = 0;
+
+		/*
+		 * RSSI adjustment according to BW
+		 * The BA is transmitted in the BW of the aggregation it acknowledges
+		 */
+		if (format_mode == FORMATMOD_HE_MU &&
+		    cl_rssi_is_valid_ru_type_factor(ru_type)) {
+			if (ru_type == CL_MU_OFDMA_RU_TYPE_26)
+				bw_factor = -9;
+			else if (ru_type == CL_MU_OFDMA_RU_TYPE_52)
+				bw_factor = -6;
+			else if (ru_type == CL_MU_OFDMA_RU_TYPE_106)
+				bw_factor = -3;
+		} else {
+			if (bw == CHNL_BW_160)
+				bw_factor = 9;
+			else if (bw == CHNL_BW_80)
+				bw_factor = 6;
+			else if (bw == CHNL_BW_40)
+				bw_factor = 3;
+		}
+
+		for (i = 0; i < cl_hw->num_antennas; i++)
+			rssi[i] += bw_factor;
+	}
+
+	equivalent_rssi = cl_rssi_calc_equivalent(cl_hw, rssi);
+
+	/* Handle RSSI after BW adjustment */
+	cl_rssi_add_to_wrs(cl_hw, cl_sta, rssi);
+	cl_stats_update_rx_rssi(cl_hw, cl_sta, rssi);
+	cl_vns_handle_rssi(cl_hw, cl_sta, rssi);
+	cl_update_sta_rssi(cl_hw, cl_sta, rssi, equivalent_rssi);
+	cl_motion_sense_rssi_ba(cl_hw, cl_sta, rssi);
+}
+
+void cl_rssi_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			struct hw_rxhdr *rxhdr, s8 equivalent_rssi)
+{
+	/* Called after BW adjustment */
+	s8 rssi[MAX_ANTENNAS] = RX_HDR_RSSI(rxhdr);
+
+	if (!IS_REAL_PHY(cl_hw->chip) && rssi[0] == 0)
+		return;
+
+	cl_rssi_add_to_wrs(cl_hw, cl_sta, rssi);
+	cl_stats_update_rx_rssi(cl_hw, cl_sta, rssi);
+	cl_vns_handle_rssi(cl_hw, cl_sta, rssi);
+	cl_update_sta_rssi(cl_hw, cl_sta, rssi, equivalent_rssi);
+}
+
+void cl_rssi_bw_adjust(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr, s8 bw_factor)
+{
+	if (cl_hw->rssi_simulate)
+		return;
+
+	rxhdr->rssi1 += bw_factor;
+	rxhdr->rssi2 += bw_factor;
+	rxhdr->rssi3 += bw_factor;
+	rxhdr->rssi4 += bw_factor;
+	rxhdr->rssi5 += bw_factor;
+	rxhdr->rssi6 += bw_factor;
+}
+
+void cl_rssi_simulate(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr)
+{
+	rxhdr->rssi1 = cl_hw->rssi_simulate;
+	rxhdr->rssi2 = cl_hw->rssi_simulate;
+	rxhdr->rssi3 = cl_hw->rssi_simulate;
+	rxhdr->rssi4 = cl_hw->rssi_simulate;
+	rxhdr->rssi5 = cl_hw->rssi_simulate;
+	rxhdr->rssi6 = cl_hw->rssi_simulate;
+}
+
+#define CCA_CNT_RATE_40MHZ    3
+
+static void cl_cca_reset_phy_counters(struct cl_hw *cl_hw)
+{
+	riu_rwnxagccca_1_cca_cnt_clear_setf(cl_hw, 1);
+	riu_rwnxagccca_1_cca_cnt_clear_setf(cl_hw, 0);
+}
+
+void cl_cca_init(struct cl_hw *cl_hw)
+{
+	/* Set PHY registers rate */
+	riu_rwnxagccca_1_cca_cnt_rate_setf(cl_hw, CCA_CNT_RATE_40MHZ);
+}
+
+void cl_cca_maintenance(struct cl_hw *cl_hw)
+{
+	struct cl_cca_db *cca_db = &cl_hw->cca_db;
+	unsigned long time = jiffies_to_usecs(jiffies);
+	unsigned long diff_time = time - cca_db->time;
+
+	cca_db->time = time;
+	if (!diff_time)
+		return;
+
+	/* Rest PHY counters */
+	cl_cca_reset_phy_counters(cl_hw);
+}
+
+void cl_prot_mode_init(struct cl_hw *cl_hw)
+{
+	struct cl_prot_mode *prot_mode = &cl_hw->prot_mode;
+	u8 init = cl_hw->conf->ce_prot_mode;
+
+	prot_mode->current_val = init;
+	prot_mode->default_val = init;
+	prot_mode->dynamic_val = (init != TXL_NO_PROT) ? init : TXL_PROT_RTS_FW;
+}
+
+void cl_prot_mode_set(struct cl_hw *cl_hw, u8 prot_mode_new)
+{
+	struct cl_prot_mode *prot_mode = &cl_hw->prot_mode;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	if (prot_mode->current_val != prot_mode_new) {
+		prot_mode->current_val = prot_mode_new;
+		cl_msg_tx_prot_mode(cl_hw,
+				    conf->ce_prot_log_nav_en,
+				    prot_mode_new,
+				    conf->ce_prot_rate_format,
+				    conf->ce_prot_rate_mcs,
+				    conf->ce_prot_rate_pre_type);
+	}
+}
+
+u8 cl_prot_mode_get(struct cl_hw *cl_hw)
+{
+	return cl_hw->prot_mode.current_val;
+}
+
+static u8 conv_to_fw_ac[EDCA_AC_MAX] = {
+	[EDCA_AC_BE] = AC_BE,
+	[EDCA_AC_BK] = AC_BK,
+	[EDCA_AC_VI] = AC_VI,
+	[EDCA_AC_VO] = AC_VO
+};
+
+static const char *edca_ac_str[EDCA_AC_MAX] = {
+	[EDCA_AC_BE] = "BE",
+	[EDCA_AC_BK] = "BK",
+	[EDCA_AC_VI] = "VI",
+	[EDCA_AC_VO] = "VO",
+};
+
+void cl_edca_hw_conf(struct cl_hw *cl_hw)
+{
+	u8 ac = 0;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		struct edca_params params = {
+			.aifsn = conf->ce_wmm_aifsn[ac],
+			.cw_min = conf->ce_wmm_cwmin[ac],
+			.cw_max = conf->ce_wmm_cwmax[ac],
+			.txop = conf->ce_wmm_txop[ac]
+		};
+
+		cl_edca_set(cl_hw, ac, &params, NULL);
+	}
+}
+
+void cl_edca_set(struct cl_hw *cl_hw, u8 ac, struct edca_params *params,
+		 struct ieee80211_he_mu_edca_param_ac_rec *mu_edca)
+{
+	u32 edca_reg_val = 0;
+
+	if (ac >= AC_MAX) {
+		pr_err("%s: Invalid AC index\n", __func__);
+		return;
+	}
+
+	edca_reg_val  = (u32)(params->aifsn);
+	edca_reg_val |= (u32)(params->cw_min << 4);
+	edca_reg_val |= (u32)(params->cw_max << 8);
+	edca_reg_val |= (u32)(params->txop << 12);
+
+	memcpy(&cl_hw->edca_db.hw_params[ac], params, sizeof(struct edca_params));
+
+	cl_msg_tx_set_edca(cl_hw, conv_to_fw_ac[ac], edca_reg_val, mu_edca);
+
+	cl_dbg_trace(cl_hw, "EDCA-%s: aifsn=%u, cw_min=%u, cw_max=%u, txop=%u\n",
+		     edca_ac_str[ac], params->aifsn, params->cw_min,
+		     params->cw_max, params->txop);
+}
+
+void cl_edca_recovery(struct cl_hw *cl_hw)
+{
+	u8 ac;
+
+	for (ac = 0; ac < AC_MAX; ac++)
+		cl_edca_set(cl_hw, ac, &cl_hw->edca_db.hw_params[ac], NULL);
+}
+
-- 
2.36.1

