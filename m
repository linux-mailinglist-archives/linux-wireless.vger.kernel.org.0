Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F65F54EA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJENBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJENA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5671D663
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9DTdBz87CIypZzhfBTMxZ7rMsSBwZddg8jrdWGddVmw=;
        t=1664974858; x=1666184458; b=hzNc34759PuI1Dy8+pux2IHER9FdigtAtJWX/QZlpMqhkbi
        fSNhqWgn0+kp2CS0AohYTCDgGP/5dESiy7p5AesekTmvycBEt+9f2NWVyQDedgX/FE0EgYdpHeaWg
        plDZOcF7mqZEIAqY9ZEdg49vbLV6hDARwSsYasTSFgWOsDCVF4/O9DZ/UskOnXf1d+ji4tr/HmJ3n
        D+uhVJmGJM3xJMz7Ipmh849j4IVJoPk+lDVdsU3J9/OUzeGsVNn0Df6USsVERUU79NdBt1udK1nH9
        eoDC5LcrVRta2DUAE+gdm+dFaYS+8eaSjngREvve8+ECblPywMoMp2WFmiH0UDYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41A-00G2RL-0G;
        Wed, 05 Oct 2022 15:00:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 22/28] wifi: mac80211: mlme: mark assoc link in output
Date:   Wed,  5 Oct 2022 15:00:42 +0200
Message-Id: <20221005145226.73fd1a760623.Ib55c8ace1ec178ed947e7ea061816dea891df987@changeid>
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

It's useful to know which link was used for the association,
mark it when printing the links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c46f355265ee..50a376f86ec2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4946,9 +4946,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 		if (sdata->vif.valid_links)
 			link_info(link,
-				  "local address %pM, AP link address %pM\n",
+				  "local address %pM, AP link address %pM%s\n",
 				  link->conf->addr,
-				  assoc_data->link[link_id].bss->bssid);
+				  assoc_data->link[link_id].bss->bssid,
+				  link_id == assoc_data->assoc_link_id ?
+					" (assoc)" : "");
 
 		link_sta = rcu_dereference_protected(sta->link[link_id],
 						     lockdep_is_held(&local->sta_mtx));
-- 
2.37.3

