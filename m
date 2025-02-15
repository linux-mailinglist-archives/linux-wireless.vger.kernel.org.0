Return-Path: <linux-wireless+bounces-18966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E0A370F4
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1438216E066
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195419B3EE;
	Sat, 15 Feb 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNyolPjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103EDF59
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656872; cv=none; b=qBN/KtayHJtStW8P2BzGCvr42O7j78Xaa39dT7ASJ5P6Nd9qY+yi1AwYaIEnCwFwH9jGOfvMZr8tmQnqboT4Y6sMeUpVCk5Km5sa0Qvxu8DdgM6dFnHC6KVRKQ0hPmqMEeCpL+2YRRsYRnTpKjzt4OoNtCMnJ0nzcQ/dehyFSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656872; c=relaxed/simple;
	bh=xk49ZIwGuxW0Q5PokUgBkC/aDIfkgg63KeVXrcZ3GuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mtTvjLj1goosxI5/Q1ovDj/R+8tLmQV8YC2zPd0toFyUUCySIkp6UvLA5zGA8TLhsVyXSAv3WlTmSrohIu/6Eaeq5QCaqwHDR+8hBSjKXIH1kSgs2POz1tEml3OkFbPZ+FNc2RK+QKWs+Cagdz0gjeO685Rh1jkKghxr2apgT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNyolPjQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaecf50578eso640946266b.2
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656869; x=1740261669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKADQsjdIUyLj1/vlyebuvRMnaHtf5UNyRZSD9It72Q=;
        b=mNyolPjQH9yAXOyT69FywYvBfEiVY0HwotaGgAsOXlK5SYPIGjBSC3dzMREfHfJdAM
         FfHsdVbUe+qlvKGewWpE6oZp6GvI75lTlak0SXFvD4o2Kn4vVrvoDY4gyFrvu6S/3nOk
         6RMtWlGhT9UWYiYqmWucf/yPdIE5ZT8ztBDtb4P319yTxOgT4tMNH9IYUgTfXRcVqXRg
         c9yvixkYWqyW5z1mM1HotIwponJy18dLj2UGFB114SoiR1uSP0gEiRhJx+sUA6S9SeBo
         SM58sIOsBP7YDcLzejgaKpJ3EuwVchRxDb6cvhx+JNsr7d3Z7LOgst781n3OiDac6eTT
         Kixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656869; x=1740261669;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKADQsjdIUyLj1/vlyebuvRMnaHtf5UNyRZSD9It72Q=;
        b=C6mQPY+8Vp0Qw9B123hPb2TS6xrFAYMWO/hr8tZMlWMhzcSbz2Z1TI54XY9YWQc4Q6
         4PwF1xeUmDPBBQBUGYO4VNZkZUQZ6wBp1l3X0j9u8wVsuicpGKSbWwmOq6vfEMPdV+eB
         BFzNDv/2+6XfRFcsQNHLhRwpjoqHE5tCrpHZlQQeJmE8HfHven1Vsy8yfg+NXFQvjUWB
         xO2Z5uhwcaBoA65jeG3jWF83AJJqU1XtNDPMoe0MMzHnejZi5IHL5gnXGdzQSPiOVSVn
         kfSlXZrMv1koMmME8fUuxfHcPtyqa6c+ixKW6Ok+Rol17GMqwpz1M7/31W70SA0h95Dg
         1cVg==
X-Gm-Message-State: AOJu0Yy4ZvYFCes1iUYd9R4i5YBvamn63NapsVo01loD5+Zt43S5YuWJ
	8cY5SvmWTftUnBCYHqIo8QWG0Yap7W7CBCAaUSMdIQhGwlFpWVHzKe+KAg==
X-Gm-Gg: ASbGncsarG12BFV6YQHqkLfAmgeSMyzXpAtGb5LmlV78eIGjCJfDu4Put+7JeH8t5Yb
	9MiA8LEdkDt2YK5tU3Rvsu58Hb072ysKgJOL84b5/aGQAyaP1tnmVl9mruTm6QbWTC0O+7yZlt8
	CsjEDb1C48rioT3Ak/jdM0orELYdJGHIfJe6xpRhyUHwAHPPjF2MUuKKrB1CzrhKVt5izo3bSCp
	eVRWFxkeQPy1YMZmkt+llFWbDdYB1rHotQqIf6vdIFAEjXuQSn+wP6ZKPod/KP5G/f7EywLgZtk
	B4XBBC7zcMpF5Wpo/doi3ksW
X-Google-Smtp-Source: AGHT+IHYTfhAU06Rsuy63VnyfhOqhgM0PC+TJUOvkyesNcICCQxLLW9qSVzWSNtr0vel0sINg0nXMw==
X-Received: by 2002:a17:907:6d09:b0:ab7:cb84:ecd6 with SMTP id a640c23a62f3a-abb70e0d0ecmr362322566b.56.1739656868921;
        Sat, 15 Feb 2025 14:01:08 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231fd5sm595226366b.26.2025.02.15.14.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:01:08 -0800 (PST)
Message-ID: <00360b4f-e7bf-4550-a0be-9c8d8aa13b8d@gmail.com>
Date: Sun, 16 Feb 2025 00:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/8] wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Record statistics for the 3SS rates too.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


