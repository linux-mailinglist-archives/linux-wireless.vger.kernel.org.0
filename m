Return-Path: <linux-wireless+bounces-27789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411DBB51B5
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6A423E84
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D882BE65F;
	Thu,  2 Oct 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qJHDIkMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8E286893;
	Thu,  2 Oct 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435769; cv=none; b=R4J05wqwUYAa07v4s+pjbMGT61Neg/QGNUKXjuJFTX6IwZ45y21LflicHZHCSv6VxzeY+dOD7WuTD+wmbPM1JPQE0Ks0ZgOMPK8VPDlaI1rLxXYCgSOBUA8vKTEW4LbXZlHGz8tOcXlB1BaWy/Xjmlwm2WgwEH4OVIJLuEV529Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435769; c=relaxed/simple;
	bh=0Ub/qcLVk3pkt6FDZetLZb0AwpvmcCDODl9rsSxjH9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX4DxGAAYGxi8KfNl14vPgDFIthAlM++dF2ZOTZrcNoC9t8dTdQ2Q+qDIcTXu2n6Fg1NdlPuiS7WPCBxKEU2uOEJSY9whRC++G/Cet8r9hBpVwaYUil/fbcpKDtkK+VY5J0aNgA3RIjnYYZpzLSIS9jx7EwlKZQA3QbWd3LA/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qJHDIkMT; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id DF5D64076196;
	Thu,  2 Oct 2025 20:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DF5D64076196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435759;
	bh=TEBbAc8sG2aEjstpmXYsQVFspq47Rcl+1lZWXzFUVKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJHDIkMTnA8ZLE2W+kv42blf+Lpz0IYn8CSnkGDyau3iqNWJW1OUotzqQ636TXY3t
	 QK4mnjUwmWNsng4Sza9oVe+VggYuvP5YyyCbAHcsdIDNFkEfmRWEACuwYZWhRoCHzY
	 Z9oa94y5bmcGVdVzbk9F0kLMRRhBgLGr+p5gCcBo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 4/7] wifi: rtw89: refine rtw89_core_tx_wait_complete()
Date: Thu,  2 Oct 2025 23:08:49 +0300
Message-ID: <20251002200857.657747-5-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002200857.657747-1-pchelkin@ispras.ru>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass TX status value directly into rtw89_core_tx_wait_complete().  This
will make it a bit in sync with further patches and will give flexibility
in future work.  Also use scope based RCU locking which simplifies the
code of the function.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.h | 20 ++++++++++----------
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/pci.h  |  4 ----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 928c8c84c964..60e32894d8b4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3507,6 +3507,11 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_TX_DONE			0x0
+#define RTW89_TX_RETRY_LIMIT		0x1
+#define RTW89_TX_LIFE_TIME		0x2
+#define RTW89_TX_MACID_DROP		0x3
+
 #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
@@ -7374,25 +7379,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 
 static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
-					       bool tx_done)
+					       u8 tx_status)
 {
 	struct rtw89_tx_wait_info *wait;
-	bool ret = false;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	wait = rcu_dereference(skb_data->wait);
 	if (!wait)
-		goto out;
+		return false;
 
-	ret = true;
-	wait->tx_done = tx_done;
+	wait->tx_done = tx_status == RTW89_TX_DONE;
 	/* Don't access skb anymore after completion */
 	complete_all(&wait->completion);
-
-out:
-	rcu_read_unlock();
-	return ret;
+	return true;
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ee5f8579447..b1985193a18f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -464,7 +464,7 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
 		return;
 
 	info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index cb05c83dfd56..16dfb0e79d77 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1487,10 +1487,6 @@ struct rtw89_pci_tx_addr_info_32_v1 {
 #define RTW89_PCI_RPP_POLLUTED		BIT(31)
 #define RTW89_PCI_RPP_SEQ		GENMASK(30, 16)
 #define RTW89_PCI_RPP_TX_STATUS		GENMASK(15, 13)
-#define RTW89_TX_DONE			0x0
-#define RTW89_TX_RETRY_LIMIT		0x1
-#define RTW89_TX_LIFE_TIME		0x2
-#define RTW89_TX_MACID_DROP		0x3
 #define RTW89_PCI_RPP_QSEL		GENMASK(12, 8)
 #define RTW89_PCI_RPP_MACID		GENMASK(7, 0)
 
-- 
2.51.0


