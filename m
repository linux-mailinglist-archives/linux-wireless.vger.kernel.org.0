Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200833AB891
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFQQI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:59 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:7360
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233607AbhFQQIB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lByKSEzocAjV8L0TLbTvJyOpDqkVePrkRqEgXq5AFRDeWdJbfXPkeVrluphadqxyGIOQooNk2GLq/fCTP59cYdo51akbQGv0L/RRhPipiqEuSdzUMSGVJNjToXeKf6RlfqsmNGU0rWNZAEalX/nMKStX2WKr5Tt1bOn9AQ/PFGb86/PItJbIHTTEQs8q4amBrJI4RAqGODyRNJitTi9I9Qup1SO/cu4g1jKVdIEyS9EyOt5xxTB/OWAweO4HDB/xeO9Bb2JAUk6rb1ivIi8SHifpxXFvvVo6vOO81NQygYRcZExz9PIPj9E4rXrYmUistz+R2Y5rbg9gGjXLD7rtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpCijZ28gADPwHG3G7BXjmNM+GD3YYnARVLWvgW6GgU=;
 b=Vfns1hZJ8Ht3IwtgCHJWKDkOwcnr04s4Z1o+tGozPyN2WNIc6q47OUhDHlFlu6ozpeNgNK7AVWgP361bS/KEVI3ojwzsSrpkH3LooBpA7MwWHdM3eYQ2Ofof+BEUFq6riPAAxQkkicTtVx9swbEtNwuy5sLGi40KMi17Nx5nRGabPWM4iOPZfrSZexNktN+kFdMidbtE69hIzYRI1z3ICt50XSq/TrUbB3LgaopfvfJS82l5OOG7tl7QemK49Lt+kx08zV4Eds9Zs4FjRjLaf+1H9+CYRIpHW0yj3KzreCM0HOHs7/CiLozOtA2Y42IUXF/xaamTAV07ZAztsYVTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpCijZ28gADPwHG3G7BXjmNM+GD3YYnARVLWvgW6GgU=;
 b=RsS/75S1VkmgGDdOPfJvOf8iz/VGKZ+tLwVkBNSS67xdUa1MiT1sZAoxtv5aqJuNnQZi38CwfgC739bG2z+lLymNDHuewC4mT54Cjqtd2sxws7N9o91yr5YxTIH7DPxQD6rKBYpMb+3dVeN8K8z+0RUlsnPWRke6Hyuo0Jz1CwA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:29 +0000
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
Subject: [RFC v1 089/256] cl8k: add fw/fw_file.h
Date:   Thu, 17 Jun 2021 15:59:36 +0000
Message-Id: <20210617160223.160998-90-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f71efbff-f7b4-4f7e-ec31-08d931a98c10
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB087160B2DF638DC59C5EEFB6F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nko/JA4DtW4ZslUHTETSJlF652RTgNL2FcnLPtowVdwZ3KPLH/8zOcGyCR6Yo0DO3l2F/werp6LMsvNslLJV0tPqguga7HIKwBwQCc+kr3h8wtTnzwn4N/T8NpbXnDEFUdhpZvtCUdQE7tlchM+ATGpWbSzPaf0cUoo3+gD2O6h83lEmKkAg7Tg3R/W4GJgRMWwIq9AnzTS2ils8Xk5iU9tB8Ia58KILp64+Z56O0E/2uOgA9EqjQmgh7OfKm8N8TAnpi8vc6HHQQqK5FqZHIax/FeoYPCGmL3E8wv5R0KxLxcgDkG+hsxHlnCqL/W4p3hSfNpRWlBHbIHsN+qNu+ix2jZubKIKR8P+PqH1XK2z8gmrSE8U6guMgqEmvDtm+69bMKV2Jd4b8atzxNeoaa4yrtKWa6n0sWkpxQgPV4LW5EbblfkgsXCV9K8nUS37bV78F4DnpHBr2HmK9ty6WJJoJmvYvgslm2/LoVyQU41z1wXkqf3W5PyhV+MTWKdigKedI0DeGL4cCRSCUG6m/mkiQG1fMxF/ZoAoHV4TZnZwUlTwZKv9av6U0qU7CwccW3AhSXvdWJ1ZpVUxW2qvaqfONNiDtCr9MUU/c9Tk4fZMNXyRgBgj30KHlGXft3AFPW95z734PRrc2PsmShHBUziSYsZva70SIXFCy56jw+A7zdXxF3hNDhsPSJu0vv2czESyBUGcV0fyI1WUwnvJ6nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsNDLcu0ISgvMI2aC36hmW8ZqmGdCKahrWBYS6KtM7IKqOCgRGVlcUKrczlH?=
 =?us-ascii?Q?lhG2SuulH4C64PVAVM4THxWFehZp+CcIZKGaS24HCDXIXK9hUl7xin2CzWU6?=
 =?us-ascii?Q?d9ll9N9SwlYYkfK97fINCrlkLZNpO+A6At/NJej2GKCpKssUHPag74geyxd8?=
 =?us-ascii?Q?FAmUX7EEY1s8EP1CjP7jgsf2QbeGwcFyolgrGrzGPck84vuMo/gaZ2j63vcr?=
 =?us-ascii?Q?1CmqsSMRDbnGRgqNhOsYyOvfsgIH4igk6zDCYygxzmeyseMXqsqYp0lqiXDi?=
 =?us-ascii?Q?VYOwRGeRI8+PZj7nh/hW8jjUZh/dQGELAIOSKreiRv/+awqOyua7+zPG9kOq?=
 =?us-ascii?Q?P5+W47ucZiEHHX90x5KKCYPqLki785DIN9I73jT1+CTdjrttkUxbA3XdKiHm?=
 =?us-ascii?Q?0E2pPNSQyqkjYmBUFnhswi2RPwtgYwfn6YL3zC8c/v6p3Kjc9Q8jrm2jH5Hn?=
 =?us-ascii?Q?4hR6t03bYDlnTIkZR4uCnUvZrQqb5GAAWGvdvRDYngzDpzrZGMXFUx5PkDqo?=
 =?us-ascii?Q?f/tcn2sebSHzlFXHhz2tgjsYgPbd28Cw7aW3rO75uC5i0WRGAIsVLrJ9laBG?=
 =?us-ascii?Q?/s8Duh44cbcFtuKa57bAc/CoqosNnBuPjpd+9mCWX8xmkaYsylm8nCIpOXcZ?=
 =?us-ascii?Q?/RyQI6S8wERVn9YvJzbHzjqb6bG8KIeuhBS3/foCZdTE3pq6g5gf7yBORcuz?=
 =?us-ascii?Q?TzGluUzd167FvzNvzzJuY8txY9Q4QkTgaxKKmQXgL36Yezq+lv3bax/1F69U?=
 =?us-ascii?Q?QyVCPCyj9JUBt6p3/QKLcih3VnnEQdd+KePmi9arjkUmnwAFQkaNCS8+3Uo9?=
 =?us-ascii?Q?zLVAF7kM7m06ewehEtyhgQI1TtNvbNpaL2aOz1iH//WLKgPE2T2DahA1Glwo?=
 =?us-ascii?Q?vLMI/90ZK9fmy25IbTepyVmmaYSnqtyZuiz5Plg84U3v5ScKYmRIIxd1Bczd?=
 =?us-ascii?Q?HDgIRKAHdqSN1rbUcNtXz2dwgRPrFdeigJZfd+Qx5kbOARJoGZeZfkqPu4xd?=
 =?us-ascii?Q?+/EtH75f1/Dw/SiXOpQDBcvff0nwUYyaJCmdIQeR5cY/CxkFW1hlVdsp9S1X?=
 =?us-ascii?Q?+g18M1idh5uJhV9RdMhA4f2ifBZknXlb7ka3qdg8RcgmuG44I+ExSnV0qh2A?=
 =?us-ascii?Q?YQWqvLo/LDC9exnfIlyi6nxkijhxtrvr/wQB8RLlN5zXSjZPt4thIAVKchaz?=
 =?us-ascii?Q?eu1Z3Wu47n/ATKxnVDg9NJ23oDGh0VzE1oKy5mkhg0ZWK0vgLyQj4J/9aD8l?=
 =?us-ascii?Q?AGON3wbwjto8xDfQ8CdY92Z6hKUdVtD3hU1RIPNKM83SzTSeLeXmgKvgE3SK?=
 =?us-ascii?Q?1V4ZqTS7MZ/ZVbq1494pAQl9?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71efbff-f7b4-4f7e-ec31-08d931a98c10
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:12.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rytB1jvM7CIAoATvi3HtKteqfGk4Iu4/34+OMwn7iBYQunD1YODXJ+uQ0pL/S8LOoic7yL5VX5lSXeGppqtHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_file.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_file.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_file.h b/drivers/net/wi=
reless/celeno/cl8k/fw/fw_file.h
new file mode 100644
index 000000000000..a9a861a615a1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_file.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FW_FILE_H
+#define CL_FW_FILE_H
+
+#include "hw.h"
+
+int cl_fw_file_load(struct cl_hw *cl_hw);
+void cl_fw_file_cleanup(struct cl_hw *cl_hw);
+void cl_fw_file_release(struct cl_hw *cl_hw);
+
+#endif /* CL_FW_FILE_H */
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

