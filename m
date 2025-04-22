Return-Path: <linux-wireless+bounces-21816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5FA95AAE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F6A3A59D4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7B191F6A;
	Tue, 22 Apr 2025 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dwMOJm1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA2156678
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286454; cv=none; b=lCdPqk8Y7RIWB1art3ssTSXUbC9ChDuxWet3wJxDaGYQ4s4i4WYqjYEEg3LpKQGAbpfUL4qBPuLVAobNxoATTFOXhBbTt2aHC4zp9cnFLbbbVYDSzyfKCMknXNqsqiGnTU73dgiR5iM2/iev14j/AFHcoflvYVIoC4dei70Kw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286454; c=relaxed/simple;
	bh=riFHpXIdj+nnZ/0/n++mSI+OQ24ilNmoXosU34v1kfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0rN0RbkhnppqHj+4EwHmYGyXdazP666z0RxTVCquysKszT1zO8bw7qc1ELcn3DQhVFBoad6C2gvc6+Ob/LRWKoNavc67uuaRG+x95qHdBXwl9sEqEwfYj1m5NE0W+L2I8PQRZ7M1FoVcy6VT32L2C0EzwLHC/DTvSDHI4oEXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dwMOJm1W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1lUpT53859593, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286450; bh=riFHpXIdj+nnZ/0/n++mSI+OQ24ilNmoXosU34v1kfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dwMOJm1WEofsGhZq4FUCiUbu6IPt9DUzv6/B+Jiz86Z3Y32eko0tN2+JbthYyWFpH
	 I9wbgJKa4XMj0DyImKovvMuF0Rk/Ew4rUru6DDFAr108uNoPbl2EjRnqVIMed/YKsJ
	 hWR7x6NnokuYugy+h6PMaNiYI+n4gketSr7ZlQZumpXcsSl8WjHfySUM09HKPJ2l2P
	 FYit3ighG+9tekte4L/O54fVglmG/fD9KR0Fr0BJ2Ev4ZBG1UFLeFNkKgqWdne8uL1
	 82jeCgNPS1/1nDhwPSz9SdH83/umLGk4XCzXjtKoQ5P1vtPAC5C8wreBKIPioZf468
	 PAqsfCsuiYfsw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1lUpT53859593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: mcc: refine filling function of start TSF
Date: Tue, 22 Apr 2025 09:46:19 +0800
Message-ID: <20250422014620.18421-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Since tob (time offset behind) could be negative, change the type of tob in
microsecond to s32. And, refine accumulation with while-loop by calculation
with roundup_u64(). Besides, as long as one of the MCC roles is GO, use the
short MCC start time.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index faa9fbe9d259..b54316eae21d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1455,9 +1455,10 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
 	u32 bcn_intvl_ref_us = ieee80211_tu_to_usec(ref->beacon_interval);
-	u32 tob_ref_us = ieee80211_tu_to_usec(config->pattern.tob_ref);
+	s32 tob_ref_us = ieee80211_tu_to_usec(config->pattern.tob_ref);
 	u64 tsf, start_tsf;
 	u32 cur_tbtt_ofst;
 	u64 min_time;
@@ -1473,15 +1474,15 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 		return ret;
 
 	min_time = tsf;
-	if (ref->is_go)
+	if (ref->is_go || aux->is_go)
 		min_time += ieee80211_tu_to_usec(RTW89_MCC_SHORT_TRIGGER_TIME);
 	else
 		min_time += ieee80211_tu_to_usec(RTW89_MCC_LONG_TRIGGER_TIME);
 
 	cur_tbtt_ofst = rtw89_mcc_get_tbtt_ofst(rtwdev, ref, tsf);
 	start_tsf = tsf - cur_tbtt_ofst + bcn_intvl_ref_us - tob_ref_us;
-	while (start_tsf < min_time)
-		start_tsf += bcn_intvl_ref_us;
+	if (start_tsf < min_time)
+		start_tsf += roundup_u64(min_time - start_tsf, bcn_intvl_ref_us);
 
 	config->start_tsf = start_tsf;
 	config->start_tsf_in_aux_domain = tsf_aux + start_tsf - tsf;
-- 
2.25.1


