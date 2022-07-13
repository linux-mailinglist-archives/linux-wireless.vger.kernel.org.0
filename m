Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDC573348
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiGMJqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiGMJp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF068F6B90
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xjpNZliAd/V9glIkDdcmRImIMhNmiwn12ErW+RTqh3w=;
        t=1657705523; x=1658915123; b=CuJTEXQYYROqCze8Q0AdCyK0YDI8/wZHhAP3qQsMZVcr/eN
        +AS8YRpRmFUUjUN+G0lNORUhS21i5zSPqXNuScnF6Lau/lsROUivH+X0UN6XuWZBZVQbulEOdqHe7
        MktBnd/3ZgWy4+ggI4nk3F+eQYF3LvJM1o5/zHEyTYBl/9To2CJLP7NUYJVA8fDyvSTsdfEoPF5gv
        suCG1XfjojZz6uelMyADjBu3ELx40zC/XOguwCpcGASj2hkIRdBfHbjDZsQ5RUIqfCDkAtVnSb2bK
        IO1fWYUSm6Hi1H7+UIaWTKwV4We06Qe+ej0LWUdLbYvN1XoDoVyrrpzdpzAwYlFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvq-00EgvB-6J;
        Wed, 13 Jul 2022 11:45:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 49/76] wifi: mac80211: don't set link address for station
Date:   Wed, 13 Jul 2022 11:44:35 +0200
Message-Id: <20220713114425.f1264fe770d8.I56a551890a5b416dc98f9e9547e75d88c6dfa744@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

We need to handle the link addresses for station differently,
they will be determined by the association code, stored, and
then applied when the links are actually created on success,
cfg80211 will fill in the right addresses per the data we're
sending back to it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4b4a36692c68..fc5869f40279 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -409,9 +409,6 @@ static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
 			break;
 		case NL80211_IFTYPE_STATION:
-			eth_random_addr(link_conf->addr);
-			ether_addr_copy(sdata->wdev.links[link_id].addr,
-					link_conf->addr);
 			break;
 		default:
 			WARN_ON(1);
-- 
2.36.1

