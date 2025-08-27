Return-Path: <linux-wireless+bounces-26696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE5B381EA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC2A1B27E4E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6430100B;
	Wed, 27 Aug 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="D2IN175S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606C2765D6;
	Wed, 27 Aug 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296405; cv=none; b=KaLXe2x+MDzFEp3qADg6SbpQn+6ByTxKjt7Ujw9IrndjoWPcECFn+wlrKylwxrT3aEGAks5h8TZ997EPMd8W5KIsdwbhO34ccquotEEatkRuP64xDZ0gWBWoLSydIgICA4ClqTLiIcfpvGG9CxfchXFuu0XNYCQ49mFd3LiaCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296405; c=relaxed/simple;
	bh=r3bwLk4B6xy2ftAAUnk1Z9Kh2yH+/XnuGMv5Z+g4s7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATXEqgVTur/UdJcoObmUfJk3fsPZzpusTVTTpvkdndk+jMOHymS3yJKb7yAEpCSN3mehEGee1yPv+WFfOC7MEmG2l/ffkKLnq4MM4bsLCf/CAWQg+oMuP4KPLV1dCtW4CzP1VlZwwJ3dNQrHRTURfJlchiX8vju/ZeTLdKLara4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=D2IN175S; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1147C406C3E1;
	Wed, 27 Aug 2025 12:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1147C406C3E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756296401;
	bh=x5NAugXlcutAqdPDV5Vn4Ip5GFUHeDytp7QlYPTrJ/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2IN175SNc2Hkhy34u4NJPiy5TpqtlnC6fb/lCQOCf19iET5ygw19QQatvFvNi8js
	 yFjPCDMY0sBKyH8f81HCVvnCglFfpIm/fPukzJQtCgrzTGyJyWYGOLUwKtq1Rde0Yc
	 Apu1yayP91L90jAsTMYsljpYBJhrRVjtpieO6z2I=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v2 3/4] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Date: Wed, 27 Aug 2025 15:05:16 +0300
Message-ID: <20250827120603.723548-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827120603.723548-1-pchelkin@ispras.ru>
References: <20250827120603.723548-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no rtwsta_link found in rtw89_core_send_nullfunc(), allocated
skb is leaked.  Free it on the error handling path.

Found by Linux Verification Center (linuxtesting.org).

Fixes: a8ba4acab7db ("wifi: rtw89: send nullfunc based on the given link")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 28bbc898b95e..e498c08151d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3454,14 +3454,14 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!sta) {
 		ret = -EINVAL;
-		goto out;
+		goto out_unlock;
 	}
 	rtwsta = sta_to_rtwsta(sta);
 
 	skb = ieee80211_nullfunc_get(rtwdev->hw, vif, link_id, qos);
 	if (!skb) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_unlock;
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
@@ -3471,22 +3471,23 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	rtwsta_link = rtwsta->links[rtwvif_link->link_id];
 	if (unlikely(!rtwsta_link)) {
 		ret = -ENOLINK;
-		goto out;
+		goto out_free_skb;
 	}
 
 	ret = rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, &qsel, true,
 				       wait);
 	if (ret) {
 		rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret);
-		dev_kfree_skb_any(skb);
-		goto out;
+		goto out_free_skb;
 	}
 
 	rcu_read_unlock();
 
 	return rtw89_core_tx_kick_off_and_wait(rtwdev, skb, qsel,
 					       timeout);
-out:
+out_free_skb:
+	dev_kfree_skb_any(skb);
+out_unlock:
 	rcu_read_unlock();
 	kfree(wait);
 
-- 
2.50.1


