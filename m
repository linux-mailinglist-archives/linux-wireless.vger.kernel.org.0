Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE303AB92A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhFQQNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:11 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:33286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233000AbhFQQL6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATr4fJvJ/3uJvS/nDWXPslazbbcqUarMxY9S/Gy0jWBxIz5bhO9UqnMzLLGnQqvBomhV4bEursC1xjnNVHN+1jy1kuMkX32GwpSmOb7eZFZ2IC236nFDyyK8dEujy87gfAMnynRn4W1wjBQ8SSHinU9mWymA6Y3Pzsb7Y5eLBi807L4dLiXpaM/uncS0BMai9J8sZOj18xW37Y0nrU5pxftiFCTMMligdaamuFguKIP3m4uOsqyRW/wfx3Kcdl4lhasGsG+eqef80P+KjuK9622SfN1ReUsZzuyrIfuCQ8O61pI3PRjKkaqVffngOzB+IC8GaNajpAIL5iNSHwm5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRWihsBEmPNWXV2wTUKBLHICgsdxHQalsLG0QJ0aOTY=;
 b=QIxk86dfB/g1lnbBkS0lsHiQpA9NDQOuKPksQA6ScY0GwDtzfnhZfTsB+VHtasGzJ1xG6R1I9SDa/ejy0PHURwfzPo+9hBs/X+j3RVI43nrv0a5YU0nhibMHfkPG+2eBnhryuEu8gIEviUh+FKNEnMT3Pjx7PCdmNXDcgqfey6vrONPoBSSaluTToEQbtDEkRVH9ieyfT6oKGh0ybLPLLCn0+JUKcj6kEFBzoZokaufoyQj76L/C5THziSiM40ZWXzmrHgiK1X+MSYvFlAdJs9HKOCHnas2hiJs6KliFleOs1X7X8dMRmwWE96Ba8IUjV3/3UKP3wIrclBOGP87XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRWihsBEmPNWXV2wTUKBLHICgsdxHQalsLG0QJ0aOTY=;
 b=A3iTpE6mg+KQl8noAxFnc2rOif8dIjD+oJZRsX5utEMplszuWs0MsuEt/7GLWZdQZoWZdw0DlRtnfQByNNxgE0aYOZHgsBS+fNMnt1pmF+F01x9zsBdDb5dbi2ZWmPq0mM5nuEJgDOJ0xVcVsBHjPmLzBN3+V78/OotgR2Iw3og=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:11 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:11 +0000
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
Subject: [RFC v1 189/256] cl8k: add temperature.h
Date:   Thu, 17 Jun 2021 16:01:16 +0000
Message-Id: <20210617160223.160998-190-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f91a49c-3b61-45fa-2e7b-08d931a9ce8a
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB026009FAB639D7E23AA3EF42F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2Ul6NzbbWSaGTGZewYmmKWt4vr9m/l4EGL89XiNtKHao/LAfdU1DGhbtnIS1WyMJ3RfTu4PYDEVV02OaVqujegjEGsayf1JPu3+DE/+wBzM4Vmub4cKvMTThu6eBEr3i15fB42uvV2on/sEf0NVJKLX+HJcdh4wPGZu5QTCfqySUxuinAoNpd5d9CB3Do6riijoTs+zWh4edPBGW3d9r+jo/FroXNSytTtetrjioRpwUJXAEYCmnYxHJ4sIbryrxrCGv2LVgDbJX4oPvFHULOC2uFSQZXy8gWVHdXp7Bs+SIuV1GIy59l8gppwQeCj8PuycGwliHlnOsmBVIKqtX1dM6fEUPrTNKYc4R/uyP88069K9mvJq8vQkHdr1J3aBzRXgNXTA6tFHZV1QVp/ZKqJFeRz9aF2ikAinoLKXurUYhIWHIZzjC1V6XKsUNx/gKaMFtoyvVO0c18hdP5lfCx7DTvp1m5CIp3lc5v0SGa/8WLlSm5A5SpfhwxzbXA5Ac5o0gu3wrSDgi3HGsdhWIABcZ1papbaxxBEvWV3xO0VpJeuUmC8wodb3kYcYJVoLe6BjzegK5RRb7+WztGaUtZ5vPmtMuLb9NPLgRsostZKyqY39zEj4P4x0NfK8P/DZgjwmn79XHuD8VHijvS/plClaYKUX4EdTJOKmsth9m+X/EJQKYPjgWJJISREiib2NFzZ0he+zHE8e/h1sWo7e8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYOSpJxRGeYPYUge5jnr3TOODZOufJ+FU6GrGhLQ7k6p0FsCyVlIDDJ0vsSU?=
 =?us-ascii?Q?W4pRH8vAdSXW4GU/OgGuDDGTfZeFk9GmTQH0JEBS36PC+mT3DEPNIViSMq1S?=
 =?us-ascii?Q?BXoJZ0PWlu8g5VPCw6yxbPBPnAbMzGHIVp6TOZ09/l98Gl3n8a8AKHVfzHgo?=
 =?us-ascii?Q?mkxXjB8Ia53xnVlQN/R+fqTM6IQFvb48szbF9tTsiIH9RXMiPXXG/7nKuApj?=
 =?us-ascii?Q?wEKj4rkZQ3p8QSMCyijxiUm5ErVpEqWluNoX0b/+evH9ikjp4ChAdzClXCxl?=
 =?us-ascii?Q?JwknKueUgGgRakHB3ymYD59S1BTyu/YGOhLLTWs/0B2k6KBqAejFgGK2L6mr?=
 =?us-ascii?Q?E0zRWVze4ZcC8xKVVSLXwRWnd4I3uqnD5WBF2pLq2LUOW0tAxmNh1HCRMFQT?=
 =?us-ascii?Q?kXBAFeWGfPabkdR0pPkM2NzZP5qHPBxQZLIlPB8ISkIBJp2jzpmazwEZwio2?=
 =?us-ascii?Q?n4Im3c5OKmBlGzUvzOoFQ0sxkzxdNFifOKtoTMrkyRMgM+frC2Pk2LzBF+Ut?=
 =?us-ascii?Q?NL1H0Pynf74JBuJbzdT44GenS59E/9U/1RxknO3nngQeTYSH//61Mamps4OP?=
 =?us-ascii?Q?NqAl5rt6yqPjUJAjBm0a4IHPygux01KexdFcDwwbBXKLKXuAiAWSyLDXaI5X?=
 =?us-ascii?Q?/X5kk8IxiEJvRyvlumk/gSuahrR5NyE89g1Ve59keJTjAcutKWp+QcJ2GJ0h?=
 =?us-ascii?Q?17jmGhmixM5+gsr90wjcE1FAxPs1ggNx2nXcGGJ9i7MOIyQAZi4xZ5ZcjsdM?=
 =?us-ascii?Q?8cofdv2aQUZtt+bEnm4I2+6fjYdXglpdyV3Qt7JTtrOfRgx9TrbrVaDp0N/0?=
 =?us-ascii?Q?v7wesuFUmQxypuTE9tbeyX2cQKjkEmTaBAZW8jH/N9HcU1nBMHFq8akfr9UR?=
 =?us-ascii?Q?00SzFAzsMfy4PnCYyujegII8DfAv+iG2RnzhTu19/Q2mnSqiKVtjq80Gzn4u?=
 =?us-ascii?Q?3XhIZie1UPWGBw9DUcgH3L4D/F80myjBmbH3er5dytNNf4ytKBYuNdeljy9a?=
 =?us-ascii?Q?1cv3gZ/965ENjbkfLIuMMLzmNjIbFOyMQYvJOqtykM3IhaVvDEm8dSFn5Ttb?=
 =?us-ascii?Q?FW2AJK5YSZ/lME8NpKQEg7VHIt/B7P8aVfyAmf/C5hjrT91CWdmvvr53Wr9n?=
 =?us-ascii?Q?Umr6FlKw3nGsNyjuQatWkn/XlBpzc4FFQTYEoDX7TjXf0Ru3iFr4yEyM0FXv?=
 =?us-ascii?Q?GNfpcAx79888J2dYVrXVgfCsFJbIuok7V5tpdT3n944T79J6OPgUD14qb/KF?=
 =?us-ascii?Q?aoYjCQdOCsn0STqWvJndOlBwkOh00b1hX7bg36oz+qOjVjfpf7A1kcFaTkw5?=
 =?us-ascii?Q?2kJJBdFCDCugUXDUPbgr2tkC?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f91a49c-3b61-45fa-2e7b-08d931a9ce8a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:03.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKSA0i7MpNUf8U7PtmKx9/4pe+/PE3M2+G80bfoP2AL4qhR5M6gzBbCTzywTGhqq9iVng0U6lKlZNt4xGfwumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/temperature.h    | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.h

diff --git a/drivers/net/wireless/celeno/cl8k/temperature.h b/drivers/net/w=
ireless/celeno/cl8k/temperature.h
new file mode 100644
index 000000000000..9f34d06b64eb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/temperature.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TEMPERATURE_H
+#define CL_TEMPERATURE_H
+
+#include <net/mac80211.h>
+#include "vendor_cmd.h"
+
+#define CL_TEMP_PROTECT_INTERVAL_MS       40000
+#define CL_TEMP_PROTECT_NUM_SAMPLES       4
+#define CL_TEMP_PROTECT_RADIO_OFF_HYST    10
+
+#define CL_TEMP_COMP_ITERATIONS           4
+
+#define CL_TEMPERATURE_TIMER_INTERVAL_MS  4000
+#define CL_TEMPERATURE_UPDATE_INTERVAL_MS (CL_TEMPERATURE_TIMER_INTERVAL_M=
S - 100)
+
+enum cl_temp_state {
+       TEMP_PROTECT_OFF,
+       TEMP_PROTECT_INTERNAL,
+       TEMP_PROTECT_EXTERNAL,
+       TEMP_PROTECT_DIFF
+};
+
+enum cl_temp_mode {
+       TEMP_MODE_INTERNAL,
+       TEMP_MODE_EXTERNAL
+};
+
+struct cl_temp_comp_db {
+       s8 calib_temperature;
+       s8 power_offset;
+       s32 acc_temp_delta;
+       s32 avg_temp_delta;
+};
+
+struct cl_temp_protect_db {
+       bool force_radio_off;
+       u8 duty_cycle;
+       u8 test_mode_duty_cycle;
+       u8 curr_idx;
+       s16 last_samples[CL_TEMP_PROTECT_NUM_SAMPLES];
+       unsigned long last_timestamp;
+};
+
+struct cl_temperature {
+       s8 diff_internal_external;
+       u8 comp_iterations;
+       struct cl_temp_protect_db protect_db;
+       struct task_struct *kthread;
+       wait_queue_head_t wait_q;
+       s16 internal_last;
+       s16 external_last;
+       unsigned long internal_read_timestamp;
+       unsigned long external_read_timestamp;
+       struct mutex mutex;
+};
+
+struct cl_chip;
+struct cl_hw;
+
+void cl_temperature_init(struct cl_chip *chip);
+void cl_temperature_close(struct cl_chip *chip);
+s16 cl_temperature_get_internal(struct cl_hw *cl_hw);
+s8 cl_temperature_read(struct cl_hw *cl_hw, enum cl_temp_mode mode);
+int cl_temperature_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)=
;
+void cl_temperature_recovery(struct cl_hw *cl_hw);
+bool cl_temperature_protect_did_reduce_duty_cycle(struct cl_hw *cl_hw);
+int cl_temperature_diff_e2p_read(struct cl_hw *cl_hw);
+s16 cl_temperature_calib_calc(struct cl_hw *cl_hw, u16 raw_bits);
+void cl_temperature_comp_update_calib(struct cl_hw *cl_hw);
+
+#endif /* CL_TEMPERATURE_H */
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

