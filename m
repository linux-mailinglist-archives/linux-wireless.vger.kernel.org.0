Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3C3CD509
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhGSMFK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 08:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhGSMFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 08:05:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pSvskRo7NNg80ze/Ja2Ys5FnFRsSinipmYhKGPOHkUg=;
        t=1626698749; x=1627908349; b=GuT8GmM3yGBsH6T5JMTwow6sZ2yIAckh8e24O5+XyzJgghm
        B+MpDZUgGC6NlCq7PgKJnKVIv1d3sKuyfbnXHcuq+3YjDgDVOl3UFMwmvGtwuxq6Bu2icHygaG8D0
        e88VtFxxsUbNe9mpbU/+FlyZim8K0NIKMmd+m1IHh/DsfqjSKFQU2x0qtSO5Vmfcr6/nTR7Nr7/+t
        gm6O+6dNttZtHPZnE+tIqU9Cmf+jA1JeA4XBWs0cWgnUMK3xpTliMhgTJO0m65WZ9PnJtIv+h7y51
        HOOBFfudIvJoQZ2wR891plypcnHv7Xw/WKCEvVhz77YXqSadbKZtt1odFtYv7qbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m5SeZ-004MeZ-3V; Mon, 19 Jul 2021 14:45:47 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Yaara Baruch <yaara.baruch@intel.com>
Subject: [PATCH 5.14 2/2] iwlwifi: add new so-jf devices
Date:   Mon, 19 Jul 2021 14:45:39 +0200
Message-Id: <20210719144523.1c9a59fd2760.If5aef1942007828210f0f2c4a17985f63050bb45@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719144523.0545d8964ff2.I3498879d8c184e42b1578a64aa7b7c99a18b75fb@changeid>
References: <20210719144523.0545d8964ff2.I3498879d8c184e42b1578a64aa7b7c99a18b75fb@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

Add new so-jf devices to the driver.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e8693be51fb1..0b8a0cd3b652 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1149,7 +1149,41 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name)
+		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
+
+/* So with JF2 */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
+
+/* So with JF */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name)
 
 #endif /* CONFIG_IWLMVM */
 };
-- 
2.31.1

