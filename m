Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D83B2660
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfIMUBM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 16:01:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUBM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 16:01:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so9895207pfa.6
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLaTBTMcQ8c6qsmuKz70nF4P1DHHOjxBGMhLZv8o2h4=;
        b=spb5uKG3C8T2cDhJgAy+8Ga6Cbx+Yq3v47agmteg+FiVVO/Yhmv+gw+/4JeEu3n1qU
         mouBVM7xy2vJ2NDDGUAxZd91hcYEsBivelWd/c5knsgQ3AeNM7yMOVTV0SVHoXVCQYx5
         nNd4M09wo8ZlxAvEj5LswjbxqM4OT2wB9Z3WqNJOFPSyWR+uM3tkVfs/4b0jIh7gHTx5
         W+PSiUD06GjczIDTtx+J+IHD22l7AhqR3wzOEA+7hTu7fJepTR38YSjkgNCbI9gcSb2+
         Pmy7yEd6Kjf07/IHbr2COOXhcaDMCM8yJlqoh9Z24b1ukFDnbc5g9ZeUkeX1BfpzB31h
         7vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLaTBTMcQ8c6qsmuKz70nF4P1DHHOjxBGMhLZv8o2h4=;
        b=Hr7aMDoXAgi8TWNGjZlr+8xArecDKEgdldfai/rE/5wf9d+eXOQyvhsCwAYSPWnc7P
         /J1DbUKnRkKYbKX72JcW6ZJz/SWYTJzBFZVOkAlSe4XEArHmND8DqkzLT5B7ZMEZXV92
         K6d4JKBG8D3GjELRGFZFIZf4X425jm+02tFhuM3zSZBp+ujJbAYSbpHJM1bclrkKkOnC
         Im1DSbFk8/GlIO5iwbTEA0bP2LcyYbD6nk50iNrTc+H4dKi3ATrlH8Cn50t5fdLzVZeT
         gbneuQZa7Gq7qlnEVkUzNmvhE+PCbO9c5s9jag1C5d3/e7tvcrjSpMF9wJl4rSdDxhLH
         WHrw==
X-Gm-Message-State: APjAAAWdOkipEdJRXJMYOxXlbshOAvSq4jO3kcRvDLjW2chAgY14nHBg
        6NWctgHN7tfuzFPYS29pfMd9a1l1jrY=
X-Google-Smtp-Source: APXvYqwFcgbPtkfu0VNDU54KbU2j8lNvUXwmpDhTgSOQ8hqMTzGLP/HB5zeR/n2DqtOFpKZinf2Uhw==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr45259217pgh.149.1568404869691;
        Fri, 13 Sep 2019 13:01:09 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id 143sm24819392pgc.6.2019.09.13.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:01:08 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
Date:   Fri, 13 Sep 2019 12:59:08 -0700
Message-Id: <20190913195908.7871-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913195908.7871-1-prestwoj@gmail.com>
References: <20190913195908.7871-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/iface.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/main.c  |  1 +
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 8dc6580e1787..16ef6b83e7ea 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -198,15 +198,57 @@ static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
 	return ret;
 }
 
+static int ieee80211_can_live_addr_change(struct ieee80211_sub_if_data *sdata)
+{
+	if (netif_carrier_ok(sdata->dev))
+		return -EBUSY;
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_OCB:
+		/* No further checking required, when started or UP these
+		 * interface types set carrier
+		 */
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		if (sdata->u.ibss.ssid_len != 0)
+			return -EBUSY;
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (!list_empty(&sdata->local->roc_list) ||
+					!sdata->local->scanning)
+			return -EBUSY;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+
 static int ieee80211_change_mac(struct net_device *dev, void *addr)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
 	struct sockaddr *sa = addr;
 	bool check_dup = true;
+	bool live = false;
 	int ret;
 
-	if (ieee80211_sdata_running(sdata))
-		return -EBUSY;
+	if (ieee80211_sdata_running(sdata)) {
+		ret = ieee80211_can_live_addr_change(sdata);
+		if (ret)
+			return ret;
+
+		live = true;
+	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 	    !(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
@@ -216,7 +258,11 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	if (ret)
 		return ret;
 
+	if (live)
+		drv_remove_interface(local, sdata);
 	ret = eth_mac_addr(dev, sa);
+	if (live)
+		drv_add_interface(local, sdata);
 
 	if (ret == 0)
 		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
@@ -1871,6 +1917,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 			sdata->u.mgd.use_4addr = params->use_4addr;
 
 		ndev->features |= local->hw.netdev_features;
+		ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 		netdev_set_default_ethtool_ops(ndev, &ieee80211_ethtool_ops);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 29b9d57df1a3..0aea583e5e69 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -596,6 +596,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_LIVE_ADDRESS_CHANGE);
 
 	wiphy->bss_priv_size = sizeof(struct ieee80211_bss);
 
-- 
2.17.1

