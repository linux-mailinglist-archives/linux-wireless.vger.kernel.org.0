Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0583C5A2CFC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiHZRAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHZRAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 13:00:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742ABC82A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso334892pjv.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8Pf6A1jSbfvvNhI6LUD9Fh4Kyvq7BLxYJ5Ca1mFYhBw=;
        b=lqNIBvI9Y2xOPTiiQ9CpR+X1qBczA2/sPIIl71YUIMQ5zk6sFsupVr38hnJ+BEbJyW
         OoOrvhcLrJm4uVTEqa+IU0HM68qd+X+kmajDqb2UZa+uThLzzx43Upfeq7WB3lSZRvVj
         lSwesp+NI17Wk4fIvrGG5jTQyejXwjrIDaxUEbyA0ru5fU8oIaLcqpW1VSzp/0DaX0cc
         5i7Q0tg84DAodFQxAuoA4d/qghtVox1oAhfAfHJzIMoW9uRrEGmeowNPlVVBOYmkTUbL
         RecYUWfB+aZsdiAQTRsNJTt8g2oUk9tWRDsWVzrhw7P6HdPB5JgUkGBrIBCJr6wBTPiE
         iwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8Pf6A1jSbfvvNhI6LUD9Fh4Kyvq7BLxYJ5Ca1mFYhBw=;
        b=ssBgXCoFZi7Vwa+zjB8PnWOvAkpxHRNGSJMLZBU2MkNt6SNVl9hVJ8AlNIaIqWj7uH
         MU3dKq4igB0t6neZe5+71fosKxJ4EKpm+sU4iQDNn5MysAII6idJAcbAqHObZAuGiohw
         aJukiAqsOrZf6K2zJXgb4zqbLg7osUucoZCAtqhZAvCQhmlbHs/xhFnvObs2eq5QuLDb
         7lfdUvQ2vrG2CxriOY6927yRdngkFpTktakjdJMSDGTs5J2TCaL7w7wXlXI9zf9NDwr9
         lQ1C228hVA8TbyIjl2T2/3OUchyxmkyUpP/UNeyjVrrwBee3A8ci6JgQeuHI4hiTM5pg
         C6gg==
X-Gm-Message-State: ACgBeo3gHOBJaNLgrvl0lwQtxL08HN34fu3EjsCrj4AqY/prxFKhu31y
        l5xBRdpTyVk4VddPulNdxfJfU7XGh80=
X-Google-Smtp-Source: AA6agR7XNBUNaLxeJX3B9B1raulZH/tenMmZAFaZ9IBHUzQs7PiKcFsUFmK0IEOzpRY9vXV08np07g==
X-Received: by 2002:a17:902:b68d:b0:172:e973:82b9 with SMTP id c13-20020a170902b68d00b00172e97382b9mr4549608pls.120.1661533242626;
        Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id y9-20020a634949000000b0041d322b3bf6sm1685034pgk.77.2022.08.26.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
Date:   Fri, 26 Aug 2022 10:00:32 -0700
Message-Id: <20220826170032.2860883-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220826170032.2860883-1-prestwoj@gmail.com>
References: <20220826170032.2860883-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds support in mac80211 for NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE.
The motivation behind this functionality is to fix limitations of
address randomization on frequencies which are disallowed in world
roaming.

The way things work now, if a client wants to randomize their address
per-connection it must power down the device, change the MAC, and
power back up. Here lies a problem since powering down the device
may result in frequencies being disabled (until the regdom is set).
If the desired BSS is on one such frequency the client is unable to
connect once the phy is powered again.

For mac80211 based devices changing the MAC while powered is possible
but currently disallowed (-EBUSY). This patch adds some logic to
allow a MAC change while powered by removing the interface, changing
the MAC, and adding it again. mac80211 will advertise support for
this feature so userspace can determine the best course of action e.g.
disallow address randomization on certain frequencies if not
supported.

There are certain limitations put on this which simplify the logic:
 - No active connection
 - No offchannel work, including scanning.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/iface.c | 71 ++++++++++++++++++++++++++++++++++++++++++--
 net/mac80211/main.c  |  2 ++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1a9ada411879..8bc168339390 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -199,15 +199,73 @@ static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
 	return ret;
 }
 
+static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_roc_work *roc;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *scan_sdata;
+	int ret = 0;
+
+	/* To be the most flexible here we want to only limit changing the
+	 * address if the specific interface is doing offchannel work or
+	 * scanning.
+	 */
+	if (netif_carrier_ok(sdata->dev))
+		return -EBUSY;
+
+	mutex_lock(&local->mtx);
+
+	/* First check no ROC work is happening on this iface */
+	list_for_each_entry(roc, &local->roc_list, list) {
+		if (roc->sdata != sdata)
+			continue;
+
+		if (roc->started) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+	}
+
+	/* And if this iface is scanning */
+	if (local->scanning) {
+		scan_sdata = rcu_dereference_protected(local->scan_sdata,
+						       lockdep_is_held(&local->mtx));
+		if (sdata == scan_sdata)
+			ret = -EBUSY;
+	}
+
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		/* More interface types could be added here but changing the
+		 * address while powered makes the most sense in client modes.
+		 */
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+unlock:
+	mutex_unlock(&local->mtx);
+	return ret;
+}
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
+		ret = ieee80211_can_powered_addr_change(sdata);
+		if (ret)
+			return ret;
+
+		live = true;
+	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 	    !(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
@@ -217,11 +275,19 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	if (ret)
 		return ret;
 
+	if (live)
+		drv_remove_interface(local, sdata);
 	ret = eth_mac_addr(dev, sa);
 
 	if (ret == 0)
 		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
 
+	/* Regardless of eth_mac_addr() return we still want to add the
+	 * interface back. This should not fail...
+	 */
+	if (live)
+		WARN_ON(drv_add_interface(local, sdata));
+
 	return ret;
 }
 
@@ -2128,6 +2194,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 			sdata->u.mgd.use_4addr = params->use_4addr;
 
 		ndev->features |= local->hw.netdev_features;
+		ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 		ndev->hw_features |= ndev->features &
 					MAC80211_SUPPORTED_FEATURES_TX;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5a385d4146b9..3aeb5e598263 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -616,6 +616,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_SCAN_FREQ_KHZ);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
-- 
2.34.3

