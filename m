Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943973AB883
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFQQIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:35 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:64480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232768AbhFQQHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4F6J1YCdbsS+qPgK3sQFZb7U0yWGFsh7afDH9XddllAH7qFIsL+byC2pGZv4H0htTYjGV1paeNi7UHhT+720vkbge/Wdw/jDOxzDkqJA3b5zMGMU5w9sCW1cX7z8drjwnNTU5N6woDRwrDqP0nPvMEWJ2/eGksBgZuyxYX30aehH7SNj6vOWcUC+EvUUTgGwOWuL0z3AlyZ0bgonF2IHQTEn406190DI2WFQ9sa9ppp2KHf5gNVZiMJLW70XzyNkPEfqYZSt69PlrA0wzJCYhPos7o6maUJUSmiplg9h9meivvhP2ILCD8O0FWvSkj+2F97arVZdWf7IddPvR/ewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhxF5akp8aXcXXFpF1x/0SXMsg2M7hyeSI8kJ+z7bAs=;
 b=KxqM4uviQCsXte47D61zQG5P0+l3o3+pmYihmfdZuku2hpKQwOxxJQTKESKH4YwWQF4WmNwlgeDnu4Vu863riJnh0vn/ia8a/TcrWLG3VDcGdYvfJZLw0b4NS5gyxVF6DBAj8nBnij4zhFpN2aig5FzjSVNYB5n/3sy+8vTsAKzQl7x/Mv87PObldSOi7nYr9ntl5Dg+pZgRoLPoQHk51pw9PDMhKra03mJgrnx1IloY4Zr6Io4fvUdUzuiwo3eykTy09f2b5ttxXFworMoKBJHvdast8tiQZzRpXNJ1ZR+2TqiPhsi7dv6mfVyfsdZFJLzBPWkpmcB7CDPfzVGycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhxF5akp8aXcXXFpF1x/0SXMsg2M7hyeSI8kJ+z7bAs=;
 b=EB0SN9AFlXDUTxFEWMP1yXjKdpqfr9l2/HZ/omypcuNauFL4T4aoYkTW0dExPy55TQWwt40HByKQo2lNanbqsRhikCr4eG1WhZITvdIbBckD00pJRCXzwgxEA73WZRz5p8+psHYF5D7PsUn7+V2eycdUQVnvhPxx3Xx97k1JLQQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:09 +0000
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
Subject: [RFC v1 111/256] cl8k: add maintenance.c
Date:   Thu, 17 Jun 2021 15:59:58 +0000
Message-Id: <20210617160223.160998-112-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b71315-3e39-494f-3154-08d931a99ad3
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0402AC98A10148B9C89DB4D7F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNxgyBt7DRJ9/VYlz/mQHyJGuvyePf+CkjcD5Q/ivJ22Dy5ojbT7TFZvlzFGRzapRXVQ9XCGcyGQ0AAsTJ4wBnjJXv6QL2tVF/NmmjZMDM4cWwpoeAyeYb6WUMbKINJkUsC8cqczkhZ6rcZ8iMS8TxR+IkOkASulBHUcwFPDmc2ICCpY/omrDWAbiAvyctGXFnN+7ionaah4Nt3mEsc7J/FEJJdmPYcxSYAxZ/5T5waPq93rKGBr8hFG6OJOyMvuWKrArDJBS3Jat7wh7MLg6Dj4ICila7P7FNWy9ymJtASUUExW9chrvcDSF2j+ppFZGO3RWI4Joa3YC+2C+fZyqH6Lk0VdTSgHyYHTmm5zCVmmrNyv/SBqygZxD9879uAAvLj/Abrn6BaDyGyLDjeXvei7jPNkCTicUVr+g/l8kRSIsCRDaVPnkfzjSInAXIsP2eLcHKn+Vw36THA1Ky1rnUp96DCr0eDFCdCfBCxsmFH1aMLGPoUbvQUBjA5fD4HgP5w9DdQaPWexjmQ0HeQmOo/0g1fb2ko1I4j4HRnVcQJyQF7yn+Wmo6ufkhmoarAuA9VvqSkwkectafshBDEvO2lsb+k/AjPC3aQeTJ+WK0JihUW61N17z5F0l+xpWldgtzuVcB5yp7RvOPFJnqslrd/jO1vn4cOK28lKlzYKb2pkI4jx51S8TSMaBqQPDxiFvVb3F2yK51jd18IkZZxEHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IUUZ3aQXTVH8qStie06sO7g5s2sPWEFGcw66YuYGnrjDLjTKTNeiOgNBJ/J?=
 =?us-ascii?Q?hhdYyj5UoMaUqFsMqPJN3BIF9+lWM5X7eUofUmfEeF+fsich3m2+BLYo5nYL?=
 =?us-ascii?Q?43sNdjzJTlzF86LvY5sLT7RBoWtWc3nxvHtWF/eOlOI6G1k57tIFOWpG9Eh4?=
 =?us-ascii?Q?WXcBUsEvATic7l1eqZKYqtFh8v9dsht6LYzMoZHDfNu/gXJdvRMC4xv2EUWV?=
 =?us-ascii?Q?jd+iFwFPz3CM3FIUwpYdj618jmittJsgwUOq2lrAH2z1nH9UXppz86F4b5bU?=
 =?us-ascii?Q?NBoFJ8rRXV8sEZR9ICezSzrbYfWjhlgbPX/flJGpJxCGdgexP0ndubi1rA1C?=
 =?us-ascii?Q?9Q/wSLMjnR0Mq3HNNxWOjNDi4IjqZ2Im6BWGKkqomcCbMGyY403ZrikCKwwN?=
 =?us-ascii?Q?VCyCOnYXC4GyZl839CAtTB9qRNl5G2TmdxKviJcrfFB5mKNNKYcydDuSv5cd?=
 =?us-ascii?Q?3oOCizL/6SVJu49MzFzb/Qpmxy4hdej+9fwSg9YDXPTHUJB054NSIMxXdlCX?=
 =?us-ascii?Q?+7NNqy1nA63DbnIRd6Mx1IG3g3Mf0GJd8xeq4FqoTL5gBVEydbGDUNDFOsSy?=
 =?us-ascii?Q?/z3+zQfo/M5BL0nUx/WeLi/WH6uKGxfpB4oSMJJyCdqXx/rLfdhw93IJpB4J?=
 =?us-ascii?Q?hZO2ewxtscWw0TDdQOPLt9XPPXfibQX/yvkEWtc2S+gqU7mknNXJKNIGrmZ+?=
 =?us-ascii?Q?q2eHEkWyGlEbQEzOp5jJBAvDa5Seo0YYhLltfCjN0ogP2OsBCOOAbfhzXPsm?=
 =?us-ascii?Q?WW6oDWpo1PyMNe0IHzIUyfWkp1IYoZmSVhp7DRvcZ5nijUfcWJvI+s1TwdJU?=
 =?us-ascii?Q?f0sk8LkYHdbr42IUJRAf7GgNuO/GksSXQ41rmMVvnZZ1FeKbwtCM4IhBJylL?=
 =?us-ascii?Q?pflWJl6kOePWyLx3UDkrzMmnHZ59WzrOIY9Wcl0BijJortNepl2CAp0lHouI?=
 =?us-ascii?Q?Twg5kWmA0TrWUhlIegfvx1tojs+ONPHiGMh5jqENMTX3J3YxemfPR7P6OpU4?=
 =?us-ascii?Q?my8Ga290QSX77GaY3kWSZfxUQzOGRIKMTtgUVPDlX2TyuWeofJE26LlFDPmt?=
 =?us-ascii?Q?f9j1KGqUUtyvvZdtrxNU65/wgIHcjZJsN3Tl3J90mNAVPs4grmO4rr0TNvOF?=
 =?us-ascii?Q?d9uwRoS1LJJH3f6T0oVytoJw7zgfUtStVmR0vLbC4vEIpaIrAtiAOHh2coXc?=
 =?us-ascii?Q?UB6JttbhbYOwdPOtDNA1GoBmjV2mTY30tmblDtMC6FDJhHAewYkf2luxo/9W?=
 =?us-ascii?Q?//LgubLfxiIDlx8LWWny876r7TcE161McAVzj1emzhB2Ekx3sFf5l8Gxg538?=
 =?us-ascii?Q?DIFCfoBgxwHLo47Bi4z2OpBK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b71315-3e39-494f-3154-08d931a99ad3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:36.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTXWh0Dd7TTaN8kzpLU3rGYO1ZJXwRCAamfTj88tvgDAFLrzuZKauB7Yie2vJfoONFjtEWmglwaG3I/en8wqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/maintenance.c    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.c

diff --git a/drivers/net/wireless/celeno/cl8k/maintenance.c b/drivers/net/w=
ireless/celeno/cl8k/maintenance.c
new file mode 100644
index 000000000000..82c1255b8872
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/maintenance.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "maintenance.h"
+#include "utils/timer.h"
+#include "traffic.h"
+#include "vns.h"
+#include "reg/reg_access.h"
+#include "sounding.h"
+#include "utils/utils.h"
+#include "sta.h"
+#include "motion_sense.h"
+#include "cca.h"
+#include "noise.h"
+
+static void cl_maintenance_callback_slow(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       cl_cca_maintenance(cl_hw);
+       cl_noise_maintenance(cl_hw);
+
+       if (cl_hw->chip->conf->ce_production_mode)
+               return;
+
+       cl_vns_maintenance(cl_hw);
+
+       if (cl_sta_num(cl_hw) =3D=3D 0)
+               return;
+
+       cl_motion_sense_maintenance(cl_hw);
+       cl_sounding_maintenance(cl_hw);
+}
+
+static void cl_maintenance_callback_fast(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       if (cl_sta_num(cl_hw) =3D=3D 0)
+               return;
+
+       cl_traffic_maintenance(cl_hw);
+}
+
+void cl_maintenance_init(struct cl_hw *cl_hw)
+{
+       cl_timer_init(&cl_hw->maintenance_slow_timer,
+                     cl_maintenance_callback_slow,
+                     (unsigned long)cl_hw,
+                     CL_MAINTENANCE_PERIOD_SLOW_MS,
+                     true);
+
+       cl_timer_init(&cl_hw->maintenance_fast_timer,
+                     cl_maintenance_callback_fast,
+                     (unsigned long)cl_hw,
+                     CL_MAINTENANCE_PERIOD_FAST_MS,
+                     true);
+
+       cl_maintenance_start(cl_hw);
+}
+
+void cl_maintenance_close(struct cl_hw *cl_hw)
+{
+       cl_timer_disable_sync(&cl_hw->maintenance_slow_timer);
+       cl_timer_disable_sync(&cl_hw->maintenance_fast_timer);
+}
+
+void cl_maintenance_stop(struct cl_hw *cl_hw)
+{
+       cl_timer_disable(&cl_hw->maintenance_slow_timer);
+       cl_timer_disable(&cl_hw->maintenance_fast_timer);
+}
+
+void cl_maintenance_start(struct cl_hw *cl_hw)
+{
+       cl_timer_enable(&cl_hw->maintenance_slow_timer);
+
+       if (!cl_hw->chip->conf->ce_production_mode)
+               cl_timer_enable(&cl_hw->maintenance_fast_timer);
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

