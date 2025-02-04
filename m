Return-Path: <linux-wireless+bounces-18466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83734A27A2C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E021882125
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAB217F50;
	Tue,  4 Feb 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApPQd6nO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E91218580
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694377; cv=none; b=MIiSnoOAve4tx+ZjspzH0EpSFrlq/ITMNl4KOCMXiU4c4g1tUG8yDx8CzbLlQncGoxEFuImZGhjxGuD1KZf+jMb/zEfWDBoW35QRtk8/tiZEEq4c40dqstgKA/+ndtxtErtLJAnQypOmBcSH5LlaEXkciCak6CIADL3CxBjvOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694377; c=relaxed/simple;
	bh=ffz1F4mAPu5eyCMwxAc+TfyaXVkccADNd14Zw3OdtCs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJVWlftP2f6c5KbsF6c3z4igZOA+KfhZmIJZiA037vBwML4cgKVAWxEj7crJBKG6C6aZx99NCcPw3DZXnkN+nFpfXnICPzor1shhfm9990q6x4qPi8i25b7eX2xxLWUYV7b8y8nK6Z3YMauips0uj3G5nwWgy6AY72Wxm7DDQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApPQd6nO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so11485643a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694372; x=1739299172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H5+7a8Re4dKW+BMIEI30vWTlU1os+zYewlN6x9QsUNY=;
        b=ApPQd6nOL6h0j/5+hAgYHRxKr1tGN21kZioK8XepueluVmmYkeZrPWZQZrtaMRGBPh
         2/xxvmTY4Q9ouVgYKpTj6xM6pnSCQmK2Up+nZIT6ehI/J4Xp4hEDLBTB0eNObYqxS+Uz
         24FvWdQWmGzMC9xim2a6uB7kIY8lZtCjpL6Pi5bx7zGAfezZ4JYX12CAXRAM+xsqcwpJ
         eTqvQR/MMH8NCNU4C2bzT/tBUPwa8UhMkTaNhSuuVa90SPkbW8hBYI/al5JTAozPS0CF
         1ZhdNaQ17QqUy17wvZ1oSc3n5P2DGmhqA/02SEwu+saf9FuMN/m4GXb3uiOFwD2C1u/7
         sLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694372; x=1739299172;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5+7a8Re4dKW+BMIEI30vWTlU1os+zYewlN6x9QsUNY=;
        b=pMDHuxZeqjgWL6RexoOGzwoBbjdbEOZPBb/VOa3UaaU7D2Q0limdaGE0YIBJBkJJv4
         7D6lp3xaOXAlfazXX2U33Fr6q39Qct4bCVCj0G6vmhdW2xnu5ILRRVwBVTCJVZYicedM
         tLhahpIou4Q0/AsvbNfxob+90rVxXjcYviXV7HmkeAB//6cLtkvFE/EceafEdaIOTqkx
         xVsVD9ZeoZy00vZ/6OUc9hl4wtuNLGDQSeDnCaWxL/eoPzaubNnxoTdkPkinPmCwptLT
         lh/JwshiGyKxYvcj36yeoi4B/rL9ag6PEi9K+/R6Cg7mMnIp2jJmoF0tVIlARQ3n3BDx
         h9dQ==
X-Gm-Message-State: AOJu0Yy0Yew8URFvF1oqHfZtVESWAkDiA6of2gcas+BPNvwtzvXGbTIQ
	yqaPt81u2tV+aGgwAyWYSfGcdxeDnLJSiUwjqY0c++RbiyTZjVvca2uGbQ==
X-Gm-Gg: ASbGncsdgRwVnWAJB0b5zTY01ckl6BfUaLSmCVegYV80GLQ/a2g1a6h6TmaNXfHszgz
	3r9HzHPK3xJVC20A2kDpFf+66tXUSvqCSFhVVB9uLEPq0FnhxiK3+x8n1YnGQLmC1TTFDQgTOzL
	5jYzWkDo/3amPG3rXZQ5EFiTyylbvqXPNXHOWgW8uvruojl+YG6y7gcwh4AGFtdNDFBPik2InvE
	2LOAQhi1SVeUogWk2++PBsduYQujSYt4+n/PeNKJWbsprxxau5NIw1ZvaSOzzNAHb2nRGfAzmO0
	UMZBlvYlVkGQAMBB7T17sv/N
X-Google-Smtp-Source: AGHT+IE/5tEToOwa2D+v7Lr9ixLDMX38ncYEN9qU9E6NhzCLe+JRlzco+Hzmp6aGHs4UZi8FURECzQ==
X-Received: by 2002:a17:907:c0d:b0:aac:4325:a604 with SMTP id a640c23a62f3a-ab6cfe25cd0mr2923895666b.49.1738694371658;
        Tue, 04 Feb 2025 10:39:31 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a2fa50sm958516466b.128.2025.02.04.10.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:39:31 -0800 (PST)
Message-ID: <08e2f328-1aab-4e50-93ac-c1e5dd9541ac@gmail.com>
Date: Tue, 4 Feb 2025 20:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/9] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The existing code is suitable for chips with up to 2 spatial streams.
Inform the firmware about the rates it's allowed to use when
transmitting 3 spatial streams.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
- Add RTW_CHIP_TYPE_8814A enum.
- Check the chip type instead of the presence of RF path C.
- Reduce indentation.
---
 drivers/net/wireless/realtek/rtw88/fw.c   | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h   |  1 +
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 02389b7c6876..6b563ac489a7 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	bool disable_pt = true;
+	u32 mask_hi;
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
 
@@ -755,6 +756,20 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->init_ra_lv = 0;
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+
+	if (rtwdev->chip->id != RTW_CHIP_TYPE_8814A)
+		return;
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO_HI);
+
+	mask_hi = si->ra_mask >> 32;
+
+	SET_RA_INFO_RA_MASK0(h2c_pkt, (mask_hi & 0xff));
+	SET_RA_INFO_RA_MASK1(h2c_pkt, (mask_hi & 0xff00) >> 8);
+	SET_RA_INFO_RA_MASK2(h2c_pkt, (mask_hi & 0xff0000) >> 16);
+	SET_RA_INFO_RA_MASK3(h2c_pkt, (mask_hi & 0xff000000) >> 24);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool connect)
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 404de1b0c407..48ad9ceab6ea 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -557,6 +557,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_DEFAULT_PORT		0x2c
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
+#define H2C_CMD_RA_INFO_HI		0x46
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P0	0x56
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P1	0x57
 #define H2C_CMD_WL_PHY_INFO		0x58
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ba64d269521a..993c381e734b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -191,6 +191,7 @@ enum rtw_chip_type {
 	RTW_CHIP_TYPE_8703B,
 	RTW_CHIP_TYPE_8821A,
 	RTW_CHIP_TYPE_8812A,
+	RTW_CHIP_TYPE_8814A,
 };
 
 enum rtw_tx_queue_type {
-- 
2.48.1


