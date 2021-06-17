Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98D73AB936
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFQQNf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:35 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:37092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233751AbhFQQMQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiEc7hozaRuvk4gzMRju0GpvXzqnFgLeIs2Do1X5hFVtV1TWfsXoz6/f2dpJmhYtQ2dQJmYhyP1ETNaJgUGIyywWF8YGEsNmjhdzXBjClIPS0FgcRicEHhXjgsT1Y4cTl8Zrr42ZrpyR/uGJKzEZ4iARdJl5CYA8amR8AmHxGdRE0sb3KedNoMpxrRnCmB0oNszT9Fp4sZxe+Arqw5NC4r+bkO1u5H0dju4OLxXmdfRnTFPyearfXhiiMULE3R1NpbQsYvhu8LB3E4ljD0XsYkyQSmKOoVrzS/sjuZSStdtvZg4vHUKnAKJ4gOkQAhusDp9AnD6oaM4kv3b6ESOGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArGAyOuMMjwaoDurl+5MrEpfL/8KAAqcv8E+kOSHskM=;
 b=fGmWq7hqvSLrYTWzx/kCaMplySWDzapaG492xvxUMjHfxiPNwmGk4dw96Pw2FQGbTYMa0zd+QGZvFup+UbEi2t0Y8p36vwil1o6dxTp2lZ1YuXiCuslrQHZUmc7WT2FqLikMUUIBH8TXzT9QYENYgl3KQ7WMoJa7BsQCHF/ioCpWNfLir7bYzC+3D3AaVTeUgEuAfvINQP+r5eqR+Tf6tvoTcq7GshQZIO+gcmkzyUvA20eTmGOx65oQ0gC00JNogC2SedicEyAj4lbVHu7U2BLKqTZqvdr1GQqDgk8jPhP6oeGGTple64TAwWjNaNI+9nkADep+xWKQHZkgp8IhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArGAyOuMMjwaoDurl+5MrEpfL/8KAAqcv8E+kOSHskM=;
 b=rw8cDtcAKXxX/Ad8utTZ3rA2hFQorlAqFSHWAWBq4817tR2Y2vinToLorSkBuVDhsureXD5BL0SndMSzAWxPUuQKn3Co5DF3PiHTTZXai7+G8CcQ1MHhu69qJZpiyZ/1Sp5+fIIOozgy8ub3NWZ8jIiD0/4K7lGnsK0Fe6TW4lY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:19 +0000
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
Subject: [RFC v1 207/256] cl8k: add tx/bcmc_cfm.h
Date:   Thu, 17 Jun 2021 16:01:34 +0000
Message-Id: <20210617160223.160998-208-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 458e009c-17f0-46a7-340a-08d931a9da51
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB107582CF144DCC08FB961D22F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lSk8s00qpiyBRWvrvW1fB1h+e3xd8a5pOe9JQ8HZ3l2ZAOaG0NO3dky2mw0JViwfejjYsFCtipmZnWuHEdDnD2uEd2xSz3AHf49GuOY/ii+/b2Adh3nfsWL6H+71t8gPudiP2QmXZlmyp/nEr6dcYlrLBO1ZIsClTyGnzsWKyN1JxmXRuvwKKl60DNlRa/cqpGQ37gIVWyz1ZmZkPcPO1W938+pzYlxGq9nQW+gDmQQON1LQdD+SBK4b/zrDr29YXQbwZjyPWjOFq+Sc+mrKzCuPGYco4PHj2iybwtenH7eLmKTctMThPnw8AfHeSpCo6n8R47T0QX96aIZHFzlpPh00MVgFdlZntxtm+KoX4Cm0xq1Vb8W/x/5uVTst4YY5motBZQGQlCZzxMzHav/xu0ry6gFGMN+iQh+hzLJQ2Vr9j5aMJx43bfncqnM6c0Tpfdqe5AykkPwevRL6dMLa9MEC+6o5sLAC97HBqzA4sy8NCvofygkNtnTC+BMK962IhlAawDKegRrWSqPCXcnVyuvNCFbkaZgD5YryP8xk/fJ1/UwTsUKrB1/ifVI2p7l/sUhdCQ9HWxG+XXs4P0pv7p2CivkrSKWmnJKEWPeR8AoZSwkN7i0CEQ28MBYJnBpiatVkyePrwOukNftl8BujfFk2GETq/NRBPJCcmuJCD2gAYI6cxc9H9eQT+Hmy4y80ElTvc+WbYHCCDzbf2t3TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9qzmcq138MmvKOo2ILIF1djc279BCDpckrzbZ6n6BKmejQwnmOsxDh/iAUV?=
 =?us-ascii?Q?5ZN6uY7f1PgZaZZwZUouqjVnstwxUwT+JhPn9W0IHWH8gnRqymFJhO1cMYBZ?=
 =?us-ascii?Q?JIs+fujJ03xGwFT3I7Uuv1ZOwF34cgElxwYCn/M8sTPcf3Ov7xaxO5zWchxo?=
 =?us-ascii?Q?VtbRpfKXgJGutMtN/NBtBs2+kni4aUC7Y3Y1MiNKYmklqLwsNngmpU45A3zT?=
 =?us-ascii?Q?2j5B0l0r2Xbf8UuAtSPVhU49BqMWwGe+WlPwRTnMBNHqLWfehxzzfeLA4lLH?=
 =?us-ascii?Q?Own5D2Y/6V2rWGg4VlKjosoe23Itn1CGb5AQscXPgKNOFntppvKyyIKl92tD?=
 =?us-ascii?Q?NYqKHKtHsyy4yH0wBUg4WRRc/+KZ9sxMACMAT4Hfcmza0HwGyXpDSe77wngd?=
 =?us-ascii?Q?5GCXsMtIt/joQNVJwyoVivPp9X/AQ0F0TFWOZqJEOz4UChZoywMHYhMclEdV?=
 =?us-ascii?Q?HjCCmkWQFpdGC0RBOgsKu6jGn8ihUDFm3JH2jmM8x66+OSH3Y8OEkkC8oHNP?=
 =?us-ascii?Q?yitEaYHCrzW7u4C4vJeJGA8FyVxPaA7Cg/4VFSWjusl9IxLctUQu2mh5KAdd?=
 =?us-ascii?Q?54+z6IIhoNiSdhIZv/EvBtjI7wFyWQIKBv7BJ9YKe71rGAYgozeV0KJav+Qx?=
 =?us-ascii?Q?2LfGWQhpQjC1jaiEgkM2JA/NFA4EoC5ZRFaF0pNp5dPNzNfLdMrWzVhhcS+l?=
 =?us-ascii?Q?BOW6WA1UhsgcrafyLceomxTAP5fmRgMvbt+LGW7C0oUndY+TLhQVMwuSTFzR?=
 =?us-ascii?Q?UtfmG8UjVZDCD7zdZymS7L6iptd5uz8kfaD3JRJ6fypSL5l35yu+caBnczdc?=
 =?us-ascii?Q?aGHVLxzN//32e5mkFTwogetU4Lr42PFfAbgTHPyeqHX9IERP3KaAGu8YqzMi?=
 =?us-ascii?Q?a+78SJnRn84VhV41AH/NsksKMGz9KcTKQ6YLTR6kogbwQujf69N6UI0Funrb?=
 =?us-ascii?Q?G3uib//O2muF5Hsr+2RI3sGpcUxdvctj7JFHwkvDYLY+S6gi2JmtprEzrvVG?=
 =?us-ascii?Q?99fOOncHABbNRQqukh8+AOF0sTP2hFek202UK1X9tOtb1FcRieKs9nx+nPxt?=
 =?us-ascii?Q?lmAjK8chQ48VzYXQlIrGj5AYDuGYgLfjdKm5N2kcl+wLp+WnklreB8EcmcVB?=
 =?us-ascii?Q?zpH24Z8avY6QDEYeQjaCWjggOdhxuMh2U85hix+TABIVTMbsD+6gRlJPcM7S?=
 =?us-ascii?Q?HIxqAjDOOHtjB85jTFkb0dlUB+TCaIQVHNqwIIm1WMu/mskCZQGjyb7NTjPX?=
 =?us-ascii?Q?Cxq3rado3B5smRZnE7k5Le9mpQ+QN/W3lOReSH4vCRYRjKvMo8mQHPBnFEc9?=
 =?us-ascii?Q?6HuacKVb5f7nJgDE70hvZxei?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e009c-17f0-46a7-340a-08d931a9da51
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:23.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKEKgi7rZiob2poHor5yYipHha/wZfYeprWlJXB1SnyKF8lSZf5rdT55rozzt86XVNNFVE8XuSIdWf53YF3N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.h b/drivers/net/w=
ireless/celeno/cl8k/tx/bcmc_cfm.h
new file mode 100644
index 000000000000..b30c96587191
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_BCMC_CFM_H
+#define CL_BCMC_CFM_H
+
+#include "tx/tx.h"
+
+void cl_bcmc_cfm_init(struct cl_hw *cl_hw);
+void cl_bcmc_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+struct cl_sw_txhdr *cl_bcmc_cfm_find(struct cl_hw *cl_hw, dma_addr_t dma_a=
ddr, bool keep_in_list);
+void cl_bcmc_cfm_flush_queue(struct cl_hw *cl_hw);
+
+#endif /* CL_BCMC_CFM_H */
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

