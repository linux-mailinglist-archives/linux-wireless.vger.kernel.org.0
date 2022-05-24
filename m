Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8C532940
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiEXLiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiEXLiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F68CCCF
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK74rTsn1WRQVC2r5rRE7rpIo46/fRNfddVd8OQ3hMvD4H0PZd9Lm8c1RBmesVZf7NGm+dQ64j5dwi+PYb6otWJSBFLVdNCHeqRHNMPZErwk8iDULm//7wwjPoH1Zsm68/rUeP9YSGuhoWU831b6m52tJ+nhD11d0c8g8DGFRH7lnRjdCpSRwJmrYI+NOPevd1wbWhfObfH7ozorflTmIJ7t+aaDomXvw0d+rfwOeFvqePFR9fXoTGgyC2D1mk3ILxVfnvQf6iXCtprIABo7yys7InFkIrzXZqCffdLq4ox/vSkYenESFazqvG27ZwCoLkOtWsUaYN4XglYUYEr43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co7LvVuHe8CONzs7QyYAq8Y2I8T5eAave9eAfyV0OEA=;
 b=nri3IsI6R2cthe6MU/PhXxoMtE3z1yyry97I8t+tAl8n9SSbhUGJ0/6QufyCkj3ViFNG2QG+BZMTbSD3rWNuMLYsZqbHkTAZGUf+AFucofpdiIW3gDdxJpI5Fzjr6sLHkLVm6wQ5kBIteWTsyWPSkr07AQuuezwazcRH/g1ICHPOOP41RbVYTSpFp6kH11g1aRcgg0BzK0BZ0NEUWDt7Of3zX6cIThYriInPHU78rR+dBZc22gEyeWQKrdCA4R5krCqE+lOKsHNgVY4O/s0DhDo9Ie8fkZieltxG0qgK6orYBqzsiyyOHQAFQJ11FROYj+Rv5HeH/EMGmWG0iVEekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co7LvVuHe8CONzs7QyYAq8Y2I8T5eAave9eAfyV0OEA=;
 b=3Ivzs3VH1kqHZcwWvWNVpWCcMAli1jEiiEPUJgxD1unGe37hl09T4Mk6k/jKtoYe2fnnSGNLGjpI712vXakyA2TBZaDLAuE7rx5j/feirsH7oxECQPWSVz5DPTejkxH7qwYOn04hFSiwzNd/av7lo8Ms/O5gNgKc/3NlYBC3bkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:53 +0000
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
Subject: [RFC v2 15/96] cl8k: add config.c
Date:   Tue, 24 May 2022 14:33:41 +0300
Message-Id: <20220524113502.1094459-16-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b16ff473-d815-4edc-369d-08da3d79d72c
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469C69003CE38AF710BDE89F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9Fa3nR5MAGvJdDLUpVVXHn0lf9R4oVzqYqXpkoLbBqKCthXzQvwmDXvMe4KqKe90LXwlF0pBs35++J3Q0I+QfZxLXrkc+WsQ4Qd1FxW2yg23HYP2K8JrTGXs2Px9rKHeRz5fiorWXo7005KnEU8lZX22GzG7F2t37JfzA7QABOcCvy+7XJ8y30trZ9oECxDGB1DmGOiNeOowwlhJff9dylpmLWtEtVK013P2x+3cRFThy0KkR+aA4lnQYvsJte2vtaqMVh0e+CotrVeaQE1YJhH4lqQFx09Ps7Lt+A1UyzOw1K+zRnRCou7u/rcagXxyu14cH2OhRPIFOMJtEo4oeoccUab45DrTMpE87KzuMAs1q+U0zry5bqpiHdwuaRLXCqH5PS3x/IHFbxbHLbva8uovJtxwWYO/mIjWkOa5iqiMbSvk+lXLtOPe5Hfk7X2UJc5FzS/qcwG9JK7iyJTAmGvk5GQ5Q7gWr6IpJtBAiN/WQFvj9614pifbcKxRarLCjHn9nFyr+Ce4Td7diIQl6VAR4MXaqzmN4dn6yXj9akr+JCvZwC/ypbVq5kX1snzWp6pSMz5lvAdsUhvCUMY+2pTzCl+c48Tl0R+Jj/pi1PBa6tMEWnXCqwokkeXmMkOllLIHb0d+FEerrX1rPO6yVMXty5hDRbju2qF9Anq2Blht+olk7TyiVJdpkyECoZfcbYVDwVE4AIxw31nQqiYKrsuFIOg3npQ50fohMUkE0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXdaXMHcSATpxgI4z4Lqk2Cd8qTXTLfruXZH3SlHZbXFYQE6fDvLQ/0NthBE?=
 =?us-ascii?Q?i101ArrscKOLyWBszMLocH351dYYSwlAGhSsXEJH27x3pqfdvQ3n/KMJtSLb?=
 =?us-ascii?Q?i7ge7g6nIGb5+x850defj69m+WK0ogy5uuEgQYTGUPg/jjvFuheJEXkHEp39?=
 =?us-ascii?Q?Xv7pYO+j3eKZA02FdpIQrbygdPW9cSV4rFTCI6grPmyokB52w2uydPFugs3x?=
 =?us-ascii?Q?xl/7aCs0MSq0LR4DaGTQeGXtDq06hwoZpEKgDr4s1/0OfxYLdeuG2O0X6EiF?=
 =?us-ascii?Q?9XsgvQGQnGN+VdaB47LKAAhqoeLZr2rwUq9ng6mAlMRTFbPhAIqKrQ5PeKAz?=
 =?us-ascii?Q?7htwyb2M2kRcDfG4omIe4Avf2492miG66DwEzegVOlyQ+a6FWTwzTVeGZ+1n?=
 =?us-ascii?Q?T9PDI1ETa9bvuiTQbBYvW4VDE14CE3pjPhyTcuUQCAjYiatRl41lTRhhVspW?=
 =?us-ascii?Q?nSruQrj3Fla/YYBXVs5GswNUEkZtJGjAwq+kleqvpEpaQJn55QPLrO86vMkK?=
 =?us-ascii?Q?qWKGXpt+PWqm+9fVbet8k5qkt1m3IAAyPzdhi+RZCsI7RP9naVKaVqvEwJZa?=
 =?us-ascii?Q?A60K8Lp23RshrudMOxFj/O6yQAkZ7ak/bilRluzX+xBZCCoufkunJ6EHYmnb?=
 =?us-ascii?Q?pkXgSgw0vVZnWKNRuLDXD5KM/nDsKJBhZk95UEIoz1oynoLCfYGfIJcKs/iz?=
 =?us-ascii?Q?oFmt4hKYUzJGuuV79CJPprhrspYHcob2Ery5ycUOQi4BLnrL6149S8PSOlSo?=
 =?us-ascii?Q?EPqABRXyE74C2a8/oxvTGBRdECFUwVh5RazBbtU1bAv+bAVav+RnaGL37rk1?=
 =?us-ascii?Q?uV10GhZilMb7lc2OsyXLo13Q5b5haWasQA0n17xSx8x19zmF74MQLOLji/4p?=
 =?us-ascii?Q?y1F8FRllK+SmGP1nbwnlrgSpJWinfCCSQ4jxErM/AXIdJEcFCdlC2dp7cXJj?=
 =?us-ascii?Q?UdhMelAJ5DzOiZQRSWbPQvlrxD8u6PTkHWvZfUDvnA0Vd5MOmM4PWEc1Jtxs?=
 =?us-ascii?Q?nUykjmMFDP8aso8YdEANE2TTMNJxdPaw7QS4JZ4iJ+IJMvxLyxfYzB40jT/4?=
 =?us-ascii?Q?3ogsTpeU2YQ/tGnh21aHy2O599/oP/fnZ4BW/Qnf3m3J2P03jBUfRXAZrPNh?=
 =?us-ascii?Q?A5+ILo5LA05xWcHpQca1aSXT/Sk50tHOvhxdiLiqhJgDlvi2WLGXUngF3fVf?=
 =?us-ascii?Q?21aIPrekxLBTEDr6i/T+fqo3+hlRhJyr1wnu5ctfGlI6LJpBzK4vj7hl7Kcm?=
 =?us-ascii?Q?YoKnLQjn1VRbsue4/P+MHpQ/EtP0OuRtzidPWhynCcslhORss/Rig58Rlx/S?=
 =?us-ascii?Q?AzwIeVWLSr0N656j+DkQ/YoD/CJOYUHONpGfvwdXnRGs+4LGAjSXag3/ACVX?=
 =?us-ascii?Q?nYDymmjPUn77Kn/bAsT0llueqwNkst0Wjd+wBfkD3mMn1DE1bzyKnDH3G3UE?=
 =?us-ascii?Q?4nzmx27IgaI9Lc/k+w0ezPy7Z0pf/WY1Rxb1wqfJIytt0LFmGqfmVYlpKtjC?=
 =?us-ascii?Q?6spVE0YaaofWwm7wLYehTy9preemTFEYcvdPF8ZqLiIY1YLh138hBSkYU4/7?=
 =?us-ascii?Q?QtjTDgIDQMQwm1HcBBOcWMnMRsO0RycU3OuirUMfQZt6on6wPlokhmGgLUwQ?=
 =?us-ascii?Q?dVe1jvmvBfvRl+Vagu0w77VQDCA0ZNhlGaaEHkFYRLnJDyp78j92u+M2qBmy?=
 =?us-ascii?Q?XsSQ6p8xQktUzSkoKv4WI5BaNXTLK4izQH7epN5D0Nf09c+LpbhWHevDE0se?=
 =?us-ascii?Q?AvX4Kirz6uYa1rYUQqssriNCgmYqvU4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ff473-d815-4edc-369d-08da3d79d72c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:53.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2wB3x8prcasP/iAEX9C2mlbAgDKHzguRmb6u9fScyGlU9oq5fHNwVQMJx19IbT3VQ9suIc7GgwvCCfjdBVC9g==
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
 drivers/net/wireless/celeno/cl8k/config.c | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.c

diff --git a/drivers/net/wireless/celeno/cl8k/config.c b/drivers/net/wireless/celeno/cl8k/config.c
new file mode 100644
index 000000000000..dbf94060bfa4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/config.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "debug.h"
+#include "config.h"
+
+static char *non_driver_conf_params[] = {
+	"ws_",
+	"ha_",
+	"uuid1",
+	"ce_pci_id",
+	"ce_rst_gpio",
+	"ce_iface_eth",
+	"ce_iface_vlan",
+	"ce_iface_ip",
+	"ci_sim_chip_num",
+	"ci_lcu_dump_folder",
+	"ci_server_addr",
+	"ci_server_user",
+	"ci_pci_tune_en",
+	"ce_uapsd_en",
+	"ce_channel_bandwidth",
+	"ce_ht_rxldpc_en",
+	"ce_vht_rxldpc_en",
+	"ce_he_rxldpc_en",
+	"ce_bf_en",
+	"ce_bss_num",
+	"ce_iface_type",
+	"ce_mu_mimo_state",
+	"ce_wireless_mode",
+	"ce_extension_channel",
+	NULL
+};
+
+bool cl_config_is_non_driver_param(char *name)
+{
+	int i = 0;
+
+	for (i = 0; non_driver_conf_params[i]; i++)
+		if (!strncmp(name, non_driver_conf_params[i], strlen(non_driver_conf_params[i])))
+			return true;
+
+	return false;
+}
+
-- 
2.36.1

