Return-Path: <linux-wireless+bounces-9970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31D926DD5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 05:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B68281A54
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109017C67;
	Thu,  4 Jul 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E6YaLKzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA715AF6
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062199; cv=none; b=XRetYOUGMqnu0XLIgwnLdVeutT0uygSXupAZn6jx6wPulyvS9p04v1MalJSOejXAXCc7zOKl6BBWLXG10aBjIuSi97xXbMdnWFiunlJnyzZIcxIqrOhoLtU05yDimnkbtuoIfry+kETnzVP/VfGSPkz/f6NraQZ1RQBwYVcXfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062199; c=relaxed/simple;
	bh=eAbd92YIK2R+VcrvjPqGGg4NCF+Faq0RSo7WGEIPKk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pC/uk1vNi0+G2zB7VpT367dNnSD3NNzMPJbjlkWekHKXpr3oq6atgAZKze5ucscCWNDkwKc01zBmoX3qX5HKuu+3pafBl86TkCAauiEGfqe/InyFsZczziNef6s83kqFAVifgbQg/SCSFQI78N201oe4k+kEjB88b/YyKei5sBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E6YaLKzf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 401913F731
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 03:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720062194;
	bh=ohrBX0V1iHxcURIO9c2jyrcgYuEKd6isy0JKLA+gdFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=E6YaLKzfwqSMYP8tGBF0rFTRA10w/TX9GgSFjF3chrMTrTGClts1HqeQbJ1kRyyYo
	 jXzT5Wh+Bt7LmGpgxGtMK4mBQxMBEnmgEMO02X5nZ47po6RwGR6ISfrexrvGjXbyVc
	 +CBNdDBSfM7nd6zOFLIWn7AtL7wv4aeEeG4NZXcpJJeWCHXsrYqSjMoGaABnTfrBFB
	 RVg2VXc9BOaiaSv7odgOR7EaL/lQkTKaUWHnlNt0zcQbdpysQVtJV2aZJuAX07Fg6B
	 e8bzZlCm9/uLsNMaa2WvrYovEdowxAVv49WBkg0VkghJ5D5Pdw1pSHgUue6/6AHSIm
	 Q+vnon41aY7UQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f70b2475e7so1151015ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 20:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062192; x=1720666992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohrBX0V1iHxcURIO9c2jyrcgYuEKd6isy0JKLA+gdFE=;
        b=IqAHX0Tx+cCcMncGV9n5UPf3Mn6vhSsmJ22tc8NrrGtdXHXNGZ3ehGt6phcmyxTzs9
         A9bfSW0F9c1YM6YMucc2D0BS9LVR/qI7FcvbgQMlGJSQMw5uOp8dn3Wc5R96hFEwsKv6
         jTIj9Qolkodlp22GtulA6s1LagSiXlnHfmuF52ZMUv418okM8jZSrMAuXIlZ76146gx0
         s/qrJc3+vXs5Zq6/O2nApLEzTinDhvKAFC61kS1NOEbK+ZQAXSfDp8WELRzwwoJQtgdp
         yFVKj7qzkADe1bhvhOK5mJ8anZx9/IaSoCLK4Q0uJkS35VSZUmtzgHlb38oyIyDcmMuz
         h0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjV7PBQQB7ey4DjTA3tcBvkQjYlhJr7Ct56QEvHkDMGKup9w3fbwSd34dyRuA3SPg+vrcHzYA20QETs278uhKDsP2LqpnNxpTo+ktn3rM=
X-Gm-Message-State: AOJu0YxwSspYbKC+rU9qEUuBxWVwP9U9es3RffRxFZJmaTazzUF9VypV
	2TqnkHBVe7mHMirhuawOhTAEJazlymwuIGW+Sqhw6+nGTUIYrbv43tM6suRmD7JOBYPvFdMnqWb
	5Zha3Q5J8Nt6OPU6UyrNa2SI+YM1TSL1FsAFvNQYTKxetu6Z/sGL24cUz/bTczOHlx7Tz6fOhi2
	6YWwwq
X-Received: by 2002:a17:902:724b:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fb33f0a61amr2494665ad.50.1720062192159;
        Wed, 03 Jul 2024 20:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEWUcskLLci8Rsep6v8yYezpc9Xezgy2DUGtZT7vj7K6+huCRlRjsCNdkhNYXQSR//GZHNQ==
X-Received: by 2002:a17:902:724b:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fb33f0a61amr2494145ad.50.1720062189756;
        Wed, 03 Jul 2024 20:03:09 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15967f2sm110803655ad.260.2024.07.03.20.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:03:09 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: kvalo@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	en-wei.wu@canonical.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Subject: [PATCH] wifi: virt_wifi: avoid reporting connection success with wrong SSID
Date: Thu,  4 Jul 2024 11:03:04 +0800
Message-ID: <20240704030304.16213-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user issues a connection with a different SSID than the one
virt_wifi has advertised, the __cfg80211_connect_result() will
trigger the warning: WARN_ON(bss_not_found).

The issue is because the connection code in virt_wifi does not
check the SSID from user space (it only checks the BSSID), and
virt_wifi will call cfg80211_connect_result() with WLAN_STATUS_SUCCESS
even if the SSID is different from the one virt_wifi has advertised.
Eventually cfg80211 won't be able to find the cfg80211_bss and generate
the warning.

Fixed it by checking the SSID (from user space) in the connection code.

Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")
Reported-by: syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/net/wireless/virtual/virt_wifi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 6a84ec58d618..86a8f74be654 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -136,6 +136,9 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+#define VIRT_WIFI_SSID_LEN 8
+#define VIRT_WIFI_SSID "VirtWifi"
+
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
 	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
@@ -146,8 +149,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = 8,
-		.ssid = "VirtWifi",
+		.len = VIRT_WIFI_SSID_LEN,
+		.ssid = VIRT_WIFI_SSID,
 	};
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
@@ -213,6 +216,8 @@ struct virt_wifi_netdev_priv {
 	struct net_device *upperdev;
 	u32 tx_packets;
 	u32 tx_failed;
+	u32 connect_requested_ssid_len;
+	u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
 	u8 connect_requested_bss[ETH_ALEN];
 	bool is_up;
 	bool is_connected;
@@ -224,11 +229,21 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 			     struct cfg80211_connect_params *sme)
 {
 	struct virt_wifi_netdev_priv *priv = netdev_priv(netdev);
+	u32 ssid_len;
 	bool could_schedule;
 
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
 
+	if (!sme->ssid) {
+		wiphy_err(wiphy, "invalid SSID\n");
+		return -EINVAL;
+	}
+
+	ssid_len = min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);
+	priv->connect_requested_ssid_len = ssid_len;
+	memcpy(priv->connect_requested_ssid, sme->ssid, ssid_len);
+
 	could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
 	if (!could_schedule)
 		return -EBUSY;
@@ -252,12 +267,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
+	bool right_ssid = (priv->connect_requested_ssid_len == VIRT_WIFI_SSID_LEN ?
+			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
+				  priv->connect_requested_ssid_len) : false);
 	u16 status = WLAN_STATUS_SUCCESS;
 
 	if (is_zero_ether_addr(requested_bss))
 		requested_bss = NULL;
 
-	if (!priv->is_up || (requested_bss && !right_addr))
+	if (!priv->is_up || (requested_bss && !right_addr) || !right_ssid)
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 	else
 		priv->is_connected = true;
-- 
2.43.0


