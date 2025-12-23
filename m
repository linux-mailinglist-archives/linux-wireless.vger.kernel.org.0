Return-Path: <linux-wireless+bounces-30069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC80CD7F1F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74698305AEEA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406D2C237C;
	Tue, 23 Dec 2025 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rULme/Jg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6862C236D
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459297; cv=none; b=gty8FrwmufOnjL0sITmgde8bCQVHqvFxhyJBa7+OrRNlI1FHSsbIHU9S3t5gCYqmhmpLGFx6nZ86vTbGyflulSEEjcXjqezP2ZzueZGduS75+fIr1+xQoobmLUgeZYd5jMqilz/dTQw9UJRK6WB2VYR9w2Hx+1yW9ZTN0+GWcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459297; c=relaxed/simple;
	bh=OC7L8jUwxLBBNH04igi4WdA2r0Um3/3vdXW9yecsg7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7EH4DwhurcGcWUJYkTLAuwcPhKThdg6ycgqinX3/XzqZJrzd3GKiV77hyzq2Yb6uWIICC98PYaLUfFUXFU9uGAeqg07xlKVa6/xAyaYL+DlFtTM5/C7A2blo3DVOUSVrX7sEEKAZHHBWtzhVNOu1lSGy4AVn2i9KfnfSo33VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rULme/Jg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN38CvfC571339, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459292; bh=lOTNN9y2rwhL6mcu335HvHjQZF7JokX1kWX+W2/WB2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rULme/Jg+O52xS4yvwrly3zwjl20gYb0f14zt12m4e5FQGDFqNTGE5bidCCVnRKEr
	 97AZkcnuXFerdSBM9o4Y23YB2xk5bROBR0yMcwEUE3LUp24xfy78/3YWQJXJsngskz
	 PLCXgsAOBZrzLlunEoJh8ByeqCTi2XZNim9EPCegfsnakowz02S5dN1Ssii72oe72h
	 PN529TECVSbUh3MfP4hMSHDrxsrPLUGXUlfFlTXiuwDHJJm9cjAMPW6uP28yRJ/l2g
	 +/XFZVw2W7kLWKbx46SnkduwLDd4M4SfDdbhB6f3mCVaFbJ5sKSp9ZtTFvx0u2bK7l
	 OYIfgE3f8LuEA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN38CvfC571339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:08:12 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:08:11 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:08:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 12/12] wifi: rtw89: mcc: reset probe counter when receiving beacon
Date: Tue, 23 Dec 2025 11:06:51 +0800
Message-ID: <20251223030651.480633-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
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


