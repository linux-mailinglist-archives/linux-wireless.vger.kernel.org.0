Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522B697903
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 10:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjBOJcO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 04:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjBOJcN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 04:32:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A01C7C1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 01:32:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD00761A2D
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D001BC433EF;
        Wed, 15 Feb 2023 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676453532;
        bh=cClIkOctlWElK5vaJXM4eYA5v0qP1twN7CXTuO4rgEo=;
        h=From:To:Cc:Subject:Date:From;
        b=Xxu48NA6NTGydoOorlpLVLv11+35Bg5X+X919qZYUkYqAk5gGzxKImDfnti1ZKXQh
         T22ZMLqtXlrlGIXmAag32a9Mo3BTQaZ98ZdrxJxjR15GhfwnIV9Bj19I7eM64YWYTq
         AcdfNpNiLvgwOzkDkozdl/m5thHWLbS3yfOkeaG1tXXpHO004BEFqP/9sGz7dojmAu
         K4Ue04iaRSYjBurctUcTWjB6JFA0yS9X3tk5foW/QllcbnHv1ZIfED1l0rKacGLuPi
         MogYATRW0a94xOywJlnZaEGx6RLarn43kcKjgOk0EcjbTNjlvEpYW7TaG5T2eBBZ0r
         PQX4tUhPC/sTA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: [PATCH wireless-next] wifi: cfg80211: remove gfp parameter from cfg80211_obss_color_collision_notify description
Date:   Wed, 15 Feb 2023 10:32:07 +0100
Message-Id: <2da652e2cd5c7903191091ae9757718f1be802a1.1676453359.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of gfp parameter from cfg80211_obss_color_collision_notify
routine description.

Fixes: 935ef47b16cc ("wifi: cfg80211: get rid of gfp in cfg80211_bss_color_notify")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 15fb019ce28d..f115b2550309 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8951,7 +8951,6 @@ int cfg80211_bss_color_notify(struct net_device *dev,
  * cfg80211_obss_color_collision_notify - notify about bss color collision
  * @dev: network device
  * @color_bitmap: representations of the colors that the local BSS is aware of
- * @gfp: allocation flags
  */
 static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
 						       u64 color_bitmap)
-- 
2.39.1

