Return-Path: <linux-wireless+bounces-22811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC4AB23E8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596651B61F05
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D71F12F4;
	Sat, 10 May 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esV8GK+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5B2AE9A
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746882761; cv=none; b=eJmT4TuYT6dfV4HnRt9tygOHlrpyj7+R9GDdszREIpDGE8WHWhCtLjMMeJY+tu2abI3l5JPTSrsP+BHLmkH6bfETBS0UO+avQTvC2YCp5rcLEN96Bjrsl/0PUQBf4SSdIzZANFKKIF1nlDLhJ1pL5fnDGGQtQTLc712aOET+xEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746882761; c=relaxed/simple;
	bh=9Gm0Nf66+CZBpaFx1mBJBsX5ryMPReGTvA2cuweHOes=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=O4gRifpkD6F8tkUKLzKwzKOVPfyZxmIXBBAKbDH9/2UlINoWkmK7DqnuCxJ5iL60zltqdEwyAIFFkZiybpwT1omu9M1AXWvC9lA+F+74puPJ81pMbBpbjNh8mHRl0Np9wqMuONgNi669ycrMPLHLn6+qkg1wKOLB4fypOdQ0lGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esV8GK+c; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so4317145a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746882757; x=1747487557; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw7skhiUsTqTHcCJAnL4Z1dH9Cv/WWyGZCk9Gg81Tqg=;
        b=esV8GK+cCxSMZWKuX/IvVizOQYb+qaGhg9QR2odlz1WO9v1S6jocuF+MmcFffpc0kq
         2sbp3F1oPQiRnXTuwERhtYCN3RKgA8aFyAOI0nZc7uVHveujdjm56FrgJlnVpp0kEz95
         YR9bbeR1d7szU2gQ2zvOBP4brjLyVdTRyFdi6XLIaaCm3JHqNJzvqtkxj7uOACDdmSGz
         m8OSmdngKTvI1KslTsAgoqTemyR9dPszSgCjg41os59FujClPgbnpSMBU5+w6SRHoZvg
         cAiA09x8d75Knzs1Pcas9CEKsWhiSZBYQqoOKGqJs+0s4l6gMjXayhg3b7UHcxEBGurg
         5w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746882757; x=1747487557;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pw7skhiUsTqTHcCJAnL4Z1dH9Cv/WWyGZCk9Gg81Tqg=;
        b=E5ZafwEhSGgDTZe3/uvfZjzOjAjtx81KCSAsqPJ2c+VG0NHTfioOAGzLTHoi63fD0j
         obTelsyqk7LGrdgfqzsvMoPDZBVCMomUlIkdyo5TDDhK4mEtU8szovATu567hJWW7pZV
         S8IGdtbwHtghONBdVmwpLqvj5XJinzsDqvZ/6GEN3lpQbDp+wUQ8T5TGZlajVXlJBvOu
         x//aTAG9pIzsRkOB8NC7XZiUUz/kd3MbOadC0p9+w+fnckYPfwMV7Dr70ddRkvs2s5Hh
         XS3m3DWjR/kuPTbXP5a1dgm/gqkARNFWlY0vyT81ePYI0wTLCnRjXRw/CToe1ttqxdHV
         DlQg==
X-Gm-Message-State: AOJu0YxwiD0bku9ArxEhGOd1h+FzKZQQkKip2yBlFQMGDa0b67tZjSnC
	q3uXQBPY+HRAqcEU0iQELeHIdJ/KMM087wcD4Uu4AHkB5EMfnrZslu53vA==
X-Gm-Gg: ASbGncsSZo47jTuytUwSSXpDWi5uYgBOXKOgn9r6MfLQL2/eFBUb0Qic6G5W0zQ6FSz
	s64KvsOXQYsNrZFW2owK8Wc5z/Y2VjQwYD52AcccKtwLSVhJN1LeY5qSIv+Q86hkAeyX7csReqa
	NzaUq3OqxzMGPoFqHA2WqtXkf4gen9VCFCQ3TeK+MDCurIRtIK1J6HO94JdrjDAey7jab9qXwzt
	15oGi19PuN4nUgjHYfsiSQzom78UEjza5MlTzljZBRmb3TU107TcJ5QkpyqUomG+cgvmMcn4zhK
	MQ6F0ACSYuDutFr0bo7KGZMOkI+9Lo2yGDff4aCRpgIyed760UdIO5ftGHNz
X-Google-Smtp-Source: AGHT+IFhyL3bYEI71K/PTwoBU7loWj3WEcnnh9HOrhjKg4qtfVpBptzzONfGCPEzLPyknLg0ON+7hg==
X-Received: by 2002:a05:6402:360a:b0:5e7:5b30:3c4f with SMTP id 4fb4d7f45d1cf-5fca075e3ddmr5430519a12.14.1746882757271;
        Sat, 10 May 2025 06:12:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe58c1sm2883865a12.3.2025.05.10.06.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 06:12:36 -0700 (PDT)
Message-ID: <c248c40a-d432-47ed-90e0-d81ee6c32464@gmail.com>
Date: Sat, 10 May 2025 16:12:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Fix the random "error beacon valid"
 messages for USB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All the USB devices have a problem in AP mode: uploading the updated
beacon to the chip's reserved page can randomly fail:

[34996.474304] rtw88_8723du 1-2:1.2: error beacon valid
[34996.474788] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
[34999.956369] rtw88_8723du 1-2:1.2: error beacon valid
[34999.956846] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
[34999.956855] rtw88_8723du 1-2:1.2: failed to download beacon
[35017.978296] rtw88_8723du 1-2:1.2: error beacon valid
[35017.978805] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
[35017.978823] rtw88_8723du 1-2:1.2: failed to download beacon
[35023.200395] rtw88_8723du 1-2:1.2: error beacon valid
[35023.200869] rtw88_8723du 1-2:1.2: failed to download drv rsvd page
[35023.200875] rtw88_8723du 1-2:1.2: failed to download beacon
[35478.680547] rtw88_8723du 1-2:1.2: error beacon valid
[35478.681023] rtw88_8723du 1-2:1.2: failed to download drv rsvd page

Disable some beacon-related hardware functions before uploading the
beacon and enable them again after.

Tested with RTL8723DU, RTL8812BU, RTL8822CE.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 6b563ac489a7..4fc78b882080 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1466,7 +1466,7 @@ void rtw_add_rsvd_page_sta(struct rtw_dev *rtwdev,
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size)
 {
-	u8 bckp[2];
+	u8 bckp[3];
 	u8 val;
 	u16 rsvd_pg_head;
 	u32 bcn_valid_addr;
@@ -1478,6 +1478,8 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	if (!size)
 		return -EINVAL;
 
+	bckp[2] = rtw_read8(rtwdev, REG_BCN_CTRL);
+
 	if (rtw_chip_wcpu_11n(rtwdev)) {
 		rtw_write32_set(rtwdev, REG_DWBCN0_CTRL, BIT_BCN_VALID);
 	} else {
@@ -1491,6 +1493,9 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	val |= BIT_ENSWBCN >> 8;
 	rtw_write8(rtwdev, REG_CR + 1, val);
 
+	rtw_write8(rtwdev, REG_BCN_CTRL,
+		   (bckp[2] & ~BIT_EN_BCN_FUNCTION) | BIT_DIS_TSF_UDT);
+
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE) {
 		val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
 		bckp[1] = val;
@@ -1521,6 +1526,7 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	rsvd_pg_head = rtwdev->fifo.rsvd_boundary;
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2,
 		    rsvd_pg_head | BIT_BCN_VALID_V1);
+	rtw_write8(rtwdev, REG_BCN_CTRL, bckp[2]);
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
 		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
 	rtw_write8(rtwdev, REG_CR + 1, bckp[0]);
-- 
2.49.0


