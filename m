Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180C263E64
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIJHSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIJG4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537AC061385
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:55:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so4475401wmh.4
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=f7I7/sOE5MX2MwYG0P7i9T0mXlgEc/Xg/VnzodtaTudMO88woJ1hS+eKDB7SiFV+vH
         TJKdZ0nKQdU1VSMvuH4XRX5knInP266MCc9oE6QVW9gxLQVPipXHQIH0bSkFz3Tu4rWX
         aoSPEOSa5W5RxBACYetaAr29wn4cv2jy3eFHeaqqx6nGqHAmvtW8UUn841lHiqv7Mfjq
         vpfncZHtm/KM57VHcU5w1jnbMhIBCKRNh0i8yG5XorXF5b3mUpoz1TpN09FostJpBILe
         cABq3qJleabsAl1uYBqTq58PkKy5sb6NOfqbfWjbrZf3FUmqGyCb9Q5uJzq1s1gqj1pI
         mr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=jielpzKeTD3nDONlNCE9Fwu6aaFBY3hDl00jH/BIBj1c6tL03CBnBuG4innDcTodJ2
         WyblCFpyCr28vvmyfnv1oEXuN3gQOgWRhmPgp4mTBwL/0xEBCDwIspil0wReGrxgBFTq
         bi7ppqxn73U6uA2XCruzCcITCqYRYnSS5xGzlkz3WEXb/2OcdIK2bm01SwLSTFgMgGjp
         2XbVCCOkHHE9k1R2lvPJcoNUwcpcB+rZ/dfh5u1uJ2G9IeQ+4DXrgdhM0WryGGlnt6el
         ypoFv8LooYJk9oopgiv3tZRFM8hx+YJq0yXt+DKnizY/IN/5DdYUmdzYbB13aX+bRZ0N
         fVmA==
X-Gm-Message-State: AOAM531pWWcYQHVDguSBcUyD8C7YFl1tuZ0rvrJ/gyl7Y0T5Zauj+yaF
        FWjkJVPFjOUmnqc0SYvmaoVJIA==
X-Google-Smtp-Source: ABdhPJx8tJ70LHF6HpOyRTSAL+A8LVJtbLNEjzH/eMpBtN3oalvlMo2E8ReiliY1BaBveE11V2DF9Q==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr7270091wmm.38.1599720904847;
        Wed, 09 Sep 2020 23:55:04 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 10/29] iwlwifi: mvm: utils: Fix some doc-rot
Date:   Thu, 10 Sep 2020 07:54:12 +0100
Message-Id: <20200910065431.657636-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix misnamed, and missing descriptions likely due to doc-rot.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Function parameter or member 'lq' not described in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Excess function parameter 'sync' description in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'vif' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'smps_request' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Excess function parameter 'smps_requests' description in 'iwl_mvm_update_smps'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index be57b83918506..71eda04946023 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -658,7 +658,8 @@ int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
 
 /**
  * iwl_mvm_send_lq_cmd() - Send link quality command
- * @sync: This command can be sent synchronously.
+ * @mvm: Driver data.
+ * @lq: Link quality command to send.
  *
  * The link quality command is sent as the last step of station creation.
  * This is the special case in which init is set and we call a callback in
@@ -683,8 +684,10 @@ int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
 
 /**
  * iwl_mvm_update_smps - Get a request to change the SMPS mode
+ * @mvm: Driver data.
+ * @vif: Pointer to the ieee80211_vif structure
  * @req_type: The part of the driver who call for a change.
- * @smps_requests: The request to change the SMPS mode.
+ * @smps_request: The request to change the SMPS mode.
  *
  * Get a requst to change the SMPS mode,
  * and change it according to all other requests in the driver.
-- 
2.25.1

