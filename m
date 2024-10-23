Return-Path: <linux-wireless+bounces-14405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536789ACC08
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739B01C212F0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96CE56A;
	Wed, 23 Oct 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn0vla5a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1F1B5823
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692890; cv=none; b=krSEvzPEAH28m+nvWe5NdKEcU+e/wDVnWA/DkmB6RY+SEvzlwGSitiUSLD6Oyjd4nBQEaknfkGA+jBKnpJOElFH+z/mptsRtrKZGq0fq3TlWanxG9LWQpoEVB4GKekN6Pe9Cg8+Wj8vrPZp/ppue3bH4hKr6XxSbq9KAkUWRNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692890; c=relaxed/simple;
	bh=Wyp/QiJnf/MhRsjnyMvrxMXP1RFUNq1wJM69srmq2pg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DHCDB1NEzo4GsMl/rzmLw/xxF2ed5B+wWhgQVA1fe/9a+3JUA/WV+vEsTQ8ZpKhq54Abj9ZRpA2X8FsqQkJ5G8QcpQ6L1I2LKkRkUrJxD0dBTLnjLe9QB/u0Z10SERinhYqFIINVe+x07Pj1z+4lgdedQsJLqzts/7oIoG5R3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn0vla5a; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so8689663a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692887; x=1730297687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QyMzMkt3y/FQ72U5AWDbOetjP796Xi4lqmxbimw0FEg=;
        b=fn0vla5asbvMsTyf9UWnNsH5WIeB18XZx7J8MmcZVOUfifk1BIQEhZFxp3lhoE1Siv
         +xmDl/dGFKMJ5bAIak2N+Ggi93UzHshJWM8CUCIxcPHb51Y5WjRdIexc10j0vQI9no1e
         379Yug9kZwEWiSmLoZTlRbZc1SgOGvOKSyxWn+JFQx+KtIFUkh52WZg3R/s8DpL2Ox0t
         Qj1m/Keqtf7CKO/282d8KidhBjrO7EybQW5GW/bw9ftndhRRIVS399j3Eg41btlXtjIT
         IBrPTK0t0FemAq/7ts/HQ9WdT4gcMc0wQ30U30P4bAuMLKCDNe90QaemghHBNg5ncxkU
         LEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692887; x=1730297687;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyMzMkt3y/FQ72U5AWDbOetjP796Xi4lqmxbimw0FEg=;
        b=j5+5wtAheeZXXFEmzfYFCvCfIOy1JDFac4ukYMQ5veDAmR8FCJ7+VbdEdyDnKrJEhe
         T9IId1d1M9Ue8dlVPKoV0dSDtt0oKBFol+NwzZcDqawd/sGJK7CdcbZ2M/07vVn+YW0O
         p4HnvJqxc7mNRHS0fCXORIyVO+NJp4tt40BTj8bldHJPw8xq39hH+2SCqmpaW7q8XJ1K
         sOL9saNcgzur8z3yxjBwV8x8xL+cWF3GUGtAyzB6EJEObU8OKcaeNhxvlExdZFHox2XU
         xYY9xnImvIC4D/fC+GIYl8UkKsqfrI0aP/dJ+5bIkio/yATLEzAB8uSHtWgX22omoeBL
         Nb6w==
X-Gm-Message-State: AOJu0YwpCX5N7Ad07/1QTHzUdAekDu1rHJ7Hxvlgw/SBp8UkBRftqf1U
	R/cb5mCzGfO2H1RSkPuzOHAkja8P2CxjFIpgArVGRJE8bV7H7h954h3BiQ==
X-Google-Smtp-Source: AGHT+IGR21OZ+LwCYkMftCvRn6cUhYKrAROHabfhMHgd15OesPjn4zWpHeRBw1H0Ed9inVA1B78OSA==
X-Received: by 2002:a05:6402:34d0:b0:5c5:c5c0:74ec with SMTP id 4fb4d7f45d1cf-5cb8af76e1dmr2119731a12.24.1729692887095;
        Wed, 23 Oct 2024 07:14:47 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72866sm4459487a12.95.2024.10.23.07.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:14:46 -0700 (PDT)
Message-ID: <358acdd2-6aae-46c1-9c66-fcce4e700b96@gmail.com>
Date: Wed, 23 Oct 2024 17:14:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 14/22] wifi: rtw88: 8821a: Regularly ask for BT info
 updates
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8821AU firmware sends C2H_BT_INFO by itself when bluetooth
headphones are connected, but not when they are disconnected. This leads
to the coexistence code still using the A2DP algorithm long after the
headphones are disconnected, which means the wifi speeds are much lower
than they should be. Work around this by asking for updates every two
seconds if the chip is RTL8821AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Move the logic to a separate function and add a comment about it.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/coex.c |  2 +-
 drivers/net/wireless/realtek/rtw88/coex.h | 11 +++++++++++
 drivers/net/wireless/realtek/rtw88/main.c |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 8f2b472589db..c929db1e53ca 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -446,7 +446,7 @@ static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
 	}
 }
 
-static void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
+void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 57cf29da9ea4..c398be8391f7 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -384,6 +384,7 @@ u32 rtw_coex_read_indirect_reg(struct rtw_dev *rtwdev, u16 addr);
 void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
 				 u32 mask, u32 val);
 void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set);
+void rtw_coex_query_bt_info(struct rtw_dev *rtwdev);
 
 void rtw_coex_bt_relink_work(struct work_struct *work);
 void rtw_coex_bt_reenable_work(struct work_struct *work);
@@ -419,4 +420,14 @@ static inline bool rtw_coex_disabled(struct rtw_dev *rtwdev)
 	return coex_stat->bt_disabled;
 }
 
+static inline void rtw_coex_active_query_bt_info(struct rtw_dev *rtwdev)
+{
+	/* The RTL8821AU firmware doesn't send C2H_BT_INFO by itself
+	 * when bluetooth headphones are disconnected, so we have to
+	 * ask for it regularly.
+	 */
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A && rtwdev->efuse.btcoex)
+		rtw_coex_query_bt_info(rtwdev);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 65d20ad02667..e91530ed05a0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -274,6 +274,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	rtw_leave_lps(rtwdev);
 	rtw_coex_wl_status_check(rtwdev);
 	rtw_coex_query_bt_hid_list(rtwdev);
+	rtw_coex_active_query_bt_info(rtwdev);
 
 	rtw_phy_dynamic_mechanism(rtwdev);
 
-- 
2.46.0


