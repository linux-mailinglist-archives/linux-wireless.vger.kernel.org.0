Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7F417C24
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbhIXUHe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 16:07:34 -0400
Received: from ns2.wdyn.eu ([5.252.227.236]:39962 "EHLO ns2.wdyn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348379AbhIXUHe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 16:07:34 -0400
X-Greylist: delayed 79285 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 16:07:33 EDT
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1632513956;
        bh=OY1ZUAoBk877xYw+eU3j/JOQF+V70HbYYX2M4BL54/I=;
        h=From:To:Cc:Subject:Date;
        b=PDmDPAh+tMsUGGazmmAEVWWlSKo10e8ZWlCK9rnI5WxeFzpOu2/pTwIPAR2m6V7n9
         0r9WKypg/LR93vvBZFLdfRV5oBkE9NLCrogpAUfkf9zEopwPBio4WNDSbULk6Al0GY
         GBpNN+JWq5+XatuHbzzoOKo3pxT8NNBYnNIWcBz8=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] mac80211: Fix Ptk0 rekey documentation
Date:   Fri, 24 Sep 2021 22:05:14 +0200
Message-Id: <20210924200514.7936-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

@IEEE80211_KEY_FLAG_GENERATE_IV setting is irrelevant for RX.
Move the requirement to the correct section in the PTK0 rekey
documentation.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 include/net/mac80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af0fc13cea34..618d1f427cb2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2818,13 +2818,13 @@ void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
  * Mac80211 drivers should set the @NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 flag
  * when they are able to replace in-use PTK keys according to the following
  * requirements:
- * 1) They do not hand over frames decrypted with the old key to
-      mac80211 once the call to set_key() with command %DISABLE_KEY has been
-      completed when also setting @IEEE80211_KEY_FLAG_GENERATE_IV for any key,
+ * 1) They do not hand over frames decrypted with the old key to mac80211
+      once the call to set_key() with command %DISABLE_KEY has been completed,
    2) either drop or continue to use the old key for any outgoing frames queued
       at the time of the key deletion (including re-transmits),
    3) never send out a frame queued prior to the set_key() %SET_KEY command
-      encrypted with the new key and
+      encrypted with the new key when also needing
+      @IEEE80211_KEY_FLAG_GENERATE_IV and
    4) never send out a frame unencrypted when it should be encrypted.
    Mac80211 will not queue any new frames for a deleted key to the driver.
  */
-- 
2.33.0

