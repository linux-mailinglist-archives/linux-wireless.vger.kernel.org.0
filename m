Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051563AB86F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhFQQIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:06 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:5985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhFQQH2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNt9PtzU1Fu6MkR44Xd+erdrQzjKXJBYYymTTbh/+BqlLm6e5QkclPPozeSvdGtEdEhzdySQMeYROBxSz7ujRVZzmYhWYofxGe42m3FGxvme1QzbNdDzd53Fpid3pT6e6VnQwXG5J5DQYP8Y5QHX58v4IUMeXLCCv0EWsdGIAkToITSdpqL5ADVMtmT62yFJP3wpJwCqzsXaswklLh80xvezPgeff4w3qejREeCQ3Iiqy9lJa8NCw2dXMX5z2v0fnpVGU599s3DyPAsb2KE0vo7L1A2qQ0igbEZlzQl3TOyuCt7uWzejhZIpp9CZVqMSfWwGlH2JNCJljL3YsZRKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4sDvID4II1JCNDW0KoGuyLuPMXRWTC5SJ7yDffNBiY=;
 b=JiTyTj70fJjx9WF2oOaZEJ1CU5b7EomDpY6j5xEZ4dwZoUkv2Evhbw2hV+xDiapkVfwVfVNRsGgCqZhXi/i7QVzODqg/iJ1higXr1IS5HfxXMpIF3JDlyTbig/VQ9RxjyqXzzMOK6HLQZ/hTqWq5aRq5Zdd/sEnBeRjh7eJ0zeSHckLjA2S3d4qwf1Zi2Rkxia9UjJF76zLooBqxbdacc3cmstt2flinGun27nPVZ32nIKapNGU3QUc9hqaqKoloOVyBSC/X/2qZcUc//IX/NPTpbh1A8qSNBQF+nDaqUCYP3BWTlEusISEh63v8ybgFgSL8l1fEi4AkknP1whNFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4sDvID4II1JCNDW0KoGuyLuPMXRWTC5SJ7yDffNBiY=;
 b=OkJfAXj2Qc/C8bAVhYEWvYG1TW+6ArTi5h/lOcf7Rua6OkdLSC3cKV0QOenfhw5oEQCwg4snT5JHlZImsecjufc0snbnrKlyl5DkalaXNpDTdkMxa/s9sD6//ShzU+lfAb/umA8pzuJ1ufDE6j156dYx0iWpeajaaXW5LxKY0Rs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:27 +0000
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
Subject: [RFC v1 084/256] cl8k: add fem.h
Date:   Thu, 17 Jun 2021 15:59:31 +0000
Message-Id: <20210617160223.160998-85-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ca3e7e-2b70-4459-57e8-08d931a988bc
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08710C5FAA450FEA9EBC4E8FF60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvVto1l4QpwouRhSnkUzdfsa3oSaaaKKfs5orL6vsPNVpS1KkkLqbtk19si7l/JEu8OuWFE5WG4aFS3v80uu/y+z+axAPm4WfG4FHz3lbSFnpi6qQjRYyMZign5O0iEhu6Ln3l1osHIUf+Bdq3DX971RJjbFK2IHz5ml6IfUgxIjL5RyLNu0HFcWc0ifb2MCX9x8wIGzy4/y4ybG4S1q+sMRJhW5GR02KZrdOyG0a+qJeT3n0N967Qhm3ylKefTsbZHM/J+BpoZwBpmOvZzPhtSOaOmL4kXw2A6zJ2CJkvX8wusLfyXMdweGls78f99CUaKmhCOhUti8SaPECwcirA79lYAdeMrUwqU4p8QFhsg3IRE/2hA5tJZF/n41/r2DXhOJ76jb48dj9EiRKbNXvYGkM114yrUlzd2Puhw3tD2qc/ss/mWgv+srmkg7Lbvw84v0sxhO//+KxKTBCJoNtS8fBcfz20p/stWjBNdGXxED9C0zziqOPTsdA80kVzMHeE27NpXpb6JXFcY09NIUR8MJDgq+BcM5xAfU07haIupJ4KU+8I4xcKCOthBaCOLPYHYP+TJvSor5fvfOIBaIaOk1IyD63awIAgiHGsE31wwqrAJIcP3gxOdNTX8NtWhTZ9sfOAUzOuLmJBpS0jBeXmGowXCkq38GKQQ15/6AEic56T8o89emxLMQTYgM6VXIp7EeR3LTjXlGqd/CjOdj5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abWItFwpQGUw5BqI9zU0zrqbi5cp1fskcgIg3wmWYHFe7Ozrjth8LaC+KKk0?=
 =?us-ascii?Q?SZKae87LpsLLCgSupBxGrxBwssXNJzIOJNZt+0oUc6bZxWz32IAHaFn7CSmN?=
 =?us-ascii?Q?n3GJNk+JFkw93LQ8oEYbYwcpJd7RSz4lAgw3zSxEs+X5xxbtHEBU7YzudWS9?=
 =?us-ascii?Q?4Bt6+yCXg5wpufY/s71rXlf1ohwllKcN8q4HBpMU+r77CxAQTbJJygDt/MHj?=
 =?us-ascii?Q?4qp4Wqzm3dFmhiwqhnBNPGnVHmeV3OwDJlBgNkCuPfVg36Mfs6UGlbBxt2LD?=
 =?us-ascii?Q?+kB0Qk9G+oPjFNJSDXjVw95xRK6RYbowGZk2IChGOCjXLgB/T7IrW5cWRmwc?=
 =?us-ascii?Q?qFJ+rKGtX7Qaq8LvwmYDiidG35gfzxpaZfltBN5c0gHj0UCcBnktNNqyYdJM?=
 =?us-ascii?Q?OPk8cZ9eYxej4cUie9Q2DP74twA1jTMfvZvlp607cwJNWh3pPP0ut1QrLn3h?=
 =?us-ascii?Q?ccOqDcZpBryJyD59TtYE1y046aZbBr1o8PBk2WiEQVB26U95xqbXmT6U6SvQ?=
 =?us-ascii?Q?wJj1Hx/zuL2wZPp93RaNAKTk3l1DpMtWcYMbVQdGwoFiKGwIgo0XNHuiwYmg?=
 =?us-ascii?Q?jJF+1PQYgkKHnrkEHFy/qMEJTq7P/zpWCRqTdcoI/+D/aHDhNmrjFuBAns7L?=
 =?us-ascii?Q?NlnM6mYfcurtvNfPtCyZ+v7aYih8uPpunvXhXLk38YjDidYbf3m7qadlpV4A?=
 =?us-ascii?Q?p461UQMLMlMUCw1oZ4DXRNSXHtEQDEngVGyWPpG20xCp0GX7ue0tMe2q8uCl?=
 =?us-ascii?Q?QB5Ezpy85iGK8tMgjHOJNZ90OyKHwKvC9wsIx/6T7yhXcFM6c+G3ZNBnOJDZ?=
 =?us-ascii?Q?QJyEOaEU4OeQ+gm+lXpJGr6CDGBdo5UksM0AHUDtJTZFL+j4CtfxjY9WYmeg?=
 =?us-ascii?Q?mRGjsrlIP6SjVuatVur9/YFOYX9QtMg2GKvKiS7Zu3oyaznYJEDeWFQlBpD1?=
 =?us-ascii?Q?L0pBZM2wDANmFFcMiPCBYV3G0MK0CpmhT5FpQ/yg/saIWBnpzCK/4uFy39HT?=
 =?us-ascii?Q?orZaZ+GLjFNfbV9q6gObARAEsjxYTxO9/a8Yj1P6lS9V7hcaeWdDghjPcSQh?=
 =?us-ascii?Q?bFyFNX94HQpJYcIMDcxdzo6c7hbeTqzCdCLnNLxjlVmR4uFH+kbffx5c0CpL?=
 =?us-ascii?Q?fNKMiaOUXiIVOVQi7fuHrUn4R5C4mLeWy6PTBXA8fTiIW3bPuK6/Ho8yupK4?=
 =?us-ascii?Q?0HzQQbhci3PIet8Dz8VDf3V0xtbEwtm2dfwyiy7M+nLh0el/Pi8cLX3uSY1E?=
 =?us-ascii?Q?zu7Jk5nkUNhkUviETw1gCkIonMEZWmTRwZdsxmJsPN9c3LSdWO2OZ9Ua7C4A?=
 =?us-ascii?Q?bFdmg/caWlxOX8Vjn3NPgzeL?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca3e7e-2b70-4459-57e8-08d931a988bc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:06.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1IVMIm5D+PSCyd7Dh35gBBA2lc4osQIeZ402YwkNjWBdv+x74lLqQehi5opES6pqd3YG1jSoE5J3LotEUVpKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fem.h | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem.h

diff --git a/drivers/net/wireless/celeno/cl8k/fem.h b/drivers/net/wireless/=
celeno/cl8k/fem.h
new file mode 100644
index 000000000000..8fcef76c7a61
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fem.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FEM_H
+#define CL_FEM_H
+
+#include "fem_common.h"
+
+/**
+ * FEM (=3DFront End Module)
+ */
+
+enum fem_mode {
+       FEM_MODE_LNA_BYPASS_ONLY =3D 0,
+       FEM_MODE_TX_ONLY =3D 1,
+       FEM_MODE_RX_ONLY =3D 2,
+
+       FEM_MODE_MAX,
+       FEM_MODE_OPERETIONAL =3D 255
+};
+
+struct cl_chip;
+
+int cl_fem_init(struct cl_chip *chip);
+int cl_fem_read_wiring_id(struct cl_chip *chip);
+int cl_fem_set_wiring_id(struct cl_chip *chip, u8 wiring_id);
+
+int cl_fem_get_registers(struct cl_hw *cl_hw, u32 fem_data[FEM_REGISTERS_A=
MOUNT]);
+int cl_fem_set_system_mode(struct cl_hw *cl_hw, u8 fem_system_mode, u8 fem=
_ant);
+int cl_fem_update_conf_params(struct cl_chip *chip);
+
+#endif /* CL_FEM_H */
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

