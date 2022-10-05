Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A285F54DA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJENBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJENA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CA1EADB
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jEhiElCFmVtcWg+9ubB5wrltCsmRN3NGIOEPy4XofxM=;
        t=1664974854; x=1666184454; b=RTMgKL/9fXkHHKTgUBq/Q2FzaON0NsmOSqTaqBCeKx7z4pH
        dafr9f+VoJ8KE9JrnIEQ9uSMWfdWFDo0tXJQ9WCTcxe7QFobsM3wcdpjx1gojy5iJMTC4mLM6qRCQ
        VvGOFR19cD+silzEP+hQgRKhdiCu1FD9O3LX0EV+W0MdY8aFa4rmLuXFeEeBf4srtkSKmdqEi6Djc
        jhU24U1Y2aZJPj4BMoMQJ3K6HX5nKXVFVlaUXS0+CvW2SnSKQHtwfw/pnyAowy4g1wzlCE8ScEOE3
        mNTjow1bcHy3HUeB+woIgA0aSjcK0lq0aPeJVBe1rubGgR85wrw0s/GJ22DcoY9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og415-00G2RL-3A;
        Wed, 05 Oct 2022 15:00:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 06/28] wifi: ieee80211: Support validating ML station profile length
Date:   Wed,  5 Oct 2022 15:00:26 +0200
Message-Id: <20221005145226.b698f2719c6b.Id5f39b418dc91617378ae448a75e573f3146ec80@changeid>
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

Add a function to validate EHT Multi-Link per station profile length.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 79690938d9a2..bdf668f9dace 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4685,6 +4685,46 @@ struct ieee80211_mle_per_sta_profile {
 	u8 variable[];
 } __packed;
 
+/**
+ * ieee80211_mle_sta_prof_size_ok - validate multi-link element sta profile size
+ * @data: pointer to the sub element data
+ * @len: length of the containing sub element
+ */
+static inline bool ieee80211_mle_sta_prof_size_ok(const u8 *data, size_t len)
+{
+	const struct ieee80211_mle_per_sta_profile *prof = (const void *)data;
+	u16 control;
+	u8 fixed = sizeof(*prof);
+	u8 info_len = 1;
+
+	if (len < fixed)
+		return false;
+
+	control = le16_to_cpu(prof->control);
+
+	if (control & IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT)
+		info_len += 6;
+	if (control & IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT)
+		info_len += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT)
+		info_len += 8;
+	if (control & IEEE80211_MLE_STA_CONTROL_DTIM_INFO_PRESENT)
+		info_len += 2;
+	if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
+		info_len += 1;
+
+	if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE &&
+	    control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE) {
+		if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE)
+			info_len += 2;
+		else
+			info_len += 1;
+	}
+
+	return prof->sta_info_len >= info_len &&
+	       fixed + prof->sta_info_len <= len;
+}
+
 #define for_each_mle_subelement(_elem, _data, _len)			\
 	if (ieee80211_mle_size_ok(_data, _len))				\
 		for_each_element(_elem,					\
-- 
2.37.3

