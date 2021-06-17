Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946F03AB81B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhFQQE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:04:59 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233513AbhFQQEr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/xQQVAWDZqfWrPWSBqQ/yGDJY2Q+sLD70apKPhXX9qTblGdMnuJDSOZYVaI2REQ3VEt7PYUxjQsEdrluhC7da90XxyTetd5FzY7DMaKL6+SPcZ7HIaRwQxenCbh/Nu0pIYjMgAxoTxXPMQPdxh07DZA9l+5tsWUEtA6zHASPRhw6/O4EvgfoOZhjBUr2DTiu8J/MUkFXA3BItlufMTRB3Xc7HEsZYc8Am2uA0SVlpWJZD/lsxPdgRYQuJdmukgtU+trMX1J8KZKNhxzdKWIkKFeRKz5RbmUQS5JkGf647uafjysjE+vY5VkJ40KDi+ZWBwEyobeNrDLICl1NJUutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq2QcCLvEIRaT1XMd10vknA3uFaei6sxuCFRMpc0BZQ=;
 b=lAkD1VgT41C8hCoHwpqxFaFJqGBvD2N4MpVXQRQkaIGStqKwsu3fk1FzQ+KzKfmlfBASW970gJd/RUlaS4AB53Mdb+8oE6mmL6IjNRSLV1130Ocxnz930/prO70GkLg46n9Z0xfgpPYNhl2Rv4uouSTnqYxxUoQ0gKQ+2jluVu9WkCOvAhCfwW+qVemsFz1cCmRSqngGSuNhUvK5duVryAesIsVcXj0fsJVQlplinxTmlxkHhG5ZpmENX+eSXtAjv3/EYDp8RO6zcwt9BXAUxHnY/v1yCeIegfxvmZzEN5Wo8bfOii7o7yXZUPMo1rCQWqkvHA/ichYOKGERME37YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq2QcCLvEIRaT1XMd10vknA3uFaei6sxuCFRMpc0BZQ=;
 b=CpgKlbONckAerJZ4m7IoR7ZdfiNNZwUsfzXjVxdVQNM8dUn2F3MxDcVHuFPHsSLTUraCYYNjw12xQN81PIsXGY/3qoWG05nqbwQdwHadBp9L566uPx10nshCYo2G4kZcKbAT9U2eyLCRX+nFYF4SbfOxfc60sLfQ4w3ib3nQlf4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:36 +0000
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
Subject: [RFC v1 003/256] cl8k: add Kconfig
Date:   Thu, 17 Jun 2021 15:58:10 +0000
Message-Id: <20210617160223.160998-4-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4784f96-6d5f-4b88-8f93-08d931a95322
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141203446A8B932D037EF1ECF60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCNXvKtxKW4EXiu8Je7cRfAdQiBgGeglwoW4mGaqlfn/fCQC9HhuhoqAqIwFIqVf3aHXCyy8nF32D34beESjnEl9j7uAwXiAHheq/yX4JEQlp4yq6QG5Gx7D2gegAwcjqywv/ofZU6jjBgykIMCzTQnsTllWhzhqgie5Qc6/cPY1V2zZmLoqBVQCoBBbetDgNrjgV228Q64Sje3gAFJ5A05EYBfUs603GwsdQQCkshzYbUXOqWAmBpDYCzKrDprZrEIo20rcMdBWdXaL0GsiGGWpfcwIx5MYUbmQUjUXkWFKT/TMejGkN1bpv/4DPE+k0+v2fT/GEA+A6ApVgJyhBgsY2QhYpT44PU6pTT3ELfIXiN4FADDeuichxJtIbKEwWL5O3WBhXjVcMgieh56TVnkvgVZ0vqegS4Cd37doejKxXXg+xHZjHNhKjKMBzKy/e/kDzLh9uouw1hLsxL2+oFVvP4WQmxl0jGLtilNCAOC+ei7opkTyTLa37p06g5avY4oJdEJ14+OtNL19k2Lb9s30rCUEfRKURVKMG7iHACsCwwhsH79zps7kolpMdCb3O063EbVHv/ivp7qowN87n5MuTRGhDfRJORlK3XegRy2+sG/kDxwK70n0sbd8HZ4VzU34Ytx3kK1GJsprpsI5f7H1xwJcVUGtCX7mGP+h4bTyagUKzDIxdp8uiZVmu5NS2gagUuF6xcJ4acq7/RMyOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vZV2ESeM9/8MWPBZfhn+Vkd/4QFcJ0MJG1ZHGmE/+338F/RAxkd8K7XIY14?=
 =?us-ascii?Q?cchqZZm9UKgMiC0FDU5wfxDJ2/hZbA+LVequ2mNesDJWU2UKKdya6nPpUrw4?=
 =?us-ascii?Q?Mo7m9dNdo/3r4clfSW3Db1R0QK8idg0A5f8Q9ZCZM/+bH2JTGtshJcuX+Xly?=
 =?us-ascii?Q?UubYTkgWTev10p1p2lAjgzBuU9xj/++bcT+PHxYxyYoT9xzZc/Ie77ywLo5Q?=
 =?us-ascii?Q?4RUGswjC7c5HtxS8w/Dzw28SkhSV+W4RMV9qmXA7QLjErq5KRto9zkHkEkRy?=
 =?us-ascii?Q?GJl5rIfb/2JbAB2xbeNy81LLBIV4lvWdOauUgNmTjQQBi9bVpteRnTChU/nf?=
 =?us-ascii?Q?a385jGyuoxaYN7MkWlDFrkjWujo5XQFxvqwF4LzOlKz+vvJE8yGMKOmyQZUu?=
 =?us-ascii?Q?ttB3s+bTNwwd5eBCoseUDpZN9PkDQCJlodkKou4nVybk5Kw/uy+Bd2n1ru7+?=
 =?us-ascii?Q?hGmPNHaStqgyYJaLVy+twAXTMYHBevhA0FBluMG16iahOgx/xFmHnVpEL/rl?=
 =?us-ascii?Q?CX2qL/Z3kurZS8Q2aIs72XBbffYsN9g1neRGVuLAVkj4w1bMd3Eu7ZQyJ7mu?=
 =?us-ascii?Q?OA4Q4eJZ3fKETuZxHSuFQ8yG/Fn7y5ZIWsFz9niqLoiK9XxMBCiI17hZr395?=
 =?us-ascii?Q?iBhVVOyedGimkN02OLwKd3t90BnM3ax40y8g7vjhzKjw5xrMv7kAnkiiM2hr?=
 =?us-ascii?Q?/pADmxqPmKMdSntGRrl4JxxrVWb/yYA+qVGxBNL6MBMJn21sc8ncjQmV5UWX?=
 =?us-ascii?Q?W7MJgTuDgNgkAeyCm/W+exnn/uDmBeYUPK4KbVQX99hjHT9RJgsgIMMPY8tI?=
 =?us-ascii?Q?jk3wTNIOqbKpeevEqh50KMQTrEcvkjIB+7VJ/YuE7ynaZRmAC5H5xr+pGrWC?=
 =?us-ascii?Q?AQddSNTpPm24frLS4KY3KNzKOIg7qiaOsKDzyszbP09hBhphAo1cBwOsOfgD?=
 =?us-ascii?Q?ZMARYUGVj7+TQ0sksCmC6HtTKS43etqnPo4p5Vv6JLZmwfSaL/E2wbmpcrrK?=
 =?us-ascii?Q?TLxjjVVc9kq7PbkBvfYtRj7EHn9QTh0Zzp04TBwSgG/M8TI7jAZCBfv/My3H?=
 =?us-ascii?Q?+UPTcINCL4S3hOnLrN6AdUa+q4derR3T2rAK/FETF1NptPQPP7s6WHuTt6zI?=
 =?us-ascii?Q?w9EAz6LfJkKUsGxrQ/hUTN9/RaYUs97/cANrk0wYl4+P8ugwq/sXSdsjQnmg?=
 =?us-ascii?Q?S04xI6VAGj5NEvOvjNCh+yrmwVttO9155i99HUx2wqvSKZCrC+eOeU+YggA4?=
 =?us-ascii?Q?v6DM2vy4p9o+Aj3S6cKgeCRVjcAHpg4gy7h1P0T3+lC+w42cRowQ/u+3SSfl?=
 =?us-ascii?Q?cY6q3SrpmP/pwFGtGrIC7yNO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4784f96-6d5f-4b88-8f93-08d931a95322
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:36.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmdE3JGuezvdqhhKzz+5ZcI/LemqTKC3P2QtB977uWFCkEXGHA3tRLIx76Xp6J32ZKw5kEXaQnWsrXSkLtqJPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/Kconfig

diff --git a/drivers/net/wireless/celeno/cl8k/Kconfig b/drivers/net/wireles=
s/celeno/cl8k/Kconfig
new file mode 100644
index 000000000000..452c647320de
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: MIT
+config CL8K
+       tristate "Celeno CL8K WLAN support"
+       depends on m
+       depends on MAC80211
+       select WANT_DEV_COREDUMP
+       help
+         This option enables support for Celeno CL8K WLAN.
+         Select M (recommended), if you have a wireless module.
+
+config CL8K_PCI
+       bool "PCI devices support"
+       depends on CL8K
+       default y
+       help
+         Say Y if you revision with PCIe-based interface.
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

