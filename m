Return-Path: <linux-wireless+bounces-10721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432A942762
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D05AB23DDB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2011A4B3A;
	Wed, 31 Jul 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pLQ1IMMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681316CD03
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409549; cv=none; b=nwI/tucO3K3bfNIW+MAXeySx2IcO75rG88mqB4cBwXThNt6ytXnRJP8K0WhrD2E58vWdQbMO0wde2UYBK2zyV9BwT/ONtM+G5a9QbsKNr6JzpvIhRfCTMWyPE5kVvzTAFMRfnbgTCBIVOUH5yZlh5DTdm8pIhfjz/lmkPzUSqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409549; c=relaxed/simple;
	bh=ktHKWszYunafo/JQmyeEK0fVVuyFaXcj1bLNSKA16sA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9ADw7IyiKsndUi2t0YR+wcTRK728zVe5oowC2ttDUD/bGOcj1XMaYAffIYIMjEgIRjw2I8NJe+dNvm43cM3BHCPt+EtArN9i3IeG7jxuzteS8IXe6312wY5bVPh8J99MtjOdgVOUefSutJW8U9QhfuVk2saveZUeeRTvKduYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pLQ1IMMt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V75j0L22075750, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722409545; bh=ktHKWszYunafo/JQmyeEK0fVVuyFaXcj1bLNSKA16sA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pLQ1IMMtCyxKHtlU7vu8m7L+JiWiG8AuqhXOGXdfjz4F/3Vdv1cht3IIfdZFd04Wf
	 vQzN1sDGLEwD3ZSxtHhRPwGNIQLCmA5kqk3quMFtaWJFm2girZftDDBjW7LZPeqHsy
	 WNklTTN85syReld5mbp0GA7qp9AcRSz3XXeUPJTEeqnw5Xu9+nuHzF+QfqZMlSORMy
	 8Janjk7zvAfZYnENqnYpJPMO6Z5nFDi4vVGiMrfx4ucp0xNxI9hUZpAY6UtzqhOD20
	 Bo29g1l1EE95cm6wYy3WEIbky3/Pp4SEMV5EDVvMMrJsesfA36TuClrVixhvbsfdvF
	 H88iw8InAjBEQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V75j0L22075750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:05:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 15:05:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 15:05:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 5/5] wifi: rtw89: correct VHT TX rate on 20MHz connection
Date: Wed, 31 Jul 2024 15:05:06 +0800
Message-ID: <20240731070506.46100-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731070506.46100-1-pkshih@realtek.com>
References: <20240731070506.46100-1-pkshih@realtek.com>
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

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

It may get wrong bitrate when connecting to AP set VHT 20MHz,
and thus we fix it to follow Wi-Fi spec.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index aa20b3e9d3c6..93c4ab7a83e5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -341,8 +341,11 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 
 		mode |= RTW89_RA_MODE_VHT;
 		csi_mode = RTW89_RA_RPT_MODE_VHT;
-		/* MCS9, MCS8, MCS7 */
-		ra_mask |= get_mcs_ra_mask(mcs_map, 9, 1);
+		/* MCS9 (non-20MHz), MCS8, MCS7 */
+		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+			ra_mask |= get_mcs_ra_mask(mcs_map, 8, 1);
+		else
+			ra_mask |= get_mcs_ra_mask(mcs_map, 9, 1);
 		high_rate_masks = rtw89_ra_mask_vht_rates;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_MASK)
 			stbc_en = 1;
-- 
2.25.1


