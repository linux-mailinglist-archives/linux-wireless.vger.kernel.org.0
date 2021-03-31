Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1754634FE5C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhCaK4y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 06:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCaK4i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 06:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7FAA61952;
        Wed, 31 Mar 2021 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617188198;
        bh=IihXZNyN8gIds+6ilfONdldXFHyglIXC5X696QD3+ho=;
        h=From:To:Cc:Subject:Date:From;
        b=gUMRJUUztRfrm35KNEovBDmhQGP17XMbVzPFvoUor0/Gb5vW4sjf5b4GS15mcvQLC
         GsN1vnPfQwt7AQ8G5OKiIPkhEoRyAqjTHNWD9gPNJOm5R4PyzkJ3XTUrr/OvcyYNuM
         NgDw4WeGQ8klDEGu7XLUB26SZhPnEt04tQNrjrv/MjrLkP4N2CG8H7Qm5TPOZTFSGI
         TbIa0x+Io6FBEBCto0fWKO7aOXUPhA4UEQu9hfSBDeQVHNc17U+8Mte3d2dinEb4nY
         728zPyjrm5rKAYpy1LgBHZvmvpsoHrQE0gX+hgHG+vw6zQ4P+4us01KCnDgbZibgH/
         vlTfEMW5YRLMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix typo in mt7921_pci_resume
Date:   Wed, 31 Mar 2021 12:56:33 +0200
Message-Id: <1b7f1c356b8e51d8cad26810b2c39e1d872ecdd3.1617188119.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return proper error code from mt7921_mcu_drv_pmctrl in mt7921_pci_resume
routine.

Fixes: 8db9c79f230d6 ("mt76: mt7921: fix suspend/resume sequence")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index def8b7816609..e94523bf19be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -245,7 +245,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 
 	err = mt7921_mcu_drv_pmctrl(dev);
 	if (err < 0)
-		return 0;
+		return err;
 
 	/* enable interrupt */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-- 
2.30.2

