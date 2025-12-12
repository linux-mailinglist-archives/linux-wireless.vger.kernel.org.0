Return-Path: <linux-wireless+bounces-29698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCCCCB7BC8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9243038685
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA321E091;
	Fri, 12 Dec 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iXvuoepQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8282749D2
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509293; cv=none; b=bQexHmTbzH39zVC5+orDb1RoCR2fSaaKYH+J8OskE/xvlEpC4zUSs7oz0tNx2Cto2BxVX2XXLG0cWmUtuRxE1y6MSAqpntFCH08MM0Gr749eZb94hzV/yADikFGqkj9WXqqBxihK9EmRF5pyhdbKjspFSfaLuSr4xiGjITwzPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509293; c=relaxed/simple;
	bh=OC7L8jUwxLBBNH04igi4WdA2r0Um3/3vdXW9yecsg7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf04hLxwrZQtZaw8mdJBXPQdtXOagBQq8A21crW8ax5BjPoo6r2Di9uC/n/CGQmNT4ORvHHFjLSkxQ153CvkOs/i2k/GKkuTwBbvyzZNDx+LdoOQIJj0TVLfOEtnCyN8YA3yjBgKWcsy5HZ/Fq0r4KwR2TzGTU3E56vG2iC6Yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iXvuoepQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3EnT923508890, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509289; bh=lOTNN9y2rwhL6mcu335HvHjQZF7JokX1kWX+W2/WB2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iXvuoepQNpBb62DbhERdS39BzjTUsWgkbQtJKnAoEPWqsS9W6zTWpSkL8JCUlSOwc
	 I286JLsuM2mPiTkerzbixI7I30NHWgWjZ0TVPTq32mOZ3dKwfCp7Wau3TuexHqstAb
	 Li/BupDYauUggwOgc0f/+eDbAbdPa7usYVGMV2vF8czjIdZrgCCT8i28PSxsKGrN3c
	 5vMtaK1005ttBZkPAtOoXxE21ISCwfIoIjEh4fLS5R/BVB09o3sgbXwyXeTqFGq6pv
	 FZM09fpIIFjkwtpNRYq9spQPmEYiOmB3zHnZ6hznBe5VV2w8aZ5yzbtGzWwu9TP/PG
	 xqbjzOt8Ea3iQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3EnT923508890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:14:49 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:14:49 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Dec 2025 11:14:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: mcc: reset probe counter when receiving beacon
Date: Fri, 12 Dec 2025 11:13:03 +0800
Message-ID: <20251212031303.19882-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

For BE chips, needs to transmit QoS null data periodically to ensure
the connection with AP in GC+STA mode. However, in environments
with interference, the Qos null data might fail to transmit
successfully. Therefore, when receive the beacon from AP will
reset the QoS null data failure counter to avoid unnecessary
disconnection.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 5 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 86f1b39a967f..8fe6a7ef738f 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2608,17 +2608,20 @@ bool rtw89_mcc_detect_go_bcn(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *role)
 {
+	struct rtw89_vif_link *rtwvif_link = role->rtwvif_link;
 	struct ieee80211_vif *vif;
 	bool start_detect;
 	int ret;
 
 	ret = rtw89_core_send_nullfunc(rtwdev, role->rtwvif_link, true, false,
 				       RTW89_MCC_PROBE_TIMEOUT);
-	if (ret)
+	if (ret &&
+	    READ_ONCE(rtwvif_link->sync_bcn_tsf) == rtwvif_link->last_sync_bcn_tsf)
 		role->probe_count++;
 	else
 		role->probe_count = 0;
 
+	rtwvif_link->last_sync_bcn_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
 	if (role->probe_count < RTW89_MCC_PROBE_MAX_TRIES)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index e4fc513aa158..f80c847d1741 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -127,6 +127,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	rtwvif_link->rand_tsf_done = false;
 	rtwvif_link->detect_bcn_count = 0;
+	rtwvif_link->last_sync_bcn_tsf = 0;
 
 	rcu_read_lock();
 
-- 
2.25.1


