Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADB3AB8EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhFQQLO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:14 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:33286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231318AbhFQQKB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij0H1mgvkGMdnREF9O+8hTwVV0V0ncZfjeJJMpfed6e5dfXV+z2QTSL4t4RwTeX9Xv5ZJMXFMwNeZdCXkhSgl9AUQPkL5EXuuioCtsYOJDNixp5trHPl1tOzG0iNcyiBVgvPypc741D3+CfKOTiNQcg3fchu57m+4iNYGixQpll4Nd/lLvJD7xhQso8I5i+Jacj639S7091rznq8IeSUGFfiuVW8FAHA2x6s8CGQ8dvQOW3stoZMPx1YZqh50Ir1OKcVnTBLgchWpl9gN5fpneW+yfMZ44o1MH0x96IgDg/J5JW0Sof1SHC3825HDuF7HV660u7H24PRD3ZRw1gUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVw6Z7I4Ia1lo1qypUa45eebG+Qykohrl4nInvATeq8=;
 b=fQBPPTTomZe7QdvU5D1QCTI3kVYsT44BTOL+ftttRv9oUXOyHw0kQbU23eNJYjNZdT4mYhG5pr44GhK8JoZH9C3urvkSLxtgEk9vJGNLvJkyervt7tSTUpPt0tBlRfxjB/uWXw9x5iOPD9NeU0HyeMCTiiN4LPSwIN7YLSmaHQ38SgvDtTahlcyExvt1gS+V/3AD997013QL/0eoFKe6vyn2o/AfBTF540hqtZu8LkYjIW5K7Nwpp6pfwb7L78AspLi81x2XYa0y3BwFR+fag3qtdUeEMWDs0POmKmzQxhZWVQvGntMf/LeY6JaUVFLyRGA/uYNYJUx6xmad1F7org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVw6Z7I4Ia1lo1qypUa45eebG+Qykohrl4nInvATeq8=;
 b=AhOFhqEV45W/ZbnkWzNmo/TsONC7WGO9Vh+QFVTQU9VHJyp0b96SnO4kRKHTFChhMvpWZq/+J2rnlJUPOlTK4hpz+4u8tkLaeAbKhmQneUXP+H4Yjc3wPk/Ho/zp/fQzuW6DUR9v1fMvA3sEhH0GTA+ybkFr05CeoZRpx7sBxrI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:08 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:08 +0000
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
Subject: [RFC v1 181/256] cl8k: add sounding.h
Date:   Thu, 17 Jun 2021 16:01:08 +0000
Message-Id: <20210617160223.160998-182-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5049a6-5275-48e4-6bce-08d931a9c915
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB026029F0D917475EBCD6CAC4F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xDdjy97kLgnIH7/RR/m8UFsY4b/ayBXR/6V8JmryO211Pg/1Fbdu+i7bTywx11/aVAIjcE7ONHV4csdjVPWbRm3B4p7DCXA8Q+94Bm1YkEVq06FOGiY6pN5HTZ5/A0aUc8nYyA/GTw5K9QZ1QntdhBSYNe/tLKoLJYZnLWlUQ3JDbuU2tM0KJ08EkVe7moutYVqF/b9ww/aipbvw8Vjj4Vew9aeGeH8P4gmisfiH9GUznySMW1S9sLxlDQNUwNC8LIkB92dYH18CXDla3J6AVWDpjCzbLM7fmQCp5rjocBQqTsR/tYepkxaPIHDLBu8K73FjZ69KIidqJGUB67fGJTF12jSRlnjbt5lWDUTmnlkAUgHZL6f1ZannkvTM1jQe0rIbE9D4yHvU1PonyuoxEy+g6Kxet1ituKEii1kkY7j48kYMuS5WKXKUiJokn7NZvKPYAxWpBTLA9EpqRxPBOy2+x2XuAoy0tR7Yeo+ukeON7hG1vg1Ij285uXgVWeFGFiqK9n9JKaAyzpRA7Deq7fJx++w9wOBlk7NamdXIIdhQR8OjB19R4YpgL7dQgQHEq2tp1fZI73Qe+a6MKVG0XkmpDutlW3HQFqMbxqRfwwjqe91ECsVXQ8HEMmBQcbo4EPzAPOqBzrMJpqGhGHo1K+mb7rzR17JhMY1Oy/5ezHETsx9jW5GcziID9xI96/npnD8xyO7ZH9HBTVpQxUJeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfv23rfb8IGlNys2uMYkaN3s/waPe37sjuF8GEQ7h9CEXISLLOqMR26AsNH6?=
 =?us-ascii?Q?1s3Aj2OC+HsS2ALMUwnNnkkBaMD1ZRldlXSSpxQNl3+ZGiuR01mAbP+RQT1P?=
 =?us-ascii?Q?SZYIKD7QSqTRksaExFIURTaYLl2DzUreDSd8XyTyqO9lXkwFhZ6C32G36bBb?=
 =?us-ascii?Q?WGKtMESc0j+A7gK+0hSAQlJWdGZcyGXbOdZ55iYm6VdfxdcKG4XLspEQB38e?=
 =?us-ascii?Q?pUoCPLKMabswrcndMRC3rQ2HQD5k0o9Idsbvs8IhsHnWtonVnRullqoaq/5W?=
 =?us-ascii?Q?CuloEOwVowwkGNa4vG6OH0Ns5xPFV8FZTLsXCQmEuegvPjpEoH+sONKVQsUm?=
 =?us-ascii?Q?3RaL8mnm8oY2lA5/BEZb9TyLLwfsqMW42uWzaWbTEqe15lJV2ut5xgL5n/uX?=
 =?us-ascii?Q?ESIH+y+td2czlZasx2segqVFsRM5wT2k5TWz+oBFWtyWPSSV5xhcdsMPWQcl?=
 =?us-ascii?Q?LY9DRYtRxc8hPwg9aKnORq9HmB2YpRsGizLWGgd0DHEP/y1+7l5TJ1b7c9HY?=
 =?us-ascii?Q?8w490NxIGZxQlu1O/865mWZUk3QJo0TSvWkGCvzRhykEFtE3bfN9Kli1slFh?=
 =?us-ascii?Q?rQcjc/h9oRHtp2Prr1VdUmL65lgvfKPpyKuOW6MuWQ6vmk4zNA01Vvz6eVtC?=
 =?us-ascii?Q?Q/xtS8L+T4VoY620BWhM2AnaQo8rDVPUzKIxYy0YPNYxId9LDijn603aSX/P?=
 =?us-ascii?Q?bN2i+qItT5rTkcw3l44qy3R8RT73ZsOoO/vjW/fYLdHDrzSIUCATHjW70cLX?=
 =?us-ascii?Q?Ax/+WDNnu9RKtqNhBoWI0UCyWm6SSuD8fFaHiL5aijULWLWTG2sMhVvX8d6G?=
 =?us-ascii?Q?6Bh2T1gjkgA2NqpSibfhzxaA10BK4/vPI/5Iy2XY7KrcEZloM83cDes0fksp?=
 =?us-ascii?Q?fQcQgMJIWO3H9lhmmyk2U2GQT9nnkqwEerSeA4fIUlQxcRe6Ip9TEgpPSRrm?=
 =?us-ascii?Q?l7T6ftOZwx6rHZJ4105KJXsk6vZPkx12Og3PJr4w33cmFF7ynfSTCqFp7HkP?=
 =?us-ascii?Q?/EvwQ71J+mjmgXsALSL7ZMP8ThSSzBghk+JNrnyi8w5Hqz9tpyUo6Et0kAt1?=
 =?us-ascii?Q?wC9lIB4SG4OL36Vqaaai8z9EWgUy1EnoOSxfiM/dtUZj32dhuAXA6Dr1UwBj?=
 =?us-ascii?Q?VDEMm/T4ffe4C6Oi8JFjQgChKcBGCpSIk4qCuHk3DCNyT0zyflc9yKB3qHDf?=
 =?us-ascii?Q?y9rqjne5yO1mpGhbja4mn1Bc6+A/1ZvBdahVTrNe7eBxcJmh3nulim8gr5RK?=
 =?us-ascii?Q?DPtCqEgPPeoEclO8OgVHZ53C3+R5M+ull6NdC410X2vt+6Gb5T2Ar9tdgGcV?=
 =?us-ascii?Q?c5cBl3yhZA+1tCIjQVYceSXW?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5049a6-5275-48e4-6bce-08d931a9c915
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:54.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XwgOIz9lwMsiKCVv0Bhg0MTw2U+kJf9aZMpfhVS8OGwZKhs2Be4y7gArPcetyUuGbptktxaHT5eceF7q+6wLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/sounding.h | 148 ++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.h

diff --git a/drivers/net/wireless/celeno/cl8k/sounding.h b/drivers/net/wire=
less/celeno/cl8k/sounding.h
new file mode 100644
index 000000000000..d5d9d4941b23
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sounding.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_SOUNDING_H
+#define CL_SOUNDING_H
+
+#include <linux/types.h>
+#include "fw/fw_msg.h"
+
+#define SOUNDING_ENABLE                                true
+#define SOUNDING_DISABLE                               false
+#define INVALID_SID                                    0xff
+#define XMEM_SIZE                                      (0x180 << 10) /* 38=
4KB */
+#define CL_SOUNDING_STABILITY_TIME                     5
+#define CL_SOUNDING_FACTOR                             10
+
+#define SOUNDING_FEEDBACK_TYPE_SHIFT                   2
+#define SOUNDING_FEEDBACK_TYPE_MASK                    (BIT(SOUNDING_FEEDB=
ACK_TYPE_SHIFT))
+#define SOUNDING_NG_SHIFT                              1
+#define SOUNDING_NG_MASK                               (BIT(SOUNDING_NG_SH=
IFT))
+#define SOUNDING_MU_CODEBOOK_SIZE_SHIFT                0
+#define SOUNDING_MU_CODEBOOK_SIZE_MASK                 (BIT(SOUNDING_MU_CO=
DEBOOK_SIZE_SHIFT))
+#define SOUNDING_FEEDBACK_TYPE_VAL(fb_type_ng_cb_size) (((fb_type_ng_cb_si=
ze) & \
+                                                         SOUNDING_FEEDBACK=
_TYPE_MASK) >> \
+                                                         SOUNDING_FEEDBACK=
_TYPE_SHIFT)
+#define SOUNDING_NG_VAL(fb_type_ng_cb_size)            (((fb_type_ng_cb_si=
ze) & \
+                                                         SOUNDING_NG_MASK)=
 >> SOUNDING_NG_SHIFT)
+#define SOUNDING_CODEBOOK_SIZE_VAL(fb_type_ng_cb_size) (((fb_type_ng_cb_si=
ze) & \
+                                                         SOUNDING_MU_CODEB=
OOK_SIZE_MASK) >> \
+                                                         SOUNDING_MU_CODEB=
OOK_SIZE_SHIFT)
+
+#define SOUNDING_TYPE_IS_VHT(type)                     ((type) =3D=3D SOUN=
DING_TYPE_VHT_SU || \
+                                                       (type) =3D=3D SOUND=
ING_TYPE_VHT_MU)
+#define SOUNDING_TYPE_IS_CQI(type)                     ((type) =3D=3D SOUN=
DING_TYPE_HE_CQI || \
+                                                       (type) =3D=3D SOUND=
ING_TYPE_HE_CQI_TB)
+
+enum fb_type_ng_cb_size {
+       FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_4_2 =3D 0x0,
+       FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_6_4,
+       FEEDBACK_TYPE_SU_NG_16_CODEBOOK_SIZE_4_2,
+       FEEDBACK_TYPE_SU_NG_16_CODEBOOK_SIZE_6_4,
+       FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_7_5,
+       FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_7,
+       FEEDBACK_TYPE_CQI_TB,
+       FEEDBACK_TYPE_MU_NG_16_CODEBOOK_SIZE_9_7,
+};
+
+enum cl_sounding_response {
+       CL_SOUNDING_RSP_OK =3D 0,
+
+       CL_SOUNDING_RSP_ERR_RLIMIT,
+       CL_SOUNDING_RSP_ERR_BW,
+       CL_SOUNDING_RSP_ERR_NSS,
+       CL_SOUNDING_RSP_ERR_INTERVAL,
+       CL_SOUNDING_RSP_ERR_ALREADY,
+       CL_SOUNDING_RSP_ERR_STA,
+       CL_SOUNDING_RSP_ERR_TYPE,
+};
+
+enum sounding_type {
+       SOUNDING_TYPE_HE_SU =3D 0,
+       SOUNDING_TYPE_HE_SU_TB,
+       SOUNDING_TYPE_VHT_SU,
+       SOUNDING_TYPE_HE_CQI,
+       SOUNDING_TYPE_HE_CQI_TB,
+       SOUNDING_TYPE_HE_MU,
+       SOUNDING_TYPE_VHT_MU,
+
+       SOUNDING_TYPE_MAX
+};
+
+enum sounding_interval_coef {
+       SOUNDING_INTERVAL_COEF_MIN_INTERVAL =3D 0,
+       SOUNDING_INTERVAL_COEF_STA_STEP,
+       SOUNDING_INTERVAL_COEF_INTERVAL_STEP,
+       SOUNDING_INTERVAL_COEF_MAX_INTERVAL,
+       SOUNDING_INTERVAL_COEF_MAX
+};
+
+struct cl_hw;
+
+struct v_matrix_header {
+       u32 format        : 2,
+           rsv1          : 30;
+       u32 bw            : 2,
+           nr_index      : 3,
+           nc_index      : 3,
+           rsv2          : 24;
+       u32 grouping      : 4,
+           rsv3          : 28;
+       u32 feedback_type : 1,
+           codebook_info : 3,
+           rsv4          : 28;
+       u32 ru_start_idx  : 7,
+           rsv5          : 25;
+       u32 ru_end_idx    : 7,
+           rsv6          : 25;
+       u32 padding       : 6,
+           rsv7          : 26;
+       u32 rsv8;
+};
+
+struct cl_sounding_info {
+       enum sounding_type type;
+       u8 sounding_id;
+       struct v_matrix_header *v_matrices_data;
+       u32 v_matrices_data_len;
+       u32 v_matrices_dma_addr;
+       u8 gid;
+       u8 bw;
+       u8 sta_num;
+       u8 q_matrix_bitmap;
+       struct cl_sta *su_cl_sta_arr[CL_MU_MAX_STA_PER_GROUP];
+       u32 xmem_space;
+       bool sounding_restart_required;
+       struct list_head list;
+};
+
+struct cl_sounding_db {
+       struct workqueue_struct *sounding_wq;
+       u8 num_soundings;
+       u8 cqi_profiles; /* Num of STAs with CQI active sounding */
+       u8 active_profiles; /* Num of STAs with non-CQI active sounding */
+       u8 active_profiles_prev[CL_SOUNDING_STABILITY_TIME];
+       u8 active_profiles_idx;
+       u8 dbg_level;
+       u8 current_interval;
+       u8 last_conf_active_profiles;
+       rwlock_t list_lock;
+       struct list_head head;
+};
+
+void cl_sounding_init(struct cl_hw *cl_hw);
+void cl_sounding_close(struct cl_hw *cl_hw);
+void cl_sounding_send_request(struct cl_hw *cl_hw, struct cl_sta **cl_sta_=
arr,
+                             u8 sta_num, bool enable, u8 sounding_type, u8=
 bw,
+                             u8 q_matrix_bitmap, struct cl_sounding_info *=
recovery_elem);
+void cl_sounding_switch_profile(struct cl_hw *cl_hw, u8 sta_idx_en, u8 sta=
_idx_dis);
+u8 cl_sounding_get_active_profiles(struct cl_hw *cl_hw);
+void cl_sounding_stop_by_sid(struct cl_hw *cl_hw, u8 sid, bool sounding_re=
start_check);
+void cl_sounding_maintenance(struct cl_hw *cl_hw);
+u16 cl_sounding_get_interval(struct cl_hw *cl_hw);
+void cl_sounding_recovery(struct cl_hw *cl_hw);
+struct cl_sounding_info *cl_sounding_get_elem(struct cl_hw *cl_hw, u8 soun=
ding_id);
+void cl_sounding_indication(struct cl_hw *cl_hw, struct mm_sounding_ind *i=
nd);
+int cl_sounding_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_SOUNDING_H */
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

