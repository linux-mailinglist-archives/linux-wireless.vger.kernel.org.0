Return-Path: <linux-wireless+bounces-13063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E297D829
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43572284128
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562717DFE0;
	Fri, 20 Sep 2024 16:16:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540C18005B;
	Fri, 20 Sep 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849001; cv=none; b=UcRrzqAQVioPzlheYEjNhPSva1lpfFBwoST6mjBLzDMTwNtZ9ab/2JMLHARtnnXDo68UZlUULBycB0GMEDG4nVdXj2x54I0V7gs6euVX8FTPpTiQIkFyu/vv7OTGSax+yE61D0gjFyDyMup1ZENktAr1tT2+iFNNWCq70t/2y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849001; c=relaxed/simple;
	bh=5hFXnoW6ooKL6vv2N9VsYM6DZuuYE8fcOIy2YKi8hMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERjkFKDMSfrgCQOyoRZze8AHFFkoOZAKP3cMSnM/lHEKA0jbASD997QUGExXfv3sgcOq3uIKu0ynz/AeBjP3/2Deu0FMHgxJU6wy+rruGzrJKqSpvO2lL/Yrt/nV/ORyC0N3169SBnhHZr/tatg4/MGMlBtkzA7U5taVHpsfEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 20 Sep
 2024 19:16:28 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 20 Sep
 2024 19:16:27 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter
	<dan.carpenter@oracle.com>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 1/1] rtlwifi: rtl8192de: fix ofdm power compensation
Date: Fri, 20 Sep 2024 09:16:18 -0700
Message-ID: <20240920161618.21780-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920161618.21780-1-n.zhandarovich@fintech.ru>
References: <20240920161618.21780-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Ping-Ke Shih <pkshih@realtek.com>

commit 3f79e541593fecc2a90687eb7162e15a499caa33 upstream.

ofdm_index[] is used to indicate how many power compensation is needed to
current thermal value. For internal PA module or 2.4G band, the min_index
is different from other cases.

This issue originally is reported by Dan. He found the size of ofdm_index[]
is 2, but access index 'i' may be equal to 2 if 'rf' is 2 in case of
'is2t'.

In fact, the chunk of code is added to wrong place, so move it back to
proper place, and then power compensation and buffer overflow are fixed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20201207031903.7599-1-pkshih@realtek.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index b3f25a228532..6cc9c7649eda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -986,18 +986,19 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			rtlpriv->dm.cck_index);
 	}
 	for (i = 0; i < rf; i++) {
-		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
+		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1) {
 			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
-		else if (ofdm_index[i] < ofdm_min_index)
+		} else if (internal_pa ||
+			   rtlhal->current_bandtype == BAND_ON_2_4G) {
+			if (ofdm_index[i] < ofdm_min_index_internal_pa)
+				ofdm_index[i] = ofdm_min_index_internal_pa;
+		} else if (ofdm_index[i] < ofdm_min_index) {
 			ofdm_index[i] = ofdm_min_index;
+		}
 	}
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		if (cck_index > CCK_TABLE_SIZE - 1) {
 			cck_index = CCK_TABLE_SIZE - 1;
-		} else if (internal_pa ||
-			   rtlhal->current_bandtype == BAND_ON_2_4G) {
-			if (ofdm_index[i] < ofdm_min_index_internal_pa)
-				ofdm_index[i] = ofdm_min_index_internal_pa;
 		} else if (cck_index < 0) {
 			cck_index = 0;
 		}
-- 
2.25.1


