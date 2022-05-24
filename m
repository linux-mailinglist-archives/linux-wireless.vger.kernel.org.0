Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695553297E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiEXLky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbiEXLkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0392D2F
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsGGd41TT1QJWhFRwAc9LyLutlu4zfD5o/LpjlXaD6g9OrJa1U7Dyc4OOBA/XxvfnUw/J3RuicVoqbQ6pKnImI6SUJ+ERIppphOMZmeyqsvHj+LUZcduoZXAQSzSCewoXfjFYKqgmwUXD3p348MMwRGqVwNPxSCk5WuAABM+DV4Qh+NhqKx88z7Au8dvk1fvxLapVYdqs+fyBns/be9PI8zmpymxdx3yEDXUpSsIEh6YOGm9Htn0n8fpRDChj9OQwZI7vqRonOS8RYsU3mkmw3iDEGrFZ7I6n7BOf7bEdkyHbEf4oQW6MiYZZb8wn14vE+g+5+QQYGfLSCC5sYAOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWenKMz6sRkGRCEeZNuLRQX0Fpm7HBuV/91nSZIKfWw=;
 b=mKnSMZGlnLJ6WNOJb08BMLalh59Ab5rjhk96eEhMUQRKpLSCKAMDO/mrJgELZb+oTtNbgVXV0wBUMXnxCN1x0p82F82LhWTXSFWu1KdQBBMuEjUrq45PG4cAlUPl8ZKeqx8Y2J2suMa8WkHednC7XvePe1JlsxM0L7ZkU20SUgYZOmwn/KmAIXj9VtJ7LMb2x8FKfPun0E2Tk7FygwWPoSF6I5jQ2xa+xMg1eKXK+K26BBFMDUWPJgJEGYrek751SYu4Tr6YOvd03bHToRGlIfzbNSqkem8PrnNH2OWPac/IdRzWvI978FFe9H4Qi4nPrej6FV6jTVWG/eQ8a9av+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWenKMz6sRkGRCEeZNuLRQX0Fpm7HBuV/91nSZIKfWw=;
 b=bIkn91i3CQecEZO1je+cFWiTps0KBt+0f8Ac1dgoxN1HT8MVh3JGbatyRi5po39SBErYJuYRnRhDvTMMibwidjbtar+s5gAaOqSv8hARiFKXUvWU68/xSw9Os711FNum5jQLtkDyBLlgXSyIivGF9sn4vwkYtDMBFjFIiitjE+o=
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
Subject: [RFC v2 71/96] cl8k: add scan.h
Date:   Tue, 24 May 2022 14:34:37 +0300
Message-Id: <20220524113502.1094459-72-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60798ae7-bd04-43ff-8132-08da3d79f6c9
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB091533BE04775CE5EFCCF11DF6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3Mrl0lwAYie4ueynuHLOZZ5W/ARjWESB3Ttux524C7MkE787W+fbj6r+faN7jFs7SbfLRjhSgz/OV4iZP144gG5o35aH9V3sTKx1nA0ExIiqD6dhM5ao4VVWHmDBYBO/oVro6exp0cyvAnQxONT+Qb+ywoxL2wBf8aZOjtifY1KuwqUNbNLdfu+/vvpD96FF3EZe5p/HDA2P1K0cexK+gBufboLOfdNwulOrIwpisVWusJLgkIfLZkONzkUVUpOxiC8SFXZ1KSrBd0aFwl9B1uQGz2gcjC4/EHaFC/36FzNIZ92zEejo2WOvkA2udiicWtkNRzlpqJqATUh+kxvLYhBlodukNikllNVXEh2MvJfYFWz/fA3TcXHGAn/WmK27BfeKqE5UQAqC1n2kxwQquauWuk7yTQgbcAi5sJ0AGaebPiijOQ7/DEOuc45Gmea41sWAbKK2zM7sHtQvDEZ5KJ07TE3dA/kcRZUkuxqKPI1S1xYvT5XGSsTAUYEiVolxcEjaZXSOLU4BMIAQ8tvxb5Gm5Nd2tax1i4zNMTp3jGovZNQE/qlOFp4WmsZ+sXGzsKNsSW1iwClomso9ffYNiUaRXdzc4LAa7sGhB3lGmtfaPiogwy5Pe8C5cy43Jhaq6VAofJFoGmvhrSZ0zLOHMGA1o32SFc9+5im8EHH1M8P9tZvyUWBJfXKsedDF0D2lZMNLMErst5XR6ujL8gE01KdvydreRBxXIlBgDwOkLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWKTP5y9Y2kMOCADCPCk+U23k/V0swE3ZEzr7nBonhCfsavll/a7xRFCz8Ih?=
 =?us-ascii?Q?eD6wLKkHMpEOz2lPv4Ocy718nQZpXX0iqoYiP7nLxuKdQaTVZgXU3vqLpCt6?=
 =?us-ascii?Q?/JrNJ0GaUF+5vIOpPYlWRwTWPBvWynkvUwPobfONLbZX1bmz/wIkYKL8v3o/?=
 =?us-ascii?Q?JLfoOS0shfSOebA55+dqjX/N+4rz3xyoGWkcH2BiQU/cqkY4w//DgqBcet+7?=
 =?us-ascii?Q?Hm8e+LPtfHO+6jvie3wGsptr5NU9WzUqqxSeokOy0rIRhKQm4ECr70La+2Wx?=
 =?us-ascii?Q?jLts7zem5KqHyR/OP2UgRKh/viGn5otrRSNBfoYO99mO+FiDiFRKflt89l9A?=
 =?us-ascii?Q?DH87VWBYlJXuy2OJxzXZDUlsMSxcj3wRiyS3nsvziAmvBgztZDFMzPV0wbid?=
 =?us-ascii?Q?7PjSovT/Mo3vzTPB9/d/qPDxvHe5d2+G9L3gJvIM3tC9Zd/PQvWdHji4pOWo?=
 =?us-ascii?Q?QLl5TxcEeLTWFZptMyNG6y9OwgWHkgQqizv3qAX9MBQkC7R9Si0h0Gf5IqhI?=
 =?us-ascii?Q?oI+g1O9l5rH749xTm7Q35Pr3jHnROOLFY4v02ulLJldFgxzISu2OMaVMMCNK?=
 =?us-ascii?Q?5QbRQk+QFrZpoyDog/UXPYiF62DNLbqwHSAQ1TwBzNtNJRmYmOPJQHeoHwDc?=
 =?us-ascii?Q?NPmCaEbBjDp4DKBZpRmew0dEaRsuQL8MakRWjA7dc6UbaNw5qK2VUPHURX8m?=
 =?us-ascii?Q?25oGZk1NF1dHhQPp2YZZFJOIyXnHmDBUzzj5dEPD271Wc0XmfTmEQLHbDtVJ?=
 =?us-ascii?Q?AKEKmt5wx37qQski4V2hDMxdJa96zBfMSguR3xCN8jygXFkQoLnhAlCbMU7A?=
 =?us-ascii?Q?7KzajevavH8LCIUivTCQM8g5+P1DJ23dNArc0/7IC9uBsH1Hv2QxlJKhhJ2d?=
 =?us-ascii?Q?8O/xloIdockm0himmX0+7y4Sf2gX2S2C78CNeH8CzewuyX+zBEwstWZuigAJ?=
 =?us-ascii?Q?+xfhcO2yR9EFDjqFLTl6SP6DS2RsbOGzHT21Lgj9JgdofbAlNxL5xkdfI3BA?=
 =?us-ascii?Q?a5UjUUagQMP0Wgdp/Qv1UmgfVIIRUgsLssV+fhDJyRt90bHZ7CkpQZa1bz78?=
 =?us-ascii?Q?LUC4J8F4Bnlz54dSJ/MUZ+RFcqCDccK5jSLxkaV/ZlZPmzE0HWnzTNQW/h1d?=
 =?us-ascii?Q?nuNZyUOLh1xB+ySOn7EW/rs01r+7+hpJ3zu4oeadeAudMz+typsUkUIbX2Sm?=
 =?us-ascii?Q?AQ4ZORG/ARtntQ3KVZ/ezY9By65Jo6rarO/kMHgdrByPAIQnA2vb7W9+bTU4?=
 =?us-ascii?Q?oyZ58L5F5UORT50WokHqlUSdCaiKJMmn7X643yQEJWFT77pfvzAbb17SGEIG?=
 =?us-ascii?Q?8poWA85UNjGNZwusnkdsgO5oHSBFf65ETJZwrLe+FGDxv9qkTEMf3mWjtauh?=
 =?us-ascii?Q?RLhYZvZ4sWRh5NnWAEYe5dW5Egyt8INOSkNg7Ooxgwn6KsuNx1Ag9L1O1Vve?=
 =?us-ascii?Q?RADUfUIrwPLJEOrGnP0dU26rP9goRvgFVlxkz1wLxvtcPSGBw4kDTX44oUHf?=
 =?us-ascii?Q?aWJGMOJBfFyfYA4tS3wKIzZXXfkBILbjWta+XnUwDEy9F8wXOeE74Xc2ff0A?=
 =?us-ascii?Q?jLzhLn7pgykjQmS2+gFdx2HPhsl5f4ErmdSzibgvBqTrSHpTCn9k5wUmpvvQ?=
 =?us-ascii?Q?TKFvhzSqsjUMHGBmfL+5XTjKGCcx5SBIWOgVo/1kyj/OP6S3LA5vMFoL3eBv?=
 =?us-ascii?Q?FR5Df0DQU1JWlpSSrQws67przyNcBfzv2PBDOK7DpZVigFSmMR/888d2j/og?=
 =?us-ascii?Q?ot+gbeQw7eJZDr6eOKAacig/k6+yvsc=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60798ae7-bd04-43ff-8132-08da3d79f6c9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:46.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G17TUoo5T0Wmea2qOJXGO4Lf4LPeesVpWCd0C/9C100HEhv7vzPzerdC3oyMElux1LREJKa3REg2UdXbD+fo3A==
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
 drivers/net/wireless/celeno/cl8k/scan.h | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/scan.h

diff --git a/drivers/net/wireless/celeno/cl8k/scan.h b/drivers/net/wireless/celeno/cl8k/scan.h
new file mode 100644
index 000000000000..857e1cfc1745
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/scan.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_SCAN_H
+#define CL_SCAN_H
+
+#include <linux/kthread.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+
+#include "channel.h"
+
+struct cl_chan_scanner {
+	struct cl_channel_stats channels[MAX_CHANNELS];
+	enum cl_channel_bw scan_bw;
+	u8 channels_num;
+	u8 scan_channels_num;
+	u8 curr_ch_idx;
+
+	struct task_struct *scan_thread;
+	atomic_t scan_thread_busy;
+
+	u32 scan_time;
+	u32 wait_time;
+
+	bool scans_enabled;
+	bool scan_aborted;
+	struct completion abort_completion;
+
+	u8 prescan_bw;
+	u32 prescan_channel;
+
+	wait_queue_head_t wq;
+	struct cl_hw *cl_hw;
+
+	void (*completion_cb)(struct cl_hw *cl_hw, void *arg);
+	void *completion_arg;
+};
+
+/* Use CHNL scan_bw =_BW_MAX to perform scan on current bandwidth */
+s32 cl_trigger_off_channel_scan(struct cl_chan_scanner *scanner, u32 scan_time, u32 wait_time,
+				const u8 *channels, enum cl_channel_bw scan_bw, u8 channels_num,
+				void (*completion_cb)(struct cl_hw *cl_hw, void *arg),
+				void *completion_arg);
+void cl_abort_scan(struct cl_chan_scanner *scanner);
+int cl_scanner_init(struct cl_hw *cl_hw);
+void cl_scanner_deinit(struct cl_hw *cl_hw);
+int cl_scan_channel_switch(struct cl_hw *cl_hw, u8 channel, u8 bw, bool allow_recalib);
+bool cl_is_scan_in_progress(const struct cl_chan_scanner *scanner);
+
+#endif /* CL_SCAN_H */
-- 
2.36.1

