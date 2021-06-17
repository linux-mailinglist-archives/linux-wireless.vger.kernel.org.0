Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2E3AB828
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhFQQFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:19 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233549AbhFQQFC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx0RCh2w7wdqcK4w/P8eoqwpgTVTxY6OfNTOHK0TvQG9ZMbBgTlF79sVyJimqigzDrDVC00hO/1zqckmKwPOtfNqtsUzqp1ZOu+Xp8TIzYZ/fxuEMud5ssgIdWt1lWzq9avuyANds4AVdZlYAey81j04a9UM0sAnwwFbCoeOnRYdyegc1F3ASbXToSoNNrYtHsJpn/THOemt+/0PvXD+fV38jD364/K6oTZIOl6+aC/2zr+0awhuDKKsBANKN8hsP5MTZXjttGPTCkuh10gO77t6k93PQNb3jlzUrD+/ja6ezCpvuGv19UKyyVyo1iFbM7nXiUc89PkQ0poslMB34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e2qcsHZ9cv9erOGrwlagK85xvk+czzYgvac5/qH2xk=;
 b=Cma8RCl+Py4QdZGYwNzx4prnxg6S7jZdZWUcDULVbDx+XR9j5QMQD87c1FuDyQZ/Sz+RHJuhE2cwnXemTH6UQja/qp3hG+i1cUb5RVGFYTYmw3pnVi/strttA0sGS+lxP9WFV2ZVlu4YeD/5bQbUr3XXX63Jcg92hKF12RL+ThYyPF9FZVcYHmFUe5Zj/L7/v080v2eJwgDaOCpUpfoIVrqMvUI6ejxBSFamhczLD4Q7qgo1pRsw14y6PSDxLfpaj+Yy7I9E8B3E6PW1el3lxVSkNtMEt8VdQBfR5cxIxvKB4F1yoULZMOyrG9a603zegkCYyXhMtL4VJgc9DclyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e2qcsHZ9cv9erOGrwlagK85xvk+czzYgvac5/qH2xk=;
 b=kC3qxrAePntfGFbwVOglXuzySFEfESTHeuwE9AbcIgu1q8Cbl/CwS3zgL+ag0IfGFROaunEcXu9Q1PvCX6V36Vz681dyjX6SBgQeKJgo7xwANvSIWRXaNrMmadRY49b+8tJC3EniFY5b8fOeMHMehnXPDH0+spVw88y3f9vUItw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:51 +0000
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
Subject: [RFC v1 016/256] cl8k: add bf.h
Date:   Thu, 17 Jun 2021 15:58:23 +0000
Message-Id: <20210617160223.160998-17-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f1d3de-fe07-43bc-60af-08d931a95c39
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04992E6A6ADEA9B3386E7DBAF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hp5aBZFMsdYBjW/g1S+2ON+4eNKeem3+aatOxGEbkCqVDjYFf8NQUKk7rqR+8i0Y36xXtNGMa4SCQNRfxxfA4guI5B9p60a7EUBRDINJgxUzch/aeQVuDRnkOI+3KZJRu/y1wWGLaudYwEg6qmDoAL60/ljhEQ0xW2TexPOzzKLPz0dffh3iFNrGHW7lL/BADjiinXnPjuC1rgGpQ7psErndNV8VnqzYWeVIwFJojdQsJHsVmhvfwnimpfL2Ymp/6H2JLBBPrM/gBo/+3zkJgCyGNM20KwF+JvkcMt7x/jdV0N5nzTjde+A57Bjvl6V6p1A6A4V8XSJQoEnIVr12He+EIGk6cIZcwHuL30pfUQJITjmM1/gq5cdKqIsnFwlIdejPA8W+cyV1pG6+aOQFtJQwJ4bCL45Tjo1OEI0XQldhzo9Ta0zSRXptMy5XYxXTk/wCmbF6zGatpl5VEVKX3lNM8y/Qk9x4iVfSbNmJBuYnI3qPqt7BsGXYsn2BQcZxWYNVPPdSGJHYG13N5j6pQJa2kmgI+IK8t64WYWWtwZcsrQ3dTOO1YlUGjqZa9wc5/s4ir7MClNJAedQzhcbCHisq36B19wO3tUM4ELyo8GEKpvWjKRs45vbXDZqlfKQHVcGX6PJ/O83AV1jFhKKDhmX1xU1JEsEbrHbcBdcOWBBUSImXhSwKJslOngXqPg/h3ORO93WvfIN0gUVlip5yew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rq8pZqLye34xFvTiE9Vs+MBIKSvEf5iodH98HthHsSFh46diWvV1tMyhdifI?=
 =?us-ascii?Q?ukp0kl3rfGUfReY/f5w6CMdsiosCk0XA6aiTCRn6ip4quhNOznrkWkce10bX?=
 =?us-ascii?Q?qTUhdRv6Pw0v/sFOc4AS0iAUlwq5Tb7P2wqxk4ibxOVB977KNyEGGk8VnFJZ?=
 =?us-ascii?Q?ZNshVgivAKb2RaZYpEBLx8MJ2PT4m6SupIZPRS0/3GwpMnA4Vh4PZNF4GToI?=
 =?us-ascii?Q?L47T0CLX39rRCp3CcXmY1YUhkxlaOgv8fFhRH06XlU3WCMYr1A090eX4IaEe?=
 =?us-ascii?Q?q7JNgyVwmelyOjFzdPFjdNjv1FIBUPbGYfC7rRuRYEB80bwo5ev8s0kU9sHX?=
 =?us-ascii?Q?1aYZtnGNzxLktRnB85Kors7n1A7bsgQJ0tPWts74lg9t8T+g7esPhKlrgFHO?=
 =?us-ascii?Q?kKaRshpJYIzi1Z893a7rgKysV0qoRf1k9HIZsrxwOFn3FD95RZ+9tvfs8ES5?=
 =?us-ascii?Q?Fx+e1P2ZKB5Aamb+k8+C2uxrRMgCkS/3fJnFxJf/K8WYE8zPIRrbzT9rwryl?=
 =?us-ascii?Q?2uJot6T3Rp59R8a4Bre5hnbwdlokWP2vfaJZhf7zTwDUBXXTJ8e+76oSKFvo?=
 =?us-ascii?Q?HTyS8b0kO4WgyeMUajf09/YXpFjiT1ERQzbMNM3Y0En/NZEF/Iy/jC+YYg+B?=
 =?us-ascii?Q?yr4PKhaoBxJ1AgHpYQEFlEApWbzIn3qQIkXBIF2wCslbrOYh04Bfumr04Kyk?=
 =?us-ascii?Q?vZVdRoJTWsnjFwCpn76YvSF8rtMCaKqidbCCHyjX61veO5R9ywIQipEnrynK?=
 =?us-ascii?Q?l69xGwlThCoZo2W33HVJpRts7ENOOFmLghLD3DO2q0fx+bQZoTttexk48vaa?=
 =?us-ascii?Q?dmEYkJcH6iFgp2oybEErGPNdRAm6SBNgmQF5RT9M9TOk1Wtq2SoqnVBVnwbp?=
 =?us-ascii?Q?CZLN6p0ksWhotBDXotCx6XcH5irVOVkhdFDhQ6ACOCrwVB0bTMqBCoDpXixh?=
 =?us-ascii?Q?TnINeiY08f5LPoOgTkcsjO+oUn4pofBOwOJaSoD1tLZiqv9c0AVM/wUPjM5i?=
 =?us-ascii?Q?Xcs5w0lRa+aZlKU/pED5A3yuox0QWqy6pddr7ph4Nlw8KVJEanQxjzCDg3uq?=
 =?us-ascii?Q?RgB893+30vl+gN8oDNFWcWVPA35Orc1QyG0a4RqmEVkDUq68YGN8shZhqQcz?=
 =?us-ascii?Q?nesa4NMkOqKgB4SzuYK1UCXfUoFquwFVw8yg3kEy2mQeBSq8AkgZK2ZHzuVI?=
 =?us-ascii?Q?/qAWWQMHIDZFIixifrjBDCo4LO5EeaxzQgMuoWA9uOc/jv60CQXT/4i9VBnW?=
 =?us-ascii?Q?X3AZQsGxQgi2Prpz30FXgfbkeZiqD2LQyqAFc0ZOSQjeaqlqL9Idu7z5VG46?=
 =?us-ascii?Q?WpMJ4taBO6SE9vH8JFQYWFdE?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f1d3de-fe07-43bc-60af-08d931a95c39
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:51.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwFMJH2t2eNEvWtGzP5cPcTTHIT6fb+WkhT7g9G3EtsTHcUBG0jXuTesVCIliZWr4o1WShtcwUdohmKxun3LRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bf.h | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.h

diff --git a/drivers/net/wireless/celeno/cl8k/bf.h b/drivers/net/wireless/c=
eleno/cl8k/bf.h
new file mode 100644
index 000000000000..eb7f0000b2c6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bf.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_BF_H
+#define CL_BF_H
+
+#include "fw/fw_msg.h"
+#include "debug.h"
+#include "hw.h"
+#include "sta.h"
+
+/**
+ * BF (=3DBeamForming, 802.11)
+ */
+
+void cl_bf_update_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct ieee=
80211_sta *sta);
+void cl_bf_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool act=
ive);
+void cl_bf_reset_sounding_ind(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_bf_is_enabled(struct cl_hw *cl_hw);
+int cl_bf_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+bool cl_bf_is_on(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 nss);
+void cl_bf_enable(struct cl_hw *cl_hw, bool enable);
+void cl_bf_sounding_start(struct cl_hw *cl_hw, enum sounding_type type, st=
ruct cl_sta **cl_sta_arr,
+                         u8 sta_num, struct cl_sounding_info *recovery_ele=
m);
+void cl_bf_sounding_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sounding_decision(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_in=
fo *new_elem);
+void cl_bf_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_in=
fo *new_elem);
+
+#endif /* CL_BF_H */
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

