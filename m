Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78CA388DDF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhESMV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 08:21:59 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54411 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346469AbhESMV6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 08:21:58 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ljLBm-000386-JW; Wed, 19 May 2021 14:20:38 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ljLBl-000PK0-E8; Wed, 19 May 2021 14:20:38 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Wed, 19 May 2021 14:20:37 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH v2 1/3] mac80211: add ieee80211_is_tx_data helper function
Date:   Wed, 19 May 2021 14:20:17 +0200
Message-Id: <20210519122019.92359-2-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519122019.92359-1-borgers@mi.fu-berlin.de>
References: <20210519122019.92359-1-borgers@mi.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a helper function that checks if a frame is a data frame. Frames
with hardware encapsulation enabled are data frames.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 include/net/mac80211.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..a2a88c545561 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6747,4 +6747,22 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_is_tx_data - check if frame is a data frame
+ *
+ * The function is used to check if a frame is a data frame. Frames with
+ * hardware encapsulation enabled are data frames.
+ *
+ * @skb: the frame to be transmitted.
+ */
+static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hdr *hdr = (void *) skb->data;
+
+	return (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP ||
+			ieee80211_is_data(hdr->frame_control));
+}
+
 #endif /* MAC80211_H */
-- 
2.31.1

