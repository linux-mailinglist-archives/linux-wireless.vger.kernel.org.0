Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB1529FAD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbiEQKpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbiEQKo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 06:44:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88539326D7
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=BObO6BJaMT7dTAEIwQTWGhVjByZmrwcvf0lp6lJBLHw=; t=1652784233; x=1653993833; 
        b=sbS9Mdn6B/dMqyCCMSNk65hta4u2gbpgdsHehRgaMKsL2QZEwY3O1TJ9BLyq4+VmbIbOYpKfOCv
        LK5n6o+CzemtmRvG9qy7+C/T3iwL6bCO5diBUkgw7Tp3BKhH90xWyoD+CujSXTpMD+EWiCiCP0Vhd
        tKKfUxmdMV9IKEEXMBZI9pHoOjW+rh5GpdMLOOZp1v6pokoSicztPER08/RXDyrh7i5q3t3feBXiF
        Qh0W8fXQNNurWSKF+/wd/9c1snSlAkMVDgkR3diq4HkxAl7ytM/n+ylZ7GUtC9sEM0bVddS8ckLrd
        P3dpZHdiCcZy4d6WLCWUuS5ukOc75T//WuLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nqug9-00ELOf-IM;
        Tue, 17 May 2022 12:43:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] cfg80211: fix kernel-doc for cfg80211_beacon_data
Date:   Tue, 17 May 2022 12:43:46 +0200
Message-Id: <20220517124345.d2020efa3a07.Ibe44080e86665722f16a9251ef21964cd2e7b8cb@changeid>
X-Mailer: git-send-email 2.36.1
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

The kernel-doc comment is formatted badly, resulting
in a warning:

  include/net/cfg80211.h:1188: warning: bad line: [...]

Fix that.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8b9d1d9c7ec4..1b52189ac3fb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1186,7 +1186,7 @@ struct cfg80211_mbssid_elems {
  * @civicloc_len: Civic location data length
  * @he_bss_color: BSS Color settings
  * @he_bss_color_valid: indicates whether bss color
-	attribute is present in beacon data or not.
+ *	attribute is present in beacon data or not.
  */
 struct cfg80211_beacon_data {
 	unsigned int link_id;
-- 
2.36.1

