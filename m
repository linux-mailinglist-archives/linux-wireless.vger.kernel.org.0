Return-Path: <linux-wireless+bounces-30498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6BCFE52C
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25E1D3005319
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F3344025;
	Wed,  7 Jan 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EuRkx/mg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B95343D6A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795850; cv=none; b=nWDjUPru452tLjmoppwR1o1pzBpDE1ypQQmh3FXd8Jequ84jEK4ezbo9S9lFTjgUS0WP7UUEf9y9kZ2Lwtrs2c50LYaP5KBfjQtZRIvNkUp9oTBgeA+LIrbyHwOfhX6HyaA1G3y53qZPyvME4yGcdJnz8yB9qmuRYSoG+bXgc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795850; c=relaxed/simple;
	bh=dYD6S2GEM4Pdom+gWxDakqous5HRLhzrDb/W5DW532s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts+Ba0AakZ8a+niaX4Fy8CTYTs8vRaj3u3xXIBXKehjVJ/HDV38UWVHbV+/Ed6gtVO0LdzW3fzda1yU8W+SmgOwJlLy35+sB7jpEpwO78o+DFDM7y9iHjQo8874hESwmxYFjIRsLidT1DB6gHSdolEAqjKNdPLG2bfP9/wEge2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EuRkx/mg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GEIdbR4txxvgfI3tGeJO9H5umCPUvJxOr+9oUsS5zoY=;
	t=1767795848; x=1769005448; b=EuRkx/mgpLQ/Ez+W4iafHBPW9+FL6+5qdv+TDxz6BZ+l+mD
	zNLK2x4DbuuF7cx6R83XbVVFlOS99EWBjneXXPdybSb0UDUmzGyUXUngLPwEBzCjAPsFs6QsqWUgq
	hrXf16Pvy+Oh/igAi05PcQg9wt58SUNhqd1VmGZFdgWwQd3h5V8rHQNJwf8pgK/7SH4XW49AedAJV
	u/I0viN/e1jDhA85cyaJu3dofx0shGjUahl7srtu+A0MMdhqQiyNPA/aL2CE99DtA99549aH7/+kN
	S18i/sF4O9qTBfTLnVpoEJJmDCf16popDjdvjaS4R8wig/P2BXqqR0F6Dy01YeaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSE-00000005agF-1zSk;
	Wed, 07 Jan 2026 15:24:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 36/46] wifi: mac80211: allow block ack agreements in NAN Data
Date: Wed,  7 Jan 2026 15:22:35 +0100
Message-ID: <20260107152325.9ecacff497c4.I104435f2af65e032cba168b1d842cb9610720041@changeid>
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

Allow receiving and sending Add Block Ack action frames for NAN Data

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-tx.c | 5 +++--
 net/mac80211/rx.c     | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index d981b0fc57bf..bcf9a54fb813 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -638,7 +638,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	    sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 	    sdata->vif.type != NL80211_IFTYPE_AP &&
-	    sdata->vif.type != NL80211_IFTYPE_ADHOC)
+	    sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+	    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
 		return -EINVAL;
 
 	if (test_sta_flag(sta, WLAN_STA_BLOCK_BA)) {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 771fb07e84c3..bd927eda04fe 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3739,7 +3739,8 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		    sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
 		    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 		    sdata->vif.type != NL80211_IFTYPE_AP &&
-		    sdata->vif.type != NL80211_IFTYPE_ADHOC)
+		    sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+		    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
 			break;
 
 		/* verify action_code is present */
-- 
2.52.0


