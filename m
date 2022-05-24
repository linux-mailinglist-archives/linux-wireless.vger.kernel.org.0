Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7369532954
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiEXLjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiEXLja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:30 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0654AE15
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUKIV3Icd4ypfqNKSctQN27PgrBhVPKD9CGRGnfKUDIJTOaG+JZW9rDaipwWg8H0QsbYdSWuLJhPlJlFWeRCdC3xwcqtDZds6zAWFIJi8wxTrgyC57CH6yGeO2z4w762gQ+I4WzAVqV+y8da4vizdtyHvfiKr6qI/dA5DzyFxEzUBz/QPAaKv7CRFQF8WGWPgP3qoPwnKav+xWN2Ae8yY31Y3TE+FJkaC+QyrR8r/XIjQ/BdY7fhlnCaQbtqzmedM2AZUF6QfLg19wPQRKbu5Op2jssVdaE2fPdw9RsWzlGRkZMoxQD12o4S3lfaVIAvkvkIQPlzfhrgj0JteVOYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIEiirRArSQNK6MsWdZlaogtGlvImxIuKIviQB4lFEQ=;
 b=UDupZYWCjNr75CpOnMHQ2Iat83dKq3feKmOBIgfgYs7oDR2ZtRe80Rgv1gtkSCQ1+hDqDch3LudMQY/TL5Vqp1i8WckZR+qjoDfr/MIt1YJIGxcLFJWaj5M4Uuiq/YvtFXZ4qJnipKTUl0mlaJy4aSCCkgVita0HxPLzatNW2yMhCHgtrnSGUpbyvhzRrXeD9OuMI1Z/+O23nmm7wA0sU5ueJLM/s3A7rnvUdcLnQtL0cAKteJZZ2+N91uypW3cpiEIYpMoOSvj66VnGqGOy0Knsb1kGlaU6d4xT4Ep+3XCosKFXRI+TTqkwS1gXDOMdMcHncin4rPU3D9ZtsAlDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIEiirRArSQNK6MsWdZlaogtGlvImxIuKIviQB4lFEQ=;
 b=gp7B0ei+DriB3dOW4Q6mvVHnK0IpQB3bD6ez+DGUpUmmsImElXitaF77IdE1yK6aiS6Ih34krvRIeNNc6bQmpO6kNXfHohAzTeC++c2ICbgVC6AFb5hicGEXXL/WJgstEl8REfPcbssjh4j9u/wJV2JN4nv8YQOecZAb+7hGgyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:41 +0000
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
Subject: [RFC v2 38/96] cl8k: add mac80211.c
Date:   Tue, 24 May 2022 14:34:04 +0300
Message-Id: <20220524113502.1094459-39-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba3571b7-be4f-49c2-6866-08da3d79e222
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB03842EBF47C216202816DE7CF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L1SN/PmmjRB/N8OiPioPExEewqdmbfgOaTr2Vel7X5WP0YdTYiXGZjVeEOUmFYOj9CNTq9ZTuTidFfqDySPQp90AqJ8acS1Yr259bYFz7JaaRniBnCeGpl9mAx/JhoaTG5hWb2GZ0sJlVlJleQiRiHtqYzM9VoH5vvtMkhtoZuc5YDt2cdR0Pt329PGbVgJaZHLofFFaK2UgnHKlSqjgtp8fo+aXu7vE3/LXJ9ntw6hWXwTlmWpOyVnD6iK3PAyf7LqmXrcyYPiGKg2mda8IWNXaC/Dbph5mF+KZMgLdNLVEj23i2foant7kGQrBcmc9ge2Ljf1pirM/mGKMOKojhWhhcX19qdHM+SvnxTiaVv3todRMwC8R+ZiF86YJZlXkva/ElB9vnwQPnq901TBYyUdy60VlxwFKeM202iTxj2KsURvtAye/2h2LOQ6bQDMDGwdo6u2x8IhYNvzWjLOi3rO49VeNITrhc6TN7Riea0zadtXmHhCN/U88OceECZILYZvyeHfdAqECuiQo78nFZImfgrnMbhe4+vDr5OcNo4q9CO+2GucSgySLCbQPU+UhC+skbpCDZvLGLwyLtKZkGM3O0WfV4xB7UU7lfLy7qU/vmqyds5+GrTC1qatm+EVxG6AOs5KR2/IbZmykbaFuH5tivTG7csvtaa/ysAL8gGymc4JgPCOi2SGPgXvyLsHN6X9l+sAdB/hAmG4GrZfLw7CgqpSBmKHNy4bAfUXMI6KQOUOpGNRrtsrjPxgYqjd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(45080400002)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHCHRX4UgBYm9KGPK2oa+PcyJJS2Ez/Lq3I2jq/W5gaMp5CGYdgjFSkyaJfc?=
 =?us-ascii?Q?56YJAP2w11Mccpiw83MG7GnHqPetZdtsfsIP7INNxek9DnaS3Hby2QwV/2P6?=
 =?us-ascii?Q?AMvD0eFrTJ4wsPzt+ICFgtHBkPsLwtMqnXps7vR3sf7MBOG9+wc2i6uVvdbB?=
 =?us-ascii?Q?Vtp+hBinwthz1V0AflCAQbTsz5ytolD7nt2VimR0XWbrybl4XPBvtuyx34CM?=
 =?us-ascii?Q?M/dZpnWtRYDSAuHPR8PVZOKulqm2Jy6ebRliDKbRLAPMLCzVfcy0KY8EIVY2?=
 =?us-ascii?Q?L0c2Wt033liceKcWf++rBpz0A5io1isicb+6nhQ/tgelSwNVrzEzQ0vqyDkI?=
 =?us-ascii?Q?M7T9GtmBwYbSbpO8EBOCgkgdYcwFiqFNasFCBwah85yg5II3wFty0cWmT9DI?=
 =?us-ascii?Q?eELSvdOpAwRCLxnViIgMMVJzclupdKqhu4mlpd25yqQKO+q8kqyuzKPp628J?=
 =?us-ascii?Q?2T9OR3WCnDqPdbkp3c+ZZJlWn4OwqfOm8BOemcqvZn1naCTTLjaJ2Oh+71vz?=
 =?us-ascii?Q?FrWWstzymRsVHiZPR0PRGzH4uLJBpV4J4F3Zkp+X0w+7lKNz5bsdj05lD4X6?=
 =?us-ascii?Q?KqxGHLJCEgk+Ui64ATfEIVHyfv7ZUYsdsNmyI1g3CXoPZvtSIXSTk88UoomP?=
 =?us-ascii?Q?CM22kObePeaw6utHRJfoNFACKfvvTNsgR7P57y2J64YdKyvCE5W936syrgwZ?=
 =?us-ascii?Q?l9QZDHM/CgCWr+uNqJFupIoMQsGsNDY2ln50bNKJSdRvzy0BGzmsn0VUpzf+?=
 =?us-ascii?Q?Gga0bkJiSLES9RYzTmniGP31toOZ8CxkM2CUfPnWuavKlnrM4kMfzYAAFfyZ?=
 =?us-ascii?Q?gxAco79Frd/jTD7OGHlMYbqs5VIwmQ5waC22ljua2ILwcZL90dmqrjNyOS27?=
 =?us-ascii?Q?qcajA2x75gxbbqQSUVjbiKs8+47H/M1sumOIfA+nS7K8yy7if5c6elVM0wLD?=
 =?us-ascii?Q?K5s8tRsezzTcmfUhByOSazmYXIUSN3C3a8gzGIu0AtVwTbj9dRLp2uUJu2zi?=
 =?us-ascii?Q?sD5MHX8TVQEdsfrGfcXePm3Dw/udya/2nJsvyLRvtSuSAfFpPXcWwQFm4miS?=
 =?us-ascii?Q?CDfGxB1LuBD5eTsXqh4GbvCU06C5C89eWbe1jZCvgN7dqoUpE3VFDl3j/iWz?=
 =?us-ascii?Q?LI29O/cSAaC+mDSa5+Pas7aaxuvgfF052cCjnS1q8hbSxVzTub5xYu9FoFBw?=
 =?us-ascii?Q?a7TMlzoVjLJUXvwzf4N9UoFgZoFpbmlYxoaS1F4rgNbIUDLLh3Ym2p387Jjd?=
 =?us-ascii?Q?5G3gSXAWQRM+9hpZnNgnEzAsjPvh4ERvl8hPgrSjv5/An4Ru63W10P2wBMqi?=
 =?us-ascii?Q?RffAVGblF+7VDQirlj0K3+0T+aHeEFMbZdKnaNi+1vEDPxuvYcVptCkurleL?=
 =?us-ascii?Q?adtHcvhkiGdHHJyeUCZQEQv+RNyOHbJv3DenxdSsh5dv7k0kRuu1tsHisHSc?=
 =?us-ascii?Q?z7vID6KTtCnHKWZGBYT4nadDpsUygLp2oFdQXTchM9JWlKeFRvZ8Z+t+m0OI?=
 =?us-ascii?Q?ydj9qznN8cxZfMSs4u81iGuFeN6QNhfGiU+zamslr1vOAlSZoxgVScj1IWYx?=
 =?us-ascii?Q?ZZVRMVUMMxmWGpAAU7twjHjylGBx+ncqG5s5myQzWjA9FCqnPHEhled0jSJD?=
 =?us-ascii?Q?gc5XmxxpozKaGdoUkF2jRq0bvz+DAIFOtCC52vVndKcc6/bdaBQTtM8qK3HX?=
 =?us-ascii?Q?/TeAhPNPYOp6dA8WkWplAAPCxu3opUTLy22mX6JbwqSUw1M0dbxveMh8Keh0?=
 =?us-ascii?Q?ovrDFlnI7aDao1oTG7boIBybXkY7N/E=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3571b7-be4f-49c2-6866-08da3d79e222
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:12.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kOv6oWgUlHIqXgI25U5eIFMex1lMNyh2XSC8P2lqnhF2NxLTdQSIx/Y+ptBc78lB7zbXCFUOJQ7aVcnm6BEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/mac80211.c | 2392 +++++++++++++++++++
 1 file changed, 2392 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.c

diff --git a/drivers/net/wireless/celeno/cl8k/mac80211.c b/drivers/net/wireless/celeno/cl8k/mac80211.c
new file mode 100644
index 000000000000..13989327ccdb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac80211.c
@@ -0,0 +1,2392 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/log2.h>
+#include <net/mac80211.h>
+
+#include "debug.h"
+#include "utils.h"
+#include "sta.h"
+#include "dfs.h"
+#include "regdom.h"
+#include "hw.h"
+#include "mac80211.h"
+#include "ampdu.h"
+#include "tx.h"
+#include "radio.h"
+#include "recovery.h"
+#include "rates.h"
+#include "temperature.h"
+#include "vns.h"
+#include "key.h"
+#include "version.h"
+#include "power.h"
+#include "stats.h"
+#include "scan.h"
+#include "mac_addr.h"
+#include "chip.h"
+
+#define RATE_1_MBPS   10
+#define RATE_2_MBPS   20
+#define RATE_5_5_MBPS 55
+#define RATE_11_MBPS  110
+#define RATE_6_MBPS   60
+#define RATE_9_MBPS   90
+#define RATE_12_MBPS  120
+#define RATE_18_MBPS  180
+#define RATE_24_MBPS  240
+#define RATE_36_MBPS  360
+#define RATE_48_MBPS  480
+#define RATE_54_MBPS  540
+
+#define CL_HT_CAPABILITIES                                              \
+{                                                                       \
+	.ht_supported = true,                                           \
+	.cap = IEEE80211_HT_CAP_DSSSCCK40 | IEEE80211_HT_CAP_MAX_AMSDU, \
+	.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K,                     \
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_1,                   \
+	.mcs = {                                                        \
+		.rx_mask = { 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 },         \
+		.tx_params = IEEE80211_HT_MCS_TX_DEFINED,               \
+	},                                                              \
+}
+
+#define CL_VHT_CAPABILITIES                                             \
+{                                                                       \
+	.vht_supported = false,                                         \
+	.cap = 0,                                                       \
+	.vht_mcs = {                                                    \
+		.rx_mcs_map = cpu_to_le16(                              \
+				IEEE80211_VHT_MCS_SUPPORT_0_7   << 0  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 2  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 4  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 6  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 8  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 14), \
+		.tx_mcs_map = cpu_to_le16(                              \
+				IEEE80211_VHT_MCS_SUPPORT_0_7   << 0  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 2  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 4  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 6  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 8  | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 | \
+				IEEE80211_VHT_MCS_NOT_SUPPORTED << 14), \
+	}                                                               \
+}
+
+#define CL_HE_CAP_ELEM_STATION                                                       \
+{                                                                                    \
+	.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,                             \
+	.mac_cap_info[1] = 0,                                                        \
+	.mac_cap_info[2] = 0,                                                        \
+	.mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,            \
+	.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_BQR,                                \
+	.mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX,               \
+	.phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G, \
+	.phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,                     \
+	.phy_cap_info[2] = 0,                                                        \
+	.phy_cap_info[3] = 0,                                                        \
+	.phy_cap_info[4] = 0,                                                        \
+	.phy_cap_info[5] = 0,                                                        \
+	.phy_cap_info[6] = 0,                                                        \
+	.phy_cap_info[7] = 0,                                                        \
+	.phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G,       \
+	.phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,           \
+	.phy_cap_info[10] = 0,                                                       \
+}
+
+#define CL_HE_CAP_ELEM_AP                                                       \
+{                                                                               \
+	.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,                        \
+	.mac_cap_info[1] = 0,                                                   \
+	.mac_cap_info[2] = 0,                                                   \
+	.mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,       \
+	.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_BQR,                           \
+	.mac_cap_info[5] = 0,                                                   \
+	.phy_cap_info[0] = 0,                                                   \
+	.phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,                \
+	.phy_cap_info[2] = 0,                                                   \
+	.phy_cap_info[3] = 0,                                                   \
+	.phy_cap_info[4] = 0,                                                   \
+	.phy_cap_info[5] = 0,                                                   \
+	.phy_cap_info[6] = 0,                                                   \
+	.phy_cap_info[7] = 0,                                                   \
+	.phy_cap_info[8] = 0,                                                   \
+	.phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,      \
+	.phy_cap_info[10] = 0,                                                  \
+}
+
+#define CL_HE_CAP_ELEM_MESH_POINT                                               \
+{                                                                               \
+	.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,                        \
+	.mac_cap_info[1] = 0,                                                   \
+	.mac_cap_info[2] = 0,                                                   \
+	.mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,       \
+	.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_BQR,                           \
+	.mac_cap_info[5] = 0,                                                   \
+	.phy_cap_info[0] = 0,                                                   \
+	.phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,                \
+	.phy_cap_info[2] = 0,                                                   \
+	.phy_cap_info[3] = 0,                                                   \
+	.phy_cap_info[4] = 0,                                                   \
+	.phy_cap_info[5] = 0,                                                   \
+	.phy_cap_info[6] = 0,                                                   \
+	.phy_cap_info[7] = 0,                                                   \
+	.phy_cap_info[8] = 0,                                                   \
+	.phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,      \
+	.phy_cap_info[10] = 0,                                                  \
+}
+
+#define CL_HE_MCS_NSS_SUPP                   \
+{                                            \
+	.rx_mcs_80 = cpu_to_le16(0xff00),    \
+	.tx_mcs_80 = cpu_to_le16(0xff00),    \
+	.rx_mcs_160 = cpu_to_le16(0xff00),   \
+	.tx_mcs_160 = cpu_to_le16(0xff00),   \
+	.rx_mcs_80p80 = cpu_to_le16(0xffff), \
+	.tx_mcs_80p80 = cpu_to_le16(0xffff), \
+}
+
+#define RATE(_bitrate, _hw_rate, _flags) { \
+	.bitrate = (_bitrate),             \
+	.flags = (_flags),                 \
+	.hw_value = (_hw_rate),            \
+}
+
+#define CHAN(_freq, _idx) {     \
+	.center_freq = (_freq), \
+	.hw_value = (_idx),     \
+	.max_power = 18,        \
+}
+
+static struct ieee80211_sband_iftype_data cl_he_data[] = {
+	{
+		.types_mask = BIT(NL80211_IFTYPE_STATION),
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = CL_HE_CAP_ELEM_STATION,
+			.he_mcs_nss_supp = CL_HE_MCS_NSS_SUPP,
+		},
+	},
+	{
+		.types_mask = BIT(NL80211_IFTYPE_AP),
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = CL_HE_CAP_ELEM_AP,
+			.he_mcs_nss_supp = CL_HE_MCS_NSS_SUPP,
+		},
+	},
+	{
+		.types_mask = BIT(NL80211_IFTYPE_MESH_POINT),
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = CL_HE_CAP_ELEM_MESH_POINT,
+			.he_mcs_nss_supp = CL_HE_MCS_NSS_SUPP,
+		},
+	},
+};
+
+static struct ieee80211_rate cl_ratetable[] = {
+	RATE(10,  0x00, 0),
+	RATE(20,  0x01, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(55,  0x02, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(110, 0x03, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(60,  0x04, 0),
+	RATE(90,  0x05, 0),
+	RATE(120, 0x06, 0),
+	RATE(180, 0x07, 0),
+	RATE(240, 0x08, 0),
+	RATE(360, 0x09, 0),
+	RATE(480, 0x0A, 0),
+	RATE(540, 0x0B, 0),
+};
+
+/* The channels indexes here are not used anymore */
+static struct ieee80211_channel cl_2ghz_channels[] = {
+	CHAN(2412, 0),
+	CHAN(2417, 1),
+	CHAN(2422, 2),
+	CHAN(2427, 3),
+	CHAN(2432, 4),
+	CHAN(2437, 5),
+	CHAN(2442, 6),
+	CHAN(2447, 7),
+	CHAN(2452, 8),
+	CHAN(2457, 9),
+	CHAN(2462, 10),
+	CHAN(2467, 11),
+	CHAN(2472, 12),
+	CHAN(2484, 13),
+};
+
+static struct ieee80211_channel cl_5ghz_channels[] = {
+	CHAN(5180, 0),  /* 36 -  20MHz */
+	CHAN(5200, 1),  /* 40 -  20MHz */
+	CHAN(5220, 2),  /* 44 -  20MHz */
+	CHAN(5240, 3),  /* 48 -  20MHz */
+	CHAN(5260, 4),  /* 52 -  20MHz */
+	CHAN(5280, 5),  /* 56 -  20MHz */
+	CHAN(5300, 6),  /* 60 -  20MHz */
+	CHAN(5320, 7),  /* 64 -  20MHz */
+	CHAN(5500, 8),  /* 100 - 20MHz */
+	CHAN(5520, 9),  /* 104 - 20MHz */
+	CHAN(5540, 10), /* 108 - 20MHz */
+	CHAN(5560, 11), /* 112 - 20MHz */
+	CHAN(5580, 12), /* 116 - 20MHz */
+	CHAN(5600, 13), /* 120 - 20MHz */
+	CHAN(5620, 14), /* 124 - 20MHz */
+	CHAN(5640, 15), /* 128 - 20MHz */
+	CHAN(5660, 16), /* 132 - 20MHz */
+	CHAN(5680, 17), /* 136 - 20MHz */
+	CHAN(5700, 18), /* 140 - 20MHz */
+	CHAN(5720, 19), /* 144 - 20MHz */
+	CHAN(5745, 20), /* 149 - 20MHz */
+	CHAN(5765, 21), /* 153 - 20MHz */
+	CHAN(5785, 22), /* 157 - 20MHz */
+	CHAN(5805, 23), /* 161 - 20MHz */
+	CHAN(5825, 24), /* 165 - 20MHz */
+};
+
+static struct ieee80211_channel cl_6ghz_channels[] = {
+	CHAN(5955, 1),  /* 1 - 20MHz */
+	CHAN(5935, 2),  /* 2 - 20MHz */
+	CHAN(5975, 5),  /* 5 - 20MHz */
+	CHAN(5995, 9),  /* 9 - 20MHz */
+	CHAN(6015, 13),  /* 13 - 20MHz */
+	CHAN(6035, 17),  /* 17 - 20MHz */
+	CHAN(6055, 21),  /* 21 - 20MHz */
+	CHAN(6075, 25),  /* 25 - 20MHz */
+	CHAN(6095, 29),  /* 29 - 20MHz */
+	CHAN(6115, 33),  /* 33 - 20MHz */
+	CHAN(6135, 37),  /* 37 - 20MHz */
+	CHAN(6155, 41),  /* 41 - 20MHz */
+	CHAN(6175, 45),  /* 45 - 20MHz */
+	CHAN(6195, 49),  /* 49 - 20MHz */
+	CHAN(6215, 53),  /* 53 - 20MHz */
+	CHAN(6235, 57),  /* 57 - 20MHz */
+	CHAN(6255, 61),  /* 61 - 20MHz */
+	CHAN(6275, 65),  /* 65 - 20MHz */
+	CHAN(6295, 69),  /* 69 - 20MHz */
+	CHAN(6315, 73),  /* 73 - 20MHz */
+	CHAN(6335, 77),  /* 77 - 20MHz */
+	CHAN(6355, 81),  /* 81 - 20MHz */
+	CHAN(6375, 85),  /* 85 - 20MHz */
+	CHAN(6395, 89),  /* 89 - 20MHz */
+	CHAN(6415, 93),  /* 93 - 20MHz */
+	CHAN(6435, 97),  /* 97 - 20MHz */
+	CHAN(6455, 101),  /* 101 - 20MHz */
+	CHAN(6475, 105),  /* 105 - 20MHz */
+	CHAN(6495, 109),  /* 109 - 20MHz */
+	CHAN(6515, 113),  /* 113 - 20MHz */
+	CHAN(6535, 117),  /* 117 - 20MHz */
+	CHAN(6555, 121),  /* 121 - 20MHz */
+	CHAN(6575, 125),  /* 125 - 20MHz */
+	CHAN(6595, 129),  /* 129 - 20MHz */
+	CHAN(6615, 133),  /* 133 - 20MHz */
+	CHAN(6635, 137),  /* 137 - 20MHz */
+	CHAN(6655, 141),  /* 141 - 20MHz */
+	CHAN(6675, 145),  /* 145 - 20MHz */
+	CHAN(6695, 149),  /* 149 - 20MHz */
+	CHAN(6715, 153),  /* 153 - 20MHz */
+	CHAN(6735, 157),  /* 157 - 20MHz */
+	CHAN(6755, 161),  /* 161 - 20MHz */
+	CHAN(6775, 165),  /* 165 - 20MHz */
+	CHAN(6795, 169),  /* 169 - 20MHz */
+	CHAN(6815, 173),  /* 173 - 20MHz */
+	CHAN(6835, 177),  /* 177 - 20MHz */
+	CHAN(6855, 181),  /* 181 - 20MHz */
+	CHAN(6875, 188),  /* 185 - 20MHz */
+	CHAN(6895, 189),  /* 189 - 20MHz */
+	CHAN(6915, 193),  /* 193 - 20MHz */
+	CHAN(6935, 197),  /* 197 - 20MHz */
+	CHAN(6955, 201),  /* 201 - 20MHz */
+	CHAN(6975, 205),  /* 205 - 20MHz */
+	CHAN(6995, 209),  /* 209 - 20MHz */
+	CHAN(7015, 213),  /* 213 - 20MHz */
+	CHAN(7035, 217),  /* 217 - 20MHz */
+	CHAN(7055, 221),  /* 221 - 20MHz */
+	CHAN(7075, 225),  /* 225 - 20MHz */
+	CHAN(7095, 229),  /* 229 - 20MHz */
+	CHAN(7115, 233),  /* 233 - 20MHz */
+};
+
+static struct ieee80211_supported_band cl_band_2ghz = {
+	.channels   = cl_2ghz_channels,
+	.n_channels = ARRAY_SIZE(cl_2ghz_channels),
+	.bitrates   = cl_ratetable,
+	.n_bitrates = ARRAY_SIZE(cl_ratetable),
+	.ht_cap     = CL_HT_CAPABILITIES,
+	.vht_cap    = CL_VHT_CAPABILITIES,
+};
+
+static struct ieee80211_supported_band cl_band_5ghz = {
+	.channels   = cl_5ghz_channels,
+	.n_channels = ARRAY_SIZE(cl_5ghz_channels),
+	.bitrates   = &cl_ratetable[4],
+	.n_bitrates = ARRAY_SIZE(cl_ratetable) - 4,
+	.ht_cap     = CL_HT_CAPABILITIES,
+	.vht_cap    = CL_VHT_CAPABILITIES,
+};
+
+static struct ieee80211_supported_band cl_band_6ghz = {
+	.channels   = cl_6ghz_channels,
+	.n_channels = ARRAY_SIZE(cl_6ghz_channels),
+	.bitrates   = &cl_ratetable[4],
+	.n_bitrates = ARRAY_SIZE(cl_ratetable) - 4,
+};
+
+static const struct ieee80211_iface_limit cl_limits[] = {
+	{
+		.max   = ARRAY_SIZE(((struct cl_hw *)0)->addresses),
+		.types = BIT(NL80211_IFTYPE_AP) |
+			 BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_MESH_POINT),
+	},
+};
+
+#define WLAN_EXT_CAPA1_2040_BSS_COEX_MGMT_ENABLED BIT(0)
+
+static u8 cl_if_types_ext_capa_ap_24g[] = {
+	[0]  = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[7]  = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+};
+
+static const struct wiphy_iftype_ext_capab cl_iftypes_ext_capa_24g[] = {
+	{
+		.iftype = NL80211_IFTYPE_AP,
+		.extended_capabilities = cl_if_types_ext_capa_ap_24g,
+		.extended_capabilities_mask = cl_if_types_ext_capa_ap_24g,
+		.extended_capabilities_len = sizeof(cl_if_types_ext_capa_ap_24g),
+	},
+};
+
+static u8 cl_if_types_ext_capa_ap_5g[] = {
+	[0]  = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[7]  = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+};
+
+static const struct wiphy_iftype_ext_capab cl_iftypes_ext_capa_5g[] = {
+	{
+		.iftype = NL80211_IFTYPE_AP,
+		.extended_capabilities = cl_if_types_ext_capa_ap_5g,
+		.extended_capabilities_mask = cl_if_types_ext_capa_ap_5g,
+		.extended_capabilities_len = sizeof(cl_if_types_ext_capa_ap_5g),
+	},
+};
+
+static u8 cl_if_types_ext_capa_ap_6g[] = {
+	[0]  = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[7]  = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+};
+
+static const struct wiphy_iftype_ext_capab cl_iftypes_ext_capa_6g[] = {
+	{
+		.iftype = NL80211_IFTYPE_AP,
+		.extended_capabilities = cl_if_types_ext_capa_ap_6g,
+		.extended_capabilities_mask = cl_if_types_ext_capa_ap_6g,
+		.extended_capabilities_len = sizeof(cl_if_types_ext_capa_ap_6g),
+	},
+};
+
+static struct ieee80211_iface_combination cl_combinations[] = {
+	{
+		.limits = cl_limits,
+		.n_limits = ARRAY_SIZE(cl_limits),
+		.num_different_channels = 1,
+		.max_interfaces = ARRAY_SIZE(((struct cl_hw *)0)->addresses),
+		.beacon_int_min_gcd = 100,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160),
+	}
+};
+
+static const int cl_ac2hwq[AC_MAX] = {
+	[NL80211_TXQ_Q_VO] = CL_HWQ_VO,
+	[NL80211_TXQ_Q_VI] = CL_HWQ_VI,
+	[NL80211_TXQ_Q_BE] = CL_HWQ_BE,
+	[NL80211_TXQ_Q_BK] = CL_HWQ_BK
+};
+
+static const int cl_ac2edca[AC_MAX] = {
+	[NL80211_TXQ_Q_VO] = EDCA_AC_VO,
+	[NL80211_TXQ_Q_VI] = EDCA_AC_VI,
+	[NL80211_TXQ_Q_BE] = EDCA_AC_BE,
+	[NL80211_TXQ_Q_BK] = EDCA_AC_BK
+};
+
+static u8 cl_he_mcs_supp_tx(struct cl_hw *cl_hw, u8 nss)
+{
+	u8 mcs = cl_hw->conf->ce_he_mcs_nss_supp_tx[nss];
+
+	switch (mcs) {
+	case WRS_MCS_7:
+		return IEEE80211_HE_MCS_SUPPORT_0_7;
+	case WRS_MCS_9:
+		return IEEE80211_HE_MCS_SUPPORT_0_9;
+	case WRS_MCS_11:
+		return IEEE80211_HE_MCS_SUPPORT_0_11;
+	}
+
+	cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7, 9 or 11!\n", mcs, nss);
+	return IEEE80211_HE_MCS_NOT_SUPPORTED;
+}
+
+static u8 cl_he_mcs_supp_rx(struct cl_hw *cl_hw, u8 nss)
+{
+	u8 mcs = cl_hw->conf->ce_he_mcs_nss_supp_rx[nss];
+
+	switch (mcs) {
+	case WRS_MCS_7:
+		return IEEE80211_HE_MCS_SUPPORT_0_7;
+	case WRS_MCS_9:
+		return IEEE80211_HE_MCS_SUPPORT_0_9;
+	case WRS_MCS_11:
+		return IEEE80211_HE_MCS_SUPPORT_0_11;
+	}
+
+	cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7, 9 or 11!\n", mcs, nss);
+	return IEEE80211_HE_MCS_NOT_SUPPORTED;
+}
+
+static u8 cl_vht_mcs_supp_tx(struct cl_hw *cl_hw, u8 nss)
+{
+	u8 mcs = cl_hw->conf->ce_vht_mcs_nss_supp_tx[nss];
+
+	switch (mcs) {
+	case WRS_MCS_7:
+		return IEEE80211_VHT_MCS_SUPPORT_0_7;
+	case WRS_MCS_8:
+		return IEEE80211_VHT_MCS_SUPPORT_0_8;
+	case WRS_MCS_9:
+		return IEEE80211_VHT_MCS_SUPPORT_0_9;
+	}
+
+	cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7-9!\n", mcs, nss);
+	return IEEE80211_VHT_MCS_NOT_SUPPORTED;
+}
+
+static u8 cl_vht_mcs_supp_rx(struct cl_hw *cl_hw, u8 nss)
+{
+	u8 mcs = cl_hw->conf->ce_vht_mcs_nss_supp_rx[nss];
+
+	switch (mcs) {
+	case WRS_MCS_7:
+		return IEEE80211_VHT_MCS_SUPPORT_0_7;
+	case WRS_MCS_8:
+		return IEEE80211_VHT_MCS_SUPPORT_0_8;
+	case WRS_MCS_9:
+		return IEEE80211_VHT_MCS_SUPPORT_0_9;
+	}
+
+	cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7-9!\n", mcs, nss);
+	return IEEE80211_VHT_MCS_NOT_SUPPORTED;
+}
+
+static void cl_set_he_6ghz_capab(struct cl_hw *cl_hw)
+{
+	struct ieee80211_he_6ghz_capa *he_6ghz_cap0 = &cl_hw->iftype_data[0].he_6ghz_capa;
+	struct ieee80211_he_6ghz_capa *he_6ghz_cap1 = &cl_hw->iftype_data[1].he_6ghz_capa;
+	struct ieee80211_he_6ghz_capa *he_6ghz_cap2 = &cl_hw->iftype_data[2].he_6ghz_capa;
+
+	he_6ghz_cap0->capa = cpu_to_le16(IEEE80211_HT_MPDU_DENSITY_1);
+
+	he_6ghz_cap0->capa |=
+		cpu_to_le16(cl_hw->conf->ci_max_mpdu_len << HE_6GHZ_CAP_MAX_MPDU_LEN_OFFSET);
+	he_6ghz_cap0->capa |=
+		cpu_to_le16(IEEE80211_VHT_MAX_AMPDU_1024K << HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET);
+
+	he_6ghz_cap0->capa |= cpu_to_le16(IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS |
+					  IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS);
+
+	he_6ghz_cap1->capa = he_6ghz_cap0->capa;
+	he_6ghz_cap2->capa = he_6ghz_cap0->capa;
+}
+
+static void _cl_set_he_capab(struct cl_hw *cl_hw, u8 idx)
+{
+	struct ieee80211_sta_he_cap *he_cap = &cl_hw->iftype_data[idx].he_cap;
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp = &he_cap->he_mcs_nss_supp;
+	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
+	u8 rx_nss = cl_hw->conf->ce_rx_nss;
+	u8 tx_nss = cl_hw->conf->ce_tx_nss;
+	int i = 0;
+
+	if (BAND_IS_5G_6G(cl_hw)) {
+		he_cap_elem->phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+		for (i = 0; i < rx_nss; i++)
+			he_mcs_nss_supp->rx_mcs_160 |=
+				cpu_to_le16(cl_he_mcs_supp_rx(cl_hw, i) << (i * 2));
+
+		for (i = 0; i < tx_nss; i++)
+			he_mcs_nss_supp->tx_mcs_160 |=
+				cpu_to_le16(cl_he_mcs_supp_tx(cl_hw, i) << (i * 2));
+
+		he_cap_elem->phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+
+		for (i = 0; i < rx_nss; i++)
+			he_mcs_nss_supp->rx_mcs_80 |=
+				cpu_to_le16(cl_he_mcs_supp_rx(cl_hw, i) << (i * 2));
+
+		for (i = 0; i < tx_nss; i++)
+			he_mcs_nss_supp->tx_mcs_80 |=
+				cpu_to_le16(cl_he_mcs_supp_tx(cl_hw, i) << (i * 2));
+	} else {
+		he_cap_elem->phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+
+		for (i = 0; i < rx_nss; i++)
+			he_mcs_nss_supp->rx_mcs_80 |=
+				cpu_to_le16(cl_he_mcs_supp_rx(cl_hw, i) << (i * 2));
+
+		for (i = 0; i < tx_nss; i++)
+			he_mcs_nss_supp->tx_mcs_80 |=
+				cpu_to_le16(cl_he_mcs_supp_tx(cl_hw, i) << (i * 2));
+	}
+
+	for (i = rx_nss; i < 8; i++) {
+		he_mcs_nss_supp->rx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_mcs_nss_supp->rx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = tx_nss; i < 8; i++) {
+		he_mcs_nss_supp->tx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_mcs_nss_supp->tx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	if (cl_hw->conf->ci_he_rxldpc_en)
+		he_cap_elem->phy_cap_info[1] |=
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+
+	if (cl_hw->conf->ci_rx_he_mu_ppdu)
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
+
+	if (cl_hw->conf->ci_bf_en) {
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+		he_cap_elem->phy_cap_info[5] |=
+			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_4;
+	}
+}
+
+static void cl_set_he_capab(struct cl_hw *cl_hw)
+{
+	struct ieee80211_sta_he_cap *he_cap0 = &cl_hw->iftype_data[0].he_cap;
+	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap0->he_cap_elem;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	u8 tf_mac_pad_dur = conf->ci_tf_mac_pad_dur;
+
+	memcpy(&cl_hw->iftype_data, cl_he_data, sizeof(cl_hw->iftype_data));
+
+	if (tf_mac_pad_dur == 1)
+		he_cap_elem->mac_cap_info[1] |= IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_8US;
+	else if (tf_mac_pad_dur == 2)
+		he_cap_elem->mac_cap_info[1] |= IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+	_cl_set_he_capab(cl_hw, 0);
+	_cl_set_he_capab(cl_hw, 1);
+	_cl_set_he_capab(cl_hw, 2);
+
+	if (cl_band_is_6g(cl_hw))
+		cl_set_he_6ghz_capab(cl_hw);
+
+	cl_hw->sband.n_iftype_data = ARRAY_SIZE(cl_he_data);
+	cl_hw->sband.iftype_data = cl_hw->iftype_data;
+}
+
+#define RATE_1_MBPS   10
+#define RATE_2_MBPS   20
+#define RATE_5_5_MBPS 55
+#define RATE_11_MBPS  110
+#define RATE_6_MBPS   60
+#define RATE_9_MBPS   90
+#define RATE_12_MBPS  120
+#define RATE_18_MBPS  180
+#define RATE_24_MBPS  240
+#define RATE_36_MBPS  360
+#define RATE_48_MBPS  480
+#define RATE_54_MBPS  540
+
+static u16 cl_cap_convert_rate_to_bitmap(u16 rate)
+{
+	switch (rate) {
+	case RATE_1_MBPS:
+		return BIT(0);
+	case RATE_2_MBPS:
+		return BIT(1);
+	case RATE_5_5_MBPS:
+		return BIT(2);
+	case RATE_11_MBPS:
+		return BIT(3);
+	case RATE_6_MBPS:
+		return BIT(4);
+	case RATE_9_MBPS:
+		return BIT(5);
+	case RATE_12_MBPS:
+		return BIT(6);
+	case RATE_18_MBPS:
+		return BIT(7);
+	case RATE_24_MBPS:
+		return BIT(8);
+	case RATE_36_MBPS:
+		return BIT(9);
+	case RATE_48_MBPS:
+		return BIT(10);
+	case RATE_54_MBPS:
+		return BIT(11);
+	default:
+		return 0;
+	}
+}
+
+u16 cl_cap_set_mesh_basic_rates(struct cl_hw *cl_hw)
+{
+	int i;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	u16 basic_rates = 0;
+
+	for (i = 0; i < MESH_BASIC_RATE_MAX; i++)
+		basic_rates |= cl_cap_convert_rate_to_bitmap(conf->ci_mesh_basic_rates[i]);
+
+	return basic_rates;
+}
+
+void cl_cap_dyn_params(struct cl_hw *cl_hw)
+{
+	struct ieee80211_hw *hw = cl_hw->hw;
+	struct wiphy *wiphy = hw->wiphy;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	u8 rx_nss = conf->ce_rx_nss;
+	u8 tx_nss = conf->ce_tx_nss;
+	u8 guard_interval = conf->ci_short_guard_interval;
+	u8 i;
+	u8 bw = cl_hw->conf->ci_cap_bandwidth;
+	struct ieee80211_supported_band *sband = &cl_hw->sband;
+	struct ieee80211_sta_ht_cap *sband_ht_cap = &sband->ht_cap;
+	struct ieee80211_sta_vht_cap *sband_vht_cap = &sband->vht_cap;
+
+	if (cl_band_is_6g(cl_hw)) {
+		memcpy(sband, &cl_band_6ghz, sizeof(struct ieee80211_supported_band));
+	} else if (cl_band_is_5g(cl_hw)) {
+		memcpy(sband, &cl_band_5ghz, sizeof(struct ieee80211_supported_band));
+	} else {
+		memcpy(sband, &cl_band_2ghz, sizeof(struct ieee80211_supported_band));
+
+		if (!conf->ci_vht_cap_24g)
+			memset(&sband->vht_cap, 0, sizeof(struct ieee80211_sta_vht_cap));
+	}
+
+	/* 6GHz doesn't support HT/VHT */
+	if (!cl_band_is_6g(cl_hw)) {
+		if (bw > CHNL_BW_20)
+			sband_ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+
+		/* Guard_interval */
+		if (guard_interval) {
+			sband_ht_cap->cap |= IEEE80211_HT_CAP_SGI_20;
+
+			if (bw >= CHNL_BW_40)
+				sband_ht_cap->cap |= IEEE80211_HT_CAP_SGI_40;
+
+			if (bw >= CHNL_BW_80)
+				sband_vht_cap->cap |= IEEE80211_VHT_CAP_SHORT_GI_80;
+
+			if (bw == CHNL_BW_160)
+				sband_vht_cap->cap |= IEEE80211_VHT_CAP_SHORT_GI_160;
+		}
+	}
+
+	/* Amsdu */
+	cl_rx_amsdu_hw_en(hw, conf->ce_rxamsdu_en);
+	cl_hw->txamsdu_en = conf->ce_txamsdu_en;
+
+	/* Hw flags */
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, QUEUE_CONTROL);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SPECTRUM_MGMT);
+	ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
+	ieee80211_hw_set(hw, NO_AUTO_VIF);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, SUPPORTS_PER_STA_GTK);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+
+	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE;
+	wiphy->features |= NL80211_FEATURE_AP_SCAN;
+	wiphy->available_antennas_tx = ANT_MASK(cl_hw->max_antennas);
+	wiphy->available_antennas_rx = ANT_MASK(cl_hw->max_antennas);
+
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+
+	if (conf->ci_fast_rx_en) {
+		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
+		ieee80211_hw_set(hw, AP_LINK_PS);
+	}
+
+	if (cl_band_is_6g(cl_hw)) {
+		hw->wiphy->iftype_ext_capab = cl_iftypes_ext_capa_6g;
+		hw->wiphy->num_iftype_ext_capab = ARRAY_SIZE(cl_iftypes_ext_capa_6g);
+	} else if (cl_band_is_5g(cl_hw)) {
+		hw->wiphy->iftype_ext_capab = cl_iftypes_ext_capa_5g;
+		hw->wiphy->num_iftype_ext_capab = ARRAY_SIZE(cl_iftypes_ext_capa_5g);
+	} else if (cl_band_is_24g(cl_hw)) {
+		/* Turn on "20/40 Coex Mgmt Support" bit (24g only) */
+		if (conf->ce_acs_coex_en) {
+			u8 *ext_cap = (u8 *)cl_iftypes_ext_capa_24g[0].extended_capabilities;
+
+			ext_cap[0] |= WLAN_EXT_CAPA1_2040_BSS_COEX_MGMT_ENABLED;
+		}
+
+		hw->wiphy->iftype_ext_capab = cl_iftypes_ext_capa_24g;
+		hw->wiphy->num_iftype_ext_capab = ARRAY_SIZE(cl_iftypes_ext_capa_24g);
+	}
+
+	/*
+	 * To disable the dynamic PS we say to the stack that we support it in
+	 * HW. This will force mac80211 rely on us to handle this.
+	 */
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+
+	if (conf->ci_agg_tx)
+		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				 BIT(NL80211_IFTYPE_AP) |
+				 BIT(NL80211_IFTYPE_MESH_POINT);
+
+	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
+			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_IBSS_RSN;
+
+	if (conf->ci_uapsd_en)
+		wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
+
+	/* Modify MAX BSS num according to the desired config value */
+	for (i = 0; i < ARRAY_SIZE(cl_combinations); i++)
+		cl_combinations[i].max_interfaces = conf->ci_max_bss_num;
+	wiphy->iface_combinations = cl_combinations;
+	wiphy->n_iface_combinations = ARRAY_SIZE(cl_combinations);
+
+	/*
+	 * hw_scan ops may ask driver to forge active scan request. So the
+	 * scan capabs are filled in (the are same as inside mac80211).
+	 * However, they are not representing real hw_scan logic, since it will
+	 * fallback to the sw_scan for active scan request.
+	 **/
+	wiphy->max_scan_ssids = 4;
+	wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+
+	hw->max_rates = IEEE80211_TX_MAX_RATES;
+	hw->max_report_rates = IEEE80211_TX_MAX_RATES;
+	hw->max_rate_tries = 1;
+
+	hw->max_tx_aggregation_subframes = conf->ce_max_agg_size_tx;
+	hw->max_rx_aggregation_subframes = conf->ce_max_agg_size_rx;
+
+	hw->vif_data_size = sizeof(struct cl_vif);
+	hw->sta_data_size = sizeof(struct cl_sta);
+
+	hw->extra_tx_headroom = 0;
+	hw->queues = IEEE80211_MAX_QUEUES;
+	hw->offchannel_tx_hw_queue = CL_HWQ_VO;
+
+	if (!cl_band_is_6g(cl_hw)) {
+		if (conf->ci_ht_rxldpc_en)
+			sband_ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+
+		sband_ht_cap->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
+
+		sband_vht_cap->cap |= cl_hw->conf->ci_max_mpdu_len;
+		if (conf->ci_bf_en) {
+			sband_vht_cap->cap |=
+				IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
+				IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+				(3 << IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT) |
+				(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+		}
+	}
+
+	if (cl_band_is_5g(cl_hw) || (cl_band_is_24g(cl_hw) && conf->ci_vht_cap_24g)) {
+		if (bw == CHNL_BW_160)
+			sband_vht_cap->cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
+
+		sband_vht_cap->cap |= (conf->ci_max_ampdu_len_exp <<
+				       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
+
+		if (conf->ci_vht_rxldpc_en)
+			sband_vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
+
+		sband_vht_cap->cap |= IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN;
+		sband_vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
+
+		sband_vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(0);
+		sband_vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(0);
+
+		for (i = 0; i < rx_nss; i++)
+			sband_vht_cap->vht_mcs.rx_mcs_map |=
+				cpu_to_le16(cl_vht_mcs_supp_rx(cl_hw, i) << (i * 2));
+
+		for (; i < 8; i++)
+			sband_vht_cap->vht_mcs.rx_mcs_map |=
+				cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
+
+		for (i = 0; i < tx_nss; i++)
+			sband_vht_cap->vht_mcs.tx_mcs_map |=
+				cpu_to_le16(cl_vht_mcs_supp_tx(cl_hw, i) << (i * 2));
+
+		for (; i < 8; i++)
+			sband_vht_cap->vht_mcs.tx_mcs_map |=
+				cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
+
+		sband_vht_cap->vht_supported = true;
+	}
+
+	/* 6GHz band supports HE only */
+	if (!cl_band_is_6g(cl_hw))
+		for (i = 0; i < rx_nss; i++)
+			sband_ht_cap->mcs.rx_mask[i] = U8_MAX;
+
+	cl_set_he_capab(cl_hw);
+
+	/* Get channels and power limitations information from ChannelInfo file */
+	cl_chan_info_init(cl_hw);
+
+	if (cl_band_is_6g(cl_hw)) {
+		wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+		wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+		wiphy->bands[NL80211_BAND_6GHZ] = sband;
+	} else if (cl_band_is_5g(cl_hw)) {
+		wiphy->bands[NL80211_BAND_2GHZ] = NULL;
+		wiphy->bands[NL80211_BAND_5GHZ] = sband;
+		wiphy->bands[NL80211_BAND_6GHZ] = NULL;
+	} else {
+		wiphy->bands[NL80211_BAND_2GHZ] = sband;
+		wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+		wiphy->bands[NL80211_BAND_6GHZ] = NULL;
+	}
+}
+
+enum he_pkt_ext_constellations {
+	HE_PKT_EXT_BPSK = 0,
+	HE_PKT_EXT_QPSK,
+	HE_PKT_EXT_16QAM,
+	HE_PKT_EXT_64QAM,
+	HE_PKT_EXT_256QAM,
+	HE_PKT_EXT_1024QAM,
+	HE_PKT_EXT_RESERVED,
+	HE_PKT_EXT_NONE,
+};
+
+static u8 mcs_to_constellation[WRS_MCS_MAX_HE] = {
+	HE_PKT_EXT_BPSK,
+	HE_PKT_EXT_QPSK,
+	HE_PKT_EXT_QPSK,
+	HE_PKT_EXT_16QAM,
+	HE_PKT_EXT_16QAM,
+	HE_PKT_EXT_64QAM,
+	HE_PKT_EXT_64QAM,
+	HE_PKT_EXT_64QAM,
+	HE_PKT_EXT_256QAM,
+	HE_PKT_EXT_256QAM,
+	HE_PKT_EXT_1024QAM,
+	HE_PKT_EXT_1024QAM
+};
+
+#define QAM_THR_1 0
+#define QAM_THR_2 1
+#define QAM_THR_MAX 2
+
+static u8 cl_get_ppe_val(u8 *ppe, u8 ppe_pos_bit)
+{
+	u8 byte_num = ppe_pos_bit / 8;
+	u8 bit_num = ppe_pos_bit % 8;
+	u8 residue_bits;
+	u8 res;
+
+	if (bit_num <= 5)
+		return (ppe[byte_num] >> bit_num) &
+		       (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE) - 1);
+
+	/*
+	 * If bit_num > 5, we have to combine bits with next byte.
+	 * Calculate how many bits we need to take from current byte (called
+	 * here "residue_bits"), and add them to bits from next byte.
+	 */
+	residue_bits = 8 - bit_num;
+
+	res = (ppe[byte_num + 1] &
+	       (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE - residue_bits) - 1)) <<
+	      residue_bits;
+	res += (ppe[byte_num] >> bit_num) & (BIT(residue_bits) - 1);
+
+	return res;
+}
+
+static void cl_set_fixed_ppe_val(u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE], u8 dur)
+{
+	u8 val = ((dur << 6) | (dur << 4) | (dur << 2) | dur);
+
+	memset(pe_dur, val, CHNL_BW_MAX * WRS_MCS_MAX_HE);
+}
+
+void cl_cap_ppe_duration(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+			 u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE])
+{
+	/* Force NVRAM parameter */
+	if (cl_hw->conf->ci_pe_duration <= PPE_16US) {
+		cl_set_fixed_ppe_val(pe_dur, cl_hw->conf->ci_pe_duration);
+		return;
+	}
+
+	/*
+	 * If STA sets the PPE Threshold Present subfield to 0,
+	 * the value should be set according to the Nominal Packet Padding subfield
+	 */
+	if ((sta->he_cap.he_cap_elem.phy_cap_info[6] &
+	     IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) == 0) {
+		switch (sta->he_cap.he_cap_elem.phy_cap_info[9] &
+			IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK) {
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
+			cl_set_fixed_ppe_val(pe_dur, PPE_0US);
+			break;
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
+			cl_set_fixed_ppe_val(pe_dur, PPE_8US);
+			break;
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
+		default:
+			cl_set_fixed_ppe_val(pe_dur, PPE_16US);
+			break;
+		}
+
+		return;
+	}
+
+	/*
+	 * struct iwl_he_pkt_ext - QAM thresholds
+	 * The required PPE is set via HE Capabilities IE, per Nss x BW x MCS
+	 * The IE is organized in the following way:
+	 * Support for Nss x BW (or RU) matrix:
+	 *	(0=SISO, 1=MIMO2) x (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz)
+	 * Each entry contains 2 QAM thresholds for 8us and 16us:
+	 *	0=BPSK, 1=QPSK, 2=16QAM, 3=64QAM, 4=256QAM, 5=1024QAM, 6=RES, 7=NONE
+	 * i.e. QAM_th1 < QAM_th2 such if TX uses QAM_tx:
+	 *	QAM_tx < QAM_th1            --> PPE=0us
+	 *	QAM_th1 <= QAM_tx < QAM_th2 --> PPE=8us
+	 *	QAM_th2 <= QAM_tx           --> PPE=16us
+	 * @pkt_ext_qam_th: QAM thresholds
+	 *	For each Nss/Bw define 2 QAM thrsholds (0..5)
+	 *	For rates below the low_th, no need for PPE
+	 *	For rates between low_th and high_th, need 8us PPE
+	 *	For rates equal or higher then the high_th, need 16us PPE
+	 *	Nss (0-siso, 1-mimo2) x BW (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz) x
+	 *		(0-low_th, 1-high_th)
+	 */
+	u8 pkt_ext_qam_th[WRS_SS_MAX][CHNL_BW_MAX][QAM_THR_MAX];
+
+	/* If PPE Thresholds exist, parse them into a FW-familiar format. */
+	u8 nss = (sta->he_cap.ppe_thres[0] & IEEE80211_PPE_THRES_NSS_MASK) + 1;
+	u8 ru_index_bitmap = u32_get_bits(sta->he_cap.ppe_thres[0],
+					  IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	u8 *ppe = &sta->he_cap.ppe_thres[0];
+	u8 ppe_pos_bit = 7; /* Starting after PPE header */
+	u8 bw, ss, mcs, constellation;
+
+	if (nss > WRS_SS_MAX)
+		nss = WRS_SS_MAX;
+
+	for (ss = 0; ss < nss; ss++) {
+		u8 ru_index_tmp = ru_index_bitmap << 1;
+
+		for (bw = 0; bw <= cl_hw->bw; bw++) {
+			ru_index_tmp >>= 1;
+			if (!(ru_index_tmp & 1))
+				continue;
+
+			pkt_ext_qam_th[ss][bw][QAM_THR_2] = cl_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+			pkt_ext_qam_th[ss][bw][QAM_THR_1] = cl_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+		}
+	}
+
+	/* Reset PE duration before filling it */
+	memset(pe_dur, 0, CHNL_BW_MAX * WRS_MCS_MAX_HE);
+
+	for (ss = 0; ss < nss; ss++) {
+		for (bw = 0; bw <= cl_hw->bw; bw++) {
+			for (mcs = 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+				constellation = mcs_to_constellation[mcs];
+
+				if (constellation < pkt_ext_qam_th[ss][bw][QAM_THR_1])
+					pe_dur[bw][mcs] |= (PPE_0US << (ss * 2));
+				else if (constellation < pkt_ext_qam_th[ss][bw][QAM_THR_2])
+					pe_dur[bw][mcs] |= (PPE_8US << (ss * 2));
+				else
+					pe_dur[bw][mcs] |= (PPE_16US << (ss * 2));
+			}
+		}
+	}
+}
+
+static void cl_ops_tx_agg(struct cl_hw *cl_hw,
+			  struct sk_buff *skb,
+			  struct ieee80211_tx_info *tx_info,
+			  struct cl_sta *cl_sta)
+{
+	cl_hw->tx_packet_cntr.forward.from_mac_agg++;
+
+	if (!cl_sta) {
+		struct cl_vif *cl_vif =
+			(struct cl_vif *)tx_info->control.vif->drv_priv;
+		u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+		u8 ac = tid_to_ac[tid];
+
+		kfree_skb(skb);
+		cl_dbg_err(cl_hw, "cl_sta null in agg packet\n");
+		cl_hw->tx_packet_cntr.drop.sta_null_in_agg++;
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		return;
+	}
+
+	/* AMSDU in HW can work only with header conversion. */
+	tx_info->control.flags &= ~IEEE80211_TX_CTRL_AMSDU;
+	cl_tx_agg(cl_hw, cl_sta, skb, false, true);
+}
+
+static void cl_ops_tx_single(struct cl_hw *cl_hw,
+			     struct sk_buff *skb,
+			     struct ieee80211_tx_info *tx_info,
+			     struct cl_sta *cl_sta,
+			     struct ieee80211_sta *sta)
+{
+	bool is_vns = cl_vns_is_very_near(cl_hw, cl_sta, skb);
+
+	cl_hw->tx_packet_cntr.forward.from_mac_single++;
+	if (cl_hw->tx_db.block_prob_resp) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+		if (ieee80211_is_probe_resp(hdr->frame_control)) {
+			struct cl_vif *cl_vif = NETDEV_TO_CL_VIF(skb->dev);
+			u8 ac = cl_vif->vif->hw_queue[skb_get_queue_mapping(skb)];
+
+			cl_tx_single_free_skb(cl_hw, skb);
+			cl_hw->tx_packet_cntr.drop.probe_response++;
+			cl_vif->trfc_cntrs[ac].tx_dropped++;
+			return;
+		}
+	}
+
+	if (sta) {
+		u32 sta_vht_cap = sta->vht_cap.cap;
+		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+
+		if (!(sta_vht_cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK))
+			goto out_tx;
+
+		if (ieee80211_is_assoc_resp(mgmt->frame_control)) {
+			int len = skb->len - (mgmt->u.assoc_resp.variable - skb->data);
+			const u8 *vht_cap_addr = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY,
+								 mgmt->u.assoc_resp.variable,
+								 len);
+
+			if (vht_cap_addr) {
+				struct ieee80211_vht_cap *vht_cap =
+					(struct ieee80211_vht_cap *)(2 + vht_cap_addr);
+
+				vht_cap->vht_cap_info &=
+					~(cpu_to_le32(IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK |
+						      IEEE80211_VHT_CAP_SHORT_GI_160));
+			}
+		}
+	}
+
+out_tx:
+	cl_tx_single(cl_hw, cl_sta, skb, is_vns, true);
+}
+
+static u16 cl_ops_recalc_smallest_tbtt(struct cl_hw *cl_hw)
+{
+	struct wiphy *wiphy = cl_hw->hw->wiphy;
+	u8 cmb_idx = wiphy->n_iface_combinations - 1;
+	struct cl_vif *cl_vif = NULL;
+	u16 ret = 0;
+	u8 topology = cl_hw_get_iface_conf(cl_hw);
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+		if (cl_vif->vif->type == NL80211_IFTYPE_STATION)
+			continue;
+		else if (ret == 0)
+			ret = cl_vif->vif->bss_conf.beacon_int;
+		else if (cl_vif->vif->bss_conf.beacon_int)
+			ret = min(ret, cl_vif->vif->bss_conf.beacon_int);
+	}
+	read_unlock_bh(&cl_hw->vif_db.lock);
+
+	if (ret == 0) {
+		WARN_ONCE(topology != CL_IFCONF_STA && topology != CL_IFCONF_MESH_ONLY,
+			  "invalid smallest beacon interval");
+		return wiphy->iface_combinations[cmb_idx].beacon_int_min_gcd;
+	}
+	return ret;
+}
+
+static void cl_ops_set_mesh_tbtt(struct cl_hw *cl_hw, u16 this_beacon_int,
+				 u16 smallest_beacon_int)
+{
+	u16 div = this_beacon_int / smallest_beacon_int;
+
+	cl_hw->mesh_tbtt_div = (div > 0) ? div : 1;
+}
+
+void cl_ops_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control, struct sk_buff *skb)
+{
+	/*
+	 * Almost all traffic passing here is singles.
+	 * Only when opening a BA session some packets with
+	 * IEEE80211_TX_CTL_AMPDU set can pass here.
+	 * All skbs passing here did header conversion.
+	 */
+	struct cl_hw *cl_hw = (struct cl_hw *)hw->priv;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_sta *sta = control->sta;
+	struct cl_sta *cl_sta = NULL;
+
+	if (sta) {
+		cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+		/*
+		 * Prior to STA connection sta can be set but we don't
+		 * want cl_sta to be used since it's not initialized yet
+		 */
+		if (cl_sta->sta_idx == STA_IDX_INVALID)
+			cl_sta = NULL;
+	}
+
+	if (cl_recovery_in_progress(cl_hw)) {
+		cl_hw->tx_packet_cntr.drop.in_recovery++;
+
+		if (cl_sta) {
+			struct cl_vif *cl_vif = cl_sta->cl_vif;
+
+			if (cl_vif) {
+				struct ieee80211_vif *vif = cl_vif->vif;
+				u8 hw_queue;
+
+				if (vif) {
+					hw_queue = vif->hw_queue[skb_get_queue_mapping(skb)];
+					cl_vif->trfc_cntrs[hw_queue].tx_dropped++;
+				}
+			}
+		}
+
+		cl_tx_drop_skb(skb);
+		return;
+	}
+
+	if (cl_sta && (tx_info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
+		goto fast_tx;
+
+	if (tx_info->flags & IEEE80211_TX_CTL_AMPDU)
+		cl_ops_tx_agg(cl_hw, skb, tx_info, cl_sta);
+	else
+		cl_ops_tx_single(cl_hw, skb, tx_info, cl_sta, sta);
+
+	return;
+
+fast_tx:
+	if (tx_info->flags & IEEE80211_TX_CTL_AMPDU)
+		cl_tx_fast_agg(cl_hw, cl_sta, skb, true);
+	else
+		cl_tx_fast_single(cl_hw, cl_sta, skb, true);
+}
+
+int cl_ops_start(struct ieee80211_hw *hw)
+{
+	/*
+	 * Called before the first netdevice attached to the hardware
+	 * is enabled. This should turn on the hardware and must turn on
+	 * frame reception (for possibly enabled monitor interfaces.)
+	 * Returns negative error codes, these may be seen in userspace,
+	 * or zero.
+	 * When the device is started it should not have a MAC address
+	 * to avoid acknowledging frames before a non-monitor device
+	 * is added.
+	 * Must be implemented and can sleep.
+	 * It does not return until the firmware is up and running.
+	 */
+	int error = 0;
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+
+	if (!cl_hw->ipc_env) {
+		CL_DBG_ERROR(cl_hw, "ipc_env is NULL!\n");
+		return -ENODEV;
+	}
+
+	/* Exits if device is already started */
+	if (WARN_ON(test_bit(CL_DEV_STARTED, &cl_hw->drv_flags)))
+		return -EBUSY;
+
+	/* Device is now started.
+	 * Set CL_DEV_STARTED bit before the calls to other messages sent to
+	 * firmware, to prevent them from being blocked*
+	 */
+
+	set_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+
+	if (!cl_recovery_in_progress(cl_hw)) {
+		/* Read version */
+		error = cl_version_update(cl_hw);
+		if (error)
+			return error;
+
+		error = cl_temperature_diff_e2p_read(cl_hw);
+		if (error)
+			return error;
+	}
+
+	/* Set firmware debug module filter */
+	error = cl_msg_tx_dbg_set_ce_mod_filter(cl_hw, conf->ci_fw_dbg_module);
+	if (error)
+		return error;
+
+	/* Set firmware debug severity level */
+	error = cl_msg_tx_dbg_set_sev_filter(cl_hw, conf->ci_fw_dbg_severity);
+	if (error)
+		return error;
+
+	/* Set firmware rate fallbacks */
+	error = cl_msg_tx_set_rate_fallback(cl_hw);
+	if (error)
+		return error;
+
+	error = cl_msg_tx_ndp_tx_control(cl_hw,
+					 conf->ci_sensing_ndp_tx_chain_mask,
+					 conf->ci_sensing_ndp_tx_bw,
+					 conf->ci_sensing_ndp_tx_format,
+					 conf->ci_sensing_ndp_tx_num_ltf);
+	if (error)
+		return error;
+
+	/* Set default, multicast, broadcast rate */
+	cl_rate_ctrl_set_default(cl_hw);
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	cl_dyn_mcast_rate_set(cl_hw);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_set(cl_hw, 0);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+
+	ieee80211_wake_queues(hw);
+
+	clear_bit(CL_DEV_INIT, &cl_hw->drv_flags);
+
+	cl_edca_hw_conf(cl_hw);
+
+	if (!cl_hw->chip->conf->ce_calib_runtime_en) {
+		cl_calib_dcoc_init_calibration(cl_hw);
+
+		if (cl_hw->chip->conf->ce_production_mode)
+			cl_calib_iq_init_production(cl_hw);
+		else if (!cl_hw_other || test_bit(CL_DEV_STARTED, &cl_hw_other->drv_flags))
+			cl_calib_iq_init_calibration(cl_hw);
+	}
+
+	return error;
+}
+
+void cl_ops_stop(struct ieee80211_hw *hw)
+{
+	/*
+	 * Called after last netdevice attached to the hardware
+	 * is disabled. This should turn off the hardware (at least
+	 * it must turn off frame reception.)
+	 * May be called right after add_interface if that rejects
+	 * an interface. If you added any work onto the mac80211 workqueue
+	 * you should ensure to cancel it on this callback.
+	 * Must be implemented and can sleep.
+	 */
+	struct cl_hw *cl_hw = hw->priv;
+
+	/* Stop mac80211 queues */
+	ieee80211_stop_queues(hw);
+
+	/* Go to idle */
+	cl_msg_tx_set_idle(cl_hw, MAC_IDLE_SYNC, true);
+
+	/*
+	 * Clear CL_DEV_STARTED to prevent message to be sent (besides reset and start).
+	 * It also blocks transmission of new packets
+	 */
+	clear_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+
+	cl_hw->num_ap_started = 0;
+	cl_hw->channel = 0;
+	cl_hw->radio_status = RADIO_STATUS_OFF;
+}
+
+static int cl_add_interface_to_firmware(struct cl_hw *cl_hw,
+					struct ieee80211_vif *vif, u8 vif_index)
+{
+	struct mm_add_if_cfm *add_if_cfm;
+	int ret = 0;
+
+	/* Forward the information to the firmware */
+	ret = cl_msg_tx_add_if(cl_hw, vif, vif_index);
+	if (ret)
+		return ret;
+
+	add_if_cfm = (struct mm_add_if_cfm *)(cl_hw->msg_cfm_params[MM_ADD_IF_CFM]);
+	if (!add_if_cfm)
+		return -ENOMSG;
+
+	if (add_if_cfm->status != 0) {
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", add_if_cfm->status);
+		ret = -EIO;
+	}
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_ADD_IF_CFM);
+
+	return ret;
+}
+
+static enum cl_iface_conf cl_recalc_hw_iface(struct cl_hw *cl_hw)
+{
+	struct cl_vif *cl_vif = NULL;
+	u8 num_ap = 0, num_sta = 0, num_mp = 0;
+
+	read_lock_bh(&cl_hw->vif_db.lock);
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list) {
+		switch (cl_vif->vif->type) {
+		case NL80211_IFTYPE_AP:
+			num_ap++;
+			break;
+		case NL80211_IFTYPE_STATION:
+			num_sta++;
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			num_mp++;
+			break;
+		default:
+			read_unlock_bh(&cl_hw->vif_db.lock);
+			return CL_IFCONF_MAX;
+		}
+	}
+	read_unlock_bh(&cl_hw->vif_db.lock);
+
+	if (num_ap > 0 && num_sta == 0 && num_mp == 0)
+		return CL_IFCONF_AP;
+	if (num_ap == 0 && num_sta == 1 && num_mp == 0)
+		return CL_IFCONF_STA;
+	if (num_ap == 1 && num_sta == 1 && num_mp == 0)
+		return CL_IFCONF_REPEATER;
+	if (num_ap > 0 && num_sta == 0 && num_mp == 1)
+		return CL_IFCONF_MESH_AP;
+	if (num_ap == 0 && num_sta == 0 && num_mp == 1)
+		return CL_IFCONF_MESH_ONLY;
+
+	return CL_IFCONF_MAX;
+}
+
+int cl_ops_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	/*
+	 * Called when a netdevice attached to the hardware is
+	 * enabled. Because it is not called for monitor mode devices, start
+	 * and stop must be implemented.
+	 * The driver should perform any initialization it needs before
+	 * the device can be enabled. The initial configuration for the
+	 * interface is given in the conf parameter.
+	 * The callback may refuse to add an interface by returning a
+	 * negative error code (which will be seen in userspace.)
+	 * Must be implemented and can sleep.
+	 */
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
+	struct net_device *dev = NULL;
+	u8 ac;
+
+	if (!wdev)
+		return -ENODEV;
+
+	dev = wdev->netdev;
+	if (!dev)
+		return -ENODEV;
+
+	/*
+	 * In recovery just send the message to firmware and exit
+	 * (also make sure cl_vif already exists).
+	 */
+	if (cl_recovery_in_progress(cl_hw) && cl_vif_get_by_dev(cl_hw, dev))
+		return cl_add_interface_to_firmware(cl_hw, vif, cl_vif->vif_index);
+
+	cl_vif->cl_hw = cl_hw;
+	cl_vif->vif = vif;
+	cl_vif->dev = dev;
+	cl_vif->vif_index = cl_mac_addr_find_idx(cl_hw, vif->addr);
+
+	/* MAC address not found - invalid address */
+	if (cl_vif->vif_index == BSS_INVALID_IDX) {
+		cl_dbg_err(cl_hw, "Error: Invalid MAC address %pM for vif %s\n",
+			   vif->addr, dev->name);
+
+		return -EINVAL;
+	}
+
+	if (chip->conf->ce_production_mode || vif->type == NL80211_IFTYPE_STATION)
+		cl_vif->tx_en = true;
+
+	cl_vif_key_init(cl_vif);
+
+	if (cl_add_interface_to_firmware(cl_hw, vif, cl_vif->vif_index))
+		return -EINVAL;
+
+	cl_vif->conn_data = kzalloc(sizeof(*cl_vif->conn_data), GFP_KERNEL);
+	if (!cl_vif->conn_data) {
+		cl_dbg_verbose(cl_hw, "Memory allocation for conn_data failed !!!\n");
+		return -ENOMEM;
+	}
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		vif->cab_queue = CL_HWQ_VO;
+
+	cl_vif_add(cl_hw, cl_vif);
+	cl_hw_set_iface_conf(cl_hw, cl_recalc_hw_iface(cl_hw));
+
+	for (ac = 0; ac < AC_MAX; ac++)
+		vif->hw_queue[ac] = cl_ac2hwq[ac];
+
+	if (cl_radio_is_on(cl_hw) && vif->type == NL80211_IFTYPE_AP)
+		cl_vif->tx_en = true;
+
+	/* Set active state in station mode after ifconfig down and up */
+	if (cl_hw->conf->ce_listener_en)
+		cl_radio_on(cl_hw);
+	else if (cl_radio_is_on(cl_hw) && vif->type == NL80211_IFTYPE_STATION)
+		cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE, true);
+
+	if (vif->type == NL80211_IFTYPE_MESH_POINT) {
+		tasklet_init(&cl_hw->tx_mesh_bcn_task, cl_tx_bcn_mesh_task,
+			     (unsigned long)cl_vif);
+		cl_radio_on(cl_hw);
+		cl_vif->tx_en = true;
+		cl_vif->mesh_basic_rates = cl_cap_set_mesh_basic_rates(cl_hw);
+	}
+
+	return 0;
+}
+
+void cl_ops_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	/*
+	 * Notifies a driver that an interface is going down.
+	 * The stop callback is called after this if it is the last interface
+	 * and no monitor interfaces are present.
+	 * When all interfaces are removed, the MAC address in the hardware
+	 * must be cleared so the device no longer acknowledges packets,
+	 * the mac_addr member of the conf structure is, however, set to the
+	 * MAC address of the device going away.
+	 * Hence, this callback must be implemented. It can sleep.
+	 */
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+
+	if (vif->type == NL80211_IFTYPE_MESH_POINT)
+		tasklet_kill(&cl_hw->tx_mesh_bcn_task);
+
+	if (!cl_recovery_in_progress(cl_hw)) {
+		kfree(cl_vif->conn_data);
+		cl_vif_remove(cl_hw, cl_vif);
+		cl_msg_tx_remove_if(cl_hw, cl_vif->vif_index);
+	} else {
+		cl_vif_remove(cl_hw, cl_vif);
+	}
+	cl_hw_set_iface_conf(cl_hw, cl_recalc_hw_iface(cl_hw));
+
+	cl_vif_key_deinit(cl_vif);
+
+	cl_vif->cl_hw = NULL;
+	cl_vif->vif = NULL;
+	cl_vif->dev = NULL;
+}
+
+static int cl_ops_conf_change_channel(struct ieee80211_hw *hw)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+	enum nl80211_chan_width width = chandef->width;
+	u32 primary = chandef->chan->center_freq;
+	u32 center = chandef->center_freq1;
+	u32 channel = ieee80211_frequency_to_channel(primary);
+	u8 bw = cl_width_to_bw(width);
+	int ret = 0;
+
+	if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags))
+		return 0;
+
+	/* WA: for the first set-channel in production mode use the nvram values */
+	if (cl_hw_is_prod_or_listener(cl_hw) || !IS_REAL_PHY(chip)) {
+		ret = cl_chandef_get_default(cl_hw, &channel, &bw,
+					     &width, &primary, &center);
+
+		if (ret != 0)
+			return ret;
+	}
+
+	cl_dbg_trace(cl_hw,
+		     "channel(%u), primary(%u), center(%u), width(%u), bw(%u)\n",
+		     channel, primary, center, width, bw);
+
+	if (cl_hw->channel == channel &&
+	    cl_hw->bw == bw &&
+	    cl_hw->primary_freq == primary &&
+	    cl_hw->center_freq == center)
+		goto dfs_cac;
+
+	/*
+	 * Flush the pending data to ensure that we will finish the pending
+	 * transmissions before changing the channel
+	 */
+	if (IS_REAL_PHY(chip))
+		cl_ops_flush(hw, NULL, -1, false);
+
+	if (cl_hw->chip->conf->ce_calib_runtime_en)
+		ret = cl_calib_runtime_and_switch_channel(cl_hw, channel, bw, primary, center);
+	else
+		ret = cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center,
+					    CL_CALIB_PARAMS_DEFAULT_STRUCT);
+	if (ret)
+		return -EIO;
+
+	/**
+	 * Set preffered channel type to HT+/- based on current hapd
+	 * configuration.
+	 */
+	if (cl_band_is_24g(cl_hw)) {
+		u8 ct = cfg80211_get_chandef_type(&hw->conf.chandef);
+
+		switch (ct) {
+		case NL80211_CHAN_HT40PLUS:
+		case NL80211_CHAN_HT40MINUS:
+			if (ct != cl_hw->ht40_preffered_ch_type) {
+				cl_dbg_info(cl_hw, "HT40 preffered channel type=%s\n",
+					    ct == NL80211_CHAN_HT40PLUS ? "HT+" : "HT-");
+				cl_hw->ht40_preffered_ch_type = ct;
+			}
+		}
+	}
+
+	cl_wrs_api_bss_set_bw(cl_hw, bw);
+
+dfs_cac:
+	/*
+	 * TODO: This callback is being spawned even in STA mode, moreover,
+	 * "start_ap" comes later - it is unclear whether we are an AP at this
+	 * stage. Likely, may be solved by moving "force_cac_*" states to beginning
+	 * of "start_ap", but the request should stay in current callback
+	 */
+	if (!cl_band_is_5g(cl_hw))
+		return 0;
+
+	/*
+	 * Radar listening may occur at DFS channels during in-service mode,
+	 * so CAC may clear the channels, but radar listening should be
+	 * still active, and should start it as soon as we can.
+	 */
+	if (hw->conf.radar_enabled) {
+		/* If channel policy demans to be in CAC - need to request it */
+		if (!cl_dfs_is_in_cac(cl_hw) &&
+		    chandef->chan->dfs_state == NL80211_DFS_USABLE)
+			cl_dfs_request_cac(cl_hw, true);
+
+		if (!cl_dfs_radar_listening(cl_hw))
+			cl_dfs_radar_listen_start(cl_hw);
+	} else {
+		/*
+		 * No sense to continue be in silent mode if the channel was
+		 * cleared
+		 */
+
+		if (cl_dfs_is_in_cac(cl_hw) &&
+		    chandef->chan->dfs_state == NL80211_DFS_AVAILABLE)
+			cl_dfs_request_cac(cl_hw, false);
+
+		if (cl_dfs_radar_listening(cl_hw))
+			cl_dfs_radar_listen_end(cl_hw);
+	}
+	/*
+	 * We have just finished channel switch.
+	 * Now, check what to do with CAC.
+	 */
+	if (cl_dfs_requested_cac(cl_hw))
+		cl_dfs_force_cac_start(cl_hw);
+	else if (cl_dfs_is_in_cac(cl_hw))
+		cl_dfs_force_cac_end(cl_hw);
+
+	return 0;
+}
+
+int cl_ops_config(struct ieee80211_hw *hw, u32 changed)
+{
+	/*
+	 * Handler for configuration requests. IEEE 802.11 code calls this
+	 * function to change hardware configuration, e.g., channel.
+	 * This function should never fail but returns a negative error code
+	 * if it does. The callback can sleep
+	 */
+	int error = 0;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+		error = cl_ops_conf_change_channel(hw);
+
+	return error;
+}
+
+/*
+ * @bss_info_changed: Handler for configuration requests related to BSS
+ *  parameters that may vary during BSS's lifespan, and may affect low
+ *  level driver (e.g. assoc/disassoc status, erp parameters).
+ *  This function should not be used if no BSS has been set, unless
+ *  for association indication. The @changed parameter indicates which
+ *  of the bss parameters has changed when a call is made. The callback
+ *  can sleep.
+ */
+void cl_ops_bss_info_changed(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *info,
+			     u32 changed)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		if (cl_msg_tx_set_associated(cl_hw, info))
+			return;
+	}
+
+	if (changed & BSS_CHANGED_BSSID) {
+		if (cl_msg_tx_set_bssid(cl_hw, info->bssid, cl_vif->vif_index))
+			return;
+	}
+
+	if (changed & BSS_CHANGED_BEACON_INT) {
+		u16 smallest_int = cl_ops_recalc_smallest_tbtt(cl_hw);
+
+		cl_hw->smallest_beacon_int = smallest_int;
+
+		if (vif->type == NL80211_IFTYPE_AP ||
+		    cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_MESH_ONLY) {
+			if (cl_msg_tx_set_beacon_int(cl_hw, info->beacon_int,
+						     cl_vif->vif_index))
+				return;
+			if (cl_msg_tx_dtim(cl_hw, info->dtim_period))
+				return;
+		}
+
+		if (vif->type == NL80211_IFTYPE_MESH_POINT &&
+		    cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_MESH_AP) {
+			cl_ops_set_mesh_tbtt(cl_hw, info->beacon_int, smallest_int);
+		}
+	}
+
+	if (changed & BSS_CHANGED_BASIC_RATES) {
+		int shift = hw->wiphy->bands[hw->conf.chandef.chan->band]->bitrates[0].hw_value;
+
+		if (vif->type == NL80211_IFTYPE_MESH_POINT)
+			if (cl_vif->mesh_basic_rates)
+				info->basic_rates = cl_vif->mesh_basic_rates;
+
+		if (cl_msg_tx_set_basic_rates(cl_hw, info->basic_rates << shift))
+			return;
+		/* TODO: check if cl_msg_tx_set_mode() should be called */
+	}
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		/*
+		 * We must be in 11g mode here
+		 * TODO: we can add a check on the mode
+		 */
+		if (cl_msg_tx_set_slottime(cl_hw, info->use_short_slot))
+			return;
+	}
+
+	if (changed & BSS_CHANGED_BANDWIDTH)
+		cl_wrs_api_bss_set_bw(cl_hw, cl_width_to_bw(info->chandef.width));
+
+	if (changed & BSS_CHANGED_TXPOWER) {
+		if (info->txpower_type == NL80211_TX_POWER_FIXED) {
+			cl_hw->new_tx_power = info->txpower;
+			cl_power_tables_update(cl_hw, &cl_hw->phy_data_info.data->pwr_tables);
+			cl_msg_tx_refresh_power(cl_hw);
+		}
+	}
+
+	if (changed & BSS_CHANGED_BEACON) {
+		struct beacon_data *beacon = NULL;
+		struct ieee80211_sub_if_data *sdata =
+			container_of(vif, struct ieee80211_sub_if_data, vif);
+		struct ieee80211_ht_cap *ht_cap = NULL;
+		struct ieee80211_vht_cap *vht_cap = NULL;
+		struct ieee80211_he_cap_elem *he_cap = NULL;
+		bool sgi_en = false;
+		u8 hw_mode = cl_hw->hw_mode;
+		enum cl_wireless_mode wireless_mode = cl_hw->wireless_mode;
+
+		rcu_read_lock();
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP)
+			beacon = rcu_dereference(sdata->u.ap.beacon);
+		else if (ieee80211_vif_is_mesh(&sdata->vif))
+			beacon = rcu_dereference(sdata->u.mesh.beacon);
+
+		if (beacon) {
+			size_t ies_len = beacon->tail_len;
+			const u8 *ies = beacon->tail;
+			const u8 *cap =  NULL;
+			int var_offset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+			int len = beacon->head_len - var_offset;
+			const u8 *var_pos = beacon->head + var_offset;
+			const u8 *rate_ie = NULL;
+
+			cl_vif->wmm_enabled = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+								      WLAN_OUI_TYPE_MICROSOFT_WMM,
+								      ies,
+								      ies_len);
+			cl_dbg_info(cl_hw, "vif=%d wmm_enabled=%d\n",
+				    cl_vif->vif_index,
+				    cl_vif->wmm_enabled);
+
+			cap = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies, ies_len);
+			if (cap && cap[1] >= sizeof(*ht_cap)) {
+				ht_cap = (void *)(cap + 2);
+				sgi_en |= (le16_to_cpu(ht_cap->cap_info) &
+					   IEEE80211_HT_CAP_SGI_20) ||
+					  (le16_to_cpu(ht_cap->cap_info) &
+					   IEEE80211_HT_CAP_SGI_40);
+			}
+
+			cap = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
+			if (cap && cap[1] >= sizeof(*vht_cap)) {
+				vht_cap = (void *)(cap + 2);
+				sgi_en |= (le32_to_cpu(vht_cap->vht_cap_info) &
+					   IEEE80211_VHT_CAP_SHORT_GI_80) ||
+					  (le32_to_cpu(vht_cap->vht_cap_info) &
+					   IEEE80211_VHT_CAP_SHORT_GI_160);
+			}
+
+			cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
+			if (cap && cap[1] >= sizeof(*he_cap) + 1)
+				he_cap = (void *)(cap + 3);
+
+			rate_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
+			if (rate_ie) {
+				if (cl_band_is_24g(cl_hw))
+					if (cl_is_valid_g_rates(rate_ie))
+						hw_mode = cl_hw->conf->ci_cck_in_hw_mode ?
+							     HW_MODE_BG : HW_MODE_G;
+					else
+						hw_mode = HW_MODE_B;
+				else
+					hw_mode = HW_MODE_A;
+			}
+		} else {
+			cl_dbg_warn(cl_hw, "beacon_data not set!\n");
+		}
+
+		rcu_read_unlock();
+
+		/*
+		 * FIXME: 1. WRS has no VIF-specific capabs settings.
+		 *        2. WRS has no BW-specific SGI configuration support.
+		 **/
+
+		/* If found any capabs info and state is different - update sgi */
+		if ((ht_cap || vht_cap) && (cl_wrs_api_bss_is_sgi_en(cl_hw) != sgi_en))
+			cl_wrs_api_bss_set_sgi(cl_hw, sgi_en);
+
+		if (hw_mode != cl_hw->hw_mode) {
+			cl_hw->hw_mode = hw_mode;
+			sgi_en =
+				(ht_cap || vht_cap) ? sgi_en : cl_hw->conf->ci_short_guard_interval;
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+			cl_dyn_bcast_update(cl_hw);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+			cl_dyn_mcast_update(cl_hw);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+			cl_wrs_api_bss_capab_update(cl_hw, cl_hw->bw, sgi_en);
+		}
+
+		wireless_mode = cl_recalc_wireless_mode(cl_hw, !!ht_cap, !!vht_cap, !!he_cap);
+		if (wireless_mode != cl_hw->wireless_mode) {
+			sgi_en =
+				(ht_cap || vht_cap) ? sgi_en : cl_hw->conf->ci_short_guard_interval;
+			cl_hw->wireless_mode = wireless_mode;
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+			cl_dyn_mcast_update(cl_hw);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+			cl_wrs_api_bss_capab_update(cl_hw, cl_hw->bw, sgi_en);
+		}
+	}
+}
+
+int cl_ops_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	set_bit(CL_DEV_AP_STARTED, &cl_hw->drv_flags);
+
+	cl_hw->num_ap_started++;
+	if (cl_hw->conf->ce_radio_on) {
+		if (cl_radio_is_off(cl_hw))
+			cl_radio_on(cl_hw);
+
+		return 0;
+	}
+
+	/*
+	 * Set active state when cl_ops_start_ap() is called not during first driver start
+	 * but rather after removing all interfaces and then doing up again to one interface.
+	 */
+	if (cl_radio_is_on(cl_hw) && !cl_recovery_in_progress(cl_hw))
+		cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE, true);
+
+	return 0;
+}
+
+void cl_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	/*
+	 * Unset CL_DEV_AP_STARTED in order to avoid
+	 * calling cl_ops_conf_change_channel after unloading the driver
+	 */
+	clear_bit(CL_DEV_AP_STARTED, &cl_hw->drv_flags);
+
+	cl_hw->num_ap_started--;
+
+	if (!cl_hw->num_ap_started)
+		cl_hw->channel = 0;
+}
+
+u64 cl_ops_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_addr_list *mc_list)
+{
+	return netdev_hw_addr_list_count(mc_list);
+}
+
+void cl_ops_configure_filter(struct ieee80211_hw *hw, u32 changed_flags,
+			     u32 *total_flags, u64 multicast)
+{
+	/*
+	 * configure_filter: Configure the device's RX filter.
+	 * See the section "Frame filtering" for more information.
+	 * This callback must be implemented and can sleep.
+	 */
+	struct cl_hw *cl_hw = hw->priv;
+
+	cl_dbg_trace(cl_hw, "total_flags = 0x%08x\n", *total_flags);
+
+	/*
+	 * Reset our filter flags since our start/stop ops reset
+	 * the programmed settings
+	 */
+	if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags)) {
+		*total_flags = 0;
+		return;
+	}
+
+	if (multicast)
+		*total_flags |= FIF_ALLMULTI;
+	else
+		*total_flags &= ~FIF_ALLMULTI;
+
+	/* TODO: optimize with changed_flags vs multicast */
+	cl_msg_tx_set_filter(cl_hw, *total_flags, false);
+
+	*total_flags &= ~(1 << 31);
+}
+
+int cl_ops_set_key(struct ieee80211_hw *hw,
+		   enum set_key_cmd cmd,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta,
+		   struct ieee80211_key_conf *key)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	return cl_key_set(cl_hw, cmd, vif, sta, key);
+}
+
+void cl_ops_sw_scan_start(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  const u8 *mac_addr)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	cl_hw->sw_scan_in_progress = 1;
+
+	if (cl_hw->conf->ce_radio_on &&
+	    cl_radio_is_off(cl_hw) &&
+	    vif->type == NL80211_IFTYPE_STATION)
+		cl_radio_on(cl_hw);
+
+	if (cl_dfs_is_in_cac(cl_hw))
+		cl_dfs_force_cac_end(cl_hw);
+}
+
+void cl_ops_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	cl_hw->sw_scan_in_progress = 0;
+}
+
+int cl_ops_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		     enum ieee80211_sta_state old_state, enum ieee80211_sta_state new_state)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	int error = 0;
+
+	if (old_state == new_state)
+		return 0;
+
+	if (old_state == IEEE80211_STA_NOTEXIST &&
+	    new_state == IEEE80211_STA_NONE) {
+		cl_sta_init_sta(cl_hw, sta);
+	} else if (old_state == IEEE80211_STA_AUTH &&
+		   new_state == IEEE80211_STA_ASSOC) {
+		error = cl_sta_add(cl_hw, vif, sta);
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTH) {
+		cl_sta_remove(cl_hw, vif, sta);
+	}
+
+	return error;
+}
+
+void cl_ops_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       enum sta_notify_cmd cmd, struct ieee80211_sta *sta)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)hw->priv;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	bool is_ps = (bool)!cmd;
+
+	cl_sta_ps_notify(cl_hw, cl_sta, is_ps);
+}
+
+int cl_ops_conf_tx(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   u16 ac_queue,
+		   const struct ieee80211_tx_queue_params *params)
+{
+	/*
+	 * Configure TX queue parameters (EDCF (aifs, cw_min, cw_max),
+	 * bursting) for a hardware TX queue.
+	 * Returns a negative error code on failure.
+	 * The callback can sleep.
+	 */
+
+	/* We only handle STA edca here */
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct cl_hw *cl_hw = hw->priv;
+		struct ieee80211_he_mu_edca_param_ac_rec mu_edca = {0};
+		struct edca_params edca_params = {
+			.aifsn = (u8)(params->aifs),
+			.cw_min = (u8)(ilog2(params->cw_min + 1)),
+			.cw_max = (u8)(ilog2(params->cw_max + 1)),
+			.txop = (u8)(params->txop)
+		};
+
+		if (cl_hw->wireless_mode > WIRELESS_MODE_HT_VHT)
+			memcpy(&mu_edca, &params->mu_edca_param_rec, sizeof(mu_edca));
+
+		cl_edca_set(cl_hw, cl_ac2edca[ac_queue], &edca_params, &mu_edca);
+	}
+	return 0;
+}
+
+void cl_ops_sta_rc_update(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  u32 changed)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)hw->priv;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u8 bw = wrs_sta->max_rate_cap.bw;
+	u8 nss = wrs_sta->max_rate_cap.nss;
+
+	if (changed & IEEE80211_RC_SMPS_CHANGED)
+		cl_wrs_api_set_smps_mode(cl_hw, sta, sta->bandwidth);
+
+	WARN_ON(sta->rx_nss == 0);
+	if (changed & IEEE80211_RC_NSS_CHANGED)
+		nss = min_t(u8, sta->rx_nss, WRS_SS_MAX) - 1;
+
+	if (changed & IEEE80211_RC_BW_CHANGED)
+		bw = sta->bandwidth;
+
+	if ((changed & IEEE80211_RC_NSS_CHANGED) || (changed & IEEE80211_RC_BW_CHANGED))
+		cl_wrs_api_nss_or_bw_changed(cl_hw, sta, nss, bw);
+}
+
+int cl_ops_ampdu_action(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct ieee80211_ampdu_params *params)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)hw->priv;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(params->sta);
+	int ret = 0;
+
+	switch (params->action) {
+	case IEEE80211_AMPDU_RX_START:
+		ret = cl_ampdu_rx_start(cl_hw, cl_sta, params->tid,
+					params->ssn, params->buf_size);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		cl_ampdu_rx_stop(cl_hw, cl_sta, params->tid);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		ret = cl_ampdu_tx_start(cl_hw, vif, cl_sta, params->tid,
+					params->ssn);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		ret = cl_ampdu_tx_operational(cl_hw, cl_sta, params->tid,
+					      params->buf_size, params->amsdu);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		ret = cl_ampdu_tx_stop(cl_hw, vif, params->action, cl_sta,
+				       params->tid);
+		break;
+	default:
+		pr_warn("Error: Unknown AMPDU action (%d)\n", params->action);
+	}
+
+	return ret;
+}
+
+int cl_ops_post_channel_switch(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif)
+{
+	/* TODO: Need to handle post switch */
+	return 0;
+}
+
+void cl_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u32 queues, bool drop)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	int flush_duration;
+
+	if (test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags)) {
+		cl_dbg_verbose(cl_hw, ": bypassing (CL_DEV_HW_RESTART set)\n");
+		return;
+	}
+
+	/* Wait for a maximum time of 200ms until all pending frames are flushed */
+	for (flush_duration = 0; flush_duration < 200; flush_duration++) {
+		if (!cl_txq_frames_pending(cl_hw))
+			return;
+
+		/* Lets sleep and hope for the best */
+		usleep_range(1000, 2000);
+	}
+}
+
+bool cl_ops_tx_frames_pending(struct ieee80211_hw *hw)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	return cl_txq_frames_pending(cl_hw);
+}
+
+void cl_ops_reconfig_complete(struct ieee80211_hw *hw,
+			      enum ieee80211_reconfig_type reconfig_type)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	cl_recovery_reconfig_complete(cl_hw);
+}
+
+int cl_ops_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int *dbm)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	if (cl_hw->phy_data_info.data)
+		*dbm = cl_power_get_max(cl_hw);
+	else
+		*dbm = 0;
+
+	return 0;
+}
+
+int cl_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+{
+	/* TODO: Fix this call */
+	return 0;
+}
+
+static void cl_ops_mgd_assoc(struct cl_hw *cl_hw, struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = container_of(vif, struct ieee80211_sub_if_data, vif);
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	struct ieee80211_sta *sta = ieee80211_find_sta(vif, sdata->u.mgd.bssid);
+
+	if (!sta) {
+		/* Should never happen */
+		cl_dbg_verbose(cl_hw, "sta is NULL !!!\n");
+		return;
+	}
+
+	cl_sta_mgd_add(cl_hw, cl_vif, sta);
+
+	if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_REPEATER) {
+		cl_vif_ap_tx_enable(cl_hw, true);
+		set_bit(CL_DEV_REPEATER, &cl_hw->drv_flags);
+	}
+}
+
+static void cl_ops_mgd_disassoc(struct cl_hw *cl_hw)
+{
+	if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_REPEATER) {
+		cl_vif_ap_tx_enable(cl_hw, false);
+		clear_bit(CL_DEV_REPEATER, &cl_hw->drv_flags);
+	}
+}
+
+void cl_ops_event_callback(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   const struct ieee80211_event *event)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	if (event->type == MLME_EVENT) {
+		if (event->u.mlme.data == ASSOC_EVENT &&
+		    event->u.mlme.status == MLME_SUCCESS)
+			cl_ops_mgd_assoc(cl_hw, vif);
+		else if (event->u.mlme.data == DEAUTH_TX_EVENT ||
+			 event->u.mlme.data == DEAUTH_RX_EVENT)
+			cl_ops_mgd_disassoc(cl_hw);
+	}
+}
+
+/* This function is required for PS flow - do not remove */
+int cl_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set)
+{
+	return 0;
+}
+
+int cl_ops_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+{
+	struct cl_hw *cl_hw = hw->priv;
+
+	*rx_ant = cl_hw->mask_num_antennas;
+	*tx_ant = cl_hw->mask_num_antennas;
+
+	return 0;
+}
+
+u32 cl_ops_get_expected_throughput(struct ieee80211_hw *hw,
+				   struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+
+	return cl_sta->wrs_sta.tx_su_params.data_rate;
+}
+
+void cl_ops_sta_statistics(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   struct station_info *sinfo)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_sta *cl_sta = NULL;
+	u64 total_tx_success = 0, total_tx_fail = 0;
+	struct cl_wrs_params *wrs_params = NULL;
+
+	if (!sta)
+		return;
+
+	cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+	/*
+	 * Since cl8k implements rate control algorithm (sets IEEE80211_HW_HAS_RATE_CONTROL)
+	 * it is needed to initialize both rx/tx bitrates manually
+	 */
+	cl_wrs_lock_bh(&cl_hw->wrs_db);
+	wrs_params = &cl_sta->wrs_sta.tx_su_params;
+	cl_wrs_fill_sinfo_rates(&sinfo->txrate, wrs_params, cl_sta);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	cl_wrs_unlock_bh(&cl_hw->wrs_db);
+
+	/* mac80211 will fill sinfo stats if driver not set sinfo->filled flag */
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	cl_stats_get_tx(cl_hw, cl_sta, &total_tx_success, &total_tx_fail);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+	sinfo->tx_packets = total_tx_success;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	sinfo->tx_failed = total_tx_fail;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+	sinfo->rx_packets = cl_stats_get_rx(cl_hw, cl_sta);
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+	sinfo->tx_bytes = cl_sta->tx_bytes;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+	sinfo->rx_bytes = cl_sta->rx_bytes;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	sinfo->tx_retries = cl_sta->retry_count;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+	sinfo->signal_avg = cl_stats_get_rssi(cl_hw, cl_sta);
+}
+
+int cl_ops_get_survey(struct ieee80211_hw *hw, int idx, struct survey_info *survey)
+{
+	struct ieee80211_conf *conf = &hw->conf;
+	struct cl_hw *cl_hw = hw->priv;
+	struct ieee80211_supported_band *sband = hw->wiphy->bands[conf->chandef.chan->band];
+	struct cl_chan_scanner *scanner = cl_hw->scanner;
+	struct cl_channel_stats *scanned_channel = NULL;
+	int chan_num;
+	u8 i;
+
+	if (idx >= sband->n_channels)
+		return -ENOENT;
+
+	survey->channel = &sband->channels[idx];
+	chan_num = ieee80211_frequency_to_channel(sband->channels[idx].center_freq);
+
+	for (i = 0; i < scanner->channels_num; i++) {
+		if (scanner->channels[i].channel == chan_num) {
+			scanned_channel = &scanner->channels[i];
+			break;
+		}
+	}
+
+	if (!scanned_channel) {
+		survey->filled = 0;
+		return 0;
+	}
+
+	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_SCAN |
+			 SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME_TX |
+			 SURVEY_INFO_TIME_RX | SURVEY_INFO_TIME_BUSY |
+			 SURVEY_INFO_TIME_EXT_BUSY;
+
+	survey->noise = scanned_channel->ch_noise;
+
+	survey->time = scanned_channel->scan_time_ms;
+	survey->time_scan = survey->time;
+
+	survey->time_rx = div64_u64(scanned_channel->util_time_rx, USEC_PER_MSEC);
+	survey->time_tx = div64_u64(scanned_channel->util_time_tx, USEC_PER_MSEC);
+
+	survey->time_busy = div64_u64(scanned_channel->util_time_busy, USEC_PER_MSEC);
+	survey->time_ext_busy = survey->time_busy;
+
+	return 0;
+}
+
+static void cl_scan_completion_cb(struct cl_hw *cl_hw, void *arg)
+{
+	struct cl_chan_scanner *scanner = cl_hw->scanner;
+	struct cfg80211_scan_info info = {
+		.aborted = scanner->scan_aborted,
+	};
+
+	cl_dbg_trace(cl_hw, "Completed scan request, aborted: %u\n", info.aborted);
+
+	cl_scan_channel_switch(cl_hw, scanner->prescan_channel, scanner->prescan_bw, true);
+	ieee80211_scan_completed(cl_hw->hw, &info);
+}
+
+int cl_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_scan_request *hw_req)
+{
+	struct cfg80211_scan_request *req = &hw_req->req;
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_chan_scanner *scanner = cl_hw->scanner;
+	u8 scan_channels[MAX_CHANNELS] = {0};
+	u8 i;
+	int ret = 0;
+
+	cl_dbg_trace(cl_hw, "Hardware scan request: n_channels:%u, n_ssids:%d\n",
+		     req->n_channels, req->n_ssids);
+
+	if (cl_hw->conf->ce_radio_on && cl_radio_is_off(cl_hw))
+		cl_radio_on(cl_hw);
+
+	ret = mutex_lock_interruptible(&scanner->cl_hw->set_channel_mutex);
+	if (ret != 0)
+		return ret;
+	scanner->prescan_bw = cl_hw->bw;
+	scanner->prescan_channel = cl_hw->channel;
+	mutex_unlock(&scanner->cl_hw->set_channel_mutex);
+
+	if (req->n_ssids > 0) {
+		/*
+		 * This is active scan request. We do not support it yet, so we
+		 * need to force the mac80211 to fallback to the sw_scan.
+		 */
+		cl_dbg_trace(cl_hw, "activating fall-back strategy - sw_scan\n");
+		return 1;
+	}
+
+	if (req->n_channels > ARRAY_SIZE(scan_channels)) {
+		cl_dbg_warn(cl_hw, "invalid number of channels to scan: %u\n",
+			    req->n_channels);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < req->n_channels; ++i) {
+		if (req->channels[i]->band != cl_hw->nl_band) {
+			cl_dbg_warn(cl_hw, "band %u is invalid\n", req->channels[i]->band);
+			return -EINVAL;
+		}
+		scan_channels[i] = ieee80211_frequency_to_channel(req->channels[i]->center_freq);
+	}
+
+	ret = cl_trigger_off_channel_scan(scanner, req->duration, 0,
+					  scan_channels, CHNL_BW_20, req->n_channels,
+					  cl_scan_completion_cb, NULL);
+	return ret;
+}
+
+void cl_ops_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct cl_hw *cl_hw = hw->priv;
+	struct cl_chan_scanner *scanner = cl_hw->scanner;
+
+	if (!cl_is_scan_in_progress(scanner))
+		return;
+
+	cl_abort_scan(scanner);
+	wait_event_interruptible_timeout(scanner->wq,
+					 !cl_is_scan_in_progress(scanner),
+					 msecs_to_jiffies(MSEC_PER_SEC));
+}
-- 
2.36.1

