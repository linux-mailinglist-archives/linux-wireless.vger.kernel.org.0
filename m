Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D821A923D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbfIDTN7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 15:13:59 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:34042 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbfIDTN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 15:13:59 -0400
Received: by mail-pf1-f175.google.com with SMTP id r12so1699445pfh.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8xWGRQoX1IvCx31D2Ompt6YG2G08KJUqFmqXk84nKM=;
        b=qd8nktnbaY8doOgOCnD7qX6cJnqEHcO6W9JjS3s0LJbAd84Of8zzp5hv8dN3P95NxE
         Ix+h+YY/Hiinr83nitFkF1Wk0Y7lPoIAqDgq1DtCkZTcvhwGQJTv1rrYhIDYIlHN7l8V
         jI2Zk/Lu4xrC4jfT4fp4yntzNud1XiWlhtACQFnMFYLUk5CU1G3c15NM1PGX7o0Gi8HL
         bWE4+EMBzbCIZtnXRd3k4mEFe6KRXLxbPg+UFqHLboRsCBN6KGEQJsWVNCPGbj+vC22Z
         Vz2+RvYrwBDMZGstyS9XzQmBQ2tS/vLJLwybhH4SbbQiC6aHoZuj/tPZzOIyT8WRsYvG
         A52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8xWGRQoX1IvCx31D2Ompt6YG2G08KJUqFmqXk84nKM=;
        b=UhEo2ATu0/VFSVuXoNnvjXBsy1jXA4dCPcHGOjRLJ8dUG5IESXFH9yjW7B0emUmasP
         NU9gcl7YzEwKhVcvcfvxmnrfvtXc7FJX0IAE5CxWif5tp+Y3wjeKdGu9WDoyXOYLb3c4
         mll6LfflU3OeYAIQ1grJCOsbjIx7+0FGLntMXg2FcpxygI8jSNsR/qeEAOLq2OUq9p8y
         Px46fzy3rIMltbtmQbTa/1kKUVg/teHCJytxJsmCMtwzPOT+XszrRsubcdDLFda9Yyoz
         RnfxDBu89fvNhj2Q2DTpF/U6nv/XlxW+pExhhx/Hea2Y3he2kXP6/7msVbwu0L1I+2pr
         4UGQ==
X-Gm-Message-State: APjAAAUJUWjrTWZgab8klXxio24K3mV417t1nwsQBhNQLHahK8YqNX9C
        VJQ+BOYgHIW2RuA0XFzubAzV/bZAKbM=
X-Google-Smtp-Source: APXvYqzP45pUu3HMoQrH5V9f+pDrQe28A22l32mBz1ea1Xtreo7n60el/u5zgP5z0J6UVTKZzewMCQ==
X-Received: by 2002:a62:3046:: with SMTP id w67mr42174598pfw.5.1567624438330;
        Wed, 04 Sep 2019 12:13:58 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u7sm18849727pgr.94.2019.09.04.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:13:57 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/4] {nl|cfg}80211: Support mac change as part of SME Connect
Date:   Wed,  4 Sep 2019 12:11:53 -0700
Message-Id: <20190904191155.28056-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904191155.28056-1-prestwoj@gmail.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 include/net/cfg80211.h       |  1 +
 include/uapi/linux/nl80211.h |  1 +
 net/wireless/core.h          |  1 +
 net/wireless/nl80211.c       | 11 +++++++++++
 net/wireless/sme.c           |  7 +++++++
 net/wireless/util.c          | 11 +++++++++++
 6 files changed, 32 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5253e7f667bd..25eacbebfa29 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2553,6 +2553,7 @@ struct cfg80211_connect_params {
 	size_t fils_erp_rrk_len;
 	bool want_1x;
 	struct ieee80211_edmg edmg;
+	const u8 *mac_to_use;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0ceb945a08fb..1bb4ce58da67 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2834,6 +2834,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_WIPHY_EDMG_CHANNELS,
 	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
+	NL80211_ATTR_MAC_TO_USE,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 77556c58d9ac..29e6ab2cf343 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -454,6 +454,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			  struct vif_params *params);
 void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev);
 void cfg80211_process_wdev_events(struct wireless_dev *wdev);
+int cfg80211_set_mac_to_use(struct net_device *dev, const u8 *mac);
 
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 				u32 center_freq_khz, u32 bw_khz);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4565d7385884..0202a762b5c8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -591,6 +591,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
+	[NL80211_ATTR_MAC_TO_USE] = { .type = NLA_EXACT_LEN_WARN,
+				      .len = ETH_ALEN },
 };
 
 /* policy for the key attributes */
@@ -10045,6 +10047,15 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		connect.flags |= CONNECT_REQ_EXTERNAL_AUTH_SUPPORT;
 	}
 
+	if (info->attrs[NL80211_ATTR_MAC_TO_USE]) {
+		if (!wiphy_ext_feature_isset(wiphy,
+				NL80211_EXT_FEATURE_LIVE_ADDRESS_CHANGE))
+			return -EOPNOTSUPP;
+
+		connect.mac_to_use =
+			nla_data(info->attrs[NL80211_ATTR_MAC_TO_USE]);
+	}
+
 	wdev_lock(dev->ieee80211_ptr);
 
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7a6c38ddc65a..f164af33655f 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1242,11 +1242,18 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 	wdev->conn_bss_type = connect->pbss ? IEEE80211_BSS_TYPE_PBSS :
 					      IEEE80211_BSS_TYPE_ESS;
 
+	if (connect->mac_to_use) {
+		err = cfg80211_set_mac_to_use(dev, connect->mac_to_use);
+		if (err)
+			goto fail;
+	}
+
 	if (!rdev->ops->connect)
 		err = cfg80211_sme_connect(wdev, connect, prev_bssid);
 	else
 		err = rdev_connect(rdev, dev, connect);
 
+fail:
 	if (err) {
 		wdev->connect_keys = NULL;
 		/*
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 92cb2cbb179b..06700431cba0 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2148,3 +2148,14 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 	return false;
 }
 EXPORT_SYMBOL(cfg80211_iftype_allowed);
+
+int cfg80211_set_mac_to_use(struct net_device *dev, const u8 *mac)
+{
+	struct sockaddr sa;
+
+	sa.sa_family = dev->type;
+	memcpy(sa.sa_data, mac, ETH_ALEN);
+
+	return dev_set_mac_address(dev, &sa, NULL);
+}
+EXPORT_SYMBOL(cfg80211_set_mac_to_use);
-- 
2.17.1

