Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16247A061
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhLSL2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235639AbhLSL2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:49 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMx-001O73-75; Sun, 19 Dec 2021 13:28:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:32 +0200
Message-Id: <iwlwifi.20211219132536.305d12cf51ac.I2e4e6874113b1e5d8ee467b8a2d90820cc6ddde9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: drop too short packets silently
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's little value in this warning, we get a warning here
if firmware passes us a short packet, particularly in monitor
mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c8b20f202627..295629c5c035 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -176,18 +176,8 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 */
 	hdrlen += crypt_len;
 
-	if (WARN_ONCE(headlen < hdrlen,
-		      "invalid packet lengths (hdrlen=%d, len=%d, crypt_len=%d)\n",
-		      hdrlen, len, crypt_len)) {
-		/*
-		 * We warn and trace because we want to be able to see
-		 * it in trace-cmd as well.
-		 */
-		IWL_DEBUG_RX(mvm,
-			     "invalid packet lengths (hdrlen=%d, len=%d, crypt_len=%d)\n",
-			     hdrlen, len, crypt_len);
+	if (unlikely(headlen < hdrlen))
 		return -EINVAL;
-	}
 
 	skb_put_data(skb, hdr, hdrlen);
 	skb_put_data(skb, (u8 *)hdr + hdrlen + pad_len, headlen - hdrlen);
-- 
2.34.1

