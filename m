Return-Path: <linux-wireless+bounces-13747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C6995C68
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A628302A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF21C13B;
	Wed,  9 Oct 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rjD//ALD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5715E8B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434616; cv=none; b=oR8ztfTJRoh7PFovOfMY2kY3rTxZgAQNcWNUoZrkif4t51fpbZ4gmed6IRkD249T0XBqAWYIbOlb9hr9B0EGuRisOQXr+lS/ToUDcrx+FVjuCbF+OD1f+4VThMLK7Fbq1vST2lxLLErWXjd3hlJ1jFcS8E9NZS4yO0e2hcRfpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434616; c=relaxed/simple;
	bh=SEZ1YJPBMZN04jxnu+BECB1F7H/I9to9yD4cPtWfrzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG5lENzNYWWBKAJ1UGYkMnL7PY9e94UXMKyz8k08BNZxgIM0YlOzViAb/W1VU2+yinCDGTeqlBisOV1p2vVxMwk5G5+mhQKUwa8ZJwRl4/1/DUV4hyt4qbYSBBgjhc9k0jiOo1jUOgkLuh/jUhVBcj1Qa4UVq8Jux8qMCMx1ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rjD//ALD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hW8w94153826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434612; bh=SEZ1YJPBMZN04jxnu+BECB1F7H/I9to9yD4cPtWfrzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rjD//ALD04NQjWjIlo/GLvMD4gynUFAOioL0k5zpiKhS+KaP/keUGC8OHZbufqg/o
	 pzEmhvpuwyigeYP3s7+0NA0BWL9rrYDl+eqBPhYhr+24//nrFZvsSUuyBrvjShiGh1
	 7AGmSzS40vifLwojeW8YplCNWDVvvBuPMy72IWPaIK3no88+4AdcDbPkjlvqmJDUMg
	 f97rYNVLPAqSRYXnjrU/ond/Mrg92Agyijlt3DbJBAdVyxSt73QIixv3dFmVRCzGiE
	 Se9SpGY++BhvE/zBUYMTJujdaV0JbgwZmhsJ96mOTbIL0u7CdzHjSJn54do4hwc33+
	 Oagm0Fsfkabow==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hW8w94153826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8852c: use 'int' as return type of error code pwr_{on,off}_func()
Date: Wed, 9 Oct 2024 08:43:00 +0800
Message-ID: <20241009004300.8144-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009004300.8144-1-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com>
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

The return type of error code of rtw8852c_pwr_{on,off}_func() and its
callee is 'int'. Correct it.

Addresses-Coverity-ID: 1626056 ("Overflowed constant")
Addresses-Coverity-ID: 1627945 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dbe77abb2c48..c58b3e8068f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -203,7 +203,7 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	val32 = rtw89_read32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_PAD_HCI_SEL_V2_MASK);
 	if (val32 == MAC_AX_HCI_SEL_PCIE_USB)
@@ -324,7 +324,7 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
 				      XTAL_SI_RFC2RF);
-- 
2.25.1


