Return-Path: <linux-wireless+bounces-12205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A9963F87
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FAD286785
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CA15666A;
	Thu, 29 Aug 2024 09:09:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C818C025
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922568; cv=none; b=rNr570xPNOQiBJKrnavzVyh2Qzhi6dbm6u8oDGJ/KD9zRFIClEde9H6fobAToL/Hb7um2Kjg8wTqR5Izt8Wqqp1v2LbT26pE1G2nvhW70qdsAdnA20Hvo684jSq1IxIxqGwDMoUK5NRKl4H4qrNDwFR/Y7obfG/qugtpHeKsw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922568; c=relaxed/simple;
	bh=ml4sOxO8ZKyXC6YXZdo3WVWHC04PEgkVadV4wh9Vvcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlTdPkvWvw5KiM5ynGcahUnhTVkSgkD2LQQeGdGPu/yTZjFOk5UUlYKMuKDVbLVbsawOU0JEXcZ3D1DSCDDy+cxOEQ8g7vR6iD5YUDUCY02yMPP8hfr85NYVbx+D0hdvZht1I/Rwax1651HcmjGKVpXZiOVVCwLUwcWay8xJB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300c5972FE490000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:972f:e490::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3F8F4FA131;
	Thu, 29 Aug 2024 11:09:18 +0200 (CEST)
From: Issam Hamdi <ih@simonwunderlich.de>
To: johannes@sipsolutions.net
Cc: ih@simonwunderlich.de,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	mathias.kretschmer@fit.fraunhofer.de,
	oe-kbuild-all@lists.linux.dev,
	quic_jjohnson@quicinc.com
Subject: [PATCH v4] wifi: cfg80211: Set the channel definition for the different Wi-Fi modes when starting CAC
Date: Thu, 29 Aug 2024 11:09:15 +0200
Message-Id: <20240829090915.2887206-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <6a9916848826a07ca41f1170e1d20cda9e798872.camel@sipsolutions.net>
References: <6a9916848826a07ca41f1170e1d20cda9e798872.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2: update the subject
v3: update the second Signed-off-by to Reported-by
v4: Remove the check on the OCB mode
---
 net/wireless/nl80211.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..60cf6d3dd3ca 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10143,7 +10143,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
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
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			wdev->links[0].ap.chandef = chandef;
+			break;
+		default:
+			break;
+		}
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;

base-commit: cc32e9fb380d8afdbf3486d7063d5520bfb0f071
-- 
2.39.2


