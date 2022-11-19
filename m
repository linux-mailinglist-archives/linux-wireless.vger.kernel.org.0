Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B56309E7
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Nov 2022 03:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiKSCUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 21:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiKSCT4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 21:19:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF572BDEF8;
        Fri, 18 Nov 2022 18:14:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30002CE222D;
        Sat, 19 Nov 2022 02:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1556AC433D6;
        Sat, 19 Nov 2022 02:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668824046;
        bh=nQXd0YnU6e0M5odipekekbdiI+/GmYF+EzbEF1WVXeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFHskSxcVVHkKMiZZ+9O7grzhXBKb5gIMYnU/Ec9YbJEEdrceKlqsrBAHLtov3Uf+
         sYgGdUN2iyWE+x3Sz3OtUV88H3zqeuefg2nSP2eo+RiXTe4Rhg3oxGjN/xj/Z9oPar
         bAIfM1Xj4vLff1nRcV6kxxszjLRnhz5l46IW3xN3lXHw+wlVmrjso7xJ+eWUdD8SqB
         jg/VFRz0LmhEAjTE4lUT3BWhCPJKDfuSSDlj+vwGGnEb1YDNpSvZkPsac9Hpl437k/
         iGAQerKmzlkH7C17aYhPhr8cwGdHuGZnLp864+HzmtMwyKQ/jNX1F+5+Lxixz3VXe3
         AeN1NRPq2TthQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        brauner@kernel.org, Julia.Lawall@inria.fr,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/27] wifi: airo: do not assign -1 to unsigned char
Date:   Fri, 18 Nov 2022 21:13:30 -0500
Message-Id: <20221119021352.1774592-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021352.1774592-1-sashal@kernel.org>
References: <20221119021352.1774592-1-sashal@kernel.org>
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit e6cb8769452e8236b52134e5cb4a18b8f5986932 ]

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, we get a warning when assigning the
unchecked output of hex_to_bin() to that unsigned char. Mark `key` as a
`u8`, which matches the struct's type, and then check each call to
hex_to_bin() before casting.

Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20221024162843.535921-1-Jason@zx2c4.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/cisco/airo.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 65dd8cff1b01..fc19ecbc4c08 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -5233,7 +5233,7 @@ static int get_wep_tx_idx(struct airo_info *ai)
 	return -1;
 }
 
-static int set_wep_key(struct airo_info *ai, u16 index, const char *key,
+static int set_wep_key(struct airo_info *ai, u16 index, const u8 *key,
 		       u16 keylen, int perm, int lock)
 {
 	static const unsigned char macaddr[ETH_ALEN] = { 0x01, 0, 0, 0, 0, 0 };
@@ -5284,7 +5284,7 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
 	struct net_device *dev = PDE_DATA(inode);
 	struct airo_info *ai = dev->ml_priv;
 	int i, rc;
-	char key[16];
+	u8 key[16];
 	u16 index = 0;
 	int j = 0;
 
@@ -5312,12 +5312,22 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
 	}
 
 	for (i = 0; i < 16*3 && data->wbuffer[i+j]; i++) {
+		int val;
+
+		if (i % 3 == 2)
+			continue;
+
+		val = hex_to_bin(data->wbuffer[i+j]);
+		if (val < 0) {
+			airo_print_err(ai->dev->name, "WebKey passed invalid key hex");
+			return;
+		}
 		switch(i%3) {
 		case 0:
-			key[i/3] = hex_to_bin(data->wbuffer[i+j])<<4;
+			key[i/3] = (u8)val << 4;
 			break;
 		case 1:
-			key[i/3] |= hex_to_bin(data->wbuffer[i+j]);
+			key[i/3] |= (u8)val;
 			break;
 		}
 	}
-- 
2.35.1

