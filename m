Return-Path: <linux-wireless+bounces-30492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C3FCFE574
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DBA83025DAD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA5C343203;
	Wed,  7 Jan 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nUO9J7ct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1B342C8B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795843; cv=none; b=e/h7lOTbdahB72N5eR7nkctFbVTkaX3R2yXcNA8ya9f59Ja8lS/d/K2l/wfTw2fzeNQfJDHmBC72mIDltRPjqESN6Ji79ZXNnB6yQpOFbA0TUr8b6yVDuQtrL1tzQGQaPQQJ8tbspMNQrpCN7+/anfCForS2dVbCgBBKlDoH9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795843; c=relaxed/simple;
	bh=2NYT5JcJpg/z0O4e+QH9afo95M2g3IcSLV22znj0EC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoNKOBnIR1p45AbgbhlMyAM7B2jw2FYCPnCXbQfOsnZimYZHaIJXr4g2lvIDXTmX5CRF4meiLK0zveqBS7P/gYRz2JJBo0/0w5yjpcSoN4rrIzR2zwUytoctgx/leb0sV+DB3vsCA0JHFEWw79kbFlPliH1ghDl0R3qQhP8TQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nUO9J7ct; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=INiG4lcRy+fhJaQwJ4oWFAAKcU53I/kpYohM9gfVDAM=;
	t=1767795841; x=1769005441; b=nUO9J7cthQBZUYeomqq4tqyYWubarPMRmAjDFL55hleXkUW
	7ZVy/lHocwrc1S+qoiF8Zx+96IPIyqIkH1WsXsZIAI7vWzOIdE7GicTmUeGDzni/GG+85OEnMF7KK
	Gxag3CRXP8cMuIUmwLtEaAQygM7M6xDCLQijfiyoYLSk9SJXyTI77FVeGUqWLU2Uva570WQQ8hnF1
	uBZr+uQq2TKzHeoohBVFl9URgR1wcPYaOLQ6T2kQdA9/dDTeS/ACAvoXTz1UTwFeDvyia/EpLpHsu
	gQNyF7kWD8cDaOKhD9EkngFbHcKCSvXwxsgoEzqOA+EQJdBJWXDbiE3W8iHOG3KA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS7-00000005agF-24nE;
	Wed, 07 Jan 2026 15:23:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 30/46] wifi: mac80211: handle reconfig for NAN DATA interfaces
Date: Wed,  7 Jan 2026 15:22:29 +0100
Message-ID: <20260107152325.26df60c2db47.I2ba3bfcd93e47e48d7f7c74007c70cca52d46896@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Make sure these interfaces are added to the driver only after the NAN
one was, and after NAN operation was started.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d31d393784b6..e623fd2b2cf4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1770,10 +1770,11 @@ ieee80211_reconfig_nan_offload_de(struct ieee80211_sub_if_data *sdata)
 
 static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *ndi_sdata;
 	int res;
 
-	res = drv_start_nan(sdata->local, sdata,
-			    &sdata->u.nan.conf);
+	res = drv_start_nan(local, sdata, &sdata->u.nan.conf);
 	if (WARN_ON(res))
 		return res;
 
@@ -1782,6 +1783,15 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
 
+	/* Now we can add all the NDIs to the driver */
+	list_for_each_entry(ndi_sdata, &local->interfaces, list) {
+		if (ndi_sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+			res = drv_add_interface(local, ndi_sdata);
+			if (WARN_ON(res))
+				return res;
+		}
+	}
+
 	return 0;
 }
 
@@ -1935,6 +1945,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 			continue;
+		/* These vifs can't be added before NAN was started */
+		if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+			continue;
 		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 		    ieee80211_sdata_running(sdata)) {
 			res = drv_add_interface(local, sdata);
@@ -1952,6 +1965,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 			    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 				continue;
+			if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				continue;
 			if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 			    ieee80211_sdata_running(sdata))
 				drv_remove_interface(local, sdata);
-- 
2.52.0


