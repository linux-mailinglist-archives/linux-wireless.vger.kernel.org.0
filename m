Return-Path: <linux-wireless+bounces-28025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DBBE7F26
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D972D4E4360
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4031197A;
	Fri, 17 Oct 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="a1m41BWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C722DC76B;
	Fri, 17 Oct 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695636; cv=none; b=tQaLPTu/NnE+JHMh1JaBAhEnfKXpw9HfGzgGHJn8uT7lfvCqiD6uSZ+TpE6M082yueilpJ2oP/Zeo9xInR804hTWqZQ35gfVFhxZuaHFVxXjhiRMTmGGorDKkm6T19Y/tQevEbVOoIWedI7A1A7be51kCGgW3HaGiuWS58USxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695636; c=relaxed/simple;
	bh=pepThzItzB66OUIAE60s5WbHafcFvSVQ8IBsvWtAy8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpWU639+FGOgEEfLd1V4pyEvOTGQ0NJQOZVT7XZXGQePy//CtGAP3sHM7FuCwWT0k4DHs0wy52M6pnbUO96EIlRH8pZVNfOpoOzud6Jjo1jZh1mI6YXqKXJCSpQbK20MkszY0vDhfj8JT7imPgrvOED4/VZRydmWGzUFmbFyCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=a1m41BWs; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id BDA6B4076734;
	Fri, 17 Oct 2025 10:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BDA6B4076734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695631;
	bh=PaDhYOYsfYv+tRgCgfeaZvUwgrspyb4z/urASnlvps4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1m41BWsuH4CzlcDyQYG+oTuVdOB4T3faUIEWbmi8hlwL2eWfnidR3OFVZhNkltVp
	 OgdlEPPnFiM1ji/iaxo/MVH4iou0mu95k6qB0QGXe46cA1sygFI0h8if3yo3ElK9aC
	 RSxIDIqbKLpwKtfxO6NYnMKeyima7+XcZioqYmis=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 3/9] wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
Date: Fri, 17 Oct 2025 13:03:05 +0300
Message-ID: <20251017100658.66581-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017100658.66581-1-pchelkin@ispras.ru>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
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
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 512a46dd9d06..655e8437d62e 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -278,6 +278,15 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
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
@@ -292,7 +301,7 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 		txcb = kmalloc(sizeof(*txcb), GFP_ATOMIC);
 		if (!txcb) {
-			dev_kfree_skb_any(skb);
+			rtw89_usb_tx_free_skb(rtwdev, txch, skb);
 			continue;
 		}
 
@@ -311,7 +320,7 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 
 			skb_dequeue(&txcb->tx_ack_queue);
 			kfree(txcb);
-			dev_kfree_skb_any(skb);
+			rtw89_usb_tx_free_skb(rtwdev, txch, skb);
 		}
 	}
 }
-- 
2.51.0


