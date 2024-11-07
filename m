Return-Path: <linux-wireless+bounces-15109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006919C0DA2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325921C245C5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1821642A;
	Thu,  7 Nov 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="5v3qiGc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287C18F2C3;
	Thu,  7 Nov 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003357; cv=none; b=qvOpJNIIfoqbYA2xSsP/9WTfyINyTnXzLbGjSOwSKLHihIZHGWhJctzpdfmnv05ZenizPdd9R7dCWrjclBPHUJB10STKxYn9U8Am+Ks8RmIRainFQEgPcfzlEF3hJqPTzOSj+o3cLO1IJhS9iss7USl6GXyBavQ3e4Wzwamsf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003357; c=relaxed/simple;
	bh=nPtIPAsVU561Yvnaz6+T9uVxRiHW+Vr+l6+dAUjIOPA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HGNyaalOxHCgs3CwqowF0/cLijGK5PgEJXz2cr6JbbqN5rhncQrg1p/G2LeshzdkSI2Bk+rFAIzl3PCbu679YdinQ+LrzCW5gxgmzFBiIIiVK0nM03k/I4OGGQam9S1+Eu4+AxMvHVNiwCDarBKiMgQVL0k8zV186Ymje9erIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=5v3qiGc+; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=gmm+6Zzwe4WCun2UySrUADDVxhFn3Q+fKTUXGWtZAyY=; b=5v3qiGc+4HBRvW1ypXPU+a9xh0
	1bKC7IWhJzUzjseuvl7V++gNxz+w4NnGliWpWUt58Dnr3CRPiaZHqnBFQJp1nlo3AgzeaWJvt/f5t
	XQ9uBSQLkbjDMEjXLVS48WP5fu8+fB+4PvpJiNkmlAp1ZEob2r4gvH+fKbFvANXLMVTPGgkDW2dvH
	i4ewoeyvCLsiYitN5+4h6CP4sIIIXdRIFD53N30iRvLieYVfBNgMMXKP8i64VTi98pPwY2wR9ok6d
	7KelnlK28vMb7nmAh+L7Iiab+pueBdVrL+wGTmTgl/XqArDqg6IColqcuPsCNXxpZIRMCkCKMuibo
	gWchP62w==;
From: Andreas Kemnade <andreas@kemnade.info>
To: kvalo@kernel.org,
	rmk+kernel@armlinux.org.uk,
	johannes.berg@intel.com,
	andreas@kemnade.info,
	leitao@debian.org,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: wlcore: fix unbalanced pm_runtime calls
Date: Thu,  7 Nov 2024 19:15:31 +0100
Message-Id: <20241107181531.1774550-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If firmware boot failes, runtime pm is put too often:
[12092.708099] wlcore: ERROR firmware boot failed despite 3 retries
[12092.708099] wl18xx_driver wl18xx.1.auto: Runtime PM usage count underflow!
Fix that by redirecting all error gotos before runtime_get so that runtime is not put.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/net/wireless/ti/wlcore/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 0c77b8524160d..98c830b665e38 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2612,13 +2612,13 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 	if (test_bit(WL1271_FLAG_RECOVERY_IN_PROGRESS, &wl->flags) ||
 	    test_bit(WLVIF_FLAG_INITIALIZED, &wlvif->flags)) {
 		ret = -EBUSY;
-		goto out;
+		goto out_unlock;
 	}
 
 
 	ret = wl12xx_init_vif_data(wl, vif);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 
 	wlvif->wl = wl;
 	role_type = wl12xx_get_role_type(wl, wlvif);
@@ -2629,7 +2629,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 
 	ret = wlcore_allocate_hw_queue_base(wl, wlvif);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 
 	/*
 	 * TODO: after the nvs issue will be solved, move this block
@@ -2644,7 +2644,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 
 		ret = wl12xx_init_fw(wl);
 		if (ret < 0)
-			goto out;
+			goto out_unlock;
 	}
 
 	/*
-- 
2.39.2


