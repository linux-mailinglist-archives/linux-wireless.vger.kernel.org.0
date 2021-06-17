Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC773AB8CF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFQQKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:44 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:64930
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233819AbhFQQJs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMu+cTVRku/H2hUwGQXV/6n06cZD2hz1tInl5SBbU05JPTcdGjg1gjw/PMZfUS3AOUlm0ueWtTtGqjWn+Hg/7U0dcwhwKB3+kbddpTnyfAW1MjeKQkkYW1txKKzaCRmL5yKZNVGksptzfy4qMm+aFWLL+Bgi5PzfdGdSx4xiWmT+LQVs47ZBcT1OLRlr6Zf8xaiHzh9X9Dy1Wp0Ajw8BpQHzKb+rTitDxZILFEqNuCX2DP2TtqL3mHm4w/YOvLKsOQiN/eoCbBFFbCqKRMnoBNglsVV37nIvUgvTPOFtq2BoY1ri56ulvzV1FRlczfse+id1j8W6dL6FEhBSJIISTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJcCw9+T4a0a03XVzIyVIsNfv/DEhVzPSNaMoxMSL8=;
 b=PoiNhjNnuuc4kFLvHhKTU9DuxhT7e5E02yNV5o7VGRSJxMZa9NZNuYCGw39p6CDtyqFsmi1J0QAU8zK2dI7qap+LkEmD6FxA3H8ZLQCqMrHo2YTX+qxINRLUA2nsfU4lLAkDDTAlHQo7Bc7Gz73LJ+TsjYbR0J914XdAdPCOrSSaPqKoafaOX/DywLcBQp7FVfeFQ1P4lWIm2FPPUOkDno0fIORzqfsZg4tXIdrO6qMNq5WqyOsZjJke/i88y7N/Z2AdmT4CN+hKLht5JmLCGgEBnyjoX4qgeKnRI2W0w/2FiOJaeb4ywLTkNwQuXAp37r/80on6OyDipOe4DFa8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJcCw9+T4a0a03XVzIyVIsNfv/DEhVzPSNaMoxMSL8=;
 b=wS8ils0QwI8OOohkmTnqF2LUrzDx0spsuLfY7ygaJfgLFbmv6S+G80m1bNgBvMBjQ53LKlV0MqNMIQJCC1Ur+4M9ogvHtS3oBR+w+EIar2GIteq07w2h5rnIOOBf7ADpjbtNxthbWxJqN/e8sKuh8ZXrc+z1Darmor5iv5SHLqE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0981.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:06:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:36 +0000
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
Subject: [RFC v1 177/256] cl8k: add rx/rx_filter.h
Date:   Thu, 17 Jun 2021 16:01:04 +0000
Message-Id: <20210617160223.160998-178-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53c0cea6-ed1a-4531-3ef2-08d931a9c614
X-MS-TrafficTypeDiagnostic: AM9P192MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0981E398CC2ABBCD50D2BD87F60E9@AM9P192MB0981.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UBnQFfrtdqSau0UwWKWVrw0mOQja8N3HrZc6a4iEe5udBIYMRogu4R2e420ZVhae7xlamnCzcWdB5mgfGKPXlSCPGE2DVVW5AwvJ6U8sKZMod6aE38CGd2I2Wo2LxNlvE7Mx4+NkQSNJaigEjf1aA4TCYXKtRkGWAGa/H4snT/5KoTMhoPogFhbhSmRR1zZQhjvCwvzsApKEezJ7vl74TD+/5L3FuXUdviRXTidB7AZvMUbqbvUmXngkD9NCiaJbbnTDyb+VCxtOa1OoSR7QhcYpkMFtNI+d3+bGREgCnvXI2mNYdYvd3Ps29ZP5PWr2qT8JrMZ52o3IPdDoGd3dYzg8CK9lkSbnT0aJksa7kjBaZdR12LLniZezZLBoHYSRhWZeIvWLHMH1s38Hz6rbLFOe4Rd07THULZYOlQaMaV+Wz1VHDZ83MWl5Dk77NdpmQlc7jGHV6RgedA77VQNPLOFw5T3TyVEqD798Y9DX5O30WaWTfy6UAgKP+ksNqWRLy6qHXOBCnVvhBa0mz4RRDitzUEr0BJbNeOKR0JpLRpr3yrXvvitVFEhqNHYyh2kWYJ19WnjM/0bN753k6AjpVBvCW1q5BhFM1W38/O0jwGKnpJPcaJWZDackVTKCslNDmwMi5oLEZWXwTT+e81C5/kCUTkOILxkSvi/+w6WG2oYm7Y83QCHopzXTYFLiWgTADa6O9V1Dg9QYOUFFFIJNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(86362001)(5660300002)(9686003)(54906003)(107886003)(6666004)(1076003)(2906002)(478600001)(6512007)(26005)(2616005)(38350700002)(16526019)(55236004)(38100700002)(6506007)(4326008)(8676002)(66946007)(186003)(66476007)(66556008)(956004)(83380400001)(6916009)(8936002)(36756003)(52116002)(6486002)(316002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0HMM4fXxoVGblFZiMLFfluVIUCaOnefMVUyxrPjxWwzx90M90OLddgd7mRN?=
 =?us-ascii?Q?RM3Md8s+97b1koPRFOsqPWcJ0K2L7OyPkPXC+4eWAd3o50G5CWlj2KWAkBWs?=
 =?us-ascii?Q?aI16IDrT0jVuSErBbvmqXTN2EkpUyhmPZAOJxW/iMwpGTlUVC4D8uqmmpTyx?=
 =?us-ascii?Q?Guc4gEbPHStb2OsjegMsJmG0lXRVy7QBbapc9pcvQSe3jLm1kWYcjFqHFpGF?=
 =?us-ascii?Q?2cstzaAoeGHcIqLkTQyG0C8O605AEBPV4994GSIwIi+2Cxft0dJ9cGTIVAFY?=
 =?us-ascii?Q?b2QPT5+APAGMsggYwOSGp74Ctv7DcrjkvrNowQUYe6tbhbNbHELIHe1XF4hq?=
 =?us-ascii?Q?dxqnbdX6mR+Tpt5fSNvfCP7PKM15nXqyc2jonNItMNudoeJPOnyLZsU2U/wg?=
 =?us-ascii?Q?f0F3Iz75TfxABJ2t8Z5u4MBfRGfTawe0v2HyoEYVPPWVZwD7DImICs+yLRIt?=
 =?us-ascii?Q?rVLl9LurjBJsfAeXugVp3ejcVpSFyDabhOBYy/L+1MFU7kRPS3Nk99+ahah9?=
 =?us-ascii?Q?w1RAfKli+8o3qYri+oMATm3/sp8USZdwNhQfCsfQhmryPQo/wnzOOHpuFRgH?=
 =?us-ascii?Q?5MqvGg3DLLtz2RHVIa8ecggv02iWznad+psmlnnk0HdgD8X7IapMsGAZr/80?=
 =?us-ascii?Q?pQkMHjvxlqH0ToeIXG12DelQl/9f+qdR0ZGZ1cEzw9MKQJdOTiAY7+fJzID1?=
 =?us-ascii?Q?ZDje5HbiCMirbYkn81g50jaDZh8gFc5/YSBDkFzyX2AVm47DXFNMqV9cneZK?=
 =?us-ascii?Q?nF+TF4hjQOVP2p1IzyJJ43HRMwNa67V9Aqmk4iV1Lt0Xts0XYlOkQ7KtyoJU?=
 =?us-ascii?Q?1vOR4MTiGoBIS5+0tYvZZseos39L1Pq3Wy3nELExQHuGOX75pKSnjdPggUl4?=
 =?us-ascii?Q?JXbIEJUuiFepMZi54RSDyW+2mt2GPP9EuMMNauxGS57yApPoTx65mTdk0BR1?=
 =?us-ascii?Q?w5TXVaRUcuFYGPVPS/9jVknNcEcyL/PdciqNpWNjcKmWi7AB61Lv2B1MNJI4?=
 =?us-ascii?Q?7Rc6cJnK93Do4tzbmWeRLXRrQ/1KJn8X23io3O3IubPO+tYMe9rFZPOfDssB?=
 =?us-ascii?Q?z1EoTUHWT3pYcdP5tQInXFYqinWAChghERKl7K2E33FdtCszb5efefym5srx?=
 =?us-ascii?Q?38fBHHSiP1/lSCLKgrAqh/+35gHiOtI97HOdWv729PK8QteILYdULhP3DWDo?=
 =?us-ascii?Q?6UqaRqgERkPPlJon1Zg2B62j0rn7xhFf5VprJX4uGjDtxbfne4AF3Rj2CeI7?=
 =?us-ascii?Q?pm/+uEhws8FeWqaF93bF1spfjlvEB1yaMfgoYIL73IYxQAnh3mFGRhZjGRqt?=
 =?us-ascii?Q?5VS3ePgfnAvN7Y0KPnDB6z2/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c0cea6-ed1a-4531-3ef2-08d931a9c614
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:49.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLLIhUQV5xNmJWoaI+kVBAIXVmI5V/K47+67uFeAtft9YNbIOXp3L1gtqFk2If5GgO5bsHvNuiiIDW/FddnmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0981
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/rx/rx_filter.h   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_filter.h

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_filter.h b/drivers/net/=
wireless/celeno/cl8k/rx/rx_filter.h
new file mode 100644
index 000000000000..a51f730019d3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_filter.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RX_FILTER_H
+#define CL_RX_FILTER_H
+
+#include "hw.h"
+#include "vendor_cmd.h"
+
+/* Field definitions */
+#define RX_CNTRL_EN_DUPLICATE_DETECTION_BIT      ((u32)0x80000000)
+#define RX_CNTRL_EN_DUPLICATE_DETECTION_POS      31
+#define RX_CNTRL_ACCEPT_UNKNOWN_BIT              ((u32)0x40000000)
+#define RX_CNTRL_ACCEPT_UNKNOWN_POS              30
+#define RX_CNTRL_ACCEPT_OTHER_DATA_FRAMES_BIT    ((u32)0x20000000)
+#define RX_CNTRL_ACCEPT_OTHER_DATA_FRAMES_POS    29
+#define RX_CNTRL_ACCEPT_QO_S_NULL_BIT            ((u32)0x10000000)
+#define RX_CNTRL_ACCEPT_QO_S_NULL_POS            28
+#define RX_CNTRL_ACCEPT_QCFWO_DATA_BIT           ((u32)0x08000000)
+#define RX_CNTRL_ACCEPT_QCFWO_DATA_POS           27
+#define RX_CNTRL_ACCEPT_Q_DATA_BIT               ((u32)0x04000000)
+#define RX_CNTRL_ACCEPT_Q_DATA_POS               26
+#define RX_CNTRL_ACCEPT_CFWO_DATA_BIT            ((u32)0x02000000)
+#define RX_CNTRL_ACCEPT_CFWO_DATA_POS            25
+#define RX_CNTRL_ACCEPT_DATA_BIT                 ((u32)0x01000000)
+#define RX_CNTRL_ACCEPT_DATA_POS                 24
+#define RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_BIT   ((u32)0x00800000)
+#define RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_POS   23
+#define RX_CNTRL_ACCEPT_CF_END_BIT               ((u32)0x00400000)
+#define RX_CNTRL_ACCEPT_CF_END_POS               22
+#define RX_CNTRL_ACCEPT_ACK_BIT                  ((u32)0x00200000)
+#define RX_CNTRL_ACCEPT_ACK_POS                  21
+#define RX_CNTRL_ACCEPT_CTS_BIT                  ((u32)0x00100000)
+#define RX_CNTRL_ACCEPT_CTS_POS                  20
+#define RX_CNTRL_ACCEPT_RTS_BIT                  ((u32)0x00080000)
+#define RX_CNTRL_ACCEPT_RTS_POS                  19
+#define RX_CNTRL_ACCEPT_PS_POLL_BIT              ((u32)0x00040000)
+#define RX_CNTRL_ACCEPT_PS_POLL_POS              18
+#define RX_CNTRL_ACCEPT_BA_BIT                   ((u32)0x00020000)
+#define RX_CNTRL_ACCEPT_BA_POS                   17
+#define RX_CNTRL_ACCEPT_BAR_BIT                  ((u32)0x00010000)
+#define RX_CNTRL_ACCEPT_BAR_POS                  16
+#define RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_BIT    ((u32)0x00008000)
+#define RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_POS    15
+#define RX_CNTRL_ACCEPT_ALL_BEACON_BIT           ((u32)0x00002000)
+#define RX_CNTRL_ACCEPT_ALL_BEACON_POS           13
+#define RX_CNTRL_ACCEPT_NOT_EXPECTED_BA_BIT      ((u32)0x00001000)
+#define RX_CNTRL_ACCEPT_NOT_EXPECTED_BA_POS      12
+#define RX_CNTRL_ACCEPT_DECRYPT_ERROR_FRAMES_BIT ((u32)0x00000800)
+#define RX_CNTRL_ACCEPT_DECRYPT_ERROR_FRAMES_POS 11
+#define RX_CNTRL_ACCEPT_BEACON_BIT               ((u32)0x00000400)
+#define RX_CNTRL_ACCEPT_BEACON_POS               10
+#define RX_CNTRL_ACCEPT_PROBE_RESP_BIT           ((u32)0x00000200)
+#define RX_CNTRL_ACCEPT_PROBE_RESP_POS           9
+#define RX_CNTRL_ACCEPT_PROBE_REQ_BIT            ((u32)0x00000100)
+#define RX_CNTRL_ACCEPT_PROBE_REQ_POS            8
+#define RX_CNTRL_ACCEPT_MY_UNICAST_BIT           ((u32)0x00000080)
+#define RX_CNTRL_ACCEPT_MY_UNICAST_POS           7
+#define RX_CNTRL_ACCEPT_UNICAST_BIT              ((u32)0x00000040)
+#define RX_CNTRL_ACCEPT_UNICAST_POS              6
+#define RX_CNTRL_ACCEPT_ERROR_FRAMES_BIT         ((u32)0x00000020)
+#define RX_CNTRL_ACCEPT_ERROR_FRAMES_POS         5
+#define RX_CNTRL_ACCEPT_OTHER_BSSID_BIT          ((u32)0x00000010)
+#define RX_CNTRL_ACCEPT_OTHER_BSSID_POS          4
+#define RX_CNTRL_ACCEPT_BROADCAST_BIT            ((u32)0x00000008)
+#define RX_CNTRL_ACCEPT_BROADCAST_POS            3
+#define RX_CNTRL_ACCEPT_MULTICAST_BIT            ((u32)0x00000004)
+#define RX_CNTRL_ACCEPT_MULTICAST_POS            2
+#define RX_CNTRL_DONT_DECRYPT_BIT                ((u32)0x00000002)
+#define RX_CNTRL_DONT_DECRYPT_POS                1
+#define RX_CNTRL_EXC_UNENCRYPTED_BIT             ((u32)0x00000001)
+#define RX_CNTRL_EXC_UNENCRYPTED_POS             0
+
+/* Default MAC Rx filters that cannot be changed by mac80211 */
+#define CL_MAC80211_NOT_CHANGEABLE (            \
+       RX_CNTRL_ACCEPT_QO_S_NULL_BIT         | \
+       RX_CNTRL_ACCEPT_Q_DATA_BIT            | \
+       RX_CNTRL_ACCEPT_DATA_BIT              | \
+       RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_BIT | \
+       RX_CNTRL_ACCEPT_MY_UNICAST_BIT        | \
+       RX_CNTRL_ACCEPT_BROADCAST_BIT         | \
+       RX_CNTRL_ACCEPT_BEACON_BIT            | \
+       RX_CNTRL_ACCEPT_PROBE_RESP_BIT          \
+       )
+
+u32 cl_rx_filter_update_flags(struct cl_hw *cl_hw, u32 filter);
+void cl_rx_filter_restore_flags(struct cl_hw *cl_hw);
+void cl_rx_filter_set_promiscuous_off(unsigned long data);
+void cl_rx_filter_set_promiscuous(struct cl_hw *cl_hw);
+
+#endif /* CL_RX_FILTER_H */
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

