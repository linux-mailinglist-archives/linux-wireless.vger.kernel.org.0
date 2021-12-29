Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D008D4811FD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Dec 2021 12:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhL2LZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhL2LZ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 06:25:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35141C06173F
        for <linux-wireless@vger.kernel.org>; Wed, 29 Dec 2021 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2QUT/dQPzFoDSJ6Bwoeb+pXmd38dxdahXoINO1+nhNc=; b=N3oo3upCUxEinQGW2FsuHEaZhc
        rtCZwxYW+bt0ydW6R0Kyf9BxgTfoetZ2HTmwl7iAQQzrgjal0JPfLt5SWw7URU30XP1qoWiOxhbVc
        WAxz1EEFnGORRM1Qn5Ij893ajGDA9K+44VPRKnQiYmhd1HFVMMo8Gdn5xQFJe9zEEaMM=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n2X5e-00065a-CP
        for linux-wireless@vger.kernel.org; Wed, 29 Dec 2021 12:25:54 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7915: update bss_info with cipher after setting the group key
Date:   Wed, 29 Dec 2021 12:25:51 +0100
Message-Id: <20211229112551.46142-3-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index aed0a5303aa8..b45b75f98c4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -367,6 +367,7 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_sta *msta = sta ? (struct mt7915_sta *)sta->drv_priv :
 				  &mvif->sta;
@@ -406,6 +407,11 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mutex_lock(&dev->mt76.mutex);
 
+	if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
+		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mt7915_mcu_add_bss_info(phy, vif, true);
+	}
+
 	if (cmd == SET_KEY)
 		*wcid_keyidx = idx;
 	else if (idx == *wcid_keyidx)
-- 
2.34.1

