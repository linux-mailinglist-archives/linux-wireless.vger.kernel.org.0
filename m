Return-Path: <linux-wireless+bounces-6057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A612989E7A5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA60280E72
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270739B;
	Wed, 10 Apr 2024 01:14:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7938D
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711685; cv=none; b=tvVcTq4Mn6+O3zUr7nKMVKni0jpcJzJl9n1yfVQHdMsVlMUOV+0yea/8GhwZDw/Q0kRHAO7oUJSljjr85mbTrSGPyQMfxPvM+teh5VcNdjiphtBnEmi0VJBzOJQgh+p1eOjuJUOmePMhzYP15X19n9jRekN9cXEE4B2dmGg20Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711685; c=relaxed/simple;
	bh=rib4XnTpF/aKeutgzCqbtNAqCBPwVHZEj1QZ8HiV64Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DO+v0YJmzJlZOkGnuvaeOARC9GJqTMFtfah/rF6rcBJJXyIUk8uvQdpjKKscHIR02QYYlLPOut9Qkr6Z/bkEl+mP6av8GxAEyBkhLKr/Tgzl2fBM04jRvZuR6Zy40F+p2+Ow+SvqK8lmHSNQf7LolNR7JWXYtAsoVPeoJeHicYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43A1EcBbA3470120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43A1EcBbA3470120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 09:14:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 09:14:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 09:14:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command
Date: Wed, 10 Apr 2024 09:13:16 +0800
Message-ID: <20240410011316.9906-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The DMA channel of firmware command doesn't use TX WD (WiFi descriptor), so
don't need to consider number of TX WD as factor of TX resource. Otherwise,
during pause state (a transient state to switch to/from low power mode)
firmware commands could be dropped and driver throws warnings suddenly:

   rtw89_8852ce 0000:04:00.0: no tx fwcmd resource
   rtw89_8852ce 0000:04:00.0: failed to send h2c

The case we met is that driver sends RSSI strength of firmware command at
RX path that could be running concurrently with switching low power mode.
The missing of this firmware command doesn't affect user experiences,
because the RSSI strength will be updated again after a while.

The DMA descriptors of normal packets has three layers like:

  +-------+
  | TX BD | (*n elements)
  +-------+
      |
      |   +-------+
      +-> | TX WD | (*m elements)
          +-------+
              |
              |   +--------+
              +-> |   SKB  |
                  +--------+

And, firmware command queue (TXCH 12) is a special queue that has only
two layers:

  +-------+
  | TX BD | (*n elements)
  +-------+
      |
      |   +------------------+
      +-> | firmware command |
          +------------------+

Fixes: 4a29213cd775 ("wifi: rtw89: pci: correct TX resource checking in low power mode")
Cc: stable@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c734f6702546..7b00476a5dee 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1114,7 +1114,8 @@ u32 __rtw89_pci_check_and_reclaim_tx_resource_noio(struct rtw89_dev *rtwdev,
 
 	spin_lock_bh(&rtwpci->trx_lock);
 	cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
-	cnt = min(cnt, wd_ring->curr_num);
+	if (txch != RTW89_TXCH_CH12)
+		cnt = min(cnt, wd_ring->curr_num);
 	spin_unlock_bh(&rtwpci->trx_lock);
 
 	return cnt;
-- 
2.25.1


