Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248DC3AB8A4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFQQJg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:36 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233686AbhFQQIQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQucnhrNSGAXhZmWa9QyMdAM2MrTq4VhqrT3f0/0nTeQ0vV5qGM2nr5pQBBwWdTTLUAMPqDXfEFBdqwVuTnnc2EVtgE89yBWiX+CiUWYJUacMJH25Jf/hULIvwljXOqywCXFMnUrZuVQhpkqwTNXXw2iAVt+jNIhrlXf1JQtnH70QbDyqAs88x11cpYEcfe2vfbKrHzgGLfrNsKweUsd+6tkMe07rpUKLI7NMiAPZCdOIohStINxymQxYd7++5uRXse5tYZAlvIeMAguHZr2ScRiaWK+sj3rCbDjAQ5YwhMEnVDT5bbZQaHvcaj5fVCKq8YZahLGRwIEte9kSFn9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+64rGqIDPP5xVEcWIBx5laxfKQaOAVamEzKbDvXV4=;
 b=iw3DCTQZJZAYcpbX2KIY5OW+Nb7ZzMwKtnPauDe74I5vot50b1x4yFQRnhnEMGhqvCug+7UmVr38DIYaO4hWK/k73djX3Kwt747FvYxp7k2b9FQqmS/Z9B11foio1+nijC/ijfEKBRXD/9nuj40zyaoIRC+vIvpqTRd2rDuyUyBxcfx9grcJ3oKlJTLaCu9npvr94NbZVIJjpSY+R0kJqIXzDrQMOfk/BEcrAVwD5YLDrVxwUFbRAXrWRxtveN8WWAJEHSKQ4fkrC+yAg1Dj5v1BKdcIEJOiFE44wSPyhKvu2yjwZdOR0jSEKQefFe1Lzpo6h7Ib5RyjUpTyZ9Rggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+64rGqIDPP5xVEcWIBx5laxfKQaOAVamEzKbDvXV4=;
 b=oO+DL5vdBy2j50ALxlosfCY1BjilmIIlZ6/sHD7+q/9BSV15VbLj/zZYgajY5085EGGpNfHV3c/y0douSWNObtJJkKmyc29ts1/pqe4MPCyl4prtcegtqkQ6DIa1bHxkpLN6IFpF/9SIeujUMhiDVGEQ1dqqhnvXFoTn/fG80a8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:05 +0000
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
Subject: [RFC v1 104/256] cl8k: add key.h
Date:   Thu, 17 Jun 2021 15:59:51 +0000
Message-Id: <20210617160223.160998-105-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b00ddd4-18ac-411c-56cb-08d931a99640
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887224A2D6FE5D050A437B0F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMbpuL42G1CEo1u3C4kBRLkvOKwQ14OEfg+EEvvgYbiPZM0SdMGHFktXKGkCC9pT+y4t/wvZsfDXHs3Qv2Rzv7BRMmmlib8Hjh37h4TcPoDW5iKHDOs8WSHnXcNPkEGUbZ8gQQGLl6OIxHBbpV4CuetVcsT0SAz33+OuFYBS/P/lVRQ5R+tejMkyTBCJU5VlqG2YDnkWVdONW0sByR5g7Sdf5nhaqgCq6dj1lU6A23CdzXVZCHpPFitkJydgIgeXTA+74+cacZqdc7dS/TQvr8SXZB8SPromOenCBZs2AwRRloGjWmQtjOuUL6TIi1cUQYXTuuSsEVCqx3XiTMmNxcQUVBG9ax8X5GGgDRR18/qii+SXj+cjIybDthVOXrIvc9rg7dKEem+BZ2jt4f1yUz8qmqZC3ew1WACIpH7SX7UetBJsatQsE5y/hYhOlt/gdfNGUYt3/5HwDY2wcRRbSWpbYtC/mkhyoBkF7u7jYmwGNJxWI3jIvJB+THxkOSx484SAidAgF3kNiTeLuVtJa+avB7brSQrqPjZnYMJ+6UPWTKJEasZiH7+15b9mCnPAFmpd4vLYKfhJxlgJIEIs+1CbXDrX07gao0lw7QDroWD0N9NvPvX2c9+ghv4KjZfCEmPd0pPG3IaTuXtq5Hs9ZW/kypuj1kpe8vYLzVDAPkmxL1Ft7Qr0m3CjCaxmPyjrv++jm8XhNModn0MSU1Pe8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUfsLb+ABJ5RDbPV6pCQJhdc3JKaJ4DFiNYOYj9hMX67mf/jMCtO1/W2BtYt?=
 =?us-ascii?Q?jig5tDhVj3aeNai22CjUjvdWeoA8DaIYONHk331X8XASmQ+kYliNAKIesbFj?=
 =?us-ascii?Q?1CInrpqcMg8q1eL5EV5BRYvSYxkB2qs1wKLx65ldUWjyskYZva0IKD1q3oIj?=
 =?us-ascii?Q?ojHxbk+KpIwVQT9YqvkQMbwEj1En3CPcJ/m2OTVKJMigzNSY8sELg/opWY5X?=
 =?us-ascii?Q?PJn8YZUV2FdyAud1iXjoCx4y2kEhwQ8iDDsQEOYUyyTuBRPbxjLMA73u6MSA?=
 =?us-ascii?Q?Wr8lD726LY8HWKtF1VIYBJ8mFYTBl1xoDKRN/bfSaY06aWn5/8Sk7NKPv9kg?=
 =?us-ascii?Q?fNq5xZlIxlyHe9CGEpLJFxymfDd5g+mze8Xmr77h2DW5E0coqJre+LB24mQR?=
 =?us-ascii?Q?iCfXDHYxry1U9hj17rBLU+aQgQkVMBKpD6px0J13B71qsQllAtI/FlOZlXV5?=
 =?us-ascii?Q?zDh5xVvx7y/Ah3llLP3khBXugVfteEuBNWRslzQpzohw8YawUGBXbeTN+4Iv?=
 =?us-ascii?Q?f/wZsNnPHT7Xnh+0qvkBa1GWYTiLij9Z04F7gJcEDWFjd4hB/YOXi2hkGA1D?=
 =?us-ascii?Q?or8afG3ZBJFpoGG4m/ksZUkhssoh6tRTHkBOFw4PICQNA1DNZy+0fqgP73HB?=
 =?us-ascii?Q?x7BC+kNI5myGzebx2spUvZASdJZ1/X8pvB2AgamVGtuvV7cryQIgDZr4bZ8W?=
 =?us-ascii?Q?5dVV4QGlAaF3nv2U7/K2l8lnleFXDhAslYQJtfAQz+TNpj3fk4+fTE29TW4I?=
 =?us-ascii?Q?vpXr1IrDB05TZVDh6k75sJchNvohYHh+9jCKWnAjyaUUO93fL9UIST0q0Y1D?=
 =?us-ascii?Q?DwNDw1IbafpXLPc01e8+UwjxS0GzJGM4+Naj0cPY6fZiRsDFMAYMrk3iFTjl?=
 =?us-ascii?Q?V0Vi6S3avuduYdCztLK3QF7/QYN2GTdYoFqmp4Zn5v3SavUSLemuJyD/RcT9?=
 =?us-ascii?Q?bJxRsGu1K3AUzuAhTIHxvN4whvH7FKbLhHGNYPRJzgHdDXqpLH8srcbQqlop?=
 =?us-ascii?Q?JNR4QMp6lw4AhTe9gkcOWJ3hy2a5fzbkPfxmlsiiul+ISS+Yi2LpVg5as6VB?=
 =?us-ascii?Q?vf9mCeM3SRE3c+Ym20GFpyWzZw489m3lr9VrN6tIQit2VjOV4PiNyhqIVCfV?=
 =?us-ascii?Q?J1HBt37gRDzbGXE5ikJnAme9J3Mir0lOGYcWpPqlDLOpjjxjYoWVTy/YXwwi?=
 =?us-ascii?Q?XAxrPPUMDl0aMF51XyFKpnU1xhmLH69sdLCOJfxxJCK1a2FFDZZgWL3TUcIx?=
 =?us-ascii?Q?5Yn+cQx2mBVGM86DZm0ZZqKhxvMyTbrJpwplGqisFmvvZEzhqGT+NEqDwJ8x?=
 =?us-ascii?Q?oo5/ygKefuNQuea+JKHmnxQH?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b00ddd4-18ac-411c-56cb-08d931a99640
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:29.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wol6SIld8xDfqorQSqSCU7rZTyEx3csYnn7hR1qnSDyjhaYw5qHhstO3RGOr94tbpBbG70uuNXhbTEBTs6MXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/key.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.h

diff --git a/drivers/net/wireless/celeno/cl8k/key.h b/drivers/net/wireless/=
celeno/cl8k/key.h
new file mode 100644
index 000000000000..9c9b9fe122f0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/key.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_KEY_H
+#define CL_KEY_H
+
+#include "hw.h"
+
+int cl_key_set(struct cl_hw *cl_hw,
+              enum set_key_cmd cmd,
+              struct ieee80211_vif *vif,
+              struct ieee80211_sta *sta,
+              struct ieee80211_key_conf *key);
+struct ieee80211_key_conf *cl_key_get(struct cl_sta *cl_sta);
+bool cl_key_is_cipher_ccmp_gcmp(struct ieee80211_key_conf *keyconf);
+void cl_key_ccmp_gcmp_pn_to_hdr(u8 *hdr, u64 pn, int key_id);
+u8 cl_key_get_cipher_len(struct sk_buff *skb);
+
+#endif /* CL_KEY_H */
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

