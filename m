Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8C3AB89B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhFQQJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:15 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:50945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232833AbhFQQIH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJioXfCvZqMZKjuW7gV0ElPaTZ3WSbD5Vpc/3C7HLfDg1zAGdh/OZfzkpTuYIQd/Tpkq0FixfCfwG8DSpydQWo//qnXWIt7q8DcFhLjYL4czFsUMTSvf5CZ4Zd9KzFsMxSm5U1Q89LoVvmVv95t54PYDMw9ork7QDmlmydYuCRVddZo8hkg7aVHgEMpUZSCazvnP/g+RQCMfjK7F3u11OfK1Kp2mpA933zBpLrY6aoJYMXny3w8W5sZtsBHY8GQYTfwH9wDwWTnbHeIZ72h3ZfXpuJjH8eGPpFeaKV1CR4IydmsfPc3MMvqTitLjULN/W39ZnjX0ezCRr9Efv95wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtQYq0WVrZRxrf+pN/SEZ0Aa1A1/0rdC9OXHpQTJoj8=;
 b=EWrTzv2N3Iu9whcbjqfKoqL9fw07pN8YsDfxYIcAs6PrqhX9PwvhOfjhq+rf1Sn/viXsQ1FeNSjpNljji6bUof/ENp3PygL/bPggJC4eZmLBXUqCU5sqOKS/zt2WtY85VIOMvbTQ3oHeiLmPO3184VRgGdF8pHkeTF7E+M1RoyE4RvlWhEjx5ZRssgRGZIbX33TpST+hv4Qc8dptNB0hhnPa5YMnt+RWeEP0VlhxDjzy6nx7lcNeyNw3Sy0D9GNEaoZnB5ETzyagYI7ugFtOHvEzCvTrblK9aqDMFDb3+dp0/WPwqhsak0XT/nkKtmyKGEphXlrlNGw8jnyAG7P5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtQYq0WVrZRxrf+pN/SEZ0Aa1A1/0rdC9OXHpQTJoj8=;
 b=3z1LFHHk6u30Y19stUzlJ98X0GwN2hpQ4LSqBmQ3yWfQTF21aStOPkWjzvMX1sFq6euxI4NhgsMR2Cz7L1Y5r7IhMxM0ctaWqvqAVgwzaLihdfxueqdwvIVkDDAknG4cgBm/c5H2kceCF1w1jUMJhk5e8bL9KXHbGQFj/ifOXCg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:43 +0000
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
Subject: [RFC v1 122/256] cl8k: add omi.h
Date:   Thu, 17 Jun 2021 16:00:09 +0000
Message-Id: <20210617160223.160998-123-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52a641b5-cf47-4db7-43f5-08d931a9a1e4
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314B3A1737A1D100980F8B2F60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2JIVrjyDLm016BysSIGcUfXhQ88pW7IPvKtaCPN+t+kCv0u6FM1CpAGm/uOavOoOSc00HiovWABNjODiwilF1qctljPvhaOsEvd6vqbOLgqZ5P3nwq5/KDcYWXF8InsJz3/DhMJyF12PuTnPpzQLHJaBSL9WDdwAS17K1r5mgX2GIjO5U6aEYL1AOeDtvWFyow6EOqJoxB6ifTEH96+/TiYadrvEg0PqctjgG2gUoPNKtE5+b3XrEFkXsmIk1yHenAi/nQK80hkCuXvR7GjmnwE1BWJNnDjKSqnYJS7MP8XtntjdwShvg+VPxQpUE4aPB23wCMeUjCMl6Hg9itKpDOez2eCba12fcqR2gffrUZs7LBvx2++hkNtgbqhce7QhOiey3rDI06ZvFlyGSMwrWIMy+7LO3LJIG1MHW8AU5EhgiuwBGLZPg4tahmhPDTLxUK7FDU+RcwEd63NbdQEwT1p1j/PRZIEEV7W5FZ1jprGFVwDTZN/vm+xHjb+LZ8IVGgQSE71dOy38/uSw7w79jtBCA/PfQgWjEag1bf4rbtM8oObiBgWflgSmNGVTtfAnW0A7fR/4TrQsssoiSnF8nyWlJWHVScWGJxuQlunTySNDmrCybwEVbKBMm310JbAr3CYwZ1UGa6TzuLg2goMO/9o/z2RqNnV2fkA2FwfAupGVHVX8jzHLf978olhQAxQPsrAfs/qc87sS1AoHtHn8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wt5YQnTOSWo4tNeFgQFiiML+doZuRNqUvqG9SYjtOf1VXm4M2Tmet0XymZgp?=
 =?us-ascii?Q?M4klzYukoudon9wFH6n0+js9bvFWHeZpkTab2Z0ubjhprZb9CUZVMyvY51JI?=
 =?us-ascii?Q?SiKgMtlDFlnhfEmldAdcMbpyA8ByC6Epbe4D8AuSxEh2UHpvstDlPQCvyShd?=
 =?us-ascii?Q?5HcPxaPY+jTq9qfBYtr19fwwwxI5ytq7ZJLH8cV8nkf07G63RBkNxP7R8Hg5?=
 =?us-ascii?Q?AaFGBjafwmQLl5kwjBoq4PxAOQjDn0YpyzH0b1nnZXQODGpoGmmM5zNkSHi+?=
 =?us-ascii?Q?GZvoS33OMa/Hd9KP2EUGP4FpNbakW3AtM034PyF+mUoDHv/xqC2YGkjRHeBU?=
 =?us-ascii?Q?FP1kh6JSDvOCGpbYfcvFw0olIW4v2pRV8og9GmngRIVTe6GzS1Lr6IRhLlr7?=
 =?us-ascii?Q?sjtEnLkGCibtWWCMIn8yUiNn8A8AfbMWB8QXGXlFPTgmejCn0nEvfaMT7YBB?=
 =?us-ascii?Q?7hVj/WdvMYiOODgbuy1wiUf6LoJPwC6fFecYUl2qDzoGEz8lO7qmn3y7Y9NJ?=
 =?us-ascii?Q?e7DPnhfaccqhwHvTsRNjEBL0BhGvY4lH7ZTkB+DLaPzGg288Ef448i2mL+m+?=
 =?us-ascii?Q?u7KcfrRbGutdgTQ/6G2wwdKAex2zgyUQgnRuxtucI1anUL15N3H/ZnoOmZ7+?=
 =?us-ascii?Q?8U7xPWO45gwcaHRdaBYAOEY+gr7Kv2ETMNaWM1UVr6VXTPydG9PhS4yMcMBt?=
 =?us-ascii?Q?Q9gu43jKxxcU6uU+wFrEkOQzr91ozobnMyMjtQ1xO94kANyJWNg7WB6UiRWa?=
 =?us-ascii?Q?V2mnJuCEmM1o9rzHGiu6wydDdRwIX1MpC60/dP26XORtFQW+aEZff+z89AlE?=
 =?us-ascii?Q?7kzb3xdSjWGXP+LWk3K/iFDHs61WiRboTwjTkobF/TR/Gv3n+r1HIlyIH9Ln?=
 =?us-ascii?Q?gGsLRYvGrkZ66Peji8eoIU/8Ok9HaI62luX7hqD8yYs5NVY+ZFXLJTl5KjKT?=
 =?us-ascii?Q?dr2FUewjbg2uz1oUDMIAna7oMk7lDYZ0IKaGLnBEv9XDmeJvDzmLnH1nnmOh?=
 =?us-ascii?Q?EAN36b/ee8SL8pI/1lVRWl8m923igdLQDutNJ+nqLqJwjLHD6AhBs2yDh/iD?=
 =?us-ascii?Q?SMbfsSXEvhmgV3zJwXM/OG/FCV52qKuERlLWDKD9lYzKaRsBqTcBfv4PO/Vc?=
 =?us-ascii?Q?L8wIC9tfmHhBdLQ+B8Hz4bU9aTAwJparrMtG9VDscOHdDkDYN3iAk8zVkQUU?=
 =?us-ascii?Q?KU1aJQgp1DAUz1U8jJFj4nUAaowR2CLt1WOaME05Hvh1KiIQUkY7dywC5WQ7?=
 =?us-ascii?Q?nDBeSql8l+4fbGZP9w6BtpdsgzLijmR4hdXcrQ9uGnmNhpB9HEKwCgP8meLJ?=
 =?us-ascii?Q?yQxVa4EMpJPOmLPG3QcB7bku?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a641b5-cf47-4db7-43f5-08d931a9a1e4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:48.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWak8VGjSKtRroLkMI2F3SXB7RdlPVcAAImrX71sC1gPu1GtDjwREoKgGdIDslGs+VPT11jds4mhIrUamNK2gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/omi.h | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/omi.h

diff --git a/drivers/net/wireless/celeno/cl8k/omi.h b/drivers/net/wireless/=
celeno/cl8k/omi.h
new file mode 100644
index 000000000000..dfcb13f0f476
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/omi.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_OMI_H
+#define CL_OMI_H
+
+#include "hw.h"
+
+/**
+ * OMI (=3DOperating Mode Indication, 802.11ax)
+ */
+
+struct cl_om_ctrl {
+       union {
+               struct {
+                       u32 rx_nss : 3,
+                          chan_width : 2,
+                          ul_mu_dis : 1,
+                          tx_nsts : 3,
+                          er_su_dis : 1,
+                          dl_mu_mimo_resound : 1,
+                          ul_mu_data_dis : 1;
+               } __packed fields;
+               u32 value;
+       } u;
+} __packed;
+
+void cl_omi_parse_om_ctrl_frm(struct cl_hw *cl_hw, struct cl_sta *cl_sta, =
struct sk_buff *skb);
+int cl_omi_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_OMI_H */
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

