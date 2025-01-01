Return-Path: <linux-wireless+bounces-16971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD909FF48E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CADD18814FA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471066A33F;
	Wed,  1 Jan 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyOFBiMX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC21854
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735748862; cv=none; b=W8XyIKeENPBiT64vRrTvnnOLfYNxjMrTO3sHg1qRoeGzJAQKo5SQ80Mkl11GWG9gZqf9RBBQqDwmPzU5JzqGNPbjXK5TGKtTPyaH88nN6CFoFyVoL3OA90awmxkm0E8VKhCh575EWfB75oKZS8WX7DT3g75Z5ms04q49fNYwN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735748862; c=relaxed/simple;
	bh=9S5tDGwedEI58iVf+doYQ37OHec3FWZEkEGPVpPww58=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GZF3qGVKJdtaAQ/o30Pu83NtrOZZu8JyBukjWSJDlEyWb3cd6RLY157m1dgstTxeEoTGQtRagwXoGuAb6bhqAoIBdXyGKrY0/kPCz3bJ526mojuQD0mhzn52m1sOZVvVriNZr7jlCF+5IifT33QBEMdnM6srObvF40s7nLqVqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyOFBiMX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so18449454a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2025 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735748859; x=1736353659; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VqrsRx72xdGdoACCDXaLNuD9qjBFeEiWXV3q71FWVk=;
        b=CyOFBiMXChJJwbZ9JRE8LFWxrMHj4f8bkB+2FmcFziy68sDGQTtNG9zU/hbR9ZSBNb
         2bPUbrDpqyoRQyl9hRTKgzTLSkRi5kF8dxGidj3rtK/Cfbiec5Yd5JPUNWhFC8qUbcPb
         IUsrHBHByI04wbVRWoWR02Q08ELjHWiex3ajKDQPl/TW3niaiahd+givSz3jSVFzE1OR
         ZwsMwfGKcyZb3JtLxvFdM+BeN6gIdLKs5KL36yl3XbehWOGuRcnb0rsXUnX8RZGbc8WO
         fdAuN3IeBz9FrO2ieqrl53ZyV3uFuHKfLspVRWenBXmqmjZ9sWJ1r2LZH0VEi4OyZ3PF
         dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735748859; x=1736353659;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VqrsRx72xdGdoACCDXaLNuD9qjBFeEiWXV3q71FWVk=;
        b=Lr+p/OGGFZPVE+H4s5yWy6l9ShH/MNOpg0+1Ko6V+OPQI6JuXU6no3irZcvJHxtOVq
         /28ER0iDmaSNbE4m2rP5chKrB5IdtVPJP95LBi7eRrRKYeNs6diECjL2DyAXH/sgrQ3u
         ZAfJeyIJqIcpREEbKBdoYNhIgcGzMDPyYH/pUDUixWg+PH2+AiU6NKpzrwzNpTEIzGO0
         zjU7mSouieF6kanyvHY5GH+7DwBilKPyDZWC3LQ7bE9z2UpxFK4rcfNAKW+snOk8CWxv
         47xGaM7Sr45NoEyxB31HBTRN6hXxQ9EgIZ/yep3hBlZESZTodDY5XPc7F/FnpkC8ypI+
         pLhQ==
X-Gm-Message-State: AOJu0YzXBxs8gM9mc0A3trhfzCXeezwUuZbMTCUdiA2nGAxiEiBPbd3A
	sG/SGSfaHwkikKHtUiJmsGJd0eMIUQ8BgIbK8uXjPLgDlKxDvOgppRnqFw==
X-Gm-Gg: ASbGncssbD7JNwKh1yF4CDSURRqXuuSgn/LjQsJMbAHC4PdPTC7PyO8gpoJ/xKXfPUI
	BdUui9EoGIXmz2Sq42KMZpulh/psNgmV3t4w34R64AXdwPzOYkiiynJX0l/3Ays0SmM8RjoceXp
	xV7klWAdzEp54FbNZM8SYtaf2JhJvZQauKax4vGEP4g4yJ8fV2RdWInmHg8ssaZgEWCpnn+yhes
	Eh+DtrYS/8EJJkMSWu2FyRX307zUF4LFdQCPddJXYklDWCXpx/hXGcbs9nYgn7x
X-Google-Smtp-Source: AGHT+IEVVQ+mHTlPCg33fhwT5/SpaE6jnCZ4MMm9qZ9+g5l/Gg3ilycucYJkCe/WTHAF5APmQrkZ8Q==
X-Received: by 2002:a17:906:dc93:b0:aab:f8e8:53ce with SMTP id a640c23a62f3a-aac2d455464mr3775096066b.11.1735748858553;
        Wed, 01 Jan 2025 08:27:38 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f014decsm1708924966b.149.2025.01.01.08.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 08:27:38 -0800 (PST)
Message-ID: <b80f7904-c6b4-4d12-a5f9-69ab9b965732@gmail.com>
Date: Wed, 1 Jan 2025 18:27:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: Delete rf_type member of struct rtw_sta_info
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It's not used for anything.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 9 ++-------
 drivers/net/wireless/realtek/rtw88/main.h | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e91530ed05a0..6993f93c8f06 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1217,7 +1217,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	u8 wireless_set;
 	u8 bw_mode;
 	u8 rate_id;
-	u8 rf_type = RF_1T1R;
 	u8 stbc_en = 0;
 	u8 ldpc_en = 0;
 	u8 tx_num = 1;
@@ -1302,13 +1301,10 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 		break;
 	}
 
-	if (sta->deflink.vht_cap.vht_supported && ra_mask & 0xffc00000) {
+	if (sta->deflink.vht_cap.vht_supported && ra_mask & 0xffc00000)
 		tx_num = 2;
-		rf_type = RF_2T2R;
-	} else if (sta->deflink.ht_cap.ht_supported && ra_mask & 0xfff00000) {
+	else if (sta->deflink.ht_cap.ht_supported && ra_mask & 0xfff00000)
 		tx_num = 2;
-		rf_type = RF_2T2R;
-	}
 
 	rate_id = get_rate_id(wireless_set, bw_mode, tx_num);
 
@@ -1319,7 +1315,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->bw_mode = bw_mode;
 	si->stbc_en = stbc_en;
 	si->ldpc_en = ldpc_en;
-	si->rf_type = rf_type;
 	si->sgi_enable = is_support_sgi;
 	si->vht_enable = is_vht_enable;
 	si->ra_mask = ra_mask;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 65c7acea41af..6ba9e0dcf9fd 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -757,7 +757,6 @@ struct rtw_sta_info {
 	u8 mac_id;
 	u8 rate_id;
 	enum rtw_bandwidth bw_mode;
-	enum rtw_rf_type rf_type;
 	u8 stbc_en:2;
 	u8 ldpc_en:2;
 	bool sgi_enable;

base-commit: 104372ff359486b26b5a2db33b8e1dc6bfb39812
prerequisite-patch-id: ffa5686d26c03c3bd942dd0e0c4e85d6cc1141c0
prerequisite-patch-id: 5fe117f3707ee7525549baaeea323157019be897
prerequisite-patch-id: f733af9c741a3e02f8dd374a402da4b07c51f97a
prerequisite-patch-id: 26c5a5c5739a581686f97ff17916b9c641a0d189
prerequisite-patch-id: 73580f2822eceab5e3a1d7291beebd362b9af45f
prerequisite-patch-id: ebd38e2e7e1f7731046d8641dbaaa2bcc9a385fe
prerequisite-patch-id: ebc85d1f7996a01b46f27e78dc6ebfb5c5a8c013
prerequisite-patch-id: 4cb1a033c2beec35dfbee0cddb8c8d1df80f2994
prerequisite-patch-id: 3887710d4f2069a49bdeb35d6e17144fe9da9c84
prerequisite-patch-id: 6b23ff2c45082cbce357c8547e5582455b160649
-- 
2.47.1


