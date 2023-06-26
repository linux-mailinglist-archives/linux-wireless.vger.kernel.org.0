Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F183773D8FE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jun 2023 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFZH66 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jun 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFZH6x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jun 2023 03:58:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A35196
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 00:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+snK81gCapVareCXi13YPH3IlePVN3vd6wTde1dxP3ieACOQRbPx+H5imQIv3UyeG3rdcvxwEKY2bUZHcuRu4sYaLqmh2M+aj0Y9ilXy5Zx+xYe5U+MHoxrUeBnShoPl8Z1eSn5/8662vn0DtJubmykJS21ohAkQmiQRad6VjKtiUI2Ztf2QG/U2U4BQ2BBv7BcI4EpjAQH7F9d6wEpBAel5JaT+DYdRGXlY8JEzCn9yMcSdg6JwtE0dUlmcSbukxUFOQNb+4TfCrlcHpOLj8QmGWdwgwXlBsm4pfDpGH4EIKFzo162jbDN3Bn1almnianCHgyfSLPuBIV3aljXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvNZHdqtK0yhtgSRFHWNxTMVF155OvNdQldxO9Wr3mg=;
 b=nFlWl3W2c/3J1Ulzc5ShyfsnMhKuF9CYuk9KVzhRrc0bVDvpSYNiokY0oDNy4hHCVo2ELu5VV+IF3sf9YIcHZmqAIGhovrDx7AMO9v01oNtW/eGpAV7nH1x32pKVGP9JGpFFsAN8GdI9Fqc+4TTmAlY9rwB5qQ7dQqdpMtijEPr/oapgRZqEa+6gP+a1w4GY5MRuMEityoebXGbK9aN2P2DEF2RY54IMrEPg1JLnI36ZU33ZTM9/KKfwfotip+UevAeed/sdgd8N19ryLAwebdMnXVcFqCzC2ineo+P4xGs6qeCh/8ulivYcxRd5Xs0CuSt0k80+76O9E5FaNPcRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvNZHdqtK0yhtgSRFHWNxTMVF155OvNdQldxO9Wr3mg=;
 b=I3w0lKeBvyZJl/r398EWvnX7QVAcBUf0bQCoWSCq79PChUUOhCFisq4dJozmX5d2bzNAiEI7i5AHRfzCyKbSyvrXCL6mqjIc7jhQNawSmK6W5ngPoiKpSfYHHVq163+GpCrhdaC9UvoOZJyN2XtqsdfqBfEtdwtorD/JDj3FcNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10) by TY0PR0101MB4866.apcprd01.prod.exchangelabs.com
 (2603:1096:400:274::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Mon, 26 Jun
 2023 07:58:41 +0000
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::a0c:9c3f:6dba:79aa]) by SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::a0c:9c3f:6dba:79aa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 07:58:41 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, JUN-KYU SHIN <jk.shin@newratek.com>
Subject: [PATCH] wifi: mac80211: fix error handling when channel_switch on S1G band
Date:   Mon, 26 Jun 2023 16:58:18 +0900
Message-Id: <20230626075818.1000-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB3286:EE_|TY0PR0101MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: ee040d4c-d05e-4cae-0da1-08db761b2813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3MlyjTG9vPru28S5my5LIuDF2FkVBcGnS1MX2vBWklKza7ijR0YmYfusn/6pU7Q3ZH02p80uaCFoYpF51hLE94AS/BKvsFn4Bt6SCOtuaAuvu3ZBJWeFBxOWf1700erl47mqRFvjjlZnD/21UT6H8V7r9wMW7Rco3HhLHieLkMFfe6epeRewAUytG2kL3ox7X8A0aPdcwO13PXPDMsgfc1IZRg3usMRU8+i6INOrgv5HGAsfOq9LAKfNPZ37HWBC8EotIxNUTC530jbnUX/651SpTzshMkx3Z+Fdrbsb6QXhWcfJmc+IJxJxjAoMkLBbnYiMUrpurMQf3ssvXkf2ULOHGO9gQmPcmBouChHOX7H0u01ud24+4iDy5tbvDrPb+b3URIFO8hOr3xgoCfzZLjqMQKTCrUyzlRF844WvbdwTUkLlknpgdvq8jT6ISV6mF29q+Wia91a9bSmAhDk0BCWe2RbjWbaZ3wIMBysYsj3367tJ9E6WTr1SP7bYrnUjGiJz9FhXQ38xla2vmOlR3FkHuPZvKDdUVdMT9KWtPYt+vGHLMK5CnVTZ4F+A2mIIXdIaiRkErA4DkjWa7YrYK0yDnN3VJZDas2QFF3wo81UUQRZu+7eps/VsaM8TtsC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB3286.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39840400004)(396003)(376002)(366004)(451199021)(26005)(107886003)(478600001)(6666004)(52116002)(83380400001)(2616005)(6512007)(1076003)(6506007)(2906002)(4744005)(186003)(6486002)(5660300002)(36756003)(38350700002)(38100700002)(66946007)(316002)(8936002)(66556008)(8676002)(6916009)(4326008)(41300700001)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gTGWOOTQOI0u0iQuK2dgMy8EsrarRgLHR+Z1kbrqL/VpL6PFtcsDNq5QGHJ?=
 =?us-ascii?Q?GqSOUH0UjyHY+fDVYI8QmbBwtVmos3Qy8E62ksteCXSu+S+G7LBewqZT1azj?=
 =?us-ascii?Q?kj3f3hnGhKxN4iMvmwHd2CCHW03SK3wOtBrK09XhdHf82EkdmCsnie6t9K3V?=
 =?us-ascii?Q?71J/Kiszui+YIEUnPhC8owPicCN5hHuYHpE3orR2IQAsWSPHakb5RV+lg7rj?=
 =?us-ascii?Q?lX100pYO1hqcKfe6BeRBy2zcVVdVQC1Wmi+rlfzAM1hWu6kOpubRCgRLaHHb?=
 =?us-ascii?Q?FMXzB+3yzZylPTQtSfiJrKnBTpzO5/rbB3FzTYwPlLLITMOR++f3nxD53T4y?=
 =?us-ascii?Q?2qaLlS1wo6uyiols2V0Es3kvJVdgyh1KzmEn41P6+za+uWm/jpXCiepRH8K+?=
 =?us-ascii?Q?cnPNEodkzLiLosTY7AoQ3gxAraPDvLMl/Fhp6qvxDuWgXOUZUEWI9zBT9jXM?=
 =?us-ascii?Q?ZA0rF8VfTfQNwJkQZlcxWowUSliZWp/QRP6Pelr9JxfnL1eoHAR4UEhQZZbS?=
 =?us-ascii?Q?BzPjkSP0mkQX60FN8wu5LMra4Dj6Kw/Kcg6tcnU5nJhD012z5VFREOhOE7cJ?=
 =?us-ascii?Q?F1DRUR68kwImLHLBQbTbmbawDSrEvc6sFOZJ4TPmWd4TQMs9YxPzc4ndKg9r?=
 =?us-ascii?Q?pHDMJMC3fcVsC85JATmYB3LmJRtykcfWG0Dm7NB0IGRLv/z8MUufVrQrNEcB?=
 =?us-ascii?Q?/EMq4FwEsodJ6PJtUA9cwbdDz/z13oXa+ldUdgbU9QPpJqvodWWZf9dmJhc6?=
 =?us-ascii?Q?NuLC/PFcTpuEwVLhAArcflw4iOLC4JyuAYkZ+lzzSkIGhd/+RqZE6f/xwucZ?=
 =?us-ascii?Q?lim+qd+z0UkwS+FTdMT1Tq8jcd77AlFd4zOcqkmCwIxRP65I+YDcVK/aFZF3?=
 =?us-ascii?Q?AHLz2Iav1FWtaoeFFn1eT1xDcBBPbztrVuSV0NOcmh/qInufbf/jVCa04QYR?=
 =?us-ascii?Q?jNJCp3j76oH73cPsfuzerha20GU5IWZtlWwnj7/LlhEWo0mVZDBpD67yQfJ+?=
 =?us-ascii?Q?OBMh/CwvVfZmViT70xBRy4zUjs+q9C9ofhdWfC9U7nsGid9tWVtvAlCftkDH?=
 =?us-ascii?Q?8cGS1YMPbr0vGrywHNLqpxeyhx7WFe7rKzNedoDjdMnnN56/uPLnjxUTzh1D?=
 =?us-ascii?Q?bnfH0TsP3V1NyepH2+uJyr8LjsnJp6LioKTJj2wUjZaJH9BdU/zBryPDwRSx?=
 =?us-ascii?Q?0FIIvY63LttrMywO3ikaGj1UtMfIdgCmgT+Ps7wflzu0WknStADKIePDti0S?=
 =?us-ascii?Q?Y90bH78gePJZCWtgBNFkcrVbSN5QzdT0/qkYVVkoMyxF3N9qJkKVnw8SOw0A?=
 =?us-ascii?Q?3MumvhPAxlwcdqMYRGj5KKd4AgKSZoTAz82vmgdr3dqRUJsAmqjpddQbXJmm?=
 =?us-ascii?Q?jPfwqgAz8UhYrjizswXs5VT2URlQsE8p++13xmDlTKFrlSdHlxVx0RVg2US3?=
 =?us-ascii?Q?YM4YBzrYIHI8NH6k05Bb7lOcvr8qisdHDiHx7Qs6Yyf7IT+DcAjbRSo53po5?=
 =?us-ascii?Q?kq6+bE5XXhWwrGKS5e7tTSIGN6gwEK2JUClxP1vld0Cj1YTlHdObk8pKOYYw?=
 =?us-ascii?Q?9hF2DYrbGNR7TY+afFNDTcskoM81gRPP6D+tYdjG?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee040d4c-d05e-4cae-0da1-08db761b2813
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB3286.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:58:41.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnYG3BUrpyHfLR+TMvy/HDUuN0FJE02r+WYGWAEaEK/DPOykzcpT9uaq5qD8BQew3i6ylT4H1tK0izpiVlHvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On the S1G band, even if freq_offset exists in the
__ieee80211_channel_switch function, it is not treated as an error.

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f2d08dbccfb7..f251945cf6fd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3909,8 +3909,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	if (params->chandef.chan->freq_offset) {
-		/* this may work, but is untested */
+	if (params->chandef.chan->freq_offset &&
+	    params->chandef.chan->band != NL80211_BAND_S1GHZ) {
+		/* Currently, offset is supported only on the S1G band. */
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.25.1

