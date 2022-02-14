Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E74B5635
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356399AbiBNQaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiBNQaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA760ABD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xp5NTAp/yhUku+lHgv6vzjBdCreaI7LGBjME44npsDY=;
        t=1644856213; x=1646065813; b=MbS6MIzAv9/TtDhv5UpSaXmM9zECmA0vUathh1T3qcVJZZc
        r64e9qdlUEFHOyGGYWct4lDWM5zsLhvCO46z6yDtG8TjACK9Bjp5RcupUrA4dTlRLcyjZKQq0gYng
        WpqdubBWk3ZTked1IInmqpKtBnINtoN6WBpiJC1XuBqtQ55ow0Ig+fzVDdQkXJTH9cW0DH1e9zEyU
        D/GkpKglnt2LDxfMSdMQdNgKgVihZEwrf+vzxSLvrCsSM3QFuUiiAzy9mNyCRAH+YcARsWziSLkOf
        M6OxK1SdhQzOVpRl44yNVSFCMUNDcKxQ0nGZBcoOi/HKUVJkQH1Y+w3PyHMbLNIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEt-0011mw-BY;
        Mon, 14 Feb 2022 17:30:11 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 12/19] mac80211: Support parsing EHT elements
Date:   Mon, 14 Feb 2022 17:29:59 +0100
Message-Id: <20220214173004.4d52ddaf1af4.Ib6beb1aa85e25b71ce40d3260b2e5b117cc42308@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Parse the new EHT elements in the element parsing utilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/util.c        | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index da35791b8378..538d047d7f27 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1587,6 +1587,8 @@ struct ieee802_11_elems {
 	const struct ieee80211_s1g_oper_ie *s1g_oper;
 	const struct ieee80211_s1g_bcn_compat_ie *s1g_bcn_compat;
 	const struct ieee80211_aid_response_ie *aid_resp;
+	const struct ieee80211_eht_cap_elem *eht_cap;
+	const struct ieee80211_eht_operation *eht_operation;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1608,6 +1610,7 @@ struct ieee802_11_elems {
 	u8 bssid_index_len;
 	u8 tx_pwr_env_len[IEEE80211_TPE_MAX_IE_COUNT];
 	u8 tx_pwr_env_num;
+	u8 eht_cap_len;
 
 	/* whether a parse error occurred while retrieving these elements */
 	bool parse_error;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1a8e18794387..b3c3191b86ee 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1008,6 +1008,17 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		if (len >= sizeof(*elems->he_6ghz_capa))
 			elems->he_6ghz_capa = data;
 		break;
+	case WLAN_EID_EXT_EHT_CAPABILITY:
+		if (ieee80211_eht_capa_size_ok(elems->he_cap,
+					       data, len)) {
+			elems->eht_cap = data;
+			elems->eht_cap_len = len;
+		}
+		break;
+	case WLAN_EID_EXT_EHT_OPERATION:
+		if (ieee80211_eht_oper_size_ok(data, len))
+			elems->eht_operation = data;
+		break;
 	}
 }
 
-- 
2.34.1

