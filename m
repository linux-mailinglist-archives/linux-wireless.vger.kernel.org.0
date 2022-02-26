Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60FA4C53B9
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 05:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiBZEvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 23:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiBZEvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 23:51:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6822BD73B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 20:51:18 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e6so5052919pgn.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 20:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kTTIEy++ofe3ES8RoKQOUL/+n9nVC73UgJwFhBvioQ=;
        b=qjQkHYB+tgLYo2c/TMNIztJL5Wurlbu4vMVYFSEinAp5WM7GUtvaMq5kmey+60XtZ/
         ZrNMr5tCsJtF7OZ6bLh7UBjuKo9xXrQn3AC5vpEtZG4+QGQ97MeTBEdRjmRN8SrDjWpA
         0pvjKwvIpt2KtLFhJYrnkNOcWNJHrQ/HEtckrd32BKN6slat0OTBcrpXu58k0a9h9TM6
         V1AN5llvZyO63QCp1EU5MT5c7ph0YilxmOK+AOQshyO17mL83Ak/z/BmLK1fEsk+1LOX
         wYTtJEdtfJIjPwPuHD9w4fMD4lYVEJhemqGRlr54BUzlm1JOznFv0ZmAy/k5aHcbuXvo
         7waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kTTIEy++ofe3ES8RoKQOUL/+n9nVC73UgJwFhBvioQ=;
        b=ifbpc+oY/TCK8uMyTMjUa1hddPcirAJW0/Xffvm3nTEIA3fVeBnYWDhjHkKxx1HKha
         2JexvmnbJMh7Uk14jo+JDrxU6dLjX81qPOhTXOKmd9sNLT7RJhBiOcNipl638GMGCcwT
         Rl+uPM02w6H52l9F8lQ8DAwM3PPkrWEt7jqtghHeVQXSbgLbNJoGOvVyJO/LFcwzinSn
         SL6iUEcmvGhpDzOfH+9EHLFMZRwNnPOQzuGF15bkxY5IX/L2DhVXPwhVoJ8nXT1yOIxt
         D42RtL5AWHwuyc0TfQq9ltUfEmvtzziarXUwxnL/DL4LxZ1f30695MgB+YPf+ELmUzE0
         IvMQ==
X-Gm-Message-State: AOAM531r5poPMvEHp+PI6lxe3LLFRAfZW9hn1hWLNkQ+paWuPPI8LCva
        OndAmQ0MpuFBnHGy39Fv2aOYLXAWTeM=
X-Google-Smtp-Source: ABdhPJwGZcrc15Bnuc9j2zZeKPHLIIEpsXindJofnoZy33OWiRwlfttyeBJSxPSEMl8jl5ukS477NQ==
X-Received: by 2002:a05:6a00:1910:b0:4f3:aa39:1e17 with SMTP id y16-20020a056a00191000b004f3aa391e17mr11066447pfi.54.1645851077755;
        Fri, 25 Feb 2022 20:51:17 -0800 (PST)
Received: from localhost (047-035-003-129.res.spectrum.com. [47.35.3.129])
        by smtp.gmail.com with UTF8SMTPSA id e30-20020a056a0000de00b004ef299a4f89sm5278115pfj.180.2022.02.25.20.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 20:51:17 -0800 (PST)
From:   Zachary Michaels <mikezackles@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Troy Volin <tmvolin@gmail.com>,
        Zachary Michaels <mikezackles@gmail.com>
Subject: [PATCH] iwlwifi: Make missed beacon timeout configurable
Date:   Fri, 25 Feb 2022 20:50:47 -0800
Message-Id: <20220226045047.643695-1-mikezackles@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Makes the beacon timeout a module parameter, allowing the original default (16
missed beacons) to be kept while also enabling users that experience problems to
increase the timeout.

For context, this patch has been in circulation for over a year as a workaround
for unstable/unusable wifi, as documented in
https://bugzilla.kernel.org/show_bug.cgi?id=203709
The linked bug report has received nearly 300 comments in the nearly three years
it has been open. During that time evidence has been presented indicating that
this is likely to be a firmware bug, but no firmware fix has been documented on
the tracker, and new issue reports continue to surface. This patch provides an
escape hatch for users that are stuck.

Signed-off-by: Zachary Michaels <mikezackles@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 4 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 1 -
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 506d05953314..c5f5787da35c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1753,6 +1753,7 @@ struct iwl_mod_params iwlwifi_mod_params = {
 	.power_level = IWL_POWER_INDEX_1,
 	.uapsd_disable = IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT,
 	.enable_ini = true,
+	.beacon_timeout = 16,
 	/* the rest are 0 by default */
 };
 IWL_EXPORT_SYMBOL(iwlwifi_mod_params);
@@ -1868,6 +1869,9 @@ module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
 		   bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(enable_ini,
 		 "Enable debug INI TLV FW debug infrastructure (default: true");
+module_param_named(beacon_timeout, iwlwifi_mod_params.beacon_timeout, uint, 0644);
+MODULE_PARM_DESC(beacon_timeout,
+		 "Number of missed beacons before disconnecting (default: 16)");
 
 /*
  * set bt_coex_active to true, uCode will do kill/defer
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 004ebdac4535..198c5ac2575b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -62,6 +62,7 @@ enum iwl_uapsd_disable {
  * @disable_11ac: disable VHT capabilities, default = false.
  * @remove_when_gone: remove an inaccessible device from the PCIe bus.
  * @enable_ini: enable new FW debug infratructure (INI TLVs)
+ * @beacon_timeout: number of missed beacons before disconnect, default = 16
  */
 struct iwl_mod_params {
 	int swcrypto;
@@ -84,6 +85,7 @@ struct iwl_mod_params {
 	bool disable_11ax;
 	bool remove_when_gone;
 	bool enable_ini;
+	u32 beacon_timeout;
 };
 
 static inline bool iwl_enable_rx_ampdu(void)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index fd7d4abfb454..c3d13326a203 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -8,6 +8,7 @@
 #include <linux/crc32.h>
 #include <net/mac80211.h>
 #include "iwl-io.h"
+#include "iwl-modparams.h"
 #include "iwl-prph.h"
 #include "fw-api.h"
 #include "mvm.h"
@@ -1420,7 +1421,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	 * TODO: the threshold should be adjusted based on latency conditions,
 	 * and/or in case of a CS flow on one of the other AP vifs.
 	 */
-	if (rx_missed_bcon > IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG)
+	if (rx_missed_bcon > iwlwifi_mod_params.beacon_timeout)
 		iwl_mvm_connection_loss(mvm, vif, "missed beacons");
 	else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD)
 		ieee80211_beacon_loss(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index da8330b5e6d5..27ccfc94474f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -38,7 +38,6 @@
 /* RSSI offset for WkP */
 #define IWL_RSSI_OFFSET 50
 #define IWL_MVM_MISSED_BEACONS_THRESHOLD 8
-#define IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG 16
 
 /* A TimeUnit is 1024 microsecond */
 #define MSEC_TO_TU(_msec)	(_msec*1000/1024)
-- 
2.35.1

