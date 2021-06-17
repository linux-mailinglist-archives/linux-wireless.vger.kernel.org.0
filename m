Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F813AB8C3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhFQQKW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:22 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:14478
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232095AbhFQQJP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFqVnFAofzrxhYCrv9r1np69Bu5LuA8Kk3N9sAzqz7DRC/D9gEYpBtFoaNj65w6I+H5uf26enEPdKRlCBNDrecr0esRsPUtnlw56E9ZnNviaOinPwNHDAdlufxWUf96npL3CqozD1I1KuiOl6uGAziYh7TfI48zKBSYyP5RzEcmyjcAZ8hyMGKAwz4EWJkkMY91YEABlYQ985BeFtmr4eB8jIs9BwIuJQIT8YrcEl9By4zGdl9Rc1uqHZmtCfy/DlOyL4zc+EtH3KFMHnbtoTLGGs14xl5F8CebXqaXOyvgJ4nPovRRGBdIQK5W4RKl1IRAL9Isw1yylQggpbpyVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvmBt7GUBZJ4l+75aqx+YJ+vTMK0yx6hPil5ttTrH+s=;
 b=NQ+ZFnVjGAc3vtJOgQjysfppifAorbw3jk/j43fqfiviAZJcO+JMYjJhjg5TlDD6V49t13pZOGQdQe5hBvTcsV/uCtsXFm1PKIGzKH4qFutTLyJlhQXKmnYWexlcbGZ45S2Yjs+ryqvdxE6TWwpnDBguekJjUiovbdQw5odGvAHagZKKEHeq8ws7Jjr5BkQ6I3In0gGMm1muDaRkjbTct/bBeooJJhWtDeXufoxA8GicskDmDCgZWnGFSCivI7rfX6Va6n45YBC3N2L+w8O9zNtCq+rYOBdgl67lufCFn/JmxLf8vFOGdUHlHjliUuidr7XEoumODzKbOXxRUU7JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvmBt7GUBZJ4l+75aqx+YJ+vTMK0yx6hPil5ttTrH+s=;
 b=FhnCJbE8AtYye+lCOsZJU62eiM31OP6U+9Qb+acjHlrk9FuoX4olv1kN7SaycNLQ694hfNn2bDWTC4O8o5pz1Ocb0oYSMXHgsc7QM8M901J8n9WCLnef586SWsAonUgZppaVizQWB/mk3VPNLKH+g9h0ZXmYIKd3fo12OxMKGeE=
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
Subject: [RFC v1 176/256] cl8k: add rx/rx_filter.c
Date:   Thu, 17 Jun 2021 16:01:03 +0000
Message-Id: <20210617160223.160998-177-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4b6d36-2a22-4542-e706-08d931a9c55a
X-MS-TrafficTypeDiagnostic: AM9P192MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0981DA273CD0D35611E912CDF60E9@AM9P192MB0981.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uydw1jmwtdXRRZ8lgdiCkxq4gif+d/AAwir0IsEMS1AObTCp3tqBnb9FFV/c+u3NnIIQIdlBQZz3yLshCsbEzo2gTsaYnleGd0dH8+PhkDOmOkAZJbLAH4go7Rg8/5JA8Zkna2i1P28Ouk7jMth4jEu09Y2yPbCdpeMj9YmrJU/YMXuh2S3L6+eJrVmBOCEzNI/fUZH5j9PnkpCEDx6CLAhqBIBQuxaSVCz/S3iPq13EgdQe+MsaAkH0n7NonIEWQvKz2ijSajNHUEyniRH5pybBS+i9OH+f7wiEXlwEEz7BD/QunlSze82eFzP0LNLuyTVcc4mDgunA228Yl+vQ3LSEIw1R/x3f0OMu2c0Fb/fy1QuN+SoBXE4z7wUi0kvYi3g6I4bczDl29qquk7iHTZPEP0/0vVCE+mJ4s94oCil830hYXaBrg2KMjtmr/QD46u0J+NbnQFblmNNKpPxG6aQI5ctyrYmKIBV5srY4pFeOxrEHYVDWsWSdpz3+wdTZAqTvD6hd/u8sP9F8z3iZoCn4RJlL54qbuaoBsFAcAVcIz1ESUgP+EyKQeUUMKcT9BMOyKXHpkJKcAU3O+HxrVpOuKzR42nLnUwm2KPJnMUYuMJ3cYeWy2nu5aAWQ35Xq6I5YOHBviCyH8DnUvlOiYvGola2BxhRiRaEPFevG/Xm0k2dKQ4A67/hPnalBs/0dar5qD0Wseh0aKRQRD5AgXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(86362001)(5660300002)(9686003)(54906003)(107886003)(6666004)(1076003)(2906002)(478600001)(6512007)(26005)(2616005)(38350700002)(16526019)(55236004)(38100700002)(6506007)(4326008)(8676002)(66946007)(186003)(66476007)(66556008)(956004)(83380400001)(6916009)(8936002)(36756003)(52116002)(6486002)(316002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSkAwBvg4CfIUGFBJKbHakzllTisroaS8UAzod6obRivkhqtw77VJ9zuXlmL?=
 =?us-ascii?Q?x5y8c1fXBlawGP1mAnorfxEUTb7DHMLKJ+bNVt8Y5FycvmSc1LAgnhI68AZF?=
 =?us-ascii?Q?QdWitFojSvGw7GGsGteNHEqtSoTpblZqRuZNgvvmFm/oaA+vZWYOYJr4cdS+?=
 =?us-ascii?Q?VLezSxeeKo/Asi0VdFfObHyoztJfVGBRDewDU7YKLAsF02xjBQJHwcC6zbMr?=
 =?us-ascii?Q?AvkuHULFiNvRmXIyH03Uf3vdagbKmqAaKfpgNCJqF9dDD7jC1SCfWyoC9ibN?=
 =?us-ascii?Q?BfwJiQ0jozrY3u71GT/I9CMoWPcXiGE5Amhul/9pQLu8G58OfA2kMuO0/hw7?=
 =?us-ascii?Q?G/MMMSKzIsutYv8ptBuWYYMEmG3m+9ib+UAhEqbYPtxI9XvilNdSM4TSg7Qs?=
 =?us-ascii?Q?p37e4GiA0xsRgnX48s3q/ovywpqIA5cdrCWfHuDQt5xw5mhsOHDZYyrLcIbk?=
 =?us-ascii?Q?YlG5N14KpNcE17nY7tjRXKaY8uM4cm2wvPJzV/pdf621fdDh16Bl8ajyzdkY?=
 =?us-ascii?Q?UFWpQROomvgnzVt2LWtrKkHjCyDalhNRLPcb9nD3cR8M3HfDyzXh/TJ8S/5N?=
 =?us-ascii?Q?qG5s9MbtMHRlPtc4171rrxT6Ma7op4GTBmI+gMIFMkcMPFjKSEuLWhYzWg9I?=
 =?us-ascii?Q?wkmfE7sMEM6cuy14fqchkwvnG8NRiJ7ZMae6YLI/GVBTvFV41XnnvmYTzUu2?=
 =?us-ascii?Q?h2cX7+c5GDwxCx1mV17Y396HM9JjGj9TZvm8t3wbC9NAhO9gMYSCQQKLSbgU?=
 =?us-ascii?Q?aVYqvHn5W/fBD8EzGWWWs/EUE2qHVKLgTKCJGYIur9Dyv9h2DCt9Thwx1pUb?=
 =?us-ascii?Q?POZMyCcYotvTTVrGX4eVY4rsCMUExh+C2kyzUzeOnl+n87nyJubbP8oiIfFq?=
 =?us-ascii?Q?7PTlNYBye+ND8wA6ncnqvsTM5ZrjmNlvhAib9gkHt3lQAlCuu77NuiRV6hiF?=
 =?us-ascii?Q?xnUmhvD3/oN5jhHVXVqO8BLIwFm4EQ7wiGOBvB27b0uo1zjuQaLfrVibYfTW?=
 =?us-ascii?Q?N9NlJhbx6kKE0UMpfBy2JYhXdNYSl/ZOwy5jQ49XSkqKQ+usH6pqmLm6y/qM?=
 =?us-ascii?Q?jZQlWLmy7Yxr1kks4kZhsSRnSbfYmvu2M9mhTmHu8EkuXsKgfMa7QIZjFKNZ?=
 =?us-ascii?Q?LUZbOv5jEUdUGL95qxOpImFSxw5nNBRtQFrkEhwxowhtyDKbiMyHMVsvP5lN?=
 =?us-ascii?Q?84gIuYOyZgBTIbPUaR01XBGjHTVbKsOYCi6tYtATSzOfR4h/E2HkXOuAXkN3?=
 =?us-ascii?Q?j2MLyYgQT3xKEQ0koevxXIx0IbSF7s4LygjX+3IXXomPy86PyBZe3cTLFv/l?=
 =?us-ascii?Q?8YLde7qTSfCcWCuYKZOYxqgG?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4b6d36-2a22-4542-e706-08d931a9c55a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:48.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd1sJ2gNun1oHFQFf4hDKagGPAp4F0DFcibjtvxVQbhzD6mePvTaJWGDKASaMb6xTwzBR1z1PYf+jLR2T6gijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0981
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/rx/rx_filter.c   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_filter.c

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_filter.c b/drivers/net/=
wireless/celeno/cl8k/rx/rx_filter.c
new file mode 100644
index 000000000000..95415ec6aad0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_filter.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rx/rx_filter.h"
+#include "fw/msg_tx.h"
+#include "ieee80211_i.h"
+
+u32 cl_rx_filter_update_flags(struct cl_hw *cl_hw, u32 filter)
+{
+       u32 rx_filter =3D 0;
+
+       if (filter & FIF_ALLMULTI)
+               rx_filter |=3D RX_CNTRL_ACCEPT_MULTICAST_BIT;
+
+       if (filter & (FIF_FCSFAIL | FIF_PLCPFAIL))
+               rx_filter |=3D RX_CNTRL_ACCEPT_ERROR_FRAMES_BIT;
+
+       if (filter & FIF_BCN_PRBRESP_PROMISC)
+               rx_filter |=3D RX_CNTRL_ACCEPT_OTHER_BSSID_BIT;
+
+       if (filter & FIF_CONTROL)
+               rx_filter |=3D RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_BIT |
+                            RX_CNTRL_ACCEPT_CF_END_BIT |
+                            RX_CNTRL_ACCEPT_ACK_BIT |
+                            RX_CNTRL_ACCEPT_CTS_BIT |
+                            RX_CNTRL_ACCEPT_RTS_BIT |
+                            RX_CNTRL_ACCEPT_BA_BIT | RX_CNTRL_ACCEPT_BAR_B=
IT;
+
+       if (filter & FIF_OTHER_BSS)
+               rx_filter |=3D RX_CNTRL_ACCEPT_OTHER_BSSID_BIT;
+
+       if (filter & FIF_PSPOLL)
+               rx_filter |=3D RX_CNTRL_ACCEPT_PS_POLL_BIT;
+
+       if (filter & FIF_PROBE_REQ)
+               rx_filter |=3D RX_CNTRL_ACCEPT_PROBE_REQ_BIT;
+
+       /* Add the filter flags that are set by default and cannot be chang=
ed here */
+       rx_filter |=3D CL_MAC80211_NOT_CHANGEABLE;
+
+       if (ieee80211_hw_check(cl_hw->hw, AMPDU_AGGREGATION))
+               rx_filter |=3D RX_CNTRL_ACCEPT_BA_BIT;
+
+       /*
+        * work around for HW bug (AD 14672)
+        * In order for the response frames to BAR and RTS be with correct
+        * power they should always be accepted and found in the KSR
+        */
+       rx_filter |=3D RX_CNTRL_ACCEPT_BAR_BIT | RX_CNTRL_ACCEPT_RTS_BIT;
+
+       return rx_filter;
+}
+
+static u32 cl_filter_get_flags(struct net_device *dev)
+{
+       struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev=
);
+
+       return sdata->local->filter_flags;
+}
+
+void cl_rx_filter_restore_flags(struct cl_hw *cl_hw)
+{
+       struct net_device *dev =3D cl_vif_get_first_net_device(cl_hw);
+       u32 filter =3D 0;
+
+       if (!dev)
+               return;
+
+       filter =3D cl_filter_get_flags(dev);
+       cl_dbg_verbose(cl_hw, "Restoring filter flags to 0x%x\n", filter);
+       cl_msg_tx_set_filter(cl_hw, filter, false);
+}
+
+void cl_rx_filter_set_promiscuous_off(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       cl_rx_filter_restore_flags(cl_hw);
+}
+
+void cl_rx_filter_set_promiscuous(struct cl_hw *cl_hw)
+{
+       u32 filter =3D ~(FIF_FCSFAIL | FIF_PLCPFAIL | (1 << 31));
+
+       cl_dbg_verbose(cl_hw, "set promiscuous mode 0x%x\n", filter);
+       cl_msg_tx_set_filter(cl_hw, filter, false);
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

