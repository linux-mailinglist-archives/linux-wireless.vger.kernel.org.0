Return-Path: <linux-wireless+bounces-2893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B501C844364
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A94C1F25BE1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE912BEAF;
	Wed, 31 Jan 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAjrJ4Eh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA912AAF3
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716158; cv=none; b=mYhDowTB86qV8CiIXZ4nLMIGybvQ9YBK6ix4z1HTqGiIhJRYz65oCrXV7mjvaxLCYu5nty9knC5Is6PCfw27AhnVgjGTJY+Ahdtvp8VuJNgx75MJgRe8rTM6Scg6zPau23IERGVsIW3V/ku3C2i2/KLpX7jEdAJGME/gPCp226s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716158; c=relaxed/simple;
	bh=l8VkQeiKug/L7jNus8NvW7gkJyItBTlW37bVno0m0xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5zYeeyJ1zTVOZqzaxCiWcxc5UuMbmpYgPSoXNIMMfyjZhLR2Z3FAtJOzC+fnWe40+ZrFYPw8RK3ff/paORqvKiRcPeW/aHlVtDp+Y5MLj4N63BEnB1OInLtbWNEEwS4b8p3SXa+7rAKsgyGnDmUdsWCLyJ45VgpFD8PcF0fczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SAjrJ4Eh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ujA/OOWj/HT0MccQRJvV7GwmEzoXdUuYfpobrVNiVko=;
	t=1706716156; x=1707925756; b=SAjrJ4EhHF/Kd78C3a3gwmPM78ndz3EhXwormrTzKlzoUZm
	cMphXKF0jmrOrYcyG96Aip+uDXR50pJ8u+QXJgS0h8d/kRJ5KDpQQ/YqvFCEOfpyRTAvAUw8uw0sc
	bDmHgvRvZbvYjT6IW2ssv6J2Aqy2LZbrbqePQqJSNsgDzZHVVH7nQdYLFOjnTGt9dYF4d6Nyg5i14
	msYLvp65h5YAPgOjULACMOfKdw2Xf9oJhZKK3dGHUaOZCC+4YFXFpb+rWUOScGpMhWFXIloYJa6VK
	3+v/zzev7gvl2ZY//3iVeNLDuWdgt6mOmgP9inowtA9e3uAXtB5KY702piIX84Rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCpt-00000007JCD-3J2U;
	Wed, 31 Jan 2024 16:49:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: clarify vif handling in TX dequeue
Date: Wed, 31 Jan 2024 16:49:11 +0100
Message-ID: <20240131164910.60066625a239.Idfb6a5a9876f9f631eae760055e1c4018259a971@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131164910.b54c28d583bc.I29450cec84ea6773cff5d9c16ff92b836c331471@changeid>
References: <20240131164910.b54c28d583bc.I29450cec84ea6773cff5d9c16ff92b836c331471@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The vif pointer at least looks like it can actually be NULL
in some cases such as the monitor-mode vif, causing static
checkers to complain with the immediate derefence. In these
cases the sta pointer will also be NULL, but clarify it in
the code anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c2e4ef327377..c3e67e40dc9a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3954,7 +3954,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			ieee80211_free_txskb(&local->hw, skb);
 			goto begin;
 		} else {
-			vif = NULL;
+			info->control.vif = NULL;
+			return skb;
 		}
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
-- 
2.43.0


