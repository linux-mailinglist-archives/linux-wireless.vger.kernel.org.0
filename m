Return-Path: <linux-wireless+bounces-1233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B013C81C7FB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B222282023
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E21803D;
	Fri, 22 Dec 2023 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6KodoXu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPTjKGap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FA171C7
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYFdViIjlESDzhteIs2oPwA/vKJ2vfKkn8h4MvsolD4=;
	b=P6KodoXujd1biP+pP+6JDahTOv/Bcf4ThZO0r3KZ03e8SgWNU47SK6Vsj8PgWLYXo2vqig
	+QKNxNqO9OG4i17DfjaiMfg8VI7ODRJFXvqJxbn3+LuBjyXCp1yeTVXOA3yZrkgfCp2hlX
	dJF9NH+l9pbVyF+15KyKrzqAEEBQOMqVDqBDJXwJCql3UjGX6CwlblRPWOufqOW53XSNT9
	K+ReEJG445DO3W+DewA8HVCv8u2UiqELViGZNzJbiyFNFB0jWubplF97sKdTZuiJ6hhK0k
	7GGwZW0nDsshTWqq5tqr8MxajBzlqmikn4f35YrApSZxHU4G588E0DMORPV0gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYFdViIjlESDzhteIs2oPwA/vKJ2vfKkn8h4MvsolD4=;
	b=rPTjKGapPWDk7VyN52qh6qYbd+3K4W9Uj26/Q2iB5e0N8uMwiDR/DK5OvOGShKkwyRGqC1
	/3PSc1i+ht7R9CAw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 11/21] wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
Date: Fri, 22 Dec 2023 11:14:32 +0100
Message-Id: <20231222101442.626837-12-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we only want to support AP mode/sending beacons on port 0, it is
enough to replace priv->vif with priv->vifs[0].

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 99fe567e0f75b..680dffb9657e1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5712,7 +5712,7 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 	struct rtl8xxxu_priv *priv =
 		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
 	struct ieee80211_hw *hw = priv->hw;
-	struct ieee80211_vif *vif = priv->vif;
+	struct ieee80211_vif *vif = priv->vifs[0];
 
 	if (!vif) {
 		WARN_ONCE(true, "no vif to update beacon\n");
-- 
2.39.2


