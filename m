Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7433AB85A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhFQQHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:02 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:40639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232477AbhFQQGi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUXa5gI/orwCb8+2a4nh6EW/n7U1mVUpHxtJDr5vpWWQlJNDulK5pMh2f5ZOzB92w5lfWBWKfA8oh3nvx7SRG6exZ5JHlHkXK+W3NIonxjNb8CXmxfsFvNHQt+bawCiwVXqVewCqqsVZrtiAU2E4M9HN/pCyclYRk0W90BQxMEXBjKZg2Xa5qtTaKl42ec7r5/fLg/8uMgDzCebpMVnz4jUis3MGf61YTEHwzK5plShCuozE8sVsCxQ6bpUY1AihH/+clfchcDZ+uaY2zT+IOcli4Sh+l5rhp8N2Rwmok4jiXnv9WELrVtMPCAnsqBWQT66tLUSjCDwhN7cHLMIEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po7t3+FUh81zh0dF6jWBCuDtnqJ8eooKgqJymLP0ZkQ=;
 b=Xp7wXsCsKac9zbvf5L7Vt0qvxUGbxjMM3pGrfGiVhZKNHneCliwbp/uETji5bqus6byEKki9HyEsQd9fGHiTCu6UcuFW2d7ozSS4j7cRDsbwaZOFHI9ARGP1TL14bWcq3O9Oq+FAvW7Yr7uf7plyL7eTIjvWabvmsr+CmwElhMoRvMgrnPzCwF5K3yKFqrdBnFCPksDx+rMxbw3Rw03++MZ7Xc60jgPJZBTVpH5lbDbkBc0NPVa0OIjQdeuwVFq3uLfjAqyu2oybu808KcFD/m814ndMhgDuvpV2q+Li86hBTVmRttgxBilr88+2GHZVsy1Gl9XdFlbFqZXf8ABvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po7t3+FUh81zh0dF6jWBCuDtnqJ8eooKgqJymLP0ZkQ=;
 b=c0Pzc7Bjd9+Vv/gnW+Xz+BHudSPvbWez1R/dp0MwwUphloMe76xvsw8eou++Q+A/WGzir2cFmnl2WQ7fpktvMdwN9RkPyzYOb/EgvFK9WPlwhL0sVr3BPDiG1QOiHF1VM2My/d7jmus1ENhywbufjUjh7GleXi03pUdGOYd/DeY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:19 +0000
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
Subject: [RFC v1 063/256] cl8k: add dfs/radar.h
Date:   Thu, 17 Jun 2021 15:59:10 +0000
Message-Id: <20210617160223.160998-64-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57e4d5a-4c9e-4994-69b5-08d931a97aea
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB126826BD33693FBB3D0E8498F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jc2NLWxb0inFkBbESuZmb7L+XuGwS1L0T8TeIujKjQ6PHVzll+S/RG+dRwfjibQCPzZFt69OVV8acndWaKQCmWnN/UI8W6/9SDWCNvjhq5fhaezVwkP0vbQIWQ+rPfOFYFR/spGD6gXdHOwwF6cQdBGiK1S9GYXmUR+SwvQsrN9Xc5jZFofJ9WJKFPQUobXV2ZDdTin0+KfPx7whYfkJxz6FXlVaGyjXqUdO5cblS4xkBmyDwvkb2C7FIKTswuKfq1o45/aG/OL9aLhXZrvLJtQ7/eceiCyROLPLSb1sIVbtQy4EUo1JsU8o361fxZreAAoh3mV0LAzuq1A6A992rnzjrsi//gEEpE3jQleMkusOzBLkFivFHdsxre64fUrDRhPQay36kkpDjF+cTJuBlAvWvI/J+jQjwDOqjMjun9ypVJMSEIA/DLoUvT6K65I+pz6iVEeXmFeATOLRpk+D7iY/erqkVa0dbRAqRM5SemyONyWXKOWVC6r0VDWrOTFL/+oQfgZXMBVHRDZfUzX79e/CM/ANeNnF+3tMwLkzadGk4f8HeEBX3lzlaYl1AnahrWfE4RhO5AfxNpnY/an659/ST103nNjvvgqpeClKtp0Ue6cgiwSBI3Av6FIjsJxA1CG5ED0l3vIGfw9J1c3Wfld/V7F8PNhhOlCY2vpE5mpw06nZL4lQVu1YpFWsIFbpMlgtf3QFrcrQXbo9DiFCtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NkEBEfUdpgwh1Hrd+vGOlQI4RJovDX4/Ysdwt89884jCBdqVeibEnJFS2tyU?=
 =?us-ascii?Q?v5/QfTkTpNMilcUToJPuTKHGfzOJflzFDeclDdyvLwCzuk8uEgTDY7kK8VdS?=
 =?us-ascii?Q?2GPKR1dM6eZB5ZzcQxEBoSQuFPvDYQJnWWgFI5MWnRyqsM4mwt0Lctc6LLO4?=
 =?us-ascii?Q?wXdpAx76/kVHIoIyAJFQR/RQx9a4m3yYHDjv0n6Am69XzNaRkUmN+uiX0Khu?=
 =?us-ascii?Q?TfGvmdmVn6um4fa1oVHhoqRTw81F4thClQrLH6DgW320xqUgFCsSxJ+WqvO7?=
 =?us-ascii?Q?/Bgxz1+e8/Z99Tg2scBrsRuG/KW7ggeVFEXIFdVsJvmGTg5Ktok43Mmf02SO?=
 =?us-ascii?Q?ujmemlVO1+E12ANYoVfrVPxnSKFtQqvt2KSgrFU5A+qOBDl5nO8zMUWhEwEL?=
 =?us-ascii?Q?ItnTmTRxZySDBeeRhoFdQHXz0E2PH6OHWcp+5nV9r91DxiG5R4G4CFsLJ8fi?=
 =?us-ascii?Q?DLQJZFI0D5gwUBg0eyw0QhEGWR0Mbq7I7JRlLOsXe7CGC32JfRUOZBKev7oz?=
 =?us-ascii?Q?4jSL/XODJn7mTGf9kU073YfN8l4CL9Oag8WXBg80ABlOU/SotraC9TCnHytj?=
 =?us-ascii?Q?QvKw0TwLOMnb5/aKkbgVYyOSTnN0sejlZAB1a6IN4SmCDnH9x6AJC5+jfVED?=
 =?us-ascii?Q?/ssaQwkGzRlgs6OSMWsTt62Lxf+BDmFPa7h5ES3T22WPBV38QBCgaS5SctBy?=
 =?us-ascii?Q?C3RGdiIOHQolK5koCazJ/E0ITux/IfW1CqHkeZb7JA2sGMrurF/yg459QgF4?=
 =?us-ascii?Q?a7mVXh1OhXO+X7SIzekqDbJHffaHoHdmYMO8gTnL9jW9z4Bk4xpjNQQaBYpE?=
 =?us-ascii?Q?pqJ+HN7JbabWN03uR/7SamvcSK/Tq9KBkUJiI1NCm5I1gxHh/QqWN2O2boHW?=
 =?us-ascii?Q?dxO2LPytDoT6p/F3Tz4+2KAuwQB7ta1rnddEeV7jJuwCkKHIy08l09Eb6sM5?=
 =?us-ascii?Q?OqgBmCoDRfX7k5cM0ElIkmZo2CX4kSDHPITCRkMfetLcphXf2ue8CDq66lFq?=
 =?us-ascii?Q?q0yKWxaJ9bjEQuQlq/yq/4oHTE/4AAOMSm8MZYx+LcLqLbqxVgj7kFJyju/4?=
 =?us-ascii?Q?dfrP/sHV1ZF/wec8eG5/RnGj+H76XzyB8Jm0i8zc3X7+pNKcPL+cgDBhSmNJ?=
 =?us-ascii?Q?cPBPQgM+7+dOnzxusRfnZoVM1j94Sa1HXlHDtSxFYOSAzWLzJXvlyOOMGBKo?=
 =?us-ascii?Q?/jo1iKwj+ijzJuvUI/xnePdXcfbT4edxxEqFf59hFP6GsZVwtcD2yGdACv1g?=
 =?us-ascii?Q?lNTyu5ky725uzdYw2QBsNFdAGUXp8S1ZAP6ClW0xdpyvGYUKGpShK2Seim3l?=
 =?us-ascii?Q?U4GTkp3e5WuHx/8xzNXkc8XS?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57e4d5a-4c9e-4994-69b5-08d931a97aea
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:43.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLIzmvWl2FRI21zrg6650MN7dg90Npo421VL9WzgfpRACOG+ud3REET36fyh2CsT2Vzpi+1A7mPxlYquoXTvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dfs/radar.h | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/radar.h

diff --git a/drivers/net/wireless/celeno/cl8k/dfs/radar.h b/drivers/net/wir=
eless/celeno/cl8k/dfs/radar.h
new file mode 100644
index 000000000000..bed037cce624
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs/radar.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RADAR_H
+#define CL_RADAR_H
+
+  #include <linux/types.h>
+
+/* Number of pulses in a radar event structure */
+#define RADAR_PULSE_MAX 4
+
+/*
+ * Structure used to store information regarding
+ * E2A radar events in the driver
+ */
+struct cl_radar_elem {
+       struct cl_radar_pulse_array *radarbuf_ptr;
+       dma_addr_t dma_addr;
+};
+
+/* Bit mapping inside a radar pulse element */
+struct cl_radar_pulse {
+       u64 freq        : 8;
+       u64 fom         : 8;
+       u64 len         : 8;  /* Pulse length timer */
+       u64 measure_cnt : 2;  /* Measure count */
+       u64 rsv1        : 6;  /* Reserve1 */
+       u64 rep         : 16; /* PRI */
+       u64 rsv2        : 16; /* Reserve2 */
+};
+
+/* Definition of an array of radar pulses */
+struct cl_radar_pulse_array {
+       /* Buffer containing the radar pulses */
+       u64 pulse[RADAR_PULSE_MAX];
+       /* Number of valid pulses in the buffer */
+       u32 cnt;
+};
+
+struct cl_radar_queue_elem {
+       struct list_head list;
+       struct cl_hw *cl_hw;
+       struct cl_radar_elem radar_elem;
+       unsigned long time;
+};
+
+struct cl_hw;
+
+void cl_radar_init(struct cl_hw *cl_hw);
+void cl_radar_push(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem);
+void cl_radar_tasklet_schedule(struct cl_hw *cl_hw);
+void cl_radar_flush(struct cl_hw *cl_hw);
+void cl_radar_close(struct cl_hw *cl_hw);
+
+#endif /* CL_RADAR_H */
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

