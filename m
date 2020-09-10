Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92A263E71
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIJHUu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgIJGzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:55:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB7C061796
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:54:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so5396431wrp.8
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOjbJX83gJDY8f1/vIcwdpJ4Kow88m/y6XKP96xRsEA=;
        b=oX8WKLXODC05S0G4JO+FCpWGIOn5GJf3bRMOm9VBdYdS2VaC0yQyUAT6SCAD/4NSBs
         cOuQHU9kMdF7dNZDy6xtChcMJ9WW7yR1ZCeq03cPCiHQkFo7F/EkpPDSrVfp/tTWPw5H
         boVVYgEpTx2yjZThhqHS0dvhD8XXYMzCIAW1hlvIZIlW5iB6NPoiyoduCsVj7MBqsRvi
         SDmEhUoyRkCjPT0XHjlBmamoPVBdudNWyJd+3V6XjYEVUxwaR1UXhJ3itE7SDh5UXoGI
         +jB7xNArviDybwhMjLp5YmYsk4Y8T5eQN1yWm/TwmUUNjUuM/PtBZaTGtInWO3YcIOhN
         r0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOjbJX83gJDY8f1/vIcwdpJ4Kow88m/y6XKP96xRsEA=;
        b=srCwhHpS7/xQaHQOPv6A7FY6B5sIIW9b93hDNr7etX1HakUVoF4TVigKLpEO1r08/p
         c+QmFkbJ8QesZd6mpF7D2mX25jtRfTxmXDl0U/NqeUs8dJbu44p8E5Zyakp19+PWhz1R
         wWYr2eN4pG2M9TAGzTmzzd7bbfUCf4OFeVt4z6bbWi4bo6JxB1GpEIGWXmDE8l27+J+v
         SsjE2Ya8e9wHOfEA/pEBGOaGT8XzlOsCC5sAimzQkeBDC98bMiWr/CytTeFigAtvodiR
         etzx3/XIGMEmN2VgAXdU+hNYt5YE5mvOU6BErBjGjoe6TeK52noT9Y4ASd6WugbPow/O
         d3JA==
X-Gm-Message-State: AOAM530SET1afYLfg/XqUqHL9XMXRbAsyAGlnLIEtUj6be30socYjOnA
        36QhbU/lU54z6ZO+XPPJyFtZOQ==
X-Google-Smtp-Source: ABdhPJwLmF4TuuY74OJxlrHdHWkPWbKZXPuKu4IXQMqWUN5VSy3PlE6l8uKF2KcRIDJBLXhwz785CA==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr7768207wrr.96.1599720895545;
        Wed, 09 Sep 2020 23:54:55 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:54:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 02/29] iwlwifi: rs: Demote non-compliant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:04 +0100
Message-Id: <20200910065431.657636-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

None of these headers attempt to document any function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:165: warning: cannot understand function prototype: 'const u16 expected_tpt_legacy[IWL_RATE_COUNT] = '
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:329: warning: Function parameter or member 'priv' not described in 'rs_program_fix_rate'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:329: warning: Function parameter or member 'lq_sta' not described in 'rs_program_fix_rate'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'tbl' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'scale_index' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'attempts' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'successes' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:681: warning: Function parameter or member 'sta' not described in 'rs_use_green'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'lq_sta' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'hdr' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'rate_type' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2628: warning: duplicate section name 'NOTE'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'priv' not described in 'rs_initialize_lq'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'sta' not described in 'rs_initialize_lq'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'lq_sta' not described in 'rs_initialize_lq'

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
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 4fa4eab2d7f38..548540dd0c0f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -151,7 +151,7 @@ static void rs_dbgfs_set_mcs(struct iwl_lq_sta *lq_sta,
 {}
 #endif
 
-/**
+/*
  * The following tables contain the expected throughput metrics for all rates
  *
  *	1, 2, 5.5, 11, 6, 9, 12, 18, 24, 36, 48, 54, 60 MBits
@@ -318,7 +318,7 @@ static u8 rs_tl_add_packet(struct iwl_lq_sta *lq_data,
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-/**
+/*
  * Program the device to use fixed rate for frame transmit
  * This is for debugging/testing only
  * once the device start use fixed rate, we need to reload the module
@@ -440,7 +440,7 @@ static s32 get_expected_tpt(struct iwl_scale_tbl_info *tbl, int rs_index)
 	return 0;
 }
 
-/**
+/*
  * rs_collect_tx_data - Update the success/failure sliding window
  *
  * We keep a sliding window of the last 62 packets transmitted
@@ -673,7 +673,7 @@ static int rs_toggle_antenna(u32 valid_ant, u32 *rate_n_flags,
 	return 1;
 }
 
-/**
+/*
  * Green-field mode is valid if the station supports it and
  * there are no non-GF stations present in the BSS.
  */
@@ -689,7 +689,7 @@ static bool rs_use_green(struct ieee80211_sta *sta)
 	return false;
 }
 
-/**
+/*
  * rs_get_supported_rates - get the available rates
  *
  * if management frame or broadcast frame only return
@@ -2612,7 +2612,7 @@ static void rs_rate_scale_perform(struct iwl_priv *priv,
 	lq_sta->last_txrate_idx = index;
 }
 
-/**
+/*
  * rs_initialize_lq - Initialize a station's hardware rate table
  *
  * The uCode's station table contains a table of fallback rates
-- 
2.25.1

