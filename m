Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6A3AB863
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhFQQHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:38 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhFQQHK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1Nkzh+W8EzFun11XBcKDnYKGHDHpcrnCSwt6me1GQGcOKmu7b5ywsdudlMYpNv2fnLCr6Y2HJOokwo3GtIhrMlaUKnnEpuDjrMfJPSU+GIiOmlJPixCpsabv1caKsbzXh+bgQndVluG8OyEJGp7EezWTs8OjQAokXtbA0yigC1fzautlXS0dSR+Rqn/YKmQAKNQrGEls2dzc5NMzzcHGM0OaWTTxAai2G7ci0en/dNLKyf0jM/MlCtDpB2Y6sOFK9rK+9UC7aiJbBMwlTSl3sOmp8GIXz9l+xJQpEEMz/q/huepo0HmZYWm3mx7VMiQz/NT5AIIxBeMojfeJ1RoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrv3iuaP852mOWsYC0loc/ZVaVrv5W+Ynsl/vmTTY80=;
 b=Qt3JsNBE71QA858Ls3cBD/S8glGxBNngBnxS+Z8ewDuk41Jqk9tram+m4M2QogXz+z6CjAsgVVFg+1OMU/4KCN6+GzWs8cKLh89gWMWsyKfZIZFOHFQtkEUq5SdUWZi7JRAkTtO/7V3kBANvXuQEcZ6PV8PyzDHPAX0+e48O5gWZcSA+/MByfhu/WjcC2NHfJTZCn74iU7Joizm0b5nMqAWk3CtaK/OMtYbO6uWuSyVbGjLnntShPUZ/KkyVi9QVlKE1YNPShUBMkxgeEr7jxf+4AqotXe+0uqjS7BL2Z7JDtI/ODxm834RehCzWNdMlXM6NOs4BNcnf1JwXKP5RIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrv3iuaP852mOWsYC0loc/ZVaVrv5W+Ynsl/vmTTY80=;
 b=UkvI4r10z2PbIAimouBm3I8iiuyTBu9qzrsOHjTMm/iuQjwiFy4BZCUoEGGesda1TIrmxf+yb+BRCgK9btwkebsFo1r702wgTRd5sfmp0Xny2OyIC1ZxtWLcLZukppY7F8dDox6yNhr22kfid5XL4PBs9uXrLvOJHqZ5teLQY/o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:00 +0000
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
Subject: [RFC v1 090/256] cl8k: add fw/fw_msg.c
Date:   Thu, 17 Jun 2021 15:59:37 +0000
Message-Id: <20210617160223.160998-91-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82ef4259-40b4-40e4-42c5-08d931a98ca6
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB088707062B962DBB8A81CF2DF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CsGaR2OX9IvoTleaA1hgr6pnOSTd3v3HgUFeDBQDhX3Bf8PnBxini5R3U3z4pSdQ0QQ/ovGNs6IvoUpuNSUIhUZqyBzSXo1tTNuT5gKYhYRszI7yEwr8aDb3b28bWDJJsdFO7o4yaqH1S+VB2EqSPKZQF/1N2uDrZIE6V1ChUnice2BWZgmeVCUYkaKAJ1OTPokONdZ03U30ZgA2ntpNOcp79vr6zC2DmiPUf6jfziORKylUTtHzO+rfGZgQQ9pj/NIEq4fhtrIRzkzlHfN1mSoRMzKlopk0R66+JREZip+aeb1PedMY74SEoGDEMiV1oX27WsOsyiSfGGnQYUQyhy12shsTaDdxyfRJVe1g8slRdsgPv455YHwujpfKyuP+tp0rPQnqkeMOSkMyWn3dJh/IuKPDA36ORXNeDOHCYpnS5gtf/ofo1W6eJhADNuOXglEXQrqvIRb0TDDXW4ikTzoi+JU1hcnfjyMtdRlZPTaHxNCmEawEzzEQYtkTadbfN8609Td7nChwJfdHNexh0ySfmzf1hS/gU7JtE1eeWs380JnVKeAL8fJD3ynWvKYQUmXfYSxUgzGl8rg+2l6pA52CoTeSl6gnsz3aDCgb7KLukCBmlx7x0P7cts6wFfB2+oVeHwOFbRfqTe4vKbDNl7mQ29e2XTsgvimrAz65SkDsFPsbZ/N9o8RVbJnzjbWxdllD7zlYE/4EykDTlwngg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3i0Nto5GLQDa6tpkkF1Agjb6prbTcGQMf2A8mqktUP5vZpc/ShER3ew5bEO?=
 =?us-ascii?Q?FrFcxa9+1SEzKFTICy8gPrMZTpSkb4Hej/88vh4WppJS32T0l4cALGwReKxE?=
 =?us-ascii?Q?5HVH+mlBNTQovARXIcaFkqAiiAITDow6RJwpryjLZCw4jpmB2NC3SAvd6OLp?=
 =?us-ascii?Q?6uj6qJ4YA4eEA/gGdMLyVPC3MR/FJxU9vrKWgXCllydBvWKCfbObTcVvXnCS?=
 =?us-ascii?Q?Ziibq9CfpCAx6IUrv8X3EoqtLN0hmkHi2Ept3Vi1GYpadV+nsXGjZuNILXXk?=
 =?us-ascii?Q?DzGT1fiv/OZUB/TBsqjNc+eM4N8jw0jHUgTjuUFsx5W/Ck8fZN5R0aV+LA72?=
 =?us-ascii?Q?XQ9cNjCVKX9DNEaVUdBq+ngpoNh2xy6+KougWkDk+J/yHxFpY/GJ+CRdx4ou?=
 =?us-ascii?Q?0TxT+cBDtwcVHHRqbe6vRNa2JbkSfbLQCFCU/IdLi7AK0B3EVUYyuFHKJHlo?=
 =?us-ascii?Q?PqaPUHYEaKld8W79Z/K98O4s0B60nImOmHXHiwtyn8vfMsVmdq4sJveMwzdj?=
 =?us-ascii?Q?9femyBApsOWsSGUN1HrBarO4u9GJaWcx92x3ts9Gy5nzjM8VsnFQMgJtcAHV?=
 =?us-ascii?Q?/pvccZOgf1X+pvtpY0VXSMaVVlQIjAC0S7vMxiN6bwGNYtowJ4rBR/nthFt5?=
 =?us-ascii?Q?s2MCAIk5FVsDCwuoT5t8phVvmoTZVAZFqrCzFa+HD0KpwrB+dr57M+oYfeBO?=
 =?us-ascii?Q?yZpYqZbkUKoHpLwIhL8GLGRTQiUPRdSXk3fOoIttthtTbdzG9N52AULkmzkp?=
 =?us-ascii?Q?WrFu/qliHFJ713iJY1zPEgXsXqa+3InzKU8bdAhjK9V3wjLpXc2KmxpmrKY1?=
 =?us-ascii?Q?B9Gl2acgN0H0XMYfo+Jsd2VUOLiCZorKNmceNEny8NaaeJ1LKJmAYtTQE80c?=
 =?us-ascii?Q?Z+3LfUOsJqOGOyW5R2GXnwWuN0Y4o6NBlaS/Abq/zGX/iYwaQWfDCgVYjzR5?=
 =?us-ascii?Q?tJPNAp5AZUh93JO/12TgSJAE+t7dRqAARge1SoSparRqw6ggCBc3TXHpn1E4?=
 =?us-ascii?Q?e9b06LV5yCs4w1wKg24AP9DG7Nth4l9YuSTOvb9SSPa966dR7NX4Wv6vPveI?=
 =?us-ascii?Q?ukxXZ2Bmo0otK0qx4ATicOYSD7D6TtsQsfQqHonZJ6EuySdkoA277093usrW?=
 =?us-ascii?Q?YV2wgVj9W7TpcGcQPCUnD2nZhgDW93Lnne6YdftcM+0A7nV8OBtTS3XZnbso?=
 =?us-ascii?Q?nRVh0UjiQRp3RvyefU3SQ3CmNhhqGZ5PpdJTnHMP5ZxycsyisTBGyM20P77+?=
 =?us-ascii?Q?ghSYfKwIn2nfsXK0BHLRd9uV+fl94kiL8McnKZLS7bdF+/iEcPitU51T/rat?=
 =?us-ascii?Q?JMpRY1KzgI1dzLGe5jJl6dG/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef4259-40b4-40e4-42c5-08d931a98ca6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:12.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtbVf95s3hUFqMqTvwTBAc9V1wjS+atn2Pd8PifY6f/7Bb9bkhO2iJvDf/O5iBbT8QAY12lcOSDwQAFcN45OFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_msg.c | 135 +++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_msg.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_msg.c b/drivers/net/wir=
eless/celeno/cl8k/fw/fw_msg.c
new file mode 100644
index 000000000000..ea59bf57fa97
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_msg.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "fw/fw_msg.h"
+
+/* Should be used for REQ and CFM only */
+const char *const msg2str[MSG_TOTAL_REQ_CFM] =3D {
+       /* MM messages */
+       [MM_RESET_REQ] =3D "MM_RESET_REQ",
+       [MM_RESET_CFM] =3D "MM_RESET_CFM",
+       [MM_START_REQ] =3D "MM_START_REQ",
+       [MM_START_CFM] =3D "MM_START_CFM",
+       [MM_VERSION_REQ] =3D "MM_VERSION_REQ",
+       [MM_VERSION_CFM] =3D "MM_VERSION_CFM",
+       [MM_ADD_IF_REQ] =3D "MM_ADD_IF_REQ",
+       [MM_ADD_IF_CFM] =3D "MM_ADD_IF_CFM",
+       [MM_REMOVE_IF_REQ] =3D "MM_REMOVE_IF_REQ",
+       [MM_REMOVE_IF_CFM] =3D "MM_REMOVE_IF_CFM",
+       [MM_STA_ADD_REQ] =3D "MM_STA_ADD_REQ",
+       [MM_STA_ADD_CFM] =3D "MM_STA_ADD_CFM",
+       [MM_STA_DEL_REQ] =3D "MM_STA_DEL_REQ",
+       [MM_STA_DEL_CFM] =3D "MM_STA_DEL_CFM",
+       [MM_SET_FILTER_REQ] =3D "MM_SET_FILTER_REQ",
+       [MM_SET_FILTER_CFM] =3D "MM_SET_FILTER_CFM",
+       [MM_SET_CHANNEL_REQ] =3D "MM_SET_CHANNEL_REQ",
+       [MM_SET_CHANNEL_CFM] =3D "MM_SET_CHANNEL_CFM",
+       [MM_SET_DTIM_REQ] =3D "MM_SET_DTIM_REQ",
+       [MM_SET_DTIM_CFM] =3D "MM_SET_DTIM_CFM",
+       [MM_SET_BEACON_INT_REQ] =3D "MM_SET_BEACON_INT_REQ",
+       [MM_SET_BEACON_INT_CFM] =3D "MM_SET_BEACON_INT_CFM",
+       [MM_SET_BASIC_RATES_REQ] =3D "MM_SET_BASIC_RATES_REQ",
+       [MM_SET_BASIC_RATES_CFM] =3D "MM_SET_BASIC_RATES_CFM",
+       [MM_SET_BSSID_REQ] =3D "MM_SET_BSSID_REQ",
+       [MM_SET_BSSID_CFM] =3D "MM_SET_BSSID_CFM",
+       [MM_SET_EDCA_REQ] =3D "MM_SET_EDCA_REQ",
+       [MM_SET_EDCA_CFM] =3D "MM_SET_EDCA_CFM",
+       [MM_SET_ASSOCIATED_REQ] =3D "MM_SET_ASSOCIATED_REQ",
+       [MM_SET_ASSOCIATED_CFM] =3D "MM_SET_ASSOCIATED_CFM",
+       [MM_SET_SLOTTIME_REQ] =3D "MM_SET_SLOTTIME_REQ",
+       [MM_SET_SLOTTIME_CFM] =3D "MM_SET_SLOTTIME_CFM",
+       [MM_SET_IDLE_REQ] =3D "MM_SET_IDLE_REQ",
+       [MM_SET_IDLE_CFM] =3D "MM_SET_IDLE_CFM",
+       [MM_KEY_ADD_REQ] =3D "MM_KEY_ADD_REQ",
+       [MM_KEY_ADD_CFM] =3D "MM_KEY_ADD_CFM",
+       [MM_KEY_DEL_REQ] =3D "MM_KEY_DEL_REQ",
+       [MM_KEY_DEL_CFM] =3D "MM_KEY_DEL_CFM",
+       [MM_BA_ADD_TX_REQ] =3D "MM_BA_ADD_TX_REQ",
+       [MM_BA_ADD_TX_CFM] =3D "MM_BA_ADD_TX_CFM",
+       [MM_BA_ADD_RX_REQ] =3D "MM_BA_ADD_RX_REQ",
+       [MM_BA_ADD_RX_CFM] =3D "MM_BA_ADD_RX_CFM",
+       [MM_BA_DEL_REQ] =3D "MM_BA_DEL_REQ",
+       [MM_BA_DEL_CFM] =3D "MM_BA_DEL_CFM",
+       [MM_PHY_RESET_REQ] =3D "MM_PHY_RESET_REQ",
+       [MM_PHY_RESET_CFM] =3D "MM_PHY_RESET_CFM",
+       [MM_AVAILABLE_BA_TXQ_REQ] =3D "MM_AVAILABLE_BA_TXQ_REQ",
+       [MM_AVAILABLE_BA_TXQ_CFM] =3D "MM_AVAILABLE_BA_TXQ_CFM",
+       [MM_UPDATE_RATE_DL_REQ] =3D "MM_UPDATE_RATE_DL_REQ",
+       [MM_UPDATE_RATE_DL_CFM] =3D "MM_UPDATE_RATE_DL_CFM",
+       [MM_SET_VNS_REQ] =3D "MM_SET_VNS_REQ",
+       [MM_SET_VNS_CFM] =3D "MM_SET_VNS_CFM",
+       [MM_SET_TX_BF_REQ] =3D "MM_SET_TX_BF_REQ",
+       [MM_SET_TX_BF_CFM] =3D "MM_SET_TX_BF_CFM",
+       [MM_SOUNDING_REQ] =3D "MM_SOUNDING_REQ",
+       [MM_SOUNDING_CFM] =3D "MM_SOUNDING_CFM",
+       [MM_SOUNDING_PAIRING_REQ] =3D "MM_SOUNDING_PAIRING_REQ",
+       [MM_SOUNDING_PAIRING_CFM] =3D "MM_SOUNDING_PAIRING_CFM",
+       [MM_SOUNDING_INTERVAL_REQ] =3D "MM_SOUNDING_INTERVAL_REQ",
+       [MM_SOUNDING_INTERVAL_CFM] =3D "MM_SOUNDING_INTERVAL_CFM",
+       [MM_SOUNDING_STA_SWITCH_REQ] =3D "MM_SOUNDING_STA_SWITCH_REQ",
+       [MM_SOUNDING_STA_SWITCH_CFM] =3D "MM_SOUNDING_STA_SWITCH_CFM",
+       [MM_CONFIG_CCA_REQ] =3D "MM_CONFIG_CCA_REQ",
+       [MM_CONFIG_CCA_CFM] =3D "MM_CONFIG_CCA_CFM",
+       [MM_SET_DFS_REQ] =3D "MM_SET_DFS_REQ",
+       [MM_SET_DFS_CFM] =3D "MM_SET_DFS_CFM",
+       [MM_SET_ANT_BITMAP_REQ] =3D "MM_SET_ANT_BITMAP_REQ",
+       [MM_SET_ANT_BITMAP_CFM] =3D "MM_SET_ANT_BITMAP_CFM",
+       [MM_NDP_TX_CONTROL_REQ] =3D "MM_NDP_TX_CONTROL_REQ",
+       [MM_NDP_TX_CONTROL_CFM] =3D "MM_NDP_TX_CONTROL_CFM",
+       [MM_REG_WRITE_REQ] =3D "MM_REG_WRITE_REQ",
+       [MM_REG_WRITE_CFM] =3D "MM_REG_WRITE_CFM",
+       [MM_PROT_MODE_REQ] =3D "MM_PROT_MODE_REQ",
+       [MM_PROT_MODE_CFM] =3D "MM_PROT_MODE_CFM",
+       [MM_GOTO_POWER_REDUCTION_REQ] =3D "MM_GOTO_POWER_REDUCTION_REQ",
+       [MM_GOTO_POWER_REDUCTION_CFM] =3D "MM_GOTO_POWER_REDUCTION_CFM",
+       [MM_BACKUP_BCN_EN_REQ] =3D "MM_BACKUP_BCN_EN_REQ",
+       [MM_BACKUP_BCN_EN_CFM] =3D "MM_BACKUP_BCN_EN_CFM",
+       [MM_START_PERIODIC_TX_TIME_REQ] =3D "MM_START_PERIODIC_TX_TIME_REQ"=
,
+       [MM_START_PERIODIC_TX_TIME_CFM] =3D "MM_START_PERIODIC_TX_TIME_CFM"=
,
+       [MM_ANAMON_READ_REQ] =3D "MM_ANAMON_READ_REQ",
+       [MM_ANAMON_READ_CFM] =3D "MM_ANAMON_READ_CFM",
+       [MM_REFRESH_PWR_REQ] =3D "MM_REFRESH_PWR_REQ",
+       [MM_REFRESH_PWR_CFM] =3D "MM_REFRESH_PWR_CFM",
+       [MM_SET_ANT_PWR_OFFSET_REQ] =3D "MM_SET_ANT_PWR_OFFSET_REQ",
+       [MM_SET_ANT_PWR_OFFSET_CFM] =3D "MM_SET_ANT_PWR_OFFSET_CFM",
+       [MM_SET_RATE_FALLBACK_REQ] =3D "MM_SET_RATE_FALLBACK_REQ",
+       [MM_SET_RATE_FALLBACK_CFM] =3D "MM_SET_RATE_FALLBACK_CFM",
+       [MM_TWT_SETUP_REQ] =3D "MM_TWT_SETUP_REQ",
+       [MM_TWT_SETUP_CFM] =3D "MM_TWT_SETUP_CFM",
+       [MM_TWT_TEARDOWN_REQ] =3D "MM_TWT_TEARDOWN_REQ",
+       [MM_TWT_TEARDOWN_CFM] =3D "MM_TWT_TEARDOWN_CFM",
+       [MM_RSRC_MGMT_REQ] =3D "MM_RSRC_MGMT_REQ",
+       [MM_RSRC_MGMT_CFM] =3D "MM_RSRC_MGMT_CFM",
+       [MM_SET_FREQ_OFFSET_REQ] =3D "MM_SET_FREQ_OFFSET_REQ",
+       [MM_SET_FREQ_OFFSET_CFM] =3D "MM_SET_FREQ_OFFSET_CFM",
+
+       /* DBG messages */
+       [DBG_STR_SHIFT(DBG_SET_MOD_FILTER_REQ)] =3D "DBG_SET_MOD_FILTER_REQ=
",
+       [DBG_STR_SHIFT(DBG_SET_MOD_FILTER_CFM)] =3D "DBG_SET_MOD_FILTER_CFM=
",
+       [DBG_STR_SHIFT(DBG_CE_SET_MOD_FILTER_REQ)] =3D "DBG_CE_SET_MOD_FILT=
ER_REQ",
+       [DBG_STR_SHIFT(DBG_CE_SET_MOD_FILTER_CFM)] =3D "DBG_CE_SET_MOD_FILT=
ER_CFM",
+       [DBG_STR_SHIFT(DBG_SET_SEV_FILTER_REQ)] =3D "DBG_SET_SEV_FILTER_REQ=
",
+       [DBG_STR_SHIFT(DBG_SET_SEV_FILTER_CFM)] =3D "DBG_SET_SEV_FILTER_CFM=
",
+       [DBG_STR_SHIFT(DBG_BEAMFORMING_TX_REQ)] =3D "DBG_BEAMFORMING_TX_REQ=
",
+       [DBG_STR_SHIFT(DBG_BEAMFORMING_TX_CFM)] =3D "DBG_BEAMFORMING_TX_CFM=
",
+       [DBG_STR_SHIFT(DBG_GET_E2W_STATS_REQ)] =3D "DBG_GET_E2W_STATS_REQ",
+       [DBG_STR_SHIFT(DBG_GET_E2W_STATS_CFM)] =3D "DBG_GET_E2W_STATS_CFM",
+       [DBG_STR_SHIFT(DBG_SET_LA_MPIF_MASK_REQ)] =3D "DBG_SET_LA_MPIF_MASK=
_REQ",
+       [DBG_STR_SHIFT(DBG_SET_LA_MPIF_MASK_CFM)] =3D "DBG_SET_LA_MPIF_MASK=
_CFM",
+       [DBG_STR_SHIFT(DBG_SET_LA_TRIG_POINT_REQ)] =3D "DBG_SET_LA_TRIG_POI=
NT_REQ",
+       [DBG_STR_SHIFT(DBG_SET_LA_TRIG_POINT_CFM)] =3D "DBG_SET_LA_TRIG_POI=
NT_CFM",
+       [DBG_STR_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_REQ)] =3D "DBG_SET_LA_MPI=
F_DEBUG_MODE_REQ",
+       [DBG_STR_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_CFM)] =3D "DBG_SET_LA_MPI=
F_DEBUG_MODE_CFM",
+       [DBG_STR_SHIFT(DBG_SET_LA_TRIG_RULE_REQ)] =3D "DBG_SET_LA_TRIG_RULE=
_REQ",
+       [DBG_STR_SHIFT(DBG_SET_LA_TRIG_RULE_CFM)] =3D "DBG_SET_LA_TRIG_RULE=
_CFM",
+       [DBG_STR_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_REQ)] =3D "DBG_TX_TRACE_DEBU=
G_FLAG_REQ",
+       [DBG_STR_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_CFM)] =3D "DBG_TX_TRACE_DEBU=
G_FLAG_CFM",
+       [DBG_STR_SHIFT(DBG_PRINT_STATS_REQ)] =3D "DBG_PRINT_STATS_REQ",
+       [DBG_STR_SHIFT(DBG_PRINT_STATS_CFM)] =3D "DBG_PRINT_STATS_CFM",
+       [DBG_STR_SHIFT(DBG_TRIGGER_REQ)] =3D "DBG_TRIGGER_REQ",
+       [DBG_STR_SHIFT(DBG_TRIGGER_CFM)] =3D "DBG_TRIGGER_CFM",
+       [DBG_STR_SHIFT(DBG_TEST_MODE_REQ)] =3D "DBG_TEST_MODE_REQ",
+       [DBG_STR_SHIFT(DBG_TEST_MODE_CFM)] =3D "DBG_TEST_MODE_CFM",
+       [DBG_STR_SHIFT(DBG_SOUNDING_CMD_REQ)] =3D "DBG_SOUNDING_CMD_REQ",
+       [DBG_STR_SHIFT(DBG_SOUNDING_CMD_CFM)] =3D "DBG_SOUNDING_CMD_CFM",
+};
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

