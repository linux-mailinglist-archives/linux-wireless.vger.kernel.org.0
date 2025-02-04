Return-Path: <linux-wireless+bounces-18413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD4A27008
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 12:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90FD188515F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12020B817;
	Tue,  4 Feb 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="tdNO574d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0920B1E1
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667658; cv=none; b=JzTEA4jqyQ1UkVT4Vp4IauWfVc//A+jSPqIdZoQrIvtKtTzXvVuFs67NI+xEk4DCk+upPti6h/vSc5avnMuJN69NwkVDhzIMMKTqN1T1PnVl8fjxPDwZ+CIkU24X64pWERwWBOeBc3RISxnDDG9Ji2NCXRy+0zly7ql33t4PLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667658; c=relaxed/simple;
	bh=6TWOOkXaHjl4ToB25GIeTq9vMct75DouYDLwrM9H/v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oc6eYKf/TMs7gK4m4Hu+ukAJUN4G09MHXnBvrr/9ItzKMH8oho60swL1eJenL+ZfwX6lDulEnRmo3DYSbuzlMu50kPF7WvYn95NE3bOaea22HePUYbO7WzKfx5C4TFknmL0XkeS3jDMogdozH8fZba4QEtaERTAFXnCxZMBi1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=tdNO574d; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738667647;
	bh=6TWOOkXaHjl4ToB25GIeTq9vMct75DouYDLwrM9H/v0=;
	h=From:To:Cc:Subject:Date;
	b=tdNO574d3rre7Dp+h7Bnwgl3V4gR0ktd1OHf+zUmDfmHS14TjSGwjZgbXP0/US4ru
	 qJY/OC1Pgc31D21aiQf8FUSERN+P2KRlQQ+nu+x9WqIR9idg4kDyhfewOFKNP1aU0w
	 Za4TRRCmZ+aXrvewJsb1RpK6oEW6FnXmfKR0jLns=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 1/2] wifi: nl80211/cfg80211: Stop supporting cooked monitor
Date: Tue,  4 Feb 2025 12:13:51 +0100
Message-ID: <20250204111352.7004-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unconditionally start to refuse creating cooked monitor interfaces to
phase them out.

There is no feature flag for drivers to opt-in for cooked monitor and
all known users are using/preferring the modern API since the hostapd
release 1.0 in May 2012.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
That's kind of brutal... But still seems to be the best way.

While we keep NL80211_MNTR_FLAG_COOK_FRAMES around to not break software
like hostapd from compiling, nl80211 will refuse anyone from using it.
Which includes drivers which still may be fine with this feature.

But adding a feature flag for that outdated feature, assign it to all
drivers without knowing if they really support that any longer seems to
be a no-go. And adding an opt-out feature for something we plan to
remove also feels off.

That way we may be able to remove NL80211_MNTR_FLAG_COOK_FRAMES in some
years...

If you think that's too hard, there is another way:
I first tried to just refuse setting the flag in mac80211, but that
triggered a warning in nl80211 when rdev_add_virtual_intf() got the
error after green-lightening the flags in nl80211_parse_mon_options().

So we could add some code in nl80211 suppressing the warning when
MONITOR_FLAG_COOK_FRAMES is set. That would open up drivers to refuse
cooperation when someone tries to use the flag.

Alexander

---
 include/net/cfg80211.h       | 2 +-
 include/uapi/linux/nl80211.h | 4 ++--
 net/wireless/nl80211.c       | 4 ++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..a72e7eb7027f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2265,7 +2265,7 @@ static inline int cfg80211_get_station(struct net_device *dev,
  * @MONITOR_FLAG_PLCPFAIL: pass frames with bad PLCP
  * @MONITOR_FLAG_CONTROL: pass control frames
  * @MONITOR_FLAG_OTHER_BSS: disable BSSID filtering
- * @MONITOR_FLAG_COOK_FRAMES: report frames after processing
+ * @MONITOR_FLAG_COOK_FRAMES: deprecated, will unconditionally be refused
  * @MONITOR_FLAG_ACTIVE: active monitor, ACKs frames on its MAC address
  * @MONITOR_FLAG_SKIP_TX: do not pass locally transmitted frames
  */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f6c1b181c886..9d8ecf20ef0d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4727,8 +4727,8 @@ enum nl80211_survey_info {
  * @NL80211_MNTR_FLAG_PLCPFAIL: pass frames with bad PLCP
  * @NL80211_MNTR_FLAG_CONTROL: pass control frames
  * @NL80211_MNTR_FLAG_OTHER_BSS: disable BSSID filtering
- * @NL80211_MNTR_FLAG_COOK_FRAMES: report frames after processing.
- *	overrides all other flags.
+ * @NL80211_MNTR_FLAG_COOK_FRAMES: deprecated
+ *	will unconditionally be refused
  * @NL80211_MNTR_FLAG_ACTIVE: use the configured MAC address
  *	and ACK incoming unicast packets.
  * @NL80211_MNTR_FLAG_SKIP_TX: do not pass local tx packets
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d3da0f6833..8bd09110d393 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4245,6 +4245,10 @@ static int nl80211_parse_mon_options(struct cfg80211_registered_device *rdev,
 		change = true;
 	}
 
+	/* MONITOR_FLAG_COOK_FRAMES is deprecated, refuse cooperation */
+	if (params->flags & MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	if (params->flags & MONITOR_FLAG_ACTIVE &&
 	    !(rdev->wiphy.features & NL80211_FEATURE_ACTIVE_MONITOR))
 		return -EOPNOTSUPP;
-- 
2.48.1


