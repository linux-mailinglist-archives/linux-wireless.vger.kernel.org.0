Return-Path: <linux-wireless+bounces-2216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F8832079
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921C41F21B53
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEA2E63A;
	Thu, 18 Jan 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="NLRxCP8a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C912E63B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609476; cv=none; b=DoI6wf+4xFbYTMnOuSgRHnqAU1jmbic73XuK0EVu6fkmO/JrczHFQYC8llV9glJqYmv/ZBpQxEP6i3z59eLaySmiDMOTCWy8QQgWg4BAtWASSMj7pejvYr3561oH7Yatws7V0LgbwIyngNeCCzXVfU9ccRXaSDyKpCZ2RaVFkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609476; c=relaxed/simple;
	bh=1r+mdaZq+yNTakzipJ+ui54CtKQ1IBnAtt8vq8jvkYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeBcBYqQYpNP0rJguRE33tPE2NjAdUqJDusglZDvTYVm0SYWrjhaUHZZ3/a45tCr0UaV1HK+9FCcufwgMZnVnQGJY+xx0ehsa7VNWAkn8vaTw1RBHFBjk4HLjNEuj43GmIWe8JKjf7W9NEBkhTIN/zRfY4eef+PpugJjDQgrB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=NLRxCP8a; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=26SlX6N5+Pz/rWkz1+xOTiqMeWMakt0FpigpxeykWEM=; b=NLRxCP8aTEDGpb139IPjVpiNos
	i4MHA45GxAJIy5MKV+470AJItbOksnqpfOHBy7hTwIqSv9S1k7PgsmqRtundJte+1D7sblKUmH00J
	ZvgPQVeC2sOKshgdtOKBrLx60KjjzDfo4NTndtsGLe+a5qWACCf/BB5jYqxymVyxV5bs=;
Received: from p200300daa7090900680536e7cb8d8cd3.dip0.t-ipconnect.de ([2003:da:a709:900:6805:36e7:cb8d:8cd3] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rQYQy-0054tJ-Rl; Thu, 18 Jan 2024 20:52:16 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 2/5] wifi: mt76: check txs format before getting skb by pid
Date: Thu, 18 Jan 2024 20:52:13 +0100
Message-ID: <20240118195216.80974-2-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118195216.80974-1-nbd@nbd.name>
References: <20240118195216.80974-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The PPDU TxS does not include the error bit so it cannot use to report
status to mac80211.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index bd2a92467a97..5f132115ebfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -32,6 +32,11 @@ enum {
 	MT_LMAC_PSMP0,
 };
 
+enum {
+	MT_TXS_MPDU_FMT = 0,
+	MT_TXS_PPDU_FMT = 2,
+};
+
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
 #define MT_TX_FREE_COUNT		GENMASK(12, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 630c6402ec25..b841bf628d02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -716,6 +716,9 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	struct sk_buff_head list;
 	struct sk_buff *skb;
 
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) == MT_TXS_PPDU_FMT)
+		return false;
+
 	mt76_tx_status_lock(dev, &list);
 	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
 	if (skb) {
-- 
2.43.0


