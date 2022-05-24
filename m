Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1278532934
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiEXLiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiEXLiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484279828
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6ZJsfEfy9B7z88h1pbP7dvUjGAwFVhNjHkn66e8yy11mjtLJWM+Ouc/Qe7gVDhzrz8Uho6r2nuCBOYV3+ssN+t62n5g7alknmX4Otocz4vFSBEHKDN26TsyiVLUp2Z8Ybj1bnlBkSP9F55zP/eu5kKtXmLvgMKBZCCgyeRRfqBAhp8VeJFZILakn4BPqLAnrdhjA60UwVs6Z4jPGu5wwtLHMDiRBcjALCCXgU1guU45AJK8uTI5fe48VFsW5UJxAl8CXVZ6XMuGPSDhMyruhin/mb/KeKLhrB2RRmp7WhLXLJf9mMcMt2ORc/YycrkNSx6ue/waoa2zJQrrRZwE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daaN8cov8RRoxAdX/xwqo1j8Z7No5bLADTD+H4jsGms=;
 b=ZtwVaqyAdOP03YpHnL1A+5a0tdHKGKxqxgHM+E1u4mxyLbZQLuK8sN9dKSvBcosySxZDMsP8AmPmh4vEDEmlWebuJh7XgK+RhJVaN74MswYUHHoNqQwE+J5IPA/egit17bz2EzSsa/biqmPC8ACDtEsj8NpeiKfjoo35yX5jqhpSqDZP1r3rNnl7q4Dyunj5uRHg+uc6qbE38usdfQBTTMMgm5ldvyaqNcZQF3YtVOP/luKhl9DupGe9OgW/nsW7UIdOKPVeTQwKHi1rVGf3UBdRMWp6MrbPEMi61YVYsNmxClLCWuziuD4L0U50TOD6ozzb4eX/CPNFP7cOcruZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daaN8cov8RRoxAdX/xwqo1j8Z7No5bLADTD+H4jsGms=;
 b=n+ftqe7bnidfQYqWlPhqqNyjfvU+/F8HDgg91NlCAK9tHVq8NOLJeh7jAJkHVXULo84v0IzIfRCfSkIJerVsKOMBrQpYtYUOXxgCW1XtXjQI32LonKV0mhJm5XtamdsdXyIxiQ3fDyvKWBhw2jvDiNpCwhxd7ma3ocrEVq0oyCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:38:03 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:03 +0000
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
Subject: [RFC v2 27/96] cl8k: add ela.c
Date:   Tue, 24 May 2022 14:33:53 +0300
Message-Id: <20220524113502.1094459-28-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d0adce3-d62a-47ac-ffed-08da3d79dcd3
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469947C6F3E0F221EC23827F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiaoEEeJwgzvULvx36d04fNE3bjnFZ+oU554uGX7iMFq0YTOqW29laAB6NPy0r5eE4M6sMhkUV6SwiMtwnHgKaj3pOtsMbcPXl3gpTCBY5HwixX2aABNs0EmyUQvt2g5twa7gcRkLPQC0OfkA9CEvJXO4HTRlNhe72bpfPN/VaBBtdmaRj3Eb2zWGq04eVk298qld3FHeZLjRJblZsiA4kdT2vcZBXi8vPrCG2XEhAmVqPDLPh9Bx9R5de1Fzi8V8DtSDSM/mYw7MqtIYVa8TrUNpWYDaCJ5HNF+/MwyW1l+SNRCXoSUYBpF1jS0i1kSOLdshuWTlwaYd9BnJM7WlkF/sx8CGPRx8F1EnKnXJnQzTfcdIYj1Bbb2WX9fwWg4Kwy7ukwTE0GxdRLsPJ5SErPxkVlHpKei8ttx7Kuek1B2eGgswL3fHxdfUh9/HNHbiS2pWCgGhxcDrMSKdt3BgwMlh3NAs9vtDBwu9ZpHWyBHsx2nqBVE00oYBs2+dwJClvS8CoNrdP3hJlMNSp4LHrlUzkh50PkjNMIi+Nl6ReGS4JXutQHD5BRNi/0X48w0zhGjob3PJiVAUO3Ba86K0akf4yorVgG4Va/Zgd+G3Afr9XFNJ9GrRpMlW0VABsO5nIEBvlEd4F+9XLJrE3BdLnQaYSHzrn3rK+G7nZKJQ54bxc1WdZroEulu2Z7c+FhyobNBeVxXBTHvQnCX6OayT4yPM/XXNWBhIlFdS4bWkqaWUCfsCojRrcmyXTaj7zqkmw+9ThrtV48Z8jwI0wMYVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZPq8H0a5CCngy0j6j4wMLHPoDIYvMX2PK+7kn/0Fbj8Nch3sYvJxV6Ol07/?=
 =?us-ascii?Q?cAvG/14Rmqr5rOQdSQnmML2x+km2eG1XpdZmux1deX/udxbOfaWpqYSCUULN?=
 =?us-ascii?Q?qAUBDCwRpW0y9LljCmuKadu6gbQ4niNfrmO/jGhub6rIKMfqpOCo1f7EtBro?=
 =?us-ascii?Q?tCwzkQBfuSf/lx4nC4R/Qx9FmQ0PIlbk7W1Wa75yZ+73m/3fzk/YUY4vuWSf?=
 =?us-ascii?Q?nJoWNt3pOx6GRg4GvODXE0lIcg4W6QqgdferQvx8iOzBtC92b+bbbqU+fgEY?=
 =?us-ascii?Q?M8/IFECpu2tWnfcHu9QS4Ng0OVg02Oc40vTOndm14MV0STKojNbew6KvOlNe?=
 =?us-ascii?Q?4ggn3hm5YiSkluFkhQb5cjWPZQgo8DcYoVcBczsDfbIAN6HKZlDjZDy8HXGk?=
 =?us-ascii?Q?h+6Fn2a3Q/aANnCm8u/tuDXy4LyK42Ts5ETPSglYOaODQqiJMnGEVNs5TLLA?=
 =?us-ascii?Q?gdfvKQfFpiMiZHfB7MkiPu4nQ07bmvL25D0VEpc46D+JnI5tA4Q7iRTTlDl6?=
 =?us-ascii?Q?9wsdnqCkgWODza1T1ejjFJCD+XR+QyUfr8PKNpgjdPkJQGQyC36zbqJwX4tv?=
 =?us-ascii?Q?43Q06cuZRyhTV5hVJGlD7ZuUgaQSph/ES7u3xG4Ng+076sq8pQ0lX+yp43pF?=
 =?us-ascii?Q?XuvY1JP+MX346EvPQISJKkDv802Yyqs9zf3haxapb4NrzNvPzIsQ6+0QFjjo?=
 =?us-ascii?Q?kiYWKCCZYnZvnxRkF43PBMNxmVGOYjrLaMje56fH1durfogXJDlWvFhCOENj?=
 =?us-ascii?Q?3uHUynvNFq+6uiZLH/Vlc7VWz/HWv0Wd/ge+qjLmKa+G77peOwzwuVKtTCOR?=
 =?us-ascii?Q?6RMG3ylbZSGl4+vGb9rhotKtn06JqMs0MUnXkAe2kf//3IPmwrt1EWdN733f?=
 =?us-ascii?Q?Sx+H0+ek7O8h55WHw3+NRHXyVocjZA9hImA5exHesxbbsNgbGO6OrDmUwhty?=
 =?us-ascii?Q?Vnse/GKDPDkoMTz1No7XsZHYaLgiSF3Mjo6R1Flgd4CmZ0LirijScpJKxKbz?=
 =?us-ascii?Q?ZcnN69PkK8Vjkq5wQdUzBAuB+N0TY47JZefK2AGu4o1uNtur5YXdgz16a29b?=
 =?us-ascii?Q?tTDZ5NO1dye5gNRoqrAA51LYcqESbifSR/zA0WtZz+oiLbyR3qagvkeQdCjQ?=
 =?us-ascii?Q?7F5VbeuufpJ/0uNTqhlFXib8IwLNKo6iF7CrWfgvSf37kcGKFVGqdgmmBfI7?=
 =?us-ascii?Q?4HSEKELpXFKgUtmLBU7aIQhOd46rak2k9ALLuKApgNnMBtZKptZPosiK0xBR?=
 =?us-ascii?Q?LdDwUNt27/Wnde+MYuNe78g6XT14tn5YYT3IxDK3YRXR+p7Hl4KD4kP7W+04?=
 =?us-ascii?Q?dtPiL/xh1g2boWwjV5sYmZEke2tidCYgUqwcXWnR+lLfPbCEp0liougispqb?=
 =?us-ascii?Q?QkkIVv6RD1nHmmhi14MgrhI6TDXumkv+puMwYTfMgc4GF6aL5jvVlpRa3ObP?=
 =?us-ascii?Q?XVPlnUVM79u/uhRnt5kSu1XZMWhrtpOHsXTDwjgRxL/Kq3NcelOy2UEQUFac?=
 =?us-ascii?Q?y8YGArrPxtT+H+3OaDLkyMb40qYLDbbmoH2yFiHayRLlZOcM1bLT56jUC46M?=
 =?us-ascii?Q?7CYFuW8bsiWT/2iwf5hWb4MbJBOJuD4IKEsQATM7QrQ7xGBgrhjkCU9gfUuq?=
 =?us-ascii?Q?i1l7exkzrciOJ8ERiHcJ9Ud2o9KedUzxPTe6FJz1RjfPBbEzAuPIIaV3YKjM?=
 =?us-ascii?Q?xkxFQk1C207CgXFVZDckjw7h+PL5UF+Ainw8KeJcJYaAI3e+v+Rkf+t+X4pB?=
 =?us-ascii?Q?C0wkpxqq5b7Rw46h8wimjnpY24tfxqA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0adce3-d62a-47ac-ffed-08da3d79dcd3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:03.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39uwfPDE8BCdwlbREKCHdAAFglEaf0BcKEC8zdmydWy5Tll7hHj5qTwUaAdoTjIx57WB8qAgIAAzEWZkbR5tMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
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
 drivers/net/wireless/celeno/cl8k/ela.c | 230 +++++++++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.c

diff --git a/drivers/net/wireless/celeno/cl8k/ela.c b/drivers/net/wireless/celeno/cl8k/ela.c
new file mode 100644
index 000000000000..c2419b11b5c0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ela.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2021, Celeno Communications Ltd. */
+
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "utils.h"
+#include "ela.h"
+
+#define CL_ELA_MODE_DFLT_ALIAS          "default"
+#define CL_ELA_MODE_DFLT_SYMB_LINK      "lcu_default.conf"
+#define CL_ELA_MODE_DFLT_OFF            "OFF"
+#define CL_ELA_LCU_CONF_TOKENS_CNT      3 /* cmd addr1 addr2 */
+#define CL_ELA_LCU_MEM_WRITE_CMD_STR    "mem_write"
+#define CL_ELA_LCU_MEM_WRITE_CMD_SZ     sizeof(CL_ELA_LCU_MEM_WRITE_CMD_STR)
+#define CL_ELA_LCU_UNKNOWN_CMD_TYPE     0
+#define CL_ELA_LCU_MEM_WRITE_CMD_TYPE   1
+#define CL_ELA_LCU_UNKNOWN_CMD_STR      "unknown"
+
+static int __must_check get_lcu_cmd_type(char *cmd)
+{
+	if (!strncmp(CL_ELA_LCU_MEM_WRITE_CMD_STR, cmd, CL_ELA_LCU_MEM_WRITE_CMD_SZ))
+		return CL_ELA_LCU_MEM_WRITE_CMD_TYPE;
+
+	return CL_ELA_LCU_UNKNOWN_CMD_TYPE;
+}
+
+static int add_lcu_cmd(struct cl_ela_db *ed, u32 type, u32 offset, u32 value)
+{
+	struct cl_lcu_cmd *cmd = NULL;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->type = type;
+	cmd->offset = offset;
+	cmd->value = value;
+
+	list_add_tail(&cmd->cmd_list, &ed->cmd_head);
+
+	return 0;
+}
+
+static void remove_lcu_cmd(struct cl_lcu_cmd *cmd)
+{
+	list_del(&cmd->cmd_list);
+	kfree(cmd);
+}
+
+static void reset_stats(struct cl_ela_db *db)
+{
+	memset(&db->stats, 0, sizeof(db->stats));
+}
+
+static int load_cmds_from_buf(struct cl_chip *chip, char *buf, size_t size)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+	char *line = buf;
+	char cmd[STR_LEN_256B];
+	u32 type = CL_ELA_LCU_UNKNOWN_CMD_TYPE;
+	u32 offset = 0;
+	u32 value = 0;
+	int tokens_cnt = 0;
+	int ret = 0;
+
+	while (line && strlen(line) && (line != (buf + size))) {
+		if ((*line == '#') || (*line == '\n')) {
+			/* Skip comment or blank line */
+			line = strstr(line, "\n") + 1;
+		} else if (*line) {
+			tokens_cnt = sscanf(line, "%s %x %x\n", cmd, &offset, &value);
+			cl_dbg_chip_trace(chip,
+					  "tokens(%d):cmd(%s), offset(0x%X), value(0x%X)\n",
+					  tokens_cnt, cmd, offset, value);
+
+			type = get_lcu_cmd_type(cmd);
+			if (type == CL_ELA_LCU_UNKNOWN_CMD_TYPE) {
+				cl_dbg_chip_trace(chip, "Detected extra token, skipping\n");
+				goto newline;
+			}
+			if (tokens_cnt != CL_ELA_LCU_CONF_TOKENS_CNT) {
+				cl_dbg_chip_err(chip,
+						"Tokens count is wrong! (%d != %d)\n",
+						CL_ELA_LCU_CONF_TOKENS_CNT,
+						tokens_cnt);
+				ret = -EBADMSG;
+				goto exit;
+			}
+
+			ret = add_lcu_cmd(ed, type, offset, value);
+			if (ret)
+				goto exit;
+
+newline:
+			line = strstr(line, "\n") + 1;
+		}
+	}
+
+exit:
+	ed->stats.adaptations_cnt++;
+	return ret;
+}
+
+void cl_ela_lcu_reset(struct cl_chip *chip)
+{
+	lcu_common_sw_rst_set(chip, 0x1);
+
+	if (chip->cl_hw_tcv0)
+		lcu_phy_lcu_sw_rst_set(chip->cl_hw_tcv0, 0x1);
+
+	if (chip->cl_hw_tcv1)
+		lcu_phy_lcu_sw_rst_set(chip->cl_hw_tcv1, 0x1);
+}
+
+void cl_ela_lcu_apply_config(struct cl_chip *chip)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+	struct cl_lcu_cmd *cmd = NULL;
+	unsigned long flags;
+
+	if (!cl_ela_lcu_is_valid_config(chip)) {
+		cl_dbg_chip_err(chip, "Active ELA LCU config is not valid\n");
+		return;
+	}
+
+	/* Extra safety to avoid local CPU interference during LCU reconfiguration */
+	local_irq_save(flags);
+	list_for_each_entry(cmd, &ed->cmd_head, cmd_list) {
+		cl_dbg_chip_info(chip, "Writing cmd (0x%X, 0x%X)\n",
+				 cmd->offset, cmd->value);
+		if (!chip->cl_hw_tcv1 && cl_reg_is_phy_tcv1(cmd->offset)) {
+			ed->stats.tcv1_skips_cnt++;
+			continue;
+		} else if (!chip->cl_hw_tcv0 && cl_reg_is_phy_tcv0(cmd->offset)) {
+			ed->stats.tcv0_skips_cnt++;
+			continue;
+		}
+		cl_reg_write_chip(chip, cmd->offset, cmd->value);
+	}
+	local_irq_restore(flags);
+	ed->stats.applications_cnt++;
+}
+
+bool cl_ela_is_on(struct cl_chip *chip)
+{
+	return !!strncmp(CL_ELA_MODE_DFLT_OFF, chip->conf->ce_ela_mode,
+			 sizeof(chip->conf->ce_ela_mode));
+}
+
+bool cl_ela_is_default(struct cl_chip *chip)
+{
+	return !strncmp(CL_ELA_MODE_DFLT_ALIAS, chip->conf->ce_ela_mode,
+			sizeof(chip->conf->ce_ela_mode));
+}
+
+bool cl_ela_lcu_is_valid_config(struct cl_chip *chip)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+
+	return ed->error_state == 0;
+}
+
+char *cl_ela_lcu_config_name(struct cl_chip *chip)
+{
+	if (!cl_ela_is_on(chip))
+		return CL_ELA_MODE_DFLT_OFF;
+
+	if (cl_ela_is_default(chip))
+		return CL_ELA_MODE_DFLT_SYMB_LINK;
+
+	return chip->conf->ce_ela_mode;
+}
+
+int cl_ela_lcu_config_read(struct cl_chip *chip)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+	char filename[CL_FILENAME_MAX] = {0};
+	size_t size = 0;
+	int ret = 0;
+
+	if (!cl_ela_is_on(chip)) {
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	reset_stats(ed);
+
+	snprintf(filename, sizeof(filename), "%s", cl_ela_lcu_config_name(chip));
+	size = cl_file_open_and_read(chip, filename, &ed->raw_lcu_config);
+	if (!ed->raw_lcu_config) {
+		ret = -ENODATA;
+		goto exit;
+	}
+
+	ret = load_cmds_from_buf(chip, ed->raw_lcu_config, size);
+exit:
+	ed->error_state = ret;
+	return ret;
+}
+
+int cl_ela_init(struct cl_chip *chip)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+	int ret = 0;
+
+	INIT_LIST_HEAD(&ed->cmd_head);
+
+	if (!cl_ela_is_on(chip))
+		return 0;
+
+	ret = cl_ela_lcu_config_read(chip);
+	if (ret == 0) {
+		cl_ela_lcu_reset(chip);
+		cl_ela_lcu_apply_config(chip);
+	}
+
+	return ret;
+}
+
+void cl_ela_deinit(struct cl_chip *chip)
+{
+	struct cl_ela_db *ed = &chip->ela_db;
+	struct cl_lcu_cmd *cmd = NULL, *cmd_tmp = NULL;
+
+	kfree(ed->raw_lcu_config);
+	ed->raw_lcu_config = NULL;
+
+	list_for_each_entry_safe(cmd, cmd_tmp, &ed->cmd_head, cmd_list)
+		remove_lcu_cmd(cmd);
+}
-- 
2.36.1

