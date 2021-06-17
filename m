Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5B3AB933
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhFQQN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:28 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:58153
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232083AbhFQQMH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSRgD1W9/gFbqOtYfMix9k9wMx32wLTIgV015i/PpRnpkm7HikU5p8BpJnjP7Mm87bbTWPc3Whk3wX2EY271SyayAgSaul8DxSjTqwD2EDh96gKidUARiyrnP4FFb88JnKlEoKGUAgL3n9Ln9oo9HmUqJ4nmcweM5heDGGOlNHYxHD/TvCpFSx8wyPQVilghEs0PGqN8lwys17ewaJMYCbqnwkyN3T0rYQzdYQCVX/oIJMWb3u+DfmXX+6lJ8zV9cp/VzqxvETLeMGALTRhSTDCxCiofFFabXi7dIgChA0BguOdMlaUJEmSFO0YhwqdtqN5CCov7j85U+29Qsf24hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkcAvOAN5gx82TINGZFrAb8FK/jwYtOQR22jNgmwXDw=;
 b=ANjMUDHv1PjL/3Rm24mR3TmQ0rydkyQ4gW2WvN+zC4OT7PzidOYYIYORSLMFPJ96AjKZ+TIBVCihkruO24jq9Fm6Q7c9useNWoPmIL5yjVsqtilvHLORtjH8cS7MuBYFDOOpF4ZHZjm37BzHOZrDzBECYS8JlvlYxPg6TaSfauy2jnKTr3zAjE4hRAP8e2sB2MjeR47LsIk4VJF5jvIPk1scOSZVP9IKmDuhW7vfjSiKiqg3rTTrtDJ9pqeLuKw49Dcm1F50aesY//gCTsjtsJ63C+yBSHXX41J7Yojf9RUW+Q3SvfZHCmS4ylWcfuisoChCY9/0v4P1lEQB7Y7pOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkcAvOAN5gx82TINGZFrAb8FK/jwYtOQR22jNgmwXDw=;
 b=Pi9u3yM2IqP8E2tHBkVJfqVxJ4WrCdSoP2VSUMfefkDbJiCCJPQq5j+bMLNcXTwPLD5qSEZUsjc68iBXOcWg84V+yQmQMSnGN3Cm6qDCFjCPqKBZcK2Gz1I5dP8vW03MBzC9fsU0pxJQYWPcbWhkDS2UlaBdOe4v5eTfvIj0zx0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:59 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:59 +0000
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
Subject: [RFC v1 235/256] cl8k: add vif.c
Date:   Thu, 17 Jun 2021 16:02:02 +0000
Message-Id: <20210617160223.160998-236-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730b7526-ba72-447e-283b-08d931a9ee1b
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04523D8E339721A9EBFDCF1BF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N3JSRxdBcXmTilku1jO4d+50ik1oKDyfxGDmobYhPIEN9fuuVWcmd/9Xi5AuElz2XwblJBvv2GuJxmMWR6dsc6uSfs3cf5skluxtTvLTkWST/5z7ZmzfjcqDB7ZtTHbnn732CQZJe83G2ae+YL27poNIFCd/61b0o+tvwXhdpncqhrz2Px1UNfT/6dvfyvgesAvLftQ3xwTca87SNcDBtNaO3lwNQxf1sHPZJTHiFhLGOC4BL/jG45/nDAE7aWdgY1jMA3dMJ0wJfmtFnAVrYzlXeIXhiTmc3WKxWQ40LrZm4913AOrc52w6IoO2a29ErOBXy4fIj86fpYOadIjzxG36ggjPzMDpGuf4sir/EMuGmhEx3wEiNX6Bc8fZnt8eyMz/xB5fV3PXB2kptyPjl+OM3yYrPbYFOdzSmiyJkPO0sjbG8Htk2+cjy3xxwCMm1grqN5Xzn6rO1uS242kU5mNXzjbGQH0u0BDTeo6YxdGwLt9fvmIjM0hLqkjJ55MRQWJ2Okxfn1kWP2bbV2wOqag8f8/fl0aF6f8zxQFKc+g9EixCh0BuxD+5XjHdVyGiHzaE1buF9SOMkaFHSMzKx8kc4O3GopkZhb+qtGws8Iyi54o3ZL4fhVYFqdjEDobGo2CcDBGWSO2ymvfCuOQgMgCIjgM+wrSRdBDt72MkJr+6ppHkyhWhKhSSKgrswD6R+jcx4nN3WLeYRJvkqBkiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4tfwZxnaB+Pjn812DJltwkopNpDXBZJpSUzSQPC7H/QfeUAa2jh2LPXYox3?=
 =?us-ascii?Q?nHQKkOLXckxZuugq91vaf0nFAG6N0HMrmfiAn98tuBok8K/TrS/GMLFN3eFp?=
 =?us-ascii?Q?t5MHcFMhBFRQNLluiNw1u9T2sODUraWGpWCiAbR6LbrGnJpXfFlXd5kozBtb?=
 =?us-ascii?Q?OasyXlLAFeEbMAGmgOJpBu/R3WnS9mWAfEajciU2bH19VFsmwFymI7gdo184?=
 =?us-ascii?Q?YBx/uExIBUP4tJIOAjNZhdZFfdp5Jy2nb1VNZFveBoGEnfCy/VTnAbcu0M+T?=
 =?us-ascii?Q?VDDf0R6DTIYW4xwqeHkBfrwIBsWSS5E+MPGOIXJ9EKKNxUHXQ1dkyEsEBtnn?=
 =?us-ascii?Q?B+4wso4M/jMXWUnsFpwgs15X4wVRchi/hSwxC6oYSRWL0h249clFQtQ1opCi?=
 =?us-ascii?Q?yL1dTB+bEnR7udpWp8b9ZRHp5Rg9Ruon4hEHB/+rq8jwIZP9SMx+az0BhJi6?=
 =?us-ascii?Q?ftAG9DB9TAHKtKwnxdJwJfqFva2ur/tk6oLFbDv6dRyv32yhiuCo2WWr454/?=
 =?us-ascii?Q?b00dWL+TA2KaFZdEp2CcRhk0S1PJ//57NpKK4/gopSfEbcH5eE3voiqMLqzL?=
 =?us-ascii?Q?lRIF4K7khU1ye0P+aOl1k6UD5Zo9gmxNBeuz8IVtJZraQDNLu/83dja6djwS?=
 =?us-ascii?Q?f+C5MzVrLwYI9kVWHXayiC7NZ1QTDcHHqp9hJANFqvDIZ1Yeyg2rRaHqaNpM?=
 =?us-ascii?Q?Ig7MLIl181jKiPu8v60Q+FrnMjeQ+66XG01TpTxtUG4jLNwm4PrNd0+dxZ+E?=
 =?us-ascii?Q?z0mSchLB4lLcbXVJ63woTVgbJeAaAHMiUwxVDMzlVt/YVdDRsUztsUoFtTYi?=
 =?us-ascii?Q?IWgnFMt5JxO8DyQvLBRcGrNHeyEW+xUxJ0F6G5kfVXtVucUebniPFWj9msKl?=
 =?us-ascii?Q?wqIqJB/uFaI6bZ3w5WruLANg5o0gzFIEZTBfhUwhGKWvgo7uRtrW5QxrwEya?=
 =?us-ascii?Q?48Vwzx4CBCvv7yVcqCP/K/W4u9V/QgW13POyooGN4enrThZhZaP1sphQtGaE?=
 =?us-ascii?Q?2n2jj8pPnk4eCso313HFE+C6yY4AWfxBP7ZSUyySGt+M2IVzLFce2k9dutnE?=
 =?us-ascii?Q?Wesl3umSqOGTtnfm/hXh9EE1q1utfkYXSrQXUvg+5VB2Zy/Vyh7syJKV/AmV?=
 =?us-ascii?Q?e3a/qaaiFbIlKcjusWOTGqiKssAsG9VYTl95PXSbGLLsY7Y99uXTDS8r5BXs?=
 =?us-ascii?Q?I046pTXh1Ptk0tewqjcABnmwNj/47vp2d884PNvG+foxGEWf+0aqQal46jxM?=
 =?us-ascii?Q?w5SRlRcQm5IjB33vm/UQlIGAiuT16ix2YcILZ1scg5huTU/pifwHJseUaXPs?=
 =?us-ascii?Q?mLbnkz3+hClI8RNT76LwRBwc?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730b7526-ba72-447e-283b-08d931a9ee1b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:56.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApHLDOmt2yAqelHdaRh2MWBYkENJ019QMS63NxCqKX4wCyIMovBAJUpcVahRab8gAMZFoaLcox4JR6l4RbNd6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vif.c | 143 +++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.c

diff --git a/drivers/net/wireless/celeno/cl8k/vif.c b/drivers/net/wireless/=
celeno/cl8k/vif.c
new file mode 100644
index 000000000000..80234de0bb7c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vif.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "vif.h"
+#include "hw.h"
+#include "mac_addr.h"
+#include "utils/utils.h"
+#include <linux/list.h>
+
+void cl_vif_init(struct cl_hw *cl_hw)
+{
+       INIT_LIST_HEAD(&cl_hw->vif_db.head);
+}
+
+void cl_vif_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+       list_add_tail(&cl_vif->list, &cl_hw->vif_db.head);
+
+       if (cl_vif->vif->type !=3D NL80211_IFTYPE_STATION)
+               cl_hw->vif_db.num_iface_bcn++;
+
+       /* Multicast vif set */
+       cl_hw->mc_vif =3D cl_vif;
+}
+
+void cl_vif_remove(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+       /* Multicast vif unset */
+       if (cl_hw->mc_vif =3D=3D cl_vif)
+               cl_hw->mc_vif =3D cl_vif_get_next(cl_hw, cl_hw->mc_vif);
+
+       list_del(&cl_vif->list);
+
+       if (cl_vif->vif->type !=3D NL80211_IFTYPE_STATION)
+               cl_hw->vif_db.num_iface_bcn--;
+}
+
+struct cl_vif *cl_vif_get_next(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+       if (list_is_last(&cl_vif->list, &cl_hw->vif_db.head))
+               return list_first_entry_or_null(&cl_hw->vif_db.head,
+                                               struct cl_vif, list);
+       else
+               return list_next_entry(cl_vif, list);
+}
+
+struct cl_vif *cl_vif_get_by_dev(struct cl_hw *cl_hw, struct net_device *d=
ev)
+{
+       struct cl_vif *cl_vif =3D NULL;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               if (cl_vif->dev =3D=3D dev)
+                       return cl_vif;
+
+       return NULL;
+}
+
+struct cl_vif *cl_vif_get_by_mac(struct cl_hw *cl_hw, u8 *mac_addr)
+{
+       struct cl_vif *cl_vif;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               if (cl_mac_addr_compare(cl_vif->vif->addr, mac_addr))
+                       return cl_vif;
+
+       return NULL;
+}
+
+struct cl_vif *cl_vif_get_first(struct cl_hw *cl_hw)
+{
+       return list_first_entry_or_null(&cl_hw->vif_db.head, struct cl_vif,=
 list);
+}
+
+struct cl_vif *cl_vif_get_first_ap(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               if (cl_vif->vif->type =3D=3D NL80211_IFTYPE_AP ||
+                   cl_vif->vif->type =3D=3D NL80211_IFTYPE_MESH_POINT)
+                       return cl_vif;
+
+       return NULL;
+}
+
+struct net_device *cl_vif_get_first_net_device(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif =3D list_first_entry_or_null(&cl_hw->vif_db.h=
ead, struct cl_vif, list);
+
+       return cl_vif ? cl_vif->dev : NULL;
+}
+
+struct net_device *cl_vif_get_dev_by_index(struct cl_hw *cl_hw, u8 index)
+{
+       struct cl_vif *cl_vif =3D NULL;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               if (cl_vif->vif_index =3D=3D index)
+                       return cl_vif->dev;
+
+       return NULL;
+}
+
+bool cl_vif_find_mac(struct cl_hw *cl_hw, u8 *mac_addr)
+{
+       struct cl_vif *cl_vif;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+               if (cl_mac_addr_compare(cl_vif->vif->addr, mac_addr))
+                       return true;
+
+       return false;
+}
+
+void cl_vif_ap_tx_enable(struct cl_hw *cl_hw, bool enable)
+{
+       struct cl_vif *cl_vif;
+       struct ieee80211_vif *vif;
+
+       list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+               vif =3D cl_vif->vif;
+
+               if (vif->type !=3D NL80211_IFTYPE_AP)
+                       continue;
+
+               cl_vif->tx_en =3D enable;
+               cl_dbg_verbose(cl_hw, "Set tx_en=3D%u for vif_index=3D%u\n"=
,
+                              enable, cl_vif->vif_index);
+       }
+}
+
+void cl_vif_bring_all_interfaces_down(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif =3D NULL, *cl_vif_tmp =3D NULL;
+
+       /* Remove all interfaces gracefully to avoid of memleaks and kernel=
 panics */
+       list_for_each_entry_safe(cl_vif, cl_vif_tmp, &cl_hw->vif_db.head, l=
ist) {
+               rtnl_lock();
+               dev_close(cl_vif->dev);
+               rtnl_unlock();
+       }
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

