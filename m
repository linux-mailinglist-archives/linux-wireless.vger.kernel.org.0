Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAEA5148AC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358777AbiD2L72 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358762AbiD2L7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 07:59:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE36C7E85
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 04:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1085B832D9
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 11:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3286DC385A7;
        Fri, 29 Apr 2022 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651233364;
        bh=KWWxD1p0Cqv2iwPkipTUDx9uVglSHLkK+nUJh50EX4c=;
        h=From:To:Cc:Subject:Date:From;
        b=vKU5ewHgQgdr8+GqvygZzmHHVvOujjS9wibB86XlLVszfGVhDA1BvaYfTnvhv/YYd
         nd8yunhuH+VZvRyEQu+W831TttUFhanlxEM7x95pE2zh8J8XUVKnFF4xTsf1jEnuPB
         o2/ZqoN3z/jPrJsCIpLvwC2mKpK5EbynrREYruZaPzI+O2iZYNsldgEDvlqMfIG7ME
         RBJqjVu1X7A24s1i9wqJR+7r1kjzgFtTFKZeAhwAMOrhY3P4lZFclxZoku4Fk73ZVL
         0PbihAcMrIASIluKmBoVZ6OIbGth+XYVDInwIJe85Z3PCvtk/JwfnW0ZQ8e6RTG1qF
         +95IqRVdsIryA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        chui-hao.chiu@mediatek.com
Subject: [PATCH] mt76: mt7915: configure soc clocks in mt7986_wmac_init
Date:   Fri, 29 Apr 2022 13:55:56 +0200
Message-Id: <012ecb7435a23b1e15d27a40147d85a851b45e63.1651233185.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure mt7986 wmac soc clocks in mt7986_wmac_init routine.

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 04e62d569599..a24bcdcd2f06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -12,6 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include "mt7915.h"
 
@@ -1117,6 +1118,19 @@ static int mt7986_wmac_init(struct mt7915_dev *dev)
 {
 	struct device *pdev = dev->mt76.dev;
 	struct platform_device *pfdev = to_platform_device(pdev);
+	struct clk *mcu_clk, *ap_conn_clk;
+
+	mcu_clk = devm_clk_get(pdev, "mcu");
+	if (IS_ERR(mcu_clk))
+		dev_err(pdev, "mcu clock not found\n");
+	else if (clk_prepare_enable(mcu_clk))
+		dev_err(pdev, "mcu clock configuration failed\n");
+
+	ap_conn_clk = devm_clk_get(pdev, "ap2conn");
+	if (IS_ERR(ap_conn_clk))
+		dev_err(pdev, "ap2conn clock not found\n");
+	else if (clk_prepare_enable(ap_conn_clk))
+		dev_err(pdev, "ap2conn clock configuration failed\n");
 
 	dev->dcm = devm_platform_ioremap_resource(pfdev, 1);
 	if (IS_ERR(dev->dcm))
-- 
2.35.1

