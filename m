Return-Path: <linux-wireless+bounces-10001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF9928079
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 04:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737C2284D43
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65901D530;
	Fri,  5 Jul 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M+Bdeuq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEC17BAF
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147092; cv=none; b=RKaPw4A7ELt2vWAgob4AvygI1SjKXVH1sfu/rRkhXl+Pws04nw81m58GtOviCEdj9N+dJA4FRzU/uxH1X+3mMlkXYqPLX6V9NBaxbpbAQ5RZrdac/uJpLsU/ZKm8zUZimUApax8AcCLfZ7TLZncJSq2V6DKgIzkjN527xNLrfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147092; c=relaxed/simple;
	bh=EiUsjHRGV+CmXkYgd4nm9b/6HTSZKdNoOGkKIGlBrPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHaH9owDV/ZRo/lhdyauXUpKex/AV9zkAOBvyc5r39GvsQxoLxUGQjbyVnDxClDckfsgigzDrnxYJlHBgnroXXyiw5c73hNBttwblzqqeGI8/U6yWPNBBHjPnv9MdGR+XJlsxGlW0dUqw2/R8tjcHk10cgypJZM1AA6B7outehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M+Bdeuq9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F7C53F6AF
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720147083;
	bh=giOuHUYB8wMySa0UyWvQdDBmX9/kmwZ2Xcw9Co/IFF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=M+Bdeuq9DJmweeVn63suUNU5GiFDJi2rDoumZEsfoyMl6xrH+SEdbf+4hF0MazyGC
	 okm230cf+BwsXgK3JE3LzwP85RFxtWo7GJqVjS/emAfV/Zq21zJlGXV6ZtJHKTLRqo
	 yJ5S+p2gq7TR3Z3Q1QfRUM4VMuxMNP4jOzagSIfNKXJyhnbd27Pq7a58qDGNvhpFca
	 WqndjpAHc1Uv99tld9Y+IO2ZhP2br5Um0uMo2Fz4oX4U85Ly3BusAcCfwt3W/fmSU6
	 UIon9n5vtolRlAZ4fwMOu64jHq/AomuWsoVkH97IAb0PKjJ5oldjQ19CBy+f7klw1l
	 URzhjNGDF0sQA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c924a5edaaso1192947a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 19:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147081; x=1720751881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giOuHUYB8wMySa0UyWvQdDBmX9/kmwZ2Xcw9Co/IFF0=;
        b=UcBeNnQmWQWipzLfCVl/QzZhRve2YYHcciGrUwP9iOjGCiZEdKla94e5WAQ4X/UPvV
         adfWPClMTG80vh4U9MjoZTG2gmxzqgWdWsZdczHTn4PICpP/YP22xDeSmoiQcYuxwwE/
         PB6RdtHJ0ijHU253hcxS4LWmnQlrpUrpp1/hhep7UXLpVSehuOz74x13XLtCRMqjH342
         CHgDt3bU9xl9dcnY6hIrtGS+K8U8KPzOkS3ro0Protl2zGITn4RtNl1Fr4IRKuy9LADg
         SAXvCJDQe8jANh7pNtbyMxWqX/y7Xt1SLO9QcRigZg62l+qyn1pEL2/hFr0VvL6xYWtV
         bC7w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5ph44Uh/LUCouuts9RJ17V7NPdOot8HIU73S6p0In/JW7L4s3387EQn601wyfyxQFeXOF9kilNje+VViIxZV19moJ86m3nEXXtgrVmY=
X-Gm-Message-State: AOJu0Yxd/qUxrdLM9cvx3aWEkjVnsl3X293+jnzh6q2AxKXHJe0IB6qS
	5cHfx8sAow9WwULtdxgrSo3spDyu+l+6IzIRxfi+qmk33HMlcHcwiiOWf8BQwqI4QdIoeC8a7Iu
	AxnCDB8O/h9kPlAn8eCwyRNDjqHzTUWDlyRjptzSJJyAFj/IgIG3AF4J6c3WTU9VFppi4jzvbgK
	w8y0Px
X-Received: by 2002:a17:90b:d8b:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2c99c32bb92mr2891180a91.0.1720147081361;
        Thu, 04 Jul 2024 19:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7odhywr3x+omb6miX/bRdJpFgq99cmMPkm57azjTm6SAhOCuNgPBP9pLJxVuxosgSvnM5w==
X-Received: by 2002:a17:90b:d8b:b0:2c3:40b7:1f6d with SMTP id 98e67ed59e1d1-2c99c32bb92mr2891172a91.0.1720147080991;
        Thu, 04 Jul 2024 19:38:00 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a81e503sm2268029a91.0.2024.07.04.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:38:00 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: johannes@sipsolutions.net,
	kvalo@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	en-wei.wu@canonical.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Subject: [PATCH v2] wifi: virt_wifi: avoid reporting connection success with wrong SSID
Date: Fri,  5 Jul 2024 10:37:56 +0800
Message-ID: <20240705023756.10954-1-en-wei.wu@canonical.com>
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
Changes in v2:
	- adjust coding style
	- remove unnecessary debug message
---

 drivers/net/wireless/virtual/virt_wifi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 6a84ec58d618..d2271a7644a0 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -136,6 +136,8 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+#define VIRT_WIFI_SSID "VirtWifi"
+
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
 	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
@@ -146,8 +148,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = 8,
-		.ssid = "VirtWifi",
+		.len = strlen(VIRT_WIFI_SSID),
+		.ssid = VIRT_WIFI_SSID,
 	};
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
@@ -213,6 +215,8 @@ struct virt_wifi_netdev_priv {
 	struct net_device *upperdev;
 	u32 tx_packets;
 	u32 tx_failed;
+	u32 connect_requested_ssid_len;
+	u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
 	u8 connect_requested_bss[ETH_ALEN];
 	bool is_up;
 	bool is_connected;
@@ -229,6 +233,12 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
 
+	if (!sme->ssid)
+		return -EINVAL;
+
+	priv->connect_requested_ssid_len = sme->ssid_len;
+	memcpy(priv->connect_requested_ssid, sme->ssid, sme->ssid_len);
+
 	could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
 	if (!could_schedule)
 		return -EBUSY;
@@ -252,12 +262,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
+	bool right_ssid = priv->connect_requested_ssid_len == strlen(VIRT_WIFI_SSID) &&
+			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
+				  priv->connect_requested_ssid_len);
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


