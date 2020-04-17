Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B701ADABC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgDQKLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgDQKLb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:11:31 -0400
Received: from lore-desk.lan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CD321D91;
        Fri, 17 Apr 2020 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587118290;
        bh=f3ymiRdU1hAG285rj12OPYlx1+9KeiwDBOQNbi5H04A=;
        h=From:To:Cc:Subject:Date:From;
        b=l+g+HlSWY3vC8z0dJXPThQWmTFHknfWj+NHSf2zfD2ddUPeDhwpYJtaXAuZTqQHcZ
         E4q9I6+GBTywplmQaqZWCBs0f1pOc+r93ZHIE591MF6lFURGqJV9h4OkQnmL69JijC
         qxXg7UgAWl+E8Qe5P/GRRF1q48sRHbuFq8Xq6ghY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: disable aspm by default
Date:   Fri, 17 Apr 2020 12:10:54 +0200
Message-Id: <1b577f39b5ea499a553f2d7da39940c272e11630.1587118207.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vendor SDK disable ASPM by default

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index f17801c4981e..3eaa0300219c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -41,6 +41,8 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	mt76_pci_disable_aspm(pdev);
+
 	map = id->device == 0x7663 ? mt7663e_reg_map : mt7615e_reg_map;
 	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
 				 pdev->irq, map);
-- 
2.25.2

