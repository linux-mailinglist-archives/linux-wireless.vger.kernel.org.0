Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BAB77CFE9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjHOQJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjHOQJG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 12:09:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D110DC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ka+Gb4MoNtPn0x3n+d9xkLPQ15ynRQn2g7mEf1J/ioE=; t=1692115745; x=1693325345; 
        b=DCgDta+OwkBz877knvRExlCnpPX1nQZqu8iSbIsZa5jrFtdzFEHDykUD3CmwdlgdBTLP34SivvL
        6SK4674Cn+DDPS5eIXlH4h2L5MLZijwaylOEn9RaeXKVtqb6ZAhFf1CGuPi8m2MhYDnAmscokAb5a
        4ABIWSaXIDZciGXAlBidMEghNB73kTcg0SwdiO1RX8JVVFbvslXmQuQ7veYHmRjzspjvyBqctK2Ce
        YJcUTfww/Tf+ZdoUceABnkq1y5aiwCJ7On7V+ZP/SWoTRosv35Zsy2WlQc6SWppK9QhoTmSTbiduH
        DBwA3HJ6jZ5CQ/suLV09v03+NuzgHaWP8QqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVwbO-0091Po-2P;
        Tue, 15 Aug 2023 18:09:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: reject auth/assoc to AP with our address
Date:   Tue, 15 Aug 2023 18:09:00 +0200
Message-ID: <20230815180859.d9af625a795f.Iaf496e41e031d1821f4748e6735b6c977b762104@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the AP uses our own address as its MLD address or BSSID, then
clearly something's wrong. Reject such connections so we don't
try and fail later.

Reported-by: syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/mlme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index ac059cefbeb3..cd1d66016ba1 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -281,6 +281,11 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 	    ether_addr_equal(req->bss->bssid, wdev->u.client.connected_addr))
 		return -EALREADY;
 
+	if (ether_addr_equal(req->bss->bssid, dev->dev_addr) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	return rdev_auth(rdev, dev, req);
 }
 
@@ -342,6 +347,11 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
 		return -EALREADY;
 
+	if (ether_addr_equal(req->bss->bssid, dev->dev_addr) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	cfg80211_oper_and_ht_capa(&req->ht_capa_mask,
 				  rdev->wiphy.ht_capa_mod_mask);
 	cfg80211_oper_and_vht_capa(&req->vht_capa_mask,
-- 
2.41.0

