Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAC699DD0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBPUez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 15:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBPUeu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 15:34:50 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE49D505
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/1UvL2DDVmvbgLU10EFtw9A4MRKyUY6sVhQ7HlHMedI=; t=1676579689; x=1677789289; 
        b=smygMcjA05EGHR8Mx6kqCfhAq26wKtaqBwJzxk5jbs+VrfYQlV7xRiSuHMZ8PlCCAq7lv072s4A
        pc/LvYegSF4bUKcSC3qUJQ2Z30pE0zld6WTizRK7j+il/sLV9OFlTYHEyHjlrbOiRY4x2N0+nCnXP
        o9F9QRLl5wLrq00FDq3gpo+jFSBpLPutqcqaPQXtjcFfnq6qoo2MoMHQrWDmPbVIPo+NmrE6vyTpL
        j3GIIeFJKR1sO5+yNlXr5Zb3aVqQdGToKPWUfF6rlZJyh/IuejUhPcP5YHL7JpCYjsr5+wguLzku5
        wyyrvMrPqLouLB9hG9ygJgWnLc125q5m94JA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSkxq-00EC3g-0R;
        Thu, 16 Feb 2023 21:34:46 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlegacy: avoid fortify warning
Date:   Thu, 16 Feb 2023 21:34:44 +0100
Message-Id: <20230216203444.134310-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are two different alive messages, the "init" one is
bigger than the other one, so we have a fortify read warn
here. Avoid it by copying from the variable-sized 'raw'
instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 4d3c544ff2e6..0a4aa3c678c1 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4020,7 +4020,7 @@ il4965_hdl_alive(struct il_priv *il, struct il_rx_buf *rxb)
 
 	if (palive->ver_subtype == INITIALIZE_SUBTYPE) {
 		D_INFO("Initialization Alive received.\n");
-		memcpy(&il->card_alive_init, &pkt->u.alive_frame,
+		memcpy(&il->card_alive_init, &pkt->u.raw,
 		       sizeof(struct il_init_alive_resp));
 		pwork = &il->init_alive_start;
 	} else {
-- 
2.39.2

