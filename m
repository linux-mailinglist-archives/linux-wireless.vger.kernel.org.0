Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093113AB87F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhFQQIY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:24 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:5985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232753AbhFQQHj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy38wVEgKOcFh7P4Izs7GS9FVNT/gtlafo5z2/gV5o36msFmAdPiU7TyI3tGMkDIcYxvrjPe1IIt3cO0Bdoq4F6DuHgOZVje3yUyaWpPDYERSyXxQmeRM/+1JxKxCs6qugGWG13HKBlfvvaY3ffA3BLsH9/5kO9KH/NznHzlK53vlxXY0hvqNbAnSeYQm4FKvwhRxOzZ4fBUGbBvGYQPISHWFGCQN3Sn8vaLux8IYX08zEIB0XI1EFt/I9A/yFCCxH3+zud1C3xNo9dRuOY67f32qALQwecIeQS9KrZqVU6zp537Ow08vr1wJ46fGgNQlIof8E9kF8cDu9dIu0iqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vls5zIUPBVacqEklLtbh8Oz3geRcJ/i5VeDcAFAlyk=;
 b=BfjlQykK/rWBNiW9honCaB59+/1xAhtGW6f7akXuKyuikRFYxxvuQsAcKAjV2CrMm4sJda7n9rg6AshgJPNEayYg5Q6OmyxCooAnw9i3pdbqTHcU//lBijgCoucntkOVfMDD8pb1/PxiceoDasMt1kiJR9IXgjpQHvAnWwEyCZkrk7ElGUfPqse1nuFLpMB1iYephpcYAF5spFh+0LNWFR8LihuCr0ZcP1A1ymvsmB9CzRZO6EvA+O9yYFFLuca54LjhFCy7iDq4ZxOpnIxt5ZcPjt7mkHc9lEAhpi1Uiv0qTSCcqOOpgn3HwT2wsTCg/LzqqdnU9lKBB11jqJJm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vls5zIUPBVacqEklLtbh8Oz3geRcJ/i5VeDcAFAlyk=;
 b=ARsL+/+sM/tNRhAD1sOqO12iZ7ii33kVSPWiMIHK3ChIbaYx59YG9BdGjZd4GsORtJ5tfKGgqZArX5jN8WV2DmK/7sOUQNeOytdbPIicVLvfaJ2p4EahH4GO0IkCyAd+8WCoYDpZzd0VhXVaqVq/8PHl9+CnG9vpRIW1Dc+TxmM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:28 +0000
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
Subject: [RFC v1 087/256] cl8k: add fw/fw_dbg.h
Date:   Thu, 17 Jun 2021 15:59:34 +0000
Message-Id: <20210617160223.160998-88-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c988c501-bf57-40ae-e0a3-08d931a98ad8
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871A7A40E0BB1D3F93F32ACF60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31o+unXnlMMzfS0teQfA53y0Xk5Knd3C8Cv5jE0O1J4PcQrmJj0wXFhFuLmAZNsDQ8KD5Ld6pq2+KPR49d1Eogk0mjDMiPzryH/85d8ZJx2jICvEwzSgJYnp8RlhBTOWbDVYlbLWRnbmz4PshGHLUNDqzDbwr3T+fqY9UDlm/iQ86QVtuxFIuGg3XKdZ1qaLbKxSHnOjh/0Ugpe86snBn2jZZAd4e9orb8f5f+HBITO1WhzJWrDacFXi3d2qWiIs23rN9gfNbPq5QiFaOUla62a8U/bN/xGDxciwlIoS4P/zIyQnpZM7RRHov1ZD9N7Vp+hK2qIOvSRbuVzvP97V0iED8vqaoQw+/otBmGl9RJd2e/BzoJr46U6Kc5aHk6jkYEHJm8R7CmjZmISPVgCeOaXZQs3sqUAbunuUOp/uEUmsM2FKrhj/trGbSd55MMFpjp5cuO9/1beNdcu+cdfIDvhmlbqcuckAb6xbHlUC7v0OWvCLc7Y+naDIWO8khT0YnpapaQX5TCIAGzKFkba1SRK2oYqR/ePBU0SIuGOokzCL/EvSvVisRAYSYbOUN48bD4jzeXxITLgX6uHOP6Mv5KnGsY0GmZqx22ativZl65nyVq93ubbV38NXmoR1TGFw6/uPKebyyeW3qvPorw8/Gy7TjtC/4a2rDLRXyylPVKuFi05hpE1ULJOhb6/9EHal/unVm+A6KD0xcyKrlQZXZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?joM43wIgfBIoc0T+Q//oVbBf8U96Za+r/do3i76KPLmL5fGMP6LvF6fJBQaV?=
 =?us-ascii?Q?iKeut10Iwi+IM5NPU81zcZyS2ZdGVF6JYzwUNnIPdjHl+KgQCJY5K1SQGlCT?=
 =?us-ascii?Q?4t6wQkfsbUe3iNee9RlZhiupvnOuacuEOSuCsFJ/oPpI86Thd8SjYlZvV5dP?=
 =?us-ascii?Q?855z9EDPeVoe6RN8xjO1wgsufoIArYNGiz7ZvSUSXAUuPofiyCJdWVvc3aaK?=
 =?us-ascii?Q?hP8SHxEye+8xlIDMe+f+g+sxQ/BiyUS6Hk2i8gMHUfV54oJPClSR2sFjbE4e?=
 =?us-ascii?Q?3QrjxrNe2+fmWPB+Yz335Nb7m0EBHiZhBQe2268lbLCvVL2fhi3XHequLi9f?=
 =?us-ascii?Q?KkVq10SC8Pu10Nrq8P34AkcOOdVH34eGx0RpachEQLVizRpST7VONpkWgHui?=
 =?us-ascii?Q?jI8igV8DveDwTfmCe+nJJ1HK31PT5jUa9sFBQm90cb9xSDDSh8/gVhlJdVt3?=
 =?us-ascii?Q?Bziemc3U1VAP9lDfpUXS3iM9Mb34RLgO/VENren/KttfT3Ml12Ckfhvq6FnZ?=
 =?us-ascii?Q?IgUbfKVT0KyobSMbcxoUAycbpveC1Qi+fVbrcLrzCPMr9urUyBfkH10EgvxC?=
 =?us-ascii?Q?/HRFj4F2XCjf8zHGmvAdqyuvVVhg11/xmK8fJDGOStSSg46aE1VsV07qsee9?=
 =?us-ascii?Q?lmuZ0huOZkO27NXK8UlLlcQb5QIu90VZ7u7FEBfF3VWGlA7aLgxxFHfK94wb?=
 =?us-ascii?Q?wmB/LhT60Pj2zBmaYrIdVSfffL7Y7ua0UTuxqmNAzAVwM93zPoNSvaDw2gSb?=
 =?us-ascii?Q?91M7mDXTih8uyKVtk0tmszgHQI6sVcB3txq2iL0mwSYP+4hREp3JZDV5fLO8?=
 =?us-ascii?Q?9w5ODtmqrrqGvNtpBFJA5EQzUnS13aVpB8XzouyCfyeg/eyOah/kdXzxG9z4?=
 =?us-ascii?Q?morqDfE8k6/TqumiMTn5coCBwdikSFASTUpqoZ9UC9UydemgbBwF2wr+PmhX?=
 =?us-ascii?Q?rg5+m2s77/GZsDBs6Jn398D48BCDCUZlEBVs7t8/SVnpOc9ped3BgyKsr9nz?=
 =?us-ascii?Q?EWaIITPptPo+44LA2IpRaRvsafNMrkKnK8H/Wta/8XR/mXysh1fH2jH8GJfR?=
 =?us-ascii?Q?yUzCssbMWQWfCMon7WbNWvkTt7DWeaicpwdrphaYrPzm2WO2fHcxsPCkIuch?=
 =?us-ascii?Q?56yo2L6Q5B7VlDW2jomSsuoa9PVTOugu2QWFsK4kB3YS9DKD5zV0AH3hPCdi?=
 =?us-ascii?Q?MDLzADlDkjo7d7W7tQWzEYP2qOV4ma0Kl6YcszuAUMQsEAW3HhMRUBJbwgRS?=
 =?us-ascii?Q?DxYU2r+tj2jXwDwPtL000qnZP3nq5mxcfgZJEQ2+RuFyCZYgJ0WFWKC04B4Z?=
 =?us-ascii?Q?NoxvycUurcfswfVPO+zvyqkv?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c988c501-bf57-40ae-e0a3-08d931a98ad8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:09.9653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pQ/4fWxeq1Roq/V2vep42yEQ9f/gz1FyNwEnnsgNb5meL/7tbby4jzYJBzWRCcKEpJRoYDbi9PqT1uOk8v/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h b/drivers/net/wir=
eless/celeno/cl8k/fw/fw_dbg.h
new file mode 100644
index 000000000000..a35b63fece63
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FW_DBG_H
+#define CL_FW_DBG_H
+
+#include "hw.h"
+
+enum {
+       DBG_INFO_DUMP =3D 1,
+       DBG_INFO_TX_STATS,
+       DBG_INFO_BCN_STATS,
+       DBG_INFO_RX_STATS,
+       DBG_INFO_DYN_CAL_STATS,
+       DBG_INFO_RATE_FALLBACK_STATS,
+       DBG_INFO_BF,
+       DBG_INFO_TRIGGER_FLOW,
+       DBG_INFO_MAX,
+       DBG_INFO_UNSET =3D DBG_INFO_MAX
+};
+
+void cl_fw_dbg_handler(struct cl_hw *cl_hw);
+int cl_fw_dbg_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+void cl_fw_dbg_trigger_based_init(struct cl_hw *cl_hw);
+void cl_fw_dbg_trigger_based_update(struct cl_hw *cl_hw, struct hw_rxhdr *=
rxhdr,
+                                   struct ieee80211_hdr *hdr);
+void cl_fw_dbg_trigger_based_reset(struct cl_hw *cl_hw);
+struct cl_coredump *cl_fw_dbg_prepare_coredump(struct cl_hw *cl_hw);
+
+#endif /* CL_FW_DBG_H */
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

