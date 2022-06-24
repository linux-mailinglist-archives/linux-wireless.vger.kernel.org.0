Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F855A19B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiFXTNh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiFXTNG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 15:13:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7EA45A
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZhKAImJnigp1/EQTMtuNh4AliQfHdZ1j7fmf6bFMB/Y=; b=Y6Uo7kSgcCP+7uQIedLBhFG0ar
        rHOOIxQB+USzA7GZ8yKXeHl1VAjwTPx9jit3gRFGSCRHcIg6WNHf7vMhZiDqOibeXq1ledDpDC2ae
        HI8N3pLg3OVqwb/O5g+m0GWXhJN+w6LF+FWcnDZoupF9EXJHK1v7RZmnVsR9sK/JLC6I=;
Received: from p200300daa71a4800391046fbc91acf5a.dip0.t-ipconnect.de ([2003:da:a71a:4800:3910:46fb:c91a:cf5a] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o4ojm-0002r8-EC
        for linux-wireless@vger.kernel.org; Fri, 24 Jun 2022 21:13:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt7615: add sta_rec with EXTRA_INFO_NEW for the first time only
Date:   Fri, 24 Jun 2022 21:12:57 +0200
Message-Id: <20220624191300.52766-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set EXTRA_INFO_NEW for the first time only to prevent adding the same
starec entry, otherwise the entry might be removed in fw.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 9 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 194e9ccd4a73..989b2a41b670 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -844,6 +844,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = phy->dev;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct mt7615_sta *msta;
+	bool new_entry = true;
 	int cmd, err;
 
 	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
@@ -853,7 +854,13 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (IS_ERR(sskb))
 		return PTR_ERR(sskb);
 
-	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, true);
+	if (!sta) {
+		if (mvif->sta_added)
+			new_entry = false;
+		else
+			mvif->sta_added = true;
+	}
+	mt76_connac_mcu_sta_basic_tlv(sskb, vif, sta, enable, new_entry);
 	if (enable && sta)
 		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
 					MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 653181905d09..8499cdc4bb0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -141,6 +141,7 @@ struct mt7615_sta {
 struct mt7615_vif {
 	struct mt76_vif mt76; /* must be first */
 	struct mt7615_sta sta;
+	bool sta_added;
 };
 
 struct mib_stats {
-- 
2.36.1

