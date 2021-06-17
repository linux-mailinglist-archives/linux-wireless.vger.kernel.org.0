Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAA3AB866
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhFQQHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:44 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:19069
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231396AbhFQQHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEd5PaZVGRvOMZRtYk+rZJNnYPYXdbXK1FL+YIPyGYctcADvwR/U140DioT5A7/cGcrc7cdfG1KBbitBQUR/UzyWEiRsHfM9eZg4qKBL2q8EHZ0cy3GLR/twpuKY9gI+dpoLZfvktrMxbc8mN6IhF1Ds6bZfbmtfO8Pa2E03MuvIfOWI3JMGAvlup4vvhy74zCGHRt56uNt3bSCpGT+toT0utYOfAGWFTGyNwXw7GlK1zHpqZFA1gdvWs2HQybI6wtUg0Nt9ukEAlE3/r2CrviNbrdq92FemKHro668SPW67AS7vD+197WNeWFsHCo9YRzpoOCcsKYtBxWGjNgbUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9FL7Mc0H9ThGM93/trVk+QgvknWLAgE58MG6SneIjg=;
 b=KQqW4h50Fi+KscrsvjAUa9flPX2c0EM9tBWoEFVdDsW7N4ZFuU0HuJ628KQRsr55zp6G+4ZtUn++L2xgzQ8yGdOc9lxCJ6Agvxae4NRcnqJGQ8K9SZWA7wgk2OVtgCWY/Wup7rlBwPyseB9YW7GWBzzUtdbM0X8+AQLMjakW1txGRWLDePHYDc5t88+vAWJj1wojoMNS4RFNyY/jaQ3kvCiiFGXXaXLR0gJao4GaAgGaP/aqhG6fHF8r0gGMlw7qrQmiSTk+x7OPs7enkYbygTiZuFY04NeQGFOP70AwzU32KjEp0g6OJteAkYvCJlG7IfxbsZRij4uTOV8Mb7DkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9FL7Mc0H9ThGM93/trVk+QgvknWLAgE58MG6SneIjg=;
 b=q4sCYmNQRji+RZeu248o1A90CwOyI5Lt2ZJcsqNxOUBmr1UlvCCCRdVjCk5K5L7HFK2KCumYijTie+Za40vAMxiNMOWOwll7Hc+7QtLZIdEXAIH9f+BFDIou+5QYRvLYetSXqsUz0cVQSD0oHmny8rTY7tPIkMwJNegDqg8I5ew=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:01 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 093/256] cl8k: add fw/msg_cfm.h
Date:   Thu, 17 Jun 2021 15:59:40 +0000
Message-Id: <20210617160223.160998-94-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f513e5ca-6734-4fea-7a42-08d931a98ebd
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08870802B3BEFB3D7652A25EF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqHujkMFikTpFElOeC7CXlDCFkEIftMGJuttO3h1F+1Zj/lOzeoE5/FZcS9dKVV1ZUCmGnqMz410LzQAHWJNvV8fpFx7zH4UN2VJuHKe0QWhputJhIK0tTa0s7WGLApHY3vQd4vvKkD7X9UfP1t4Fey6+8Wfz3EV5SyTIsH9QO3AkFTTruYUbiJxix4bYI1T3E2KFr1+kEQEHUmYX3grMKTBGjvd3vYwIrmQ7XCw671wDcHaLmmNu6JzWHbl/oqC07aP9S562d+STDnf1xmI+VTfOnZerhEpu/aCyFY/kaXJhqrpOlNh1LJ9PHioFKc/uj82zOjYZSmz5yoGjmYBtKbdXn1gzfArckkKXjt1ARS2/lWfAVSLFf/+CWyKStmVQB8CQajwrfamfdMPJMFCITkzYxrpl9d19W64jRgipH/eYlTUbFJoOkNpli3W71bLWmP+NRAoV5kbjKoTGVxNq/XSNbx7P2zmNEtDLX8sovbyS0RjNdDF6DInm/GPyYYEnCH3rMh9vk44QctEw56wUrmVFAPe52a0t7RT6cLO5XxPwYWTfepN7xC8ZgrzLjaiaK3eKGUHE5wH3DPWDb+OBpBPWjwFXrHW2Tr/AArhbNTjq1ltyq1lDRHJzRhFNt8pqj6xOM5FMn9tU33WEujC9l4J14Wb2rBPe1Y6pWxUuAcUrnVkJPHzk7N3QMjSBFLLW8GSWZLQ+gnzm+qn1ohRcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4r4Yj0mLRaSyos5muf0/MrA0wbCRkjeHpyNvl60MSFdpVjEwrl6oRgCb6BuE?=
 =?us-ascii?Q?K/vng5mC/kZgynDsLlStHiB2kjtnCK+msAX6e7L9+CsE7MaswoKMWw+X4NRE?=
 =?us-ascii?Q?psBOk2PPsxdsi6wk1m90df1hxvb0Q+NIroAWdHocUzIJ/k54E9v8EpmLdjtz?=
 =?us-ascii?Q?pLxOQyA2yY3WiXRVT+r5FRaMVxQcKQydoKyzznVy0LY1Clv4OPWG15Sq5Hk4?=
 =?us-ascii?Q?9NvxLfBkiA9uNuhsv78zrY+Cdj+TQSdkSfPXqyszd6n1sfrfCD/sypGzEnu9?=
 =?us-ascii?Q?7Q/mlxTRVbjFyjLIl5zmiH24B2HcuZ5zqFmCQNwqKVjCZWH8yMR8oFbTpAK3?=
 =?us-ascii?Q?zKZ4tmQs18ZZqBH1c/hAyCOPDICi9XPM5xRJzvc4FsJcNUS1HgKrHYi7neoW?=
 =?us-ascii?Q?wsjiAo7TgztBZhKnz6v70Llf+JWqXpc4Nm0G6gshHnkLUK0QuMoJA8C+d3xj?=
 =?us-ascii?Q?0z8ya8d83VOfysAnZlHWX2Oql4XfZ8bk/Aa3vCRq80LboObYwaauWljtNol5?=
 =?us-ascii?Q?rNjI2v559KQ5xuVff8cBxyk1PJ+JdBwYLMuwUa1wGml8XZqMG9hpKV1gcfcr?=
 =?us-ascii?Q?p6AdgRUfkPFW97zpSrsXg6woNjf391U5JyauszYZL/Etheb5u3XRPoREkfn9?=
 =?us-ascii?Q?8kAkfyNW+zmW8vgbrT9LA/qz4HxuWT/PzhaLiixyCMn4tKXVAYvwHxQgnSFF?=
 =?us-ascii?Q?/rMWqKbFOKUba3Sw8qp70j8XUAFZBTWbw8ye9FvhelvtwAWWCTh6mAJUyVpo?=
 =?us-ascii?Q?08LZ3zt+GlDJvn3+JNm9u2P432umtU9Y6ErjJoTWCCYGYazpqcvL1KkQqVDs?=
 =?us-ascii?Q?arCYpZlML8kW1e24hNrQWf9YRThnYgzCA0Uh1XGu3ytHnVvv2QqCKBu106eX?=
 =?us-ascii?Q?ErvrenzzlbDW4scbej0QJskkrUof2HPfOiB0XqSRWngvtI9XljiZ+3Et0Ktq?=
 =?us-ascii?Q?aypJTd6HyTKeEjoHNCnvmA+2YdkYUHEie9rxaP9wD3dYXLWDFSOc47oA69F6?=
 =?us-ascii?Q?jjrkRnKl0fUobo/ih+QorORWdtGe/sM5osnJTRjDFywSy1WNVJZCzN/X07D6?=
 =?us-ascii?Q?oWO5rHlNcn+MXN2F1GR2+vWMJeFcoUD+9s9hstYKVO83ux40xJCdNoMtTXS+?=
 =?us-ascii?Q?tyBviyPwqAuyTu2RCpW4sDlRcNlKg3ekcb0oq6rzkJ2h5nLHFQUTh4asDoNc?=
 =?us-ascii?Q?D3BcQIhmfUY6lAm3QDx6mrvX/sN3/PMJttQRb4TD/Ntj3+vQLXdz2qa5Mblx?=
 =?us-ascii?Q?ByB6YY4BgpxTs3vYEcqrOAfLX5jWNECXnTfZQzm7omocD+NsVW1Gia3PZvYH?=
 =?us-ascii?Q?ahIv07K/87n04d5OShYnpA0F?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f513e5ca-6734-4fea-7a42-08d931a98ebd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:16.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EheFcWgKRt5n9WdYq7dHf3vU1aQoImfJofgNNsIWfVPXM0u6NmZHq86Szbv6kBfIBFTIN6cUFG9KphFSygo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h b/drivers/net/wi=
reless/celeno/cl8k/fw/msg_cfm.h
new file mode 100644
index 000000000000..21c4996634ae
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MSG_CFM_H
+#define CL_MSG_CFM_H
+
+#include "hw.h"
+#include "fw/fw_msg.h"
+
+/* Timeout waiting for firmware confirmation */
+#define CL_MSG_CFM_TIMEOUT_MS            400
+#define CL_MSG_CFM_TIMEOUT_JIFFIES       msecs_to_jiffies(CL_MSG_CFM_TIMEO=
UT_MS)
+
+#define CL_MSG_CFM_TIMEOUT_CALIB_MS      1800
+#define CL_MSG_CFM_TIMEOUT_CALIB_JIFFIES msecs_to_jiffies(CL_MSG_CFM_TIMEO=
UT_CALIB_MS)
+
+#define CFM_CLEAR_BIT(bit, cfm_flags) \
+       clear_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_SET_BIT(bit, cfm_flags) \
+       set_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_TEST_BIT(bit, cfm_flags) \
+       test_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_TEST_AND_CLEAR_BIT(bit, cfm_flags) \
+       test_and_clear_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+u16 cl_msg_cfm_set_bit(u16 req);
+int cl_msg_cfm_wait(struct cl_hw *cl_hw, u16 bit, u16 req_id);
+void cl_msg_cfm_assign_and_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_ms=
g *msg);
+void cl_msg_cfm_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg);
+void cl_msg_cfm_simulate_timeout(struct cl_hw *cl_hw);
+
+#endif /* CL_MSG_CFM_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

