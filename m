Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C751D3BB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiEFIzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 04:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245583AbiEFIzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 04:55:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43F5C361
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=wDl7t8S0HvjKhn6wi+xRQpxwhBK2O+pUZa2LezCSC84=; t=1651827118; x=1653036718; 
        b=pGUvkhZChTxttQSmEpcYxxh5znpCvUJdrU/pTCFdBes8kO5/tIG/B58iCEtCWkHiv9rFhq5roVd
        KdYdcmIu/zmmh/swNoWj7ukJ5ZFRDckYsvO1t+eToa+sDQl2AGD/xQQjjgtQD6/R3iQFnG8nd7cT2
        2Qr1YTMXeSzJhnQM08VtSBP6V4UPS93vEExfffiQswkMlFZYMVI2f4YwpDwQCzDgpr+sJN113h0/t
        Vlpp1ZKpF6gIkSzsvtdYAmOskdpYNS2Ck8JptC6HTEA2APQcdvHmuIsJ2YjI4G8rAxtMn9CtdhmCW
        XhnhkFDErkTV4Z+wnlQ/y8BDvxN2+KZJyDMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmtgo-00463o-D4;
        Fri, 06 May 2022 10:51:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Jouni Malinen <j@w1.fi>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: unify CCMP/GCMP AAD construction
Date:   Fri,  6 May 2022 10:51:52 +0200
Message-Id: <20220506105150.51d66e2a6f3c.I65f12be82c112365169e8a9f48c7a71300e814b9@changeid>
X-Mailer: git-send-email 2.35.1
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

From: Johannes Berg <johannes.berg@intel.com>

Ping-Ke's previous patch adjusted the CCMP AAD construction
to properly take the order bit into account, but failed to
update the (identical) GCMP AAD construction as well.

Unify the AAD construction between the two cases.

Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/wpa.c | 87 +++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 56 deletions(-)

diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index cd35ae76d5b7..5fd8a3e8b5b4 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -311,14 +311,17 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
-
-static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
+/*
+ * Calculate AAD for CCMP/GCMP, returning qos_tid since we
+ * need that in CCMP also for b_0.
+ */
+static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad)
 {
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 mask_fc;
 	int a4_included, mgmt;
 	u8 qos_tid;
 	u16 len_a = 22;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	/*
 	 * Mask FC: zero subtype b4 b5 b6 (if not mgmt)
@@ -344,22 +347,6 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
 		qos_tid = 0;
 	}
 
-	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
-	 * mode authentication are not allowed to collide, yet both are derived
-	 * from this vector b_0. We only set L := 1 here to indicate that the
-	 * data size can be represented in (L+1) bytes. The CCM layer will take
-	 * care of storing the data length in the top (L+1) bytes and setting
-	 * and clearing the other bits as is required to derive the two IVs.
-	 */
-	b_0[0] = 0x1;
-
-	/* Nonce: Nonce Flags | A2 | PN
-	 * Nonce Flags: Priority (b0..b3) | Management (b4) | Reserved (b5..b7)
-	 */
-	b_0[1] = qos_tid | (mgmt << 4);
-	memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
-	memcpy(&b_0[8], pn, IEEE80211_CCMP_PN_LEN);
-
 	/* AAD (extra authenticate-only data) / masked 802.11 header
 	 * FC | A1 | A2 | A3 | SC | [A4] | [QC] */
 	put_unaligned_be16(len_a, &aad[0]);
@@ -378,8 +365,31 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
 		memset(&aad[24], 0, ETH_ALEN + IEEE80211_QOS_CTL_LEN);
 		aad[24] = qos_tid;
 	}
+
+	return qos_tid;
 }
 
+static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u8 qos_tid = ccmp_gcmp_aad(skb, aad);
+
+	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
+	 * mode authentication are not allowed to collide, yet both are derived
+	 * from this vector b_0. We only set L := 1 here to indicate that the
+	 * data size can be represented in (L+1) bytes. The CCM layer will take
+	 * care of storing the data length in the top (L+1) bytes and setting
+	 * and clearing the other bits as is required to derive the two IVs.
+	 */
+	b_0[0] = 0x1;
+
+	/* Nonce: Nonce Flags | A2 | PN
+	 * Nonce Flags: Priority (b0..b3) | Management (b4) | Reserved (b5..b7)
+	 */
+	b_0[1] = qos_tid | (ieee80211_is_mgmt(hdr->frame_control) << 4);
+	memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
+	memcpy(&b_0[8], pn, IEEE80211_CCMP_PN_LEN);
+}
 
 static inline void ccmp_pn2hdr(u8 *hdr, u8 *pn, int key_id)
 {
@@ -573,9 +583,7 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 
 static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad)
 {
-	__le16 mask_fc;
-	u8 qos_tid;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 
 	memcpy(j_0, hdr->addr2, ETH_ALEN);
 	memcpy(&j_0[ETH_ALEN], pn, IEEE80211_GCMP_PN_LEN);
@@ -583,40 +591,7 @@ static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad)
 	j_0[14] = 0;
 	j_0[AES_BLOCK_SIZE - 1] = 0x01;
 
-	/* AAD (extra authenticate-only data) / masked 802.11 header
-	 * FC | A1 | A2 | A3 | SC | [A4] | [QC]
-	 */
-	put_unaligned_be16(ieee80211_hdrlen(hdr->frame_control) - 2, &aad[0]);
-	/* Mask FC: zero subtype b4 b5 b6 (if not mgmt)
-	 * Retry, PwrMgt, MoreData; set Protected
-	 */
-	mask_fc = hdr->frame_control;
-	mask_fc &= ~cpu_to_le16(IEEE80211_FCTL_RETRY |
-				IEEE80211_FCTL_PM | IEEE80211_FCTL_MOREDATA);
-	if (!ieee80211_is_mgmt(hdr->frame_control))
-		mask_fc &= ~cpu_to_le16(0x0070);
-	mask_fc |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-
-	put_unaligned(mask_fc, (__le16 *)&aad[2]);
-	memcpy(&aad[4], &hdr->addr1, 3 * ETH_ALEN);
-
-	/* Mask Seq#, leave Frag# */
-	aad[22] = *((u8 *)&hdr->seq_ctrl) & 0x0f;
-	aad[23] = 0;
-
-	if (ieee80211_is_data_qos(hdr->frame_control))
-		qos_tid = ieee80211_get_tid(hdr);
-	else
-		qos_tid = 0;
-
-	if (ieee80211_has_a4(hdr->frame_control)) {
-		memcpy(&aad[24], hdr->addr4, ETH_ALEN);
-		aad[30] = qos_tid;
-		aad[31] = 0;
-	} else {
-		memset(&aad[24], 0, ETH_ALEN + IEEE80211_QOS_CTL_LEN);
-		aad[24] = qos_tid;
-	}
+	ccmp_gcmp_aad(skb, aad);
 }
 
 static inline void gcmp_pn2hdr(u8 *hdr, const u8 *pn, int key_id)
-- 
2.35.1

