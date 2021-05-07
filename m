Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65F3769D9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhEGSOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhEGSOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 14:14:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3533C061761
        for <linux-wireless@vger.kernel.org>; Fri,  7 May 2021 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Tk6vZF4201Rap7RaOcrF0PDjB5oEwR4lv0xdhdEPs30=; b=lvfBeYQjlI8BhBoesRq24vANOA
        Rbil3s4pDuDNk8C9K7qgN/+B0PFlZo9EpfG7ewOc0ypkqCW1pSN8gAltTQO0/P0hdnRZtXsYZxDWD
        fhk5VOj8eK2cYkS/vePWzYZJF57mXg4hVarQHtroBp1iuJBNBvL4mIORQROGEBr3sVEg=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lf4yM-0001Yq-Ff
        for linux-wireless@vger.kernel.org; Fri, 07 May 2021 20:13:10 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] mt76: mt7915: disable ASPM
Date:   Fri,  7 May 2021 20:11:08 +0200
Message-Id: <20210507181108.55095-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210507181108.55095-1-nbd@nbd.name>
References: <20210507181108.55095-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The same is done on the other chips already, so it is very likely needed
on MT7915 as well

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index aae2fb3ccad1..340b364da5f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -255,6 +255,8 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	mt76_pci_disable_aspm(pdev);
+
 	if (id->device == 0x7916)
 		return mt7915_pci_hif2_probe(pdev);
 
-- 
2.30.1

