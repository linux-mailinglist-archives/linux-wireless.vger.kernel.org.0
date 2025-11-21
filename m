Return-Path: <linux-wireless+bounces-29245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5DC7AE5F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CCE0368922
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C433B963;
	Fri, 21 Nov 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAbC3Vs5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AE2E92D0
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743229; cv=none; b=N9o6d/7bOzd1RRhtjiU5YkVkRqe4SAckSCaccVo/CD08melpRnT8Wn3DZhb2G1qD4TQnSDknN/mtyh5SO2CjQz9W0w5SkV1AQUJHKouH8cLz47BmAq8mg/dDWC3biMDTWQ+TccbyJsufsRZC2m72vkA5nqUyE6/wOlQTIg3yjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743229; c=relaxed/simple;
	bh=Rm1/7ip/Xfymj7J/7OJ6HrqpXryMsKmbuq4OeZBLkHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPGsnJ7M8DwG9QGfVcNX/YgYPGDDq58Lp8kfPkTeBpUOLbxWOj4NDTaWn+vGFkRHWybZnIsxDYvHkBRDBTM96pJ5EJXjgweg8+TXNJZ8OJihNlkGz+6Ay0OOW3njaSVrFNoYak+i3sdO29X1FVEictFl828OYiQ3ucL2wy5b+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SAbC3Vs5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=iJPosBbTDupW54WNtHiaOja9wBd9b2KdAqnKuzFuTvU=; t=1763743228; x=1764952828; 
	b=SAbC3Vs5jspkBnVMHqlDV2kD0h9RaIzCGsOcOIRzXphk5YU23hwCkOeiAZ2QNSxzJW/Oc7P7Cc1
	DWiSXZrKNNhZuuHaQmc7R7te2fFiSXwdrr9jkcYqbw3BTthrIE8L3ZmmNtd9/XegbKKf1U1KNyOYm
	d04Zps0pylTKfY21celq/KXTjVyH3YeA+qa+oaAsHzodsNkeMzzx4Vsr+eaGsH7pG1aHGFHnerFva
	Vb07b2hBiLHCBCBdeqgS5xxIL8qM1139rOQij4dSfgYefkDLE9N1kkb5Yak4uC6IBPgxTZGrrTCU7
	4+RcS+mIPDQ+aximCBEhwtgjjI0C4zYNgTyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vMUBL-0000000DAuH-3FMv;
	Fri, 21 Nov 2025 17:40:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: use cfg80211_leave() in iftype change
Date: Fri, 21 Nov 2025 17:40:20 +0100
Message-ID: <20251121174021.922ef48ce007.I970c8514252ef8a864a7fbdab9591b71031dee03@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When changing the interface type, all activity on the interface has
to be stopped first. This was done independent of existing code in
cfg80211_leave(), so didn't handle e.g. background radar detection.
Use cfg80211_leave() to handle it the same way.

Note that cfg80211_leave() behaves slightly differently for IBSS in
wireless extensions, it won't send an event in that case. We could
handle that, but since nl80211 was used to change the type, IBSS is
rare, and wext is already a corner case, it doesn't seem worth it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/util.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 97f40c6d1e9d..27e8a2f52f04 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1203,28 +1203,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		dev->ieee80211_ptr->use_4addr = false;
 		rdev_set_qos_map(rdev, dev, NULL);
 
-		switch (otype) {
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_P2P_GO:
-			cfg80211_stop_ap(rdev, dev, -1, true);
-			break;
-		case NL80211_IFTYPE_ADHOC:
-			cfg80211_leave_ibss(rdev, dev, false);
-			break;
-		case NL80211_IFTYPE_STATION:
-		case NL80211_IFTYPE_P2P_CLIENT:
-			cfg80211_disconnect(rdev, dev,
-					    WLAN_REASON_DEAUTH_LEAVING, true);
-			break;
-		case NL80211_IFTYPE_MESH_POINT:
-			/* mesh should be handled? */
-			break;
-		case NL80211_IFTYPE_OCB:
-			cfg80211_leave_ocb(rdev, dev);
-			break;
-		default:
-			break;
-		}
+		cfg80211_leave(rdev, dev->ieee80211_ptr);
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
-- 
2.51.1


