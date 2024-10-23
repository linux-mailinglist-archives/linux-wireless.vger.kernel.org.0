Return-Path: <linux-wireless+bounces-14404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136689ACC07
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAEF1F22C95
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931991BB6BA;
	Wed, 23 Oct 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEuJK7Y/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC291146018
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692859; cv=none; b=M7Hb6lS61kyTSgXWI6Qyn7KYKNMtPi/ek+Ct1N6AdbuPCibpiMNY7IiSIM5GqBs6RDHgCM5EJl0BsSnfbBJ2l8HZJLn8mauTYIEsvRsjELLMpJJ53xv4mIrjZGJkemZ5qOU9nBtpe2gXtBqpmT7jkiE3VgWMxw7OjfJ/81W+2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692859; c=relaxed/simple;
	bh=u7pZ6cLlKhD39gQJJ7KF+/HUbipVAWQv5dL1IrlJvb8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3IN+XyBcOwzY9T6ClY6rRn/S+cU2+uWQgKy8bRlWMrO1T2r3lw90Ic1ISqcfrjvYlht1L+uM1zLKX9kk+eqJLHH9kSoy77gZRdS/6JRR/2eueyPFFL6HVjmlKGVQ1MOJGLeqFUg8e/91xTiMudKjrgot+tO/LAZUutBxwo0N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEuJK7Y/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso8650442a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692856; x=1730297656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rKSR5ZLSL0OS9bwJ5h77es6Nzsmxx+GPd+Y/ggfbew=;
        b=MEuJK7Y/fbkQhjFBM6ZAMt3c6opWnkQzbV1avBBbC3JFe51ZDIpboCiKKK929QpzGU
         QCJSw7GdEmkW3j7WHbti1hECwgXBWesh+dK1LfJainp+iVlNKZXLlGpLWwto4wE0hQ+d
         A3eTXI3yD0ptFOcqvOBvNMIUhmD2xdcEMrezSct/soiydpup3T42d3JZYtmqKsdi7Pjs
         runfQCUF5YIyOIMsDoCAdborqSXzY5KwsYrD9KH1pLfa8D5tjQ9gxAqTugw77iRAXcIg
         Kj87mBFUxiGsargLnwdZxsntmbl4S+qPP6YEXPM7WfvMOzxhsKVLTD5mYRohVvaFc70s
         rmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692856; x=1730297656;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rKSR5ZLSL0OS9bwJ5h77es6Nzsmxx+GPd+Y/ggfbew=;
        b=TDpChoBAJ1BhehPRn4TAEjhNHBpJ9juqk4tUYqAMcHWSQo8ePBPkz5B/W3/N8tBJ7i
         zoVdKNYcfcdhbLlzza6VH0LhZSxutjz21gEyBa38hEq5qNz/jOBs9oDF8gXiCG/PlfRG
         jBotmx6Qg5JVjuLEWmvk0hhs47CboThxiL5j+3NHV9L3rRCYD+WykBnyKCnnvbXnY2ea
         ZL9WSRJAvWg1pZW0uPGTXE74gYzgtAnPiKK+sR01Ayw88dY8un/yofn5cMNGCtY2gmZ+
         tw5L0Jy+AIQDY6QDswbOh5+1hQECYd2B5Yb/hZLgPmWg0+MZt6Dlol0LhWwaZenb4kvO
         +U2g==
X-Gm-Message-State: AOJu0YxDdPe6vLLd9Q2nAGJ18CjDfvMxVAWUiWBmOP1p9K87MMGH2xn5
	tLTtHfaMQLasxp1iEAIcsGJJiXtEtCoElKbJ3L9HPgbKjks9PVbe1Mm4gg==
X-Google-Smtp-Source: AGHT+IE5jutu/Rrk3AX0U9H5gu0hfY81Q3R9JRNmTJw13kM5tVP0i4GHgxXeq2fvTpddv0aNTqxetA==
X-Received: by 2002:a05:6402:5202:b0:5cb:6690:eabb with SMTP id 4fb4d7f45d1cf-5cb8af9562amr1947552a12.24.1729692855900;
        Wed, 23 Oct 2024 07:14:15 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b974sm4462037a12.67.2024.10.23.07.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:14:14 -0700 (PDT)
Message-ID: <5058f23d-2086-42cd-82ad-eef31a348467@gmail.com>
Date: Wed, 23 Oct 2024 17:14:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 13/22] wifi: rtw88: coex: Support chips without a
 scoreboard
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
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

v3:
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
index b5aa46a44cdb..cd09fb6f7b8b 100644
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


