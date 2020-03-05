Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3E17A1E9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 10:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCEJGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 04:06:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44636 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEJGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 04:06:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id y26so2447858pfn.11
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2020 01:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MlXeFdRN5tB3w8Bo0VrxQRMXlvi/qB14o5wGpgmD9kc=;
        b=jJLmIYAd5gRXCFhLg1VtQGk0w+nv1kAs4dtlQpD9+Okc+rPGTTi5yOWwpTzGEEBnG5
         Y8W6N9BUDk+iu2m6f/aLBlrWdyaF4O5jXWWR5uXdU5gF5YLhLJgXSETPG2qp80VZnGsx
         83FGNocunfycpqZ+44YwSKSKNKzaMVJ2ajDwinE9zA7tO8YGV5O+NqyFgExAZOip9IGG
         0hijeS4MKmOEPSpEcJrZSbmWHLK4UoYZ/Lp8rO88T5JA2MQxCO0TyduP2s4/es5x6v5+
         Q4qJtREEvq598GzaeiJAxG1ENJB9PGchuGz1Pkb+/qc36uytMExxF4xX7USaCCM+N1/m
         r6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MlXeFdRN5tB3w8Bo0VrxQRMXlvi/qB14o5wGpgmD9kc=;
        b=gmbgCbhd/9jJbuPQ+ny4RzfJBUhpiCA9AuZH2VO/WaIrV1LrAWiESSkW4V8lFFtmP9
         b6fGcZJ1IYYLYsd7dWNObHNeopp54smEpcJDYYsU2s4k9wxjszifAxYAVqvfNN8RS9ag
         4B04Gtf0FOdvLHLAAnL3uaibMuBYPAnSizKfemyUdYHe990cQht5g+BS8q/m2KM9JsOW
         Eo/G3YKYCjOJY+pTATsuk2eSNsKC9AMb9ih9JpMn2outzV/kUpOP1A7S5e1MmVHlleC6
         aLZQ89g9tnV64S/GV8RUJeVtvaroXs4nqy/WJWYLHg0QCrsGFOBPMGY2fzCZ2IoZU7vR
         i4fg==
X-Gm-Message-State: ANhLgQ2KU2mdrqCoN1myantro4CMDRsONqbOlez6Xu0KOJRQqCiXcIJA
        CVEih3vBEJI8+fZgP3G7NV8=
X-Google-Smtp-Source: ADFU+vv3cLjblQg26tHOsfdFLkzzrt3Xz51MrxsGk/p4kHUhUxWEKeeKYnxWMMZrAy1z8ZVCF7dimg==
X-Received: by 2002:a63:c304:: with SMTP id c4mr6805084pgd.85.1583399203921;
        Thu, 05 Mar 2020 01:06:43 -0800 (PST)
Received: from localhost.localdomain ([180.70.143.152])
        by smtp.gmail.com with ESMTPSA id h12sm14811296pfk.124.2020.03.05.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 01:06:42 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH mac80211-next] virt_wifi: implement ndo_get_iflink
Date:   Thu,  5 Mar 2020 09:06:36 +0000
Message-Id: <20200305090636.28221-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

->ndo_get_iflink() is useful for finding lower interface.

Test commands:
    ip link add dummy0 type dummy
    ip link add vw1 link dummy0 type virt_wifi
    ip link show vw1

Before:
    9: vw1: <BROADCAST,MULTICAST> ...
After:
    9: vw1@dummy0: <BROADCAST,MULTICAST> ...

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/wireless/virt_wifi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 01305ba2d3aa..c878097f0dda 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -436,10 +436,18 @@ static int virt_wifi_net_device_stop(struct net_device *dev)
 	return 0;
 }
 
+static int virt_wifi_net_device_get_iflink(const struct net_device *dev)
+{
+	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
+
+	return priv->lowerdev->ifindex;
+}
+
 static const struct net_device_ops virt_wifi_ops = {
 	.ndo_start_xmit = virt_wifi_start_xmit,
-	.ndo_open = virt_wifi_net_device_open,
-	.ndo_stop = virt_wifi_net_device_stop,
+	.ndo_open	= virt_wifi_net_device_open,
+	.ndo_stop	= virt_wifi_net_device_stop,
+	.ndo_get_iflink = virt_wifi_net_device_get_iflink,
 };
 
 /* Invoked as part of rtnl lock release. */
-- 
2.17.1

