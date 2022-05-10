Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAA521D78
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiEJPJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiEJPIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 11:08:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18C2C131
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=w4W/7mgtIWwHG66i01hyrUtW3ca+nIN+5BQqyjtauoo=; t=1652193505; x=1653403105; 
        b=cdQQOZl14GGXvQrJivkszLjzEe8ekAZapeZppXYo+IgKByuHvwjs+dXebB51QCC4h0GIkYEHeT0
        bKEurIK1GZxjMQNRMhWTMPdjv3pg4T9r3c+418jGmBbn4pxdCtbW65DOuh6L3uDZmFBfEqGyyOxjt
        0kEln/SzwtegCwZc3dJ2B1iiTH+6C3jJMZTxuhc8HKoaUi9Mfo13QPgaDjTJuKtW0bJFKhrarLqpb
        uo5poUspIo0d00pzrR8xcZrnZ3ROgZlT5DomCtIbd0ybCU78MK5WKQspHTHXPlSuRQmw/jhgtyiod
        C2qjn+JEc1TNRkcUgeFc44WaL6PiMyKnJVAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noR0H-007plT-M8;
        Tue, 10 May 2022 16:38:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: remove stray multi_sta_back_32bit docs
Date:   Tue, 10 May 2022 16:38:19 +0200
Message-Id: <20220510163819.8fd0ce20586d.I7cc68ee1d9786b47b96ae266039b579c54df83d1@changeid>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This field doesn't exist, remove the docs for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c887db9524a1..f152e725724a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -514,7 +514,6 @@ struct ieee80211_fils_discovery {
  * to that BSS) that can change during the lifetime of the BSS.
  *
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
- * @multi_sta_back_32bit: supports BA bitmap of 32-bits in Multi-STA BACK
  * @uora_exists: is the UORA element advertised by AP
  * @ack_enabled: indicates support to receive a multi-TID that solicits either
  *	ACK, BACK or both
-- 
2.35.3

