Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A403AB90C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhFQQMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:08 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:25569
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233812AbhFQQKx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxtUg7BArTHh1pQShxr5aiwyUgiBY8mHBXJIIfBuWXXRxQdJdx2hPVr/YOsGlwcqDgVhpjLaaxTntwlDhuiHXCyGJpvpoE45ZBqxroee97rb41lom/tsfWMdAqsst7RgFYjB8h+YUk2buWVDcFGwXIwD9mb9eXDcVhban4Gssqu1ZRVw73xDCTzxu6uGCEdoJueouaWMKvOxMxT5PQ6rcgYAVqCWrvLa3xnp0XBrbA2AUTOddGppWmq9QZR867D2sf7xrxkdDT0LnE4OjT5luCWM3d1KguA2IP722usarlurfTrMzeUtXhlCWWBcMhJeVqeNytc68t8Lo8CWSHRXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVB26Z/l7CkC6MejwD4drrPj6nBHK4k27CXMHXpdHig=;
 b=NAMFssKxNnslomo9r+yUXaoP0lhh1Btqk8+8e5Euh6eBou/FWZmrnJ6bJzFt7rja6BEzjrKzJJCyTtJ/TYZ7TSdwpF6oYgWfmAM3z6gOA0a6XTmw4NrkMXauazkCLpsBIgsypeRkU7DhYUQ/Wu5ou9fRy5w/HkOHOVKGNcTyB4j5vnQLJrN+r20lxHi7IGPd6Wg0fy43aZKBcgvw7MQuRNnAfYCEFjGgDx9/UqyVGG3EzrshTUZZwSXWIx+/wnVOt4Pn4m9VhMklBBaEZRdFav6oAdeaPObvGMm2jJQsw3vi3OIyO6zFtNaDSOLH9DbIxwLeH/gqFyy3ZqQ6xWfWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVB26Z/l7CkC6MejwD4drrPj6nBHK4k27CXMHXpdHig=;
 b=NeSHXNfCv0CxsNYJ/zL/g6cyrVnfN+bIPEd/gB2eP6u8v624LixtrqaAhk4Z0WLdDyc8R/5W04aICNJvxymLO91doT1IvhPtyVJy7ZXlsX8i7QcAhRebj3+Gbn71Ho48vY3nNcThvJMQSd2p3dsIrICTMK3rPrGnAo3N+KNeHyQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:15 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:15 +0000
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
Subject: [RFC v1 199/256] cl8k: add twt_frame.h
Date:   Thu, 17 Jun 2021 16:01:26 +0000
Message-Id: <20210617160223.160998-200-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 270e3e5f-6896-4667-6b8a-08d931a9d545
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10752C2BB303BBF9CC81B248F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMwrG1g5q5aZPAFDPmFuKTbweOdq3bwDQsVVwnS/ej4E+wlU6pDrjYs7Z2IBm7dqFBD/2nVSNFtwODnnq2TllhAm/ksb7BXZg/73yuZKkeLkYiRy72XVmDhYX+J3DtCqErJ7nuL7Jj3sil7JjImCoH+a6JNn6nq1tCDtAeKGnauUn5p6m/a6YkU/RiFa1sfHUAVfZrNkzPMfrjdpzs3be0U8Z905CzIy6EtVAODYiqTtjDG9tacEdx3P/+th9ZyfMZLd7iXGH03Qcr2WmXb24e6M3v24qhVXMKh8yXThY/RwEMAwrRXQFlGDxK6Nkl6IziLEnQYpJxCpf6NNdJcurcT/qZVGIvUQp6Qiot5smrE9AlfiLVGMd499p6wG4RG9OC1n5Xo54O2+d2jO/HaASTHIqpeO30UKzojA6DHLyMfQEGVjpl/+NpjcmsCkcXJi7EOeVuHv3pvFSqr8zBcjZupPGNUB0F4+Rgwc4qdiWD4Zx8WiV+0PPqN7VDh+TX0oSelcCN6ZHg9wji2wXu+DRp7o9Nzp4QPkECb5ZW8mldNCZd1OcOfxOT2UiXUjVQKc8odsSDPAFCd7ZU6+RmUH0DpQyB1p1g4NyInzzxXs+yXfFD26felWEpIwsfFVVZosA13PK3FyiWNf3RAl4+DOwJh0AmK2VjyReTGmp2Af4MSVWE81x2qETFN9w9a33GRltgWdXv2CshuDgw3ssHVuCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydZWvGYJGbNJsfg2M3yqT34WivSWCXdAE7bMhNDYkV6H4ehasQhB+eEGuzBm?=
 =?us-ascii?Q?hAZw2l6JkoJWE5JEHCyPv4TDccLSSUwtA0KW3Y27aM9H9cf0SB0BDLRB1oHT?=
 =?us-ascii?Q?zXa1R/iSWC+ntwbVskO7WKU/u8dHtFIcX9nU1A0Z4QcC7KFle2aQE+HwXU8Z?=
 =?us-ascii?Q?k1Nke/RPECH1iE+oIhXuM+0kcfrSe2JmzZ7AKfdW0Vyx5XhQPWTJ+2SFbQ1f?=
 =?us-ascii?Q?1RTwC1tOsO7ydEfFGl1YmBupS/7yLExaqOA7oHse1EDm43LVlT/KPke8RFUv?=
 =?us-ascii?Q?4k9vP8eUl5IQz9hZpQbtgqDnJW//qt9QxwnNwJuRthD0QHZqQd8KZHlRktXD?=
 =?us-ascii?Q?V0w0zNA7rUG+U2CnFz5hNhnqkN1GuCrw/mhlzr0GazyNZzfD/e1c8SkiLuYa?=
 =?us-ascii?Q?5hQCvEkuIY2xb7476axdZpSNcnWqjTYxlXMRsaRX929y2IiZixQmCl6g6r4n?=
 =?us-ascii?Q?S3E4eKFunaI7pXpbQBDX5cEhnwP+4yTyPjWj3ysc71tydWZERgbrvB8WkJ1b?=
 =?us-ascii?Q?JiusGVl7glf7hgjqIMSh1jqVW1PKijiRBwK/1WHsh73n+mCKUqYoShAai5Cz?=
 =?us-ascii?Q?w4mLCuv6ud+USrcnX5wwsGBErKOkC9DikPsHA2Bt8YP5Qya7fVI6YstmbfQu?=
 =?us-ascii?Q?i8LS+4eLw7EgcuS75NjLbcIEJf9RjS7Y3nC7EklZ1P7MmX399LGNzvBBvLFW?=
 =?us-ascii?Q?qMGxswbVSlZXz4NZNuvzZ2WR64VjWwWu3RKKx/pYjKiVsdk4IrUsVIlgfP3G?=
 =?us-ascii?Q?3xzpRH84nIf3MmUGvO6ncIn+48muQoLrYh+P+PYNVvrfvpYs3WL1NoQsXK/G?=
 =?us-ascii?Q?0yVBqpEMDlyUjzE1w1Y6fSqGcdWV8BooqN/Z8bdnm9DWhlx12S/n+HJH+Z6V?=
 =?us-ascii?Q?zBMhWlIBoS2SFvS2K/1BVJ/r7yKnqEoC8As1/2PoO8BR4/cppBzGwfzLysog?=
 =?us-ascii?Q?L8j2eo8MT54dLj5rYtgUcnlAFNmrb4AgDRXAjr2vJkGjg26wn45mR4/11hI8?=
 =?us-ascii?Q?JSPjWWP232sX7T21MbAnnV0uEpw9VFxAu8gEhQWVcsen7u6lDvoVBSj43rF1?=
 =?us-ascii?Q?4JGIpv1VIo2LU/kSCqPJqxxHd4/DcIh37FffKfp+VdMDpDuLVmELzM+ZcpcK?=
 =?us-ascii?Q?RBrrDYlF+x3lWOHZ50B4yoLJqw5zXm1OnVsNL1sWtf+a4e8F895bufUIX7af?=
 =?us-ascii?Q?RtT5HaxyMIX5Tu3ZQaGcjYHa+F5GfwCRuXw2/kiAJdLh98dqc9dtljeRpIL6?=
 =?us-ascii?Q?/c7+UsRGZetW2kxNKyAI45stq4b3UtUPR2KuNCQ3+lSOb6x/aytoESbiVbVz?=
 =?us-ascii?Q?lotq44chZUyoC3u4UN9MXevF?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270e3e5f-6896-4667-6b8a-08d931a9d545
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:14.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw4+8OjzMgE0KCFQntKqSyap20VHd2cGa+L511R7ZXBI7ri3h/tlHYk9SBTRS4MriqDJKAwXA1NCirPXM1WlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt_frame.h | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_frame.h

diff --git a/drivers/net/wireless/celeno/cl8k/twt_frame.h b/drivers/net/wir=
eless/celeno/cl8k/twt_frame.h
new file mode 100644
index 000000000000..92d462caba6f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt_frame.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TWT_FRAME_H
+#define CL_TWT_FRAME_H
+
+#include "hw.h"
+#include "mac80211.h"
+
+bool cl_twt_frame_is_individual_setup_request_valid(struct cl_hw *cl_hw,
+                                                   struct cl_ieee80211_mgm=
t *request);
+int cl_twt_frame_send_individual_setup_response(struct cl_hw *cl_hw,
+                                               struct cl_sta *cl_sta,
+                                               struct cl_ieee80211_mgmt *r=
equest,
+                                               struct cl_twt_session_db **=
session);
+int cl_twt_frame_send_individual_setup_request(struct cl_hw *cl_hw,
+                                              struct cl_sta *cl_sta,
+                                              enum ieee80211_twt_setup_com=
mand setup_cmd,
+                                              u8 flow_id,
+                                              bool announced,
+                                              bool triggered,
+                                              u64 interval_us,
+                                              u32 min_wake_duration_us);
+int cl_twt_frame_simulate_individual_setup_request(struct cl_hw *cl_hw,
+                                                  struct cl_sta *cl_sta,
+                                                  enum ieee80211_twt_setup=
_command setup_cmd,
+                                                  u8 flow_id,
+                                                  bool announced,
+                                                  bool triggered,
+                                                  u64 interval_us,
+                                                  u32 min_wake_duration_us=
);
+int cl_twt_frame_send_individual_teardown_request(struct cl_hw *cl_hw,
+                                                 struct cl_sta *cl_sta,
+                                                 u8 flow_id);
+int cl_twt_frame_simulate_individual_teardown_request(struct cl_hw *cl_hw,
+                                                     struct cl_sta *cl_sta=
,
+                                                     u8 flow_id);
+
+#endif /* CL_TWT_FRAME_H */
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

