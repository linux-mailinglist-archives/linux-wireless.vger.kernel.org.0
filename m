Return-Path: <linux-wireless+bounces-10590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2293EA17
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 00:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3633CB20ABF
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E154FAD;
	Sun, 28 Jul 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpB+Ucqd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149E2AD29
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722207098; cv=none; b=Wq4Sc5nxd3miXHy5LNOOkookuyIpmg7ufmmwLkZ7c7smKTKYMZnLogrH+FBgNnig9VbW6lzLphe+Tmh8PhlGfqqKIQ4auN5HpqOVHCeFFRadnkhFYTwo3IEM9Zdbf7VoPjmq+epZBy42bYdymNRoleElB9jOX9khaGPP1wZl2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722207098; c=relaxed/simple;
	bh=DZ2LQAVSFIbhPnSxaXPiv9dyKuxE4dmthsUqpn2GnL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WBkAEw7DaUUtxRkx2hYuDSqf2HEOn+zHelV+tiZm9412GPnW80SkcU167B9ylDWTCGv8o7j0wxEiU+ilER/EImlBkOPoWV/bgcH6oiS6IiTDQA+/5xR/VwBqu8Edu9YHGbKODmul45CJnCtbcPZsyGmOdPJUAiQZidX9hoGgBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpB+Ucqd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7abf92f57bso398046166b.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722207095; x=1722811895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eErmgg3C3BYnn7rzeAexXGu3bOZN0GGwGvi9Um95qrY=;
        b=XpB+UcqdGX3vteHYYRf9TyJWhR7cDWtmcfmwlPfYOfmDBhG33GB9nl92upN6E2lMmR
         t6UMw7hLoS1GZt3GJQv2yV029n64sIPlle5/HV6DqMwhVUAwtXhAjyZ/45ES9/XBdCpp
         uYlboPMwNGlH0FylgaKIZjIQDgvLMJakmm27Y6T9vyQhIBSVKkTDQK+AEFecKKqW7nMH
         EFKP4QcIhwh9U1kkGk5kUPLuTl7DYQsHpiaAucscO4yK9FBWq9fLNwwhf22BqFgLwU/G
         ILMAnNjEFaIYO76yf4wjkXNlFdAi5PjN0fLmUiPpOO4m0D4WDLHw4UMMHJrXySJe45XO
         9eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722207095; x=1722811895;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eErmgg3C3BYnn7rzeAexXGu3bOZN0GGwGvi9Um95qrY=;
        b=cqrVa/NWrCmLhRiVBHbNkdT18RE45tNUzbH2cFBoGHwEvMoaG/wh0OI5suhDngoB2J
         7kBgX4OqfYymp8Rup+U/3rCqmLpJld30FqiZ6HdGyO3Vj5vdL028rDieXFhlPf5Y+TQH
         32QvZCOcAaVb+xMxczDnJLJW7n7Vrc56p5H7ssbXOZ/1/eFAvm40Ii4LuI6lCdwJDWbw
         DVL5OheiiCSFKalX4v/jTg9Q0jmGJw7bYgXjDbgLlu6mnEi5Z0qShsFkCtl2j621v1gA
         IXVS8aPIV0t656N0C6cH96EfW940tMEmZXesIH1slHhCQZnc10gEAgX0KjIzJMfkHG1T
         XmIw==
X-Gm-Message-State: AOJu0Yys1LtuFfyYEKz4kzWHouYeBpIZWcWowaqJaW3UQMdiCXyA8BBB
	YKBdVa58w9n7xdlKKI3EHgwWESaMwGHHj+LBJmLQSX5NIPh9j9E8QhX1pA==
X-Google-Smtp-Source: AGHT+IGpZeDcVOtuImkW6pwJg8cy/NhPumynqa/MjXv9LtFtuc/Fs7jkyLGh3QZJDuX4MjmsX6LuhQ==
X-Received: by 2002:a17:907:7e9d:b0:a77:aa6d:e0c7 with SMTP id a640c23a62f3a-a7d3fff5d65mr394479966b.30.1722207094549;
        Sun, 28 Jul 2024 15:51:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23157sm433031166b.33.2024.07.28.15.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 15:51:34 -0700 (PDT)
Message-ID: <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
Date: Mon, 29 Jul 2024 01:51:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
Content-Language: en-US
In-Reply-To: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In AP mode, the firmware stops transmitting beacons if it receives
H2C_CMD_RA_INFO for macid 0.

Leave macid 0 unused in AP mode. Macid 1 is already reserved for
broadcast/multicast. Assign macid 2 to the first connected client.

Tested with RTL8811CU and RTL8723DU.

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Tagging this for inclusion only in 6.6+ because that's the oldest
stable kernel with USB support, and presumably the PCI devices don't
have this problem. My RTL8822CE doesn't.

I don't know if SDIO devices also have this problem.
---
 drivers/net/wireless/realtek/rtw88/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b3a089b4f707..e0b1ccc3759c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -316,11 +316,12 @@ static void rtw_ips_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
+static u8 rtw_acquire_macid(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 {
 	unsigned long mac_id;
 
-	mac_id = find_first_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
+	mac_id = find_next_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM,
+				    vif->type == NL80211_IFTYPE_AP ? 2 : 0);
 	if (mac_id < RTW_MAX_MAC_ID_NUM)
 		set_bit(mac_id, rtwdev->mac_id_map);
 
@@ -345,7 +346,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
-	si->mac_id = rtw_acquire_macid(rtwdev);
+	si->mac_id = rtw_acquire_macid(rtwdev, vif);
 	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
-- 
2.45.2


