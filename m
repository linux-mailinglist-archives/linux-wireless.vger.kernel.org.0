Return-Path: <linux-wireless+bounces-17822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F99A18BA3
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7097216965F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD2199240;
	Wed, 22 Jan 2025 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mij/3El6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59918E361
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525861; cv=none; b=d5KbagOgQjbcM9j3HWfmDFJ+uIkpEZp+jhhMYRD1k4uDT/AcN7C6uo59/eb5oVvD3gQwISjutk+EIlgolR/k/cbV6jlFv5wW2CpUUjBRZDsPx9pJ9PXfIF3wVV1UgSQ2IjsdY4MDMmNPnifjGcy6scwQb4+dAuC6MghjCmrEe+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525861; c=relaxed/simple;
	bh=iE2s6IgLO2QIOrMAq6oUEYatVK3F70hzR9XVhqr4FT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFlBbn4V/rvoVJpO8UGElXEKTjqD4rpjJAuAbXiWP3XIQkKOarMpgbzGaTPAMuYfcE7rtfhLsMIlBWPRr839pruhia14nwM7MxqXwpBEnvdl13cTXuwgQUlt3etnBS4zYFtW5OJHytbJJNChvonip2hGCnF4t8CLOIe9FcJ6Mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mij/3El6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M64HAG02495232, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525857; bh=iE2s6IgLO2QIOrMAq6oUEYatVK3F70hzR9XVhqr4FT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mij/3El63TVb7kOarl/FTOnNP6bKkyydQEsKLhibxPfdfIYq5T63vddCYPCVm34Fn
	 GTn5ABM0WVTYPmE1VGbeMkOtEbi+XG7o8IOwWQaoCEM8nT+qx+w3/Xafr5aTzm+8e9
	 wJZeJdGX38R5KbZs8gXBJjv8teVvOpyW/wizw/X4Irc0LGHeiQBeQEl46XrV2DU/kB
	 qwAn/T3CiYZ7DdH3rJPFSxgyaeG+XP30vs/b1pfcFIXtcCJVcfli4TFmEsM/OejwSz
	 IV+DH3l9Zk9t4ZHcyQ4ki2UgVbGhDdKVvz/2HAuni3nK3HVbcLzTvWkzeUonK+E4Ny
	 3kxUOKoGWDbDA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M64HAG02495232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:04:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:04:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:04:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/10] wifi: rtw89: remove definition of driver mutex
Date: Wed, 22 Jan 2025 14:03:09 +0800
Message-ID: <20250122060310.31976-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
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

No consumers of driver mutex now, so remove definition eventually.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 --
 drivers/net/wireless/realtek/rtw89/core.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 60bb53b53f46..df8468cfbbb2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4831,7 +4831,6 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		return -ENOMEM;
 	spin_lock_init(&rtwdev->ba_lock);
 	spin_lock_init(&rtwdev->rpwm_lock);
-	mutex_init(&rtwdev->mutex);
 	mutex_init(&rtwdev->rf_mutex);
 	rtwdev->total_sta_assoc = 0;
 
@@ -4890,7 +4889,6 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 
 	destroy_workqueue(rtwdev->txq_wq);
 	mutex_destroy(&rtwdev->rf_mutex);
-	mutex_destroy(&rtwdev->mutex);
 }
 EXPORT_SYMBOL(rtw89_core_deinit);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 947e8b094912..96ca66bfee84 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5631,8 +5631,6 @@ struct rtw89_dev {
 	struct rtw89_sta_link __rcu *assoc_link_on_macid[RTW89_MAX_MAC_ID_NUM];
 	refcount_t refcount_ap_info;
 
-	/* ensures exclusive access from mac80211 callbacks */
-	struct mutex mutex;
 	struct list_head rtwvifs_list;
 	/* used to protect rf read write */
 	struct mutex rf_mutex;
-- 
2.25.1


