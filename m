Return-Path: <linux-wireless+bounces-30459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 164EBCFDFB5
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C451A3005017
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A833ADB5;
	Wed,  7 Jan 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mnwqbA5j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAF24397A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793027; cv=none; b=XdYl9rKqQzUFesehRYWHkNqt9FnJG4IAgB471Pp2Cy1Kn0xEdXqplWb4tlUv3O9pU2ZlTuXD4pV8WMWdk0Gz4ZwdnkQt6i9dwBMGzSA0HLf8HNkYa8953SFWrQCbn7ImmFCeBgZYOzGOJImbB5SpCVSvCsU1eshe9QjdY4k1xIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793027; c=relaxed/simple;
	bh=lfTCH2LriGQaKGt6Po5wf6Btnfuk1JVHrLW6vOzUXPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8xUMTbJeblF2aH/0xpkOWdVrGgwRVGmdrVdl3JUgybbNMZ6FA+lAHQB8QvVZkF3jQXQfs09A7Q6qBrUBngYQpIKN9xEC8uDSZcQWgNho5dvEkkqjYjVlx9hzkAfTfwbNVyDYbGyYZ/u9nR0E8v+A319IMjjVS1J8Nm4tExKvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mnwqbA5j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rk3qcSmktANrKc0HxOmaUAadhJQEtsFnnuDubsEiScU=; t=1767793025; x=1769002625; 
	b=mnwqbA5j/6QNQqEpgszErRHH6s2SQPZ1qurxle+X7jCUk9iu8QlXDSOUEIqjxkgZl+v/sXNKaIW
	ARWgf9So8sMEd17qK7fcaEqx9xFbkAuCZm3E25WxKJ4S1QUU6/t2kmX8Mwym2hTrWBskKeIXWr3Le
	KfRDmxG4ka5qZwA/k+kXxlw3cT/9JXjFrSqjTXbJ0KrPViFiWQe4mBiGftfMCaBMnK2j6iJmPKtJR
	U5T+lIb/p1+23vDyscHzvVCQz7tKie7pRQ+pGlnyBbUE687LvtEDIeCZbLl1mUXUTUkClfKt524YQ
	G+qF9zcFO4k1gy+dHTledXDugq7IGF71vJog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdTia-00000005ZRC-2wxh;
	Wed, 07 Jan 2026 14:36:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: mac80211_hwsim: fix typo in frequency notification
Date: Wed,  7 Jan 2026 14:36:51 +0100
Message-ID: <20260107143652.7dab2035836f.Iacbaf7bb94ed5c14a0928a625827e4137d8bfede@changeid>
X-Mailer: git-send-email 2.52.0
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
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
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
2.52.0


