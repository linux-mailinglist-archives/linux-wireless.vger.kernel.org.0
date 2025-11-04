Return-Path: <linux-wireless+bounces-28538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99976C315A1
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A913BD52E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D132ABC0;
	Tue,  4 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="PcBGG3kx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95A32A3DA;
	Tue,  4 Nov 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264673; cv=none; b=lbqvjEjVqLVhf3vcbAu4F6wCCOIoBtDNiGNFej+EFghD7WA45w+0mQFZhkjCj+zXgZj/UPU+W2FENyAa+VWKj4iw4VrPA7WEixBAlr81dpVd/DXfr4r0VZi78xoOh8nQYPLn/wpxuIJJVopT+UYW6UuM2cl7UpHEIBwk/4lF4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264673; c=relaxed/simple;
	bh=3kStzJTf5qQS1O5vVDNq7Md4am1Mv9O73q7+UYZjKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juotJzRPmdqH0q/yXNYsNY36LapNka2lSpH+U4fW81NqGr2HRWhogUPpU1+YSQtXPOxosUfaUzO5llrA2iLRxlWck/stkhpV/wBWCQfZHC+1Ok9mX0dv/I9vglNFJKrezvtLlgH2s+G423dz0S7bm3UfJD1fvppnvF47l7Ciqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=PcBGG3kx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3E74B40777A0;
	Tue,  4 Nov 2025 13:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3E74B40777A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264662;
	bh=03fY7Fl1FQsU0lT4WynJKxK1JHkulU0ucQNJqFvI+HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcBGG3kxvnznOUK7xRmQqMfuPkSZzvUua4DSbLGIX4i3bt+SxQRssaHVostV/XVfw
	 Hm31DSJGldTlxYz3BS/WDXmtp9WUOICkEF8fSxjwJbKuu2IDDGj5/aW73XZol9dler
	 vajR/00UA2opiFadewDkL39/jhjielYffS7H2qic=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 01/10] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
Date: Tue,  4 Nov 2025 16:57:08 +0300
Message-ID: <20251104135720.321110-2-pchelkin@ispras.ru>
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

Allow adding rx_skb to rx_free_queue for later reuse on the common error
handling path, otherwise free it.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: - do goto 'free_or_reuse' (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 4c47071b30fd..450631c77840 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -390,8 +390,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
 			rtw89_warn(rtwdev, "rx_queue overflow\n");
-			dev_kfree_skb_any(rx_skb);
-			continue;
+			goto free_or_reuse;
 		}
 
 		memset(&desc_info, 0, sizeof(desc_info));
@@ -402,7 +401,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			rtw89_debug(rtwdev, RTW89_DBG_HCI,
 				    "failed to allocate RX skb of size %u\n",
 				    desc_info.pkt_size);
-			continue;
+			goto free_or_reuse;
 		}
 
 		pkt_offset = desc_info.offset + desc_info.rxd_len;
@@ -412,6 +411,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		rtw89_core_rx(rtwdev, &desc_info, skb);
 
+free_or_reuse:
 		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
 			dev_kfree_skb_any(rx_skb);
 		else
-- 
2.51.0


