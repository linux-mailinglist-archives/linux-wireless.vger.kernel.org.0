Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13E62C4F6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiKPQnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiKPQm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDB5F852
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4B361EDA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC84C433D7;
        Wed, 16 Nov 2022 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616748;
        bh=1SM7K3/4Fy0y/nWhjjRoQXPN6DVkPA1qyrRfg0BZ1Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P83G3bXijGWc0j+17BxwAD1wQD24UtzCO44P4H+UmJzWcTDGGj0nNc61UJfD/t22R
         Ayut4JnacBzArjKyLbVLZRDarsEso1qt1Q3HzTfz0NrOhmd81sREGZy43mqZyckCQJ
         D9Cwb8DRNl651MkG/PbjTnFKiCQvtr2eJ5VqRTYBFEbXBivtkDTXlxv3aixTq/QBUS
         cvOgtvCfV0Qm9k3AgelphsS18tcg0AXatreOeTkvU+V61yqHjHNNpkoGICYZbk0g1H
         F59QZkxVaxa9/c0DzCodxigNWy9WAkfCwuaAYy6X0R6oT8ryo8I3a7SMocwgcBMHp+
         WHGaSxxfEvZBg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 01/50] wifi: ath12k: add Kconfig
Date:   Wed, 16 Nov 2022 18:38:13 +0200
Message-Id: <20221116163902.24996-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
new file mode 100644
index 000000000000..4f9c514c13e7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+config ATH12K
+	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
+	depends on MAC80211 && HAS_DMA && PCI
+	depends on CRYPTO_MICHAEL_MIC
+	select QCOM_QMI_HELPERS
+	select MHI_BUS
+	select QRTR
+	select QRTR_MHI
+	help
+	  Enable support for Qualcomm Technologies Wi-Fi 7 (IEEE
+	  802.11be) family of chipsets, for example WCN7850 and
+	  QCN9274.
+
+	  If you choose to build a module, it'll be called ath12k.
+
+config ATH12K_DEBUG
+	bool "ath12k debugging"
+	depends on ATH12K
+	help
+	  Enable debug support, for example debug messages which must
+	  be enabled separately using the debug_mask module parameter.
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  you want optimal performance choose N.
+
+config ATH12K_TRACING
+	bool "ath12k tracing support"
+	depends on ATH12K && EVENT_TRACING
+	help
+	  Enable ath12k tracing infrastructure.
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  you want optimal performance choose N.

