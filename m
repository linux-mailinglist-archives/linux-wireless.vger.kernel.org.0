Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B05532932
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiEXLhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbiEXLhm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510E4130C
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIu92YdZ+wP6TFIkYh7Jbtc5SX9mtJffceOXIjTi/9gYCl+hLsVXaXByuEDZoTCcWXU7VW3f8eMGCYSkIG8x/u+MhjMWe5k0xIDC/+nHtbMj+uWwxX9yc2D9EeapEEL9mkPogZR2mPJ2Qfv+FJltl1eYur1aflT7Y/Uprmc+LfcxRhz06fkyKVAwURdczleYQTHJz4y7fIJv8SH8Rue8u1qdEmoRfZLXorHx7kXN8thIBuC+iiWb+lNZQVOXtQraoG3XPMiaspoBbaT3ixog3UxYcHGsO61coZo7ITy+sUP5oAvBxf9aNyb23CgbRZa6MAkFZjMTeouPKOG9M6qpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ40xLq4tpWp7KWz3O5Vi5mtsv/Yh/b0n8cCXY3vghE=;
 b=ClKnab2gClB5bhzspS3ZwGxBRv+vR7IfwhWxiRGsxQt1naGEFjZL/g42CBo8JR+NekH3PQZJzD16fewLs46cvfE89sJsa1PjzzQlXXnCv5NtiH5eFkVJ/BcOWxNLVpSNPKOc6wJjApioAAq9E4QOyE/K43srjLA3gkLoIp49z/TA/PJGBu2JNN6gvqbDctJnNoaLM6i1hn4v1Z12JMwMdX5Vc0eOdGVK7z4JXcdJvh0PpcBRb+xGqjSDQ63k8mE0ssLOmWORDcrkEm3klBkkT9SHqF1s9QJO+HjNTwFoBHz2EtP8JsE1TfADbKPsbB8fudtar8TyFE6+3rQ6MKsaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ40xLq4tpWp7KWz3O5Vi5mtsv/Yh/b0n8cCXY3vghE=;
 b=v/udtxWlIYhxLoKWsnxy5CgZ2x7nZTvDMamp06MnAQhMinpf2QNUfO6v/UxaxTqZs8wBPSShLISinN97uZyNRzu5GkM+403sC40E0KjTZaG4Nedmex0dlyzvrHSTU6haEZYmtK1nF6uur8oYQr/EFOgDNNGzk0PXXKEX5y2NwLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:37:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:38 +0000
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
Subject: [RFC v2 05/96] cl8k: add ampdu.c
Date:   Tue, 24 May 2022 14:33:31 +0300
Message-Id: <20220524113502.1094459-6-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0f46ebe-f43b-4268-1e97-08da3d79ce4c
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384CD0527EB403475F93457F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqb3Rrq4sTUyCHQVEYwZB4aJSbp0H8YL8prQjhCm3Zjg+u5Ox5OyCI12/Hdg/3odgSLfZZHSlcP2Ir5LdfXZmDeBScMimLn83XJFfH6wqd8fqtiJ+C3RRj3XvkTVSGSVLw4obn/jQ5Ayovymu+5P3C22HX+33L/h2B9y0zWdC20yFg+ympa6TrEaDQtmRhenecGDMaSKo3eWkRZWJL+nSjq/5jNi8I5FAisZEhwV6IsYubPiz68g0G3V4IcY7fFT1C9PyM9eaVmhVgZesdl9vJKz+eAuYi5b9p8mgc8krkmj6ka5j1bkzucd2gF6RJMENG+9W+eoPFpCnolZf80dh1vKTKoEJjME9nKHPvinsa4HQ3acWQld6+zka6j+FrBr0v5x0yJr2pv/2IdAr5RD0J8tY06+oHzskufIx7Jky+4MBW39Arpk6P0BbubYAdcNuJDbeFEoiEkhASxY7+hCv7w6/Vmr6HSymIRFJUuP+r+zoFnJPE3x4u+TW0rTdQRTudMfGuz99nk+l3SODUj+RPNuyNGnocDTDGdCHMEQ2cymJRe/bwW4eSfK97/QBzmOz6JpcYjbRWJwHTCwUNQQStQRNB76zImuC71a2ld+mrNImhVW0PMQHm84ERtQFI4A3sQ+NMKU7JMHGT2s3c5ZXC1sH0akTTORBFcEcN68jnjuwCQju1kZwnSP9XqQQ3wBywMLt5q/tu6XiqNtEVBvBPEIcGmhO3MwwjOlkV6PTxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RswMRZef7mso3kyBJQ4rwjH2jSCJEvOIBuqTaiPlXX83iBVQEGLokrRb2Woi?=
 =?us-ascii?Q?Cfx5aCgYG9MiY5f2zrgwzfuLGAOGUoE+p86mySs73ooxscwLfSV4kYQjv5Nw?=
 =?us-ascii?Q?Ky6qnl0O2FNTjb0/QvRrPuoHb1thZTRWaW/DcNfnBEGwYyQmXsGVZrHjTPnv?=
 =?us-ascii?Q?k5YSpJUu0YhjUZxEeMcoyTt3zcsXRw0KE0GSl3ATvdT30C8touh0jOc1aaH8?=
 =?us-ascii?Q?BC0NNChvg7JWMosTpHAAVBwOqeZeiKeHOvhi1hLkrfsmhgTvNx8kvDeH0Tnu?=
 =?us-ascii?Q?e7mRLg6zq/AGSZG4H9hj42D3I1GPbMyDaaErRVOWBxZlV0mTd7CWDZg7rxI1?=
 =?us-ascii?Q?lax+W/7DChuEsJ2S71uJjAQRTuJlOyxvuVhu8Z4M40P+IrCUiTBArb0g8JDV?=
 =?us-ascii?Q?vUHkGOL1y/qc8g9UxXo44e2aZxU3FPSzlzbsb9wQ/5MDZYHZkLG4k3c0vego?=
 =?us-ascii?Q?fJ3a+bShwKcWqiwiJAZ+hfQAK0hrgd/KBIygv9zHIL/ToRDFFb+aBGIf6MD3?=
 =?us-ascii?Q?Pr0cg2j7k9WIXDeB8oKL40QonoJ5JstUGgys1c0Xz2SBabyfkL/bE7TpFJgS?=
 =?us-ascii?Q?18x8dX7LvtpB9AYu9srCxGHb8zFtwZfkqBqzmjwwOnIJGLoWgRZCgfQFNolU?=
 =?us-ascii?Q?ihGXIZQzcXK0PEgQma3GyIXBgjqfhJF3P6RAbCDOh7QooFiv0F+kse97Vzwy?=
 =?us-ascii?Q?VnxewUfOjhkhs9gxPWzXPyyU4+HRmUEYPAp30EYvPN+LSFBe8S38A12lSAO/?=
 =?us-ascii?Q?XuIEP5T2HIhKPhOZ4pvlP72miSgEJnatyjBSxYt+QlrkvfARfcAifpcHqTiJ?=
 =?us-ascii?Q?o4Qv4H7UbLlYprkLkbKlMP7v/VV7ZE0GTOZD5TjqrhY9IbgL0j41JBrFF0AG?=
 =?us-ascii?Q?FkuC8jwWZqLq6tcWWTU04f4NQ7oSx+kSXebzLM4c33vMXXiBdQ6bssO/bscB?=
 =?us-ascii?Q?1Zsxa07Fg62S2kMdmU4+nKgGToI7L1jnABvkJSyF5eJnF4C7AxuAyG+HvWeh?=
 =?us-ascii?Q?yEsAXTw3Y6PNdvQ+mQwqJjtGUWunb0aRKGsLOvgfjlo7jkW0q8FlC/O+LusN?=
 =?us-ascii?Q?hlcESh6AR1flpU+6+gE6qwRmfpN24R85098CAMJC7L6MtTczvpNctJPHlb0n?=
 =?us-ascii?Q?2QhaiV7ZTCuPMN4MElI48YwY4rAtTvZnDw3rpBQ8wHx+2/xXt4eOV95NIOMM?=
 =?us-ascii?Q?Wq3Ll5+X3D12D5yv/FRmEBBWcmzygmIGi7JD0Ms/2pBL4VZYs6M/M2p+qjEQ?=
 =?us-ascii?Q?C9FDik+u/mMVe46j244a5/t5guB7VfZ1E+8UktBht2r5ng7Hf1TQq5hOM6LL?=
 =?us-ascii?Q?79vDxHmSqBkMOHeKCst33hbI+MYDhBgPFKLCDiXNcZjsolGPfVZusW6MoFnZ?=
 =?us-ascii?Q?JVooBh3x9eTrSdWiPhpFkGev/GL8PUN8HgzVz4mRsjCbZ8hfO196LjKKw/lT?=
 =?us-ascii?Q?9bxlrrlcqQaVUQP67r0ql0h47U40ElEeD/arHwDNmoll2gLS7kWA7VbiFy/V?=
 =?us-ascii?Q?2iLakArgkovzJYjaUZjzmIKXC+d3Jo+jcdxsnZsap9uNuxycPR+uGV8pBwJO?=
 =?us-ascii?Q?wswhxz1szN91uEzEyRrHgd2YzWxv8qoWNZdoMIRmqLEU2CdUWgvm85vYLCF3?=
 =?us-ascii?Q?CnGHVLreQ4AzESOYq9LURngURZDNcSIGo1N0PUV9t0XZzuE+2SJfeZ3r4qFa?=
 =?us-ascii?Q?sjJoEaKba8uErtbv1fHWnHRW+Bn3F+pMsYkyZwemvCDjS6suBnxPvueonXEW?=
 =?us-ascii?Q?T0yNJ3l8xCPYebaHAe+UFKCuSPftV8g=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f46ebe-f43b-4268-1e97-08da3d79ce4c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:38.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN8S5dbiBIG/5mtyHPm3zk9oljLPokn78qYl3gDGIIWlwDgrusVkEGvg3L7D1EAHRJvielnpmw+8tdOzxu+xRw==
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
 drivers/net/wireless/celeno/cl8k/ampdu.c | 331 +++++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.c

diff --git a/drivers/net/wireless/celeno/cl8k/ampdu.c b/drivers/net/wireless/celeno/cl8k/ampdu.c
new file mode 100644
index 000000000000..6609bc62d340
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ampdu.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "recovery.h"
+#include "utils.h"
+#include "ampdu.h"
+
+int cl_ampdu_rx_start(struct cl_hw *cl_hw,
+		      struct cl_sta *cl_sta,
+		      u16 tid,
+		      u16 ssn,
+		      u16 buf_size)
+{
+	/* @IEEE80211_AMPDU_RX_START: start RX aggregation */
+	if (!cl_hw->conf->ci_agg_rx)
+		return -EOPNOTSUPP;
+
+	cl_dbg_trace(cl_hw, "sta_idx [%u] tid [%u]\n", cl_sta->sta_idx, tid);
+
+	buf_size = min(buf_size, cl_hw->conf->ce_max_agg_size_rx);
+
+	if (cl_hw->conf->ci_fast_rx_en)
+		cl_rx_reorder_init(cl_hw, cl_sta, tid, buf_size);
+
+	cl_msg_tx_ba_add(cl_hw, BA_AGMT_RX, cl_sta->sta_idx, tid, buf_size, ssn);
+
+	return 0;
+}
+
+void cl_ampdu_rx_stop(struct cl_hw *cl_hw,
+		      struct cl_sta *cl_sta,
+		      u16 tid)
+{
+	/* @IEEE80211_AMPDU_RX_STOP: stop RX aggregation */
+	cl_dbg_trace(cl_hw, "sta_idx [%u] tid [%u]\n", cl_sta->sta_idx, tid);
+
+	if (cl_hw->conf->ci_fast_rx_en)
+		cl_rx_reorder_close(cl_sta, tid);
+}
+
+int cl_ampdu_tx_start(struct cl_hw *cl_hw,
+		      struct ieee80211_vif *vif,
+		      struct cl_sta *cl_sta,
+		      u16 tid,
+		      u16 ssn)
+{
+	/* @IEEE80211_AMPDU_TX_START: start TX aggregation */
+	struct mm_available_ba_txq_cfm *cfm = NULL;
+	int ret = 0;
+
+	if (!ieee80211_hw_check(cl_hw->hw, AMPDU_AGGREGATION) || !cl_hw->conf->ci_agg_tx)
+		return -ENOTSUPP;
+
+	if (!cl_txq_is_agg_available(cl_hw)) {
+		cl_dbg_warn(cl_hw, "No free aggregation queue for sta_idx [%u] tid [%u]\n",
+			    cl_sta->sta_idx, tid);
+		return -1;
+	}
+
+	ret = cl_msg_tx_available_ba_txq(cl_hw, cl_sta->sta_idx, tid);
+	if (ret)
+		return ret;
+
+	/* Read FW confirm message */
+	cfm = (struct mm_available_ba_txq_cfm *)(cl_hw->msg_cfm_params[MM_AVAILABLE_BA_TXQ_CFM]);
+	if (!cfm)
+		return -ENOMSG;
+
+	/* Check if status is valid */
+	if (cfm->status != BA_TXQUEUE_INVALID && cfm->status != BA_TXQUEUE_VALID) {
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+		cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+		return -EIO;
+	}
+
+	if (cfm->status == BA_TXQUEUE_INVALID) {
+		cl_dbg_warn(cl_hw, "BA_TXQUEUE_INVALID - sta_idx [%u] tid [%u]\n",
+			    cfm->sta_idx, cfm->tid);
+		cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+		return -1;
+	}
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+	cl_txq_agg_request_add(cl_hw, cl_sta->sta_idx, tid);
+	cl_baw_start(&cl_sta->baws[tid], ssn);
+
+	/* Mandatory callback once setup preparations are done at lower level */
+	ieee80211_start_tx_ba_cb_irqsafe(vif, cl_sta->addr, tid);
+
+	return 0;
+}
+
+int cl_ampdu_tx_operational(struct cl_hw *cl_hw,
+			    struct cl_sta *cl_sta,
+			    u16 tid,
+			    u16 buf_size,
+			    bool amsdu_supported)
+{
+	/* @IEEE80211_AMPDU_TX_OPERATIONAL: TX aggregation has become operational */
+	struct mm_ba_add_cfm *cfm = NULL;
+	struct cl_baw *baw = &cl_sta->baws[tid];
+	u16 ssn = baw->ssn;
+	int ret = 0;
+
+	buf_size = min(buf_size, cl_hw->conf->ce_max_agg_size_tx);
+
+	/* Send MM_BA_ADD_TX_REQ message to firmware */
+	ret = cl_msg_tx_ba_add(cl_hw, BA_AGMT_TX, cl_sta->sta_idx, tid, buf_size, ssn);
+	if (ret)
+		return ret;
+
+	/* Handle message confirmation */
+	cfm = (struct mm_ba_add_cfm *)(cl_hw->msg_cfm_params[MM_BA_ADD_TX_CFM]);
+	if (!cfm)
+		return -ENOMSG;
+
+	if (cfm->status != BA_AGMT_ESTABLISHED) {
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+		cl_msg_tx_free_cfm_params(cl_hw, MM_BA_ADD_TX_CFM);
+		cl_txq_agg_request_del(cl_hw, cl_sta->sta_idx, tid);
+		return -EIO;
+	}
+
+	cl_baw_operational(cl_hw, baw, cfm->agg_idx, amsdu_supported);
+	cl_agg_cfm_set_ssn(cl_hw, ssn, cfm->agg_idx);
+	cl_hw->ipc_env->ring_indices_elem->indices->new_ssn_idx[cfm->agg_idx] = cpu_to_le32(ssn);
+
+	if (amsdu_supported)
+		cl_tx_amsdu_set_max_len(cl_hw, cl_sta, tid);
+	else
+		cl_dbg_trace(cl_hw, "AMSDU not supported - sta_idx=%u\n", cl_sta->sta_idx);
+
+	cl_txq_agg_alloc(cl_hw, cl_sta, cfm, buf_size);
+	cl_msg_tx_free_cfm_params(cl_hw, MM_BA_ADD_TX_CFM);
+
+	return 0;
+}
+
+void _cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+		       struct cl_tx_queue *tx_queue,
+		       struct cl_sta *cl_sta,
+		       u8 tid)
+{
+	struct mm_ba_del_cfm *cfm = NULL;
+	u8 fw_agg_idx = tx_queue->index;
+
+	if (cl_recovery_in_progress(cl_hw))
+		goto out;
+
+	/*
+	 * TX stop flow:
+	 * 1) Flush TX queues - done in cl_ampdu_tx_stop()
+	 * 2) Poll confirmation queue and clear enhanced TIM
+	 * 3) Send MM_STA_DEL_REQ message to firmware
+	 * 4) Poll again confirmation and flush confirmation queue
+	 * 5) Reset write index
+	 */
+	cl_agg_cfm_poll_empty(cl_hw, fw_agg_idx, false);
+
+	/* Send MM_BA_DEL_REQ message to firmware */
+	if (cl_msg_tx_ba_del(cl_hw, cl_sta->sta_idx, tid))
+		goto out;
+
+	cfm = (struct mm_ba_del_cfm *)(cl_hw->msg_cfm_params[MM_BA_DEL_CFM]);
+	if (!cfm) {
+		cl_dbg_err(cl_hw, "Unable to fetch CFM\n");
+		goto out;
+	}
+
+	/* Check confirmation status */
+	if (cfm->status != BA_AGMT_DELETED && cfm->status != BA_AGMT_DOES_NOT_EXIST)
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_BA_DEL_CFM);
+
+out:
+	cl_agg_cfm_poll_empty(cl_hw, fw_agg_idx, true);
+	cl_txq_agg_free(cl_hw, tx_queue, cl_sta, tid);
+
+	/* Reset the synchronization counters between the fw and the IPC layer */
+	cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_idx.agg[fw_agg_idx] = 0;
+}
+
+int cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+		     struct ieee80211_vif *vif,
+		     enum ieee80211_ampdu_mlme_action action,
+		     struct cl_sta *cl_sta,
+		     u16 tid)
+{
+	/*
+	 * @IEEE80211_AMPDU_TX_STOP_CONT: stop TX aggregation but continue transmitting
+	 *	queued packets, now unaggregated. After all packets are transmitted the
+	 *	driver has to call ieee80211_stop_tx_ba_cb_irqsafe().
+	 * @IEEE80211_AMPDU_TX_STOP_FLUSH: stop TX aggregation and flush all packets,
+	 *	called when the station is removed. There's no need or reason to call
+	 *	ieee80211_stop_tx_ba_cb_irqsafe() in this case as mac80211 assumes the
+	 *	session is gone and removes the station.
+	 * @IEEE80211_AMPDU_TX_STOP_FLUSH_CONT: called when TX aggregation is stopped
+	 *	but the driver hasn't called ieee80211_stop_tx_ba_cb_irqsafe() yet and
+	 *	now the connection is dropped and the station will be removed. Drivers
+	 *	should clean up and drop remaining packets when this is called.
+	 */
+
+	/* !!!  Comment in agg-tx.c, ___ieee80211_stop_tx_ba_session():  !!!
+	 * !!!  HW shall not deny going back to legacy                   !!!
+	 * !!!  Therefore cl_ampdu_tx_stop() always returns 0            !!!
+	 */
+
+	struct cl_tx_queue *tx_queue = cl_sta->agg_tx_queues[tid];
+	struct cl_baw *baw = &cl_sta->baws[tid];
+
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+
+	cl_baw_stop(baw);
+	cl_txq_agg_request_del(cl_hw, cl_sta->sta_idx, tid);
+
+	/* Check if BA session exist */
+	if (!tx_queue) {
+		spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+		if (!cl_recovery_in_progress(cl_hw))
+			cl_dbg_warn(cl_hw, "Queue doesn't exist - sta_idx [%u] tid [%u]\n",
+				    cl_sta->sta_idx, tid);
+
+		goto out;
+	}
+
+	if (action == IEEE80211_AMPDU_TX_STOP_CONT) {
+		/*
+		 * The order of flow here is very important here to avoid reorder problem!
+		 * 1) Take single lock to block single traffic
+		 * 2) Stop agg traffic.
+		 * 3) Transfer agg-to-single and push all skbs from agg queue to single queue.
+		 * 4) Transfer BA window pending queue to single queue.
+		 * 5) Release single lock
+		 */
+		spin_lock_bh(&cl_hw->tx_lock_single);
+		cl_txq_agg_stop(cl_sta, tid);
+		cl_txq_transfer_agg_to_single(cl_hw, tx_queue);
+		cl_baw_pending_to_single(cl_hw, cl_sta, baw);
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+	} else {
+		cl_txq_agg_stop(cl_sta, tid);
+		cl_txq_flush_agg(cl_hw, tx_queue, false);
+		cl_baw_pending_purge(baw);
+	}
+
+	cl_tx_amsdu_anchor_reset(&cl_sta->amsdu_anchor[tid]);
+
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+	_cl_ampdu_tx_stop(cl_hw, tx_queue, cl_sta, tid);
+
+out:
+	/* Mandatory callback once we've made our own tear down ops */
+	if (action != IEEE80211_AMPDU_TX_STOP_FLUSH)
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, cl_sta->addr, tid);
+
+	return 0;
+}
+
+#define HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET 3
+#define HE_EXP_MAX 22 /* 2 ^ 22 = 4194304 < 6500631 */
+
+static void _cl_ampdu_size_exp(struct ieee80211_sta *sta,
+			       u8 *ampdu_exp_he,
+			       u8 *ampdu_exp_vht,
+			       u8 *ampdu_exp_ht)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	u8 mac_cap_info3 = he_cap->he_cap_elem.mac_cap_info[3];
+	u8 he_exp;
+
+	if (sta->ht_cap.ht_supported)
+		*ampdu_exp_ht = IEEE80211_HT_MAX_AMPDU_FACTOR + sta->ht_cap.ampdu_factor;
+
+	if (sta->vht_cap.vht_supported) {
+		u32 vht_exp = (sta->vht_cap.cap &
+			       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK) >>
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
+
+		*ampdu_exp_vht = IEEE80211_HT_MAX_AMPDU_FACTOR + vht_exp;
+	}
+
+	he_exp = (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) >>
+		HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET;
+
+	if (sta->vht_cap.vht_supported) {
+		if (he_exp)
+			*ampdu_exp_he = min(IEEE80211_HE_VHT_MAX_AMPDU_FACTOR + he_exp, HE_EXP_MAX);
+		else
+			*ampdu_exp_he = *ampdu_exp_vht;
+	} else if (sta->ht_cap.ht_supported) {
+		if (he_exp)
+			*ampdu_exp_he = IEEE80211_HE_HT_MAX_AMPDU_FACTOR + he_exp;
+		else
+			*ampdu_exp_he = *ampdu_exp_ht;
+	}
+}
+
+static void _cl_ampdu_size_exp_6g(struct ieee80211_sta *sta, u8 *ampdu_exp_he)
+{
+	u8 mac_cap_info3 = sta->he_cap.he_cap_elem.mac_cap_info[3];
+	u8 he_exp_ext = (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) >>
+		HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET;
+
+	if (he_exp_ext) {
+		*ampdu_exp_he = min(IEEE80211_HE_VHT_MAX_AMPDU_FACTOR + he_exp_ext, HE_EXP_MAX);
+	} else {
+		struct ieee80211_he_6ghz_capa *he_6g_cap = &sta->he_6ghz_capa;
+		u8 he_exp_6ghz = (le16_to_cpu(he_6g_cap->capa) &
+				  HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_MASK) >>
+				  HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET;
+
+		*ampdu_exp_he = min(HE_6GHZ_CAP_MAX_AMPDU_LEN_FACTOR + he_exp_6ghz, HE_EXP_MAX);
+	}
+}
+
+void cl_ampdu_size_exp(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+		       u8 *ampdu_exp_he, u8 *ampdu_exp_vht, u8 *ampdu_exp_ht)
+{
+	if (cl_band_is_6g(cl_hw))
+		_cl_ampdu_size_exp_6g(sta, ampdu_exp_he);
+	else
+		_cl_ampdu_size_exp(sta, ampdu_exp_he, ampdu_exp_vht, ampdu_exp_ht);
+
+	cl_dbg_info(cl_hw, "ampdu_size_exp: he = %u, vht = %u, ht = %u\n",
+		    *ampdu_exp_he, *ampdu_exp_vht, *ampdu_exp_ht);
+}
+
-- 
2.36.1

