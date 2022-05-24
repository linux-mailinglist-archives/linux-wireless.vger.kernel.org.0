Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E0532975
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiEXLkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiEXLkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56652E53
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo0EvKniGP4CGTQHW2wtoRhO0Jnk93X7d85BlomoAPXOs16Fq4lu547w+naWjUm1QHRb9wcRINxYXbnIGsbjv0cBSelyz2jVxf7asrVecjg4Vt0tFznDpcGuiMkR8mQIIYWJgEiZPxlXgXjU5tUGWb5F2CxTaZ6s8kswrs2uAenrZVD1knbBS39sJom5w5u/vYYost4CGP0YJUkBvDTUP6KVHid0e1EKNg+weENDV6uTax3R4IUlw+JBRc1MTtSZmO3Aj42Er0t6oKY3jFHEk0SOhrrBlnfRVOv0MNHe4YLMb0sJuIFbksW2nOLfF3tWnLoHqykYivjXE42wJX024g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NKkNFUnzF4NBOR/kll86ViWsMGlbf5FYlK9A+AVYl0=;
 b=GyqMQuge2uTtmNV6gLBD90F9AvrnyVdWvGRqyGPv4+oBjaRMa1iyT6n2tMHU3RqMTXiO3ZZq2In88bN2n44DowN5T74RdkwxVrevaZVhRLcHJUnG01pmjq67ABpeVt5HmNRDIc2P3c5kWfV28okxYOK23iC+jrv79n3rYQ82xlEM0VFP0sSHI6QmU249vML0LEH0jK854Gfbnf2L6APdwctWonXuoCCUkli9O9iMeKm2+YnNgcfWwOE2rI4SeuI70qNIESTlvctl5P9hK38//BRu5K0Hquo0vJK8DG9TJudUD23l2S2AuY0zD3l9+0Cp2ORDTEwB/BkoaT5Uir+VMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NKkNFUnzF4NBOR/kll86ViWsMGlbf5FYlK9A+AVYl0=;
 b=AneTBnVw4DBov0k78wMCWJ8cJ0iSzxkth19wexQs6MplMJeGFAT+2nRV73HS0837kyV6uJlUoF6E5hW8zEycPextGGRr+G+VCUwa0Q5FDV0hxz9ZlcuViDGA2YLYDKe9f01jbnzbwKX61NP1ajGFC+C5as13/124cQhD3CaVt1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:26 +0000
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
Subject: [RFC v2 70/96] cl8k: add scan.c
Date:   Tue, 24 May 2022 14:34:36 +0300
Message-Id: <20220524113502.1094459-71-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 553d6de1-df54-4ee7-b1f3-08da3d79f654
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915FFFB4D10F12660A7EBE9F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOxkJSLcbLocB9PEZcQ4R4l9y6jjtKIONRIiWp7dejMKKsz2ayh7kLaskpNjrkZKkzTIbF98htNvI2x0gyYiFDwZvla2NGdkRg8UaRqYMX4GOrcSzJYyWQjixdmc3TwR9oe4vktUL0hg+fxEABsEYhLUgrmQQ8RRHpt7TcCnI9hLErLWc7B+TBNLCPOnck7eyAZC7FUvhiYNES4GI4LI7e7KoFeQ4Kkd+OeyCclgZHua8yzUIEQu4WjuCxGUiFx305Qxo/A8NVGActDoCKwxUV6FTAlbCbv0Hqjd8yc/1MXOQIdj1lWHZ8yo5rxEa1LU/iwauz2tMjaRZpDuDZFxn+/ubNbZ4RQbc6PPh25IEROSO0qQ/0GHcIjk9eEj+QEwpdO/hUklhCYpD1TzAzWRAyfmrd4Vot6VIBdaESI8pVaSP3Kgqgfzlu3EjGdHRapsbh3CulWc2y0v8zoQlBd0uxqyK7xiUnBfVpMGumfVtK8heJXEX8542J7pyTSA4dysWXgpz0A8JahhmTKHd77E6l1kjw4QXuMB9Nu+8O6NcHDCtCjVcna2R3yQBNGI/aaeN56a1xGfoCFHYX3lE/SzXBZOT8GUfCn541KmuBOL65itb5uvs+Wqu3Zv7kvAiS8xUYp4T7X54zRnVoSy7g2BCYBPnbFjpNtHJkR8ERfFA1BDAbPxbb+QT68MiJUzCcJdKh9RY2bv9nzf1uB9q98Xl9xhabX1OdUlU54IJUvvnXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(45080400002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYMa5CzzcReSszsFsUuiCELcjttVbRGPrVEywnSya/ajoeyYA37WefJ2lP/g?=
 =?us-ascii?Q?RuUTBfPCY3xAxG/cCPbQikrGSbZWIc8j12F7T9p5LjyFuFOxVZnhZ5ITVD1C?=
 =?us-ascii?Q?Rhdzqqs5V/GGK9Fn/T7HnSnXF/F/UO52EGOOWm8wB17LxipjDwTwG1V9IRsB?=
 =?us-ascii?Q?oE0FNaf1pLN2NaU5g+1s/hlZwa4SK6LgAJujsHhVARKQPyPRkoSOdjreJ22I?=
 =?us-ascii?Q?xC0o2m9EU/xDyto/eHd7RTUp2cQhezExD9PQUc3L8u66Hn5/qAaO7MF4fFtE?=
 =?us-ascii?Q?QI2Q40pnSmAC0yJxWIFSkt83xpRjgLT7gF6HxQwNKqT1uuuOKscPmmTNmbLf?=
 =?us-ascii?Q?B/QnDVczJz/CHvQkjPkSeOrapFNotXx1wXiU0cqXeS0OQ5m1I+vvkJbiBj0m?=
 =?us-ascii?Q?AwkTe0UU5fMT8gI9GHsqk/DIanYCUUHECFWIqW1eO4fbiGpdco6h5gSSn2oT?=
 =?us-ascii?Q?aogaoBTd2yncJ2Ng0jFTh7Cg5/ApxPsuWoIzPgMrmBOz35jHDwOZ1No70G0h?=
 =?us-ascii?Q?k/DF7zq4rquJ4QF43PLDHfavd8IyOyBsVqj6hCgZXNwJXRK2dGPFeuoTeHmv?=
 =?us-ascii?Q?nqr3zQ2+mXL9oHMG4HPEEmZYyP6aKoCdk1oHLc9Znd6oyi4981yFbnF16ZOP?=
 =?us-ascii?Q?INr3kPCVn06eYhGhH6KMKtK6RnvC8Hv9meT1NcIxxeco6x435aBtCOTf04Jc?=
 =?us-ascii?Q?wHbT3XULIDnEj0XoFAx6chUHXz2TPjtIBarP9E5/tDKVYDlAvTRJkvIBReW4?=
 =?us-ascii?Q?AP3StPV8zZKU7TVws9x1eCFJ6Ts/VY0vpmPFcFO59ET6bqYL8WhUVC/G1x4g?=
 =?us-ascii?Q?PDJurI5P56+To/Ivm1Rf+P/yovJE3+HjycVOqgSJnRyi8hfI7rhCscbNH35W?=
 =?us-ascii?Q?oc4I0OLCfpkrOGTujbcVNU6fed2TfcfrptfXNuii7lc8h0ZxVCqAXHa66NfY?=
 =?us-ascii?Q?dNERhMMQMxuLSFYJPzJm30d8gM36WtWMATXF4rrTMyII68kFgPKtK9tycJM8?=
 =?us-ascii?Q?2bnh+bf9SBH38ZSTMT3sogUicOkXUiULyKXwKoyNRvBQ/FT0SCxqvIMDh9Tm?=
 =?us-ascii?Q?mYTNa+lNx9c+rwBtZvQPom+1QNX2oVdXj8HZ2PGEm0eDSOC1x/H6BNFIdXie?=
 =?us-ascii?Q?gDZci1wvLrpYuWPlXtzkrAT5OlJAvPopTNUAWkIjn58aDHfL+jJx4BP4apbe?=
 =?us-ascii?Q?/6j67z6KYmZN/pQF98WT+DkKMflNOlXD3A4co5TGBEDTglieWIYQ4TSY0yqT?=
 =?us-ascii?Q?ryRclJ8cQ1kAd9atEhLO3PfDlgGkFWkWmynC8bPnI1FBRvEYov52poH5bvnx?=
 =?us-ascii?Q?ZQJZVQ8e1BcDetw8Zs5x9d5kdsAR3C2Sc0sRN1B44GodJ+mEaNO9H2MNKZuQ?=
 =?us-ascii?Q?gnVQD5sKf7FKHc6S43fiyL6j+GHBC60Zky3ENkDwArJAO9um/3vFQPEO97SN?=
 =?us-ascii?Q?c+z8IpGm8rOIK+lYcr/cpryAdFBjn0Wu8vDcjJ41KibjWgjQ9/0hoInWWrl7?=
 =?us-ascii?Q?kdnLKzMpGyPs4KcIk+Wlv9p//bFYz/YjlZsMcnpXBtqmPxSR1B/km3A1OiVY?=
 =?us-ascii?Q?Vcvlwl8vliKy6xJliLeHf9ePPVUxyvXNAAFY70/dELrLeJcg1ezBQQv7aoUL?=
 =?us-ascii?Q?KTiUIXdxuB03kaTF3vJi+XkYznIpq4xRCW8owZsL/54JSQa42mIiai+cWPel?=
 =?us-ascii?Q?z1tw7K+dVWaLLozu/pKXYN5UQ76CFx0jxcg0sh/sWqOdNNYyZrRRktmkdRn1?=
 =?us-ascii?Q?MHHrx817heoqx+WjSGuYwIpOVYwkdG4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553d6de1-df54-4ee7-b1f3-08da3d79f654
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:46.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oleXYSTvYSojiks2TgKTFZfmxhjnzzsh/d7kImlzd9El5k7xkszFNhkbVp/CzD9PjeCCAOJWbSf1pix6hSxPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0915
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
 drivers/net/wireless/celeno/cl8k/scan.c | 392 ++++++++++++++++++++++++
 1 file changed, 392 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/scan.c

diff --git a/drivers/net/wireless/celeno/cl8k/scan.c b/drivers/net/wireless/celeno/cl8k/scan.c
new file mode 100644
index 000000000000..10076d93620e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/scan.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include "channel.h"
+#include "chip.h"
+#include "calib.h"
+#include "debug.h"
+#include "rates.h"
+#include "vif.h"
+#include "hw.h"
+#include "scan.h"
+
+#define CL_MIN_SCAN_TIME_MS 50
+#define CL_MIN_WAIT_TIME_MS 20
+
+static const char SCANNER_KTHREAD_NAME[] = "cl_scanner_kthread";
+
+int cl_scan_channel_switch(struct cl_hw *cl_hw, u8 channel, u8 bw,
+			   bool allow_recalib)
+{
+	struct cl_vif *cl_vif = cl_vif_get_first(cl_hw);
+	struct cfg80211_chan_def *chandef = NULL;
+	struct cfg80211_chan_def local_chandef;
+	struct ieee80211_channel *chan = NULL;
+	u16 freq = ieee80211_channel_to_frequency(channel, cl_hw->nl_band);
+	int ret = 0;
+
+	if (!cl_vif) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	chandef = &cl_vif->vif->bss_conf.chandef;
+	local_chandef = *chandef;
+
+	chan = ieee80211_get_channel(cl_hw->hw->wiphy, freq);
+	if (!chan) {
+		cl_dbg_err(cl_hw, "Channel %u wasn't found!\n", channel);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	local_chandef.chan = chan;
+	if (cl_chandef_calc(cl_hw, channel, bw,
+			    &local_chandef.width,
+			    &local_chandef.chan->center_freq,
+			    &local_chandef.center_freq1)) {
+		cl_dbg_err(cl_hw, "Failed to extract chandef data for ch:%d\n",
+			   channel);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	*chandef = local_chandef;
+	cl_hw->hw->conf.chandef = local_chandef;
+
+	if (cl_hw->chip->conf->ce_calib_runtime_en && allow_recalib)
+		ret = cl_calib_runtime_and_switch_channel(cl_hw, channel, bw,
+							  freq,
+							  chandef->center_freq1);
+	else
+		ret = cl_msg_tx_set_channel(cl_hw, channel, bw, freq,
+					    chandef->center_freq1,
+					    CL_CALIB_PARAMS_DEFAULT_STRUCT);
+exit:
+	return ret;
+}
+
+static int cl_scan_channel(struct cl_chan_scanner *scanner, u8 ch_idx)
+{
+	u8 main_channel;
+	enum cl_channel_bw main_bw;
+	s32 res = 0;
+	bool is_off_channel;
+	u64 scan_time_jiffies;
+
+	/*
+	 * 1. Save current channel
+	 * 2. Disable tx
+	 * 3. jump to new channel
+	 * 4. Enable promiscious
+	 * 5. Enable BSS collection
+	 * 6. Reset stats counters
+	 * 7. Sleep for scan_time
+	 * 8. Calculate stats
+	 * 9. Disable promiscious
+	 * 10. Disable BSS collection
+	 * 11. Switch to current channel
+	 * 12. Enable tx
+	 **/
+
+	cl_dbg_trace(scanner->cl_hw, "Starting scan on channel %u, scan time %u(ms)\n",
+		     scanner->channels[ch_idx].channel, scanner->scan_time);
+
+	/* Save current channel */
+	res = mutex_lock_interruptible(&scanner->cl_hw->set_channel_mutex);
+	if (res != 0)
+		return res;
+	main_channel = scanner->cl_hw->channel;
+	main_bw = scanner->cl_hw->bw;
+	mutex_unlock(&scanner->cl_hw->set_channel_mutex);
+
+	cl_dbg_trace(scanner->cl_hw, "Main channel is %u with bw %u\n",
+		     main_channel, main_bw);
+
+	is_off_channel = (scanner->channels[ch_idx].channel != main_channel) ||
+			 (scanner->channels[ch_idx].scan_bw != main_bw);
+
+	/* Jump to new channel */
+	if (is_off_channel) {
+		/* Disable tx */
+		cl_tx_en(scanner->cl_hw, CL_TX_EN_SCAN, false);
+
+		res = cl_scan_channel_switch(scanner->cl_hw,
+					     scanner->channels[ch_idx].channel,
+					     scanner->channels[ch_idx].scan_bw,
+					     false);
+		if (res) {
+			cl_dbg_err(scanner->cl_hw,
+				   "Channel switch failed: ch - %u, bw - %u, err - %d\n",
+				   scanner->channels[ch_idx].channel,
+				   scanner->channels[ch_idx].scan_bw, res);
+			goto enable_tx;
+		}
+	} else {
+		cl_dbg_trace(scanner->cl_hw, "Scan on main channel %u\n", main_channel);
+	}
+
+	/* Enable promiscious mode */
+	cl_rx_filter_set_promiscuous(scanner->cl_hw);
+
+	/* Reset channel stats */
+	cl_get_initial_channel_stats(scanner->cl_hw, &scanner->channels[ch_idx]);
+
+	/* Sleep for scan time */
+	scan_time_jiffies = msecs_to_jiffies(scanner->scan_time);
+	res = wait_for_completion_interruptible_timeout(&scanner->abort_completion,
+							scan_time_jiffies);
+	if (res > 0) {
+		cl_dbg_err(scanner->cl_hw, "Scan on channel %u, bw %u, idx %u was aborted\n",
+			   scanner->channels[ch_idx].channel,
+			   scanner->channels[ch_idx].scan_bw, ch_idx);
+		res = 0;
+	}
+
+	/* Calculate stats */
+	cl_get_final_channel_stats(scanner->cl_hw, &scanner->channels[ch_idx]);
+
+	/* Disable promiscious */
+	cl_rx_filter_restore_flags(scanner->cl_hw);
+
+	if (is_off_channel) {
+		res = cl_scan_channel_switch(scanner->cl_hw, main_channel, main_bw, false);
+		if (res)
+			cl_dbg_err(scanner->cl_hw,
+				   "Switching to main ch %u, bw %u failed, err - %d\n",
+				   main_channel, main_bw, res);
+enable_tx:
+		/* Enable tx */
+		cl_tx_en(scanner->cl_hw, CL_TX_EN_SCAN, true);
+	}
+
+	cl_dbg_trace(scanner->cl_hw, "Scan on channel %u finished, actual scan_time is %u ms\n",
+		     scanner->channels[ch_idx].channel, scanner->channels[ch_idx].scan_time_ms);
+
+	return res;
+}
+
+static s32 cl_run_off_channel_scan(struct cl_chan_scanner *scanner)
+{
+	u8 i = 0, scanned_channels = 0;
+	s32 ret = 0;
+
+	for (i = 0; i < scanner->channels_num && !scanner->scan_aborted; ++i) {
+		if (!scanner->channels[i].scan_enabled)
+			continue;
+
+		scanner->curr_ch_idx = i;
+		ret = cl_scan_channel(scanner, i);
+		if (ret)
+			cl_dbg_err(scanner->cl_hw, "scan failed, err - %d, channel - %u\n",
+				   ret, scanner->channels[i].channel);
+
+		if (scanner->scan_aborted)
+			break;
+
+		cl_dbg_trace(scanner->cl_hw, "Scan on chan %u finished, waiting for time %u\n",
+			     scanner->channels[i].channel, scanner->wait_time);
+
+		++scanned_channels;
+		if (scanned_channels != scanner->scan_channels_num) {
+			u64 wait_time_jiffies;
+
+			wait_time_jiffies = msecs_to_jiffies(scanner->wait_time);
+			ret = wait_for_completion_interruptible_timeout(&scanner->abort_completion,
+									wait_time_jiffies);
+			if (ret > 0) {
+				cl_dbg_err(scanner->cl_hw, "Off-channel scan was aborted\n");
+				ret = 0;
+			}
+		}
+	}
+
+	if (scanner->completion_cb)
+		scanner->completion_cb(scanner->cl_hw, scanner->completion_arg);
+
+	cl_dbg_info(scanner->cl_hw, "Off-channel scan on %u channels finished\n",
+		    scanner->scan_channels_num);
+
+	return ret;
+}
+
+static s32 cl_off_channel_scan_thread_fn(void *args)
+{
+	struct cl_chan_scanner *scanner = args;
+
+	while (!kthread_should_stop()) {
+		if (atomic_read(&scanner->scan_thread_busy)) {
+			cl_run_off_channel_scan(scanner);
+			atomic_set(&scanner->scan_thread_busy, 0);
+			wake_up_interruptible(&scanner->wq);
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+	}
+
+	return 0;
+}
+
+static bool cl_is_scan_available(struct cl_chan_scanner *scanner)
+{
+	if (atomic_cmpxchg(&scanner->scan_thread_busy, 0, 1) == 1) {
+		cl_dbg_warn(scanner->cl_hw, "Off-channel scan is already in progress\n");
+		return false;
+	}
+
+	return true;
+}
+
+static enum cl_channel_bw cl_scanner_fix_input_bw(struct cl_chan_scanner *scanner, u8 bw)
+{
+	return (bw >= CHNL_BW_MAX) ? scanner->cl_hw->bw : bw;
+}
+
+static void cl_scanner_disable_everywhere(struct cl_chan_scanner *scanner)
+{
+	u8 j;
+
+	for (j = 0; j < scanner->channels_num; ++j)
+		scanner->channels[j].scan_enabled = false;
+}
+
+s32 cl_trigger_off_channel_scan(struct cl_chan_scanner *scanner, u32 scan_time, u32 wait_time,
+				const u8 *channels, enum cl_channel_bw scan_bw, u8 channels_num,
+				void (*completion_cb)(struct cl_hw *cl_hw, void *arg),
+				void *completion_arg)
+{
+	u8 i, j;
+
+	if (!channels || scan_bw > CHNL_BW_MAX)
+		return -EINVAL;
+
+	if (!scanner->scans_enabled)
+		return 0;
+
+	if (channels_num > scanner->channels_num) {
+		cl_dbg_err(scanner->cl_hw, "channels num %u is invalid, max is %u\n",
+			   channels_num, scanner->channels_num);
+		return -ERANGE;
+	}
+
+	if (!cl_is_scan_available(scanner))
+		return -EBUSY;
+
+	scanner->completion_arg = completion_arg;
+	scanner->completion_cb = completion_cb;
+	scanner->scan_time = max_t(u32, scan_time, CL_MIN_SCAN_TIME_MS);
+	scanner->wait_time = max_t(u32, wait_time, CL_MIN_WAIT_TIME_MS);
+	scanner->scan_bw = cl_scanner_fix_input_bw(scanner, scan_bw);
+	scanner->scan_aborted = false;
+
+	cl_scanner_disable_everywhere(scanner);
+
+	scanner->scan_channels_num = 0;
+	for (j = 0; j < scanner->channels_num; ++j) {
+		for (i = 0; i < channels_num; ++i) {
+			if (channels[i] != scanner->channels[j].channel)
+				continue;
+
+			if (!cl_chan_info_get(scanner->cl_hw, scanner->channels[j].channel,
+					      scanner->scan_bw)) {
+				cl_dbg_warn(scanner->cl_hw, "channel %u with bw %u is disabled\n",
+					    scanner->channels[j].channel, scanner->scan_bw);
+				continue;
+			}
+
+			scanner->channels[j].scan_enabled = true;
+			++scanner->scan_channels_num;
+		}
+	}
+
+	reinit_completion(&scanner->abort_completion);
+
+	wake_up_process(scanner->scan_thread);
+
+	return 0;
+}
+
+void cl_abort_scan(struct cl_chan_scanner *scanner)
+{
+	scanner->scan_aborted = true;
+	complete(&scanner->abort_completion);
+	cl_dbg_info(scanner->cl_hw, "Off-channel scan was aborted\n");
+}
+
+bool cl_is_scan_in_progress(const struct cl_chan_scanner *scanner)
+{
+	return atomic_read(&scanner->scan_thread_busy);
+}
+
+int cl_scanner_init(struct cl_hw *cl_hw)
+{
+	u8 i, j;
+	s32 ret = 0;
+	u32 channels_num;
+	struct cl_chan_scanner *scanner;
+
+	cl_hw->scanner = vzalloc(sizeof(*cl_hw->scanner));
+	if (!cl_hw->scanner)
+		return -ENOMEM;
+
+	scanner = cl_hw->scanner;
+	init_completion(&scanner->abort_completion);
+
+	scanner->cl_hw = cl_hw;
+	scanner->scans_enabled = true;
+
+	channels_num = cl_channel_num(scanner->cl_hw);
+	for (i = 0, j = 0; i < channels_num; ++i) {
+		u32 freq;
+
+		freq = cl_channel_idx_to_freq(cl_hw, i);
+		if (!ieee80211_get_channel(cl_hw->hw->wiphy, freq))
+			continue;
+
+		ret = cl_init_channel_stats(scanner->cl_hw, &scanner->channels[j], freq);
+		if (ret)
+			return ret;
+
+		cl_dbg_trace(scanner->cl_hw, "Stats for channel %u at index %u initialized\n",
+			     scanner->channels[j].channel, j);
+		++j;
+	}
+
+	scanner->channels_num = j;
+
+	atomic_set(&scanner->scan_thread_busy, 0);
+	init_waitqueue_head(&scanner->wq);
+
+	scanner->scan_thread = kthread_run(cl_off_channel_scan_thread_fn,
+					   scanner, SCANNER_KTHREAD_NAME);
+	if (IS_ERR(scanner->scan_thread)) {
+		cl_dbg_err(scanner->cl_hw, "unable to create kthread %s, err - %ld\n",
+			   SCANNER_KTHREAD_NAME, PTR_ERR(scanner->scan_thread));
+		return PTR_ERR(scanner->scan_thread);
+	}
+	cl_dbg_trace(scanner->cl_hw, "%s kthread was created, pid - %u\n",
+		     SCANNER_KTHREAD_NAME, scanner->scan_thread->pid);
+
+	return ret;
+}
+
+void cl_scanner_deinit(struct cl_hw *cl_hw)
+{
+	struct cl_chan_scanner *scanner = cl_hw->scanner;
+
+	if (!scanner->scans_enabled)
+		goto out;
+
+	if (scanner->scan_thread)
+		kthread_stop(scanner->scan_thread);
+
+ out:
+	vfree(cl_hw->scanner);
+	cl_hw->scanner = NULL;
+}
-- 
2.36.1

