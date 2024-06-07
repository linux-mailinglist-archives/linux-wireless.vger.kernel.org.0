Return-Path: <linux-wireless+bounces-8681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB39900092
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8FE1C219A2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8015B14A;
	Fri,  7 Jun 2024 10:21:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE802156F5A;
	Fri,  7 Jun 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755662; cv=none; b=ojytE89jeLCSJ2zd/fDISk2RRySW2lAO0Iznwy7JTe4dfBsb/AIDRzwhZ7mD1Yrq+xu1VOR58dBUfTZS6Hu7ljswcl3uigytP1ZXLOjl1LuObDg7n6mC4AUEIQqv9SwiMcGrvDNffF/dwBdGNYwDilHqq/6ad9+ww1sIT2cpQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755662; c=relaxed/simple;
	bh=nd+4BToiRJXLGGA3mTGlxCpZ4MPw9XkWR9N7avm/dGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evnW25N8fOvFbXhs+WUCAunc2eemQfQZ2EJhXl+I8M15PZaBq0s6IYArIE0mICGJ8xBH1TZJD0G13BFRMsnqgzjMDeqO9qOlWlljKXQapjB8X5Is+kgO3p1f4BBZ91xWC1GXVyPP70ymqCegvG4c+VqXAQWVLobNvMW9q3XzPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso41964866b.2;
        Fri, 07 Jun 2024 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755659; x=1718360459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wleu//OAE2cyfcBt+2g23v6CQm8bhtCW5SGTOJfzMc=;
        b=sw0Oxrroaq2bA4fbpgrPmgkbPMuAOAKXKyXx8PNktZUlu3VUx8wdYlogreO+Dw5hdQ
         CEy2gSsMCserFOBvI2mzpIxAkZT0ges901m7nrc8hU4wTCFVB1HTQ58gU/tJzNPDLQ2r
         hMTWVE3FHupWkL1r/K01pJ1uAYpktXEaQJG+iF5FWzke2gFqw+A9FALF28K9arQtKRgj
         nC4dq1w4b8EFNi+ft0mq38gu9wju2AUYYpxabewAQ9U9Q29lsolJePi/Y0XnTFgafGMC
         m4B0AR7cDiwvsyTZBJN1f7HHCVrjZZE8I/GW/DIycejeb9bSE+43mx++jF5V6f5Nr7Lm
         2Tow==
X-Forwarded-Encrypted: i=1; AJvYcCVuPGD+TcfWfFgaBZ4VKu2VOU/c8AJIpE3LUJcT7m+PR+yLN2sIL5bq/tbxyXbj7q1AVWJ9xGP5e7gITeTUM7cexvhPhuKn8dFrfyF+lkJsjuU8ZvBOxDAoddrxSPdmMx9NZRZwEf8sshumVWeF0czX4r2oLxrOfl6fF0B0KQb0wEZh0vk=
X-Gm-Message-State: AOJu0YxGOGI3JvJxfiBSc825ZOrWpHzlnUXSnN1E8NdB2ZPQ/w89XQiy
	qLsALdMTVbg5dmYv9Eo7JfTeD+63/uo8OsGA3KR/htns9WYk12o7
X-Google-Smtp-Source: AGHT+IEyyLJRYOtiSgR04GeTyfW24MKvLfnpXDDvS3JofL34QAj8qDmKfpKJ/W6nPTYpqmlU81mH7w==
X-Received: by 2002:a17:906:11c8:b0:a6c:704b:cff1 with SMTP id a640c23a62f3a-a6cd76a9344mr136254766b.41.1717755657977;
        Fri, 07 Jun 2024 03:20:57 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581a7esm226683666b.36.2024.06.07.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:20:57 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	sbhatta@marvell.com,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wifi-next 1/2] wifi: mac80211: Move stats allocation to core
Date: Fri,  7 Jun 2024 03:20:43 -0700
Message-ID: <20240607102045.235071-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core instead
of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Move mac80211 driver to leverage the core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/mac80211/iface.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..605305cb3ff2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1458,11 +1458,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	return res;
 }
 
-static void ieee80211_if_free(struct net_device *dev)
-{
-	free_percpu(dev->tstats);
-}
-
 static void ieee80211_if_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -1470,7 +1465,6 @@ static void ieee80211_if_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->netdev_ops = &ieee80211_dataif_ops;
 	dev->needs_free_netdev = true;
-	dev->priv_destructor = ieee80211_if_free;
 }
 
 static void ieee80211_iface_process_skb(struct ieee80211_local *local,
@@ -2101,11 +2095,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
 
-		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-		if (!ndev->tstats) {
-			free_netdev(ndev);
-			return -ENOMEM;
-		}
+		ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 		ndev->needed_headroom = local->tx_headroom +
 					4*6 /* four MAC addresses */
@@ -2118,7 +2108,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		ret = dev_alloc_name(ndev, ndev->name);
 		if (ret < 0) {
-			ieee80211_if_free(ndev);
 			free_netdev(ndev);
 			return ret;
 		}
-- 
2.43.0


