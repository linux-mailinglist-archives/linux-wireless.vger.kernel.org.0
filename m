Return-Path: <linux-wireless+bounces-29171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6012C7479F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3875F34AEAC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7113025B1D2;
	Thu, 20 Nov 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6F4Mfpk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D8335573
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648035; cv=none; b=aUb0Lp3PbibNofvAmi9oxIGJzTlRsfv8aWlTv34R6AptfnBANbLdz1OKZEMsOA8iF+om2I0eT7lJMNU6GM7Iacsnjt96RBwJJDFncKs1b4KjUyUQ/GVr0g/UDVNJ1TatKYk2Lcjl+J0RjgxIcbRHSiWOLGPvaI8tLEnRl1V8rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648035; c=relaxed/simple;
	bh=I86lQ9/OMB8tLGMMTiYmKyRpTjaMBZhg9KnUOpe42Ig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JxHjg1groIMCt5XcOT4XrJcMdBYWZ/3XdAmSAwGR70mM8Nmrc/NobQHFd6hJKuv6aZFn2O+K9VVEerUJX/u3CvnURsJPoDDY88Lgo0h46v7JYkdy+EKniSIq9NEHOaOngZNYbNLWD/mtBK6lGa4XlBqpP7LDO1tGuk0Sch8bYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6F4Mfpk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32900c8bso567500f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648032; x=1764252832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbLILvo+Ax5N1sfk5M9UYy4E8/NZJ7Mn66IjszFy4cg=;
        b=J6F4Mfpk3UDMheLWi5i+ydfA4hSeDuLj+XbFERiHyP6AL+6IVMgLLXZ4PI48g5u66S
         Z8hklbywm50/Cfl1rjX83/5LEfhSqvQ0p3n8KeEzzRcWP43gFNOeChoWztf0bkes6OO8
         SLL+MjJjDToSwmR0d0qjHM1OdQXBjTL9UdXwcqfdHD6ah1EjSI5G6hNmwacOBjcjbd2w
         L9fvYD+zp9+0QOtCd8GgZr9miIeiilekGlrqWXwWJv+0ZTw4kOmjXxvvVCWYvl5onseG
         I+j9x+YaLtTYdHUyQB7tInM9ff+eNoZ9B2U+viJesOi+ozWTotTKF2D2XilF6jkGXpxx
         rUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648032; x=1764252832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbLILvo+Ax5N1sfk5M9UYy4E8/NZJ7Mn66IjszFy4cg=;
        b=Ggyxg8bwmbijeSpDNUTIgD/9B4EYnEB/+6XZ6svmJ2j7GQG+N12AM7Q6cKKbmZizCL
         Sj4YQVrNtgi6+YoNeP4j7E8Tvt0+ef7RwzGamjdJxDT2d4op2M+sucqHRCWli/dGwuVz
         cTzB+a5Ch/ayfwAF3NV2EdyksNyO74SJP8StrzhNRlhEoGo8l6waC48MjulYrJu+qzJS
         bY+WBu7f27xQy6Cm5bNBUxDxo/HHz4n2xA/Th1H6ae+SLwz6fkFQQREoh1KV+by0e2eJ
         CXfdEHgt9mjwdbwDxY4IIkTzldAM7UilccpDlPVp6b6NufiCRWvtc8ybSl80e0HZuuxc
         VzVA==
X-Gm-Message-State: AOJu0YwmC8M07rLQYnfz1mowaFQwBtmlOl1qorFNAevLHVX0VQkkkk3j
	HY93vAXyBwO2BF0bHS7vkBUFZDtjh1SUDEW/pnScQaoqrSVBWXhLsK8GTLGqzQ==
X-Gm-Gg: ASbGnctGjLLdKcbP58M08fT8kDGmiYv4mqLA++1wTI9J9nRCdh0FEOkMBcc1GlgK6p6
	ia5jeQR2PMtAWMzdqaInmXncqH1zB2VgqAMJL0qhpsA6lSVlDXWzOIZhjRlemm7Fqdj918vL3gR
	OIZAu2FHXUfK/Yyf1ydbs4anoamteyL71D1LBU+S5SkLN9nGpQZdYj/JA53nq+8n8AhgGTP1cwb
	yR1XO6KXj2X7qlKbWLwaqhfTrm7s0FFPFKUvaJQxlFt/+cHm7xeOINATg/fJlXWA5+5vJU/macP
	g9kXiVU3c56gQLa7O8429CzUVOmjBkN1YbHcE+Bkz1bJqkZQG/s7ekS47aHtjBkN6kJ/iDFHbYD
	U9SMtzTZoN2GoVGKDCdxEB/qycgVrYuPayVch+UuaVec0A2zbeolid2viighSDnx21nEufw19+O
	7Kox6ZiYeGXdWrfsRdsuI=
X-Google-Smtp-Source: AGHT+IGXmKYxolirq/eobhkQiaDFqaWDsrKxeV2gjnRliMsoF/Q3CKZ0XrQUkGb7eT1TwgOJYikOeg==
X-Received: by 2002:a05:6000:430a:b0:42b:3062:c647 with SMTP id ffacd0b85a97d-42cbb2788acmr2064543f8f.21.1763648031511;
        Thu, 20 Nov 2025 06:13:51 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8e62sm5732511f8f.35.2025.11.20.06.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:13:51 -0800 (PST)
Message-ID: <4f053103-adfd-4ead-acb3-ef69127a4bab@gmail.com>
Date: Thu, 20 Nov 2025 16:13:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 5/5] wifi: rtl8xxxu: Enable 40 MHz width by
 default
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Language: en-US
In-Reply-To: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

40 MHz support is hidden behind the ht40_2g module parameter with
this comment:

/*
 * Some APs will negotiate HT20_40 in a noisy environment leading
 * to miserable performance. Rather than defaulting to this, only
 * enable it if explicitly requested at module load time.
 */

This parameter was added in commit 26f1fad29ad9 ("New driver:
rtl8xxxu (mac80211)"). Back then rtl8xxxu only supported RTL8723AU
and the RTL8192CU family. It's entirely possible the miserable
performance was due to mistakes in the channel switching function,
which were fixed in a previous patch.

Delete the ht40_2g module parameter. If someone still needs to
disable 40 MHz support, cfg80211 has the module parameter
cfg80211_disable_40mhz_24ghz. That works too.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Reviewed-by.
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index a18f73aea837..c06ad064f37c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -20,7 +20,6 @@
 #define DRIVER_NAME "rtl8xxxu"
 
 int rtl8xxxu_debug;
-static bool rtl8xxxu_ht40_2g;
 static bool rtl8xxxu_dma_aggregation;
 static int rtl8xxxu_dma_agg_timeout = -1;
 static int rtl8xxxu_dma_agg_pages = -1;
@@ -45,8 +44,6 @@ MODULE_FIRMWARE("rtlwifi/rtl8192fufw.bin");
 
 module_param_named(debug, rtl8xxxu_debug, int, 0600);
 MODULE_PARM_DESC(debug, "Set debug mask");
-module_param_named(ht40_2g, rtl8xxxu_ht40_2g, bool, 0600);
-MODULE_PARM_DESC(ht40_2g, "Enable HT40 support on the 2.4GHz band");
 module_param_named(dma_aggregation, rtl8xxxu_dma_aggregation, bool, 0600);
 MODULE_PARM_DESC(dma_aggregation, "Enable DMA packet aggregation");
 module_param_named(dma_agg_timeout, rtl8xxxu_dma_agg_timeout, int, 0600);
@@ -4896,8 +4893,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				sgi = 1;
 
 			highest_rate = fls(ramask) - 1;
-			if (rtl8xxxu_ht40_2g &&
-			    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40)
 				bw = RATE_INFO_BW_40;
 			else
 				bw = RATE_INFO_BW_20;
@@ -7851,7 +7847,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	sband->ht_cap.ht_supported = true;
 	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
-	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40;
+	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
+			    IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
 	sband->ht_cap.mcs.rx_mask[0] = 0xff;
 	sband->ht_cap.mcs.rx_mask[4] = 0x01;
@@ -7860,15 +7857,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
 	}
 	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	/*
-	 * Some APs will negotiate HT20_40 in a noisy environment leading
-	 * to miserable performance. Rather than defaulting to this, only
-	 * enable it if explicitly requested at module load time.
-	 */
-	if (rtl8xxxu_ht40_2g) {
-		dev_info(&udev->dev, "Enabling HT_20_40 on the 2.4GHz band\n");
-		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
-	}
+
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
 
 	hw->wiphy->rts_threshold = 2347;
-- 
2.51.1


