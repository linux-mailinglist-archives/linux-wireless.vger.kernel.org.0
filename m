Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC32D9D9C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440360AbgLNR0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:26:16 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:14744 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440343AbgLNRZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:25:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966730; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KisoZtDlrm+samIaHQpbHbHIH0aRsaFa190cA8u7/fM=; b=u3p/hcGuRzF9jI4Pux/Enoc0NU8IxttXZl85krF2fnjLyomb4yXxDtIdeJTDUVoVng5zlnZV
 RfUArX7Xar4QuClOwt5h0n/ALSCnUmsav0IFA7tEhesjHEBeBp0lrqfH9M1zIxBbxGLi+Y6e
 UMYqmHoaOcDXZ7sjl5x36NHXMuM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fd7a0005723412e543c0a63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:25:20
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48D25C43461; Mon, 14 Dec 2020 17:25:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E08FC433ED;
        Mon, 14 Dec 2020 17:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E08FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/5] ath: Modify ath_key_delete() to not need full key entry
Date:   Mon, 14 Dec 2020 19:21:17 +0200
Message-Id: <20201214172118.18100-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214172118.18100-1-jouni@codeaurora.org>
References: <20201214172118.18100-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tkip_keymap can be used internally to avoid the reference to key->cipher
and with this, only the key index value itself is needed. This allows
ath_key_delete() call to be postponed to be handled after the upper
layer STA and key entry have already been removed. This is needed to
make ath9k key cache management safer.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath.h                |  2 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  2 +-
 drivers/net/wireless/ath/ath9k/main.c         |  5 ++-
 drivers/net/wireless/ath/key.c                | 34 +++++++++----------
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index 9d18105c449f..f083fb9038c3 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -197,7 +197,7 @@ struct sk_buff *ath_rxbuf_alloc(struct ath_common *common,
 bool ath_is_mybeacon(struct ath_common *common, struct ieee80211_hdr *hdr);
 
 void ath_hw_setbssidmask(struct ath_common *common);
-void ath_key_delete(struct ath_common *common, struct ieee80211_key_conf *key);
+void ath_key_delete(struct ath_common *common, u8 hw_key_idx);
 int ath_key_config(struct ath_common *common,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 8f2719ff463c..532eeac9e83e 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -522,7 +522,7 @@ ath5k_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		}
 		break;
 	case DISABLE_KEY:
-		ath_key_delete(common, key);
+		ath_key_delete(common, key->hw_key_idx);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 2b7832b1c800..72ef319feeda 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1461,7 +1461,7 @@ static int ath9k_htc_set_key(struct ieee80211_hw *hw,
 		}
 		break;
 	case DISABLE_KEY:
-		ath_key_delete(common, key);
+		ath_key_delete(common, key->hw_key_idx);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 10b87aa1d289..bcdf150060f2 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1543,12 +1543,11 @@ static void ath9k_del_ps_key(struct ath_softc *sc,
 {
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_node *an = (struct ath_node *) sta->drv_priv;
-	struct ieee80211_key_conf ps_key = { .hw_key_idx = an->ps_key };
 
 	if (!an->ps_key)
 	    return;
 
-	ath_key_delete(common, &ps_key);
+	ath_key_delete(common, an->ps_key);
 	an->ps_key = 0;
 	an->key_idx[0] = 0;
 }
@@ -1748,7 +1747,7 @@ static int ath9k_set_key(struct ieee80211_hw *hw,
 		}
 		break;
 	case DISABLE_KEY:
-		ath_key_delete(common, key);
+		ath_key_delete(common, key->hw_key_idx);
 		if (an) {
 			for (i = 0; i < ARRAY_SIZE(an->key_idx); i++) {
 				if (an->key_idx[i] != key->hw_key_idx)
diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index cb266cf3c77c..61b59a804e30 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -581,38 +581,38 @@ EXPORT_SYMBOL(ath_key_config);
 /*
  * Delete Key.
  */
-void ath_key_delete(struct ath_common *common, struct ieee80211_key_conf *key)
+void ath_key_delete(struct ath_common *common, u8 hw_key_idx)
 {
 	/* Leave CCMP and TKIP (main key) configured to avoid disabling
 	 * encryption for potentially pending frames already in a TXQ with the
 	 * keyix pointing to this key entry. Instead, only clear the MAC address
 	 * to prevent RX processing from using this key cache entry.
 	 */
-	if (test_bit(key->hw_key_idx, common->ccmp_keymap) ||
-	    test_bit(key->hw_key_idx, common->tkip_keymap))
-		ath_hw_keysetmac(common, key->hw_key_idx, NULL);
+	if (test_bit(hw_key_idx, common->ccmp_keymap) ||
+	    test_bit(hw_key_idx, common->tkip_keymap))
+		ath_hw_keysetmac(common, hw_key_idx, NULL);
 	else
-		ath_hw_keyreset(common, key->hw_key_idx);
-	if (key->hw_key_idx < IEEE80211_WEP_NKID)
+		ath_hw_keyreset(common, hw_key_idx);
+	if (hw_key_idx < IEEE80211_WEP_NKID)
 		return;
 
-	clear_bit(key->hw_key_idx, common->keymap);
-	clear_bit(key->hw_key_idx, common->ccmp_keymap);
-	if (key->cipher != WLAN_CIPHER_SUITE_TKIP)
+	clear_bit(hw_key_idx, common->keymap);
+	clear_bit(hw_key_idx, common->ccmp_keymap);
+	if (!test_bit(hw_key_idx, common->tkip_keymap))
 		return;
 
-	clear_bit(key->hw_key_idx + 64, common->keymap);
+	clear_bit(hw_key_idx + 64, common->keymap);
 
-	clear_bit(key->hw_key_idx, common->tkip_keymap);
-	clear_bit(key->hw_key_idx + 64, common->tkip_keymap);
+	clear_bit(hw_key_idx, common->tkip_keymap);
+	clear_bit(hw_key_idx + 64, common->tkip_keymap);
 
 	if (!(common->crypt_caps & ATH_CRYPT_CAP_MIC_COMBINED)) {
-		ath_hw_keyreset(common, key->hw_key_idx + 32);
-		clear_bit(key->hw_key_idx + 32, common->keymap);
-		clear_bit(key->hw_key_idx + 64 + 32, common->keymap);
+		ath_hw_keyreset(common, hw_key_idx + 32);
+		clear_bit(hw_key_idx + 32, common->keymap);
+		clear_bit(hw_key_idx + 64 + 32, common->keymap);
 
-		clear_bit(key->hw_key_idx + 32, common->tkip_keymap);
-		clear_bit(key->hw_key_idx + 64 + 32, common->tkip_keymap);
+		clear_bit(hw_key_idx + 32, common->tkip_keymap);
+		clear_bit(hw_key_idx + 64 + 32, common->tkip_keymap);
 	}
 }
 EXPORT_SYMBOL(ath_key_delete);
-- 
2.20.1

