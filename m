Return-Path: <linux-wireless+bounces-11284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E649194E333
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F51B20D56
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECB18E20;
	Sun, 11 Aug 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLqTciuu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064C2595
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410219; cv=none; b=GAq0sU/QWQsTmSW+zWfb5Fad77SZzGWgpVOacpAlgQVQwbTiVVTvWpAFFqrdA2wKMIB1OrYeQwZCvhvKEsCEiPZWxCovpT8hlGJbPagX4ab+tgsgfwCgPH9oniEgFhENkcj9Twt0O8nO5GE/1gE7LWFG46rm7E9VMR+uq9x9n/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410219; c=relaxed/simple;
	bh=WtA+FRo4fn3aj+h/YTz37L5cyh51xJHHeO5yl+D8DXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kjir1dW8kpkD0oc/B8Z2wv04EvGy2YrtXmd2zHe4H/Rxka0blEvSkok37b+eAB/HnL04VuS6wOutLfhlPJVpjNpQcm4bUvL6XZmf9xlVp5OsUQlvqH07ttq5SINqd6jJ1VaFjkTuqoIqqUw2N4S5QOypf1MpJdvJBQHYOP4USYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLqTciuu; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso4436133a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410216; x=1724015016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/oc9tgeXEQISzzaJ1Vezj3CUQUPzmAFFQKXegJ9QYhI=;
        b=GLqTciuuCJnP4kqfwywAwE7DcQlPDZfIHDVCuEnmJIBM74/tX0z5l9S7CV049vB/Sb
         SpY77ReiQe/wmPRpmHT+TWVv3gUfEp//5OnWW0D+nimvawLS4tciiyfjXDsfjMUJCi2d
         cZ9ba5KomM32BAMKNRRfyCvi/derkNhhf1PKjI9UVkubB6BdPXQVG47m4GYwFxQvJ2Ff
         60zqAslMuDHKSBxz2OI+4d/AKkgaLfDvsU8eLBaEHfsc3FpFzEUTOw8k2/zDG7WXdnMP
         n5tfvoKFyz2lNSpca1IGciMi/2t7Fnfkw7e+BqMWXqZreHf+c5U4cTfLUCW5U2tiaI4X
         pqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410216; x=1724015016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oc9tgeXEQISzzaJ1Vezj3CUQUPzmAFFQKXegJ9QYhI=;
        b=tbZZeTr4NhMhe9tKvOE2r4WnkdGtHkbxZqaYJsKve+mYJtW8lH6NOpb09XrsqNR8fE
         x3KtTCOvfK75McXfXLMwXw5TsQ6bHG8fFjp1/J4lJRo6E/uINY3iLSciiom/oAdonTW1
         asNShcSks2Xv9VM/je369wjjiiq9hTTLiRn0wyWDzdFXqS2p23BQyuQotJPi22n5YCNj
         jyrxiiVfb4NcLPKaGFgHkUp+ZF8NmRgGtsjKmVkJWQC4Uw8A9/Y6grLdQg5+Ot+GU/03
         z5MGgj1K5ZcvMp6ykgsK9loqWLHLZNELD7R1LyOU7in4BvJPsdNgl78vQlodzS3beSqO
         0mKQ==
X-Gm-Message-State: AOJu0YxVsKRpi3y3dSn/wrNG3uKJu7skT7W1cUy/O30wekih9+BW+VNm
	NlaKRiv+Pn08aQ8o42AKf0MNZUdgWVX2qbPuagDy28c7DdFOka7JgXImqg==
X-Google-Smtp-Source: AGHT+IFfweikH+U+7ANroRjP9bhISp5wIDU3cjpQ81y77JfCa6YVEiR3Nnr8ZUpfx+uWP6LjC7GF5g==
X-Received: by 2002:a05:6402:358a:b0:5a4:2c8:abda with SMTP id 4fb4d7f45d1cf-5bd0a50a533mr5298020a12.3.1723410215547;
        Sun, 11 Aug 2024 14:03:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f32fbsm1581135a12.11.2024.08.11.14.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:03:35 -0700 (PDT)
Message-ID: <0c597b71-4359-4571-91f8-44910854a136@gmail.com>
Date: Mon, 12 Aug 2024 00:03:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 13/20] wifi: rtw88: coex: Support chips without a scoreboard
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
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
 drivers/net/wireless/realtek/rtw88/coex.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 7f12dcc03d70..39fbc5ef82f8 100644
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
index bc444c4cfade..bd43bb759949 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1496,6 +1496,7 @@ struct rtw_coex_stat {
 	u8 bt_hid_slot;
 	u8 bt_a2dp_bitpool;
 	u8 bt_iqk_state;
+	u8 bt_disable_cnt;
 
 	u16 wl_beacon_interval;
 	u8 wl_noisy_level;
-- 
2.46.0


