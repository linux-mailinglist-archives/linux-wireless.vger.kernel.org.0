Return-Path: <linux-wireless+bounces-23696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544DACDBF9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 12:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CD17A42A2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D728DB69;
	Wed,  4 Jun 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="vz6lJEDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CB2153EA;
	Wed,  4 Jun 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032972; cv=none; b=fFtAimAwJZ+KPVdiYBcGYL2w0j75Vo6P64dqEamDizcyCU5KitaOBL8imyOrb8lvsNXp2TAs2fRWtylraDfjnOVYvFbKdJYLXkk1HIFbRWPKZ9DXhnrlDlhm5yZBH33QH7L9LvqraziqpNHuU/GhuNlwFJE3DyuWmWNLyHMAb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032972; c=relaxed/simple;
	bh=K0KH87Eqmp0gY8TpGdW3mtysyP6xVb0gwpGfKjIWs7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTB15avj9JSlSlfq03npLfdxr6x4nl+yf7ex5Ye3cIvcaWEedkjrkMF5ulkRASgBmAReXqqtutoN8gvqLyx/UgORKpWjBJgZl7S7UvNIwDTnZmgvwz+DUiMxh72wYdnV85DovfuK4sHGOZ0udLc32vsEMMXDR/1Vd65m7ZqKWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=vz6lJEDI; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1749032043; h=from:subject:to:date:message-id;
	bh=K0KH87Eqmp0gY8TpGdW3mtysyP6xVb0gwpGfKjIWs7k=;
	b=vz6lJEDITQM61yQXqmdMenRaQvSX3SrS+iGH9t/NNNPxlBXwjYd92l0sEhHP/aMOFEFQtN2MPJE
	VLiWbh124z2HFn3U7vyy/sGQjUwyQTtPTAw/Kt7Ijy+fJ5UY0SVwWb5Z7tOAY6TJh1QsuKKYv86P8
	D6o7IppyT4xGGLakYNPHkBKguUJqA7euPRGwT13UnK3yAosdwYfPm4+vW+M630sGu9jkrO8Ipoxqq
	GcvIuPzRh+IQfRcT0i065Q4C4P8iHDTY2c9dK0jVVh9tWn8T2Jpez8aC4LiCzYeCARGKjgZ+89GdQ
	ENAN0VwovpvOQmPOVuO+IOW7DrYfxoPMDUNw==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Johannes Berg <johannes.berg@intel.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Kees Cook <kees@kernel.org>, "Emmanuel
 Grumbach" <emmanuel.grumbach@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, "John W. Linville"
	<linville@tuxdriver.com>, Daniel Drake <dsd@gentoo.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] wifi: zd1211rw: Fix potential data race in zd_mac_tx_to_dev()
Date: Wed, 4 Jun 2025 13:13:56 +0300
Message-ID: <20250604101356.6292-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

There is a potential data race in zd_mac_tx_to_dev(). For example, it is
possible for filter_ack() to clear the ack_wait_queue right after
zd_mac_tx_to_dev() checks that queue has more than 50 elements, but before
it dequeues any skb. This results in skb_dequeue() returns NULL and the
pointer is dereferenced in zd_mac_tx_status().

In order to avoid potential data races and leading dereference of a NULL
pointer, acquire the queue lock before any work with the queue is done and
replace all skb_* calls with their lockless version.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 459c51ad6e1f ("zd1211rw: port to mac80211")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 9653dbaac3c0..e7e0d1b7b9ab 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -568,6 +568,7 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hw *hw = info->rate_driver_data[0];
 	struct zd_mac *mac = zd_hw_mac(hw);
+	unsigned long flags;
 
 	ieee80211_tx_info_clear_status(info);
 
@@ -581,13 +582,17 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 	} else {
 		struct sk_buff_head *q = &mac->ack_wait_queue;
 
-		skb_queue_tail(q, skb);
+		spin_lock_irqsave(&q->lock, flags);
+
+		__skb_queue_tail(q, skb);
 		while (skb_queue_len(q) > ZD_MAC_MAX_ACK_WAITERS) {
-			zd_mac_tx_status(hw, skb_dequeue(q),
+			zd_mac_tx_status(hw, __skb_dequeue(q),
 					 mac->ack_pending ? mac->ack_signal : 0,
 					 NULL);
 			mac->ack_pending = 0;
 		}
+
+		spin_unlock_irqrestore(&q->lock, flags);
 	}
 }
 
-- 
2.34.1


