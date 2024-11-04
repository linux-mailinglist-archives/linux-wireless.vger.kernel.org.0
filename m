Return-Path: <linux-wireless+bounces-14858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766879BB187
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB981F22D04
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B71B218D;
	Mon,  4 Nov 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSkHWPz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239781AF4EE;
	Mon,  4 Nov 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717451; cv=none; b=tMlIq6q7iwUW2OFmHBJlQpXUei/ujscEFwv0JYUtTzWw+XXCuSpc9ufMcQgTVikxIYVhcY4fezyteu1bJnOiFcHbM9FADO8b9jeqR5EH9KXD8jdOVj+Ctb9jBDv/gOT8jqOxV1KQ650zcrZ2uPyoTX0VRl7cgaDknIBFkfgOQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717451; c=relaxed/simple;
	bh=lBZrhWvoMj/p4OEHr1GE4XcXt2E0PBbM75G1Kg5ZRs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbPPlXbdjDFR+ss3eACbUaqE3OmaS1qF1SKYcxgRWOsfWDhllokHS4v2VYVK2jDgLhT0KF+zK+p647Mh2c45vgxcCND4VfRhNE1F2f5woIHnQ/O4A0YUWP5mbYWXWalQRS0iukhHKU2+YbB2dfOpkjgGkXQm5txqOWUugCyEmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSkHWPz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67ABC4CECE;
	Mon,  4 Nov 2024 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717450;
	bh=lBZrhWvoMj/p4OEHr1GE4XcXt2E0PBbM75G1Kg5ZRs8=;
	h=From:To:Cc:Subject:Date:From;
	b=NSkHWPz/tsM81HD9DF3xccUUMlL8uASNWXVN3t77I+VagjEyUC0v/jVA1lDOqObdc
	 BOrisI1PG5KKzuEP3Y51nWo85M5HaBjiYEn2sD0mtIlRreJg22fwO+hYe5Rxx/lSGt
	 XNRqIgKaUdzVge8DFqiUWBheX35yJNM9RNsyRFKYQ+b2Yq43dzmTc5bmbrjq+K0Zeg
	 46la4FarOVaDpJycm2n+FT4ks8ZoFIBQ/o3XqGzbITrzFUhe1WDZk0UIVSTUePgU2j
	 eKUZRhgZfWVxedpZiLZ5E4c6DDV4D27cx/qpFuAd/2MlCIp/LoVFDJLBpysVFxob4C
	 M/uMDLBSEv7ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 01/21] wifi: mac80211: Fix setting txpower with emulate_chanctx
Date: Mon,  4 Nov 2024 05:49:37 -0500
Message-ID: <20241104105048.96444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 8dd0498983eef524a8d104eb8abb32ec4c595bec ]

Propagate hw conf into the driver when txpower changes
and driver is emulating channel contexts.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Link: https://patch.msgid.link/20240924011325.1509103-1-greearb@candelatech.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b02b84ce21307..c4f4300c81c16 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3046,6 +3046,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	enum nl80211_tx_power_setting txp_type = type;
 	bool update_txp_type = false;
 	bool has_monitor = false;
+	int old_power = local->user_power_level;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3128,6 +3129,10 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		}
 	}
 
+	if (local->emulate_chanctx &&
+	    (old_power != local->user_power_level))
+		ieee80211_hw_conf_chan(local);
+
 	return 0;
 }
 
-- 
2.43.0


