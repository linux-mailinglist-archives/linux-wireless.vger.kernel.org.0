Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA6D3AB937
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhFQQNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:41 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:60643
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233916AbhFQQMU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvzfpPeFpOhl8GRmhCEQaGTZ0TME6f70CaDlXwaWTZ8Wx1jcLlbsg/NoKlK9+evnxskbT99aS9HKyOk1XzKVgL0O/VEyId4p+JYopA1keK1d3MoGEvp/gfpqxTKlaSFIJViPlVBLm0EvtTupEywWp9ghP/4hGWc9SK3Q2jLLbX2kSUZRJX42JUs8VaX3Hv842bXPgnDbjhNbwNZHoNSOxZbYHb9tOcON6gHJxZX1KqVa2EucB2g3tcJ3kZD5LEtFuOl9hTc/Sy+k6iryPzdXje+EKcxtvdzstDbkC7gBVTym+hcnRJBUUqReJj2kpFu2MxVLjGpJDPZ4D2RwzbQ12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au4N+5Vj79W/vonL8EpSOAjxfdX39Nqx84GVaL5dLWI=;
 b=TkeTHvQPiskWN9JqPWaISJk9RawfuBCBrlnxxi+8piAWZTF0v+1oOpRiVCPVsdvq+RXJcjYRe/9SAJhgWzUS2oPoSNonHy4z4obXeW9BP1tYTv8dFoGo0CYSgtfONQ0ozaCRy8Wn30xQdrX6l5UHJQWOtVlPd4nr3UKjTgzP1A/QEVlScUlTRFHSFir1nZ3+N1AJE0Ye56aCETD3As9GfucZmuNv5bCnD+hqXDRLe4M+ntkyLcDMOP1y9C/N4ryHcwdcsQegoOcupaiDTsvCiieKFnZI8RVQKoCTBEXuSPo9DNFbLRygiQJMDPc15qd9c5licAC2WDgE7kR/aho7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au4N+5Vj79W/vonL8EpSOAjxfdX39Nqx84GVaL5dLWI=;
 b=lbZl9c6s7SqYDa4FrevEkGkcZk/VKsJtl4foAR4xl8QM6Eid9nt+8+yyt2/4ON5akEEzTAiJA/KLe7HPfnWM3bl3M/an8XA/ivsRWVtYX1klbMIkUaAV+/hu83JLcyuA0A11uLpfy006pQg1cLqFbXIDloWVp4FMgZAO2SykmqE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:08:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:00 +0000
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
Subject: [RFC v1 236/256] cl8k: add vif.h
Date:   Thu, 17 Jun 2021 16:02:03 +0000
Message-Id: <20210617160223.160998-237-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc6968a-0193-4463-4826-08d931a9eebb
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452B8E00EA2C7E76EF6AACAF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HnqETqNuz7E0x+Yc6ZGEKHokIl9WcGfRp8Sec5aLlUSmVaVkjryTBrp5EU6NCoFFXpxs9CX7dzBmIlqcWtE6JWG8JLvHPfvKa/J209fcWrqG8ghbBmx/RXJdHA5OeAZ1Nzzc7plJHfwrbcqe7t5y2avYqiHxcbMVn6OpBummZItAMlrRtmsvt3+1+Vn5adcUBXlz4PQAh65b8cC6/H+lsDhvEt+J1q8TTAhgEZrRcd6GUz96uScKIhXheDXv2kvM3wuBt/U0wGSfvODN8RQ2IUtlq7HeboMdSbAtjXnYx5a2XoK2ut3zzGJS7fGfs0byy1eYLjp8c60kgUZEMJRFyC4VXJ7rVuM7MV+lghBwizM0NuEdhb3DrvHZREXuxaA41qw2SCFXJ7INr15ox0WwY+uR9rJqk9G3FtrK7Ih69SMTYXV5ZfNT+rbZMW8eLMK9UluapG7Wlr1ZStTFeVOnZDhmN2m+ZpQjo9mfoFfe95Dr7yBsMS/ECzlB0qdh4qBlX9rbdK8k2MLl5kifo5672BXg4MPl5F2RCqlMGqAty9wnLS+SKcaAvS2cNYpCko6hOoru6bCj4TexDVyOGPKio7RKWSZaCq+Vgc6ayUfaWg5HT5iWAYElHmhyQ/U1fwK8X90JCsW3V1uQfD5tRsdX732HpEACvdIbF4eRhjyQ2bMRGF1t+ptCmwUPb1brzG4Govw/SLdiGihx2Z5bwAcvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Io/szmltfvoW2BNH+xBt06TK5TbS6Hgsc7bdZ7r2wkHZ92cFdXfTPxRm1O6J?=
 =?us-ascii?Q?9HN5WBfZ8TeAFoFeLtgA8qUvSRTqu+NK3WaFaPGvjwQym6Jmk/71ZrU//Je2?=
 =?us-ascii?Q?q0ZogMNkS9XaJyarkNecgiU9nQxa6sSSlEVIuDOSomr+Yx7I8E/SYfGvMy5Q?=
 =?us-ascii?Q?x9/PIv8eXN7CoLb4GBrsiWi+dmgfV8HlfBPXiqHtT5UH5uE3yGndljEEE4iz?=
 =?us-ascii?Q?jhr0v2CjldLQQX4kdprrPtMhE6sYtYxFFVcbX6SLKkOG+ykaFaZXz2msA+7z?=
 =?us-ascii?Q?TSxyuPF+qUrvYzQjKRuSjMxsVIPjrnLsywZ+xk5FYgI3432idZn3eeCvrU8D?=
 =?us-ascii?Q?2dwmHlsYVcVU/2j47QpDD3AR+53KgDmZvRauJBRsMmKsATX3J6hL9lwFAnVM?=
 =?us-ascii?Q?I7Z1D91yiB2Ir55F4soG+BDk7SR7X5NaV3CJZu4L8eQtp9TliK0LN0KIQaha?=
 =?us-ascii?Q?+lWgPGp2FkKYHs6qSFQXpjEUNa/L36CN+CdlKNWNRQ8R0tSR5u5udVOrThb+?=
 =?us-ascii?Q?JDAKVEcDZwJNjFY1X3A7sgd9JAlhqA4owA59dDuFExFMzYsGgH7Z9DpP23DI?=
 =?us-ascii?Q?RAB4dY/n0Pmbzp9bf1PadSjxKCREAtK7N3s/4wWNb/MSdUikRY/PkXxmpMWM?=
 =?us-ascii?Q?0TtC0NqXjio9/UTs1ioAM0JdQl67Y1QG0U3yHAhs40yBJXqKkaPdAr3XIOYo?=
 =?us-ascii?Q?Iqa5vzRYRVVeUmfD5uQy9Vl+8kRdT51Kn04z1UT55gKJCht5Kdcy0lE/OFhI?=
 =?us-ascii?Q?vDuXQ3SD8QtPInWO+fUQL6pjtnw1GA4RaU9aBQgDrNxP1cR18eAItzwfQRuL?=
 =?us-ascii?Q?WhynGaKK1/JF51nCIolkfMCL95bO+H6Hv+pf3L/mT9x1LlLbMDxSx0UIMaO9?=
 =?us-ascii?Q?h8OcBdrv+PrdWpjilZB6nkJAicWUlGN2UuQiGfqGOQ1/GJKDnWlLa5k31ieH?=
 =?us-ascii?Q?wc6PSdJz8hHlDAcsFzwgqyuppaAyuo/agxhc+dAgr1HrbXZkudXW2tpAqvzX?=
 =?us-ascii?Q?fXAcIAJkKTKUb9RN6zeVYYKQwQBbxT3U9zUKpwRly4Vc2LAxu8nGA7VyVUYQ?=
 =?us-ascii?Q?GNMLbZsQAsXqWmDoxaVitiiWBHjefyEnwCXuZSWx2VY9NX32if2MuztS72fe?=
 =?us-ascii?Q?WLePE5+D91ArlBaqe2v4ge3v3cR30euEbFcslQDJUxbA1SKgp5cOWmzhMFvk?=
 =?us-ascii?Q?348gXAEJG2zxNf3AuS1Ghust/Y3wwFcpEy7J4FJBQeOdad7W4sjBPvzbP4r/?=
 =?us-ascii?Q?suV3H3hQpJo0Giobe/Aifl0cqpv3Fhm96z5xl1PxCRWm1iA/Lpn14ope0vaG?=
 =?us-ascii?Q?Bkd5pFufq7c0vwHSrgQ/st8o?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc6968a-0193-4463-4826-08d931a9eebb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:57.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLIe9d3+9gN6p57wfggeNknAQmbmNHTQBnchg40ghhEcI1kCqh8XvdV0tw81XnCxHuhzppovBSVbFt93KrHF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vif.h | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.h

diff --git a/drivers/net/wireless/celeno/cl8k/vif.h b/drivers/net/wireless/=
celeno/cl8k/vif.h
new file mode 100644
index 000000000000..2cfd027ee88c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vif.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_VIF_H
+#define CL_VIF_H
+
+#include "wrs/wrs_db.h"
+#include <linux/netdevice.h>
+
+/*
+ * Structure used to save information relative to the managed interfaces.
+ * Will be used as the 'drv_priv' field of the "struct ieee80211_vif" stru=
cture.
+ * This is also linked within the cl_hw vifs list.
+ */
+struct cl_vif {
+       struct list_head list;
+       struct cl_hw *cl_hw;
+       struct ieee80211_vif *vif;
+       struct net_device *dev;
+       struct net_device_ops dev_ops;
+       struct ieee80211_key_conf *key_conf;
+       const struct net_device_ops *orig_dev_ops;
+       u16 sequence_number;
+       u8 num_sta; /* Number of station connected per SSID */
+       u8 vif_index;
+       bool tx_en;
+       struct mcast_table *mcast_table;
+};
+
+void cl_vif_init(struct cl_hw *cl_hw);
+void cl_vif_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+void cl_vif_remove(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+struct cl_vif *cl_vif_get_next(struct cl_hw *cl_hw, struct cl_vif *cl_vif)=
;
+struct cl_vif *cl_vif_get_by_dev(struct cl_hw *cl_hw, struct net_device *d=
ev);
+struct cl_vif *cl_vif_get_by_mac(struct cl_hw *cl_hw, u8 *mac_addr);
+struct cl_vif *cl_vif_get_first(struct cl_hw *cl_hw);
+struct cl_vif *cl_vif_get_first_ap(struct cl_hw *cl_hw);
+struct net_device *cl_vif_get_first_net_device(struct cl_hw *cl_hw);
+struct net_device *cl_vif_get_dev_by_index(struct cl_hw *cl_hw, u8 index);
+bool cl_vif_find_mac(struct cl_hw *cl_hw, u8 *mac_addr);
+void cl_vif_ap_tx_enable(struct cl_hw *cl_hw, bool enable);
+void cl_vif_bring_all_interfaces_down(struct cl_hw *cl_hw);
+
+#endif /* CL_VIF_H */
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

