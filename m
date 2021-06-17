Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01D3AB8B1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhFQQJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:52 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:27105
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhFQQIi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfhDfLYm+1NYEsYV9xAzBQ9Zm+h75aFjIVTdcY41e2fCtQYZZH+kCXrT08p5+6sh+Ba/9AAMMW96xrCA9GTuAoZ7RV5+9c1yi1Ve+V9yTHlFdg2rx3bEsUMoTUbnVbBNJyP3jz9AKTVhARzNB4W1jC/v8JdY5L+RWfuc2OM6FevcabhzKSeW/OlL53Brqv4BDHKmNp1tVkqc0rt1pHH8rh6S7RJxjv2SChGGOhbArxn0CMdP77GCUDbErO/Iru1aSTYRMxn29dYseO+m5KIqRXhpWUK2rHZGNkhkroR44HqvgRWgJa/+wA/daz4JDzgnqupp3yCy9N/dOyVwDuzciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHN/fbXwqyht5PEO2exMtLT/LOU86QIydkBJ778ymbI=;
 b=JQ0BEmVsDECiSs4EpW/qXsotxCm0Zsz+fGmaIzbQLt0XBvUYCSn2eHS2UKL3gEsSES+fCzUsshSv1goVM15bVmogqtSpDRtVZTcAUq2Ess9jFXUw6q8azX2CihYS3lp04MICKwvfXt9/KjFf0oz8LEngFahYoQXadIJAY/CodG1DLxd9K91d9h4iQXTK4UVbjeolS9uuTqa6KBm5zLrfF9pux2dq5Ns9n/JeUb8qWkCcUUtjq/HfMVpwYpgtjw3i4rTpaBzDl3031bN8xd5I/tcR2uLN3ND9y8Sib49pxO0s7RN93dFX38IGMJKnwowN7Dpue9cSpYhYEajkh1MB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHN/fbXwqyht5PEO2exMtLT/LOU86QIydkBJ778ymbI=;
 b=mQ7avDqkrqZGQaquBLAsDc7605KuAEUmVsI7JL7JPrEvP5OThaamX/imN0fuukDfYAEnmjpIVyr/Z3yjtw5yFbD0MzW8+WhL0KOA3/dXep2rmS5kJicBR+E4oiTNPbJcBnjS/g/3mYG+d9WGl8dmZXr1NHZIgvF4nhXaDgDTZVA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:52 +0000
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
Subject: [RFC v1 145/256] cl8k: add recovery.c
Date:   Thu, 17 Jun 2021 16:00:32 +0000
Message-Id: <20210617160223.160998-146-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862639bf-3585-4cf7-86e4-08d931a9b114
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04654556D72AF0D2B0BD98C9F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NoKV2oD9FWRmB7fgWJYSaPIwodeVloK5+j3Xs6ZawosfCye6DcvF+mZJq4lW5sqiUYGSSxFCHxcoyLrS/Juls5I15qSbtAEhAsIpIYpEz+AE6fNYBGuMURgrjB7D9MfsiGfSkV2Yid9Sth1pkBD8H0xVUE/n+9alhpTZI6XX1M/N13RHzK/bUuta+XrrQRV/QdZm1kvM3mAmg4gFrjIWRjkAk7IkBipTBU77wf2dXQXuNrgxrzBft3vDYrhpll3c3RVDn+BOcG7z4M0QJpGfszU2Gd9KGjA8SQUy+tpbq4xWOjLoyiYFZaGQVAN6RKyENTDMp3SLETGxo+cbot5eYYwiWdsDar2Jv4SAE6DU9ezl23/Q2Ba+pIxe9epHe0rwPS6wYWaBgWn+qY8MKVXkTdQFGL7letJJe7N97eZ2pndflFaZNMGFFweMO1JAYf53Hk2V5awnYOSbhHOH82KV7S10IjG+zQopZO0CoBlA/Y+TLHi/FPZldNAKsE9ETwVxb3I3SpAEd76M9KlilV1ypRVCYu0bnUcBpY6UUR0Rxc6S4IFsolz2+12RJrqIFtdTUT/47+L997vQmPUVMCh+yOW8txZ5lo3ioVXjrvYtyF699Zl/JjOmawGxQD9uKAeVgjtR1VJG691SRgZv2c29BKxtC25scJZ5ROuSBK8Oy10qduUMtSC2O7X6+JfckwO2zCGnFKO6IxyBYASKvBo/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EjjTeLQcWZ+0JC3QBagICoBM/bOBm9zVJUSCBdoSkQc5/wkow1ki1gzLGTW?=
 =?us-ascii?Q?OHtRM8lSKJ9D+PccIwDdzKRZpTdzk9RLNubU6gom+//1XHZFNbIOJHXzcv0S?=
 =?us-ascii?Q?7cDfXby6DgWXjAy6m4N8HRhvSp1TuF11q6HCWriwzEVrJ4bpaS+VbhQNvj8I?=
 =?us-ascii?Q?enF0kbZN8bqwKgwQRFoLVt6l4O2xLAQFVVq5+0GYzopSDvttNIpvEymFzsh3?=
 =?us-ascii?Q?7Z2xWMwcFXhQHpnG59A9fb/mZic108FVXt8E17W1eY1UlmwzZGLrGK0NLvty?=
 =?us-ascii?Q?t8MoGwWAylc9MWAd33TrbrmraWoijrQu56FqDljvrFsV8QyrIUTs3tHDRiDA?=
 =?us-ascii?Q?7dZUYADbgokOFIHAh8Z1RuP6QM/fJ/SbCN8NbAzy17ZCz1AbgpOBnK5N/aia?=
 =?us-ascii?Q?N5xR2xgXZ3HdAUUVTcaZnUHTUkjsQaREqPcCY+muh/KndX22VEu/+VBuU5yb?=
 =?us-ascii?Q?fMpVHQMcZv8rJ5H0+WL7XtE/w5S3Re1p7JhCwohqjiYn95kMya1mubfIBvr8?=
 =?us-ascii?Q?EIp/mrua9oU/2KzZiWPMKJLNvgdJOHZx4pEZZ76nh4Rm7yHZJFUPxGqfU4xe?=
 =?us-ascii?Q?BV6zd4sgefOoKcRPgOHwVpwViib3+6y/vZuomVRxdlmAXOr+J74L6DdLN4t4?=
 =?us-ascii?Q?0U1hd8LIp231V/Z7+KE9prcZrKAfY10Lrjg4dzTKu+f4pfQIz4SaM5shtyaT?=
 =?us-ascii?Q?ZldqpL5a09XV3ZBcQkgEDx7hZYuFm+W9rWwsN1myQdGrCuSOvlBb02fkb4xI?=
 =?us-ascii?Q?tjiJODy97dxpC/z2B8IT+BXG62m5pkiXYcSUFKk/4uScRfTlHSZN0i6Zbi89?=
 =?us-ascii?Q?kA1+P5vkBzaxWGOpTRCpGjMZOi7UuPoNeRJ252xJnBz26L/+fNQmkQFHwxFJ?=
 =?us-ascii?Q?aTTRuBTcpwADlKb7yOXmSdUh82RQEZG6Lp8UhCZ4v3qZuuJCioXH0MFaeLn3?=
 =?us-ascii?Q?UjhSdbYaLRU8Lt7SQsDdhyg9cpX2FfP/nMdLMcvSROimdMDYXhsP2aEaiSpk?=
 =?us-ascii?Q?Kp2a0zEDzoYZcPwZ7Wl9g11x1A27vjWQxzIuzFnZMOdiEdo3wDBUDm/xc3Cl?=
 =?us-ascii?Q?rLyco0/iWsf+N7g+VLv72/VnrX2yyskXk73h7Kr5EMMbINV0y9lc1fIulDdJ?=
 =?us-ascii?Q?mqEOip4K960mFE7ERKSHgu0cvdtqYCsPDQ0sdoGzR6sp5rX8OW1GZ6Cyq0cS?=
 =?us-ascii?Q?n089FwZS63pDKmL9qVdZgzk/AIw3wc1cYbsQHgLoKyt7De3f9DyGl0T5CgDX?=
 =?us-ascii?Q?EWBIP9KPlgYzxb8Nbdv8piyyijE470WcouTzvhZeLR9v9bWeLJsBu3v65iIe?=
 =?us-ascii?Q?otfSOgiDmrPaOv0K2DJgCOzc?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862639bf-3585-4cf7-86e4-08d931a9b114
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:14.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIejeZTTNXa0YCHEIG+hb9fmwDoFCTqAXXcBxtK/vyjh0c8aS0rYY3vydzPscTg2yp9KCxOpYgr7jhKk+9wCog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/recovery.c | 264 ++++++++++++++++++++
 1 file changed, 264 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.c

diff --git a/drivers/net/wireless/celeno/cl8k/recovery.c b/drivers/net/wire=
less/celeno/cl8k/recovery.c
new file mode 100644
index 000000000000..1bba86ea4882
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/recovery.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "recovery.h"
+#include "rx/rx_amsdu.h"
+#include "main.h"
+#include "phy/phy.h"
+#include "vif.h"
+#include "dfs/dfs.h"
+#include "maintenance.h"
+#include "tx/tx_inject.h"
+#include "ext/dyn_mcast_rate.h"
+#include "ext/dyn_bcast_rate.h"
+#include "vns.h"
+#include "radio.h"
+#include "wrs/wrs_api.h"
+#include "config.h"
+#include "fw/msg_tx.h"
+#include "coredump.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/irq.h"
+#endif
+
+struct cl_recovery_work {
+       struct work_struct ws;
+       struct cl_hw *cl_hw;
+       int reason;
+};
+
+#define RECOVERY_POLL_TIMEOUT 6
+
+static void cl_recovery_poll_completion(struct cl_hw *cl_hw)
+{
+       u8 cntr =3D 0;
+
+       while (test_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags)) {
+               msleep(1000);
+
+               if (++cntr =3D=3D RECOVERY_POLL_TIMEOUT) {
+                       cl_dbg_verbose(cl_hw, "\n");
+                       cl_dbg_err(cl_hw, "Driver handgup was detected!..."=
);
+                       break;
+               }
+       }
+}
+
+static void cl_recovery_start_hw(struct cl_hw *cl_hw)
+{
+       clear_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags);
+
+       /* Restart MAC firmware... */
+       if (cl_main_on(cl_hw)) {
+               cl_dbg_err(cl_hw, "Couldn't turn platform on .. aborting\n"=
);
+               return;
+       }
+
+       if (cl_msg_tx_reset(cl_hw)) {
+               cl_dbg_err(cl_hw, "Failed to send firmware reset .. abortin=
g\n");
+               return;
+       }
+
+       set_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags);
+       clear_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags);
+
+       /* Hand over to mac80211 from here */
+       ieee80211_restart_hw(cl_hw->hw);
+
+       cl_recovery_poll_completion(cl_hw);
+}
+
+static void cl_recovery_stop_hw(struct cl_hw *cl_hw)
+{
+       /* Start recovery process */
+       cl_hw->recovery_db.in_recovery =3D true;
+
+       clear_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+       set_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags);
+       set_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags);
+#ifdef CONFIG_CL_PCIE
+       /* Disable interrupts */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
+#endif
+       cl_tx_inject_stop_in_recovery(cl_hw);
+       cl_maintenance_stop(cl_hw);
+
+       ieee80211_stop_queues(cl_hw->hw);
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+
+       cl_main_off(cl_hw);
+
+       cl_hw->fw_active =3D false;
+       cl_hw->fw_send_start =3D false;
+
+       cl_coredump_reset_trace(cl_hw);
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+
+       /* Reset it so MM_SET_FILTER_REQ will be called during the recovery=
 */
+       cl_hw->rx_filter =3D 0;
+
+       /*
+        * Reset channel/frequency parameters so that cl_msg_tx_set_channel=
()
+        * will not be skipped in cl_ops_config()
+        */
+       cl_hw->channel =3D 0;
+       cl_hw->primary_freq =3D 0;
+       cl_hw->center_freq =3D 0;
+}
+
+static void cl_recovery_process(struct cl_hw *cl_hw)
+{
+       int ret;
+
+       cl_dbg_verbose(cl_hw, "Start\n");
+
+       cl_recovery_stop_hw(cl_hw);
+       cl_phy_reset(cl_hw);
+
+       ret =3D cl_phy_load_recovery(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_phy_load_recovery failed %d\n", ret);
+               return;
+       }
+
+       cl_recovery_start_hw(cl_hw);
+}
+
+static void cl_recovery_handler(struct cl_hw *cl_hw, int reason)
+{
+       unsigned long recovery_diff =3D jiffies_to_msecs(jiffies - cl_hw->r=
ecovery_db.last_restart);
+
+       cl_hw->recovery_db.restart_cnt++;
+
+       if (recovery_diff > cl_hw->conf->ce_fw_watchdog_limit_time) {
+               cl_hw->recovery_db.restart_cnt =3D 1;
+       } else if (cl_hw->recovery_db.restart_cnt > cl_hw->conf->ce_fw_watc=
hdog_limit_count) {
+               cl_dbg_verbose(cl_hw, "Too many failures... aborting\n");
+               cl_hw->conf->ce_fw_watchdog_mode =3D FW_WD_DISABLE;
+               return;
+       }
+
+       cl_hw->recovery_db.last_restart =3D jiffies;
+
+       /* Count recovery attempts for statistics */
+       cl_hw->fw_recovery_cntr++;
+       cl_dbg_trace(cl_hw, "Recovering from firmware failure, attempt #%i\=
n",
+                    cl_hw->fw_recovery_cntr);
+
+       cl_recovery_process(cl_hw);
+}
+
+static void cl_recovery_work_do(struct work_struct *ws)
+{
+       /* Worker for restarting hw. */
+       struct cl_recovery_work *recovery_work =3D container_of(ws, struct =
cl_recovery_work, ws);
+
+       recovery_work->cl_hw->assert_info.restart_sched =3D false;
+       cl_recovery_handler(recovery_work->cl_hw, recovery_work->reason);
+       kfree(recovery_work);
+}
+
+static void cl_recovery_work_sched(struct cl_hw *cl_hw, int reason)
+{
+       /*
+        * Schedule work to restart device and firmware
+        * This is scheduled when driver detects hw assert storm.
+        */
+       struct cl_recovery_work *recovery_work;
+
+       if (!cl_hw->ipc_env || cl_hw->is_stop_context) {
+               cl_dbg_warn(cl_hw, "Skip recovery - Running down!\n");
+               return;
+       }
+
+       /* If restart is already scheduled - exit */
+       if (cl_hw->assert_info.restart_sched)
+               return;
+
+       cl_hw->assert_info.restart_sched =3D true;
+
+       /* Recovery_work will be freed by cl_recovery_work_do */
+       recovery_work =3D kzalloc(sizeof(*recovery_work), GFP_ATOMIC);
+
+       if (!recovery_work)
+               return;
+
+       INIT_WORK(&recovery_work->ws, cl_recovery_work_do);
+       recovery_work->cl_hw =3D cl_hw;
+       recovery_work->reason =3D reason;
+
+       queue_work(cl_hw->drv_workqueue, &recovery_work->ws);
+}
+
+bool cl_recovery_in_progress(struct cl_hw *cl_hw)
+{
+       return cl_hw->recovery_db.in_recovery;
+}
+
+void cl_recovery_reconfig_complete(struct cl_hw *cl_hw)
+{
+       clear_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags);
+
+       /* Multicast/Broadcast rate recovery */
+       cl_dyn_mcast_rate_recovery(cl_hw);
+       cl_dyn_bcast_rate_recovery(cl_hw);
+
+       /* DFS recovery */
+       cl_dfs_recovery(cl_hw);
+
+       /* VNS recovery */
+       cl_vns_recovery(cl_hw);
+
+       /* Restore EDCA configuration */
+       cl_edca_recovery(cl_hw);
+
+       /* Temperature  recovery */
+       cl_temperature_recovery(cl_hw);
+
+       /* Sounding recovery */
+       cl_sounding_recovery(cl_hw);
+
+       /*
+        * Update Tx params for all connected stations to sync firmware aft=
er the
+        * recovery process.
+        */
+       cl_wrs_api_recovery(cl_hw);
+
+       /* Enable maintenance timers back */
+       cl_maintenance_start(cl_hw);
+
+       if (cl_radio_is_on(cl_hw))
+               cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE);
+
+       cl_hw->recovery_db.in_recovery =3D false;
+
+       pr_debug("cl_recovery: complete\n");
+
+       cl_rx_post_recovery(cl_hw);
+}
+
+void cl_recovery_start(struct cl_hw *cl_hw, int reason)
+{
+       /* Prevent new messages to be sent until firmware has recovered */
+       set_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags);
+
+       switch (cl_hw->conf->ce_fw_watchdog_mode) {
+       case FW_WD_DISABLE:
+               cl_dbg_info(cl_hw, "Skip recovery - Watchdog is off!\n");
+               break;
+
+       case FW_WD_INTERNAL_RECOVERY:
+               cl_recovery_work_sched(cl_hw, reason);
+               break;
+
+       case FW_WD_DRV_RELOAD:
+               /* TODO: Implement netlink hint to the userspace */
+               cl_dbg_info(cl_hw, "RELOAD handler is absent, doing nothing=
");
+               break;
+
+       default:
+               break;
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

