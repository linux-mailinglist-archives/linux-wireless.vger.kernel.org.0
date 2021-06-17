Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33543AB899
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhFQQJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:11 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:45023
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232842AbhFQQIH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLk36oGyncRdHUiMbmCMPAyKSQlyjdWxHNhs8vqSoj9/NIkU3TLUGA8DZgBr7kxmifFkhSh0T6SyqBMqDXqm+HD4AarU+BGxWoEy4Um55El1jHCxzxkLWJj93KSzr1I5gpeUn3FG2mNfeVKSyVZAKBnNsqNDr8Y1hI7Jk1ovvdK4rsZTx84f/BKwQBiy9D6lFikySBuyZyulxQ5vGWwwIdn89dIKrq6nSTNShmOi6D1JEbAJGtRjWJoy5l++rTvaZhZGyK0W4UIWufC1bWQS7Q+QisK47Ii0+z8fKSPd6pzzFsrMiS1xCiYuVEWH5j61z3Kj+ySiEZdrNo1IaLf8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYWikKzwuNp0SbNjyx8VPqT2gcV8FxgEUDBlDQevuwg=;
 b=ieWfvFpjlJsRyCSOeoGHEcUkH4ZzDGR8ZFbGievMj1jcoHgqpU4GN3Wxa7grJnoy6pqLZREyUX6gktVdUB1I7yXIsGIIa4tezipIqEVL8L5JJUjJ6GxiRwgqBA7g3+2ZzceqhrDiDo3SjqkhCcUPkxtpNY94H7vNJlOd0bIANtOI8vz8bG96v/BSfMI5HpHk7c8+jWkG+Sf7ER2UeL9TFJ5I+5WDZcvrD9wgNHncnCXysIcNmCw7d+2efRyWunTrOOOhts+qvN4CjZSAALyN9UEtt5DLBlVLpv602EE7NuFRMplhNotI/vci00UFzoNsOZYUJJK0qSOHfp1R0ddPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYWikKzwuNp0SbNjyx8VPqT2gcV8FxgEUDBlDQevuwg=;
 b=NF+DL+Ro+IBDUHwICrHi39pH8v14Sykoh/u03t0SYBkVACQWQ8/nxThonBHuZWYxI/7bKXO/4h7rUdT3HRdx5riwbi8gubf6uOf7ehc7DjLtt9LFiUHylKUObeEntApBspOZg463s4jUPAjxHcxDuztTKcL+yR8pg0Famhvl700=
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
 16:05:49 +0000
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
Subject: [RFC v1 139/256] cl8k: add prot_mode.c
Date:   Thu, 17 Jun 2021 16:00:26 +0000
Message-Id: <20210617160223.160998-140-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 235f4133-a6a5-4fa8-bcd8-08d931a9ad38
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0465CF29EE0CB8A4637B7210F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqdZHcYMVg4xYnRJO+FSyKSThD1MHK2pcXzkmS7Z5hVUSQYPbZJLjCO9Mye3RlE84yFAvAWmPDw8bmQYCQTQNUKXNyosat2TxhlKrzHDewbTbzo+jxsqtBZWphOURZGbGPbw5jdnhWBDqzdNeCavGzOm4Zb05pjAGPBS0Ua9JdPkV6DBpPSVNgjEkHnG7czBVrXa/vLSHQt0eZOxNU2z9vGJokvVhkfJO+RUvRacO6zjM92o85w+FYYS4+ui//FrZbFM6MoXCLU59LGsx+4rAjN4HoLlUXkAUAlO+kvq7Fp4CQq1MwwwFNFPmz4Dz3xV6f1zHHdw1QjIy6vBgVFj5rPmQN2cBvQVMqvfc0gclAsuS24o/EH3Tdtq0FHRffv1XHassRyM1W0Y2v9ea1Z8CptQhzL6dUvTibyWcVPQQz5hazP0MR4IgiLWS7b+V6ciW1lb8DYPcJt/PFCI8xEjRI3jqJgCFuoJUIMwrYs3yd59KebGp2LhEbtHhQrjugCJIEvyqzzzWad4LraPVVOSyruMRH3godegD8Hx4UHIQHJkqm2yCiASqcLtOWO+LKCQG4Gjt+5u0DpF/eBgWOacFtW7P8G+nI38mbaTY44xWiRpNSBRzJu8RmjGa2prUC79zygTxw9svx4zny/hujeK4E/JCvwDQoFL66qkM6eQgBLF72UYthRgxnatokhK4s0x9twWccNnK6itaQ0db3yDsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oxZaXs+hDT4rOmhdPTRXTvltNFG+2VQuVwWt74HzyEfTWQ4FwcjMg31fWfeI?=
 =?us-ascii?Q?6VB7XIUf0hkoOdBdfniZPPNgnRoT+H3akVPrw2bOiaRlF8U1xABMzqAlm6P5?=
 =?us-ascii?Q?zyn/Roy/WNQVPMykXge+FRk8mx8Snxh/8g5ZDE/DBn+0cgvO3DO+bQRm72Ot?=
 =?us-ascii?Q?kuhbJm0pkRA3DEjpOurEIAxOwyJNhxmCBaiHvhLZA3bAhpegxD4zt+zE34dx?=
 =?us-ascii?Q?fFGY6/PVscJkv6j3o2IHeYPnCIUWDlKdKo39kbUK03ucULXI8x2DRT8+5CqU?=
 =?us-ascii?Q?eZ7zHYqdGf3IbMS5dtLM1yssXSGqjGhHE0a5MQM+mY4jmt+V0b4se+yP3+tE?=
 =?us-ascii?Q?CleQDNq5nWoCvbQiBIja0VWwtK3SeSUnayK7SKmDp67EfQnNmkDn4uRc7kLU?=
 =?us-ascii?Q?yEn9o1EWkq38TTbmqWuwsp4kKYXdTAIPmOYvbUe8aHo7az/xd5vciibfz/Ch?=
 =?us-ascii?Q?hgmO6X5YswPSt4uxjj/JHWv2G4lCBZESaw540TmI+GQVHEqEGdbOWjlfikVR?=
 =?us-ascii?Q?MoWkCx/AYMTimvri30uAn+CUHHzMyRg+qqHhH+HyX1/3KYv7uxLVx5OUKG1/?=
 =?us-ascii?Q?VWyqmr/aTXqyUoZ4OlpLf7GDVvlDadOa/RS/8HQ/WLGdZjDj5VsQjyWlWIJ4?=
 =?us-ascii?Q?SGsToyBanf9VJMZ8cujh3TyPaiDhpWQfkNZPRO2mQ/GNXSu7zXI8KstjO/6P?=
 =?us-ascii?Q?trooockSe4kGs824lToZbl/GnPH7FtSwlSUwogPjLbvh/zJfyyfLUWOcaG5e?=
 =?us-ascii?Q?7C7ISQWuR4VjH40G+mkPSMcGHMUXzrTaD2qSOeVTTfyoKRwLB3fx27Bf2i00?=
 =?us-ascii?Q?KBpAajLHm88iAC2Mf9xRs8dsD3GXGLsNbIcvL4rrRRSH3zYMxh+wX/ZGAU2F?=
 =?us-ascii?Q?y2Bmehw9B6M0L8swCThCYKIw7xVbOFGGmpcowISOshvFSkIMVO+HJBlDfBGH?=
 =?us-ascii?Q?EjHvbsa/XX0/q8TYf9elNEfzpewFf5O2L0PhFwejpHHpVoptPZynv4Yizezv?=
 =?us-ascii?Q?/RcUPAZU3/aSZB1H5i9WbaPoFZnu3eZvNzF/xhGz2kBgrZi4dbH5syVQ7fiW?=
 =?us-ascii?Q?+VLm7P1mJEkSLPZ3K0dgOZh55i0CCWp45sfOg98WY9GIDNmRa2RoWSEknOQI?=
 =?us-ascii?Q?+Gi68FUqFUHRWWWVyCet2JKBoDUeklPxsvky8qPnUTU3norg1bSSSRBNBb5A?=
 =?us-ascii?Q?poapUke2FFeCZPwjMpcjndCBR3Alaj08bbVLCT6Km39K7eZ2zpH+lmiKAKDx?=
 =?us-ascii?Q?wsgAwcmZ7yLGaRXB1/Traz8b/Jaw8OfPA8xhCKitbtjzCdZbZKF+k01gm/aI?=
 =?us-ascii?Q?Qsca2Puid0FsrUNbWRnB+Px3?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235f4133-a6a5-4fa8-bcd8-08d931a9ad38
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:07.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFL3U5hfAxwWngieHz1/gp7tMf5LitgWFXsX8DHLEec6b7Z4FSvO4ncuvRZji21u09DQrdjhBbbQXB+tASHeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/prot_mode.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/prot_mode.c

diff --git a/drivers/net/wireless/celeno/cl8k/prot_mode.c b/drivers/net/wir=
eless/celeno/cl8k/prot_mode.c
new file mode 100644
index 000000000000..34e20328772e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/prot_mode.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "prot_mode.h"
+#include "fw/msg_tx.h"
+#include <linux/string.h>
+
+void cl_prot_mode_init(struct cl_hw *cl_hw)
+{
+       struct cl_prot_mode *prot_mode =3D &cl_hw->prot_mode;
+       u8 init =3D cl_hw->conf->ce_prot_mode;
+
+       prot_mode->current_val =3D init;
+       prot_mode->default_val =3D init;
+       prot_mode->dynamic_val =3D (init !=3D TXL_NO_PROT) ? init : TXL_PRO=
T_RTS;
+}
+
+void cl_prot_mode_set(struct cl_hw *cl_hw, u8 prot_mode_new)
+{
+       struct cl_prot_mode *prot_mode =3D &cl_hw->prot_mode;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       if (prot_mode->current_val !=3D prot_mode_new) {
+               prot_mode->current_val =3D prot_mode_new;
+               cl_msg_tx_prot_mode(cl_hw,
+                                   conf->ce_prot_log_nav_en,
+                                   prot_mode_new,
+                                   conf->ce_prot_rate_format,
+                                   conf->ce_prot_rate_mcs,
+                                   conf->ce_prot_rate_pre_type);
+       }
+}
+
+void cl_prot_mode_disable(struct cl_hw *cl_hw)
+{
+       cl_prot_mode_set(cl_hw, TXL_NO_PROT);
+}
+
+void cl_prot_mode_enable(struct cl_hw *cl_hw)
+{
+       cl_prot_mode_set(cl_hw, cl_hw->prot_mode.dynamic_val);
+}
+
+void cl_prot_mode_restore_default(struct cl_hw *cl_hw)
+{
+       cl_prot_mode_set(cl_hw, cl_hw->prot_mode.default_val);
+}
+
+u8 cl_prot_mode_get(struct cl_hw *cl_hw)
+{
+       return cl_hw->prot_mode.current_val;
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

