Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429F13AB8D0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhFQQKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:47 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232598AbhFQQJu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3ydCt97uywPWAG8yNkBDHw8V0XTxODXqgaIqw2tp9y876HKMYr23OlcYyioqxrZZxkBQxDbdmChixfqQGWiIycZ9/2UbSGLLXEnk7WFPB08sImqYJVB2WiV6KyQPZLY4cCS+aqjp149cbqVjTXuAgz+Gbd9LiMd9dtlXjUQK1eVm85+zdKmcX/ZdqTO9gQtBWsrJZuqnChOTbDag+Zg1T1lQnrIbbCPbAphymZU1NQY5fGNGD5FyfpaSgBp07e7lbPCij+imSioRXHM25sjZwbw87Q7jGOmaETDpdXxHz9run5I1dIAGkUs0PRqlccc1Mw0YSJtkgA8dKL8Cva0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnbiDJUrS0osfSRKsPpfFxKgFQHWSOksUpZOemyPrxc=;
 b=KlZfyI7E6YyGhh8DRh/BPhMeOouJXpg/Ut1pfF9HX9PKQvNycM8H10SS/k8JildkdF0W54GMUQz5TntTJ+NksmMStItMXYwTokITZ8StO6eI7G7oFkIBzh5NKYAfprkEm2csa/TCL/UNsMvIMwY8YQZDJFXD3+jzwKNr4JqeiANgj0gAzun3+OzH2dbq6EOTvN6O24kV/ZdG8T6it5pi4tsQLp4SWUvQNm7jYbCz0jteaSsAlyOQzu3IQ4NERj/T9OmhIogF2vTmz4YJU2XgX+nNrlTGcgwObiYPKSVix7JeOBS2yN2gXPzS9s+JQRIGRHA5+kT99rZwX4kcKjxmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnbiDJUrS0osfSRKsPpfFxKgFQHWSOksUpZOemyPrxc=;
 b=uxtrQbcYQC4jfI/32fZ7l6RUEtCM1zj4ffah/fJdlmMSAURYZUKOV38TcTou/me28On8xhhkm/ylZMkkrCwjLlWOjKIIaNLLm3Mk1ZomMKKzUlnPcv426mDWgedw1bCoji1zEhWVRKhf85lr5MlcTC0Ar5V4mj/BPDbCzRdJbVg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:27 +0000
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
Subject: [RFC v1 160/256] cl8k: add reg/reg_mac_hw_mu.h
Date:   Thu, 17 Jun 2021 16:00:47 +0000
Message-Id: <20210617160223.160998-161-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ee6aa56-85e9-4722-1f6f-08d931a9ba49
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB11878A7BA36F78B949715B72F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 019K4zjC3oRGCdXRQOKGUkMSMIlmjslVY27gHTd3yuR4zkmTEA91Z3dEmpyrHlXnJiNUo7L/hLg/TcUU0UwvKML6/3NkG4hZMNf2Y6cM9dfCHI4x/YDL9/lAmYJoBHYkGbeLNuvrNVCW6D+nTh2kaIkg9OGBDPp1Y5UeNJN5VMKPZr1B03xqJvV2eOMSxxrQiCkaBxX1aV0FIA5ETUc8Vh9XHkDXPQ0NCkNwCAv8jm0/8RJxHB5PeXEaQQsCyA9WjOI5BPvwf7opQjUBQ/bhvF7a5YFt+NxBtXf2VJp9nERwUYcdzbO74IusTOJ7fEg5jbcPPH8F4/ej8D9CBxJFA6mAs/i9OloIzYTyCIfYxMa/R2oqlf89wuv3ClBn+bvQNBsgcXfj0AXP5V4vpB9Guzmo1+If1BIyE9JAuZXNi+pyYzpOrPN5b2CJPJ560Wi8tRgk+7mYPi+R3viRBU3+rC0fCozvs6zZH+Ki2Fb38TB9tAewaLslBTeFGToa4DKMrSilEQ8RMGJJ4CUX6dm6hFqm5CEZyaBSp9FtdjdlgFeZHN09ohQbcR3L5jC3eFAj4I1LSFbLrK4A3EGYzvTNWNtXSgFEWhmxgBsfid51mtf0AZ83ph5kzZ5lcpHILoq3QHUB95dJYYQEC1c5nTjXf+kFzQNKmnkTg4AD68geX5YOeYCFn+U0qTq+kjJlPzKc7Vjw+jgB57hNsOo3c1P2mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTriP1CHYTDtatq3d2+gSCYbeJfui6PEtY1seMBuzrpTIuVKKqc00oWcP+mB?=
 =?us-ascii?Q?PmxNq6ywgYEM2OoKuewxn4osCOTpO0lGS2g4UJpWpTSK4ABEVoe2yzKEVZXz?=
 =?us-ascii?Q?XfecQ/kDs7H1uglc6wNp0VcGI5mt8/Ri3WBIdnRcEjTksTIk0iIqkh09KrmW?=
 =?us-ascii?Q?Ssb1ZJD8hXh0Zgc7tZdlQDdBeK93uF+UqWC7lWZjITOzTvE79J0ItLRMD325?=
 =?us-ascii?Q?Gv06I+36Amme9Dxfw0V/ob9ofgcfm/dI+7Qi44xqWN2DNE+1EUl+Id11XzdG?=
 =?us-ascii?Q?gzrlk5PavAtzjNYboFCCNBhw9WHDoNItLpKGwCdv636H3KYansoZ63VNiuPq?=
 =?us-ascii?Q?jUgKhSXWUtW+TPnHkhaJ8JS/8FW1tK2WHbpp7RGTNpvPtfJVxbMt7558uq0/?=
 =?us-ascii?Q?+JxEoVxX29OAKoL0/blr3uyjmcHpe+PwnUV8KxprYr7dU1YVYj1Kc0w8YaGA?=
 =?us-ascii?Q?LQpHh/Wbfgliz82yGKXusF86bQlvJ87WdkAu7hI7wDv/QRZmmPjJ0tXTat/+?=
 =?us-ascii?Q?kdTRUFsClfWMPpqKZYDzPcr0d2vLfNqgknydp6Ka+18RaeY3JfiRx7sCefHx?=
 =?us-ascii?Q?qTQp7fAXuX9pytDxbQ0mPr7HDFveXod6N15fThOIR8JK6yJqnKRmVNpsZXXs?=
 =?us-ascii?Q?YrqVuFXZnVpYKe3OhO0Sh498RcepHS7F+z1KaSTcupB3cLR/qrfKlmphN2sX?=
 =?us-ascii?Q?L7hIgYKCTJB9zTbO+VAauyxygLkToeX/KIxOJVwyCBA5SBnGqfsCZq452dEq?=
 =?us-ascii?Q?TYB8FcDsmTQbI9DAnaUYAtOsY7pwxMuBFcWpPdtMI9nF+DSwRdPrvYKtIc4P?=
 =?us-ascii?Q?xeAPC54iOC6NPdgQzp7XRsyZGSwc2b2QlyeUy/0ra66Yp/jpDm3mtzXkr1N4?=
 =?us-ascii?Q?unEnbn0Am+mWn8NL2JaAcIDEgJ6I78rNP3M4QxtlbckZOy1/aTJIkiCQ1SGY?=
 =?us-ascii?Q?K2pdaDNSLhZH+TckkCHs/NbP5yO1BWuXQWPKG2SjwLR2/ClrJ66IsxpWiTmY?=
 =?us-ascii?Q?Wl5wY/OlbyJiffnIgulHJbx5TKXFv4bXl4yM42XEM3GfXJobiknc9jHsEeaM?=
 =?us-ascii?Q?a7GJ5Ryff1+75Q+dBT8Dp4oSK+04HdBke+7xobn9E/pO/Yl2p+9q1tNueteb?=
 =?us-ascii?Q?S9sFbafznlDeNIM+l4MJ4hYKw72Bd3AxCUfY0z3Kdd12P5g1jbKmBtbDjYss?=
 =?us-ascii?Q?Bs3xuX7n7BabNsq1vZ6uWpY0RFZ5P+ceWbgfNz93GeOKLGouJkwbUKUt0fvC?=
 =?us-ascii?Q?2gDCDC6iXxh8jvA2Ew8F2tk8FumVhyACPaMwjp4uJWlgeA64Qaoon/nPP/En?=
 =?us-ascii?Q?w5VQH2Op/+xvpW4yg+PTmUcf?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee6aa56-85e9-4722-1f6f-08d931a9ba49
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:29.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiSiAsrIzLdfQMWofCsdrDjaBEbiGErN9RotnUP9zN7sW5j86DlfianKMv/gEmZuM39AQW/93qwCvfhAsgasng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_mac_hw_mu.h  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw_mu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw_mu.h b/drivers=
/net/wireless/celeno/cl8k/reg/reg_mac_hw_mu.h
new file mode 100644
index 000000000000..45368cfc36d6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw_mu.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_MAC_HW_MU_H
+#define CL_REG_MAC_HW_MU_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+#define MU_ADDR_OFFSET(i) ((i) << 16)
+
+/*
+ * @brief MAC_CNTRL_2 register definition
+ * Contains various settings for controlling the operation of the core. re=
gister description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   00    SOFT_RESET                0
+ * </pre>
+ */
+#define MAC_HW_MU_MAC_CNTRL_2_ADDR        (REG_MAC_HW_BASE_ADDR + 0x000080=
50)
+#define MAC_HW_MU_MAC_CNTRL_2_OFFSET      0x00008050
+#define MAC_HW_MU_MAC_CNTRL_2_INDEX       0x00002014
+#define MAC_HW_MU_MAC_CNTRL_2_RESET       0x00000000
+
+static inline void  mac_hw_mu_mac_cntrl_2_set(struct cl_hw *cl_hw, u32 val=
ue, u8 mu_idx)
+{
+       ASSERT_ERR(mu_idx < cl_hw->max_mu_cnt);
+       cl_reg_write(cl_hw, (MAC_HW_MU_MAC_CNTRL_2_ADDR + MU_ADDR_OFFSET(mu=
_idx)), value);
+}
+
+#endif /* CL_REG_MAC_HW_MU_H */
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

