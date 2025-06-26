Return-Path: <linux-wireless+bounces-24543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D87AE9D1C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3177B456D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24742F1FEC;
	Thu, 26 Jun 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="ns8VGIYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC362F1FDA;
	Thu, 26 Jun 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939359; cv=none; b=gi/YdfhSvjW0xvc1Sr5Ip6WPMzBSrFESPI01O5/e8kPcwx2vfGmhr66EeF8Sm9NwInsSaKCVmEFwg07UmbpsEOizKWqDbx+7KIqgR7/nZRWTuLIeJ+pr1F3MFyhqRIYHTQlxGph9vfHVXBFIaYOPFI2HFcP6p6wShNVB9phP2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939359; c=relaxed/simple;
	bh=wmnasIyPxehdxLNIHSKhKpOToo640MSxNeoWG1PR6tw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BN/S/TsmHzo5ZbP2qa/cjcfnPrwarE+v9heLS8e7ge9+R6MdN0BQl4M4WgUeCP0lp6e27E/G6loFvtD7pBpT0uIvBo+VbmvYFkoIRykaV8Rlz67/xEA5Xr7E5adui1QN+9FmoGMcrfKXlt8isC/Z9vSE7yRdD4P0VHh6UgwArXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=ns8VGIYS; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1750938406; h=from:subject:to:date:message-id;
	bh=wmnasIyPxehdxLNIHSKhKpOToo640MSxNeoWG1PR6tw=;
	b=ns8VGIYSWsUJBF63yP/4S3anVqeG0fexbzzX+6E8g46NiJZt8RvDT3j/FtEgYcgOCr7/sd0bzWs
	jVJPqkUNXjYDn1RBVbExm4W/WBXAmv+WiyOeR3oTHMo+Z5Fej4Kw/VapqiKz5wgkvqCeXZ8vNbjix
	hZG+qvOroXIzA/JZDTK/JImJzybJ754PoiMHwFEWaqSQUy2OHgOeS/TdhibCc7hZ7TNjR+7CMtYst
	bUVE4j5M4ditUMZE4xVX6DuXuOdmiAL6WSKoLbId5oqzqj3xSJLUh4KiFdKefhVTavUOXh9bVeHVv
	3N3Bts80i6FgX4V+jR+BQ7ylZQHxuPffr7dQ==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Daniil Dulov <d.dulov@aladdin.ru>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()
Date: Thu, 26 Jun 2025 14:46:19 +0300
Message-ID: <20250626114619.172631-1-d.dulov@aladdin.ru>
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

There is a potential NULL pointer dereference in zd_mac_tx_to_dev(). For
example, the following is possible:

    	T0			    		T1
zd_mac_tx_to_dev()
  /* len == skb_queue_len(q) */ 	   				  
  while (len > ZD_MAC_MAX_ACK_WAITERS) {

					  filter_ack()
					    spin_lock_irqsave(&q->lock, flags);
					    /* position == skb_queue_len(q) */
					    for (i=1; i<position; i++)
				    	      skb = __skb_dequeue(q)

					    if (mac->type == NL80211_IFTYPE_AP)
					      skb = __skb_dequeue(q);
					    spin_unlock_irqrestore(&q->lock, flags);

    skb_dequeue() -> NULL

Since there is a small gap between checking skb queue length and skb being
unconditionally dequeued in zd_mac_tx_to_dev(), skb_dequeue() can return NULL.
Then the pointer is passed to zd_mac_tx_status() where it is dereferenced.
				   				
In order to avoid potential NULL pointer dereference due to situations like
above, check if skb is not NULL before passing it to zd_mac_tx_status().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 459c51ad6e1f ("zd1211rw: port to mac80211")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
v2: Replace locking changes with a check for NULL since it has more determined
behavior compared to changing locking logic and might be less harmful in terms
of old code.

Link to v1: https://lore.kernel.org/linux-wireless/20250604101356.6292-1-d.dulov@aladdin.ru/T/#u

 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 9653dbaac3c0..21205568374e 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -583,7 +583,11 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 
 		skb_queue_tail(q, skb);
 		while (skb_queue_len(q) > ZD_MAC_MAX_ACK_WAITERS) {
-			zd_mac_tx_status(hw, skb_dequeue(q),
+			skb = skb_dequeue(q);
+			if (!skb)
+				break;
+
+			zd_mac_tx_status(hw, skb,
 					 mac->ack_pending ? mac->ack_signal : 0,
 					 NULL);
 			mac->ack_pending = 0;
-- 
2.34.1


