Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE472B3E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGXJQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 05:16:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfGXJQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 05:16:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4F2B602A8; Wed, 24 Jul 2019 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563959780;
        bh=4um6Z72cI3pcPlgq9f4r25PCw2rtwQDCWwglrF2iJJU=;
        h=From:To:Cc:Subject:Date:From;
        b=a+9sJa2KKlG4LPQm4L80m04YX32/Pbr+3p69WmZotuiDnlYGnjatux0NOifWw8iCv
         BMRjEavrhNRh97BGkW1nv1RKGk6IPvIWJvyTYm/u1G56LiOMWmqd+rUvvNBaOF1YSZ
         iWnNS9WFxRnDpOwtXkHFcJmdhUDpKQEYhwZ/vYtM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8E96016D;
        Wed, 24 Jul 2019 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563959780;
        bh=4um6Z72cI3pcPlgq9f4r25PCw2rtwQDCWwglrF2iJJU=;
        h=From:To:Cc:Subject:Date:From;
        b=a+9sJa2KKlG4LPQm4L80m04YX32/Pbr+3p69WmZotuiDnlYGnjatux0NOifWw8iCv
         BMRjEavrhNRh97BGkW1nv1RKGk6IPvIWJvyTYm/u1G56LiOMWmqd+rUvvNBaOF1YSZ
         iWnNS9WFxRnDpOwtXkHFcJmdhUDpKQEYhwZ/vYtM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C8E96016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] mac80211: reject zero MAC address in add station
Date:   Wed, 24 Jul 2019 14:46:10 +0530
Message-Id: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't allow using a zero MAC address as the station
MAC address. so validated the MAC address using
is_valid_ether_addr.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4f12d04..cf97b07 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1539,7 +1539,7 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	if (ether_addr_equal(mac, sdata->vif.addr))
 		return -EINVAL;
 
-	if (is_multicast_ether_addr(mac))
+	if (!is_valid_ether_addr(mac))
 		return -EINVAL;
 
 	sta = sta_info_alloc(sdata, mac, GFP_KERNEL);
-- 
1.9.1

