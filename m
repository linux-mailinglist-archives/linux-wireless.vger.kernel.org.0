Return-Path: <linux-wireless+bounces-13914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771E99ADC4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6988C1C2264F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D081D14EE;
	Fri, 11 Oct 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWxLreDk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC5199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680014; cv=none; b=kbCOAZE9qDNXT3/oYkKBQbTqcKj3I0Z6awx2j7xsWqJrjGUSBTOPFOZ8ewuyRBhiAPxDA6YYC2dq7OucL8w3IxTdqCg95FEQ0FfjyYtHu0BS31VyucOuTHvcomL0LtgT5Vh03cK63J8vGN+mfz4r+jlByfekMQqIlbh/1X+uXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680014; c=relaxed/simple;
	bh=Yh3QND2ONKRRpAr7unW0BFy/q1zwLJJUteuEt/ESh50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j9m08d3MlIotWxrIh1F1R0m7aLdY3OITgS9hqIpjJVt/yH5WJRfTVHR0B1c0nw9rg+hzHWHSSEza//yd9ZYDyzmYPVfWTpuX/oOQXQ0EWMX0W5GXZlZnyUe2r4xSSJycd7AxHaDATh3tFHRwu5ajT7XutTPWqmJzBMt3EleRpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWxLreDk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43115887867so16112325e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680011; x=1729284811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jb2eulFW0qQPVkTTkL64Ef4nlQZ1RCYh9+vd/7IThWo=;
        b=GWxLreDkoFHVE8PSS0fDI69rvSKXYALY7vI9CE7W/fY11LnKMOt8ksmRHfyURRuolv
         mb6jgNobaMEUin8WbDrLKwPkqnldCSL3AMPD7GjXijUeayIWHhrIRcC2Ij/UHMYzWZuH
         8yA3Corv0ie9aqD7vwU6GhdeUuaftVOk6L5CVzRR2zhNfLeSI1c0t0l1syzIGN2WqGU3
         BXu3bjBNXPnJmvhNq3+qMFfNM9RbRWbD3NsdZqaLwyo+XGZ7iu6lFh7lRD45Pn+/rJG1
         3FnDM10VxawmNKpyMu0kEuITtHMm9QFw8IbuNwoWA6ZEquq9Q26B38HtbJ9+mAOLsdje
         q5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680011; x=1729284811;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2eulFW0qQPVkTTkL64Ef4nlQZ1RCYh9+vd/7IThWo=;
        b=r2VhSUVeT7g093MICQh+3rY3lRXkAl04DsQItqlAb7ZUxDhhSgdQKaFTRriEJph5oz
         mVSh873c0ChMTye6U9Ronp87uSAuT+i8TQk/HxYwLhCkJD7qfdXDm9wjiMTCmSJC5J7l
         lEtoTVR7dM6FjdP5DF6DrIKGfUrtlsTuXC9XJsZYdUmKMIfbzmRGkCQql24pmWoXxWPL
         0e/8dY8YCoDTYZXTRL/Y2HvSzd32rAVmMTuVSz7h1su99jIlwMT3uTPAkqabI1uLDrks
         nyMZFGcLA+WLB4106ptswr7AZwv+cjphxIOuFQwWLiLFe0Z238fUgGTwGHN7CfrHqOhy
         g6GQ==
X-Gm-Message-State: AOJu0YyMUmFbSXBNDEMvoeJdS/o1RFMTtbq5SVg7+Ag2OUsZ3RSuT4zb
	HQ8WBjrh8x/9049To5EEwdHeb/s2LjighIeO4e9knBTa1PVlo+lQhZpH5g==
X-Google-Smtp-Source: AGHT+IEI+hximSFP5bM0qvg1eFlw3YtkrxgCRDf+g59usmGPWurFN83UMlMmstt329VnFSKCzv+IFA==
X-Received: by 2002:a05:600c:1c9f:b0:42c:ba81:117c with SMTP id 5b1f17b1804b1-4311d8914ecmr32904655e9.6.1728680011520;
        Fri, 11 Oct 2024 13:53:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183062b5sm50630905e9.26.2024.10.11.13.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:53:30 -0700 (PDT)
Message-ID: <99aeae82-64a2-41e7-8755-9b5973d796da@gmail.com>
Date: Fri, 11 Oct 2024 23:53:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 14/22] wifi: rtw88: 8821a: Regularly ask for BT info
 updates
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
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


