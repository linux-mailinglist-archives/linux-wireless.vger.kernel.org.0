Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CD02AF7FD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKKSeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKKSeD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:34:03 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74258C0613D4
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ea5uMcA7h99r08JwcVRIEgyCxGX1Y4UXOILPxpEy3uk=; b=jXKO3MN4VXEzbWnbCKhsgaNiir
        swnYHN70jOgGSyQr0yn6HORuakjz0bBzoZQ9b+q4SNTTCc1tlaLg1vkxk4q0digDirmYqFsHrfsco
        pX/viXgjaJh9xx0qGS0yJwkqLPSqJ5WuKrRua1IFyt7yumejLMb2RemR2EHS5EiuO1zc=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kcuwS-00034H-PD; Wed, 11 Nov 2020 19:34:00 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.10 1/3] mac80211: fix memory leak on filtered powersave frames
Date:   Wed, 11 Nov 2020 19:33:57 +0100
Message-Id: <20201111183359.43528-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After the status rework, ieee80211_tx_status_ext is leaking un-acknowledged
packets for stations in powersave mode.
To fix this, move the code handling those packets from __ieee80211_tx_status
into ieee80211_tx_status_ext

Reported-by: Tobias Waldvogel <tobias.waldvogel@gmail.com>
Fixes: 3318111cf63d ("mac80211: reduce duplication in tx status functions")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/status.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 6feb45135020..3485610755ef 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -49,7 +49,8 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	int ac;
 
 	if (info->flags & (IEEE80211_TX_CTL_NO_PS_BUFFER |
-			   IEEE80211_TX_CTL_AMPDU)) {
+			   IEEE80211_TX_CTL_AMPDU |
+			   IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		ieee80211_free_txskb(&local->hw, skb);
 		return;
 	}
@@ -915,15 +916,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			ieee80211_mpsp_trigger_process(
 				ieee80211_get_qos_ctl(hdr), sta, true, acked);
 
-		if (!acked && test_sta_flag(sta, WLAN_STA_PS_STA)) {
-			/*
-			 * The STA is in power save mode, so assume
-			 * that this TX packet failed because of that.
-			 */
-			ieee80211_handle_filtered_frame(local, sta, skb);
-			return;
-		}
-
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
@@ -1150,6 +1142,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							    -info->status.ack_signal);
 				}
 			} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
+				/*
+				 * The STA is in power save mode, so assume
+				 * that this TX packet failed because of that.
+				 */
+				if (skb)
+					ieee80211_handle_filtered_frame(local, sta, skb);
 				return;
 			} else if (noack_success) {
 				/* nothing to do here, do not account as lost */
-- 
2.28.0

