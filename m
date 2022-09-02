Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56CA5AB433
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiIBOvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiIBOvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3BD11E9
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Iy+CTgre9YIFNysf5OVP84n8QeXNgWna12rnUwmorsM=;
        t=1662127996; x=1663337596; b=FKCBrmufRBtzin4Y7VIWV75CSQDQlhPKh1V2GZSTcsVys60
        zhWDYR9X64l3TCwaU1PDjcbdxDcEybaJaaYqEyStFhmwwMvhHKQI5GSkroIqkIuekcVpb0218kFVd
        mad4n69vqvIYS+73XBCHgI/ucfUUVB4cQwJ4MT8s/qY5ge74L0Eur+yE1PfABvJl7EzcEXFVFUa14
        cb8vTvn7nkPdOy2XnNxJeTYTX3QVTmPjzLiDLhV5YYiYcvLyf5OVwVjjsOI3mwR+gJ1U9r3hUOXUW
        AjmSPx45qvvawr74zwyL+1B/Gupi3XHZHXhCkxAEmcgys4OsebrPdcNSgS8ZmqGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Q2-006Ch3-2C;
        Fri, 02 Sep 2022 16:13:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 26/27] wifi: mac80211: prevent 4-addr use on MLDs
Date:   Fri,  2 Sep 2022 16:12:58 +0200
Message-Id: <20220902161143.f2e4cc2efaa1.I5924e8fb44a2d098b676f5711b36bbc1b1bd68e2@changeid>
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

We haven't tried this yet, and it's not very likely to
work well right now, so for now disable 4-addr use on
interfaces that are MLDs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c  | 7 +++++++
 net/mac80211/mlme.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b5522edbe05d..687b4c878d4a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -226,6 +226,10 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 		if (params->use_4addr == ifmgd->use_4addr)
 			return 0;
 
+		/* FIXME: no support for 4-addr MLO yet */
+		if (sdata->vif.valid_links)
+			return -EOPNOTSUPP;
+
 		sdata->u.mgd.use_4addr = params->use_4addr;
 		if (!ifmgd->associated)
 			return 0;
@@ -4697,6 +4701,9 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	if (wdev->use_4addr)
+		return -EOPNOTSUPP;
+
 	return ieee80211_vif_set_links(sdata, wdev->valid_links);
 }
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8a2237106002..ff449e0c2e62 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6903,6 +6903,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
 		size += req->links[i].elems_len;
 
+	/* FIXME: no support for 4-addr MLO yet */
+	if (sdata->u.mgd.use_4addr && req->link_id >= 0)
+		return -EOPNOTSUPP;
+
 	assoc_data = kzalloc(size, GFP_KERNEL);
 	if (!assoc_data)
 		return -ENOMEM;
-- 
2.37.2

