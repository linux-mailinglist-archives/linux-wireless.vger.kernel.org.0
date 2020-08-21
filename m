Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF024CF2D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHUHWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgHUHRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCCC061388
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:16:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so1028635wrw.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=rkVyOQMg2wau38ZPpaZZT3bSVg8gGAc+SWIKguwoF/1Onn1d6uup2i1Zfoit1rJBu/
         cQRngUuSF7pA6T8YpCRwMyLMhUj40DGOWmfCV0GiDz5YfZydx2dN3bancnc4NzdBN28U
         X4x3IJMG3RyEhqR+Sv9mm50FJ9rj4l8mMTEbyZLGqW6bcjpmsaJY2+MRbBtCmrKa5uFc
         g262cSLOIlrsObxFXVae+ZgaaSga7fcgOTLf0lCupEfvsk1WON176RZaw06G4LGST1Y9
         Hj3kHcFyABn/RHTaOevWnsLc406ar5HXKjK7w/hERQaVL8UzV0cUhClVVXoAfEumq9Ti
         j1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=B4ze2AgNbrZwL3pVch9WGrPPNw/QkQjm4ZG/eVvmhkDfCFSqV5a6PEaJhtKc4oyorp
         5mtNBtobwfdeK77LrqFD6aBtSUg2QYPoxS0AVLATa+WSMxBB+owbmtcw28JlUyJAetp+
         cWPQgK+eOstIB8t28Xjx+Rn6zVvPyPsvfs5+Yatum4xnTmMt26esUsQCKHQeUZsf5uD6
         GKOYoB1J/A6qc0axkKrwR4UyACnsXbGwry0BojEJt++ifAvaqqGhQpq4XpTON4x42YXp
         H2ph0GtDermHYMxqxUs8iAkC6fVujRTRoSb/3pwn8Ce2TQsunEb3UiZMJcIbit3kPq5m
         03HQ==
X-Gm-Message-State: AOAM532q4DuGSz15XYsm/EMefw3XMpI7KKi0hbrUlj3nP/nO8cGxxEFJ
        9+YfvXCWTuMDsAobo+J0JRLHrQ==
X-Google-Smtp-Source: ABdhPJySDIkv4P+bkJnVoXjHfbHCrSZ0KvSwLlEC3/Ep5ABPG7oUXyGwPGtuCXmejPq9lczxP1kI6w==
X-Received: by 2002:a5d:564c:: with SMTP id j12mr1489415wrw.357.1597994218559;
        Fri, 21 Aug 2020 00:16:58 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:16:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 08/32] wireless: intel: iwlwifi: mvm: utils: Fix some doc-rot
Date:   Fri, 21 Aug 2020 08:16:20 +0100
Message-Id: <20200821071644.109970-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
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

