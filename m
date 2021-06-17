Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD33AB82C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhFQQFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:23 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233564AbhFQQFI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCqUAZB2nYhjDhd/mpHJuFH4PlEJdHoVvvvOoNcnYSiwI0/MwE0GLjdf9bwf/DeuKstoOjw/ujC+djYaanSJGav7xrpWrSvpfXauw2a5SbX+0+/eW1a2eXsK+OHfXE9pGOiDDSlxDXevnx3wWd1fduyanaFQCwqwS2o9HGUYBtTEcEVWqafF0BrLKXG8ZecfPkB4AQvQC0dxZXfWB2yTJyBjA+JQvLEDTApsat1+oUYmwWZJ3It1OAYbVsqBH6yn5kXXBACuH2lkDkdlZH7ebqKLTPo1J9XhWaWD7/YtnDSG1WsLNwy0rwt8pq9HR/mjlWPqU7FZ6x4RcgrBgCyNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiRC678BjAczn1hdjKpfqgh6ZOCFwotvojTG90+aLFU=;
 b=WB9NY5lfumvc99JpN4YdIZRTAeYOI6Y4cZfJiC6f5pEpbdQffGlW2xhUAYeGbFkmi3vwOGyAIdAHtpUAbee3PBHgcSK2gWGG4xGax08vKWtRwg051zRhZ9PnnUVkP1RrKPDkJ1j6EpaTVuBjhcYRxRyz2UaPw1td2+efDAn3IYsfgZr5wKi/1mgWq5N/nRcnahwHM/5trCbtRiCXkERDl6+6BqBP2Chf/rxEfvjOyMl6tqxZjFeh4Jklo+EytvnihX6tFByx4f2rXF7OlNUjsjBahXoEUkB7duhPxIp6NHg6X+D8fkn+kO2LWtL/0/LM4hXvJwaEC20VvnEuZZDQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiRC678BjAczn1hdjKpfqgh6ZOCFwotvojTG90+aLFU=;
 b=g0k9KdXIkV85VdfqgecjFP0YGQkgs7kPmmw+PIR925FCd40tx6ye+YB9hhpQTN3eARyGEerWX12IEYverEUtxhZsJYEl+9Aa2cB+QTdb3UGb9yQpZwmsUlE2PP1ZRwWtEQtd533Kqjl4CkKal0Om/7gDM1my8Bx3r6u/dJPz3tk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:56 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:56 +0000
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
Subject: [RFC v1 020/256] cl8k: add bus/pci/irq.h
Date:   Thu, 17 Jun 2021 15:58:27 +0000
Message-Id: <20210617160223.160998-21-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf68f951-2e19-4c89-dd19-08d931a95ec0
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499C41B0E8F770A4D7E1098F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIsqZpY3YYZ4DDrU0gs2vUxfhS1M0pF0cHKUS6iUFZK2LCKiIfZjlwqrEXwlI5j8YqFEk7N15RSI+81yC5d4288XPLI0f8t1IdIjjgiF65Xel0nn2xbTC+/Y6pgNlka5uIL9XJ+DJMqIR62SD8JbHkOO+dULuQAcHsNqAPPF0NHpnlhuYYANQe0n3dkYmEEJri7aAgGpTIcvZb42JcWuTaKC4rDEwR/vzASTa4h/3ozugMMocK0LeZZorcFWPnqpUUNojI5NKxzKd2khBi4drzyJeGuraY7xgIUIp6zVBm6Cc5ExzVKF4EINxKSJpJ+xFjAZNepr7xiWReaoMlOtvrxs+99ihpBPTZBbYApyNTRJkeBjL45p4vX9oWca2FMiIIvYQi0IBTJx2pXdLnr4o5Zpa6g518jimq+sK7cEKXwcdagjyCImRcO5rbzCV4W5q9ls6eEjgq5adauHDSD3W/cdjQTJV7cW6i/j6/auQZrkuqEwupALEtgk2UG2liu7tEHFm6CWPXLhMhpgU4QkwDOqOIpPvwogHQzVqT2FdRxWROnHgMzoB+QhUzQV07DgAmZuKP/d1J4mObL8qT0r4tfbbodOZFZNoPKHXvuC3rljj7C4JlLqeZPmclW2rwKo7mLsGE1PTS5Enf8kjXahlF4IC1CuP35LBWxrjNEgcNXs3/cUjvjhThHdYPUXDtiFj4f58SBl36JEo/FqyPyg4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FuZwCjGnK+i10ll9vgf/S7Zamx069n6YPdBbRp523SGjO4cu4ZuWQaMWrbGX?=
 =?us-ascii?Q?tY40FsOREc0p8KY7edZPuxklOhe3qiCL49wiwsK9P6iFG2pfLEDucBsLo0BT?=
 =?us-ascii?Q?O3czeyLt0XEZCbxktaSL/eS/gW9AMPHvCgWI8KzHdXP2LnZZJp7T8vWjwCgR?=
 =?us-ascii?Q?wuYteavuoD4QJIaR5Lsd5vrJOTf/amikxCmJt+aDdGxKggAB1M6Vt5RQHM3/?=
 =?us-ascii?Q?VtsKg6EsxQktRoBPbgxiH1a22mdiHnRSqwStH3N7KqD+Mha0yqqWIm4qERKv?=
 =?us-ascii?Q?YDuRMMS5GqHPN36Mq540yPJJKnrUkD1irdHPiTnk18whW3pYbTfvYo7s1Ax/?=
 =?us-ascii?Q?DCi7GlgGJg7k2+5O9cU5/ozTzqyIX2HYGYtkiRXEdXCwpcJlmCwdrx8BWvIE?=
 =?us-ascii?Q?eSuG9Xo0PHyaUvXcN6uIJHrrwxaoLATqnbCwxoQMAswry3E3ifn1bXyQYQF9?=
 =?us-ascii?Q?vm0VpWBbyUCHrCY6zD5r35t3NzKlMLSbAFhk+8MA+627tpIc825Fm8YiaA55?=
 =?us-ascii?Q?qpAv0X7TJ9sJ7gq8/z2tsFtuLq/+HyUo6sKFPBOIWrNX+zoM0n1LswPYpKRB?=
 =?us-ascii?Q?QXfndjj0nr0VI/SRRIixUaTuV0vL5Pt9YoGExJJhqBHc32Tjw5gQYAo4PkTs?=
 =?us-ascii?Q?HKpANdbl8pvBpNokC5Ji0yYbtS5kd05NS4p2HoMfV37TCSd0ZPdsLPynQdzM?=
 =?us-ascii?Q?TTnXQ5Ykdj37nuEgsbD2+u9FCZ5YQrfsoTCkROF8l9aka5wvdX2UBfgQzSCd?=
 =?us-ascii?Q?HQOvSzIs5zvT/CYqywfmpHvQrRxW8I+LtOzp9fD+OZGR9YOXU7XyeKysyO+8?=
 =?us-ascii?Q?dEw4D1nYC1Ppsbdl6G6Mz294jo+F7dzSJbTWiFtM+88aO0gT68urgLUgmDOw?=
 =?us-ascii?Q?ODsH3KHOLFR9bUaOtRw0D8jufmCA7Ltl/okd2OG7jH5XyjZSacYdnUWlYBTF?=
 =?us-ascii?Q?+D98ZzszI+igG/AsCfP9KgOVLh4eP/HZYKMwbb0jXAlU4o9pWivk5dPzZCBG?=
 =?us-ascii?Q?QwQ/3r5LXEha6/1vqPLzUyT7F+YyqiYQwKs3HaMAr0cnYQ0zuohLaTc7/1hX?=
 =?us-ascii?Q?xslncye6de52P7k7TQFZNEUcG0GluwsqZfIZjzkTPxj/oeQl+F9dBES0+unu?=
 =?us-ascii?Q?El+7ATZJcUnfQlcywgwFl8IdRccOJkG0y6y/5MnDvI9Opipm5GqL+iNFrKcS?=
 =?us-ascii?Q?3laqFP+VPlFzV8kbCgolF6ocytQN+TALPl/sIEcWIoFDS2oDidrV+zWjwG2L?=
 =?us-ascii?Q?l1TD1tICDxasWsOi7WsYNIEFCORWZrkn8sUc8dq59iNnMo7uiABvUx6G0uTT?=
 =?us-ascii?Q?plQNyN1YkxKen6jZ4nTv440c?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf68f951-2e19-4c89-dd19-08d931a95ec0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:56.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHPOhFuE++Blzh8odzhXcaXnbbcBD5CFaAsHP36iEiozDfwtqYxVkCBWWYPS1YRKQ4ih6xGGZEk4MCH87y6Cdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bus/pci/irq.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/irq.h

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/irq.h b/drivers/net/w=
ireless/celeno/cl8k/bus/pci/irq.h
new file mode 100644
index 000000000000..10fe4588c1bb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/irq.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_IRQ_H
+#define CL_IRQ_H
+
+#ifdef CONFIG_CL_PCIE
+int cl_irq_request(struct cl_chip *chip);
+void cl_irq_free(struct cl_chip *chip);
+#endif
+void cl_irq_status(struct cl_hw *cl_hw, u32 status);
+void cl_irq_enable(struct cl_hw *cl_hw, u32 value);
+void cl_irq_disable(struct cl_hw *cl_hw, u32 value);
+
+#endif /* CL_IRQ_H */
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

