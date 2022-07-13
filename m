Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81735573A3A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiGMPes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C52FFE0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5lXq3+gwn+yp3ypbdM7NnRAzFBA6eb94pXrPSZX9Wso=;
        t=1657726481; x=1658936081; b=cr8upjGLmDPNBaTNTooKVz56G2Ea8jA6+Ll+/8gJrw8poZq
        kMEJ73rSIYxcU/5g7wPdo9qxz+M4GZS1bmBo+w/tL4GaChSIKNckRiI80dk3QaK2jSKOQIPWBTwSi
        urHb2hQxuyQtZK3ZJoMhtzQasURbgQhhbYZJKTR7jU56gUklFvkYe7KkzxmjoLeygFGM0UEBHfE1I
        PCA2wZy5ZFCyai8SE0FovMKjVhqydVNv2h2Lo7dHLzcLLX8ly3+WwEaaGd5yUFQCDmMAUxhdJS2jW
        D4gV+bB5UxGIAwv+GMyH7CkRlok59VMsxEhD23BcmLBe1/qZKDipzYnlBDoVesgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNp-00EnaA-QC;
        Wed, 13 Jul 2022 17:34:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/21] wifi: nl80211: reject fragmented and non-inheritance elements
Date:   Wed, 13 Jul 2022 17:34:14 +0200
Message-Id: <20220713173301.b71b1a24e37c.Iae35742381f6a5495768fca57e01b4a1fab918d6@changeid>
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

The underlying mac80211 code cannot deal with fragmented
elements for purposes of sorting the elements into the
association frame, so reject those inside the link. We
might want to reject them inside the assoc frame, but
they're used today for FILS, so cannot do that.

The non-inheritance element inside the links similarly
cannot be handled by mac80211, and outside the links it
makes no sense.

Reject both since using them could lead to an incorrect
implementation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index be969f64b5c3..e2d1efe0174e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10661,6 +10661,13 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_IE]) {
 		req.ie = nla_data(info->attrs[NL80211_ATTR_IE]);
 		req.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
+
+		if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+					   req.ie, req.ie_len)) {
+			GENL_SET_ERR_MSG(info,
+					 "non-inheritance makes no sense");
+			return -EINVAL;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_USE_MFP]) {
@@ -10805,6 +10812,24 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 					nla_data(attrs[NL80211_ATTR_IE]);
 				req.links[link_id].elems_len =
 					nla_len(attrs[NL80211_ATTR_IE]);
+
+				if (cfg80211_find_elem(WLAN_EID_FRAGMENT,
+						       req.links[link_id].elems,
+						       req.links[link_id].elems_len)) {
+					GENL_SET_ERR_MSG(info,
+							 "cannot deal with fragmentation");
+					err = -EINVAL;
+					goto free;
+				}
+
+				if (cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+							   req.links[link_id].elems,
+							   req.links[link_id].elems_len)) {
+					GENL_SET_ERR_MSG(info,
+							 "cannot deal with non-inheritance");
+					err = -EINVAL;
+					goto free;
+				}
 			}
 		}
 
-- 
2.36.1

