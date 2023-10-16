Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D07CA70C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJPLxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 07:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjJPLxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 07:53:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB985130
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697457180; x=1728993180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mD+pucRMjq0UnsjQQ8LVSapNTX+IZFAkMc9Vo4CSZLg=;
  b=nlMLRCsT3KCcz7Xqo6f23P5Md/9lNwl1TqSPqR+hvia902K8oKkKv6+F
   EGiOOQU9wJdbw3Ossc8DCqpaKs60ig45x2LyqiPanKi4AQhgKJzkFRudN
   jmPyublYGjG7EsQpifoSnQiXGYkso8rXSz2cNYl1s24epz9X1YbXULOZQ
   N31nEnvY4sKMh0JwHXN1X5j0vMOtuGwwsKBo0cJR9D1dn+KegYCERb4Y9
   zXYKAK747+y0G1CWIyosRtSDqqwUlI9V30tgteFGFXbIwTl+GhShzm6W/
   LjbhY5VMzJDVtqA/BAq09YcfxEfk2qP+MekgyDl747ehbRt46Au0hsuMX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385346921"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385346921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749263615"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="749263615"
Received: from stavmalk-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.82.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:52:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] wifi: mac80211: don't drop all unprotected public action frames
Date:   Mon, 16 Oct 2023 14:52:48 +0300
Message-Id: <20231016145213.2973e3c8d3bb.I6198b8d3b04cf4a97b06660d346caec3032f232a@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Not all public action frames have a protected variant. When MFP is
enabled drop only public action frames that have a dual protected
variant.

Fixes: 76a3059cf124 ("wifi: mac80211: drop some unprotected action frames")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 29 +++++++++++++++++++++++++++++
 net/mac80211/rx.c         |  3 +--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 62b4469c6866..d31876236c0f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4419,6 +4419,35 @@ static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 	return mgmt->u.action.category == WLAN_CATEGORY_PUBLIC;
 }
 
+/**
+ * ieee80211_is_protected_dual_of_public_action - check if skb contains a
+ * protected dual of public action management frame
+ * @skb: the skb containing the frame, length will be checked
+ *
+ * Return: true if the skb contains a protected dual of public action
+ * management frame, false otherwise.
+ */
+static inline bool
+ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
+{
+	u8 action;
+
+	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
+	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
+		return false;
+
+	action = *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
+
+	return action != WLAN_PUB_ACTION_20_40_BSS_COEX &&
+		action != WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
+		action != WLAN_PUB_ACTION_MSMT_PILOT &&
+		action != WLAN_PUB_ACTION_TDLS_DISCOVER_RES &&
+		action != WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
+		action != WLAN_PUB_ACTION_FTM_REQUEST &&
+		action != WLAN_PUB_ACTION_FTM_RESPONSE &&
+		action != WLAN_PUB_ACTION_FILS_DISCOVERY;
+}
+
 /**
  * _ieee80211_is_group_privacy_action - check if frame is a group addressed
  * privacy action frame
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f2ea15d31c31..69db83433ba1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2469,8 +2469,7 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 		/* drop unicast public action frames when using MPF */
 		if (is_unicast_ether_addr(mgmt->da) &&
-		    ieee80211_is_public_action((void *)rx->skb->data,
-					       rx->skb->len))
+		    ieee80211_is_protected_dual_of_public_action(rx->skb))
 			return RX_DROP_U_UNPROT_UNICAST_PUB_ACTION;
 	}
 
-- 
2.38.1

