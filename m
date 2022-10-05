Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831835F54DD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJENBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285801EC5C
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GujKab8TBG7vuyXwNHTACuM5NBxz65biyCHTWfa7zrY=;
        t=1664974855; x=1666184455; b=siK/Sbi9NTSGTCvwp89Cby/9XnM7htQ4zKJIT71+xiJ+TuH
        mKgtLCAkBs3VVvLxYQRGGbLdnfK3lpjWZ4iT+sOd8HGrzT8kb7X9blGpqmKvwVX6GmdMFPJT9Xwrz
        4t29uERH8+FwIFhknD84ROrsF9qTVh0gLwosUNiCov1aJfFrLKw40mA9Zec8UqZmyZF7Rq7zPFyTQ
        2GUUxPNrqScQjKxtWo4SJ/S/d8hoLo/G7BH7sHT3qJORAmNz5f4eJ5OBr00ch81wvavje8yqmFXUF
        gi+OkSt+4SOs4Y9mxhk+0Lt0ynd3KHIdL0SakkPm/ZJMwpALzXXz9YvGqEJ3luUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og417-00G2RL-0v;
        Wed, 05 Oct 2022 15:00:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/28] wifi: mac80211: wme: use ap_addr instead of deflink BSSID
Date:   Wed,  5 Oct 2022 15:00:31 +0200
Message-Id: <20221005145226.3270406f08ac.Iba00b0fc46614689b2241c1b7a86734aa9b9f580@changeid>
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

We use this to look up the destination station, so it
needs to be the MLD address of the AP for an MLO; use
ap_addr instead of the BSSID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/wme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index ecc1de2e68a5..9fab97f6fbea 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -211,7 +211,7 @@ u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 		if (sta)
 			break;
 
-		ra = sdata->deflink.u.mgd.bssid;
+		ra = sdata->vif.cfg.ap_addr;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		ra = skb->data;
-- 
2.37.3

