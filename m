Return-Path: <linux-wireless+bounces-3386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AAC84F4BC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907632832BF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673E2E415;
	Fri,  9 Feb 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyLxTJ6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416C20334
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478541; cv=none; b=OljhFl3YNvtwxGkFfKzrjUQQgLWxJe49/2c17PVtPCEdWLPRUYaQzsrgNeodL9rtvO8HiIkpX0QExcUiJP+9hWl/jgfpMEczy+EvC93Z9TdFWCHWi0qsJUz9BLpmfiQbpVfBW5HOfnpeXXUaifyuxsnVzNf4cgLSo5ZOpnRW/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478541; c=relaxed/simple;
	bh=OLGM0HoaT8iMv3DwzlYuMHB7VYGNVy2MDATK9JBr11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMAln7nsv8WcenoTVLC/XX83A2EMNkMuXA/WQ+HB7XgnV4BLUuFXPySaej0kEGZQf2xJxD532Sz/BMDFgbh6dmDu4DxFoyTOuzkie+xU7Q07EOhy5tgSzjG21wi5mCvOOI8pna4NNWvy9YjNqjq6hDERKl7SC9QYU+aDecdZ5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyLxTJ6X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-410585542b3so6579515e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 Feb 2024 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707478538; x=1708083338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm4JJt9uD1FPJlWzQS1y3vdwjoX/msXl9aHi4Ixrq2w=;
        b=QyLxTJ6X+cUW6iaua4Mm/uHjRsAQ5NICeHKcU8JRBlG6tuokcF3vCR8A/FcMYFale7
         col8maUKo/fIg0kZW4XoZovWmNsO7hNuWyr+X2FlBxkCuqpXHL94k6uRXOtIhlJ/IoSc
         q7A/u41qO93n7O7Pg0TJhGk85f/0P0tDQjrCcahy9jjpHroBNU5ZVtnFQBYjo5T7DkQt
         ZulAqMjcyFjjLq1uKfLvOezH/blyhUon6BfYOH2lDwowyAIKv5nQ5ij/70YiirXOvFot
         CpRaz4iJES8VkYp3N41BzoOhagOURHa6BoyQAmYCKVYBCTUiMMo7Pw7dF7z8jgbAoaFX
         sYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478538; x=1708083338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm4JJt9uD1FPJlWzQS1y3vdwjoX/msXl9aHi4Ixrq2w=;
        b=qkE1BLXni3z7xddF7/lcHWp2yREfPKXeUCnmpcyvnF/Q23GsRlpXdq/V3DnPPfDENb
         WVdHffHX9AH6YLttYcquPjdJ0AD2HyRomOO40W4bYZHakyQSNferKNEROaz3YhAHSn4k
         cfm8nLSCdJ9TFR7gUP8AF1RJ/6dyoVzL+yjV9zDeVfv9Wci751u5I0Wpr0GJ31LzoBqk
         TGCHcffLGQ18dnmsMn9iTgFybm4j/7al2hSBqkvFXo0VZz/14OaEWOC/lRAODpzFYZfd
         diLD0YQnbhYlP5ZvPS++HYD0Zpt3gT1Yu6JTtvyFq/nfFYp8pfb8fDSyelqWRbnEODM6
         YUOA==
X-Gm-Message-State: AOJu0YwuNz00bVNuyDmk5wNeVOVVhhxvjet1+dmRniO5t4fWXpxUShMa
	YZA54unETbp9JHnLpdq3So4vT3VThVNmT5t1Ja4sc+EyCtD45cNA
X-Google-Smtp-Source: AGHT+IFmiJ2G7GqQQljSg/6FYb0ezyz9HlO6sLBHNN3PZhmm2gDtrn5oXA+qrP/xHI8L2BmElsiTbg==
X-Received: by 2002:a05:600c:4510:b0:40f:dd91:2d06 with SMTP id t16-20020a05600c451000b0040fdd912d06mr1006044wmo.32.1707478537791;
        Fri, 09 Feb 2024 03:35:37 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b00410723b14e4sm346251wma.19.2024.02.09.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:35:37 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
Date: Fri,  9 Feb 2024 12:35:35 +0100
Message-ID: <20240209113536.266822-2-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209113536.266822-1-nico.escande@gmail.com>
References: <20240209113536.266822-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1] lets not use WMI_SCAN_XXX defines in combination with
scan_flags directly when setting scan params in struct scan_req_params but use
the underlying bitfield. This bitfield is then converted to WMI_SCAN_XXX when
filling the WMI command to send to the firmware.

[1] https://lore.kernel.org/all/871qae51wx.fsf@kernel.org/

Tested-on: QCN9074 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 6 +++---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index be04f823566f..7bf5d1068164 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4013,7 +4013,7 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			       req->ssids[i].ssid_len);
 		}
 	} else {
-		arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+		arg->scan_f_passive = 1;
 	}
 
 	if (req->n_channels) {
@@ -9252,8 +9252,8 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	arg->dwell_time_active = scan_time_msec;
 	arg->dwell_time_passive = scan_time_msec;
 	arg->max_scan_time = scan_time_msec;
-	arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
-	arg->scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
+	arg->scan_f_passive = 1;
+	arg->scan_f_filter_prb_req = 1;
 	arg->burst_duration = duration;
 
 	ret = ath11k_start_scan(ar, arg);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 688ee20528a0..78c11025c21c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2098,7 +2098,7 @@ void ath11k_wmi_start_scan_init(struct ath11k *ar,
 				  WMI_SCAN_EVENT_BSS_CHANNEL |
 				  WMI_SCAN_EVENT_FOREIGN_CHAN |
 				  WMI_SCAN_EVENT_DEQUEUED;
-	arg->scan_flags |= WMI_SCAN_CHAN_STAT_EVENT;
+	arg->scan_f_chan_stat_evnt = 1;
 
 	if (test_bit(WMI_TLV_SERVICE_PASSIVE_SCAN_START_TIME_ENHANCE,
 		     ar->ab->wmi_ab.svc_map))
-- 
2.43.0


