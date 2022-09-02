Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF55AB414
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiIBOuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiIBOti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:49:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228EA135D29
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Dsn2QMq9+S5IlN6y1o2tvi/ltCs0rYEEpGK2/In5k1U=;
        t=1662127883; x=1663337483; b=SrAs31VO18crpV/wlS4LOtBzXRh9uDQWqSpyt0BnheM6YkO
        2gn3Hi17zJ6zJsckmv8fwgI5EJTp0CllbPV93sVp10rzf4zqpxddsyC8wB0Tply1/TywDMKsrcfC2
        ljrUeWUwU464FS4A3hpe7z79r3qExrcuLJ+YMEV11vaBjFPmWeh1jkDI1S6FCOGTKv/6YP/+xEXFv
        j3zh52yoNizIZSdg7GC/sf1SEybBUpBULBTEk9k7uIGtb//SShoMPILsSjab+dofbbxJWlJXp5L97
        uDGFexKjmjjSIS/uXXvksfgsd3QTpa054/b+TeA/JGrPirghxPJQl+lUto+WdrbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7OC-006Cfn-1U;
        Fri, 02 Sep 2022 16:11:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: mlme: release deflink channel in error case
Date:   Fri,  2 Sep 2022 16:11:15 +0200
Message-Id: <20220902161058.c6e40e0c38c1.I97c1d24d4f526d3d5e41398a2a56de7255f725c2@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902161058.7d5f399c88d3.I1c257b1c7a8309a9f9b96654c0e71bcf4b247b98@changeid>
References: <20220902161058.7d5f399c88d3.I1c257b1c7a8309a9f9b96654c0e71bcf4b247b98@changeid>
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

In the prep_channel error case we didn't release the deflink
channel leaving it to be left around. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4555d23b009e..13d075e6a318 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6549,6 +6549,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	return 0;
 
 out_err:
+	ieee80211_link_release_channel(&sdata->deflink);
 	ieee80211_vif_set_links(sdata, 0);
 	return err;
 }
-- 
2.37.2

