Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFD68A74A
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Feb 2023 01:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjBDAjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 19:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBDAjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 19:39:15 -0500
X-Greylist: delayed 999 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 16:39:13 PST
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42016A42AA
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 16:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=V74tGe4P9YGaTA/LOKpaEQwL+HBwFeWMYsmovOhuKRA=; b=YQl9P5xOaeqS4a3tEiFrMGjwsp
        8A+fJUpBv1sp8Y1LkCol2GEaGPI8eWo0z3r0FtUs0VK3kZxR6CHg66G/bpBDxrDjHb4+BokGnAZp9
        dPl0cWVDi0kLyhldCe32LPHLd5t3+/1egj1zvaPPt5dUWrmIyK6WyQAQeDiuj4rPBOUVAHlisr6x7
        vzCeevfIu5F6H9QWM2YM8ZfqUH2J6FBQurcpYsu5PzqLepMsBAYm9nHhfgFfL1L/vSpIL+jKHcvJ1
        ly1QQSoEjMXh5s2/Lcfa8NOyUnlIgwv/1i0egrAa0P9sLU/M4ROvq1OY2U4zj3PViADvi6IEr1aLr
        gqCuBiog==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pO6K7-00077N-27;
        Sat, 04 Feb 2023 00:22:31 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: expose device tree match table
Date:   Sat,  4 Feb 2023 01:22:18 +0100
Message-Id: <20230204002218.4130312-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On MT7986 the WiFi driver currently does not get automatically loaded,
requiring manual modprobing because the device tree compatibles are not
exported into metadata.

Add the missing MODULE_DEVICE_TABLE macro to fix this.

Fixes: 99ad32a4ca3a2 ("mt76: mt7915: add support for MT7986")
Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 686c9bbd59293..7303b690a64dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1237,6 +1237,8 @@ static const struct of_device_id mt7986_wmac_of_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, mt7986_wmac_of_match);
+
 struct platform_driver mt7986_wmac_driver = {
 	.driver = {
 		.name = "mt7986-wmac",
-- 
2.25.1

