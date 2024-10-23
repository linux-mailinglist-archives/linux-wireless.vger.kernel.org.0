Return-Path: <linux-wireless+bounces-14403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EB9ACC01
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1D31C20E35
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744E1BD003;
	Wed, 23 Oct 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edsMJHN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FD1BBBC6
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692830; cv=none; b=GtwRKRBlVMJOMhhAF54nQSCbhy9PsnVHSH14sseyfQ8NRW1Yg+1oD+h51NBO4M+M5vk+LUslaBkAlap4OJZbRGMwfET9L0m3IHx7DeG2bHo1uRBIiYg6Ny9fcSiAmOAmCcNKdVRC2lFV2bWDXmO61V12+kJv/sQuYV2vIcDgrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692830; c=relaxed/simple;
	bh=ttuI96b8TPAWU3eUM9Itnuq5UY2Y1jfoj2+oK9yoJZ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c6+p37Ym7SqZszDzu2nMLcBlHkj8I8yW7LTE7Rzbcrk65h2Qyw4AgPjNOwKSlxbGs9NVmREJteH+ShF/TuOiQC7IQCufMQbwvOkX4momd0MQzYgubun1K+QZ18X6mVIfdUv9Z4ag+R/1ZXrQldzms7R8W3LoNDFLyqkeu2lff/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edsMJHN4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9932aa108cso1015792066b.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692827; x=1730297627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gr7FH15dGm7nVka0Ti7MzdyhzA7Z3uAAoM0a1lGS+BM=;
        b=edsMJHN4Af1Z1V2m4/it9O8O9Qhg9tD/bNhtYV3II0aJDmubF1akROslUbVDVWBPph
         EA8byyHr03+Ax478e1uSmTgcFjjdUWGXgjzldm3OXWRfScs//AZyxpuoq+jC0gKy31a+
         qllo335P1GvAfIrF2XVLLMUh3hU71yXYwpmWDxLNuQ7VmTe/iB4bJUqNl2eYmhZIewas
         bxHtm6jMglslabGVR9EwpGb/4S1BGcGhd3v2++oCRrbdaU/5Xcq+YkbmnjoTn8VO4DY3
         DbPWYo2jhHRNjn/AieKZXOjzz5mMyCck3dorEIifiOquQX9btgaJeAAWV/sUXn/Rbcnu
         IzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692827; x=1730297627;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr7FH15dGm7nVka0Ti7MzdyhzA7Z3uAAoM0a1lGS+BM=;
        b=ZCRuoCcuh/CZLHTU/WERRK+rRBGDb/6uIZYFv1VV4sCapSjadUeh9RY3QIXpgUYGXa
         IxL0CAxlLP1qnuRMdvbbAfuC16HK/HkGLKK02w+F3Nb/oNdzndrK+EIdVNTnIPIt59KV
         IoTmKkOHY8Y7NPRLkywOFjaMHUMzwuGXId9zxFReXIbUsEioOF4lI9KACh9qqH1hLQDD
         SZesgyWnK0lEcr4RATr7dglwQAvNeXXZBP7AsLKM7ap4tkxTuUqXQr//3tfH5HASguYK
         SkbrUd7Myw9wwn1abm0M/hIwIY+ncinQQXTVI+XUujbPLYjLw169sQsdtvBkDrD8CE+7
         rNUA==
X-Gm-Message-State: AOJu0YymAUUqLXGc2SEku/+2WIYjqXnaIyoL+o/VatH4FSC5qf1cZBBP
	5JrW+m18Lsx3Dup2TXEsoWaUJwKhlMOSK7G294OnuD+u23t7NlCew17rfw==
X-Google-Smtp-Source: AGHT+IEuOmoHxesnxtutOhkErx+8qh0i2JT+sp3OD5HEHrBJdbGv4/fW0FK0CElDKhtVrTqgTY0wRQ==
X-Received: by 2002:a17:906:794e:b0:a9a:3cf:cdb8 with SMTP id a640c23a62f3a-a9abf8ba607mr275692766b.36.1729692827235;
        Wed, 23 Oct 2024 07:13:47 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee157sm479972466b.57.2024.10.23.07.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:13:46 -0700 (PDT)
Message-ID: <f52b2fcf-bf94-48bc-89bd-e55ebc3a2f2d@gmail.com>
Date: Wed, 23 Oct 2024 17:13:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 12/22] wifi: rtw88: Detect beacon loss with chips other
 than 8822c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The driver is supposed to avoid entering LPS (power saving) when there
is beacon loss, but only RTL8822C detects the beacon loss (because it
has beacon filtering in the firmware).

Detect beacon loss with the other chips by checking if we received less
than half the expected number of beacons in the last 2-second interval.

This gets rid of the occasional "failed to get tx report from firmware"
warnings with RTL8821AU. It may also avoid some disconnections.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Move beacon loss checking to separate function.
 - Move variable declaration to the top.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e6f985a92019..65d20ad02667 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -202,6 +202,21 @@ static void rtw_vif_watch_dog_iter(void *data, struct ieee80211_vif *vif)
 	rtwvif->stats.rx_cnt = 0;
 }
 
+static void rtw_sw_beacon_loss_check(struct rtw_dev *rtwdev,
+				     struct rtw_vif *rtwvif, int received_beacons)
+{
+	int watchdog_delay = 2000000 / 1024; /* TU */
+	int beacon_int, expected_beacons;
+
+	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER) || !rtwvif)
+		return;
+
+	beacon_int = rtwvif_to_vif(rtwvif)->bss_conf.beacon_int;
+	expected_beacons = DIV_ROUND_UP(watchdog_delay, beacon_int);
+
+	rtwdev->beacon_loss = received_beacons < expected_beacons / 2;
+}
+
 /* process TX/RX statistics periodically for hardware,
  * the information helps hardware to enhance performance
  */
@@ -212,6 +227,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	int received_beacons = rtwdev->dm_info.cur_pkt_count.num_bcn_pkt;
 	u32 tx_unicast_mbps, rx_unicast_mbps;
 	bool ps_active;
 
@@ -270,6 +286,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 */
 	rtw_iterate_vifs(rtwdev, rtw_vif_watch_dog_iter, &data);
 
+	rtw_sw_beacon_loss_check(rtwdev, data.rtwvif, received_beacons);
+
 	/* fw supports only one station associated to enter lps, if there are
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
-- 
2.46.0


