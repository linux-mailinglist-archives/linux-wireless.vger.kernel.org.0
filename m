Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB133AB91B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhFQQMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:40 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:19479
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233993AbhFQQLe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUzTj5xhuLdvXwcR61eOBPPwSRPbGj1TX8CDycvkBMOaFqIsgVDhPEOg0jMSmN02303gNhvzO7NaajdW7cEARo2OnbMTw9TSHr9jbKnAvwYngrCQAJpSvE6jixkbVeT2CG4NM9Fkd3Tu70m998ETgh+kySTB9meQ2QDztiUpR+Gmw1bEufgU/x4QfRJMmLa1hS8m+EPCLElbYlgImCe0PD9Dkh2Rd/hxsrNrwa5Usvjv7nFtCW9NiOdnfi0C8J8pQ2DWPdOX5t5SHsK4Vk8qRik831Kbt4WZbOYmBBWzNrIOx3Tqq1F4w2UA9iNYfxClA5Tn1kl/OFPm4tc2WEUHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FZa+d2a3/gyptCAhogHqfIv6Zrlu51gHB8jZD8RDEQ=;
 b=FI51GCAlyBL3kNkhP0M56tjQ14QHROYXnmTq6Pi8bIs5rAOBgiHweJ/rYo5kznICv09dHOQNMdMaq6/Wgl+brs2L0OTqv6dM+SAXgJirasPcgKyquygh2JxLs2pH1bhDZx3YnktrOTiymGx7WFLMRxLAgdEhhKzvgeFOgCEfZ4GEydbnU2lv8EcLV/NMxaXvfpqhXFMd4zAvIzf0D3yoUt2riovnN31fpEx5Kzz+hTbHcWkebpKpwdn1GXlUm9bfkwJ1Wcar8UlhnEhVhhwidsOSF+T2ME2PLwcCwW/W+WEnZie6xMXgjDWlWKzhB2an99GGYfIJajQjiDX3Bw39Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FZa+d2a3/gyptCAhogHqfIv6Zrlu51gHB8jZD8RDEQ=;
 b=Pu6rUe0X4s4b6dlh8l5scm3rei8HO6AVbOMYYzuCa/1rPWPvTxFC6D1buEQZb/NSYkkT7Pzub3HoIds/Zgp+Qixl6smrWmrgUIhhvPnTfHWP1ciNYo6Ny5+HzowHzYKMBTFajVf5/CeXFvAuhBPYVO3216TovSRPHTw/tu5LWb8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:01 +0000
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
Subject: [RFC v1 238/256] cl8k: add vns.h
Date:   Thu, 17 Jun 2021 16:02:05 +0000
Message-Id: <20210617160223.160998-239-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53adad6-d31b-413d-26f4-08d931a9f001
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB051589EDE9C21EBDE1F11975F60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOF82/n+j1uvi6VFLJxQzC7Jy1Ps7TVyJDvg0E3qk6JWD1ZcSRQa+CilQnnCaUeTYnFNghnP3c+BWRl+RjNM6sIgLmywfL7akX147CzW27CFsTW7qfNPkEK3pWOOcAx5WlzUQbDxxCKc39zh9Q0lGeO290N5GsYa/kDmm+3XEOH1HQiEXSwev3d3Y03azk8tlIjxYRhAT8ztVOXrP4Tr6R07s/L1+cNFp9REEl4Do1aynzQTSBZwpEk5J2SdBo5eGRDLm4k5yWIsOVg5XPGOWDUkcmCy4iPdTHIu5dzQXoLYWNC8Su2RvS7aRLTLFRTyA9bFkYep6Yd9UuzDaCDIoEfHGfM74CjgEUQHjmhQjkODTWBum882E/Hi8bApyHcZr1JkE5M75UIDoNAsZYakWvHpplJtEwMXXlrYeiPHj9FuMEplwQIgG+oRDToLlw5ziMzWYT9UU2kpfmZzonC1ubRfxWotdzbs+jQKXMXnV8OGTfchNYq/lrKppb//cKMyZX0cK0KLLF7RSjOtPaffEWSfhkUdtyjaRLKji1Iv5Nc3jW0jwasfaXaGkiARbK4chSp1I401Wwdz3AnVHl4H5OrYMfdG1Ms+RdtNshuxfIcOBcGeQI9VkqI5VtAflm/I0rczEvo0BUWnUpMUp1gAPxlpqXWdRl3m64P6I50C/3y/edMylafQ2ysmWWzxvJEor+1NjXuH9d/Cr/6zSIihhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(6666004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?di5U7VlgP0ulO9U0JpNeG6fxEfM8HvwPoKGHSZzzpQ8MPK46o/+DRTQBNp3O?=
 =?us-ascii?Q?LhURs8oSsichEY0TsKpRITS7rfxMk8omPY+BMC8vR+wvkqogPNMSpxZDE6Ba?=
 =?us-ascii?Q?KCczpskQK7QHkb1tHvTnW3HrkwrAPV3RDJqYHPfAqOsq/ApWWHkLiXFn2PQp?=
 =?us-ascii?Q?Yrb+QqW1vawG+fZtN1cUWY/mXbxYuam7AABCgIDkfaEIhKw+EUO2xUWfQWqf?=
 =?us-ascii?Q?lill9x4IYjTkCZYpbqb3Fglo853taTmgNc/iKHMO0FMYmKNLniOkiVbYSv5q?=
 =?us-ascii?Q?3FKq/eEGE/WegUOBg2kQu4j2MgAPK0ebS1yn3LObC9AkARGBzwpooODaLbE0?=
 =?us-ascii?Q?aDu/xO+EmA+0IWqPOoqekgzuR7g0vzTwGWOARQULIJJEQpjZrrmm/ZPR6WEg?=
 =?us-ascii?Q?mgjtAM78JfcNnDsVSOzjVoynrQguICnTrpCDmnqhnxM13ktA6unJliP0YJQ7?=
 =?us-ascii?Q?yhdahxDfKS8M3sODHKoHHV1qtZdpAOU53iWTdW1rdn1JhMvHr/bLV7nY2Lw2?=
 =?us-ascii?Q?WgS224XjL6aTKdstcurZLPd5ipJrUv5HlYlnt1nZWCdP+ZrYkRrK+57+1gWS?=
 =?us-ascii?Q?qRbIbr7A2n6X5nBvXjAtRz6Qrlr+2oAuPxZAs8o0yzpROfGU3zB7SmLU2tbl?=
 =?us-ascii?Q?2SgjfGb6DAxMDe/1T92OpIPNZcTtXXpCQt7qp9zkQOoDFluMwVpOrwX7eOaD?=
 =?us-ascii?Q?D1+EVQ7cW82AsOdPbQWCtB02A/phjqwneowesqsmAd6u/2Fyf/QkqVWTBfTl?=
 =?us-ascii?Q?pXS9TEPUmScNAagQUX9qcoO29QFFkSSm2EcvPti8ZJnG46Pb4Yn4Ot1zBgUM?=
 =?us-ascii?Q?bmyBOGjYoCgs1go6oguh+Kpqkiq5vg+6OLFxaVDBYkv16k8bv+IwLUlXJyhy?=
 =?us-ascii?Q?OavgyIfIdPnY2U4aS3HKqEIWeAE4vVk97fn9YrueRVSf69d2b4oGDKZGNsa6?=
 =?us-ascii?Q?mBiM7NMhKmm3UZhm82C12fAqKm0sf67OGuivVSRFZNiZYbTfd3JuJl4hKYV4?=
 =?us-ascii?Q?SCO1r9UtGJ5ByJlinXkg8RJUjdvk5ZoYYNcCKqoV6g69m9r6UbxJa9FkhWtd?=
 =?us-ascii?Q?TraCgvYAEnxhKYSFwNQasI1pMDUicMAS9pxXiTVv9tSv6i75Usg1ETEqbzDe?=
 =?us-ascii?Q?/uOH4Ytn+aCa6z9+SY18ILtExUYRKfEZ9CtyZ057feAhxDdMGIlk3rde3ekI?=
 =?us-ascii?Q?fnFzbnvl2xUlGIUVHRRyQgot5Jd8lj15tpkk/ECSLFe++L/G94GjnfhHxeeN?=
 =?us-ascii?Q?IHLoO1FGBHRqs5GWqXvWY7tK7RbuEOmf/TGu2bjDYg/QydGWAeJ8GpArJeJw?=
 =?us-ascii?Q?sn3sGd7Y6bSQIlW5JwpIjNxq?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53adad6-d31b-413d-26f4-08d931a9f001
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:59.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJRKtwFy3LZb3Td/VUEjNDV1rUBrlpVygrnsprwQU730/Jx/FrDLNUc8br+Gx/AcoC10XSml91cUHPcn8J5gXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/vns.h | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.h

diff --git a/drivers/net/wireless/celeno/cl8k/vns.h b/drivers/net/wireless/=
celeno/cl8k/vns.h
new file mode 100644
index 000000000000..fc60ce275d52
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vns.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_VNS_H
+#define CL_VNS_H
+
+#include "hw.h"
+
+/**
+ * DOC: VNS (=3DVery Near STA)
+ *
+ * Feature is responsible for TX power adjustment regarding to the STA
+ * location. Near stations should get signal with lower power to avoid
+ * saturation. Power is contolled for both transmitted data (%VNS_MODE_DAT=
A)
+ * and autoresponse frames (%VNS_AUTO_REPLY), including both cases for
+ * connected and not connected stations.
+ *
+ * In order to determine, whether a station is in VNS range, we rely on th=
e
+ * RSSI values, received from the firmware for every RX frame.
+ */
+
+#define VNS_MODE_DATA       0x1
+#define VNS_MODE_AUTO_REPLY 0x2
+#define VNS_MODE_ALL        (VNS_MODE_DATA | VNS_MODE_AUTO_REPLY)
+
+void cl_vns_init(struct cl_hw *cl_hw);
+void cl_vns_close(struct cl_hw *cl_hw);
+void cl_vns_maintenance(struct cl_hw *cl_hw);
+void cl_vns_mgmt_handler(struct cl_hw *cl_hw, u8 *addr, s8 rssi[MAX_ANTENN=
AS]);
+bool cl_vns_is_very_near(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struc=
t sk_buff *skb);
+void cl_vns_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_vns_handle_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rss=
i[MAX_ANTENNAS]);
+void cl_vns_recovery(struct cl_hw *cl_hw);
+int cl_vns_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_VNS_H */
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

