Return-Path: <linux-wireless+bounces-27541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C4B8C912
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A627E6CC7
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FC30214E;
	Sat, 20 Sep 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EGMqr9dQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D2FFDC1;
	Sat, 20 Sep 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374851; cv=none; b=TFm0+xLxhcYA0qMqK7y98vjy0d8vqOzxBVLZpYC5qRXnPYTz2Zl+w+4w4Qe7iSvQ4trNCCwOh7C6HoAl8tu6atNjtQpaoTWjrR6dmQDFY1XlHB1VygTzthcNepgl5aLlVP2D0oGiP8gd4x+VgCs+J3YPpE2bn5KYEYm7QLWopuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374851; c=relaxed/simple;
	bh=CWXrVmVIEf0A8isn0vEv7F6yIHZHLMSSsejfgFnA+5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E72c0J3bABjZTWALqWv2T69XC2fPgQFOGpjAEEStOlvm34pTAN2Uno3KcpLc0x8aOcAk/SX4LERjNQPSk2uws/YTwZItBAUt2scROQ4t24EIWKg0o/iy8COcAeytZzDtrP3/zSbLqjPSAnv03yV3QAbYwBoNtIih7wGVKOG9Dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EGMqr9dQ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7AB0E4076729;
	Sat, 20 Sep 2025 13:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7AB0E4076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374844;
	bh=lBRy73gtJp6Oq+I/NTee64OyQYehsFSPMldzgTDvJSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGMqr9dQ0aiPCN8kJnsa2oqfj2BBDgaFDpV8PjNujP68Uy5J0jMZFMM5ufefNurcZ
	 BXa0zekcB5n09VSO9AAOGTN96QVdjFK85a2gDTynA2SbBkhDVstGCq/yEI6rg0gXWD
	 CtOPmLqMHdQaE477iIQlA1lFNR8e7rsJU568knEw=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 6/6] wifi: rtw89: forcefully clear TX wait list on HCI reset
Date: Sat, 20 Sep 2025 16:26:11 +0300
Message-ID: <20250920132614.277719-7-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX status reporting based on firmware messages does not necessarily happen
when an HCI reset occurs, in contrast to RPP based one where pending skbs
are forcefully flushed, see rtw89_pci_release_txwd_skb().

So for the former case, if completion from the firmware doesn't happen, TX
wait objects are wastefully piled up in the list and not released.
Forcefully clear TX wait list on HCI reset then.

It's okay since wiphy lock is held during HCI reset.  For the RPP case,
all pending completions were done just before in ->reset callback and no
new ones can appear.  For the C2H message case, RCU access to the list
helps.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e76f04736502..3a0388d3acbf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1140,7 +1140,7 @@ static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						tx_wait_work.work);
 
-	rtw89_tx_wait_list_clear(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev, false);
 }
 
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e7948bd0bdf6..0ad871472e79 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6282,14 +6282,14 @@ static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info *wait)
 	kfree_rcu(wait, rcu_head);
 }
 
-static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
+static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev, bool force)
 {
 	struct rtw89_tx_wait_info *wait, *tmp;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
-		if (!completion_done(&wait->completion))
+		if (!force && !completion_done(&wait->completion))
 			continue;
 		list_del_rcu(&wait->list);
 		rtw89_tx_wait_release(wait);
@@ -6305,7 +6305,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
-	rtw89_tx_wait_list_clear(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev, true);
 	skb_queue_purge(&rtwdev->tx_rpt_queue);
 }
 
-- 
2.51.0


