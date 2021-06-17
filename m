Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CB3AB882
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFQQI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:28 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhFQQHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgyw8YZ/xg+GdnqOkf98YnrARmJpBxH7nmvlIj43TKWocBeBMCpuvi1WXuvF6m/9HLXtPzmDZc+HgdI6GRjTdLoVJrVarUVtd3OYdhyM13zWZbOAwIhGOaeXqfTOaIdoptsm945v3qipVXCx7yr8oBEJv4x8/41R4XW4SmoAy6KA3mf+ZcEtrkcj8xYhTm9qtUOSosEmnclnG5CG0Rf63DLokCINJ30RN2PI9OgB75LUhY2nI2yRUcDOmprZq4Eo5atLwJDxG1z+qu0I1FO4V0Gha2fs6WFhRJrjNqmXjv1LXb58xehXitZVmfgr74oLlrklXahZhi8iGlgrkG3sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAeK8Te/yjbEjczLAboijJpDNnp7t37lh9x+QKRG/KU=;
 b=E2mZaEbwyDG38gHhZmaMD/A1ogob89beH9Jm4qm7ZD27QQ/Al4g1ElhQZtNW1KTXwCcWyMmGoplUVXY/sx+tGb+i3Pi2Q7+VszZ8QiJENMPuZ4ym3X3W2ldOUQSiAz/r2s2ormBhxm9vbnfzch1TSyH6c7RV/Fd7qP6V1228tSHJdHLxjf7T6dwH6JaSLo9LLfGNcW7LAR7DkE2l/DXwEUKSbbkyPqJgwjJqXXXzwmytiSHuMEp28UNjBPzwfvubdtkuBgBDDo6YjkpPE7k/VizJhgnpow96XfdHmtFkgiQHinCY2LIaFYBctN8YV2FokxQsBY0pDal/7jCZ0ZAFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAeK8Te/yjbEjczLAboijJpDNnp7t37lh9x+QKRG/KU=;
 b=C0e1nBsm1WqxMpOY4qE6MZb1uM+4HRHAufZX8tlsZAGaLuheBzwo9LcSWbHnJDNl03k5S1WVZKPoFzlBKbPIl1hUplUPPyH5dIGRoI4W61L8BezsE3MjWA8eVPHOumkrl2Mm5xj/2pKtWxhScUI9ckgHlYT+72c7U5DbtfaLyHE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:02 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:02 +0000
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
Subject: [RFC v1 096/256] cl8k: add fw/msg_tx.c
Date:   Thu, 17 Jun 2021 15:59:43 +0000
Message-Id: <20210617160223.160998-97-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 735f5ef6-49c5-4340-9be9-08d931a99092
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887A6BE5546ED5A5DC3B59BF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcN159enWILxkKxcPjZdEZWVAWkYWDvCEegUxMwQBuVs3LjBsTSrt1UEQGhLjkcDCMSagOgXq0qBVtgd0Tqie0xsuG6Np8oVvJGiGtSKzF3yN3VK36jBVVLNVlxHIwjkm35OvdCsw9R0EtdEnJCcl2X806N/PHQ6EUUglAk8e7wiBx+WLcL9RSgvb6j/aogJ3OmUocC42dMFBA4pciAqPld8ZyMtyN3snJq3yv2ct1O2TMizpIdVpXLiRM6F81P82+ohUKLoBPr+Myb6Y86MGtB+D82lwBsme05Rk5x0OAmzfBg5NENjjgX468Q2y1axd0sZRAKGj4IHuyaNClPeyDKcG5qzWcGbTEfRSrhulSZnwtZUPYaBnZBmZXdl6B72zPOfnjTw6c1pdQsrqIJJ/7KlrG9RazvgsD0pBkH3EduqXBt+7bcZWv3Moh04Y/CkXeZsL40IvenTwe4+6/ZnHev+0a+1Rhy7GS3Buhg0/64HP47RgLJzsPdZL5mwhKfSaxwGj/LOyMDMHERLmiYD9VSrK6gkE08qszIFz9a0ZIZWbbLMm/cM4jhRydHXdhZ/DngqqlHuEi4UpEV1J20ARLQICVt3QMypB16A2SEJSZaAMwRq+7YHcoU7gWhET9nk+U4C3qzRMSZWo1fb4hHbsp1I8Chcp4AT1rGaiauA9jdadenR3vClMp303GMdDktQhwxvqg8rzCokA0tpKdkUeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FkWm5ZFmZHs46B4E8Gcdc4d4QRUUVfYXnxroplnJc3CkhYScjYecXmcTC15r?=
 =?us-ascii?Q?mmEZFKiv/lGBdo3kgJSkZyhCs7ouaaYVgeQmwuqnouPbHgSKiIxv5F1X5YNm?=
 =?us-ascii?Q?nB6Hb1upl4sXLxuwhKc9Q7gEpcpUsYgJs2JbDoOq0oOpKZ3WcQhJ5iWFx2+t?=
 =?us-ascii?Q?71dW8zyRQ8sFyRa8oK+pb212K2IvRYE3mQ2YYSNDGlSkl2/G3y47v6jBksY9?=
 =?us-ascii?Q?tKLg7Fy/bMoXGMXuyxzYWQ49eOHeYpdsr5IHgjXsDWS+y5KSsYVVGFhUOVSx?=
 =?us-ascii?Q?GkUXgsg3HWP68hM/Lmr2SgJ1evnuHGihJ/rtF8YvEjYqNmsGzN1rIFfnwbTV?=
 =?us-ascii?Q?Os4282d3pIp2Ebbz/yo6QNhR6qLw2WoDQHJJ5wmmg2lcqdG4qgIZzfbhB5MJ?=
 =?us-ascii?Q?OPBZdpvw5z8ALYJ+haoIIe9RH+8Qa7vxFH5IKz8B22NNsN5P1Hgk095HlmcK?=
 =?us-ascii?Q?H32BaDD98z9VtHzchMuCJqWkirqj1VH3unqqAVnVJYFZ09NXM/CmQyNYi84B?=
 =?us-ascii?Q?jbOfCujt73Xi+JcyAxa0C3K6r6DXehVuPz2O16olt0RKKp3ZSn2590GvQ2yT?=
 =?us-ascii?Q?vMQyKfbb51CgdcmRzMJ8zUd3eMNxJk6G7LL4kgBkp8HukTnIpAJKbadu2nyY?=
 =?us-ascii?Q?joLRecQp3fcuD6KKn8rErheBsLEIyBH4nH2hpjEmOcqSwvx5esKZgFSyWRO/?=
 =?us-ascii?Q?8IBEjROTdjzzJSJl1+qmkWO+xqVkZf2Y+w3CsvXw2JGN4qmYXb/LmcO3L7kP?=
 =?us-ascii?Q?1mw1WG0HbDLHXz3oEWxSTtGND+kl9Cp0oxh1CqYFQmC586Ef3MiIytQ7sWyf?=
 =?us-ascii?Q?CkczgaeEkpVQjO9TOrP+qi6MTnEUmYPc1mc4wVRYJgiQ6+j4l4gWGjRhObs3?=
 =?us-ascii?Q?VdDjjDeR7xNFaxMTutvYfJvxf+Er8zThWTdP7iK+39QNnYv1QN7RYcVbz5WX?=
 =?us-ascii?Q?YeW/MsUMzIP4kHFPgNxS4EpCADIZgQ7PbO6grd+LM4bp8YGzhdaOqhjnHtNw?=
 =?us-ascii?Q?jWMmwG9cuKeGsArkzbB0scRjOGe0RA13By89zkJfYbBYd74aMF8SXobPwS8h?=
 =?us-ascii?Q?QzUaJBn4xAIC8vk8SXFisqYB4R59lLOfc7A5FkkrgpWS8H0idVul/3emWgKj?=
 =?us-ascii?Q?1JmOcb+ghmsfAfjqIK8tRWVd/WchKwV6CuPs/u94yTZu3VP4OJrqMGRilhI2?=
 =?us-ascii?Q?kjS2xxmEmitHxYnyZhrJr7W6ZDcXaCVxFFJiONuLC6BvkfGdgM6gijsiLhCL?=
 =?us-ascii?Q?Gll7IGK7BVnaMYeR/5NwFU36uGfmUr0OGDm4tM6vAjtjyoK8mYSOOBziKuEN?=
 =?us-ascii?Q?+GOOLrY+7Td5Kfr4nkDOdkHd?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735f5ef6-49c5-4340-9be9-08d931a99092
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:19.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q34Oyn8Iq8ocIPGmkBJyLylxzirI64RCLuYDknqO7QeesAMI7TJhNG3d9An473PxPALtzh7cIscwCvWrmevkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_tx.c | 1800 ++++++++++++++++++
 1 file changed, 1800 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_tx.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_tx.c b/drivers/net/wir=
eless/celeno/cl8k/fw/msg_tx.c
new file mode 100644
index 000000000000..b63d5be24660
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_tx.c
@@ -0,0 +1,1800 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "tx/tx.h"
+#include "rx/rx.h"
+#include "fw/msg_tx.h"
+#include "fw/msg_cfm.h"
+#include "fw/fw_msg.h"
+#include "drv_ops.h"
+#include "temperature.h"
+#include "chan_info.h"
+#include "power.h"
+#include "env_det.h"
+#include "rx/rx_filter.h"
+#include "prot_mode.h"
+#include "rate_ctrl.h"
+#include "utils/utils.h"
+#include "calib.h"
+#include "band.h"
+#include "reg/reg_riu.h"
+#include "reg/reg_ricu.h"
+#include "calib.h"
+#include "recovery.h"
+#include "utils/math.h"
+#include "fem.h"
+#include "agc_params.h"
+#include "mac_addr.h"
+#include "cap.h"
+#include "ampdu.h"
+#include "phy/phy_common_lut.h"
+#include "channel.h"
+
+#define DRV_TASK_ID 100
+
+#define CL_DEF_ANT_BITMAP 0x55
+
+/* No scale-down on ASIC platform */
+#define CL_ASIC_FW_SCALEDOWN 1
+
+struct cl_msg_tx_work {
+       struct work_struct ws;
+
+       /* Background message info */
+       struct cl_hw *cl_hw;
+       void *msg_params;
+};
+
+void cl_msg_tx_free_cfm_params(struct cl_hw *cl_hw, u16 id)
+{
+       /* Free message and set pointer to NULL */
+       kfree(cl_hw->msg_cfm_params[id]);
+       cl_hw->msg_cfm_params[id] =3D NULL;
+}
+
+static inline void *cl_msg_zalloc(struct cl_hw *cl_hw, u16 msg_id, u8 dst_=
task_id, u16 param_len)
+{
+       struct fw_msg *msg;
+       u32 total_size =3D ALIGN(sizeof(struct fw_msg) + param_len, sizeof(=
u32));
+       u32 max_size =3D sizeof(u32) * IPC_A2E_MSG_BUF_SIZE;
+
+       if (total_size > max_size) {
+               cl_dbg_err(cl_hw, "total size (%u) > max size (%u)\n",
+                          total_size, max_size);
+               return NULL;
+       }
+
+       /* msg is freed out of the scope of this function */
+       msg =3D kzalloc(total_size, GFP_ATOMIC);
+       if (!msg)
+               return NULL;
+
+       msg->msg_id =3D cpu_to_le16(msg_id);
+       msg->dst_kern_id =3D cl_hw->fw_dst_kern_id;
+       msg->dst_task_id =3D dst_task_id;
+       msg->src_kern_id =3D KERN_HOST;
+       msg->src_task_id =3D DRV_TASK_ID;
+       msg->param_len =3D cpu_to_le16(param_len);
+
+       return msg->param;
+}
+
+static inline void cl_msg_free(const void *msg_param)
+{
+       kfree(container_of((void *)msg_param, struct fw_msg, param));
+}
+
+static void cl_send_msg_background_handler(struct work_struct *ws)
+{
+       struct cl_msg_tx_work *msg_tx_work =3D container_of(ws, struct cl_m=
sg_tx_work, ws);
+
+       cl_drv_ops_msg_fw_send(msg_tx_work->cl_hw, msg_tx_work->msg_params,=
 true);
+       kfree(msg_tx_work);
+}
+
+static int cl_send_msg_background(struct cl_hw *cl_hw,
+                                 const void *msg_params)
+{
+       /* Generate & populate the work struct wrapper for the background m=
sg */
+       struct cl_msg_tx_work *msg_tx_work =3D kzalloc(sizeof(*msg_tx_work)=
, GFP_ATOMIC);
+
+       if (msg_tx_work) {
+               INIT_WORK(&msg_tx_work->ws, cl_send_msg_background_handler)=
;
+               msg_tx_work->cl_hw =3D cl_hw;
+               msg_tx_work->msg_params =3D (void *)msg_params;
+
+               /* Schedule work, the work will be executed in the backgrou=
nd */
+               queue_work(cl_hw->drv_workqueue, &msg_tx_work->ws);
+
+               return 0;
+       }
+
+       cl_dbg_err(cl_hw, "msg_tx_work allocation failed\n");
+       cl_msg_free(msg_params);
+
+       return -ENODATA;
+}
+
+static int cl_send_request(struct cl_hw *cl_hw, const void *msg_params)
+{
+       int ret;
+       bool background =3D (preempt_count() !=3D 0);
+
+       if (background) {
+               /*
+                * asynchronous operation mode, message would be triggered =
in the background
+                */
+               ret =3D cl_send_msg_background(cl_hw, msg_params);
+       } else {
+               /*
+                * synchronous operation mode, message would be triggered i=
mmediately
+                * feedback to caller given immediately
+                */
+               ret =3D cl_drv_ops_msg_fw_send(cl_hw, msg_params, false);
+       }
+
+       /*
+        * In case of synchronous mode ret success implies that the msg was=
 successfully
+        * transmited where is asynchronous mode ret success implies that t=
he msg was
+        * successfully pushed to background queue
+        */
+       return ret;
+}
+
+int cl_msg_tx_reset(struct cl_hw *cl_hw)
+{
+       void *void_param;
+
+       /* RESET REQ has no parameter */
+       void_param =3D cl_msg_zalloc(cl_hw, MM_RESET_REQ, TASK_MM, 0);
+       if (!void_param)
+               return -ENOMEM;
+
+       return cl_send_request(cl_hw, void_param);
+}
+
+static u8 copy_mask_bits(u8 mask, u8 num_bits)
+{
+       /* Copy first X bits that are set in mask to new_mask */
+       u8 i =3D 0, cntr =3D 0, new_mask =3D 0;
+
+       for (i =3D 0; i < MAX_ANTENNAS; i++) {
+               if (mask & (1 << i)) {
+                       new_mask |=3D (1 << i);
+
+                       cntr++;
+                       if (cntr =3D=3D num_bits)
+                               break;
+               }
+       }
+
+       return new_mask;
+}
+
+static void cl_fill_ant_config(struct cl_hw *cl_hw,
+                              struct cl_antenna_config *ant_config,
+                              u8 num_antennas, u8 mask_antennas,
+                              u8 tx_mask_cck, u8 rx_mask_cck)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 ricu_cdb =3D 0;
+       u8 ant_shift =3D cl_hw_ant_shift(cl_hw);
+
+       ant_config->num_tx_he =3D num_antennas;
+       ant_config->num_rx =3D num_antennas;
+       ant_config->mask_tx_he =3D mask_antennas << ant_shift;
+       ant_config->mask_rx =3D mask_antennas << ant_shift;
+
+       /* Configuration for TX OFDM/HT/VHT (limited to 4 antennas) */
+       if (num_antennas <=3D MAX_ANTENNAS_OFDM_HT_VHT) {
+               ant_config->num_tx_ofdm_ht_vht =3D num_antennas;
+               ant_config->mask_tx_ofdm_ht_vht =3D mask_antennas << ant_sh=
ift;
+       } else {
+               ant_config->num_tx_ofdm_ht_vht =3D MAX_ANTENNAS_OFDM_HT_VHT=
;
+               ant_config->mask_tx_ofdm_ht_vht =3D
+                       copy_mask_bits(mask_antennas, MAX_ANTENNAS_OFDM_HT_=
VHT) << ant_shift;
+       }
+
+       /* Antenna configuration for CCK */
+       if (cl_band_is_24g(cl_hw)) {
+               ant_config->mask_tx_cck =3D tx_mask_cck << ant_shift;
+               ant_config->mask_rx_cck =3D rx_mask_cck << ant_shift;
+       }
+
+       ricu_cdb =3D ricu_static_conf_0_cdb_mode_maj_getf(chip);
+
+       /*
+        * In current implementation cdb_mode equals the num of ants for SX=
1
+        * cbd_mask 0x0 -> SX0 chain. 0x1-> SX1 chain.
+        */
+       ricu_cdb =3D MAX_ANTENNAS_CHIP - ricu_cdb;
+       ricu_cdb =3D ANT_MASK(ricu_cdb);
+       ricu_cdb =3D ~ricu_cdb;
+
+       ant_config->cdb_mask =3D ricu_cdb;
+}
+
+static void cl_fill_fem_config(struct cl_hw *cl_hw, struct cl_fem_config *=
fem_conf)
+{
+       int i;
+
+       cl_fem_get_registers(cl_hw, fem_conf->reg);
+
+       for (i =3D 0; i < ARRAY_SIZE(fem_conf->reg); i++)
+               fem_conf->reg[i] =3D cpu_to_le32(fem_conf->reg[i]);
+}
+
+static void cl_fill_calib_config(struct cl_hw *cl_hw, struct cl_calib_para=
m *calib_param,
+                                u16 primary, u16 center, u8 mode)
+{
+       struct cl_hw *cl_hw_other =3D cl_hw_other_tcv(cl_hw);
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 ant =3D 0;
+       u8 calib_bitmap =3D cl_hw->mask_num_antennas;
+       u8 ant_shift =3D cl_hw_ant_shift(cl_hw);
+
+       memset(calib_param->ant_tx_pairs, U8_MAX, ARRAY_SIZE(calib_param->a=
nt_tx_pairs));
+       memset(calib_param->ant_rx_pairs, U8_MAX, ARRAY_SIZE(calib_param->a=
nt_rx_pairs));
+
+       ant_for_each(ant) {
+               if (calib_bitmap & (1 << ant)) {
+                       calib_param->ant_tx_pairs[ant] =3D conf->ci_calib_a=
nt_tx[ant - ant_shift];
+                       if (mode & SET_CHANNEL_MODE_CALIB_IQ)
+                               calib_param->ant_rx_pairs[ant] =3D
+                                       conf->ci_calib_ant_rx[ant - ant_shi=
ft];
+               }
+       }
+
+       if (IS_PHY_ATHOS(cl_hw->chip)) {
+               calib_param->conf.initial_rx_gain =3D CALIB_RX_GAIN_DEFAULT=
_ATHOS;
+               calib_param->conf.rx_gain_upper_limit =3D CALIB_RX_GAIN_UPP=
ER_LIMIT_ATHOS;
+               calib_param->conf.rx_gain_lower_limit =3D CALIB_RX_GAIN_LOW=
ER_LIMIT_ATHOS;
+       } else {
+               calib_param->conf.initial_rx_gain =3D CALIB_RX_GAIN_DEFAULT=
;
+               calib_param->conf.rx_gain_upper_limit =3D CALIB_RX_GAIN_UPP=
ER_LIMIT;
+               calib_param->conf.rx_gain_lower_limit =3D CALIB_RX_GAIN_LOW=
ER_LIMIT;
+       }
+
+       calib_param->conf.initial_tx_gain =3D CALIB_TX_GAIN_DEFAULT;
+       calib_param->conf.nco_freq =3D cpu_to_le16(CALIB_NCO_FREQ_DEFAULT);
+       calib_param->conf.nco_amp =3D CALIB_NCO_AMP_DEFAULT;
+       calib_param->conf.sleeve_trshld =3D GAIN_SLEEVE_TRSHLD_DEFAULT;
+       calib_param->conf.n_samples_exp_lolc =3D N_SAMPLES_EXP_LOLC;
+       calib_param->conf.n_samples_exp_iqc =3D N_SAMPLES_EXP_IQC;
+       calib_param->conf.p_thresh =3D cpu_to_le32(LO_P_THRESH);
+       calib_param->conf.n_bit_fir_scale =3D N_BIT_FIR_SCALE;
+       calib_param->conf.n_bit_amp_scale =3D N_BIT_AMP_SCALE;
+       calib_param->conf.n_bit_phase_scale =3D N_BIT_PHASE_SCALE;
+
+       cl_calib_iq_get_tone_vector(cl_hw->bw, calib_param->conf.tone_vecto=
r);
+
+       calib_param->conf.gp_rad_trshld =3D cpu_to_le32(GP_RAD_TRSHLD_DEFAU=
LT);
+       calib_param->conf.ga_lin_upper_trshld =3D cpu_to_le32(GA_LIN_UPPER_=
TRSHLD_DEFAULT);
+       calib_param->conf.ga_lin_lower_trshld =3D cpu_to_le32(GA_LIN_LOWER_=
TRSHLD_DEFAULT);
+       calib_param->conf.comp_filter_len =3D COMP_FILTER_LEN_DEFAULT;
+       calib_param->conf.singletons_num =3D SINGLETONS_NUM_DEFAULT;
+       calib_param->conf.tones_num =3D IQ_NUM_TONES_REQ;
+       calib_param->conf.rampup_time =3D cpu_to_le16(RAMPUP_TIME);
+       calib_param->conf.lo_coarse_step =3D cpu_to_le16(LO_COARSE_STEP);
+       calib_param->conf.lo_fine_step =3D cpu_to_le16(LO_FINE_STEP);
+
+       calib_param->other_tcv.prim20_freq =3D cpu_to_le16(primary + SX_FRE=
Q_OFFSET_Q2);
+       cl_phy_oly_lut_update(cl_hw->nl_band,
+                             center + SX_FREQ_OFFSET_Q2,
+                             &calib_param->other_tcv.center1_freq_lut);
+
+       if (cl_chip_is_both_enabled(cl_hw->chip)) {
+               calib_param->other_tcv.mask_tx_he =3D cl_hw_other->mask_num=
_antennas;
+               calib_param->other_tcv.num_tx_he =3D cl_hw_other->num_anten=
nas;
+               calib_param->other_tcv.band =3D cl_band_to_fw_idx(cl_hw_oth=
er);
+       } else {
+               calib_param->other_tcv.mask_tx_he =3D cl_hw->mask_num_anten=
nas;
+               calib_param->other_tcv.num_tx_he =3D cl_hw->num_antennas;
+               calib_param->other_tcv.band =3D cl_band_to_fw_idx(cl_hw);
+       }
+}
+
+int cl_msg_tx_start(struct cl_hw *cl_hw)
+{
+       struct mm_start_req *req;
+       struct cl_phy_cfg *phy_cfg;
+       struct cl_start_param *param;
+       struct cl_cca_config *cca_config;
+       struct dbg_meta_data *dbg_metadata;
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_tcv_conf *tcv_conf =3D cl_hw->conf;
+       struct cl_chip_conf *chip_conf =3D chip->conf;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       u8 bw =3D 0, ant =3D 0;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_START_REQ, TASK_MM, sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       phy_cfg =3D &req->phy_cfg;
+       param =3D &req->param;
+       cca_config =3D &phy_cfg->cca_config;
+       dbg_metadata =3D &param->dbg_metadata;
+
+       phy_cfg->band =3D cl_band_to_fw_idx(cl_hw);
+       phy_cfg->channel_bandwidth =3D tcv_conf->ce_channel_bandwidth;
+       phy_cfg->ht_rxldpc_en =3D tcv_conf->ce_ht_rxldpc_en;
+       phy_cfg->freq_offset =3D cpu_to_le16(chip->eeprom_cache->calib.freq=
_offset);
+       phy_cfg->vns_tx_power_mode =3D chip_conf->ce_production_mode ? 0 : =
tcv_conf->ci_vns_pwr_mode;
+       phy_cfg->vns_rssi_suto_resp_th =3D tcv_conf->ci_vns_rssi_auto_resp_=
thr;
+       phy_cfg->afe_config_en =3D true;
+       phy_cfg->no_capture_noise_sleep =3D chip_conf->ci_no_capture_noise_=
sleep;
+       phy_cfg->gain_update_enable =3D tcv_conf->ci_gain_update_enable;
+       phy_cfg->mcs_sig_b =3D tcv_conf->ci_mcs_sig_b;
+       phy_cfg->ofdm_only =3D tcv_conf->ci_ofdm_only;
+       phy_cfg->hr_factor =3D tcv_conf->ci_hr_factor[phy_cfg->channel_band=
width];
+       phy_cfg->td_csd_en =3D tcv_conf->ci_csd_en;
+       phy_cfg->pe_duration_bcast =3D tcv_conf->ci_pe_duration_bcast;
+       phy_cfg->tx_digital_gain =3D cpu_to_le32(tcv_conf->ci_tx_digital_ga=
in);
+       phy_cfg->tx_digital_gain_cck =3D cpu_to_le32(tcv_conf->ci_tx_digita=
l_gain_cck);
+       phy_cfg->ofdm_cck_power_offset =3D (u8)tcv_conf->ci_ofdm_cck_power_=
offset;
+       phy_cfg->phy_clk_gating_en =3D tcv_conf->ci_phy_clk_gating_en;
+
+       /*
+        * Set rx_sensitivity according to number of antennas.
+        * For all other antennas set 0xff which is equal to -1
+        */
+       memcpy(phy_cfg->rx_sensitivity, cl_hw->rx_sensitivity, cl_hw->num_a=
ntennas);
+       if (cl_hw->num_antennas < ARRAY_SIZE(phy_cfg->rx_sensitivity))
+               memset(&phy_cfg->rx_sensitivity[cl_hw->num_antennas], U8_MA=
X,
+                      MAX_ANTENNAS - cl_hw->num_antennas);
+
+       if (!cl_hw->fw_send_start) {
+               cl_hw->fw_send_start =3D true;
+               phy_cfg->first_start =3D true;
+       }
+
+       cl_fill_ant_config(cl_hw, &phy_cfg->ant_config, cl_hw->num_antennas=
,
+                          cl_hw->mask_num_antennas, tcv_conf->ce_cck_tx_an=
t_mask,
+                          tcv_conf->ce_cck_rx_ant_mask);
+       cl_fill_fem_config(cl_hw, &phy_cfg->fem_conf);
+
+       cca_config->ed_rise_thr_dbm =3D (u8)tcv_conf->ci_cca_ed_rise_thr_db=
m;
+       cca_config->ed_fall_thr_dbm =3D (u8)tcv_conf->ci_cca_ed_fall_thr_db=
m;
+       cca_config->cs_en =3D tcv_conf->ci_cca_cs_en;
+       cca_config->modem_en =3D tcv_conf->ci_cca_modem_en;
+       cca_config->main_ant =3D tcv_conf->ci_cca_main_ant;
+       cca_config->second_ant =3D tcv_conf->ci_cca_second_ant;
+       cca_config->flag0_ctrl =3D tcv_conf->ci_cca_flag0_ctrl;
+       cca_config->flag1_ctrl =3D tcv_conf->ci_cca_flag1_ctrl;
+       cca_config->flag2_ctrl =3D tcv_conf->ci_cca_flag2_ctrl;
+       cca_config->flag3_ctrl =3D tcv_conf->ci_cca_flag3_ctrl;
+       cca_config->gi_rise_thr_dbm =3D (u8)tcv_conf->ci_cca_gi_rise_thr_db=
m;
+       cca_config->gi_fall_thr_dbm =3D (u8)tcv_conf->ci_cca_gi_fall_thr_db=
m;
+       cca_config->gi_pow_lim_dbm =3D (u8)tcv_conf->ci_cca_gi_pow_lim_dbm;
+       cca_config->ed_en =3D cpu_to_le16(tcv_conf->ci_cca_ed_en);
+       cca_config->gi_en =3D tcv_conf->ci_cca_gi_en;
+
+       param->prot_log_nav_en =3D tcv_conf->ce_prot_log_nav_en;
+       param->prot_mode =3D cl_prot_mode_get(cl_hw);
+       param->prot_rate_format =3D tcv_conf->ce_prot_rate_format;
+       param->prot_rate_mcs =3D tcv_conf->ce_prot_rate_mcs;
+       param->prot_rate_pre_type =3D tcv_conf->ce_prot_rate_pre_type;
+       param->bw_signaling_mode =3D tcv_conf->ce_bw_signaling_mode;
+       param->cfm_size =3D cpu_to_le16(IPC_CFM_SIZE);
+       param->cfm_dma_base_addr =3D cpu_to_le32(ipc_env->cfm_dma_base_addr=
);
+       param->phy_dev =3D cpu_to_le16(chip_conf->ci_phy_dev);
+       param->fw_scale_down =3D cpu_to_le16(CL_ASIC_FW_SCALEDOWN);
+       param->hal_timeout.idle =3D cpu_to_le32(tcv_conf->ci_hal_idle_to);
+       param->hal_timeout.ac0 =3D cpu_to_le32(tcv_conf->ci_tx_ac0_to);
+       param->hal_timeout.ac1 =3D cpu_to_le32(tcv_conf->ci_tx_ac1_to);
+       param->hal_timeout.ac2 =3D cpu_to_le32(tcv_conf->ci_tx_ac2_to);
+       param->hal_timeout.ac3 =3D cpu_to_le32(tcv_conf->ci_tx_ac3_to);
+       param->hal_timeout.bcn =3D cpu_to_le32(tcv_conf->ci_tx_bcn_to);
+
+       /* Update rxbuff/txqueue & ring_indices that hold the array metadat=
a */
+       param->ipc_ring_indices_base =3D cpu_to_le32(ipc_env->ring_indices_=
elem->dma_addr);
+       param->host_rxbuf_base_addr[CL_RX_BUF_RXM] =3D
+               ipc_env->rx_hostbuf_array[CL_RX_BUF_RXM].dma_payload_base_a=
ddr;
+       param->host_rxbuf_base_addr[CL_RX_BUF_FW] =3D
+               ipc_env->rx_hostbuf_array[CL_RX_BUF_FW].dma_payload_base_ad=
dr;
+
+       /*
+        * The FW needs to be aware of the DMA addresses of the
+        * TX queues so it could fetch txdesc from the host.
+        */
+       param->ipc_host_tx_queues_dma_addr =3D cpu_to_le32(cl_hw->ipc_env->=
tx_queues.dma_addr);
+
+       /*
+        * Compilation flags match check - please add here all compilation =
flags
+        * which should be compiled on both driver and firmware.
+        */
+       param->comp_flags =3D cpu_to_le32(0) | cpu_to_le32(BIT(CENX_CFG_CE_=
TX_CFM));
+
+       param->dbg_test_mode_max =3D DBG_TEST_MODE_MAX;
+
+       param->ipc_rxbuf_size[CL_RX_BUF_RXM] =3D
+               cpu_to_le16(tcv_conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM]);
+       param->ipc_rxbuf_size[CL_RX_BUF_FW] =3D
+               cpu_to_le16(tcv_conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW]);
+
+       param->ipc_rxbuf_extra_headroom =3D cpu_to_le32(IPC_RXBUF_EXTRA_HEA=
DROOM);
+       param->host_pci_gen_ver =3D chip_conf->ce_host_pci_gen_ver;
+       param->dma_lli_max_chan[0] =3D chip_conf->ci_dma_lli_max_chan[0];
+       param->dma_lli_max_chan[1] =3D chip_conf->ci_dma_lli_max_chan[1];
+       param->production_mode =3D chip_conf->ce_production_mode;
+       param->mult_ampdu_in_txop_en =3D tcv_conf->ci_mult_ampdu_in_txop_en=
;
+       param->cca_timeout =3D cpu_to_le32(tcv_conf->ci_cca_timeout);
+       param->long_retry_limit =3D tcv_conf->ce_long_retry_limit;
+       param->short_retry_limit =3D tcv_conf->ce_short_retry_limit;
+       param->assoc_auth_retry_limit =3D tcv_conf->ci_assoc_auth_retry_lim=
it;
+       param->bcn_tx_path_min_time =3D cpu_to_le16(tcv_conf->ce_bcn_tx_pat=
h_min_time);
+       param->backup_bcn_en =3D tcv_conf->ci_backup_bcn_en;
+       param->tx_txop_cut_en =3D tcv_conf->ce_tx_txop_cut_en;
+       param->ac_with_bcns_flushed_cnt_thr =3D tcv_conf->ci_bcns_flushed_c=
nt_thr;
+       param->txl_statistics_struct_size =3D cpu_to_le32(sizeof(struct cl_=
txl_statistics));
+       param->rxl_statistics_struct_size =3D cpu_to_le32(sizeof(struct cl_=
rxl_statistics));
+       param->phy_err_prevents_phy_dump =3D tcv_conf->ci_phy_err_prevents_=
phy_dump;
+       param->tx_rx_delay =3D tcv_conf->ci_tx_rx_delay;
+       param->assert_storm_detect_thd =3D tcv_conf->ci_fw_assert_storm_det=
ect_thd;
+       param->assert_time_diff_sec =3D tcv_conf->ci_fw_assert_time_diff_se=
c;
+       param->ps_ctrl_enabled =3D tcv_conf->ce_ps_ctrl_enabled;
+       param->phy_data_dma_addr =3D cpu_to_le32(cl_hw->phy_data_info.dma_a=
ddr);
+       param->phy_remote_rom_dma_addr =3D cpu_to_le32(cl_hw->fw_remote_rom=
.dma_addr);
+       param->iq_dcoc_calib_tables_dma_addr =3D cpu_to_le32(cl_hw->iq_dcoc=
_data_info.dma_addr);
+       param->power_table_dma_addr =3D cpu_to_le32(cl_hw->power_table_info=
.dma_addr);
+       param->tf_info_dma_addr =3D 0;
+       param->min_ant_pwr_q1 =3D cl_power_min_ant_q1(cl_hw);
+
+       for (bw =3D 0; bw < ARRAY_SIZE(param->bw_factor_q2); bw++) {
+               cl_hw->power_db.bw_factor_q2[bw] =3D cl_power_bw_factor_q2(=
cl_hw, bw);
+               param->bw_factor_q2[bw] =3D
+                       cl_convert_signed_to_reg_value(cl_hw->power_db.bw_f=
actor_q2[bw]);
+       }
+
+       for (ant =3D 0; ant < ARRAY_SIZE(param->ant_factor_q2); ant++) {
+               cl_hw->power_db.ant_factor_q2[ant] =3D cl_power_array_gain_=
q2(cl_hw, ant + 1);
+               param->ant_factor_q2[ant] =3D cl_hw->power_db.ant_factor_q2=
[ant];
+       }
+
+       param->default_distance.auto_resp_all =3D tcv_conf->ci_distance_aut=
o_resp_all;
+       param->default_distance.auto_resp_msta =3D tcv_conf->ci_distance_au=
to_resp_msta;
+       param->su_force_min_spacing_usec =3D tcv_conf->ci_su_force_min_spac=
ing;
+       param->mu_force_min_spacing_usec =3D tcv_conf->ci_mu_force_min_spac=
ing;
+       param->force_tcv0_only =3D false;
+       param->rx_padding =3D tcv_conf->ci_rx_padding_en;
+       param->bar_cap_disable =3D tcv_conf->ci_bar_disable;
+       param->hw_bsr =3D 0; /* FIXME */
+       param->drop_to_lower_bw =3D tcv_conf->ci_drop_to_lower_bw;
+       param->dra_enable =3D cl_chip_is_both_enabled(chip); /* DRA enable =
only in CDB mode */
+       param->mac_clk_gating_en =3D tcv_conf->ci_mac_clk_gating_en;
+       param->imaging_blocker =3D tcv_conf->ci_imaging_blocker;
+       param->fec_coding =3D tcv_conf->ce_he_rxldpc_en;
+       param->cs_required =3D tcv_conf->ci_cs_required;
+
+       if (!chip->fw_first_tcv) {
+               chip->fw_first_tcv =3D true;
+               param->first_tcv =3D true;
+       }
+
+       dbg_metadata->lmac_req_buf_size =3D cpu_to_le32(sizeof(struct dbg_e=
rror_trace_info_drv));
+       dbg_metadata->physical_queue_cnt =3D CL_MAX_BA_PHYSICAL_QUEUE_CNT;
+       dbg_metadata->agg_index_max =3D AGG_IDX_MAX;
+       dbg_metadata->ce_ac_max =3D CE_AC_MAX;
+       dbg_metadata->mu_user_max =3D MU_MAX_STREAMS;
+       dbg_metadata->txl_exch_trace_depth =3D DBG_TXL_FRAME_EXCH_TRACE_DEP=
TH;
+       dbg_metadata->mac_hw_regs_max =3D cpu_to_le16(HAL_MACHW_REG_NUM);
+       dbg_metadata->phy_hw_regs_max =3D cpu_to_le16(PHY_HW_DBG_REGS_CNT);
+       dbg_metadata->thd_chains_data_size =3D cpu_to_le16(DBG_THD_CHAINS_I=
NFO_ARRAY_SIZE);
+       dbg_metadata->chains_info_elem_cnt =3D DBG_CHAINS_INFO_ELEM_CNT;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_version(struct cl_hw *cl_hw)
+{
+       void *void_param;
+
+       /* VERSION REQ has no parameter */
+       void_param =3D cl_msg_zalloc(cl_hw, MM_VERSION_REQ, TASK_MM, 0);
+       if (!void_param)
+               return -ENOMEM;
+
+       return cl_send_request(cl_hw, void_param);
+}
+
+int cl_msg_tx_add_if(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+                    u8 vif_index)
+{
+       struct mm_add_if_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_ADD_IF_REQ, TASK_MM, sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       cl_mac_addr_copy(req->addr.array, vif->addr);
+
+       switch (vif->type) {
+       case NL80211_IFTYPE_STATION:
+       case NL80211_IFTYPE_P2P_CLIENT:
+               req->type =3D MM_STA;
+               break;
+
+       case NL80211_IFTYPE_ADHOC:
+               req->type =3D MM_IBSS;
+               break;
+
+       case NL80211_IFTYPE_AP:
+       case NL80211_IFTYPE_P2P_GO:
+               req->type =3D MM_AP;
+               break;
+
+       case NL80211_IFTYPE_MONITOR:
+               req->type =3D MM_MONITOR;
+               break;
+
+       case NL80211_IFTYPE_MESH_POINT:
+               req->type =3D MM_MESH_POINT;
+               break;
+
+       default:
+               req->type =3D MM_STA;
+               break;
+       }
+
+       req->tx_strip_vlan =3D 1;
+       req->mac_addr_hi_mask =3D cpu_to_le32(cl_hw->mask_hi);
+       req->mac_addr_low_mask =3D cpu_to_le32(cl_hw->mask_low);
+       req->inst_nbr =3D vif_index;
+
+       if (vif->type =3D=3D NL80211_IFTYPE_AP) {
+               struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
+               struct ps_data *ps =3D &sdata->u.ap.ps;
+
+               req->start_dtim_count =3D (u8)(ps->dtim_count);
+       }
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_remove_if(struct cl_hw *cl_hw, u8 vif_index)
+{
+       struct mm_remove_if_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_REMOVE_IF_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->inst_nbr =3D vif_index;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+                     struct cl_vif *cl_vif, u8 recovery_sta_idx,
+                     u32 rate_ctrl_info)
+{
+       struct mm_sta_add_req *req;
+       struct ieee80211_sta_ht_cap *ht_cap =3D &sta->ht_cap;
+       struct ieee80211_sta_vht_cap *vht_cap =3D &sta->vht_cap;
+       struct ieee80211_sta_he_cap *he_cap =3D &sta->he_cap;
+       u16 my_aid =3D 0;
+       u8 inst_nbr =3D cl_vif->vif_index;
+       bool is_6g =3D cl_band_is_6g(cl_hw);
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+
+       req =3D cl_msg_zalloc(cl_hw, MM_STA_ADD_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       cl_mac_addr_copy(req->mac_addr.array, sta->addr);
+
+       if (cl_vif->vif->type =3D=3D NL80211_IFTYPE_STATION)
+               my_aid =3D cl_vif->vif->bss_conf.aid;
+
+       if (is_6g) {
+               u8 mac_cap_info4 =3D he_cap->he_cap_elem.mac_cap_info[4];
+
+               req->su_bfee =3D (mac_cap_info4 & IEEE80211_HE_PHY_CAP4_SU_=
BEAMFORMEE) ? 1 : 0;
+               req->mu_bfee =3D (mac_cap_info4 & IEEE80211_HE_PHY_CAP4_MU_=
BEAMFORMER) ? 1 : 0;
+       } else if (vht_cap->vht_supported) {
+               req->su_bfee =3D (vht_cap->cap & IEEE80211_VHT_CAP_SU_BEAMF=
ORMEE_CAPABLE) ? 1 : 0;
+               req->mu_bfee =3D (vht_cap->cap & IEEE80211_VHT_CAP_MU_BEAMF=
ORMEE_CAPABLE) ? 1 : 0;
+       }
+
+       req->ampdu_min_spacing =3D cl_sta->ampdu_min_spacing;
+
+       if (he_cap->has_he) {
+               u8 mac_cap_info1 =3D he_cap->he_cap_elem.mac_cap_info[1];
+               u8 mac_cap_info3 =3D he_cap->he_cap_elem.mac_cap_info[3];
+
+               req->he_tf_mac_padding_duration =3D
+                       (mac_cap_info1 & IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_D=
UR_MASK);
+
+               req->he_rx_ctrl_frm_to_mbss =3D
+                       (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_RX_CTRL_FRAM=
E_TO_MULTIBSS) ?
+                       true : false;
+
+               /* Fill PE duration table */
+               cl_cap_ppe_duration(cl_hw, sta, req->pe_duration);
+       }
+
+       cl_ampdu_size_exp(cl_hw, sta, &req->ampdu_size_exp_he,
+                         &req->ampdu_size_exp_vht, &req->ampdu_size_exp_ht=
);
+
+       if (cl_hw->conf->ce_txldpc_en) {
+               if (he_cap->has_he)
+                       req->ldpc_enabled =3D (he_cap->he_cap_elem.phy_cap_=
info[1] &
+                                            IEEE80211_HE_PHY_CAP1_LDPC_COD=
ING_IN_PAYLOAD) ? 1 : 0;
+               else if (vht_cap->vht_supported)
+                       req->ldpc_enabled =3D (vht_cap->cap & IEEE80211_VHT=
_CAP_RXLDPC) ? 1 : 0;
+               else if (ht_cap->ht_supported)
+                       req->ldpc_enabled =3D (ht_cap->cap & IEEE80211_HT_C=
AP_LDPC_CODING) ? 1 : 0;
+       }
+
+       /* TODO Set the interface index from the vif structure */
+       req->inst_nbr =3D inst_nbr;
+
+       req->aid =3D cpu_to_le16(sta->aid);
+       req->my_aid =3D cpu_to_le16(my_aid);
+       req->recovery_sta_idx =3D recovery_sta_idx;
+
+       /* Station power save configuration */
+       req->uapsd_queues =3D sta->uapsd_queues;
+       req->max_sp =3D sta->max_sp;
+
+       /* Set WRS default parameters for rate control */
+       req->tx_params.rate =3D cpu_to_le32(rate_ctrl_info);
+
+       /* Fill TX antenna with default value */
+       req->tx_params.ant_set =3D CL_DEF_ANT_BITMAP;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sta_del(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       struct mm_sta_del_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_STA_DEL_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D sta_idx;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_filter(struct cl_hw *cl_hw, u32 filter, bool force)
+{
+       struct mm_set_filter_req *req;
+       u32 rx_filter =3D 0;
+
+       if (cl_channel_is_scan_active(cl_hw)) {
+               cl_dbg_trace(cl_hw, "Set filter ignored due to active chann=
el scan\n");
+               return 0;
+       }
+
+       if (force)
+               rx_filter =3D filter;
+       else
+               rx_filter =3D cl_rx_filter_update_flags(cl_hw, filter);
+
+       if (rx_filter =3D=3D cl_hw->rx_filter) {
+               cl_dbg_trace(cl_hw, "Rx filter 0x%x already set - return\n"=
, rx_filter);
+               return 0;
+       }
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_FILTER_REQ, TASK_MM, sizeof(*re=
q));
+       if (!req)
+               return -ENOMEM;
+
+       /* Now copy all the flags into the message parameter */
+       req->filter =3D cpu_to_le32(rx_filter);
+       cl_hw->rx_filter =3D rx_filter;
+
+       cl_dbg_trace(cl_hw, "new total_flags =3D 0x%08x\nrx filter set to  =
0x%08x\n",
+                    filter, rx_filter);
+
+       return cl_send_request(cl_hw, req);
+}
+
+u8 cl_mark_calib_flags(struct cl_hw *cl_hw, u8 mode)
+{
+       int lna =3D 0;
+       int ant =3D 0;
+       u8 calib_info_set =3D 0;
+       struct cl_iq_dcoc_info *iq_dcoc_db =3D &cl_hw->phy_data_info.data->=
iq_dcoc_db;
+
+       /* In case DCOC is going to be calibrated, no need to raise any cal=
ibration flag. */
+       if (mode & SET_CHANNEL_MODE_CALIB_DCOC)
+               return calib_info_set;
+
+       /* Check if DCOC flag should be marked */
+       for (lna =3D 0; lna < ARRAY_SIZE(iq_dcoc_db->dcoc); lna++) {
+               for (ant =3D 0; ant < cl_hw->num_antennas; ant++) {
+                       if (iq_dcoc_db->dcoc[lna][ant].i || iq_dcoc_db->dco=
c[lna][ant].q) {
+                               calib_info_set |=3D SET_PHY_DATA_FLAGS_DCOC=
;
+                               break;
+                       }
+               }
+       }
+
+       /* Check if IQ Tx LOLC flag should be marked */
+       for (ant =3D 0; ant < cl_hw->num_antennas; ant++) {
+               if (iq_dcoc_db->iq_tx_lolc[ant]) {
+                       calib_info_set |=3D SET_PHY_DATA_FLAGS_IQ_TX_LOLC;
+                       break;
+               }
+       }
+
+       /* Check if IQ Tx flag should be marked */
+       for (ant =3D 0; ant < cl_hw->num_antennas; ant++) {
+               if (iq_dcoc_db->iq_tx[ant].coef0 || iq_dcoc_db->iq_tx[ant].=
coef1 ||
+                   iq_dcoc_db->iq_tx[ant].coef2 || iq_dcoc_db->iq_tx[ant].=
gain) {
+                       calib_info_set |=3D SET_PHY_DATA_FLAGS_IQ_TX;
+                       break;
+               }
+       }
+
+       /* Check if IQ Rx flag should be marked */
+       for (ant =3D 0; ant < cl_hw->num_antennas; ant++) {
+               if (iq_dcoc_db->iq_rx[ant].coef0 || iq_dcoc_db->iq_rx[ant].=
coef1 ||
+                   iq_dcoc_db->iq_rx[ant].coef2 || iq_dcoc_db->iq_rx[ant].=
gain) {
+                       calib_info_set |=3D SET_PHY_DATA_FLAGS_IQ_RX;
+                       return calib_info_set;
+               }
+       }
+       return calib_info_set;
+}
+
+static int __cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw=
, u16 primary,
+                                  u16 center, u8 mode)
+{
+       struct mm_set_channel_req *req;
+       int res =3D 0;
+       struct cl_phy_data *data =3D cl_hw->phy_data_info.data;
+
+       /* Fill AGC parameters - check before we start building the message=
 */
+       if ((res =3D cl_agc_params_fill(cl_hw, &data->agc_params)))
+               return res;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_CHANNEL_REQ, TASK_MM, sizeof(*r=
eq));
+       if (!req)
+               return -ENOMEM;
+
+       req->band =3D cl_band_to_fw_idx(cl_hw);
+       req->bandwidth =3D bw;
+       req->prim20_freq =3D cpu_to_le16(primary);
+       cl_phy_oly_lut_update(cl_hw->nl_band, center, &req->center1_freq_lu=
t);
+       req->hr_factor =3D cl_hw->conf->ci_hr_factor[bw];
+       req->signal_ext =3D cl_hw->conf->ci_signal_extension_en;
+
+       /* Set power per mcs offset after EIRP truncation */
+       cl_power_tables_update(cl_hw, &data->pwr_tables);
+
+       /* Get antenna power offset from eeprom */
+       cl_calib_power_offset_fill(cl_hw, channel, bw, req->ant_pwr_offset)=
;
+
+       cl_calib_fill_phy_data(cl_hw, &data->iq_dcoc_db, SET_PHY_DATA_FLAGS=
_ALL);
+
+       if (mode =3D=3D SET_CHANNEL_MODE_CALIB)
+               req->calib_info_set =3D SET_PHY_DATA_FLAGS_ALL;
+       else
+               req->calib_info_set =3D SET_PHY_DATA_FLAGS_NONE;
+
+       req->calib_param.mode =3D mode;
+
+       if (mode & (SET_CHANNEL_MODE_CALIB_LOLC | SET_CHANNEL_MODE_CALIB_IQ=
)) {
+               req->sx_freq_offset_mhz =3D SX_FREQ_OFFSET_Q2;
+               cl_fill_calib_config(cl_hw, &req->calib_param, primary, cen=
ter, mode);
+       }
+
+       if (mode & SET_CHANNEL_MODE_CALIB_DCOC) {
+               if (IS_PHY_ATHOS(cl_hw->chip))
+                       req->calib_param.dcoc_max_vga =3D DCOC_MAX_VGA_ATHO=
S;
+               else
+                       req->calib_param.dcoc_max_vga =3D DCOC_MAX_VGA;
+       }
+
+       /* Antenna configuration */
+       cl_fill_ant_config(cl_hw, &req->ant_config, cl_hw->num_antennas, cl=
_hw->mask_num_antennas,
+                          cl_hw->conf->ce_cck_tx_ant_mask, cl_hw->conf->ce=
_cck_rx_ant_mask);
+       /* FEM configuration */
+       cl_fill_fem_config(cl_hw, &req->fem_conf);
+
+       res =3D cl_send_request(cl_hw, req);
+
+       cl_temperature_comp_update_calib(cl_hw);
+
+       cl_dbg_info(cl_hw,
+                   "band=3D%u, channel=3D%u, bw=3D%u, primary=3D%u.%u, cen=
ter=3D%u.%u, sx_index=3D%u\n",
+                   cl_hw->conf->ci_band_num, channel, bw, GET_FREQ_INT(pri=
mary),
+                   GET_FREQ_FRAC(primary), GET_FREQ_INT(center), GET_FREQ_=
FRAC(center),
+                   cl_hw->tcv_idx);
+
+       return res;
+}
+
+int _cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 pr=
imary,
+                          u32 center, u8 mode)
+{
+       int res =3D 0;
+       u32 primary_q2 =3D FREQ_TO_Q2(primary);
+       u32 center_q2 =3D FREQ_TO_Q2(center);
+
+       /*
+        * Need to take mutex lock to ensure that no one touching the phy_d=
ata
+        * DMA before FW is reading all its values.
+        * The mutex is unlocked right after the iq_dcoc_data_info DMA is
+        * handled in cl_calib_handle_set_channel_cfm.
+        */
+       res =3D mutex_lock_interruptible(&cl_hw->set_channel_mutex);
+
+       if (res !=3D 0) {
+               cl_dbg_verbose(cl_hw, "Error - mutex_lock_interruptible (%d=
)\n", res);
+               return res;
+       }
+
+       cl_hw->channel =3D channel;
+       cl_hw->bw =3D bw;
+       cl_hw->primary_freq =3D primary;
+       cl_hw->center_freq =3D center;
+
+       if (mode & SET_CHANNEL_MODE_CALIB)
+               cl_hw->msg_calib_timeout =3D true;
+
+       res =3D __cl_msg_tx_set_channel(cl_hw, channel, bw, primary_q2, cen=
ter_q2, mode);
+
+       if (mode & SET_CHANNEL_MODE_CALIB) {
+               cl_hw->msg_calib_timeout =3D false;
+
+               if (!res)
+                       res =3D cl_calib_handle_cfm(cl_hw, mode);
+       }
+
+       mutex_unlock(&cl_hw->set_channel_mutex);
+
+       return res;
+}
+
+int cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 pri=
mary, u32 center)
+{
+       if (cl_calib_is_needed(cl_hw, channel, bw))
+               return cl_calib_set_channel(cl_hw, channel, bw, primary, ce=
nter);
+       else
+               return _cl_msg_tx_set_channel(cl_hw, channel, bw, primary, =
center,
+                                             SET_CHANNEL_MODE_OPERETIONAL)=
;
+}
+
+int cl_msg_tx_dtim(struct cl_hw *cl_hw, u8 dtim_period)
+{
+       struct mm_set_dtim_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_DTIM_REQ, TASK_MM, sizeof(*req)=
);
+       if (!req)
+               return -ENOMEM;
+
+       req->dtim_period =3D dtim_period;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_beacon_int(struct cl_hw *cl_hw, u16 beacon_int, u8 vif_i=
dx)
+{
+       struct mm_set_beacon_int_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_BEACON_INT_REQ, TASK_MM, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->beacon_int =3D cpu_to_le16(beacon_int);
+       req->inst_nbr =3D vif_idx;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_basic_rates(struct cl_hw *cl_hw, u32 basic_rates)
+{
+       struct mm_set_basic_rates_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_BASIC_RATES_REQ, TASK_MM, sizeo=
f(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->rates =3D cpu_to_le32(basic_rates);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_bssid(struct cl_hw *cl_hw, const u8 *bssid, u8 vif_idx)
+{
+       struct mm_set_bssid_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_BSSID_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       cl_mac_addr_copy(req->bssid.array, bssid);
+       req->inst_nbr =3D vif_idx;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_edca(struct cl_hw *cl_hw, u8 hw_queue, u32 param,
+                      struct ieee80211_he_mu_edca_param_ac_rec *mu_edca)
+{
+       struct mm_set_edca_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_EDCA_REQ, TASK_MM, sizeof(*req)=
);
+       if (!req)
+               return -ENOMEM;
+
+       req->ac_param =3D cpu_to_le32(param);
+       req->hw_queue =3D hw_queue;
+
+       if (mu_edca) {
+               req->mu_edca_aifsn =3D mu_edca->aifsn;
+               req->mu_edca_ecw_min_max =3D mu_edca->ecw_min_max;
+               req->mu_edca_timer =3D mu_edca->mu_edca_timer;
+       }
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_associated(struct cl_hw *cl_hw,
+                            struct ieee80211_bss_conf *bss_conf)
+{
+       struct mm_set_associated_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_ASSOCIATED_REQ, TASK_MM, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->aid =3D cpu_to_le16(bss_conf->aid);
+
+       /* Multiple BSSID feature support */
+       if (bss_conf->nontransmitted && bss_conf->assoc) {
+               u8 i =3D 0;
+               u8 mask_addr[ETH_ALEN] =3D {0};
+               u32 bssid_hi_mask =3D 0;
+               u32 bssid_low_mask =3D 0;
+
+               for (i =3D 0; i < ARRAY_SIZE(mask_addr); i++)
+                       mask_addr[i] =3D (bss_conf->transmitter_bssid[i] ^
+                                       bss_conf->bssid[i]);
+               cl_mac_addr_array_to_nxmac(mask_addr, &bssid_low_mask,
+                                          &bssid_hi_mask);
+               /* Set mask to allow the transmitter BSSID Rx reception */
+               req->bssid_hi_mask =3D cpu_to_le32(bssid_hi_mask);
+               req->bssid_low_mask =3D cpu_to_le32(bssid_low_mask);
+       }
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_slottime(struct cl_hw *cl_hw, bool use_short_slot)
+{
+       struct mm_set_slottime_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_SLOTTIME_REQ, TASK_MM, sizeof(*=
req));
+       if (!req)
+               return -ENOMEM;
+
+       req->slottime =3D use_short_slot ? 9 : 20;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_idle(struct cl_hw *cl_hw, u8 idle)
+{
+       struct mm_set_idle_req *req;
+
+       if (cl_fem_read_wiring_id(cl_hw->chip)) {
+               cl_dbg_err(cl_hw, "!!! Invalid wiring id [%u] !!! Aborting\=
n",
+                          cl_hw->chip->fem.wiring_id);
+               return -EINVAL;
+       }
+
+       /*
+        * Rearm last_tbtt_ind so that error message will
+        * not be printed in cl_irq_status_tbtt()
+        */
+       if (!idle)
+               cl_hw->last_tbtt_irq =3D jiffies;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_IDLE_REQ, TASK_MM, sizeof(*req)=
);
+       if (!req)
+               return -ENOMEM;
+
+       req->hw_idle =3D idle;
+
+       cl_dbg_info(cl_hw, "idle =3D %s\n", idle ? "True" : "False");
+
+       return cl_send_request(cl_hw, req);
+}
+
+void cl_msg_tx_idle_async(struct cl_hw *cl_hw)
+{
+       cl_hw->idle_async_set =3D true;
+       cl_msg_tx_set_idle(cl_hw, MAC_IDLE_ASYNC);
+}
+
+int cl_msg_tx_key_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+                     struct ieee80211_sta *sta,
+                     struct ieee80211_key_conf *key_conf,
+                     u8 cipher_suite)
+{
+       struct mm_key_add_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_KEY_ADD_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       if (sta) {
+               /* Pairwise key */
+               req->sta_idx =3D ((struct cl_sta *)sta->drv_priv)->sta_idx;
+       } else {
+               /* Default key */
+               req->sta_idx =3D 0xFF;
+               req->key_idx =3D (u8)(key_conf->keyidx); /* Only useful for=
 default keys */
+       }
+
+       req->inst_nbr =3D ((struct cl_vif *)vif->drv_priv)->vif_index;
+       req->key.length =3D key_conf->keylen;
+
+       /* TODO: check if this works well in Big endian platforms */
+       memcpy(req->key.array, key_conf->key, key_conf->keylen);
+
+       req->cipher_suite =3D cipher_suite;
+       req->spp =3D cl_hw->conf->ci_spp_ksr_value;
+
+       cl_dbg_info(cl_hw, "sta_idx:%u, key_idx:%u, inst_nbr:%u, cipher:%u,=
 key_len:%u, spp:%u\n",
+                   req->sta_idx, req->key_idx, req->inst_nbr,
+                   req->cipher_suite, req->key.length, req->spp);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_key_del(struct cl_hw *cl_hw, u8 hw_key_idx)
+{
+       struct mm_key_del_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_KEY_DEL_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       req->hw_key_idx =3D hw_key_idx;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ba_add(struct cl_hw *cl_hw, u8 type, u8 sta_idx,
+                    u16 tid, u16 bufsz, u16 ssn)
+{
+       struct mm_ba_add_req *req;
+       u16 msg_id =3D ((type =3D=3D BA_AGMT_TX) ? MM_BA_ADD_TX_REQ : MM_BA=
_ADD_RX_REQ);
+
+       req =3D cl_msg_zalloc(cl_hw, msg_id, TASK_MM, sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->type =3D type;
+       req->sta_idx =3D sta_idx;
+       req->tid =3D (u8)tid;
+       req->bufsz =3D cpu_to_le16(bufsz);
+       req->ssn =3D cpu_to_le16(ssn);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ba_del(struct cl_hw *cl_hw, u8 sta_idx, u16 tid)
+{
+       struct mm_ba_del_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_BA_DEL_REQ, TASK_MM, sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D sta_idx;
+       req->tid =3D (u8)tid;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_phy_reset(struct cl_hw *cl_hw)
+{
+       struct mm_phy_reset_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_PHY_RESET_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_available_ba_txq(struct cl_hw *cl_hw, u8 sta_idx, u16 tid)
+{
+       struct mm_available_ba_txq_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_AVAILABLE_BA_TXQ_REQ, TASK_MM, size=
of(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D sta_idx;
+       req->tid =3D (u8)tid;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_update_rate_dl(struct cl_hw *cl_hw, u8 sta_idx, u32 rate, u3=
2 rate_fallback,
+                            u8 req_bw_tx, u8 op_mode, u8 ltf, u8 ltf_fallb=
ack, u32 rate_he)
+{
+       struct mm_update_rate_dl_req *req;
+
+       cl_dbg_info(cl_hw, "sta_idx=3D%u, rate=3D0x%x, rate_fallback=3D0x%x=
, req_bw_tx=3D%u, "
+                   "op_mode=3D%u, ltf=3D%u, ltf_fallback=3D%u, rate_he=3D0=
x%x\n",
+                   sta_idx, rate, rate_fallback, req_bw_tx, op_mode,
+                   ltf, ltf_fallback, rate_he);
+
+       req =3D cl_msg_zalloc(cl_hw, MM_UPDATE_RATE_DL_REQ, TASK_MM, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       /* Populate tx_params */
+       req->tx_params.rate =3D cpu_to_le32(rate);
+       req->tx_params.rate_he =3D cpu_to_le32(rate_he);
+       req->tx_params.req_bw_tx =3D req_bw_tx;
+       req->tx_params.ant_set =3D CL_DEF_ANT_BITMAP;
+       req->tx_params.ltf =3D ltf;
+
+       req->op_mode =3D op_mode;
+       req->sta_idx =3D sta_idx;
+       req->rate_fallback =3D cpu_to_le32(rate_fallback);
+       req->ltf_fallback =3D ltf_fallback;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_vns(struct cl_hw *cl_hw, u8 sta_idx, u8 is_vns)
+{
+       struct mm_set_vns_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_VNS_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D sta_idx;
+       req->is_vns =3D is_vns;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_tx_bf(struct cl_hw *cl_hw, u8 sta_idx, u8 is_on, u8 is_o=
n_fallback)
+{
+       struct mm_set_tx_bf_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_TX_BF_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D sta_idx;
+       req->is_on =3D is_on;
+       req->is_on_fallback =3D is_on_fallback;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding(struct cl_hw *cl_hw,
+                      struct mm_sounding_req *sounding_req)
+{
+       struct mm_sounding_req *req;
+       u8 i;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SOUNDING_REQ, TASK_MM, sizeof(*req)=
);
+       if (!req)
+               return -ENOMEM;
+
+       /* Populate mm_sounding_req */
+       memcpy(req, sounding_req, sizeof(struct mm_sounding_req));
+
+       /* In case of non-TB HE SU/CQI, nc should be set to 0 */
+       if (req->sounding_type =3D=3D SOUNDING_TYPE_HE_CQI ||
+           req->sounding_type =3D=3D SOUNDING_TYPE_HE_SU)
+               for (i =3D 0; i < req->sta_num; i++)
+                       req->info_per_sta[i].nc =3D 0;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding_pairing(struct cl_hw *cl_hw, u8 sounding_id, u8 sou=
nding_type,
+                              u8 gid, u8 sta_idx)
+{
+       struct mm_sounding_pairing *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SOUNDING_PAIRING_REQ, TASK_MM, size=
of(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->sounding_type =3D sounding_type;
+       req->sta_idx =3D sta_idx;
+       req->gid =3D gid;
+       req->sounding_id =3D sounding_id;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding_interval(struct cl_hw *cl_hw, u16 interval, u16 lif=
etime,
+                               u8 sounding_type, u8 sta_idx)
+{
+       struct mm_sounding_interval_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SOUNDING_INTERVAL_REQ, TASK_MM, siz=
eof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->interval =3D cpu_to_le16(interval);
+       req->bfr_lifetime =3D cpu_to_le16(lifetime);
+       req->sounding_type =3D sounding_type;
+       req->sta_idx =3D sta_idx;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_config_cca(struct cl_hw *cl_hw, bool enable)
+{
+       struct mm_config_cca_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_CONFIG_CCA_REQ, TASK_MM, sizeof(*re=
q));
+       if (!req)
+               return -ENOMEM;
+
+       req->enable =3D enable;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_dfs(struct cl_hw *cl_hw, bool enable, u8 standard,
+                     u8 initial_gain, u8 agc_cd_th)
+{
+       struct mm_set_dfs_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_DFS_REQ, TASK_MM, sizeof(*req))=
;
+       if (!req)
+               return -ENOMEM;
+
+       req->enable =3D enable;
+       req->standard_fcc =3D (standard =3D=3D CL_STANDARD_FCC) ? true : fa=
lse;
+       req->initial_gain =3D initial_gain;
+       req->agc_cd_th =3D agc_cd_th;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_ant_bitmap(struct cl_hw *cl_hw, u8 bitmap)
+{
+       struct mm_set_ant_bitmap_req *req;
+       u8 num_antennas =3D hweight8(bitmap);
+       u8 bitmap_cck =3D 0;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_ANT_BITMAP_REQ, TASK_MM, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       if (cl_band_is_24g(cl_hw)) {
+               if (num_antennas > MAX_ANTENNAS_CCK)
+                       bitmap_cck =3D copy_mask_bits(bitmap, MAX_ANTENNAS_=
CCK);
+               else
+                       bitmap_cck =3D bitmap;
+       }
+
+       cl_fill_ant_config(cl_hw, &req->ant_config, num_antennas, bitmap, b=
itmap_cck, bitmap_cck);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ndp_tx_control(struct cl_hw *cl_hw, u8 chain_mask, u8 bw, u8=
 format, u8 num_ltf)
+{
+       struct mm_ndp_tx_control_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_NDP_TX_CONTROL_REQ, TASK_MM, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->chain_mask =3D chain_mask;
+       req->bw =3D bw;
+       req->format =3D format;
+       req->num_ltf =3D num_ltf;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_reg_write(struct cl_hw *cl_hw, u32 address, u32 value, u32 m=
ask)
+{
+       struct mm_reg_write_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_REG_WRITE_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->address =3D cpu_to_le32(address);
+       req->value =3D cpu_to_le32(value);
+       req->mask =3D cpu_to_le32(mask);
+
+       cl_dbg_info(cl_hw, "address=3D0x%x, value=3D0x%x, mask=3D0x%x\n", a=
ddress, value, mask);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_prot_mode(struct cl_hw *cl_hw, u8 log_nav_en, u8 mode, u8 ra=
te_format,
+                       u8 rate_mcs, u8 rate_pre_type)
+{
+       struct mm_prot_mode_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_PROT_MODE_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->log_nav_en =3D log_nav_en;
+       req->mode =3D mode;
+       req->rate_format =3D rate_format;
+       req->rate_mcs =3D rate_mcs;
+       req->rate_pre_type =3D rate_pre_type;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_goto_power_reduction(struct cl_hw *cl_hw, u8 mode)
+{
+       struct mm_goto_power_reduction_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_GOTO_POWER_REDUCTION_REQ, TASK_MM, =
sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->goto_power_reduction_mode =3D mode;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_backup_bcn_en(struct cl_hw *cl_hw, bool backup_bcn_en)
+{
+       struct mm_set_backup_bcn_en_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_BACKUP_BCN_EN_REQ, TASK_MM, sizeof(=
*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->backup_bcn_en =3D backup_bcn_en;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_start_periodic_tx_time(struct cl_hw *cl_hw, u16 periodic_tx_=
time_off,
+                                    u16 periodic_tx_time_on)
+{
+       struct mm_start_periodic_tx_time_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_START_PERIODIC_TX_TIME_REQ, TASK_MM=
, sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->periodic_tx_time_off =3D cpu_to_le16(periodic_tx_time_off);
+       req->periodic_tx_time_on =3D cpu_to_le16(periodic_tx_time_on);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_anamon_read(struct cl_hw *cl_hw, u8 mode, u8 param1, u8 para=
m2)
+{
+       struct mm_anamon_read_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_ANAMON_READ_REQ, TASK_MM, sizeof(*r=
eq));
+       if (!req)
+               return -ENOMEM;
+
+       req->mode =3D mode;
+       req->param1 =3D param1;
+       req->param2 =3D param2;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_refresh_power(struct cl_hw *cl_hw)
+{
+       void *void_param;
+
+       /* MM_REFRESH_PWR_REQ has no parameter */
+       void_param =3D cl_msg_zalloc(cl_hw, MM_REFRESH_PWR_REQ, TASK_MM, 0)=
;
+       if (!void_param)
+               return -ENOMEM;
+
+       return cl_send_request(cl_hw, void_param);
+}
+
+int cl_msg_tx_set_ant_pwr_offset(struct cl_hw *cl_hw, s8 pwr_offset[MAX_AN=
TENNAS])
+{
+       struct mm_set_ant_pwr_offset_req *req;
+       u8 i =3D 0;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_ANT_PWR_OFFSET_REQ, TASK_MM, si=
zeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       for (i =3D 0; i < ARRAY_SIZE(req->pwr_offset); i++) {
+               pwr_offset[i] =3D cl_power_offset_check_margin(cl_hw, cl_hw=
->bw, i, pwr_offset[i]);
+               req->pwr_offset[i] =3D cl_convert_signed_to_reg_value(pwr_o=
ffset[i]);
+       }
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_rate_fallback(struct cl_hw *cl_hw)
+{
+       struct mm_rate_fallback_req *req;
+       u8 *fb_conf =3D cl_hw->conf->ci_rate_fallback;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_RATE_FALLBACK_REQ, TASK_MM, siz=
eof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->fallback_count_su =3D fb_conf[CL_RATE_FALLBACK_COUNT_SU];
+       req->fallback_count_mu =3D fb_conf[CL_RATE_FALLBACK_COUNT_MU];
+       req->retry_count_thr =3D fb_conf[CL_RATE_FALLBACK_RETRY_COUNT_THR];
+       req->ba_per_thr =3D fb_conf[CL_RATE_FALLBACK_BA_PER_THR];
+       req->ba_not_received_thr =3D fb_conf[CL_RATE_FALLBACK_BA_NOT_RECEIV=
ED_THR];
+       req->disable_mcs0 =3D fb_conf[CL_RATE_FALLBACK_DISABLE_MCS];
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_twt_setup(struct cl_hw *cl_hw, struct mm_twt_setup_req *para=
ms)
+{
+       struct mm_twt_setup_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_TWT_SETUP_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D params->sta_idx;
+       req->twt_flow_id =3D params->twt_flow_id;
+       req->announced =3D params->announced;
+       req->triggered =3D params->triggered;
+       req->min_wake_duration_us =3D cpu_to_le32(params->min_wake_duration=
_us);
+       req->twt_interval_us =3D cpu_to_le64(params->twt_interval_us);
+       req->twt_start_time_tsf =3D cpu_to_le64(params->twt_start_time_tsf)=
;
+
+       cl_dbg_info(cl_hw,
+                   "sta_idx %u, flow_id %u, interval_us %llu, min_wake_dur=
ation_us %u,"
+                   "start_time %llu, announced %u, triggered %u\n",
+                   req->sta_idx, req->twt_flow_id, req->twt_interval_us,
+                   req->min_wake_duration_us, req->twt_start_time_tsf,
+                   req->announced, req->triggered);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_twt_teardown(struct cl_hw *cl_hw, struct mm_twt_teardown_req=
 *params)
+{
+       struct mm_twt_teardown_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_TWT_TEARDOWN_REQ, TASK_MM, sizeof(*=
req));
+       if (!req)
+               return -ENOMEM;
+
+       req->sta_idx =3D params->sta_idx;
+       req->twt_flow_id =3D params->twt_flow_id;
+
+       cl_dbg_info(cl_hw, "sta_idx %u, flow_id %u\n",
+                   req->sta_idx, req->twt_flow_id);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_rsrc_mgmt_traffic_event(struct cl_hw *cl_hw, u8 event_type,
+                                     enum cl_traffic_level level,
+                                     enum cl_traffic_direction direction,
+                                     u8 active_sta_cnt)
+{
+       struct mm_rsrc_mgmt_req *req =3D NULL;
+       struct cl_sta *cl_sta =3D NULL;
+       int curr_cnt =3D 0;
+       size_t size =3D sizeof(*req) + active_sta_cnt * sizeof(struct mm_rs=
rc_mgmt_active_sta);
+
+       req =3D cl_msg_zalloc(cl_hw, MM_RSRC_MGMT_REQ, TASK_MM, size);
+       if (!req)
+               return -ENOMEM;
+
+       req->subtype =3D event_type;
+       req->u.traffic_event.level =3D level;
+       req->u.traffic_event.direction =3D direction;
+
+       cl_sta_lock_bh(cl_hw);
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               struct cl_wrs_rate *max_rate_cap =3D &cl_sta->wrs_sta.max_r=
ate_cap;
+               struct cl_wrs_tx_params *su_tx_params =3D &cl_sta->wrs_sta.=
su_params.tx_params;
+
+               if (!cl_sta->traffic_db[direction].activity_db[level].is_ac=
tive)
+                       continue;
+
+               if (req->u.traffic_event.active_sta.cnt =3D=3D active_sta_c=
nt) {
+                       WARN_ONCE(active_sta_cnt !=3D 0,
+                                 "Synchronization failure between actual a=
nd "
+                                 "preallocated station entities!");
+                       break;
+               }
+
+               req->u.traffic_event.active_sta.list[curr_cnt] =3D (struct =
mm_rsrc_mgmt_active_sta) {
+                   .idx =3D cl_sta->sta_idx,
+                   .su_rate =3D {
+                       .bw =3D su_tx_params->bw,
+                       .nss =3D su_tx_params->nss,
+                       .mcs =3D su_tx_params->mcs
+                   },
+                   .max_rate =3D {
+                       .bw =3D max_rate_cap->bw,
+                       .nss =3D max_rate_cap->nss,
+                       .mcs =3D max_rate_cap->mcs
+                   },
+               };
+
+               curr_cnt++;
+       }
+       req->u.traffic_event.active_sta.cnt =3D curr_cnt;
+       cl_sta_unlock_bh(cl_hw);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_rsrc_mgmt_rates_event(struct cl_hw *cl_hw, u8 event_type,
+                                   struct cl_sta *cl_sta)
+{
+       struct mm_rsrc_mgmt_req *req =3D NULL;
+       struct cl_wrs_rate *max_rate_cap =3D &cl_sta->wrs_sta.max_rate_cap;
+       struct cl_wrs_tx_params *su_tx_params =3D &cl_sta->wrs_sta.su_param=
s.tx_params;
+
+       req =3D cl_msg_zalloc(cl_hw, MM_RSRC_MGMT_REQ, TASK_MM, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       req->subtype =3D event_type;
+       req->u.rate_event.sta =3D (struct mm_rsrc_mgmt_active_sta) {
+           .idx =3D cl_sta->sta_idx,
+           .su_rate =3D {
+               .bw =3D su_tx_params->bw,
+               .nss =3D su_tx_params->nss,
+               .mcs =3D su_tx_params->mcs
+           },
+           .max_rate =3D {
+               .bw =3D max_rate_cap->bw,
+               .nss =3D max_rate_cap->nss,
+               .mcs =3D max_rate_cap->mcs
+           },
+       };
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_freq_offset(struct cl_hw *cl_hw, u16 val)
+{
+       struct mm_set_freq_offset_req *req;
+
+       /* Build the MM_SET_FREQ_OFFSET_REQ message */
+       req =3D cl_msg_zalloc(cl_hw, MM_SET_FREQ_OFFSET_REQ, TASK_MM,
+                           sizeof(struct mm_set_freq_offset_req));
+
+       if (!req)
+               return -ENOMEM;
+
+       /* Set parameters for the MM_SET_FREQ_OFFSET_REQ message */
+       req->val =3D cpu_to_le16(val);
+
+       /* Send the MM_SET_FREQ_OFFSET_REQ message to firmware */
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_mod_filter(struct cl_hw *cl_hw, u32 filter)
+{
+       struct dbg_set_mod_filter_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_MOD_FILTER_REQ, TASK_DBG, size=
of(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->mod_filter =3D cpu_to_le32(filter);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_ce_mod_filter(struct cl_hw *cl_hw, u32 filter)
+{
+       struct dbg_set_mod_filter_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_CE_SET_MOD_FILTER_REQ, TASK_DBG, s=
izeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->mod_filter =3D cpu_to_le32(filter);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_sev_filter(struct cl_hw *cl_hw, u32 filter)
+{
+       struct dbg_set_sev_filter_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_SEV_FILTER_REQ, TASK_DBG, size=
of(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->sev_filter =3D cpu_to_le32(filter);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_beamforming_tx(struct cl_hw *cl_hw, u32 param32)
+{
+       struct dbg_beamforming_tx_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_BEAMFORMING_TX_REQ, TASK_DBG, size=
of(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->bf_cmd =3D cpu_to_le32(param32);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_get_e2w_stats(struct cl_hw *cl_hw, bool clear)
+{
+       struct dbg_e2w_stats_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_GET_E2W_STATS_REQ, TASK_DBG, sizeo=
f(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->clear =3D cpu_to_le32(clear);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_la_mpif_mask(struct cl_hw *cl_hw, u32 mask)
+{
+       struct dbg_set_la_mpif_mask_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_LA_MPIF_MASK_REQ, TASK_DBG, si=
zeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->mpif_mask =3D cpu_to_le32(mask);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_la_trig_point(struct cl_hw *cl_hw, u32 trigger_point=
)
+{
+       struct dbg_set_la_trig_point_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_LA_TRIG_POINT_REQ, TASK_DBG, s=
izeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->trigger_point =3D cpu_to_le32(trigger_point);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_la_mpif_debug_mode(struct cl_hw *cl_hw, u8 mode)
+{
+       struct dbg_set_la_mpif_debug_mode_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_LA_MPIF_DEBUG_MODE_REQ, TASK_D=
BG,
+                           sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->mode =3D mode;
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_la_trig_rule(struct cl_hw *cl_hw, u8 idx, bool enabl=
e, u32 address,
+                                  u8 oper, u32 value, u32 mask, u32 durati=
on)
+{
+       struct dbg_set_la_trig_rule_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SET_LA_TRIG_RULE_REQ, TASK_DBG, si=
zeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->rule_id =3D idx;
+       req->oper =3D oper;
+       req->enable =3D enable;
+       req->address =3D cpu_to_le32(address);
+       req->value =3D cpu_to_le32(value);
+       req->mask =3D cpu_to_le32(mask);
+       req->duration =3D cpu_to_le32(duration);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_tx_trace_debug_flag(struct cl_hw *cl_hw, u32 bitmap, u8 =
w_r_cmd)
+{
+       struct dbg_tx_trace_debug_flag_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_TX_TRACE_DEBUG_FLAG_REQ, TASK_DBG,=
 sizeof(*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->read_write_flag =3D w_r_cmd;
+       req->bitmap =3D cpu_to_le32(bitmap);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_print_stats(struct cl_hw *cl_hw, u32 command,
+                             u32 param0, u32 param1, u32 param2, u32 param=
3)
+{
+       struct dbg_print_stats_req *req;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_PRINT_STATS_REQ, TASK_DBG, sizeof(=
*req));
+       if (!req)
+               return -ENOMEM;
+
+       req->command =3D cpu_to_le32(command);
+       req->param[0] =3D cpu_to_le32(param0);
+       req->param[1] =3D cpu_to_le32(param1);
+       req->param[2] =3D cpu_to_le32(param2);
+       req->param[3] =3D cpu_to_le32(param3);
+
+       cl_dbg_verbose(cl_hw, "param0 =3D 0x%x, param1 =3D 0x%x, param2 =3D=
 0x%x, param3 =3D 0x%x\n",
+                      req->param[0], req->param[1], req->param[2], req->pa=
ram[3]);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_trigger(struct cl_hw *cl_hw, char *msg)
+{
+       struct dbg_trigger_req *req;
+       u8 msg_len =3D min(strlen(msg), sizeof(req->error) - 1);
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_TRIGGER_REQ, TASK_DBG, sizeof(*req=
));
+       if (!req)
+               return -ENOMEM;
+
+       strncpy(req->error, msg, msg_len);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_test_mode(struct cl_hw *cl_hw, u32 *params)
+{
+       struct dbg_test_mode_req *req;
+       int i =3D 0;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_TEST_MODE_REQ, TASK_DBG, sizeof(*r=
eq));
+       if (!req)
+               return -ENOMEM;
+
+       req->command =3D cpu_to_le32(params[0]);
+
+       /* Param[0] is the command, therefore start from param[i + 1] */
+       for (i =3D 0; i < ARRAY_SIZE(req->params); i++)
+               req->params[i] =3D cpu_to_le32(params[i + 1]);
+
+       return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_sounding_cmd(struct cl_hw *cl_hw, struct dbg_sounding_cm=
d_param *params)
+{
+       struct dbg_sounding_cmd_param *req;
+       int i;
+
+       req =3D cl_msg_zalloc(cl_hw, DBG_SOUNDING_CMD_REQ, TASK_DBG, sizeof=
(*req));
+       if (!req)
+               return -ENOMEM;
+
+       memcpy(req, params, sizeof(struct dbg_sounding_cmd_param));
+       req->sounding_cmd_index =3D cpu_to_le32(params->sounding_cmd_index)=
;
+
+       for (i =3D 0; i < ARRAY_SIZE(req->param); i++)
+               req->param[i] =3D cpu_to_le32(params->param[i]);
+
+       return cl_send_request(cl_hw, req);
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

