Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D253293E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiEXLiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEXLiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897750440
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/3JvZXWJadEnUojua6sfJOdLMkYC/OGK9klydXJcdL9eaw6I3o6tXeE4AtioDGZ/TzOXDV9Ju5SMi7ukmZcP7exoEZEnIvNVJEVaPlB0KzRO8ALtzmFTEpf0RypFtuR28Q6GkzEcm9zWJ2meSI0vYE6QrwwMUn64wTR+JvCmrXA++Xer4uiPIuuq8OmPHak/N6al9FvuYC4EeR1oRtf1jdj5H5qYW2q1I4xkwoRT2TYkXBXTi6GGrASm4i1y2hWsbI4qYFhvmQVFZ6Yft//Fcv43mKWQMJWrf2KnRPHtj2GNGjDIX2wSaBHULTZl1sg8wuwQ9zFjkeshp/qUAe1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfPEhb2GCnLmNZAdirC+WHylsoqoq43L6itd9DV3PLg=;
 b=SkIUoXGsS0+9fiYzgbyPVJIg4j87RyWbRZDBwzIgLOdqYf/gZYCQtf/NQpeSJGVJ4bAWf6JOxedVb6zU/EthBpmgRnMkfso71xx5PEMJhkBYnqOvXAa6Z05wvy9pbSHjKWae5SMwP7Yi/PWuj25Ffg1SIb8kt8NXVodtjkIzRDCvzHssjEbDJGMo4dhrDEl9V2vtZIZGVE1Bm/A9xCqAyVwnfhwFKb7FUSK3oj/0rcsrCLgWavHWCt/FgjqX1LBJyi5KeKBPMtAKdgb0l3Qo5RfQYRHoeVnlb0tKKIYEZFLaplxOHDbTwJ9vyUwFaTRXiEAqgAEMrzoZwFBjWRoTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfPEhb2GCnLmNZAdirC+WHylsoqoq43L6itd9DV3PLg=;
 b=yIirNEwGoRwjlXXoKFFigMq3ztG8iR5n3PrXe3/tHAVA0wPTclTOfGMsFjANosrsIjaJpSfEXlPbOB92A0cjr/J8Xm8DrJuXMcgPw6KRDQ6qtgVXHbuvJA5867gfUPZQqOCwKZfMn4t8Btb7mhG6BYin3K5MU3gmxkac7LIzyY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:38:04 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:04 +0000
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
Subject: [RFC v2 28/96] cl8k: add ela.h
Date:   Tue, 24 May 2022 14:33:54 +0300
Message-Id: <20220524113502.1094459-29-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d0a7bc7-b17d-4ce5-a4d9-08da3d79dd4f
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB03053405BB633C2DDC61394CF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8C60JCvZtPCOG/D6ZERMG+fgmnIEy4JSz8Y6YKGBIkJVsvtQvU7bTRmUhh3zxdrfqLU3Wb10DX9LQI7SNZis70dwBcSGqbqgUjipXGX8pXxykoQngFo4X2eL0Hp+BH71MMvZUgoZVBZS3jSXEPtpUwdqMSUxYu5BXwaywmkJ6RPUlvHjPrCtvBgdhJqsPgBMOSe9dA3JAK3uFiOp8b/SbDVQmCYNiGpWbsQuU60YHVOdtmkfXpTqwREOQb26G+VKD3UI6YZ/58/oG8Cid2+IY9pMrqn1N9obV6NppOz5uAgEGTA2J838bzRr/pnV8vHyJFI6MSrZXroaGaAbX7HS81LEaLGJI+16QYoSRA1A17PXkNHQLP/QdKq8zqnFeONBVzipJRBkTVpfpND78y9fbQxS60LDWheoI0HI5ftOExVslwDVpcKKsOWLKWEiuabSPQFeIlQlfKRWhTHZodMOuHeip2bpaAMUF9mG9wMgFCU4ssvwxEn8LprKv/ZsIp2k5mi9YB8GmgF1IgXUCcDcXsZfmdGdPPpIwFaG1cv2ZHsadGwXS8jDleGUNEcvqmZYvb6FkAk9KA7WWWjPIWxWE5qOdYr3GWOskUoN8MKLpDGJRy5dMmkNr6EUAqJAcqDdxuodzwqoNtdwSNT1826bgulW7qfmNK0v1yidNo7K5rnCy1en/4uWbVIFKCAaqf/3PHA+xzfoxmN8Ch6xbpjDjT2w0wiA8JO7wvJculqr0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AESZ1USAIiemUyp8CC7Kc11guZBtJWNnulhGFv8uQmpoWD0ZjdV9+18G1xH4?=
 =?us-ascii?Q?xiXtOU+KeNO7Nc8LM2iGmDrVRbc4o0NR2fIKOuxGiY99xj/rE0ju0z77bPHP?=
 =?us-ascii?Q?GJExkdU5KaWXLJc2LNA21JBcOURgonXIRhURYplKdUdRP0jxBT59z9VjCIEB?=
 =?us-ascii?Q?/NhYDyDPwC/GdhVFSPCCmVH2r88bRTUmMu4ak5oSjVlNBqysXly28Y4V0NKA?=
 =?us-ascii?Q?mAb1dKb9aJNTkrI6xOsJOyCz5v3yJaKb5bglGLeYcflypJlCdmVG9C/EdiD0?=
 =?us-ascii?Q?xJkqMdno6I3QADX7yfdxXIrrzd/DeVYe9GZGeezy6KZ9b6A8wtyOD0qBMkXd?=
 =?us-ascii?Q?e3u+bxzVRqZgQbKQTenCWcyOaHkx7vd05bHXJ9AMk26g1V7M6bmL9BIDNC2e?=
 =?us-ascii?Q?Kox6VxXuSgV9iMUTZq80ma85Ip2pRwRkYaSjL9A1YcLiOlIvcl7wXV2xoVCl?=
 =?us-ascii?Q?ktJXDb5R4TXwWLrtXByhGvu5zC29r2sLfWZ24giYrgB9WoePFfF7YEIB9vcX?=
 =?us-ascii?Q?PRpYuIfwL0PmO1dL1NAfXKG31KeuZuEYHQURe9OeST017Jad7cqmI5olk+nb?=
 =?us-ascii?Q?S+BmnJtr0eIppCQn5riEWCMuN3unYsci6+yziXXcv3s8OtRXDgzLK+3QtAs0?=
 =?us-ascii?Q?9WbjQm28DuLS+rqkA0YDb456Dsn5aqirT02ui/qSrSeU88ChEZ+AmEhB2CKC?=
 =?us-ascii?Q?ETa1eLKHpcYuwQDsT1A653XzsoRWrxhAHYGBSuRmKNtocTR9XTa3ahFCTOL5?=
 =?us-ascii?Q?elaZ5ftz/WAk2N0k6PhgGvi9IT0vEVDAmbQne3liGriKWy5mUfELxV/x2DOu?=
 =?us-ascii?Q?En4o4tf78OQ2qP26SEZXxbB9W/McbkNvV5F+TC4o222Mth6786ddiMEe40F/?=
 =?us-ascii?Q?DjeL+uk0BWab4bvfxm5aExcSnfXFTtdbdgAd1KbDUOKn64VtwJpNs/+qeXUu?=
 =?us-ascii?Q?pyVR/HCeIT55tRg5+shkdYdTb0dTHQ3WrZpUImOuefvC9qk1QkUZAGFZjbDC?=
 =?us-ascii?Q?N+x190eyk7jSdnIvm5YlSAX3t+sKuc9DL5VMW9HEtuJfboDrqGTEvgJbAhfl?=
 =?us-ascii?Q?XJaTcq1FksLUPn5Ka0vkwbeMK/zHT+C+VOAwr6l7uyVxhoyFwa3xMqTbMedz?=
 =?us-ascii?Q?pQDUJQb+M0iq5ppz9nESz2/tMogdGYbA3dItC/W0UwjkZn9OsrVzrNWtNv0c?=
 =?us-ascii?Q?cbNdDGSBpOqX3Le0eR4Zv4X2AdGttdYBU5r25N40SXNCyzAFm+J2KsEe5Bri?=
 =?us-ascii?Q?jba+8l0G7ha2Zn9PhVPaOYySpUbO4MvIyM4a0aBm34MziALz2x3j69j0Zh79?=
 =?us-ascii?Q?wiExbew0WWoK1T94D/1YQvUmGchkaq/OPWO42bog6fX/wMDdIR/z6+2BioRl?=
 =?us-ascii?Q?g5rcdUxUA5KRFDE6srCPhMd2I0BiK7QFl8llsGX9ehBQ/vYsGNVdm1l1wB1d?=
 =?us-ascii?Q?zLBHh1N8twtTVZAxsBSyx2lPlzw9JfV/SfO+r/RGg7YdtdzDkJAzFrZ4Vh6a?=
 =?us-ascii?Q?XK2+jNAYJ3Ck3sDSy4VIe0bvr2zP5XiNASzbxJjHfJqMAsMSLnk8ZcNIvH0Z?=
 =?us-ascii?Q?R9COJnxvgsjrOAIyRdIWF+dWpZJnhUTGP1DhxcaW3QjWu0NZVAQOSY5oCMKm?=
 =?us-ascii?Q?u4p3Cf4j3pT+ufrH5pSedt76xP5DLZZUXWSmupFgxwFf6bFyxy9I+8Ipr2sm?=
 =?us-ascii?Q?MpZWWQbbQPBtgh3XIkzq6v9gQYndd9OVws4ztVAyiw4QTmp7/vEkj0e+Q+8x?=
 =?us-ascii?Q?vUjkttQUw6G9lye+CkSRInUSPM4O7Wo=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a7bc7-b17d-4ce5-a4d9-08da3d79dd4f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:04.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9c+jr4RkH3oqTX3+xnnzaH+VIjuzMpweAZGOvUVx9r1YDy7aQ+OhZZ3OXlXjl4F8RRt6ZrMtC/Z2390s4YyLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 drivers/net/wireless/celeno/cl8k/ela.h | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.h

diff --git a/drivers/net/wireless/celeno/cl8k/ela.h b/drivers/net/wireless/celeno/cl8k/ela.h
new file mode 100644
index 000000000000..a0886c3a9331
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ela.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_ELA_H
+#define CL_ELA_H
+
+/**
+ * DOC: ELA (=Embedded Logic Analyzer)
+ *
+ * Chip contains built-in ELA with LCU (=Logic Capture Unit), that allows to
+ * collect profiling info. Collected data is aggregated via set of %cl_nlev
+ * elements, and saved inside special dump buffer (described by %cl_coredump)
+ * and fed to the userspace via DEV_COREDUMP subsystem.
+ *
+ * This layer is mandatory since it allows to set properly initial and
+ * post-recovery configuration.
+ */
+
+struct cl_lcu_cmd {
+	u32 type;
+	u32 offset;
+	u32 value;
+	struct list_head cmd_list;
+};
+
+struct cl_ela_db {
+	char *raw_lcu_config;
+	struct list_head cmd_head;
+	struct {
+		u32 adaptations_cnt;
+		u32 applications_cnt;
+		u32 tcv0_skips_cnt;
+		u32 tcv1_skips_cnt;
+	} stats;
+	int error_state;
+};
+
+void cl_ela_lcu_reset(struct cl_chip *chip);
+void cl_ela_lcu_apply_config(struct cl_chip *chip);
+bool cl_ela_is_on(struct cl_chip *chip);
+bool cl_ela_is_default(struct cl_chip *chip);
+bool cl_ela_lcu_is_valid_config(struct cl_chip *chip);
+char *cl_ela_lcu_config_name(struct cl_chip *chip);
+int cl_ela_lcu_config_read(struct cl_chip *chip);
+int cl_ela_init(struct cl_chip *chip);
+void cl_ela_deinit(struct cl_chip *chip);
+
+#endif /* CL_ELA_H */
-- 
2.36.1

