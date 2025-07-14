Return-Path: <linux-wireless+bounces-25381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2BB03E89
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D31885285
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B93FB1B;
	Mon, 14 Jul 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VBV+F1JI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC67247290
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495851; cv=none; b=YVHSb6VHf/Z6NHX2A3ycdABOKr7gZStK+1S1gC1xZm+euzokwSSBFVHmSzuTJgXy+l9bqOvS8ofVBgfo43dJWIDL5TzAG+VBIjbAUh4lCqHk7oZbaAT5ta3YbBMAO6VJA0+H33LXYnWU1Lja2MmcjflxJ46dA7KR+WqtKfdSFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495851; c=relaxed/simple;
	bh=icYxLDDklMLD5GADehEaB35YySHsXMV5oVa6pp6aZQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URQm6B34HezCsPIWk+BrycevIQBPi9pOiR35tIWVb+HAR5c/1RBCLdIc9ywTfkEiSuVM7UOZOU2xb61nDM+5EcCPLFF2GiDn80t0rCa2WfVVralqUke7iQXDV+NNudcEQNFGdcohxAnG5JAiOIO/pf1UVrEyUdgzsx3ylO9tZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VBV+F1JI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Bbd6pNJrlb7qHZ4b9jTcbPXToe6gFtCU/hTin7GBlzc=; t=1752495850; x=1753705450; 
	b=VBV+F1JIE6ALiFsJp0LrLPEhmlD4jcRQiFDdCypPCaFgJPJDB99RzIQvHh9zSHYnvKYOb3Kb2Y3
	lxesXWtv+Sgk3ZjGmnLnXjGJQ4HCh72CjrmmEnRhN3tVwfMbLJTw/0CQPiofZv1HlyBse6f4SCsHG
	r/FmG008B6PIxdKmn4lNXTtMTbN1DCFCBNSC2EyRXdCeDBro0ebofKHUIg+OT4aYmvkDaR8+CwylX
	ASKPlloTdcNusb7MBGJg8oWkBhr84EYN3GTuUa4qITuQcW1Nt6jgjL0riD7z/fGUbbqcSRCEX9sA8
	aksfQQr0nat80gWQzk5TtOWuzyctHxaTK+DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubIE3-000000043RY-0ooj;
	Mon, 14 Jul 2025 14:24:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Haoyu Li <lihaoyu499@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211/mac80211: remove wrong scan request n_channels
Date: Mon, 14 Jul 2025 14:24:05 +0200
Message-ID: <20250714142405.02beff564ba8.I25dd7af47f5dab3b560dec7b33cdaf49c3a4418f@changeid>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This (partially) reverts commits
 - 838c7b8f1f27 ("wifi: nl80211: Avoid address calculations via out of bounds array indexing")
 - f1d3334d604c ("wifi: cfg80211: sme: init n_channels before channels[] access")
 - 82bbe02b2500 ("wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request")

These commits all set the structure to be in an inconsistent
state, setting n_channels to some value before them actually
being filled in. That's fine for what the code does now, but
with the removal of __counted_by() it's no longer needed and
it does leave a bit of a landmine there since breaking out of
some code to send the scan or something would leave it wrong.

Remove the now superfluous n_channels settings.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c    | 1 -
 net/wireless/nl80211.c | 1 -
 net/wireless/sme.c     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6b6de43d9420..2a7587955127 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1359,7 +1359,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				      GFP_KERNEL);
 	if (!local->int_scan_req)
 		return -ENOMEM;
-	local->int_scan_req->n_channels = channels;
 
 	eth_broadcast_addr(local->int_scan_req->bssid);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50202d170f3a..f45293b2a0a2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9439,7 +9439,6 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
-	request->n_channels = n_channels;
 
 	if (n_ssids)
 		request->ssids = (void *)request + ssids_offset;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index cf998500a965..7a734c8085af 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -83,7 +83,6 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	if (!request)
 		return -ENOMEM;
 
-	request->n_channels = n_channels;
 	if (wdev->conn->params.channel) {
 		enum nl80211_band band = wdev->conn->params.channel->band;
 		struct ieee80211_supported_band *sband =
-- 
2.50.1


