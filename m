Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15B0FE0D1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 16:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKOPFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 10:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfKOPFy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 10:05:54 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CBB720732;
        Fri, 15 Nov 2019 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573830353;
        bh=LE6GM9HQEzvPi89pmsNQanj6gvD+fHjj0YieVWvNZEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhoDzdbTz2jkol0BZS/ePqQ2AVcc6sCdU1HDFdbrDYS+OjhWPMQfJ7X6gG/+7PV12
         r3/X265ffR9kg+/BDr7DYxU8UiyWSqmmGHzIcsVyJersWjJ2UIcbRRJbG+SHi/pp0/
         MZJPh9Tf1e0h/xeNmAyHbZif8+jBPcMrP8n/k2EI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 1/3] mt76: mt76x02: fix coverage_class type
Date:   Fri, 15 Nov 2019 17:05:24 +0200
Message-Id: <eefff3bdc564c6cf57fcdaa14e887838aff192cc.1573828743.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1573828743.git.lorenzo@kernel.org>
References: <cover.1573828743.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix coverage_class definition in mt76x02_dev data structure since
coverage_class can be negative to enable dynack (just supported by
ath9k)

Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 0ca0bbfe8769..cdc1cbd1d392 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -110,7 +110,7 @@ struct mt76x02_dev {
 
 	bool no_2ghz;
 
-	u8 coverage_class;
+	s16 coverage_class;
 	u8 slottime;
 
 	struct mt76x02_dfs_pattern_detector dfs_pd;
-- 
2.21.0

