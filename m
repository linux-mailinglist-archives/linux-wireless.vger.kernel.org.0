Return-Path: <linux-wireless+bounces-29402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FDC924FB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26F94E6C22
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156F330333;
	Fri, 28 Nov 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OGhchyhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9E33032C
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339668; cv=none; b=hBfKShaAequu2ueYp11s19FuYvkjStWDvPYNWrzWeO7Szg6/A2Vltu9nLk+mTgngXAVQ9EIyCOxiGyNdqfSKX0tWfwwgBQifLjiVmzmVndJrcmFgyS0tZMtX+Qy5f1bH/5R5ulLWZ7jQu9tqSfHo6Y7WB9eWZ/CVZMtDwMoyHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339668; c=relaxed/simple;
	bh=VgZYZg98wZfbvi2z1mzn+HZZ0M5yO24rTR9t7CifE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0f0KaoGUzvoiRlSH+7yjIMUHMMI611moOoOsMKaRRbewGt+Vizc5qK6Uc2OwfJJurHuAGvm7UrG/vrjROVzMbkYPgazAZgUHz3wJKMJNtp/wxAkMTWem7wAPYHXvVBiar7Q4CgM7nOZW2xVpuwbK4GorpV1LxU1GM80M2tQGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OGhchyhg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2aOPbggWmVJswkDOCgdJKZNoh/Y7cNfTTK4PUQ978tk=;
	t=1764339666; x=1765549266; b=OGhchyhgml9/kqwt224yEXqYQoWAfo1a+CBCFtKayOIXY54
	GJWN+rJ+Pnlq/bXTss4nXC+JJQSX4R7ILCLbCQwEqjWzWS8A1OtXMViYiBfg0CeODmGxGLLRT4bqw
	FFOIIzP3IKb69FKzHu/gk21h4acBQFBAb41McYnW2L0ow8nI6PPYXc5QMJoRCfTMTgZ9Tzo6IZ6XA
	y2qAe4+E1rNGYRL+5wO6VZdNLjg4lNMEJcJ9dxxoXV0RFMAHYn22QUtyBbDWHvUfy+dgT70VUlUEq
	MOivZMuay4reQKAE/c2SE6JKqthlGy1PTvt/Td8xo/Wy0q3DGW4YVMN8ojGOB5Gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLE-00000003926-1d6G;
	Fri, 28 Nov 2025 15:20:56 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 01/18] wifi: mac80211_hwsim: fix typo in frequency notification
Date: Fri, 28 Nov 2025 15:15:39 +0100
Message-ID: <20251128151537.e63b63d8aa44.Iacbaf7bb94ed5c14a0928a625827e4137d8bfede@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The NAN notification is for 5745 MHz which corresponds to channel 149
and not 5475 which is not actually a valid channel. This could result in
a NULL pointer dereference in cfg80211_next_nan_dw_notif.

Fixes: a37a6f54439b ("wifi: mac80211_hwsim: Add simulation support for NAN device")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..92427f527286 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4040,7 +4040,7 @@ mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
 			ieee80211_vif_to_wdev(data->nan_device_vif);
 
 		if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
-			ch = ieee80211_get_channel(hw->wiphy, 5475);
+			ch = ieee80211_get_channel(hw->wiphy, 5745);
 		else
 			ch = ieee80211_get_channel(hw->wiphy, 2437);
 
-- 
2.51.1


