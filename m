Return-Path: <linux-wireless+bounces-18485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A6A2816B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D731889D07
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1F227B87;
	Wed,  5 Feb 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CEaiuvRC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FC22836B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719682; cv=none; b=jogpWx9lhVD0yGaNi7wawEweTn5OEKQ2jIzn5iJ9hNOxldm+blSJ0ElB8jjtjXbE0hkeUTJbJ6eDXJbHonOXfYXJ6N7pYopYMKHKqEp/NLOTVfylqExa+L4W+JyXCGAqVEt5WdAmidrS3edLMyv4/6XEf4Tlm2xG+weBlC7Dgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719682; c=relaxed/simple;
	bh=+CvGQhFgbCiziAveIz9mAl5lrUwJGlDCUufDruhvGQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNT7sFWhvX1lu4cgFCPad/7qo7c4D5MtINP660sptBU5g9H3fbNj3DRwKerB3OS3ewsDcp5v2emWCt6EjCYZSr4xIY6dVXc7g2YWS2V37hbcAIJKPJvNXhJW92M4RMHJ9UE8w0MKcA+Jt2XFu+xOGWLHD5L48gVSEpm8DXKRQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CEaiuvRC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5151fHJA1769087, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738719677; bh=+CvGQhFgbCiziAveIz9mAl5lrUwJGlDCUufDruhvGQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CEaiuvRCZdp1Zk+pa/8CDdgMbDGsdLywFpb8osZU3Tf/sPKUFeqz9XC0XJmoUtbe6
	 ECznd8ElasU+bBYL/gmFi94Tv9OY7UDKzFSVE60w7HPKeWYCCPNFvLu0VvGUK011ZI
	 wBCEwCU7RRZh4adsfSLLgolEortsMmSQXIJKQyQpS8DakOqGhhk6rkeRWnfX8D+zGU
	 ysdk3Pq0iAnr2hb4WGkWgQ+u2KnI1W0kITI7Fle/T+cv9tebQP1sYa+6B3/JIWBkV0
	 kL/DYCnHzLPtLj2HLC3WSvBCzB0A6OjW4onxBqITE8aSH90MfIS/uujBu+j8MXQWVS
	 ruV++7ePlko+A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5151fHJA1769087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 09:41:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 09:41:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Feb
 2025 09:41:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: regd: avoid using BITMAP_FROM_U64() to assign function bitmap
Date: Wed, 5 Feb 2025 09:40:51 +0800
Message-ID: <20250205014051.13765-1-pkshih@realtek.com>
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

Since there are two function features for now, func_bitmap[] has single
one element, which BITMAP_FROM_U64() generating two elements is exceeded.
Change to assign function bitmap barely.

With i386-allmodconfig (a 32 bit system), it throws

 >> include/linux/bitmap.h:736:33: warning: excess elements in array initializer
      736 |                                 ((unsigned long) ((u64)(n) >> 32))
          |                                 ^
    drivers/net/wireless/realtek/rtw89/regd.c:16:34: note: in expansion of macro 'BITMAP_FROM_U64'
       16 |                 .func_bitmap = { BITMAP_FROM_U64(_fmap), },     \
          |                                  ^~~~~~~~~~~~~~~
    drivers/net/wireless/realtek/rtw89/regd.c:20:9: note: in expansion of macro 'COUNTRY_REGD'
       20 |         COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW, 0x0);
          |         ^~~~~~~~~~~~

Fixes: 79a36fc56bea ("wifi: rtw89: regd: handle supported regulatory functions by country")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502031932.BMQ4lhJT-lkp@intel.com/
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 505a3d0767c6..0e67d0f128dd 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -16,9 +16,11 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 		.txpwr_regd[RTW89_BAND_2G] = _rule_2ghz,	\
 		.txpwr_regd[RTW89_BAND_5G] = _rule_5ghz,	\
 		.txpwr_regd[RTW89_BAND_6G] = _rule_6ghz,	\
-		.func_bitmap = { BITMAP_FROM_U64(_fmap), },	\
+		.func_bitmap = { _fmap, },	\
 	}
 
+static_assert(BITS_PER_TYPE(unsigned long) >= NUM_OF_RTW89_REGD_FUNC);
+
 static const struct rtw89_regd rtw89_ww_regd =
 	COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW, 0x0);
 
-- 
2.25.1


