Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3124D33F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgHUKw6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 06:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgHUKwg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 06:52:36 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2504020656;
        Fri, 21 Aug 2020 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598007144;
        bh=lg8+n+C0pHQLdt8FjDS8pFJ1hAn7mZtkxBEH4wzhlIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nWgc2nAj8niRbTPvY0BBP/KTRsH1IhqnCTHFMtYfoTNnloO5lhrdVHNkZEhlPJC6g
         +WIJ2BmEv0v3QinJ1Fxq49n4JK05fiwhFiD1dlFg5lDUS40XqUDQmNiJV/3QN8+1WL
         3A8/yHMlwkRgr/5nOiuTsk4SO0UXpD0g2c9egfcw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix a possible NULL pointer dereference in mt76_testmode_dump
Date:   Fri, 21 Aug 2020 12:52:15 +0200
Message-Id: <f416b042ccb8adfa1873fd5968dd3c01231c400c.1598007098.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible NULL pointer dereference in mt76_testmode_dump() since
nla_nest_start returns NULL in case of error

Fixes: f0efa8621550e ("mt76: add API for testmode support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 75bb02cdfdae..5bd6ac1ba3b5 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -442,9 +442,13 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 	mutex_lock(&dev->mutex);
 
 	if (tb[MT76_TM_ATTR_STATS]) {
+		err = -EINVAL;
+
 		a = nla_nest_start(msg, MT76_TM_ATTR_STATS);
-		err = mt76_testmode_dump_stats(dev, msg);
-		nla_nest_end(msg, a);
+		if (a) {
+			err = mt76_testmode_dump_stats(dev, msg);
+			nla_nest_end(msg, a);
+		}
 
 		goto out;
 	}
-- 
2.26.2

