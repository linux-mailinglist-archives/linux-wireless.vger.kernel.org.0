Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9353BDA6D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhGFPrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 11:47:15 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38686 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhGFPrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 11:47:15 -0400
Received: by mail-wr1-f41.google.com with SMTP id a8so14926915wrp.5;
        Tue, 06 Jul 2021 08:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKZq5qbhINauEqvCfmIrG9RDxQlurs+fI84Tr3Es6H0=;
        b=TqsuAo0uz3dEtKxw/ZJE8FbirvsGz7RGgqBr71Ckb31+Psbc69935mRmkT03r1Vjm7
         9tiv3nJ0jZZQN6OMCPXdQ//ORCWox/fn2aFNnmkO/Zj1I4SXWz7BK/P7HWLe4ab5IO/q
         IKa81wEWs8a0dh1nQ+8apoQY+Q7am2v1WNfptEaYj7WGuzRExOcJU0jz7bBBjK3j9RA3
         MDVqtfSPdOY7ZHh3UOifKrLytahPVXLuZl0bIcmyUExcFj17/7Mz7QKXuwwPdpoaPWL6
         N5m3Yg5M8iwggBY55m7mgteWhKIINGUuHJCcYf+XJKaz1avuHdC+U+1m/yzXHDjtxqtw
         Dq7w==
X-Gm-Message-State: AOAM531QUWiymNfNluqziw9nCAOzs0e1QEVzQv1H2jp19GKLkKXF1zmp
        m9K6jBXVt342rfLJwE/3m27TmFZbRXQ=
X-Google-Smtp-Source: ABdhPJxx/Et+AQedt84FDz57T7Z+/lfL0ncYEwTlIodDqA2OSA3cU21wWopkV69x38hG82V40zDMVg==
X-Received: by 2002:adf:9084:: with SMTP id i4mr22760890wri.23.1625586274261;
        Tue, 06 Jul 2021 08:44:34 -0700 (PDT)
Received: from msft-t490s.. (host-79-12-118-22.retail.telecomitalia.it. [79.12.118.22])
        by smtp.gmail.com with ESMTPSA id v1sm18183321wre.20.2021.07.06.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:44:33 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-wireless@vger.kernel.org,
        Cody Schuffelen <schuffelen@google.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virt_wifi: fix error on connect
Date:   Tue,  6 Jul 2021 17:44:23 +0200
Message-Id: <20210706154423.11065-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When connecting without first doing a scan, the BSS list is empty
and __cfg80211_connect_result() generates this warning:

$ iw dev wlan0 connect -w VirtWifi
[   15.371989] ------------[ cut here ]------------
[   15.372179] WARNING: CPU: 0 PID: 92 at net/wireless/sme.c:756 __cfg80211_connect_result+0x402/0x440
[   15.372383] CPU: 0 PID: 92 Comm: kworker/u2:2 Not tainted 5.13.0-kvm #444
[   15.372512] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
[   15.372597] Workqueue: cfg80211 cfg80211_event_work
[   15.372756] RIP: 0010:__cfg80211_connect_result+0x402/0x440
[   15.372818] Code: 48 2b 04 25 28 00 00 00 75 59 48 8b 3b 48 8b 76 10 48 8d 65 e0 5b 41 5c 41 5d 41 5e 5d 49 8d 65 f0 41 5d e9 d0 d4 fd ff 0f 0b <0f> 0b e9 f6 fd ff ff e8 f2 4a b4 ff e9 ec fd ff ff 0f 0b e9 19 fd
[   15.372966] RSP: 0018:ffffc900005cbdc0 EFLAGS: 00010246
[   15.373022] RAX: 0000000000000000 RBX: ffff8880028e2400 RCX: ffff8880028e2472
[   15.373088] RDX: 0000000000000002 RSI: 00000000fffffe01 RDI: ffffffff815335ba
[   15.373149] RBP: ffffc900005cbe00 R08: 0000000000000008 R09: ffff888002bdf8b8
[   15.373209] R10: ffff88803ec208f0 R11: ffffffffffffe9ae R12: ffff88801d687d98
[   15.373280] R13: ffff88801b5fe000 R14: ffffc900005cbdc0 R15: dead000000000100
[   15.373330] FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[   15.373382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.373425] CR2: 000056421c468958 CR3: 000000001b458001 CR4: 0000000000170eb0
[   15.373478] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   15.373529] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   15.373580] Call Trace:
[   15.373611]  ? cfg80211_process_wdev_events+0x10e/0x170
[   15.373743]  cfg80211_process_wdev_events+0x10e/0x170
[   15.373783]  cfg80211_process_rdev_events+0x21/0x40
[   15.373846]  cfg80211_event_work+0x20/0x30
[   15.373892]  process_one_work+0x1e9/0x340
[   15.373956]  worker_thread+0x4b/0x3f0
[   15.374017]  ? process_one_work+0x340/0x340
[   15.374053]  kthread+0x11f/0x140
[   15.374089]  ? set_kthread_struct+0x30/0x30
[   15.374153]  ret_from_fork+0x1f/0x30
[   15.374187] ---[ end trace 321ef0cb7e9c0be1 ]---
wlan0 (phy #0): connected to 00:00:00:00:00:00

Add the fake bss just before the connect so that cfg80211_get_bss()
finds the virtual network.
As some code was duplicated, move it in a common function.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/net/wireless/virt_wifi.c | 52 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 1df959532c7d..514f2c1124b6 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -136,6 +136,29 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+static void virt_wifi_inform_bss(struct wiphy *wiphy)
+{
+	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
+	struct cfg80211_bss *informed_bss;
+	static const struct {
+		u8 tag;
+		u8 len;
+		u8 ssid[8];
+	} __packed ssid = {
+		.tag = WLAN_EID_SSID,
+		.len = 8,
+		.ssid = "VirtWifi",
+	};
+
+	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
+					   CFG80211_BSS_FTYPE_PRESP,
+					   fake_router_bssid, tsf,
+					   WLAN_CAPABILITY_ESS, 0,
+					   (void *)&ssid, sizeof(ssid),
+					   DBM_TO_MBM(-50), GFP_KERNEL);
+	cfg80211_put_bss(wiphy, informed_bss);
+}
+
 /* Called with the rtnl lock held. */
 static int virt_wifi_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *request)
@@ -156,28 +179,13 @@ static int virt_wifi_scan(struct wiphy *wiphy,
 /* Acquires and releases the rdev BSS lock. */
 static void virt_wifi_scan_result(struct work_struct *work)
 {
-	struct {
-		u8 tag;
-		u8 len;
-		u8 ssid[8];
-	} __packed ssid = {
-		.tag = WLAN_EID_SSID, .len = 8, .ssid = "VirtWifi",
-	};
-	struct cfg80211_bss *informed_bss;
 	struct virt_wifi_wiphy_priv *priv =
 		container_of(work, struct virt_wifi_wiphy_priv,
 			     scan_result.work);
 	struct wiphy *wiphy = priv_to_wiphy(priv);
 	struct cfg80211_scan_info scan_info = { .aborted = false };
-	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
 
-	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
-					   CFG80211_BSS_FTYPE_PRESP,
-					   fake_router_bssid, tsf,
-					   WLAN_CAPABILITY_ESS, 0,
-					   (void *)&ssid, sizeof(ssid),
-					   DBM_TO_MBM(-50), GFP_KERNEL);
-	cfg80211_put_bss(wiphy, informed_bss);
+	virt_wifi_inform_bss(wiphy);
 
 	/* Schedules work which acquires and releases the rtnl lock. */
 	cfg80211_scan_done(priv->scan_request, &scan_info);
@@ -225,10 +233,12 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 	if (!could_schedule)
 		return -EBUSY;
 
-	if (sme->bssid)
+	if (sme->bssid) {
 		ether_addr_copy(priv->connect_requested_bss, sme->bssid);
-	else
+	} else {
+		virt_wifi_inform_bss(wiphy);
 		eth_zero_addr(priv->connect_requested_bss);
+	}
 
 	wiphy_debug(wiphy, "connect\n");
 
@@ -241,11 +251,13 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 	struct virt_wifi_netdev_priv *priv =
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
-	bool has_addr = !is_zero_ether_addr(requested_bss);
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
 	u16 status = WLAN_STATUS_SUCCESS;
 
-	if (!priv->is_up || (has_addr && !right_addr))
+	if (is_zero_ether_addr(requested_bss))
+		requested_bss = NULL;
+
+	if (!priv->is_up || (requested_bss && !right_addr))
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 	else
 		priv->is_connected = true;
-- 
2.31.1

