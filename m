Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0656B47CB91
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 04:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhLVDOG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 22:14:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2312 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238645AbhLVDOG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 22:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640142846; x=1671678846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lr7dSi0ciTW50dtMQlXvbGVLDghbk0BFwT8nf4lV/Aw=;
  b=uMZK+J954Vl/w7MA/HKubaghiwotkuXFprTchPg1xPRsHRYc3BntEGRX
   0P758yHohOT1TmJktHrJPb5WKBj15aX7jmAlqKH9XW86ILjNSPaF+FlRc
   oCMPovl6AoJvrsW9YnpohIGOAQuU3t+pg0/EUfskvnqQyxs1iJQuztW/F
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Dec 2021 19:14:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 19:14:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 19:14:05 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 19:14:04 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath10k: fix memory overwrite of the WoWLAN wakeup packet pattern
Date:   Tue, 21 Dec 2021 22:13:47 -0500
Message-ID: <20211222031347.25463-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In function ath10k_wow_convert_8023_to_80211(), it will do memcpy for
the new->pattern, and currently the new->pattern and new->mask is same
with the old, then the memcpy of new->pattern will also overwrite the
old->pattern, because the header format of new->pattern is 802.11,
its length is larger than the old->pattern which is 802.3. Then the
operation of "Copy frame body" will copy a mistake value because the
body memory has been overwrite when memcpy the new->pattern.

Assign another empty value to new_pattern to avoid the overwrite issue.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Fixes: fa3440fa2fa1 ("ath10k: convert wow pattern from 802.3 to 802.11")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wow.c b/drivers/net/wireless/ath/ath10k/wow.c
index 7d65c115669f..20b9aa8ddf7d 100644
--- a/drivers/net/wireless/ath/ath10k/wow.c
+++ b/drivers/net/wireless/ath/ath10k/wow.c
@@ -337,14 +337,15 @@ static int ath10k_vif_wow_set_wakeups(struct ath10k_vif *arvif,
 			if (patterns[i].mask[j / 8] & BIT(j % 8))
 				bitmask[j] = 0xff;
 		old_pattern.mask = bitmask;
-		new_pattern = old_pattern;
 
 		if (ar->wmi.rx_decap_mode == ATH10K_HW_TXRX_NATIVE_WIFI) {
-			if (patterns[i].pkt_offset < ETH_HLEN)
+			if (patterns[i].pkt_offset < ETH_HLEN) {
 				ath10k_wow_convert_8023_to_80211(&new_pattern,
 								 &old_pattern);
-			else
+			} else {
+				new_pattern = old_pattern;
 				new_pattern.pkt_offset += WOW_HDR_LEN - ETH_HLEN;
+			}
 		}
 
 		if (WARN_ON(new_pattern.pattern_len > WOW_MAX_PATTERN_SIZE))

base-commit: 6629123e6a8ba405d270fd9cd70dc1ccb65e25de
-- 
2.31.1

