Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04156573332
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiGMJp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E40BFACF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YsOAagzrDZwSOgmh3robiZfSaIhx3MZUpw86AdzFWpY=;
        t=1657705511; x=1658915111; b=q1p1TllB+8pe1owvx8kRW7qyEjuOVYGpl0SKlfcrRvwj37x
        EpZtzhQmbKEdMZGxM+aASWIgzUeUKDwEmexn2ZY/8zfGMFEDTP1wqpp/A7At7RD9vcMpvzeXXTcPK
        LgoSM/trQA/ycZSOe+ngVDwf6u9QHM64tWSo9tkBDTfRzC4PJ6Ae5Wxkk0WjFe5CqU7oPrdVL8Ks7
        UY3PrJsRENGQn7StL02kp+DWoyMI1hkbvIaOzm2co/MUDaDzIS3mzelUbUKCV1bUSdpYoQfvP2SIe
        s+eyo0mGa1Opc8bvbxRUdRNV3vrVkHsx0+OAVcs3AXz1NxBFXGTvMiMo7Zy4v2aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvd-00EgvB-90;
        Wed, 13 Jul 2022 11:45:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/76] wifi: cfg80211: make cfg80211_auth_request::key_idx signed
Date:   Wed, 13 Jul 2022 11:44:02 +0200
Message-Id: <20220713114425.df55e53b473d.I37ad568e7118b4a8a93f5317d0f0ab5a8c164cf5@changeid>
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

We might assign -1 to it in some cases when key is NULL,
which means the key_idx isn't used but can lead to a
warning from static checkers such as smatch.

Make the struct member signed simply to avoid that, we
only need a range of -1..3 anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d4632b391a15..e50b93160319 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2773,7 +2773,8 @@ struct cfg80211_auth_request {
 	size_t ie_len;
 	enum nl80211_auth_type auth_type;
 	const u8 *key;
-	u8 key_len, key_idx;
+	u8 key_len;
+	s8 key_idx;
 	const u8 *auth_data;
 	size_t auth_data_len;
 	s8 link_id;
-- 
2.36.1

