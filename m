Return-Path: <linux-wireless+bounces-21195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5527A7DE52
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695E53A84E6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CFA245022;
	Mon,  7 Apr 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="UULxuXYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D73235C1B;
	Mon,  7 Apr 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030629; cv=none; b=b0i82MMLsfOGww0qPio2cPTHSHxO1NfHXsXeDknk9PLcIORLjWVndEKpxg1CTc64NLyxdZx1+DOmphUnWg6ZztofCbG6KJtivN9Abkdk8Pzcqwp2hEQDAnrCd4CkQPa3vKncYjpMEa7Okfax0c10An2/De5KmFWtLu3JBX4v9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030629; c=relaxed/simple;
	bh=OEDiXzm/qmF3FRDqzM/+Zluxei66pUIJZ3pMWyOZlRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocSMRMsV1/6EXsdp8dbxDtKcNW+9h2OQpii0/TbBc8niIlwh8t1TgV5QkMtRFNSPQnGcyVOTtDkWLNJ2m06r9DRT7DJqVni6QD/O+kKqLao9El8gKzB7F3E6hkcZoEgO4/n1NepuyLbpjzOJslDEgtgKzMcNvzsif9fmKhP8RUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=UULxuXYy; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 9CEE3C002F;
	Mon,  7 Apr 2025 15:57:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 9CEE3C002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1744030623; bh=sa2g2wAUd2eSMwnZ40egS62F2SqkxAsInBEKx18r4X8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UULxuXYyffxed8UmMp20Gj4QYS1WpcN0Aw4dfwIx+REpEMzAAtMFsCNQ8AcT9Hbg8
	 E0uLGf+4C823kc2keH6lYx4ldh4pvk8hfp7AZnl6H5BRA3ALZdBlz1fJMw1fsIf5rb
	 lof/7Bkupjaj1AQBR1lWh5GWh/MQC0vZzOssbjqcZqReow+e6p8rkZIcahE2NwpVgB
	 T/dY6S04mPiIK6KcfLRk3DYzad4MBfQjQxN60iSpDXHbKB8Y8iWRtfn/ZCahs/OsxV
	 x2pbNbTePcTJWOKYzFKkuQUOh/hytuPH1HaHkhdMM1NdhtFu9ec2ahwv+gdxN42OWy
	 Dah7X6Tf7jJqQ==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  7 Apr 2025 15:57:03 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 15:57:02 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 1/3] cfg80211: Restore initial state on failed device_rename() in cfg80211_switch_netns()
Date: Mon, 7 Apr 2025 15:53:42 +0300
Message-ID: <20250407125345.1238818-2-i.abramov@mt-integration.ru>
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

Currently, the return value of device_rename() is not acted upon.

To avoid an inconsistent state in case of failure, roll back the changes
made before the device_rename() call.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 04600794958f ("cfg80211: support sysfs namespaces")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/wireless/core.c | 47 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9e6b31903121..e4d353ec9436 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -169,27 +169,17 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 		wdev->netdev->netns_immutable = true;
 	}
 
-	if (err) {
-		/* failed -- clean up to old netns */
-		net = wiphy_net(&rdev->wiphy);
-
-		list_for_each_entry_continue_reverse(wdev,
-						     &rdev->wiphy.wdev_list,
-						     list) {
-			if (!wdev->netdev)
-				continue;
-			wdev->netdev->netns_immutable = false;
-			err = dev_change_net_namespace(wdev->netdev, net,
-							"wlan%d");
-			WARN_ON(err);
-			wdev->netdev->netns_immutable = true;
-		}
-
-		return err;
-	}
+	if (err)
+		goto errout;
 
 	guard(wiphy)(&rdev->wiphy);
 
+	err = device_rename(&rdev->wiphy.dev, dev_name(&rdev->wiphy.dev));
+	WARN_ON(err);
+
+	if (err)
+		goto errout;
+
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
@@ -200,9 +190,6 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 
 	wiphy_net_set(&rdev->wiphy, net);
 
-	err = device_rename(&rdev->wiphy.dev, dev_name(&rdev->wiphy.dev));
-	WARN_ON(err);
-
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
@@ -212,6 +199,24 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	}
 
 	return 0;
+
+errout:
+	/* failed -- clean up to old netns */
+	net = wiphy_net(&rdev->wiphy);
+
+	list_for_each_entry_continue_reverse(wdev,
+					     &rdev->wiphy.wdev_list,
+					     list) {
+		if (!wdev->netdev)
+			continue;
+		wdev->netdev->netns_immutable = false;
+		err = dev_change_net_namespace(wdev->netdev, net,
+					       "wlan%d");
+		WARN_ON(err);
+		wdev->netdev->netns_immutable = true;
+	}
+
+	return err;
 }
 
 static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
-- 
2.39.5


