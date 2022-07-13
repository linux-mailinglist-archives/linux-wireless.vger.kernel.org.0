Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAEE57336A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiGMJqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiGMJpe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0EBFAEB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tenSZWeuOGMdi7jW7hKWhy9SodxPJDG05UmrTfBIZgo=;
        t=1657705526; x=1658915126; b=MYnCJWEYgoORZLiaoeIcjJ0qJ2lfJI7e+Iucjd2A+9GUyEI
        OY4UpP2FOGpDCJzTDKBghnFYunzKBIw1nx84A/A9yk52uwmjFkRhw1WQGErhaPkp8W7qO0rXgn6SC
        +v5wxQRXpaZZZjrouKSqrQiE+SzADZotfJz6n9sRQxIJ/3tA7tDlMhaxoKnm08GeaYF2iLkI19/tx
        zInQwbR+hU5BONYcK3LGxSmcSsVZHa3z9qS4vjbpLEaNKdaZf6ZxWiPMY4j98bGth2QWsy+1/a2GN
        kGE//iw4my4D3FM4AeFYteb64c4g9X7US7g5hP9D03a2bK/BvoCSGzLy+Jb7qiMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvs-00EgvB-KU;
        Wed, 13 Jul 2022 11:45:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 56/76] wifi: mac80211: consider EHT element size in assoc request
Date:   Wed, 13 Jul 2022 11:44:42 +0200
Message-Id: <20220713114425.1002d927b883.Id031d730eddd29d80c86071d5c3b548c1a81ca61@changeid>
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

We need to consider the (maximum) size of the EHT element
we'll add for the association request, otherwise we may run
out of space.

Fixes: 820acc810fb6 ("mac80211: Add EHT capabilities to association/probe request")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b56f2cefee44..f83d361ad50d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -987,6 +987,9 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 				sizeof(struct ieee80211_he_mcs_nss_supp) +
 				IEEE80211_HE_PPE_THRES_MAX_LEN +
 			2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
+			2 + 1 + sizeof(struct ieee80211_eht_cap_elem) + /* EHT */
+			sizeof(struct ieee80211_eht_mcs_nss_supp) +
+			IEEE80211_EHT_PPE_THRES_MAX_LEN +
 			assoc_data->ie_len + /* extra IEs */
 			(assoc_data->fils_kek_len ? 16 /* AES-SIV */ : 0) +
 			9 + /* WMM */
-- 
2.36.1

