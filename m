Return-Path: <linux-wireless+bounces-26838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE0B3AC8D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C26D987C41
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152329D292;
	Thu, 28 Aug 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nN3Ad0N7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78870285042;
	Thu, 28 Aug 2025 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415585; cv=none; b=ttzHgnGrra0wImMKxKTp0CMldFu6SjLubHyKZqSB5TtlM4akWumnoOdIng1V6bTgbeoagDRIpK0AaPlD0X/hzNC0dMkIkPjnngeEkXEgJR5d1BayrZpv96UP8HmSlf6GkmdVSH5sMjQS9xSr1hO6ovji/LZqlENHgXKskvbbdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415585; c=relaxed/simple;
	bh=OniFXwUoe0W1imxggrHBCJ+gM8p7r7MshdAC5zJdL6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCmfPXY3FTK1p6wrEZfiBAKITmSxJxn2M+/ZHfnwZM1C+Yj0Acwy3qeHKkTcrN5lvLEsPvuyH8Gpd2b/eceGpns7Y3tYwgc/XJhMVAtfV2rL3yUfLsoqT0fjhNardZ3WiTCcNJyIN7W7pqQiC9GYgp0vN/8fb4zmzR5SwpmIRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nN3Ad0N7; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9FDE7406C3E5;
	Thu, 28 Aug 2025 21:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9FDE7406C3E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756415580;
	bh=Fi+20ZQtwM9nr6ht2ES5Nn9HSbIxe3ub+nRRgUmKr7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nN3Ad0N7YpVVNuIB4tmT2VnLZZOFPcCkSeLij/WYFUbJnoaHpcHp+3+iEgM8LfNrP
	 JSlldIb8khNVJWIQsCD4SqwniRGgbfvXt4gecBaDUAOguf3qn1mr2Rc1w9SO7K1dvK
	 gTaEDAyEKWdv9Qg405Kpsv8lnOj30Sz2o7i/du7M=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v3 3/5] wifi: rtw89: perform tx_wait completions for USB part
Date: Fri, 29 Aug 2025 00:11:59 +0300
Message-ID: <20250828211245.178843-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828211245.178843-1-pchelkin@ispras.ru>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no completion signaling for tx_wait skbs on USB part. This means
rtw89_core_tx_kick_off_and_wait() always returns with a timeout.

Moreover, recent rework of tx_wait objects lifecycle handling made the
driver be responsible for freeing the associated skbs, not the core
ieee80211 stack. Lack of completion signaling would cause those objects
being kept in driver internal tx_waits queue until rtw89_hci_reset()
occurs, and then a double free would happen.

Extract TX status handling into a separate function, like its
rtw89_pci_tx_status() counterpart. Signal completion from there.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

New series iteration -> new nuances found.

It seems the two previous patches from the series would not be too great
in USB case because there is no completion signaling for tx_wait skbs
there.

I don't have this hardware so *the patch is compile tested only*. It'd
be nice if someone gave it a run on top of two previous patches of the
series, thanks!

 drivers/net/wireless/realtek/rtw89/usb.c | 36 +++++++++++++++---------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..10fe19bd5166 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -188,11 +188,32 @@ static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
 	}
 }
 
+static void rtw89_usb_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+				int status)
+{
+	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
+	struct ieee80211_tx_info *info;
+
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, status == 0))
+		return;
+
+	info = IEEE80211_SKB_CB(skb);
+	ieee80211_tx_info_clear_status(info);
+
+	if (status == 0) {
+		if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+		else
+			info->flags |= IEEE80211_TX_STAT_ACK;
+	}
+
+	ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+}
+
 static void rtw89_usb_write_port_complete(struct urb *urb)
 {
 	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
 	struct rtw89_dev *rtwdev = txcb->rtwdev;
-	struct ieee80211_tx_info *info;
 	struct rtw89_txwd_body *txdesc;
 	struct sk_buff *skb;
 	u32 txdesc_size;
@@ -214,18 +235,7 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 			txdesc_size += rtwdev->chip->txwd_info_size;
 
 		skb_pull(skb, txdesc_size);
-
-		info = IEEE80211_SKB_CB(skb);
-		ieee80211_tx_info_clear_status(info);
-
-		if (urb->status == 0) {
-			if (info->flags & IEEE80211_TX_CTL_NO_ACK)
-				info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
-			else
-				info->flags |= IEEE80211_TX_STAT_ACK;
-		}
-
-		ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+		rtw89_usb_tx_status(rtwdev, skb, urb->status);
 	}
 
 	switch (urb->status) {
-- 
2.51.0


