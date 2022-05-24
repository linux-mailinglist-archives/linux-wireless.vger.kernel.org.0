Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D43532989
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiEXLl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEXLlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:11 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A1941BA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/wlAiSGQhkb2tRJ9DeuA7LOKHL0fy9qHf1I81O9hUBCsr20oCF0FURgz68Y+M12BPf/5MYmab9rnmBfxnNXTUfJaE6ngunbnSxytPwhm5j7uvOKfz+sGm+hNBPbgPWqFwockNDHB2O9tCZRtl9cI7S1/PpIE/k1asH+Jb3OzJMFBiU4V3bkcfYxuBOS1vjK0ZHnYwbdTqs0t2yTpNLrMTcr+rd8WNZp0JRPdTzoBJFoTXM0TZThxXGOQHV24uQwY7drUEcsDyfCYm8fEJ04vT5nTne1qF8RGV0pslgFUHIGLxRUfTSgHy+a7avLVp8vF3cdQZVEV3WT/0JRGH2bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLsiStGhBV+fyJYbOK9tcR6/jxKYf7YVRl0ZH+zdLek=;
 b=E4KjV/119CwdlJ98xMLitilgy4wLxuRi8G1tMGIbg25xvmOCQdc5sujW/Jl1m9HIt5CBROVJbhlDTH+EV4RhSGX3Bb86lMurJSU+wc0lRmVS1PVww9VLakq5YgTDYsucNmal61ATdQnsKtdY3iCFNV9cMpy9HCPSlZVJ//E2DDJvGpyC5mMU1BusEUoZo9aserTUtVT0aRD6e22bzD69SOVeKs0Bd/3PXnWaeC8FvxXfElVvZSyKa6u783UVt59dwRmfL2bzXT8Gcx8UGuM37vRBcnbltfzm/wkGOiwtsiNTnm+K+LoPWSPVfEPzSAlkTkwZlZ89OWUDE4LSekVo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLsiStGhBV+fyJYbOK9tcR6/jxKYf7YVRl0ZH+zdLek=;
 b=iyc68KrUggfVpTxPkfDJWer/IbGm/w5m+cmYB6l1InglPqZIuWorLr7bAaGtkw2q2klfdMWI51sK8XsHaB+1tmUwWYt1wYZhyI5KYsQkuOGbHPIKylolTapYKCUN/OQ9B9V33RA1xr7KcXHjCO0Lh3zyWa8MJVGzP5vh7cRJsvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:05 +0000
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
Subject: [RFC v2 92/96] cl8k: add vns.c
Date:   Tue, 24 May 2022 14:34:58 +0300
Message-Id: <20220524113502.1094459-93-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 478eed20-10ef-470e-57c8-08da3d7a00ac
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB103310381F80E561A3A8CA47F6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLYHMZsga955sZsw7/yp97VmYJTCtbdDMxMBCDpwXKHI/D3lLqoNlJKWWuhFaK92aAUITv/FjAl+s3fObcB+e3KSvTPlKFB8g+2YRlggDXQ13xPc7LHnuGZHJqWZJS6A2Dx30YihjJpZQg6lbX9RCvIh6umgxJo0wxAUh87BdOmTNOJFCc7srDNb3CNzIdB0YCe8eULa7mu+i6zqFREBXkgpq8e4z3BBwdwZKpK9mpZONXu6pIVVgeP80yQ+MxVblcz5PWkhQXDsWRDcSD6yJVjkw4b1+hau5/a+cvpgJegkYCS0OHW8fdDcCAKTkp/lfOfHFGaHdFnx9/ZItJD5kOktTQdf9tNPEDYtWyYSnsCSZDqbUf2D4oeyrKHkTmWHvG3MK+Pz3QFMg5VXRlnPzgZ9nTmQv7GJYf/peHqxnkVoD+Pt28OcWx+6scTUyZ0VOjgiHrezVuMxhOVX3s9fZ/HunsabVJ4BXkoAaCxqvjehwIGTYKns5fYgbyrH43kDpvgODs9zojQsnKe5Cz9xoi8G4KzGPglvpfniuD2LJslxxnTGISzeELwrd18AnBy3EwZIuwuYBeW4JT21XTQE2r6QzK/WfCoXrAZBPTKImz+bCEq2SaJcmTx37dIXUQ/J4YjGrFej973M6tm/oX/hTqpEPngsAdhy4u2DF2Nmt975IitmynxGWqI4+WYhMxPcQR53w4DXM9KJMmU6QxRHhtvpeOro3fQ03cqG2iR75+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(107886003)(5660300002)(508600001)(83380400001)(8936002)(186003)(1076003)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6z7eB4gybonHrkr3TonQ1IhtIyioMJK60D2XzcHNrUvWWc6J1fIWmoj2vdJ?=
 =?us-ascii?Q?+gZwnr0bq3uHkllSgN++tSYIhFUj2k+u3XFcdMcODygOVdBCe+qTAAICPQZ/?=
 =?us-ascii?Q?QDocJKdOYJuvb98jazdk/a+v+woQ/IAARvHMGMjvq2nesGmFB63k5MiYcHPP?=
 =?us-ascii?Q?CqLgeXEXRK2oS3KKUcG53oRTunsZdN+INVEGiR3CjXzJNVbq3fWt9InPnySo?=
 =?us-ascii?Q?fDeeBJBWjG8897EThoXKQlpnoXgKpGi0oOsjGQBef5wFzama45DjAc/FhIUF?=
 =?us-ascii?Q?EDsmdoQKK8ujWawUa1Aee4EfXSUgzPSDmEHpUJ08pGJaTJzhsZBTjAU6GX+/?=
 =?us-ascii?Q?XNvNYw8klKVOSS1k3w+mRHAAkqivpv+N395/n4fBz+wfiMEVBQ8l6OPkgNHh?=
 =?us-ascii?Q?j/6zTy5Wqbf6/bb9de8zhinkSeoAFTcVGVmsvFXh9TQQjWJCJKtAzbZetpxe?=
 =?us-ascii?Q?EAQVI25xnGm3V5/XEVupzv6mSTrd0CXy45uMvbaT1kRZsn97uOLA4VdBuBT0?=
 =?us-ascii?Q?obzA23Gp/nWiTQQAjWKC/FI/p1UDvv7fo4RBsm5FDkISEsti+2ySnmvh5I+5?=
 =?us-ascii?Q?r17Jge4gM2thnNVXDTSDsouHE4bWncS7lUiSj5EcMQVadD5tmF5g4vj0ctBz?=
 =?us-ascii?Q?qRv9z6CVXylr517Qtljtx1m58pLL2RF4aU7zj+wX3rCmj89lm+e+UFoW/Z/H?=
 =?us-ascii?Q?HHxxcv/hQrohFcaN6hLcCOoy5rslN47c+nkh9pzPrVXnGRIdSKc8TSsyTIUm?=
 =?us-ascii?Q?INNbLzn4Wty5nBCy4ri/KvFymWKyUM62WDbcHNAMmBrZjyYk0eN1aia+fqMd?=
 =?us-ascii?Q?QV7HwBunWI5ItYvigVse49oZW70BJEe4/qoPNvZ1lKP0aMdWeCVDSAofSoSz?=
 =?us-ascii?Q?TSzozxiWDqyObQj22/Wf4AxFl2yBco1kec0psBww5kecDtHlKYRFZyqs9LH2?=
 =?us-ascii?Q?pmW/aHkPWws1Auoxqp1qKU7i1KRyd2XTTT5+ySfzdvFDpcnWRBxfkDipTC3c?=
 =?us-ascii?Q?9wDCRR0+B/ByvfIz9fWLbzOH7d8PXGtQliD3CAkt2fw0BnGlvtoFIOStua3h?=
 =?us-ascii?Q?h+D+4IJ9OqmzVrb/fxQPC68eWuyiYtCihWEJ8kaz6DKpWgAvUJfMCd5+B0ym?=
 =?us-ascii?Q?SodwvVHu4exgzJC6xjLoPwBEbx5Fj1VhbVSEkNJqaEv8ctrdYwBYXQNNfTHM?=
 =?us-ascii?Q?aCAZ1GdaBbrX0ndVUTnYTwX76dKvyRjgcXUGUH4AQxxcLnmPvSGrPtQ8Z62G?=
 =?us-ascii?Q?iUCq+zFmccIfpo7UQVobvng+M3YaBSMOSD7Ae1TpEfNtkqr81HoyJgdCqwab?=
 =?us-ascii?Q?gu6uK+LjLKaHZ9IQOlVj5bgJCSxULeBfqpaRwHH/9Rl8rLqX8pXfNcp1fP3m?=
 =?us-ascii?Q?KfVX3gZnnaw/QcYUyLY42/e7qdbpjYORZDDA0IeQizOgNs2d51QXrkLPnzpB?=
 =?us-ascii?Q?nvicdqv1Jnbh+sdiERYXy+pIoDZP4HLkeDXpBhWqCnXHPLbf+0hyHI32E4t0?=
 =?us-ascii?Q?0rdDHoz8d4XeQuKEEfvEl9Tbz+d+SObL3/UJ8rSKsPw3pJ6ovm76TIMAkadm?=
 =?us-ascii?Q?Hv31kcBIHyaxiBpwKwy3/uXFNLyRzsMhbROA8kuJ8/GG57YEfjiUkSkKgD42?=
 =?us-ascii?Q?IiMzlVt3hwDHkLwxkj4jCn5gGpMeDAtVUfWWJ1gnrKathsNubdnb1SzmC5Q2?=
 =?us-ascii?Q?KSSntvXxZcVxLVgPhJzxIDrQtR4DYTUIT2leXQL28Ih0ALU1t/imZ06yWX88?=
 =?us-ascii?Q?Rg0eukjgFJX0sgUMlvbXr7ctAypl7A8=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478eed20-10ef-470e-57c8-08da3d7a00ac
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:03.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23m9EuLLu1BqmWZYG1Pg+6fM046CGpKcv84utPXiEFxScX0a4t0sndL6NfIP7VQ1cYYxmdGdxceVRPvnsv+axg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1033
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
 drivers/net/wireless/celeno/cl8k/vns.c | 354 +++++++++++++++++++++++++
 1 file changed, 354 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.c

diff --git a/drivers/net/wireless/celeno/cl8k/vns.c b/drivers/net/wireless/celeno/cl8k/vns.c
new file mode 100644
index 000000000000..6f79b36d0a5c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vns.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "maintenance.h"
+#include "mac_addr.h"
+#include "debug.h"
+#include "vns.h"
+
+#define CL_VNS_HASH_IDX    (ETH_ALEN - 2)
+#define CL_VNS_MGMT_AGEOUT 200
+
+#define vns_pr(...) \
+	do { \
+		if (unlikely(cl_hw->vns_db->dbg)) \
+			pr_debug("[VNS]" __VA_ARGS__); \
+	} while (0)
+
+#define vns_pr_pkt(...) \
+	do { \
+		if (unlikely(cl_hw->vns_db->dbg_per_packet)) \
+			pr_debug("[VNS-pkt]" __VA_ARGS__); \
+	} while (0)
+
+static void cl_vns_mgmt_list_add(struct cl_hw *cl_hw, u8 *addr, s8 strongset_rssi)
+{
+	/* Add entry to mgmt list */
+	struct cl_vns_rssi_entry *entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+
+	if (!entry)
+		return;
+
+	/* Fill entry parameters */
+	INIT_LIST_HEAD(&entry->list_all);
+	INIT_LIST_HEAD(&entry->list_addr);
+	cl_mac_addr_copy(entry->addr, addr);
+	entry->strongset_rssi = strongset_rssi;
+	entry->timestamp = jiffies;
+
+	/* Add to list */
+	cl_hw->vns_db->mgmt_db.num_entries++;
+	list_add(&entry->list_all, &cl_hw->vns_db->mgmt_db.list_all);
+	list_add(&entry->list_addr, &cl_hw->vns_db->mgmt_db.list_addr[addr[CL_VNS_HASH_IDX]]);
+}
+
+static void cl_vns_mgmt_list_remove(struct cl_hw *cl_hw, struct cl_vns_rssi_entry *entry)
+{
+	/* Remove entry from mgmt list */
+	cl_hw->vns_db->mgmt_db.num_entries--;
+	list_del(&entry->list_all);
+	list_del(&entry->list_addr);
+	kfree(entry);
+}
+
+static void cl_vns_mgmt_list_flush(struct cl_hw *cl_hw)
+{
+	/* Flush all mgmt list */
+	if (cl_hw->vns_db->mgmt_db.num_entries > 0) {
+		struct cl_vns_rssi_entry *entry = NULL, *tmp = NULL;
+
+		list_for_each_entry_safe(entry, tmp, &cl_hw->vns_db->mgmt_db.list_all, list_all)
+			cl_vns_mgmt_list_remove(cl_hw, entry);
+	}
+}
+
+static struct cl_vns_rssi_entry *cl_vns_mgmt_list_find(struct cl_hw *cl_hw, u8 *addr)
+{
+	/* Search for entry in mgmt list */
+	struct cl_vns_mgmt_db *mgmt_db = &cl_hw->vns_db->mgmt_db;
+
+	if (mgmt_db->num_entries > 0) {
+		struct cl_vns_rssi_entry *entry = NULL;
+
+		list_for_each_entry(entry, &mgmt_db->list_addr[addr[CL_VNS_HASH_IDX]], list_addr)
+			if (ether_addr_equal(entry->addr, addr))
+				return entry;
+	}
+
+	return NULL;
+}
+
+static bool cl_vns_mgmt_list_find_and_remove(struct cl_hw *cl_hw, u8 *addr)
+{
+	/*
+	 * Search for entry in mgmt list
+	 * If entry found remove it and return true
+	 */
+	struct cl_vns_rssi_entry *entry = cl_vns_mgmt_list_find(cl_hw, addr);
+
+	if (entry) {
+		cl_vns_mgmt_list_remove(cl_hw, entry);
+		return true;
+	}
+
+	return false;
+}
+
+static void cl_vns_mgmt_list_ageout(struct cl_hw *cl_hw)
+{
+	/* Remove old entries from mgmt list */
+	struct cl_vns_mgmt_db *mgmt_db = &cl_hw->vns_db->mgmt_db;
+
+	if (mgmt_db->num_entries > 0) {
+		struct cl_vns_rssi_entry *entry = NULL, *tmp = NULL;
+		unsigned long delta_time;
+
+		list_for_each_entry_safe(entry, tmp, &mgmt_db->list_all, list_all) {
+			delta_time = jiffies_to_msecs(jiffies - entry->timestamp);
+
+			if (delta_time > CL_VNS_MGMT_AGEOUT) {
+				vns_pr("sta %pM removed from list because of ageout\n",
+				       entry->addr);
+				cl_vns_mgmt_list_remove(cl_hw, entry);
+			}
+		}
+	}
+}
+
+static s8 cl_vns_get_strongest_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_vns_sta_db *vns_db = &cl_sta->vns_db;
+	s32 rssi_samples = vns_db->rssi_samples;
+
+	if (rssi_samples > 0) {
+		u8 i;
+		s32 strongest_rssi = S32_MIN;
+
+		for (i = 0; i < cl_hw->num_antennas; i++)
+			if (vns_db->rssi_sum[i] > strongest_rssi)
+				strongest_rssi = vns_db->rssi_sum[i];
+
+		/* Reset rssi for next time that cl_vns_get_strongest_rssi() will be called */
+		memset(vns_db->rssi_sum, 0, sizeof(vns_db->rssi_sum));
+		vns_db->rssi_samples = 0;
+
+		return (s8)(strongest_rssi / rssi_samples);
+	}
+
+	return 0;
+}
+
+static void cl_vns_monitor_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	/* Monitor RSSI of associated stations and update state if necessary */
+	struct cl_vns_sta_db *vns_db = &cl_sta->vns_db;
+	s8 strongset_rssi = cl_vns_get_strongest_rssi(cl_hw, cl_sta);
+	s8 rssi_thr = 0;
+	bool is_vns = false;
+
+	if (strongset_rssi == 0)
+		return;
+
+	/*
+	 * Calculate RSSI threshold (take hystersis into
+	 *  consideration according to current state)
+	 */
+	if (vns_db->is_very_near)
+		rssi_thr = cl_hw->conf->ci_vns_rssi_thr - cl_hw->conf->ci_vns_rssi_hys;
+	else
+		rssi_thr = cl_hw->conf->ci_vns_rssi_thr + cl_hw->conf->ci_vns_rssi_hys;
+
+	is_vns = strongset_rssi > rssi_thr;
+	/* Avoid toggling of VNS state - require two consecutive same decisions */
+	if (is_vns != vns_db->prev_decision) {
+		vns_db->prev_decision = is_vns;
+		return;
+	}
+
+	if (is_vns != vns_db->is_very_near) {
+		vns_pr("sta %pM changed state, strongset_rssi = %d, is_vns = %s\n",
+		       cl_sta->addr, strongset_rssi, is_vns ? "TRUE" : "FALSE");
+		vns_db->is_very_near = is_vns;
+		cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, is_vns);
+	}
+}
+
+static void cl_vns_recovery_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	if (cl_sta->vns_db.is_very_near)
+		cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, true);
+}
+
+int cl_vns_init(struct cl_hw *cl_hw)
+{
+	int i = 0;
+	u8 vns_pwr_mode = cl_hw->conf->ci_vns_pwr_mode;
+
+	cl_hw->vns_db = vzalloc(sizeof(*cl_hw->vns_db));
+	if (!cl_hw->vns_db)
+		return -ENOMEM;
+
+	if (vns_pwr_mode == VNS_MODE_DATA || vns_pwr_mode == VNS_MODE_ALL)
+		cl_hw->vns_db->enable = true;
+
+	spin_lock_init(&cl_hw->vns_db->lock);
+
+	INIT_LIST_HEAD(&cl_hw->vns_db->mgmt_db.list_all);
+
+	for (i = 0; i < STA_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&cl_hw->vns_db->mgmt_db.list_addr[i]);
+
+	return 0;
+}
+
+void cl_vns_close(struct cl_hw *cl_hw)
+{
+	if (cl_hw->vns_db->enable) {
+		spin_lock_bh(&cl_hw->vns_db->lock);
+		cl_vns_mgmt_list_flush(cl_hw);
+		spin_unlock_bh(&cl_hw->vns_db->lock);
+
+		cl_hw->vns_db->enable = false;
+	}
+
+	vfree(cl_hw->vns_db);
+	cl_hw->vns_db = NULL;
+}
+
+void cl_vns_maintenance(struct cl_hw *cl_hw)
+{
+	/*
+	 * Maintenance:
+	 * 1) Remove old entries from mgmt list
+	 * 2) Update state for associated clients
+	 */
+	if (!cl_hw->vns_db || !cl_hw->vns_db->enable)
+		return;
+
+	cl_hw->vns_db->interval_period += CL_MAINTENANCE_PERIOD_SLOW_MS;
+
+	if (cl_hw->vns_db->interval_period < cl_hw->conf->ci_vns_maintenance_time)
+		return;
+
+	cl_hw->vns_db->interval_period = 0;
+
+	spin_lock_bh(&cl_hw->vns_db->lock);
+	cl_vns_mgmt_list_ageout(cl_hw);
+	spin_unlock_bh(&cl_hw->vns_db->lock);
+
+	/* Check RSSI of associated stations */
+	cl_sta_loop(cl_hw, cl_vns_monitor_rssi);
+}
+
+void cl_vns_mgmt_handler(struct cl_hw *cl_hw, u8 *addr, s8 rssi[MAX_ANTENNAS])
+{
+	/*
+	 * Handle management frames of non-associated stations,
+	 * and save the very-near ones in the mgmt list
+	 */
+	s8 strongset_rssi = 0;
+	struct cl_vns_rssi_entry *entry = NULL;
+
+	if (!cl_hw->vns_db->enable)
+		return;
+
+	strongset_rssi = cl_rssi_get_strongest(cl_hw, rssi);
+
+	spin_lock_bh(&cl_hw->vns_db->lock);
+
+	entry = cl_vns_mgmt_list_find(cl_hw, addr);
+
+	if (entry) {
+		if (strongset_rssi > cl_hw->conf->ci_vns_rssi_thr) {
+			/* Update exisiting entry */
+			entry->strongset_rssi = strongset_rssi;
+			entry->timestamp = jiffies;
+			vns_pr("sta %pM updated in list (rssi=%d)\n",
+			       addr, strongset_rssi);
+		} else {
+			/* Remove exisiting entry */
+			cl_vns_mgmt_list_remove(cl_hw, entry);
+			vns_pr("sta %pM removed from list (rssi=%d)\n",
+			       addr, strongset_rssi);
+		}
+	} else {
+		if (strongset_rssi > cl_hw->conf->ci_vns_rssi_thr) {
+			/* Add new entry */
+			cl_vns_mgmt_list_add(cl_hw, addr, strongset_rssi);
+			vns_pr("sta %pM added to list (rssi=%d)\n",
+			       addr, strongset_rssi);
+		}
+	}
+
+	spin_unlock_bh(&cl_hw->vns_db->lock);
+}
+
+bool cl_vns_is_very_near(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb)
+{
+	bool is_vns = false;
+	/* This function checks for every TX packet whether it's VNS or not */
+	if (!cl_hw->vns_db->enable)
+		return false;
+
+	if (unlikely(!cl_sta)) {
+		struct ieee80211_hdr *mac_hdr = (struct ieee80211_hdr *)skb->data;
+
+		spin_lock_bh(&cl_hw->vns_db->lock);
+		is_vns = cl_vns_mgmt_list_find(cl_hw, mac_hdr->addr1);
+		spin_unlock_bh(&cl_hw->vns_db->lock);
+
+		vns_pr_pkt("mgmt-sta %pM, is_vns = %s\n",
+			   mac_hdr->addr1, is_vns ? "TRUE" : "FALSE");
+
+		return is_vns;
+	}
+	is_vns = cl_sta->vns_db.is_very_near;
+
+	vns_pr_pkt("assoc-sta %pM, is_vns = %s\n",
+		   cl_sta->addr, is_vns ? "TRUE" : "FALSE");
+
+	return is_vns;
+}
+
+void cl_vns_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	/* Update is_very_near according to mgmt list */
+	bool is_vns = false;
+
+	if (!cl_hw->vns_db->enable)
+		return;
+
+	spin_lock_bh(&cl_hw->vns_db->lock);
+	is_vns = cl_vns_mgmt_list_find_and_remove(cl_hw, cl_sta->addr);
+	spin_unlock_bh(&cl_hw->vns_db->lock);
+
+	if (is_vns) {
+		vns_pr("sta %pM connected - is_vns = TRUE\n", cl_sta->addr);
+		cl_sta->vns_db.is_very_near = true;
+		cl_sta->vns_db.prev_decision = true;
+		cl_msg_tx_set_vns(cl_hw, cl_sta->sta_idx, true);
+	} else {
+		vns_pr("sta %pM connected - is_vns = FALSE\n", cl_sta->addr);
+	}
+}
+
+void cl_vns_handle_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS])
+{
+	/* Collect rssi samples */
+	int i;
+
+	if (!cl_hw->vns_db->enable)
+		return;
+
+	for (i = 0; i < cl_hw->num_antennas; i++)
+		cl_sta->vns_db.rssi_sum[i] += rssi[i];
+
+	cl_sta->vns_db.rssi_samples++;
+}
+
+void cl_vns_recovery(struct cl_hw *cl_hw)
+{
+	vns_pr("Recovery\n");
+	cl_sta_loop_bh(cl_hw, cl_vns_recovery_sta);
+}
+
-- 
2.36.1

