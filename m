Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B385913A4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiHLQKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHLQKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E7AE9CA
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15DB4B8247F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AF7C433B5;
        Fri, 12 Aug 2022 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320607;
        bh=oaNUQ6dvbadxTOk0YYIJr6XY993EPWnmNRYPOUjno00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ta0l9FYXsrkq1eS6vaT+FwH5ZekkLS0AgKSFuBhZmb5YhM8TUO1aHQBCQbC+bSvUS
         002zdNWc2UC1f+d/mxXmooH9e2aezJnvzqmre3k1+ASVztAtZRQNFvgjlyUMXc0NHH
         6CEUx0rpdQwdoP//9J7gdL6bw5Kc/SetMRo/POJU/QyOgddaQ/qw91RjTzRQnAln1E
         2aXyhx+2uFlDbw0XIi59NC3adzq6zXZ2vZW79o5hhJVZOr+iUJyJO5nvlBspdKtMZk
         WXQIUJnj37wcfVCBiHtZjEWYxw/GMQieOIaP9HvmvZPWjvHSdx/dMBd4vYJQI/l7Yv
         /ezdv0YtGiUFw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 01/50] wifi: ath12k: add Kconfig
Date:   Fri, 12 Aug 2022 19:09:14 +0300
Message-Id: <20220812161003.27279-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 000000000000..4b60852691ba
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
+	  you want optimal perfomance choose N.
+
+config ATH12K_TRACING
+	bool "ath12k tracing support"
+	depends on ATH12K && EVENT_TRACING
+	help
+	  Enable ath12k tracing infrastructure.
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  you want optimal perfomance choose N.

