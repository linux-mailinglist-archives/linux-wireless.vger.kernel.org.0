Return-Path: <linux-wireless+bounces-22504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F00AAA296
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443B71885E62
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8D2DCB71;
	Mon,  5 May 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ8i52qx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4A2DCB6C;
	Mon,  5 May 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483708; cv=none; b=BQ1ZVsFKJxOKhMh1e/pbqMOy5SPWly6ROYda5nvmUdtPTVgWbEixC/yYcIjgtdg3MEA1p2IeZmIc5mB2L4uKYCg2TdrWe/KueGzea6yBC8srdZsjN+sJhzWiLBkIOo6BJ9+6v6qXy0xctWIbJTaM6so0WbXI32pjEP3J4ZjfQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483708; c=relaxed/simple;
	bh=ONwpip4q/dGroCpoWoHEDiYYoN7PMqutsUsTghmh8yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDGHdCUVn8F18mLABYAYZ9yTRYN/8LYs0UkwdEjMP0F582wluPdk//dso2WJECrTLJAvIkzFIdtklWJrEYO0f8nJhN1pAx1sP6yYQzQ9kPKuPGmPOcLr0X/M1Vh64+KXBUGvFTNxpDXph4/Af8DB5jgW4rCbw4w9ziVMn/BkBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ8i52qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A9DC4CEEE;
	Mon,  5 May 2025 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483708;
	bh=ONwpip4q/dGroCpoWoHEDiYYoN7PMqutsUsTghmh8yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ8i52qxkuGbpaPR6WMVihhf6PvtYewUqgIGFmZGFYIDfWoU4P8waJJ+SiGRmzNFv
	 o6E3jAVM/ar78dMWcg9UU0BxXmVZW752/OGn8vs8iP/LfYLM2135LeiTEgmoNrvxLg
	 W4BXo+hWZGSH7zRPHH7QIYwLRFwnXGtzvjFh4PRO1hy+lS7+uqkZjuuL+GlK8jk3/f
	 nFP+YYAWuav+v68bX/rxtuXFNnVu0nPOh5tJLDqCzcKjt0uZQBGZGQA4ZLCurerBQx
	 8VlJCAsBohvKZTDu2zxufsnMgxE4E27yQEdXo/2826qAmhWxaZ6ptQjzjgXylJkALO
	 ktYn3qW4tjbuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 190/642] wifi: mac80211: fix U-APSD check in ML reconfiguration
Date: Mon,  5 May 2025 18:06:46 -0400
Message-Id: <20250505221419.2672473-190-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 7a6a740be17e049a2742c76bb1dadb3d78c930d9 ]

If U-APSD isn't enabled by us, then IEEE80211_STA_UAPSD_ENABLED
won't be set, but the AP can still support it in that case. Only
require U-APSD from the AP if we enabled it, don't require it to
be disabled on the AP if we didn't.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.b4674be12a38.I01959e448c6a2a3e8bc5d561bbae9e8d2cca616a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad90803d17cd1..b179aa7b6470b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10216,12 +10216,11 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		/* Require U-APSD support to be similar to the current valid
-		 * links
-		 */
-		if (uapsd_supported !=
-		    !!(sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED)) {
+		/* Require U-APSD support if we enabled it */
+		if (sdata->u.mgd.flags & IEEE80211_STA_UAPSD_ENABLED &&
+		    !uapsd_supported) {
 			err = -EINVAL;
+			sdata_info(sdata, "U-APSD on but not available on (all) new links\n");
 			goto err_free;
 		}
 
-- 
2.39.5


