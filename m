Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE95F930E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiJIW4E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiJIWx6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 18:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55F4AD43;
        Sun,  9 Oct 2022 15:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFFA060DD9;
        Sun,  9 Oct 2022 22:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE898C433B5;
        Sun,  9 Oct 2022 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665354420;
        bh=+3IhUpAN6u1ITIK/zEVNFbHGupufpTdT9BiBQYhxLqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVifz5JCxk+wj/yTp+iqpuDJtTIpfTBWzIbBwCbjjzKabj8CPpaK1T1N3gszYDAC9
         1LJZ5GegVyvy0iOpKguxihPUvJStVuquQ5n30w/59DGdIGYq68awowz424/0LYCFAh
         51MSSOioq4WJLhMMLW4eRs9onhYFh++NvgyUQbcwKoF8n73VFlZcaSmRDWbpHjxbB8
         SB+rpvmVJCixU5vbtn0OHKVWwtI3gHDGSHNTdTENf5x+k21hVnAhlKIMlGVUKkYw63
         AlvxoPGWgbFgY5eBZf851KtELwt9iHiaY6evGWH5MvktGb262BaSavAXND1uK+dGMK
         PlfE7FyqUL+dQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Serge Vasilugin <vasilugin@yandex.ru>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        helmut.schaa@googlemail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/23] wifi: rt2x00: correctly set BBP register 86 for MT7620
Date:   Sun,  9 Oct 2022 18:25:50 -0400
Message-Id: <20221009222557.1219968-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009222557.1219968-1-sashal@kernel.org>
References: <20221009222557.1219968-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit c9aada64fe6493461127f1522d7e2f01792d2424 ]

Instead of 0 set the correct value for BBP register 86 for MT7620.

Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/257267247ee4fa7ebc6a5d0c4948b3f8119c0d77.1663445157.git.daniel@makrotopia.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 57fa472b5c4e..155c08dc2e0e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3655,7 +3655,10 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 		rt2800_bbp_write(rt2x00dev, 62, 0x37 - rt2x00dev->lna_gain);
 		rt2800_bbp_write(rt2x00dev, 63, 0x37 - rt2x00dev->lna_gain);
 		rt2800_bbp_write(rt2x00dev, 64, 0x37 - rt2x00dev->lna_gain);
-		rt2800_bbp_write(rt2x00dev, 86, 0);
+		if (rt2x00_rt(rt2x00dev, RT6352))
+			rt2800_bbp_write(rt2x00dev, 86, 0x38);
+		else
+			rt2800_bbp_write(rt2x00dev, 86, 0);
 	}
 
 	if (rf->channel <= 14) {
-- 
2.35.1

