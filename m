Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B573AB8E9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhFQQLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:07 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:58683
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232789AbhFQQKB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpNo+qijVckv3WZn6MTurphDUQklCHAAc6Ifq0cC6fLNTiuP11o4hREJz07NAwrPIRObjSTcAx8qnqUZcuDXuzh7maF+6oEMkDWwebotHq+pC0pJ1ObPNgsedqfHPXfhSddAZd/NuiXLJpeCChUZpeige/fBVOAJYA8qm3k4yjcSklh1KaoIBy7S7R2tDtGjiOsatNJZiuTcPyJ2gWX4Hv/69uwROz2r+742M4I+htiv29iixLf9NVVMGz6MduVfrPuETl7TW/yU7RdZKRNLonMkDriIsH4DkiXBCoK4SvYb1ib/66Lz9hLUBBJVXCFxOhTAXWgl00S532kcqDcDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hznK1YfdOA925gaM2jpd/VA9ywYHDkkVXWjFdifa6YQ=;
 b=KlHyz2At9m59ZO2S/1gJmwi9cLdkLRookGXkPZyKoUHHRdKRxN0dXpO54mfVOVc+PzB7jZsoqGMPsbBg4Uxq7mnERK0uI8y7EF47xzcY+nUeV0b3q4gPnrRcj4cSSej0DrtujfVSnyNv2siviMkETzr8ljpbXmMHqDEEMLpbUMcquHn5FXeBTEHZSHpN1VPDo+6Os63bpvZeZj8r+/9lXthMShYTUBPTba5h2cIwLDuJSn+Zzy/JKJw1TYMyoINwBrpVyAFNBq6K1tvVEE35qT93m95fw57NvdZgfQ3c5BnfUJkC55zgMp/Pm80S8dT8tn6HlfUFyN19khcUwJNKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hznK1YfdOA925gaM2jpd/VA9ywYHDkkVXWjFdifa6YQ=;
 b=OfhkUw7SiOFh+gytRK+ZMLnW8ZYN4xaW87dAa9OWkXIXGH56vwBPsjoQl5p6qG2MIXWC13Avc1IQWdt2iqQHUq8bel8zmlG819w2PQJnVfB+2Yvu0ooAlaS0eFYOY4deHPhXRDPRJupt0D1zkIIqp8q+WSNCcvw+dZ+4RZQwp7M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:50 +0000
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
Subject: [RFC v1 210/256] cl8k: add tx/sw_txhdr.c
Date:   Thu, 17 Jun 2021 16:01:37 +0000
Message-Id: <20210617160223.160998-211-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d0896d-3668-4561-69db-08d931a9dc38
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB13297F7A259725E7BC66C9C7F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRw2JEhDD5D67Xo5E0y3+bvFws5n6agtZawyCVZYfZr0sZcNUF9mg9jQ/0ftBJqJScC3QdDH64P1KK/qJS5Mk/ZIcxyZjQxJ2ooxS8wVHhz3sgQE6i0uYMKZpnEIZ/hxF4pfl9mDjFDpIxYXvUi7VfZ8sqh5UGHgda8l5LR/O8JxWymfhtEO6C20HYKW1ijOdW0eh3vk7uI6eL8DAeoNga75lxk8v58fQsqVuC7Q97egRRbUjn57cp292OQ6PXw2LdqSGqNP4dCbLAx4d3tglV63AW0n42MMP2pCMtrH1/tjk6c/Rhg6LAwbC+X1T3n03/u99wnMs85GqtjH7VY6OcDeN/yd8nVjyjem41vOpC5JXG9NG1BEJWTx+ZQKbaLX8vuwuHklJPfWVSpdkLon54L/VmEiLnjsRC2b6mX40UcyxHCnOD9k2DuCItHvNRlgsxZYiWbzU63b/sRNhJqSYataIGykB/B/nGbU9iXDq1vI0pFJx778S/C7egsMUIy015bXMYFAPJsHfi6ZURY7dO+VnGnWh1udTyaotkZA5DbYeTUMw3mFsoBbrSmEx5yU7qESTxSu6ae0cAZzAC6ZViziHHBS0Ne0DIcnOxqR3xPZX7l4SaibVyTK5Xj8IdfhPahs+S0fND+XnL5fgMtWbP1Jlelv5FGhnLjhp1FeP2m/i22FMJ5lM4PQB2lWnnRFnsk6NXCs3R/nicCajkTJ9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AR8K4vtLnL49NvJEuGnMcpFCFLhQppeBd8iQKcz0ppsEquilEiINLN3Ez6vn?=
 =?us-ascii?Q?JGYACkn7US8BT1IUlbsAX9+V/Y77M7rZ+3fwe4MXsyPi4vIOwNPyEZCVI6gA?=
 =?us-ascii?Q?bxIOC8Z3nWhVmqhh6PX7LUXlUdTYWAASZsy5nB+6F28ss4CavSo0JhKaEnb0?=
 =?us-ascii?Q?T1VudPzIr03c/Z3kjK3A3K6JrSQys4ruz6rjMws65fllzrN9CCUuodEWV8xN?=
 =?us-ascii?Q?z7rZSImkCoHtscO8QpU8Aj8cDmmVckL2d4nzWpxRmwnu6P8d9n5fkPzR7vvh?=
 =?us-ascii?Q?eYjJs0/yjiLmT/V4l++TeKfMNzpcTebmyQKW1AAtgTZ34oBP3Vj3Nad11f8C?=
 =?us-ascii?Q?XvFdJOhcB069KUaRKJVeW56IJvxDUFL51U+ylbnJsLKjguKBThjg/IJQpFKH?=
 =?us-ascii?Q?N7KmcDaJPGvQHkOUnNLWEJMFu4pYyUusivg+qIHOovruT1jJiCaA8Zobh7aW?=
 =?us-ascii?Q?qIVwoQP4iAmUnIj/7s3qOfyE94YQPQdlm+dxdneP0Ah573wFU8A5ztFiNqaA?=
 =?us-ascii?Q?RFrVMXiWe+CeuamNg2XG0JrF2RjwrvKkU/ZMpA01iDicRjoFqhXhGeDoXOzV?=
 =?us-ascii?Q?eLmEWX+nNIsqR5ml67gEGpscopSP2X/glVaKXJyNwLKLw6MGqvbKYop6mLex?=
 =?us-ascii?Q?ay5V2dl4KGWCJqpHRGPa4DIKHEqd+P/NfvxWVwtzddGpnyXwE41+q+OHNdh4?=
 =?us-ascii?Q?l4g+n/0v70KB8BYg4YmGj7gGGWCiEk9EHfAIRPn9dWdr0ggyw+NG8HjMnew/?=
 =?us-ascii?Q?x6aA3LD+IDSQ8ZWShM7jVPHv9GmgDf0K5GJ2dYOFw0Lb6xVEMCOSy2y7jIAC?=
 =?us-ascii?Q?YnbpBAK2wF/fZuKzM7UlDRt3F7u4qRCkS8henZXk1QlCEYVlcHQzxQMcosfP?=
 =?us-ascii?Q?t7hlNLNSEfy3lBSDbwXLxKGh6VcEXW3MJZUl0FRArPJH9W/qZdiEYCj+Qmad?=
 =?us-ascii?Q?F5tRZXYSEQ/UtiqcZMmTvji+8hKym1hbH8WvrVNY7SKZJK6R7XbKNyCLUXgC?=
 =?us-ascii?Q?RtBTJhpFFzfaUars2fQueIWxhCCezq7QA0fcLRj0pgXNN8f/r5eVzUmQI/Xy?=
 =?us-ascii?Q?euiLgvZENrHn5DxLVfK/1t7+WAgviFDFBpFX9Xfo/BNSWjhdzekt29ErjHVQ?=
 =?us-ascii?Q?Ji9wN62onTrdnX1CSqHcfpGs0gWo3KpsdH2uJI4Gnjxa19Oiflb1yKWcTraA?=
 =?us-ascii?Q?e9i8u9aMJ8F7abm69w0KT9B/I4YQ80HW5Vz/kuoItvm55Q7LR07jjSFdo0hq?=
 =?us-ascii?Q?aRUDs7wFq9IJCmF0I4RCQ2QyaJm6p7OSo9MN8tktUwXl3s9o3R+9ZRfqPWhf?=
 =?us-ascii?Q?yolrwrtoEYHpL3aJCVQFSIH7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d0896d-3668-4561-69db-08d931a9dc38
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:26.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKUEL7b+thm5YKlG2WqyEPtbWzXk+1VNFX7zwTBDJT252uFEALTeI+Ei4olrwH07rcKC946HuAOBFmqcyaRSbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/sw_txhdr.c    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.c b/drivers/net/w=
ireless/celeno/cl8k/tx/sw_txhdr.c
new file mode 100644
index 000000000000..3ba63ab9a335
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/sw_txhdr.h"
+
+int cl_sw_txhdr_init(struct cl_hw *cl_hw)
+{
+       char sw_txhdr_cache_name[MODULE_NAME_LEN + 32] =3D {0};
+
+       snprintf(sw_txhdr_cache_name, sizeof(sw_txhdr_cache_name),
+                "%s_sw_txhdr_cache", THIS_MODULE->name);
+
+       cl_hw->sw_txhdr_cache =3D kmem_cache_create(sw_txhdr_cache_name,
+                                                 sizeof(struct cl_sw_txhdr=
),
+                                                 0,
+                                                 (SLAB_HWCACHE_ALIGN | SLA=
B_PANIC),
+                                                 NULL);
+
+       if (!cl_hw->sw_txhdr_cache) {
+               cl_dbg_verbose(cl_hw, "sw_txhdr_cache NULL\n");
+               return -1;
+       }
+
+       return 0;
+}
+
+void cl_sw_txhdr_deinit(struct cl_hw *cl_hw)
+{
+       kmem_cache_destroy(cl_hw->sw_txhdr_cache);
+}
+
+struct cl_sw_txhdr *cl_sw_txhdr_alloc(struct cl_hw *cl_hw)
+{
+       return kmem_cache_alloc(cl_hw->sw_txhdr_cache, GFP_ATOMIC);
+}
+
+void cl_sw_txhdr_free(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+       kmem_cache_free(cl_hw->sw_txhdr_cache, sw_txhdr);
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

