Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12E23AB898
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFQQJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:09 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:41442
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhFQQIG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjb8qqG3QfxSMzRxRX7MUhi+/SG9SgHy5wQEhr8yXUWRTEulb26sxUGBKvIPeA3Sb6MC5pC6l6t6FNr49R2BbkLuaWgVeJ2eYA2WWdliV/4k6E/35FQ65QmTJWDVjzjrByxLuJZxxKHwkNLCxawLQzdy+ZMn/GcuFHR7oSJ2nBpXd2npal2oKVvaJuSSM+JMF2rZOZHvk8M0Tfatywle/8hE86KACewjwAPkEOdbYoPjQ6u6fhxTKDUI75mEcTuo0zQt0QFkQOmmtLfU/zFnxOt4wcUGFLYtGpqsMjdGrbBw0fh5RwRsf+DGQ2Ddp+GjZlfPPU6SUTVd+zO/zQRf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd16VHWT4vt5w/nR3aDImuF4ZQfa/KxsXT/3NUY1nvs=;
 b=aSfkaIPfjnzESLAqq8R369PoN5D3ai/dRF4aLorJRnbHZJMKqBnCHK+RvK0VLm/W501Wof8Rti3P/Iw88AgiS+rtvJb8MnTx7N+u64URaLIY4miATDDL1JyhiqBTYubS5niRmvKeRy1u5nhpVFJOuA7cOyLpuTroeELg2oL/ZYVa2uwR5CuiFqXjkGswqP8SazOFBhZUbf93XhdxPqz2eJtCQFr2N/+zvLVVuWK0bWBXQVlUP9rBQva2PSJ5P6QXLgJKKbzmxmmKpRgGZhTcwTNd1ELX1xvqSDxY9NhI37kVTCPcYpkdxYR5XhURCZEiQx8ZHgzks+MpTuJI5gSG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd16VHWT4vt5w/nR3aDImuF4ZQfa/KxsXT/3NUY1nvs=;
 b=yAa8MCbEYdJwzartZYbU6SCn3JdIFU96IgMLM7qblfpmICdpWxmwy8zR7WwAhOC96vqCTA7FchmxbMFnuuL5D1/A6zjbSHJr7gBHuOwFXJuNACadUtPHIX8VTDqSeeao17xTxAmwD2JReWhtpl8HNyrHsf+iaFTmVLU3KL9L7Sw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:10 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:10 +0000
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
Subject: [RFC v1 115/256] cl8k: add motion_sense.c
Date:   Thu, 17 Jun 2021 16:00:02 +0000
Message-Id: <20210617160223.160998-116-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efd3fc6-a637-4b29-2065-08d931a99d7a
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0402179D92780A508E3CA4CEF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svVjPVgVxwMw/O2tlOjm9ScrZ79iO+6oFYC5EDEe2VN3PZ2Gbc7I/1YyDLKyteQ9bwBv3aRIkk/VcCo9aCY18DI1RfluiRdZLr4nq6FfLGtbo8/tC+3yFv3G6c4tJ/cdiWQRHp713eMsldwVvj1+qtl9Cp2AK0SmpZCQx5JUEQe75vflhi02ABGRrOGVofFuZy521E19v9Nq1oAA3sQAjeNAHvw2LDaEpN2P6jIYS+do5oPv8ZcT5nubj01HyA5JfyNaZ+Snoa1Q1uB2oKNGq7puUEHD1/VpcRXc9TnjZdFQ6+riquxM35eG7GwpqG36y5MaAxk2sR7FvUUSzq+7GngunQqaxjeoE54CgZ/Ysu3vZ7/7pLAf7FhU49aI2D2zmMROoq1tURR385XJBGgfcr08y59Fy5EHLnDxe/iT/TIuB6z7RoSeKUSPaboV+Wijox+W5Y/OZSF9QXNEc4f4f7n6cHIxeKgq5icjyaqrnQzcnnlOqZH/ZRQtI12YX/95AAk1oWOyLmPM1oD9/Df2zrORloHOl44rBuS9Fqar/gmvLaftySnJobala8XTVqbJerewUzQ6RZeRW5bMWzHx/Z7PQwg1iC0CErO7HWjZbrNKd4osaNQm8JAO1kl8gsBQDWEGD7Yx1yal1Bc4Kd5JA+3/wRTekVZ3XrYWOz3LOWDue2OjwbNRDooVffieEbpY4nGKFMouaQDU9XMhfPJeFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(30864003)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOKrgRUj4H/zDKTMMOZ9KNk/QqgCneu0lW6OWKcpbm4wOz5Ye6vmunWg9FIW?=
 =?us-ascii?Q?XZ2HI3tHsI1rUODRKnC2MUoQPXtafZdD2b9GedbkjGc7+byfB4zDph9E0QuG?=
 =?us-ascii?Q?TlLOkH+2wjRu449PrDjW6ZLQ/HseTBawQhAGITD1ClcS0snrdxExSZK3auij?=
 =?us-ascii?Q?g/5oenuJ++9lkK5Vo8zAI8x09xiBGFMjP8YzqjKHs/T7RE7CE1RiN9vualP7?=
 =?us-ascii?Q?ujE0sHtT2IPvuyoAdQXqq2RCyYdoBw+1gyqXMuP/9hb5ZhArmrXf8TDZKDvI?=
 =?us-ascii?Q?S2LCTGIe1iKwt+l3eRBqWcWE0kvgkJTWgxlIvTKPLc5v2fj7yMOj1fafUdMK?=
 =?us-ascii?Q?WBT7lcASV0I9Gwi27bbopb2SR+mhHfR1HoS1CAJQwrVNXCKG25PnLgiGwz0P?=
 =?us-ascii?Q?4Me3TKAhfpcxxBj1klOWRfTcbH8p7NiKKNT8LoRoqXfQEspy4pN5RyC3eEcT?=
 =?us-ascii?Q?XmOEzCF/xAiZ07dDuAr6RCOkRjGhcMjTmzOAgnWrponyoRYk+uITBlmyYgaF?=
 =?us-ascii?Q?lnOrriXGIsw0Xkf4OTnXWbx1FNTkfP1+WCUChekqkXfVDA1wc0Y30k/71FIT?=
 =?us-ascii?Q?9fIotBoelrBCitQXEvdqrut1wsL5fnSwRhZkZPQJvqGaxWtgwpEFhVFogBAH?=
 =?us-ascii?Q?myas9kidJMB/kRU6ZbWN8UReB2kLbbTAiOyeWEGkeczIzAERKzMth6aZEGUU?=
 =?us-ascii?Q?KrCAdGkdUhBg2XrONx88arGk5zSWA+wR4rO23F+a26hbvxz35jQh4nvO9Doq?=
 =?us-ascii?Q?CfCvoedLT1pRNIjMhkhmz47AWJm3Amng3gqc5LSM3Fw0IRLWaWerkBf4M2Bt?=
 =?us-ascii?Q?Mof3EL8HoOavdp7uRHPGZ6wlZpoVd2FUpYqdvtCiTOt9ImB6Gs/CMZoAj251?=
 =?us-ascii?Q?1hjsB+tr+ZaLvmqME5ZLxBkmwe097AOqT5Dv7a6VozJVGtGN5e3AFAquOBwY?=
 =?us-ascii?Q?viCEWO/RClmPfdd+JrNhvI6Oz0d/dNFj8Oa+YtVZWjLea6K3h8oM1514IP8/?=
 =?us-ascii?Q?Ewkau3DpRvX1nM8JLMGQdqpUQ3Nr2EbFkZZMO010Wl7lS81mWn0Q9LUDQg94?=
 =?us-ascii?Q?PrFhrGSMhuPMpXCEzhdh4RBjsAKm3Odf+zmmO3yWEGEbqgaUdDGjYK1JainN?=
 =?us-ascii?Q?q8XT4koIeiM+bLTAGRXmLKozQAXS/rlzQvAUazG0wUkCxyn0vxyGFi2xwPiH?=
 =?us-ascii?Q?MMWD1mfrl6iwdUz4BBgLayjexH3QZLird4cdDtWEKgie3PKk2J5QRr+L9xTR?=
 =?us-ascii?Q?8fALcvHyXzkkGblpAI8FbUxbchhV7LgSYpcejjGotv5gYfzaeW2AabnmJtj4?=
 =?us-ascii?Q?VTsjtwFhEa9zjrtJ9SEme1vy?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd3fc6-a637-4b29-2065-08d931a99d7a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:41.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcM+MIx7yEqIfF9vEMGm5d3zAcN4VEXTZn9rOwUMgBz+gV+wr2ODaqzgvfhEbcY5T6GnU68xdJehMb7v02FLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/motion_sense.c   | 458 ++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.c

diff --git a/drivers/net/wireless/celeno/cl8k/motion_sense.c b/drivers/net/=
wireless/celeno/cl8k/motion_sense.c
new file mode 100644
index 000000000000..bd8b1c6df08e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/motion_sense.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "motion_sense.h"
+#include "rssi.h"
+#include "chip.h"
+
+#define MOTION_PRINT(...) \
+       do { \
+               if (cl_hw->motion_sense_dbg) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+/* Minimum time (+1) for taking a decison */
+#define MOTION_SENSE_MIN_DECISION_MGMT_CTL 4
+#define MOTION_SENSE_MIN_DECISION_DATA     9
+#define MOTION_SENSE_MIN_DECISION_BA       9
+
+#define MOTION_STATE_STR(state) \
+       (((state) =3D=3D STATE_NULL) ? "NULL" : \
+       (((state) =3D=3D STATE_MOVING) ? "MOVING" : "STATIC")) \
+
+static void _cl_motion_sense_sta_add(struct cl_motion_rssi *motion_rssi)
+{
+       motion_rssi->max =3D S8_MIN;
+       motion_rssi->min =3D S8_MAX;
+}
+
+void cl_motion_sense_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       _cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_mgmt_ctl);
+       _cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_data);
+       _cl_motion_sense_sta_add(&cl_sta->motion_sense.rssi_ba);
+}
+
+static void cl_motion_sense_rssi_handler(struct cl_hw *cl_hw,
+                                        struct cl_motion_rssi *motion_rssi=
,
+                                        s8 rssi[MAX_ANTENNAS])
+{
+       u8 i;
+
+       motion_rssi->cnt++;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               motion_rssi->sum[i] +=3D rssi[i];
+}
+
+void cl_motion_sense_rssi_mgmt_ctl(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta,
+                                  struct hw_rxhdr *rxhdr)
+{
+       /* RSSI of mgmt and ctl packets */
+       if (cl_hw->conf->ci_motion_sense_en) {
+               s8 rssi[MAX_ANTENNAS] =3D RX_HDR_RSSI(rxhdr);
+
+               cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.r=
ssi_mgmt_ctl, rssi);
+       }
+}
+
+void cl_motion_sense_rssi_data(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct hw_rxhdr *rxhdr)
+{
+       /* RSSI of data packets */
+       s8 rssi[MAX_ANTENNAS] =3D RX_HDR_RSSI(rxhdr);
+
+       if (!cl_hw->conf->ci_motion_sense_en)
+               return;
+
+       cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.rssi_data=
, rssi);
+}
+
+void cl_motion_sense_rssi_ba(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
8 rssi[MAX_ANTENNAS])
+{
+       /* RSSI of block-acks */
+       if (cl_hw->conf->ci_motion_sense_en)
+               cl_motion_sense_rssi_handler(cl_hw, &cl_sta->motion_sense.r=
ssi_ba, rssi);
+}
+
+static s8 cl_motion_sense_calc_new_rssi(struct cl_hw *cl_hw, struct cl_mot=
ion_rssi *motion_rssi)
+{
+       u8 i =3D 0;
+       s8 rssi_avg[MAX_ANTENNAS] =3D {0};
+
+       /* Calculate average rssi */
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               rssi_avg[i] =3D (s8)(motion_rssi->sum[i] / motion_rssi->cnt=
);
+
+       /* Reset rssi sum for next maintenance cycle */
+       memset(motion_rssi->sum, 0, sizeof(motion_rssi->sum));
+       motion_rssi->cnt =3D 0;
+
+       return cl_rssi_calc_equivalent(cl_hw, rssi_avg);
+}
+
+static void cl_motion_sense_state(struct cl_hw *cl_hw, struct cl_motion_rs=
si *motion_rssi,
+                                 u8 sta_idx, u8 min_history, const s8 *typ=
e)
+{
+       u8 i =3D 0;
+       s8 rssi_new =3D 0, rssi_old =3D 0;
+
+       if (motion_rssi->cnt =3D=3D 0)
+               return;
+
+       /* Get new and old rssi */
+       rssi_new =3D cl_motion_sense_calc_new_rssi(cl_hw, motion_rssi);
+       rssi_old =3D motion_rssi->history[motion_rssi->idx];
+
+       /* Add new rssi to history and increase history index */
+       motion_rssi->history[motion_rssi->idx] =3D rssi_new;
+
+       motion_rssi->idx++;
+       if (motion_rssi->idx =3D=3D MOTION_SENSE_SIZE)
+               motion_rssi->idx =3D 0;
+
+       /* Check if new rssi is max or min */
+       if (rssi_new > motion_rssi->max) {
+               motion_rssi->max =3D rssi_new;
+               goto out;
+       } else if (rssi_new < motion_rssi->min) {
+               motion_rssi->min =3D rssi_new;
+               goto out;
+       }
+
+       /*
+        * Check if old rssi was max or min.
+        * If so, go over history and find new max/min
+        */
+       if (rssi_old =3D=3D motion_rssi->max) {
+               motion_rssi->max =3D S8_MIN;
+
+               for (i =3D 0; i < MOTION_SENSE_SIZE; i++) {
+                       if (motion_rssi->history[i] =3D=3D 0)
+                               break;
+
+                       if (motion_rssi->history[i] > motion_rssi->max)
+                               motion_rssi->max =3D motion_rssi->history[i=
];
+               }
+       } else if (rssi_old =3D=3D motion_rssi->min) {
+               motion_rssi->min =3D S8_MAX;
+
+               for (i =3D 0; i < MOTION_SENSE_SIZE; i++) {
+                       if (motion_rssi->history[i] =3D=3D 0)
+                               break;
+
+                       if (motion_rssi->history[i] < motion_rssi->min)
+                               motion_rssi->min =3D motion_rssi->history[i=
];
+               }
+       }
+
+out:
+       /* Wait X second after connection, before making first decision */
+       if (motion_rssi->history[min_history] =3D=3D 0)
+               return;
+
+       /* According to delta decide if station is STATIC or in MOTION */
+       if ((motion_rssi->max - motion_rssi->min) < cl_hw->conf->ci_motion_=
sense_rssi_thr) {
+               if (motion_rssi->state =3D=3D STATE_STATIC)
+                       return;
+
+               motion_rssi->state =3D STATE_STATIC;
+
+               MOTION_PRINT("[MOTION_SENSE] %s - sta_idx=3D%u, min=3D%d, m=
ax=3D%d, state=3DSTATIC\n",
+                            type, sta_idx, motion_rssi->min, motion_rssi->=
max);
+       } else {
+               if (motion_rssi->state =3D=3D STATE_MOVING)
+                       return;
+
+               motion_rssi->state =3D STATE_MOVING;
+
+               MOTION_PRINT("[MOTION_SENSE] %s - sta_idx=3D%u, min=3D%d, m=
ax=3D%d, state=3DMOVING\n",
+                            type, sta_idx, motion_rssi->min, motion_rssi->=
max);
+       }
+}
+
+static void _cl_motion_sense_dump(char **buf, int *len, ssize_t *buf_size,
+                                 struct cl_motion_rssi *motion_rssi,
+                                 const s8 *type)
+{
+       int delta =3D motion_rssi->max - motion_rssi->min;
+       int i;
+
+       cl_snprintf(buf, len, buf_size, "\n");
+       cl_snprintf(buf, len, buf_size, "type =3D %s\n", type);
+       cl_snprintf(buf, len, buf_size,
+                   "state =3D %s\n", MOTION_STATE_STR(motion_rssi->state))=
;
+       cl_snprintf(buf, len, buf_size,
+                   "min =3D %d\n", motion_rssi->min);
+       cl_snprintf(buf, len, buf_size,
+                   "max =3D %d\n", motion_rssi->max);
+       cl_snprintf(buf, len, buf_size,
+                   "delta =3D %d\n", delta);
+       cl_snprintf(buf, len, buf_size,
+                   "idx =3D %u\n", motion_rssi->idx);
+
+       for (i =3D 0; i < MOTION_SENSE_SIZE; i++) {
+               if (motion_rssi->history[i])
+                       cl_snprintf(buf, len, buf_size,
+                                   "%2i) =3D %3d, ", i, motion_rssi->histo=
ry[i]);
+               else
+                       break;
+
+               if ((i % 8) =3D=3D 7)
+                       cl_snprintf(buf, len, buf_size, "\n");
+       }
+
+       cl_snprintf(buf, len, buf_size, "\n");
+}
+
+static int cl_motion_sense_dump(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       struct cl_motion_sense *motion_sense =3D NULL;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_sta_lock_bh(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+       if (!cl_sta) {
+               pr_err("[MS] Invalid sta_idx =3D %u\n", sta_idx);
+               goto out;
+       }
+
+       motion_sense =3D &cl_sta->motion_sense;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "sta_idx =3D %u\n", sta_idx);
+
+       if (motion_sense->forced_state !=3D STATE_NULL) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "forced_state =3D %s\n",
+                           MOTION_STATE_STR(motion_sense->forced_state));
+               goto out;
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "combined_state =3D %s\n",
+                   MOTION_STATE_STR(motion_sense->combined_state));
+
+       _cl_motion_sense_dump(&buf, &len, &buf_size, &motion_sense->rssi_mg=
mt_ctl, "mgmt/ctl");
+       _cl_motion_sense_dump(&buf, &len, &buf_size, &motion_sense->rssi_ba=
, "ba");
+       _cl_motion_sense_dump(&buf, &len, &buf_size, &motion_sense->rssi_da=
ta, "data");
+
+out:
+       cl_sta_unlock_bh(cl_hw);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_motion_sense_moving(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta,
+                                  struct cl_motion_sense *motion_sense)
+{
+       if (motion_sense->combined_state !=3D STATE_MOVING) {
+               motion_sense->combined_state =3D STATE_MOVING;
+               MOTION_PRINT("[MOTION_SENSE] sta_idx =3D %u, combined_state=
 =3D MOVING\n",
+                            cl_sta->sta_idx);
+       }
+}
+
+static void cl_motion_sense_static(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta,
+                                  struct cl_motion_sense *motion_sense)
+{
+       if (motion_sense->combined_state !=3D STATE_STATIC) {
+               motion_sense->combined_state =3D STATE_STATIC;
+               MOTION_PRINT("[MOTION_SENSE] sta_idx =3D %u, combined_state=
 =3D STATIC\n",
+                            cl_sta->sta_idx);
+       }
+}
+
+static void cl_motion_sense_combined_state(struct cl_hw *cl_hw, struct cl_=
sta *cl_sta)
+{
+       struct cl_motion_sense *motion_sense =3D &cl_sta->motion_sense;
+
+       if (motion_sense->rssi_mgmt_ctl.history[MOTION_SENSE_MIN_DECISION_M=
GMT_CTL] =3D=3D 0 &&
+           motion_sense->rssi_data.history[MOTION_SENSE_MIN_DECISION_DATA]=
 =3D=3D 0 &&
+           motion_sense->rssi_ba.history[MOTION_SENSE_MIN_DECISION_BA] =3D=
=3D 0)
+               return;
+
+       if (motion_sense->rssi_mgmt_ctl.state =3D=3D STATE_MOVING ||
+           motion_sense->rssi_data.state =3D=3D STATE_MOVING ||
+           motion_sense->rssi_ba.state =3D=3D STATE_MOVING)
+               cl_motion_sense_moving(cl_hw, cl_sta, motion_sense);
+       else
+               cl_motion_sense_static(cl_hw, cl_sta, motion_sense);
+}
+
+static void cl_motion_sense_maintenance_sta(struct cl_hw *cl_hw, struct cl=
_sta *cl_sta)
+{
+       u8 sta_idx =3D cl_sta->sta_idx;
+       struct cl_motion_sense *motion_sense =3D &cl_sta->motion_sense;
+
+       cl_motion_sense_state(cl_hw, &motion_sense->rssi_mgmt_ctl, sta_idx,
+                             MOTION_SENSE_MIN_DECISION_MGMT_CTL, "mgmt/ctl=
");
+       cl_motion_sense_state(cl_hw, &motion_sense->rssi_data, sta_idx,
+                             MOTION_SENSE_MIN_DECISION_DATA, "data");
+       cl_motion_sense_state(cl_hw, &motion_sense->rssi_ba, sta_idx,
+                             MOTION_SENSE_MIN_DECISION_BA, "ba");
+
+       if (motion_sense->forced_state !=3D STATE_NULL)
+               return;
+
+       cl_motion_sense_combined_state(cl_hw, cl_sta);
+}
+
+void cl_motion_sense_maintenance(struct cl_hw *cl_hw)
+{
+       cl_sta_loop(cl_hw, cl_motion_sense_maintenance_sta);
+}
+
+bool cl_motion_sense_is_static(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       return (cl_sta->motion_sense.combined_state =3D=3D STATE_STATIC);
+}
+
+static void cl_motion_sense_force_state(struct cl_hw *cl_hw, u8 sta_idx, u=
8 state)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       struct cl_motion_sense *motion_sense =3D NULL;
+
+       cl_sta_lock_bh(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+       if (!cl_sta) {
+               pr_err("[MS] Invalid station (%u)\n", sta_idx);
+               goto out;
+       }
+
+       motion_sense =3D &cl_sta->motion_sense;
+
+       switch (state) {
+       case STATE_NULL:
+               pr_debug("[MS] Disable force state\n");
+               break;
+       case STATE_MOVING:
+               pr_debug("[MS] Force state - MOVING\n");
+               cl_motion_sense_moving(cl_hw, cl_sta, motion_sense);
+               break;
+       case STATE_STATIC:
+               pr_debug("[MS] Force state - STATIC\n");
+               cl_motion_sense_static(cl_hw, cl_sta, motion_sense);
+               break;
+       default:
+               pr_warn("[MS] Invalid state (%u)\n", state);
+               goto out;
+       }
+
+       motion_sense->forced_state =3D state;
+
+out:
+       cl_sta_unlock_bh(cl_hw);
+}
+
+static int cl_motion_sense_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "motion usage:\n"
+                "-d: Set debug [0/1]\n"
+                "-e: Set enable [0/1]\n"
+                "-f: Force state [sta_idx].[0-null, 1-moving, 2-static]\n"
+                "-i: Dump info [sta_idx]\n"
+                "-r: Set rssi threshold [rssi]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_motion_sense_cli(struct cl_hw *cl_hw, struct cli_params *cli_params=
)
+{
+       u32 expected_params =3D 0;
+       bool set_debug =3D false;
+       bool set_enable =3D false;
+       bool force_state =3D false;
+       bool dump_info =3D false;
+       bool set_rssi_thr =3D false;
+
+       switch (cli_params->option) {
+       case 'd':
+               set_debug =3D true;
+               expected_params =3D 1;
+               break;
+       case 'e':
+               set_enable =3D true;
+               expected_params =3D 1;
+               break;
+       case 'f':
+               force_state =3D true;
+               expected_params =3D 2;
+               break;
+       case 'i':
+               dump_info =3D true;
+               expected_params =3D 1;
+               break;
+       case 'r':
+               set_rssi_thr =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_motion_sense_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (set_debug) {
+               cl_hw->motion_sense_dbg =3D (bool)cli_params->params[0];
+               pr_debug("[MS] debug =3D %u\n", cl_hw->motion_sense_dbg);
+               return 0;
+       }
+
+       if (dump_info) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               return cl_motion_sense_dump(cl_hw, sta_idx);
+       }
+
+       if (set_enable) {
+               cl_hw->conf->ci_motion_sense_en =3D (bool)cli_params->param=
s[0];
+               pr_debug("[MS] ci_motion_sense_en =3D %s\n",
+                        cl_hw->conf->ci_motion_sense_en ? "true" : "false"=
);
+               return 0;
+       }
+
+       if (force_state) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u8 state =3D (u8)cli_params->params[1];
+
+               cl_motion_sense_force_state(cl_hw, sta_idx, state);
+               return 0;
+       }
+
+       if (set_rssi_thr) {
+               cl_hw->conf->ci_motion_sense_rssi_thr =3D (s8)cli_params->p=
arams[0];
+               pr_debug("[MS] ci_motion_sense_rssi_thr =3D %d\n",
+                        cl_hw->conf->ci_motion_sense_rssi_thr);
+               return 0;
+       }
+
+out_err:
+       return -EIO;
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

