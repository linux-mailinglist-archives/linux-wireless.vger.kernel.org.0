Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624CE15AD0E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLQSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:18:02 -0500
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com ([40.107.21.40]:6071
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbgBLQSB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:18:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hst2nWiNZ++z5wGR4FcJy3p5m5TnHNidvge2Fh2zLuE1hfJZMzNMNnSuABzT02ShAolVeX2Bz9b3hbK46TrmEPUk5AxZFeTIX03Yhf8IwppITw8WJe5Mtn/LpnqJrqPYnXyBtmB2TKka66C1TAc4W6uD2pEp0IIM7jB9xfFawmaWbonEb42S7G6ZU0xXVr3EtbgCDsQRvww1CijWplE+aX+/QSqpz8tePdlnmMUvTZQ8H6pXnRZReUEuIk0mbabKSZ7VdIvdZaFfmRdK21daWB7IfLX/OXJHt8dQc0d4bG1dH9XfkOj+q2p54+2RnIeKC95EPMrY4bvQleKWYKPVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7nC2p+lBkWL6p0AKEd2/5TdVCKA+mqTP8t8cgjpstM=;
 b=AlTgGytEgvD/oEeSbJmN7+jsKVcSfd0lYqSd6wZvg1BoK1Fsj3RGYNmxGXceFZQDn9/mEfF+uXD+q6uNFGYDbck2hVdJ7MyY1DA5mJ7hicBwaiiUrsqV5tkq4/VI9TxiJfwNXg/B2HCCZvT5y9aIxAnG0rgL4BMsmaQlq6O5mVA8mhcvbyxhgHfXck/z03W5Z36kFVWsQe6/vv42WdXV1bWeT616nywmE9vXI7HpZtDLKuAUQzEuUCGaN1LIfB8GpLWqnGFt8WI5b1ZAMOzXSHM7Hv1VHc3zztZUtiClENrqtVs3RTMSA7LJiY4NiTv4QvZvnf93TN4Sw1wfQUZW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7nC2p+lBkWL6p0AKEd2/5TdVCKA+mqTP8t8cgjpstM=;
 b=MX/ziY8ZlnBd+acniQPmvciX9FEbEy26epQzzQenJK3rmNLDuqroVGq4vO9s9QIMliDOtyWMzAE7BuM1Kt0whHfqhVwtLjwYNB5lQZk9Z6Y4qVeWQkEGr1EihTDpdNo2hxptKL+YmnroE3qJyo2+FuxJ7wHqnzbouYNO8/pDQtg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4314.eurprd04.prod.outlook.com (52.135.129.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 16:17:31 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34%4]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 16:17:31 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        James Cao <zheng.cao@nxp.com>, Cathy Luo <xiaohua.luo@nxp.com>
Subject: [PATCH] mwifiex: change license text from MARVELL to NXP
Date:   Wed, 12 Feb 2020 21:47:10 +0530
Message-Id: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR0401CA0016.apcprd04.prod.outlook.com
 (2603:1096:3:1::26) To DB7PR04MB5242.eurprd04.prod.outlook.com
 (2603:10a6:10:18::25)
MIME-Version: 1.0
Received: from localhost.localdomain (115.112.95.158) by SG2PR0401CA0016.apcprd04.prod.outlook.com (2603:1096:3:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 16:17:28 +0000
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [115.112.95.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae54b70d-c531-41ea-373f-08d7afd70f8a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4314:|DB7PR04MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB43147545C8E59C5D8A8EDE378F1B0@DB7PR04MB4314.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6512007)(5660300002)(6486002)(186003)(956004)(26005)(44832011)(2616005)(30864003)(4326008)(478600001)(52116002)(16526019)(66946007)(55236004)(86362001)(6916009)(66476007)(6506007)(66556008)(6666004)(316002)(54906003)(2906002)(36756003)(8936002)(8676002)(81156014)(81166006)(2004002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4314;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WFoOjDWbsczcWnI5AzFtFUCWsMrQb0OUC5KQTaJJO0IlSp+OHU5giIJ3G0pyQ1MUIamFZ/Fz33iJZ+VP+z0tczZ2dgW5uCzA4mH2qOU4lLFZ2o/PXTMZ8Sdrg/3WEgLoclSGqYLlbJy2370x+W4rb+js8MwVWF4aNtzqVqT7K1dsYUoEzKYJB37wPX4npCPo+Zs039VDjbvQEGyNnI8Kt3N98A8gaZxYEks7Fqp3AqbSQdKC07Mi39Cpcqqzc0JYLDIxjoPiXfhS7B9JNuk36LpAFohURf2ofZmCiazNZ49ZzHM/TmKOzNxZwHpBExfeXEn20eOTve3G6Mc/PAI8WJHKMG+bA8GqfjbrmBMaKXuTo+fRhc0Fv90mqc177o3KZwuFsltB17YobYGADwf2C/2DvNQnkIYi7KS5cvxQRV/g7tXomM8DwEm1L2+Ax/KI4/uvUv1zuSOJFBP6064MyZjUJL1fDHwF/brxNEo/Vs=
X-MS-Exchange-AntiSpam-MessageData: RMf4U4RKvM7KINZMXJfECEuytYn7FTzT2z6QUaJv2r5w4pjlmTc24dsgKTL44y7DWdq5Oke1MBHDLxOfMJRKfmuxJZou/gKiD9H2Z7+Auruw+QoGdfdGG7bFhVIdzyqKtLiVZXU27CnAfDjAXprQQw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54b70d-c531-41ea-373f-08d7afd70f8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 16:17:31.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX3bjw3ikIhE9hQCZDuAh8Ay40oNynBRqMHdMJUUSrDns7OxDFENhvqNzv/gQxL0nLq8q86tXSCYGAOWrdK8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4314
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As of 6-DEC-2019, NXP has acquired Marvell’s Wireless business
unit. This change is to update the license text accordingly.

Signed-off-by: James Cao <zheng.cao@nxp.com>
Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/11ac.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11ac.h          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11h.c           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n.c           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n.h           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c      | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n_aggr.h      | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.h | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/cfg80211.h      | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/cfp.c           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/cmdevt.c        | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/debugfs.c       | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/decl.h          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/ethtool.c       | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/fw.h            | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/ie.c            | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/init.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/ioctl.h         | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/join.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/main.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/main.h          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/pcie.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/pcie.h          | 6 +++---
 drivers/net/wireless/marvell/mwifiex/scan.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sdio.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sdio.h          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c       | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c   | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_event.c     | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c     | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_rx.c        | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sta_tx.c        | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/tdls.c          | 9 +++++----
 drivers/net/wireless/marvell/mwifiex/txrx.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c       | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/uap_event.c     | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c      | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/usb.c           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/usb.h           | 6 +++---
 drivers/net/wireless/marvell/mwifiex/util.c          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/util.h          | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/wmm.c           | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/wmm.h           | 8 ++++----
 45 files changed, 179 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11ac.c b/drivers/net/wireless/marvell/mwifiex/11ac.c
index 59d23fb..756f019 100644
--- a/drivers/net/wireless/marvell/mwifiex/11ac.c
+++ b/drivers/net/wireless/marvell/mwifiex/11ac.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11ac
+ * NXP Wireless LAN device driver: 802.11ac
  *
- * Copyright (C) 2013-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11ac.h b/drivers/net/wireless/marvell/mwifiex/11ac.h
index 1ca92c7..29e8346 100644
--- a/drivers/net/wireless/marvell/mwifiex/11ac.h
+++ b/drivers/net/wireless/marvell/mwifiex/11ac.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11ac
+ * NXP Wireless LAN device driver: 802.11ac
  *
- * Copyright (C) 2013-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 238accf..d2ee646 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11h
+ * NXP Wireless LAN device driver: 802.11h
  *
- * Copyright (C) 2013-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index e435f80..6696bce 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n
+ * NXP Wireless LAN device driver: 802.11n
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.h b/drivers/net/wireless/marvell/mwifiex/11n.h
index 33268ce..83a88ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n
+ * NXP Wireless LAN device driver: 802.11n
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
index 0886124..46f41db 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n Aggregation
+ * NXP Wireless LAN device driver: 802.11n Aggregation
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.h b/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
index 8279b15..382c126 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n Aggregation
+ * NXP Wireless LAN device driver: 802.11n Aggregation
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 05a3c61..0bdafe9 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n RX Re-ordering
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.h b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.h
index 22d991f..465f244 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.h
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: 802.11n RX Re-ordering
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d896841..0a6da6f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: CFG80211
+ * NXP Wireless LAN device driver: CFG80211
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.h b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
index 9083678..530a63f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.h
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: CFG80211
+ * NXP Wireless LAN device driver: CFG80211
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index f1522fb..fb91ecf 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: Channel, Frequence and Power
+ * NXP Wireless LAN device driver: Channel, Frequence and Power
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index e8788c3..7e4b8cd 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: commands and events
+ * NXP Wireless LAN device driver: commands and events
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 8ab114c..dded92d 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: debugfs
+ * NXP Wireless LAN device driver: debugfs
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 46696ea..6bd23c9 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: generic data structures and APIs
+ * NXP Wireless LAN device driver: generic data structures and APIs
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/ethtool.c b/drivers/net/wireless/marvell/mwifiex/ethtool.c
index 58400c6..9bdad3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/ethtool.c
+++ b/drivers/net/wireless/marvell/mwifiex/ethtool.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: ethtool
+ * NXP Wireless LAN device driver: ethtool
  *
- * Copyright (C) 2013-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 1fb76d2..4dfdf92 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: Firmware specific macros & structures
+ * NXP Wireless LAN device driver: Firmware specific macros & structures
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/ie.c b/drivers/net/wireless/marvell/mwifiex/ie.c
index 580387f..811abe9 100644
--- a/drivers/net/wireless/marvell/mwifiex/ie.c
+++ b/drivers/net/wireless/marvell/mwifiex/ie.c
@@ -1,11 +1,11 @@
 /*
- * Marvell Wireless LAN device driver: management IE handling- setting and
+ * NXP Wireless LAN device driver: management IE handling- setting and
  * deleting IE.
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 1aa93e7..82d69bc 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: HW/FW Initialization
+ * NXP Wireless LAN device driver: HW/FW Initialization
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 0dd592e..3db449e 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: ioctl data structures & APIs
+ * NXP Wireless LAN device driver: ioctl data structures & APIs
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index d87aeff..5934f71 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: association and ad-hoc start/join
+ * NXP Wireless LAN device driver: association and ad-hoc start/join
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7d94695..5290991 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: major functions
+ * NXP Wireless LAN device driver: major functions
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index fa5634a..afaffc3 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: major data structures and prototypes
+ * NXP Wireless LAN device driver: major data structures and prototypes
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index fc1706d..87b4ccc 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: PCIE specific handling
+ * NXP Wireless LAN device driver: PCIE specific handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.h b/drivers/net/wireless/marvell/mwifiex/pcie.h
index f7ce9b6..fc59b52 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.h
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.h
@@ -3,10 +3,10 @@
  * @brief This file contains definitions for PCI-E interface.
  * driver.
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index a7968a8..ff932627 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: scan ioctl and command handling
+ * NXP Wireless LAN device driver: scan ioctl and command handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index fec38b6..6a2dcb0 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: SDIO specific handling
+ * NXP Wireless LAN device driver: SDIO specific handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index f672bdf..71cd862 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: SDIO specific definitions
+ * NXP Wireless LAN device driver: SDIO specific definitions
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 4ed10cf..0bd93f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: station command handling
+ * NXP Wireless LAN device driver: station command handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 20c206d..f216601 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: station command response handling
+ * NXP Wireless LAN device driver: station command response handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 5fdffb11..bc79ca4 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: station event handling
+ * NXP Wireless LAN device driver: station event handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index fbfa0b1..653f9e0 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: functions for station ioctl
+ * NXP Wireless LAN device driver: functions for station ioctl
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 52a2ce2..0d2adf8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: station RX data handling
+ * NXP Wireless LAN device driver: station RX data handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 37c24b9..2413053 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: station TX data handling
+ * NXP Wireless LAN device driver: station TX data handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index f8f282c..97bb87c 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -1,9 +1,10 @@
-/* Marvell Wireless LAN device driver: TDLS handling
+/*
+ * NXP Wireless LAN device driver: TDLS handling
  *
- * Copyright (C) 2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available on the worldwide web at
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index e3c1446..a8479b8 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: generic TX/RX data handling
+ * NXP Wireless LAN device driver: generic TX/RX data handling
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 0939a8c..b48a85d 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: AP specific command handling
+ * NXP Wireless LAN device driver: AP specific command handling
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 86bfa1b..9121447 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: AP event handling
+ * NXP Wireless LAN device driver: AP event handling
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 354b09c..77c8595 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: AP TX and RX data handling
+ * NXP Wireless LAN device driver: AP TX and RX data handling
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index c2365ee..6f3cfde 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: USB specific handling
+ * NXP Wireless LAN device driver: USB specific handling
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.h b/drivers/net/wireless/marvell/mwifiex/usb.h
index 37abd22..d822ec1 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.h
+++ b/drivers/net/wireless/marvell/mwifiex/usb.h
@@ -1,10 +1,10 @@
 /*
  * This file contains definitions for mwifiex USB interface driver.
  *
- * Copyright (C) 2012-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 3b0d318..de89a1e 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: utility functions
+ * NXP Wireless LAN device driver: utility functions
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.h b/drivers/net/wireless/marvell/mwifiex/util.h
index 7cafcec..44aa80e 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.h
+++ b/drivers/net/wireless/marvell/mwifiex/util.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: utility functions
+ * NXP Wireless LAN device driver: utility functions
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 132f9e8..a06fff1 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: WMM
+ * NXP Wireless LAN device driver: WMM
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.h b/drivers/net/wireless/marvell/mwifiex/wmm.h
index 38f0976..04d7da9 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.h
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.h
@@ -1,10 +1,10 @@
 /*
- * Marvell Wireless LAN device driver: WMM
+ * NXP Wireless LAN device driver: WMM
  *
- * Copyright (C) 2011-2014, Marvell International Ltd.
+ * Copyright 2011-2020 NXP
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * This software file (the "File") is distributed by NXP
+ * under the terms of the GNU General Public License Version 2, June 1991
  * (the "License").  You may use, redistribute and/or modify this File in
  * accordance with the terms and conditions of the License, a copy of which
  * is available by writing to the Free Software Foundation, Inc.,
-- 
1.9.1

