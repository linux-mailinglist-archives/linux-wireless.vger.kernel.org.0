Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3E3AB846
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhFQQGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:13 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:58626
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233642AbhFQQF6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4kY3X90oCTYrehGnLP3poI1oaiPNAbCiZtszK2yyzFIqF9EAI+LU2sV7yhcMy+g8u4Wv0fm6+oSdrkmIQcNGXYxWsvCxQeaofPKuYz2NiEwFPSSBVhj3uySnuW8grC6Jd3Zco4SpbgyxLB5FsJOR0Bs7TnLXuB/XGRJUQoZBwsZEAvMH+yJZutUo1gagY9QvEHIhHqIndDmEWUrC2KmyvXChkpB2OCA9/YCqUPGdESo32cbgT5OlCfea8aW15liAGcc/o2x5mgNj4NUW1VAVsk7yA37TT18CU3dRhO5fYz5OccMJuxnRkR8liADGlocqc22XW7DQiPls6fGG2xbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjFgC45B9R8TkOP7PpbZinh56CrNG68HSy4ON8jZySE=;
 b=Zv2oZ9B3rIsxnN29mRGepr1fBeZcITrlI82m1fCNfIkRSBncrubpoxQsHKg0O/m8PAXPhSrkb1hi31kj5BRktAGlYxwtaxqfZeEK+6P4EBdVx7rSMY+07mC2mtF52GJZPDSFzmZhsx9k9mjhnFuefcQdP7034Gz15EP0oGT0KuB8HpruIdnjKCM+bzj44rdFx/Rg1yDeRaPnZ1+us6OUWC9iq2o2+3A/HmbDlYItGpPhaPhb/8xXPzJ2qffjQ7fgo833HIsJqUqCDsjG3Ja8hW3NhK/o3j3kwG5UHMdAX3e6Jf8TaFlQhAJuViZ3Pxf2YH70QLTI/Nk/RgoVbt+IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjFgC45B9R8TkOP7PpbZinh56CrNG68HSy4ON8jZySE=;
 b=NQJHMfrD0svJAf0jWbKX7Z8VwFdpowT55s6pinVCK91dNxqyBJIaUkJWwbj3kyeM5hA8VaIxhGhqhy/NCGHyBMZOQwMTScEJcL3WVxUo/0IL4NFBYcHfSJ3d+YRDCQnJ/W5c8vvxuOKVfIdCufXoduIx37eONPX4sQFUb0Yqc2M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:44 +0000
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
Subject: [RFC v1 048/256] cl8k: add coredump.c
Date:   Thu, 17 Jun 2021 15:58:55 +0000
Message-Id: <20210617160223.160998-49-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f70d0a6-4c6c-45a3-3b39-08d931a970e5
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04999D7D92F5501812A2C703F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDsU2DsoUPgnTTfWPhRegFX26+XTZUzcR9iicxapvBCcba1crylMQf9RAi0WcKaaKo9LyCpYw8PM/XACnBnf0t6iS/zbNie0Of9BN5PmyXU+0ErmoXWVB9AZBpCkEwapw0ReWlqU4UTe0SwtUa7TtRPWP/xi14qEFWl8m3JzM87X4EVEVJ9r1IFSVG7q8Nstvy+XlmXyUtqHRkoNQpGcPgV9pXwip1GXtztUmWs5/OKJgvbnIVp0grfC0eKRJTb7EAuhfBTNcBflqqnJ4SydudGUuJdu1S9mkOrdZZ9RC+S5FMN6V70bacipBvo7zvsRrn3R0+sOKOwh+QmIphwO5s3rAsR2fp3aXbd6iuUE6mxiQRe6uyuEQGivU7ddTByFjJuHe041DfrXfbqjIbUEBqCKgp4QAX6b5x0ZVCzwBtXWxAGxi6F7XohTDzmvhUyWzF9tTTTsU5Q/4NZpeK6IjNfvS9a7hieYGCmld11VFUqm6zqUILHNS3FqRU50brGP5Wa1wC1j8eLAgWkBIFROyRPl97yRLbS2gSpjvUQyTVUyu+ihFSP629chJe8f9/I1OQTG6jg8tfljzYon/X9f4QzhXZjvjHhg67RVONHi7xvyqUUU+OU3ORm2JtpyPvAxX+buusGgtUcSsp8KiC+KeUQ3b/ENCcy1C0r1lW/gcmAezpS9gRVhkSUka3yzwFskW6Ore7rkbqd1JKPbBQ2Xpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Tij3CB7quMuvUFGvWAJ+aSdPMqk6isZFGHGWcOhq/VVeH5M2XE5pEiMyX+K?=
 =?us-ascii?Q?s9cXxTBfNd8C1IbDEHuvL4AJl7ixBI4RzsHD6iYS/35rBANW4O9Iv1rxHlr2?=
 =?us-ascii?Q?FpyM47BDmH46R3QNjNZa2jYrbyjAE6s94ivuly8uh3K4NWkeTdIGnJjuYFFz?=
 =?us-ascii?Q?BroTbZ06IXfR/k1Exm2+U6vqzVLUvGLmUl2MLwbMBnhL2GyFgqkZwnJNZD7N?=
 =?us-ascii?Q?3qisnTcjK0fUA3cKmITqrNIAmTHQztUrlsPUtioHIrdcSZtjA68hVIpYuLuV?=
 =?us-ascii?Q?kGpgIYTrb21Kxwuiv4t9+Al5ZqiXbqrA9ngqBjuMF5tAVk2xRpFTcypah+Au?=
 =?us-ascii?Q?wh9zhxq4VmFxDNAwC2svtmL+zYHeQ6MU2GJKpsulnA8l+Z4QfKxv9rzkIFBX?=
 =?us-ascii?Q?4Li1d+x34VFlFti/HWhpGl3mOkRxGOs6oou92OW8GITiavOoFdSKvXlWrYBg?=
 =?us-ascii?Q?KINKwLCe0SGfslYyZP1VHkl4n5X57BCpthbXNBz0JDN3vzaI4o+LT+eJrnZL?=
 =?us-ascii?Q?zScZrzOD1BwvtBrdFTjcWXHsgooBFhsUjQHKSCaqQOVk6Jrl3KSfrT/JyDG0?=
 =?us-ascii?Q?kK8ujn0o+dIW64w/Y6+sbprXagaiz8fdYq9Gu1hIe0XM+dSkiv2IEuKY4tKJ?=
 =?us-ascii?Q?giDDY8eAU8/6HdYlzPZKUdKtqaLVJueUzvDnXO7r43whFaN2y8hW+FnwrCIY?=
 =?us-ascii?Q?itrEoFzs7N5f7XEH9++cvbiF9oWtw3qljRRoGH/rjF5/K0Vhfg4Tn2AZ4+Tr?=
 =?us-ascii?Q?hY3e+vSJp0ecitILGR8S/eDxlUmJf79n7RajakZ6Zif/szpMsbkhAySJiLlx?=
 =?us-ascii?Q?poSxUHS88vBQw9E2KoHg76ukxhR3JwCX8KmYGyBrtZ+AoIfYls2PAY+KRu/u?=
 =?us-ascii?Q?CYLVkZcWi/nZ4ZFJmDGhvL2AZ0W0Kh429BlAKBhPon7HayF5OUOa+jqNGYFc?=
 =?us-ascii?Q?XU8Od1K21pX0+OYJj3Ij7o611IV2laOgTN/n1oAVYDIcaxMuEOMN3QRbIc+c?=
 =?us-ascii?Q?pQC+gcRAHDv6ErVoC2vjdFqhWotqjaKxKMlPrpspW/cKJk2FIQLWT/TJtLdL?=
 =?us-ascii?Q?eF7KQJX+PX4p8MuSeWzla8AUxjhNzlwsoGGjPj6nNQ/kOcSaNQDaEQvIDvvA?=
 =?us-ascii?Q?rDgi7OFe8tgzDeD0ZOx/v6PyhjyOtCm7TzMbG3DFufwz+ZOFrROD659Jjs5G?=
 =?us-ascii?Q?zpIDCeIcHJzJcxewNASHpr5lOhac/wWtvZ1DlyUO7L6N59M4MfR90cvqmMaJ?=
 =?us-ascii?Q?iRhl9X9B/GN4r1XsKnDgs4ulvnJPOuFfSZJMeRAp2WP0gUX5z57a2erF6BqQ?=
 =?us-ascii?Q?5vGoYIb34Vz5pfVXpTtUoKXa?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f70d0a6-4c6c-45a3-3b39-08d931a970e5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:26.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7sO13E117j22785IvH+3S/A+82cUGQcfHg23hwC0a4jLSqVi8c6XrnawgGqYnbRxgMFeV/ZDqsR/VKt3DiTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/coredump.c | 190 ++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/coredump.c

diff --git a/drivers/net/wireless/celeno/cl8k/coredump.c b/drivers/net/wire=
less/celeno/cl8k/coredump.c
new file mode 100644
index 000000000000..bf0313715f6f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/coredump.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "coredump.h"
+#include "recovery.h"
+#include "mib.h"
+#include "ela.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/ipc.h"
+#endif
+#include "chip.h"
+#include "config.h"
+
+#include "fw/fw_dbg.h"
+
+#include <linux/devcoredump.h>
+
+static int cl_coredump_generate(struct cl_hw *cl_hw)
+{
+       struct cl_coredump *dump;
+
+       dump =3D cl_fw_dbg_prepare_coredump(cl_hw);
+       if (!dump)
+               return -ENODATA;
+
+       dev_coredumpv(cl_hw->chip->dev, dump, le32_to_cpu(dump->len),
+                     GFP_KERNEL);
+
+       return 0;
+}
+
+static void cl_coredump_done(struct cl_hw *cl_hw)
+{
+       /*
+        * Print MIB counters only if watchdog is disabled,
+        * otherwise the dump of prints effects the recovery
+        */
+       if (cl_hw->conf->ce_fw_watchdog_mode =3D=3D FW_WD_DISABLE)
+               cl_mib_cntrs_dump(cl_hw);
+
+       if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags))
+               return;
+
+       /*
+        * Assuming firmware cannot request next dump before we release the=
 host buffer
+        *  so no need to sync the following against error_ind()
+        */
+       cl_hw->debugfs.trace_prst =3D false;
+#ifdef CONFIG_CL_PCIE
+       cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+#endif
+       if (cl_hw->dbginfo.buf->u.dump.general_data.error_type =3D=3D DBG_E=
RROR_FATAL ||
+           cl_hw->assert_info.restart_needed) {
+               cl_dbg_err(cl_hw, "Starting recovery due to unrecoverable a=
ssert\n");
+               cl_recovery_start(cl_hw, RECOVERY_UNRECOVERABLE_ASSERT);
+       }
+}
+
+static void cl_coredump_work(struct work_struct *ws)
+{
+       struct cl_debugfs *debugfs =3D container_of(ws, struct cl_debugfs, =
coredump_work);
+       struct cl_hw *cl_hw =3D container_of(debugfs, struct cl_hw, debugfs=
);
+       unsigned long flags;
+
+       debugfs->coredump_call_tstamp =3D jiffies;
+
+       cl_coredump_generate(cl_hw);
+       if (cl_ela_is_on(cl_hw->chip)) {
+               cl_ela_lcu_reset(cl_hw->chip);
+               cl_ela_lcu_apply_config(cl_hw->chip);
+       }
+
+       spin_lock_irqsave(&debugfs->coredump_lock, flags);
+       if (!debugfs->unregistering)
+               cl_coredump_done(cl_hw);
+       debugfs->coredump_scheduled =3D false;
+       spin_unlock_irqrestore(&debugfs->coredump_lock, flags);
+}
+
+int cl_coredump_trigger(struct cl_hw *cl_hw)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+       unsigned long flags;
+       unsigned long curr_time =3D jiffies;
+       unsigned int diff_time =3D jiffies_to_msecs(curr_time - debugfs->co=
redump_call_tstamp);
+
+       if (diff_time < cl_hw->conf->ci_coredump_diff_time_ms) {
+#ifdef CONFIG_CL_PCIE
+               cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_a=
ddr);
+#endif
+               cl_dbg_verbose(cl_hw,
+                              "Skip coredump - time from previous call=3D%=
u m-sec\n",
+                              diff_time);
+               return -1;
+       }
+
+       spin_lock_irqsave(&debugfs->coredump_lock, flags);
+       if (debugfs->coredump_scheduled) {
+               spin_unlock_irqrestore(&debugfs->coredump_lock, flags);
+               cl_dbg_verbose(cl_hw, ": Already scheduled\n");
+               return -EBUSY;
+       }
+
+       if (debugfs->unregistering) {
+               spin_unlock_irqrestore(&debugfs->coredump_lock, flags);
+               cl_dbg_verbose(cl_hw, ": unregistering\n");
+               return -ENOENT;
+       }
+
+       debugfs->coredump_scheduled =3D true;
+       debugfs->trace_prst =3D true;
+       ktime_get_real_ts64(&cl_hw->dbginfo.trigger_tstamp);
+
+       schedule_work(&debugfs->coredump_work);
+       spin_unlock_irqrestore(&debugfs->coredump_lock, flags);
+
+       return 0;
+}
+
+bool cl_coredump_recovery(struct cl_hw *cl_hw, int reason)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+       unsigned long flags;
+       bool need_restart =3D false;
+
+       spin_lock_irqsave(&debugfs->coredump_lock, flags);
+
+       if (!debugfs->coredump_scheduled) {
+               cl_dbg_trace(cl_hw,
+                            "Starting recovery due to reason:%d\n",
+                            reason);
+               cl_recovery_start(cl_hw, reason);
+       } else {
+               need_restart =3D true;
+       }
+
+       spin_unlock_irqrestore(&debugfs->coredump_lock, flags);
+
+       return need_restart;
+}
+
+bool cl_coredump_is_scheduled(struct cl_hw *cl_hw)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+
+       return debugfs->coredump_scheduled;
+}
+
+void cl_coredump_reset_trace(struct cl_hw *cl_hw)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+
+       debugfs->trace_prst =3D false;
+}
+
+void cl_coredump_init(struct cl_hw *cl_hw, struct dentry *dir_drv)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+
+       debugfs->dir =3D dir_drv;
+       debugfs->unregistering =3D false;
+       debugfs->trace_prst =3D false;
+       debugfs->coredump_scheduled =3D false;
+
+       INIT_WORK(&debugfs->coredump_work, cl_coredump_work);
+
+       spin_lock_init(&debugfs->coredump_lock);
+
+       /*
+        * Initialize coredump_call_tstamp to current time minus
+        * (ci_coredump_diff_time_ms + 1), so that if assert happens immedi=
ately
+        * coredump will be called.
+        */
+       debugfs->coredump_call_tstamp =3D jiffies -
+               msecs_to_jiffies(cl_hw->conf->ci_coredump_diff_time_ms + 1)=
;
+}
+
+void cl_coredump_close(struct cl_hw *cl_hw)
+{
+       struct cl_debugfs *debugfs =3D &cl_hw->debugfs;
+
+       flush_work(&debugfs->coredump_work);
+
+       if (!debugfs->dir)
+               return;
+
+       debugfs->unregistering =3D true;
+       debugfs_remove_recursive(debugfs->dir);
+       debugfs->dir =3D NULL;
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

