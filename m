Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC262C527
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiKPQot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiKPQnt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3F5E9C8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0FA761EF9
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0C7C433D6;
        Wed, 16 Nov 2022 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616798;
        bh=LkYPOzL8QAlFxe+/Q60xcGyTfE4txp2r67xDszwbRWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6vsel9q2fD0x3PhEoqhktWcTRmUx5x1CpNQv0zRBFoi32eSYZrPt+2V9wYOTXjVy
         Y3WFVF35bU+7GF5JXG3lU+i1w2mdbWKDEoZ8OK3obI45ToLtkyKbhMN51viShhZhYL
         AEdm8Yjv3aHaxrDAo9fOVeurHVS8kSRopkBBCYxbgphGd/mFbcfVUPrvvBAtiy/YH7
         4+5ulYq/ojT5KFkdhBtuBITRwYTRgTCXGNEgx5WKD6f1BMZWSnXgyB2PFTP5WYFOPl
         tAOnDkZDfr3+y+nCKf6ALaE+ZUZVHO402OngKCZrjSl7x26kXGL0njPdjVp4etrKRE
         bVsfTiXu0kbTA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 48/50] wifi: ath: add ath12k to Makefile
Date:   Wed, 16 Nov 2022 18:39:00 +0200
Message-Id: <20221116163902.24996-49-kvalo@kernel.org>
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
 

