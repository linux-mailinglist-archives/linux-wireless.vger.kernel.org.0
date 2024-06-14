Return-Path: <linux-wireless+bounces-9000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0C90852A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8734528A3A4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2913D512;
	Fri, 14 Jun 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f3FrYPGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11E14883F
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350562; cv=none; b=szzlUEFINEEAdmcXJ/SNweqPUoGbCMiWJlwzjAstWhNpRw0X6OJxec2Mholc+DyLQ4ubXECXdL5yMlZABCgemCAtNRLoIR9XO5NWL7KYujGtwsus+X1Pw9hUHrUd9xHEQtNB89f7S+bnowvzgD/M+yv+ngDpWeSSum8Go6IHWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350562; c=relaxed/simple;
	bh=rltOypF0NwStXAAJnvz+erhbKr/KAHSBvDaMxgtYhjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHU9RIWmLqXiTLU2rpdAPb5BsCzAbBdEgydNAGffurd+/EXutP3x/G6tjOBMkxARd3JFc2zqaqolJl/wEh11tWdI+HA7WT13Y8CxIdCLZvKJffO+2MJbNSweDLWnd/Kio88ipKqUcTQHwk4x65goR027w+EGZVOxj6AWR+Lv4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f3FrYPGI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tWvKyF69lNPDCf5JrsdcFqIH6IcAtBMPE48fAJbvMO0=; t=1718350558; x=1719560158; 
	b=f3FrYPGIMnZMVHKcP+jxnUqPkOU9VYIKDSR4juGelPHC7YpVdhQQmVd0dTFPZr+9tQ9JASYy31q
	Fw+PLHwdz/WS25ts+u5Sj4PwrZYF3p67N61H7k3C1XyMW67UWIcsQyXV19b/ylv6DswPCDRYCWH9h
	t9URF2K8MfPtCG0iWiV5sa8s3X/5jkWthDJr12F52uz57uQIxLTPc6WKRnd/DHRyX8vnVzPzdjmIa
	MZ6atDcgej2eJFFZETvHTkZnf+bhDiCt7vXXnRwZFlNxRVP3he3aPdEwmN9XUJ3oxFky1SwbAX6fE
	C1YpgmvBmLqfUW5Ky4bXrTqmoXNi8tnCcl9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sI1TS-0000000DWbE-0Z1X;
	Fri, 14 Jun 2024 09:35:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: cfg80211: Always call tracing
Date: Fri, 14 Jun 2024 09:35:41 +0200
Message-ID: <20240614093541.018cb816e176.I28f68740a6b42144346f5c175c7874b0a669a364@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Call the tracing function even if the cfg80211 callbacks
are not set. This would allow better understanding of
user space actions.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/rdev-ops.h | 56 ++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 755af47b88b9..8f15658002ee 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -578,13 +578,11 @@ static inline int rdev_leave_ibss(struct cfg80211_registered_device *rdev,
 static inline int
 rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
 {
-	int ret;
-
-	if (!rdev->ops->set_wiphy_params)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
-	ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
+	if (rdev->ops->set_wiphy_params)
+		ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -1425,13 +1423,11 @@ rdev_set_radar_background(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_chan_def *chandef)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
-	int ret;
-
-	if (!rdev->ops->set_radar_background)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_radar_background(wiphy, chandef);
-	ret = rdev->ops->set_radar_background(wiphy, chandef);
+	if (rdev->ops->set_radar_background)
+		ret = rdev->ops->set_radar_background(wiphy, chandef);
 	trace_rdev_return_int(wiphy, ret);
 
 	return ret;
@@ -1468,13 +1464,11 @@ rdev_add_link_station(struct cfg80211_registered_device *rdev,
 		      struct net_device *dev,
 		      struct link_station_parameters *params)
 {
-	int ret;
-
-	if (!rdev->ops->add_link_station)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_add_link_station(&rdev->wiphy, dev, params);
-	ret = rdev->ops->add_link_station(&rdev->wiphy, dev, params);
+	if (rdev->ops->add_link_station)
+		ret = rdev->ops->add_link_station(&rdev->wiphy, dev, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -1484,13 +1478,11 @@ rdev_mod_link_station(struct cfg80211_registered_device *rdev,
 		      struct net_device *dev,
 		      struct link_station_parameters *params)
 {
-	int ret;
-
-	if (!rdev->ops->mod_link_station)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_mod_link_station(&rdev->wiphy, dev, params);
-	ret = rdev->ops->mod_link_station(&rdev->wiphy, dev, params);
+	if (rdev->ops->mod_link_station)
+		ret = rdev->ops->mod_link_station(&rdev->wiphy, dev, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -1500,13 +1492,11 @@ rdev_del_link_station(struct cfg80211_registered_device *rdev,
 		      struct net_device *dev,
 		      struct link_station_del_parameters *params)
 {
-	int ret;
-
-	if (!rdev->ops->del_link_station)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_del_link_station(&rdev->wiphy, dev, params);
-	ret = rdev->ops->del_link_station(&rdev->wiphy, dev, params);
+	if (rdev->ops->del_link_station)
+		ret = rdev->ops->del_link_station(&rdev->wiphy, dev, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -1517,13 +1507,11 @@ rdev_set_hw_timestamp(struct cfg80211_registered_device *rdev,
 		      struct cfg80211_set_hw_timestamp *hwts)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
-	int ret;
-
-	if (!rdev->ops->set_hw_timestamp)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_hw_timestamp(wiphy, dev, hwts);
-	ret = rdev->ops->set_hw_timestamp(wiphy, dev, hwts);
+	if (rdev->ops->set_hw_timestamp)
+		ret = rdev->ops->set_hw_timestamp(wiphy, dev, hwts);
 	trace_rdev_return_int(wiphy, ret);
 
 	return ret;
@@ -1535,13 +1523,11 @@ rdev_set_ttlm(struct cfg80211_registered_device *rdev,
 	      struct cfg80211_ttlm_params *params)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
-	int ret;
-
-	if (!rdev->ops->set_ttlm)
-		return -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_ttlm(wiphy, dev, params);
-	ret = rdev->ops->set_ttlm(wiphy, dev, params);
+	if (rdev->ops->set_ttlm)
+		ret = rdev->ops->set_ttlm(wiphy, dev, params);
 	trace_rdev_return_int(wiphy, ret);
 
 	return ret;
-- 
2.45.2


