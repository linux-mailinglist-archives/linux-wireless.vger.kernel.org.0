Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0D4D44F0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiCJKsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 05:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCJKsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 05:48:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373FC13EF93
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 02:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD4EDB82544
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 10:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A22C340E8;
        Thu, 10 Mar 2022 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646909232;
        bh=qQRV3jk8JunveVs8RMk5vfYKZvKWHUH+NACI5kP1oGk=;
        h=From:To:Cc:Subject:Date:From;
        b=tsDV8NfoC1kB77m5RJLHivMbK3g6LL/rbMBH0iHFQpiUe5LtqQJ4KsnjpiMEO7iaA
         J5Bq6DHzhIPtbs2Evf8q3908f2/lxO51wCI+PVp4R+FohUKRyU34XTbWXoYrQN2nRM
         l1ra4hrqp1EZlf33+ER0cHf0pTd6bpVSCGzqMYAI9dZM6WYQ7krA0b3psBYl72vkx1
         9C/YKBKQGOzm9SvYpaIxwkGZPRSuCFzvRxw4reHD9MPdxC1WYx/h8tulKCgwMxt5bp
         hCbzS6n+c4rOyEgw/ZjsBwOqMWGihspS2xS0TO7CmALzhw75cwF117J24bYCjU8ALM
         Gxl5skuH6wvCQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iw: print Radar background capability if supported
Date:   Thu, 10 Mar 2022 11:46:56 +0100
Message-Id: <1661d4de358d5ff8f6f8350eb165acf08f870951.1646909094.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/info.c b/info.c
index 3a45b3f..fa79ec7 100644
--- a/info.c
+++ b/info.c
@@ -702,6 +702,7 @@ broken_combination:
 		ext_feat_print(tb, 4WAY_HANDSHAKE_AP_PSK, "AP mode PSK offload support");
 		ext_feat_print(tb, BSS_COLOR, "BSS coloring support");
 		ext_feat_print(tb, FILS_CRYPTO_OFFLOAD, "FILS crypto offload");
+		ext_feat_print(tb, RADAR_BACKGROUND, "Radar background support");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
-- 
2.35.1

