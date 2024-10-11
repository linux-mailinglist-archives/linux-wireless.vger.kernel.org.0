Return-Path: <linux-wireless+bounces-13912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FC99ADC0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F861C23AE4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ACD199231;
	Fri, 11 Oct 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzJG37kM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3011D151F
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679938; cv=none; b=JGLOq4iIRfelsKUezE6yT/gh8o/Krx+ygKamXp8kRNEWmm7uzhJrpiTloZ6ZNdq33fGk095ZFkFzCoM89mtBFM4DVryxqg8NXgyKYBWKweSaj7YMyZc2L7SUtzdQXZrr7u5/7UkgkyaRrxMezkVLCjSQU2/vToXBidCnpKUfReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679938; c=relaxed/simple;
	bh=HlFUS57sNR9PPpSArrDhNs9SnDsLMQFc9/BKQfqrOHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qnZwdZjBlG56JNuBMdcWBNdHuNZav6GjCa+jzTYZ+IfjZ/6MQaFFnU8sCqEo+zvcGuV/49RydbxfjjV+RljNSCsxxDQBS5bQyMjR6OF2bT9OkUO49tJUy90DPxolMFLbGRjYBJabh5MFXatPs/EcuHKZf9j9CXfU2szqslU53Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzJG37kM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d41894a32so1577734f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679935; x=1729284735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+bLQzUj6BJjH3Gvj1ZoTxcYyUw2gto/CjkJZSUvgnU=;
        b=EzJG37kMJTkRPWrd/FM3PIQhYJZrj0BGAH//fELS0TytghIs3fH3JjCNrENYi6XE4F
         7hmzb2+P6QFF8/Cf8eK+cyNHJIsvlmIAvxHkoPsMHGtRzHgpKsBuhxqnt0ToixU5mOIE
         m0cljCrI1iLWa4ZiTP+cHFQIol1qBPVpMCPz0z7rnMZFNnPm2eejazzTn0xnJMdXlZYi
         ynxquQB+PZO/qCp8pfO1QAqK3ICzQJThtGLUHJVYF4HV1Ea2mGj0kgybFcH/Pd9N+4aV
         /Y9a3VICpwvnhISgI2Rh0A00tXPUvL6MH9WjBSyRLEKy5qBfRyAUpzT0LQdIz124T5Lu
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679935; x=1729284735;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+bLQzUj6BJjH3Gvj1ZoTxcYyUw2gto/CjkJZSUvgnU=;
        b=xSO519jX8aecZc5qyAQVyBY/pjQFjlSqtZ4hzSmEQGUP8EgQde3E5Fw91QaubUOfeV
         Ijs5deoG0wA+YxWNrDRSPUdJ+ncWyh3TRvIgn9krusWMHDaibsJ0edSL9xehXxQqtjvu
         tCvicdBBt7GQ9BhCqs8tl6y3ylyrZXhYlxyeB1vo/q5cpoRcPXH4TapPx7dFwa6FvZbX
         MaAcghvp0VdKN/doRee6YulE/GsJTq5ssvZnudj7L/bZPK47uZe4+qghCgNPkLG8rEWY
         5vxYil/aou5TdeZU/x+lvNXRc3QW3NvGJ2PvhhMnLVbqtJivlmyPChEw7f8dLPgLrwxg
         bXMw==
X-Gm-Message-State: AOJu0YwSpxzSFRHvtd0z8XYFJSqVevdgWazwLuuttz5VJP1kPDOO2Eof
	PjPq1xHIEzLnQkmOMrGN0ovuHpKVIwuGiv3p20ZFC6Izo3vHhddy3FWBWw==
X-Google-Smtp-Source: AGHT+IF5Bd495GoXMO2ThsFKzwIQkR/rfo0NwD0kEhhh+Wp0Q/PxZe7TWmpOK/L+W0Gjckv5mF/kgQ==
X-Received: by 2002:adf:cf03:0:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-37d48194896mr6585668f8f.16.1728679935246;
        Fri, 11 Oct 2024 13:52:15 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45e3bsm82969205e9.15.2024.10.11.13.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:52:14 -0700 (PDT)
Message-ID: <a60666a1-88e6-4e84-ae9b-ac2eb903dd01@gmail.com>
Date: Fri, 11 Oct 2024 23:52:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 12/22] wifi: rtw88: Detect beacon loss with chips other
 than 8822c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
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


