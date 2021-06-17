Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5013AB826
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhFQQFO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:14 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:35801
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233543AbhFQQFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAUBbLlQvY9hRIjeLEFKiEym8wsN6EOF0Zjukd6oEoghe5DlCqBOIFON7QWSm3QyrbPkW9IOBYz0nDTgwOQKPppp84xDFjeDBZ0fBGdqVyY1v9V9p9GmBuobllp2zVEcHYt15wm6dJwHqQYvgnmLvw+C9jvtq/NvTYOpDQKSFMnbGwQK9Wjf1ejmfvZWJ4IyXc2sN0PXLX+tkWQ8NXxWYrCqLDTSwuNcAG6s9RVBQTDwI1uCqvKxssYifgvacg0RR9OFgZkIKJIuDbQgfo0pII3mJ/8EPjyiwpY9Xg3kJ0Ogxsv+Pfr/rc9fgexOwkvSk3oK/5XOr+4fS4aJLRSgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFaNX8khnwNjspBqPI6+3OW7AOsiRCbdF7dlkTPh5wo=;
 b=cLkuatUz0W2T6f6Tkbd3g0aOn14VbaXeBc4QUKaf/v+hJUyp764fuDdEq9OXmXKh4yxqINUMKlyZiTaQ6jSVp1G/t66tZeGXsFsi8DGA13wR4CT7/DoqAPYKvYJqQ38XD5CFZzx7ssHvS7bASNGCK/lvTSuaIRHSzgSxxtY25GTVX4m4tAgj8FLQfl2gjaFxDHgnYH6EBfp0jNvj14NwvZ0e6UZXfd/p6K+6VSebdvYvQrr6nycc4RN/hDKNGyu5IXPEyAhLVL+xhlk6EVvHG/R1Jw33uuepDHEFEUTQAjD4/c8KBK4K3pApuECjthjcF42Dr+oyIsdG7ed59PS9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFaNX8khnwNjspBqPI6+3OW7AOsiRCbdF7dlkTPh5wo=;
 b=CZKYNclEUIvBAoFIxWTFwzoDg/dRZ4AFwiq8z3Rr0C1ibFfCM7MJxrse3e1H26K/6CVJ7pr4cR24K0HKznhjAs354v/JCIVscUGLSWpmCMhMj0PUkXl8edZFN7aVYVzYaTzW5v5Cgct/yw94Kx1HXRe+6z7IdT2my058P5PsJ2o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:45 +0000
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
Subject: [RFC v1 010/256] cl8k: add ampdu.h
Date:   Thu, 17 Jun 2021 15:58:17 +0000
Message-Id: <20210617160223.160998-11-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d183aea8-ac25-4cfc-dc88-08d931a9582f
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1412C5A4FA1943166A86B3C2F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJ47xixtcQHf+SYmtVqH5MZoV81LpBKSykmFsEiOJemavqzmRrK9dsmarXG3hQuB3/6tAT0KtZPkh6gtQMQ+/cFSO/vQKB+/PKazPjUm9wNTR5HK+p2nxRMc/JC9udZlOftWWBY/JsHR/FiAo6cDKB9wYUCQDQE4xL8e3UMwh5FaYxeKNttbAuD+5QD+Y7Fqg0TxNwsgQOkJlMit0E0hI0Q0cd1E6Vq6Z6KYv2FxggK/FONYxGqkjbQj8J/seBAbaN8fv3sigSwtST/olQol6D0XtOTi+wCVZ4533rhh3SuWDCYW2LyJFnoxzzP7TYxyvzfgAzlmgMMVhpZBqA/abQEOFC+1yCdiqp6HqeSYPmsdctyeP+VE4cxQOpmMv8umBrfoYE528T+825QqIFXZVWlmgTozvYa4Ys8VqK3rQ3f0uqqKW0mOXjYsB+ZfwVEHX4eur7NjQ49kARRYW0q03I706zwU64Tk/qmMg+vwqe3rtahXvHtLFeKJOM7HUGqbCwd5/UnBcHddZVgxocFaa4Pg8wVMlraesaJuhNY2yoYsVbHdjFPjiP3IAoJpxFeRO+gGQb8M+KL734K0eqBqhvPM8Cz9ILg4WD2fFAx3wihOLoyJhVNzJUVq4/5Gs2eb0S+aYcD1pkFkBEKgp/VyasvyBrv2BHUfm4j++jktFNcAYwOgPEAIdSlQd1JgjLxosbSBYr+HcIsf54Inz2MTag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzXCqTXve6mRi7AMVNFli2o7nsHlJwyYKwnbckN+kztMhUttSTGPzxc5zVyt?=
 =?us-ascii?Q?HI7MamGV1prH/3IIanzxfWYjcSsBair0QajJb+uXeNcstRJwm2aYbq4rP2Dm?=
 =?us-ascii?Q?8eC8nV+5bwusZUZCF8i/ptnjcsCHjnX4XICutNzfKxRqDoy9fm09ueoa+TRt?=
 =?us-ascii?Q?Tfb0/ZZs2LNV3Q6PTbWLtWWi9HJ/avc+yi2rJ/meHzuarIb7vZvKp7A2a/VB?=
 =?us-ascii?Q?qlx6aANUIjFwJGWTPPY+IitLmGXn0ofGIHT17a7am028MkJ67bXt+FrMUazd?=
 =?us-ascii?Q?qhDf7DA1Q5EL9vQi/UaEq+t3xGb4BGrnWUpOy4UL8nAKm7IKtQnECSflh0sL?=
 =?us-ascii?Q?sjvXBqHa4bM/JtU2X4NCLYG0uOSV0liasR7ABxyRL/Uxg9bF7HpHq7UNnBND?=
 =?us-ascii?Q?Vf+FGtLsbo2Om1TSp6Ug82uK2TM4pzPN6aUhGvr7TrfsrIglTgBLjt8SPtOw?=
 =?us-ascii?Q?t9mJMe6cfj1jMsggAhvLaOgQAEZzJCgVGChvZA2hCjsXb1OZrqUWIgKTkFLc?=
 =?us-ascii?Q?ln7zMOhAnZP17CI+zXJg3jJtKcrBEwzL6LGuaCsiJY3tmI2IZqSEM9HLiKhJ?=
 =?us-ascii?Q?lfNq9FCDhB+mGZ0UBMun2OKE2OopgyIkA7cEqh5ilBygsjkdEmwdpqgKmL1V?=
 =?us-ascii?Q?j2BZuB0dlm8bD881/oaQI8JTqGAb8zLT8k6BgGgJnqtFaEc21EgVuszmaf/U?=
 =?us-ascii?Q?tz/IGpjJsI13FZ3Yj7BTwegR8tqo1xi12Gq5i9/j8AhOgiQbMfwLu6MDngF0?=
 =?us-ascii?Q?pTcNpBBWuKB8io0Psrdf/Ee5H534b3dq2Wry2DBkcK4+nKHVTBRQB0VNMdz/?=
 =?us-ascii?Q?qDUg3vGEpdO8Bpa3uXMCmJ0zWcdzcwEcPmdBqgbrO9vBG7SXRkn3TffJNrM8?=
 =?us-ascii?Q?bJrrTDh0tL+6aDEf3wJ5m01nS4K2C8Rl9RPPaD1Y6VLqUUYlYjWGVkfMp19c?=
 =?us-ascii?Q?MGvEtmFrV2RZsgFGeQdQTQoeAqGpzkscy/enLUarYRLg0ne0yrizZbiQ2mZQ?=
 =?us-ascii?Q?kPluDrVXO3LUL2nZQwuYOkU9Aes4+yv8w0ozFF3O2zjLDLljdvq10xXiicof?=
 =?us-ascii?Q?Jxl9vWuJkpjk3+az5DBBAum4LfwaTxTFBTtVQloYg0wAcrmbrntjZ3/5yHFW?=
 =?us-ascii?Q?Y+4GQfLN/M1OfCb8BFlx9FvRVSHef7Zr7OaBjoJnwnA4hxPq5uyRxk9YkPED?=
 =?us-ascii?Q?fHRCB9GQ8EI9F7nGYavgiP2rT6PibYffuaNk4Pr+XncI/Ydc9OO4w58AZOKz?=
 =?us-ascii?Q?rsPyTg30yLsg+B3s2ztsqWzX0mhIaZ6hxyhxAjkn9xPFvvtj5d7zDSXFn47t?=
 =?us-ascii?Q?I0u2VXVdZ3+1KUNRDxFG29KI?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d183aea8-ac25-4cfc-dc88-08d931a9582f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:44.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJVUhiOVDZyTW6Hu+8Vl/S9GrdE5EbIz2OJ4z+0ViDue/q+jVrhv2tpQLyuuvHXrkAEI9iTuGGQeAQ+SY313vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ampdu.h | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.h

diff --git a/drivers/net/wireless/celeno/cl8k/ampdu.h b/drivers/net/wireles=
s/celeno/cl8k/ampdu.h
new file mode 100644
index 000000000000..8b1cdd35dbbb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ampdu.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_AMPDU_H
+#define CL_AMPDU_H
+
+#include "sta.h"
+
+int cl_ampdu_rx_start(struct cl_hw *cl_hw,
+                     struct cl_sta *cl_sta,
+                     u16 tid,
+                     u16 ssn,
+                     u16 buf_size);
+
+void cl_ampdu_rx_stop(struct cl_hw *cl_hw,
+                     struct cl_sta *cl_sta,
+                     u16 tid);
+
+int cl_ampdu_tx_start(struct cl_hw *cl_hw,
+                     struct ieee80211_vif *vif,
+                     struct cl_sta *cl_sta,
+                     u16 tid,
+                     u16 ssn);
+
+int cl_ampdu_tx_operational(struct cl_hw *hw,
+                           struct cl_sta *cl_sta,
+                           u16 tid,
+                           u16 buf_size,
+                           bool amsdu_supported);
+
+void _cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+                      struct cl_tx_queue *tx_queue,
+                      struct cl_sta *cl_sta,
+                      u8 tid);
+
+int cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+                    struct ieee80211_vif *vif,
+                    enum ieee80211_ampdu_mlme_action action,
+                    struct cl_sta *cl_sta,
+                    u16 tid);
+
+void cl_ampdu_size_exp(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+                      u8 *ampdu_exp_he, u8 *ampdu_exp_vht, u8 *ampdu_exp_h=
t);
+
+#endif /* CL_AMPDU_H */
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

