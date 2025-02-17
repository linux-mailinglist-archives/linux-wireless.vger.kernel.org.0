Return-Path: <linux-wireless+bounces-19082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A76A38FA5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3093A6439
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28921A5B83;
	Mon, 17 Feb 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV7Yz9zw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797015666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835141; cv=none; b=BUjBD3hO3iXt706NsQ9ina0I3Nb2CxsWbbHo0SOxGKYCEuR3EEJVPSusfncUNUqXKaiVMWscfFlwDK8+gpR+W8qCJ9XI/4xlC9pbouAPi+zCdeSTsvdoz3PvC4bkC42I3P9xv4d37ObFncIV8rED7rVQ5/mceErWfw2ScV/q1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835141; c=relaxed/simple;
	bh=KKPK28GkhPHcnf2YJXUIA3CvApVQ9JI7h4oh1eQrEFM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NFqlfd9TRR60r3kFIYpL5AaXOp6kFkDhDVc3gNMTONQtMrrx6NDy0vM9sXy51ei6IA46/zdLC7z6bIQ2sC6dnxXdjnoPxAp5D1XACrs1PxiEkx8uH0ZhC/AyYPQc1IYkfZdDvU51DkV4/FhuUFgW02qvzA4/QODiVEv3iF6uL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV7Yz9zw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso3035890a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835138; x=1740439938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JHtu3gWiPwMihPPm+h3WIQAJyj7ggSzm9jjAZ3Cr5s=;
        b=JV7Yz9zw4s7/ipKEpr6JEGkoIAWtn2pN0fZZCEKy74VLj1W/3aR6Xuf1wQtn2+6mNn
         vWF0ew0gF7qMNrbXdZblaCDV0pwOdmqOCUatDnrPXTIkp9Yhg5WT4S6K+VLGbn1cqGo9
         eemf/495km448LC3SlFiM2aGLC9a9e6cRvZjxxLCsZuj/7IYSrS2qdybAsCOZvad9Nhp
         XB4bDZP0oqlcVjhz7wZDgqkEzz7PUNQ290Ui0AQG4aIuu14PWw0Hxo8Apj+O2FL8CB25
         2Ne83UErhulrs7bRCRhlU/I3/p69jcCrC7SrPgif9VOhnXAPumU5lgBWB5v6UjG6zpeK
         jyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835138; x=1740439938;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JHtu3gWiPwMihPPm+h3WIQAJyj7ggSzm9jjAZ3Cr5s=;
        b=o4iFr+yLJAbFXLMt6PE0un3A+QiqcjyHBFXEc0YD8V/KU5DWO6Y4Ce9F3vvai8A+4J
         Eggkiu8lrJsz0/KQwuMRACvVowJ8odmcDMwblZbEwqetO684/USnlR/0e9tTnM2YUIww
         idS+ccNFkQ9Nm+EruIOqk9IiW3vztBWK2vfrd8f3XrqFM8I2Jh8ziNBJL6CvapVdRGMe
         Cr4YAZLzJ86QsQB6g4vK1Qlq+tRJvVwvref+UveQI68a+kRkYG2Gv+diWHTH2L5WN6ga
         7iElpdIqBomBemlW3E91nPb1zO7cK9GB68cZd4Z/F00ao9tlbi/VXEOFkiT+WpX5b+QC
         aG1g==
X-Gm-Message-State: AOJu0Yze2XPEHATaJBRDUhhM4j5O/iGzpoynyyDEaLl+LPunA2br5Or9
	ecHOcpmlz74qM4enKeS9/jXH8wWMWqTMuoolsSlFEtTQmrqRouevslhyBA==
X-Gm-Gg: ASbGncs/QyBGSC2yidAeAzaSIsOrcXjLOrs+CiMbwOSR88mSzJair2kpodmGbf+c11F
	CMfJHKW+anS+HkVmf232xzNRCZcbvk4erlRMCUYxtWRVdtHC1tpZU+7LC8AQ5H0/U6FuPDAao+c
	A5czQTRIJlj2gL/LsEbHRgFMJNnrPd/8XaCAzmN6wdI2gIE9hRDqDp/UyfDAESIpnDquX1Ok3xg
	YJcJPdh0LvwU4etMq0rGaQgBdpPn//bYSlHPqBNciWeunJd/1q3yTDMtmeuP1/m8NTYn10Y/kiD
	0eqwHTawp6PRZOQf2kOrrvw3
X-Google-Smtp-Source: AGHT+IEXd/hyxrEWm4cI5jFtwEw3b3iqDxPVr/dcQ2RuPzOx1uiPJ5lATEUCB7+eDQ0qicH6ZiAOTg==
X-Received: by 2002:a05:6402:50cb:b0:5de:5718:296 with SMTP id 4fb4d7f45d1cf-5e0360318a7mr10634832a12.13.1739835138020;
        Mon, 17 Feb 2025 15:32:18 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2721d9sm7971822a12.56.2025.02.17.15.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:32:17 -0800 (PST)
Message-ID: <7c8e94e2-e034-40f3-bdaf-b000018b5573@gmail.com>
Date: Tue, 18 Feb 2025 01:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 7/8] wifi: rtw88: Extend rtw_debugfs_get_phy_info() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Print information about the 3rd and 4th RF paths and about the 3rd
spatial stream.

Also, fix a small bug: don't show the average SNR and EVM for the OFDM
and HT/VHT rates when the rate is actually CCK 11M.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
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


