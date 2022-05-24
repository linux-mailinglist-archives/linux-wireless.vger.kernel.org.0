Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F0532976
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiEXLmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiEXLmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:42:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E8E40
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuU9eh70OS9giLWD1xDKUUxgJCTWU/i4aYo+xrLCB9E7bjeOGbmeyILOU8CeZTALacVwBBEldjFJw+Q5j2E1E1zwabpR4So4hJk0vEQyde5mYDUiuDLoAjJ+cJqFPrhVSJ56SHfqgk2uVoLcp4gCMqX3w1jI0Y8tfuEFzlnP1EZQqLgExmTV8rowxOeEVXqYRZGtwloWzpuGaqc64/4zmw92Aclxd0Q4gRcPKXeDHdaaKXt48f6yXT5mF5FvQr0Qmon92gP8oZmHykDTn1gM0riOkHZSbwuPM3fgr+BkbsMyqNIm7gVM5hSg3yvb89TQRvwF5pLK7Dg/+CtoPOQeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PXTbmhWxQv7mjh8kuNWJrgJdYxIJx6HW77pXz6jwYU=;
 b=RPgybN+Z9hNvmMmT7yVM1NNjGSWxHEpu5Xn3e8V2bffVQ+95dJ+7OTnkoLyIgWfaCGFMd5eejesPN7jgouS3OBZ2LpmbN4CFJGTiXUR+UDjPr6oA/X3UA0zymb2lXozIovkst30mH8I1eOgcVuXGUUrG9bkaxrjVCG8tvXn02wspO0DF8DtSZn8Yy3kqQngxit4trqy0PJCFNIkBcY7SFjlbqm2Q8Ysq40sAYB2YXRJ/zTvDKZkJcZAugHn+tFkmc0d9T2JY7n5BLQsTv6XB0Y4vsYoWqQHoMRdeuDZDF9u0RAr4P2g4ErmOmfNvDxWuNOMacXwGUxoYkuFLzwQZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PXTbmhWxQv7mjh8kuNWJrgJdYxIJx6HW77pXz6jwYU=;
 b=FZzwXyVfOz/XNBRV9cF9LGqNczIH5Ul9ebs5ilMwNpJOPOruQ5ARWojeV7r7D8s27Ka03gedmB4dt7DxCHQMtNQL7Tnaygi17HPseb/kUZx4+fhlEYU8av9nhrWR58mh/uk31PCF6ULsxz9wb0nJnZfkTxl0ymx+IyOoCFloXzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:35 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 90/96] cl8k: add vif.c
Date:   Tue, 24 May 2022 14:34:56 +0300
Message-Id: <20220524113502.1094459-91-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23069032-f7a0-4314-1747-08da3d79ffad
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB066973317AEF25926D8C3CF8F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJtWpU47e4sQSHRgZ6UzQ+tGeFtQORFHHDS973227Tc2/NSOkxGw/waF9CSt170ELIPsQ9IIa7s6AqwN8pEPMld7rtO00fZUiMXMLSjDPItl432kGLxEEnTJo3FJql9APebzcz1Up7TuWVEzJ5SD0RjLPKfWn27NFcpfh2vZHV9Wf3MoJc+ZivXrt632Nl4uOOGGjmp5QkvCOznDYNCmRCWOEQd011YEyV1R6qZ6bRgfGj036ETkMvB7lojewtiEDjjeusTjFcXR+wSS8uEmKKcbCsIS+2I65s+mRLcEALHhSVazvZukKhJgeUakVI/x1JnWt6KeryXT9CvprnfZTgW/0F3XMtwy03T3Yv1KMOkbZPeZun8Eq+9W9opHB7qqMMtn7ktLKDvEWgXMq7NQEOzRn4eFl7Z3+jBN0gMJ5fclmo2o1haRfBIgeB+vnsfndtXPi/Ag7Cw9nSi6AAWSdRZkBtPODTBbl1r73vRqh0Zxpz7IJjQfAH9VIKO89RZwh6imdqtyN6UWcv/UQWkMzbLrnZlxT64TjrEVUCYt6CtTtfc4tLGcouqLUCNzGcKkm/OmO1srtAlthhldgYYZKmHX7fJ4KSQEbedWf7g0rrAsVsbbYi0bTGMTwUXtLAapNlY4r8xsixHm461NMdbp2FYB7t+c4jyEB2seEjtVpsI/OaC9jM/FSdQYfe11Wfml+NDLBhpPTs2o+MZjdwjaOGNViMInP7u8PhFGnoywxv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUFoLcq97JpYjjkYKYMmYBYmXt8gUiFTAeTP2wTpXeKKQu4fdgrpdQ1qww0F?=
 =?us-ascii?Q?MdwJnXIQ+8Fn+RbRK7mSkMdR+UztRELCufi8Udki1TGxyYYASZw8P3T2Yd5x?=
 =?us-ascii?Q?pxkTw3FE3K9bIespb4czCMfQfvVKhXUKPF5KsMt9p/roDJcWsxWEZzaQsAQ2?=
 =?us-ascii?Q?RXhTbSIYa9RDQG7I28/LSnXwmuIrVxvJPDt2A5XHWWAr7PjNJ69i5Zr5m53w?=
 =?us-ascii?Q?NlMHIeXFLOpMArK9GoNuA4GasuWfndGcZDM3dfzYq1brQ/mJNYxLiOELfO3w?=
 =?us-ascii?Q?9PcYSztJBAgNvR/escH49za5womAIExDHdvhgbIy5RA79enEjSLilD4bEk9x?=
 =?us-ascii?Q?EH8V0RpffgPjeUzzPhwy5R8KLjIpZNJgXvULctSCfINh27Ct0/TSJghxA3ue?=
 =?us-ascii?Q?ETGC6ps3LNjvZUNmOxFRm6rfs/bqFF5DO1VrjgE9oYLan1oWbNnkfCI7/9fb?=
 =?us-ascii?Q?uphYx6+fr5G7Xc87Xcg/ulEqHLe9lIY3y7rr+qo0fOIiWFBOMZy1L48bRFdb?=
 =?us-ascii?Q?/4VThOOYylZjzPnQTLaIhfYFnSf76DoZFkjRPD4HHRTABaNgEAmmNylQtH10?=
 =?us-ascii?Q?K7eqX1rW7Fu8NWjIUyQ8gS/RTnUeId/kwyNEkJwfuOAk4M1mPvwiV75Rb75L?=
 =?us-ascii?Q?34lQHU0koXQiAgNOJpjK9TZvqFxkEmAMGG2DX5NPOOWFXpkF4lxgMgAkwvdY?=
 =?us-ascii?Q?NN7J0e1Hb5tHqtrsPV2bcS0SkYuFsvBV+++zu8YD390OuCwIQu3MjQmbEIL6?=
 =?us-ascii?Q?l4/k7t89rwrpvp/R/Zc0M6yL+Ozhu9/y3gtb17Cy3KBlyvU0t7MvTZwP3LvR?=
 =?us-ascii?Q?UQHWVtuTIblpDrH754JFbWLh8LhND+/5Zps2BFKm9zm4ZtTunOTIghRdK1vl?=
 =?us-ascii?Q?GJLYEMD1801kc+iZes5J/BvM6YVAEhc9Z3TJamnkK33LfCwyrPT8vTVfm2LS?=
 =?us-ascii?Q?aeZHvseBhVbaRYHdW994WRZd4SRHmUmG7CN/8ZMf/sNWTm5qpYhSJt+PeA6i?=
 =?us-ascii?Q?qQPWk13PIhmwXTiTlXKBQoWqWiwJKQIffynHzPdN4fOqGBKacozK6U5glzM4?=
 =?us-ascii?Q?oatQJ/Fq99Qfchc34EHW94+Fg2cBLMUJKUqn2k/DrRpTa9rBqQQT2tWkwPhy?=
 =?us-ascii?Q?x3P0jCFL9WFDaAsdq7QiKbYNxauZy097I+7XaGsJdXzk5freqQGl1W1lLhvQ?=
 =?us-ascii?Q?Vve+s+s/zImpzjvuMR3HPWtdAZWMJ1F6JQjrA5nrAohN90C1K5absqPOTPaS?=
 =?us-ascii?Q?Omw8PX5oGSAFfH3fl9VckhK1NnsrAHHjj/+wyuVt3v1IiHoNEvPIL8pxwhqP?=
 =?us-ascii?Q?7oqrym6gHjuKk4QKs1qhvehVjAVg9HaLYpYysKrY4EdPJgMeQ1/V1GCNPPfQ?=
 =?us-ascii?Q?d5HOZFgg6Ieyod1QR9ferp/zF+nEKSZVLTpuKuKtaNScqhXYwUGQl+fORQg+?=
 =?us-ascii?Q?/gPL3z+ouEecU94ooGNXU1d63DBUza+RJGFxSXs1l1NwFEdjlUshBDUHg1Nw?=
 =?us-ascii?Q?t0ZVjTInxX7c642M3hCMjDHVsdjjAcDivuwVaORbO3JxNuPt7krFZ9/naTQE?=
 =?us-ascii?Q?/Zm44431jjYEkDyIvFoP/Nr6xZM/9ptzRyFnditN7E9472z6oNyhg+Ze90Py?=
 =?us-ascii?Q?vppXuoGXh16+irEjqWZdMm8KZMrqw4fxf0WC74hfCl1L6ZD9u6J4GT2ZOfBL?=
 =?us-ascii?Q?3Lrq1jUuRGm9Gv/wcABGoPOGoy8ix2B09cj0JVOeeCelOEsusm0RbOx2obtB?=
 =?us-ascii?Q?UyfTD+NFlwbQHinSD8V6V0ontdluL8Q=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23069032-f7a0-4314-1747-08da3d79ffad
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:01.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx4vHKcaHMToXQa6jBmBvK4zTJd3h/b8gBVkkw1uuXtZuQFvBYuzAdSLWfkgZnFBeAxfI9Wh7OZgr0QojoWD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vif.c | 162 +++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.c

diff --git a/drivers/net/wireless/celeno/cl8k/vif.c b/drivers/net/wireless/celeno/cl8k/vif.c
new file mode 100644
index 000000000000..7592f0d32e7a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vif.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/list.h>
+
+#include "hw.h"
+#include "mac_addr.h"
+#include "vif.h"
+
+void cl_vif_init(struct cl_hw *cl_hw)
+{
+	rwlock_init(&cl_hw->vif_db.lock);
+	INIT_LIST_HEAD(&cl_hw->vif_db.head);
+}
+
+void cl_vif_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+	struct cl_vif_db *vif_db = &cl_hw->vif_db;
+
+	write_lock_bh(&vif_db->lock);
+	list_add_tail(&cl_vif->list, &vif_db->head);
+
+	if (cl_vif->vif->type != NL80211_IFTYPE_STATION)
+		vif_db->num_iface_bcn++;
+
+	/* Multicast vif set */
+	cl_hw->mc_vif = cl_vif;
+
+	write_unlock_bh(&vif_db->lock);
+}
+
+void cl_vif_remove(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+	struct cl_vif_db *vif_db = &cl_hw->vif_db;
+
+	write_lock_bh(&vif_db->lock);
+	/* Multicast vif unset */
+	if (cl_hw->mc_vif == cl_vif)
+		cl_hw->mc_vif = cl_vif_get_next(cl_hw, cl_hw->mc_vif);
+
+	list_del(&cl_vif->list);
+
+	if (cl_vif->vif->type != NL80211_IFTYPE_STATION)
+		vif_db->num_iface_bcn--;
+	write_unlock_bh(&vif_db->lock);
+
+	cl_bcmc_cfm_poll_empty_per_vif(cl_hw, cl_vif);
+}
+
+struct cl_vif *cl_vif_get_next(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+	if (list_is_last(&cl_vif->list, &cl_hw->vif_db.head))
+		return list_first_entry_or_null(&cl_hw->vif_db.head,
+						struct cl_vif, list);
+	else
+		return list_next_entry(cl_vif, list);
+}
+
+struct cl_vif *cl_vif_get_by_dev(struct cl_hw *cl_hw, struct net_device *dev)
+{
+	struct cl_vif *cl_vif = NULL, *cl_vif_ret = NULL;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+		if (cl_vif->dev == dev) {
+			cl_vif_ret = cl_vif;
+			goto unlock;
+		}
+
+unlock:
+	read_unlock_bh(&cl_hw->vif_db.lock);
+	return cl_vif_ret;
+}
+
+struct cl_vif *cl_vif_get_by_mac(struct cl_hw *cl_hw, u8 *mac_addr)
+{
+	struct cl_vif *cl_vif, *cl_vif_ret = NULL;
+
+	read_lock(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+		if (cl_mac_addr_compare(cl_vif->vif->addr, mac_addr)) {
+			cl_vif_ret = cl_vif;
+			goto unlock;
+		}
+
+unlock:
+	read_unlock(&cl_hw->vif_db.lock);
+	return cl_vif_ret;
+}
+
+struct cl_vif *cl_vif_get_first(struct cl_hw *cl_hw)
+{
+	return list_first_entry_or_null(&cl_hw->vif_db.head, struct cl_vif, list);
+}
+
+struct cl_vif *cl_vif_get_first_ap(struct cl_hw *cl_hw)
+{
+	struct cl_vif *cl_vif, *cl_vif_ret = NULL;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+		if (cl_vif->vif->type == NL80211_IFTYPE_AP ||
+		    cl_vif->vif->type == NL80211_IFTYPE_MESH_POINT ||
+		    cl_hw->conf->ce_listener_en) {
+			cl_vif_ret = cl_vif;
+			goto unlock;
+		}
+
+unlock:
+	read_unlock_bh(&cl_hw->vif_db.lock);
+	return cl_vif_ret;
+}
+
+struct net_device *cl_vif_get_first_net_device(struct cl_hw *cl_hw)
+{
+	struct cl_vif *cl_vif = NULL;
+	struct net_device *dev = NULL;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	cl_vif = list_first_entry_or_null(&cl_hw->vif_db.head, struct cl_vif, list);
+	if (cl_vif)
+		dev = cl_vif->dev;
+	read_unlock_bh(&cl_hw->vif_db.lock);
+
+	return dev;
+}
+
+struct net_device *cl_vif_get_dev_by_index(struct cl_hw *cl_hw, u8 index)
+{
+	struct cl_vif *cl_vif = NULL;
+	struct net_device *dev = NULL;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+		if (cl_vif->vif_index == index) {
+			dev = cl_vif->dev;
+			goto unlock;
+		}
+
+unlock:
+	read_unlock_bh(&cl_hw->vif_db.lock);
+	return dev;
+}
+
+void cl_vif_ap_tx_enable(struct cl_hw *cl_hw, bool enable)
+{
+	struct cl_vif *cl_vif;
+	struct ieee80211_vif *vif;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+		vif = cl_vif->vif;
+
+		if (vif->type != NL80211_IFTYPE_AP)
+			continue;
+
+		cl_vif->tx_en = enable;
+		cl_dbg_verbose(cl_hw, "Set tx_en=%u for vif_index=%u\n",
+			       enable, cl_vif->vif_index);
+	}
+	read_unlock_bh(&cl_hw->vif_db.lock);
+}
-- 
2.36.1

