Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695073F5BF8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhHXKXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236257AbhHXKXt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4AA861357;
        Tue, 24 Aug 2021 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800585;
        bh=+327ZNOld72HlUPOg4sSvBzyK9vK8+RH7mIh6t3SQg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjXkXCZXr4zC5KwI1reIuYtbE1aTekY/F3dtYA9g/AbSx6mMfsZFjCrTaP7nhSiQI
         5gQfW9EOw+e9EdJcdwRWsO7dpnWpqRg9ZiRUCyyCahgCjhQtgJrIvj2wpWpMg8d3Ml
         GGrA+nNWyRfXFbTrNrr2ld1Ex8hO9LhAZ8V4RVq2H8PHEwuUx6x5i6D8f+UCc2D8q+
         ZsvDlUR/8ND5OjSqbXBIpcy+g01gmYtkVxic3PjmkCjvmP8buDEu+Jg72C83BumJ9J
         IfbAyiNueqkg5LOWx2ZOvudF7oSjH6rXPBhLKSzzhrmQP7R3TbGObYJs9V8tM8gtbl
         INaHB5XbBI00g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 5/9] mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
Date:   Tue, 24 Aug 2021 12:22:23 +0200
Message-Id: <a70f5ed6bc1c1e59397f41d6c89a047b47c6d76f.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce sta_rec_he_6g_capa tlv in order configure the mcu with 6GHz
capabilities. This is a preliminary patch to enable 6GHz band for
mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 12 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8e1475aa35ac..ab44e61e3aaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -770,8 +770,18 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 		mt76_connac_mcu_sta_amsdu_tlv(skb, sta, vif);
 
 	/* starec he */
-	if (sta->he_cap.has_he)
+	if (sta->he_cap.has_he) {
 		mt76_connac_mcu_sta_he_tlv(skb, sta);
+		if (band == NL80211_BAND_6GHZ &&
+		    sta_state == MT76_STA_INFO_STATE_ASSOC) {
+			struct sta_rec_he_6g_capa *he_6g_capa;
+
+			tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G,
+						      sizeof(*he_6g_capa));
+			he_6g_capa = (struct sta_rec_he_6g_capa *)tlv;
+			he_6g_capa->capa = sta->he_6ghz_capa.capa;
+		}
+	}
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 0f11574af535..5ab5e185a8bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -145,6 +145,13 @@ struct sta_rec_phy {
 	u8 rsv[2];
 } __packed;
 
+struct sta_rec_he_6g_capa {
+	__le16 tag;
+	__le16 len;
+	__le16 capa;
+	u8 rsv[2];
+} __packed;
+
 /* wtbl_rec */
 
 struct wtbl_req_hdr {
@@ -303,6 +310,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_vht) +	\
 					 sizeof(struct sta_rec_uapsd) + \
 					 sizeof(struct sta_rec_amsdu) +	\
+					 sizeof(struct sta_rec_he_6g_capa) + \
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
 
@@ -329,6 +337,7 @@ enum {
 	STA_REC_MUEDCA,
 	STA_REC_BFEE,
 	STA_REC_PHY = 0x15,
+	STA_REC_HE_6G = 0x17,
 	STA_REC_MAX_NUM
 };
 
-- 
2.31.1

