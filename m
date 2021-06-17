Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4953AB92D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhFQQNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:15 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:25569
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232281AbhFQQL7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBbzDRqhX/XMgOq9+faZoZgm7ZPnyzW1GOYXNlzykP+g5DuBYWptUYXbdk9wGP7rbh7rWYpXOEEkO9/uIEEKCnfvY1OgQ9czd+ip0BVzaUVBsy2CoqBXVSsZMaIsXY1RWlqlrEYp4L8BuZhUgO3L+8S0m8HJRPA2Ch7jHqB54yjfwiXOgnkcVot4ese9bOe/0TZoahPbHUw67RmLwUgD0+fZ9jL/GPNlMy++WMEeCsEIvtXBhSREoCHW98hBIzHVaKoeYXb75Atkhuq8/IS2YIHNC2ZvU9Lccu4S7zPLbTUWwBIX+YFw8QpwD4uJYKkqB/qNH3LBhasYVWejFOLMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NWNTt/igRJOGuAtNuHSM033NB+Q4h9wgUa4jCP9XZM=;
 b=nyaxGEoH49QSeRaJuUFxrgQ2mrqu5HaUKenr1PF6bSna3PEAYn3g3J5/YpJlWouHgXScrxZDg/iJZYhEFdVejiSu/LhIImWK5YqUvMD31fDOQOLjW7vInW36WReWr/mp7SU466p9kG160YoT9GMWH+7PcBuMt0ldC17fO3bV/q/5J7xCQu6NyvkoZWFxzk8c5q7AWp0YYfnsKhKXnf7mjZrjWiELUVUaVCbf8BjbuI+oq6DPBn4/MlDU1eRKDPsvzx1rpWGiMB2yIUyX8yAJ2FJptMWXhzHoqKNVrN2Fru53WJFGabHR54L9iPbnixgi3XdFuK2RRLBZWUhJLUPuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NWNTt/igRJOGuAtNuHSM033NB+Q4h9wgUa4jCP9XZM=;
 b=0PTy3d5wod9x29M6zbA8c9iHnsIZ5RtTIINIMWS0K6GyOHVKctStFEt6jSuP+cdreIM7kbktnq26sF+Gv8iSgwVDHuTTs/G4VJ8mnk073Eo74ZISCrRLvklC4bQyVL0glCpNZfaV2ejiA3LRrizxEvUdRjcDiMPaNjwRialCMjU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:17 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:17 +0000
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
Subject: [RFC v1 204/256] cl8k: add tx/baw.c
Date:   Thu, 17 Jun 2021 16:01:31 +0000
Message-Id: <20210617160223.160998-205-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c0309c-908a-4c08-db9e-08d931a9d886
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075D041ABEE82FE02218F4DF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toqKNEbelIWfeKcVDFp18LSwfcpQCu32IwCS6/hCV6p+dirHhkvoHck9cp1RFFt1MRpj2vkuQcJOq7zibjiWDQ1UBwU9v0VyXdiISLUrR0b9ObJu0gKv2pdzRy+ONnncYQg1CZ3LrL00DudTB4mIIWY5NGDJs8ZuiOEOANdQr2+osqw2rycJm4QDD6BjpnG7HTNsX+YkWnieqZVzD5n0WTRvxcODQwa8TTumMCJEMjEr1h/Hetcn4AHxPZhogO0j45i6Wm++TCSrAteBQNdFPMB+ONjDDLthpd4230VsyVJQirUOgzNo1pr/ePo58ySWaNVL+zwPypJ1m7E8y2jLAwm1p9fwZHt1XO4dr1lh38cwKUo6gRcemvFNdSrhM/DRvLP3QGT8gE5IgUwLURD8kGUJZBBzWJhBtm5ch4zeg7HpXVyuQPhLaG/2Yy10CaZTQIaJuM7MEFzAuIOVmrEHWdv77FrMkRTNGeb8AYBGwwfTlGsLjzTDNcHE00qi37hxfIVOrdca+QdtfxTcc0Dgi0cSCbqOy6e9U/8J15zdvaEAR8kcEmmY1EY7QQZ4dvbxAJ7WfgIHdfiXzm7/AMZ+SHYSS9QZqWlX3pVpot9XwCJ1mmh8MYqnpfQVapMB8PXfcpc2X2cRtrqmquP+bH5l83R8MHZ5/cg5bwK+klhFm7dTFHsu95B9uQnCDNHrncBkcrrCSKHCmGr6y3ZGPxg1Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vBgokjE2vlMopiLp5t+A+Izg+65wIP0iCd/R+Z9lIBME+KtZZoLd5Q+34Gs?=
 =?us-ascii?Q?iby2kJ5qt7vxUIDu5z3epCr8td3UzrAIDEsFFktxSiaM2NDc7l1DprCvB7d8?=
 =?us-ascii?Q?vMLCpOnF01zL8MuifgV1WhBcv+VPLiC9OlxLcW+BLCAeC1LesYDOjZBfJcGU?=
 =?us-ascii?Q?6lo5w8GMLF3gY9V34lLiKNzz7gjIE04SR2yQfays7sAOtERKK6TN8PlGmSfQ?=
 =?us-ascii?Q?aDFLbXBndWzIvGR7/n1AseOh8FMXXc1a+xdVaSETt7PAeAPAdCkXW1byfIi5?=
 =?us-ascii?Q?aPM3qUReX+0n+AAdQsJrFMCxjlrG5QE+YTK6TeDumP0csNbEmYeYZejSUH8P?=
 =?us-ascii?Q?fTjo1MB0+ok3yKTC3wTfbjqBTO8+tB8M1FS34MIdP7+jU1MO5Z6n4RNEqf50?=
 =?us-ascii?Q?YQDfkbzAKkB52BlYUS8I8VV1rQAK6i320tJfvOuS3snHfwanXnGiyxRfLXrT?=
 =?us-ascii?Q?E/5/1UpZm/ne7PPOY1ld9sIDNFcmBKLyHoSFRqSeZu6IvjCJUDm5lHDzQwb2?=
 =?us-ascii?Q?MG7SnZwrP10CptCW2AC4cOHuBu5nIx5js0yrZtwHLfaHBAE+V3SiYmvn+l65?=
 =?us-ascii?Q?Sri9l+6ShYaL8R5wH/bzu9vm/+yOdb1xSZARQfOHtl+oYpJTkyfiSftpjF66?=
 =?us-ascii?Q?bOwcsB6BndRLinpamFDCtkQq26tWh0fV7c2YgHSwga1kDpldTZupYgDjCaTM?=
 =?us-ascii?Q?upGn2EGdVUDY/MVyQdf8iJb8hl0W7A64bt94AxWqZg10Lk1KpOqxereEhHXz?=
 =?us-ascii?Q?D0frn8Ij5mYD8s0/MikrLZNw4BDJKy+golCqO6iE6eUUlBF14pWMRBXNdOFJ?=
 =?us-ascii?Q?p9Sky1gbNPlZMCf1dn1xN7Y9AApeg6rUR76wfuSDHT6Lg5sLZVMdTbA3ASAn?=
 =?us-ascii?Q?HPmRpVsLEoqbZAAGhjlKqO80lta+oC1Ojd9y63D8H9M9wKgzZtkIEh4NuN+x?=
 =?us-ascii?Q?K/a/9PBisaMq4xNsAA5eG0EU4SLAaKG2KnmDZ7QaIKZdOns/RPS+aVeZ5FnX?=
 =?us-ascii?Q?wlFJCx4orXeM03Ds4k6V8OkTQuEiyJ9KVRlp/yEKIi+tiSgqJtOg2bCR0raD?=
 =?us-ascii?Q?iyT7daLBqfAWjXeuBok5+G8CoWlBSdimdcbJagOf3m0VR/elSRTfY8/QGwAS?=
 =?us-ascii?Q?KtB0Vk+YLBD6kMKQcCYdkLaq57tICTQQuga7B6ucyK0dOmpm0d5AcVjbpmDV?=
 =?us-ascii?Q?NoZd1mspn//jp9MBxgTKwY97+a/i/RLOn58o4QVL0rJ9ALJl9w4qJ9BFOc7U?=
 =?us-ascii?Q?W3sexM3BZXrhQeLQW3Vq2uA2lMRvZjr3LBfPb4XPam0KpRdk2UAxN0/edGYz?=
 =?us-ascii?Q?Y1Ngp47x45G5Gz7inFBAr+6j?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c0309c-908a-4c08-db9e-08d931a9d886
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:20.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VU+J6SNlYQ3tI7q7HLzNomXo/3mqjUQq7a9xb/BknzU3Epr5M2qAG9IcCYLVCtFWEvqSMPnK54+qjaBderOmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/baw.c | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/baw.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/baw.c b/drivers/net/wirele=
ss/celeno/cl8k/tx/baw.c
new file mode 100644
index 000000000000..d6c11db6c1e9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/baw.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/baw.h"
+#include "tx/tx.h"
+
+void cl_baw_init(struct cl_sta *cl_sta)
+{
+       u8 tid;
+
+       for (tid =3D 0; tid < IEEE80211_NUM_TIDS; tid++)
+               __skb_queue_head_init(&cl_sta->baws[tid].pending);
+}
+
+void cl_baw_start(struct cl_baw *baw, u16 ssn)
+{
+       baw->ssn =3D ssn;
+       baw->action_start =3D true;
+}
+
+void cl_baw_operational(struct cl_hw *cl_hw, struct cl_baw *baw,
+                       u8 fw_agg_idx, bool amsdu_supported)
+{
+       baw->fw_agg_idx =3D fw_agg_idx;
+       baw->tid_seq =3D IEEE80211_SN_TO_SEQ(baw->ssn);
+       baw->action_start =3D false;
+       baw->amsdu =3D (cl_hw->txamsdu_en && amsdu_supported);
+}
+
+void cl_baw_stop(struct cl_baw *baw)
+{
+       baw->action_start =3D false;
+}
+
+void cl_baw_tx_inject(struct cl_hw *cl_hw,
+                     struct cl_baw *baw,
+                     u8 fw_agg_idx)
+{
+       baw->ssn =3D 0;
+       baw->fw_agg_idx =3D fw_agg_idx;
+       baw->tid_seq =3D IEEE80211_SN_TO_SEQ(0);
+       baw->amsdu =3D cl_hw->txamsdu_en;
+}
+
+void cl_baw_pending_to_agg(struct cl_hw *cl_hw,
+                          struct cl_sta *cl_sta,
+                          u8 tid)
+{
+       struct cl_baw *baw =3D &cl_sta->baws[tid];
+       struct sk_buff *skb;
+
+       while (!skb_queue_empty(&baw->pending)) {
+               skb =3D __skb_dequeue(&baw->pending);
+               cl_tx_fast_agg(cl_hw, cl_sta, skb, false);
+       }
+}
+
+void cl_baw_pending_to_single(struct cl_hw *cl_hw,
+                             struct cl_sta *cl_sta,
+                             struct cl_baw *baw)
+{
+       struct sk_buff *skb;
+
+       while (!skb_queue_empty(&baw->pending)) {
+               skb =3D __skb_dequeue(&baw->pending);
+               cl_tx_fast_single(cl_hw, cl_sta, skb, false);
+       }
+}
+
+void cl_baw_pending_purge(struct cl_baw *baw)
+{
+       if (!skb_queue_empty(&baw->pending))
+               __skb_queue_purge(&baw->pending);
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

