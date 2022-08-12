Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D05913A0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiHLQLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiHLQLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:11:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717589677F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32CA3B8247F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E4C433D6;
        Fri, 12 Aug 2022 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320652;
        bh=GNbpHWpVMrnuBrHGHn3VB5LVaeNRK3g9BVacM/V8We0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4CWzYoV9Iu/gDxeNOQ59EOCgKy/cfG35LDGLgKexGqFq1K9ymuA0GZ7hj51mL71d
         h3G8y/d9ESM67OHk7Nwg7oDgJ2lBIZlQkvvloGn+uw1qQvk0BR+gIQPlj8zBNONOLO
         s+SwUQMzdfPPEDS36qRqD3JEkGChNSJeV8zfnSk888lhP+7cZwhtlFgL6t/qnP1ZNf
         G+OLRafoCFBVQ2Wvha21c4Umap40AgkmvUCMzvOTCnjJOGrasL2WNEATBObxSXaG1Y
         r9gsFITHDuVZnv8klp0Rb9GHHZvuEGI+pUMCLTUofvYOnlUDz3gmTNMJlRjVXSppA8
         HxzzmNlguaFtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 44/50] wifi: ath12k: add trace.c
Date:   Fri, 12 Aug 2022 19:09:57 +0300
Message-Id: <20220812161003.27279-45-kvalo@kernel.org>
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

