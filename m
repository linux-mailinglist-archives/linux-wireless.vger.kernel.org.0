Return-Path: <linux-wireless+bounces-11283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585994E332
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5767281343
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF22595;
	Sun, 11 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiGeLQWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D161E890
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410173; cv=none; b=FMHK5h+Uf9x/bN0THI9wvtZuzJSmQN/Vl5lxb3DTpfmVtRFU25joyC5uRMDmxz1/4E8uUoPUKbAmRtoQuGqI0e48LnXCB+61+UzcrxX7u0ixPvF9r5aSoJdDsXm/QZRqZ1IrrYBHKw2DAMmgYCtM3naX53NMs8Ev1WMMIdbJL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410173; c=relaxed/simple;
	bh=AZI3RLETLA6itEgbZTo5aAJjgYBeMgcvGGUU9TEmKWU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DGZLPM0DmCLEnTBAwWQYHXJBVkd8FjN+3jvre4RvnTO0YW/Jxe7SeWkachbOiZWXAb35oqM7frxY2nWjJqKp0CfLBzd6I6FpWFVcXhhYgWZtAGnxjOw3rJXhVAk4wlNBDGuSjaT7o6OHOpRcitWT7DFrvXfHXLXHWJV35ATD6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiGeLQWJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso6592603e87.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410170; x=1724014970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ayhhWajW/MG8dH08Y471uR5wCQBV8psA+4gEbOuXc0g=;
        b=XiGeLQWJb6lE6o9Tqt6eyIbViOpZ1e0/LO7vhiIRxNNa3cVk92KdWA+bpFq7G6jr1E
         LdI/T3JEajliXTSBW1eFx4YA45VZ4JHq2jPvUdccSqZvP4Z+yF/Bbd8s0s6o1h/8oIMK
         xArRjmJnee2q5nYRebD0A8n40r2yqIbSK6oSaIDRR7gIjAEqMC8EHlmqhEUYyKaog7UK
         xmooosUSwEFBLfFCKdJ8lMsMgV9Jj3rbAR7mtOsq8xDo8KJrZ4WdnqkO29wWC4SLjuU5
         ZAsMVeq2TNdFUZl2HAfVbH/LxCCt6KXQ7+4bF2DSbDB7I/IWOObIpMwwHL4kmODOszMI
         rLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410170; x=1724014970;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhhWajW/MG8dH08Y471uR5wCQBV8psA+4gEbOuXc0g=;
        b=eY0A4Q8G0SyByy0WQPPwfFhLgjim7DAhbtM2qBqJ8gDEkE/9UuX+gKMl6s2KYTpywa
         QQckhQKmdqWXy5WaoJrZsoClPhxY0oztnBBKIv6vya0qG+7frpdU9tdffsh79SF+7/kU
         nnXeLBYWU6NbPuOVvmjns5OIWVRmifNYjnAUb9CXdYcgPS+Nh1G6oqPmTvNFmKGnthm9
         NTaBztMSqcdqtgdGWOIqYw57slRujJbnaK+dRb5G/NglZOzwySbC3Ns72vqmWg/O+hIR
         /9SPWH9HSUz/U41DmNZXePgRtS5tlx6gfDTIF3R+JeyIv+eLVxe+OBvqPtpiqYFE31o0
         pIzg==
X-Gm-Message-State: AOJu0YyrhUaGclMpXhyPRJJJQZsJutyhVhqUBtEpwFDXksntikEowT4S
	HFe8uWraAKZT9O9ozVQlsulQAEAS/zJtryNIUx70zELTDDmDOyn/47wT/w==
X-Google-Smtp-Source: AGHT+IGiM/kPwL6WQAPPFwtgutg5Im48aB8Fxd+O2XJkJj7ltK4D6LKTJZrTsyNgdteJRXUz9/73tg==
X-Received: by 2002:a05:6512:6c4:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530ee9f3555mr6511891e87.42.1723410169804;
        Sun, 11 Aug 2024 14:02:49 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fcecsm170819466b.8.2024.08.11.14.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:02:49 -0700 (PDT)
Message-ID: <aea73a7a-e791-4475-bde6-500d9f3cb2ae@gmail.com>
Date: Mon, 12 Aug 2024 00:02:48 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 12/20] wifi: rtw88: Detect beacon loss with chips other than
 8822c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
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
 drivers/net/wireless/realtek/rtw88/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 3806e57400fb..62d9abc04a34 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -254,6 +254,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		goto unlock;
 
+	int received_beacons = rtwdev->dm_info.cur_pkt_count.num_bcn_pkt;
+
 	/* make sure BB/RF is working for dynamic mech */
 	rtw_leave_lps(rtwdev);
 	rtw_coex_wl_status_check(rtwdev);
@@ -270,6 +272,15 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 */
 	rtw_iterate_vifs(rtwdev, rtw_vif_watch_dog_iter, &data);
 
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER) &&
+	    data.rtwvif) {
+		int beacon_int = rtwvif_to_vif(data.rtwvif)->bss_conf.beacon_int;
+		int watchdog_delay = 2000000 / 1024; /* TU */
+		int expected_beacons = DIV_ROUND_UP(watchdog_delay, beacon_int);
+
+		rtwdev->beacon_loss = received_beacons < expected_beacons / 2;
+	}
+
 	/* fw supports only one station associated to enter lps, if there are
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
-- 
2.46.0


