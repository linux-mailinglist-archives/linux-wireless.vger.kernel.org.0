Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC3573335
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiGMJpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiGMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16489E0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lJBSwg/SVx5pUshcnIiKChSII5Xqe79jbTlXiQEbcHo=;
        t=1657705512; x=1658915112; b=Usk93poo0tm+JmKQR5N4/oLXN8i3jDwhWLJ9s5Va/pjkB9l
        wL6ksV1rW/tqs1Ga3tGpLFYvPHWInXq8bsap50z5wP/O9DgCrUq1US4jq3WcL82vOpMv+sfcKOxcI
        LXnhlhEHMDH0WhfpZpgBzjNPvnuVOTvh4p1OdZ2Oh9la8RfSTP21WvTCmEP6GAaYDfsnQbU+CMqUg
        SeW8rdxz3/5pSiGwMMFpdcTUUFuQ1rYGiW1GkA2CQe+A61S3vqXzXrhk4Sb+fMQHIk2sRXrSf0xad
        ugL6v5UM6aSgvlIXxVEPIas35vvVrehjK93H8Gua+dK8epLSMxRQ3avSFWTCcc4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYve-00EgvB-Fe;
        Wed, 13 Jul 2022 11:45:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/76] wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS
Date:   Wed, 13 Jul 2022 11:44:06 +0200
Message-Id: <20220713114425.fa593e78de9a.I67a99fcbfcac0cefb4dcbb85e8b7d719b16d8a7c@changeid>
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

There are a few places that check ps_sdata and/or the dynamic
PS timeout, but they're erroneous in case SUPPORTS_DYNAMIC_PS
is set by the driver.

Skip the entire recalculation in this case so we cannot get
into those paths elsewhere, and so we simplify this for the
purpose of implementing MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 28bb7609cd4c..74676bbd6e23 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1818,7 +1818,8 @@ void ieee80211_recalc_ps(struct ieee80211_local *local)
 	int count = 0;
 	int timeout;
 
-	if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS)) {
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_PS) ||
+	    ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS)) {
 		local->ps_sdata = NULL;
 		return;
 	}
-- 
2.36.1

