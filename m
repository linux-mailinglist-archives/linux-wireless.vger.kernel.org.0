Return-Path: <linux-wireless+bounces-3387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E978284F4BD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 12:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC7B256EC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1622E651;
	Fri,  9 Feb 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2/m8ACL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E942DF7D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478541; cv=none; b=RdtKDFy3nAmAM5Kj1W2XDUeT+7NbfTmvWOmbIUxI/8lyrIBuPJSdpc/qBP8/8fRDoursk6EljHIAbRIqaDo8cY5Ns1x5fyaj5l5JEU8DlwX+mQe40DGXXQNHPyLTczkOXdKU+vLp63zHEY9LBjO7eiDNsDuhQH8KZOo6RgQe3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478541; c=relaxed/simple;
	bh=vnkX1URmV9lPk0B92oXHPV+zjITHUhdmL5AhRdIwvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLhg75C8CfyvzyUwmxwU9BMGpgbt5440qwsTPyd7stp7knc61KEbWVFkYwouZP00OMuABYdgitfsWAZEF4y6pgEEWReROWcE8Nem/l/ZjpFC8ScJxP8NzpqlTY8eunCOwsOHioUJmAdMkKk6tGI80WweHzzwFfmhSOpwJLmTFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2/m8ACL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41059577f26so7805445e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Feb 2024 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707478538; x=1708083338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtlqHllwjFZl2786B/ZnNk68ctdlZdYfKUj7z5b/g7E=;
        b=O2/m8ACLZjsiCqXHqwd9OxnrCs/qvpKmyvoqG0JEhf7snpEuD32btgFoEyEXZ52Pzj
         PbPZSN/W7MDTVH1nlpGM3c6MhAgkiYYFPPwb059a/oiycpVe7LcxZ/9eIJVCjRwhUtg6
         3pi/klOtqavoL5CJW2XovHlP+KgvBtT19Dyu+/4V+pOlTImwP+utqU+ikPkntDnAqlGz
         i90KNJPieeWOtsH7ZJGXPbRrKPH+GN8FOJin5ggY/7imewC0WyEJi5mDRQ+Ja5VkSBRg
         wPa4n6qu8gTYn6FxNjlMRhu2lmeqp+wuBD7zI3HnqhuMSG9IEbsDHbcR/Llw7m2K1v8v
         Avjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478538; x=1708083338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtlqHllwjFZl2786B/ZnNk68ctdlZdYfKUj7z5b/g7E=;
        b=Aabv4EBEphEJn8/O/3ZKdWhELvoiqKwTa4Xq9vj12j/NUMCeIQt+TXbjyHQKLdH6Kr
         5cRq6wIXGHJi7bL6CxBuquOFK/VEWfg0snGu5U0vY+35oXYkg3RoScl1hfO1UDkxC5ZY
         zXenoOQVX5dQbrduJz6rLtjsu4aHO5KuIEx4uoEHljm3F9tnTuFViCjJtmlg69BgrfHk
         pg9YNNLgzCZvLmDVJiEcz+XA281pbJzt2u6mKsRsAAl0pmfqlnizt5DO6GTev4U4NXyY
         Kv/EPWeiXHDMsrbyhDPcInHomJ4Z34KsCMvynrdSOJZDIijy2Fbov4736qmAeqGlXLwP
         VP0w==
X-Gm-Message-State: AOJu0YzAHG2IsFu8Z64eZCd8okQ0oPL/hicriUy1SjTVKn3gSj/TcGZI
	MVMI9DiNUmPnc80vJzZumJWinmr/+QtFv5ZJbvqeZISB5Lxf+GyD
X-Google-Smtp-Source: AGHT+IHA4KQZAMJuYwS55zu/hXNFYZN3e63pc3he17mm07yp14L6PPs7xrz3EhPSfP9uVJBH4AFn2Q==
X-Received: by 2002:a05:600c:468e:b0:410:1d09:701f with SMTP id p14-20020a05600c468e00b004101d09701fmr856436wmo.14.1707478538264;
        Fri, 09 Feb 2024 03:35:38 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b00410723b14e4sm346251wma.19.2024.02.09.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:35:37 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: ath11k: Remove scan_flags union from struct scan_req_params
Date: Fri,  9 Feb 2024 12:35:36 +0100
Message-ID: <20240209113536.266822-3-nico.escande@gmail.com>
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

Now that we do not use scan_flags directly with WMI_SCAN_XXX macros anymore but
only the bitfield scan_f_xxx, lets remove the scan_flags & the underlying union.

This will prevent further problems as some entries in the scan_f_xxx bitfield
don't match their corresponding WMI_SCAN_XXX flags as seen in [1]

[1] https://lore.kernel.org/all/20231127180559.1696041-1-nico.escande@gmail.com/

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 55 ++++++++++++---------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 6dcd14700570..bc7adf7f13fb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3394,36 +3394,31 @@ struct scan_req_params {
 	u32 idle_time;
 	u32 max_scan_time;
 	u32 probe_delay;
-	union {
-		struct {
-			u32 scan_f_passive:1,
-			    scan_f_bcast_probe:1,
-			    scan_f_cck_rates:1,
-			    scan_f_ofdm_rates:1,
-			    scan_f_chan_stat_evnt:1,
-			    scan_f_filter_prb_req:1,
-			    scan_f_bypass_dfs_chn:1,
-			    scan_f_continue_on_err:1,
-			    scan_f_offchan_mgmt_tx:1,
-			    scan_f_offchan_data_tx:1,
-			    scan_f_promisc_mode:1,
-			    scan_f_capture_phy_err:1,
-			    scan_f_strict_passive_pch:1,
-			    scan_f_half_rate:1,
-			    scan_f_quarter_rate:1,
-			    scan_f_force_active_dfs_chn:1,
-			    scan_f_add_tpc_ie_in_probe:1,
-			    scan_f_add_ds_ie_in_probe:1,
-			    scan_f_add_spoofed_mac_in_probe:1,
-			    scan_f_add_rand_seq_in_probe:1,
-			    scan_f_en_ie_whitelist_in_probe:1,
-			    scan_f_forced:1,
-			    scan_f_2ghz:1,
-			    scan_f_5ghz:1,
-			    scan_f_80mhz:1;
-		};
-		u32 scan_flags;
-	};
+	u32 scan_f_passive:1,
+	    scan_f_bcast_probe:1,
+	    scan_f_cck_rates:1,
+	    scan_f_ofdm_rates:1,
+	    scan_f_chan_stat_evnt:1,
+	    scan_f_filter_prb_req:1,
+	    scan_f_bypass_dfs_chn:1,
+	    scan_f_continue_on_err:1,
+	    scan_f_offchan_mgmt_tx:1,
+	    scan_f_offchan_data_tx:1,
+	    scan_f_promisc_mode:1,
+	    scan_f_capture_phy_err:1,
+	    scan_f_strict_passive_pch:1,
+	    scan_f_half_rate:1,
+	    scan_f_quarter_rate:1,
+	    scan_f_force_active_dfs_chn:1,
+	    scan_f_add_tpc_ie_in_probe:1,
+	    scan_f_add_ds_ie_in_probe:1,
+	    scan_f_add_spoofed_mac_in_probe:1,
+	    scan_f_add_rand_seq_in_probe:1,
+	    scan_f_en_ie_whitelist_in_probe:1,
+	    scan_f_forced:1,
+	    scan_f_2ghz:1,
+	    scan_f_5ghz:1,
+	    scan_f_80mhz:1;
 	enum scan_dwelltime_adaptive_mode adaptive_dwell_time_mode;
 	u32 burst_duration;
 	u32 num_chan;
-- 
2.43.0


