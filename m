Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326BD11E72D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfLMP6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from nbd.name ([46.4.11.11]:56226 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfLMP6O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKV-00073u-DD; Fri, 13 Dec 2019 16:58:11 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 5/7] mac80211: drop now unused bss_color element
Date:   Fri, 13 Dec 2019 16:58:00 +0100
Message-Id: <20191213155802.25491-5-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With all users of bss_color converted we can drop the old element. Driver
code should now use the new he_bss_color struct.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 2 --
 net/mac80211/mlme.c    | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 994686443553..9a67fd2cfe4b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -496,7 +496,6 @@ struct ieee80211_ftm_responder_params {
  * This structure keeps information about a BSS (and an association
  * to that BSS) that can change during the lifetime of the BSS.
  *
- * @bss_color: 6-bit value to mark inter-BSS frame, if BSS supports HE
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
  * @multi_sta_back_32bit: supports BA bitmap of 32-bits in Multi-STA BACK
  * @uora_exists: is the UORA element advertised by AP
@@ -610,7 +609,6 @@ struct ieee80211_ftm_responder_params {
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
-	u8 bss_color;
 	u8 htc_trig_based_pkt_ext;
 	bool multi_sta_back_32bit;
 	bool uora_exists;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 319d43f4082b..bc602d460b73 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3371,7 +3371,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (bss_conf->he_support) {
-		bss_conf->bss_color =
 		bss_conf->he_bss_color.color =
 			le32_get_bits(elems.he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
-- 
2.20.1

