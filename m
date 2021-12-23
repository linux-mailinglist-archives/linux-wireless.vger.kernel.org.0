Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAF47E2E7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbhLWMIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348116AbhLWMIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F244E61E42
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5694CC36AE9;
        Thu, 23 Dec 2021 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261290;
        bh=Aifo72OlYZHtEgfGo1BABE7UUrWaSW+tFe/pZNPl9XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLeeMPWYdCH1lCKogCmB9sDdZ64jLgoI00YY1qWNQ5+bxBzRuBMHqhuDJmBwaYuMW
         73JeobQfyPaKl0HrEoAPsOB0+q6niYx2M9IkLdX56a/UZQBPRM5XtiS1Md0b/t3t16
         OGsx5n3KwsICQNjdirsphyKlEtfI7grPo7YXAaa3tfiQjwdvU8ITWU/KwEUW7FnlAU
         bm0EyLL06X5R9PSAJr50WNwNIXTguM7ASh6glnIPlDXEcBNicIqqRYEKo4NkwUgTin
         /fkA80ckniFZPXh6n2hpaSMD5a3Aqk5fZATEQJ8lA04fadHQY6afAHckFHzsNqwQGf
         pK/bC9Jzur3RA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 05/15] mt76: mt7915: rely on mt76_connac_mcu_sta_ba_tlv
Date:   Thu, 23 Dec 2021 13:07:33 +0100
Message-Id: <8c1d4431e0c483570375ac694fb36ec96045bf95.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_sta_ba_tlv routine in mt7915 and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4fb7bc81d7c9..7b94d78393dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -742,25 +742,6 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 }
 
 /** starec & wtbl **/
-static void
-mt7915_mcu_sta_ba_tlv(struct sk_buff *skb,
-		      struct ieee80211_ampdu_params *params,
-		      bool enable, bool tx)
-{
-	struct sta_rec_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
-
-	ba = (struct sta_rec_ba *)tlv;
-	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
-	ba->winsize = cpu_to_le16(params->buf_size);
-	ba->ssn = cpu_to_le16(params->ssn);
-	ba->ba_en = enable << params->tid;
-	ba->amsdu = params->amsdu;
-	ba->tid = params->tid;
-}
-
 static void
 mt7915_mcu_wtbl_ba_tlv(struct sk_buff *skb,
 		       struct ieee80211_ampdu_params *params,
@@ -831,7 +812,7 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7915_mcu_sta_ba_tlv(skb, params, enable, tx);
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-- 
2.33.1

