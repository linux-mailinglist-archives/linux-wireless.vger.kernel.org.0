Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2500D3AB8AB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhFQQJo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:44 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:45023
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233709AbhFQQIW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+J6v5BZN6A4AHHuDk/4Z4d7MLPhizSA2UBMw0EypwE4R+TJFm31tP392Q2ZJ2jQlvBYvpbMOOTDA/iRbwbi2pC6ZJ75+6V4eR2mZ4l9wFNypv3TXV5jhY46RYQ6CVTynKDc9dFodvic7mOgvW+GD0defvQm+2BXobI+X8GaoTp6C8Tnj0Tplk0AlXUDF70JrQDJqIgILF6QMrcumeptvCex17Aa3Dxr6Qq//W7vYklZR5wI+8t3I9qmWUvgFh0FcQcFRi5igIw0h997IiltDLHjnimNpWQSzA5t0johN96pnjEv989L05Yd3ztov7JzWIwt3Mh9RPwY2EKP/5uzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RBTjo9b1dFWoy31sFg1UhmToQNnNfK/0WZk7INNUqs=;
 b=jyVOrRbCqQyRx/ZsA7+vEGr1U2r/0TQpkSS+ODtJg5TLnPy7cqDUtn/CQFVhPbdBELBIfeOSLP3UV+tiH17s8GZfpzq9yi0algzYdAiNFd9BsXLX4EkZAEIs6zPrV9dp23pJpbGS2aZz5AeFklRhWqJS3k/0esMdIDCMqKkZCz19EdLbTicoovsXeLe8IRy2KmaOqgxl4e3RiWGedov6B1cJHibBCR6nkQplHzujPMPtMmETVfrFlpQ+7svcJqpaGEZ6dqGi4lSAEDS3cdpDyR6X/ot7fB+2L8x83nMwoar7SjEibZuovU7m9XGh9LMwe6A4V0F1EaIMaBx7gCL89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RBTjo9b1dFWoy31sFg1UhmToQNnNfK/0WZk7INNUqs=;
 b=ujqkM2wa85E0boeRM+EeIox6UI+3ykxstpBsGmgMmYQrJkjbzQv6eA+kDuSzr0/Y17n87TCWKrQPHoYelMvJz8DqMTMMiZTOYqiszT9YPf7B8MhgxEqlSzdk2DU+5AtcZDA1niDeRFWcyimXNzX7qyHX7pUwVQGn+YouQOZLey8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:50 +0000
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
Subject: [RFC v1 141/256] cl8k: add radio.c
Date:   Thu, 17 Jun 2021 16:00:28 +0000
Message-Id: <20210617160223.160998-142-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d85a748-a1ac-4e62-51b4-08d931a9ae8f
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0465BC6D3147D724730327DEF60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hM6dYaq60Pzc6u0DpReONe/k6iluASJTo2avTbwD4w6+4W1M5HaQ5ce2y2RXlxojzfe06ubNoYfBinAQwNnEK+tzrcqpMby4a1K1lKdgVSpwFkhxzDA3L0UEb7IqQgFnhCyUyEs9rak9rZAB76yWn1F9kmJs/DdzXL9zLKq0L5sLHF+aid3cPU03s0HPGlMhYRWMVmR+ExgTKxMODMxs02UK1Lh9cuWyaL7fwdpIRewMtD5zkDSrK2fOzS6zL5rN0lPTB3cMZRJ2xqga4WBRmHvp9RsrloKXmCXd1apo0YvZ8PZTBm0/sridSOCFYtjgCc2fRV3FyOWOjmcxjBalimIgu55mCDk15tuuEZRAsi/upJMGnPZK3s6ip7WPODs2Kg3VB0mP12oogCl9LqBWTfBmkmKxfZH29V6kn8chwhGBBTU8rDS9pKsTZfrP+9u78n1rocsTDB9XKxmCfuXVewVTGTBHhSTTedb3sqRd5+CQO8Fn5/vVPE7xbrI94JCYteQZoWOZu0+1/0bikOXQPhVXpX7UNDOxLxTSW3gersmwoBQMeVrZFI92U0chaViiGAVNnLIz+OWhHh5XLVNKvKkfSMFpfbpWz0Ze/HYAx85qN18ENszB4o8yLNTeALAJOagOrvMe387pPXKfxy6Q4RXbkDg6k6BWx/2h/WihBpY6Lz6FmyYEYm72EJrSivQifFIP/0D2/0A30437yAe6nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iy4wAfZh0RrbXlOXxStbfgyvMF3XGsfD55YX7++zLpGf7U84mimHctKCQAWP?=
 =?us-ascii?Q?1HKZ5Iobe/Y1vRbZzsSm3UUa+VH+jBRPK/DcmvMVrNdE43fzLGp7sLsdfzw6?=
 =?us-ascii?Q?oJvLCqBl3CWbti36fOghObTw4VzKKbgItM0ls35mDLeWBqlQFABADMZF2Tny?=
 =?us-ascii?Q?WOkd6G62K4BhfZ87ubIrEByZUxICKVAVsslFkwJGoCcnuhHCDzWy4EAzfTi6?=
 =?us-ascii?Q?7kyTyFU9Su87gXcbmh9Vg/BJtBOqBQ19SkejTBQLQ6Ku8wZ0seyvlX0MYD5C?=
 =?us-ascii?Q?/m9LDcXWKxda3NuEhlesTIzcDM4rnFiJYVfIgSCMz8RoPfxN1a0/i1mKKqBv?=
 =?us-ascii?Q?ctO/BRTv9VGpMLShgL9rV64KB0jH5hZz6kJqNZu/5fKf3As7SWNogFiabUtA?=
 =?us-ascii?Q?aQ3YcW8NGLLhkM3LBFsWS7Z158p89haQkaaWaKjPTts9ydy8tDdSbXOTHP8p?=
 =?us-ascii?Q?sCcneeIw6oe2gS6hUCC/OuhHkkkYqRfepFEgte2xeaDxLu5A3qfW0O7H4zW2?=
 =?us-ascii?Q?eAxTfG51Nl3SXvMd2bLKBItBIN4hPcs8xJevgQyJGNN19OFm3aANIS9bPdb8?=
 =?us-ascii?Q?ea33yZqObGYkrHSAL1Ypp+B6jax+u8dmu1GDUzvCUaj8d5dh7PDnJb7sjEnH?=
 =?us-ascii?Q?bSK1Cu0//EnSrjTaBVBbjTMUPdv6jIRIdRNuU1ketGU1LHC4GNjDR4UK0+FD?=
 =?us-ascii?Q?mJBMDiNG8PBw/2aI04ftshTZkPPBSzqWDDu7SWQ8V5lCY2fWDCJHdHQ1X7C5?=
 =?us-ascii?Q?LkM0CZF8mGqGitKFgoGUiCJ9E+BuGHIiTK7ASH46pXZbKR1lbo2aqVGd726C?=
 =?us-ascii?Q?gzr8/0EWhkD/mHpq1/4tLWWSbugd2SreK5ue/ENTriYIl9bTzbwh7jxEb5se?=
 =?us-ascii?Q?Vf58UlBDEyC7gxEPWixpTfRsMPlei4+aaq2X8FOpJ325Z+68idIsTaCbH/zf?=
 =?us-ascii?Q?V0aeO8b7CbEriLc9V9RLxuLt6smLCGAu99yKcSWnU9ueBKqqg5IwrmldJ26F?=
 =?us-ascii?Q?LTAohhX+RbHxrvILGJJ48wipJ4VifoCniYtdeZgPbqqFkXlympuMNbE2ss7s?=
 =?us-ascii?Q?5juoJdMbxuZEsQMIhQskcdA2r5iJf4kA+6mAtZxB0HKv3eXeYBLv09vq0toI?=
 =?us-ascii?Q?d5+j5u/Nrrq576pCpDyYRJo+RUeC8iYa/uI5m3VegWYuT/uiXBPQwX6eq3cU?=
 =?us-ascii?Q?4n0LVmAyMIkhT4uDNozRGcbbsRtLJ2keGEkEOekaTj8a/h4ov50d6ndz/+NB?=
 =?us-ascii?Q?ceoNLip5ApqM7GH+NVbDJfqn+90QxejTPTqGQ1q/7eXfnn4anbPrEWLBoEJB?=
 =?us-ascii?Q?V0FXz/nDv8DOBhBW0cvA1gIV?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d85a748-a1ac-4e62-51b4-08d931a9ae8f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:09.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju3Souc8cH8v/t6ZxVM96/qTmKOUQ3AvYDS66iU7bwtsbC2Qyxtd+3fEZ5gIQnybPW7z7Wv8xBwYpIEVGitw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/radio.c | 171 +++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.c

diff --git a/drivers/net/wireless/celeno/cl8k/radio.c b/drivers/net/wireles=
s/celeno/cl8k/radio.c
new file mode 100644
index 000000000000..165d90332254
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/radio.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
+#include "radio.h"
+#include "vendor_cmd.h"
+#include "fw/msg_tx.h"
+#include "vif.h"
+#include "sta.h"
+#include "chip.h"
+
+static int cl_radio_off_kthread(void *arg)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)arg;
+       struct cl_vif *cl_vif;
+
+       cl_sta_disassociate_all(cl_hw);
+
+       cl_dbg_verbose(cl_hw, "Waiting for stations to disconnect\n");
+
+       if (wait_event_timeout(cl_hw->radio_wait_queue,
+                              cl_sta_num_bh(cl_hw) =3D=3D 0,
+                              msecs_to_jiffies(5000)) =3D=3D 0) {
+               cl_dbg_verbose(cl_hw,
+                              "Failed to disconnect stations. %u stations =
still remaining\n",
+                              cl_sta_num_bh(cl_hw));
+               return 1;
+       }
+
+       cl_dbg_trace(cl_hw, "Stopping queues ...\n");
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+               cl_vif->tx_en =3D false;
+               cl_dbg_verbose(cl_hw, "Radio OFF vif_index =3D %u\n",
+                              cl_vif->vif_index);
+       }
+
+       cl_msg_tx_set_idle(cl_hw, MAC_IDLE_SYNC);
+
+       cl_dbg_trace(cl_hw, "Radio shut down successfully\n");
+
+       cl_hw->radio_status =3D RADIO_STATUS_OFF;
+       atomic_set(&cl_hw->radio_lock, 0);
+
+       return 0;
+}
+
+static int cl_radio_off(struct cl_hw *cl_hw)
+{
+       struct task_struct *k;
+
+       if (cl_hw->radio_status !=3D RADIO_STATUS_ON ||
+           atomic_xchg(&cl_hw->radio_lock, 1))
+               return 1;
+
+       cl_hw->radio_status =3D RADIO_STATUS_GOING_DOWN;
+
+       /* Relegate the job to a kthread to free the system call. */
+       k =3D kthread_run(cl_radio_off_kthread, cl_hw, "cl_radio_off_kthrea=
d");
+       if (IS_ERR(k))
+               cl_dbg_verbose(cl_hw,
+                              "Error: failed to run cl_radio_off_kthread\n=
");
+       return 0;
+}
+
+static void _cl_radio_on(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+               if (cl_vif->vif->type =3D=3D NL80211_IFTYPE_AP) {
+                       if (cl_hw->iface_conf =3D=3D CL_IFCONF_REPEATER &&
+                           !test_bit(CL_DEV_REPEATER, &cl_hw->drv_flags))
+                               continue;
+                       if (cl_hw->iface_conf =3D=3D CL_IFCONF_MESH_AP &&
+                           !test_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags))
+                               continue;
+               }
+
+               cl_vif->tx_en =3D true;
+               cl_dbg_verbose(cl_hw, "Radio ON vif=3D%u\n", cl_vif->vif_in=
dex);
+       }
+
+       cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE);
+
+       cl_dbg_verbose(cl_hw, "Radio has been started\n");
+
+       cl_hw->radio_status =3D RADIO_STATUS_ON;
+       atomic_set(&cl_hw->radio_lock, 0);
+}
+
+int cl_radio_on(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_hw *cl_hw_other =3D cl_hw_other_tcv(cl_hw);
+       bool other_tcv_radio_on_needed =3D false;
+
+       if (cl_hw->radio_status !=3D RADIO_STATUS_OFF ||
+           atomic_xchg(&cl_hw->radio_lock, 1))
+               return 1;
+
+       cl_hw->calib_ready =3D true;
+
+       if (cl_chip_is_both_enabled(chip) && cl_hw_other->conf->ce_radio_on=
) {
+               if (cl_hw_other->calib_ready)
+                       other_tcv_radio_on_needed =3D true;
+               else
+                       return 1;
+       }
+
+       _cl_radio_on(cl_hw);
+
+       if (other_tcv_radio_on_needed)
+               _cl_radio_on(cl_hw_other);
+
+       if (chip->conf->ce_calib_scan_en && !chip->calib_db.scan_complete)
+               cl_calib_start_work(cl_hw);
+
+       return 0;
+}
+
+void cl_radio_off_chip(struct cl_chip *chip)
+{
+       if (cl_chip_is_tcv0_enabled(chip))
+               cl_radio_off(chip->cl_hw_tcv0);
+
+       if (cl_chip_is_tcv1_enabled(chip))
+               cl_radio_off(chip->cl_hw_tcv1);
+}
+
+void cl_radio_on_chip(struct cl_chip *chip)
+{
+       if (cl_chip_is_tcv0_enabled(chip))
+               cl_radio_on(chip->cl_hw_tcv0);
+
+       if (cl_chip_is_tcv1_enabled(chip))
+               cl_radio_on(chip->cl_hw_tcv1);
+}
+
+bool cl_radio_is_off(struct cl_hw *cl_hw)
+{
+       return cl_hw->radio_status =3D=3D RADIO_STATUS_OFF;
+}
+
+bool cl_radio_is_on(struct cl_hw *cl_hw)
+{
+       return cl_hw->radio_status =3D=3D RADIO_STATUS_ON;
+}
+
+bool cl_radio_is_going_down(struct cl_hw *cl_hw)
+{
+       return cl_hw->radio_status =3D=3D RADIO_STATUS_GOING_DOWN;
+}
+
+int cl_radio_cli(struct cl_hw *cl_hw, bool radio_on)
+{
+       cl_hw->conf->ce_radio_on =3D radio_on;
+
+       if (radio_on)
+               cl_radio_on(cl_hw);
+       else
+               cl_radio_off(cl_hw);
+
+       return 0;
+}
+
+void cl_radio_off_wake_up(struct cl_hw *cl_hw)
+{
+       wake_up(&cl_hw->radio_wait_queue);
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

