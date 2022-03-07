Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079484CFD16
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiCGLgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 06:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbiCGLg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 06:36:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174134754F
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 03:35:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E117E60AD4
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 11:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670A8C340E9;
        Mon,  7 Mar 2022 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646652931;
        bh=Iyx/xSbAFq8+0tNTewDESKfxHXN0JUokgjkQV+9sIfc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ux1BO3CHF1myqMU5ySFVm0GIDgSKplvVMoCBvhX2x5atwJmzZKbmk13ZTwtkdoJNn
         uEtJbstrZ1PMnkGLnqtsPXKTY/a8i0POOdmV3ia8FyV1IPNvyqPF+PRhy0NJlHLaO0
         EbgIpxllFzNpCZ+FMjHiuNYj41zqM5FP9E1qGKj7sSziPD9wO30l4cg3IGET0gZQ65
         arf4KqkEFdQCgWsFXCK/aqps6aon+0reELK/irtv6kbahIyRqNsI3lzPNzxyqzkEZQ
         3ZX213s5hRifQJCSWYLR4xa8/1Za+utuafTDoh6GCd8T97RSdAOeNK5dFTjHmUFtkY
         C/i1yy3u81Jdw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_wait_for_mcu_init declaration
Date:   Mon,  7 Mar 2022 12:35:21 +0100
Message-Id: <0dac8473a32b528a7de84d79779ac071c69e86f4.1646652868.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921_wait_for_mcu_init is no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1f573ffc17ce..a66215c7cd5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -412,7 +412,6 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
 void mt7921_pm_power_save_work(struct work_struct *work);
-bool mt7921_wait_for_mcu_init(struct mt7921_dev *dev);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
-- 
2.35.1

