Return-Path: <linux-wireless+bounces-18794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258AEA31896
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4321889076
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10A267714;
	Tue, 11 Feb 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZBmDjcg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1C268FDB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312737; cv=none; b=f9jXLuBMaFwklYcNs3Eo/ouoN7RPomJu0PwDQl5w207+Z6tOAqxfYNiBgCbqzDM8d6PMcIBsPGbWk9xjmCIV0eBnvpQKJOWkx22sp+dZ44nQ61GD6XU0m2SG8oWzZC1/DENiTP3E4YJyxBy7exMxk2oIo195l8hHaqGz2eAdylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312737; c=relaxed/simple;
	bh=q39GKe54wWsixypymdEc02ltQC77Y4eY9LP9seBWqdM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OCHYMXA/ppmgg/nE/N/dMOk+MqCLPebh+Z7U0c+u40WnlKLTEnfemEAU5WKCEOUxut9y+yn4XiA9x8c+BZ788a7/zv+kjD7jXI8BcjYSJ0EG6TfjuFIsyC1VeOLkXLRlhxQtT0SHHzcY926ZAH8skxk2pcC8qWyNUsnOsFxJEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZBmDjcg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so933113566b.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312734; x=1739917534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bF2VIE1a4aWIniUoomxj4NoiwWg/dsC1RN0XrnuE7Fc=;
        b=DZBmDjcgx2W+lFnSXlRP9mEe2ZAuF63D4s224Gu/R1Ou//5HDI8OwqQY+KNnm6+x8s
         KVW0WK6TjwzJ3TvCsbI3kp1wjxIb++kU3M1bE6Y24Bu7X4fizcSLS763IhkJPWDsoS2F
         KswV5hnDKuH193RXDipRU5uaqtRCGiXFTR72EDwD9z1X48BX0YkijUS4iJD85YeAw78j
         fdUC6G+fBbJ/W9+JseyzJbeBq6WaPd0y/uO8a6v6WDOdw0G3UreytN39FYAaNJDloQQL
         IIBZuNw5wrBW12sS2s2S/gmKUTZ6etD6rdfDcuZuKclwnCIU9zrnzt9M35lzeDmVTben
         KNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312734; x=1739917534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF2VIE1a4aWIniUoomxj4NoiwWg/dsC1RN0XrnuE7Fc=;
        b=GYyoapoeM5X7CF5V/vKfRsjeYHT7EpkeAnxD1msdUYtdKQ3a3G4aYiNdWNoDqdVBuS
         jwu4dJChvyHrck4x1ABSU3h1WMz4uP31bA/Xp6jyTJUZNosEsg3bUXLO4W1MYfXo85qW
         Kxom4q6NndFMIxjIUqjS03qbs199Xz29pMeBXrZqj/hdZ1NevT2lMxFM5ToXH3t5rUzO
         Nh/zJp+L7Ln5MBz7ll8P+rHCLPPWNduhDHeVqEE54mk/i4YCizCHgno0x+OrDBXR8kU2
         98EXtpvdcLJxjCrxb8Z+rTrmwIKB57F1390qNJju0n53AJ/vSS4ESf7q8NNoVlnm+03m
         I3rQ==
X-Gm-Message-State: AOJu0Ywa8t+CSVWCNipqwlt9pEBlhlvKQBv81NvWPL7jNMdjk93KGDrE
	b1V5iAw+vSuiOGTp5bZLk0CLjun82ZigRJXP0QUxQK1wxY6gCKNvX90m9Q==
X-Gm-Gg: ASbGncuL1Y6MLNNdDaxD9XunLrN6+UBN/w1eAt5X2MgK8hfcbPvRMdeMvg7VnX5x+dr
	Aa95Bl3j2KwehEEG8Zwkk1wX4qcynfNPOj3CbrFqkdveF7UyQByAfZBPlK48mzsrQikdRInccjw
	BYvGi+D/pinCPEgdmPee68CQVJjRpHwg2roXz0fZ8H/RkhPx+0qyprunQAzC2zk3Hs+mpbWvsjp
	OYRFhPiBHhYTvxvdwLMIRJ2IqK7ZRJ96WhVfU66IXIoK5yF10o2uTHTlkEuJ6ZFvoyaWcUlqigG
	Hp8Q7VpDtbVniOcJWqzTgsaY
X-Google-Smtp-Source: AGHT+IGTRJ9+6u/xsS4CxSsgFiudc9me6E3ZfilGOo0bsJtb88NNDYpdb7DWepxxFJCetzRjZoAmJg==
X-Received: by 2002:a17:907:d1a:b0:ab7:83c2:bdbf with SMTP id a640c23a62f3a-ab7f347aa61mr66847566b.41.1739312733480;
        Tue, 11 Feb 2025 14:25:33 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e9853560sm136911966b.111.2025.02.11.14.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:25:33 -0800 (PST)
Message-ID: <2af9cee8-1b4e-4d97-bbf6-4f793005f910@gmail.com>
Date: Wed, 12 Feb 2025 00:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 7/8] wifi: rtw88: Extend rtw_debugfs_get_phy_info() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Print information about the 3rd and 4th RF paths and about the 3rd
spatial stream.

Also, fix a small bug: don't show the average SNR and EVM for the OFDM
and HT/VHT rates when the rate is actually CCK 11M.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 37 +++++++++++++++-------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 364ec0436d0f..1adb03d1210a 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -654,10 +654,10 @@ static void rtw_print_rate(struct seq_file *m, u8 rate)
 	case DESC_RATE6M...DESC_RATE54M:
 		rtw_print_ofdm_rate_txt(m, rate);
 		break;
-	case DESC_RATEMCS0...DESC_RATEMCS15:
+	case DESC_RATEMCS0...DESC_RATEMCS31:
 		rtw_print_ht_rate_txt(m, rate);
 		break;
-	case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT2SS_MCS9:
+	case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT4SS_MCS9:
 		rtw_print_vht_rate_txt(m, rate);
 		break;
 	default:
@@ -849,20 +849,28 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 			   last_cnt->num_qry_pkt[rate_id + 9]);
 	}
 
-	seq_printf(m, "[RSSI(dBm)] = {%d, %d}\n",
+	seq_printf(m, "[RSSI(dBm)] = {%d, %d, %d, %d}\n",
 		   dm_info->rssi[RF_PATH_A] - 100,
-		   dm_info->rssi[RF_PATH_B] - 100);
-	seq_printf(m, "[Rx EVM(dB)] = {-%d, -%d}\n",
+		   dm_info->rssi[RF_PATH_B] - 100,
+		   dm_info->rssi[RF_PATH_C] - 100,
+		   dm_info->rssi[RF_PATH_D] - 100);
+	seq_printf(m, "[Rx EVM(dB)] = {-%d, -%d, -%d, -%d}\n",
 		   dm_info->rx_evm_dbm[RF_PATH_A],
-		   dm_info->rx_evm_dbm[RF_PATH_B]);
-	seq_printf(m, "[Rx SNR] = {%d, %d}\n",
+		   dm_info->rx_evm_dbm[RF_PATH_B],
+		   dm_info->rx_evm_dbm[RF_PATH_C],
+		   dm_info->rx_evm_dbm[RF_PATH_D]);
+	seq_printf(m, "[Rx SNR] = {%d, %d, %d, %d}\n",
 		   dm_info->rx_snr[RF_PATH_A],
-		   dm_info->rx_snr[RF_PATH_B]);
-	seq_printf(m, "[CFO_tail(KHz)] = {%d, %d}\n",
+		   dm_info->rx_snr[RF_PATH_B],
+		   dm_info->rx_snr[RF_PATH_C],
+		   dm_info->rx_snr[RF_PATH_D]);
+	seq_printf(m, "[CFO_tail(KHz)] = {%d, %d, %d, %d}\n",
 		   dm_info->cfo_tail[RF_PATH_A],
-		   dm_info->cfo_tail[RF_PATH_B]);
+		   dm_info->cfo_tail[RF_PATH_B],
+		   dm_info->cfo_tail[RF_PATH_C],
+		   dm_info->cfo_tail[RF_PATH_D]);
 
-	if (dm_info->curr_rx_rate >= DESC_RATE11M) {
+	if (dm_info->curr_rx_rate >= DESC_RATE6M) {
 		seq_puts(m, "[Rx Average Status]:\n");
 		seq_printf(m, " * OFDM, EVM: {-%d}, SNR: {%d}\n",
 			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_OFDM]),
@@ -875,6 +883,13 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_2SS_B]),
 			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_2SS_A]),
 			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_2SS_B]));
+		seq_printf(m, " * 3SS, EVM: {-%d, -%d, -%d}, SNR: {%d, %d, %d}\n",
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_3SS_A]),
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_3SS_B]),
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_3SS_C]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_3SS_A]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_3SS_B]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_3SS_C]));
 	}
 
 	seq_puts(m, "[Rx Counter]:\n");
-- 
2.48.1


