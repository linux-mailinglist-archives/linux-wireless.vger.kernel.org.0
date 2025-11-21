Return-Path: <linux-wireless+bounces-29244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC28C7AE95
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77FC94EF7AF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194693321DE;
	Fri, 21 Nov 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RE64pywa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAA2F12A3
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743229; cv=none; b=m6P2FVCwOZQxNhRjD5uzYxImi8sV+yNRmWFTxHeNNyeWUUNkkXVM1Cv5qt+Iolt+4Oyx7RV2BmfbQ/fWxlJljM60rfCDgBD30XiXkejmmqb7sRG3Y5g0tmEg6129/tUKnH85DQNWWe64EYtQizsaHJeVxivAPABWxoi+HhkwUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743229; c=relaxed/simple;
	bh=dbBFZiWWYGF+enuyPP9ObNTqG6rmaORe/bHIzwBPfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAI9BmFBiG2Y9e2ZaZu867LL1fDS2ku/qPaL70otKJBKqWS1rh4mWY5k+VG/iw1wwGGYg5cMz6lAIatxUxZ8ih0J5ZLI9eM2B+psGv4uMadejJkCjCmo7oAoU77u1TyqfbingtdP2UoG1n5UbOVfcPVyrLt5S/x+vynAeJPRqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RE64pywa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Cct0dgHEJzWMmUcdj6m6mdHq+lo8o3ZCz4yr8Jr87N8=;
	t=1763743227; x=1764952827; b=RE64pywahb3MlzYX1lUDKAvC0ovbBYoQwx/DQj6vqt0Dkeo
	E4uuDEF6yviXZ/T7K9N3jxuCaNLUb5Mbhj2c8p88DrKuKzXlEZRy7yTBYTZix308UFbeP3pW8AIUw
	fQabmRUzSC5Oyz5TZDREQCGoJKSgXQcRHsJtqQM4/C5bivCFIURcKz0hfyu9u5sjm3wgsyGTPqNxG
	aAjnlOw3bwqxN9m+2kNilIDtJogTgt7yEtt2fF5RIPKH/qaQbouinIum8SsV7cguFqwkTDseZ4ISq
	qSp9ne6QCSfCUG+ikHrovgL1xBdJ4y9+Ba83k4kTQgi6D9T9PA/njJsZd2M7DkbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vMUBM-0000000DAuH-2gbw;
	Fri, 21 Nov 2025 17:40:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: cfg80211: stop radar detection in cfg80211_leave()
Date: Fri, 21 Nov 2025 17:40:21 +0100
Message-ID: <20251121174021.290120e419e3.I2a5650c9062e29c988992dd8ce0d8eb570d23267@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121174021.922ef48ce007.I970c8514252ef8a864a7fbdab9591b71031dee03@changeid>
References: <20251121174021.922ef48ce007.I970c8514252ef8a864a7fbdab9591b71031dee03@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If an interface is set down or, per the previous patch, changes
type, radar detection for it should be cancelled. This is done
for AP mode in mac80211 (somewhat needlessly, since cfg80211 can
do it, but didn't until now), but wasn't handled for mesh, so if
radar detection was started and then the interface set down or
its type switched (the latter sometimes happning in the hwsim
test 'mesh_peer_connected_dfs'), radar detection would be around
with the interface unknown to the driver, later leading to some
warnings around chanctx usage.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c |  1 +
 net/wireless/core.h |  1 +
 net/wireless/mlme.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 7be25b9ae36e..9a420d627d3c 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1380,6 +1380,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 
 	cfg80211_pmsr_wdev_down(wdev);
 
+	cfg80211_stop_radar_detection(wdev);
 	cfg80211_stop_background_radar_detection(wdev);
 
 	switch (wdev->iftype) {
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 82f343663e8f..63dcf315dba7 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -489,6 +489,7 @@ cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rde
 					  struct wireless_dev *wdev,
 					  struct cfg80211_chan_def *chandef);
 
+void cfg80211_stop_radar_detection(struct wireless_dev *wdev);
 void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev);
 
 void cfg80211_background_cac_done_wk(struct work_struct *work);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..3fc175f9f868 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1295,6 +1295,25 @@ cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rde
 	return 0;
 }
 
+void cfg80211_stop_radar_detection(struct wireless_dev *wdev)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	int link_id;
+
+	for_each_valid_link(wdev, link_id) {
+		struct cfg80211_chan_def chandef;
+
+		if (!wdev->links[link_id].cac_started)
+			continue;
+
+		chandef = *wdev_chandef(wdev, link_id);
+		rdev_end_cac(rdev, wdev->netdev, link_id);
+		nl80211_radar_notify(rdev, &chandef, NL80211_RADAR_CAC_ABORTED,
+				     wdev->netdev, GFP_KERNEL);
+	}
+}
+
 void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 {
 	struct wiphy *wiphy = wdev->wiphy;
-- 
2.51.1


