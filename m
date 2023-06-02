Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA0E71F96E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 06:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjFBEpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 00:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBEpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 00:45:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2036.outbound.protection.outlook.com [40.92.99.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C9F2
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 21:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBl+gIHodHIJi3Q6bg51ZWjjtX8T7zstN9jEp7Qi/aKOyeyRwPHUVR5ZbHrVWaLD2sfR4A58W14fZrQYJ1uJaEUgGwxvW8Z5ASUpAJtNOQjuuT9gqf2kA+2QnOmAN5YMaG+ZbGsogU//A+YMmCmlesoJSUgn8TdQZC+dgnh4pDdVmtxkZjcascPKdcaXHiD7UhlpsWmoTAp6AH/yd5upQn+qzSzBgivB0DFL/6isBK2h5Bav8xNJgJKYdqO/j0xsQa1rdsP/j6urLtuQTRkutKD0azMw+TnCsqtrvPpdYKj8oRMK89YeGZCs4oaKTNV4Gi3t8QHjg0vwEaGTHO3idQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMH5k1a4elqZbhLTdVgJGPSVJTNatbTtBsVPZBDjpc0=;
 b=OIsJtTsIOrNjzcRFjIop7gMF/C5w5uNUvmvPmztUXyi7jWptOXXUCpZaTEkt7zOYb2JPUqPe/sTM2seGoTb6r7nlm5vs8ih3L0s62d68XgnFnOmCybYj1Hs2bt/yG70Y0zik9tbCq1HxXAFoCRJLbmyqSeE/3BRwT+aKImwPW2TP1F9/EmXHHeHq5Rm9PJvWgwzyKqJ8Ep8to96npdOEdsV27mscpHOx1q+xNI1CV3YW7t0pOtzRFfIoNk/eQ2tDtNoaZgDKvhAPQ3vcWcSZ7Nu45rSXej2P0Dg5tjYe7FCK2DbbL3LgLjOnKXndWMgSKkWScg78BXIS72JV04u+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMH5k1a4elqZbhLTdVgJGPSVJTNatbTtBsVPZBDjpc0=;
 b=R8q6o/BSARjn+n9ZcRjFavMgOWpO5yZHsezUxDPKbZz0IS/kbJTyo0pM57X/YjFGZrc0Wrih6wC3TzHJrSfIo/3KdTr0zunLaXmSVslQIky2Kv19Yk9QkIdKzd/1bKvr9WndfeMUQ2jeljjN5sTKDH7uigRDs23URuGzhMUVZtSua2j9GrFLhiPDjlDQ4xOfRIUnub3MSoe8y6MeQvIPoFZUr2XMbfd5chimih8HlmwwBDVq5NR8iHsK36olQUL08+OFmGj+49eThyzJ27owfZU7dqH4ttTFQvgzD1sYKCQSwuDnnopNP/hbBD4EuQbhxhDLRrv+kISH86TYNeWQDw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB1732.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 04:45:13 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 04:45:13 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robert Marko <robimarko@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Shiji Yang <yangshiji66@qq.com>
Subject: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
Date:   Fri,  2 Jun 2023 12:36:20 +0800
Message-ID: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VYwj4oIJakJstiml0q4Ynd1q5f+NtIBu]
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230602043619.3708-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB1732:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e1407b-59f2-4191-b314-08db63242718
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ztn8IE34tMkza0MRdH9Q2IxECexEZfQhiUCTFPzuCIq3bGrsYSA/OtX0jaHNI9jvAjxH1eRfojmjZqZY7kCNUVEogGe/MkMFgNrfYZeeacLfl5Sqao6SZfdHKO39bUYVofsyOPzgsvabS475rtjiTip1jHBw/lZEOS9+is3xW7CyzbsAHREryWBf+0LIT76PzI+rFg8oBz+jqpUF/kFl8SyhvuRu5oQzdvz1XmaRfrXYWAphFnDBTQDf/DGrCXLdfVQ3R62MI6WvfZnoUulSNETP9IGyc8jjTYoGMGGPvvVLPmaUOWnkxsT3X3xeA3buyxupDUoKT4zZbBnfizljmfL49M7I0PZJN5JboCpMLgDUgArfgk+WXhMtLKn6U1kFLsWTttpIXd7unAlqi1GNY/DO5sXlj4OyLZOEYu76KNKWoijATcH9UNk0DUzDMKrl94OUo3cjMOVxBXnx2Z1BOUSjFxFdxCky8+FnqY2H+BF7b5A6Qs0/g4b8I+Cb1uDgOAVmkg7VJg8wO+5VN7Lz5VpYSak0Lm9nJjFrJOqAnqE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtjLh9aAUkRPLV2OgdFUMEXU1OcVuwB2REg7fOCMRILUt4Wl6DQZwW8GJiMj?=
 =?us-ascii?Q?Q8f00SxMwsdElJBgcEzEjoDtQRhYQTaEcfH+0Loxd0FBt/WwwX37zYKLvb5n?=
 =?us-ascii?Q?4875UCJzy/FAWNFw1WC/hPZI315QKJePgTjp3z9JBBGTpGpb7hlPWvIF2qMu?=
 =?us-ascii?Q?bVzIU4hGPOiqktHDu8Zv+yBRkRWT0b2r6xcuQOFCcNm7hs9G20yZ0nVWEMAu?=
 =?us-ascii?Q?fMWkSPzxq+upIhjEQ15iVULCLj0yxzmaAZUjtKlyYE1u69ubnPJ0M3X6Y1PX?=
 =?us-ascii?Q?4QWduEjgXP0W+XLPnwWEAPTk3EboqvUAqIwdZpzLTMiSD66fbEZMUKa9rfQd?=
 =?us-ascii?Q?sdwLpzf+tItjvMKctMihjWsyjKtAo4p4rGkj3Ng1CeZAERYtILECa1zYquMf?=
 =?us-ascii?Q?lVXjYxthTz8r0yfcTtAqROEiI+uA1gleBStc9KabgYg8ASikcmYun/Fvijti?=
 =?us-ascii?Q?rjbzs4CjCJl7bqYPo88cGrTTMkU5We2Phh7a+drYD1w05nZ2tLOPxHW9+ywT?=
 =?us-ascii?Q?vKjQZOGJAQ5K7jfzD9O6T8qkbtSBj3JBXPaLvGpXQooCSQwextWvzfo/kJcb?=
 =?us-ascii?Q?2KQAHD6GvtHBFl1LzaCuk43Ar4B1jmrRlzdQF1Kr1cRAqq3PGuiVt/Bgdb2P?=
 =?us-ascii?Q?ApPIV3mpaG8sPGgHH2AyabwuIzKhG6iu49qYuPKHXrKMrdUK6OIm1bV26JRL?=
 =?us-ascii?Q?ftTKa2+0uNkL8CnbCwkMclPtSDCgpcLIuPt3JWu1CYin8zcufImLC712q2Hw?=
 =?us-ascii?Q?0II5B2hzNypElH+n0oDIgxjm+yJU1dt6NVuMeLm0lIHwCoYhmKO/Z3M9Ua6t?=
 =?us-ascii?Q?m7BQvt/nmFWqIDPZiS1m/MnRerD/QuUy5rDDxZmPDRscW1bGjVR4Juwd1WKO?=
 =?us-ascii?Q?8xAfWv4ouUmwBXTSzHNGlHW35UE0v0tJtkBTgwUJd5r4FsCufk7mxrlR/1tR?=
 =?us-ascii?Q?Kn7OcFxOcxcpmt+OwTv+T4fwPk7S/ZUZ7Ze4BjE0M5iX/IOaE3sYtOYcnzVk?=
 =?us-ascii?Q?jH3V+16sEFCbeSpMgUiOOB+JdxAhLe9E+LMLOrkWnhPXdCGID6s385nSlMCT?=
 =?us-ascii?Q?60Zt7JRxfxvTmrRWHQkuJ/9KFGOMCFYlhe3e3l5yV2NsTRJoTeaLnYu8tVAq?=
 =?us-ascii?Q?m2oPGlwTIKJ5mQy55GfXpDpdjvb5rU6Kc0J5ngzff/Q5HMKUPozXgVdr1Dwm?=
 =?us-ascii?Q?7tOmKu7OG6NEFjZNmzR/oP77ZdREngLe47bx8l7/KvaSUdiPOhAk7RD0jIY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e1407b-59f2-4191-b314-08db63242718
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 04:45:13.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shiji Yang <yangshiji66@qq.com>

Add a struct_group to around all members in struct ath_cycle_counters.
It can help the compiler detect the intended bounds of the memcpy() and
memset().

This patch fixes the following build warning:

In function 'fortify_memset_chk',
    inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning:
detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  314 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@qq.com>
---
More discussion on: https://github.com/openwrt/openwrt/pull/12764
---
 drivers/net/wireless/ath/ath.h                | 10 ++++++----
 drivers/net/wireless/ath/ath5k/ani.c          |  2 +-
 drivers/net/wireless/ath/ath5k/base.c         |  4 ++--
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |  2 +-
 drivers/net/wireless/ath/ath9k/link.c         |  2 +-
 drivers/net/wireless/ath/ath9k/main.c         |  4 ++--
 drivers/net/wireless/ath/hw.c                 |  2 +-
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f02a308a9..4b42e401a 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -43,10 +43,12 @@ struct ath_ani {
 };
 
 struct ath_cycle_counters {
-	u32 cycles;
-	u32 rx_busy;
-	u32 rx_frame;
-	u32 tx_frame;
+	struct_group(cnts,
+		u32 cycles;
+		u32 rx_busy;
+		u32 rx_frame;
+		u32 tx_frame;
+	);
 };
 
 enum ath_device_state {
diff --git a/drivers/net/wireless/ath/ath5k/ani.c b/drivers/net/wireless/ath/ath5k/ani.c
index 850c608b4..fa95f0f0f 100644
--- a/drivers/net/wireless/ath/ath5k/ani.c
+++ b/drivers/net/wireless/ath/ath5k/ani.c
@@ -379,7 +379,7 @@ ath5k_hw_ani_get_listen_time(struct ath5k_hw *ah, struct ath5k_ani_state *as)
 	spin_lock_bh(&common->cc_lock);
 
 	ath_hw_cycle_counters_update(common);
-	memcpy(&as->last_cc, &common->cc_ani, sizeof(as->last_cc));
+	memcpy(&as->last_cc.cnts, &common->cc_ani.cnts, sizeof(as->last_cc.cnts));
 
 	/* clears common->cc_ani */
 	listen = ath_hw_get_listen_time(common);
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index c59c14483..efe072e7a 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -2985,8 +2985,8 @@ ath5k_reset(struct ath5k_hw *ah, struct ieee80211_channel *chan,
 	memset(&ah->survey, 0, sizeof(ah->survey));
 	spin_lock_bh(&common->cc_lock);
 	ath_hw_cycle_counters_update(common);
-	memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-	memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+	memset(&common->cc_survey.cnts, 0, sizeof(common->cc_survey.cnts));
+	memset(&common->cc_ani.cnts, 0, sizeof(common->cc_ani.cnts));
 	spin_unlock_bh(&common->cc_lock);
 
 	/*
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 11ed30d6b..eb62115b1 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -665,7 +665,7 @@ ath5k_get_survey(struct ieee80211_hw *hw, int idx, struct survey_info *survey)
 		ah->survey.time_rx += cc->rx_frame / div;
 		ah->survey.time_tx += cc->tx_frame / div;
 	}
-	memset(cc, 0, sizeof(*cc));
+	memset(&cc->cnts, 0, sizeof(cc->cnts));
 	spin_unlock_bh(&common->cc_lock);
 
 	memcpy(survey, &ah->survey, sizeof(*survey));
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index 9d84003db..0d557e6b6 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -536,7 +536,7 @@ int ath_update_survey_stats(struct ath_softc *sc)
 	if (cc->cycles > 0)
 		ret = cc->rx_busy * 100 / cc->cycles;
 
-	memset(cc, 0, sizeof(*cc));
+	memset(&cc->cnts, 0, sizeof(cc->cnts));
 
 	ath_update_survey_nf(sc, pos);
 
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a4197c14f..8608a29a1 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -135,8 +135,8 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (power_mode != ATH9K_PM_AWAKE) {
 		spin_lock(&common->cc_lock);
 		ath_hw_cycle_counters_update(common);
-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+		memset(&common->cc_survey.cnts, 0, sizeof(common->cc_survey.cnts));
+		memset(&common->cc_ani.cnts, 0, sizeof(common->cc_ani.cnts));
 		spin_unlock(&common->cc_lock);
 	}
 
diff --git a/drivers/net/wireless/ath/hw.c b/drivers/net/wireless/ath/hw.c
index 85955572a..be8bfed9d 100644
--- a/drivers/net/wireless/ath/hw.c
+++ b/drivers/net/wireless/ath/hw.c
@@ -183,7 +183,7 @@ int32_t ath_hw_get_listen_time(struct ath_common *common)
 	listen_time = (cc->cycles - cc->rx_frame - cc->tx_frame) /
 		      (common->clockrate * 1000);
 
-	memset(cc, 0, sizeof(*cc));
+	memset(&cc->cnts, 0, sizeof(cc->cnts));
 
 	return listen_time;
 }
-- 
2.30.2

