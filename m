Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC4532952
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiEXLjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiEXLjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCCA8D6A6
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM/gDrFOkcCnrQWdb8RJHU24WJFG4R5mO9j2n0RahXi2IGjndMRqY74vk7pC0qTs6b7Y49wCOlFnvmrqLXVRLOt6SxX8LPZuk/KGg+XagSaqkwg7JYowVkPEr3mzv2BIfbzI/fEUKl74n723NIhmGHNXvBl3RJqzCoxtJScC3vd1oM4J7RUxRPrmgB0bOTZPSAl4lE0+iBeO15+l8EQhxezj5EKa4iJSvyJybVu8ZnWm2kOFiBLVzht98hP1EpgMZNpgPo5IUDnKD8Lf+HJzDAh8P5pCTaDmMf4RtNNYgAMpPstAn8bzUjURnNvkvbIRIM1XFP7g1OVIpB2ymO3QKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnf0lzHhXiJjUj1mEj2y01uHUt7I+1E59uqvq5alXWk=;
 b=ljMa/EO4OY6JwLR/6zOiGPcb+WfbOyNOQFE5nwEc/cA7FgP2U/TfazYFN8/RsKsmcf0UyiGWsTuDCcL/m7sYsaaz5lavcMguOmns3zHSTEqLaJo4A6yIMhHxD8IVHTDCwknyYbeD/zGsXQrNJldUIwXQkd58tiXRgr8BTpWbfe2oynUb8YXx9gqRClPL/TSczefGPWPZGjfnXRxDXb0aS6jMZwWpjYUT2WiYP28guYliJi23AIosRAMF5/fTAFJCnJjYzhqRVcX8rcbKukaNdu5zR+Jxx2LpVa+SoAOI5LXqRR+REw4BQRFa+uISFbWApPOLYxaUgvUXYDDi9I6D7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnf0lzHhXiJjUj1mEj2y01uHUt7I+1E59uqvq5alXWk=;
 b=lc8csV5g0nPVlRu7FRXS5Glm9zP822/jKCBTh2x8rn6Hb1KQZ8RqXhkTUsFQBHrDAbHxPDUQmAZcKnV/PTC5PQw9kr/6vW7bEBJ0IhBwUqMF80vERExUCEG0XM31lA8co8DoGqSQ42KCyn4se+MUgTbFASL0cDa+Tdl5XbZrxtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:43 +0000
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
Subject: [RFC v2 41/96] cl8k: add mac_addr.h
Date:   Tue, 24 May 2022 14:34:07 +0300
Message-Id: <20220524113502.1094459-42-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd35cfe9-dbf1-46c8-630f-08da3d79e439
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB038408D53627EC5D0DA62E3DF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jBSUMEayaFCDgl1Dd+tVjeIvhCzRSIm51cOvZQfkj4l635sQehCDbeETGgBIytOKj/CtmeSosQeOWbvwXySltXFizVGfw3Jo0xfmBMfaQZFnz3zQwa7roQ+iel/xsj50IzSqOdIHS0R7/V4v9f1CEykeqZlq9fLObLgUJqbcWF6dU4+89yH3K1UZq8U9kl4KEELZMNHziQsYEqye6ekS7KqyzhbJAQjBtG26pBKCQ8fF4obmTWSBkSNygNscRFXUBDjftwyn0XN9JrDhBLHDdqhkhffZLDp9SJ6ppYEh97R7+4mtTCX0bydYAbF6FsO/l3kM1/TGDp8sMp6Y2qpzFArFeeQ94iXL/re3J4trUIUz90Xwl4AQ9D2Xdjli33fGNHYH//OmHwBW7cRy9ydYMWh1inyUC32V68WR1HkGXm4bok9nyhg3hBrCSImOnU2LpKk/iLhh4sSh+T7W8CxjnAqXJV3kPaPtUVFPDDGMl04qICpez99CeV+6E7Bj8/qFTn0BWNsUGiwF5axugJPeB7ykfKctF2prWNKHkQnDQEc3zeDY+bdSFRhAeiRdbKpXF6XA0SPZUerw48Bt6A97tBaG2pVLk6x7RYvcV6E/9Flzwe0CWVvIBw7f89HoHYf/L2CECnF22jcTXXtNNYc7BBuwvbNPqVcjyr96uDhhx+Sf1kazKsRlf2OB6p0WPjcmWrToTYJSABPotKCZLw7iOXb9FJQ8yrK8DXfUN8raSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/fcuxp7QqnREZYphLyxIiMu8uAy0Da55ZDrdOnri2wxdYHOEZZYMXHfz63lR?=
 =?us-ascii?Q?KypKDWhrRhT8zyD2O9Sh80cU5rTuy4kasBZoOLdHaY5zlcR0zucUn5zUUhDi?=
 =?us-ascii?Q?foBPBe+bmINCK8YbIrRQLIad3N+m+dcY+PYCmkW26OQhINLhgP9OOA33O2P7?=
 =?us-ascii?Q?7vq2n2GOVFZV0vRLamyVwmk6uU3oHt4lWi0ZNbqTxijfG8zR/Wj9kBlTuGSL?=
 =?us-ascii?Q?esEj71S6f4TY9LtZXE2UepDeJkSfpthqIg35/MRw1/IIvGmX7yKu2COLuElJ?=
 =?us-ascii?Q?KG0zYLG/v3OStn7BsQIIw7JGDZF1+bdVkfbRawdU6zIfPjeznzwSl2uI1XIp?=
 =?us-ascii?Q?L539ybB5+EyWUQTbNjTPh7KTDWf+VxPLyJQRsgd0KZ5A/P4Aut5h+7T4TQNu?=
 =?us-ascii?Q?r0yB9ZwMkWbvUTbLm9un0p8hAqB8takJwEbboAAayUkr+hj1nj8UIZjXkW/e?=
 =?us-ascii?Q?T4H+iTUlMzaChpKzxJUsnWB3TcCzz11DDo6KlxQOwZuRt/7wcyN8FXnQKi3W?=
 =?us-ascii?Q?scYGZRTurJFacKEFIcHr7QZVfIoHi7yOr3SUqOuhPcGhyU/wdNd2mr4QGPL/?=
 =?us-ascii?Q?+D76Hh2GCcjhqF7E7ZAI8mMxKKaZm9f/qmxwXyxYJpSIJ3Be/gJlfcJfTIXZ?=
 =?us-ascii?Q?ROSFOnlyxaRz7wa7y1e1Lj0U6nfQEjvvqaONNeTs5ixzgGi+mliSn7P6B3kq?=
 =?us-ascii?Q?UDZVP5C35ladR3jm+UU2WAVZ8kTHQysGFpjY5hzUi54UYBb+FAodrQe97QX/?=
 =?us-ascii?Q?zRmpWbfVosVa2f6HVadGoBO55AOIlCVhABWRt36HYR7UJizx8xKsRfExk+tj?=
 =?us-ascii?Q?102tAPuuO4+KsD5VmDQp/bc3sJFKuOLV14jjWny+/FAQOUO/VtrE3Ssj6Atw?=
 =?us-ascii?Q?WUVdCJx1LpI4xlEzfRjOiG9qVhhHRuyZCdYD/T3CU4F8r2/RvvkD6oZSzd6/?=
 =?us-ascii?Q?s1L+yX/oQNSxpLG4mpd5vVuTbiw1sGVAr+JbjqpVgvAQ3qDtVkB/nOuuFoyt?=
 =?us-ascii?Q?QzAZ/0fSr0xSZwblMr41ZgCqhorJcmQ14DRhgdSkQjiSqrYonsc+TBkOYglA?=
 =?us-ascii?Q?3fMn9xxGD6EZjpMk1YnF2r7DajbSFfFciXZPOWwR6Mj5xSA2ITxuPhy+4PnF?=
 =?us-ascii?Q?lUnHV4FI6+dhhd8eVI7hOIh5DiTPbOZ9pyHqfqg6eWgZQ4Om99OdbWZG09gL?=
 =?us-ascii?Q?fn/FF0OkbKEahZJ3jK8bPjhAAQROJz/aDuOwuj9ws7cH6szvKjbQo7j25j0Z?=
 =?us-ascii?Q?A5NrgED5cDKpuwewXC4Mex0H0R8w1qxDO4MFZXMfJo1ICENPoZS0PlxoHwpJ?=
 =?us-ascii?Q?uXAC+/LBXoi4E2RVJzbyrfS7+ygWPugeqT8TG1gegXJPoxLu3OJWM3MDAh0Z?=
 =?us-ascii?Q?jB5omKnw9RIa2IVToBgcPbkTrPj5jQAQn9vlOUUtOAmGc+vlUrETQRrRA1pT?=
 =?us-ascii?Q?1DK7Qm7wKco7Lr7LNpGUf1ckykeK19OJjjWfEo+cgtpq+Y2YMF4eurjxMASr?=
 =?us-ascii?Q?x8zhvpEGiib35/yqm9a4nr9BVF2hEZCXB/7/A7k4/mkpI+kCQARakjQC7oLx?=
 =?us-ascii?Q?zr5I7N8mTFJFC6sS4t4DJLcGuBCdj9zeJdcUW//ypIglfi4iFE7c6zS/HATO?=
 =?us-ascii?Q?KuYdQ6njyhpVefGjwqY16mOQSMeRbtH0dKPQEmwNSpeuhSEa0uPUEse0/HvA?=
 =?us-ascii?Q?qt4PLF/qfAqDFnZWNR2gTb0yLikM4RXfujzOhdxXFXQIdf+JVIbseJnrgNWI?=
 =?us-ascii?Q?ZTLfcicPGQMyEJRABxThzGa7wXYYA0k=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd35cfe9-dbf1-46c8-630f-08da3d79e439
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:15.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15nYMeIYFXuxk7pU8fWzuGa4v5yC7X/oE3/E5xBr2HJPi96jLzwNohAdsW8eUat/b5s9XcnuY9uRKcI6Uj5e7Q==
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
 drivers/net/wireless/celeno/cl8k/mac_addr.h | 61 +++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.h

diff --git a/drivers/net/wireless/celeno/cl8k/mac_addr.h b/drivers/net/wireless/celeno/cl8k/mac_addr.h
new file mode 100644
index 000000000000..3f916f2b7f7b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac_addr.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_MAC_ADDR_H
+#define CL_MAC_ADDR_H
+
+#include "hw.h"
+
+int cl_mac_addr_set(struct cl_hw *cl_hw);
+
+static inline void cl_mac_addr_copy(u8 *dest_addr, const u8 *src_addr)
+{
+	memcpy(dest_addr, src_addr, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_compare(const u8 *addr1, const u8 *addr2)
+{
+	return !memcmp(addr1, addr2, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_is_zero(const u8 *addr)
+{
+	const u8 addr_zero[ETH_ALEN] = {0};
+
+	return !memcmp(addr, addr_zero, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_is_broadcast(const u8 *addr)
+{
+	const u8 addr_bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	return !memcmp(addr, addr_bcast, ETH_ALEN);
+}
+
+static inline void cl_mac_addr_array_to_nxmac(u8 *array, u32 *low, u32 *high)
+{
+	/* Convert mac address (in a form of array) to a C nxmac form.
+	 * Input: array - MAC address
+	 * Output: low - array[0..3], high - array[4..5]
+	 */
+	u8 i;
+
+	for (i = 0; i < 4; i++)
+		*low |= (u32)(((u32)array[i]) << (i * 8));
+
+	for (i = 0; i < 2; i++)
+		*high |= (u32)(((u32)array[i + 4]) << (i * 8));
+}
+
+static inline u8 cl_mac_addr_find_idx(struct cl_hw *cl_hw, u8 *addr)
+{
+	u8 i;
+
+	for (i = 0; i < cl_hw->n_addresses; i++)
+		if (cl_mac_addr_compare(cl_hw->addresses[i].addr, addr))
+			return i;
+
+	return BSS_INVALID_IDX;
+}
+
+#endif /* CL_MAC_ADDR_H */
-- 
2.36.1

