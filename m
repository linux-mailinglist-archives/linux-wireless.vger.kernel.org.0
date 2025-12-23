Return-Path: <linux-wireless+bounces-30098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825CCDAD5C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 00:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BC92301B82E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2669289378;
	Tue, 23 Dec 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMCymoEu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C327FD71
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532410; cv=none; b=oNkGGP4no9OGQRr8kd1QdagYP6TpTKMqtCNCI7yWL3pbaSw+upb8q8vNVkHMSVzKi4JQhLpissW+XZt0r0ssS1KSE7WqRC8J7WFTYeiTNQT9ZwOTHSlkxzhdaaHSoVf43MdPqw5T2LI6j/bg4KECz0QE8h+L4HuV94d4AXTLYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532410; c=relaxed/simple;
	bh=RsoEp6nsItC2rsRpH8e0lGS1gCLhA4fsDsOJnLEK9N0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XFZAd6ekZPz874Mbo+4GS8Smtk+gcvxK0fHlGy+/mev0ULEXp+hxHby6TbfgdRd+BeoTzJwdUoBW1ASiq5vfS3rsvqUBK+Q0ffKkZch6KkP9XpFMn6QlnGLgSff9nm07qcq/4poZpp7QMxIBEnvw1XGiPoNFxm/tbUTw6c8c+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMCymoEu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so40243645e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 15:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766532407; x=1767137207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTo5hsLOFo9KyZSP3I6xucYM8B6+DhbojJrxzg9q4Ng=;
        b=FMCymoEuA1RrxSstFIMhTC12ke2LXyh0Ke2qfysNWXcsxwsDvX3tjg8jiG7Ekn724v
         T7GLzM6BGUxp2Sc99jjbnebBFSqpwp33shLSZ6ayF1KM79i7EQL8mk2EqvHVCsJ0nTs3
         ZOeosOFblmGfoVQvAqprtVdX0tRKOto6BcLLWJgvMqGyZC3xNPCxouKU/YCfaF3aHOyZ
         ps0DZnI1cqw/lq0/+350cRT2NIbc+YthX2uYtRyRnql9d0I/xSZaVRrNF+jb536WS1Et
         nrbHw21rFELAhf3JXX0WP0n3/CoQdyZThmkTsaJXaQOlKkjQTDTi9dn5RJQRip6YSCeo
         bwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532407; x=1767137207;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTo5hsLOFo9KyZSP3I6xucYM8B6+DhbojJrxzg9q4Ng=;
        b=iG0x979e7VjUg6geUUpln1ILwotsAXMQdb8gBwf/ztQp+1TfqaZuz68yUoWuoi1L/Z
         C/1ren7RRAx6a3l5fEYSkl5k7fUJf1JCXRQTJYss1+dA0EA6VGhSV97DLJHKEDdFw2Rs
         R65VYHnJoSpeaGAuRg5hQiu9XQBw/HP8fNWDNsC3PN1MnaPK5m9MaBDf3MAAprcefuSn
         t+MYt7/rJPzEdCdLwnseMSc0qiA7Y/sTz8RNZBTJ7T/Idi1aADte01QcK5Rkuy4OqDgc
         GaP4VIarI/pFwnECjRDPO/Sx8yOHTdW69ZOrPCShVoNn+Ef7Jg6v+0/SusglQ2yCc2mm
         lNVw==
X-Gm-Message-State: AOJu0YyD5BF3u8rJLLr1aLxfP4aSgcckg0jBZRawTMQ/JL4NoLlZ/nQ3
	IjqjJ0LxNS8LfeD5iVGfuJhX5+TaVMvBAn5+78ZYK2hcMpAmMzyBs16ro6dFCw==
X-Gm-Gg: AY/fxX5rxn5fnMWC95Z3kPKGkULkDe7glQ4gTicPgIkq/qp6DZQeOCGf9wV0VidpsAb
	MCyZ3aKhKmlJTNq8VM0y/24/1YJN4LPPWJ/bgZe4ZDJtCdfXXGoLxUdDmsRlQ3DlFXz/U9rUrLc
	FBD4rkvHxPSJ+DXZF83Fe1Zx501XvPtoPUzWczlOFPkIhsqGrsPcqW5cd54sYRrvAMxo6yO1CUB
	C5PJmKC/oTIKrWClLKziB5zV8Ur/fJqeMVTYSdCjQOaGfczC6GqzvSEuIcCWm98HYw6tPiNC69K
	twvi7xwB6MpVlts1xTVFSzCXMsBEcqT+e2w1KMsuxZ3W3XB4nW6AK+ZPgrTc1Cf4A1baR4vEXme
	PA3Edc3r8vnIT+DF2zShAgw4x0ZtMrTHienLduNZQ2QVntvxFguH6lMzd7rqm07lEqDeqU8xuRF
	2f+p1YaygNjksAkwwko79w
X-Google-Smtp-Source: AGHT+IEwaxF8m6ukXwco2izlq02o2cArykZwvIkfX/77jrnxHZpBmMRBklYoQ71gJTTTmcLW6YRt3A==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47d1959f714mr186534455e9.31.1766532407450;
        Tue, 23 Dec 2025 15:26:47 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273e4d5sm322778485e9.6.2025.12.23.15.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 15:26:47 -0800 (PST)
Message-ID: <e94ad653-2b6d-4284-a33c-8c694f88955b@gmail.com>
Date: Wed, 24 Dec 2025 01:26:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 3/3] wifi: rtw88: Fix inadvertent sharing of struct
 ieee80211_supported_band data
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Content-Language: en-US
In-Reply-To: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Internally wiphy writes to individual channels in this structure,
so we must not share one static definition of channel list between
multiple device instances, because that causes hard to debug
breakage.

For example, with two rtw88 driven devices in the system, channel
information may get incoherent, preventing channel use.

Copied from commit 0ae36391c804 ("wifi: rtw89: Fix inadverent sharing
of struct ieee80211_supported_band data").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 34 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 46af5bcbb8bc..c4f9758b4e96 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1661,16 +1661,41 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 	return len;
 }
 
+static struct ieee80211_supported_band *
+rtw_sband_dup(struct rtw_dev *rtwdev,
+	      const struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_supported_band *dup;
+
+	dup = devm_kmemdup(rtwdev->dev, sband, sizeof(*sband), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	dup->channels = devm_kmemdup_array(rtwdev->dev, sband->channels,
+					   sband->n_channels,
+					   sizeof(*sband->channels),
+					   GFP_KERNEL);
+	if (!dup->channels)
+		return NULL;
+
+	dup->bitrates = devm_kmemdup_array(rtwdev->dev, sband->bitrates,
+					   sband->n_bitrates,
+					   sizeof(*sband->bitrates),
+					   GFP_KERNEL);
+	if (!dup->bitrates)
+		return NULL;
+
+	return dup;
+}
+
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
 	struct ieee80211_supported_band *sband;
 	struct rtw_dev *rtwdev = hw->priv;
-	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_2ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1679,8 +1704,7 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_5ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
-- 
2.51.1


