Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C724CF2F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgHUHWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgHUHRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBAC061387
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:16:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so837690wmi.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEuMBeNYRk5zJO3oK7+mBcMmVKwq5vw1RsgSJVTkf20=;
        b=DW/Phlyh+obGNUw4ueWjW09DI2bFN0XqZQ17caLwo4M+AdomYyyhlVByH8rGyHrLtn
         co9NN9ONnNCGbNVBnL8SdFh1crPr6lAC6TaxCrc04aq+M/Ly13/A6wpK2IXQpv13T9/6
         QoG+RKq3yqtKw/NsyM8hrWsveQQ18tLTi/R7ei8FB3Cai0eVKOEIFZWmtGUE9+6Ac5uI
         uZa+A7mcx2O61LOkpNf4Q/a1F6FlY1cl7tiGY3Np2UKv9gJBbLHozqeCHj9+NLNcFGwa
         wfrCxzM7nAh0g2jkWr09e3TnMGs4G3hkyc82fts7FG20H/jJ3Km/pYreoWksVN44EpQu
         spTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEuMBeNYRk5zJO3oK7+mBcMmVKwq5vw1RsgSJVTkf20=;
        b=EP5K+dZ4yg0xi4qq/qljKHo1zChgf7dnTlAXtWcfofwl6TLJiIPcaUMdFMBeAZG8aN
         Jd9DB81/msSu//yYdHoc7isNnvcvbhNh+SbPoQJ5kYC4xzbE/RUpU1PFtpFf19qDhYmM
         g1H6mt6pa0RxqVQHtpM7HhHnvScXm2OZ6jeynHdS4P4z62CTwSp3ynIXXYTULk9rrCZS
         C7ed3PZVX7hfWwnH/g34be30/046CqopM/spdNBwuLJdlaesWe1vmk8jaJ27UKo3wt6d
         OJX7r6QOKdKRHzZGBuji9w8t1kmVJZU04t+8Sf70tJLnw+eUX58pfjh4ZaoWcnC11X9r
         qlMQ==
X-Gm-Message-State: AOAM530ysIf3SUxh/bYI4iyI+hHu86LlpixBUF16UQtsXYO054PxUMAb
        ZkutM+Je2U9Bx3JAspO767oL9g==
X-Google-Smtp-Source: ABdhPJxKn/3N6VpBa20RtxaeEKSSfLRS9ZrkKA5GIeXUlsBd3G0Q3GNDUuSyv5SNp1nk0oR0j+QcuA==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr1650662wmc.103.1597994217415;
        Fri, 21 Aug 2020 00:16:57 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:16:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 07/32] wireless: intel: iwlwifi: dvm: rx: Demote a couple of nonconformant kernel-doc headers
Date:   Fri, 21 Aug 2020 08:16:19 +0100
Message-Id: <20200821071644.109970-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/rx.c:145: warning: Function parameter or member 'priv' not described in 'iwlagn_good_plcp_health'
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c:145: warning: Function parameter or member 'cur_ofdm' not described in 'iwlagn_good_plcp_health'
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c:145: warning: Function parameter or member 'cur_ofdm_ht' not described in 'iwlagn_good_plcp_health'
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c:145: warning: Function parameter or member 'msecs' not described in 'iwlagn_good_plcp_health'
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c:939: warning: Function parameter or member 'priv' not described in 'iwl_setup_rx_handlers'

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
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 673d60784bfad..9d55ece050200 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -132,7 +132,7 @@ static void iwlagn_rx_beacon_notif(struct iwl_priv *priv,
 	priv->ibss_manager = le32_to_cpu(beacon->ibss_mgr_status);
 }
 
-/**
+/*
  * iwl_good_plcp_health - checks for plcp error.
  *
  * When the plcp error is exceeding the thresholds, reset the radio
@@ -929,7 +929,7 @@ static void iwlagn_rx_noa_notification(struct iwl_priv *priv,
 		kfree_rcu(old_data, rcu_head);
 }
 
-/**
+/*
  * iwl_setup_rx_handlers - Initialize Rx handler callbacks
  *
  * Setup the RX handlers for each of the reply types sent from the uCode
-- 
2.25.1

