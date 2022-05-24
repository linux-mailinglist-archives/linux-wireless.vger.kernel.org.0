Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD1532926
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiEXLhp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiEXLhn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB241316
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9qL6GqEX/MTFU3ewN/3JBl6PV1MTTrKKaXc/+tmIV8VdtxKg2EUwpyKjejgYxNkFKuzqeUG6u9MLpN7rUtpqK3ZSF3uZaDUUVHbC0vPH9KJQKoiw8yRmPopMOTIO6jI74cLuUw3soSOc76HPapm8DtaJrnf5TEbnJj3o+vQ8jD+4GanMKjkiKlrvBf8E2j/EvEDDQkWOG32fT80SJQx5aiLhbdE14Z9Cz1ZYubNQaM5jql+XYGMkIiDUbKl3HBAvkb8xjA8lA0wjmYxZc6GPHf2ZfdGc62aZDyEUPHbFV6gcftcxkTifOAwIEtweCQWI6Fe4/JFqCRDRdkbELq5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZMHGy4DdrTWQAHsrgOqt1xMFTWy9K8tbxa7wkjdddA=;
 b=f0PbTXfM9Sa3Chb8RvxeNP0fHH6GBuVM6L1ulKs5aWn7PwWAnxcmyRK56vYUluBiejX00S+rnxwiJK2PBINjDTtWNgaMsb3Q65/eXxSatEFx3mW2pIj+tubKzOyXqV/uGOk9FlUks5TvagJKkjIsJlYMV+TTx4tNRaJOmHJ5h2HnDIl+GOakmgb8LegrexTWR3jEVJup4NXCmMLeIK+4y7+db7h9mgDcqi4UJ+f/oG48gwg7LcOi7qTCEyAg41+W1ufLCBx5dXIEbL/g+jSabTfI5yKopDK8KDRJLDtfr2wpattYhNQkyTX+KBJSPp1iBW4/4R3fJwhCvl7yOlWBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZMHGy4DdrTWQAHsrgOqt1xMFTWy9K8tbxa7wkjdddA=;
 b=JqQ2QVZvB7PghCzEAc8+f04hRjGbwxbkXV3mDstQ60d6EzZAy1smIeVFDjybInVzeSEQPYn5QtZKROrsTSu6XzjOWHhJVh2NHJkUbjQlBjgJFkY340pQrOMHYXCrnjeFrBIUz883yZu+6RvpbwT5XX2UQfESwmy/rXNo+9Hf+lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:37:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:39 +0000
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
Subject: [RFC v2 06/96] cl8k: add ampdu.h
Date:   Tue, 24 May 2022 14:33:32 +0300
Message-Id: <20220524113502.1094459-7-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d062a4b-bcbf-4df1-f14f-08da3d79cedf
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384A84B9227AD979A04CB11F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqGmWhs1G2StI/zN4/vjw0BAEriyxJgFFZd4JPmNrf96+KdplZfza0zQJH81n5jo0d3CrT2TAlaKrZe6aSAac2WG0EU2edZw9R50tl9q+bAX5n1s9vWxy6/vWvjRN9YJSdPaKN9qp61d8vjwJJSrFiesZ37LCjUoxIRImicbTm7TS46zbG3a8z/r38nznSq0MF5qd3mOvXaD+w+xNICRumPm5EkP9Lji1W7K8BGyCyqIS0cQfwjbfAWQwExb1y9nk8z9iX6VSqPMWGSQ18NTe7UEUsAqoRVJg4DpbzuAYcl/RfyC1Q/mIpUQ9hQ1OsLZlqPoJTCce60Puox/LNmEsu6VxGahtlY9eAH4oBpSqS2jUlAXyfKIK2JFjkJmsCjjnrVnZzvp+RDiOnMGdPCH3D5FT352QtMqFzCBViyhm1/zE/cUASj6J+bfOgPuBoH4iIaydwF4Awfe0f9zB6py7N2SII6GSp/xHZyjOiZAUzW6Qoh6mIBrf2+CkYTiJsaagxDYViM6c1irder39VJa46X/X4lHdcyLskM9JLm6K3banvLGvS+2uYDzNivngUtgDE7PT9NXmEFSIdhd4c32yKaeJGaguJy1oRVHTFDnf7hVJUYqU2YbKzk9cwBrsNUyyVruWp2m8A10xqcaT02UbsKguuW4QhItn09q6y9pAR5VkltrKsZi6DPB/PVNPvMNvNbUBfRcK7QLgIJQfUkFPOXFu0tQC7s571Ut+LPqzxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duzAcQlal7QgulgSeRAQvzg0evvIghFn8R1NFgvZVmf7wGPtibKWl9RpyUmG?=
 =?us-ascii?Q?/9uJ497/r2fw4svZ18vEofadamdenPaMm/r1pvbLSsBvoUnJ8l8l51Sl3O0s?=
 =?us-ascii?Q?gI0wYVQH+VpvPTgasDn/qvU6upOwuMmdOMEcRzA8+Xce9nV7s016tCa8iVLB?=
 =?us-ascii?Q?E17Zf2Cpt6xawj30PP0f4pkbUfJX3ypndN7Thg1edcR63fFHXTXNCac89LxN?=
 =?us-ascii?Q?hcdyn4CJt8AT61qhT0ME72E2SNDIwXJbxbegBvKSQiNRB6RtOp+LRtH936B4?=
 =?us-ascii?Q?Cb/nP5h7xOoQqYrKiTL3+nyEBYa1i2m+y7NsKYVjLtVonII3DIck7Qu3A7cB?=
 =?us-ascii?Q?32uPt1CXE7R4WBgCCRGcOBSVKI3KMhvke2qjFykgDLi3cfK0Z/F12OSVRZ+Y?=
 =?us-ascii?Q?7YaNVhBvVCbrR9j0vhl2tTbur/AkCSZK+pje2PBEeAHZHaCMKOAAXfFNimOs?=
 =?us-ascii?Q?hsUQYg7+hU/UrwyqJFAhDpzjMWZRhMieyRxIYjtNoPU/4JORBEAqrJ1qNPqG?=
 =?us-ascii?Q?ynqjOhojzkU8hdQsLeXNp8JQ6Kw19x86tFdmEzPBQOUEOUvJwmtBeu8m/rsP?=
 =?us-ascii?Q?jtxKWkoE9ikeSvT71ZNRsmz3necW5xXOydTk6/xMm6SCkD2bOKEGcsRA7n8v?=
 =?us-ascii?Q?kCAMTALf3gc4RxZeDSgOT6L9thRKP2cyYIcMnCBztK87WCl/CI3Cjd1EbyFw?=
 =?us-ascii?Q?Lr02+qBm+UBwkWsQZWfJY14bWYeSMtAqltgRTRGrNVdjr2qFCoiF6iC2Rf6J?=
 =?us-ascii?Q?tpY2ARKY5cFs1E0Y1D8BdTxiIMyxnGEcFhI679+lBJ8OcheQF2iU7ywjaW7A?=
 =?us-ascii?Q?9fK1rX6lSmqg7mbly00/Tu/8MGaFTVyiv/68MY6mWM8PA7vJec6hsvBKQFOq?=
 =?us-ascii?Q?2+z9OVIQJgVWx1nLNghuNzKps8mT+fLEv2O/OMRYDtSrLkzkpTqHDqpL5dO6?=
 =?us-ascii?Q?nBj+2B5Mq0uTInl7htWBNnfLCHm10Kuwec0CnptlUvBWU/44MIt1q8x9jQl3?=
 =?us-ascii?Q?xerAoS2BIHRy48vj9rFNXUMDb9dJLwl0rA0N7zDuQaMCfaqglKlflC+pYEF1?=
 =?us-ascii?Q?/OTc4sRxDNn/M4A+7AXdqD1rUkN3Gzj2K/TtUB5+dBVjjt8fX+bK23LvgUYR?=
 =?us-ascii?Q?vUghbtlTh4/Cra5AT3YYyl8iX3nAkHuJtzrnhDr8Zkqaj/Z3p1BkkzMx//Bn?=
 =?us-ascii?Q?UcTxHVncD+CJowAHmGqbcpmPP0MNaIwDin/GuNp7bcoYq2V5SRgnLixUIOfQ?=
 =?us-ascii?Q?x3VgjMX0PsNB2RXDffcCkMPlHuXD1O3fHvB23RJxbjftPPk7fxq/L42wNLk+?=
 =?us-ascii?Q?C2UDud5b0MXMrxEa3ZcROMtLju2xixt0EvUP8hcyN9pdjiMwThMDoKcOuRoX?=
 =?us-ascii?Q?fHcA87fi654bxjnvybJSj/a8sJsLKMHNCKAy0/RpT+IVQz533JkQyHda6G2S?=
 =?us-ascii?Q?JADvEiST47RkA5aSBeNxs7LZQ/zMkamG72nrqCqNjNmBrXeKDfFdkfSFE8SG?=
 =?us-ascii?Q?JqMR2sC1UwVuDIfLnv78wZMp8d/RD0f71x3ae924eoKjE28nCse1QMGgTRXm?=
 =?us-ascii?Q?17WHEnYuSnAvmrVHtngtMaBc996TVoOvvLq3EwZsSbpy/Iw6Xcw7OfFmmvLW?=
 =?us-ascii?Q?YzIoWFNXiPAZJNwDCqwNI2sQr7rnfuuevp24P3XUwHpjjPqtEFPe2XRH28VQ?=
 =?us-ascii?Q?DaYok5qXVhrYF2HGjyV3uba83/aZ2JZtiNu9L3OnkLU4oRicdX1y5x1hlXAi?=
 =?us-ascii?Q?mbvyE2WpOYx8LTkezvslxONkL4jtYLU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d062a4b-bcbf-4df1-f14f-08da3d79cedf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:39.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXgnV4cf63XMu0PvHZvHWSjEKhGWXhU7H+52xK76X8hW2/xIq1RQcXY2vJQmkxTP2/1xX0j1s2qD8KwUpPzMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/ampdu.h | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.h

diff --git a/drivers/net/wireless/celeno/cl8k/ampdu.h b/drivers/net/wireless/celeno/cl8k/ampdu.h
new file mode 100644
index 000000000000..62c3f60c8c86
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ampdu.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_AMPDU_H
+#define CL_AMPDU_H
+
+#include "sta.h"
+
+int cl_ampdu_rx_start(struct cl_hw *cl_hw,
+		      struct cl_sta *cl_sta,
+		      u16 tid,
+		      u16 ssn,
+		      u16 buf_size);
+void cl_ampdu_rx_stop(struct cl_hw *cl_hw,
+		      struct cl_sta *cl_sta,
+		      u16 tid);
+int cl_ampdu_tx_start(struct cl_hw *cl_hw,
+		      struct ieee80211_vif *vif,
+		      struct cl_sta *cl_sta,
+		      u16 tid,
+		      u16 ssn);
+int cl_ampdu_tx_operational(struct cl_hw *hw,
+			    struct cl_sta *cl_sta,
+			    u16 tid,
+			    u16 buf_size,
+			    bool amsdu_supported);
+void _cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+		       struct cl_tx_queue *tx_queue,
+		       struct cl_sta *cl_sta,
+		       u8 tid);
+int cl_ampdu_tx_stop(struct cl_hw *cl_hw,
+		     struct ieee80211_vif *vif,
+		     enum ieee80211_ampdu_mlme_action action,
+		     struct cl_sta *cl_sta,
+		     u16 tid);
+void cl_ampdu_size_exp(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+		       u8 *ampdu_exp_he, u8 *ampdu_exp_vht, u8 *ampdu_exp_ht);
+
+#endif /* CL_AMPDU_H */
-- 
2.36.1

