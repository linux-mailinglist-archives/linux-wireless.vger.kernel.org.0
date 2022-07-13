Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B57573A39
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiGMPes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562341D3A
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bM5w5nfF6EkhHYX8Sz4nGkzE5bziwujdNy+U/ulO2cY=;
        t=1657726481; x=1658936081; b=oWjTSLWUQZ7AOPXeIdBty5OR4uMcH2Q9AJEo9PVxMqQFDSp
        mKZ5Vi8epy3OSfgEEMRbxVoyQpXMqbyC3iVgxNG3GGXRF/sWkTMneYUYU1swweD/byEJJUutWN5Jx
        bohxjFnUDLIZuXbrpoL78JMu5gD58ZJOuK7CwjitQrNLR2Siv1bW7DcZxMLjvRN31kQA65TtrsFlp
        psx8gB8CR0qHYX5wdrGRRc6RciVgJEb+xy0LT2RjsOhXsttwuVcn/dT4mgMkFxGJoPn6xpkhA3fIU
        M5C3a0wJgEO5MuHFwBuAqLQb3paRtudx9vj45EwF9mSVAc/Shnknd3rfqz1s0ZXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNq-00EnaA-Ve;
        Wed, 13 Jul 2022 17:34:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/21] wifi: mac80211: add multi-link element to AUTH frames
Date:   Wed, 13 Jul 2022 17:34:19 +0200
Message-Id: <20220713173301.8ce1b3fb7c9d.I8b2ece0e92aa8454f106730cac9d31a86495f540@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

When sending an authentication frame from an MLD, include
the multi-link element with the MLD address and use the
link address for transmission.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 994a49b892a6..b6ddcbbb22e8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1711,11 +1711,28 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
+	bool multi_link = sdata->vif.valid_links;
+	struct {
+		u8 id;
+		u8 len;
+		u8 ext_id;
+		struct ieee80211_multi_link_elem ml;
+		struct ieee80211_mle_basic_common_info basic;
+	} __packed mle = {
+		.id = WLAN_EID_EXTENSION,
+		.len = sizeof(mle) - 2,
+		.ext_id = WLAN_EID_EXT_EHT_MULTI_LINK,
+		.ml.control = cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_BASIC),
+		.basic.len = sizeof(mle.basic),
+	};
 	int err;
 
+	memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+
 	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
-			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN);
+			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
+			    multi_link * sizeof(mle));
 	if (!skb)
 		return;
 
@@ -1732,6 +1749,8 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.auth.status_code = cpu_to_le16(status);
 	if (extra)
 		skb_put_data(skb, extra, extra_len);
+	if (multi_link)
+		skb_put_data(skb, &mle, sizeof(mle));
 
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-- 
2.36.1

