Return-Path: <linux-wireless+bounces-13133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359F9850AD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E925B22B47
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533FEEAE;
	Wed, 25 Sep 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wxBkLKeN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8781136672
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228401; cv=none; b=G5Ej+Ub/lc7NKm5S7JnMID2BlZKkUS9fE9FvF7XmQOsMEes49bPhtCaWBpXPHWt+Wd7gv7MsCpJreFpqDvH/UkHReLlqfa7rhOtTtfppqdMGyfKU6uh1rftZfb1DX4/Iata257Y2lIlbhQXNHP96iR2NxrXYtyQtIy9fA69I0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228401; c=relaxed/simple;
	bh=HjKwFGe3hw9O5eyqFbFEI7SulR9j/WX6/WVSsJx2TC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4DIiYb4KcbQn2PjNN0j+SfBE1mfWkZL1Gmh19Qn6lmFjEGpxSjQmdXqfEwvFqTGgx5ZThcJnw6Wkh7mhT3d5TYHuP2YvgDZjisiB7CipV+I/S18Y4eKkmqNWfYSCj3ipnUhTgi6cdHh3yjkYo9IkuarbXAIla85PUwtRXcg6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wxBkLKeN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1dveL73834599, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727228397; bh=HjKwFGe3hw9O5eyqFbFEI7SulR9j/WX6/WVSsJx2TC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wxBkLKeNd7/Pt7h53dGm2tGwzYGKNFv/eyau8m0au7+um282t2sWz75I4BaO5Y+WJ
	 VY9UxamBMQfayK9u7qcnOXsUFM34CAU498z49OBcQ8QdfHJzrFFzad+klW5KIitIO7
	 cFde6PIEPJl1f3FvLuh/fkZoplny45EN46qgVQliuRPJZrt1cYUmmpYjm5RRMuZGK4
	 YrTsc7LNr3lnhe9hMAM0aRN8FBp3O8T9tfj31HHv4wrD4tvCuTRwnj95FFep0YkAbV
	 rCIBN2QwRBn9EMiWyYh8eBCxtQDazgL6duZ72Xj2HGlZ1EExXlrgRah1nwgHb3qwht
	 WKlcKVeolYASw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1dveL73834599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 09:39:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:39:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 09:39:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: 8852ce: fix gray code conversion for filter out EQ
Date: Wed, 25 Sep 2024 09:39:00 +0800
Message-ID: <20240925013901.9835-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925013901.9835-1-pkshih@realtek.com>
References: <20240925013901.9835-1-pkshih@realtek.com>
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

To use manual mode to set value of filter out EQ, read the source value of
filter out EQ coded in gray code, and write to the target register in
binary number. The function to convert from gray code to binary number is
wrong originally, causing unexpected EQ, so fix it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c1e0861b7b3f..45d536b818e9 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3724,19 +3724,16 @@ static void rtw89_pci_free_irq(struct rtw89_dev *rtwdev,
 	pci_free_irq_vectors(pdev);
 }
 
-static u16 gray_code_to_bin(u16 gray_code, u32 bit_num)
+static u16 gray_code_to_bin(u16 gray_code)
 {
-	u16 bin = 0, gray_bit;
-	u32 bit_idx;
+	u16 binary = gray_code;
 
-	for (bit_idx = 0; bit_idx < bit_num; bit_idx++) {
-		gray_bit = (gray_code >> bit_idx) & 0x1;
-		if (bit_num - bit_idx > 1)
-			gray_bit ^= (gray_code >> (bit_idx + 1)) & 0x1;
-		bin |= (gray_bit << bit_idx);
+	while (gray_code) {
+		gray_code >>= 1;
+		binary ^= gray_code;
 	}
 
-	return bin;
+	return binary;
 }
 
 static int rtw89_pci_filter_out(struct rtw89_dev *rtwdev)
@@ -3772,7 +3769,7 @@ static int rtw89_pci_filter_out(struct rtw89_dev *rtwdev)
 		val16 = rtw89_read16_mask(rtwdev,
 					  phy_offset + RAC_ANA1F * RAC_MULT,
 					  FILTER_OUT_EQ_MASK);
-		val16 = gray_code_to_bin(val16, hweight16(val16));
+		val16 = gray_code_to_bin(val16);
 		filter_out_val = rtw89_read16(rtwdev, phy_offset + RAC_ANA24 *
 					      RAC_MULT);
 		filter_out_val &= ~REG_FILTER_OUT_MASK;
-- 
2.25.1


