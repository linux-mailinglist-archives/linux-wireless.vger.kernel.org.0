Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D6744CB7E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 22:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhKJWAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 17:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhKJWAj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 17:00:39 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56787C061766
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 13:57:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h11so8070319ljk.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Z72NWCiAPtJ6rYr8/oM4tLeal/V8QeKwSl0mXUe0lI=;
        b=8EBxBO2oFs6YS+tyNEiDUJ5+kQo9zDnUq9MxKDH+xArh70NZOBxH2C9m4mJILqEdiM
         RPr2bEqFTahIwSi31BWW0oc+ireArKdVVnvVwwxDoVv8ShN0CTAqj/Ikz5nkTsEOQc0I
         o9XC1ibbHhpoMt+CxgiD8ji2spSWnFps29fHROSrhr7Uqj58EhbaiByCPx220y8kDQxp
         UWDwMw5/MbVVYzh6b3wMlXOIVwsCvB/QFduJuGNyk7A+/SzZy6Uq/MhWMQkFbZgv45mo
         vA3Sva0iHLlxark/jzTcoFo/8TjtJPr9Aq4Pi8+lFCtJq58Ua+YTRVW/2ck8F8HHKaiO
         gZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Z72NWCiAPtJ6rYr8/oM4tLeal/V8QeKwSl0mXUe0lI=;
        b=eWTxzPVRAE6o2Lo0YKqY/8DGwcnG8sw2izwtehPKRc9K2YLxvOSibmz2g9F462ZfdQ
         cRppDxgBUwQzn3SWRA34PlyoWZdpKFeGGSczX6djp5LmccjXbCN6N3LoGvmmO+vocEVE
         UvHLeQ/rRnVzit0ViFpZ8yiqo1lSBnH1WfBy1tIhCx3dPjapgGDy2AiDGjoS4/gmrYHs
         m92GikP3SWOsl67gc0g/5482Ngmt8mIX3Q+BUKwTfqm6EDEuRAqJ+4FjjoJx1iYrUBEb
         MXC6Phg5G+Jnja/QZWMqHiwP4ZwpwfEU66CPm6VrnPaOjtq0SHqQpy+mHBmmb3MCwvDj
         YeLQ==
X-Gm-Message-State: AOAM531Yp2aEaRepDc76OQK0kMQE85ROyEI7O9javtO3fof6UxX39HcX
        /thRwBUBxE6SoyZMfaHSip4W
X-Google-Smtp-Source: ABdhPJwg5M64oHCxWZNpkjmGWW99MVFpcx7WXugm00AAA8BBMBiRl3myBOMp6XTMDvIsOJUjtV6SXg==
X-Received: by 2002:a2e:9e93:: with SMTP id f19mr2230134ljk.311.1636581469644;
        Wed, 10 Nov 2021 13:57:49 -0800 (PST)
Received: from localhost.localdomain (public-gprs376873.centertel.pl. [37.47.103.106])
        by smtp.gmail.com with ESMTPSA id w17sm87742ljh.15.2021.11.10.13.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 13:57:49 -0800 (PST)
From:   Lukasz Bartosik <lb@semihalf.com>
X-Google-Original-From: Lukasz Bartosik <lukasz.bartosik@semihalf.com>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>, upstream@semihalf.com
Subject: [PATCH v1] iwlwifi: fix warnings produced by kernel debug options
Date:   Wed, 10 Nov 2021 22:57:44 +0100
Message-Id: <20211110215744.5487-1-lukasz.bartosik@semihalf.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Łukasz Bartosik <lb@semihalf.com>

Fix warnings produced by:
- lockdep_assert_wiphy() in function reg_process_self_managed_hint(),
- wiphy_dereference() in function iwl_mvm_init_fw_regd().
Both function are expected to be called in critical section.

The warnings were discovered when running v5.15 kernel
with debug options enabled:

1)
Hardware name: Google Delbin/Delbin
RIP: 0010:reg_process_self_managed_hint+0x254/0x347 [cfg80211]
...
Call Trace:
regulatory_set_wiphy_regd_sync+0x3d/0xb0
iwl_mvm_init_mcc+0x49d/0x5a2
iwl_op_mode_mvm_start+0x1b58/0x2507
? iwl_mvm_reprobe_wk+0x94/0x94
_iwl_op_mode_start+0x146/0x1a3
iwl_opmode_register+0xda/0x13d
init_module+0x28/0x1000

2)
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:263 suspicious rcu_dereference_protected() usage!
...
Hardware name: Google Delbin/Delbin, BIOS Google_Delbin
Call Trace:
dump_stack_lvl+0xb1/0xe6
iwl_mvm_init_fw_regd+0x2e7/0x379
iwl_mvm_init_mcc+0x2c6/0x5a2
iwl_op_mode_mvm_start+0x1b58/0x2507
? iwl_mvm_reprobe_wk+0x94/0x94
_iwl_op_mode_start+0x146/0x1a3
iwl_opmode_register+0xda/0x13d
init_module+0x28/0x100

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 77ea2d0a3091..61dd75f9304d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -687,6 +687,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 	int ret;
 
 	rtnl_lock();
+	wiphy_lock(mvm->hw->wiphy);
 	mutex_lock(&mvm->mutex);
 
 	ret = iwl_run_init_mvm_ucode(mvm);
@@ -702,6 +703,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 		iwl_mvm_stop_device(mvm);
 
 	mutex_unlock(&mvm->mutex);
+	wiphy_unlock(mvm->hw->wiphy);
 	rtnl_unlock();
 
 	if (ret < 0)
-- 
2.34.0.rc0.344.g81b53c2807-goog

