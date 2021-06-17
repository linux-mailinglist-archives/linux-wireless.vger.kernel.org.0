Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADA3AB852
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFQQGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:30 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:17172
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233658AbhFQQGJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdSthIEx294OzRDIjifh34UP/Li1boadt8BmTlxPtG3yc7ZcdhiGdzKEkkkn08laz3v2D2jaxWinWDWwZ3LAUP0HQVafoiOCZUGQdg9Qndpl2rgsBRP8HeDJzycBqqQrXnQTnaEFH+XNjUKmFRoZmO/AOsNdxc5GEdkC2L8tAK814XjEntXe5OfTfjw3hr7vnlA+cAJqzCaXIspQZeGw4ve6kT26pO+lUD3Jx/Apsh2/hKd+iZ6iyB3h988R9bgEpf6trgnyooX5LOgB35Hr6x5POgh1V3JIIRKgGZE+0kdfXeMWxwqe6JWTdwedhHE/KbHGlAG3q8bDXwL1TC9p3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwuvoILTbpbwnCbWZuxd6YdxG2AJSdCL72/oaNg9a/E=;
 b=oZEpSdqlvPm6JgMMi7lKHztGRxjoFrblISvCbPCvXLwvpGp8e/7CmSxHDWwmFVUP0fKsP8YSbOWxod1uQB3F132geVcJxMPnLS0nRILaDBv4nRks5m4RFeV/nbWkug6HaBZ4aN674DaEgVRFfI0Y5/hwapJgjJtls7A3qkyPnT8ePGEaxSBPsn1CxK2qdgnOWZAvMigm4IBxREraGcFnLiQzx5QOQL/GEIznhxlD5RVTvs76TuTZSGCeE3Gvpr1d4isiQ3knAjOyGyMyB9XBz3PBpcN8LJsa3QxTLNGx5DRZULEN7ehIwopwLdv3RLycIUzISjeVeUihpNHrvhuLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwuvoILTbpbwnCbWZuxd6YdxG2AJSdCL72/oaNg9a/E=;
 b=p/RHpLbwFSeWiWhpYhSGya1YJ0ywHLOSoF6Dhi7oIpWOQKmfQH0ft8gTBcXxeDgNmAmqfcLQRmcKpuG3AR8wzzyYzKJux0U4WjtJC73hOw9iWlqLzaIJybLAWFYV3l5eWYIhXY803xn7wxRiYavxYaSXmdEKfiziA/ECuj2MPtY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:46 +0000
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
Subject: [RFC v1 054/256] cl8k: add debug.h
Date:   Thu, 17 Jun 2021 15:59:01 +0000
Message-Id: <20210617160223.160998-55-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 307a1a64-d557-4a01-a484-08d931a974d2
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234E6936B58C2477E2CE2D3F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoKoPKdmJy+4OgE7/I7g3ATuhjICCYIPRYp38Er/gVqpzUykOwL45iCAs0Ojlo3aDAibBRtfRo8QAol/OJaXtokVtVqKpSwc73UX8cOjQf9tpRu7W7D7yrtUTgIDBOg003WKcfqwOVGyyW608oC4fw4aPa2O+EsxMIFGXlaaaOy6S4MOIMjRDeuYGKSCQ46V/ElNznd2ivaDC+8Q39AVx8kEhuWEu+rvtpoTKoCUTKUtN61Hyud28+7z0wLX78y5AUrGE6hAHnYVjs1McCBhVvW5qI12wdoM/DUNegnO11cgQdm66qPWJ9DMVp4sErPYe0HatOx08QtYnOpGCP/X4/A8oK+hfpkJi+ACva+kFC6tbbr2VeJxNrpk0RidB1Vt1hCdX/YeUhz5RXkcuHdymf43knDGJyRmXDcuMaIocJfIU0iyx7Zskk71g60hG45SNtcwQKGgYgCOHR59I+3vEtFDZfMNWIhmwiEQDwSctTNQOtxtOBK0NJmwk4XnIFbSICYQm1ZowpdEtoAAwEnO6/EUJnxliOoCDvPqwnfgCBSMmviRlUcml49xLL07qkeQXqSXN3kEUARPCOEbXXdzeymg3kRQCE9DQXrsXDx3qCv1IwKM39tV3KImQzbdLLMZiHfmxOgf+GVTnz+sKmUe8HIYQ5ZVy/AwZlXkOxncE7j2Qp4ZMyJnV0A+lz22ca4NADbiwDD9o59qEGTEc9q6DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2glHhleHdaxWKrZmXqTXUT6fOr7avDSZwtMkp4B0g5FwgkKH+glZF8bnA3Y?=
 =?us-ascii?Q?aHFEq5Hw5jvmiPxrfzw8ZwXM8dngEktLCu8JobMNCImeic3Paz1iqhIoMtB9?=
 =?us-ascii?Q?rGaTtxKqdwPnny+9sXfqr70ZC/jfDoXd5pUVtTYQ8WeYUVpS7+yimU//kxwA?=
 =?us-ascii?Q?qnb9iZ6Uj2rmMlsEMasoSesthGGGznbupyjFtPJGsa+NMOYbbBynora/s/8g?=
 =?us-ascii?Q?RDypyRydGASYHe/9sl6vu1FUbSoJd4y7xTWub0gAs/rRyjLJknA0NJMTIkWa?=
 =?us-ascii?Q?F/A2WcakpiaVjiAopITTpG32xLfnTPIsGuZ4LfQWzpUYv79xKOvXba5GwYVz?=
 =?us-ascii?Q?xkMOG2qrppPlxf0MlZrQJP/+wSbVi4mjPdP1uQ8PpiSV8TwiwU8qsTpt7LQU?=
 =?us-ascii?Q?SFtN7b3qC+kzQZkisZrIpSiAlfEDf0AdggaVKi2UreyFrOFAOtb7o5TVoj6M?=
 =?us-ascii?Q?zZjKsdl9VWvjZZQThZK7XyqAZH2a43GuTDFtS0s7MtpNPrRTM56T4azuNQwZ?=
 =?us-ascii?Q?/b6V9O135gG4vv+5/zBanEmbmNaK5LfdlhRxA3Rm7zm6RiCPeoEqRImuGI8J?=
 =?us-ascii?Q?fgfABJ1i0aK4jPVGdrnYow/s3b0IJuWF6AovVWphT7bhUEPlL3zCXBGqZTtx?=
 =?us-ascii?Q?IfFmzHuG+TrIeLLwCvL5vJP8KCZ/aWDJyCCaORSGftRlLLuIabANz+x1eIX2?=
 =?us-ascii?Q?qhcPd1u1E7RqS6+TJUpT1Uy9+NjBoN25dUQb7BGYjg4uPBwDSYLRrsBFiCXc?=
 =?us-ascii?Q?GBD5TQcIDX5Xep0LtHQZ2RsF9nqL27SNiPbRbrpUXPUjY1BtyNPNyL1IBJi6?=
 =?us-ascii?Q?aDThPGI8GijLmNRAbQqOmYsDKI0tbQ8A5nzkTU992ciEeSPp6omYK4nGZUIs?=
 =?us-ascii?Q?AJ75ebBZEcJj1G6Lvz9fw7vLJTn6UfNcXh0aao46UpBGCH28EdR/7odC8lto?=
 =?us-ascii?Q?5Xf57nLlnbMQbKttCpl0doO5D9DBwze5/FB8m2uXh5yzzz35YIZmM07Ad92e?=
 =?us-ascii?Q?KpGQXDABHa0JLihNOOpzAH/mjSKoGeEPP36a0HB28PctmSFV57j4yXBkTrrI?=
 =?us-ascii?Q?Hb0Np1zkxjzqt60G/FyyxchOeOhZustrFgtxc9ZQwrG1ED1cPT6/jVKwL7A3?=
 =?us-ascii?Q?G+l7tekiSXw5LLMXJiisNlXveIZCBqfn9mP8cbz/ZFZVYKy1vIcylH9d0DYG?=
 =?us-ascii?Q?ngP5yZGZZX445fGQg3Lng777F+rRdJ1EX9vMTOrb9VGAYjrgfq1+AuEeuwA9?=
 =?us-ascii?Q?tdqKRinxmukWvy7mUv/8zmc2QoHTve4Nrf4EAOF4ywmjhZmb6aUUtKgHJzjn?=
 =?us-ascii?Q?5FNcywZm0GhP7Yk28pXL04J3?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a1a64-d557-4a01-a484-08d931a974d2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:33.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSpTqisevZgoZxlMjfwQw1pTFxjDrR0HFHVcLYY0CHNhcC/rltMs43etGW+7OMwarfI8Ngjz/qMo8LSYawWEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/debug.h | 121 +++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.h

diff --git a/drivers/net/wireless/celeno/cl8k/debug.h b/drivers/net/wireles=
s/celeno/cl8k/debug.h
new file mode 100644
index 000000000000..f51591755051
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debug.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DEBUG_H
+#define CL_DEBUG_H
+
+#include <linux/string.h>
+
+enum cl_dbg_level {
+       DBG_LVL_VERBOSE,
+       DBG_LVL_ERROR,
+       DBG_LVL_WARNING,
+       DBG_LVL_TRACE,
+       DBG_LVL_INFO,
+
+       DBG_LVL_MAX,
+};
+
+#define CL_DBG(cl_hw, lvl, fmt, ...) \
+do { \
+       if ((lvl) <=3D (cl_hw)->conf->ce_debug_level) \
+               pr_debug("[tcv%u][%s][%d] " fmt, (cl_hw)->idx, __func__, __=
LINE__, ##__VA_ARGS__); \
+} while (0)
+
+#define CL_DBG_CHIP(chip, lvl, fmt, ...) \
+do { \
+       if ((lvl) <=3D (chip)->conf->ce_debug_level) \
+               pr_debug("[chip%u][%s][%d] " fmt, (chip)->idx, __func__, __=
LINE__, ##__VA_ARGS__); \
+} while (0)
+
+#define cl_dbg_verbose(cl_hw, ...) CL_DBG((cl_hw), DBG_LVL_VERBOSE, ##__VA=
_ARGS__)
+#define cl_dbg_err(cl_hw, ...)     CL_DBG((cl_hw), DBG_LVL_ERROR, ##__VA_A=
RGS__)
+#define cl_dbg_warn(cl_hw, ...)    CL_DBG((cl_hw), DBG_LVL_WARNING, ##__VA=
_ARGS__)
+#define cl_dbg_trace(cl_hw, ...)   CL_DBG((cl_hw), DBG_LVL_TRACE, ##__VA_A=
RGS__)
+#define cl_dbg_info(cl_hw, ...)    CL_DBG((cl_hw), DBG_LVL_INFO, ##__VA_AR=
GS__)
+
+#define cl_dbg_chip_verbose(chip, ...) CL_DBG_CHIP((chip), DBG_LVL_VERBOSE=
, ##__VA_ARGS__)
+#define cl_dbg_chip_err(chip, ...)     CL_DBG_CHIP((chip), DBG_LVL_ERROR, =
##__VA_ARGS__)
+#define cl_dbg_chip_warn(chip, ...)    CL_DBG_CHIP((chip), DBG_LVL_WARNING=
, ##__VA_ARGS__)
+#define cl_dbg_chip_trace(chip, ...)   CL_DBG_CHIP((chip), DBG_LVL_TRACE, =
##__VA_ARGS__)
+#define cl_dbg_chip_info(chip, ...)    CL_DBG_CHIP((chip), DBG_LVL_INFO, #=
#__VA_ARGS__)
+
+static inline char *basename(const char *filename)
+{
+       char *p =3D strrchr(filename, '/');
+
+       return p ? p + 1 : (char *)filename;
+}
+
+#define TXT_ERROR \
+       do { \
+               pr_debug("\n"); \
+               pr_debug("#######  #####    #####     #####   #####\n"); \
+               pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+               pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+               pr_debug("#######  #####    #####    #     #  #####\n"); \
+               pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+               pr_debug("#        #     #  #     #  #     #  #     #\n"); =
\
+               pr_debug("#######  #     #  #     #   #####   #     #\n"); =
\
+       } while (0)
+
+#define TXT_WARNING \
+       do { \
+               pr_debug("\n"); \
+               pr_debug("#       #   #####   #####    #     #  ###  #     =
#   #####\n"); \
+               pr_debug("#       #  #     #  #    #   ##    #   #   ##    =
#  #     #\n"); \
+               pr_debug("#       #  #     #  #    #   # #   #   #   # #   =
#  #\n"); \
+               pr_debug("#   #   #  #######  #####    #  #  #   #   #  #  =
#  #    ###\n"); \
+               pr_debug("#  # #  #  #     #  #    #   #   # #   #   #   # =
#  #     #\n"); \
+               pr_debug("# #   # #  #     #  #     #  #    ##   #   #    #=
#  #     #\n"); \
+               pr_debug(" #     #   #     #  #     #  #     #  ###  #     =
#   #####\n"); \
+       } while (0)
+
+#define INFO_CL_HW(cl_hw, ...) \
+       do { \
+               pr_debug("\n"); \
+               pr_debug("CHIP:        %u\n", (cl_hw)->chip->idx); \
+               pr_debug("TCV:         %u\n", (cl_hw)->idx); \
+               pr_debug("FILE:        %s\n", basename(__FILE__)); \
+               pr_debug("FUNCTION:    %s\n", __func__); \
+               pr_debug("LINE:        %u\n", __LINE__); \
+               pr_debug("DESCRIPTION: " __VA_ARGS__); \
+               pr_debug("\n"); \
+       } while (0)
+
+#define INFO_CHIP(chip, ...) \
+       do { \
+               pr_debug("\n"); \
+               pr_debug("CHIP:        %u\n", (chip)->idx); \
+               pr_debug("FILE:        %s\n", basename(__FILE__)); \
+               pr_debug("FUNCTION:    %s\n", __func__); \
+               pr_debug("LINE:        %u\n", __LINE__); \
+               pr_debug("DESCRIPTION: " __VA_ARGS__); \
+               pr_debug("\n"); \
+       } while (0)
+
+#define CL_DBG_ERROR(cl_hw, ...) \
+       do { \
+               TXT_ERROR; \
+               INFO_CL_HW(cl_hw, __VA_ARGS__); \
+       } while (0)
+
+#define CL_DBG_ERROR_CHIP(chip, ...) \
+       do { \
+               TXT_ERROR; \
+               INFO_CHIP(chip, __VA_ARGS__); \
+       } while (0)
+
+#define CL_DBG_WARNING(cl_hw, ...) \
+       do { \
+               TXT_WARNING; \
+               INFO_CL_HW(cl_hw, __VA_ARGS__); \
+       } while (0)
+
+#define CL_DBG_WARNING_CHIP(chip, ...) \
+       do { \
+               TXT_WARNING; \
+               INFO_CHIP(chip, __VA_ARGS__); \
+       } while (0)
+
+#endif /* CL_DEBUG_H */
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

