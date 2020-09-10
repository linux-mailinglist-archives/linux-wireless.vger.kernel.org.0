Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE354263DCC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgIJG4r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIJGze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:55:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1FBC0617A0
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:54:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so5439604wrv.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zkp7Qawe8Rxm7rdSdovVzLB4vK2dfikmYIjnToE95fQ=;
        b=g4Fdn7VI3qS/0gbKFqeDt0A+g/bA7MA6ER7mw9ftQp+3TrJ4Kw6f9kSDHIo1+/T0S+
         xx0yXKaOzIRtC/8JALHIt5XNd6sSbAG75GJJ5AgZnq1srmEA7SMAUw8r0k9phE1XHvqK
         Agoogui317QVrQ47SGp4msYMODcouLsg+23tBGV+EapWbavM0wqdmT9vED2x26EGVvNe
         FFYyi8U0PcnWPQr4bt49V+cI5ZXDZ4ZKUZoMXRGi8FUTszmmrnnzOoKy4BktSoYtMU3u
         sH8VMxHJOAZrxnlqFBDSx9P9U9g6GQjirr5x6rgSUY9nnehuO/2ItFtUgwG0DZ7RHsX3
         NPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zkp7Qawe8Rxm7rdSdovVzLB4vK2dfikmYIjnToE95fQ=;
        b=TJ4PQblLQc4uFC/H790kQ+HK4Loy7Oq/KRrT5fH+7Nr6ync8o2q6h5Z6n/I1gQk/YG
         iJFpRujkBZ/pzAQmP6c3nFntBm83q3Et7ecaSJ6ie+lLkJYGdTmEe+FELrQ2EWfY7KXs
         8+nZ/7CnYLLbMmRJSOALiy45QuXjiRN243rqhzCUQ9q39k5hRtibRynI6YwsGiyeEtd3
         mvuzICqkPQRXBaynAsOwcCW9DIltSZ/nfyqrBBCxTATk15iKCfDJIY8bwn90HUZorodo
         tTfqXvgIH5bGwEMoc7AZUMNn+yXw05x8yQR1LUfeTgVO9bz0X3jiJr5jOjnkcKgDbFdm
         Dk1g==
X-Gm-Message-State: AOAM533TUdIeMOfMQUK1KcJgnh0E2BH9p8u5jOMk/ZVMcnlaNlhoCial
        4vbboZvtk9WQ3BMgj/3Ne5HTrA==
X-Google-Smtp-Source: ABdhPJyjOu6hXaydDo4atC4QK0jbmaE/9TXZntfJi0qvF6dUD2Zb7u35wQpvQTUIKuHeiPjC0Yztjg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr7085295wrw.98.1599720897900;
        Wed, 09 Sep 2020 23:54:57 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:54:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 04/29] iwlwifi: dvm: lib: Demote non-compliant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:06 +0100
Message-Id: <20200910065431.657636-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neither of these headers attempt to document any function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:121: warning: Function parameter or member 'priv' not described in 'iwlagn_txfifo_flush'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:121: warning: Function parameter or member 'scd_q_msk' not described in 'iwlagn_txfifo_flush'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:779: warning: Function parameter or member 'priv' not described in 'iwlagn_set_rxon_chain'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:779: warning: Function parameter or member 'ctx' not described in 'iwlagn_set_rxon_chain'

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
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index eab94d2f46b1e..3b937a7dd4032 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -110,7 +110,7 @@ int iwlagn_manage_ibss_station(struct iwl_priv *priv,
 				  vif->bss_conf.bssid);
 }
 
-/**
+/*
  * iwlagn_txfifo_flush: send REPLY_TXFIFO_FLUSH command to uCode
  *
  * pre-requirements:
@@ -769,7 +769,7 @@ static u8 iwl_count_chain_bitmap(u32 chain_bitmap)
 	return res;
 }
 
-/**
+/*
  * iwlagn_set_rxon_chain - Set up Rx chain usage in "staging" RXON image
  *
  * Selects how many and which Rx receivers/antennas/chains to use.
-- 
2.25.1

