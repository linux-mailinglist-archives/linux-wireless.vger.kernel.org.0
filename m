Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A231B219
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Feb 2021 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBNSuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Feb 2021 13:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNSt7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Feb 2021 13:49:59 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02732C061574
        for <linux-wireless@vger.kernel.org>; Sun, 14 Feb 2021 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q+cg1oObXGpi/3y0MDcBEnirsfQ+3Z1hURC29KRqHag=; b=sztb+xsMylgaRKicwUUDDHoA6v
        ZUW5pD790dBYHqJset2nNYmnYrX3GfT5oINaCxFHE/Bt16x7LjoIvrxtEQBYKDQyXeJ0kzU0RnSAx
        OExlNwVAtybkzbfdFGUXqlCmbZE1qtrWw9X1YKq+yZeZdleHjVohXOiYYb9ki86sNLxU=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lBMSJ-00080x-Dx; Sun, 14 Feb 2021 19:49:15 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, hurricos@gmail.com
Subject: [PATCH] ath9k: fix transmitting to stations in dynamic SMPS mode
Date:   Sun, 14 Feb 2021 19:49:11 +0100
Message-Id: <20210214184911.96702-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When transmitting to a receiver in dynamic SMPS mode, all transmissions that
use multiple spatial streams need to be sent using CTS-to-self or RTS/CTS to
give the receiver's extra chains some time to wake up.
This fixes the tx rate getting stuck at <= MCS7 for some clients, especially
Intel ones, which make aggressive use of SMPS.

Cc: stable@vger.kernel.org
Reported-by: Martin Kennedy <hurricos@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ath/ath9k/ath9k.h | 3 ++-
 drivers/net/wireless/ath/ath9k/xmit.c  | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 13b4f5f50f8a..ef6f5ea06c1f 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -177,7 +177,8 @@ struct ath_frame_info {
 	s8 txq;
 	u8 keyix;
 	u8 rtscts_rate;
-	u8 retries : 7;
+	u8 retries : 6;
+	u8 dyn_smps : 1;
 	u8 baw_tracked : 1;
 	u8 tx_power;
 	enum ath9k_key_type keytype:2;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index e60d4737fc6e..5691bd6eb82c 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1271,6 +1271,11 @@ static void ath_buf_set_rate(struct ath_softc *sc, struct ath_buf *bf,
 				 is_40, is_sgi, is_sp);
 			if (rix < 8 && (tx_info->flags & IEEE80211_TX_CTL_STBC))
 				info->rates[i].RateFlags |= ATH9K_RATESERIES_STBC;
+			if (rix >= 8 && fi->dyn_smps) {
+				info->rates[i].RateFlags |=
+					ATH9K_RATESERIES_RTS_CTS;
+				info->flags |= ATH9K_TXDESC_CTSENA;
+			}
 
 			info->txpower[i] = ath_get_rate_txpower(sc, bf, rix,
 								is_40, false);
@@ -2114,6 +2119,7 @@ static void setup_frame_info(struct ieee80211_hw *hw,
 		fi->keyix = an->ps_key;
 	else
 		fi->keyix = ATH9K_TXKEYIX_INVALID;
+	fi->dyn_smps = sta && sta->smps_mode == IEEE80211_SMPS_DYNAMIC;
 	fi->keytype = keytype;
 	fi->framelen = framelen;
 	fi->tx_power = txpower;
-- 
2.28.0

