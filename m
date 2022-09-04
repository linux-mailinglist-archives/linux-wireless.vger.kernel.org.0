Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41775AC620
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiIDT3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiIDT3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3782E1
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aWTMKTni8LE38W0sPBEwDKc7LbsI4GZP/Z8aTMB/o1s=;
        t=1662319761; x=1663529361; b=Twe27cmbxFqWTF9lqRUcRSPuMbDH4eVUt5tgO7JdiTYGW8B
        ng2LBtq6zRkLtD3wxFL23lYNNrK8CgjzaRJLlJcNQBsvLI8ZMAZDYGtxVdq/j7wGkwgWwqopbyCEj
        j1W/qK1yJZl0S3NwYPtwTMwdUepXVqNP5zHi2L5UpSyJIj8gR1cVzLpYXQbqr/ZPLKzQ8ynyJaY8O
        iq9urxS00+1lZ+4Smep5Uor3ZJdvvwlUVFfkzSOsUlIIn3gW1H/EUjeMilalMcfSz6VqI0QZ7H7wv
        8o07De1auAy5JeZzPW37UfjpHDx6XYjWyCOWwjkPuQp8TLtUNOQ0YIx9V+cQCt5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvIz-007pTZ-21;
        Sun, 04 Sep 2022 21:29:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/12] wifi: libertas: fix a couple of sparse warnings
Date:   Sun,  4 Sep 2022 21:29:03 +0200
Message-Id: <20220904212910.76c34b2ae7a0.Ieb97c72b6d26f9d695cc4ab10fa7af5c3509612b@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

 - endian swapping is required in one place, use the
   already swapped 'bsssize' local
 - lbs_disablemesh need not be exported and can be static

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c  | 2 +-
 drivers/net/wireless/marvell/libertas/main.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 5e3ae00153b8..3e065cbb0af9 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -546,7 +546,7 @@ static int lbs_ret_scan(struct lbs_private *priv, unsigned long dummy,
 	pos = scanresp->bssdesc_and_tlvbuffer;
 
 	lbs_deb_hex(LBS_DEB_SCAN, "SCAN_RSP", scanresp->bssdesc_and_tlvbuffer,
-			scanresp->bssdescriptsize);
+		    bsssize);
 
 	tsfdesc = pos + bsssize;
 	tsfsize = 4 + 8 * scanresp->nr_sets;
diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 5c9f295536ea..8f5220cee112 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -39,8 +39,7 @@ unsigned int lbs_debug;
 EXPORT_SYMBOL_GPL(lbs_debug);
 module_param_named(libertas_debug, lbs_debug, int, 0644);
 
-unsigned int lbs_disablemesh;
-EXPORT_SYMBOL_GPL(lbs_disablemesh);
+static unsigned int lbs_disablemesh;
 module_param_named(libertas_disablemesh, lbs_disablemesh, int, 0644);
 
 
-- 
2.37.2

