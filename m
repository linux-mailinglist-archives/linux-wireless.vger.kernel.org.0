Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16953AB90E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhFQQMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:10 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:59907
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233875AbhFQQLD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3v7iEDBvRGnQPLPUg89htZI0pOh2valymihUkM5Xc3yorcTjlal+FKc5BL6vxBMG7WQ3Mxxr1MvZlGQ27W394f7hVDXyN/dDDkL6Qa545ZsCN3qR/MXFn8MxfjT5D+dEsUNyEbKhaZbCsmY9gbG5bVs6Cw63jo2JTn3EYC5H0PYm+ZCKLhcuFzgTPq9nfnjU3zMSHGm3/H5u9Ao434pvqGmvEjZMt+Jmds8tCHG1EDXA4VsRd4mNFtHfHydhGgFztAMiuY6dMDUU5/lIrckGU+8v1lhv5ErcuO43GeD9cRuQE0ZDeeZVY8SxQ8VB18wVm6HmSZe1RU2TNuBMe6Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRRGHQPn+ZXACgtNvmBMs49eCMFpnZpu+Dq7i9JatSc=;
 b=fsNEH9g8MPq3FZhzLM0yqHZwoPCKFXorISBf6nMzCof39ee18CwzoBuj79MAGPusjZTRfEG7lnPqBW0w83lWxCM75a0/PnBMLh1QKkGJYDaM2qD31h/Z2SbHia5sopQyq1NwF+rtdrNWBHZ/3J79eUEUy7sQHwsKY/zKTsUz0eTejiK2V2YelSCWwPQVenLFQOTQJ3B01RhTWSQZ5Ki5MfgHjmh2rh1h5vhYJHRIDIoWeP7RiFjgIdMzesFq5cIAJIZqD+0IuzLZezYUNk7Fl/8gYVQJjrApmQI0jXm+OUNFNUKpmwGDj0FYHyW+C3uHKvDu/S/yuRAON8xbGydd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRRGHQPn+ZXACgtNvmBMs49eCMFpnZpu+Dq7i9JatSc=;
 b=2339EG6PGlDzZYxnKBRWDchgcIJJmugbbcLD8g1YTkS/n1zIdyrUJV7XqvALGZ1PzSDKIV4vtxgTS/p/9vOLZPUQ+skWHU2FMQSP1JoYhWhQmEfeVIw+0mWqffYgAiefsILp3YShBOuZX/Xju/M7AcHHklL/k4GulJKEvDs0+20=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:55 +0000
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
Subject: [RFC v1 224/256] cl8k: add utils/math.h
Date:   Thu, 17 Jun 2021 16:01:51 +0000
Message-Id: <20210617160223.160998-225-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b57635d-e1a6-4398-d6d4-08d931a9e6f2
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452784A495AD3FAFFFC3A40F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v3zfyi9gFsoHNqkAaKo1O0y+CODeqj1CN12gGuV7sj5fWCQ2jsnzewaB2r7ZS3ZqBE5e480w+FLKl4GBUZJOAJVNpJXf3d4XoTyMkKYjooHyjKhxaJfHhLvyJkIQGGC6bPriWxkQ1xcicFVVzmFuFlGq3IgYHR6tdtjPiZElY38xlS7lRor94Wxp2txHRVCGG/MKwj6RC22VtliD9S3AC+TAs5gYE6rpFAZNZ2hU9hlNiWHoxe8dWq/tHnfygq2tK/HRJnn5YCnd3bpU6CHOxFGiHIJ8WsOtkr5+nnx4pvNzAWI1S0VOj6i1yKYjPec46Xd4G7JPJWFDcnVSObAnV+LBIAtIJ5V7MTgrEG+hBWu8lS11jGCN94h091Pe7aexfSxnvEEnffFkUO0VNgLzEVsnqXLR6KpDCKyv5eUoTP+H6qGssTJfk4kd/feomTH5gHOSbotu3aEaAd4PN1qf9ns6ageA0zBQsrryvfPTcPWCIAZb8+b8ORgxTo9K7L7KDL22g95KCJS6MY+7iwFt21TbeBDz9FvnFPv4ZiwyghGy4dcciYg6kOsi1y+kfzHAmmukwP3zwwKOokXJrrWFHiMEjm8S4x8yOXBDDOZ0U7gwJHpvuTicJZGWhMzv/lJpH8YIpV9ocIFrg+mQ2F1W+P8bK6gGFG2/KuVRkINJMakB0H++DIHEsz3PQhIIvwvoDc23zutDJ+0YGUKMwbjNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOwYDFxFZAwZnLMUKC6kdgs0S4fxJJ7H2tUtWl53nVa44VHbW4X2H9WkWBSv?=
 =?us-ascii?Q?itA9z8P3Rldc3V8SWJMRyf8wBqwnvFk7U9UUZK7eCEuCCZxEWKN2ovFTHtQR?=
 =?us-ascii?Q?TgfJB+WhNcr5PIel7KDk0PhHi6r5/LBV2Qq1uPQHrugO1EhMGj97xBJA6/B+?=
 =?us-ascii?Q?P0/8+ypGUOHjc7nBmiAtSeBg4Y6Q9+ROff/HJJJa8MBjO8Mp+/3BXovA/J9I?=
 =?us-ascii?Q?QekZ7RwtvPWb0T/IlK0u/m1YnvqEXyHPajgT7J+vU09cex+4pUPOimaJgNEl?=
 =?us-ascii?Q?mEKtp3HwLCnkGTLG5qeXYkxDXD2BWpztOW3LG198rEiEkj7HkbUYTBKEhRU/?=
 =?us-ascii?Q?+EQ40Atb5cVXYgotRGV/CYa6UIg0KP+xRefJcyXnTRQ1rQBRjqB8xglBbsl6?=
 =?us-ascii?Q?DP7zigluM/nywxNcbI/p5+/c42HIt1ZMoYpBAAclGYCVcP3yRsyLOaU5leey?=
 =?us-ascii?Q?BxkYuUPmstf+xbmuuAwRBQ5WoabtR9ejhIIjG9u3dADmfPAxkC6NCDDv348p?=
 =?us-ascii?Q?JZAgcQqkSXNPONYCiF6nruenZ+Lhtxj5oG67ShPTcZKMFbMua0blq5T+PLXX?=
 =?us-ascii?Q?Y4Fnae9il7VCb7RPD1a8CA7Ye3e7rhAY1pUswuLAmB/VwIEtmNbaJ/ytwOid?=
 =?us-ascii?Q?HhxApsA1Tfqz9ZhtBjdn1eyxF/OFfZekvdoB5070wCfq7XejVCJGoj/UvQeZ?=
 =?us-ascii?Q?ARsWolwaHPO3winyCHlqcmNak9DvexU+Mtr6oMZnFXRKXCf6j1XydO6Pi1/3?=
 =?us-ascii?Q?q1D4qIz5gpFsm4C35iH5C9fwP/jKaWdRqr+0buvloYRMaoyGrtJtEvtDpIXP?=
 =?us-ascii?Q?4USjIs/fkcoB/5Um0ScSfuyPut74tTvwolGcl6OttFrfUq7b3KWwpmIjT4XK?=
 =?us-ascii?Q?rE2QHdZ5ll+inQ2ZaZeW0WbJDYu8b16pphJCuGdiD3/GdVDtLUMVxZ0DHrIb?=
 =?us-ascii?Q?KNMTio8kKyB2BRvC9jZfw/LXzR+IyYLOXnNG8mtM9H66BPYWB5KVvjIv3opV?=
 =?us-ascii?Q?3o+H4WxQ7w1Lzabc1MDSzd3JOURyheStPMp0ctSq94JFZ3EA8q0N7OicbUvr?=
 =?us-ascii?Q?jreX3s13OR2sQ7Rla2soQQOEMBcmMFkBC/wDQE4+XZJ3z5Ryw8VpT1eeFJcj?=
 =?us-ascii?Q?Un3kiiej08BCfwdv2OtEbKJUfsP7pb7nCrpujP8VjC2iWBBS6VxvKmCfRCSn?=
 =?us-ascii?Q?qkKvHtIXCg0jmiR4QTYQFw04uFfzz9Pip7oE1jL+dQdZpaa1xdIKMH76OHrb?=
 =?us-ascii?Q?CUlnYnoH0hJkyqNos1gn6KiGuVYy1Y40FvFBWlKCmxxBugPJpdgVuQI1ERnE?=
 =?us-ascii?Q?0BRP20+QxWtgTRDUaDXCXP1K?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b57635d-e1a6-4398-d6d4-08d931a9e6f2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:44.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciRf3NZnVL6L0n3YnHphKCrQp3GshMpBaPkeb0p8eJ5hHdiZwjIqNw9fUtqTyLN0/XOB8qEnRCnCRTkedQI+Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils/math.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/math.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/math.h b/drivers/net/wi=
reless/celeno/cl8k/utils/math.h
new file mode 100644
index 000000000000..f03bef46f3eb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/math.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MATH_H
+#define CL_MATH_H
+
+#include <linux/types.h>
+#include <linux/math64.h>
+
+static inline void cl_div64_decimal(u64 dividend, u64 divisor, u32 *a, u32=
 *b)
+{
+       u64 remainder =3D 0;
+
+       *a =3D (u32)div64_u64_rem(dividend, divisor, &remainder);
+       *b =3D (u32)div64_u64(100 * remainder, divisor);
+}
+
+#endif /* CL_MATH_H */
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

