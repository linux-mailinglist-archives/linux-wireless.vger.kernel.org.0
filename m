Return-Path: <linux-wireless+bounces-25649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28EB09E19
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020384E1510
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8622C35D;
	Fri, 18 Jul 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EiV93BWN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC3AD21
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827572; cv=none; b=MxdqTaZSzfaQYpZdPxrHVJj2sxICZzfjdvXG4cXEvr0X9EF4WjhCnj8cTWZtkx8efRKCA5GLL8bXSfyT8o2UpmSISFQYiYcJnVV4jSzyvh4DZkZFHyJyaEAgzoYg45uEbPmjSm2AEBOACVd6l/MbdnAB/kgJUpi0Hc+ykwah5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827572; c=relaxed/simple;
	bh=jGE6fKCCBw10J3v63Kk4QQKdmgAKlYfgm/z0BEpxsuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiXYzknPVXJ8eFEbvQK4SXcNEqU4LSOP5IzonGHVRhxlxKdexgSzpCm3zDDBVXZl31vmqzTxOfJn0xasth38JhH8LpeAWJcWjVdNrcMETbZyx4K7VRuxCi9TnaQKX5NhzenZL83rqsPHpD/s2PQyIqAggFTwYTg6jjXdLb39rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EiV93BWN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3/dW0aIjuR5mmELrja0TRihaSd+/dwRX9ST2WYOevLM=; t=1752827570; x=1754037170; 
	b=EiV93BWNhe8oObk3jIMVe0I2rS/rMCC1rLghMio+p7okidKshWb/pylGXEw3Njn9VA9wYTqaJ/B
	eUuYVFUxb5sI8nrsBxIaRsYELFXmFJycELrs9/CI7M2S7TFXapc5LoLZIpBuFFXBSs5iq3ShSjTY2
	mpm4AGA6AR9l3CsimGclVwF46Kku7FkgGjEWgDiBwC1HISFHfOzkZki0YERJblBWlHQqlUdi9BlMz
	vbZdxVI41/dLtVms7nYOCFU94Nx/0gF2r7QLoLSO2o/zTZ9Hulm80zS0I/llvHRBD2LbHZWfzbDQU
	qAa/PNnaJfjE1aK3a4HmjD45ZJf9j67GzjsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucgWL-0000000CNZP-4BXk;
	Fri, 18 Jul 2025 10:32:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next] wifi: cfg80211/mac80211: remove wrong scan request n_channels
Date: Fri, 18 Jul 2025 10:32:36 +0200
Message-ID: <20250718103237.59510b2384c5.Ied5ba9c5c49efc008f4491c8ca7a45858a83f064@changeid>
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
v2: apply on wireless-next

---
 net/mac80211/main.c    | 1 -
 net/wireless/nl80211.c | 1 -
 net/wireless/sme.c     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ec60b82af007..351564360c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1334,7 +1334,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				      GFP_KERNEL);
 	if (!local->int_scan_req)
 		return -ENOMEM;
-	local->int_scan_req->n_channels = channels;
 
 	eth_broadcast_addr(local->int_scan_req->bssid);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 63f015ce9ad4..20bc0f052c16 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9975,7 +9975,6 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
-	request->req.n_channels = n_channels;
 
 	if (n_ssids)
 		request->req.ssids = (void *)request + ssids_offset;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 6d7a7e7f0fc2..826ec0a6355f 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -83,7 +83,6 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	if (!request)
 		return -ENOMEM;
 
-	request->req.n_channels = n_channels;
 	if (wdev->conn->params.channel) {
 		enum nl80211_band band = wdev->conn->params.channel->band;
 		struct ieee80211_supported_band *sband =
-- 
2.50.1


