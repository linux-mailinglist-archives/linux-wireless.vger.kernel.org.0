Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9E3AB8A0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhFQQJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:28 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:27105
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231372AbhFQQIM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEw1pQmIgOBjUG7kiusf4R4Nuw36Ue2VxvxP/G2nsODOY+44QhCddHi5tnTxbvDw0c0235xuNVqsA/BzT6nUMHWeyYsRlNcDEhNiRy0qVslhncJsAA3ZSXfGXZ353AVivLDNfeOnYbjFWhjpFUZl9io8sqkuX7MJuyZ49TWP+odUrh/xqQnUrzRkc6u+Db+LFFOfW0l5QaNrAGyHnJ2Vvw72/hKqth18Zbflv6XXwwoeVqTpAZEku6DmYBjuA7psg+EijuQkKB9tOVOIXANowXSSXG1cO1liouthr46nveMHSkuLoeLR5ZqmR3qN9lax1lUTOfiXVWJXi9+MK3aj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOXMTFW3/An2dgDVLUKyxKyQcyZdqn7CYpysjABnI8I=;
 b=ItQjDAPViIzD50PDVnYquFK5jNo2709EV0AJUBEyhdwsFR0lkgP0EzpvuRDAKC169FKy9OfA2DENAH+o3FRO31fozVFVCJ7JxrEd2fZLRJpOSzn82uZjTLHwjlyLtezUTyo1Ie/GRL9+ywTdkRvAVwyZVlYMpatjZMSAbcg+mcqQTwH51eDaWlci45NssEYgJ477F9avPgaEsiI2P0xgWg9++EQDK0cUcuMXMd/Aw7JFFLoWqORZvmjccjSjTYBF//1U6nq78zF1HfR4Cx9TCKjDpKkLEqifH/Mccke5Lz8uQrdPHTmxi0ffh+U4j41///2SUISQvpwcIdUDedUDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOXMTFW3/An2dgDVLUKyxKyQcyZdqn7CYpysjABnI8I=;
 b=A4LRnjyj3uTi9Luh7Pl6tx9H2ECcvxiOXyan26gD+Csuzn2MONsHoTKT0WirkNeL5hNCIUZHoqhwW9QQftTNEJV29JPd2IeY7OP4SnROWbUu+x94zvDjYBPFpTm9z9msBF/087+vhmhimiefgkYhu+7LKa2fxzUYbv0vBbYYrjc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:50 +0000
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
Subject: [RFC v1 140/256] cl8k: add prot_mode.h
Date:   Thu, 17 Jun 2021 16:00:27 +0000
Message-Id: <20210617160223.160998-141-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a8c3a7-a863-4fee-6b72-08d931a9addd
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0465C831857BC48F2CEA9D67F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4oZMRJkXSMgc8Gpk8qgLmQdGKagVifzGEfvex+JvkAEbteKeHh2QWiJYN+/qlQlC6KmT1L01YTOHDhpbD//uEDYPpTvDAMUxg7DbnLIpjPTo1hXZOl+UmIUOD1IK5/xxWkAoDZgdXNduZ7zWzdy4+RTFoc+COTxJiZ8ccZdLvQupXidS3zBgm2lYzBk/aSRPikFOwjG9A+a6xO8UxM9dHmWCdh+bJu7Oro+/1eSteN49/QDhAiEUewfu9VAfZYJhLFtF7Zac69LYo7n0MVB56IUgFujfy0YrD2bOD8DlyWtV3T0zO1H3OB85IeFAvPpeAIpOMQlul339rTTsOa3Snx7zmJ5hVJe5pmNQB39bewi6R/8IRYxQEPZQpm/1e8i/9UqOxfLe5bbK547gSoq1Xyx8pn6av5YBSkofMOCA6CHeN8sjcJF1Ou76sYo6tSj/JPz9ufxT3TMDr+eyK+RJ3el1Xn0PX42WIM5hizpD/35175OyBR9gTOwQGCgNJ101QkCeHmx0xKlzGF7XoLkwjLQmZl+eHR+ITNTuKGA4oVW2xr1dSBkpVVvGyHTKNYJ2kQfUDZoR1sfR432UIaE6uPEUhntjcleVtFwK8VjQrzhD+oztn1VFwTSd8DSjsXcti+HNTU61uUZYADkx5SjDH2WV94VBzt+0OsJBBG7S5dDTdDCJTph6fcjXS5DucMklS+Zy2Y1eJwRLw/vkXlg9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oI3pn/220eeh+xTfS10EdZF5Q/AQor6P9Y/Y0wNI+4cewMf+78Ej1Qnbwm08?=
 =?us-ascii?Q?NaxRNz7SvyBhNsM6vHuMspcYojU118gcNwg1JW3NO58f4omlrRMYday6/Hy8?=
 =?us-ascii?Q?F4JFJsECIxnBv5sRLjQOCFfUaEuwkcctGLCzwKOdlFzVtrxdbzYIXGZTGrJd?=
 =?us-ascii?Q?r2t0KqJmW/48mWYWBUTPjzNVBOSBBXJJBjTq4r7zd8KAWhEvWNmwNEDz6Kur?=
 =?us-ascii?Q?GesrBrBjdvLFPnpBPly+lvhFhblXPirTlP01PIDJ6UbqQlrwW9QCHNZHsrny?=
 =?us-ascii?Q?+hqlyPL7YADaZEiqkjc8kN04G2PxG9mdOe4x2CW/KenFXBGYjM8bDc4wdx+X?=
 =?us-ascii?Q?z1EYvbiEerN3ZON65T1KBgnF/ETrFuPqaIEZ0sn0DfOhJhce4Vf+USFxFYla?=
 =?us-ascii?Q?kz2qC+f0XljEEjzm0IzImSVlkAw3H2JfEedArlgePLXxQNLjZ5Or4FTeebC1?=
 =?us-ascii?Q?1EdP4peIPe0lYUJadB3vqdXMGwwu6rcyTC9WU7jJ4DC30ews3kVBeIxssAi9?=
 =?us-ascii?Q?8imCWK2ap/k3+AUyXKHpF7XUhn7a4H9xbGZ2kaPELTKUV1TtfsTdRuKVZ0S8?=
 =?us-ascii?Q?1oD+d6DtHkc6b6TePpFeomzf0r2x4f+zhUcJ4Nygcc/2gkXzx1nWr9KMbWP8?=
 =?us-ascii?Q?NIUWwYGaxHI6Z8NNzMIAfGOV02JAYHwBm/uzLDVGUWsP+PQv+w2fyzxYXqEK?=
 =?us-ascii?Q?WLtorOIWdN549L8NU6q6Y3hmhMGzSdkTZQ4hL3p3Lucig3g9TaA34IQlqrVU?=
 =?us-ascii?Q?zTm5jh6m8j49yoeLo1z/DcX8nKvLh261BjxPPMO2FLpP2s5OFxKbUDJT8uFu?=
 =?us-ascii?Q?Vc/RRMqV899c84VfQ4qK41MQDIHeeDphj3Pr9haRK/MoYlK+uqXCLYzkWl1E?=
 =?us-ascii?Q?D2vdg+PfX7dp7RK/CT8tuAETkP3qp2yPxC9FEr/kIisoPbmUKKBpmL7nHMCa?=
 =?us-ascii?Q?iVru8PYmw3P9zaSf5KZloewDnAEoR5NJYgqRjwmqAFD/5AsCu3mtwKuLorUh?=
 =?us-ascii?Q?7NRjls7AhcoNqqw9L/C6zS68pQyJdaj/aNPuTQqAL6gguaLclj1hxMCa/2g5?=
 =?us-ascii?Q?g4HlLkyO8ZwQLensU4DmpgJ7gR/FBrP9Gx5pOXHtdqvOISi0JvaNOuU938et?=
 =?us-ascii?Q?aFWySVgnWn2EtNXnQvlTBrjC+Efhzx4G/4bf40PXRhKrILlNGCT7K52JJOeO?=
 =?us-ascii?Q?K+iqiQlddxIMVm7dclkYCdVsIt+t5T8AtRxKIg7CHH/T+g1wvemq+nP7wpoX?=
 =?us-ascii?Q?aU8jy9TzG8ekAWKXXAANKuvlBMwm1kUWQED21sFgNM+zucjkj5+XbcIfL9HL?=
 =?us-ascii?Q?I/26rIIusFJFRUKf1ZV9jXQn?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a8c3a7-a863-4fee-6b72-08d931a9addd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:08.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtvLQDgp7lSRhinfIQAVK2aaoqiUssZDYGYlg0WPLvpoCL3F7WKzX8Gmz66HqMu1B0CjudvJE4Cb7uDZVT/GLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/prot_mode.h | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/prot_mode.h

diff --git a/drivers/net/wireless/celeno/cl8k/prot_mode.h b/drivers/net/wir=
eless/celeno/cl8k/prot_mode.h
new file mode 100644
index 000000000000..177559edf62f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/prot_mode.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_PROT_MODE_H
+#define CL_PROT_MODE_H
+
+#include "hw.h"
+
+/**
+ * Protection mode (RTS/CTS) control
+ */
+
+enum cl_txl_prot_mode {
+       TXL_NO_PROT,
+       TXL_PROT_RTS,
+       TXL_PROT_CTS,
+       TXL_PROT_RTS_FW,
+       TXL_PROT_CTS_FW,
+
+       TXL_PROT_MAX,
+};
+
+void cl_prot_mode_init(struct cl_hw *cl_hw);
+void cl_prot_mode_disable(struct cl_hw *cl_hw);
+void cl_prot_mode_enable(struct cl_hw *cl_hw);
+void cl_prot_mode_restore_default(struct cl_hw *cl_hw);
+void cl_prot_mode_set(struct cl_hw *cl_hw, u8 prot_mode_new);
+u8 cl_prot_mode_get(struct cl_hw *cl_hw);
+
+#endif /* CL_PROT_MODE_H */
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

