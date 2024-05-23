Return-Path: <linux-wireless+bounces-8002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A78CD008
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577A81C225F8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2367F140373;
	Thu, 23 May 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ImvE7JIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432E140E37
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458998; cv=none; b=JktVwuDC+jUR/EzRDGaPq7XyKQqew8Iwyq4Tx3+QrTGhESe7wF+gV5W00L4KiOogwcjpCJ/eRHzV6jDqXaTEITo8xunogLK/JLVsSlDUKa9Pf89jYq1Bn5hS2Ztx2p3cXkgDAEaj2ukhHIjvga4EI1z11sh+NgdX2Bj++VDZ97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458998; c=relaxed/simple;
	bh=M+eHxTIj/4FrGsitM4DSUIqMDwMySik9W9uQlhFBawU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb5IOuTieOagXGdWiPtqCGQ9DzL/I5TA/5WcFncLNHA/n/G4/7hptAQrIP6OTEytCOLImuFq+g4wRS1KmDdeLdjISNERhQqoh/3FZvcDyYDUBLN++KT2t401efXgGEkCMy8TAedrWR1SQOspkhkvUoTk0g/Je4fEvERHNz8OLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ImvE7JIw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Bj3oL2LeBKBLofe1PDKTuSeM+LHLUXW8rKvpQlk6hV4=;
	t=1716458996; x=1717668596; b=ImvE7JIw65nnzHrjTZLFFirIjf5tAPwzjNHwP1pwrLJv99U
	C9GFx50v6PizXWH7U5Lo6m5UacSFgq48su/Ep0cAHNjcQsMmNrpB8lbldQWg32i67radQe4RNA0YT
	MgJunYtU3fwJtT+EfOAfcQBEN8/J2pt06tqRB5sIQYKbZ0MA+ox2LwfvEUV7f76G4qWI9WfkJOVlH
	22FYiDP/ipS8r/TViuk2AtXrMQFZXQ+jbVYmEDKc4tJV3USroDI23l0TeXtwC+2uZEzPs8MgXQexB
	vZlrX20rRuwVlPHO3b8VzLeHA0vQdDhLlMZvdgy8g+Tfb67L2BlyOaISjamBiKXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OT-00000005wvn-2agC;
	Thu, 23 May 2024 12:09:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 7/8] wifi: cfg80211: refactor regulatory beaconing checking
Date: Thu, 23 May 2024 12:09:48 +0200
Message-ID: <20240523120945.d44c34dadfc2.I59b4403108e0dbf7fc6ae8f7522e1af520cffb1c@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are two functions exported now, with different settings,
refactor to just export a single function that take a struct
with different settings. This will make it easier to add more
parameters.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 54 +++++++++++++++++++++++++++++++++++++-----
 net/wireless/chan.c    | 30 ++++++++++-------------
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0e548507fd8d..dcb543344db6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8800,6 +8800,31 @@ static inline void cfg80211_report_obss_beacon(struct wiphy *wiphy,
 					sig_dbm);
 }
 
+/**
+ * struct cfg80211_beaconing_check_config - beacon check configuration
+ * @iftype: the interface type to check for
+ * @relax: allow IR-relaxation conditions to apply (e.g. another
+ *	interface connected already on the same channel)
+ *	NOTE: If this is set, wiphy mutex must be held.
+ */
+struct cfg80211_beaconing_check_config {
+	enum nl80211_iftype iftype;
+	bool relax;
+};
+
+/**
+ * cfg80211_reg_check_beaconing - check if beaconing is allowed
+ * @wiphy: the wiphy
+ * @chandef: the channel definition
+ * @cfg: additional parameters for the checking
+ *
+ * Return: %true if there is no secondary channel or the secondary channel(s)
+ * can be used for beaconing (i.e. is not a radar channel etc.)
+ */
+bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
+				  struct cfg80211_chan_def *chandef,
+				  struct cfg80211_beaconing_check_config *cfg);
+
 /**
  * cfg80211_reg_can_beacon - check if beaconing is allowed
  * @wiphy: the wiphy
@@ -8809,9 +8834,17 @@ static inline void cfg80211_report_obss_beacon(struct wiphy *wiphy,
  * Return: %true if there is no secondary channel or the secondary channel(s)
  * can be used for beaconing (i.e. is not a radar channel etc.)
  */
-bool cfg80211_reg_can_beacon(struct wiphy *wiphy,
-			     struct cfg80211_chan_def *chandef,
-			     enum nl80211_iftype iftype);
+static inline bool
+cfg80211_reg_can_beacon(struct wiphy *wiphy,
+			struct cfg80211_chan_def *chandef,
+			enum nl80211_iftype iftype)
+{
+	struct cfg80211_beaconing_check_config config = {
+		.iftype = iftype,
+	};
+
+	return cfg80211_reg_check_beaconing(wiphy, chandef, &config);
+}
 
 /**
  * cfg80211_reg_can_beacon_relax - check if beaconing is allowed with relaxation
@@ -8826,9 +8859,18 @@ bool cfg80211_reg_can_beacon(struct wiphy *wiphy,
  *
  * Context: Requires the wiphy mutex to be held.
  */
-bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
-				   struct cfg80211_chan_def *chandef,
-				   enum nl80211_iftype iftype);
+static inline bool
+cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
+			      struct cfg80211_chan_def *chandef,
+			      enum nl80211_iftype iftype)
+{
+	struct cfg80211_beaconing_check_config config = {
+		.iftype = iftype,
+		.relax = true,
+	};
+
+	return cfg80211_reg_check_beaconing(wiphy, chandef, &config);
+}
 
 /**
  * cfg80211_ch_switch_notify - update wdev channel and notify userspace
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 360480604515..8b1796130b28 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1550,22 +1550,12 @@ static bool _cfg80211_reg_can_beacon(struct wiphy *wiphy,
 	return res;
 }
 
-bool cfg80211_reg_can_beacon(struct wiphy *wiphy,
-			     struct cfg80211_chan_def *chandef,
-			     enum nl80211_iftype iftype)
-{
-	return _cfg80211_reg_can_beacon(wiphy, chandef, iftype, true);
-}
-EXPORT_SYMBOL(cfg80211_reg_can_beacon);
-
-bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
-				   struct cfg80211_chan_def *chandef,
-				   enum nl80211_iftype iftype)
+bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
+				  struct cfg80211_chan_def *chandef,
+				  struct cfg80211_beaconing_check_config *cfg)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	bool check_no_ir;
-
-	lockdep_assert_held(&rdev->wiphy.mtx);
+	bool check_no_ir = true;
 
 	/*
 	 * Under certain conditions suggested by some regulatory bodies a
@@ -1573,12 +1563,16 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 	 * only if such relaxations are not enabled and the conditions are not
 	 * met.
 	 */
-	check_no_ir = !cfg80211_ir_permissive_chan(wiphy, iftype,
-						   chandef->chan);
+	if (cfg->relax) {
+		lockdep_assert_held(&rdev->wiphy.mtx);
+		check_no_ir = !cfg80211_ir_permissive_chan(wiphy, cfg->iftype,
+							   chandef->chan);
+	}
 
-	return _cfg80211_reg_can_beacon(wiphy, chandef, iftype, check_no_ir);
+	return _cfg80211_reg_can_beacon(wiphy, chandef, cfg->iftype,
+					check_no_ir);
 }
-EXPORT_SYMBOL(cfg80211_reg_can_beacon_relax);
+EXPORT_SYMBOL(cfg80211_reg_check_beaconing);
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 				 struct cfg80211_chan_def *chandef)
-- 
2.45.1


