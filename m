Return-Path: <linux-wireless+bounces-24250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43AADECFB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600423B4D27
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4AE2DF3F2;
	Wed, 18 Jun 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MKO/buIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD02E06D0
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250857; cv=none; b=DBXSwcKorykZ3OetL2DKZJZLPna3F8Nx0tmPp2DK6Gwk16p37YOHlOSJcUBPIeEqDerNxjSGIKtPWx58Wz9lP5chwHNv88/dq8DdAzNbtmc3irkDmmogfAe0hyQEktC2WHMGgnIXutMH+0WIv13bon1IRDsDSkqlC7iQPt6NPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250857; c=relaxed/simple;
	bh=Q9rZ2SXuaNZdzmGEynjdQvd45dkPu0QAghtwFhqd8dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1HIWSPAM+pu3rX2jDQ1l4Vidq17mB74uCvHrEzQeL9MVDbpBkvGlQj8oIZfrjo8roNvBIdchnVsD2IXE3DNR/T/JfGKBmDNRKLfVAB4THJk7OoJYDkt9QlT+iN6hLuRRQiRMtgQrF/LG2u4jF5HwVxm0S//UorfqPmIk7UbJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MKO/buIz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClXYe94151167, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250853; bh=wgS/QzgTTzLOQ0cq0qsmvY3zpfhgs0egyiotEKWBIb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MKO/buIzUnxkjfBYULDrAeNE0nJsaSa6okapm1ik9LFcz+08Gf6X2G+GvcYgJ4xBt
	 7a2s4fA2qJmy4k0EYezHm13ZzCJc3gHhmKVcUiZRWjLcWck8VADEBt/IkUBqmwJ8tt
	 IGl4HSNGEiPVr6aK5EudvbdpYzbRrM+ISFrmG15O/gFbIg5RMLNZNsKPmxvmsjb70j
	 GjpPBVE/rBSnoRD11ACZZQa6upiPNR84cB+JMJ+DD3hFHaDdjK/m52JcbI9wxNeDkA
	 aT96CsY9fogWvNH9BMtapQSwcoSOSm269NH+vfS799rdpuUzBTmEC97493cIvtKtxA
	 Uq4cgFenXxTiQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClXYe94151167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 20:47:40 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/6] wifi: rtw89: correct length for IE18/19 PHY report and IE parser
Date: Wed, 18 Jun 2025 20:46:46 +0800
Message-ID: <20250618124649.11436-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618124649.11436-1-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

Correct the length when parsing with 2nd IE header and the length
of IE18/19 PHY status report. These two IE contain PHY OFDM signal
information and can be used for debug.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4026cda04ef6..d0d2ca31b376 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1723,7 +1723,7 @@ static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev,
 		},
 		[RTW89_CHIP_BE] = {
 			32, 40, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
-			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
+			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 88, 56, VAR_LEN,
 			VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
 		},
 	};
@@ -1918,6 +1918,8 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 
 	pos = phy_ppdu->buf + PHY_STS_HDR_LEN;
+	if (phy_ppdu->hdr_2_en)
+		pos += PHY_STS_HDR_LEN;
 	end = phy_ppdu->buf + phy_ppdu->len;
 	while (pos < end) {
 		const struct rtw89_phy_sts_iehdr *iehdr = pos;
-- 
2.25.1


