Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709A02D9DA0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440374AbgLNR1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:27:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:20222 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440353AbgLNR0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:26:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966746; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DXLfqPvuhj2DiSvXJSOSQ80E+MCQkLUCD7jGR33tBnU=; b=Bngs0HCgnU7Iua2Y+2V6C4DS4OXkHKDVQNqO/uASc8mf0CDD2by++r7w7JfHKjN/iI94Tg1A
 5SCIcsKRUd8ITbf39tgbxoSMVEKt4uukA2l/LA2uAWs/oZe0tU4OHJv9TOxHKPptjGl6AFgd
 RzOg0zy2mG5UsucA0U+qk3TxJ90=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fd79ffd9499561cc1521faa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:25:17
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C468C433CA; Mon, 14 Dec 2020 17:25:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8057CC43461;
        Mon, 14 Dec 2020 17:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8057CC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/5] ath: Export ath_hw_keysetmac()
Date:   Mon, 14 Dec 2020 19:21:16 +0200
Message-Id: <20201214172118.18100-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214172118.18100-1-jouni@codeaurora.org>
References: <20201214172118.18100-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath9k is going to use this for safer management of key cache entries.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath.h | 1 +
 drivers/net/wireless/ath/key.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index 7a364eca46d6..9d18105c449f 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -203,6 +203,7 @@ int ath_key_config(struct ath_common *common,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key);
 bool ath_hw_keyreset(struct ath_common *common, u16 entry);
+bool ath_hw_keysetmac(struct ath_common *common, u16 entry, const u8 *mac);
 void ath_hw_cycle_counters_update(struct ath_common *common);
 int32_t ath_hw_get_listen_time(struct ath_common *common);
 
diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index 59618bb41f6c..cb266cf3c77c 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -84,8 +84,7 @@ bool ath_hw_keyreset(struct ath_common *common, u16 entry)
 }
 EXPORT_SYMBOL(ath_hw_keyreset);
 
-static bool ath_hw_keysetmac(struct ath_common *common,
-			     u16 entry, const u8 *mac)
+bool ath_hw_keysetmac(struct ath_common *common, u16 entry, const u8 *mac)
 {
 	u32 macHi, macLo;
 	u32 unicast_flag = AR_KEYTABLE_VALID;
@@ -125,6 +124,7 @@ static bool ath_hw_keysetmac(struct ath_common *common,
 
 	return true;
 }
+EXPORT_SYMBOL(ath_hw_keysetmac);
 
 static bool ath_hw_set_keycache_entry(struct ath_common *common, u16 entry,
 				      const struct ath_keyval *k,
-- 
2.20.1

