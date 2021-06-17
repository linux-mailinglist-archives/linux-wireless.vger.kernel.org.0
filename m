Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63113AB92F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhFQQNV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:21 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:59907
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbhFQQMF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUHkSUIToduQwbxYgv+FcORcvyWdAwX5w/gWHAM0KRf+dsaNU2a5Z0cplq0imramS85/7YUclG3h2nO12oFZ2FN9HvWTqvYh8INiSJMB/n+sit4raR1v2oi1Mkz4ApLvczdbM8d8pxI71Sk14I/6bjT5ZOIGA0LagHoxZlq6oqo62Sv3v5FgvDDqhJKR+a4Zqjn+heJayLLHBKgd0gxtZLtu9boxaaDhXapkCZdiE3OMEAea1jQxnpPHuWT5DBfv26YFEx497eArErGTgE4ia2/C9bpNroVeCcihwNC6P/xSdEjZNbHmpegXz7CObiGj247Ik8JWd+pRM3cEUICoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47iFjpkeqBofYaFeXuHsoj1468+AUM3MOGMmkhnHRYQ=;
 b=G1Zepvpt0n9vp22QUD5uZGqB50JztoCLPhdRHD9u4GbdEhZchPhldkfVjUie/P29O5SodyLRJR9zuVWUg8hrh5rPCj/JY5XHA+E3Ym/kBeOoO7JDCtGdt87KCyMFKinxRf7so88SEs2Yas9zIEhMw/lEClW6MFBrGWqqYV8qZquxwWOVcmKtDfrLdt/sbtOeEybs9MHtBAKqYWP8fflnPa2JP0JuBdUsZ3uJXe6tChvAkevIWb5ZejCva410R9d9l1jbYgLpyUoRdZmSJMS/Nn9bkK/wQ3CwuEVrZrIeNTlZ0RHBTpnhLHDaJySVkL4HWzK+uo9cvScF+u4+FCYtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47iFjpkeqBofYaFeXuHsoj1468+AUM3MOGMmkhnHRYQ=;
 b=CD2kQ2Cz61YlE+Xg/CuN4F27SQJPpP6HDTkbKVALEEXwua+jwXtxJV8FU4d09kAHq5vCG08dhhokM+OBhYxbebS8adsaCCxVotVj7WnIj7rX0vYkMexGErpbho3qyFbi5cL2mKJXp9hzgy4T+I8yCM+6xhFOkxesshJ5GJxWr/s=
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
Subject: [RFC v1 234/256] cl8k: add version.h
Date:   Thu, 17 Jun 2021 16:02:01 +0000
Message-Id: <20210617160223.160998-235-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8571d960-6fb3-4c87-6865-08d931a9ed5d
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452795E2AA3A9622D584D74F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuJn7tZMbI51yACuJwubfiOcSUMMF213Ib2PqlgmZh1/uHenKO4NrbluyBs+nK+xIAJCMLej/LegxLxu/pnP0gykhGZ7iebBG/RJuOukgmzzGtaOR/BqCTTci552tL7Gn8qbouAan/okOTtTeUtuuxEssTMndGZPqwHAi/YUtSfGHtP0k3OZ1dAOZkvpcr6aZAtdxlqmlvun+AnzAqXpdoU9wRBA9R2U6BrdeG+0lQEY6YFGtSTF8U4cWhDGQzfqb3e2YiwbS5fNOCVXPjwnENKCDKcCHKZS7hFM925XvD5t9UPsicAkyv9ifXqHpurCej4RQQb4SKFGYuWztBJ/61HjavFm1aY8NXanzoIhIshL+zsV9bSyVhHq62TOicbEp0VSlesu+7FAbpJ/CG7Sq9Y6uXdu59pV0lWg2G6hDcYoerW65sd606v7rh4Re8T/2q5E2hTu+BTU/ju7jcFUSziPT8+D5lr0A7UfT9+WZRqoT5XNjMhsvGpwNMVQ7yt0ssYrzjFhLyWqsiLDEJ5O5/oAw0gwWcodfpjknT3ZVT0FBLQ7BZEhA0Hv8H+lvuPZoboIc5bfYs7JN6K+YLmj3ipNFaxVSdBfNO4P/ejM21JTAfI92BTg413q032LHqqatTJpgFlZiNKsB5/yp17ZrRcSR/eiV5lmHuFFRqvY87Zf6oa1mXTmJ/rY1r9pMiWbSJctpyAT/n/8y2SP0aJRJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQKvwP1UsoFXvol7S+3XGYRH3S8EhD50+D98bMuSRajF1WeZLl73tFNprpiV?=
 =?us-ascii?Q?6EW98oEscrmQ+iBGVNGjWDaPZjARZs4FHxWXIwWhJ8C3kCC7K2ul5kqEfQcw?=
 =?us-ascii?Q?BJfd2qWxPHcI0w+7CuE72laTfRhdQ1Y9oxpLpD7QnRqkpyoFgqKoVFlivBZB?=
 =?us-ascii?Q?zlIeYskfvuRmJiX+eFbyu0JVUJ4vAFa0YGSO5KdbqNtw19mFGJOtVlP4u1bA?=
 =?us-ascii?Q?4IDJtGQym1UKRomNF+GPkvpkawXB0CxMRzLv1g5aIz3UeZZ7gCbBISQQ+rmO?=
 =?us-ascii?Q?YT1YAHAKup+hOokWV4PqT2K4MiJcGV4BOOwDRR5/R1KpYqWdjy5AXT1Ww3Ul?=
 =?us-ascii?Q?Q/F7cz25Ah59O8zlf8vTw4IVkyTpcLl1/GJEjIxdt7WmQ8eB7o91Y6k7PZgB?=
 =?us-ascii?Q?f+wQ8iUCUhz5KD6ukn14DhvthTMb+wjYnuWcvsQ4qQ0PBWYvso7hPVBCMBMi?=
 =?us-ascii?Q?/rrTYyvvdx7NCt18/7/KpSFPgqqvWG2b5oLCvIUSGYNg/7bPIW7n9AvNa/av?=
 =?us-ascii?Q?EpbWq5bseSsqCryUGOjL9dFxeFG9PKqcCRrdWCB9tq5QWdFJ6Lvv9niHobQr?=
 =?us-ascii?Q?yQK6SfszMLGrLn5LqSgyv3KNkXVR8MrvQbcmDRRp3NE9NViJ2+/z3i01N0CP?=
 =?us-ascii?Q?PnM3QkBMfVuxGppvOWyCBgOl/KvjuB9KVFDYwiUw5cio0tVQ5ZnMgvxx97nP?=
 =?us-ascii?Q?1HBrK/el5zUumOHTpTzzjZsQulaz14v2nfO+THdXz13/2ajwIVbpwwuWGK25?=
 =?us-ascii?Q?lAeTo2qrEHCSP1SI/TwhXTS9Vw93QGurWQxQW8T8y3gNuC0x2yC0mdjZ8oz7?=
 =?us-ascii?Q?KJLU+jf1PU+YY6Ls/u+2y22hPmEg2Mn+KqGEHMFV1UlQrfEmVQ+jzg1fM/L/?=
 =?us-ascii?Q?B7H3VzTSV4oM91E2jzqKQ2uoUCO7NdHcnKWE0yDMILtvHGbzgg3jhOxUVPRA?=
 =?us-ascii?Q?oBXU63aRr3OjoQfA8Bw0plVAjHAx5yxcSGBkQVkN/1IYkGKs11SHfUXzHefk?=
 =?us-ascii?Q?d0kCqB/DWw0fQ2KFbBG4A1WaKljDASDj/zrk6Xe2Gt2vakiPbXTwxjsNiLlS?=
 =?us-ascii?Q?QkUggUlN6Z53V7XQVXyMr1Imh9sljHmSJS3g3bWZzRa18jCgjGXTaB/l9IZO?=
 =?us-ascii?Q?PKPkbT11K0J4paMzkFdJk8iP8d7qiDaTRCJwT/HicyZKesGvi1at3NdKW7u3?=
 =?us-ascii?Q?yzCp1IOBkHrn+ZhABTzXECIHJl0hHF5zP3bAcd7BBuZnk6H1TA8NF1nfdSoF?=
 =?us-ascii?Q?Z2EvuHxTKR2zNE3EIbF3Mj2kFtNf05SQpKs/La/Z7gQ6M9vlcuobFjQAce82?=
 =?us-ascii?Q?mzmI4r57knjvshty2SovIiDM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8571d960-6fb3-4c87-6865-08d931a9ed5d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:55.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Id01VGLCXoPVAgp7hdyRMWuA9OMYtLK6laBJlk5s57NImq8Gv0rzHMcq5m+LOVrBA817jZEVdAvMXz3LLZsYJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/version.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.h

diff --git a/drivers/net/wireless/celeno/cl8k/version.h b/drivers/net/wirel=
ess/celeno/cl8k/version.h
new file mode 100644
index 000000000000..d23a45487636
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/version.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_VERSION_H
+#define CL_VERSION_H
+
+#include "hw.h"
+
+int cl_version_read(struct cl_hw *cl_hw, bool reply);
+int cl_version_update(struct cl_hw *cl_hw);
+void cl_version_sync_wiphy(struct cl_hw *cl_hw, struct wiphy *wiphy);
+int cl_version_cli(struct cl_hw *cl_hw);
+
+#endif /* CL_VERSION_H */
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

