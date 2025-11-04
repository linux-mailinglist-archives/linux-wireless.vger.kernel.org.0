Return-Path: <linux-wireless+bounces-28535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A0C31574
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 14:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899BE1887CE3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796B32AAA0;
	Tue,  4 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KxhSQZ39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDB328B54;
	Tue,  4 Nov 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264673; cv=none; b=J90RcbB2FcA8iKm2TJuOvaAHRP93pz6lF/y6jEwvRUj90YDm2wmI8ub2uIxyl26cQqVN79G9b8lACcIgmMPgHmnxxL50eLOGxWBwCyek7RgTnSdFfFEnvaY40DLyDPMcY3Xxm1MZMTan40yRUKDEQ/osx+XseQbHgLSB4LR3EgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264673; c=relaxed/simple;
	bh=b3Vpd1OyZZ9Cowg/dLMJHD1l34hV7HUjt5ifMnlse14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2yrwEtSQ3B5CZ52iBUnf9+I4M9QFbFEk+wtRhOJbqNLtB8c7h5JyGSkr1fI9p9XNQZ+vKHNxcDm+KCUMltp6dRC2TpJ+h0SDWq+hObC6yVoqNUyLDAHUj+8OYmzW8IIaxUeoWYCI5jSLiE71PhuxyYesDdQYsow06+qp2R6Jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KxhSQZ39; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 672DF40777B0;
	Tue,  4 Nov 2025 13:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 672DF40777B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264663;
	bh=m0YoMoNeXKgR18trKy8kaciDqdWIF3M6iUGwA99dDZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxhSQZ39MrOyDso/2O1y0J3dql+py78y5UDaoElj/xOaMLXfXa2Feu0mF7HCHv501
	 LT8Qa4xe4f5tr34HKAP9wkF6o9lM0t6JOsr6s2FNFXtICqJSrLr8kPNNQlTGUYwT8e
	 SCBYXS0HEXaGr+2ws0bY8KjBTEqlEhcliCo+KvhI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 03/10] wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
Date: Tue,  4 Nov 2025 16:57:10 +0300
Message-ID: <20251104135720.321110-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89_usb_ops_tx_kick_off() may need to release skb if a failure occurs.
It operates mainly on skbs coming from the core wireless stack and the
ones containing firmware commands.

Use ieee80211_free_txskb() for the former case.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 639b84ebe942..59cdee54feef 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -258,6 +258,15 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	return ret;
 }
 
+static void rtw89_usb_tx_free_skb(struct rtw89_dev *rtwdev, u8 txch,
+				  struct sk_buff *skb)
+{
+	if (txch == RTW89_TXCH_CH12)
+		dev_kfree_skb_any(skb);
+	else
+		ieee80211_free_txskb(rtwdev->hw, skb);
+}
+
 static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
@@ -272,7 +281,7 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 		txcb = kmalloc(sizeof(*txcb), GFP_ATOMIC);
 		if (!txcb) {
-			dev_kfree_skb_any(skb);
+			rtw89_usb_tx_free_skb(rtwdev, txch, skb);
 			continue;
 		}
 
@@ -291,7 +300,7 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 			skb_dequeue(&txcb->tx_ack_queue);
 			kfree(txcb);
-			dev_kfree_skb_any(skb);
+			rtw89_usb_tx_free_skb(rtwdev, txch, skb);
 		}
 	}
 }
-- 
2.51.0


