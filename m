Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC2A9240
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfIDTOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 15:14:01 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39544 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbfIDTOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 15:14:00 -0400
Received: by mail-pg1-f175.google.com with SMTP id u17so11749514pgi.6
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prGeALBfuemlVpYx5ZOLdgfG4/7E0J+83AupSJ5m4b4=;
        b=ElVcmzuhjLJzxYNO72DLF3U1eb5KVUwv/d+PoQvIXkg5h/4aR9qOU21tjJQ8yrh/9p
         2+nqadpGZnXFlYE4Du5e1Cheio4f2kzI7YZfg6Mges1eEJWBD3MDLc9o2TZfiRjbqtg9
         0A1x/8Q90q0tTatlPQ8y2okAvyvaIahc5HdLOzg7b0lGrad83wjKR+imwx5147071yBl
         ElPgHOHcUIKoazhvRvCaws9X2wYdeG7sVAgmOT4H/grvMn9+z4tDc3XaSxrNKQEkvM5N
         eDPs5ZJuYMnHGrjkq87bKO15wmpzg6pF8PD+h0N85p+H44tvKAnyVS2q6h/6mVDsna0v
         jKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prGeALBfuemlVpYx5ZOLdgfG4/7E0J+83AupSJ5m4b4=;
        b=Fb6BANDh/WCzst+hAZ7dRg1VvZUQuJgBynHw4fmDkbWzROs4dtal492btHvCzTtN38
         S+crVBDXC+oZNnD7UONvJdoV430hKquMnzL0M6COkNLf/6qlDGyO66SN+OGkzrMlgSm3
         nLPhksNK9gkkicLj5DSql2hB2BfvKxI3B5azxbQjO4Moq/3uM9Gb6ScDVTXeFsAlvIvt
         R52WEDgqU4fPqWZl/aE2RJuKGUyEG5Zf9gJFa3JWLm6QSp9CLlhSNKagZ974rfP2XhdR
         iA5IzB2+HAm9EIgYmhRENdGivGeLV+vcQVXkUsMaocFuSJzAL1u5xTx+YiREs8f5qASF
         56kw==
X-Gm-Message-State: APjAAAU+8asfmttbGYXnquYapEViIlqDcU9pyK9VON+OQl1kEXD/i/Bi
        lnSS6Fm8GueeSKoYdLw4Ugk2hl0NeQA=
X-Google-Smtp-Source: APXvYqzXzDzrn/6zQEwFlR77bY3s66t9lm0Hs/xMC0MQTmUTt9RfY0odc4vdQgaMG5XRAk8mmiB5sw==
X-Received: by 2002:aa7:8c44:: with SMTP id e4mr10089313pfd.80.1567624439782;
        Wed, 04 Sep 2019 12:13:59 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u7sm18849727pgr.94.2019.09.04.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:59 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/4] mac80211: Support LIVE_ADDRESS_CHANGE feature
Date:   Wed,  4 Sep 2019 12:11:54 -0700
Message-Id: <20190904191155.28056-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904191155.28056-1-prestwoj@gmail.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

