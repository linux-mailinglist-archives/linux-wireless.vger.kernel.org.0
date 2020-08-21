Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7694824CF00
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHUHR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgHUHRe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A8C06135B
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so818811wme.4
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORROKc4zS4isv+NiIKK9DX3bTWpPv9GkX3d9qrOHUaI=;
        b=ESbKocyHn40ftV/JsQHpreJTqQKXvQfoEyYUn+BGPFH/aP67/bgZtE1pJuGKZutQ96
         VInQQ+c5LRUvRrRjKU50ah6UyoNBPt8yz9RUFUSA5mpNaP2IS2uVr2/OYw6MZW3AlcNE
         kitgklNmt9g/a5lKx5p2M1nI7zlXcBaJNFXFWnDt41uQ3jtcw1lfA3wXgXaInPhavodw
         8mWSpRKW6Ko+SXeVmtstUVQSd8n+j6A6e8UmapV8oHoPRP0XPS0P2JqnOIr4c9ySm8FZ
         5SytEiA5l2C6Ri/TU66NwXO+cWl26JD6g/vnolek2KVDoLZdET3Yr7mfd3+TzqOLOQLy
         QHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORROKc4zS4isv+NiIKK9DX3bTWpPv9GkX3d9qrOHUaI=;
        b=PzguAZMebtnGvPPQiztTn9AdOc06I2+en7qbbrt8dZUjO9QGDf8UxU+mRvLsp8EVLw
         lUh7Eur3RRZXc1EfV0RGpWAU8j/mEwKfqf4tS5R+PEJJTiX0Zi30Be2zSEq0i/5AnG1L
         2mhpkxGy9B2KID3SPpe3WIxZZUw2X5FHxSvNQK0tf0TTlmfDDAzrr4pTBpbqBIwNCfK2
         NhuUQJ3E2aRq5IThAg1DF/15+93XF+HzVTDwawf6HgxJBhcJHdx1gwZtyOdoTX23CDKc
         QAmO2ABA3aEehGumj5YKlLxDK618TJwOIgfcznZr38s6fnvgilxu1UasyBTx6T85kKbx
         h1oQ==
X-Gm-Message-State: AOAM530ry9neorqWKPtFObF6TuxXC6dM3nZ+GOlrDCFEUm/SiqKTxF98
        qrBHpYnrv/bLtTUHmeoz0XDnaQ==
X-Google-Smtp-Source: ABdhPJyJxmaBQ0Hh4H/E0WBSFApXAvRQNjR8LzJXXhI6vHV5nxNeBzqY83GHvrLiSbs2U+rdRkArZQ==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr2116491wmd.66.1597994224797;
        Fri, 21 Aug 2020 00:17:04 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 13/32] wireless: intel: iwlwifi: dvm: rxon: Demote non-conformant kernel-doc headers
Date:   Fri, 21 Aug 2020 08:16:25 +0100
Message-Id: <20200821071644.109970-14-lee.jones@linaro.org>
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

 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:695: warning: bad line:
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:701: warning: Function parameter or member 'priv' not described in 'iwl_set_rxon_channel'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:701: warning: Function parameter or member 'ctx' not described in 'iwl_set_rxon_channel'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:839: warning: Function parameter or member 'ctx' not described in 'iwl_full_rxon_required'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:1029: warning: Function parameter or member 'priv' not described in 'iwlagn_commit_rxon'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:1029: warning: Function parameter or member 'ctx' not described in 'iwlagn_commit_rxon'

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
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 6f37c9fac31d9..12a3d464ae640 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -689,7 +689,7 @@ void iwl_set_rxon_ht(struct iwl_priv *priv, struct iwl_ht_config *ht_conf)
 		_iwl_set_rxon_ht(priv, ht_conf, ctx);
 }
 
-/**
+/*
  * iwl_set_rxon_channel - Set the band and channel values in staging RXON
  * @ch: requested channel as a pointer to struct ieee80211_channel
 
@@ -826,7 +826,7 @@ static int iwl_check_rxon_cmd(struct iwl_priv *priv,
 	return errors ? -EINVAL : 0;
 }
 
-/**
+/*
  * iwl_full_rxon_required - check if full RXON (vs RXON_ASSOC) cmd is needed
  * @priv: staging_rxon is compared to active_rxon
  *
@@ -1007,7 +1007,7 @@ static void iwl_calc_basic_rates(struct iwl_priv *priv,
 	ctx->staging.ofdm_basic_rates = ofdm;
 }
 
-/**
+/*
  * iwlagn_commit_rxon - commit staging_rxon to hardware
  *
  * The RXON command in staging_rxon is committed to the hardware and
-- 
2.25.1

