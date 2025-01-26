Return-Path: <linux-wireless+bounces-17942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07CA1C835
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34112165FC0
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379425A64C;
	Sun, 26 Jan 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beUDQbi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA68BEE
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900198; cv=none; b=LqVJy1PKsXzo3DGDv2D93oDcSu0/c7YXxhTwtUIyg1O7jSgTq/Z2Wr73DNunDmiL81Vg0fwZ4uO4n3E0pSVp6b86QwHIJba+vizqiymeB9RZUSehkuWDYWmbtzDKXVyCaUXv2Y8YYkJL4lvfVdrjXHo2kacL6vFyFL7mFLzqtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900198; c=relaxed/simple;
	bh=TIDlDIhyGAup1rK0w+KvfA7T5wA1lkiaVNjjcnO3siM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AiovE8T8yqv9n9M1K8+7Te4yxuiiCNKf3sU2drL53OfKM6n1qW1r3BgFP6p5Mu6xujw+QC36fmgmv2cJFZOFku171ShzuBETuLzvyB478KlBjuU9E+WoTOoe+0GbtU9YFPc4oauQPKP2gi4tIHNSXZ6aftaAAXHvNskhzsYS3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beUDQbi2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385dece873cso1934039f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 06:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737900194; x=1738504994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjjhc42Sif5IHiUAzxNG3hRr5Vnha3Epy9ke7fBloAY=;
        b=beUDQbi2eAYVFgbrJ4F87zFLCU3OsqzVbBxgpdrKkVpxTvG8cg7/HtpK5z9GpwxAIR
         s6rDn9UKSaj/tvh4T2+mOnEONUuN4v7s95wcp20AiailVcKl8vVKHCsALecebFFdiWeI
         2pEhgNp+NGK1pTL5MGqVl1dAyvpeA74qI3q2tqSjcjM53ttW7ie87dbmCkhA+gHDv9Hc
         jDyUSx2Qs78e8kB0OIglrijPYcmABMmBFVdo4HOFLWIRF2weRs+dAaj1KlHV/VpV8WrL
         lM4u/WX1xfB+xqKFE1ecMmXj3LRSsegmvEBjZ16gkmOoUwDUoppEfUz/gR4t/6ETHzIW
         rmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900194; x=1738504994;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pjjhc42Sif5IHiUAzxNG3hRr5Vnha3Epy9ke7fBloAY=;
        b=JceusoqvcCk8WdFwMqZTfh9PnPzs0idf4lgPZq6tn4PctiW9SaZ43NyuifkTmjjXka
         dMa9nEdDvR1NrLPilTG8Zbm2Ba5Yb0OwLcjLzUcj4mtikqNVIri0G5J3jQ4qEDMeFRiT
         QeVhyKp4wRr88AeJjBZoi3/fRnPlMx71eUAKn9LlL041/9abFXaHs32RCCn+/xGUmmtf
         +U08+Dnwz1wkTITcd2cRKiO5eV1tcq8Qjuw8lWJ+/mGbX+8anXTkKqRaLGqeTwufj8Sw
         ryU+ErGElEi1i27IwFrsTKU+Ek/hxgHaYys6QJwP7KSahV/Y+EokQSQnuHL2PIQ9qCbz
         j21Q==
X-Gm-Message-State: AOJu0Yz6HTbpclprzt9S1NEEjBI/2XhXGFa7nDWPio6lM7nF1SwTM0XB
	x4zGgWKS7b2nt4vqMX/tHLTxT7CHJoqGZaQxvEAOrPVBPx1Ji8+s26SGUQ==
X-Gm-Gg: ASbGncs4M/8nbZm3cxZ5h42mRn5IvvY6vIJcGMfkVg85hsaWqHRX6RVFwiu2PYj8fwW
	mhx9LnEMsFte0q6Ol/zY/nAaKsDVsiLWT9KMFbIchDRVxuzBbRChOJpUAq3ETbqB1Sv7neeR6Gj
	iQZYd+oZgG/8cJw+TZRsYrh9ALXW5OOQwuU3Ke8Vis5IWlHrfnO+hHILFFjfqX+EOGYVw77Wtnh
	E3/ZvfEaAOMN3DiOHaz5uvIdu39J3U6UIqDdvkGEHw7EfNrafhHrIVMsIv8W6cMtEWSg8QpXmWS
	pRVbaWqvQjgy
X-Google-Smtp-Source: AGHT+IGFzYGfAI8/yKFm7uAHcLdDYLKLQhsmoAnWskH+BWcJqIYW3f2+6IhWJpLBYC1Eyc950MCNqg==
X-Received: by 2002:a5d:58ef:0:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-38bf57b380bmr33707342f8f.39.1737900193804;
        Sun, 26 Jan 2025 06:03:13 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a176538sm8043232f8f.8.2025.01.26.06.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 06:03:13 -0800 (PST)
Message-ID: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
Date: Sun, 26 Jan 2025 16:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: Don't use static local variable in
 rtw8822b_set_tx_power_index_by_rate
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some users want to plug two identical USB devices at the same time.
This static variable could theoretically cause them to use incorrect
TX power values.

Move the variable to the caller and pass a pointer to it to
rtw8822b_set_tx_power_index_by_rate().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 7f03903ddf4b..23a29019752d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -935,11 +935,11 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 }
 
 static void
-rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path,
+				    u8 rs, u32 *phy_pwr_idx)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	static const u32 offset_txagc[2] = {0x1d00, 0x1d80};
-	static u32 phy_pwr_idx;
 	u8 rate, rate_idx, pwr_index, shift;
 	int j;
 
@@ -947,12 +947,12 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 		rate = rtw_rate_section[rs][j];
 		pwr_index = hal->tx_pwr_tbl[path][rate];
 		shift = rate & 0x3;
-		phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
+		*phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
 		if (shift == 0x3) {
 			rate_idx = rate & 0xfc;
 			rtw_write32(rtwdev, offset_txagc[path] + rate_idx,
-				    phy_pwr_idx);
-			phy_pwr_idx = 0;
+				    *phy_pwr_idx);
+			*phy_pwr_idx = 0;
 		}
 	}
 }
@@ -960,11 +960,13 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u32 phy_pwr_idx = 0;
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
 		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs);
+			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
+							    &phy_pwr_idx);
 	}
 }
 
-- 
2.48.1


