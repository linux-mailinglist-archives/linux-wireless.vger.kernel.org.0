Return-Path: <linux-wireless+bounces-36054-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDI6M9RO/GlOOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36054-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 10:35:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CB4E4EA6
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64AC311BC0A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85637756E;
	Thu,  7 May 2026 08:22:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B8326928;
	Thu,  7 May 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142167; cv=none; b=ewtvaPgaG0j+GytZa7JJZD97wjV1MQm5l0Fiv+WsYhZsljf44cTFZ7zXHVgZ9U2IHZeiHYgTKOKxIkhwNOxXIJ+BvW4+z6joLtnzRSdNGU5xkszhVcJUq8dBV8X6Hc+E87D6bHGPnbuY3WwflCZm1X1gaXl6webYTr1BqskQGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142167; c=relaxed/simple;
	bh=359YSji4sS3Ohx4uk9Oha8X4GF/An7AlJrwM96KteKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZDWqIOAWHY5b54Y2Unari3nXiOQkzqgo336z2uJOkGLrJCLAi2TJrEcJiApeIrSghor6Xg/rYNbidnQ97UZtXHK49es12cRwGGWju2X2RChlC+9qk3YMQCLGvYBsD3jILZVwd+qPF2/h//uKXM7maQ+QG03R8R8CAZbsKGLMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKu0I-00000000buB-0puI;
	Thu, 07 May 2026 10:22:42 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] wifi: rtw88: remove rtw_txq_dequeue
Date: Thu,  7 May 2026 10:22:12 +0200
Message-ID: <20260507082238.889656-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B6CB4E4EA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[kaiser.cx : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36054-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kaiser.cx];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@kaiser.cx,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Remove the rtw_txq_dequeue helper. It's a wrapper around
ieee80211_tx_dequeue with just one caller.

Call ieee80211_tx_dequeue directly in rtw_txq_push. There's no need to
fetch txq for every frame, we can do this once outside of the rcu lock.

Make the loop variable i unsigned long, it should have the same type as
frames.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- variable declarations in reverse xmas tree order

 drivers/net/wireless/realtek/rtw88/tx.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 3106edb84fb4..bea78971141e 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -619,31 +619,19 @@ static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
 	return 0;
 }
 
-static struct sk_buff *rtw_txq_dequeue(struct rtw_dev *rtwdev,
-				       struct rtw_txq *rtwtxq)
-{
-	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
-	struct sk_buff *skb;
-
-	skb = ieee80211_tx_dequeue(rtwdev->hw, txq);
-	if (!skb)
-		return NULL;
-
-	return skb;
-}
-
 static void rtw_txq_push(struct rtw_dev *rtwdev,
 			 struct rtw_txq *rtwtxq,
 			 unsigned long frames)
 {
+	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
 	struct sk_buff *skb;
+	unsigned long i;
 	int ret;
-	int i;
 
 	rcu_read_lock();
 
 	for (i = 0; i < frames; i++) {
-		skb = rtw_txq_dequeue(rtwdev, rtwtxq);
+		skb = ieee80211_tx_dequeue(rtwdev->hw, txq);
 		if (!skb)
 			break;
 
-- 
2.43.7


