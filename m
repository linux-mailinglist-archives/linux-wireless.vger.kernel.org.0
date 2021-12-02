Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA07046633F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357767AbhLBMNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 07:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbhLBMNA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 07:13:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52CC061759
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 04:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=MOi83VO591d40TaQfgyQbC53U7Jcnai9UsJoRedKrQw=; t=1638446959; x=1639656559; 
        b=HhEl01FqE0Ny7I9BMYvxxCRxyI92TR34+E04JGxlH5Inmd31Y4qKZOB3Ue94lCrlxmaymk3uzUK
        V0yw924Xq3GLFQ2lhWndkn1pNRgxrUhvjDwNk6LYCCOO7cotKCkeS53QJhR42hIH2P0q3IM64gXP7
        GaM0t/Rj0vxnDhRGGk06gxn+snEdywRkfNiVi5TMot9YMTM2l+rT8d3VYpEiQYaZmASr5Lh8Qx687
        tNFO1GfYe9vglqwhQDDHbRNn6cqHLOVlyRhIt6YZSIm399Bhmn0uZJJRTVdtqRtDt3qiNI+QB/nUY
        uipI8hD0Cr8wH0zP+7kiIcXBqDXBTqT09VEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1msktp-005qMi-34;
        Thu, 02 Dec 2021 13:09:17 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: refactor cfg80211_get_ies_channel_number()
Date:   Thu,  2 Dec 2021 13:09:14 +0100
Message-Id: <20211202130913.a0adf67a9319.I6db0340a34fff18d78e9cd512f4abf855da4e43a@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that this is no longer part of the bigger function,
we can get rid of the channel_num variable. Also change
the function to use the struct element helpers, instead
of open-coding the element handling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 22e92be61938..49a1a8e078dd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1797,31 +1797,29 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 				    enum nl80211_band band)
 {
-	const u8 *tmp;
-	int channel_number = -1;
+	const struct element *tmp;
 
 	if (band == NL80211_BAND_S1GHZ) {
-		tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
-		if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
-			struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
+		tmp = cfg80211_find_elem(WLAN_EID_S1G_OPERATION, ie, ielen);
+		if (tmp && tmp->datalen >= sizeof(struct ieee80211_s1g_oper_ie)) {
+			struct ieee80211_s1g_oper_ie *s1gop = (void *)tmp->data;
 
-			channel_number = s1gop->primary_ch;
+			return s1gop->primary_ch;
 		}
 	} else {
-		tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
-		if (tmp && tmp[1] == 1) {
-			channel_number = tmp[2];
-		} else {
-			tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
-			if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
-				struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
+		tmp = cfg80211_find_elem(WLAN_EID_DS_PARAMS, ie, ielen);
+		if (tmp && tmp->datalen == 1)
+			return tmp->data[0];
 
-				channel_number = htop->primary_chan;
-			}
+		tmp = cfg80211_find_elem(WLAN_EID_HT_OPERATION, ie, ielen);
+		if (tmp && tmp->datalen >= sizeof(struct ieee80211_ht_operation)) {
+			struct ieee80211_ht_operation *htop = (void *)tmp->data;
+
+			return htop->primary_chan;
 		}
 	}
 
-	return channel_number;
+	return -1;
 }
 EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
 
-- 
2.33.1

