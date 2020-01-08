Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8571348CE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgAHRGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 12:06:34 -0500
Received: from nbd.name ([46.4.11.11]:36460 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgAHRGd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 12:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=38SI0OWwuUqT0gGsBOu+go89uE3cghIj39aRp31c7Ic=; b=Y62P9UaK8x62GUPQ0D6MOVUqR/
        1TKbxPW0mJAfoJC9jveJE6+Qek28jf7RbzhrrQ7+Ydxu84jJi3s2e5f30hTfUGtty1HPUvJXLGGBP
        YCykpV9wSGmuFWVXv2vVhOGfENXx4jWT55MgsdANYUUQK3UHRoICqZgeYhpPt2EujeTE=;
Received: from [217.114.218.21] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ipEmt-0008CQ-Or; Wed, 08 Jan 2020 18:06:31 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 05C33770B712; Wed,  8 Jan 2020 18:06:30 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.5 1/2] cfg80211: fix memory leak in nl80211_probe_mesh_link
Date:   Wed,  8 Jan 2020 18:06:29 +0100
Message-Id: <20200108170630.33680-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The per-tid statistics need to be released after the call to rdev_get_station

Cc: stable@vger.kernel.org
Fixes: 5ab92e7fe49a ("cfg80211: add support to probe unexercised mesh link")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da5262b2298b..73e1430c7ac5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13796,6 +13796,8 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	cfg80211_sinfo_release_content(&sinfo);
+
 	return rdev_probe_mesh_link(rdev, dev, dest, buf, len);
 }
 
-- 
2.24.0

