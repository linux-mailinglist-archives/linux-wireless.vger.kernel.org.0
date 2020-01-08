Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FE1348CD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgAHRGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 12:06:33 -0500
Received: from nbd.name ([46.4.11.11]:36458 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgAHRGd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 12:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YHvMwTEucT6PMku9udp5ErJhGFDrBf/G1+2ch4qbZ7I=; b=MbVAnA1XOWMwnFAoe+kF9xs8HH
        k+XDVfLvtVSHv+nitawHe5NWu2UG+Up3NnR57/fKTOPl74B2vmEqfY4XmQNg+tQM33UqAprmQwQwX
        TeRvjE5sZlu444ZMFRf8hFg42QxsLInyRpMOnABw18pX9qkkbxP838hIFrvzE70exWz4=;
Received: from [217.114.218.21] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ipEmt-0008CP-Os; Wed, 08 Jan 2020 18:06:31 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0105B770B711; Wed,  8 Jan 2020 18:06:30 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.5 2/2] cfg80211: fix memory leak in cfg80211_cqm_rssi_update
Date:   Wed,  8 Jan 2020 18:06:30 +0100
Message-Id: <20200108170630.33680-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200108170630.33680-1-nbd@nbd.name>
References: <20200108170630.33680-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The per-tid statistics need to be released after the call to rdev_get_station

Cc: stable@vger.kernel.org
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 73e1430c7ac5..1e97ac5435b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10843,6 +10843,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 		if (err)
 			return err;
 
+		cfg80211_sinfo_release_content(&sinfo);
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
 			wdev->cqm_config->last_rssi_event_value =
 				(s8) sinfo.rx_beacon_signal_avg;
-- 
2.24.0

