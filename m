Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F612653D92
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 10:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiLVJi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 04:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLVJit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 04:38:49 -0500
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 01:38:47 PST
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B482791C
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 01:38:47 -0800 (PST)
From:   Nick Hainke <vincent@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1671701449;
        bh=XYHDEfQRMug+Rp94MysU/jvPr3SX4XzhiDB+0Ghx+XY=;
        h=From:To:Cc:Subject:Date:From;
        b=5eqwfdTdf4XMr1ILvmysy8C3DyR6KJEh0I8aLVbVUnAjXz9z9T/jBoDahk37aPvB3
         pkh3KbQl2HYiZxq54uCCuUztLPVsY5fa/1uow2cx1zPiWooSMIyoR00rGwJTsd+nlm
         ABEdYES/XoqkPQftLRk5cMLpMBYOyNAONDutVY611eHcNrFqJY/wkeHmSlKb4XZqMc
         DMQ+Ji4NIkMK/h0hJwDeabZj5LlRgWiYH1O3VxebxgoR+j7NVJJE+yIqTb1bI+GZz0
         CN63rYZsWE5inGToNct7ZBP8YXr7p4T2bHh/+tjNzOaydvUR9pc7iplt9DAsPBYekO
         NoikgrXMFKU4Q==
To:     johannes.berg@intel.com, linux-wireless@vger.kernel.org
Cc:     Nick Hainke <vincent@systemli.org>
Subject: [PATCH] wifi: mac80211: fix double space in comment
Date:   Thu, 22 Dec 2022 10:29:57 +0100
Message-Id: <20221222092957.870790-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove a space in "the  frames".

Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f9a2ab502b3..c885076fae89 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2727,7 +2727,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * If the scan has been forced (and the driver supports
 		 * forcing), don't care about being beaconing already.
 		 * This will create problems to the attached stations (e.g. all
-		 * the  frames sent while scanning on other channel will be
+		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
 		if (sdata->deflink.u.ap.beacon &&
-- 
2.39.0

