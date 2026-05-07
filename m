Return-Path: <linux-wireless+bounces-36079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMQlEte9/GnSTAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 18:29:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0944EC347
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F2253010BF3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EB3CF69E;
	Thu,  7 May 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rovxtZer"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF73C9ED9
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171343; cv=none; b=b+LxG0l1I2EFIXql3JCkFhmpUUDxwWDE9TsCPjND6kCM492VbUX6Vh2+cZejLds25Mt98ECYzFIKPJhcB4E//CvTLLc0FCYq020pWIXldk2IDEFuQwTQO0/5jFLygkS5AfMK3BiKPhRjrC922eD8E3F9ocY3/muOXSs/JTcIM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171343; c=relaxed/simple;
	bh=ZEA9pBIA123ERVAyGkgPVyXrJeCtp4rxg/tbZw4RkgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SyW2ynaB5i+Z+NNpGi+mYG3SKrcvWgXk7Vs/2ElsGl9SksBeMEOhBciyNPqhKUORtoPm7YdQFWW57CmrQQmTuRFzxofz+SeprBEzQglk9D0XcGCuOptMjDafkVuirgz8WIVQoVwUz8hlD7zJElGThgdQe2+oPat2I+7/WGbl+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rovxtZer; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778171328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1iHWditqvTBoDQoEmSHLseNG/XsNlEMSIKQ9TPbaggE=;
	b=rovxtZer5Sf3A7/0IKh/Sl/lrNYGORDB2yc0Q2kSoUqzOCYH9sV2qX5k0rmbTV5NedPExw
	3yPoMgGjfDjnUyaOt5qqO2fURBn2hSFddBF+Jq68cdUl2ovx0jShu+HWV4OhsCIcJGzbp1
	d6lB2f6pC09EinzKPGUmT/pqMkmW5TI=
From: luka.gejak@linux.dev
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: rtw88: usb: fix memory leaks on USB write failures
Date: Thu,  7 May 2026 18:28:27 +0200
Message-ID: <20260507162827.69168-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: ED0944EC347
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36079-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Action: no action

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

Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")
Cc: stable@vger.kernel.org
Tested-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v2:
 - Use ret = rtw_usb_write_port(...); style, and check by next line (in
   rtw_usb_tx_agg_skb)
 - Remove unnecessary comment
 - Use ieee80211_purge_tx_queue() instead of skb_queue_purge()
 - Add testing details to commit message

 drivers/net/wireless/realtek/rtw88/usb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 718940ebba31..1bb922cc2928 100644
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
+			         rtw_usb_write_port_tx_complete, txcb);
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


