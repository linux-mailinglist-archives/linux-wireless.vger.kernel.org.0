Return-Path: <linux-wireless+bounces-28377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08888C1CE12
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B60C1A22754
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C83590BE;
	Wed, 29 Oct 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="si0mvWm0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69C2F12CC;
	Wed, 29 Oct 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764582; cv=none; b=qt7gbqLD+fTses/HKrU+En4mi/UR2BHO3T/qTH0JbgVwMu21hk7J+IIrrN/k4WoKnhe2J+RavqkDvUZ/X3NOVFUD9xtMy2bp2qsj0tTmgOKtpCby3OMqwan7KM0rnVBCFo3XjsiAdOVvtc8zl9P83iA8r2M6Yp4grM6t54NeFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764582; c=relaxed/simple;
	bh=m1ThU6s/OuTsfPXh0aCqXOqnYksqYIpXdR+yR8bMpS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjj6uD9Ksd/jMkiKiGGtflA7yySggHftxFDmCfkY4bYXwxjN7JxwpizU1cjUDkKpMhDjEFHP0pneWUJWiMTCXvxmV+z4RJkByrYTRFSdtiZf1GNK/7Q4mAwYT9SGOCRbU+hkC0YgTInKkOlb0xRwD8fHLsr4RdRyHRAosZ8BQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=si0mvWm0; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id E970040777A3;
	Wed, 29 Oct 2025 19:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E970040777A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764579;
	bh=8jiWoBq2G+KYWCFKuOBzxu0i0MoFGVrc86YGBUTtZb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=si0mvWm02txeDnjF2v3nO5P9NTgZ4CjDskBXw5QAzVzq/EIfYV5ucJhoA6sOCtvMP
	 tfVVmf+Y+WSOx7g7NzkX3QeKd2ywFeelE0EUmIqhpbNXTIGoyTRLKvD5oJOsUxQimi
	 zfcPmJHE/ADFYT6RRJW5QRzqP8FWJxnVfJOXz4AM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 03/10] wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
Date: Wed, 29 Oct 2025 22:02:31 +0300
Message-ID: <20251029190241.1023856-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029190241.1023856-1-pchelkin@ispras.ru>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
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
index 1d9760e5eae7..93dc4e91c1d4 100644
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


