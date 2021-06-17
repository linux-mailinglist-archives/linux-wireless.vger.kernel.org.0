Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3CE3AB903
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFQQLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:54 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:35463
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhFQQKm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFt0ifD37sW9XmKs+x8qrFZX0viMIGa+hzSktgRQmRWgw2/msjH5q2e5FAA8qVJ3GN37p2JSOnf+NZwf00T6mxa9yWk06K9NAyOVkTpEWbVsjju+YBltGOVcejbVV2Lks1uJCVy5KEMU8AE6JhRojHlVpeflw75hgmcl92GO+KyN+yRb3hmvtnxjbK7gnqpW84X9stXx+U2cwK936e+dkbGoSPXG0/gs+RtlldzQqICdzvqywS6cKwCNsK4j/FgYB5dkP7tCd2mrliTFwvaWiL9NM2iP8FYeHvqKUqkc6PNaSuXH2EQ9noK+WqkcUAF9FpD4/Z3JdLg5WA0MC66IhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9cpEU4oB19qua3yZO5pXOV6iVuXFQjbXo1mRp62Eug=;
 b=KPgEzdSH7d99txCyRe248KnkHL1h4YBK53OTLeXHxio+yEQYa0IL4x/BOKiXSqY8OGxDsMbHgNXumXVHT790ld8A9a7lPMgKsv5gSl/IFHWst8bwS+FPkyvXCCjzGRX/OfMZwyA5rQ7VR6qObXCqZewU+XkwjQiJUtWUD6AWOqRpiZJFYOdJvW75eeFco9xxJway+PSJhsnuhvUWdiwzBnEcCyL2nfK6BXNCV4X/M6AQPNSkDjJi7+r1ZKSCa8LcjPzJI2iZsb8n3LiWNb3xWCvU0FOp5VFIwh4zleMTSJEqeZyTd+oTrf+Ikwz0nccpCA0tEdvOGOPyWjAmAhV+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9cpEU4oB19qua3yZO5pXOV6iVuXFQjbXo1mRp62Eug=;
 b=LIXYEzKoXYONkVEx+yD6scxceUykcFVRE6SkoEdDVKT4gOz5Ce5erEzR4u97kmbcYyNhez8b2Uigp0q0IP5wxQSKvgvN79dGSEkDROcPDeNNlvsNFqPnVOmUHN0NAQrAemHGCfArAMIBpxOKr8EBeQPGdf6SybJxbLTrhMmGWzU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:32 +0000
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
Subject: [RFC v1 240/256] cl8k: add wrs/wrs.h
Date:   Thu, 17 Jun 2021 16:02:07 +0000
Message-Id: <20210617160223.160998-241-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70e8d87-97a7-4471-c8a9-08d931a9f153
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978A6DB56C2F72D4DEA6FD2F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9as/Jd16JHJnnKc9PxwaQgtOR/O32o9djboAwv3AV9SnoHoPdpBiVfjmSHjI6+UIz08dKwHSSxBGj/Etkw+VeqwPk+ll6jfUQ4sKCHsRzVZ0BktooRUY7GdCqUpE0khn/eunxJCT6lXLFtl//WQbtcSYWeWFulNNQwJsitPTrLQc7OOFEfl2EJzXia3E6Yr+DjcxjG5vzHLEEZA1dDFmJEUDKEsMV0rs/atwbHx79lqzkh4VljB/A7S/eLdMowFs3lue+e0oFJ7trdu7jYMYrRCMISdiAslQSPAPyUYROiJkKkukrEsW+a7aZA48ZOmO7vFmi2Wor/uGMhHjerELwwzC567+m1Bdx85dU3Es/9KSlldzhvB6CRQsZDVoaCdudmdBC2uG3wlqvzCyJ+xQP40IjYt8mSgJAkIq09VhzZlNqBTXRkLjsyDfVZ5cnY9wbF9hk2g0ChDcYQo/8d/MqpIiDB87c9aW/S+LsOQrXok6MqqqNMBbUvNnfdcYxlSSE/8FCFcncVrIW0ORqWABgwplzKTKjHbXQISaQjaq76RY8xTx7R39m2lOkLGS/5HIFz6ckOIxWS10BskSQsDKJMbORrTRIn+L4x2l/nG9ZOahHEl+godjhQxHDcBUHJnHnBvFhqXe1Z0RTZx2lpPj6iOW77LCTGqbno0nukPvoFxMNMpltQTQeCoa25gp4+7aIdgfuIRa7IQ/oHRB+P+vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOFEz2+VOvPCKjETSSNP4x05ZZhpL4ukY3Xxn6WjyeT8PF6FsjVfOFs2Kfrv?=
 =?us-ascii?Q?bLWkrGryeT5XcvUTAp3cLNw9zrXln6SCqamcNOM6x2CBiMjdQJJneKrbo4OC?=
 =?us-ascii?Q?m7v7mZv+sZ6J9s6ydSM/3MMgGsAfW73GEqpFqF4fYXPCoUMJtDcLdm9Bj3m3?=
 =?us-ascii?Q?W/TzoE+PQMTVJ0K6cI8UggQplu1IMj8jUXp0q/J4B6JMRML8ij9eBI2bV2r6?=
 =?us-ascii?Q?P6nVjxsHsEJGZVuzPyTVXz1niTa7FluyExM+fk3DvVMuxY4oEu0jyQ4Lhfyl?=
 =?us-ascii?Q?xrR8nF+1UDS8j+nP8Zh0b41/qUMJYnoZKvAdsji9nZ3k7oyHvNPMWKQPF6o3?=
 =?us-ascii?Q?FxYKLmTo4Uu7H9/+t/nvpGHlm787AyDSJ4+p/uAbUK+yhmhiJS1QBYxsxDdj?=
 =?us-ascii?Q?xkcySwUajoLUsGST/sgnbRS4lO/6A+qxoC+sTQTX7Xvy5ay5cbYHK5c8jiP8?=
 =?us-ascii?Q?ots4rKDv0oUj+DqvarFFi67IuZBrTMJORNLQGqzoshmcu7oio2Vef4XHvZVl?=
 =?us-ascii?Q?BtmG8aYgA63udaCL5oGL25/kBofZFXbW83bC2CCWHHd8mOymaoBImN493pZN?=
 =?us-ascii?Q?clMAOcRBZCtT62TyX8DDW2qcEv6OWFfPaYy90kABViHMi9PwZMpUUj5W4RQk?=
 =?us-ascii?Q?ku/zDRorSH3b3MafqcuUHs6OouFWCgJxipPXXiBvK7of/Mj4ECq6zIL436ka?=
 =?us-ascii?Q?mxjJz5qnbxN/iJF7Ve9eSSQXge8/uSF0noeYOOx58tYTM43vQabndZyjeN6C?=
 =?us-ascii?Q?JGhN2myJjPWkrWT2cDF3lhO8Aa//vJrOv7jHGJB8nM6/gVhdOb7Ef1oESQcj?=
 =?us-ascii?Q?xJJCZyLcjDVn1AEIWeYHqMDESj/X99+bHXTSQFvsl7BskgBDUu3kBPo9MtNF?=
 =?us-ascii?Q?SX7RBgokos6zHAF7gj5dthsyphOL20Hc7RgkVVmBudnVJM4OyXdKqgcHYrk5?=
 =?us-ascii?Q?NnKQFVUECYYLhCD6u6bKbBAU1Lpu2VCnDCFSXVgVnppliCr83DfXianq5qjL?=
 =?us-ascii?Q?d0Z8dIuhzjVWYSuzyDr+zVvwuC+sOT7u0zD9x5jiE7+vgzvhkPac55zs1J6S?=
 =?us-ascii?Q?8C7gWBa5ltr1N4krbslLR7Oyt/mw1rjs5Xtr07VOwgaHjMeBi+Te3CWcWguN?=
 =?us-ascii?Q?xvQLxSkMPpgUNM6vMw5a6OqxsOBl7uZT/ypZ4U9rwk+uLhdc+dASr1Ad2jo1?=
 =?us-ascii?Q?sD1ZDvH0MJGNcMu5wS35XxKFfEUXVnchD7Sx17p1Qw+TfR4SFhXVM02AA9VH?=
 =?us-ascii?Q?LUousGY70eSS4EyUuZcmZ8gsM705LXNCSjqwKXnS8husZ0cMf30iz5cTAyaK?=
 =?us-ascii?Q?AbwwtQy331jjdGGG9QfnyQRe?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70e8d87-97a7-4471-c8a9-08d931a9f153
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:01.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrP1IpMdinZAf/3xG7uMcqnwQJdmfz7N9gTvs03hQ9TlV/0/5u0n2e/PQvbbZHuTn8dokwfQDeVvHKjH1ekxJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs.h | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs.h b/drivers/net/wirel=
ess/celeno/cl8k/wrs/wrs.h
new file mode 100644
index 000000000000..cf525e868341
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_H
+#define CL_WRS_H
+
+#include "wrs/wrs_db.h"
+#include "hw.h"
+
+/**
+ * WRS (=3DWeighted Rate Selection)
+ */
+
+void cl_wrs_init(struct cl_hw *cl_hw);
+void cl_wrs_lock_bh(struct cl_wrs_db *wrs_db);
+void cl_wrs_unlock_bh(struct cl_wrs_db *wrs_db);
+void cl_wrs_lock(struct cl_wrs_db *wrs_db);
+void cl_wrs_unlock(struct cl_wrs_db *wrs_db);
+void cl_wrs_fixed_rate_set(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                          struct cl_wrs_sta *wrs_sta, struct cl_wrs_params=
 *wrs_params,
+                          u8 is_fixed_rate, u8 mode, u8 bw, u8 nss, u8 mcs=
, u8 gi);
+void cl_wrs_tx_param_sync(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs=
_sta,
+                         struct cl_wrs_params *wrs_params);
+void cl_wrs_tx_params_update(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            struct cl_wrs_sta *wrs_sta, struct cl_wrs_para=
ms *wrs_params,
+                            u16 new_rate_idx, bool is_sync_required);
+void cl_wrs_decision_make(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta, struct cl_wrs_params =
*wrs_params,
+                         enum cl_wrs_decision decision, u16 new_rate_idx);
+void cl_wrs_decision_update(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *w=
rs_sta,
+                           struct cl_wrs_params *wrs_params, enum cl_wrs_d=
ecision decision,
+                           u16 new_rate_idx);
+void cl_wrs_quick_down_check(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            struct cl_wrs_sta *wrs_sta, struct cl_wrs_para=
ms *wrs_params);
+bool cl_wrs_up_mcs1(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                   struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_p=
arams);
+void cl_wrs_tx_param_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                        struct cl_wrs_params *wrs_params,
+                        struct cl_wrs_tx_params *tx_params,
+                        struct cl_wrs_rate *rate_fallback);
+s8 cl_wrs_rssi_eq_calc(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                      bool read_clear, s8 *sorted_rssi);
+void cl_wrs_tx_cntrs_reset(struct cl_wrs_sta *wrs_sta, struct cl_wrs_param=
s *wrs_params);
+
+#endif /* CL_WRS_H */
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

