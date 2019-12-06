Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B368114C27
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 06:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLFFqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 00:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfLFFqr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:47 -0500
Received: from localhost.localdomain (unknown [37.26.146.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C0E2245C;
        Fri,  6 Dec 2019 05:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575611206;
        bh=O69Fxb/T1nD5MHaIqAu7eFbU05WFEHFnEb33Wkauyl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5KdrGeoaD4bC9hUt93N43wuvdfLZUXO8vDzmJiMrgIk63KfFNJXw1+nKXPtarvXD
         2UbJAE5Ckli0KfjrmBl7qIhPdAYUsUtvczC+OmJ7gBC9ELjKRSnJ4uHxz+bg31EF1P
         0iUCeLaFJd15695B1hPBwlY92AFjmC/KkJAbsKE4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v3 2/3] mt76: mt7603: set 0 as min coverage_class value
Date:   Fri,  6 Dec 2019 07:46:24 +0200
Message-Id: <05b58f0ab71a285ea628791bec8d0e3f59e58a4f.1575609821.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1575609821.git.lorenzo@kernel.org>
References: <cover.1575609821.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set 0 as minimum configurable value for coverage_class since mt76 does
not support dynack

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 6da7caaaade1..5b2f354ba845 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -642,7 +642,7 @@ mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
 	struct mt7603_dev *dev = hw->priv;
 
-	dev->coverage_class = coverage_class;
+	dev->coverage_class = max_t(s16, coverage_class, 0);
 	mt7603_mac_set_timing(dev);
 }
 
-- 
2.21.0

