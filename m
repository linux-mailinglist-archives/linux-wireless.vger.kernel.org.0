Return-Path: <linux-wireless+bounces-28023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A72BE7F17
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8E3B2550
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EE30F815;
	Fri, 17 Oct 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="o3hKbIoh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D117192D68;
	Fri, 17 Oct 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695636; cv=none; b=OXHac5kOEaSDR2SSdzP65R9PdTncb461pV1ZmABlUDjwMrqi4hGVmK8uwUErsRQbDeMxn3UdVXt+qk9Mc4vJLI4QihOUMbVusM0Xo/IwxdA5oqK3V0kGtJqMYMGE9/ayexLBKGVREmpN4yw74wYrB9HB+09kBsc58ZuSWT3N7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695636; c=relaxed/simple;
	bh=cMgcWlcNEaLGVhzpqUmzdVFaAi5wv7dfTqoSQ2NjCDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFeW0H6F8o6brqwZDY8NOBOQStUzQUw8wwma2zmdE0i0WmkROpmArRKbSy1wD1Ia4eF7s+2zUsT07Ta9XcgdEpVVx5JajkkR0/FbSj2MT513ONREbus7n/j2M8qKb6lmdsTYVEIRscpQTQi29bW6uOhy72VrN6DQaqc2lrRiKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=o3hKbIoh; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7C5C44076729;
	Fri, 17 Oct 2025 10:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7C5C44076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695630;
	bh=AgczVpBUOFdifsC4fNu0U21e7j0us/Endy89rAucTwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3hKbIohUYgLGA7aqda52MK1JicLdnCKu+Rj7RLPiHfcJTGPS6/zkewuVprZsV6r6
	 I3tjE2+35G18abQG/6GpOs1HRvNjsQ6PzDKa6ewFzr9GP3zJwWw38YHxtecKfqGfRl
	 bledJdeX3mvocAhPW6Gbft9HQCNkACGLTYOSqOL0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 1/9] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
Date: Fri, 17 Oct 2025 13:03:03 +0300
Message-ID: <20251017100658.66581-2-pchelkin@ispras.ru>
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

Allow adding rx_skb to rx_free_queue for later reuse on the common error
handling path, otherwise free it.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---

v2: - do goto 'free_or_reuse' (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..e8e064cf7e0a 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -410,8 +410,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
 			rtw89_warn(rtwdev, "rx_queue overflow\n");
-			dev_kfree_skb_any(rx_skb);
-			continue;
+			goto free_or_reuse;
 		}
 
 		memset(&desc_info, 0, sizeof(desc_info));
@@ -422,7 +421,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			rtw89_debug(rtwdev, RTW89_DBG_HCI,
 				    "failed to allocate RX skb of size %u\n",
 				    desc_info.pkt_size);
-			continue;
+			goto free_or_reuse;
 		}
 
 		pkt_offset = desc_info.offset + desc_info.rxd_len;
@@ -432,6 +431,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		rtw89_core_rx(rtwdev, &desc_info, skb);
 
+free_or_reuse:
 		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
 			dev_kfree_skb_any(rx_skb);
 		else
-- 
2.51.0


