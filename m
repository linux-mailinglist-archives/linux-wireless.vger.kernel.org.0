Return-Path: <linux-wireless+bounces-30486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A476CFFBE5
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1E013006E30
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DF342177;
	Wed,  7 Jan 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K8FTTftL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F3341072
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795838; cv=none; b=cG6qeHvY+RmLfZX5lkUNnK7kvQfzN9A005Vv/F3Q9V8NkRZcjkzbI5t3slOrlqmlwhKkdxbYSptMrDM28gbcmbhdQqgU6Dn2CPu5386u6YCs59R3Jim8zDEmr1f08RsjH7KOYC7Kz/eW8vcj0nDQxQmT5qb551yjLW9PLOvOL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795838; c=relaxed/simple;
	bh=ycCVF/pzcA4pUgg0LqD8mHSmZkjiqQ1YEuWHJhoEozM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQq5jIzop3YKZAnAUVJocpjgCL+Iy4Aut44t8oPwYDizzsByGdu0KC50laNDKdkJ9eF9Qndib3LXlNlKJUFHDSckHlQqgnRjehvcZdyz2A11/DXGTOIngI9FadPmIImbAoKQnqIJKjL3FeLy0HSVmmdjHzFZhXyOceo/DjpEX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K8FTTftL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QthVqPXnAdns2zMzL12siX4zNRh/g77R95SEECt2SO8=;
	t=1767795836; x=1769005436; b=K8FTTftLwmySx/3DfG7sg/pgotcd+szorJUgW/NwUbrPp3d
	ehy2l55G/uO7PvAyZUNF4OsQJS4aJ++c6V7j3qNaRMKjp7HxJ3ZbxQ7rGbzwYXlR6fvYZZ6iaoyzT
	QoLv+Ia3CD1VYxQHVJyqUbZhmtId68Yy33msRpAXbHPORwRa1foJSX9/FAFsirYhw4X9wvm7JD/82
	E0FmeJmHvSeukGmzCYyMTJfoO/ZpH6Smk8z8yjbrs0fMnr1+bgvWCDsa7Zlx6XdgMTqAWDNGBPF/i
	f6yJVTsILEtIREvdkCVar3c1M6vbmuU9St1p7xlfFfz+zZD9SprmUfHepdt1VTMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS2-00000005agF-3HBz;
	Wed, 07 Jan 2026 15:23:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 24/46] wifi: mac80211: properly handle error in ieee80211_add_virtual_monitor
Date: Wed,  7 Jan 2026 15:22:23 +0100
Message-ID: <20260107152325.9c5ef9d9a3b2.I689dba2f54069b259702e8d246cedf79a73b82c6@changeid>
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

In case of an error in ieee80211_add_virtual_monitor,
SDATA_STATE_RUNNING should be cleared as it was set in this function.
Do it there instead of in the error path of ieee80211_do_open.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 024fd4b17bdc..d5ba067a4b51 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1222,14 +1222,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		}
 	}
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
-
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
 	if (ret) {
 		kfree(sdata);
 		return ret;
 	}
 
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	mutex_lock(&local->iflist_mtx);
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
@@ -1242,6 +1242,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 		mutex_unlock(&local->iflist_mtx);
 		synchronize_net();
 		drv_remove_interface(local, sdata);
+		clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 		kfree(sdata);
 		return ret;
 	}
@@ -1551,8 +1552,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
-	/* might already be clear but that doesn't matter */
-	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	return res;
 }
 
-- 
2.52.0


