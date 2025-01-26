Return-Path: <linux-wireless+bounces-17984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9EFA1CF0F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144AE18869EF
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFD481A3;
	Sun, 26 Jan 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djyTs+vr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C215672
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932194; cv=none; b=FU+lT+6+ntwrU7ConH74GuSF4cMYCkc8u/MgpUI3jSM08QUjv3jcopkBr7TxznsS1kEGlneYLn5NRZdioDeUVLl4F1sYuU4rkkaHKBd0jPW22r9zTfYf5BYlETf763Z19EDBEB3pMdzALyrPYyAMyuyG+4i2ivcrgyzlnBPnPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932194; c=relaxed/simple;
	bh=5bAcsapafvFcUgKVbCZ2tvSLLTtdVgRrqA52pTk16TU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kPx/BIluv2KbSJbO0vJf7h8kX3fetcs9fiZs3zZvwQ1zUoLGpVRRqw7I2L6pIpuW/WBwXhGjHabgHzfIVG26ySTV0xwjnyjeOskb7sEBhye1A7EZhIMkMgRlVaj9gIvHP1jOqwp11LZ35hUlhzSOjatZlQddMFm9RLedElQprAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djyTs+vr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436341f575fso41557495e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932190; x=1738536990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1wcQtmMnk6kFrc7dpl5z4c/qXyaxGiNpFhqFS3oGmg=;
        b=djyTs+vrDn2c+aZ896l5I7Ui6Epgep20VAWgLL9cZcpHyujtoqzQ2yNBmi3u1t8Sz5
         mUnbvfVoz6s0/RL6KOJc9+lECHU7VD4o7g6UmBR/XznP7kRJ3v2iTGnhHfG/TtP0vOG6
         vI0Rvd5SWluZZG2ABF4v33kQOqx6PuLmMHvS/O7kUsM3DARLg01CSzYVtiBX6Q7t74Gu
         WR2snFF1mQRIR18AioGy7k3YNFrdmHupb+IfkmxhS1Gh3wYhXXinl7v5mgxpTfDgJ2rZ
         oiap71SKoxC7QAWPEzzHHH7Qc1OmOG3DVgO976Rc2fhCnYYTSyqyqy8dVB9gyXQoALbW
         j9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932190; x=1738536990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1wcQtmMnk6kFrc7dpl5z4c/qXyaxGiNpFhqFS3oGmg=;
        b=kpW+uoeNe8sxUC1xxc0uZoT5ZLrIbhDJRD/a22woLXnO/NakhSU/TLQxqH94Rnywj+
         Qq7d6aQVLosifnYVKeCB9cmRHtlEN5kPT5xWOxmCdqeE1Uym8qbDTSNXzqSNSrY6UN/T
         8r+DYPTurgXx8ts6SwIr1xwzkoWBoAkfv8BojcwqXptMZq+tnVrYTq3ixq1AwuK7BiiP
         u9HVriuLsc7rF0pYJ0FmGch2q3UxM7DMM9KRWQQCn2ic4tPmD9sDVY5zoynIm3/b+63q
         AMDuBcgIjlFG/kJfuHBRO3dU94BSLC+JYv2h5c19B1qNtbdmhL55DVa8X3JN9zkgyB5W
         zhww==
X-Gm-Message-State: AOJu0Yxf/uoA4+oCt4akzvhrhOZ0njKPRwBxuXjrlEloNh6FBhnDb8eW
	S9K4G6LR7jZWDMo4PJ8cI23aj8anzMjK2WbX7/YE8jimRpG3+QIIQORtmw==
X-Gm-Gg: ASbGncsLV5DSFN4vepXrVA4fb6WNAyhDvDdeqZ29DbdIM6cXilTcabMI3FW4M7dyKDL
	ECzqVDxEJQK9w5vE/mevKUZ/nc2yKOmgjagvQNKyFWAl98OaNsfhHGEV4gcu8VZE/R+BjJuwWQW
	9igGF0Hoyr8Px1T43voiT8tGvz7EXlm80yHowj03eIkNtg/4lYu14FI3A5vkZVUoDdS/YpwGWFp
	yLJjOHkXozwdDMSfWlLRtAjqQmlRsLPbwVpRYvW2YtWm66jjvriuIlAlagbfFe5jwkmDOwFpgrp
	zCmkCLrnUpy4
X-Google-Smtp-Source: AGHT+IFVlFOy6yLVEixFV8+U3mITKfucb2wP/gkgnzIsjQR8MTz1n4mUbaJkAhjCJv/uvHmsW5QLdA==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr324363365e9.9.1737932190514;
        Sun, 26 Jan 2025 14:56:30 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857b8sm107664835e9.15.2025.01.26.14.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:56:29 -0800 (PST)
Message-ID: <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
Date: Mon, 27 Jan 2025 00:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The existing code is suitable for chips with up to 2 spatial streams.
Inform the firmware about the rates it's allowed to use when
transmitting 3 spatial streams.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 02389b7c6876..0ca1b139110d 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	bool disable_pt = true;
+	u32 mask_hi;
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
 
@@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->init_ra_lv = 0;
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+
+	if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
+		SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO_HI);
+
+		mask_hi = si->ra_mask >> 32;
+
+		SET_RA_INFO_RA_MASK0(h2c_pkt, (mask_hi & 0xff));
+		SET_RA_INFO_RA_MASK1(h2c_pkt, (mask_hi & 0xff00) >> 8);
+		SET_RA_INFO_RA_MASK2(h2c_pkt, (mask_hi & 0xff0000) >> 16);
+		SET_RA_INFO_RA_MASK3(h2c_pkt, (mask_hi & 0xff000000) >> 24);
+
+		rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+	}
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
-- 
2.48.1


