Return-Path: <linux-wireless+bounces-19080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9FA38FA3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114393A1361
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1B1A5B83;
	Mon, 17 Feb 2025 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqlcly+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67115666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835080; cv=none; b=ePkO6FN4nKjtEaJavuy+EZPWQPE6gsFyKZ9xpXwUvjy4glhTtocGSDNw8m4XyD3ZqDTux4PaRkXEez2d3eTy4ACGRf4YsGKiCA+5m785oKRaP11z+b7C/Ty4qBkScBS15ZlW5kNb4zx0Tqlzym6c7zxxS6kdVrW2O/uJLqS5Qa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835080; c=relaxed/simple;
	bh=CxrkcZKE4VXQPi2QTsOFsi71IG/Ky29WMT54QPm8cQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gRmeFyTYJvsa87wkS0mnkhiP2P6L37P1OFaAh2jQQ77FgmwiSlJZwRSn84FATaixjRIWUgn4WCPnX9W0Voicj9AijB2+asPtmAiqVAfru6evlVS5nQUVUj2V7mUhkSUvHwlXSO/8sSLNLmad8Zoo4aDDPXsej6iojwDlY9CaqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqlcly+m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso806876666b.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835077; x=1740439877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TsK6bNM5LqoZMcp+twKiN43bkararPMEamGn+YryHi8=;
        b=jqlcly+mHvlTipCY0agjnP2R7PxRmSHJgr5W6TEXCswpl2NPzMQKW3r+3Nrw9J28y0
         xz0rDYVnQ3l+3E3UViTNc1ukvB2V69BZz4O4xuXIab5tTIq/WsNyoUpbpWKfC8leeu6A
         68pYChK2+7HrB930qcs/JtNyuG1139kWWV05fBiFsV5K1TsWr60YnutmmftYQxIrReYR
         /in+ttkUgLvshyw0mD53BC7A2EFwWQFDWRueOqeZdmhoOgIpDAr3KI3UJ+VzVHjLQgA4
         MLbGZj2ZEW0JVCufVc5NMkQAHqsnXR+oM+EV6gFlWz6NKETKYK5GWpO/xdpnWWfQBHX6
         qP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835077; x=1740439877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsK6bNM5LqoZMcp+twKiN43bkararPMEamGn+YryHi8=;
        b=lEa0YWiGbC9HjZnvN9t2w0F+HciCjpCO+h+SuViHrKFitTWZDBO6YOaalVdsqZ5JgZ
         aDWV6nfWm8BepHVI9RPF+Kegfa1cPd1U+HpqHf2KekRRQ5HLYnSVKKHpWDEqeGjnA805
         7m2I2Y7+MF9RUJhaNUMrukKlNMo0vEgaQ6SQ7XmimkhUUdHT4nYBjnVeasg1sKgGjJyo
         pDY9HfH8hpgxBRLdQO4DIPkgKtVRmF42vmUiH7V0Rmcqwn9jQCzxWnCR39Ns41woVT73
         I6KLmzE9gwfKH2mwGdpVm09Ds0on6zqbfmwa9jvBOO1ZqKewCakHiCQdx6uuO2YbCcNP
         aSpA==
X-Gm-Message-State: AOJu0YxVhVbpU7BOaOEnBWDPjdW1M9806pc8uKLNqpVhDGoSKsCZ3bQH
	QgzTSeSs3zHw/lVNpWGXMPoww7BDWLZWQuF9tL84Gg/fYs8HtFGSJo8ZCg==
X-Gm-Gg: ASbGncs3YM1T0WqjUzSwW8VEfGrf9+L1Htyuc0l0bjmhgGHA9grJfKT36Kf63AmeEZJ
	tzS/Y2EBLeTybI28Brz0ir39a1P78csEO56v0RS5+twqr8/NzrELwceG/CHo+p1weqNvljYUbO3
	KZirbRB3jK8KxOLpwZJzBz0RJohC7nLchKJ5r95/OnmITgTLLxKIwc9iLSTyfrBKbHijsYgkU0h
	+WsJWY2n1vX9Gq8KZM91b6KM+6NRtD+iRBEZ42OuE+12AJ5DYxljNDEGbGrmfsnoRbU2BMqf/Gj
	152C/0cg9BgAlfL5OvZdeo6O
X-Google-Smtp-Source: AGHT+IHZVHO0HTl8KOGDW2jVnE4PULmD2NFQlMGWSiQ18AJfXezct1qLMeRObQyxyUvyFe6gq15orw==
X-Received: by 2002:a17:907:72c8:b0:abb:33ff:c5f4 with SMTP id a640c23a62f3a-abb70d679bbmr1252581666b.36.1739835076650;
        Mon, 17 Feb 2025 15:31:16 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322b9sm959505266b.37.2025.02.17.15.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:31:15 -0800 (PST)
Message-ID: <39e3c7cf-37ed-4c0e-af00-dcd9eab351f0@gmail.com>
Date: Tue, 18 Feb 2025 01:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/8] wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Record statistics for the 3SS rates too.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.h | 7 +++++++
 drivers/net/wireless/realtek/rtw88/rx.c   | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 24ac749271cc..c15e0f55d09a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -386,6 +386,9 @@ enum rtw_evm {
 	RTW_EVM_1SS,
 	RTW_EVM_2SS_A,
 	RTW_EVM_2SS_B,
+	RTW_EVM_3SS_A,
+	RTW_EVM_3SS_B,
+	RTW_EVM_3SS_C,
 	/* keep it last */
 	RTW_EVM_NUM
 };
@@ -403,6 +406,10 @@ enum rtw_snr {
 	RTW_SNR_2SS_B,
 	RTW_SNR_2SS_C,
 	RTW_SNR_2SS_D,
+	RTW_SNR_3SS_A,
+	RTW_SNR_3SS_B,
+	RTW_SNR_3SS_C,
+	RTW_SNR_3SS_D,
 	/* keep it last */
 	RTW_SNR_NUM
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 90fc8a5fa89e..8b0afaaffaa0 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -73,6 +73,12 @@ static void rtw_rx_phy_stat(struct rtw_dev *rtwdev,
 		rate_ss_evm = 2;
 		evm_id = RTW_EVM_2SS_A;
 		break;
+	case DESC_RATEMCS16...DESC_RATEMCS23:
+	case DESC_RATEVHT3SS_MCS0...DESC_RATEVHT3SS_MCS9:
+		rate_ss = 3;
+		rate_ss_evm = 3;
+		evm_id = RTW_EVM_3SS_A;
+		break;
 	default:
 		rtw_warn(rtwdev, "unknown pkt rate = %d\n", pkt_stat->rate);
 		return;
-- 
2.48.1


