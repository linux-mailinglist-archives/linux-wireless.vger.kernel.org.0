Return-Path: <linux-wireless+bounces-4741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69787BB01
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EC91F26034
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988726E2B8;
	Thu, 14 Mar 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jeoTQu6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E506D1BD;
	Thu, 14 Mar 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411009; cv=none; b=D0kg2PCGGLFQC3vwsYeS6QLiRG9XzFN0vOmO4J3MuMCM55Ryp/vF9XLqv0OJi0U6tBkwkVN+BNLUata40zW9o0JK6Dz4rrK8Xjf0cw2yQeVGaCxudQJDN8e2Y+bMLbc0icGguiQDJieq3Jmjm1HVnHsGxDeUxOoBVUF3w7IjuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411009; c=relaxed/simple;
	bh=GAz3IMC18u7zTkkTXAFXCWbLBOE+TT982TI6NUldSrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0AuNRMmUdiwQP6vhNI2Lkcwji8MRtL6n6IzoeW6g4MY1A1p/B8VXyhyIWXhz/x+2H0i2SyjPOe60Fbs+AkVxRQ3GCeoKmTRvW0rRETUEynlVdaWdRKBMe24isMUFvsbmLSTtdZJe2wyFUrvnhda4K2xncY+p3qga5/+H+5o/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jeoTQu6Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Cy/nU2VxCWwqaZaSzcgS+OVy77qXRy/yXlsJlzEKv+c=; t=1710411006; x=1711620606; 
	b=jeoTQu6QM5g0j7G++6DONoypMEakYuMbpZN6OlB+QzuHY5Gnv0SmojyR8ui8ch4txiExl/Dc+Fb
	eT5o23vr2rEtRZr8g+9N+Km7LWSULtFiJ/t4ejfkYy4CfThOlNjxwFJp9lxSnV6jS0t7ciHd/oBmi
	SB3Dcg2u55YH1tyv+qQUzM4PHyPjhAqnHca1kTsQEsDKMvH5xrgr9ou2lH5kBYwAUtOyaGoSD34yt
	PGSQaeBOVNqKLkacoJyFB4gnyZDIF0YJzwd7FOd1ZKtSYTOXmvj9E/0UaM08IypjdmmHKmomwY0ZD
	fHTx/BCJruLg4Ntsh4hzWAMqleKtpolzynQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rki29-0000000GUPO-39mO;
	Thu, 14 Mar 2024 11:09:57 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: cfg80211: add a flag to disable wireless extensions
Date: Thu, 14 Mar 2024 11:09:51 +0100
Message-ID: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Wireless extensions are already disabled if MLO is enabled,
given that we cannot support MLO there with all the hard-
coded assumptions about BSSID etc.

However, the WiFi7 ecosystem is still stabilizing, and some
devices may need MLO disabled while that happens. In that
case, we might end up with a device that supports wext (but
not MLO) in one kernel, and then breaks wext in the future
(by enabling MLO), which is not desirable.

Add a flag to let such drivers/devices disable wext even if
MLO isn't yet enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h   | 2 ++
 net/wireless/wext-core.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2e2be4fd2bb6..1e09329acc42 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4991,6 +4991,7 @@ struct cfg80211_ops {
  *	set this flag to update channels on beacon hints.
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
+ * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5002,6 +5003,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_4ADDR_STATION		= BIT(6),
 	WIPHY_FLAG_CONTROL_PORT_PROTOCOL	= BIT(7),
 	WIPHY_FLAG_IBSS_RSN			= BIT(8),
+	WIPHY_FLAG_DISABLE_WEXT			= BIT(9),
 	WIPHY_FLAG_MESH_AUTH			= BIT(10),
 	WIPHY_FLAG_SUPPORTS_EXT_KCK_32          = BIT(11),
 	WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY	= BIT(12),
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index a161c64d1765..838ad6541a17 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -4,6 +4,7 @@
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
  * Copyright (c) 1997-2007 Jean Tourrilhes, All Rights Reserved.
  * Copyright	2009 Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2024 Intel Corporation
  *
  * (As all part of the Linux kernel, this file is GPL)
  */
@@ -662,7 +663,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
 	    dev->ieee80211_ptr->wiphy->wext &&
 	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
 		wireless_warn_cfg80211_wext();
-		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+		if (dev->ieee80211_ptr->wiphy->flags & (WIPHY_FLAG_SUPPORTS_MLO |
+							WIPHY_FLAG_DISABLE_WEXT))
 			return NULL;
 		return dev->ieee80211_ptr->wiphy->wext->get_wireless_stats(dev);
 	}
@@ -704,7 +706,8 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
 #ifdef CONFIG_CFG80211_WEXT
 	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
 		wireless_warn_cfg80211_wext();
-		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+		if (dev->ieee80211_ptr->wiphy->flags & (WIPHY_FLAG_SUPPORTS_MLO |
+							WIPHY_FLAG_DISABLE_WEXT))
 			return NULL;
 		handlers = dev->ieee80211_ptr->wiphy->wext;
 	}
-- 
2.44.0


