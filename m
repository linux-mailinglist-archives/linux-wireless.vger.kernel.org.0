Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC853294D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiEXLjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiEXLjR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B58D680
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikFNIDc7AG6/kDiN3FSu3RQYUl2AWWIAZTTvIZ49Bc57+9SXNLusCVcB5ivMjtmvsb0sfuIZk52WCPyn2JXvexCBgCPYFSjoF358MuhvJbHzdLwf/oppLFbDj2zl+gTZtd71jfbr7DKQa41DgNWNdFOl1C0OXGinCd5g76czj4T5nJhrg/7dt6xFw9v4MCob7uAntkCSHEsqdWSkB5I3rQYem+iGsPVi21DXighrHFMWLyQtyV6x6jdKVsln3WI9yEox3cwOFD8yL+4amNzDbPuK1zCj1H+Gd/cNr0Z9b9e+E6CstqqIg6VE9WThSt1hAr9uGHM3BnG3KfvPQHNuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgfD6rYdhGban4wtkPkLuL+pvxsH4gSyKEI47Rt1HZc=;
 b=nrJkqRi19knXgmGOh1dRmxerF6PMpKlI4iJPGUef1ck2zZ3P5XvPNWwuPtY7F5MxBOAsQhsH5N29ALqvU0U57NR5lRn9DAVM/afI5RgO5DrcThA+MG0XixdXJF6mm4B8YNjAPGC8QVqgwgNAUR36vdYAt0VTB32z+NsL7dxOQoTMh3UCO5x76JR0h4pRfVWzRLkhi1MmC5OTzaHvZHOEopu1P4OTZiTLb54J1UK60JRbgPLs+q/Dpx5XOmY+MjkpKAv6Ucm6ETgkgYiWJEVdYdOGmo4KGh+PeZeDyMPLJiTmjSFfsSvjDmY7T+LeuJbCinUmfs/9OeflwPNqv+pwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgfD6rYdhGban4wtkPkLuL+pvxsH4gSyKEI47Rt1HZc=;
 b=lz1p7GbHpCuctGjdJ9pfFd4CEv9KrUjWfVGgg/0OF64eweg+e+Sleo2WUAH2MNroeAvMWPvtQuvq3yjAnd5yIyXjvyTjeHAmSNkGWz55UT4ODfmKXESqPUElrBMI5v4GvuYgLj8DXVz3exZMUM1I1OJ+MzDwH33HvmfdC1tqP2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:45 +0000
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
Subject: [RFC v2 46/96] cl8k: add motion_sense.c
Date:   Tue, 24 May 2022 14:34:12 +0300
Message-Id: <20220524113502.1094459-47-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25a5d643-7ead-49b4-ede8-08da3d79e9a1
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB157134A897F8F57B5CB92C81F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNoxbOm0gAJ8DG3aGeix3675Q4YJ4Vhp87zUsvPq/D0+HtWbne06kwwkBClDo3visSESoeuzb3gQ/NMZMMW4Bk+7oQqQ/oH8fD+XJ7M00qCLJnVF+oYhwI8bNsrOmmBmaDHsMRt5X5RzCoF8nNT/uONMgQZYucdaNISww64xNS0SMKCxZVXfhrHYjjJgX/PWGa5ZXyMAQVaLCQw639pzUDy03gAHqkL2sufoBrfJzpAFZl88OU/98bPRxmJRYJQD6sSwxPaEmyuYicdYYjGO9TivC/TdOubAbU+Qpv/5szetl7yNah4DBji9CQvAnxGH7rLKkEdWe2S4sanJxCujifRdxAXZRWfxqKnpe6Ffu3QDpCGMeBfQ+L5Na4qdd4iF1JTQf2jy+3f6nN8dSoEcBOLKPFwYLJ3gV493Br/CWpDeIKs+gazLYdaG6HfA23yGfFQ8dGc1qPx0957CJolJw6vqN4xjw8VDyoXISuye3Q+prnSHes7G7MQx0IXTs+dwIv1ACAxmTBLRpP9U7SnCu4MbXLkkorRIU3BeZXfXVDFLENmRa43AZPFfzBVDdtwpzozbvGPcUfQuYvMaVlZ7AawyvxgiYyxk6b1Fa/C6ybCjuuAElcRXNw1EgEmgZXj4Bb1U4TnhFxr/Cx+X8C0VLrsv9i3DHgtBayPqXOOgwERQdA1m8IMg+tK1ddHsWMwt90irMlKrvBtnBmb/GCvXyFlZmI+Y/veKg3TQtGPTd/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MjJCMR+hRsUjVAb6p2IINNJ5lRKBqNTjX96o6ZvrwWMtr8O5kxDAaAWzxC7B?=
 =?us-ascii?Q?cgj0S/SuWcfG6ZasKfbFuYRdLM8Vat8Ru0vsL7tsZb7bUkS+rHO8FnIeGPa3?=
 =?us-ascii?Q?9cOhTc3qM/S+SmyKCk7qM46tCrguDLGofzQnFu73axpjhH7k/nKZKZF2uh1M?=
 =?us-ascii?Q?O9yxeDXlqtncFixt/Q1jLW+3IsJjDxiLXRJfc05nk4twSDbbSgZsvgviwEyk?=
 =?us-ascii?Q?ARwuNJYCZNVHEeAL7utPo0z5l9FZ0syTeAnZOGXZznqdFR0vYBY+f1X3XFKl?=
 =?us-ascii?Q?0tUmhf/FZCLVe3Gf9gCPTTuWM3e2LgUHaDAeDHUb+IlVSK9xZX1h9qk8akmr?=
 =?us-ascii?Q?HTjoU5gj3h+ww0Dw6FwfHHcNhH2TuyQvRJfqexA3+zw60C34xSfvlDiwEwG6?=
 =?us-ascii?Q?YLVXoFfYLQzhxAgzezaKE0UeSoITR4+VBgwNsVxyEcRbDW52WavJ7gAYHWaR?=
 =?us-ascii?Q?WZBvpS7NFCtA7pwqiFvzPiUBaqHOmVV976UV5wVDj3uNC+oJUgyp7G8Z40Dl?=
 =?us-ascii?Q?/C+DCuwXuZSaieKR032NHWkeyTqEGkTPzRlqb97iRrkBeBnH4Fih3fYCYpAb?=
 =?us-ascii?Q?N43DwnVsjuUCUsfjXASOOGeF+H5Kn5+KTTtaDZlRzg8va+BTSJlKD/7GU3O/?=
 =?us-ascii?Q?nxlWSCUZChbXM8YpfxXVaSWiYMmiZ9rNEOqq8cEg7seJkiRfG0zomaeUSbm5?=
 =?us-ascii?Q?XtbdlBMZVYQaKFMkjTNve4BDRgjOs7tnzzTrIxq2VF5EGTqu7LBth5P5SwEt?=
 =?us-ascii?Q?glYqq2g+LLiLUSooHWCxi/GBwR5WxiHDvKXnKpEU29Wg+qmIU1trDiH/7jQB?=
 =?us-ascii?Q?uOGQ8ktD/3AC2aXDmOPFwiAdfmKiobR74H4Wxis4kpq4Lx/wp7kM+Zs2yaLd?=
 =?us-ascii?Q?aOze5FsfZDxjSwG5p+pesy/+tEifeloFyE1cYlWECOOwe1tR0JOL4NcCnh3R?=
 =?us-ascii?Q?AorqPBO9cMxOdFlXWc2h7FDkCFK9AVWWe+/p6nicUhci0I0LlEHqLV17lv/b?=
 =?us-ascii?Q?XU5+SZGG+taFDUBB+fhj/58AOgHEGvuDZ2igVlLPyFh/fuT0jW2xXPBlMWJy?=
 =?us-ascii?Q?4mHdKgGX83ET2B2ARISxa8WBaFK0u3AJ60IhJhyPLzLlBZevJ3NtJvyOT+4l?=
 =?us-ascii?Q?8ThEKDeGPysJPL4m7LTNcKpL1Vm2ShdpUJD6yrX+bL37L0gpWVOGzSSKY7Fa?=
 =?us-ascii?Q?eyU8JoINZUsu61IUB9FSJigQazxFITEQMaiHFX2Sn73+Iq4yqjAxpLL+kzP+?=
 =?us-ascii?Q?j5YcoUTIwrevkzdWsGP+wbg0/Z1eyPUsqSCgzd+v8+rKgtLxVi/gmhRDQR1c?=
 =?us-ascii?Q?fKZLdo1EzL0FDW0635veWK4rFs2NtAsln8qvFYM6fV3J1JVYJWhO2BiY4JsK?=
 =?us-ascii?Q?bZriPlU5X3OG70OOW1i5BIKZPf9tZ/bhKlmz4eB9KB89+T5Q71ea8Q2a6TzI?=
 =?us-ascii?Q?+NwEVdPQRJ+t9Gkx0Zw5phSd/lZYh9mpHBl5yMOBsjEuJI1JCGMGK5ZaMHOn?=
 =?us-ascii?Q?kPsGD4Sr4MvWidSYyfquUtYORh+XUjrhVMM17NedX9yF5eqGhUWbz4y4jODD?=
 =?us-ascii?Q?uTQukHLTs45pQ5V50iAc4fT5opU3HjizGUv1XM/ObBtkuNJ0KVUM72QpGQWj?=
 =?us-ascii?Q?qAcWDTFS0muxjsuBrgbTpgxNPrg8oi+ulRn9xw64rY67fVHtdlUgIeYY7IVS?=
 =?us-ascii?Q?CKvxTa2jhEgtv3NvqeiBn8ydYKp/AluNJl/B+q1ccN+YWliI/TO34Uxr5A/z?=
 =?us-ascii?Q?5xLh5eHGEZdmZkP0pG4Bxb2Q5LwRNYU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a5d643-7ead-49b4-ede8-08da3d79e9a1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:24.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2419UE0Go/DQ9aCicU3yZKQtB14/cCxceabYXMiP2IKGJyCVUtSnXGaxMgcHwb12twPu7ACNAo3Ozzlql5baKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 .../net/wireless/celeno/cl8k/motion_sense.c   | 244 ++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.c

diff --git a/drivers/net/wireless/celeno/cl8k/motion_sense.c b/drivers/net/wireless/celeno/cl8k/motion_sense.c
new file mode 100644
index 000000000000..2e4c05564900
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/motion_sense.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "hw.h"
+#include "debug.h"
+#include "motion_sense.h"
+
+#define motion_pr(...) \
+	do { \
+		if (cl_hw->motion_sense_dbg) \
+			pr_debug("[MOTION SENSE]" __VA_ARGS__); \
+	} while (0)
+
+/* Minimum time (+1) for taking a decison */
+#define MOTION_SENSE_MIN_DECISION_MGMT_CTL 4
+#define MOTION_SENSE_MIN_DECISION_DATA     9
+#define MOTION_SENSE_MIN_DECISION_BA       9
+
+static void _cl_motion_sense_sta_add(struct cl_motion_rssi *motion_rssi)
+{
+	motion_rssi->max = S8_MIN;
+	motion_rssi->min = S8_MAX;
+}
+
+void cl_motion_sense_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	_cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_mgmt_ctl);
+	_cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_data);
+	_cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_ba);
+}
+
+static void cl_motion_sense_rssi_handler(struct cl_hw *cl_hw,
+					 struct cl_motion_rssi *motion_rssi,
+					 s8 rssi[MAX_ANTENNAS])
+{
+	u8 i;
+
+	motion_rssi->cnt++;
+
+	for (i = 0; i < cl_hw->num_antennas; i++)
+		motion_rssi->sum[i] += rssi[i];
+}
+
+void cl_motion_sense_rssi_mgmt_ctl(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				   struct hw_rxhdr *rxhdr)
+{
+	/* RSSI of mgmt and ctl packets */
+	if (cl_hw->conf->ci_motion_sense_en) {
+		s8 rssi[MAX_ANTENNAS] = RX_HDR_RSSI(rxhdr);
+		u8 i;
+
+		if (!IS_REAL_PHY(cl_hw->chip))
+			for (i = 0; i < cl_hw->num_antennas; i++)
+				if (rssi[i] == 0)
+					return;
+
+		cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.rssi_mgmt_ctl, rssi);
+	}
+}
+
+void cl_motion_sense_rssi_data(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct hw_rxhdr *rxhdr)
+{
+	/* RSSI of data packets */
+	s8 rssi[MAX_ANTENNAS] = RX_HDR_RSSI(rxhdr);
+
+	if (!cl_hw->conf->ci_motion_sense_en)
+		return;
+
+	if (!IS_REAL_PHY(cl_hw->chip) && rssi[0] == 0)
+		return;
+
+	cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.rssi_data, rssi);
+}
+
+void cl_motion_sense_rssi_ba(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS])
+{
+	/* RSSI of block-acks */
+	if (cl_hw->conf->ci_motion_sense_en)
+		cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.rssi_ba, rssi);
+}
+
+static s8 cl_motion_sense_calc_new_rssi(struct cl_hw *cl_hw, struct cl_motion_rssi *motion_rssi)
+{
+	u8 i = 0;
+	s8 rssi_avg[MAX_ANTENNAS] = {0};
+
+	/* Calculate average rssi */
+	for (i = 0; i < cl_hw->num_antennas; i++)
+		rssi_avg[i] = (s8)(motion_rssi->sum[i] / motion_rssi->cnt);
+
+	/* Reset rssi sum for next maintenance cycle */
+	memset(motion_rssi->sum, 0, sizeof(motion_rssi->sum));
+	motion_rssi->cnt = 0;
+
+	return cl_rssi_calc_equivalent(cl_hw, rssi_avg);
+}
+
+static void cl_motion_sense_state(struct cl_hw *cl_hw, struct cl_motion_rssi *motion_rssi,
+				  u8 sta_idx, u8 min_history, const s8 *type)
+{
+	u8 i = 0;
+	s8 rssi_new = 0, rssi_old = 0;
+
+	if (motion_rssi->cnt == 0)
+		return;
+
+	/* Get new and old rssi */
+	rssi_new = cl_motion_sense_calc_new_rssi(cl_hw, motion_rssi);
+	rssi_old = motion_rssi->history[motion_rssi->idx];
+
+	/* Add new rssi to history and increase history index */
+	motion_rssi->history[motion_rssi->idx] = rssi_new;
+
+	motion_rssi->idx++;
+	if (motion_rssi->idx == MOTION_SENSE_SIZE)
+		motion_rssi->idx = 0;
+
+	/* Check if new rssi is max or min */
+	if (rssi_new > motion_rssi->max) {
+		motion_rssi->max = rssi_new;
+		goto out;
+	} else if (rssi_new < motion_rssi->min) {
+		motion_rssi->min = rssi_new;
+		goto out;
+	}
+
+	/*
+	 * Check if old rssi was max or min.
+	 * If so, go over history and find new max/min
+	 */
+	if (rssi_old == motion_rssi->max) {
+		motion_rssi->max = S8_MIN;
+
+		for (i = 0; i < MOTION_SENSE_SIZE; i++) {
+			if (motion_rssi->history[i] == 0)
+				break;
+
+			if (motion_rssi->history[i] > motion_rssi->max)
+				motion_rssi->max = motion_rssi->history[i];
+		}
+	} else if (rssi_old == motion_rssi->min) {
+		motion_rssi->min = S8_MAX;
+
+		for (i = 0; i < MOTION_SENSE_SIZE; i++) {
+			if (motion_rssi->history[i] == 0)
+				break;
+
+			if (motion_rssi->history[i] < motion_rssi->min)
+				motion_rssi->min = motion_rssi->history[i];
+		}
+	}
+
+out:
+	/* Wait X second after connection, before making first decision */
+	if (motion_rssi->history[min_history] == 0)
+		return;
+
+	/* According to delta decide if station is STATIC or in MOTION */
+	if ((motion_rssi->max - motion_rssi->min) < cl_hw->conf->ci_motion_sense_rssi_thr) {
+		if (motion_rssi->state == STATE_STATIC)
+			return;
+
+		motion_rssi->state = STATE_STATIC;
+
+		motion_pr("%s - sta_idx=%u, min=%d, max=%d, state=STATIC\n",
+			  type, sta_idx, motion_rssi->min, motion_rssi->max);
+	} else {
+		if (motion_rssi->state == STATE_MOVING)
+			return;
+
+		motion_rssi->state = STATE_MOVING;
+
+		motion_pr("%s - sta_idx=%u, min=%d, max=%d, state=MOVING\n",
+			  type, sta_idx, motion_rssi->min, motion_rssi->max);
+	}
+}
+
+static void cl_motion_sense_moving(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				   struct cl_motion_sense *motion_sense)
+{
+	if (motion_sense->combined_state != STATE_MOVING) {
+		motion_sense->combined_state = STATE_MOVING;
+		motion_pr("sta_idx = %u, combined_state = MOVING\n",
+			  cl_sta->sta_idx);
+	}
+}
+
+static void cl_motion_sense_static(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				   struct cl_motion_sense *motion_sense)
+{
+	if (motion_sense->combined_state != STATE_STATIC) {
+		motion_sense->combined_state = STATE_STATIC;
+		motion_pr("sta_idx = %u, combined_state = STATIC\n",
+			  cl_sta->sta_idx);
+	}
+}
+
+static void cl_motion_sense_combined_state(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_motion_sense *motion_sense = &cl_sta->motion_sense;
+
+	if (motion_sense->rssi_mgmt_ctl.history[MOTION_SENSE_MIN_DECISION_MGMT_CTL] == 0 &&
+	    motion_sense->rssi_data.history[MOTION_SENSE_MIN_DECISION_DATA] == 0 &&
+	    motion_sense->rssi_ba.history[MOTION_SENSE_MIN_DECISION_BA] == 0)
+		return;
+
+	if (motion_sense->rssi_mgmt_ctl.state == STATE_MOVING ||
+	    motion_sense->rssi_data.state == STATE_MOVING ||
+	    motion_sense->rssi_ba.state == STATE_MOVING)
+		cl_motion_sense_moving(cl_hw, cl_sta, motion_sense);
+	else
+		cl_motion_sense_static(cl_hw, cl_sta, motion_sense);
+}
+
+static void cl_motion_sense_maintenance_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	u8 sta_idx = cl_sta->sta_idx;
+	struct cl_motion_sense *motion_sense = &cl_sta->motion_sense;
+
+	cl_motion_sense_state(cl_hw, &motion_sense->rssi_mgmt_ctl, sta_idx,
+			      MOTION_SENSE_MIN_DECISION_MGMT_CTL, "mgmt/ctl");
+	cl_motion_sense_state(cl_hw, &motion_sense->rssi_data, sta_idx,
+			      MOTION_SENSE_MIN_DECISION_DATA, "data");
+	cl_motion_sense_state(cl_hw, &motion_sense->rssi_ba, sta_idx,
+			      MOTION_SENSE_MIN_DECISION_BA, "ba");
+
+	if (motion_sense->forced_state != STATE_NULL)
+		return;
+
+	cl_motion_sense_combined_state(cl_hw, cl_sta);
+}
+
+void cl_motion_sense_maintenance(struct cl_hw *cl_hw)
+{
+	cl_sta_loop(cl_hw, cl_motion_sense_maintenance_sta);
+}
+
+bool cl_motion_sense_is_static(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	return (cl_sta->motion_sense.combined_state == STATE_STATIC);
+}
+
-- 
2.36.1

