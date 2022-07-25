Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1157FCAE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiGYJuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiGYJuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 05:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD851B84
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 02:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 616AC612AE
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 09:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F204C341C6;
        Mon, 25 Jul 2022 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658742612;
        bh=/LUsW1aykFRtvpZdgjYCBv8rbTHc01wQhDFAEz2beWk=;
        h=From:To:Cc:Subject:Date:From;
        b=rJC4MH8LOm+WXiEliqNrqD0BmIq9c3iK7WTBAgARr2XKEUm8SfdmWpUfFQ4UH/4Uk
         aXpHGE2dKMzSxa8q9zib9jPqUeIIZUw9xODS951yD0T/05Z6rjoXxQa7Ef6YuBjS6F
         Q+WUk2pFQ8sBjDbVY4YVlx9Uk7j1sS3yzIMp7ElOoBBjwOLwgIU2kTQnyVkvkwGjEV
         kmdjfmajI7mEjRtG5M60GppeRUcA4ZHBqG7AUtXTifFEN+WSPcLZFgcSP8/ModppIf
         6Qo2s1+DopLsP2YLgVCqW6MuLI+EJ7ejLrpEsOLzd2ewOvFZ7hOYWXynvsRsU4BC2a
         0o7x76p1f3OCQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix possible unaligned access in mt7915_mac_add_twt_setup
Date:   Mon, 25 Jul 2022 11:50:03 +0200
Message-Id: <439d9c01f6574dc021ce6eca4c8419a4e783d13e.1658742444.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Fix possible unaligned pointer in mt7915_mac_add_twt_setup routine.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 3782b69d03e71 ("mt76: mt7915: introduce mt7915_mac_add_twt_setup routine")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 60ae834d95a6..b9b74c706d2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2071,8 +2071,9 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 
 	flowid = ffs(~msta->twt.flowid_mask) - 1;
-	le16p_replace_bits(&twt_agrt->req_type, flowid,
-			   IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type |= le16_encode_bits(flowid,
+					       IEEE80211_TWT_REQTYPE_FLOWID);
 
 	table_id = ffs(~dev->twt.table_mask) - 1;
 	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
@@ -2122,8 +2123,9 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
 unlock:
 	mutex_unlock(&dev->mt76.mutex);
 out:
-	le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
-			   IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt_agrt->req_type |=
+		le16_encode_bits(setup_cmd, IEEE80211_TWT_REQTYPE_SETUP_CMD);
 	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
 		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
 }
-- 
2.37.1

