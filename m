Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C334AA2BC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiBDWDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiBDWDG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:06 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D70C061741
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ExuNEQHIJjq2Vyg+YS2kPV2HphLdh+YZuJdO78OUhJg=;
        t=1644012185; x=1645221785; b=wi8jYXCYtVC+C/2X0LCZOSsjFLTprGcTVAfRXSx8wTj+Ajo
        gvUhENY/Ne+Ec7iCUA+XToQYQuiMz2oOOl14lS8I8d/WcoqR2Td7p9Sy/oYXdr3Jf9QdnmCSmcPVQ
        hiSSRTFNXo6wsVtya+GVIXLxBpsX6FKTtIytN5pT68stXjjTMldnX4PbDTgPV1GUAtn+v2DA3ZXRa
        Yup+YOpKAL2g9VI01X8NW15yAPgu3cchT2ML3rsHHCqiFRXmdZKlnLIU/RhSasvLXMkzfmluo+8fl
        siq9rLoyNMmKv07C5rCRw0qda9011Qmn2uxGVDdPZegbtRjco0J4G0G0283XIV/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fX-00EeJL-W6;
        Fri, 04 Feb 2022 23:03:04 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 12/19] mac80211: Support parsing EHT elements
Date:   Fri,  4 Feb 2022 23:02:48 +0100
Message-Id: <20220204230119.b89704dbefc9.Ib6beb1aa85e25b71ce40d3260b2e5b117cc42308@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
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

From: Ilan Peer <ilan.peer@intel.com>

Parse the new EHT elements in the element parsing utilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/util.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index da35791b8378..538d047d7f27 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1587,6 +1587,8 @@ struct ieee802_11_elems {
 	const struct ieee80211_s1g_oper_ie *s1g_oper;
 	const struct ieee80211_s1g_bcn_compat_ie *s1g_bcn_compat;
 	const struct ieee80211_aid_response_ie *aid_resp;
+	const struct ieee80211_eht_cap_elem *eht_cap;
+	const struct ieee80211_eht_operation *eht_operation;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1608,6 +1610,7 @@ struct ieee802_11_elems {
 	u8 bssid_index_len;
 	u8 tx_pwr_env_len[IEEE80211_TPE_MAX_IE_COUNT];
 	u8 tx_pwr_env_num;
+	u8 eht_cap_len;
 
 	/* whether a parse error occurred while retrieving these elements */
 	bool parse_error;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index abc29df6834c..430614aff289 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1006,6 +1006,16 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		if (len >= sizeof(*elems->he_6ghz_capa))
 			elems->he_6ghz_capa = data;
 		break;
+	case WLAN_EID_EXT_EHT_CAPABILITY:
+		if (len >= sizeof(struct ieee80211_eht_cap_elem)) {
+			elems->eht_cap = data;
+			elems->eht_cap_len = len;
+		}
+		break;
+	case WLAN_EID_EXT_EHT_OPERATION:
+		if (len >= sizeof(*elems->eht_operation))
+			elems->eht_operation = data;
+		break;
 	}
 }
 
-- 
2.34.1

