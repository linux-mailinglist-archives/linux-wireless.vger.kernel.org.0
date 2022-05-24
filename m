Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D7532931
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiEXLii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiEXLie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2758CCF2
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBG6cYLDHigOjaBNUi2HdoeFoX/FwtVFbGfctYO+NndpNZ6A7bp/bAjxFyAnYVaT+mciB58PVji5o0XpUHr1K5+DdCDBcrNpMa3ImDYsjpqUhquDQvrB7CEvlxqnfPZ6lOAVvq0ug3m5VvGw2p3qYWbbbp2OT6liJI6GwCcVNhS1NUlMUwKDpAgltW5MQqKTnH5Bva1nMN1XxNfPb+pBhveHRUHZnsO5wvYfG3psBqtx4VDI9KoedJ8ijxp0SkIgAMVTqIA6npiS19Fc8nxgrUP+3Sd3diXo3Y6qXidAZLB/2D6SRcD33WGq4iHgCGBKZtvdnjYh5fbfTJqq7Z8hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAuHuTD9exojMeoaBmIf6+CD7o/d9qZ39+eHWH6bNJs=;
 b=GTzEBWdPF9jDQEgaOv5YKQfmV99a6IJppbCRHcPrcE3p2L7Jn2Zuug5tAXq9MY3FjHZ3kBrjz7xRH1Wz1CtutoaLlpEDK3iGTvsyc9MekNu1qo7FTmWhWqiKeRW2VqGw2DIfT0lo115nUzHnAEYQT45HGsHMzVGhclvyZ/VggaKVsqKujm6FmW4j/WnweQ22R1NiHgNazJcSOMQwrMDcccq7Z5gyTUXNxvIMMNmpxhCaqWRAKaZIgYFrc0V4z1oUsoQW7IGql2njD0dicxMm65QBeasdZyQi29mXQxcNdz37wd9gQLxY7x75XBEpo+q5vOeGAyiJQyf7EhdVBFGfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAuHuTD9exojMeoaBmIf6+CD7o/d9qZ39+eHWH6bNJs=;
 b=W/8g5U5EEWswOWhSEjMqOVbFlTTy2V9LD1Sytc1FvySnKCs/ppRzEBbasYsfpGNsKRj3zU5Js8gBU2rprS36cgkOo1DoTsISxMzq7iH7n7s3AxOwjO3J2WpCiS4KXKE6YNi12ie1k5DDoG1x+4jwkEuUzz3+jPXaTcY6d/V2Bl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:38:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:00 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 23/96] cl8k: add dsp.h
Date:   Tue, 24 May 2022 14:33:49 +0300
Message-Id: <20220524113502.1094459-24-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7956de99-f04b-465a-f6bd-08da3d79db04
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469C39D1B832B0F7C9F992BF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0mxGXZJOmpu5Bv19h5SAhRRqQaI0jd5FHjdBHHnUUxi6/1yA1qZ0yRjly/x7EJOnt4rIN4R2JaBTmi4UN3CYfnwFCSQZag5Z/1k4SH6bYzPzi7jPpU+sLZZcUEqWS44totUr5zrxC2UNFJH1nQGWDRQ5jgsUcVhZRiRY8KJ0NrjX/frKyyz/6sSR/g32p7zvsUwgzylUIEkVZjHmXQ+/6dN/vXvqiVZLQnkdnyGb7QbBdm//IwjN8V7A8isvoA40op35RCSvhAecBsD6eDPthBjIrMB+d+DBDyJAnVBAqNENqjfyWVus03XeiTYhryoc5+Uwn78pq9P9j0mMOb10OQtTditmDGk5A9t4xT1kDRBcmvgg0krK5lOw61gE+pdASFF+mh0s0PG3zA2xcEkoY/l7TFaO0hUJU1gMR/fu1Pu/YfBodtVaFfuc8jIZi/Wr6YxvDJAhxgqSytFfVUtXk/JTiyfyN4P2EACxgp3xbOnmhuinDv4eArjgZLu65ZsE2gp21ynBiBDg6zAPhlkZc3EEkse8Emjg6zOj3pisO8q07iJMrKQgSzVSaXzWMIjSn3QXRWMImdTF4GNchDFTdrUUjILtY3JRWWq1huz+faMrPVNMhPoit87Tx9WRAincFn18aYXg3FX2MQeVcp0Y+nZu7k8swVU+NwmU/WFyfmeJkbuX55tIIF9+otRFrX/eOTdlSVGB7QGDafMzkQOsQl3MVoMzDMLGsJh/24k5d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6k6SP40eIJvmz5XwccrC9y5F6Bs4oG3Ct7TDHZvFuFFbVIXhxcteB9uq4gI?=
 =?us-ascii?Q?G1ikzfxSWioZXemd4NEgzxYZevQ63DmZrUDUJdNRBhVltTrVjhgVD5todTgl?=
 =?us-ascii?Q?pKXIsmY65y7xyfUY/lH/69MWnK7mZUu+mcExnuS0mrbxED7NggToOJGXLNzx?=
 =?us-ascii?Q?qTxkoAyuGY/0DgKpYn22X8w6Uf9cV0TCnWs2CUpSQfoq2BxDks85zmpZZIsS?=
 =?us-ascii?Q?kiXsR7Mg7U6KqYhrGNo+Y+mvSrGBxwI4HtxU0ioQAWlyxifqFGnUZ3Po1xoM?=
 =?us-ascii?Q?eASQUleW7p72xtKxIgunz6DAhN6kxsBUNt7oJuN1QfHEFvBr0l8fPumLJ55a?=
 =?us-ascii?Q?+rVRtUMZqWQepVp/cbZAD+as3PwtWO2fC1OXCdLkKILm5gdM/3MIERP5859Z?=
 =?us-ascii?Q?dp1d6SwxlhRA1Aj+YZkNvAy6ri+VYscEe7LGxh1aNxL8sBM72kqUrNvJ/yNp?=
 =?us-ascii?Q?1mTFMyqppl6010Rjh/3kqVLEQco+6Snf2PyKE80M33gUVaSVciBpeE+FDZI9?=
 =?us-ascii?Q?MWPCqs5wa/6P4jBlSA3/GfAb7v2splhYozTOMGDZtKXsGI9/+vFEk+8H7Avu?=
 =?us-ascii?Q?bUrfmVaEC8TGDKNP3Mj4nXKH7YFOJ9bjW2rAi3PQrVTtmi1LkCUz6DcdjXgj?=
 =?us-ascii?Q?kDWk2lXCAqQ8mFI+fDfZXoABMyn9SFs39sDaw/2ltN31Y3Y535sjJzXwo6hU?=
 =?us-ascii?Q?ywxPdkAgP3fRqViFf/rTglx4B2jSSAg1oekCTbwenJ4aAMJpLmUlTPQZXzU8?=
 =?us-ascii?Q?vbD7mCWb+hI/pRo7mN/J0B4PgAuekLDeOvjm0y7ZixvMwzUBIX9o3BhpXCMi?=
 =?us-ascii?Q?aE3M0fQUxVZpHdTe20WQTgwQvP2E5UJgEpATcgIApCknBIDmypHhQnITj38Y?=
 =?us-ascii?Q?F4UIEZuQJSQve7BSvljENhHRqCYApdLnAmrn1UGeMfgHKBvqpJkSN47EzB7o?=
 =?us-ascii?Q?ijhX3t7Eo5GNgSc+mxp/Q6k2ySc4Iw+1tP7NETVfOymVoCQb3qEsUFT0K4vi?=
 =?us-ascii?Q?zNUEPtZaNYGsBRSqH6TD3pyuA3fSwvYTlffaqrvBB9+ZXueqyjuCPIyK7it4?=
 =?us-ascii?Q?TitwVGNbNMHNuoDu+zTbK2pWKiS0I2mGxWw2LGOn/sTHN87encx6kLZhnB6s?=
 =?us-ascii?Q?Hp+eucFNKiZcacbjTyINGLdzgq/IIxhU/934Y9bCSXkKdwzLjl/070i14Kao?=
 =?us-ascii?Q?0lp8YKVaggIawMS9fwpyrYGvzOOgL3pduWb21gG2xbk7+biFpqkZFL1uG3so?=
 =?us-ascii?Q?0x96DaWCtD+282S5JVKEfN3BxCrf4wFy2j/d09eNtPZCNgM2pVRYeb0TsCuI?=
 =?us-ascii?Q?HaBH0kZWU+9nt2I1lWt4qGzl+OzNsaApCO50KMuF0Rx80pWWtYq/1wBkZc/y?=
 =?us-ascii?Q?8sx733kpdUfm8VONjNPQcEB1e8GgyTXbB+cHZTtjA1naDat4JNNRKvI4IaCg?=
 =?us-ascii?Q?8GMUPPE1qcwwERu7+l09/0xbh+UeoTxh+tEvfymVwN1BtZ6VEG1f85O0nrEN?=
 =?us-ascii?Q?kGRC8HbOG5h+4YbatA43A8UfAN0Z/uYUKxecGSMRnt1tZqTgkqy7u3PV2Djo?=
 =?us-ascii?Q?iGIEy09l8hXAj8gZ80vqaa1t2MoInGo3jd1Hd9a8kn3vwb05LEtdMag8kZMc?=
 =?us-ascii?Q?JoavBgcQiVMdjsup5tE/4ew4KAZjVneMPP9yLguigpPiCXiZN13CtHLxnZ/C?=
 =?us-ascii?Q?gi6Ixg+kvHedCAKLVi3wqzZCxA1otzUsAsCHiimy0psjqEoussQfBaisNvcL?=
 =?us-ascii?Q?uJMCo6xOFm9nj6ZaBNeGAHk9yPUJQLo=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7956de99-f04b-465a-f6bd-08da3d79db04
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:00.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0/RJPa5OHvLqRnIP64PbFfcLXah5vjsK47DToGA8YeGEXNUycr5JQRPm+Chp7yg5SopIj8Zq+OWrgokDBRzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dsp.h | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.h

diff --git a/drivers/net/wireless/celeno/cl8k/dsp.h b/drivers/net/wireless/celeno/cl8k/dsp.h
new file mode 100644
index 000000000000..006043983ae3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dsp.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_DSP_H
+#define CL_DSP_H
+
+#include "chip.h"
+
+/*
+ * cl_dsp_load_regular - Load DSP firmware for both TCV's.
+ *
+ * @chip - chip pointer.
+ *
+ * Return value: 0 upon success, negative errno code upon failure.
+ */
+int cl_dsp_load_regular(struct cl_chip *chip);
+
+/*
+ * cl_dsp_load_recovery - Load only DSP data for single TCV.
+ *
+ * @chip - chip pointer.
+ *
+ * Return value: 0 upon success, negative errno code upon failure.
+ */
+int cl_dsp_load_recovery(struct cl_hw *cl_hw);
+
+#endif /* CL_DSP_H */
-- 
2.36.1

