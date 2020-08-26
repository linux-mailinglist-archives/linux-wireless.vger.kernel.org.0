Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25596252F78
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgHZNRi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 09:17:38 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:39557
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729177AbgHZNRh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 09:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkVuQlgFeakgf/wP9fnxHMLv41y5t3kXv3nOrB5Oaj39TRtez9/5J1xMyOUqQNN/I5SRWLDoUF1Z55XIBw9p0Hx/MWy52b9/khNR60D6lN7CyF9UM1XhdmKVWZ6CQDjhLiUZO3vGISPnI4pgAi2pZahAmneKtyLZRI/CLIXWzI+I4V40U1lR8/jOKtJ79GewmPXnPra5cXOrIrGXznJpOdpCNQddazt06h3H9LG6cvsqthoBU/74Sp8uCFfeDECk80WpYLL1I25hS++0uRPGzGrhCuokUh8w/403KDtoXk976H3C4f3bviEjEj8dZjWJ8ZcnpPux6Vit1P5+OoVzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS4dFbbXaLfjBXEFocUwKGtMZYSpiVNY/mFGckSWFQU=;
 b=Ewnc98K8ryA1wQ0DwFtg5q5Vv8p+/IB6xU9/GrUH+5mjqbRFi+aRCAOcHqkI8fudIjrn8CUZWw0TvvKzLXme3QdYs8Tv0tOh+3Qq0llvNWzvvGFv6hZO7MafRyq1WvdfKh1qa2iIOq1mERm2q8bCjiM2h0sP6nxlZJLeeq+kwjJg62syHmee6ldR9ygminxzZScTrUgzgTEjiA9ufrL9lRs6WV9sA2A/TyGrb5wDgSx7lIqCplr/zf7yIbL7Le1Jx88aGNXXTDwE+0S22nlhdZeQ0+VJUPoV7RHNw69+D1YMrDjHx5LUGNfEX9iRWtJpJwhR/x5JFaC9DMwETBLHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS4dFbbXaLfjBXEFocUwKGtMZYSpiVNY/mFGckSWFQU=;
 b=hD8nCwsjoSoWYscN8uo8Nbom0De+7HesUvx5SqRMOI/SwzDEd/mgfewRsVXGlj652S99oyMnSyFCH2VwJR+qA6AInvmhdHrsvne4sMyW5EKm8qQKgqKaROjGGG+4dXvRoW1XwW3hhZtBFNMU15qoSo7PALc8o5uwTNm4FVylSiI=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:38::31)
 by VE1P192MB0686.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 13:17:33 +0000
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9f3:c73:3d30:1467]) by VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9f3:c73:3d30:1467%6]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 13:17:33 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Subject: [PATCH] nl80211: Trigger channel switch from driver
Date:   Wed, 26 Aug 2020 16:17:09 +0300
Message-Id: <20200826131709.25530-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0417.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::21) To VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:803:38::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (77.126.12.128) by LO2P265CA0417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 13:17:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.126.12.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f49ef99-4cda-49a0-6ed0-08d849c26433
X-MS-TrafficTypeDiagnostic: VE1P192MB0686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1P192MB0686CA4C34AF49FA98D26699E7540@VE1P192MB0686.EURP192.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaOvV1HuRBtZV5H6d8it6eqsycLYNvbj+bJmUDhnFd58SkoYjaxQaEAAwmB/6KNVeIT6vR8+LpQSVW6jNFW8N+jildOTkC6stU61leqw63Q8jhf+zhXQSsLGYmKMtOEOc7CnUEZ2jPL+OnSLk3vKLREyBDHpG6vMaeAzXwFXAhX2LUjfuKuqHYnTTIxSrv7xOuwrIQ9lP4qFlPc5t7YP5DsO5qtuN/MghcbQXad4bcEXPtagIJH9z+5kVnDAcQEToq75ipS4CUxfCyKwMWwvJSLDkYEjerurXqVFH3moMo8sOt3nSsQC9iR7DK9UwEkAO3FqHvc1W4dfOzBbgkj3b9iKAB2tFr3UEr1xV2oDzn+F3DrIh46SwkEJUCqbzOw4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P192MB0479.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(39840400004)(376002)(186003)(26005)(6506007)(5660300002)(6666004)(66556008)(52116002)(44832011)(6916009)(2616005)(69590400008)(2906002)(956004)(66476007)(16526019)(1076003)(36756003)(66946007)(6512007)(8676002)(83380400001)(4326008)(86362001)(107886003)(6486002)(8936002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mn2BSEyozRNRMORlxbFSsq8WZWEsAdBZ6rfjNToEFMirvtaA9OFsXn7mQYjCTnc0fb8lC5BRWKvXCBrIJfutyVPqMHWyT4f4V5hZGKNHZwKi1LXTPJkdPTdwK/IwIWd4QhSINQfWQbUoLzGvchfecOA/4kj8/VUIS47hTyAcx6lpU+IKdmL6wyMuVmcJg54XxfJFzNDsSvV7wMavgBJtkl+OoLCU1HwLwGmTXjs3iD4UGmvZDYb7qMKMflBvqk71nBJlb3cuaDRvIz0dtq3gCZdLZNGNrJldEn/giL6tz5ok5/ntzuGz2NliPKvUBu7+ycKaunRg+hH+5Fv5PSqd5l/kSSWWtyA3vcLIr/7X1VTTwajuRvunAj21CbjwoQzO8YzM6S4icLg6qgMPXd8PsENiwQMuzGgTukKzTiB0Eua2j+jeGTJboeSOxY1rFKuvrsOPEkLIEQxTj+qj37bQqBKrRh13+8yuo54WPOy5Kn3UWLWiVNnJQBcNc3aGvUjFD7tjxHM/FtR07HvIUjc9X1bTvQMiM/NvPCQQPHEj+eN+bt4VY3kqkLrY75VlL7a4QMW0JdpItq4b7DweOIOaIe4YfODuM65YvbpTRbaAuSejf/G5DudAaA1InSFtHZkWkBpKr63OuUyZzYmzPg7SuA==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f49ef99-4cda-49a0-6ed0-08d849c26433
X-MS-Exchange-CrossTenant-AuthSource: VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 13:17:33.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCDrbrym6mW3qUHHjDznmb6BIQ9p2hLOEQyoEbO6FWWP6iWLfgv5l8JlBzeC0JFa/gfgrQ5dedYBTmS2KpXIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0686
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch add channel switch event from driver to hostap.
same as can be triggered from US via hostapd_cli chan_switch.
using the already existing NL80211_CMD_CHANNEL_SWITCH.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 include/net/cfg80211.h | 11 ++++++
 net/wireless/nl80211.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d9e6b9fbd95b..ae02d96eb8ec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7416,6 +7416,17 @@ void cfg80211_ch_switch_started_notify(struct net_de=
vice *dev,
                                       struct cfg80211_chan_def *chandef,
                                       u8 count);

+/*
+ * cfg80211_ch_switch - trigger channel switch from driver
+ * same as is can be triggered from hostapd_cli chan_switch
+ * @dev: the device which switched channels
+ * @chandef: the new channel definition
+ * @csa_count: the number of TBTTs until the channel switch happens
+ */
+bool cfg80211_ch_switch(struct net_device *dev,
+                              struct cfg80211_chan_def *chandef,
+                              u8 csa_count);
+
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 19dc0ee807f6..c9ed073e5ab3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16854,6 +16854,89 @@ void cfg80211_ch_switch_started_notify(struct net_=
device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);

+static void nl80211_ch_switch(struct cfg80211_registered_device *rdev,
+                             struct net_device *netdev,
+                             struct cfg80211_chan_def *chandef,
+                             u8 csa_count,
+                             gfp_t gfp)
+{
+       struct sk_buff *msg;
+       void *hdr;
+
+       msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+       if (!msg)
+               return;
+
+       hdr =3D nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_CHANNEL_SWITCH);
+       if (!hdr) {
+               nlmsg_free(msg);
+               return;
+       }
+
+       if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx))
+               goto nla_put_failure;
+
+       if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex))
+               goto nla_put_failure;
+
+       if (nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ,
+                       chandef->chan->center_freq))
+               goto nla_put_failure;
+
+       if (nla_put_u32(msg, NL80211_ATTR_CENTER_FREQ1, chandef->center_fre=
q1))
+               goto nla_put_failure;
+
+       if (nla_put_u32(msg, NL80211_ATTR_CHANNEL_WIDTH, chandef->width))
+               goto nla_put_failure;
+
+       if (chandef->width =3D=3D NL80211_CHAN_WIDTH_40) {
+               enum nl80211_channel_type chan_type =3D NL80211_CHAN_HT40MI=
NUS;
+
+               if (chandef->center_freq1 > chandef->chan->center_freq)
+                       chan_type =3D NL80211_CHAN_HT40PLUS;
+
+               if (nla_put_u32(msg, NL80211_ATTR_WIPHY_CHANNEL_TYPE,
+                               chan_type))
+                       goto nla_put_failure;
+       }
+
+       if (nla_put_u32(msg, NL80211_ATTR_CH_SWITCH_COUNT, csa_count))
+               goto nla_put_failure;
+
+       genlmsg_end(msg, hdr);
+
+       genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg,=
 0,
+                               NL80211_MCGRP_MLME, gfp);
+       return;
+
+ nla_put_failure:
+       genlmsg_cancel(msg, hdr);
+       nlmsg_free(msg);
+}
+
+bool cfg80211_ch_switch(struct net_device *dev,
+                       struct cfg80211_chan_def *chandef,
+                       u8 csa_count)
+{
+       struct wireless_dev *wdev =3D dev->ieee80211_ptr;
+       struct wiphy *wiphy =3D wdev->wiphy;
+       struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
+
+       if (WARN_ON(wdev->iftype !=3D NL80211_IFTYPE_AP &&
+                   wdev->iftype !=3D NL80211_IFTYPE_P2P_GO &&
+                   wdev->iftype !=3D NL80211_IFTYPE_ADHOC &&
+                   wdev->iftype !=3D NL80211_IFTYPE_MESH_POINT))
+               return false;
+
+       if (WARN_ON(!chandef || !chandef->chan))
+               return false;
+
+       nl80211_ch_switch(rdev, dev, chandef, csa_count, GFP_ATOMIC);
+
+       return true;
+}
+EXPORT_SYMBOL(cfg80211_ch_switch);
+
 void
 nl80211_radar_notify(struct cfg80211_registered_device *rdev,
                     const struct cfg80211_chan_def *chandef,
--
2.17.1

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

