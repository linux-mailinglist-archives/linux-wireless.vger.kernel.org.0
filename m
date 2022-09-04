Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052BB5AC623
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiIDT3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiIDT32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE426B06
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=B8SI0E2hnpzDhiu//tK/sDIPcyBjMkdBfArPwseBvIU=;
        t=1662319761; x=1663529361; b=gPjI4XgEX6tua194A6nS3pcZPAXt88L4J3041csFSdR9Za6
        AqHlUFkvO6NR5bMTaqrxscbdQDFgkWS5sSDClShe/IfvXIPvS4Ki0rXpQVmRKhp8eeaC8rG9X7LaT
        Z3gI0qV3+guAEmmad2X3YyW0vm1RjFH3gCRYCe94Kvfnak0IzGmf5ZVoExxWEuKDWCuPBGNVa/hYL
        6eDycwzKVLHyrl+aICy21YF24AJ0dRqCIFGXejv9Ku7MYr47IRoFGzEbeXd3CSo9hjGCiN4pTCupi
        8kwzv7ngqWSPFjHAaMRi9dJrUJAa7LaOc1f8AAelX5vnc5QfD0zgcd/i71ow1J7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ1-007pTZ-0s;
        Sun, 04 Sep 2022 21:29:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/12] wifi: mwifiex: fix endian conversion
Date:   Sun,  4 Sep 2022 21:29:08 +0200
Message-Id: <20220904212910.a32e45adb2b2.I8c966b07c0bf7be4485967b044d9dad3f4772a27@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Clearly the value should be converted and then compared,
not the result of the comparison be converted. No binary
changes on x86.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index b95e90a7d124..b6315fccd1bb 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -623,7 +623,7 @@ mwifiex_fw_dump_info_event(struct mwifiex_private *priv,
 		adapter->event_skb->data, event_skb->len);
 	adapter->devdump_len += event_skb->len;
 
-	if (le16_to_cpu(fw_dump_hdr->type == FW_DUMP_INFO_ENDED)) {
+	if (le16_to_cpu(fw_dump_hdr->type) == FW_DUMP_INFO_ENDED) {
 		mwifiex_dbg(adapter, MSG,
 			    "receive end of transmission flag event!\n");
 		goto upload_dump;
-- 
2.37.2

