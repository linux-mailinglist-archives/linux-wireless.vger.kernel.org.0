Return-Path: <linux-wireless+bounces-11306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F694EC93
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C6C280E1B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B91E488;
	Mon, 12 Aug 2024 12:15:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8939535DC
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464924; cv=none; b=rL/eBD9NkQv1r+QM1gli622b9h+QqlNB8d9mNvJUJh4d2zZQ6fg4o1Y4WPSaJfKA9w8sPtcUgkilcy6xSelFjnxa8OKU6XksP0j9yiQTgtQlDS/2WRWo9FBdqfZVMfZPNH+/un8ZMzdKCq1TMp4AwgPehoF/vPn/Gw3VNpwBBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464924; c=relaxed/simple;
	bh=V5ILcYoKGnaoTG5zZrrFSoRUjRiwfkYA6GrDXz7bZwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSxulz5EiWiOogYLuKRzlLAUv+OA1zHPEsSDS1L5OSQiMJfV+rGHEvPDL5Bf8EAvRt/YkfKkYS4Ex4jyxuqlfUHiQOm3F8fYylJwqQI6bzbLkI4lbbAyZMp5UNCGpZaagaNwd6DpS/7663JHOxytAga84KGybOOd6fqndA7bN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hissam.office.simonwunderlich.net; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hissam.office.simonwunderlich.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300C5972B4590000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:972b:4590::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BC7A0FA131;
	Mon, 12 Aug 2024 14:09:11 +0200 (CEST)
From: root <root@hissam.office.simonwunderlich.net>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Issam Hamdi <ih@simonwunderlich.de>,
	Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
Subject: [PATCH] cfg80211: Set the channel definition for the different Wi-Fi modes when starting CAC
Date: Mon, 12 Aug 2024 14:09:09 +0200
Message-Id: <20240812120909.2721400-1-root@hissam.office.simonwunderlich.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Issam Hamdi <ih@simonwunderlich.de>

When starting CAC in a mode other than AP mode, it return a
"WARNING: CPU: 0 PID: 63 at cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]"
caused by the chandef.chan being null at the end of CAC.

Solution: Ensure the channel definition is set for the different modes
when starting CAC to avoid getting a NULL 'chan' at the end of CAC.

 Call Trace:
  ? show_regs.part.0+0x14/0x16
  ? __warn+0x67/0xc0
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? report_bug+0xa7/0x130
  ? exc_overflow+0x30/0x30
  ? handle_bug+0x27/0x50
  ? exc_invalid_op+0x18/0x60
  ? handle_exception+0xf6/0xf6
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? regulatory_propagate_dfs_state.cold+0x1b/0x4c [cfg80211]
  ? cfg80211_propagate_cac_done_wk+0x1a/0x30 [cfg80211]
  ? process_one_work+0x165/0x280
  ? worker_thread+0x120/0x3f0
  ? kthread+0xc2/0xf0
  ? process_one_work+0x280/0x280
  ? kthread_complete_and_exit+0x20/0x20
  ? ret_from_fork+0x19/0x24

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
Signed-off-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
---
 net/wireless/nl80211.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..d200c365339a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10143,7 +10143,21 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 	if (!err) {
-		wdev->links[0].ap.chandef = chandef;
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_MESH_POINT:
+			wdev->u.mesh.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			wdev->u.ibss.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_OCB:
+			wdev->u.ocb.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			wdev->links[0].ap.chandef = chandef;
+			break;
+		}
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;
-- 
2.39.2


