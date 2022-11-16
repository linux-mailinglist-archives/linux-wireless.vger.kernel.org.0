Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2837F62C525
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiKPQoq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiKPQnr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E559FCC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50654B81DDC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C14AC43146;
        Wed, 16 Nov 2022 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616794;
        bh=GNbpHWpVMrnuBrHGHn3VB5LVaeNRK3g9BVacM/V8We0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUMHZY7/YNApC9LIL2pW+4wfutGkUJPvRO8hP9P6co4EpMaY4qXkPjzP9KgVadZ3B
         DggZ7GNOulO7keXf8Db5b2ymhpvaA5ReM/z6b1KGXnX+0w744DwV/yHewBk610Cu5W
         MwLCd1TQuHE2kiGWDhtF2Ml/a3SjcU45t8ac+5Teq4VYOztvndqVdw6md0R5Xv4LCu
         EwAR7nm+3kB0Umr+Vp+7eM+Z+PYWZm/rIUdkDLgmCptmY2j9XI2PrxUyxrIMJeJWoC
         U0ZUaIuZOwSw6y+SLW8bUIBvbdp9qBCu+uNTiWW2xsZpB/kcVYvPTSd+NIsmlG/PWX
         othgB+0qk1bhw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 44/50] wifi: ath12k: add trace.c
Date:   Wed, 16 Nov 2022 18:38:56 +0200
Message-Id: <20221116163902.24996-45-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/trace.c b/drivers/net/wireless/ath/ath12k/trace.c
new file mode 100644
index 000000000000..0d0edf4204b7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/trace.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"

