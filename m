Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDC3AB8B6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFQQJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:57 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:14478
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233672AbhFQQIp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTxkeI7Wclr8JoMRD6eWUlR7c9r1/zk3XTcYHlbxSXCtom1jN27PUpj27G0LVva9seV96MBYjoQZyXcqoMjEpbq9uU3e9Qt+zU5CP5vsiUc7zIqld+pL9DT3N4jCelbMODe+oaRWsozNELZy+er1NH9EWJ0vloLkfJhaMFkAemGM+dZzy967PWCCsTzgohdlnIhznCBdsiGPVM94vLG+yWaAg2zWgfd0aS5ETWKFtiClIk/E/vMc94RrYF6DugaeSt7bKAAbh5pETLOSvv67yMmLwuPEhs2iEJ/VW4kEywE5PhZUYq4D6ODUD3zVI+v63Yzd6xluhuxd7e+myBfWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDcNtTNMNfE6NgQ93o+ahB+qeEd4NII2vPahk4+taxU=;
 b=Wk08Ol+j8MAPUSgH/dlaiMQfJ7l7Jp7+2avVPB6nkxDhjgPOPGfjzK7bdNa2sEYjwIdDLCtuIQtSeLC96wiVENjdJoOi2o2lOsXFjAmEgfsm4xPF4XxZ375AxLCe+GZLypPJRUj83F2Ikl8NVud/g7ralfJqDUTidTw6fZBBQzPfGzHvEWWsKA/6iod52etHWphr8roD/6Ei+uOTHSuL0EYaF2Mh9CmQoxTR2z/Jb0BiACSYN2CSEH/NjIa1QXvPdwuTqRk+dQk5Nn9NsEwS4wpHoZmW4tfPDN3yiMcJiVNFD6wEAhmkGdyV4RAzYWQ0zM9Vp35s1akjpWzB/O5bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDcNtTNMNfE6NgQ93o+ahB+qeEd4NII2vPahk4+taxU=;
 b=vxE70V1QjzMeB714uDQyAHpiuhXOFrzAE/Q3h1gbjH4H0CLOn26U7QQSF/p7P9fqZqSxbv7k4hq9XmlYmm0b+3I9PdMe7n2RW+nFiswiU4kAoWKvk5qKV1yPZCyIDUkzBIjTpYiTVR+p9l8OGU+c3U8eXO8d63a9VNmjQC89CX0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0981.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:06:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:35 +0000
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
Subject: [RFC v1 175/256] cl8k: add rx/rx_amsdu.h
Date:   Thu, 17 Jun 2021 16:01:02 +0000
Message-Id: <20210617160223.160998-176-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c902cd7c-eeac-4c43-d015-08d931a9c4a5
X-MS-TrafficTypeDiagnostic: AM9P192MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09816860B4C3F4ABE838CFA1F60E9@AM9P192MB0981.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrnK9gxwkV4Cp2ffsgrLDeeX1D7OjXbr0SDPj/cyYCLesDqrdQzrPkRsEF+bdR+kFVOEmbvRmHzSZF9p6hPcHccMkuY374DsoKlo2HK89OEdpwxKjq9yyYeeOuoCaqK1Fpf9oj9mPyl/udxwdfW9MX6l+pwtsDKaXphBeq6GJxk0TnJnSElxQ/Ah6/PWdTE3xOhtUkU9qX+11G97X+aPIaPHdfebUEgQEWluojUi4+WUO/unq3uFjNne6GrVW3ub6c8xJ9rtTBFrvGlYYfG7MZX/7UEb62Dz4OGSOovQRXaQkiJnK416FEGbKBs+gavqCnWQuHf6rAza53e9BqUaXfDHzwO/Q5IZUkjn/ngte/PhjrSqKG+/2OBxFWyfHmT31BNPqgBmdwOnFJIyt0RUm3wf+y60NNlFGZ9gUedTwvnsscx01pPNUR2XFhrJ7b+PbnG/5uEhR4CtWOW6kITZ8c8uNm7TDdD0GxZUlcp/2vSQBHnHLFKDeghn15Jnesrn1SYtLZNx8rotDJSHUBf/MuRCMquBRnjGy6B6eVlRJzzQIl5Grgor6m9gaY6dsuoZ3Qxy2nCfJ6sIRwh7sEyrXDYFFmP4nAcOitomnRjhfoMTyjYL//wQVBRr13QkXCtVPCetto65lxtLSGgiogqCicqVJ1DhuUOv0uFpsvhzfcMiUaB5FUYmwagAyn/7cgUUdrMbXWc4KPW9WGIFZRuZlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(86362001)(5660300002)(9686003)(54906003)(107886003)(6666004)(1076003)(2906002)(478600001)(6512007)(26005)(2616005)(38350700002)(16526019)(55236004)(38100700002)(6506007)(4326008)(8676002)(66946007)(186003)(66476007)(66556008)(956004)(83380400001)(6916009)(8936002)(36756003)(52116002)(6486002)(316002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3SgT9bEIcQnTLW9mfKqyF/jQApEVhCXYSD+fwvn2loBrrp2FTWd5HbGNe1k?=
 =?us-ascii?Q?UzOw/p4xDPVaNUE7av25VnSNu7cpF8kzV+swO9Z4rEhIS91rKtBt3+3RTvOH?=
 =?us-ascii?Q?m85KbFFc5/gvsNMsmZw7vQb+/eXUokkxtsskOhjKTn1Z7jidRRbaRJ6a9n5v?=
 =?us-ascii?Q?hLTp3m2tUnaAMYC1SIM7ZrDtiYWqBenrOxPdMsFnugshhPhq4PDVQbM/S5ys?=
 =?us-ascii?Q?LYoTLOLbHScljtGsCWovgStLsWhBgxykFEOhsQrMFVtlQHaAjbqwnZK7vknK?=
 =?us-ascii?Q?6NtO+VNqLWikt80oIYs3ruceK02I5dauE20JlSFg/CNNJDbbbkqQBEP9YCAO?=
 =?us-ascii?Q?5+uxS4B9Q0d0qYntIqrC7BYososlSN60HebJ+CfsMIhXCw1jHfnsHO4ymK1T?=
 =?us-ascii?Q?KcSHpFmbB6xquc4BoZZaSMtDdiUoiMfO+3tpXqkDYoaN3sofiGTCxH2xV77W?=
 =?us-ascii?Q?EKxbGE8nmYd/lzYmZCrToQyfx7znUidKabDgChc49e78WKH7fGy/ertdVouf?=
 =?us-ascii?Q?TWf82H/BMSJKSFDgRT63/VvKePGEwNoValXaCT8L2M4yKpdBYN+WLJtIZGWi?=
 =?us-ascii?Q?5A84hbfwrniFd92uJIJRYidXtMMdOeWEQIMXIQ/kDprdTRia5WB8z+ic0xgA?=
 =?us-ascii?Q?KvxJmwZF+/HE316M1UhXZy8Cu4yTWkhtUeoZuY/IE3PhXn8UxKW+ZJoEhEgp?=
 =?us-ascii?Q?IhZCxfxGN8SuSJUdItAZjtcu9hKWlkHm95n+VUGBTTmeaj+0Vy1iMstxaJVu?=
 =?us-ascii?Q?C7OHu0TQ35UgTFMXY8VbQDCb6yNEHn7oGBBr1d2gjDRSpddOMYCy8r78iFRr?=
 =?us-ascii?Q?qsELjFrHrSCj6dtxGG3Y1qfaAeCeg3asFiYnATH8SQQVxqQ6UKL3CW8oynZV?=
 =?us-ascii?Q?j8axaOzr+OCx3Zz0HA9MU7V98liJAXzn1aiz5Sle76LTXNQSomscbARQWMO/?=
 =?us-ascii?Q?plZVwFJ08hLeo2bXdPNHVa3cprZYLZkaWPIEiZgKg2tl/S37H6FHUmx7KCbO?=
 =?us-ascii?Q?wdud7/X20yInwaAVuRVexw7HHHRvVibZkSwwEUK4UU+YfnxuVF2OmxyTvkkv?=
 =?us-ascii?Q?/BCUEFufhS7g34sNqtIJN49oz5rKoEvwd/Oy8IMIfSR1BeR3Ol1yL8h+0YVy?=
 =?us-ascii?Q?YccKW+W4raywIzbh9UIzKB9TojIhsezI/vckAkdkVdqv63PB82vh+oaUgSOQ?=
 =?us-ascii?Q?s9Gu/6xrdDHnYfLw0yNxZZJkbF4DMq5RUxI37WLRGdsZMvfiiOd5ywh+8nn9?=
 =?us-ascii?Q?VFVPYLMlwLwvoOcBKbx0iJQm+RjWkOXuUp4AyFleiQS3skBBQbytebt5/6Iv?=
 =?us-ascii?Q?oh0krcx/kYj2o9fpy8GmPX6/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c902cd7c-eeac-4c43-d015-08d931a9c4a5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:46.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwLjHNJYs9len3dhY5pgJGcZkTnJ7koqH+2E7FmLijD2L9Zc8w7M5KtPFXwc6e3+wrC7z1PW/gRZmx/AZqRdww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0981
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/rx/rx_amsdu.h    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.h

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.h b/drivers/net/w=
ireless/celeno/cl8k/rx/rx_amsdu.h
new file mode 100644
index 000000000000..a445f4a83187
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RX_AMSDU_H
+#define CL_RX_AMSDU_H
+
+#include "hw.h"
+#include "rx/rx.h"
+
+void cl_rx_amsdu_first(struct cl_hw *cl_hw, struct sk_buff *skb, struct hw=
_rxhdr *rxhdr,
+                      u8 sta_idx, u8 tid, u8 encrypt_len);
+bool cl_rx_amsdu_sub(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_rx_amsdu_first_corrupted(struct cl_hw *cl_hw, struct sk_buff *skb,
+                                struct hw_rxhdr *rxhdr);
+void cl_rx_amsdu_sub_error(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_rx_amsdu_reset(struct cl_hw *cl_hw);
+void cl_rx_amsdu_stats(struct cl_hw *cl_hw, u8 msdu_cnt);
+void cl_rx_amsdu_hw_en(struct ieee80211_hw *hw, bool rxamsdu_en);
+
+#endif /* CL_RX_AMSDU_H */
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

