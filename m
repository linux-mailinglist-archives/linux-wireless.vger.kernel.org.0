Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5063AB8B3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhFQQJy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:54 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:26086
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231526AbhFQQIm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwXyoecLXHwjVMMLlrrCHcziMZothfP8gh+PNVJIWU7LT1Z7hGs9BxfpEFQt4jSULGAMQ/22iAUFgIaEQYzq3pUz+yWkBTCEYVFXRBA+u1Rj5aOU36DK3yFgIHr1BNio1uohEqx9n3HM6K3XVvMAGQM9F4EvcUboSo5oYKO9L9EnkmBH4GmhqifBccs8KCzgz1K+fqqqj5Y4/PpfwnGFQxnrS60mmVyE07LPR1eccL1bEG0IplgsLk2Z5sKfqW9OreAGrHKrxDWjSdtDeU2HmVLwXoFfTG+ZTTmCUhbXrDjZLcfb6zirJgfK0zF6sHT0joQQhVHZRHWMvodTKaQxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9bLhUvmy4T3O4X3fC6BMQKGU2auFuM+vBfOCoEwCUE=;
 b=Qyf2kv19vS0NwSeqRuGI3S5cKpPJm7KI0AajGnsMkj7w1ChKiZixopJTJ0dHcOEr1Mkx+TB3WU3vzL3JCz0Z9C7CC8jwo2hBNU7yYUIOKMybvslTITvZcI3C0uFPD23KG+wkLxrmuZeVLCGlP1U5U6mRIvWpR1cCFgIwVaa01m+662AmJ7W5vgYlguSSAxFJWvyoJEyZQORh5YMF+TqW9BakP2uv4vOrp/F7X1NT+b+84LXGALha6RPLMhpABRlb4UHW+9U3+xBECaVnnqrCC6QHagVsH44ZrvBdChYGBM8PJZA0ceCmBBSv0F7DeAjvL7/I1vjPCKHa7RgLT+qt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9bLhUvmy4T3O4X3fC6BMQKGU2auFuM+vBfOCoEwCUE=;
 b=fLemeBNevAG4J9T34p35A7+IJb859+C9cQT3UjArMv03Zp5eWx3CRDqtccK9W5a0Z/emVYGZvn5q/fwu5vxIgECz9/wVXMlCYRrckCDHhwCwpeTHalC7l+3FB1yNGoj+7INQBjohdK8jw3JTqQsjnwGxu9we+8cmg5f162iuOJk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:06:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:33 +0000
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
Subject: [RFC v1 170/256] cl8k: add rssi.c
Date:   Thu, 17 Jun 2021 16:00:57 +0000
Message-Id: <20210617160223.160998-171-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82241b6-83eb-4063-5b86-08d931a9c0ec
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260690C260FE32A472B1385F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcMGIaZhBUw9Eo1KbZZ81IfhYlqnfoQqy3FBrkNhJsJy2R9aqyzdom1YDwd3v/yJW6dA6vGkololw20XeayC8rFJYqxCtmXDxMdkNBJf18lZi6sMrK96kmRIil8wArXAEVFCSgB4b8RIcPj6/RGtr52nbx1Of7MWuWfWkzgGRmXu+LaOIiAFqV/zgaPO5e3UseSqkHLGJkFmKUmH9PBssYmQZ7jwlDXjiJc9hwPaEfhGt2OnK+yasbt62RfEJt17VLi9ew/65XFpE7ySvFiSEgKwXik+0jd7qC+3Ugz+81AZftTbKJ3xUk83IUAchPwUDCzPhmZcEBry1liqLicT7HZi3FDDPsuYINJZ9laS6gZQgi/8DsPBhMgPLj4R82V4xCCqMtK6ijuiPTiArMcUDjkepTVlKpo+usftUB8TsfxeAo8WsqasYfTdLoOdvYCjxLqAmefEl/QeVOp1XJkjI270iT2s0GwWBjKCEqUGhGPbuqohM18cmt3g+gK+p/Akyl1fza0RJGylhREaI87TPts1+EBMkvKiZ2som7+TI8766kIYiiVsFYce0Riqmse8k+d84god2HBx+IDaw8+ApvRcpf6HogNQ7kqDbq5IEAVoL3XznYIm9iTFzjRvfnNSsK6SSBQZ2003DDvFBsGJ9TL4NVbBR+NUEyB8BMqhdVN6IYZs1U2wO/pWcYvtb6F25AFUii01zSWJ1NSDg2pkcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(508600001)(8936002)(86362001)(107886003)(4326008)(316002)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URNCl8a3l5XF3M51nI7Bt+ypsIBeUUX3jfpE7nVs9L+vq1ropj8nKiqN6M+w?=
 =?us-ascii?Q?82mHfZj4WhSPkx6/xelQPdsMNTms42jCicbG0mTau+9QJGzIcgQbY1w5+mV5?=
 =?us-ascii?Q?e6IjtbuMnwzfBe7yCQ0RzeoVBETVeIibJvvtknZybwjlha1yvZrNYvMwhDyr?=
 =?us-ascii?Q?7doFfAIx8EzH+woRB0nvQeKPT96Me2HM+FRiriGJODdkKVjB1/2x27HqrNLi?=
 =?us-ascii?Q?55kmnUblkSTiadoGI4CIEV7G+P1rvXq6hMZMcdFKrpqUTbtUKofcax3Ldovq?=
 =?us-ascii?Q?JCmpdXNLT0QwBb3MTtis8BipmhPmBX2COWcDORgf+rpmI6pH7NzWl9cry+7T?=
 =?us-ascii?Q?QOu4TEHES7/fm/6OgbFYVRCEV0zZTLMpf0VLcTnGgaQfzeRUBYL+Jt3FdXMV?=
 =?us-ascii?Q?tdMgHV05ZcNcsWDxMNpHZnr/zKVGPk5d+Anl3pOee3a0sI4L61eUYboTAFUG?=
 =?us-ascii?Q?xO0gnjFvcWKb/2f+LeEbVf0X12PDyFr1bys+42N23opmsi8oDxQfJcx+io0B?=
 =?us-ascii?Q?oFqIvy5xX02gqmb5gHKcF/aiQJLo8NOdCLA047mqgIDrOoKAJuAm51/21znA?=
 =?us-ascii?Q?vFGinzijkpJExvNy4sKBOgw9lqDFRkZtDD9LfdrdmiixXq0FqvEGcbVSrNVq?=
 =?us-ascii?Q?89qKkzQrSbKtPKC1jhaycMYIt2idlDiatuwWdtBKeIwCzZnbNE8QPt1rqbMw?=
 =?us-ascii?Q?NOWOcYoVjrEDFgJC1yDNdk1XXVdyKt/kay7Gyo2muU1WB/VRgk5bIlsFJJqV?=
 =?us-ascii?Q?mnP7edJzDZOLZBBUEpdmT2vikcNvYZfubWu5IQ/YU2jtupHOmA4A15EASdgf?=
 =?us-ascii?Q?hUX4PWHovRZ75psgr8zZqiZsnQ7qYMMrghkaMRClrQSgOgACqLSexk2yOWqK?=
 =?us-ascii?Q?dI7fAF6u+80ni3QC82Br6eOboVaT3fGs14+KdUI/6zTwCXYtDJLaXL79SwL5?=
 =?us-ascii?Q?H2ICBUvz/er2X4jb24BEqI0b8W583h9hdgT66kTAQ2j9aYllI05B+iA1f0t7?=
 =?us-ascii?Q?X3VBCWQRvMPSJ/hXCHsk5MbyNYcMGQKXQqlRmNKTiEWQXJ3M80FYrpNHqrxF?=
 =?us-ascii?Q?IOMnC21VzvA1oFPEuMCAIgeUNZSsJmS8G7Bm3x0IbefJyTed6IqqydyogOyK?=
 =?us-ascii?Q?QUHauI+ofNbL7e7V8PZRf6O6lcFb+nZnufA6VLonhGWSGjhFzybWGEJm9j5C?=
 =?us-ascii?Q?m0gDRsivM1DWHmOiVo7vPuWmRwfEsqw0chxMPK68aofYD4iSxGTxXBfGezxs?=
 =?us-ascii?Q?qG4a0TWp5BHE91hGAyuttcxH7gK31bYxi84iHbh+AepiBU/T7PJ1zcTtzAyk?=
 =?us-ascii?Q?uz1Du22armf9ZgSt3AXY6vU5?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82241b6-83eb-4063-5b86-08d931a9c0ec
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:40.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzNK+v5hT1s5tefcWLeAwfD7QoO83WZJ5UXq+muspCoqLKDu362XuSuXpBT/LS3ho5hPeVFlQb/MrP0cEc6UHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rssi.c | 320 ++++++++++++++++++++++++
 1 file changed, 320 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rssi.c

diff --git a/drivers/net/wireless/celeno/cl8k/rssi.c b/drivers/net/wireless=
/celeno/cl8k/rssi.c
new file mode 100644
index 000000000000..48221007f424
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rssi.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rssi.h"
+#include "vns.h"
+#include "stats.h"
+#include "sta.h"
+#include "motion_sense.h"
+#include "mac_addr.h"
+#include "chip.h"
+
+/*
+ * cl_rssi_assoc_###()
+ * -------------------
+ * RSSI values of association packets (request in AP mode and respone in S=
TA mode)
+ * are not added to rssi pool sample, because at this stage station is not=
 added
+ * to driver database.
+ * RSSI of association is important for WRS in order to select its initial=
 rate.
+ * The goal of this code is to save MAC address and RSSI values of all ass=
ociation
+ * packets, and after station fully connects, search for the correct RSSI =
and add
+ * it to the rssi pool sample.
+ */
+struct assoc_queue_elem {
+       struct list_head list;
+       u8 addr[ETH_ALEN];
+       s8 rssi[MAX_ANTENNAS];
+       unsigned long timestamp;
+};
+
+#define CL_RSSI_LIFETIME_MS 5000
+
+static void cl_rssi_add_to_wrs(struct cl_hw *cl_hw, struct cl_sta *cl_sta,=
 s8 rssi[MAX_ANTENNAS])
+{
+       struct cl_wrs_rssi *wrs_rssi =3D &cl_sta->wrs_rssi;
+       int i =3D 0;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               wrs_rssi->sum[i] +=3D rssi[i];
+
+       wrs_rssi->cnt++;
+}
+
+void cl_rssi_assoc_init(struct cl_hw *cl_hw)
+{
+       INIT_LIST_HEAD(&cl_hw->assoc_queue.list);
+       spin_lock_init(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_assoc_exit(struct cl_hw *cl_hw)
+{
+       /* Delete all remaining elements in list */
+       spin_lock(&cl_hw->assoc_queue.lock);
+
+       if (!list_empty(&cl_hw->assoc_queue.list)) {
+               struct assoc_queue_elem *elem =3D NULL;
+               struct assoc_queue_elem *tmp =3D NULL;
+
+               list_for_each_entry_safe(elem, tmp, &cl_hw->assoc_queue.lis=
t, list) {
+                       list_del(&elem->list);
+                       kfree(elem);
+               }
+       }
+
+       spin_unlock(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_assoc_handle(struct cl_hw *cl_hw, u8 *mac_addr, struct hw_rxh=
dr *rxhdr)
+{
+       /* Allocate new element and add to list */
+       struct assoc_queue_elem *elem =3D kmalloc(sizeof(*elem), GFP_ATOMIC=
);
+
+       if (elem) {
+               INIT_LIST_HEAD(&elem->list);
+               cl_mac_addr_copy(elem->addr, mac_addr);
+
+               elem->rssi[0] =3D (s8)rxhdr->rssi1;
+               elem->rssi[1] =3D (s8)rxhdr->rssi2;
+               elem->rssi[2] =3D (s8)rxhdr->rssi3;
+               elem->rssi[3] =3D (s8)rxhdr->rssi4;
+               elem->rssi[4] =3D (s8)rxhdr->rssi5;
+               elem->rssi[5] =3D (s8)rxhdr->rssi6;
+
+               elem->timestamp =3D jiffies;
+
+               spin_lock(&cl_hw->assoc_queue.lock);
+               list_add(&elem->list, &cl_hw->assoc_queue.list);
+               spin_unlock(&cl_hw->assoc_queue.lock);
+       }
+}
+
+void cl_rssi_assoc_find(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 num=
_sta)
+{
+       /* Search for rssi of association according to mac address */
+       spin_lock(&cl_hw->assoc_queue.lock);
+
+       if (!list_empty(&cl_hw->assoc_queue.list)) {
+               unsigned long lifetime =3D 0;
+               struct assoc_queue_elem *elem =3D NULL;
+               struct assoc_queue_elem *tmp =3D NULL;
+
+               list_for_each_entry_safe(elem, tmp, &cl_hw->assoc_queue.lis=
t, list) {
+                       lifetime =3D jiffies_to_msecs(CL_TIME_DIFF(jiffies,=
 elem->timestamp));
+
+                       /* Check lifetime of rssi before using it */
+                       if (lifetime > CL_RSSI_LIFETIME_MS) {
+                               /* Delete element from list */
+                               list_del(&elem->list);
+                               kfree(elem);
+                               continue;
+                       }
+
+                       if (ether_addr_equal(elem->addr, cl_sta->addr)) {
+                               struct hw_rxhdr rxhdr;
+                               s8 equivalent_rssi =3D cl_rssi_calc_equival=
ent(cl_hw, elem->rssi);
+
+                               rxhdr.rssi1 =3D elem->rssi[0];
+                               rxhdr.rssi2 =3D elem->rssi[1];
+                               rxhdr.rssi3 =3D elem->rssi[2];
+                               rxhdr.rssi4 =3D elem->rssi[3];
+                               rxhdr.rssi5 =3D elem->rssi[4];
+                               rxhdr.rssi6 =3D elem->rssi[5];
+
+                               cl_rssi_rx_handler(cl_hw, cl_sta, &rxhdr, e=
quivalent_rssi);
+
+                               /* Delete element from list */
+                               list_del(&elem->list);
+                               kfree(elem);
+                       }
+               }
+       }
+
+       spin_unlock(&cl_hw->assoc_queue.lock);
+}
+
+void cl_rssi_sort_descending(s8 rssi[MAX_ANTENNAS], u8 num_ant)
+{
+       int i, j;
+
+       for (i =3D 0; i < num_ant - 1; i++)
+               for (j =3D 0; j < num_ant - i - 1; j++)
+                       if (rssi[j] < rssi[j + 1])
+                               swap(rssi[j], rssi[j + 1]);
+}
+
+static s8 cl_rssi_equivalent_2_phys(s8 rssi_max, s8 rssi_min)
+{
+       s8 rssi_diff =3D rssi_min - rssi_max;
+
+       if (rssi_diff > (-2))
+               return (rssi_max + 3);
+       else if (rssi_diff > (-5))
+               return (rssi_max + 2);
+       else if (rssi_diff > (-9))
+               return (rssi_max + 1);
+       else
+               return rssi_max;
+}
+
+s8 cl_rssi_calc_equivalent(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS])
+{
+       s8 rssi_tmp[MAX_ANTENNAS] =3D {0};
+       u8 rx_ant =3D cl_hw->num_antennas;
+       int i, j;
+
+       /* Copy to rssi_tmp */
+       memcpy(rssi_tmp, rssi, rx_ant);
+
+       /* Sort the rssi's in desceding order */
+       cl_rssi_sort_descending(rssi_tmp, rx_ant);
+
+       /*
+        * 1) Calc equivalent rssi between the two lowest values.
+        * 2) Sort again
+        * 3) Repeat steps 1 and 2 according to number of antennas.
+        */
+       for (i =3D 0; i < rx_ant - 1; i++) {
+               rssi_tmp[rx_ant - i - 2] =3D cl_rssi_equivalent_2_phys(rssi=
_tmp[rx_ant - i - 2],
+                                                                    rssi_t=
mp[rx_ant - i - 1]);
+
+               for (j =3D rx_ant - i - 2; j > 0; j--) {
+                       if (rssi_tmp[j] > rssi_tmp[j - 1])
+                               swap(rssi_tmp[j], rssi_tmp[j - 1]);
+                       else
+                               break;
+               }
+       }
+
+       return rssi_tmp[0];
+}
+
+s8 cl_rssi_get_strongest(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS])
+{
+       int i;
+       s8 strongest_rssi =3D S8_MIN;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++) {
+               if (rssi[i] > strongest_rssi)
+                       strongest_rssi =3D rssi[i];
+       }
+
+       return strongest_rssi;
+}
+
+static void cl_update_sta_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              s8 rssi[MAX_ANTENNAS], s8 equivalent_rssi)
+{
+       /* Last RSSI */
+       memcpy(cl_sta->last_rssi, rssi, cl_hw->num_antennas);
+
+       if (cl_sta->manual_alpha_rssi)
+               return;
+
+       /* Alpha RSSI - use alpha filter (87.5% current + 12.5% new) */
+       if (cl_sta->alpha_rssi)
+               cl_sta->alpha_rssi =3D
+                       ((cl_sta->alpha_rssi << 3) - cl_sta->alpha_rssi + e=
quivalent_rssi) >> 3;
+       else
+               cl_sta->alpha_rssi =3D equivalent_rssi;
+}
+
+void cl_rssi_block_ack_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct cl_agg_tx_report *agg_report)
+{
+       /* Handle RSSI of block-ack's */
+       union cl_rate_ctrl_info *rate_ctrl_info =3D
+               (union cl_rate_ctrl_info *)&agg_report->rate_cntrl_info;
+       u8 bw =3D (u8)rate_ctrl_info->field.bw;
+       s8 rssi[MAX_ANTENNAS];
+       s8 equivalent_rssi;
+       int i;
+       s8 bw_factor =3D 0;
+
+       /*
+        * For TCV1 fill in the rxhdr rssi "holes" so that values will star=
t from rssi1.
+        * The implementation below takes into account elastic mimo, and ma=
ximum number
+        * of antennas for each TCV.
+        */
+       if (cl_chip_is_8ant(cl_hw->chip)) {
+               rssi[0] =3D (s8)agg_report->rssi1;
+               rssi[1] =3D (s8)agg_report->rssi2;
+               rssi[2] =3D (s8)agg_report->rssi3;
+               rssi[3] =3D (s8)agg_report->rssi4;
+               rssi[4] =3D (s8)agg_report->rssi5;
+               rssi[5] =3D (s8)agg_report->rssi6;
+       } else if (cl_chip_is_6ant(cl_hw->chip)) {
+               if (cl_hw_is_tcv0(cl_hw)) {
+                       rssi[0] =3D (s8)agg_report->rssi1;
+                       rssi[1] =3D (s8)agg_report->rssi2;
+                       rssi[2] =3D (s8)agg_report->rssi3;
+                       rssi[3] =3D (s8)agg_report->rssi4;
+                       rssi[4] =3D (s8)agg_report->rssi5;
+               } else {
+                       /* Chain 1 is not used */
+                       rssi[0] =3D (s8)agg_report->rssi2;
+                       rssi[1] =3D (s8)agg_report->rssi3;
+                       rssi[2] =3D (s8)agg_report->rssi4;
+                       rssi[3] =3D (s8)agg_report->rssi5;
+                       rssi[4] =3D (s8)agg_report->rssi6;
+               }
+       } else {
+               if (cl_hw_is_tcv0(cl_hw)) {
+                       rssi[0] =3D (s8)agg_report->rssi1;
+                       rssi[1] =3D (s8)agg_report->rssi2;
+                       rssi[2] =3D (s8)agg_report->rssi3;
+                       rssi[3] =3D (s8)agg_report->rssi4;
+               } else {
+                       /* Chains 0 & 1 are not used */
+                       rssi[0] =3D (s8)agg_report->rssi3;
+                       rssi[1] =3D (s8)agg_report->rssi4;
+                       rssi[2] =3D (s8)agg_report->rssi5;
+                       rssi[3] =3D (s8)agg_report->rssi6;
+               }
+       }
+
+       /*
+        * RSSI adjustment according to BW
+        * The BA is transmitted in the BW of the aggregation it acknowledg=
es
+        */
+       if (bw =3D=3D CHNL_BW_160)
+               bw_factor =3D 9;
+       else if (bw =3D=3D CHNL_BW_80)
+               bw_factor =3D 6;
+       else if (bw =3D=3D CHNL_BW_40)
+               bw_factor =3D 3;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               rssi[i] +=3D bw_factor;
+
+       equivalent_rssi =3D cl_rssi_calc_equivalent(cl_hw, rssi);
+
+       /* Handle RSSI after BW adjustment */
+       cl_rssi_add_to_wrs(cl_hw, cl_sta, rssi);
+       cl_stats_update_rx_rssi(cl_hw, cl_sta, rssi);
+       cl_vns_handle_rssi(cl_hw, cl_sta, rssi);
+       cl_update_sta_rssi(cl_hw, cl_sta, rssi, equivalent_rssi);
+       cl_motion_sense_rssi_ba(cl_hw, cl_sta, rssi);
+}
+
+void cl_rssi_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                       struct hw_rxhdr *rxhdr, s8 equivalent_rssi)
+{
+       /* Called after BW adjustment */
+       s8 rssi[MAX_ANTENNAS] =3D RX_HDR_RSSI(rxhdr);
+
+       cl_rssi_add_to_wrs(cl_hw, cl_sta, rssi);
+       cl_stats_update_rx_rssi(cl_hw, cl_sta, rssi);
+       cl_vns_handle_rssi(cl_hw, cl_sta, rssi);
+       cl_update_sta_rssi(cl_hw, cl_sta, rssi, equivalent_rssi);
+}
+
+void cl_rssi_bw_adjust(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr, s8 bw_=
factor)
+{
+       rxhdr->rssi1 +=3D bw_factor;
+       rxhdr->rssi2 +=3D bw_factor;
+       rxhdr->rssi3 +=3D bw_factor;
+       rxhdr->rssi4 +=3D bw_factor;
+       rxhdr->rssi5 +=3D bw_factor;
+       rxhdr->rssi6 +=3D bw_factor;
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

