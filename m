Return-Path: <linux-wireless+bounces-922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4E8173CA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2201C24266
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2B101DB;
	Mon, 18 Dec 2023 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8lZ4mbN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfx4H69t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE223A1B8
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVbpg6g5sTl9EWm/5/FJyu5zvMqtzxnjXlgvdAKUlh0=;
	b=Y8lZ4mbNBHVoHG5hhTTIgW4j2wXwOJmcb4x4mxq9V1YIrKwPNL6NleUTNRTA3WmbHMbKPz
	OkLTitBpQJ57GLv4Qj7GqIF0MSg8fTOL6+AGx27BJroXRkPKMk+pJM7XcwjEvM32VjQB84
	V0mtDhdxbwVAlMFdC9pbjmCa5Y2XuJ/C4EGNJ32eCC8/QYjCLy8XNS5kliFQBkWnhcXMDs
	821wsllUsHZtNQa0/oFr5tL5mhUPJsD+3zDn6h3JpF5uzz38Pz2AkjOljdlvXZzNCInC3+
	1bw3UCFQMOl6kwL41nqGL1W6TDq333s5+ET59oScAh/koXbHr1P/FG1z4CFXRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVbpg6g5sTl9EWm/5/FJyu5zvMqtzxnjXlgvdAKUlh0=;
	b=vfx4H69tLT7wX5GKEVqEVjRFs7MW+q3w50ndSYLTfAeCGe0Elk0Tvmls5vWAeKLfUhyh3q
	Pe+vYmLMGT+0U+Dg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/20] wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
Date: Mon, 18 Dec 2023 15:36:35 +0100
Message-Id: <20231218143645.433356-11-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
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
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 827e715f0e585..6683ff0f4d8c7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5710,7 +5710,7 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 	struct rtl8xxxu_priv *priv =
 		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
 	struct ieee80211_hw *hw = priv->hw;
-	struct ieee80211_vif *vif = priv->vif;
+	struct ieee80211_vif *vif = priv->vifs[0];
 
 	if (!vif) {
 		WARN_ONCE(true, "no vif to update beacon\n");
-- 
2.39.2


