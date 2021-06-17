Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC113AB929
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhFQQNI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:08 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:11146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231906AbhFQQLz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFLm1E5ZRDf49cK6p5gu5E+PFM8snVDuGm3IcXKhH1xh+Q/pH/jT9+oQiVXzwNjvsxDFgGdjXV0mYNrYtMWF0GH8BKH6Q2OpAmzd70iS83p0GOx9Tu6Deyc4cbk/YWqtqjAzkwKsgCl+RKg20nrYEzp1x2/AV98F0Ze0w/VFK3MNRa/go40cjgyx2CZzy8M+NyyB1w4khc8xv1AEArVwXSvXyPQUuGtSQeNc8CThoJHGTyNUgDXADweJnOQUA68gdwp+EufhXvAoIoA6d8Z4EWGC3GoYqrwTgXW40uLQ5YRp8RmrttfU8USSc2YhoYnLRnXJ9j+6g6wLCws0TDXb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3UxZnj2rS0Io0WXeqWAFacb052qkJ9mrvfBQqlZCPk=;
 b=e1MZ2V2TstdgmnE7QYHvtIvDnmp9GJInSYs3mdyyB5Zc4P9VV0Za45g6v/nGCJlURygB4i3eYXH5gT7JcDUzQCaFay4Kufq0Ww0tSXYE6oK4lX9l8t8u6K/uzHjvH/NIVUuBfqDQN3pfGOwU0b+iDeo8T45TCOENkWIZLWISk1RE9W+JeDiRzkkk6WZDEFBIpNzVa81pN9tFA8oexBfdSZujtwBBq2qGczjNdYv9jaYBwHmezzaNaknIW30rqr0LsDaJ2bSsuwKEN+n2gfsooqwqXYC4SkVdq8umd5K7Fg/dzWlt9RPMyTPwjYYGWiLgeu955yn491hkMXOnc2ACeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3UxZnj2rS0Io0WXeqWAFacb052qkJ9mrvfBQqlZCPk=;
 b=cbkEtrLApHd9n8rRXSthU214EXCauSQfTZ3R0/fqk1cCR9cOsyg68aKnd5Wv/U+q/OCrG22N/laKQOUTd3jiQqMtq3o2IFRgqpI5YNu/yX+P36OnMy49SRxyH4uXdl7hOkCkJLQdL1ELxmPX+IWoBt6oDIZai6N0ckhptx+00Po=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:33 +0000
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
Subject: [RFC v1 245/256] cl8k: add wrs/wrs_cli.c
Date:   Thu, 17 Jun 2021 16:02:12 +0000
Message-Id: <20210617160223.160998-246-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 915a6e61-5cb9-453a-8f42-08d931a9f4cf
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978D18F46344553B10CAD0CF60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5C3a1T2kZJG4+YvwerpuS2eJ2gL4PChjpwZBU2q28ECv0NfedGfqo2bkRK/YlrjPNOea2MbIggJkmLdOKnXUbRWCOoIDieOBNbb+39DY6VCbJJrbhGN6MzowYKIDzNmgTKm5KL4VWwuDeE6unD3cT6aFtDORzhoZZ5ctG5eNUPN8VxrN1OEhSzxWXpsVE22Vw5Haokprv1EQincGc9QOOnQF/464IrtH+zyyGYBj42Sev4wtFVHLAKromdUzgDit7fYAsThL4WS050dmtoXb744F7SSsoPeWnHeh0CIjuvGQewa9MAJOf4qI0Z3/rx5MNyORKBF3IXIzlcmPpZdBgusROqapjL3+kmzW4IrZIYTznlNNAQHh+6LLERhN6LWUQUh9jt46sQ4fLu4LANZDDJTxl2r2OOZ8rSBBVJUJd6hxDSkoBN5LkkF//8KXjRzhb+xI13FHvaAP5sK58EskCLVEBaGzy8RwkRD7UFf6v8nT7ENY9NqEXNVaOvS9cGQOtaWdlMPB+N0dd8ZSd6RnOa4rr+nG5yFS/DiaPOLqj02ITT5195TqCS+eAPxn+k8VOM8aSd1f9CM0grQgARf1AQoO35CYYOyFLSQ9rui2Y3huI+VOMkIRH+1yTeITR0YsGLAIM0Tr/fmjQmMGV/jW2JAUMlnuZEiV+QKG1NEGz2lhci7ieIJiBkdM3XOCQdHCupSDtU/TaCswwgjBJB47g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(6666004)(5660300002)(66556008)(83380400001)(26005)(30864003)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(45080400002)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmBsJQJ3RPrGAidkjRYVq+sb3kP8d1Xcx6t4RA1aGkA/SUw9D+OQC9p9AZ6P?=
 =?us-ascii?Q?0xltF2JKo39wOqcpC4v8ppOnwK8Woz6Pl+YmdOFAuic7pYHflqRuY0DZj5CI?=
 =?us-ascii?Q?xwic7HHp30dKuKVeSSvmCyIW1wpdD93nWcwRCHf1wNutR8ugQSRIzlNkovPv?=
 =?us-ascii?Q?XUY95f3yfAurIxk0YBkGVODB40L0M1bhKtc+VctBL3bwKD2gcBr2bT/Q4ejc?=
 =?us-ascii?Q?elhKbQpm9VIjkP1jgnZjW7AWgvvlivaxyYxAK8vCogKF+WkVUd7ERKqPYypi?=
 =?us-ascii?Q?iIU9ePI9UVBQi1ANLmuvBNWnwrG52h0Cy5JVxWzX4O2cSBjseQYBPLXuYED6?=
 =?us-ascii?Q?H6QIqYB56AInsSc/zJFQId+D1xoaDbBrDn3V03UPV3uFh8i7otM+fQrjMSpA?=
 =?us-ascii?Q?LnK3nL2uDkWl1+k/DrkVRjl1I9O/5IHUI0PfhVCbJh0xe4HuaMksc94jpBH5?=
 =?us-ascii?Q?hjtRacNSi7DctizAOiKRGzJGju5FlG5pbXroiXP3dCcUQCKzPvakajTqXx4/?=
 =?us-ascii?Q?N6dl/pV2HcYz/dKnida/RNy5ttPV6wGUx8u9RHgnn1uilcAXwjiCIwdDLLu2?=
 =?us-ascii?Q?icqqgLxH/llaHCnlnTteh+SxGMBHLbHE1BE/obKvf/4yiEEnclNS55m9rPx+?=
 =?us-ascii?Q?vVY8t7tysrHE8wbL/qQWMpA6wN8YS2iZ8+fULNxdXQ7eP+7JYRoviQROs+Ci?=
 =?us-ascii?Q?ozEDyWLM4CB+Tz/ssc5seaqzHsQCcmAVJB4c3f/R11kHcVx8WbYjQOWkH4Ky?=
 =?us-ascii?Q?1vE3L/9uHZRIDf/7Wei57Q4CT32a3giMOTGq/LWPsm48knT8rMZt+a2s9ztv?=
 =?us-ascii?Q?UrWwbQmhiVXEKkpwYszwnphW+0Qdawh6HpvMnP6AMaXniFtLFaOAigBcI+FL?=
 =?us-ascii?Q?gVB69yo3peLTYVO9P2dja3xDQK2vKtzF32F/RzY3CoDUO7L4EiJmzh/O90c9?=
 =?us-ascii?Q?WRDpiEa2Z05t2WZBRTEbm0fTU51nC3GEmaTzeu4ziZrCEPJ/WHpx/mSFmuQV?=
 =?us-ascii?Q?fsT4yQEKIdseyFqqt2WOL9gS/t1Dz4eVC31p0ZIRgIFlHSGlEzq904EMYoHI?=
 =?us-ascii?Q?J6XRkeSFCdKLDXf3uhTTGIC/7bY1jVxDNA70CXmEGi0AVLqyo9PTTQoF56c3?=
 =?us-ascii?Q?4f+QGPRjWVdIdQTekz51fjToU8F9ggdPBaIqbLLZUeNaBkXGdXEXX4EDatnz?=
 =?us-ascii?Q?IcW7R0B/1UIY0f86gkvzkh0K5mde73cMYwQnL51B679hcVJbEIYtJHJYw6ZZ?=
 =?us-ascii?Q?PycN3KATka0GJF/dpY8iBQc91SXtDeJIetq0U91PyCyP8lN+9IUouMVSeeMD?=
 =?us-ascii?Q?PI+blr8tU2Ginn1oYWc+DykD?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915a6e61-5cb9-453a-8f42-08d931a9f4cf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:08.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjjNzt83QN2LTeRE59v8b+qd5BAbr95DHviOBoN42Hv8HLzE1FwZ/wrmwo5mizRkUU9ZOe4sLd4R6negf65AnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_cli.c    | 852 ++++++++++++++++++
 1 file changed, 852 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.c b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_cli.c
new file mode 100644
index 000000000000..7319ad681358
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.c
@@ -0,0 +1,852 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_cli.h"
+#include "wrs/wrs_sta.h"
+#include "wrs/wrs_rssi.h"
+#include "wrs/wrs.h"
+#include "wrs/wrs_stats.h"
+#include "utils/utils.h"
+#include "sta.h"
+
+#define WRS_ALL_STA U8_MAX
+
+static void cl_wrs_cli_interval_set(struct cl_wrs_db *wrs_db, u32 interval=
)
+{
+       wrs_db->interval =3D msecs_round(interval);
+       cl_timer_period_set(&wrs_db->timer_maintenance, wrs_db->interval);
+
+       pr_debug("[WRS] Interval =3D %u\n", wrs_db->interval);
+}
+
+static void cl_wrs_cli_config_print(struct cl_hw *cl_hw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       pr_debug("\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Main database configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Interval                =3D [%u]\n",
+                wrs_db->interval);
+       pr_debug("Debug level             =3D [%u]\n",
+                wrs_db->debug_level);
+       pr_debug("Min frames for decision =3D [%u]\n",
+                wrs_db->min_frames_for_decision);
+       pr_debug("EPR factor              =3D [%u]\n",
+                wrs_db->epr_factor);
+       pr_debug("--------------------------------\n");
+       pr_debug("Immediate drop configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Enabled                 =3D [%s]\n",
+                wrs_db->immediate_drop_en ? "TRUE" : "FALSE");
+       pr_debug("EPR Factor              =3D [%u]\n",
+                wrs_db->immediate_drop_epr_factor);
+       pr_debug("Max in row              =3D [%u]\n",
+                wrs_db->immediate_drop_max_in_row);
+       pr_debug("--------------------------------\n");
+       pr_debug("RSSI protect configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Enabled                 =3D [%s]\n",
+                wrs_db->rssi_protect_en ? "TRUE" : "FALSE");
+       pr_debug("Mode                    =3D [%s]\n",
+                (wrs_db->rssi_protect_mode =3D=3D WRS_RSSI_PROT_MODE_RSSI)=
 ? "rssi" : "neighbor");
+       pr_debug("Up threshold            =3D [%d]\n",
+                wrs_db->rssi_protect_up_thr);
+       pr_debug("Down threshold          =3D [%d]\n",
+                wrs_db->rssi_protect_dn_thr);
+       pr_debug("--------------------------------\n");
+       pr_debug("Converge idle configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Enable                  =3D [%s]\n",
+                wrs_db->converge_idle_en ? "TRUE" : "FALSE");
+       pr_debug("Interval reset          =3D [%u]\n",
+                wrs_db->converge_idle_interval_reset);
+       pr_debug("Interval rssi           =3D [%u]\n",
+                wrs_db->converge_idle_interval_rssi);
+       pr_debug("Packet threshold        =3D [%u]\n",
+                wrs_db->converge_idle_packet_th);
+       pr_debug("--------------------------------\n");
+       pr_debug("Converge traffic configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Traffic enable          =3D [%s]\n",
+                wrs_db->converge_trfc_en ? "TRUE" : "FALSE");
+       pr_debug("Interval static         =3D [%u]\n",
+                wrs_db->converge_trfc_interval_static);
+       pr_debug("Interval motion         =3D [%u]\n",
+                wrs_db->converge_trfc_interval_motion);
+       pr_debug("--------------------------------\n");
+       pr_debug("Steps and min/max thresholds\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Step down               =3D [%u]\n",
+                wrs_db->step_down);
+       pr_debug("Step same/up            =3D [%u]\n",
+                wrs_db->step_up_same);
+       pr_debug("Min threshold           =3D [%u]\n",
+                wrs_db->time_th_min);
+       pr_debug("Max threshold up        =3D [%u]\n",
+                wrs_db->time_th_max_up);
+       pr_debug("Max threshold down      =3D [%u]\n",
+                wrs_db->time_th_max_down);
+       pr_debug("--------------------------------\n");
+       pr_debug("Quick up configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Enable                  =3D [%s]\n",
+                wrs_db->quick_up_en ? "TRUE" : "FALSE");
+       pr_debug("BA threshold            =3D [%u]\n",
+                wrs_db->quick_up_ba_thr);
+       pr_debug("Interval                =3D [%u]\n",
+                wrs_db->quick_up_interval);
+       pr_debug("--------------------------------\n");
+       pr_debug("Quick down configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Enable                  =3D [%s]\n",
+                wrs_db->quick_down_en ? "TRUE" : "FALSE");
+       pr_debug("EPR factor              =3D [%u]\n",
+                wrs_db->quick_down_epr_factor);
+       pr_debug("Agg threshold           =3D [%u]\n",
+                wrs_db->quick_down_agg_thr);
+       pr_debug("Packet threshold        =3D [%u]\n",
+                wrs_db->quick_down_pkt_thr);
+       pr_debug("--------------------------------\n");
+       pr_debug("BA not received configuration\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Collision filter        =3D [%s]\n",
+                wrs_db->ba_not_rcv_collision_filter ? "TRUE" : "FALSE");
+       pr_debug("Force                   =3D [%s]\n",
+                wrs_db->ba_not_rcv_force ? "TRUE" : "FALSE");
+       pr_debug("Time since sync         =3D [%u]\n",
+                wrs_db->ba_not_rcv_time_since_sync);
+       pr_debug("--------------------------------\n");
+       pr_debug("Sync rate\n");
+       pr_debug("--------------------------------\n");
+       pr_debug("Sync timeout            =3D [%u]\n",
+                wrs_db->sync_timeout);
+       pr_debug("Sync min attempts       =3D [%u]\n",
+                wrs_db->sync_min_attempts);
+       pr_debug("\n");
+}
+
+static void cl_wrs_cli_dbg_level_set(struct cl_wrs_db *wrs_db, u32 debug_l=
evel)
+{
+       if (debug_level < DBG_LVL_MAX) {
+               wrs_db->debug_level =3D debug_level;
+               pr_debug("[WRS] Debug level =3D %u\n", debug_level);
+       } else {
+               pr_err("[WRS] Invalid debug level =3D %u\n", debug_level);
+       }
+}
+
+static void cl_wrs_cli_fixed_rate_set(struct cl_hw *cl_hw, struct cl_wrs_d=
b *wrs_db, u8 sta_idx,
+                                     u8 is_fixed_rate, u8 mode, u8 bw, u8 =
nss,
+                                     u8 mcs, u8 gi)
+{
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+
+       if (is_fixed_rate >=3D WRS_FIXED_RATE_MAX) {
+               pr_err("[WRS] Invalid fixed rate [%u] -\n"
+                      "0 =3D auto\n"
+                      "1 =3D fixed - fallback enable\n"
+                      "2 =3D fixed - fallback disable\n",
+                      is_fixed_rate);
+               return;
+       }
+
+       if (sta_idx !=3D WRS_ALL_STA) {
+               cl_sta_lock_bh(cl_hw);
+               wrs_sta =3D cl_wrs_sta_get(cl_hw, sta_idx);
+
+               /* Fixed rate for single station */
+               if (!wrs_sta) {
+                       pr_err("[WRS] Invalid sta_idx [%u]\n", sta_idx);
+                       goto unlock;
+               }
+
+               cl_wrs_fixed_rate_set(cl_hw, wrs_db, wrs_sta, &wrs_sta->su_=
params, is_fixed_rate,
+                                     mode, bw, nss, mcs, gi);
+
+unlock:
+               cl_sta_unlock_bh(cl_hw);
+       } else {
+               /* Fixed rate for all connected station */
+               struct cl_sta *cl_sta;
+
+               cl_sta_lock_bh(cl_hw);
+
+               list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+                       wrs_sta =3D &cl_sta->wrs_sta;
+
+                       cl_wrs_fixed_rate_set(cl_hw, wrs_db, wrs_sta,
+                                             &wrs_sta->su_params, is_fixed=
_rate,
+                                             mode, bw, nss, mcs, gi);
+               }
+
+               cl_sta_unlock_bh(cl_hw);
+
+               /* Save fixed rate parameters for stations that will connec=
t in the future */
+               wrs_db->is_fixed_rate =3D is_fixed_rate;
+
+               if (is_fixed_rate) {
+                       cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MODE=
] =3D mode;
+                       cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_BW] =
=3D bw;
+                       cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_NSS]=
 =3D nss;
+                       cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MCS]=
 =3D mcs;
+                       cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_GI] =
=3D gi;
+               }
+       }
+}
+
+static void cl_wrs_cli_converge_idle_param_set(struct cl_wrs_db *wrs_db, u=
32 param, u32 value)
+{
+       switch (param) {
+       case 0:
+               wrs_db->converge_idle_en =3D (bool)value;
+               break;
+       case 1:
+               wrs_db->converge_idle_interval_reset =3D value;
+               break;
+       case 2:
+               wrs_db->converge_idle_interval_rssi =3D value;
+               break;
+       case 3:
+               wrs_db->converge_idle_packet_th =3D value;
+               break;
+       default:
+               pr_warn("[WRS] Invalid parameter [%u]\n", param);
+               break;
+       }
+}
+
+static void cl_wrs_cli_converge_trfc_param_set(struct cl_wrs_db *wrs_db, u=
32 param, u32 value)
+{
+       switch (param) {
+       case 0:
+               wrs_db->converge_trfc_en =3D (bool)value;
+               break;
+       case 1:
+               wrs_db->converge_trfc_interval_static =3D value;
+               break;
+       case 2:
+               wrs_db->converge_trfc_interval_motion =3D value;
+               break;
+       default:
+               pr_warn("[WRS] Invalid parameter [%u]\n", param);
+               break;
+       }
+}
+
+static void cl_wrs_cli_immediate_drop_set(struct cl_wrs_db *wrs_db, bool e=
nable,
+                                         u8 epr_factor, u32 max_in_row)
+{
+       wrs_db->immediate_drop_en =3D enable;
+       wrs_db->immediate_drop_epr_factor =3D epr_factor;
+       wrs_db->immediate_drop_max_in_row =3D max_in_row;
+
+       pr_debug("[WRS] Set immediate drop: %s, epr_factor =3D %u, max_in_r=
ow =3D %u\n",
+                enable ? "enable" : "disable", epr_factor, max_in_row);
+}
+
+static void cl_wrs_cli_step_max_min_set(struct cl_wrs_db *wrs_db, u16 step=
_dn, u16 step_same_up,
+                                       u16 time_th_min, u16 time_th_max_up=
, u16 time_th_max_down)
+{
+       wrs_db->step_down =3D step_dn;
+       wrs_db->step_up_same =3D step_same_up;
+       wrs_db->time_th_min =3D time_th_min;
+       wrs_db->time_th_max_up =3D time_th_max_up;
+       wrs_db->time_th_max_down =3D time_th_max_down;
+
+       pr_debug("------------------------------------------\n");
+       pr_debug("Set steps and up/down decision thresholds:\n");
+       pr_debug("------------------------------------------\n");
+       pr_debug("Step down decision    =3D [%u]\n", wrs_db->step_down);
+       pr_debug("Step same/up Decision =3D [%u]\n", wrs_db->step_up_same);
+       pr_debug("Min threshold         =3D [%u]\n", wrs_db->time_th_min);
+       pr_debug("Max threshold up      =3D [%u]\n", wrs_db->time_th_max_up=
);
+       pr_debug("Max threshold down    =3D [%u]\n", wrs_db->time_th_max_do=
wn);
+}
+
+static void cl_wrs_cli_down_up_thr_set(struct cl_hw *cl_hw, struct cl_wrs_=
db *wrs_db,
+                                      u8 sta_idx, u16 time_th_dn, u16 time=
_th_up_mcs,
+                                      u16 time_th_up_nss, u16 time_th_up_b=
w, u16 time_th_up_bf,
+                                      u16 time_th_up_gi)
+{
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+       struct cl_wrs_params *wrs_params =3D NULL;
+       u16 rate_idx =3D 0;
+
+       cl_sta_lock_bh(cl_hw);
+       wrs_sta =3D cl_wrs_sta_get(cl_hw, sta_idx);
+
+       if (!wrs_sta) {
+               cl_sta_unlock_bh(cl_hw);
+               pr_err("[WRS] Invalid sta_idx [%u]\n", sta_idx);
+               return;
+       }
+
+       wrs_params =3D &wrs_sta->su_params;
+
+       for (rate_idx =3D 0; rate_idx < wrs_params->table_size; rate_idx++)=
 {
+               wrs_params->table->rate_down.time_th =3D time_th_dn;
+               wrs_params->table->rate_up[WRS_TABLE_NODE_UP_MCS].time_th =
=3D time_th_up_mcs;
+               wrs_params->table->rate_up[WRS_TABLE_NODE_UP_BW].time_th =
=3D time_th_up_bw;
+               wrs_params->table->rate_up[WRS_TABLE_NODE_UP_NSS].time_th =
=3D time_th_up_nss;
+               wrs_params->table->rate_up[WRS_TABLE_NODE_UP_BF].time_th =
=3D time_th_up_bf;
+               wrs_params->table->rate_up[WRS_TABLE_NODE_UP_GI].time_th =
=3D time_th_up_gi;
+       }
+
+       cl_sta_unlock_bh(cl_hw);
+
+       pr_debug("Table thresholds - station [%u]\n", sta_idx);
+       pr_debug("------------------------------------------\n");
+       pr_debug("Down   =3D %u\n", time_th_dn);
+       pr_debug("Up mcs =3D %u\n", time_th_up_mcs);
+       pr_debug("Up nss =3D %u\n", time_th_up_nss);
+       pr_debug("Up bw  =3D %u\n", time_th_up_bw);
+       pr_debug("Up bf  =3D %u\n", time_th_up_bf);
+       pr_debug("Up gi  =3D %u\n", time_th_up_gi);
+}
+
+static void cl_wrs_cli_main_print(struct cl_sta *cl_sta, struct cl_wrs_sta=
 *wrs_sta,
+                                 struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_params;
+
+       pr_debug("\n");
+       pr_debug("--------------------------------------------\n");
+       pr_debug("WRS info for station %u - %pM\n", cl_sta->sta_idx, cl_sta=
->addr);
+       pr_debug("--------------------------------------------\n");
+       pr_debug("Settings      =3D [%s]\n", FIXED_RATE_STR(wrs_params->is_=
fixed_rate));
+       pr_debug("Converge mode =3D [%s]\n", WRS_CONVERGE_MODE_STR(wrs_para=
ms->converge_mode));
+       pr_debug("Synced        =3D [%s]\n", wrs_params->sync ? "True" : "F=
alse");
+       pr_debug("Mode          =3D [%s]\n", WRS_MODE_STR(tx_params->mode))=
;
+
+       if (wrs_sta->mode =3D=3D tx_params->mode)
+               pr_debug("Rate index    =3D [%u]\n", wrs_params->rate_idx);
+
+       pr_debug("Rate params   =3D [bw=3D%s, nss=3D%u, mcs=3D%u, gi=3D%s]\=
n",
+                WRS_BW_STR(tx_params->bw),
+                tx_params->nss,
+                tx_params->mcs,
+                WRS_GI_STR(tx_params->gi));
+}
+
+static void cl_wrs_cli_sta_db_print(struct cl_hw *cl_hw, struct cl_wrs_db =
*wrs_db,
+                                   u8 sta_idx, u32 print_type)
+{
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+       struct cl_wrs_params *wrs_params =3D NULL;
+       struct cl_sta *cl_sta =3D NULL;
+
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               wrs_sta =3D &cl_sta->wrs_sta;
+
+               if (sta_idx !=3D WRS_ALL_STA && sta_idx !=3D wrs_sta->sta_i=
dx)
+                       continue;
+
+               wrs_params =3D &wrs_sta->su_params;
+
+               cl_wrs_cli_main_print(cl_sta, wrs_sta, wrs_params);
+
+               if (print_type & 0x1)
+                       cl_wrs_tables_print(cl_hw, wrs_params);
+
+               if (print_type & 0x2)
+                       cl_wrs_stats_decision_print(wrs_params);
+
+               if (print_type & 0x4)
+                       cl_wrs_stats_per_print(cl_hw, wrs_sta, wrs_params);
+       }
+
+       cl_sta_unlock_bh(cl_hw);
+
+       if (sta_idx =3D=3D WRS_ALL_STA)
+               pr_debug("*** END OF WRS STATS ***\n");
+}
+
+static void cl_wrs_cli_sta_db_reset(struct cl_hw *cl_hw, struct cl_wrs_db =
*wrs_db,
+                                   u8 sta_idx, u32 reset_type)
+{
+       struct cl_wrs_sta *wrs_sta =3D NULL;
+       struct cl_wrs_params *wrs_params =3D NULL;
+       struct cl_sta *cl_sta =3D NULL;
+
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               wrs_sta =3D &cl_sta->wrs_sta;
+
+               if (sta_idx !=3D WRS_ALL_STA && sta_idx !=3D wrs_sta->sta_i=
dx)
+                       continue;
+
+               wrs_params =3D &wrs_sta->su_params;
+
+               if (reset_type & 0x1)
+                       cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+
+               if (reset_type & 0x2)
+                       cl_wrs_stats_decision_reset(wrs_params);
+
+               if (reset_type & 0x4)
+                       cl_wrs_stats_per_reset(wrs_params);
+       }
+
+       cl_sta_unlock_bh(cl_hw);
+}
+
+static void cl_wrs_cli_sync_params_set(struct cl_wrs_db *wrs_db,
+                                      u16 sync_timeout, u8 sync_min_attemp=
ts)
+{
+       wrs_db->sync_timeout =3D sync_timeout;
+       wrs_db->sync_min_attempts =3D sync_min_attempts;
+       pr_debug("[WRS] sync_timeout =3D %u, sync_min_attempts =3D %u\n",
+                sync_timeout, sync_min_attempts);
+}
+
+static void cl_wrs_cli_min_frames_decision_set(struct cl_wrs_db *wrs_db, u=
32 min_frames)
+{
+       wrs_db->min_frames_for_decision =3D min_frames;
+       pr_debug("[WRS] min_frames_for_decision =3D %u\n", min_frames);
+}
+
+static void cl_wrs_cli_conservative_mode_set(struct cl_wrs_db *wrs_db,
+                                            bool conservative_mcs, bool co=
nservative_nss)
+{
+       wrs_db->conservative_mcs_noisy_env =3D conservative_mcs;
+       wrs_db->conservative_nss_noisy_env =3D conservative_nss;
+
+       pr_debug("[WRS] Conservative mode - mcs =3D %s, nss =3D %s\n",
+                conservative_mcs ? "true" : "false",
+                conservative_nss ? "true" : "false");
+}
+
+static void cl_wrs_cli_quick_up_set(struct cl_wrs_db *wrs_db, bool enable,=
 u8 ba_thr, u16 interval)
+{
+       wrs_db->quick_up_en =3D enable;
+       wrs_db->quick_up_ba_thr =3D ba_thr;
+       wrs_db->quick_up_interval =3D msecs_round(interval);
+
+       pr_debug("[WRS] Quick up: enable =3D %s, ba_thr =3D %u, interval =
=3D %u\n",
+                wrs_db->quick_up_en ? "true" : "false",
+                wrs_db->quick_up_ba_thr,
+                wrs_db->quick_up_interval);
+}
+
+static void cl_wrs_cli_quick_down_set(struct cl_wrs_db *wrs_db, bool enabl=
e,
+                                     u8 epr_factor, u8 agg_thr, u16 pkt_th=
r)
+{
+       wrs_db->quick_down_en =3D enable;
+       wrs_db->quick_down_epr_factor =3D epr_factor;
+       wrs_db->quick_down_agg_thr =3D agg_thr;
+       wrs_db->quick_down_pkt_thr =3D pkt_thr;
+
+       pr_debug("[WRS] Quick down: enable =3D %s, epr_factor =3D %u, agg_t=
hr =3D %u, pkt_thr =3D %u\n",
+                enable ? "true" : "false", epr_factor, agg_thr, pkt_thr);
+}
+
+static void cl_wrs_cli_ba_not_rcv_set(struct cl_wrs_db *wrs_db, bool colli=
sion_filter,
+                                     bool force, u32 time_since_sync)
+{
+       wrs_db->ba_not_rcv_collision_filter =3D collision_filter;
+       wrs_db->ba_not_rcv_force =3D force;
+       wrs_db->ba_not_rcv_time_since_sync =3D msecs_round(time_since_sync)=
;
+
+       pr_debug("[WRS] BA not received: collision_filter =3D %s, force =3D=
 %s, time_since_sync =3D %u\n",
+                wrs_db->ba_not_rcv_collision_filter ? "true" : "false",
+                wrs_db->ba_not_rcv_force ? "true" : "false",
+                wrs_db->ba_not_rcv_time_since_sync);
+}
+
+static int cl_wrs_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       len +=3D snprintf(buf, PAGE_SIZE,
+                       "wrs usage\n"
+                       "-a : Print station list\n"
+                       "-b : Set maintenance interval [ms]\n"
+                       "-c : Print configuration\n"
+                       "-d : Set debug level [0-off, 1-error, 2-warning, "
+                               "3-trace, 4-info]\n"
+                       "-f : Set fixed rate [sta_idx].[0-auto,1-fixed "
+                               "fallback en,2-fixed fallback dis].[mode]."
+                               "[bw].[nss].[mcs].[gi]\n"
+                       "-g : Set converge idle parameters [0-en, "
+                               "1-interval_reset, 2-interval_rssi, "
+                               "3-packet_th].[value]\n"
+                       "-h : Set converge trfc parameters [0-en, "
+                               "1-interval_static, 2-interval_motion]."
+                               "[value]\n"
+                       "-k : Set EPR factor [factor]\n"
+                       "-l : Set immediate drop [0-disable/1-enable]."
+                               "[per factor].[max in row]\n"
+                       "-m : Print rssi protect debug [sta_idx]\n"
+                       "-n : Set rssi protect parameters [enable 0/1]."
+                               "[mode 0-rssi/1-neighbor].[rssi up thr]."
+                               "[rssi down th]\n"
+                       "-o : Set step and time thresholds [step down]."
+                               "[step same up].[time min].[time max up]."
+                               "[time max down]\n"
+                       "-p : Set down and up time thresholds [sta_idx]."
+                               "[down].[up mcs].[up nss].[up bw].[up bf]."
+                               "[up gi]\n"
+                       "-q : Reset and print station data [sta_idx].[op:"
+                               " 1-weights, 2-decisions, 4-per, 7-all)]\n"
+                       "-r : Reset station data [sta_idx].[op: 1-weights, =
"
+                               "2-decisions, 4-per, 7-all)]\n"
+                       "-s : Print station data [sta_idx].[op: 1-weights, =
"
+                               "2-decisions, 4-per, 7-all)]\n"
+                       "-t : Set sync parameters [timeout].[min attempts]\=
n"
+                       "-u : Set minimum frames for decision [min frames]\=
n"
+                       "-v : Set conservative mode [mcs-0/1].[nss-0/1]\n"
+                       "-w : Set quick up [enable].[ba_thr].[interval]\n"
+                       "-x : Set quick down [enable].[epr factor]."
+                               "[agg thr][pkt thr]\n"
+                       "-y : Set BA not received [collision filter][force]=
."
+                               "[time since sync]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_wrs_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_para=
ms *cli_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       u32 expected_params =3D 0;
+       bool sta_list_print =3D false;
+       bool interval_set =3D false;
+       bool config_print =3D false;
+       bool set_debug_level =3D false;
+       bool fixed_rate =3D false;
+       bool converge_idle_set =3D false;
+       bool converge_trfc_set =3D false;
+       bool epr_factor_set =3D false;
+       bool immediate_drop_set =3D false;
+       bool rssi_prot_print =3D false;
+       bool rssi_protect_set =3D false;
+       bool set_step_max_min_th =3D false;
+       bool set_up_dn_th =3D false;
+       bool print_reset_sta_db =3D false;
+       bool reset_sta_db =3D false;
+       bool print_sta_db =3D false;
+       bool sync_params_set =3D false;
+       bool min_frames_set =3D false;
+       bool conservative_mode_set =3D false;
+       bool quick_up_set =3D false;
+       bool quick_down_set =3D false;
+       bool ba_not_rcv_set =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               sta_list_print =3D true;
+               expected_params =3D 0;
+               break;
+       case 'b':
+               interval_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               config_print =3D true;
+               expected_params =3D 0;
+               break;
+       case 'd':
+               set_debug_level =3D true;
+               expected_params =3D 1;
+               break;
+       case 'f':
+               fixed_rate =3D true;
+               expected_params =3D 7;
+               break;
+       case 'g':
+               converge_idle_set =3D true;
+               expected_params =3D 2;
+               break;
+       case 'h':
+               converge_trfc_set =3D true;
+               expected_params =3D 2;
+               break;
+               break;
+       case 'k':
+               epr_factor_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 'l':
+               immediate_drop_set =3D true;
+               expected_params =3D 3;
+               break;
+       case 'm':
+               rssi_prot_print =3D true;
+               expected_params =3D 1;
+               break;
+       case 'n':
+               rssi_protect_set =3D true;
+               expected_params =3D 3;
+               break;
+       case 'o':
+               set_step_max_min_th =3D true;
+               expected_params =3D 5;
+               break;
+       case 'p':
+               set_up_dn_th =3D true;
+               expected_params =3D 7;
+               break;
+       case 'q':
+               print_reset_sta_db =3D true;
+               expected_params =3D 2;
+               break;
+       case 'r':
+               reset_sta_db =3D true;
+               expected_params =3D 2;
+               break;
+       case 's':
+               print_sta_db =3D true;
+               expected_params =3D 2;
+               break;
+       case 't':
+               sync_params_set =3D true;
+               expected_params =3D 2;
+               break;
+       case 'u':
+               min_frames_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 'v':
+               conservative_mode_set =3D true;
+               expected_params =3D 2;
+               break;
+       case 'w':
+               quick_up_set =3D true;
+               expected_params =3D 3;
+               break;
+       case 'x':
+               quick_down_set =3D true;
+               expected_params =3D 4;
+               break;
+       case 'y':
+               ba_not_rcv_set =3D true;
+               expected_params =3D 3;
+               break;
+               break;
+       case '?':
+               return cl_wrs_cli_help(cl_hw);
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
+       if (sta_list_print) {
+               cl_wrs_sta_print_list(cl_hw, wrs_db);
+               return 0;
+       }
+
+       if (interval_set) {
+               u32 interval =3D (u32)cli_params->params[0];
+
+               cl_wrs_cli_interval_set(wrs_db, interval);
+               return 0;
+       }
+
+       if (config_print) {
+               cl_wrs_cli_config_print(cl_hw);
+               return 0;
+       }
+
+       if (set_debug_level) {
+               u32 debug_level =3D (u32)cli_params->params[0];
+
+               cl_wrs_cli_dbg_level_set(wrs_db, debug_level);
+               return 0;
+       }
+
+       if (fixed_rate) {
+               u8 sta_idx  =3D (u8)cli_params->params[0];
+               u8 is_fixed_rate =3D (u8)cli_params->params[1];
+               u8 mode =3D (u8)cli_params->params[2];
+               u8 bw =3D (u8)cli_params->params[3];
+               u8 nss =3D (u8)cli_params->params[4];
+               u8 mcs =3D (u8)cli_params->params[5];
+               u8 gi =3D (u8)cli_params->params[6];
+
+               cl_wrs_cli_fixed_rate_set(cl_hw, wrs_db, sta_idx, is_fixed_=
rate,
+                                         mode, bw, nss, mcs, gi);
+               return 0;
+       }
+
+       if (converge_idle_set) {
+               u32 param =3D (u32)cli_params->params[0];
+               u32 value =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_converge_idle_param_set(wrs_db, param, value);
+               return 0;
+       }
+
+       if (converge_trfc_set) {
+               u32 param =3D (u32)cli_params->params[0];
+               u32 value =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_converge_trfc_param_set(wrs_db, param, value);
+               return 0;
+       }
+
+       if (epr_factor_set) {
+               wrs_db->epr_factor =3D (u8)cli_params->params[0];
+               pr_debug("[WRS] epr_factor =3D %u\n", wrs_db->epr_factor);
+               return 0;
+       }
+
+       if (immediate_drop_set) {
+               bool is_en =3D (bool)cli_params->params[0];
+               u8 epr_factor =3D (u8)cli_params->params[1];
+               u32 max_in_row =3D (u32)cli_params->params[2];
+
+               cl_wrs_cli_immediate_drop_set(wrs_db, is_en, epr_factor, ma=
x_in_row);
+               return 0;
+       }
+
+       if (rssi_prot_print) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               struct cl_wrs_sta *wrs_sta;
+
+               cl_sta_lock_bh(cl_hw);
+               wrs_sta =3D cl_wrs_sta_get(cl_hw, sta_idx);
+
+               if (wrs_sta)
+                       cl_wrs_rssi_prot_dbg(cl_hw, wrs_db, wrs_sta);
+               else
+                       pr_err("[WRS] Invalid sta_idx [%u]\n", sta_idx);
+
+               cl_sta_unlock_bh(cl_hw);
+
+               return 0;
+       }
+
+       if (rssi_protect_set) {
+               bool enable =3D (bool)cli_params->params[0];
+               bool mode =3D (bool)cli_params->params[1];
+               s32 rssi_up_th =3D cli_params->params[2];
+               s32 rssi_dn_th =3D cli_params->params[3];
+
+               cl_wrs_rssi_prot_config(cl_hw, wrs_db, enable, mode, rssi_u=
p_th, rssi_dn_th);
+               return 0;
+       }
+
+       if (set_step_max_min_th) {
+               u16 step_dn =3D (u16)cli_params->params[0];
+               u16 step_same_up =3D (u16)cli_params->params[1];
+               u16 time_th_min =3D (u16)cli_params->params[2];
+               u16 time_th_max_up =3D (u16)cli_params->params[3];
+               u16 time_th_max_down =3D (u16)cli_params->params[4];
+
+               cl_wrs_cli_step_max_min_set(wrs_db, step_dn, step_same_up,
+                                           time_th_min, time_th_max_up, ti=
me_th_max_down);
+               return 0;
+       }
+
+       if (set_up_dn_th) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u16 time_th_dn =3D (u16)cli_params->params[1];
+               u16 time_th_up_mcs =3D (u16)cli_params->params[2];
+               u16 time_th_up_nss =3D (u16)cli_params->params[3];
+               u16 time_th_up_bw =3D (u16)cli_params->params[4];
+               u16 time_th_up_bf =3D (u16)cli_params->params[5];
+               u16 time_th_up_gi =3D (u16)cli_params->params[6];
+
+               cl_wrs_cli_down_up_thr_set(cl_hw, wrs_db, sta_idx, time_th_=
dn,
+                                          time_th_up_mcs, time_th_up_nss, =
time_th_up_bw,
+                                          time_th_up_bf, time_th_up_gi);
+               return 0;
+       }
+
+       if (print_reset_sta_db) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u32 print_type =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_sta_db_print(cl_hw, wrs_db, sta_idx, print_type)=
;
+               cl_wrs_cli_sta_db_reset(cl_hw, wrs_db, sta_idx, print_type)=
;
+               return 0;
+       }
+
+       if (reset_sta_db) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u32 reset_type =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_sta_db_reset(cl_hw, wrs_db, sta_idx, reset_type)=
;
+               return 0;
+       }
+
+       if (print_sta_db) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+               u32 print_type =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_sta_db_print(cl_hw, wrs_db, sta_idx, print_type)=
;
+               return 0;
+       }
+
+       if (sync_params_set) {
+               u16 sync_timeout =3D (u16)cli_params->params[0];
+               u8 sync_min_attempts =3D (u16)cli_params->params[1];
+
+               cl_wrs_cli_sync_params_set(wrs_db, sync_timeout, sync_min_a=
ttempts);
+               return 0;
+       }
+
+       if (min_frames_set) {
+               u32 min_frames =3D (u32)cli_params->params[0];
+
+               cl_wrs_cli_min_frames_decision_set(wrs_db, min_frames);
+               return 0;
+       }
+
+       if (conservative_mode_set) {
+               u32 conservative_mcs =3D (u32)cli_params->params[0];
+               u32 conservative_nss =3D (u32)cli_params->params[1];
+
+               cl_wrs_cli_conservative_mode_set(wrs_db, conservative_mcs, =
conservative_nss);
+               return 0;
+       }
+
+       if (quick_up_set) {
+               bool enable =3D (bool)cli_params->params[0];
+               u8 ba_thr =3D (u8)cli_params->params[1];
+               u16 interval =3D (u16)cli_params->params[2];
+
+               cl_wrs_cli_quick_up_set(wrs_db, enable, ba_thr, interval);
+               return 0;
+       }
+
+       if (quick_down_set) {
+               bool enable =3D (bool)cli_params->params[0];
+               u8 epr_factor =3D (u8)cli_params->params[1];
+               u8 agg_thr =3D (u8)cli_params->params[2];
+               u16 pkt_thr =3D (u16)cli_params->params[3];
+
+               cl_wrs_cli_quick_down_set(wrs_db, enable, epr_factor, agg_t=
hr, pkt_thr);
+               return 0;
+       }
+
+       if (ba_not_rcv_set) {
+               bool collision_filter =3D (bool)cli_params->params[0];
+               bool force =3D (bool)cli_params->params[1];
+               u32 time_since_sync =3D (u32)cli_params->params[2];
+
+               cl_wrs_cli_ba_not_rcv_set(wrs_db, collision_filter, force, =
time_since_sync);
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

