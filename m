Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845A952618
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 10:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfFYII4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 04:08:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53696 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfFYII4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 04:08:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfgVa-0003nN-AC; Tue, 25 Jun 2019 10:08:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wireless: fix netlink vendor commands
Date:   Tue, 25 Jun 2019 10:08:45 +0200
Message-Id: <20190625080845.19014-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In my previous commit to validate a policy I neglected to
actually add one to the few drivers using vendor commands,
fix that now.

Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Fixes: 901bb9891855 ("nl80211: require and validate vendor command policy")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c               | 4 ++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c | 1 +
 drivers/net/wireless/ti/wlcore/vendor_cmd.c               | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 804955d24b30..37ac95940c22 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -177,6 +177,7 @@ static const struct wiphy_vendor_command wil_nl80211_vendor_commands[] = {
 		.info.subcmd = QCA_NL80211_VENDOR_SUBCMD_DMG_RF_GET_SECTOR_CFG,
 		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.policy = wil_rf_sector_policy,
 		.doit = wil_rf_sector_get_cfg
 	},
 	{
@@ -184,6 +185,7 @@ static const struct wiphy_vendor_command wil_nl80211_vendor_commands[] = {
 		.info.subcmd = QCA_NL80211_VENDOR_SUBCMD_DMG_RF_SET_SECTOR_CFG,
 		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.policy = wil_rf_sector_policy,
 		.doit = wil_rf_sector_set_cfg
 	},
 	{
@@ -192,6 +194,7 @@ static const struct wiphy_vendor_command wil_nl80211_vendor_commands[] = {
 			QCA_NL80211_VENDOR_SUBCMD_DMG_RF_GET_SELECTED_SECTOR,
 		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.policy = wil_rf_sector_policy,
 		.doit = wil_rf_sector_get_selected
 	},
 	{
@@ -200,6 +203,7 @@ static const struct wiphy_vendor_command wil_nl80211_vendor_commands[] = {
 			QCA_NL80211_VENDOR_SUBCMD_DMG_RF_SET_SELECTED_SECTOR,
 		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.policy = wil_rf_sector_policy,
 		.doit = wil_rf_sector_set_selected
 	},
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
index d493021f6031..30ebadc5e5bb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
@@ -123,6 +123,7 @@ const struct wiphy_vendor_command brcmf_vendor_cmds[] = {
 		},
 		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
 			 WIPHY_VENDOR_CMD_NEED_NETDEV,
+		.policy = VENDOR_CMD_RAW_DATA,
 		.doit = brcmf_cfg80211_vndr_cmds_dcmd_handler
 	},
 };
diff --git a/drivers/net/wireless/ti/wlcore/vendor_cmd.c b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
index 5cf0b32c413b..e1bd344c4ebc 100644
--- a/drivers/net/wireless/ti/wlcore/vendor_cmd.c
+++ b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
@@ -163,6 +163,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_start,
+		.policy = wlcore_vendor_attr_policy,
 	},
 	{
 		.info = {
@@ -172,6 +173,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_stop,
+		.policy = wlcore_vendor_attr_policy,
 	},
 	{
 		.info = {
@@ -181,6 +183,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_set_group_key,
+		.policy = wlcore_vendor_attr_policy,
 	},
 };
 
-- 
2.17.2

