Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0470E310765
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBEJL1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:11:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230128AbhBEJHu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7x4n-0044i1-4z; Fri, 05 Feb 2021 11:06:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  5 Feb 2021 11:06:39 +0200
Message-Id: <iwlwifi.20210205110447.a497faa942dd.Ibc155ad36da9de7eb0ddcdd826ddf8dd6607d2ac@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205090642.1553849-1-luca@coelho.fi>
References: <20210205090642.1553849-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [RESEND PATCH 09/12] iwlwifi: mvm: cancel the scan delayed work when scan is aborted
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we abort the scan because of a firmware crash, we
need to cancel the delayed work that monitors the scan
completion. Otherwise it'll kick and try to restart the
firmware yet another time.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index e89f4f1e44c6..42e790ed8caa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2854,6 +2854,8 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 				.aborted = true,
 			};
 
+			cancel_delayed_work(&mvm->scan_timeout_dwork);
+
 			ieee80211_scan_completed(mvm->hw, &info);
 			mvm->scan_uid_status[uid] = 0;
 		}
@@ -2894,6 +2896,7 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 				.aborted = true,
 			};
 
+			cancel_delayed_work(&mvm->scan_timeout_dwork);
 			ieee80211_scan_completed(mvm->hw, &info);
 		}
 
-- 
2.30.0

