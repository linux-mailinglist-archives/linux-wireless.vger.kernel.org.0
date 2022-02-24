Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194EC4C2B3F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiBXL4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 06:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiBXL4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 06:56:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2F254569
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 03:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EA2861874
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 11:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD45C340EF;
        Thu, 24 Feb 2022 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645703742;
        bh=v7JT792GZb9ZDhpBQladCImKtYOivVYsLE3WX2yNUlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg5Xqr+7c/t7WJsHOtoYkZVHngW5fjefkOa9UESgYQJw29LXVlab6oZ9P7wPcnHTF
         XsG9q+KxUqYPQxxka6y5GgyjqsfP4nS5/jrvyE/UR85dvNqPaTywltbgNwKoXXAExT
         D3+jp6o3sMskFr+wmBB55PNsr6TJIKQdkPhvTAKesH3QngzW5oGB+kmP9WvNC+4uAU
         EtqONFr62HC8Smk11ciE4LS7qUwdC6fNDQjIlgVvO81Rkr45kpB6rxwvmCxB4jYCRp
         wtxhxMz1zeeh9EPbzrBZLLipwctua/gkW023J676Gnz90mvj6B5sDY0Kk2qB5QFH9S
         zYA3aKNvOYuYA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        quic_alokad@quicinc.com, john@phrozen.org, nbd@nbd.name,
        ryder.lee@mediatek.com, money.wang@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v14 mac80211-next 3/3] mac80211: update bssid_indicator in ieee80211_assign_beacon
Date:   Thu, 24 Feb 2022 12:55:00 +0100
Message-Id: <f92317e002fca9933f05a445fcefb4f53291d601.1645702516.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645702516.git.lorenzo@kernel.org>
References: <cover.1645702516.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update bssid_indicator in ieee80211_bss_conf according to the
number of bssid in the set.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/cfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 464d2896fbbc..9ecccacafc62 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1071,6 +1071,9 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		new->mbssid_ies = (struct cfg80211_mbssid_elems *)pos;
 		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
 		ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies, mbssid);
+		/* update bssid_indicator */
+		sdata->vif.bss_conf.bssid_indicator =
+			ilog2(__roundup_pow_of_two(mbssid->cnt + 1));
 	}
 
 	if (csa) {
-- 
2.35.1

