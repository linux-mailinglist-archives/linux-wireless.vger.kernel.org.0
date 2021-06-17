Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8A3AB8BA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhFQQKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:06 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:56046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231560AbhFQQJE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAwKzYiUSZ64HahSEKz4fFuk9S6tl2E6cqgF5kUeRDHwHUi4OmbSk17cfLPsttVdcpF2OfTq0a6+psCaC15RxzRwWgWvnKlsObrIRBdbUOJ7u/Xuc+NbEGUGHqGng7yFYDK/NShc+R86EFBkyVUvPyCYEYHf5tsjKhRA0nkgUQ44EIFSiY/Kpykw/iHjhGdoE2TPppvi+hFXqbMqkJqCF+t09W2AvkvfULgeBvOvKWNbLAuhFvNusSta8+LDxcxAznNr+h4KE8pbpXi2FrvMY+WHntBoCuvFCT+TQm2OEUtVEzB6LOb8t6ausn0kYHAkmOIuZxsVPgW9gwGeY30nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDCgxlAHrdIZjNA6d4trn0H2uoexJBlJTlkBnIjgOko=;
 b=UA3afv5fr5a6afBDeUZ/g2Tb412ysg8aXGbA5H9QH//hvj3dmq6zXF4rMl8Sx4CO5a56Fq/L6n/f3djVlKJvpDu64zKquHD1KUOLOx5LgUuZ0RhGq+D3M7dLcM53iI1SaThr5dxaFFw9fY48uu6HzmYagXvX0J9QbpOEb4QTZJpvasqZFTYKZLKp/uOWx5vBPYlgMAhghcngSJhNZb4XgEHXexbX51wFj2vPOmGgjNxoRnHlwJv25lpuP1umRn884Y9QWhNKTSsS0PG/7O09W7pxQywbew7o+JFdxUcu3ycTKfprzgJib16X7NldPDZel3EsVieL06weAxQCqUcQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDCgxlAHrdIZjNA6d4trn0H2uoexJBlJTlkBnIjgOko=;
 b=0kjs7A0/pQO2E8drE95XV3ttQTBYDJpcID6d1xUHaXaZMJKxJPIXCAmOvofFVC8t+hywfwcy6NMMPlxl5EApvcjKUNseWwvCzj8TrFJ+O0qUjlE8PLjgMUV8J/S1QqMoUZ9wMlgulYKeWrys7gnhm81aOvtnwWqFbdIo60Gqsc4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:51 +0000
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
Subject: [RFC v1 144/256] cl8k: add rate_ctrl.h
Date:   Thu, 17 Jun 2021 16:00:31 +0000
Message-Id: <20210617160223.160998-145-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9002c221-fa6e-4717-66f8-08d931a9b074
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10590DB4A1F87D8944A167FCF60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTcUQNCO/2T1lefR+4NIjVIWUCt6kxvN0yh3t5EhvMDrsN9hRrK/5f2CQ8uZ77LzbzsbJ8fR1Sw1Z4MvnzF8SMAq6v4Lwkk+jW5pZph//qnOTXQ0chaDOnSxYInpHbMvFzb1SRnarG7z84h6dR9hpSe6HOmjNsDoTCNL5Bx/DEc+te/Od1XamXxiFk4hfzrCH0Qq0Ws5Gn/f8LtTS4i/MmfaDNXUYb+ZfKJLRyHkpb0n7uH25fmb0BjPBa4tGhvBS1IBSst3iZOhpkGAxCMgQZ+uNjqOhfppfsD+qsgKycmvpJGBKx0/t0Evn7IQaXew2O1AK8stZrMkmo30S2Q/CXpQgW8aXqQoWMqKimPcf617kVfVDpclG+XsGAM3rl16CrJNTJme2UmwQ1VrI7ry/7cT65cFBp5aWM8fZr6zqXAtsdXexP7klkDFXIIayrdUm2WoJQ0j+lwhdCdQuXhnHTW3cyYRvwQxRXVdsIlns3musCyjZcPSJtbQpXk6kjigInuHB0y6gghrxm3naXFcASNeQWexzz34ukWeB25ieH2wPrUv04hRvds15T8YE/x2UpI4hnYY537gfnTI+W+Cpalw0s8HnjQ/usLF636JP/xilP2zPNqLkKwPNxqyIvjVL0v4CTn6APBE2DQLAUIK8hv2FYEjxh6sTTSHHPtOTPIBzWct7/w5e5jJXt10SExZBHFf64btKIW7pGQEvKid2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(376002)(396003)(366004)(26005)(956004)(478600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(316002)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/k3RROWX/P9DbTp/qlIMbdU1x+KFjCVuC8FRobLokfrdsBXa5n7PsEy5ZbM?=
 =?us-ascii?Q?FGVdFeRa+wgNcyP48vnZtjKBlUPNhwhiVNl+YjKpKZX8cdJai05I0YYU9P8h?=
 =?us-ascii?Q?AmJg6Bk9v41v8VEIs5ozx2nNhtZDUwk1ExBcGDhuC4kGWg1gbKGm5M+9iDrv?=
 =?us-ascii?Q?U3CLXN/Xg/d8PfXYaf9FLiLuaSlDEY+eRd/wBrfojECPS0imlcZnl5G2qi9x?=
 =?us-ascii?Q?9PDAGsDjlaq5GO/rjtG8nGTNolc00mLNFG7nqtqK8r378oC/wK1nyHEw5QHE?=
 =?us-ascii?Q?mkCULYCH7YRNPNo45kIBCmhLHWebzp9H+YhSrxox2XTVU5aI2gKUBB1MCLek?=
 =?us-ascii?Q?+9CsMAkBA3LhnzuYSOtKtE7VSvvuSGvww6UBISp8FCe3DxX6HwXjPsumcmVb?=
 =?us-ascii?Q?o+1HjSow4LhQSUnoVguG2A2zZMrCyQDKTIT5B3Terv1DljdV5rGGYp3eMJQo?=
 =?us-ascii?Q?6Wude5y4Yzbh+PWfNzVm/afjfztr+vgowvOpsWyFJWBBrRVlGYNwqqNLKytn?=
 =?us-ascii?Q?g5qttxKc41HBhMLAlhC4TkV9PV+JdXPzA6036TLjqrj4qSYjvMyqxS2T6er3?=
 =?us-ascii?Q?lRoYtglUAkXwbQJAlcxzwmqz3o2fcflFyPGQNd5pIoQniaEEeFLCxLn9+AXO?=
 =?us-ascii?Q?Q/rkpu4fXbeHAAt1uIaXiDyoVamDwrmkWVaZV9wu+wkwS07WzhQSZAb/QlRn?=
 =?us-ascii?Q?ELfQbHEsKNMttB0cD7106ySbsZvhlZxLVE5VfTv/C6vs4KCauPGzPQLmIaAo?=
 =?us-ascii?Q?U2cc/N9DLmumcif/hU/x69cfbdxl7gAageyZpEykvyb+xiHj7mzcsgPYdVhS?=
 =?us-ascii?Q?iDKt/73xJ7/etMm2BpKdzeLwhVH0MOscCz5dMRM3KUY20oTfpsYkUkb2scqz?=
 =?us-ascii?Q?w0BQQyo3dgEiJbYJxAD5fm3XZItw/moYtygC2YVES7uQh7drjI01gx0pPm42?=
 =?us-ascii?Q?GUMVvhpPukQ5GQECVc3VGe26sTzIlGeRQnpnJzTx7Go/DoPP7h4KWRZOvTBJ?=
 =?us-ascii?Q?sjZcYIEd8Ry58nOfcY6YCCNAajJxk5OI1Mvj4I/qI0tjugdbDEHCXI8kgBv/?=
 =?us-ascii?Q?ubjvTcLrCsxJci/AI/bucKStIXV6VSHml3s6fVkl6/yAVHyYdjhujKV5QjnV?=
 =?us-ascii?Q?ksohVRxGLQKOu4vDyXLIEB862ROKiw7bJ/gWnkeMArqLwGJ7WrkjgkZtSXXF?=
 =?us-ascii?Q?VSCCxEew9T257csOn/ubBFvmp2ClTBqDJtnFpv+22b2+OLII0onkO/Bk/gbD?=
 =?us-ascii?Q?jAqLRPEgVVLEExPN3szdtBvMtI8/QXB1AAqxXKbB3e0+LsQcFWG+wowHSors?=
 =?us-ascii?Q?41oUJWZ/8GGs/DvuV8CPjK2R?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9002c221-fa6e-4717-66f8-08d931a9b074
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:13.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjhtBBgECnR81xc5wmO2Zfx2/9B+sPM3p7BikxlxhsBYcJzlkWOGkSYIPa/BlBEZonNx3sCF0i3Dl1/jrU7aSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rate_ctrl.h | 106 +++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rate_ctrl.h

diff --git a/drivers/net/wireless/celeno/cl8k/rate_ctrl.h b/drivers/net/wir=
eless/celeno/cl8k/rate_ctrl.h
new file mode 100644
index 000000000000..181f6e31ca00
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rate_ctrl.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RATE_CTRL_H
+#define CL_RATE_CTRL_H
+
+#include <linux/types.h>
+#include "ipc_shared.h"
+
+#define RATE_CTRL_OFFSET_OFDM          4
+#define RATE_CNTRL_HE_SPATIAL_CONF_DEF 0xF
+
+/* Op_mode field in mm_update_rate_dl_req structure */
+enum cl_op_mode {
+       RATE_OP_MODE_FIXED,
+       RATE_OP_MODE_DEFAULT_HE,
+       RATE_OP_MODE_DEFAULT_OFDM,
+       RATE_OP_MODE_DEFAULT_CCK,
+       RATE_OP_MODE_STA_SU,
+       RATE_OP_MODE_STA_MU,
+       RATE_OP_MODE_MCAST,
+       RATE_OP_MODE_BCAST
+};
+
+/* Value to be set in tx_host_info */
+enum cl_rate_ctrl_entry {
+       RATE_CTRL_ENTRY_NA =3D 0,
+
+       RATE_CTRL_ENTRY_STA,
+       RATE_CTRL_ENTRY_FIXED_RATE,
+       RATE_CTRL_ENTRY_MIN_HE,
+       RATE_CTRL_ENTRY_MIN_OFDM,
+       RATE_CTRL_ENTRY_MIN_CCK,
+       RATE_CTRL_ENTRY_MCAST,
+       RATE_CTRL_ENTRY_BCAST,
+
+       /* Entry size in firmware is represented by 3 bits */
+       RATE_CTRL_ENTRY_MAX =3D 8
+};
+
+/*
+ * sw_ctrl includes eights bits (16 - 23) to be used by software.
+ * Bit 16 is used by driver to indicate tx_bf.
+ * Bit 17 is used by driver to indicate fallback.
+ * Bit 18 - 23 are still free.
+ */
+struct cl_rate_ctrl_info_fields {
+       u32 mcs_index        : 7;   /* [6:0] */
+       u32 bw               : 2;   /* [8:7] */
+       u32 gi               : 2;   /* [10:9] */
+       u32 pre_type_or_stbc : 1;   /* [11] */
+       u32 format_mod       : 4;   /* [15:12] */
+       u32 tx_bf            : 1;   /* [16] */
+       u32 fallback         : 1;   /* [17] */
+       u32 sw_ctrl          : 6;   /* [23:18] */
+       u32 tx_chains        : 8;   /* [31:24] */
+};
+
+union cl_rate_ctrl_info {
+       struct cl_rate_ctrl_info_fields field;
+       u32 word;
+};
+
+struct cl_rate_ctrl_info_he_fields {
+       u32 spatial_conf    : 4;   /* [3:0] */
+       u32 starting_sts    : 3;   /* [6:4] */
+       u32 ru_index        : 6;   /* [12:7] */
+       u32 ru_type         : 3;   /* [15:13] */
+       u32 ru_band         : 1;   /* [16] */
+       u32 mu_usr_pos      : 2;   /* [18:17] */
+       u32 dcm_data        : 1;   /* [19] */
+       u32 num_usrs_mu_dl  : 4;   /* [23:20] */
+       u32 ru_alloc        : 8;   /* [31:24] */
+};
+
+union cl_rate_ctrl_info_he {
+       struct cl_rate_ctrl_info_he_fields field;
+       u32 word;
+};
+
+struct cl_hw;
+struct cl_sta;
+struct cl_sw_txhdr;
+
+u32 cl_rate_ctrl_generate(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                         u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi,
+                         bool fallback_en);
+void cl_rate_ctrl_convert(union cl_rate_ctrl_info *rate_ctrl_info);
+void cl_rate_ctrl_parse(union cl_rate_ctrl_info *rate_ctrl_info, u8 *nss, =
u8 *mcs);
+
+void cl_rate_ctrl_set_default(struct cl_hw *cl_hw);
+
+void cl_rate_ctrl_set_default_per_he_minrate(struct cl_hw *cl_hw, u8 bw,
+                                            u8 nss, u8 mcs, u8 gi);
+bool cl_rate_ctrl_set_mcast(struct cl_hw *cl_hw, u8 mode, u8 mcs);
+bool cl_rate_ctrl_set_fixed(struct cl_hw *cl_hw, u32 rate_ctrl_he, u8 mode=
, u8 mcs, u8 nss,
+                           u8 bw, u8 gi, u8 ltf_field);
+bool cl_rate_ctrl_set_dbgfs(struct cl_hw *cl_hw, u8 sta_idx, u32 rate_ctrl=
, u32 rate_ctrl_he,
+                           u8 op_mode, u8 bw, u8 ltf_field);
+void cl_rate_ctrl_set_ate_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+
+void cl_rate_ctrl_update_desc_single(struct cl_hw *cl_hw, struct tx_host_i=
nfo *info,
+                                    struct cl_sw_txhdr *sw_txhdr);
+void cl_rate_ctrl_update_desc_agg(struct cl_hw *cl_hw, struct tx_host_info=
 *info);
+
+#endif /* CL_RATE_CTRL_H */
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

