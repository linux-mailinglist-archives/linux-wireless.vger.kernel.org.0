Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0679532951
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiEXLjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiEXLjq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829441F81
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NozRaV399Llfr/B185YuROSaEhp8giLZGGxojeYASKOvfLL32hvsoHrbtSsEBipHmPKNgsIB6IkZQ76leZ6dpS2zU3L1xCqSXx6F2asQ5+9g4o8UxAV/X0c2bBfKZi8S8s+TUTdqmb4FIqjzu3h5r0F/h2ITb5PMvDJYyGx/ZQ0MA0x5pFdrvY32s2P/CN1FbWZk+AdFVX3SDep6trssVsofm0zqqwPppN2v1deZAH4oTL26fVlV0C0qGZ2xc+FshdLp1gT/vMwc/YpjXGYNE3NTSGK6+VZPpqd35tWGqWnvMWZIGTv+lova6Upv37IP7m6RUXL2hSE8mJdJi6TF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Zcz7jJOp44uHsXdmERQ5BchjseNQnAvpdC03MLf4g=;
 b=jMrXg0IKay6BsmU+vpwD+LOzKtVsMXhboi0xypOIJAz+w7gfaUmNEyR2LF5XG3GuDha8mx0mGcteonurkPuTH0tOlARcgQbbqn7rWhOMDeaq1vpjq4MNMvp7m3gjQ3kgIjvAAAoVQNjDL7qOLtVFNZTnxTEB06ZQsMiVfDBzYanzneE87oIC0rs4EBkTajN/rG9jdzVNJWOeJp/RdftwIVh36IfFebyQVrcBz8w32gcFuFf1GVIe8v9yUApi27TZqcYpN0eadK5l0TBQNH2zlIVnddkTDrza3r+bNXdUmrMp0ybhAFtb/b/LOjw/7sLBRJYX9cmfkTFLOv02Bo8Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Zcz7jJOp44uHsXdmERQ5BchjseNQnAvpdC03MLf4g=;
 b=GvDJ0MxMPy4NEjHSM0LAtFzwKqAlPbhHpY9DT2O2BNPNUHuP+BGEAN2IcGQQZ8nQq2A3XM68xEdS1k9ooFWV7XF66jRHXEEKsn81lWsjKN6zKtkeCu1O0+1oF+pN2aS+t+doApbxbiT0NIFrSDiGYaUQDbwXLNotFgTE7IPZSew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:24 +0000
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
Subject: [RFC v2 63/96] cl8k: add regdom.h
Date:   Tue, 24 May 2022 14:34:29 +0300
Message-Id: <20220524113502.1094459-64-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2994a499-edb1-45f7-afc1-08da3d79f287
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915618A7F6DE0AEDFC80506F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pU7JO73yxJv5UggH3EBJ8/ZIVmjTcyHT2tJU1L/tu1pxKV8jMukQnpNQsYMd8/s0tO7tfIJpTgwvUzie30PziINTJ8MgIcipADL9rirNx3uX6DENy+sS144v4Gg8tycUl67XBoKR/aAXlB0hyJ1O6wU6c2+bhV+/SpJUvenjVJjzeolFdqZUyme9b+j/OR3gIkXT5ugNodlHLUscvB5jPtppryvuCunUIVHAB9razksx1bNSfg58lEzbGAwWKVH2Fpn9rX3JDUxDHpEc05mgtWI6rzImeFViBPkko3pW631867zTEoRDzXE0BIGabzjthqMZulD4mM3qgzsRIrmMeYwK0GA7mpC+zeyplK8OV6YJUHANQclBLHOnx51mBRjlULDhj24mSKYrakDdgnONHkWUbmSDoYl/NGYVVhpW8i6xN0MRYNohFWIpL/ClPO9yFuzAwXQxyhZGTcUCkEqJ2x2VKUVyBXCsGBkkyY3v+ws/bVQO7vZp95wB7XrOWz65YwgTcjgh21VflreQ3L7WLoxefG84mRYw1TRZh1MAbWzQo+7yd20PZ7cl4jJlDqzJgCvmS6TfQAbkNuEE4GG7Ewco5JFwupnKQPWod9NSEBOVLZicnYhN4J/qEI++CPNhS0KStF9yDsb0KVNmaHl4kYmxBpuPvC7tHdMh0A5l2PL+F/O+3c5RuYWgZklir5O3i2pA+1JiO/4Ymm6aRdt+5Zjgc0KEPFNQNcdfKIhmgfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(4744005)(1076003)(6916009)(41300700001)(66946007)(8936002)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leLugU6z10WVJf3OQ2dte4pAdWwh/oTowDKw7nwWdPC1Yhhm0Zs/tStQ/rOt?=
 =?us-ascii?Q?tQzc1JXRrWg/lOFlEOlBB2n7SEI2+CxQTPD1qmL1f5wpv5PdWLWCaTK1gtaJ?=
 =?us-ascii?Q?iUFnx1R3o28nqFBi2boLURnKd701MR1GGugJQw2KsF7OH/n1kt1bjnzHRAZ2?=
 =?us-ascii?Q?9tWC+7ze9oqCmhoYfI8sirhOlIzthDxhvCyW1TFb+6YTSHNpxytqzX3v/rcG?=
 =?us-ascii?Q?u3kQ0+FAJEVQsUg7kSkwRaFC2Wucp6FQEYDOivqgsF5zgZYMcA6srPvrg9Bd?=
 =?us-ascii?Q?54W6aAAREEKww8h36rFaqn2vkCZsWZnQG9YBAPrYSPD8naUrFX5oclHmDSBI?=
 =?us-ascii?Q?CGDvMeGAbPdFqXDpn5EbIvkqpb7DuCNGjY/nsgCbOe9VRMNbcCVnRVyj+9sl?=
 =?us-ascii?Q?qwTce3xCo7lbxts4LcdD1vLuaS7VspCc9B/uF3Cya+AxqxieqUeQSyBfAlfW?=
 =?us-ascii?Q?YG84pln5C6sF6j+SdeEc79RTSxRMCSmYx6Os7fiui1uSxjNKCQBwla42BRJ+?=
 =?us-ascii?Q?gK1ynbivZPHWOHrfGtJklBdZBUrHViWmkk0QaH7qrWoMlZrjenCssiBFH2uV?=
 =?us-ascii?Q?EWX+qkobN810kajuyYOm+stNuOKF+OMs7hkUUxz2aotlo/LIriyMOFYNV61X?=
 =?us-ascii?Q?Oxun+0mKEISHySscTw5ZlCk/Ja8bpqa6jn+2kW4Gwb2xfcjP7hXz9aeyb1Ir?=
 =?us-ascii?Q?3ZWs5T2lS5/MfSirgu3SZipMFMkrIAu/b5Sjm1gCQ6khD7fVLZe84eC4SavE?=
 =?us-ascii?Q?aeVDLbQJQ1EDONwuXOCNhpeO1+4So6ali7S8DuvocEfYP4axyeRQQrRKoiAx?=
 =?us-ascii?Q?69G+jdDe2OHXC2S/H9M4B6f5/g1JkAKovoyeSxukp9yHkQZMV9XbC64W9HC5?=
 =?us-ascii?Q?t4NMbKY/c+cFfAjJyesgXqioRJDHuAM8IlPm+tz71qcBObQtAn82YeI250ME?=
 =?us-ascii?Q?eteHrZofYOvKad3tXebqr405YyICAFINSxE0ojNZJYb9jjqiYF46iP99/dNq?=
 =?us-ascii?Q?Vx3pm19z7lyL4ORtzXvF11Qa2CLo8AxbuOlAg+3b0ylG2fgPNaZ5ei5QmSQ9?=
 =?us-ascii?Q?+j4dTinwLKw8egk/wlri+jAlnzJnrz79MTLDsXQdwFb0z2TvE9mGOkvX25lr?=
 =?us-ascii?Q?ip8obo/76nooaHeLAcOFm2XbhgjVoPkauOHrXYuPU8zHi5tSdRNZH5r0c7ac?=
 =?us-ascii?Q?ewgupQncqt8uQqrrg0fraAIyWOsMQ4HWU2rBBDuQHnpiFDpo7mGGngq34mn6?=
 =?us-ascii?Q?fVNxQU+T+Y2zW0JpL40XxKZTK5+xaXkp6L2HyEEGOFr4aEVnR0RGMYGlPfcN?=
 =?us-ascii?Q?2ich2REHCgmEPcuMsxBJ+U8OcGyjALXOWhnEt06SI4bBznfl0GnUcP4iBimi?=
 =?us-ascii?Q?O4k2jL4UDJZkZuRCuMh3X6tr/782yegJ8vSsxnOQeqtlQ6dBKgaVdT9TVuBz?=
 =?us-ascii?Q?+dcujCNXT5vMO9sVY3BDjazUhzi31/Z5kIEka2PgS6SzyjWalaQ55AmJsMkf?=
 =?us-ascii?Q?biDoWuNdUTiXhvd3SLsbFkhPznbSlHI3UlKu13V80glK5KqYu2jdRnd2/6lT?=
 =?us-ascii?Q?Ma9Go8XJj6iFzvarY82eQ8Jv01OQjxGPDd2oKtA0sNvRUkWlfBudc5cz/cYN?=
 =?us-ascii?Q?l9WGQ2hzxHPJgYaidSW5aeEuMAwsScE4lTjFSEoD93TzSlJHtuNkt3TlIpLY?=
 =?us-ascii?Q?zLOdQq1iX1QLbImoeZ0fTE3NYlax4whOfMVIaVPU9oVnDvMNXDRlxfAl0gAX?=
 =?us-ascii?Q?/6pVbIabIxETKCx7FZLMBd7VE0bLxys=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2994a499-edb1-45f7-afc1-08da3d79f287
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:39.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4TRJeRi66B039HsBE/ocHsyzMqi3NXTHsVQWpAJdJqoTbmeyRxLyu8swVUq+K7ENtaKwjRG6V76MfuBRc5EgQ==
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
 drivers/net/wireless/celeno/cl8k/regdom.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/regdom.h

diff --git a/drivers/net/wireless/celeno/cl8k/regdom.h b/drivers/net/wireless/celeno/cl8k/regdom.h
new file mode 100644
index 000000000000..0a063716ef4f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/regdom.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_REGDOM_H
+#define CL_REGDOM_H
+
+int cl_regd_init(struct cl_hw *cl_hw, struct wiphy *wiphy);
+void cl_regd_set(struct cl_hw *cl_hw, struct ieee80211_regdomain *rd,
+		 struct regulatory_request *request);
+
+#endif /* CL_REGDOM_H */
-- 
2.36.1

