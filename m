Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E63AB8A6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhFQQJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:39 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:64480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233693AbhFQQIR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvxMR8gno+NjHnZyWRvEkY1LfUM28PiXa5vyuQmH59wyryqOCaHBtSer6w3X0mYKmE77+gl8gVHZwAamaDWfi2xVxqPwLt3I42fXjSe+KJ1SsCdaiMsRm801SGDiUXaex2Hp8d2yNnoc+JhXVVkLAzPzgehx9hV2kjL+yuxbHul3UAIlk8lfqECfiF8XBHKcCuw9MmswkDJsLgQcymMcsJAqbyl3aJeP23Mnw2ba9+T3AdV7jt+JRn41EEowa4z3Ydlkne8ADFk4gn8MfG95ObhX6X0LWLigahSYYfPZcE22k5LBlMQNR1GyvJFm4s6djHOfzvLO9VnE7ZuLuxsjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLyCqNwjjtwWE+MCOtIKts16DbZ/1faEJES+NF8QPHw=;
 b=CJrDFCxI/Bo3VRvpYeTc3K2tg0QkZSt415awQPW8aVKOMdeAe4h9uVtcbfeVzs1b7VRMpUURI8Ov0U7IS/EyD3paIEFyBvmkKpY0b8jaDtaYKrM9vi3HRsFJnxbK1+rcKYt1zkPh1UBWMhX64NS3TN86FcbS1z99xAVbYQTLvH4E4D6XA47hcZYnSKgr5U2+7mqcNtSCE1gcjMxPUsaIDuCYobiuzHcBGUsdEG+f5fv5dyXph7JdKTRFYSeoTBbPR5m2D+vDT5IaacqEZXd/ufql6L56tK6rQVpGC3wsZarJQTZ/eg6cZYWmq10Ws9bFfHWY+hLIs6V64/oTzVDimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLyCqNwjjtwWE+MCOtIKts16DbZ/1faEJES+NF8QPHw=;
 b=wN2ftwuwlXjyCgduoIsukhNkuY+h4YT1obSY/lZrmSDPU9283Y6gIHZfpuh7ccWNSYOF5RYRqJMpUrpAZLtktYOmzMQXj7rxx/8PUtql5TMJ+g0Qgca+dpFjLh0mLzuMlZhnHu4n/W/xkoADwWwS1neJwBS8uKrcxA5Bb46Bew8=
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
Subject: [RFC v1 117/256] cl8k: add netlink.c
Date:   Thu, 17 Jun 2021 16:00:04 +0000
Message-Id: <20210617160223.160998-118-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a81f10-205d-4f5d-8867-08d931a99ede
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04028AE621FAE68F05C6B537F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DiNXSbxUV5EySboW2fT7K84OsM0C2i6WBOFcyRfeVFr4d3wHr/Evv0/Z9n+FSUd9APIHkNu/OJIx8eMYfk1mO2wlz3r7cxGEEUgMn2QWpZL8vXSxjoSYZL24DJDAM15xmc1P1agXpJxswb4EDI262tk8fIShsbCtgqy5bMweoW+NB2NRqzvIr2KSJL6C+JyT4cqubSnlaeF9ku60gFxW3YBlZnlOoJeJ4Wc4ZgIgGbl8hn3C6SBKJIZUFq8q8u9ipHe0dX4skiI3laK6w4adC2i5NRxoPW0HPqhFgOZhsIZ4JsR351mk6ZVjduVBj8D+EtrupXkFB7/61y0XJSjE94aF+XGbDgIoGaq/25Eb1cIBKERDYIPKlaOhYruTGJgSfB2UY/c7fEsH5uDRMrP3U6wHSQcFrWOLwaT/PpOawG+SpHwO8WZVLJtbUnaXEflCxgE0Nd34xRUPox+MbjG+JYP/1pL/F5hSlu03iZjcIZb5oVqtMTDDYb8MtV6zXqn4avqK+HGS3zUTlHj4qbD0x7ht2ZsmaqEsNvJKYs94NHpEcXy8qKPMfbnHPNNYB/CGSv055soi0w/ItZqL4KIbDVIinrpKJkdGSHRDHWXMIxZFiNDgbvMUTzIINxcGi06DgA2y1A/utzz3GXuOjVhLVnHkO/3mvPvK74Q8OfBI2lvkylrSjkSVsiNPau/RNGGcWeVynRbIecqf96zLH370Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyfaJYKHDZRyYr7RVD98pZyq1KGREQRe6f+Hv9pVrcVnv2nq2M4qjN7Kp20v?=
 =?us-ascii?Q?ZsKoQD2jliuA3lwG+yxqPx/+dTS0dNgMtzZSU2/O+qV7w5KdUXzdvVs9UCPq?=
 =?us-ascii?Q?cj7I46NoaBrMhLuwjxNHV/L5FY7duGOyyMNUXPbB8HxY9F1i/lJMKlLETVAn?=
 =?us-ascii?Q?cgKkI72nOQzf/GkYDLVgKj3tIOiniPEWnNMdKPS6As0TOtkElDm3B/kK88N5?=
 =?us-ascii?Q?xU4b3uP8qWFB/Fsy7C+t8ygww3loiIwcPHylKyyW8UbKZkAjx560WZ82YMRU?=
 =?us-ascii?Q?bTd9XnubZ8FSACKFTeDw+z8EHRAGs8HetD677PxkBEzQ5ok7WX/AjaD9RKD4?=
 =?us-ascii?Q?xnGwxzK75FOVyD7bO8JNY/E3Z4sFTVsvy9ngwFEXvp3bIHLA9hgSoIH2STnM?=
 =?us-ascii?Q?I6s+Cc1C+USp5cxS0eAN3uZ1qUNtTLbEIJF4mBhRnSZOppyWfimbpoZ/kxw+?=
 =?us-ascii?Q?Ve/AmdtRgyomp58b3FNX8XvaxJEUQV38LJp7yQG6FSGqURb+SmzlhCO65LWT?=
 =?us-ascii?Q?2BSfBZMTEwBARu+lIPJ1GwIE4tt0uPQ0but+z5/Nr0CeqR2EeQ9FhXFARRz+?=
 =?us-ascii?Q?UDuqsBFTHWAmcjek41sxMYMfB1uP/+B58d0TrSyenUCJF5iyUN5PsIpqrBef?=
 =?us-ascii?Q?C8sJJ8xOwRKh/Y0RaQOLItRL1+exd+Y1YMuLkx+7oZKIsS+beXiR3wd1kquf?=
 =?us-ascii?Q?Jboj3tWRyn5g5zS7QR5Vmdh/ie4BzghVqkYXfkklrqEjOjSo3RtLpUVnf4Y/?=
 =?us-ascii?Q?3gS2/jDmwQ6I7pUDwv+CITSokSKcnfEcuoESkpyUo2sQOG6XDtswrr3G5IFF?=
 =?us-ascii?Q?kPY4Ex6HKMOMOGKbb8vfTLFVer83O3bIJHkzcvcRP/kDQNmvUe+RVNZe48LQ?=
 =?us-ascii?Q?6PzyLNxpzIqP0CwCmqiQOlTO2FeLwpzKFuI2MxMFQUJKI6tSUtcuS2BzYNhb?=
 =?us-ascii?Q?vkDC03yz9Om1oEpvL4fxA8ouj3Y+n6FC7UybEqR/rRpr/lk1cmXomk+myxCi?=
 =?us-ascii?Q?4qcqBlR3z3ubxNhf54U+YsIqX0zdlP8GWOxYRYfEyiwToSJ23+QINiSqZySa?=
 =?us-ascii?Q?0l4DgopMK0QIpiyyiukdQfelQz5nw1LeMvQUixli8pPzhmksukPnNUY8kpkz?=
 =?us-ascii?Q?fhYBgAH89KORp/z5P+3XrZGnaRkd1KBYud20BO0TSJyaDGx0qANIOUFLLsW+?=
 =?us-ascii?Q?Hc0bhXRyXfUvW14ZWfcO4e63P9/4xq5gEd/7FcYlWSniE5oKN7W5+Qlc6hB/?=
 =?us-ascii?Q?LLX6N34btXpSizWtM7a9AObpoHTlpfe2HGnxAtuPyjPUDo/FSu20L3PYaMKo?=
 =?us-ascii?Q?IuP9Vsk4+fh67HIL0IO/Yctt?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a81f10-205d-4f5d-8867-08d931a99ede
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:43.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oefHAztGFUzH1kXC1pojK3/eYU658wV6V3ZcyHxUiRSjF8E2BME4r9jLAV8Rs1h//ssaHbqc+sL9rFZLzRBVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/netlink.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/netlink.c

diff --git a/drivers/net/wireless/celeno/cl8k/netlink.c b/drivers/net/wirel=
ess/celeno/cl8k/netlink.c
new file mode 100644
index 000000000000..cc03575704ad
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/netlink.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/socket.h>
+#include <linux/rtnetlink.h>
+#include <net/cfg80211.h>
+
+#include "netlink.h"
+
+void cl_netlink_send_async(struct cl_hw *cl_hw, struct cl_nl_event *event)
+{
+       struct sk_buff *skb =3D NULL;
+       int msg_len;
+
+       msg_len =3D sizeof(*event);
+       skb =3D cfg80211_vendor_event_alloc(cl_hw->hw->wiphy, NULL, msg_len=
,
+                                         CL_VENDOR_EVENT_ASYNC, GFP_ATOMIC=
);
+       if (!skb) {
+               cl_dbg_err(cl_hw, "vendor_event_alloc(len:%u) failed\n", ms=
g_len);
+               return;
+       }
+
+       if (nla_put(skb, CL_VENDOR_ATTR_DATA, msg_len, event)) {
+               kfree_skb(skb);
+               return;
+       }
+
+       cfg80211_vendor_event(skb, GFP_ATOMIC);
+}
+
+void cl_netlink_send_event_co_locate_update(struct cl_hw *cl_hw)
+{
+       struct cl_nl_event event =3D {0};
+
+       event.tcv_idx =3D cl_hw->idx;
+       event.event_id =3D CL_NL_EVENT_ID_CO_LOCATE_UPDATE;
+
+       cl_netlink_send_async(cl_hw, &event);
+}
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

