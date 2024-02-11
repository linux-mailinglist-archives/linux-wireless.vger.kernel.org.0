Return-Path: <linux-wireless+bounces-3418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246048509C1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0330B214B4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9AE5B66C;
	Sun, 11 Feb 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEX0AuyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7759174
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663356; cv=none; b=Y6W7ZyidLxB7fDGM8drksqBUVrbTkqlKppzkv7v0wVJOK7541hZO3LfMYOCSn2ScnfHNz/3GxfyMulBqSx8kUWT2pvouKQ6/1PmmCrY5oR2WWC6qIOyCeuukUA7ImcjZWplpqnlTNSSgoWJTqmmUDJTA+tt1zpayZ5BrfY+EZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663356; c=relaxed/simple;
	bh=ONLw4+bljx7Rp4qtyaqQ7r5nbVt/T2OkK2yshni2upA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORp/uMSuflZyAx+PLKmos533v39sBygOCy7OmlOopAi/QQ2SYb5MQUuAgboyYtIL6irYLkKEj+Nmc0bVmfWizPO2vhcZNpdkii/gsZmxgjCaQBBpyMvIXZRybUZbsyNV+n3UE0+lgfsWQxmy1GjCnQCGNtYmsNCFbrkURdbnuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEX0AuyK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41095324ba3so6310285e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707663352; x=1708268152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlKpg9+BHEDjOOwYDTsy/ZpeasKv7giejYp8qUONndg=;
        b=IEX0AuyKb4wlJbR70p/mkgcBtVEKXl5u203ghbP78XUiSunYF8F7YBAvhHqnB+tlNb
         17hTbISVUmlFXS1B137B7vMAYezRDKGjwZ6lNayJ8ak9Zh/ertvfl3JeXetwQT7OZemB
         8iC5L9x3e/DDwR5DKHEmTnKNVvaGjjq7xJyb1QVPn9npSTO1AJqHJsLaVhNHT7yUwdYD
         SPi8wIRl30+WnCYFuW8F++4uNdRJgDBp21NBKFqoECUGhVGO1Paw0Pzk4wdQzmLdS414
         Pmw1Jzk43vKExd2za+6iT3qfzPMeNRyJI32ayDWBqsKdL4d+2C/++og4LwQyigLopeNU
         4tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707663352; x=1708268152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlKpg9+BHEDjOOwYDTsy/ZpeasKv7giejYp8qUONndg=;
        b=NyndjR4lkztuSV2FNFL6I8ORQANb6PVgVwN7NQVhGBehHyL4TF8zBF/tN/4UrGnKOt
         f+EL3mlyTpojpdFTMtMNGqj3EahwlF4l1XEyUXP9vCSFShp9ZSmQ5Klddowqa9czORuQ
         hcJYWBxE+SJT0FbQfj24H1QiVQjSuhtCmhaLLPy5fZgaEDhfEzjLeR7AZRLg53ufX3DZ
         f2I/lm9jbcj9L4dWpKdnWLGqdni0h86KsBnv2w9zEf/uljXAYd2mcMA05fVrHvpNPbSK
         AiN4HZR91OlCjoAZQoRw+ZSLrcSxQ/HI7xV4SMCpUtRu08AoJDykZ1ueg2xUahHNEvrz
         QHuw==
X-Gm-Message-State: AOJu0YzafIhfOZPxNMSWkd31ZJyLj9G+mnHshOp8EKdiW4MdcB6hIdIk
	cYriaRu1f/zn6V+I8OF2yLLWJY6RxYij3DikIfxqbhGsm8eKIgr3cXZr2DmY
X-Google-Smtp-Source: AGHT+IHIIkEdzUNXVIM1fcs1I98irQSeAdaD5rNitgawv52fHSKAfgMfY0ML8AAstbg+xedot6W1kw==
X-Received: by 2002:a5d:42d1:0:b0:33b:1562:cf4c with SMTP id t17-20020a5d42d1000000b0033b1562cf4cmr3360829wrr.14.1707663352256;
        Sun, 11 Feb 2024 06:55:52 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id cf2-20020a5d5c82000000b0033b7263702csm3779424wrb.29.2024.02.11.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 06:55:51 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath12k: Remove unused scan_flags from struct ath12k_wmi_scan_req_arg
Date: Sun, 11 Feb 2024 15:55:48 +0100
Message-ID: <20240211145548.1939610-3-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211145548.1939610-1-nico.escande@gmail.com>
References: <20240211145548.1939610-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we did for ath11k lets remove the unused scan_flags from struct
ath12k_wmi_scan_req_arg. This will prevent us from using out of sync values
between WMI_SCAN_XXX & scan_f_xxx bitfield. 
While at it remove the underlying wrapping struct/union construct as it serves
no purpose anymore.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 55 ++++++++++++---------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 4bd1d0f270a1..892f21f95ee5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3311,36 +3311,31 @@ struct ath12k_wmi_scan_req_arg {
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


