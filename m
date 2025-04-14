Return-Path: <linux-wireless+bounces-21509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF5A88472
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC077560DF7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170827A12A;
	Mon, 14 Apr 2025 13:38:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0827A12F
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637906; cv=none; b=uB1Co/XDDnaPcrC+z2GFunNL/ZxlqaBRzn55jVUOmhsEY0BPY0iPfm8+JWbtytUlfLujQylJkrSQHfl/FRKFstXEGbgZYMFMss3Oq8mvlPv+suR9dF5JnsHf1Fx+bXUf7JptRL/8y/ikqTwV7jqfvW6uvuiXV5c2/gPX8FkUpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637906; c=relaxed/simple;
	bh=FlfmmqXT6lEgVrp3NomEHgxVCTZgkfZvEgJYsv9pMew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHLHpP4c1jMfhA2XSHUKoSF7U3kkV/JsTHaOd2o2+d0tbKC4yNtMznSuRcCmbSD8HobIZkvFthyJIuDULZ34ecZpuVFQ+ql1mdJ+KImaf4Ql00YZOyXXeXGRFhR8n/J3cFbcLHUUe1pJqzVUMXh+lf8+07vMT/EUXhW9R0Giv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowAA3dQ3DD_1nuTHzCA--.4875S2;
	Mon, 14 Apr 2025 21:38:13 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] mac80211: null pointer dereference similar to CVE-2022-42722
Date: Mon, 14 Apr 2025 21:37:58 +0800
Message-ID: <20250414133758.961-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3dQ3DD_1nuTHzCA--.4875S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW8Cry5KF1fWFy3uryUJrb_yoW5uryUpF
	15Aa98tF4UXF43AFn5GrW8ZFWUAr4UZw1fuFykGFWa93WvvFyFyr1UCFWUXrWFyFZ3J343
	Z3WkAF1Yv3ZYkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAgMEmf82uq9DgAAsC

I found null pointer dereference similar to 
commit b2d03cabe2b2 ("wifi: mac80211: fix crash in beacon protection for P2P-device")
in mac80211.
ieee80211_rx_h_check(), ieee80211_drop_unencrypted_mgmt(),
ieee80211_rx_h_data() and cfg80211_michael_mic_failure(), like 
ieee80211_rx_h_decrypt(), use the netdev pointer, which isn't present 
for P2P-Device. 
Just like CVE-2022-42722, I add a check for the netdev pointer
in these functions.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 net/mac80211/rx.c  | 16 +++++++++-------
 net/mac80211/wpa.c |  3 ++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..e5928d2c61dc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1520,7 +1520,7 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 				return RX_CONTINUE;
 		}
 
-		if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
+		if (rx->sdata->vif.type == NL80211_IFTYPE_AP && rx->sdata->dev &&
 		    cfg80211_rx_spurious_frame(rx->sdata->dev,
 					       hdr->addr2,
 					       GFP_ATOMIC))
@@ -2469,8 +2469,8 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 				 */
 				if (!rx->key)
 					return RX_CONTINUE;
-
-				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
+				if (rx->sdata->dev)
+					cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     rx->skb->data,
 							     rx->skb->len);
 			}
@@ -2479,15 +2479,16 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 		/* BIP does not use Protected field, so need to check MMIE */
 		if (unlikely(ieee80211_is_multicast_robust_mgmt_frame(rx->skb) &&
 			     ieee80211_get_mmie_keyidx(rx->skb) < 0)) {
-			if (ieee80211_is_deauth(fc) ||
-			    ieee80211_is_disassoc(fc))
+			if ((ieee80211_is_deauth(fc) ||
+			     ieee80211_is_disassoc(fc)) && rx->sdata->dev)
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     rx->skb->data,
 							     rx->skb->len);
 			return RX_DROP_U_UNPROT_MCAST_MGMT;
 		}
 		if (unlikely(ieee80211_is_beacon(fc) && rx->key &&
-			     ieee80211_get_mmie_keyidx(rx->skb) < 0)) {
+				 ieee80211_get_mmie_keyidx(rx->skb) < 0) &&
+				 rx->sdata->dev) {
 			cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 						     rx->skb->data,
 						     rx->skb->len);
@@ -3185,7 +3186,8 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 	if (ieee80211_has_a4(hdr->frame_control) &&
 	    sdata->vif.type == NL80211_IFTYPE_AP) {
 		if (rx->sta &&
-		    !test_and_set_sta_flag(rx->sta, WLAN_STA_4ADDR_EVENT))
+		    !test_and_set_sta_flag(rx->sta, WLAN_STA_4ADDR_EVENT) &&
+			rx->sdata->dev)
 			cfg80211_rx_unexpected_4addr_frame(
 				rx->sdata->dev, rx->sta->sta.addr, GFP_ATOMIC);
 		return RX_DROP;
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 40d5d9e48479..54754d1da9dd 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -182,7 +182,8 @@ ieee80211_rx_h_michael_mic_verify(struct ieee80211_rx_data *rx)
 	 * a driver that supports HW encryption. Send up the key idx only if
 	 * the key is set.
 	 */
-	cfg80211_michael_mic_failure(rx->sdata->dev, hdr->addr2,
+	if (rx->sdata->dev)
+		cfg80211_michael_mic_failure(rx->sdata->dev, hdr->addr2,
 				     is_multicast_ether_addr(hdr->addr1) ?
 				     NL80211_KEYTYPE_GROUP :
 				     NL80211_KEYTYPE_PAIRWISE,
-- 
2.34.1


