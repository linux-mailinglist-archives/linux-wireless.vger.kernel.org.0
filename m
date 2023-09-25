Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DD7ADB59
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjIYPZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjIYPZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589E10E
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=c7ESgCOGqfPACC58cI9nXZdsrcS8tYFYqzIsmArEIqg=;
        t=1695655516; x=1696865116; b=vR0ZMqToyGHfZqIQpgw/09Gnspjfv0vZC1ItvtaGBVIU+FO
        3g+RQDht+fcUPhPXTsQWepnos7JNA6OEBd/2EfGpO/w08yrvaiPS30QnIpPRSb5CEyE40P5OjteS7
        0J8N5vNJ8W2cDiKm0JmIy6zL4rl9yxIwomy1+XVAJ4jDUQC8HGeEGNvq/Qez73NDrNNdawh+NLIMp
        7T/krj/HqknnPo+9LgmHSKpui1VYApEAZfH3h0lN3AKNQJQhBzoSBwB3MsWTszC0Csj840YW8aurt
        +HQ+nFGO0zbuptRc6UyYcBz7tM5elRStviFyql1EHOP4cGKeaY1PA8knon4wmqMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknSU-003kq9-1i;
        Mon, 25 Sep 2023 17:25:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] wifi: mac80211: expand __ieee80211_data_to_8023() status
Date:   Mon, 25 Sep 2023 17:25:11 +0200
Message-ID: <20230925172508.9344bdb3837b.I974bd3626681dffe3373981276c7cdaa4946c838@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925172508.bc62dfb8a129.I9d64271b6d375aa87c8cac82145823374800b246@changeid>
References: <20230925172508.bc62dfb8a129.I9d64271b6d375aa87c8cac82145823374800b246@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Make __ieee80211_data_to_8023() return more individual drop
reasons instead of just doing RX_DROP_U_INVALID_8023.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/drop.h |  4 ++++
 net/mac80211/rx.c   | 22 ++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 3acc21ae9c69..12a6f0e9eca6 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -62,6 +62,10 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	R(RX_DROP_U_SHORT_CMAC)			\
 	R(RX_DROP_U_SHORT_CMAC256)		\
 	R(RX_DROP_U_SHORT_GMAC)			\
+	R(RX_DROP_U_UNEXPECTED_VLAN_4ADDR)	\
+	R(RX_DROP_U_UNEXPECTED_STA_4ADDR)	\
+	R(RX_DROP_U_UNEXPECTED_VLAN_MCAST)	\
+	R(RX_DROP_U_NOT_PORT_CONTROL)		\
 /* this line for the trailing \ - add before this */
 
 /* having two enums allows for checking ieee80211_rx_result use with sparse */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ff98681c70e3..fb2d4a7436be 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2476,7 +2476,7 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 	return 0;
 }
 
-static int
+static ieee80211_rx_result
 __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 {
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
@@ -2488,32 +2488,31 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 	*port_control = false;
 	if (ieee80211_has_a4(hdr->frame_control) &&
 	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN && !sdata->u.vlan.sta)
-		return -1;
+		return RX_DROP_U_UNEXPECTED_VLAN_4ADDR;
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    !!sdata->u.mgd.use_4addr != !!ieee80211_has_a4(hdr->frame_control)) {
-
 		if (!sdata->u.mgd.use_4addr)
-			return -1;
+			return RX_DROP_U_UNEXPECTED_STA_4ADDR;
 		else if (!ether_addr_equal(hdr->addr1, sdata->vif.addr))
 			check_port_control = true;
 	}
 
 	if (is_multicast_ether_addr(hdr->addr1) &&
 	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN && sdata->u.vlan.sta)
-		return -1;
+		return RX_DROP_U_UNEXPECTED_VLAN_MCAST;
 
 	ret = ieee80211_data_to_8023(rx->skb, sdata->vif.addr, sdata->vif.type);
 	if (ret < 0)
-		return ret;
+		return RX_DROP_U_INVALID_8023;
 
 	ehdr = (struct ethhdr *) rx->skb->data;
 	if (ehdr->h_proto == rx->sdata->control_port_protocol)
 		*port_control = true;
 	else if (check_port_control)
-		return -1;
+		return RX_DROP_U_NOT_PORT_CONTROL;
 
-	return 0;
+	return RX_CONTINUE;
 }
 
 bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
@@ -3124,7 +3123,6 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 	__le16 fc = hdr->frame_control;
 	ieee80211_rx_result res;
 	bool port_control;
-	int err;
 
 	if (unlikely(!ieee80211_is_data(hdr->frame_control)))
 		return RX_CONTINUE;
@@ -3145,9 +3143,9 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		return RX_DROP_MONITOR;
 	}
 
-	err = __ieee80211_data_to_8023(rx, &port_control);
-	if (unlikely(err))
-		return RX_DROP_U_INVALID_8023;
+	res = __ieee80211_data_to_8023(rx, &port_control);
+	if (unlikely(res != RX_CONTINUE))
+		return res;
 
 	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
 	if (res != RX_CONTINUE)
-- 
2.41.0

