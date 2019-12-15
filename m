Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590AA11F884
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 16:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLOPdj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 10:33:39 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:60436 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfLOPdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 10:33:39 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 10:33:38 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bSqP2C3qz9vYfN
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2019 15:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zyTL2-8SGFB5 for <linux-wireless@vger.kernel.org>;
        Sun, 15 Dec 2019 09:24:01 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bSqP16QMz9vYfM
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2019 09:24:01 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id d198so3739198ywa.17
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2019 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXeOuc0B3gYX32LabDU9f+RSGbyw1wcQBHVeANF/Ibg=;
        b=gFbnXdjz2JyDs4kf8BW4QAMQEHuYlzIExGtIGz08EPf7yeUz69r2qyT9KH+d6UHKYD
         +8Y68qzOIDZjoC/J/jbi/P+wfQs+Ts54xVgQNcRO570Hu0dMRXd2kpxg4sVOQFF7rltE
         5hqGsoOLgKmq0/4sEYqHVWCiFKXmHBgYJdsG2+YCSeKjNTJW3EGZtWqAy3/lrDv5wm6y
         QU2i0RKp0HvZuZF4i3elIn/MjXO7LBHPV/lWHDNK8k3C33mOoZq9EV1HlAqMac7v+YMH
         x90F2rZA0JpnodY+TigIVIH/qhsKVxsws4grBrtIq1w8VRJIqe/5lAYf+2f4ihzU79Z+
         WMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXeOuc0B3gYX32LabDU9f+RSGbyw1wcQBHVeANF/Ibg=;
        b=TJFJ8U3eJIyFJLTKsCdBddPiUrKST5L2IdyY9QF/4FA1dgk3S39zXjGVTanHyqO5PA
         qsMFC7iZoGIizSvL8xMGSvRDYZnnYlb16aqhJ8T/sGNU72r1b48p+BQ/7BnhkYplpD68
         /BJUJqGSjJfoWkgLlYEYn4SonoL6rG3Qv8TD/9m8lSKlit18FK1ejKx01SconxcCBHw1
         4vNES4xOpzReNkpCJ7+b9qv27ZOK8Vi0QzoEJ0KFNRGMU9v5HJyaL9E5MDDORr7/NY/I
         VudcaidVNo5e5AydkXWw8bUGKqsAUVo+H6+lUEIjHVUeVWefgYvVHi8CJkegfmq7p/qC
         7e2Q==
X-Gm-Message-State: APjAAAUgGVWnbUEt/udAMcm8uMh1VCBhgJpNK9jPHFDyLnFWPfzty51R
        Rq8pobv+jYf6QobYp3t9TuBeKf88dGD09cX8VDuxEnTh+p5mh+MPS8TPLxYkTELfYoADAVkMJXC
        hfDXs9xrYDG91hqFIsiqYTq7au1ibSaA=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr12866653ybc.69.1576423440623;
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmH7sFfvfBy1cep+91o5KmIInPx1Yz9wIMEp9QMF/hlEh4qqQVE73XWTB1gu0XWKPd9zKF2g==
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr12866635ybc.69.1576423440363;
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id b192sm3235899ywe.2.2019.12.15.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: Remove redundant assertion
Date:   Sun, 15 Dec 2019 09:23:48 -0600
Message-Id: <20191215152348.20912-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In wiphy_to_ieee80211_hw, the assertion to check if wiphy is NULL is
repeated in wiphy_priv. The patch removes the duplicated BUG_ON check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/mac80211/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c0..780df3e9092e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -39,7 +39,6 @@ const void *const mac80211_wiphy_privid = &mac80211_wiphy_privid;
 struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 {
 	struct ieee80211_local *local;
-	BUG_ON(!wiphy);
 
 	local = wiphy_priv(wiphy);
 	return &local->hw;
-- 
2.20.1

