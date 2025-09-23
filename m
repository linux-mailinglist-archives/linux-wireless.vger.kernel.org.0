Return-Path: <linux-wireless+bounces-27614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E837AB959CA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC07AA2C5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC4189;
	Tue, 23 Sep 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9wGKFr7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF1315D3A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626422; cv=none; b=R7SZOxXo8raOWnqhbsOJS6t3P+ebB/zh28YoZo3+lUlr0HyEFVpTYAiIfmYfk8+k/BL1FVkC4Ugau8RnsohWfFaarq2QjM3iPrOW/OH6roVP+GerNS2SgJ7XC9DvdPs3x5OLCEQLSYkusafrCmNvPh8BYDYi4gVXll3FV6fGDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626422; c=relaxed/simple;
	bh=B3fRnPBrL6bndjkV80Lqpltt+HotD1WV25scPuVekdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ACgJkJbWGqYjiUbqdzwE5WcQTvZNb9GbJJWybMOSuAdEfMZMV1Nun9LJpAOtpSaEWmRdREl7JFAS4UimAOeGXdTThxrIBZ2/DxJxMrIPhyf0va10lBzPWYmYrToM/4HW+Wk8ULOd0e+gJn/eVmbE96kwkpAdv2Dl06pP7tye8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i9wGKFr7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so5132694f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626420; x=1759231220; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE8TJpb+bgJUe79vS/3A1j4fTVnXxc+D4cm6eCdCSiM=;
        b=i9wGKFr73N2dpnTDqR9wl7Mt41sJLnKWB/19jvnsgxsw0sbDnRHDjb9jZl8xTNBqzL
         x3TIaMnHjMFQQQFTAyc7M/sHlm46TalPo3ChDHoDyqlgeBXSHRM+QOgnjsuM66Mi4CWy
         FQ2n36iX7uVW2bULH7g2idNd5B7WNUoC1qn6dqmc/SzdtltQ91bO8OvenQqWTcy6bufn
         UX3yLGMlmsWHTK4McIGcmRrNUtGpJfj8AVHbKFSmDkILr9Ur9eE9aB/QiaxpfZixxBGF
         si7jWMjtCkB41RA96YLkY9KRzv8IAIzjYupmAgc9DADqGItAIpTUlNlJ1/1cv3ii41wp
         FAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626420; x=1759231220;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE8TJpb+bgJUe79vS/3A1j4fTVnXxc+D4cm6eCdCSiM=;
        b=ehmGn0hlDX0tjw9R1T+uQLeTtGddcNkkaW+sUrrC+0zBy7jlun/1ZB2QYBH1RLTbJI
         0rysOBaj6i9hKXcM2r80QWw1PB9WOh1qLJS4XCDzFQsxUgDAmAab9mqh6q6fh8KZrfyE
         AFHl+nDd4eHvxNWtjWgPT/OrPLjeVkhYwKSFdvIK5KCu4GR6X8DV5SB0Fdl+bxRGYZ81
         0c5i/UyyxqQlpIxRB5BH1Py6WYCAnAidiPGtG8n1maN+Z+uAhHVR1fh1FY/Eue4H1Qf6
         MFxlfYOW5t4rEVas01YGr7HB2qqpxUq94fwc1cSQ7BUINiewkSrM+BwS99xS40HAWIYF
         0CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe3UpZPr2NwTNAwDZaSN3APgAmaq41DGoc+S3PaiaZ+xFfGcpB5uak2CUqJ2UbHyUFJWMTlwiEdyxtX08nPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+z+qQcIBIguMbdNCo5xcMxTVcv5E8vwLIOdVDrqVpszdl/7D
	mmI+NgIskF8WW0gscaYr2G/riuq0Ur9mApt6oHhrL2Mjx/0gt8HNHadI+sFdYAO8VtU=
X-Gm-Gg: ASbGncs3r6QFepm53NooZUibpCg/XogdP7wHWeEHIBvzihi8RUkrhxvVZrb3SQbNFCW
	ye1A362tKVwa/ovMjAKDKDm3vgtv1LgMZXAWj/CwULBQ2zEKXRwdkG/Px/uafAXndggk0xK2UDD
	YioixignOIeOavGlsN+9B6CvxfWI0oHYHkKzkMGIyHbRN8juFAsJturE4aXUgGQnsw7pFJjAs/g
	GHMh29GUpELRi7YKN9HiH4K302kMUptOoMQME3sl6mXy2jJZpkiCY69Nz3Xet4cmzEh3kZ8CPzL
	g3VLD6MuxfLw3xr5WJT2fY8p7PMN58Pz29pxfn6FJPQzN7FlH1Ggu+dBgAOe7sCtM42XtBgbe/z
	q99DeP2rvU2dAFK8MxcnpkSSURLoS
X-Google-Smtp-Source: AGHT+IH5ERjqItScX3GlaqMEPRqH6OH857XNBhEBSVVCeFpYjz1uRmIbad/KOH3nGEJlbG/jtig3mw==
X-Received: by 2002:a05:6000:186d:b0:3e7:46bf:f8bd with SMTP id ffacd0b85a97d-405c5ccd210mr1652472f8f.23.1758626419495;
        Tue, 23 Sep 2025 04:20:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f0d8a2bfsm249409455e9.2.2025.09.23.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:20:19 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:20:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: fix potential use after free in
 iwl_mld_remove_link()
Message-ID: <aNKCcKlbSkkS4_gO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code frees "link" by calling kfree_rcu(link, rcu_head) and then it
dereferences "link" to get the "link->fw_id".  Save the "link->fw_id"
first to avoid a potential use after free.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 738f80fe0c50..60d814bf5779 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -501,6 +501,7 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
+	u8 fw_id = link->fw_id;
 
 	if (WARN_ON(!link || link->active))
 		return;
@@ -513,10 +514,10 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 
 	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 
-	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
+	if (WARN_ON(fw_id >= mld->fw->ucode_capa.num_links))
 		return;
 
-	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
 }
 
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
-- 
2.51.0


