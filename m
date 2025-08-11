Return-Path: <linux-wireless+bounces-26260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF4B20904
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3982A3CB5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D8DF6C;
	Mon, 11 Aug 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Iauc8J9G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A482D323D
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916039; cv=none; b=TBXeXMR6HJI8CK9ByCgGsZtlz1UyOYAu+5IUokSCMWHTaP1sAtLDDLQ4BRzyK8BB3WdaU0fY8CMivWEl3ImFmQcJshEv4D6AONCe5Vs+XW8MGkm+9b2YIlapmk28ibwFROqy6gepF+qrfnVohCJxqwR5D5HtJmMRMAhNudpMj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916039; c=relaxed/simple;
	bh=IkXBkheECZHDXqBs1BeixZhB1wGyl0hJCAAtpTr0ftA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIkWmLXFW5hMCcHlIMCcf3AwX/CUps8cFY77+RVLAKn9gfZboFjMZzDTnnsF8HT+U8bDvSY8q/nACbtI0ZpGFLb756HFgGndRMfQR+P21o0WEGbxT+Nlz57f3V/G7Maf64YpNqqy6p0zLxUlhoQBV+VsYHULpW3DsoT1uiAfN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Iauc8J9G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCeYgT5074073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754916035; bh=j+RWH1754TbeOB5sCXiGdOPgk+jVH3owABg9GDv1LO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Iauc8J9Gw4DrYdxmilkmB3vB51wQ8ITmcrJke5NiJOZdYmv1p29ZtfEvRsNlyN8Am
	 0phVLE1MJPsAOdZdwwQPtGJaQ9dxRQikOo7i5zDocysV/KwOVtqnUQ4K6lpP6eOH3W
	 cBN1cMo3wiwG6MgGjumH4D9O4PgjvXbFzpH0j/DjIPysP7VHRE1Q0x+K7L3+6EOWqf
	 veAreCKo8eSLfYgJEYh+qYJPvQt94rWMARBMp4CYd+NBLw1wX3V6CETRLnEvQbiKtB
	 CNt5g1gByX+r/nm9dkD/22VSwMHLXkpNpVVCS0986KxU56Y3lcDhyTFXAVUgnLqsAK
	 XcKo3WTTp6xtA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCeYgT5074073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:40:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:40:33 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:40:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 7/8] wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
Date: Mon, 11 Aug 2025 20:39:50 +0800
Message-ID: <20250811123950.15697-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

For non-transmitted connections, beacons are received from the
transmitted BSSID. Fix this to avoid missing beacon statistics.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7d522031dfa1..0ad7562632a5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2668,6 +2668,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_vif_link *rtwvif_link;
 	const u8 *bssid = iter_data->bssid;
+	const u8 *target_bssid;
 
 	if (rtwdev->scanning &&
 	    (ieee80211_is_beacon(hdr->frame_control) ||
@@ -2689,7 +2690,10 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		goto out;
 	}
 
-	if (!ether_addr_equal(bss_conf->bssid, bssid))
+	target_bssid = ieee80211_is_beacon(hdr->frame_control) &&
+		       bss_conf->nontransmitted ?
+		       bss_conf->transmitter_bssid : bss_conf->bssid;
+	if (!ether_addr_equal(target_bssid, bssid))
 		goto out;
 
 	if (is_mld) {
-- 
2.25.1


