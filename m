Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5065913B6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiHLQLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbiHLQLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9EA50E2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F0BB82482
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFB1C433B5;
        Fri, 12 Aug 2022 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320657;
        bh=LkYPOzL8QAlFxe+/Q60xcGyTfE4txp2r67xDszwbRWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nep7YndIf+Zc+xkdutEEquhZRLVnCbHiPs/Rt9scJI1lfQMZSnB35Bnh6gHyLxh59
         zfpJrvDcbGnGM1ucvCH2YqsdSg27fq4kM1lLcVJoTaBFlNP87XvXz52s26c+qXR24f
         OrVLgsNeTZeY2d0Y3lkWMxWaOVFHPo/Qzxt+nZVN3oBK0BTFtG+KZLx1CO12Nloc8P
         mb6wFwnCnuyl4Q9jSfNP2rqpomzkyVq7zfuRwz39YLZBjyBrmWfeiP/pKe5dUl/q8B
         0mxjKTXmkpjeT4K4gb5Yo7BKqRtAO7xwuuLUz/jCRM/x2e9e3mMfe+JNYgGdjLWH9y
         olENLNwzy9rag==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 48/50] wifi: ath: add ath12k to Makefile
Date:   Fri, 12 Aug 2022 19:10:01 +0300
Message-Id: <20220812161003.27279-49-kvalo@kernel.org>
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
 drivers/net/wireless/ath/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/Makefile b/drivers/net/wireless/ath/Makefile
index 8e4ae9de5ae4..8d6e6e218d24 100644
--- a/drivers/net/wireless/ath/Makefile
+++ b/drivers/net/wireless/ath/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_WIL6210)		+= wil6210/
 obj-$(CONFIG_ATH10K)		+= ath10k/
 obj-$(CONFIG_WCN36XX)		+= wcn36xx/
 obj-$(CONFIG_ATH11K)		+= ath11k/
+obj-$(CONFIG_ATH12K)		+= ath12k/
 
 obj-$(CONFIG_ATH_COMMON)	+= ath.o
 

