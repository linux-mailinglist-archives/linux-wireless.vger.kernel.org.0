Return-Path: <linux-wireless+bounces-18791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8ACA31890
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBE1884842
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1151B4243;
	Tue, 11 Feb 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqcv6ig6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFA267714
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312639; cv=none; b=d+kxr3vVWtZpc+1XKhUSfe0JS8nagP7QUK9PZcQSj+dz8IiX8ie8BeYoPZ4pR3gBYV2qxzGkSpy6JySZ4cwCZAdcpnoDyMtPbF7ocxejm56cREyyQaz3HVpQNKad5FIK6z3VNdwOUonihfJe6+gxCizNgaQSoXU/7YIUQX+/fDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312639; c=relaxed/simple;
	bh=8OOt5VUmuoUOmx1zA7BPvfMxbeOhC1Za86OZenEi3Pk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BayvkbUiXBt5ZKaKpmo53o7u4RdsLK57pc589gAGOahFgHS8hmRNl6V9mSQTzn8XefUB07zD7zuTl/93QA8xLnIcxOeMQXS1tpfNNeplam6wyfXhMDS8ccJOuNnugeNSITaYl5fyakdcLnCgAIXv4arhxjyaZ3EpL3Oy1Khdnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqcv6ig6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so191014566b.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312636; x=1739917436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zc2OVM5XY9gyqbnVO1o7VPq2IP1Z0aNrrnWGpKs/1M=;
        b=Vqcv6ig6eTQxp8vrXkjy+L3zLrVMZI52KSKMtt6B8QK3iIgAZKmGgG0xEhPwxdtsTY
         pO+jv73CQhIkrnPXjDJUJePTrXcSwXhTRkwrYI04MjCsErDve6zGtQls5mn/ar8NW79h
         gwPACl8nOkrfhUPN7C7mNG2GrEsLrsiks8ucP0wMCA2MpJfoxZvCX6kPqN1lY6EHI3Yx
         ry9yYH9pSsCSsJ9nsqnY6uJz6JHnYTiTbt7V6ulXujg3dvDkab7AiXvE6VFTL4l1RRk4
         Z6sLZyoHxWRJVrsvM87g9YWjH/7NdZ9ChOqXkTiENLnqFsdoGRTLMSb01ZSGu8lJGbeL
         Z3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312636; x=1739917436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zc2OVM5XY9gyqbnVO1o7VPq2IP1Z0aNrrnWGpKs/1M=;
        b=itK5oWovv29+UTKN4vX9ggOjxMOA/ihnj4fRdCKzONiN9gqcSqWZUi6+NoyVpjQ1p6
         w3lNe3zuDYEP8EcKm0vFbzBK1s30jpU+ga1mloMtLFPBEYtTVToyehcjCdtqB5k2lSN3
         +EXmEJ6wt17jJi33WwpjjJWaliPkdlVpEd02vBu2PVfAHKVBd0c+ZjiJNR5Y0z+vrHJb
         rFA4TdOATk1X4sdal98WHG5rx5fpmfrvRXN8QGtlLueoABURiqdlQoKAVBi4aJLsGbaO
         g4uc+k5r7sBNT3VZqsH9vDdm42u1dP2sPOmz2pNwOcvdix8qIZr4CDW7SRYBA6ocpLXG
         TDEg==
X-Gm-Message-State: AOJu0YyadqVQPNqZBGLu3+su4QdcgQicQndgWoYmJB4z17Jnm2sM1Tai
	nJ+NWX3hpwRcrPm+sBefLPNNhgUgc8+z1QhqIAr+nJKKBeQeLuU+1w1YzQ==
X-Gm-Gg: ASbGnctz4g7TPrazvCV6c0tKnCPPoKrwRaw7jb/zWP/ruMv7hu/NfUOfBDLpyt06LGf
	7zO6gy7AQKNO9SnlwqWap+ssIz25Tbd+2loX8lDQ0SZsPG+C/Xhk9LxrpnA91i/eUGbLfEDBjN+
	MSM8IcgsZXBpF1N/2/XnDy1aHw4y0G31x0FuEZIe4JUHByRH36gzASgFKffaYy38dCWF9Tv7SCV
	F/Tf1GXWswcEtg2lrpJ4ZEz0j6VqsE9V9FBq0ORU/FKGgysLhDqAqEf1XHkfJfA5FgX42MSJaM7
	WfxqBXYMeyUF2s7wnnGeisoX
X-Google-Smtp-Source: AGHT+IGOEXikU38Kc2F/X7hSd46iA6sjjpdaDKLtCOl/IJwY9zhLkiuN4H2AC60YidN8oh5jZdmCPw==
X-Received: by 2002:a17:907:d1a:b0:ab7:f096:61da with SMTP id a640c23a62f3a-ab7f347a696mr68276966b.41.1739312636217;
        Tue, 11 Feb 2025 14:23:56 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b393da3fsm614844866b.96.2025.02.11.14.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:23:55 -0800 (PST)
Message-ID: <26c2ef1a-b382-4901-b286-d1b48d808900@gmail.com>
Date: Wed, 12 Feb 2025 00:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/8] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the MCS maps and the highest rates according to the number of
spatial streams the chip has. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 3319bb5044c3..959f56a3cc1a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1596,8 +1596,9 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1620,21 +1621,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
-- 
2.48.1


