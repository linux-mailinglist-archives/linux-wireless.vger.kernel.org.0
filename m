Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A468F402
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfHOS61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 14:58:27 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44729 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbfHOS61 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 14:58:27 -0400
Received: by mail-pg1-f172.google.com with SMTP id i18so1672964pgl.11
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YaXPQ1vdKs3CiPy7S/m8KzA74vN1sy+p6D17RrrThr0=;
        b=ro2VFF0ZV5Pu9w8rrbqVnOT8rMTZ6/AqeS6RnJskoZA5JSQD7DoH3zgEjD9fB0or5D
         3eAMQpda5StJd9K2e4yS+E68SOHWHVv/yuv2hWSmZFB4aR23PvSDPL8udabXZe/zNW/z
         /Inh4kgJ8i3FXa6JSCOlI4Icz5vjCUn0OPDUmNMqByWnvhxGpHm1HUy7aQhRqR7KLugG
         OrE1EadS7JIl9lwZaEPQjx7/MegO9F6CxNeV0WHFd0SiyKdyKXq7nRUq5rUYXacTGeJh
         dKYd6Kn3+OXG0AHmShylH7TFOVkTXTj2mlDnadWAYAbXPYOCBzf/v+tIvRb0ppeu/fzG
         gWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YaXPQ1vdKs3CiPy7S/m8KzA74vN1sy+p6D17RrrThr0=;
        b=ISPnzmI5vdVE+hYUXkYQZ29JPhYY8tqqTFWi6LcB175TonBWdEv9a4M/3jOjI+Rckf
         GQoSO9DXYupIdZgNV8jsjP33H4x2Y4xID+mkEH2tIKTIbXYFzLZWIWsXfsPFj36NXtu5
         7YNnCl+gwUBW83F3f/HJsV5aeI1M36u8V0ZQ7YGtFVE6JmzeymeM3nkODUINfOCc2ohl
         QODtvtXdSY/4tBMVLneI/dm0kLnDsYZXazszPPxss/sWN9RERCLJ1UKg0gqvnb+X1hWo
         NZZqm/cFmI76zxmdavAANWwd8WDhATUr1t8wcHlRS6vSWkFu3BNfTesc+Uw9c1chKqVB
         3k0A==
X-Gm-Message-State: APjAAAVY2ZHAeNgP1L8JgdCEt5ZX+LYXhtAPxnL1oTrtP+TEaBVsObyx
        N8KfOnNoO9rvdJDmVXKoFZ4gORsR
X-Google-Smtp-Source: APXvYqxNg83FjuUQSm1ytjn18vhOIrMWFoyA873LV2zweLiMMiu+N0LZbITNeEa6Qu6oF1yYZZ5XFA==
X-Received: by 2002:a63:d210:: with SMTP id a16mr4520278pgg.77.1565895505186;
        Thu, 15 Aug 2019 11:58:25 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id 67sm2469878pjo.29.2019.08.15.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 11:58:24 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] RFC: allow mac address change on up iface
Date:   Thu, 15 Aug 2019 11:57:02 -0700
Message-Id: <20190815185702.30937-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815185702.30937-1-prestwoj@gmail.com>
References: <20190815185702.30937-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 ++
 include/net/cfg80211.h                        |  1 +
 include/uapi/linux/nl80211.h                  |  3 +++
 net/mac80211/iface.c                          |  5 ++---
 net/wireless/nl80211.c                        |  9 +++++++++
 net/wireless/sme.c                            | 20 +++++++++++++++++++
 6 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fdbabca0280e..410daeb78208 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -601,6 +601,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	hw->wiphy->features |= NL80211_FEATURE_HT_IBSS;
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_LIVE_ADDR_CHANGE);
+
 	hw->wiphy->regulatory_flags |= REGULATORY_ENABLE_RELAX_NO_IR;
 	if (iwl_mvm_is_lar_supported(mvm))
 		hw->wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8fb5be3ca0ca..e067db9f61b9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2433,6 +2433,7 @@ struct cfg80211_connect_params {
 	const u8 *fils_erp_rrk;
 	size_t fils_erp_rrk_len;
 	bool want_1x;
+	const u8 *random_mac;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6f09d1500960..da7d770a6bf2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2794,6 +2794,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_STA_TX_POWER_SETTING,
 	NL80211_ATTR_STA_TX_POWER,
 
+	NL80211_ATTR_RANDOM_MAC_ADDR,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5466,6 +5468,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD,
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
+	NL80211_EXT_FEATURE_LIVE_ADDR_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 06aac0aaae64..63d7b14189b0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -205,9 +205,6 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	bool check_dup = true;
 	int ret;
 
-	if (ieee80211_sdata_running(sdata))
-		return -EBUSY;
-
 	if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 	    !(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
 		check_dup = false;
@@ -216,6 +213,8 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	if (ret)
 		return ret;
 
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
 	ret = eth_mac_addr(dev, sa);
 
 	if (ret == 0)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 520d437aa8d1..bc975e49cd00 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9887,6 +9887,15 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		connect.flags |= CONNECT_REQ_EXTERNAL_AUTH_SUPPORT;
 	}
 
+	if (info->attrs[NL80211_ATTR_RANDOM_MAC_ADDR]) {
+		if (!wiphy_ext_feature_isset(wiphy,
+					NL80211_EXT_FEATURE_LIVE_ADDR_CHANGE))
+			return -EINVAL;
+
+		connect.random_mac = nla_data(
+				info->attrs[NL80211_ATTR_RANDOM_MAC_ADDR]);
+	}
+
 	wdev_lock(dev->ieee80211_ptr);
 
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7d34cb884840..8a09aad19752 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1218,6 +1218,26 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 	wdev->conn_bss_type = connect->pbss ? IEEE80211_BSS_TYPE_PBSS :
 					      IEEE80211_BSS_TYPE_ESS;
 
+	if (connect->random_mac) {
+		struct sockaddr *sa;
+		int len;
+
+		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
+						  sizeof(*sa));
+		sa = kmalloc(len, GFP_KERNEL);
+		if (!sa)
+			return -ENOMEM;
+
+		sa->sa_family = dev->type;
+		memcpy(sa->sa_data, connect->random_mac,
+			dev->addr_len);
+
+		err = dev_set_mac_address(dev, sa, NULL);
+		kfree(sa);
+		if (err < 0)
+			return err;
+	}
+
 	if (!rdev->ops->connect)
 		err = cfg80211_sme_connect(wdev, connect, prev_bssid);
 	else
-- 
2.17.1

