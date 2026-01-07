Return-Path: <linux-wireless+bounces-30466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FACFF6A3
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E382B3035AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976033A9C3;
	Wed,  7 Jan 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JOxTdkhG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F1329C7C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795820; cv=none; b=pqrVUOc/GCWSIauJdY67r8wWIjQNBEfHVyBG3h3khVJr4zx1WbJn5j6Gzt/AIoibiIIaVGmu3YKea0tfzYx2cLuDa2+Zgv4qkeHPxZ8Xs4/OTo0AoUteu5T3kQUoW6qAG8qWJNY6b7gSdNCdvD9el3vV2gZyj/WXF0rmUc7ZrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795820; c=relaxed/simple;
	bh=LtBY7Yzzibi1H1YAgW2utsZ4ovVN759zX//DlGojYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA0KINWZTHWdJ6KXQqfXqmzSjO75oqkJs6G8XPCv6Mezhp6J6ewaNIUjMgR1DKdkbq8/PfJVe+18KYF+UOvvmBp0+E7d+BKAMBM9m4/xj0bNrBhBkOToXW6yRwyMaiF2aB7z6faZ5yNlpK+2WB9C2WO6dypKYP1q5j69D3II08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JOxTdkhG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CPyJo3EGc0MPIZ9ZawwH3vIS+G6x/9JCzOqmyoL1vOs=;
	t=1767795819; x=1769005419; b=JOxTdkhG+UX4qQHDRb02TsaudQkcSPG0FjvPkPBmp1TIgd5
	fwWBJYtUcXanI+4xUVz2M7qpIMsLRDvgiktg7JxIB/F3nAfDB49sqDahXPFsdc2KG3WQVwIisKrc+
	EGw6Iuv7SsP+bCTwC5jmwev8+Ga0oQRr0pJTGmgyHnAxehHqc3ixK+wIID6GLmqEVMP3pXTYJsxLM
	Mu2tROT5xJEnc0u5HNpIjsSNBhfpq/NFZ7QPLFnjXF+9y7afgQXHojnmElTVoB+U/V5ZvSKArnlIb
	TZSREA1L+Wd9+sitoP3tBEmnRCEyQ1Zhs9tV8wroQ6voft4Sq7qohyuWhLkEKAhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURk-00000005agF-1XgE;
	Wed, 07 Jan 2026 15:23:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 03/46] wifi: mac80211_hwsim: remove unused nan_vif struct member
Date: Wed,  7 Jan 2026 15:22:02 +0100
Message-ID: <20260107152324.df76aeb1803f.I35d3eae582461af7ee25c63c56b13adff17cf20f@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The struct also contains nan_device_vif and that is the member that is
being used.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..c3babda1660c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -760,7 +760,6 @@ struct mac80211_hwsim_data {
 	enum nl80211_band nan_curr_dw_band;
 	struct hrtimer nan_timer;
 	bool notify_dw;
-	struct ieee80211_vif *nan_vif;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
-- 
2.52.0


