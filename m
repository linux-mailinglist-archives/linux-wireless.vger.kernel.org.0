Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B983AB851
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhFQQGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:25 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:35841
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233081AbhFQQGI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHBBOHJnRsUiySrX97VivKc6/mwYBCJOX2ftgoBfQRXCLJut3hOKAHqWwX+jDjfTYe9uJbbkHt9I9LK/CDoDUUECjEEH3QOtIbVbU0rAiB2VrxLzO6ru1dtVqPURwAmTzr57Fawlyf/MH7dDr4x4EiP7GTAewNNbaMzOWPxY49RUohhQW/Liis+Z2/3z6TAPGEpTJdzrrmhOfNkJimF1odCTbO7Rvzz5wQ6q7nu1nBmv8q5qwW3ie/Osn+estRoQD/AAQCbTpoeHDlrff7a1+7HgTA5Ybs/d8POrKxBWCpf9pohItntCn1Vy5vw6lfUwVLSEhiiylln49aNp2imSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2DRfQ0bwibLJFIxPrPv0FIlU+fo+KphB7UlvgNSLfk=;
 b=iKoIE6dlckkpO+DxLMzl2ry+escoBDVgZNiP/fYKprrYpiP7VhOyZt+VURornj0DKu1LpN7+9zA/ZRV8epGZ0EgNsKTCUMBJV9STvF1FrUnwgk38Ksn1j5sH5d2lx+L6t4UC9z6ayvlajPAUkcjmWFBzG5pUIy9QzoaAzdmSzV/OVHoNuAOsaXaxFxSrrTOW6s5zkLI2FKVPVgUUlRmFwYfa68feNDDLJzEQztfD8t5kQBNpH6N3xPVorsGuaQVxvH84xVAykNdFOIl+D4RWyYcygilAF4NSi64ViWttkYFVeU3ni9nmKxtO9I63qM5sDKSMM6e+FnWI0BfPWdo3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2DRfQ0bwibLJFIxPrPv0FIlU+fo+KphB7UlvgNSLfk=;
 b=3ltnlafXstJolFRQJISTa0fsNuOrfK51b4a0zLO5KaG3hK0GtRj59msi+Uw/QVd3UFfL0+vA+e+h5qn/jwxBg5yIdRXHsdbQ4O1LGwyjn7My+ainoD1kdREyw91Lp2QQKGDK044DPQz59mSujJBIx5neH7FuvTdG94Y6ipJWD44=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:48 +0000
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
Subject: [RFC v1 058/256] cl8k: add def.h
Date:   Thu, 17 Jun 2021 15:59:05 +0000
Message-Id: <20210617160223.160998-59-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde1d4d1-0236-47cf-2546-08d931a97777
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499051CF0E3EDFF46D6251FF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUFmpLoWtPJcOfS/3OqbZR+w74k0glP4Em6eTN5A73d7CZut/pY/93QZxlsIyplUdpiMSAELv9JxyVj0UbnhlZgWDyGa8SOzCsAD+W4FkBhHW7LvesKy++RK6SOuTULlbeULUSdUorydHuKmMBcl8QYptC/6d36JiAXYqjOGeE9fRBNFoI/NHR+zK4mmjdOnBjkyHo4B0PBM8AjrqqdzFaBtG9KW2dSPQqAGOq2MuSLk0oOPKOBIBXdyB+0VTZsMU0XwiS1z43x1Nv2D+9ALgXhkHi0U5FM1TSyihXiU44NVYUE/6pdXNwKAQERAn15PzSQSvhOSWdpTTtc+yGQVJLcHvuQ/Otl1kqYaRbhd24Qxm5yT1oL3qTZvnE8pF5nGLVq6ayJg8gMqUyYJtfL4ASPICWjfe3zRpII8xO5c6ExQ6CwqwR91e4BatXretIhnb41hleRFWQFbrvWbFY1NT1asyTx2dI3VvQGzRTxfRB86i6wY2IIyAIiERy6WY9Eidwf57SvJKsZxrHTa5bhvam+p3cAG3AlVfHS5aNj3vd27OwRSQPez9KIJ/sflQCL+1teaNUu7xsXRp87eC99iRcmKyo4TS+w+STDHTSfp1UwrslgOfmqyFiEbygvwzP5yW3oCoQI2Y+H7CdwpL0wyZLeaLZTw2+jAjKhmIpWg9UnvrjpGRCLST0HOoKSS/90K2Qkht8wVYYS0tsxkHc3YUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BW0zKRNsYoMtTQaEQtvJoDPuBuWJcSX9rxkB8OZRiGMUB7vw96Buo96xthe4?=
 =?us-ascii?Q?ax3/9YG9ct0YYTSqxH9qxifHWX3M0IvXR871YkVPpNfzBcxRmaFv0dIs9Bxh?=
 =?us-ascii?Q?ftMQjzb7JoUSbMm6ujWnN2GpPuSVVlnuIgCc0Mpn34o+jtBgDIw7CaQxu3GC?=
 =?us-ascii?Q?nHZS5BbVSPqyT2xfl/F6SyfqyXIxgxIIlQkh541qGQQAY85IHE0ziWfkqV2K?=
 =?us-ascii?Q?l3q57FRNCVybIGlzpQ71cGFBSVaiiZceQpmthcq3iqSoWLV6uUtAK0CAgVRw?=
 =?us-ascii?Q?mveRjoHHm1zL9hJIO4UgwdCOLU3lseClh5zrfU5ybRhQWDLuCeyiH2OhLPzw?=
 =?us-ascii?Q?1DcBLdP9CGtqL21J8pOrMJcjr9SgZHgKSiNGCnuf/CczDpMkpJpWZKlO0mFa?=
 =?us-ascii?Q?Fz/3u9LYW0kkb2TmZCQD42iIisOExFlNQPzj82TZmB222Q+jBVe5+BRtVuWw?=
 =?us-ascii?Q?GT9raIDDn2ex2JLy+kXPthXbKUBKIdnJdY4meXxmqXJ/WjXnfD2g8SKS2sne?=
 =?us-ascii?Q?NiZCnQiWSuS5hX2gl8+VcrpmHVXClellu1diqP6FAk/T86ii83Yu4jlraop+?=
 =?us-ascii?Q?1dmRIMxak9IpcUrbXGOEXMukRGoRAoDuKslsLZP9GC+gXMG1f0p5TFxG+/Fp?=
 =?us-ascii?Q?DTTZXbZc5iRTsNY2GVEImtbEjXg2pS5B60x1oaALDBBEuRpW618f6Z2R1fU1?=
 =?us-ascii?Q?Rp+i1BJOXIITgM+QBdZYvPhd7odp/h3YxOVAtcEmZKWj4wZAgbgoer3+Ynxu?=
 =?us-ascii?Q?Nz9/saw6KStPe9HQRFEXfvvi2gQFcsvwRbErIpUrmHwpJjLxIeRHReBbFHjO?=
 =?us-ascii?Q?1ubd2lo1kyDY0AlRzaUbTZhb3e4gj8tuJ8LHlW490NZ09PXb1R6zrwKXxQsB?=
 =?us-ascii?Q?rBq7PrfSPx08FibTcdvsvFiegY538Q8Xq4aexK3GBC03MgFb/LV6Y0SG3DZS?=
 =?us-ascii?Q?mZN5/YbR7hB5Si+dOCJ1hBVFDjXyxmEPX8uVQFHQRqzj1Cq1fj8UJRRJGLHB?=
 =?us-ascii?Q?LLnb2q9921G/O3Uxaf+QNs4hBZdasAgFTbT1gCQ2cd0Gq8Q5/2p+W5y+I49o?=
 =?us-ascii?Q?8xG5LUe7zM218LpXITKiaBWn2KR2YnjGybabG+C+WS0527S7OYbZQYc35M5m?=
 =?us-ascii?Q?V9MdtUj5OulA6Md3eTtUke2MPKDvcddMJpeoZtrebFUOL9hSxbhmhgd2deVt?=
 =?us-ascii?Q?al+ZsgGHXuso2n9+O36fEOuhi8olAlQ22F/eI1JMLXWOCeYym7B06U42mMgR?=
 =?us-ascii?Q?i5/Rmf25l2Deymcns/RRhR+Q3Kwc7QTJehfx69YccTVR9a3kQcWqivjiTmzV?=
 =?us-ascii?Q?53e1Gfh3yxG/yC5/fE0O2vs5?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde1d4d1-0236-47cf-2546-08d931a97777
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:37.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2b7k5Bdq3bAlFixjTLY8fi4GA8PM4E93Fl/59g0f2St+M+QBjsO0ZV05XuqIoTg3X8p8lE1+QBd280wAciGMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/def.h | 269 +++++++++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/def.h

diff --git a/drivers/net/wireless/celeno/cl8k/def.h b/drivers/net/wireless/=
celeno/cl8k/def.h
new file mode 100644
index 000000000000..b57f611dfac2
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/def.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DEF_H
+#define CL_DEF_H
+
+#include <stddef.h>
+#include <linux/types.h>
+
+#define ASSERT_ERR(condition) \
+       do { \
+               if (unlikely(!(condition))) \
+                       cl_dbg_err(cl_hw, ":ASSERT_ERR(" #condition ")\n");=
 \
+       } while (0)
+
+#define ASSERT_ERR_CHIP(condition) \
+       do { \
+               if (unlikely(!(condition))) \
+                       cl_dbg_chip_err(chip, ":ASSERT_ERR(" #condition ")\=
n"); \
+       } while (0)
+
+#define CL_TIME_DIFF(a, b) ((a) - (b))
+
+#define msecs_round(ms) jiffies_to_msecs(msecs_to_jiffies(ms))
+
+/* Each chip supports two TCVs */
+#define TCV0    0
+#define TCV1    1
+#define TCV_MAX 2
+
+#define CHIP0    0
+#define CHIP1    1
+#define CHIP_MAX 2
+
+#define TCV_TOTAL (CHIP_MAX * TCV_MAX)
+
+#define CL_VENDOR_ID 0x1d69
+
+#define CPU_MAX_NUM 8
+
+/* We support 128 stations and last station is assigned for high priority =
*/
+#define CL_MAX_NUM_STA 128
+#define FW_MAX_NUM_STA (CL_MAX_NUM_STA + 1)
+
+#define MAX_SINGLE_QUEUES   (AC_MAX * FW_MAX_NUM_STA)
+#define HIGH_PRIORITY_QUEUE (MAX_SINGLE_QUEUES - 1)
+
+/* Must be aligned to NX_VIRT_DEV_MAX definition in rwnx_config.h */
+#define MAX_BSS_NUM 8
+
+#define MAX_TX_SW_AMSDU_PACKET 15
+
+#define RX_MAX_MSDU_IN_AMSDU 128
+
+#define CL_PATH_MAX 200
+#define CL_FILENAME_MAX 100
+
+/* MAX/MIN number of antennas supported */
+#define MIN_ANTENNAS             1
+#define MAX_ANTENNAS             6
+#define MAX_ANTENNAS_OFDM_HT_VHT 4
+#define MAX_ANTENNAS_CCK         4
+#define MAX_ANTENNAS_CHIP        8
+
+#define MAX_ANTENNAS_CL808X      8
+#define MAX_ANTENNAS_CL806X      6
+#define MAX_ANTENNAS_CL804X      4
+
+#define ANT_MASK(ant) (BIT(ant) - 1)
+
+/* 6GHz defines */
+#define HE_6GHZ_CAP_MIN_MPDU_START_OFFSET    0
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET 3
+#define HE_6GHZ_CAP_MAX_MPDU_LEN_OFFSET      6
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_FACTOR     13
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_MASK   0x38
+
+#define MHZ_TO_BW(mhz) ilog2((mhz) / 20)
+#define BW_TO_MHZ(bw)  ((1 << (bw)) * 20)
+#define BW_TO_KHZ(bw)  ((1 << (bw)) * 20000)
+
+#define CIPHER_SUITE_LIST_OFFSET 11
+#define CIPHER_SUITE_LIST_SIZE   4
+
+/* Cipher suite selectors */
+#define CL_CIPHER_SUITE_USE_NONE     0
+#define CL_CIPHER_SUITE_WEP40        1
+#define CL_CIPHER_SUITE_TKIP         2
+#define CL_CIPHER_SUITE_CCMP         4
+#define CL_CIPHER_SUITE_WEP104       5
+#define CL_CIPHER_SUITE_AES_CMAC     6
+#define CL_CIPHER_SUITE_GCMP         8
+#define CL_CIPHER_SUITE_GCMP_256     9
+#define CL_CIPHER_SUITE_CCMP_256     10
+#define CL_CIPHER_SUITE_BIP_GMAC_128 11
+#define CL_CIPHER_SUITE_BIP_GMAC_256 12
+#define CL_CIPHER_SUITE_BIP_CMAC_256 13
+#define CL_CIPHER_SUITE_USE_GROUP    14
+
+#define CIPHER_SUITE_MASK() (BIT(CL_CIPHER_SUITE_WEP40)        | \
+                            BIT(CL_CIPHER_SUITE_WEP40)        | \
+                            BIT(CL_CIPHER_SUITE_TKIP)         | \
+                            BIT(CL_CIPHER_SUITE_CCMP)         | \
+                            BIT(CL_CIPHER_SUITE_WEP104)       | \
+                            BIT(CL_CIPHER_SUITE_AES_CMAC)     | \
+                            BIT(CL_CIPHER_SUITE_GCMP)         | \
+                            BIT(CL_CIPHER_SUITE_GCMP_256)     | \
+                            BIT(CL_CIPHER_SUITE_CCMP_256)     | \
+                            BIT(CL_CIPHER_SUITE_BIP_GMAC_128) | \
+                            BIT(CL_CIPHER_SUITE_BIP_GMAC_256) | \
+                            BIT(CL_CIPHER_SUITE_BIP_CMAC_256) | \
+                            BIT(CL_CIPHER_SUITE_USE_GROUP))
+
+#define IS_VALID_ENCRYPT_TYPE(encrypt_type) ((encrypt_type) & CIPHER_SUITE=
_MASK())
+
+#define CL_CIPHER_SUITE_MIXED_TKIP_CCMP (BIT(CL_CIPHER_SUITE_TKIP) | \
+                                        BIT(CL_CIPHER_SUITE_CCMP))
+
+/* AKM suite selectors */
+#define CL_AKM_SUITE_OPEN              0
+#define CL_AKM_SUITE_8021X             1
+#define CL_AKM_SUITE_PSK               2
+#define CL_AKM_SUITE_FT_8021X          3
+#define CL_AKM_SUITE_FT_PSK            4
+#define CL_AKM_SUITE_8021X_SHA256      5
+#define CL_AKM_SUITE_PSK_SHA256        6
+#define CL_AKM_SUITE_TDLS              7
+#define CL_AKM_SUITE_SAE               8
+#define CL_AKM_SUITE_FT_OVER_SAE       9
+#define CL_AKM_SUITE_8021X_SUITE_B     11
+#define CL_AKM_SUITE_8021X_SUITE_B_192 12
+#define CL_AKM_SUITE_FILS_SHA256       14
+#define CL_AKM_SUITE_FILS_SHA384       15
+#define CL_AKM_SUITE_FT_FILS_SHA256    16
+#define CL_AKM_SUITE_FT_FILS_SHA384    17
+
+#define CL_HWQ_BK  0
+#define CL_HWQ_BE  1
+#define CL_HWQ_VI  2
+#define CL_HWQ_VO  3
+#define CL_HWQ_BCN 4
+
+/* Traffic ID enumeration */
+enum {
+       TID_0,
+       TID_1,
+       TID_2,
+       TID_3,
+       TID_4,
+       TID_5,
+       TID_6,
+       TID_7,
+       TID_MAX
+};
+
+/* Access Category enumeration */
+enum {
+       AC_BK =3D 0,
+       AC_BE,
+       AC_VI,
+       AC_VO,
+       AC_MAX
+};
+
+enum cl_dev_flag {
+       CL_DEV_HW_RESTART,
+       CL_DEV_SW_RESTART,
+       CL_DEV_STOP_HW,
+       CL_DEV_STARTED,
+       CL_DEV_RADAR_LISTEN,
+       CL_DEV_INIT,
+       CL_DEV_FW_SYNC,
+       CL_DEV_FW_ERROR,
+       CL_DEV_REPEATER,
+       CL_DEV_MESH_AP,
+};
+
+enum cl_hw_mode {
+       HW_MODE_A,
+       HW_MODE_B,
+       HW_MODE_G,
+       HW_MODE_BG,
+
+       HW_MODE_MAX,
+};
+
+enum cl_channel_bw {
+       CHNL_BW_20,
+       CHNL_BW_40,
+       CHNL_BW_80,
+       CHNL_BW_160,
+
+       CHNL_BW_MAX,
+};
+
+#define MU_UL_MAX 4
+
+#define CHNL_BW_MAX_HE   CHNL_BW_MAX
+#define CHNL_BW_MAX_VHT  CHNL_BW_MAX
+#define CHNL_BW_MAX_HT   CHNL_BW_80
+#define CHNL_BW_MAX_OFDM CHNL_BW_40
+#define CHNL_BW_MAX_CCK  CHNL_BW_40
+
+#define CHNL_BW_2_5 4
+#define CHNL_BW_5   5
+#define CHNL_BW_10  6
+
+#define CHNL_BW_MAX_OFDMA 7
+
+enum cl_reg_standard {
+       CL_STANDARD_NONE,
+       CL_STANDARD_FCC,
+       CL_STANDARD_ETSI,
+};
+
+enum cl_wireless_mode {
+       WIRELESS_MODE_LEGACY,
+       WIRELESS_MODE_HT,
+       WIRELESS_MODE_HT_VHT,
+       WIRELESS_MODE_HT_VHT_HE,
+       WIRELESS_MODE_HE
+};
+
+enum cl_ndp_tx_chains {
+       NDP_TX_PHY0 =3D 0x1,
+       NDP_TX_PHY1 =3D 0x2,
+       NDP_TX_PHY01 =3D 0x3,
+};
+
+#define IS_VALID_TX_CHAINS(mask) \
+       (((mask) =3D=3D NDP_TX_PHY0) || \
+        ((mask) =3D=3D NDP_TX_PHY1) || \
+        ((mask) =3D=3D NDP_TX_PHY01))
+
+#define Q2_TO_FREQ(x)    ((x) >> 2)
+#define Q2_TO_FREQ_FRAC(x) (((x) & 0x3) * 25)
+#define FREQ_TO_Q2(freq) ((freq) << 2)
+
+/* Values of the firmware FORMATMOD fields */
+enum format_mode {
+       FORMATMOD_NON_HT =3D 0,
+       FORMATMOD_NON_HT_DUP_OFDM =3D 1,
+       FORMATMOD_HT_MF =3D 2,
+       FORMATMOD_HT_GF =3D 3,
+       FORMATMOD_VHT =3D 4,
+       FORMATMOD_HE_SU =3D 5,
+       FORMATMOD_HE_MU =3D 6,
+       FORMATMOD_HE_EXT =3D 7,
+       FORMATMOD_HE_TRIG =3D 8,
+       FORMATMOD_MAX =3D 9
+};
+
+/* PHY device options */
+enum {
+       PHY_DEV_OLYMPUS, /* Olympus - 5g + 24g */
+       PHY_DEV_ATHOS,   /* Athos - 6g + 5g */
+       PHY_DEV_MAX,
+};
+
+#define IS_PHY_OLYMPUS(chip) ((chip)->conf->ci_phy_dev =3D=3D PHY_DEV_OLYM=
PUS)
+#define IS_PHY_ATHOS(chip) ((chip)->conf->ci_phy_dev =3D=3D PHY_DEV_ATHOS)
+
+#define ant_for_each(_ant) for (_ant =3D cl_hw->first_ant; _ant <=3D cl_hw=
->last_ant; _ant++)
+
+#define CL_MU_MAX_STA_PER_GROUP     8
+#define CL_MU_OFDMA_MAX_STA_PER_GRP 8
+#define CL_MU_MIMO_MAX_STA_PER_GRP  4
+
+#endif /* CL_DEF_H */
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

