Return-Path: <linux-wireless+bounces-13913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B059999ADC1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C244F1C217B9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDF1D0BA2;
	Fri, 11 Oct 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL3xUbiR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AB199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679983; cv=none; b=QOD8kgjFWHIIEoSyOI5kGMhSffps5/qfG3u8gPJ4BMFiIlda/F1BdEzbeJhLfT+5OFN/8zBqHZeOWImkGi0612exdUoxsW6U8p/uNRWyThtCb0a1UxdIKHyRcOjiFKUdTNlesYVHldKuDQDscl19yeYy4ygHGfWKdD5A6EwBaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679983; c=relaxed/simple;
	bh=R+EYqRAS4lq5erX55FzfU31qPxPT8FI3bC9B+T8HOdg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ROdqmv/TqeJLvCC06X+M1ncu02354FDt+BlvibkOkkBpGJTBeSC5gz3fPD9QXohq2XR7P7E6/TjQSirZ5sPKssBXkoFnISNo36MG/UlU749Ef/jt+4OTfHQdub3J5ceoog104u+DgXDldGEwDrlTlVphUQo6JotLHAS7mEJtisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL3xUbiR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43115b31366so20855325e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679980; x=1729284780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cM4uzy8R8NGb2a4b5C0gzPLbc4dyoM4yonUjKcNSTHA=;
        b=aL3xUbiRCykFM8G/j5r94zhH58QT97VENeoXBXA6o55/hIDoje87zx/HQs8jYLq2Pi
         ApLb1SocQkXcXiraqvFya5W7iNWMorhy1N24/EdQ4IoHLhp/fKrSuN8C2q+tV0Bsu6vt
         6lzS2zmZQd8yLAKS7ye0nh4VcQ11y/btGTMfglIXAJ+nUnSQmTQtE1AoarIkSFlMr8yD
         THoa1+qUsJAQCtJNuT6LeD0ZJVoIPHxpIQqGQr1pkP8+z9hPN2RkWbfSPdhCwuEVz+mb
         rVVhexjrbgS9qONXU9vJR61pSB8OeN7jK6xCtZV3ZjSa/xVupx+qi3uf7ELbRSVAzVS6
         ArvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679980; x=1729284780;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM4uzy8R8NGb2a4b5C0gzPLbc4dyoM4yonUjKcNSTHA=;
        b=vya1LXZeqQ4dfxEHD/xyDTCHL9skZVNJOzA85NWvWlj/7dPEDHMk2CQO+BnkQZd0aw
         cCS7/rRF1ViLIVy1nFbilixbphXsG271cdswE2/FAbpWucRV2Bym1S8XYTmOm1sQ6Sd6
         UhiCWGk0QFR2xwoMXN81B0LC88uCJL9r2QC8Gw6YHjAaJzM9yEmg7kGq/aZPk+3mrPfN
         RzpBFGS0KZBjJI18/MJjuU7z6uoHzrW1MKj657SN0RRrRFVVY7XkX4n/v+YbuoPvo+Hh
         a6vbTwEDq1LuBoeQ6v9i371jMU0fJiBrWnEBFe4728jzhQ7sZ/A1I2tixUYU+nmjRSFK
         QHEg==
X-Gm-Message-State: AOJu0YwtmqQ0t/filcxvrj0BHZlD9Vo4VPF3l5e+HoSBsT6IZCJRAhKr
	N7InwrlrceK56uaKleyZSbH4zPdXAXTJ95aZc+ksrCg1+bYcK472H70V7w==
X-Google-Smtp-Source: AGHT+IF8DYTmqXZbALRL0RFrDzwGAg/V5aBPGDRNpltn+WakIfeMwSCjoIzLsxqW4FhmZLyAwFUxPg==
X-Received: by 2002:a05:600c:4e8e:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-4311df1e45cmr31787145e9.25.1728679979678;
        Fri, 11 Oct 2024 13:52:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd399sm4704226f8f.26.2024.10.11.13.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:52:58 -0700 (PDT)
Message-ID: <b1d98277-c351-49a2-902f-9ca1e86aded0@gmail.com>
Date: Fri, 11 Oct 2024 23:52:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 13/22] wifi: rtw88: coex: Support chips without a
 scoreboard
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All the chips currently supported have a "scoreboard": the chip keeps
track of certain things related to bluetooth, for example, whether
bluetooth is active. The information can be read from register 0xaa.

RTL8821AU doesn't have this. Implement bluetooth activity detection in
rtw_coex_monitor_bt_enable() based on the bluetooth TX/RX counters.

This is mostly important for RTL8811AU, the version of RTL8821AU without
bluetooth. Without this change, the driver thinks bluetooth is active
and the wifi speeds are low.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/coex.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 8c5aec744f3c..8f2b472589db 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -494,11 +494,29 @@ static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	bool bt_disabled = false;
+	bool bt_active = true;
 	u16 score_board;
 
 	if (chip->scbd_support) {
 		score_board = rtw_coex_read_scbd(rtwdev);
 		bt_disabled = !(score_board & COEX_SCBD_ONOFF);
+	} else {
+		if (coex_stat->hi_pri_tx == 0 && coex_stat->hi_pri_rx == 0 &&
+		    coex_stat->lo_pri_tx == 0 && coex_stat->lo_pri_rx == 0)
+			bt_active = false;
+
+		if (coex_stat->hi_pri_tx == 0xffff && coex_stat->hi_pri_rx == 0xffff &&
+		    coex_stat->lo_pri_tx == 0xffff && coex_stat->lo_pri_rx == 0xffff)
+			bt_active = false;
+
+		if (bt_active) {
+			coex_stat->bt_disable_cnt = 0;
+			bt_disabled = false;
+		} else {
+			coex_stat->bt_disable_cnt++;
+			if (coex_stat->bt_disable_cnt >= 10)
+				bt_disabled = true;
+		}
 	}
 
 	if (coex_stat->bt_disabled != bt_disabled) {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 072d09a7d313..545e91d6f4c1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1494,6 +1494,7 @@ struct rtw_coex_stat {
 	u8 bt_hid_slot;
 	u8 bt_a2dp_bitpool;
 	u8 bt_iqk_state;
+	u8 bt_disable_cnt;
 
 	u16 wl_beacon_interval;
 	u8 wl_noisy_level;
-- 
2.46.0


