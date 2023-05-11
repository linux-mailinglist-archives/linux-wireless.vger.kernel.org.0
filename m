Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9551E6FF277
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjEKNRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEKNQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:16:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D0E73F;
        Thu, 11 May 2023 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810935; x=1715346935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdSBw6kmMXKbjHj4XOjr3hir47yLMEiBhsxfNK+xo6c=;
  b=LDCREMqa8hlXwt4smpWTc1bCDR0zeyjwOh6OZqSmixVWSoKdvL2MdKdP
   SXfO0VVHVtly2yMwbPRiggrvyfpGQLYqkS/KkhAEFo40pXD6ry9Fbd9ru
   YqUiGbarXlxzWxsc/Tgq/0TrbZvXvuScFCHMqT5ZJYBSJkjOBhmvuydyy
   qvMwMev84MeDlZGKn0UXyjIadFAhtrnBfJMkoIeGVZSQbRr9fBOYBJd8v
   UZkwoweij1YFzAsudC2daxV1AwksZr65nFWUQ0HkhQPkojliMJLMEK19z
   KfKPkOBnTTcQrB9lTWFVY54qY67joCQ5df1hsRzVmHlTKl94ZkwpVJN4U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619584"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169844"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169844"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/17] mt76: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
Date:   Thu, 11 May 2023 16:14:34 +0300
Message-Id: <20230511131441.45704-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.
And in the case of upstream (parent), the driver does not even own the
device it's changing LNKCTL for.

Use pcie_lnkctl_clear_and_set() which does proper locking to avoid
losing concurrent updates to the register value.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/mediatek/mt76/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/pci.c b/drivers/net/wireless/mediatek/mt76/pci.c
index 4c1c159fbb62..8c6444f5fac3 100644
--- a/drivers/net/wireless/mediatek/mt76/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/pci.c
@@ -39,9 +39,8 @@ void mt76_pci_disable_aspm(struct pci_dev *pdev)
 	/* both device and parent should have the same ASPM setting.
 	 * disable ASPM in downstream component first and then upstream.
 	 */
-	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, aspm_conf);
+	pcie_lnkctl_clear_and_set(pdev, aspm_conf, 0);
 	if (parent)
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   aspm_conf);
+		pcie_lnkctl_clear_and_set(parent, aspm_conf, 0);
 }
 EXPORT_SYMBOL_GPL(mt76_pci_disable_aspm);
-- 
2.30.2

