Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87A53294C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiEXLjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiEXLjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59B8CCFA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLww2rz9VLX9wjvKZZFkX+cVR4LaW/cE0pp/hbZrqkMMChtilrejTKeDFrv0wWJ3PhtFKNR4DeWnKj3jTfmTtqFhk1C4UaS1QCIG2oULjA+/sb3Kp7CgvztnMI3HpGcVxEWwfgJMf/KeP7s+ZPPdD1EvGbHqUoxJlWc69CuIJPb48ToyS9jqQgqYO0h7DZqqJmtA2ceJ41I3BP++yFpTd+SQwB5O4z01RcrOtqx2b62ocuWB/tWPNqzp/swuZiOEXc9Hf+iJbxL12x/3Y0HOvQffOyKiQznQ5u3pxDlxpov73sUwdLA6nnT88DxRdsxqy9sGKjAcPPoeP2oxSj6T+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCrjD385YbFOSBmwfsR2keCEPmC5oz2aDqYm5W8imSc=;
 b=hcS7tMDKAyF2Pyt8jjIvOoEh8z/EFmSO54wCYWM0aI9GLA5fnADC37xk9iEWdJNQeQr8oAUzSWQEtwRU3eAWOrMMIxIvvoPEhmXKyrf+00HpmKpCuZMaw7tdfHzzSbECBRXG/eYOnyFiN01Jdhr5wc7hdkBRQobMTXhII9nxO0I7DUTCwg5f5zYzBhGb42nJNA51SnrqnlV3HO2lLOyBkznHgHk1Jxd03uX18o/tRalCn3Ief3GdJQUVSZ0WxsRC5jjfx6lSpHAqQ+n043b/l24QPNH5PIKN0cPyseN4ekLZsqWIfrZrgp1mJgWowumDV+lkD7SZK6HTaDpQav/62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCrjD385YbFOSBmwfsR2keCEPmC5oz2aDqYm5W8imSc=;
 b=uwit51Bgsu7lM7NVEwSi8wN6LUaOh56sun0bZ2Ocg7MPDvkfLUp0sF/NObhMy+eSiny0e9mQgXv+uIg+wX6wrtaIDOEQx9TEYYbhX7A2UHjqvxYfyiOwPnDqNLvX8RqQ4EhsDEcLwkEuWhYtWR21gsdkqZius4FQkJj8SU+zluU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:40 +0000
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
Subject: [RFC v2 37/96] cl8k: add key.h
Date:   Tue, 24 May 2022 14:34:03 +0300
Message-Id: <20220524113502.1094459-38-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 495b7315-980c-483b-fd14-08da3d79e1af
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384734B05EB23D754BA1A04F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keJ2gBEtn+1qQOCulx5M1OpM2pkj+vyQMxlLIKJqGM0K1ZAvLcLddiJS+91XV4zHNRiF3n3dZ81oKrVKsIa6WRvxN8I9bJJkbV7k+S7nBJ46PUeJhjGkQMW8JN0iQnVqYc32Bnwm6eHLDwAWZldNBf1IKH5+24pUR16lIPUJlxDNkBIL+8B6uw6gkY2J+wNixXtYq7kkhQmeG6CZn+2/S1Z8bn8tMfZoiNACRmwY96R2jCcqcqMPW1lQkEsbl9t1eTwo2lKLZ0vQe5nACEg/xhEUOlTU+dpkMYZ8IktwhfyCvKEmqdno6kelX7dyK+p0jXQc+yq9ycxzXAH2K74SCdPcHtNL/n4y6vK5HSb3jWOfWXq/sPU4OS8V53cuKEmLJOyIsPsTY97AUHqwJPI4KC2Ris8XE31q1r3Ey+0rHpHYiAe5pb/hFgNEziXYn48Mj4VPQvR3vgkIzxzXt33WYa5p7/iLTpIcU38LnhdmM3Mz4ixTRUO6pgX9XtXJ61dN5CmUsCSPoQXy0gY7BxnZ7lCcUDbqh7ka1R9jqj+KewLX0z/+55l9C0y0lgwKVrlwSqdffF4eNtBqWkKNqCOHh6x2wD5LlDqQsO1m3APHdbKECvHOsHdEQB6g6ywdpKF3xXd46vP49XQY+f9LGfKsZv9dU0T1Rugppf+pKQCplHPj1X1P1nbvwmDrrtpJEDd9f31gCIolOsmwFHAe2hkRMy8Vmyq59CTAnyNhZBriDN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3D24uLrcjmHJ5IEYAyTy7BdOY8I+tbyPsDG6wATlLbPXUGGkk9JChMkDeAV?=
 =?us-ascii?Q?5twWImN9mFnN7qzXRSX6MnCtLEqNLF248bdWntUA0sZUo8cQMWcSQEICXONj?=
 =?us-ascii?Q?32xsNndMg3vPsn1SYkeqwVIePR76FPdoa40T4oCo0oKZDcjej3ozDGRfpCyH?=
 =?us-ascii?Q?qYpu1VQXTxkBdBhbWJ9PHG7naE00FJN/jA4si7XsG9vLZ+gZRwCNy75itmOs?=
 =?us-ascii?Q?1whfT0ooCO6IZKp8roBt/4C10pYSgVPbJsZfnZzrJgzjoLZ0jpGQK1vRciH/?=
 =?us-ascii?Q?AoYTdv5IeG8KVuDmsOiVvbvD0apqYbXVh++1OI7jZdgK4P74ogigWzrFJZW7?=
 =?us-ascii?Q?m/wSGujC4s+rgKzm45KOoEHssBfW149PSzPRSMpOI5ggXpuk91UwmiDinTX+?=
 =?us-ascii?Q?phUX1PEsE6kQ8br5+Ah//ig0LQHfmrQEw4pA7k3J/EIr9cmigWnaz4UJjzR2?=
 =?us-ascii?Q?OYbhwrJvkrz9aeXA4WqnJQoH851DjfaWBlF4oRDpvOTaqN+GGuokRO3fRFXb?=
 =?us-ascii?Q?qt8nMMQFx70tVPgL/S6aMdIAxIejZZqs5WCncDK4LjOj3a35V8Qm3Md8TpJK?=
 =?us-ascii?Q?0CE/9CIxoqzMQS1qG+d2W2YwKPUBHnkKfWlLgN1WfIDhChQkXed74XUCQEZm?=
 =?us-ascii?Q?W/luHI9RQgAUKKEJ0pU94FfSGfQCFH8bX/WH+42KcZ7/d1jbW2ykdtISnAzU?=
 =?us-ascii?Q?MsevxH3COyxBkLNJ0W8iYitOVFKQVbbGsUftL4fxrFR2Wh6RZTt4FtnvRQ1q?=
 =?us-ascii?Q?sVURmVR8qCEkqzUp3dtwcDYl+bDrl3dzQTSIrCxOccUhbOrR2FHnKykOr3kc?=
 =?us-ascii?Q?r3W+ItWtAK4/sM7cZfCN7neV3ZXuYgwDUYTfZssHplbk/vxKG1upfMHh2L41?=
 =?us-ascii?Q?3trc5sHAoJKNGfT/2nxUM7F7z/iAJtQgNKjMMf9cz02AGosGyYrsSi/qtt/E?=
 =?us-ascii?Q?L+QA8R9EtWDWSynYP2y/4xoJ1yAx11F4YEbro1WYmisu0e0qp2WFUtSVdMWg?=
 =?us-ascii?Q?ZtwkhaLlN6a4YIS1nTOEDNk1i5cYY85N4vW8vJWlBEgDfo7VfiD+o5OEwGf4?=
 =?us-ascii?Q?kv5ca8v+R8CWcjEz9TGsAutZIaJW9Up/0z/1QLSZPwtkVIS92OaAmUvf/umo?=
 =?us-ascii?Q?D+PW3sDEGYbIgC/lvn2Pd/U28elS/ZH6VxaS7yotDN0V9F5FKh7RJvIz2+4i?=
 =?us-ascii?Q?HcRHovm+DJbsCHeshFUXq4RQVx6Q+ZwxCSeAw5wk77PA5GgAzo8ubQnRS8c7?=
 =?us-ascii?Q?bEyy8TXNsTG6jkCimhOuJBgItmcJKonhK6rLljqXgzQgcwxEb9x4nnMeeerF?=
 =?us-ascii?Q?aIehEyX+ja1dmxQWXIlpt23TFVFKqdHNON4lJNQm6CxPqhI6E5+Us5Q/L+yb?=
 =?us-ascii?Q?WK4+iuj9LyqbX14BrDORXUC6sUYFlEoiKCcakkaKtjf3o/goTbYrrB+LjhoI?=
 =?us-ascii?Q?cpopbk2KpgUGjNMDzC523zq0zr6+w1edl98Ez5JN5jgX9Jh4E24+zXy1gwCn?=
 =?us-ascii?Q?aEpshnLAjHveRdd0yaIrQEU4jdz6lputfBPftIolYHNNlXmOnb61o0XzniBz?=
 =?us-ascii?Q?UyJkDzkOE7yWX8bKGI/pVBEO9Ino/gU1xI/BBMoTeMxiRhXCjbq9m53YtTgB?=
 =?us-ascii?Q?PHwsnkaH1Ah1iWzquOtZKvL/rbM1NPxSTDIXxZziXK11bjFb/KFLEI4C6rHh?=
 =?us-ascii?Q?I8/0wDIdmUVzjvXSzYZiNdCl9ZZHaCojoz2TuyCPGRaoqgKsXR1RYD/U+H1S?=
 =?us-ascii?Q?YidnR29HBjjZ33VQS5avpJdNH2qUuIk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b7315-980c-483b-fd14-08da3d79e1af
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:11.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utYAxY0Wunpzn17SA4ftSLLTP5KtKvyrOxX4BNti8sN3Byc9ikdq4DlU7HBTPq7qyDuBZyrZQ8Rqz2zSSqTleA==
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
 drivers/net/wireless/celeno/cl8k/key.h | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.h

diff --git a/drivers/net/wireless/celeno/cl8k/key.h b/drivers/net/wireless/celeno/cl8k/key.h
new file mode 100644
index 000000000000..3731347f8243
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/key.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_KEY_H
+#define CL_KEY_H
+
+#include "hw.h"
+#include "vif.h"
+
+enum cl_key_pn_valid_state {
+	CL_PN_VALID_STATE_SUCCESS,
+	CL_PN_VALID_STATE_FAILED,
+	CL_PN_VALID_STATE_NOT_NEEDED,
+
+	CL_PN_VALID_STATE_MAX
+};
+
+struct cl_key_conf {
+	struct list_head list;
+	struct ieee80211_key_conf *key_conf;
+};
+
+void cl_vif_key_init(struct cl_vif *cl_vif);
+void cl_vif_key_deinit(struct cl_vif *cl_vif);
+int cl_key_set(struct cl_hw *cl_hw,
+	       enum set_key_cmd cmd,
+	       struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta,
+	       struct ieee80211_key_conf *key);
+struct ieee80211_key_conf *cl_key_get(struct cl_sta *cl_sta);
+bool cl_key_is_cipher_ccmp_gcmp(struct ieee80211_key_conf *keyconf);
+void cl_key_ccmp_gcmp_pn_to_hdr(u8 *hdr, u64 pn, int key_id);
+u8 cl_key_get_cipher_len(struct sk_buff *skb);
+int cl_key_handle_pn_validation(struct cl_hw *cl_hw, struct sk_buff *skb,
+				struct cl_sta *cl_sta);
+
+#endif /* CL_KEY_H */
-- 
2.36.1

