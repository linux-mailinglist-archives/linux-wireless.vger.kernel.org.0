Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84815062A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 13:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBCM2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 07:28:21 -0500
Received: from nbd.name ([46.4.11.11]:58698 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBCM2U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 07:28:20 -0500
Received: from [95.163.165.154] (helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iyapu-0005o6-Ff; Mon, 03 Feb 2020 13:28:18 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>
Subject: [PATCH] mac80211: fix 11w when using encapsulation offloading
Date:   Mon,  3 Feb 2020 13:28:12 +0100
Message-Id: <20200203122812.18993-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 802.11 encapsulation returned early when setting up the keys in case
offloading was enabled. This causes ieee802.11w to not work anymore. Fix
this by moving the check for offloading into the switch/case construct and
allowing CCMP/GCMP keys. With this patch applied ieee80211w works again
when enabling offloading.

Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Reported-by: Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/key.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 9a3a6b95fa27..54934eff4ac1 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -210,10 +210,6 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 			  key->conf.keyidx,
 			  sta ? sta->sta.addr : bcast_addr, ret);
 
-	/* cannot do software crypto with encapsulation offload */
-	if (sdata->hw_80211_encap)
-		return -EINVAL;
-
  out_unsupported:
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -221,12 +217,20 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		/* We cannot do software crypto of data frames with
+		 * encapsulation offload enabled. However for 802.11w to
+		 * function properly we need cmac/gmac keys.
+		 */
+		if (sdata->hw_80211_encap)
+			return -EINVAL;
+		/* Fall through */
+
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
 		/* all of these we can do in software - if driver can */
 		if (ret == 1)
 			return 0;
-- 
2.20.1

