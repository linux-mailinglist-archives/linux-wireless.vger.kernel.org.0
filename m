Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194DE532935
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiEXLih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiEXLie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F653E2D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lImJ9jj8sMVxxDSyEalH5PJza8XkDxYmjSSbFLlmc5tcCQkTIs9v6HvaP36b3jzRnac75SOewaObrxrB58Qgb9DlPzAhURKS9jC8h3o/TJRwa09iwEqSkt1ROQwx4wXn5hFMXm+/l3uv6vI1VTyixoQ41Q/E5X8c3R/s/tq6YQ+zwiE5J/Ka4TC08PgOSvayCJopyQIhqvgsHCOn7T94GcV/A3UNCKVySeX3j1y4dq5ryF93mQnOztqFWjpvVfPheeZIg2yGNHO+Eds2g18cQz27lSTJTH1osigtu492V6z5sb6XMeOTW5PbwloAM2FNAch4hAelmLNHpF/5bcgENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15YbXjjVT26uE7SlUk+eFEsixW8nvxZCH58NaVpWJ40=;
 b=SiL/DLcimEvkEUXCWEGKRHNwB+W+OafPaMLWSs1j9sSqgL9h4QXcW0f2zQxfn3r5jCSP0fjAztt7/YXWVUJ0m/3PoYJqwEKT45A58PNP/HqnoUlB3CMEi3IAz/eczsvtieURjv8fI2HZ3yI87ZRMz09JCwfI/oeUiTLkR3+37GGFIlzgX3qF3/KlNrWtdiufzg75dhO9+DkczJK5aBNdGI0H6vWrGGNw76BeivKBtmSEpg4L+6tZKJBS7KTThAZQS1iHwX8Wh+2f09qkpAcEGWWW+NP+AcRIJgHUYSWA/qp9AXe36fHrHMu8Ry/JBvECrFdmRpquRLnn8aOsmrTQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15YbXjjVT26uE7SlUk+eFEsixW8nvxZCH58NaVpWJ40=;
 b=qI9Qb1c5Ew8DRKErQtCvlGwEH4ZHUMoCqEG00KMwmeXUh/mAzHS+RulmU3iJUdrvcKLM8Lv//YhQoOJ9wWtxbu30kCTvb1bNJssRU5rMIkvqwqPQdBdsqO4xcs61bn+re8F5S/x/69PKBXfdVWh0OzgIqUgPrjgRfqaFh8N5lSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:38:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:05 +0000
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
Subject: [RFC v2 30/96] cl8k: add enhanced_tim.h
Date:   Tue, 24 May 2022 14:33:56 +0300
Message-Id: <20220524113502.1094459-31-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9a55e40-8442-4066-4b3b-08da3d79de32
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB0305ED342227A6B2B6B585A5F6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvE4WEA4LcbvSHN2GEbgf/DkbeMJjp4FddPVppmNG8+FXAPDvAoXneIOZksFJctfpu6c2IK9+mjdmdfviRZmESIijXK/LL2BcIXQ6Up9qZtUOKfKzIZ3rA1+upZYGF6DVYWamld1I1lTvYGIEEz+PK+j0uzSkv1KhEdy1+ZYPGCfX0IE0/zxu+okZ3tzDjyLBBs5TFgX6fiVEGKXrNInIZ+3XGWxOfZ28yE24TrkAJ0QOR62psu7nZrxe+uYMQJsVqwfozhLtEySIEw7Z3HUEsvwoHnx7UzGieBKL05i3YiFomJHqYOLGJwsZ6pPEpkM4w24HWgQpDCyQa8LMvixHMshxIO3EyFUCzA3EkB/mT4gYRN29Oemq8+MjA1a/yDkqMJSK2fRpm+S4sETGSPdVFuiKtAzmWUxJgy1+WSC52kbn9mWbe8c+qx4Fq/+R0RtEJ5Eh7FUxH/BVUflc+iFzYmDi+kOsFoKSxvEABbyaMEVZrroyEax1Mu/qo7dtZIQtKq4PGBj40zEUh/Zy3QD99+FgmkU5cvW5YUFZDQGaxVBDAdmkxZ9Pz2KDgp36R2mTtNjt+uzk+ovOG0f77Omq45uxHmaaBqHxjQWqR6OUO1CeTWqLpgG30Ehk490fsRmQbCnUNKQsLEf4Vp1rU1QHZVeSaSGPfk+CZsm7HOcJzWLQRf1onk8ViOVjz6Naik3FG8jEzgTEA4IivKtJzdWeM3wWrebjFArQgtJnm7lJkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fxe9Wp4OkDbITI0d/5yRdeGNrdReLnkPnwnLsH1grbPl1ZUhjziXDqxt/O8H?=
 =?us-ascii?Q?yddnLbyuV06rRUdXfz367+OGHTMxKumiHelmBvaiiAyhmsPaPzbqz72yQyWF?=
 =?us-ascii?Q?y9ZgVPhB5KkVaVfdOO+0aOCv9rtROoj/LGRo119c+luOHQEgVLGhFp/j0+LN?=
 =?us-ascii?Q?WNzbkawS4tWjdbuFTvf6bAA75PmMeS8bhKX/NKyoY4ak9l8ZxzOapcbRhbGP?=
 =?us-ascii?Q?kSp3djxz6nl0oK/zmv4LgYaS3uKyz+Eg6ti9H8idQJ0bFj21CSr4JHhgkHgP?=
 =?us-ascii?Q?YhQkEfIVRR2+TgnhBfABHUiKaFdlkacmLS61K7P+3NUhr+9sYxS6aJomr3v3?=
 =?us-ascii?Q?XatCW5qqVZ9Uv4O9gIQ68R1bNl1jr93DG+RtxwHfcp4f3PArl3TcMdSSNPY+?=
 =?us-ascii?Q?n6Xe8nUVRtSCK/o+6IyQOjOvScePmb1bJXsw6xp7uGu3g+FGh0McLim8DQKY?=
 =?us-ascii?Q?a/XVP3ieDt0icd3sUEQnBGg4BI6vMJiZ3hF93DfwZaluIQAjEfR9fX3ZpcbP?=
 =?us-ascii?Q?qhEYb+KbhxsS6HtYLI/9Hy9LLiyLdapX02fZEHt//j17qDRKvH7OaVXd0GWe?=
 =?us-ascii?Q?m1G0ZrExPGcde0TUtGpj4evWceouqdAprL8UIJV58dWV4aCDwUJCy0MeUHeI?=
 =?us-ascii?Q?TMfFmg632nEVI7Oye12nZlU+J3v2ebo9CrSn8PNny9DF6psFdR+N+vHxhmPz?=
 =?us-ascii?Q?1Yj8v1xSrbnYzX52DAmQwwzBYK09/gQ4eiC/OmnP4u8itZz19NGiQuNTsF7P?=
 =?us-ascii?Q?VoozfI0MCgFLr9pu9E3N7HeBUetXAHiWzXBdo+E0VunbArn7eFPjLAhtb3Ug?=
 =?us-ascii?Q?vGeT06vDiUpwIZxQ42qsl0yEBVBbhMhKSVhx8obMTcxrki6gaBHuVb1IDEA2?=
 =?us-ascii?Q?JcNvwBRaljZEA0xD4TJ/rXXVcT93mx4MtsI/L2cBppQxrhjwQ2Dxw/Ahybnm?=
 =?us-ascii?Q?mYwunKvuWDfWHCG9FZipXKzKqmSNqY7ZAHt7K6EIIQHbOvvSRCxPKNXfcgjA?=
 =?us-ascii?Q?4wCMthcx6UMOrpuCmx427twd4nddehUDhLtOHjHOluHExWILO0xZdkXssI0k?=
 =?us-ascii?Q?jmmL+bLAth0Z45qpgpGDzicdGJAuiaqcXeOrzfzfBe3d3WrEIXRnmOH3MgwZ?=
 =?us-ascii?Q?efm2gslOC8q1OqAfFuNkMe2f0Bu9VqN1wyTEuqC3HPoDMQw7bzb1MciqV4Tx?=
 =?us-ascii?Q?KmmPC+weIdOuKc64kNE+ZeAtrCMV7x+tlNs0hV4rvO/H8NrY5z1fN/c4JhBs?=
 =?us-ascii?Q?wr8yXPWgRk9ch9nRqsC71qzNc2tNJN3FV2cHdrwqAcK4NI9Dz3bghX44hrum?=
 =?us-ascii?Q?rap8BKkepRXH5/2oOI4m1HZpj9SjllXGmMnAPHjNhcZC59JDrC2gmIdVMSoS?=
 =?us-ascii?Q?n0/GMh/ciXeWNw43Mv5cusp4kwNv7y78d4ObFIwQ6ysy3RNCyPXRns+Tqu+R?=
 =?us-ascii?Q?iVCE4EbHGcPpulsWihPTtcDjEdRBcYzLAfMaCS4xMCmQct819rVePgWyMrL7?=
 =?us-ascii?Q?WALHUBdybl/ck5q/1CWAO9QqF5rx8LrKRC76KW6k6KdHeC4zS3CESnv3SwTE?=
 =?us-ascii?Q?+UiNPkL2tYaiyDBFU7P9mmlFzQswskffxHoY7MJHZmZ4hGVAh2m7FZfHFl82?=
 =?us-ascii?Q?iAdS6dj7MdcYc1o4yZLO0zCnejvMWiCHVnd0dYO92PWgjHQm44bq4zWc+jN2?=
 =?us-ascii?Q?9fZAFFAWxxGSxsHBLeX4c1DYUAuTlWfW/YbmoutRKz+jO8Q6FiEM0Fsy9i4c?=
 =?us-ascii?Q?8Pv6AD6eHWomMyau4b4c91BSAae3SLU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a55e40-8442-4066-4b3b-08da3d79de32
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:05.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDW9/ZIsD+2NIEi++3QalBZtQhG4YrijjyJVYH/6GiVBtCapZ1WdQyuwyNextGQUFEJ27lfLTC6ylpQgcojmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 .../net/wireless/celeno/cl8k/enhanced_tim.h   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.h

diff --git a/drivers/net/wireless/celeno/cl8k/enhanced_tim.h b/drivers/net/wireless/celeno/cl8k/enhanced_tim.h
new file mode 100644
index 000000000000..ec40ac03df59
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/enhanced_tim.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_ENHANCED_TIM_H
+#define CL_ENHANCED_TIM_H
+
+#define BCN_IE_TIM_BIT_OFFSET 2
+
+void cl_enhanced_tim_reset(struct cl_hw *cl_hw);
+void cl_enhanced_tim_clear_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx,
+				  u8 ac, struct cl_sta *cl_sta, u8 tid);
+void cl_enhanced_tim_clear_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				     bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid);
+void cl_enhanced_tim_set_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid);
+void cl_enhanced_tim_set_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8 ac,
+				   bool no_ps_buffer, struct cl_sta *cl_sta, u8 tid);
+
+#endif /* CL_ENHANCED_TIM_H */
-- 
2.36.1

