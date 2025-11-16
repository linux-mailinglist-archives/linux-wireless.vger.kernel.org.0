Return-Path: <linux-wireless+bounces-29006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1380C61C50
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B21534A96A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EF24169F;
	Sun, 16 Nov 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me88e02Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F9D531
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324965; cv=none; b=GUmIanh+mTA+LDDOshznXDaGjwyuert4nlacfnCGl2zGjMz76c9f1uv3FSNVVlVRMy9rhBd3bE0hMfhshU7QlOvFly76N2aPqoeBI41S/jO+UOiX3bACcVhmdhmZXwkSzeGQbsJyV9xQGmNUZX1ViqaRw3cqj/5SXkonF1HAa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324965; c=relaxed/simple;
	bh=CTj31XpWuQiJBn1E4eUVKKFYQAdMer+hLAc8sWYYJbY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p4PbgKFchV1gKmphqLkdPEy+5Fy0TneB2V7wVzKMdpzsRVjdhljg9fwSV3mje7Aki6n/BMiuSXmsxWG/wcMVhUhul0s/PQuSUKwdbVV1K2Cc8T71XIz5QuRr8pMRuUE6d1M93sNXrigoekr8sa59G9rBtw4cK1Gbfn3yHM2RKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me88e02Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso2759455e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763324962; x=1763929762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8m+60Fwy9tjWSOLMxIfXptCmK1/VPk5w+1BKElzUy8E=;
        b=me88e02Yt2M0mscRVXDIrozlJnROKdbhY5LjKam7IYScCbfMd3HuDwKNqap3uj2hhu
         Keg//k5fsnqpFTaNvs+aSb9qpz2d3aYMhLq2irTiSTGO8d6ZHb2BgH3I0RveRjVUjakg
         v/AxKVUxuj0m8/gq58mYZE9IsCNjxf5xAHsUxeSSZWQRFYPxkUDVI9KKqEOWjyPYuHV/
         g+ksTORd01B6bVfQUDlY2lX63MmER2CQYozdh6CuLicyYGGd8fBbkCw3q5FAixoci6pN
         czMzeiIbjRRqPMR/93IyKWrOJaOtp6mm3Dl7lmvUWHZWFm/hOKiduHs2XhsOtHf9Z7Dk
         opLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324962; x=1763929762;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8m+60Fwy9tjWSOLMxIfXptCmK1/VPk5w+1BKElzUy8E=;
        b=FHwbq2laOOE0tJIfKj/aHVJ337kvPx4yy0pdpXZGGQZRig+z//3FKU0Lwck9evUZ1C
         WhtRo4+50F2kiBocz20qpfMUOhCwVYaejnUFx0EQR8VCta1w0x7XinpuvPVepfyzgdbd
         aqIlnEIMTMpA96Z3bidnHd0N7t3AEX+I3J0mtaIReZbh5Y2EJiAIiXEsaWcI7biYTz1e
         Ox4dg7+m9VlW6yBEh7zhWBmoTz3Jit09BaaSFMz+s2w6VWvTYPOuJxhAEbkTDE7xtd+w
         kcG9B1yNV9djDoBQ1O9tR/m1coFXoQfkyFR38Tc/Uvk2If7TSg9i4+CdSJZa5weOibDJ
         ZeaQ==
X-Gm-Message-State: AOJu0Yz4zRkJSZvv+53V18NgIlLLVlc97IroTmh3yJYd3wDF42kPvQ+j
	+uaFyL8YqAun6O/JljJDq942jycQTF6kdMK4pcJDIULXXAaq7VTv+BBq+ySQcw==
X-Gm-Gg: ASbGnct747q7ZkrTSmecqtHnJldRpKaaeGXSUtL/my4mwaEStCbYSYTKVog6vV+DTX1
	tLqQL8mMclHdai5AkV6bf6FI8BJh5Z0qmdFxlcJz0A4ACSN2XzgvGrX1tnRgfbv9nlp1MWApdA2
	0oQpYx/07c+ggurGjDpsD2wF75iEnF7mLeztlb2bBnaCAIr6XErCjXTMycr1mbDXkTobKoq84H2
	FhUdihDd5EQKj7Bxp4RDvMh3EVnlKLDphN2ow+fsYhC9ub2aC/lw0ugzmpUx88I3MMp9YilCK/1
	nnmt93poCGgp6D8tT182okv8i0q9mxvJKM5Vj6b3pRPAxjlUdaFWYv7n0jC0WixV9ckG1cVW4S7
	mGiCpyIkvoDvzaD+aTnL6a04TjtVN3abArG4wVkpdosBIAV+H6ua3qExZa720kSakRk3WqMiLv/
	yiiVFsMx2S
X-Google-Smtp-Source: AGHT+IFgR7moyA/EanwEIYpVIph2xGvavuzJBWorgvTqd3m+KpKMZ/UoV/HFFqzXDnO+gfQtxlnaUw==
X-Received: by 2002:a05:600c:8b8a:b0:477:952d:fc11 with SMTP id 5b1f17b1804b1-47795418dcbmr80409605e9.16.1763324962292;
        Sun, 16 Nov 2025 12:29:22 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778beafcf5sm97804725e9.0.2025.11.16.12.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:29:21 -0800 (PST)
Message-ID: <150bf88d-9e12-412b-abc6-5313cb4d62d6@gmail.com>
Date: Sun, 16 Nov 2025 22:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/5] wifi: rtl8xxxu: Fix the 40 MHz subchannel for
 RTL8192EU, RTL8723BU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Language: en-US
In-Reply-To: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8xxxu_gen2_config_channel() was missing the subchannel setting.
This function is used by RTL8192EU and RTL8723BU.

This change seems to make no difference in my testing on channel 13
with either chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 7700e4074dc3..739456640ca8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1373,9 +1373,11 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw)
 		    hw->conf.chandef.chan->center_freq) {
 			sec_ch_above = 1;
 			channel += 2;
+			subchannel = 2;
 		} else {
 			sec_ch_above = 0;
 			channel -= 2;
+			subchannel = 1;
 		}
 
 		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
-- 
2.51.1


