Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4A4811FC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Dec 2021 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhL2LZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbhL2LZ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 06:25:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9DC06173E
        for <linux-wireless@vger.kernel.org>; Wed, 29 Dec 2021 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y8S1xJrDOPbP7Slop5C5IfwObjlA/C1wGsnDp1ivhyg=; b=II3ls/2tYj69E5jGlQZt5viQA2
        YBhSYS0juXmtoc0GuB/awJhL8xK3XhKoTpoGG92djgqVXdLmqTtQ4kPWhEiQEXnsW10j0WM7gdkH9
        2QcBmsSBi9quttfkYnWjbnEbte49y65oiUgGnv1SHjAka+mwQq4NAMe2X7H9j9YrZmoU=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n2X5e-00065a-6Y
        for linux-wireless@vger.kernel.org; Wed, 29 Dec 2021 12:25:54 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7615: update bss_info with cipher after setting the group key
Date:   Wed, 29 Dec 2021 12:25:50 +0100
Message-Id: <20211229112551.46142-2-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229112551.46142-1-nbd@nbd.name>
References: <20211229112551.46142-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some cases, the WA firmware needs to know if encryption is used, in order
to set the protection bit of packets

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 82d625a16a62..9f7ac78f1222 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -365,6 +365,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
 				  &mvif->sta;
@@ -403,6 +404,11 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt7615_mutex_acquire(dev);
 
+	if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
+		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mt7615_mcu_add_bss_info(phy, vif, NULL, true);
+	}
+
 	if (cmd == SET_KEY)
 		*wcid_keyidx = idx;
 	else if (idx == *wcid_keyidx)
-- 
2.34.1

