Return-Path: <linux-wireless+bounces-27788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545CEBB51A9
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D9D423A73
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753DB296BDE;
	Thu,  2 Oct 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="r1QefwUO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518A27A904;
	Thu,  2 Oct 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435768; cv=none; b=BJChsGbz3IbzOLeb3mIaDZ/8kkCIIxBGObl11E8WktkGfl1crNUE0k1bRIccvTzKoSk4GKMMlkLaCHCnoCS5ez0VJudn6WzrRjRRqEtwgzrwoncX/ffGMT3Slieg9UreLPglv/M9Xavl7eRAn4P2ogd4KttIFq7Q2J2e66a9vWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435768; c=relaxed/simple;
	bh=Rmj2sgA5CekdHAHknJfKqQC1LMlQZq/QRpUSbyFFRYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YezByaSY/j/VUH66yXfuv+oYe4BUPAjjq+2P2KOMmeFON1y7msmBnRiqvqPEbm8iuQbvUBnhL1BJZ0dMxlihURoJh+g25N0ftjZZCshAFAk8WUhlzTl8QwzE3AS71i3pXiSWY7/EC7P/wdZ5O4nnRwPyjlFX19KIzqR8dlWRpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=r1QefwUO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 31CAF40762EC;
	Thu,  2 Oct 2025 20:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 31CAF40762EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435758;
	bh=91TWc3inH30K3Fo86B486YT7zZg8JTJp9Q43ZuDHyqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1QefwUOM8L3iOEDQzPhogDHrBOAqj+iB6MQsK4KSv+1V8voyJGBPi1SzB+4TE1tH
	 uc1mDbmU9rgeYvIyBgeFqR54Se4qgaPLZATApVKW1Tqv8B8ZoW/474cuBxJY6+LkF/
	 U2wLJEaz+UB5iYEHIX5VSLRkdnKK+d8a+9akg+nw=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 3/7] wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
Date: Thu,  2 Oct 2025 23:08:48 +0300
Message-ID: <20251002200857.657747-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002200857.657747-1-pchelkin@ispras.ru>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
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


