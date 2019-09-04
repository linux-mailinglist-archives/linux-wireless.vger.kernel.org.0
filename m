Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C59AA9241
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfIDTOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 15:14:02 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37528 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732934AbfIDTOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 15:14:02 -0400
Received: by mail-pl1-f181.google.com with SMTP id b10so4937075plr.4
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ns59MJnS41pUvrzoJ+EufNvjRLwIyb/C4J/rzg8qRUQ=;
        b=TTWrLPgx9rMepi2uKSOpdfcFQtRf9rsSOKm4TdLEh0yAXp8BwxW//Z7gwnspFJCnBi
         3nre6oOf2agMLKODWQEVFK9OBk8i+5siddSNzn/Cn3RZlHxRYVtDE10cmWSE1xG2MFM2
         vnHehha8CRISwMgHuJENYufqwEu3KjrK8oKa5uIyXYo8H+Arge4DdjqlodcQeOVemRGZ
         NjYnUJjJJgkytUbHcGbq/GQK2IHbOL1nZaAq7Kr34hGTq26A3l2AGwBp1h7jwHFuetYH
         0g/Rxy6OwumfYWubJk+4x9PMFV6Ix9ZMNMRxwMsKt+p8yC+vCBnc1AIOCUe8SDl4RBE+
         4CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ns59MJnS41pUvrzoJ+EufNvjRLwIyb/C4J/rzg8qRUQ=;
        b=Gb/DMAd70q2qdv89VEqCL+Q2HSFrg4PQ7qzwefZA3SL9j3tEj8FwVdKB+FsDfmokJb
         a1uk7jTxGM46yh4SP0xztYYs9lyFmZFPz9y2Tt2qTOgypFERhbIb9XQNE5fLio+ZFmjY
         eJ5I/GW1SUBn+iyGmnce72MmOtyL4KKJyaRvJ0xvBp2jLJP8zvOMrW6nJvRIPs2WZwCo
         wGmCAvEX1LURtMlHpi5aHvADDANIX0a3OAaWU5sJ4MuXpBLX37tRrKueLK4PqSCxrR5b
         xQTS4K7WY8Heicb5noqPLfHvmFVtFtnI9EB4P/T8H7uH+EPKY5vS2cAMj++FaPaf/6T1
         Tapw==
X-Gm-Message-State: APjAAAXpf607+j9uYcHRogJ8Orrljo/7aprdkN550KI1k/MkaQjuO4Ee
        Hh/7Ngj4RHVTWuz1/16Qkkm6op7KcMA=
X-Google-Smtp-Source: APXvYqzEpbviJA/1seqx4GKlhgUN45RrR8UYWRf1+1ASKpMuAa4rf+xs3jxIlIppdLHIwE97+hhQHg==
X-Received: by 2002:a17:902:ff09:: with SMTP id f9mr345627plj.55.1567624441357;
        Wed, 04 Sep 2019 12:14:01 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id u7sm18849727pgr.94.2019.09.04.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:14:00 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/4] {nl,cfg}nl80211: Support mac change for mlme_authenticate
Date:   Wed,  4 Sep 2019 12:11:55 -0700
Message-Id: <20190904191155.28056-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904191155.28056-1-prestwoj@gmail.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 net/wireless/core.h    | 3 ++-
 net/wireless/mlme.c    | 9 ++++++++-
 net/wireless/nl80211.c | 7 ++++++-
 net/wireless/sme.c     | 2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 29e6ab2cf343..869ab983692d 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -366,7 +366,8 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 		       const u8 *ssid, int ssid_len,
 		       const u8 *ie, int ie_len,
 		       const u8 *key, int key_len, int key_idx,
-		       const u8 *auth_data, int auth_data_len);
+		       const u8 *auth_data, int auth_data_len,
+		       const u8 *mac_to_use);
 int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 			struct net_device *dev,
 			struct ieee80211_channel *chan,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f9462010575f..adf411905e64 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -226,7 +226,8 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 		       const u8 *ssid, int ssid_len,
 		       const u8 *ie, int ie_len,
 		       const u8 *key, int key_len, int key_idx,
-		       const u8 *auth_data, int auth_data_len)
+		       const u8 *auth_data, int auth_data_len,
+		       const u8 *mac_to_use)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_auth_request req = {
@@ -257,6 +258,12 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 	if (!req.bss)
 		return -ENOENT;
 
+	if (mac_to_use) {
+		err = cfg80211_set_mac_to_use(dev, mac_to_use);
+		if (err)
+			return err;
+	}
+
 	err = rdev_auth(rdev, dev, &req);
 
 	cfg80211_put_bss(&rdev->wiphy, req.bss);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0202a762b5c8..db32eaaaa50e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8898,6 +8898,7 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	enum nl80211_auth_type auth_type;
 	struct key_parse key;
 	bool local_state_change;
+	const u8 *mac_to_change = NULL;
 
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
@@ -8993,6 +8994,10 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
 
+	if (info->attrs[NL80211_ATTR_MAC_TO_USE])
+		mac_to_change = nla_data(
+				info->attrs[NL80211_ATTR_MAC_TO_USE]);
+
 	/*
 	 * Since we no longer track auth state, ignore
 	 * requests to only change local state.
@@ -9004,7 +9009,7 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_mlme_auth(rdev, dev, chan, auth_type, bssid,
 				 ssid, ssid_len, ie, ie_len,
 				 key.p.key, key.p.key_len, key.idx,
-				 auth_data, auth_data_len);
+				 auth_data, auth_data_len, mac_to_change);
 	wdev_unlock(dev->ieee80211_ptr);
 	return err;
 }
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index f164af33655f..f66ea48b73df 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -174,7 +174,7 @@ static int cfg80211_conn_do_work(struct wireless_dev *wdev,
 					  params->ssid, params->ssid_len,
 					  NULL, 0,
 					  params->key, params->key_len,
-					  params->key_idx, NULL, 0);
+					  params->key_idx, NULL, 0, NULL);
 	case CFG80211_CONN_AUTH_FAILED_TIMEOUT:
 		*treason = NL80211_TIMEOUT_AUTH;
 		return -ENOTCONN;
-- 
2.17.1

