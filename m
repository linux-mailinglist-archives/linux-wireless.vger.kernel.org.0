Return-Path: <linux-wireless+bounces-3417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BF8509C0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 15:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CCCB215AB
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Feb 2024 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E05B5D1;
	Sun, 11 Feb 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/F0xsWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D85B202
	for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663355; cv=none; b=SmTtL96Grg7PR2jKuwihXPtgygd7PNYH1oLRTs6HQ/20FzV5oANhzzPuWxRBbXAGTZGdzygFwedmCHIzfzrcOUSc4XQXlDxCJkvrckEVN8/ACaW+8g9wnpxDJoGok9FN1MEOH7FgaKHN0i7KTjbLI7IqSr1RLkkH9SkNqXrwmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663355; c=relaxed/simple;
	bh=6O1Y0kotZOZb3Knng6E6vF2YA6LpnjUkKsjE11qppPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJdnp2Vj/nnDUXAg2O2TsP7K7T/wjkf/aolSser4QSQVFADytO12hAqHGe8SrN/Btl8oR24mqsLSnO+n89Wl4kwDS/DjdFVBWXnJXuNwuqShtFw2j7I9YJOJfd0htb+uj+y39teHEc9Ms0LcN1EZKchXc7Z1MLYGcbsQbWQH6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/F0xsWT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b815b182fso89383f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Feb 2024 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707663351; x=1708268151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAn2AS+0LO75NkItpaZHGDtD144iwOC08hKoiH7RRq0=;
        b=V/F0xsWTClJgUPSUQbzZvP7sClB9iAdkGajepg4t8INUvSrI/4nXVTQ18B9ixRHOHh
         OViraujV5oteGXAU9q5s99O9wmfguS/FIlBi/YMjcDDEuhrsDH/Lc4kBhZYKc3RItzdU
         Sk3RzwPABdxgXTZS/II6hTBH0O/4tp6sR0boSI3oeQo0pvbCH0F0nFg0u0UdQV6nv3CS
         DPVof4p268u63tbzd2hmf9IAIS7cs4od8nBi7yvj2yix1nc9kVvThlaVjl7tNd6vlsz+
         7MctWrzyI/mtAxz6DaPOW/hYhPKW+o5r3GsfdHFWRmw4AWUme8Wn2OV2Q36vpSW9Pztz
         bwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707663351; x=1708268151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAn2AS+0LO75NkItpaZHGDtD144iwOC08hKoiH7RRq0=;
        b=hl/o5EOEPuKusacxCuHjVAEYSr2jFHxMOwfnKfw3MqzFbsVqIexMSVVLy73Rslr9x1
         cRJ/wF1wDgC4TwKjx2b7d2cvU/4+snArtiw32bW8f0F0tFF19a083QHhbvBKTdauZb7v
         tExUk2Y+Jgk0MEYV1M6r6Ayo1BVeoBc2ToXR2rXuzTYjM7L3Oor1WAFA4BcOdIULIyTS
         F8DB6QrcpWEXrAABI+AV3YGvZ4nExYf42V/Wm9193zg94vllL8SaxayFh3y54smzeEsC
         EmH48HXDCpBxYN0i+bcCJgvm2hYZ05Jm9JLb3raJrdnlhoJ8GDpRWT+P4MbYzmlr8AKY
         B7rw==
X-Gm-Message-State: AOJu0YxI+UVVK3G/hH/3bBb8nX7VrfkTC18lYwamQPSi8YCtw6PBGn2q
	MXOCFInywggWlah9mGUcyx4ziW1GufyVyhldx0TQMDfFzCVMeZ8M9iLJ0vlj
X-Google-Smtp-Source: AGHT+IHFNpT7vRUPtRfvLinZI28Y8eMsTlQazNuTi7Et68dVRe4OyBj3BrFYUNN4gQMQ5P+bWcTa8g==
X-Received: by 2002:a5d:628e:0:b0:33b:28:1084 with SMTP id k14-20020a5d628e000000b0033b00281084mr3363122wru.33.1707663351353;
        Sun, 11 Feb 2024 06:55:51 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id cf2-20020a5d5c82000000b0033b7263702csm3779424wrb.29.2024.02.11.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 06:55:50 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath12k: Do not use scan_flags from struct ath12k_wmi_scan_req_arg
Date: Sun, 11 Feb 2024 15:55:47 +0100
Message-ID: <20240211145548.1939610-2-nico.escande@gmail.com>
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

As discussed in [1] to fix the mismatch between the WMI_SCAN_XXX macros &
their corresponding scan_f_xxx bitfield equivalent, lets stop using the
scan_flags in the union altogether.

[1] https://lore.kernel.org/all/4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-02907.1-QCAHKSWPL_SILICONZ-10

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a737a09a0b9c..7d3f5321a36d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3201,7 +3201,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		for (i = 0; i < arg.num_ssids; i++)
 			arg.ssid[i] = req->ssids[i];
 	} else {
-		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+		arg.scan_f_passive = 1;
 	}
 
 	if (req->n_channels) {
@@ -7555,7 +7555,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	arg.dwell_time_active = scan_time_msec;
 	arg.dwell_time_passive = scan_time_msec;
 	arg.max_scan_time = scan_time_msec;
-	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+	arg.scan_f_passive = 1;
 	arg.burst_duration = duration;
 
 	ret = ath12k_start_scan(ar, &arg);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84d7d6584fba..2c2a010d88df 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2194,7 +2194,7 @@ void ath12k_wmi_start_scan_init(struct ath12k *ar,
 				  WMI_SCAN_EVENT_BSS_CHANNEL |
 				  WMI_SCAN_EVENT_FOREIGN_CHAN |
 				  WMI_SCAN_EVENT_DEQUEUED;
-	arg->scan_flags |= WMI_SCAN_CHAN_STAT_EVENT;
+	arg->scan_f_chan_stat_evnt = 1;
 	arg->num_bssid = 1;
 
 	/* fill bssid_list[0] with 0xff, otherwise bssid and RA will be
-- 
2.43.0


