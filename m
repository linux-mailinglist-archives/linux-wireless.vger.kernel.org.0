Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED13AB859
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhFQQG7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:59 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231650AbhFQQGe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAom8CxtKUpUhljzW7GgHmnzOU8DA0BTQtanFF6ag2EUwydVVfqOZ5b1qsYyHgfDpzU/XZOPLZhW3y+yx26kPQsECYL+fOWlfOHpzeWRPxpsl2ftKuCi315EWwxP0fTQKQNjwLAXp6u2pHgzQNeDirGigXgCdlSj/+sPUGtMQAHg39j9+HOa6StwU08lEfLrghP/jWZtegnzCDTqFQHzQXMtYmCadspCWy/ir0sjD2h4bRa2USx/bluf5wd1CR0X84SYmjFTk7bQ/hwx3adT5GLJMG8sl0M2I30IkiXTvcZe4f/e0T5LMeRQ/c5BRYnKmC1eWSoU9zDOKidu9XY+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuDJ57GgpncX4wXETlQT0oeED6EKTVNWTxCxnDSVrsw=;
 b=eLXlW2ZC4xnErM/yoBgHbLFTOWa/T+FPH5Czwr4FtsrUnLGtWx0E5Vs+YtGFxitUcf4zEaApq+6KqG7nQVO2ch2N4yLTylzU0NLwknbLC1nFxyvZ2iFrkLKMIpr2J+RoMvg7GdIkaqYNUBdxAejszRtfISPopDZpjl2LqdmJ6ZuhKUOZNbwPVj27GZMKmKtnaaWNhJXBpyq+OsSbDafN8hMD9hOQ3kQDAVBQRpuYkcYZKtb77VMruZbUk4kgnAncGNVvocCBM+VBaRt0wbhAy938rnO9FZ/711SvX25pGI5uFfxcXF639mvmS27+TfFVj0a4Axjom0f6d1nMvf/l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuDJ57GgpncX4wXETlQT0oeED6EKTVNWTxCxnDSVrsw=;
 b=kzJgwVdxUpnw5XApKitdhGwboqshJVyqbeXumQzomFSOIpSCLX96BzEOSlXZ104vS7XE2wTHH8GmHfYjN3QRBvKjf1K7dTwwhoCndUfv0DBdUkswKo45zMN+G5J0oI1aqujmx8QhewEtVmoIBFcleYX0TtzEEQKYGzIQq78E45Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:24 +0000
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
Subject: [RFC v1 076/256] cl8k: add env_det.h
Date:   Thu, 17 Jun 2021 15:59:23 +0000
Message-Id: <20210617160223.160998-77-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ce9be9-454e-4df0-21b0-08d931a9835f
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871A2C130C4CA89673DFEEFF60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue9SQDyCoAPk0OM68fGxhfQ8zonD2bLZKQx1PZTKIpkdGTmbpJqih8p7qg7WpuHiXzYpmjLM13eMiFq3pJFnBME2baCTHhxgFB+KFbvHv4JUd0RfKL9utaRjmDh142sbK1Yx0JOgJy0Ni5dM25wkIIkf9LBUQtkkWsHNzVvnqmHlJnnFYhWVnQ/fGrI0r+C3dUNXdhcsWFVObT/aQS8NaxZlUcw0ky++oVrTG/MccvOjvALJueIRpYCLqVotGPpfeZRPux46WYpOlHUdSFi3HIoE09qOps8oNVtbFlWaffVg0FctRzbomASOUdUh7gkALKdloxrQ00YOm93cuoAnDx0Gb5phQ/rr/AaIl9i+4mDMaBFLn+1jF8vyZzlMu3zcCkW0DVfsAwtyD7JuXGVXr6D2cvMB3/ZVzyTf8CmnyBezLIx6V2jX1Os/4/goHW4Rg2MMwq3lnCz7MBl7OYHeAigr7RZVFaDmmLYVcn1hm54KlfpfvP96987P38cIbbfO04WgQmAWwBsjlsmsnV1wOov3B+8RGgLPh309+I8XvJhFDfmpu4FGwWY9JyChqbEZkND0i7z3cx5dQgjapKVJmlO1Abtpakn5w1d2PZMA8kiZd91RVTt3DsLvhotw8wgl6/4EluJQUb7gemEDM2llagTHbnGxfN+ZHEaY9HG+d0KCr/+S4Y2FF5iqz67J1mNmn3agR8uSFktjiUKKHjP+2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRrjb/0n6PdzDkArt3DOKCyIsdEhT8gStC40xhgTo8LaEFuzWUAh25qORICL?=
 =?us-ascii?Q?5xWtFCp2B7fGAzDdzf5iWotKAcqAdn64PHbWsI3ZrodijKjP3Ks0tWPQOVVv?=
 =?us-ascii?Q?3XGd2S8fLC4L6quX6Skhcq/9seuWbSt9FwGM4m9xINvgmWgaTQisMvd9/d3A?=
 =?us-ascii?Q?faYHFgT3+Tqrvt2V+d5PB1FpGUqxWxedhkqxWkc1w5xiSsz9js4xa/0B5T4T?=
 =?us-ascii?Q?djgKcgo8a87gpftoiymHzpXr/6FMcxsCYvrc3yFSHbMkOP55aWBsFCFmnnU5?=
 =?us-ascii?Q?/VMe30Awibt8wC749cTFwubUxp9DbcmNe5nv/C2d0/StNTdMqgb7J+4PAj6k?=
 =?us-ascii?Q?JHgQvIoKC8dORR45fBocWGnfyN4YnixoERlCW52YYDpcQYzP52hE6OZYBr3Z?=
 =?us-ascii?Q?5r4FJkKXHvgv419Mx0GAbDSPc8oL8hc5cEHud0BOia+0gHN145vb9mOKcp2N?=
 =?us-ascii?Q?+tG1GD/dixmkI396m5Ca364gdQD0H/vjY5sUQmi3D0ejyiknIug7LGAvNOsh?=
 =?us-ascii?Q?zinUspQm4Z+1pRewq0Y4L3gENET4cRp3xbFVT8B6co9yNLkgz9I0+HSQPxDj?=
 =?us-ascii?Q?T/47OCmgbVtknKjXTGiTMR4VQwS6qgT8T+5xd9PIDQ8si5UdUx7bZ//GpC6i?=
 =?us-ascii?Q?WGg86qtFyXaVMLGxr6/aPDWye0+xnicUBHrujmokS9izKlV3EYWLhTGvkIsM?=
 =?us-ascii?Q?Go0jRXmkiypvuD66inx2K4iqF1hD197XDR09ylBkHxrmS7qnhR38J3Ae34u6?=
 =?us-ascii?Q?3rhIighiii0UnMiZsrJAjdM+PS1nQ8Lgcam2+rKRHm7BL6k67Kq41JdKMufo?=
 =?us-ascii?Q?rbArgfap11pwbRzSjshT483SkIXFKC3WWayhKR2QqP4pLMlCXllBr0vKQEcV?=
 =?us-ascii?Q?cBNLsm2rGEazw5tLq9MmUC8H6Rz/GVDpt/GIxpa1fzL58g7Di4nV2eWlZzyX?=
 =?us-ascii?Q?6QYsD9YVtioZnAad7F+ztcVdvJYaHVAWZE6fDhZJDO8B7gKUzNoW9z6bo3n+?=
 =?us-ascii?Q?zBQfA56ktZ3m875Mvfpz8+z4EW9ZVodxvHrSRR3V1O9RG1/6o3+nmBWThnYz?=
 =?us-ascii?Q?bjYsMPWDmv8ormS8fVGFWppQVQPpTxocMEwPpaedIM9Rnozd2TCUBqXFfzJh?=
 =?us-ascii?Q?hrXDe6klHk2fUfmApVUEvrKQrlKSGur4/T2KHMPyY9NxbaoO2e5u5KkCcZJt?=
 =?us-ascii?Q?/BZbOHPDOhqJHVVC/3LdYUFzP/CrEVi17gDTPeRVClr22kDjb7R/hiFF2vq5?=
 =?us-ascii?Q?PaU474zkZbwhpv2Bvzf+cZFibyXLqA7r3Q71MAKMxihgRUSPU4mMLc1WGfnp?=
 =?us-ascii?Q?+ZTNBVz0h/WHl1MpFe/9Akl0?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ce9be9-454e-4df0-21b0-08d931a9835f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:57.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LwBudwfjJ0dA6QYP3xtxumAcpoICUk+ze3AWo5ZWYcZmG/vCBksRO7epMA9a9yxeFY3llikwzGoNKvmdP2MjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/env_det.h | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/env_det.h

diff --git a/drivers/net/wireless/celeno/cl8k/env_det.h b/drivers/net/wirel=
ess/celeno/cl8k/env_det.h
new file mode 100644
index 000000000000..b00940b94825
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/env_det.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_ENV_DET_H
+#define CL_ENV_DET_H
+
+#include "vendor_cmd.h"
+
+#define MAX_CCA_CLEAN_DEF   20000
+#define MAX_CCA_AVERAGE_DEF 300000
+#define MAX_CCA_NOISY_DEF   850000
+#define MIN_CCA_CLEAN_DEF   20000
+#define MIN_CCA_AVERAGE_DEF 100000
+#define MIN_CCA_NOISY_DEF   400000
+
+enum cl_env_type {
+       CL_ENV_TYPE_CLEAN,
+       CL_ENV_TYPE_AVERAGE,
+       CL_ENV_TYPE_NOISY,
+       CL_ENV_TYPE_VERY_NOISY,
+
+       CL_ENV_TYPE_MAX
+};
+
+struct cl_env_db {
+       enum cl_env_type type;
+};
+
+void cl_env_det_set_type(struct cl_hw *cl_hw, enum cl_env_type type);
+
+bool cl_env_det_is_clean(struct cl_hw *cl_hw);
+bool cl_env_det_is_average(struct cl_hw *cl_hw);
+bool cl_env_det_is_noisy(struct cl_hw *cl_hw);
+bool cl_env_det_is_very_noisy(struct cl_hw *cl_hw);
+
+#endif /* CL_ENV_DET_H */
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

