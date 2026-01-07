Return-Path: <linux-wireless+bounces-30431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE8CFCED5
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A287E30B370B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DF312825;
	Wed,  7 Jan 2026 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ejoapbyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E9312814
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778079; cv=none; b=SmggjiU/a4DpkD83APnA1RxtjTs2wtXr8THKhflXtaZMIaLwP2Lyt04vTdEdvup4lwTXHGwhpUZ9EKSYOxPvni1GgdkvOjpUWW3bGYMk7jtpUFSwCOsklh+UaQj3s+ugoqo8svDxVlP+Dejc6nd8TtfRdMjN0aSkp8EYXHHp1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778079; c=relaxed/simple;
	bh=g1WA3hhzcBNKCpDwGVcvqg8QcHrAEKl4kdMa8V2XFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+2bwQzCn4fSXtnDsc2QDcoikq1zTZeJuLLCKHh2+OPa4a+UC92A6WvRwLbdz5Ff2uO0v6SdZVsneAH5Bu8vRsvNo4AtJQkjUSTv50G0VR9rSWFgbzdJPpzHbwE+Zs+aBj6S3PSYSuUT9cG54Br8BnoEmlosdoPbpQH7M6+iLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ejoapbyb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so1663965b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 01:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767778077; x=1768382877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhb3q7cnQYnbFMmPVM1DpAFU8aH9HqYVVJx0dsKwbns=;
        b=EjoapbybuO41INYTRfNfb4DZP8PakMQZO7+jZ7I1YtfR99b4++DlAu0I0eV5IcrNeM
         a59Ba1dTdWDeQv4oQtORGlj5T7pEK4lSKGF28Y4FAMSggtVp51ExABOoszNd/+ZJX4H0
         kCEA+U9v6rF9fOoaMthGiTb3kS6fVEHh0s4r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778077; x=1768382877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhb3q7cnQYnbFMmPVM1DpAFU8aH9HqYVVJx0dsKwbns=;
        b=KBa3czXfF338NElaWJjOWdVkbPF9wQVxaes5E00D0KUoi9quDJsJcewOBVTFQyQ7VU
         OMwnwKv5mI37q34lsdV3aNG2qw6Qi42FzxiIoN/eblvmkbV8SZx4CgFvDw45ZWUiXrYp
         fP/o44jEy8qQy2Hw3PoaHNgTXB+t0sev2B1kjv5Ew3mF2x4zesYYebjQ2UVzi5GJEn3B
         2xOrPUQAT9HzShkJQaCmWrZbV2jpg0WjwB6rMTVUg8TdBC3ROnL/DhYHgiLkSiH50unl
         PwOxrfqOIPNNxkXS5dPv4HQ7q+ZTPN0R/a5nXMWPc3qkSnOx3Ix2FhAj20Bu/FJ4QC44
         WqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV71r3S29MBvCXbURC4Jcg7g5l3hfWW/yhZV9ma080nYB0DPmrnBKFyk4AIleyAYE6ZRc7qcAQn4rXX7WGVnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxgr3ww9Inpr39UjrifQ/gDPNhc2yObCz7dXHw06UXLQh9wa8u
	TnuTGB99szPkJyHPCSGHfxh3D+BPnElQh5k/a2YHRo0ZPvh3IcQXGt0GQAz35wSg1tj8lUmVnXL
	E44g=
X-Gm-Gg: AY/fxX7ZCf+YCDstg+A78lHT/vkueEqRjX5/tKl6x+2BlRB5mN8SVb6vGBxVT1ma7wM
	xEGrbvf0nShoElWBYQTqHhcj8zoYOgDGfaaZLvFw2vP8BiZPLbG/tZHOL3GJRSrqnRdwEx8T8sd
	9lNwE2zGQLllwQK3lmFX1FQ/cNHfTjnjZ+fwwvVqQ2Mf2SSAds4Sr+HZu57Y+VMobhxSonITpWM
	56/T3aLIm2MnhveZZoMqv4Y6FP2UaS46LHzjBQXB3lDiSglXjsxuoIhHaTr4eShna1Fn2jy3rPz
	yqgScYaSZbjhQR/p05+de5n05LSvOYmqXaA9JEijC9YM2fypHBL0pA6nhjJMhVwnuChkhY7S75H
	evSnb+uSydNpThxz9TXdQh+7FNVwCv3icU8tz+7tfITxSIXF+mvkst6oIegNvqBdchy0DqGn1+W
	bb9XARoDjQ7h+e7Pa8AaUkSvS+zprig+CjowVyD33W1JkinQZJkQBz5N181Q7kMFE=
X-Google-Smtp-Source: AGHT+IH62OQ3bsUsVU2frgQ+oZSI7idoa7HhgVZkXQGFx50QzusA3hyEAliOKuIBKTn+v4gQcTVwyg==
X-Received: by 2002:a05:6a00:428c:b0:7aa:5c32:17a3 with SMTP id d2e1a72fcca58-81b7de5bed3mr1632625b3a.17.1767778077338;
        Wed, 07 Jan 2026 01:27:57 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:fab:ea:9a9:a24f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e983fsm4428163b3a.55.2026.01.07.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:27:56 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Allocate dev name earlier for interface workqueue name
Date: Wed,  7 Jan 2026 17:27:40 +0800
Message-ID: <20260107092744.1131314-1-wenst@chromium.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interface specific workqueues are allocated with the interface name
as part of the workqueue name. However when they are allocated, the
interface name has not been allocated, thus the "name" is actually the
pattern for the name "mlan%d". This ends up pretty ugly and could
conflict if multiple interfaces were added.

Allocate the device name earlier and use that to allocate the
workqueues. Also tweak the workqueue name patterns to add a separator
between the prefix and the interface name parts for readability.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index be23a29e7de0..a66d18e380fc 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3147,10 +3147,14 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 	SET_NETDEV_DEV(dev, adapter->dev);
 
-	priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC%s",
+	ret = dev_alloc_name(dev, name);
+	if (ret)
+		goto err_alloc_name;
+
+	priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC-%s",
 						  WQ_HIGHPRI |
 						  WQ_MEM_RECLAIM |
-						  WQ_UNBOUND, 0, name);
+						  WQ_UNBOUND, 0, dev->name);
 	if (!priv->dfs_cac_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS CAC queue\n");
 		ret = -ENOMEM;
@@ -3159,9 +3163,9 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 	INIT_DELAYED_WORK(&priv->dfs_cac_work, mwifiex_dfs_cac_work_queue);
 
-	priv->dfs_chan_sw_workqueue = alloc_workqueue("MWIFIEX_DFS_CHSW%s",
+	priv->dfs_chan_sw_workqueue = alloc_workqueue("MWIFIEX_DFS_CHSW-%s",
 						      WQ_HIGHPRI | WQ_UNBOUND |
-						      WQ_MEM_RECLAIM, 0, name);
+						      WQ_MEM_RECLAIM, 0, dev->name);
 	if (!priv->dfs_chan_sw_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS channel sw queue\n");
 		ret = -ENOMEM;
@@ -3198,6 +3202,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	destroy_workqueue(priv->dfs_cac_workqueue);
 	priv->dfs_cac_workqueue = NULL;
 err_alloc_cac:
+err_alloc_name:
 	free_netdev(dev);
 	priv->netdev = NULL;
 err_sta_init:
-- 
2.52.0.351.gbe84eed79e-goog


