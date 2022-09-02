Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA15AB421
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiIBOvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiIBOvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518B61D85
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ok0HDtDYudgcWjKSmwSS3/DuI1i+c2eEBX6M/Txs0Qo=;
        t=1662127986; x=1663337586; b=hTQ0U6JWhTZYV4/uwgl53wRDY9Y5ARWVEm6sFRlZyipzet2
        kC7gkYPkBpT0lRpy2LQT9vxUDIcEG4rgO3hvRwhG6sr7hhUft3v7dl8Hr75pcBBSD/y+5hkweQpSj
        elkqol9TnhuWvqLfnlkENRV5R0dT7M+5H/Oi51L0kHjp54nO72CDig7jlhIOd40jEWR0zqqE6df7w
        CREmuXgzq95fpxDf12kH7AzfSS3r5+V7nUwW24XJPKlFFqfH+1Ex0il+BwpGcBLdO2TrZ4upsqUha
        716lkpaNZ0UfrGqqzI2NVsqTTdB2V5wgqa2IgSzzoNty8sv28zW132FqxYlBQacQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pr-006Ch3-1X;
        Fri, 02 Sep 2022 16:13:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/27] wifi: mac80211_hwsim: check STA magic in change_sta_links
Date:   Fri,  2 Sep 2022 16:12:35 +0200
Message-Id: <20220902161143.05f3fcf0d10f.Ie97f4d0615e75fbf1f73a41dc915503a93864aaa@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

Just as an additional check that mac80211 isn't doing
anything strange, add a check of the STA magic (which
gets assigned when the station is added, and cleared
when the station is removed).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 87176b205fc1..48b1c39c1c05 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3021,6 +3021,8 @@ static int mac80211_hwsim_change_sta_links(struct ieee80211_hw *hw,
 					   struct ieee80211_sta *sta,
 					   u16 old_links, u16 new_links)
 {
+	hwsim_check_sta_magic(sta);
+
 	return 0;
 }
 
-- 
2.37.2

