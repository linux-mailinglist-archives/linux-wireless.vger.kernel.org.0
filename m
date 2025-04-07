Return-Path: <linux-wireless+bounces-21196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A8A7DE53
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BCC3A84D8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37922F167;
	Mon,  7 Apr 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="Lwgl87fO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2923236A;
	Mon,  7 Apr 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030640; cv=none; b=QuUZ1BH1ft4bReCMiEIDhZgqTZYLspadJfQpQ5t7NV3FeV9nxyRB968FB9q8LssXkm7s3qi+QMUqKtJofvD38lx5ehgfYh7e/ES2ua4q0lfneJDkzcDs7vwY5QDisjaCUXxplZ6r6rBKOWVGCGcI8utUA7CBIQd0NNOoe+MboR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030640; c=relaxed/simple;
	bh=GjgB/1b6yL6S3GjYO9vvjZ66PvP14a5uu6KhaZ3tFBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3bE75mPh0YnxEXYKbEj+lcrQb6ZzSb75EXkgua04fDi1UE6v552ga2JNd+YrvaDXk3LmoXisC6rKHuxkYtfZD9zigASkoYmdtUD7NHPIrE9MxkrA0dwNw8YO8t8TiDO+2AlpIr2HV7Qob1WjZFStMGOaVFaQHBDANGmwKHbRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=Lwgl87fO; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 6CF2DC002F;
	Mon,  7 Apr 2025 15:57:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 6CF2DC002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1744030633; bh=LEEYx4z9+X0y1G9jyn3zn5zkjA2VHvliyo1xxFpgzy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Lwgl87fOYI/MKzNwwOpNEZJJHXKQaGQ1/LKVQWTy9azhf/jd4WMRqC7KetCziPKEz
	 KcJ4SbhVQ3D8foqMlX0tazcCm8uCJDR3zP+Dn8MLg3ywml/YnK+FK/jyeu2IfowLW7
	 FRFx2GriJHWvBYjNaIoExv9LDdibWpR+f8Kz0u5BVnThxEh1vz1f6ztvhHFrf0onHJ
	 636JyDNP6w8So9iTG+0H2KeZzTjPEesBoU+DJ+wT8767we8aommTe9cpeRZyTQXrAT
	 mHMqQMB95DtSBcHi/Z2MXYQk1AMv4Lhhu7aILqjcNYlZySiuZIPs6hAefB2SdpV7oK
	 51nMU+BL4GAWA==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  7 Apr 2025 15:57:13 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 15:57:12 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 2/3] cfg80211: Avoid calling WARN_ON() on -ENOMEM in cfg80211_switch_netns()
Date: Mon, 7 Apr 2025 15:53:43 +0300
Message-ID: <20250407125345.1238818-3-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
References: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192430 [Apr 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/07 08:57:00 #27861720
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
dev_change_net_namespace() and device_rename(), since it only leads to
useless splats caused by deliberate fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 04600794958f ("cfg80211: support sysfs namespaces")
Fixes: 463d01832385 ("cfg80211: make aware of net namespaces")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/wireless/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index e4d353ec9436..6f95aad18d47 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -164,8 +164,10 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 			continue;
 		wdev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wdev->netdev, net, "wlan%d");
-		if (err)
+		if (err) {
+			WARN_ON(err && err != -ENOMEM);
 			break;
+		}
 		wdev->netdev->netns_immutable = true;
 	}
 
@@ -175,7 +177,7 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	guard(wiphy)(&rdev->wiphy);
 
 	err = device_rename(&rdev->wiphy.dev, dev_name(&rdev->wiphy.dev));
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	if (err)
 		goto errout;
@@ -212,7 +214,7 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 		wdev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wdev->netdev, net,
 						"wlan%d");
-		WARN_ON(err);
+		WARN_ON(err && err != -ENOMEM);
 		wdev->netdev->netns_immutable = true;
 	}
 
-- 
2.39.5


