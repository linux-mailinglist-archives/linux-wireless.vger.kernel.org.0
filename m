Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654DD5F54D9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJENBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273DF1E3F7
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6DCFTkBpVp4dN+6vNMb8kCyMeKkUzaDaiA+IqZ6Oeos=;
        t=1664974855; x=1666184455; b=BcRhg5eXneMj3VSE523oI/nzPpIvANXhEroyN5jvj65IvVA
        mbHJ+WbnHeFR9PPpBqHiE4+ipYzHTZldxFe4w2i5pZQK4gOCe7tOK+g0b/5Qm1Tpu5Tqv9WCvFp2f
        Z1/F5HwVQJdVgtYibfVyVbplkwG8K54SFhGIK9Fu8jrbJkN8Zf0v1EsLShOtNGDlLDo4Q/agFkl3y
        Z85LWc46M4wQvSM0KkxOAaRwcXZ5e+nnoNlT7ERe/Z/MBo9hv2XRgbKIMCw4W8s4BdS1tnrpkIOdK
        V8Mz1pQ0AiMJNgoRPqnKN5xPtCHbmaQ0jr99ZIra/sAM0lCipWek/D3IDK8BMTGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og416-00G2RL-0h;
        Wed, 05 Oct 2022 15:00:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 07/28] wifi: cfg80211/mac80211: Fix ML element common size calculation
Date:   Wed,  5 Oct 2022 15:00:27 +0200
Message-Id: <20221005145226.5f77aeb1786d.I22b9114767b6579e57f15457fcfccb836d7681ea@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The common size is part of the length in the data
so don't add it again.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bdf668f9dace..442b13333da8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4573,18 +4573,17 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
-		common += sizeof(struct ieee80211_mle_basic_common_info);
-		break;
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
-		common += sizeof(struct ieee80211_mle_preq_common_info);
+	case IEEE80211_ML_CONTROL_TYPE_TDLS:
+		/*
+		 * The length is the first octet pointed by mle->variable so no
+		 * need to add anything
+		 */
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		return common;
-	case IEEE80211_ML_CONTROL_TYPE_TDLS:
-		common += sizeof(struct ieee80211_mle_tdls_common_info);
-		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
 			common += ETH_ALEN;
-- 
2.37.3

