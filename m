Return-Path: <linux-wireless+bounces-28147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79ABF6CDF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B6D19A4E86
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4541338929;
	Tue, 21 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HnJtjsBH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB93370F5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053671; cv=none; b=hcwe/C0WNFyVVnaKxiaAhC6hLaLs3pq66BwmiyALndb82dC1v1Lch1w4URW4tJuNV9pkBwvTs6GsUs8DKmkxq5TNVXwjzhpw1aUpuBRIxIW5gPFgK08DKcYKNCYVDdlE1f9rAmdkznV3HT0PK1URrOTBRFD2RPRryfGt9ayL7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053671; c=relaxed/simple;
	bh=p0ObaJhdNVmgY2H2zh82Apd2IxZcoTYWN7AUIEW2UeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hitShgjMUFNyxc/d7ahF4+UVrECzGmF9RLTXzc5VScD04qeYYKkIYv0qI5I7A3+KzV9s8uEpl+k9waiJhqj+wfm8cTkoFcdswmOdE2Nt/aFLJR1qEVCskppZucc3C1NKg8OO43rgSWleKtW0naQgyA1Ej+IWB2IFaMdK5GMg96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HnJtjsBH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYNOo83088107, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053663; bh=KL1ZOMfg3RY99M0UoZtr6pEHLeKU/oMOBR7WGT0cr44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HnJtjsBHxdAm2KbACU9RNsV0jNLIYKUvGjEDPmsMB7Y5F0Jg13pMXDTtjkjUYhEms
	 qLeNJV9DOFMXw9X969jM+jOB1iDZYdLL4j8FOyyZWmsbXRHebr6MQXjG/lr4gRb5qu
	 bhRnAXFK6ZkYHeHapq3YTxsLUfUVXqHXQ4UYeb+YA4s+arVAcIpicgf52zpCIk/LFe
	 X/m/0VLqeJG91sdPi8d7dlSPIX7Ja8Q4OurjEUwF+RM8yg5ByP4aruBIPZv5PQDdQJ
	 uQb71WNjLb++Zh4H2QxOEYj12e94c2BOoYuFfGW3xEX7/yiK5PeHV/ymP2TpRgsd6y
	 tS4ThinyLzJ6w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYNOo83088107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:23 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:22 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 8/8] wifi: rtw89: improve scan time on 6 GHz band
Date: Tue, 21 Oct 2025 21:34:02 +0800
Message-ID: <20251021133402.15467-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jui-Peng Tsai <emma_tsai@realtek.com>

Reduce scan time for all supported channels from 4.4s to 3.5s.

If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan request, only scan PSC
channels and the channels from the RNR element found on the 2.4/5 GHz
channels. When firmware support parsing RNR element from received beacon
or probe response, offload the decision about non-PSC channels to firmware.
Driver do not need to fill non-PSC channels to scan list. If
NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set, scan all supported channels.

Signed-off-by: Jui-Peng Tsai <emma_tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9a926bb2cf00..cb431c8a65ac 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7787,15 +7787,23 @@ int rtw89_hw_scan_prep_chan_list_be(struct rtw89_dev *rtwdev,
 	struct ieee80211_channel *channel;
 	struct list_head chan_list;
 	enum rtw89_chan_type type;
+	bool chan_by_rnr;
 	bool random_seq;
 	int ret;
 	u32 idx;
 
 	random_seq = !!(req->flags & NL80211_SCAN_FLAG_RANDOM_SN);
+	chan_by_rnr = rtwdev->chip->support_rnr &&
+		      (req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ);
 	INIT_LIST_HEAD(&chan_list);
 
 	for (idx = 0; idx < req->n_channels; idx++) {
 		channel = req->channels[idx];
+
+		if (channel->band == NL80211_BAND_6GHZ &&
+		    !cfg80211_channel_is_psc(channel) && chan_by_rnr)
+			continue;
+
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
 		if (!ch_info) {
 			ret = -ENOMEM;
-- 
2.25.1


