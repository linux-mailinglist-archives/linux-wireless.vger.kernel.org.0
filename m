Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EA532958
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiEXLjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiEXLjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11648CB3D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USDzTwPt+D6HHAi+FL6nanQKsD1tltugm03Q7IHEmDZEPnMy0GNqnfTO6P2pnLv4jo2rt/10tj75h/5UoZBb7ZbJ3ZyF0VeAl3n5wQ4ELJPcSgS6g24RV1mXqt3BXMogeD7yzr0ycI4B62R0PMC62gBpIZGku12lm7b+8eyvgE000IBWvSRmKLzMCOrojBwsN0DbidSz6TSCXoyHxTT5QzpJUOZ/p36W4CheNIGBsQ98bPcZNatP9RGSTHfZL4X3sxXn+AKlTdJUi7HjE+lwHh96fCKD73DbzJxVnoN5PaIq+9hB/QoTN9hsyecWveHYewBX7L2VWk7ajQnkIRqbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73VgtPoBPUHFsPlhN2xY0bBWL2WMKVEtWH8FJesVnzI=;
 b=Lhy0P9ZlF05ol73QY6t7pNXdnaGHMaROx+8fU4bAxA+FR9UaZrLzLsSYdlKfz6MZrKLkmzTqUQ+nm9jdOf0+gtwVruJ7rltdiZIUW4BzwcjGRAvPoW0IcjiNJfA2SpYaDTUj5YtQLMQUiwvomnrTaR+CfuX+6AnPNZqlr9DXU0vjLYtU5kbDyhSPTRhTF84C3whTvVht+2+2Y8EaPRTF383JJSp+ohoClCo5AAFkjESgoPwvyZpaj1ORUzF5pL3ujYDN8s7NIyN10X06YwyaGiSv0LLyPTHR9k8HJ+Imr8t6DE/RUskQwlGI5A1688yRxPzSTeIKbjVWeHgqrNr+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73VgtPoBPUHFsPlhN2xY0bBWL2WMKVEtWH8FJesVnzI=;
 b=xtZfEwSw2PC6AkypHUHmZhTA4CgT0VX9FgXxWgFapYIjOv7A0GcGz7O7xDyMNCvG2Gih97uqqC6Vp7+1qDk+pKYuv4FI29BzIBJpY5g0x3uLjjg4LSFtRuKcXLYHbNIDdwPL9s5YXTQ1nii+W1ipxs7AN2ePJY0fr95TKbrjojQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:42 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:42 +0000
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
Subject: [RFC v2 40/96] cl8k: add mac_addr.c
Date:   Tue, 24 May 2022 14:34:06 +0300
Message-Id: <20220524113502.1094459-41-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: a49df5ac-5d19-442f-eb5c-08da3d79e3b9
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB03842EFB60169408044A1F5EF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+u01cIuuSvweBJNdPxvlUoHqOT9kgc/pbUTuOgqrtQmYSEd0SqiIOEKLnqnVc6dLwqsJP2bNjHxDj+QTH9B62qp6BBl6SJqDTSpaSd5mflkn+NmofsdDv+MnC5I+uH53vz57lp1esxSJyjb8e/UVs35K5Esq7MDLkT+51yBuhp1eaIQpROx7E0S9gRBme635lG+OYGPC8P6TMBha727LiAwG6bpjBPo9HB98fIydAt/WR9r/1EPL58hNcMiQqqKu9P0yJCF9lshwhLwHVyw4hK5c1q1SMt4QDTi7QOXW43YFRTe6c1b348Jiezb2Qyvr01HC1UWUSTjaOwuCpDtZioyARPW75wPkapsjwOCIcwfauCqQsZLKjnmLmcBuPSs7ajwHFgGWLbkO0ddupHD3KF0wB7kfi22gtJQEmPPlek6wdarGJZY8BefSRBZ8y3isGUySIbRQ/YXrpby64BqXb+h4Bm93ZZS9j4a8GHCOg0R4dFOZH69ChczFNls6W+i2I6MzST2Sv5RdinFxWX4hbgzBEODXR/LVr1n91I0ZCHzi4R/TbhLXNovm2tmhUa5UPE/eqXjcPk1JOygm6B0hCXvPE3Ii35wZrcr/LAb4mGwPsk8VzUF/TwLV9yfw7/T4dE0gm9r/jgEpllRT3haG1Ar+dfDrRDMJu3AQhc1CGrMD0mwdqaO6gULKjCGKMM18vjUOSoJjWYoLItLYjbgU24WXJMGqgt9laF/1w6Yhus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJRQvrvfO72IGYjiSA7ugVopWGHpH4zq5u5T+KOZ2JAEVZoQiOQv5MDOUFP1?=
 =?us-ascii?Q?xzD1QB6/Fk1YQebZKxsI7Y+Rl4b1bbOMbipuDBu001MxmwZR4G53K8TiBels?=
 =?us-ascii?Q?L16PRNl+4gNqBDOAmKNjpHvbaQOmn+56P5AnD7HBkrgB6XKGyexpYwROWecR?=
 =?us-ascii?Q?u4x/S0FdZ5aacyf5kvWjOwaoauQlamIohgmgGCN6IG9GilZ4RrvgottAQ2FK?=
 =?us-ascii?Q?4BbLbdLjSm+ja3V/usaHajGyvaNNaPcDz5vWBSn4gDLI0/NNxCPvPl8SqMMf?=
 =?us-ascii?Q?qr2RQk65afTfD315IdRbUBUGMjMVLtGxohaU61gopz4w+bdzJOxUM3SI6HKT?=
 =?us-ascii?Q?M6Ir0iqgZDWF91p/LXhz2VujcjdG00bj+bpS5kAmrERwgKtk/NgRwQOBHXbK?=
 =?us-ascii?Q?XG2t4qJ0Y++02cLR5se0/zYsZaANCtLvbVQNfalOTbFPEPaRskPanGxyKAzc?=
 =?us-ascii?Q?eSwIKoBPy1+XP9/ThQQARPd76t5MfeJftgjsLqbB4yrI4QzP+icQUVsbMLQq?=
 =?us-ascii?Q?o6jhcYQUL8fxt3VIHM5cZ2TPFG6wgeFjYjpPRLk5CQXLFXaMcI2SXhytaI53?=
 =?us-ascii?Q?9NCxCTFPebA4J3J3DORJ2mp06QMx6QVRzz+yuYQypEQZxPuSVwIvF2NaBvFV?=
 =?us-ascii?Q?fmjU0y+7umfjnQSp1FqdMnL8GUirKc7Bg4+GHFcaHbf95nO3xDksBG0HwCLp?=
 =?us-ascii?Q?dloDFxtOJiwPHNzGzUL4wwRIn8Bs0VUEQYrGb9RO3cK+7qxMux4CnxPRtjzd?=
 =?us-ascii?Q?40fQAxui2Cndp5b07vatAm6z4lCPnmmIfIWCMoV1w+l4C6d00QQWcGresagy?=
 =?us-ascii?Q?vRyuBD4sdcdyr4IB/Qt01FmoQk9Hthv1h0xedptIeVVnQ2lhW7nscJ7UEUv5?=
 =?us-ascii?Q?G+K/kCduzMnWwHT/4h5nAgHrq4XKpsVEdFyXES+clymelBnBdEFRdfObV0OW?=
 =?us-ascii?Q?5tb4E5fKfgw/oEkG27Mk5/9CzPThGYbscPSyGuZilnj9nGAG8tnJjXVQAAe5?=
 =?us-ascii?Q?qweIGXtFmCNMN9/Erd/AAIhsbyVgk3NmQgGG+969tEmkzI33l3xvCV5wymGv?=
 =?us-ascii?Q?i2uiOlAqFYqFeThi5gLDWZPA8dfCqSwM5DsAYOd8jQwLdx5dSc6uQOF58RZU?=
 =?us-ascii?Q?boY4QTvHEpcl50yrsXVarmyLtnUuYpEEOA4d5RUWZGYfhm9JF8lL93WKKMpU?=
 =?us-ascii?Q?NP5ODBeBVMLYok7ujBdT7AVI1tZGwPAGjOkdJOwT5utwjJGDbxXkSNHqVqGI?=
 =?us-ascii?Q?Saz+HaRCxAJn7ut5re9pqMAhV8O/vhZgs2eomGr5S6f1ayOlKS8zMNVp6vJe?=
 =?us-ascii?Q?hZIARNDHrkc2rHi+iha2sR/1pQwg39WiFSTIFxcwhpt935gXLrzJ1bikew27?=
 =?us-ascii?Q?W5IX5mfALZD5dyvxZIw3FRpH3gmAKhX7hn7GjwOXNeD+dr0807iUjIZq3O98?=
 =?us-ascii?Q?RQJH1SWcj9wAnwsjSx/lpJSHoF5Yo2qhkBYJLEL99Pw2pf/dlzYa2dtPyCPN?=
 =?us-ascii?Q?Px8GZis3tXtUvLygOwExtbrjQz+XMORaRRm0UeDdU1jPUveGNjcJZR9XZG8X?=
 =?us-ascii?Q?BJ/PIPvwsNONgaPsNH2GVJqe4qRLx0hgHm4220yMyXpES7FknbjMEpbna/Q1?=
 =?us-ascii?Q?0WnGNM34RQyvVxbvTbQVXIuWxKLRgxI+Mgqt3YIXevQV56o6RsixjED2YbL+?=
 =?us-ascii?Q?lJ1A99A9pICjri7bhlJddyc2ppp7VHbtN9QTnQhqjhTcTakmVR7EHLcqb6Fs?=
 =?us-ascii?Q?mirIzcvbUiMRUtef+73q1cchLO8Wp3A=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49df5ac-5d19-442f-eb5c-08da3d79e3b9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:14.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko093/ZyJ7WM64V1JXp9GMyv36b0lXJFrXFO9Z4JSc3WpptdKx0OBoSg6En4U/xoe/KpafvqMN8GPydyMTs6Ng==
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
 drivers/net/wireless/celeno/cl8k/mac_addr.c | 418 ++++++++++++++++++++
 1 file changed, 418 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.c

diff --git a/drivers/net/wireless/celeno/cl8k/mac_addr.c b/drivers/net/wireless/celeno/cl8k/mac_addr.c
new file mode 100644
index 000000000000..be9080564773
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac_addr.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "mac_addr.h"
+
+/** DOC: MAC identifier generation
+ *
+ * The driver allows to works with multiple MAC indentifiers via one base MAC,
+ * which it gets from:
+ *  a) EEPROM;
+ *  b) %ce_phys_mac_addr parameter in chip config;
+ *  c) randomly generated address with Celeno's OUI.
+ *
+ * All other MAC are generated from base MAC by modyfing specific byte in each
+ * new address (starting from %ce_first_mask_bit). All addresses should be in
+ * 4-bit range from each other (HW requirement).
+ *
+ * Both tranceivers are sharing MAC addresses pool per same chip, and with LAM
+ * (=Locally Administered Mac) there is the ability to have up to 16 different
+ * addrs starting with any base MAC. Otherwise (without LAM), base MAC should
+ * allow to generate addresses within 4-bit difference at max.
+ *
+ * Max addresses count is configurable on per-TCV basis via %ci_max_bss_num
+ * variable.
+ *
+ * If LAM is enabled, TCV0 is getting original MAC for the first interface. All
+ * another interfaces of the TCV0 and all interfaces of the TCV1 are getting
+ * LAM-based addresses, which will have 0x02 in the first byte and will have
+ * dynamic last (depends on %ce_first_mask_bit) byte, which typically is being
+ * incremented for each new address, but not always (the logic tries to fit
+ * addresses in 4-bit range, for the sake of this rule new LAM-based address be
+ * reseted to start from 0.
+ *
+ * MAC examples
+ * Case 1: Typical (with LAM)
+ *  - 00:1C:51:BD:FB:00; -> base MAC (valid with and without LAM)
+ *  - 02:1C:51:BD:FB:00;
+ *  - 02:1C:51:BD:FB:01;
+ *
+ * Case 2: Typical (without LAM)
+ *  - 00:1C:51:BD:FB:00; -> base MAC (valid with and without LAM)
+ *  - 00:1C:51:BD:FB:01;
+ *  - 00:1C:51:BD:FB:02;
+ *
+ * Case 3: With reset to fit 4-bit rule (with LAM)
+ *  - 00:1C:51:BD:FB:CF; -> base MAC (valid only with LAM)
+ *  - 02:1C:51:BD:FB:CF;
+ *  - 02:1C:51:BD:FB:C0:
+ *  - 02:1C:51:BD:FB:C1;
+ */
+
+#define CL_LAM_INDICATION 0x02
+
+static int cl_set_mask_addr_without_zeroing_bits(struct cl_hw *cl_hw, u64 mac64, u8 bss_num,
+						 u8 first_mask_bit, u8 *mask_addr)
+{
+	u64 mask = mac64;
+	s8 idx = 0;
+
+	mask >>= first_mask_bit;
+	mask += (bss_num - 1);
+
+	/*
+	 * After the following line the mask will contain the changed
+	 * bits between the first BSS MAC and the last BSS MAC
+	 */
+	mask ^= (mac64 >> first_mask_bit);
+
+	/* Find leftmost set bit */
+	for (idx = 47 - first_mask_bit; (idx >= 0) && (!(mask & (1ULL << idx))); idx--)
+		;
+
+	if (idx < 0) {
+		cl_dbg_err(cl_hw, "Invalid mask (mac=0x%02llx, first_mask_bit=%u, bss_num=%u)\n",
+			   mac64, first_mask_bit, bss_num);
+		mask = 0;
+		eth_zero_addr(mask_addr);
+
+		return -1;
+	}
+
+	mask = (1ULL << idx);
+	mask |= (mask - 1);
+	mask <<= first_mask_bit;
+
+	for (idx = 0; idx < ETH_ALEN; idx++) {
+		u8 shift = (BITS_PER_BYTE * (ETH_ALEN - 1 - idx));
+
+		mask_addr[idx] = (mask & ((u64)0xff << shift)) >> shift;
+	}
+
+	return 0;
+}
+
+static int cl_mask_mac_by_bss_num(struct cl_hw *cl_hw, u8 *mac_addr, u8 *mask_addr,
+				  bool use_lam, bool random_mac)
+{
+	u8 bss_num = cl_hw->conf->ci_max_bss_num;
+	struct cl_hw *cl_hw_tcv0 = cl_hw->chip->cl_hw_tcv0;
+	u8 first_mask_bit = cl_hw->chip->conf->ce_first_mask_bit;
+	u8 i;
+	/* Determine the bits necessary to cover the number of BSSIDs. */
+	u8 num_bits_to_mask[ARRAY_SIZE(cl_hw->addresses) * TCV_MAX] = {
+		0, /* 0 : 00:1C:51:BD:FB:(0b 0000 0000) -> 0-bit diff (no LAM, original MAC) */
+		0, /* 1 : 02:1C:51:BD:FB:(0b 0000 0000) -> 0-bit diff (LAM) */
+
+		1, /* 2 : 02:1C:51:BD:FB:(0b 0000 0001) -> 1-bit diff (LAM, between address #1) */
+
+		2, /* 3 : 02:1C:51:BD:FB:(0b 0000 0011) -> 2-bit diff (LAM) */
+		2, /* 4 : 02:1C:51:BD:FB:(0b 0000 0010) -> 2-bit diff (LAM) */
+
+		3, /* 5 : 02:1C:51:BD:FB:(0b 0000 0111) -> 3-bit diff (LAM) */
+		3, /* 6 : 02:1C:51:BD:FB:(0b 0000 0100) -> 3-bit diff (LAM) */
+		3, /* 7 : 02:1C:51:BD:FB:(0b 0000 0101) -> 3-bit diff (LAM) */
+		3, /* 8 : 02:1C:51:BD:FB:(0b 0000 0110) -> 3-bit diff (LAM) */
+
+		4, /* 9 : 02:1C:51:BD:FB:(0b 0000 1111) -> 4-bit diff (LAM) */
+		4, /* 10: 02:1C:51:BD:FB:(0b 0000 1000) -> 4-bit diff (LAM) */
+		4, /* 11: 02:1C:51:BD:FB:(0b 0000 1001) -> 4-bit diff (LAM) */
+		4, /* 12: 02:1C:51:BD:FB:(0b 0000 1010) -> 4-bit diff (LAM) */
+		4, /* 13: 02:1C:51:BD:FB:(0b 0000 1100) -> 4-bit diff (LAM) */
+		4, /* 14: 02:1C:51:BD:FB:(0b 0000 1110) -> 4-bit diff (LAM) */
+		4, /* 15: 02:1C:51:BD:FB:(0b 0000 1011) -> 4-bit diff (LAM) */
+	};
+
+	u8 mask_size = 0;
+	u8 byte_num = ETH_ALEN - 1 - (first_mask_bit / BITS_PER_BYTE);
+	u8 bit_in_byte = first_mask_bit % BITS_PER_BYTE; /* Referring to the index of the bit */
+
+	if ((first_mask_bit + num_bits_to_mask[bss_num]) > BITS_PER_TYPE(struct mac_address)) {
+		cl_dbg_err(cl_hw, "Invalid combination of first_mask_bit + bss_num. "
+		       "must be lower than 48 bit in total\n");
+		return -EINVAL;
+	}
+
+	if (cl_hw_is_first_tcv(cl_hw)) {
+		mask_size = num_bits_to_mask[bss_num - 1];
+	} else {
+		u64 mac64 = ether_addr_to_u64(mac_addr);
+		u8 tcv0_bss_num = cl_hw_tcv0 ? cl_hw_tcv0->conf->ci_max_bss_num : 0;
+		u8 bit_mask = (1 << num_bits_to_mask[bss_num + tcv0_bss_num - 1]) - 1;
+
+		/*
+		 * If we need to zero bits due to lack of room for the MAC addresses
+		 * of all BSSs of TCV1, then the mask is the number of zeroed bits
+		 */
+		if (((u64)bit_mask - ((mac64 >> first_mask_bit) & (u64)bit_mask) + 1) < bss_num) {
+			mask_size = num_bits_to_mask[bss_num + tcv0_bss_num - 1];
+		} else {
+			/*
+			 * Otherwise the mask is the different bits between the
+			 * addresses of the first and the last BSSs
+			 */
+			cl_set_mask_addr_without_zeroing_bits(cl_hw, mac64, bss_num,
+							      first_mask_bit, mask_addr);
+			return 0;
+		}
+	}
+
+	/* Build mac and mask addr */
+	for (i = 0; i < mask_size; i++) {
+		/*
+		 * Build mask - Convert to "1" the relevant bits in the mask
+		 * addr in order to support the desired number of BSSIDs
+		 */
+		mask_addr[byte_num] |= (0x01 << bit_in_byte);
+
+		/*
+		 * Build mac -convert to "0" the relevant bits in the mac addr
+		 * in order to support the desired number of BSSIDs
+		 */
+		if (random_mac && !use_lam)
+			mac_addr[byte_num] &= ~(0x01 << bit_in_byte);
+
+		bit_in_byte++;
+
+		/* Support cases where the mask bits are not at the same byte. */
+		if (bit_in_byte == BITS_PER_BYTE) {
+			byte_num--;
+			bit_in_byte = 0;
+		}
+	}
+
+	if (use_lam) {
+		/* Mask LAM bit (Locally Administered Mac) */
+		if (cl_hw_is_first_tcv(cl_hw))
+			mask_addr[0] |= CL_LAM_INDICATION;
+	} else {
+		/*
+		 * When not using LAM we do not zero the MAC address of the second BSS,
+		 * so the mask (the modified bits between the first and last BSS) depends
+		 * on initial MAC
+		 */
+		u64 mac64 = ether_addr_to_u64(mac_addr);
+
+		cl_set_mask_addr_without_zeroing_bits(cl_hw, mac64, bss_num,
+						      first_mask_bit, mask_addr);
+	}
+
+	return 0;
+}
+
+#define MAC_FILTER_BITS 4
+#define MAC_FILTER_MASK ((1 << MAC_FILTER_BITS) - 1)
+
+static bool cl_is_valid_mac_addr(u64 mac64, u8 first_mask_bit, u8 bss_num)
+{
+	u8 mac_bits = (mac64 >> first_mask_bit) & MAC_FILTER_MASK;
+	u8 mac_diff = 0;
+	u8 i;
+
+	for (i = 0; i < bss_num; i++) {
+		mac_diff |= mac_bits;
+		mac_bits++;
+	}
+
+	return hweight8(mac_diff) <= MAC_FILTER_BITS;
+}
+
+static int cl_mac_addr_set_addresses(struct cl_hw *cl_hw, bool use_lam,
+				     u8 *mask_addr)
+{
+	u8 first_mask_bit = cl_hw->chip->conf->ce_first_mask_bit;
+	int i = 0;
+	u8 bss_num = min_t(u8, cl_hw->conf->ci_max_bss_num, ARRAY_SIZE(cl_hw->addresses));
+	u64 mac64 = ether_addr_to_u64(cl_hw->hw->wiphy->perm_addr);
+	u64 mask64 = 0;
+	u8 new_addr[ETH_ALEN] = {0};
+
+	if (!use_lam && !cl_is_valid_mac_addr(mac64, first_mask_bit, bss_num)) {
+		cl_dbg_err(cl_hw,
+			   "perm_addr %pM is invalid for bss_num %d without LAM\n",
+			   cl_hw->hw->wiphy->perm_addr, bss_num);
+		return -1;
+	}
+
+	cl_mac_addr_copy(cl_hw->addresses[i].addr,
+			 cl_hw->hw->wiphy->perm_addr);
+	for (i = 1; i < bss_num; i++) {
+		u8 *prev_addr = cl_hw->addresses[i - 1].addr;
+
+		if (use_lam) {
+			mac64 = ether_addr_to_u64(prev_addr);
+			mask64 = ether_addr_to_u64(mask_addr);
+			if (cl_hw_is_first_tcv(cl_hw)) {
+				if (i == 1)
+					mac64 &= ~mask64;
+				else
+					mac64 += 1 << first_mask_bit;
+				u64_to_ether_addr(mac64, new_addr);
+				new_addr[0] |= CL_LAM_INDICATION;
+			} else {
+				if ((mac64 & mask64) == mask64)
+					mac64 &= ~mask64;
+				else
+					mac64 += 1 << first_mask_bit;
+				u64_to_ether_addr(mac64, new_addr);
+			}
+			cl_mac_addr_copy(cl_hw->addresses[i].addr, new_addr);
+		} else {
+			mac64 = ether_addr_to_u64(prev_addr);
+			mac64 += 1 << first_mask_bit;
+			u64_to_ether_addr(mac64, cl_hw->addresses[i].addr);
+		}
+	}
+	cl_hw->n_addresses = bss_num;
+
+	return 0;
+}
+
+static int cl_mac_addr_set_first_tcv(struct cl_hw *cl_hw, u8 *dflt_mac,
+				     bool *random_mac)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (!cl_mac_addr_is_zero(chip->conf->ce_phys_mac_addr)) {
+		/* Read MAC from NVRAM file */
+		cl_mac_addr_copy(dflt_mac, chip->conf->ce_phys_mac_addr);
+		cl_dbg_verbose(cl_hw, "Read MAC address from NVRAM [%pM]\n", dflt_mac);
+	} else {
+		/* Read MAC from EEPROM */
+		if (chip->eeprom_read_block(chip, ADDR_GEN_MAC_ADDR,
+					    ETH_ALEN, dflt_mac) != ETH_ALEN) {
+			CL_DBG_ERROR(cl_hw, "Error reading MAC address from EEPROM\n");
+			return -1;
+		}
+
+		cl_dbg_verbose(cl_hw, "Read MAC address from EEPROM [%pM]\n", dflt_mac);
+	}
+
+	/* Test if the new mac address is 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff */
+	if (cl_mac_addr_is_zero(dflt_mac) || cl_mac_addr_is_broadcast(dflt_mac)) {
+		/* Set celeno oui */
+		dflt_mac[0] = 0x00;
+		dflt_mac[1] = 0x1c;
+		dflt_mac[2] = 0x51;
+		get_random_bytes(&dflt_mac[3], 3);
+		cl_dbg_verbose(cl_hw, "Random MAC address [%pM]\n", dflt_mac);
+		*random_mac = true;
+	}
+
+	return 0;
+}
+
+static void cl_mac_addr_set_second_tcv(struct cl_hw *cl_hw, u8 *dflt_mac)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	u8 tcv0_bss_num = cl_hw_tcv0->conf->ci_max_bss_num;
+	u8 first_mask_bit = chip->conf->ce_first_mask_bit;
+	u64 mac64;
+	u8 idx;
+	u8 bss_num = cl_hw->conf->ci_max_bss_num;
+	u8 lam_bit_mask[ARRAY_SIZE(cl_hw->addresses) * TCV_MAX] = {
+		0b0000, /* 1 addr,  0-bit diff between MAC addrs, LAM is not affecting it */
+		0b0000, /* 2 addrs, 0-bit diff between MAC addrs, first differs by LAM !!! */
+		0b0001, /* 3 addrs, 1-bit diff */
+		0b0011, /* 4 addrs, 2-bit diff */
+		0b0011, /* 5 addrs, 2-bit diff */
+
+		0b0111, /* 6 addrs, 3-bit diff */
+		0b0111, /* 7 addrs, 3-bit diff */
+		0b0111, /* 8 addrs, 3-bit diff */
+		0b0111, /* 9 addrs, 3-bit diff */
+
+		0b1111, /* 10 addrs, 4-bit diff */
+		0b1111, /* 11 addrs, 4-bit diff */
+		0b1111, /* 12 addrs, 4-bit diff */
+		0b1111, /* 13 addrs, 4-bit diff */
+		0b1111, /* 14 addrs, 4-bit diff */
+		0b1111, /* 15 addrs, 4-bit diff */
+		0b1111, /* 16 addrs, 4-bit diff */
+	};
+
+	mac64 = ether_addr_to_u64(cl_hw_tcv0->hw->wiphy->perm_addr);
+
+	if (chip->conf->ce_lam_enable) {
+		/* Find the first address of TCV1 */
+		if (tcv0_bss_num == 1) {
+			/*
+			 * For tcv0 bss num = 1, we have to zero the necessary bits
+			 * since it hasn't been done in TCV0
+			 */
+			mac64 &= ~((u64)lam_bit_mask[bss_num] << first_mask_bit);
+		} else {
+			u8 total_bss_to_mask = bss_num + tcv0_bss_num - 1;
+
+			mac64 &= ~((u64)lam_bit_mask[tcv0_bss_num - 1] << first_mask_bit);
+			/*
+			 * Get the first MAC address of TCV1 by incrementing the MAC
+			 * address of the last BSS of TCV0.
+			 * After the instruction below mac64 will hold the MAC of TCV0's
+			 * last BSS.
+			 */
+			mac64 += ((u64)(tcv0_bss_num - 2) << first_mask_bit);
+			/*
+			 * If there is no more room for another address in TCV0's mask
+			 * address then we have to zero bits else increment the last
+			 * address of TCV0
+			 */
+			if (((mac64 >> first_mask_bit) & (u64)lam_bit_mask[total_bss_to_mask]) ==
+			    (u64)lam_bit_mask[total_bss_to_mask])
+				mac64 &= ~((u64)lam_bit_mask[total_bss_to_mask] << first_mask_bit);
+			else
+				mac64 += (1ULL << first_mask_bit);
+		}
+
+		/* Enable LAM bit */
+		mac64 += (0x2ULL << 40);
+	} else {
+		mac64 += ((u64)tcv0_bss_num << first_mask_bit);
+	}
+
+	for (idx = 0; idx < ETH_ALEN; idx++) {
+		u8 shift = (8 * (ETH_ALEN - 1 - idx));
+
+		dflt_mac[idx] = (mac64 & ((u64)0xFF << shift)) >> shift;
+	}
+}
+
+int cl_mac_addr_set(struct cl_hw *cl_hw)
+{
+	bool random_mac = false;
+	u8 dflt_mac[ETH_ALEN] = {0x00, 0x1c, 0x51, 0x51, 0x51, 0x51};
+	u8 dflt_mask[ETH_ALEN] = {0};
+	bool use_lam = cl_hw->chip->conf->ce_lam_enable;
+	struct wiphy *wiphy = cl_hw->hw->wiphy;
+
+	if (cl_hw_is_first_tcv(cl_hw)) {
+		if (cl_mac_addr_set_first_tcv(cl_hw, dflt_mac, &random_mac))
+			return -1;
+	} else {
+		cl_mac_addr_set_second_tcv(cl_hw, dflt_mac);
+	}
+
+	if (cl_mask_mac_by_bss_num(cl_hw, dflt_mac, dflt_mask, use_lam, random_mac))
+		return -1;
+
+	/* Permanent address MAC (the MAC of the first BSS) */
+	SET_IEEE80211_PERM_ADDR(cl_hw->hw, dflt_mac);
+
+	/*
+	 * Addresses count must be power of 2
+	 * mac80211 doesn't handle non-contiguous masks
+	 */
+	BUILD_BUG_ON_NOT_POWER_OF_2(ARRAY_SIZE(cl_hw->addresses));
+
+	cl_mac_addr_array_to_nxmac(dflt_mask, &cl_hw->mask_low, &cl_hw->mask_hi);
+
+	if (cl_mac_addr_set_addresses(cl_hw, use_lam, dflt_mask))
+		return -1;
+
+	wiphy->addresses = cl_hw->addresses;
+	wiphy->n_addresses = cl_hw->n_addresses;
+
+	return 0;
+}
-- 
2.36.1

