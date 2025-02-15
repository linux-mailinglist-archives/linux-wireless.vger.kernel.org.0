Return-Path: <linux-wireless+bounces-18965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DBA370F3
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF783ACF55
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63238153803;
	Sat, 15 Feb 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/0bi4JQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF6DF59
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656849; cv=none; b=VpnvvLvXpJKdUwwxRhaBckoUIFWAsj+4GdjjAmXnNIq1Zi4V0xLVUoiKZP8joAsFn3/9z0JTdvM8TAvdLyliYzy23qa1WHrM65pWxVzXEJJJQ1kImslHAJBy8pPYFRoNjhG1fHAM1oFYZfa+dJv5lDnM/tck3qwSXuPmSBbAw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656849; c=relaxed/simple;
	bh=woYRf/0nObaiJVrU9nvK8m28s6R0czNTkwB5qE/0rRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UXeutM0HsgE0VMpqDi9lt/pKvwF7L9uil4ov45IiIVBzKqvn2WiVIC+lNVv06J8Lsma1RCqSFK5GtCMcRaWz2/3Lsd8WNIUe3vLIPJk9iYPins/eDWpf43AHJlwsYqs/toQ2LHRJ4nAO5FDfEh9AY9sR6ATrezpBXWW8v/UO6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/0bi4JQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so644009266b.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656846; x=1740261646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E9OzYdLEusS0eEvaALGex5cqjmm2MMWeU/B3AEikGbQ=;
        b=P/0bi4JQKweEFEtB5CiUcRjLwfi7ELnEi6dN0m0FTLDGCf/Dr+ODIAHG/ho0zlyrC9
         NQRvdoQ3TEog0XTIkh9XDhas22colWGYqGvk95xa9pu9jcRV8jv164V2scXgNROdwF5b
         3mpeROcdgRZKLyygfI/QMY2HcizWWfNAw0btn5z/0EOUCAX9f1dXkoUOU2yAEwyci/ic
         Xzk31SQKqNpmvpSlfy2iDS//+jwI3CE3wEWwkuyA0OFijQiG/mdX3hORuda52KJNrAEb
         y5wlvvtrnEVpqooeX9g9XoEr+2wSEMn3zoRXswtCW3ujFOmyAg9VA5w7CyW0vf9QGtpt
         Uw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656846; x=1740261646;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9OzYdLEusS0eEvaALGex5cqjmm2MMWeU/B3AEikGbQ=;
        b=R4vKvLcnEKcKeWtqzPA4tpQ/qCgJZC8SFk2LM11UtMRVVV9FT0xAFmj5xwrXmsWIbB
         RP9V6Co5Cx7TfBMqUmc71GfCo5hOyAT2f14HWZ7o4nO93og/JC5RzAr3wIdxtv4Xt07a
         2h7JaK6MQID5PL74CrDa238V6Wojw1dH2B+PR8NBVMRNGa4KWAdZ01ry1Be0TXxirrMG
         KmNFKi6ic5Fh1iEgFIoyObTuo7exwjEWNjiJBZB+k9x0Mg+QOyXKM2eXmmDgqEfIxXTt
         Vwa0mAdsIQO1TVB2asRaYPrlFZmrZmA0YeVFMGjK9FOpTGXeIN5vMBiFovoxAewvmoty
         q9TQ==
X-Gm-Message-State: AOJu0Yykquqf2sDSKg27nyaKBuKQP2l7IA4J4n46VWn9biQYg1n8omzB
	JItqqi6cjUAOOixsAxXToEA7VHhqKwKW1z1vsZLSTettMFbLnKxis0PkuA==
X-Gm-Gg: ASbGncu+qa5FjgEOTspRLNMsa4/SQzBMlg3zen46IFBQhxPL1ejz+NuqaGMLU2nPU7T
	9rtcWScurc72GV4q2yZU4LFiTNsb7YIM9NhuDcamzoteKO8TGDJLVkZZoF/xX91+WfltCG4fBjA
	PxRxPJM2S+wuV+PMmuaTjwnQirxUaAfksI4vNKef671Hu/sxBAZROZ5leYv+iGh5gCxoMHAo6ae
	fSh9iX5H0iZ4ji9oWND2K+ab3eQewOJZtIWkCJrBPgMVOT+fk40Q8KbnkBKIfaa7Qy2HjsHZkaQ
	0phHSedX7U6xnSKvJK5yf+/s
X-Google-Smtp-Source: AGHT+IGSFgZaBDUkuY8p8C/34ZGOUs4lf/2Sojc18MnrcFH1DYpdGRduDjBjtoWKZW0NBkpT6zlHAQ==
X-Received: by 2002:a17:907:784b:b0:aba:6055:9f5b with SMTP id a640c23a62f3a-abb70c01eadmr380748466b.2.1739656845627;
        Sat, 15 Feb 2025 14:00:45 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532832d1sm592239166b.81.2025.02.15.14.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:00:45 -0800 (PST)
Message-ID: <377e675b-3962-4f88-823a-5ca74eeee50b@gmail.com>
Date: Sun, 16 Feb 2025 00:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/8] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the MCS maps and the highest rates according to the number of
spatial streams the chip has. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


