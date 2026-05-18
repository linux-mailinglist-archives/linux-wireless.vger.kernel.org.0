Return-Path: <linux-wireless+bounces-36608-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEPoIkshC2reDgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36608-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:25:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161F56EB16
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D740302E3B7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417B48AE19;
	Mon, 18 May 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y4sgGUpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5030480954
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114228; cv=none; b=eaTdjZZ26nkTZ74MictLg1E7B8lKWOze3vTfZBatjMdK2hv6vFDQYn1nZTmKJg+oMeCItSCoO3xlquRurznGzuI+uH/EHOIscHfo/xR08lXfGzuy7SGyEMURF7uxP/5ZZ1I/3Ks5vn7vOOX6avLIKDbfirGuW0N/2m3cUjE1DYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114228; c=relaxed/simple;
	bh=SJNouWG9N49DwlJLdrIoGEnUc1bC0vBsiRAFE5KGYOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huIVj46TuaqkgWylk+dhGL+mVqRdVCxKz84+mxYoN2D2XPJVbgcMnHIjhYWdmidBfjyYkUOFoS2p8y2SiW1LI9EikqC4NEN+9lDy3rtCt6j3wvkjDD8c8qBwoDP8ygZrfjrmsW/KVVJGe7226QZYpvswo+1B70wZQbpYMDIyGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y4sgGUpG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779114220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=am8E06sbfDGT3YQjEADivRAyuYuxtPXZN7W3YBwkanM=;
	b=Y4sgGUpGN0Sv61JlQpt888ReSan3+0bUgp2PZHYUU1i1+Eb3w5bg/yioe6uUroMgo6uwb2
	SRN0Ui7TZbHJ5ExKomrL8qGi6sBiGgt/XQX7WcqqFZGlQ+wT8e6VqXbKfMyRnfuW6FnvNG
	jVgGJzMODoYty98QhPZMyyKCPfF5uB4=
From: luka.gejak@linux.dev
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] wifi: rtw88: usb: fix memory leaks on USB write failures
Date: Mon, 18 May 2026 16:23:11 +0200
Message-ID: <20260518142311.10328-2-luka.gejak@linux.dev>
In-Reply-To: <20260518142311.10328-1-luka.gejak@linux.dev>
References: <20260518142311.10328-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36608-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 3161F56EB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When rtw_usb_write_port() fails to submit a USB Request Block (URB)
(e.g., due to device disconnect or ENOMEM), the completion callback is
never executed.

Currently, the driver ignores the return value of rtw_usb_write_port()
in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
functions rely on the completion callback to free the socket buffers
(skbs) and the transaction control block (txcb), a submission failure
results in:
1. A memory leak of the allocated skb in rtw_usb_write_data().
2. A memory leak of the txcb structure and all aggregated skbs in
   rtw_usb_tx_agg_skb().

Fix this by checking the return value of rtw_usb_write_port(). If it
fails, explicitly free the skb in rtw_usb_write_data(), and properly
purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().

The issue was discovered in practice during device disconnect/reconnect
scenarios and memory pressure conditions. Tested by verifying normal TX
operation continues after the fix without regressions.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v4:
 - Fixed checkpatch issues and picked up Acked-by tag.
Changes in v3:
 - Updated the Fixes tag to the commit that introduced USB support.
Changes in v2:
 - Use ret = rtw_usb_write_port(...); style, and check by next line (in
   rtw_usb_tx_agg_skb)
 - Remove unnecessary comment
 - Use ieee80211_purge_tx_queue() instead of skb_queue_purge()
 - Add testing details to commit message

 drivers/net/wireless/realtek/rtw88/usb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 718940ebba31..1a0bdbf52cb0 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -399,6 +399,7 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list
 	int agg_num = 0;
 	unsigned int align_next = 0;
 	u8 qsel;
+	int ret;
 
 	if (skb_queue_empty(list))
 		return false;
@@ -456,7 +457,13 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list
 	tx_desc = (struct rtw_tx_desc *)skb_head->data;
 	qsel = le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
 
-	rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_complete, txcb);
+	ret = rtw_usb_write_port(rtwdev, qsel, skb_head,
+				 rtw_usb_write_port_tx_complete, txcb);
+	if (ret) {
+		ieee80211_purge_tx_queue(rtwdev->hw, &txcb->tx_ack_queue);
+		kfree(txcb);
+		return false;
+	}
 
 	return true;
 }
@@ -518,8 +525,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
 
 	ret = rtw_usb_write_port(rtwdev, qsel, skb,
 				 rtw_usb_write_port_complete, skb);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
 		rtw_err(rtwdev, "failed to do USB write, ret=%d\n", ret);
+		dev_kfree_skb_any(skb);
+	}
 
 	return ret;
 }
-- 
2.54.0


