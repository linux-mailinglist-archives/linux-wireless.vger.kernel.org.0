Return-Path: <linux-wireless+bounces-30499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C3CFE598
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5527330248A0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60F344045;
	Wed,  7 Jan 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oURAqDMF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D62344044
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795850; cv=none; b=ej3Z26OhBZOZCSFGtJWaTAW5sPNomBmDcO+SE6vf5aPTt7/8XhSZIV+ibTFdVycBgPnoY+/i14jMboJ0ff1qP9l0/PZfW5cxIpUlP7iZgjvV+9hFSjO071Dw1qwBAj/KQWnFv9+qP3dB5aBNY7Db8p413b2SZWGeG+dcApAGrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795850; c=relaxed/simple;
	bh=/Kx2eG52jvZLJ2Sk4hBY9iubbpaiovLJrfmmeDZTZZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdGWVWMMkbs1E4CunFZ/Pf/KlYjc+qF1UKCg+joL3uYXoT6A3MBH8L7DdGKab74eb9ILdYsKyBQA9aG43u+RkbHTf7cG5+FP+5iy/gfKt5KTiRnIBSuCylowmdpgc8Z1KkAmQ2Rh98Z5wLrhEdgiKptyCTb0STzR1EULIP9tRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oURAqDMF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ACNQngi/X7cMkzBXviCvAu0k9+P42Qce4GIvSu7vvvo=;
	t=1767795849; x=1769005449; b=oURAqDMFMcHWDAl0zxeHV+Av38n6U2wvcL6My0OE3o5RZpB
	PXW5RIXxsQZnA8qq7W01N/mYrFjWG42DOtQ/rE5g5xjwxtyyjKBWMeNgK8SwE/WNU94e2PA1aqHs7
	JIFAA2rI8R8S6BduMbf25oYkLf36rmU9ktcdkOpd9ovjM2Up6nZQ1j+xciE6QusSOxgVwZ9CWr0/j
	lgI6LHpgGAgIyU1JLt/mVCv3b7LHUutcE/uAFUZ1JIDFfUUi6LUVinxjGCwnMu1juU84eNQDx6Fjy
	SVAEDjFwJPsWhlLpdDgFXblYMeohxPUx4S6vQ/PtU1ArVDqLnDQV0fCI79PGO2SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSE-00000005agF-4BDP;
	Wed, 07 Jan 2026 15:24:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 37/46] wifi: mac80211: report and drop spurious NAN Data frames
Date: Wed,  7 Jan 2026 15:22:36 +0100
Message-ID: <20260107152325.93308b40e5f0.I19e3572508beeba143871682c80e9a56b6c1046a@changeid>
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

According to Wi-Fi Aware (TM) 4.0 specification 6.2.5, in case a frame
is recevied from an address that doesn't belong to any active NDP, the
frame should be dropped and a NAN Data Path Termination should be sent
to the transmitter.
Do it by dropping the frame and calling cfg80211_rx_spurious_frame in
that case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bd927eda04fe..a439bbb098e2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1587,6 +1587,25 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 	if (ieee80211_vif_is_mesh(&rx->sdata->vif))
 		return ieee80211_rx_mesh_check(rx);
 
+	/*
+	 * Wi-Fi Aware (TM) 4.0 specification 6.2.5:
+	 * For NAN_DATA, unicast data frames must have A2 (source)
+	 * assigned to an active NDP. If not the frame must be dropped
+	 * and NAN Data Path termination frame should be sent. Notify
+	 * user space so it can do so.
+	 */
+	if (rx->sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+		if (ieee80211_is_data(hdr->frame_control) &&
+		    !is_multicast_ether_addr(hdr->addr1) &&
+		    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC))) {
+			if (cfg80211_rx_spurious_frame(rx->sdata->dev, hdr->addr2,
+						       rx->link_id, GFP_ATOMIC))
+				return RX_DROP_U_SPURIOUS;
+			return RX_DROP;
+		}
+		return RX_CONTINUE;
+	}
+
 	if (unlikely((ieee80211_is_data(hdr->frame_control) ||
 		      ieee80211_is_pspoll(hdr->frame_control)) &&
 		     rx->sdata->vif.type != NL80211_IFTYPE_ADHOC &&
-- 
2.52.0


