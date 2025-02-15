Return-Path: <linux-wireless+bounces-18968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA1A370F6
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C571892909
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2B153803;
	Sat, 15 Feb 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT+oV5Bc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EADF59
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656940; cv=none; b=pUXK/6FG399HiBCJ9b920USkkoDi6j18PvQrPB1u6pSwhvljErBdOQqWrY4WhIZ6+tVp4biG20lTuvDIV8Pmae8ySaGBn2taTki3L283gYD9sj2HZPDCvphTRmAmiZWAJLdGXA1jVOgJ+XnQu7xHa9wdLWIzrNUt/+Qqvm7fBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656940; c=relaxed/simple;
	bh=GGyBcXrbK+aFVu2AjbF2Cy35l5vYUMWaH5JE7HjahDs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=imx4focn6xmUKBl9R3sFvzqGww0qQEfMnTP4RxE1r6zqQpEQpY1ZH+PuPZqRi96qO3F/RjhDpp1sIa9VIErp1zDlkG1supbitZFqgUpbSL2+HSJgxiTlPSxNYsra8W3hxjbSf91ll+CoiYypueZOWqkn5uHRdLtugmmYHlelwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT+oV5Bc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so5014867a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656935; x=1740261735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB3SYmN/D6AjxtJoKKJMS0GHweLv2UwfM/ppjlpc7Zk=;
        b=PT+oV5BcLpvt/K1T1sEWX7XKgMeGS7xjo0sX2qAeTHBMbtZrYhLIE3UAFfTl9Rhes8
         zKYB1+V4ljAAv0yJyvCP0E7lPxr0cvIubP0Xy6w+BjM01lyVbEfwSgC2QuqIpI0g9T1K
         rrIAanolnl+e/3d2Bq/bPuXvOUM1aOGmOUGJsfPnNB6wX8T8BMX81BBIKhY2CVAxbOgL
         r0185nlSAd2edsnikIp2aL1DKWEBjD+eLDBgufQhn4Fj8WEwLqAKUCGq6J/sx9lbTeBF
         C/jCB66ZdJ+qFg852BD76PXgWyBdfdl9972KOnfHF7vquLNkt/0a6Be7JvjLP5qur+9E
         piyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656935; x=1740261735;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB3SYmN/D6AjxtJoKKJMS0GHweLv2UwfM/ppjlpc7Zk=;
        b=gatps1f6d2B+R6cbaDRBK2jtepDAgH+1iNb1mVTKkmtPXdnyUX6kEZVYK13xquyOV9
         zFF3yn0CtCff1s/WmBftHTv5f+4CGjtoSvWT4lHdC7scbNw4pNB+PfWANov5QsQUVzMO
         SZGpuH279lKUeufzw6mYbGOQvD478uJ/M5lRE35kq//Wx5ukjriyyz63uhhOfi3GNUJv
         zUu+cBW5Y4FJKkUyWAGYHlM8EpYVHUZR57HIoa3CPnIOWXRsTAL8q6SIyvyuvK9m2qFf
         jo+R8oz+RKaeGjM5tH7K2e3NaKwTPKky9kMGwM7NB1PVt8Q+ciBh3S+yKJoWPTkJATC1
         phmQ==
X-Gm-Message-State: AOJu0YyGrx+UMLwt4rwmm3v5dd+mkHIt7UovwOL5Zbpqc5iVya42s2GV
	GhFq5y6UQbxgZNbCZe9iA40QVbQ5/ZCKuQyr/Gg/z3BXjpuRcwXxa/VopQ==
X-Gm-Gg: ASbGncv8/TM5ogHHWR8Z7IsqG9AHVVdAasq25TWzTvvCEsA4xSsqHd7NUsfar9db7Gh
	L3pjgTTFMLMEGAioHf+PYpgTCO1nwIAo243WetmyIxkdxQrg0w96oyq1wbjO4rnzjiK0/GHBLC4
	7H7prNTNWBOW4CPeGqJmf/WdrP0Gk6U/gy24RGdH87eUaY6InQABVQdzdb6hdA+qepGszDZi9U7
	0TLPkoagYKvguUzsrKiVmhA1zoutjXe247//vUIexkinpMl1gdKt5KlGzpf6npjrKorqpH79fSN
	Xf8Z5gKUkj4VBMEtSfcpsuY6
X-Google-Smtp-Source: AGHT+IGLGorY0F5coP8G+VEy9p823hqKqxtBGYlMl8FUe1N7deNMYHobbme1RasvMmU/u47IA/iHdQ==
X-Received: by 2002:a05:6402:270e:b0:5de:bc13:6c65 with SMTP id 4fb4d7f45d1cf-5e0360bc7f2mr4031357a12.14.1739656934872;
        Sat, 15 Feb 2025 14:02:14 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dedddd5b82sm3465707a12.30.2025.02.15.14.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:02:13 -0800 (PST)
Message-ID: <a3992c32-1cd5-4ba4-8dab-92dcf1182b74@gmail.com>
Date: Sun, 16 Feb 2025 00:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 7/8] wifi: rtw88: Extend rtw_debugfs_get_phy_info() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
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


