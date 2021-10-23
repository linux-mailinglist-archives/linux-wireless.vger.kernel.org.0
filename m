Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82864438294
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJWJNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhJWJNw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A45F61073;
        Sat, 23 Oct 2021 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980293;
        bh=2L8s2H3bU6sFrOhiOtFbYFeWrB/EluG4V/kioF6sqRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9QnRrpiMHamAyiFa6pcZpx6jlqOG6geIzhh5I2Lwspv2dLuWphWrermPujGzQwqH
         /Vwhpb3mwv5dylWSkBPSzXX5Ae9qBgwnzyJunELph9uha8Wz+bv8bxWNUArbc2na78
         mHNt3wRwPJ1eVR74uItT7Il2eFz3vPFc0mt+e0PJpaRL1ETCuKl+8IJ7trphK7caRA
         GDhtcF4tledB2LGIdlI889NWlO/1PO020RZg5iR++LSeVbTP/Vy/vNs3rLJGpzTmgs
         +Hex8+PxHOGqxJfgGSUf8hYJ/gp3uuDkY7QaPyUdOl1hnlLO+st7n/TPkxFmbbTndp
         PrsITBBEERC+Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 6/6] cfg80211: introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag
Date:   Sat, 23 Oct 2021 11:10:55 +0200
Message-Id: <241849ccaf2c228873c6f8495bf87b19159ba458.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_EXT_FEATURE_RADAR_OFFCHAN feature flag in order to
notify userland the underlay hw supports offchannel radar/CAC detection.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/mlme.c          | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 87ece3e68b8b..3e734826792f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6060,6 +6060,9 @@ enum nl80211_feature_flags {
  *	frames. Userspace has to share FILS AAD details to the driver by using
  *	@NL80211_CMD_SET_FILS_AAD.
  *
+ * @NL80211_EXT_FEATURE_RADAR_OFFCHAN: Device supports offchannel radar/CAC
+ *	detection.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6126,6 +6129,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
+	NL80211_EXT_FEATURE_RADAR_OFFCHAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 532df85d1c26..247ee0a01e8b 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1040,6 +1040,10 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	unsigned int cac_time_ms;
 	int err = -EBUSY;
 
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_RADAR_OFFCHAN))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&rdev->offchan_mutex);
 	if (rdev->offchan_radar_wdev)
 		goto out;
-- 
2.31.1

