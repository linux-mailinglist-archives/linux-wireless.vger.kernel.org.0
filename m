Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91145274A48
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVUoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 16:44:44 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:47826 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUoo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 16:44:44 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CEE3F13C2B0;
        Tue, 22 Sep 2020 13:44:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CEE3F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600807482;
        bh=Y7BEo9tq5oANxsd2ILjh/8oGhdaRNbkq+0SihhCM+sY=;
        h=From:To:Cc:Subject:Date:From;
        b=hYBm8kxyhfi2sSstzflNLjwZr4f4PP+VBv5xMwkakoHcv7RHQXdtjMklNIB1MLIjx
         rUD1nH1ZWChaosj/gHfi3hlfqFBTS7Vft2ObKual6chdWke+CozdG7MVPnO1dDYOeO
         InK1BwvIDbnTco1WYQnc55FyXn8rXInR3hhccius=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wireless:  Add sysfs file to show if radio is unavailable
Date:   Tue, 22 Sep 2020 13:44:39 -0700
Message-Id: <20200922204440.25360-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

While stress-testing an IPQ4019 based AP, sometimes the firmware and/or
radio hardware crashes hard enough that it cannot recover.  In this case,
no wifi can work on that radio again until user-space takes some
action (such as reboot, or possibly rmmod/modprobe).

Provide a sysfs file so that watchdog or other tools can check to
see if radios are in such a state and take appropriate action.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/cfg80211.h | 13 +++++++++++++
 net/wireless/core.c    |  6 ++++++
 net/wireless/sysfs.c   |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d9e6b9fbd95ba..926ba62e4b3e2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4778,6 +4778,8 @@ struct wiphy_iftype_akm_suites {
  * @max_data_retry_count: maximum supported per TID retry count for
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
+ * @unavailable:  Has this radio become unavailable for some reason.
+ *	0:  It is available, otherwise not.
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -4791,6 +4793,7 @@ struct wiphy {
 
 	const struct ieee80211_iface_combination *iface_combinations;
 	int n_iface_combinations;
+	int unavailable;
 	u16 software_iftypes;
 
 	u16 n_addresses;
@@ -7696,6 +7699,16 @@ void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
  */
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy);
 
+/**
+ * cfg80211_set_unavailable - Set value indicating resources have become
+ * unavailable.
+ *
+ * This can happen if firmware crashes during restart, for instance.  In this
+ * case, probably module rmmod/modprobe or reboot is required to get the system
+ * functional again.
+ */
+void cfg80211_set_unavailable(struct wiphy *wiphy, int value);
+
 /**
  * wiphy_ext_feature_set - set the extended feature flag
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 354b0ccbdc240..e1c842acab796 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -259,6 +259,12 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+void cfg80211_set_unavailable(struct wiphy *wiphy, int value)
+{
+	wiphy->unavailable = value;
+}
+EXPORT_SYMBOL_GPL(cfg80211_set_unavailable);
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 3ac1f48195d28..077ec8083b887 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -33,6 +33,7 @@ static ssize_t name ## _show(struct device *dev,			\
 static DEVICE_ATTR_RO(name)
 
 SHOW_FMT(index, "%d", wiphy_idx);
+SHOW_FMT(unavailable, "%d", wiphy.unavailable);
 SHOW_FMT(macaddress, "%pM", wiphy.perm_addr);
 SHOW_FMT(address_mask, "%pM", wiphy.addr_mask);
 
@@ -66,6 +67,7 @@ static DEVICE_ATTR_RO(addresses);
 
 static struct attribute *ieee80211_attrs[] = {
 	&dev_attr_index.attr,
+	&dev_attr_unavailable.attr,
 	&dev_attr_macaddress.attr,
 	&dev_attr_address_mask.attr,
 	&dev_attr_addresses.attr,
-- 
2.26.2

