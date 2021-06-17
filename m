Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93753AB8F0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhFQQLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:17 -0400
Received: from mail-he1eur02hn2203.outbound.protection.outlook.com ([52.100.9.203]:12679
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233731AbhFQQKI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULu+eTiadmI5I2rLB0b01pIL4yE1X8gkJNIWWjRGYPUWaCa9mPGEdJwPENwfCO/9wbdFVYLx7fmkdCtwxDQ9rKHKmQ/uDtsjoUDh8UVDQhlSvPGxr4VAZC4GQcURxzvDwrX8id67eV+O3yuQHrCOukcmC5ZSxw+S3tQlkN162q/oPiJXDS0OJQwWSrR+LoMJkmROalR7McKyxry5IKbioN1vapCGuCqvWhJupLlZ88CC12dMz0g4MLpOpyrmmYbvexEHeQNVE/VMb+vPmmiZz6b9XvIRvAFtpUgkgl1TyrheJny7z+qQ9geiCta2y5HVWyKmEkt3ZQsMBAcOv0dmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS7/QuK0GerwrgKnSPVurn1AWgNx0k/26BHgb2KnYWA=;
 b=DLjOZ0qljIfBdzg1ebrjj5D/xtqPanh9BVbfMTv3jT7NgevFAa5ZbGziz8k+GX9WFoLiS6CnyWfLWsbao3q1or3W9hNC7OL1qt8madYl8bNovAf4Wp4VDVahabZRSrPrJ6pl0rM8DWjg/MIYPPR3qhmQzeGOSn3b49TIAGs2Z+l8QQH9+Ig5FAsYOuAtNRTVaJOUthsENqH4oajvc+3VDnjeOKnT5d685Vdniep+ccO1S0rxXu7dGr0eUjuSTXw1djSS+DY95HDz7vMXDJDkxC6YizXaBK5wpxYKV1Fm66tvbb8zVSL44AJapAiIYs1scZsSfWuS+toXTCMEaaC6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS7/QuK0GerwrgKnSPVurn1AWgNx0k/26BHgb2KnYWA=;
 b=TKCxCq9xkm8NAkhNITAlE2iKii5jW+2KRJ6Kp4n7vR8VBPPMK2ZkCTUu7ZWL3BVmveHk4FWa42oZBuDtCMhaIq2irjFWDHxyxkI9G5P9UuIppAqDkSsHIDR42xO4yk2KNXyOC0Hg6cvY/AEJQ4Npdndwh9WoutTbgX28EbxnXMY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:58 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:58 +0000
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
Subject: [RFC v1 232/256] cl8k: add vendor_cmd.h
Date:   Thu, 17 Jun 2021 16:01:59 +0000
Message-Id: <20210617160223.160998-233-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38eb6453-98a3-4758-0824-08d931a9ec1b
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB051554192B9BC68867F6979EF60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tRs90N4Nvo6ZQrCI01Z4lSmq9y4SYF3OTKnAX73unYqsco5aRgd0B+wDo9zp?=
 =?us-ascii?Q?fW7lNTDgFFSS7K7uXiU/rgwDqhAwIIc0guyQEBbMgw7nW6QWuy8awhCO6dAY?=
 =?us-ascii?Q?q0OIYR5om83Udhy+D4Pp7Qra0ZoPaMqCzGqTNry4TaeyIuTP7SIHu74wxbij?=
 =?us-ascii?Q?cNy2ZjkzXrMGcYXsGTy4lfUNr1i29BXqBKbvuKSDuflK1hEhlKZBGUA4vIK9?=
 =?us-ascii?Q?PTXgoYcGbj1LipIk6H6pvo1LgFBW5a8z2z0AiqluRDqmfiszR+MwWCDAnwQb?=
 =?us-ascii?Q?LSOa0wXpCrJWplSr/luXetgHfSfqu2Ch9Dq/Nc4Dg1xvrNc3vwqQQihKgl9n?=
 =?us-ascii?Q?rzzeDbud8Bl1ruhNo+hLImd9Tq4d9OBvpE6Oy1/XTHp6t7fsuD+QOCHkusWa?=
 =?us-ascii?Q?ywufxsyL+nGjXOQoXzfy7EBrB37tMzVqert1tuLIej1mXtywkQGnknuMlouD?=
 =?us-ascii?Q?yKWOmI/XJTDnFLzpSGCPvXQy+DwwNKs4Qq3tqW6OYHeK5sKvP+YBJIAExyDH?=
 =?us-ascii?Q?4XH6GzlYjHP14V/yp7EQTXYkAPqoB94QSJO2vLWRAJkq2V0Vmr64jMK1JO/9?=
 =?us-ascii?Q?j+snD60r2TjXO8Xf2TJYbESX97VHDszzQKYQXRpmH4pR83Em6xEc/4K/6ZPy?=
 =?us-ascii?Q?GTHv2WXNCZ/gOrgEkTrzPZBAp8ESrpH7yOALuUsQnE79G8wRJSvlQvY/YkWO?=
 =?us-ascii?Q?MTT1ythGajELUlTvHeQwfyDHKeflqAWwn8KlMvFDoGkZeoT/doebfzRPKpQo?=
 =?us-ascii?Q?7S042KKXYqJenxi13SFjBsflFzUTG3qUQwCa6wsr7wm1SufKQc2UpEWFzRCv?=
 =?us-ascii?Q?17uWOQwJUbBLc+Uyup7y+zuNO0ycwCIb4ZPAAz5yZbpPzDrGYZjHNxQidHoN?=
 =?us-ascii?Q?S/FznXD2kjFfJ9TkBfk5anMm7JoVpLetLt6N1yDfhbq/DqksoI9ORPk4zLfg?=
 =?us-ascii?Q?FRV8HB7UeLHcjTVgAN64KBPHYTq4U+wZ6lQALC2F8b/QPLSpPlY2c7XAsdeD?=
 =?us-ascii?Q?Iifwer9ia1sHR3oMhVUxv2r9w2a2RLASjlzs62ydRWnjw4+3vk31cIIyh/gN?=
 =?us-ascii?Q?ElHIfH+BkMOuep55J+IHg7CGxQoCjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(26005)(54906003)(66476007)(107886003)(66556008)(966005)(140170200002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ix/0VX9PVeyjHFZ29ZL8Df0VcabdV+65IBXOSrHgmp/kuoVxWvQPQQ7Rq1A?=
 =?us-ascii?Q?ZS2rMQhCNFs6nPuxBxpfO86JpE+A4ZmRlvlo2gA+qLoAXML6fzyZzYqZ1NoR?=
 =?us-ascii?Q?eRpzgDoxHBPdvNXDlcIlw0L8DfADxC9kTbJAna6rkggsi47Gqf1x0PiXik9E?=
 =?us-ascii?Q?i9LQLxZsMKGQCLQdm07C6CjeKAIQweGbngjV5rlgg2Ckm4Zb7DKSHh9SW1Vn?=
 =?us-ascii?Q?xYirKIL6k5XID3rAyZOD4wtfbhP97sxxOmbEaDcLNt+ceastfIeJrTG9CFSB?=
 =?us-ascii?Q?4HpmVZQDlBZAl/2W24cSGQD5a1VirHUWrP3PadB2t5B89us8ol71dL3nkJyN?=
 =?us-ascii?Q?5QnVRHWWDrbnwi5qJ4IU0Vioj7qcgWOBgFllvZROQYdLcnYKbw1Yzu97aEPs?=
 =?us-ascii?Q?tDJF0Ury3U2sk+E5A70GLsa9PADUBXQ2upe/0aR39e8JsENt0PXA1hYduL9H?=
 =?us-ascii?Q?S2Nn6giUjIvqLBATYkimXi2uOCDmx1mhL6ZBjARY24L6wCB7vxcHPNoOadsR?=
 =?us-ascii?Q?nVf0frNmdXUzEaT6KlbO+1G6V6nPoE1YVRcP0p1IY/bZLkb0n6vjwD8lp5OZ?=
 =?us-ascii?Q?0vbVfkQDFgzB1LZWocFNxtAr06QL7VfVrL2x+gkDRo6EPFIp2Lw5eH+Uv5do?=
 =?us-ascii?Q?EYL+wPZYvYmGXyuDLFy6AVbmh1yOBOMAKKH44YMcRzcLN4dqJ8tUBkAvyE14?=
 =?us-ascii?Q?Gb1vzIlb2hSlVbZlN6V8w5eWWmUalCXdGdEVlWP7pvJNl+6cEHw8KTkqiTHM?=
 =?us-ascii?Q?a7bfUCN25AFfNvXM2T3pscrgDgVN0PfxZGnuYoIjRfFg07fEU9liTq/Nv/bH?=
 =?us-ascii?Q?5+LkuSlnb9geKLG0R/GoUleXDJZis6D5Hang9a0y9tc66LlgQN3gDHQMeu6z?=
 =?us-ascii?Q?oh4mVf/TV6/i8nSIodGimXuiPP+KKtDDqv4XP/rX4lVfZeriVAcmncwM2V+x?=
 =?us-ascii?Q?xP8yuqv4oG7wA+Hp82iL8NQ7bbBIL/TEag0dvrn7l2Pm/K9SEbBqUKVPQ8bJ?=
 =?us-ascii?Q?z7+k1XsZPY/jL7B1bLWTix+ad7mKcx2gsvN7cr21PVMdLGWR/3Fci1KXSoAi?=
 =?us-ascii?Q?+dHTGchH14u6iZkNL1UZWpV9i1sTvw0zESsU9j1kb+dK0rMoXmlGoIPYukQ9?=
 =?us-ascii?Q?TuLC7QjOQkd3vOUDbFTB/QRF1o6igOlBH5k9SpTBuiuq8Jtz8zESL22HP3Jp?=
 =?us-ascii?Q?cOPLGB9sEj/qwkQkPQZ08Uvsrwx7o5DHWTKAd7PTMtiFV7JVBL2TIbjcQEp+?=
 =?us-ascii?Q?lfgFJcCiY2G1F6LdRlSJzRJFyov0e0hlanoo/QINML4k8ftffClUIShTw197?=
 =?us-ascii?Q?0X+3czGievEOnQLrblOf/fVG?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eb6453-98a3-4758-0824-08d931a9ec1b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:53.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRaEPyVMc87z2x5PmB7IfQmcBg53+lpcxuZZvJ/ljRuxapeGrhrVvxsLGlkBmsbgiRWpdUNuUqofn0P/2FDLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vendor_cmd.h | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vendor_cmd.h

diff --git a/drivers/net/wireless/celeno/cl8k/vendor_cmd.h b/drivers/net/wi=
reless/celeno/cl8k/vendor_cmd.h
new file mode 100644
index 000000000000..9c7c3fe571be
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vendor_cmd.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_VENDOR_CMD_H
+#define CL_VENDOR_CMD_H
+
+/*
+ * DOC: Vendor commands
+ *
+ * A driver supporting vendor commands must register them as an array
+ * in struct wiphy, with handlers for each one, each command has an
+ * OUI and sub command ID to identify it.
+ *
+ * Note that this feature should not be (ab)used to implement protocol
+ * features that could openly be shared across drivers. In particular,
+ * it must never be required to use vendor commands to implement any
+ * "normal" functionality that higher-level userspace like connection
+ * managers etc. need.
+ */
+
+#include "def.h"
+#include "e2p.h"
+
+#define VENDOR_CMD_TIMER_PERIOD_MS 5000
+
+/* Celeno OUI - see http://www.my-ip.club/oui-info/00-1C-51 */
+#define CELENO_OUI 0x001c51
+
+struct cl_hw;
+
+enum cl_vndr_cmds {
+       CL_VNDR_CMDS_UNSPEC,
+       CL_VNDR_CMDS_CECLI,
+       CL_VNDR_CMDS_E2P,
+       CL_VNDR_CMDS_ATE,
+       CL_VNDR_CMDS_HELP,
+       CL_VNDR_CMDS_LAST
+};
+
+enum cl_vndr_events {
+       CL_VENDOR_EVENT_ASYNC,
+
+       CL_VENDOR_EVENT_LAST
+};
+
+/* Enum cl_vndr_nlattrs - nl80211 message attributes */
+enum cl_vndr_nlattrs {
+       CL_VENDOR_ATTR_UNSPEC,
+       CL_VENDOR_ATTR_REPLY,
+       CL_VENDOR_ATTR_DATA,
+       CL_VENDOR_ATTR_LEN,
+
+       NUM_CL_VENDOR_ATTR,
+       MAX_CL_VENDOR_ATTR =3D NUM_CL_VENDOR_ATTR - 1
+};
+
+struct point {
+       u8 chan;
+       u8 phy;
+       u8 idx;
+       u16 addr;
+       struct eeprom_phy_calib calib;
+} __packed;
+
+#define CLI_MAX_PARAMS 32
+
+enum {
+       E2P_MODE_BIN,
+       E2P_MODE_EEPROM,
+
+       E2P_MODE_MAX
+};
+
+struct wiphy;
+void cl_vendor_cmds_init(struct wiphy *wiphy);
+
+/* Note: data structures used by kernel and by userspace */
+struct ate_stats {
+       u32 tx_bw20;
+       u32 tx_bw40;
+       u32 tx_bw80;
+       u32 tx_bw160;
+       u32 rx_bw20;
+       u32 rx_bw40;
+       u32 rx_bw80;
+       u32 rx_bw160;
+       u32 fcs_err;
+       u32 phy_err;
+       u32 delimiter_err;
+       u32 rx_success;
+       s8 rssi0;
+       s8 rssi1;
+       s8 rssi2;
+       s8 rssi3;
+       s8 rssi4;
+       s8 rssi5;
+};
+
+struct cli_params {
+       u32 num_params;
+       char option;
+       s32 params[CLI_MAX_PARAMS];
+};
+
+#define MSG_SIZE 4095
+
+struct cl_msg_data {
+       char more_data;
+       char data[MSG_SIZE];
+} __attribute__((__packed__));
+
+int cl_vendor_reply(struct cl_hw *cl_hw, void *data, u16 len);
+void cl_vendor_timer_init(struct cl_hw *cl_hw);
+void cl_vendor_timer_close(struct cl_hw *cl_hw);
+
+#endif /* CL_VENDOR_CMD_H */
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

