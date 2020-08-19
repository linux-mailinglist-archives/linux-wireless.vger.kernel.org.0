Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB61249757
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHSH3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgHSHY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB5C061347
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so1129005wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbKBLvVHaH2v5GCYgGjIlYZDy81EB6VKwDmcXvqDNxg=;
        b=OXds1Fu1qKTN30kQh7VA0bF/2WfppMdJpu1WBsaU2U+5BdI5GdG9GRWftpfs28R00j
         LiSm8dsDtg9VqEA+iEIVBJN0CAIP20vnFBIL8CwmytV9VdMPYxW9iGnSFO/gP4bDU1no
         rM1tKqchdPiPs04+yDFvfhzHRalicb7QtGUQ0PhC18KLR1mHszACOgBEyovLQNpwCTtI
         tuGJpL2QzJq0vnOwMC+o5QNuMON//UnmBmVQn3p1wVOIcXrd16Ng4DpnCwTJuQ/Peu38
         V47gDngdpVAMSZOwy7SEMT/zEsU/0TJK2lWrmFMKM25yUI0aa4TpGB0aAu1NPlpo5BQx
         uvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbKBLvVHaH2v5GCYgGjIlYZDy81EB6VKwDmcXvqDNxg=;
        b=uLPXh/14lrWvOHuqZT3VRVuEO6S7+spOD0MaL/CLo6NzpnvSVJG2LQ1CK+ihXCyTMe
         Y2v+Fb5H7L3iwVhuMEpHfsBeqzWE0jQpEJCulzS/S4ZySWRt8zuGFsr+/SKKIcjel9s1
         DHqFTkNukSBeT+dPVu9QUtzfv+AXRehRJFjK4O9NV4K5eIQQ4aF9cwRFipgxct190KaO
         Lv28tKZO3JyZqZYmz3tx51pgncFwPh5m7sTWDFPJufrBpQuEy7wB4Ufu0FQxP4FHjTsq
         8kyTtQ27va8MhTu9Xo3W/lUCGxBeA5DSXvhVLCFcJw4OYD350D8l5auIGca4q6w1fEwL
         A83A==
X-Gm-Message-State: AOAM532gN7ZHmT2RqDEY4zePmFAHqHrl3Dkowh3q9DS2hsq7aEzEgL7b
        yjvXcu0825XU/Wate5McJcE2eQ==
X-Google-Smtp-Source: ABdhPJzktKf0Cr27eGyQgeRCt60ASIOSBcNvQFBXJQddtrhnePaDETm8O/YZgHWNlIrloQVil8hKQg==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr3354073wmo.3.1597821857777;
        Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 10/28] wireless: intel: iwlwifi: dvm: tx: Demote non-compliant kernel-doc headers
Date:   Wed, 19 Aug 2020 08:23:44 +0100
Message-Id: <20200819072402.3085022-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

None of these headers attempt to document any function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/tx.c:811: warning: Function parameter or member 'priv' not described in 'iwlagn_hwrate_to_tx_control'
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c:811: warning: Function parameter or member 'rate_n_flags' not described in 'iwlagn_hwrate_to_tx_control'
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c:811: warning: Function parameter or member 'info' not described in 'iwlagn_hwrate_to_tx_control'
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c:1267: warning: Function parameter or member 'priv' not described in 'iwlagn_rx_reply_compressed_ba'
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c:1267: warning: Function parameter or member 'rxb' not described in 'iwlagn_rx_reply_compressed_ba'

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
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index fd454836adbed..e3962bb523289 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -803,7 +803,7 @@ static void iwlagn_non_agg_tx_status(struct iwl_priv *priv,
 	rcu_read_unlock();
 }
 
-/**
+/*
  * translate ucode response to mac80211 tx status control values
  */
 static void iwlagn_hwrate_to_tx_control(struct iwl_priv *priv, u32 rate_n_flags,
@@ -1256,7 +1256,7 @@ void iwlagn_rx_reply_tx(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 	}
 }
 
-/**
+/*
  * iwlagn_rx_reply_compressed_ba - Handler for REPLY_COMPRESSED_BA
  *
  * Handles block-acknowledge notification from device, which reports success
-- 
2.25.1

