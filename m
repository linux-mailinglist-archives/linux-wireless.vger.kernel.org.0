Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146FE3AB8F3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhFQQLU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:20 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:21118
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233856AbhFQQKF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV1UaOlvCk5R9A3P57qjl5Gi5IWyAwHEINfyrtRIaa3vSMBzgvBsMR8FLMs237UZM2xVx5oB+w3MkygUlFhX2quJLhwHN2yiOzQoS3VRgOsoX0ewDQkpKkWXPloWWn4bfB9C8rUvTPDPTXU89WVwq8wAKCsaXqDku3q/C5ULqmEPolp+5xWttRSbDNr/xX746aKK9jTxKb8Q55GYmd1eHGhPT+BuqShFtPoYRMqN13VoPe83/7bsPcItjNJcvkabkZWdZz+kT2J0/hinV6iKOkzEow3DyuIIe/9yWl12QxPonJFZ/hFjE6E48eXJbQ1ICjbpIjkqBejV1uHj7LlKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0v9CK7+VtwXYgchW3eJKn5wixu3DDkWL3pwX3iXc3I=;
 b=DDNR/pwZ3ekz9IQKGGTD3ekjH9NJFtFbKzqXAJYHkislh/2qJRwDDWC68mJyY9Qk0UUKLaLdFw0n4wSu+zWnZVkktM6jT9WncFxoNZL8eKE2ntQfSnovZ4yPuZZjOE6fFgBozcG8NpVL8nfj1bYIuLP/V+dd41KLNq4uaZ1mn2fPIz2IJYxeqBtNsIWoKDzAS8JZZP4dVA4Jy2x9vzNxXjciN9lf1oQ/RJoUgxoRSDebBx72020nguVowLWFcrPCVZbzTpCP2yJngcICHRzcjp8Fbwvdw5MrYZsHzsNv8OMi3n+AjXRLKNVfK7Pw/YucC0+gtDcn9iNqgSkcaQwpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0v9CK7+VtwXYgchW3eJKn5wixu3DDkWL3pwX3iXc3I=;
 b=wvjCDisMLCaK8qTRKEx8nw2kPfQQ3xtmGRyySCeKsXR7CHCbZ9XzqC+v9IHrwxEhD10FMfFVMFlcBQS2MUper4sMbLhblmAt3xstDv5OClAQBZa6L169KjbZDqLKeBrsIVgni1bLbpKIbd4BNQCWHZDIBcykDCSgbz4mKt3OZKo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:14 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:14 +0000
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
Subject: [RFC v1 195/256] cl8k: add twt.h
Date:   Thu, 17 Jun 2021 16:01:22 +0000
Message-Id: <20210617160223.160998-196-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc7acb4-8710-4507-5190-08d931a9d28d
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10753EB6BDB2C98DFA0CBDC2F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuJiMPZboF73WeQU2smppCFBelI1i65Rbpgh66BYdNmPNXAZ8VcNxLHv/ZhJhsk7W40Y9jgNoQJZCjItPHOBrp7qKJtULjlXaMTvKBN0HeggrFgvSOrWbC7YC7du2i6rxwyneqtj7Brcp5ivb4j9tsK6t6d4uhO1fC4oAFd2BuD6ojsZMHSAHLhVJo7eSWoJ18SBrYeme70oegwpieb+MoUjNzXgCt2yqOOfz9C95E9xyglZadcCG1a+zOnefsDHrchK6Nx8//OUX5vGc3Dsz18zbnp+czZefJ555LKzFs+Ci40NjemXrK+46/H+X7eMwUUBhGyGItAe5Km4Zoz4FbvlOX3xMVKd45mzk+NyCAE1mkkVsy4El9CpOFWMZk3nZtp3LZzeZf6I3f8SDzsLFcEqGiLRtnu+WTn8XGaCK+w0t0tdK/EiaXHXc+TbSeIudmkN/hO2fDExqzZtLIREBxL8j+7/Cj4a+GodbnEPK6AdxcGFGqfPGuusvy8Xha1YLKZeBo985hnqCVK+Hr40aRCdmeJ9ZaVC7srIn6uPNBF9xWf738N5brCzbR7okWAyS/V1nam+tYuxUzmhIyrxu9PwZo/SAgzhkS6sjPdCCpRaZHGltuqGif4p/fE8QqbQWddTOMS/YSxoOfm9C/cvGWXmMObKIOAVQ0FSLTWg9Eek2T5ApJZY8RDcV6x0DhYJy5dbgz4Up7zBguHsctkI+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Md+17phS0P2hn1K0YqqxwgPmrB5Sxmh94GAeRT1hGDod/Xt0B/KtqOIlD3cX?=
 =?us-ascii?Q?EzaZ+iI5/7rgSzZAzU7Fp2QqxhD8pqhzxEf9cu6hBgNP3zgluUNcMdeaTnAS?=
 =?us-ascii?Q?W/dFxSI5ZExXmArhcUkrzmY/kr0EUuKwnkZqPCLN6jJh8UHffj/MlmjN3GYB?=
 =?us-ascii?Q?w4Is6OhXhjww+vMkku+It4kTR+KASGpYXlSKtqMW8dsBRfKAcDTFTzE/vQVU?=
 =?us-ascii?Q?yUGlncFyT4NeD6VNB/py0qgEXTQLuuqRvnK71PYNPA8ZVjXMini5Nid5Kr02?=
 =?us-ascii?Q?BGRpc0KPE1U2jezl3hMULNFIi8L4zhFfCj/m75ioSbdkp1aTyJ0iHzZfhlmG?=
 =?us-ascii?Q?hKYSXuAwLbR/twEuOrcLTw+v3zczt0ITBzBr1qvcHH/lv5SXZvyfJ4y8wO7a?=
 =?us-ascii?Q?DNWbiJkdx/Co+MZbQRKwaTnTqPUrpQx94OEnXJUs5W6uch4ys5gttdPZyhc+?=
 =?us-ascii?Q?aHiPrTe6hQFLpZopEFiY+FWDN0DwaVKjm6hzzLmMHIX0cj/0of9Thwt1ej4u?=
 =?us-ascii?Q?Lmf9O+GugL9gBBe5kllCOxxeEvobrV2l0xC4KsqRwKv0I8+kjfvtwE+771dy?=
 =?us-ascii?Q?t3PfM0HXQKcEprZZm2jXqTIZPeiF3Jat00yqH2VH+TOM5fXHC3QzhHcCrU8U?=
 =?us-ascii?Q?k0KY0n6JqOoCwHFpDFGoN5YY+96YvHNG0ds252c/qtgxZ1ZbRLx/Al+2/W+n?=
 =?us-ascii?Q?Q8B2yKRrzkzDYCuf2nn475pjOFENV6cdoOMEngX+PbyeXBU0TF/LRvwUHfEH?=
 =?us-ascii?Q?2C6i8J7ECjolRRbCXObArSVse31u27y+xpiXeKpK+DCh7iYEPqHxnbhfNIGF?=
 =?us-ascii?Q?J4OuRh7FDF6pO1pIqN0omX3sHyNQcnN6jD18g4+3Ym9M1N752o9HT9bJKcH/?=
 =?us-ascii?Q?5BW1GFaYC4roQeTlBRKIsCRGGuwL/e7vWCG7iHRPsduxkcugMPTdzxoLJGxe?=
 =?us-ascii?Q?pGyjvYxaDQCvqraVxiAZYD+B0iGik5z2rRmUyozMjLP5Zz8u7xvJ4hu3TOcn?=
 =?us-ascii?Q?qNCsAmP9MA98ueD0PCdUVd5gcw5oCdz33358o1vHtXadxETH+5mfLZ/SVYl0?=
 =?us-ascii?Q?5+UW0ph46ghmX4f1nXvtwdQF17FAQDkmN9fTMRN9e3UAgePctTWbdgH8VN5c?=
 =?us-ascii?Q?+Rad9MDL0L94jPvW9DvvuFtcoIdM7eSIMIl7BkT2fw7JWN2hb5Fg42i53UL8?=
 =?us-ascii?Q?rnKgcKRRuQ7eyfx3KW2VM6EBc4cZ+PqOC56g+HO3etZUTl9ux0YgDLkZVEre?=
 =?us-ascii?Q?JTNmeh5XxgeudLfeGVpw7YCdSG3nhFexMPsxK5H2Kse35+97tgeGAY9b8Rrm?=
 =?us-ascii?Q?VYELqskfEM2Pz0SfTuCkBUzs?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc7acb4-8710-4507-5190-08d931a9d28d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:10.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlAmUEGfrp/kLjYgkPChpGbE4UfqXVi3aBjHO/5DXLm/svhDAAoDxQZpiUF4S9teNwrggrvxFNEZDL4t7aIuBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt.h | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt.h

diff --git a/drivers/net/wireless/celeno/cl8k/twt.h b/drivers/net/wireless/=
celeno/cl8k/twt.h
new file mode 100644
index 000000000000..fa01c69abf4f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TWT_H
+#define CL_TWT_H
+
+#include "hw.h"
+#include <linux/ieee80211.h>
+
+/**
+ * TWT (=3DTarget Wake Time, 802.11ax)
+ */
+
+#define CL_TWT_DEFAULT_INTERVAL_US 524288 /* 512 TU */
+#define CL_TWT_DEFAULT_MIN_WAKE_DURATION_US 64000 /* 62.5 TU */
+#define CL_TWT_FLOW_ID_ALL 0xFF
+#define CL_TWT_FLOW_ID_MAX 0x7
+
+bool cl_twt_is_enabled(struct cl_hw *cl_hw);
+void cl_twt_init(struct cl_hw *cl_hw);
+void cl_twt_close(struct cl_hw *cl_hw);
+struct cl_twt_session_db *
+cl_twt_get_session(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 flow_id)=
;
+int cl_twt_update_session(struct cl_hw *cl_hw,
+                         struct cl_sta *cl_sta,
+                         struct ieee80211_twt_individual_elem *twt_elem,
+                         struct  cl_twt_session_db *session);
+int cl_twt_add_session(struct cl_hw *cl_hw,
+                      struct cl_sta *cl_sta,
+                      struct ieee80211_twt_individual_elem *twt_elem,
+                      struct  cl_twt_session_db **session_ptr);
+void cl_twt_remove_session(struct cl_hw *cl_hw,
+                          struct cl_twt_session_db *session,
+                          bool send_teardown_req);
+int cl_twt_teardown_individual_sesseion(struct cl_hw *cl_hw,
+                                       struct cl_sta *cl_sta,
+                                       u8 flow_id,
+                                       bool send_teardown_req);
+void cl_twt_sta_remove(struct cl_hw *cl_hw,
+                      struct cl_sta *cl_sta);
+u64 cl_twt_get_wake_interval_us(struct ieee80211_twt_individual_elem *elem=
);
+u32 cl_twt_get_min_wake_time_us(struct ieee80211_twt_individual_elem *elem=
);
+void cl_twt_set_target_wake_time(struct cl_hw *cl_hw,
+                                struct ieee80211_twt_individual_elem *elem=
);
+void cl_twt_set_min_wake_duration(struct cl_hw *cl_hw,
+                                 struct ieee80211_twt_individual_elem *ele=
m,
+                                 u32 duration_us);
+void cl_twt_set_interval(struct cl_hw *cl_hw,
+                        struct ieee80211_twt_individual_elem *elem,
+                        u64 interval_us);
+int cl_twt_handle_individual_setup_request(struct cl_hw *cl_hw,
+                                          struct cl_sta *cl_sta,
+                                          struct cl_ieee80211_mgmt *reques=
t);
+int cl_twt_handle_individual_teardown_request(struct cl_hw *cl_hw,
+                                             struct cl_sta *cl_sta,
+                                             struct cl_ieee80211_mgmt *req=
uest);
+
+#endif /* CL_TWT_H */
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

