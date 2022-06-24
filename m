Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86A2559753
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiFXKGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFXKGm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 06:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25616F4B0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 03:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EA46218C
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 10:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19547C34114;
        Fri, 24 Jun 2022 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656065200;
        bh=PHOHvDSIWwZlgZEjUF9IlCuXjjMkgxlP2mtKSWGku5c=;
        h=From:To:Cc:Subject:Date:From;
        b=cuCzwAO1znO9Fw+gReohbOudot/gu0d+uQ/vSmhR7lZ+r6JBpPb8kYACilZjoNfb6
         jWL6hwjoGvd1l4XSibqRV9MyS4U66LPNYMNpSMHZXXjU9oy9LeM0E4xRN9XjW8Eb+x
         EdgNcYjJ6caZVeMZpJ9lV5dMoieEdG9MdRaNRFU/AaJHm35dZSGnv43Tk9rXOMndTo
         4ZhJSY/3WFN1hroT/5Z3Pp+VVfBIGjL8LUMSdsjPo4F0mXkH9uNZvZhoH3bAw4Lqxj
         g9f4Cf3OinQVX+Vau5MvfA3ioDSa9Nd+IRcGe0cBt/qqKSIzlyt6uOtUHOp7uUlgh+
         wmOBEJxaIQMhg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: make mt7921_pci_driver static
Date:   Fri, 24 Jun 2022 12:06:29 +0200
Message-Id: <da9740f81ef48488aaedf7b2effb10779a479e8f.1656065130.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
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

mt7921_pci_driver struct is only referenced in mt7921/pci.c so make it
static.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index efeb82cbbe83..d2d45f381232 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -272,7 +272,6 @@ mt7921_hw_dev(struct ieee80211_hw *hw)
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
 extern const struct ieee80211_ops mt7921_ops;
-extern struct pci_driver mt7921_pci_driver;
 
 u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 23361a505daf..06af35250b3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -489,7 +489,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PM */
 
-struct pci_driver mt7921_pci_driver = {
+static struct pci_driver mt7921_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7921_pci_device_table,
 	.probe		= mt7921_pci_probe,
-- 
2.36.1

