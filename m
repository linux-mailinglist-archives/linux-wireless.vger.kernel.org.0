Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFB5F54D8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJENBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJENAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F51E3F4
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=opj3ISbWRjB+BL7Etw+VvOBUfpA49+i8J8umB2jgmcM=;
        t=1664974854; x=1666184454; b=c1RB+Xea1BMNN1KWeYs8MVGrgNLO8tDk7yMW0p6Q7KCHLkZ
        AZJmmvm9XDfhE4drPib2TmiUkJqf/jWMJ2YW65om7MdpX685PqftJIcwqWOM95ZmcUmchDUUI8Yyw
        Dz87ba1gsDuXJ+WyuP7ssCQrhmpQeC35Ewwke8vpmzGPiRRXqGn5ScdXGPI2/LaCfjPHhqOCynhHL
        sKKbZIQtSxNMRh4GMPXam4Wz2YRqs5Ysvqn0hNmblmEBqkRirOLXjJIbsMQQPE7BLbfTPdGzH2q+O
        SzKHbvGbU3fE9CfJFioyhq6TAE5p6Bf37dqvDk5VqTiMa99TQfhzacc8ciT3ITOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og416-00G2RL-1Z;
        Wed, 05 Oct 2022 15:00:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 08/28] wifi: cfg80211/mac80211: Fix ML element common size validation
Date:   Wed,  5 Oct 2022 15:00:28 +0200
Message-Id: <20221005145226.8b737f8d84a4.Id558683049f7d6b9c2e79e9e81b9aa0c01e6821e@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

The Multi-Link element can be fragmented, thus its size can exceed 254.
Thus, modify ieee80211_mle_size_ok() to use 'size_t len' instead of
'u8 len'.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 442b13333da8..b935a85b2f44 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4601,7 +4601,7 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
  * @data: pointer to the element data
  * @len: length of the containing element
  */
-static inline bool ieee80211_mle_size_ok(const u8 *data, u8 len)
+static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 {
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u8 fixed = sizeof(*mle);
-- 
2.37.3

