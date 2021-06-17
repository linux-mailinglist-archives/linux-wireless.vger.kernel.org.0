Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B159B3AB870
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhFQQIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:07 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhFQQH2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwxvxekEaZJFZXeoHTa6ouzvdlE/0u+cfG8BDPqCmitr4ibKlMPuIN02AF1kjMVV6w4zpmzYedCwxXe65zsVAH9i7p7aNiMpK2NczUovPglhgjwnPS8YpB/Wbyy5evPdCZXHiBJ+HcCB23/3f3qKQuDTJSoPzPmUIG4rE6nnKwUURAycJBXwD3l8WJ9mHF62edPZPvCw10iKjdiqSaFcAQwUrjftkM2aFzTATHYW33cSf1FPBrRtGxJRX2UpbxIuXStJ0xAoZIwlostAWTEVJQkHHnKiS/YC5ER1hXnpBP5pEEw6aaXZ8K2N/6v8asSKuec8BBVXjcNmYX6TwC6B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRpdU4ND7M4gkSV0A8/GHhm9JeJ8t87A45hhSfqiQg=;
 b=SNOjcSFYsvkvDt+dYDzMZUiilpsnKqpjMQzHhHuy7fLNBNLfxz9JoaR23yl2NVCxRtw3fzf+ogLZRThFyRLwG+hRNHlgCQ8l5jn80wXinbGZwwDoR0aCYxTEnhX9eFpLleihH7jfhcbjIwttz7xipsfR/Zkvq229U75iGQY1WgCYsl7rve4RBOCdc+4II067Nlj6nprBKCB8se7SG0rChrDu7At66SsdQIjMGh0NyPwji7n5PnWjDvFBmbZd+NaEcssDEgdQ+Wvcf9ol4Dahitl4ZazbfPGyaKCwNdTHwO5yV3HVxa5n0l9bYpV/aoMotywYVsGzBaFFQI6qGMqijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRpdU4ND7M4gkSV0A8/GHhm9JeJ8t87A45hhSfqiQg=;
 b=Kfvvp17sXyChjj9g5hL5rK2TtacOgCI68qqlfIwcAPq59VA1mwLE0P/KjN1oYT9VViD4LIsfpv/gICOJhdUJ6g/sXiDgftnHY7hxDA1XwPw5jNo88W6D4xJcpjcPaG9GHwtxBZaMs0bahdECoy+a7NsexjY1nvHIhjtaKPSkKMg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:01 +0000
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
Subject: [RFC v1 094/256] cl8k: add fw/msg_rx.c
Date:   Thu, 17 Jun 2021 15:59:41 +0000
Message-Id: <20210617160223.160998-95-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4c50f4-b04a-4345-6305-08d931a98f5c
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887E793A5885D94B5EE545FF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GV2b/MyvP0gCauwV7BB9yHcIUufYRhrZjBIos/02G4zYPGrBspcU9mWrnZ45dm6pmbpeWJKONehE3kbQ6W/CtQJXpsw5dAUUCBd8BMi3LNAMttLWfRC3ZZOwRZ4hTEbuOif0K3oktr7TPnDkFRyPxOUXAM4OSn+qgqyiiusbY3IIr+khcNZBBGkKCEhlT5dIiyHAMGJ3w+is8j5npPIqm0CMg/77TjC3Kogo0M7AhmR3f8LqPFqVt24+aRG1LVyPRpXASWGoPFTgFDSgCgPoPeZ9lL8u/s4v+TJVgE6VIYD4gIYR8w532RKvGr7LYroWBKeNXVQUt71n1JFGJR2mWnGdSgzfD18Q1iDW6Sd89c41db8XmcsgxQ8edUa2fMlcPAUlax/XAcftZYZd6f2nOB+EmWReRqvTvXzQUvj7pBDCCXcREsn2l0F1CDJTwUBlGdDs12dByYoI+ojx/O8lig6nCsMGNTW88tPsl23Yor5L0VozwSFas/3dhpVD80ryjyVvC+8pSroKtAj0JmMpqOmYgFtsz/P4N2rKNVJsdB+Ix6+oE3TlaHh3buHvFjZafMwsqJQwqWcnICLQnJrfSfKCQO+lxLg63SltMuPq2pD5nkTgjpug9hfpBivReWRCjWQyG91UVbm22kUn44OMEwZL8RFe1FA8tSSEmUyPeOlWePMObsmGVQHh+34adCxxGH/8oSrcvjwepGYBH9gLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVrmMamcpX+GxvsAUEop/+xOrukz/HD8z1BIg36m3SYsjbBVqZMXW1bSArSn?=
 =?us-ascii?Q?Jsu8wsgvLboyXWtFbtmxRF3tAdC47yYIGQzt/hwlDQAYgACubzNz/KSFCOsR?=
 =?us-ascii?Q?KWf4uC662zqAtC9NySKkhf/dKdYEVw1SukRxNqskH967WlN7PfnSVdRe6Gvz?=
 =?us-ascii?Q?M0XcH2fopQIsPPcGMaOOBdrLO1WxjFRTMEMIQPY4OBllra0LLfh4JDqe797y?=
 =?us-ascii?Q?vEiJmPnC92x0kVXoIuS1sw8M7EejOl1/Glx9DkAFg+KQRW3O7c+1bcfkZd1W?=
 =?us-ascii?Q?4eHOki/oKjwyMTxtvJCISGAlDCKdnpmoxKEA27syUpTm9Xlqj71qyDxp2E8S?=
 =?us-ascii?Q?1wCFjQ9o8y92sYsG/QwuRVxqXqwy+Q4njaGxwfgvGk7yhK0zKgzyGCErvb76?=
 =?us-ascii?Q?5+znGAVtAQNWMC37ThihYxJCiGUBKOUDkx45ASCyW1HUlMWCgLyGqNTvgnnb?=
 =?us-ascii?Q?KxOJ/ZvhUOunwx7ImkIG7Sj0Z8gyB3Q+dEb99EOzV6ebAp0vSuHz072MmFv3?=
 =?us-ascii?Q?UJBoh1SnV+16kG4kw7659+dKemScC5EjcKffVnCIvplX8aa90C3F/G+61kEb?=
 =?us-ascii?Q?NhBu++zVVnZhRxi2AwuIwl7MdgsrOCqOyt+jLp1StO+wAJOamG08F6gWQrfY?=
 =?us-ascii?Q?NxFvfWkVEaLPY2vyYcklmCceEp1zMyZTKbrVMTc05ITzfIomkWdt4FTgs46R?=
 =?us-ascii?Q?098YiEBoHL1y2EIQ2OdFuKWsmoQoX92doJAm8dD15m2cjZAMn/jnTG8KkYrG?=
 =?us-ascii?Q?MeiNcwsXcyYYP7wWNH1tGK/p6wxasLjoDyXfAer/XkXgtsx6IRf/CNwc1cY2?=
 =?us-ascii?Q?1z0JYesWXaWbApq3RqKMutGlgtnTcAN7X5IOB/hvSO5kIjcw1NYARng28fg6?=
 =?us-ascii?Q?tMl6/z7/E6sQV70dc1Qcmjt/7Ku2yRXRfnrmSBtioFlp+gXQcsmuT0T1KG+W?=
 =?us-ascii?Q?jrqBaFKQTVWRbXMlrBfz1hcyDd/uQ14yCQqkR9foYLkJkGpIyNgD0nWV0jP6?=
 =?us-ascii?Q?vx7oJ7CkbPyoTWZ9Vl6OTFtZeaQ6uMU6kKdF/mw8D7M1Vc725FybjJERqryL?=
 =?us-ascii?Q?C/VAxgccw2DXn8PGJ9LEg7sK204ef4vr9NsB7DjpMZyDGjD630jAfahPA6/N?=
 =?us-ascii?Q?60oTCm60lgPmSfEPmZYCWh52PX6CXe3UkrswkNbd043yEOp/01smeQrW/XGE?=
 =?us-ascii?Q?wPTsrM8VkQV9DP/QL4fQRzdvJKwWtdtNUFTsj62E9fpkzTVz+8cItZ1xLk9F?=
 =?us-ascii?Q?ZEpakJJEpwPCTC4AZYzWtcBuiTxE58x2Cy2RReFS1RfJLx2fk9ke4AfuVBfL?=
 =?us-ascii?Q?EgMr56X12mWZPM8IUSDYVtep?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4c50f4-b04a-4345-6305-08d931a98f5c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:17.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzxFfMhVCk87laKSiFaqF+B6wkpBb7C2fV55c2PL9koOXEcfLplU6etDZSUHLLxM6uxSnfBRKcEPC66766skKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_rx.c | 349 +++++++++++++++++++
 1 file changed, 349 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_rx.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_rx.c b/drivers/net/wir=
eless/celeno/cl8k/fw/msg_rx.c
new file mode 100644
index 000000000000..be8a6b13392b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_rx.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/tx.h"
+#include "sounding.h"
+#include "fw/msg_rx.h"
+#include "fw/msg_tx.h"
+#include "fw/msg_cfm.h"
+#include "stats.h"
+#include "rssi.h"
+#include "fw/fw_dbg.h"
+#include "utils/utils.h"
+#include "hw_assert.h"
+#include "rate_ctrl.h"
+#include "bus/pci/ipc.h"
+#include "rsrc_mgmt.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+static inline void rx_mm_start_cfm(struct cl_hw *cl_hw, struct cl_ipc_e2a_=
msg *msg)
+{
+       cl_msg_cfm_clear(cl_hw, msg);
+
+       /* Send indication to the embedded that a new rxbuffer element are =
ready */
+       cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_RXBUF_BAC=
K);
+}
+
+static inline void rx_mm_ba_add_cfm(struct cl_hw *cl_hw, struct cl_ipc_e2a=
_msg *msg)
+{
+       if (le16_to_cpu(msg->id) =3D=3D MM_BA_ADD_TX_CFM)
+               cl_msg_cfm_assign_and_clear(cl_hw, msg);
+       else
+               cl_msg_cfm_clear(cl_hw, msg);
+}
+
+static inline void rx_mm_rsrc_mgmt_cfm(struct cl_hw *cl_hw, struct cl_ipc_=
e2a_msg *msg)
+{
+       struct mm_rsrc_mgmt_cfm *cfm =3D (struct mm_rsrc_mgmt_cfm *)msg->pa=
ram;
+
+       cl_rsrc_mgmt_process_cfm(cl_hw, cfm);
+       cl_msg_cfm_clear(cl_hw, msg);
+}
+
+static inline void rx_mm_agg_tx_report_ind(struct cl_hw *cl_hw, struct cl_=
ipc_e2a_msg *msg)
+{
+       struct cl_agg_tx_report *agg_report =3D (struct cl_agg_tx_report *)=
msg->param;
+       struct cl_sta *cl_sta;
+       union cl_rate_ctrl_info rate_ctrl_info;
+
+       /*
+        * Take care of endianness and update gi and format_mod fields of r=
ate
+        * ctrl info in agg_report for the sake of any function that needs =
to
+        * use them
+        */
+       agg_report->rate_cntrl_info =3D le32_to_cpu(agg_report->rate_cntrl_=
info);
+       agg_report->rate_cntrl_info_he =3D le32_to_cpu(agg_report->rate_cnt=
rl_info_he);
+
+       rate_ctrl_info.word =3D agg_report->rate_cntrl_info;
+
+       cl_rate_ctrl_convert(&rate_ctrl_info);
+       agg_report->rate_cntrl_info =3D rate_ctrl_info.word;
+
+       cl_sta_lock(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, agg_report->sta_idx);
+
+       if (cl_sta) {
+               /* TX stats */
+               cl_agg_tx_report_handler(cl_hw, cl_sta, (void *)agg_report)=
;
+               cl_stats_update_tx_agg(cl_hw, cl_sta, agg_report);
+
+               /* RSSI stats */
+               if (!agg_report->ba_not_received)
+                       cl_rssi_block_ack_handler(cl_hw, cl_sta, agg_report=
);
+
+               /*
+                * TODO: Do we need to notify upper layer at agg_report->su=
ccess?
+                * Ageout may need to reset ageout counter if at least one
+                * frame was success.
+                * May be needed when sending UDP downlink because BA's are=
 not
+                * forwarded to driver.
+                */
+       }
+
+       cl_sta_unlock(cl_hw);
+}
+
+static inline void rx_mm_sounding_ind(struct cl_hw *cl_hw, struct cl_ipc_e=
2a_msg *msg)
+{
+       struct mm_sounding_ind *ind =3D (struct mm_sounding_ind *)msg->para=
m;
+
+       cl_sounding_indication(cl_hw, ind);
+}
+
+static inline void rx_mm_fw_error_ind(struct cl_hw *cl_hw, struct cl_ipc_e=
2a_msg *msg)
+{
+       struct mm_fw_error_ind *ind =3D (struct mm_fw_error_ind *)msg->para=
m;
+
+       switch (ind->error_type) {
+       case MM_FW_ERROR_TYPE_MU_OFDMA_SLOW_SECONDARY:
+               break;
+       case MM_FW_ERROR_TYPE_MAX:
+       default:
+               cl_dbg_err(cl_hw, "Invalid fw error type %u\n", ind->error_=
type);
+               break;
+       }
+}
+
+static inline void rx_mm_idle_async_ind(struct cl_hw *cl_hw, struct cl_ipc=
_e2a_msg *msg)
+{
+       cl_hw->idle_async_set =3D false;
+
+       cl_dbg_trace(cl_hw, "Clear MM_IDLE_ASYNC_IND\n");
+}
+
+static inline void rx_mm_rsrc_mgmt_ind(struct cl_hw *cl_hw, struct cl_ipc_=
e2a_msg *msg)
+{
+       cl_rsrc_mgmt_process_ind(cl_hw, (struct mm_rsrc_mgmt_ind *)msg->par=
am);
+}
+
+static inline void rx_dbg_print_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a=
_msg *msg)
+{
+       cl_hw_assert_print(cl_hw, msg);
+}
+
+static inline void rx_dbg_info_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_=
msg *msg)
+{
+       cl_fw_dbg_handler(cl_hw);
+}
+
+static void (*mm_hdlrs[])(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)=
 =3D {
+       [MM_RESET_CFM]                  =3D cl_msg_cfm_clear,
+       [MM_START_CFM]                  =3D rx_mm_start_cfm,
+       [MM_VERSION_CFM]                =3D cl_msg_cfm_assign_and_clear,
+       [MM_ADD_IF_CFM]                 =3D cl_msg_cfm_assign_and_clear,
+       [MM_REMOVE_IF_CFM]              =3D cl_msg_cfm_clear,
+       [MM_STA_ADD_CFM]                =3D cl_msg_cfm_assign_and_clear,
+       [MM_STA_DEL_CFM]                =3D cl_msg_cfm_clear,
+       [MM_SET_FILTER_CFM]             =3D cl_msg_cfm_clear,
+       [MM_SET_CHANNEL_CFM]            =3D cl_msg_cfm_clear,
+       [MM_SET_DTIM_CFM]               =3D cl_msg_cfm_clear,
+       [MM_SET_BEACON_INT_CFM]         =3D cl_msg_cfm_clear,
+       [MM_SET_BASIC_RATES_CFM]        =3D cl_msg_cfm_clear,
+       [MM_SET_BSSID_CFM]              =3D cl_msg_cfm_clear,
+       [MM_SET_EDCA_CFM]               =3D cl_msg_cfm_clear,
+       [MM_SET_ASSOCIATED_CFM]         =3D cl_msg_cfm_clear,
+       [MM_SET_SLOTTIME_CFM]           =3D cl_msg_cfm_clear,
+       [MM_SET_IDLE_CFM]               =3D cl_msg_cfm_clear,
+       [MM_KEY_ADD_CFM]                =3D cl_msg_cfm_assign_and_clear,
+       [MM_KEY_DEL_CFM]                =3D cl_msg_cfm_clear,
+       [MM_BA_ADD_TX_CFM]              =3D rx_mm_ba_add_cfm,
+       [MM_BA_ADD_RX_CFM]              =3D rx_mm_ba_add_cfm,
+       [MM_BA_DEL_CFM]                 =3D cl_msg_cfm_assign_and_clear,
+       [MM_AVAILABLE_BA_TXQ_CFM]       =3D cl_msg_cfm_assign_and_clear,
+       [MM_UPDATE_RATE_DL_CFM]         =3D cl_msg_cfm_clear,
+       [MM_SET_VNS_CFM]                =3D cl_msg_cfm_clear,
+       [MM_SET_TX_BF_CFM]              =3D cl_msg_cfm_clear,
+       [MM_PHY_RESET_CFM]              =3D cl_msg_cfm_clear,
+       [MM_CONFIG_CCA_CFM]             =3D cl_msg_cfm_clear,
+       [MM_SET_DFS_CFM]                =3D cl_msg_cfm_clear,
+       [MM_SET_ANT_BITMAP_CFM]         =3D cl_msg_cfm_clear,
+       [MM_NDP_TX_CONTROL_CFM]         =3D cl_msg_cfm_clear,
+       [MM_REG_WRITE_CFM]              =3D cl_msg_cfm_clear,
+       [MM_PROT_MODE_CFM]              =3D cl_msg_cfm_clear,
+       [MM_GOTO_POWER_REDUCTION_CFM]   =3D cl_msg_cfm_clear,
+       [MM_SOUNDING_CFM]               =3D cl_msg_cfm_assign_and_clear,
+       [MM_SOUNDING_PAIRING_CFM]       =3D cl_msg_cfm_clear,
+       [MM_SOUNDING_INTERVAL_CFM]      =3D cl_msg_cfm_assign_and_clear,
+       [MM_SOUNDING_STA_SWITCH_CFM]    =3D cl_msg_cfm_assign_and_clear,
+       [MM_BACKUP_BCN_EN_CFM]          =3D cl_msg_cfm_clear,
+       [MM_START_PERIODIC_TX_TIME_CFM] =3D cl_msg_cfm_clear,
+       [MM_ANAMON_READ_CFM]            =3D cl_msg_cfm_assign_and_clear,
+       [MM_REFRESH_PWR_CFM]            =3D cl_msg_cfm_clear,
+       [MM_SET_ANT_PWR_OFFSET_CFM]     =3D cl_msg_cfm_clear,
+       [MM_SET_RATE_FALLBACK_CFM]      =3D cl_msg_cfm_clear,
+       [MM_TWT_SETUP_CFM]              =3D cl_msg_cfm_clear,
+       [MM_TWT_TEARDOWN_CFM]           =3D cl_msg_cfm_clear,
+       [MM_RSRC_MGMT_CFM]              =3D rx_mm_rsrc_mgmt_cfm,
+       [MM_SET_FREQ_OFFSET_CFM]        =3D cl_msg_cfm_clear,
+       [MM_AGG_TX_REPORT_IND]          =3D rx_mm_agg_tx_report_ind,
+       [MM_SOUNDING_IND]               =3D rx_mm_sounding_ind,
+       [MM_FW_ERROR_IND]               =3D rx_mm_fw_error_ind,
+       [MM_IDLE_ASYNC_IND]             =3D rx_mm_idle_async_ind,
+       [MM_RSRC_MGMT_IND]              =3D rx_mm_rsrc_mgmt_ind,
+       [MM_MAX]                        =3D NULL,
+};
+
+#define DBG_MSG_SHIFT(id)  ((id) - FIRST_MSG(TASK_DBG))
+
+static void (*dbg_hdlrs[])(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg=
) =3D {
+       [DBG_MSG_SHIFT(DBG_SET_MOD_FILTER_CFM)]         =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_SET_SEV_FILTER_CFM)]         =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_CE_SET_MOD_FILTER_CFM)]      =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_BEAMFORMING_TX_CFM)]         =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_GET_E2W_STATS_CFM)]          =3D cl_msg_cfm_assi=
gn_and_clear,
+       [DBG_MSG_SHIFT(DBG_SET_LA_MPIF_MASK_CFM)]       =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_SET_LA_TRIG_POINT_CFM)]      =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_CFM)] =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_SET_LA_TRIG_RULE_CFM)]       =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_CFM)]    =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_PRINT_STATS_CFM)]            =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_TRIGGER_CFM)]                =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_TEST_MODE_CFM)]              =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_SOUNDING_CMD_CFM)]           =3D cl_msg_cfm_clea=
r,
+       [DBG_MSG_SHIFT(DBG_PRINT_IND)]                  =3D rx_dbg_print_in=
d,
+       [DBG_MSG_SHIFT(DBG_INFO_IND)]                   =3D rx_dbg_info_ind=
,
+       [DBG_MSG_SHIFT(DBG_MAX)]                        =3D NULL,
+};
+
+static bool is_dbg_msg(u16 msg_id)
+{
+       return (msg_id >=3D FIRST_MSG(TASK_DBG) && msg_id < DBG_MAX);
+}
+
+static void cl_msg_rx_run_mm(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *m=
sg, u16 msg_id)
+{
+       if (msg_id < MM_REQ_CFM_MAX)
+               cl_dbg_trace(cl_hw, "%s\n", msg2str[msg_id]);
+
+       mm_hdlrs[msg_id](cl_hw, msg);
+}
+
+static int cl_msg_rx_run_dbg(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *m=
sg, u16 msg_id)
+{
+       u16 dbg_id =3D DBG_MSG_SHIFT(msg_id);
+
+       if (dbg_hdlrs[dbg_id]) {
+               if (msg_id < DBG_REQ_CFM_MAX) {
+                       u16 str_id =3D DBG_STR_SHIFT(msg_id);
+
+                       cl_dbg_trace(cl_hw, "%s\n", msg2str[str_id]);
+               }
+
+               dbg_hdlrs[dbg_id](cl_hw, msg);
+               return 0;
+       }
+
+       return -1;
+}
+
+static int cl_msg_rx_run(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+       u16 msg_id =3D le16_to_cpu(msg->id);
+
+       if (msg_id < MM_MAX && mm_hdlrs[msg_id]) {
+               cl_msg_rx_run_mm(cl_hw, msg, msg_id);
+               return 0;
+       }
+
+       if (is_dbg_msg(msg_id))
+               return cl_msg_rx_run_dbg(cl_hw, msg, msg_id);
+
+       return -1;
+}
+
+static bool is_cfm_msg(u16 msg_id)
+{
+       /* A confirmation must be an odd id */
+       if ((msg_id & 0x1) =3D=3D 0)
+               return false;
+
+       return ((msg_id < MM_FIRST_IND) || is_dbg_msg(msg_id));
+}
+
+static int cl_msg_rx_handler(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *m=
sg)
+{
+       int ret =3D 0;
+       u16 msg_id =3D le16_to_cpu(msg->id);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_msg_rx_handler_start(cl_hw->idx, msg_id,
+                                           le32_to_cpu(msg->pattern), cl_h=
w->cfm_flags);
+#endif
+       /* Relay further actions to the msg parser */
+       ret =3D cl_msg_rx_run(cl_hw, msg);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "Unexpected msg (%u)\n", msg_id);
+       } else {
+               /* Wake up the queue in case the msg is a confirmation */
+               if (is_cfm_msg(msg_id))
+                       wake_up(&cl_hw->wait_queue);
+       }
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_msg_rx_handler_end(cl_hw->idx, cl_hw->cfm_flags);
+#endif
+
+       return ret;
+}
+
+void cl_msg_rx_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_e2a_msg_elem *msg_elem =3D NULL;
+       struct cl_ipc_e2a_msg *msg =3D NULL;
+       int msg_handled =3D 0;
+       u8 idx;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_msg_rx_tasklet_start(cl_hw->idx);
+#endif
+
+       while (1) {
+               idx =3D ipc_env->e2a_msg_host_idx;
+               msg_elem =3D (struct cl_e2a_msg_elem *)(ipc_env->e2a_msg_ho=
stbuf_array[idx].hostid);
+               msg =3D msg_elem->msgbuf_ptr;
+
+               /* Look for pattern which means that this hostbuf has been =
used for a MSG */
+               if (le32_to_cpu(msg->pattern) !=3D IPC_E2A_MSG_VALID_PATTER=
N)
+                       break;
+
+               cl_msg_rx_handler(cl_hw, msg);
+               msg_handled++;
+
+               /* Reset the msg element and re-use it */
+               msg->pattern =3D 0;
+
+               /* Make sure memory is written before push to HW */
+               wmb();
+
+               /* Push back the buffer */
+               cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->=
dma_addr);
+       }
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_msg_rx_tasklet_end(cl_hw->idx, msg_handled);
+#endif
+}
+
+void cl_msg_rx_flush_all(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       for (i =3D FIRST_MSG(TASK_MM); i < MM_MAX; i++) {
+               if (cl_hw->msg_cfm_params[i]) {
+                       cl_dbg_verbose(cl_hw, "free MM msg_cfm_params %d\n"=
, i);
+                       cl_msg_tx_free_cfm_params(cl_hw, i);
+               }
+       }
+
+       for (i =3D FIRST_MSG(TASK_DBG); i < DBG_MAX; i++) {
+               if (cl_hw->msg_cfm_params[i]) {
+                       cl_dbg_verbose(cl_hw, "free DBG msg_cfm_params %d\n=
", i);
+                       cl_msg_tx_free_cfm_params(cl_hw, i);
+               }
+       }
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

