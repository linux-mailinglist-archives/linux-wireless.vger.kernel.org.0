Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42A43AB907
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhFQQMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:03 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:13120
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232861AbhFQQKq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy4vLUthMDAFbnc4n1QBDl1Ll9D3wmGa/8WQbKPOtcVnooMMgBcuD1/x4j/nu4XZpuaBbdKjBhXJI2Jc7LIPsj4TYgGWpD3LpQW4bZmR6gJZTbzTAvkm/VlH97UhSBxElX+BlEr6bi0BMBb2bzFIGj+L0xtOXIOOGxHg6Zoiwk7ZMDtNT8Al0MSe5ivZg8eau62zoJs5AN2QFHLQPj8aA0/yhTGQPtS3anGkxXQlLkP36xkh9Xqv0DRxilhWsbU8QlXHCdHw1o17bYG9XZUNd3EoRtpTZpBvHB6biWi/uKB/2Z2cSNcJ7RmeAJC9j8qfTpOTb0kSLQ61x/1XJqd6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXZ9BiixqLezMieBNK9BC+oIhvaY2O2Hz7HGR/H/5ho=;
 b=lVJx+Tw8Lb0OCbKgO6QDO+lLYkBxzb34MOUemxrtHYEgwdXXT6npLoVh3AMaMotZSiBlJGo/UDAoZ+/hNiFb8+66k3s6+WZwTslazuHzI1W7RITpE7KeeWdMv0QKKrwLvjmuqrrKCMaqxO7aBN2qpmLBbwuYLU4DHm3lpxxMBTo3Y0m9TkZhKn7z5pTcQXo9Q+5eIrSsNiJMXDNetpR+iOqHEJ7DJDKm482k2zHFxxUhFLk5viYB6TWCYCLKsdzWLkv9Nn8zSM6PKuFV31dlOgqjAHp+gsRpw7KJpCxXypmkyo4t0OV8AlczGyoxRWULHowzo+btC/2N/yWpBw0PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXZ9BiixqLezMieBNK9BC+oIhvaY2O2Hz7HGR/H/5ho=;
 b=RKGp37y1yeZAJg5QaooIgxR7XlI+OVJx4aEIsnbi5mD08xWW+shZ2Bb/X7Aiyw14dJY3V2wwxegDDxc2QzSI3AMArLYP+Rs/pNJzRZOgU2F+F96gd9cvLDfyAynzQgoWf1Rgvy7MSiM3CJReQt/4L4+ieeBGdszHvOwsQLcXDcM=
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
Subject: [RFC v1 231/256] cl8k: add vendor_cmd.c
Date:   Thu, 17 Jun 2021 16:01:58 +0000
Message-Id: <20210617160223.160998-232-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc26ba52-4fdf-4480-baee-08d931a9eb7c
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0515B9B835A9E7507A9EDABFF60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKabLO0F+bJuN4n9dM6aHQvPjSBthBiSRq6iaGgrFfyDLHi9eXe9tmB+K8+kOK5KSqwYEQ4uG3aalC3FzYKtahf1MrUiBds+4N4ktAuT9AhJW2kAFOJ81ggi1yKJHtgGiCD9VXEtdoZVpoE9aAcqFpueSmDuz9nELD626CLp+exwjgh5zOKzsspt68iBmjcjWlxAbf3eQjVkFkVUVZE6unVH2vnwLnCS/xdDwdZx2JBi2cSlafZHPzsJYS6gg5RCa81sEGrokeUa28acW4+X/RlYGCknmNYhvF+ewxPQXRtpU+wOY2jFdTwLNj40yB25GLtvu7uZfKXgpdIgTxuYeWSVLVfDxbBY18CnL9DFjEwCsq7kWYnBt9aIZpv4lSbR5hP/FCOT2B7O6uzoUq153HAna1+OKFm2SqxSotp7nJXTAJARvh6EX6Mh/L78U6LWiNEiREAJMsJuouiXv2TJ1bYO2s4m82QBE6rxZjjtmz/l37ZK10k1SmwqY/sTcdw0pOBDfhk4SS5aiR0+r6s2FGPJHYMO3iEZOyKVo71rd1TwMYXs7lqTerQvdmz5n8xeDhi3iVUkIAwyY5apRSe4ppB+KrOAkKMnYvj5sb2GgQyxMMW3SNq1Jn4TKKgXb9wPvGT2ry7WhFrRjmJpAOqAM/JHz8i1/P6LRAVhk7Gw+wc+HRApCRYHnJg/z0Agq+uroVnjnZMRV/nOj/1ESavHwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(30864003)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0tdOkZNcRVg62lXHLAD6jK35648/YXXuePlFLBkVtF53deimfu3eNsrW/Mg?=
 =?us-ascii?Q?RHe5zDbMaALSjdZBVQTnB9iXSAb84IFfQ9UiP7CvZwaH/pKZQ/El+iIyojiy?=
 =?us-ascii?Q?uj+v3kMwPSlbGztFgRjuuCr1cC0NV+mDIcUVf71gv6G+sDV2+eBviS62WrKH?=
 =?us-ascii?Q?zcqEvPPkOP+jn3A374HqwTMiU7YscdE8nfnXrz8EAtVFNyn2LwRzXil19EZY?=
 =?us-ascii?Q?2a3JoEGMAJWMrI9SgN/xa87Vqro+WheeOCp32SvQh/VYWACqBz6Y2YvJdkZc?=
 =?us-ascii?Q?Yy4mGlQnhTBpoTJQV0OEUfBHTfLAdDKj19v2SkKkyjnWi5/sanrSQKMNvpWI?=
 =?us-ascii?Q?hL3p7xvVT9I1J+s51WEAbmKDK2q1XJhzr5IuJCm8C1s0/FjSJS3yyyxLhosL?=
 =?us-ascii?Q?/oMbMRNzd8fhxurI7sxIc2+MbwOQyolnTkQSw8zXP8kZEoA2fIsbu8zLjiXK?=
 =?us-ascii?Q?9r7TurBdnpv/XwdFCxneQ2j5WJPHjBRtzytis79NXDW34C/F0P3p88V8Kbqv?=
 =?us-ascii?Q?XCjuOMbA8icMRmeeRYrL7RL2eWzOPg+tmvsWwrK4+bSvRNuGquSc4Z0JtZ7S?=
 =?us-ascii?Q?QIpnQp2LkTpMklGx6UeGxaVXp0zB1Q4GW3r3FefprDKXMfO4mVvA+QjjzsM/?=
 =?us-ascii?Q?kW6JhJI4w+eeqQMCOm6N3RiYCiq0jkBjIMwjwReMbwg5hz+kaz37HhHqYZmg?=
 =?us-ascii?Q?lRZAetxPyW7mkaJoXqffCYJllAEZQcpf0oGQ1BLSR+sI9FgBMSJDoJEZaoQw?=
 =?us-ascii?Q?r7K64WdJO2fjuc6X2LhE4sPLNwFsoeCEYLyNjfQVSw8pmvHwpdumPi0Dpu3s?=
 =?us-ascii?Q?ByLZlzslCvKfh9pmdrkDprNt29bP0t+NsPHgK7GUSLuMBwMjrdlMAqc2l2IC?=
 =?us-ascii?Q?xzRU+m4UeGm8Ua/O99MuM5rriT83DcMtDgg86aZ1EHV+Dr9n410ys/ddyqNc?=
 =?us-ascii?Q?kyY0QNS4TphA1TZzSGH84MrTbUPHHO++IuGKfDcQSPzbh975+HJBx5Hz/yS6?=
 =?us-ascii?Q?utoYT03knosLd6JbyHgZTIMDChXe+5nHmfiZfw86ekpbGYuW8Ecg87O6mogx?=
 =?us-ascii?Q?hDDhIs8mCJQSV9TrDwylCeTzehp7JpFT4pMPtLSF86x7VGRwMJfmAAW/M0Hc?=
 =?us-ascii?Q?le1zhZayESdlkjF4AUCMcu6PMUXqxap+AuoDhvazgxins714rqt1HGLT25KL?=
 =?us-ascii?Q?YFP/BREGUhfjuqrah2ZnFgNkRssconyEqdZLIolhmIYgwUqxj/I7Hbesr/As?=
 =?us-ascii?Q?zURwfACfqe51EYWRZK10fDH2Y7juu8SAnNS8ZaqIfpfTy7jeWiLrmv/3ZOrU?=
 =?us-ascii?Q?VdqhSPXh1T0hKfGbagSkEW9o?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc26ba52-4fdf-4480-baee-08d931a9eb7c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:52.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwBFkps6PjM0JChPIvSSXlGiUodx1TPVVCPdbsCgPHrMzg8ZyShBC4yR/mpl6o02lSsKFgvn7ReKrNrbwR1q4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vendor_cmd.c | 377 ++++++++++++++++++
 1 file changed, 377 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vendor_cmd.c

diff --git a/drivers/net/wireless/celeno/cl8k/vendor_cmd.c b/drivers/net/wi=
reless/celeno/cl8k/vendor_cmd.c
new file mode 100644
index 000000000000..812eebe72956
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vendor_cmd.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+#include <linux/version.h>
+#include "vendor_cmd.h"
+#include "calib.h"
+#include "e2p.h"
+#include "ate.h"
+#include "cecli.h"
+#include "utils/utils.h"
+
+static int vendor_reply(struct wiphy *wiphy, void *data, u16 len)
+{
+       /* Utility function to send reply message */
+       struct sk_buff *msg =3D cfg80211_vendor_cmd_alloc_reply_skb(wiphy, =
len);
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cl_msg_data *msg_data =3D (struct cl_msg_data *)data;
+
+       if (!msg)
+               return -ENOMEM;
+
+       if (data) {
+               if (nla_put(msg, CL_VENDOR_ATTR_REPLY, len, (void *)msg_dat=
a) < 0) {
+                       kfree_skb(msg);
+                       return -ENOBUFS;
+               }
+       }
+
+       /* Start timer if we waiting for more msg's from userspace */
+       if (msg_data->more_data)
+               cl_timer_enable(&cl_hw->vendor_timer);
+
+       return cfg80211_vendor_cmd_reply(msg);
+}
+
+static int _cl_vendor_reply(struct cl_hw *cl_hw, void *data, u16 len, bool=
 process_data)
+{
+       struct cl_vendor_msg *vendor_msg =3D &cl_hw->vendor_msg;
+       struct cl_msg_data *msg_data =3D NULL;
+       int ret =3D 0;
+       u16 curr_size;
+
+       if (!data || len =3D=3D 0)
+               return -EIO;
+
+       msg_data =3D kzalloc(sizeof(*msg_data), GFP_KERNEL);
+       if (!msg_data)
+               return -ENOMEM;
+
+       /* Messages 2..N */
+       if (process_data) {
+               curr_size =3D vendor_msg->len - vendor_msg->offset;
+               if (curr_size <=3D MSG_SIZE) {
+                       vendor_msg->in_process =3D false;
+               } else {
+                       curr_size =3D MSG_SIZE;
+                       msg_data->more_data =3D 1;
+               }
+
+               memcpy(msg_data->data, vendor_msg->buf + vendor_msg->offset=
, curr_size);
+               vendor_msg->offset +=3D curr_size;
+               ret =3D vendor_reply(cl_hw->hw->wiphy, (void *)msg_data, si=
zeof(*msg_data));
+
+               /* Last msg */
+               if (!vendor_msg->in_process)
+                       memset(vendor_msg, 0, sizeof(*vendor_msg));
+
+               goto out;
+       }
+
+       /* Single message */
+       if (len < MSG_SIZE) {
+               memcpy(msg_data->data, data, len);
+               ret =3D vendor_reply(cl_hw->hw->wiphy, (void *)msg_data, si=
zeof(*msg_data));
+               goto out;
+       } else if (vendor_msg->in_process) {
+               goto out;
+       }
+
+       /* First message */
+       msg_data->more_data =3D 1;
+
+       /* Allocate buffer in driver */
+       vendor_msg->buf =3D data;
+
+       vendor_msg->in_process =3D true;
+       vendor_msg->len =3D len;
+
+       memcpy(msg_data->data, data, MSG_SIZE);
+       vendor_msg->offset +=3D MSG_SIZE;
+       ret =3D vendor_reply(cl_hw->hw->wiphy, (void *)msg_data, sizeof(*ms=
g_data));
+
+out:
+       kfree(msg_data);
+       return ret;
+}
+
+static int cl_vendor_cecli_handler(struct wiphy *wiphy,
+                                  struct wireless_dev *wdev,
+                                  const void *data, int len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u8 cecli_cmd_id =3D *(u8 *)data;
+       void *real_data =3D (u8 *)(data + 1);
+
+       len--;
+
+       cl_timer_disable_sync(&cl_hw->vendor_timer);
+       if (cl_hw->vendor_msg.in_process &&
+           cecli_cmd_id =3D=3D CL_CECLI_MORE_DATA)
+               return _cl_vendor_reply(cl_hw, real_data, len, true);
+
+       switch (cecli_cmd_id) {
+       case CL_CECLI_AGC_PARAMS:
+               return cl_cecli_agc_params(wiphy, wdev, real_data, len);
+       case CL_CECLI_BF:
+               return cl_cecli_bf(wiphy, wdev, real_data, len);
+       case CL_CECLI_CALIB:
+               return cl_cecli_calib(wiphy, wdev, real_data, len);
+       case CL_CECLI_CCA:
+               return cl_cecli_cca(wiphy, wdev, real_data, len);
+       case CL_CECLI_CHIP:
+               return cl_cecli_chip(wiphy, wdev, real_data, len);
+       case CL_CECLI_CONFIG:
+               return cl_cecli_config(wiphy, wdev, real_data, len);
+       case CL_CECLI_DEBUG:
+               return cl_cecli_debug(wiphy, wdev, real_data, len);
+       case CL_CECLI_DFS:
+               return cl_cecli_dfs(wiphy, wdev, real_data, len);
+       case CL_CECLI_EDCA:
+               return cl_cecli_edca(wiphy, wdev, real_data, len);
+       case CL_CECLI_FW:
+               return cl_cecli_fw(wiphy, wdev, real_data, len);
+       case CL_CECLI_MOTION:
+               return cl_cecli_motion(wiphy, wdev, real_data, len);
+       case CL_CECLI_NOISE:
+               return cl_cecli_noise(wiphy, wdev, real_data, len);
+       case CL_CECLI_OMI:
+               return cl_cecli_omi(wiphy, wdev, real_data, len);
+       case CL_CECLI_POWER:
+               return cl_cecli_power(wiphy, wdev, real_data, len);
+       case CL_CECLI_QOS:
+               return cl_cecli_qos(wiphy, wdev, real_data, len);
+       case CL_CECLI_RADIO:
+               return cl_cecli_radio(wiphy, wdev, real_data, len);
+       case CL_CECLI_REG:
+               return cl_cecli_reg(wiphy, wdev, real_data, len);
+       case CL_CECLI_SOUNDING:
+               return cl_cecli_sounding(wiphy, wdev, real_data, len);
+       case CL_CECLI_STATS:
+               return cl_cecli_stats(wiphy, wdev, real_data, len);
+       case CL_CECLI_TCV:
+               return cl_cecli_tcv(wiphy, wdev, real_data, len);
+       case CL_CECLI_TEMP:
+               return cl_cecli_temp(wiphy, wdev, real_data, len);
+       case CL_CECLI_TRAFFIC:
+               return cl_cecli_traffic(wiphy, wdev, real_data, len);
+       case CL_CECLI_TWT:
+               return cl_cecli_twt(wiphy, wdev, real_data, len);
+       case CL_CECLI_TXQ:
+               return cl_cecli_txq(wiphy, wdev, real_data, len);
+       case CL_CECLI_VERSION:
+               return cl_cecli_version(wiphy, wdev, real_data, len);
+       case CL_CECLI_VNS:
+               return cl_cecli_vns(wiphy, wdev, real_data, len);
+       case CL_CECLI_WRS:
+               return cl_cecli_wrs(wiphy, wdev, real_data, len);
+       default:
+               return cl_cecli_help(wiphy, wdev, real_data, len);
+       }
+
+       return 0;
+}
+
+static int cl_vendor_e2p_handler(struct wiphy *wiphy,
+                                struct wireless_dev *wdev,
+                                const void *data, int len)
+{
+       u8 e2p_cmd_id =3D *(u8 *)data;
+       void *real_data =3D (u8 *)(data + 1);
+
+       len--;
+
+       switch (e2p_cmd_id) {
+       case CL_E2P_GET_ADDR:
+       case CL_E2P_GET_MAC:
+       case CL_E2P_GET_SERIAL_NUMBER:
+       case CL_E2P_GET_PWR_TABLE_ID:
+       case CL_E2P_GET_FREQ_OFFSET:
+       case CL_E2P_GET_WIRING_ID:
+       case CL_E2P_GET_FEM_LUT:
+       case CL_E2P_GET_PLATFORM_ID:
+       case CL_E2P_GET_HEXDUMP:
+       case CL_E2P_GET_TABLE:
+               return cl_e2p_get_addr(wiphy, wdev, real_data, len);
+       case CL_E2P_GET_CALIB:
+               return cl_calib_get(wiphy, wdev, real_data, len);
+       case CL_E2P_SET_ADDR:
+       case CL_E2P_SET_MAC:
+       case CL_E2P_SET_SERIAL_NUMBER:
+       case CL_E2P_SET_PWR_TABLE_ID:
+       case CL_E2P_SET_FREQ_OFFSET:
+       case CL_E2P_SET_FEM_LUT:
+       case CL_E2P_SET_PLATFORM_ID:
+               return cl_e2p_set_addr(wiphy, wdev, real_data, len);
+       case CL_E2P_SET_WIRING_ID:
+               return cl_e2p_set_wiring_id(wiphy, wdev, real_data, len);
+       case CL_E2P_SET_CALIB:
+               return cl_calib_set(wiphy, wdev, real_data, len);
+       default:
+               return cl_e2p_help(wiphy, wdev, real_data, len);
+       }
+
+       return 0;
+}
+
+static int cl_vendor_ate_handler(struct wiphy *wiphy,
+                                struct wireless_dev *wdev,
+                                const void *data, int len)
+{
+       u8 ate_cmd_id =3D *(u8 *)data;
+       void *real_data =3D (u8 *)(data + 1);
+
+       len--;
+
+       switch (ate_cmd_id) {
+       case CL_ATE_RESET:
+               return cl_ate_reset(wiphy, wdev, real_data, len);
+       case CL_ATE_MODE:
+               return cl_ate_mode(wiphy, wdev, real_data, len);
+       case CL_ATE_BW:
+               return cl_ate_bw(wiphy, wdev, real_data, len);
+       case CL_ATE_MCS:
+               return cl_ate_mcs(wiphy, wdev, real_data, len);
+       case CL_ATE_NSS:
+               return cl_ate_nss(wiphy, wdev, real_data, len);
+       case CL_ATE_GI:
+               return cl_ate_gi(wiphy, wdev, real_data, len);
+       case CL_ATE_LTF:
+               return cl_ate_ltf(wiphy, wdev, real_data, len);
+       case CL_ATE_LDPC:
+               return cl_ate_ldpc(wiphy, wdev, real_data, len);
+       case CL_ATE_CHANNEL:
+               return cl_ate_channel(wiphy, wdev, real_data, len);
+       case CL_ATE_ANT:
+               return cl_ate_ant(wiphy, wdev, real_data, len);
+       case CL_ATE_MULTI_ANT:
+               return cl_ate_multi_ant(wiphy, wdev, real_data, len);
+       case CL_ATE_PACKET_LEN:
+               return cl_ate_packet_len(wiphy, wdev, real_data, len);
+       case CL_ATE_VECTOR_RESET:
+               return cl_ate_vector_reset(wiphy, wdev, real_data, len);
+       case CL_ATE_VECTOR:
+               return cl_ate_vector(wiphy, wdev, real_data, len);
+       case CL_ATE_FREQ_OFFSET:
+               return cl_ate_freq_offset(wiphy, wdev, real_data, len);
+       case CL_ATE_STAT_RESET:
+               return cl_ate_stat_reset(wiphy, wdev, real_data, len);
+       case CL_ATE_STAT:
+               return cl_ate_stat(wiphy, wdev, real_data, len);
+       case CL_ATE_POWER:
+               return cl_ate_power(wiphy, wdev, real_data, len);
+       case CL_ATE_POWER_OFFSET:
+               return cl_ate_power_offset(wiphy, wdev, real_data, len);
+       case CL_ATE_TX_START:
+               return cl_ate_tx_start(wiphy, wdev, real_data, len);
+       case CL_ATE_TX_CONTINUOUS:
+               return cl_ate_tx_continuous(wiphy, wdev, real_data, len);
+       case CL_ATE_STOP:
+               return cl_ate_stop(wiphy, wdev, real_data, len);
+       default:
+               return cl_ate_help(wiphy, wdev, real_data, len);
+       }
+
+       return 0;
+}
+
+static int cl_vendor_help_handler(struct wiphy *wiphy,
+                                 struct wireless_dev *wdev,
+                                 const void *data, int len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       char ret_buf[] =3D {
+               "usage:\n"
+               "cecli - Celeno driver related\n"
+               "e2p   - Celeno eeprom related\n"
+               "ATE   - Celeno production related\n"
+       };
+
+       return cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+}
+
+static void cl_vendor_handle_timeout(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_vendor_msg *vendor_msg =3D &cl_hw->vendor_msg;
+
+       memset(vendor_msg, 0, sizeof(*vendor_msg));
+       pr_warn("cl_vendor timer expired!\n");
+}
+
+int cl_vendor_reply(struct cl_hw *cl_hw, void *data, u16 len)
+{
+       return _cl_vendor_reply(cl_hw, data, len, false);
+}
+
+void cl_vendor_timer_init(struct cl_hw *cl_hw)
+{
+       /* Init vendor_cmd timer */
+       cl_timer_init(&cl_hw->vendor_timer, cl_vendor_handle_timeout,
+                     (unsigned long)cl_hw, VENDOR_CMD_TIMER_PERIOD_MS, fal=
se);
+}
+
+void cl_vendor_timer_close(struct cl_hw *cl_hw)
+{
+       cl_timer_disable_sync(&cl_hw->vendor_timer);
+}
+
+/* Vendor specific commands */
+const struct wiphy_vendor_command cl_vendor_cmds[] =3D {
+       {
+               .info.vendor_id =3D CELENO_OUI,
+               .info.subcmd =3D CL_VNDR_CMDS_CECLI,
+               .flags =3D WIPHY_VENDOR_CMD_NEED_WDEV |
+                       WIPHY_VENDOR_CMD_NEED_RUNNING |
+                       WIPHY_VENDOR_CMD_NEED_NETDEV,
+               .policy =3D VENDOR_CMD_RAW_DATA,
+               .doit =3D cl_vendor_cecli_handler
+       },
+       {
+               .info.vendor_id =3D CELENO_OUI,
+               .info.subcmd =3D CL_VNDR_CMDS_E2P,
+               .flags =3D WIPHY_VENDOR_CMD_NEED_WDEV |
+                       WIPHY_VENDOR_CMD_NEED_RUNNING |
+                       WIPHY_VENDOR_CMD_NEED_NETDEV,
+               .policy =3D VENDOR_CMD_RAW_DATA,
+               .doit =3D cl_vendor_e2p_handler
+       },
+       {
+               .info.vendor_id =3D CELENO_OUI,
+               .info.subcmd =3D CL_VNDR_CMDS_ATE,
+               .flags =3D WIPHY_VENDOR_CMD_NEED_WDEV |
+                       WIPHY_VENDOR_CMD_NEED_RUNNING |
+                       WIPHY_VENDOR_CMD_NEED_NETDEV,
+               .policy =3D VENDOR_CMD_RAW_DATA,
+               .doit =3D cl_vendor_ate_handler
+       },
+       {
+               .info.vendor_id =3D CELENO_OUI,
+               .info.subcmd =3D CL_VNDR_CMDS_HELP,
+               .flags =3D WIPHY_VENDOR_CMD_NEED_WDEV |
+                       WIPHY_VENDOR_CMD_NEED_RUNNING |
+                       WIPHY_VENDOR_CMD_NEED_NETDEV,
+               .policy =3D VENDOR_CMD_RAW_DATA,
+               .doit =3D cl_vendor_help_handler
+       },
+};
+
+/* Vendor specific events */
+const struct nl80211_vendor_cmd_info cl_vendor_events[] =3D {
+       {
+               .vendor_id =3D CELENO_OUI,
+               .subcmd =3D CL_VENDOR_EVENT_ASYNC,
+       }
+};
+
+void cl_vendor_cmds_init(struct wiphy *wiphy)
+{
+       /* Set celeno vendor commands used by nl80211 */
+       wiphy->vendor_commands =3D cl_vendor_cmds;
+       wiphy->n_vendor_commands =3D ARRAY_SIZE(cl_vendor_cmds);
+       wiphy->vendor_events =3D cl_vendor_events;
+       wiphy->n_vendor_events =3D ARRAY_SIZE(cl_vendor_events);
+}
+
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

