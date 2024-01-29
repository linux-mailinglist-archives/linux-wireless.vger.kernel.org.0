Return-Path: <linux-wireless+bounces-2702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBE8412EB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8881281543
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BADDBC;
	Mon, 29 Jan 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="htFUGfmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A632E84D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554862; cv=none; b=iF/JRS75uD3g1oTBAYCqyn03xblZ8RolJW88Qvhq8/cN7LFJamHz9KpUyPW5EOHP7pV60c9OnKdrFxjeKdOsaGFQA8MX/1ihUKm1eQLkW+GUNrUC12Ey9fiV5oZrkWi77TziUVKipvpSsJIA3ApPSkWInRpAW+jJz0tb72ZvnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554862; c=relaxed/simple;
	bh=mPa10nyf13l86zZZOqYww/Dw0Gtbihdyr/EQYTCqpV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq9eW/VhfCxVE63yQcm1+eiGOFSWgvTzIoTpE5S8GWMseH9+Gt9/xOs+s+pNbxRwsQStx68tSmHSYPECAiL2x7ibMMhUO/W1xviZMQxNCQKN9/EvXMlRxLjJH8wWLPjiO1sVcDCFqHAmUhCeOOjqZ2XIfJmgD6L//lFT9VNJ054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=htFUGfmj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rRcn+qgYpoXfyfNOBOtN2tvNKZ4+uKF2SFfvhVq6eWk=; t=1706554860; x=1707764460; 
	b=htFUGfmj3JcZS0KxITjNuU00ktf3hHKb2DzQP4TxcxsscTql38g7U3Kk3SUhE0UDSfvuQ0TNmFu
	3mirppL3ivsGCLPPswIRgmAujjRwUiJOEA15KnkXVzrEzxQfxcCe7gB8IContG/iHIhqrTcp6QOAg
	T5HHM5SIKdndUPTLj31Fn76n+E0s7c7OOSPhM9VtXiYRUrZRTp7qcFvE1jYwI9KqbA886RCNNkUxS
	FawBXeGoDbawd7JbYKTZf4zv7ST/c6TsiAH4sOGmNezF1Bw8H897Y+nFey1xNnWQdg3ssNIVdKl4j
	PZvPSH5HDfgiKK8fUYnKMza+HNo4935MIXyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWsM-00000004zxs-0wBJ;
	Mon, 29 Jan 2024 20:00:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: mac80211_hwsim: enable all links only in MLO
Date: Mon, 29 Jan 2024 20:00:52 +0100
Message-ID: <20240129200054.f5459f6c29c8.I397814449e17950fcf882ef44a1e790a71aa1dce@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The existing code is enabling all usable links when moving to
authorized state, but this should happen only for MLO connections.
Fix this.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 59ec6aa5ac26..907c0842fee7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 /*
@@ -2671,10 +2671,11 @@ static int mac80211_hwsim_sta_state(struct ieee80211_hw *hw,
 		return mac80211_hwsim_sta_add(hw, vif, sta);
 
 	/*
-	 * when client is authorized (AP station marked as such),
-	 * enable all links
+	 * in an MLO connection, when client is authorized
+	 * (AP station marked as such), enable all links
 	 */
-	if (vif->type == NL80211_IFTYPE_STATION &&
+	if (ieee80211_vif_is_mld(vif) &&
+	    vif->type == NL80211_IFTYPE_STATION &&
 	    new_state == IEEE80211_STA_AUTHORIZED && !sta->tdls)
 		ieee80211_set_active_links_async(vif,
 						 ieee80211_vif_usable_links(vif));
-- 
2.43.0


