Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E313AB932
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhFQQN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:26 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:39392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233814AbhFQQMH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1VLWVzhoeWXZfDleFoJs9HYYrfkED57NWuxLP1CjVybBstkYo2upqNf42+pVECqnUzmKGpp0JuGxePk1WClcBf8sEjMx/QQkrzxft3uWGXsr0eygZ6PtGocXumySJGjofUrQlzk/wr4RR8gO2D4G9pLGKVaf0dM++M3byluMRZ8CPDCXglJsLBAVODJEavW9RGSCnF4OnV5+pkM+xBaI6bS0a+v9lA9N3WVYDnX6qGxvg65m4Mko/JnxpEVti3WDT+yVzaHqHfm93QbyNQRiUq7eEzN55zV2Pc9UiGr5aXz9UiOQEv0BPNOik7GxbuIk7v6KKCgDQOsEjGtuKKpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAZ2tLeVuYa3nVzqdpOgHTzVLJ5daeSYAqj+xEflJCA=;
 b=ULcO57WA+8gg6Tf83jTZoQ/Brf11PYBUFyzbxKXtrKdorGsT1ajP3fYjEZMkB9FKlCQG2QTnu8yCak9VhiwP7j5Nneh0NZcfLvc633JZfT75lYV16GBGCXN/MpVe1GG5IyBhDqZdnFgQqba6H6dXwwGRBExLqSh4pRgtI9PqCJ2CJJFBCcPzCzcvq8wHL+YYuzsafhP/3R5IsbWkE4z9v3P+lzypty56a/ep/zAraLsqUtQE3ajj8tFxWxzu+QqJPb948iqH8e8HL17m675iCjigkkQ9qMKLwV1kMAl6ALOnUqp3ZkmxuxuSGOzIxMUUV/fQAifnaGtEk2kLgADUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAZ2tLeVuYa3nVzqdpOgHTzVLJ5daeSYAqj+xEflJCA=;
 b=Rvy18IrMUe+ux+DoCEBT4wJ1RDtlKgT556GyS4/8v0BCBDhSEbclCKJUf5i3xbeKYezT+nxUAbPCNRMst2YmZirNYE77+KmIlbeJB4WyjsIi1CCz+87j5GavZURm2rp2NEQXgwtHGB5TjkCovpv4cau+OpxAA13TvBeUlUNj8E8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:18 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:18 +0000
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
Subject: [RFC v1 206/256] cl8k: add tx/bcmc_cfm.c
Date:   Thu, 17 Jun 2021 16:01:33 +0000
Message-Id: <20210617160223.160998-207-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b16006e-d5ae-4d5c-31a6-08d931a9d9ba
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075AE1A01260137DFA2D70BF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89PDlJx5Q9E/SVy5wz6X2PrXNIBKAeSeTHyaB/rAoUMhrqQuonyRUWH5R/EAOItEqi/iDmjGXHcT+sr1oQLU1NCVZm4hw6YnuDNARUB6smKo10GbP9i4xHTuZSJ5T4C6B/dB0Bb7ptd+9kQnqFlYJmsmsVvuDhhP/hhOPJTYB/wL4ld8QYOQ7/ncMFHsr81WuGnnQrNPfxZoT7T7epSyLu8YtjPmYavkMgV0ev2lkYTB5+qP7I+askOtQDR1ddKy0d1bQylJrASNmaLu6f+ZRsX3SGDngYqbZlku5Y7MICqNqRqCSopGntsDCWyv61jkI2xV+azXCfSkC5FNDVYJgcp8aqw6hHib6nqh9F3Efobb6FhUw2Um0/UKu7sQi5TvIj5WtgOKyiwjSrXIUyWYr7dZ8hM/O3ZYr/+//T4hHVseP6EjZ77ejr3kgttTu4YtGgCLtXsUXfc+ACpucDbbw2fXX13OCyYBBFNgfhtXxrWr7WRomQOZoGXzCnmtiMLsQ1LmRcfOvtqStGe5O9waES/W86CGCidXPV3dIT+X34fzF/53LlJhrw4pJ7Iuq9e5KYuMh2yOLzBEP7ixUr4gtWMA/HRTXmwXi1jbD16p39OGOdVbLoKzlrjGNajilrHJAx2FdjNPieRMioOvtq6aGicOuLrr5GP1koejb/rjSmu+yG7MDZEQ7vnGfkaIh1ywkTBKixHoT0JASFZauye40Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1bitkcaqHgzPlflWAwottwzBduzS2MXLuHt8hlTrPDBs4+zfI9LLUE+xfb7?=
 =?us-ascii?Q?LS0uRk72i4FScz0hmUj/fXfk8RFkLnxFoKPwZqh5YV3ybfXVevF+IJAzL/wQ?=
 =?us-ascii?Q?RVOhTVfUsesynW9h89RZTNw2YD1RSqDnngI06WhSfegTqIM/5OLAFe5jn4rm?=
 =?us-ascii?Q?76y5biUToflNl7XdgDqkXj0xMUnlXU9DCMg5gaaOA7ixbiNWxp4dlWTpUTcd?=
 =?us-ascii?Q?4itouQKYKwJ8TkWTR7x1PtTX/KGeIuzVvm7U1pwKH5A6au0SSZXK2u2mbXUh?=
 =?us-ascii?Q?WfCODUd2/kIDMFI3o/ukzCKv113FK3UZtoJUPjbZmd8zDFMJnnImAqki95Tu?=
 =?us-ascii?Q?WP0Hxw2tW0KXmS7izwg8/hLZKeMhSnxisy2oXUs/uu6H8RMZY4CNYvcqiFSV?=
 =?us-ascii?Q?jpHeXE+ctuZXJQCVRwSdx2hU3su98Ni9hRbV+re9PdBeEN1I8i1v0GOFOPS3?=
 =?us-ascii?Q?Ik5lZSvazDWRDt4BHQqvpsJAkzsmZzbIf9PK846E4K0zAm34aJ5+dR5qvpK7?=
 =?us-ascii?Q?u1BAnYhj0301ekB6hH082shGAR7d+tZz9761aUME5Evp/RejK+TKSoOwWn0w?=
 =?us-ascii?Q?y6wfauHjs4+jNukzA+s0iltrJTa0tg4GRDaIh9hMtLnX3lV14GO4gz74E+HC?=
 =?us-ascii?Q?6Va9U4FH5jWJNBf84CWlzGAl6NzKCluyjhZQHVHu3ENlX+/TmYVtvs1OxUMA?=
 =?us-ascii?Q?7bL+3g7tjFyBv5IV3DgMC6r114ejmqxTW5CUZ+tfSMrERApGVTvxqDz2we0M?=
 =?us-ascii?Q?uqIzDLWLXPzRBhLnqHMxmjycsMgGoHwn91r7RJ6P7xQbKhP1SmX1uca+VXBT?=
 =?us-ascii?Q?ZgAAkxKaquCukbIA7wXHOV/GrgIJYxDWiC+WIByznZfE/kBFMjVLGKc/gqEl?=
 =?us-ascii?Q?F+1nElPfEzdjofMrKpqsfI904c2pSbS8p35FIBIDzT6iUTxfvjtgB6wWQsJ/?=
 =?us-ascii?Q?3klKlseJZISvUxu6wGuKUevSZ7ZVySqbi20mW3x6x7TYAywSd4lLYXc6eRls?=
 =?us-ascii?Q?UThFlEdwRbl0GFguW/Ixy2rwCeJAHTyxUfOyrvHP2U/+1SgS8lshJyoq/21T?=
 =?us-ascii?Q?2/bw41GKJL3b/kQxqfaeKNepMsAIE5CBIFKkO83HBlC2f3gA4NFkzAosjrMp?=
 =?us-ascii?Q?31LSo552AzpLcCOj1XBPD6a5gUMZ5TdJWuHGI0+pY2AKY9DSoWoDZTibaU17?=
 =?us-ascii?Q?6FPwBnHpPfGOg5RkMsknmElqlOZxIuVo7C77xPEnaaYxkX6b2E5wHMg2/v6A?=
 =?us-ascii?Q?NL+EQgPCCLlt5PEeB4w4P4/XK8QAzBIpttJlK0hxEh4OszTPTdzw2HOL5RFt?=
 =?us-ascii?Q?G2BYNxloUAHAAVhij4+MzBRX?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16006e-d5ae-4d5c-31a6-08d931a9d9ba
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:22.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5OrvpeD/UxeOpHA8+bUe0hImjp1UtDa3a47MKNmQyrmdBkZ7s8X2GK7NFYPjtjZnzgkw528LEBID4qLVU8Lrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/bcmc_cfm.c    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.c b/drivers/net/w=
ireless/celeno/cl8k/tx/bcmc_cfm.c
new file mode 100644
index 000000000000..bc4bbdf40f54
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/bcmc_cfm.h"
+#include "chip.h"
+#include "tx/sw_txhdr.h"
+
+/*
+ * cl_hw->bcmc_cfm_queue:
+ * This queue is used to keep pointers to already sent
+ * beacon skb's that are waiting for confirmation.
+ */
+
+void cl_bcmc_cfm_init(struct cl_hw *cl_hw)
+{
+       INIT_LIST_HEAD(&cl_hw->bcmc_cfm_queue.head);
+}
+
+void cl_bcmc_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+       list_add_tail(&sw_txhdr->cfm_list, &cl_hw->bcmc_cfm_queue.head);
+}
+
+struct cl_sw_txhdr *cl_bcmc_cfm_find(struct cl_hw *cl_hw, dma_addr_t dma_a=
ddr, bool keep_in_list)
+{
+       struct cl_single_cfm_queue *cfm_queue =3D &cl_hw->bcmc_cfm_queue;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct cl_sw_txhdr *tmp =3D NULL;
+
+       list_for_each_entry_safe(sw_txhdr, tmp, &cfm_queue->head, cfm_list)=
 {
+               if (le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]) =
=3D=3D dma_addr) {
+                       if (!keep_in_list)
+                               list_del(&sw_txhdr->cfm_list);
+
+                       return sw_txhdr;
+               }
+       }
+
+       return NULL;
+}
+
+void cl_bcmc_cfm_flush_queue(struct cl_hw *cl_hw)
+{
+       struct cl_single_cfm_queue *cfm_queue =3D &cl_hw->bcmc_cfm_queue;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_tx_info *tx_info =3D NULL;
+       dma_addr_t dma_addr;
+
+       while (!list_empty(&cfm_queue->head)) {
+               sw_txhdr =3D list_first_entry(&cfm_queue->head, struct cl_s=
w_txhdr, cfm_list);
+               dma_addr =3D le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_a=
ddr[0]);
+               skb =3D sw_txhdr->skb;
+               tx_info =3D IEEE80211_SKB_CB(skb);
+
+               dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_=
len, DMA_TO_DEVICE);
+               dev_kfree_skb_irq(skb);
+               list_del(&sw_txhdr->cfm_list);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       }
+
+       /* Set fw_free_space back to maximum after flushing the queue */
+       cl_hw->tx_queues.bcmc.fw_free_space =3D cl_hw->tx_queues.bcmc.fw_ma=
x_size;
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

