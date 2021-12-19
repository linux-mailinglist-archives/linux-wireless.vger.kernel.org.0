Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3B47A030
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhLSKSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51388 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235596AbhLSKSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:35 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGz-001O3b-Ak; Sun, 19 Dec 2021 12:18:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:19 +0200
Message-Id: <iwlwifi.20211219121514.0ede76a9ca92.Ie64a4df79ea9c485ae3d2fc043319e8f79cefa8e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mvm: correctly set channel flags
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

In case of forced passive scan on a UHB channel,
don't set the direct probe option for this channel.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b401ab6d46a9..cad190fac9e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1826,8 +1826,6 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 			}
 		}
 
-		flags = bssid_bitmap | (s_ssid_bitmap << 16);
-
 		if (cfg80211_channel_is_psc(params->channels[i]) &&
 		    psc_no_listen)
 			flags |= IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN;
@@ -1869,8 +1867,11 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 					  (s_max > 1 || b_max > 3));
 		}
 		if ((allow_passive && force_passive) ||
-		    (!flags && !cfg80211_channel_is_psc(params->channels[i])))
+		    (!(bssid_bitmap | s_ssid_bitmap) &&
+		     !cfg80211_channel_is_psc(params->channels[i])))
 			flags |= IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE;
+		else
+			flags |= bssid_bitmap | (s_ssid_bitmap << 16);
 
 		channel_cfg[i].flags |= cpu_to_le32(flags);
 	}
-- 
2.34.1

