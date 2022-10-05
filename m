Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C655F54E3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJENBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJENA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F9C1D32A
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fVhqgEEdPIVuH9X3f1Ttcpq5fk/s2BWkYAkWgSvhPyY=;
        t=1664974856; x=1666184456; b=evqFAnTdL4ULb+w8aF4vqOMowi7cyupoaCtvHFOeQ070nnq
        l+xz0gqFMNruhgeSEAiSNVQ5paqsUw0vHG2J0Ku9hQjDxVOTj6Ki/JhIglkDgr/7/CZRrgaqAQEPF
        d2Qx/oBXQfPox4H1HoFwPJabCYvFkkBfYcKwuRTZq8Stom9kc67rYAWFfSdVOOucrEKVvfcA0jGnW
        IxgMLNfiNGkBY44hLTrqFqDaSTO9SUb+ItFGDw48ssr6b5SGxCqz8cBizuRZ/AfFEUH8so7pwO85Q
        qW526Z0RdZ6lLmFB8ozRkszOZanbNciOR4zHoxtRR/HHnM+WeVtRqPCUhrpk6brQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og418-00G2RL-1u;
        Wed, 05 Oct 2022 15:00:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/28] wifi: mac80211: set internal scan request BSSID
Date:   Wed,  5 Oct 2022 15:00:36 +0200
Message-Id: <20221005145226.504bf975cde8.I3d9ceb29ef236af29c21efc573965ca4d5aed6a2@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

If any driver relies entirely on the scan request BSSID,
then that would be wrong for internal scans. Initialize
it to the broadcast address since we don't otherwise use
the field.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 46f3eddc2388..25e72812000e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1155,6 +1155,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	if (!local->int_scan_req)
 		return -ENOMEM;
 
+	eth_broadcast_addr(local->int_scan_req->bssid);
+
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		if (!local->hw.wiphy->bands[band])
 			continue;
-- 
2.37.3

