Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF5532964
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiEXLkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiEXLkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9339347A
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecfibF+oT7v2poIJNkNSLUrFFaNRyfUQ+EpLiwan8Oj7KCc/rGNkuSwy0Uu0G+7fkBKQ/qqM/GY79XysFhDZViLMTApIcWSMGn+q/VksKFeFGtVhsP4cTe78y42Qe1HYwvvlzZB8sm/ByMCIZijKg3zxASINNKbElFZ6rf+hruJM2AL0J7/TxyI6na0gKauoh5Mq7Is3P0Mcq+27CfQ5fbr7aDh+T1zYpAJv1Ixfi9AVsObTxkUyw+gtZxqlv5dO4pxlx96sQs2lZjEtIe71d8eGD8EjzazECi9fM/y0cbZNCB8lBvmIelQtDejAnCK+Sr5YXCJnAqdcTyoKxIMUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sfqBqthfKltNiBd3RvGRGTDowfw7pLuSZ4n6NX/EeY=;
 b=BpwD+SjxAFEDyaGsMSTe7ldZW25tU67j4FWJ7bUZguQ+8zaUr8mT1vWayMZIEHQl8VlP3pb7zLreDmpgebgSsLLIVuOjmlnzmukN5L+pqIx5dc1D2bM2z8BCiJin82ri28IUecufhhJ7digB3LtijeMHsi/6cgChVhgHbPF/2Q5Q2/7VqeIqVK2O4ZsW83SFUu//yOJ+FAjUo9LAOe7GTEut9ZlDa+7NMx3fYqNIqXNV4v8xb3wDnKVXBaQNfgN4aq9OmZKRoj668k6CG9gpqgUIxHlBtml+8PAXpx+wSXgsduuSTJlihZpdx4rrnFwIzYmcXOcZQZuVDx3xZind9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sfqBqthfKltNiBd3RvGRGTDowfw7pLuSZ4n6NX/EeY=;
 b=OCmXVIMK10bDREw+0HCo/V+jSrlIcAf3Y9paM+azCWv/zbZCT9acfevwI/dUmktosjvduIDui+nkK50AzrMdgmWe0nWnkxLXg5H88eiDTqeTo7cXnvzNHiuUrQ2f9f9OAqBDOFllOvcvz0BYPQKQ1kp1iomHgMhXbW7ioBwPshM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:25 +0000
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
Subject: [RFC v2 67/96] cl8k: add rfic.h
Date:   Tue, 24 May 2022 14:34:33 +0300
Message-Id: <20220524113502.1094459-68-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4abede78-bd41-437d-a188-08da3d79f4a0
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915AAC557CEC8A001DD8E09F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZVZ7NV/vWdjvKlxCLnAYFRuCR7AnaCXNgHQGva031HhpiR8Zrt5Hb9rBhocq/JlR19knUMm5slbhfkOf6ZqtpJmjzaQew0iXcCz/WQT1PHMUb+FyIc4T8AEwBQy4kSrB6SkXf1XUKqvzEzuWBdz39eSm9f/mssBnYtTQb5u92m8HHnLWDiqB5fVJw93FZBI+xOU/hTdShCBUqY82tMEC46tFQmVx9dI+nCdLaihaMkG6HZTypuz6ORJDRSTUg9Ly93PTrkrDpdNS/RVauu9rjYdLMkW3y9clQ1bJ4zogF7P2HIzKjel7jm3rSnW6PLzS2fZe3ZcVuhohtoTJ2dS1ZR/LfpSshHmyDKgUriY/89QWmKUVqyo9j0P3bax/0mpo82dEmwkbNxG4FLtB5tzrg9MtlUNsTbi9ISQw+WI1sQYnGvkgjFxHOTOv2JNDZRONPEFbqFhQ8jERTrxngRUueHEfoNVRvaryFN+LqQ+hDVz1gR7bZ5svtVUge1Y68Y4DQNl1yCirLvLlIFF771tL8meWKicQLYaTHBYA6GDDPqu5TEhZ+L+DsNMxpm00Tw4aEvuyB7kv/PSQLqQG3/uVt92X8XbW6TbBM6gVJO8tNc76V3clrRWu+pG0SEydnNIW356dS/hTicovwha1HinJP9TQTKXBO0l7+JoVBHK9AZT7g8JgUCkhOBEXT2p1X/wnmHPXG4oE+rxobmtWMXUUqCoIv1Y4nqVdzUHkHB2p+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voanQE+X5ed7Vo7o3fflAy/3B6/cLBynZQv5IfjQORSb426bMFmpL5kWwKX6?=
 =?us-ascii?Q?wrxrgBLpxvduYkkjRCpNjVK0LyPARGq/qzY107Oq9XKKvCxixeAXIv9Zfkc6?=
 =?us-ascii?Q?+r6OTIj/3rw/pMCmPVp21ikJIHS2FW5QtrIFYPgf/aHwFZDnu++L1aLIL++/?=
 =?us-ascii?Q?LGGCbxKkN9w3r0OEP7hapQABz+AIHXSUwApAu+uVnPkL0KW0mtboxLlCiNbz?=
 =?us-ascii?Q?w2s8xoiWMxgLWvUCaQA1YhVjotKNbR1SJ6aeKU8l4Bn3knMRm2j0z7Qiya9m?=
 =?us-ascii?Q?hnuygRpattoi1Mwtdk3GiTMQCMlyRdTLHwN1OSJ7J7zmI+d4y0Gdt565l+hR?=
 =?us-ascii?Q?1YAgwaSHi9sZQsB16eO/TmmEpNlzGnI8Eb/YCnDFSQVB/b9sE079N6EPjuhw?=
 =?us-ascii?Q?zgvm7mK3G68qbTvSCzTYGCXbuImin8eZHfm/Qi4oMPdROOhVzNdcYQBmRW+f?=
 =?us-ascii?Q?aGrgfSIS43InG/MAn8gprL1QmAK7R9SyIJyFizNUioUMtcKT6XtGTqdAVMY1?=
 =?us-ascii?Q?33M1NWbXQzQ8vGzjxBo97xW9Pw8hF75ouIY++suIz0Gw5yKaFMQMpiOGBP/u?=
 =?us-ascii?Q?0EUXmWU/tANioGT3Bxy75SWVXrMGMcP0GaUp8g6AfcdrG5poLd1PItdljVAS?=
 =?us-ascii?Q?Y6IXvTCZYh/farfvz7q2GkNLNCqM0xahATgVqPQb8Np1Ld2MhRi96uA0CuRe?=
 =?us-ascii?Q?VxwUEujKA/xZYNAgMWpDJORDLou+0t+ZGOgOdV32gjLECtcj6T+XYXoj1i/R?=
 =?us-ascii?Q?Fk8ieN4SA7N5jmSK/jH7j72HfuN2RFCEba7i1NObnINmaudvVTCgFgmiTJik?=
 =?us-ascii?Q?9vfpSeqbMrjGdlDom2uv0eSADc52jxNVhWt9LsXMlnwdWtca+wahTVJRHgil?=
 =?us-ascii?Q?9cU0FtmZF3AxiGC3yw1tNawl7qokh5zHzyS63ecPAE/ogZG/0A4X4MgALNnd?=
 =?us-ascii?Q?+E2IRO/SQmVEqS0NhSV6DS5456IwpYbEehtFAX0AjlWZBiW+YT6ScSzAdOzp?=
 =?us-ascii?Q?raQMO/8HuwCp8lJsm1mmChSR226pbrrPSJ8fF0BpX6Y1W6GubvS/LVmVcK9q?=
 =?us-ascii?Q?z/Tm29ae5X/DfGWTEkReQO5G/gvTNN4Qy0eWY0ettn2Ft5oaQwDG72wfmXH3?=
 =?us-ascii?Q?/yNJFh/MGSZ8jppWtyZ10CgnQJvVtjQMLTEOkp7VXrri62wcP+N1cDo8LhT3?=
 =?us-ascii?Q?BZXRvKFnYlbm+J5msx3ksKpUJA8ih1Mz2TB+v82Q+gMYcVe4KkdOHbAbmpaO?=
 =?us-ascii?Q?Yi8hh6PK0KfD+6wZ8XkIv2v+HW086TzyEBKoDC3z4iG1Ttpt2wXk9VYg6FwY?=
 =?us-ascii?Q?ObfzX7ijJuuI4I939HgauZJSy6uoAdg57WueFaLENmkzloFZTyBVaJlegYEI?=
 =?us-ascii?Q?R+Q3CLZVx3uirGcj7sw7MTnISsubeEsLw+Tac4Gc93E5GaSfT/TwSaLLRasr?=
 =?us-ascii?Q?4hRXtFin8Od3amZMZ/3kfWm1jt/KvChGBkSzvR6rS4fsQ+w6vlMx4ZNZDfIW?=
 =?us-ascii?Q?S8x0EmavYMo2GRzymsg3mejdD/a4kIaTH+qZW8htvrGVrMH7UdtUeKpY2rF9?=
 =?us-ascii?Q?IRMIDGlCinNrUEUF+8X99E9lfEY0wiTti9qrs3prC5pEU3/aPMj6+Zxq+4YG?=
 =?us-ascii?Q?XQbLsts5wOsuPiSp8Gx1lcNAtgARjNYLQs01U+KNs5uS3fcRo7H2+3S9sy+0?=
 =?us-ascii?Q?jSF5Q8mZFVYg5pZOyexpkfukm50Yp0JIhCkRcSerXsDt2Bjy8rGszG0mhJxN?=
 =?us-ascii?Q?+TOl2XncYeAdU67S2sFBjCrQ8pygzws=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abede78-bd41-437d-a188-08da3d79f4a0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:43.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hf3N87l43+4CZ56JPwZ9/TKANAC7lCWUfhnJYy7hMbKNp+8pPEe8g4YFUV+sdr/kmHlwuuw4IEMgIEE2903gg==
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
 drivers/net/wireless/celeno/cl8k/rfic.h | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rfic.h

diff --git a/drivers/net/wireless/celeno/cl8k/rfic.h b/drivers/net/wireless/celeno/cl8k/rfic.h
new file mode 100644
index 000000000000..686ebd6fcd98
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rfic.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_RFIC_H
+#define CL_RFIC_H
+
+#include "hw.h"
+
+#define ATHOS_A_VER    0xB1
+#define ATHOS_B_VER    0xB2
+
+enum cl_rf_overwrite_cmd {
+	OVERWRITE_DONE,
+	SPI_RD_CMD,
+	SPI_WR_CMD,
+	GCU_WR_CMD,
+	RIU_WR_CMD,
+	UDELAY_CMD,
+	GEN_WR_CMD,
+	RF_OVERWRITE_CMD_MAX = OVERWRITE_DONE
+};
+
+int cl_spi_driver_read_byte(struct cl_hw *cl_hw, u8 page, u8 addr, u8 *val);
+int cl_spi_read(struct cl_hw *cl_hw, u8 page, u8 addr, u8 *val);
+int cl_rfic_read_overwrite_file(struct cl_hw *cl_hw,
+				struct cl_rf_reg_overwrite_info *info,
+				bool init);
+void cl_chip_set_rfic_version(struct cl_hw *cl_hw);
+#endif /* CL_RFIC_H */
-- 
2.36.1

