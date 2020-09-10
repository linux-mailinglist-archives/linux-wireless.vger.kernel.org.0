Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C835E263E63
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIJHSa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIJG40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A51C0617BF
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:55:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so5396802wrp.8
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEuMBeNYRk5zJO3oK7+mBcMmVKwq5vw1RsgSJVTkf20=;
        b=pBqUmvFqw5Jk9CUhvL0FQ1kaDwlw1xq0VFgwnckNEc6H8p/xNNeZlaRnjyQy5utZEj
         pBEoXNgtdf6FyiXyz9IJWpRU4vjzE0h89J2uGVaGjVWGwghpoKCnk3cF5jdjdgp7GXis
         s3roRqZqPDjXOyeTDjbTEXishmLQIkUftwpzOpZtLezTzgju1B8PGB3eSsfva5qUPiUG
         VBFtkefOEYECENzKnI1yZ0c3HqEIWKAYy7s/nIhY7Npi1WrjdAHtQX9QUWw7PTFZD+1n
         /G1+SyBUmcYDK5RH+KN6Tpz6O5vO/11vso1kkVhJ5B/4GG/DFiRNMc22n7iwyG+cC7df
         U2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEuMBeNYRk5zJO3oK7+mBcMmVKwq5vw1RsgSJVTkf20=;
        b=GI5/CYQ4ZDIvXeyDzDeaffshd6bj8Gl5XZMgN5bWlqeqFCb18ZGZR47FPY0FU2o1IK
         rscleVyFy/FgOYG8JsQnE99zgP7/X9XGaYT94oiIkRGaJY139y8OSILtIFauuJ126m8y
         cJhwbkCcjDFvUS0yZNHf7wzIxAPgwPJD/0uqaGgy5qkLnlPCqS/aPIk+z2KyXwcdewdI
         hsAJJf/eEE1/9m51aPP6yk3bd0lan4DOK3PRS18YNHpdG38rgTdPEr0LMqd2sQm/rKIk
         gwjuwTJ/3J1KKT49EccTEBw5NLw0fPI95keyGtdX59ysIvQRha8sukYqc+XJaI/n/vsN
         4Gvg==
X-Gm-Message-State: AOAM5321YZvnn6gsEb1MyW8xQg/bhIXIKFQ1+S4crJnWW7PqA6Nd5BQu
        6UzVTWbcDYrwNb3pKUu6wz+GJw==
X-Google-Smtp-Source: ABdhPJyK93YFoZYWjNZAmUwZCt9txB48qt9plEmTBf9e4k49KkDwMgZfuqHgf++fOSlLySTxgbtIsQ==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr7189574wrw.113.1599720903702;
        Wed, 09 Sep 2020 23:55:03 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 09/29] iwlwifi: dvm: Demote a couple of nonconformant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:11 +0100
Message-Id: <20200910065431.657636-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
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

