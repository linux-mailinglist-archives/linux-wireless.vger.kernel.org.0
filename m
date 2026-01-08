Return-Path: <linux-wireless+bounces-30568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30599D03901
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 15:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E9A13064D69
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A63BFE2E;
	Thu,  8 Jan 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MYITukir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A814F70
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879113; cv=none; b=N7ppLHyrTixKvyHZsxCLRzaaR4eMdy8wiRFDf0gI1PiwAoxLJ+ZO0OuCrKtlk0BDI4p5SEYxQ27FYLVHjp6FD5AioveYD/ywV5bqFd4q14uEnuUWE3kifHSy6wERhiauobgpbWnrEX6w7+zLqMHKPRZW3A7bv5Du98fRLutTuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879113; c=relaxed/simple;
	bh=9oU51hFX/jiGK3lVbg659dEI5nCip5Y7e2zjeiQokRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSfIIT4zIZ++ry7nuPriY/C0vT8vCKXLRszaxUYK8v68+ha/XpfLUrVzzmSpg5Dy+jHnFiUb/iYzmduIhlfbgl+BOLoIwP+SjlMeORpb8G6oO/tGS8OCVOT7r/Guf47ulfBeV2TkBhAuV0ATJFRL1q2J1Qa6hwckD9vi7SSJRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MYITukir; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=myy5wIbQCc7FOWx3VYYqxH5aYxm7qOFpdtoucH1hxsU=; t=1767879111; x=1769088711; 
	b=MYITukirdD+oIqZYHedhjQPFblmxMcWlVbC/4LGM3l7Aa7PI7mQ6LQSjYCSI4v1OhAhJun0tG5E
	AdwrnkRFWumhHEZelFyGwltw90niPfEJbwp4QIcIpjiCpfpxnXxpLBgrgvZlpg8LnPTkqWWh3Th49
	KCkGAPy8DEUUlTTK2R4OmqiDQGN6OFJyo1+vn6g+5KBS/Tn8nTpLlPeVYZCZ6opFU+onRjUAOuutA
	liY0WzvbmArVBfp1ED+BSc1VQaR+vwyHFMU7XYLIlewW4+94vdbgEhoHcET4W0TkxPSTGCy7zDffC
	WIHR8jniT5YCUrs80uxDmOPEfoPBfkeKU3Wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdq79-00000006WSS-1bd9;
	Thu, 08 Jan 2026 14:31:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211_hwsim: remove NAN by default
Date: Thu,  8 Jan 2026 14:31:38 +0100
Message-ID: <20260108143139.0d4af6ae3609.Ie444b9f5aedabc713c6a1279b5b55976cfb4c465@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We're improving NAN support, but NAN datapath support also
means we need to change some other things, e.g. related to
rate control. Remove NAN by default again from hwsim since
it's the much newer feature.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..df145d911f9a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -7163,14 +7163,12 @@ static int __init init_mac80211_hwsim(void)
 		}
 
 		param.p2p_device = support_p2p_device;
-		param.nan_device = true;
 		param.mlo = mlo;
 		param.multi_radio = multi_radio;
 		param.use_chanctx = channels > 1 || mlo || multi_radio;
 		param.iftypes = HWSIM_IFTYPE_SUPPORT_MASK;
 		if (param.p2p_device)
 			param.iftypes |= BIT(NL80211_IFTYPE_P2P_DEVICE);
-		param.iftypes |= BIT(NL80211_IFTYPE_NAN);
 
 		err = mac80211_hwsim_new_radio(NULL, &param);
 		if (err < 0)
-- 
2.52.0


