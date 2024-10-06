Return-Path: <linux-wireless+bounces-13572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1F992229
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 00:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401261C209CD
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AC18BBBB;
	Sun,  6 Oct 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Hn+nhNYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF018C036;
	Sun,  6 Oct 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255206; cv=none; b=drQxcZejQz3pxamtKVShfWJNQ+jr9dBGgXwECOmgAZCguakSSwYuDpvOYbb6n0pnLbRdejRtVxr9Rk0FUYHfh6bdYiHATyOvY/LBMx3ezUvqtmvzei5MZfy6OrtfnIAvfgXa/kIXevVI7jBigfIsm7Owi87rNORHW6V9lxf1yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255206; c=relaxed/simple;
	bh=JbGT4PmDiLI+8OespZr+BZTeb1MTifSY8Tb5f9KoutA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMQrjbB9pws4iQCK1YAehmhZDmlpBUykbCjz4UQcDoCKuY0NdHx4ohhQ7OoT+XbBXhJ6wTwu8lzHigFYWtDqp67xMnM4T2IdnVCyZWk2r5iVRI0eT0pq/hDtt3LvPPlXlvXnieBHxDO23SgJIIVeiOV2dzHJ1erpfcG6Kg2Az0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Hn+nhNYR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=sDoC0AjVQEZ6NF4cxvoGmjALQJWw/amCL5+nVShqYGk=; b=Hn+nhNYRmPY9LuMg
	UuUkcWjibQkAzlxdn6I3XcRDdItv/07roMzfUs/ndRg/yvAadGc2UiPYnkdbj2mjjLiG+yF10k4Dv
	AuqtcVnAEY0/30eyFMCJaUpiQO0Kzo6zGc4qV6voSGsq09SeNxGqpE+FrVZg0h6qIyJZf0dx2WJlg
	eG4hzB1hrFMn1661rwSbIlt0pSygWlD5BG5EZgJPltnEJRz5UKcZBC3bMtDz6Cem8Dy/qxba3SOxy
	l/9luSTZ9+puHjDQGKNgCoCpQL73Sw6OhnNQOUgSpj16JfiJeJCbQSkgslGyZlNOwRurLw6oFA5xQ
	tvHE7CPqpxL8yn/WPw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxa7d-009LcO-0I;
	Sun, 06 Oct 2024 22:53:05 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] cfg80211: Remove unused cfg80211_background_cac_abort
Date: Sun,  6 Oct 2024 23:53:02 +0100
Message-ID: <20241006225303.121445-2-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006225303.121445-1-linux@treblig.org>
References: <20241006225303.121445-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cfg80211_background_cac_abort() is unused.
It got renamed from cfg80211_offchan_cac_abort by commit
a95bfb876fa8 ("cfg80211: rename offchannel_chain structs to background_chain to avoid confusion with ETSI standard")

and that was originally added in commit
1507b1531981 ("cfg80211: move offchan_cac_event to a dedicated work")
but never used.

To me it looks like the queue is still used (I see a queue_work
in __cfg80211_radar_event), so I think it's just the wrapper that's
unused.

Remove cfg80211_background_cac_abort.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/cfg80211.h | 9 ---------
 net/wireless/mlme.c    | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69ec1eb41a09..fd843a519329 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8752,15 +8752,6 @@ void cfg80211_cac_event(struct net_device *netdev,
 			enum nl80211_radar_event event, gfp_t gfp,
 			unsigned int link_id);
 
-/**
- * cfg80211_background_cac_abort - Channel Availability Check offchan abort event
- * @wiphy: the wiphy
- *
- * This function is called by the driver when a Channel Availability Check
- * (CAC) is aborted by a offchannel dedicated chain.
- */
-void cfg80211_background_cac_abort(struct wiphy *wiphy);
-
 /**
  * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
  * @dev: network device
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4dac81854721..8ec236bbbc7c 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1226,14 +1226,6 @@ void cfg80211_background_cac_abort_wk(struct work_struct *work)
 				      NL80211_RADAR_CAC_ABORTED);
 }
 
-void cfg80211_background_cac_abort(struct wiphy *wiphy)
-{
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-
-	queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
-}
-EXPORT_SYMBOL(cfg80211_background_cac_abort);
-
 int
 cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rdev,
 					  struct wireless_dev *wdev,
-- 
2.46.2


