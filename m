Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA2A7E9D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfIDI7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 04:59:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIDI7n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 04:59:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4682A61213; Wed,  4 Sep 2019 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567587582;
        bh=kz6dwXzHfr0deg3i62oSRnUEz0ppenM9hUgvgvIBEFo=;
        h=From:To:Cc:Subject:Date:From;
        b=B4s1/7+CDFoTwvFxmIHvqSIJ7Jjo1TvVHiANT/GStJh6aWWrfOA2vryfzNuWr3+fe
         K3xLl0MKNGUgtOFLPGyJZBlLGwqeVPXe/051QLYQtgZ41ma7lOAusLMbyLm7Mjk3gG
         G+lSVe51iW4q5BxDgikiv19xfSihoqS9f4TugPxM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E68216119E;
        Wed,  4 Sep 2019 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567587581;
        bh=kz6dwXzHfr0deg3i62oSRnUEz0ppenM9hUgvgvIBEFo=;
        h=From:To:Cc:Subject:Date:From;
        b=oQ0Yl5ueqjYPrRC4amEzr6q4mlN4RJBqwSzkHaiDt6gU87PGLMVa4uQP8erZaOLRf
         +xGUnv6SEKetNilTeh1xKC1nFWxq9PKRmtVviWaTGgN24R1FH4AEsYiBT9V/kML3Eq
         7tq7S6gtZMewr8NGmN/HwMUtyFvVv/v4JKyIMr/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E68216119E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] mac80211: Store max_mtu in ieee80211_hw
Date:   Wed,  4 Sep 2019 16:58:04 +0800
Message-Id: <1567587484-31930-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make it possibly for drivers to adjust the default mat_mtu
by storing it in the hardware struct.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change to set max_mtu to IEEE80211_MAX_DATA_LEN in alloc_hw
 include/net/mac80211.h | 3 +++
 net/mac80211/iface.c   | 2 +-
 net/mac80211/main.c    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da01..8545b03 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2454,6 +2454,8 @@ enum ieee80211_hw_flags {
  *
  * @weight_multiplier: Driver specific airtime weight multiplier used while
  *	refilling deficit of each TXQ.
+ *
+ * @max_mtu: the max mtu could be set.
  */
 struct ieee80211_hw {
 	struct ieee80211_conf conf;
@@ -2491,6 +2493,7 @@ struct ieee80211_hw {
 	u8 max_nan_de_entries;
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
+	u32 max_mtu;
 };
 
 static inline bool _ieee80211_hw_check(struct ieee80211_hw *hw,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 06aac0a..32d87f0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1877,7 +1877,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		/* MTU range: 256 - 2304 */
 		ndev->min_mtu = 256;
-		ndev->max_mtu = IEEE80211_MAX_DATA_LEN;
+		ndev->max_mtu = local->hw.max_mtu;
 
 		ret = register_netdevice(ndev);
 		if (ret) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 85e4162..89a6a09 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -638,6 +638,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 					 IEEE80211_RADIOTAP_VHT_KNOWN_BANDWIDTH;
 	local->hw.uapsd_queues = IEEE80211_DEFAULT_UAPSD_QUEUES;
 	local->hw.uapsd_max_sp_len = IEEE80211_DEFAULT_MAX_SP_LEN;
+	local->hw.max_mtu = IEEE80211_MAX_DATA_LEN;
 	local->user_power_level = IEEE80211_UNSET_POWER_LEVEL;
 	wiphy->ht_capa_mod_mask = &mac80211_ht_capa_mod_mask;
 	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
-- 
1.9.1

