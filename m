Return-Path: <linux-wireless+bounces-30489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65216CFE5B0
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40DFE3043F63
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E37342532;
	Wed,  7 Jan 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j/tFUX2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD4342512
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795840; cv=none; b=ULYu4MYThuAaFHYv3IOoSQ/2FLc7UpqVoMyflpu5qnHaTV69v2+IvA31YgP2tu7akYLYQO3UfKPrvEqjjyp9FYzfNgdGP/n4js4M+mPqc1g78zLfbGFt0053gtvbtghOhoH5b1wqSgGMNsKF1DLg+mpBtFarQ82rt3ji1RrG0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795840; c=relaxed/simple;
	bh=vdrjvHvRY2d9KR+mwpnjZrgAd6n81TeOjbFBUyjpzkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANJWY50HPKPe7ir/9ThoCohC8DhUGWbQFFz6xBcBuKsVr5kjn3uj0yaXdm9ZqhjGYm2J4FtfV23cQ16ENL6Zkq9T1pu2al91umOweDUmQJrIQG5q45itCjt1qnRhOeAd9RD/Gfs7L4OL1qFDVTpiyKBtxdSjnNhZNFrI0iFm6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j/tFUX2c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sovmN6TaQUXWMSNV/q4a08swJNj6hH4orUCJ6auhNFE=;
	t=1767795839; x=1769005439; b=j/tFUX2cerRRjXGLZN/kodIGtArXPBhCUpaFKg6MYdaSoBH
	c6JC3e9HeVXjiPyCUStVVsSgdEfrOjBnW5bcwHFAtX8nlOL7GbwSxFtQpT0HnRg3lAxxjFEfQHJV7
	SWGpnl7YJwgIIiMkpTCgcbzMy6j54FdFglR9Jp+3xf+t4WZt24qGSMXr7Pe4Uuwf87QYn5D21vhWq
	q3QUaM5cmTo6PydY7A5KeHmMnnn9cAMxZkPVc1LgIyjMV/smCJq3vG9i2Ldo8//yWfxaoqsiTV58g
	8rVDAa+Ak9cIugXiKT8ZmdjQcSgmcr7j6bLkEkJzzJLVP2c7+kMj0AghynQZ1i6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS5-00000005agF-1LMl;
	Wed, 07 Jan 2026 15:23:57 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 27/46] wifi: mac80211: cleanup error path of ieee80211_do_open
Date: Wed,  7 Jan 2026 15:22:26 +0100
Message-ID: <20260107152325.eecba2db0791.Idac5c38d5ad7ce97782a8c05ae72bb0c689c4fa9@changeid>
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

If we failed on drv_start, we currently cleanup AP_VLAN reference to
bss.
But this is not needed, since AP_VLAN must be tied to a pre-existing AP
interface, so open_count cannot be 0, so we will never call drv_start
for AP_VLAN interfaces.

Remove these cleanup and return immediately instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index ddce54d1c9e8..65466daebdba 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1365,8 +1365,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		break;
 		}
 	case NL80211_IFTYPE_AP:
-		sdata->bss = &sdata->u.ap;
-		break;
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_MONITOR:
@@ -1392,8 +1390,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		local->reconfig_failure = false;
 
 		res = drv_start(local);
-		if (res)
-			goto err_del_bss;
+		if (res) {
+			/*
+			 * no need to worry about AP_VLAN cleanup since in that
+			 * case we can't have open_count == 0
+			 */
+			return res;
+		}
 		ieee80211_led_radio(local, true);
 		ieee80211_mod_tpt_led_trig(local,
 					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
@@ -1464,6 +1467,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		netif_carrier_on(dev);
 		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
 		break;
+	case NL80211_IFTYPE_AP:
+		sdata->bss = &sdata->u.ap;
+		fallthrough;
 	default:
 		if (coming_up) {
 			ieee80211_del_virtual_monitor(local);
@@ -1552,10 +1558,10 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
  err_stop:
 	if (!local->open_count)
 		drv_stop(local, false);
- err_del_bss:
-	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
+	/* Might not be initialized yet, but it is harmless */
+	sdata->bss = NULL;
 	return res;
 }
 
-- 
2.52.0


