Return-Path: <linux-wireless+bounces-25093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D1AFE8A7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810137B0C03
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2B1DFFD;
	Wed,  9 Jul 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IGWVPD5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hj9IoDx5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A918E3F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063331; cv=none; b=D1AZkCQ2iA2kbjj+ojjatyrwRtqUL4cIQCGXe1zK+OEGKwouyJTukBZgYAWuiY0vYSB7RpdlP9RHOomirI1jBMohV61kp22Rrr8mZNJYgCHArqgpz58EupmEOUFrHs0GbMBaGkmwVIE4xi3rIjZxRbcFZf74nHw0DxibarZhd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063331; c=relaxed/simple;
	bh=MebP8y/UxHWdGQbm3+N0noAIuotCe2jVmld+36qsm9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nC1Q6NO/UkqHLzWj0CVcHruROPY+2LwDEQzXq6HuARieca/RP1OxTP2++3sDlCdwHCHYb38hjs5w64VYTYtteohjpcgVxoLT5YmBPx1+Nszqd2dAXCEzv5wKtTTc/8+jAmSlEgNeHwJJC1rrAtMyh/En6wnW7wuFVZwdBzdsAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IGWVPD5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hj9IoDx5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752063328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTfI6tt/TZyyFVfuuqVoL5nAVhY/MbvpGkDFusyxV0c=;
	b=4IGWVPD5flYqqZhFxafRICEUDTctNiQUAtJxCO4DLKNQxuHadndtBYBqoPs3lJrNxr2TwL
	jkkZStPG797tpa55MELjcCfYlP44eBSzQChz+/ujchAMKEJz/FJHjd6rI6n061kTem0ZTA
	ZWVKJ4bPVgEeSgTTWVWKPZhcBuJtNGVTujMhgyYbP5t2dYnQoym9BTMJMlWLBNA9hj4Dgz
	fTGrDqMetauXAFGGs94rDBOAHg3p0nW4TS3SidriCJtguUinGVRcqcIZLXb5QVJ5Jx9w5f
	FSLp0/UdgN327nG1j4iAVxHeNoMOjJThcIXfWvUEjbmFZ3SuorhjVtNGoBXAMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752063328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTfI6tt/TZyyFVfuuqVoL5nAVhY/MbvpGkDFusyxV0c=;
	b=hj9IoDx5+QJY0ElMVMVAtSogQmUZpBikU5KCFh6Td9PiQZ4npG4PymODqG8Gf/3HigOiBr
	lHZAMiLOFfOpF9Cw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix RX skb size for aggregation disabled
Date: Wed,  9 Jul 2025 14:15:22 +0200
Message-Id: <20250709121522.1992366-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for
phystats") increased the skb size when aggregation is enabled but decreased
it for the aggregation disabled case.

As a result, if a frame near the maximum size is received,
rtl8xxxu_rx_complete() is called with status -EOVERFLOW and then the
driver starts to malfunction and no further communication is possible.

Restore the skb size in the aggregation disabled case.

Fixes: 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for phystats")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 496836f716aa1..f6f169d2062d9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6618,7 +6618,7 @@ static int rtl8xxxu_submit_rx_urb(struct rtl8xxxu_priv *priv,
 		skb_size = fops->rx_agg_buf_size;
 		skb_size += (rx_desc_sz + sizeof(struct rtl8723au_phy_stats));
 	} else {
-		skb_size = IEEE80211_MAX_FRAME_LEN;
+		skb_size = IEEE80211_MAX_FRAME_LEN + rx_desc_sz;
 	}
 
 	skb = __netdev_alloc_skb(NULL, skb_size, GFP_KERNEL);
-- 
2.39.5


