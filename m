Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5054619ADC8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgDAO05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 10:26:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:33009 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732749AbgDAO05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 10:26:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585751216; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=a//GqbAgoCNTN/XuFIY5jVPqTTuX/SP4at5TU0Dm/f8=; b=ppUY2/FVTTiymE+4sottVIDw78GKSP7G+m1dd0daZABXmwE2YITtzGbTLGZnKUUWwKn3Vegg
 QvnZpnpc6ikKlN4fRKBqTjNRkGSx8z+gmhc8y+94Rq387zuMG2P74U6RVH8tEJGS3smfaat9
 dEpRS7ncFAVAVhYv2xui7jNq05U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e84a4af.7f3125df35a8-smtp-out-n03;
 Wed, 01 Apr 2020 14:26:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1920AC433D2; Wed,  1 Apr 2020 14:26:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EE72C433F2;
        Wed,  1 Apr 2020 14:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EE72C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/2] cfg80211: Unprotected Beacon frame RX indication
Date:   Wed,  1 Apr 2020 17:25:47 +0300
Message-Id: <20200401142548.6990-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend cfg80211_rx_unprot_mlme_mgmt() to cover indication of unprotected
Beacon frames in addition to the previously used Deauthentication and
Disassociation frames. The Beacon frame case is quite similar, but has
couple of exceptions: this is used both with fully unprotected and also
incorrectly protected frames and there is a rate limit on the events to
avoid unnecessary flooding netlink events in case something goes wrong.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       | 10 ++++++++--
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 13 +++++++++++--
 net/wireless/sme.c           |  2 ++
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c78bd4ff9e33..66da62d49876 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5111,6 +5111,8 @@ struct wireless_dev {
 	struct list_head pmsr_list;
 	spinlock_t pmsr_lock;
 	struct work_struct pmsr_free_wk;
+
+	unsigned long unprot_beacon_reported;
 };
 
 static inline u8 *wdev_address(struct wireless_dev *wdev)
@@ -6125,12 +6127,16 @@ void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len);
 /**
  * cfg80211_rx_unprot_mlme_mgmt - notification of unprotected mlme mgmt frame
  * @dev: network device
- * @buf: deauthentication frame (header + body)
+ * @buf: received management frame (header + body)
  * @len: length of the frame data
  *
  * This function is called whenever a received deauthentication or dissassoc
  * frame has been dropped in station mode because of MFP being used but the
- * frame was not protected. This function may sleep.
+ * frame was not protected. This is also used to notify reception of a Beacon
+ * frame that was dropped because it did not include a valid MME MIC while
+ * beacon protection was enabled (BIGTK configured in station mode).
+ *
+ * This function may sleep.
  */
 void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev,
 				  const u8 *buf, size_t len);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..afdd9802ccb8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1151,6 +1151,11 @@
  * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
  *	is passed using %NL80211_ATTR_TID_CONFIG attribute.
  *
+ * @NL80211_CMD_UNPROT_BEACON: Unprotected or incorrectly protected Beacon
+ *	frame. This event is used to indicate that a received Beacon frame was
+ *	dropped because it did not include a valid MME MIC while beacon
+ *	protection was enabled (BIGTK configured in station mode).
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1377,6 +1382,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_TID_CONFIG,
 
+	NL80211_CMD_UNPROT_BEACON,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ad87e9db9a91..b68bc628585d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15544,10 +15544,19 @@ void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
 	if (WARN_ON(len < 2))
 		return;
 
-	if (ieee80211_is_deauth(mgmt->frame_control))
+	if (ieee80211_is_deauth(mgmt->frame_control)) {
 		cmd = NL80211_CMD_UNPROT_DEAUTHENTICATE;
-	else
+	} else if (ieee80211_is_disassoc(mgmt->frame_control)) {
 		cmd = NL80211_CMD_UNPROT_DISASSOCIATE;
+	} else if (ieee80211_is_beacon(mgmt->frame_control)) {
+		if (wdev->unprot_beacon_reported &&
+		    elapsed_jiffies_msecs(wdev->unprot_beacon_reported) < 10000)
+			return;
+		cmd = NL80211_CMD_UNPROT_BEACON;
+		wdev->unprot_beacon_reported = jiffies;
+	} else {
+		return;
+	}
 
 	trace_cfg80211_rx_unprot_mlme_mgmt(dev, buf, len);
 	nl80211_send_mlme_event(rdev, dev, buf, len, cmd, GFP_ATOMIC, -1,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ac3e60aa1fc8..3554c0d951f4 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -694,6 +694,7 @@ void __cfg80211_connect_result(struct net_device *dev,
 		return;
 	}
 
+	wdev->unprot_beacon_reported = 0;
 	nl80211_send_connect_result(wiphy_to_rdev(wdev->wiphy), dev, cr,
 				    GFP_KERNEL);
 
@@ -921,6 +922,7 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 	cfg80211_hold_bss(bss_from_pub(info->bss));
 	wdev->current_bss = bss_from_pub(info->bss);
 
+	wdev->unprot_beacon_reported = 0;
 	nl80211_send_roamed(wiphy_to_rdev(wdev->wiphy),
 			    wdev->netdev, info, GFP_KERNEL);
 
-- 
2.20.1
