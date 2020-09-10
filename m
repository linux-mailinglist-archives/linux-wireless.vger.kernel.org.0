Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D93263DCB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIJG4u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgIJGzY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:55:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7DC06179E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:54:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so5390840wrw.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbKBLvVHaH2v5GCYgGjIlYZDy81EB6VKwDmcXvqDNxg=;
        b=n41ntEOLrKSWt8PibAE37DqGU6i4Ib98B7O4G+ELSKMayn33X+WA2m6oj9Mf1sa4yu
         6gP2/1WIBLHLD2tW6ZOT9PlerxqYybifK1HCfy6dZ7yaGgNHPcLXuSew0F+qynqicKBf
         ptLisDmdEUSlMlke34+vjTZ5soOPDnmc+3WtniR0WmLmLZsP2UzzGR6Q4yfGhhxUxwq3
         jUWJGb2CQIgBD7cqZn+Nm2KThPlUoWkr1qnGkDOWXFhy0nr5k7Y6iY8S8no6VcBTPt0u
         AL4t8Ep5ypOKHvWf1Y2e8JxHw7j02kp0PZ0L/FP7OL8LGKf7Ea1QfhwWXrkbTmNA6cS/
         bHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbKBLvVHaH2v5GCYgGjIlYZDy81EB6VKwDmcXvqDNxg=;
        b=BCzbRzscC4SWwS3v2y35uiJ6I4XWClWiagYAPmXzhbbA+a1Z7/kk7KUKqy46TIMukB
         zS9jMNVlIrxizLel9VCRYugHaV4ntf7x8MYxmO3uCOXkWrA/NB5cnfOELb/GJ3ooaCoU
         ZpjK8SEIiuHzGSniSt8uHdUoUScSyQ1mhMBiceefdl8envo9xPJaOWCBJrRCK8FKWvh/
         QmMJ+WvbtUYzDdEIoMJkFlKjMz19WX+jhvuiKh2Y759VIN8uDg8CPf4eW/saUThviIbt
         kh/mYThcndE9Q83dSMLwbDZ/ziOMmuhk0QZ4JetGTVPZU7QjJreoTUtKsoCxSI6lh7L4
         GnVw==
X-Gm-Message-State: AOAM5332tJWeA/ybjyyu+4SlcgQZPl8zuao0pUDQbXgPK9yibqE9L9Bv
        1SS2TQ49Cd2iThzQ2MTxuBJYQA==
X-Google-Smtp-Source: ABdhPJz3egXddNRHHBLq0lGLK15q9ImWvnkid/gLtUa8ihcv0eDNyg9d0MCGOcTfeNQPU+zhfgSdFg==
X-Received: by 2002:adf:82b1:: with SMTP id 46mr7933654wrc.271.1599720896760;
        Wed, 09 Sep 2020 23:54:56 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:54:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 03/29] iwlwifi: dvm: tx: Demote non-compliant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:05 +0100
Message-Id: <20200910065431.657636-4-lee.jones@linaro.org>
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

