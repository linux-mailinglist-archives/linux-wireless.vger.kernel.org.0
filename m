Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64883AB8CA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhFQQKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:31 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:37092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233745AbhFQQJd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoLEgyGiSh8K34hbWFQzmSX5Dq8o3o0g9hCB5fcpWCRx6NgtEUQzln4bBehstOganA6ab8VnZ6F7szWqobeocOQAwV8eOi+Vi2thhYT+IimxOHBAvSKuf6mKUcIqs0EVf8MfkS+/C0qA78z5AkOt2YdPChqyx4xvas4No5Z9udekOS/9T+zzW1PWpRmPRuiQ7LqcEaSwdXSqLtGWxBgxAjD12jtQFFTd6xV8z7xLXlH9wbwp+vPQkZ2wt5r93KfRsHhSmlVF5Lef5QjBQKG6adgLVBQd6OdeKc0jtOI4BA/eLiPTSvvMssKjWMlbIMnFXQB2n7er0Kf2JhD7aU/jdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGjl2M5Nd+7mfOycISBRNrjOqc5WlQ7pznSayqMgHjc=;
 b=ZZKI4EjbrhL7oJ8Veuz+sGIMvck6feMMahwWz57XWXcOil4E9cAMT/AVACGyy+BFTYGqSb6KGA9RYLq7a0LjZ6uZNlLoiePUgzOb4vF2Kd8wgyVNCslgVyUax8XIWCjUUnIeQYFMA9cC00zgVB6/ZjXZUgaIV897iIlz9kl2RfmHWF/n1XiUw31sJLOuvNQG7UwPuX5Djo9vHO1+VCtg8Tkpj0O9K3k3KHj6gcjE+XwRxinFS95ndCQ9RGB+aTgKK9Emro9R2X6H3xVgJPgHnNJTGnmY5NUcqi03vnbpQFyEACxBmCh73QO5YnCaC3j2oNBXMNv5tBwhFEiR4Mewww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGjl2M5Nd+7mfOycISBRNrjOqc5WlQ7pznSayqMgHjc=;
 b=27AZ9pbwi5m+eXj/8xU0/Kgc6vYaWQdj9eEW2FBIn0ziGXTEDUs1BRZ5qAUHDNPZ2OoYwcdo/CiguZOcjG0MrDgjjyYIYgrOxf7BNqX+IlqF0DYhQNKxKbA4dOz55xIuCn+VaDkmFbdJ67P/YqpRY3c/m9Un9Sh//RjFVXugMw0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:12 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:12 +0000
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
Subject: [RFC v1 191/256] cl8k: add trace.h
Date:   Thu, 17 Jun 2021 16:01:18 +0000
Message-Id: <20210617160223.160998-192-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0cef862-0861-40d6-0ba2-08d931a9cffb
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075DB0AE4C1C8C677FECC05F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYT6fHNwiiSwVN3QjlZYUqnMG4/xjPoiFmcKBqAsDuJIOLNBiIAK/ttJ8T5JTzG7MB7xrL3paeHnS1+UO+Lc4K9TsHOY6+uoDh4hLnygW7SzMUEKJj71q0K5Dr/CjyI6JmLCGMbLgiqG36xlYTKCPvIQP8p8U70M6mlh3EXee30kQTZDZ35xIN+uGsRlSCiIlZAKjWzJMIJAqk+cIKd24XM4FRhPJksUompJCIHMfgCs8csy3MWAJh3X8oNClVC1405XHbiAuXc973OFxwefk80mAJSrk79/2VxPan0whlDbQQRRRC7xYBakjO7PwOjqeMfIh4xzYdpaYVNrP//DK01A801PPI424iXXNs7bv5aRX++4TKVEwtAcAv4hp0cf3mfB/cIz/4q7oFxuyBGpH9ghjmYMnUpLset3sd0s03Wh2dxEqqxdlIS6sFxC/eCl6HjIBdLFMRGklVYqrNAkkptI1oN/zifQCUFSundrO6x/wi/+0I7G7iC024izRQU8ZrP5iwxFeRcmqbFnRPXHdGumW//hlK0TJijN85UPfbGddjHRixGW/7yWVrEcAXqJgQ8z7jk0dQBrbEBMAR2gCFrN1rU/hLgZPOSoV6v2rr7+OcvUU4WxgYfB4ImbCCN9pJS/TDNYuDRx80it67oZbsVOuDxvEYXIwnRU2OIb6lmBUfpWLfLr0dETEG2+zDWzUYQwmfKOBgMSraPDzMcSVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cbQ4LyJfw7F/kRtUgtsXaOE3C5boJD6g77FfTO5FuM6XqdnBXVzd+kfL5hL2?=
 =?us-ascii?Q?SLOAcFIrljKw+UAfCmfleaiEvtZ0NA0VPUAZL5fdgO1Bi0z91H8+2Jey72lr?=
 =?us-ascii?Q?Bd+BeH6goAdtwNlYJLOc2XbE8j6wOLVjiepIPTiJEBXwJTwJd7Y6MglQ2bQg?=
 =?us-ascii?Q?Ip0LRmhve/I2xAC2jSxwz7drX46gFmU15Oyd32vWob77GTlLYWMnW/xr/gEO?=
 =?us-ascii?Q?EJcZjuxYez/464L/f/9PMC8MSiK/A7A2BWQP9CzQAqVAcHvczN92Iayxghve?=
 =?us-ascii?Q?QsLc14G9NPouvk2mumyLexPqealVDkD/TVvE8zrIR9F24kq/rcSygk065JkS?=
 =?us-ascii?Q?lLhZ6YNS50WBkonrx/3k2CV/y/RwgoHLCQtnNBkdWZMCfHm3XHGq7j70IkYN?=
 =?us-ascii?Q?+UAOcmqjtQ98qLkE1MUx/Wu2/lW10JQCQe3Ay3JRBcPj1p0I3FA+jhkvigqi?=
 =?us-ascii?Q?DNT6fbHm7wq4Upa5yZXRMCqoZH2q9kwfVk3f0kLRCh3TeSpEz+7jTtyRLyvc?=
 =?us-ascii?Q?km2dhwzPdqVf5e6a7Ier0bANvGf5Nd7vvCoCARfDkzMFoBHejQGblZDMPK7L?=
 =?us-ascii?Q?S8lll8+iQcRo/BJRl9HK8PNs/G4uewGbz+QVWlD4E2bPC7BlEOxUU6FBdZKB?=
 =?us-ascii?Q?3tW8O+/Jmzj4V1DT4ikXHB5BITeZV2z5f4NrwF4gDj2MTwCcbBh5pP/o402T?=
 =?us-ascii?Q?pmFYeWwj0P4N9ZouABQQLvPw8i25gkMktH75Npjmz3Kr6EfNttzCO+z7fTCo?=
 =?us-ascii?Q?BAVNWPdIXagFR6Sgu3Zf1+WePuEXrHnIcFCcG8CClmBRq9R7NpGelcP4dqhI?=
 =?us-ascii?Q?RHD3zGuZEwKc7TJici41/+4dfy7654iIuBPh6rOJY0DGho1u619fvyJ8SUuo?=
 =?us-ascii?Q?3e5hRiTyWkOQXgnYJSuAQxotETu8AwvokgUnBL+oM4aFHqGEUavIxPpM/Z8Y?=
 =?us-ascii?Q?Q3vIanOQU1QUFXUXRJm7II4jUvtwZqyEXjymtMz1Sd/1mga78R4AoI0FUzGq?=
 =?us-ascii?Q?VE61shAjUmaoXskwAXgNmt4ITMJsRSeV6wGsHe4X+HrtaSgfBUfcj5/v6pPz?=
 =?us-ascii?Q?diHpYphP5q8EN423AHH2S0C/JYLUIgxvE+mkPFrx/pzeL9TnG438adWoyNtZ?=
 =?us-ascii?Q?Cn+NIV05iN0i85mzphfxMGGlnKb7ZeNGT2UPk4Oq2cg6xtPR4IERfRm0fNql?=
 =?us-ascii?Q?v3KmCt6H19Q3paM9Jj8zG+gESgouNy4mw8AUnRIbCWXHLXlOfA5EiA69Hi3H?=
 =?us-ascii?Q?Jn6uyj/6RHTffIwxK9fNswXk4r+f8AVl5ym6GN9MI4RHM8AG9cSoKJqh1Cyg?=
 =?us-ascii?Q?0FxFE2X0++DBgKFQZDXwUYPn?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cef862-0861-40d6-0ba2-08d931a9cffb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:06.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNBvQDhBIe7i5vnN74YFZgkJRBJMzmNp5gWxm52olI01sHWjx+PoYHD7OUTI0M2Y/D9NVZp3HFZwUOlXE3dt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/trace.h | 203 +++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/trace.h

diff --git a/drivers/net/wireless/celeno/cl8k/trace.h b/drivers/net/wireles=
s/celeno/cl8k/trace.h
new file mode 100644
index 000000000000..21b9927c0f99
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/trace.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cl_trace
+
+#if !defined(_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_H
+
+#include <linux/tracepoint.h>
+
+/* Here, we need to include headers for definitions used in TP_PROTO */
+#include <net/mac80211.h>
+#include <linux/skbuff.h>
+#include <linux/ieee80211.h>
+#include "rx/rx.h"
+
+/* Add your tracepoint definitions here. */
+TRACE_EVENT(cl_trace_tx_start,
+       TP_PROTO(unsigned char cl_hw_idx,
+                struct sk_buff *skb,
+                int buffer_cnt),
+       TP_ARGS(cl_hw_idx, skb, buffer_cnt),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_tx_push,
+       TP_PROTO(unsigned char cl_hw_idx,
+                struct sk_buff *skb,
+                unsigned char packet_cnt,
+                unsigned short seq_ctrl,
+                unsigned char tid),
+       TP_ARGS(cl_hw_idx, skb, packet_cnt, seq_ctrl, tid),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_tx_pci_single_cfm_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned int cfm_used_idx),
+       TP_ARGS(cl_hw_idx, cfm_used_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_tx_pci_single_cfm_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned int cfm_used_idx),
+       TP_ARGS(cl_hw_idx, cfm_used_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_msg_rx_handler_start,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned short msg_id,
+                unsigned long msg_pattern,
+                unsigned long *cfm_flags),
+       TP_ARGS(cl_hw_idx, msg_id, msg_pattern, cfm_flags),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+)
+
+TRACE_EVENT(cl_trace_msg_rx_handler_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned long *cfm_flags),
+       TP_ARGS(cl_hw_idx, cfm_flags),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_msg_rx_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_msg_rx_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                int msg_handled),
+       TP_ARGS(cl_hw_idx, msg_handled),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_dbgfile_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_dbgfile_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                int dbg_handled),
+       TP_ARGS(cl_hw_idx, dbg_handled),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_tx_agg_cfm_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_tx_agg_cfm_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                int cfm_handled),
+       TP_ARGS(cl_hw_idx, cfm_handled),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_rx_desc_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned int write_idx_rxm,
+                unsigned int write_idx_fw),
+       TP_ARGS(cl_hw_idx, write_idx_rxm, write_idx_fw),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_rx_desc_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                unsigned int write_idx_rxm,
+                unsigned int write_idx_fw),
+       TP_ARGS(cl_hw_idx, write_idx_rxm, write_idx_fw),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_rx_tasklet_start,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_rx_tasklet_end,
+       TP_PROTO(unsigned char cl_hw_idx,
+                int handled),
+       TP_ARGS(cl_hw_idx, handled),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_netif_rx_start,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_netif_rx_end,
+       TP_PROTO(unsigned char cl_hw_idx),
+       TP_ARGS(cl_hw_idx),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+TRACE_EVENT(cl_trace_cl_msg_fw_send,
+       TP_PROTO(unsigned char cl_hw_idx,
+                int msg_id),
+       TP_ARGS(cl_hw_idx, msg_id),
+       TP_STRUCT__entry(),
+       TP_fast_assign(),
+       TP_printk("%d", 0)
+);
+
+#endif /* !defined(_TRACE_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/*
+ * Without these two lines, the tracepoint will be searched
+ * for in include/trace/events, which is not what we desire.
+ */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cl_trace
+
+#include <trace/define_trace.h>
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

