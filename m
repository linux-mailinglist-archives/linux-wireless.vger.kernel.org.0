Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296733AB8A7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhFQQJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:40 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:41442
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233696AbhFQQIV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILWXl4SqQdmaD9P1pVM54CPiahJHND2h2YayTXvwIp/jIcvbsa8lM0AlyfDZ1btHhmB1rWjZ2DNrLFCQ6U+dhwVkWOBT6rrB+T8OcQUur0RRaNfPXYaK3LtYx9ATqT4tOXSm/NnKdCXMQqZS7s7b+oavbxopY+lRZiGZ9u1+dl6PnlGsY6WGk2Cn++Pch0ZsOkLcKAOBIuaZvGa1QUIb8w8zMBIkICX9s4hbe6ygKc0AeVNxD0RSgsMDw6xvOTO94hSQxpDc/30pjMKNAiYZChUxIppO0Lar+KFtEXUhcx5iUzpCgd2i/bszX0FRJ5s8Mf08Fb6S+aWAl3JIA6baMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtJkTSa+1HgIzi1oobvpE5xl/9yV3rnzBZ1qwOxU8zU=;
 b=XWeWB+Hyv+WzZfvGIw6nAJkaDq4s1tPrVvOlxYL8MEbG4CvZ03Y76kgGpn4ppKewnIKNUcWxh7zio53aqKvmPudBqPOVtZO3rsFIbLLOyRjwOUlavXWz2FKdjkgIn81TxoEq0pEQ/WazVMQR+Km1jz+ja/dqJd1QRQZDxrpCXMoJd+H5htfoK7sSYqqmqbE0kOJNwWPDk0MWtglflDfYb605pwJc2p1KozDY1nTIF7gCPPrB/NfpeKeW1N9Ujb3ahdL9Sben0MujeoNUfS9iCsSfCMZ96+h3cDOKNtpQifIvLwozY1W71DJUzLjc66bLD65Yq6fsAhSTDCxFTkiCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtJkTSa+1HgIzi1oobvpE5xl/9yV3rnzBZ1qwOxU8zU=;
 b=2we4Ey1UauDaB+3AYYBpnSejd5oOgBIaFbHI3vcpCWHcE0oTfPQ+F45pYdKtcRg8wvQ6kxni6Ar5BS7LuKtBNV3RdcdXehPuuABT348d1cYlckNcfvEq9B6PxtiHEhavNYxm36qLUKVlBGnNB6xZIHEu9D5N9b2no/H8lWFUOcA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:11 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:11 +0000
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
Subject: [RFC v1 118/256] cl8k: add netlink.h
Date:   Thu, 17 Jun 2021 16:00:05 +0000
Message-Id: <20210617160223.160998-119-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02289728-9de8-41be-ab46-08d931a99f77
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0402E8BF5EFFF59453322FCDF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reSl54693BLIB5NHjFZdycEu5zcbsUZ8cqZl7XN58CddiCqIWrTEARNYRU1RSl1PSmmL5bHIIAyjRMFsomW3/eRLiG0FGOfVhItoWEgungw3S+kLCz6MxlTlNV0B8848wDcrS68KdDA9RtWgh7uZ/mRUqyQVSVIDwUO1bGytbh3NO84wzZewLQbk/3uVK7yhJwBCjyn3uxIUGlZZFS8zuT2kPhhtvnX4Qq1I84edtUwqU8oI6XGZ3uxEWK91icIiMl9D9pHS6q/1jr/lwf1DNGHcKZjuAN2qlEjXzQNKP8Xn+vp4ZmUeYUR12iBVBlU7mNjKMD7nbf8vJVOdSElhsqYXoLWeEqtrgg24qD1PdmHW/h9U55DkUhRnBhJwEFmSAWPv5vBx2yKcoO/avKzoHSVbrKs5hZwLCx4Lk1JmvF4O9Lvz/WWG13ThTJ63MpZnp7yU+pRNZmCkBnLIvIgBXNmSe0m0NzIXQ1V0VWyMdigSTn5wz6aBVTMW1V29jpSuJObdD49JoxyVJe7GVvwTINRT84VUv0bNYmgSop42xCghAY6or6XnIGYbveG4xwlpVhnxGNcWMAsv7J6pRSwScYzrW0LAkrCGx05vnvgEHrpoTQTgHztpelDcuNmZb1J7qstl34/BH0z4H+jmlAI02mLWaCL1jO17CuJLTa8MmSqV+rSkDrdzz4zp2xlYrOfqW6HgRGFXynL7VIWV8r+ZQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xoa6v5EAkSV7qIu82nCTgoCXro9DBghUY+Zc90Tny2/qH/uCPXlV6DPSOCfL?=
 =?us-ascii?Q?1Ht2tlaQkfB5wZY5Uv8XQwkNMy/+0tqmSaqGs6FegM1DgFROhCrmK80VKN4e?=
 =?us-ascii?Q?VhO/ScFlvljxKLauLfoeCnqPoKF1fwSnm+bGKGrFe/ssAe+fD6f/dNI+LVa3?=
 =?us-ascii?Q?uEC0QFtWLAhweuKCvhvku4slP40WNB5S9wIa7gUpV5WoDIWfpPQtcC4obA4x?=
 =?us-ascii?Q?VTnAWH8QwfYuUbmgfW2HymWiBayrmu8zNkhmMU2u0JXqjw4b4LShh1SzDhig?=
 =?us-ascii?Q?hNC5TQvhutYfiV1cUd5eUEvImBLRANYM7Add48Iy194dvlBqIn5erjNmxc4e?=
 =?us-ascii?Q?Jf0qUgfJl237Xcr9xaLVBHJOaMKvL5V53u22rRnkgm1Xrb2KLPaGTWx6C4uN?=
 =?us-ascii?Q?bPpiC736QpEOt0LkS8BzRnEJzjrPyYRq6UcJwAqUTkGTu3qIojUXStUJ+Pph?=
 =?us-ascii?Q?hyqFSV3xwYt4zzfYaj9p7VEmGVdgp7ZXVq/xVzpQgSwOt3W0DvoGvjRLLp/a?=
 =?us-ascii?Q?OyAIqobixdVy65Opcgy44vm+pxr7ok1vK9Ewu97HLulqKZzBEuzvjdcwoZrP?=
 =?us-ascii?Q?i0RfnRre6Tm3uaDBeRXBxMrhxz9MU95LrMYI4gzL9U8jlEp4cyQKlievezPM?=
 =?us-ascii?Q?y5dG5bjQajUuZKgMxvzf1cIfqnmNqUr96X59TEN/Sfw17K5JBdJt3tS2U1d2?=
 =?us-ascii?Q?IbZtPCCd8F66THsGoA++kgd/LKivILbsUuECcGFW3XxAco92cmzpGTHx9u5k?=
 =?us-ascii?Q?efWGPXQ09sJns5jBJGMEAuhqk92icD6MmIrnmEdjCFuAdwqfjpYdlBFxD6oO?=
 =?us-ascii?Q?+vmLWcEg9NiwlDAxSzpx/7bNktWNb4d3oosRVEHy/i2xQjivF3/3FOUdgk2m?=
 =?us-ascii?Q?x94SsbA8uYDNEAOHreAKJ9tWYcrFsiDqVLRWkCP5MPcVKlhOwMLSQSGEpAat?=
 =?us-ascii?Q?A7ADrGbINlcxk75sIyDnqu6BRSK0ziJXlk5KJtaXmtG1mCZL8aMkvYpLBvOK?=
 =?us-ascii?Q?V4yrs6hA59JG/nFc2A1+fHQHb0ohoso7YOIqaP1ZahAC0LZH8V0eP5HbljOf?=
 =?us-ascii?Q?celmc/b2L8RiM1yNB5QiL8vGM5eAkC4sGfpHjQHcGEYQxmDVWZQwnXtirbL3?=
 =?us-ascii?Q?xHlHemeUJT0N234AX0u/6E7aSEAKnayFDDnTYBfwmW95t6YTz+ziJJlpGKy0?=
 =?us-ascii?Q?e3Afdagkbk8HauIu/V5M8Tl/Tc7Fm6bx17DLb18ukOXXzhkSK4YxxxPVmkdX?=
 =?us-ascii?Q?3U4eWwtu+PW6cZGpvf5e8iD+HDolNetJaeVEE1TIr3ELb4kv+yrOcRLSHJdT?=
 =?us-ascii?Q?BP+1dBIwwzF/T5ZRudvjwDTl?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02289728-9de8-41be-ab46-08d931a99f77
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:44.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej9Z7QuVhDyv5LtUI4KVQ6a2R0/B6jQ67unHViNF90g/7eG7ztNBO6cjHkoqYT4hPkOXtWB92YsLZpcF7C7awA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/netlink.h | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/netlink.h

diff --git a/drivers/net/wireless/celeno/cl8k/netlink.h b/drivers/net/wirel=
ess/celeno/cl8k/netlink.h
new file mode 100644
index 000000000000..7bc7f0404a73
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/netlink.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_NETLINK_H
+#define CL_NETLINK_H
+
+#include "hw.h"
+#include "vif.h"
+
+#define CL_NL_MAX_PAYLOAD 512
+
+struct cl_nl_event {
+       char event_id;
+       char tcv_idx;
+       char data[CL_NL_MAX_PAYLOAD];
+};
+
+enum cl_nl_event_id {
+       CL_NL_EVENT_ID_UNSPEC,
+       CL_NL_EVENT_ID_CO_LOCATE_UPDATE,
+
+       CL_NL_EVENT_ID_MAX
+};
+
+void cl_netlink_send_async(struct cl_hw *cl_hw, struct cl_nl_event *event)=
;
+void cl_netlink_send_event_co_locate_update(struct cl_hw *cl_hw);
+
+#endif /* CL_NETLINK_H */
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

