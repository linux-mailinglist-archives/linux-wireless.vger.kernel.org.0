Return-Path: <linux-wireless+bounces-7018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092208B67C9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4724282B0A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CA8BF0;
	Tue, 30 Apr 2024 02:05:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C238BE0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442736; cv=none; b=pD0c43/KLJHYiZL0REEMTkmdFhDrBkwT1SkSKLqTcE8kNYP4WTfbO2CpDbe9Rvzkg5dUe3UEMupdZaSJPwXIMfa5ctVfGDGOVZU8bKiWholJCvqTk9JJyc3TPUY6WXkB5qpEWbwCkpf4iknQ37d4tcNFIpljjEdj9FRIQ8G34mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442736; c=relaxed/simple;
	bh=BZaOHqSNkHCxymDnTE8RJmfseMtvPutF9zpNjXvlNA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poqITfwOS4aiMJEucFu+stL76kZ7JZEpFBLLcbaAPmjfEhBo7iyWjEX2kDK1oY+O15MmamLg639RJNV79it7oSIK8cCm4Ph3GObMHwvErPgHr7I+5YUKlynW6DgPwoR+bbh0hGCsAWGKJqYojbDyh5KxFsM+SK3+nXzxjaWfLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43U25UYs84079483, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43U25UYs84079483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 10:05:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 10:05:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 10:05:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: correct aSIFSTime for 6GHz band
Date: Tue, 30 Apr 2024 10:05:15 +0800
Message-ID: <20240430020515.8399-1-pkshih@realtek.com>
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

aSIFSTime is 10us for 2GHz band and 16us for 5GHz and 6GHz bands.
Originally, it doesn't consider 6GHz band and use wrong value, so correct
it accordingly.

Cc: stable@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 31d1ffb16e83..c4707a036b00 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -318,7 +318,7 @@ static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 	u8 sifs;
 
 	slot_time = vif->bss_conf.use_short_slot ? 9 : 20;
-	sifs = chan->band_type == RTW89_BAND_5G ? 16 : 10;
+	sifs = chan->band_type == RTW89_BAND_2G ? 10 : 16;
 
 	return aifsn * slot_time + sifs;
 }
-- 
2.25.1


