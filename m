Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6AE591398
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiHLQKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbiHLQKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C845A5
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D17FB82482
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6EFC433D7;
        Fri, 12 Aug 2022 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320608;
        bh=afi8JZrLiX2wXtdlF6dXd1AGUNdqgAzSllZrAXc550s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wh9jDm+oZB5oPyiIeRVagaR6aXlSEpvlFD9XDyyJm4KEsMUL3iXQ7QZjbIGsgeSej
         fjqsFk2pWeT71ggbo98eQt8lgs4jVFYDeaAFRs72DQKVF/ESkGXYj12C2vEbwDf0hq
         oj8oWdow2QF3z5n1HZCwo2iOMdUKIBlanHSRbGAIqeRckJPR98Q+Z9vcz93BKI28hh
         ZPJkfo5WkC+iXACOEJc7UiJL0Wocp+z4aZu9PkDfvw8DdsrkXaqncTXDODf4kTlVQS
         QGsCbTAnAf+GYlh44GDFrsGRHXJYlug00swohrd9OJoV/6LfW/DNr14NqyL0PN9rL/
         V/w+8n4NzpUTg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 02/50] wifi: ath12k: add Makefile
Date:   Fri, 12 Aug 2022 19:09:15 +0300
Message-Id: <20220812161003.27279-3-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/Makefile | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
new file mode 100644
index 000000000000..62c52e733b5e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+obj-$(CONFIG_ATH12K) += ath12k.o
+ath12k-y += core.o \
+	    hal.o \
+	    hal_tx.o \
+	    hal_rx.o \
+	    wmi.o \
+	    mac.o \
+	    reg.o \
+	    htc.o \
+	    qmi.o \
+	    dp.o  \
+	    dp_tx.o \
+	    dp_rx.o \
+	    debug.o \
+	    ce.o \
+	    peer.o \
+	    dbring.o \
+	    hw.o \
+	    mhi.o \
+	    pci.o \
+	    dp_mon.o
+
+ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
+
+# for tracing framework to find trace.h
+CFLAGS_trace.o := -I$(src)

