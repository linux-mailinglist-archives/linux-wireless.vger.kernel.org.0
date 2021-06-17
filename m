Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFA3AB8C4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhFQQKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:23 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:64066
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231148AbhFQQJS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVt1ugnLhweY4OvRhP0eovv84fHt7RyB9mXgbg4otVSGliUl3qnZJ4cpiKgRNcz80yl/gG3oxUSVTco8/f6ILD9aldJkYD0BCcnOYK/d9MFh10SCfUFhxSSxlm1kos2vQ09Um/5RX6KynVlYmSEAxH6jpZCwNQtZHDLdDxUgoaHcusk6+FCuK0b1Du9ApsAKQwocMgHfpazaN/sNa14hSqBlCWK4TqCuhyfiRJSNGhJPrRBVG1OtPpHf26hq5wKWF2KXFyRGCK6oOobQkCshKbRZeN/WFdUDDZBr1sx0vh87GoRSgh048ss923KIVgQHuvjsRq/MIEGkeH40FGSHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciE2nHticaYgdU77Q37QQJQhA+HC0FstWCGUqK1pcHE=;
 b=Mto05UaojsyMRAQ1MY3J7qFWF+yrl7jbAt5pL3DAxdkIXvReOepfV0zG5jhhxRdx2GxhgMYhJDr4eIYciG1BKuFnIO3gKSn3lFU2Ze8QVkhdnNPwwV4cB5Dm7Opr5obQuto5NVDVnmb0Abwv/fBr76sqisJz10lLu86LZS4j72yWPEegbdJZ2Sku5Ig6lZQ2/uIHPksiaWD+8FnboRSkyHZ0l0dDO4TVUP/vRyK+0jf/gj0oNLgPYdPDhQoaduYfgnmJRsrbm2NAsNkKxz23YhbkTz+UBeDi3iHk9XdSybBUmo1E7ZZIdeADC794jWZjFsHmItnOfGB8z6N431I+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciE2nHticaYgdU77Q37QQJQhA+HC0FstWCGUqK1pcHE=;
 b=nQGZlNDbpMSxapTL1a/l4pHqUdZvqV7bHxC8a6iMazgPgR81Fi2rsbx3cdTPk1wSD0gzszw983rbOS4GABtFDlPY4HVj9LwsE+RN/+0iM0y/wIG4DikUC7Q/p43lkdRMWyFmG2LYwGfdpHLfvuIj4uJCEN4OMkkWvyxQpJM17tM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:26 +0000
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
Subject: [RFC v1 157/256] cl8k: add reg/reg_macdsp_api.h
Date:   Thu, 17 Jun 2021 16:00:44 +0000
Message-Id: <20210617160223.160998-158-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe4f209-b8bd-4546-4e83-08d931a9b86d
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187BB0EE254F7A6A7FE0862F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ap4o8N0zVifg9AArJqqqOvRRngZuWSeMaQBUk/Gr3mqOYa+TLQL3SO5qlryNjPxR7YPI62b8OgfJknSBz0TK3J5X1wpy70baKN3b3sj7N3JOaH0b5Hr4flEXbXHcrkmDGdwab5zuwl8b+7M1aAfQeWsRgvEAtK8dlbaZN+MANYtA38iOam9Jg7ATUe004El6WE7ce36hlRuGIucvEXtkG1500h/G85yV/8iddrScIHjY8Vsj5lisftSIUfj4GY4KJ3BZnbS5FXn6M2yJpmovB7jBSqLCH4yozXRShCH+q/zCUGCuIGaXhBbMW6qCsxdObwe3lUbkxOV/KZlKGTUMH+CJuM46tvZZwxNG84qU8EDurVTsQQOu4iBtcxojaaEtYO3LcW7N9so2Gubpy5Ooc8D1kmUOtQj+51GyglbY6YTMyzZCc+Ir3S+hNMhDtZwYjsmXesonZGKGXoCMkWISEGOsAN8G36XikoaZ1UZOxFiiIGNxHfNHXRI6bMVc5FuQHiDwhUtLtDdEbq1Wk/KWJiy1MpCf0cCKsL+Mq6ccetOhI8oA2bDqyiaDhpa/lpE8YNHkjWkLKyZaPdQVcAyf3zWl53kzN8U/oh/mVE0rWNx5ks/1Kspzpm7e9FJQBK4HfnNZY46hcfoJDkSC/GWbQilYiPWAxw0i6gpRIwBAq0mTMABVGmcavePK+M/4ObrGgd/MDwrklt+mayM9DUOMwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVz9yDc3Vjk1x3XBhTXOmKeHF6AmOtwFh+Y8LcLDyeZ3yblGKD0tHDsybIfW?=
 =?us-ascii?Q?sbvFzPmPRWFM0An/FQpxtu+VWVTXENnOKzXrhdggMpAalczGjEJjyYzy7SNt?=
 =?us-ascii?Q?UIWWeI2zmGwWvornlX9t4p1il0DZAxa/dzQlABQ1wpwR8vniDCCTlu9USydU?=
 =?us-ascii?Q?pBYF/QQvjz224S5ByGsDvvLZdAvHYsLNMQ9l6FaOmQtG2nkkXSRq6skNVOTN?=
 =?us-ascii?Q?5Ajc6ePAAxVtY2/lvDNhj/6GSzwAoZffYpNpi6pwvpYR+KyBH0j+jWmulqtw?=
 =?us-ascii?Q?UcexqnZAX+MF2Uq6teUkYVmmjYD31/AVHK1oE/afJ8k5QeKPUNfIRff1Wiac?=
 =?us-ascii?Q?88zW3bEmMlMTGl84s1Ae3IP7LpS8F49zL/0D7ZTEMvZu75dhCJN2f8wV8CLR?=
 =?us-ascii?Q?XgiuIzfs0yCO3Je63KhJJMYI6nWEMRffyCn+YBzx5iMQH9M7oAJo0bVbSwm3?=
 =?us-ascii?Q?SoG1wo+/guumLqu14HERfuP7LcXY2Z8vwhpYvT18u7w/v10HwcxhOoUzEL00?=
 =?us-ascii?Q?X0qIGI05tQoIDo72NTB4FvBJKzuW9LC0t2SFR0e0SmnPxMs5b2/xU3HbimXC?=
 =?us-ascii?Q?v69I0uzrEkjPgYFhFxAH9vrSZwPEeJUZnA4Nr7q9iZ4RC0ZGSjZMGV1LPP6y?=
 =?us-ascii?Q?+CXMa6MCYlPoM872emflgoen2BCe3JPCY1K7gmF2AdnImxvtp+YYBQsSthwu?=
 =?us-ascii?Q?6YHtEIb8XBPP9BbHSOTCLs895S8clLz3AS0caYS+e/f3GXi4uXvGp1q9sOkN?=
 =?us-ascii?Q?X7MRIQeElxTTWavWsEhqn51mudklS6qzSJfL7xXwI2eYnZuilOaKfaIVgNun?=
 =?us-ascii?Q?nhev12ytEhBCADZBZpKYQmojiFgJ+Z6j7Mu6T77ubQ/MLuJw4UQPgOtR5POY?=
 =?us-ascii?Q?RCEkG+6HNi1skZBJJn3hCRqFkK4JyWDBXt5JDc437S7ayUv1/ADJi5Btyd8j?=
 =?us-ascii?Q?hN9cX0fxL0ByiqUTD+DTuJKmmE16I5LhU7wlhPKdlDSbNChrTdsxpQ1upFlx?=
 =?us-ascii?Q?BVReb/BE1Zm/rSFnn85RNQnhvd/QYDq1JW5PpTg1SaLS9U27rzNHb9J0agaY?=
 =?us-ascii?Q?TOZObAmUf2XtS7eGT0DZ2OQxYXsFgSrT4x3P8vqQBk4kKCwX/vh4OmFn5jMr?=
 =?us-ascii?Q?MbFutfCYIFgtDPlfGwU4WdtL3xL+Rf1E1yCHJjyLcO9dLcq97d1HW/XT6Q9E?=
 =?us-ascii?Q?+WH2guXBW0ins1g6aD9ma0mx7/BGiJ81BGBOubwUoAi6ywIBEamn7/ozSjxV?=
 =?us-ascii?Q?1PmrVVKtYb6OrBsQzj1cbrJG1QEL2VBg11hyeZMWbDPxQYk+tQ8TQ88uDe7r?=
 =?us-ascii?Q?LD7rFREfiM93ire6zJ3sNp6D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe4f209-b8bd-4546-4e83-08d931a9b86d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:26.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChSVmvvlC1KsMHRfeyjFb69Fl3j34DlC9XXhwlrpEHswSNle/g48G5spuROjKaeEVSFTkpM2LmUFF/jWH+fG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_macdsp_api.h | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_macdsp_api.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_macdsp_api.h b/driver=
s/net/wireless/celeno/cl8k/reg/reg_macdsp_api.h
new file mode 100644
index 000000000000..434f963650a2
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_macdsp_api.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_MACDSP_API_H
+#define CL_REG_MACDSP_API_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+/*
+ * @brief CONFIG_SPACE register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:26 ActiveAntennaSet          0x0
+ *    25:20 RxCckActiveChain          0x0
+ *    19:14 RxOfdmActiveChain         0x0
+ *    13:08 TxCckActiveChain          0x0
+ *    07:06 Band                      0x0
+ *    05:04 ChannelBandwidth          0x0
+ *    03    OfdmOnly                  0
+ *    02    RxSensingMode             0
+ *    01    UpdateSync                0
+ *    00    StartupSync               0
+ * </pre>
+ */
+#define MACDSP_API_CONFIG_SPACE_ADDR        (REG_MACDSP_API_BASE_ADDR + 0x=
00000010)
+#define MACDSP_API_CONFIG_SPACE_OFFSET      0x00000010
+#define MACDSP_API_CONFIG_SPACE_INDEX       0x00000004
+#define MACDSP_API_CONFIG_SPACE_RESET       0x00000000
+
+static inline void macdsp_api_config_space_set(struct cl_hw *cl_hw, u32 va=
lue)
+{
+       cl_reg_write(cl_hw, MACDSP_API_CONFIG_SPACE_ADDR, value);
+}
+
+/*
+ * @brief INBDPOW_20 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 Inbdpow20Pdbm3            0x0
+ *    23:16 Inbdpow20Pdbm2            0x0
+ *    15:08 Inbdpow20Pdbm1            0x0
+ *    07:00 Inbdpow20Pdbm0            0x0
+ * </pre>
+ */
+#define MACDSP_API_INBDPOW_20_ADDR        (REG_MACDSP_API_BASE_ADDR + 0x00=
000974)
+#define MACDSP_API_INBDPOW_20_OFFSET      0x00000974
+#define MACDSP_API_INBDPOW_20_INDEX       0x0000025D
+#define MACDSP_API_INBDPOW_20_RESET       0x00000000
+
+static inline void macdsp_api_inbdpow_20_unpack(struct cl_hw *cl_hw,
+                                               u8 *inbdpow20pdbm3, u8 *inb=
dpow20pdbm2,
+                                               u8 *inbdpow20pdbm1, u8 *inb=
dpow20pdbm0)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, MACDSP_API_INBDPOW_20_ADDR);
+
+       *inbdpow20pdbm3 =3D (local_val & ((u32)0xFF000000)) >> 24;
+       *inbdpow20pdbm2 =3D (local_val & ((u32)0x00FF0000)) >> 16;
+       *inbdpow20pdbm1 =3D (local_val & ((u32)0x0000FF00)) >> 8;
+       *inbdpow20pdbm0 =3D (local_val & ((u32)0x000000FF)) >> 0;
+}
+
+#endif /* CL_REG_MACDSP_API_H */
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

