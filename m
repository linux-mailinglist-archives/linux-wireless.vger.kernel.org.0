Return-Path: <linux-wireless+bounces-7001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC68B60D5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4921F20F26
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768A126F0A;
	Mon, 29 Apr 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibXU8cZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A571727
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413477; cv=none; b=ZO2U4EcB19McyJ6wbnp4W62aPBqs4bm2UivfU3FiNARwmyE+zH8oe4FVTHSR8svy2AKEwN2NzsTHY/cMLOjJVT7pNUPkHn2bdwIFncwA5d5WEXFo+whNlLfMcKLFE9RbhVqO0Rc4g1zZs/U0JaQ9D8pJIIYBtQptAiRbLL6B3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413477; c=relaxed/simple;
	bh=1vpui76ReUU+ZNOMGsNcUKgtm7jtNOXDU+JTxeE9GDE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ROJbygN2G1Gg0FdjD4OTv4ADntPbdZ8sFHgwtvH9aPQ01X7Y5uCnDzUTUuyIC4fAAfqY8R93m+GX8IbbV2Tq+6vgpd8kW8MmWpL+C6HI8HG9pQWAmOfqYQNzvb4ci1bt9Ftg4oj5n8wa749oRdjgnkyWWG6ww5REH6khDu/0AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibXU8cZY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d1ede7e51so803631f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714413474; x=1715018274; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SibA/Ql+XBg+fLqRKXHnbTQ4WwI0I66p3A9mv5LAXs=;
        b=ibXU8cZYmCtq2HNJGZHrdcc5B0L2BBmtNFM+PAvsCDPOFH1+b3HAifyLDCxfcCY6qO
         Rib2/90sI9D1l5wUqQiNpgdJXkE44IT8pe/iJ9ssW9TCK84f4zyd10bI/mlUffphoYql
         gI/isMJV5aXOJbh5pH4G1mNUyKVPzraiVzdsWt6LCONQR213KeOeY32DfozrfKf3OBeQ
         gB68woby2Y0iWsNPJx/uy/ltz+vns5vvhhyUJCNsrgNCyGNc7MQ7iO+qjFDeacIJv4nn
         c+stloEnNUXswgPUC5Bw//s8eGuei5945coLhM/WESELTfPsPojovAdrj1lwCEjAI5MD
         Lhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413474; x=1715018274;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SibA/Ql+XBg+fLqRKXHnbTQ4WwI0I66p3A9mv5LAXs=;
        b=m46NugnHag8V+vPuKCA+DzBVO1ne8xbWrd1V9XH3uQdH7JZ+Hh+vSNl8CxA/jc2YgI
         WGCwGq4A0CEsj31ITG6UKkYVxkLzC51nxV//SvmysqE3hr5SCYeHQ/QeZt/5DhtsrS3Q
         QTOWLJwcDz+VnD1K67zgtXMeaUfYrr0gOkvn4hBuS8B7UyjNWEK0zad7sSwZCBl/OzLA
         01QhfRKRpXDWRjmAJDQNuNt6jNq5NSo2y/ReKEuvkm5K35QgSh7A+YH+SzzYnY0qwd/X
         S2UXG7yPGI7SHS4T7IAhSDJyumo5bRXYqfZqwXLKrs+9S5nKmHEZG9lBNWU1hqy5F7wG
         61GQ==
X-Gm-Message-State: AOJu0YyLiPIiRiQaIE8u4HWMFjLWFcJ8B8qQMfGvE9W0onv+avqvcy8X
	8cx0KlISCJOSf6owQE0QKvFdIv/qnVY55zo5AxIUg1fNrgfcqEPKQd7Na6dk
X-Google-Smtp-Source: AGHT+IG2+YKbjH6Irku9rZiPrTsbqkRWy6oQplcvsKh+6xvaxQBCQsQSHe7anxdTBeD2m/uLraklJA==
X-Received: by 2002:adf:e789:0:b0:34b:5d10:1d48 with SMTP id n9-20020adfe789000000b0034b5d101d48mr328841wrm.26.1714413474256;
        Mon, 29 Apr 2024 10:57:54 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b00347ec0469b2sm30012085wru.46.2024.04.29.10.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 10:57:54 -0700 (PDT)
Message-ID: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
Date: Mon, 29 Apr 2024 20:57:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: usb: Fix disconnection after beacon loss
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When there is beacon loss, for example due to unrelated Bluetooth
devices transmitting music nearby, the wifi connection dies soon
after the first beacon loss message:

Apr 28 20:47:14 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-BEACON-LOSS
Apr 28 20:47:15 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1

Apr 28 20:47:24 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-BEACON-LOSS
Apr 28 20:47:25 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1

Apr 28 20:47:34 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-BEACON-LOSS
Apr 28 20:47:35 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
 CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1

When the beacon loss happens, mac80211 makes rtw88 transmit a QOS
NULL frame and asks to confirm the ACK status. Even though rtw88
confirms to mac80211 that the QOS NULL was transmitted successfully,
the connection still dies. This is because rtw88 is handing the QOS
NULL back to mac80211 with skb->data pointing to the headroom (the
TX descriptor) instead of ieee80211_hdr.

Fix the disconnection by moving skb->data to the correct position
before ieee80211_tx_status_irqsafe().

The problem was observed with RTL8811AU (TP-Link Archer T2U Nano)
and the potential future rtw88_8821au driver. Also tested with
RTL8811CU (Tenda U9).

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3ba7b81c6080..1dfe7c6ae4ba 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -278,6 +278,8 @@ static void rtw_usb_write_port_tx_complete(struct urb *urb)
 		info = IEEE80211_SKB_CB(skb);
 		tx_data = rtw_usb_get_tx_data(skb);
 
+		skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
+
 		/* enqueue to wait for tx report */
 		if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
 			rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
-- 
2.44.0


