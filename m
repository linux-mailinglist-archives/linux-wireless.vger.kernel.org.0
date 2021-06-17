Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47D93AB823
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhFQQFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:11 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233539AbhFQQFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHugMhbwFSpV4Io/87Ck0ALzQ5Y8XXYYd2AuWb8aOVVL/JEwezjIR124bj5ZwYPtSnhmbfK2DLg88taBqJU9FLg5X/3GKYAYUEGycIGinuBf4+E7UqWpMZmF/ka5bQKbEeAZDxq9Rq08Y85Aayw5y1OKQqkQ4N/7cFlMwej8ffLaVNNIcwaZ7PzIewihlxnqpGQQFjprFB0h893iy8AVmTy8zDmX3lVgt9v2t7iOWAY0qQRYMBeZuIWQLb3Xgl8w18qkqH2+rsbfmV0FhrPm7GNnwtjpdbUnVtdedHiUType2AwfwpY4IIe7Nmbd9Ox1YZIzx16ab+MQfBPlDc5BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhIKIbioIK3k5xCwOQrkHp6hhUaigJNnkJUTgrBZdE=;
 b=Up/Cps8LrC/jDLLyDdTsZl9vk4NPnwU6QdYsSlvQnC3FlnWCwvTn5aCLbLWsPNBvwEd1ISObeeUR+zBqv7m5sKo1g78nXJbiFxB/B7IOPVwwpVn+77Pc6Nu+gKBdd+I2Bl9awiEIWw2y2vJQRnuQg9RxJmEHQZJy5EqtDKf0fh75zxFomVkctHjaMvKJZD3qpF/MhoEkI1/HTUdS4k5AvSzV/PhCzd3oQMpIzHO79nTwJyQivLc6meNtDsiDRKGjufcC6cJ3mb4DWURw0RLE583dvsH4ybO/t/ugiLt/CqV4osm3D+5mtJ4er4aGdzJuZnmnJX7vmE3/6/Cwyo/DaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhIKIbioIK3k5xCwOQrkHp6hhUaigJNnkJUTgrBZdE=;
 b=gCliebgInF1BxuGspe1blzUXeSIAoGLCha5rug8iYkeAP6JZfNsDWyZG5shj9AMJYF5xd1uoz8bMIgN5vtssMgQpD1pD1hvyXeZT/r6kw9IzQT9AncWqZsE0Hyk2TOVi4ZQbGvw83K4pSIklNbVbmgZanMvuKRr8+EegG8eSkaE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:44 +0000
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
Subject: [RFC v1 009/256] cl8k: add ampdu.c
Date:   Thu, 17 Jun 2021 15:58:16 +0000
Message-Id: <20210617160223.160998-10-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd63310-9827-45a8-3abc-08d931a95787
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1412410CE5D4764FAE51D801F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtBnSLZqIpL0GVGb/XC0raWVLtUO4rZFJ4JouHC0Cm1mrFQxkaqIqyosXrbnCXY0oxbYIROj2+oBN7OXdNpoaKHqsR4Bt0xZaZ0qOcRYHpVA2v4Rk+P7NF9EttQ8yUZFASIM9GXQTBBFW6F11nthvZc0eStYAaBRFzHIYxXI9rUDAVDg2DiN3/8Us2os0jyZPUnOTVCERAG1D3zXfTicIXOuU8WLj+TAk9C1DA8qs7TTBRSuYXCnR7EL49C5AljHTd/uPgsS8b8Ek1tsli9bTgevg5CA7anj+ZZ7xQW+5KbjQhRT18vZ5/ZaZ/ope+B7JiSNez3XWg6Udxj/CBNiFj6cVrZqDSGgvM1B3XabARLhomrRM14/GBhqPbOLgZrfHkGe0ghbCDv9Iez2aPWUGW+p+/gAfKMSM37ZFpeY4KszWo2w3whsP4R71cnRvm7SSWLoYqyssIZZhm97fOw8Nx5my9mUqZKpvA9oZj3UfCmL3JQ/0Rx9+vtexCiYJ9pVFHd8NY4vvmafuHOK+BGWAaSpyl9c2Ka/RppPSQYyW5Ks6+5CWCNsPNrPLms1TMgwB+R/wA7BMoUlBjN+OHB1jiTDPX+OZegFjxdqpydBYYV6svaw8+glrohU/zFBdkoyrt2I6DkHGn6tGAnsJxb+m0GLV/07b+eVySJTtzZ4vuI6jDS6SJluiOD/rhuh947Q3XQowPQYXfCyu6LyZLmWXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(30864003)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXQ95t4QpAJbGY+1ojIc84Fo5BRSifd8MpDt+Qjv42t8gwkAKbJE7Basb3YW?=
 =?us-ascii?Q?iDTAR6ap3h3yySsTdHlvk1Pe2QZZDhrbSAdsPL19b/MFU8lUWz9m8i+3sNeu?=
 =?us-ascii?Q?TJ7fu4ztJ5xSfKjzrL3TNKUsMD74aSNkH6mqbtjWaQjp+eJMO5ZfvoUPuufO?=
 =?us-ascii?Q?6yyu8L6GORAtVtYl56H+lXd03qilP1LZfc8gYasqGNQlLit+ixoU5QM0pckU?=
 =?us-ascii?Q?yqLhprapBjBIMOq/HrZ/snAz1DRpmlyvnU8WQ2nbtrrxEwqN+qK0dJGudLlt?=
 =?us-ascii?Q?CDByYF2RUFf/vhtPaFZ8MKJi06AS6b4a+SSsUUzqj6RrwUluHjJwyv07RbPr?=
 =?us-ascii?Q?Td705SL59gH5ULrqvAiyDKXKaIojG7/GLlQyE3O0lm9COaX5w6sG/4qSGl2u?=
 =?us-ascii?Q?idUv38E2oN9YDvLrdH01SWcdYJfneIT3/wKy65d/V/EZJTMYEsF5NA93bOuZ?=
 =?us-ascii?Q?KKLrLma6YodrbAeZ2KhjBf6SWkXcPlI9l2dTM2U1Few37V28jsFUcpMfFx/L?=
 =?us-ascii?Q?ejm9hp6rFbVrI3K7Xo+MXqi1wJ13sT/5G0JF5lDbyoRgTdwczBjUiT12V6fa?=
 =?us-ascii?Q?BrOP8zIrG+GVYdfwcyZEpTclg7jakMojt/tjLDMCp35S2idJI2ZLuLRWQ8YE?=
 =?us-ascii?Q?jO+6ApjzwVnj6PUELV5aYPVLy7ar+Va+hEVXGqb2v8EppzCXmYbQuAWSzRmq?=
 =?us-ascii?Q?ZDMzUWz7pD5xDRRpGYTrifOpqVwSQVv+FLKAg3wJQZx+pW0LKW1YIyGzmjea?=
 =?us-ascii?Q?vQq1PVYRE/e8l0FFvEL/gxc4NZAHpgSYECu1VNQaWuzPrl1lhAX+GhIg2jdI?=
 =?us-ascii?Q?PmK1yX3vnDI2FttT/2HSHvneCyeu34Ppw9KYcbo1334Karl6JyRvmhIMArgt?=
 =?us-ascii?Q?+x5xc/g5GQ5+xGcYu3CqRzkMpmd3XFtcIl5omPsYXD598oUlZOdlTit3uJgU?=
 =?us-ascii?Q?kKBHuxGlmRVcHz4aFQOMBob07+1bsKJ6s4QdkciglQZq9q9s9isF7fHoAW9o?=
 =?us-ascii?Q?H6Gu91PwdVp/NwFAwFF5N0BZEUGDHcDJPEtfm3/5XUHImzCc1i8ucv8klzNB?=
 =?us-ascii?Q?MrSpGg2r1fMo0FVViOwcAdAGZliaXU9LxgEA6H52sYT4I468gX9M+vjqemXT?=
 =?us-ascii?Q?mo4ST9QzABe50OoIb5wV21mAexh3v8qwz7M7S8o0XNoib15qonxwLkeJoSP3?=
 =?us-ascii?Q?yn5ipZZIohhaomErd2y+X6w+ML6Cz3iZpo286/NTrq79aUdrrBSQ3JsXrk7N?=
 =?us-ascii?Q?hK0CN32pM7RwFzW/675jWJbocJ+fX3/xjobVhSiiqlODVl+OEdlcwSoesqdh?=
 =?us-ascii?Q?kKhMkZKDlkomW1U+eQl4/tC5?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd63310-9827-45a8-3abc-08d931a95787
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:43.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05DoVqR+hdA4GqjNounk8fkBdrtUdxaxF/R9Rz53CYywhhnCGMiIy++lLZlnr9aQ2lIvwOeTn+YRaFwTjklvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ampdu.c | 344 +++++++++++++++++++++++
 1 file changed, 344 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.c

diff --git a/drivers/net/wireless/celeno/cl8k/ampdu.c b/drivers/net/wireles=
s/celeno/cl8k/ampdu.c
new file mode 100644
index 000000000000..7116995b5059
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ampdu.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "ampdu.h"
+#include "hw.h"
+#include "fw/msg_tx.h"
+#include "tx/tx_queue.h"
+#include "tx/agg_cfm.h"
+#include "recovery.h"
+#include "tx/tx_inject.h"
+#include "tx/baw.h"
+#include "utils/math.h"
+#include "band.h"
+#include "rx/rx_reorder.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/ipc.h"
+#endif
+
+int cl_ampdu_rx_start(struct cl_hw *cl_hw,
+                     struct cl_sta *cl_sta,
+                     u16 tid,
+                     u16 ssn,
+                     u16 buf_size)
+{
+       /* @IEEE80211_AMPDU_RX_START: start RX aggregation */
+       if (!cl_hw->conf->ci_agg_rx)
+               return -EOPNOTSUPP;
+
+       cl_dbg_trace(cl_hw, "sta_idx [%u] tid [%u]\n", cl_sta->sta_idx, tid=
);
+
+       buf_size =3D min(buf_size, cl_hw->conf->ce_max_agg_size_rx);
+
+       if (cl_hw->conf->ci_fast_rx_en)
+               cl_rx_reorder_init(cl_hw, cl_sta, tid, buf_size);
+
+       cl_msg_tx_ba_add(cl_hw, BA_AGMT_RX, cl_sta->sta_idx, tid, buf_size,=
 ssn);
+
+       return 0;
+}
+
+void cl_ampdu_rx_stop(struct cl_hw *cl_hw,
+                     struct cl_sta *cl_sta,
+                     u16 tid)
+{
+       /* @IEEE80211_AMPDU_RX_STOP: stop RX aggregation */
+       cl_dbg_trace(cl_hw, "sta_idx [%u] tid [%u]\n", cl_sta->sta_idx, tid=
);
+
+       if (cl_hw->conf->ci_fast_rx_en)
+               cl_rx_reorder_close(cl_sta, tid);
+}
+
+int cl_ampdu_tx_start(struct cl_hw *cl_hw,
+                     struct ieee80211_vif *vif,
+                     struct cl_sta *cl_sta,
+                     u16 tid,
+                     u16 ssn)
+{
+       /* @IEEE80211_AMPDU_TX_START: start TX aggregation */
+       struct mm_available_ba_txq_cfm *cfm =3D NULL;
+       int ret =3D 0;
+
+       if (!ieee80211_hw_check(cl_hw->hw, AMPDU_AGGREGATION) || !cl_hw->co=
nf->ci_agg_tx)
+               return -EOPNOTSUPP;
+
+       if (!cl_txq_is_agg_available(cl_hw)) {
+               cl_dbg_warn(cl_hw, "No free aggregation queue for sta_idx [=
%u] tid [%u]\n",
+                           cl_sta->sta_idx, tid);
+               return -1;
+       }
+
+       ret =3D cl_msg_tx_available_ba_txq(cl_hw, cl_sta->sta_idx, tid);
+       if (ret)
+               return ret;
+
+       /* Read FW confirm message */
+       cfm =3D (struct mm_available_ba_txq_cfm *)(cl_hw->msg_cfm_params[MM=
_AVAILABLE_BA_TXQ_CFM]);
+       if (!cfm)
+               return -ENOMSG;
+
+       /* Check if status is valid */
+       if (cfm->status !=3D BA_TXQUEUE_INVALID && cfm->status !=3D BA_TXQU=
EUE_VALID) {
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+               cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+               return -EIO;
+       }
+
+       if (cfm->status =3D=3D BA_TXQUEUE_INVALID) {
+               cl_dbg_warn(cl_hw, "BA_TXQUEUE_INVALID - sta_idx [%u] tid [=
%u]\n",
+                           cfm->sta_idx, cfm->tid);
+               cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+               return -1;
+       }
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_AVAILABLE_BA_TXQ_CFM);
+       cl_txq_agg_request_add(cl_hw, cl_sta->sta_idx, tid);
+       cl_baw_start(&cl_sta->baws[tid], ssn);
+
+       /* Mandatory callback once setup preparations are done at lower lev=
el */
+       ieee80211_start_tx_ba_cb_irqsafe(vif, cl_sta->addr, tid);
+
+       return 0;
+}
+
+int cl_ampdu_tx_operational(struct cl_hw *cl_hw,
+                           struct cl_sta *cl_sta,
+                           u16 tid,
+                           u16 buf_size,
+                           bool amsdu_supported)
+{
+       /* @IEEE80211_AMPDU_TX_OPERATIONAL: TX aggregation has become opera=
tional */
+       struct mm_ba_add_cfm *cfm =3D NULL;
+       struct cl_baw *baw =3D &cl_sta->baws[tid];
+       u16 ssn =3D baw->ssn;
+       int ret =3D 0;
+
+       buf_size =3D min(buf_size, cl_hw->conf->ce_max_agg_size_tx);
+
+       /* Send MM_BA_ADD_TX_REQ message to firmware */
+       ret =3D cl_msg_tx_ba_add(cl_hw, BA_AGMT_TX, cl_sta->sta_idx, tid, b=
uf_size, ssn);
+       if (ret)
+               return ret;
+
+       /* Handle message confirmation */
+       cfm =3D (struct mm_ba_add_cfm *)(cl_hw->msg_cfm_params[MM_BA_ADD_TX=
_CFM]);
+       if (!cfm)
+               return -ENOMSG;
+
+       if (cfm->status !=3D BA_AGMT_ESTABLISHED) {
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+               cl_msg_tx_free_cfm_params(cl_hw, MM_BA_ADD_TX_CFM);
+               cl_txq_agg_request_del(cl_hw, cl_sta->sta_idx, tid);
+               return -EIO;
+       }
+
+       cl_baw_operational(cl_hw, baw, cfm->agg_idx, amsdu_supported);
+       cl_agg_cfm_set_ssn(cl_hw, ssn, cfm->agg_idx);
+#ifdef CONFIG_CL_PCIE
+       cl_hw->ipc_env->ring_indices_elem->indices->new_ssn_idx[cfm->agg_id=
x] =3D cpu_to_le16(ssn);
+#endif
+
+       if (amsdu_supported)
+               cl_tx_amsdu_set_max_len(cl_hw, cl_sta, tid);
+       else
+               cl_dbg_trace(cl_hw, "AMSDU not supported - sta_idx=3D%u\n",=
 cl_sta->sta_idx);
+
+       cl_txq_agg_alloc(cl_hw, cl_sta, cfm, buf_size);
+       cl_msg_tx_free_cfm_params(cl_hw, MM_BA_ADD_TX_CFM);
+
+       return 0;
+}
+
+void _cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+                      struct cl_tx_queue *tx_queue,
+                      struct cl_sta *cl_sta,
+                      u8 tid)
+{
+       struct mm_ba_del_cfm *cfm =3D NULL;
+       u8 fw_agg_idx =3D tx_queue->index;
+
+       if (cl_recovery_in_progress(cl_hw))
+               goto out;
+
+       /*
+        * TX stop flow:
+        * 1) Flush TX queues - done in cl_ampdu_tx_stop()
+        * 2) Poll confirmation queue and clear enhanced TIM
+        * 3) Send MM_STA_DEL_REQ message to firmware
+        * 4) Poll again confirmation and flush confirmation queue
+        * 5) Reset write index
+        */
+       cl_agg_cfm_poll_empty(cl_hw, fw_agg_idx, false);
+
+       /* Send MM_BA_DEL_REQ message to firmware */
+       if (cl_msg_tx_ba_del(cl_hw, cl_sta->sta_idx, tid))
+               goto out;
+
+       cfm =3D (struct mm_ba_del_cfm *)(cl_hw->msg_cfm_params[MM_BA_DEL_CF=
M]);
+       if (!cfm) {
+               cl_dbg_err(cl_hw, "Unable to fetch CFM\n");
+               goto out;
+       }
+
+       /* Check confirmation status */
+       if (cfm->status !=3D BA_AGMT_DELETED && cfm->status !=3D BA_AGMT_DO=
ES_NOT_EXIST)
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", cfm->status);
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_BA_DEL_CFM);
+
+out:
+       cl_agg_cfm_poll_empty(cl_hw, fw_agg_idx, true);
+       cl_txq_agg_free(cl_hw, tx_queue, cl_sta, tid);
+
+#ifdef CONFIG_CL_PCIE
+       /* Reset the synchronization counters between the fw and the IPC la=
yer */
+       cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_idx.agg[fw=
_agg_idx] =3D 0;
+#endif
+}
+
+int cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+                    struct ieee80211_vif *vif,
+                    enum ieee80211_ampdu_mlme_action action,
+                    struct cl_sta *cl_sta,
+                    u16 tid)
+{
+       /*
+        * @IEEE80211_AMPDU_TX_STOP_CONT: stop TX aggregation but continue =
transmitting
+        *      queued packets, now unaggregated. After all packets are tra=
nsmitted the
+        *      driver has to call ieee80211_stop_tx_ba_cb_irqsafe().
+        * @IEEE80211_AMPDU_TX_STOP_FLUSH: stop TX aggregation and flush al=
l packets,
+        *      called when the station is removed. There's no need or reas=
on to call
+        *      ieee80211_stop_tx_ba_cb_irqsafe() in this case as mac80211 =
assumes the
+        *      session is gone and removes the station.
+        * @IEEE80211_AMPDU_TX_STOP_FLUSH_CONT: called when TX aggregation =
is stopped
+        *      but the driver hasn't called ieee80211_stop_tx_ba_cb_irqsaf=
e() yet and
+        *      now the connection is dropped and the station will be remov=
ed. Drivers
+        *      should clean up and drop remaining packets when this is cal=
led.
+        */
+
+       /* !!!  Comment in agg-tx.c, ___ieee80211_stop_tx_ba_session():  !!=
!
+        * !!!  HW shall not deny going back to legacy                   !!=
!
+        * !!!  Therefore cl_ampdu_tx_stop() always returns 0            !!=
!
+        */
+
+       struct cl_tx_queue *tx_queue =3D cl_sta->agg_tx_queues[tid];
+       struct cl_baw *baw =3D &cl_sta->baws[tid];
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       cl_baw_stop(baw);
+       cl_txq_agg_request_del(cl_hw, cl_sta->sta_idx, tid);
+
+       /* Check if BA session exist */
+       if (!tx_queue) {
+               spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+               if (!cl_recovery_in_progress(cl_hw))
+                       cl_dbg_warn(cl_hw, "Queue doesn't exist - sta_idx [=
%u] tid [%u]\n",
+                                   cl_sta->sta_idx, tid);
+
+               goto out;
+       }
+
+       if (action =3D=3D IEEE80211_AMPDU_TX_STOP_CONT) {
+               /*
+                * The order of flow here is very important here to avoid r=
eorder problem!
+                * 1) Take single lock to block single traffic
+                * 2) Stop agg traffic.
+                * 3) Transfer agg-to-single and push all skbs from agg que=
ue to single queue.
+                * 4) Transfer BA window pending queue to single queue.
+                * 5) Release single lock
+                */
+               spin_lock_bh(&cl_hw->tx_lock_single);
+               cl_txq_agg_stop(cl_sta, tid);
+               cl_txq_transfer_agg_to_single(cl_hw, tx_queue);
+               cl_baw_pending_to_single(cl_hw, cl_sta, baw);
+               spin_unlock_bh(&cl_hw->tx_lock_single);
+       } else {
+               cl_txq_agg_stop(cl_sta, tid);
+               cl_txq_flush(cl_hw, tx_queue);
+               cl_baw_pending_purge(baw);
+       }
+
+       cl_tx_amsdu_anchor_reset(&cl_sta->amsdu_anchor[tid]);
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+       _cl_ampdu_tx_stop(cl_hw, tx_queue, cl_sta, tid);
+
+out:
+       /* Mandatory callback once we've made our own tear down ops */
+       if (action !=3D IEEE80211_AMPDU_TX_STOP_FLUSH)
+               ieee80211_stop_tx_ba_cb_irqsafe(vif, cl_sta->addr, tid);
+
+       return 0;
+}
+
+#define HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET 3
+#define HE_EXP_MAX 22 /* 2 ^ 22 =3D 4194304 < 6500631 */
+
+static void _cl_ampdu_size_exp(struct ieee80211_sta *sta,
+                              u8 *ampdu_exp_he,
+                              u8 *ampdu_exp_vht,
+                              u8 *ampdu_exp_ht)
+{
+       struct ieee80211_sta_he_cap *he_cap =3D &sta->he_cap;
+       u8 mac_cap_info3 =3D he_cap->he_cap_elem.mac_cap_info[3];
+       u8 he_exp;
+
+       if (sta->ht_cap.ht_supported)
+               *ampdu_exp_ht =3D IEEE80211_HT_MAX_AMPDU_FACTOR + sta->ht_c=
ap.ampdu_factor;
+
+       if (sta->vht_cap.vht_supported) {
+               u32 vht_exp =3D (sta->vht_cap.cap &
+                              IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT=
_MASK) >>
+                       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
+
+               *ampdu_exp_vht =3D IEEE80211_HT_MAX_AMPDU_FACTOR + vht_exp;
+       }
+
+       he_exp =3D (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP=
_MASK) >>
+               HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET;
+
+       if (sta->vht_cap.vht_supported) {
+               if (he_exp)
+                       *ampdu_exp_he =3D min(IEEE80211_HE_VHT_MAX_AMPDU_FA=
CTOR + he_exp, HE_EXP_MAX);
+               else
+                       *ampdu_exp_he =3D *ampdu_exp_vht;
+       } else if (sta->ht_cap.ht_supported) {
+               if (he_exp)
+                       *ampdu_exp_he =3D IEEE80211_HE_HT_MAX_AMPDU_FACTOR =
+ he_exp;
+               else
+                       *ampdu_exp_he =3D *ampdu_exp_ht;
+       }
+}
+
+static void _cl_ampdu_size_exp_6g(struct ieee80211_sta *sta, u8 *ampdu_exp=
_he)
+{
+       u8 mac_cap_info3 =3D sta->he_cap.he_cap_elem.mac_cap_info[3];
+       u8 he_exp_ext =3D (mac_cap_info3 & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_=
LEN_EXP_MASK) >>
+               HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_OFFSET;
+
+       if (he_exp_ext) {
+               *ampdu_exp_he =3D min(IEEE80211_HE_VHT_MAX_AMPDU_FACTOR + h=
e_exp_ext, HE_EXP_MAX);
+       } else {
+               struct ieee80211_he_6ghz_capa *he_6g_cap =3D &sta->he_6ghz_=
capa;
+               u8 he_exp_6ghz =3D (he_6g_cap->capa & HE_6GHZ_CAP_MAX_AMPDU=
_LEN_EXP_MASK) >>
+                       HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET;
+
+               *ampdu_exp_he =3D min(HE_6GHZ_CAP_MAX_AMPDU_LEN_FACTOR + he=
_exp_6ghz, HE_EXP_MAX);
+       }
+}
+
+void cl_ampdu_size_exp(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+                      u8 *ampdu_exp_he, u8 *ampdu_exp_vht, u8 *ampdu_exp_h=
t)
+{
+       if (cl_band_is_6g(cl_hw))
+               _cl_ampdu_size_exp_6g(sta, ampdu_exp_he);
+       else
+               _cl_ampdu_size_exp(sta, ampdu_exp_he, ampdu_exp_vht, ampdu_=
exp_ht);
+
+       cl_dbg_info(cl_hw, "ampdu_size_exp: he =3D %u, vht =3D %u, ht =3D %=
u\n",
+                   *ampdu_exp_he, *ampdu_exp_vht, *ampdu_exp_ht);
+}
+
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

