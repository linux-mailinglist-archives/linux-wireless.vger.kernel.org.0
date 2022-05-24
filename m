Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B40532980
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiEXLku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiEXLkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:42 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00080.outbound.protection.outlook.com [40.107.0.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC18CCDC
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZIqz/okfmNOVeNEQV+EXKc/RXuURVqD8SGh7fujNGZbqHQ/T1Qelu5TSyxDgg1rxwKy07CBPGEZwMWKrFPpV/qHKHXUoIiZjHDfK1DuykidFt6S7AOQG5I6mbOXQA5+9u/FAorg6hSPB2grKtOdgua4I/SDjBgnm3c3OUCqrOyN459R6+55ul5Op9K0mhpwxG55Gkmz7U0V56LlIJy258kBpluuUSjFbe6bG/Idf5R1KYZLPoozK4lp1HR5ehNyisDNBNxvSDPVM45bA15A86p/dasELsHET/bGwblOAJ7BNLS62LrJuio9CqwDGxOFF035gIm6hf/+j1FvMaGgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYIF415s1BDyPgeTVJSYpCTcvR9hXJafxy8QLPL4wjs=;
 b=EVxFJsX4jy4QEmGLnKDLC9bNPpp1Rpzc3xRdUAH0UikHFSXur+TBMX5lubkuD5nopLl+Grz0//KVLM/D9elLiNI5aSvbt5yKyA7Th1AkmiPJIP5GQ8U7WA94ptijRW+EdZbNa8wHhHHk+Pg1JDsi2mxqWqLv79j0Y0IHjJFRpiv5Cui0d3QQNodWZyGAzwDdgTLP7Qjwa4ljXLS/yrWtoCqGaZkhNdPJek/bgNn3sjoz3CMtp3Um20TyISnaz7A4pIzXIBCPpt8jzhwEftfCwVsL9o8VRZqlEXgAejqhTrkCOERDX7bn2gUSq6NPdWrTStjJSJTe7T9GXX5COjfK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYIF415s1BDyPgeTVJSYpCTcvR9hXJafxy8QLPL4wjs=;
 b=SzWcryY0GSMMeY3GHRq00dCgHtITtCLSWo2sfugz7vBDwN44XKM9ojLXTuhi1nt8J8yqNzWEo5XhHtSoheryACzoAqIHvltCMe/+nRB0hUKU2N4H0q3LDUfFhpLd1KXIDvOPaTmjEVBiK5w01370KDMGCiOM5+3NNuMqEq2UiGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:06 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:06 +0000
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
Subject: [RFC v2 93/96] cl8k: add vns.h
Date:   Tue, 24 May 2022 14:34:59 +0300
Message-Id: <20220524113502.1094459-94-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: e05b8fe5-4f6c-4399-0bfc-08da3d7a0115
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB1033BC54ECE64BD0A815BFA3F6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIWoPwEYL1e5Sw4B75bsp5wPMkh5ZcwinXX04cpn3rxl9ZoKUN9Diqno5sKk3civAEXh3O7XZZ+7k31j1BGRwYnrWHEI1JF3SEqlqHtuyzFkfsus2CZtdIDpXJJXA6kPz3t7UUWVr6jNtfttcpUZBu5/ZMvYS6PrUnD3ZH/iw5X70ABp9ZLSjjtXpbDE6IqbysEGUARVUBbRppj0M4gGdOE0dCDoM9jXVYGBRN81DEKH76yHPWG7koJELnBAVGJZvqVy82M09AZ9RRhohxpZDR3hTWZF3wO0wA5YBlIXQHjAvzJwJspuhpPohoaHz45+Zc7wzTaz1qhuSrOJxc0m6o27YPB7SlXs/b/zI6plQVFlQV6XCMjLPB2YFfAb/wJ004VnsTD3RM6xg+6GBrxap0oOlcGz/7HTIo+fJ24FN8o5/dOKipNuLQ3o1O3FaQgBbz2ehOe9ilDM+n63mXuMhtf4NfQv2RL0rsyJAwjpYi53Hxh/zwVNBrHlbvjBg2a+03OJUBDeMvi8BCONBsiyzF/9rDo2CG+kpLhQjMNQULif1KTcI3nM7u/CRBRxboqbenp6NouVOmhKk0fncEoEH7lSakLUFcstfhF9jeGw+8ucSEfb1vUTPOIri0EHOs4fSTm61Jm1Ea20IQMhuU6rKrCGIEZAjhExLgnBgx1WunwaBPf9jomhoOjmpfyFgCCAW7LAyBJsweE3ciFfpvRgf2WLzTcQ3rIv3wSmfIonKQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(107886003)(5660300002)(508600001)(83380400001)(8936002)(186003)(1076003)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5qlSosVpEkTkxBOQSpdASPQdyquZj7nfv5n+t9JmnPpyQpMIWsfxhu+6uJt?=
 =?us-ascii?Q?6GiJf6+zQBgIexm9oJsVmlI1UAk18zdaaN/DOUJmDJqD3nRNCdUa/HQxqbTh?=
 =?us-ascii?Q?qNhwFX7tG5L54Bs+6B/2UkZKxuOhdM2EIHw4063H1On5YqCe2H9vCB0RbFe9?=
 =?us-ascii?Q?femWWUvDegepEVOiTcfFrx5I7eckF5Ab0OfnqhvhRerpZsnw1gV945lPCWdD?=
 =?us-ascii?Q?Km5M/B1DHH8X2h9d9BEkjenUgJPEQMMWYUZdNLNExoF1vb0W7FCKELjV22h+?=
 =?us-ascii?Q?qSmd7lvcGWQ0g+3+Hf6sv5S3Rd6ZC9mWFCqXmDQOGKnXDZxTWfyWBLTNEvK9?=
 =?us-ascii?Q?zCAWBy1qUWSAjrsg9E7nhI42SQzHe23qc3IFUwOs8frjW67Hr6hzXZTy0ZQr?=
 =?us-ascii?Q?eVvh+yPTLD0vuBKbJoiiMxp/VnEiLmssyaungvx1jvZWjwjy2UEvfgvJphDi?=
 =?us-ascii?Q?26Q9tg57sqlaUer+yq0U/hFWz7JxDvtuhFdXkKEIUmHXGAj+fT+NE4qvzo2k?=
 =?us-ascii?Q?+Gyh+uSh7pBUTbyFpLd9RSdKKpCvXp+qnzhFL2RunSS0pOlxWq7qyTbQha6/?=
 =?us-ascii?Q?DuTofQ7QFvT5RzY/XReIsJqII6BziFulZacNk5QK+CVKIpe9PS9v0gNabn86?=
 =?us-ascii?Q?j98bVjRVHJKD9SVbl8oSZk4YmGSn5Hjvt4/xkyvDImY8lAhWHEmb/lSZgPKv?=
 =?us-ascii?Q?YeQBnzECOxN1KRsYS8dBoZSyZ3fWcsTne6zPedA8A5MaF+GXpCD8ciYyinEh?=
 =?us-ascii?Q?JG2W5MDOyYmhdOTZ7XfFXDQhFQCzeLiab+F3Wof67iPS+E/r/Z92Tw7rFwC3?=
 =?us-ascii?Q?OBWBaUi1QB2izzWl/ZTkcwH5J4KYZQRTCUFd2457U6EmDYgmtDXos/vqyLKS?=
 =?us-ascii?Q?4GnObLUvhUUoJ+Nc0wFVwkVnrgHxkAnIn9CBvZ+kIUQGb751mFd95mOFh26T?=
 =?us-ascii?Q?NAav++WwleIuKgloEqSNPFcAU/y2roe5qRU25EyN9iSM1OjGCjcwgZWvmB/U?=
 =?us-ascii?Q?oW7nJj4FQVrvnMnNEdlR2fTbDkbpwL2MyNMWLFyPC2UddXYKs5vCtEFVIjK+?=
 =?us-ascii?Q?xqXFNgOkzXZI2zWMSwsxbv5oYLDRiunxWGwDPzUAKi+8JYiTVOU8ciKjw361?=
 =?us-ascii?Q?NrMHa/d8O7Q8Iex1ngaFB2L+qZQkBhoA74Abh91uqwqRt3UlDCQSKsTf2VXB?=
 =?us-ascii?Q?kF7DaSa9H8r7n3ercExCf0SdMuTYaMgvPVMDCCXYWTDd00UlCcqELi9Q6yxz?=
 =?us-ascii?Q?FhQE8H9h9B2mMAhaDOqo/E5wPSlmjPgYVWbk0qzb2JNVUrNU3dBXuA/JWVIk?=
 =?us-ascii?Q?dFPYv00EmQi9Kb0Yak91zn55ZZDwDra0UA7GziQAQSNNgpev0ZOPL77SI0ZN?=
 =?us-ascii?Q?YGeIc4msbz/6pAMxz/aK2zfEcNcgUv+ruXBLcAn20Uj2xBJWbkB2/OThY/1S?=
 =?us-ascii?Q?uFD9aQ/XTu7t/iyXtNrT6Zy9OahtBSMd4QLlvLzpqwkugSs9IU23iAFjHXd+?=
 =?us-ascii?Q?Y33N6ngidEB179bYr97dcRVO/sdb782tS8qfqTNpmzziChqQcikk1l0xslPf?=
 =?us-ascii?Q?QGYjZpJl7X04mxSk7fSC2mBMUoW78pPeXZmMyv8ypdRErFZ8vS2Bkm7rNLCy?=
 =?us-ascii?Q?xI5LuvU19gbnx9ahRV4IyBxwu6Z54VJwQZb1DBUjbgjocpuPZqbauoJ9RCBD?=
 =?us-ascii?Q?HZyokwWnCB16zE3x+OshHSxHET6PTXZORw0d8iZVw0MCe8SmiBb3s1NCljv2?=
 =?us-ascii?Q?PqwkNgDb/4uGlORBXB9gpHMUi8InHuU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05b8fe5-4f6c-4399-0bfc-08da3d7a0115
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:04.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEAm07pCeKRUy+a6EXqGPrIn356JK/kJ7QfzFWfP5OpEMyQRMU/nCrEXYUsmwiJIFVI+hNo8W9klPUYuiXeScw==
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
 drivers/net/wireless/celeno/cl8k/vns.h | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.h

diff --git a/drivers/net/wireless/celeno/cl8k/vns.h b/drivers/net/wireless/celeno/cl8k/vns.h
new file mode 100644
index 000000000000..904fa7a7fe1b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vns.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_VNS_H
+#define CL_VNS_H
+
+#include "def.h"
+
+/**
+ * DOC: VNS (=Very Near STA)
+ *
+ * Feature is responsible for TX power adjustment regarding to the STA
+ * location. Near stations should get signal with lower power to avoid
+ * saturation. Power is contolled for both transmitted data (%VNS_MODE_DATA)
+ * and autoresponse frames (%VNS_AUTO_REPLY), including both cases for
+ * connected and not connected stations.
+ *
+ * In order to determine, whether a station is in VNS range, we rely on the
+ * RSSI values, received from the firmware for every RX frame.
+ */
+
+#define VNS_MODE_DATA       0x1
+#define VNS_MODE_AUTO_REPLY 0x2
+#define VNS_MODE_ALL        (VNS_MODE_DATA | VNS_MODE_AUTO_REPLY)
+
+struct cl_vns_rssi_entry {
+	struct list_head list_all;
+	struct list_head list_addr;
+	unsigned long timestamp;
+	s8 strongset_rssi;
+	u8 addr[ETH_ALEN];
+};
+
+struct cl_vns_mgmt_db {
+	u32 num_entries;
+	struct list_head list_all;
+	struct list_head list_addr[STA_HASH_SIZE];
+};
+
+struct cl_vns_db {
+	bool enable;
+	bool dbg;
+	bool dbg_per_packet;
+	u16 interval_period;
+	spinlock_t lock;
+	struct cl_vns_mgmt_db mgmt_db;
+};
+
+struct cl_vns_sta_db {
+	bool is_very_near;
+	bool prev_decision;
+	s32 rssi_sum[MAX_ANTENNAS];
+	s32 rssi_samples;
+};
+
+int cl_vns_init(struct cl_hw *cl_hw);
+void cl_vns_close(struct cl_hw *cl_hw);
+void cl_vns_maintenance(struct cl_hw *cl_hw);
+void cl_vns_mgmt_handler(struct cl_hw *cl_hw, u8 *addr, s8 rssi[MAX_ANTENNAS]);
+bool cl_vns_is_very_near(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb);
+void cl_vns_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_vns_handle_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS]);
+void cl_vns_recovery(struct cl_hw *cl_hw);
+
+#endif /* CL_VNS_H */
-- 
2.36.1

