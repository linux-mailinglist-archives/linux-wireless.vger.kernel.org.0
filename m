Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2475C3AB8AF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhFQQJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:50 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:3726
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233723AbhFQQIe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRgxUp24Lo7owPEZ7UqLAx2LlU8yBQbPYEn5kKCz1j4AKUO/vZYm2RwIBN6QHsidfmIxvD4/oT2xFheavxPsgKTYIuSGrz0BUnRiZwxVc53oM8y/soRLc6x5HSPyX+O6G4JoJuAXAX5663u78lWCe9XPZZgHqaapq3V1FhZfzovGWoBtKYxNmG2sPjCpvzcygyvgsn5qaZa4woPGdqHcQdnoReB0BDLYltayvB6yoV/dAE0pIJ89b+K9GuizMM6oHDoseCtNnE5BOuoueqf6pkcTlqYa+WWxlR5ABYci9/GEK7ilWZOQ/ovw9h7uE5u07xZbhGALPmqXl+il4VXpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okVMGC83JMlNvi0ZrY+C1JFYEGH8uIJFeJRTSXAWrVo=;
 b=TktUCW1FCrocnhfcVBuQQ0WqUZCciPxt+5cYVUHl7yBedZ7p4JdFOGViH1jwu7BLluWS4YwNX3xV0LvCjED6oL4wG2e8NfpNThVkl38eXwC+I79xQo9x93ALdZ3S1VCGRAU1g3ZnlmOwbOkwGEnIRj3V+WZodWXQFO0iZIyDQOT04Nbd475DYhruH6KXYEozkU7dbH6BvnFDeo3tzFuwPY/lQS2p7KKxtd13tfvmjUdByIJk2ZCEFriFFZZ6gMSxJ+/Mc4rW97pyxaI9hiQBnmoVVkcq0BcHS9r8YKTTA4kfjRhs0/mPaHjhQaMWGOGncObljMJFBwUq9plftHpSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okVMGC83JMlNvi0ZrY+C1JFYEGH8uIJFeJRTSXAWrVo=;
 b=ma3GtIpAvTInPKIcH0XFRe9JMjo7BolQBajB9estPQGaM8kqVBtFYkcYqLuHWnkZMEKQSGmFLUYH+W/lcYhMXeivFsqojhCweD2oVneAbXWCEDy8vSRzI7E/J1amgGwYI5tCWPlWmcRba6NX5CWHiGcURgX7l/CVM/EjWrh7p48=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:51 +0000
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
Subject: [RFC v1 142/256] cl8k: add radio.h
Date:   Thu, 17 Jun 2021 16:00:29 +0000
Message-Id: <20210617160223.160998-143-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c8f045-12c1-4c3f-dc6e-08d931a9af2c
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10594296197EAB0CC4C7D25FF60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmYC+w7cbTGdYOolbNz0TsJaYaJtIaUUAsiiBkQYWhwTtbs4fqIB8356H94wy/0NSdt7dDWLy52PwLjJ5T1ocGQPDV2EqjBVClYf14oqR5QsRu7dtLq1ZH6gvQ8QYQDmTKBkP1N+RXu7Rus+8Mby8mf6LZ14uvsQOo/KfcVhMLr5JtJ/NsDu4kSGsLDlY44ayg8dpcCjByZW0oXQePRSf1DGoGWf4/Vx+26BtLdCDW9x+YDspnzyJLgcueZ4AYYgQXWchBMtK99xORo5+zUNHInlEiSFww9dpRq0tTtAUG4fiJkM5BPdYxnjIMuweOhoOpR2xLZ45aGNzNFsXNxz0S+el5DrbRVS8q6u5mKXFabmQbSb73c+OOzOuGk3rY4t7Mqh5arEGzCzUykHIHUS0M68yEPlHKrjfzSPau/GUHZnIvJcr0ToMqhHKGFCkOGlcDywsNEnsEYt/B77YC7l4ns9kdQjoHiGrkvxcf/2B4zOORArqzpwxOXSoQcFx32AvFFN7VtGtPZ2TIMfrW1CX4miIZIzL8LsUh5605Dd1G9zKIVSJ5Nu/Zsb3LDwOuPGqCaFXQ8V2AsTJ6wiKde92wpPXBbXsQO7he6ffkNbTyl8mKDPZ5eIFuXGkPFuYe7/55MU7B5qA2ofukXVBHlIKn4V3ZjOZ78MbGVFax2e1CEPCIS3v9+cO2YAtWahJneagedXso4i6fO0ONJHhs5OKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOLzNU+R7fWyzk28MbaMghW7bjTVFC/02sx5OtI54ftghTfz223LB6M+HddB?=
 =?us-ascii?Q?3cdegE3GD+BiGs9OCGjeDKJ5UBFMIkvuVBJZiJepAlqcmxwhOJBISm5v21xc?=
 =?us-ascii?Q?WaDoqE5HAtNEaSe6OkxkDVCnesT3cO9DnMEq/HwNGohcqwRaGJYFjcTQP/8n?=
 =?us-ascii?Q?tgqMwK7W5HBkBDtQRY2EZ7q/Ka4OOGZoub2HIoTDbCXzgI/B9BgHSneGBdF8?=
 =?us-ascii?Q?e+IiHMBas2oLBy9IzLbktYbFF+OtMaopXmnbzE2A/OoeNMy/Eit99DhO/FU0?=
 =?us-ascii?Q?C5vO0WSUS7JaYSvitXD6ngE8rc9UowI5Ogj6KKPHt7RKCSiv2/44fDqtjo4L?=
 =?us-ascii?Q?19k4c+K5RNBKm331yRWw0awu41kWLvPrfApIIZXQzIxMxLEDDU2WZxk1YoQ6?=
 =?us-ascii?Q?HDh1gsvSJlI85Du5I+HFqR4cRkF2iE2QEbyh2D9kZNCkVr0HZp/n1b1yMC5a?=
 =?us-ascii?Q?PTRiNkYtGJ6EvCn+A4gvMkDAPpTDIKPPlZDlD1ai+PpQh039bCqZbA/eKFu2?=
 =?us-ascii?Q?yqOQ5SLCsyvSd9M0jFYK2Llel4nNi96yvTjUpeV9hTWbHId4f3t0S5w5QmCi?=
 =?us-ascii?Q?p2TM1RSbDurCq26zSElG3hH6rwX1STSRe+hq7YgJw3OOErVA00iN6b8auOkn?=
 =?us-ascii?Q?XXVdu/ZCEEAuj5U/eJjYQaalAbPqcpJopbTiGaqjN5mnUdZHPCDXRw745bCv?=
 =?us-ascii?Q?GTedVG8s0/hHkUU7UxtRl7/4Bh9hQU7gHfM9mlzHnNOjTLj9UWpBfs/uWsmo?=
 =?us-ascii?Q?Jh1nPWqzi0U3rVk/UIPWYFW6SbTaOHcSS+L8WnIzqGFPaAbHrXiStS7z2ER/?=
 =?us-ascii?Q?sfeVPmKiVEzR4SLCEbjIssextNPFiQTFsMRhugIuoKNpGhE4uwWWABvENzGX?=
 =?us-ascii?Q?FXBjNmflbwYupS09VpjYxuSieNL51Y3MyjibDxlLxFMNypDc2D39SJfLoHoy?=
 =?us-ascii?Q?SxuT8M8QAHux2nEIlX/yjeUOCuj9glG5HBxBZ4pc0aSYROquDzTzHCj21jUh?=
 =?us-ascii?Q?opGHymm9pNHzVKWpf/yVihANGcRIPigENA8ZiXl9dunG3cEQyffi+HQqWJ01?=
 =?us-ascii?Q?Xq2po/gYXxwRkY53pt9ztftDqhr6MW+4ugmUx7N8UuC3PmqGP4CzVYAfQcYN?=
 =?us-ascii?Q?bV4XFgYLqmsiRzB8/ayyfT/DD5lh01UjBdcvwCJI5gZbG0czczdStiBcvJ0q?=
 =?us-ascii?Q?SK6+dsHX7vGkTtAwRK2ESOTdIY7Oj+AqEloLT/nbAavr/2+SbTz7AZ5xv1zf?=
 =?us-ascii?Q?bcfSeMxxT9nOSGXgR/GVtcy3dcoglVNHf0h1w8BwGa1wcZvtLkon1+ymT6Ji?=
 =?us-ascii?Q?lwEOaPSlcwXhGpxSi6nsga+m?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c8f045-12c1-4c3f-dc6e-08d931a9af2c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:10.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeCvvRRsWTiNIn/9s5i8ZkKtdQWZFSKRtbdvJB9vTL7vEAEay7SZvALZviCmT64mutNEKcDaUMCS2C8qGzuLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/radio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.h

diff --git a/drivers/net/wireless/celeno/cl8k/radio.h b/drivers/net/wireles=
s/celeno/cl8k/radio.h
new file mode 100644
index 000000000000..d95a2d526d1b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/radio.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RADIO_H
+#define CL_RADIO_H
+
+#include "hw.h"
+
+#define RADIO_STATUS_OFF        0
+#define RADIO_STATUS_ON         1
+#define RADIO_STATUS_GOING_DOWN 2
+
+int cl_radio_on(struct cl_hw *cl_hw);
+void cl_radio_off_chip(struct cl_chip *chip);
+void cl_radio_on_chip(struct cl_chip *chip);
+bool cl_radio_is_off(struct cl_hw *cl_hw);
+bool cl_radio_is_on(struct cl_hw *cl_hw);
+bool cl_radio_is_going_down(struct cl_hw *cl_hw);
+int cl_radio_cli(struct cl_hw *cl_hw, bool radio_on);
+
+/* Wakes up cl_radio_off_kthread after all the stations have disconnected.=
 */
+void cl_radio_off_wake_up(struct cl_hw *cl_hw);
+
+#endif /* CL_RADIO_H */
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

