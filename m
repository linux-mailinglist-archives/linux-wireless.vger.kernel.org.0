Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB7573334
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiGMJpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiGMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A4C04F4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0QXAjhtNKCNLBGSjrnu/gHm8SdohvgsRG4xI36+PkdY=;
        t=1657705512; x=1658915112; b=U0fggS+qGDMvXtrCjaZ9RK8/VULB7SMoEs8zetX4iukTsxZ
        W8tVJpn8W2nkmOMI3kKAftlJ7i+kIcmQfsxFT5BIwQt6jhBDDP/pZsUXpb1yYZ83hydTxEKrEuwo+
        ZdtHzoAIVcbdzixp5i2Z1EnVceXKB2/hDKzegxdeddTH8xddyVPGgc+d7U6ZbOo8sducOUmQzyN+E
        VIeddQRF38ArYbJjhdqKuz/VJJIm6EYmH0+IoiPTSS70H4VgEGILWEVPCbqzyy6hYoRv3/jqUaO9f
        kZuZ4rrqXq+jI0bQxcvwzm7GtLLt/8I6amoFw/DAOR1b0VsplB5toGcebM5SkWyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYve-00EgvB-8h;
        Wed, 13 Jul 2022 11:45:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/76] wifi: mac80211: debug: omit link if non-MLO connection
Date:   Wed, 13 Jul 2022 11:44:05 +0200
Message-Id: <20220713114425.b7500d0c97ea.Ie2d8ee2b81cdc3929768633b0e23b9de63fc43cb@changeid>
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

If we don't really have multiple links, omit the link ID from
link debug prints, otherwise we change the format for all of
the existing drivers (most of which might never support MLO),
and also have extra noise in the logs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debug.h | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index 3302e8da0314..b4c20f5e778e 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -135,14 +135,33 @@ do {									\
 	_sdata_dbg(1, sdata, fmt, ##__VA_ARGS__)
 
 #define link_info(link, fmt, ...)					\
-	_sdata_info((link)->sdata, "[link %d] " fmt, (link)->link_id,	\
-		    ##__VA_ARGS__)
+	do {								\
+		if ((link)->sdata->vif.valid_links)			\
+			_sdata_info((link)->sdata, "[link %d] " fmt,	\
+				    (link)->link_id,			\
+				    ##__VA_ARGS__);			\
+		else							\
+			_sdata_info((link)->sdata, fmt, ##__VA_ARGS__);	\
+	} while (0)
 #define link_err(link, fmt, ...)					\
-	_sdata_err((link)->sdata, "[link %d] " fmt, (link)->link_id,	\
-		   ##__VA_ARGS__)
+	do {								\
+		if ((link)->sdata->vif.valid_links)			\
+			_sdata_err((link)->sdata, "[link %d] " fmt,	\
+				   (link)->link_id,			\
+				   ##__VA_ARGS__);			\
+		else							\
+			_sdata_err((link)->sdata, fmt, ##__VA_ARGS__);	\
+	} while (0)
 #define link_dbg(link, fmt, ...)					\
-	_sdata_dbg(1, (link)->sdata, "[link %d] " fmt, (link)->link_id,	\
-		   ##__VA_ARGS__)
+	do {								\
+		if ((link)->sdata->vif.valid_links)			\
+			_sdata_dbg(1, (link)->sdata, "[link %d] " fmt,	\
+				   (link)->link_id,			\
+				   ##__VA_ARGS__);			\
+		else							\
+			_sdata_dbg(1, (link)->sdata, fmt,		\
+				   ##__VA_ARGS__);			\
+	} while (0)
 
 #define ht_dbg(sdata, fmt, ...)						\
 	_sdata_dbg(MAC80211_HT_DEBUG,					\
-- 
2.36.1

