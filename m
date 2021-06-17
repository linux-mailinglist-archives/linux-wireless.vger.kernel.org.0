Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248023AB8F4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhFQQLW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:22 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:59907
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233853AbhFQQKE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhHB+r2DVotwUXkd8hRYExEJUYR/YeLGEqM0+LKgHmTf0ifcLKcLglIsFWWczZdkzHm+vEtagiNQxnV7t6v5UVBzWTyaPVYlZfHrsWYhEBowGGmStLlTXa8hhV/kxvCoeEp0Qz52kvnIeC9PQ0FOD3a9lYY/8jqf4tdRoFb8mlNPG3hWlS56cQgknzR/r2AFALzufQSG0hJukkc3uGa6XG/SxXJ4EoCfwlqiHeyp03fH+lBsLeSNCEeRwfqTa635ZefOFXYZyiIfZaqXmzt6HFn/hlQB++Zw63boO8qZAdEg3j9v76LVBfXXpv96Ucn0OoEKeGDWYXcCZLW4LghxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY6q4HEWo452E3uF3ZAatnZ99LpnOp8D3eXF5kM8dw0=;
 b=l9dXof6KTm2AEe1icV0qcOvg+34XUUk/SDlVGgc/e/T5oOVmEs2ZjaQn2moCTj/w8Qh98sQEvlIQBm6JP0EeAWoKrs3yLlihuy0BRcDbaqQ//Xxt9ltcIgtuPR3Asrh7tXkQ75s2oLiiDfMe63zry4+U0F5fZSoBbO2JP/I9ur/AdP0fSgyjyHeyhpQB0kkROBQLeySh8DBprBRUlJoWX8+R8KyB+KB7R2gygoNI/7hWmrrGKzUFniNhp4MBL4E3+WtV0cH020t1TlXH2haOO3gR+2UbeYuVdPfRtVmEWY/Fg6woLUIuXB6Y0l4RqJvmJioz3augN4hKVuCt3gWDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY6q4HEWo452E3uF3ZAatnZ99LpnOp8D3eXF5kM8dw0=;
 b=a9TbY6HSX1D2nxjFCgkP9QKwPfSFRTXuYe3jE+vgu4p9kmsjnNuKS0JfFDXzVxkkTJjdbtyEsyuvKmfoaJ6f+qmxdg5AVXQX1igwbEf9BW5yt2/vlwZzoQvPDG+mHoXlBG61hCTHB+mmJKnTSSDOeq8rII7P1LhEZmFyPQLfl9U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:53 +0000
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
Subject: [RFC v1 220/256] cl8k: add utils/file.c
Date:   Thu, 17 Jun 2021 16:01:47 +0000
Message-Id: <20210617160223.160998-221-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ef0805-626f-45fc-dbb9-08d931a9e467
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04526CE258F0705DF7F170B7F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwJZe8JLc5lxf4ef0Opi2XreZfcKRopyH5628D70Ay5zQm9FHPUFrD07bKmRwpaxPG8h7w7awKYOaMPrBbTpmNEbUjuUiIqCNiGi5+oaxX+czhST3qxrX8M99y1KHEbnWsUKFmkMP+5SfgzAcM6YpU9Po5O+CH77CZaNcmTmS5pyWs4KbhbeN0bEJ9BF+WtgFasrPXX1t0+amX5SHKEWu73hkX47mvyZRaE3+fXy6NPQL6NQNInJ40sUSUit6E2DDioECzfmNU8IvNnR2JSFfzzg7ApxHxT6Dv/wE4LvaEOwqC53JWj9nlOvGYSbUVyMcfdP5qaKVJmz763DaVHlt72aTWVxbbIB7fhgiLfFsfrwGCyaMZBQAgJuveGse70xJ0U4nYg7Y+b470/rVTsn9dN0ZXqH9clBH9sWN7bMYlYacRKw6lNMyIhEz1zaAA3ejSoqKVZ6YwVFTE3QIo4pUg9eSzn0lRGdi+3CLDtCWfE7RXlBxuakLq7COIbg17XQdm4a8ae+20OphOi/nkFzkf/3MN/9QgoPv30jVYQ+6KyphteTpMLl5ucDJlp1jskZSg/5chQRvYkYOjaY3ObMdXBNmcSVAQO0n/3piPdyrXlTlWI+ShfRfv5dUXzlsGJsAUnKy4BIQ/8xDzwJ0ISH0gIUsqEl88oHXmBbrgr4NOTAPz6+cyNfAATB0pzvKTuEStdGwXsV+82JzXCaannxnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV9Sw7PI8n7mQ/saSYUroyP/Nv+zP8r/Iql3jOEV12XvzHAXk3YzaAtpkVDE?=
 =?us-ascii?Q?sYN0yF2XNxq0Z8i1+v9ndWm9iMvmSLVuc/vQFfsnSvxJUHls3geQUfT/GPmb?=
 =?us-ascii?Q?5CSMkjWj5PHCUS6kLVUVLVpwKzY71LxVHtzQAhwW9EKcEhbqK7OCL52J66vi?=
 =?us-ascii?Q?Vep2rCwvalyZu4C1cbaw4dcg3+OrWU2aSpbcaEpoUxAZ6Qh86T6Msuj4VugE?=
 =?us-ascii?Q?p+LjK0Lk9XGPnDUqOpdEtISHucOyoG2U6isB6POOXuwSkkO5tk14a+hBpUam?=
 =?us-ascii?Q?e1Sffmk+C6WzfONe7gi+8z/9pYx4m7EYL/71YZNWufYjAYhBWy9jp2p3022A?=
 =?us-ascii?Q?qra5nsejFTYt3A7NZxCq2zCGaAz66MAH9pgnZt9IH4WS6RRELK0oWTL01OFC?=
 =?us-ascii?Q?AYXp9Infay4SXUAtazLzXCrsyLQYsHQPbQ/PBrhegsDmpgMsiNKgu7htK+oK?=
 =?us-ascii?Q?nRdyxeyad2EcQ8Ep/r7BvFlB3w7xQ6xSAToTBEu6eWpODzwVAcI/0S0vatUs?=
 =?us-ascii?Q?Pp0wkoZfD52hLF13UyW9KeW9Sc1nq44zswMtR8eSo7Y1IoGjw/awbmMmvuMY?=
 =?us-ascii?Q?Y3b4Ugi153d+4cTCnEB8CTegAxSz9CO7I6U0Hvyhw5fPaRXFTJnbVeULfuzj?=
 =?us-ascii?Q?1/Zj1XgU9tGGejOfGonjkTLkFB8HwMeBoT8MKcgvHa9vJh2xYtrleupEA7c9?=
 =?us-ascii?Q?EQahHe/jiRI1LX7eVj4p4mLMgKb6NZnlmSavEuYGbPMhfSm4EejZw+N2od0B?=
 =?us-ascii?Q?YqiogPKXvLTIr7TusTBCYus7CqaiFvRyS30I90QXIE8TRQCQjSFqVzUjW3oS?=
 =?us-ascii?Q?eJ6IPRwkHJ09VMKjhkKD3/RZW+ircZyecT1141hOdUooC0ODh5FQM/llThzo?=
 =?us-ascii?Q?8qgHkXofHbgoygOXM1BlqZHLiH8aw+vZx70anh9HlC+PTOJY/UYbPtZDfUVd?=
 =?us-ascii?Q?VCSOkkfF0qLvMWA8qHYDJ+IotmxeBsnQBJdW8BksLUPFW+DNaCFyRh1ZepiS?=
 =?us-ascii?Q?I1glImZBLyiBAF0Y+2+E0qfMDBbmzJuPraHsLFllGjWzYtzDJi0VntdER5KM?=
 =?us-ascii?Q?3v8B48Qa5rweTwFJ8E2CnR8BWAoNNQrKCPW9SRXwfZ3O11Gsfpk3X8J3c7os?=
 =?us-ascii?Q?BCM05HC30uM40YFLeGaGZiYo2aTAZxz+VzvdxIrFn6PhkSLFPPYyqklJFo0x?=
 =?us-ascii?Q?IxBE+5miMxHaU3l5y5B2kRq1GNp1jD7ZmXYYU/iW7U8K5jXsqea+NcPcpsc8?=
 =?us-ascii?Q?yuz+DLDOvLkO7k8A8amgkvEDas8PqSKXqdbg9+Mg/KMMat7f3ElEIJuJGoVO?=
 =?us-ascii?Q?SqlwDLochTdXz3eWqJeMqCeY?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ef0805-626f-45fc-dbb9-08d931a9e467
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:40.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtXVNZbBWdoEKdTgKofR21vc0Y7Q3FrEzvZYSynMReMMI+AK95MxXiaHerx5AsHcnulMRgZsHYUCinNHjV3Mxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils/file.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/file.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils/file.c b/drivers/net/wi=
reless/celeno/cl8k/utils/file.c
new file mode 100644
index 000000000000..b42d78f386e4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/file.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "utils/file.h"
+#include "reg/reg_access.h"
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+
+size_t cl_file_open_and_read(struct cl_chip *chip, const char *filename,
+                            char **buf)
+{
+       const struct firmware *fw;
+       size_t size =3D 0;
+       int ret =3D 0;
+       char path_name[CL_PATH_MAX] =3D {0};
+
+       snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+       ret =3D request_firmware(&fw, path_name, chip->dev);
+
+       if (ret) {
+               cl_dbg_chip_err(chip, "request_firmware %s failed\n",
+                               path_name);
+               return 0;
+       }
+
+       if (!fw || !fw->data) {
+               cl_dbg_chip_err(chip, "Invalid firmware %s\n", path_name);
+               goto out;
+       }
+
+       size =3D fw->size;
+
+       /*
+        * Add one byte with a '\0' so that string manipulation functions
+        * used for parsing these files can find the string '\0' terminator=
.
+        * Make sure size is aligned to 4.
+        */
+       *buf =3D kzalloc(ALIGN(size + 1, 4), GFP_KERNEL);
+       if (!(*buf)) {
+               size =3D 0;
+               goto out;
+       }
+
+       memcpy(*buf, fw->data, size);
+
+out:
+       release_firmware(fw);
+
+       return size;
+}
+
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

