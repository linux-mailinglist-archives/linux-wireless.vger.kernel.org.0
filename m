Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342343AB81F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhFQQFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:04 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:35801
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233532AbhFQQE6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrgzDbMHy+zJP8iXn8fZ2SEUWqjA4uxzLRyqmVek6kzgF6VcGBCDIiQYEIp9W8NMoHsXGI29ikfCnNjyT1vKXM8ptR8rcp+w7Ssd705sa8qY0tKpfPx+5wNSVdZlwcQVA4UPdgCADNcpSj/V8l12SgLdbAjwwLeRYC+sZg6jBGo3RX1eMCAUt8vWtNFuZrrM8Hw8Hl1+hLhBsHqDjKpPZZLl1yrCkS2WEanFTDL6mjuXIs4KZbz2Rd/kNHBzuNqG8tbhF+S5Jy2Bjd6yDfVTKFdWBlvdHSgPEwybc3Cs3g+zZqiKT70oFZGTdaazns778427fMCYuClUUl9dc1f4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUH35m0cSWd6AFaMN/tZYrqw2iASJIes6NHAQQuf4JE=;
 b=EvZLR+i0Oq5eVpjAb7Zhr+NyI5+cimkhayCUQDjsmBxBz2A/oKI/wfHab2C+JAJUl/2oSjFy+rTlm16k21mojW0VcymKtRSPsx6SBM8RhhU36rFYXEl7G9Evvk7XhjjjlFlZgy0DBNB1VZi80s9aT7l5xT0ndnHBn44SjwDltq/72HOVnVb9ytlxbisVsZdOj4z9j3urLMZSBZwoHMEDERHqBFb4WgCzRUqQ1C8Kh7YeylovLEIP4vQH5l/FYA6nPL7D5+JGhRWvCImVriE+hETtDqP8EMdusGnQeGibGKM64V91hETdPiUMO5xHTHm2Tn1uLKwYT6TXnuWQwbLjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUH35m0cSWd6AFaMN/tZYrqw2iASJIes6NHAQQuf4JE=;
 b=xZBnVc8D58rURP+9PRxkn0JxCaRISJxJRY7XXAKrfvrkSrZgkpGfMxz8zJtIuFwFYDmpKNifL7Y2xV1GVOq++fEUxSop3QNoH3/LcN+/V2r1fLi+/HbiXF0AZCU6C4F/r5a8VUpAKdFMSKsfkOd+zkUNVCwm/6Yl1SX12QYGc6k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:39 +0000
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
Subject: [RFC v1 005/256] cl8k: add afe.c
Date:   Thu, 17 Jun 2021 15:58:12 +0000
Message-Id: <20210617160223.160998-6-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42b2687b-24f5-49ac-c431-08d931a95496
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1412D0E4AB65EDA858D5336FF60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9rR6LJEUEmdbKlKMzCrfWoi8kAv4K59UulBkMy6JtLa4U8mumQnYPo0+ZDMp0/7woZXQ22XkPM9b3eLmSMUucZolvqvKmQgtbPlurtYyPXbBFfyhkXEAEQvYoXVAozIzRiWTFWzVZasUg7ivZ/Gh4uIkkh4LM6hTJSzfeQosiudumgS6Esq2EPMSMx7LafhFHedhnZl47xcOAn+cPmsak7sEOnuu23G5KptAI2Si4UxSYIf02nhyLZphktNq6SrqH5HH0MPzgEy3WMlV7OZ2sqTtmLWuH9QarfWtQ/umWgDrLUWO4442IfLxPKIV+PkXua0z0yyd6A/dMKFdf4IZJL0YSe/v4KQjTnnTi2m1mMD9Kp4ixbcHmFsuq2D8mJRzoIgLXCufq9lp//2Z2StcnZ81CfCY/5apbk2U/uC2SRvHiQaEuTEHd9UK9jbQFQdvz0aAfbqwLUAohxtWmpLuFvi9dQ1Cj4WFyXp0WOL0k57qF1vf0DqQHH75chyFFsRJ2umVFwX4nAYoriVPx8nYTuBxYBuUyzwiWkSC9GZM5cv1AmY3NItUqG3O28raYgj+Rcl4ajP94VOY7xP/eH8fESNvGnhFAiIm3YNzsrdPtYbEqtjpeRj+m7iB0P/ZXM76ckxBotTEQfZevG2a+HsOCtgmjBEyNzYJ4MCAix8gcI0fyKeVhE9kOuavd96WeHoMI/yHclVpwTWCPOHxsAH2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(66574015)(316002)(8676002)(30864003)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XnmWeUtv5e9tFXQ32KxU4GhSgtmozczT9CxnbfaNovC8oOcfZGF38SdC7MC?=
 =?us-ascii?Q?hnEbXvArm9oBo/BU8vSEvxT6AoTbb5QhZbYSLdYGaS6k+cfXkgSMM46XOZXW?=
 =?us-ascii?Q?vsmc4F4BlIOG2WlZpMIzVH4YLJh9luan8UtwnNw1xuUNaKmYIWfh3KRnXSns?=
 =?us-ascii?Q?ccQ/LtvVb9Xg2T8qOTdUJcOQhQWq0nJDOzzpM5Ri9P7G9VhcwKVUwToD5DPe?=
 =?us-ascii?Q?4n3No8ulusKqwzoNoWjMx1/TxemTQy6+rSFR1N/jlYhqI99WUuQlfkS+lFAK?=
 =?us-ascii?Q?OIKsfT3vAwhjJHuzu3QDdXEmExRadupOnxD90Y7r4rztOrY0m2W1PrCpe+sL?=
 =?us-ascii?Q?g7ZzndoQv1daHPUx2tCn28ulk6r15uUKXu1o5a0NnuBu+xliYVjWF+wLP/2+?=
 =?us-ascii?Q?PUnVBFBEaS2FGN4AJNKPTuWJSC7siOu8zyL9GwvGmDyJf53P72W5akP11kzW?=
 =?us-ascii?Q?aTcNOHgFGB0NQ6kePOH6uPuL2ZulqzfkAjovH81yUDtTOfdfqwJwqqsSGFwP?=
 =?us-ascii?Q?/V3Bes3B6oHCbMxMrEfOo23PVwWGw06U3A6/BGncZoOVznAltWWO05h28alj?=
 =?us-ascii?Q?nTiIcjHRScC+KqGt47hRQ0q9Ak9uq+tAZY7KStFbZtr/1DbJuRdeTWjHxTdN?=
 =?us-ascii?Q?mjpjzWo+T50fN5pnRgvuyVkrdaCp7od+wB5V2w5/efIp0lpXA6cp/4hqx/Z6?=
 =?us-ascii?Q?C66ejp7kNqRiIvqwSirSxSvDXu1j4kIPUOPsM0a8c8ZWfj4uqWpkS2y70dLF?=
 =?us-ascii?Q?exsoCMYVJ8jQbMwhAMimOKoB8FnOg8kftSdEycrqFDY5BURryPpTJ9Lmd3x4?=
 =?us-ascii?Q?qiEQIzM2RjvaA3llqFlLvKyQawTsdwL0pAyIrl70OjIclEh9jnYp6FsOb94g?=
 =?us-ascii?Q?JyjCJbblPDqdUOEl1C9kpISRgudrqInTNe8p5PsIoFaUYBdphkqzO3X29id/?=
 =?us-ascii?Q?qhiPZK0eTM4NMUccHpFDBtt4D5eHar+E7eNaaZ/NXalqEn4IcKxwOgLEc7fu?=
 =?us-ascii?Q?TBp9OEYPM3EHBzcYLEinOi44wh8aUfa98FlXpVAVPam9ANv+8HMe+Gbwycay?=
 =?us-ascii?Q?n0gGAR3qXpOKYYmmnNqQWpQ9LK3cG0HbdRvm8H09etad8J/PcMFCpwMNgs8H?=
 =?us-ascii?Q?O5DLOQxabxaOft6Bq9vcqpGaXCv76KomP9NfPJolMC5w2lR8duFrVQdQt/fQ?=
 =?us-ascii?Q?pGNVPvoPzNw4LQrO7+sVr8ULbrxP+WTlk9FI/MCVs+ySItUM1qiJI5UwUj/n?=
 =?us-ascii?Q?yM/j/vBZVia906jXbXVmvzaFyl3WlgVWwj99xnh7TgvLszY2WuqvaPpDwD7J?=
 =?us-ascii?Q?GRD5Y90K3lX5D6NXOKQ8aEYr?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b2687b-24f5-49ac-c431-08d931a95496
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:39.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix+AUs24Vuv5vMmEQMyH6MipXpPA1O0XP6Yho1wLhR24VFsifu4+16Vm8dfdNSdaEOgyjr72obY8lwJ6vDGQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/afe.c | 737 +++++++++++++++++++++++++
 1 file changed, 737 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/afe.c

diff --git a/drivers/net/wireless/celeno/cl8k/afe.c b/drivers/net/wireless/=
celeno/cl8k/afe.c
new file mode 100644
index 000000000000..ce846396ac0f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/afe.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "afe.h"
+#include "reg/reg_ricu.h"
+#include "reg/reg_io_ctrl.h"
+#include "fem.h"
+
+/*
+ * The configuration below supports:
+ * CL8080: 4 + 4 (chains 0-3 @ TCV0 and chains 0-3 @ TCV1)
+ * CL8060: 4 + 2 (chains 0-3 @ TCV0 and chains 2-3 @ TCV1)
+ * CL8064: 4 + 2 (chains 0-3 @ TCV0 and chains 2-3 @ TCV1)
+ * CL8040: 2 + 2 (chains 0-1 @ TCV0 and chains 2-3 @ TCV1)
+ * CL8046: 4 + 0 (chains 0-3 @ TCV0)
+ */
+
+#define RICU_AFE_CTL_9_EN_DAC_REF_CL808X \
+       (RICU_AFE_CTL_9_EN_DAC_REF_0_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_1_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_2_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_3_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_4_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_5_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_6_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_7_BIT)
+
+#define RICU_AFE_CTL_9_EN_DAC_REF_CL806X \
+       (RICU_AFE_CTL_9_EN_DAC_REF_0_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_1_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_2_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_3_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_4_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_5_BIT)
+
+#define RICU_AFE_CTL_9_EN_DAC_REF_CL8046 \
+       (RICU_AFE_CTL_9_EN_DAC_REF_0_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_1_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_2_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_3_BIT)
+
+#define RICU_AFE_CTL_9_EN_DAC_REF_CL8040 \
+       (RICU_AFE_CTL_9_EN_DAC_REF_0_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_1_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_4_BIT | \
+        RICU_AFE_CTL_9_EN_DAC_REF_5_BIT)
+
+#define RICU_AFE_CTL_8_EN_BGR_CL808X \
+       (RICU_AFE_CTL_8_EN_BGR_0_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_1_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_2_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_3_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_4_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_5_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_6_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_7_BIT)
+
+#define RICU_AFE_CTL_8_EN_BGR_CL806X \
+       (RICU_AFE_CTL_8_EN_BGR_0_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_1_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_2_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_3_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_4_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_5_BIT)
+
+#define RICU_AFE_CTL_8_EN_BGR_CL8046 \
+       (RICU_AFE_CTL_8_EN_BGR_0_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_1_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_2_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_3_BIT)
+
+#define RICU_AFE_CTL_8_EN_BGR_CL8040 \
+       (RICU_AFE_CTL_8_EN_BGR_0_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_1_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_4_BIT | \
+        RICU_AFE_CTL_8_EN_BGR_5_BIT)
+
+#define RICU_AFE_CTL_8_EN_REF_CL808X \
+       (RICU_AFE_CTL_8_EN_REF_0_BIT | \
+        RICU_AFE_CTL_8_EN_REF_1_BIT | \
+        RICU_AFE_CTL_8_EN_REF_2_BIT | \
+        RICU_AFE_CTL_8_EN_REF_3_BIT | \
+        RICU_AFE_CTL_8_EN_REF_4_BIT | \
+        RICU_AFE_CTL_8_EN_REF_5_BIT | \
+        RICU_AFE_CTL_8_EN_REF_6_BIT | \
+        RICU_AFE_CTL_8_EN_REF_7_BIT)
+
+#define RICU_AFE_CTL_8_EN_REF_CL806X \
+       (RICU_AFE_CTL_8_EN_REF_0_BIT | \
+        RICU_AFE_CTL_8_EN_REF_1_BIT | \
+        RICU_AFE_CTL_8_EN_REF_2_BIT | \
+        RICU_AFE_CTL_8_EN_REF_3_BIT | \
+        RICU_AFE_CTL_8_EN_REF_4_BIT | \
+        RICU_AFE_CTL_8_EN_REF_5_BIT)
+
+#define RICU_AFE_CTL_8_EN_REF_CL8046 \
+       (RICU_AFE_CTL_8_EN_REF_0_BIT | \
+        RICU_AFE_CTL_8_EN_REF_1_BIT | \
+        RICU_AFE_CTL_8_EN_REF_2_BIT | \
+        RICU_AFE_CTL_8_EN_REF_3_BIT)
+
+#define RICU_AFE_CTL_8_EN_REF_CL8040 \
+       (RICU_AFE_CTL_8_EN_REF_0_BIT | \
+        RICU_AFE_CTL_8_EN_REF_1_BIT | \
+        RICU_AFE_CTL_8_EN_REF_4_BIT | \
+        RICU_AFE_CTL_8_EN_REF_5_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_0_DAC_CL808X \
+       (RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_4_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_5_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_0_DAC_CL806X \
+       (RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_0_DAC_CL8046 \
+       (RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_0_DAC_CL8040 \
+       (RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT | \
+        RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_1_DAC_CL808X \
+       (RICU_AFE_CTRL_37_PHY_1_EN_DAC_0_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_1_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_4_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_5_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_1_DAC_CL806X \
+       (RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_BIT)
+
+#define RICU_AFE_CTRL_37_PHY_1_DAC_CL804X \
+       (RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_BIT | \
+        RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_BIT)
+
+static void cl_afe_enable(struct cl_chip *chip)
+{
+       u32 regval;
+
+       /* Enable PLL LDO */
+       ricu_afe_ctl_1_en_pll_ldo_setf(chip, 1);
+
+       /* Enable DAC BGR & reference */
+       regval =3D ricu_afe_ctl_9_get(chip);
+       if (cl_chip_is_8ant(chip))
+               regval |=3D RICU_AFE_CTL_9_EN_DAC_REF_CL808X;
+       else if (cl_chip_is_6ant(chip))
+               regval |=3D RICU_AFE_CTL_9_EN_DAC_REF_CL806X;
+       else if (cl_chip_is_6g(chip))
+               regval |=3D RICU_AFE_CTL_9_EN_DAC_REF_CL8046;
+       else
+               regval |=3D RICU_AFE_CTL_9_EN_DAC_REF_CL8040;
+       ricu_afe_ctl_9_set(chip, regval);
+
+       /* Enable ADC BGR & Reference */
+       regval =3D ricu_afe_ctl_8_get(chip);
+       if (cl_chip_is_8ant(chip)) {
+               regval |=3D RICU_AFE_CTL_8_EN_BGR_CL808X;
+               regval |=3D RICU_AFE_CTL_8_EN_REF_CL808X;
+       } else if (cl_chip_is_6ant(chip)) {
+               regval |=3D RICU_AFE_CTL_8_EN_BGR_CL806X;
+               regval |=3D RICU_AFE_CTL_8_EN_REF_CL806X;
+       } else if (cl_chip_is_6g(chip)) {
+               regval |=3D RICU_AFE_CTL_8_EN_BGR_CL8046;
+               regval |=3D RICU_AFE_CTL_8_EN_REF_CL8046;
+       } else {
+               regval |=3D RICU_AFE_CTL_8_EN_BGR_CL8040;
+               regval |=3D RICU_AFE_CTL_8_EN_REF_CL8040;
+       }
+       ricu_afe_ctl_8_set(chip, regval);
+
+       /* Enable Embedded LDO */
+       regval =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       regval |=3D (RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_BIT |
+                  RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                  RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_BIT);
+       ricu_afe_ctrl_36_phy_0_set(chip, regval);
+
+       regval =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       regval |=3D (RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_BIT |
+                  RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                  RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_BIT);
+       ricu_afe_ctrl_36_phy_1_set(chip, regval);
+
+       /* Wait 2 us PLL LDO settling time */
+       udelay(2);
+
+       /* Enable the LC oscillator of the LCPLL */
+       ricu_afe_ctl_2_lock_con_rev_lc_setf(chip, 1);
+       /* Enable the LC PBIAS of the LCPLL */
+       ricu_afe_ctl_0_pbias_ctrl_en_lc_setf(chip, 1);
+
+       /* Wait 1 us */
+       udelay(1);
+
+       /* Power up control for LCPLL */
+       ricu_afe_ctl_1_resetb_lc_setf(chip, 1);
+
+       /* Wait 1 us */
+       udelay(1);
+
+       /* Enable DAC & ADC cores */
+       if (cl_chip_is_8ant(chip))
+               ricu_afe_ctrl_37_phy_0_set(chip, RICU_AFE_CTRL_37_PHY_0_DAC=
_CL808X);
+       else if (cl_chip_is_6ant(chip))
+               ricu_afe_ctrl_37_phy_0_set(chip, RICU_AFE_CTRL_37_PHY_0_DAC=
_CL806X);
+       else if (cl_chip_is_6g(chip))
+               ricu_afe_ctrl_37_phy_0_set(chip, RICU_AFE_CTRL_37_PHY_0_DAC=
_CL8046);
+       else
+               ricu_afe_ctrl_37_phy_0_set(chip, RICU_AFE_CTRL_37_PHY_0_DAC=
_CL8040);
+
+       if (cl_chip_is_8ant(chip))
+               ricu_afe_ctrl_37_phy_1_set(chip, RICU_AFE_CTRL_37_PHY_1_DAC=
_CL808X);
+       else if (cl_chip_is_6ant(chip))
+               ricu_afe_ctrl_37_phy_1_set(chip, RICU_AFE_CTRL_37_PHY_1_DAC=
_CL806X);
+       else
+               ricu_afe_ctrl_37_phy_1_set(chip, RICU_AFE_CTRL_37_PHY_1_DAC=
_CL804X);
+
+       /* Enable DAC & ADC cores */
+       regval =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       regval |=3D (RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT |
+                  RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_0_set(chip, regval);
+
+       regval =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       regval |=3D (RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT |
+                  RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_1_set(chip, regval);
+
+       /* Wait 2us */
+       udelay(2);
+
+       /* Enable Main & 2nd CDB clock generators */
+       ricu_afe_ctl_0_cdb_clk_resetb_setf(chip, 1);
+}
+
+static void cl_afe_disable(struct cl_chip *chip)
+{
+       u32 regval;
+
+       /* Power down control for LCPLL */
+       ricu_afe_ctl_1_resetb_lc_setf(chip, 0);
+       /* Disable PLL LDO */
+       ricu_afe_ctl_1_en_pll_ldo_setf(chip, 0);
+       /* Disable the LC oscillator of the LCPLL */
+       ricu_afe_ctl_2_lock_con_rev_lc_setf(chip, 0);
+       /* Disable the LC PBIAS of the LCPLL */
+       ricu_afe_ctl_0_pbias_ctrl_en_lc_setf(chip, 0);
+
+       /* Disable DAC BGR & reference */
+       regval =3D ricu_afe_ctl_9_get(chip);
+       if (cl_chip_is_8ant(chip))
+               regval &=3D ~RICU_AFE_CTL_9_EN_DAC_REF_CL808X;
+       else if (cl_chip_is_6ant(chip))
+               regval &=3D ~RICU_AFE_CTL_9_EN_DAC_REF_CL806X;
+       else if (cl_chip_is_6g(chip))
+               regval &=3D ~RICU_AFE_CTL_9_EN_DAC_REF_CL8046;
+       else
+               regval &=3D ~RICU_AFE_CTL_9_EN_DAC_REF_CL8040;
+       ricu_afe_ctl_9_set(chip, regval);
+
+       /* Disable ADC BGR & Reference */
+       regval =3D ricu_afe_ctl_8_get(chip);
+       if (cl_chip_is_8ant(chip)) {
+               regval &=3D ~RICU_AFE_CTL_8_EN_BGR_CL808X;
+               regval &=3D ~RICU_AFE_CTL_8_EN_REF_CL808X;
+       } else if (cl_chip_is_6ant(chip)) {
+               regval &=3D ~RICU_AFE_CTL_8_EN_BGR_CL806X;
+               regval &=3D ~RICU_AFE_CTL_8_EN_REF_CL806X;
+       } else if (cl_chip_is_6g(chip)) {
+               regval &=3D ~RICU_AFE_CTL_8_EN_BGR_CL8046;
+               regval &=3D ~RICU_AFE_CTL_8_EN_REF_CL8046;
+       } else {
+               regval &=3D ~RICU_AFE_CTL_8_EN_BGR_CL8040;
+               regval &=3D ~RICU_AFE_CTL_8_EN_REF_CL8040;
+       }
+       ricu_afe_ctl_8_set(chip, regval);
+
+       /* Disable Embedded LDO */
+       regval =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_BIT |
+                   RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_BIT);
+       ricu_afe_ctrl_36_phy_0_set(chip, regval);
+
+       regval =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_BIT |
+                   RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_BIT);
+       ricu_afe_ctrl_36_phy_1_set(chip, regval);
+
+       /* Disable DAC & ADC cores */
+       ricu_afe_ctrl_37_phy_0_set(chip, 0);
+       ricu_afe_ctrl_37_phy_1_set(chip, 0);
+
+       /* Disable DAC & ADC cores */
+       regval =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_0_set(chip, regval);
+
+       regval =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_1_set(chip, regval);
+
+       /* Disable Main & 2nd CDB clock generators */
+       ricu_afe_ctl_0_cdb_clk_resetb_setf(chip, 0);
+}
+
+static void cl_io_ctrl_config(struct cl_chip *chip)
+{
+       io_ctrl_fastwr_0_set(chip, 0x2338);
+       io_ctrl_fastwr_1_set(chip, 0x2338);
+       io_ctrl_fastwr_2_set(chip, 0x2338);
+       io_ctrl_fastwr_3_set(chip, 0x2338);
+       io_ctrl_fastwr_4_set(chip, 0x2338);
+       io_ctrl_fastwr_5_set(chip, 0x2338);
+       io_ctrl_fastwr_6_set(chip, 0x2338);
+       io_ctrl_fastwr_7_set(chip, 0x2338);
+       io_ctrl_fwr_en_1_set(chip, 0x338);
+       io_ctrl_spiclk_set(chip, 0x308);
+}
+
+static int cl_adc_sampling_cfg_tcv0(struct cl_chip *chip, u16 adc_sampling=
_clk)
+{
+       switch (adc_sampling_clk) {
+       case 40:
+               ricu_afe_ctrl_43_freq_sel_setf(chip, 0x0);
+               /* Configure ADC sampling for primary chains */
+               ricu_afe_ctl_25_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_26_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_27_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_33_pack(chip, 0x1, 0x3D, 0x3D);
+               break;
+       case 80:
+               ricu_afe_ctrl_43_freq_sel_setf(chip, 0x1);
+               /* Configure ADC sampling for primary chains */
+               ricu_afe_ctl_25_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_26_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_27_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctl_33_pack(chip, 0x1, 0x3D, 0x3D);
+               break;
+       case 160:
+               ricu_afe_ctrl_43_freq_sel_setf(chip, 0x2);
+               /* Configure ADC sampling for primary chains */
+               ricu_afe_ctl_25_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_26_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_27_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_33_pack(chip, 0x0, 0x7, 0x7);
+               break;
+       case 320:
+               ricu_afe_ctrl_43_freq_sel_setf(chip, 0x3);
+               /* Configure ADC sampling for primary chains */
+               ricu_afe_ctl_25_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_26_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_27_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctl_33_pack(chip, 0x0, 0x7, 0x7);
+               break;
+       default:
+               CL_DBG_ERROR_CHIP(chip, "Invalid adc_sampling_clk %u\n", ad=
c_sampling_clk);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int cl_adc_sampling_cfg_tcv1(struct cl_chip *chip, u32 adc_sampling=
_clk)
+{
+       switch (adc_sampling_clk) {
+       case 40:
+               ricu_afe_ctrl_44_cdb_freq_sel_setf(chip, 0x0);
+               /* Configure ADC sampling for secondary chains */
+               ricu_afe_ctrl_39_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_40_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_41_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_42_pack(chip, 0x1, 0x3D, 0x3D);
+               break;
+       case 80:
+               ricu_afe_ctrl_44_cdb_freq_sel_setf(chip, 0x1);
+               /* Configure ADC sampling for secondary chains */
+               ricu_afe_ctrl_39_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_40_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_41_pack(chip, 0x1, 0x3D, 0x3D);
+               ricu_afe_ctrl_42_pack(chip, 0x1, 0x3D, 0x3D);
+               break;
+       case 160:
+               ricu_afe_ctrl_44_cdb_freq_sel_setf(chip, 0x2);
+               /* Configure ADC sampling for secondary chains */
+               ricu_afe_ctrl_39_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_40_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_41_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_42_pack(chip, 0x0, 0x7, 0x7);
+               break;
+       case 320:
+               ricu_afe_ctrl_44_cdb_freq_sel_setf(chip, 0x3);
+               /* Configure ADC sampling for secondary chains */
+               ricu_afe_ctrl_39_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_40_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_41_pack(chip, 0x0, 0x7, 0x7);
+               ricu_afe_ctrl_42_pack(chip, 0x0, 0x7, 0x7);
+               break;
+       default:
+               CL_DBG_ERROR_CHIP(chip, "Invalid adc_sampling_clk %u\n", ad=
c_sampling_clk);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int cl_afe_adc_and_dac_cfg(struct cl_chip *chip)
+{
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       u16 bw_tcv0 =3D cl_hw_tcv0->conf->ce_channel_bandwidth;
+       u16 bw_tcv1 =3D cl_hw_tcv1->conf->ce_channel_bandwidth;
+       u16 riu_sampling_clk_tcv0 =3D cl_hw_tcv0->conf->ci_hr_factor[bw_tcv=
0] * BW_TO_MHZ(bw_tcv0);
+       u16 riu_sampling_clk_tcv1 =3D cl_hw_tcv1->conf->ci_hr_factor[bw_tcv=
1] * BW_TO_MHZ(bw_tcv1);
+       u16 adc_sampling_clk_tcv0 =3D 2 * riu_sampling_clk_tcv0;
+       u16 adc_sampling_clk_tcv1 =3D 2 * riu_sampling_clk_tcv1;
+       u8 sb_rd_delay_tcv0 =3D ((riu_sampling_clk_tcv0 =3D=3D 80) ||
+                              (riu_sampling_clk_tcv0 =3D=3D 160)) ? 4 : 2;
+       u8 sb_rd_delay_tcv1 =3D ((riu_sampling_clk_tcv1 =3D=3D 80) ||
+                              (riu_sampling_clk_tcv1 =3D=3D 160)) ? 4 : 2;
+       u32 regval;
+
+       /*
+        * For ADC sampling CLK=3D40MHz set to 0
+        * For ADC sampling CLK=3D80MHz set to 1
+        * For ADC sampling CLK=3D160MHz set to 2
+        * For ADC sampling CLK=3D320MHz set to 3
+        *
+        * The sampling clock depends on the channel_bandwidth (20/40/80/16=
0MHz)
+        * and hr_factor (1,2,4,8):
+        * ADC Sampling (MHz) =3D 2 * hr_factor * channel_bandwidth
+        *
+        * Select the external forced clock for ADC0..7:
+        * For ADC sampling CLK=3D40MHz/80MHz set to 1
+        * For ADC sampling CLK=3D160MHz/320MHz set to 0
+        * In our default case: rosel0-3 =3D 0x0; rosel4-7 =3D 0x1
+        *
+        * Internal clock frequency of ADCI0..7 I (when its ROSEL is low):
+        * For ADC sampling CLK=3D40MHz/80MHz set to 7'b011_1101
+        * For ADC sampling CLK=3D160MHz/320MHz set to 7'b000_0111
+        * In our default case: roctrli0-3 =3D 0x7; roctrli4-7 =3D 0x3D
+        *
+        * Internal clock frequency of ADCQ0..7 I (when its ROSEL is low):
+        * For ADC sampling CLK=3D40MHz/80MHz set to 7'b011_1101
+        * For ADC sampling CLK=3D160MHz/320MHz set to 7'b000_0111
+        * In our default case: roctrlq0-3 =3D 0x7; roctrlq4-7 =3D 0x3D
+        */
+
+       if (cl_adc_sampling_cfg_tcv0(chip, adc_sampling_clk_tcv0))
+               return -1;
+       if (cl_adc_sampling_cfg_tcv1(chip, adc_sampling_clk_tcv1))
+               return -1;
+
+       /* AFE_CTL_0 - AUX ADC for debug + for second band */
+       regval =3D ricu_afe_ctl_0_get(chip);
+       if (cl_chip_is_4ant(chip) && cl_chip_is_6g(chip))
+               regval |=3D (RICU_AFE_CTL_0_EN_GPADC_CLK_BIT |
+                          RICU_AFE_CTL_0_EN_GPADC_BIT);
+       else
+               regval |=3D (RICU_AFE_CTL_0_EN_CDB_DAC_CLK_BIT |
+                          RICU_AFE_CTL_0_EN_CDB_ADC_CLK_BIT |
+                          RICU_AFE_CTL_0_EN_CDB_GEN_BIT |
+                          RICU_AFE_CTL_0_EN_GPADC_CLK_BIT |
+                          RICU_AFE_CTL_0_EN_GPADC_BIT);
+       ricu_afe_ctl_0_set(chip, regval);
+
+       ricu_afe_ctl_3_cml_sel_setf(chip, 7);
+
+       /* VC_LD_AVDI0..7 =3D 0x1 */
+       ricu_afe_ctl_23_set(chip, 0x55555555);
+       /* VC_LD_AVDQ0..7 =3D 0x1 */
+       ricu_afe_ctl_24_set(chip, 0x55555555);
+       /* EN_BGR0..7 =3D 0x1, CH_CML_SEL0..7 =3D 0x1, EN_EXT_LOAD0..7 =3D =
0x0, EN_REF0..7 =3D 0x1 */
+       ricu_afe_ctl_8_set(chip, 0xff00ffff);
+       /* VC_CML0..7_I =3D 0x0 */
+       ricu_afe_ctl_29_set(chip, 0x0);
+       /* VC_CML0..7_Q =3D 0x0 */
+       ricu_afe_ctl_30_set(chip, 0x0);
+       /* IC_REFSSF0..7 =3D 0x3, EOC_CTRL0..7 =3D 0x2 */
+       ricu_afe_ctl_12_set(chip, 0xaaaaffff);
+
+       /*
+        * Set channels to Transceiver0 (phy0) or Transceiver1 (phy1):
+        * 6'b11_0000 (Transceiver1 @CH7~6, Transceiver0 @CH5~0)
+        * 6'b11_1000 (Transceiver1 @CH7~5, Transceiver0 @CH4~0)
+        * 6'b11_1100 (Transceiver1 @CH7~4, Transceiver0 @CH3~0)
+        * 6'b11_1110 (Transceiver1 @CH7~3, Transceiver0 @CH3~0)
+        * 6'b11_1111 (Transceiver1 @CH7~2, Transceiver0 @CH2~0)
+        * In our default case: mainsel72 =3D 0x3C
+        */
+       ricu_afe_ctl_5_main_sel_7_2_setf(chip, 0x3C);
+
+       /*
+        * Set 1 - b0 to MINV0/1/2/3/4/5/6/7 (DAC)
+        * Set 1 - b1 to TWOS0/1/2/3/4/5/6/7 (ADC)
+        */
+       ricu_afe_ctl_10_set(chip, 0x00FF0000);
+
+       /* Set VC_REF0/1/2/../7 */
+       ricu_afe_ctl_17_set(chip, 0x77777777);
+
+       /* Set COMP_CTRL0/1/2/.../7[3:0] to 4'b1010 for normal mode */
+       ricu_afe_ctl_19_set(chip, 0xAAAAAAAA);
+
+       /*
+        * Disable DAC & ADC cores (To save power.
+        * Assuming RIU HW will control it due to HW_MODE_ADC/DAC)
+        */
+       ricu_afe_ctrl_37_phy_0_set(chip, 0);
+       ricu_afe_ctrl_37_phy_1_set(chip, 0);
+
+       regval =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_0_set(chip, regval);
+
+       regval =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       regval &=3D ~(RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT |
+                   RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT);
+       ricu_afe_ctrl_36_phy_1_set(chip, regval);
+
+       /* Sync buffer read delay, ignore fifo indication */
+       ricu_afe_ctrl_34_phy_0_adc_sb_rd_delay_setf(chip, sb_rd_delay_tcv0)=
;
+       ricu_afe_ctrl_34_phy_0_adc_sb_ignore_fifo_indication_setf(chip, 1);
+
+       ricu_afe_ctrl_34_phy_1_adc_sb_rd_delay_setf(chip, sb_rd_delay_tcv1)=
;
+       ricu_afe_ctrl_34_phy_1_adc_sb_ignore_fifo_indication_setf(chip, 1);
+
+       /* DAC - ignore fifo indication =3D true */
+       ricu_afe_ctrl_35_phy_0_dac_sb_rd_delay_setf(chip, 1);
+       ricu_afe_ctrl_35_phy_0_dac_sb_ignore_fifo_indication_setf(chip, 1);
+
+       ricu_afe_ctrl_35_phy_1_dac_sb_rd_delay_setf(chip, 1);
+       ricu_afe_ctrl_35_phy_1_dac_sb_ignore_fifo_indication_setf(chip, 1);
+
+       /* Set to HW/SW control mode */
+       ricu_afe_ctrl_36_phy_0_hw_mode_adc_setf(chip, 1);
+       ricu_afe_ctrl_36_phy_0_hw_mode_dac_setf(chip, 1);
+
+       ricu_afe_ctrl_36_phy_1_hw_mode_adc_setf(chip, 1);
+       ricu_afe_ctrl_36_phy_1_hw_mode_dac_setf(chip, 1);
+
+       return 0;
+}
+
+static int cl_afe_set_cdb_mode(struct cl_chip *chip)
+{
+       /* Configure number of RF chains per PHY */
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       u8 ant_tcv0 =3D cl_hw_tcv0->num_antennas;
+       u8 ant_tcv1 =3D cl_hw_tcv1 ? cl_hw_tcv1->num_antennas : (chip->max_=
antennas - ant_tcv0);
+       u8 ant_total =3D ant_tcv0 + ant_tcv1;
+
+       if (!cl_chip_is_8ant(chip)) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x4);
+               return 0;
+       }
+
+       if (ant_total < MAX_ANTENNAS_CHIP) {
+               if (ant_tcv0 <=3D 4 && ant_tcv1 <=3D 4) {
+                       ant_tcv0 =3D 4;
+                       ant_tcv1 =3D 4;
+               } else {
+                       ant_tcv0 +=3D min(cl_hw_tcv0->max_antennas - cl_hw_=
tcv0->num_antennas,
+                                       chip->max_antennas - ant_total);
+
+                       if (cl_hw_tcv1) {
+                               ant_total =3D ant_tcv0 + ant_tcv1;
+                               ant_tcv1 +=3D min(cl_hw_tcv1->max_antennas =
- cl_hw_tcv1->num_antennas,
+                                               chip->max_antennas - ant_to=
tal);
+                       } else {
+                               ant_tcv1 =3D MAX_ANTENNAS_CHIP - ant_tcv0;
+                       }
+               }
+       }
+
+       if (ant_tcv0 =3D=3D 6 && ant_tcv1 =3D=3D 2) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x2);
+       } else if (ant_tcv0 =3D=3D 5 && ant_tcv1 =3D=3D 3) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x3);
+       } else if (ant_tcv0 =3D=3D 4 && ant_tcv1 =3D=3D 4) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x4);
+       } else if (ant_tcv0 =3D=3D 3 && ant_tcv1 =3D=3D 5) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x5);
+       } else if (ant_tcv0 =3D=3D 2 && ant_tcv1 =3D=3D 6) {
+               ricu_static_conf_0_cdb_mode_maj_setf(chip, 0x6);
+       } else {
+               CL_DBG_ERROR_CHIP(chip, "Invalid antenna configuration (tcv=
0 %u) (tcv1 %u)\n",
+                                 ant_tcv0, ant_tcv1);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int cl_afe_phy_type_and_rf_chains(struct cl_chip *chip)
+{
+       ricu_spi_clk_ctrl_set(chip, 0x1c); /* SPI clock bitmap */
+       ricu_static_conf_0_btc_sel_setf(chip, 0); /* Clear BTC select */
+
+       if (cl_afe_set_cdb_mode(chip))
+               return -1;
+
+       if (cl_chip_is_8ant(chip))
+               ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(chip, U8_MAX);
+       else if (cl_chip_is_6ant(chip))
+               ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(chip, 0x3f);
+       else if (cl_chip_is_6g(chip))
+               ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(chip, 0x0f);
+       else
+               ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(chip, 0x33);
+
+       /* Reset RFIC */
+       ricu_static_conf_0_rf_rst_n_req_setf(chip, 0x1);
+
+       return 0;
+}
+
+int cl_afe_cfg(struct cl_chip *chip)
+{
+       /* 1. Define PHY Type & RF Chains per band */
+       if (cl_afe_phy_type_and_rf_chains(chip))
+               return -1;
+
+       /* 2. AFE Disable */
+       cl_afe_disable(chip);
+
+       /* Wait 2us for AFE LDO settling time */
+       udelay(2);
+
+       /* 3. AFE Enable */
+       cl_afe_enable(chip);
+
+       /* 4. ADC & DAC Configuration */
+       cl_afe_adc_and_dac_cfg(chip);
+
+       cl_io_ctrl_config(chip);
+
+       /* 5. FEM Configuration */
+       cl_fem_update_conf_params(chip);
+
+       return 0;
+}
+
+void cl_afe_cfg_calib(struct cl_chip *chip)
+{
+       struct cl_afe_reg *orig_afe_reg =3D &chip->orig_afe_reg;
+       u32 reg_phy0, reg_phy1;
+
+       orig_afe_reg->ctrl36_phy0 =3D ricu_afe_ctrl_36_phy_0_get(chip);
+       orig_afe_reg->ctrl36_phy1 =3D ricu_afe_ctrl_36_phy_1_get(chip);
+       orig_afe_reg->ctrl37_phy0 =3D ricu_afe_ctrl_37_phy_0_get(chip);
+       orig_afe_reg->ctrl37_phy1 =3D ricu_afe_ctrl_37_phy_1_get(chip);
+
+       reg_phy0 =3D orig_afe_reg->ctrl36_phy0;
+       reg_phy0 |=3D (RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT |
+                    RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT |
+                    RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_BIT |
+                    RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                    RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_BIT); /* =
Enable ADC cores */
+       reg_phy0 &=3D ~(RICU_AFE_CTRL_36_PHY_0_HW_MODE_ADC_BIT |
+                     RICU_AFE_CTRL_36_PHY_0_HW_MODE_DAC_BIT); /* Set to SW=
 control mode */
+       ricu_afe_ctrl_36_phy_0_set(chip, reg_phy0);
+
+       cl_dbg_chip_trace(chip, "Setting: RICU_AFE_CTRL_36_PHY_0 =3D 0x%x\n=
", reg_phy0);
+
+       reg_phy1 =3D orig_afe_reg->ctrl36_phy1;
+       reg_phy1 |=3D (RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT |
+                    RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT |
+                    RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_BIT |
+                    RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_BIT |
+                    RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_BIT);
+       reg_phy1 &=3D ~(RICU_AFE_CTRL_36_PHY_1_HW_MODE_ADC_BIT |
+                     RICU_AFE_CTRL_36_PHY_1_HW_MODE_DAC_BIT); /* Set to SW=
 control mode */
+       ricu_afe_ctrl_36_phy_1_set(chip, reg_phy1);
+
+       cl_dbg_chip_trace(chip, "Setting: RICU_AFE_CTRL_36_PHY_1 =3D 0x%x\n=
", reg_phy1);
+
+       /* Enable DAC cores */
+       if (cl_chip_is_8ant(chip)) {
+               reg_phy0 =3D RICU_AFE_CTRL_37_PHY_0_DAC_CL808X;
+               reg_phy1 =3D RICU_AFE_CTRL_37_PHY_1_DAC_CL808X;
+       } else if (cl_chip_is_6ant(chip)) {
+               reg_phy0 =3D RICU_AFE_CTRL_37_PHY_0_DAC_CL806X;
+               reg_phy1 =3D RICU_AFE_CTRL_37_PHY_1_DAC_CL806X;
+       } else if (cl_chip_is_6g(chip)) {
+               reg_phy0 =3D RICU_AFE_CTRL_37_PHY_0_DAC_CL8046;
+               reg_phy1 =3D RICU_AFE_CTRL_37_PHY_1_DAC_CL804X;
+       } else {
+               reg_phy0 =3D RICU_AFE_CTRL_37_PHY_0_DAC_CL8040;
+               reg_phy1 =3D RICU_AFE_CTRL_37_PHY_1_DAC_CL804X;
+       }
+
+       ricu_afe_ctrl_37_phy_0_set(chip, reg_phy0);
+       cl_dbg_chip_trace(chip, "Setting: RICU_AFE_CTRL_37_PHY_0 =3D 0x%x\n=
", reg_phy0);
+
+       ricu_afe_ctrl_37_phy_1_set(chip, reg_phy1);
+       cl_dbg_chip_trace(chip, "Setting: RICU_AFE_CTRL_37_PHY_1 =3D 0x%x\n=
", reg_phy1);
+}
+
+void cl_afe_cfg_restore(struct cl_chip *chip)
+{
+       struct cl_afe_reg *orig_afe_reg =3D &chip->orig_afe_reg;
+
+       ricu_afe_ctrl_36_phy_0_set(chip, orig_afe_reg->ctrl36_phy0);
+       cl_dbg_chip_trace(chip, "Restoring: RICU_AFE_CTRL_36_PHY_0 =3D 0x%x=
\n",
+                         orig_afe_reg->ctrl36_phy0);
+
+       ricu_afe_ctrl_36_phy_1_set(chip, orig_afe_reg->ctrl36_phy1);
+       cl_dbg_chip_trace(chip, "Restoring: RICU_AFE_CTRL_36_PHY_1 =3D 0x%x=
\n",
+                         orig_afe_reg->ctrl36_phy1);
+
+       ricu_afe_ctrl_37_phy_0_set(chip, orig_afe_reg->ctrl37_phy0);
+       cl_dbg_chip_trace(chip, "Restoring: RICU_AFE_CTRL_37_PHY_0 =3D 0x%x=
\n",
+                         orig_afe_reg->ctrl37_phy0);
+
+       ricu_afe_ctrl_37_phy_1_set(chip, orig_afe_reg->ctrl37_phy1);
+       cl_dbg_chip_trace(chip, "Restoring: RICU_AFE_CTRL_37_PHY_1 =3D 0x%x=
\n",
+                         orig_afe_reg->ctrl37_phy1);
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

