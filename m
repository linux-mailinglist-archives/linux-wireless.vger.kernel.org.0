Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE99F3AB83D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhFQQF6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:58 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231726AbhFQQFu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkYVmAWwdjHchwLx9zWJKXREahP2QfWkaUltvpZNo4B3ASHa8eAeD7HJRmlrx3EIOLPViIboKGtoFUZRvVbbC8706iJBgnF5waTL/LF93J+skOoJWpvCn66IrScfcmhv885Nbc+wylaLH25khG5rXbFVQQHX9Jmdl6UBjeuD8J3EyxjSDNFAfsaa0chzM7AOCZx+BOqILI1mK+QjNpiB1HNDACwr4JpRlZlBNw0jZonlbJfKcbxbmRtWZt1Q4f+MM3Tz3xbiel+btMG/lItzNvl/4dr0ttSms6DyaX7gVc5H9zSyscgOFKOXAWGoeRmedo5wc1If19Cbuobom1Wgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgAfUqD9ZOtTiZ9LDMyvS4w82hpKXAJHSsnsxevXwLE=;
 b=dtf42fpkkEdsjP83JATNHJA1C72EK9L+F+bdCHS7o7HkEQbzDKjCli3RbRMQwRjNKn0IG1RrJBNzQ8XVrxmIVzbZBoa5x0msH08pa90JqnwftVhImg/H4VyKywKTpZKhpADO1/Fj41TR2byG1gXXg6nu7QBLdJMCKZgvJVxSRc1e6RrjsrTZ4JdFlVWkXVy9dU3oPjQXVTytPICTNwUpnROUDhetCdhnkS2qNCQFY8QLkbMxBg2pFGYu7TNui2ButgdYGrF5mcgSzvpJoSDCu1NijsTH0XWr4nBJAPM2gPEUIkQablQTlNZ63LDtV3yIKTsZJUu7Hoi+6iuQ3024nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgAfUqD9ZOtTiZ9LDMyvS4w82hpKXAJHSsnsxevXwLE=;
 b=ByNwkoXpg5iA3uxsTR9OiuIDEl0GN5vtmwM0SH+lULoaUT/HpVu7IxbLxSDS3G8DZm31CwcQuv33/Hm8ABiSobqnFEvTOVB6J24VVdk7m7jCT9HWJQvM95OQU4NxIHsUdvi6/6Kg1wCMzPfLYeydITR97tRZgFX/ersmE7YJEjE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:39 +0000
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
Subject: [RFC v1 035/256] cl8k: add cecli.h
Date:   Thu, 17 Jun 2021 15:58:42 +0000
Message-Id: <20210617160223.160998-36-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a652ed22-9916-4d7a-0358-08d931a968f3
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB123459EA442E3FF7ADA4B3B4F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5v9CXDsjHnxKQb0Q+V6HUJ74h4uSKXzy8lv26obS6boGfNdqYpwgS93+SUKK3YLwaeP8RlnME0WddbrFOuxvNkKCi1cx5WJc8htfITPVHdTjzSFnpUGHMY+rsP8q3nS87c/v1yiTtcgd0xXKURSB0h8XjJzj3Wxie9/4fHfxv4gACj2eSUOExJ9sYKEXqWIxVWCF9q5TAzIigTJkAuZBJ1slghYnZ46YcmEbclQK/tLe+uvzQxOrIHs1HCy92vo7GPDxjJuyEeLJbPWRG8beZTJ6+uy8KVeVVWb6dAgqZ2gudTlAub4uPvWJVK8Pu9gxgR1c/LFBTHO//A+acONGEAQpGqGVP/m41ReMRg7MEDV7hzaS69SH3JNU/dbWetueFs2W2zqBrcSQlxAthgUWpUD3BOfjbyq+4t5fcRvxSuNwLNZ4YcdotKSWiqs/0+WPqURid3i4oGjHpHi9b7uE3Ks24cwUey6F1SY+Byb4lRpxT2LCXMFRi7ash9347Nyn2+hLi9JqfYErDoIsWDu/Dh2V6B33tY8QFn0m43fhu3iRj4p3NbTZGEIcDftyF8eaihiLGyXhFqgfrxS/dgzYph6WZbfc2pnkfr3ptT59+QAxgY2WL+mDVeAKSDtdopZe7znGorCcOubCRPRpCIsL6D5Kry7/KyPBpi95/NyrfHzbAy9+ZmX37kD88dwlHmqRm+Xsnpskurjzg3xxqSC1fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+EZUkXSdK0d/BwhGblAgMMShGnjW1+bvdaOWf1tpF1efQR+c7jei5YZrZAf?=
 =?us-ascii?Q?mG0nivbSLws91Ac0vF0jwuDKTfmzkF20vqVNFonPZ9YjoZnL9OWUUw/4L9Bi?=
 =?us-ascii?Q?p9nuLKyRG6XYVSUYc154G9iECJs5a/2bZUX6J1lJau7huCxeD34a8F0OAIBd?=
 =?us-ascii?Q?E5HCG+VkTvs9zlOswnNW0gpmO+135nlhdTTc2FdrWIJoS0Q2ccfzKixdZjn1?=
 =?us-ascii?Q?X3/N/kib+2GegOq+hKSICOhm+m6KOImPMCIiPHLIulGxMDhWsdcf9kNwZvDB?=
 =?us-ascii?Q?2Lq1tgySoOueMdyo3C3PKyOThBap8ygZymhOPN7bs97cIOwDm1//f7dap/xK?=
 =?us-ascii?Q?VELGEtBE8ECVgzvEtEDkRWGls6Du8HXGw/2eGvJwfMA8jqJx/PSJgNAa4zcL?=
 =?us-ascii?Q?ANH8+bd0wmG4DfgPkldbVtEBwXNs/jHe99aBVjxTPZwJvBjSpZdVrYtfgoxA?=
 =?us-ascii?Q?YeccqSKLpG4lQo1FEEd/ZgCfmtN9EKikZq24MBSwiSKEqeILrcN1N1xYUgyk?=
 =?us-ascii?Q?NGIVe0aQH0FfF62b1UbjWZ/vfg6mA4mgrotKXD3sk4YXqKI82g3llUjGdVPo?=
 =?us-ascii?Q?XjHVTfFWnZbG27VMreLdVyf2mAfQIlbYuTy7jZxocwg9xNAMUkW+i33rtZ8z?=
 =?us-ascii?Q?xN6yot4cKnibs4xmvBtoCL+0v6dzIUHASrZTCMOmGDLdGEujfgWxS8T1Xf3O?=
 =?us-ascii?Q?/xS3ttIicHEZ8cZffqEcB1vxRF6NGJaTdm0jRkiXxPnMMjRIzJRJ5+G3v9fu?=
 =?us-ascii?Q?c5StIuADHMfO+2sNY8WaCJQ3B7mHGOYyrulBTdnMLny/wlrR5rhVAK+8Z7hz?=
 =?us-ascii?Q?s6UGfuWhznrNjzgArMFP0vD7pEfigDGHZ7USjr/fG0UgCEJFK2q+DH2if1cM?=
 =?us-ascii?Q?aiJTf/NEPsuyI65laeTEdIfuxjYusSueopaF5tQqbDBVVx4Hw9pBkACQE9N4?=
 =?us-ascii?Q?AmrEi6Yxw8JJLJ9qC3OUJxWok2htFbbZQBV7HDFGGT9Jtv7KKIb9Y/b779I2?=
 =?us-ascii?Q?ON+uvZPA2KbVLS6RXUNSclgJlATo1WPXECbTfH9wTaoZaWWYgcMBG0Fh8rZZ?=
 =?us-ascii?Q?Oh+8PKqPAoaUKlUId2Cuk5NtzC3e7lILQe9x6Hlg8rUYDEAKYXWR0+wf466m?=
 =?us-ascii?Q?Y3Ipu+fYTODtq+WqEPfTRvKCGYAlje3oQ+L/bfx6QGiSp1yIlSFH6nxSZORJ?=
 =?us-ascii?Q?gElphirBj0Ad+mP1jaE76ODdtoosi51XloRaMlUw4fNjaM96/h72Mj5ge/xU?=
 =?us-ascii?Q?/S/BTc+uhd2zK6mEDXTMA7bdn74ghlzGERYKd5t8n6NhSmw5Qqy8IWUB7maX?=
 =?us-ascii?Q?tLvjunOaTLurlqG3dw8qm3SN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a652ed22-9916-4d7a-0358-08d931a968f3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:13.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z72z//KULYgV+om2J7z99X92NDt/dCbwApj+Ae+UL/Bbv6ys3VYKDqfTB3En/bsJzyVfmhQRT1IWun+P395mHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cecli.h | 112 +++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cecli.h

diff --git a/drivers/net/wireless/celeno/cl8k/cecli.h b/drivers/net/wireles=
s/celeno/cl8k/cecli.h
new file mode 100644
index 000000000000..3260ca56e563
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cecli.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CECLI_H
+#define CL_CECLI_H
+
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+#include <linux/version.h>
+
+/**
+ * DOC: Cecli - command line interface wrapper
+ *
+ * Allows to control the driver behavior and inspect statistics, utilizes
+ * vendor specific commands and events from the nl80211 layer.
+ */
+
+int cl_cecli_acs(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_agc_params(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len);
+int cl_cecli_bf(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_cecli_bss_color(struct wiphy *wiphy, struct wireless_dev *wdev,
+                      const void *data, int data_len);
+int cl_cecli_calib(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_cca(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_chip(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len);
+int cl_cecli_config(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len);
+int cl_cecli_debug(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_dfs(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_edca(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len);
+int cl_cecli_fw(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_cecli_motion(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len);
+int cl_cecli_noise(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_omi(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_qos(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_radio(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_reg(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_sounding(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len);
+int cl_cecli_stats(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_cecli_tcv(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_temp(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len);
+int cl_cecli_traffic(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len);
+int cl_cecli_twt(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_txq(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_version(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len);
+int cl_cecli_vns(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_wrs(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_cecli_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len);
+
+enum cl_cecli_cmd {
+       CL_CECLI_AGC_PARAMS,
+       CL_CECLI_BF,
+       CL_CECLI_CALIB,
+       CL_CECLI_CCA,
+       CL_CECLI_CHIP,
+       CL_CECLI_CONFIG,
+       CL_CECLI_DEBUG,
+       CL_CECLI_DFS,
+       CL_CECLI_EDCA,
+       CL_CECLI_FW,
+       CL_CECLI_MORE_DATA,
+       CL_CECLI_MOTION,
+       CL_CECLI_NOISE,
+       CL_CECLI_OMI,
+       CL_CECLI_POWER,
+       CL_CECLI_QOS,
+       CL_CECLI_RADIO,
+       CL_CECLI_REG,
+       CL_CECLI_SOUNDING,
+       CL_CECLI_STATS,
+       CL_CECLI_TCV,
+       CL_CECLI_TEMP,
+       CL_CECLI_TRAFFIC,
+       CL_CECLI_TWT,
+       CL_CECLI_TXQ,
+       CL_CECLI_VERSION,
+       CL_CECLI_VNS,
+       CL_CECLI_WRS,
+
+       CL_CECLI_MAX
+};
+
+#endif /* CL_CECLI_H */
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

