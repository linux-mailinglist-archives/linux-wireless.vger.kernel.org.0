Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7595251E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfFYHqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 03:46:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53196 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFYHqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 03:46:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfg9y-0003JI-ES; Tue, 25 Jun 2019 09:46:34 +0200
Message-ID: <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Date:   Tue, 25 Jun 2019 09:46:33 +0200
In-Reply-To: <20190625073837.GG5447@atomide.com> (sfid-20190625_093856_832195_5A1A0447)
References: <20190625073837.GG5447@atomide.com>
         (sfid-20190625_093856_832195_5A1A0447)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
> Hi,
> 
> Looks like at least drivers/net/wireless/ti wlcore driver has stopped
> working in Linux next with commit 901bb9891855 ("nl80211: require and
> validate vendor command policy"). Reverting the commit above makes it
> work again.
> 
> It fails with the warning below, any ideas what goes wrong?

Oops. For some reason, I neglected to check the vendor command usage
beyond hwsim.

The patch below should work?

johannes

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
index 75756fb8e7b0..cd82d3580e87 100644
--- a/drivers/net/wireless/ti/wlcore/vendor_cmd.c
+++ b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
@@ -166,6 +166,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_start,
+		.policy = wlcore_vendor_attr_policy,
 	},
 	{
 		.info = {
@@ -175,6 +176,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_stop,
+		.policy = wlcore_vendor_attr_policy,
 	},
 	{
 		.info = {
@@ -184,6 +186,7 @@ static const struct wiphy_vendor_command wlcore_vendor_commands[] = {
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV |
 			 WIPHY_VENDOR_CMD_NEED_RUNNING,
 		.doit = wlcore_vendor_cmd_smart_config_set_group_key,
+		.policy = wlcore_vendor_attr_policy,
 	},
 };
 

