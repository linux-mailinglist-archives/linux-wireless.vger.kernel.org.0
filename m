Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6034152DF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEFRjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 13:39:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34114 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfEFRjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 13:39:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so2720856otq.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wt5U1v1Ut1PuD1bJa6JYik9CGW3GmdcNVSMP6n6/Uic=;
        b=U/6ZjbyJxtuc+SrDPU6YGhYBM/5smxfdyCU7NJwdAR7Jd8HTWyH4thLJjXW2eL/U1H
         TPEI5gIUJeJ803pH2PR692sgMjhYDDdy2yvwqwBsDwDfoJP8PVd8mdqMu96+R90YvRcZ
         W7if8hZoHNWfZw+jbCjYOc4KJWN+m5Dbee7pJPTbnyL21cKpohVPImxYxHe5eRNpe3bv
         gRBuqT/0dihNRx6pqRxwUI3Y5JQOQBy67I5tzzl0w4SeoUvVHqrFr0GI+bQnrNO+S2ft
         1iZMqZmS7aVyXr3IyQXy+EdsYfBA9Y4lQz/iGoc+0I9HYc0yX64MJEgS2U1uQsUs7mfv
         DUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Wt5U1v1Ut1PuD1bJa6JYik9CGW3GmdcNVSMP6n6/Uic=;
        b=oYagTmMOMnFLXUozv3b2a06VDj3whHxWJ1zbY/wguq6zDxm5uhZf/SXpLb3jsTHK7n
         ZuU3MPeLmutdnBd1gCYmvXXRa6BgTmgCOf4uazbC29m+Fbt6hGQDl8lrd+rnITcVciWQ
         iP+5bRci5tPF95JIDmKd6ETXkjCWCnA3SmTicEGlmVmERue7nh+rMdas4sZ8banUttfo
         HjwvXB+OZnR01V1HjGqPni0bmMF9sTnVNREFpkQqYJoq+aCLKvhXex867Zkis+SsaO8H
         f02tNZ/+7Hz3m6oNo8UUrJxwHitvXwswHn2LCVUUhKUeq+p5COd7K/DI6CdV6tB3+Bdy
         PzsQ==
X-Gm-Message-State: APjAAAXl1vsa4TSWS6/Rwcv83WrXn+eYHHhv5Xe2trh3VR4gM/kqIlOZ
        GlwUeESMYZGQjSn/P84+6KI=
X-Google-Smtp-Source: APXvYqwtcaoykiUcI7oPgSFM0uPa75x/22w4QuE8un62zntXs88qT6xqSo6Uql+3non27qKCoSklfA==
X-Received: by 2002:a9d:758d:: with SMTP id s13mr18192259otk.306.1557164362622;
        Mon, 06 May 2019 10:39:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m14sm4168682oih.6.2019.05.06.10.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:39:21 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [RFC] rtlwifi: rtl8821ae: Use inline routines rather than macros for descriptor word 0
Date:   Mon,  6 May 2019 12:39:16 -0500
Message-Id: <20190506173916.16486-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver uses complicated macros to set parts of word 0 of the TX and RX
descriptors. These are changed into inline routines.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

Kalle,

Based on your comment on how much you dislike those "byte macros", I have
converted a few of them from rtl8821ae into static inline functions.

Is this what you had in mind, and do you consider these changes to
improve the code?

These routines still need to mask the value before the ! operation with
the masked original value.

Thanks,
Larry
---

 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  | 33 ++++----
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.h  | 80 ++++++++++++++-----
 2 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
index 7b6faf38e09c..2ad33cfb1656 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
@@ -703,8 +703,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	if (firstseg) {
 		if (rtlhal->earlymode_enable) {
 			SET_TX_DESC_PKT_OFFSET(pdesc, 1);
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN +
-					   EM_HDR_LEN);
+			set_tx_desc_offset((__le32 *)pdesc,
+					   USB_HWDESC_HEADER_LEN + EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
@@ -713,7 +713,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 					 (u8 *)(skb->data));
 			}
 		} else {
-			SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+			set_tx_desc_offset((__le32 *)pdesc,
+					   USB_HWDESC_HEADER_LEN);
 		}
 
 
@@ -752,8 +753,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 		SET_TX_DESC_TX_SUB_CARRIER(pdesc,
 			rtl8821ae_sc_mapping(hw, ptcb_desc));
 
-		SET_TX_DESC_LINIP(pdesc, 0);
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16)skb_len);
+		set_tx_desc_linip((__le32 *)pdesc, 0);
+		set_tx_desc_pkt_size((__le32 *)pdesc, (u16)skb_len);
 		if (sta) {
 			u8 ampdu_density = sta->ht_cap.ampdu_density;
 
@@ -789,15 +790,15 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Enable RDG function.\n");
 				SET_TX_DESC_RDG_ENABLE(pdesc, 1);
-				SET_TX_DESC_HTC(pdesc, 1);
+				set_tx_desc_htc((__le32 *)pdesc, 1);
 			}
 		}
 		/* tx report */
 		rtl_set_tx_report(ptcb_desc, pdesc, hw, tx_info);
 	}
 
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_first_seg((__le32 *)pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg((__le32 *)pdesc, (lastseg ? 1 : 0));
 	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)buf_len);
 	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
 	/* if (rtlpriv->dm.useramask) { */
@@ -815,7 +816,7 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	SET_TX_DESC_MORE_FRAG(pdesc, (lastseg ? 0 : 1));
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
-		SET_TX_DESC_BMC(pdesc, 1);
+		set_tx_desc_bmc((__le32 *)pdesc, 1);
 	}
 
 	rtl8821ae_dm_set_tx_ant_by_tx_info(hw, pdesc, ptcb_desc->mac_id);
@@ -841,12 +842,12 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	}
 	CLEAR_PCI_TX_DESC_CONTENT(pdesc, TX_DESC_SIZE);
 
-	SET_TX_DESC_FIRST_SEG(pdesc, 1);
-	SET_TX_DESC_LAST_SEG(pdesc, 1);
+	set_tx_desc_first_seg((__le32 *)pdesc, 1);
+	set_tx_desc_last_seg((__le32 *)pdesc, 1);
 
-	SET_TX_DESC_PKT_SIZE((u8 *)pdesc, (u16)(skb->len));
+	set_tx_desc_pkt_size((__le32 *)pdesc, (u16)(skb->len));
 
-	SET_TX_DESC_OFFSET(pdesc, USB_HWDESC_HEADER_LEN);
+	set_tx_desc_offset((__le32 *)pdesc, USB_HWDESC_HEADER_LEN);
 
 	SET_TX_DESC_USE_RATE(pdesc, 1);
 	SET_TX_DESC_TX_RATE(pdesc, DESC_RATE1M);
@@ -864,7 +865,7 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
 
 	SET_TX_DESC_MACID(pdesc, 0);
 
-	SET_TX_DESC_OWN(pdesc, 1);
+	set_tx_desc_own((__le32 *)pdesc, 1);
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD,
 		      "H2C Tx Cmd Content\n",
@@ -877,7 +878,7 @@ void rtl8821ae_set_desc(struct ieee80211_hw *hw, u8 *pdesc,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			SET_TX_DESC_OWN(pdesc, 1);
+			set_tx_desc_own((__le32 *)pdesc, 1);
 			break;
 		case HW_DESC_TX_NEXTDESC_ADDR:
 			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *)val);
@@ -919,7 +920,7 @@ u64 rtl8821ae_get_desc(struct ieee80211_hw *hw,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_TX_DESC_OWN(pdesc);
+			ret = get_tx_desc_own((__le32 *)pdesc);
 			break;
 		case HW_DESC_TXBUFF_ADDR:
 			ret = GET_TX_DESC_TX_BUFFER_ADDRESS(pdesc);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index 861d78a24d05..64deaf4dab23 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -14,25 +14,67 @@
 #define USB_HWDESC_HEADER_LEN			40
 #define CRCLENGTH						4
 
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 16, __val)
-#define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 16, 8, __val)
-#define SET_TX_DESC_BMC(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 24, 1, __val)
-#define SET_TX_DESC_HTC(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 25, 1, __val)
-#define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 26, 1, __val)
-#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
-#define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
-#define SET_TX_DESC_OWN(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
-
-#define GET_TX_DESC_OWN(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+/* Set packet size (16 bits) in TX descriptor word 0 */
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u16 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(0, 15)) |
+			       __val);
+}
+
+/* Set offset (8 bits) in TX descriptor word 0 */
+static inline void set_tx_desc_offset(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(16, 23)) |
+			       __val << 16);
+}
+
+/* Set bmc (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_bmc(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(24, 24)) |
+			       __val << 24);
+}
+
+/* Set htc (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_htc(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(25, 25)) |
+			       __val << 25);
+}
+
+/* Set last segment flag (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(26, 26)) |
+			       __val << 26);
+}
+
+/* Set first segment iflag (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(27, 27)) |
+			       __val << 27);
+}
+
+/* Set linip (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_linip(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(28, 28)) |
+			       __val << 18);
+}
+
+/* Set own flag (1 bit) in TX descriptor word 0 */
+static inline void set_tx_desc_own(__le32 *__pdesc, u8 __val)
+{
+	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(31, 31)) |
+			       __val << 31);
+}
+
+/* Get own flag (1 bit) from TX descriptor word 0 */
+static inline u8 get_tx_desc_own(__le32 *__pdesc)
+{
+	return (le32_to_cpu(*__pdesc) & ~GENMASK(31, 31)) >> 31;
+}
 
 #define SET_TX_DESC_MACID(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
-- 
2.21.0

