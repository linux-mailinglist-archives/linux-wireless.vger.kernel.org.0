Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127F1D32F1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJJUxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 16:53:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 16:53:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so9445184wrw.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbWsOyqaUaMHm6xbSII/Hh4r9T9pk6P3FHSekk7NLFU=;
        b=lC2l7cvBPfIl4Gq/l8GvzR3FxvmfuhHxOkkKNG+Nzv3wKCi4kplrEMVe2j6TbVpk/l
         SdZTvDG/1zbVLm4dJaCnG8Xy8+ghhrToYzKyFegOnQtjEi1OWRlueKewQLjqt25tXr4i
         hnYHONPrQN02siE1dX1miH07uqVW4gXOub1dICHKpO5wb3vQbxc/qxuSNwWiYQJj6pTp
         ir9tudAC5vFJgsOPCCgxkHEDOWlWjP+LKRk9IAA+6DM6ASTNUezOEhQxwPKVqvB+J1lJ
         9EGxl6y9CDKsSjJwDyv0c5BqqWtYNW8s4Kkr/kjtkjj5GIg7NkT1OoNVKROhl2Fur2z/
         Y+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbWsOyqaUaMHm6xbSII/Hh4r9T9pk6P3FHSekk7NLFU=;
        b=YoKzmkukXGE+ti+HzlZ3Wwidq9WdqFqjzonRz5QK3j0htbsNkVjCu7K7cSm//nJhmz
         f2ygBOe3yyfYimRpxMtK3o67ZFKlbBshvnuDc4Dmh4sDsqtg18Y1uOyHmvaYMtn3M0It
         GXdXj8KplLmOLk8pNvf4lskCl2zPzVGA3LWCkfJpkYlfva+EGKAKGNS+3UMjR0cb93dj
         bYYVgHHu8n5FC69tcgrf6VhC6vtcAVti990J0jCVp9WAWiFTMM/2sLlgCH5MTdvu9fQ3
         LpJj6uIo4pQzwjfJFZqPR3dWfBieMZ7tvgYYK+Gzu0icmg5jyTUoZJXx1bzFpORBMufT
         eu1Q==
X-Gm-Message-State: APjAAAVpZ6PZ7xfNfnU1w/QSYiLjy9rj01+7nA9u6qbh6rh2MRiabySU
        yYU5XqXBpd1HJBZuZYIQ3U1MGB6ZuP8=
X-Google-Smtp-Source: APXvYqwAVP4Sirp8uMbLsyEKE2RUSL0NVI9HK5gNpEZC2jXRuM8qAOBVr6co12geF+Z0ocycj3RI6Q==
X-Received: by 2002:a5d:4901:: with SMTP id x1mr2092059wrq.28.1570740799141;
        Thu, 10 Oct 2019 13:53:19 -0700 (PDT)
Received: from localhost.localdomain ([31.147.208.18])
        by smtp.googlemail.com with ESMTPSA id y18sm5179081wrs.6.2019.10.10.13.53.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 13:53:18 -0700 (PDT)
From:   =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Subject: [PATCH] ath: rename regulatory rules
Date:   Thu, 10 Oct 2019 22:53:15 +0200
Message-Id: <1570740795-12522-1-git-send-email-pozega.tomislav@gmail.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Regulatory rule defines in regd.c are used not only by ath9k but also
ath10k driver (haven't test other drivers) and thus should be
renamed from ATH9K* to ATH*.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 drivers/net/wireless/ath/regd.c |   50 +++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index e25bfdf..20f4f8e 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -33,33 +33,33 @@
  */
 
 /* Only these channels all allow active scan on all world regulatory domains */
-#define ATH9K_2GHZ_CH01_11	REG_RULE(2412-10, 2462+10, 40, 0, 20, 0)
+#define ATH_2GHZ_CH01_11	REG_RULE(2412-10, 2462+10, 40, 0, 20, 0)
 
 /* We enable active scan on these a case by case basis by regulatory domain */
-#define ATH9K_2GHZ_CH12_13	REG_RULE(2467-10, 2472+10, 40, 0, 20,\
+#define ATH_2GHZ_CH12_13	REG_RULE(2467-10, 2472+10, 40, 0, 20,\
 					 NL80211_RRF_NO_IR)
-#define ATH9K_2GHZ_CH14		REG_RULE(2484-10, 2484+10, 40, 0, 20,\
+#define ATH_2GHZ_CH14		REG_RULE(2484-10, 2484+10, 40, 0, 20,\
 					 NL80211_RRF_NO_IR | \
 					 NL80211_RRF_NO_OFDM)
 
 /* We allow IBSS on these on a case by case basis by regulatory domain */
-#define ATH9K_5GHZ_5150_5350	REG_RULE(5150-10, 5350+10, 80, 0, 30,\
+#define ATH_5GHZ_5150_5350	REG_RULE(5150-10, 5350+10, 80, 0, 30,\
 					 NL80211_RRF_NO_IR)
-#define ATH9K_5GHZ_5470_5850	REG_RULE(5470-10, 5850+10, 80, 0, 30,\
+#define ATH_5GHZ_5470_5850	REG_RULE(5470-10, 5850+10, 80, 0, 30,\
 					 NL80211_RRF_NO_IR)
-#define ATH9K_5GHZ_5725_5850	REG_RULE(5725-10, 5850+10, 80, 0, 30,\
+#define ATH_5GHZ_5725_5850	REG_RULE(5725-10, 5850+10, 80, 0, 30,\
 					 NL80211_RRF_NO_IR)
 
-#define ATH9K_2GHZ_ALL		ATH9K_2GHZ_CH01_11, \
-				ATH9K_2GHZ_CH12_13, \
-				ATH9K_2GHZ_CH14
+#define ATH_2GHZ_ALL		ATH_2GHZ_CH01_11, \
+				ATH_2GHZ_CH12_13, \
+				ATH_2GHZ_CH14
 
-#define ATH9K_5GHZ_ALL		ATH9K_5GHZ_5150_5350, \
-				ATH9K_5GHZ_5470_5850
+#define ATH_5GHZ_ALL		ATH_5GHZ_5150_5350, \
+				ATH_5GHZ_5470_5850
 
 /* This one skips what we call "mid band" */
-#define ATH9K_5GHZ_NO_MIDBAND	ATH9K_5GHZ_5150_5350, \
-				ATH9K_5GHZ_5725_5850
+#define ATH_5GHZ_NO_MIDBAND	ATH_5GHZ_5150_5350, \
+				ATH_5GHZ_5725_5850
 
 /* Can be used for:
  * 0x60, 0x61, 0x62 */
@@ -67,8 +67,8 @@
 	.n_reg_rules = 5,
 	.alpha2 =  "99",
 	.reg_rules = {
-		ATH9K_2GHZ_ALL,
-		ATH9K_5GHZ_ALL,
+		ATH_2GHZ_ALL,
+		ATH_5GHZ_ALL,
 	}
 };
 
@@ -77,9 +77,9 @@
 	.n_reg_rules = 4,
 	.alpha2 =  "99",
 	.reg_rules = {
-		ATH9K_2GHZ_CH01_11,
-		ATH9K_2GHZ_CH12_13,
-		ATH9K_5GHZ_NO_MIDBAND,
+		ATH_2GHZ_CH01_11,
+		ATH_2GHZ_CH12_13,
+		ATH_5GHZ_NO_MIDBAND,
 	}
 };
 
@@ -88,8 +88,8 @@
 	.n_reg_rules = 3,
 	.alpha2 =  "99",
 	.reg_rules = {
-		ATH9K_2GHZ_CH01_11,
-		ATH9K_5GHZ_NO_MIDBAND,
+		ATH_2GHZ_CH01_11,
+		ATH_5GHZ_NO_MIDBAND,
 	}
 };
 
@@ -98,8 +98,8 @@
 	.n_reg_rules = 3,
 	.alpha2 =  "99",
 	.reg_rules = {
-		ATH9K_2GHZ_CH01_11,
-		ATH9K_5GHZ_ALL,
+		ATH_2GHZ_CH01_11,
+		ATH_5GHZ_ALL,
 	}
 };
 
@@ -108,9 +108,9 @@
 	.n_reg_rules = 4,
 	.alpha2 =  "99",
 	.reg_rules = {
-		ATH9K_2GHZ_CH01_11,
-		ATH9K_2GHZ_CH12_13,
-		ATH9K_5GHZ_ALL,
+		ATH_2GHZ_CH01_11,
+		ATH_2GHZ_CH12_13,
+		ATH_5GHZ_ALL,
 	}
 };
 
-- 
1.7.0.4

